// fold.js -- ambisonic fold-down matrix for barnett-dbap v0.8 (context.md D36-D38)
// Virtual-speaker encode: each of the 8 speaker feeds is a point source at that speaker's
// direction from the listener, encoded to 3rd-order AmbiX (ACN channel order, SN3D, no
// Condon-Shortley phase). Direction only: equal gain per speaker, no 1/d.
//
// Listener = rig centroid (x, y) at earHeight(centroid y), as dbap.js deriveVenue() + earHeight().
// Ambisonic axes: X = front = toward the stage (-y room), Y = audience left (-x room), Z = up.
// Azimuth is counter-clockwise from front (+ = audience left), elevation + = up.
//
// inlet 0 messages:
//   venue / bang   re-read the "venue" dict and resend (hosts broadcast "venue" on dbap-venue)
//   flat 0/1       1 = zero every elevation (image on the horizon), levels unchanged
//   mirror 0/1     1 = flip the azimuth sign (left <-> right), if the monitor turns out mirrored
//
// outlet 0: "<in 0-7> <out 0-15> <gain>" x 128  -> matrix~ 8 16 (left inlet)
// outlet 1: "set <text>"                         -> status comment

inlets = 1;
outlets = 2;

var NSPK = 8;
var NSH = 16;

// O-Octagon defaults (the same table as dbap.js): metres, origin front-left,
// x left->right (audience view), y stage->rear
var DEFAULT_SPK = [
    [0.50, 4.50, 4.50],
    [12.50, 4.50, 4.50],
    [12.50, 9.85, 4.70],
    [12.50, 16.00, 5.10],
    [9.80, 19.50, 5.40],
    [3.20, 19.50, 5.40],
    [0.50, 16.00, 5.10],
    [0.50, 9.85, 4.70]
];
var DEFAULT_RAKE_FRONT = 1.10;
var DEFAULT_RAKE_REAR = 3.20;

var spk = [];
var rakeFront = DEFAULT_RAKE_FRONT;
var rakeRear = DEFAULT_RAKE_REAR;
var venueName = "";
var flatOn = 0;
var mirrorOn = 0;
var lis = [0, 0, 0];           // listener, metres
var dirs = [];                 // [[azDeg, elDeg], ...] as sent (after flat / mirror)

function setDefaultVenue() {
    spk = [];
    for (var i = 0; i < NSPK; i++) {
        spk.push([DEFAULT_SPK[i][0], DEFAULT_SPK[i][1], DEFAULT_SPK[i][2]]);
    }
    rakeFront = DEFAULT_RAKE_FRONT;
    rakeRear = DEFAULT_RAKE_REAR;
}

function readVenue() {
    var ok = false;
    venueName = "";
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
        var nm = d.get("name");
        if (typeof nm === "string") venueName = nm;
        spk = next;
        rakeFront = rf;
        rakeRear = rr;
        ok = true;
    } catch (e) {
        post("fold.js: venue dict unavailable (" + e.message + "), using built-in Barnett layout\n");
        setDefaultVenue();
    }
    return ok;
}

// dbap.js deriveVenue() + earHeight(): centroid (x, y), ear height linear in y over the bbox
function deriveListener() {
    var bbMinY = spk[0][1], bbMaxY = spk[0][1];
    var cx = 0, cy = 0;
    for (var i = 0; i < NSPK; i++) {
        if (spk[i][1] < bbMinY) bbMinY = spk[i][1];
        if (spk[i][1] > bbMaxY) bbMaxY = spk[i][1];
        cx += spk[i][0];
        cy += spk[i][1];
    }
    cx /= NSPK;
    cy /= NSPK;
    if (bbMaxY - bbMinY < 1e-6) bbMaxY = bbMinY + 1;
    var t = (cy - bbMinY) / (bbMaxY - bbMinY);
    lis = [cx, cy, rakeFront + (rakeRear - rakeFront) * t];
}

// Real spherical harmonics to order 3 for a unit vector (x front, y left, z up):
// ACN order, SN3D normalisation, no Condon-Shortley phase (AmbiX).
function sh3(x, y, z) {
    var x2 = x * x, y2 = y * y, z2 = z * z;
    return [
        1.0,                                         //  0  W
        y,                                           //  1  Y
        z,                                           //  2  Z
        x,                                           //  3  X
        1.7320508075688772 * x * y,                  //  4  V
        1.7320508075688772 * y * z,                  //  5  T
        0.5 * (3.0 * z2 - 1.0),                      //  6  R
        1.7320508075688772 * x * z,                  //  7  S
        0.8660254037844386 * (x2 - y2),              //  8  U
        0.7905694150420949 * y * (3.0 * x2 - y2),    //  9  Q
        3.872983346207417 * x * y * z,               // 10  O
        0.6123724356957945 * y * (5.0 * z2 - 1.0),   // 11  M
        0.5 * z * (5.0 * z2 - 3.0),                  // 12  K
        0.6123724356957945 * x * (5.0 * z2 - 1.0),   // 13  L
        1.9364916731037085 * z * (x2 - y2),          // 14  N
        0.7905694150420949 * x * (x2 - 3.0 * y2)     // 15  P
    ];
}

function send() {
    var RAD = 180.0 / Math.PI;
    dirs = [];
    for (var i = 0; i < NSPK; i++) {
        // room -> ambisonic axes: front = -y, left = -x, up = +z
        var ax = -(spk[i][1] - lis[1]);
        var ay = -(spk[i][0] - lis[0]);
        var az = spk[i][2] - lis[2];
        if (flatOn) az = 0;
        if (mirrorOn) ay = -ay;
        var len = Math.sqrt(ax * ax + ay * ay + az * az);
        if (len < 1e-9) {          // a speaker at the listener: no direction, W only
            ax = 0; ay = 0; az = 0;
            len = 1;
        }
        ax /= len; ay /= len; az /= len;
        dirs.push([Math.atan2(ay, ax) * RAD, Math.asin(az < -1 ? -1 : (az > 1 ? 1 : az)) * RAD]);
        var g = sh3(ax, ay, az);
        if (len === 1 && ax === 0 && ay === 0 && az === 0) {
            for (var k = 1; k < NSH; k++) g[k] = 0;
        }
        for (var n = 0; n < NSH; n++) {
            var v = g[n];
            if (!isFinite(v)) v = 0;
            outlet(0, i, n, v);    // a 0 gain disconnects that node, which is the same thing
        }
    }
    var label = venueName.length > 24 ? venueName.substring(0, 23) + "..." : venueName;
    var txt = (label.length ? label + "  |  " : "") + "listener " + lis[0].toFixed(2) + ", " +
        lis[1].toFixed(2) + ", " + lis[2].toFixed(2) + " m" + (flatOn ? "  |  flat" : "") +
        (mirrorOn ? "  |  mirrored" : "");
    outlet(1, "set", txt);
}

function report() {
    var s = "fold.js: listener (" + lis[0].toFixed(2) + ", " + lis[1].toFixed(2) + ", " +
        lis[2].toFixed(2) + ") m; az / el";
    for (var i = 0; i < NSPK; i++) {
        s += "  s" + (i + 1) + " " + dirs[i][0].toFixed(1) + " / " + dirs[i][1].toFixed(1);
    }
    post(s + "\n");
}

function venue() {
    readVenue();
    deriveListener();
    send();
    report();
}

function bang() {
    venue();
}

function loadbang() {
    venue();
}

function flat(v) {
    flatOn = v ? 1 : 0;
    if (!spk.length) { readVenue(); deriveListener(); }
    send();
}

function mirror(v) {
    mirrorOn = v ? 1 : 0;
    if (!spk.length) { readVenue(); deriveListener(); }
    send();
}

function anything() {
    post("fold.js: unknown message " + messagename + "\n");
}
