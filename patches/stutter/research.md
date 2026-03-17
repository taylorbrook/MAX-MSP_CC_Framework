# Stutter Effect — Research Findings

## gen~ Stutter Engine Architecture

### Buffer Access
- **`Buffer buf("stutter_buf")`** — references external `buffer~` named "stutter_buf" in parent patch
- **`peek(buf, index, channel)`** — read sample at index (0-based sample position), channel (0=L, 1=R)
- **`poke(buf, value, index, channel)`** — write sample at index
- Circular buffer: use `History write_pos(0)` to track write position, wrap with `wrap()`

### State Tracking
- **`History`** for all persistent state: write position, read position, slice boundaries, trigger state
- **`Param`** for all user-facing controls
- **`Data`** for lookup tables (division factors)

### Playback Engine — Dual-Voice Crossfade
Two alternating voices (A/B) prevent clicks on all transitions.

**Per-voice History variables (x2 for L/R = x4 total sets):**
- `read_pos_A_L`, `read_pos_A_R`, `read_pos_B_L`, `read_pos_B_R`
- `env_A` (0→1 fade in or 1→0 fade out), `env_B`
- `slice_start_A`, `slice_start_B` (where each voice's slice begins)
- `slice_len_A`, `slice_len_B`
- `rate_A`, `rate_B` (playback rate including pitch + reverse)
- `active_voice` (0 = A is active/fading in, 1 = B is active/fading in)

**Voice swap trigger conditions:**
1. Loop wrap: active voice reaches end of slice
2. Division change: `change()` detects param change
3. Reverse toggle: `change()` detects param change
4. Stutter engage: `change()` on stutter_active

**Crossfade mechanics:**
- Fade time: ~5ms = `fade_samples = 0.005 * samplerate` (~220 samples)
- Active voice envelope ramps 0→1 over fade_samples
- Inactive voice envelope ramps 1→0 over fade_samples (then stops processing)
- `env_A = env_A + fade_inc` (clamped 0–1), `env_B = env_B - fade_inc` (or vice versa)
- Output = `voice_A_sample * env_A + voice_B_sample * env_B`

**On swap:**
1. Toggle `active_voice`
2. New active voice: set read_pos to new slice_start, set envelope to 0 (will ramp up)
3. Old voice: keep playing from current position, envelope ramps down to 0

### Chaotic Mode
- `noise()` generates white noise (-1 to 1) — scale and `sah`/`latch` to sample-and-hold random values
- On each stutter cycle boundary: sample new random values for offset, length variation, rate variation
- `sah(noise(), trigger, 0)` — sample noise when trigger crosses zero, hold until next trigger
- Blend with `mix(rhythmic_output, chaotic_output, chaos_amount)`

### Division Table
- Use `Data divisions(19)` with pre-poked factor values
- Or compute in-line with if/else chain (no performance cost in gen~, both branches always execute)
- Factor computation: `slice_samples = samplerate * 60.0 / bpm / factor`

### Feedback
- Mix output back into write path: `poke(buf, in_sample + feedback * out_sample, write_pos, ch)`
- Cap feedback at 0.95 to prevent runaway

### gen~ Limiter (separate gen~ object)
- Envelope follower pattern from existing codebase:
  ```
  att_coeff = exp(-1 / (attack_ms * 0.001 * samplerate));
  rel_coeff = exp(-1 / (release_ms * 0.001 * samplerate));
  ```
- Compare abs(input) to threshold, compute gain reduction
- Apply with `output = input * gain`
- Attack ~1ms (44 samples), release ~50ms (2200 samples)

### Stereo
- Single gen~ with 4 audio I/O: in1=L, in2=R, out1=L, out2=R
- Plus extra output: out3 = current read position (normalized 0-1 for waveform~ display)
- L/R share all Params but process independently with separate History variables per channel

## GenExpr Syntax Patterns (from existing project code)

```genexpr
// Declarations first
Param bpm(120, min=20, max=300);
History write_pos(0);
Buffer buf("stutter_buf");
Data divisions(19);

// I/O
x_L = in1;
x_R = in2;
sr = samplerate;

// Processing...
out1 = result_L;
out2 = result_R;
out3 = position;  // control signal for display
```

## UI Object Details

### waveform~ (buffer display + slice indicator)
- Set buffer: `name stutter_buf` message or `buffername` attribute
- **Inlet 2**: selection start (ms) — use for slice start indicator
- **Inlet 3**: selection end (ms) — use for slice end indicator
- Selection highlight shows the current playback region
- Use `snapshot~` on gen~ out3 to get position, scale to ms, send to waveform~

### Level Metering
- `meter~` — simple peak LED meter, good for compact display
- `levelmeter~` — RMS with ballistics, better for mixing context
- Recommendation: use `meter~` for compact layout

### Controls
- `dial` — rotary knob. Key attrs: `size` (range), `min`, `mult`, `floatoutput`
- `umenu` — division selector. Items format: `["1/4", ",", "1/4.", ",", "1/4T", ...]`
- `toggle` — for stutter on/off, reverse, input source
- `textbutton` — for file open (mode=0 for momentary, sends bang)
- `led` — stutter activity indicator with `oncolor`/`offcolor`
- `dropfile` — drag-and-drop zone for soundfile loading

### snapshot~ (gen~ position → waveform~ display)
- Connects to gen~ audio output carrying position signal
- Converts signal to control-rate float
- Set `interval` attribute (e.g., 50ms) for update rate
- Output goes to waveform~ selection inlets (scaled from 0-1 to ms)

## Patcher.py Integration

### add_gen() method
- `patcher.add_gen(code, num_inputs, num_outputs, x, y)` → returns `(Box, Patcher)`
- Auto-detects I/O from `in1`/`out1` patterns in code
- Codebox code stored in `extra_attrs["code"]`
- Parent box: `maxclass="newobj"`, `text="gen~"`, `outlettype=["signal"]*N`

### buffer~ creation
- Use `patcher.add_object("buffer~", ...)` — uses own maxclass `buffer~`
- Text: `"buffer~ stutter_buf 4000 2"` (name, duration_ms, channels)
- Messages: `set`, `read`, `clear`, `sizeinsamps`

### selector~ 2 for input switching
- `patcher.add_object("selector~", args="2")` — 3 inlets (select, in1, in2), 1 outlet
- variable_io: inlet_count = first_arg + 1

## Key Constraints
- gen~ codebox uses `in1`/`out1` (no space), NOT `in 1`/`out 1`
- Delay uses `.read()`/`.write()` methods, NOT `delay()`
- Initialize History variables before if/else blocks
- gen~ params: send as plain name messages (`bpm 120`), not `@bpm 120`
- Both branches of if/else always execute in gen~ (SIMD) — no performance penalty
- `samplerate` is a keyword, not a function
