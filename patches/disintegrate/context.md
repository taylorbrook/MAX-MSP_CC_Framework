# disintegrate

Project context and notes.

## Kickoff (2026-08-25)

**Concept:** One-knob "disintegration" filter. Single `amount` param 0→1: 0 = bypass, 1 = silence. Perceptual disintegration — sound progressively distorts, filters, and detunes until it is gone.

**I/O:** Stereo insert effect — adc~ (or file player for testing) → disintegrate → dac~.

**Degradation stages the knob sweeps through:**
- Lowpass + highpass narrowing (filters close in from both ends)
- Saturation / distortion (drive rises mid-sweep)
- Detuning (user-added)

**Engine:** Single gen~ codebox, one `Param amount` drives all internal curves.

**UI:** One big dial in presentation mode + I/O gain/meter. Minimal.

## Discussion Decisions (2026-08-25)

- **Detune = pitch drift/wobble:** slow random LFO (noise → smoothed) modulating a short delay line, tape-wow style; depth and rate grow with `amount`.
- **Stage sequencing = overlapping ramps.** Each stage has its own onset/curve within the 0→1 sweep (initial targets, tune by ear):
  - wobble: onset ~0.1, ramps to full depth by ~0.9
  - drive/saturation: ~0.2 → 0.8
  - LP closes from 20kHz → ~200Hz and HP rises from 20Hz → ~2kHz over ~0.3 → 0.95 (bands cross ⇒ near-silence)
  - explicit output gain fade → 0 over the last ~15% (0.85 → 1.0) for a guaranteed null
- **Endpoint:** filters converge + gain fade (not filters alone).
- **Source:** adc~ only (no file player).
- **Engine:** one gen~ codebox, `Param amount(0)`; stereo = process L/R in the same codebox (in1/in2 → out1/out2), single shared wobble LFO or slightly decorrelated per channel.
- **UI:** presentation mode — one big `dial` (0–1, float) labelled "disintegrate", plus input/output `gain~` + `meter~` pairs.

## Research Findings (2026-08-25)

Sourced from confirmed-working codeboxes in this repo (no external lookups needed):

**Wobble / pitch drift** — `tape-wobble` codebox: Ornstein–Uhlenbeck noise (`noise()` integrated with damping, then one-pole smoothed at ~10 Hz) plus a slow `cos` LFO, summed into a delay-read offset in samples on a `Delay del(4096)` with a ~50-sample base delay. Independent L/R OU states give slight decorrelation. For disintegrate: depth = f(amount) (0 → ~40 samples), OU drift gain and LFO rate both scale up with amount so the wobble gets faster and wilder as it disintegrates.

**Saturation** — `stereo-feedback-delay` pattern: `dgain = 1 + drive*K; y = tanh(x*dgain)/dgain` (unity small-signal gain, no level jump). Not in a feedback loop here, so we can use `tanh(x*g) / max(1, g*0.6)` or similar to allow some loudness rise mid-sweep before the fade, then a DC blocker (`y = x - x1 + 0.995*y1`) after the nonlinearity.

**Filters** — one-pole LP in History form (`coef = 1 - exp(-twopi*fc/samplerate)`; `y = y1 + coef*(x - y1)`); HP = `x - LP(x)`. Cascade two one-poles each for 12 dB/oct. Cutoffs computed from `amount` on exponential (log-frequency) curves: `lp_fc = 20000 * pow(0.01, s)`, `hp_fc = 20 * pow(100, s)` where `s = smoothstep(0.3, 0.95, amount)`.

**Stage curves** — `smoothstep(lo, hi, amount)` is in the Gen DB (3 inlets) and gives per-stage onset/ramp with zero cost. Final gain = `1 - smoothstep(0.85, 1.0, amount)`. Dry/wet cross-fade near 0 (`mix(dry, wet, smoothstep(0, 0.1, amount))`) guarantees a true bypass at 0.

**Param smoothing** — `reverse-delay` pattern: 20 ms one-pole smoother on `amount` (`sc = exp(-1/(0.02*samplerate))`) so dial jumps don't zipper.

**Gen~ rules to respect** (CLAUDE.md): declarations first; no tabs; no `else if`; no local aliases (`sr`, `pi`) inside Param-only expressions — write `samplerate` / `twopi` literally in those; never assign to built-in constant names (`pi`, `twopi`, `e`).

**MAX side** — `adc~` (L/R) → `gen~` (in1/in2) → `gain~` ×2 → `dac~`; `dial` (0–1 float, `floatoutput 1`) → `amount $1` message → gen~ inlet 0; `meter~` beside each `gain~`. Presentation: one large dial + label + output gain/meters.

## Status
Ready to build.
