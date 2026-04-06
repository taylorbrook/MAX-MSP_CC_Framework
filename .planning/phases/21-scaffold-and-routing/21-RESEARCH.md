# Phase 21: Scaffold and Routing - Research

**Researched:** 2026-04-06
**Domain:** M4L device scaffolding, project lifecycle, agent routing
**Confidence:** HIGH

## Summary

Phase 21 adds `create_m4l_project()` to `project.py` for scaffolding valid M4L device skeletons (audio_effect, instrument, midi_effect) and updates the router + agent SKILL.md files with M4L-specific dispatch rules and context sections.

The codebase is well-structured for this work. `create_project()` in `project.py` establishes the directory/version pattern that `create_m4l_project()` reuses. The `Patcher` class API (`add_box`, `add_connection`, `to_dict`) handles all patch construction. M4L constants (`m4l_constants.py`) and device detection (`analysis.py::detect_device_type`) from Phase 20 are already in place. The kicksynth-m4l.maxpat provides ground-truth reference for `saved_attribute_attributes`, `openinpresentation`, `devicewidth`, and `parameter_enable` patterns.

**Primary recommendation:** Split into two plan groups: (1) scaffold implementation + tests in `project.py`, (2) router dispatch-rules.md M4L section + agent SKILL.md M4L sections. These are independent and can execute in parallel.

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions
- **D-01:** Minimal boilerplate only -- scaffold generates required objects per device type (plugin~/plugout~/midiin/midiout/live.thisdevice) plus openinpresentation=1 and devicewidth. No example controls, signal chains, or comments. Agents add everything else during /max-build.
- **D-02:** `create_m4l_project(device_type, name, base_dir)` is a separate function in project.py. Does not extend or modify existing `create_project()`.
- **D-03:** Instrument and midi_effect scaffolds include midiin -> midiout connected passthrough. MIDI flows through even if the device doesn't process it -- prevents silent MIDI drops.
- **D-04:** `---` prefix applied at scaffold-time only. `create_m4l_project()` prefixes named objects in the scaffold. During /max-build and /max-iterate, agents follow CLAUDE.md rules to add `---` manually. No Patcher API changes needed.
- **D-05:** Default devicewidth is 300px (Ableton's stock device default, fits 4-5 dials in a row).
- **D-06:** Scaffold sets presentation flags only: openinpresentation=1 on patcher, presentation=1 and presentation_rect on live.thisdevice. No presentation_rect on boilerplate objects (plugin~, plugout~, midiin, midiout). Phase 24 Layout engine handles all presentation positioning.
- **D-07:** Router dispatches M4L tasks to existing agents (dsp, patch, ui) with M4L-specific context injected. No dedicated M4L agent. Matches existing RNBO dispatch pattern.
- **D-08:** Router detects M4L keywords ("Max for Live", "M4L", "Ableton device", "audio effect device", "instrument device", "MIDI effect") and injects device type context into the dispatch.
- **D-09:** Four agents get M4L-specific SKILL.md sections: max-patch-agent (MIDI routing, live.path/live.object), max-dsp-agent (plugin~/plugout~ I/O, gain~/plugout~ prohibition), max-ui-agent (live.* controls, parameter_enable, presentation mode, 169px), max-router (M4L keyword detection, dispatch-rules.md M4L section).
- **D-10:** max-critic gets a brief M4L awareness note -- M4L devices will have a dedicated critic in Phase 22. Prevents the general critic from flagging M4L-specific patterns as errors.

### Claude's Discretion
- Object positioning within scaffold patches (patching_rect coordinates for boilerplate objects)
- Exact M4L keyword list for router dispatch (beyond the core ones specified in D-08)
- Internal structure of M4L context injection (how device type info is passed to agents)

### Deferred Ideas (OUT OF SCOPE)
None -- discussion stayed within phase scope
</user_constraints>

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|------------------|
| SCAFFOLD-01 | Framework scaffolds audio_effect devices with plugin~/plugout~, live.thisdevice, openinpresentation, and devicewidth | Patcher API supports all needed operations; plugin~/plugout~ override to maxclass="newobj" confirmed in overrides.json; live.thisdevice uses its own maxclass; devicewidth and openinpresentation are patcher-level props |
| SCAFFOLD-02 | Framework scaffolds instrument devices with midiin/midiout passthrough, plugout~, live.thisdevice | midiin/midiout resolve to maxclass="newobj"; plugout~ override confirmed; midiin->midiout connection for MIDI passthrough per D-03 |
| SCAFFOLD-03 | Framework scaffolds midi_effect devices with midiin/midiout, live.thisdevice (no audio I/O) | No plugin~/plugout~ needed; midiin->midiout connection per D-03 |
| SCAFFOLD-04 | Framework auto-sets parameter_enable=1 with saved_attribute_attributes on all live.* UI controls in M4L context | Scaffold only adds live.thisdevice (no live.* UI controls in minimal boilerplate per D-01); this requirement applies at /max-build time when agents add controls -- scaffold provides the M4L context flag so agents know to apply parameter_enable |
| SCAFFOLD-05 | Framework auto-prefixes named objects with `---` in M4L context | Per D-04, applied at scaffold-time on boilerplate objects; agents follow CLAUDE.md rules for their additions |
| SCAFFOLD-06 | Framework sets presentation=1 and presentation_rect on all user-facing objects in M4L devices | Per D-06, scaffold sets on live.thisdevice only; agents set on their additions during /max-build |
| ROUTING-01 | Router recognizes M4L keywords and dispatches with M4L-specific context | dispatch-rules.md needs new M4L section; keyword list from D-08 |
| ROUTING-03 | Agent SKILL.md files have M4L-specific instruction sections | Four agents + critic per D-09/D-10; content mirrors CLAUDE.md M4L rules, domain-specific |
</phase_requirements>

## Standard Stack

### Core
| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| src.maxpat.patcher | local | Patcher/Box/Patchline construction | Project's own API for all patch generation [VERIFIED: codebase] |
| src.maxpat.project | local | Project lifecycle (directory, versions, status) | Existing create_project() pattern to follow [VERIFIED: codebase] |
| src.maxpat.m4l_constants | local | ParamType, UnitStyle, ModMode enums | Phase 20 output, used for saved_attribute_attributes values [VERIFIED: codebase] |
| src.maxpat.db_lookup | local | ObjectDatabase for I/O verification | Required by CLAUDE.md Rule #1 for all object lookups [VERIFIED: codebase] |
| src.maxpat.aesthetics | local | set_canvas_background() | Applied to new patches per create_project() pattern [VERIFIED: codebase] |

### Supporting
| Library | Version | Purpose | When to Use |
|---------|---------|---------|-------------|
| src.maxpat.analysis | local | detect_device_type(), DeviceTypeResult | Already implemented in Phase 20; can validate scaffold output [VERIFIED: codebase] |
| src.maxpat.hooks | local | save_patch_roundtrip() | Final save with git commit [VERIFIED: codebase] |
| pytest | 9.0.2 | Test framework | All tests in tests/ directory [VERIFIED: system] |

## Architecture Patterns

### Recommended Project Structure (no new files needed beyond code additions)
```
src/maxpat/
  project.py         # ADD: create_m4l_project() function
  m4l_constants.py   # EXISTING: enums (Phase 20)
  analysis.py        # EXISTING: detect_device_type() (Phase 20)
.claude/skills/
  max-router/
    SKILL.md                     # UPDATE: add M4L dispatch section
    references/dispatch-rules.md # UPDATE: add M4L keyword section
  max-patch-agent/SKILL.md       # UPDATE: add M4L MIDI section
  max-dsp-agent/SKILL.md         # UPDATE: add M4L signal chain section
  max-ui-agent/SKILL.md          # UPDATE: add M4L presentation section
  max-critic/SKILL.md            # UPDATE: add M4L awareness note
tests/
  test_m4l_scaffold.py  # NEW: scaffold tests
```

### Pattern 1: create_m4l_project() Function Signature

**What:** New function in project.py following the create_project() pattern.
**When to use:** Called by `/max-new` when user specifies or detection identifies M4L device.

```python
# Source: derived from create_project() pattern at project.py:31-93
def create_m4l_project(
    device_type: str,  # "audio_effect" | "instrument" | "midi_effect"
    name: str,
    base_dir: Path,
    devicewidth: float = 300.0,
) -> Path:
    """Create an M4L device project with valid boilerplate patch.
    
    Calls create_project() for directory scaffolding, then replaces the
    empty .maxpat with a device-type-specific skeleton.
    """
```
[VERIFIED: codebase pattern at project.py:31-93]

### Pattern 2: M4L Patcher Construction

**What:** Building the scaffold .maxpat with correct patcher-level properties and boilerplate objects.
**When to use:** Inside create_m4l_project().

```python
# Source: kicksynth-m4l.maxpat ground truth + defaults.py props
from src.maxpat.patcher import Patcher
from src.maxpat.aesthetics import set_canvas_background

p = Patcher()
set_canvas_background(p)

# M4L patcher-level properties
p.props["openinpresentation"] = 1
p.props["devicewidth"] = devicewidth  # default 300.0 per D-05

# Add boilerplate objects per device type
thisdevice = p.add_box("live.thisdevice", x=20.0, y=20.0)
thisdevice.presentation = True
thisdevice.presentation_rect = [0.0, 0.0, 120.0, 20.0]  # small, top-left
```
[VERIFIED: kicksynth-m4l.maxpat shows openinpresentation=1, devicewidth at patcher level; Patcher.props is a dict that serializes directly via to_dict()]

### Pattern 3: Device-Type Boilerplate Objects

**What:** Required objects per device type.
**When to use:** Device-type-specific scaffold branches.

**audio_effect:** plugin~ + plugout~ + live.thisdevice
```python
plugin = p.add_box("plugin~", x=50.0, y=80.0)
plugout = p.add_box("plugout~", x=50.0, y=200.0)
# plugin~ outlets -> plugout~ inlets (stereo passthrough)
p.add_connection(plugin, 0, plugout, 0)
p.add_connection(plugin, 1, plugout, 1)
```

**instrument:** midiin + midiout + plugout~ + live.thisdevice
```python
midiin = p.add_box("midiin", x=50.0, y=80.0)
midiout = p.add_box("midiout", x=50.0, y=200.0)
plugout = p.add_box("plugout~", x=200.0, y=200.0)
# MIDI passthrough per D-03
p.add_connection(midiin, 0, midiout, 0)
```

**midi_effect:** midiin + midiout + live.thisdevice (NO audio I/O)
```python
midiin = p.add_box("midiin", x=50.0, y=80.0)
midiout = p.add_box("midiout", x=50.0, y=200.0)
# MIDI passthrough per D-03
p.add_connection(midiin, 0, midiout, 0)
```
[VERIFIED: CLAUDE.md M4L section defines required objects per type; D-03 mandates midiin->midiout passthrough]

### Pattern 4: Dispatch Rules Markdown Extension

**What:** Adding M4L keyword section to dispatch-rules.md.
**When to use:** Router reads this file at dispatch time.

```markdown
### M4L Dispatch (Max for Live Devices)

**Primary keywords:** Max for Live, M4L, Ableton device, audio effect device,
instrument device, MIDI effect, amxd, live device

**Secondary keywords:** live.dial, live.slider, live.numbox, live.toggle,
live.menu, live.tab, live.text, live.adsrui, plugin~, plugout~,
parameter_enable, presentation mode, devicewidth, live.thisdevice,
live.path, live.object, live.banks, push controller

**Dispatch strategy:** M4L tasks dispatch to existing agents with M4L context:
- DSP tasks in M4L context -> max-dsp-agent + M4L signal chain rules
- UI tasks in M4L context -> max-ui-agent + M4L presentation rules
- MIDI routing in M4L context -> max-patch-agent + M4L MIDI rules
- Multi-domain M4L -> standard multi-agent with M4L context on all

**Context injection:** When M4L detected, inject:
- Device type (audio_effect/instrument/midi_effect)
- M4L-specific rules reminder (--- prefix, parameter_enable, 169px height)
- Reference to CLAUDE.md M4L section
```
[VERIFIED: dispatch-rules.md structure at .claude/skills/max-router/references/dispatch-rules.md]

### Anti-Patterns to Avoid
- **Modifying create_project():** D-02 explicitly requires a separate function. Do NOT add M4L parameters to the existing function.
- **Adding example controls to scaffold:** D-01 is minimal boilerplate only. No dials, sliders, or signal chains.
- **Adding Patcher API auto-prefix:** D-04 says no Patcher API changes. `---` prefix is manual at scaffold-time and by agents during generation.
- **Using database maxclass field for midiin/midiout:** The `resolve_maxclass()` function determines maxclass, NOT the database's maxclass field. midiin/midiout resolve to "newobj" correctly through resolve_maxclass().

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Object I/O counts | Hardcoded inlet/outlet numbers | `ObjectDatabase.compute_io_counts()` | Variable I/O objects, DB is source of truth |
| Box sizing | Manual patching_rect widths | `calculate_box_size()` via Box constructor | Content-aware sizing handles all cases |
| Maxclass resolution | Hardcoded maxclass strings | `resolve_maxclass()` via Box constructor | UI_MAXCLASSES handles all known objects |
| Directory scaffolding | Manual mkdir/file writes | Call `create_project()` first, then replace .maxpat | Reuses version tracking, status, context.md |
| Git commits | Manual git subprocess calls | `auto_commit_patch()` | Handles staging, diff check, commit message |

**Key insight:** The scaffold should reuse `create_project()` for directory structure then replace the generated .maxpat with the M4L-specific one. This avoids duplicating directory creation, version init, context.md, and status.md logic.

## Common Pitfalls

### Pitfall 1: plugin~/plugout~ maxclass Override
**What goes wrong:** Without the override, Box constructor resolves plugin~/plugout~ maxclass from the database as "plugin~"/"plugout~" instead of "newobj".
**Why it happens:** The database has `maxclass: "plugin~"` but the override in overrides.json forces it to "newobj". The Box constructor uses `resolve_maxclass()` which checks UI_MAXCLASSES. plugin~/plugout~ are NOT in UI_MAXCLASSES, so they correctly resolve to "newobj" via resolve_maxclass(). The database override just ensures DB lookups are also correct.
**How to avoid:** Use `p.add_box("plugin~")` -- the standard path handles this correctly. Do NOT manually set maxclass.
**Warning signs:** Patches with `"maxclass": "plugin~"` instead of `"maxclass": "newobj"` in the JSON output.
[VERIFIED: overrides.json line 5943-5948; maxclass_map.py resolve_maxclass() does not include plugin~/plugout~ in UI_MAXCLASSES]

### Pitfall 2: live.thisdevice Uses Its Own Maxclass
**What goes wrong:** Assuming all objects use maxclass="newobj".
**Why it happens:** live.thisdevice IS in UI_MAXCLASSES (maxclass_map.py line 48), so it uses `maxclass: "live.thisdevice"` -- unlike plugin~/plugout~/midiin/midiout which use "newobj".
**How to avoid:** Use `p.add_box("live.thisdevice")` -- resolve_maxclass handles it. Do NOT set text field manually.
**Warning signs:** Box.text being set on a live.thisdevice box (UI objects don't have text fields in .maxpat).
[VERIFIED: maxclass_map.py line 48; Box.to_dict() only sets text for maxclass=="newobj" or "comment"/"message"]

### Pitfall 3: parameter_enable on Non-Parameter Objects
**What goes wrong:** Setting parameter_enable=1 on live.thisdevice or other non-parameter M4L objects.
**Why it happens:** SCAFFOLD-04 says "all live.* UI controls" but live.thisdevice is NOT a user-facing control. The Box.to_dict() creation path sets `parameter_enable: 0` on UI objects by default (line 321).
**How to avoid:** Only set parameter_enable=1 on actual control objects: live.dial, live.slider, live.numbox, live.toggle, live.menu, live.tab, live.text, live.adsrui. The scaffold only has live.thisdevice (which keeps default parameter_enable=0). Agents adding controls during /max-build handle parameter_enable themselves.
**Warning signs:** saved_attribute_attributes on live.thisdevice (it doesn't need parameter metadata).
[VERIFIED: kicksynth-m4l.maxpat line 113 shows parameter_enable=0 on non-parameter objects]

### Pitfall 4: saved_attribute_attributes Missing Required Fields
**What goes wrong:** Ableton ignores parameter or shows default values if required fields are missing.
**Why it happens:** The saved_attribute_attributes.valueof block needs at minimum: parameter_longname, parameter_shortname, parameter_type, parameter_unitstyle, parameter_modmode.
**How to avoid:** Provide a helper function or reference pattern for agents to use when adding live.* controls. SKILL.md M4L sections should include the minimum required fields.
**Warning signs:** live.* controls without saved_attribute_attributes block or missing fields within it.
[VERIFIED: kicksynth-m4l.maxpat all live.dial/live.tab boxes have complete valueof blocks]

### Pitfall 5: MIDI passthrough Missing on Instrument/MIDI Devices
**What goes wrong:** MIDI data stops flowing through the device, causing silent failures in Ableton.
**Why it happens:** If midiin and midiout are present but not connected, MIDI doesn't pass through.
**How to avoid:** D-03 requires midiin -> midiout connection in instrument and midi_effect scaffolds. Always include this connection.
**Warning signs:** midiin and midiout boxes present but no patchline connecting them.
[VERIFIED: CLAUDE.md M4L section: "MIDI flows through even if the device doesn't process it -- always include both objects"]

### Pitfall 6: devicewidth vs patcher rect Width
**What goes wrong:** Device appears at wrong width in Ableton.
**Why it happens:** Ableton uses `devicewidth` (patcher-level property), NOT `rect[2]` (window width). These are independent values.
**How to avoid:** Set `p.props["devicewidth"] = 300.0` (D-05 default). The patcher rect width (640 default) is the editor window size, not the device size.
**Warning signs:** patcher rect width changed instead of devicewidth property.
[VERIFIED: kicksynth-m4l.maxpat line 19 shows devicewidth=614.0 separate from rect]

## Code Examples

### Complete audio_effect Scaffold Pattern
```python
# Source: synthesized from create_project() pattern + kicksynth-m4l.maxpat ground truth
from pathlib import Path
from src.maxpat.patcher import Patcher
from src.maxpat.aesthetics import set_canvas_background
from src.maxpat.project import create_project, auto_commit_patch
import json

def create_m4l_project(
    device_type: str,
    name: str,
    base_dir: Path,
    devicewidth: float = 300.0,
) -> Path:
    # Reuse directory scaffolding
    project_dir = create_project(name, base_dir)
    
    # Build M4L-specific patch
    p = Patcher()
    set_canvas_background(p)
    p.props["openinpresentation"] = 1
    p.props["devicewidth"] = devicewidth
    
    # live.thisdevice (all device types)
    thisdevice = p.add_box("live.thisdevice", x=20.0, y=20.0)
    thisdevice.presentation = True
    thisdevice.presentation_rect = [0.0, 0.0, 120.0, 20.0]
    
    if device_type == "audio_effect":
        plugin = p.add_box("plugin~", x=50.0, y=80.0)
        plugout = p.add_box("plugout~", x=50.0, y=200.0)
        p.add_connection(plugin, 0, plugout, 0)
        p.add_connection(plugin, 1, plugout, 1)
        
    elif device_type == "instrument":
        midiin = p.add_box("midiin", x=50.0, y=80.0)
        midiout = p.add_box("midiout", x=50.0, y=200.0)
        plugout = p.add_box("plugout~", x=200.0, y=200.0)
        p.add_connection(midiin, 0, midiout, 0)
        
    elif device_type == "midi_effect":
        midiin = p.add_box("midiin", x=50.0, y=80.0)
        midiout = p.add_box("midiout", x=50.0, y=200.0)
        p.add_connection(midiin, 0, midiout, 0)
    
    # Write M4L patch over the empty one
    patch_dict = p.to_dict()
    maxpat_path = project_dir / "generated" / f"{name}.maxpat"
    maxpat_path.write_text(json.dumps(patch_dict, indent=2) + "\n")
    
    # Commit per CLAUDE.md Rule #7
    auto_commit_patch(project_dir, base_dir, description=f"scaffold {device_type} device")
    
    return project_dir
```

### saved_attribute_attributes Template (for agent SKILL.md reference)
```python
# Source: kicksynth-m4l.maxpat ground truth (lines 618-632)
# Minimum required fields for a live.dial parameter
PARAM_TEMPLATE = {
    "saved_attribute_attributes": {
        "valueof": {
            "parameter_longname": "Param Name",      # unique across device
            "parameter_shortname": "P.Name",          # 8 chars max (Push display)
            "parameter_type": 0,                      # ParamType.INT=0, FLOAT=1, ENUM=2
            "parameter_unitstyle": 0,                 # UnitStyle enum value
            "parameter_modmode": 0,                   # ModMode.UNIPOLAR=0
        }
    }
}
# Optional but common: parameter_mmin, parameter_mmax, parameter_initial,
# parameter_initial_enable, parameter_enum (for ENUM type)
```
[VERIFIED: kicksynth-m4l.maxpat all live.dial boxes contain these fields]

### M4L SKILL.md Section Template (for max-dsp-agent)
```markdown
### M4L Signal Chain Rules

When generating audio for M4L devices (audio_effect or instrument):

- **plugin~/plugout~ are the I/O:** audio_effect uses plugin~ (stereo input) and plugout~ (stereo output). Instruments use plugout~ only.
- **NEVER connect gain~ to plugout~:** Ableton's channel strip handles volume. The M4L critic (Phase 22) flags this as an error.
- **Use maxclass="newobj"** for plugin~/plugout~ -- they are NOT UI objects. The Box constructor handles this correctly via add_box("plugin~").
- **Stereo convention:** plugin~ has 2 outlets (L/R), plugout~ has 2 inlets (L/R). Connect both channels.
```
[VERIFIED: CLAUDE.md M4L section; overrides.json plugin~/plugout~ maxclass override]

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| Manual .maxpat JSON construction | Patcher API (add_box, add_connection, to_dict) | Phase 2 | All patch generation uses typed API |
| plugin~/plugout~ maxclass guessing | overrides.json forces maxclass="newobj" | Phase 20 | Correct maxclass resolution for M4L audio I/O |
| No M4L detection | detect_device_type() in analysis.py | Phase 20 | Enables scaffold to validate its own output |
| No M4L constants | m4l_constants.py IntEnum classes | Phase 20 | Typed parameter values for saved_attribute_attributes |

**From CLAUDE.md (already in place):**
- M4L domain rules including device types, `---` prefix, parameter_enable, presentation mode, 169px height constraint, live.* controls, MIDI passthrough -- all documented and authoritative

## Assumptions Log

> List all claims tagged [ASSUMED] in this research.

| # | Claim | Section | Risk if Wrong |
|---|-------|---------|---------------|
| A1 | midiin/midiout resolve to maxclass="newobj" via resolve_maxclass() | Common Pitfalls, Pattern 3 | midiin/midiout boxes would render incorrectly in MAX |
| A2 | live.thisdevice presentation_rect of [0,0,120,20] is reasonable | Pattern 2 | Mispositioned in Ableton device view -- trivial to adjust |
| A3 | Calling create_project() first then replacing .maxpat is safe | Don't Hand-Roll | Could create unnecessary empty .maxpat write -- minor perf concern only |

**Mitigation for A1:** The maxclass_map.py UI_MAXCLASSES set does NOT contain "midiin" or "midiout". `resolve_maxclass()` returns "newobj" for anything not in that set. This is the same behavior as notein, noteout, ctlin, etc., which are confirmed "newobj" in kicksynth-m4l.maxpat. HIGH confidence this is correct.

## Open Questions (RESOLVED)

1. **midiin/midiout I/O Count Verification** -- RESOLVED
   - What we know: Database says midiin has 1 inlet, 1 outlet; midiout has 1 inlet, 1 outlet
   - What's unclear: Whether midiout has any outlets (some MIDI objects have status outlets)
   - Recommendation: Trust ObjectDatabase.compute_io_counts() -- it's verified. LOW risk.
   - Resolution: Using ObjectDatabase as source of truth. If midiout has additional outlets they are unused in the scaffold (only inlet 0 is connected).

2. **Should scaffold include a `---` prefixed object?** -- RESOLVED
   - What we know: D-04 says prefix applied at scaffold-time, but D-01 says minimal boilerplate only
   - What's unclear: The scaffold boilerplate (plugin~, plugout~, midiin, midiout, live.thisdevice) doesn't include any named objects that need `---` prefix (no buffer~, coll, dict, send, receive, etc.)
   - Recommendation: SCAFFOLD-05 is satisfied by the `create_m4l_project()` function being M4L-aware. The actual `---` prefixing happens when agents add named objects during /max-build. The scaffold itself has no objects that need the prefix. Document this clearly.
   - Resolution: No `---` prefixed objects in scaffold. SCAFFOLD-05 satisfied by M4L-aware context (openinpresentation=1) that signals downstream agents to apply `---` prefix when adding named objects. Tests verify the precondition: scaffold contains no named objects that would need the prefix.

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | pytest 9.0.2 |
| Config file | none (uses default discovery) |
| Quick run command | `python -m pytest tests/test_m4l_scaffold.py -x` |
| Full suite command | `python -m pytest tests/ -x` |

### Phase Requirements to Test Map
| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| SCAFFOLD-01 | audio_effect scaffold has plugin~, plugout~, live.thisdevice, openinpresentation=1, devicewidth | unit | `python -m pytest tests/test_m4l_scaffold.py::TestAudioEffect -x` | Wave 0 |
| SCAFFOLD-02 | instrument scaffold has midiin, midiout, plugout~, live.thisdevice, midiin->midiout connection | unit | `python -m pytest tests/test_m4l_scaffold.py::TestInstrument -x` | Wave 0 |
| SCAFFOLD-03 | midi_effect scaffold has midiin, midiout, live.thisdevice, no audio I/O, midiin->midiout connection | unit | `python -m pytest tests/test_m4l_scaffold.py::TestMidiEffect -x` | Wave 0 |
| SCAFFOLD-04 | Scaffold contains no live.* UI controls (precondition: parameter_enable applies at /max-build time) | unit | `python -m pytest tests/test_m4l_scaffold.py::TestParameterEnable -x` | Wave 0 |
| SCAFFOLD-05 | Scaffold contains no named objects needing `---` prefix (precondition: prefix applies at /max-build time) | unit | `python -m pytest tests/test_m4l_scaffold.py::TestTripleDashPrefix -x` | Wave 0 |
| SCAFFOLD-06 | Presentation flags set on user-facing objects | unit | `python -m pytest tests/test_m4l_scaffold.py::TestPresentation -x` | Wave 0 |
| ROUTING-01 | Router M4L keywords in dispatch-rules.md | grep | `grep "M4L Dispatch" .claude/skills/max-router/references/dispatch-rules.md` | N/A |
| ROUTING-03 | Agent SKILL.md files contain M4L sections | grep | `grep -l "M4L" .claude/skills/max-dsp-agent/SKILL.md .claude/skills/max-patch-agent/SKILL.md .claude/skills/max-ui-agent/SKILL.md .claude/skills/max-critic/SKILL.md` | N/A |

### Sampling Rate
- **Per task commit:** `python -m pytest tests/test_m4l_scaffold.py -x`
- **Per wave merge:** `python -m pytest tests/ -x`
- **Phase gate:** Full suite green before `/gsd-verify-work`

### Wave 0 Gaps
- [ ] `tests/test_m4l_scaffold.py` -- covers SCAFFOLD-01 through SCAFFOLD-06

## Project Constraints (from CLAUDE.md)

Actionable directives affecting this phase:

1. **Rule #1 (Never Guess Objects):** All objects in scaffold MUST be verified via ObjectDatabase. Use `p.add_box()` which auto-validates.
2. **Rule #2 (Verify Before Connect):** All connections must be within I/O bounds. ObjectDatabase provides counts.
3. **Rule #5 (No Generator Scripts):** Scaffold builds patches via Patcher API in-memory. No separate generate.py script.
4. **Rule #7 (Commit After Every Save):** Use `auto_commit_patch()` after writing .maxpat.
5. **M4L Device Types:** audio_effect (plugin~/plugout~), instrument (midiin/plugout~), midi_effect (midiin/midiout, no audio I/O).
6. **No gain~ to plugout~:** Ableton's channel strip handles volume.
7. **`---` prefix:** All named objects in M4L devices MUST use `---` prefix.
8. **parameter_enable=1:** Every live.* UI control needs complete saved_attribute_attributes block.
9. **openinpresentation=1:** Required on all M4L device patchers.
10. **169px height constraint:** Ableton's device view is 169px tall. All presentation-mode controls must fit.
11. **Presentation mode:** M4L devices must set openinpresentation=1; user-facing controls need presentation=1 + presentation_rect.
12. **MIDI passthrough:** Instrument and midi_effect devices use midiin/midiout. Always include both.

## Sources

### Primary (HIGH confidence)
- `src/maxpat/project.py` -- create_project() pattern, auto_commit_patch()
- `src/maxpat/patcher.py` -- Box constructor, Patcher.add_box(), to_dict() serialization
- `src/maxpat/m4l_constants.py` -- ParamType, UnitStyle, ModMode, ParamVisibility enums
- `src/maxpat/maxclass_map.py` -- resolve_maxclass(), UI_MAXCLASSES set (includes live.thisdevice, excludes plugin~/plugout~/midiin/midiout)
- `src/maxpat/defaults.py` -- DEFAULT_PATCHER_PROPS (openinpresentation default=0)
- `.claude/max-objects/overrides.json` -- plugin~/plugout~ maxclass="newobj" override
- `patches/kicksynth/generated/kicksynth-m4l.maxpat` -- ground truth for M4L device structure
- `.claude/skills/max-router/references/dispatch-rules.md` -- current dispatch rules format
- `.claude/skills/max-{patch,dsp,ui,critic}/SKILL.md` -- current skill file structure

### Secondary (MEDIUM confidence)
- `.claude/max-objects/max/objects.json` -- midiin/midiout object data (maxclass field says "midiin"/"midiout" but resolve_maxclass overrides to "newobj")
- `.claude/max-objects/msp/objects.json` -- plugin~/plugout~ I/O counts (2 inlets, 2 outlets each)

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH -- all code paths verified in codebase, no external dependencies
- Architecture: HIGH -- follows established create_project() and dispatch-rules.md patterns
- Pitfalls: HIGH -- all verified against ground truth (kicksynth-m4l.maxpat) and source code

**Research date:** 2026-04-06
**Valid until:** 2026-05-06 (30 days -- stable internal codebase, no external API dependencies)
