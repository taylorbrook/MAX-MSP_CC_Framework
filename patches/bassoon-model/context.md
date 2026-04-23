# bassoon-model

## Kickoff

**Initial brief:** Physical model of a bassoon that can play pitches very accurately, for creating microtonal bassoon music.

## Goals

- Physical modeling synthesis of a bassoon (double-reed conical bore)
- High pitch accuracy for microtonal composition
- Playable/controllable via signal-rate frequency + amplitude inputs

## Decisions (kickoff)

| # | Question | Answer |
|---|----------|--------|
| 1 | Pitch input | **Raw frequency (Hz)** — signal-rate freq input |
| 2 | Control source | **Monophonic**, signal-rate frequency + amplitude inputs (no MIDI layer yet) |
| 3 | Expressivity | **Full continuous control** — breath, embouchure, vibrato |
| 4 | Context | **Real-time standalone patch** |
| 5 | Model approach | **Waveguide + reed nonlinearity** (start simple, iterate) |

## Decisions (discussion — DSP)

| # | Question | Answer |
|---|----------|--------|
| D1 | Bore geometry | **Conical waveguide, Scavone/Smith cone** (single delay + truncation filter at apex) |
| D2 | Fractional delay | **1st-order allpass** (phase-flat, unity magnitude) |
| D3 | Reed model | **McIntyre/Woodhouse table lookup** of pressure-flow curve |
| D4 | Tuning calibration | **Analytic compensation** — precompute phase delay of bell filter + allpass, subtract from main delay length |
| D5 | Embouchure parameter | **Both reed stiffness AND reed aperture** on separate params |
| D6 | Vibrato | **Built-in LFO** with rate/depth params, modulates freq |

## Architecture (current)

**Signal flow (inside gen~ codebox):**
```
freq~ ─┐
amp~ ──┤                                                 ┌──> bell filter ──> out
       ├─> reed table (pressure-flow) ─> delay line ─────┤
       │      ^                             ^            │
       │      │ embouchure (stiffness,      │ length =   │
       │      │              aperture)      │ SR/freq -  │
       │      │                             │ filter phase
       │      │                             │ (D4 compensation)
       │   <──┘  reflection from bell ──────┘
       └─> vibrato LFO → freq modulation
```

**Key components:**
- **Delay line:** circular buffer in `Data`, sample write + fractional read
- **Fractional read:** 1st-order allpass interpolator (1 History)
- **Cone behavior:** truncation filter at the reed end (replaces simple reflection) — standard Scavone/Smith cone waveguide
- **Bell filter:** onepole lowpass (tunable brightness)
- **Reed nonlinearity:** Data-based LUT indexed by (pressure - bore feedback), scaled by reed stiffness; offset by reed aperture
- **Pitch accuracy:** analytic delay-length compensation using onepole + allpass phase delay formulas

**Params (gen~ Param):**
- `reed_stiff` — 0-1, reed damping/stiffness
- `reed_aper` — -1..1, lip pressure offset
- `bell_bright` — 0-1, bell filter cutoff mix
- `vib_rate` — Hz
- `vib_depth` — cents

**Ins/outs:**
- in1: freq (Hz, signal-rate)
- in2: amp (0-1, signal-rate breath pressure)
- out1: audio

## Research (MAX object mapping)

### Host patch (outside gen~)

| Need | Object | Notes |
|------|--------|-------|
| DSP container | `gen~ bassoon` | One gen~ hosts entire model. `patcher-name` arg loads `.gendsp` sidecar. |
| Audio out | `dac~ 1 2` | Stereo duplicate of mono out. |
| Master gain | `*~ 0.5` × `live.gain~` | Gain staging — keep well below 1.0; physical models can get loud on edge instability. |
| Safety | `limi~` | Brick-wall limiter before dac~ for experimentation. |
| Freq input UI | `flonum` + `mtof` + `sig~` | Lets user type MIDI notes or raw Hz; `mtof` supports fractional MIDI for cents. |
| Cents offset | `flonum` + `expr` | Convert `note + cents/100` to freq via `mtof`. |
| Breath/amp input | `slider` or `live.slider` → `line~` | `line~` smooths to signal-rate; prevents zipper noise and clicks. |
| Scope | `live.scope~`, `spectroscope~` | Visualize bore waveform (live.scope~ — Live UI style) and harmonic content during tuning. |
| Tuning verification | `pitch~` (fzero~, retune package) OR FFT-based | `pitch~` not in stock MAX; use `fzero~` from Tristan Jehan or `zsa.fundamental~` — alternatives for measuring output pitch during calibration. Fallback: manual ear + spectroscope~. |

### Inside gen~ codebox (GenExpr)

| Need | Operator | Usage |
|------|----------|-------|
| Signal inputs | `in1`, `in2` | freq (Hz), amp (0-1) |
| Named params | `Param reed_stiff(0.5);` etc. | Declarations at top of codebox. |
| Sample rate | `samplerate` | For computing `delay_samples = samplerate / freq`. |
| Delay buffer | `Data bore(8192);` + `peek`/`poke` | Manual circular buffer — gives full control of fractional allpass read. Preferred over `delay` operator for waveguide. |
| Fractional read | 1st-order allpass | `eta = (1-d)/(1+d); y = eta*x + x_prev - eta*y_prev;` — 2 History cells (x_prev, y_prev). |
| Reed LUT | `Data reed_lut(1024);` + `lookup` | `lookup` maps signal -1..1 to table indices automatically. Table precomputed at load time (filled via init phase or `peek` with external write). |
| Single-sample feedback | `History` | For bore feedback loop, reed state, allpass state, onepole state. |
| Bell lowpass | Onepole IIR in codebox | `y = y_prev + a*(x - y_prev);` where `a = 1 - exp(-2*pi*fc/sr)`. |
| Cone truncation filter | Leaky integrator / differentiator | Scavone cone model: reflection at apex includes `(1 - z^-1)` style high-pass, plus loss term. |
| Vibrato LFO | `cycle(vib_rate)` | Sine wave; multiply by `vib_depth` (in cents) then apply as freq offset via `freq * pow(2, cents/1200)`. |
| Clipping/safety | `clip(x, -1, 1)` | Limit bore state to prevent runaway blow-up. |
| Init-time writes | GenExpr `dim()` loop in external `gendsp` only at load | LUT fill done once via Python precompute, stored in a `Data` with initial values, or populated via a `poke` chain triggered by `history=1` latch. |

### Key gen~ techniques

**1. Fractional delay (1st-order allpass read):**
```
// Pseudo-GenExpr inside codebox
Param freq_hz(220);
History read_prev(0);
History input_prev(0);

target = samplerate / max(freq_hz, 1);    // delay in samples
target -= filter_phase_delay;              // D4 compensation
int_part = floor(target);
frac = target - int_part;
eta = (1 - frac) / (1 + frac);

// Read integer tap from Data 'bore' at (write_idx - int_part) wrapped
x_int = peek(bore, read_index, 0);

// Allpass interpolation
y = eta * x_int + input_prev - eta * read_prev;
input_prev = x_int;
read_prev = y;
```

**2. Reed LUT via `lookup`:** populate `reed_lut` at patch-load time with a precomputed McIntyre/Woodhouse pressure-flow curve. The `lookup` operator auto-maps input -1..1 to the full table — no manual index math needed.

**3. Analytic phase-delay compensation:**
- Onepole lowpass phase delay at bore resonance ≈ `atan(sin(w)*a / (1 - a*cos(w))) / w` samples
- Allpass interpolator phase delay ≈ `d` samples (one of `frac` or `1-frac` depending on form)
- Subtract both from main delay length before computing integer read index

**4. Cone waveguide:** Scavone's thesis gives the "cylindrical-plus-cone-cap" model:
- Main delay line (cylindrical section = bore)
- Apex reflection includes a differentiating/integrating pair `1 - z^-1 / (1 - alpha*z^-1)` where alpha depends on cone truncation ratio
- This produces odd+even harmonics (vs clarinet's odd-only) — correct for bassoon

### Alternatives considered

| Alternative | Why not (for now) |
|-------------|-------------------|
| `delay` operator with `@interp` | Less control over allpass coefficient; phase-delay harder to compensate analytically. Revisit if codebox implementation is too slow. |
| `poly~` voice instance | Not needed for monophonic. Revisit for polyphony. |
| `rnbo~` container | Not needed unless exporting to VST. Add later. |
| Waveguide in MSP primitives (`tapin~`/`tapout~`) | Works but interpolation quality limited; gen~ gives sample-accurate fractional delay. |

### Version compatibility

All operators/objects used are available in MAX 9. No MAX 9-only features relied upon.

### PD-confusion check

None of the following PD objects are used: `osc~`, `lop~`, `hip~`, `bp~`, `tabread~`, `throw~`, `catch~`. Replaced with MAX equivalents (`cycle~`, `onepole~`, `index~`, `send~`/`receive~`) — or done inside gen~ codebox directly.

### Open research items (for later iteration)

- Exact McIntyre/Woodhouse pressure-flow curve parameters for double-reed (vs clarinet single-reed). Sources: STK `BlowBotl`/`Clarinet`, Scavone thesis §5.
- Bell filter impulse response data — whether onepole is sufficient or if 2nd-order biquad better matches a real bassoon bell.
- Register/speaker hole modeling (bassoon has crook + whisper key; can simplify to a single freq-dependent loss filter initially).
- CPU budget for reed LUT size (1024 should be plenty; 4096 if needed for smoothness).

## Research (v0.3 realism pass — 2026-04-22)

**Goal:** identify highest-ROI realism + expressivity improvements to the current v0.2.0 gen~ bassoon. Sources: Grothe (bassoon tonehole-lattice formants, HAL hal-03365402), Almeida/Vergez/Caussé (double-reed pressure-flow + embouchure losses), Scavone waveguide review, STK `Clarinet`/`BlowBotl`, Bassoon Operator (formant spectrum).

### What a real bassoon does that v0.2.0 does NOT

| Feature | v0.2.0 state | Reality |
|---------|-------------|---------|
| **500 Hz radiation formant** | onepole, no formant | Tonehole lattice produces a strong formant peak ~500 Hz — defining bassoon color. |
| **~2200 Hz tonehole cutoff** | slow onepole rolloff | Sharp rolloff above ~2.2 kHz on first register; gives bassoon its dark/round timbre. |
| **Spectral notches @ ~1 kHz & ~3.5 kHz** | none | Chimney pipes trap energy at characteristic freqs → audible anti-resonances. |
| **Reed formant (double-reed linear peak)** | none | Short confined reed channel acts as a BPF peak ~1.2-1.8 kHz; shapes source spectrum before bore. |
| **Frequency-dependent bore loss** | flat `cone_loss=0.85` | Thermoviscous + radiation losses rise with frequency → HF damping per round trip. |
| **Breath turbulence / chiff** | none | Confined air jet in embouchure is a turbulence source — small noise component is physically present, not cosmetic. |
| **Amplitude vibrato (tremolo)** | FM only | Player vibrato couples pressure+pitch; pure FM sounds synthetic. |
| **Attack transient** | linear breath ramp | Onset has subharmonic noise "chiff" before pitch locks in. |
| **Pitch bend / cents offset** | vib_depth only | No static detune — needed for microtonal drift/performance. |
| **Register control** | none | Whisper key + register venting shifts the bore toward 2nd mode. |

### Candidate improvements (tradeoffs)

**Tier A — realism (affects timbre directly, low CPU cost):**

| ID | Change | Adds | Cost |
|----|--------|------|------|
| **A1** | Replace onepole bell with **biquad shaped for 500 Hz formant + 2.2 kHz cutoff**. Reuse `bell_bright` → sweeps formant freq + Q. | proper bassoon color | +2 History, +biquad coeffs |
| **A2** | Insert **reed formant BPF** (2nd-order) on `reed_sig` before bore injection. New params `reed_res_freq` (500-2500 Hz), `reed_res_q` (1-6). | characteristic double-reed honk | +2 History, new params |
| **A3** | **Freq-dependent bore loss**: replace `cone_loss=0.85` scalar with onepole LPF in reflection path. New param `bore_damp` (0-1). | HF damping realism, prevents shrillness | +1 History, 1 param |
| **A4** | **Breath noise**: filtered `noise()` added to `breath` before reed LUT, amount scaled by breath level + `noise_amt` param. | chiff, air realism | +1 History, 1 param |

**Tier B — expressivity (new controls):**

| ID | Change | Adds | Cost |
|----|--------|------|------|
| **B1** | **Amplitude vibrato (tremolo)**: reuse `vib_phase`, modulate `breath` by `(1 + vib_sin * vib_amp)`. New param `vib_amp` (0-0.3). | lifelike vibrato | 1 param |
| **B2** | **Static pitch offset**: `Param pitch_cents(0, -100, 100)` added before vibrato, stacks with `mtof` input. | microtonal ergonomics | 1 param |
| **B3** | **Attack chiff**: breath derivative → gated noise burst at onset. Param `chiff_amt` (0-1). | note attack realism | +2 History, 1 param |
| **B4** | **Register control**: `register` (0-1) param scales `bore_damp` + shifts reflection polarity/gain to favor 2nd mode at high register. | upper-register tone | 1 param, 1 scaling term |

**Tier C — polish (optional):**

- C1: Host-side MIDI/Hz toggle for freq input (addresses recurring "why is my Hz off" confusion — see MEMORY).
- C2: `pattrstorage` preset bank for reed/tone snapshots.
- C3: Lip formant BPF between reed output and bore injection (extra resonance layer).
- C4: 2nd-order allpass fractional delay (marginal tuning accuracy gain, more CPU).

### Recommendation

Ship **A1 + A2 + A3 + A4 + B1 + B2** as v0.3.0 "realism + expressivity pass." This is ~6 new/changed DSP blocks, 5 new params (`reed_res_freq`, `reed_res_q`, `bore_damp`, `noise_amt`, `vib_amp`, `pitch_cents`), no new History beyond ~6 cells. Host patch adds 6 live.dials.

B3/B4 and Tier C are deferable — they layer cleanly on top of the v0.3.0 baseline.
