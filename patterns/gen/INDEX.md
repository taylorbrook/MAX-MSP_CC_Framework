# Gen~ Pattern Library Index

Reusable .gendsp files for common DSP operations. Each file is a standalone gen~ patcher with codebox, in/out objects, and Param declarations for tunability.

## How to Use

### In a .maxpat (via agent generation)

Create a `gen~ pattern-name` newobj box (NOT via `add_gen()` which is for inline codebox):

```python
# Create gen~ box referencing external .gendsp
gen_box = patcher.add_box(Box("gen~", ["smooth-ramp"], db))
gen_box.numinlets = 1    # Match .gendsp I/O count
gen_box.numoutlets = 1
gen_box.outlettype = ["signal"]
```

### File Placement

Copy the .gendsp file to the project's `generated/` directory alongside the .maxpat. MAX resolves the filename (without extension) from the same directory or search path.

### Param Messages

Send parameters as plain name messages (NOT @ syntax):
- Correct: `time 50` or `time $1`
- Wrong: `@time 50` or `@time $1`

## Pattern Table

### Ramps & Envelopes

| Pattern | File | In | Out | Params | Use Instead Of | Description |
|---------|------|----|-----|--------|----------------|-------------|
| Smooth Ramp | `ramps/smooth-ramp` | 1 | 1 | `time` (ms) | line~ message chains | Sample-accurate ramp to target value |
| AR Envelope | `ramps/ar-envelope` | 1 (gate) | 1 | `attack`, `release` (ms) | function + line~ | Exponential attack/release envelope |
| ADSR Envelope | `ramps/adsr-envelope` | 1 (gate) | 1 | `attack`, `decay`, `sustain`, `release` | function + line~ combo | Full ADSR state machine, click-free |
| Exp Curve | `ramps/exp-curve` | 1 (0-1) | 1 (0-1) | `curve` (-4 to 4) | Custom math | Exponential/logarithmic curve shaper |

### Parameter Smoothing

| Pattern | File | In | Out | Params | Use Instead Of | Description |
|---------|------|----|-----|--------|----------------|-------------|
| One-Pole Smooth | `smoothing/one-pole-smooth` | 1 | 1 | `smooth` (0-0.999) | Nothing (zipper noise) | One-pole lowpass for parameter smoothing |
| Lag Processor | `smoothing/lag-processor` | 1 | 1 | `rise_ms`, `fall_ms` | Custom smoothing | Asymmetric lag with different rise/fall times |

### Phasor-Based Timing

| Pattern | File | In | Out | Params | Use Instead Of | Description |
|---------|------|----|-----|--------|----------------|-------------|
| Master Clock | `timing/master-clock` | 0 | 1 | `bpm`, `multiplier` | metro + counter | Sample-accurate BPM phasor clock |
| Subdivider | `timing/subdivider` | 1 | 1 | `division` (1-32) | counter + modulo | Subdivide master phasor by N |
| Swing Generator | `timing/swing-generator` | 1 | 1 | `swing` (0-1) | Manual timing offsets | Apply swing feel to phasor clock |

### Gain Safety

| Pattern | File | In | Out | Params | Use Instead Of | Description |
|---------|------|----|-----|--------|----------------|-------------|
| Soft Clipper | `gain/soft-clipper` | 1 | 1 | `drive` (1-10) | clip~ 0 1 | Normalized tanh waveshaper (smooth saturation) |
| Safe Gain | `gain/safe-gain` | 1 | 1 | `gain` (0-1) | Raw *~ at full volume | Gain with tanh soft-clip to prevent overs |

### Buffer Record/Playback

| Pattern | File | In | Out | Params | Use Instead Of | Description |
|---------|------|----|-----|--------|----------------|-------------|
| Buffer Recorder | `buffer/buffer-recorder` | 1 (audio) | 1 (position) | `record`, `loop` | record~ + manual position | Record to buffer with loop/position tracking |
| Buffer Player | `buffer/buffer-player` | 0 | 1 (audio) | `speed`, `start`, `end`, `loop` | play~ + phasor~ | Variable-speed phasor-driven buffer playback |

### Essential DSP

| Pattern | File | In | Out | Params | Use Instead Of | Description |
|---------|------|----|-----|--------|----------------|-------------|
| Simple Reverb | `dsp/simple-reverb` | 2 | 2 | `decay`, `damping`, `drywet` | External reverb~ | Schroeder reverb (4 comb + 2 allpass) |
| Multi-Tap Delay | `dsp/multi-tap-delay` | 1 | 1 | `time_ms`, `feedback`, `drywet` | tapin~/tapout~ chains | Single delay line with feedback and mix |
| Compressor | `dsp/compressor` | 1 | 1 | `threshold` (dB), `ratio`, `attack_ms`, `release_ms`, `makeup` (dB) | External plugins | dB-domain envelope detection + gain reduction |
| Noise Generator | `dsp/noise-generator` | 0 | 1 | `type` (0=white, 1=pink, 2=brown) | noise~ only | White, pink, and brown noise in one generator |

### Randomization

| Pattern | File | In | Out | Params | Use Instead Of | Description |
|---------|------|----|-----|--------|----------------|-------------|
| Sample & Hold | `random/sample-and-hold` | 1 (trigger) | 1 | `min_val`, `max_val` | sah~ + random | Rising-edge S&H with random output in range |
| Random Walk | `random/random-walk` | 0 | 1 | `rate`, `step_size`, `min_val`, `max_val` | drunk + metro | Bounded brownian walk at controllable rate |

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Smooth parameter transitions | Custom line~ message chains | `one-pole-smooth` or `smooth-ramp` | line~ has message jitter; gen~ is sample-accurate |
| ADSR envelopes | function + line~ combos | `adsr-envelope` | State machine in gen~ is click-free and phase-accurate |
| Timing/clocks | metro + counter | `master-clock` + `subdivider` | Phasor is sample-accurate, metro has scheduler jitter |
| Soft clipping | clip~ 0 1 | `soft-clipper` | Hard clip causes distortion artifacts; tanh is smooth |
| Parameter smoothing | Nothing (zipper noise) | `one-pole-smooth` | Every parameter change needs smoothing at audio rate |
| Volume control | Raw *~ at full level | `safe-gain` | Tanh soft-clips to prevent overs |

## Also Available (Existing)

These .gendsp files already exist in project-specific directories:

| Pattern | Location | In | Out | Description |
|---------|----------|----|-----|-------------|
| FDN Reverb | `patches/FDNVerb/generated/FDNverb.gendsp` | 2 | 2 | Full-featured FDN reverb (heavier than simple-reverb) |
| Brickwall Limiter | `patches/stutter/generated/brickwall-limiter.gendsp` | 2 | 2 | Stereo brickwall limiter with linked detection |
