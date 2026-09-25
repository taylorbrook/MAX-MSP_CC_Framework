// slot-engine.js
// Slice position computer for rhythmic-sampler slot bpatcher.
// Queries buffer length directly via js Buffer API (no info~ needed).
//
// inlets:
//   0: int (step/slice index from counter)
//   1: symbol (buffer name, e.g. "setbuffer slot-1")
//   2: int (number of slices)
//   3: float (start offset percentage, 0-100)
//
// outlets:
//   0: float (slice start ms -> groove~ inlet 1, playhead expr inlet 2)
//   1: float (slice end ms -> groove~ inlet 2, playhead expr inlet 1)
//
// Start offset shifts where the slice grid begins: the N slices divide
// the region [offset, bufferEnd], so 0% slices the whole file.

autowatch = 1;
inlets = 4;
outlets = 2;

var buf = null;
var bufferLength = 0;
var numSlices = 16;
var startOffsetPct = 0;

function getBufferLengthMs() {
	if (!buf) return 0;
	// Buffer.length() is a method (returns ms), not a property
	var len = buf.length();
	return (typeof len === "number" && len > 0) ? len : 0;
}

function msg_int(v) {
	if (inlet === 0) {
		// Refresh buffer length each step (handles re-loads)
		var len = getBufferLengthMs();
		if (len > 0) bufferLength = len;
		// Compute slice boundaries within [offset, bufferLength]
		if (bufferLength > 0 && numSlices > 0) {
			var sliceIndex = v % numSlices;
			var offsetMs = bufferLength * (startOffsetPct / 100);
			var sliceLen = (bufferLength - offsetMs) / numSlices;
			var startMs = offsetMs + sliceIndex * sliceLen;
			var endMs = startMs + sliceLen;
			outlet(1, endMs);
			outlet(0, startMs);
		}
	} else if (inlet === 2) {
		numSlices = Math.max(1, Math.min(16, v));
	} else if (inlet === 3) {
		setStart(v);
	}
}

function msg_float(v) {
	if (inlet === 0) {
		msg_int(Math.floor(v));
	} else if (inlet === 2) {
		msg_int(Math.floor(v));
	} else if (inlet === 3) {
		setStart(v);
	}
}

function setStart(v) {
	// Cap below 100% so the slice region never collapses to zero length
	startOffsetPct = Math.max(0, Math.min(95, v));
}

function setbuffer(name) {
	buf = new Buffer(name);
	bufferLength = getBufferLengthMs();
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
