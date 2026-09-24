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
- **Pitch bend**: 14-bit via `midiin → xbendin`, range adjustable since v0.1.3 (see below).
- **Sync**: gen~ master phase drives `saw~`/`rect~` sync inlets. Hard sync resets VCO2 each VCO1 cycle; note sync resets both on retrigger.
- **Mod wheel** (v0.1.1, per Minitaur manual): `mt-mod-wheel` is initialised to 1.0 by `loadmess 1.` → `send mt-mod-wheel`, so VCO/VCF LFO AMOUNT act directly at load and the MOD WH dial/flonum show max. Once any wheel value arrives (CC1/33 or the MOD WH dial) it scales both depths.
- **LFO depth ranges**: VCO LFO ±1 octave (`*~ 1.` in `p oscillators`), VCF LFO ±5 octaves (`*~ 5.` in `p filter`).
- **Not yet built**: (glide-legato mode added v0.1.5, MIDI clock sync v0.1.6)

## Decisions (v0.1.2 trig mode + priority, 2026-09-24)

- **TRIG MODE** umenu (Legato ON / Legato OFF / EG Reset, default Legato ON via `loadmess 0`) replaces the LEGATO toggle in the same AMP EG slot; bus renamed `mt-cc-legato` → `mt-cc-trig-mode` (0/1/2). CC73 → `/ 43` (0-42/43-85/86-127). UI sync via `receive mt-cc-trig-mode → set $1`.
- Voice JS takes `trigmode N`: mode 0 = no retrigger on overlapping notes; modes 1/2 retrigger. The retrigger *shape* lives in the EG gen~s via `Param trig_mode`: 0/1 attack from the current level, 2 dumps to zero over ~3 ms first (the pre-v0.1.2 behaviour, now only in EG Reset). Fresh notes during release follow the same rule.
- **PRIORITY** default Last (`loadmess 2` → umenu; JS default `prio = 2`). CC91 → `/ 43` → `mt-cc-note-priority` (0 Low, 1 High, 2 Last); `receive mt-cc-note-priority → set $1` keeps the menu in sync.
- EG codebox local `e` renamed `ev` (GenExpr constant-name trap, see CLAUDE.md).

## Decisions (v0.1.3 bend range, 2026-09-24)

- **Separate up/down bend range** per the manual, default ±3 st. Buses `mt-cc-bend-up` / `mt-cc-bend-dn` carry the menu index 0-7 → 0 (OFF)/2/3/4/5/7/12/24 st.
- CC107 (up) / CC108 (down) → `/ 16` in `p midi-input` gives the manual's 16-wide quantised bands directly.
- `p oscillators`: `* 2.` replaced by `expr ($f1>0.)*$f1*$f2+($f1<0.)*$f1*$f3` (bend -1..1 → semitones). Range chain `receive → zl.lookup 0 2 3 4 5 7 12 24 → t b f` sets the cold inlet then bangs, so a range change applies to a held bend immediately.
- UI: BEND UP / BEND DN umenus beside PRIORITY (pres. x 512 / 580, y 307); keyboard panel widened to 836 px (right edge aligned with the filter panel). `loadmess 2` defaults, `receive → set $1` keeps menus synced with CCs.

## Decisions (v0.1.4 VCO2 beat, 2026-09-24)

- **BEAT** = ±50 cents on VCO2 only. Bus `mt-cc-vco2-beat` carries 0-1 like the other knobs (0.5 = centre, set by a 9th outlet on the loadbang `trigger`).
- `p oscillators`: `receive → $1 30 → line~ → -~ 0.5` is added via `+~` to the VCO2 semitone offset (`-~ 12.`) ahead of the `pow(2, x/12)` ratio gen~. So ±0.5 st = ±50 cents, and it sums with VCO2 FREQ.
- MIDI: CC18 (coarse) / CC50 (fine) in `p midi-input`, handled with the same `expr *128 → t i 0` / `t b i → + → scale 0 16383 0. 1.` pair as the other 14-bit CCs.
- UI: BEAT dial/flonum at pres. x 125 in the OSC panel. The OSC panel is 55 px wider (354), and every row-1 control right of VCO2 FREQ moved +55 px (row 1 now ends at x 904). New fan-outs go through `t f f`.

## Decisions (v0.1.5 legato glide + glide type menu, 2026-09-24)

- **LEGATO GLIDE** toggle in PERF (pres. 866,255 under GLIDE, label at 861,240), default off. Bus `mt-cc-legato-glide` (0/1); CC83 → `>= 64` (0-63 always glide, 64-127 glide only on overlapping notes). `receive → set $1` keeps the toggle synced.
- Voice JS has a 5th outlet: overlap flag (1 when the sounding note changed while another key was held, incl. falling back to a held note on release; 0 on fresh notes), sent before the note → `send mt-overlap`.
- `p glide` gen~ now has 6 inputs: in5 overlap (`receive mt-overlap → sig~`), in6 legato glide (`receive mt-cc-legato-glide → sig~`). On a target change with legato on and no overlap it sets `jump`, so `cur = target` instantly; otherwise glides as before. GLIDE on/off still gates everything.
- **GLD TYP** is now a umenu (LCR / LCT / EXP, index 0-2) in the old dial slot (pres. 956,209,50,20), `loadmess 0` default LCR. Dial, flonum and both scale objects removed. CC92 → `expr ($i1>42)+($i1>84)` (0-42/43-84/85-127).

## Decisions (v0.1.6 LFO MIDI clock sync, 2026-09-24)

- **Clock logic** lives in `generated/minitaur-clock.js` (inside `p lfo`). `rtin → select 248 250 252`: each 248 tick is timestamped by `cpuclock` in the scheduler before reaching js (js runs deferred), 250 → `start`, 252 → `stop` (no-op: sync follows the ticks, not the transport).
- **Rate** = 1000 / (tick ms × ticks per cycle). Tick period is averaged over the last 24 ticks (one quarter note). "Clock arriving" = a tick within the last 300 ms (js Task watchdog), so sync drops out, and the RATE knob takes over again, 300 ms after the clock stops.
- **Divisions** follow the manual's p.24 table, 21 steps from 4 WH (384 ticks) to 1/64 T (1 tick) at 24 ppqn. CC86 bands are 0-6/7-12/…/61-67/…/122-127, and the same band lookup maps the RATE knob (0-1 × 127) to a division. The knob changes the division only while synced; CC86 and the DIV menu set it at any time. Default division: 1/4.
- **Buses**: `mt-cc-lfo-sync` (0/1; CC87 `>= 64`; SYNC toggle, `loadmess 1` default ON), `mt-cc-lfo-div` (raw CC86 0-127), `mt-lfo-div-sel` (menu index → js), `mt-lfo-div` (js → menu `set $1` display).
- **LFO gen~** has 7 inputs now: in6 = synced Hz (0 = free, use in1), in7 = start toggle. A start edge resets the phase like key trigger does. It only flips while SYNC is on.
- Drift: the rate is derived, not phase-locked. Phase realigns only on Start.
- **UI**: the LFO panel is 45 px wider (360). SYNC label/toggle are at pres. 837/842 (the column after VCO2 O), and DIV label + 21-item umenu sit at pres. 757/785, y 251. The PERF panel and its contents moved +45 px (901…1054).
