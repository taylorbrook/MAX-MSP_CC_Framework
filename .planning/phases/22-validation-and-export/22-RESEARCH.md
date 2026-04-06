# Phase 22: Validation and Export - Research

**Researched:** 2026-04-06
**Domain:** M4L critic validation + .amxd binary export
**Confidence:** HIGH

## Summary

Phase 22 adds two new modules: `m4l_critic.py` (M4L device semantic validation) and `m4l_export.py` (AMXD binary export). Both follow established project patterns -- the critic follows the RNBO critic template exactly, and the export follows the hooks.py file-write pattern.

The codebase is well-prepared. `m4l_constants.py` already defines the full AMXD binary header format (struct-verified at 32 bytes). The critic system (`critics/__init__.py`) has a clean auto-detection pattern via `_has_rnbo_boxes()` that the M4L equivalent mirrors. The scaffold code from Phase 21 (`create_m4l_project()`) establishes the device structures the critic validates against.

**Primary recommendation:** Follow existing patterns strictly. The M4L critic is a straightforward port of the RNBO critic pattern with M4L-specific checks. The AMXD export is a struct.pack + json.dumps + file write. Both are < 200 lines each.

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions
- **D-01:** Report only -- M4L critic returns CriticResult findings with severity levels (error/warning/info), same as existing critics. Does not block file writes. Agents and hooks read results and decide how to act. Keeps critic system consistent across all domains.
- **D-02:** Standalone `write_amxd(patch_path, output_path, device_type)` function in a new `src/maxpat/m4l_export.py` module. Called explicitly by agents or user -- export is a deliberate step, not auto-triggered on save. Clean separation from hooks.py.
- **D-03:** Detection strategy is Claude's discretion. Must wire into `critics/__init__.py` so M4L critic auto-invokes when device type detected (SC#4). Pattern follows existing `_has_rnbo_boxes()` approach.
- **D-04:** Full device quality validation beyond the 3 required checks (gain~/plugout~, completeness, parameter uniqueness) plus openinpresentation, devicewidth, live.thisdevice presentation_rect, parameter_enable blocks, parameter ranges, orphaned live.* objects.
- **D-05:** plugout~ and plugin~ added to `_TERMINAL_NAMES` / `_IO_OBJECT_NAMES` in dsp_critic.py and layout.py (SC#6).

### Claude's Discretion
- M4L device auto-detection approach (simple pattern check vs confidence-scored -- D-03)
- Internal structure of m4l_critic.py (function signatures, helper organization)
- Severity assignment for quality checks beyond VALID-01/02/03 (warning vs info)
- How device_type is inferred from patch structure for auto-detection

### Deferred Ideas (OUT OF SCOPE)
None -- discussion stayed within phase scope
</user_constraints>

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|------------------|
| VALID-01 | M4L critic detects gain~ connected to plugout~ and flags as error | Extend `_TERMINAL_NAMES` in dsp_critic.py to include `plugout~`. Existing BFS gain-staging check already handles this once plugout~ is a terminal. |
| VALID-02 | M4L critic validates device completeness (required objects per device type) | M4L critic scans for plugin~/plugout~/midiin/midiout/live.thisdevice. Device type rules from `create_m4l_project()` define requirements per type. |
| VALID-03 | M4L critic validates unique parameter_longname across device | Scan all boxes for `saved_attribute_attributes.valueof.parameter_longname`. Collect into set, flag duplicates as blocker. |
| EXPORT-01 | write_amxd() produces valid .amxd files with correct binary header per device type | `m4l_constants.py` has complete header format. struct.pack + json.dumps + file write. |
</phase_requirements>

## Standard Stack

### Core

No new external libraries. Phase 22 uses only Python stdlib.

| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| struct (stdlib) | Python 3.14 | Pack AMXD binary header | Only way to write binary format in Python |
| json (stdlib) | Python 3.14 | Serialize patch JSON for AMXD body | Already used throughout codebase |
| pathlib (stdlib) | Python 3.14 | File path handling | Project convention |

[VERIFIED: Python 3.14 stdlib -- no external deps needed]

### Supporting

| Library | Version | Purpose | When to Use |
|---------|---------|---------|-------------|
| src.maxpat.critics.base | internal | CriticResult class | Every critic finding |
| src.maxpat.utils | internal | get_box_name() | Object name extraction from box dicts |
| src.maxpat.m4l_constants | internal | AMXD_* constants, ParamType enums | write_amxd() header construction |
| src.maxpat.project | internal | auto_commit_patch() | Post-export git commit |

## Architecture Patterns

### New File Structure
```
src/maxpat/
  critics/
    __init__.py          # Modified: add M4L auto-detection + import
    dsp_critic.py        # Modified: add plugout~ to _TERMINAL_NAMES
    m4l_critic.py        # NEW: M4L device validation critic
  layout.py              # Modified: add plugin~/plugout~ to _IO_OBJECT_NAMES
  m4l_export.py          # NEW: write_amxd() function
  m4l_constants.py       # EXISTS: AMXD constants (no changes)
```

### Pattern 1: M4L Critic Structure (follows rnbo_critic.py exactly)

**What:** Single public function `review_m4l()` with private helper functions for each check.
**When to use:** All new domain critics.
**Example:**
```python
# Source: src/maxpat/critics/rnbo_critic.py (existing pattern)
from src.maxpat.critics.base import CriticResult
from src.maxpat.utils import get_box_name

def review_m4l(
    patch_dict: dict,
    device_type: str | None = None,
) -> list[CriticResult]:
    """Review M4L aspects of a patch."""
    results: list[CriticResult] = []
    patcher = patch_dict.get("patcher", {})
    boxes = patcher.get("boxes", [])

    # Detect device type if not explicitly provided
    if device_type is None:
        device_type = _detect_device_type(patcher, boxes)

    if device_type is None:
        return results  # Not an M4L device

    results.extend(_check_gain_plugout(boxes, patcher.get("lines", [])))
    results.extend(_check_device_completeness(boxes, device_type))
    results.extend(_check_parameter_uniqueness(boxes))
    results.extend(_check_device_quality(patcher, boxes))
    return results
```
[VERIFIED: pattern matches rnbo_critic.py at src/maxpat/critics/rnbo_critic.py]

### Pattern 2: Auto-Detection in __init__.py

**What:** Boolean detection function + conditional critic invocation.
**When to use:** Domain-specific critics that should only run when relevant.
**Example:**
```python
# Source: src/maxpat/critics/__init__.py (existing _has_rnbo_boxes pattern)
def _detect_m4l_device(patch_dict: dict) -> str | None:
    """Detect M4L device type from patch structure.

    Returns device_type string or None if not M4L.
    Uses confidence-scored approach:
      - live.thisdevice present = strong M4L signal
      - plugin~/plugout~ = audio_effect or instrument
      - midiin/midiout without plugout~ = midi_effect
      - openinpresentation=1 + devicewidth set = supporting evidence
    """
    patcher = patch_dict.get("patcher", {})
    boxes = patcher.get("boxes", [])

    has_thisdevice = False
    has_plugin = False
    has_plugout = False
    has_midiin = False
    has_midiout = False

    for box_entry in boxes:
        box = box_entry.get("box", {})
        name = get_box_name(box)
        if name == "live.thisdevice" or box.get("maxclass") == "live.thisdevice":
            has_thisdevice = True
        elif name == "plugin~":
            has_plugin = True
        elif name == "plugout~":
            has_plugout = True
        elif name == "midiin":
            has_midiin = True
        elif name == "midiout":
            has_midiout = True

    # Must have live.thisdevice to be M4L
    if not has_thisdevice:
        return None

    # Classify device type
    if has_plugin and has_plugout:
        return "audio_effect"
    elif has_plugout and has_midiin:
        return "instrument"
    elif has_midiin and has_midiout and not has_plugout:
        return "midi_effect"
    elif has_plugout:
        return "audio_effect"  # plugout~ without plugin~ still audio
    else:
        return None  # Has live.thisdevice but can't determine type
```
[VERIFIED: detection logic derived from create_m4l_project() scaffold patterns at src/maxpat/project.py:146-161]

### Pattern 3: AMXD Export (follows hooks.py write pattern)

**What:** Standalone function that reads .maxpat JSON, prepends binary header, writes .amxd.
**When to use:** Explicit export step after patch is finalized.
**Example:**
```python
# Source: src/maxpat/m4l_constants.py (AMXD constants)
import struct
import json
from pathlib import Path
from src.maxpat.m4l_constants import (
    AMXD_MAGIC, AMXD_VERSION, AMXD_META_MARKER,
    AMXD_META_VERSION, AMXD_PATCH_MARKER, AMXD_HEADER_FORMAT,
    AMXD_TYPE_AUDIO_EFFECT, AMXD_TYPE_INSTRUMENT, AMXD_TYPE_MIDI_EFFECT,
)

_DEVICE_TYPE_BYTES = {
    "audio_effect": AMXD_TYPE_AUDIO_EFFECT,
    "instrument": AMXD_TYPE_INSTRUMENT,
    "midi_effect": AMXD_TYPE_MIDI_EFFECT,
}

def write_amxd(
    patch_path: str | Path,
    output_path: str | Path,
    device_type: str,
) -> Path:
    """Export a .maxpat as .amxd with correct binary header."""
    patch_path = Path(patch_path)
    output_path = Path(output_path)

    # Read and re-serialize JSON (normalize formatting)
    patch_json = patch_path.read_text(encoding="utf-8")
    patch_data = json.loads(patch_json)
    json_bytes = json.dumps(patch_data, indent="\t").encode("utf-8")

    type_bytes = _DEVICE_TYPE_BYTES[device_type]
    header = struct.pack(
        AMXD_HEADER_FORMAT,
        AMXD_MAGIC,        # b"ampf"
        AMXD_VERSION,      # 4
        type_bytes,         # b"aaaa" / b"iiii" / b"mmmm"
        AMXD_META_MARKER,  # b"meta"
        AMXD_META_VERSION,  # 4
        # 4 zero bytes (padding) handled by 4x in format
        AMXD_PATCH_MARKER,  # b"ptch"
        len(json_bytes),    # JSON byte length
    )

    output_path.parent.mkdir(parents=True, exist_ok=True)
    with open(output_path, "wb") as f:
        f.write(header)
        f.write(json_bytes)
        f.flush()
        os.fsync(f.fileno())

    return output_path
```
[VERIFIED: header format from m4l_constants.py, struct.calcsize confirms 32 bytes]

### Anti-Patterns to Avoid
- **Blocking saves in critic:** D-01 says report only. Critics return findings, never raise exceptions or block file writes.
- **Auto-triggering export on save:** D-02 says explicit step only. write_amxd() is standalone, not part of hooks.py pipeline.
- **Putting detection in m4l_critic.py:** Detection logic belongs in `__init__.py` alongside `_has_rnbo_boxes()`. The critic receives device_type, it does not detect it.
- **Duplicating gain staging check:** VALID-01 (gain~->plugout~) is solved by adding plugout~ to `_TERMINAL_NAMES` in dsp_critic.py. The existing BFS gain check already handles it. The M4L critic should NOT reimplement gain staging -- it gets this for free.

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Binary header packing | Manual byte concatenation | `struct.pack()` with `AMXD_HEADER_FORMAT` | Endianness, alignment, field sizes all handled |
| Object name extraction | Custom text parsing | `get_box_name()` from utils.py | Handles newobj vs UI maxclass distinction |
| Gain->terminal detection | New BFS in m4l_critic | Add plugout~ to `_TERMINAL_NAMES` in dsp_critic.py | Existing BFS gain staging check covers it |
| JSON serialization | Custom formatter | `json.dumps(indent="\t")` | AMXD files use tab indentation (community convention) |

**Key insight:** VALID-01 (gain~->plugout~ detection) is NOT a new check. It is a 1-line change adding `"plugout~"` to `_TERMINAL_NAMES` in dsp_critic.py. The existing gain staging BFS already detects gain~ feeding any terminal without intervening *~ or gain~.

## Common Pitfalls

### Pitfall 1: AMXD JSON Indentation
**What goes wrong:** .amxd files use tab indentation, not the 4-space indent from .maxpat files.
**Why it happens:** Developers copy the save_patch_roundtrip() pattern which uses space indentation.
**How to avoid:** Use `json.dumps(indent="\t")` for AMXD body. MAX/Live expects tabs in .amxd. [ASSUMED]
**Warning signs:** Ableton fails to load the device or shows parsing errors.

### Pitfall 2: Duplicate _TERMINAL_NAMES Definitions
**What goes wrong:** `_TERMINAL_NAMES` exists in BOTH `validation.py` (line 41) and `dsp_critic.py` (line 33). They are separate frozensets with different contents. Adding plugout~ to one but not the other leaves a gap.
**Why it happens:** Two independent modules grew organically.
**How to avoid:** Add plugout~ to BOTH: `validation.py` (unterminated chain detection) and `dsp_critic.py` (gain staging check). The validation.py set also includes `send~` and `out~` which dsp_critic does not.
**Warning signs:** Validation reports "unterminated signal chain" on M4L patches with plugout~.
[VERIFIED: validation.py line 41 has `{"dac~", "ezdac~", "send~", "out~"}`, dsp_critic.py line 33 has `{"dac~", "ezdac~"}`]

### Pitfall 3: maxclass vs Name for live.thisdevice
**What goes wrong:** `get_box_name()` returns the maxclass for UI objects. `live.thisdevice` has `maxclass="live.thisdevice"`, not `maxclass="newobj"`. So `get_box_name()` returns `"live.thisdevice"` correctly. But plugin~/plugout~ have `maxclass="plugin~"` / `maxclass="plugout~"` in the DB (not `"newobj"`).
**Why it happens:** The DB says maxclass is `"plugin~"` but ground truth from a real MAX patch shows `"newobj"` with text `"plugin~"`. STATE.md flagged this as a Phase 20 blocker.
**How to avoid:** Detection logic must check BOTH `get_box_name(box)` AND `box.get("maxclass")` for live.thisdevice. For plugin~/plugout~, check `get_box_name()` which handles both cases (returns first word of text for newobj, or maxclass for UI objects).
**Warning signs:** Detection fails on real .maxpat files loaded from MAX.
[VERIFIED: STATE.md blocker note, get_box_name() implementation at src/maxpat/utils.py]

### Pitfall 4: Parameter Longname in Nested Patchers
**What goes wrong:** VALID-03 only checks top-level boxes and misses parameters in subpatchers (bpatchers, p objects).
**Why it happens:** M4L devices often organize controls in subpatchers. Parameter names must be unique across the ENTIRE device, not just the top level.
**How to avoid:** Recursive scan through all nested patchers when collecting parameter_longname values.
**Warning signs:** Duplicate parameter names cause Ableton to show "Parameter name conflict" warnings that are hard to debug.
[ASSUMED -- recursive scanning needed based on M4L architecture knowledge]

### Pitfall 5: Empty parameter_longname
**What goes wrong:** live.* objects without a set parameter_longname get auto-generated names like "live.dial[2]". These are not real duplicates but can collide.
**Why it happens:** MAX auto-assigns longnames when parameter_enable=1 but no explicit name is set.
**How to avoid:** Only flag duplicates between explicitly-set longnames (non-empty strings). Empty/missing longnames are a separate "warning" level finding (no explicit name set).
**Warning signs:** False positive blocker findings on devices where MAX auto-names parameters.
[ASSUMED -- based on M4L parameter naming behavior]

## Code Examples

Verified patterns from the existing codebase:

### Collecting Parameter Longnames (recursive)
```python
# Based on rnbo_critic.py pattern for scanning inner patchers
def _collect_parameter_longnames(
    boxes: list[dict],
    found: dict[str, str] | None = None,
) -> dict[str, str]:
    """Collect parameter_longname -> box_id mapping, recursing into subpatchers.

    Args:
        boxes: List of box entries [{"box": {...}}, ...].
        found: Accumulator dict. Created if None.

    Returns:
        Dict mapping parameter_longname to first box_id that uses it.
    """
    if found is None:
        found = {}

    for box_entry in boxes:
        box = box_entry.get("box", {})
        box_id = box.get("id", "?")

        # Check for parameter_longname in saved_attribute_attributes
        saa = box.get("saved_attribute_attributes", {})
        valueof = saa.get("valueof", {})
        longname = valueof.get("parameter_longname", "")

        if longname:
            if longname in found:
                pass  # Duplicate -- caller handles
            else:
                found[longname] = box_id

        # Recurse into subpatchers
        inner = box.get("patcher")
        if inner:
            inner_boxes = inner.get("boxes", [])
            _collect_parameter_longnames(inner_boxes, found)

    return found
```
[VERIFIED: saved_attribute_attributes.valueof.parameter_longname path confirmed by project codebase scan of patcher.py line 320-321]

### Device Completeness Check
```python
# Source: create_m4l_project() rules at src/maxpat/project.py:146-161
_REQUIRED_OBJECTS = {
    "audio_effect": {"plugout~", "live.thisdevice"},
    "instrument": {"plugout~", "midiin", "midiout", "live.thisdevice"},
    "midi_effect": {"midiin", "midiout", "live.thisdevice"},
}
# plugin~ is expected for audio_effect but not strictly required
# (pass-through devices may omit it)
```
[VERIFIED: matches scaffold code at src/maxpat/project.py:146-161]

### Wiring M4L Critic into __init__.py
```python
# Source: existing pattern in src/maxpat/critics/__init__.py:70-71
from src.maxpat.critics.m4l_critic import review_m4l

# In review_patch():
device_type = _detect_m4l_device(patch_dict)
if device_type is not None:
    results.extend(review_m4l(patch_dict, device_type=device_type))
```
[VERIFIED: follows _has_rnbo_boxes() / review_rnbo() pattern at __init__.py:70-71]

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| Manual M4L validation | Automated M4L critic | Phase 22 (now) | Catches errors before Ableton |
| .maxpat only output | .amxd export | Phase 22 (now) | Complete device creation loop |
| plugout~ not terminal | plugout~ in _TERMINAL_NAMES | Phase 22 (now) | gain~ checks work for M4L |

## Assumptions Log

| # | Claim | Section | Risk if Wrong |
|---|-------|---------|---------------|
| A1 | .amxd files use tab indentation for JSON body | Pitfalls: AMXD JSON Indentation | Ableton may fail to load device -- verify against a real .amxd file if available |
| A2 | Parameter longnames must be scanned recursively through subpatchers | Pitfalls: Nested Patchers | Missed duplicates in complex devices |
| A3 | Empty parameter_longname should not be flagged as duplicate | Pitfalls: Empty parameter_longname | False positive blockers |
| A4 | The AMXD binary format has no trailing binary block needed for basic export | Architecture: AMXD Export | Some community posts mention "binary block at end" but m4l_constants.py defines header-only format. If trailing data is required, write_amxd() output may not load in Ableton |

## Open Questions

1. **AMXD trailing binary data**
   - What we know: Community forum mentions "a binary block at the end" of .amxd files. m4l_constants.py only defines the 32-byte header.
   - What's unclear: Whether the trailing data is required for Ableton to load the device, or if it's optional metadata (checksums, etc.).
   - Recommendation: Start with header-only approach per m4l_constants.py. If Ableton rejects it, investigate what trailing bytes are needed. User can verify by loading in Ableton (TEST-01 in Phase 25).

2. **plugin~/plugout~ maxclass discrepancy**
   - What we know: Object DB says `maxclass="plugin~"` but STATE.md flagged that ground truth shows `maxclass="newobj"`. This was assigned as Phase 20 blocker but Phase 20 has no directory.
   - What's unclear: Whether this was resolved or deferred.
   - Recommendation: Detection code should handle both cases via `get_box_name()` which works regardless. The DB maxclass value only matters for Patcher.add_box() serialization -- if the scaffold produces working patches, the maxclass is correct enough.

## Environment Availability

Step 2.6: SKIPPED (no external dependencies identified -- pure Python code changes using only stdlib)

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | pytest 9.0.2 |
| Config file | pytest runs from repo root |
| Quick run command | `python3 -m pytest tests/test_critics.py tests/test_m4l_scaffold.py -x -q` |
| Full suite command | `python3 -m pytest tests/ -x -q` |

### Phase Requirements to Test Map
| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| VALID-01 | gain~->plugout~ flagged as error | unit | `python3 -m pytest tests/test_m4l_critic.py::TestGainPlugout -x` | Wave 0 |
| VALID-02 | Device completeness per type | unit | `python3 -m pytest tests/test_m4l_critic.py::TestDeviceCompleteness -x` | Wave 0 |
| VALID-03 | Unique parameter_longname | unit | `python3 -m pytest tests/test_m4l_critic.py::TestParameterUniqueness -x` | Wave 0 |
| EXPORT-01 | write_amxd() correct binary header | unit | `python3 -m pytest tests/test_m4l_export.py -x` | Wave 0 |
| SC#4 | Auto-detection wired into __init__.py | unit | `python3 -m pytest tests/test_critics.py::TestReviewPatchM4L -x` | Wave 0 |
| SC#6 | plugin~/plugout~ in _IO_OBJECT_NAMES | unit | `python3 -m pytest tests/test_m4l_critic.py::TestTerminalNames -x` | Wave 0 |

### Sampling Rate
- **Per task commit:** `python3 -m pytest tests/test_m4l_critic.py tests/test_m4l_export.py -x -q`
- **Per wave merge:** `python3 -m pytest tests/ -x -q`
- **Phase gate:** Full suite green before `/gsd-verify-work`

### Wave 0 Gaps
- [ ] `tests/test_m4l_critic.py` -- covers VALID-01, VALID-02, VALID-03, SC#4, SC#6
- [ ] `tests/test_m4l_export.py` -- covers EXPORT-01
- No framework install needed -- pytest already available

## Project Constraints (from CLAUDE.md)

- Rule #1: Never Guess Objects -- critic must use ObjectDatabase or get_box_name(), not hardcoded assumptions
- Rule #7: Commit After Every Save -- write_amxd() must auto-commit via auto_commit_patch()
- Rule #5: No Generator Scripts -- write_amxd() is an export function, not a generator
- MSP gain safety rule -- values feeding *~ for volume must be 0.0-1.0 range
- All patches target MAX 9

## Sources

### Primary (HIGH confidence)
- `src/maxpat/critics/rnbo_critic.py` -- Template for new critic module structure
- `src/maxpat/critics/__init__.py` -- Auto-detection and review_patch() wiring pattern
- `src/maxpat/critics/dsp_critic.py` -- _TERMINAL_NAMES and gain staging BFS
- `src/maxpat/critics/base.py` -- CriticResult class (severity/finding/suggestion)
- `src/maxpat/m4l_constants.py` -- AMXD binary header format (32 bytes, verified via struct.calcsize)
- `src/maxpat/validation.py` -- Separate _TERMINAL_NAMES that also needs plugout~
- `src/maxpat/project.py:99-171` -- create_m4l_project() device type rules (ground truth for completeness checks)
- `src/maxpat/layout.py:1091-1094` -- _IO_OBJECT_NAMES set
- `src/maxpat/utils.py:6-18` -- get_box_name() for box name extraction
- `src/maxpat/hooks.py` -- File write + fsync + auto-commit pattern

### Secondary (MEDIUM confidence)
- [Cycling '74 Forum: Max For Live Device File Format](https://cycling74.com/forums/max-for-live-device-file-format) -- confirms header + JSON + trailing binary structure
- [Cycling '74 Docs: Device Parameters](https://docs.cycling74.com/max7/vignettes/live_parameters) -- parameter_longname documentation

### Tertiary (LOW confidence)
- AMXD tab indentation assumption -- needs validation against real .amxd file

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH -- pure stdlib, no external dependencies
- Architecture: HIGH -- follows established project patterns exactly
- Pitfalls: HIGH -- dual _TERMINAL_NAMES verified via codebase grep; maxclass discrepancy documented in STATE.md
- AMXD export: MEDIUM -- header format verified via struct but trailing data question unresolved

**Research date:** 2026-04-06
**Valid until:** 2026-05-06 (stable -- internal project patterns, no external API drift)
