# ji-harmonizer — Context

## Origin

Port of the user's VST **O-IntonationPad** (v2.8.4) at
`/Users/taylorbrook/Dev/VST-development-octagon/plugins/O-IntonationPad`.
A wavetable pad synth where one MIDI note triggers a full chord (up to 12 sub-voices),
every pitch tuned by a microtonal engine (built-in temperaments, Scala .scl/.kbm,
scale generators). Complex system — build a part first, then grow.

## Source-plugin functional summary (from code exploration, 2026-08-13)

### Tuning engine (`Source/DSP/TuningEngine.{h,cpp}`)
- Data model: scale = vector of cents `[0, i1, …, period]` (period usually 1200;
  non-octave scales supported: BP 1902, Carlos α/β/γ).
- Ratios in .scl converted to cents on parse: `1200*log2(num/den)`.
- Built-in temperaments (cents from C): 12-TET, Pythagorean, Zarlino, Meantone 1/4,
  Werckmeister III, Kirnberger III, Vallotti, Well Tempered, Just Intonation
  `{0, 111.73, 203.91, 315.64, 386.31, 498.04, 582.51, 701.96, 813.69, 884.36, 996.09, 1088.27}`,
  Bohlen-Pierce.
- 24 embedded library tunings (historical, JI incl. Partch 43, EDOs 17-53, non-octave, world).
- Scale generators: EDO(divisions, period); harmonic series (octave-reduced);
  rank-2 (spiral-of-fifths generator stacking).
- Frequency computation: precomputed 128-entry table, 3 paths:
  1. **12-note scale, no KBM (signature sound):**
     `freq = 12TET(note, A4, stretch) * 2^(scaleIntervals[(pc - tonic) mod 12]/1200)`
     — deliberately NOT textbook JI: absolute interval cents applied ON TOP of the
     note's 12-TET freq (intervals nearly doubled). Documented intentional character
     (TuningEngine.cpp:729-731). **Port verbatim.**
  2. Non-12 scales: linear degree mapping anchored at MIDI 60 + tonic.
  3. KBM: full Scala keyboard mapping.
- Tonic = modal rotation of interval list + pitch-class shift.
- Params: masterTune (A4 400-480), octaveStretch (0.95-1.25), temperament preset.

### Chord generator (`Source/DSP/ChordGenerator.cpp`)
- Played note → nearest *enabled* scale degree; per-degree enable toggles.
- Voicing modes: Free / Close / Open / Drop-2 / Thirds / Quartal / Quintal
  (stacked `round(scaleDegreeCount*k/12)` degrees, k=4/5/7).
- voiceCount 2-12 (def 5); complexity 0-1 gates voices (voice i audible when
  `complexity >= i/total*0.85`, 0.1-wide crossfade).
- spacing (prob. copy 1-3 octaves up), inversion (down), timingRandom (0-100ms stagger),
  detuneRandom (0-50 cents), stereoSpread (alternating L/R constant-power pan,
  width ∝ index, root centered).

### Synthesis
- Dual morphing wavetable oscillators: 20 banks, 256 frames x 2048 samples,
  banks defined as additive partial recipes {ratio, fadeInStart/End, maxAmp, phase};
  frame 0 ≈ sine → frame 255 full character; 11 mipmap levels for anti-aliasing.
  Bank 0 "JI Harmonic" uses pure JI partial ratios.
- ADSR, StateVariableTPT LP filter (LFO + velocity mod), 2 LFOs → wavetable position
  (per-sub-voice random phase offsets, root tracks global phase).
- 8-voice poly (each key = one chord of up to 12 sub-voices x 2 oscs).
- FX chain: Chorus → Delay (ping-pong, LP feedback) → 3-band EQ → Reverb (predelay).
- No pitch bend / MPE implemented in the VST. VST3 Note Expression tuning exists
  (irrelevant for MAX port; equivalent = per-note cents-offset inlet).
- 12 factory presets; ~48 automatable params.

### Suggested build order (from exploration)
1. TuningEngine → 128-entry frequency table (pure control math, standalone testable)
2. ChordGenerator (note in → list of notes/gains out) — 1+2 = the plugin's identity
3. Wavetable oscillator bank (build-time Python → buffer data; gen~/wave~ morph)
4. Voice/sub-voice engine (poly~/mc., ADSR, pan, filter)
5. FX chain + presets (pattrstorage) + tuning UI (.scl import via JS)

## Kickoff decisions (2026-08-13)

- **First slice: tuning + chord engine.** MIDI note in → JI-tuned chord out, driving a
  simple placeholder oscillator bank (cycle~/saw). Wavetable engine ported later.
- **Tuning math: verbatim VST port.** Reproduce the signature non-standard 12-note path
  (interval cents applied on top of each note's 12-TET frequency) exactly.
- **Tuning scope: 23-limit JI via editable ratio table.** 12-degree table where each
  degree is a typed JI ratio (up to 23-limit, e.g. 23/16, 19/16, 13/8), converted to
  cents internally (`1200*log2(n/d)`) like the VST's .scl parser. Ships with a sensible
  default scale. The VST's fixed temperament presets are deferred.
- **Input/poly: mono chord, live MIDI.** notein + on-screen kslider; one held key at a
  time triggers its chord. poly~ 8-key polyphony deferred.

## Decisions (discuss, 2026-08-13)

- **Engine: js object (V8).** One js file holds TuningEngine + ChordGenerator as a direct
  port of the C++ logic — easy to verify against the VST source and to grow (.scl import
  later). Native objects handle only MIDI I/O and audio.
- **Chord scope: core set.** voiceCount (2–12, def 5), complexity gating (voice i audible
  when complexity >= i/total*0.85), all 7 voicing modes (Free/Close/Open/Drop-2/Thirds/
  Quartal/Quintal), key root/tonic. Deferred: spacing/inversion randomization,
  timingRandom, detuneRandom, stereoSpread.
- **Audio arch: mc.cycle~ bank.** 12-channel mc.cycle~ fed per-channel freqs + gains,
  mixed to stereo. Sine placeholder timbre; wavetable engine later.
- **Ratio UI: per-degree fields.** 12 individual entry boxes, one per degree, each with
  its computed cents readout beside it. Default scale: harmonics 16–30
  (1/1 17/16 9/8 19/16 5/4 21/16 11/8 23/16 3/2 13/8 7/4 15/8 — spans 23-limit).
- **Rationale for verbatim tuning path:** freq = 12TET(note) * 2^(cents[(pc-tonic)%12]/1200)
  — the VST's documented signature; do not "fix" to textbook JI.

## Decisions (discuss, slice 2 — wavetable engine, 2026-08-13)

- **Dual oscillators, verbatim structure.** Osc A + osc B per sub-voice, matching the VST:
  both share the sub-voice frequency (no inter-osc detune in the VST — detuneRandom is a
  chord-level param, already deferred). Each osc has its own wavetable position and gain
  (VST gainA/gainB, block-smoothed). Both implemented inside ONE gen~ codebox
  (two phase accumulators, two bilinear reads, out = oscA*gainA + oscB*gainB).
- **Position control: dial + one LFO.** Per-osc position dial (0-1, default 0.5) plus a
  single global LFO (rate/depth) modulating both positions around their dials
  (`clamp(dial + sin(lfo)*depth, 0, 1)` — VST formula). The VST's second LFO and
  per-sub-voice LFO phase offsets are deferred to a later slice.
- **Banks: render bank 0 only; tool supports all 20.** Both oscs play JI Harmonic this
  slice; per-osc bank umenu arrives when more banks are rendered.
- **Rendered WAV committed to git** (~23 MB float32). Patch works on clone with no build
  step; the Python tool remains the source of truth for regeneration.
- **Buffer layout: one mono buffer~ per bank**, mipmaps concatenated:
  `index = mip*(256*2048) + frame*2048 + sample` (5,767,168 samples). Mipmap level
  computed per channel in gen~ as `clamp(floor(log2(max(freq,1)/20)), 0, 10)` —
  equivalent to the VST's getMipmapLevel table walk. Hard mipmap switch (no crossfade),
  verbatim VST behavior.
- **Verbatim render math** (WavetableData.h): partial excluded from a level when
  `mipmapBaseFreqs[level]*2 * ratio > 0.9 * 24000`; sin^2 fade by frame position;
  per-sample normalization `1/max(totalAmp, 1)`; phaseOffset per partial.
- **Free-running phases** (VST resets per noteOn; mono-chord slice free-runs — inaudible
  for pads, revisit with poly~).

## Next slice (chosen 2026-08-13, after v0.1.2)

**Stereo spread + chord feel** — port stereoSpread (alternating constant-power L/R pan,
width ∝ voice index, root centered), detuneRandom (0-50 cents), timingRandom (0-100ms
stagger) from ChordGenerator. Requires going stereo: current chain is mono
(mc.mixdown~ 1). Pending: load test of v0.1.2 in MAX (first mc.gen~ + 23MB buffer~ use).
After this: more banks + selectors, filter + modulation, then poly~.

## Research (2026-08-13)

All objects below verified in the DB with non-empty I/O.

### Signal flow (slice 1)

```
notein ─→ stripnote ─→ kslider (display + touch input) ─┐
                                                         ▼
                    js ji-engine.js  (TuningEngine + ChordGenerator port)
                    in: note/vel, ratio <i> <n/d>, voicecount, complexity,
                        voicingmode, tonic, mastertune
   out 0: 12-elem freq list ──→ mc.sig~ @chans 12 ──→ mc.cycle~ (left, signal)
   out 1: 12-elem gain list ──→ mc.sig~ @chans 12 ──→ mc.rampsmooth~ (~50ms)
                                                        └→ mc.*~ (right inlet)
   out 2: gate (norm. velocity or 0) ──→ adsr~ ──→ *~ (post-mixdown env)
   out 3: cents per degree ──→ route 0..11 ──→ 12 flonum readouts
mc.cycle~ → mc.*~ → mc.mixdown~ 2 → *~ (env) → gain~ ⇄ meter~ → ezdac~
```

### Object choices & rationale

- **js** (1 in, N out via `outlets=4`): whole engine in one file. Handlers: `list` for
  note/vel, `anything` for named params (`ratio`, `voicecount`, `complexity`,
  `voicingmode`, `tonic`, `mastertune`). Direct C++ port, testable in Max console.
- **mc.sig~ @chans 12**: accepts a plain 12-element `list` → sets per-channel constant
  signal values. Cleanest verified way to feed per-channel freqs/gains (avoids relying
  on mc wrapper `setvalue`, unverified in DB).
- **mc.cycle~** (2 in: freq signal/float, phase; 1 out): 12-ch sine bank; freq from
  mc.sig~ signal into left inlet. Placeholder timbre until wavetable port.
- **mc.rampsmooth~** (3 in, 1 out; args ramp-up/down samples): smooths per-channel gain
  steps from complexity/voicecount changes — no clicks while dragging (~2205 samp = 50ms).
- **mc.*~**: applies smoothed gain lane to oscillator lane.
- **mc.mixdown~ 2** (2 in, 1 out): 12ch → stereo.
- **adsr~** (5 in, 4 out; args A D S R): master mono envelope, gated by js out 2
  (normalized velocity 0-1 → satisfies gain-safety rule; 0 = release).
- **textedit ×12**: per-degree ratio entry; outlet 0 emits text on enter →
  `prepend ratio <i>` → js. flonum cents readout beside each (from js out 3 via route).
- **umenu**: voicing mode (Free/Close/Open/Drop-2/Thirds/Quartal/Quintal) — remember
  comma-as-element items format. **tab** is an alternative if a segmented control reads
  better; umenu is more compact.
- **kslider**: outlet 0 = pitch, outlet 1 = velocity; also accepts int display input
  (existing touchscreen-kslider convention from simple-fm applies).
- **gain~ + meter~** side-by-side (companion pair), ezdac~ termination.

### Notes / tradeoffs

- Freq changes via mc.sig~ are unsmoothed (instant pitch step). Correct for note
  retriggers; if later we want glide, insert mc.slide~ or drive freqs through mc.line~.
- Silent channels: js sets gain 0 for unused sub-voices; oscillators keep running
  (12 fixed channels — fine at sine cost; revisit with poly~/mute in the full engine).
- adsr~ retrigger while held is legato-safe for mono chord slice; full VST ADSR params
  (A 1ms-5s etc.) can map 1:1 onto adsr~ inlets later.
- pattrstorage/preset available for slice-2 preset support; not in slice 1.
- No PD-blocklist conflicts in this plan.

## Research (slice 2 — wavetable engine, 2026-08-13)

All objects verified in DB with non-empty I/O: `mc.gen~` (MC), `buffer~`, `cycle~`, `*~`,
`+~`, `line~`, `clip~` (MSP), `dial`/`flonum`/`loadbang`/`message` (Max). Gen operators
verified in gen domain: `peek`, `wrap`, `log2`, `floor`, `clamp`, `history`. numpy 2.4.0
available for the render tool.

### Render tool (build-time Python — sanctioned, not a Rule #5 violation)

- `tools/render_wavetables.py`: ports all 20 partial-recipe tables from WavetableData.h
  verbatim; renders selected banks (default: bank 0) to float32 mono WAV.
- Verbatim math: sin^2 fade (`calculateFade`), partial exclusion per mipmap
  (`baseFreq*2*ratio > 0.9*24000`, ASSUMED_SAMPLE_RATE 48000), per-sample normalization
  `1/max(totalAmp,1)`, per-partial phaseOffset.
- Output layout: 11 mipmaps concatenated, `idx = mip*524288 + frame*2048 + sample`
  (5,767,168 samples ≈ 23 MB). File: `generated/bank00-ji-harmonic.wav` — next to the
  .maxpat so Max's patch-folder search path finds it.
- Sanity checks in tool: frame 0 of every mipmap ≈ pure sine (only ratio-1.0 partial has
  fadeStart>=fadeEnd); top mipmaps go silent as even the fundamental exceeds 0.9*Nyquist
  (VST does the same).

### Audio architecture

- ONE `mc.gen~` codebox replaces `mc.cycle~`: 3 signal inlets (freq from existing
  mc.sig~; posA; posB — mono signals broadcast to all 12 instances), 1 outlet.
- Single shared phase accumulator (History + wrap) — valid because VST osc A/B share
  baseFreq and both reset phase to 0 per note (phases always identical).
- Per sample: mipmap level `clamp(floor(log2(max(f,1)/20)), 0, 10)` (equals VST's
  getMipmapLevel), 8 peeks (2 oscs × 2 frames × 2 samples), bilinear interp,
  `out1 = oscA*gaina + oscB*gainb`.
- `gaina`/`gainb` as Params (0-1) with one-pole smoothing in codebox (≈20 ms, mirrors
  VST block-rate gain smoothing); set via `gaina $1` message boxes into mc.gen~ inlet 0
  (bare param messages broadcast to all mc instances — uniform, which is what we want).
- Position path: flonum (0-1) → `$1 20` → line~ → +~ (LFO) → mc.gen~ (clamped in gen).
  LFO: `cycle~` (rate flonum) → `*~` (depth flonum) → shared by both `+~` position sums.
- `add_gen()` builds gen~ + codebox; parent box renamed to `mc.gen~` afterwards
  (embedded-patcher JSON identical; mc wrapper auto-adapts to 12-ch input). Risk noted:
  first mc.gen~ use in this repo — verify at load in test protocol.
- buffer~ created as `buffer~ jiharm0 bank00-ji-harmonic.wav` (auto-loads from patch
  folder at open).

## Research (slice 4 — wavetable banks + per-osc selectors, 2026-08-13)

All objects verified in DB with non-empty I/O: `umenu` (1 in / 3 out; outlet 1 = "Menu
Item Text Evaluated as a Message"), `buffer~` (`replace` message verified), `prepend`.

- **Banks rendered: all 20** via `tools/render_wavetables.py --all` → `generated/
  bankNN-name.wav`, 23.1 MB each (~461 MB total). Committed per the slice-2 decision
  (patch works on clone, no build step). Flag: pushes to origin get heavy; each file is
  well under GitHub's 100 MB per-file limit.
- **Per-osc buffers, switch by `replace`** (recommended over 20 resident buffers +
  gen~ if/else chains): rename `buffer~ jiharm0` → `buffer~ jiharmA`, add
  `buffer~ jiharmB`, both arg-loading `bank00-ji-harmonic.wav` so the default sound
  is unchanged. Codebox splits `Buffer wt("jiharm0")` into `wta("jiharmA")` /
  `wtb("jiharmB")`; osc A peeks wta, osc B peeks wtb (8 peeks unchanged in count).
  Resident memory 2 × 23 MB; mc.gen~ instances share the global buffer namespace.
- **Selector chain per osc:** `umenu` (items = the 20 WAV filenames, comma-as-element
  JSON format; default index 0 = bank00 matches initial buffer contents, so no
  loadbang init needed) → outlet 1 (item text) → `prepend replace` → buffer~ inlet 0.
  `replace` resolves the filename via the patch-folder search path, same as the
  creation-arg load. All files are identical length → no buffer resize; peek during
  the async load reads 0 briefly (acceptable for pad material, matches VST bank-load
  behavior).
- Filenames double as menu labels (self-descriptive `bankNN-name`), avoiding a
  name→file mapping object that could drift.

## Decisions (slice 5 — filter + modulation, 2026-08-14)

From PluginProcessor.cpp exploration (verbatim semantics):

- **Master-bus filter, NOT per-voice**: one stereo StateVariableTPT lowpass applied
  after the synth render, before the FX chain. VST fixes resonance at 0.707
  (Butterworth) with no res param.
- **filterCutoff** 20–20000 Hz (log skew 0.25, default 8000), 20 ms smoothing.
- **filterLfoDepth** (0–1, def 0): `cutoff * 2^(sin(lfoPhaseA) · depth · 2)`,
  clamped 20–20k. VST advances in 32-sample sub-blocks; the port computes
  per-sample in gen~ (strictly better resolution, same formula).
- **velocityToFilter** (0–1, def 0): `cutoff *= 1 − v2f·(1 − lastNoteOnVelocity)`
  using the most recent note-on velocity (held through release).
- **LFO split**: VST runs independent LFOs — A → pos A + filter phase source,
  B → pos B (rate 0.01–20 Hz def 0.5, depth 0–1 def 0). The patch's shared LFO
  becomes LFO A; LFO B added in wtctl for pos B.

Port decisions (user-confirmed):

- **gen~ TPT codebox** (JUCE StateVariableTPTFilter math ported verbatim), stereo,
  3 signal ins (L, R, lfoA), 2 outs. Placed post-envelope via send~/receive~
  pairs (jhFinL/R into the filter, jhFoutL/R back to the *~ 0.1 stages).
- **Resonance exposed as a param** (0.5–10, default 0.707) — DELIBERATE DEVIATION
  from the VST's fixed Butterworth, chosen for sound-design range.
- Velocity source: js gate outlet (normalized vel or 0) through `split 0.0001 1.`
  so note-offs don't zero the filter velocity (matches VST lastNoteVelocity hold).

## Presentation-mode exclusions (deliberate, per Rule #9)

- `gain~` obj-122 (R channel): slaved to the master L fader (L outlet 1 → R inlet 0,
  single-master stereo pair) — patching-side only; the master gain~ + both meters are
  in presentation.

## Research (chord feel completion — spacing/inversion + LFO phase offsets, 2026-08-14)

Verbatim VST semantics (WavetableVoice.cpp startNote/render/setWavetablePositionWithLFO):

- **spacing** (0-1, def 0.0) / **inversion** (0-1, def 0.3): per sub-voice at noteOn,
  roll `getRandomOctaveShift()` — 60% → 1 oct, 30% → 2, 10% → 3 — independently for
  spacing (UP: note+12·oct, clamp 127) and inversion (DOWN: note−12·oct, clamp 0).
  Both reuse the sub-voice's detune centOffset (cancels in any freq ratio). Each
  sub-voice runs THREE osc groups (base/spacing/inversion, each dual-osc A+B).
  Per-voice random thresholds ∈[0,1) rolled at noteOn; live per block:
  `spacingMix → (spacing >= thresh ? 1 : 0)` smoothed with the 250 ms one-pole
  (`1−exp(−1/(0.25·sr))`); `baseMix = (1−spacingMix)(1−inversionMix)`; groups share
  the sub-voice's amplitude gain, pan, and positions. Root (i=0) rolls thresholds
  too (only the no-chord fallback path pins them). Live knob changes crossfade
  groups on held notes.
- **v1.14 LFO phase offsets**: `subVoiceLFOPhaseOffsets[i] = i==0 ? 0 : rand·2π`,
  rolled at noteOn; SAME offset array used by LFO A (pos A) and LFO B (pos B):
  `pos = clamp(basePos + sin(lfoPhase + ofs[i])·depth, 0, 1)` per sub-voice.
  Filter LFO keeps the un-offset global phase A.

Port architecture (keeps 12 channels — no lane restructuring):

- **All three osc groups inside the wavetable mc.gen~ codebox** (3 phase Histories,
  3 mipmap levels, 24 peeks/instance worst case, CPU ≈ ×3 — VST runs the same 6
  oscs/sub-voice). Spacing/inversion inherit the channel's gain lane + pan exactly
  like the VST (mix happens pre-`mc.*~`).
- **Per-instance values via `applyvalues` wrapper messages** into mc.gen~ inlet 0
  (first use on mc.gen~ — verified pattern on mc.sig~ since v0.2.0; fallback if the
  load test fails: js emits 12 × `setvalue <i> <param> <v>` instead). js gains
  outlet 5 wired straight to mc.gen~ in0, emitting
  `applyvalues spacingthresh/inversionthresh/lfoofs …` at noteOn (rollNoteRandoms)
  and `applyvalues spacingratio/inversionratio …` live in recomputeOutputs — ratios
  are `noteFrequency(shiftedNote)/noteFrequency(baseNote)` so octaveStretch,
  MIDI clamping, and live tuning edits all track; detune cancels by construction.
  Octave rolls (1-3) stored per voice at noteOn; shifted notes re-derived from the
  live chord in recomputeOutputs (voicing/tonic changes track, rolls stay fixed).
- **LFO A/B move into the codebox** (rate/depth as Params `lforatea/lfodeptha/
  lforateb/lfodepthb`, per-instance `lfoofs`): phase accumulated per instance —
  all instances stay in lockstep (same rate history), offsets applied on top.
  `p wtctl` slims to: dials → line~ → outlets (base positions only; +~ sums, LFO-B
  cycle~/*~ removed); rate/depth inlets → `lforatea $1`-style messages → NEW 4th
  outlet → mc.gen~ in0. cycle~ A stays solely as the filter's phase source
  (starts at 0 like the codebox accumulators, same rate → phase-locked in practice;
  sample-exact lock deferred until it audibly matters).
- **New UI**: spacing + inversion flonums (0-1) → `spacing $1`/`inversion $1`
  messages → mc.gen~ in0 (broadcast, live on held notes, like gaina/gainb);
  `p init` trigger extended to 12, defaults 0. / 0.3 (VST defaults), new outlets
  appended rightmost (x-rank preserved). Both flonums + labels added to
  presentation next to the chord-feel controls (Rule #9).
- Codebox gate smoothing: per-sample one-pole, `coeff = 1−exp(−1/(0.25·samplerate))`
  (the VST's ~250 ms crossfade intent; VST applies the same coeff at block rate).
- Ops verified in DB: exp/wrap/clamp/floor/peek/log2 (gen); sin/tan/pow already in
  use in existing codeboxes.

## Research (slice 3 — stereo spread + chord feel, 2026-08-13)

Verbatim VST semantics (WavetableVoice.cpp startNote/render + PluginProcessor params):

- **stereoSpread** (0-1, def 0.5): per sub-voice pan factor rolled at noteOn:
  root (i=0) centered (0); else `direction * i/(MAX-1)` with direction = +1 odd / -1
  even, plus random ±0.05 "ensemble" variation, clamped ±1. Live per block:
  `targetPan = panFactor * stereoSpread`; voice 1 clamped to ±0.15; constant-power law
  `angle=(pan+1)*0.5; panL=cos(angle*π/2); panR=sin(angle*π/2)`. Spread changes are
  live on held notes (block-rate smoothing).
- **detuneRandom** (0-50 cents, def 5): per sub-voice cent offset rolled ONCE at noteOn
  (`(rand*2-1)*detuneRandom`, root included), applied `freq * 2^(cents/1200)`.
  Param changes affect the NEXT note only (VST caches at startNote).
- **timingRandom** (0-100 ms, def 10): per sub-voice onset delay rolled at noteOn:
  root 0; else uniform 0..timingRandom ms. Param changes affect next note only.

Port architecture (all objects already verified in patch):

- Pan baked into gain lists in js: outlet 1 becomes gainL (existing lane rewires
  unchanged = L), NEW outlet 4 = gainR. Duplicate the gain lane for R:
  `prepend applyvalues → mc.sig~ @chans 12 → mc.rampsmooth~ 2205 2205 → mc.*~
  (mc.gen~ out fans to both) → mc.mixdown~ 1 → *~ (adsr~ fans to both) → *~ 0.1
  → gain~ R → ezdac~ inlet 1`. gain~ L right outlet links gain~ R (single master
  fader); second meter~ for R. ezdac~ verified 2 inlets.
- detuneRandom in js: stored per-note centOffsets[12]; recomputeOutputs multiplies.
- timingRandom in js: onsetMask[12] + js Task objects re-emit gain lists as staggered
  voices unmute; mc.rampsmooth~ 50 ms softens steps (approximates VST 250 ms gain
  smoothing; control-rate ms resolution is adequate for pad onsets).
- New js handlers: stereospread (live recompute), detunerandom / timingrandom
  (stored, next-note). New UI: 3 flonums through `p params` (3 new inlets/prepends,
  x-order preserved) + `p init` defaults (0.5 / 5. / 10., trigger extended to 10
  outlets, new outlets appended right of x=540 to keep x-rank).
- Tradeoff noted: VST staggers sample-accurately inside the voice; the port staggers
  at control rate via Task — acceptable for pad material, revisit with poly~.

## Decisions (temperament presets, 2026-08-14)

- **v0.7.0 temperament presets**: umenu (11 entries) → `prepend temperament` → js.
  Tables verbatim from TuningEngine.cpp; JI/Zarlino/Pythagorean stored as exact
  ratio strings, tempered scales as VST cent values with "c" suffix (Scala-style,
  now accepted by the ratio parser everywhere — "90.225c" is valid manual entry).
  Item 0 restores the default harm-16-30 scale. Bohlen-Pierce included: its 12
  cent values flow through the same signature path (cents on top of 12-TET).
- js outlet 6 (new): [degree, ratiotext] → `p ratioset` (route 0-11 → prepend set)
  → textedit displays refresh on preset load. umenu does NOT auto-switch to
  "Custom" when a degree is hand-edited afterward (accepted, VST-like).
