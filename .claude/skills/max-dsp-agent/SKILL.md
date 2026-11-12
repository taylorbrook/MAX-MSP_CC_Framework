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
2. Read `.claude/skills/references/genexpr-rules.md` before writing or editing any GenExpr (codebox, `.gendsp`, `mc.gen~`) -- the full gen~ rule set with derivations and evidence
3. Read `.claude/skills/references/shared-capabilities.md` "bach (package) Rules" before using any bach object (moved out of CLAUDE.md)
4. Use `ObjectDatabase` from `src.maxpat.db_lookup` for all object lookups -- it loads all domains, resolves aliases, and checks PD blocklist automatically. No need to read individual domain JSON files.
5. Check `.claude/max-objects/pd-blocklist.json` if you need to browse PD equivalents in bulk
6. Read project `config.json` via `load_project_config()` from `src.maxpat.project` for allowed packages. Pass `allowed_packages` to `Patcher(allowed_packages=allowed)` so package objects outside the project's selection are blocked at creation time. If `load_project_config()` returns None (no config.json), use `allowed = []` (core-only), never None -- None allows every package.

**Domain focus:** MSP (signal processing) and Gen~ (DSP operators). Other domains are handled by their respective agents.

## Capabilities

### GenExpr Code Generation
- `build_genexpr(params, code_body, num_inputs=1, num_outputs=1)` -- build validated GenExpr code string
- `parse_genexpr_io(code)` -- detect input/output count from GenExpr code
- `generate_gendsp(code, num_inputs=None, num_outputs=None)` -- generate standalone .gendsp JSON dict
- `write_gendsp(code, path, num_inputs=None, num_outputs=None)` -- write a .gendsp file: a new path is generated; an existing file is edited in place (codebox `code` replaced, `in N`/`out N` boxes synced to the code's I/O, everything else kept; removed cords come back in `result.orphaned`) (imported from `src.maxpat.hooks`, not from `src.maxpat.patcher`)
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
gen_box = patcher.add_box("gen~", ["smooth-ramp"])
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
- `finalize_patch(patcher, is_new=True, force_layout=False)` -- single-call layout cleanup: styling, layout, comments, midpoints (new); comments + routing of new or touched cords that have no midpoints, never moving boxes or clearing midpoints (edit). With `is_new=True` it raises `LayoutRefusedError` on MAX-saved or large patchers (see Output Protocol step 3)
- `apply_layout(patcher)` -- row-based topological auto-layout (called internally by finalize_patch)

### Signal Chain Construction
- Oscillators: cycle~, saw~, rect~, noise~, phasor~, pink~, rand~
- Filters: biquad~, onepole~, reson~, svf~, cascade~, lores~, cross~
- Delays: tapin~/tapout~, delay~ (gen~), allpass~, comb~
- Dynamics: limi~ (peak limiter), gate~, deltaclip~ (slew limiter), gen~ (custom compressor/limiter via GenExpr)
- Effects: cverb~ (MSP reverb), allpass~ / comb~ networks, or build them in gen~ from `patterns/gen` (`simple-reverb`, `multi-tap-delay`) or with tapin~/tapout~ modulated by cycle~ (chorus/flanger)
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

**Max for Live devices (experimental, unconfirmed in Live):** lead audio-effect and instrument builds with `Patcher.add_m4l_device(kind, params)` (or `add_m4l_gen_synth(params)` for a gen~ synth body), save the `.maxpat`, then write the `.amxd` with `export_amxd(maxpat_path)` from `src.maxpat.m4l_device`. Signatures and reuse / refusal rules: "Builder API" in `.claude/skills/references/shared-capabilities.md`; device rules: CLAUDE.md "Max for Live (M4L / .amxd)".

## Package Intelligence

When generating patches with package objects (BEAP, Vizzie, etc.), read `.claude/max-objects/PACKAGES.md` for:
- Signal conventions (BEAP: 0-5V CV, +/-1 audio; Vizzie: Jitter matrices)
- Functional roles and canonical module selection
- Template signal chains with connection order

### Community DSP Packages

Before generating with community package objects, verify `get_package_info(name)["extracted"]` is `true`.

- **FluCoMa** (`fluid.*`): Real-time audio analysis (`fluid.mfcc~`, `fluid.pitch~`, `fluid.loudness~`), decomposition (`fluid.hpss~`, `fluid.sines~`), ML (`fluid.mlpclassifier~`, `fluid.kdtree~`). Signal objects follow standard MSP gain conventions.
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
**Chain:** audio source -> fluid.melbands~ (or fluid.mfcc~ / fluid.pitch~ / fluid.loudness~) -> fluid.stats -> downstream; optional normalization through fluid.normalize~ via the fluid.list2buf / fluid.buf2list bridge

| # | Source | Outlet | Destination | Inlet | Type |
|---|--------|--------|-------------|-------|------|
| 1 | (audio source) | 0 | fluid.melbands~ | 0 (audio in) | signal |
| 2 | fluid.melbands~ | 0 (band magnitudes list) | fluid.stats | 0 (input list) | list |
| 3 | fluid.stats | 0 (rolling mean list; outlet 1 = standard deviation list) | (downstream) or fluid.list2buf | 0 | list |
| 4 | fluid.list2buf | 0 (`buffer <name>` reply) | message `transformpoint $2 <normbuf>` -> fluid.normalize~ | 0 | message |
| 5 | fluid.normalize~ | 0 (reply) | fluid.buf2list `@source <normbuf>` (send `bang`) | 0 | bang |

**Parameter ranges (from the installed refpages):**
- fluid.melbands~: the box argument is shorthand for `@numbands` (min 2, max `@maxnumbands`); `@minfreq` default 20 Hz, `@maxfreq` default 20000 Hz
- fluid.stats: the box argument is the input list size; `@history` sets the window (min 2); it computes the rolling mean and sample standard deviation
- fluid.normalize~: `fit <dataset>` learns the extrema from a fluid.dataset~; `transformpoint <srcbuf> <dstbuf>` normalizes one point held in a buffer~

**Gotchas:**
- fluid.melbands~ outputs a list of band magnitudes (NOT signal) from outlet 0
- fluid.stats keeps a rolling window -- send `clear` to reset its internal state
- fluid.normalize~ works on datasets and buffers, never raw lists: send `fit` with training data first, then bridge each live list with fluid.list2buf (outlet 0 replies `buffer <name>`, used as `$2`, the same shape the fluid.kdtree~ and fluid.mlpclassifier~ help patches use) and read the result back with fluid.buf2list (`bang`, or `buffer <name>`, outputs the buffer as a list). Rows 4-5 follow the refpage; the exact reply that should trigger fluid.buf2list is (role unverified -- confirm in MAX)
- fluid.list2buf: pre-size the destination buffer~ and set `@autosize 0` -- autosize only works on the main thread (refpage) and fails from the scheduler thread
- Feature lists have variable length depending on analysis settings -- downstream objects must handle this

### FluCoMa: Offline Buffer Processing Pipeline

**Use case:** Analyze pre-recorded audio into a corpus and query it by nearest neighbour
**Chain:** buffer~ (source) -> fluid.bufmfcc~ (or fluid.bufmelbands~) -> fluid.bufstats~ -> `addpoint` into fluid.dataset~ -> `fit` fluid.kdtree~ -> `knearest` queries

| # | Source | Outlet | Destination | Inlet | Type |
|---|--------|--------|-------------|-------|------|
| 1 | button | 0 | fluid.bufmfcc~ `@source <src> @features <feat>` | 0 | bang (starts processing) |
| 2 | fluid.bufmfcc~ | 0 (done) | fluid.bufstats~ `@stats <statsbuf>` | 0 | message (as in the fluid.buf2list help) |
| 3 | fluid.bufstats~ | 0 (done) | `t b` -> message `addpoint <id> <statsbuf>` -> fluid.dataset~ | 0 | message |
| 4 | message `fit <dataset>` | 0 | fluid.kdtree~ | 0 | message |
| 5 | (query list) -> fluid.list2buf | 0 (`buffer <name>`) | message `knearest $2` -> fluid.kdtree~ | 0 | message |
| 6 | fluid.kdtree~ | 0 (reply) | `route knearest` -> (downstream) | 0 | list of identifiers |

**Parameters (from the installed refpages):**
- fluid.bufmfcc~: `@source` (input buffer~), `@features` (output buffer~), `@numcoeffs` default 13
- fluid.bufstats~: `@source`, `@stats` (output buffer~), `@numderivs`
- fluid.dataset~: `addpoint <identifier> <buffer>` adds a point; the first point sets the dimensionality
- fluid.kdtree~: `fit <dataset>` builds the tree; `knearest <buffer> [k]` replies with identifiers; `@numneighbours` sets k
- fluid.bufnmf~ (decomposition alternative): `@source`, `@resynth` / `@bases` / `@activations` (output buffer~s), `@components`, `@iterations`; `bang` starts processing and outlet 0 reports completion (help patch)

**Gotchas:**
- fluid.buf* objects start on `bang` and report completion from outlet 0 (help patches wire `button` -> object -> `button`); chain the next stage off that completion, never off the trigger that started the job
- Identifier bookkeeping for `addpoint` (unique id per point) is up to the patch (role unverified -- confirm in MAX)
- Source and destination buffers must be different buffer~ objects
- fluid.dataset~ `read` runs at low priority: chain `dump` off the `read` completion reply, not off a trigger

### FluCoMa: ML Classification Pipeline

**Use case:** Train a classifier on audio features, then classify new audio in real-time
**Train phase:** fluid.buf* analysis -> fluid.dataset~ (features, `addpoint`) + fluid.labelset~ (labels, `addlabel`) -> `fit <dataset> <labelset>` -> fluid.mlpclassifier~
**Predict phase:** real-time fluid.mfcc~ list -> fluid.list2buf -> `predictpoint $2` -> fluid.mlpclassifier~ -> `route predictpoint` -> result mapping

| # | Phase | Source | Outlet | Destination | Inlet | Type |
|---|-------|--------|--------|-------------|-------|------|
| 1 | Train | fluid.bufmfcc~ (or fluid.bufmelbands~) | 0 (done) | `t b` -> `addpoint <id> <buf>` -> fluid.dataset~ | 0 | message |
| 2 | Train | message `fit <dataset> <labelset>` | 0 | fluid.mlpclassifier~ | 0 | message |
| 3 | Predict | (audio source) | 0 | fluid.mfcc~ | 0 | signal |
| 4 | Predict | fluid.mfcc~ | 0 (coefficient list) | fluid.list2buf | 0 | list |
| 5 | Predict | fluid.list2buf | 0 (`buffer <name>`) | message `predictpoint $2` -> fluid.mlpclassifier~ | 0 | message |
| 6 | Predict | fluid.mlpclassifier~ | 0 (reply) | `route fit predictpoint` -> (result mapping) | 0 | message |

**Parameters (from the installed refpage):**
- fluid.mlpclassifier~: `fit <dataset> <labelset>` trains, `predict <dataset> <labelset>` labels a whole dataset, `predictpoint <buffer>` labels one point; `@hiddenlayers` (list of layer sizes; changing it resets the network), `@maxiter` (epochs per `fit`), `@learnrate` (0.0-1.0), `@activation`, `@batchsize`, `@momentum`, `@validation`
- Training features and prediction features must use the same analysis (same object, same settings)

**Gotchas:**
- Training is offline (buf* objects), prediction can be real-time
- fluid.mlpclassifier~ must receive `fit` before `predict` / `predictpoint`
- Replies arrive at outlet 0 prefixed by the method name (help patch: `route fit predictpoint`)
- Use identical analysis settings for training and prediction to avoid dimension mismatch
- fluid.mlpclassifier~ stores model state -- `write` saves it as JSON, `read` reloads it (both run deferred at low priority)

### BEAP: FM Synthesis Chain

Extends the canonical BEAP templates in `.claude/max-objects/PACKAGES.md` (see also the BEAP section of max-patch-agent SKILL.md). Port roles below come from the installed BEAP module patchers' panel labels and the BEAP help patches.

**Use case:** FM voice with an LFO modulating FM depth, filtered and enveloped
**Chain:** bp.Keyboard (pitch + gate) -> bp.FM (LFO on Depth) -> bp.LPF -> bp.VCA (bp.ADSR on CV) -> bp.Stereo

| # | Source | Outlet | Destination | Inlet | Type |
|---|--------|--------|-------------|-------|------|
| 1 | bp.Keyboard | 0 (1v/oct) | bp.FM | 0 (1v/oct) | CV |
| 2 | bp.LFO | 0 (Sine) | bp.FM | 1 (Depth) | CV |
| 3 | bp.FM | 0 (output) | bp.LPF | 0 (Signal) | audio |
| 4 | bp.LPF | 0 (output) | bp.VCA | 0 (signal input) | audio |
| 5 | bp.Keyboard | 1 (Gate) | bp.ADSR | 0 (Gate) | CV |
| 6 | bp.ADSR | 0 (envelope) | bp.VCA | 1 (CV input) | CV |
| 7 | bp.VCA | 0 (scaled output) | bp.Stereo | 0 and 1 (L and R) | audio |

**Port reference:**
- bp.Keyboard outlets: 0 1v/oct, 1 Gate, 2 Trig, 3 Vel
- bp.FM inlets: 0 1v/oct pitch, 1 Depth (help patch drives it from an LFO)
- bp.LFO outlets: 0 Sine, 1 Up, 2 Down, 3 Tri, 4 Square; sine, ramp and square are scaled to +/-5 V inside the module
- bp.LPF (24 dB/oct) inlets: 0 Signal, 1 CV1 (1v/oct), 2 CV2, 3 CV3 (0-5v), 4 Res (0-5v); bp.MMF (12 dB/oct multimode) has the same five-inlet layout
- bp.VCA: 0 to +5 V on the CV inlet scales the signal 0-100% (two-quadrant mode)

**Gotchas:**
- Always route through bp.VCA before bp.Stereo (gain staging convention)
- Feed both bp.Stereo inlets (the help patches wire the mono output to inlets 0 and 1)
- bp.LFO's sine, ramp and square outputs are bipolar (+/-5 V) -- offset them before feeding a 0-5 V input (CV3 or Res on bp.LPF)

### BEAP: Sequenced Pattern

**Use case:** Step sequencer driving oscillator pitch and envelope
**Chain:** bp.Sequencer (CV + Gate) -> bp.Oscillator (pitch from CV) AND bp.ADSR (envelope from Gate) -> bp.VCA (envelope on CV inlet) -> bp.Stereo

| # | Source | Outlet | Destination | Inlet | Type |
|---|--------|--------|-------------|-------|------|
| 1 | bp.Sequencer | 0 (CV) | bp.Oscillator | 0 (CV1 1v/oct) | CV |
| 2 | bp.Sequencer | 1 (Gate) | bp.ADSR | 0 (Gate) | CV |
| 3 | bp.Oscillator | 0 (signal) | bp.VCA | 0 (signal input) | audio |
| 4 | bp.ADSR | 0 (envelope) | bp.VCA | 1 (CV input) | CV |
| 5 | bp.VCA | 0 (scaled output) | bp.Stereo | 0 and 1 (L and R) | audio |

**Port reference:**
- bp.Sequencer inlets: 0 Trigger, 1 Reset; outlets: 0 CV, 1 Gate (help patch: outlet 0 -> bp.FM pitch, outlet 1 -> envelope/trigger inputs)
- bp.ADSR inlets: 0 Gate, 1 Trig
- bp.Oscillator inlets: 0 CV1 (1v/oct, no attenuator), 1 CV2, 2 CV3, 3 Linear FM, 4 PWM, 5 Sync; outlets 0 and 1 are signal outputs

**Gotchas:**
- Internal clock: bp.Sequencer contains its own metro/transport clock, so no external metro is needed; inlet 0 accepts an external trigger
- bp.Oscillator CV1 has no attenuator -- use it for keyboard/sequencer pitch tracking

## Editing Existing Patches (via /max-iterate)

**Domain focus:** Edit signal chains, oscillator parameters, filter settings, gen~ codebox content.

## Output Protocol (New Patches)

1. Generate GenExpr code and/or MSP signal chain
2. If GenExpr: validate with `validate_genexpr()` from `src.maxpat.code_validation`
3. If .maxpat with signal objects: `finalize_patch(patcher, is_new=True)` -- applies styling, layout, assistance comments, and midpoint generation for all patchers and subpatchers. It raises `LayoutRefusedError` (`from src.maxpat.layout import LayoutRefusedError`, a `ValueError`) before changing anything when the patcher, or a subpatcher the layout recurses into, has more than 120 boxes or was saved by MAX: for a large NEW build call `finalize_patch(patcher, is_new=True, force_layout=True)`; for a build that embeds a MAX-saved patcher or edits a file from disk never force -- use `finalize_patch(patcher, is_new=False)` or `edit_patch(path)`. Then serialize via `patch_dict = patcher.to_dict()` and validate a copy via `results = validate_patch(copy.deepcopy(patch_dict), db=patcher.db)`. Proposed removals mean inspect, don't save: if any result has `proposed_removal` set, inspect each `(src_id, outlet, dst_id, inlet)` -- fix a real wiring mistake and re-validate, or keep a false-positive cord and report the checker gap; call `apply_fixes(patch_dict, results)` only when removal is explicitly wanted, then re-validate
4. If standalone .gendsp: generate via `generate_gendsp()`
5. Return output for critic review (DSP critic checks signal flow, gen~ I/O matching)
6. Apply revisions if critic requests them
7. Only when `has_blocking_errors(results, is_new=True)` is False, write final output via `save_patch_roundtrip(patch_dict, path)` or `write_gendsp()` to project's `generated/` directory

## Output Protocol (Edited Patches)

Follow "Output Protocol (Edited Patches)" in `.claude/skills/references/shared-capabilities.md`.

## DSP Pre-Flight Simulation

Before saving a waveguide patch, agent checks for an opt-in numpy
stability fixture and gates the save on its result. See
`src/maxpat/dsp_sim/` and `tests/dsp_sim/README.md` for the topology
catalogue and threshold defaults.

### Codebox smoke test (advisory)

After writing or editing a gen~ codebox, run the offline GenExpr smoke test on the saved file.
It runs every codebox at the default and per-Param min/max corners; UNSUPPORTED never passes.
Report any FAIL or UNSUPPORTED finding to the user, but never block a save on it. Details:
`src/maxpat/dsp_sim/README.md`.

- **Port kinds come from the host patch.** An outlet that reaches `dac~` / `plugout~` / `out~` /
  `gain~` / a meter through signal consumers is **audio** and gets every check (NaN/inf, peak > 4,
  permanent silence, self-sustain such as a latched `tanh(x*g)/tanh(g)` loop, DC, denormal). Any
  other outlet is **control** (Hz, ms, indices, flags) and gets only the NaN/inf FAIL and the
  `denormal` WARN. Inlets get a stimulus by what feeds them (`click~` -> gate, `sig~` / `line~` ->
  control, nothing -> zero, else audio noise).
- **Smoke the host `.maxpat`** rather than a bare `.gendsp`: a lone `.gendsp` finds its host only
  among sibling `.maxpat` files, and with no host every port is audio.
- **`// smoke:` directive** for standalone code and patterns: a comment line in the codebox such
  as `// smoke: control out2 trigger in1 in3=phasor:2` (`control outN`, `audio outN`,
  `trigger inN`, `inN=SPEC`) overrides the inferred kinds. An unusable token is a
  `smoke_directive` WARN.
- A `silence` WARN after the louder rerun (a gate, threshold or one-shot that stays quiet on
  noise) is not a defect; only silence that survives the rerun FAILs.
- Build-time WARNs (`loop_bound_param`, `hoist_alias`, `implicit_channel`) point at the
  codebox safe-construct rules in `genexpr-rules.md`.

```bash
python3 -m src.maxpat.dsp_sim smoke patches/<project>/generated/<name>.maxpat
```

### When to Run (D-07) -- filename convention

- Compute `stem = Path(patch_path).stem` (e.g.,
  `patches/bassoon-model/generated/bassoon-model.maxpat` -> `bassoon-model`).
- Look for `tests/dsp_sim/test_<stem>.py`.
- Present -> run pytest BEFORE `save_patch_roundtrip()`.
- Absent -> no gate; non-waveguide patches and patches without a sim
  fixture commit freely (D-04).

### How to Invoke (T-02 mitigation: argv form, no shell)

```python
import importlib.util
import subprocess
import sys
from pathlib import Path
from src.maxpat.hooks import PatchValidationError

REPO_ROOT = Path.cwd()  # the framework root: run from the directory holding src/
stem = Path(patch_path).stem
fixture = REPO_ROOT / "tests" / "dsp_sim" / f"test_{stem}.py"
if fixture.exists():
    if importlib.util.find_spec("pytest") is None:
        raise PatchValidationError(
            f"DSP pre-flight simulation for {stem} cannot run: pytest is not "
            f"installed for {sys.executable} (pip install -r requirements-dev.txt)"
        )
    result = subprocess.run(
        [sys.executable, "-m", "pytest", str(fixture), "-q", "-p", "no:cacheprovider",
         "-o", "addopts="],
        cwd=str(REPO_ROOT),
        check=False,
        capture_output=True,
        text=True,
    )
    if result.returncode != 0:
        # VALID-05 'error' severity -- HARD BLOCK the save (D-04).
        raise PatchValidationError(
            f"DSP pre-flight simulation failed for {stem}:\n{result.stdout}\n{result.stderr}"
        )
```

`-o addopts=` clears the maintainer `pytest.ini` addopts (`-n auto`), so the gate stays serial and needs no pytest-xdist in any checkout.

`sys.executable -m pytest` with `cwd=REPO_ROOT` is what makes the gate work in
a release install: `tests/` is not shipped there, so a registered fixture has
no `__init__.py` or conftest, and bare `pytest` would put `tests/dsp_sim` (not
the root) on `sys.path` and fail collection with `No module named 'src'`.
`python -m` puts the working directory on `sys.path`, and it needs no `pytest`
on PATH.

Use the argv list form ALWAYS. Never invoke pytest through a shell (no
`shell` kwarg set to true) and never string-interpolate `stem` or
`patch_path` into a command string -- the path comes from the filesystem
and may contain metacharacters; argv form treats it as a single opaque
token.

### How to Register a New Sim Test

For a patch at `patches/<project>/generated/<name>.maxpat`:

1. Pick a topology from `src/maxpat/dsp_sim/topologies/` (`reed_bore`,
   `reed_bore_post_radiation`; `bore_only` was removed in Q25) or write a custom mirror.
2. Create `tests/dsp_sim/test_<name>.py` calling
   `run_simulation(patch_path=..., topology=..., params=..., sweep_param=..., sweep=(lo, hi, n))`.
3. Assert `report.verdict == "pass"`.

The `(patch_path, param_name, sweep_range)` triple in that fixture file is
the ENTIRE binding (D-02 / DSPSIM-05). No sidecar JSON, no patch-comment
annotation, no config block.

### Failure Handling (VALID-05 'error' tier)

If the gate fails, surface in the agent's summary:

- The verdict (one of `phase_drift`, `mode_competition`, `no_oscillation`,
  `runaway`).
- The sweep parameter name and the worst-step's `param_value`.
- Worst step's `measured_hz` vs `target_hz` (and `cents_offset`).
- The `suggested_fix` string from `SimulationReport.suggested_fix`.

Then HARD BLOCK the commit. The author either fixes the DSP issue OR, if
intentional, deletes / skip-marks the fixture (D-10) -- opt-out is
auditable in git history; there is no `--skip-dsp-sim` flag.

### Verdict & Fix Reference

| Verdict | Threshold | Suggested fix (from CLAUDE.md Gen~ rule "Waveguide loop filters"; derivation: genexpr-rules.md) |
|---------|-----------|----------------------------------------------------------------------|
| `phase_drift` | range > 5 cents across sweep | Use phase delay (atan2-based) compensation, not group delay |
| `mode_competition` | any step > 50 cents jump | Move the high-Q (Q > ~1) filter post-loop |
| `no_oscillation` | RMS < 1e-4 at any step | Loop dissipation likely too high; check damping coefficients |
| `runaway` | peak > 10.0 OR NaN/Inf | Loop gain >= 1; add saturator or reduce reflection scalar |

Verdict priority on multi-mode runs (D-09):
`runaway` > `no_oscillation` > `mode_competition` > `phase_drift` > `pass`.
Single verdict per run.

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
