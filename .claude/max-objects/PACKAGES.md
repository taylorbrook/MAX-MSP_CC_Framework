# Package Reference

Shared reference for all agents when generating patches with bundled package objects. For individual object details (inlets, outlets, arguments, messages), use `ObjectDatabase.lookup(name)`.

## Scope

Bundled packages only: BEAP, Vizzie, jit.mo, Jitter Geometry, Jitter Tools, ableton-dsp, Mira, maxforlive-elements.

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

Look up individual objects with `ObjectDatabase.lookup(name)` for inlet/outlet details.

## Community Packages

Community packages require separate installation and extraction before generation. Agents must check `extracted` flag in package_info.json before using any community package objects.

### Package Reference

| Package | Prefix | Domain | Key Objects | Install |
|---------|--------|--------|-------------|---------|
| FluCoMa | `fluid.*` | Audio analysis, decomposition, ML | `fluid.mfcc`, `fluid.hpss~`, `fluid.mlpclassifier` | Package Manager |
| CNMAT | *(bare names)* | OSC, resonance, spectral | `resonators~`, `analyzer~`, `peqbank~` | Package Manager |
| Bach | `bach.*` | Algorithmic composition (llll data type) | `bach.score`, `bach.roll`, `bach.eval` | Package Manager |
| Odot | `o.*` | OSC bundle expressions | `o.pack`, `o.route`, `o.expr.codebox` | Package Manager |
| ml-lib | `ml.*` | Machine learning | `ml.svm`, `ml.ann`, `ml.knn` | Package Manager |
| IRCAM Spat | `spat5.*` | Spatial audio, ambisonics | `spat5.panoramix`, `spat5.binaural~` | IRCAM Forum download |
| Cage | `cage.*` | Algorithmic composition (requires Bach) | `cage.profile`, `cage.lsystem` | Package Manager |
| Dada | `dada.*` | Graphical CAC (requires Bach) | `dada.graph`, `dada.bounce` | Package Manager |
| EARS | `ears.*` | Offline buffer processing (requires Bach) | `ears.slice`, `ears.filter~` | Package Manager |
| Rhythmic Time Toolkit | `rtk.*` | Signal-rate sequencing | `rtk.seq~`, `rtk.clock~` | Package Manager |

### Data Type Warnings

- **Bach llll**: Bach, Cage, Dada, EARS all use the llll (Lisp-like linked list) data type. lllls are NOT compatible with standard MAX lists. Use `bach.list2llll` / `bach.llll2list` for conversion. Never connect a regular MAX list outlet to a bach object expecting llll input.
- **Odot bundles**: Odot objects pass OSC bundles, not standard MAX messages. Use `o.pack` to create bundles and `o.route` to extract values.
- **FluCoMa buf* objects**: Offline buffer processors (no `~` suffix) operate asynchronously -- they output bang when done, not immediate results.

### Extraction Command

After installing a package, extract its objects for the framework:
```
python .claude/scripts/extract_objects.py --package "PackageName"
```
