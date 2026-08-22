# sample-layers

Project context and notes.

## Kickoff (2026-08-22)

**Concept:** Long-grain sample layer player. Pool of 6 audio buffers; each buffer
continuously plays one long grain at a time (3000–20000 ms), retriggering a new
grain with a fresh randomized start point the moment the previous one ends.
Playback engine in gen~. Tukey (trapezoidal) window softens grain start/end.
Global on/off with adjustable attack (fade-in) and release (fade-out) times.

**Kickoff decisions:**

- **Buffer loading:** drag-and-drop per slot — 6 dropfile zones, one per buffer.
- **Per-buffer controls:** gain per buffer + grain length min/max range per buffer.
  (No per-layer mute; layer can be silenced via its gain.)
- **Stereo:** random pan per grain — each new grain gets a random stereo position.
- **Tukey taper:** adjustable taper time (e.g. 100–2000 ms), shared by all layers.
- **Global controls:** on/off toggle, attack time, release time, master volume.
- **UI:** presentation mode with the above controls.

**Audio/MIDI requirements:** audio output only (stereo), no audio input, no MIDI.

**Signal flow (sketch):** 6 × [buffer~ + dropfile] → 6 × gen~ grain voice
(random start, random length within per-buffer range, Tukey window, random pan)
→ stereo sum → global attack/release envelope → master volume → dac~.

**Change (kickoff amendment):** 6 buffers instead of 4.

## Decisions (discuss, 2026-08-22)

- **Architecture: bpatcher slot ×6.** One slot abstraction containing dropfile,
  buffer~ #1, gen~ grain voice, per-slot gain, and grain-length min/max controls,
  instantiated 6× with standalone #N args (buffer name as #1). Numeric args passed
  as JSON numbers per CLAUDE.md.
- **Randomization inside gen~.** noise() sampled at each grain boundary for start
  point, grain length (within slot's min/max Params), and pan. Sample-accurate
  retrigger, no control-rate round trip.
- **Master attack/release as a gen~ envelope.** Small gen~ stage after the stereo
  sum: on/off gate input, attack/release time Params, linear (or smoothed) ramp
  multiplying both channels. User chose gen~ over line~ for the master fade.
- **Tukey window computed per-sample in the voice gen~** from grain phase and the
  shared taper-time Param.

## Research (2026-08-22)

All objects verified in DB. No PD-blocklist conflicts.

**Slot chain (bpatcher, arg #1 = buffer name, e.g. "slot1"):**
- `dropfile` (1 in / 2 out) -> `prepend replace` -> `buffer~ #1`. buffer~ right
  outlet emits after `replace` completes -> bang `info~` to read file sample rate
  (info~: 1 in / 10 outlets; verify SR outlet index at build) -> compute
  filesr/dspsr -> `rate $1` Param message into gen~ for pitch-correct playback
  when file SR != DSP SR.
- Voice `gen~` with codebox. Buffer binding: declare `Buffer buf;` in codebox and
  rebind per slot via `loadbang -> message "buf #1" -> gen~` (message boxes do #N
  substitution; gen~ rebinds a Buffer op by `<opname> <buffername>` message, same
  pattern as Param setting).
- Per-slot Params (set via `<name> $1` messages, no @ prefix): `minlen` / `maxlen`
  (ms, from rslider or two flonums), `gain` (0..1, smoothed in gen), `rate`.
  Shared taper Param `taper` (ms) broadcast to all slots via send/receive.

**Voice codebox design (follows CLAUDE.md safe-construct rules — spaces only, no
else-if, peek with explicit channel, no variable-bound loops; no loops needed here):**
- State in History: sample counter `pos`, grain length `len` (samps), start
  offset `start`, pan gains `gl`/`gr`.
- Retrigger: when `pos >= len`, latch new randoms from `noise()` (abs() to get
  0..1): start in [0, dim(buf)-len], len in [minlen, maxlen] (ms -> samps),
  pan 0..1 -> equal-power `gl = cos(pan*halfpi)`, `gr = sin(pan*halfpi)`.
  dim(buf)==0 guard (empty buffer -> output 0).
- Tukey window per sample: `T = clamp(taper_samps, 1, len/2)`;
  env = pos<T ? 0.5*(1-cos(pi*pos/T)) : (pos>len-T ? 0.5*(1-cos(pi*(len-pos)/T)) : 1)
  written as nested if/else (no else-if chains).
- Read: fractional index `idx = start + pos*rate`; linear interp via two
  `peek(buf, i, 0)` calls + mix (gen `sample` op uses normalized 0..1 phase —
  integer-index peek+mix is clearer for long grains). Mono read of channel 0;
  optionally average ch 0/1 when channels(buf) > 1.
- Outputs: out1 = s*env*gl*gain, out2 = s*env*gr*gain.

**Master envelope gen~ (per discuss decision):**
- 2 signal ins (stereo sum), 2 outs. Params: `on` (0/1 from toggle), `atk` (ms),
  `rel` (ms). History env; per sample linear ramp:
  on ? env=min(1, env+1/atk_samps) : env=max(0, env-1/rel_samps). Multiply both
  channels. (Optionally shape with env*env for smoother perceived fade.)

**Summing/output:** 6 slots x 2 outlets -> stereo sum (signal inlets sum
automatically at gen~ master-env inputs) -> master env gen~ -> `gain~` pair
(linked stereo per gain_linked_stereo memory) -> `dac~`. `meter~` beside gain~.

**Alternatives considered:** `play~`/`groove~` + control-rate retrigger (simpler
but scheduler-latency retrigger, and windowing needs extra line~ per voice);
poly~ (overkill for 1 grain per buffer); mc.gen~ single instance (harder per-slot
buffer binding). Chosen: 6 bpatcher slots, self-contained gen~ voices.

**MAX 9 compatibility:** all objects are core Max/MSP, no 9-only objects needed.

## Build v0.1.0 (2026-08-22)

Generated `sample-layers-slot.maxpat` (slot abstraction) and `sample-layers.maxpat`
(main patch, 6 bpatcher instances args slot1..slot6).

- **Slot:** dropfile -> t s s (filename display message + prepend replace ->
  buffer~ #1). buffer~ right outlet -> t b -> info~ #1 -> outlet 0 (file SR) ->
  `filesr $1` -> voice gen~. Voice gen~ computes `rate = filesr / samplerate`
  internally — no DSP-SR query object needed. Params: minlen/maxlen (ms),
  gain (0-1 via dial -> scale 0 127 0. 1.), taper (shared via `r grain-taper`),
  filesr. Buffer bound per slot via loadbang -> `buf #1` message. Grain
  retrigger/randomization (start, length, equal-power pan) sample-accurate in
  codebox; Tukey window via nested if/else (safe-construct rules followed).
- **Main:** slots sum at master-env gen~ signal inlets; env is linear ramp
  squared (env*env) for perceived-smooth fade; Params on/atk/rel. Output:
  linked stereo gain~ pair (L outlet 1 -> R inlet 0), init 128 (unity) via
  loadbang, post-fader meter~ pair, ezdac~.
- **Presentation:** main opens in presentation; slots shown via bpatcher
  embedded presentation (slot patch has openinpresentation=1), 2x3 grid at
  210x150 each; master panel right (toggle, attack/release/taper flonums,
  master fader, meters, ezdac~).
- **Deliberate presentation exclusion (Rule #9):** `gain~` R is slaved to
  gain~ L (linked-stereo pattern) and intentionally NOT in presentation.
- **DB fix:** added `buffer~` outlets override (both control, right = bang
  after read/replace/write) — DB mis-marked them as signal.

## Iterate v0.2.0 (2026-08-22)

Slot UI rework per user request: filepath message bar removed; `waveform~`
(bound via loadbang -> `set #1`, auto-updates on buffer replace) is now the
display, with the dropfile zone overlaid on it (dropfile brought to front —
it catches file drags, passes clicks through to waveform~). Per-slot mono
meter~ fed by (L+R) summed into `*~ 0.5`. "drop audio file" hint moved to the
header row so it never overlaps the waveform. Slot presentation grew to
210x170; main grid rows now y=40/220/400 and bpatcher patching heights match
(toggle row shifted down 40px to clear).

## Iterate v0.3.0 (2026-08-22)

Slot waveform~ now highlights the playing grain: voice gen~ rebuilt with 4
outputs — out3/out4 emit the current grain's start/end position in buffer ms
(`start / filesr * 1000` and `(start + len * rate) / filesr * 1000`; buffer
timebase uses the FILE sample rate, not DSP SR). Each is polled by
`snapshot~ 100` into waveform~ inlet 2 (Selection Start ms) / inlet 3
(Selection End ms), so the selection jumps to each new grain within 100 ms.
End is wired before start (cold-first). Empty buffer -> 0/0 -> no highlight.
Also fixed: finalize's assistance pass had rewritten the slot label comment's
stored text to "#1" (comments don't substitute #N); restored placeholder
"slot" — loadbang's `set #1` sets the real label at load. Watch for this
after future finalize passes.

## Fix v0.3.1 (2026-08-22)

Master on/off was always-on: the env codebox used `e` as the ramp variable,
but `e` is the GenExpr built-in Euler constant — assignments silently no-op,
so `env = e` pinned the envelope at 2.718 and `sh = e*e` was a constant ~7.4x
(~+17 dB) gain. Renamed to `ev`. Rule promoted to CLAUDE.md (never shadow
GenExpr constant names). Voice codebox audited — no collisions.

## Iteration v0.4.0 (2026-08-22)

- **Master toggle now stops slot playback.** Main toggle -> `t i i` -> `on $1`
  (master env, unchanged) + `s layers-on`; each slot: `r layers-on` -> `on $1`
  -> voice gen~. New `Param on(0)` (master gate) and `Param active(1)` (slot
  gate) in the voice codebox; a new grain is scheduled only when
  `on * active > 0.5`. Idle voice outputs 0 and skips peek/env (CPU drops).
- **Gate-off fade:** on gate low mid-grain, `pos` jumps to the envelope-matched
  point of the closing Tukey taper (attack pos p -> len - p; plateau -> len - T),
  so slots fade out click-free over the taper time instead of ringing for the
  full grain length.
- **Slot bpatcher inlets (x-order):** inlet 0 = slot on/off (0/1) -> visible
  toggle (presentation [70,138], init 1 via loadbang trigger outlet 7) ->
  `active $1`; inlet 1 = gain 0.-1. -> `scale 0. 1. 0. 127.` -> dial (dial
  position reflects incoming gain; existing dial -> scale -> `gain $1` chain
  drives the Param). Main-patch bpatchers updated to numinlets=2 (unwired --
  inlets are for external control).
- Critic warnings: control->signal on gen~ param messages (known false-positive
  class), cosmetic missing-midpoints on new cables. No blockers.
