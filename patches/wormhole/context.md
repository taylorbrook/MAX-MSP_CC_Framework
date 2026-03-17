# wormhole

Wormhole-inspired spectral effects processor for MAX/MSP. Designed as a reusable stereo effect (2-in, 2-out) for embedding in other patches.

## Source

Inspired by Zynaptiq Wormhole plugin -- a spectral effects processor combining spectral warping, pitch/frequency shifting, dual reverb, stereo delay, and structural dry/wet morphing.

## Architecture

### Signal Flow

```
INPUT L/R
    ↓
[DELAY] (optional dry/effect signal delay, opposing L/R for width)
    ↓
[WARP] (spectral warping -- depth, poles, tilt)
    ↓
[SHIFT] (pitch shift ±48st + freq shift ±4kHz + decay time)
    ↓
[REVERB PRE] (random-modulated hall, pre-blend)
    ↓
[FX BLEND] (structural morphing dry/wet)
    ↓
[REVERB POST] (random-modulated hall, post-blend)
    ↓
OUTPUT L/R
```

### Modules

#### 1. WARP (Spectral Warping via gen~)
- Allpass filter cascade for frequency-axis warping
- **Depth**: 0-100% warping amount
- **Poles**: Number of resonance points / filter stages (2-32)
- **Tilt**: Frequency-domain rotation ±100%

#### 2. SHIFT (Pitch + Frequency Shifting via gen~)
- **Pitch Shift**: ±48 semitones (±4 octaves) via dual-delay crossfade
- **Pitch Mode**: Smooth, Tight, Detune A (±48 cents L/R), Detune B (±48 cents L/R)
- **Freq Shift**: ±4000 Hz via Hilbert transform SSB modulation
- **Decay Time**: Envelope-based component gating to reduce ringing

#### 3. REVERB (Dual Random-Modulated Hall via gen~)
- 8x8 Feedback Delay Network with Hadamard mixing
- Random modulation of delay line lengths
- Pre-blend and post-blend instances
- Simple controls: Mix, Size, Damping

#### 4. DELAY (Stereo Delay)
- Independent L/R delay times
- Can delay dry signal, effect signal, or both
- Opposing L/R delays for stereo width

#### 5. FX BLEND (Structural Morphing)
- Standard crossfade mode
- Envelope-following morph (wraps effect into source silhouette)
- Blend amount 0-100%

### Integration

- Stereo throughout (2-in, 2-out)
- Building-block design: parameters via inlets and send/receive
- No presentation-mode UI in v1
- Heavy gen~ usage for DSP core
- Each module is a self-contained subpatcher

## Implementation Decisions

1. **Gen~ codeboxes** for all DSP: WARP (allpass cascade), SHIFT (pitch shifter + Hilbert transform), REVERB (FDN)
2. **Building blocks first** -- no UI, parameters exposed via gen~ param objects
3. **Stereo processing** throughout the chain
4. **Modular subpatchers** -- each module is an independent p object
