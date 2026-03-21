// mixer-manager.js — Dynamic mixer strip/bus creation via thispatcher
// Master bpatcher is static (varname "master"), repositioned via patcher API

inlets = 1;
outlets = 1;

var currentStrips = [];
var currentBusses = [];

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

// Remove all dynamic bpatchers by walking the patcher.
// Handles saved duplicates with [N] suffix varnames that
// simple "script delete" by exact name would miss.
function cleanAll() {
	var obj = this.patcher.firstobject;
	while (obj) {
		var next = obj.nextobject;
		if (obj.maxclass === "bpatcher") {
			var vn = obj.varname;
			if (vn && vn !== "master") {
				this.patcher.remove(obj);
			}
		}
		obj = next;
	}
	currentStrips = [];
	currentBusses = [];
}

function moveMaster() {
	var master = this.patcher.getnamed("master");
	if (master) {
		var x = X_START
			+ currentStrips.length * (STRIP_W + GAP)
			+ BUS_GAP
			+ currentBusses.length * (BUS_W + GAP)
			+ MASTER_GAP;
		master.rect = [x, ROW_Y, x + MASTER_W, ROW_Y + MASTER_H];
	}
}

// Atomic init — creates tracks and busses in one pass, no double-firing
function init(trackCount, busCount) {
	trackCount = Math.max(1, Math.min(trackCount, 32));
	busCount = Math.max(0, Math.min(busCount, 8));

	// Clean slate: delete ALL possible strips/busses (including saved ones)
	cleanAll();

	// Create strips
	for (var i = 0; i < trackCount; i++) {
		var varname = "strip-" + (i + 1);
		var x = X_START + i * (STRIP_W + GAP);
		outlet(0, "script", "newobject", "bpatcher",
			"@args", i + 1,
			"@name", "mixer-strip.maxpat",
			"@varname", varname,
			"@presentation", 0,
			"@patching_rect", x, ROW_Y, STRIP_W, STRIP_H);
		currentStrips.push(varname);
	}

	// Create busses
	var x_offset = X_START + currentStrips.length * (STRIP_W + GAP) + BUS_GAP;
	for (var i = 0; i < busCount; i++) {
		var busNum = i + 1;
		var varname = "bus-" + busNum;
		var x = x_offset + i * (BUS_W + GAP);
		var recvL = "bus-" + busNum + "-L";
		var recvR = "bus-" + busNum + "-R";
		outlet(0, "script", "newobject", "bpatcher",
			"@args", busNum, recvL, recvR,
			"@name", "mixer-bus.maxpat",
			"@varname", varname,
			"@presentation", 0,
			"@patching_rect", x, ROW_Y, BUS_W, BUS_H);
		currentBusses.push(varname);
	}

	post("mixer: init " + trackCount + " track(s), " + busCount + " bus(ses)\n");
	moveMaster();
}

function tracks(count) {
	count = Math.max(1, Math.min(count, 32));

	// Delete all strip bpatchers (handles saved duplicates with [N] suffixes)
	var obj = this.patcher.firstobject;
	while (obj) {
		var next = obj.nextobject;
		if (obj.maxclass === "bpatcher" && obj.varname && obj.varname.indexOf("strip-") === 0) {
			this.patcher.remove(obj);
		}
		obj = next;
	}
	currentStrips = [];

	for (var i = 0; i < count; i++) {
		var varname = "strip-" + (i + 1);
		var x = X_START + i * (STRIP_W + GAP);
		outlet(0, "script", "newobject", "bpatcher",
			"@args", i + 1,
			"@name", "mixer-strip.maxpat",
			"@varname", varname,
			"@presentation", 0,
			"@patching_rect", x, ROW_Y, STRIP_W, STRIP_H);
		currentStrips.push(varname);
	}

	post("mixer: created " + count + " track(s)\n");

	if (currentBusses.length > 0) {
		busses(currentBusses.length);
	} else {
		moveMaster();
	}
}

function busses(count) {
	count = Math.max(0, Math.min(count, 8));

	// Delete all bus bpatchers (handles saved duplicates with [N] suffixes)
	var obj = this.patcher.firstobject;
	while (obj) {
		var next = obj.nextobject;
		if (obj.maxclass === "bpatcher" && obj.varname && obj.varname.indexOf("bus-") === 0) {
			this.patcher.remove(obj);
		}
		obj = next;
	}
	currentBusses = [];

	var x_offset = X_START + currentStrips.length * (STRIP_W + GAP) + BUS_GAP;

	for (var i = 0; i < count; i++) {
		var busNum = i + 1;
		var varname = "bus-" + busNum;
		var x = x_offset + i * (BUS_W + GAP);
		var recvL = "bus-" + busNum + "-L";
		var recvR = "bus-" + busNum + "-R";
		outlet(0, "script", "newobject", "bpatcher",
			"@args", busNum, recvL, recvR,
			"@name", "mixer-bus.maxpat",
			"@varname", varname,
			"@presentation", 0,
			"@patching_rect", x, ROW_Y, BUS_W, BUS_H);
		currentBusses.push(varname);
	}

	post("mixer: created " + count + " bus(ses)\n");
	moveMaster();
}
