# amplitude-follower — Context

## Kickoff (2026-08-21)

Simple RMS amplitude follower with a smoothing parameter, built in gen~. Smoothness
over snappiness — latency is not a concern.

- **Input:** live audio via `adc~` only (no test source, no sample player)
- **Output:** continuous signal, clamped 0–1, usable as a modulation source
- **Smoothing:** single parameter, time in milliseconds (symmetric attack/release)
- **UI:** minimal — flonum for smoothing ms, small display for verification
- **Signal delivery:** kept inline — signal ends at a `number~` display; user will
  copy the gen~ into other patches when needed (no send~, no abstraction outlets)

## Design Decisions

- **RMS via one-pole averaging in gen~ codebox:** square input → one-pole lowpass
  (mean-square) → sqrt → clamp 0..1. This is the standard smooth RMS estimator;
  no windowed buffer needed since latency doesn't matter.
- **Coefficient from ms param:** `a = exp(-1 / (smooth_ms * 0.001 * samplerate))`,
  computed per-sample in the codebox (cheap, avoids param-change glitches).
  `History` holds the mean-square state.
- **Param:** `Param smooth(100, min=1, max=5000)` — ms. Set from MAX via
  `smooth $1` message (no `@` prefix, per CLAUDE.md gen~ rules).
- **Display:** `number~` on the gen~ output for verification. `scope~` skipped
  (empty I/O in DB; number~ suffices for a minimal patch).
- **Signal termination:** output chain ends at `number~` (a signal sink) — no dac~
  connection needed; nothing routes to speakers.

## Research

- All required objects verified in DB: `adc~` (3 out), `gen~` (variable I/O),
  `number~` (2 in / 2 out), `flonum`, `comment`.
- gen~ codebox rules from CLAUDE.md apply: declarations first (Param, then
  History), spaces only, no else-if chains, plain if/else fine.
- Mono follower on adc~ left channel (outlet 0). Stereo could sum/average later
  if requested — out of scope for v1.
