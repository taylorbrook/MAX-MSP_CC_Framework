# FDNVerb

Advanced digital reverb built directly in gen~ for use inside MAX.

## Algorithm

**Feedback Delay Network (FDN)** — 8 delay lines with Hadamard mixing matrix for dense, smooth tails.

## Signal Flow

- **Input:** Mono or stereo in, stereo out
- **Chain:** Input -> Pre-delay -> Diffusion -> FDN Core -> Output EQ -> Dry/Wet Mix -> Stereo Output

## Parameters

| Parameter   | Range         | Description                                      |
|-------------|---------------|--------------------------------------------------|
| Decay       | 0.1–30s       | RT60 reverb tail length                          |
| Pre-delay   | 0–500ms       | Delay before reverb onset                        |
| Damping     | 0–100%        | High-frequency rolloff in feedback paths         |
| Size        | 0–100%        | Scales FDN delay line lengths (room size)        |
| Diffusion   | 0–100%        | Allpass diffusion density                        |
| Dry/Wet     | 0–100%        | Mix between dry input and wet reverb             |
| Mod Rate    | 0.01–10 Hz    | LFO rate for delay line modulation               |
| Mod Depth   | 0–100%        | Depth of delay time modulation                   |
| EQ Low      | -12 to +12 dB | Low shelf EQ on reverb output                   |
| EQ High     | -12 to +12 dB | High shelf EQ on reverb output                  |
| Bloom       | 0–100%        | Density buildup rate (slow swell vs instant)     |
| Freeze      | on/off        | Infinite hold — locks feedback at unity gain     |

## Architecture

- Main `.maxpat` with `gen~` and UI controls (dials/toggles)
- `gen~` with codebox implementing the full FDN algorithm:
  - 8 modulated delay lines with prime-ratio lengths
  - 8x8 Hadamard feedback matrix
  - Per-line lowpass damping filters
  - Allpass diffusion stages on input
  - Bloom envelope shaping on feedback gains
  - Output shelving EQ
  - Freeze mode (unity feedback override)
- Params exposed as `gen~` attributes via `Param` in GenExpr

## Version

MAX 9

## v0.2.0 — bpatcher module + help patch + DSP review fixes (2026-09-21)

- `FDNVerb.maxpat` is now the **bpatcher module**: inlets L / R / param messages, outlets L / R. The attrui test harness, `*~ 0.5` trims, `meter~`s and `ezdac~` were removed — host concerns, they live in the help patch. (The old patch had **no audio input wired to gen~** at all.)
- Face is **364 × 174** in presentation: dark panel `[0.19 0.19 0.22]`, four group panels (REVERB row of six; MOD / EQ / OUT row), 11 `live.dial`s + `live.text` Freeze toggle. Decay and Rate dials use `parameter_exponent 3`. All load at the gen~ Param defaults via `parameter_initial`.
- Control path is explicit and two-way: inlet 3 → `route <12 names>` → control → `prepend <name>` → gen~. Messages like `decay 8.` / `freeze 1` move the face; the face drives gen~. No `param_connect` (gen~ is file-backed; explicit wiring is the proven form).
- Patching view: audio column at left, 12-column control grid on a 75 px pitch aligned to the `route` outlets, all `prepend`s share one bus segment into gen~. Presentation-only panels/captions sit bottom-right, labelled.
- `FDNVerb.maxhelp` hosts the module: impulse (`click~`) + gated `adc~` → bpatcher → linked `gain~` pair + meters → `ezdac~`; example param messages and two comma-list presets (big hall / small room); parameter reference + usage steps. Patching-mode only, so no Rule #9 exclusions.
- **gen DSP fixes** (`FDNverb.gendsp`, verified with a numpy FDN sim before editing):
  - Bloom shaping moved from the **feedback gains** to the **input injection**. It was multiplying line gains by up to 0.3 per trip: at the default bloom 0.5 a 10 s decay measured ~2.2 s, and Freeze lost ~54 dB in 4 s. Now RT60 tracks `decay` at every bloom setting and Freeze holds level.
  - Freeze bypasses damping (lossless hold); damping capped at 0.98 so 100% cannot zero the loop.
  - FDN lines 16384 → 65536 samples, predelay 24000 → 96000 (old sizes clipped size=1 at 96 kHz and 500 ms predelay above 48 kHz).
  - `size` and `predelay` one-pole smoothed (~80 ms) — no zipper/clicks on sweeps.
  - De-hoist guard (`History one(1)`, `srs = samplerate * one`) on the delay-time / decay chain per CLAUDE.md hoisting rule, since the module is meant to travel to other machines.
- Deliberate non-changes: input is still summed to mono into the tank (mono source → feed both inlets); linear-interp delay reads mean a frozen tail slowly darkens under modulation.

**v0.2.0 user-confirmed in MAX 2026-09-21** (compiles, face, help patch, bloom/freeze fixes). Project complete.
