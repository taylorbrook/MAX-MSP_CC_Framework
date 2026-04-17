# rhythmic-corpus-chopper

Sample-accurate beat slicer and re-sequencer using FluCoMa, EARS, and Rhythmic Time Toolkit community packages.

## Description

A single-patch instrument for chopping any loop and resequencing its hits in real time.

## Signal Flow (User Spec)

1. Load a drum loop via `ears.readfile` into a `buffer~`
2. `fluid.bufonsetslice~` detects transient locations, `ears.slice` cuts the buffer at those points into individual hit buffers
3. Display section shows detected slice count, user adjusts onset sensitivity (`fluid.bufonsetslice~` threshold parameter)
4. `rtk.seq~` drives a step sequencer at signal rate -- each step value selects which slice index to play
5. `rtk.stepper~` provides the clock, synced to a tempo control
6. `rtk.arp~` creates arpeggiated patterns across the slice pool for variation
7. Playback uses `play~` or `groove~` reading from the sliced buffers
8. Randomize button shuffles the sequence, slice count display, tempo control via `rtk.clock~`

## Packages Required

- **FluCoMa** (onset detection / slicing)
- **EARS** (file I/O, buffer slicing) -- requires **Bach** dependency
- **Rhythmic Time Toolkit** (signal-rate sequencing, clocking)

## Database Flags

- `fluid.bufonsetslice~` is NOT in object database. DB has real-time `fluid.onsetslice~` but not the buffer-based variant.
- All RTK objects (`rtk.seq~`, `rtk.stepper~`, `rtk.clock~`, `rtk.arp~`) are LOW confidence stubs -- unverified I/O.
- All EARS objects require Bach package.

## Kickoff Status: ANSWERED 2026-04-16

### Q1: Onset detection approach
**Answer: A** -- Use `fluid.bufonsetslice~` (now in DB at `.claude/max-objects/packages/FluCoMa/objects.json`, `verified: false` -- schema may be incomplete, confirm via research).

### Q2: Package confidence
**Answer: B** -- Research actual RTK/FluCoMa/EARS APIs via `/max-research` before building.

### Q3: Bach dependency
**Answer: A** -- Bach is installed, EARS available.

### Q4: UI scope
**Answer: A** -- Minimal: tempo dial, sensitivity slider, randomize button, slice count display, start/stop.

## Research (2026-04-16)

DB stubs verified against FluCoMa docs, EARS GitHub help patches, and pdmeyer/rhythm-and-time-toolkit repo. **Significant name/API corrections — the original spec references three objects that do not exist.**

### FluCoMa: `fluid.bufonsetslice~`
- **Inlets (2):** (0) messages + `bang` to trigger analysis; (1) thread/progress control
- **Outlets (2):** (0) bang on completion; (1) progress/cancel (standard FluCoMa buf-object pattern)
- **Required attrs:** `@source <buf>` and `@indices <buf>` — you must declare both `buffer~` objects in the patch
- **Key attrs:** `@metric` (0–9, use `9` for normalized spectral), `@threshold` (sensitivity), `@minslicelength` (units: **hops**, not samples/ms), `@fftsettings`, `@filtersize`
- **Usage:** `bang` triggers analysis → done-bang on outlet 0 → read `@indices` buffer via `peek~` to enumerate onset sample indices
- **DB schema gap:** DB currently shows 1 inlet / 1 outlet; actual is 2/2. Also missing `@source`/`@indices` attrs.

### EARS: `ears.read~` and `ears.slice~`
- **`ears.readfile` does NOT exist** — correct name is `ears.read~`
  - **Inlets (1):** filename, list, or llll `[filename start_ms end_ms]`
  - **Outlets (5):** (0) buffer name list (plain Max list, not llll); (1) resolved paths; (2) sample format; (3) metadata tags llll; (4) markers llll
  - Async — outlet-0 buffer-name list fires when load completes (no separate "done" outlet)
- **`ears.slice` is actually `ears.slice~`**
  - **Inlets (2):** (0) input buffer name(s); (1) slice points (numeric list or llll)
  - **Outlets (2):** (0) list of newly-allocated output buffer names (auto-named `u########`); (1) dump/info
  - **Slice-point format:** list in `@timeunit` units (`samps`, `ms`, `relative 0.–1.`) — **not** FluCoMa indices-buffer directly. Must `peek~` the indices buffer and pass sample positions with `@timeunit samps`.

### Rhythm and Time Toolkit: prefix is `rtt.`, NOT `rtk.`
- **`rtk.seq~` → `rtt.sequence~`** (signal-rate step sequencer)
  - **Inlets (2):** (0) audio-rate phasor 0–1; (1) step-value list
  - **Outlets (2):** (0) interpolated step value as signal; (1) control/metadata
  - Driven by `multislider`→`(prepend list)` typically; `@steps N`, `@low/@high` output range
- **`rtk.clock~` → `rtt.clock~`** (master clock)
  - **Outlets (2):** (0) **phasor 0→1 ramp at bar rate** (not gate pulses); (1) hard-sync/bar-wrap
  - **Inlets (4):** (0) transport on/off; (1) BPM signal; (2) hard-sync impulse; (3) bar length
  - `@bpm`, `@barlength`, `@syncupdate 1` (defer bpm changes to next cycle)
- **`rtk.stepper~` does NOT exist.** Closest: `rtt.counter~` (pulse-driven) — but `rtt.sequence~` takes phasor directly, so you likely don't need a separate stepper. Decide based on whether clocking is phasor or pulse.
- **`rtk.arp~` does NOT exist.** No direct arpeggiator. Closest patterning: `rtt.pattern~`, `rtt.euclidean~`, `rtt.rprob~`, `rtt.pprob~`. For arp-like behavior, swap `rtt.sequence~` step lists dynamically.

### Recommended Signal Flow (corrected)

1. `ears.read~` loads loop → outputs buffer name on outlet 0
2. Set `@source <buf>` on `fluid.bufonsetslice~` (with `@indices slices_idx_buf`, `@metric 9`, `@threshold` tuned)
3. `bang` → done-bang on outlet 0 → `peek~ slices_idx_buf` reads sample indices as list
4. Feed list into `ears.slice~ @timeunit samps` (with original loop buffer on inlet 0) → outlet 0 yields list of N slice buffer names
5. `rtt.clock~` outputs phasor → into `rtt.sequence~` (step list = indices 0..N-1) → `zl.nth` picks slice buffer name per step → `groove~` or `play~` plays selected slice
6. For "randomize": shuffle the step list into `rtt.sequence~` on button press
7. For variation: swap `rtt.sequence~` for `rtt.rprob~` / `rtt.euclidean~` to get arp-like patterns (replaces the missing `rtk.arp~`)

### DB Corrections Needed (post-build)

- `fluid.bufonsetslice~`: update to 2 inlets / 2 outlets, add `@source`/`@indices` attrs
- Rename RTK entries from `rtk.*` to `rtt.*`, delete non-existent `rtt.stepper~` and `rtt.arp~` stubs, add real `rtt.sequence~`/`rtt.counter~`/`rtt.euclidean~`/`rtt.pattern~`
- Rename `ears.readfile` → `ears.read~`, `ears.slice` → `ears.slice~`, fix outlet counts (5 for read, 2 for slice)

## Resolved Questions (2026-04-16)

- **Q5 (variation mode):** Use `rtt.euclidean~` — Euclidean rhythms across slice pool replace the missing arpeggiator. User toggles between straight-step and Euclidean mode.
- **Q6 (randomize):** Shuffle — permutation of existing step order (each slice used exactly once per cycle).
- **Q7 (step count):** User-adjustable via number box / dial. Default 16. Must not exceed detected slice count (or wrap modulo slice count).
- **Q8 (playback):** `groove~` — supports looping, variable speed, and position control.

## Implementation Decisions (2026-04-16)

### D1: Subpatcher organization
Use subpatchers wherever they serve clear semantic boundaries. Proposed 4 groups:
- `p io` — `ears.read~`, dropfile, filename→buffer routing
- `p slicer` — `fluid.bufonsetslice~`, source/indices buffers, `peek~` → index list → `ears.slice~` → slice-buffer-name list
- `p sequencer` — `rtt.clock~`, pulse derivation, mode switch (straight vs euclidean), step list management, randomize logic
- `p player` — `groove~`, gain staging to `dac~`

### D2: Control ranges & defaults
- **Tempo:** 40–240 BPM, default 120
- **Sensitivity:** 0–100% display (flonum) scaled internally to `fluid.bufonsetslice~ @threshold` 0.0–1.0, default 50
- **Step count:** 1–64, default 16

### D3: Slice-index wiring (pulse-driven path)
`rtt.clock~` phasor outlet → `edge~` (pulse on phasor wrap) → pulses feed `rtt.counter~` → `snapshot~` extracts current step index at control rate → `zl.nth` picks slice buffer name from the slice-name list → `set <name>` message → `groove~` plays that slice.

Step list (length = user step count) stores slice indices; when step count > slice count, indices wrap modulo slice count (computed at list build time).

### D4: Mode toggle (straight vs Euclidean)
Both `rtt.sequence~`-based straight mode and `rtt.euclidean~` available. **Implementation detail** (resolving D3/D4 interaction): since D3 uses pulse-driven counter rather than phasor-driven sequence~, the "mode toggle" actually gates whether every pulse fires a slice (straight) or only Euclidean-accepted pulses fire (Euclidean). Use `gate~` on the pulse stream to route:
- Straight: raw `edge~` pulses → counter
- Euclidean: raw pulses → `rtt.euclidean~ @pulses k @steps n` → filtered pulses → counter
- Toggle switches `gate~` between path 0 and path 1

Euclidean params: expose `k` (hits) as a user dial 1–32, `n` (steps) follows step count dial.

### D5: Randomize mechanism
Manual randomize button (triggers `zl.scramble` on step list, repacks into sequencer) **plus** auto-reshuffle toggle with "every N bars" interval (N user-adjustable, default 4). Auto-reshuffle driven by `rtt.clock~` bar-wrap outlet feeding a `counter` that fires scramble every N wraps.

### D6: Presentation layout
Single horizontal strip, left-to-right:
`[tempo dial] [sens slider] [step count dial] [mode toggle] [randomize button] [auto-shuffle toggle + N] [start/stop] [slice count display]`

With dropfile for loop loading above the strip, and a waveform scope (`waveform~`) showing the loaded buffer with slice markers below.

## Next Step

Run `/max-build` to generate the patch.
