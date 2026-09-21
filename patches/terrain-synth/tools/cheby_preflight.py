"""Pre-flight for the terrain-cheby codebox (terrain-synth v0.12.0).

Numpy model of the Chebyshev bandlimited terrain core:
    v(t) = sum_{m,n < 8} c[m][n] * w(m + n, f) * T_m(xs) * T_n(ys)
with xs / ys the terrain-osc orbit (0-1 -> -1..1) and w the pitch-scaled order limiter
    w(d, f) = clamp((1 - d * fh / fmax) * 10, 0, 1),  fmax = min(0.45 * sr, 21600),
    fh = f (ellipse / squarcle) or f * lobes (epitrochoid).

Two implementations are cross-checked: `render_literal` is a per-sample transliteration of the
codebox (two flat constant-bound loops, Data arrays, History cursor amortisation + coefficient
smoothing); `render_fast` is the vectorised steady state used for the sweeps.

Aliasing metric: f is snapped to an FFT bin k * sr / N with k odd and N = 2^16, so every true
harmonic lands on a multiple of k and every folded component lands elsewhere. "alias dB" =
10 log10(non-harmonic energy / total AC energy).

Baseline: the existing TERRAIN core reading the same polynomial from a 256 x 256 bilinear table
(what slot A / B do today), same orbit, no tanh.

Run: python3 patches/terrain-synth/tools/cheby_preflight.py  (writes test-results/cheby-preflight.md)
This is an analysis tool only -- it never writes a .maxpat.
"""
from pathlib import Path
import numpy as np

N_ORD = 8
NFFT = 1 << 16

# (m = x order, n = y order, coefficient). Keep in sync with generated/cheby-coefs.js.
PRESETS = {
    "saw": [(m, 0, 1.0 / m) for m in range(1, 8)],
    "square": [(1, 0, 1.0), (3, 0, 1 / 3), (5, 0, 1 / 5), (7, 0, 1 / 7)],
    "hollow xy": [(1, 0, 1.0), (0, 3, 0.5), (5, 0, 0.33), (0, 7, 0.25), (2, 1, 0.3)],
    "cross": [(1, 1, 1.0), (2, 1, 0.6), (1, 3, 0.5), (3, 2, 0.4), (2, 5, 0.3), (4, 3, 0.25)],
    "glass": [(1, 0, 1.0), (2, 2, 0.5), (3, 3, 0.4), (5, 5, 0.3), (7, 7, 0.25)],
    "bell": [(1, 0, 0.6), (3, 4, 1.0), (4, 3, 0.8), (7, 2, 0.5), (6, 7, 0.4), (7, 7, 0.3)],
}


def coef_table(name, bright=1.0):
    """Flat 64-entry table, idx = m * 8 + n, brightness b^(d - dmin), normalised sum|c| = 1."""
    terms = PRESETS[name]
    dmin = min(m + n for m, n, _ in terms)
    c = np.zeros(N_ORD * N_ORD)
    for m, n, a in terms:
        c[m * N_ORD + n] = a * bright ** (m + n - dmin)
    return c / np.sum(np.abs(c))


def orbit(ph, shape=0, rx=0.5, ry=0.5, rot=0.0, cx=0.5, cy=0.5, lobes=3.0, lobeamt=0.4, zoom=1.0):
    """terrain-osc v0.4 orbit (fb = 0, no mod inputs). ph = wrapped phase 0-1. Returns x, y in 0-1."""
    th = ph * 2 * np.pi
    ux, uy = np.cos(th), np.sin(th)
    if shape == 1:
        ux = (np.cos(th) + lobeamt * np.cos(lobes * th)) / (1 + lobeamt)
        uy = (np.sin(th) + lobeamt * np.sin(lobes * th)) / (1 + lobeamt)
    if shape == 2:
        ux = np.sign(np.cos(th)) * np.abs(np.cos(th)) ** 0.5
        uy = np.sign(np.sin(th)) * np.abs(np.sin(th)) ** 0.5
    rc, rs = np.cos(rot * 2 * np.pi), np.sin(rot * 2 * np.pi)
    x = np.clip(cx + rx * zoom * (ux * rc - uy * rs), 0, 1)
    y = np.clip(cy + ry * zoom * (ux * rs + uy * rc), 0, 1)
    return x, y


def order_weights(f, sr, shape=0, lobes=3.0):
    fh = f * lobes if shape == 1 else f
    fmax = min(0.45 * sr, 21600.0)
    d = np.arange(16)
    return np.clip((1 - d * fh / fmax) * 10, 0, 1)


def render_fast(c, f, sr, n, **orb):
    ph = np.mod(np.arange(1, n + 1) * f / sr, 1.0)
    x, y = orbit(ph, **orb)
    xs, ys = x * 2 - 1, y * 2 - 1
    w = order_weights(f, sr, orb.get("shape", 0), orb.get("lobes", 3.0))
    tx = np.empty((N_ORD, n)); ty = np.empty((N_ORD, n))
    tx[0] = 1; tx[1] = xs; ty[0] = 1; ty[1] = ys
    for i in range(2, N_ORD):
        tx[i] = 2 * xs * tx[i - 1] - tx[i - 2]
        ty[i] = 2 * ys * ty[i - 1] - ty[i - 2]
    v = np.zeros(n)
    for k in range(N_ORD * N_ORD):
        m, nn = divmod(k, N_ORD)
        if c[k] != 0 and w[m + nn] > 0:
            v += c[k] * w[m + nn] * tx[m] * ty[nn]
    return v


def render_literal(c, f_of_n, sr, n, off=0, **orb):
    """Per-sample transliteration of the codebox (loops, Data, cursor, smoothing)."""
    coefbuf = np.zeros(128); coefbuf[off:off + 64] = c
    tx = np.zeros(8); ty = np.zeros(8); wd = np.zeros(16); cs = np.zeros(64); ce = np.zeros(64)
    shape, lobes = orb.get("shape", 0), orb.get("lobes", 3.0)
    lim = min(0.45 * sr, 21600.0)
    cur = 0; phb = 0.0
    out = np.zeros(n)
    for s in range(n):
        f = f_of_n(s)
        phb = (phb + f / sr) % 1.0
        x, y = orbit(np.array([phb]), **orb)
        xs = min(max(x[0] * 2 - 1, -1), 1); ys = min(max(y[0] * 2 - 1, -1), 1)
        fh = f * lobes if 0.5 < shape < 1.5 else f
        t0x, t1x, t0y, t1y = 1.0, xs, 1.0, ys
        tx[0] = 1; tx[1] = xs; ty[0] = 1; ty[1] = ys
        for i in range(16):                                   # loop 1
            wd[i] = min(max((1 - i * fh / lim) * 10, 0), 1)
            if 1.5 < i < 7.5:
                t2x = 2 * xs * t1x - t0x; t2y = 2 * ys * t1y - t0y
                tx[i] = t2x; ty[i] = t2y
                t0x, t1x, t0y, t1y = t1x, t2x, t1y, t2y
        cm = np.floor(cur * 0.125); cn = cur - cm * 8           # amortised cursor: one entry / sample
        csm = cs[cur] + 0.06 * (coefbuf[off + cur] - cs[cur])
        cs[cur] = csm
        ce[cur] = csm * wd[int(cm + cn)]
        cur = (cur + 1) % 64
        acc = 0.0; m = 0; nn = 0
        for i in range(64):                                   # loop 2
            acc = acc + ce[i] * tx[m] * ty[nn]
            nn += 1
            if nn > 7.5:
                nn = 0; m += 1
        out[s] = acc
    return out


def table_baseline(c, f, sr, n, **orb):
    """Existing TERRAIN core: 256 x 256 bilinear read of the same polynomial (no order limiting)."""
    g = np.linspace(-1, 1, 256)
    T = [np.ones(256), g]
    for i in range(2, N_ORD):
        T.append(2 * g * T[-1] - T[-2])
    T = np.array(T)
    tab = np.zeros((256, 256))
    for k in range(64):
        m, nn = divmod(k, N_ORD)
        if c[k] != 0:
            tab += c[k] * np.outer(T[nn], T[m])           # rows = y, cols = x
    ph = np.mod(np.arange(1, n + 1) * f / sr, 1.0)
    x, y = orbit(ph, **orb)
    px, py = x * 255, y * 255
    x0 = np.floor(px).astype(int); y0 = np.floor(py).astype(int)
    x1 = np.minimum(x0 + 1, 255); y1 = np.minimum(y0 + 1, 255)
    fx, fy = px - x0, py - y0
    a = tab[y0, x0] * (1 - fx) + tab[y0, x1] * fx
    b = tab[y1, x0] * (1 - fx) + tab[y1, x1] * fx
    return a * (1 - fy) + b * fy


def snap(f, sr):
    k = int(round(f * NFFT / sr)) | 1                      # odd bin
    return k, k * sr / NFFT


def alias_db(v, k):
    X = np.abs(np.fft.rfft(v)) ** 2
    X[0] = 0
    tot = X.sum()
    if tot <= 0:
        return -np.inf, 0
    harm = X[k::k].sum()
    top = np.nonzero(X > tot * 1e-12)[0]
    return 10 * np.log10(max(tot - harm, 1e-300) / tot), (top.max() if len(top) else 0)


def sweep(lines, title, sr, presets, notes, **orb):
    lines.append(f"\n### {title} (sr = {sr})\n")
    lines.append("| preset | worst cheby alias dB (note) | worst table alias dB (note) | max top partial Hz |")
    lines.append("|---|---|---|---|")
    for name in presets:
        c = coef_table(name)
        wc, wt, top = (-999, 0), (-999, 0), 0
        for note in notes:
            k, f = snap(440 * 2 ** ((note - 69) / 12), sr)
            a, tb = alias_db(render_fast(c, f, sr, NFFT, **orb), k)
            b, _ = alias_db(table_baseline(c, f, sr, NFFT, **orb), k)
            if a > wc[0]: wc = (a, note)
            if b > wt[0]: wt = (b, note)
            top = max(top, tb * sr / NFFT)
        lines.append(f"| {name} | {wc[0]:.1f} ({wc[1]}) | {wt[0]:.1f} ({wt[1]}) | {top:.0f} |")


def main():
    L = ["# terrain-cheby pre-flight (numpy)", "",
         "Generated by `tools/cheby_preflight.py`. alias dB = non-harmonic energy / total AC energy "
         "(f snapped to an odd FFT bin, N = 65536). -150 dB or lower (or -999 = exactly zero) = double-precision floor = alias-free.",
         "Baseline 'table' = today's TERRAIN core reading the same polynomial from the 256 x 256 bilinear buffer."]
    notes = list(range(24, 121, 4))
    names = list(PRESETS)

    # 1. literal codebox vs vectorised steady state
    sr = 96000; c = coef_table("bell"); k, f = snap(1500.0, sr)
    n = 24000
    lit = render_literal(c, lambda s: f, sr, n)
    fast = render_fast(c, f, sr, n)
    err = np.max(np.abs(lit[-4096:] - fast[-4096:]))
    L += ["", "## 1. Codebox transliteration vs vectorised model", "",
          f"bell preset, {f:.1f} Hz, sr 96000, after coefficient smoothing settles: max |literal - fast| = {err:.2e}"]

    # 2. ellipse sweeps
    L += ["", "## 2. Ellipse orbit, MIDI 24-120 (every 4 semitones)"]
    sweep(L, "centred circle, full radius", 48000, names, notes)
    sweep(L, "centred circle, full radius", 96000, names, notes)
    sweep(L, "off-centre rotated ellipse (rx .35 ry .2 rot .13 cx .6 cy .45)", 48000, names, notes,
          rx=0.35, ry=0.2, rot=0.13, cx=0.6, cy=0.45)

    # 3. harmonic content vs pitch
    L += ["", "## 3. Order limiting: highest partial vs pitch (bell preset, max degree 14, sr 48000)", "",
          "| MIDI | f Hz | highest partial | Hz | max degree passed |", "|---|---|---|---|---|"]
    c = coef_table("bell")
    for note in (36, 48, 60, 72, 84, 90, 96, 102, 108, 114, 120):
        k, f = snap(440 * 2 ** ((note - 69) / 12), 48000)
        _, tb = alias_db(render_fast(c, f, 48000, NFFT), k)
        w = order_weights(f, 48000)
        L.append(f"| {note} | {f:.1f} | h{tb // k} | {tb * 48000 / NFFT:.0f} | {int(np.max(np.nonzero(w > 0)[0]))} |")

    # 4. non-ellipse shapes and clamping
    L += ["", "## 4. What breaks the guarantee (sr 48000, worst over the sweep)"]
    sweep(L, "epitrochoid, lobes = 3 (integer), limiter uses fh = f * lobes", 48000, names, notes, shape=1, lobes=3.0)
    sweep(L, "epitrochoid, lobes = 3.008 (the patch's LOBES default; dial is continuous)", 48000, names, notes,
          shape=1, lobes=3.008)
    sweep(L, "epitrochoid, lobes = 3.5 (worst case between integers)", 48000, names, notes, shape=1, lobes=3.5)
    sweep(L, "squarcle", 48000, names, notes, shape=2)
    sweep(L, "ellipse pushed into the 0-1 clamp (cx .85, rx .5)", 48000, names, notes, cx=0.85)

    # 5. glide through the limiter: literal model (64-sample cursor refresh) vs ideal per-sample weights
    sr = 96000; hold = 16000; n = hold + 9600
    f0, f1 = 1200.0, 4800.0
    c = coef_table("bell")
    fn = f0 * (f1 / f0) ** (np.maximum(np.arange(n) - hold, 0) / (n - hold))   # hold lets the coefficient smoother settle
    g = render_literal(c, lambda s: fn[s], sr, n)
    ph = np.mod(np.cumsum(fn / sr), 1.0)
    x, y = orbit(ph)
    xs, ys = x * 2 - 1, y * 2 - 1
    T = lambda u, o: np.cos(o * np.arccos(np.clip(u, -1, 1)))
    lim = min(0.45 * sr, 21600.0)
    ideal = np.zeros(n)
    for k in range(64):
        m, nn = divmod(k, N_ORD)
        if c[k] != 0:
            ideal += c[k] * np.clip((1 - (m + nn) * fn / lim) * 10, 0, 1) * T(xs, m) * T(ys, nn)
    warm = hold
    dev = np.max(np.abs(g[warm:] - ideal[warm:]))
    L += ["", "## 5. Two-octave glide in 100 ms across the limiter (bell, 1200 -> 4800 Hz, sr 96000)", "",
          f"max |literal (64-sample cursor refresh) - ideal (per-sample weights)| = {dev:.2e} "
          f"({20 * np.log10(max(dev, 1e-12)):.0f} dBFS). This is fade LAG, not a step: a weight is at most 64 samples old, "
          "in which this glide moves f by 0.93 %, so a partial the stale weight still passes sits below "
          f"{lim * 1.0093:.0f} Hz -- under Nyquist at every supported rate (22050+). Slower glides / vibrato lag proportionally less."]

    out = Path(__file__).resolve().parents[1] / "test-results" / "cheby-preflight.md"
    out.write_text("\n".join(L) + "\n")
    print("\n".join(L))


if __name__ == "__main__":
    main()
