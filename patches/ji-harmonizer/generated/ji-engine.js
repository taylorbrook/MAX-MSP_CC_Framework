// ji-engine.js -- TuningEngine + ChordGenerator port from O-IntonationPad v2.8.4
// Verbatim port of the 12-note/no-KBM tuning path (TuningEngine.cpp:729-740):
//   freq = 12TET(note, A4, stretch) * 2^(scaleCents[(pc - tonic) % 12] / 1200)
// Interval cents are applied ON TOP of each note's 12-TET frequency -- the
// plugin's documented signature sound. Do not "fix" to textbook JI.
// Chord voicing is a verbatim port of ChordGenerator.cpp (all 7 voicing modes);
// like the VST, all 12 sub-voices are always generated (thresholds i/12*0.85)
// and voiceCount/complexity gate their gains in real time on held notes.

inlets = 1;
outlets = 4;
// outlet 0: 12-element frequency list (Hz)      -> mc.sig~ (freq lane)
// outlet 1: 12-element gain list (0..1)         -> mc.sig~ (gain lane)
// outlet 2: gate (velocity/127 on note-on, 0 on note-off) -> adsr~
// outlet 3: [degree, cents] pairs               -> route -> readouts

var SCALE_SIZE = 12;
var MAX_SUB_VOICES = 12;

// Default scale: harmonics 16-30, octave-reduced (spans 23-limit)
var ratios = [
    [1, 1], [17, 16], [9, 8], [19, 16], [5, 4], [21, 16],
    [11, 8], [23, 16], [3, 2], [13, 8], [7, 4], [15, 8]
];
var scaleCents = [];

var enabled = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
var voiceCount = 5;      // 2..12, gates sub-voice gains (WavetableVoice.cpp:213)
var complexityAmt = 0.5; // 0..1, crossfades sub-voices in (WavetableVoice.cpp:203-210)
var voicingModeIdx = 0;  // 0 Free, 1 Close, 2 Open, 3 Drop2, 4 Thirds, 5 Quartal, 6 Quintal
var tonicIdx = 0;        // drives tuning tonic AND chord keyRoot
var a4 = 440.0;          // masterTune, 400..480
var octaveStretch = 1.0; // 0.95..1.25

var heldNote = -1;
var heldVel = 0;

var VOICING_NAMES = {
    "free": 0, "close": 1, "open": 2, "drop2": 3, "drop-2": 3,
    "thirds": 4, "quartal": 5, "quintal": 6
};

function computeCents() {
    scaleCents = [];
    for (var i = 0; i < SCALE_SIZE; i++) {
        scaleCents.push(1200.0 * Math.log(ratios[i][0] / ratios[i][1]) / Math.LN2);
    }
}
computeCents();

// --- TuningEngine port ---------------------------------------------------

function calc12TET(note) {
    // TuningEngine::calculate12TETFrequency
    return a4 * Math.pow(2.0, ((note - 69) * octaveStretch) / 12.0);
}

function noteFrequency(note) {
    // TuningEngine::calculateCustomFrequencyUnlocked, 12-note/no-KBM path
    if (note < 0) note = 0;
    if (note > 127) note = 127;
    var baseFreq = calc12TET(note);
    var pitchClass = note % 12;
    var relativePitch = (pitchClass - tonicIdx + 12) % 12;
    return baseFreq * Math.pow(2.0, scaleCents[relativePitch] / 1200.0);
}

// --- ChordGenerator port -------------------------------------------------

function findNearestDegree(midiNote, keyRoot, enabledDegrees) {
    var relativeMidi = midiNote - 60 - keyRoot;
    var degree = ((relativeMidi % SCALE_SIZE) + SCALE_SIZE) % SCALE_SIZE;
    var bestDegree = enabledDegrees[0];
    var bestDist = SCALE_SIZE;
    for (var k = 0; k < enabledDegrees.length; k++) {
        var d = enabledDegrees[k];
        var dist = Math.min(Math.abs(degree - d), SCALE_SIZE - Math.abs(degree - d));
        if (dist < bestDist) {
            bestDist = dist;
            bestDegree = d;
        }
    }
    return bestDegree;
}

function buildChordIntervals(rootDegree, enabledDegrees) {
    var intervals = [];
    for (var k = 0; k < enabledDegrees.length; k++) {
        var offset = enabledDegrees[k] - rootDegree;
        if (offset < 0) offset += SCALE_SIZE;
        intervals.push(offset);
    }
    intervals.sort(function (a, b) { return a - b; });
    return intervals;
}

function getThreshold(voiceIndex, totalVoices) {
    if (voiceIndex === 0) return 0.0;
    if (totalVoices <= 1) return 0.0;
    return (voiceIndex / totalVoices) * 0.85;
}

function generateChord(rootMidiNote) {
    var enabledDegrees = [];
    for (var i = 0; i < SCALE_SIZE; i++) {
        if (enabled[i]) enabledDegrees.push(i);
    }
    if (enabledDegrees.length === 0) enabledDegrees.push(0);

    var rootDegree = findNearestDegree(rootMidiNote, tonicIdx, enabledDegrees);
    var intervals = buildChordIntervals(rootDegree, enabledDegrees);
    var available = intervals.length;
    var numVoices = MAX_SUB_VOICES;
    var voices = [];
    var i, intervalIndex, degreeOffset, octaveShift, stackedInterval;

    switch (voicingModeIdx) {
        case 1: // Close: all voices within one octave
            for (i = 0; i < numVoices; i++) {
                intervalIndex = i % available;
                voices.push({
                    midiNote: rootMidiNote + intervals[intervalIndex],
                    threshold: getThreshold(i, numVoices)
                });
            }
            break;

        case 2: // Open: odd-indexed voices shifted up one octave
            for (i = 0; i < numVoices; i++) {
                intervalIndex = i % available;
                octaveShift = (i % 2 !== 0) ? 1 : 0;
                voices.push({
                    midiNote: rootMidiNote + intervals[intervalIndex] + (octaveShift * SCALE_SIZE),
                    threshold: getThreshold(i, numVoices)
                });
            }
            break;

        case 3: // Drop2: close voicing, then 2nd-highest dropped one octave
            for (i = 0; i < numVoices; i++) {
                intervalIndex = i % available;
                voices.push({
                    midiNote: rootMidiNote + intervals[intervalIndex],
                    threshold: getThreshold(i, numVoices)
                });
            }
            voices.sort(function (a, b) { return a.midiNote - b.midiNote; });
            if (voices.length >= 2) {
                voices[voices.length - 2].midiNote -= 12; // always 12 semitones
            }
            break;

        case 4: // Thirds: stacked, interval = round(SCALE_SIZE * 4 / 12)
        case 5: // Quartal: round(SCALE_SIZE * 5 / 12)
        case 6: // Quintal: round(SCALE_SIZE * 7 / 12)
            var k = (voicingModeIdx === 4) ? 4 : (voicingModeIdx === 5) ? 5 : 7;
            stackedInterval = Math.max(1, Math.floor((SCALE_SIZE * k + 6) / 12));
            for (i = 0; i < numVoices; i++) {
                degreeOffset = stackedInterval * i;
                voices.push({
                    midiNote: rootMidiNote + degreeOffset,
                    threshold: getThreshold(i, numVoices)
                });
            }
            break;

        case 0: // Free: spread across octaves
        default:
            for (i = 0; i < numVoices; i++) {
                var octaveOffset;
                if (numVoices <= available) {
                    intervalIndex = i;
                    octaveOffset = 0;
                } else {
                    intervalIndex = Math.floor((i * available) / numVoices);
                    octaveOffset = Math.floor(i / available);
                }
                voices.push({
                    midiNote: rootMidiNote + intervals[intervalIndex] + (octaveOffset * SCALE_SIZE),
                    threshold: getThreshold(i, numVoices)
                });
            }
            break;
    }
    return voices;
}

// --- Output --------------------------------------------------------------

function recomputeOutputs() {
    if (heldNote < 0) return;
    var voices = generateChord(heldNote);
    var freqs = [];
    var gains = [];
    for (var i = 0; i < MAX_SUB_VOICES; i++) {
        var note = voices[i].midiNote;
        if (note < 0) note = 0;     // WR-05 clamp
        if (note > 127) note = 127;
        freqs.push(noteFrequency(note));

        // WavetableVoice.cpp:203-213 complexity crossfade + voice-count gate
        var t = voices[i].threshold;
        var g;
        if (t <= 0.0) g = 1.0;
        else if (complexityAmt >= t) g = 1.0;
        else if (complexityAmt <= t - 0.1) g = 0.0;
        else g = (complexityAmt - (t - 0.1)) / 0.1;
        if (i >= voiceCount) g = 0.0;
        gains.push(g);
    }
    outlet(1, gains);
    outlet(0, freqs);
}

// --- Message handlers ----------------------------------------------------

function list(note, vel) {
    if (arguments.length < 2) return;
    note = Math.round(note);
    vel = Math.round(vel);
    if (vel > 0) {
        heldNote = note;
        heldVel = vel;
        recomputeOutputs();
        var gate = vel / 127.0;
        if (gate > 1.0) gate = 1.0;
        outlet(2, gate);
    } else if (note === heldNote) {
        heldNote = -1;
        heldVel = 0;
        outlet(2, 0);
    }
}

function ratio(idx) {
    idx = Math.round(idx);
    if (idx < 0 || idx >= SCALE_SIZE) return;
    var n, d;
    if (arguments.length >= 3) {
        n = parseFloat(arguments[1]);
        d = parseFloat(arguments[2]);
    } else if (arguments.length === 2) {
        var parts = String(arguments[1]).split("/");
        n = parseFloat(parts[0]);
        d = (parts.length > 1) ? parseFloat(parts[1]) : 1.0;
    } else {
        return;
    }
    if (!(n > 0) || !(d > 0)) {
        post("ji-engine: bad ratio for degree " + idx + "\n");
        return;
    }
    ratios[idx] = [n, d];
    computeCents();
    outlet(3, [idx, scaleCents[idx]]);
    recomputeOutputs();
}

function voicecount(n) {
    n = Math.round(n);
    if (n < 2) n = 2;
    if (n > 12) n = 12;
    voiceCount = n;
    recomputeOutputs();
}

function complexity(c) {
    c = parseFloat(c);
    if (!(c >= 0.0)) c = 0.0;
    if (c > 1.0) c = 1.0;
    complexityAmt = c;
    recomputeOutputs();
}

function voicingmode(m) {
    if (typeof m === "string") {
        var key = m.toLowerCase();
        if (VOICING_NAMES.hasOwnProperty(key)) {
            voicingModeIdx = VOICING_NAMES[key];
        } else {
            post("ji-engine: unknown voicing mode " + m + "\n");
            return;
        }
    } else {
        m = Math.round(m);
        if (m < 0) m = 0;
        if (m > 6) m = 6;
        voicingModeIdx = m;
    }
    recomputeOutputs();
}

function tonic(t) {
    t = Math.round(t);
    if (t < 0) t = 0;
    if (t > 11) t = 11;
    tonicIdx = t;
    recomputeOutputs();
}

function mastertune(f) {
    f = parseFloat(f);
    if (!(f >= 400.0)) f = 400.0;
    if (f > 480.0) f = 480.0;
    a4 = f;
    recomputeOutputs();
}

function stretch(s) {
    s = parseFloat(s);
    if (!(s >= 0.95)) s = 0.95;
    if (s > 1.25) s = 1.25;
    octaveStretch = s;
    recomputeOutputs();
}

function degree(idx, on) {
    idx = Math.round(idx);
    if (idx < 0 || idx >= SCALE_SIZE) return;
    enabled[idx] = on ? 1 : 0;
    recomputeOutputs();
}

function dump() {
    computeCents();
    for (var i = 0; i < SCALE_SIZE; i++) {
        outlet(3, [i, scaleCents[i]]);
    }
}

function bang() {
    dump();
}
