inlets = 1;
outlets = 1;
autowatch = 1;

function bang() {
    var buf = new Buffer("rcc_indices");
    var n = buf.framecount();

    if (!n || n === 0) {
        post("read_indices: rcc_indices buffer empty\n");
        return;
    }

    var batch = buf.peek(1, 0, n);
    if (!batch || batch.length === 0) batch = buf.peek(0, 0, n);

    var result = [];
    for (var i = 0; i < n; i++) {
        var f = batch && batch[i];
        if (typeof f !== "number" || isNaN(f)) {
            var single = buf.peek(1, i, 1);
            f = (single && single[0]) || 0;
        }
        result.push(Math.floor(f));
    }

    post("read_indices: " + n + " onsets -> " + result.slice(0, 8).join(",") + (n > 8 ? "..." : "") + "\n");
    outlet(0, result);
}
