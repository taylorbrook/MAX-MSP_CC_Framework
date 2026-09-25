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
- Note range: MIDI 0-72 (C-1 to C5); notes above 72 fold into the top octave (fw 2.1, since v0.1.7)
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

## Decisions (v0.1.7 manual ranges + defaults, 2026-09-24)

- **EG attack / decay-release**: 1 ms–30 s exponential (`pow(30000, x)` in both EG codeboxes; was 10 s).
- **EXT LVL** 0–200%: bus stays 0–1, `* 2.` in `p mixer` ahead of the `$1 30 → line~` ramp. Default 64/127 (0.503937) ≈ unity.
- **KB TRK** 0–200%: filter gen~ uses `kb = clamp(in5, 0, 1) * 2`. Now 14-bit, CC20 coarse / CC52 fine (the same `expr *128 → t i 0` / `t b i → + → scale 0 16383 0. 1.` pair as the other 14-bit CCs; chain moved to y 1050 in `p midi-input`). Default 32/127 (0.251969) ≈ 50%.
- **FLT VEL / AMP VEL** default 0.5.
- **Init**: the loadbang `trigger` has 13 outlets. Outlets 9–12 send the four defaults above. Dials and flonums pick them up through the existing `receive → scale → set $1` UI-sync chains.
- **Note fold** (voice JS `fold()`): n > 72 → `61 + (n - 61) % 12`, so pitch class is kept (84 → 72, 73 → 61).

## Decisions (v0.1.8 polish, 2026-09-24)

- **Wave switch declick**: both `selector~ 2` (+ `+ 1` offset, + the `loadbang → 1` init) in `p oscillators` are replaced by `p wave-xfade` (inlets wave / saw / rect, same order as the old selector~ inlets 0/1/2). Inside: `$1 10 → line~` gives a 10 ms linear crossfade, `!-~ 1.` for the saw gain, `*~` pair and `+~`. line~ starts at 0 = saw, matching the old default.
- **DSP toggle**: presentation 1034,32 (18 px), "DSP" label at 1002,32, on the nav-button row. `toggle → adstatus switch`, whose right outlet → `set $1` → toggle keeps it in sync with DSP changes made elsewhere, with no feedback loop. The DSP toggle is deliberately NOT parameter-enabled, so audio never auto-starts on load.
- **Parameter saving**: all 41 dials/toggles/umenus have `parameter_enable 1`, `varname` = longname, and `parameter_initial` + `parameter_initial_enable 1`. Initial values equal the old load defaults: cutoff 89, volume 89, VCO levels 102, sustains/velocity 64, ext 64, KB TRK 32, mod wheel 127, LFO SYNC 1, PRIORITY 2, BEND 2/2, DIV 10 (1/4), everything else 0. The old defaults came from line~/sig~ starting at 0, so the sound at load is unchanged. VCO2 FREQ stays at 0 = -12 st, as before.
- The centre-detented dials (FINE TUNE, BEAT, EG AMT) use `floatoutput 1` with an initial value of 63.5, so they load exactly at centre (0.5).
- The parameter system now seeds every bus at load. The 13-outlet loadbang `trigger` (with its messages and sends) and all loadmess objects (PRIORITY, TRIG MODE, BEND UP/DN, GLD TYP, SYNC, `loadmess 1.` mod wheel) were removed so that only one source sets the load values. This also fixes PRIORITY, which had two conflicting loadmess objects (0 and 2).
- Initial values are the load state. To make the current knob positions the new load state, use the Parameters window's initial-value column (or add autopattr/pattrstorage later).

## Decisions (v0.1.9 review fixes, 2026-09-24)

- **Retrigger is a counter**: `mt-trig` (voice js) and the clock phase reset (clock js) now step 0..1023 instead of flipping 0/1. With a toggle, two retriggers inside one audio vector cancelled out and the note played silent. The gen~ edge test `abs(x - prev) > 0.5` is unchanged; the 1023→0 wrap still counts as an edge.
- **EG release on gate level**: the EG releases whenever gate < 0.5 in attack/decay, not only on a falling edge. So a note-on + note-off inside one vector releases instead of sticking at sustain. A zero-length note is now silent, which beats a stuck one.
- **Velocity latched into the EG peak**: each EG gen~ has a 7th input (`expr` → `sig~`), latched on retrigger. Attack rises to the peak, and decay heads for sustain × peak. The old `$1 5 → line~ → *~` output scaling is gone, so there's no velocity blip and no level jump on a soft retrigger in Legato OFF. Legato notes keep the held velocity, and VEL knob changes apply from the next note. The EG decay also snaps to its target to avoid denormals.
- **VCO1 sync**: `out1 = note_sync` only. Resetting saw~/rect~ on VCO1's own wrap every cycle snapped its period to whole samples and made the pitch jitter.
- **LFO wave bands**: `expr $i1 * 6 / 128` (six ~21-wide bands) replaces `scale 0 127 0 5`, for both CC85 and the WAVE dial. `scale` with int args truncated, so Filter EG was only reachable at 127.
- **Centre detents**: FINE TUNE / EG AMT / BEAT use `scale 0. 127. 0. 1.`, because an int-range scale truncated 63.5 to 63. Those dials have `parameter_type 0` (float).
- **Mixer saturation**: `*~ 0.5 → tanh~ → *~ 2.` = 2·tanh(x/2). It's close to linear at normal levels and only overdrives when hot. Two VCOs at the default 0.8 now peak ~1.33 into the filter (was 0.92 through a plain tanh~), about 3 dB louder.
- **Glide**: `History armed`. The first target change after load jumps, so the first note no longer glides up from MIDI 0.
- **Output**: a soft-knee gen~ (linear to 0.8, tanh into a 1.0 ceiling) sits before `clip~`, which stays as a backstop, so resonant peaks round off instead of hard-clipping.
- **Clock start** keeps its tick history, so the synced rate no longer drops to the free rate for one tick after Start.

## Decisions (v0.1.10 UI cleanup, 2026-09-24)

- **Readouts**: all 25 flonums are display-only (`ignoreclick 1`), 45×22, default font, 2 decimals (WAVE uses 0).
- **Labels**: dial and toggle labels are all fontsize 9, 17 px tall. Label boxes are trimmed to their text, so no two presentation rects overlap.
- **Toggle rows** use a 45 px pitch with the toggle top = dial top + 10 and the label 23 px above it. OSC row: toggles x 187/232/277/322 at y 104, labels at y 81. LFO row: toggles x 762/807/852 at y 219, labels at y 196. "VCO2 O" was renamed "V2 ONLY".
- **LEGATO** (glide) label and toggle moved under GLD TYP: label [1001,233], toggle [1016,251].
- **Right edge**: the DSP toggle and label end flush at 1054, and the keyboard panel is 1044 wide, so every row ends at 1054. Window `rect` is [34,208,1064,460] (check the height once in MAX; it assumes ~70 px of toolbars).
- The OUTPUT header replaces "VOL", so it doesn't repeat the VOLUME dial label.
- Parameters "Release" → "Release Switch" and "Glide" → "Glide On" (longname, shortname and varname).
- The stale "INIT" / "init ->" patching comments were renamed UI SYNC, and the dead `receive mt-cc-cutoff` (obj-45) was removed.

## Decisions (v0.1.11 subpatcher layout, 2026-09-24)

- All functional subpatchers were relaid out: midi-input, oscillators (+ both wave-xfade), mixer, glide, envelopes, lfo, filter, vca-output. `p about` (text only), the gen~ internals and the top-level patching view are untouched.
- **Method**: each connected chain uses a layered top-down layout. Each source sits directly above its consumer, node order is chosen to minimise crossings, and a compaction pass closes empty vertical strips. Cables are routed at right angles, with each horizontal run in its own channel between rows. `newobj`/message boxes are sized to their text.
- **midi-input**: chains are packed into rows ≤ 1400 px wide in their original reading order. Each `---` section header starts a new row. Comments that name a CC sit next to that `ctlin`.
- Other comments sit beside the object they described, in the nearest spot clear of boxes and cables. Inlet/outlet x-order is unchanged (asserted), so parent connections map the same.
- Result: 0 overlaps and 0 upward cables in every subpatcher. Widths: envelopes ~1900, lfo ~1830, oscillators ~1560 (14 parallel input chains into the gen~s); everything else is < 1000.
- The critic's remaining 106 overlap and 122 missing-midpoint warnings are all in the top-level patching view (UI-sync area), which this pass left alone.
