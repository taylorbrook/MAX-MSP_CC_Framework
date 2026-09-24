// mixer-manager.js — Dynamic mixer strip/bus management via thispatcher
// Master bpatcher is static (varname "master"), repositioned via patcher API.
//
// Strips/busses are synced, not rebuilt: an existing "strip-N" / "bus-N"
// bpatcher is kept (with its patch cords and settings), extras beyond the
// requested count are removed, and only missing ones are created. Saved
// duplicates with "[N]" suffix varnames are always removed.
// Control values persist via pattrstorage (see save / recallState).

inlets = 1;
outlets = 1;

var STRIP_W = 88;
var STRIP_H = 702;
var BUS_W = 88;
var BUS_H = 428;
var MASTER_W = 118;
var MASTER_H = 438;

var ROW_Y = 190;
var X_START = 10;
var GAP = 4;
var BUS_GAP = 16;
var MASTER_GAP = 24;

var trackCount = 0;
var busCount = 0;
var soloed = {};		// strip number -> 1 while its S is on

function stripX(i) {
	return X_START + i * (STRIP_W + GAP);
}

function busX(i) {
	return X_START + trackCount * (STRIP_W + GAP) + BUS_GAP + i * (BUS_W + GAP);
}

// p is passed in explicitly: helpers are called as plain functions.
// Keep prefix1..prefixN bpatchers, remove everything else carrying the prefix.
// Returns an array indexed by number (1-based) of kept objects.
function prune(p, prefix, count) {
	var kept = [];
	var obj = p.firstobject;
	while (obj) {
		var next = obj.nextobject;
		var vn = obj.varname;
		if (obj.maxclass === "bpatcher" && vn && vn.indexOf(prefix) === 0) {
			var tail = vn.substring(prefix.length);
			var n = /^[0-9]+$/.test(tail) ? parseInt(tail, 10) : 0;
			if (n >= 1 && n <= count && !kept[n]) {
				kept[n] = obj;
			} else {
				p.remove(obj);
			}
		}
		obj = next;
	}
	return kept;
}

function syncStrips(p, count) {
	var kept = prune(p, "strip-", count);
	for (var i = 0; i < count; i++) {
		var n = i + 1;
		var x = stripX(i);
		if (kept[n]) {
			kept[n].rect = [x, ROW_Y, x + STRIP_W, ROW_Y + STRIP_H];
		} else {
			outlet(0, "script", "newobject", "bpatcher",
				"@args", n, "mixer-in-" + n + "-L", "mixer-in-" + n + "-R",
				"@name", "mixer-strip.maxpat",
				"@varname", "strip-" + n,
				"@presentation", 0,
				"@patching_rect", x, ROW_Y, STRIP_W, STRIP_H);
		}
	}
	trackCount = count;
	for (var k in soloed) {
		if (parseInt(k, 10) > count) delete soloed[k];
	}
}

function syncBusses(p, count) {
	var kept = prune(p, "bus-", count);
	for (var i = 0; i < count; i++) {
		var n = i + 1;
		var x = busX(i);
		if (kept[n]) {
			kept[n].rect = [x, ROW_Y, x + BUS_W, ROW_Y + BUS_H];
		} else {
			outlet(0, "script", "newobject", "bpatcher",
				"@args", n, "bus-" + n + "-L", "bus-" + n + "-R",
				"@name", "mixer-bus.maxpat",
				"@varname", "bus-" + n,
				"@presentation", 0,
				"@patching_rect", x, ROW_Y, BUS_W, BUS_H);
		}
	}
	busCount = count;
}

function moveMaster(p) {
	var master = p.getnamed("master");
	if (master) {
		var x = busX(busCount) + MASTER_GAP;
		master.rect = [x, ROW_Y, x + MASTER_W, ROW_Y + MASTER_H];
	}
}

// Highest N among exact "prefixN" bpatchers already in the patch
function countExisting(p, prefix) {
	var max = 0;
	var obj = p.firstobject;
	while (obj) {
		var vn = obj.varname;
		if (obj.maxclass === "bpatcher" && vn && vn.indexOf(prefix) === 0) {
			var tail = vn.substring(prefix.length);
			if (/^[0-9]+$/.test(tail)) max = Math.max(max, parseInt(tail, 10));
		}
		obj = obj.nextobject;
	}
	return max;
}

function setCounts(p) {
	var nt = p.getnamed("ntracks");
	var nb = p.getnamed("nbusses");
	if (nt) nt.message("set", trackCount);
	if (nb) nb.message("set", busCount);
}

// Atomic init — syncs tracks and busses in one pass
function init(t, b) {
	var p = this.patcher;
	syncStrips(p, Math.max(1, Math.min(t, 32)));
	syncBusses(p, Math.max(0, Math.min(b, 8)));
	moveMaster(p);
	setCounts(p);
	broadcastSolo();
	post("mixer: init " + trackCount + " track(s), " + busCount + " bus(ses)\n");
}

// On open: keep the saved strip/bus counts (4/2 on first open), then
// recall mixer-state.json once every strip's own loadbang defaults are done.
function load() {
	var p = this.patcher;
	var t = countExisting(p, "strip-");
	var b = countExisting(p, "bus-");
	if (t === 0) { t = 4; b = 2; }
	init.call(this, t, b);
	recallTask = new Task(recallState, this);
	recallTask.schedule(50);
}

// ---- state: pattrstorage "mixstate" <-> mixer-state.json next to the patch

var recallTask = null;

function statePath(p) {
	var fp = p.filepath;
	if (!fp) return null;
	return fp.substring(0, fp.lastIndexOf("/") + 1) + "mixer-state.json";
}

function recallState() {
	var p = this.patcher;
	var ps = p.getnamed("mixstate");
	var path = statePath(p);
	if (!ps || !path) return;
	var f = new File(path, "read");
	var exists = f.isopen;
	f.close();
	if (!exists) return;
	ps.message("read", path);
	ps.message("recall", 1);
	post("mixer: recalled " + path + "\n");
}

function save() {
	var p = this.patcher;
	var ps = p.getnamed("mixstate");
	var path = statePath(p);
	if (!ps) return;
	if (!path) {
		post("mixer: save the patch first -- state is stored next to it\n");
		return;
	}
	ps.message("store", 1);
	ps.message("write", path);
	post("mixer: saved " + path + "\n");
}

function tracks(count) {
	var p = this.patcher;
	syncStrips(p, Math.max(1, Math.min(count, 32)));
	syncBusses(p, busCount);	// reposition only; existing busses are kept
	moveMaster(p);
	broadcastSolo();
	post("mixer: " + trackCount + " track(s)\n");
}

function busses(count) {
	var p = this.patcher;
	syncBusses(p, Math.max(0, Math.min(count, 8)));
	moveMaster(p);
	post("mixer: " + busCount + " bus(ses)\n");
}

// ---- solo-in-place: strips report "solo N 0/1" via send mixer-solo;
// every strip gates its output on mixer-solo-any (1 while any strip is soloed)

function solo(n, state) {
	if (state) soloed[n] = 1;
	else delete soloed[n];
	broadcastSolo();
}

function broadcastSolo() {
	var any = 0;
	for (var k in soloed) any = 1;
	messnamed("mixer-solo-any", any);
}
