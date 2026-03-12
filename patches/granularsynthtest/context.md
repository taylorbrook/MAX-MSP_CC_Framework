# granularsynthtest

## Overview
Granular synthesizer with a Gen~ DSP engine, polished UI, and MC multichannel output for flexible speaker arrays.

## Requirements

### Audio I/O
- **Both** file-based (buffer) and live input (real-time) granular modes
- Input: audio file loaded into buffer OR live audio input
- Output: MC (multichannel) for flexible speaker array compatibility

### Grain Parameters
- Grain size / duration
- Grain density / overlap count
- Position (scan through buffer)
- Pitch / transposition
- Randomization: position jitter, pitch scatter, size variation
- Envelope shape (Hanning, triangle, tukey, etc.)
- Spatialization: panning movements and randomized panning per grain

### UI Design
- Creative, visually polished, intuitive to manipulate
- Presentation mode layout
- Nice aesthetic with thoughtful color scheme

### Output Architecture
- MC (multichannel) objects for modular speaker array support
- mc.mixdown~ for flexible speaker count panning
- mc.pack~ to combine grain voices into MC signal
- Coordinate-based panning via cartopol~/poltocar~ for spatial positioning

### Target
- MAX 9 (latest version)

## Architecture

### Signal Flow
```
[buffer~ / adc~] → [gen~ granular-engine] → [mc.pack~] → [mc.mixdown~ N] → [mc.dac~]
                         ↑                        ↑
                   grain params              pan positions
                   from UI controls          (per-grain randomized)
```

### Gen~ Engine (core DSP)
- Polyphonic grain voices using phasor-driven scheduling
- Buffer access via peek/sample operators
- Grain envelopes via triangle + smoothstep operators
- Pitch shifting via playback rate modulation
- Per-grain randomization via noise operator + latch/sah
- Parameters exposed via Param objects for UI control

### MC Panning
- mc.pack~ combines individual grain voice outputs
- mc.mixdown~ with configurable output channel count
- Pan position driven by line~/phasor~/noise for movement patterns
- Randomized panning: noise-seeded per-grain pan positions
- Supports stereo through arbitrary speaker counts

### UI Controls (Presentation Mode)
- Source selector (file/live toggle)
- Buffer waveform display (waveform~)
- Grain controls: size, density, position, pitch (knobs/dials)
- Randomization controls: jitter amounts for each parameter
- Envelope shape selector
- Spatial controls: pan position, spread, movement speed, randomization
- Output channel count selector
- Master gain with level metering

## Research

### Approach: Gen~ Phasor-Driven Granular Engine

The core DSP runs inside a single `gen~` object using GenExpr/codebox. This is the standard high-performance approach for granular synthesis in MAX — all grain scheduling, buffer reading, enveloping, and mixing happens at sample rate inside Gen~.

#### Grain Voice Architecture (inside Gen~)

Each grain voice uses a **phasor-driven scheduling model**:

1. **Grain clock**: A `phasor` running at `density/num_voices` Hz generates a 0→1 ramp per grain lifecycle
2. **Phase offset**: Each voice is offset by `voice_index / num_voices` so grains are evenly staggered
3. **Envelope**: `triangle` operator on the grain phase creates the window shape. Duty cycle parameter morphs between triangle (0.5), attack-heavy, and decay-heavy shapes. For Hanning: use `0.5 - 0.5 * cos(phase * TWOPI)`
4. **Buffer read**: `sample` operator (interpolated) reads from the external `buffer` reference. Read position = `grain_position + phase * grain_size * pitch_rate`
5. **Randomization**: `noise` + `latch` (triggered at grain onset, when phase wraps) gives per-grain random values for position jitter, pitch scatter, size variation, and pan position
6. **Output**: Each voice outputs `sample_value * envelope`. All voices are summed inside Gen~ for mono/stereo, OR output as separate outlets for MC panning

**Recommended voice count**: 8-16 voices (configurable). More voices = smoother cloud but higher CPU.

#### Key Gen~ Objects Used

| Object | Role | Notes |
|--------|------|-------|
| `param` | Expose grain size, density, position, pitch, jitter amounts | min/max/default attributes |
| `buffer` | Reference external `buffer~` | First arg = internal name, second = external buffer~ name |
| `dim` | Get buffer length in samples | For position scaling |
| `sample` | Read buffer with interpolation | Phase input 0-1, with start/end range |
| `peek` | Read buffer without interpolation | Alternative for precise sample access |
| `phasor` | Grain clock per voice | Frequency = density / num_voices |
| `triangle` | Grain envelope shape | Phase + duty cycle inputs |
| `noise` | Random values | Output range -1 to 1 |
| `latch` | Sample-and-hold randomization | Latch noise at grain onset |
| `history` | Single-sample delay for onset detection | Detect phase wrap: `phase < history(phase)` |
| `data` | Internal lookup tables | For custom envelope shapes |

#### GenExpr Pseudocode (per voice)

```
// Grain clock with voice offset
grain_freq = density / NUM_VOICES;
raw_phase = phasor(grain_freq);
phase = wrap(raw_phase + voice_offset, 0, 1);

// Onset detection (phase wrapped around)
prev_phase = history(phase);
onset = phase < prev_phase;  // true on grain start

// Per-grain randomization (latched at onset)
rand_pos = latch(noise(), onset) * pos_jitter;
rand_pitch = latch(noise(), onset) * pitch_jitter;
rand_size = latch(noise(), onset) * size_jitter;
rand_pan = latch(noise(), onset) * pan_spread;

// Buffer read position
buf_len = dim(buf);
grain_size_samps = (grain_size_ms + rand_size) * samplerate / 1000;
read_pos = (position + rand_pos) * buf_len;
read_index = read_pos + phase * grain_size_samps * (pitch + rand_pitch);

// Envelope (Hanning window)
env = 0.5 - 0.5 * cos(phase * TWOPI);
// OR triangle: triangle(phase, 0.5)

// Output
out = peek(buf, read_index, 0, channels=1) * env;
```

### Buffer Management

- **`buffer~`** (MSP): Main audio storage. Args: name, optional filename, duration, channels
  - Inlets: 1 (messages: read, write, size, etc.)
  - Outlets: 2 (mouse position ms, bang on file load complete)
  - RNBO compatible: yes
- **`record~`** (MSP): Write live audio to buffer. Args: buffer-name, input-channels
  - Inlets: 3 (signal input + start/stop, record start ms, record end ms)
  - Outlets: 1 (sync output)
- **`waveform~`** (MSP): Visual buffer display/editor (UI)
  - Inlets: 5 (display start, display length, selection start, selection end, link)
  - Outlets: 6 (display start, display length, sel start, sel end, mouse output, link)

### MC Output Chain

The multichannel output uses this signal path:

```
[gen~ outputs per-voice audio + pan] → [mc.pack~ N] → [mc.mixdown~ output_chans] → [mc.gain~] → [mc.dac~]
```

**Object details:**

- **`mc.pack~`** — Combines N single-channel inputs into one MC signal. Arg: number of inlets/channels. `variable_io: true`
  - Each gen~ voice output connects to one mc.pack~ inlet
- **`mc.mixdown~`** — Pans and mixes MC input to N output channels. Arg: output channel count
  - Left inlet: MC audio signal
  - Right inlet: MC pan positions (0-1 per input channel)
  - Key attributes: `autogain`, `chans`, `pancontrolmode`
- **`mc.gain~`** — MC signal level slider with visual metering
- **`mc.dac~`** — MC audio output to hardware

**Pan position strategy**: Each grain voice has a randomized pan value (from Gen~ `noise` + `latch`). These pan values are sent out of Gen~ via separate outlets, packed with `mc.pack~`, and connected to `mc.mixdown~`'s right inlet.

### Alternative Approaches Considered

#### 1. poly~ Voice Allocation (rejected for primary engine)
- `poly~` with `thispoly~` inside a subpatcher per grain voice
- Each voice uses `groove~` or `play~` for buffer playback
- Pros: natural voice stealing, per-voice muting, familiar MAX patching
- Cons: higher overhead per voice, harder to get precise sample-accurate scheduling, message-rate grain triggering limits density
- **Verdict**: Gen~ is better for high-density granular (100+ grains/sec). poly~ is fine for sparse granular (< 20 grains/sec)

#### 2. wave~ + phasor~ (MSP-only, no Gen~)
- `phasor~` drives `wave~` with start/end points for each grain
- Envelope via `*~` with a second `wave~` reading an envelope buffer
- Pros: simple, no Gen~ knowledge needed
- Cons: limited voice count without poly~, harder to randomize per-grain
- **Verdict**: Good for simple cases but doesn't scale to the feature set needed here

#### 3. RNBO Export Path
- Many key objects ARE RNBO compatible: `buffer~`, `wave~`, `groove~`, `record~`, `param`, `peek`, `poke`, `data`, `dim`, `channels`, `noise`, `latch`, `triangle`
- NOT RNBO compatible: `poly~`, `index~`, `play~`, `sample` (gen~), `phasor` (gen~), `history` (gen~)
- **Verdict**: An RNBO-exportable version is possible but would need workarounds for phasor/history. Not a priority for v1.

### UI Object Recommendations

| Control | Object | Notes |
|---------|--------|-------|
| Dials/knobs | `live.dial` | 2 outlets (scaled value, raw 0-1). Attributes for colors, appearance |
| Menus | `live.menu` | 3 outlets (index, symbol, raw). For envelope shape, source select |
| Toggles | `live.toggle` | File/live mode switch |
| Waveform | `waveform~` | Buffer display with selection range |
| Envelope editor | `function` | Breakpoint editor, 4 outlets |
| Gain slider | `mc.gain~` | MC-aware gain with metering |
| Labels | `comment` | With bubble attributes for tooltips |

### Version Compatibility

All objects verified for MAX 9. MC objects require MAX 8.1+. No MAX 9-only objects are strictly required, so the patch could work on MAX 8.1+ with minor adjustments.
