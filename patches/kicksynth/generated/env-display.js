// env-display.js -- Compute envelope curves for function object display
// Receives parameter messages (e.g., "pitch_start 300") from prepend objects.
// Outlet 0 -> pitch envelope function object
// Outlet 1 -> amp envelope function object

inlets = 1;
outlets = 2;

var NUM_POINTS = 32;
var SR = 44100;

var p = {
    pitch_start: 300,
    pitch_end: 50,
    pitch_decay: 30,
    amp_decay: 200,
    pitch_curve: 0.3,
    amp_curve: 0.15
};

function anything() {
    var name = messagename;
    var val = arguments[0];
    if (p.hasOwnProperty(name)) {
        p[name] = val;
        update();
    }
}

function bang() {
    update();
}

function update() {
    var total_time = Math.max(p.pitch_decay * 4, p.amp_decay * 1.5);
    total_time = Math.max(total_time, 50);

    // --- Pitch envelope ---
    outlet(0, "clear");
    outlet(0, "domain", total_time);
    outlet(0, "range", Math.max(p.pitch_end - 10, 10), p.pitch_start + 20);

    var pitch_samples = Math.max(p.pitch_decay * 0.001 * SR, 1);
    var pitch_coeff = Math.exp(-1.0 / (pitch_samples * Math.max(p.pitch_curve, 0.001)));

    for (var i = 0; i < NUM_POINTS; i++) {
        var t = (i / (NUM_POINTS - 1)) * total_time;
        var samples_at_t = t * 0.001 * SR;
        var env = Math.pow(pitch_coeff, samples_at_t);
        var freq = p.pitch_end + (p.pitch_start - p.pitch_end) * env;
        outlet(0, t, freq);
    }

    // --- Amp envelope ---
    outlet(1, "clear");
    outlet(1, "domain", total_time);
    outlet(1, "range", 0, 1.05);

    var amp_samples = Math.max(p.amp_decay * 0.001 * SR, 1);
    var amp_coeff = Math.exp(-1.0 / (amp_samples * Math.max(p.amp_curve, 0.001)));

    for (var i = 0; i < NUM_POINTS; i++) {
        var t = (i / (NUM_POINTS - 1)) * total_time;
        var samples_at_t = t * 0.001 * SR;
        var env = Math.pow(amp_coeff, samples_at_t);
        outlet(1, t, env);
    }
}
