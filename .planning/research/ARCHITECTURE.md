# Architecture Patterns

**Domain:** MAX/MSP Package Integration into existing AI-assisted patch generation framework
**Researched:** 2026-04-12

## Existing Architecture Snapshot

The current system (33,430 LOC Python) has these key components:

```
.claude/max-objects/
  {domain}/objects.json     8 domain files (max, msp, jitter, mc, gen, m4l, rnbo, packages)
  aliases.json              Shorthand -> canonical name
  overrides.json            Expert corrections, variable_io_rules
  relationships.json        Object pairs (tapin~/tapout~, etc.)
  pd-blocklist.json         PD objects -> MAX equivalents

src/maxpat/
  db_lookup.py              ObjectDatabase -- single source of truth (302 LOC)
  patcher.py                Patcher/Box/Patchline data model (2048 LOC)
  validation.py             4-layer validation pipeline (1020 LOC)
  layout.py                 Row-based layout engine (1212 LOC)
  critics/                  DSP, structure, layout, M4L, ext, RNBO critics
  audit/                    Help patch parser, override merger
  externals.py              Min-DevKit scaffolding + build
  project.py                Project lifecycle (patches/{name}/)
  maxclass_map.py           UI_MAXCLASSES set + resolve_maxclass()

.claude/skills/             6 specialist agents + router
```

## Recommended Architecture for Package Integration

### Component Boundaries

| Component | Responsibility | Communicates With |
|-----------|---------------|-------------------|
| `PackageRegistry` (NEW) | Package metadata, tier, install status, discovery | ObjectDatabase, validation, agents |
| `ObjectDatabase` (MODIFIED) | Object lookup with package-aware filtering | PackageRegistry, validation, Patcher/Box |
| `AbstractionExtractor` (NEW) | Parse bpatcher .maxpat files for I/O metadata | PackageRegistry, ObjectDatabase (write) |
| `PackageDetector` (NEW) | Scan filesystem for installed packages | PackageRegistry |
| `validation.py` (MODIFIED) | Package gating warnings in Layer 2 | ObjectDatabase, project config |
| `patcher.py` (MODIFIED) | Route package objects to add_bpatcher() vs add_box() | ObjectDatabase |
| `maxclass_map.py` (MODIFIED) | Recognize package bpatcher abstractions | ObjectDatabase |
| Per-agent SKILL.md (MODIFIED) | Package-specific generation guidance | PackageRegistry |
| `package_critic.py` (NEW) | Package convention validation (BEAP CV, Bach llll) | ObjectDatabase, PackageRegistry |

### Data Flow

```
                    +-----------------------+
                    |  PackageDetector      |
                    |  (filesystem scan)    |
                    +----------+------------+
                               |
                               v
+-------------------+    +-----+-------+    +---------------------+
| AbstractionParser |    | Package     |    | XML Extraction      |
| (BEAP, Vizzie     |--->| Registry    |<---| (existing pipeline) |
|  .maxpat parsing) |    | package_    |    | (FluCoMa, CNMAT...) |
+-------------------+    | info.json   |    +---------------------+
                         +------+------+
                                |
                                v
                    +-----------+-----------+
                    |   ObjectDatabase      |
                    |   (MODIFIED)          |
                    |   - package field     |
                    |   - allowed_packages  |
                    |   - per-package dirs  |
                    +-----------+-----------+
                         |     |      |
              +----------+     |      +-----------+
              v                v                  v
     +--------+-----+  +------+------+   +-------+-------+
     | Patcher/Box  |  | validation  |   | Agent Skills   |
     | (route to    |  | (Layer 2    |   | (package       |
     |  add_bpatcher|  |  gating)    |   |  guidance)     |
     |  vs add_box) |  +------+------+   +-------+-------+
     +--------------+         |                   |
                              v                   v
                    +---------+--------+  +-------+-------+
                    | package_critic   |  | Starter       |
                    | (BEAP CV, Bach   |  | Templates     |
                    |  llll, etc.)     |  | (per-package) |
                    +------------------+  +---------------+
```

## New Components -- Detailed Design

### 1. PackageRegistry (`package_info.json` + methods on ObjectDatabase)

**What:** Central metadata store for all known packages. A JSON file loaded by ObjectDatabase, with accessor methods added to the class.

**Location:** `.claude/max-objects/package_info.json`

**Schema:**
```json
{
  "packages": {
    "beap": {
      "name": "BEAP",
      "tier": "bundled",
      "prefix": "bp.",
      "version": "1.0",
      "object_type": "bpatcher_abstraction",
      "install_method": "bundled_with_max",
      "install_paths": [
        "/Applications/Max.app/Contents/Resources/C74/packages/BEAP",
        "~/Documents/Max 9/Packages/BEAP"
      ],
      "description": "Berlin Experimental Audio Patches -- modular synth toolkit",
      "db_file": "packages/beap/objects.json",
      "extracted": true,
      "object_count": 172
    },
    "flucoma": {
      "name": "FluCoMa",
      "tier": "community",
      "prefix": "fluid.",
      "version": "1.0.8",
      "object_type": "compiled_external",
      "install_method": "package_manager",
      "install_paths": [
        "~/Documents/Max 9/Packages/FluidCorpusManipulation"
      ],
      "description": "Fluid Corpus Manipulation -- audio analysis and ML",
      "db_file": "packages/flucoma/objects.json",
      "extracted": false,
      "object_count": 0,
      "stub_objects": ["fluid.hpss~", "fluid.nmf~", "fluid.mfcc~"]
    }
  }
}
```

**Why a separate file (not embedded in ObjectDatabase):** Package metadata (install paths, tiers, install instructions) is orthogonal to object data. ObjectDatabase should stay focused on object lookup. The registry is the single source of truth for "what packages exist and where they live."

**Integration:** ObjectDatabase constructor reads `package_info.json` once. Methods query it for package-level decisions. No new class needed -- add methods directly to ObjectDatabase.

### 2. Per-Package DB Directories

**What:** Split the monolithic `packages/objects.json` (87 objects, all abl.* and jit.mo.*) into per-package subdirectories.

**Structure:**
```
.claude/max-objects/packages/
  beap/
    objects.json         # ~172 bpatcher abstraction entries
  vizzie/
    objects.json         # ~110 bpatcher abstraction entries
  ableton-dsp/
    objects.json         # 74 objects (moved from monolithic file)
  jit-mo/
    objects.json         # 8 objects (moved from monolithic file)
  flucoma/
    objects.json         # Stubs initially, full entries after extraction
  cnmat/
    objects.json
  bach/
    objects.json
  ...
```

**Loading strategy:** The current `DOMAIN_LOAD_ORDER` includes `"packages"` as a single slot. Change `_load()` to iterate over subdirectories under `packages/` instead of loading a single `packages/objects.json`. Each subdirectory's `objects.json` loads into the same namespace. Core domains still shadow duplicates.

**Critical detail:** The existing 87 objects in `packages/objects.json` are `abl.*` (74) + `jit.mo.*` (8) + misc (5). These must be migrated to `packages/ableton-dsp/objects.json` and `packages/jit-mo/objects.json` respectively before the split. This is a data migration, not a code change.

### 3. AbstractionExtractor (NEW: `src/maxpat/extract_abstractions.py`)

**What:** Extraction pipeline for bpatcher-based packages (BEAP, Vizzie, Jitter Tools abstractions). The existing XML pipeline (`audit/parser.py`, `extract_objects.py`) cannot handle these because bpatcher abstractions have no XML refpages.

**Approach:**
1. Scan package directory for `.maxpat` files in `patchers/` subdirectory
2. For each `.maxpat` file, open and parse the JSON
3. Count `inlet`/`outlet` objects at the top patcher level
4. Determine signal types by tracing connections from inlets to first downstream objects:
   - If inlet connects to a signal object's signal inlet -> signal inlet
   - If outlet receives from a signal object's signal outlet -> signal outlet
   - Otherwise -> control
5. Extract name from filename, category from directory structure, description from patcher description field
6. Write per-package `objects.json` in the standard format

**Signal type inference is the hard part.** The existing `traverse_patcher()` in `audit/parser.py` already handles recursive descent into subpatchers and extracts connections. Reuse that infrastructure.

**Fallback:** If signal type inference fails for an object, default to control type and add `"signal_inferred": false` flag. Agent guidance can note "signal type unverified" for these entries.

**Integration with existing code:** This reuses `audit/parser.py`'s `traverse_patcher()` and `parse_object_text()` for the heavy lifting. The new module is a thin orchestrator that:
- Finds .maxpat files in a package directory
- Calls traverse_patcher to extract the structure
- Applies signal type inference logic
- Writes the DB JSON

### 4. PackageDetector (simple filesystem scanner)

**What:** Detects which packages are actually installed on the user's machine by checking standard MAX package paths.

**Location:** Function in `db_lookup.py` or standalone `package_detect.py`.

**Paths to check (macOS):**
```python
PACKAGE_SEARCH_PATHS = [
    Path("/Applications/Max.app/Contents/Resources/C74/packages"),  # Bundled
    Path.home() / "Documents" / "Max 9" / "Packages",               # User-installed
    Path("/Users/Shared/Max 9/Packages"),                            # System-wide
]
```

**Behavior:** Returns dict of `{package_name: Path}` for installed packages. Used by extraction commands and for install status display. NOT called on every ObjectDatabase init -- only when explicitly requested (e.g., extraction command, package status check).

### 5. ObjectDatabase Modifications

**Current state:** `ObjectDatabase._load()` iterates `DOMAIN_LOAD_ORDER` and loads one `objects.json` per domain. Package objects already load from `packages/objects.json`.

**Required changes:**

```python
# db_lookup.py modifications

class ObjectDatabase:
    def __init__(self, db_root=None, allowed_packages=None):
        # NEW: allowed_packages filter
        self._allowed_packages: set[str] | None = allowed_packages
        self._package_info: dict = {}
        # ... existing init ...

    def _load(self, db_root):
        # ... existing alias, override, PD blocklist loading ...

        # MODIFIED: Load package_info.json
        pkg_info_path = db_root / "package_info.json"
        if pkg_info_path.exists():
            self._package_info = json.loads(pkg_info_path.read_text())

        # MODIFIED: packages slot now loads per-package subdirectories
        for domain_dir in DOMAIN_LOAD_ORDER:
            if domain_dir == "packages":
                self._load_packages(db_root / "packages")
            else:
                # existing single-file loading
                json_path = db_root / domain_dir / "objects.json"
                if json_path.exists():
                    data = json.loads(json_path.read_text())
                    for name, obj in data.items():
                        self._objects[name] = obj

    def _load_packages(self, packages_dir: Path):
        """Load per-package subdirectories."""
        if not packages_dir.exists():
            return
        for pkg_dir in sorted(packages_dir.iterdir()):
            if not pkg_dir.is_dir():
                continue
            json_path = pkg_dir / "objects.json"
            if json_path.exists():
                data = json.loads(json_path.read_text())
                for name, obj in data.items():
                    if "package" not in obj:
                        obj["package"] = pkg_dir.name
                    self._objects[name] = obj

    def lookup(self, name, check_allowed=False):
        """Look up object, optionally checking package permission."""
        canonical = self._aliases.get(name, name)
        obj = self._objects.get(canonical)
        if obj is None:
            return None
        if check_allowed and self._allowed_packages is not None:
            pkg = obj.get("package")
            if pkg and pkg not in self._allowed_packages:
                return None
        return obj

    def is_package_object(self, name):
        """Check if an object belongs to a package (not a core domain)."""
        obj = self.lookup(name)
        return obj is not None and obj.get("package") is not None

    def get_package(self, name):
        """Get the package name for an object, or None if core."""
        obj = self.lookup(name)
        return obj.get("package") if obj else None

    def list_packages(self):
        """List all known package names."""
        return list(self._package_info.get("packages", {}).keys())

    def get_package_info(self, package_name):
        """Get metadata for a specific package."""
        return self._package_info.get("packages", {}).get(package_name)

    def get_package_objects(self, package_name):
        """Get all objects belonging to a specific package."""
        return {
            name: obj for name, obj in self._objects.items()
            if obj.get("package") == package_name
        }
```

**Key design decisions:**
- `allowed_packages` is constructor-level, not per-lookup. Per-project gating means creating an ObjectDatabase with the right filter for each generation context.
- The existing `lookup()` signature stays backward compatible (check_allowed defaults to False).
- Package info is lazy -- loaded once, queried as needed.

### 6. Validation Pipeline Modifications

**Current state:** `validation.py` Layer 2 (`_validate_objects_exist`) checks if objects exist in DB and flags unknown objects as warnings. PD objects get errors.

**Required change:** Add package gating check after the existence check.

```python
# In _validate_objects_exist(), after confirming db.exists(name):
pkg = db.get_package(name)
if pkg and project_packages is not None:
    if pkg not in project_packages:
        results.append(ValidationResult(
            "objects", "warning",
            f"'{name}' requires package '{pkg}' which is not "
            f"enabled for this project.",
        ))
```

**Package gating is warnings, not errors.** The patch is structurally valid even with package objects. The user may have the package installed. Warnings surface the issue without preventing work.

### 7. Patcher/Box Modifications for Bpatcher Abstractions

**Current state:** `Box.__init__()` looks up the object in ObjectDatabase, resolves maxclass via `maxclass_map.py`, and raises ValueError if unknown. Bpatcher creation uses the separate `Patcher.add_bpatcher()` method.

**Problem:** Package bpatcher abstractions (BEAP, Vizzie) are in the DB with `"maxclass": "bpatcher"`, but `Box.__init__()` would try to create them as `newobj` boxes. The agent would need to know to call `add_bpatcher()` instead.

**Solution -- Smart routing in Patcher.add_box():**

```python
def add_box(self, name, args=None, x=0.0, y=0.0, **kwargs):
    """Add a box, auto-routing bpatcher abstractions."""
    obj_data = self.db.lookup(name) if self.db else None

    if obj_data and obj_data.get("maxclass") == "bpatcher":
        # Route to add_bpatcher for package abstractions
        filename = obj_data.get("abstraction_file", name + ".maxpat")
        numinlets = len(obj_data.get("inlets", []))
        numoutlets = len(obj_data.get("outlets", []))
        return self.add_bpatcher(
            filename=filename,
            args=args or [],
            x=x, y=y,
            numinlets=numinlets,
            numoutlets=numoutlets,
            **kwargs,
        )

    # Normal path
    box = Box(name, args=args, box_id=self._gen_id(), db=self.db, x=x, y=y)
    self.boxes.append(box)
    return box
```

**This is the highest-leverage architectural improvement.** Agents should not need to know whether an object is a compiled external or a bpatcher abstraction. `add_box("bp.Oscillator")` should just work. The DB metadata drives the routing decision. This makes package objects feel like native objects from the agent's perspective.

### 8. Package-Aware Critics (NEW: `src/maxpat/critics/package_critic.py`)

**What:** Domain-specific validation for package conventions.

**BEAP critic:**
- Check CV signal range: values fed to BEAP CV inputs should be in 0-5V range
- Check bpatcher sizing matches BEAP module dimensions
- Warn on mixing BEAP and non-BEAP in same signal chain without conversion

**Bach critic:**
- Check llll connections: Bach objects expect llll data types, not standard MAX lists
- Warn when connecting non-Bach objects to Bach inlets (data type mismatch)
- Verify bach.roll/bach.score have required supporting objects

**Pattern:** Same as existing critics -- functions returning `list[CriticResult]`.

### 9. Project Config for Package Selection

**Current state:** Projects have `context.md` and `status.md`. No structured config.

**New file:** `patches/{project}/config.json`

```json
{
  "packages": ["beap", "vizzie"],
  "max_version": 9
}
```

**Why separate from status.md:** Status is lifecycle state. Config is project parameters. Different update patterns.

**Integration:** `project.py`'s `create_project()` gets an optional `packages` parameter. The router reads `config.json` to determine allowed packages, passes to ObjectDatabase constructor.

## Patterns to Follow

### Pattern 1: DB-Driven Routing (the core insight)

**What:** All object metadata -- including how to instantiate them in a patch -- is determined by the object DB entry, not by agent knowledge.

**When:** Always, for all objects (core and package).

**Example:**
```python
# Agent code for both core and package objects:
box = patcher.add_box("cycle~", args=["440"])     # Core object -> Box()
box = patcher.add_box("bp.Oscillator")             # BEAP -> add_bpatcher()
# Agent doesn't need to know the difference. DB drives routing.
```

### Pattern 2: Layered Package Loading

**What:** Packages load within the existing domain load order. Core domains shadow package duplicates.

**When:** At ObjectDatabase initialization.

### Pattern 3: Warn, Don't Block

**What:** Package gating produces warnings, never errors. Structural validation still blocks.

**When:** Validation layer 2 (object existence).

### Pattern 4: Stub-to-Full Upgrade Path

**What:** Community packages start as stubs (name, package, prefix, install instructions). When the user runs extraction on an installed package, stubs are replaced with full entries.

## Anti-Patterns to Avoid

### Anti-Pattern 1: Per-Agent Package Knowledge

**What:** Embedding package-specific instantiation logic in agent SKILL.md files.
**Why bad:** 6+ agents all need updating when a package changes. Inconsistencies between agents.
**Instead:** Agents use `add_box()` uniformly. DB drives routing. Agent SKILL.md contains only usage guidance (when to use BEAP vs hand-built, Bach data type conventions), not instantiation mechanics.

### Anti-Pattern 2: Monolithic Package DB

**What:** Keeping all package objects in one `packages/objects.json`.
**Why bad:** Currently 87 objects. With all target packages, this becomes 700+ objects in one file.
**Instead:** Per-package subdirectories.

### Anti-Pattern 3: Global Package Permissions

**What:** Setting allowed packages globally rather than per-project.
**Why bad:** A modular synth project (BEAP) and a notation project (Bach) have completely different needs.
**Instead:** Per-project `config.json` with package list.

### Anti-Pattern 4: Blocking on Stubs

**What:** Refusing to generate patches that reference stub (unextracted) package objects.
**Why bad:** User may have the package installed even though stubs haven't been upgraded.
**Instead:** Generate with best-effort I/O counts from stubs. Warn that validation is limited.

## Integration Points -- Existing Components Requiring Changes

### Changes Ranked by Impact

| Priority | Component | File(s) | Change Type | LOC Estimate |
|----------|-----------|---------|-------------|--------------|
| 1 | ObjectDatabase | `db_lookup.py` | Modify _load(), add package methods | +80 LOC |
| 2 | Package Registry | `package_info.json` (NEW) | New data file | ~200 LOC JSON |
| 3 | Per-Package DB Split | `packages/*/objects.json` | Data migration | ~0 code, data move |
| 4 | Patcher.add_box() | `patcher.py` | Add bpatcher routing | +20 LOC |
| 5 | Validation Layer 2 | `validation.py` | Add package gating | +15 LOC |
| 6 | Abstraction Extractor | `extract_abstractions.py` (NEW) | New module | ~250 LOC |
| 7 | Project Config | `project.py` | Add packages to create_project() | +30 LOC |
| 8 | Package Detector | `package_detect.py` or in `db_lookup.py` | New function | +40 LOC |
| 9 | Package Critic | `critics/package_critic.py` (NEW) | New module | ~150 LOC |
| 10 | Agent Skills | `.claude/skills/*/SKILL.md` | Add package guidance sections | ~200 LOC markdown |
| 11 | Relationships | `relationships.json` | Add package pairs | ~50 LOC JSON |
| 12 | Router Skill | `.claude/skills/max-router/SKILL.md` | Package-aware dispatch | +20 LOC |
| 13 | Starter Templates | `.claude/skills/references/` | New template files | ~300 LOC |

**Total new code estimate: ~500 LOC Python + ~450 LOC JSON + ~520 LOC markdown**

### Files NOT Needing Changes

| Component | File | Why No Change |
|-----------|------|---------------|
| Layout engine | `layout.py` | Bpatcher boxes already handled (treated as fixed-size) |
| Aesthetics | `aesthetics.py` | Package objects get standard styling |
| Code generation | `codegen.py` | No GenExpr for package objects |
| Sizing | `sizing.py` | Bpatcher sizing comes from DB entry |
| Hooks | `hooks.py` | save_patch_roundtrip, finalize_patch work unchanged |
| Audit parser | `audit/parser.py` | Already handles subpatcher descent -- reused |
| Override merger | `audit/merger.py` | Already handles packages domain |
| RNBO validation | `rnbo_validation.py` | RNBO is already in DB |
| External scaffolding | `externals.py` | External build is separate concern |

## Scalability Considerations

| Concern | Current (87 pkg) | After Bundled (~500) | After Community (~1000+) |
|---------|-------------------|----------------------|--------------------------|
| DB load time | <10ms | ~30ms | ~50ms |
| Memory | <1MB | ~3MB | ~5MB |
| Lookup speed | O(1) dict | O(1) unchanged | O(1) unchanged |
| Validation speed | No pkg checks | +1 dict lookup/object | +1 dict lookup/object |

**No lazy loading needed.** Even 1000+ package objects is a small dict.

## Suggested Build Order

```
Phase 20 (Schema Foundation)
  Plan 1: package_info.json + data migration (split packages/objects.json)
  Plan 2: ObjectDatabase modifications (_load_packages, package methods)
  Plan 3: Validation Layer 2 package gating + Patcher.add_box() routing

Phase 21 (Bundled Extraction)           Phase 22 (Generation Gating)
  Plan 1: AbstractionExtractor            Plan 1: Project config.json
  Plan 2: BEAP extraction                 Plan 2: /max-new package prompt
  Plan 3: Vizzie extraction
  Plan 4: Jitter Geometry/Tools

Phase 23 (Agent Intelligence)           Phase 24 (Community Support)
  Plan 1: Agent SKILL.md updates          Plan 1: Stub entries for all Tier 2
  Plan 2: relationships.json              Plan 2: Extraction CLI commands
  Plan 3: Layout overrides                Plan 3: Install guidance in agents

Phase 25 (Templates + Critics)
  Plan 1: Package critics (BEAP, Bach)
  Plan 2: Starter templates
  Plan 3: /max-new template integration
```

**Critical path:** Phase 20 -> Phase 21 -> Phase 25.

**The single most important piece:** DB-driven routing in `Patcher.add_box()` (Phase 20 Plan 3). Without it, extraction is useless -- agents can't use the objects. With it, every subsequent phase's objects are immediately usable.

## Sources

- [MAX Package Structure (Cycling '74 docs)](https://docs.cycling74.com/max7/vignettes/packages)
- [MAX Package Manager](https://docs.cycling74.com/userguide/package_manager/)
- [bpatcher Reference](https://docs.cycling74.com/legacy/max8/refpages/bpatcher)
- [FluCoMa MAX Installation](https://learn.flucoma.org/installation/max/)
- [FluCoMa GitHub](https://github.com/flucoma/flucoma-max)
- [CNMAT Externals](https://github.com/CNMAT/CNMAT-Externs)
- [Bach Project](https://www.bachproject.net/)
- [MAX Reference Page XML format](https://cycling74.com/tutorials/writing-reference-pages)
- [maxref.xml schema discussion](https://cycling74.com/forums/reference-schema-description-maxref-xml-files)
- Existing codebase: `db_lookup.py`, `validation.py`, `patcher.py`, `audit/parser.py`, `audit/merger.py`, `project.py`, `maxclass_map.py`, `critics/*.py`
