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
