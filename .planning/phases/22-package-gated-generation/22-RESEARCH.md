# Phase 22: Package-Gated Generation - Research

**Researched:** 2026-04-14
**Domain:** Project config, ObjectDatabase filtering, agent skill integration, validation pipeline
**Confidence:** HIGH

## Summary

Phase 22 connects the package filtering infrastructure built in Phase 20 (ObjectDatabase.lookup(allowed_packages=...)) to the actual generation and validation pipelines. The ObjectDatabase already supports package-aware filtering -- the gap is that nothing reads project config to determine WHICH packages are allowed, and nothing passes that filter through to Patcher, Box, validation, or agent skills.

The work splits into four clean layers: (1) config storage in project directories, (2) config reading wired into Patcher/Box creation so filtered-out objects raise ValueError per Rule #1, (3) validation pipeline also enforcing package gating as defense-in-depth, (4) agent skill SKILL.md updates instructing agents to load and pass config.

**Primary recommendation:** Add `config.json` to project directories, add a `load_project_config()` function to `project.py`, thread `allowed_packages` through `Patcher.__init__()` so it passes to all `Box()` calls via `db.lookup()`, and add a package validation layer to `validate_patch()`.

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions
- **D-01:** `/max-new` presents packages in two groups: "Bundled packages" (ship with MAX -- BEAP, Vizzie, jit.mo, etc.) and "Community packages" (require install -- FluCoMa, CNMAT, Bach, etc.)
- **D-02:** No preset bundles -- user picks individual packages from the two lists
- **D-03:** `/max-build` hard-blocks if project hasn't configured packages yet -- "Run `/max-new` or `/max-config` to set packages before building"
- **D-04:** Package selection stored in new `patches/{name}/config.json` -- separate from context.md (freeform) and status.md (transient state)
- **D-05:** Simple list format: `{"packages": ["BEAP", "Vizzie"]}` -- names match DB package directory names. Metadata already in `package_info.json`.
- **D-06:** Filtered-out package objects treated as non-existent -- `lookup()` returns None, agent follows Rule #1 (Never Guess Objects). No special messaging.
- **D-07:** Validation pipeline also enforces package gating post-generation -- checks every object in patch against allowed packages. Defense in depth with PKG-04 groundwork from Phase 20.
- **D-08:** Core only until configured -- no packages enabled by default. `/max-new` prompts for selection as part of project creation.
- **D-09:** Users can add/remove packages after creation via direct `config.json` edit or a new `/max-config` command (same bundled/community split as `/max-new`).

### Claude's Discretion
- Implementation details of `/max-config` command (whether it's a new skill or extension of max-lifecycle)
- Exact wording of the `/max-build` block message
- Whether bundled/community classification lives in `package_info.json` or is derived from DB structure

### Deferred Ideas (OUT OF SCOPE)
None -- discussion stayed within phase scope
</user_constraints>

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|------------------|
| PKG-09 | `/max-new` asks user which packages to use for the project | Config storage pattern (config.json), package_info.json tier field for bundled/community split, max-lifecycle SKILL.md update |
| PKG-10 | `/max-build` prompts before generating with package objects if not decided | Router SKILL.md gate check, load_project_config() returns None when no config.json exists |
| PKG-11 | Package selection stored in project config | config.json schema and project.py functions |
| PKG-12 | Object usage gated on project-level package selection | Patcher.__init__(allowed_packages=...) threading to Box.__init__() via db.lookup() |
| PKG-13 | No silent generation with unavailable packages | Validation pipeline package check layer + Patcher-level gating = defense in depth |
</phase_requirements>

## Standard Stack

No new external libraries needed. This phase is purely internal code changes using existing Python modules and project infrastructure.

### Core
| Module | Location | Purpose | Why Standard |
|--------|----------|---------|--------------|
| `src/maxpat/project.py` | Existing | Config read/write, project lifecycle | Already manages all project state |
| `src/maxpat/db_lookup.py` | Existing | ObjectDatabase with allowed_packages | Already has filtering API from Phase 20 |
| `src/maxpat/patcher.py` | Existing | Patcher/Box creation | Needs allowed_packages threading |
| `src/maxpat/validation.py` | Existing | 4-layer validation pipeline | Needs package check layer |
| `.claude/skills/max-lifecycle/` | Existing | Project creation agent | Needs config.json awareness |
| `.claude/skills/max-router/` | Existing | Build dispatch agent | Needs package gate check |

### Supporting
| Module | Location | Purpose | When to Use |
|--------|----------|---------|-------------|
| `package_info.json` | `.claude/max-objects/` | Package registry with tier field | Bundled/community classification for selection UI |
| Agent SKILL.md files | `.claude/skills/max-*-agent/` | Agent instructions | Need "load project config" step in Domain Context Loading |

## Architecture Patterns

### Config.json Schema
```json
{
  "packages": ["BEAP", "Vizzie"]
}
```
Names are exact matches to `package_info.json` keys and `packages/` subdirectory names. [VERIFIED: package_info.json keys match packages/ dir names]

### Project Directory with Config
```
patches/{name}/
  config.json           # Package selection (NEW)
  context.md            # Project vision (existing)
  status.md             # Stage/progress (existing)
  versions.json         # Version history (existing)
  generated/            # Output files (existing)
  test-results/         # Test results (existing)
```

### Pattern 1: Config Read/Write in project.py
**What:** Add `load_project_config()` and `save_project_config()` to project.py
**When to use:** Every generation flow, `/max-new`, `/max-config`
```python
# Source: project.py pattern (existing read_status/update_status pattern)
def load_project_config(project_dir: Path) -> dict | None:
    """Load config.json from project directory.
    
    Returns None if config.json does not exist (project not configured).
    """
    config_path = project_dir / "config.json"
    if not config_path.is_file():
        return None
    return json.loads(config_path.read_text())

def save_project_config(project_dir: Path, config: dict) -> None:
    """Write config.json to project directory."""
    config_path = project_dir / "config.json"
    config_path.write_text(json.dumps(config, indent=2) + "\n")

def get_allowed_packages(project_dir: Path) -> list[str] | None:
    """Get allowed packages from project config.
    
    Returns:
        List of package names if configured, None if no config exists.
        Empty list means core-only (explicitly configured with no packages).
    """
    config = load_project_config(project_dir)
    if config is None:
        return None  # Not configured
    return config.get("packages", [])
```

### Pattern 2: Patcher Threading
**What:** Pass allowed_packages through Patcher to all Box lookups
**When to use:** Every Patcher construction for generation
```python
# Source: patcher.py Patcher.__init__() -- currently line 367
class Patcher:
    def __init__(self, db=None, is_subpatcher=False, allowed_packages=None):
        if db is None:
            db = ObjectDatabase()
        self.db = db
        self.allowed_packages = allowed_packages
        # ... rest unchanged
```

The key insight: `Box.__init__()` calls `db.lookup(name)` at line 183 without `allowed_packages`. This is where gating happens. The Patcher passes its `allowed_packages` when creating boxes:

```python
# In Box.__init__() -- change db.lookup(name) to:
obj_data = db.lookup(name, allowed_packages=allowed_packages)
```

But Box doesn't currently have access to `allowed_packages`. Two approaches:
1. Add `allowed_packages` parameter to `Box.__init__()` -- cleanest, Box carries the context
2. Store `allowed_packages` on ObjectDatabase instance -- changes DB semantics, less clean

**Recommendation:** Option 1. Add `allowed_packages` param to `Box.__init__()`, Patcher passes it through. [ASSUMED]

### Pattern 3: Validation Defense Layer
**What:** Add package check as Layer 2c in validation pipeline
**When to use:** Post-generation validation (validate_patch with db that has package context)
```python
# In validation.py, after _validate_objects_exist:
def _validate_package_gating(
    patch_dict: dict, db: ObjectDatabase, allowed_packages: list[str] | None
) -> list[ValidationResult]:
    """Check that no package objects appear from non-allowed packages."""
    if allowed_packages is None:
        return []  # No package config -- skip check
    results = []
    for box_entry in patch_dict["patcher"]["boxes"]:
        box = box_entry.get("box", {})
        name = _extract_object_name(box)
        if name is None:
            continue
        package = db.get_package(name)
        if package and package not in allowed_packages:
            results.append(ValidationResult(
                "packages", "error",
                f"Object '{name}' from package '{package}' not in project's allowed packages",
            ))
    return results
```

### Pattern 4: Bundled/Community Classification
**What:** Use existing `tier` field in `package_info.json` to split packages for selection UI
**When to use:** `/max-new` and `/max-config` package selection prompts

The `package_info.json` already has a `tier` field with values: "bundled", "community", "licensed". [VERIFIED: package_info.json contains tier field]

```python
# Reading tier classification from existing data:
db = ObjectDatabase()
bundled = []
community = []
for pkg_name in db.list_packages():
    info = db.get_package_info(pkg_name)
    if info and info.get("tier") == "bundled":
        bundled.append(pkg_name)
    else:
        community.append(pkg_name)
```

Current tier breakdown from package_info.json:
- **Bundled (8):** ableton-dsp, Mira, jit.mo, Jitter Geometry, Jitter Tools, BEAP, Vizzie, RNBO Guitar
- **Community (8):** FluCoMa, CNMAT, Bach, Odot, ml-lib, Cage, Dada, EARS, Rhythmic Time Toolkit
- **Licensed (1):** IRCAM Spat
- **Not in package_info.json but in packages/ dir (3):** maxforlive-elements, VIDDLL (these need tier classification added)

[VERIFIED: Read package_info.json directly]

### Pattern 5: Agent Skill Context Loading Update
**What:** Each agent SKILL.md adds a step to read project config and pass allowed_packages
**When to use:** All generation agents

```markdown
## Domain Context Loading

Before any generation:
1. Read `CLAUDE.md` at project root
2. Read project `config.json` via `load_project_config()` for allowed packages
3. Create `ObjectDatabase` and use `allowed_packages` from config when constructing `Patcher`
```

### Anti-Patterns to Avoid
- **Storing allowed_packages on ObjectDatabase instance:** DB is a shared resource; package gating is project-specific. Keep gating at Patcher/Box level.
- **Silently downgrading package objects to warnings:** D-06 says filtered objects are non-existent. `lookup()` returns None, Box raises ValueError. No ambiguity.
- **Default packages enabled:** D-08 says core only until configured. Empty packages list = only core objects available.

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Package tier classification | Custom categorization logic | `package_info.json` tier field | Already exists, already structured |
| Object-to-package mapping | Custom scanning of packages/ dirs | `db.get_package(name)` | ObjectDatabase already indexes this |
| Package filtering | Custom filter on top of lookups | `db.lookup(name, allowed_packages=[...])` | Already implemented in Phase 20 |
| Project config persistence | New config system | `json.loads/dumps` to `config.json` | Matches existing project file pattern |

## Common Pitfalls

### Pitfall 1: Box.__init__() Doesn't Know About Packages
**What goes wrong:** Box constructor calls `db.lookup(name)` without `allowed_packages`, so package objects always pass through even when the Patcher was constructed with filtering intent.
**Why it happens:** Phase 20 added filtering to ObjectDatabase but nothing passes the filter down to Box creation.
**How to avoid:** Thread `allowed_packages` through Patcher -> Box -> db.lookup() explicitly.
**Warning signs:** Tests pass but package objects still appear in generated patches.

### Pitfall 2: from_dict() Bypass
**What goes wrong:** `Patcher.from_dict()` uses `Box.__new__(Box)` to bypass DB validation when loading existing patches. This means package gating only applies to NEW object creation, not to loaded patches.
**Why it happens:** Loading an existing patch shouldn't reject objects that are already there.
**How to avoid:** This is actually correct behavior. from_dict() should NOT gate packages (it's loading, not generating). Validation catches it post-load if needed.
**Warning signs:** If someone tries to add package gating to from_dict(), loaded patches will break.

### Pitfall 3: Subpatcher ObjectDatabase Inheritance
**What goes wrong:** `add_subpatcher()` creates an inner Patcher with `db=self.db`. If Patcher stores allowed_packages, the subpatcher must inherit it.
**Why it happens:** Subpatchers share the parent's DB but might not share the allowed_packages setting.
**How to avoid:** Ensure `add_subpatcher()` passes `allowed_packages=self.allowed_packages` to the inner Patcher constructor.
**Warning signs:** Package objects slip through inside subpatchers.

### Pitfall 4: Validation Pipeline DB Has No Package Context
**What goes wrong:** `validate_patch()` creates its own `ObjectDatabase()` at line 110 when no db is passed. This default DB has no package filtering, so validation doesn't catch package violations.
**Why it happens:** validate_patch() takes an optional `db` parameter but callers often don't pass one.
**How to avoid:** Add `allowed_packages` parameter to `validate_patch()`, or ensure callers always pass the Patcher's db (which knows about packages).
**Warning signs:** Validation reports clean but generated patch has package objects from non-allowed packages.

### Pitfall 5: Missing Packages in package_info.json
**What goes wrong:** Two packages in `packages/` dir (maxforlive-elements, VIDDLL) don't have entries in package_info.json. The tier classification lookup will return None for these.
**Why it happens:** These packages were added to the extraction pipeline but not registered.
**How to avoid:** Either add entries to package_info.json or handle missing info gracefully (treat as community/unknown tier).
**Warning signs:** Package selection UI doesn't show all available packages.

### Pitfall 6: Config Creation Race in create_project()
**What goes wrong:** `create_project()` creates directories and files but doesn't create `config.json`. If the skill expects config.json to exist after project creation, it won't be there until the user answers the package selection prompt.
**Why it happens:** D-08 says "core only until configured" but the lifecycle needs to prompt and write config during `/max-new`.
**How to avoid:** Have `create_project()` NOT create config.json. Let the `/max-new` skill handle the prompt -> write flow separately. `get_allowed_packages()` returning None signals "not configured yet".
**Warning signs:** `/max-build` always blocks because config.json is never created.

## Code Examples

### Reading Project Config for Generation
```python
# Source: Pattern derived from existing project.py and skill loading
from src.maxpat.project import get_active_project, load_project_config
from src.maxpat.patcher import Patcher

# In agent generation flow:
active = get_active_project(base_dir)
project_dir = base_dir / "patches" / active["name"]
config = load_project_config(project_dir)

if config is None:
    # D-03: Block if not configured
    raise RuntimeError("Run /max-new or /max-config to set packages before building")

allowed = config.get("packages", [])
p = Patcher(allowed_packages=allowed)
# All Box() calls through this patcher now respect package gating
```

### Package Selection Prompt Format
```python
# Source: Pattern for /max-new and /max-config
from src.maxpat.db_lookup import ObjectDatabase

db = ObjectDatabase()
pkg_info = {name: db.get_package_info(name) for name in db.list_packages()}

bundled = [name for name, info in pkg_info.items() 
           if info and info.get("tier") == "bundled"]
community = [name for name, info in pkg_info.items()
             if info and info.get("tier") in ("community", "licensed")]

# Present to user:
# "Bundled packages (ship with MAX):"
# for name in sorted(bundled):
#     print(f"  - {name}: {pkg_info[name]['description']}")
# "Community packages (require install):"
# for name in sorted(community):
#     print(f"  - {name}: {pkg_info[name]['description']}")
```

### Validation with Package Check
```python
# Source: Pattern for validate_patch extension
from src.maxpat.validation import validate_patch

# When validating a Patcher instance (has db and allowed_packages):
results = validate_patch(patcher)  # Uses patcher.db and patcher.allowed_packages

# When validating a raw dict (post-generation):
results = validate_patch(patch_dict, db=db, allowed_packages=allowed)
```

## Assumptions Log

| # | Claim | Section | Risk if Wrong |
|---|-------|---------|---------------|
| A1 | Adding `allowed_packages` param to `Box.__init__()` is the cleanest threading approach | Architecture Patterns - Pattern 2 | LOW -- alternative is storing on DB instance, also viable but messier semantically |
| A2 | `maxforlive-elements` and `VIDDLL` packages need tier entries in package_info.json | Pitfalls - Pitfall 5 | LOW -- could handle with fallback instead |

## Open Questions (RESOLVED)

1. **Should `/max-config` be a new skill or extend max-lifecycle?**
   - What we know: max-lifecycle already handles project creation, status, switching
   - What's unclear: Whether config management is a lifecycle concern or separate
   - Recommendation: Extend max-lifecycle -- it already reads/writes project state files. Add `/max-config` to its "When to Use" section. [ASSUMED]

2. **Should config.json be created by `create_project()` or by the `/max-new` skill after prompting?**
   - What we know: D-08 says "core only until configured", D-04 says config.json stores packages
   - What's unclear: Timing -- does create_project() write a default config.json or does the skill handle it?
   - Recommendation: `create_project()` does NOT create config.json. The `/max-new` skill prompts for packages and writes config.json as a separate step. This way `get_allowed_packages()` returning None cleanly signals "not yet configured" for the D-03 block check in `/max-build`.

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | pytest 9.0.2 |
| Config file | tests/ directory with conftest.py |
| Quick run command | `python3 -m pytest tests/test_project.py -x -q` |
| Full suite command | `python3 -m pytest tests/ -x -q` |

### Phase Requirements -> Test Map
| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| PKG-09 | `/max-new` package selection (skill behavior) | manual-only | N/A -- SKILL.md prompt, not code | N/A |
| PKG-10 | `/max-build` blocks without config | unit | `python3 -m pytest tests/test_project.py::TestProjectConfig::test_get_allowed_packages_none_when_no_config -x` | Wave 0 |
| PKG-11 | Package selection stored in config.json | unit | `python3 -m pytest tests/test_project.py::TestProjectConfig -x` | Wave 0 |
| PKG-12 | Object usage gated on packages | unit | `python3 -m pytest tests/test_patcher.py::TestPackageGating -x` | Wave 0 |
| PKG-13 | No silent generation with unavailable packages | unit+integration | `python3 -m pytest tests/test_validation.py::TestPackageValidation -x` | Wave 0 |

### Sampling Rate
- **Per task commit:** `python3 -m pytest tests/test_project.py tests/test_patcher.py tests/test_validation.py -x -q`
- **Per wave merge:** `python3 -m pytest tests/ -x -q`
- **Phase gate:** Full suite green before `/gsd-verify-work`

### Wave 0 Gaps
- [ ] `tests/test_project.py::TestProjectConfig` -- covers PKG-10, PKG-11 (load/save config, get_allowed_packages)
- [ ] `tests/test_patcher.py::TestPackageGating` -- covers PKG-12 (Patcher with allowed_packages filters Box creation)
- [ ] `tests/test_validation.py::TestPackageValidation` -- covers PKG-13 (validation catches package violations)

## Integration Points Summary

All sites where ObjectDatabase() is constructed without package awareness (need changes):

| Location | Line | Current | Change |
|----------|------|---------|--------|
| `patcher.py` Patcher.__init__() | 375 | `ObjectDatabase()` | Accept `allowed_packages`, store on Patcher |
| `patcher.py` Patcher.from_dict() | 1916 | `ObjectDatabase()` | No change needed (loading, not gating) |
| `patcher.py` Box.__init__() | 183 | `db.lookup(name)` | `db.lookup(name, allowed_packages=allowed_packages)` |
| `validation.py` validate_patch() | 110 | `ObjectDatabase()` | Accept `allowed_packages`, add package validation layer |
| `hooks.py` read_patch() | 194 | `Patcher.from_dict(data)` | No change needed (loading) |

Agent skills needing SKILL.md updates:
| Skill | File | Change |
|-------|------|--------|
| max-lifecycle | SKILL.md | Add config.json management, `/max-config` command |
| max-lifecycle | references/project-structure.md | Add config.json to directory layout |
| max-router | SKILL.md | Add package config gate check before dispatch |
| max-patch-agent | SKILL.md | Add config loading to Domain Context Loading |
| max-dsp-agent | SKILL.md | Add config loading to Domain Context Loading |
| max-ui-agent | SKILL.md | Add config loading to Domain Context Loading |
| max-rnbo-agent | SKILL.md | Add config loading to Domain Context Loading |

## Sources

### Primary (HIGH confidence)
- `src/maxpat/db_lookup.py` -- ObjectDatabase.lookup() with allowed_packages parameter (verified lines 108-131)
- `src/maxpat/patcher.py` -- Patcher.__init__(), Box.__init__(), from_dict() (verified lines 367-376, 137-227, 1886-1935)
- `src/maxpat/project.py` -- create_project(), read_status pattern (verified full file)
- `src/maxpat/validation.py` -- validate_patch(), _validate_objects_exist() (verified lines 86-241)
- `.claude/max-objects/package_info.json` -- tier field structure (verified full file)
- `.claude/max-objects/packages/` -- 20 package subdirectories (verified ls output)
- `tests/test_package_schema.py` -- existing package API tests (verified full file)
- `tests/test_project.py` -- existing project tests (verified full file)

### Secondary (MEDIUM confidence)
- Agent SKILL.md files -- verified Domain Context Loading sections

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH -- entirely internal code, all modules verified
- Architecture: HIGH -- clear integration points, existing patterns to follow
- Pitfalls: HIGH -- identified from direct code reading, verified threading gaps

**Research date:** 2026-04-14
**Valid until:** 2026-05-14 (stable internal architecture)
