#!/usr/bin/env python3
"""
bake_geometry.py -- 3D geometry -> mipmapped wavetable bank for terrain-synth.

Self-contained (numpy only). Functions are copied from the research prototype
`mesh_slice_wavetable.py` and adapted to the locked bake contract:

  * buffer layout identical to ji-harmonizer banks:
        idx = mip * (256 * 2048) + frame * 2048 + sample
    11 mip levels, base freqs 20 * 2^k Hz. A harmonic h survives level k when
        base_k * 2 * h <= 0.9 * 24000   ->   h_max(k) = floor(10800 / base_k)
    = 540, 270, 135, 67, 33, 16, 8, 4, 2, 1, 0 (level 10 is silence, verbatim
    ji-harmonizer / VST behaviour). Levels are made by FFT truncation of the
    level-0 frame.
  * per-frame DC removal, FFT cross-correlation + polarity alignment chained
    frame-to-frame, ONE global peak normalisation across all frames and levels.
  * float32 mono IEEE WAV (48 kHz header) written into generated/.

Bank 00 (default): torus SDF sampled along a (2,3) torus-knot orbit, orbit
scale swept 0.3 -> 1.6 across 256 frames, tanh(3 f) shaping.

Geometry note (found while writing the sanity report): a torus is symmetric
about its axis, so along a centred (p, q) knot the SDF only sees the meridian
motion (rho = R + r cos(q t), z = r sin(q t)) and the sampled field has exact
period 2 pi / q. Baked over a full 2 pi the frame is a pure harmonic-q series
(frame 0 = "sine" at 3x pitch). The bake therefore samples ONE field period
per cycle (`fold = q`) so harmonic 1 is the fundamental. A second degeneracy:
at scale 1.0 the orbit sits at constant distance from the tube centre and the
frame is silent after DC removal; an axial orbit offset (`--zoff`) removes it.
`--tilt` rotates the torus against the orbit plane (breaks the symmetry; use
with `--fold 1`) for later, rougher banks.

Usage:
    python3 tools/bake_geometry.py                 # bank00-torus-sdf.wav
    python3 tools/bake_geometry.py --frames 256 --scale 0.3 1.6 --zoff 0.25
    python3 tools/bake_geometry.py --self-test     # mesh path smoke test
"""
from __future__ import annotations

import argparse
import math
import struct
import sys
import time
from pathlib import Path

import numpy as np

# ----------------------------------------------------------------------------
# Bank layout (locked contract, identical to ji-harmonizer render_wavetables.py)
# ----------------------------------------------------------------------------
N = 2048                     # samples per frame
NUM_FRAMES = 256
NUM_MIPMAPS = 11
ASSUMED_SAMPLE_RATE = 48000.0
NYQUIST = ASSUMED_SAMPLE_RATE / 2.0
MIPMAP_BASE_FREQS = [20.0 * 2 ** k for k in range(NUM_MIPMAPS)]
FRAME_STRIDE = N
MIP_STRIDE = NUM_FRAMES * N  # 524288

HERE = Path(__file__).resolve().parent
PROJECT = HERE.parent
GENERATED = PROJECT / "generated"
TEST_RESULTS = PROJECT / "test-results"


def h_max(level: int) -> int:
    """Highest harmonic kept at a mip level (partial aliases when base*2*h > 0.9*Nyquist)."""
    return int(math.floor(0.9 * NYQUIST / (MIPMAP_BASE_FREQS[level] * 2.0) + 1e-9))


# ----------------------------------------------------------------------------
# Volume fields + orbits (prototype section 5, "volume variant")
# ----------------------------------------------------------------------------
def torus_sdf(p: np.ndarray, R: float = 1.0, r: float = 0.4) -> np.ndarray:
    q = np.stack([np.hypot(p[..., 0], p[..., 1]) - R, p[..., 2]], -1)
    return np.linalg.norm(q, axis=-1) - r


def torus_knot(n: int, p: int = 2, q: int = 3, R: float = 1.0, r: float = 0.5,
               phase: float = 0.0, fold: int = 1) -> np.ndarray:
    """(p, q) torus knot, n points. `fold` samples 1/fold of the parameter range
    (use fold=q when the field is symmetric about the torus axis)."""
    t = np.linspace(0, 2 * np.pi / fold, n, endpoint=False) + phase
    x = (R + r * np.cos(q * t)) * np.cos(p * t)
    y = (R + r * np.cos(q * t)) * np.sin(p * t)
    z = r * np.sin(q * t)
    return np.stack([x, y, z], -1)


def rot_x(a: float) -> np.ndarray:
    c, s = math.cos(a), math.sin(a)
    return np.array([[1.0, 0.0, 0.0], [0.0, c, -s], [0.0, s, c]])


# --- 3D value noise (fBm) for later noise-volume banks ------------------------
_rng = np.random.default_rng(1234)
_perm = _rng.permutation(256)
_perm = np.concatenate([_perm, _perm])


def _hash3(ix, iy, iz):
    return _perm[(_perm[(_perm[ix & 255] + (iy & 255)) & 255] + (iz & 255)) & 255] / 255.0 * 2 - 1


def value_noise3(p: np.ndarray) -> np.ndarray:
    p = np.asarray(p, dtype=np.float64)
    i = np.floor(p).astype(np.int64)
    f = p - i
    f = f * f * (3 - 2 * f)
    out = 0.0
    for dz in (0, 1):
        for dy in (0, 1):
            for dx in (0, 1):
                w = ((f[..., 0] if dx else 1 - f[..., 0]) * (f[..., 1] if dy else 1 - f[..., 1])
                     * (f[..., 2] if dz else 1 - f[..., 2]))
                out = out + w * _hash3(i[..., 0] + dx, i[..., 1] + dy, i[..., 2] + dz)
    return out


def fbm3(p: np.ndarray, octaves: int = 4, lac: float = 2.0, gain: float = 0.5) -> np.ndarray:
    a, s, tot = 1.0, 0.0, 0.0
    p = np.asarray(p, dtype=np.float64)
    for _ in range(octaves):
        s = s + a * value_noise3(p)
        tot += a
        p = p * lac + 17.3
        a *= gain
    return s / tot


# ----------------------------------------------------------------------------
# Alignment / conditioning (prototype section 4, adapted to the contract)
# ----------------------------------------------------------------------------
def remove_dc(w: np.ndarray) -> np.ndarray:
    return w - w.mean()


def align_xcorr(prev: np.ndarray, cur: np.ndarray) -> tuple[np.ndarray, int, float]:
    """Circular shift (and polarity) of `cur` maximising correlation with `prev`."""
    X = np.fft.rfft(cur)
    Y = np.fft.rfft(prev)
    corr = np.fft.irfft(np.conj(X) * Y, n=len(cur))
    k = int(np.argmax(np.abs(corr)))
    sgn = 1.0 if corr[k] >= 0 else -1.0
    return sgn * np.roll(cur, k), k, sgn


def rms_diff(A: np.ndarray) -> tuple[float, float]:
    d = np.sqrt(np.mean(np.diff(A, axis=0) ** 2, axis=1))
    return float(d.mean()), float(d.max())


def spectrum(w: np.ndarray) -> np.ndarray:
    S = np.abs(np.fft.rfft(w)) / (len(w) / 2)
    S[0] = 0.0
    return S


def harmonics_above(w: np.ndarray, db: float = -60.0) -> int:
    S = spectrum(w)
    ref = S.max()
    return int(np.max(np.nonzero(S > ref * 10 ** (db / 20))[0])) if ref > 0 else 0


# ----------------------------------------------------------------------------
# Mesh path (prototype sections 1-3, kept for later banks; smoke-tested only)
# ----------------------------------------------------------------------------
def grid_to_tris(nu: int, nv: int, wrap_u: bool = True, wrap_v: bool = True) -> np.ndarray:
    tris = []
    for i in range(nu if wrap_u else nu - 1):
        i2 = (i + 1) % nu
        for j in range(nv if wrap_v else nv - 1):
            j2 = (j + 1) % nv
            a, b, c, d = i * nv + j, i2 * nv + j, i2 * nv + j2, i * nv + j2
            tris.append((a, b, c))
            tris.append((a, c, d))
    return np.asarray(tris, dtype=np.int64)


def mesh_torus(nu: int = 96, nv: int = 48, R: float = 1.0, r: float = 0.4):
    th = np.linspace(0, 2 * np.pi, nu, endpoint=False)
    ph = np.linspace(0, 2 * np.pi, nv, endpoint=False)
    T, P = np.meshgrid(th, ph, indexing="ij")
    V = np.stack([(R + r * np.cos(P)) * np.cos(T), (R + r * np.cos(P)) * np.sin(T), r * np.sin(P)], -1)
    return V.reshape(-1, 3), grid_to_tris(nu, nv)


def load_obj(path: str | Path):
    V, F = [], []
    with open(path) as fh:
        for ln in fh:
            if ln.startswith("v "):
                V.append([float(t) for t in ln.split()[1:4]])
            elif ln.startswith("f "):
                idx = [int(t.split("/")[0]) - 1 for t in ln.split()[1:]]
                for k in range(1, len(idx) - 1):
                    F.append((idx[0], idx[k], idx[k + 1]))
    return np.asarray(V, float), np.asarray(F, np.int64)


def slice_mesh(V: np.ndarray, T: np.ndarray, h: float, eps: float = 1e-9) -> list[np.ndarray]:
    """Plane z = h through a triangle mesh -> list of closed 2D loops (last != first)."""
    z = V[:, 2] - h
    z = np.where(np.abs(z) < eps, eps, z)
    tz = z[T]
    s = np.sign(tz)
    cross = ~((s[:, 0] == s[:, 1]) & (s[:, 1] == s[:, 2]))
    tri = T[cross]
    tzc = tz[cross]
    if len(tri) == 0:
        return []
    segs = np.empty((len(tri), 2, 2))
    keys = np.empty((len(tri), 2, 2), dtype=np.int64)
    fill = np.zeros(len(tri), dtype=np.int64)
    for a, b in ((0, 1), (1, 2), (2, 0)):
        za, zb = tzc[:, a], tzc[:, b]
        m = (za * zb) < 0
        t = za[m] / (za[m] - zb[m])
        pa, pb = V[tri[m, a]], V[tri[m, b]]
        P = pa + (pb - pa) * t[:, None]
        rows = np.nonzero(m)[0]
        col = fill[rows]
        segs[rows, col] = P[:, :2]
        ia, ib = tri[m, a], tri[m, b]
        keys[rows, col] = np.stack([np.minimum(ia, ib), np.maximum(ia, ib)], -1)
        fill[rows] += 1
    assert np.all(fill == 2)
    kflat = keys.reshape(-1, 2)
    uniq, inv = np.unique(kflat, axis=0, return_inverse=True)
    inv = inv.reshape(-1, 2)
    nseg, nnode = len(inv), len(uniq)
    adj = [[] for _ in range(nnode)]
    for si, (a, b) in enumerate(inv):
        adj[a].append(si)
        adj[b].append(si)
    used = np.zeros(nseg, bool)
    loops = []
    flat_segs = segs.reshape(-1, 2)
    flat_inv = inv.reshape(-1)
    for s0 in range(nseg):
        if used[s0]:
            continue
        loop_nodes = []
        si = s0
        node = inv[si, 0]
        start = node
        while True:
            used[si] = True
            loop_nodes.append(node)
            node = inv[si, 1] if inv[si, 0] == node else inv[si, 0]
            if node == start:
                break
            nxt = [x for x in adj[node] if not used[x]]
            if not nxt:
                break
            si = nxt[0]
        pts = np.array([flat_segs[np.argmax(flat_inv == n)] for n in loop_nodes])
        if len(pts) >= 3:
            loops.append(pts)
    return loops


def loop_area(P: np.ndarray) -> float:
    x, y = P[:, 0], P[:, 1]
    return float(0.5 * np.sum(x * np.roll(y, -1) - np.roll(x, -1) * y))


def orient_ccw(P: np.ndarray) -> np.ndarray:
    return P if loop_area(P) > 0 else P[::-1].copy()


def centroid_area(P: np.ndarray) -> np.ndarray:
    x, y = P[:, 0], P[:, 1]
    x1, y1 = np.roll(x, -1), np.roll(y, -1)
    c = x * y1 - x1 * y
    A = 0.5 * c.sum()
    if abs(A) < 1e-12:
        return P.mean(0)
    return np.array([((x + x1) * c).sum(), ((y + y1) * c).sum()]) / (6 * A)


def resample_arclength(P: np.ndarray, n: int = N) -> tuple[np.ndarray, float]:
    Q = np.vstack([P, P[:1]])
    seg = np.linalg.norm(np.diff(Q, axis=0), axis=1)
    s = np.concatenate([[0], np.cumsum(seg)])
    L = s[-1]
    t = np.linspace(0, L, n, endpoint=False)
    return np.stack([np.interp(t, s, Q[:, 0]), np.interp(t, s, Q[:, 1])], -1), float(L)


def unwrap_arclength(P: np.ndarray, phi: float = 0.0, n: int = N) -> np.ndarray:
    """Arc-length unwrap projected at angle phi: cos(phi) x(s) + sin(phi) y(s), centroid-relative."""
    Q, _ = resample_arclength(P, n)
    c = centroid_area(P)
    Q = Q - c
    return math.cos(phi) * Q[:, 0] + math.sin(phi) * Q[:, 1]


def pick_loop(loops: list[np.ndarray], prev_centroid: np.ndarray | None,
              hysteresis: float = 0.35) -> np.ndarray:
    """Largest-area loop with hysteresis: keep following the loop nearest the previous
    centroid unless a different loop is larger by more than `hysteresis` (fraction)."""
    areas = np.array([abs(loop_area(L)) for L in loops])
    largest = int(np.argmax(areas))
    if prev_centroid is None:
        return loops[largest]
    cents = np.array([centroid_area(L) for L in loops])
    nearest = int(np.argmin(np.linalg.norm(cents - prev_centroid, axis=1)))
    if areas[largest] > areas[nearest] * (1.0 + hysteresis):
        return loops[largest]
    return loops[nearest]


def bake_mesh(V: np.ndarray, T: np.ndarray, frames: int = NUM_FRAMES, phi: float = 0.0,
              margin: float = 0.02) -> tuple[np.ndarray, np.ndarray, dict]:
    """Plane-slice sweep along z -> (aligned frames, raw frames, stats). Slices with no
    loop produce a silent frame."""
    zmin, zmax = V[:, 2].min(), V[:, 2].max()
    hs = zmin + (zmax - zmin) * (margin + (1 - 2 * margin) * np.arange(frames) / (frames - 1))
    raw, aligned, shifts, flips = [], [], [], 0
    prev = prev_c = None
    for h in hs:
        loops = [orient_ccw(L) for L in slice_mesh(V, T, h) if abs(loop_area(L)) > 1e-9]
        if not loops:
            w = np.zeros(N)
        else:
            L = pick_loop(loops, prev_c)
            prev_c = centroid_area(L)
            w = remove_dc(unwrap_arclength(L, phi))
        raw.append(w)
        if prev is None or not np.any(w):
            prev = w
        else:
            prev, k, sgn = align_xcorr(prev, w)
            shifts.append(min(k, N - k))
            flips += sgn < 0
        aligned.append(prev)
    raw, aligned = np.asarray(raw), np.asarray(aligned)
    return aligned, raw, {"rms_raw": rms_diff(raw), "rms_xcorr": rms_diff(aligned),
                          "xcorr_shifts": shifts, "polarity_flips": int(flips)}


# ----------------------------------------------------------------------------
# Volume bake (the slice-1 path)
# ----------------------------------------------------------------------------
def bake_volume(field, frames: int = NUM_FRAMES, scale_range=(0.3, 1.6), drive: float = 3.0,
                knot=(2, 3), knot_r: float = 0.5, fold: int = 1, tilt: float = 0.0,
                zoff: float = 0.0, phase: float = 0.0):
    """Sample `field` along a torus-knot orbit whose scale sweeps across frames.
    Returns (aligned, raw, stats). Frames are DC-free, NOT yet normalised."""
    t0 = time.perf_counter()
    orb0 = torus_knot(N, knot[0], knot[1], 1.0, knot_r, phase, fold)
    Rt = rot_x(tilt)
    raw, aligned, shifts, flips, frame_peaks = [], [], [], 0, []
    prev = None
    for k in range(frames):
        s = scale_range[0] + (scale_range[1] - scale_range[0]) * k / (frames - 1)
        orb = orb0 * s + np.array([0.0, 0.0, zoff])
        f = field(orb @ Rt.T)
        if drive > 0:
            f = np.tanh(drive * f)
        w = remove_dc(f)
        frame_peaks.append(float(np.max(np.abs(w))))
        raw.append(w)
        if prev is None:
            prev = w
        else:
            prev, kk, sgn = align_xcorr(prev, w)
            shifts.append(min(kk, N - kk))
            flips += sgn < 0
        aligned.append(prev)
    raw, aligned = np.asarray(raw), np.asarray(aligned)
    stats = {"time_s": time.perf_counter() - t0, "rms_raw": rms_diff(raw), "rms_xcorr": rms_diff(aligned),
             "xcorr_shifts": shifts, "polarity_flips": int(flips), "frame_peaks": np.asarray(frame_peaks)}
    return aligned, raw, stats


# ----------------------------------------------------------------------------
# Mips + export
# ----------------------------------------------------------------------------
def build_mips(frames: np.ndarray) -> np.ndarray:
    """(frames, N) level-0 table -> (NUM_MIPMAPS, frames, N) via FFT truncation."""
    spec = np.fft.rfft(frames, axis=1)
    out = np.zeros((NUM_MIPMAPS, frames.shape[0], N), dtype=np.float64)
    for lvl in range(NUM_MIPMAPS):
        hm = h_max(lvl)
        if hm <= 0:
            continue
        S = spec.copy()
        S[:, hm + 1:] = 0.0
        S[:, 0] = 0.0
        out[lvl] = np.fft.irfft(S, n=N, axis=1)
    return out


def normalise_global(table: np.ndarray) -> tuple[np.ndarray, tuple[int, int]]:
    """One global peak normalisation across ALL levels and frames -> peak exactly 1.0."""
    idx = np.unravel_index(int(np.argmax(np.abs(table))), table.shape)
    peak = float(abs(table[idx]))
    if peak > 0:
        table = table / peak
    return table, (int(idx[0]), int(idx[1]))


def write_float32_wav(path: Path, data: np.ndarray, sample_rate: int = 48000) -> None:
    """Mono float32 WAV (format 3, IEEE float) with fact chunk, no scipy."""
    payload = np.ascontiguousarray(data, dtype="<f4").tobytes()
    n = len(payload)
    header = b"RIFF" + struct.pack("<I", 4 + 26 + 12 + 8 + n) + b"WAVE"
    fmt = struct.pack("<HHIIHHH", 3, 1, sample_rate, sample_rate * 4, 4, 32, 0)
    fact = struct.pack("<I", data.size)
    with open(path, "wb") as f:
        f.write(header)
        f.write(b"fmt " + struct.pack("<I", len(fmt)) + fmt)
        f.write(b"fact" + struct.pack("<I", len(fact)) + fact)
        f.write(b"data" + struct.pack("<I", n) + payload)


def read_float32_wav(path: Path) -> np.ndarray:
    """Minimal reader for the writer above (verification only)."""
    b = path.read_bytes()
    assert b[:4] == b"RIFF" and b[8:12] == b"WAVE"
    pos = 12
    while pos < len(b):
        cid, size = b[pos:pos + 4], struct.unpack("<I", b[pos + 4:pos + 8])[0]
        if cid == b"data":
            return np.frombuffer(b[pos + 8:pos + 8 + size], dtype="<f4")
        pos += 8 + size
    raise ValueError("no data chunk")


# ----------------------------------------------------------------------------
# Sanity report
# ----------------------------------------------------------------------------
def census_line(w: np.ndarray, label: str) -> list[str]:
    S = spectrum(w)
    ref = S[1:].max()
    top = np.argsort(S)[::-1][:6]
    rel = [f"h{int(h)}:{20 * math.log10(max(S[h] / ref, 1e-12)):+.1f}dB" for h in top]
    h1 = 20 * math.log10(max(S[1] / ref, 1e-12))
    other = float(np.sqrt(np.sum(S[2:] ** 2)) / max(S[1], 1e-12))
    return [f"  {label}: top {' '.join(rel)} | h1 {h1:+.1f} dB re strongest | "
            f"THD(h2+) {20 * math.log10(max(other, 1e-12)):+.1f} dB | "
            f"harmonics >-60dB: {harmonics_above(w)} | crest {20 * math.log10(np.max(np.abs(w)) / (np.sqrt(np.mean(w ** 2)) + 1e-12)):.1f} dB"]


def sanity_report(table: np.ndarray, stats: dict, params: dict, wav_path: Path) -> tuple[list[str], bool]:
    frames = table.shape[1]
    ok = True
    L = [f"bake_geometry sanity report -- {wav_path.name}",
         f"  params: {params}",
         f"  layout: {NUM_MIPMAPS} mips x {frames} frames x {N} samples = {table.size} float32 "
         f"({table.size * 4 / 1e6:.1f} MB); idx = mip*{MIP_STRIDE} + frame*{N} + sample",
         f"  bake time: {stats['time_s'] * 1000:.0f} ms"]

    # frame coherence
    rr, rx = stats["rms_raw"], stats["rms_xcorr"]
    sh = stats["xcorr_shifts"]
    L.append(f"  adjacent-frame RMS diff (pre-normalisation): raw mean/max {rr[0]:.4f}/{rr[1]:.4f}  "
             f"xcorr mean/max {rx[0]:.4f}/{rx[1]:.4f}  -> {'PASS' if rx[0] <= rr[0] + 1e-12 else 'FAIL'} (xcorr <= raw)")
    ok &= rx[0] <= rr[0] + 1e-12
    if sh:
        L.append(f"  xcorr shifts (samples): mean {np.mean(sh):.1f} max {max(sh)}  polarity flips: {stats['polarity_flips']}")

    # dead zones / amplitude sweep
    fp = stats["frame_peaks"]
    lvl0 = table[0]
    frms = np.sqrt(np.mean(lvl0 ** 2, axis=1))
    qmin = int(np.argmin(frms))
    L.append(f"  raw frame peak range before global norm: min {fp.min():.4f} (frame {int(np.argmin(fp))}) "
             f"max {fp.max():.4f} (frame {int(np.argmax(fp))})")
    L.append(f"  level-0 frame RMS after norm: min {frms.min():.4f} (frame {qmin}) median {np.median(frms):.4f} "
             f"max {frms.max():.4f}  -> {'PASS' if frms.min() > 0.05 * np.median(frms) else 'WARN dead zone'}")

    # harmonic census on level 0
    L.append("  harmonic census (level 0):")
    for fi in (0, frames // 2, frames - 1):
        L += census_line(lvl0[fi], f"frame {fi:3d}")
    S0 = spectrum(lvl0[0])
    sine_like = S0[1] == S0[1:].max()
    L.append(f"  frame 0 fundamental is the strongest partial: {'PASS' if sine_like else 'FAIL'}")
    ok &= bool(sine_like)

    # mip truncation check
    L.append("  mip levels (max non-zero harmonic vs h_max, peak):")
    for lvl in range(NUM_MIPMAPS):
        Sm = np.abs(np.fft.rfft(table[lvl], axis=1)).max(axis=0)
        nz = np.nonzero(Sm > 1e-9)[0]
        top = int(nz.max()) if len(nz) else 0
        pk = float(np.max(np.abs(table[lvl])))
        good = top <= h_max(lvl) and (lvl < 10 or pk == 0.0)
        ok &= good
        L.append(f"    mip {lvl:2d} base {MIPMAP_BASE_FREQS[lvl]:7.1f} Hz  h_max {h_max(lvl):3d}  "
                 f"highest {top:3d}  peak {pk:.4f}  {'ok' if good else 'FAIL'}")
    silent = float(np.max(np.abs(table[10]))) == 0.0
    L.append(f"  level 10 silence: {'PASS' if silent else 'FAIL'}")
    ok &= silent

    peak = float(np.max(np.abs(table)))
    L.append(f"  global peak: {peak:.6f} at mip {stats['peak_at'][0]} frame {stats['peak_at'][1]}  "
             f"-> {'PASS' if abs(peak - 1.0) < 1e-6 else 'FAIL'}")
    ok &= abs(peak - 1.0) < 1e-6

    # DC per frame
    dc = float(np.max(np.abs(lvl0.mean(axis=1))))
    L.append(f"  max |DC| per frame (level 0): {dc:.2e} -> {'PASS' if dc < 1e-6 else 'FAIL'}")
    ok &= dc < 1e-6

    # file round-trip
    back = read_float32_wav(wav_path)
    rt = back.size == table.size and np.array_equal(back, table.astype(np.float32).reshape(-1))
    L.append(f"  WAV round-trip ({wav_path.stat().st_size / 1e6:.1f} MB on disk): {'PASS' if rt else 'FAIL'}")
    ok &= bool(rt)
    L.append(f"  RESULT: {'ALL PASS' if ok else 'CHECK FAILURES ABOVE'}")
    return L, ok


# ----------------------------------------------------------------------------
def self_test() -> None:
    """Mesh path smoke test on a procedural torus (no bank written)."""
    V, T = mesh_torus()
    aligned, raw, st = bake_mesh(V, T, frames=32, phi=0.0)
    print(f"mesh self-test: torus {len(T)} tris, 32 frames, rms raw {st['rms_raw'][0]:.3f} "
          f"xcorr {st['rms_xcorr'][0]:.3f}, flips {st['polarity_flips']}, "
          f"nonzero frames {int(np.sum(np.any(raw != 0, axis=1)))}/32")


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--out", default=str(GENERATED / "bank00-torus-sdf.wav"))
    ap.add_argument("--report", default=None, help="report path (default test-results/bake-<bank>.txt)")
    ap.add_argument("--frames", type=int, default=NUM_FRAMES)
    ap.add_argument("--scale", type=float, nargs=2, default=(0.3, 1.6), metavar=("LO", "HI"))
    ap.add_argument("--drive", type=float, default=3.0, help="tanh(drive * sdf) shaping; 0 = off")
    ap.add_argument("--torus", type=float, nargs=2, default=(1.0, 0.4), metavar=("R", "r"))
    ap.add_argument("--knot", type=int, nargs=2, default=(2, 3), metavar=("p", "q"))
    ap.add_argument("--knot-r", type=float, default=0.5)
    ap.add_argument("--fold", type=int, default=None,
                    help="sample 1/fold of the orbit per cycle (default q when tilt == 0, else 1)")
    ap.add_argument("--tilt", type=float, default=0.0, help="torus tilt about x (radians)")
    ap.add_argument("--zoff", type=float, default=0.25, help="orbit offset along the torus axis")
    ap.add_argument("--phase", type=float, default=0.0)
    ap.add_argument("--self-test", action="store_true")
    a = ap.parse_args(argv)

    if a.self_test:
        self_test()
        return 0
    if a.frames != NUM_FRAMES:
        print(f"WARNING: {a.frames} frames does not match the ji-harmonizer layout ({NUM_FRAMES}); "
              f"the oscillator assumes {NUM_FRAMES}.", file=sys.stderr)

    fold = a.fold if a.fold is not None else (a.knot[1] if a.tilt == 0.0 else 1)
    params = {"torus": tuple(a.torus), "knot": tuple(a.knot), "knot_r": a.knot_r, "fold": fold,
              "tilt": a.tilt, "zoff": a.zoff, "phase": a.phase, "scale": tuple(a.scale), "drive": a.drive}
    field = lambda p: torus_sdf(p, a.torus[0], a.torus[1])
    aligned, raw, stats = bake_volume(field, a.frames, tuple(a.scale), a.drive, tuple(a.knot), a.knot_r,
                                      fold, a.tilt, a.zoff, a.phase)
    table = build_mips(aligned)
    table, stats["peak_at"] = normalise_global(table)

    out = Path(a.out)
    out.parent.mkdir(parents=True, exist_ok=True)
    write_float32_wav(out, table.reshape(-1))

    lines, ok = sanity_report(table, stats, params, out)
    report = Path(a.report) if a.report else TEST_RESULTS / f"bake-{out.stem}.txt"
    report.parent.mkdir(parents=True, exist_ok=True)
    report.write_text("\n".join(lines) + "\n")
    print("\n".join(lines))
    print(f"wrote {out}\nreport {report}")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
