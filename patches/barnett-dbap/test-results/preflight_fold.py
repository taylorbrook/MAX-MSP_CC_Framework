"""preflight_fold.py -- numpy pre-flight for barnett-dbap v0.8 (fold.js, context.md D36-D38).
Run: python3 patches/barnett-dbap/test-results/preflight_fold.py
The matrix under test is the one the REAL generated/fold.js emits (run under node with a stub
outlet / post / Dict), checked against an independent numpy SH implementation (Legendre
recurrence, ACN / SN3D, no Condon-Shortley phase).
"""
import json, math, os, subprocess, sys
import numpy as np

HERE = os.path.dirname(os.path.abspath(__file__))
GEN = os.path.join(HERE, "..", "generated")
fails = 0


def check(name, ok, detail=""):
    global fails
    if not ok:
        fails += 1
    print(("PASS  " if ok else "FAIL  ") + name + ("   " + detail if detail else ""))


# ---- run fold.js under node -------------------------------------------------------------
NODE_SRC = r"""
var fs = require("fs"), vm = require("vm");
var spec = JSON.parse(process.argv[2]);
var out = [], posts = [];
var ctx = {
    messagename: "",
    outlet: function () { out.push(Array.prototype.slice.call(arguments)); },
    post: function (s) { posts.push(s); },
    Dict: function () {
        if (!spec.dict) throw new Error("no dict in node");
        this.get = function (k) { return spec.dict.hasOwnProperty(k) ? spec.dict[k] : null; };
    },
    Math: Math, isFinite: isFinite
};
vm.createContext(ctx);
vm.runInContext(fs.readFileSync(process.argv[1], "utf8"), ctx);
var res = {};
ctx.loadbang(); res.load = out.slice(); out.length = 0;
ctx.flat(1); res.flat = out.slice(); out.length = 0;
ctx.flat(0); ctx.mirror(1); res.mirror = out.slice(); out.length = 0;
ctx.mirror(0); res.back = out.slice();
res.posts = posts;
console.log(JSON.stringify(res));
"""


def run_fold(spec):
    r = subprocess.run(["node", "-e", NODE_SRC, os.path.join(GEN, "fold.js"), json.dumps(spec)],
                       capture_output=True, text=True, check=True)
    return json.loads(r.stdout)


def matrix(msgs):
    m = np.full((8, 16), np.nan)
    for a in msgs:
        if a[0] == 0:
            m[int(a[1]), int(a[2])] = a[3]
    return m


def status(msgs):
    return [a for a in msgs if a[0] == 1][-1][2]


# ---- independent reference ----------------------------------------------------------------
SPK = np.array([[0.50, 4.50, 4.50], [12.50, 4.50, 4.50], [12.50, 9.85, 4.70], [12.50, 16.00, 5.10],
                [9.80, 19.50, 5.40], [3.20, 19.50, 5.40], [0.50, 16.00, 5.10], [0.50, 9.85, 4.70]])
RAKE = (1.10, 3.20)


def listener(spk, rake):
    cx, cy = spk[:, 0].mean(), spk[:, 1].mean()
    y0, y1 = spk[:, 1].min(), spk[:, 1].max()
    return np.array([cx, cy, rake[0] + (rake[1] - rake[0]) * (cy - y0) / (y1 - y0)])


def to_amb(v):
    """room vector(s) -> ambisonic axes: X front = -y, Y left = -x, Z up."""
    v = np.atleast_2d(v)
    return np.stack([-v[:, 1], -v[:, 0], v[:, 2]], axis=1)


def unit(v):
    return v / np.linalg.norm(v, axis=-1, keepdims=True)


def legendre(l, m, x):
    """Associated Legendre P_l^m(x) WITHOUT the Condon-Shortley phase (m >= 0)."""
    pmm = np.ones_like(x)
    if m > 0:
        s = np.sqrt(np.maximum(0.0, 1.0 - x * x))
        for i in range(1, m + 1):
            pmm = pmm * (2 * i - 1) * s
    if l == m:
        return pmm
    pm1 = x * (2 * m + 1) * pmm
    if l == m + 1:
        return pm1
    for ll in range(m + 2, l + 1):
        pl = ((2 * ll - 1) * x * pm1 - (ll + m - 1) * pmm) / (ll - m)
        pmm, pm1 = pm1, pl
    return pm1


def sh_sn3d(u, order=3):
    """u: (..., 3) unit vectors (amb axes). Returns (..., (order+1)^2), ACN / SN3D."""
    az = np.arctan2(u[..., 1], u[..., 0])
    sin_el = np.clip(u[..., 2], -1, 1)
    cols = []
    for l in range(order + 1):
        for m in range(-l, l + 1):
            am = abs(m)
            n = math.sqrt((2.0 if am else 1.0) * math.factorial(l - am) / math.factorial(l + am))
            p = legendre(l, am, sin_el)
            cols.append(n * p * (np.sin(am * az) if m < 0 else np.cos(am * az)))
    return np.stack(cols, axis=-1)


def azel(u):
    return np.degrees(np.arctan2(u[..., 1], u[..., 0])), np.degrees(np.arcsin(np.clip(u[..., 2], -1, 1)))


def ang(a, b):
    return np.degrees(np.arccos(np.clip(np.sum(unit(a) * unit(b), axis=-1), -1, 1)))


# decode grid: Fibonacci sphere, sampling decoder with max-rE weights (order 3)
NG = 5000
ii = np.arange(NG) + 0.5
gz = 1 - 2 * ii / NG
gphi = math.pi * (1 + 5 ** 0.5) * ii
GRID = np.stack([np.sqrt(1 - gz * gz) * np.cos(gphi), np.sqrt(1 - gz * gz) * np.sin(gphi), gz], axis=1)
YG = sh_sn3d(GRID)                                   # (NG, 16)
DEG = np.array([int(math.sqrt(n)) for n in range(16)])
N3D = (2 * DEG + 1)                                  # sampling decoder: (2l+1) * Y_sn3d
RE_ROOT = 0.861136311594053                          # largest root of P4 -> max-rE for order 3
MAXRE = np.array([legendre(l, 0, np.array(RE_ROOT)) for l in DEG])


def energy_vector(b, maxre=True):
    """b: (16,) SN3D signal set. Decode to the grid, return the energy vector (amb axes)."""
    w = N3D * (MAXRE if maxre else 1.0)
    g = YG @ (w * b)
    e = g * g
    return (e[:, None] * GRID).sum(axis=0) / e.sum()


# ---- 1. matrix from the default venue (dict absent -> built-in layout) ---------------------
res = run_fold({})
M = matrix(res["load"])
check("1a fold.js emits 128 matrix messages, all finite", len([a for a in res["load"] if a[0] == 0]) == 128
      and np.all(np.isfinite(M)))
L = listener(SPK, RAKE)
check("1b listener = rig centroid at earHeight", np.allclose(L, [6.50, 12.46, 2.21], atol=0.005),
      "(%.2f, %.2f, %.2f)" % tuple(L))
U = unit(to_amb(SPK - L))
REF = sh_sn3d(U)
err = np.max(np.abs(M - REF))
check("1c matrix == independent ACN / SN3D reference", err < 1e-12, "max abs err %.2e" % err)
az, el = azel(U)
BRIEF = [(37.0, 12.9), (-37.0, 12.9), (-66.5, 20.8), (-120.5, 22.5), (-154.9, 22.3), (154.9, 22.3),
         (120.5, 22.5), (66.5, 20.8)]
ok = all(abs(az[i] - BRIEF[i][0]) < 0.06 and abs(el[i] - BRIEF[i][1]) < 0.06 for i in range(8))
check("1d speaker directions match the brief", ok,
      "  ".join("s%d %+.1f/%.1f" % (i + 1, az[i], el[i]) for i in range(8)))
check("1e W column is 1 for every speaker (equal gain, direction only)", np.allclose(M[:, 0], 1.0))
check("1f channels 1-3 are the unit direction (Y, Z, X): valid first order",
      np.allclose(M[:, 1], U[:, 1]) and np.allclose(M[:, 2], U[:, 2]) and np.allclose(M[:, 3], U[:, 0]))
# SN3D sanity: per-degree energy of a plane wave is 1 for every degree (addition theorem)
pd = np.array([[np.sum(M[i, DEG == l] ** 2) for l in range(4)] for i in range(8)])
check("1g SN3D addition theorem: sum over each degree's squares = 1", np.allclose(pd, 1.0, atol=1e-12))
check("1h status text names the listener", "6.50, 12.46, 2.21" in status(res["load"]), status(res["load"]))

# ---- 2. unit feed on speaker N decodes to that speaker's direction --------------------------
worst = 0.0
for i in range(8):
    ev = energy_vector(M[i])
    worst = max(worst, float(ang(ev, U[i])))
check("2a unit feed on speaker N: max-rE energy vector within 1 deg", worst < 1.0, "worst %.3f deg" % worst)
worst_b = max(float(ang(energy_vector(M[i], maxre=False), U[i])) for i in range(8))
check("2b same with a basic (unweighted) decode", worst_b < 1.0, "worst %.3f deg" % worst_b)
rE = np.linalg.norm(energy_vector(M[0]))
check("2c |rE| for a single speaker ~ 0.861 (order-3 max-rE)", abs(rE - RE_ROOT) < 0.01, "%.4f" % rE)

# ---- 3. flat / mirror ---------------------------------------------------------------------
MF = matrix(res["flat"])
UF = U.copy(); UF[:, 2] = 0; UF = unit(UF)
check("3a flat 1: elevation zeroed, azimuth kept", np.max(np.abs(MF - sh_sn3d(UF))) < 1e-12)
check("3b flat 1: W unchanged (levels unchanged), Z channel 0", np.allclose(MF[:, 0], 1) and np.allclose(MF[:, 2], 0))
MM = matrix(res["mirror"])
UM = U.copy(); UM[:, 1] *= -1
check("3c mirror 1: azimuth sign flipped", np.max(np.abs(MM - sh_sn3d(UM))) < 1e-12)
check("3d flat 0 / mirror 0 restores the matrix", np.array_equal(matrix(res["back"]), M))

# ---- 4. a different venue through the Dict path --------------------------------------------
rng = np.random.default_rng(7)
V2 = SPK + rng.uniform(-1.5, 1.5, SPK.shape)
d = {"name": "test hall", "rake::front": 0.9, "rake::rear": 2.4}
for k in range(8):
    for j, ax in enumerate("xyz"):
        d["speakers::s%d::%s" % (k + 1, ax)] = float(V2[k, j])
r2 = run_fold({"dict": d})
L2 = listener(V2, (0.9, 2.4))
e2 = np.max(np.abs(matrix(r2["load"]) - sh_sn3d(unit(to_amb(V2 - L2)))))
check("4a venue dict layout: matrix follows the dict", e2 < 1e-12, "max abs err %.2e" % e2)
check("4b venue dict: status carries the venue name", "test hall" in status(r2["load"]))
d_bad = dict(d); del d_bad["speakers::s5::z"]
r3 = run_fold({"dict": d_bad})
check("4c incomplete dict falls back to the built-in layout", np.array_equal(matrix(r3["load"]), M)
      and any("using built-in" in p for p in r3["posts"]))


# ---- 5. puck sweep through dbap.js-equivalent gains ---------------------------------------
def dbap_gains(xs, ys, zs_above=0.0, rolloff=4.0, blur=0.03):
    """context.md 'DBAP math' (unit weights, no trims / hull / z-cue)."""
    c = SPK.mean(axis=0)
    rig = math.sqrt(np.mean(np.sum((SPK - c) ** 2, axis=1)))
    rs = min(blur * blur * 6 * rig, 200.0)
    y0, y1 = SPK[:, 1].min(), SPK[:, 1].max()
    zs = RAKE[0] + (RAKE[1] - RAKE[0]) * (ys - y0) / (y1 - y0) + zs_above
    dd = np.maximum(np.sqrt(np.sum((SPK - [xs, ys, zs]) ** 2, axis=1) + rs * rs), 0.05)
    t = dd ** (-(rolloff / (20 * math.log10(2))))
    return t / math.sqrt(np.sum(t * t))


g0 = dbap_gains(6.5, 12.0)
check("5a DBAP reference: sum of squares = 1", abs(np.sum(g0 ** 2) - 1) < 1e-12)

# The mix is what the hall gets: at the default rolloff (4 dB / doubling) every speaker carries
# signal wherever the puck is, so the energy vector is SHORT (a diffuse image) and is pulled toward
# the rear, where the rig has more speakers. The checks below are therefore about direction of
# travel, at the default rolloff and at 12 dB (the tightest the source allows).
def sweep_circle(rolloff):
    errs, sides, lens = [], [], []
    for th in np.arange(0, 360, 5.0):          # th = ambisonic azimuth of the puck from the listener
        px, py = L[0] - 5 * math.sin(math.radians(th)), L[1] - 5 * math.cos(math.radians(th))
        px = min(max(px, 0.5), 12.5); py = min(max(py, 4.5), 19.5)
        ev = energy_vector(dbap_gains(px, py, rolloff=rolloff) @ M)
        true_az = math.degrees(math.atan2(-(px - L[0]), -(py - L[1])))
        ev_az = math.degrees(math.atan2(ev[1], ev[0]))
        errs.append(abs((ev_az - true_az + 180) % 360 - 180))
        sides.append((true_az, ev_az)); lens.append(np.linalg.norm(ev))
    return np.array(errs), sides, np.array(lens)


for R, tol in ((4.0, 40.0), (12.0, 40.0)):
    errs, sides, lens = sweep_circle(R)
    check("5b puck on a 5 m circle, rolloff %g: image azimuth follows the puck" % R, errs.max() < tol,
          "azimuth error mean %.1f, worst %.1f deg; |rE| %.2f .. %.2f" % (errs.mean(), errs.max(), lens.min(), lens.max()))
    lr = all((t > 0) == (e > 0) for t, e in sides if 15 < abs(t) < 165)
    check("5c rolloff %g: left / right never swaps" % R, lr)

# puck straight left -> right through the listener row: +az (audience left) to -az (right)
xs = np.linspace(0.5, 12.5, 49)
for R in (4.0, 12.0):
    yv = np.array([energy_vector(dbap_gains(x, L[1], rolloff=R) @ M)[1] for x in xs])
    check("5d rolloff %g, puck left -> right: rE.y falls monotonically, + on the left, - on the right" % R,
          np.all(np.diff(yv) < 0) and yv[0] > 0.2 and yv[-1] < -0.2 and abs(yv[24]) < 0.01,
          "rE.y %+.2f at x 0.5 m, %+.2f at the centre, %+.2f at x 12.5 m" % (yv[0], yv[24], yv[-1]))
ys = np.linspace(4.5, 19.5, 61)
for R in (4.0, 12.0):
    xv = np.array([energy_vector(dbap_gains(L[0], y, rolloff=R) @ M)[0] for y in ys])
    check("5e rolloff %g, puck stage -> rear: rE.x falls monotonically, front at the stage, back at the rear" % R,
          np.all(np.diff(xv) < 0) and xv[0] > 0 and xv[-1] < 0,
          "rE.x %+.2f at the stage, %+.2f at the rear (front / back weaker than left / right, as expected)" % (xv[0], xv[-1]))

# ---- 6. W gain range ----------------------------------------------------------------------
one = np.zeros(8); one[0] = 1.0
even = np.full(8, 1 / math.sqrt(8))
w_lo = 20 * math.log10(abs((one @ M)[0])); w_hi = 20 * math.log10(abs((even @ M)[0]))
ws = []
for x in np.linspace(0.5, 12.5, 25):
    for y in np.linspace(4.5, 19.5, 31):
        for blur in (0.0, 0.03, 0.3, 1.0):
            ws.append(20 * math.log10((dbap_gains(x, y, blur=blur) @ M)[0]))
check("6a W gain: 0 dB on one speaker, +9.03 dB spread evenly", abs(w_lo) < 1e-9 and abs(w_hi - 9.0309) < 1e-3,
      "%.2f .. %.2f dB" % (w_lo, w_hi))
check("6b W gain over the whole puck / blur range stays inside 0 .. +9.03 dB", min(ws) > -1e-9 and max(ws) < 9.031,
      "%.2f .. %.2f dB (fold trim default -9 dB)" % (min(ws), max(ws)))
# worst-case peak of any AmbiX channel relative to the source, before the fold trim
pk = max(np.max(np.abs(dbap_gains(x, y, blur=b) @ M)) for x in np.linspace(0.5, 12.5, 25)
         for y in np.linspace(4.5, 19.5, 31) for b in (0.0, 0.03, 0.3, 1.0))
check("6c no AmbiX channel exceeds W's worst case", pk <= 10 ** (9.031 / 20), "peak channel gain %.2f dB" % (20 * math.log10(pk)))

print("\n%s (%d failed)" % ("PRE-FLIGHT OK" if not fails else "PRE-FLIGHT FAILED", fails))
sys.exit(1 if fails else 0)
