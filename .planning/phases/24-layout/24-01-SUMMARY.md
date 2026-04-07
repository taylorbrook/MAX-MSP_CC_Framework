---
phase: 24-layout
plan: 01
subsystem: layout
tags: [m4l, presentation, column-packing, live-controls, ableton]

# Dependency graph
requires:
  - phase: 23-m4l-polish
    provides: _classify_parameter, _collect_live_controls semantic grouping
provides:
  - layout_m4l_presentation() column-packing layout engine
  - GROUP_PRIORITY signal flow ordering constants
  - _get_control_size, _set_pres_rect, _add_group_label helpers
affects: [24-layout plan-02, 24-layout plan-03, max-ui-agent]

# Tech tracking
tech-stack:
  added: []
  patterns: [column-packing layout, presentation_rect integer enforcement, tall-control label skip]

key-files:
  created:
    - src/maxpat/m4l_layout.py
    - tests/test_m4l_layout.py
  modified: []

key-decisions:
  - "GROUP_H_GAP=10px between columns, CONTROL_V_GAP=4px between stacked controls"
  - "Tall controls (>=100px) skip group label to fit 169px height budget"
  - "Label width minimum 44px, matches narrowest common control (live.dial)"
  - "textjustification=1 (center) on group labels for clean visual alignment"

patterns-established:
  - "Column-packing: groups sorted by GROUP_PRIORITY, laid out left-to-right"
  - "Presentation integer enforcement: all _set_pres_rect values passed through int()"
  - "Preserve-existing: controls with presentation_rect skip layout entirely"

requirements-completed: [LAYOUT-01, LAYOUT-03]

# Metrics
duration: 3min
completed: 2026-04-07
---

# Phase 24 Plan 01: M4L Layout Engine Summary

**Column-packing layout engine groups live.* controls by semantic function into vertical columns within Ableton's 169px device height, with integer-only coordinates and auto-expanding device width**

## Performance

- **Duration:** 3 min
- **Started:** 2026-04-07T14:24:08Z
- **Completed:** 2026-04-07T14:27:36Z
- **Tasks:** 1
- **Files created:** 2

## Accomplishments
- TDD implementation of layout_m4l_presentation() with 23 tests covering grouping, packing, sizing, width expansion, integer enforcement, and tall-control handling
- Semantic grouping reuses _classify_parameter from m4l_polish.py for single source of truth (D-01)
- Signal flow ordering: Pitch > Filter > Amp > Envelope > Mod > FX > Noise > Mix > Main
- Controls with existing presentation_rect are preserved untouched (D-14)

## Task Commits

Each task was committed atomically:

1. **Task 1 (TDD): Core layout engine** 
   - RED: `dbfc756` (test) - 23 failing tests across 7 test classes
   - GREEN: `9701b1f` (feat) - Full implementation passing all tests
   - REFACTOR: `d95c88d` (refactor) - Remove unused module-level counter

## Files Created/Modified
- `src/maxpat/m4l_layout.py` - M4L presentation layout engine with column-packing algorithm
- `tests/test_m4l_layout.py` - 23 tests: basics, grouping, column packing, device width, whole pixels, preserve existing, special cases

## Decisions Made
- GROUP_H_GAP set to 10px between group columns (wider than the 4-6px D-09 intra-group gap, providing visual separation between semantic groups)
- TALL_CONTROL_THRESHOLD at 100px -- live.gain~ (136px) and live.scope~ (131px) skip labels to fit 169px budget
- Default control fallback size (100, 22) for unknown maxclass types
- Label minimum width 44px to match live.dial width (narrowest common control)

## Deviations from Plan

None -- plan executed exactly as written.

## Issues Encountered

- Worktree base mismatch: worktree HEAD (f9b9e5f) did not contain m4l_polish.py, m4l_constants.py, m4l_critic.py, or m4l_export.py (they exist on the planning branch at 9b9fd76). Resolved by checking out prerequisite files from 9b9fd76 into the worktree.
- Pre-existing test failures in test_hooks.py (validate_patch keyword arg) and test_inlet_types.py (MSP signal I/O exceptions) -- both unrelated to layout changes, not addressed.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness
- layout_m4l_presentation() ready for Plan 02 (tabbed layout) to extend with tab overflow detection
- GROUP_PRIORITY and _group_controls available for Plan 02/03 to reuse
- Test helpers (_make_live_control, _make_m4l_patch) established for future layout tests

---
*Phase: 24-layout*
*Completed: 2026-04-07*
