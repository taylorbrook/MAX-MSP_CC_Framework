# kicksynth

Fully customizable kick drum synthesizer inspired by Kick 3 (Sonic Academy).

## Requirements

### Synthesis Engine
- **Architecture:** Gen~ core engine for sample-accurate pitch envelopes, oscillator phase reset, click generation
- **Layers:**
  - Body/pitch layer -- sine oscillator with exponential pitch envelope sweep (main tonal component)
  - Click/transient layer -- pulse + filtered noise burst for attack snap
  - Sub layer -- pure sine at fundamental frequency for low-end weight
  - Noise layer -- filtered white/pink noise burst for attack texture
- **Output:** Standard MAX patch (not RNBO)

### Parameters (per layer + master)
- Pitch (start/end frequency, envelope curve shape, decay time)
- Amplitude envelope (attack, hold, decay, curve shape)
- Waveform selection (sine, triangle, saturated sine)
- Drive/saturation (tanh-based with drive amount)
- Filtering (HP/LP per layer)
- Layer mix/balance
- Master output (volume, EQ, limiter)

### Trigger
- MIDI note input
- On-screen button
- Both simultaneously

### UI / Visualization
- Waveform display of output kick (scope~)
- Pitch envelope curve visualization
- Amplitude envelope curve visualization
- Spectrum/frequency analyzer (spectroscope~)
- Parameter controls with visual feedback

### Reference
- Kick 3 by Sonic Academy as design inspiration
- TR-808 and TR-909 circuit architectures as algorithm references
- Focus on deep customization of kick drum sound

## Research Summary

### Core Algorithm
- Sine oscillator with exponential pitch decay (start 150-800Hz -> end 30-65Hz)
- Pitch decay time 5-100ms defines character (fast=punchy, slow=808-style)
- Amplitude decay 100-800ms
- Gen~ essential for sample-accurate envelope timing and phase-coherent oscillator reset

### Layer Architecture
- Body: sine + pitch envelope (primary sound)
- Click: single-sample pulse + short noise burst (attack transient)
- Sub: pure sine at fundamental, no pitch sweep (low-end weight)
- Noise: filtered white noise with short envelope (texture)

### Signal Chain
- Per-layer: oscillator -> saturation -> filter -> amp envelope -> level
- Master: layer mix -> EQ (HP 20Hz, shelf boost 50-80Hz, cut 200-400Hz, presence 2-5kHz) -> limiter
- Saturation: tanh(drive * x) / tanh(drive) for normalized soft clipping

### Presets by Style
- 808: start 130Hz, end 49Hz, pitch decay 30-100ms, amp decay 300-800ms, no click
- 909: start 200-300Hz, end 50-60Hz, pitch decay 5-15ms, amp decay 150-300ms, strong click
- Techno: start 200-500Hz, end 40-55Hz, pitch decay 10-30ms, tight
- Trap: start 150-250Hz, end 35-50Hz, long decay, deep sub
