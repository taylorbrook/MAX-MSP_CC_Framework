// mode-gains.js — bridge between multislider and buffer~ mode_gains
// inlet 0: bang = init buffer to 1.0 + output list; list = write values to buffer
// inlet 1: int = set active mode count
// outlet 0: list of gain values (for multislider)

inlets = 2;
outlets = 1;

var size = 32;
var buf_name = "mode_gains";

function bang() {
	// Initialize buffer to all 1.0 and output list for multislider
	var buf = new Buffer(buf_name);
	var vals = [];
	for (var i = 0; i < size; i++) {
		buf.poke(1, i + 1, 1.0);
		vals.push(1.0);
	}
	outlet(0, vals);
}

function list() {
	if (inlet === 0) {
		// Write multislider values to buffer
		var buf = new Buffer(buf_name);
		var a = arrayfromargs(arguments);
		for (var i = 0; i < a.length; i++) {
			buf.poke(1, i + 1, a[i]);
		}
	}
}

function msg_float(v) {
	if (inlet === 0) {
		// Single float — treat as list of one
		var buf = new Buffer(buf_name);
		buf.poke(1, 1, v);
	}
}

function msg_int(v) {
	if (inlet === 1) {
		size = Math.max(v, 1);
	} else {
		msg_float(v);
	}
}
