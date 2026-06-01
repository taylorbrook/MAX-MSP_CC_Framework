// transport_barbeat.js  --  psycography transport module
// Reverse-lookup: master sample position -> "bar beat" using a precomputed beat grid.
//
// The grid is the integrated downbeat/beat grid for the whole piece, derived from the
// MIDI tempo map by the timeline tool (next module). Each entry is [sample, bar, beat]
// in ascending sample order. Until a grid is loaded the readout shows an em dash.
//
// Inlet 0 messages:
//   clear                      -- empty the grid
//   add <sample> <bar> <beat>  -- append one grid point (any order; sorted lazily)
//   <float|int>                -- current master sample (from snapshot~) -> emit position
// Outlet 0:
//   list  <bar> <beat>         -- current musical position
//   symbol "—"            -- no grid loaded / before first beat

autowatch = 1;
inlets = 1;
outlets = 1;
setinletassist(0, "snapshot~ master sample; or clear / add sample bar beat");
setoutletassist(0, "bar beat (list) or —");

var grid = [];     // [ [sample, bar, beat], ... ]
var dirty = false; // needs re-sort before lookup

function clear() {
    grid = [];
    dirty = false;
    outlet(0, "—");
}

// add <sample> <bar> <beat>
function add() {
    var a = arrayfromargs(arguments);
    if (a.length < 3) {
        post("transport_barbeat: 'add' needs sample bar beat\n");
        return;
    }
    grid.push([a[0], a[1], a[2]]);
    dirty = true;
}

function ensureSorted() {
    if (dirty) {
        grid.sort(function (p, q) { return p[0] - q[0]; });
        dirty = false;
    }
}

// index of greatest entry with sample <= x, or -1 if x precedes the first entry
function findIndex(x) {
    var lo = 0, hi = grid.length - 1, res = -1;
    while (lo <= hi) {
        var mid = (lo + hi) >> 1;
        if (grid[mid][0] <= x) { res = mid; lo = mid + 1; }
        else { hi = mid - 1; }
    }
    return res;
}

function lookup(x) {
    if (grid.length === 0) { outlet(0, "—"); return; }
    ensureSorted();
    var i = findIndex(x);
    if (i < 0) { outlet(0, "—"); return; }
    outlet(0, [grid[i][1], grid[i][2]]);
}

function msg_float(x) { lookup(x); }
function msg_int(x) { lookup(x); }
function bang() { /* no-op */ }
