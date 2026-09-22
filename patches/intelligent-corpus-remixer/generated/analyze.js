// analyze.js -- turn the onset buffer into per-slice MFCC descriptors.
//
// Reads buffer~ onsets (channel 1 = onset frame indices) and buffer~ source,
// builds slice bounds (short segments are merged into their predecessor rather
// than dropped, so the corpus covers the whole file), then drives the named
// fluid.buf*~ objects in the parent patcher per slice and fills
// fluid.dataset~ descriptors + coll slice_meta.
//
// outlet 0: bang when done
// outlet 1: slice count

inlets = 1;
outlets = 2;

var MIN_SLICE = 4096;

function buffer() {
    bang();
}

function anything() {
    bang();
}

function readOnsets(onsets, numOnsets) {
    var vals = [];
    var batch = onsets.peek(1, 0, numOnsets);
    if (typeof batch === "number") batch = [batch];
    for (var i = 0; i < numOnsets; i++) {
        var f = batch && batch[i];
        if (typeof f !== "number" || isNaN(f)) {
            f = onsets.peek(1, i, 1);
            if (Array.isArray(f)) f = f[0];
            if (typeof f !== "number" || isNaN(f)) f = 0;
        }
        vals.push(Math.floor(f));
    }
    return vals;
}

function sliceBounds(onsetFrames, sourceLen) {
    var bounds = onsetFrames.slice();
    if (bounds.length === 0 || bounds[0] > 0) bounds.unshift(0);
    if (bounds[bounds.length - 1] < sourceLen - 1) bounds.push(sourceLen);
    for (var i = 0; i < bounds.length; i++) {
        if (bounds[i] < 0) bounds[i] = 0;
        if (bounds[i] > sourceLen) bounds[i] = sourceLen;
    }

    // greedy merge: absorb sub-MIN_SLICE segments into the running slice
    var slices = [];
    var start = bounds[0];
    for (var j = 1; j < bounds.length; j++) {
        var end = bounds[j];
        if (end - start >= MIN_SLICE) {
            slices.push([start, end - start]);
            start = end;
        }
    }
    if (start < sourceLen) {
        if (slices.length > 0) {
            var last = slices[slices.length - 1];
            last[1] = sourceLen - last[0];
        } else if (sourceLen - start >= MIN_SLICE) {
            slices.push([start, sourceLen - start]);
        }
    }
    return slices;
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

    var bufmfcc = this.patcher.getnamed("bufmfcc");
    var bufstats = this.patcher.getnamed("bufstats");
    var bufflatten = this.patcher.getnamed("bufflatten");
    var dataset = this.patcher.getnamed("descRef");
    var slicecoll = this.patcher.getnamed("slicecoll");

    if (!bufmfcc || !bufstats || !bufflatten || !dataset) {
        post("analyze: missing named objects (bufmfcc/bufstats/bufflatten/descRef)\n");
        return;
    }

    var slices = sliceBounds(readOnsets(onsets, numOnsets), sourceLen);

    dataset.message("clear");
    if (slicecoll) slicecoll.message("clear");

    for (var i = 0; i < slices.length; i++) {
        var start = slices[i][0];
        var len = slices[i][1];

        bufmfcc.message("startframe", start);
        bufmfcc.message("numframes", len);
        bufmfcc.message("bang");
        bufstats.message("bang");
        bufflatten.message("bang");

        dataset.message("addpoint", i + "", "mfcc_flat");
        if (slicecoll) slicecoll.message(i, start, len);
    }

    post("analyze: " + slices.length + " slices from " + numOnsets + " onsets\n");

    var count = slices.length;
    var doneTask = new Task(function() {
        outlet(1, count);
        outlet(0, "bang");
    }, this);
    doneTask.schedule(100);
}
