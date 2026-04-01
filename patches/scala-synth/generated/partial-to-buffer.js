// partial-to-buffer.js -- Writes multislider values to buffer~ partial-amps
// Connected to multislider outlet 0 (user interaction output)
inlets = 1;
outlets = 0;

function list() {
    var args = arrayfromargs(arguments);
    var buf = new Buffer("partial-amps");
    for (var i = 0; i < args.length; i++) {
        buf.poke(1, i + 1, args[i]);
    }
}

function bang() {}
