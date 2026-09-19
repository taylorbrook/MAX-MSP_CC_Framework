// dbap.js -- mono DBAP solver + lcd room-plan renderer (barnett-dbap v0.2, per-instance)
// Port of DbapSolver.cpp from O-Octagon v1.13.0 (Lossius / Baltazar / de la Hogue,
// ICMC 2009, 2011-04-14 revised equations). All constants verbatim (context.md D10).
//
// inlet 0 messages:
//   mouse x y        lcd outlet 0 (pixels, local to lcd) -> puck position
//   srcxy nx ny      normalised 0..1 position over the speaker bounding box
//   srcz f           metres above the sloped audience ear plane
//   rolloff f        dB per doubling of distance (3..12, default 4)
//   blur f           spatial blur 0..1 (default 0.03)
//   weights l1..l8   per-speaker weights 0..1 (multislider list)
//   trims t1..t8     per-speaker trims in dB, applied after DBAP normalisation (scene-stored)
//   venue            re-read the embedded "venue" dict
//   bang             solve + redraw
//
// outlet 0: "applyvalues g1 .. g8"  -> mc.sig~ @chans 8   (gain lane, sum g^2 = 1)
// outlet 1: lcd drawing messages     -> lcd
// outlet 2: readouts: "pos x_m y_m z_abs", "nxy nx ny" (mouse only -> pattr srcpos), "gains g1 .. g8"

inlets = 1;
outlets = 3;

var NSPK = 8;

// ---- venue (O-Octagon defaults, section OQ4 traced layout) -----------------
// metres; origin front-left, x left->right (audience view), y stage->rear
var DEFAULT_SPK = [
    [0.50, 4.50, 4.50],   // 1 front-left
    [12.50, 4.50, 4.50],  // 2 front-right
    [12.50, 9.85, 4.70],  // 3 right-2nd
    [12.50, 16.00, 5.10], // 4 right-3rd
    [9.80, 19.50, 5.40],  // 5 back-right
    [3.20, 19.50, 5.40],  // 6 back-left
    [0.50, 16.00, 5.10],  // 7 left-3rd
    [0.50, 9.85, 4.70]    // 8 left-2nd
];
var DEFAULT_RAKE_FRONT = 1.10;
var DEFAULT_RAKE_REAR = 3.20;

var spk = [];          // [[x,y,z], ...]
var rakeFront = DEFAULT_RAKE_FRONT;
var rakeRear = DEFAULT_RAKE_REAR;
var bbMinX = 0, bbMaxX = 1, bbMinY = 0, bbMaxY = 1;
var rigScale = 1;
var venueLoaded = false;

// ---- lcd geometry ------------------------------------------------------------
var LCD_W = 240;
var LCD_H = 300;
var MARGIN = 30;
var pxPerM = 20;       // recomputed from the bounding box so any venue fits

// ---- source state ------------------------------------------------------------
var srcNX = 0.5;
var srcNY = 0.5;
var srcZ = 0.0;
var rolloffDb = 4.0;
var blurAmt = 0.03;
var wts = [1, 1, 1, 1, 1, 1, 1, 1];
var trimsDb = [0, 0, 0, 0, 0, 0, 0, 0];
var gains = [0, 0, 0, 0, 0, 0, 0, 0];

// ---- colours (lcd rgb 0..255) --------------------------------------------------
var COL_BG = [22, 22, 26];
var COL_BOX = [70, 70, 80];
var COL_TEXT = [200, 200, 210];
var COL_SPK_DIM = [55, 60, 75];
var COL_SPK_HOT = [90, 200, 255];
var COL_PUCK = [255, 185, 60];
var COL_PUCK_RING = [255, 235, 190];

function setDefaultVenue() {
    spk = [];
    for (var i = 0; i < NSPK; i++) {
        spk.push([DEFAULT_SPK[i][0], DEFAULT_SPK[i][1], DEFAULT_SPK[i][2]]);
    }
    rakeFront = DEFAULT_RAKE_FRONT;
    rakeRear = DEFAULT_RAKE_REAR;
    deriveVenue();
}

function deriveVenue() {
    bbMinX = spk[0][0]; bbMaxX = spk[0][0];
    bbMinY = spk[0][1]; bbMaxY = spk[0][1];
    var cx = 0, cy = 0, cz = 0;
    for (var i = 0; i < NSPK; i++) {
        var s = spk[i];
        if (s[0] < bbMinX) bbMinX = s[0];
        if (s[0] > bbMaxX) bbMaxX = s[0];
        if (s[1] < bbMinY) bbMinY = s[1];
        if (s[1] > bbMaxY) bbMaxY = s[1];
        cx += s[0]; cy += s[1]; cz += s[2];
    }
    cx /= NSPK; cy /= NSPK; cz /= NSPK;
    var acc = 0;
    for (var j = 0; j < NSPK; j++) {
        var dx = spk[j][0] - cx, dy = spk[j][1] - cy, dz = spk[j][2] - cz;
        acc += dx * dx + dy * dy + dz * dz;
    }
    rigScale = Math.sqrt(acc / NSPK);
    if (bbMaxX - bbMinX < 1e-6) bbMaxX = bbMinX + 1;
    if (bbMaxY - bbMinY < 1e-6) bbMaxY = bbMinY + 1;
    var sx = (LCD_W - 2 * MARGIN) / (bbMaxX - bbMinX);
    var sy = (LCD_H - 2 * MARGIN) / (bbMaxY - bbMinY);
    pxPerM = Math.min(sx, sy);
}

// Read the embedded "venue" dict. Falls back to the defaults on any problem.
function venue() {
    var ok = false;
    try {
        var d = new Dict("venue");
        var next = [];
        var rf = d.get("rake::front");
        var rr = d.get("rake::rear");
        for (var i = 1; i <= NSPK; i++) {
            var base = "speakers::s" + i + "::";
            var x = d.get(base + "x");
            var y = d.get(base + "y");
            var z = d.get(base + "z");
            if (typeof x !== "number" || typeof y !== "number" || typeof z !== "number") {
                throw new Error("speaker s" + i + " incomplete");
            }
            next.push([x, y, z]);
        }
        if (typeof rf !== "number" || typeof rr !== "number") {
            throw new Error("rake incomplete");
        }
        spk = next;
        rakeFront = rf;
        rakeRear = rr;
        deriveVenue();
        ok = true;
    } catch (e) {
        post("dbap.js: venue dict unavailable (" + e.message + "), using built-in Barnett layout\n");
        setDefaultVenue();
    }
    venueLoaded = true;
    if (ok) post("dbap.js: venue loaded from dict, rigScale " + rigScale.toFixed(3) + " m\n");
    solveAndDraw();
}

// ---- geometry helpers ----------------------------------------------------------
function earHeight(ym) {
    var t = (ym - bbMinY) / (bbMaxY - bbMinY);   // linear in y, extrapolated outside bbox
    return rakeFront + (rakeRear - rakeFront) * t;
}

function mToPx(xm, ym) {
    return [MARGIN + (xm - bbMinX) * pxPerM, MARGIN + (ym - bbMinY) * pxPerM];
}

function clamp01(v) {
    if (v < 0) return 0;
    if (v > 1) return 1;
    return v;
}

// ---- DBAP solve (DbapSolver.cpp port) ----------------------------------------------
function solve() {
    var xs = bbMinX + srcNX * (bbMaxX - bbMinX);
    var ys = bbMinY + srcNY * (bbMaxY - bbMinY);
    var zs = earHeight(ys) + srcZ;

    var rs = blurAmt * blurAmt * 6.0 * rigScale;
    if (rs > 200.0) rs = 200.0;
    var rs2 = rs * rs;

    var a = rolloffDb / (20.0 * Math.log(2) / Math.LN10);   // R / (20*log10(2))

    var t = [];
    var denom = 0;
    for (var i = 0; i < NSPK; i++) {
        var dx = spk[i][0] - xs, dy = spk[i][1] - ys, dz = spk[i][2] - zs;
        var d = Math.sqrt(dx * dx + dy * dy + dz * dz + rs2);
        if (d < 0.05) d = 0.05;
        var ti = Math.pow(d, -a);
        t.push(ti);
        denom += wts[i] * wts[i] * ti * ti;
    }
    if (denom < 1e-20) {
        for (var k = 0; k < NSPK; k++) gains[k] = 0;   // silence, never NaN
    } else {
        var kk = 1.0 / Math.sqrt(denom);
        for (var m = 0; m < NSPK; m++) gains[m] = kk * wts[m] * t[m];
    }
    // per-speaker trims (dB) sit outside the normalisation on purpose: they correct the room
    for (var n = 0; n < NSPK; n++) gains[n] = gains[n] * Math.pow(10, trimsDb[n] / 20);
    outlet(0, ["applyvalues"].concat(gains));
    outlet(2, "pos", xs, ys, zs);
    outlet(2, ["gains"].concat(gains));
}

// ---- lcd drawing --------------------------------------------------------------------
function rgb(name, c) {
    outlet(1, name, c[0], c[1], c[2]);
}

function draw() {
    outlet(1, "clear");
    outlet(1, "pensize", 1, 1);

    // bounding box of the array
    var tl = mToPx(bbMinX, bbMinY);
    var br = mToPx(bbMaxX, bbMaxY);
    rgb("frgb", COL_BOX);
    outlet(1, "framerect", Math.round(tl[0]), Math.round(tl[1]), Math.round(br[0]), Math.round(br[1]));

    // stage marker
    outlet(1, "font", "Arial", 9);
    rgb("frgb", COL_TEXT);
    outlet(1, "moveto", Math.round((tl[0] + br[0]) / 2) - 16, 12);
    outlet(1, "write", "STAGE");

    // speakers: fill brightness follows the solved gain
    var R = 8;
    for (var i = 0; i < NSPK; i++) {
        var p = mToPx(spk[i][0], spk[i][1]);
        var g = Math.sqrt(gains[i]);   // perceptual-ish lift so quiet speakers stay visible
        var cr = Math.round(COL_SPK_DIM[0] + (COL_SPK_HOT[0] - COL_SPK_DIM[0]) * g);
        var cg = Math.round(COL_SPK_DIM[1] + (COL_SPK_HOT[1] - COL_SPK_DIM[1]) * g);
        var cb = Math.round(COL_SPK_DIM[2] + (COL_SPK_HOT[2] - COL_SPK_DIM[2]) * g);
        var l = Math.round(p[0] - R), tp = Math.round(p[1] - R);
        outlet(1, "paintoval", l, tp, l + 2 * R, tp + 2 * R, cr, cg, cb);
        rgb("frgb", COL_TEXT);
        outlet(1, "moveto", Math.round(p[0]) - 3, Math.round(p[1]) + 4);
        outlet(1, "write", i + 1);
    }

    // source puck
    var xs = bbMinX + srcNX * (bbMaxX - bbMinX);
    var ys = bbMinY + srcNY * (bbMaxY - bbMinY);
    var q = mToPx(xs, ys);
    var PR = 6;
    var ql = Math.round(q[0] - PR), qt = Math.round(q[1] - PR);
    outlet(1, "paintoval", ql, qt, ql + 2 * PR, qt + 2 * PR, COL_PUCK[0], COL_PUCK[1], COL_PUCK[2]);
    rgb("frgb", COL_PUCK_RING);
    outlet(1, "frameoval", ql - 3, qt - 3, ql + 2 * PR + 3, qt + 2 * PR + 3);
}

function solveAndDraw() {
    solve();
    draw();
}

// ---- message handlers ------------------------------------------------------------------
function mouse(x, y) {
    var w = (bbMaxX - bbMinX) * pxPerM;
    var h = (bbMaxY - bbMinY) * pxPerM;
    srcNX = clamp01((x - MARGIN) / w);
    srcNY = clamp01((y - MARGIN) / h);
    solveAndDraw();
    // publish for the scene store (pattr srcpos); it echoes back as srcxy, which is a no-op below
    outlet(2, "nxy", srcNX, srcNY);
}

// Scene recall / pattr echo. Never emits nxy, so mouse -> pattr -> srcxy cannot loop.
function srcxy(nx, ny) {
    nx = clamp01(nx);
    ny = clamp01(ny);
    if (Math.abs(nx - srcNX) < 1e-9 && Math.abs(ny - srcNY) < 1e-9) return;
    srcNX = nx;
    srcNY = ny;
    solveAndDraw();
}

function trims() {
    var a = arrayfromargs(arguments);
    for (var i = 0; i < NSPK; i++) {
        var v = (i < a.length) ? a[i] : 0;
        if (v < -60) v = -60;
        if (v > 24) v = 24;
        trimsDb[i] = v;
    }
    solveAndDraw();
}

function srcz(v) {
    srcZ = v;
    solveAndDraw();
}

function rolloff(v) {
    if (v < 3) v = 3;
    if (v > 12) v = 12;
    rolloffDb = v;
    solveAndDraw();
}

function blur(v) {
    blurAmt = clamp01(v);
    solveAndDraw();
}

function weights() {
    var a = arrayfromargs(arguments);
    for (var i = 0; i < NSPK; i++) {
        var v = (i < a.length) ? a[i] : 0;
        wts[i] = clamp01(v);
    }
    solveAndDraw();
}

function list() {
    // a bare 8-element list is treated as weights (multislider default output)
    weights.apply(this, arrayfromargs(arguments));
}

function bang() {
    if (!venueLoaded) {
        venue();
    } else {
        rgb("brgb", COL_BG);
        solveAndDraw();
    }
}

function loadbang() {
    rgb("brgb", COL_BG);
    venue();
}

function anything() {
    post("dbap.js: unknown message " + messagename + "\n");
}

setDefaultVenue();
