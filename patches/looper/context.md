# looper

Project context and notes.

## Kickoff (2026-08-24)

**Goal:** Record audio input and loop it, pedal-style.

- **Style:** Pedal-style looper — one button cycles record → play → overdub (like a guitar loop pedal). Loop length is set by the first recording pass.
- **Overdub:** Yes, with feedback control so older layers can decay.
- **Playback manipulation:** None — straight looping at original speed. No rate/pitch control, no adjustable loop points.
- **UI:** Presentation mode with a clean UI — transport button(s), waveform display, input/output level metering.
- **Audio I/O:** Live audio input (adc~) → looper → output (dac~). No MIDI requirement stated.

## Decisions (2026-08-24, /max-discuss)

- **Engine: gen~ Data looper.** Codebox with a `Data` buffer; sample-accurate loop length latched at end of first record pass; overdub = `write(input + feedback * existing)`. `karma~` is not in the object DB (Rule #1) and record~/groove~ overdub sync is fiddly at control rate.
- **Mono** signal path: adc~ input 1 → engine → both dac~ channels.
- **Max loop length: 30 seconds** (Data sized at 44100*30 = 1,323,000 samples baseline; use samplerate-aware guard in code — cap loop at Data size).
- **Transport:** main button cycles empty→record→play→overdub→play…; plus **Stop** (halt, keep loop) and **Clear** (erase, back to empty). No undo, no rate control, no loop-point editing (kickoff: keep it simple).
- **Feedback dial** 0–1 (default 1.0 = infinite layering) controls how much existing loop survives each overdub pass.
- **No input monitor toggle, no keyboard mapping** (not selected).
- **UI (presentation):** transport buttons, feedback dial, waveform display of loop buffer, input/output metering.
- **State machine lives at control level** (Max messages setting a gen~ `state` Param); gen~ handles record/play heads, length latch, and crossfade-free overdub mixing.

## Research (2026-08-24, /max-research)

**Engine: gen~ codebox bound to an external named `buffer~` (not internal `Data`).**
Declaring `Buffer loopbuf;` in the codebox binds to a parent-patch `buffer~ loopbuf 30000 1` (30 s mono). This wins over internal `Data` because:
- `buffer~` accepts a `clear` message (verified in DB) → Clear button zeroes the loop at control rate, avoiding any giant for-loop in the codebox (safe-construct rule: no large/variable loops).
- `waveform~` displays the same buffer via its `buffername` attribute (pattern confirmed in `patches/stutter`), giving the UI waveform for free.
- `waveform~` does NOT auto-redraw on gen~ `poke` writes → drive redraws with `qmetro 100` → `bufname loopbuf` message, enabled only during record/overdub states.

**gen~ engine design (codebox, safe-construct compliant):**
- Params: `state` (0 empty, 1 record, 2 play, 3 overdub, 4 stopped), `feedback` (0–1, default 1).
- History: write/play position, latched loop length, previous state, write-gain and output-gain ramp states.
- First record pass: poke input at writepos++, capped at `dim(loopbuf)`. On leaving record → latch `looplen = writepos`.
- Play/overdub: single phase counter 0..looplen-1. Overdub: `poke(loopbuf, existing*feedback + input*recgain, pos, 0)` — explicit channel arg per safe-construct rules.
- Click-free: ~10 ms one-pole ramps on record gain (in/out of record/overdub) and output gain (stop/play). No else-if chains; spaces only.
- Outlet 2: looplen (samples) as signal → `snapshot~ 100` → ms conversion → waveform~ display range (inlets 2/3 take display start/end in ms).

**Control level (all objects DB-verified):**
- Main button: `textbutton` (3 outlets). State transitions via `select`-based logic: 0→1, 1→2, 2→3, 3→2; Stop: →4 (from 2/3); from 4 main button →2; Clear: →0 + `clear` to buffer~. State value → `state $1` message → gen~ inlet 0 (bare param name, no `@`).
- Feedback: `dial` → `scale 0 127 0. 1.` (or dial 0..1 float mode) → `feedback $1` → gen~.
- Metering: `meter~` on adc~ input and on output before dac~.
- State name display: message boxes → `set <name>` → comment.
- `poke~`/`dac~` have empty I/O in the DB (audit warning) — dac~ is used constantly in this repo (fine via builder defaults); avoid `poke~` at top level (gen~ does all writing anyway).

**Signal flow:** `adc~ 1` → gen~ (in1) → `*~` output stage → `dac~ 1 2` (mono to both). meter~ taps at input and output.

**MAX 9 compatibility:** all chosen objects are core MSP/Max, no version concerns.

## Bpatcher conversion (2026-08-24, /max-iterate)

`looper.maxpat` is now a reusable bpatcher module (`openinpresentation: 1`):
- **Arg `#1` = buffer name** (symbol, e.g. `looper-1`). Standalone-token substitution: `buffer~ #1 30000 1`; loadbang → `t b b` → `loopbuf #1` (gen~ Buffer rebind) + `set #1` (waveform~, since stored attrs don't substitute — `buffername` attr removed); redraw msg is `bufname #1`.
- **I/O:** mono signal `inlet` ("Audio In (mono)") → engine → mono `outlet` ("Loop Out (mono)"). adc~/dac~ removed — parent patch owns hardware I/O.
- **Demo:** `looper-demo.maxpat` — adc~ 1 → two bpatcher instances (args `looper-1`/`looper-2`) → summed via `*~ 0.7` → dac~ 1 2.
- Each instance needs a unique `#1` arg or instances will share one buffer.
