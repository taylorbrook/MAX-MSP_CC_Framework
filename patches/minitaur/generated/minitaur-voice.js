// minitaur-voice.js -- monophonic voice allocator
// inlet 0:  "note vel" lists (vel 0 = note off), "priority N" (0 low, 1 high, 2 last),
//           "legato N" (1 = no envelope retrigger on overlapping notes), "clear"
// outlets:  0 note (clamped 0-72), 1 velocity, 2 gate 0/1, 3 retrigger toggle (flips 0/1)

inlets = 1;
outlets = 4;

var held = [];      // held notes, oldest first
var vels = {};      // velocity per held note
var prio = 0;
var legatoMode = 0;
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

function sound(n, retrig) {
    current = n;
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
        if (!wasHeld) sound(target, true);
        else if (target !== current) sound(target, !legatoMode);
    } else {
        delete vels[n];
        if (held.length === 0) {
            outlet(2, 0);
        } else {
            var back = select();
            if (back !== current) sound(back, !legatoMode);
        }
    }
}

function priority(p) {
    prio = Math.max(0, Math.min(2, Math.floor(p)));
}

function legato(l) {
    legatoMode = l > 0.5 ? 1 : 0;
}

function clear() {
    held = [];
    vels = {};
    outlet(2, 0);
}
