# stutter

Glitchy stutter audio effect with rhythmic and chaotic modes, built around a gen~ stutter engine.

## Architecture

```
[Input Stage] → [Capture Buffer] → [gen~ Stutter Engine] → [gen~ Limiter] → [Dry/Wet Mix] → [dac~]
                                          ↑ feedback ←──────────┘
```

## Requirements

### Audio Routing
- Switch between live audio input (adc~) and soundfile playback (sfplay~, looped)
- selector~ to toggle between sources
- File loading via dropfile / opendialog
- Stereo processing throughout

### Capture Buffer
- 4-second stereo buffer~
- Circular recording via gen~ poke
- Write position tracked with History in gen~

### gen~ Stutter Engine (core)
- **Architecture**: Single gen~ codebox, stereo (L/R processed independently with same params)
- **Buffer I/O**: peek for read, poke for write (circular buffer)
- **Dual-voice crossfade**: Two alternating playback voices (A/B) with crossfade envelope
  - On loop wrap: current voice fades out, other voice takes over at slice start, fades in
  - On retrigger (division change, reverse toggle): same swap — no clicks on any transition
  - On stutter engage/disengage: crossfade between dry and stuttered signal
  - Crossfade time: ~5ms (~220 samples at 44.1kHz)
  - Each voice has its own History set: read_pos, slice_start, slice_len, rate, envelope
  - Active voice flag tracked with History active_voice(0) — toggles 0/1 on each retrigger
- **Playback**: Manual phasor via History per voice, wrapping at slice boundary
- **Rhythmic mode**: Slice length from BPM + division. Formula: slice_samples = samplerate * 60 / bpm / division_factor
- **Chaotic mode**: Randomized slice start, length, and playback rate per trigger cycle (noise-driven)
- **Pitch shift**: Phase increment multiplied by rate factor (0.5 = -1 oct, 2.0 = +1 oct)
- **Reverse**: Negate phase increment — triggers voice swap for click-free transition
- **Blend**: Crossfade between rhythmic and chaotic via chaos_amount param
- **Feedback**: Mix fraction of output back into buffer write path
- **Retrigger**: Immediately snap to new division via voice swap (no wait for cycle end, no click)

### gen~ Params
- stutter_active (0/1) — toggle on/off
- bpm (20–300) — tempo for rhythmic divisions
- division (0–N) — index into division table (see below)
- slice_length (0–1) — normalized, scales within division window
- pitch (0.5–2.0) — playback rate
- reverse (0/1) — direction toggle
- chaos_amount (0–1) — blend rhythmic ↔ chaotic
- feedback (0–0.95) — feedback amount, capped below 1
- dry_wet (0–1) — mix

### Division Table
| Index | Division | Factor | Notes |
|-------|----------|--------|-------|
| 0     | 1/4      | 1      | quarter note |
| 1     | 1/4.     | 0.667  | dotted quarter |
| 2     | 1/4T     | 1.5    | quarter triplet |
| 3     | 1/8      | 2      | eighth note |
| 4     | 1/8.     | 1.333  | dotted eighth |
| 5     | 1/8T     | 3      | eighth triplet |
| 6     | 1/16     | 4      | sixteenth note |
| 7     | 1/16.    | 2.667  | dotted sixteenth |
| 8     | 1/16T    | 6      | sixteenth triplet |
| 9     | 1/32     | 8      | thirty-second note |
| 10    | 1/32.    | 5.333  | dotted thirty-second |
| 11    | 1/32T    | 12     | thirty-second triplet |
| 12    | 1/64     | 16     | sixty-fourth note |
| 13    | 1/4 quint | 1.25  | quarter quintuplet |
| 14    | 1/8 quint | 2.5   | eighth quintuplet |
| 15    | 1/16 quint| 5     | sixteenth quintuplet |
| 16    | 1/4 sept  | 1.75  | quarter septuplet |
| 17    | 1/8 sept  | 3.5   | eighth septuplet |
| 18    | 1/16 sept | 7     | sixteenth septuplet |

### gen~ Limiter
- Separate gen~ object after stutter engine
- Brickwall limiter with envelope follower via History
- Fast attack (~1ms / ~44 samples), slow release (~50ms / ~2200 samples)
- Gain reduction when envelope exceeds threshold
- Stereo, L/R independent
- Prevents feedback loop from blowing up

### UI — Presentation Mode
- **waveform~** showing full 4-second capture buffer
- **Slice indicator**: second waveform~ or highlight overlay showing current playback region
- **BPM dial** (20–300)
- **Division selector** (umenu with all 19 divisions)
- **Slice length dial** (0–1)
- **Pitch dial** (-1 oct to +1 oct, displayed as semitones or ratio)
- **Reverse toggle** button
- **Chaos amount dial** (0–1)
- **Feedback dial** (0–0.95)
- **Dry/wet dial** (0–1)
- **Stutter on/off toggle** (main engage)
- **Input source switch** (live / file)
- **Input level meter~**
- **Output level meter~**
- **Stutter activity LED** (driven by gen~ output)
- **File open button** for soundfile loading

## Decisions
- gen~ for stutter engine (sample-level control, tight glitch timing)
- gen~ for limiter (no external objects like omx)
- No filter or bit-crush effects (may add later)
- L/R processed independently with shared params
- Soundfile loops continuously
- Buffer waveform shows full 4 sec + slice position indicator
- Dual-voice crossfade (A/B voices) for click-free transitions on all events (loop wrap, retrigger, division change, reverse toggle, stutter engage/disengage)
