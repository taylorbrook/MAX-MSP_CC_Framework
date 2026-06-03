// clicks_engine.js  --  psycography click scheduler pointer (Module: click)
//
// Sample-accurate click timing is done in the SIGNAL domain (receive~ master >=~
// sig~<threshold> -> edge~). This js owns only the bookkeeping that the signal
// domain can't: which event is "next", and re-syncing that pointer after a seek.
//
// Lifecycle per event:
//   1. seek(S) or load -> pointer = first event whose sample >= S; arm its sample
//      as the crossing threshold (outlet 0 -> sig~).
//   2. master reaches the threshold -> edge~ rising bang -> fire():
//        emit this event's TYPE (outlet 1 -> synth selector), advance the pointer,
//        arm the next event's sample as the new threshold.
//
// Events are loaded by dumping the clicks coll and prepending "add":
//   clear, then  add <sample> <type>  per entry (type 0=beat, 1=accent, 2=subdiv).
//
// Inlet 0 messages:
//   clear                  -- empty the event list
//   add <sample> <type>    -- append one event (sorted lazily before use)
//   seek <sample>          -- re-sync pointer to first event >= sample; arm threshold
//   fire / bang            -- master crossed the threshold: emit type, advance, arm next
//   reset                  -- pointer to start; arm first event
//   count                  -- post the loaded event count (debug)
// Outlet 0: next crossing threshold (sample)  -> sig~
// Outlet 1: fired event type (0/1/2)          -> synth selector
// Outlet 2: status / debug (loaded count, "armed <sample>", "done")

autowatch = 1;
inlets = 1;
outlets = 3;
setinletassist(0, "clear / add sample type / seek sample / fire / reset");
setoutletassist(0, "next threshold sample -> sig~");
setoutletassist(1, "fired event type 0=beat 1=accent 2=subdiv -> synth");
setoutletassist(2, "status / debug");

var FAR = 1e12;     // threshold that master never reaches = disarmed / past end
var events = [];     // [ [sample, type], ... ] ascending by sample
var ptr = 0;
var dirty = false;

function clear() { events = []; ptr = 0; dirty = false; }

// add <sample> <type>
function add() {
    var a = arrayfromargs(arguments);
    if (a.length < 2) { post("clicks: 'add' needs sample type\n"); return; }
    events.push([a[0], a[1]]);
    dirty = true;
}

function _sort() {
    if (dirty) {
        events.sort(function (x, y) { return x[0] - y[0]; });
        dirty = false;
    }
}

// arm the crossing threshold for the current pointer (or FAR if past the end)
function _arm() {
    if (ptr >= 0 && ptr < events.length) {
        outlet(0, events[ptr][0]);
        outlet(2, "armed", events[ptr][0]);
    } else {
        outlet(0, FAR);
        outlet(2, "done");
    }
}

// binary search: first index with sample >= s
function seek(s) {
    _sort();
    var lo = 0, hi = events.length;
    while (lo < hi) {
        var mid = (lo + hi) >> 1;
        if (events[mid][0] < s) lo = mid + 1;
        else hi = mid;
    }
    ptr = lo;
    _arm();
}

// master crossed the current threshold: emit type, advance, arm next
function fire() {
    _sort();
    if (ptr < 0 || ptr >= events.length) { outlet(0, FAR); return; }
    outlet(1, events[ptr][1]);   // type -> synth selector
    ptr++;                       // advance
    _arm();                      // load next threshold
}

function bang() { fire(); }

function reset() { ptr = 0; _sort(); _arm(); }

function count() { outlet(2, "count", events.length); }
