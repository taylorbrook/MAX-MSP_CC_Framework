# tape-wobble

Analog-style tape wobble effect in stereo. Main DSP engine in gen~, with visualizations and intuitive controls.

## Requirements

- **Audio I/O:** Stereo insert effect (stereo in → stereo processing → stereo out)
- **Wobble character:** Both wow (slow drift <5 Hz) and flutter (fast 5–30 Hz) with independent controls
- **Visualization:** Real-time waveform scope showing modulated delay (before/after) + modulation shape display (LFO waveform + depth meter)
- **Extra color:** Tape saturation/soft-clipping for warmth + high-frequency rolloff / "head bump" EQ curve
- **Engine:** gen~ codebox for core DSP
- **Target:** MAX 9, stereo

## Signal Flow

```
stereo input
  → saturation (Pade tanh, in gen~)
  → wow+flutter+drift modulated delay (gen~, cubic interp)
  → head bump EQ (~100 Hz peaking)
  → HF rolloff (LPF ~9 kHz)
  → dry/wet mix
  → stereo output
  ↓ taps to visualizations
```

## Controls

- Wow: rate (0.1–6 Hz) + depth (0–1)
- Flutter: rate (3–30 Hz) + depth (0–1)
- Drift amount (0–1)
- Saturation drive (0–1)
- HF rolloff (4k–15k Hz)
- Head bump gain (0–6 dB) + freq (60–200 Hz)
- Stereo spread (0–1)
- Dry/wet mix (0–1)
- Input/output gain
- No presets for now — raw controls only

## Layout

- Controls across top row
- Visualizations filling bottom half

## Visualizations

- live.scope~ showing dry vs wet waveform (before/after wobble)
- live.scope~ showing combined modulation signal (wow+flutter+drift)

## Implementation Decisions

- Saturation: Pade tanh approximant (`x * (27 + x²) / (27 + 9x²)`) — cheap, great sound
- Mod display: live.scope~ for real-time modulation visualization
- No presets initially — add once dialed in

## Research Findings

### Physical Model
- Wow (capstan eccentricity): 0.5–6 Hz, sinusoidal + 2–3 harmonics
- Flutter (mechanical resonance): 5–30 Hz, multi-harmonic (3 cosines at ratios 230:80:99 from ChowTape measurements)
- Drift: <0.5 Hz Ornstein-Uhlenbeck mean-reverting random walk
- Real tape = deterministic periodic components + stochastic noise floor

### DSP Architecture (from ChowTapeModel, u-he Satin, Airwindows, FAUST implementations)
- **Saturation**: Pade approximant to tanh: `x * (27 + x²) / (27 + 9x²)` — cheap, accurate, symmetric
- **Modulated delay**: gen~ Delay with cubic interpolation, base ~50 samples, max 4096
- **Three-layer modulation**: drift (O-U) + wow (cosine + noise) + flutter (3-harmonic sum)
- **Stereo**: same frequencies, slightly offset phases + independent O-U drift per channel
- **Head bump**: peaking EQ ~100 Hz, +3 dB, Q ~1.0 (cassette model)
- **HF rolloff**: ~-3 dB at 8 kHz, -6 dB at 12 kHz (1st/2nd order LPF at ~9 kHz)
- **Signal order**: Input → Saturation → Modulated Delay → Head Bump → HF Rolloff → Mix → Output

### Ornstein-Uhlenbeck Drift (key insight)
```
ou_next = ou_state + sqrt(dt) * noise * amount
ou_next += damping * (mean - ou_next) * dt
```
Mean-reverting random walk — more natural than filtered white noise. Used in ChowTapeModel for wow variance.

### Flutter Harmonic Ratios (from ChowTape Sony TC-260 measurements)
- Fundamental: amplitude 1.0
- 2nd harmonic: amplitude 0.35, phase offset 13π/4
- 3rd harmonic: amplitude 0.43, phase offset -π/10

### Parameter Ranges
| Param | Range | Default | Physical basis |
|-------|-------|---------|---------------|
| Wow rate | 0.1–6 Hz | 2 Hz | Capstan rotation speed |
| Wow depth | 0–1 | 0.3 | Capstan eccentricity |
| Flutter rate | 3–30 Hz | 8 Hz | Mechanical resonance freq |
| Flutter depth | 0–1 | 0.2 | Flutter severity |
| Drift | 0–1 | 0.3 | Tape age/quality |
| Saturation | 0–1 | 0.3 | Recording level |
| HF cutoff | 4k–15k Hz | 9 kHz | Head/oxide HF loss |
| Head bump gain | 0–6 dB | 3 dB | Playback head resonance |
| Head bump freq | 60–200 Hz | 100 Hz | Gap width / tape speed |
| Stereo spread | 0–1 | 0.15 | L/R track decorrelation |
| Dry/wet | 0–1 | 0.7 | Mix |

### Sources
- Chowdhury, "Real-time Physical Modelling for Analog Tape Machines" (DAFx 2019)
- ChowTapeModel open-source (JUCE/C++)
- Dattorro, "Effect Design Part 2: Delay-Line Modulation and Chorus" (JAES 1997)
- Julius O. Smith, "Physical Audio Signal Processing" — delay interpolation
- Airwindows Flutter (C++)
- FAUST tape wobble implementations (HISE forum)
- Jack Endino, measured response curves of analog recorders
