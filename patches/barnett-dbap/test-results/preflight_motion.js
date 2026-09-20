// preflight_motion.js -- node pre-flight for barnett-dbap v0.5 (motion.js + dbap.js motion path).
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
var worst = 0, worstRow = "";
ref.forEach(function (row) {
    var f = row.split(" ").map(Number);
    m.seed(f[0]); m.ensureSeeded(); m.path(f[1]);
    if (f[2] === 1) { m.size(9.5); m.ratio(0.4); m.angle(37); m.height(2.5); m.phase(110); }
    else { m.size(6); m.ratio(1); m.angle(0); m.height(0); m.phase(0); }
    var p = m.evaluate(f[3]);
    for (var k = 0; k < 3; k++) { var e = Math.abs(p[k] - f[4 + k]); if (e > worst) { worst = e; worstRow = row; } }
});
// the plugin is float32, the port is double: agreement to float precision on up to 12 m values
// Tolerance: the worst rows are Drift at large cycle counts, where the plugin's float32 argument
// (n * 8 in the top fbm octave) quantises at ~6e-5 and the noise slope turns that into ~2e-4 m.
check("evaluate() matches MotionPath.h on " + ref.length + " points (6 paths, 3 seeds)", worst < 5e-4, "max |err| " + worst.toExponential(2) + " m at [" + worstRow + "]");
var worstCyc = 0;
ref.forEach(function (row) {
    var f = row.split(" ").map(Number);
    if (f[1] === 3) return;
    m.seed(f[0]); m.ensureSeeded(); m.path(f[1]);
    if (f[2] === 1) { m.size(9.5); m.ratio(0.4); m.angle(37); m.height(2.5); m.phase(110); }
    else { m.size(6); m.ratio(1); m.angle(0); m.height(0); m.phase(0); }
    var p = m.evaluate(f[3]);
    for (var k = 0; k < 3; k++) worstCyc = Math.max(worstCyc, Math.abs(p[k] - f[4 + k]));
});
check("the five cyclic paths match to float32 precision", worstCyc < 5e-6, "max |err| " + worstCyc.toExponential(2) + " m");

// ---------------------------------------------------------------- closure, extent
m = load("motion.js");
var names = ["orbit", "figure8", "sweep", "drift", "pendulum", "spiral"];
[0, 1, 2, 4, 5].forEach(function (pi) {
    m.path(pi); m.size(6); m.ratio(0.7); m.angle(0); m.height(1.5); m.phase(40);
    var a = m.evaluate(0), b = m.evaluate(1), c = m.evaluate(5);
    var d = Math.max(Math.abs(a[0] - b[0]), Math.abs(a[1] - b[1]), Math.abs(a[2] - b[2]), Math.abs(a[0] - c[0]), Math.abs(a[1] - c[1]));
    var mx = 0, my = 0, mz = 0;
    for (var k = 0; k < 7200; k++) { var p = m.evaluate(k / 7200); mx = Math.max(mx, Math.abs(p[0])); my = Math.max(my, Math.abs(p[1])); mz = Math.max(mz, Math.abs(p[2])); }
    check(names[pi] + ": closes after one cycle", d < 1e-9, "gap " + d.toExponential(1));
    check(names[pi] + ": max |x| = size / 2", Math.abs(mx - 3) < 1e-3 && my <= 3 * 0.7 + 1e-9 && mz <= 1.5 + 1e-9, "x " + mx.toFixed(4) + " y " + my.toFixed(4) + " z " + mz.toFixed(4));
});
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
