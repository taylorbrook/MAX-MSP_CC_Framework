# Phase 22: Validation and Export - Context

**Gathered:** 2026-04-06
**Status:** Ready for planning

<domain>
## Phase Boundary

M4L critic module validates device correctness (gain~/plugout~ rule, device completeness, parameter uniqueness, device quality) and write_amxd() produces valid .amxd files with correct binary headers per device type. Catches errors before the user opens in Ableton and completes the device creation loop.

</domain>

<decisions>
## Implementation Decisions

### Critic Error Behavior
- **D-01:** Report only -- M4L critic returns CriticResult findings with severity levels (error/warning/info), same as existing critics. Does not block file writes. Agents and hooks read results and decide how to act. Keeps critic system consistent across all domains.

### AMXD Export Integration
- **D-02:** Standalone `write_amxd(patch_path, output_path, device_type)` function in a new `src/maxpat/m4l_export.py` module. Called explicitly by agents or user -- export is a deliberate step, not auto-triggered on save. Clean separation from hooks.py.

### Device Auto-Detection
- **D-03:** Detection strategy is Claude's discretion. Must wire into `critics/__init__.py` so M4L critic auto-invokes when device type detected (SC#4). Pattern follows existing `_has_rnbo_boxes()` approach.

### Validation Scope
- **D-04:** Full device quality validation beyond the 3 required checks:
  - VALID-01: gain~ connected to plugout~ flagged as error
  - VALID-02: Device completeness per type (required objects: plugout~ for audio_effect/instrument, midiin/midiout for instrument/midi_effect, live.thisdevice for all)
  - VALID-03: Unique parameter_longname across entire device (duplicate = blocker)
  - Plus: openinpresentation=1 on patcher, devicewidth set, live.thisdevice has presentation_rect
  - Plus: parameter_enable blocks on live.* controls, parameter ranges set, no orphaned live.* objects
- **D-05:** plugout~ and plugin~ added to `_TERMINAL_NAMES` / `_IO_OBJECT_NAMES` in dsp_critic.py and layout.py (SC#6).

### Claude's Discretion
- M4L device auto-detection approach (simple pattern check vs confidence-scored -- D-03)
- Internal structure of m4l_critic.py (function signatures, helper organization)
- Severity assignment for quality checks beyond VALID-01/02/03 (warning vs info)
- How device_type is inferred from patch structure for auto-detection

</decisions>

<canonical_refs>
## Canonical References

**Downstream agents MUST read these before planning or implementing.**

### Critic Template
- `src/maxpat/critics/rnbo_critic.py` -- Template for domain-specific critic. Shows pattern: detect domain boxes, scan inner patchers, return CriticResult list. M4L critic follows same structure.
- `src/maxpat/critics/__init__.py` -- review_patch() combines all critics with auto-detection. M4L critic must be wired in here with auto-invoke logic.
- `src/maxpat/critics/base.py` -- CriticResult class definition, severity levels.

### DSP Critic (needs plugout~ additions)
- `src/maxpat/critics/dsp_critic.py` -- `_TERMINAL_NAMES` and `_GAIN_NAMES` sets. plugout~ must be added to terminal names. gain~->plugout~ detection logic goes here or in m4l_critic.

### M4L Constants and Reference
- `src/maxpat/m4l_constants.py` -- ParamType, UnitStyle, ModMode, ParamVisibility enums, AMXD binary format constants (header structure, magic bytes, device type codes).
- `patches/kicksynth/generated/kicksynth.maxpat` -- Ground-truth M4L device structure for validation reference.

### Hooks and Validation Pipeline
- `src/maxpat/hooks.py` -- finalize_patch, write_gendsp, validate_file. write_amxd() is standalone (D-02) but should follow similar patterns for file write + git commit.
- `src/maxpat/validation.py` -- validate_patch(), has_blocking_errors(). M4L critic integrates at semantic level, not structural validation level.

### Layout (needs plugin~/plugout~ in IO names)
- `src/maxpat/layout.py` -- `_IO_OBJECT_NAMES` set needs plugin~/plugout~ added per SC#6.

### Requirements
- `.planning/REQUIREMENTS.md` -- VALID-01, VALID-02, VALID-03, EXPORT-01

</canonical_refs>

<code_context>
## Existing Code Insights

### Reusable Assets
- `CriticResult` class in base.py -- severity/finding/suggestion pattern used by all critics. M4L critic returns these directly.
- `_has_rnbo_boxes()` in __init__.py -- Auto-detection pattern. M4L equivalent checks for plugin~/plugout~/live.thisdevice.
- `m4l_constants.py` AMXD constants -- Binary header format fully defined (magic, version, device type bytes, patch section marker). write_amxd() uses these directly.
- `auto_commit_patch()` in project.py -- Git commit helper. write_amxd() should use this for auto-committing exported .amxd files.

### Established Patterns
- Critics return `list[CriticResult]` with severity levels, never block saves (D-01 reinforces this).
- Auto-detection in __init__.py: simple boolean check function, conditional critic invocation.
- hooks.py file write pattern: write content, fsync, auto-commit.
- Scaffold creates devices with known structure (project.py create_m4l_project) -- critic can validate against these expectations.

### Integration Points
- `review_patch()` in __init__.py -- M4L critic added here with auto-detection gate.
- `_TERMINAL_NAMES` in dsp_critic.py -- plugout~ added here for gain staging checks.
- `_IO_OBJECT_NAMES` in layout.py -- plugin~/plugout~ added here.
- New file: `src/maxpat/critics/m4l_critic.py` -- follows rnbo_critic.py structure.
- New file: `src/maxpat/m4l_export.py` -- standalone write_amxd() function.

</code_context>

<specifics>
## Specific Ideas

No specific requirements -- open to standard approaches

</specifics>

<deferred>
## Deferred Ideas

None -- discussion stayed within phase scope

</deferred>

---

*Phase: 22-validation-and-export*
*Context gathered: 2026-04-06*
