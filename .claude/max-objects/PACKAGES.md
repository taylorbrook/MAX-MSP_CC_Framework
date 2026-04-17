# Package Reference

Shared reference for all agents when generating patches with bundled package objects. For individual object details (inlets, outlets, arguments, messages), use `ObjectDatabase.lookup(name)`.

## Scope

Covers all packages in `.claude/max-objects/packages/`:

- **Bundled** (ship with Max 9): ableton-dsp, BEAP, jit.mo, Jitter Geometry, Jitter Tools, maxforlive-elements, Mira, RNBO Guitar, VIDDLL, Vizzie.
- **Community** (separate install via Package Manager or manual): ABL Effect Modules, abclib, Bach, Cage, catart-mubu, CNMAT, cv.jit, Dada, EARS, ease, FlowSwing, FluCoMa, grainflow, IRCAM Spat, ml-lib, ml.star, nn_tilde, Odot, Rhythmic Time Toolkit.

For per-package install state and object counts, see `package_info.json` (`installed`, `extracted`, `object_count` fields).

## Signal Conventions

### BEAP

BEAP modules use a modular synthesizer paradigm with standardized signal levels:

- **CV signals:** 0 to +5V range (all CV inlets/outlets)
- **Audio signals:** +/-1 range (standard MSP amplitude)
- **Pitch tracking:** 1V/oct on CV1 inputs (inlet 0 on oscillators)
- **Gate signals:** 0V (off) to +5V (on)
- **Always terminate** signal chains with bp.Stereo or bp.Mono
- **Always use bp.VCA** for gain control -- never connect an oscillator directly to an output module
- bp.VCA inlet 1 accepts 0-5V CV for amplitude envelope control

### Vizzie

Vizzie modules process video using Jitter matrices:

- **All data flows as Jitter matrices** between modules (NOT audio signals)
- **Matrix inlets** accept `jit_matrix` type connections
- **Control inlets** accept int/float messages for parameter adjustment
- **No audio signal processing** -- Vizzie is pure video/visual domain
- Use vz.audio2vizzie or vz.beapconvertr to bridge audio/BEAP data into Vizzie

## Functional Roles

### BEAP

| Role | Categories | Key Modules |
|------|------------|-------------|
| Sources | Oscillator, Input, Random | bp.Oscillator, bp.Keyboard, bp.Noise, bp.FM |
| Processors | Filter, Effects, Level, Waveshapers | bp.LPF, bp.VCA, bp.Chorus, bp.Feedback Delay |
| Modulators | LFO, Envelope | bp.LFO, bp.ADSR, bp.AD, bp.Envelope Follower |
| Output | Output | bp.Stereo, bp.Mono |
| Utility | Scope, Misc, Sequencer, Mixers, MIDI, Analysis | bp.Scope, bp.Sequencer, bp.Audio Mixer |

### Vizzie

| Role | Categories | Key Modules |
|------|------------|-------------|
| Sources | Input, Generate | vz.playr, vz.grabbr, vz.avplayr, vz.moviefoldr |
| Effects | Effect, Transform | vz.slidr, vz.scramblr, vz.delayr, vz.kaleidr |
| Control | Control | vz.fadr, vz.dataslidr, vz.clickr, vz.scrubbr |
| Compositing | Mix-Composite | vz.chromakeyr, vz.xfadr, vz.4mixr, vz.alphablendr |
| Output | Output | vz.viewr, vz.projectr, vz.recordr, vz.snappr |
| Utility | Utility | vz.audio2vizzie, vz.beapconvertr, vz.startr |

## Canonical Templates

### BEAP Templates

> Additional BEAP workflow templates (FM synthesis, sequenced patterns) are in `.claude/skills/max-dsp-agent/SKILL.md` under "Package Workflow Templates".

#### 1. Subtractive Synthesizer

**Modules:** bp.Keyboard -> bp.Oscillator -> bp.LPF -> bp.VCA -> bp.Stereo
**Modulation:** bp.ADSR -> bp.VCA (CV), bp.LFO -> bp.LPF (CV2)

| # | Source | Outlet | Destination | Inlet | Signal |
|---|--------|--------|-------------|-------|--------|
| 1 | bp.Keyboard | 0 (pitch CV) | bp.Oscillator | 0 (CV1 1V/oct) | CV |
| 2 | bp.Oscillator | 0 (signal) | bp.LPF | 0 (signal input) | audio |
| 3 | bp.LPF | 0 (filtered) | bp.VCA | 0 (signal input) | audio |
| 4 | bp.VCA | 0 (output) | bp.Stereo | 0 | audio |
| 5 | bp.Keyboard | 1 (gate) | bp.ADSR | 0 (gate) | CV |
| 6 | bp.ADSR | 0 (envelope) | bp.VCA | 1 (CV) | CV |
| 7 | bp.LFO | 0 (waveform) | bp.LPF | 1 (CV2 cutoff) | CV |

#### 2. FM Synthesizer

**Modules:** bp.Keyboard -> bp.FM -> bp.VCA -> bp.Stereo
**Modulation:** bp.ADSR -> bp.VCA (CV)

| # | Source | Outlet | Destination | Inlet | Signal |
|---|--------|--------|-------------|-------|--------|
| 1 | bp.Keyboard | 0 (pitch CV) | bp.FM | 0 (CV1) | CV |
| 2 | bp.FM | 0 (signal) | bp.VCA | 0 (signal input) | audio |
| 3 | bp.VCA | 0 (output) | bp.Stereo | 0 | audio |
| 4 | bp.Keyboard | 1 (gate) | bp.ADSR | 0 (gate) | CV |
| 5 | bp.ADSR | 0 (envelope) | bp.VCA | 1 (CV) | CV |

#### 3. Sequenced Patch

**Modules:** bp.Sequencer -> bp.Oscillator -> bp.LPF -> bp.VCA -> bp.Stereo
**Modulation:** bp.AD -> bp.VCA (CV), clock from bp.Sequencer

| # | Source | Outlet | Destination | Inlet | Signal |
|---|--------|--------|-------------|-------|--------|
| 1 | bp.Sequencer | 0 (pitch CV) | bp.Oscillator | 0 (CV1) | CV |
| 2 | bp.Oscillator | 0 (signal) | bp.LPF | 0 (signal input) | audio |
| 3 | bp.LPF | 0 (filtered) | bp.VCA | 0 (signal input) | audio |
| 4 | bp.VCA | 0 (output) | bp.Stereo | 0 | audio |
| 5 | bp.Sequencer | 1 (gate) | bp.AD | 0 (gate) | CV |
| 6 | bp.AD | 0 (envelope) | bp.VCA | 1 (CV) | CV |

#### 4. Audio Effect Chain

**Modules:** (audio input) -> bp.Chorus -> bp.Feedback Delay -> bp.Stereo
No keyboard -- processes existing audio from another source.

| # | Source | Outlet | Destination | Inlet | Signal |
|---|--------|--------|-------------|-------|--------|
| 1 | (audio source) | 0 | bp.Chorus | 0 (signal input) | audio |
| 2 | bp.Chorus | 0 (wet) | bp.Feedback Delay | 0 (signal input) | audio |
| 3 | bp.Feedback Delay | 0 (output) | bp.Stereo | 0 | audio |

#### 5. Analysis/Visualization

**Modules:** (audio input) -> bp.Scope
Visual monitoring of audio signals. bp.Scope has 1 inlet (signal) and 1 outlet (pass-through).

| # | Source | Outlet | Destination | Inlet | Signal |
|---|--------|--------|-------------|-------|--------|
| 1 | (audio source) | 0 | bp.Scope | 0 (signal input) | audio |

### Vizzie Templates

#### 1. Video Effects Chain

**Modules:** vz.playr -> vz.slidr -> vz.chromakeyr -> vz.viewr

| # | Source | Outlet | Destination | Inlet | Type |
|---|--------|--------|-------------|-------|------|
| 1 | vz.playr | 0 (matrix) | vz.slidr | 0 (matrix input) | matrix |
| 2 | vz.slidr | 0 (matrix) | vz.chromakeyr | 0 (foreground) | matrix |
| 3 | vz.chromakeyr | 0 (composite) | vz.viewr | 0 (display) | matrix |

#### 2. Live Camera Processing

**Modules:** vz.grabbr -> vz.scramblr -> vz.delayr -> vz.viewr

| # | Source | Outlet | Destination | Inlet | Type |
|---|--------|--------|-------------|-------|------|
| 1 | vz.grabbr | 0 (matrix) | vz.scramblr | 0 (matrix input) | matrix |
| 2 | vz.scramblr | 0 (matrix) | vz.delayr | 0 (matrix input) | matrix |
| 3 | vz.delayr | 0 (matrix) | vz.viewr | 0 (display) | matrix |

#### 3. VJ Setup (Multi-source)

**Modules:** vz.playr + vz.grabbr -> vz.xfadr -> vz.projectr

| # | Source | Outlet | Destination | Inlet | Type |
|---|--------|--------|-------------|-------|------|
| 1 | vz.playr | 0 (matrix) | vz.xfadr | 0 (source A) | matrix |
| 2 | vz.grabbr | 0 (matrix) | vz.xfadr | 1 (source B) | matrix |
| 3 | vz.xfadr | 0 (mixed) | vz.projectr | 0 (display) | matrix |

## Bpatcher Conventions

- BEAP modules are bpatchers with the `bp.` prefix
- Vizzie modules are bpatchers with the `vz.` prefix
- All BEAP/Vizzie modules have measured `bpatcher_dimensions` in the DB -- use `add_bpatcher(object_name="bp.Oscillator")` for auto-sizing
- BEAP standard module height: 116px (most modules), widths vary 52-895px
- Vizzie dimensions vary more widely (71-738px wide, 57-517px tall)
- Bpatcher arguments use `#N` substitution -- see CLAUDE.md Bpatcher rules

## Other Bundled Packages

These packages use standard newobj objects (NOT bpatchers):

| Package | Prefix | Domain | Notes |
|---------|--------|--------|-------|
| ableton-dsp | abl. | Audio effects/synths | Building blocks for Ableton-style devices |
| jit.mo | jit.mo. | Jitter animation | Motion and animation utilities |
| Jitter Geometry | jit.geom. | Jitter geometry | Mesh manipulation and deformation |
| Jitter Tools | jit. | Jitter rendering | Additional rendering, effects, utilities |
| Mira | mira. | iPad control | Remote control UI for MAX patches |
| maxforlive-elements | m4l. | Max for Live | UI elements and utility abstractions |
| VIDDLL | viddll. | GPU video decoding | Hardware-accelerated video playback (3 objects, used by Vizzie internally) |
| RNBO Guitar | rnbo.guitar. | RNBO guitar effects | Empty in DB (`extracted: false`) -- placeholder for future extraction |

Look up individual objects with `ObjectDatabase.lookup(name)` for inlet/outlet details.

## Community Packages

Community packages require separate installation and extraction before generation. Agents must check `extracted` flag in package_info.json before using any community package objects.

### Package Reference

| Package | Prefix | Domain | Key Objects | Install |
|---------|--------|--------|-------------|---------|
| ABL Effect Modules | `Abl.*` | Ableton-style effect abstractions (`.maxpat` bpatchers wrapping ABL DSP library) | `Abl.Compressor~`, `Abl.AutoFilter~`, `Abl.DarkHall~`, `Abl.SpectralReson~` | Package Manager |
| abclib | `abc.*` | Spatial audio (ambisonics), multichannel synthesis, mixed-music utilities | `abc.adcinput~`, `abc.delaychain~`, `abc.env.generator~`, `abc.cartopol~` | Package Manager |
| Bach | `bach.*` | Algorithmic composition (llll data type) | `bach.score`, `bach.roll`, `bach.eval` | Package Manager |
| Cage | `cage.*` | Algorithmic composition (requires Bach) | `cage.profile`, `cage.lsystem` | Package Manager |
| catart-mubu | `camu.*` | Concatenative synthesis, audio mosaicing, descriptor analysis (requires MuBu; optional Bach/Cage/Spat) | `camu.analysis`, `camu.import-from-text`, `camu.imubu.control`, `camu.export.segments` | Package Manager |
| CNMAT | *(bare names)* | OSC, resonance, spectral | `resonators~`, `analyzer~`, `peqbank~` | Package Manager |
| cv.jit | `cv.jit.*` | Computer vision externals for Jitter (matrices in/out) | `cv.jit.binedge`, `cv.jit.blobs.bounds`, `cv.jit.blobs.centroids`, `cv.jit.LKflow` | Package Manager |
| Dada | `dada.*` | Graphical CAC (requires Bach) | `dada.graph`, `dada.bounce` | Package Manager |
| EARS | `ears.*` | Offline buffer processing (requires Bach) | `ears.slice`, `ears.filter~` | Package Manager |
| ease | `ease`, `ease~`, `jit.ease`, `list.ease`, `ease.xfade`, `ease.xfade~` | Easing functions for audio, visuals, automation | `ease`, `ease~`, `jit.ease`, `list.ease` | Package Manager |
| FlowSwing | `flowSwing.*` | Real-time non-isochronous-grid time-warping and sample-accurate sequencing (FluCoMa optional) | `flowSwing.audioWarp`, `flowSwing.onsetDetect`, `flowSwing.stepUI`, `flowSwing.subDiv` | Package Manager |
| FluCoMa | `fluid.*` | Audio analysis, decomposition, ML | `fluid.mfcc`, `fluid.hpss~`, `fluid.mlpclassifier` | Package Manager |
| grainflow | `grainflow.*` | Multichannel granulation toolkit (mc.* paradigm) | `grainflow.live~`, `grainflow.scrubSynth~`, `grainflow.synth~`, `grainflow.streams~` | Package Manager |
| IRCAM Spat | `spat5.*` | Spatial audio, ambisonics | `spat5.panoramix`, `spat5.binaural~` | IRCAM Forum download |
| ml-lib | `ml.*` | Supervised/sequence ML (older lib) | `ml.svm`, `ml.knn`, `ml.adaboost`, `ml.gmm`, `ml.hmmc` | Package Manager |
| ml.star | `ml.*` | Unsupervised ML for real-time interactive music/video (different package from ml-lib, see warning below) | `ml.mlp`, `ml.fcm`, `ml.markov`, `ml.kdtree`, `ml.som` | Package Manager |
| nn_tilde | `nn~`, `mc.nn~`, `mcs.nn~`, `nn.info` | Neural audio synthesis via PyTorch models (requires libtorch + `.ts` model file) | `nn~`, `mc.nn~`, `nn.info` | Package Manager |
| Odot | `o.*` | OSC bundle expressions | `o.pack`, `o.route`, `o.expr.codebox` | Package Manager |
| Rhythmic Time Toolkit | `rtk.*` | Signal-rate sequencing | `rtk.seq~`, `rtk.clock~` | Package Manager |

### Workflow Templates

Structured workflow templates for community packages are maintained in agent SKILL.md files:

- **FluCoMa** (real-time analysis, offline buffer processing, ML classification): `.claude/skills/max-dsp-agent/SKILL.md` > Package Workflow Templates
- **Bach** (llll construction, notation display, algorithmic composition): `.claude/skills/max-patch-agent/SKILL.md` > Package Workflow Templates

### Data Type Warnings

- **Bach llll**: Bach, Cage, Dada, EARS all use the llll (Lisp-like linked list) data type. lllls are NOT compatible with standard MAX lists. Use `bach.list2llll` / `bach.llll2list` for conversion. Never connect a regular MAX list outlet to a bach object expecting llll input.
- **Odot bundles**: Odot objects pass OSC bundles, not standard MAX messages. Use `o.pack` to create bundles and `o.route` to extract values.
- **FluCoMa buf* objects**: Offline buffer processors (no `~` suffix) operate asynchronously -- they output bang when done, not immediate results.
- **ml-lib vs ml.star prefix collision**: Both packages use the `ml.*` namespace but ship different objects (ml-lib has supervised classifiers like `ml.svm`/`ml.knn`/`ml.adaboost`; ml.star has unsupervised algorithms like `ml.mlp`/`ml.fcm`/`ml.markov`). No object names overlap, but `ObjectDatabase.lookup("ml.foo")` only resolves to whichever package owns that specific name -- check the `package` field on the returned entry to confirm which library you're invoking.
- **cv.jit Jitter matrices**: All cv.jit objects consume and emit Jitter `jit_matrix` messages, not audio signals. Use `jit.matrix` to bridge between `jit.grab` / `jit.movie` sources and cv.jit processors.
- **catart-mubu MuBu dependency**: catart-mubu requires the MuBu package (separate install) for its `mubu` and `imubu` containers. Without MuBu, the `camu.imubu.*` and `camu.input.*` objects will not instantiate.
- **nn_tilde model files**: `nn~` and its mc/mcs variants require a PyTorch `.ts` (TorchScript) model file at instantiation: `nn~ <path-to-model.ts> <method-name>`. Without a valid model, the object reports an error and produces silence. Models are loaded async; `nn.info` queries metadata about a loaded model.
- **grainflow multichannel**: grainflow objects use Max's `mc.*` multichannel paradigm. Inputs/outputs are `multichannelsignal` -- pack/unpack with `mc.pack~` / `mc.unpack~` to interop with mono signal chains.
- **ABL Effect Modules are bpatchers**: Each `Abl.*~` object is a `.maxpat` abstraction designed to be loaded via `bpatcher Abl.<Name>~` (not as a newobj alone). They expect Live-style modulation and depend on the bundled `ableton-dsp` package (`abl.*` primitives) for their internal DSP.

### Extraction Command

After installing a package, extract its objects for the framework. The script auto-detects pipeline (XML refpages vs `.maxpat` abstractions) and writes/merges into `packages/<name>/objects.json`, then updates `package_info.json`:

```bash
# Standard install location (~/Documents/Max 9/Packages/<name>):
python .claude/scripts/extract_objects.py --package "PackageName"

# Custom path (e.g., a local copy for audit, or a non-standard install):
python .claude/scripts/extract_objects.py --package "PackageName" --path /path/to/package-folder
```

**Abstraction-only packages** (no `.maxref.xml` refpages -- e.g., ABL Effect Modules, catart-mubu, cv.jit) are not handled by `extract_objects.py`. For those, parse inlet/outlet boxes directly from the `.maxpat` files in the package's `patchers/` directory or from the corresponding `.maxhelp` files. See the procedure used in `.planning/quick/260416-vji-audit-and-update-db-for-15-installed-max/260416-vji-SUMMARY.md`.
