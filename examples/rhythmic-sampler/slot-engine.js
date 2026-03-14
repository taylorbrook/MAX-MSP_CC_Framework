// slot-engine.js
// Slice position computer for rhythmic-sampler slot bpatcher.
// Queries buffer length directly via js Buffer API (no info~ needed).
//
// inlets:
//   0: int (step/slice index from counter)
//   1: symbol (buffer name, e.g. "setbuffer slot-1")
//   2: int (number of slices)
//
// outlets:
//   0: float (slice start ms -> groove~ inlet 1)
//   1: float (slice end ms -> groove~ inlet 2)

autowatch = 1;
inlets = 3;
outlets = 2;

var buf = null;
var bufferLength = 0;
var numSlices = 16;

function msg_int(v) {
	if (inlet === 0) {
		// Refresh buffer length each step (handles re-loads)
		if (buf) {
			var len = buf.length;
			if (len > 0) bufferLength = len;
		}
		// Compute slice boundaries
		if (bufferLength > 0 && numSlices > 0) {
			var sliceIndex = v % numSlices;
			var sliceLen = bufferLength / numSlices;
			var startMs = sliceIndex * sliceLen;
			var endMs = startMs + sliceLen;
			outlet(1, endMs);
			outlet(0, startMs);
		}
	} else if (inlet === 2) {
		numSlices = Math.max(1, v);
	}
}

function msg_float(v) {
	if (inlet === 0) {
		msg_int(Math.floor(v));
	}
}

function setbuffer(name) {
	buf = new Buffer(name);
	bufferLength = buf.length;
	post("slot-engine: buffer set to " + name + " (" + bufferLength + " ms)\n");
}

function anything() {
	// Handle messages on inlet 1 (buffer name)
	if (inlet === 1) {
		var name = messagename;
		if (name === "setbuffer" && arguments.length > 0) {
			setbuffer(arguments[0]);
		} else if (name !== "float" && name !== "int" && name !== "bang") {
			// Treat as buffer name directly
			setbuffer(name);
		}
	}
}

function reset() {
	bufferLength = 0;
	buf = null;
}
