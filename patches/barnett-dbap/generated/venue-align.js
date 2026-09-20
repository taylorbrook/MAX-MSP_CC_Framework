// venue-align.js -- host alignment delays for barnett-dbap v0.5 (context.md D23)
// Reads speakers::sN::delayMs (default 0) from the shared "venue" dict and sets the host's
// mc.delay~ per channel. Port of the plugin's alignment stage (GainStage.cpp): delay in SAMPLES
// = ms * sr / 1000, the 0..50 ms rail (VenueGeometry.h kMaxAlignDelayMs), and a zero delay is a
// true bypass: an int 0 in delay~'s right inlet is "no delay", so the default venue is
// bit-transparent.
//
// Per-channel values go out as "setvalue N samples" into mc.delay~'s RIGHT inlet. The mc wrapper
// reference says setvalue works in any inlet; a bare list or a float would not distribute
// (memory: feedback_mc_applyvalues). Int samples keep delay~ on its non-interpolating path; a
// signal-driven delay time would add one sample of latency to every channel.
//
// inlet 0 messages:
//   venue / bang   re-read the dict and resend (the host broadcasts "venue" after a dict read)
//   sr f           sample rate from dspstate~ (fires when DSP starts); resends
//
// outlet 0: "setvalue N samples"  -> mc.delay~ 9600 @chans 8, right inlet
// outlet 1: "set <text>"          -> status comment (venue name, alignment summary)

inlets = 1;
outlets = 2;

var NSPK = 8;
var K_MAX_ALIGN_DELAY_MS = 50.0;
var MAX_SAMPLES = 9600;          // the mc.delay~ memory: 50 ms at 192 kHz
var sampleRate = 48000.0;
var delaysMs = [0, 0, 0, 0, 0, 0, 0, 0];
var venueName = "";

function readVenue() {
    var name = "";
    for (var i = 0; i < NSPK; i++) delaysMs[i] = 0;
    try {
        var d = new Dict("venue");
        var nm = d.get("name");
        if (typeof nm === "string") name = nm;
        for (var k = 1; k <= NSPK; k++) {
            var v = d.get("speakers::s" + k + "::delayMs");
            if (typeof v !== "number" || !isFinite(v)) v = 0;   // older venues carry no delayMs
            if (v < 0) v = 0;
            if (v > K_MAX_ALIGN_DELAY_MS) v = K_MAX_ALIGN_DELAY_MS;
            delaysMs[k - 1] = v;
        }
    } catch (e) {
        post("venue-align.js: venue dict unavailable (" + e.message + "), all delays 0\n");
    }
    venueName = name;
}

function send() {
    var maxMs = 0;
    for (var i = 0; i < NSPK; i++) {
        var n = Math.round(delaysMs[i] * sampleRate / 1000.0);
        if (n < 0) n = 0;
        if (n > MAX_SAMPLES) n = MAX_SAMPLES;
        outlet(0, "setvalue", i + 1, n);
        if (delaysMs[i] > maxMs) maxMs = delaysMs[i];
    }
    var label = venueName.length > 44 ? venueName.substring(0, 43) + "..." : venueName;
    var txt = (label.length ? label + "   |   " : "");
    if (maxMs > 0) {
        txt += "align on, max " + maxMs.toFixed(2) + " ms at " + (sampleRate / 1000).toFixed(1) + " kHz";
    } else {
        txt += "align off (all speakers 0 ms)";
    }
    outlet(1, "set", txt);
}

function venue() {
    readVenue();
    send();
}

function bang() {
    venue();
}

function loadbang() {
    venue();
}

function sr(v) {
    if (typeof v === "number" && v > 0 && v !== sampleRate) {
        sampleRate = v;
        send();
    }
}

function anything() {
    post("venue-align.js: unknown message " + messagename + "\n");
}
