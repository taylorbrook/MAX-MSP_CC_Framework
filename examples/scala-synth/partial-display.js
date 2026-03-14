// partial-display.js -- Computes partial amplitudes for multislider
// Inlets: 0 = num_partials (int), 1 = tilt (float), 2 = even_odd (float)
// Outlet 0: list of 32 amplitude values

inlets = 3;
outlets = 1;

var num_partials = 8;
var tilt = 1.0;
var even_odd = 0.5;

function msg_int(v) {
    if (inlet === 0) {
        num_partials = Math.max(1, Math.min(32, v));
        compute();
    }
}

function msg_float(v) {
    if (inlet === 1) {
        tilt = v;
        compute();
    } else if (inlet === 2) {
        even_odd = v;
        compute();
    }
}

function bang() { compute(); }

function compute() {
    var amps = [];
    for (var i = 0; i < 32; i++) {
        var n = i + 1;
        if (n > num_partials) {
            amps.push(0);
        } else {
            var amp = 1.0 / Math.pow(n, tilt);
            if (n > 1) {
                var is_even = (n % 2 === 0);
                if (is_even) {
                    amp *= Math.min(1, Math.max(0, even_odd * 2));
                } else {
                    amp *= Math.min(1, Math.max(0, (1 - even_odd) * 2));
                }
            }
            amps.push(amp);
        }
    }
    outlet(0, amps);
}

function loadbang() { compute(); }