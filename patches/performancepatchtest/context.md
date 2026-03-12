# performancepatchtest

## Overview
Performance patch for instrument and live electronics. Triggers events that change live processing routing and play back soundfiles. Organized with subpatchers, presentation mode mixer.

## Audio I/O
- **Input**: Mono mic (1 channel)
- **Output**: Stereo

## Signal Flow
1. Live mono input → EQ → Multiband Compressor (always on, front-end processing)
2. Post-compressor signal routed to effects based on current cue state:
   - Feedback Delay
   - Distortion
   - Detune
3. Effect sends/returns controlled per-cue (routing changes at each event)
4. Soundfile playback: up to 3 stereo files simultaneously, fire-and-forget
5. All sources → Mixer (gain~ + meter~  per channel) → Master output

## Event System
- **Cue list**: numbered cues, performer advances with "next"
- **MIDI triggers**: footpedal/controller can also trigger cues
- Each cue defines:
  - Which effects the live input routes through
  - Which soundfiles to trigger (if any)
  - Effect parameter changes

## Mixer Channels
1. Live input (post-processing, dry)
2. Feedback delay return
3. Distortion return
4. Detune return
5. Soundfile playback (stereo bus)
6. Master output

## Subpatcher Organization
- `p input-processing` — EQ + multiband compressor
- `p feedback-delay` — feedback delay effect
- `p distortion` — distortion effect
- `p detune` — detune/pitch shift effect
- `p soundfile-player` — 3x stereo file playback
- `p cue-system` — cue list + MIDI trigger logic
- `p mixer` — gain~ + meter~ mixer with presentation mode UI

## Target
- MAX 9
