# rhythmic-sampler

Sequis-inspired rhythmic sampler with synchronized playback and rich sample manipulation.

## Requirements

### Audio/MIDI
- Internal step sequencer for triggering (no MIDI input or clock sync for now)
- Audio output to dac~

### Sample Slots
- 8 independent sample slots
- Each slot loads its own audio file
- Independent loop points, start/end markers, playback direction (forward/reverse/ping-pong)

### Rhythmic Sync & Manipulation
- **Slice-based sequencing:** divide each sample into N slices, sequence the playback order
- **Time-stretching:** samples stay in sync with master tempo regardless of original length
- **Per-slot manipulation controls:**
  - Pitch (semitones + fine tune)
  - Filter (LP/HP/BP with cutoff and resonance)
  - Reverse playback
  - Stutter/repeat
  - Envelope (attack/decay)
  - Sample rate reduction (bitcrush/downsample)

### Step Sequencer
- Master tempo control (BPM)
- Per-slot step patterns (16 steps per slot)
- Step velocity support
- Pattern length per slot (1-16 steps)
- Global transport (play/stop)

### UI / Presentation Mode
- Performance-ready presentation view
- Waveform display per slot (showing slice points)
- Per-slot controls panel
- Step sequencer grid
- Master transport and tempo controls
- Functional layout with default MAX styling

## Architecture Notes

### Signal Flow
```
[sample files] → [buffer~] → [groove~ / play~] → [per-slot FX chain] → [mixer] → [dac~]
```

### Key Object Choices
- `buffer~` for sample storage (one per slot)
- `groove~` for playback with pitch/speed control and looping
- `waveform~` for visual display with selection
- `onepole~` / `svf~` / `biquad~` for filtering
- `metro` + `counter` for step sequencer clock
- `degrade~` for sample rate reduction
- `transport` for master tempo

## Decisions

### 1. Slice Engine: Equal divisions + manual adjust
- Start with N equal-length slices (8, 16, 32)
- User can drag/nudge individual slice points on the waveform display
- Slice points stored per slot

### 2. Time-Stretch: Slice-quantized
- No audio stretching -- slices trigger at tempo-synced intervals
- Each slice plays at original speed/pitch
- Sequencing is locked to master tempo
- Artifact-free approach

### 3. Patch Structure: bpatcher per slot
- One reusable subpatch (slot.maxpat) instantiated 8 times
- Each bpatcher gets its own visual panel in presentation mode
- Communication via send/receive with slot index prefix

### 4. Step Sequencer: multislider + coll backend
- multislider (16 steps) per slot for visual velocity editing
- coll per slot for saving/loading patterns
- 0 = step off, 1-127 = velocity

### 5. FX Chain Order
```
groove~ → pitch (gizmo~/pfft~ or rate) → filter (svf~) → stutter → bitcrush (degrade~) → envelope (*~ with line~)
```

### 6. Mixer: Volume + Pan + Mute/Solo + Send
- Per-slot: gain, pan, mute toggle, solo toggle
- Send level to shared effects bus
- Effects bus: placeholder for now (user will choose later)
- All slots sum to stereo master output → dac~

## Version
- MAX 9 (required)
