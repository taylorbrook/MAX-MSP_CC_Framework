# Gong Model

Physical model of a gong using gen~ modal synthesis. 32 parallel resonators with morphable structure, Hertzian mallet excitation, nonlinear coupling, and spectral bloom.

**Version:** 1.13.3 | **Target:** MAX 9 | **Voices:** Monophonic (resonator state persists between strikes)

## Architecture

```
MIDI / Test Button
        |
   [Excitation]         [Audio In]
   Hertzian mallet         |
   + body resonance        |
        |                  |
        +--------+---------+
                 |
        [32-Mode Resonator Bank]
         2nd-order bandpass filters
         per-mode position & angle gain
         frequency-dependent damping
                 |
        +--------+---------+
        |                  |
   [Coupling]         [Bloom]
   Kirchhoff global   Cross-modulation
   + sparse triplets   energy cascade
        |                  |
        +--------+---------+
                 |
         [Stereo Output]
         Golden-ratio pan distribution
         DC blocker + tanh limiter
                 |
              [dac~]
```

### Files

| File | Purpose |
|------|---------|
| `gong-model.maxpat` | Main patch: UI, MIDI, routing, visualization |
| `gong-engine.gendsp` | gen~ codebox: all DSP (embedded in maxpat as `gen~`) |
| `gong-presets.json` | 10 preset snapshots via pattrstorage |
| `mode-gains.js` | js bridge: multislider values to buffer~ for per-mode gain |
| `randomize.js` | js: randomize all parameters except gain |
| `drift.js` | js: brownian motion drift on parameters |

## gen~ Engine

All DSP runs inside a single gen~ codebox. No poly~ -- the resonator bank is monophonic so that rearticulation interacts with ringing state (a new strike partially damps then re-excites existing modes).

### Execution Order (per sample)

1. **Parameter smoothing** -- one-pole lowpass on all 23 Params (~23ms convergence, coeff 0.001)
2. **Ratio table interpolation** -- when structure changes, interpolate between 5 ratio tables (32 modes x 5 channels in 2D Data)
3. **Position gain update** -- when position or angle changes, recompute `sin(PI * pos * (m+1)) * angle_mod` per mode
4. **Coefficient update** -- round-robin: 1 mode per sample. Computes `a1 = 2r*cos(theta)`, `a2 = -r^2` from T60 and frequency. Includes nonlinear pitch glide via smoothed amplitude envelope.
5. **Trigger detection** -- rising-edge on velocity (MIDI) or strike_count increment (test button). On trigger: rearticulation damping, burst init, per-mode random detune, bloom envelope reset.
6. **Excitation** -- Hertzian mallet model with 5-material morph, body resonance, pink noise blend, velocity-dependent brightness, contact impulse, mallet bounce.
7. **Resonator bank** -- 32 parallel 2nd-order resonators: `y = a1*y1 + a2*y2 + excitation*gain`. Aftertouch damping. Golden-ratio stereo panning.
8. **Nonlinear coupling** -- Kirchhoff global stiffening (`force = -y * S`) + 16 sparse triplet couplings (quadratic cross-modulation). Double-buffered via `coupling_accum` Data.
9. **Bloom** -- cross-modulation energy cascade: products of low-mode pairs (adjacent + non-adjacent) injected into modes 8-31 with progressive falloff. 15% turbulent noise residual. Gated by low-mode RMS.
10. **Output** -- gain scaling by `1/sqrt(num_modes)`, two-stage DC blocker, tanh soft limiter.

### Structure Morph

The `structure` parameter (0.0-1.0) interpolates continuously across 5 ratio tables stored in `ratio_table(32, 5)`:

| Value | Type | Character |
|-------|------|-----------|
| 0.00 | Harmonic | Integer ratios, string-like |
| 0.25 | Gamelan | Degenerate mode pairs with beating (ombak) |
| 0.50 | Nipple gong | Pitched but inharmonic, structured spectrum |
| 0.75 | Church bell | Classic bell partials (hum tone at ratio 0.5) |
| 1.00 | Flat tam-tam | Maximally inharmonic, dense spectrum |

Ratios are from measured acoustic data (Rossing, Fletcher). Each structure type also has its own decay profile in `decay_table(32, 5)` -- e.g., church bell has massive hum sustain, gamelan has mid-focused singing tones, tam-tam has fast upper-partial decay.

### Mallet Model

Five material types interpolated by the `material` parameter (0.0-1.0):

| Value | Material | Contact (ms) | Hertzian Exp | Character |
|-------|----------|-------------|--------------|-----------|
| 0.00 | Wool | 12 | 1.8 | Long, dark, warm thud |
| 0.25 | Felt | 7 | 2.2 | Warm, moderate |
| 0.50 | Rubber | 4 | 2.8 | Punchy, mid-range |
| 0.75 | Wood | 2 | 3.5 | Bright, articulate |
| 1.00 | Metal | 0.8 | 5.0 | Sharp, brilliant |

Each material defines: contact duration, impact ratio, LPF low/high frequencies, mallet body resonance center/Q, and Hertzian power-law exponent. The envelope shape is `sin(PI * t/T)^p` where `p` is the exponent -- felt produces a smooth broad hump while metal produces a narrow spike.

Additional excitation features:
- **Body resonance**: 2nd-order bandpass models the mallet head vibrating on contact
- **Pink noise blend**: Paul Kellet 3-stage filter; soft materials get more low-frequency emphasis
- **Contact impulse**: broadband click for wood/metal range (0.2ms)
- **Mallet bounce**: secondary contact ~8ms after strike for hard mallets at high velocity
- **Velocity-dependent brightness**: ff strikes up to 3x brighter than pp
- **Velocity-dependent contact duration**: Hertzian scaling `tau ~ v^((1-p)/2p)`

### Nonlinear Behavior

Three mechanisms model the nonlinear physics of vibrating metal:

1. **Pitch glide** (per mode): `freq_eff = base_freq * (1 + nonlinearity * env^2)`. Uses smoothed amplitude envelope to avoid FM artifacts. Capped at 1.5x frequency shift.

2. **Kirchhoff global coupling**: `force_m = -y_m * S * nl_strength` where `S = sum(y^2)` across all modes. O(N) per sample. Produces natural amplitude-dependent frequency stiffening.

3. **Sparse triplet coupling**: 16 pre-computed triplets where `freq[A] + freq[B] ~ freq[C]`. Quadratic cross-modulation `ya * yb * strength` feeds mode C. Coupling strengths recomputed from frequency proximity when structure changes.

**Stability protocol**: total energy clamping (threshold 5.0), tanh soft saturation on all injection paths, hard ceiling clamp (+-0.02), frequency-dependent falloff `1/(1 + mode_index * 0.1)`, double-buffered accumulation.

### Bloom

Spectral bloom models the energy cascade from low to high modes that occurs in real gongs 1-3 seconds after a hard strike (the "shimmer" or "wash" effect).

- **Source**: products of low-mode pairs -- 7 adjacent pairs `(m, m+1)` plus 6 non-adjacent pairs for sum-frequency coverage
- **Target**: modes 8-31 with progressive weight falloff `1/(1 + (m-8) * 0.12)`
- **Envelope**: rises when low-mode RMS exceeds threshold (0.005), rate controlled by `bloom_speed`
- **Turbulent residual**: 15% noise component for broadband wash character
- **Persistence**: `bloom_persist` controls how much bloom envelope survives a new strike (0 = reset, 1 = fully preserved)

## Parameters

### gen~ Params

| Param | Range | Default | Description |
|-------|-------|---------|-------------|
| base_freq | 20-2000 Hz | 110 | Fundamental frequency (from MIDI pitch or manual) |
| structure | 0-1 | 0.5 | Morphs through 5 ratio tables (harmonic to tam-tam) |
| brightness | 0-1 | 0.5 | Frequency-dependent damping slope (0=dark, 1=bright) |
| decay_time | 0.1-30 s | 8 | Base T60 decay time (modulated by per-structure profile) |
| position | 0-1 | 0.5 | Strike position on gong surface (radial) |
| excitation_angle | 0-1 | 0.5 | Strike angle (angular position on gong surface) |
| nonlinearity | 0-1 | 0.1 | Pitch glide + coupling strength |
| num_modes | 4-32 | 16 | Active resonator count (CPU vs. richness) |
| mallet_hardness | 0-1 | 0.5 | Excitation bandwidth + mode rolloff |
| material | 0-1 | 0.3 | Mallet material (wool to metal) |
| bloom_amount | 0-1 | 0.1 | Bloom cascade intensity |
| bloom_speed | 0.1-5 s | 1 | Bloom envelope rise/fall rate |
| bloom_persist | 0-1 | 0 | Bloom preservation across rearticulations |
| noise_level | 0-1 | 0.5 | Direct mallet sound (bypasses resonators) |
| output_gain | 0-1 | 0.5 | Master output level |
| stereo_width | 0-1 | 1 | Stereo spread (0=mono, 1=full golden-ratio pan) |
| vel_curve | 0.3-3 | 1 | Velocity response curve (power exponent) |
| detune | 0-1 | 0 | Per-mode random detuning amount |
| pitch_track | 0-1 | 1 | Compensate sub-unity ratio[0] so MIDI pitch tracks |
| velocity | 0-1 | 0 | Strike velocity (from MIDI or manual) |
| aftertouch | 0-1 | 0 | Hand-damping simulation |
| strike_count | 0-10000 | 0 | Test button trigger counter |
| strike_force | 0-1 | 0.8 | Force for test button strikes |

### Data Arrays

| Data | Size | Purpose |
|------|------|---------|
| mode_y1, mode_y2 | 32 | Resonator state (y[n-1], y[n-2]) |
| mode_a1, mode_a2 | 32 | Resonator coefficients |
| mode_freq | 32 | Current frequency per mode |
| mode_output | 32 | Current output sample per mode (read-only for coupling) |
| mode_env | 32 | Smoothed amplitude envelope per mode |
| mode_detune | 32 | Random detune offset per mode (regenerated each strike) |
| pos_gain | 32 | Position-dependent excitation gain per mode |
| current_ratios | 32 | Interpolated partial ratios |
| current_decays | 32 | Interpolated decay multipliers |
| ratio_table | 32x5 | 5 structure types x 32 mode ratios |
| decay_table | 32x5 | Per-structure T60 multipliers |
| coupling_map | 16x4 | Triplet coupling: [modeA, modeB, modeC, strength] |
| coupling_accum | 32 | Double-buffer for coupling/bloom forces |
| mat_params | 5x7 | Material parameters (contact, LPF, resonance, exponent) |
| init_flag | 1 | Initialization guard |

## MAX Patch

### Input

- **MIDI**: `notein` -> pitch to `mtof` for frequency, velocity scaled 0-1 for strike force, aftertouch for hand-damping
- **Test button**: increments strike_count via `p strikecounter` subpatcher; manual freq/velocity flonum inputs
- **Audio input**: mixed with mallet excitation at gen~ input level

### Visualization

- **spectroscope~**: real-time frequency content (log freq + log amp)
- **live.scope~**: output waveform
- **meter~**: L/R output levels
- **multislider** (mode spectrum): 32 bars showing per-mode gain, editable for custom spectra
- **nodes**: XY pad for strike position (radial) and excitation angle

### Subpatchers

| Subpatcher | Purpose |
|------------|---------|
| `p velocity` | MIDI velocity scaling and routing |
| `p strikecounter` | Test button -> counter increment for trigger detection |
| `p xypad` | XY pad routing to position/angle params |
| `p drift` | js-driven brownian motion parameter drift |
| `p settings` | Preset routing via pattrstorage + umenu |

### Parameter Routing

All live.dial controls use scripting names (`d_structure`, `d_brightness`, etc.) for:
- **pattrstorage**: autopattr registers all named dials for preset save/recall
- **randomize.js**: looks up dials by scripting name to set random values
- **drift.js**: captures and modulates dial positions by scripting name

Each dial output routes through `prepend [param_name]` -> `send gong-ctrl` -> `receive gong-ctrl` -> gen~ inlet. This decouples the UI from the DSP engine.

### Presets

10 presets stored in `gong-presets.json` via pattrstorage, selectable by umenu:

1. **Symphonic Tam-tam** -- full tam-tam spectrum, moderate bloom, wide stereo
2. **Opera Gong** -- nipple gong, strong nonlinearity, tight stereo
3. **Temple Bell** (large) -- church bell spectrum, long decay, bright, metal mallet
4. **Gamelan** -- gamelan structure, moderate decay, felt mallet, detuned
5. **Thunder Sheet** -- near-tam-tam, dark, heavy bloom, high persistence
6. **Singing Bowl** -- near-harmonic, very bright, long decay, metal mallet
7. **Wind Chime** -- gamelan-ish, very short decay, hard mallet, high detune
8. **Thunder Sheet** (dark) -- mid structure, very dark, extreme bloom + persistence
9. **Temple Bell** (small) -- nipple gong, moderate brightness, wood mallet
10. **Frozen Cymbal** -- near-tam-tam, long decay, moderate bloom, high persistence

### Drift System

The `drift.js` script implements brownian motion parameter modulation:
- Toggle on/off captures current dial positions as drift centers
- Three multisliders control per-parameter: **enables** (on/off), **ranges** (drift width 0-1), **rates** (drift speed 0-1)
- Motion: random acceleration with damping (`velocity *= 0.85`), bounded by center +/- range
- Covers all 14 parameters except gain
- Tick rate set by metro in the `p drift` subpatcher

### Mode Gains

The `mode-gains.js` script bridges a multislider to a `buffer~ mode_gains` that gen~ reads via `peek()` during the resonator loop. This allows real-time per-mode gain editing from the UI -- draw a spectral shape on the multislider and it directly weights which modes sound.

## Usage

1. Open `gong-model.maxpat` in MAX 9
2. Turn on audio (ezdac~)
3. Select a preset from the umenu or set parameters manually
4. Play via MIDI keyboard or click the strike button
5. Adjust XY pad for strike position/angle
6. Use the mode spectrum multislider to sculpt the spectral shape
7. Enable drift for evolving textures

### Tips

- **Pitch tracking**: with `pitch_track` enabled (default), MIDI notes map to the perceived pitch even for church bell structure (which has ratio[0]=0.5). Disable for physically accurate tuning.
- **CPU**: `num_modes` directly controls CPU load. 16 modes is a good default; 32 for maximum richness.
- **Bloom**: most audible with tam-tam structure, high nonlinearity, hard strikes. Increase `bloom_speed` for faster shimmer onset.
- **Rearticulation**: new strikes interact with ringing state. Soft mallets preserve more resonance; hard mallets kill more before re-exciting.
- **Stereo**: modes are distributed across the stereo field using golden-ratio spacing for maximal separation. `stereo_width` 0 collapses to mono.

## References

- Rossing, T.D. -- measured gong mode frequencies
- Fletcher, N.H. -- nonlinear vibration theory
- Touze, C. / Thomas, O. / Chaigne, A. (2002) -- nonlinear modal coupling, chaos in gongs
- Poirot / Bilbao / Kronland-Martinet (2024) -- simplified coupling matrix model (EURASIP)
- Ducceschi / Bilbao (DAFx 2023) -- real-time gong synthesis
- Chaigne / Doutaut (1997) -- mallet-plate Hertzian contact (JASA)
- nlm (2025, arXiv) -- real-time non-linear modal synthesis in Max
- Mutable Instruments Rings/Elements -- open-source modal synthesis reference
