# Phase 25: Templates + Critics - Research

**Researched:** 2026-04-15
**Domain:** Package-aware critics and agent workflow templates for MAX/MSP patch generation
**Confidence:** HIGH

## Summary

Phase 25 adds two complementary capabilities: (1) package-specific critics that catch semantic errors the generic validation pipeline misses (BEAP signal convention violations, Bach llll/list type mismatches, unextracted community package usage), and (2) structured workflow templates in agent SKILL.md files for FluCoMa, BEAP, and Bach packages.

The critic system is well-established with 6 existing critics following a consistent `review_{domain}(patch_dict) -> list[CriticResult]` pattern. Adding a new `package_critic.py` module that dispatches to BEAP, Bach, and community-extracted sub-checks is straightforward. The key data infrastructure already exists: BEAP objects have `signal_convention: "0-5V CV"` and `category` fields, Bach objects have `"llll in"` / `"llll out"` digest annotations on 70 of 78 objects, and `ObjectDatabase.get_package()` identifies which package any object belongs to.

Templates are text-based signal chain descriptions (not pre-built .maxpat files) that go into agent SKILL.md files. BEAP templates already exist in PACKAGES.md (5 canonical chains from Phase 23). This phase extends coverage to FluCoMa (real-time analysis chains, offline buffer processing, ML pipelines) and Bach (llll construction, notation workflows, algorithmic composition), plus integrates template suggestions into the `/max-new` lifecycle flow.

**Primary recommendation:** Build `src/maxpat/critics/package_critic.py` with a `review_packages()` entry point that conditionally dispatches to BEAP, Bach, and community-extracted checks based on detected package objects. Wire it into `review_patch()` in `__init__.py` following the RNBO conditional pattern.

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions
- **D-01:** High-value packages only: FluCoMa, BEAP, Bach templates. No other packages.
- **D-02:** Templates are structured signal chain descriptions in agent SKILL.md files -- NOT pre-built .maxpat files.
- **D-03:** Each template includes: which objects, connection order, expected I/O types, common parameter ranges, gotchas.
- **D-04:** Two new critics: BEAP signal convention checker and Bach llll type checker (per PKG-26).
- **D-05:** BEAP critic checks: CV range (0-5V, not +/-1), audio range (+/-1 after VCA), always terminate with bp.Stereo/bp.Mono, gain staging through bp.VCA. Severity: warnings.
- **D-06:** Bach critic checks: llll/list type mismatches (connecting regular MAX list outlets to bach inlets expecting llll), missing bach.list2llll/bach.llll2list conversion. Severity: blockers.
- **D-07:** Community package critic: warn if patch uses community package objects from unextracted packages. Reuses validation layer 2d pattern.
- **D-08:** Templates live in agent SKILL.md files under "Package Workflow Templates" section.
- **D-09:** Template integration with /max-new: lifecycle suggests relevant templates on package selection. No automated scaffolding.
- **D-10:** New `src/maxpat/critics/package_critic.py` module with `review_packages()` function.
- **D-11:** Auto-invoked by `review_patch()` when patch uses package objects.
- **D-12:** BEAP checks only run when BEAP objects detected. Bach checks only when Bach objects detected.

### Claude's Discretion
- Exact template chain compositions beyond canonical examples
- Wording and formatting of template sections in SKILL.md files
- Which specific BEAP convention violations to check (beyond core four in D-05)
- How to detect llll/list type mismatches in Bach critic (object name prefix matching vs. DB field)
- Test fixture design for package critics

### Deferred Ideas (OUT OF SCOPE)
None.
</user_constraints>

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|------------------|
| PKG-23 | Starter templates for common package workflows | BEAP templates exist in PACKAGES.md (Phase 23); FluCoMa and Bach templates need creation in agent SKILL.md files. 53 FluCoMa objects (15 real-time, 38 offline) and 78 Bach objects provide clear workflow patterns. |
| PKG-24 | Package-aware critics (signal conventions, data type checking) | Critic system architecture fully understood: `CriticResult(severity, finding, suggestion)`, 6 existing critics, `review_patch()` dispatcher. BEAP has `signal_convention` field, Bach has `llll` digest annotations. |
| PKG-25 | Template integration with `/max-new` project scaffolding | Lifecycle skill (`max-lifecycle/SKILL.md`) already handles package selection; needs template suggestion text added to the package selection flow. |
| PKG-26 | Dedicated critics for BEAP signal conventions and Bach llll handling | BEAP: all 185 objects tagged `"0-5V CV"`, 7 Output objects (bp.Stereo, bp.Mono, etc.), bp.VCA is sole gain staging module. Bach: 70/78 objects have `"llll in"` digest, `bach.list2llll`/`bach.llll2list` are the conversion bridge objects. |
</phase_requirements>

## Architecture Patterns

### Recommended Project Structure (new files)

```
src/maxpat/critics/
  package_critic.py          # NEW: review_packages() entry point
  __init__.py                # MODIFIED: add review_packages import + call

.claude/skills/
  max-patch-agent/SKILL.md   # MODIFIED: add Package Workflow Templates section
  max-dsp-agent/SKILL.md     # MODIFIED: add FluCoMa/BEAP DSP templates
  max-lifecycle/SKILL.md     # MODIFIED: add template suggestion on package select
```

### Pattern 1: Package Critic Module Structure
**What:** Single `package_critic.py` module with `review_packages()` that conditionally dispatches to sub-checks
**When to use:** Any patch that contains package objects

The existing critic pattern from `dsp_critic.py` and the RNBO conditional invocation pattern in `__init__.py` provide the exact blueprint. [VERIFIED: src/maxpat/critics/__init__.py, dsp_critic.py]

```python
# Source: Modeled on existing critic architecture
from src.maxpat.critics.base import CriticResult
from src.maxpat.db_lookup import ObjectDatabase
from src.maxpat.utils import get_box_name

def review_packages(
    patch_dict: dict,
    db: ObjectDatabase | None = None,
) -> list[CriticResult]:
    """Review package-specific semantics.
    
    Dispatches to BEAP, Bach, and community checks based on
    which package objects are detected in the patch.
    """
    results: list[CriticResult] = []
    if db is None:
        db = ObjectDatabase()
    
    patcher = patch_dict.get("patcher", {})
    boxes = patcher.get("boxes", [])
    lines = patcher.get("lines", [])
    
    # Detect which packages are used
    packages_used: set[str] = set()
    box_lookup: dict[str, dict] = {}
    for box_entry in boxes:
        box = box_entry.get("box", {})
        box_id = box.get("id")
        if box_id:
            box_lookup[box_id] = box
        name = get_box_name(box)
        pkg = db.get_package(name)
        if pkg:
            packages_used.add(pkg)
    
    # Conditional dispatch
    if "BEAP" in packages_used:
        results.extend(_check_beap_conventions(box_lookup, lines, db))
    if "Bach" in packages_used:
        results.extend(_check_bach_llll_types(box_lookup, lines, db))
    
    # Community extraction check (all community packages)
    results.extend(_check_community_extracted(box_lookup, db))
    
    return results
```

### Pattern 2: BEAP Convention Checking
**What:** BFS/adjacency analysis of BEAP signal chains checking 4 core conventions
**When to use:** Any patch with `bp.*` objects

The BEAP critic should check (per D-05):
1. **No bp.Output termination:** BEAP chain has no bp.Stereo/bp.Mono at the end
2. **Missing bp.VCA:** Oscillator connected directly to output without VCA gain staging
3. **CV range misuse:** Non-BEAP control signals (0-1 range) fed to BEAP CV inlets expecting 0-5V (NOTE: this is harder to detect statically, recommend starting with checks 1-2 and the simpler 4)
4. **Non-BEAP audio to BEAP:** Standard MSP audio (+/-1) connected to BEAP input expecting 0-5V CV

Key data available in DB: [VERIFIED: .claude/max-objects/packages/BEAP/objects.json]
- All 185 BEAP objects have `"package": "BEAP"` field
- All have `"signal_convention": "0-5V CV"` 
- `category` field classifies: Oscillator (15), Output (7), Level (16, includes bp.VCA), Filter (12), etc.
- Output objects (bp.Stereo, bp.Mono, etc.) have 0 outlets -- they are true signal terminators
- bp.VCA: inlet 0 = signal input, inlet 1 = CV input (0-5V), outlet 0 = scaled output

```python
# BEAP output object names
_BEAP_OUTPUT_NAMES = frozenset({
    "bp.Stereo", "bp.Mono", "bp.Calibrated", 
    "bp.Calibrated_64bit", "bp.M4L Out", "bp.Recordr", "bp.Snapshotter",
})

_BEAP_SOURCE_CATEGORIES = frozenset({
    "Oscillator", "Input", "Random",
})
```

### Pattern 3: Bach llll Type Mismatch Detection
**What:** Check connections where non-bach outlets feed bach inlets that expect llll data
**When to use:** Any patch with `bach.*` objects

The detection strategy: [VERIFIED: .claude/max-objects/packages/Bach/objects.json]
- 70 of 78 bach objects have `"llll in"` in their inlet digest -- these REQUIRE llll data
- Only 4 bach objects lack llll annotation: `bach.explode`, `bach.list2llll`, `bach.llll2list`, `bach.wrap`
- `bach.list2llll` is the ONLY converter from MAX lists to llll format
- If a non-bach object outlet connects to a bach inlet with `"llll"` in its digest, AND the source is not `bach.list2llll`, it's a type mismatch (blocker severity)

Detection approach (recommended): **Inlet digest matching + source package check**
```python
def _is_llll_inlet(obj_entry: dict, inlet_id: int) -> bool:
    """Check if an object's inlet expects llll data."""
    for inlet in obj_entry.get("inlets", []):
        if inlet["id"] == inlet_id:
            return "llll" in inlet.get("digest", "").lower()
    return False
```

For each patchline:
1. Get destination object and inlet
2. Look up in DB -- does this inlet have "llll" in its digest?
3. If yes, check source object -- is it a bach.* object (outputs llll) or bach.list2llll?
4. If source is non-bach and not bach.list2llll, emit blocker

### Pattern 4: Community Extraction Check (Critic Wrapper)
**What:** Wrap the existing validation layer 2d logic for the critic pipeline
**When to use:** All patches (lightweight -- skips quickly for non-community packages)

The validation pipeline already has `_validate_community_extracted()` (layer 2d). [VERIFIED: src/maxpat/validation.py line 344] The critic version reuses the same logic but returns `CriticResult` instead of `ValidationResult`. Per D-07, this is a wrapper.

### Pattern 5: review_patch() Integration
**What:** Add package critic to the `review_patch()` dispatcher
**When to use:** N/A -- wiring change

Following the RNBO conditional pattern: [VERIFIED: src/maxpat/critics/__init__.py]

```python
# In __init__.py review_patch():
# Package critic: auto-invoke when package objects detected
if _has_package_boxes(patch_dict, db):
    results.extend(review_packages(patch_dict, db=db))
```

Note: `review_packages()` needs an `ObjectDatabase` instance. The current `review_patch()` does not receive one. Two options:
- **Option A:** Create DB inside `review_packages()` (like validation.py does). Slightly wasteful but no API change.
- **Option B:** Add optional `db` parameter to `review_patch()`. Cleaner but changes existing signature.

**Recommendation:** Option A (internal DB creation) for Phase 25. Avoids breaking existing callers. The DB load is fast (cached in practice since other code paths already loaded it).

### Anti-Patterns to Avoid
- **Checking bpatcher maxclass instead of object name:** BEAP/Vizzie objects have `maxclass: "bpatcher"` -- must use `get_box_name()` which extracts the text field name. But bpatchers use the `name` attribute for their abstraction reference, not the `text` field. Need to check both `box.get("name", "")` for bpatchers and standard `get_box_name()`. [VERIFIED: BEAP objects in DB have maxclass "bpatcher"]
- **Assuming all bach connections are type mismatches:** `bach.list2llll` accepts plain MAX lists (that's its whole purpose). Don't flag connections TO `bach.list2llll`.
- **Running expensive graph traversal on every patch:** Use early-exit -- if no BEAP/Bach objects detected, return immediately. The `packages_used` set check is O(n) in boxes but avoids graph analysis.

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Object name extraction | Custom text parsing | `get_box_name()` from utils.py | Handles newobj vs maxclass correctly |
| Package detection | String prefix matching | `ObjectDatabase.get_package(name)` | Handles CNMAT (bare names), aliases, edge cases |
| llll type detection | Hardcoded object list | Inlet digest `"llll"` substring check | Scales with DB updates, covers all annotated objects |
| Community extraction status | Filesystem probing | `get_package_info(pkg).get("extracted")` flag | Consistent with validation layer 2d approach |
| Graph traversal for gain staging | New BFS implementation | Adapt existing `_check_gain_staging` pattern from dsp_critic.py | Proven adjacency-list + BFS pattern |

## Common Pitfalls

### Pitfall 1: Bpatcher Name Resolution
**What goes wrong:** `get_box_name()` returns empty string or "bpatcher" for BEAP modules because bpatchers use `maxclass: "bpatcher"` and the name lives in the `name` attribute, not `text`.
**Why it happens:** `get_box_name()` returns `text.split()[0]` for newobj, and `maxclass` for everything else. Bpatchers have `maxclass: "bpatcher"`.
**How to avoid:** For bpatcher boxes, check `box.get("name", "")` to get the abstraction name (e.g., "bp.Oscillator"). The package critic needs a bpatcher-aware name resolver.
**Warning signs:** All BEAP/Vizzie objects returning package=None from `get_package()`.

### Pitfall 2: Bach llll False Positives from Message Boxes
**What goes wrong:** Message boxes or number boxes legitimately connect to bach objects (e.g., `bach.score` accepts messages like `addchord`). Flagging these as llll mismatches would be noisy.
**Why it happens:** Not all bach inlets exclusively accept llll -- some accept messages/ints too. Only inlets with "llll" in the digest require llll format.
**How to avoid:** Check the specific inlet digest, not just "is destination a bach object." Only flag connections to inlets whose digest contains "llll".
**Warning signs:** Excessive false positive warnings on valid bach patches.

### Pitfall 3: BEAP Signal Convention -- Can't Verify CV Range Statically
**What goes wrong:** Trying to verify 0-5V CV range from patch structure alone is impossible -- signal values are determined at runtime.
**Why it happens:** BEAP convention is a design guideline, not something enforceable from static patch analysis.
**How to avoid:** Focus BEAP checks on structural conventions (output termination, VCA presence in chain) rather than trying to verify actual signal values. D-05 specifies severity as "warning" not "blocker" for exactly this reason.
**Warning signs:** Attempting to infer signal amplitudes from object parameters alone.

### Pitfall 4: review_m4l Not in review_patch() -- Inconsistent Pattern
**What goes wrong:** Assuming the M4L critic integration pattern matches the RNBO pattern.
**Why it happens:** `review_m4l` is NOT wired into `review_patch()` -- it exists as a standalone function. Only DSP, structure, layout, RNBO, and external critics are in the dispatcher.
**How to avoid:** The package critic SHOULD be wired into `review_patch()` (per D-11). Follow the RNBO pattern, not the M4L pattern.
**Warning signs:** N/A -- just don't copy M4L integration approach.

## Code Examples

### Example 1: Detecting Package Objects in a Patch

```python
# Source: Modeled on _has_rnbo_boxes() in critics/__init__.py
def _has_package_boxes(patch_dict: dict, db: ObjectDatabase | None = None) -> bool:
    """Check if a patch contains any package objects."""
    if db is None:
        db = ObjectDatabase()
    patcher = patch_dict.get("patcher", {})
    for box_entry in patcher.get("boxes", []):
        box = box_entry.get("box", {})
        # Handle both newobj (text field) and bpatcher (name field)
        name = get_box_name(box)
        if box.get("maxclass") == "bpatcher":
            name = box.get("name", "")
        if name and db.get_package(name):
            return True
    return False
```

### Example 2: BEAP Output Termination Check

```python
# Source: Modeled on _check_gain_staging in dsp_critic.py
def _check_beap_output_termination(
    box_lookup: dict[str, dict],
    lines: list[dict],
    db: ObjectDatabase,
) -> list[CriticResult]:
    """Check that BEAP signal chains terminate with an output module."""
    results: list[CriticResult] = []
    
    # Find all BEAP source objects (Oscillator, Input, Random categories)
    beap_sources = []
    for box_id, box in box_lookup.items():
        name = _get_beap_name(box)
        if not name:
            continue
        obj_entry = db.lookup(name)
        if obj_entry and obj_entry.get("category") in _BEAP_SOURCE_CATEGORIES:
            beap_sources.append(box_id)
    
    # BFS from each source, check if it reaches an output module
    # (adapted from gain staging BFS in dsp_critic.py)
    # ...
    
    return results
```

### Example 3: Bach llll Type Mismatch Check

```python
# Source: Adapted from _check_audio_rate_consistency in dsp_critic.py
def _check_bach_llll_types(
    box_lookup: dict[str, dict],
    lines: list[dict],
    db: ObjectDatabase,
) -> list[CriticResult]:
    """Detect non-bach objects connected to bach inlets expecting llll."""
    results: list[CriticResult] = []
    
    for line_entry in lines:
        patchline = line_entry.get("patchline", line_entry)
        source = patchline.get("source", [])
        destination = patchline.get("destination", [])
        if len(source) < 2 or len(destination) < 2:
            continue
        
        src_id = source[0]
        dst_id, dst_inlet = destination[0], destination[1]
        
        src_box = box_lookup.get(src_id)
        dst_box = box_lookup.get(dst_id)
        if not src_box or not dst_box:
            continue
        
        src_name = _get_object_name(src_box)
        dst_name = _get_object_name(dst_box)
        
        # Only check connections TO bach objects
        dst_entry = db.lookup(dst_name)
        if not dst_entry or dst_entry.get("package") != "Bach":
            continue
        
        # Skip bach.list2llll -- it's designed to accept plain lists
        if dst_name == "bach.list2llll":
            continue
        
        # Check if this inlet expects llll
        if not _is_llll_inlet(dst_entry, dst_inlet):
            continue
        
        # Source must be a bach object (outputs llll) or bach.list2llll
        src_entry = db.lookup(src_name)
        src_is_bach = src_entry and src_entry.get("package") == "Bach"
        if src_name == "bach.list2llll":
            src_is_bach = True
        
        if not src_is_bach:
            results.append(CriticResult(
                "blocker",
                f"Bach llll type mismatch: '{src_name}' ({src_id}) "
                f"connected to '{dst_name}' ({dst_id}) inlet {dst_inlet} "
                f"which expects llll data -- plain MAX lists will silently "
                f"produce garbage",
                f"Insert 'bach.list2llll' between '{src_name}' and "
                f"'{dst_name}' to convert MAX list to llll format",
            ))
    
    return results
```

### Example 4: Template Format for Agent SKILL.md

```markdown
## Package Workflow Templates

### FluCoMa: Real-time Audio Analysis Chain

**Objects:** audio source -> fluid.melbands~ -> fluid.stats -> fluid.normalize -> downstream
**Use case:** Extract real-time spectral features from audio for ML input or visualization

| # | Source | Outlet | Destination | Inlet | Type |
|---|--------|--------|-------------|-------|------|
| 1 | (audio source) | 0 | fluid.melbands~ | 0 (audio in) | signal |
| 2 | fluid.melbands~ | 0 (features) | fluid.stats | 0 (input) | list |
| 3 | fluid.stats | 0 (stats) | fluid.normalize | 0 (input) | list |

**Gotchas:**
- fluid.melbands~ outputs a list of band energies, NOT a signal
- fluid.stats accumulates over time -- send "reset" message to clear
- fluid.normalize needs training data first -- send "fit" before "transform"
```

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | pytest 9.0.2 |
| Config file | pyproject.toml (implicit) |
| Quick run command | `python3 -m pytest tests/test_critics.py -x` |
| Full suite command | `python3 -m pytest tests/ -x` |

### Phase Requirements to Test Map
| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| PKG-24 | review_packages() returns findings for BEAP/Bach issues | unit | `python3 -m pytest tests/test_critics.py -x -k "package"` | Wave 0 |
| PKG-26-a | BEAP critic detects missing output termination | unit | `python3 -m pytest tests/test_critics.py -x -k "beap_output"` | Wave 0 |
| PKG-26-b | BEAP critic detects missing VCA gain staging | unit | `python3 -m pytest tests/test_critics.py -x -k "beap_vca"` | Wave 0 |
| PKG-26-c | Bach critic detects llll/list mismatch | unit | `python3 -m pytest tests/test_critics.py -x -k "bach_llll"` | Wave 0 |
| PKG-26-d | Bach critic allows bach-to-bach connections | unit | `python3 -m pytest tests/test_critics.py -x -k "bach_clean"` | Wave 0 |
| PKG-24-comm | Community extraction critic warns on unextracted packages | unit | `python3 -m pytest tests/test_critics.py -x -k "community"` | Wave 0 |
| PKG-23 | Templates exist in SKILL.md files | grep-verify | `grep "Package Workflow Templates" .claude/skills/max-*/SKILL.md` | manual |
| PKG-25 | Lifecycle skill suggests templates on package selection | grep-verify | `grep -l "template" .claude/skills/max-lifecycle/SKILL.md` | manual |

### Sampling Rate
- **Per task commit:** `python3 -m pytest tests/test_critics.py -x`
- **Per wave merge:** `python3 -m pytest tests/ -x`
- **Phase gate:** Full suite green before `/gsd-verify-work`

### Wave 0 Gaps
- [ ] `tests/test_critics.py` -- add TestPackageCritic class with BEAP/Bach/community fixtures (file exists, class does not)
- [ ] Test fixtures for: BEAP patch without output termination, BEAP patch missing VCA, Bach patch with llll mismatch, clean BEAP/Bach patches
- [ ] Framework install: N/A (pytest already available)

## Security Domain

Not applicable -- this phase adds internal validation logic and documentation content. No external inputs, authentication, cryptography, or access control involved. `security_enforcement` applies to the validation output (which strengthens patch safety), but no ASVS categories are directly applicable to the implementation itself.

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| No package-specific semantic checks | Generic validation only (layer 2 object existence, layer 2c package gating) | Phase 22 (April 2026) | Package objects pass validation but may violate package conventions |
| No agent workflow templates | BEAP templates in PACKAGES.md (Phase 23) | Phase 23 (April 2026) | Agents have BEAP guidance but not FluCoMa/Bach |
| Community packages silently fail | Layer 2d warns on unextracted community packages (Phase 24) | Phase 24 (April 2026) | Validation catches unextracted, but critics don't |

## Assumptions Log

| # | Claim | Section | Risk if Wrong |
|---|-------|---------|---------------|
| A1 | Bpatcher boxes in .maxpat use `name` attribute (not `text`) for the abstraction reference name like "bp.Oscillator" | Architecture Patterns / Pitfall 1 | Package detection would fail for all BEAP/Vizzie objects; need to verify actual .maxpat bpatcher structure |
| A2 | FluCoMa real-time objects output list data from non-signal outlets, not signal data | Code Examples (template) | Template connection types may be wrong; verify with actual FluCoMa help files |
| A3 | `bach.list2llll` is the ONLY bridge from MAX lists to llll format (no other bach object auto-converts) | Architecture Pattern 3 | False negatives in Bach critic if other objects also accept plain lists |

## Open Questions

1. **Bpatcher name resolution in get_box_name()**
   - What we know: `get_box_name()` returns maxclass for non-newobj objects, which gives "bpatcher" for all BEAP/Vizzie modules
   - What's unclear: The exact attribute name used in .maxpat JSON for the bpatcher abstraction reference (`name`? `args[0]`? `bgpatching_rect.name`?)
   - Recommendation: Inspect an actual BEAP .maxpat patch in `tests/fixtures/` or generate a test bpatcher to verify the exact JSON key. May need to extend `get_box_name()` or create `get_bpatcher_name()`.

2. **Bach objects with multiple inlet types**
   - What we know: 70/78 bach objects have "llll in" on inlet 0; some objects like `bach.*` have llll on inlets 0 AND 1
   - What's unclear: Whether bach objects accept messages on the same llll inlet (e.g., `bach.score` accepts both llll and specific messages like `addchord`)
   - Recommendation: Treat the critic conservatively -- only flag connections from non-bach control outlets to llll inlets. Message boxes connecting to bach objects should be allowed (they send specific messages, not raw lists).

3. **FluCoMa offline objects -- completion pattern**
   - What we know: `fluid.buf*` objects output bang on completion, not immediate results. 38 offline objects in DB.
   - What's unclear: Whether templates should encode the async completion pattern (bang -> trigger next step)
   - Recommendation: Include async pattern in FluCoMa templates with explicit note about bang-on-completion flow.

## Sources

### Primary (HIGH confidence)
- `src/maxpat/critics/__init__.py` -- review_patch() dispatcher, _has_rnbo_boxes() conditional pattern [VERIFIED]
- `src/maxpat/critics/base.py` -- CriticResult(severity, finding, suggestion) class [VERIFIED]
- `src/maxpat/critics/dsp_critic.py` -- BFS gain staging pattern, box_lookup construction, adjacency analysis [VERIFIED]
- `src/maxpat/critics/m4l_critic.py` -- Package-specific critic pattern, standalone invocation [VERIFIED]
- `.claude/max-objects/packages/BEAP/objects.json` -- 185 objects, all with signal_convention="0-5V CV", category field [VERIFIED]
- `.claude/max-objects/packages/Bach/objects.json` -- 78 objects, 70 with "llll in" digest annotation [VERIFIED]
- `.claude/max-objects/packages/FluCoMa/objects.json` -- 53 objects (15 real-time, 38 offline) [VERIFIED]
- `src/maxpat/validation.py` lines 344-399 -- _validate_community_extracted() layer 2d pattern [VERIFIED]
- `src/maxpat/db_lookup.py` -- get_package(), get_package_info(), ObjectDatabase API [VERIFIED]
- `src/maxpat/utils.py` -- get_box_name() implementation [VERIFIED]
- `.claude/max-objects/PACKAGES.md` -- Existing BEAP/Vizzie templates, signal conventions, functional roles [VERIFIED]
- `.claude/max-objects/relationships.json` -- 17 BEAP relationship pairs (bp.Keyboard+bp.Oscillator etc.) [VERIFIED]
- `.claude/skills/max-patch-agent/SKILL.md` -- Agent skill structure, needs template section [VERIFIED]
- `.claude/skills/max-dsp-agent/SKILL.md` -- DSP agent skill structure, needs FluCoMa/BEAP templates [VERIFIED]
- `.claude/skills/max-lifecycle/SKILL.md` -- Lifecycle skill, package selection flow [VERIFIED]
- `.claude/skills/max-critic/SKILL.md` -- Critic orchestrator, review_patch() usage [VERIFIED]
- `tests/test_critics.py` -- 56 existing tests, _make_patch() fixture helper [VERIFIED]
- `.planning/config.json` -- nyquist_validation: true [VERIFIED]
- `.claude/max-objects/package_info.json` -- Package registry with tier/extracted fields [VERIFIED]

### Secondary (MEDIUM confidence)
- `.planning/phases/23-agent-package-intelligence/23-CONTEXT.md` -- BEAP functional roles, template patterns [VERIFIED]

### Tertiary (LOW confidence)
- None

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH -- all code, DB, and patterns verified from existing codebase
- Architecture: HIGH -- follows established critic system patterns with clear extension points
- Pitfalls: HIGH -- identified from concrete code analysis (get_box_name, bpatcher maxclass)

**Research date:** 2026-04-15
**Valid until:** 2026-05-15 (stable -- internal architecture, no external dependencies)
