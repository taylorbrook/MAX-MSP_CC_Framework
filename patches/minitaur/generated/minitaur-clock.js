// minitaur-clock.js -- LFO MIDI clock sync (Minitaur manual p.24)
// inlet 0:  "tick <ms>" (cpuclock time of each 0xF8 clock), "start" (0xFA), "stop" (0xFC),
//           "sync 0/1" (CC87 / SYNC toggle), "divcc 0-127" (CC86, p.24 bands),
//           "div N" (division index 0-20 from the menu), "rate 0-1" (LFO RATE knob;
//           picks the division only while synced)
// outlets:  0 synced LFO rate in Hz (0 = free-running, use the RATE knob),
//           1 phase-reset counter (steps 0..1023 on start), 2 division index for the display

inlets = 1;
outlets = 3;

// p.24 table, longest to shortest: CC86 band lower bounds and clock ticks per LFO cycle (24 ppqn)
var LOWS  = [0, 7, 13, 19, 25, 31, 37, 43, 49, 55, 61, 68, 74, 80, 86, 92, 98, 104, 110, 116, 122];
var TICKS = [384, 288, 192, 144, 96, 72, 64, 48, 36, 32, 24, 18, 16, 12, 9, 8, 6, 4, 3, 2, 1];
var WINDOW = 24;        // average the tick period over one quarter note
var TIMEOUT_MS = 300;   // no tick for this long = clock stopped arriving

var syncOn = 1;         // CC87 default ON
var present = 0;        // clock ticks currently arriving
var divIdx = 10;        // 1/4 note
var times = [];         // recent tick timestamps (ms)
var lastHz = -1;
var resetState = 0;

var watchdog = new Task(function () {
    present = 0;
    times = [];
    update();
}, this);

function ccToIndex(v) {
    var i = LOWS.length - 1;
    while (i > 0 && v < LOWS[i]) i--;
    return i;
}

function update() {
    var hz = 0;
    if (syncOn && present && times.length >= 2) {
        var tickMs = (times[times.length - 1] - times[0]) / (times.length - 1);
        if (tickMs > 0) hz = 1000 / (tickMs * TICKS[divIdx]);
    }
    if (hz === 0 ? lastHz !== 0 : Math.abs(hz - lastHz) > lastHz * 0.001) {
        lastHz = hz;
        outlet(0, hz);
    }
}

function setDiv(i) {
    i = Math.max(0, Math.min(TICKS.length - 1, Math.floor(i)));
    if (i === divIdx) return;
    divIdx = i;
    outlet(2, divIdx);
    update();
}

function tick(ms) {
    times.push(ms);
    if (times.length > WINDOW + 1) times.shift();
    present = 1;
    watchdog.cancel();
    watchdog.schedule(TIMEOUT_MS);
    update();
}

function start() {
    // keep the tick history: clock ticks run across transport starts, clearing it dropped the synced rate for a tick
    if (syncOn) {
        resetState = (resetState + 1) % 1024;
        outlet(1, resetState);
    }
}

function stop() {
    // Ticks may keep coming after stop; sync follows the ticks, not the transport.
}

function sync(v) {
    syncOn = v ? 1 : 0;
    update();
}

function divcc(v) {
    setDiv(ccToIndex(v));
}

function div(i) {
    setDiv(i);
}

function rate(v) {
    if (syncOn && present) setDiv(ccToIndex(Math.max(0, Math.min(1, v)) * 127));
}

function loadbang() {
    outlet(2, divIdx);
}
