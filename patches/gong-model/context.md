# gong-model

Physical model of a gong using gen~ modal synthesis with detailed pitch and timbre control.

## Kickoff

- **Target**: Standalone MAX patch for sound design / exploration
- **Excitation**: MIDI note triggers, audio input as exciter, built-in excitation models (mallet, stick, bow, etc.)
- **Polyphony**: 2-4 voices (a few simultaneous strikes)
- **Gong type**: Open — to be determined by research findings (tam-tam, opera gong, gamelan, etc.)
- **UI**: live.scope~, custom controls, sonic/visual representations of the model
- **Core**: gen~ physical model with exposed parameters for pitch and timbre

## Research Findings

### Commercial / Open-Source Analysis

**Key implementations studied**: Mutable Instruments Rings/Elements (open-source modal synthesis), AAS Chromaphone (coupled resonators), Physical Audio Preparation/Derailer (finite element), Ableton Collision, Faust physmodels.lib, STK ModalBar, SuperCollider Klank/DynKlank, CNMAT resonators~.

**Architecture consensus**: Modal synthesis (bank of bandpass filters) is the best approach for gen~ — CPU-efficient, easily parameterizable, proven in Rings (24-64 modes) and CNMAT resonators~.

**Critical parameters (from cross-implementation analysis)**:
1. **Pitch** — fundamental frequency
2. **Structure/Inharmonicity** — THE defining parameter; controls partial ratio pattern from harmonic (string) to inharmonic (gong). Rings' most important control.
3. **Brightness** — frequency-dependent damping (how fast high partials die)
4. **Damping/Decay** — overall decay time
5. **Strike Position** — affects mode excitation pattern via sin(pi * position * n)
6. **Velocity/Force** — strike hardness, brighter excitation at higher velocity
7. **Nonlinearity** — pitch glide at high amplitudes (gong signature)

**Partial ratio tables (measured)**:
- Flat gong/tam-tam: 1.000, 1.593, 2.136, 2.296, 2.653, 2.917, 3.156, 3.501...
- Nipple/pitched gong: 1.000, 1.483, 1.986, 2.514, 2.998, 3.523, 4.011, 4.524...
- Church bell: 0.500, 1.000, 1.183, 1.506, 2.000, 2.514, 2.662, 3.011...

**Realism requirements**:
- Frequency-dependent damping (high partials decay much faster — inverse-square law)
- Nonlinear pitch glide on hard strikes (cubic nonlinearity: f * sqrt(1 + a*A^2))
- Shaped exciter (filtered noise burst, not raw impulse)
- At least 12-16 modes minimum
- Measured/Bessel-derived partial ratios (not harmonic, not random)

**Rings implementation details** (from source code):
- SVF bandpass filters in parallel, one per mode
- Structure parameter interpolates between harmonic and inharmonic ratio tables
- Brightness = frequency-dependent damping multiplier
- Position = sin(pi * pos * n) mode excitation
- 24 modes (hardware), 64 modes (software)

**UI patterns**: Rings' 5-knob model (Pitch, Structure, Brightness, Damping, Position) as primary controls; XY pad for strike position (Kaivo); mode visualization via multislider.

### Academic / Scientific Analysis

**Physics**: Gongs are thin curved shells/plates governed by Kirchhoff-Love plate equation. Mode frequencies f_mn = (lambda_mn^2 / 2pi*a^2) * sqrt(D/rho*h). Modes described by Bessel functions with (m) nodal diameters and (n) nodal circles.

**Nonlinear behavior (the key differentiator)**:
- Von Karman plate equations describe geometric nonlinearity when deflection ~ plate thickness
- Energy cascade: low modes transfer energy to high modes via quadratic/cubic coupling (the "bloom")
- Internal resonance conditions: f_C ~ f_A + f_B enables efficient energy transfer
- Amplitude-dependent frequency: omega_NL = omega_0 * sqrt(1 + beta * (A/h)^2)
- Transition from periodic → quasiperiodic → chaotic at increasing amplitudes (Touze, Thomas, Chaigne 2002)

**Gong type physics**:
- Chinese opera gongs: pitch glide from hardening (descending) or softening (ascending) nonlinearity depending on dome geometry. Shallow dome = hardening, deep dome = softening.
- Tam-tams: wave turbulence regime at high amplitudes, hundreds of modes, energy cascade produces "bloom" effect 1-3 seconds after hard strike
- Gamelan: degenerate mode pairs produce characteristic beating ("ombak"), boss creates clearer pitch
- Singing bowls: cylindrical shell modes, friction excitation via stick-slip

**Material data (bronze 78/22)**:
- Young's modulus: 96-120 GPa, Density: 8700-8900 kg/m^3, Poisson: 0.34
- Internal damping (loss factor): 0.001-0.003

**Damping model (composite, three-parameter)**:
- sigma_n = sigma_0 + sigma_1 * f_n + sigma_2 * f_n^2
- sigma_0: frequency-independent losses, sigma_1: internal dissipation, sigma_2: radiation losses

**Implementation for gen~ (recommended)**:
- Each mode as 2nd-order resonator: y = a1*y1 + a2*y2 + excitation
- Coefficients: r = exp(-6.9078 / (T60 * sr)), theta = 2pi*f/sr, a1 = 2r*cos(theta), a2 = -r^2
- 20-40 modes comfortable real-time, 60-100 feasible with optimization
- Nonlinear coupling: sparse (only resonant triplets), or phenomenological energy transfer
- Mallet excitation: Hertzian contact model, F = k_H * [delta]^1.5, contact time 2-10ms

**Key researchers**: Rossing (measured gong modes), Fletcher (nonlinear theory), Chaigne (FD methods), Touze (nonlinear modal coupling, chaos), Bilbao (FDTD, numerical methods), Legge (chaos in gongs), Ducceschi (energy-conserving schemes).

## Architecture Decisions

### Core Engine
- **Morphable model** — single gen~ engine where Structure parameter sweeps continuously through ratio tables
- **Variable mode count** — 8-32 modes, user-controlled via Param (trade CPU for richness)
- **Full nonlinear coupling + bloom** — sparse von Karman modal coupling between resonant triplets, plus phenomenological energy cascade from low→high modes on hard strikes
- **Single gen~ instance** (not poly~) — resonator state persists between strikes; rearticulation interacts with ringing state (mallet contact damps then re-excites existing modes, damping amount depends on mallet type)

### Exciter
- **Hybrid architecture** — built-in mallet models computed in gen~ (soft/hard mallet via filtered noise burst, hardness controls bandwidth), audio input mixed in from MAX level
- **Mallet only** for v1 — soft/hard mallet covers primary use cases
- **Rearticulation model** — new strike partially damps existing resonator state at strike point before adding new excitation energy

### Structure Morph (5-point interpolation)
Ratio tables interpolated by Structure param (0.0 → 1.0):
1. **Harmonic** (0.0) — integer ratios, string-like
2. **Gamelan** (0.25) — tuned with beating, ombak character
3. **Nipple gong** (0.5) — pitched, inharmonic but structured
4. **Church bell** (0.75) — classic bell spectrum
5. **Flat tam-tam** (1.0) — maximally inharmonic, dense spectrum

### MIDI
- Note → pitch (fundamental frequency)
- Velocity → strike force (mallet hardness / excitation bandwidth)
- Aftertouch → damping/mute (hand-damping simulation)

### UI (Full Explorer)
- **Primary controls**: dials for Pitch, Structure, Brightness, Decay, Position, Nonlinearity
- **XY pad**: strike position (radial + angular on gong surface)
- **Mode spectrum**: multislider showing frequency and amplitude of active modes in real-time
- **Waveform**: live.scope~ for output waveform
- **Spectral display**: spectroscope~ for real-time frequency content
- **Chladni visualization**: gong surface showing active nodal patterns
- **A/B compare**: switch between two parameter snapshots
- **Exciter section**: mallet hardness control, audio input gain, exciter type selector

## MAX Implementation Research

### gen~ Codebox Architecture

**Single codebox, 32 hardcoded modes with Data objects for state.**
Unused modes (above num_modes Param) silenced via gain=0. gen~ evaluates both branches of conditionals (SIMD), so branching around unused modes saves nothing — zeroing gain is cleaner. Pattern proven in existing FDN reverb (8-line) and granular engine (8-voice) in this codebase.

**Data objects (internal gen~ arrays):**
- `mode_y1(32)`, `mode_y2(32)` — resonator state (y[n-1], y[n-2])
- `mode_a1(32)`, `mode_a2(32)` — resonator coefficients
- `mode_gain(32)` — per-mode amplitude
- `ratio_table(32, 5)` — 5 structure types x 32 ratios (2D, 5 channels)
- `decay_table(32, 5)` — per-mode T60 multipliers per structure type
- `coupling_map(16, 4)` — up to 16 resonant triplets [mode_A, mode_B, mode_C, strength]
- `mode_output(32)` — current output per mode (for coupling pass)
- `init_flag(1)` — initialization guard

**Per-sample execution order:**
1. Parameter smoothing (one-pole on all Params, ~0.0005 coeff)
2. Coefficient update (spread across 32 samples via counter — 1 mode/sample when dirty)
3. Ratio table interpolation (when structure changes — frac_idx into 2D Data, mix() between adjacent rows)
4. Trigger detection (rising edge on velocity input) + rearticulation damping (multiply all y1/y2 by damp factor, harder mallet = more damping)
5. Excitation computation (noise() * exponential envelope * velocity, one-pole LPF with hardness-dependent cutoff 500-8000 Hz)
6. Resonator bank (for-loop 0-31: y = a1*y1 + a2*y2 + excitation*gain, peek/poke Data)
7. Coupling pass (iterate coupling_map, quadratic: ya*yb*strength feeds mode_C)
8. Bloom computation (low-mode RMS → threshold → envelope → high-mode gain boost)
9. Output sum / sqrt(num_modes) + DC blocker

**Nonlinear pitch glide:** Per mode, modulate frequency based on amplitude:
`freq_eff = base_freq * (1 + nonlinearity * amp^2)`
Applied during coefficient computation.

### MAX Patch Objects

**MIDI chain:** notein → [pitch, velocity, channel] — pitch to mtof for freq, velocity scaled 0-1 for strike force. Aftertouch: touchin (channel aftertouch) or midiparse outlet for polyphonic — maps to damping multiplier on mode states.

**Audio input:** adc~ → *~ (gain control) → gen~ inlet alongside mallet excitation. Mixed at gen~ input level.

**Visualization:**
- `spectroscope~` — real-time frequency content display (logfreq + logamp mode)
- `live.scope~` — output waveform (or scope~ with custom display settings)
- `multislider` — 32 sliders showing per-mode amplitude (snapshot~ from gen~ side-output, @setminmax 0. 1., @orientation 0)
- `nodes` — XY pad for strike position (@nodenumber 1, single point on gong surface)
- Chladni visualization: `jit.gl.sketch` + `jit.gl.render` + `jit.pwindow` — draw nodal pattern based on active modes. Driven by mode amplitude data via snapshot~ → jit.gl.sketch drawing commands.

**A/B compare:** `pattrstorage` with 2 preset slots (A=1, B=2). `autopattr` registers all UI objects. Tab object toggles between slot 1/2. `pattrstorage::recallmulti` for instant A/B switching with optional interpolation.

**Primary controls:** `dial` objects for Pitch, Structure, Brightness, Decay, Position, Nonlinearity, Mallet Hardness. Each connected via appropriate scaling to gen~ Param inputs.

## Research — Timbre Fidelity Improvements (v1.6.0)

### 1. BLOOM: Coupling-Based Energy Cascade (Replace Noise Injection)

**Diagnosis**: Current section 9 injects `noise() * 0.1` into modes 16-31 — uncorrelated white noise with no frequency relationship to the resonating modes. Real gong bloom is deterministic energy cascade via von Karman nonlinearity: products of existing modal amplitudes drive new modes at sum/difference frequencies.

**Key literature**: Touze/Thomas/Chaigne 2002 (nonlinear modal coupling in plates), Poirot/Bilbao/Kronland-Martinet 2024 (simplified coupling matrix model), Ducceschi/Bilbao DAFx 2023 (real-time gong synthesis). Confirmed: Rings/Elements has NO bloom/coupling — modes are independent.

**Recommended changes**:
- **Replace bloom noise injection with quadratic cross-modulation**: `inject = ya * yb * coupling_strength * bloom_nl` where ya/yb are existing modal outputs. Energy comes from real resonator state, not noise.
- **Expand coupling network**: For each pair (i,j), find mode k where `freq[k] ≈ freq[i] + freq[j]` within 5% tolerance. Compute dynamically during structure changes. Expect 30-60 active triplets instead of current 16.
- **Make coupling amplitude-dependent (cubic)**: `eff_strength = strength * (1 + amp^2 * scale)` — bloom naturally only appears on hard strikes.
- **Optional turbulent residual**: Keep 10-20% noise component gated by modal RMS for broadband wash: `inject = noise() * turb_gain * (1 + mode_amp * 5.0)`, starting from mode 8+ (not just 16-31).
- **Energy conservation**: subtract 30% of injection from source modes A and B.

**Priority**: #1 — highest impact single change. Difference between "digital effect" and "real gong."

### 2. FUNDAMENTAL PITCH MATCHING

**Diagnosis**: For most structures, pitch tracking IS correct (ratio[0]=1.0). Church bell has ratio[0]=0.5, which is physically correct (hum tone at half nominal). The perceived "strike tone" of a real bell is at the 5th partial (nominal), not the fundamental — so this behavior matches reality.

**Potential issues**:
- Position gain can suppress mode 0 entirely at position=1.0 (`sin(PI * 1 * 1) = 0`)
- Nonlinear pitch glide shifts fundamental sharp during loud attacks

**Recommended changes**:
- **Pitch compensation for sub-unity ratio[0]**: `pitch_comp = 1.0 / max(ratio0, 0.1)` applied to base_freq, optionally controlled by a Param `pitch_comp_mode(0..1)` to let user choose physical vs keyboard-tracking behavior
- **Minimum mode 0 gain floor**: In position gain calc, enforce `max(abs(raw_pg), 0.4)` for m==0 instead of 0.12 — fundamental never drops below 40% gain
- **Optional**: expose as `pitch_comp_mode` Param for user control

**Priority**: #7 — most structures already track correctly; church bell is the only case and it's physically authentic.

### 3. GAIN COMPENSATION

**Diagnosis**: Only `s_gain / sqrt(nm)` compensates for mode count. Missing: decay time (longer=louder), brightness (brighter=more HF energy), structure (dense spectra accumulate more energy), bloom injection.

**Recommended changes**:
- **Multi-factor compensation**:
  - `decay_comp = 1.0 / max(sqrt(s_decay / 4.0), 0.5)` — longer decay = more energy
  - `bright_comp = 1.0 / (1.0 + s_bright * 0.3)` — brighter = more partials sustaining
  - `struct_comp` from per-structure gain table: Harmonic=1.0, Gamelan=0.9, Nipple=0.85, Bell=0.8, Tam-tam=0.7
  - Combined: `scale = s_gain * nm_comp * decay_comp * bright_comp * struct_comp`
- **RMS AGC safety net** (slow, preserves dynamics): ~300ms attack, only engages when output exceeds 2x target RMS (~0.15). Very slow release (0.00005 coefficient). Clamp gain 0.1-2.0.
- **Per-structure gain table**: `Data struct_gain_table(5)` initialized in init block, interpolated with structure param.

**Priority**: #2 (multi-factor comp) and #6 (AGC safety net).

### 4. MALLET/ATTACK SUBTLETY

**Diagnosis**: Fixed envelope shape for all materials. No velocity-dependent spectral change. Missing initial contact impulse for hard mallets. No mallet bounce.

**Key literature**: Chaigne/Doutaut 1997 (xylophones), Bilbao (numerical collisions) — Hertzian force law `F = K * delta^p` where p varies by material: wool≈1.8, felt≈2.2, rubber≈2.8, wood≈3.5, metal≈5.0. Higher p = sharper pulse with more HF content. Contact duration scales as `tau ∝ v^((1-p)/2p)` — shorter contact at higher velocity.

**Recommended changes**:
- **Power-law exponent per material**: Add 7th column to mat_params for Hertzian exponent. Expand `Data mat_params(5, 7)`.
- **Hertzian pulse shape**: Replace raised-cosine+exponential with `sin(PI * t/T)^p` — smooth broad hump for felt (p=2), narrow sharp spike for metal (p=5).
- **Velocity-dependent contact duration**: `vel_duration_scale = pow(vel, (1-p)/(2*p))` — stronger velocity effect than current 25% range.
- **Velocity-dependent brightness**: `body_cut *= (1.0 + burst_vel^2 * 2.0)` — up to 3x brighter at ff regardless of material.
- **Initial contact impulse for hard mallets**: Very short (0.2ms) broadband click, only for wood/metal range: `impulse_gain = clamp(s_mat - 0.5, 0, 1) * 2.0`.
- **Mallet bounce** (optional): Secondary contact ~8ms after initial, 15% energy, only for hard materials at high velocity.

**Priority**: #3 (pulse shape), #4 (vel brightness), #8 (contact impulse), #9 (bounce).

### Implementation Priority Summary

| # | Change | Impact | Effort |
|---|--------|--------|--------|
| 1 | Coupling-based bloom (replace noise) | Very High | Moderate |
| 2 | Multi-factor gain compensation | High | Low |
| 3 | Hertzian pulse shape (power-law per material) | High | Low |
| 4 | Velocity-dependent brightness | Med-High | Very Low |
| 5 | Amplitude-dependent coupling strength | Medium | Low |
| 6 | RMS AGC safety net | Medium | Low |
| 7 | Church bell pitch compensation | Medium | Low |
| 8 | Contact impulse for hard mallets | Low-Med | Very Low |
| 9 | Mallet bounce | Low | Low |
| 10 | Fundamental gain floor | Low | Very Low |

### Key References
- Touze/Thomas/Chaigne 2002 — nonlinear modal coupling, chaos in gongs
- Poirot/Bilbao/Kronland-Martinet 2024 — simplified coupling matrix model (EURASIP)
- Ducceschi/Bilbao DAFx 2023 — real-time gong synthesis
- Chaigne/Doutaut 1997 — mallet-plate Hertzian contact (JASA)
- nlm: Real-Time Non-linear Modal Synthesis in Max (2025, arXiv)

## Research — Bloom Realism (v1.12.1)

### Problem Diagnosis

Current bloom (section 9) injects `noise() * 0.1` into modes 16-31 gated by low-mode RMS. This sounds like digital artifacting because:
1. **White noise is spectrally uncorrelated** — no frequency relationship to resonating modes
2. **Abrupt onset** — threshold-based gating, no progressive cascade
3. **Skips modes 8-15** — real bloom cascades through intermediate modes
4. **Current coupling (section 8) is nearly inaudible** — coupling_map strengths ~0.00005 clamped ±0.001

The v1.9-1.10 coupling-based bloom was reverted due to runaway feedback caused by:
- No double-buffering (read/write aliasing on mode_y1 within coupling loop)
- No total energy monitoring/clamping
- Injection limits not tied to modal damping rates
- Hard clamp (audible artifacts at limit)

### Approach: Three-Tier Replacement

**Tier 1 — Cross-modulation bloom** (replaces section 9 noise injection):
- Use products of existing mode outputs (`ya * yb`) as excitation for higher modes
- Sum/difference frequencies naturally fall near other mode frequencies → spectrally coherent bloom
- Read from `mode_output` (written previous sample, read-only), accumulate into `Data coupling_accum(32)`, apply in second pass
- ~16-32 targeted mode pairs where `freq[i] + freq[j] ≈ freq[k]` within 5%
- Scale by `bloom_amount * bloom_env` (existing envelope logic is fine)
- Soft saturation: `tanh(force * 200) / 200` instead of hard clamp
- CPU: ~5% additional

**Tier 2 — Kirchhoff global nonlinearity** (enhances section 8):
- Compute `S = sum(y_m^2)` across all active modes (single pass)
- Apply `force_m = -y_m * S * nl_strength` — amplitude-dependent frequency stiffening
- Produces natural pitch glide under high amplitude AND some energy redistribution
- From nlm paper (arXiv 2603.10240): O(N) per sample, simplest physically-motivated coupling
- CPU: ~3% additional

**Tier 3 — Band-to-band energy cascade** (progressive bloom buildup):
- 4 bands: [0-7], [8-15], [16-23], [24-31]
- Track per-band energy: `E_band[k] = sum(y[m]^2)` for modes in band k
- Energy flux band k → k+1: `flux = coeff * E_band[k]^2 / (1 + E_band[k+1] / E_max)`
- Inject as scaled existing mode amplitudes: `inject[m] = flux * y[m] / (E_band[k+1] + eps)`
- Produces gradual 1-3 second shimmer buildup characteristic of real tam-tams
- CPU: ~7% additional

### Stability Protocol (must implement ALL of these)

1. **Double-buffer pattern**: New `Data coupling_accum(32)`. Pass 1: compute all forces, poke into accum. Pass 2: read accum, apply to mode_y1, zero accum.
2. **Total energy clamping**: `total_E = sum(y_m^2)`. If total_E > threshold (e.g. 10.0), scale ALL coupling/bloom forces by `threshold / total_E`.
3. **Damping-relative injection limit**: Per mode: `max_inject = (1 - pole_radius^2) * |y_m|` where `pole_radius = sqrt(-a2)`.
4. **Soft saturation**: `tanh(force * scale) / scale` (preserves small-signal linearity, smoothly limits large excursions).
5. **Frequency-dependent coupling falloff**: Higher modes get weaker coupling: `strength *= 1 / (1 + mode_index * 0.1)`.
6. **Bloom injection only when resonator activity exists**: Gate by `low_rms > 0.001` (already present).

### Implementation Priority

| # | Change | Impact | Effort | Risk |
|---|--------|--------|--------|------|
| 1 | Tier 1: Cross-modulation bloom | Very High | Medium | Medium (stability) |
| 2 | Stability protocol (all 6 items) | Critical | Low | Low |
| 3 | Tier 2: Kirchhoff global NL | High | Low | Low |
| 4 | Tier 3: Band cascade | Medium | Medium | Low |

Recommended order: Implement stability protocol first (item 2), then Tier 1 (item 1), test. Add Tier 2 and Tier 3 incrementally.

### Key References (added)
- nlm: Real-Time Non-linear Modal Synthesis in Max (arXiv 2603.10240, 2026)
- Poirot/Bilbao/Kronland-Martinet 2024: simplified coupling matrix (EURASIP)
- Ducceschi/Bilbao DAFx 2023: SAV energy-conserving gong synthesis
- Humbert/Josserand/Touze 2016: phenomenological wave turbulence model
- VK-Gong project: MATLAB/C++ von Karman modal coupling reference
- Nathan Ho: practical modal synthesis implementation notes

## Decisions — Presentation Mode (v1.7.0)

### Panel grouping (by function):
1. **Tone** — Structure, Brightness, Decay, Nonlinearity, Material (5 dials)
2. **Exciter** — Hardness, Vel Curve (2 dials) + Strike button + audio input controls
3. **Bloom** — Bloom, Bloom Speed, Bloom Persist (3 dials)
4. **Output** — Gain, Noise Level, Stereo Width, Modes, Detune (5 dials)

### Visualization:
- Spectroscope~ + live.scope~ (replacing scope~) + meters (L/R)

### Drift section:
- Full: toggle + speed number + 3 labeled multisliders (enables/ranges/rates)

### Mode spectrum:
- Compact multislider

### Utility split:
- **Top bar**: ezdac~ + preset umenu + random button
- **With exciter panel**: Strike button + audio input controls
