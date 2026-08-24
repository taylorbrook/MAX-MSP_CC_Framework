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

## Build log

### v0.1.0 (2026-08-23)

First build. Single gen~ codebox synth (1 in / 1 out):
- Params: `bassiness` (0.5), `randomness` (0.3), `vel` (0.79 ≈ velocity 100). Set via `prepend <name>` → gen~ inlet 0.
- Trigger: `number` (0–127) → `scale 0 127 0. 1.` → `t b f` — f sets `vel` cold, b fires `click~` hot; codebox detects the impulse (`in1 > 0.5` rising). `button` re-hits at last velocity.
- DSP: swept-sine kick core (base 90→40 Hz by bassiness, sweep multiplier ~3× → base over 45 ms), damped body sine at 2.7× base, noise knuckle-click through manual onepole (`clkcoef`), squared-exp decays via per-sample History multiplies, `tanh` drive scaled by bassiness, output ×vel².
- Per-hit randomization (latched from `noise()` at trigger, scaled by randomness): decay times (±55%), sweep depth (±60%), click level/brightness.
- Output: gen~ → gain~ (loadmess 120) + meter~ companion → ezdac~.
- Presentation UI: panel, KNOCK title, hit button, velocity number, randomness/bassiness dials (floatoutput 1, size 1.0) with labels, gain~ + meter~ + ezdac~. Labels re-colored light (0.92) after auto-styling forces dark house textcolor — apply textcolor AFTER `finalize_patch` or it gets overwritten.
- Critic: clean except by-design warnings (message-into-signal-inlet idiom; gain~/meter~ companion 5px gap).
