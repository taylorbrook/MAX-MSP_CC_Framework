# Phase 24: Layout - Context

**Gathered:** 2026-04-06
**Status:** Ready for planning

<domain>
## Phase Boundary

M4L presentation layout engine positions controls intelligently within Ableton's 169px device height constraint. Replaces the crude grid fallback in `_apply_presentation_layout()` with device-aware layout that groups controls by function, supports tabbed and overlay patterns, and enforces whole-pixel coordinates. Covers LAYOUT-01, LAYOUT-02, LAYOUT-03.

</domain>

<decisions>
## Implementation Decisions

### Control Grouping
- **D-01:** Reuse Phase 23's Push bank semantic clustering logic (varname prefix/keyword analysis) as the grouping source. Single source of truth for both Push banks and visual layout.
- **D-02:** Each group gets a live.comment header label above it (e.g., "Filter", "Amp"). Standard M4L convention, costs ~18px height per group.
- **D-03:** Groups flow left-to-right as vertical columns within the device. Each group is a column: label on top, controls stacked below. Device widens if needed to fit all groups.

### Layout Patterns
- **D-04:** ~~UNLOCKED~~ Tabbed layout uses live.tab + script hide/show pattern. live.tab at top outputs tab index, wired through thispatcher to script show/hide individual controls by varname. Simpler than bpatcher swap, avoids subpatcher complexity.
- **D-05:** Tab trigger threshold: >8 controls per group, or total controls exceed what fits in devicewidth at 169px height. Auto-selected based on control count and device complexity.
- **D-06:** Overlay pattern covers two cases: (a) readout overlays — flonum/live.numbox overlaid on live.dial with ignoreclick=1, and (b) popup panels — hidden panels that slide over device for advanced settings (Show/Hide button pattern).

### Spacing & Sizing
- **D-07:** Vertical allocation: ~18px for live.comment group label, ~4px gap, remaining height for controls. Two rows possible for smaller controls (live.numbox at 15px, live.toggle at 15px).
- **D-08:** Control sizes use exact dimensions from sizing.py. live.dial is always 44x66, live.slider always 39x87, etc. No scaling.
- **D-09:** Horizontal spacing between controls: tight 4-6px gap, matching Ableton stock devices.
- **D-10:** All presentation coordinates enforced as whole pixels (int() or round()). No fractional values causing blurry rendering.

### Device Width
- **D-11:** Auto-fit devicewidth starting at 300px default. Expands if controls don't fit. Ableton supports up to ~900px device width. Ensures nothing is clipped.

### Module Structure
- **D-12:** New standalone module `src/maxpat/m4l_layout.py` with `layout_m4l_presentation(patch_dict)` function. Keeps layout.py focused on patching mode layout. Follows m4l_export.py and m4l_polish.py pattern.
- **D-13:** Pipeline order: agents build -> polish -> layout -> export. Layout reads polished parameter metadata to inform grouping. Explicit call by agents, not auto-triggered.
- **D-14:** Layout engine preserves manually-set presentation_rect values. If a control already has presentation_rect, layout leaves it alone. Only positions controls without presentation_rect.

### Claude's Discretion
- Internal algorithm for packing controls into columns within 169px
- Exact threshold constants for tab vs single-page decision
- Popup panel implementation details (show/hide scripting, panel sizing)
- How live.tab + bpatcher structure is generated (subpatcher creation, tab wiring)
- Group ordering heuristic (which group goes leftmost)

</decisions>

<canonical_refs>
## Canonical References

**Downstream agents MUST read these before planning or implementing.**

### Layout Engine
- `src/maxpat/layout.py` -- Existing `_apply_presentation_layout()` at line 1057 (crude grid fallback to be replaced). `_IO_OBJECT_NAMES` includes plugin~/plugout~. `_UI_CONTROL_NAMES` lists live.* controls.
- `src/maxpat/sizing.py` -- All live.* control dimensions (live.dial: 44x66, live.slider: 39x87, live.numbox: 56x15, etc.). Source of truth for control sizes.

### M4L Pipeline (upstream)
- `src/maxpat/m4l_polish.py` -- Semantic parameter grouping logic for Push banks. Layout reuses this grouping (D-01).
- `src/maxpat/m4l_constants.py` -- ParamType, UnitStyle, device type constants.
- `src/maxpat/m4l_export.py` -- Standalone module pattern to follow. Called after layout in pipeline.
- `src/maxpat/project.py` -- `create_m4l_project()` sets devicewidth=300 and openinpresentation=1.

### M4L Critic
- `src/maxpat/critics/m4l_critic.py` -- Validates device structure. Layout should produce valid devices.

### Patcher API
- `src/maxpat/patcher.py` -- Box.presentation, Box.presentation_rect, Patcher.props for devicewidth/openinpresentation.

### Requirements
- `.planning/REQUIREMENTS.md` -- LAYOUT-01, LAYOUT-02, LAYOUT-03

</canonical_refs>

<code_context>
## Existing Code Insights

### Reusable Assets
- `m4l_polish.py` semantic grouping -- Groups parameters by function (filter, amp, pitch, etc.) using varname/keyword analysis. Layout reuses same groups (D-01).
- `sizing.py` `_DEFAULT_SIZES` dict -- All live.* control dimensions. Layout reads these for exact positioning.
- `_apply_presentation_layout()` in layout.py -- Crude grid fallback. Can be updated to delegate to m4l_layout.py for M4L devices.
- `bring_to_front()` / `set_z_index()` in patcher.py -- Already supports overlay readout pattern (D-06a).
- `add_subpatcher()` in patcher.py -- Creates bpatchers for tabbed layout (D-04).

### Established Patterns
- Standalone M4L module pattern: m4l_export.py, m4l_polish.py are standalone functions called explicitly. m4l_layout.py follows same pattern.
- Presentation mode flags: scaffold sets openinpresentation=1, presentation=True on controls. Layout sets presentation_rect.
- `auto_commit_patch()` for git commits after file changes.

### Integration Points
- `_apply_presentation_layout()` in layout.py -- Could delegate to m4l_layout.py when M4L device detected, or remain separate.
- Agent SKILL.md files (max-ui-agent) -- Need updated instructions to call layout after polish.
- `m4l_polish.py` -- Layout reads its output (parameter groups) for control grouping.

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

*Phase: 24-layout*
*Context gathered: 2026-04-06*
