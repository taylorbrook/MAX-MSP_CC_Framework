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

## Decisions (v1.1.0 review fixes, 2026-09-24)
- EQ band menus: umenu index -> `+ 1` -> `setfilter <0-based band>, mode $1` (filtergraph~ type messages only hit the *selected* filter). Stored curve reset to flat: lowshelf 100 / peak 400, 1k, 3k / highshelf 8k, all 0 dB.
- pattrstorage `comp-state` owns EQ + compressor state; the default-setting loadbangs in input-processing and comp-band.maxpat were removed. If comp-state.json is missing, menus/dials show their zero positions until restored.
- Mixer faders init via `p fader-init` (loadbang): channels 128 (0 dB), master 118 (~ -6 dB headroom, no limiter yet).
- Stereo: soundfile players sum per-side to `sfplay-ret-L`/`-R`; dry + fx returns stay mono and feed both sides. FILES and MASTER are slaved stereo `gain~` pairs (L outlet 1 -> R inlet 0).
- **Presentation exclusions:** the slaved R `gain~` for FILES and MASTER are deliberately NOT in presentation (the L fader drives both); both stereo meters are shown.
- Cues: state is an `int` pair + `clip 0 <last>`; `trigger i i i i` stores current, sends `cue-number`, then fires coll. NEXT (button, note 64, sustain CC 64 via `> 63 -> change`), PREV, RESET (cue 0), goto via CUE number box (`send goto-cue`; display uses `prepend set` to avoid feedback). Last cue = coll `length - 1` after read, so cue numbers must be contiguous from 0. Cue 0 is the reset state, applied at startup.
- v1.1.1: gen~ files use the `History one(1)` de-hoist pattern (srs, k_* copies); no `sr` alias, no reassignment of built-ins `pi`/`sqrt2`. Math unchanged.
- v1.2.0: crossover low band gets 1k+5k allpass, lo-mid gets 5k allpass (LR4 LP+HP == 2nd-order allpass) -> 4-band sum is flat (numpy: was -0.47 dB dip at ~260 Hz, now <0.01 dB).
- v1.2.0: `limi~ 2 @threshold -1.` between master faders and dac~; meters are post-fader, pre-limiter.
- v1.2.0: delay time -> `$1 200` -> line~ -> tapout~ signal inlet (interpolating). Time changes glide (tape-style pitch bend over 200 ms) instead of clicking.
- v1.2.0: soundfiles are preloaded at startup: cue-system sends `cues-loaded <count>` after reading; each player preloads `preload <cue+2> <file>` for every cue, then plays int (cue+2) when a cue names a file. Editing cue-data.txt requires reopening the patch to re-preload.
