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

    post("analyze: onsets channelcount=" + onsets.channelcount() + "\n");
    var sampleC1 = onsets.peek(1, 0, 1);
    var sampleC0 = onsets.peek(0, 0, 1);
    post("analyze: probe ch=1 -> " + JSON.stringify(sampleC1) + " ch=0 -> " + JSON.stringify(sampleC0) + "\n");
    var batch = onsets.peek(1, 0, numOnsets);
    post("analyze: batch peek ch=1 type=" + (typeof batch) + " len=" + (batch && batch.length) + " first3=" + (batch ? [batch[0], batch[1], batch[2]].join(",") : "null") + "\n");

    var rawBounds = [];
    for (var i = 0; i < numOnsets; i++) {
        var f = batch && batch[i];
        if (typeof f !== "number" || isNaN(f)) {
            f = onsets.peek(1, i, 1);
            f = (f && f[0]) || 0;
        }
        rawBounds.push(Math.floor(f));
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
    var bufflatten = this.patcher.getnamed("bufflatten");
    var dataset = this.patcher.getnamed("descRef");

    if (!bufmfcc || !bufstats || !bufflatten || !dataset) {
        post("analyze: missing named objects (bufmfcc/bufstats/bufflatten/descriptors)\n");
        return;
    }

    dataset.message("clear");
    var slicecoll = this.patcher.getnamed("slicecoll");
    if (slicecoll) slicecoll.message("clear");

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
        bufflatten.message("bang");

        dataset.message("addpoint", kept + "", "mfcc_flat");
        if (slicecoll) slicecoll.message(kept, start, len);
        kept++;
    }

    post("analyze: added " + kept + " points, skipped " + skipped + " short slices\n");
    dataset.message("print");

    var keptFinal = kept;
    var doneTask = new Task(function() {
        outlet(1, keptFinal);
        outlet(0, "bang");
    }, this);
    doneTask.schedule(100);
}
