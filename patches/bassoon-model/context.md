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

## Research (v0.11 vibrato realism pass — 2026-04-23)

**Goal:** Identify what makes the current v0.10.2 vibrato sound synthetic and enumerate high-ROI fixes. Sources: Timmers & Desain 2000 (vibrato rate/depth in performance), Dromey et al. 2003 (instrumental vibrato analysis), Gibiat & Castellengo (wind vibrato studies), MacRitchie & Nuti (flute/oboe vibrato), Fletcher 1975 (perturbation modeling), Rossing "Science of Sound" §17 (wind vibrato).

### Current vibrato (v0.10.2) — what it does

- **One LFO**: `vib_phase += TWOPI * vib_rate / sr`; `vib_sin = sin(vib_phase)`
- **Pitch FM**: `freq * 2^(vib_sin * vib_depth / 1200)` — cents modulation
- **Tremolo AM**: `breath *= 1 + vib_sin * vib_amp` — same sine, same phase, same envelope
- **Ranges**: vib_rate 0.1–12 Hz, vib_depth 0–50 cents, vib_amp 0–0.3

### What a real bassoon vibrato does that v0.10.2 does NOT

| Feature | v0.10.2 state | Reality | Why it matters |
|---------|---------------|---------|----------------|
| **Delayed onset** | Instant at note start | Starts ~150–300ms after attack, ramps to full over 200–500ms | Instant full vibrato is the #1 tell of synthetic playing |
| **Rate jitter** | Metronomic | ±10–15% slow random walk around mean rate | Pure periodic LFO is audibly "locked" |
| **Depth jitter** | Constant | ±15–25% breath-to-breath variation | Real players' diaphragm varies ~0.5 Hz |
| **Pitch↔Amp phase offset** | 0° (perfectly coupled) | Tremolo typically LAGS pitch by ~30–90° | In-phase coupling sounds mechanical; offset gives "roll" |
| **Waveshape** | Pure sine | Slight 2nd-harmonic content, mild asymmetry (rise ≠ fall) | Real diaphragm motion isn't sinusoidal |
| **Register dependence** | Flat | Faster + wider in high register, slower + narrower low | Players physically can't produce 5 Hz vib on pedal notes same as high C |
| **Pitch asymmetry** | Symmetric ± | Real vibrato often biased (more below than above center) | Embouchure mechanics favor one direction |
| **Breath micro-jitter** | None | Constant low-amp 1/f noise on pitch independent of LFO | Even "steady" notes have ±2–5 cent wobble |
| **Release fade** | Cuts at note end | Depth decays over 100–200ms on breath release | Sudden vibrato stop is artificial |

### Candidate improvements (ranked by realism-per-line-of-code)

**Tier A — biggest realism ROI (should ship together as v0.11):**

| ID | Change | What it adds | Cost |
|----|--------|--------------|------|
| **V1** | **Delayed onset envelope**. Detect note-on from breath crossing a threshold (e.g., breath > 0.1 for N samples). Ramp `vib_env` from 0→1 over ~300ms starting ~150ms post-onset. Apply multiplicatively to BOTH `vib_depth` and `vib_amp`. New param `vib_onset_ms` (default 150) optional, but can hardcode. | Eliminates synthetic "instant vibrato" — single biggest realism gain | +2 History (env, onset_timer), ~10 lines |
| **V2** | **Rate jitter**. Add smoothed noise (bandwidth ~0.5–1 Hz via cascaded onepoles) to `vib_rate` with ±12% deviation. New param `vib_rate_jit` (0–0.3, default 0.12). | Breaks metronomic lock, matches real diaphragm irregularity | +2 History (jit_lp1, jit_lp2), 1 param |
| **V3** | **Pitch↔Amp phase offset**. Compute `amp_phase = vib_phase - phase_offset` then `amp_sin = sin(amp_phase)`. Use `vib_sin` for FM, `amp_sin` for tremolo. Fixed offset ~45° (π/4) works well for bassoon; or param `vib_amp_lag` (0–1, 0=in-phase, 1=90°). | Decouples pitch/amp perceptually, removes "organ" quality | 0 History, 1 param (optional) |

**Tier B — nice polish, low cost (can stack on V1–V3):**

| ID | Change | What it adds | Cost |
|----|--------|--------------|------|
| **V4** | **Depth jitter**. Slow smoothed noise (~0.3 Hz) modulating effective depth ±15% around setpoint. Share with V2's jitter bus or separate. | Cycle-to-cycle breath variation | +2 History, minimal |
| **V5** | **Non-sinusoidal waveshape**. `vib_wave = sin(x) + 0.08 * sin(2x + φ)` — tiny 2nd-harmonic injection with phase φ ≈ π/6 gives asymmetric rise/fall. | Slight "human" curve to the sweep | 0 History, 0 params |
| **V6** | **Release fade**. When breath drops below onset threshold, decay `vib_env` over ~150ms (don't cut instantly). V1's envelope generalizes to cover this. | Natural vibrato tail on release | shared with V1 |

**Tier C — more involved, deferrable:**

| ID | Change | What it adds | Cost |
|----|--------|--------------|------|
| **V7** | **Register-dependent rate/depth**. Scale `vib_rate` and `vib_depth` with freq: e.g., `rate_eff = vib_rate * (0.85 + 0.3 * freq_norm)`, similar for depth. `freq_norm = (log2(freq/110) / 3)` clipped. | Physiological realism across registers | ~5 lines |
| **V8** | **Pitch asymmetry**. Bias LFO so positive swings are ~15% smaller than negative (or reverse). Shape: `vib_sin_asym = vib_sin - 0.15 * sign(vib_sin) * abs(vib_sin)^2`. | Embouchure realism — not always audible | 0 History |
| **V9** | **Breath micro-jitter**. Very low-amp (±3 cents) 1/f-shaped noise added to pitch independently of vibrato LFO. Active even when `vib_depth=0`. | "Alive" sustained notes, breath character | +3 History (pink filter) |

### Recommendation

Ship **V1 + V2 + V3 + V5 + V6** as v0.11.0 "vibrato realism pass." These together address the top three synthetic tells (instant onset, metronomic rate, in-phase coupling) plus waveshape asymmetry at near-zero cost. V4 can fold in if depth jitter becomes desirable after listening. V7–V9 are deferrable polish.

**Implementation plan sketch (all inside existing gen~):**
```
// Add Params
Param vib_onset_time(0.15, 0, 1);    // delay before vibrato ramps up (s)
Param vib_ramp_time(0.3, 0.05, 1);   // ramp duration (s)
Param vib_rate_jit(0.12, 0, 0.3);    // ±fraction of rate
Param vib_amp_lag(0.5, 0, 1);        // 0=in-phase, 1=90° lag

// Add History
History vib_env(0);
History onset_timer(0);
History jit_state1(0);
History jit_state2(0);

// --- Onset / release envelope (V1, V6) ---
// Breath threshold = 0.05. Count samples above threshold, reset when below.
breath_on = breath_state > 0.05 ? 1 : 0;
onset_timer = breath_on ? onset_timer + 1 : 0;
onset_sec = onset_timer / samplerate;
// Ramp: 0 until vib_onset_time, then linear 0→1 over vib_ramp_time
vib_target = clamp((onset_sec - vib_onset_time) / vib_ramp_time, 0, 1);
// Smoothed envelope: 50ms attack, 150ms release
env_a = breath_on ? (1 - exp(-1 / (samplerate * 0.05))) : (1 - exp(-1 / (samplerate * 0.15)));
vib_env = vib_env + env_a * (vib_target * breath_on - vib_env);

// --- Rate jitter (V2) ---
jit_raw = noise();
jit_fc = 0.7; // Hz
jit_a = 1 - exp(-TWOPI * jit_fc / samplerate);
jit_state1 = jit_state1 + jit_a * (jit_raw - jit_state1);
jit_state2 = jit_state2 + jit_a * (jit_state1 - jit_state2);  // cascade for smoothness
rate_eff = vib_rate * (1 + vib_rate_jit * jit_state2 * 3);  // *3 to counter noise() RMS

// --- LFO with V5 waveshape ---
vib_inc = TWOPI * rate_eff / samplerate;
vib_phase = vib_phase + vib_inc;
if (vib_phase > TWOPI) { vib_phase = vib_phase - TWOPI; }
vib_sin_pure = sin(vib_phase);
vib_sin = vib_sin_pure + 0.08 * sin(2 * vib_phase + 0.52);  // π/6 phase shift

// --- Phase offset for tremolo (V3) ---
amp_phase = vib_phase - (PI * 0.5 * vib_amp_lag);
amp_sin = sin(amp_phase) + 0.08 * sin(2 * amp_phase + 0.52);

// --- Apply envelope to depth + amp ---
cents_offset = vib_sin * vib_depth * vib_env;
trem_gain = 1.0 + amp_sin * vib_amp * vib_env;
```

Net cost: +4 Param, +4 History, ~20 lines in the LFO block. No changes to reed/bore/bell paths.

### Expected audible differences

- **Before**: machine-precise 5 Hz wobble with pitch and loudness in lockstep; present from first sample; feels like ring-mod
- **After V1**: note speaks clean for ~200ms then vibrato "breathes in"; vibrato decays naturally on release
- **After V2**: rate drifts 4.5–5.5 Hz organically; no two cycles identical
- **After V3**: pitch and loudness no longer peak together; feels like a player, not a modulator
- **After V5**: subtle — removes the last "pure tone" character from the LFO shape

