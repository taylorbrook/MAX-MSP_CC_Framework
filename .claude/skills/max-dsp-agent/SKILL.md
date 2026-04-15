---
name: max-dsp-agent
description: Generate Gen~ GenExpr DSP code, signal processing patches, and audio effect chains
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
preconditions:
  - Active project must exist
  - Router must have dispatched to this agent
---

# DSP/Gen~ Specialist Agent

The DSP agent generates audio signal processing components: GenExpr code for gen~ objects, MSP signal chains, and audio effect architectures. It handles everything that operates at audio rate.

## Domain Context Loading

Before any generation:
1. Read `CLAUDE.md` at project root -- follow MSP and Gen~ domain-specific rules
2. Use `ObjectDatabase` from `src.maxpat.db_lookup` for all object lookups -- it loads all domains, resolves aliases, and checks PD blocklist automatically. No need to read individual domain JSON files.
3. Check `.claude/max-objects/pd-blocklist.json` if you need to browse PD equivalents in bulk
4. Read project `config.json` via `load_project_config()` from `src.maxpat.project` for allowed packages. Pass `allowed_packages` to `Patcher(allowed_packages=allowed)` so package objects outside the project's selection are blocked at creation time.

**Domain focus:** MSP (signal processing) and Gen~ (DSP operators). Other domains are handled by their respective agents.

## Capabilities

### GenExpr Code Generation
- `build_genexpr(params, code_body, num_inputs=1, num_outputs=1)` -- build validated GenExpr code string
- `parse_genexpr_io(code)` -- detect input/output count from GenExpr code
- `generate_gendsp(code, num_inputs=None, num_outputs=None)` -- generate standalone .gendsp JSON dict
- `write_gendsp(code, path, num_inputs=None, num_outputs=None)` -- generate and write a .gendsp file to disk (imported from `src.maxpat.hooks`, not from `src.maxpat.patcher`)
- GenExpr syntax: `in1`/`out1` for I/O (no space -- space form is for gen~ patcher objects only), `Param` for parameters, `History` for feedback, `Buffer`/`Data` for samples
- **Declaration ordering rule:** ALL declarations (`Param`, `Delay`, `History`, `Buffer`, `Data`) MUST appear at the top of the codebox, before any expressions or assignments. GenExpr enforces this strictly -- mixing declarations with expressions causes "declarations must come before any expressions" errors. Group declarations by type: Params first, then Delays, then History, then Buffer/Data.

### Gen~ Patch Integration
- `Patcher.add_gen(code, num_inputs=None, num_outputs=None)` -- embed gen~ codebox in a .maxpat
- Codebox via `Box.__new__()` pattern (structural object bypassing DB)
- Codebox code stored in `extra_attrs` for serialization

## Gen~ Pattern Library

Reusable .gendsp files in `patterns/gen/` provide sample-accurate alternatives to common anti-patterns. Consult `patterns/gen/INDEX.md` for the full pattern table with I/O counts, params, and use cases.

### Using External .gendsp Patterns

Create a `gen~ pattern-name` newobj box (NOT via `add_gen()` which is for inline codebox):

```python
gen_box = patcher.add_box(Box("gen~", ["smooth-ramp"], db))
gen_box.numinlets = 1    # Must match .gendsp I/O count
gen_box.numoutlets = 1
gen_box.outlettype = ["signal"]  # Use ["signal", "signal"] for stereo
```

**File placement:** Copy the .gendsp file from `patterns/gen/` to the project's `generated/` directory alongside the .maxpat.

**Param messages:** Send as plain name messages: `time 50` or `time $1` (NOT `@time 50`).

### Don't Hand-Roll

| Problem | Don't Build | Use Instead |
|---------|-------------|-------------|
| Smooth parameter transitions | Custom line~ message chains | `one-pole-smooth` or `smooth-ramp` |
| ADSR envelopes | function + line~ combos | `adsr-envelope` |
| Timing/clocks | metro + counter | `master-clock` + `subdivider` |
| Soft clipping | clip~ 0 1 | `soft-clipper` |
| Parameter smoothing | Nothing (zipper noise) | `one-pole-smooth` |
| Volume control | Raw *~ at full level | `safe-gain` |

### Layout and Finalization
- `finalize_patch(patcher, is_new=True)` -- single-call layout cleanup: styling, layout, comments, midpoints (new); midpoints + comments (edit)
- `apply_layout(patcher)` -- row-based topological auto-layout (called internally by finalize_patch)

### Signal Chain Construction
- Oscillators: cycle~, saw~, rect~, noise~, phasor~, pink~, rand~
- Filters: biquad~, onepole~, reson~, svf~, cascade~, lores~, cross~
- Delays: tapin~/tapout~, delay~ (gen~), allpass~, comb~
- Dynamics: limi~ (peak limiter), gate~, deltaclip~ (slew limiter), gen~ (custom compressor/limiter via GenExpr)
- Effects: reverb~, chorus~, flanger~, phaser~
- Gain: *~ for level control, line~ for smooth transitions, dbtoa/atodb for dB conversion
- Monitoring: meter~, levelmeter~, scope~, spectroscope~, snapshot~

### Bpatcher Argument Substitution (for reusable DSP subpatches)
- `#N` tokens must be **standalone** in object text -- never embedded in compound strings
- WRONG: `buffer~ slot-#1`, `send~ slot-#1-out` -- compound substitution fails in MAX
- RIGHT: `buffer~ #1`, `send~ #2` with bpatcher args `["slot-1", "slot-1-out"]`
- See CLAUDE.md "Bpatcher and Abstraction Arguments" section for full rules

### Audio Architecture Patterns
- Proper gain staging: never connect raw oscillators to dac~ at full volume
- Use `*~ 0.5` or `*~` with `line~` for gain control
- Terminate signal chains with `dac~` or `*~ 0.` (mute)
- Use `snapshot~` to convert signal values to control rate for display
- Feedback loops: tapin~/tapout~ pair (MSP) or History operator (gen~)
- gen~ exempted from feedback loop warnings (History is the intended mechanism)

### Control-Rate Fan-Out in DSP Patches
- **MUST** use `trigger` (t) for any control-rate outlet that fans out to 2+ destinations
- Signal-rate (~) fan-out is exempt -- MSP processes all signal connections simultaneously
- Common case: a `loadbang` or `metro` feeding multiple control-rate destinations in a DSP patch still needs trigger
- See shared-capabilities.md "Control-Rate Fan-Out Rule" for the full rule and examples

> **Shared Capabilities:** See `.claude/skills/references/shared-capabilities.md` for Control-Rate Fan-Out Rule, Assistance Comments, Aesthetic Capabilities, Layout Options, Editing Functions, and Edit Workflow reference.

## Package Intelligence

When generating patches with package objects (BEAP, Vizzie, etc.), read `.claude/max-objects/PACKAGES.md` for:
- Signal conventions (BEAP: 0-5V CV, +/-1 audio; Vizzie: Jitter matrices)
- Functional roles and canonical module selection
- Template signal chains with connection order

### Community DSP Packages

Before generating with community package objects, verify `get_package_info(name)["extracted"]` is `true`.

- **FluCoMa** (`fluid.*`): Real-time audio analysis (`fluid.mfcc`, `fluid.pitch`, `fluid.loudness`), decomposition (`fluid.hpss~`, `fluid.sines~`), ML (`fluid.mlpclassifier`, `fluid.kdtree`). Signal objects follow standard MSP gain conventions.
- **CNMAT** (`resonators~`, `peqbank~`, `oscillators~`, `harmonics~`): Spectral/resonance modeling. `resonators~` is the key DSP object -- takes partials data via messages.
- **Bach** (`bach.*`): Algorithmic composition, not signal processing. `bach.score`/`bach.roll` output MIDI-like data for driving synths.
- **IRCAM Spat** (`spat5.*`): Spatial audio -- `spat5.panning~`, `spat5.binaural~`, `spat5.reverb~`. Multi-channel signal I/O.
- **ml-lib** (`ml.*`): Control-rate ML -- outputs classification/regression values for driving parameters.

### BEAP and MSP Integration

BEAP modules use MSP signals internally but with modular conventions:
- BEAP CV range is 0 to +5V (NOT standard MSP +/-1) -- do not mix raw MSP signals into BEAP CV inputs without scaling
- When building hybrid patches (MSP + BEAP), use `*~ 5.0` to scale MSP (+/-1) to BEAP CV range, or `*~ 0.2` for BEAP-to-MSP
- BEAP 1V/oct pitch tracking: each volt = one octave. bp.Keyboard outputs calibrated pitch CV.
- gen~ codebox output can feed BEAP modules if properly scaled to 0-5V range
- BEAP modules are NOT gen~ objects -- they are bpatchers containing MSP signal chains

## Package Workflow Templates

Structured signal chain blueprints for generating working package patches. Each template specifies objects, connection order, I/O types, parameter ranges, and gotchas. Templates are generation guidance -- not pre-built .maxpat files.

### FluCoMa: Real-Time Audio Analysis Chain

**Use case:** Extract spectral features from live audio for visualization or ML input
**Chain:** audio source -> fluid.melbands~ (or fluid.mfcc~ or fluid.pitch~) -> fluid.stats -> fluid.normalize -> downstream

| # | Source | Outlet | Destination | Inlet | Type |
|---|--------|--------|-------------|-------|------|
| 1 | (audio source) | 0 | fluid.melbands~ | 0 (audio in) | signal |
| 2 | fluid.melbands~ | 0 (features list) | fluid.stats | 0 (input) | list |
| 3 | fluid.stats | 0 (stats) | fluid.normalize | 0 (input) | list |
| 4 | fluid.normalize | 0 (normalized) | (downstream) | 0 | list |

**Parameter ranges:**
- fluid.melbands~: `@numbands` default 40 (range 2-128), `@minfreq` 20, `@maxfreq` 20000
- fluid.stats: `@numderivs` default 0 (0-2), controls derivative statistics
- fluid.normalize: call `fit` with training data before `transform`

**Gotchas:**
- fluid.melbands~ outputs a list of band energies (NOT signal) from outlet 0
- fluid.stats accumulates over time -- send "reset" message to clear
- fluid.normalize needs training data first -- send "fit" before "transform"
- Real-time FluCoMa objects follow standard MSP gain conventions (+/-1 signal range)
- Feature lists have variable length depending on analysis settings -- downstream objects must handle this

### FluCoMa: Offline Buffer Processing Pipeline

**Use case:** Analyze/decompose pre-recorded audio (corpus analysis, NMF decomposition)
**Chain:** buffer~ (source) -> fluid.bufnmf (or fluid.bufstats, fluid.bufmelbands) -> [bang on completion] -> fluid.dataset -> fluid.kdtree

| # | Source | Outlet | Destination | Inlet | Type |
|---|--------|--------|-------------|-------|------|
| 1 | buffer~ | (reference) | fluid.bufnmf | @source attribute | bang/message |
| 2 | fluid.bufnmf | 0 (bang on done) | trigger | 0 | bang |
| 3 | trigger | 0 | fluid.dataset | 0 (addpoint msg) | message |
| 4 | fluid.dataset | (query) | fluid.kdtree | 0 (input) | message |
| 5 | fluid.kdtree | 0 (nearest result) | (downstream) | 0 | list |

**Parameter ranges:**
- fluid.bufnmf: `@components` 2-10 (number of decomposition components), `@iterations` 100 default
- fluid.dataset: stores labeled feature vectors, query by ID
- fluid.kdtree: `@numneighbours` default 1 (number of nearest neighbors to return)

**Gotchas:**
- All fluid.buf* objects are ASYNC -- they output bang from outlet 0 when done
- Chain multiple buf* operations using bang -> trigger -> next buf* pattern
- fluid.bufnmf outputs to destination buffer~ (set via @resynth attribute), not via outlets
- fluid.dataset stores feature vectors for ML queries; fluid.kdtree enables nearest-neighbor lookup
- Source and destination buffers must be different buffer~ objects

### FluCoMa: ML Classification Pipeline

**Use case:** Train a classifier on audio features, then classify new audio in real-time
**Train phase:** fluid.buf* analysis -> fluid.dataset (store features) -> fluid.mlpclassifier (train)
**Predict phase:** real-time fluid.*~ analysis -> fluid.mlpclassifier (predict) -> result mapping

| # | Phase | Source | Outlet | Destination | Inlet | Type |
|---|-------|--------|--------|-------------|-------|------|
| 1 | Train | fluid.bufmfcc (or bufmelbands) | 0 (bang) | trigger -> fluid.dataset addpoint | 0 | bang |
| 2 | Train | fluid.dataset | (complete) | fluid.mlpclassifier "train" msg | 0 | message |
| 3 | Predict | (audio source) | 0 | fluid.mfcc~ (or melbands~) | 0 | signal |
| 4 | Predict | fluid.mfcc~ | 0 (features) | fluid.mlpclassifier "predict" msg | 0 | list |
| 5 | Predict | fluid.mlpclassifier | 0 (prediction) | (result mapping) | 0 | list |

**Parameter ranges:**
- fluid.mlpclassifier: `@hiddenlayers` default [5] (list of layer sizes), `@maxiter` 1000, `@learnrate` 0.01
- Training features and prediction features must use the same analysis (same object, same settings)

**Gotchas:**
- Training is offline (buf* objects), prediction can be real-time
- fluid.mlpclassifier needs "train" message before "predict"
- Send feature lists (not signals) to classifier input
- Use identical analysis settings for training and prediction to avoid dimension mismatch
- fluid.mlpclassifier stores model state -- use "write" message to save, "read" to reload

### BEAP: FM Synthesis Chain

Extends the canonical BEAP templates in PACKAGES.md with additional modular patterns.

**Use case:** FM synthesis with modulator LFO controlling carrier frequency
**Chain:** bp.LFOscillator (modulator CV) -> bp.FM (carrier) -> bp.SVF (optional filter) -> bp.VCA -> bp.Stereo

| # | Source | Outlet | Destination | Inlet | Type |
|---|--------|--------|-------------|-------|------|
| 1 | bp.Keyboard | 0 (pitch CV) | bp.FM | 0 (CV1 1V/oct) | CV |
| 2 | bp.LFOscillator | 0 (mod CV) | bp.FM | 1 (mod input) | CV |
| 3 | bp.FM | 0 (signal) | bp.SVF | 0 (signal input) | audio |
| 4 | bp.SVF | 0 (filtered) | bp.VCA | 0 (signal input) | audio |
| 5 | bp.Keyboard | 1 (gate) | bp.ADSR | 0 (gate) | CV |
| 6 | bp.ADSR | 0 (envelope) | bp.VCA | 1 (CV) | CV |
| 7 | bp.VCA | 0 (output) | bp.Stereo | 0 | audio |

**Parameter ranges:**
- bp.LFOscillator: rate typically 0.1-20 Hz for FM modulation
- bp.SVF: cutoff controlled via 0-5V CV on inlet 1
- bp.FM: ratio parameter sets carrier/modulator frequency relationship

**Gotchas:**
- bp.FM expects modulation as 0-5V CV signal, not audio-rate modulation
- bp.SVF cutoff controlled via 0-5V CV on inlet 1
- Always route through bp.VCA before bp.Stereo (gain staging convention)
- bp.LFOscillator outputs 0-5V CV range -- compatible directly with BEAP CV inlets

### BEAP: Sequenced Pattern

**Use case:** Step sequencer driving oscillator pitch and envelope
**Chain:** bp.Steppr (gate + CV) -> bp.ADSR (envelope from gate) AND bp.Oscillator (pitch from CV) -> bp.VCA (envelope on CV inlet) -> bp.Stereo

| # | Source | Outlet | Destination | Inlet | Type |
|---|--------|--------|-------------|-------|------|
| 1 | bp.Steppr | 0 (gate) | bp.ADSR | 0 (gate) | CV |
| 2 | bp.Steppr | 1 (CV pitch) | bp.Oscillator | 0 (CV1 1V/oct) | CV |
| 3 | bp.Oscillator | 0 (signal) | bp.VCA | 0 (signal input) | audio |
| 4 | bp.ADSR | 0 (envelope) | bp.VCA | 1 (CV) | CV |
| 5 | bp.VCA | 0 (output) | bp.Stereo | 0 | audio |

**Parameter ranges:**
- bp.Steppr: 8 or 16 steps, tempo in BPM, gate length adjustable
- bp.ADSR: attack/decay/sustain/release in standard envelope ranges
- bp.Oscillator: pitch follows 1V/oct from bp.Steppr CV output

**Gotchas:**
- bp.Steppr gate outlet (0) triggers bp.ADSR; CV outlet (1) controls pitch
- bp.ADSR outputs 0-5V envelope -- connect to bp.VCA CV input (inlet 1)
- bp.Oscillator pitch inlet expects 1V/octave CV from bp.Steppr or bp.Keyboard
- Internal clock: bp.Steppr has its own tempo control; no external metro needed

## Editing Existing Patches (via /max-iterate)

**Domain focus:** Edit signal chains, oscillator parameters, filter settings, gen~ codebox content.

## Output Protocol (New Patches)

1. Generate GenExpr code and/or MSP signal chain
2. If GenExpr: validate with `validate_genexpr()` from `src.maxpat.code_validation`
3. If .maxpat with signal objects: `finalize_patch(patcher, is_new=True)` -- applies styling, layout, assistance comments, and midpoint generation for all patchers and subpatchers. Then serialize via `patcher.to_dict()`, validate via `validate_patch()`
4. If standalone .gendsp: generate via `generate_gendsp()`
5. Return output for critic review (DSP critic checks signal flow, gen~ I/O matching)
6. Apply revisions if critic requests them
7. Write final output via `save_patch_roundtrip(patch_dict, path)` or `write_gendsp()` to project's `generated/` directory

## Output Protocol (Edited Patches)

1. Load and analyze existing patch via `read_patch()` and `patcher.analyze()`
2. Make surgical edits or section rebuild using find/modify/replace/insert/remove
3. Finalize patch: `finalize_patch(patcher, is_new=False)` -- regenerates cable midpoints and populates assistance comments without repositioning existing objects
4. Validate via `validate_patch(patcher)`
5. Return for critic review
6. Save via `save_patch_roundtrip()`

## When to Use

- Any task involving audio signal processing
- GenExpr code generation (waveshapers, filters, oscillators, effects)
- MSP signal chain construction
- Audio effect design (delay, reverb, chorus, distortion, compression)
- Synthesizer audio engine (oscillators, envelopes, modulation)
- Multichannel (mc.) signal processing
- Feedback loop design

## When NOT to Use

- Control-rate patch routing (sequencers, MIDI, messages) -- use max-patch-agent
- Presentation mode UI layout -- use max-ui-agent
- JavaScript/Node scripting -- use max-js-agent
- RNBO export and compatibility -- use max-rnbo-agent
- C/C++ external development -- use max-ext-agent
