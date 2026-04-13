# Technology Stack: Package Integration

**Project:** MAX Package Integration Milestone
**Researched:** 2026-04-12
**Overall Confidence:** HIGH

## Executive Summary

Package integration extends the existing 2,015-object knowledge base to cover MAX packages -- from bundled Tier 1 (BEAP, Vizzie, Jitter Geometry, Jitter Tools) to community Tier 2 (FluCoMa, CNMAT, Bach, etc.). The core question: what stack additions are needed for extraction, registry, filtering, and validation of package objects?

**Answer: Zero new external dependencies.** The existing Python stdlib + extraction script (`extract_objects.py`) + ObjectDatabase already handle 90% of the work. What changes is (1) the extraction script needs a second extraction path for bpatcher abstractions (BEAP/Vizzie have zero `.maxref.xml` files), (2) the ObjectDatabase needs a `package` field and filtering API, and (3) the registry needs a per-package metadata format for permission gating.

The two package types require fundamentally different extraction strategies:
- **XML-documented packages** (Jitter Geometry: 27 refs, Jitter Tools: 99 refs, RNBO: 560 refs): Existing `extract_objects.py` handles these already. Add the package source dirs to `SOURCE_DIRS` / `PACKAGE_GLOBS`.
- **Bpatcher abstractions** (BEAP: 168 modules, Vizzie: 110 modules): No XML refs exist. I/O metadata must be extracted by parsing `.maxpat` JSON -- counting `inlet`/`outlet` boxes inside embedded or referenced patchers, reading `comment` attributes for digest text.

## Recommended Stack: No New Libraries

### What Already Works

| Capability | Current Module | Status | Package Integration Change |
|------------|---------------|--------|---------------------------|
| XML ref extraction | `.claude/scripts/extract_objects.py` | Working | Add package source dirs |
| Object storage | `.claude/max-objects/{domain}/objects.json` | Working | Expand `packages/` or add per-package dirs |
| Object lookup | `db_lookup.py` ObjectDatabase | Working | Add `package` field filter, `list_packages()` |
| Object validation | `validation.py` Layer 2 | Working | Package-aware existence checks |
| Connection validation | `validation.py` Layer 3 | Working | No change (uses DB I/O counts) |
| Object schema | `test_object_schema.py` | Working | Schema unchanged |

### What Needs to Be Added (All In-House)

| New Capability | Module | Purpose | Complexity |
|----------------|--------|---------|------------|
| Bpatcher abstraction extractor | Extend: `extract_objects.py` | Parse .maxpat JSON for I/O from inlet/outlet boxes | Medium |
| Package registry format | New: `.claude/max-objects/packages/registry.json` | Per-package metadata: name, tier, version, license, installed path | Low |
| ObjectDatabase filter API | Extend: `db_lookup.py` | `lookup(name, packages=["BEAP"])`, `list_packages()`, `objects_in_package()` | Low |
| Package scanner | New function in `extract_objects.py` | Discover installed packages from MAX package dirs | Low |
| Per-patch package permissions | New field in project `context.md` or `status.md` | List of allowed packages per project | Low |

## Detailed Stack Decisions

### Decision 1: Two-Path Extraction (XML + Bpatcher Parsing)

**Recommendation:** Extend `extract_objects.py` with a second extraction function for `.maxpat`-based abstractions. Keep the existing XML extraction for packages that have `.maxref.xml` files.

**Evidence from disk analysis:**

| Package | `.maxref.xml` Count | Module Type | Extraction Path |
|---------|---------------------|-------------|-----------------|
| Jitter Geometry | 27 | Compiled externals + abstractions | Existing XML parser |
| Jitter Tools | 99 | Compiled externals (`.mxo`) + abstractions | Existing XML parser |
| BEAP | 0 | Bpatcher clippings (167 embedded, 1 file-ref) | **New: .maxpat parser** |
| Vizzie | 0 | Bpatcher clippings (0 embedded, 110 file-refs) | **New: .maxpat parser** |
| Gen | 194 | Gen patchers | Already extracted |
| RNBO | 560 | RNBO objects | Already extracted |

**Bpatcher extraction algorithm:**

```
For each clipping .maxpat in package/clippings/:
  1. Load JSON, find the bpatcher box
  2. IF embedded (has 'patcher' key):
     - Count inlet/outlet~ boxes in inner patcher
     - Read 'comment' attribute from inlet/outlet boxes for digest
  3. ELSE (file reference via 'name' key):
     - Resolve reference file from package/patchers/
     - Count inlet/outlet boxes in referenced patcher
     - Read 'comment' attributes for digest
  4. Extract: name, category (from dir path), inlets, outlets, signal types
  5. Output to standard object schema format
```

BEAP modules are 99.4% embedded (167/168). Vizzie is 100% file-referenced. Both patterns must be handled.

**Inlet comment attributes** are the key source of digest text. Verified on disk:
- BEAP inlets: `comment` attribute is empty (BEAP uses presentation mode labels instead)
- Vizzie inlets: `comment` attribute has full descriptions (e.g., "Toggle mirroring", "Video output")

For BEAP, we'll need to parse presentation-mode `comment` boxes near inlet/outlet positions as a fallback.

**Complexity:** Medium. JSON parsing is trivial. The challenge is reliably associating comment text with inlet/outlet objects across both embedded and referenced patterns.

**Confidence:** HIGH -- verified by parsing 168 BEAP clippings and 110 Vizzie clippings from `/Applications/Max.app/Contents/Resources/C74/packages/`.

### Decision 2: Expand Object Schema with `package` Field

**Recommendation:** Add a `package` string field to every object. Core objects get `package: "core"`. Package objects get the package name (e.g., `"BEAP"`, `"FluCoMa"`).

**Current schema (18 fields):**
```
name, maxclass, module, domain, category, digest, description,
inlets, outlets, arguments, messages, attributes, seealso, tags,
min_version, verified, variable_io, rnbo_compatible
```

**Proposed addition:**
```
package: string  // "core" | "BEAP" | "Vizzie" | "FluCoMa" | etc.
```

This is a non-breaking addition. The `domain` field currently stores "Packages" for all package objects indiscriminately. Adding `package` enables filtering by specific package without changing `domain`.

**Migration:** Backfill existing 87 package objects (all `abl.*`, `jit.*`, `live.*`, `mira.*`) with appropriate `package` values (e.g., `"ableton-dsp"`, `"jit.mo"`, `"mira"`). Core domain objects get `package: "core"`.

**Why not use `domain` for this?** Domain is a categorical field (Max, MSP, Jitter, MC, Gen, M4L, Packages, RNBO) used for validation pipeline routing. A single package can contain objects across multiple domains (e.g., FluCoMa has both signal processing `fluid.*~` and data objects `fluid.dataset`). Keeping `domain` for type and `package` for provenance is cleaner.

**Confidence:** HIGH -- simple additive schema change.

### Decision 3: Per-Package Directory Structure (Not Flat `packages/objects.json`)

**Recommendation:** Move from a single `packages/objects.json` to per-package directories.

**Current:**
```
.claude/max-objects/packages/objects.json    # All 87 objects in one file
```

**Proposed:**
```
.claude/max-objects/packages/
  registry.json                               # Package metadata index
  ableton-dsp/objects.json                    # 74 abl.* objects
  beap/objects.json                           # ~168 bp.* objects
  vizzie/objects.json                         # ~110 vz.* objects
  jitter-geometry/objects.json                # ~27 jit.geom.* objects
  jitter-tools/objects.json                   # ~99 jit.gl.*, jit.ui.* objects
  flucoma/objects.json                        # ~60 fluid.* objects (when installed)
  cnmat/objects.json                          # ~30 objects (when installed)
  # ... more as packages are added
```

**Why per-package dirs:** Enables lazy loading (only load packages a project uses), cleaner git diffs, independent extraction per package, and permission gating at the directory level.

**Impact on ObjectDatabase._load():** Currently iterates `DOMAIN_LOAD_ORDER = ["rnbo", "packages", "m4l", ...]`. Change `"packages"` to iterate subdirectories of `packages/`, or accept a `packages` filter parameter.

**Backward compatible:** The existing `DOMAIN_LOAD_ORDER` scan just needs to walk subdirs instead of loading one file.

**Confidence:** HIGH -- directory-per-domain pattern already used for the 8 core domains.

### Decision 4: Package Registry Format (`registry.json`)

**Recommendation:** Create a lightweight package index at `.claude/max-objects/packages/registry.json`.

```json
{
  "packages": {
    "beap": {
      "display_name": "BEAP",
      "version": "1.0.4",
      "tier": 1,
      "bundled": true,
      "license": "free",
      "install_path": "packages/BEAP",
      "object_count": 168,
      "extraction_method": "bpatcher",
      "extraction_date": "2026-04-12T00:00:00Z",
      "categories": ["Oscillator", "Filter", "Envelope", "Effects", "MIDI", "Sequencer", "Mixer", "Scope", "Level", "LFO", "Quantizer", "Random", "Input", "Output", "Waveshapers", "Analysis", "Serialosc"]
    },
    "vizzie": {
      "display_name": "Vizzie",
      "version": "2.3.0",
      "tier": 1,
      "bundled": true,
      "license": "free",
      "install_path": "packages/Vizzie",
      "object_count": 110,
      "extraction_method": "bpatcher",
      "extraction_date": "2026-04-12T00:00:00Z",
      "categories": ["CONTROL", "EFFECTS", "GENERATORS", "INPUT", "MIXERS", "OUTPUT", "UTILITIES"]
    },
    "jitter-geometry": {
      "display_name": "Jitter Geometry",
      "version": "1.0.0",
      "tier": 1,
      "bundled": true,
      "license": "free",
      "install_path": "packages/Jitter Geometry",
      "object_count": 27,
      "extraction_method": "xml",
      "extraction_date": null
    },
    "jitter-tools": {
      "display_name": "Jitter Tools",
      "version": "1.2.2",
      "tier": 1,
      "bundled": true,
      "license": "free",
      "install_path": "packages/Jitter Tools",
      "object_count": 99,
      "extraction_method": "xml",
      "extraction_date": null
    },
    "flucoma": {
      "display_name": "FluCoMa",
      "version": "1.0.8",
      "tier": 2,
      "bundled": false,
      "license": "free",
      "install_path": null,
      "object_count": 50,
      "extraction_method": "xml_or_help",
      "extraction_date": null,
      "prefix": "fluid."
    }
  }
}
```

**Fields:**
- `tier`: 1 (bundled with MAX) or 2 (community/licensed). Tier 1 objects are always available; Tier 2 require the package to be installed.
- `bundled`: Whether the package ships with MAX 9.
- `license`: "free", "paid", "academic". Used for gating recommendations.
- `extraction_method`: "xml" (has `.maxref.xml`), "bpatcher" (parse `.maxpat` clippings), "xml_or_help" (may need both).
- `install_path`: Relative to MAX's C74 dir for bundled, absolute for user-installed.

**Confidence:** HIGH -- mirrors `package-info.json` format from MAX plus our metadata.

### Decision 5: ObjectDatabase Filtering Extensions

**Recommendation:** Add package-aware methods to ObjectDatabase, not a new class.

```python
class ObjectDatabase:
    # Existing constructor gets optional packages filter
    def __init__(self, db_root=None, packages=None):
        """
        Args:
            packages: If provided, only load objects from these packages.
                      None means load all. ["core"] means only core objects.
                      ["core", "BEAP"] means core + BEAP.
        """
        ...

    # New methods
    def list_packages(self) -> list[str]:
        """Return names of all available packages."""
        ...

    def objects_in_package(self, package: str) -> list[str]:
        """Return object names belonging to a specific package."""
        ...

    def lookup(self, name: str, packages: list[str] | None = None) -> dict | None:
        """Look up object, optionally restricted to specific packages.
        If packages is None, searches all loaded objects (existing behavior).
        """
        ...
```

**Why a filter, not separate databases:** The validation pipeline needs one unified database. Filtering at query time is simpler than maintaining separate ObjectDatabase instances per project.

**Per-patch permission gating:** A project's `context.md` or a new `packages.json` declares which packages the project uses:
```json
{"allowed_packages": ["core", "BEAP", "FluCoMa"]}
```
When creating a patch, pass this to `ObjectDatabase(packages=allowed)`. Agents can only use objects from allowed packages. Validation layer 2 flags objects from disallowed packages.

**Confidence:** HIGH -- simple extension to existing API.

### Decision 6: Do NOT Build a Package Manager / Installer

**Recommendation:** Do not build tooling to install/update community packages. That is MAX Package Manager's job.

**What we DO build:**
- Scan installed packages and extract object metadata
- Store extracted metadata in our DB format
- Gate access per project

**What we DO NOT build:**
- Download/install packages from the internet
- Version conflict resolution
- Dependency management between packages
- Auto-update from package repos

**Why:** Community packages (FluCoMa, Bach, CNMAT) have their own release cycles, build systems (CMake for FluCoMa), and distribution channels. Replicating this is a maintenance burden with no benefit -- users install via MAX Package Manager, we scan what is installed.

**Confidence:** HIGH -- clear scope boundary.

### Decision 7: Extraction for Community Packages (Tier 2)

**Recommendation:** Use a hybrid extraction approach based on what the package provides.

| Package | Type | Extraction Source | Notes |
|---------|------|-------------------|-------|
| FluCoMa | Compiled externals (`.mxo`) | `.maxref.xml` if present, else parse `.maxhelp` files | All objects prefixed `fluid.*` |
| CNMAT | Compiled externals | `.maxref.xml` or `.maxhelp` | Objects like `resonators~`, `sinusoids~` |
| Bach | Mixed (externals + abstractions) | `.maxref.xml` (250+ objects) | All prefixed `bach.*` |
| Odot | Compiled externals | `.maxref.xml` or parse help patches | OSC processing, `o.*` prefix |
| ml.star | Compiled externals | `.maxhelp` files | 8 objects, `ml.*` prefix |
| IRCAM Spat | Compiled externals | `.maxref.xml` (300+ objects) | Licensed, `spat5.*` prefix, paid |
| Cage | Mixed | `.maxref.xml` or help | `cage.*` prefix, depends on Bach |
| Dada | Mixed | Help patches | `dada.*` prefix, depends on Bach |
| EARS | Mixed | Help patches | `ears.*` prefix, depends on Bach |

**Help patch extraction** (fallback when no XML refs exist):
```
For each .maxhelp in package/help/:
  1. Find the target object box in the help patch
  2. Read numinlets/numoutlets from the box
  3. Read outlettype array for signal types
  4. Parse comment boxes near inlets/outlets for digest text
  5. Extract object name from box text
```

This is less reliable than XML extraction but sufficient for Tier 2 packages where we accept lower verification confidence.

**Confidence:** MEDIUM -- not all community packages have been examined. The extraction approach is sound but specific packages may have quirks.

## What NOT to Add

| Technology | Why Not |
|------------|---------|
| Package download/install tooling | MAX Package Manager handles this |
| SQLite for object DB | JSON files are small (11K lines for 87 objects), fast, git-friendly |
| NetworkX for package dependency graphs | Package deps are simple (Bach -> Cage/Dada/EARS), hardcode in registry |
| Web scraping for package docs | Fragile, unnecessary -- extract from installed files |
| Any npm/pip dependencies | Extraction is pure Python stdlib (json, xml.etree, pathlib) |

## Existing Stack: Unchanged

| Technology | Version | Status |
|------------|---------|--------|
| Python | 3.14 | Keep -- runtime for all modules |
| pytest | 9.0.2 | Keep -- test framework |
| `json` (stdlib) | 3.14 | Keep -- .maxpat and object DB parsing |
| `xml.etree.ElementTree` (stdlib) | 3.14 | Keep -- .maxref.xml parsing in extract_objects.py |
| `pathlib` (stdlib) | 3.14 | Keep -- file I/O and package path discovery |
| `extract_objects.py` | v1.0 | Keep + extend -- add bpatcher extraction path |
| `db_lookup.py` (ObjectDatabase) | v1.1 | Keep + extend -- add package filter API |
| `validation.py` | v1.1 | Keep + extend -- package-aware object checks |
| `patcher.py` | v2.0 | Keep -- round-trip editing (no changes needed) |
| All other `src/maxpat/*.py` modules | v1.1-2.0 | Keep -- no changes needed |

## New/Modified Module Map

```
.claude/scripts/
  extract_objects.py        # EXTENDED: add extract_bpatcher_abstractions(), scan_packages()

.claude/max-objects/
  packages/
    registry.json           # NEW: package metadata index
    ableton-dsp/objects.json # MOVED from flat packages/objects.json
    beap/objects.json        # NEW: ~168 bpatcher abstraction objects
    vizzie/objects.json      # NEW: ~110 bpatcher abstraction objects
    jitter-geometry/objects.json  # NEW: 27 objects from XML refs
    jitter-tools/objects.json     # NEW: 99 objects from XML refs
    flucoma/objects.json     # NEW (when installed): ~50 objects
    # more Tier 2 packages added as discovered

src/maxpat/
  db_lookup.py              # EXTENDED: package filter in __init__, list_packages(),
                            #   objects_in_package(), package-aware lookup()
  validation.py             # EXTENDED: Layer 2 checks package allowlist
  # All other modules unchanged
```

## Integration Points

### Extraction Pipeline
```
extract_objects.py --scan-packages
  -> Discover: iterate MAX package dirs, read package-info.json
  -> For each package:
     IF has .maxref.xml: existing XML extraction
     ELIF has clippings/: bpatcher extraction (parse .maxpat JSON)
     ELSE: help patch extraction (parse .maxhelp JSON)
  -> Output: per-package objects.json + update registry.json
```

### ObjectDatabase Load Path (Modified)
```
ObjectDatabase(packages=["core", "BEAP", "FluCoMa"])
  -> Load DOMAIN_LOAD_ORDER domains (unchanged for core)
  -> For "packages": iterate packages/ subdirs
     -> Skip subdirs not in packages filter (if filter provided)
     -> Load each subdir's objects.json
  -> Apply overrides, aliases (unchanged)
```

### Validation Integration
```
validate_patch(patch, db=ObjectDatabase(packages=project_packages))
  -> Layer 2: object existence checks against filtered DB
  -> Objects from non-allowed packages trigger warning:
     "Object 'bp.Oscillator' requires BEAP package (not in project allowlist)"
```

### Agent Integration
```
Agent receives: project context with allowed_packages
Agent creates:  ObjectDatabase(packages=allowed_packages)
Agent uses:     db.lookup("bp.Oscillator")  # Found only if BEAP allowed
Agent suggests: db.objects_in_package("BEAP")  # For discovery
```

## Installation

```bash
# No new packages to install. Zero new dependencies.
# Package extraction uses Python 3.14 stdlib: json, xml.etree, pathlib.
```

## Sources

### Codebase Analysis (HIGH confidence)
- `extract_objects.py` -- Examined XML extraction pipeline, SOURCE_DIRS, PACKAGE_GLOBS (lines 1-50)
- `db_lookup.py` -- Examined ObjectDatabase._load(), DOMAIN_LOAD_ORDER, lookup(), compute_io_counts()
- `validation.py` -- Examined 4-layer pipeline, _validate_objects_exist(), _extract_object_name()
- `conftest.py` -- Examined VALID_DOMAINS, DOMAIN_DIRS, test fixtures
- `test_object_schema.py` -- Examined required schema fields (18 fields)
- `.claude/max-objects/packages/objects.json` -- 87 existing package objects, all abl.*/jit.*/live.*/mira.*
- `.claude/max-objects/extraction-log.json` -- 2,015 total objects across 8 domains

### MAX Package Structure Analysis (HIGH confidence, verified on disk)
- `/Applications/Max.app/Contents/Resources/C74/packages/` -- Examined all 18 bundled packages
- BEAP `package-info.json` -- Version 1.0.4, 168 clippings, 167/168 embedded bpatchers
- Vizzie `package-info.json` -- Version 2.3.0, 110 clippings, 110/110 file-referenced bpatchers
- Jitter Geometry -- 27 `.maxref.xml` files, compiled externals + abstractions
- Jitter Tools -- 99 `.maxref.xml` files, compiled externals (`.mxo` in externals/)
- BEAP inlet comment attributes: empty (uses presentation labels instead)
- Vizzie inlet comment attributes: populated with descriptions

### Official Documentation (HIGH confidence)
- [MAX Package Structure](https://docs.cycling74.com/userguide/packages/) -- Directory structure, package-info.json format, discovery mechanism
- [package-info.json Spec](https://docs.cycling74.com/max8/vignettes/package_info_json) -- All fields documented

### Community Package Research (MEDIUM confidence)
- [FluCoMa GitHub](https://github.com/flucoma/flucoma-max) -- Compiled C++ externals, `fluid.*` prefix, v1.0.8
- [FluCoMa Reference](https://learn.flucoma.org/reference/) -- ~50 objects across analyse/decompose/slice/transform categories
- [CNMAT Externals](https://github.com/CNMAT/CNMAT-Externs) -- Compiled externals, resonators~/sinusoids~/harmonics~
- [Bach Project](https://www.bachproject.net/) -- 100+ externals + abstractions, `bach.*` prefix, notation/CAC
- [FluCoMa on Cycling74](https://cycling74.com/packages/fluidcorpusmanipulation) -- Package Manager listing
- [ml.star](https://cycling74.com/packages/mlstar) -- 8 ML objects, `ml.*` prefix
- [IRCAM Spat5](https://forum.ircam.fr/projects/detail/spat/) -- 300+ objects, `spat5.*` prefix, paid license
