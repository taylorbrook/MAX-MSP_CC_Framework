# knock

Project context and notes.

## Kickoff (2026-08-23)

**Concept:** A deep knocking sound generator — kick-drum-style synth triggered per hit, with per-hit randomization so repeated knocks sound naturally varied.

**Core spec (from user):**
- Trigger: velocity-sensitive input — a single number (0–127 or 0.–1.) both triggers the knock and sets its loudness; a bare bang re-triggers at last velocity.
- **Randomness** parameter (0.–1.): 0 = identical knock every time; 0.5 = some variation; 1.0 = wide variation.
- **Bassiness** parameter: how deep and heavy the knock sounds.
- Simple, focused patch.

**Kickoff decisions:**
- Synthesis: single **gen~ codebox** — pitch-swept sine + click/noise transient + amp envelope, all sample-accurate. Randomization logic lives inside gen~.
- Randomized aspects (scaled by randomness param): **decay length**, **attack/transient character** (click brightness / strike hardness), **pitch-sweep depth**. Base pitch stays fixed (governed by bassiness), so the knock keeps its identity at all randomness settings.
- Trigger input: number = trigger (velocity + trigger in one message); bang = re-hit at last velocity.
- UI: presentation mode — randomness dial, bassiness dial, test-hit button, velocity display, output meter.

## Decisions (discuss, 2026-08-23)

- **Sound character: kick + body knock.** Pitch-swept sine core for kick-style weight, plus a short damped body resonance and a knuckle-click noise transient — reads as a heavy knock on a large surface rather than a drum-machine kick.
- **Bassiness = macro (0.–1.).** One knob scales three things together: base pitch downward (~90 Hz at 0 → ~40 Hz at 1), decay length upward, and transient tone darker. Low = dry tap, high = deep heavy boom.
- **Velocity = loudness + slight brightness.** Velocity maps primarily to gain, with a modest transient-brightness boost so hard knocks sound harder, not just louder.
- **Randomization is internal to gen~** using its noise source, sampled once per trigger, scaled by the randomness Param. At randomness 0 the randomized offsets collapse to 0 → identical hits.

## Research (2026-08-23)

All objects verified in the database.

**Top-level signal/control flow:**
- Trigger path: `number` (0–127) → `t b f` — right outlet (`f`) sets the `vel` Param on gen~ first (cold), left outlet (`b`) fires `click~` last (hot). `click~` (1 in / 1 out, signal) feeds gen~'s signal inlet; the codebox detects the nonzero impulse sample as the trigger. This gives sample-accurate triggering with velocity guaranteed latched before the hit.
- `button` in UI fires the same `t b f` chain via a stored last-velocity (`f` object not needed — the message path re-sends last number; simplest: button → `t b` into the same click~, vel Param retains last value).
- Params: `dial` (0–1 via scale or float dial settings) → message `randomness $1` / `bassiness $1` → gen~ inlet 0. Param-name messages, no `@` prefix (per CLAUDE.md).
- Output: gen~ out1 → `gain~` (with `meter~` companion beside it) → `dac~` both channels. Velocity handles per-hit loudness inside gen~; gain~ is master trim.

**Inside gen~ (single codebox, all operators verified in gen domain: `noise`, `exp`, `sin`, `twopi`, `samplerate`, `clamp`, `mix`, `pow`):**
- Trigger detect: `if (in1 > 0.)` → reset envelope counters, latch per-hit random offsets from `noise()` scaled by `randomness` Param.
- Kick core: phase-accumulated sine with exponential pitch sweep: freq = base + sweep·exp(-t/sweepTime); base ≈ 90→40 Hz mapped from `bassiness`.
- Body resonance: second phase-accumulated damped sine at a fixed inharmonic multiple (~2.7×) of base freq with its own shorter exp decay — gives the "knock on a surface" body. No feedback loops, no resonant filters, so no phase-compensation concerns.
- Knuckle click: short `noise()` burst through a manual onepole lowpass (`y = y + b*(x-y)` via History); cutoff darkened by bassiness, brightened slightly by velocity and by the per-hit attack-character random offset.
- Envelopes: exponential decay via per-sample multiply (`env *= d` with d derived from decay-time), History-based. Decay time scaled up by bassiness, randomized by decay offset.
- Randomized per hit (all scaled by `randomness`): decay length, transient brightness/click level, pitch-sweep depth. Base pitch NOT randomized.
- Codebox safe-construct rules apply: spaces only, no `else if`, declarations first, no variable-bound loops (none needed here — no loops at all).

**Version notes:** all objects are core MAX 8-era, no MAX 9-only objects needed.
