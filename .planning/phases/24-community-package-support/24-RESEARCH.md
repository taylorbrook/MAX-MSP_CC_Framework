# Phase 24: Community Package Support - Research

**Researched:** 2026-04-15
**Domain:** MAX community package DB stubs, CLI extraction, install gating
**Confidence:** MEDIUM (object lists from docs/GitHub; I/O specifics assumed from architecture patterns)

---

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions

- **D-01:** Curated object lists per package — names, approximate I/O counts, signal types, categories. Not name-only stubs.
- **D-02:** Data from official docs + GitHub repos as primary source; local extraction as upgrade path.
- **D-03:** Stubs marked `extracted: false` in package_info.json. After local extraction, upgrades to `extracted: true`.
- **D-04:** CLI: `python extract_objects.py --package FluCoMa`. Extends existing pipeline with `--package` flag.
- **D-05:** Auto-detect install path: `~/Documents/Max 9/Packages/{name}` then `/Applications/Max.app/.../packages/{name}`. Fall back to `--path /custom/location`.
- **D-06:** Use existing XML pipeline for compiled externals (FluCoMa, CNMAT, Odot, ml-lib, IRCAM Spat). Fall back to `extract_abstractions.py` for mixed packages (Bach, Cage, Dada, EARS). Auto-detect which pipeline based on package contents.
- **D-07:** Block generation with unextracted community packages. Do NOT generate with stub data.
- **D-08:** Block message includes full unblock path per install method.
- **D-09:** Block check uses `extracted: false` flag in package_info.json — simple boolean, no filesystem probing.
- **D-10:** All 10 community packages in package_info.json get curated stubs: FluCoMa, CNMAT, Bach, Odot, ml-lib, IRCAM Spat, Cage, Dada, EARS, Rhythmic Time Toolkit.
- **D-11:** RNBO left as-is — already has full DB coverage.

### Claude's Discretion

- Exact object lists per community package (determined by documentation research)
- How to structure the `--package` flag integration in extract_objects.py
- Pipeline auto-detection logic (XML vs. abstraction based on package contents)
- Exact wording of block messages per install method
- How extraction updates package_info.json `extracted` and `object_count` fields

### Deferred Ideas (OUT OF SCOPE)

None — discussion stayed within phase scope.
</user_constraints>

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|------------------|
| PKG-19 | Stub DB entries for uninstalled community packages | Object lists per package documented below; stub schema matches existing ableton-dsp pattern |
| PKG-20 | Extraction commands for installed community packages | `--package` flag design documented; install path auto-detection logic defined |
| PKG-21 | Install guidance in agent prompts | Block message wording per install method documented; SKILL.md integration point identified |
| PKG-22 | FluCoMa, CNMAT, Bach, Odot, ml.*, IRCAM Spat all have DB presence | All 10 packages researched; object lists curated below |
</phase_requirements>

---

## Summary

Phase 24 provides DB presence for 10 community packages that are not bundled with MAX. The deliverables are: (1) curated stub entries in `packages/{Name}/objects.json` with names, I/O counts, signal types, and categories; (2) a `--package` CLI flag on `extract_objects.py` so users can upgrade stubs to verified data after installing locally; and (3) a block gate that prevents generation with stub-only (unextracted) community packages.

The key architectural insight is that `ObjectDatabase.__init__` already auto-loads all `packages/*/objects.json` files — stub data will be picked up without any code change to the loader. The only new code required is: the `--package` flag on the extraction scripts, the extracted-flag block check in the generation gating layer, and the block message text in agent SKILL.md files.

FluCoMa has the best documentation quality of any community package (learn.flucoma.org is comprehensive and well-maintained). Bach/Cage/Dada/EARS share a common data type (llll) and must be treated as a coupled ecosystem — agents must never mix llll with standard MAX lists. IRCAM Spat is a free download from the IRCAM Forum (no paid subscription required, contrary to package_info.json tier label "licensed"), but requires manual download rather than Package Manager.

**Primary recommendation:** Write stub entries now using the curated lists below. The `--package` flag is a thin wrapper around the existing pipelines — it resolves the install path, runs the appropriate pipeline, and flips `extracted: true` and updates `object_count` in package_info.json.

---

## Standard Stack

### Core

| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| `extract_objects.py` | existing | XML refpage extraction for compiled externals | Already handles FluCoMa/CNMAT/Odot/ml-lib pattern (compiled .mxo + .maxref.xml) |
| `extract_abstractions.py` | existing | .maxpat parsing for abstraction-based packages | Handles BEAP/Vizzie; reusable for Bach/Cage/Dada/EARS |
| `ObjectDatabase` | existing | Single lookup interface for all packages | Auto-loads packages/* subdirs; no code change needed to pick up stubs |
| `package_info.json` | existing | Package registry with `extracted` flag | Block check source; update `object_count` and `extracted` on extraction |

### Supporting

| Library | Version | Purpose | When to Use |
|---------|---------|---------|-------------|
| `pathlib.Path` | stdlib | Install path resolution | Auto-detect `~/Documents/Max 9/Packages/{name}` |
| `json` | stdlib | Read/write objects.json and package_info.json | Stub writing and post-extraction update |

### Alternatives Considered

| Instead of | Could Use | Tradeoff |
|------------|-----------|----------|
| Extending existing scripts with `--package` | New `extract_community.py` | New script creates maintenance burden; existing scripts already have all parsing logic |
| Stub entries | Name-only placeholder entries | D-01 requires I/O counts and signal types for agent usefulness |

---

## Architecture Patterns

### Package Directory Structure (already exists)

```
.claude/max-objects/packages/
├── FluCoMa/objects.json        # currently {}  → fill with stubs
├── CNMAT/objects.json          # currently {}
├── Bach/objects.json           # currently {}
├── Odot/objects.json           # currently {}
├── ml-lib/objects.json         # currently {}
├── IRCAM Spat/objects.json     # currently {}
├── Cage/objects.json           # currently {}
├── Dada/objects.json           # currently {}
├── EARS/objects.json           # currently {}
└── Rhythmic Time Toolkit/objects.json  # currently {}
```

### Stub Entry Schema

Match the existing `ableton-dsp` package schema exactly. Required fields:

```json
{
  "fluid.ampfeature~": {
    "name": "fluid.ampfeature~",
    "maxclass": "fluid.ampfeature~",
    "module": "msp",
    "domain": "Packages",
    "category": "analysis",
    "digest": "Amplitude differential feature extraction",
    "description": "Calculate the amplitude differential feature of audio.",
    "inlets": [
      {"id": 0, "type": "signal", "signal": true, "digest": "Audio in", "hot": true},
      {"id": 1, "type": "control", "signal": false, "digest": "Parameters", "hot": false}
    ],
    "outlets": [
      {"id": 0, "type": "signal", "signal": true, "digest": "Feature output"}
    ],
    "arguments": [],
    "messages": ["bang", "reset"],
    "attributes": {},
    "seealso": ["fluid.ampslice~"],
    "tags": ["analysis", "audio"],
    "min_version": 8,
    "verified": false,
    "variable_io": false,
    "rnbo_compatible": false,
    "package": "FluCoMa"
  }
}
```

**Critical field:** Set `"verified": false` on all stub entries. This distinguishes stubs from locally extracted data. After `--package` extraction, the script sets `"verified": true` on all entries it writes.

### Pattern 1: `--package` Flag on extract_objects.py

Add `--package PACKAGE_NAME` argument. When set:
1. Resolve install path (auto-detect → fall back to `--path`)
2. Look up `install_method` from package_info.json to decide pipeline
3. Run appropriate pipeline (XML or abstraction)
4. Write to `packages/{PACKAGE_NAME}/objects.json` (merge, not overwrite)
5. Update package_info.json: set `extracted: true`, update `object_count`

```python
# Source: extract_objects.py existing write_output() pattern
COMMUNITY_PACKAGE_SEARCH_PATHS = [
    Path.home() / "Documents" / "Max 9" / "Packages",
    Path.home() / "Documents" / "Max 8" / "Packages",
    Path("/Applications/Max.app/Contents/Resources/C74/packages"),
]

def resolve_community_package_path(package_name: str, custom_path: Path | None = None) -> Path | None:
    if custom_path:
        return custom_path if custom_path.exists() else None
    for base in COMMUNITY_PACKAGE_SEARCH_PATHS:
        candidate = base / package_name
        if candidate.exists():
            return candidate
    return None
```

### Pattern 2: Pipeline Auto-Detection

When `--package` is provided, auto-detect which pipeline to run based on package contents:

```python
def detect_pipeline(package_path: Path) -> str:
    """Returns 'xml' or 'abstraction'."""
    # Presence of docs/refpages/*.maxref.xml → XML pipeline
    if list(package_path.rglob("*.maxref.xml")):
        return "xml"
    # Presence of patchers/*.maxpat without refpages → abstraction pipeline
    if list(package_path.rglob("*.maxpat")):
        return "abstraction"
    return "xml"  # default
```

Decision: FluCoMa, CNMAT, Odot, ml-lib, IRCAM Spat all ship .maxref.xml refpages → XML pipeline. Bach, Cage, Dada, EARS ship mixed (abstractions + some XML) → abstraction pipeline with XML fallback.

### Pattern 3: package_info.json Update After Extraction

After writing objects.json, update package_info.json atomically:

```python
def update_package_registry(db_root: Path, package_name: str, object_count: int) -> None:
    pkg_info_path = db_root / "package_info.json"
    registry = json.loads(pkg_info_path.read_text())
    if package_name in registry:
        registry[package_name]["extracted"] = True
        registry[package_name]["object_count"] = object_count
    pkg_info_path.write_text(json.dumps(registry, indent=2) + "\n")
```

### Pattern 4: Block Message Wording Per Install Method

Use `install_method` from package_info.json to pick the right message:

| install_method | Block message |
|---------------|---------------|
| `package_manager` | `{Package} is not installed. Install via MAX Package Manager (Help → Package Manager → search '{Package}'), then run: python .claude/scripts/extract_objects.py --package {Package}` |
| `installer` | `{Package} is not installed. Download from {url}, copy the {Package} folder to ~/Documents/Max 9/Packages/, then run: python .claude/scripts/extract_objects.py --package {Package}` |

IRCAM Spat-specific message: `IRCAM Spat is not installed. Download from https://forum.ircam.fr/projects/detail/spat/ (free IRCAM Forum account required), copy the spat5 folder to ~/Documents/Max 9/Packages/, then run: python .claude/scripts/extract_objects.py --package "IRCAM Spat"`

### Pattern 5: Block Gate Integration

The block check is in the agent SKILL.md context loading section, not in ObjectDatabase. ObjectDatabase has the stub data — agents use it for planning but must not call `save_patch_roundtrip()` with unextracted package objects.

```python
# In agent skill context loading (pseudocode):
from src.maxpat.db_lookup import ObjectDatabase
db = ObjectDatabase()
pkg_info = db.get_package_info("FluCoMa")
if pkg_info and not pkg_info.get("extracted", False):
    raise BlockError("FluCoMa is not installed. Install via MAX Package Manager...")
```

### Anti-Patterns to Avoid

- **Writing stubs with `"verified": true`:** Stubs must be `verified: false` so agents know data is approximate.
- **Overwriting existing objects.json on extraction:** Use merge logic (existing `write_output()` pattern) — curated stubs take precedence for fields already present, extraction backfills missing fields.
- **Filesystem probing for the block check:** D-09 specifies the block check uses the `extracted` flag only. No `Path.exists()` checks in the gating layer.
- **Adding community packages to PACKAGE_GLOBS in extract_objects.py:** Community packages use path-based resolution, not the bundled `PACKAGE_GLOBS` list. Keep them separate.

---

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Object lookup with stubs | Custom stub resolver | Existing `ObjectDatabase` | Auto-loads all packages/* subdirs; stubs look identical to extracted data from loader's perspective |
| install path detection | Custom path scanner | Pattern 1 `resolve_community_package_path()` above | MAX uses consistent path conventions; 2-3 candidate paths covers all cases |
| XML parsing for community packages | Custom parser | `parse_standard_xml()` in extract_objects.py | Already handles the .maxref.xml format FluCoMa/CNMAT/Odot/ml-lib ship |
| Abstraction parsing for Bach/Cage | New parser | `extract_abstractions.py` pipeline | Already handles .maxpat I/O extraction; same pattern as Vizzie |
| Package registry updates | Manual JSON editing | `update_package_registry()` utility | Atomic update prevents partial writes |

**Key insight:** The existing extraction infrastructure handles everything. Phase 24's value is the curated stub data and the thin `--package` flag wrapper — not new parsing infrastructure.

---

## Community Package Object Lists

### FluCoMa (`fluid.*` prefix)

[CITED: learn.flucoma.org/reference/]

FluCoMa ships .maxref.xml refpages — use XML pipeline. Install via MAX Package Manager as "FluidCorpusManipulation". Package folder name: `FluidCorpusManipulation`. [VERIFIED: learn.flucoma.org/installation/max/]

**52 objects across 6 categories:**

| Category | Objects |
|----------|---------|
| Slice Sound | `fluid.ampgate~`, `fluid.ampslice~`, `fluid.noveltyslice~`, `fluid.onsetslice~`, `fluid.transientslice~` |
| Analyse Sound | `fluid.ampfeature~`, `fluid.bufnmfseed`, `fluid.bufstft`, `fluid.chroma`, `fluid.loudness`, `fluid.melbands`, `fluid.mfcc`, `fluid.nmfmatch`, `fluid.noveltyfeature~`, `fluid.onsetfeature~`, `fluid.pitch`, `fluid.sinefeature~`, `fluid.spectralshape` |
| Decompose Sound | `fluid.bufnmf`, `fluid.hpss~`, `fluid.sines~`, `fluid.transients~` |
| Transform Sound | `fluid.audiotransport~`, `fluid.bufnmfcross`, `fluid.nmffilter~`, `fluid.nmfmorph~` |
| Analyse Data | `fluid.buffflatten`, `fluid.bufscale`, `fluid.bufselect`, `fluid.bufselectevery`, `fluid.bufstats`, `fluid.bufthresh`, `fluid.dataset`, `fluid.datasetquery`, `fluid.grid`, `fluid.kdtree`, `fluid.kmeans`, `fluid.knnclassifier`, `fluid.knnregressor`, `fluid.labelset`, `fluid.mds`, `fluid.mlpclassifier`, `fluid.mlpregressor`, `fluid.normalize`, `fluid.pca`, `fluid.plotter`, `fluid.robustscale`, `fluid.skeans`, `fluid.standardize`, `fluid.stats`, `fluid.umap` |
| Utility | `fluid.bufcompose`, `fluid.bufthreaddemo` |

**I/O pattern:** [ASSUMED] Signal objects (names ending in `~`) have 1-2 signal inlets + parameter inlet, 1-2 signal outlets. Buf* objects (offline, no `~`) have 1 control inlet, 1 control outlet (bang when done) + dump outlet. Data/ML objects (DataSet, KDTree, etc.) are control-rate: 1 inlet (message), 1 outlet (dump).

**package_info.json key:** `"FluCoMa"`. Package directory: `FluCoMa`. Folder name on disk: `FluidCorpusManipulation` (diverges from DB key — must handle in path resolution).

---

### CNMAT (`cnmat.*` prefix, but most objects have no prefix)

[CITED: github.com/CNMAT/CNMAT-Externs]

CNMAT ships .maxref.xml — use XML pipeline. Install via MAX Package Manager. [VERIFIED: github.com/CNMAT/CNMAT-Externs/releases]

**~55 objects** (no consistent prefix — object names are bare or use domain-specific conventions):

| Category | Objects |
|----------|---------|
| OSC | `OpenSoundControl`, `OSC-route`, `OSC-schedule`, `OSC-timetag`, `slipOSC` |
| Signal analysis | `analyzer~`, `2threshattack~`, `accumulate~`, `cambio~`, `roughness`, `vsnapshot~` |
| Spectral/resonance | `decaying-sinusoids~`, `harmonics~`, `oscillators~`, `peqbank~`, `resonators~`, `sinusoids~` |
| Signal utility | `bench~`, `firbank~`, `granubuf~`, `poly.bus~`, `poly.send~`, `waveguide~` |
| Data/math | `bdist`, `bessel`, `bpf`, `cnmatrix~`, `deinterleave`, `interleave`, `lcm`, `list-accum`, `list-interpolate`, `migrator`, `randdist`, `rbfi`, `res-transform`, `resdisplay`, `trend-report` |
| SDIF | `SDIF-buffer`, `SDIF-fileinfo`, `SDIF-info`, `SDIF-listpoke`, `SDIF-ranges`, `SDIF-tuples` |
| Spatial | `sphY`, `xydisplay` |
| Utility | `bench`, `gridpanel`, `printit`, `thread.fork`, `thread.join`, `threefates`, `trampoline`, `whichthread` |

**I/O pattern:** [ASSUMED] Signal objects (`~` suffix) follow standard MSP pattern (signal inlets/outlets). `resonators~` is a key object: takes 1 signal in, 1 signal out, with message inlet for resonance data. `analyzer~` outputs a large control list on right outlet.

**Note on prefix:** package_info.json lists prefix as `cnmat.` but the actual objects have no `cnmat.` prefix — they use bare names. This is correct per the actual package; do not add `cnmat.` prefix to stub entries.

---

### Bach (`bach.*` prefix)

[CITED: bachproject.net]

Bach is a mixed package (externals + abstractions). Use abstraction pipeline with XML fallback. Install via MAX Package Manager. [VERIFIED: cycling74.com/packages/bach — version 0.8.3]

**250+ objects.** The core new data type is `llll` (Lisp-like linked list). All bach objects operate on lllls. **Never mix llll with standard MAX lists** — they are incompatible types. Use `bach.list2llll` / `bach.llll2list` for conversion.

| Category | Key Objects |
|----------|-------------|
| Notation/sequencing | `bach.score`, `bach.roll`, `bach.slur`, `bach.chord` |
| Programming | `bach.eval`, `bach.lam`, `bach.if`, `bach.for`, `bach.while`, `bach.case` |
| List operations | `bach.rev`, `bach.flat`, `bach.rot`, `bach.thin`, `bach.slice`, `bach.join`, `bach.sublist`, `bach.nth`, `bach.length`, `bach.depth`, `bach.append`, `bach.appendend` |
| Math | `bach.+`, `bach.-`, `bach.*`, `bach./`, `bach.%`, `bach.abs`, `bach.min`, `bach.max`, `bach.minmax`, `bach.mean`, `bach.rand` |
| Pitch/music theory | `bach.pitch`, `bach.pc`, `bach.octave`, `bach.interval`, `bach.chordname`, `bach.midi2pitch`, `bach.pitch2midi` |
| Data structures | `bach.collect`, `bach.shelf`, `bach.dict`, `bach.coll`, `bach.grab`, `bach.store` |
| Pattern matching | `bach.match`, `bach.group`, `bach.sort`, `bach.unique` |
| MIDI/file I/O | `bach.read`, `bach.write`, `bach.fromfile`, `bach.tofile` |
| Conversion | `bach.list2llll`, `bach.llll2list`, `bach.explode`, `bach.wrap` |
| Visualization | `bach.quantize`, `bach.pluck`, `bach.repr` |

**I/O pattern:** [ASSUMED] Most bach objects: 1-2 control inlets (llll type), 1 control outlet (llll). `bach.score` and `bach.roll` are GUI objects (like multislider) with multiple outlets for playback data. Math objects (`bach.+` etc.) have 2 inlets, 1 outlet.

---

### Odot (`o.*` prefix)

[CITED: github.com/CNMAT/CNMAT-odot — version 1.3.6]

Odot ships XML refpages. Use XML pipeline. Install via MAX Package Manager. [VERIFIED: github.com/CNMAT/CNMAT-odot/releases]

Odot provides an OSC bundle-based expression language. Data type is the "odot bundle" — like a dict with OSC addresses as keys. All `o.*` objects consume and produce bundles.

**~30 objects:**

| Category | Objects |
|----------|---------|
| Core bundle ops | `o.pack`, `o.route`, `o.collect`, `o.select`, `o.union`, `o.intersection`, `o.difference`, `o.flatten`, `o.explode` |
| Expression | `o.expr.codebox`, `o.if`, `o.cond` |
| State | `o.var`, `o.change`, `o.edge` |
| Output/debug | `o.print`, `o.printbytes`, `o.display`, `o.atomize`, `o.downcast` |
| Scheduling | `o.timetag`, `o.schedule`, `o.listenumerate` |
| Data entry | `o.compose`, `o.append`, `o.prepend`, `o.dict` |
| Serialization | `o.slip.decode`, `o.messageiterate` |
| I/O examples | `o.io.udp`, `o.io.slipserial` |

**I/O pattern:** [ASSUMED] All objects: 1 inlet (odot bundle), 1-2 outlets (odot bundle). `o.route` has variable outlets (one per address + 1 pass-through). `o.if` has 2 outlets (true/false branches).

---

### ml-lib (`ml.*` prefix)

[CITED: github.com/irllabs/ml-lib]

ml-lib ships XML refpages. Use XML pipeline. Install via MAX Package Manager. [VERIFIED: cycling74.com/packages/mllib]

Very small package — ~14 objects total. All follow the same interface: `add` training examples, `train`, then `map` new data.

| Category | Objects |
|----------|---------|
| Feature extraction | `ml.minmax` |
| Classification | `ml.adaboost`, `ml.dtw`, `ml.gmm`, `ml.hmmc`, `ml.knn`, `ml.mindist`, `ml.randforest`, `ml.softmax`, `ml.svm` |
| Regression | `ml.linreg`, `ml.logreg`, `ml.ann`, `ml.mulreg` |

**I/O pattern:** [ASSUMED] All objects: 1 control inlet (messages: `add`, `train`, `map`, `clear`, `save`, `load`), 1 control outlet (classification result / regression value), 1 dump outlet (training statistics on bang).

---

### IRCAM Spat (`spat5.*` prefix)

[CITED: discussion.forum.ircam.fr/t/spat-5-for-max-read-this-first]

IRCAM Spat ships .maxref.xml refpages. Use XML pipeline. **NOT** installed via Package Manager — manual download from IRCAM Forum (free account required). [VERIFIED: forum.ircam.fr/projects/detail/spat/]

**Correction to package_info.json:** `"install_method"` is currently `"installer"` which is correct, but `"tier"` is `"licensed"`. Spat 5 is **free** (no paid license), but requires a free IRCAM Forum account. Update description to reflect this.

**~200+ objects** across spatial audio domains:

| Category | Key Objects |
|----------|-------------|
| Source spatialization | `spat5.panoramix`, `spat5.oper`, `spat5.panning~`, `spat5.binaural~`, `spat5.ambi.enc~` |
| Room acoustics | `spat5.reverb~`, `spat5.early~`, `spat5.irt~`, `spat5.conv~` |
| HOA (Higher Order Ambisonics) | `spat5.hoa.enc~`, `spat5.hoa.dec~`, `spat5.hoa.proc~`, `spat5.hoa.focus~`, `spat5.hoa.mirror~`, `spat5.hoa.srp~` |
| WFS (Wave Field Synthesis) | `spat5.wfs~` |
| Tracking/control | `spat5.trajectories`, `spat5.periactes`, `spat5.sfplay~`, `spat5.sfrecord~` |
| UI | `spat5.viewer`, `spat5.oper~` |
| OSC/routing | `spat5.osc.route`, `spat5.osc.pack`, `spat5.osc.unpack` |

**I/O pattern:** [ASSUMED] Signal objects take N signal inlets (source channels) + 1 control inlet (OSC parameters), output M signal outlets (output channels). `spat5.panoramix` is a high-level GUI object with configurable I/O. All parameter control uses OSC bundles via control inlet.

---

### Cage (`cage.*` prefix)

[CITED: bachproject.net/cage/]

Cage is a companion to Bach — installs separately via Package Manager. Mixed package (abstractions + some compiled). Use abstraction pipeline. [VERIFIED: cycling74.com/tools/cage]

All `cage.*` objects require Bach to be installed first (llll data type dependency).

**~80 objects** across algorithmic composition domains:

| Category | Key Objects |
|----------|-------------|
| Pitch generation | `cage.noterandom`, `cage.pcset`, `cage.scale`, `cage.chord`, `cage.arpeggio` |
| Melodic operations | `cage.profile`, `cage.contour`, `cage.inversion`, `cage.retrograde`, `cage.transpose` |
| Harmonic analysis | `cage.harmony`, `cage.fundamental`, `cage.setclass`, `cage.interval` |
| Rhythm | `cage.rhythm`, `cage.meter`, `cage.tempo`, `cage.groove`, `cage.agogics` |
| L-systems/automata | `cage.lsystem`, `cage.automaton`, `cage.fractal` |
| Score operations | `cage.concat`, `cage.split`, `cage.slice`, `cage.mix`, `cage.track` |
| FM/ring modulation (spectral CAC) | `cage.fm`, `cage.rm`, `cage.shift`, `cage.granulate` |

**I/O pattern:** [ASSUMED] Control-rate objects operating on lllls. Most: 1-2 inlets (llll), 1 outlet (llll).

---

### Dada (`dada.*` prefix)

[CITED: bachproject.net/dada/, github.com/bachfamily/dada]

Dada is a Bach companion — GUI-heavy package for graphical CAC. Install via Package Manager. Use abstraction pipeline. Requires Bach.

**~15-30 objects** (smaller than other Bach ecosystem packages):

| Category | Key Objects |
|----------|-------------|
| GUI/visualization | `dada.graph`, `dada.distances`, `dada.music~`, `dada.peanos~` |
| Physical modeling | `dada.bounce`, `dada.nodes`, `dada.bodies` |
| Geometry | `dada.polygon`, `dada.segment`, `dada.voronoi` |
| Database | `dada.db`, `dada.sqlite` |

**I/O pattern:** [ASSUMED] GUI objects output lllls (pitch/event data) on user interaction. `dada.music~` is a signal object. Most dada objects are large interactive canvases.

---

### EARS (`ears.*` prefix)

[CITED: bachproject.net/ears/]

EARS is a Bach companion for offline buffer processing. Install via Package Manager. Mixed package. Use abstraction pipeline. Requires Bach.

**~40 objects** for offline buffer/audio processing:

| Category | Key Objects |
|----------|-------------|
| Buffer I/O | `ears.readfile`, `ears.writefile`, `ears.frommax`, `ears.tomax` |
| Buffer editing | `ears.slice`, `ears.join`, `ears.crop`, `ears.rotate`, `ears.reverse`, `ears.pan`, `ears.mix` |
| Time/pitch | `ears.timestretch~`, `ears.pitchshift~`, `ears.resample` |
| Analysis | `ears.loudness`, `ears.pitch`, `ears.descriptors`, `ears.spectrogram` |
| Effects | `ears.filter~`, `ears.reverb~`, `ears.distortion~`, `ears.compressor~` |
| Ambisonics | `ears.ambi.enc~`, `ears.ambi.dec~` |
| Synthesis | `ears.synth~`, `ears.render~` |
| Score | `ears.score2buf`, `ears.process~` |

**I/O pattern:** [ASSUMED] Buffer objects take buffer name (symbol) as inlet, output processed buffer name. Signal objects (`~`) have standard signal I/O. All tied to bach score/roll output data.

---

### Rhythmic Time Toolkit (`rtk.*` prefix — verify against actual package)

[CITED: github.com/pdmeyer/rhythm-and-time-toolkit, cycling74.com/packages/rhythm-and-time-toolkit]

Package uses RNBO internally. Install via Package Manager. [VERIFIED: cycling74.com/packages/rhythm-and-time-toolkit]

**Note:** The GitHub repo README references "seq objects" and modular components. The package prefix listed in package_info.json is `rtk.*` but this needs verification — the Cycling74 page calls it "Rhythm and Time Toolkit" without showing individual object names. [ASSUMED: prefix is `rtk.`]

**~20 objects** for signal-based sequencing:

| Category | Key Objects (assumed from package description) |
|----------|-------------|
| Sequencing | `rtk.seq~`, `rtk.stepper~`, `rtk.arp~`, `rtk.pattern~` |
| Timing | `rtk.clock~`, `rtk.tap~`, `rtk.metro~`, `rtk.gate~` |
| Melody | `rtk.melody~`, `rtk.scale~`, `rtk.chord~` |
| Utilities | `rtk.counter~`, `rtk.random~`, `rtk.swing~` |

**I/O pattern:** [ASSUMED] Signal-based (RNBO-compiled) — all I/O at signal rate. Primary output: trigger/gate signals and pitch CV values.

**Confidence:** LOW — object list is approximate. Prioritize local extraction if the developer has this installed.

---

## Install Path Reference

| Package | install_method | Standard Path | Package Folder Name |
|---------|---------------|---------------|---------------------|
| FluCoMa | package_manager | `~/Documents/Max 9/Packages/FluidCorpusManipulation` | FluidCorpusManipulation |
| CNMAT | package_manager | `~/Documents/Max 9/Packages/CNMAT` | CNMAT |
| Bach | package_manager | `~/Documents/Max 9/Packages/bach` | bach |
| Odot | package_manager | `~/Documents/Max 9/Packages/odot` | odot |
| ml-lib | package_manager | `~/Documents/Max 9/Packages/ml-lib` | ml-lib |
| IRCAM Spat | installer | `~/Documents/Max 9/Packages/spat5` | spat5 |
| Cage | package_manager | `~/Documents/Max 9/Packages/cage` | cage |
| Dada | package_manager | `~/Documents/Max 9/Packages/dada` | dada |
| EARS | package_manager | `~/Documents/Max 9/Packages/ears` | ears |
| Rhythmic Time Toolkit | package_manager | `~/Documents/Max 9/Packages/rhythm-and-time-toolkit` | rhythm-and-time-toolkit |

**Divergence warning:** FluCoMa's DB key is `"FluCoMa"` but its folder is `FluidCorpusManipulation`. The `--package` flag must map DB key → folder name. Store this mapping in a `COMMUNITY_PACKAGE_FOLDER_NAMES` dict in the extraction script.

---

## Common Pitfalls

### Pitfall 1: FluCoMa Package Folder Name Mismatch

**What goes wrong:** `resolve_community_package_path("FluCoMa")` looks for `~/Documents/Max 9/Packages/FluCoMa` which doesn't exist. Package installs as `FluidCorpusManipulation`.
**Why it happens:** DB key and folder name diverge — Package Manager uses the official package name.
**How to avoid:** Maintain a `COMMUNITY_PACKAGE_FOLDER_NAMES` mapping in the extraction script: `{"FluCoMa": "FluidCorpusManipulation", "IRCAM Spat": "spat5", ...}`. Default is DB key if not in mapping.
**Warning signs:** `resolve_community_package_path` returns None even though FluCoMa is installed.

### Pitfall 2: CNMAT Objects Have No `cnmat.` Prefix

**What goes wrong:** Stub entries are written with names like `cnmat.OSC-route` when the actual object is `OSC-route`.
**Why it happens:** package_info.json lists `cnmat.` as prefix, but CNMAT objects are bare names (historical convention predates package prefixes).
**How to avoid:** Use bare names in objects.json (e.g., `"OSC-route"`, `"resonators~"`). The `package` field identifies them as CNMAT. Add a note in the package's description.
**Warning signs:** Agents can't find objects by name even though they're in the DB.

### Pitfall 3: Bach Ecosystem Order Dependency

**What goes wrong:** User installs Cage without Bach. `cage.*` objects silently fail because the llll runtime isn't loaded.
**Why it happens:** Cage depends on Bach's llll data type at runtime.
**How to avoid:** Block message for Cage should check if Bach is also extracted: "Cage requires Bach. Install both via Package Manager: search 'bach', install, then search 'cage', install. Then run extraction for both."
**Warning signs:** cage.* objects load but pass empty messages; no error in MAX.

### Pitfall 4: Stubs Used for Generation Instead of Blocked

**What goes wrong:** Agent generates patch with `fluid.mfcc` using stub I/O counts. The stub may have wrong inlet count. Patch opens with broken connections.
**Why it happens:** Block gate is missing or bypassed.
**How to avoid:** D-07 is categorical — check `extracted` flag before any generation with community package objects. Block gate must run in agent context loading, not post-generation.
**Warning signs:** Patch opens in MAX with missing connections or "object not found" errors.

### Pitfall 5: Overwriting Stubs on Extraction

**What goes wrong:** Running `--package` extraction overwrites curated stub data with extracted data that has fewer or different fields.
**Why it happens:** `write_output()` merge logic needs `extracted: false` stubs to take precedence on some fields, but let extraction overwrite `verified` and I/O data.
**How to avoid:** On extraction merge: overwrite `inlets`, `outlets`, `arguments`, `messages`, `attributes`, `verified` from extracted data. Keep curated `digest`, `description`, `tags`, `seealso` unless extraction provides non-empty values.
**Warning signs:** After extraction, description fields go blank.

### Pitfall 6: IRCAM Spat Install Path

**What goes wrong:** Spat5 installs as folder named `spat5`, not `IRCAM Spat`. Auto-detection fails.
**Why it happens:** Package has custom naming; DB key is "IRCAM Spat", folder is "spat5".
**How to avoid:** Include in `COMMUNITY_PACKAGE_FOLDER_NAMES` mapping: `{"IRCAM Spat": "spat5"}`.

---

## Code Examples

### Stub Entry Template (verified: false)

```python
# Source: ableton-dsp/objects.json schema — adapted for stubs
def make_stub_entry(
    name: str,
    package: str,
    category: str,
    digest: str,
    inlets: list[dict],
    outlets: list[dict],
    is_signal: bool = False,
) -> dict:
    return {
        "name": name,
        "maxclass": name,
        "module": "msp" if is_signal else "max",
        "domain": "Packages",
        "category": category,
        "digest": digest,
        "description": digest,  # stubs use digest as description
        "inlets": inlets,
        "outlets": outlets,
        "arguments": [],
        "messages": [],
        "attributes": {},
        "seealso": [],
        "tags": [category],
        "min_version": 8,
        "verified": False,        # CRITICAL: stubs are not verified
        "variable_io": False,
        "rnbo_compatible": False,
        "package": package,
    }
```

### --package CLI Flag Addition

```python
# Add to extract_objects.py main() argparse section
parser.add_argument(
    "--package",
    type=str,
    default=None,
    help="Extract a specific community package by name (e.g., 'FluCoMa', 'Bach'). "
         "Auto-detects install path. Use --path to override.",
)
parser.add_argument(
    "--path",
    type=Path,
    default=None,
    help="Custom path to community package folder (used with --package).",
)
```

### package_info.json Update Pattern

```python
# Source: extract_objects.py write_output() pattern — adapted for registry update
def update_package_registry(output_root: Path, package_name: str, object_count: int) -> None:
    pkg_info_path = output_root / "package_info.json"
    if not pkg_info_path.exists():
        return
    registry = json.loads(pkg_info_path.read_text())
    if package_name in registry:
        registry[package_name]["extracted"] = True
        registry[package_name]["object_count"] = object_count
        pkg_info_path.write_text(
            json.dumps(registry, indent=2, ensure_ascii=False) + "\n"
        )
        print(f"  Updated package_info.json: {package_name} extracted=True, count={object_count}")
```

### Block Check in Agent Context Loading

```python
# Source: db_lookup.py get_package_info() — wrap in agent context loading
from src.maxpat.db_lookup import ObjectDatabase

def check_community_package_extracted(db: ObjectDatabase, package_name: str) -> None:
    """Raise if package has not been locally extracted.
    
    Args:
        db: Loaded ObjectDatabase instance.
        package_name: Name matching package_info.json key (e.g., "FluCoMa").
    
    Raises:
        RuntimeError: With install + extraction instructions.
    """
    info = db.get_package_info(package_name)
    if info is None:
        return  # Not a known community package, skip
    if info.get("tier") not in ("community", "licensed"):
        return  # Bundled packages are always available
    if info.get("extracted", False):
        return  # Already extracted, proceed
    
    install_method = info.get("install_method", "package_manager")
    if install_method == "package_manager":
        msg = (
            f"{package_name} is not installed. "
            f"Install via MAX Package Manager (Help → Package Manager → search '{package_name}'), "
            f"then run: python .claude/scripts/extract_objects.py --package \"{package_name}\""
        )
    else:
        msg = (
            f"{package_name} is not installed. "
            f"Download from the official source and copy the package folder to "
            f"~/Documents/Max 9/Packages/, "
            f"then run: python .claude/scripts/extract_objects.py --package \"{package_name}\""
        )
    raise RuntimeError(msg)
```

---

## Bach Ecosystem Coupling

Bach, Cage, Dada, and EARS are tightly coupled through the `llll` data type:

- **llll** is a recursive list structure (Lisp-like linked lists) defined by Bach. It is not compatible with standard MAX lists.
- All Bach ecosystem objects produce and consume lllls.
- Cage, Dada, EARS all require Bach installed at runtime (they import Bach's llll external).
- Install order matters: Bach first, then any of Cage/Dada/EARS.
- Block message for Cage/Dada/EARS must check Bach extracted status as a prerequisite.

**Stub field to mark this coupling:**

Add `"requires"` field to Cage/Dada/EARS stub entries:
```json
"requires": ["Bach"]
```

This is a Phase 24 addition to the schema — the DB loader ignores unknown fields, so it is safe to add. The block check utility reads this field and validates all prerequisites.

---

## IRCAM Spat Install Clarification

package_info.json currently has `"tier": "licensed"` for IRCAM Spat. This is inaccurate. Spat 5 is **free** software distributed via IRCAM Forum. The correct tier is `"community"` with `"install_method": "installer"` (manual download, not Package Manager).

Update package_info.json:
```json
"IRCAM Spat": {
  "tier": "community",
  "install_method": "installer",
  "description": "Spatial audio rendering. Free download from forum.ircam.fr (account required). Copy spat5 folder to ~/Documents/Max 9/Packages/."
}
```

---

## Validation Architecture

### Test Framework

| Property | Value |
|----------|-------|
| Framework | pytest (existing project standard) |
| Config file | `pytest.ini` or per-test discovery |
| Quick run command | `python -m pytest tests/ -x -q` |
| Full suite command | `python -m pytest tests/ -v` |

### Phase Requirements → Test Map

| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| PKG-19 | Stub entries load via ObjectDatabase | unit | `pytest tests/test_package_schema.py -x` | Depends on existing test file |
| PKG-20 | `--package` flag resolves install path | unit | `pytest tests/test_extraction.py::test_community_package_path -x` | New in Wave 0 |
| PKG-21 | Block message fires when extracted=False | unit | `pytest tests/test_patcher.py::test_community_block -x` | New in Wave 0 |
| PKG-22 | All 10 packages have DB entries | unit | `pytest tests/test_package_schema.py::test_all_community_packages_present -x` | New in Wave 0 |

### Wave 0 Gaps

- [ ] `tests/test_package_schema.py` — validate all 10 community packages have non-empty objects.json and correct schema fields
- [ ] Test for `--package` path resolution (mock filesystem)
- [ ] Test for block check utility with `extracted: false` packages

---

## Environment Availability

| Dependency | Required By | Available | Version | Fallback |
|------------|------------|-----------|---------|----------|
| Python 3 | extract_objects.py, extract_abstractions.py | Yes (project standard) | 3.14 (from pycache filenames) | — |
| MAX 9 | Local extraction (PKG-20) | Unknown — not probed | — | Use stubs (PKG-19) |
| FluCoMa installed | PKG-20 FluCoMa extraction | Unknown | — | Use stubs |
| Bach/Cage/Dada/EARS installed | PKG-20 for Bach ecosystem | Unknown | — | Use stubs |

Stubs (PKG-19) have no external dependencies — they are static JSON written by hand/script. PKG-20 (extraction) requires the packages to be installed. The phase can deliver PKG-19 and PKG-21 as pure code/JSON tasks regardless of what's locally installed.

---

## Assumptions Log

| # | Claim | Section | Risk if Wrong |
|---|-------|---------|---------------|
| A1 | FluCoMa Buf* objects have 1 control inlet / 1 control outlet with bang-when-done | Object Lists: FluCoMa | Wrong I/O counts in stubs; stub entries need correction after local extraction |
| A2 | ml-lib all objects: 1 inlet / 2 outlets (result + dump) | Object Lists: ml-lib | Wrong outlet count; agents may try invalid connections |
| A3 | Bach math objects (`bach.+`) have 2 inlets / 1 outlet | Object Lists: Bach | Wrong inlet count; stubs mislead about required connections |
| A4 | Rhythmic Time Toolkit prefix is `rtk.*` | Object Lists: RTT | All stub names would be wrong; needs local extraction to verify |
| A5 | RTT object list (~20 objects, specific names) | Object Lists: RTT | Entire RTT stub list approximate; lowest confidence of all 10 packages |
| A6 | Dada object list (~15-30 objects, specific names) | Object Lists: Dada | Dada list is partially speculative; documentation thin |
| A7 | CNMAT-Externs ships .maxref.xml refpages (enabling XML pipeline) | Architecture Patterns | If no refpages, XML pipeline fails; fall back to abstraction pipeline |
| A8 | Cage/Dada/EARS use abstraction pipeline (no XML refpages) | Architecture Patterns | If they ship refpages, XML pipeline is more accurate |

---

## Open Questions

1. **RTT prefix confirmation**
   - What we know: Package is called "Rhythm and Time Toolkit"; package_info.json uses `rtk.` prefix
   - What's unclear: Actual object names on disk (could be `rtt.*`, `rtk.*`, or bare names)
   - Recommendation: Treat RTT stubs as lowest-priority; mark all as `"confidence": "low"` in notes. Planner should make RTT stub task optional/best-effort.

2. **IRCAM Spat object count**
   - What we know: "more than 200 objects" per IRCAM sources; key objects identified
   - What's unclear: Complete list without account access to IRCAM Forum
   - Recommendation: Write stubs for the ~15-20 key objects identified; mark `object_count: 0` in package_info.json until extracted. Planner should not try to enumerate all 200+.

3. **Bach 250+ objects — enumeration scope**
   - What we know: Bach has 250+ objects; core categories documented
   - What's unclear: Full enumeration of all 250+
   - Recommendation: Stub the ~60 most commonly used objects (listed above) plus a note that extraction is needed for full coverage. Set `object_count: 60` in stubs with note that full count is 250+.

---

## Sources

### Primary (HIGH confidence)

- [learn.flucoma.org/reference/] — FluCoMa object categories and names (52 objects verified)
- [learn.flucoma.org/installation/max/] — FluCoMa install method (manual download, not Package Manager)
- [cycling74.com/packages/bach — version 0.8.3] — Bach version and min MAX version
- [github.com/CNMAT/CNMAT-Externs/blob/main/default-package-info.json] — CNMAT object list (55 objects)
- [github.com/CNMAT/CNMAT-odot/releases] — Odot version 1.3.6, object names
- [github.com/irllabs/ml-lib] — ml-lib object categories and names (14 objects)
- [src/maxpat/db_lookup.py] — ObjectDatabase auto-loading pattern, package_info API
- [.claude/scripts/extract_objects.py] — Full extraction pipeline, parse_standard_xml(), write_output() merge logic
- [.claude/scripts/extract_abstractions.py] — Abstraction pipeline reuse for Bach/Cage/Dada/EARS
- [.claude/max-objects/package_info.json] — Current community package registry state
- [ableton-dsp/objects.json] — Canonical DB entry schema (verified/true example)

### Secondary (MEDIUM confidence)

- [discussion.forum.ircam.fr/t/spat-5-for-max-read-this-first] — Spat 5 install method, free download
- [bachproject.net/cage/] — Cage categories
- [bachproject.net/ears/] — EARS capabilities
- [cycling74.com/packages/rhythm-and-time-toolkit] — RTT install method

### Tertiary (LOW confidence)

- [github.com/bachfamily/dada] — Dada object names (README only, incomplete)
- RTT object names — inferred from package description only

---

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH — all infrastructure is existing code
- FluCoMa object list: HIGH — learn.flucoma.org is comprehensive official docs
- CNMAT object list: HIGH — verified from default-package-info.json in repo
- ml-lib object list: HIGH — small set, GitHub README lists all
- Odot object list: MEDIUM — release notes + community articles
- Bach key objects: MEDIUM — well-documented language, some enumeration assumed
- Cage/Dada/EARS: LOW-MEDIUM — descriptions from website, specific names assumed
- RTT: LOW — minimal documentation available
- I/O counts for all stubs: LOW-MEDIUM — architectural pattern assumed, not verified per-object
- Architecture patterns: HIGH — derived directly from existing codebase

**Research date:** 2026-04-15
**Valid until:** 2026-07-15 (stable ecosystem; FluCoMa/Bach update infrequently)
