// slot-engine.js
// Slice position computer for rhythmic-sampler slot bpatcher.
// Buffer length is received from info~ on inlet 1 (float).
//
// inlets:
//   0: int (step/slice index from counter)
//   1: float (buffer duration ms from info~) or symbol (setbuffer name)
//   2: int (number of slices)
//   3: float (start offset percentage, 0-100)
//
// outlets:
//   0: float (slice start ms -> groove~ inlet 1)
//   1: float (slice end ms -> groove~ inlet 2)

autowatch = 1;
inlets = 4;
outlets = 2;

var bufferLength = 0;
var numSlices = 16;
var startOffsetPct = 0;

function msg_int(v) {
	if (inlet === 0) {
		// Compute slice boundaries
		if (bufferLength > 0 && numSlices > 0) {
			var sliceIndex = v % numSlices;
			var sliceLen = bufferLength / numSlices;
			var endMs = (sliceIndex + 1) * sliceLen;
			var offsetMs = sliceLen * (startOffsetPct / 100);
			var startMs = sliceIndex * sliceLen + offsetMs;
			if (startMs >= endMs) startMs = endMs - 1;
			outlet(1, endMs);
			outlet(0, startMs);
		}
	} else if (inlet === 1) {
		if (v > 0) bufferLength = v;
	} else if (inlet === 2) {
		numSlices = Math.max(1, v);
	} else if (inlet === 3) {
		startOffsetPct = Math.max(0, Math.min(100, v));
	}
}

function msg_float(v) {
	if (inlet === 0) {
		msg_int(Math.floor(v));
	} else if (inlet === 1) {
		// Buffer duration in ms from info~
		if (v > 0) {
			bufferLength = v;
			post("slot-engine: buffer length " + bufferLength + " ms\n");
		}
	} else if (inlet === 2) {
		numSlices = Math.max(1, Math.floor(v));
	} else if (inlet === 3) {
		startOffsetPct = Math.max(0, Math.min(100, v));
	}
}

function anything() {
	if (inlet === 1) {
		var name = messagename;
		if (name === "setbuffer" && arguments.length > 0) {
			// Just acknowledge buffer name, length comes from info~
			post("slot-engine: buffer name " + arguments[0] + "\n");
		}
	}
}

function reset() {
	bufferLength = 0;
}
