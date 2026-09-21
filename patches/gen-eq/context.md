# gen-eq

## Overview

5-band parametric EQ built in gen~ with analog-modeled filter topology and Neve-warm character. Designed as a mono abstraction that wraps cleanly in `mc.poly~` for stereo/multichannel use.

## Kickoff Answers

### Audio I/O
- **Mono** processing (single channel in/out)
- Designed to wrap in `mc.poly~` or `poly~` for stereo/multichannel
- Must work as both abstraction and subpatcher

### Signal Flow
- Audio in → HPF → Bell 1 → Bell 2 → Bell 3 → LPF → Audio out
- All filtering in gen~ codebox (sample-rate processing)
- Parameters controlled via gen~ `Param` objects

### Bands
1. **HPF** -- 20Hz–20kHz, selectable slope (6/12/18/24 dB/oct)
2. **Bell 1 (Low)** -- 20Hz–20kHz, ±18dB gain, Q 0.1–10
3. **Bell 2 (Mid)** -- 20Hz–20kHz, ±18dB gain, Q 0.1–10
4. **Bell 3 (High)** -- 20Hz–20kHz, ±18dB gain, Q 0.1–10
5. **LPF** -- 20Hz–20kHz, selectable slope (6/12/18/24 dB/oct)

### UI
- SSL-style horizontal layout (left-to-right bands)
- Full suite of dials for all parameters
- Presentation mode with aesthetically pleasing arrangement

### Analog Modeling
- **Priority:** Smooth parameter interpolation (no zipper noise)
- **Character:** Neve warm -- subtle harmonic saturation, musical resonance
- Filter topology: SVF-based for stability and smooth modulation
- Gentle nonlinear saturation between stages for warmth

## Discussion Decisions

1. **Filter topology:** TPT SVF (Trapezoidal-integrated State Variable Filter) -- zero-delay feedback, stable under modulation
2. **HPF/LPF slopes:** Always run 4 cascaded stages, pick output from appropriate tap (no clicks on switch)
3. **Parameter smoothing:** One-pole lowpass per param inside gen~ codebox (manual control over time constant)
4. **Neve warmth:** DC-biased tanh between stages -- asymmetric saturation for even+odd harmonics, drive ~1.5-2.0, bias ~0.15
5. **Abstraction interface:** gen~ Param objects only -- all control via messages, single signal in/out, clean for mc.poly~ wrapping

## Research Findings

### TPT SVF Algorithm (Cytomic / Andrew Simper)

Core per-sample tick (zero-delay feedback):
```
g = tan(pi * freq / samplerate)
k = 1 / Q
a1 = 1 / (1 + g * (g + k))
a2 = g * a1
a3 = g * a2

v3 = input - ic2eq
v1 = a1 * ic1eq + a2 * v3
v2 = ic2eq + a2 * ic1eq + a3 * v3
ic1eq = 2*v1 - ic1eq
ic2eq = 2*v2 - ic2eq

LP = v2, BP = v1, HP = input - k*v1 - v2
```

Bell mode via output mixing: `output = input + m1 * bandpass`
- Boost: `A = 10^(dB/40)`, `k = 1/(Q*A)`, `m1 = k*(A*A - 1)`
- Cut: `k = A/Q`, `m1 = k*(1/(A*A) - 1)`
- At 0dB: A=1, m1=0, natural unity passthrough

### Cascaded HPF/LPF Slopes
- 4 cascaded SVF stages, pick output tap by slope setting
- Butterworth Q alignment for 4th-order: Q1=0.5412, Q2=1.3066
- 6dB/oct uses 1-pole TPT: `v = (in - ic1) * g / (1+g); lp = v + ic1; ic1 = 2*lp - ic1`

### Neve Warmth -- Asymmetric tanh (DC-biased)
Research shows Neve character comes from:
- Even harmonics (2nd harmonic dominant) from asymmetric class-A clipping
- Transformer saturation stronger at low frequencies
- Gradual onset, not abrupt clipping

Best gen~ approach: **DC-biased tanh** for even+odd harmonics:
```
biased = input + bias        // bias ~0.1-0.2
sat = tanh(biased * drive)
output = sat - tanh(bias * drive)  // remove DC offset
```
- Produces both even and odd harmonics (bias controls ratio)
- Apply between each filter stage at low drive (1.5-2.0)
- Output stage can have slightly higher drive for intentional color

### Parameter Smoothing
- One-pole: `smooth = smooth + (target - smooth) * coeff`
- Coeff from time constant: `coeff = 1 / (tau_ms * samplerate / 1000)`
- Recommended time constants: gain/Q ~10ms (0.001), freq ~20ms (0.0005), drive ~20ms
- Denormal prevention: add `1e-18` to filter state updates

### State Variable Count
- HPF: 4 stages × 2 state vars = 8 History
- 3 Bells: 1 stage × 2 state vars = 6 History
- LPF: 4 stages × 2 state vars = 8 History
- Smoothing: ~17 params × 1 History each
- Total: ~39 History declarations

### Sources
- Cytomic SvfLinearTrapOptimised2.pdf (Andrew Simper)
- Zavalishin "The Art of VA Filter Design" (Native Instruments)
- RBJ Audio EQ Cookbook (W3C spec)
- Neve 1073 harmonic analysis (Gearspace, UAD)

## v0.3.0 Review Decisions (2026-09-21)

1. **HPF/LPF slopes are true Butterworth 6/12/18/24 dB/oct**, -3 dB at the dial frequency for every slope: one-pole, SVF Q 0.7071, one-pole + SVF Q 1.0, SVF Q 0.5412 + SVF Q 1.3066. All four alignments run in parallel from the same input and are crossfaded by the smoothed slope value (triangular weights). Replaces the v0.1 "4 identical stages, pick a tap" scheme, which measured 12/24/36/48 dB/oct with the corner drifting to 1.52x fc.
2. **Saturation is `(tanh(x*drive + bias) - tanh(bias)) / (drive * (1 - tanh(bias)^2))`** -- unity small-signal gain at every drive/bias, so Drive is an amount control, not a gain stage (v0.2.x: drive 2 = +21 dB through the four stages). Drive range is now 0.1-5.0; 0.1 is effectively clean, 1.0 (default) matches the old default curve. Bias is applied post-drive so the normalization stays bounded.
3. **DC blocker (~5 Hz) after the output saturation** -- the asymmetric curve rectifies the signal (v0.2.x: up to -0.6 DC at the outlet).
4. **No global send/receive.** `prepend` boxes wire straight into gen~ on a bus at y=510; `_eq_param` cross-talked between instances.
5. **Readout flonums sit in series** (dial -> flonum -> prepend), so there is no fan-out and no trigger needed.
6. **Init via `loadmess`** per control (replaces one loadbang fanned out to 15 message boxes).
7. **State:** every dial/umenu has a varname matching its Param name, plus `autopattr @autorestore 0`. The abstraction does not persist values itself -- the parent adds a `pattrstorage` to store/recall, or sets controls by name (`<varname> <raw dial value>`).
8. Bell uses the single Cytomic formula (`A = 10^(gain/40)`, exact reciprocal cut) -- no boost/cut branch. Cutoffs are clamped to 0.49*samplerate; smoothing coefficients scale with samplerate; `History one(1)` de-hoists the samplerate-derived setup.
9. **Open:** poly~ wrapping still needs `in~`/`out~` (or mc.gen~ on the engine); Freq dials are 128 integer steps (~5.6%/step); Q dial is linear.

## v0.3.1–v0.4.0 Decisions (2026-09-21)

1. **Freq dials are float-output** (same log mapping); readout is an integer-Hz `number` box fed from a `t f f` (gen~ still gets the full-precision value). Default inits are fractional raw values chosen to land just above 30 / 200 / 1000 / 5000 / 18000 Hz because the number box truncates.
2. **Q dials are log-mapped:** raw 0-100 -> `expr pow(10.\,min($f1\,100.)/50.-1.)`, Q = 1 at centre (user-confirmed range 0.10-10.00 in MAX).
3. Readout boxes are positioned so their typical content is centred on the dial (number/flonum text is left-aligned, ~4 px inset). Perfect centring would need `comment` readouts driven by `set` -- not built.
4. **Multichannel ships as a sibling file** `gen-eq-mc.maxpat` (user decision): identical face and wiring, `mc.gen~ @gen gen-eq-engine.gendsp` in place of `gen~`, mc signal in/out, controls linked across all channels. The mono `gen-eq.maxpat` is NOT converted. **UI/wiring changes must be applied to both files** (the engine is shared, so DSP changes apply to both automatically).
5. **Presets live in the parent:** test patchers carry `pattrstorage <name> @savemode 2` with store/recall 1-3; clients appear as `<bpatcher varname>::<param>`.
