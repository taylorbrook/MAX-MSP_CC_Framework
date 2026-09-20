// preflight_motion.js -- node pre-flight for barnett-dbap v0.5 / v0.6 (motion.js incl. the gesture recorder,
// dbap.js motion path + anchorm / setanchor / recstate, venue-align.js).
// Run: node patches/barnett-dbap/test-results/preflight_motion.js
// motion_ref.txt is the output of motion_ref.cpp, which compiles the PLUGIN'S OWN MotionPath.h /
// PerlinNoise.h (c++ -std=c++17 -I<O-Octagon>/Source -I<O-Octagon>/Source/DSP motion_ref.cpp).
var fs = require("fs"), vm = require("vm"), path = require("path");
var GEN = path.join(__dirname, "..", "generated");
var fails = 0;
function check(name, ok, detail) {
    if (!ok) fails++;
    console.log((ok ? "PASS  " : "FAIL  ") + name + (detail ? "   " + detail : ""));
}

function load(file) {
    var out = [];
    var ctx = {
        out: out, posts: [], tasks: [], messagename: "",
        outlet: function () { out.push(Array.prototype.slice.call(arguments)); },
        post: function (s) { ctx.posts.push(s); },
        arrayfromargs: function (a) { return Array.prototype.slice.call(a); },
        Task: function (fn, obj) { this.fn = fn; this.running = false; this.interval = 0; ctx.tasks.push(this);
            this.repeat = function () { this.running = true; }; this.cancel = function () { this.running = false; }; },
        Dict: function () { throw new Error("no dict in node"); },
        Math: Math, Date: Date, Number: Number, isFinite: isFinite
    };
    vm.createContext(ctx);
    vm.runInContext(fs.readFileSync(path.join(GEN, file), "utf8"), ctx, { filename: file });
    return ctx;
}
function flat(m) { return Array.isArray(m[1]) ? [m[0]].concat(m[1]) : m; }   // outlet(n, [list]) form
function lastMsg(ctx, outletIdx, name) {
    for (var i = ctx.out.length - 1; i >= 0; i--) { var m = flat(ctx.out[i]); if (m[0] === outletIdx && m[1] === name) return m.slice(2); }
    return null;
}

// ---------------------------------------------------------------- motion.js vs the plugin headers
var m = load("motion.js");
var ref = fs.readFileSync(path.join(__dirname, "motion_ref.txt"), "utf8").trim().split("\n");
var worst = 0, worstRow = "", nRef = 0;
ref.forEach(function (row) {
    var f = row.split(" ").map(Number);
    if (f[1] === 5) return;   // spiral deviates from MotionPath.h on purpose (D25), checked below
    nRef++;
    m.seed(f[0]); m.ensureSeeded(); m.path(f[1]);
    if (f[2] === 1) { m.size(9.5); m.ratio(0.4); m.angle(37); m.height(2.5); m.phase(110); }
    else { m.size(6); m.ratio(1); m.angle(0); m.height(0); m.phase(0); }
    var p = m.evaluate(f[3]);
    for (var k = 0; k < 3; k++) { var e = Math.abs(p[k] - f[4 + k]); if (e > worst) { worst = e; worstRow = row; } }
});
// the plugin is float32, the port is double: agreement to float precision on up to 12 m values
// Tolerance: the worst rows are Drift at large cycle counts, where the plugin's float32 argument
// (n * 8 in the top fbm octave) quantises at ~6e-5 and the noise slope turns that into ~2e-4 m.
check("evaluate() matches MotionPath.h on " + nRef + " points (5 paths, 3 seeds; spiral excluded, D25)", worst < 5e-4, "max |err| " + worst.toExponential(2) + " m at [" + worstRow + "]");
var worstCyc = 0;
ref.forEach(function (row) {
    var f = row.split(" ").map(Number);
    if (f[1] === 3 || f[1] === 5) return;
    m.seed(f[0]); m.ensureSeeded(); m.path(f[1]);
    if (f[2] === 1) { m.size(9.5); m.ratio(0.4); m.angle(37); m.height(2.5); m.phase(110); }
    else { m.size(6); m.ratio(1); m.angle(0); m.height(0); m.phase(0); }
    var p = m.evaluate(f[3]);
    for (var k = 0; k < 3; k++) worstCyc = Math.max(worstCyc, Math.abs(p[k] - f[4 + k]));
});
check("the four plugin-verbatim cyclic paths match to float32 precision", worstCyc < 5e-6, "max |err| " + worstCyc.toExponential(2) + " m");

// ---------------------------------------------------------------- closure, extent
m = load("motion.js");
var names = ["orbit", "figure8", "sweep", "drift", "pendulum", "spiral"];
[0, 1, 2, 4, 5].forEach(function (pi) {
    m.path(pi); m.size(6); m.ratio(0.7); m.angle(0); m.height(1.5); m.phase(40);
    var a = m.evaluate(0), b = m.evaluate(1), c = m.evaluate(5);
    var d = Math.max(Math.abs(a[0] - b[0]), Math.abs(a[1] - b[1]), Math.abs(a[2] - b[2]), Math.abs(a[0] - c[0]), Math.abs(a[1] - c[1]));
    var mx = 0, my = 0, mz = 0;
    for (var k = 0; k < 7200; k++) { var p = m.evaluate(k / 7200); mx = Math.max(mx, Math.abs(p[0])); my = Math.max(my, Math.abs(p[1])); mz = Math.max(mz, Math.abs(p[2]));
        if (pi === 5) mx = Math.max(mx, Math.sqrt(p[0] * p[0] + (p[1] / 0.7) * (p[1] / 0.7))); }   // spiral: the ellipse radius reaches R
    check(names[pi] + ": closes after one cycle", d < 1e-9, "gap " + d.toExponential(1));
    check(names[pi] + ": max |x| = size / 2", Math.abs(mx - 3) < 1e-3 && my <= 3 * 0.7 + 1e-9 && mz <= 1.5 + 1e-9, "x " + mx.toFixed(4) + " y " + my.toFixed(4) + " z " + mz.toFixed(4));
});
// ---------------------------------------------------------------- spiral (D25)
m.path(5); m.size(6); m.ratio(1); m.angle(0); m.height(0); m.phase(0);
var wind = 0, minStep = 1e9, prevA = null, rOut = [], N = 14400;
for (var k = 0; k <= N; k++) {
    var p = m.evaluate(k / N), r = Math.sqrt(p[0] * p[0] + p[1] * p[1]);
    if (k <= N / 2) rOut.push(r);
    if (r < 1e-6) { continue; }
    var a = Math.atan2(p[1], p[0]);
    if (prevA !== null) { var da = a - prevA; while (da > Math.PI) da -= 2 * Math.PI; while (da < -Math.PI) da += 2 * Math.PI; wind += da; minStep = Math.min(minStep, da); }
    prevA = a;
}
check("spiral: 6 turns per cycle (3 out + 3 in)", Math.abs(wind / (2 * Math.PI) - 6) < 0.01, "winding " + (wind / (2 * Math.PI)).toFixed(3) + " turns");
check("spiral: rotation direction never reverses", minStep > 0, "min angular step " + minStep.toExponential(2) + " rad");
var mono = true; for (var k = 1; k < rOut.length; k++) if (rOut[k] < rOut[k - 1] - 1e-12) mono = false;
check("spiral: radius grows monotonically 0 -> size / 2 over the first half cycle", mono && rOut[0] < 1e-9 && Math.abs(rOut[rOut.length - 1] - 3) < 1e-9);
var oa = m.evaluate(0.2), ob = m.evaluate(0.8);
check("spiral: the inward arm mirrors the outward arm", Math.abs(oa[0] - ob[0]) < 1e-9 && Math.abs(oa[1] + ob[1]) < 1e-9);
var mt = load("motion.js"); mt.path(5); mt.on(1);
var trS = lastMsg(mt, 0, "trace");
check("spiral: trace has 120 points and stays under 256 atoms", trS.length === 240);
mt.path(0);
check("other paths keep the 32-point trace", lastMsg(mt, 0, "trace").length === 64);

m.path(3); m.size(6); m.ratio(1);
var dmax = 0;
for (var k = 0; k < 20000; k++) { var p = m.evaluate(k * 0.013); dmax = Math.max(dmax, Math.abs(p[0]), Math.abs(p[1])); }
check("drift: stays within size / 2", dmax <= 3 + 1e-9, "max " + dmax.toFixed(3));

// ---------------------------------------------------------------- clock: start, re-base, off
m = load("motion.js");
var clock = 1000000;
m.nowMs = function () { return clock; };
m.path(0); m.size(6); m.rate(0.1);
m.on(1);
check("on 1 starts a 16 ms Task", m.tasks.length === 1 && m.tasks[0].running && m.tasks[0].interval === 16);
var tr = lastMsg(m, 0, "trace");
check("on 1 emits a 32-point trace", tr !== null && tr.length === 64);
clock += 3000; m.tick();
var p1 = lastMsg(m, 0, "motion");
m.rate(2.0); m.tick();
var p2 = lastMsg(m, 0, "motion");
var jump = Math.max(Math.abs(p1[0] - p2[0]), Math.abs(p1[1] - p2[1]), Math.abs(p1[2] - p2[2]));
check("rate 0.1 -> 2 Hz mid-cycle: no position jump", jump < 1e-9, "jump " + jump.toExponential(1) + " m");
clock += 16; m.tick();
var p3 = lastMsg(m, 0, "motion");
var step = Math.sqrt(Math.pow(p3[0] - p2[0], 2) + Math.pow(p3[1] - p2[1], 2));
check("after the re-base the path advances at the NEW rate", Math.abs(step - 2 * Math.PI * 3 * 2.0 * 0.016) < 0.01, "step " + step.toFixed(4) + " m / tick");
clock += 250; m.tick(); var before = m.out.length;
m.on(1);
check("on 1 while running is ignored (scene recall keeps the phase)", m.out.length === before);
m.on(0);
var off = lastMsg(m, 0, "motion"), offTr = lastMsg(m, 0, "trace");
check("on 0 stops the Task, emits motion 0 0 0 and a bare trace", !m.tasks[0].running && off[0] === 0 && off[1] === 0 && off[2] === 0 && offTr.length === 0);
before = m.out.length; m.tick();
check("no output while off", m.out.length === before);
m.on(1); m.path(3);
check("drift clears the trace", lastMsg(m, 0, "trace").length === 0);

// ---------------------------------------------------------------- drift determinism per seed
function driftRun(seed) {
    var c = load("motion.js"), t = 5000; c.nowMs = function () { return t; };
    c.seed(seed); c.path(3); c.rate(1.3); c.on(1);
    var acc = [];
    for (var i = 0; i < 200; i++) { t += 16; c.tick(); acc.push(lastMsg(c, 0, "motion").join(",")); }
    return acc.join(";");
}
check("drift: same seed -> identical run", driftRun(7) === driftRun(7));
check("drift: different seed -> different run", driftRun(7) !== driftRun(8));

// ---------------------------------------------------------------- v0.6 gesture recorder (D26-D30)
// The patch loops js outlet 1 back through the UI: toggle / umenu / dials -> prepend -> js, and
// "gesture" through pattr gesture -> prepend gesture -> js. wire() is that loop, synchronous as in MAX.
function wire(ctx) {
    var raw = ctx.outlet;
    ctx.ui = [];
    ctx.outlet = function () {
        var a = Array.prototype.slice.call(arguments);
        raw.apply(null, a);
        if (a[0] !== 1) return;
        var mm = Array.isArray(a[1]) ? a[1] : a.slice(1);
        ctx.ui.push(mm[0]);
        ctx[mm[0]].apply(ctx, mm.slice(1));
    };
    return ctx;
}
// An L with a pause at the corner: 2 s east at 1.5 m/s, 1 s still (NO reports, as the lcd), 1.5 s north.
function drawL(ctx, clk, reports) {
    var t;
    for (t = 0; t <= 2000; t += 16) { clk.t = clk.base + t; reports.push([t / 1000, 2 + 1.5 * t / 1000, 3]); ctx.anchorm(2 + 1.5 * t / 1000, 3); }
    for (t = 3000; t <= 4500; t += 16) { clk.t = clk.base + t; reports.push([t / 1000, 5, 3 + 1.2 * (t - 3000) / 1000]); ctx.anchorm(5, 3 + 1.2 * (t - 3000) / 1000); }
}
var r = wire(load("motion.js")), clk = { base: 5000000, t: 5000000 }, reps = [];
r.nowMs = function () { return clk.t; };
r.path(0); r.size(6); r.rate(0.1);
r.anchorm(1, 1);
check("rec: anchorm while unarmed does nothing", r.out.length === 0 && r.recPts.length === 0);
r.on(1);
var nOut = r.out.length;
r.rec(1);
check("rec 1 with motion on: switches motion off through the UI, then recstate 1",
      r.isOn === 0 && r.ui.join() === "on" && lastMsg(r, 0, "recstate")[0] === 1 && lastMsg(r, 0, "motion").join() === "0,0,0");
clk.base += 700; drawL(r, clk, reps);
clk.t += 900;                       // reaching for the toggle: no reports, not part of the gesture
r.ui = []; nOut = r.out.length;
r.rec(0);
var emitted = r.out.slice(nOut).map(flat);
var gMsg = lastMsg(r, 1, "gesture"), dur = reps[reps.length - 1][0];
check("rec 0: gesture is 240 finite floats", gMsg.length === 240 && gMsg.every(function (v) { return typeof v === "number" && isFinite(v); }));
var gcx = 0, gcy = 0, grm = 0;
for (var k = 0; k < 120; k++) { gcx += gMsg[2 * k]; gcy += gMsg[2 * k + 1]; grm = Math.max(grm, Math.sqrt(gMsg[2 * k] * gMsg[2 * k] + gMsg[2 * k + 1] * gMsg[2 * k + 1])); }
check("gesture: centroid at 0, largest radius exactly 1", Math.abs(gcx / 120) < 1e-9 && Math.abs(gcy / 120) < 1e-9 && Math.abs(grm - 1) < 1e-12,
      "centroid " + (gcx / 120).toExponential(1) + " " + (gcy / 120).toExponential(1) + ", rmax " + grm);
check("rec 0: UI order is gesture, ratio, angle, phase, size, rate, path, on", r.ui.join() === "gesture,ratio,angle,phase,size,rate,path,on", r.ui.join());
var order = emitted.filter(function (o) { return o[0] === 1 || o[1] === "recstate" || o[1] === "setanchor"; }).map(function (o) { return o[1]; }).join();
check("rec 0: recstate 0 and setanchor come after path 6 and before on 1", order === "gesture,ratio,angle,phase,size,rate,path,recstate,setanchor,on", order);
var sa = lastMsg(r, 0, "setanchor"), szE = lastMsg(r, 1, "size")[0], rtE = lastMsg(r, 1, "rate")[0];
check("rec 0: rate = 0.9 / duration (the tail after the last report is dropped), path 6, ratio 1, angle 0, phase 0",
      Math.abs(rtE - 0.9 / 4.488) < 1e-12 && Math.abs(dur - 4.488) < 1e-9 && lastMsg(r, 1, "path")[0] === 6 && lastMsg(r, 1, "ratio")[0] === 1 && lastMsg(r, 1, "angle")[0] === 0 && lastMsg(r, 1, "phase")[0] === 0, "rate " + rtE);
check("after stop: motion is on, path recorded, state came back through the UI loop", r.isOn === 1 && r.pathIdx === 6 && r.sizeM === szE && r.rateHz === rtE && r.gestPts.length === 240);
check("after stop: a 120-point trace (241 atoms) was sent", lastMsg(r, 0, "trace").length === 240);
// size = 2 rmax and setanchor = centroid: rebuild the absolute path and compare with the reports
// 120 points over 4.488 s is one point every 37.7 ms. Linear interpolation is exact on the straight, constant-
// speed runs; across a velocity KINK (the stops and starts at 0 / 2 / 3 / 4.488 s) it cuts the corner in TIME by
// at most v dt / 4 = 1.5 * 0.0377 / 4 = 14 mm, along the path (about 9 ms early / late), never off the line.
var worstPos = 0, worstAway = 0, worstOff = 0, tStart = clk.t, dtRes = dur / 119, kinks = [0, 2, 3, dur];
reps.forEach(function (rp) {
    clk.t = tStart + rp[0] * 1000; r.tick();
    var mo = lastMsg(r, 0, "motion"), ax = sa[0] + mo[0], ay = sa[1] + mo[1];
    var e = Math.sqrt(Math.pow(ax - rp[1], 2) + Math.pow(ay - rp[2], 2));
    var nearKink = kinks.some(function (kt) { return Math.abs(rp[0] - kt) < dtRes; });
    worstPos = Math.max(worstPos, e);
    if (!nearKink) worstAway = Math.max(worstAway, e);
    worstOff = Math.max(worstOff, Math.min(Math.abs(ay - 3), Math.abs(ax - 5)));   // distance off the drawn L
});
check("playback at the emitted rate / size / anchor reproduces the drawn positions at the drawn times (< 1 cm away from stops / starts)", worstAway < 0.01, "max error " + (worstAway * 1000).toFixed(3) + " mm over " + reps.length + " reports");
check("playback: at a stop / start the error stays under v dt / 4 (14 mm, a 9 ms timing slip) and never leaves the drawn line",
      worstPos <= 1.5 * dtRes / 4 + 1e-9 && worstOff < 1e-9, "max " + (worstPos * 1000).toFixed(2) + " mm, off-line " + worstOff.toExponential(1) + " m");
clk.t = tStart + 2500; r.tick(); var hold = lastMsg(r, 0, "motion");
check("the pause at the corner is a hold, not a drift", Math.abs(sa[0] + hold[0] - 5) < 0.01 && Math.abs(sa[1] + hold[1] - 3) < 0.01, "at 2.5 s: " + (sa[0] + hold[0]).toFixed(3) + ", " + (sa[1] + hold[1]).toFixed(3));
// glide: continuous at both joins, closes the loop
var cyc = 1 / rtE, maxStep = 0, prevP = null, tickTravel = 0;
for (var tt = 0; tt <= 2 * cyc * 1000; tt += 16) {
    clk.t = tStart + tt; r.tick(); var pp = lastMsg(r, 0, "motion");
    if (prevP) maxStep = Math.max(maxStep, Math.sqrt(Math.pow(pp[0] - prevP[0], 2) + Math.pow(pp[1] - prevP[1], 2)));
    prevP = pp;
}
// fastest legitimate travel per tick: the drawn 1.5 m/s, or the glide's peak (pi / 2 x its mean speed)
var e0 = r.evaluate(0), e9 = r.evaluate(0.8999999), eEnd = r.evaluate(0.9999999), e1 = r.evaluate(1);
var glideLen = Math.sqrt(Math.pow(e9[0] - e0[0], 2) + Math.pow(e9[1] - e0[1], 2));
tickTravel = Math.max(1.5, Math.PI / 2 * glideLen / (0.1 * cyc)) * 0.016;
check("glide: no step larger than one tick of travel over two cycles", maxStep <= tickTravel * 1.05, "max step " + (maxStep * 1000).toFixed(1) + " mm, one tick " + (tickTravel * 1000).toFixed(1) + " mm");
var j1 = r.evaluate(0.9), j0 = r.evaluate(0.9 - 1e-9);
check("glide: continuous at the 0.9 join and closes the loop at 1.0",
      Math.abs(j1[0] - j0[0]) < 1e-6 && Math.abs(j1[1] - j0[1]) < 1e-6 && Math.abs(eEnd[0] - e0[0]) < 1e-5 && Math.abs(eEnd[1] - e0[1]) < 1e-5 && e1[0] === e0[0] && e1[1] === e0[1]);
var gl = r.evaluate(0.95);
check("glide: the midpoint is halfway between the last and the first point (raised cosine)", Math.abs(gl[0] - 0.5 * (e0[0] + j1[0])) < 1e-9 && Math.abs(gl[1] - 0.5 * (e0[1] + j1[1])) < 1e-9);
// transforms act about the centroid
r.size(szE * 2); var big = r.evaluate(0.3); r.size(szE); var nat = r.evaluate(0.3);
r.angle(90); var rot = r.evaluate(0.3); r.angle(0);
r.phase(90); var ph = r.evaluate(0.05), ph0; r.phase(0); ph0 = r.evaluate(0.3);
check("size scales, angle rotates and phase shifts the recorded path about its centroid",
      Math.abs(big[0] - 2 * nat[0]) < 1e-12 && Math.abs(rot[0] + nat[1]) < 1e-12 && Math.abs(rot[1] - nat[0]) < 1e-12 && Math.abs(ph[0] - ph0[0]) < 1e-12 && Math.abs(ph[1] - ph0[1]) < 1e-12);
// echo / scene recall
r.ui = []; nOut = r.out.length;
r.gesture.apply(r, gMsg);
var echoOut = r.out.slice(nOut).map(flat);
check("gesture echo never re-emits on outlet 1 (only a fresh trace while playing)", r.ui.length === 0 && echoOut.length === 1 && echoOut[0][1] === "trace" && echoOut[0].length === 242);
var sc = wire(load("motion.js")), sclk = 100; sc.nowMs = function () { return sclk; };
sc.path(6); sc.on(1);
check("scene recall order path, on, gesture: empty until the gesture lands (bare trace, motion 0)", lastMsg(sc, 0, "trace").length === 0 && sc.evaluate(0.4).join() === "0,0,0");
sc.size(szE); sc.rate(rtE); sc.gesture.apply(sc, gMsg);
sclk += 1000; sc.tick();
var scm = lastMsg(sc, 0, "motion");
check("a scene-style gesture + path 6 + on 1 plays without a recording", lastMsg(sc, 0, "trace").length === 240 && Math.abs(sa[0] + scm[0] - (2 + 1.5)) < 0.01 && Math.abs(sa[1] + scm[1] - 3) < 0.01 && sc.ui.length === 0);
sc.gesture(0);
check("an invalid gesture (pattr with no value: 0) clears it", sc.gestPts.length === 0 && lastMsg(sc, 0, "trace").length === 0);
sc.gesture.apply(sc, gMsg.slice(0, 239).concat([NaN]));
check("a gesture with a non-finite value is rejected", sc.gestPts.length === 0);
// discard cases restore the previous state
function discardRun(draw, wasOn) {
    var c = wire(load("motion.js")), ck = { t: 9000 }; c.nowMs = function () { return ck.t; };
    c.path(4); if (wasOn) c.on(1);
    c.rec(1); draw(c, ck); c.ui = []; c.rec(0);
    return c;
}
var d1 = discardRun(function (c) { c.anchorm(3, 3); }, 1);
check("discard: one point -> console line, recstate 0, previous path / on restored, no gesture",
      d1.posts.length === 1 && lastMsg(d1, 0, "recstate")[0] === 0 && d1.ui.join() === "path,on" && d1.pathIdx === 4 && d1.isOn === 1 && lastMsg(d1, 1, "gesture") === null && lastMsg(d1, 0, "setanchor") === null);
var d2 = discardRun(function (c, ck) { c.anchorm(3, 3); ck.t += 50; c.anchorm(4, 3); }, 0);
check("discard: shorter than 0.1 s, motion stays off", d2.posts.length === 1 && d2.isOn === 0 && d2.pathIdx === 4 && lastMsg(d2, 1, "gesture") === null);
var d3 = discardRun(function (c, ck) { for (var i = 0; i < 60; i++) { ck.t += 16; c.anchorm(3 + 0.0005 * i, 3); } }, 0);
check("discard: largest radius under 0.05 m", d3.posts.length === 1 && lastMsg(d3, 1, "gesture") === null);
var d0 = discardRun(function () {}, 0);
check("discard: rec 1 then rec 0 with no mouse at all", d0.posts.length === 1 && lastMsg(d0, 1, "gesture") === null);
// auto-stop
var au = wire(load("motion.js")), ack = { t: 1000 }; au.nowMs = function () { return ack.t; };
au.rec(1);
for (var i = 0; i <= 5700; i++) { au.anchorm(2 + 8 * i / 5700, 4 + Math.sin(i / 300)); ack.t += 16; if (au.ui.length) break; }
var auRate = lastMsg(au, 1, "rate");
check("auto-stop at 90 s (0.9 / the 0.01 Hz rate floor): the same stop routine, rate stays on the dial",
      auRate !== null && auRate[0] >= 0.01 && Math.abs(0.9 / auRate[0] - 90) < 0.02 && au.recArmed === 0 && au.isOn === 1, auRate ? "duration " + (0.9 / auRate[0]).toFixed(3) + " s" : "never stopped");
nOut = au.out.length; au.anchorm(5, 5); au.rec(0);
check("auto-stop: nothing further until rec 0, and that rec 0 is silent", au.out.length === nOut);

// ---------------------------------------------------------------- v0.7 loop modes, cue, wander (D31-D34)
function player(mode, pathI) {
    var c = wire(load("motion.js")), ck = { t: 7000000 }; c.ck = ck; c.nowMs = function () { return ck.t; };
    c.size(szE); c.rate(rtE); c.gesture.apply(c, gMsg); c.path(pathI === undefined ? 6 : pathI); c.loop(mode);
    c.at = function (sec) { ck.t = c.t0 + sec * 1000; c.tick(); return lastMsg(c, 0, "motion"); };
    c.start = function () { c.on(1); c.t0 = ck.t; };
    return c;
}
function absPos(mo) { return [sa[0] + mo[0], sa[1] + mo[1]]; }
function near(a, b, tol) { return Math.abs(a[0] - b[0]) < tol && Math.abs(a[1] - b[1]) < tol; }
var drawnAt = function (tSec) { var best = reps[0]; reps.forEach(function (rp) { if (Math.abs(rp[0] - tSec) < Math.abs(best[0] - tSec)) best = rp; }); return [best[1], best[2]]; };
// loop 0 is v0.6
var l0 = player(0); l0.start();
var same06 = true; [0.3, 1.7, 2.5, 4.1, 4.7, 6.2].forEach(function (t) { clk.t = tStart + t * 1000; r.tick(); var a = lastMsg(r, 0, "motion"), b = l0.at(t); if (a[0] !== b[0] || a[1] !== b[1] || a[2] !== b[2]) same06 = false; });
check("loop 0 with wander 0 is bit-identical to v0.6 (gesture + glide back)", same06 && lastMsg(l0, 0, "traceopen") === null && lastMsg(l0, 0, "trace").length === 240);
// one-shot
var os = player(2); os.start();
check("one-shot: on 1 ARMS, the puck waits at the gesture's first point", os.shotArmed === 1 && near(absPos(os.at(0)), [2, 3], 1e-9) && near(absPos(os.at(3.3)), [2, 3], 1e-9));
var otr = lastMsg(os, 0, "traceopen");
check("one-shot: the trace is OPEN (traceopen, 120 points, first / last = the gesture's ends, no glide)", otr !== null && otr.length === 240 && near([sa[0] + otr[0], sa[1] + otr[1]], [2, 3], 1e-9) && near([sa[0] + otr[238], sa[1] + otr[239]], [5, 4.7856], 1e-9));
os.ck.t = os.t0 + 5000; os.cue(); os.t0 = os.ck.t;
var osWorst = 0; [0.5, 1.0, 1.6, 2.5, 3.5, 4.2].forEach(function (t) { var q = absPos(os.at(t)), w = drawnAt(t); osWorst = Math.max(osWorst, Math.abs(q[0] - w[0]), Math.abs(q[1] - w[1])); });
check("one-shot: cue plays the gesture once at the drawn speed (same rate as loop mode)", osWorst < 0.02, "max error " + (osWorst * 1000).toFixed(1) + " mm");
var endP = [5, 3 + 1.2 * 1.488];
check("one-shot: holds at the gesture's LAST point afterwards (no glide, no restart)", near(absPos(os.at(dur + 0.001)), endP, 1e-3) && near(absPos(os.at(dur + 3)), endP, 1e-9) && near(absPos(os.at(40)), endP, 1e-9));
os.cue(); os.t0 = os.ck.t;
check("one-shot: a second cue plays it again from the start", near(absPos(os.at(0)), [2, 3], 1e-9) && near(absPos(os.at(1.0)), [3.5, 3], 0.02));
os.loop(2); os.gesture.apply(os, gMsg); os.path(6);
check("one-shot: a scene recall re-sending loop / gesture / path does NOT re-arm a running shot", os.shotArmed === 0 && near(absPos(os.at(1.5)), [4.25, 3], 0.02));
os.gesture.apply(os, gMsg.map(function (v, i) { return i === 7 ? v + 0.01 : v; }));
check("one-shot: a NEW gesture re-arms (waits at its start)", os.shotArmed === 1);
os.rate(rtE * 3); os.cue(); os.t0 = os.ck.t; var q1 = absPos(os.at(0.4)); os.rate(rtE); var q2 = absPos(os.at(0.4));
check("one-shot: rate change mid-shot does not jump (the path clock rides MotionClock's re-base)", near(q1, q2, 1e-9));
var offc = player(2); offc.ui = []; offc.cue();
check("cue while off switches on through the UI and fires at once", offc.ui.join() === "on" && offc.isOn === 1 && offc.shotArmed === 0);
// palindrome
var pal = player(1); pal.start();
var palWorst = 0; [0.4, 1.2, 2.6, 3.9].forEach(function (t) { var f = absPos(pal.at(t)), bck = absPos(pal.at(2 * dur - t)), w = drawnAt(t);
    palWorst = Math.max(palWorst, Math.abs(f[0] - w[0]), Math.abs(f[1] - w[1]), Math.abs(f[0] - bck[0]), Math.abs(f[1] - bck[1])); });
check("palindrome: forward at the drawn speed, then the same points backward; period = 2 x duration", palWorst < 0.02 && near(absPos(pal.at(dur)), endP, 1e-3) && near(absPos(pal.at(2 * dur)), [2, 3], 1e-3) && near(absPos(pal.at(2 * dur + 1)), [3.5, 3], 0.02), "max error " + (palWorst * 1000).toFixed(1) + " mm");
var palStep = 0, pp0 = null; for (var ms = 0; ms < 2 * dur * 1000 * 2; ms += 16) { var pq = pal.at(ms / 1000); if (pp0) palStep = Math.max(palStep, Math.sqrt(Math.pow(pq[0] - pp0[0], 2) + Math.pow(pq[1] - pp0[1], 2))); pp0 = pq; }
check("palindrome: never glides or jumps (max step = one tick at the drawn 1.5 m/s)", palStep <= 1.5 * 0.016 * 1.05, "max step " + (palStep * 1000).toFixed(1) + " mm");
pal.cue(); pal.t0 = pal.ck.t;
check("cue in a looping mode restarts from the path's start", near(absPos(pal.at(0)), [2, 3], 1e-9));
pal.height(2); pal.cue(); pal.t0 = pal.ck.t;
var zf = pal.at(1.0)[2], zb = pal.at(2 * dur - 1.0)[2];
check("palindrome: z folds with the path", Math.abs(zf - zb) < 1e-9 && Math.abs(zf) > 0.1);
pal.height(0); pal.phase(90); pal.cue(); pal.t0 = pal.ck.t;
var phStart = absPos(pal.at(0)), phBack = absPos(pal.at(2 * (0.9 - 0.25) / rtE));
check("palindrome + phase: phase is a start offset inside the gesture, the fold stays at the gesture's end", near(phStart, drawnAt(0.25 / 0.9 * dur), 0.03) && near(phBack, phStart, 1e-6));
// the computed paths
var orb = player(2, 0); orb.size(6); orb.rate(0.5); orb.start();
var o0 = orb.at(1.3); orb.cue(); orb.t0 = orb.ck.t; var oq = orb.at(0.5), oe = orb.at(9);
check("one-shot orbit: waits at its start, one revolution on cue, holds back at the start", near(o0, [3, 0], 1e-9) && near(oq, [3 * Math.cos(Math.PI / 2), 3 * Math.sin(Math.PI / 2)], 1e-9) && near(oe, [3, 0], 1e-9));
var orbp = player(1, 0); orbp.size(6); orbp.rate(0.5); orbp.start();
check("palindrome orbit: reverses after one revolution", near(orbp.at(2.5), orbp.at(1.5), 1e-9) && lastMsg(orbp, 0, "trace").length === 64 && lastMsg(orbp, 0, "traceopen") === null);
var dr = player(2, 3); dr.start(); var dA = dr.at(2.0); dr.cue(); var dB = dr.at(2.0); var drl = player(0, 3); drl.start();
check("drift ignores loop mode and cue", dr.shotArmed === 1 && near(dA, dB, 1e-12) && near(dA, drl.at(2.0), 1e-12) && (dA[0] !== 0 || dA[1] !== 0));
// wander
var wa = player(0, 0); wa.size(6); wa.rate(0.5); wa.start();
var clean = wa.at(1.1).slice(); wa.wander(2); var noisy = wa.at(1.1), wmax = 0, wMoved = 0, prevW = null;
for (var ws = 0; ws < 4000; ws++) { var cw = wa.at(ws * 0.05), ang = 2 * Math.PI * 0.5 * ws * 0.05, ex = cw[0] - 3 * Math.cos(ang), ey = cw[1] - 3 * Math.sin(ang);
    wmax = Math.max(wmax, Math.abs(ex), Math.abs(ey)); if (prevW) wMoved = Math.max(wMoved, Math.abs(ex - prevW)); prevW = ex; }
check("wander: adds bounded noise (|offset| <= wander / 2) on top of the path, z untouched", (noisy[0] !== clean[0] || noisy[1] !== clean[1]) && noisy[2] === clean[2] && wmax <= 1 + 1e-9 && wmax > 0.2, "max offset " + wmax.toFixed(3) + " m of 1.000");
var w2 = player(0, 0); w2.size(6); w2.rate(0.5); w2.wander(2); w2.start();
var w3 = player(0, 0); w3.size(6); w3.rate(0.5); w3.wander(2); w3.seed(9); w3.start();
check("wander: deterministic per seed, different across seeds, never repeats cycle to cycle", near(w2.at(1.1), noisy, 1e-12) && !near(w3.at(1.1), noisy, 1e-6) && !near(w2.at(1.1), w2.at(3.1), 1e-6));
wa.wander(0);
check("wander 0 is bit-identical to no wander", wa.at(1.1)[0] === clean[0] && wa.at(1.1)[1] === clean[1]);
var ww = player(2); ww.wander(1.5); ww.start();
var wA = ww.at(1.0), wB = ww.at(2.0);
check("wander keeps moving while a one-shot waits for its cue", !near(wA, wB, 1e-6) && Math.abs(sa[0] + wA[0] - 2) <= 0.75 && Math.abs(sa[1] + wA[1] - 3) <= 0.75);
check("wander: the trace stays the clean path", JSON.stringify(lastMsg(w2, 0, "trace")) === JSON.stringify((function () { var c = player(0, 0); c.size(6); c.rate(0.5); c.start(); return lastMsg(c, 0, "trace"); })()));

// ---------------------------------------------------------------- dbap.js
function dbapState(setup) {
    var d = load("dbap.js");
    d.bang();                                   // venue() -> built-in Barnett layout (no Dict in node)
    d.srcxy(0.31, 0.64); d.srcz(1.25); d.width(3); d.decorr(0.5); d.air(0.35); d.hull(1);
    if (setup) setup(d);
    return d;
}
function snap(d) {
    return JSON.stringify([lastMsg(d, 0, "applyvalues"), lastMsg(d, 3, "applyvalues"), lastMsg(d, 4, "fcl"), lastMsg(d, 4, "fcr"),
                           lastMsg(d, 4, "depth"), lastMsg(d, 2, "zcue"), lastMsg(d, 2, "pos")]);
}
var base = dbapState();
var zero = dbapState(function (d) { d.motion(1.5, -2, 0.75); d.motion(0, 0, 0); });
check("dbap.js: motion 0 0 0 is BIT-IDENTICAL to no motion (gains L/R, fc, depth, z-cue, pos)", snap(base) === snap(zero));

var g = lastMsg(base, 0, "applyvalues"), ss = 0; g.forEach(function (v) { ss += v * v; });
var moved = dbapState(function (d) { d.motion(2.4, -1.5, 0); });
var equiv = dbapState(function (d) { d.srcxy(0.31 + 2.4 / 12.0, 0.64 - 1.5 / 15.0); });   // bbox 12 x 15 m
var ga = lastMsg(moved, 0, "applyvalues"), gb = lastMsg(equiv, 0, "applyvalues"), e = 0;
for (var i = 0; i < 8; i++) e = Math.max(e, Math.abs(ga[i] - gb[i]));
check("dbap.js: motion (2.4, -1.5) m == moving the anchor by the same metres", e < 1e-9, "max diff " + e.toExponential(1));
var mz = dbapState(function (d) { d.motion(0, 0, 0.75); }), sz = dbapState(function (d) { d.srcz(2.0); });
check("dbap.js: motion dz adds to srcZ for the solve AND the z-cue", snap(mz) === snap(sz));
var nxyCount = moved.out.filter(function (o) { return o[0] === 2 && o[1] === "nxy"; }).length;
check("dbap.js: motion never emits nxy (the stored anchor is untouched)", nxyCount === 0 && moved.srcNX === 0.31 && moved.srcNY === 0.64);
var far = dbapState(function (d) { d.motion(30, 30, 0); });
var gf = lastMsg(far, 0, "applyvalues"), finite = gf.every(function (v) { return isFinite(v); });
check("dbap.js: an offset far outside the hull stays finite (hull projection)", finite && lastMsg(far, 2, "dhull")[0] > 10);
var t2 = dbapState(function (d) { d.trace(1, 0, 0, 1, -1, 0, 0, -1); });
check("dbap.js: trace stores the polyline, bare trace clears it", t2.tracePts.length === 8 && (t2.trace(), t2.tracePts.length === 0));
var bad = dbapState(function (d) { d.motion(NaN, 1, 0); });
check("dbap.js: NaN offset is ignored", snap(bad) === snap(base));

// ---------------------------------------------------------------- dbap.js v0.6 (D27)
var mo = dbapState(); var n0 = mo.out.length;
mo.mouse(30 + 0.25 * 180, 30 + 0.5 * 240);
var moOut = mo.out.slice(n0).filter(function (o) { return o[0] === 2 && (o[1] === "nxy" || o[1] === "anchorm"); });
var am = lastMsg(mo, 2, "anchorm"), posM = lastMsg(mo, 2, "pos");
check("dbap.js: mouse emits nxy then anchorm (anchor metres = pos with no motion)", moOut.length === 2 && moOut[0][1] === "nxy" && moOut[1][1] === "anchorm" && Math.abs(am[0] - posM[0]) < 1e-12 && Math.abs(am[1] - posM[1]) < 1e-12, "anchorm " + am.join(" "));
var mm2 = dbapState(function (d) { d.motion(1.5, -2, 0); }); mm2.mouse(30 + 0.25 * 180, 30 + 0.5 * 240);
check("dbap.js: anchorm carries the ANCHOR, never the motion offset", lastMsg(mm2, 2, "anchorm").join() === am.join());
var st = dbapState(); n0 = st.out.length;
st.setanchor(am[0] + 1.234567, am[1] - 2.345678);
var nxys = st.out.slice(n0).filter(function (o) { return o[0] === 2 && o[1] === "nxy"; });
var backM = st.anchorM();
check("dbap.js: setanchor round-trips metres -> norm -> metres (1e-9) and emits exactly one nxy", nxys.length === 1 && Math.abs(backM[0] - am[0] - 1.234567) < 1e-9 && Math.abs(backM[1] - am[1] + 2.345678) < 1e-9);
var moved2 = dbapState(function (d) { d.srcxy(nxys[0][2], nxys[0][3]); });
check("dbap.js: setanchor solves exactly like srcxy at the same position", snap(st) === snap(moved2));
n0 = st.out.length; st.srcxy(nxys[0][2], nxys[0][3]);
check("dbap.js: the echoed srcxy emits nothing (no loop)", st.out.length === n0);
st.setanchor(-50, 99);
check("dbap.js: setanchor clamps to the bounding box; NaN is ignored", st.srcNX === 0 && st.srcNY === 1 && (st.setanchor(NaN, 1), st.srcNX === 0));
n0 = st.out.length; st.recstate(1);
var recDraw = st.out.slice(n0).filter(function (o) { return o[0] === 1 && o[1] === "write" && o[2] === "REC"; }).length;
n0 = st.out.length; st.recstate(1); var again = st.out.length - n0;
st.recstate(0);
var offDraw = st.out.slice(n0).filter(function (o) { return o[0] === 1 && o[1] === "write" && o[2] === "REC"; }).length;
check("dbap.js: recstate 1 draws REC on the plan, a repeat is a no-op, recstate 0 removes it", recDraw === 1 && again === 0 && offDraw === 0);
check("dbap.js: recstate / setanchor do not touch the gains of an untouched source", snap(dbapState(function (d) { d.recstate(1); d.recstate(0); })) === snap(base));

var to = dbapState(function (d) { d.traceopen(1, 0, 0, 1, -1, 0, 0, -1); }), tc = dbapState(function (d) { d.trace(1, 0, 0, 1, -1, 0, 0, -1); });
function traceSegs(d) { var n0 = d.out.length; d.bang(); var o = d.out.slice(n0), i0 = -1, n = 0;
    o.forEach(function (m, i) { if (m[0] === 1 && m[1] === "frgb" && m[2] === 150 && m[3] === 112 && m[4] === 48) i0 = i; });
    for (var i = i0 + 1; i < o.length && o[i][1] === "linesegment"; i++) n++; return n; }
check("dbap.js v0.7: trace closes the polyline (4 segments), traceopen leaves it open (3); a bare one clears", traceSegs(tc) === 4 && traceSegs(to) === 3 && (to.traceopen(), to.tracePts.length === 0));

// ---------------------------------------------------------------- venue-align.js (host, D23)
function alignRun(venueData) {
    var a = load("venue-align.js");
    a.Dict = function () { this.get = function (k) {
        var parts = k.split("::"), v = venueData;
        for (var i = 0; i < parts.length; i++) { if (v === null || typeof v !== "object" || !(parts[i] in v)) return null; v = v[parts[i]]; }
        return v; }; };
    return a;
}
function setvalues(a) {
    var last = {};
    a.out.forEach(function (o) { if (o[0] === 0 && o[1] === "setvalue") last[o[2]] = o[3]; });
    var r = []; for (var k = 1; k <= 8; k++) r.push(last[k]); return r;
}
var host = JSON.parse(fs.readFileSync(path.join(GEN, "barnett-dbap.maxpat"), "utf8")).patcher.boxes
    .map(function (b) { return b.box; }).filter(function (b) { return b.text === "dict venue @embed 1"; })[0].data;
var al = alignRun(host); al.loadbang();
check("venue-align.js: embedded venue carries delayMs 0 on all 8 speakers -> setvalue N 0 (bypass)",
      Object.keys(host.speakers).every(function (k) { return host.speakers[k].delayMs === 0; }) && setvalues(al).join() === "0,0,0,0,0,0,0,0");
check("venue-align.js: status reads 'align off'", String(lastMsg(al, 1, "set")[0]).indexOf("align off") >= 0);
var legacy = alignRun({ name: "old", speakers: { s1: { x: 0, y: 0, z: 0 } } }); legacy.venue();
check("venue-align.js: a venue without delayMs keys -> all 0", setvalues(legacy).join() === "0,0,0,0,0,0,0,0");
var dv = { name: "delayed", speakers: {} };
[0, 1.5, 4.25, 10, 80, -3, 0.01, 50].forEach(function (ms, i) { dv.speakers["s" + (i + 1)] = { delayMs: ms }; });
var a2 = alignRun(dv); a2.venue();
check("venue-align.js: samples = round(ms * sr / 1000) at 48 kHz, rail 0..50 ms", setvalues(a2).join() === "0,72,204,480,2400,0,0,2400", setvalues(a2).join());
a2.sr(96000);
check("venue-align.js: sr 96000 resends doubled sample counts", setvalues(a2).join() === "0,144,408,960,4800,0,1,4800", setvalues(a2).join());
a2.sr(192000);
check("venue-align.js: 50 ms at 192 kHz fits the mc.delay~ 9600 memory", Math.max.apply(null, setvalues(a2)) === 9600);

console.log(fails === 0 ? "\nALL PASS" : "\n" + fails + " FAILED");
process.exit(fails === 0 ? 0 : 1);
