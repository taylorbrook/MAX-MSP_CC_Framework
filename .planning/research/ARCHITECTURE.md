# Architecture: M4L Device Creation Integration

**Domain:** Max for Live device authoring within existing MAX patch generation framework
**Researched:** 2026-04-05
**Confidence:** HIGH (based on direct codebase analysis and .amxd format reverse-engineering)

## Recommended Architecture

M4L device creation integrates into the existing framework through **6 surgical insertion points** -- no new modules, no architectural rewrites, no new abstractions. Every change either adds a function to an existing module or adds a new file that follows an established pattern (the critic pattern, the dispatch-rules pattern).

### Integration Map

```
User request: "Build me an M4L audio effect"
       |
       v
[dispatch-rules.md]  <-- ADD: M4L keywords + intent patterns
       |
       v
[Agents: DSP + UI]   <-- ADD: M4L sections to SKILL.md files
       |
       v
[project.py]         <-- ADD: create_m4l_project() scaffold function
       |
       v
[patcher.py]         <-- NO CHANGE (props dict already supports all M4L flags)
       |
       v
[layout.py]          <-- MODIFY: _apply_presentation_layout() for M4L-aware grouping
       |
       v
[critics/__init__.py] <-- ADD: _has_m4l_boxes() detection + review_m4l() invocation
[critics/m4l_critic.py] <-- NEW FILE: M4L device completeness checks
       |
       v
[analysis.py]        <-- ADD: detect_device_type() method + SECTION_SIGNATURES entries
       |
       v
[hooks.py]           <-- ADD: write_amxd() for .amxd export (alongside save_patch_roundtrip)
```

### Component Boundaries

| Component | Responsibility | Changes |
|-----------|---------------|---------|
| `project.py` | M4L device scaffold -- creates project with plugin~/plugout~, live.thisdevice, presentation mode enabled | ADD `create_m4l_project()` function |
| `m4l_constants.py` | M4L parameter enums (ParamType, UnitStyle, ModMode), device type constants, .amxd binary format constants | NEW FILE |
| `critics/m4l_critic.py` | Validates device completeness, gain~/plugout~ rule, parameter_enable on live.* controls | NEW FILE following RNBO critic pattern |
| `critics/__init__.py` | Auto-detects M4L devices and invokes M4L critic | ADD `_has_m4l_boxes()` + conditional call in `review_patch()` |
| `layout.py` | M4L presentation layout with functional grouping | MODIFY `_apply_presentation_layout()` |
| `analysis.py` | Device type detection (audio_effect/instrument/midi_effect) | ADD `detect_device_type()` to AnalysisMixin |
| `hooks.py` | .amxd file export | ADD `write_amxd()` function (~15 lines) |
| `dispatch-rules.md` | M4L keywords route to correct agents | ADD M4L keyword section |
| `CLAUDE.md` | M4L domain rules | ADD M4L section under Domain-Specific Rules |
| Agent SKILL.md files | M4L-specific patterns and conventions | ADD M4L sections to DSP, UI, Patch agents |
| `relationships.json` | M4L object pairings | ADD plugin~/plugout~, live.thisdevice/live.path entries |
| `m4l/objects.json` | Missing M4L objects | ADD live.adsrui, live.adsr~; recategorize live.scope~ |

### What Does NOT Change

These components need zero modification:

| Component | Why No Change |
|-----------|---------------|
| `patcher.py` Patcher class | `self.props` dict already has `openinpresentation` and `devicewidth` keys. Setting `patcher.props["openinpresentation"] = 1` works today. |
| `patcher.py` Box class | `parameter_enable` already emitted in `to_dict()` for UI objects (default 0). Agents set to 1 via `box.extra_attrs["parameter_enable"] = 1`. `saved_attribute_attributes` flows through `extra_attrs` on creation and `_raw` on round-trip. |
| `hooks.py` (existing functions) | `finalize_patch()` already calls `apply_layout()` which calls `_apply_presentation_layout()`. Chain is intact. |
| `validation.py` | Mechanical validation doesn't need M4L-specific checks. The M4L critic handles semantic validation. |
| `sizing.py` | All live.* objects already have correct sizes in UI_SIZES. |
| `maxclass_map.py` | All live.* objects already in UI_MAXCLASSES. plugin~/plugout~ use maxclass="newobj" (confirmed by kicksynth-m4l.maxpat). |

## Data Flow

### M4L Project Creation Flow

```
create_m4l_project("my-effect", base_dir, device_type="audio_effect")
  |
  +-- create_project("my-effect", base_dir)    # existing, unchanged
  |     Creates: patches/my-effect/{context.md, status.md, generated/, test-results/}
  |
  +-- scaffold_m4l_device(patcher, device_type)  # NEW helper
        |
        +-- patcher.props["openinpresentation"] = 1
        +-- patcher.props["devicewidth"] = 250.0  (or per device_type)
        +-- add plugin~ (if audio_effect or instrument)
        +-- add plugout~ (if audio_effect or instrument)
        +-- add live.thisdevice
        +-- add loadbang -> live.thisdevice
        +-- write to generated/{name}.maxpat via save_patch_roundtrip()
        +-- write to generated/{name}.amxd via write_amxd()
```

### .amxd Export Flow

```
write_amxd(patch_dict, device_type, path)
  |
  +-- json_bytes = json.dumps(patch_dict, indent="    ").encode("utf-8")
  +-- header = build_amxd_header(device_type, len(json_bytes))
  +-- write header + json_bytes to path
```

The .amxd format is a 32-byte fixed binary header + identical JSON to .maxpat:
```
Offset  Size  Content
0       4     "ampf" (magic)
4       4     uint32le version (always 4)
8       4     Device type: "aaaa"=audio_effect, "iiii"=instrument, "mmmm"=midi_effect
12      4     "meta" (tag)
16      4     uint32le meta size (always 4)
20      4     4 zero bytes
24      4     "ptch" (tag)
28      4     uint32le JSON byte count
32      N     JSON payload (identical to .maxpat)
```

### M4L Critic Auto-Detection Flow

```
review_patch(patch_dict)
  |
  +-- review_dsp(patch_dict)       # existing, always
  +-- review_structure(patch_dict)  # existing, always
  +-- review_layout(patch_dict)     # existing, always
  |
  +-- if _has_rnbo_boxes(patch_dict):   # existing pattern
  |     review_rnbo(patch_dict)
  |
  +-- if _has_m4l_boxes(patch_dict):    # NEW, same pattern
        review_m4l(patch_dict)
```

Detection logic for `_has_m4l_boxes()`:
```python
def _has_m4l_boxes(patch_dict: dict) -> bool:
    """Check if a patch contains M4L-specific objects."""
    patcher = patch_dict.get("patcher", {})
    boxes = patcher.get("boxes", [])
    for box_entry in boxes:
        box = box_entry.get("box", {})
        text = box.get("text", "")
        name = text.split()[0] if text else ""
        if name in ("plugout~", "plugin~") or name.startswith("live."):
            return True
        if box.get("maxclass", "").startswith("live."):
            return True
    return False
```

### M4L Presentation Layout Flow

```
_apply_presentation_layout(boxes)
  |
  +-- Collect boxes with presentation=True
  +-- if _is_m4l_device(boxes):     # detected via plugin~/plugout~/live.* presence
  |     _apply_m4l_presentation_layout(boxes)
  |       |
  |       +-- Group controls by varname prefix or functional role
  |       +-- Position groups in columns (knobs left, meters right)
  |       +-- Respect devicewidth for horizontal bounds
  |       +-- Place labels above controls
  |
  +-- else:
        existing grid fallback (unchanged)
```

## Patterns to Follow

### Pattern 1: Critic Module Structure (from rnbo_critic.py)

Every critic module follows this exact shape:

```python
"""M4L critic -- semantic review of Max for Live device patches."""

from __future__ import annotations
from src.maxpat.critics.base import CriticResult

def review_m4l(patch_dict: dict) -> list[CriticResult]:
    """Review M4L aspects of a patch."""
    results: list[CriticResult] = []
    # ... checks ...
    return results
```

The critic checks operate on `patch_dict` (raw JSON dict, NOT Patcher instances). This is important -- critics run on serialized output, not live objects. Checks scan `boxes` array for `text`, `maxclass`, and attribute presence.

**M4L critic checks to implement:**
1. **plugout~ presence** (blocker) -- audio_effect/instrument must have plugout~
2. **No gain~ before plugout~** (blocker) -- Ableton channel strip handles volume
3. **parameter_enable on live.* controls** (warning) -- live.dial/slider/numbox/toggle without parameter_enable=1 won't be automatable
4. **live.thisdevice presence** (warning) -- devices should have initialization via live.thisdevice
5. **Device type consistency** (warning) -- instrument without MIDI input, audio_effect with MIDI output, etc.
6. **Duplicate parameter_longname** (blocker) -- causes silent automation collision in Live

### Pattern 2: Scaffold Function in project.py

The scaffold function belongs in `project.py`, not `patcher.py`. Rationale:

- `project.py` already handles project creation lifecycle (create_project, init_versions, etc.)
- `patcher.py` is the data model -- it provides Box/Patcher primitives, not project templates
- The scaffold calls `create_project()` then builds a Patcher with M4L boilerplate, then saves it
- This mirrors how `create_project()` already creates an empty .maxpat at the end

```python
def create_m4l_project(
    name: str,
    base_dir: Path,
    device_type: str = "audio_effect",
) -> Path:
    """Create an M4L device project with correct boilerplate.

    Args:
        name: Project name (lowercase-hyphenated).
        base_dir: Root directory.
        device_type: "audio_effect", "instrument", or "midi_effect".

    Returns:
        Path to created project directory.
    """
    # Validate device_type
    if device_type not in ("audio_effect", "instrument", "midi_effect"):
        raise ValueError(f"Invalid device_type: {device_type}")

    # Create base project structure (reuse existing)
    project_dir = create_project(name, base_dir)

    # Build M4L scaffold patch (overwrites the empty .maxpat)
    from src.maxpat.patcher import Patcher
    p = Patcher()

    # Enable presentation mode
    p.props["openinpresentation"] = 1

    # Device-type-specific scaffolding
    if device_type in ("audio_effect", "instrument"):
        plugin_in = p.add_box("plugin~")
        plugout = p.add_box("plugout~")
        p.add_connection(plugin_in, 0, plugout, 0)
        p.add_connection(plugin_in, 1, plugout, 1)

    thisdevice = p.add_box("live.thisdevice")
    lb = p.add_box("loadbang")
    p.add_connection(lb, 0, thisdevice, 0)

    if device_type == "instrument":
        p.add_box("notein")

    # ... finalize, save .maxpat, and write .amxd ...
```

### Pattern 3: Dispatch Rules Extension

Add M4L as a **modifier** on existing agents, not a new agent. M4L tasks route to DSP + UI + Patch (same as today), but with M4L context injected.

```markdown
### M4L Device Context (modifier, not standalone agent)

**Primary keywords:** m4l, max for live, ableton, live device, audio effect,
instrument, midi effect, plugin~, plugout~, live.thisdevice, parameter_enable

**Secondary keywords:** live.dial, live.slider, live.numbox, live.toggle,
live.button, live.menu, live.tab, live.gain~, live.meter~, live.scope~,
live.path, live.object, live.observer, presentation mode, device width,
automatable, automation

**Effect:** When M4L keywords are detected, add M4L context flag to all
dispatched agents. Agents check this flag and apply M4L-specific rules
from their SKILL.md M4L sections.

**Intent patterns:**
- "Build me a Max for Live audio effect..."
- "Create an M4L instrument..."
- "Make a MIDI effect for Ableton..."
- "Add automatable parameters..."
```

### Pattern 4: Analysis Device Type Detection

Add to AnalysisMixin, following the existing `_classify_domain()` pattern:

```python
def detect_device_type(self) -> str | None:
    """Detect M4L device type from object patterns.

    Returns:
        "audio_effect", "instrument", "midi_effect", or None.
    """
    has_plugin = any(b.name == "plugin~" for b in self.boxes)
    has_plugout = any(b.name == "plugout~" for b in self.boxes)
    has_notein = any(b.name == "notein" for b in self.boxes)
    has_live = any(b.name.startswith("live.") for b in self.boxes)

    if has_plugout and has_notein:
        return "instrument"
    if has_plugout or has_plugin:
        return "audio_effect"
    if has_live and not has_plugout:
        return "midi_effect"
    return None
```

## Anti-Patterns to Avoid

### Anti-Pattern 1: New M4L Module (m4l.py)
**What:** Creating a standalone `src/maxpat/m4l.py` module as a new abstraction layer
**Why bad:** Adds an indirection layer that duplicates Patcher API calls. The scaffold is 30 lines of code, not a module. The critic is a file in critics/. The layout change is a function in layout.py. There is no coherent "M4L module" -- the M4L capability is distributed across existing modules by design.
**Instead:** Add functions to existing modules where they naturally belong. Exception: `m4l_constants.py` is a data-only constants file, not a logic module.

### Anti-Pattern 2: M4L Patcher Subclass
**What:** `class M4LPatcher(Patcher)` with M4L-specific methods
**Why bad:** Violates the existing pattern where Patcher is domain-agnostic. RNBO doesn't have an RNBOPatcher. Gen~ doesn't have a GenPatcher. The Patcher class is a data model; domain intelligence lives in critics, layout, and project functions.
**Instead:** Keep Patcher generic. Domain logic in critic + scaffold + layout functions.

### Anti-Pattern 3: M4L-Specific Agent
**What:** Creating a `max-m4l-agent` specialist
**Why bad:** M4L devices are DSP patches with presentation mode. They use the same objects, same signal flow, same layout. An M4L agent would duplicate 90% of DSP + UI agent capabilities. The real need is M4L context awareness in existing agents.
**Instead:** Add M4L sections to existing agent SKILL.md files. Use dispatch-rules modifier pattern.

### Anti-Pattern 4: Presentation Layout as Separate Module
**What:** Creating `src/maxpat/m4l_layout.py`
**Why bad:** The presentation layout is called from `_apply_presentation_layout()` in layout.py. Splitting it into a separate module means layout.py would import m4l_layout.py for one function. The M4L-aware layout logic is ~50-80 lines -- not worth a module.
**Instead:** Add `_apply_m4l_presentation_layout()` as a private function in layout.py, called from the existing `_apply_presentation_layout()`.

### Anti-Pattern 5: Complex .amxd Export Pipeline
**What:** Building a heavy abstraction layer or separate module for .amxd export
**Why bad:** The .amxd format is a 32-byte fixed header + the same JSON as .maxpat. A "pipeline" for this is over-engineering. The entire export is `struct.pack` + `file.write`.
**Instead:** Add `write_amxd(patch_dict, device_type, path)` as a single function in `hooks.py` alongside `save_patch_roundtrip()`. ~15 lines of code.

## Detailed Integration Points

### 1. project.py: create_m4l_project()

**Location:** After `create_project()` (line ~93), add `create_m4l_project()`.
**Signature:** `create_m4l_project(name, base_dir, device_type="audio_effect") -> Path`
**Depends on:** `create_project()` (calls it internally), `Patcher` class, `save_patch_roundtrip()`, `write_amxd()`
**Tests:** Create audio_effect/instrument/midi_effect, verify plugin~/plugout~ presence, verify openinpresentation=1

### 2. m4l_constants.py: Parameter Enums and Format Constants

**Location:** New file `src/maxpat/m4l_constants.py`
**Contents:** `ParamType`, `UnitStyle`, `ModMode`, `ParamVisibility` (IntEnum classes), `DeviceType` constants, `AMXD_*` binary format constants, `DEVICE_TYPE_SIGNALS` detection patterns
**Depends on:** Nothing (pure data)
**Tests:** Verify enum values match ground truth from kicksynth-m4l.maxpat

### 3. critics/m4l_critic.py: review_m4l()

**Location:** New file in `src/maxpat/critics/`
**Pattern:** Identical to `rnbo_critic.py` -- module-level function returning `list[CriticResult]`
**Depends on:** `CriticResult` from base.py only
**Checks:**
- plugout~ missing (blocker for audio_effect/instrument)
- gain~ directly connected to plugout~ (blocker)
- live.* controls without parameter_enable=1 (warning)
- missing live.thisdevice (warning)
- device type inconsistency (warning)
- duplicate parameter_longname (blocker)

### 4. critics/__init__.py: Auto-detection

**Location:** Add `_has_m4l_boxes()` after `_has_rnbo_boxes()` (line ~25), add conditional call in `review_patch()` (line ~70)
**Pattern:** Exact mirror of RNBO auto-detection
**Import:** `from src.maxpat.critics.m4l_critic import review_m4l`

### 5. layout.py: M4L Presentation Layout

**Location:** Replace/extend `_apply_presentation_layout()` (line 1057)
**Change:** Detect M4L device (plugin~/plugout~/live.* presence), branch to M4L-aware layout
**Grouping strategy:**
- Group by varname prefix (e.g., "osc_" controls together, "filter_" controls together)
- If no varname prefixes, group by control type (dials together, sliders together)
- Place meters/scopes on the right edge
- Respect `devicewidth` from patcher props for horizontal bounds
- Labels above controls (live.comment or comment boxes with presentation=True)

### 6. analysis.py: Device Type Detection

**Location:** Add `detect_device_type()` to AnalysisMixin (after `_classify_domain()`)
**Add to SECTION_SIGNATURES:**
```python
"plugin~": "Audio Input (M4L)",
"plugout~": "Audio Output (M4L)",
"live.thisdevice": "Device Init (M4L)",
```

### 7. hooks.py: write_amxd()

**Location:** After `save_patch_roundtrip()` in hooks.py
**Signature:** `write_amxd(patch_dict, device_type, path) -> None`
**Depends on:** `m4l_constants.py` for AMXD_* constants
**Implementation:** ~15 lines using `struct.pack` for header + `json.dumps` for payload

### 8. dispatch-rules.md: M4L Keywords

**Location:** Add new section after existing agent keyword sections
**Type:** Modifier (context flag), not standalone agent dispatch
**Keywords:** m4l, max for live, ableton, live device, audio effect, instrument, midi effect, plugin~, plugout~, live.thisdevice, parameter_enable, presentation mode

### 9. Object Database Updates

**relationships.json:** Add entries:
- `plugin~` <-> `plugout~` (always paired)
- `live.thisdevice` <-> `loadbang` (init pattern)
- `live.path` <-> `live.object` <-> `live.observer` (API chain)
- `live.dial` <-> `live.param~` (parameter modulation)

**m4l/objects.json:** Add live.adsrui, live.adsr~. Move live.scope~ entry from packages/.

## Suggested Build Order

Based on dependency analysis, build in this order:

### Phase 1: Foundation (no dependencies, enables everything else)

| Task | Module | Effort | Why First |
|------|--------|--------|-----------|
| Add M4L constants module | m4l_constants.py | Small | Enums referenced by scaffold, critic, and export |
| Add M4L objects to DB | m4l/objects.json, relationships.json | Small | Agents need objects to exist before they can use them |
| Add M4L rules to CLAUDE.md | CLAUDE.md | Small | Rules must exist before critic or agents can enforce them |
| Add device type detection | analysis.py | Small | Critic and scaffold both need to know device type |

### Phase 2: Scaffold + Routing (depends on Phase 1)

| Task | Module | Effort | Why Second |
|------|--------|--------|------------|
| M4L device scaffold | project.py | Medium | Creates the starting point for all M4L devices |
| M4L dispatch rules | dispatch-rules.md | Small | Routes M4L tasks correctly |
| M4L agent instructions | SKILL.md files (3) | Small | Agents know what to do with M4L context |

### Phase 3: Validation + Export (depends on Phase 1 device type detection)

| Task | Module | Effort | Why Third |
|------|--------|--------|-----------|
| M4L critic module | critics/m4l_critic.py | Medium | Catches problems after generation |
| Critic auto-detection | critics/__init__.py | Small | Wires critic into review_patch() |
| .amxd export | hooks.py | Small | Completes device creation loop (~15 LOC) |

### Phase 4: Polish (depends on Phases 1-3)

| Task | Module | Effort | Why Last |
|------|--------|--------|----------|
| M4L presentation layout | layout.py | Medium-Large | Needs real devices to test against; scaffold must exist first |
| End-to-end tests | tests/test_m4l_workflow.py | Medium | Needs scaffold + critic to test the full loop |

**Critical path:** Phase 1 -> Phase 2 -> Phase 3 -> Phase 4

**Parallelizable within phases:**
- Phase 1: All 4 tasks are independent
- Phase 2: Scaffold and dispatch/skills are independent
- Phase 3: Critic module and __init__.py wiring are sequential (module first); .amxd export is independent
- Phase 4: Layout and tests are independent

### Why This Order

1. **Constants + DB + rules first** because every other component references the parameter enums, object database, or CLAUDE.md rules. Building the critic before adding M4L constants means the critic can't use typed enums.

2. **Scaffold before critic** because the critic validates scaffolded devices. Without a scaffold to generate test fixtures, critic tests would require handcrafted JSON (fragile). With the scaffold, tests call `create_m4l_project()` and validate the output.

3. **Critic before layout** because the critic catches structural errors (missing plugout~, gain~ before plugout~) that would make layout testing meaningless. Fix structure first, then polish presentation.

4. **.amxd export in Phase 3** because it depends on device type detection (Phase 1) and is trivial to implement. Shipping it with validation means the scaffold can output both .maxpat and .amxd from the start.

5. **Layout last** because it's the most subjective and least testable component. The capability review recommends deferring presentation layout intelligence until more real devices are built. The crude grid fallback works for now; M4L-aware layout benefits from learning from actual usage patterns.

## Sources

All findings from direct codebase analysis + .amxd format reverse-engineering:
- `src/maxpat/critics/__init__.py` -- RNBO auto-detection pattern (the pattern M4L critic will follow)
- `src/maxpat/critics/rnbo_critic.py` -- Critic module structure template
- `src/maxpat/project.py` -- Project creation lifecycle
- `src/maxpat/patcher.py` -- Box/Patcher data model, props dict, parameter_enable handling, extra_attrs mechanism
- `src/maxpat/layout.py` -- Presentation layout function (lines 1057-1083)
- `src/maxpat/analysis.py` -- Domain classification, SECTION_SIGNATURES
- `src/maxpat/defaults.py` -- DEFAULT_PATCHER_PROPS showing openinpresentation/devicewidth already present
- `.claude/skills/max-router/references/dispatch-rules.md` -- Keyword routing pattern
- `.planning/quick/260405-lne-review-m4l-device-creation-capabilities-/M4L-CAPABILITY-REVIEW.md` -- Gap analysis
- `patches/kicksynth/generated/kicksynth-m4l.maxpat` -- Real M4L device proof point
- `patches/kicksynth/generated/kicksynth-m4l.amxd` -- Reverse-engineered binary format (32-byte header + JSON)
