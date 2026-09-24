# minitaur

Digital recreation of the Moog Minitaur bass synthesizer in MAX/MSP.

## Source

Based on the Moog Minitaur hardware synthesizer -- a monophonic analog bass synth descended from the Taurus line.

## Architecture

### Signal Flow

```
VCO 1 (Saw/Square) --+
                      +--> MIXER --> FILTER (24dB Moog Ladder LP) --> VCA --> VOLUME --> OUTPUT
VCO 2 (Saw/Square) --+                    ^                          ^
                      |                    |                          |
External Audio In ----+               Filter EG                   VCA EG
                                          ^                          ^
Pitch CV --> VCO Pitch                    |                          |
Gate --> Triggers both EGs           LFO -+                     LFO (via routing)
LFO --> VCO Pitch & VCF Cutoff
```

### Oscillator Section (2x VCO)
- Waveforms: Sawtooth or Square per oscillator (switchable, not simultaneous)
- Note range: MIDI 0-72 (C-1 to C5), clamped -- bass synth by design
- Fine tune: +/-1 semitone (both VCOs)
- VCO 2 frequency offset: -12 to +12 semitones
- VCO 2 beat frequency: fine Hz offset for chorus/beating effects
- Hard sync: VCO1 resets VCO2 phase
- Note sync: oscillator phase resets on Note On

### Mixer Section
- 3 channels: VCO 1 level, VCO 2 level, External audio input level
- Subtle overdrive/saturation at high mixer levels

### Filter Section (Moog Ladder)
- Classic 4-pole (24 dB/octave) low-pass ladder filter
- Cutoff: 20 Hz to 20 kHz
- Resonance: 0 to self-oscillation (sine-like tone at high resonance with no input)
- Envelope amount: bipolar (positive and negative modulation from filter EG)
- Keyboard tracking: 0-100%
- Velocity sensitivity

### Envelope Generators (2x ADSR, shared Decay/Release)
- Filter EG: hardwired to filter cutoff modulation
- VCA EG: hardwired to amplitude
- Parameters per EG: Attack, Decay, Sustain (with shared Decay/Release knob)
- Release toggle: on/off switch -- when on, Release = Decay time; when off, instant cut
- Trigger modes: Reset (retrigger from zero) or Legato (no retrigger on overlapping notes)

### LFO Section
- 6 waveforms: Triangle, Square, Sawtooth, Ramp, Sample & Hold, Filter EG (as mod source)
- Rate: 0.01 Hz to 100 Hz
- Destinations: VCO pitch amount, VCF cutoff amount
- VCO 2 only mode: route LFO to VCO2 only
- Key trigger: reset LFO phase on Note On
- MIDI sync with clock divisions

### Performance Controls
- Glide (portamento): on/off with rate control
- Glide types: Linear Constant Rate, Linear Constant Time, Exponential
- Glide legato mode: glide only on overlapping notes
- Pitch bend: asymmetric up/down ranges, 0-24 semitones each
- Mod wheel: controls LFO depth
- Note priority: Low, High, or Last note

### Key Implementation Notes
- Monophonic: single voice with note priority
- Oscillators always running -- VCA EG opens/closes sound
- Moog Ladder filter is the defining character (Huovilainen or Stilson-Smith algorithm in gen~)
- Self-oscillation must produce sine-like tone
- Beat frequency = Hz detuning for classic analog chorus
- External audio input gets full filter/VCA treatment

## Front Panel Controls (16 knobs + 2 buttons)

### Oscillator
1. FINE TUNE knob (+/-1 semitone)
2. VCO 2 FREQ knob (-12 to +12 semitones)

### Mixer
3. VCO 1 LEVEL knob
4. VCO 2 LEVEL knob

### Filter
5. CUTOFF knob
6. RESONANCE knob
7. EG AMOUNT knob

### Filter Envelope
8. ATTACK knob
9. DECAY knob
10. SUSTAIN knob

### Amp Envelope
11. ATTACK knob
12. DECAY knob
13. SUSTAIN knob
14. RELEASE button (on/off)

### Modulation
15. LFO RATE knob
16. VCO LFO AMOUNT knob
17. VCF LFO AMOUNT knob

### Performance
18. GLIDE button (on/off)
19. GLIDE RATE knob

### Output
20. VOLUME knob

## Implementation Decisions

1. **Filter DSP**: gen~ codebox with Huovilainen Moog ladder algorithm (proper self-oscillation, resonance compensation)
2. **UI**: Full presentation-mode replication of the Minitaur front panel (16 knobs + 2 buttons + waveform selectors)
3. **External audio**: Include external audio input path through mixer into filter/VCA chain
4. **MIDI CC**: Full CC map -- all 14-bit parameter pairs, all 7-bit switches, note priority, velocity routing

## Decisions (v0.1.0 review fixes, 2026-09-24)

- **Voice logic** lives in `generated/minitaur-voice.js` (inside `p midi-input`): held-note stack, Low/High/Last priority (umenu PRIORITY, default Low), legato = no envelope retrigger on overlapping notes. Broadcasts `mt-note` (0-72), `mt-vel`, `mt-gate`, `mt-trig` (0/1 toggle that flips on every retrigger). CC 123 clears the stack.
- **Retrigger** is edge-detected from `mt-trig` inside gen~ (envelopes, LFO key trigger, note sync), never from the gate level. Gate and trig reach gen~ via `sig~`, not `line~`.
- **Envelopes**: attack/decay knobs map exponentially 1 ms–10 s. Reset mode dumps to 0 over ~3 ms before re-attacking. Release OFF = 5 ms tail (no instant cut).
- **Velocity**: scales the EG output, `1 - sens + sens * vel/127`, separately for filter EG and amp EG.
- **Filter**: TPT/ZDF 4-pole ladder with tanh on the feedback sum, k = res × 4.4 (self-oscillation from res ≈ 0.93, in tune from 220 Hz to 20 kHz in the numpy pre-flight), output gain compensation `1 + 0.5k`. Keyboard tracking references C3 (130.81 Hz), measured from the glide output.
- **Glide** runs in semitones. Rate knob 2 ms–4 s, exponential. Type 0 = constant rate (knob time per octave), 1 = constant time, 2 = exponential.
- **Pitch bend**: 14-bit via `midiin → xbendin`, fixed ±2 semitones (range not exposed yet).
- **Sync**: gen~ master phase drives `saw~`/`rect~` sync inlets. Hard sync resets VCO2 each VCO1 cycle; note sync resets both on retrigger.
- **Mod wheel** (v0.1.1, per Minitaur manual): `mt-mod-wheel` is initialised to 1.0 by `loadmess 1.` → `send mt-mod-wheel`, so VCO/VCF LFO AMOUNT act directly at load and the MOD WH dial/flonum show max. Once any wheel value arrives (CC1/33 or the MOD WH dial) it scales both depths.
- **LFO depth ranges**: VCO LFO ±1 octave (`*~ 1.` in `p oscillators`), VCF LFO ±5 octaves (`*~ 5.` in `p filter`).
- **Not yet built**: VCO2 beat-frequency control, glide-legato mode, MIDI clock sync for the LFO, adjustable bend range.
