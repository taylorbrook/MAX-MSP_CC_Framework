# Phase 20: DB Schema Foundation - Research

**Researched:** 2026-04-13
**Domain:** Python object database schema, JSON data migration, API extension
**Confidence:** HIGH

## Summary

This phase adds package awareness to the existing ObjectDatabase. The codebase is a Python project with a well-structured object database (`db_lookup.py`, ~303 lines) that loads 8 domain JSON files in priority order. The current `packages/objects.json` is a flat file with 87 objects that need splitting into per-package subdirectories (`ableton-dsp`, `Mira`, `jit.mo`, plus allocating 6 ambiguous objects). The ObjectDatabase API needs `allowed_packages`, `list_packages()`, and `get_package_objects()` extensions, and a new `package_info.json` registry needs creation.

The work is entirely internal Python + JSON -- no external dependencies, no web services, no new libraries. The main risks are: (1) breaking existing tests that reference `packages/objects.json` directly or hardcode domain counts, (2) correctly allocating the 6 ambiguous objects (`jit.bang`, `jit.framecount`, `jit.line`, `live.adsrui`, `live.adsr~`, `live.scope~`), and (3) ensuring the conftest.py `all_objects` fixture loads per-package subdirectories correctly.

**Primary recommendation:** Implement as a clean migration -- split the monolithic file, update `_load()` to scan `packages/*/objects.json`, add the new API methods, create `package_info.json`, and update conftest.py to match the new loading pattern. All changes are backward-compatible for callers of `db.lookup()`.

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions
- **D-01:** Use MAX's exact Packages folder names as package identifiers: `"BEAP"`, `"Vizzie"`, `"ableton-dsp"`, `"Mira"`, `"FluCoMa"`, etc. No normalization to kebab-case or prefix-based names.
- **D-02:** `package_info.json` keys match these folder names exactly. Each entry has `prefix`, `tier`, `version`, `install_method`, and `description` fields.
- **D-03:** Core (non-package) objects do NOT get a `"package"` field added. Field absence = core. Only package objects carry `"package": "<name>"`. This avoids churn across ~1400 core domain objects.
- **D-04:** ObjectDatabase treats missing `package` field as core: `def is_core(obj): return "package" not in obj`.
- **D-05:** `ObjectDatabase.lookup()` without `allowed_packages` returns everything (core + all packages). Fully backward-compatible with existing code.
- **D-06:** `allowed_packages=[]` means core-only. `allowed_packages=["BEAP"]` means core + BEAP. Package gating at the agent/generation layer happens in Phase 22, not here.
- **D-07:** Clean break: delete `packages/objects.json` entirely. Split into `packages/ableton-dsp/objects.json` (74 objects), `packages/Mira/objects.json` (2 objects), `packages/jit.mo/objects.json` (8 objects). Remaining 3 objects checked and allocated by actual package source.
- **D-08:** Update domain load to scan `packages/*/objects.json` instead of `packages/objects.json`.
- **D-09:** Create empty `packages/BEAP/objects.json` and `packages/Vizzie/objects.json` (and other known packages) as `{}` placeholders for Phase 21 extraction.

### Claude's Discretion
- `package_info.json` exact schema beyond the decided fields (name, tier, prefix, version, install_method, description) -- Claude can add fields useful for downstream phases
- Internal implementation of `list_packages()` and `get_package_objects()` methods
- Test structure and coverage approach
- Whether to add `is_core()` and `get_package()` convenience methods alongside the required API

### Deferred Ideas (OUT OF SCOPE)
None -- discussion stayed within phase scope.
</user_constraints>

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|------------------|
| DBSI-01 | Every package object in the DB is tagged with its source package name | Add `"package": "<name>"` field to each object in per-package JSON files; core objects keep no field (D-03) |
| DBSI-02 | Package registry (`package_info.json`) tracks name, tier, version, install method, prefix, and description per package | Create new JSON file at `.claude/max-objects/package_info.json` with locked schema (D-02) |
| DBSI-03 | ObjectDatabase supports `allowed_packages` filter parameter for package-scoped lookups | Add `allowed_packages` param to `lookup()` with semantics from D-05/D-06 |
| DBSI-04 | ObjectDatabase provides `list_packages()` and `get_package_objects(pkg)` methods | New methods on ObjectDatabase, implementation at Claude's discretion |
| DBSI-05 | Package objects stored in per-package subdirectories | Split `packages/objects.json` into `packages/<pkg>/objects.json` per D-07 |
| DBSI-06 | Existing 87 abl.*/mira.* package objects migrated to per-package subdirectories with package tags | Migration script or manual split; includes all 87 objects allocated to correct packages |
</phase_requirements>

## Project Constraints (from CLAUDE.md)

- ObjectDatabase in `src/maxpat/db_lookup.py` is the single source of truth for object lookups
- `DOMAIN_LOAD_ORDER` controls priority: packages load early, core domains load last and shadow duplicates
- All database JSON files follow uniform schema: object name as key, object dict as value
- Overrides deep-merge onto base objects
- Rule #7: Commit after every save -- changes must be committed
- Multi-instance safety: never `git add .` or `git add -A`

## Standard Stack

No new external dependencies needed. This phase uses only:

| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| Python stdlib `json` | 3.x | JSON file I/O | Already used in `db_lookup.py` |
| Python stdlib `pathlib` | 3.x | Path operations | Already used in `db_lookup.py` |
| pytest | 9.0.2 | Testing | Already installed and configured [VERIFIED: `pytest --version`] |

## Architecture Patterns

### Current Database Loading Pattern
[VERIFIED: `src/maxpat/db_lookup.py` lines 13-71]

```python
# Current: loads flat domain dirs
DOMAIN_LOAD_ORDER = [
    "rnbo", "packages", "m4l", "gen", "mc", "jitter", "msp", "max"
]

# In _load():
for domain_dir in DOMAIN_LOAD_ORDER:
    json_path = db_root / domain_dir / "objects.json"
    if json_path.exists():
        data = json.loads(json_path.read_text())
        for name, obj in data.items():
            self._objects[name] = obj
```

### Required Change: Package Subdirectory Scanning

Replace the flat `packages/objects.json` load with scanning `packages/*/objects.json`:

```python
# New pattern for packages:
for domain_dir in DOMAIN_LOAD_ORDER:
    if domain_dir == "packages":
        # Scan per-package subdirectories
        pkg_root = db_root / "packages"
        if pkg_root.is_dir():
            for pkg_dir in sorted(pkg_root.iterdir()):
                json_path = pkg_dir / "objects.json"
                if json_path.exists() and pkg_dir.is_dir():
                    data = json.loads(json_path.read_text())
                    for name, obj in data.items():
                        self._objects[name] = obj
                        # Track package membership
                        self._package_objects[pkg_dir.name].append(name)
    else:
        # Existing pattern for other domains
        json_path = db_root / domain_dir / "objects.json"
        ...
```

### New Data Structures

```python
class ObjectDatabase:
    def __init__(self, ...):
        self._objects: dict[str, dict] = {}
        self._aliases: dict[str, str] = {}
        self._variable_io_rules: dict[str, dict] = {}
        self._pd_blocklist: dict[str, dict] = {}
        # NEW:
        self._package_objects: dict[str, list[str]] = defaultdict(list)  # pkg_name -> [obj_names]
        self._package_info: dict[str, dict] = {}  # from package_info.json
```

### Package-Aware lookup() Signature

```python
def lookup(self, name: str, *, allowed_packages: list[str] | None = None) -> dict | None:
    """Look up an object by name, optionally filtering by package.
    
    Args:
        name: Object name or alias.
        allowed_packages: If None (default), returns any object (backward-compatible).
            If [] (empty list), returns only core objects (no package field).
            If ["BEAP", "ableton-dsp"], returns core + those packages.
    
    Returns:
        Object dict, or None if not found or filtered out.
    """
    canonical = self._aliases.get(name, name)
    obj = self._objects.get(canonical)
    if obj is None:
        return None
    
    if allowed_packages is None:
        return obj  # No filtering -- backward compatible
    
    pkg = obj.get("package")
    if pkg is None:
        return obj  # Core object -- always allowed
    
    if pkg in allowed_packages:
        return obj
    
    return None  # Package object not in allowed list
```

### New API Methods

```python
def list_packages(self) -> list[str]:
    """Return sorted list of all package names found in the database."""
    return sorted(self._package_objects.keys())

def get_package_objects(self, package: str) -> list[dict]:
    """Return all objects belonging to a specific package."""
    return [self._objects[name] for name in self._package_objects.get(package, [])
            if name in self._objects]

def is_core(self, name: str) -> bool:
    """Check whether an object is a core (non-package) object."""
    canonical = self._aliases.get(name, name)
    obj = self._objects.get(canonical)
    return obj is not None and "package" not in obj

def get_package(self, name: str) -> str | None:
    """Return the package name for an object, or None if core/not found."""
    canonical = self._aliases.get(name, name)
    obj = self._objects.get(canonical)
    if obj is None:
        return None
    return obj.get("package")
```

### File Structure After Migration

```
.claude/max-objects/
  packages/
    ableton-dsp/
      objects.json        # 74 abl.* objects + 3 live.* objects = 77
    Mira/
      objects.json        # 2 mira.* objects
    jit.mo/
      objects.json        # 5 jit.mo.* + 3 jit.bang/framecount/line + 1 jit.mo.sin = 9
    BEAP/
      objects.json        # {} empty placeholder
    Vizzie/
      objects.json        # {} empty placeholder
    (other known packages as empty placeholders)
  package_info.json       # NEW: package registry
  max/objects.json        # unchanged
  msp/objects.json        # unchanged
  ... (all other domains unchanged)
```

### Anti-Patterns to Avoid
- **Modifying core domain files:** D-03 says core objects get NO `package` field. Don't touch `max/objects.json`, `msp/objects.json`, etc.
- **Case-normalizing package names:** D-01 says use exact Packages folder names. `"BEAP"` not `"beap"`, `"ableton-dsp"` not `"AbletonDsp"`.
- **Breaking `conftest.py` silently:** The test fixture loads `packages/objects.json` directly -- must update to scan subdirectories.

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Deep merge of overrides | Custom recursive merger | Existing override pattern in `_load()` | Already works, tested |
| JSON schema validation | Custom validator | Existing `test_object_schema.py` tests | Schema tests already enforce required fields |
| Package name resolution | Fuzzy matching | Exact string match per D-01 | Decision is locked -- exact names only |

## Object Allocation Analysis

[VERIFIED: Analysis of `.claude/max-objects/packages/objects.json`]

The 87 objects in the current monolithic file break down as:

| Package | Count | Objects |
|---------|-------|---------|
| `ableton-dsp` | 74 | All `abl.*` objects |
| `Mira` | 2 | `mira.motion`, `mira.multitouch` |
| `jit.mo` | 5 | `jit.mo.field`, `jit.mo.fieldmask`, `jit.mo.func`, `jit.mo.join`, `jit.mo.time` |
| **Ambiguous: `live.*`** | 3 | `live.adsrui`, `live.adsr~`, `live.scope~` |
| **Ambiguous: `jit.*`** | 3 | `jit.bang`, `jit.framecount`, `jit.line` |

**Additional discovery:** `jit.mo.sin` exists in `jitter/objects.json` with `domain: "Jitter"` but is actually a jit.mo package object. It should be migrated to `packages/jit.mo/objects.json` during this phase. [VERIFIED: grep of jitter/objects.json]

### Allocation Recommendations

**`live.adsrui`, `live.adsr~`, `live.scope~`:** These are part of the `ableton-dsp` package. They ship with the same externals and have `min_version: 8`. The M4L domain already has 28 `live.*` objects -- these 3 were extracted from a different source (the ableton-dsp package refpages, not the M4L refpages). Allocate to `ableton-dsp`. [ASSUMED -- verify by checking MAX Packages/ableton-dsp folder contents]

**`jit.bang`, `jit.framecount`, `jit.line`:** These are Jitter Tools objects that were lumped into the packages domain during extraction. They relate to render context timing (jit.world/jit.gl.render). Allocation options:
1. Put in `jit.mo` (they're GL render utilities, closely related to jit.mo motion)
2. Create a `Jitter Tools` package directory

Recommendation: Allocate to `jit.mo` since they're part of the same Jitter motion/animation workflow and ship in the same Package folder in MAX. [ASSUMED -- verify against MAX's actual Packages folder structure]

**`jit.mo.sin`:** Currently in `jitter/objects.json` but should migrate to `packages/jit.mo/objects.json` for consistency. Remove from jitter domain, add to jit.mo package with `"package": "jit.mo"` tag. [VERIFIED: exists in jitter/objects.json with domain "Jitter"]

### Final Allocation (if recommendations accepted)

| Package | Count | Objects |
|---------|-------|---------|
| `ableton-dsp` | 77 | 74 `abl.*` + 3 `live.*` |
| `Mira` | 2 | 2 `mira.*` |
| `jit.mo` | 9 | 5 `jit.mo.*` from packages + 3 `jit.*` utilities + 1 `jit.mo.sin` from jitter |

Total: 88 objects (87 from packages + 1 from jitter migration).

## Common Pitfalls

### Pitfall 1: conftest.py Fixture Breakage
**What goes wrong:** Tests fail because `conftest.py` loads `packages/objects.json` directly (line 28), and after migration that file won't exist.
**Why it happens:** The test fixture uses `DOMAIN_DIRS` list to find `{domain}/objects.json`, but `packages` will now have subdirectories instead of a single file.
**How to avoid:** Update `conftest.py` to mirror the new loading logic -- scan `packages/*/objects.json` when the domain is `packages`. Keep `DOMAIN_DIRS` order the same.
**Warning signs:** Any test that touches `all_objects` or `objects_by_domain` will fail.

### Pitfall 2: VALID_DOMAINS Set Mismatch
**What goes wrong:** `test_domain_classification.py` checks `obj["domain"] in VALID_DOMAINS` where `VALID_DOMAINS = {"Max", "MSP", "Jitter", "MC", "Gen", "M4L", "Packages", "RNBO"}`. After migration, package objects still have `domain: "Packages"` -- this is fine. But if someone changes the domain field during migration (e.g., to the package name), tests break.
**How to avoid:** Keep `domain: "Packages"` on all migrated objects. The `package` field is the new discriminator, not the `domain` field.

### Pitfall 3: Load Order Priority After Split
**What goes wrong:** If `packages/*/objects.json` loads after core domains, core objects might shadow package objects with the same name.
**Why it happens:** The current `DOMAIN_LOAD_ORDER` puts `packages` second (after `rnbo`). Since later entries overwrite earlier ones, core domains already shadow package duplicates. After splitting, the subdirectory scanning must still happen at the `packages` position in the load order.
**How to avoid:** Keep scanning at the same position in `DOMAIN_LOAD_ORDER`. Don't add individual package names to the order list.

### Pitfall 4: Empty Placeholder Files and list_packages()
**What goes wrong:** `list_packages()` returns `["BEAP", "Vizzie", ...]` for empty placeholder files, confusing consumers.
**How to avoid:** `list_packages()` should return only packages that have at least one object. `_package_objects` is populated during loading -- empty `{}` files produce no entries. Alternatively, read `package_info.json` for the full list (including empty packages) and provide a separate `list_populated_packages()` or a flag parameter.

### Pitfall 5: jit.mo.sin Migration Breaks Jitter Domain Tests
**What goes wrong:** Moving `jit.mo.sin` from `jitter/objects.json` to `packages/jit.mo/objects.json` changes the Jitter domain object count in tests.
**How to avoid:** Check if any tests assert exact Jitter domain object counts. If so, update the expected count. The object should change its `domain` field to `"Packages"` and add `"package": "jit.mo"`.

## Code Examples

### package_info.json Schema

```json
{
  "ableton-dsp": {
    "name": "ableton-dsp",
    "tier": "bundled",
    "prefix": "abl.",
    "version": "9.0",
    "install_method": "bundled",
    "description": "Ableton audio effects and synthesizer building blocks",
    "object_count": 77
  },
  "Mira": {
    "name": "Mira",
    "tier": "bundled",
    "prefix": "mira.",
    "version": "1.3",
    "install_method": "bundled",
    "description": "iPad remote control for MAX patches",
    "object_count": 2
  },
  "jit.mo": {
    "name": "jit.mo",
    "tier": "bundled",
    "prefix": "jit.mo.",
    "version": "9.0",
    "install_method": "bundled",
    "description": "Jitter motion and animation utilities",
    "object_count": 9
  },
  "BEAP": {
    "name": "BEAP",
    "tier": "bundled",
    "prefix": "bp.",
    "version": "1.0",
    "install_method": "bundled",
    "description": "BPATCHER Electro-Acoustic Patching -- modular synthesis modules",
    "object_count": 0,
    "extracted": false
  },
  "Vizzie": {
    "name": "Vizzie",
    "tier": "bundled",
    "prefix": "vz.",
    "version": "2.0",
    "install_method": "bundled",
    "description": "Video processing and effects modules",
    "object_count": 0,
    "extracted": false
  }
}
```

### Per-Package objects.json Example (ableton-dsp)

Each object gets a `"package"` field added:

```json
{
  "abl.device.autofilter~": {
    "name": "abl.device.autofilter~",
    "maxclass": "abl.device.autofilter~",
    "module": "max",
    "domain": "Packages",
    "package": "ableton-dsp",
    ...existing fields unchanged...
  }
}
```

### Updated conftest.py Pattern

```python
DOMAIN_DIRS = ["rnbo", "packages", "m4l", "gen", "mc", "jitter", "msp", "max"]

@pytest.fixture(scope="session")
def all_objects(db_root: Path) -> list[dict]:
    """Load all domain JSON files into a flat list of object dicts."""
    objects = []
    for domain_dir in DOMAIN_DIRS:
        if domain_dir == "packages":
            # Scan per-package subdirectories
            pkg_root = db_root / "packages"
            if pkg_root.is_dir():
                for pkg_dir in sorted(pkg_root.iterdir()):
                    json_path = pkg_dir / "objects.json"
                    if json_path.exists() and pkg_dir.is_dir():
                        data = json.loads(json_path.read_text())
                        for obj in data.values():
                            objects.append(obj)
        else:
            json_path = db_root / domain_dir / "objects.json"
            if json_path.exists():
                data = json.loads(json_path.read_text())
                for obj in data.values():
                    objects.append(obj)
    return objects
```

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | pytest 9.0.2 |
| Config file | None (default discovery) |
| Quick run command | `python -m pytest tests/test_object_schema.py tests/test_domain_classification.py -x -q` |
| Full suite command | `python -m pytest tests/ -x -q` |

### Phase Requirements -> Test Map
| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| DBSI-01 | Package objects have `package` field | unit | `pytest tests/test_package_schema.py::test_package_objects_have_package_field -x` | Wave 0 |
| DBSI-02 | `package_info.json` has required fields | unit | `pytest tests/test_package_schema.py::test_package_info_schema -x` | Wave 0 |
| DBSI-03 | `allowed_packages` filtering works | unit | `pytest tests/test_package_schema.py::test_allowed_packages_filtering -x` | Wave 0 |
| DBSI-04 | `list_packages()` and `get_package_objects()` work | unit | `pytest tests/test_package_schema.py::test_list_packages -x` | Wave 0 |
| DBSI-05 | Per-package subdirectories exist | unit | `pytest tests/test_package_schema.py::test_per_package_directories -x` | Wave 0 |
| DBSI-06 | All 87+ objects migrated correctly | unit | `pytest tests/test_package_schema.py::test_migration_completeness -x` | Wave 0 |

### Sampling Rate
- **Per task commit:** `python -m pytest tests/test_object_schema.py tests/test_domain_classification.py tests/test_package_schema.py -x -q`
- **Per wave merge:** `python -m pytest tests/ -x -q`
- **Phase gate:** Full suite green before `/gsd-verify-work`

### Wave 0 Gaps
- [ ] `tests/test_package_schema.py` -- covers DBSI-01 through DBSI-06
- [ ] No framework install needed (pytest 9.0.2 already installed)

## Assumptions Log

| # | Claim | Section | Risk if Wrong |
|---|-------|---------|---------------|
| A1 | `live.adsrui`, `live.adsr~`, `live.scope~` belong to `ableton-dsp` package | Object Allocation Analysis | LOW -- if wrong, just move to correct package; no API impact |
| A2 | `jit.bang`, `jit.framecount`, `jit.line` belong to `jit.mo` package | Object Allocation Analysis | LOW -- if wrong, create separate package dir; no API impact |
| A3 | Package version numbers (9.0, 1.3, 1.0, 2.0) | package_info.json Schema | LOW -- version field is informational, not used for gating |
| A4 | BEAP prefix is `bp.` | package_info.json Schema | MEDIUM -- incorrect prefix affects downstream Phase 21 extraction matching |

## Open Questions

1. **Allocation of the 6 ambiguous objects**
   - What we know: `live.adsrui`/`live.adsr~`/`live.scope~` are Ableton-authored, `jit.bang`/`jit.framecount`/`jit.line` are Jitter render utilities
   - What's unclear: Exact MAX Packages folder assignment (can't check MAX app from here)
   - Recommendation: Use proposed allocation (live.* -> ableton-dsp, jit.* -> jit.mo), validate with user. Easy to move later since it's just file organization.

2. **Should `list_packages()` include empty placeholder packages?**
   - What we know: D-09 creates empty placeholders for BEAP, Vizzie, etc.
   - What's unclear: Whether API consumers want to see packages with 0 objects
   - Recommendation: `list_packages()` returns only populated packages. Add `list_all_packages()` or use `package_info.json` to discover all known packages including empty ones.

3. **Should `jit.mo.sin` migrate from jitter domain?**
   - What we know: It's in `jitter/objects.json` with `domain: "Jitter"` but is a jit.mo package object
   - What's unclear: Whether this migration is worth the test churn
   - Recommendation: Include in this migration for correctness. Update domain field and add package tag.

## Sources

### Primary (HIGH confidence)
- `src/maxpat/db_lookup.py` -- full ObjectDatabase implementation read, 303 lines
- `.claude/max-objects/packages/objects.json` -- all 87 objects analyzed and categorized
- `tests/conftest.py` -- test fixtures loading pattern verified
- `tests/test_object_schema.py` -- schema validation tests reviewed
- `tests/test_domain_classification.py` -- domain validation reviewed
- `.planning/phases/20-db-schema-foundation/20-CONTEXT.md` -- all 9 locked decisions

### Secondary (MEDIUM confidence)
- `.planning/milestones/v4.0-package-integration-PROPOSAL.md` -- phase breakdown and package inventory
- `.claude/max-objects/jitter/objects.json` -- verified `jit.mo.sin` presence

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH -- no external deps, pure Python/JSON
- Architecture: HIGH -- existing codebase patterns fully understood from source
- Pitfalls: HIGH -- all test files reviewed, fixture loading patterns verified
- Object allocation: MEDIUM -- 6 objects need user confirmation

**Research date:** 2026-04-13
**Valid until:** 2026-05-13 (stable domain, no external dependency drift)
