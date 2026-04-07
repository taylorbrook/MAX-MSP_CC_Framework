---
phase: 24-layout
plan: 02
subsystem: layout
tags: [m4l, tabbed-layout, live-tab, script-hide-show, thispatcher, presentation]

# Dependency graph
requires:
  - phase: 24-layout-01
    provides: layout_m4l_presentation(), _group_controls(), GROUP_PRIORITY, column-packing engine
provides:
  - _select_layout_pattern() threshold detection (single vs tabbed)
  - _apply_tabbed_layout() with live.tab + script hide/show wiring
  - _create_tab_box() live.tab with parameter_enable and ENUM type
  - _create_tab_wiring() full patching-mode wiring chain
affects: [24-layout plan-03, max-ui-agent]

# Tech tracking
tech-stack:
  added: []
  patterns: [tabbed-layout via live.tab + thispatcher, script hide/show per varname, _layout_ prefix for scripting names]

key-files:
  created: []
  modified:
    - src/maxpat/m4l_layout.py
    - tests/test_m4l_layout.py

key-decisions:
  - "TAB_CONTROL_THRESHOLD=8 controls, TAB_GROUP_THRESHOLD=3 groups trigger tabbed mode"
  - "Each group becomes a tab page; controls positioned as column below live.tab"
  - "live.gain~/live.scope~ always on first page, never hidden (Pitfall 1)"
  - "Controls without varname get _layout_ prefix to avoid collision with parameter scripting names (Pitfall 3)"
  - "Wiring chain: live.tab -> select N -> message (script show/hide) -> thispatcher"

patterns-established:
  - "Tabbed layout: groups sorted by GROUP_PRIORITY become tab pages"
  - "Script hide/show on individual controls by varname (D-04 unlocked approach)"
  - "First page visible (hidden=0), other pages hidden (hidden=1)"

requirements-completed: [LAYOUT-02]

# Metrics
duration: 6min
completed: 2026-04-07
---

# Phase 24 Plan 02: Tabbed Layout Pattern Summary

**TDD tabbed layout with live.tab auto-detection, script hide/show wiring via thispatcher, and per-control visibility management by varname**

## Performance

- **Duration:** 6 min
- **Started:** 2026-04-07T14:30:47Z
- **Completed:** 2026-04-07T14:37:09Z
- **Tasks:** 1
- **Files modified:** 2

## Accomplishments
- TDD implementation of tabbed layout pattern with 22 new tests (45 total, up from 23)
- Auto-detection: >8 controls or >3 groups triggers tabbed mode
- live.tab created with livemode=1, parameter_enable=1, parameter_type=2 (ENUM), group names as tab labels
- Full wiring chain generated: live.tab -> select -> message boxes (script show/hide) -> thispatcher
- Per-control visibility: first page hidden=0, other pages hidden=1
- live.gain~/live.scope~ special-cased to always appear on first page (Pitfall 1)
- Varname assignment with _layout_ prefix for controls lacking one (Pitfall 3)

## Task Commits

Each task was committed atomically:

1. **Task 1 (TDD): Tabbed layout -- threshold detection, live.tab creation, script hide/show wiring**
   - RED: `9faae18` (test) - 22 new failing tests across 4 test classes
   - GREEN: `4fd7ca9` (feat) - Full tabbed layout implementation, all 45 tests pass
   - REFACTOR: `1e165d9` (refactor) - Clean up stale comments

## Files Created/Modified
- `src/maxpat/m4l_layout.py` - Added _select_layout_pattern, _apply_tabbed_layout, _create_tab_box, _create_tab_wiring, _ensure_varname, plus TAB_* constants
- `tests/test_m4l_layout.py` - Added TestLayoutPatternSelection, TestTabbedLayout, TestTabWiring, TestTabSpecialCases (22 new tests)

## Decisions Made
- TAB_CONTROL_THRESHOLD=8: more than 8 controls triggers tabbed (D-05 boundary)
- TAB_GROUP_THRESHOLD=3: more than 3 groups triggers tabbed (research recommendation)
- Each group becomes one tab page, laid out as a single column below the tab
- live.tab spans full device width minus margins
- Existing test_auto_expands_when_needed updated: 12-control/6-group patch now correctly routes to tabbed mode, so the test was changed to use 6 wide controls in 3 groups to test single-page width expansion

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] Updated existing test for tabbed threshold interaction**
- **Found during:** GREEN phase
- **Issue:** Existing test_auto_expands_when_needed used 12 controls across 6 groups, which now correctly triggers tabbed layout instead of single-page, causing the width expansion assertion to fail
- **Fix:** Changed test to use 6 live.menu controls (100px wide each) in 3 groups, which stays within single-page threshold while still requiring width expansion beyond 300px
- **Files modified:** tests/test_m4l_layout.py
- **Commit:** 4fd7ca9

## Issues Encountered

None beyond the test adjustment noted above.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness
- Tabbed layout fully functional for Plan 03 (overlay patterns) to build upon
- _select_layout_pattern can be extended with additional pattern types (e.g., "overlay")
- All constants and helpers exported for downstream use

---
*Phase: 24-layout*
*Completed: 2026-04-07*
