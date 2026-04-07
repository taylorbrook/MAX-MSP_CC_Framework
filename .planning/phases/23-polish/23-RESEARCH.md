# Phase 23: Polish - Research

**Researched:** 2026-04-06
**Domain:** M4L parameter metadata, Push banks, info text annotations
**Confidence:** HIGH

## Summary

Phase 23 adds parameter naming intelligence, Push controller bank organization, and info text annotations to M4L devices. The work centers on a new standalone module `m4l_polish.py` that post-processes patch dicts to fill gaps in parameter metadata, plus critic warnings for missing polish.

All three requirements operate on the same data structures: the `saved_attribute_attributes.valueof` block on live.* UI controls (for POLISH-01 naming and POLISH-03 info text) and the `_parameter_banks` key on the live.banks box (for POLISH-02 Push banks). The existing codebase provides strong foundations: `_collect_parameter_longnames()` in m4l_critic.py already recursively traverses all boxes including subpatchers, and the `UnitStyle` enum in m4l_constants.py maps directly to display units needed for info text formatting.

**Primary recommendation:** Build `m4l_polish.py` as a single module with three public functions (`derive_parameter_names`, `organize_push_banks`, `populate_info_text`) composed by `polish_m4l_device()`. Then extend m4l_critic.py with two new warning checks. Tests use the same `_make_patch` helper pattern from test_m4l_critic.py.

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions
- **D-01:** Dual approach -- agents set names during /max-build via SKILL.md rules, post-process function fills gaps and derives missing names. Post-process does NOT normalize or override agent-set names.
- **D-02:** Longname fallback derives from varname or box text. If varname is "filter_cutoff", longname becomes "Filter Cutoff" (underscore-to-space, title case).
- **D-03:** Shortname uses abbreviation table (Frequency->Freq, Resonance->Reso, Envelope->Env, Modulation->Mod, etc.) then truncates to 8 chars max.
- **D-04:** Varname auto-derived from longname as snake_case lowercase: "Filter Cutoff" -> "filter_cutoff".
- **D-05:** Parameters grouped into banks of 8 by semantic function, auto-detected from parameter names/varnames. E.g., pitch params in bank 1, amp params in bank 2, filter in bank 3.
- **D-06:** Bank names auto-derived from parameter group content. Bank containing Cutoff/Resonance/Drive -> "Filter".
- **D-07:** Partial banks padded with empty slots -- standard Push behavior, no merging of small groups.
- **D-08:** Contextual info text that describes what the parameter does and how it affects the sound. E.g., "Controls the lowpass filter cutoff. Higher values brighten the sound."
- **D-09:** Info text includes unit style and range from parameter_unitstyle. E.g., "Range: 20-20000 Hz" or "Range: 0-127 (MIDI)".
- **D-10:** Agents generate contextual info text during build (they understand DSP context). Post-process fills generic fallbacks for anything missed.
- **D-11:** New standalone module `src/maxpat/m4l_polish.py` with `polish_m4l_device(patch_dict)` function.
- **D-12:** Explicit call -- agents call polish after build, before export. Not auto-triggered on save or wired into hooks.
- **D-13:** M4L critic (m4l_critic.py) expanded to flag missing info text and absent live.banks as warnings -- gentle nudge to run polish.

### Claude's Discretion
- Abbreviation table contents (specific word->abbreviation mappings beyond the examples)
- Semantic clustering algorithm for Push bank grouping (keyword matching, varname prefix analysis, etc.)
- Generic fallback info text templates for post-process gap-filling
- Function signatures and internal structure of m4l_polish.py

### Deferred Ideas (OUT OF SCOPE)
None -- discussion stayed within phase scope
</user_constraints>

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|------------------|
| POLISH-01 | Parameter naming intelligence auto-derives longname, shortname, and varname from context | Verified: saved_attribute_attributes.valueof contains parameter_longname, parameter_shortname; varname is a top-level box attribute. Derive logic follows D-01 through D-04. |
| POLISH-02 | Push controller bank organization via live.banks | Verified: live.banks object in DB, uses message-based API (new/edit/delete). Bank data stored in `_parameter_banks` box attribute (undocumented format, needs ASSUMED handling). Parameters referenced by longname. |
| POLISH-03 | Info text / annotations auto-populated on live.* controls | Verified: `annotation` (body) and `annotation_name` (header) are top-level box attributes on 13 live.* UI objects. Displayed in Ableton Info View on hover. |
</phase_requirements>

## Standard Stack

### Core
| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| Python 3 | 3.14 | Runtime | Project standard [VERIFIED: codebase] |
| pytest | 9.0.2 | Testing | Project standard [VERIFIED: `pytest --version`] |

### Supporting
No new dependencies needed. This phase is pure Python operating on dict structures.

## Architecture Patterns

### Recommended Project Structure
```
src/maxpat/
  m4l_polish.py          # NEW: polish functions (POLISH-01, 02, 03)
  m4l_constants.py       # EXISTING: UnitStyle, ParamType enums
  critics/
    m4l_critic.py        # MODIFY: add info text + live.banks warnings
tests/
  test_m4l_polish.py     # NEW: polish function tests
  test_m4l_critic.py     # MODIFY: add tests for new warnings
```

### Pattern 1: Standalone Module Pattern
**What:** `m4l_polish.py` follows the same pattern as `m4l_export.py` -- a standalone module with a top-level function called explicitly by agents. [VERIFIED: m4l_export.py pattern in codebase]
**When to use:** Always for this phase.
**Example:**
```python
# Source: pattern from src/maxpat/m4l_export.py
def polish_m4l_device(patch_dict: dict) -> dict:
    """Apply parameter naming, Push banks, and info text polish.
    
    Fills gaps only -- does NOT override agent-set values.
    Mutates patch_dict in place and returns it.
    """
    derive_parameter_names(patch_dict)
    organize_push_banks(patch_dict)
    populate_info_text(patch_dict)
    return patch_dict
```

### Pattern 2: Recursive Box Traversal
**What:** Reuse the recursive traversal pattern from `_collect_parameter_longnames()` in m4l_critic.py to find all live.* controls across the entire patcher hierarchy. [VERIFIED: m4l_critic.py line 156-187]
**When to use:** All three polish functions need to discover parameters in subpatchers.
**Example:**
```python
# Source: existing pattern in src/maxpat/critics/m4l_critic.py
def _collect_live_controls(boxes: list[dict]) -> list[dict]:
    """Recursively collect all live.* UI control boxes."""
    controls = []
    for box_entry in boxes:
        box = box_entry.get("box", box_entry)
        maxclass = box.get("maxclass", "")
        if maxclass.startswith("live.") and maxclass not in _LIVE_NO_PARAM:
            controls.append(box)
        # Recurse into subpatchers
        inner = box.get("patcher")
        if inner:
            controls.extend(_collect_live_controls(inner.get("boxes", [])))
    return controls
```

### Pattern 3: saved_attribute_attributes Structure
**What:** The canonical JSON format for M4L parameter metadata on live.* controls. [VERIFIED: wormhole-test.maxpat, timestretch.maxpat]
**Example:**
```python
# Source: verified from patches/timestretch/generated/timestretch.maxpat
{
    "id": "obj-19",
    "maxclass": "live.dial",
    "parameter_enable": 1,
    "varname": "filter_cutoff",       # <- POLISH-01 derives this
    "annotation_name": "Cutoff",      # <- POLISH-03 sets this
    "annotation": "Controls the lowpass filter cutoff frequency. Higher values brighten the sound. Range: 20-20000 Hz",  # <- POLISH-03 sets this
    "saved_attribute_attributes": {
        "valueof": {
            "parameter_longname": "Filter Cutoff",   # <- POLISH-01 derives
            "parameter_shortname": "Cutoff",          # <- POLISH-01 derives
            "parameter_type": 1,
            "parameter_unitstyle": 3,                 # HERTZ
            "parameter_mmin": 20.0,
            "parameter_mmax": 20000.0,
            "parameter_modmode": 0
        }
    }
}
```

### Pattern 4: live.banks JSON Box Structure
**What:** How live.banks stores parameter bank data in the .maxpat JSON. [ASSUMED -- undocumented internal format]
**Example:**
```python
# ASSUMED: based on training knowledge, not verified against real .maxpat
{
    "id": "obj-banks",
    "maxclass": "live.banks",
    "numinlets": 1,
    "numoutlets": 1,
    "outlettype": [""],
    "patching_rect": [20.0, 20.0, 315.0, 45.0],
    "_parameter_banks": {
        "banks": [
            {
                "name": "Pitch",
                "parameters": [
                    "Pitch Start", "Pitch End", "Pitch Decay",
                    "Pitch Curve", "-", "-", "-", "-"
                ]
            },
            {
                "name": "Amp",
                "parameters": [
                    "Amp Decay", "Amp Curve", "Body Level",
                    "-", "-", "-", "-", "-"
                ]
            }
        ]
    }
}
```
**Critical note:** The `_parameter_banks` format is ASSUMED. The actual storage format may differ. Implementation should generate banks via `new` messages on loadbang as a safe fallback if direct JSON injection doesn't work. Bank parameters are referenced by their `parameter_longname`. [CITED: docs.cycling74.com/reference/live.banks]

### Pattern 5: Critic Warning Pattern
**What:** Adding new checks to m4l_critic.py follows the existing four-check structure. [VERIFIED: m4l_critic.py]
**Example:**
```python
# Source: pattern from src/maxpat/critics/m4l_critic.py
def _check_missing_info_text(boxes: list[dict]) -> list[CriticResult]:
    """Flag live.* controls missing annotation text."""
    results = []
    for box_entry in boxes:
        box = box_entry.get("box", box_entry)
        maxclass = box.get("maxclass", "")
        if maxclass.startswith("live.") and maxclass not in _LIVE_NO_PARAM:
            if not box.get("annotation"):
                results.append(CriticResult(
                    "warning",
                    f"{maxclass} ({box.get('id', '?')}) missing info text",
                    "Run polish_m4l_device() or set annotation manually",
                ))
    return results
```

### Anti-Patterns to Avoid
- **Overriding agent-set names:** Post-process MUST NOT normalize or change names that agents already set (D-01). Only fill gaps.
- **Hardcoding shortname truncation without abbreviation:** Always try abbreviation table first, then truncate to 8 chars as last resort.
- **Merging small banks:** Partial banks pad with "-" (empty slots). Do not merge Filter (3 params) + Mixer (2 params) into one bank (D-07).

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Recursive box traversal | New traversal logic | Pattern from `_collect_parameter_longnames()` | Already handles subpatchers, tested |
| UnitStyle display strings | Hardcoded unit strings | `UnitStyle` enum from m4l_constants.py | Canonical source of truth |
| Box name extraction | Custom text parsing | `get_box_name()` from utils.py | Handles newobj vs maxclass correctly |
| Live.* control detection | Inline maxclass checks | `_LIVE_NO_PARAM` frozenset from m4l_critic.py | Already maintained set |

## Common Pitfalls

### Pitfall 1: Shortname Length
**What goes wrong:** Shortname exceeds display limit, gets truncated unpredictably by Push
**Why it happens:** Official docs say "5 to 7 characters" range; CONTEXT.md decision says 8 chars max. The actual max is 8 characters but narrower characters (like 'i', 'l') allow more visible chars than wide ones (like 'M', 'W'). [CITED: docs.cycling74.com/reference/live.dial]
**How to avoid:** Abbreviate first (table lookup), then hard-truncate at 8 chars. Never leave shortname longer than 8.
**Warning signs:** Shortname over 8 chars in test output.

### Pitfall 2: Duplicate Parameter Longnames
**What goes wrong:** Polish function generates duplicate longnames, causing Ableton to silently merge parameters.
**Why it happens:** When deriving longnames from varname, two controls with similar varnames could produce identical longnames.
**How to avoid:** After deriving names, run uniqueness check. If collision found, append index suffix (e.g., "Filter Cutoff 2"). The existing `_check_parameter_uniqueness()` in m4l_critic.py already validates this.
**Warning signs:** Critic blocker about duplicate parameter_longname.

### Pitfall 3: Bank Parameter References
**What goes wrong:** live.banks references parameters by name, but uses the wrong name field.
**Why it happens:** Banks reference parameters by `parameter_longname`, not varname or shortname. If polish derives longname AFTER bank creation, banks reference stale names.
**How to avoid:** Run naming derivation (POLISH-01) BEFORE bank organization (POLISH-02). The `polish_m4l_device()` function must call them in order. [CITED: docs.cycling74.com/reference/live.banks -- banks use parameter symbol names]
**Warning signs:** Push banks showing empty slots for parameters that exist.

### Pitfall 4: Overwriting Agent-Set Values
**What goes wrong:** Post-process overwrites carefully crafted agent names/info text.
**Why it happens:** Not checking whether a value already exists before setting it.
**How to avoid:** Every setter in m4l_polish.py must check for existing non-empty values first. Pattern: `if not valueof.get("parameter_longname"):` before writing.
**Warning signs:** Agent-crafted names disappearing after polish.

### Pitfall 5: Info Text Without Context
**What goes wrong:** Generic fallback info text is useless ("Controls a parameter").
**Why it happens:** Post-process has no DSP context -- it only sees parameter names and types.
**How to avoid:** Generic fallbacks should incorporate available metadata: parameter name, unit style, range. E.g., "Frequency control. Range: 20-20000 Hz" is better than "Controls a parameter." [D-08, D-09, D-10]
**Warning signs:** All info text looking identical.

## Code Examples

### Example 1: Parameter Name Derivation
```python
# Core naming logic for POLISH-01

# Abbreviation table (Claude's discretion per CONTEXT.md)
_ABBREVIATIONS = {
    "frequency": "Freq",
    "resonance": "Reso",
    "envelope": "Env",
    "modulation": "Mod",
    "amplitude": "Amp",
    "oscillator": "Osc",
    "sustain": "Sust",
    "release": "Rel",
    "attack": "Atk",
    "decay": "Dcy",
    "velocity": "Vel",
    "volume": "Vol",
    "feedback": "Fdbk",
    "distortion": "Dist",
    "compressor": "Comp",
    "threshold": "Thresh",
    "milliseconds": "ms",
    "filter": "Filt",
    "output": "Out",
    "input": "In",
    "level": "Lvl",
}


def _varname_to_longname(varname: str) -> str:
    """Convert varname to longname: 'filter_cutoff' -> 'Filter Cutoff' (D-02)."""
    return varname.replace("_", " ").title()


def _longname_to_varname(longname: str) -> str:
    """Convert longname to varname: 'Filter Cutoff' -> 'filter_cutoff' (D-04)."""
    return longname.lower().replace(" ", "_")


def _abbreviate_shortname(longname: str, max_len: int = 8) -> str:
    """Derive shortname from longname using abbreviation table (D-03).
    
    Strategy: abbreviate individual words, then truncate to max_len.
    If longname is already <= max_len, use as-is.
    """
    if len(longname) <= max_len:
        return longname
    
    words = longname.split()
    # Try abbreviating longest words first
    abbreviated = []
    for word in words:
        lower = word.lower()
        if lower in _ABBREVIATIONS:
            abbreviated.append(_ABBREVIATIONS[lower])
        else:
            abbreviated.append(word)
    
    result = " ".join(abbreviated)
    if len(result) <= max_len:
        return result
    
    # Still too long -- drop leading context words, keep last word
    # "Filter Cutoff" -> "Cutoff", "Amp Envelope Decay" -> "Env Dcy"
    while len(result) > max_len and len(abbreviated) > 1:
        abbreviated.pop(0)
        result = " ".join(abbreviated)
    
    # Final truncation
    return result[:max_len]
```

### Example 2: Semantic Bank Grouping
```python
# Semantic clustering for POLISH-02 (Claude's discretion)

_BANK_KEYWORDS = {
    "Pitch": {"pitch", "tune", "tuning", "detune", "transpose", "semitone", "cent", "octave"},
    "Amp": {"amp", "amplitude", "volume", "level", "gain", "velocity", "body"},
    "Filter": {"filter", "cutoff", "resonance", "reso", "freq", "tone", "drive", "hp", "lp", "bp"},
    "Envelope": {"envelope", "env", "attack", "decay", "sustain", "release", "adsr", "curve"},
    "Mod": {"modulation", "mod", "lfo", "rate", "depth", "amount", "speed"},
    "FX": {"delay", "reverb", "chorus", "flanger", "phaser", "distortion", "comp", "eq"},
    "Noise": {"noise", "sub"},
    "Mix": {"mix", "dry", "wet", "send", "return", "pan", "width"},
}


def _classify_parameter(varname: str) -> str:
    """Classify a parameter into a semantic group by varname prefix/keywords."""
    parts = set(varname.lower().replace("_", " ").split())
    prefix = varname.lower().split("_")[0] if "_" in varname else ""
    
    best_group = "Main"
    best_score = 0
    for group_name, keywords in _BANK_KEYWORDS.items():
        score = len(parts & keywords)
        # Bonus for prefix match
        if prefix in keywords:
            score += 2
        if score > best_score:
            best_score = score
            best_group = group_name
    
    return best_group
```

### Example 3: Info Text Generation
```python
# Generic fallback info text for POLISH-03

from src.maxpat.m4l_constants import UnitStyle

_UNIT_LABELS = {
    UnitStyle.INT: "",
    UnitStyle.FLOAT: "",
    UnitStyle.TIME: "ms",
    UnitStyle.HERTZ: "Hz",
    UnitStyle.DECIBEL: "dB",
    UnitStyle.PERCENT: "%",
    UnitStyle.PAN: "(L/R)",
    UnitStyle.SEMITONES: "st",
    UnitStyle.MIDI: "(MIDI)",
    UnitStyle.CUSTOM: "",
}


def _make_range_text(valueof: dict) -> str:
    """Build range string from parameter metadata (D-09)."""
    mmin = valueof.get("parameter_mmin")
    mmax = valueof.get("parameter_mmax")
    unitstyle = valueof.get("parameter_unitstyle", 0)
    
    if mmin is None and mmax is None:
        return ""
    
    label = _UNIT_LABELS.get(UnitStyle(unitstyle), "")
    parts = []
    if mmin is not None:
        parts.append(f"{mmin:g}")
    if mmax is not None:
        parts.append(f"{mmax:g}")
    
    range_str = "-".join(parts)
    if label:
        return f"Range: {range_str} {label}"
    return f"Range: {range_str}"
```

### Example 4: Annotation Attribute Placement
```python
# VERIFIED: annotation and annotation_name are top-level box attributes
# NOT inside saved_attribute_attributes.valueof
# Source: verified from .claude/max-objects/m4l/objects.json attribute listings

# CORRECT placement:
box["annotation_name"] = "Filter Cutoff"  # Header in Info View
box["annotation"] = "Controls the lowpass filter cutoff. Range: 20-20000 Hz"  # Body

# WRONG -- these are NOT parameter attributes:
# box["saved_attribute_attributes"]["valueof"]["annotation"] = ...  # WRONG
```

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| Manual parameter naming in Inspector | Programmatic naming via saved_attribute_attributes | Max 7+ | Can auto-derive names in code |
| No Push banks (default mapping) | live.banks object for explicit bank control | Max 8.1+ | Professional Push integration |
| No info text | annotation/annotation_name attributes | Max 7+ | Ableton Info View integration |

**Deprecated/outdated:**
- Pre-Max 8 devices without live.banks get auto-mapped by Ableton (no control over Push layout)
- The `live.banks` `attributes` dict in the DB is empty `{}` -- attributes may not be stored via standard attribute mechanism [VERIFIED: m4l/objects.json]

## Assumptions Log

| # | Claim | Section | Risk if Wrong |
|---|-------|---------|---------------|
| A1 | live.banks stores bank data in `_parameter_banks` JSON key on the box dict | Architecture Patterns, Pattern 4 | Medium -- if format differs, bank creation needs different approach. Fallback: use `new` messages via loadbang |
| A2 | Bank parameters are referenced by `parameter_longname` (not varname or shortname) | Architecture Patterns, Pitfall 3 | High -- banks would reference wrong names, Push shows empty slots |
| A3 | `annotation` and `annotation_name` are stored as direct box attributes (not inside saved_attribute_attributes) | Code Examples, Example 4 | Low -- verified against objects.json attribute listings but not against a live patch file |

## Open Questions

1. **live.banks `_parameter_banks` exact JSON format**
   - What we know: live.banks stores bank data persistently with the device. Banks have name + up to 8 parameter slots. Empty slots use "-". [CITED: docs.cycling74.com/reference/live.banks]
   - What's unclear: The exact JSON key name and structure in the .maxpat file. No public documentation exists for this internal format.
   - Recommendation: Start with the assumed `_parameter_banks` format. If it doesn't work when loaded in MAX, fall back to generating `loadbang -> new` message chains instead. Both approaches should be tested manually.

2. **Parameter name field used by live.banks**
   - What we know: Banks reference parameters by "symbol names" per docs. In practice this is the parameter_longname.
   - What's unclear: 100% confirmation that it's longname vs varname.
   - Recommendation: Use longname (most likely correct per training data and docs). If Push shows empty slots, switch to varname.

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | pytest 9.0.2 |
| Config file | none -- default pytest discovery |
| Quick run command | `python3 -m pytest tests/test_m4l_polish.py -x` |
| Full suite command | `python3 -m pytest tests/test_m4l_polish.py tests/test_m4l_critic.py -v` |

### Phase Requirements -> Test Map
| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| POLISH-01a | Longname derived from varname (D-02) | unit | `python3 -m pytest tests/test_m4l_polish.py::TestNameDerivation::test_longname_from_varname -x` | Wave 0 |
| POLISH-01b | Shortname abbreviated then truncated to 8 chars (D-03) | unit | `python3 -m pytest tests/test_m4l_polish.py::TestNameDerivation::test_shortname_abbreviation -x` | Wave 0 |
| POLISH-01c | Varname derived from longname (D-04) | unit | `python3 -m pytest tests/test_m4l_polish.py::TestNameDerivation::test_varname_from_longname -x` | Wave 0 |
| POLISH-01d | Existing names not overridden (D-01) | unit | `python3 -m pytest tests/test_m4l_polish.py::TestNameDerivation::test_preserves_existing -x` | Wave 0 |
| POLISH-02a | Parameters grouped by semantic function | unit | `python3 -m pytest tests/test_m4l_polish.py::TestPushBanks::test_semantic_grouping -x` | Wave 0 |
| POLISH-02b | Banks of 8, partial padded with "-" (D-07) | unit | `python3 -m pytest tests/test_m4l_polish.py::TestPushBanks::test_bank_padding -x` | Wave 0 |
| POLISH-02c | Bank names auto-derived (D-06) | unit | `python3 -m pytest tests/test_m4l_polish.py::TestPushBanks::test_bank_naming -x` | Wave 0 |
| POLISH-03a | Info text set on live.* controls | unit | `python3 -m pytest tests/test_m4l_polish.py::TestInfoText::test_annotation_set -x` | Wave 0 |
| POLISH-03b | Info text includes range from UnitStyle (D-09) | unit | `python3 -m pytest tests/test_m4l_polish.py::TestInfoText::test_range_formatting -x` | Wave 0 |
| POLISH-03c | Existing annotation not overridden (D-10) | unit | `python3 -m pytest tests/test_m4l_polish.py::TestInfoText::test_preserves_existing -x` | Wave 0 |
| D-13a | Critic warns missing info text | unit | `python3 -m pytest tests/test_m4l_critic.py::TestPolishWarnings::test_missing_info_text -x` | Wave 0 |
| D-13b | Critic warns absent live.banks | unit | `python3 -m pytest tests/test_m4l_critic.py::TestPolishWarnings::test_missing_live_banks -x` | Wave 0 |

### Sampling Rate
- **Per task commit:** `python3 -m pytest tests/test_m4l_polish.py -x`
- **Per wave merge:** `python3 -m pytest tests/test_m4l_polish.py tests/test_m4l_critic.py -v`
- **Phase gate:** Full suite green before `/gsd-verify-work`

### Wave 0 Gaps
- [ ] `tests/test_m4l_polish.py` -- covers POLISH-01, POLISH-02, POLISH-03
- [ ] New test class in `tests/test_m4l_critic.py` -- covers D-13 critic warnings

## Security Domain

Security enforcement: not applicable. This phase is purely offline patch metadata manipulation with no network, auth, or user input concerns.

## Sources

### Primary (HIGH confidence)
- `.claude/max-objects/m4l/objects.json` -- live.banks definition, annotation_name presence on 15 objects
- `src/maxpat/critics/m4l_critic.py` -- existing recursive traversal, CriticResult pattern, _LIVE_NO_PARAM set
- `src/maxpat/m4l_constants.py` -- UnitStyle enum values
- `patches/timestretch/generated/timestretch.maxpat` -- saved_attribute_attributes.valueof real-world structure
- `patches/wormhole/generated/wormhole-test.maxpat` -- live.gain~ parameter_longname/shortname format

### Secondary (MEDIUM confidence)
- [Cycling74 live.banks reference](https://docs.cycling74.com/reference/live.banks) -- message API, bank structure (8 slots, "-" for empty)
- [Cycling74 live.dial reference](https://docs.cycling74.com/reference/live.dial) -- annotation/annotation_name attribute docs, shortname "5 to 7 characters"
- [Ableton maxdevtools production guidelines](https://github.com/Ableton/maxdevtools/blob/main/m4l-production-guidelines/m4l-production-guidelines.md) -- annotation_name is header, annotation is body for Info View

### Tertiary (LOW confidence)
- `_parameter_banks` JSON format -- training data only, no authoritative source found

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH -- no new dependencies, pure Python on dict structures
- Architecture: HIGH -- follows established codebase patterns (m4l_export.py, m4l_critic.py)
- Naming logic (POLISH-01): HIGH -- saved_attribute_attributes format verified from real patches
- Push banks (POLISH-02): MEDIUM -- live.banks message API verified, JSON storage format assumed
- Info text (POLISH-03): HIGH -- annotation/annotation_name verified in object DB and official docs
- Critic warnings (D-13): HIGH -- follows existing CriticResult pattern exactly

**Research date:** 2026-04-06
**Valid until:** 2026-05-06 (stable domain, M4L format doesn't change frequently)
