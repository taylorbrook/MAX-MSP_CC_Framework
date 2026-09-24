// mixer-manager.js — Dynamic mixer strip/bus management via thispatcher
// Master bpatcher is static (varname "master"), repositioned via patcher API.
//
// Strips/busses are synced, not rebuilt: an existing "strip-N" / "bus-N"
// bpatcher is kept (with its patch cords and settings), extras beyond the
// requested count are removed, and only missing ones are created. Saved
// duplicates with "[N]" suffix varnames are always removed.

inlets = 1;
outlets = 1;

var STRIP_W = 88;
var STRIP_H = 563;
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

// Atomic init — syncs tracks and busses in one pass
function init(t, b) {
	var p = this.patcher;
	syncStrips(p, Math.max(1, Math.min(t, 32)));
	syncBusses(p, Math.max(0, Math.min(b, 8)));
	moveMaster(p);
	post("mixer: init " + trackCount + " track(s), " + busCount + " bus(ses)\n");
}

function tracks(count) {
	var p = this.patcher;
	syncStrips(p, Math.max(1, Math.min(count, 32)));
	syncBusses(p, busCount);	// reposition only; existing busses are kept
	moveMaster(p);
	post("mixer: " + trackCount + " track(s)\n");
}

function busses(count) {
	var p = this.patcher;
	syncBusses(p, Math.max(0, Math.min(count, 8)));
	moveMaster(p);
	post("mixer: " + busCount + " bus(ses)\n");
}
