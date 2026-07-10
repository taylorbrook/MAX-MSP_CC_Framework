# simple-fm

Project context and notes.

## Purpose

A teaching patch that demonstrates the essentials of how frequency modulation
(FM) synthesis works. Optimized for clarity and pedagogy over sound-design
depth: the learner should be able to hear AND see what changing each FM
parameter does.

## Kickoff Decisions (2026-07-09)

- **Note input:** On-screen `kslider` for instant mouse play, with `notein`/`stripnote`
  in parallel for an optional MIDI keyboard. Both feed the same pitch path.
- **Topology:** Classic 2-operator Chowning pair — one sine modulator into one
  sine carrier. No feedback, no parallel modulators (keep the lesson clean).
- **Parameter model:** Chowning style — **harmonicity ratio** (mod freq =
  carrier freq × ratio) and **modulation index** (deviation = index × mod freq).
  Teaches why integer ratios sound harmonic and non-integer ratios inharmonic.
- **Visualization:** `spectroscope~` (watch sidebands appear/spread as index
  rises) + `scope~` (time-domain wobble). This is the core teaching payoff.
- **Audio/MIDI requirements:** Audio out (dac~ with gain safety), MIDI note in
  (optional). No audio input.
- **UI:** Yes — presentation-friendly layout with labeled ratio + index dials,
  kslider, spectrum + waveform displays.

## Decisions (discuss, 2026-07-09)

- **Dual DSP implementation, in parallel:** the same 2-op FM algorithm built
  twice — (a) a plain MSP chain (`cycle~` / `*~` / `+~`) with visible math and
  stage comments, and (b) a `gen~` codebox with equivalent GenExpr. An A/B
  switch (`selector~`) picks which implementation feeds the envelope/output and
  scopes, so the learner can hear they are identical and compare the two idioms.
  Both receive the same carrier freq / ratio / index values.
  - Rationale: user explicitly wants both side by side as part of the lesson.
- **Envelope:** simple AR — note-on ramps amp up (~10 ms), note-off ramps down
  (~200 ms) via `line~` (single-message list format per CLAUDE.md `line~` rule).
- **Teaching readouts:** live labeled numbers for carrier Hz, mod Hz
  (= carrier × ratio), and deviation Hz (= index × mod Hz), updating as dials
  move and notes play. Makes the Chowning math concrete.
- **Presentation mode:** yes — clean presentation view (kslider, ratio/index
  dials + readouts, A/B switch, spectroscope~, scope~, volume). Patching view
  stays organized top-to-bottom as the visible signal-flow lesson.
- **Gain safety:** amp envelope and volume control normalized 0.–1. into `*~`
  before `dac~`, defaulting to a modest level.

## Research (2026-07-09)

All planned objects verified in the object database (none missing, no PD
confusion — `osc~` correctly avoided in favor of `cycle~`).

### Verified objects (inlets/outlets)

| Object | In/Out | Notes |
|---|---|---|
| `kslider` | 2/2 | out0 = note, out1 = velocity (mouse height) |
| `notein` | 1/3 | out0 note, out1 velocity, out2 channel; pair with `stripnote` (2/2) |
| `mtof` | 1/1 | MIDI note → Hz |
| `cycle~` | 2/1 | sine oscillator, freq in inlet 0 (signal or float) |
| `*~`, `+~` | 2/1 | signal math; float accepted in right inlet |
| `line~` | 2/2 | AR envelope; single space-delimited list per ramp (CLAUDE.md rule) |
| `selector~ 2` | 3/1 | computed via variable_io: inlet 0 = control switch, inlets 1–2 = signals |
| `gen~` | var | I/O follows codebox in/out declarations |
| `flonum` | 1/2 | derived-Hz readouts |
| `spectroscope~` | 2/0 | signal display, inlet 0 |
| `scope~` | 2/0 | waveform display; set `calccount` for a stable trace |
| `dac~` | 2/0 | terminate chain; `gain~` (1/2) or normalized `*~` for volume |

Empty-I/O DB warnings for `comment` / `scope~` / `spectroscope~` / `dac~` /
`panel` come from shadowed package copies; effective lookups are populated and
these objects are used throughout existing patches.

### Signal flow (MSP teaching chain)

```
kslider ─┬─ note ──→ mtof → carrierHz (float)
notein → stripnote ─┘         │
                              ├→ [* ratio]  → modHz  → flonum readout
                              │       └→ [* index] → devHz → flonum readout
cycle~ (modHz) → *~ devHz → +~ carrierHz → cycle~ (carrier) → selector~ → env *~ → gain → dac~
```

- Ratio/index changes recompute modHz at control rate; `trigger` objects
  enforce cold-before-hot ordering when carrierHz updates fan out.
- Envelope: velocity > 0 → `line~` "1. 10"; velocity 0 → `line~` "0. 200"
  (single-list messages, never comma-segments — `line~` replaces active ramps).
- `selector~ 2` A/B: inlet 1 = MSP chain, inlet 2 = gen~ chain; umenu or
  toggle-driven int to inlet 0. Note: `selector~` clicks on switch — acceptable
  here (teaching patch, switch is rare and both sources sound identical).

### Gen~ codebox equivalent

Gen operators `cycle`, `mtof` confirmed in the gen domain. Codebox sketch
(declarations first, per CLAUDE.md ordering rule):

```
Param ratio(2.);
Param index(2.);
cf = in1;              // carrier freq (signal, from mtof → sig~ or line~)
modhz = cf * ratio;
dev = modhz * index;
out1 = cycle(cf + cycle(modhz) * dev);
```

Carrier freq enters as a signal (in1) so both chains share one pitch source;
ratio/index arrive as `param` messages (`ratio $1`, no `@` prefix).

### Presentation mode

Standard builder support: presentation rects on kslider, dials, flonum
readouts, A/B switch, scopes, volume. Patching view keeps the annotated
top-to-bottom teaching layout.
