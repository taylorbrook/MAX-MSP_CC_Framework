# timestretch

Granular time-stretching instrument built in gen~ with both real-time and offline modes.

## Requirements

- **Audio source:** Both live audio input AND pre-loaded buffer (switchable)
- **Algorithm:** Granular (overlap-add), implemented in gen~ for maximum quality and flexibility
- **UI:** Full presentation mode -- waveform display, playback position, grain visualization, preset recall
- **Modes:**
  - Real-time: continuous granular stretching of live input
  - Offline/triggered: stretch a loaded buffer on demand
- **Research mandate:** Investigate commercial, open-source, and academic timestretch algorithms to inform the gen~ implementation -- prioritize quality and flexibility

## Signal Flow

```
[live input / buffer~] → [grain engine (gen~)] → [output mix] → [dac~]
                              ↑
                     [stretch ratio, grain size, window shape,
                      pitch shift, grain density, randomization]
```

## Key Design Decisions

- gen~ codebox for the grain engine core (sample-rate precision, single-sample feedback)
- Buffer~ for file playback source, live input via adc~ for real-time mode
- Overlap-add with configurable grain count, window function, and scatter
- Waveform~ for visual feedback of playback position

---

## Research Findings

### Algorithm Selection: WSOLA-Enhanced Granular OLA

After surveying commercial (Elastique, Ableton, Paul Stretch, Serato, iZotope Radius), open-source (Rubber Band, SoundTouch, SuperCollider, Csound), and academic literature (Verhelst & Roelands 1993, Moulines & Charpentier 1990, Laroche & Dolson 1999, Roads 2001, Driedger & Muller 2016), the recommended approach is:

**WSOLA-enhanced synchronous granular overlap-add** -- this provides the best quality-to-complexity ratio for a gen~ implementation, combining:

1. **Synchronous granular OLA** (the proven Warp1/syncgrain model) as the core
2. **WSOLA cross-correlation search** at grain launch for optimal phase alignment (the single biggest quality improvement over naive OLA -- Verhelst & Roelands 1993)
3. **Transient-adaptive grain sizing** (shorter grains at transients, longer in steady-state -- informed by Roebel 2003, Duxbury et al. 2003)
4. **Quasi-synchronous emission** with jitter to eliminate periodic artifacts (Roads 2001)

This avoids the complexity of a full phase vocoder (Rubber Band R3 uses multi-resolution FFT with HPSS bin classification -- overkill for gen~) while surpassing basic granular quality.

### Key Insights from Research

**From commercial implementations:**
- Elastique's core innovation: transient/tonal decomposition with separate processing paths (US Patent 8,805,697 B2). We adapt this as adaptive grain sizing rather than full signal separation.
- Paul Stretch: phase randomization for extreme ratios (>8x). Simple to add as an optional mode -- randomize grain start positions with large scatter.
- iZotope Radius: multi-resolution approach (multiple FFT sizes). We approximate this with adaptive grain size.
- Ableton's best modes (Complex/Complex Pro) are phase vocoders, not granular. Their granular modes (Tones/Texture) are creative tools. Our approach targets the gap: granular quality approaching spectral methods.

**From open-source codebases:**
- SuperCollider Warp1: recursive second-order Hann envelope generation (`b1 = 2*cos(2*PI/N); y0 = b1*y1 - y2; amp = y1*y1`) -- zero table memory, perfect Hann. Directly applicable to gen~.
- SoundTouch WSOLA: cross-correlation search with center-bias heuristic (`corr *= (1 - 0.25*tmp*tmp)`). Grain size 40-90ms auto-tuned, seek window 15-20ms, overlap 8ms.
- Rubber Band R3: frequency-dependent phase locking (tight beta for low frequencies, loose for high). The HPSS bin classification (horizontal/vertical median filtering) is the gold standard but too complex for gen~.
- Csound syncgrain: `kprate` (pointer rate) as the time-stretch mechanism -- read pointer advances in "grain units". Clean model for gen~.

**From academic literature:**
- COLA constraint: Hann window at 50% or 75% overlap gives perfect constant-amplitude reconstruction. This is non-negotiable for artifact-free output.
- WSOLA tolerance window: +/-128 samples is sufficient for most material. Larger tolerance = better phase alignment but more temporal smearing.
- Grain density regimes (Roads): 50-200 grains/sec for tonal fusion. Below 20/sec = pointillistic. Above 500/sec = texture/noise.
- Driedger & Muller (2016) survey finding: WSOLA and phase-locked phase vocoder produce comparable quality for moderate stretch (0.5x-2x). Phase vocoder is only definitively better at extreme ratios (>4x).

### gen~ Architecture

```
                          GRAIN ENGINE (gen~ codebox)
                    +-----------------------------------+
                    |                                   |
 adc~/buffer~ ----->| Data buf(131072)  [circular buf]  |
                    |                                   |
                    | write_pos: always advancing        |
                    | read_pos: advancing at 1/stretch   |
                    |                                   |
                    | 8 grain voices (75% overlap):      |
                    |   g0: [pos, phase, active]         |
                    |   g1: [pos, phase, active]         |
                    |   ...                              |
                    |   g7: [pos, phase, active]         |
                    |                                   |
                    | Per grain each sample:             |
                    |   sample = buf.peek(grain_pos)     |
                    |   env = hann(grain_phase)          |
                    |   output += sample * env           |
                    |   grain_pos += playback_speed      |
                    |   grain_phase += 1/grain_size      |
                    |                                   |
                    | Grain launch (every hop samples):  |
                    |   WSOLA search: +/-128 samples     |
                    |   find best correlation            |
                    |   set grain_pos = best_pos         |
                    |   apply +/-5% jitter               |
                    |                                   |
                    | Transient detector:                |
                    |   envelope follower (1ms atk/50ms) |
                    |   when transient: grain_size=10ms  |
                    |   otherwise: grain_size=40ms       |
                    +-----------------------------------+
                              |
                              v
                          *~ gain --> dac~
```

### Implementation Parameters

| Parameter | Default | Range | Notes |
|-----------|---------|-------|-------|
| Stretch ratio | 1.0 | 0.25 - 8.0 | Read pointer speed = 1/ratio |
| Grain size | 40ms | 5-200ms | ~1764 samples at 44.1kHz |
| Overlap | 75% (4 grains) | 50-87.5% (2-8 grains) | Higher = smoother, more CPU |
| Grain voices | 8 | Fixed | Supports up to 87.5% overlap |
| WSOLA tolerance | 128 samples | 0-256 | 0 = disable WSOLA search |
| Pitch shift | 0 cents | -2400 to +2400 cents | Grain playback speed = 2^(cents/1200) |
| Jitter | 5% | 0-25% | Random offset on grain start |
| Window | Hann | Hann/Tukey/Gaussian | Hann for COLA compliance |
| Transient sensitivity | 0.5 | 0-1 | Threshold for adaptive grain size |
| Buffer size | 131072 | Fixed | ~3 seconds at 44.1kHz |

### Quality Tiers

**Standard (4 grains, 75% overlap):**
- Hann window, WSOLA search, 40ms grains
- Good for moderate stretch (0.5x-2x)
- Low CPU

**High (8 grains, 87.5% overlap):**
- Hann window, WSOLA search, adaptive grain sizing
- Transient detection active
- Good for 0.25x-4x stretch
- Moderate CPU

**Extreme/Creative (8 grains + phase randomization):**
- Large grains (100-500ms), high scatter
- Paul Stretch-style phase randomization on grain positions
- For >4x stretch, ambient textures
- Moderate CPU

### UI Design

Full presentation mode with:
- **Waveform display** (waveform~) showing source audio with playback position indicator
- **Stretch ratio** -- large dial or slider, center-detented at 1.0
- **Grain size** -- dial with adaptive mode toggle
- **Pitch shift** -- dial in cents (hundredths of a semitone)
- **Overlap/density** -- dial or dropdown (2/4/8 voices)
- **WSOLA amount** -- tolerance dial (0=off, full=256 samples)
- **Jitter** -- dial (0-25%)
- **Transient sensitivity** -- dial with LED indicator showing detected transients
- **Mode switch** -- live input / file playback toggle
- **File controls** -- load, play/stop, loop toggle
- **Preset recall** -- 8 preset slots
- **Output level** -- meter~ + gain dial

### References

- Verhelst & Roelands (1993) -- WSOLA algorithm
- Moulines & Charpentier (1990) -- PSOLA
- Laroche & Dolson (1999) -- Phase-locked phase vocoder
- Roads (2001) -- Microsound / granular taxonomy
- Roebel (2003) -- Transient preservation
- Duxbury, Davies & Sandler (2003) -- Transient detection
- Driedger, Muller & Ewert (2014) -- Harmonic-percussive separation for TSM
- Driedger & Muller (2016) -- Review of TSM methods
- Gabor (1946) -- Acoustic quanta
- Truax (1988) -- Real-time granular synthesis
- SuperCollider GrainUGens -- Recursive Hann envelope
- SoundTouch TDStretch -- WSOLA reference implementation
- Rubber Band R3 -- Multi-resolution phase vocoder with HPSS
