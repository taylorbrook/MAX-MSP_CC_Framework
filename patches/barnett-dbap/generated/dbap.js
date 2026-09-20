// dbap.js -- DBAP solver + lcd room-plan renderer (barnett-dbap v0.5, per-instance)
// Port of DbapSolver.cpp + SourceShaper.cpp from O-Octagon v1.13.0 (Lossius / Baltazar /
// de la Hogue, ICMC 2009, 2011-04-14 revised equations). All constants verbatim
// (context.md D10, D18).
//
// v0.3: stereo width. The puck is shaped into TWO sub-points (left / right) by
// SourceShaper::shapeAt (steps 2-6): bearing from the rig centroid, spread faded to zero
// within rFade = 0.05 * rigScale of the centroid, left-hand perpendicular n^, each sub-point at
// its own ear height. Each sub-point gets its own DBAP solve; the patch renders
// y_i = vL_i * sL + vR_i * sR with sL / sR the two feeds at 0.5 (GainStage.cpp).
//
// v0.4: hull + air (D19). The 8 speakers' floor projection is hulled (ConvexHull2D.cpp: Andrew's
// monotone chain, collinear points popped). A sub-point OUTSIDE the hull is solved at its nearest
// boundary point and trimmed by -hull * dHull dB (floor -24 dB) (HullProcessor.h hullTrimGain).
// The z-cue (GainStage.cpp v1.3.0) trims each sub-point by (invK_z / invK_0)^2.5 clamped to +-6 dB,
// invK_0 being the same solve with srcZ stripped, so it is exactly 1 at srcZ = 0. The air filter's
// cutoff is driven by the UNPROJECTED sub-point's planar distance from the rig centroid less a
// near field of 0.1 rigScale: fc = 20 kHz * 2^(-air * dAir / (0.2 rigScale)), floor 500 Hz. The
// filter itself (one-pole TPT lowpass per feed) lives in the gen~; fc 0 means "skip" (air = 0 or
// inside the near field), which is the plugin's bit-transparent branch.
//
// v0.5: motion (D21). A separate dbap-motion module sends an ANCHOR-RELATIVE offset in metres
// ("motion dx dy dz"). It is added to the puck's metres AFTER normalised -> metres and BEFORE
// shaping / hull / air (GainStage.cpp updateControl, the plugin's insertion point); dz adds to
// srcZ ONCE and that effective Z reaches both consumers, the sub-point heights and the z-cue
// reference solve. The stored anchor (srcpos) never changes. "motion 0 0 0" is bit-identical to
// no motion. The plan shows the anchor as a hollow ring, the moving puck solid, and the path
// ("trace", one cycle in metres) around the anchor; Drift has no trace and gets a short tail.
//
// inlet 0 messages:
//   mouse x y        lcd outlet 0 (pixels, local to lcd) -> puck position
//   srcxy nx ny      normalised 0..1 position over the speaker bounding box
//   srcz f           metres above the sloped audience ear plane
//   rolloff f        dB per doubling of distance (3..12, default 4)
//   blur f           spatial blur 0..1 (default 0.03)
//   width f          stereo spread in metres between the sub-points (0..12, default 0)
//   decorr f         decorrelator amount 0..1 (default 0)
//   air f            air absorption amount 0..1 (default 0.35; 0 = filter skipped)
//   hull f           outside-hull attenuation, dB per metre 0..3 (default 1; 0 = no trim)
//   weights l1..l8   per-speaker weights 0..1 (multislider list)
//   trims t1..t8     per-speaker trims in dB, applied after DBAP normalisation (scene-stored)
//   motion dx dy dz  anchor-relative offset in metres from dbap-motion (third inlet)
//   trace x1 y1 ..   one cycle of the motion path, metres, anchor-relative; bare "trace" clears
//   venue            re-read the embedded "venue" dict (also broadcast by the host after a read)
//   bang             solve + redraw
//
// outlet 0: "applyvalues g1 .. g8"  -> mc.sig~ @chans 8   LEFT sub-point lane (sum g^2 = 1)
// outlet 1: lcd drawing messages     -> lcd
// outlet 2: readouts: "pos x_m y_m z_abs", "nxy nx ny" (mouse only -> pattr srcpos),
//           "weff w_m", "gains g1 .. g8" (L), "gainsr g1 .. g8" (R),
//           "airhz fcL fcR" (0 = skipped), "dhull dL dR" (metres outside the hull), "zcue cL cR"
// outlet 3: "applyvalues g1 .. g8"  -> mc.sig~ @chans 8   RIGHT sub-point lane
// outlet 4: -> gen~ Params: "depth d" (decorr * min(wEff / 2 m, 1)), "fcl hz", "fcr hz"
//           (air cutoff per feed, 0 = skip; the gen~ applies the 0.45 fs Nyquist ceiling)

inlets = 1;
outlets = 5;

var NSPK = 8;

// ---- SourceShaper.h / Decorrelator.h constants (verbatim) ----------------------
var K_FADE_FRACTION = 0.05;        // rFade = 0.05 * rigScale
var K_BEARING_EPSILON = 1.0e-6;
var K_FULL_DEPTH_WIDTH_M = 2.0;    // depth reaches the dialled decorr at wEff = 2 m

// ---- HullProcessor.h / ConvexHull2D.h / GainStage.cpp constants (verbatim) -----
var K_TRIM_FLOOR_DB = -24.0;
var K_AIR_REF_FRACTION = 0.2;      // dRef = 0.2 * rigScale: one octave per dRef at air = 1
var K_AIR_NEAR_FRACTION = 0.1;     // near field = 0.1 * rigScale: filter skipped inside it
var K_AIR_CEILING_HZ = 20000.0;
var K_AIR_FLOOR_HZ = 500.0;
var K_ZCUE_EXPONENT = 2.5;
var K_ZCUE_MIN_GAIN = 0.5011872;   // -6 dB
var K_ZCUE_MAX_GAIN = 1.9952623;   // +6 dB
var EPS_DEDUP = 1.0e-4;
var EPS_ONEDGE = 1.0e-3;
var EPS_LEN2 = 1.0e-12;

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
var centX = 0, centY = 0;   // rig centroid (x, y) -- the bearing origin (SourceShaper step 2)
var rigScale = 1;
var venueLoaded = false;
var hullPts = [];           // CCW hull of the speakers' floor projection: [[x, y], ...]
var hullEpsCross = 0;       // 1e-6 * spanX * spanY (an AREA tolerance, scaled to the room)

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
var widthM = 0.0;
var decorrAmt = 0.0;
var airAmt = 0.35;
var hullAtten = 1.0;
var fcL = 0, fcR = 0;          // last air cutoffs in Hz (0 = skipped)
var dHullL = 0, dHullR = 0;    // metres outside the hull per sub-point
var trimDbMin = 0;             // the larger of the two hull attenuations, in dB (for the plan)
var wts = [1, 1, 1, 1, 1, 1, 1, 1];
var trimsDb = [0, 0, 0, 0, 0, 0, 0, 0];
var gainsL = [0, 0, 0, 0, 0, 0, 0, 0];
var gainsR = [0, 0, 0, 0, 0, 0, 0, 0];
var sub = null;        // last shape() result: {lx, ly, lz, rx, ry, rz, weff, nx, ny}

// ---- motion (v0.5, D21) --------------------------------------------------------------
var motX = 0.0, motY = 0.0, motZ = 0.0;   // anchor-relative offset, metres
var zEff = 0.0;                           // srcZ + motZ: the ONE effective Z both consumers read
var tracePts = [];                        // [x1, y1, x2, y2, ...] metres, anchor-relative
var tailPts = [];                         // recent absolute positions (Drift: no closed trace)
var TAIL_MAX = 48;                        // about 0.8 s of 60 Hz ticks
var DRAW_MIN_MS = 30;                     // motion ticks redraw the plan at most ~33 fps
var lastDrawMs = 0;

// ---- colours (lcd rgb 0..255) --------------------------------------------------
var COL_BG = [22, 22, 26];
var COL_BOX = [70, 70, 80];
var COL_TEXT = [200, 200, 210];
var COL_SPK_DIM = [55, 60, 75];
var COL_SPK_HOT = [90, 200, 255];
var COL_PUCK = [255, 185, 60];
var COL_PUCK_RING = [255, 235, 190];
var COL_AXIS = [255, 210, 120];
var COL_HULL = [96, 104, 128];
var COL_INFO = [150, 170, 190];
var COL_TRACE = [150, 112, 48];
var COL_ANCHOR = [200, 150, 60];

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
    centX = cx;
    centY = cy;
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
    buildHull();
}

// ---- ConvexHull2D.cpp port ---------------------------------------------------------------
function cross2(ax, ay, bx, by) {
    return ax * by - ay * bx;
}

// Andrew's monotone chain over the speakers' (x, y). The pop test is `<= epsCross`, so COLLINEAR
// points are popped (speakers 3 and 8 of the traced layout are on-edge, not vertices).
function buildHull() {
    hullPts = [];
    var minX = spk[0][0], maxX = spk[0][0], minY = spk[0][1], maxY = spk[0][1];
    for (var i = 0; i < NSPK; i++) {
        if (spk[i][0] < minX) minX = spk[i][0];
        if (spk[i][0] > maxX) maxX = spk[i][0];
        if (spk[i][1] < minY) minY = spk[i][1];
        if (spk[i][1] > maxY) maxY = spk[i][1];
    }
    hullEpsCross = 1.0e-6 * (maxX - minX) * (maxY - minY);

    // step 0: deduplicate (lowest speaker index kept)
    var pts = [];
    for (var a = 0; a < NSPK; a++) {
        var dup = false;
        for (var b = 0; b < pts.length; b++) {
            var ex = spk[a][0] - pts[b][0], ey = spk[a][1] - pts[b][1];
            if (ex * ex + ey * ey < EPS_DEDUP * EPS_DEDUP) dup = true;
        }
        if (!dup) pts.push([spk[a][0], spk[a][1]]);
    }
    if (pts.length === 1) {
        hullPts = [pts[0]];
        return;
    }

    // step 1: sort by (x, then y)
    pts.sort(function (p, q) {
        if (p[0] < q[0]) return -1;
        if (q[0] < p[0]) return 1;
        if (p[1] < q[1]) return -1;
        if (q[1] < p[1]) return 1;
        return 0;
    });

    // step 2: monotone chain
    var chain = [];
    function pops(c) {
        var k = chain.length;
        return cross2(chain[k - 1][0] - chain[k - 2][0], chain[k - 1][1] - chain[k - 2][1],
                      c[0] - chain[k - 2][0], c[1] - chain[k - 2][1]) <= hullEpsCross;
    }
    var n = pts.length;
    for (var lo = 0; lo < n; lo++) {
        while (chain.length >= 2 && pops(pts[lo])) chain.pop();
        chain.push(pts[lo]);
    }
    var lowerEnd = chain.length + 1;
    for (var up = n - 2; up >= 0; up--) {
        while (chain.length >= lowerEnd && pops(pts[up])) chain.pop();
        chain.push(pts[up]);
    }
    chain.pop();   // the chain closes on its own first point
    if (chain.length > NSPK) chain.length = NSPK;
    hullPts = chain;

    // winding: the inside test needs CCW; measure the signed area and reverse once if needed
    if (hullPts.length >= 3) {
        var area2 = 0;
        for (var h = 0; h < hullPts.length; h++) {
            var nx = hullPts[(h + 1) % hullPts.length];
            area2 += cross2(hullPts[h][0], hullPts[h][1], nx[0], nx[1]);
        }
        if (area2 < 0) hullPts.reverse();
    }
}

function nearestOnSegment(a, b, px, py) {
    var abx = b[0] - a[0], aby = b[1] - a[1];
    var ab2 = abx * abx + aby * aby;
    var tRaw = ((px - a[0]) * abx + (py - a[1]) * aby) / Math.max(ab2, EPS_LEN2);
    var t = Math.min(1.0, Math.max(0.0, tRaw));
    return [a[0] + t * abx, a[1] + t * aby];
}

function hullInside(px, py) {
    var count = hullPts.length;
    if (count <= 0) return false;
    if (count === 1) {
        return Math.sqrt((px - hullPts[0][0]) * (px - hullPts[0][0]) + (py - hullPts[0][1]) * (py - hullPts[0][1])) < EPS_ONEDGE;
    }
    if (count === 2) {
        var q = nearestOnSegment(hullPts[0], hullPts[1], px, py);
        return Math.sqrt((px - q[0]) * (px - q[0]) + (py - q[1]) * (py - q[1])) < EPS_ONEDGE;
    }
    for (var i = 0; i < count; i++) {
        var a = hullPts[i], b = hullPts[(i + 1) % count];
        if (cross2(b[0] - a[0], b[1] - a[1], px - a[0], py - a[1]) < -hullEpsCross) return false;
    }
    return true;
}

// Nearest point on the hull boundary and its distance: {x, y, d}
function hullProject(px, py) {
    var count = hullPts.length;
    if (count <= 0) return { x: px, y: py, d: 0 };
    var best = hullPts[0], bestD = Number.MAX_VALUE;
    var edges = (count === 2) ? 1 : count;
    if (count === 1) edges = 0;
    for (var i = 0; i < edges; i++) {
        var q = nearestOnSegment(hullPts[i], hullPts[(i + 1) % count], px, py);
        var d = Math.sqrt((px - q[0]) * (px - q[0]) + (py - q[1]) * (py - q[1]));
        if (d < bestD) { bestD = d; best = q; }
    }
    if (count === 1) bestD = Math.sqrt((px - best[0]) * (px - best[0]) + (py - best[1]) * (py - best[1]));
    return { x: best[0], y: best[1], d: bestD };
}

// ---- HullProcessor.h port ------------------------------------------------------------------
function hullTrimGain(atten, dHull) {
    var attenDb = -(atten * dHull);
    if (attenDb < K_TRIM_FLOOR_DB) attenDb = K_TRIM_FLOOR_DB;
    return Math.pow(10, attenDb / 20);   // exactly 1 at atten * dHull = 0
}

function airDistanceMetres(px, py) {
    var dx = px - centX, dy = py - centY;
    var d = Math.sqrt(dx * dx + dy * dy) - K_AIR_NEAR_FRACTION * rigScale;
    return d > 0 ? d : 0;
}

// Cutoff in Hz, or 0 when the filter is skipped (air = 0, or inside the near field). The 0.45 fs
// Nyquist ceiling is applied in the gen~, which knows the sample rate.
function airCutoffHz(amount, dAir) {
    if (!(amount > 0) || !(dAir > 0)) return 0;
    var dRef = K_AIR_REF_FRACTION * rigScale;
    if (!(dRef > 0)) return K_AIR_CEILING_HZ;
    var fc = K_AIR_CEILING_HZ * Math.pow(2, -(amount * dAir) / dRef);
    if (fc < K_AIR_FLOOR_HZ) fc = K_AIR_FLOOR_HZ;
    if (fc > K_AIR_CEILING_HZ) fc = K_AIR_CEILING_HZ;
    return fc;
}

function zCueGain(invK, invKRef) {
    if (!(invK > 0) || !(invKRef > 0)) return 1.0;
    var cue = Math.pow(invK / invKRef, K_ZCUE_EXPONENT);
    if (cue < K_ZCUE_MIN_GAIN) return K_ZCUE_MIN_GAIN;
    if (cue > K_ZCUE_MAX_GAIN) return K_ZCUE_MAX_GAIN;
    return cue;
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

// ---- SourceShaper::shapeAt port (steps 2-6) -------------------------------------
// px, py: puck in metres. Returns the two sub-points (metres, absolute z) and wEff.
function shape(px, py) {
    // step 2: bearing from the rig centroid
    var bx = px - centX, by = py - centY;
    var bLen = Math.sqrt(bx * bx + by * by);

    // step 3: fade the spread to zero near the centroid (avoids the 180 deg flip jump)
    var rFade = K_FADE_FRACTION * rigScale;
    var fadeRatio = bLen / rFade;
    var fade = rFade > K_BEARING_EPSILON ? (fadeRatio < 1.0 ? fadeRatio : 1.0) : 0.0;
    var wEff = widthM * fade;

    // step 4: unit bearing (fallback (0,-1) = toward the stage) and its left-hand perpendicular
    var bhx, bhy;
    if (bLen < K_BEARING_EPSILON) { bhx = 0.0; bhy = -1.0; } else { bhx = bx / bLen; bhy = by / bLen; }
    var nhx = -bhy, nhy = bhx;    // n^ = (-b^.y, b^.x): puck downstage -> n^ = (1,0) = audience right

    // step 5: the two sub-points
    var half = 0.5 * wEff;
    var lx = px - half * nhx, ly = py - half * nhy;
    var rx = px + half * nhx, ry = py + half * nhy;

    // step 6: each sub-point resolves its own height at its own y
    return {
        lx: lx, ly: ly, lz: earHeight(ly) + zEff,
        rx: rx, ry: ry, rz: earHeight(ry) + zEff,
        weff: wEff, nx: nhx, ny: nhy
    };
}

// ---- DBAP solve (DbapSolver.cpp port) for one point -> out[]; returns invK = sqrt(denom),
// the field BEFORE normalisation (0 on the all-zero-weights path) ------------------------
function solveAt(xs, ys, zs, out) {
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
        for (var k = 0; k < NSPK; k++) out[k] = 0;   // silence, never NaN
        return 0;
    }
    var sqrtDenom = Math.sqrt(denom);
    var kk = 1.0 / sqrtDenom;
    for (var m = 0; m < NSPK; m++) out[m] = kk * wts[m] * t[m];
    return sqrtDenom;
}

// GainStage.cpp solveSubPoint + step 6 for one sub-point: classify against the hull, project if
// outside, solve, z-cue reference solve (same x/y, effective Z stripped), then fold hull trim * z-cue
// and the per-speaker trims into out[]. Returns {dHull, zCue}.
var refScratch = [0, 0, 0, 0, 0, 0, 0, 0];
function solveSubPoint(px, py, pz, out) {
    var sx = px, sy = py, dHull = 0;
    if (!hullInside(px, py)) {
        var pr = hullProject(px, py);
        sx = pr.x;
        sy = pr.y;
        dHull = pr.d;
    }
    var invK = solveAt(sx, sy, pz, out);
    var invKRef = solveAt(sx, sy, pz - zEff, refScratch);
    var cue = zCueGain(invK, invKRef);
    var trim = hullTrimGain(hullAtten, dHull) * cue;
    // per-speaker trims (dB) sit outside the normalisation on purpose: they correct the room
    for (var n = 0; n < NSPK; n++) out[n] = out[n] * trim * Math.pow(10, trimsDb[n] / 20);
    return { dHull: dHull, zCue: cue };
}

// The puck anchor in metres (the stored, scene-recalled position).
function anchorM() {
    return [bbMinX + srcNX * (bbMaxX - bbMinX), bbMinY + srcNY * (bbMaxY - bbMinY)];
}

function motionActive() {
    return motX !== 0 || motY !== 0 || motZ !== 0;
}

function solve() {
    // GainStage.cpp: anchor -> metres, THEN the metric offset (6 m is 6 m in any hall). No clamp:
    // a path may leave the bounding box and the hull projection deals with it, as in the plugin.
    var an = anchorM();
    var xs = an[0] + motX;
    var ys = an[1] + motY;
    zEff = srcZ + motZ;
    var zs = earHeight(ys) + zEff;

    sub = shape(xs, ys);
    var resL = solveSubPoint(sub.lx, sub.ly, sub.lz, gainsL);
    var resR = solveSubPoint(sub.rx, sub.ry, sub.rz, gainsR);
    dHullL = resL.dHull;
    dHullR = resR.dHull;
    var worst = dHullL > dHullR ? dHullL : dHullR;
    trimDbMin = -(hullAtten * worst);
    if (trimDbMin < K_TRIM_FLOOR_DB) trimDbMin = K_TRIM_FLOOR_DB;

    // air cutoff per feed from the UNPROJECTED sub-point's distance from the listener (centroid)
    fcL = airCutoffHz(airAmt, airDistanceMetres(sub.lx, sub.ly));
    fcR = airCutoffHz(airAmt, airDistanceMetres(sub.rx, sub.ry));

    // GainStage.cpp: depth = decorr * clamp(wEff / 2 m, 0, 1), only while wanted
    // (decorr > 0 AND wEff > 0); otherwise 0, which the gen~ chain treats as bypass.
    var widthRamp = clamp01(sub.weff / K_FULL_DEPTH_WIDTH_M);
    var wanted = decorrAmt > 0 && sub.weff > 0;
    var depth = wanted ? decorrAmt * widthRamp : 0;

    // R lane first, then L, then depth: the L applyvalues is the "hot" one for listeners
    outlet(4, "fcr", fcR);
    outlet(4, "fcl", fcL);
    outlet(4, "depth", depth);
    outlet(3, ["applyvalues"].concat(gainsR));
    outlet(0, ["applyvalues"].concat(gainsL));
    outlet(2, "pos", xs, ys, zs);
    outlet(2, "weff", sub.weff);
    outlet(2, ["gains"].concat(gainsL));
    outlet(2, ["gainsr"].concat(gainsR));
    outlet(2, "airhz", fcL, fcR);
    outlet(2, "dhull", dHullL, dHullR);
    outlet(2, "zcue", resL.zCue, resR.zCue);
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

    // convex hull of the array: outside it the hull trim applies
    if (hullPts.length >= 3) {
        rgb("frgb", COL_HULL);
        for (var hi = 0; hi < hullPts.length; hi++) {
            var ha = mToPx(hullPts[hi][0], hullPts[hi][1]);
            var hb = mToPx(hullPts[(hi + 1) % hullPts.length][0], hullPts[(hi + 1) % hullPts.length][1]);
            outlet(1, "linesegment", Math.round(ha[0]), Math.round(ha[1]), Math.round(hb[0]), Math.round(hb[1]));
        }
    }

    // stage marker
    outlet(1, "font", "Arial", 9);
    rgb("frgb", COL_TEXT);
    outlet(1, "moveto", Math.round((tl[0] + br[0]) / 2) - 16, 12);
    outlet(1, "write", "STAGE");

    // speakers: fill brightness follows the louder of the two sub-point gains
    var R = 8;
    for (var i = 0; i < NSPK; i++) {
        var p = mToPx(spk[i][0], spk[i][1]);
        var gm = gainsL[i] > gainsR[i] ? gainsL[i] : gainsR[i];
        var g = Math.sqrt(gm);   // perceptual-ish lift so quiet speakers stay visible
        if (g > 1) g = 1;
        var cr = Math.round(COL_SPK_DIM[0] + (COL_SPK_HOT[0] - COL_SPK_DIM[0]) * g);
        var cg = Math.round(COL_SPK_DIM[1] + (COL_SPK_HOT[1] - COL_SPK_DIM[1]) * g);
        var cb = Math.round(COL_SPK_DIM[2] + (COL_SPK_HOT[2] - COL_SPK_DIM[2]) * g);
        var l = Math.round(p[0] - R), tp = Math.round(p[1] - R);
        outlet(1, "paintoval", l, tp, l + 2 * R, tp + 2 * R, cr, cg, cb);
        rgb("frgb", COL_TEXT);
        outlet(1, "moveto", Math.round(p[0]) - 3, Math.round(p[1]) + 4);
        outlet(1, "write", i + 1);
    }

    // source puck: the anchor plus the motion offset (equal to the anchor with no motion)
    var an = anchorM();
    var xs = an[0] + motX;
    var ys = an[1] + motY;
    var q = mToPx(xs, ys);
    var qa = mToPx(an[0], an[1]);
    var PR = 6;
    var moving = motionActive() || tracePts.length >= 4;

    // v0.5: motion path around the anchor (closed polyline), or the Drift tail, UNDER everything
    if (tracePts.length >= 4) {
        rgb("frgb", COL_TRACE);
        var nTr = tracePts.length / 2;
        for (var ti = 0; ti < nTr; ti++) {
            var tj = (ti + 1) % nTr;
            var ta = mToPx(an[0] + tracePts[2 * ti], an[1] + tracePts[2 * ti + 1]);
            var tb = mToPx(an[0] + tracePts[2 * tj], an[1] + tracePts[2 * tj + 1]);
            outlet(1, "linesegment", Math.round(ta[0]), Math.round(ta[1]), Math.round(tb[0]), Math.round(tb[1]));
        }
    } else if (tailPts.length >= 4) {
        rgb("frgb", COL_TRACE);
        for (var di = 0; di + 3 < tailPts.length; di += 2) {
            var da = mToPx(tailPts[di], tailPts[di + 1]);
            var dbp = mToPx(tailPts[di + 2], tailPts[di + 3]);
            outlet(1, "linesegment", Math.round(da[0]), Math.round(da[1]), Math.round(dbp[0]), Math.round(dbp[1]));
        }
    }

    // D17: spread axis through the puck with a tick at each sub-point, drawn UNDER the puck
    // so the ticks visibly collapse onto it as the centroid fade takes wEff to zero.
    if (sub !== null) {
        var pl = mToPx(sub.lx, sub.ly);
        var pr = mToPx(sub.rx, sub.ry);
        var halfPx = 0.5 * sub.weff * pxPerM;
        rgb("frgb", COL_AXIS);
        outlet(1, "pensize", 2, 2);
        outlet(1, "linesegment", Math.round(pl[0]), Math.round(pl[1]), Math.round(pr[0]), Math.round(pr[1]));
        // ticks: 4 px each side along the bearing (perpendicular to the spread axis)
        var tx = -sub.ny * 4, ty = sub.nx * 4;
        outlet(1, "linesegment", Math.round(pl[0] - tx), Math.round(pl[1] - ty), Math.round(pl[0] + tx), Math.round(pl[1] + ty));
        outlet(1, "linesegment", Math.round(pr[0] - tx), Math.round(pr[1] - ty), Math.round(pr[0] + tx), Math.round(pr[1] + ty));
        outlet(1, "pensize", 1, 1);
        if (halfPx > PR + 6) {
            // labels just outside each tick, and the effective width beside the R tick
            outlet(1, "font", "Arial", 9);
            outlet(1, "moveto", Math.round(pl[0] - sub.nx * 10) - 3, Math.round(pl[1] - sub.ny * 10) + 4);
            outlet(1, "write", "L");
            outlet(1, "moveto", Math.round(pr[0] + sub.nx * 10) - 3, Math.round(pr[1] + sub.ny * 10) + 4);
            outlet(1, "write", "R");
        }
        if (sub.weff > 0.005) {
            outlet(1, "font", "Arial", 9);
            outlet(1, "moveto", Math.round(q[0]) + 10, Math.round(q[1]) - 8);
            outlet(1, "write", "w " + sub.weff.toFixed(1) + " m");
        }
    }

    // v0.4 status line under the plan: air cutoff(s) while the filter runs, hull trim when outside
    outlet(1, "font", "Arial", 9);
    rgb("frgb", COL_INFO);
    if (fcL > 0 || fcR > 0) {
        var airTxt = "air " + fmtHz(fcL);
        if (Math.abs(fcL - fcR) > 1) airTxt = "air L " + fmtHz(fcL) + "  R " + fmtHz(fcR);
        outlet(1, "moveto", 6, LCD_H - 6);
        outlet(1, "write", airTxt);
    }
    if (trimDbMin < -0.05) {
        outlet(1, "moveto", LCD_W - 78, LCD_H - 6);
        outlet(1, "write", "hull " + trimDbMin.toFixed(1) + " dB");
    }

    // v0.5: with motion patched in, the ANCHOR is a hollow ring (it is what the mouse drags and
    // what scenes store) and the moving puck is solid
    if (moving) {
        var al = Math.round(qa[0] - PR), at = Math.round(qa[1] - PR);
        rgb("frgb", COL_ANCHOR);
        outlet(1, "frameoval", al, at, al + 2 * PR, at + 2 * PR);
    }

    var ql = Math.round(q[0] - PR), qt = Math.round(q[1] - PR);
    outlet(1, "paintoval", ql, qt, ql + 2 * PR, qt + 2 * PR, COL_PUCK[0], COL_PUCK[1], COL_PUCK[2]);
    rgb("frgb", COL_PUCK_RING);
    outlet(1, "frameoval", ql - 3, qt - 3, ql + 2 * PR + 3, qt + 2 * PR + 3);
}

function fmtHz(f) {
    if (!(f > 0)) return "off";
    if (f >= 1000) return (f / 1000).toFixed(1) + "k";
    return Math.round(f) + "";
}

function solveAndDraw() {
    solve();
    draw();
    lastDrawMs = new Date().getTime();
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

// v0.5 (D21): anchor-relative offset in metres from the dbap-motion module. Every tick solves
// (the 21 ms gain ramp smooths 60 Hz steps); the plan redraws at most every DRAW_MIN_MS. The
// anchor (srcNX / srcNY, pattr srcpos) is untouched, and nothing is emitted on the nxy path.
function motion(dx, dy, dz) {
    if (typeof dx !== "number" || typeof dy !== "number") return;
    if (typeof dz !== "number") dz = 0;
    if (!isFinite(dx) || !isFinite(dy) || !isFinite(dz)) return;
    if (dx === motX && dy === motY && dz === motZ) return;
    motX = dx;
    motY = dy;
    motZ = dz;
    var settle = !motionActive();   // "motion 0 0 0": the module was switched off
    if (settle) {
        tailPts = [];
    } else if (tracePts.length < 4) {
        var an = anchorM();
        tailPts.push(an[0] + motX);
        tailPts.push(an[1] + motY);
        if (tailPts.length > 2 * TAIL_MAX) tailPts.splice(0, tailPts.length - 2 * TAIL_MAX);
    }
    solve();
    var now = new Date().getTime();
    if (settle || now - lastDrawMs >= DRAW_MIN_MS || now < lastDrawMs) {
        draw();
        lastDrawMs = now;
    }
}

// One cycle of the motion path (metres, anchor-relative). A bare "trace" clears it.
function trace() {
    var a = arrayfromargs(arguments);
    var next = [];
    for (var i = 0; i + 1 < a.length; i += 2) {
        if (typeof a[i] !== "number" || typeof a[i + 1] !== "number") break;
        next.push(a[i]);
        next.push(a[i + 1]);
    }
    tracePts = next;
    if (tracePts.length >= 4) tailPts = [];
    draw();
    lastDrawMs = new Date().getTime();
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

function width(v) {
    if (v < 0) v = 0;
    if (v > 12) v = 12;
    widthM = v;
    solveAndDraw();
}

function decorr(v) {
    decorrAmt = clamp01(v);
    solveAndDraw();
}

function air(v) {
    airAmt = clamp01(v);
    solveAndDraw();
}

function hull(v) {
    if (v < 0) v = 0;
    if (v > 3) v = 3;
    hullAtten = v;
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
