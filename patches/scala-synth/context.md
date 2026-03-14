# scala-synth

A 16-voice polyphonic additive synthesizer with Scala (.scl) file support for microtonal playback.

## Overview

Additive synth where each voice computes up to 32 sine partials in a gen~ codebox. Scala tuning files remap MIDI note numbers to microtonal frequencies. Full UI with presentation mode.

## Audio / MIDI Requirements

- MIDI note input (notein) with velocity sensitivity
- 16-note polyphony via poly~
- Output to dac~ with master volume control

## Signal Flow

```
MIDI In -> notein -> Scala frequency lookup (buffer~) -> poly~ (16 voices)
  Each voice:
    gen~ additive engine (1-32 sine partials)
      - Spectral tilt (amplitude rolloff across partials)
      - Harmonic stretch (inharmonicity factor)
      - Even/odd partial balance
      - Partial drift (per-partial random detuning)
    -> ADSR envelope (adsr~)
    -> voice output
-> mix -> master volume -> dac~
```

## Additive Engine (gen~ codebox)

- Fundamental frequency from Scala-tuned lookup table
- Number of partials: 1-32, user-controllable
- Spectral tilt: controls 1/f^n rolloff exponent (0 = flat, 1 = natural, 2+ = dark)
- Harmonic stretch: partial N freq = fundamental * N^stretch (1.0 = pure harmonic, >1 = inharmonic/metallic)
- Even/odd balance: crossfade between full series, odd-only, even-only
- Partial drift: small per-partial random frequency offset for organic motion
- All partials summed and normalized

## Scala File Handling

- js object parses .scl text files
- Extracts pitch ratios (supports both cents and ratio notation)
- Builds a 128-entry MIDI-to-frequency table
- Stores table in a buffer~ (128 samples) for gen~ lookup
- Default: 12-TET until a .scl file is loaded

## UI / Presentation Mode (go all out)

- Scala file loader (drag & drop or browse)
- Tuning info display (scale name, number of degrees)
- Number of partials slider (1-32)
- Spectral tilt knob
- Harmonic stretch knob
- Even/odd balance knob
- Partial drift amount knob
- ADSR envelope controls (4 knobs or sliders)
- Master volume slider with level meter
- Partial amplitude visualization (multislider showing current partial levels)
- Active voice count display
- Spectrum analyzer (spectroscope~)
- Keyboard/note display showing active notes

## Technical Decisions

- poly~ for voice allocation (16 voices)
- gen~ codebox for efficient per-sample additive synthesis
- buffer~ (128 samples) as frequency lookup table shared across voices
- js object for .scl parsing (text parsing + ratio math)
- adsr~ for per-voice amplitude envelope
- All synth parameters sent to poly~ via "target 0" for global control

## Target

- MAX 9
- No external dependencies
