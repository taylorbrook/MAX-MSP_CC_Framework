// minitaur-voice.js -- monophonic voice allocator
// inlet 0:  "note vel" lists (vel 0 = note off), "priority N" (0 low, 1 high, 2 last),
//           "trigmode N" (0 Legato ON = no retrigger on overlapping notes,
//           1 Legato OFF / 2 EG Reset = retrigger; reset shape lives in gen~), "clear"
// outlets:  0 note (clamped 0-72), 1 velocity, 2 gate 0/1, 3 retrigger toggle (flips 0/1),
//           4 overlap flag (1 = note sounded while another key was held; drives legato glide)

inlets = 1;
outlets = 5;

var held = [];      // held notes, oldest first
var vels = {};      // velocity per held note
var prio = 2;        // Last (Minitaur default)
var legatoMode = 1;  // trig mode 0 = Legato ON
var current = -1;
var trigState = 0;

function select() {
    if (held.length === 0) return -1;
    if (prio === 2) return held[held.length - 1];
    var best = held[0];
    for (var i = 1; i < held.length; i++) {
        if (prio === 0 ? held[i] < best : held[i] > best) best = held[i];
    }
    return best;
}

function sound(n, retrig, overlap) {
    current = n;
    outlet(4, overlap ? 1 : 0);
    outlet(1, vels[n]);
    outlet(0, Math.max(0, Math.min(72, n)));
    outlet(2, 1);
    if (retrig) {
        trigState = 1 - trigState;
        outlet(3, trigState);
    }
}

function list(n, v) {
    n = Math.floor(n);
    var i = held.indexOf(n);
    if (i >= 0) held.splice(i, 1);
    var wasHeld = held.length > 0;

    if (v > 0) {
        held.push(n);
        vels[n] = v;
        var target = select();
        if (!wasHeld) sound(target, true, false);
        else if (target !== current) sound(target, !legatoMode, true);
    } else {
        delete vels[n];
        if (held.length === 0) {
            outlet(2, 0);
        } else {
            var back = select();
            if (back !== current) sound(back, !legatoMode, true);
        }
    }
}

function priority(p) {
    prio = Math.max(0, Math.min(2, Math.floor(p)));
}

function trigmode(m) {
    legatoMode = Math.floor(m) === 0 ? 1 : 0;
}

function clear() {
    held = [];
    vels = {};
    outlet(2, 0);
}
