inlets = 1;
outlets = 2;

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

    if (numOnsets === 0 || sourceLen === 0) {
        post("analyze: source or onsets buffer empty\n");
        return;
    }

    var bounds = [];
    for (var i = 0; i < numOnsets; i++) {
        var v = onsets.peek(1, i, 1);
        bounds.push(Math.floor(v[0]));
    }
    if (bounds.length === 0 || bounds[0] > 0) bounds.unshift(0);
    if (bounds[bounds.length - 1] < sourceLen) bounds.push(sourceLen);

    var bufmfcc = this.patcher.getnamed("bufmfcc");
    var bufstats = this.patcher.getnamed("bufstats");
    var dataset = this.patcher.getnamed("descriptors");

    if (!bufmfcc || !bufstats || !dataset) {
        post("analyze: missing named objects (bufmfcc/bufstats/descriptors)\n");
        return;
    }

    dataset.message("clear");

    var kept = 0;
    for (var i = 0; i < bounds.length - 1; i++) {
        var start = bounds[i];
        var len = bounds[i + 1] - bounds[i];
        if (len < 1024) continue;

        bufmfcc.message("startframe", start);
        bufmfcc.message("numframes", len);
        bufmfcc.message("bang");

        bufstats.message("bang");

        dataset.message("addpoint", "slice_" + kept, "mfcc_mean");
        kept++;
    }

    post("analyze: added " + kept + " points to descriptors dataset\n");
    outlet(1, kept);
    outlet(0, "bang");
}
