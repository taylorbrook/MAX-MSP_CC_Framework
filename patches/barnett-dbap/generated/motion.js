// motion.js -- motion engine for dbap-motion.maxpat (barnett-dbap v0.6, D21 / D22 / D26-D30)
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
// The six computed paths, t = 2 pi frac(cycles) + phase, R = size / 2 (size is the EXTENT, a diameter):
//   0 orbit     x = R cos t         y = R ratio sin t
//   1 figure8   x = R sin t         y = R ratio sin 2t
//   2 sweep     x = R (2 fold - 1)  y = 0
//   3 drift     x = R fbm(n)        y = R ratio fbm(n + 1000)     n = cycles, seeded
//   4 pendulum  x = R sin t         y = 0
//   5 spiral    x = R s cos ts      y = R ratio s sin ts          s = fold(u + phase / 360),
//                                                                  ts = 2 pi 6 frac(cycles) + phase
//   all         z = height sin t    (drift: height fbm(n + 2000))
//
// SPIRAL DEVIATES FROM THE PLUGIN ON PURPOSE (context.md D25). MotionPath.h turns ONCE per cycle
// while the radius folds out and back, which draws a single heart-shaped lobe (r = theta / pi),
// not a spiral. Here the angle makes K_SPIRAL_TURNS = 6 turns per cycle: three turns winding out,
// three winding back in, rotation direction never reversing. The inward arm is the mirror image of
// the outward arm. The radius law, phase handling, rotation and z are unchanged.
// then (x, y) rotated about the anchor by angle.
//
// v0.6 GESTURE RECORDER (D26-D30, no plugin counterpart). A seventh path, "recorded":
//   6 recorded  x = R gx(uu)        y = R ratio gy(uu)            uu = frac(u + phase / 360)
// gx / gy is a gesture drawn with the mouse on the source's plan: 120 points uniform in time,
// centroid-relative, normalised so the largest radius is 1. The first 90 % of a cycle plays the
// gesture at the recorded speed (index uu / 0.9 * 119, linear interpolation); the last 10 % glides
// from the last point back to the first on a raised cosine (D29), so the loop never jumps.
// Recording: "rec 1" arms (motion is switched off first, so the hand is what is heard). The source
// reports every mouse position as "anchorm x_m y_m" over the scene cord; the clock starts at the
// FIRST anchorm and the gesture ends at the LAST anchorm before "rec 0". The lcd only reports
// while the mouse moves, so a gap longer than K_REC_HOLD_S is recorded as a HOLD at the previous
// position (a pause stays a pause instead of becoming a slow drift). On stop the module sets its
// own dials through outlet 1 for 1:1 playback (size = 2 rmax, rate = 0.9 / duration, ratio 1,
// angle 0, phase 0, path recorded), moves the source's anchor to the gesture's centroid
// ("setanchor") and switches motion on. The dials drive this js through their prepend boxes as
// always: the UI is the one source of truth, so scenes stay consistent. The gesture itself lives
// in "pattr gesture" (D30): it is emitted once on record stop and comes back as "gesture ...",
// which never re-emits.
//
// inlet 0 messages:
//   on 0/1      start / stop the clock. Off emits "motion 0 0 0" and an empty "trace" once.
//               "on 1" while already running is ignored (a scene recall must not restart the phase).
//   path i      0..6 (orbit, figure8, sweep, drift, pendulum, spiral, recorded)
//   rate f      Hz, 0.01..10 (default 0.1)
//   size f      metres, 0..24 (default 6)
//   ratio f     0..1 (default 1)
//   angle f     degrees, 0..360 (default 0)
//   height f    metres, 0..8 (default 0)
//   phase f     degrees, 0..360 (default 0)
//   seed i      1..64 (default 1), Drift only
//   rec 0/1     arm / stop the gesture recorder
//   anchorm x y the source's anchor in metres while the mouse drags it (ignored unless armed)
//   gesture ... 240 floats (pattr echo / scene recall); anything else clears the gesture
//
// outlet 0: "motion dx dy dz"            every tick while on (metres, anchor-relative)
//           "trace x1 y1 .. xN yN"       one cycle of a cyclic path, on start and whenever a shape
//                                        parameter changes; N = 32 (spiral: 120, 20 per turn; the
//                                        message stays under 256 atoms); bare "trace" = clear (off,
//                                        or Drift, or "recorded" with no gesture). "recorded"
//                                        sends 120 points, glide segment included
//           "setanchor x_m y_m"          on record stop: the gesture's centroid becomes the anchor
//           "recstate 0/1"               the source's plan shows REC while 1
// outlet 1: UI feedback, routed to the module's own controls: "on i", "path i", "rate f",
//           "size f", "ratio f", "angle f", "phase f", "gesture f x 240"

inlets = 1;
outlets = 2;

var TICK_MS = 16;
var TRACE_POINTS = 32;
var TRACE_POINTS_SPIRAL = 120;   // 20 per turn; 241 atoms with the selector
var K_SPIRAL_TURNS = 6;          // D25: turns per cycle (3 out + 3 in). An integer, so the path closes.
var K_TWO_PI = 6.283185307179586476925286766559;
var K_DEG_TO_RAD = 0.017453292519943295769;

var PATH_ORBIT = 0, PATH_FIGURE8 = 1, PATH_SWEEP = 2, PATH_DRIFT = 3, PATH_PENDULUM = 4, PATH_SPIRAL = 5;
var PATH_RECORDED = 6;
var K_NUM_PATHS = 7;

// ---- gesture recorder constants (D28, D29) ----------------------------------------------------
var K_GESTURE_POINTS = 120;      // 240 floats + selector = 241 atoms (prepend's limit is 256)
var K_GESTURE_PLAY = 0.9;        // fraction of a cycle that plays the gesture; the rest glides back
var K_REC_MAX_S = 90.0;          // auto-stop: 0.9 / 0.01 Hz, the longest gesture the rate floor plays 1:1
var K_REC_MIN_S = 0.1;           // shorter than this: discard
var K_REC_MIN_RADIUS_M = 0.05;   // smaller than this: discard
var K_REC_HOLD_S = 0.1;          // a gap between mouse reports longer than this is a hold
var K_REC_HOLD_EDGE_S = 0.016;   // the hold ends one tick before the next report

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

// ---- recorder state -------------------------------------------------------------------------------
var recArmed = 0;
var recPts = [];          // [t_s, x_m, y_m, ...] since the first anchorm
var recT0 = -1;           // ms clock of the first anchorm, < 0 = none yet
var gestPts = [];         // 240 floats (x1 y1 .. x120 y120), centroid-relative, max radius 1; or empty
var prevOn = 0;
var prevPath = 0;

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

function hasGesture() {
    return gestPts.length === 2 * K_GESTURE_POINTS;
}

// Gesture position (unit radius) at uu in [0, 1): gesture for the first 90 %, then the glide back.
function gestureAt(uu, out) {
    var last = K_GESTURE_POINTS - 1;
    if (uu < K_GESTURE_PLAY) {
        var f = uu / K_GESTURE_PLAY * last;
        var i = Math.floor(f);
        if (i >= last) { i = last - 1; }
        var a = f - i;
        out[0] = gestPts[2 * i] + a * (gestPts[2 * i + 2] - gestPts[2 * i]);
        out[1] = gestPts[2 * i + 1] + a * (gestPts[2 * i + 3] - gestPts[2 * i + 1]);
    } else {
        var k = (uu - K_GESTURE_PLAY) / (1.0 - K_GESTURE_PLAY);
        var w = 0.5 - 0.5 * Math.cos(Math.PI * k);
        out[0] = gestPts[2 * last] + w * (gestPts[0] - gestPts[2 * last]);
        out[1] = gestPts[2 * last + 1] + w * (gestPts[1] - gestPts[2 * last + 1]);
    }
}
var gScratch = [0, 0];

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
        // D25: K_SPIRAL_TURNS turns per cycle instead of the plugin's one (see the header note)
        var ts = K_TWO_PI * K_SPIRAL_TURNS * u + phaseDeg * K_DEG_TO_RAD;
        uu = u + phaseDeg / 360.0;
        s = fold(uu - Math.floor(uu));
        x = R * s * Math.cos(ts);
        y = R * ratioAmt * s * Math.sin(ts);
        z = heightM * Math.sin(t);
    } else if (pathIdx === PATH_RECORDED) {
        if (!hasGesture()) return [0.0, 0.0, 0.0];
        uu = u + phaseDeg / 360.0;
        gestureAt(uu - Math.floor(uu), gScratch);
        x = R * gScratch[0];
        y = R * ratioAmt * gScratch[1];
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

// One cycle of the path (cyclic paths only), 32 points, 120 for the spiral. Shape only: independent
// of the clock.
function emitTrace() {
    if (!isOn || !isCyclic(pathIdx) || (pathIdx === PATH_RECORDED && !hasGesture())) {
        outlet(0, "trace");
        return;
    }
    var msg = ["trace"];
    var nPts = (pathIdx === PATH_SPIRAL) ? TRACE_POINTS_SPIRAL : TRACE_POINTS;
    if (pathIdx === PATH_RECORDED) nPts = K_GESTURE_POINTS;
    for (var k = 0; k < nPts; k++) {
        var p = evaluate(k / nPts);
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

// ---- gesture recorder (D26-D30) -----------------------------------------------------------------
function recPush(tSec, x, y) {
    recPts.push(tSec);
    recPts.push(x);
    recPts.push(y);
}

// Position of the raw recording at time tSec (linear between reports; holds are explicit points).
function recAt(tSec, out) {
    var n = recPts.length / 3;
    var lo = 0, hi = n - 1;
    if (tSec <= recPts[0]) { out[0] = recPts[1]; out[1] = recPts[2]; return; }
    if (tSec >= recPts[3 * hi]) { out[0] = recPts[3 * hi + 1]; out[1] = recPts[3 * hi + 2]; return; }
    while (hi - lo > 1) {
        var mid = (lo + hi) >> 1;
        if (recPts[3 * mid] <= tSec) lo = mid; else hi = mid;
    }
    var t0 = recPts[3 * lo], t1 = recPts[3 * hi];
    var a = (t1 > t0) ? (tSec - t0) / (t1 - t0) : 0.0;
    out[0] = recPts[3 * lo + 1] + a * (recPts[3 * hi + 1] - recPts[3 * lo + 1]);
    out[1] = recPts[3 * lo + 2] + a * (recPts[3 * hi + 2] - recPts[3 * lo + 2]);
}

function recDiscard(why) {
    post("motion.js: recording discarded (" + why + ")\n");
    recPts = [];
    recT0 = -1;
    outlet(0, "recstate", 0);
    // back to where the module was before "rec 1" (through the UI, the one source of truth)
    outlet(1, "path", prevPath);
    outlet(1, "on", prevOn);
}

// The ONE stop routine ("rec 0" and the auto-stop). Leaves recArmed to the caller.
function recStop() {
    var n = recPts.length / 3;
    if (n < 2) { recDiscard("fewer than 2 points"); return; }
    var dur = recPts[3 * (n - 1)];
    if (!(dur >= K_REC_MIN_S)) { recDiscard("shorter than " + K_REC_MIN_S + " s"); return; }

    // resample: 120 points uniform in time
    var g = [], p = [0, 0], cx = 0.0, cy = 0.0, k;
    for (k = 0; k < K_GESTURE_POINTS; k++) {
        recAt(dur * k / (K_GESTURE_POINTS - 1), p);
        g.push(p[0]);
        g.push(p[1]);
        cx += p[0];
        cy += p[1];
    }
    cx /= K_GESTURE_POINTS;
    cy /= K_GESTURE_POINTS;
    var rmax = 0.0;
    for (k = 0; k < K_GESTURE_POINTS; k++) {
        g[2 * k] -= cx;
        g[2 * k + 1] -= cy;
        var r = Math.sqrt(g[2 * k] * g[2 * k] + g[2 * k + 1] * g[2 * k + 1]);
        if (r > rmax) rmax = r;
    }
    if (!(rmax >= K_REC_MIN_RADIUS_M)) { recDiscard("smaller than " + K_REC_MIN_RADIUS_M + " m"); return; }
    for (k = 0; k < 2 * K_GESTURE_POINTS; k++) g[k] /= rmax;

    recPts = [];
    recT0 = -1;
    // the pattr echo brings the gesture back as "gesture ..."; nothing else is set here
    outlet(1, ["gesture"].concat(g));
    outlet(1, "ratio", 1.0);
    outlet(1, "angle", 0.0);
    outlet(1, "phase", 0.0);
    outlet(1, "size", 2.0 * rmax);
    outlet(1, "rate", K_GESTURE_PLAY / dur);
    outlet(1, "path", PATH_RECORDED);
    outlet(0, "recstate", 0);
    outlet(0, "setanchor", cx, cy);
    outlet(1, "on", 1);
}

function rec(v) {
    var want = v ? 1 : 0;
    if (want) {
        if (recArmed) return;
        recArmed = 1;
        recPts = [];
        recT0 = -1;
        prevOn = isOn;
        prevPath = pathIdx;
        if (isOn) outlet(1, "on", 0);   // the toggle switches this js off: the hand is what is heard
        outlet(0, "recstate", 1);
    } else {
        if (!recArmed) return;          // also the "rec 0" that follows an auto-stop
        recArmed = 0;
        recStop();
    }
}

function anchorm(x, y) {
    if (!recArmed) return;
    if (typeof x !== "number" || typeof y !== "number" || !isFinite(x) || !isFinite(y)) return;
    var now = nowMs();
    if (recT0 < 0) {
        recT0 = now;
        recPush(0.0, x, y);
        return;
    }
    var tSec = (now - recT0) / 1000.0;
    var n = recPts.length / 3;
    var tPrev = recPts[3 * (n - 1)];
    if (tSec < tPrev) return;           // clock went backwards: drop the report
    if (tSec > K_REC_MAX_S) {
        // auto-stop: the gesture ends at the last report inside the limit; nothing more until "rec 0"
        recArmed = 0;
        recStop();
        return;
    }
    if (tSec - tPrev > K_REC_HOLD_S) {
        recPush(tSec - K_REC_HOLD_EDGE_S, recPts[3 * (n - 1) + 1], recPts[3 * (n - 1) + 2]);
    }
    recPush(tSec, x, y);
}

// pattr echo / scene recall. Never re-emits on outlet 1, so record stop -> pattr -> here cannot loop.
function gesture() {
    var a = arrayfromargs(arguments);
    var ok = (a.length === 2 * K_GESTURE_POINTS);
    for (var i = 0; ok && i < a.length; i++) {
        if (typeof a[i] !== "number" || !isFinite(a[i])) ok = false;
    }
    gestPts = ok ? a : [];
    if (isOn && pathIdx === PATH_RECORDED) emitTrace();
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
