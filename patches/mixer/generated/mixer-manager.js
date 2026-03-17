// mixer-manager.js — Dynamic mixer strip/bus creation via thispatcher
// Master bpatcher is static (varname "master"), repositioned via patcher API

inlets = 1;
outlets = 1;

var currentStrips = [];
var currentBusses = [];

var STRIP_W = 88;
var STRIP_H = 508;
var BUS_W = 88;
var BUS_H = 428;
var MASTER_W = 118;
var MASTER_H = 438;

var ROW_Y = 10;
var X_START = 10;
var GAP = 4;
var BUS_GAP = 16;
var MASTER_GAP = 24;

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

function tracks(count) {
	count = Math.max(1, Math.min(count, 32));

	for (var i = 0; i < currentStrips.length; i++) {
		outlet(0, "script", "delete", currentStrips[i]);
	}
	currentStrips = [];

	for (var i = 0; i < count; i++) {
		var varname = "strip-" + (i + 1);
		var x = X_START + i * (STRIP_W + GAP);
		outlet(0, "script", "newobject", "bpatcher",
			"@name", "mixer-strip.maxpat",
			"@args", i + 1,
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

	for (var i = 0; i < currentBusses.length; i++) {
		outlet(0, "script", "delete", currentBusses[i]);
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
			"@name", "mixer-bus.maxpat",
			"@args", busNum, recvL, recvR,
			"@varname", varname,
			"@presentation", 0,
			"@patching_rect", x, ROW_Y, BUS_W, BUS_H);
		currentBusses.push(varname);
	}

	post("mixer: created " + count + " bus(ses)\n");
	moveMaster();
}
