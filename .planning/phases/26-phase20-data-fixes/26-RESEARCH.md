# Phase 26: Phase 20 Data Fixes & Governance - Research

**Researched:** 2026-04-07
**Domain:** M4L object database, device detection, CLAUDE.md governance
**Confidence:** HIGH

## Summary

Phase 26 closes 7 gap-closure requirements from the v3.0 milestone audit. Three require code changes (DB-02, DB-03, VALID-04) and four need verification only (DB-01, DB-04, VALID-05, ROUTING-02). However, research reveals that ROUTING-02 actually requires a code change -- CLAUDE.md has NO M4L domain-specific rules section despite the audit claiming otherwise.

All changes are confined to JSON data files, one Python module refactor, one CLAUDE.md addition, and associated tests. No new dependencies, no architectural changes.

**Primary recommendation:** Execute as 3 task waves -- data fixes first (DB-02, DB-03), then detection refactor (VALID-04), then verifications + CLAUDE.md (DB-01, DB-04, VALID-05, ROUTING-02).

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|------------------|
| DB-01 | live.adsrui and live.adsr~ in database with verified I/O | Objects found in packages/objects.json with 0 inlets/0 outlets, unverified. Need I/O populated and moved/aliased to m4l domain. |
| DB-02 | live.scope~ domain corrected to M4L | Entry in packages/objects.json has domain="Packages". Overrides have correct I/O but no domain fix. Add domain override or move entry. |
| DB-03 | relationships.json needs M4L entries | Currently zero M4L entries. Need plugin~/plugout~, live.path/live.object, midiin/midiout pairs. |
| DB-04 | m4l_constants.py has ParamType, UnitStyle, ModMode, ParamVisibility IntEnums | File exists and is complete with all 4 IntEnum classes plus AMXD binary format constants. Verification only. |
| VALID-04 | detect_device_type() exported as standalone public function with test coverage | Logic exists as private _detect_m4l_device() in critics/__init__.py. Needs public wrapper, export from src.maxpat, and dedicated test file. |
| VALID-05 | plugout~ in _TERMINAL_NAMES in validation.py and dsp_critic.py | Confirmed present in both files. Verification only. |
| ROUTING-02 | CLAUDE.md has M4L domain-specific rules section | **NOT present** -- CLAUDE.md has zero M4L rules. Audit evidence was incorrect. Code change required. |
</phase_requirements>

## Current State Analysis

### DB-02: live.scope~ domain [VERIFIED: codebase grep + ObjectDatabase]

**Location:** `.claude/max-objects/packages/objects.json` key `"live.scope~"`
- **Current domain:** `"Packages"` (incorrect)
- **Target domain:** `"M4L"`
- **I/O status:** Overrides in `overrides.json` provide correct I/O (2 signal inlets, 0 outlets) [VERIFIED: overrides.json line 5778]
- **Fix approach:** Add `"domain": "M4L"` to the existing overrides.json entry for live.scope~. This is simpler than moving the base entry between files and follows the existing override pattern.

### DB-03: relationships.json M4L entries [VERIFIED: relationships.json content]

**Current state:** Zero M4L entries. File has 19 pairs total (tapin~/tapout~, send~/receive~, etc.)
**Required additions (3 pairs):**
1. `plugin~` / `plugout~` -- required_pair, M4L audio I/O
2. `live.path` / `live.object` -- required_pair, Live API access
3. `midiin` / `midiout` -- common_pair, M4L MIDI device I/O

Format follows existing pattern: `{"objects": [...], "relationship": "...", "note": "..."}` inside the `"pairs"` array.

### VALID-04: detect_device_type() public export [VERIFIED: critics/__init__.py]

**Current implementation:** `_detect_m4l_device(patch_dict)` at line 27 of `src/maxpat/critics/__init__.py`
- Takes `patch_dict`, returns `"audio_effect"`, `"instrument"`, `"midi_effect"`, or `None`
- Already in `__all__` of critics module (as `_detect_m4l_device`)
- 6 tests exist in `test_m4l_critic.py::TestAutoDetection` (all passing)

**What's needed:**
1. Create public `detect_device_type()` function -- either rename or create wrapper that calls `_detect_m4l_device`
2. Keep `_detect_m4l_device` as backward-compat alias to avoid breaking existing callers (6 test imports + review_patch internal use)
3. Export `detect_device_type` from `src.maxpat.__init__` in `__all__`
4. Create `tests/test_m4l_detection.py` with dedicated tests (can import from new public name)

**Recommended location:** Keep in `src/maxpat/critics/__init__.py` alongside the detection logic. Add public name `detect_device_type = _detect_m4l_device` and export.

### DB-01: live.adsrui and live.adsr~ I/O verification [VERIFIED: packages/objects.json]

**Current state in packages/objects.json:**
- `live.adsrui`: 0 inlets, 0 outlets, verified=false, domain="Packages"
- `live.adsr~`: 0 inlets, 0 outlets, verified=false, domain="Packages"

**I/O data (needs verification in MAX):** [ASSUMED]
- `live.adsrui`: 1 inlet (list/float/bang), 1 outlet (list/float). UI object for ADSR shape editing.
- `live.adsr~`: 1-2 signal inlets (gate trigger + optional retrigger), 1 signal outlet (envelope signal). Arguments: attack, decay, sustain, release.

**Note:** The exact I/O counts could not be verified from help patch audits (objects not in audit data) or web docs (Cycling 74 docs don't list explicit counts on the scraped pages). The requirement says "verified I/O" -- these need manual verification in MAX or sourced from a help patch.

**Fix approach:** Add entries to overrides.json with best-known I/O, or if DB-01 requires m4l domain placement, add overrides with `"domain": "M4L"` as well. Mark verified=false until manual confirmation.

### DB-04: m4l_constants.py [VERIFIED: src/maxpat/m4l_constants.py]

**Status: COMPLETE.** File exists with all required IntEnum classes:
- `ParamType` (INT=0, FLOAT=1, ENUM=2, BLOB=3)
- `UnitStyle` (INT=0 through CUSTOM=9)
- `ModMode` (UNIPOLAR=0 through ABSOLUTE=3)
- `ParamVisibility` (AUTOMATED_AND_STORED=0, STORED_ONLY=1, HIDDEN=2)
- Plus AMXD binary format constants (AMXD_MAGIC, AMXD_VERSION, header format)

Consumed by `m4l_export.py` and `m4l_polish.py`. Verification only.

### VALID-05: plugout~ in terminal names [VERIFIED: validation.py line 41 + dsp_critic.py line 33]

**Status: COMPLETE.**
- `validation.py` line 41: `_TERMINAL_NAMES = frozenset({"dac~", "ezdac~", "send~", "out~", "plugout~"})`
- `dsp_critic.py` line 33: `_TERMINAL_NAMES = frozenset({"dac~", "ezdac~", "plugout~"})`

Verification only.

### ROUTING-02: CLAUDE.md M4L rules section [VERIFIED: CLAUDE.md grep]

**Status: NOT PRESENT.** The milestone audit evidence stated "CLAUDE.md M4L rules section exists" but this is INCORRECT. Grep for "M4L", "Max for Live", "plugin~", "plugout~", "live.", and "amxd" in CLAUDE.md returns only 1 hit: the file listing `m4l/objects.json` in the Object Database section.

**CLAUDE.md Domain-Specific Rules sections that exist:**
- MSP (Audio/Signal) -- line 120
- Gen~ (GenExpr DSP Code) -- line 130
- Subpatcher Inlet/Outlet Access -- line 141
- RNBO (Export-Ready Patches) -- line 154
- Node for Max (N4M / node.script) -- line 163
- js (V8 JavaScript / js object) -- line 173

**Missing:** `### M4L (Max for Live)` section under Domain-Specific Rules.

**Required content for M4L section:** [ASSUMED based on codebase patterns]
- M4L device types (audio_effect, instrument, midi_effect) and required objects per type
- plugin~/plugout~ for audio I/O (not dac~)
- No gain~ before plugout~ (Ableton channel strip handles volume)
- live.thisdevice required in every M4L device
- Parameter naming: parameter_enable=1, unique parameter_longname
- --- prefix for named objects (buffer~, coll, send, receive, etc.)
- Presentation mode: openinpresentation=1, presentation_rect on user-facing objects
- 169px height constraint for M4L presentation view
- live.banks for Push controller layout

## Architecture Patterns

### Override vs. Move Pattern for DB Fixes

The codebase uses `overrides.json` for corrections over base data. This is the preferred approach:

```python
# ObjectDatabase applies overrides via deep-merge
# overrides.json entry:
{
    "live.scope~": {
        "domain": "M4L",           # <-- adds domain correction
        "inlets": [...]            # <-- already exists
    }
}
```

**Why override, not move:** Moving an entry from packages/ to m4l/ creates risk of ObjectDatabase loading both copies. The override pattern is safe and already tested.

### Public Function Export Pattern

The codebase pattern for public exports:

```python
# In src/maxpat/critics/__init__.py:
def detect_device_type(patch_dict: dict) -> str | None:
    """Public API for M4L device type detection. [docstring]"""
    ...

# Backward compat:
_detect_m4l_device = detect_device_type

# In src/maxpat/__init__.py:
from src.maxpat.critics import detect_device_type
# Add to __all__
```

### relationships.json Entry Pattern

```json
{
    "objects": ["plugin~", "plugout~"],
    "relationship": "required_pair",
    "note": "M4L audio I/O -- plugin~ receives audio from Live, plugout~ sends to Live"
}
```

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Domain correction | Move JSON between files | overrides.json domain field | ObjectDatabase deep-merges overrides; moving risks duplicate entries |
| Detection export | New module with copy-pasted logic | Rename in-place + alias | Single source of truth, no divergence |

## Common Pitfalls

### Pitfall 1: Duplicate Object Entries
**What goes wrong:** Object exists in both packages/ and m4l/ domain files, ObjectDatabase loads both, last-write-wins creates unpredictable behavior.
**How to avoid:** Use overrides.json for domain correction. Never duplicate base entries across domain files.

### Pitfall 2: Breaking Existing Imports
**What goes wrong:** Renaming `_detect_m4l_device` breaks 6 test imports and internal `review_patch()` call.
**How to avoid:** Keep `_detect_m4l_device` as an alias. Make `detect_device_type` the primary name, assign `_detect_m4l_device = detect_device_type`.

### Pitfall 3: Unverified I/O Marked as Verified
**What goes wrong:** DB-01 requires "verified I/O" but web docs don't provide exact inlet/outlet counts for live.adsrui/live.adsr~.
**How to avoid:** Add best-known I/O but keep `verified: false` until manually confirmed in MAX. Flag in code comments.

### Pitfall 4: CLAUDE.md M4L Section Placement
**What goes wrong:** Adding M4L rules in the wrong location disrupts CLAUDE.md structure.
**How to avoid:** Insert `### M4L (Max for Live)` after the RNBO section (line 162) and before Node for Max (line 163), following the domain-specific rules pattern.

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | pytest 9.0.2 |
| Config file | pyproject.toml |
| Quick run command | `python3 -m pytest tests/test_m4l_critic.py tests/test_m4l_detection.py -x -q` |
| Full suite command | `python3 -m pytest tests/ -x -q` |

### Phase Requirements -> Test Map
| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| DB-01 | live.adsrui/live.adsr~ in DB with I/O | unit | `python3 -m pytest tests/test_m4l_db.py -x` | Exists (untracked pyc seen) |
| DB-02 | live.scope~ domain = M4L | unit | `python3 -m pytest tests/test_m4l_db.py -x` | Exists (untracked pyc seen) |
| DB-03 | M4L relationships exist | unit | `python3 -m pytest tests/test_m4l_db.py -x` | Exists (untracked pyc seen) |
| DB-04 | m4l_constants enums exist | unit | `python3 -c "from src.maxpat.m4l_constants import ParamType, UnitStyle, ModMode, ParamVisibility"` | Inline check |
| VALID-04 | detect_device_type() public + tested | unit | `python3 -m pytest tests/test_m4l_detection.py -x` | Wave 0 |
| VALID-05 | plugout~ in terminal names | unit | `python3 -m pytest tests/test_m4l_critic.py -x` | Exists |
| ROUTING-02 | CLAUDE.md M4L section | manual-only | Grep check | N/A |

### Wave 0 Gaps
- [ ] `tests/test_m4l_detection.py` -- dedicated test file for detect_device_type() public API (VALID-04)

Note: `test_m4l_db.py` appears to exist already (untracked .pyc in git status). If the .py source exists, it may already cover DB-01/02/03.

## Assumptions Log

| # | Claim | Section | Risk if Wrong |
|---|-------|---------|---------------|
| A1 | live.adsrui has 1 inlet, 1 outlet | DB-01 analysis | Wrong I/O in database; mitigated by keeping verified=false |
| A2 | live.adsr~ has 1-2 signal inlets, 1 signal outlet | DB-01 analysis | Wrong I/O in database; mitigated by keeping verified=false |
| A3 | M4L rules section content (device types, no gain~ before plugout~, etc.) | ROUTING-02 analysis | Incomplete rules; mitigated by deriving from existing codebase patterns |

## Open Questions (RESOLVED)

1. **live.adsrui / live.adsr~ exact I/O counts**
   - What we know: Web docs confirm they exist; the objects are in packages/objects.json with 0/0 I/O
   - What's unclear: Exact inlet/outlet count and types
   - RESOLVED: Add best-guess I/O from training knowledge, keep verified=false. User can verify in MAX later.

2. **Should DB-01 entries move to m4l/objects.json or stay in packages/ with domain override?**
   - RESOLVED: Use domain override in overrides.json (consistent with live.scope~ fix pattern)

## Sources

### Primary (HIGH confidence)
- `.claude/max-objects/packages/objects.json` -- live.scope~, live.adsrui, live.adsr~ entries inspected
- `.claude/max-objects/m4l/objects.json` -- confirmed domain="M4L" for all 35 objects
- `.claude/max-objects/overrides.json` -- live.scope~ I/O override at line 5778, no domain fix
- `.claude/max-objects/relationships.json` -- full content inspected, zero M4L entries
- `src/maxpat/m4l_constants.py` -- full file read, all 4 IntEnums confirmed
- `src/maxpat/critics/__init__.py` -- _detect_m4l_device implementation read in full
- `src/maxpat/__init__.py` -- __all__ exports verified, no detect_device_type
- `src/maxpat/validation.py` line 41 -- plugout~ confirmed in _TERMINAL_NAMES
- `src/maxpat/critics/dsp_critic.py` line 33 -- plugout~ confirmed in _TERMINAL_NAMES
- `CLAUDE.md` -- all section headers enumerated, no M4L section found
- `.planning/v3.0-MILESTONE-AUDIT.md` -- audit findings cross-referenced

### Secondary (MEDIUM confidence)
- [Cycling 74 live.adsrui reference](https://docs.cycling74.com/max8/refpages/live.adsrui) -- confirms object exists, no explicit I/O counts
- [Cycling 74 live.adsr~ reference](https://docs.cycling74.com/max8/refpages/live.adsr~) -- confirms object exists, no explicit I/O counts

### Tertiary (LOW confidence)
- live.adsrui / live.adsr~ I/O counts from training knowledge [ASSUMED]

## Metadata

**Confidence breakdown:**
- DB fixes (DB-02, DB-03): HIGH -- exact file locations and current state verified
- Detection refactor (VALID-04): HIGH -- implementation fully read, export pattern clear
- Verifications (DB-04, VALID-05): HIGH -- code confirmed present
- ROUTING-02 reclassification: HIGH -- CLAUDE.md has no M4L section (verified by grep)
- DB-01 I/O data: LOW -- exact counts unverified, Cycling 74 docs unhelpful

**Research date:** 2026-04-07
**Valid until:** 2026-05-07 (stable domain, no external dependencies)
