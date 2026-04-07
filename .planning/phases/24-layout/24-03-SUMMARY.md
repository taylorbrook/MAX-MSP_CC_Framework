---
phase: 24-layout
plan: 03
subsystem: layout
tags: [m4l, presentation, overlay, readout, popup-panel, z-order, live-controls]

# Dependency graph
requires:
  - phase: 24-layout plan-01
    provides: _set_pres_rect, _get_control_size, LAYOUT_VARNAME_PREFIX, UI_SIZES
provides:
  - add_readout_overlay() live.numbox overlay on dial/slider
  - create_popup_panel() hidden panel with toggle button
affects: [max-ui-agent, m4l-device-building]

# Tech tracking
tech-stack:
  added: []
  patterns: [overlay readout z-order pattern, hidden popup panel with scripting name]

key-files:
  created: []
  modified:
    - src/maxpat/m4l_layout.py
    - tests/test_m4l_layout.py

key-decisions:
  - "Readout height from UI_SIZES['live.numbox'] constant (15px), not hardcoded"
  - "Global _readout_counter for auto-generated unique IDs"
  - "Panel varname format: _layout_panel_{name} for scripting via thispatcher"
  - "Default button position: device_width - 50, top-right corner"

patterns-established:
  - "Overlay readout: insert at index 0 for z-order, ignoreclick=1, width matches control"
  - "Popup panel: hidden=1 panel + live.text toggle with mode=1 and parameter_enable=1"

requirements-completed: [LAYOUT-02]

# Metrics
duration: 4min
completed: 2026-04-07
---

# Phase 24 Plan 03: Overlay Layout Patterns Summary

**Readout overlay places live.numbox on dials/sliders with ignoreclick and z-order, popup panel creates hidden panel with live.text toggle button and scripting name**

## Performance

- **Duration:** 4 min
- **Started:** 2026-04-07T14:39:45Z
- **Completed:** 2026-04-07T14:44:19Z
- **Tasks:** 1
- **Files modified:** 2

## Accomplishments
- TDD implementation of add_readout_overlay() with 12 tests covering z-order, ignoreclick, dimension matching, positioning at bottom of control
- TDD implementation of create_popup_panel() with 11 tests covering hidden panel, toggle button mode, scripting name, coordinate enforcement
- Readout width matches control width (not default live.numbox 56px), positioned at control bottom
- All coordinates enforced as whole integers via int() casting

## Task Commits

Each task was committed atomically:

1. **Task 1 (TDD): Overlay patterns**
   - RED: `388b004` (test) - 23 failing tests across TestReadoutOverlay and TestPopupPanel
   - GREEN: `cd108d1` (feat) - Full implementation passing all 68 tests

## Files Created/Modified
- `src/maxpat/m4l_layout.py` - Added add_readout_overlay() and create_popup_panel() utility functions
- `tests/test_m4l_layout.py` - Added TestReadoutOverlay (12 tests) and TestPopupPanel (11 tests)

## Decisions Made
- Readout height derived from UI_SIZES["live.numbox"][1] constant rather than hardcoded 15 -- stays in sync if sizing changes
- Auto-generated readout IDs use global counter with "obj-layout-readout-" prefix
- Panel varname format uses lowercase panel name: `_layout_panel_{name.lower()}`
- Default toggle button positioned at top-right: (device_width - 50, 4, 44, 15)
- No refactor commit needed -- implementation was clean on first pass

## Deviations from Plan

None -- plan executed exactly as written.

## Issues Encountered

None.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness
- Phase 24 layout engine complete: single-page (Plan 01), tabbed (Plan 02), overlays (Plan 03)
- add_readout_overlay and create_popup_panel available as utility functions for agents building M4L devices
- Full test suite at 68 layout tests, all passing

## Self-Check: PASSED

---
*Phase: 24-layout*
*Completed: 2026-04-07*
