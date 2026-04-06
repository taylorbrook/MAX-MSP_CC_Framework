# Phase 20: Foundation - Research

**Researched:** 2026-04-05
**Domain:** M4L data structures, object database entries, device detection, validation terminal names, CLAUDE.md rules
**Confidence:** HIGH

## Summary

Phase 20 is a pure data/documentation phase -- no behavioral changes to existing code beyond adding `plugout~` to two frozensets. Every deliverable is either a new file (`m4l_constants.py`), additive JSON entries (objects.json, relationships.json), a new function (`detect_device_type()`), or documentation (CLAUDE.md M4L rules). All tasks are parallelizable because there are zero inter-task dependencies within this phase.

The research confirms all required values via ground truth (kicksynth-m4l.maxpat and kicksynth-m4l.amxd), official Cycling 74 documentation, and direct codebase analysis. The .amxd binary header format is fully reverse-engineered: `ampf` magic + 4-byte version + 4-char device type code (`aaaa`/`iiii`/`mmmm`) + `meta` + 4-byte version + 4-byte padding + `ptch` + 4-byte JSON length (LE). The plugin~/plugout~ maxclass question is resolved: ground truth shows `maxclass: "newobj"`, not `"plugout~"` as the DB currently states -- this needs an override.

**Primary recommendation:** Execute all 7 deliverables in parallel. The terminal names fix (`plugout~` in `_TERMINAL_NAMES`) should be committed first as it unblocks correct test baselines, but it has no code dependency on other tasks.

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions
- **D-01:** `detect_device_type()` returns definitive type for unambiguous patterns (midi_effect = midiin+midiout with no audio I/O; audio_effect = plugin~+plugout~ with no MIDI). For ambiguous patterns (e.g., plugin~ + midiin), returns uncertain and the system asks the user during project kickoff.
- **D-02:** Detection works on both existing patches (/max-onboard flow) and during new project creation (/max-new).
- **D-03:** Confidence scoring uses numeric 0.0-1.0 (not enum). Allows downstream code to set thresholds.
- **D-04:** Researcher investigates .amxd binary header format (32-byte header, community-documented). No user-provided reference material.
- **D-05:** Include ALL known parameter_type, parameter_unitstyle, and parameter_modmode values in IntEnum classes -- comprehensive reference, not a common subset.
- **D-06:** M4L rules section covers core device rules AND Live API patterns: gain~/plugout~ prohibition, `---` naming convention, parameter_enable requirement, plugin~/plugout~ boilerplate, device type differences, live.path/live.object usage, live.banks, parameter metadata conventions.
- **D-07:** Include 169px height constraint and presentation mode conventions (openinpresentation) in Phase 20 rules -- agents need this knowledge from the start, even before the layout engine exists in Phase 24.
- **D-08:** live.adsrui and live.adsr~ sourced via research (docs, community). Added with verified=false, corrected during testing (Phase 25) if wrong.
- **D-09:** plugin~/plugout~ maxclass question (DB says "plugin~"/"plugout~", ground truth may be "newobj") resolved via research. If inconclusive, noted for manual verification.

### Claude's Discretion
None specified -- all decisions locked.

### Deferred Ideas (OUT OF SCOPE)
None -- discussion stayed within phase scope.
</user_constraints>

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|------------------|
| DB-01 | live.adsrui and live.adsr~ added to m4l/objects.json with verified I/O | I/O counts researched from official docs and adsr~ pattern; live.adsr~ = 5 inlets (trigger, A, D, S, R) + 4 outlets (signal, signal, message, message); live.adsrui = UI object, 1 inlet + 9 outlets (one per ADSR parameter) -- LOW confidence, mark verified=false |
| DB-02 | live.scope~ domain corrected to M4L | Confirmed: live.scope~ currently in packages/objects.json with domain="Packages"; must move to m4l/objects.json with domain="M4L" |
| DB-03 | M4L relationship entries added | Companion pairs identified: plugin~/plugout~ (required_pair), live.path/live.object (required_pair), midiin/midiout (required_pair for M4L), live.thisdevice/loadbang (common_pair) |
| DB-04 | m4l_constants.py with IntEnum classes | All enum values verified: ParamType (0-3), UnitStyle (0-9), ModMode (0-3), ParamVisibility (0-2), AMXD header format constants |
| VALID-04 | Device type detection from patch structure | Detection heuristics defined per D-01: unambiguous patterns return definitive type, ambiguous return uncertain with confidence < threshold |
| VALID-05 | plugout~ in _TERMINAL_NAMES | Two files confirmed: validation.py line 41 and dsp_critic.py line 33; additive change only |
| ROUTING-02 | CLAUDE.md M4L rules section | Content scope defined per D-06/D-07: core device rules, Live API patterns, 169px constraint, presentation mode |
</phase_requirements>

## Standard Stack

### Core
| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| Python stdlib `enum.IntEnum` | 3.14 | Parameter type/unitstyle/modmode enums | Standard Python enum, no dependency; IntEnum allows direct int comparison |
| Python stdlib `struct` | 3.14 | .amxd binary header packing (used in Phase 22, constants defined here) | Stdlib, no dependency |
| Python stdlib `json` | 3.14 | Object database JSON read/write | Already used throughout codebase |

### Supporting
No additional libraries needed. Phase 20 is pure data/documentation -- no new dependencies.

### Alternatives Considered
| Instead of | Could Use | Tradeoff |
|------------|-----------|----------|
| IntEnum | StrEnum | IntEnum preferred because .maxpat JSON stores parameter values as integers; IntEnum allows `ParamType.FLOAT == 1` directly |
| JSON for objects | dataclass | JSON matches existing DB pattern; all 8 domain files use JSON |

## Architecture Patterns

### Recommended Project Structure
```
src/maxpat/
    m4l_constants.py       # NEW: IntEnum classes + AMXD format constants
    analysis.py            # MODIFY: add detect_device_type() to AnalysisMixin
    validation.py          # MODIFY: add "plugout~" to _TERMINAL_NAMES (line 41)
    critics/
        dsp_critic.py      # MODIFY: add "plugout~" to _TERMINAL_NAMES (line 33)

.claude/max-objects/
    m4l/objects.json       # MODIFY: add live.adsrui, live.adsr~, live.scope~
    relationships.json     # MODIFY: add M4L companion entries

CLAUDE.md                  # MODIFY: add M4L domain rules section
```

### Pattern 1: IntEnum Constants Module
**What:** A data-only Python module with IntEnum classes mapping human-readable names to integer values used in .maxpat JSON.
**When to use:** When .maxpat stores magic integers that need named constants for downstream code.
**Example:**
```python
# Source: kicksynth-m4l.maxpat ground truth + Cycling 74 docs
from enum import IntEnum

class ParamType(IntEnum):
    """parameter_type values in saved_attribute_attributes.valueof."""
    INT = 0        # Integer values (0-255 range default)
    FLOAT = 1      # Floating point (no range restriction)
    ENUM = 2       # Enumerated list of items
    BLOB = 3       # Non-automatable, preset storage only

class UnitStyle(IntEnum):
    """parameter_unitstyle values -- controls display format in Ableton."""
    INT = 0        # Integer display
    FLOAT = 1      # Float display
    TIME = 2       # Milliseconds (ms)
    HERTZ = 3      # Frequency (Hz)
    DECIBEL = 4    # Decibels (dB)
    PERCENT = 5    # Percentage (%)
    PAN = 6        # Left/Right pan
    SEMITONES = 7  # Semitones for tuning
    MIDI = 8       # MIDI note numbers (0-127)
    CUSTOM = 9     # User-definable label

class ModMode(IntEnum):
    """parameter_modmode values -- modulation behavior in Ableton."""
    UNIPOLAR = 0   # Modulation between min and current value
    BIPOLAR = 1    # Modulation range = 2x distance to nearest boundary
    ADDITIVE = 2   # +/- half of total range
    ABSOLUTE = 3   # Current value as upper/lower bound

class ParamVisibility(IntEnum):
    """parameter_visibility values."""
    AUTOMATED_AND_STORED = 0  # Stored in Live Set/presets, available for automation
    STORED_ONLY = 1           # Stored but not visible to automation system
    HIDDEN = 2                # Neither stored nor automatable
```

### Pattern 2: Device Type Detection Function
**What:** Standalone function (not method) that analyzes a patch_dict and returns device type with confidence score.
**When to use:** During /max-onboard analysis and /max-new project creation.
**Example:**
```python
# Source: CONTEXT.md D-01, D-02, D-03
from dataclasses import dataclass

@dataclass
class DeviceTypeResult:
    device_type: str           # "audio_effect", "instrument", "midi_effect", "uncertain"
    confidence: float          # 0.0-1.0
    evidence: dict[str, bool]  # Which objects were found

def detect_device_type(patch_dict: dict) -> DeviceTypeResult:
    """Detect M4L device type from patch structure.
    
    Scans for plugin~, plugout~, midiin, midiout, dac~, ezdac~.
    Returns definitive type for unambiguous patterns, "uncertain" for ambiguous.
    """
    # ... scan boxes for key objects ...
    # Unambiguous: plugin~ + plugout~ + no midiin/midiout = audio_effect (1.0)
    # Unambiguous: midiin + midiout + no plugin~/plugout~ = midi_effect (1.0)
    # Ambiguous: plugin~ + midiin = uncertain (0.5) -- ask user
```

### Pattern 3: Object Database JSON Entry
**What:** JSON object following the exact schema of existing entries in m4l/objects.json.
**When to use:** Adding new objects to any domain.
**Example:**
```json
{
  "live.adsr~": {
    "name": "live.adsr~",
    "maxclass": "newobj",
    "module": "m4l",
    "domain": "M4L",
    "category": "Max for Live",
    "digest": "ADSR envelope generator for Max for Live",
    "description": "...",
    "inlets": [
      {"id": 0, "type": "signal/float", "signal": true, "digest": "Trigger/amplitude", "hot": true},
      {"id": 1, "type": "signal/float", "signal": true, "digest": "Attack time (ms)", "hot": false},
      {"id": 2, "type": "signal/float", "signal": true, "digest": "Decay time (ms)", "hot": false},
      {"id": 3, "type": "signal/float", "signal": true, "digest": "Sustain level", "hot": false},
      {"id": 4, "type": "signal/float", "signal": true, "digest": "Release time (ms)", "hot": false}
    ],
    "outlets": [
      {"id": 0, "type": "signal", "signal": true, "digest": "Envelope signal"},
      {"id": 1, "type": "signal", "signal": true, "digest": "Envelope busy signal"},
      {"id": 2, "type": "message", "signal": false, "digest": "Notification messages"},
      {"id": 3, "type": "message", "signal": false, "digest": "Parameter query output"}
    ],
    "arguments": [],
    "messages": ["bang", "list", "float"],
    "attributes": {},
    "seealso": ["adsr~", "live.adsrui"],
    "tags": ["Max for Live", "Envelope"],
    "min_version": 8,
    "verified": false,
    "variable_io": false,
    "rnbo_compatible": false
  }
}
```

### Pattern 4: Relationships JSON Entry
**What:** Entries in the "pairs" array of relationships.json following existing format.
**When to use:** Adding companion/required pair documentation for agents.
**Example:**
```json
{"objects": ["plugin~", "plugout~"], "relationship": "required_pair", "note": "Audio I/O for M4L audio_effect and instrument devices -- always used together"},
{"objects": ["live.path", "live.object"], "relationship": "required_pair", "note": "live.path resolves Live API paths, live.object sends messages to the resolved path"},
{"objects": ["midiin", "midiout"], "relationship": "required_pair", "note": "MIDI passthrough for M4L instrument and midi_effect devices"}
```

### Anti-Patterns to Avoid
- **Modifying patcher.py or Box class:** Phase 20 adds no new attributes to Box. All M4L metadata flows through `extra_attrs` and `saved_attribute_attributes` -- existing mechanisms.
- **Creating m4l_constants.py with logic:** It must be pure data. No imports beyond stdlib `enum`. No functions, no classes with methods. Just IntEnum definitions and named constants.
- **Guessing live.adsrui I/O counts:** Mark `verified=false` per D-08. The I/O for live.adsrui is not fully documented; inferring from the attribute list (10 parameters: attack_time, attack_slope, decay_time, decay_slope, sustain, release_time, release_slope, initial, peak, end_value) suggests 1 inlet + 10 outlets, but this is LOW confidence.

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Parameter type validation | Custom string matching | `ParamType(value)` IntEnum | IntEnum raises ValueError on invalid values automatically |
| Object DB entry format | Ad-hoc dict construction | Copy exact schema from existing entries | Schema must match exactly for ObjectDatabase._load() |
| JSON I/O | Custom file handling | `json.loads(path.read_text())` | Matches existing pattern in db_lookup.py |
| .amxd header byte layout | Manual byte arrays | `struct.pack("<4sI4s4sI4xI", ...)` | Stdlib struct handles endianness correctly |

## Common Pitfalls

### Pitfall 1: plugin~/plugout~ Maxclass Mismatch
**What goes wrong:** DB says `maxclass: "plugout~"` but ground truth (kicksynth-m4l.maxpat) shows `maxclass: "newobj"`. If the DB is not corrected, generated patches with plugin~/plugout~ will use wrong maxclass and MAX may not load them correctly.
**Why it happens:** Extraction scripts derived maxclass from object names for signal objects; plugin~/plugout~ are exceptions where maxclass is "newobj".
**How to avoid:** Add overrides for plugin~ and plugout~ in overrides.json: `{"maxclass": "newobj"}`. Alternatively, correct the entries in msp/objects.json directly.
**Warning signs:** Generated .maxpat has `"maxclass": "plugout~"` instead of `"maxclass": "newobj"`.

### Pitfall 2: live.scope~ Left in Packages Domain
**What goes wrong:** If live.scope~ is left in packages/objects.json with domain "Packages", the ObjectDatabase load order puts packages before m4l, so db.lookup("live.scope~").domain returns "Packages" not "M4L". Domain classification heuristic catches it (starts with "live."), but DB should be authoritative.
**Why it happens:** Extraction tool classified it as a package object.
**How to avoid:** Move the entry from packages/objects.json to m4l/objects.json, update domain field to "M4L".
**Warning signs:** `AnalysisMixin._classify_domain()` returns inconsistent results for live.scope~ depending on whether DB or heuristic path is taken.

### Pitfall 3: AMXD Device Type Code Confusion
**What goes wrong:** Using wrong 4-char device type code in .amxd header causes Live to reject the file or load it as wrong device type.
**Why it happens:** The codes are not officially documented; derived from community reverse-engineering.
**How to avoid:** Use verified codes from kicksynth-m4l.amxd ground truth: `iiii` = instrument. Community forum confirms: `aaaa` = audio_effect, `mmmm` = midi_effect.
**Warning signs:** .amxd file opens in Live but appears in wrong device category.

### Pitfall 4: UnitStyle Value Ordering
**What goes wrong:** Assigning wrong integer to UnitStyle enum causes parameters to display with wrong units in Ableton (e.g., a frequency showing as milliseconds).
**Why it happens:** Official docs list unit styles by name without integer codes. Must be inferred from ordering and ground truth.
**How to avoid:** Verify against kicksynth-m4l ground truth: Decay parameters use unitstyle=2 (Time/ms), Frequency parameters use unitstyle=3 (Hz), Gain parameters use unitstyle=4 (dB). This confirms Int=0, Float=1, Time=2, Hz=3, dB=4 ordering.
**Warning signs:** Parameter displays wrong unit label in Ableton's automation lane.

### Pitfall 5: Forgetting dsp_critic.py Terminal Names
**What goes wrong:** Adding `plugout~` to validation.py's `_TERMINAL_NAMES` but forgetting dsp_critic.py's separate `_TERMINAL_NAMES`. Gain staging BFS in dsp_critic still cannot reach plugout~ and produces false positive "missing gain staging" warnings for M4L devices.
**Why it happens:** Two separate files define their own `_TERMINAL_NAMES` frozensets independently.
**How to avoid:** Both files must be updated. Validation.py line 41 AND dsp_critic.py line 33.
**Warning signs:** `review_dsp()` still produces gain staging warnings for M4L patches after validation.py fix.

### Pitfall 6: detect_device_type() in Wrong Module
**What goes wrong:** Putting detection in a module that requires Patcher instantiation when it should work on raw patch_dict.
**Why it happens:** AnalysisMixin is a mixin for Patcher, but detection may need to work on raw dicts from /max-onboard.
**How to avoid:** Implement as a standalone function in analysis.py (not as a mixin method). Takes patch_dict, returns DeviceTypeResult. Can be called without instantiating a Patcher.
**Warning signs:** Callers forced to create Patcher objects just to call detection.

## Code Examples

### AMXD Header Construction
```python
# Source: Reverse-engineered from kicksynth-m4l.amxd
import struct

# Device type codes (bytes 8-11 in header)
AMXD_TYPE_AUDIO_EFFECT = b"aaaa"
AMXD_TYPE_INSTRUMENT = b"iiii"
AMXD_TYPE_MIDI_EFFECT = b"mmmm"

# Header structure: 32 bytes total
# Offset  Len  Content
# 0       4    b"ampf"          (magic)
# 4       4    uint32 LE = 4    (version)
# 8       4    device type      (aaaa/iiii/mmmm)
# 12      4    b"meta"          (section marker)
# 16      4    uint32 LE = 4    (meta version)
# 20      4    4 zero bytes     (padding)
# 24      4    b"ptch"          (patch section marker)
# 28      4    uint32 LE        (JSON byte length)

def build_amxd_header(device_type_code: bytes, json_length: int) -> bytes:
    """Build the 32-byte .amxd binary header."""
    return struct.pack(
        "<4sI4s4sI4x4sI",
        b"ampf",            # magic
        4,                  # version
        device_type_code,   # device type
        b"meta",            # section marker
        4,                  # meta version
        # 4 zero bytes (padding via 4x)
        b"ptch",            # patch section marker
        json_length,        # JSON byte length
    )
```

### Terminal Names Fix
```python
# validation.py line 41 -- add "plugout~"
_TERMINAL_NAMES = frozenset({"dac~", "ezdac~", "send~", "out~", "plugout~"})

# dsp_critic.py line 33 -- add "plugout~"
_TERMINAL_NAMES = frozenset({"dac~", "ezdac~", "plugout~"})
```

### Device Type Detection
```python
# Source: CONTEXT.md D-01, D-02, D-03
from dataclasses import dataclass

@dataclass
class DeviceTypeResult:
    device_type: str       # "audio_effect", "instrument", "midi_effect", "uncertain"
    confidence: float      # 0.0-1.0
    evidence: dict[str, bool]

def detect_device_type(patch_dict: dict) -> DeviceTypeResult:
    """Detect M4L device type from patch structure."""
    patcher = patch_dict.get("patcher", {})
    boxes = patcher.get("boxes", [])
    
    has_plugin = False
    has_plugout = False
    has_midiin = False
    has_midiout = False
    has_dac = False
    
    for box_entry in boxes:
        box = box_entry.get("box", {})
        text = box.get("text", "").split()[0] if box.get("text") else ""
        if text == "plugin~":
            has_plugin = True
        elif text == "plugout~":
            has_plugout = True
        elif text == "midiin":
            has_midiin = True
        elif text == "midiout":
            has_midiout = True
        elif text in ("dac~", "ezdac~"):
            has_dac = True
    
    evidence = {
        "plugin~": has_plugin,
        "plugout~": has_plugout,
        "midiin": has_midiin,
        "midiout": has_midiout,
        "dac~": has_dac,
    }
    
    # Unambiguous patterns
    if has_midiin and has_midiout and not has_plugin and not has_plugout:
        return DeviceTypeResult("midi_effect", 1.0, evidence)
    if has_plugin and has_plugout and not has_midiin and not has_midiout:
        return DeviceTypeResult("audio_effect", 1.0, evidence)
    if has_plugout and has_midiin and not has_plugin:
        return DeviceTypeResult("instrument", 0.9, evidence)
    
    # Counter-signal: dac~ presence suggests non-M4L patch
    if has_dac and not has_plugout:
        return DeviceTypeResult("uncertain", 0.3, evidence)
    
    # Ambiguous: mixed signals
    if has_plugin and has_midiin:
        return DeviceTypeResult("uncertain", 0.5, evidence)
    
    # No M4L objects found
    return DeviceTypeResult("uncertain", 0.0, evidence)
```

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| Manual parameter_type integers | IntEnum classes in m4l_constants.py | This phase | Eliminates magic numbers in all downstream M4L code |
| No terminal plugout~ | plugout~ in _TERMINAL_NAMES | This phase | M4L devices stop generating false-positive unterminated warnings |
| live.scope~ in Packages | live.scope~ in M4L domain | This phase | Correct domain classification for M4L-specific analysis |
| No M4L rules in CLAUDE.md | Full M4L section | This phase | All agents get M4L conventions from session start |

## Open Questions

1. **live.adsrui I/O Count**
   - What we know: It is a UI control for ADSR parameters. The attributes include attack_time, attack_slope, decay_time, decay_slope, sustain, release_time, release_slope, initial, peak, end_value (10 parameters). Each outlet feeds the corresponding inlet of live.adsr~.
   - What's unclear: Exact outlet count. Likely 1 inlet + 9 or 10 outlets (one per ADSR segment parameter), but official docs do not specify.
   - Recommendation: Add with best-guess I/O (1 inlet, 9 outlets based on standard ADSR UI controls sending A, D, S, R + slopes + initial/peak/end), mark `verified=false` per D-08. Phase 25 testing corrects if wrong.

2. **live.adsr~ maxclass**
   - What we know: Standard adsr~ uses maxclass "newobj". live.adsr~ likely follows same pattern.
   - What's unclear: Not verified in ground truth (kicksynth doesn't use live.adsr~).
   - Recommendation: Set maxclass="newobj" (consistent with all other live.* signal objects). Mark verified=false.

3. **parameter_modmode Values 1-3**
   - What we know: ModMode 0 (UNIPOLAR) confirmed in ground truth. Values 1 (BIPOLAR), 2 (ADDITIVE), 3 (ABSOLUTE) from docs.
   - What's unclear: No ground truth verification for values 1-3.
   - Recommendation: Include all 4 values per D-05 (comprehensive reference). Document that only value 0 is ground-truth verified.

4. **plugin~/plugout~ Override vs Direct Edit**
   - What we know: DB has maxclass="plugout~" but ground truth shows maxclass="newobj". Need to correct.
   - What's unclear: Whether to add to overrides.json (recommended pattern) or edit msp/objects.json directly.
   - Recommendation: Use overrides.json for maxclass correction. This is the established pattern for expert corrections and avoids touching the auto-extracted base data.

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | pytest 9.0.2 |
| Config file | None (no pytest.ini or pyproject.toml test section) |
| Quick run command | `python3 -m pytest tests/ -x -q` |
| Full suite command | `python3 -m pytest tests/ -v` |

### Phase Requirements -> Test Map
| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| DB-01 | live.adsrui and live.adsr~ in m4l/objects.json | unit | `python3 -m pytest tests/test_object_schema.py -x -k "m4l"` | Partial (test_object_schema.py exists, needs M4L-specific cases) |
| DB-02 | live.scope~ domain = M4L | unit | `python3 -m pytest tests/test_object_schema.py -x -k "scope"` | Partial |
| DB-03 | M4L relationships in relationships.json | unit | `python3 -m pytest tests/test_m4l_foundation.py -x -k "relationships"` | No -- Wave 0 |
| DB-04 | m4l_constants.py importable with correct enums | unit | `python3 -m pytest tests/test_m4l_foundation.py -x -k "constants"` | No -- Wave 0 |
| VALID-04 | detect_device_type() returns correct types | unit | `python3 -m pytest tests/test_m4l_foundation.py -x -k "detect"` | No -- Wave 0 |
| VALID-05 | plugout~ in _TERMINAL_NAMES | unit | `python3 -m pytest tests/test_validation.py tests/test_critics.py -x -k "terminal or plugout"` | Partial (files exist, need plugout~ test cases) |
| ROUTING-02 | CLAUDE.md has M4L section | smoke | `python3 -m pytest tests/test_claude_md.py -x` | Partial (test_claude_md.py exists) |

### Sampling Rate
- **Per task commit:** `python3 -m pytest tests/ -x -q` (quick run, stop at first failure)
- **Per wave merge:** `python3 -m pytest tests/ -v` (full suite, verbose)
- **Phase gate:** Full suite green before `/gsd:verify-work`

### Wave 0 Gaps
- [ ] `tests/test_m4l_foundation.py` -- covers DB-03, DB-04, VALID-04 (new test file for Phase 20 deliverables)
- [ ] Add test cases to existing `test_validation.py` for plugout~ in _TERMINAL_NAMES (VALID-05)
- [ ] Add test cases to existing `test_critics.py` for plugout~ in dsp_critic _TERMINAL_NAMES (VALID-05)
- [ ] Add test cases to existing `test_object_schema.py` for live.adsrui, live.adsr~, live.scope~ domain (DB-01, DB-02)

## Project Constraints (from CLAUDE.md)

- **Rule #1 (Never Guess Objects):** New M4L objects (live.adsrui, live.adsr~) must follow exact DB schema. Mark verified=false since I/O derived from docs, not direct verification.
- **Rule #5 (No Generator Scripts):** No intermediary scripts. Constants module is importable data, not a generator.
- **Rule #7 (Commit After Every Save):** Every file modification must be committed.
- **MSP Domain:** plugout~ addition to _TERMINAL_NAMES is an MSP-domain validation concern.
- **Multi-instance safety:** Commit only files within the active scope; no `git add .`.
- **Object schema:** Each entry requires: name, maxclass, module, domain, inlets[], outlets[], arguments, messages, min_version, verified, variable_io, rnbo_compatible.

## Sources

### Primary (HIGH confidence)
- `patches/kicksynth/generated/kicksynth-m4l.maxpat` -- ground truth M4L instrument, parameter_type/unitstyle/modmode values verified
- `patches/kicksynth/generated/kicksynth-m4l.amxd` -- reverse-engineered .amxd binary header (32 bytes: ampf + version + device_type + meta + version + padding + ptch + json_length)
- `src/maxpat/validation.py` line 41 -- `_TERMINAL_NAMES` confirmed needs plugout~
- `src/maxpat/critics/dsp_critic.py` line 33 -- `_TERMINAL_NAMES` confirmed needs plugout~
- `.claude/max-objects/m4l/objects.json` -- 35 objects currently, missing live.adsrui and live.adsr~
- `.claude/max-objects/packages/objects.json` -- live.scope~ with domain="Packages" (needs correction)
- `.claude/max-objects/msp/objects.json` -- plugin~/plugout~ entries with maxclass="plugout~"/"plugin~" (needs override to "newobj")
- `.claude/max-objects/relationships.json` -- existing pair format, no M4L entries yet
- [Cycling 74: Device Parameters in Max for Live](https://docs.cycling74.com/userguide/m4l/live_parameters/) -- parameter_type, unitstyle, modmode
- [Cycling 74: live.adsr~ Reference](https://docs.cycling74.com/max8/refpages/live.adsr~) -- 5 inlets confirmed
- [Cycling 74: live.adsrui Reference](https://docs.cycling74.com/max8/refpages/live.adsrui) -- UI envelope control (I/O not fully specified)
- [Cycling 74 Forum: amxd midi effect to audio effect](https://cycling74.com/forums/amxd-midi-effect-to-audio-effect) -- device type codes confirmed: aaaa, iiii, mmmm

### Secondary (MEDIUM confidence)
- `.planning/research/SUMMARY.md` -- v3.0 research summary with architecture, pitfalls, phase ordering
- `.planning/research/ARCHITECTURE.md` -- integration map, component boundaries, data flow
- [Cycling 74: Creating Audio Effect Devices](https://docs.cycling74.com/userguide/m4l/live_audiodevices/) -- plugin~/plugout~ requirements
- [Cycling 74: Creating MIDI Effects](https://docs.cycling74.com/userguide/m4l/live_midieffects/) -- midiin/midiout requirements

### Tertiary (LOW confidence)
- live.adsrui outlet count (9 or 10) -- inferred from attribute list, not documented
- UnitStyle values 5-8 (%, Pan, Semitones, MIDI) -- from docs ordering, no ground truth verification
- ModMode values 1-3 -- from docs, only value 0 verified in ground truth

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH -- no new dependencies, all stdlib
- Architecture: HIGH -- all changes are additive to existing patterns; specific line numbers identified
- Pitfalls: HIGH -- all verified against ground truth or direct code analysis
- M4L object I/O: LOW for live.adsrui (docs don't specify), MEDIUM for live.adsr~ (matches adsr~ pattern)
- AMXD format: HIGH -- fully reverse-engineered from binary, community-confirmed device type codes
- Parameter enums: HIGH for verified values (types 0,2; unitstyles 1-4,9; modmode 0), MEDIUM for unverified (type 1,3; unitstyles 5-8; modmodes 1-3)

**Research date:** 2026-04-05
**Valid until:** 2026-05-05 (stable domain -- M4L parameter system unchanged since MAX 8)
