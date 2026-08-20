# spectraldetector

## Goal

A patch that takes an audio input and detects whether it is mostly a **sustained pitch** or **noise**.

## Kickoff Decisions (2026-08-19)

- **Outputs (all three):**
  - UI indicator — pitch/noise light or label + confidence meter
  - Control message — 0/1 (or symbol) via outlet/send for other patches to react to
  - Continuous value — 0.–1. "pitchedness" alongside the binary decision
- **Detection method:** Autocorrelation in gen~ — custom time-domain periodicity measure in a gen~ codebox
- **Temporal behavior:** Smoothed, ~250–500 ms — classification must hold before the output flips; ignores transients/attacks
- **Audio source:** Both live input (adc~) and a test file player, with a source switch; mono analysis

## Decisions (discuss phase, 2026-08-19)

- **Pitch range:** 80 Hz – 2 kHz. Max lag ≈ 550 samples @ 44.1k (sr/80), min lag ≈ 22 (sr/2000). Analysis window ~2× max lag.
- **Metric:** normalized autocorrelation peak (NSDF-style) over the lag range, computed in a gen~ codebox → continuous 0.–1. pitchedness.
- **Decision logic:** adjustable threshold dial + built-in hysteresis band (default flip-up ~0.7, flip-down ~0.55) so output doesn't chatter near the boundary.
- **Silence gate / 3-state output:** below an input RMS floor, report "silent" instead of noise. Control message: 0 = silent, 1 = noise, 2 = pitch.
- **Smoothing:** pitchedness smoothed ~250–500 ms (exposed as a control per kickoff "smoothed" choice with sensible default).
- **UI:** full presentation mode — source switch (adc~/file), input level meter, pitchedness bar, PITCH/NOISE/SILENT indicator, threshold dial, smoothing control, file player transport.

## Research (2026-08-19)

All objects below verified in the object database (none PD, none empty-I/O at the connection sites used).

### gen~ detector core (single codebox, 1 signal in, 2 signal outs)

- **Ring buffer:** `Data ring(2048);` + wrapping write counter (`poke`). 2048 covers 2× max lag up to 48 kHz.
- **Lag range:** minlag = samplerate/2000 (≈22), maxlag = samplerate/80 (≈551 @ 44.1k, 600 @ 48k).
- **NSDF sweep every hop (512 samples ≈ 11 ms):** for each lag, r = Σ x[n]·x[n−lag] over window W = maxlag; normalize 2r / (Σx² [n] + Σx²[n−lag]); pitchedness = max peak over lag range. Sweep guarded by `if (hopcount == 0)` — codebox `for` loops + `if` compile to real control flow (the "both branches execute" note applies to expression-level ops, not codebox loops). ~290k MACs per 11 ms ≈ 26 MFLOPS — fine for one instance; **validate CPU in MAX on first load.**
- **Smoothing:** per-sample onepole on the latched raw pitchedness; coefficient derived from `smoothms` Param (t60-style: `c = exp(-1/(smoothms*0.001*samplerate))`).
- **Silence gate:** RMS via onepole on x²; compare against `floor` Param (default 0.003 ≈ −50 dB).
- **3-state hysteresis (History state):** rms < floor → 0 (SILENT); smoothed > thresh → 2 (PITCH); smoothed < thresh − hyst → 1 (NOISE); in between → hold previous state.
- **Params** (set via bare `name $1` messages, no `@`): `thresh` (0.5–0.95, def 0.7), `hyst` (0.05–0.3, def 0.15), `smoothms` (50–1000, def 350), `floor` (def 0.003).
- **Outputs:** out1 = smoothed pitchedness (0.–1. signal), out2 = state (0/1/2 signal).
- Gen operators confirmed in DB: data/peek/poke/history/param/wrap/mstosamps/samplerate/clamp/counter/latch.

### MAX-side signal flow

```
adc~ ─┐
      ├─ selector~ 2 ── gen~ ── out1 → snapshot~ 50 → slider(display)+flonum
playlist~ ─┘   │              └ out2 → snapshot~ 50 → change → sel 0 1 2 → "set …" msgs → comment
               └── meter~ (input level)                    └→ s detector-state (+ int display)
```

- **File player:** `playlist~` (1 in / 3 out; built-in UI, drag-drop) — nicer than sfplay~ for testing.
- **Source switch:** `selector~ 2` (3 inlets w/ variable_io: control + 2 signals, 1 outlet) driven by `umenu` (Live Input / File Player — remember comma-element items format).
- **State messaging:** `snapshot~ 50` → `change` (outlet 0) → `select 0 1 2` → message boxes `set SILENT` / `set NOISE` / `set PITCH` → indicator comment; state int also to `send detector-state` for downstream patches.
- **Monitoring:** `gain~` → `dac~`, default 0 (silent, safe) — optional listen path.
- **Dials:** plain `dial` + overlay flonum readouts (Rule #6 builder) → `thresh $1` / `smoothms $1` message boxes → gen~ inlet 0.

### Build notes

- Quick numpy validation of the NSDF metric (sine / noise / mixes at several freqs) before committing the codebox — cheap insurance on threshold defaults.
- Presentation layout per Rule #9: every interactive control + label in presentation grid.
- Encapsulate routing/init chains in named subpatchers (`p sources`, `p classify`, `p settings`).

## Notes

- No audio output path required beyond monitoring (detector, not effect)

## Build v0.1.0 (2026-08-19)

- numpy pre-flight (scratchpad sim): NSDF metric validated. Pure tones (sine/saw/square, 82.4 Hz–1975 Hz) score ≥0.97; white noise 0.12; 50/50 sine+noise mix 0.71. Finding: low-weighted noise fakes periodicity (pink 0.70, brown 0.97 raw) → added **3-stage 70 Hz one-pole high-pass pre-filter** inside the codebox (pink → 0.17, brown → 0.67, tones ≥0.97). Defaults confirmed: thresh 0.7, hyst 0.15.
- Codebox: incremental lagged-window energy update per lag (halves sweep cost); hop = 512 samples; ring = Data(2048); lag clamped so window+lag fits ring at up to 96k.
- Patch: selector~ source switch (msg 1 = live on load), monitor gain~→dac~ defaults silent, `send detector-state` broadcasts 0/1/2, snapshot~ 50 display rate.
- Critic loop: round 1 had 3 blockers (dial fan-out without trigger) — fixed with t f f / t i i; round 3 clean (0 errors / 0 blockers; 5 documented-legitimate control→signal-inlet warnings).
- Deliberate presentation exclusions: none — all interactive widgets included.
