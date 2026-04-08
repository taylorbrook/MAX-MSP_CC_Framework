# Phase 27: Scaffold Auto-Enforcement - Research

**Researched:** 2026-04-08
**Domain:** M4L device polish pipeline -- parameter_enable and --- prefix automation
**Confidence:** HIGH

## Summary

Phase 27 adds two new passes to the existing `polish_m4l_device()` pipeline in `src/maxpat/m4l_polish.py`: `ensure_parameter_enable()` for SCAFFOLD-04 and `ensure_m4l_prefixes()` for SCAFFOLD-05. Both follow the established polish pass pattern (mutate `patch_dict` in place, return it, fill gaps only / never override).

The codebase is well-structured for this work. The `_collect_live_controls()` helper already iterates all `live.*` boxes recursively and excludes non-parameter objects via `_LIVE_NO_PARAM`. The `_LIVE_NO_PARAM` frozenset in `m4l_critic.py` defines the exclusion list. Named objects follow a simple text-splitting pattern (`"send myname"` -> `"send ---myname"`). Both functions are straightforward dictionary mutations with clear idempotency rules.

**Primary recommendation:** Implement both functions in `m4l_polish.py`, add them to `polish_m4l_device()` before the existing `derive_parameter_names()` pass, and add unit + integration tests to `tests/test_m4l_polish.py`.

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions
- D-01: Add `ensure_parameter_enable()` as a new pass inside `polish_m4l_device()`. Runs post-build, catches all live.* controls regardless of which agent created them.
- D-02: `ensure_parameter_enable()` sets `parameter_enable=1` and creates `saved_attribute_attributes.valueof` with required fields (parameter_type, parameter_unitstyle) on any live.* control that lacks them. Excludes objects in the `_LIVE_NO_PARAM` set from m4l_critic.py.
- D-03: Add `ensure_m4l_prefixes()` as a new pass inside `polish_m4l_device()`. Scans all named objects (buffer~, coll, dict, send, receive, send~, receive~, value) and adds `---` prefix if missing. Supersedes Phase 21 D-04.
- D-04: Prefix enforcement targets objects whose first argument is a name (not `#1` substitution or empty). The `---` prefix is prepended to the name in the box text.
- D-05: Fill gaps only -- never overwrite existing values. Only set `parameter_enable=1` if currently 0 or missing. Only add `---` prefix if not already present. Idempotent.
- D-06: Unit tests for both functions individually with mock patch dicts.
- D-07: Integration test: `create_m4l_project()` -> add controls -> `polish_m4l_device()` -> verify.

### Claude's Discretion
- Exact ordering of ensure_parameter_enable() and ensure_m4l_prefixes() within the polish pipeline
- Default values for parameter_type and parameter_unitstyle when creating saved_attribute_attributes
- How to extract the object name from box text for prefix detection

### Deferred Ideas (OUT OF SCOPE)
None.
</user_constraints>

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|------------------|
| SCAFFOLD-04 | Framework auto-sets parameter_enable=1 with saved_attribute_attributes on all live.* UI controls in M4L context | `ensure_parameter_enable()` pass using `_collect_live_controls()` and `_LIVE_NO_PARAM` exclusion. Ground truth structure from timestretch/wormhole patches. |
| SCAFFOLD-05 | Framework auto-prefixes named objects (buffer~, coll, dict, send, receive, send~, receive~, value) with `---` in M4L context | `ensure_m4l_prefixes()` pass scanning all boxes recursively, splitting text on spaces, prepending `---` to first argument. |
</phase_requirements>

## Standard Stack

### Core
| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| Python | 3.14 | Runtime | Already in use across project [VERIFIED: codebase pyc files] |
| pytest | 9.0.2 | Testing | Already in use, test infrastructure established [VERIFIED: pyc files] |

No new dependencies required. This phase modifies existing Python modules only.

## Architecture Patterns

### Existing Polish Pipeline (ground truth from m4l_polish.py)

```
polish_m4l_device(patch_dict)
  1. derive_parameter_names()    # POLISH-01: fill longname/shortname/varname gaps
  2. organize_push_banks()       # POLISH-02: group params into Push banks of 8
  3. populate_info_text()        # POLISH-03: set annotation/annotation_name
```

### Extended Pipeline (after Phase 27)

```
polish_m4l_device(patch_dict)
  1. ensure_parameter_enable()   # SCAFFOLD-04: set parameter_enable=1 + saved_attribute_attributes
  2. ensure_m4l_prefixes()       # SCAFFOLD-05: add --- prefix to named objects
  3. derive_parameter_names()    # POLISH-01 (existing)
  4. organize_push_banks()       # POLISH-02 (existing)
  5. populate_info_text()        # POLISH-03 (existing)
```

**Ordering rationale:** `ensure_parameter_enable()` MUST run before `derive_parameter_names()` because naming fills in `saved_attribute_attributes.valueof.parameter_longname` -- the valueof dict must already exist. `ensure_m4l_prefixes()` is independent of parameter naming and can run at any position, but placing it early keeps enforcement passes grouped. [VERIFIED: code analysis of m4l_polish.py]

### Pass Signature Pattern
Every polish pass follows the same contract [VERIFIED: m4l_polish.py lines 147, 244, 389]:
```python
def ensure_parameter_enable(patch_dict: dict) -> dict:
    """Mutates patch_dict in place. Returns the same dict."""
    ...
    return patch_dict
```

### _collect_live_controls() Reuse
Already iterates all `live.*` boxes recursively, excludes `_LIVE_NO_PARAM` objects, and returns inner box dicts. Defined at m4l_polish.py line 118. Reuse directly for `ensure_parameter_enable()`. [VERIFIED: source code]

### Box Text Parsing for Named Objects
Named objects use `maxclass="newobj"` with text like `"send myname"` or `"buffer~ mybuf 1000"`. [VERIFIED: gong-model patch has `"send gong-ctrl"` and `"receive gong-ctrl"`]

Extraction logic:
```python
NAMED_OBJECTS = frozenset({
    "buffer~", "coll", "dict", "send", "receive", "send~", "receive~", "value"
})

text = box.get("text", "")
tokens = text.split()
if len(tokens) >= 2 and tokens[0] in NAMED_OBJECTS:
    name_arg = tokens[1]
    if not name_arg.startswith("---") and not name_arg.startswith("#"):
        tokens[1] = "---" + name_arg
        box["text"] = " ".join(tokens)
```

### saved_attribute_attributes Ground Truth Structure
From timestretch and wormhole patches [VERIFIED: patches/timestretch/generated/timestretch.maxpat, patches/wormhole/generated/wormhole-test.maxpat]:

```python
# Minimal structure ensure_parameter_enable() should create
box["parameter_enable"] = 1
box.setdefault("saved_attribute_attributes", {})
box["saved_attribute_attributes"].setdefault("valueof", {})
valueof = box["saved_attribute_attributes"]["valueof"]
valueof.setdefault("parameter_type", ParamType.FLOAT)      # 1 = float (safe default)
valueof.setdefault("parameter_unitstyle", UnitStyle.FLOAT)  # 1 = float display (safe default)
```

**Default values recommendation:**
- `parameter_type`: `ParamType.FLOAT` (1) -- safe default, works for all control types. INT (0) would truncate fractional values. [ASSUMED]
- `parameter_unitstyle`: `UnitStyle.FLOAT` (1) -- neutral display format, doesn't impose units. [ASSUMED]

Both use `setdefault()` to never override existing values (D-05). [VERIFIED: pattern from derive_parameter_names()]

### Recursive Box Scanning for Prefix Enforcement
Must scan into subpatchers like `_collect_live_controls()` does. Named objects inside subpatchers also need `---` prefix. The function should walk `box.get("patcher", {}).get("boxes", [])` recursively. [VERIFIED: m4l_polish.py _collect_live_controls pattern]

### Anti-Patterns to Avoid
- **Modifying box text by index without splitting:** Text may have extra arguments beyond the name (`"buffer~ mybuf 1000"` has 3 tokens). Always rejoin all tokens after prefix. [VERIFIED: maxpat format analysis]
- **Treating maxclass-based objects as newobj:** `live.*` objects use their maxclass directly (e.g., `maxclass="live.dial"`), NOT `maxclass="newobj"`. Named objects like `buffer~` use `maxclass="newobj"` with text. [VERIFIED: m4l objects DB and patcher.py]
- **Forgetting recursive scan:** Both functions must recurse into subpatchers. Missing this means nested controls/named objects get skipped. [VERIFIED: existing _collect_live_controls does recursion]

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Live control collection | Custom box iteration | `_collect_live_controls()` | Already handles recursion, exclusion, and box unwrapping |
| Non-parameter exclusion | Hardcoded list | Import `_LIVE_NO_PARAM` from m4l_critic | Single source of truth, already tested |
| Parameter type/unitstyle values | Magic numbers | Import `ParamType`, `UnitStyle` from m4l_constants | Enum-based, self-documenting |

## Common Pitfalls

### Pitfall 1: ensure_parameter_enable Before derive_parameter_names
**What goes wrong:** If `derive_parameter_names` runs first, it calls `saa.setdefault("valueof", {})` but the control may not have `parameter_enable=1` yet. The naming pass would then fill in names for controls that aren't actually enabled, which is wasted work but not harmful. However, if ensure_parameter_enable runs AFTER naming, it would create the `saved_attribute_attributes.valueof` dict, potentially clearing or conflicting with the naming pass's output.
**Why it happens:** Order dependency between passes.
**How to avoid:** Always run `ensure_parameter_enable()` before `derive_parameter_names()` in the pipeline. The ensure pass creates the skeleton; the naming pass fills in names.
**Warning signs:** Controls with `parameter_enable=1` but empty `parameter_longname`.

### Pitfall 2: Named Object Without Arguments
**What goes wrong:** `"coll"` (no name argument) would be processed incorrectly if the code doesn't check `len(tokens) >= 2`.
**Why it happens:** Not all named objects have a name -- some are unnamed instances.
**How to avoid:** Always check `len(tokens) >= 2` before accessing `tokens[1]`.
**Warning signs:** IndexError in text splitting.

### Pitfall 3: Double-Prefixing
**What goes wrong:** Running polish twice would turn `"send ---myname"` into `"send ------myname"`.
**Why it happens:** Prefix check not done before prepending.
**How to avoid:** Always check `if not name_arg.startswith("---")` before prepending.
**Warning signs:** Objects with `------` prefix in text.

### Pitfall 4: #1 Substitution Arguments
**What goes wrong:** `"buffer~ #1"` is used in bpatchers/abstractions for argument substitution. Adding `---` prefix would break the substitution mechanism (`"buffer~ ---#1"` is not valid).
**Why it happens:** `#1` looks like a name but is actually a substitution token.
**How to avoid:** Skip arguments starting with `#`. D-04 explicitly calls this out.
**Warning signs:** Broken bpatcher argument substitution after polish.

### Pitfall 5: Non-M4L Context
**What goes wrong:** `ensure_m4l_prefixes()` adds `---` prefix to named objects in a non-M4L patch (plain MAX patch), which is incorrect -- `---` prefix is M4L-specific.
**Why it happens:** `polish_m4l_device()` is the entry point and should only be called for M4L devices. But if called on a non-M4L patch, prefix enforcement would incorrectly modify it.
**How to avoid:** This is already handled by the architecture -- `polish_m4l_device()` is only called by agents after M4L device builds. No additional guard needed beyond documentation.
**Warning signs:** `---` prefixes appearing in non-M4L patches.

## Code Examples

### ensure_parameter_enable Implementation Pattern
```python
# Source: analysis of m4l_polish.py patterns + timestretch ground truth
from src.maxpat.critics.m4l_critic import _LIVE_NO_PARAM
from src.maxpat.m4l_constants import ParamType, UnitStyle

def ensure_parameter_enable(patch_dict: dict) -> dict:
    """Set parameter_enable=1 and saved_attribute_attributes on live.* controls.

    Fills gaps only -- never overrides existing values (D-05).
    Excludes non-parameter live objects per _LIVE_NO_PARAM.
    """
    patcher = patch_dict.get("patcher", {})
    boxes = patcher.get("boxes", [])
    controls = _collect_live_controls(boxes)

    for box in controls:
        # D-05: only set if missing or 0
        if not box.get("parameter_enable"):
            box["parameter_enable"] = 1

        # Ensure saved_attribute_attributes.valueof exists with required fields
        saa = box.setdefault("saved_attribute_attributes", {})
        valueof = saa.setdefault("valueof", {})
        valueof.setdefault("parameter_type", int(ParamType.FLOAT))
        valueof.setdefault("parameter_unitstyle", int(UnitStyle.FLOAT))

    return patch_dict
```

### ensure_m4l_prefixes Implementation Pattern
```python
# Source: analysis of CLAUDE.md M4L rules + gong-model patch patterns

_NAMED_OBJECTS = frozenset({
    "buffer~", "coll", "dict", "send", "receive", "send~", "receive~", "value"
})

def ensure_m4l_prefixes(patch_dict: dict) -> dict:
    """Add --- prefix to named objects in M4L devices.

    Scans all boxes recursively. Targets objects whose first argument
    is a name (not #N substitution or empty). Idempotent (D-05).
    """
    patcher = patch_dict.get("patcher", {})
    boxes = patcher.get("boxes", [])
    _prefix_boxes(boxes)
    return patch_dict


def _prefix_boxes(boxes: list[dict]) -> None:
    """Recursively scan and prefix named objects."""
    for box_entry in boxes:
        box = box_entry.get("box", box_entry)
        text = box.get("text", "")
        if text:
            tokens = text.split()
            if (len(tokens) >= 2
                    and tokens[0] in _NAMED_OBJECTS
                    and not tokens[1].startswith("---")
                    and not tokens[1].startswith("#")):
                tokens[1] = "---" + tokens[1]
                box["text"] = " ".join(tokens)

        # Recurse into subpatchers
        inner_patcher = box.get("patcher")
        if inner_patcher:
            _prefix_boxes(inner_patcher.get("boxes", []))
```

### Updated polish_m4l_device
```python
def polish_m4l_device(patch_dict: dict) -> dict:
    """Apply full M4L polish pipeline to a device patch."""
    ensure_parameter_enable(patch_dict)   # SCAFFOLD-04
    ensure_m4l_prefixes(patch_dict)       # SCAFFOLD-05
    derive_parameter_names(patch_dict)    # POLISH-01 (existing)
    organize_push_banks(patch_dict)       # POLISH-02 (existing)
    populate_info_text(patch_dict)        # POLISH-03 (existing)
    return patch_dict
```

### Test Pattern (from existing test_m4l_polish.py)
```python
# Reuses _make_live_control() and _make_patch_with_controls() helpers
# already defined in tests/test_m4l_polish.py

class TestParameterEnableEnforcement:
    def test_sets_parameter_enable_when_missing(self):
        ctrl = _make_live_control(parameter_enable=0)
        patch = _make_patch_with_controls([ctrl])
        ensure_parameter_enable(patch)
        box = patch["patcher"]["boxes"][0]["box"]
        assert box["parameter_enable"] == 1

    def test_creates_saved_attribute_attributes(self):
        ctrl = _make_live_control(parameter_enable=0)
        patch = _make_patch_with_controls([ctrl])
        ensure_parameter_enable(patch)
        box = patch["patcher"]["boxes"][0]["box"]
        saa = box["saved_attribute_attributes"]["valueof"]
        assert "parameter_type" in saa
        assert "parameter_unitstyle" in saa

    def test_preserves_existing_parameter_enable(self):
        ctrl = _make_live_control(parameter_enable=1)
        patch = _make_patch_with_controls([ctrl])
        ensure_parameter_enable(patch)
        box = patch["patcher"]["boxes"][0]["box"]
        assert box["parameter_enable"] == 1

    def test_skips_non_parameter_live_objects(self):
        # live.thisdevice etc. should not get parameter_enable
        ...

    def test_idempotent(self):
        # Run twice, same result
        ...
```

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | pytest 9.0.2 |
| Config file | pytest.ini or pyproject.toml (standard) |
| Quick run command | `python3 -m pytest tests/test_m4l_polish.py -x -q` |
| Full suite command | `python3 -m pytest tests/ -x -q` |

### Phase Requirements -> Test Map
| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| SCAFFOLD-04 | ensure_parameter_enable sets parameter_enable=1 | unit | `python3 -m pytest tests/test_m4l_polish.py::TestParameterEnableEnforcement -x` | Wave 0 |
| SCAFFOLD-04 | ensure_parameter_enable creates saved_attribute_attributes | unit | `python3 -m pytest tests/test_m4l_polish.py::TestParameterEnableEnforcement -x` | Wave 0 |
| SCAFFOLD-04 | ensure_parameter_enable skips _LIVE_NO_PARAM objects | unit | `python3 -m pytest tests/test_m4l_polish.py::TestParameterEnableEnforcement -x` | Wave 0 |
| SCAFFOLD-04 | ensure_parameter_enable idempotent | unit | `python3 -m pytest tests/test_m4l_polish.py::TestParameterEnableEnforcement -x` | Wave 0 |
| SCAFFOLD-05 | ensure_m4l_prefixes adds --- to named objects | unit | `python3 -m pytest tests/test_m4l_polish.py::TestM4LPrefixEnforcement -x` | Wave 0 |
| SCAFFOLD-05 | ensure_m4l_prefixes skips #1 substitution | unit | `python3 -m pytest tests/test_m4l_polish.py::TestM4LPrefixEnforcement -x` | Wave 0 |
| SCAFFOLD-05 | ensure_m4l_prefixes idempotent | unit | `python3 -m pytest tests/test_m4l_polish.py::TestM4LPrefixEnforcement -x` | Wave 0 |
| SCAFFOLD-04+05 | Integration: scaffold -> add controls -> polish -> verify | integration | `python3 -m pytest tests/test_m4l_polish.py::TestEnforcementIntegration -x` | Wave 0 |

### Sampling Rate
- **Per task commit:** `python3 -m pytest tests/test_m4l_polish.py -x -q`
- **Per wave merge:** `python3 -m pytest tests/ -x -q`
- **Phase gate:** Full suite green before `/gsd-verify-work`

### Wave 0 Gaps
None -- existing test infrastructure (`tests/test_m4l_polish.py`) provides the test file, helpers (`_make_live_control`, `_make_patch_with_controls`), and patterns. New test classes are added to this existing file.

## Assumptions Log

| # | Claim | Section | Risk if Wrong |
|---|-------|---------|---------------|
| A1 | ParamType.FLOAT (1) is the best default for parameter_type | Architecture Patterns | LOW -- if wrong, controls would display incorrectly but not crash. Easy to change the default. |
| A2 | UnitStyle.FLOAT (1) is the best default for parameter_unitstyle | Architecture Patterns | LOW -- same as A1, display-only impact. |

Both defaults are conservative choices. INT (0) would truncate fractional values; FLOAT (1) works universally. The existing timestretch device uses both INT (0) and FLOAT (1) depending on the parameter, but FLOAT is the safer default for unknown parameter types.

## Open Questions

None -- all decisions are locked in CONTEXT.md and implementation patterns are clear from the codebase.

## Sources

### Primary (HIGH confidence)
- `src/maxpat/m4l_polish.py` -- Existing polish pipeline, _collect_live_controls(), pass patterns
- `src/maxpat/critics/m4l_critic.py` -- _LIVE_NO_PARAM frozenset (line 27-28)
- `src/maxpat/m4l_constants.py` -- ParamType, UnitStyle enums
- `tests/test_m4l_polish.py` -- Existing test patterns, helpers
- `tests/test_m4l_scaffold.py` -- Scaffold test patterns, NAMED_OBJECTS set
- `patches/timestretch/generated/timestretch.maxpat` -- Ground truth saved_attribute_attributes structure
- `patches/wormhole/generated/wormhole-test.maxpat` -- Ground truth saved_attribute_attributes structure
- `patches/gong-model/generated/gong-model.maxpat` -- Named object examples (send/receive without --- prefix)

### Secondary (MEDIUM confidence)
- `.claude/max-objects/m4l/objects.json` -- M4L object database, 33 objects catalogued

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH -- pure Python, no new dependencies, established patterns
- Architecture: HIGH -- all code reviewed, patterns verified from source
- Pitfalls: HIGH -- edge cases identified from real patches in the codebase

**Research date:** 2026-04-08
**Valid until:** 2026-05-08 (stable domain, no external dependencies)
