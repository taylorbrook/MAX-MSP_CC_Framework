// ji-engine.js -- TuningEngine + ChordGenerator port from O-IntonationPad v2.8.4
// 12-note/no-KBM tuning path, corrected to true scale tuning (2026-08-19):
//   freq = 12TET(tonic in note's octave, A4, stretch)
//          * 2^(scaleCents[(pc - tonic) % 12] / 1200)
// Interval cents are anchored on the TONIC's 12-TET frequency, so a degree
// marked 9/8 sounds a true 9/8 (203.91c) above the tonic. The VST's original
// path (TuningEngine.cpp:729-740) anchored on each note's OWN 12-TET frequency,
// which stacked the 12-TET semitone distance on top of the scale cents and
// nearly doubled every interval (9/8 landed on E, not D). That "signature"
// behaviour was ported verbatim through v0.8.0 and deliberately reversed here
// at the user's request -- do not restore it.
// Chord voicing is a verbatim port of ChordGenerator.cpp (all 7 voicing modes),
// plus a MAX-only mode 7 "Random" (2026-08-20): intervals drawn from the
// enabled-degree pool in a random order rolled once per note-on, so when more
// ratios are enabled than voiceCount the sounding subset is a fresh random
// pick on every note. Like the VST, all 12 sub-voices are always generated
// (thresholds i/12*0.85) and voiceCount/complexity gate their gains in real
// time on held notes.

inlets = 1;
outlets = 7;
// outlet 0: 12-element frequency list (Hz)      -> mc.sig~ (freq lane)
// outlet 1: 12-element LEFT gain list (0..1)    -> mc.sig~ (gain lane L)
// outlet 2: gate (velocity/127 on note-on, 0 on note-off) -> adsr~
// outlet 3: [degree, cents] pairs               -> route -> readouts
// outlet 4: 12-element RIGHT gain list (0..1)   -> mc.sig~ (gain lane R)
// outlet 5: applyvalues param messages          -> mc.gen~ (per-instance
//           spacingratio/inversionratio/spacingthresh/inversionthresh/lfoofs)
// outlet 6: [degree, ratiotext] pairs           -> p ratioset -> textedits
//           (refreshes the ratio table display on temperament preset load)
// The SOUNDING PITCHES table is driven directly through named comment boxes
// in the parent patcher (pd_f<row>/pd_i<row>/pd_n<row>) -- no outlet, no cords.

var SCALE_SIZE = 12;
var MAX_SUB_VOICES = 12;

// jsthis, captured at load -- used to reach the display comment boxes by
// varname. Captured here rather than read as this.patcher at call time so
// the lookup also works from Task callbacks (unmuteVoice).
var JSOBJ = this;
var NOTE_NAMES = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"];
var dispCells = null;   // lazily resolved [[freqCell, intervalCell, noteCell], ...]

// Default scale: harmonics 16-30, octave-reduced (spans 23-limit)
var ratios = [
    [1, 1], [17, 16], [9, 8], [19, 16], [5, 4], [21, 16],
    [11, 8], [23, 16], [3, 2], [13, 8], [7, 4], [15, 8]
];
var scaleCents = [];

// Built-in temperament presets -- verbatim port of TuningEngine.cpp preset
// tables (cents from C). Where a table is exact JI (Pythagorean, Zarlino,
// Just Intonation) the entries are ratio strings (identical cents via
// 1200*log2(n/d)); tempered scales use the VST's cent values with the "c"
// suffix understood by parseRatioText. Index 0 restores the default scale.
// Bohlen-Pierce (13-EDO over 3:1, mapped to 12 notes) flows through the same
// signature path -- cents applied on top of 12-TET -- exactly like the VST.
var TEMPERAMENTS = [
    { name: "Custom (harm 16-30)", vals: ["1/1", "17/16", "9/8", "19/16", "5/4", "21/16", "11/8", "23/16", "3/2", "13/8", "7/4", "15/8"] },
    { name: "12-TET", vals: ["0c", "100c", "200c", "300c", "400c", "500c", "600c", "700c", "800c", "900c", "1000c", "1100c"] },
    { name: "Pythagorean", vals: ["1/1", "2187/2048", "9/8", "32/27", "81/64", "4/3", "729/512", "3/2", "6561/4096", "27/16", "16/9", "243/128"] },
    { name: "Zarlino (Just Major)", vals: ["1/1", "16/15", "9/8", "6/5", "5/4", "4/3", "7/5", "3/2", "8/5", "5/3", "9/5", "15/8"] },
    { name: "Meantone 1/4", vals: ["0c", "76.05c", "193.16c", "310.26c", "386.31c", "503.42c", "579.47c", "696.58c", "772.63c", "889.74c", "1006.84c", "1082.89c"] },
    { name: "Werckmeister III", vals: ["0c", "90.225c", "192.18c", "294.135c", "390.225c", "498.045c", "588.27c", "696.09c", "792.18c", "888.27c", "996.09c", "1092.18c"] },
    { name: "Kirnberger III", vals: ["0c", "90.18c", "193.16c", "294.13c", "386.31c", "498.04c", "590.22c", "696.58c", "792.18c", "889.74c", "996.09c", "1088.27c"] },
    { name: "Vallotti", vals: ["0c", "94.13c", "196.09c", "298.04c", "392.18c", "501.96c", "592.18c", "698.04c", "796.09c", "894.13c", "1000c", "1090.22c"] },
    { name: "Well Tempered", vals: ["0c", "94.135c", "196.09c", "298.045c", "392.18c", "500c", "594.135c", "698.045c", "796.09c", "894.135c", "1000c", "1092.18c"] },
    { name: "Just Intonation", vals: ["1/1", "16/15", "9/8", "6/5", "5/4", "4/3", "7/5", "3/2", "8/5", "5/3", "16/9", "15/8"] },
    { name: "Bohlen-Pierce", vals: ["0c", "146.3c", "292.6c", "438.9c", "585.2c", "731.5c", "877.8c", "1024.1c", "1170.4c", "1316.7c", "1463c", "1609.3c"] }
];

var enabled = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
var voiceCount = 5;      // 2..12, gates sub-voice gains (WavetableVoice.cpp:213)
var complexityAmt = 0.5; // 0..1, crossfades sub-voices in (WavetableVoice.cpp:203-210)
var voicingModeIdx = 0;  // 0 Free, 1 Close, 2 Open, 3 Drop2, 4 Thirds, 5 Quartal, 6 Quintal, 7 Random
var tonicIdx = 0;        // drives tuning tonic AND chord keyRoot
var a4 = 440.0;          // masterTune, 400..480
var octaveStretch = 1.0; // 0.95..1.25

var heldNote = -1;
var heldVel = 0;

// Chord-feel params (ChordGenerator/WavetableVoice port, v1.13.0 semantics)
var stereoSpreadAmt = 0.5;  // 0..1; live on held notes (VST caches per block)
var detuneRandomAmt = 5.0;  // 0..50 cents; rolled once per noteOn (startNote)
var timingRandomAmt = 10.0; // 0..100 ms onset stagger; rolled once per noteOn

// Per-noteOn random state (WavetableVoice::startNote). Rerolled on every
// note-on, held constant while the note sustains -- param changes to detune/
// timing affect the NEXT note only, matching the VST's cached-at-startNote
// behavior. stereoSpread scales the stored panFactors live.
var centOffsets = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
var panFactors = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
var onsetMask = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
var staggerTasks = [];

// Spacing/inversion octave randomization (WavetableVoice.cpp:172-198):
// per sub-voice, rolled at noteOn -- octave shift counts (1-3, weighted
// 60/30/10) and activation thresholds [0,1). Live knob position vs threshold
// gates the octave copies in the gen~ codebox (250 ms crossfade there).
var spacingOcts = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
var inversionOcts = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
var spacingThresh = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
var inversionThresh = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];

// v1.14 ensemble movement: per-sub-voice LFO phase offsets (root tracks the
// global LFO phase exactly; others get a random 0..2pi offset at noteOn)
var lfoOffsets = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

// Mode 7 "Random" shuffle keys: one float per interval-pool slot, rolled at
// noteOn (rollNoteRandoms). generateChord sorts pool indices by these keys,
// so the random interval order is stable while a note is held (param tweaks
// don't reshuffle) and rerolls on every new note-on. Initial ascending values
// make the pre-first-note order the identity (same as Close).
var randKeys = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];

var VOICING_NAMES = {
    "free": 0, "close": 1, "open": 2, "drop2": 3, "drop-2": 3,
    "thirds": 4, "quartal": 5, "quintal": 6, "random": 7
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
    // TuningEngine::calculateCustomFrequencyUnlocked, 12-note/no-KBM path,
    // corrected: the scale cents ride on the tonic of the note's octave, not
    // on the note itself. `note - relativePitch` is the MIDI note of the tonic
    // at or below `note`, so degree 0 sits exactly on 12-TET and every other
    // degree is scaleCents[] above it. octaveStretch still applies, via the
    // tonic's 12-TET frequency.
    if (note < 0) note = 0;
    if (note > 127) note = 127;
    var pitchClass = note % 12;
    var relativePitch = (pitchClass - tonicIdx + 12) % 12;
    var baseFreq = calc12TET(note - relativePitch);
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

        case 7: // Random: root anchored on voice 0; remaining intervals drawn
            // from the enabled pool in the per-noteOn shuffled order, cycling
            // with an octave bump once the pool is exhausted. With more
            // enabled ratios than voiceCount, the gated-in voices 0..count-1
            // are therefore a random subset of the pool, rerolled per note.
            var order = [];
            for (i = 1; i < available; i++) order.push(i);
            order.sort(function (a, b) { return randKeys[a] - randKeys[b]; });
            order.unshift(0); // intervals[] is sorted ascending -> [0] is root
            for (i = 0; i < numVoices; i++) {
                intervalIndex = order[i % available];
                octaveShift = Math.floor(i / available);
                voices.push({
                    midiNote: rootMidiNote + intervals[intervalIndex] + (octaveShift * SCALE_SIZE),
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

// --- Note-on randomization (WavetableVoice::startNote port) ---------------

function clampVal(v, lo, hi) {
    return v < lo ? lo : (v > hi ? hi : v);
}

function cancelStagger() {
    for (var k = 0; k < staggerTasks.length; k++) {
        staggerTasks[k].cancel();
    }
    staggerTasks = [];
}

function unmuteVoice(i) {
    onsetMask[i] = 1;
    recomputeOutputs();
}

function randomOctaveShift() {
    // WavetableVoice::getRandomOctaveShift: 60% 1 oct, 30% 2 oct, 10% 3 oct
    var r = Math.random();
    if (r < 0.6) return 1;
    if (r < 0.9) return 2;
    return 3;
}

function rollNoteRandoms() {
    cancelStagger();
    for (var i = 0; i < MAX_SUB_VOICES; i++) {
        // Detune: (rand*2-1)*detuneRandom cents, root included
        centOffsets[i] = (detuneRandomAmt > 0.0)
            ? (Math.random() * 2.0 - 1.0) * detuneRandomAmt
            : 0.0;

        // Pan factor: root centered; else alternating L/R, width ~ index,
        // plus random +/-0.05 ensemble variation (clamped +/-1)
        if (i === 0) {
            panFactors[i] = 0.0;
        } else {
            var width = i / (MAX_SUB_VOICES - 1);
            var direction = (i % 2 === 0) ? -1.0 : 1.0;
            panFactors[i] = clampVal(
                direction * width + (Math.random() * 2.0 - 1.0) * 0.05,
                -1.0, 1.0);
        }

        // Onset stagger: root immediate; else uniform 0..timingRandom ms
        var delayMs = (i === 0 || timingRandomAmt <= 0.0)
            ? 0.0
            : Math.random() * timingRandomAmt;
        if (delayMs < 1.0) {
            onsetMask[i] = 1;
        } else {
            onsetMask[i] = 0;
            var t = new Task(unmuteVoice, this, i);
            t.schedule(delayMs);
            staggerTasks.push(t);
        }

        // Spacing/inversion: independent octave rolls + activation thresholds
        // (rolled for the root too -- only the VST's no-chord fallback pins them)
        spacingOcts[i] = randomOctaveShift();
        inversionOcts[i] = randomOctaveShift();
        spacingThresh[i] = Math.random();
        inversionThresh[i] = Math.random();

        // Mode 7 "Random" voicing: fresh shuffle keys each note-on
        randKeys[i] = Math.random();

        // v1.14: per-sub-voice LFO phase offset (root = 0)
        lfoOffsets[i] = (i === 0) ? 0.0 : Math.random() * 2.0 * Math.PI;
    }

    // Distribute per-instance noteOn state to the mc.gen~ wrapper
    outlet(5, ["applyvalues", "spacingthresh"].concat(spacingThresh));
    outlet(5, ["applyvalues", "inversionthresh"].concat(inversionThresh));
    outlet(5, ["applyvalues", "lfoofs"].concat(lfoOffsets));
}

// --- Sounding-pitch display ---------------------------------------------
// Drives the read-only SOUNDING PITCHES table in the parent patcher. Each
// row is three named comment boxes set via Maxobj.message("set", ...), so
// the table needs no patch cords and no extra outlet.
//
// Columns, per decisions (2026-08-19):
//   freq     -- the actual sounding frequency, detune included
//   interval -- the ratio typed in the scale table for that degree, then the
//               true sounding ratio against sub-voice 1 in parentheses. Since
//               the tuning fix (2026-08-19) these agree to within the per-voice
//               random detune; a residual gap means the two voices sit in
//               different octaves or the detune knob is wide open.
//   note     -- nearest true 12-TET note (scientific octaves, MIDI 60 = C4)
//               referenced to the masterTune a4, so retuning a4 does not
//               offset every reading. octaveStretch shows up in the cents.

function dispResolve() {
    if (dispCells) return dispCells;
    if (!JSOBJ || !JSOBJ.patcher) return null;
    var cells = [];
    for (var r = 0; r < MAX_SUB_VOICES; r++) {
        cells.push([
            JSOBJ.patcher.getnamed("pd_f" + r),
            JSOBJ.patcher.getnamed("pd_i" + r),
            JSOBJ.patcher.getnamed("pd_n" + r)
        ]);
    }
    dispCells = cells;
    return cells;
}

function gcdInt(a, b) {
    a = Math.abs(a);
    b = Math.abs(b);
    while (b > 0.5) {
        var t = a % b;
        a = b;
        b = t;
    }
    return a;
}

function isWholeNumber(v) {
    return isFinite(v) && Math.abs(v - Math.round(v)) < 1e-9;
}

// Exact scale-table factor for a MIDI note: the degree's [num, den] plus the
// octave index above the tonic. Mirrors noteFrequency's degree lookup so the
// displayed ratio always names the degree the engine actually used.
function degreeFactor(n) {
    var rel = (((n - tonicIdx) % SCALE_SIZE) + SCALE_SIZE) % SCALE_SIZE;
    var oct = Math.floor((n - tonicIdx) / SCALE_SIZE);
    return [ratios[rel][0], ratios[rel][1], oct];
}

// Scale-table ratio of note n against note n0, reduced. Returns "" when the
// scale holds cent values rather than rationals (temperament presets store
// 2^(c/1200) as a float numerator) or when the fraction blows up -- the
// actual-ratio decimal beside it still carries the information.
function tableRatioText(n, n0) {
    var a = degreeFactor(n);
    var b = degreeFactor(n0);
    var num = a[0] * b[1];
    var den = a[1] * b[0];
    var d = a[2] - b[2];
    if (d > 0) num *= Math.pow(2, d);
    else if (d < 0) den *= Math.pow(2, -d);
    if (!isWholeNumber(num) || !isWholeNumber(den)) return "";
    num = Math.round(num);
    den = Math.round(den);
    if (num <= 0 || den <= 0 || num > 999999 || den > 999999) return "";
    var g = gcdInt(num, den);
    if (g > 1) {
        num /= g;
        den /= g;
    }
    return num + "/" + den;
}

// Nearest true 12-TET note name + cents deviation, e.g. ["A6", "-31c"].
function noteNameText(f) {
    if (!(f > 0)) return ["", ""];
    var m = 69.0 + 12.0 * Math.log(f / a4) / Math.LN2;
    var n = Math.round(m);
    var cents = Math.round((m - n) * 100.0);
    if (n < 0) n = 0;
    if (n > 127) n = 127;
    var oct = Math.floor(n / 12) - 1;   // scientific pitch: MIDI 60 = C4
    var name = NOTE_NAMES[((n % 12) + 12) % 12] + oct;
    return [name, (cents < 0 ? "-" : "+") + Math.abs(cents) + "c"];
}

function dispSetCell(cell, a, b) {
    if (!cell) return;
    if (b === undefined) cell.message("set", a);
    else cell.message("set", a, b);
}

// Blank every row to the silent marker (no note held / all voices gated).
function dispClear() {
    var cells = dispResolve();
    if (!cells) return;
    for (var r = 0; r < MAX_SUB_VOICES; r++) {
        dispSetCell(cells[r][0], "-");
        dispSetCell(cells[r][1], "-");
        dispSetCell(cells[r][2], "-");
    }
}

// gates[] is the pre-pan voice gain: 0 means voiceCount/complexity/onset
// stagger has silenced that sub-voice, so its row reads as silent.
function updateDisplay(notes, freqs, gates) {
    var cells = dispResolve();
    if (!cells) return;
    var refNote = notes[0];
    var refFreq = freqs[0];
    for (var r = 0; r < MAX_SUB_VOICES; r++) {
        if (!(gates[r] > 0.0)) {
            dispSetCell(cells[r][0], "-");
            dispSetCell(cells[r][1], "-");
            dispSetCell(cells[r][2], "-");
            continue;
        }
        var f = freqs[r];
        dispSetCell(cells[r][0], f >= 1000.0 ? f.toFixed(1) : f.toFixed(2));

        var tab = tableRatioText(notes[r], refNote);
        var act = (refFreq > 0) ? (f / refFreq).toFixed(3) : "?";
        dispSetCell(cells[r][1], tab === "" ? act : tab, tab === "" ? undefined : "(" + act + ")");

        var nn = noteNameText(f);
        dispSetCell(cells[r][2], nn[0], nn[1]);
    }
}

// --- Output --------------------------------------------------------------

function recomputeOutputs() {
    if (heldNote < 0) return;
    var voices = generateChord(heldNote);
    var freqs = [];
    var gainsL = [];
    var gainsR = [];
    var dispNotes = [];
    var dispGates = [];
    var spacingRatios = [];
    var inversionRatios = [];
    var HALF_PI = Math.PI * 0.5;
    for (var i = 0; i < MAX_SUB_VOICES; i++) {
        var note = voices[i].midiNote;
        if (note < 0) note = 0;     // WR-05 clamp
        if (note > 127) note = 127;
        var bf = noteFrequency(note);
        freqs.push(bf * Math.pow(2.0, centOffsets[i] / 1200.0));
        dispNotes.push(note);

        // Spacing (up) / inversion (down) octave-copy freq ratios vs base.
        // Ratio form: detune cancels (VST applies the same centOffset to all
        // three); octaveStretch, MIDI 0/127 clamping, and live tuning edits
        // all track. Octave counts stay fixed while the note is held.
        var sn = note + 12 * spacingOcts[i];
        if (sn > 127) sn = 127;
        var iv = note - 12 * inversionOcts[i];
        if (iv < 0) iv = 0;
        spacingRatios.push(noteFrequency(sn) / bf);
        inversionRatios.push(noteFrequency(iv) / bf);

        // WavetableVoice.cpp:203-213 complexity crossfade + voice-count gate
        var t = voices[i].threshold;
        var g;
        if (t <= 0.0) g = 1.0;
        else if (complexityAmt >= t) g = 1.0;
        else if (complexityAmt <= t - 0.1) g = 0.0;
        else g = (complexityAmt - (t - 0.1)) / 0.1;
        if (i >= voiceCount) g = 0.0;
        g *= onsetMask[i];
        dispGates.push(g);

        // Constant-power pan (WavetableVoice.cpp:347-356): voice 1 clamped
        // near center, pan = panFactor * stereoSpread
        var pan = panFactors[i] * stereoSpreadAmt;
        if (i === 1) pan = clampVal(pan, -0.15, 0.15);
        pan = clampVal(pan, -1.0, 1.0);
        var panAngle = (pan + 1.0) * 0.5;
        gainsL.push(g * Math.cos(panAngle * HALF_PI));
        gainsR.push(g * Math.sin(panAngle * HALF_PI));
    }
    outlet(5, ["applyvalues", "spacingratio"].concat(spacingRatios));
    outlet(5, ["applyvalues", "inversionratio"].concat(inversionRatios));
    outlet(4, gainsR);
    outlet(1, gainsL);
    outlet(0, freqs);
    updateDisplay(dispNotes, freqs, dispGates);
}

// --- Message handlers ----------------------------------------------------

function list(note, vel) {
    if (arguments.length < 2) return;
    note = Math.round(note);
    vel = Math.round(vel);
    if (vel > 0) {
        heldNote = note;
        heldVel = vel;
        rollNoteRandoms();
        recomputeOutputs();
        var gate = vel / 127.0;
        if (gate > 1.0) gate = 1.0;
        outlet(2, gate);
    } else if (note === heldNote) {
        heldNote = -1;
        heldVel = 0;
        outlet(2, 0);
        dispClear();
    }
}

// Parse a ratio field into [n, d] or null. Accepts "3/2", "18 17", decimals
// ("1.5" = ratio), and cents with a trailing "c" ("90.225c", .scl-style).
// textedit may deliver quoted symbols ("18/17"), stray newlines, or odd
// tokenization -- extract the numeric fields instead of trusting atoms.
function parseRatioText(txt) {
    txt = String(txt).replace(/["'\\]/g, "").replace(/\s+/g, "");
    var m = txt.match(/^(-?\d*\.?\d+)c$/i);
    if (m) return [Math.pow(2, parseFloat(m[1]) / 1200.0), 1.0];
    var nums = txt.match(/\d*\.?\d+/g);
    if (nums && nums.length >= 2) return [parseFloat(nums[0]), parseFloat(nums[1])];
    if (nums && nums.length === 1) return [parseFloat(nums[0]), 1.0];
    return null;
}

function ratio(idx) {
    idx = Math.round(idx);
    if (idx < 0 || idx >= SCALE_SIZE) return;
    if (arguments.length < 2) return;
    var raw = [];
    for (var k = 1; k < arguments.length; k++) raw.push(String(arguments[k]));
    var txt = raw.join(" ");
    var nd = parseRatioText(txt);
    if (!nd || !(nd[0] > 0) || !(nd[1] > 0)) {
        post("ji-engine: bad ratio for degree " + idx + " (got: " + txt + ")\n");
        return;
    }
    ratios[idx] = nd;
    computeCents();
    outlet(3, [idx, scaleCents[idx]]);
    recomputeOutputs();
}

function temperament(t) {
    t = Math.round(t);
    if (t < 0 || t >= TEMPERAMENTS.length) return;
    var vals = TEMPERAMENTS[t].vals;
    for (var i = 0; i < SCALE_SIZE; i++) {
        var nd = parseRatioText(vals[i]);
        if (nd) ratios[i] = nd;
    }
    computeCents();
    for (var j = 0; j < SCALE_SIZE; j++) {
        outlet(6, [j, vals[j]]);
        outlet(3, [j, scaleCents[j]]);
    }
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
        if (m > 7) m = 7;
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

function stereospread(s) {
    s = parseFloat(s);
    if (!(s >= 0.0)) s = 0.0;
    if (s > 1.0) s = 1.0;
    stereoSpreadAmt = s;
    recomputeOutputs(); // live on held notes, like the VST's block-rate cache
}

function detunerandom(c) {
    c = parseFloat(c);
    if (!(c >= 0.0)) c = 0.0;
    if (c > 50.0) c = 50.0;
    detuneRandomAmt = c; // takes effect at next noteOn (VST startNote cache)
}

function timingrandom(ms) {
    ms = parseFloat(ms);
    if (!(ms >= 0.0)) ms = 0.0;
    if (ms > 100.0) ms = 100.0;
    timingRandomAmt = ms; // takes effect at next noteOn (VST startNote cache)
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
