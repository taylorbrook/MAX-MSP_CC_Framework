// cues_engine.js  --  psycography cue / section manager (Module: cues)
//
// Models the piece as an ordered list of SECTIONS, each CLICK (sample-accurate,
// master clock runs) or FREE (conductor-led, clock parked). Sample-accuracy only
// needs to hold WITHIN a click section; a free section is a gap where the clock
// waits. Re-entry uses the transport's seek + GO primitive.
//
// A click run flows continuously through consecutive click sections and auto-stops
// at the next FREE section (endstop armed at that free section's start). On the
// transport's "ended" notification we advance into that free section and wait.
//
// Inlet 0 messages:
//   clearsections                 -- empty the list
//   addsection <start> <type>     -- append (type: 1=click, 0=free)
//   go            / bang          -- operator: advance to next section
//   jump <n>                      -- rehearsal: jump to section n (1-based)
//   ended                         -- transport auto-stopped at a free boundary
//   reset                         -- back to "before section 1"
// Outlet 0: transport commands (seekmeasure / endstopmeasure / endstop / go / stop)
// Outlet 1: status  ->  "section <n> <startMeasure> <type> <total>"
// Outlet 2: hooks    ->  "clickmute 0|1"  (+ free-audio cues later)

autowatch = 1;
inlets = 1;
outlets = 3;

var DISABLE = 1000000000;   // endstop threshold that is never reached = disarmed
var sections = [];          // [{start, type}]
var cur = -1;

function clearsections() { sections = []; cur = -1; }

function addsection() {
    var a = arrayfromargs(arguments);
    if (a.length < 2) { post("cues: addsection needs <start> <type>\n"); return; }
    sections.push({ start: a[0], type: a[1] });
}

function nextFree(i) {
    for (var k = i + 1; k < sections.length; k++) {
        if (sections[k].type === 0) return k;
    }
    return -1;
}

function status() {
    if (cur < 0 || cur >= sections.length) {
        outlet(1, "section", 0, 0, 0, sections.length);
    } else {
        outlet(1, "section", cur + 1, sections[cur].start, sections[cur].type, sections.length);
    }
}

function enterClick(i) {
    outlet(2, "clickmute", 0);                       // click on
    outlet(0, "seekmeasure", sections[i].start);
    var j = nextFree(i);
    if (j >= 0) outlet(0, "endstopmeasure", sections[j].start);  // stop at next free
    else        outlet(0, "endstop", DISABLE);                   // run to natural end
    outlet(0, "go");
    cur = i; status();
}

function enterFree(i) {
    outlet(0, "stop");
    outlet(0, "endstop", DISABLE);
    outlet(2, "clickmute", 1);                       // click off
    cur = i; status();
}

function go() {
    if (sections.length === 0) { post("cues: no sections loaded\n"); return; }
    var n = cur + 1;
    if (n >= sections.length) { post("cues: already at last section\n"); return; }
    if (sections[n].type === 1) enterClick(n); else enterFree(n);
}

function jump(n) {                                    // 1-based rehearsal jump
    var i = n - 1;
    if (i < 0 || i >= sections.length) { post("cues: jump out of range\n"); return; }
    if (sections[i].type === 1) enterClick(i); else enterFree(i);
}

// Transport auto-stopped at the armed free boundary -> enter that free section.
function ended() {
    var j = nextFree(cur);
    if (j >= 0) {
        cur = j;
        outlet(0, "endstop", DISABLE);
        outlet(2, "clickmute", 1);
        status();
    }
}

function reset() { cur = -1; status(); }
function bang() { go(); }
