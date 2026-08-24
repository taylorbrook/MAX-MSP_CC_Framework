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

## v0.1.1 (2026-08-19) — gen~ compile fix

MAX reported "gen~: failed to compile patcher" on v0.1.0. Repo-wide survey of every codebox: all confirmed-working ones (gong-model, bassoon, stutter, granular, timestretch) use **3-arg `peek(buf, idx, 0)` and 4-arg `poke(buf, val, idx, 0)`** (explicit channel), and **none use `else if`**. v0.1.0 was the sole codebox with 2-arg peek / 3-arg poke / `else if` chains. Fixed: added channel args everywhere; rewrote state machine as nested plain if/else. Pending confirmation in MAX → then promote peek/poke arity + no-else-if rule to CLAUDE.md Gen~ section.

## v0.2.0 (2026-08-19) — defensive codebox rewrite

v0.1.1 still failed ("failed to compile genpatcher", no codebox-specific error). gen~ box structure verified byte-identical in shape to confirmed-working ji-harmonizer, so the fault is in the code string. Key finding: **the v0.1.x codebox was the only codebox in the whole repo containing TAB characters** (77); every other codebox — working or not — is pure spaces. Also, no confirmed-working codebox uses variable loop bounds or nested for loops (only unconfirmed timestretch and failed scala-synth do).

Rewrite uses ONLY repo-proven constructs: spaces-only indentation; single non-nested `for` with constant bound 600 + `if (i < win)` guard; **amortized sweep — one lag per sample** (full sweep ≈ 12 ms, same avg CPU as hop version, no per-hop spike); no `else` anywhere (sequential guarded ifs); 3-arg peek / 4-arg poke. DSP semantics unchanged vs numpy-validated metric (windows slide ≤1 sweep-length between lags — immaterial for classification).

If this compiles: promote to CLAUDE.md — tabs suspected fatal, spaces mandatory; constant-bound single loops; no else-if; peek/poke channel arg. If it STILL fails: next bisect step is loop removal (unrolled or Delay-based) — but suspect list is now empty of knowns.

## Status: v0.2.0 confirmed working in MAX (2026-08-19)

gen~ compiles and the detector runs. Codebox safe-construct rules promoted to CLAUDE.md Gen~ section.

## v0.2.1 (2026-08-23) — floorlin silence gate usable range

User report: "never detects silent unless extremely quiet." Root cause was calibration, not logic: the gate compares 50 ms RMS of the high-passed input against `floorlin`, but the default was -50 dBFS RMS (below most live-input noise floors) and the floor dial capped at -30 dB (range -70..-30), so the threshold could never be raised above a real-world noise floor. The codebox Param also clamped at 0.1 (≈ -20 dB).

Fix: dial range widened to -80..-10 dB (min=-80, size=71), loadbang default -50 → -40 dB, `Param floorlin` default 0.003 → 0.01 with max 0.1 → 0.35 (dbtoa(-10) = 0.316 now fits). Gate logic unchanged. Note for calibration: the gate reads RMS (≈3 dB below sine peak, ~10 dB below noise peaks) of the 70 Hz-highpassed signal, so it reads lower than meter~ peak levels.

## v0.2.2 (2026-08-23) — silence gate: peak-envelope branch for noisy input

User feedback (via 0_Burnt integration): the RMS gate under-reads noisy sounds — noise has a high crest factor, so its RMS sits ~10 dB below its perceived/peak level and noisy material dropped toward SILENT too easily. Applied the amplitude-follower v0.4.0 pattern: decaying peak envelope (`pkh = max(abs(x), pkh*rc)`, 50 ms rc shared with RMS), smoothed and scaled by 0.7071, and `gate = max(sqrt(rmsq), pksm)`. For a sine the scaled peak equals RMS (tonal behavior unchanged); for noise the gate reads ~6 dB hotter. New Histories: pkh, pksm. Also applied directly to both embedded detector copies in 0_Burnt.maxpat.
