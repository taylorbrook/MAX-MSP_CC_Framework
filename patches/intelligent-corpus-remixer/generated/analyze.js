inlets = 1;
outlets = 2;

var MIN_SLICE = 4096;

function buffer() {
    bang();
}

function anything() {
    bang();
}

function bang() {
    var onsets = new Buffer("onsets");
    var source = new Buffer("source");
    var numOnsets = onsets.framecount();
    var sourceLen = source.framecount();

    post("analyze: source=" + sourceLen + " frames, onsets buffer=" + numOnsets + " frames\n");

    if (numOnsets === 0 || sourceLen === 0) {
        post("analyze: source or onsets buffer empty\n");
        return;
    }

    var rawBounds = [];
    for (var i = 0; i < numOnsets; i++) {
        var v = onsets.peek(1, i, 1);
        var f = Math.floor(v[0]);
        rawBounds.push(f);
    }
    post("analyze: raw onsets = " + rawBounds.join(",") + "\n");

    var bounds = rawBounds.slice();
    if (bounds.length === 0 || bounds[0] > 0) bounds.unshift(0);
    if (bounds[bounds.length - 1] < sourceLen - 1) bounds.push(sourceLen);
    for (var i = 0; i < bounds.length; i++) {
        if (bounds[i] < 0) bounds[i] = 0;
        if (bounds[i] > sourceLen) bounds[i] = sourceLen;
    }

    var bufmfcc = this.patcher.getnamed("bufmfcc");
    var bufstats = this.patcher.getnamed("bufstats");
    var dataset = this.patcher.getnamed("descriptors");

    if (!bufmfcc || !bufstats || !dataset) {
        post("analyze: missing named objects (bufmfcc/bufstats/descriptors)\n");
        return;
    }

    dataset.message("clear");

    var kept = 0;
    var skipped = 0;
    for (var i = 0; i < bounds.length - 1; i++) {
        var start = bounds[i];
        var len = bounds[i + 1] - bounds[i];
        if (len < MIN_SLICE) { skipped++; continue; }
        if (start + len > sourceLen) len = sourceLen - start;
        if (len < MIN_SLICE) { skipped++; continue; }

        bufmfcc.message("startframe", start);
        bufmfcc.message("numframes", len);
        bufmfcc.message("bang");

        bufstats.message("bang");

        dataset.message("addpoint", "slice_" + kept, "mfcc_mean");
        kept++;
    }

    post("analyze: added " + kept + " points, skipped " + skipped + " short slices\n");
    outlet(1, kept);
    outlet(0, "bang");
}
