inlets = 1;
outlets = 4;
autowatch = 1;

// outlet 0: bang -> zl.reg holding the loop name -> ears.split~ left inlet (hot)
// outlet 1: split points (samples) -> ears.split~ right inlet (cold)
// outlet 2: slice start list (samples), one per output slice -> waveform playhead
// outlet 3: loop channel count -> mono/stereo handling in the player

function buffer() {
    bang();
}

function anything() {
    bang();
}

function bang() {
    var buf = new Buffer("rcc_indices");
    var loop = new Buffer("rcc_loop");
    var n = buf.framecount();
    var len = loop.framecount();

    if (!n || n === 0) {
        post("read_indices: rcc_indices buffer empty\n");
        return;
    }

    var batch = buf.peek(1, 0, n);
    if (!batch || batch.length === 0) batch = buf.peek(0, 0, n);

    // Keep only interior points, strictly increasing: a point at 0 or at the
    // loop end would make ears.split~ emit a zero-length slice.
    var points = [];
    var last = 0;
    for (var i = 0; i < n; i++) {
        var f = batch && batch[i];
        if (typeof f !== "number" || isNaN(f)) {
            var single = buf.peek(1, i, 1);
            f = (single && single[0]) || 0;
        }
        f = Math.floor(f);
        if (f > last && (!len || f < len)) {
            points.push(f);
            last = f;
        }
    }

    // no interior onsets: split one sample before the end so ears.split~
    // still gets a valid point list (the whole loop becomes slice 0)
    if (points.length === 0) points.push(len > 1 ? len - 1 : 1);

    var starts = [0].concat(points);

    post("read_indices: " + starts.length + " slices -> " + points.slice(0, 8).join(",") + (points.length > 8 ? "..." : "") + "\n");
    outlet(3, loop.channelcount());
    outlet(2, starts);
    outlet(1, points);
    outlet(0, "bang");
}
