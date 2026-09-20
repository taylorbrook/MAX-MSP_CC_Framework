// motion.js -- motion engine for dbap-motion.maxpat (barnett-dbap v0.5, D21 / D22)
// Port of MotionPath.h + MotionClock.h (free-run branch) + PerlinNoise.h from O-Octagon v1.13.0.
// Equations and constants verbatim (context.md D10 principle).
//
// The module knows nothing about the venue: it emits an ANCHOR-RELATIVE offset in METRES that
// dbap.js adds to the puck position after normalised -> metres, before shaping / hull / air
// (the plugin's insertion point, GainStage.cpp updateControl).
//
// Clock (D22): a Task at 16 ms evaluates the path from ELAPSED TIME, never by accumulating:
//   cycles = rate * t + phaseBase,  t = seconds since "on 1"
// and on a rate change phaseBase += (oldRate - newRate) * t (MotionClock.h freeRunCycles), so the
// path never jumps when the rate dial moves. Task jitter changes WHEN a point is sampled, not
// where the path is. Free-running Hz only; no transport sync.
//
// The six paths, t = 2 pi frac(cycles) + phase, R = size / 2 (size is the EXTENT, a diameter):
//   0 orbit     x = R cos t         y = R ratio sin t
//   1 figure8   x = R sin t         y = R ratio sin 2t
//   2 sweep     x = R (2 fold - 1)  y = 0
//   3 drift     x = R fbm(n)        y = R ratio fbm(n + 1000)     n = cycles, seeded
//   4 pendulum  x = R sin t         y = 0
//   5 spiral    x = R s cos t       y = R ratio s sin t           s = fold(u + phase / 360)
//   all         z = height sin t    (drift: height fbm(n + 2000))
// then (x, y) rotated about the anchor by angle.
//
// inlet 0 messages:
//   on 0/1      start / stop the clock. Off emits "motion 0 0 0" and an empty "trace" once.
//               "on 1" while already running is ignored (a scene recall must not restart the phase).
//   path i      0..5 (orbit, figure8, sweep, drift, pendulum, spiral)
//   rate f      Hz, 0.01..10 (default 0.1)
//   size f      metres, 0..24 (default 6)
//   ratio f     0..1 (default 1)
//   angle f     degrees, 0..360 (default 0)
//   height f    metres, 0..8 (default 0)
//   phase f     degrees, 0..360 (default 0)
//   seed i      1..64 (default 1), Drift only
//
// outlet 0: "motion dx dy dz"            every tick while on (metres, anchor-relative)
//           "trace x1 y1 .. x32 y32"     one cycle of a cyclic path, on start and whenever a shape
//                                        parameter changes; bare "trace" = clear (off, or Drift)

inlets = 1;
outlets = 1;

var TICK_MS = 16;
var TRACE_POINTS = 32;
var K_TWO_PI = 6.283185307179586476925286766559;
var K_DEG_TO_RAD = 0.017453292519943295769;

var PATH_ORBIT = 0, PATH_FIGURE8 = 1, PATH_SWEEP = 2, PATH_DRIFT = 3, PATH_PENDULUM = 4, PATH_SPIRAL = 5;
var K_NUM_PATHS = 6;

// ---- parameters (PluginProcessor.cpp defaults; rate range per D22) ---------------------------
var isOn = 0;
var pathIdx = 0;
var rateHz = 0.1;
var sizeM = 6.0;
var ratioAmt = 1.0;
var angleDeg = 0.0;
var heightM = 0.0;
var phaseDeg = 0.0;
var seedVal = 1;

// ---- clock state (MotionClock.h MotionClockState; phaseBase is a constant of integration) ----
var t0Ms = 0;
var phaseBase = 0.0;
var lastRate = -1.0;      // < 0: no rate observed yet, so the first call does not re-base
var seededWith = -1;
var tsk = null;

// ---- PerlinNoise.h port -------------------------------------------------------------------------
var perm = [];

function perlinSeed(s) {
    var i;
    for (i = 0; i < 256; i++) perm[i] = i;
    for (i = 255; i > 0; i--) {
        // uint32 LCG. s * 1664525 stays below 2^53, so the double product is exact.
        s = (s * 1664525 + 1013904223) % 4294967296;
        var j = (s >>> 16) % (i + 1);
        var tmp = perm[i];
        perm[i] = perm[j];
        perm[j] = tmp;
    }
    for (i = 0; i < 256; i++) perm[256 + i] = perm[i];
}

function pFade(t) {
    return t * t * t * (t * (t * 6.0 - 15.0) + 10.0);
}

function pGrad(hash, x) {
    return (hash & 1) ? -x : x;
}

function perlinNoise(x) {
    var fl = Math.floor(x);
    var xi = fl & 255;
    var xf = x - fl;
    var u = pFade(xf);
    var a = pGrad(perm[xi], xf);
    var b = pGrad(perm[xi + 1], xf - 1.0);
    return a + u * (b - a);
}

// octaves 4, lacunarity 2, persistence 0.5 (the header's defaults, which the plugin uses)
function perlinFbm(x) {
    var value = 0.0, amplitude = 1.0, frequency = 1.0, maxAmplitude = 0.0;
    for (var i = 0; i < 4; i++) {
        value += perlinNoise(x * frequency) * amplitude;
        maxAmplitude += amplitude;
        amplitude *= 0.5;
        frequency *= 2.0;
    }
    return value / maxAmplitude;
}

// ---- MotionPath.h port ---------------------------------------------------------------------------
function fold(u) {
    return u < 0.5 ? 2.0 * u : 2.0 - 2.0 * u;
}

function isCyclic(p) {
    return p !== PATH_DRIFT;
}

// Pure function of (parameters, cycles). Returns [x, y, z] in metres, anchor-relative.
function evaluate(cycles) {
    var R = 0.5 * sizeM;
    var u = cycles - Math.floor(cycles);
    var t = K_TWO_PI * u + phaseDeg * K_DEG_TO_RAD;
    var x = 0.0, y = 0.0, z = 0.0;
    var uu, f, s, n;

    if (pathIdx === PATH_ORBIT) {
        x = R * Math.cos(t);
        y = R * ratioAmt * Math.sin(t);
        z = heightM * Math.sin(t);
    } else if (pathIdx === PATH_FIGURE8) {
        x = R * Math.sin(t);
        y = R * ratioAmt * Math.sin(2.0 * t);
        z = heightM * Math.sin(t);
    } else if (pathIdx === PATH_SWEEP) {
        uu = u + phaseDeg / 360.0;
        f = fold(uu - Math.floor(uu));
        x = R * (2.0 * f - 1.0);
        y = 0.0;
        z = heightM * Math.sin(t);
    } else if (pathIdx === PATH_DRIFT) {
        n = cycles;
        x = R * perlinFbm(n);
        y = R * ratioAmt * perlinFbm(n + 1000.0);
        z = heightM * perlinFbm(n + 2000.0);
    } else if (pathIdx === PATH_PENDULUM) {
        x = R * Math.sin(t);
        y = 0.0;
        z = heightM * Math.sin(t);
    } else if (pathIdx === PATH_SPIRAL) {
        uu = u + phaseDeg / 360.0;
        s = fold(uu - Math.floor(uu));
        x = R * s * Math.cos(t);
        y = R * ratioAmt * s * Math.sin(t);
        z = heightM * Math.sin(t);
    }

    // rotation about the anchor, skipped exactly at angle 0 (as in the plugin)
    if (angleDeg !== 0.0) {
        var a = angleDeg * K_DEG_TO_RAD;
        var ca = Math.cos(a), sa = Math.sin(a);
        var rx = x * ca - y * sa;
        var ry = x * sa + y * ca;
        x = rx;
        y = ry;
    }
    return [x, y, z];
}

// ---- MotionClock.h freeRunCycles port -----------------------------------------------------------
function nowMs() {
    return new Date().getTime();
}

function cyclesAt(tSec) {
    if (lastRate >= 0.0 && rateHz !== lastRate) {
        phaseBase += (lastRate - rateHz) * tSec;
    }
    lastRate = rateHz;
    return rateHz * tSec + phaseBase;
}

function ensureSeeded() {
    if (seedVal !== seededWith) {
        perlinSeed(seedVal);
        seededWith = seedVal;
    }
}

function tick() {
    if (!isOn) return;
    ensureSeeded();
    var tSec = (nowMs() - t0Ms) / 1000.0;
    var p = evaluate(cyclesAt(tSec));
    outlet(0, "motion", p[0], p[1], p[2]);
}

// One cycle of the path at 32 points (cyclic paths only). Shape only: independent of the clock.
function emitTrace() {
    if (!isOn || !isCyclic(pathIdx)) {
        outlet(0, "trace");
        return;
    }
    var msg = ["trace"];
    for (var k = 0; k < TRACE_POINTS; k++) {
        var p = evaluate(k / TRACE_POINTS);
        msg.push(p[0]);
        msg.push(p[1]);
    }
    outlet(0, msg);
}

function clampTo(v, lo, hi) {
    if (!(v >= lo)) return lo;
    if (v > hi) return hi;
    return v;
}

// ---- message handlers ------------------------------------------------------------------------------
function on(v) {
    var want = v ? 1 : 0;
    if (want === isOn) return;
    isOn = want;
    if (isOn) {
        // free-run restarts from phase 0 (GainStage prepare: motionClock = {})
        t0Ms = nowMs();
        phaseBase = 0.0;
        lastRate = -1.0;
        ensureSeeded();
        emitTrace();
        if (tsk === null) tsk = new Task(tick, this);
        tsk.interval = TICK_MS;
        tsk.repeat();
    } else {
        if (tsk !== null) tsk.cancel();
        outlet(0, "motion", 0.0, 0.0, 0.0);
        outlet(0, "trace");
    }
}

function path(v) {
    pathIdx = Math.floor(clampTo(v, 0, K_NUM_PATHS - 1));
    if (isOn) emitTrace();
}

function rate(v) {
    rateHz = clampTo(v, 0.01, 10.0);   // the re-base happens at the next tick (cyclesAt)
}

function size(v) {
    sizeM = clampTo(v, 0.0, 24.0);
    if (isOn) emitTrace();
}

function ratio(v) {
    ratioAmt = clampTo(v, 0.0, 1.0);
    if (isOn) emitTrace();
}

function angle(v) {
    angleDeg = clampTo(v, 0.0, 360.0);
    if (isOn) emitTrace();
}

function height(v) {
    heightM = clampTo(v, 0.0, 8.0);
}

function phase(v) {
    phaseDeg = clampTo(v, 0.0, 360.0);
    if (isOn) emitTrace();
}

function seed(v) {
    seedVal = Math.floor(clampTo(v, 1, 64));
}

function bang() {
    if (isOn) {
        emitTrace();
        tick();
    }
}

function notifydeleted() {
    if (tsk !== null) tsk.cancel();
}

function anything() {
    post("motion.js: unknown message " + messagename + "\n");
}

perlinSeed(seedVal);
seededWith = seedVal;
