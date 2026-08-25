# stereo-feedback-delay

A patch that takes a mono input and provides stereo feedback delay effects.

## Kickoff (2026-08-24)

- **Input source:** live mono input via `adc~`, with input gain control.
- **Architecture:** gen~ delay engine — single codebox with interpolated delays; smooth time changes, feedback-path processing inside the loop.
- **Feedback path coloring:** damping filter (lowpass darkening, tape-echo behavior), slow LFO modulation of delay time (tape warble), and soft-clip saturation for self-limiting runaway feedback.
- **UI:** full presentation-mode panel — delay time(s), feedback, filter, mix, input/output gain, meters.

## Decisions (2026-08-24, /max-discuss)

- **Stereo topology:** single delay line + short Haas-style L/R offset tap for width. Simplest engine; subtle stereo rather than ping-pong motion. (Ping-pong and dual-delay variants considered and declined.)
- **Time control:** free milliseconds, 1–2000 ms continuous dial. No tempo sync.
- **Time-change behavior:** tape-style pitch glide — slewed interpolated read position; the same smoothing mechanism carries the LFO warble modulation.
- **Feedback range:** capped at 95% — always-decaying repeats, no self-oscillation. Saturation stays in the loop for tone, not runaway control.
- **In-loop processing** (from kickoff): onepole-style lowpass damping (low-Q, safe in-loop per CLAUDE.md waveguide/filter rules), slow LFO on read position, soft-clip saturation.

## Research (2026-08-24, /max-research)

All objects verified in the DB (domains/IO checked via `ObjectDatabase`).

### Top-level patch objects
- `adc~` (3 outlets; use outlet 0 = ch 1 mono) → input `gain~` → `gen~` → output `gain~` L/R → `dac~`. `meter~` companions beside each `gain~` (Rule #4 side-by-side).
- UI: `dial` + overlay `flonum` readouts (Rule #6 pattern), `comment` labels, full presentation layout (Rule #9).
- Param control: `dial → scale → message "param_name $1" → gen~ inlet 0` (bare param-name messages, no `@` prefix, per CLAUDE.md).
- Gain safety: all gain-feeding values normalized 0.–1. before `*~`/`gain~`.

### gen~ engine design (single codebox)
Proven idioms borrowed from `patches/tape-wobble` (confirmed-working codebox in this repo): constant-size `Delay` declarations, History-based LFO phase accumulator with `wrap(phase + inc, 0, twopi)`, one-pole smoothing via History.

- **Delay line:** `Delay d(192001)` — 2000 ms at 96 kHz headroom, constant size (codebox-safe).
- **Tape glide:** one-pole slew on target delay time in samples (`History t_smooth`), coefficient ~0.9995–0.9999; LFO warble adds to the smoothed read position. `d.read(pos, interp="cubic")` for interpolated reads.
- **Loop (mono):** write = `input + fb_tap`; fb_tap = main read → onepole damping (`y += c*(x-y)`, low-Q, in-loop safe) → `tanh` soft clip (drive param, output normalized by `tanh(drive)`) → `* feedback` (clamped 0–0.95) → `dcblock`-style History pair.
- **Stereo (post-loop):** L = main tap; R = second read at `pos + width_offset` (Haas, 0–30 ms). Width tap stays OUT of the feedback loop — loop remains mono and simple.
- **Dry/wet:** `mix(dry, wet, mixparam)` in gen~; dry mono routed to both channels.
- **Params (8):** `time_ms` (1–2000), `feedback` (0–0.95), `damp` (cutoff Hz ~500–15000), `mod_rate` (0.1–8 Hz), `mod_depth` (0–1 → scaled to a few ms), `drive` (0–1), `width` (0–30 ms), `mix` (0–1).
- Codebox safe-construct rules apply: spaces only (no tabs), no `else if`, all declarations before expressions, no loops needed for this design.

### Alternatives considered
- `tapin~`/`tapout~` + top-level feedback: rejected — MSP feedback loops are quantized to the signal vector; gen~ gives single-sample feedback and clean in-loop processing.
- Crossfading dual read heads for clickless time jumps: rejected in discuss (tape glide chosen).
