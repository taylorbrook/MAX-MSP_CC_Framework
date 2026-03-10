---
phase: 02-patch-generation-and-validation
plan: 02
subsystem: layout
tags: [topological-sort, kahn-algorithm, column-layout, spacing, presentation-mode]

# Dependency graph
requires:
  - phase: 02-01
    provides: "Patcher/Box/Patchline data model, sizing, defaults (V_SPACING, H_GUTTER)"
provides:
  - "apply_layout() function that positions all boxes in a Patcher via topological sort"
  - "Column-based layout with dynamic widths and configurable spacing"
  - "UI control positioning above targets"
  - "Presentation mode grid layout for UI objects"
affects: [02-03, 02-04]

# Tech tracking
tech-stack:
  added: []
  patterns: ["Kahn's algorithm for topological column assignment", "UI control extraction and repositioning above targets", "Presentation grid layout for UI objects"]

key-files:
  created:
    - src/maxpat/layout.py
  modified:
    - tests/test_layout.py

key-decisions:
  - "Disconnected nodes (no connections at all) separated from source nodes in topological sort -- placed in final column"
  - "UI controls removed from column assignment then repositioned above their first connected target"
  - "Presentation layout uses 4-per-row grid with 60px horizontal and 40px vertical spacing"

patterns-established:
  - "Layout mutates Box.patching_rect in-place rather than returning new positions"
  - "Graph built from Patchline objects with deduplication of edges"

requirements-completed: [PAT-06, PAT-07]

# Metrics
duration: 1min
completed: 2026-03-10
---

# Phase 2 Plan 02: Layout Engine Summary

**Column-based layout engine using Kahn's topological sort with dynamic column widths, UI control positioning, and presentation mode grid**

## Performance

- **Duration:** 1 min
- **Started:** 2026-03-10T00:03:18Z
- **Completed:** 2026-03-10T00:04:46Z
- **Tasks:** 1 (TDD: RED -> GREEN)
- **Files modified:** 2

## Accomplishments
- Kahn's algorithm assigns boxes to columns by signal flow depth (source -> processing -> output)
- Dynamic column widths based on widest object in each column with H_GUTTER (70px) spacing
- V_SPACING (100px) vertical gap between objects within columns
- Disconnected nodes correctly placed in a final column at the rightmost position
- UI control objects (toggle, slider, dial, number, flonum) repositioned above their targets
- Presentation mode grid layout for boxes with presentation=True
- Edge cases handled: empty patcher (no-op), single box, fan-out, diamond convergence

## Task Commits

Each task was committed atomically:

1. **Task 1 RED: Failing tests for layout engine** - `e34f175` (test)
2. **Task 1 GREEN: Layout engine implementation** - `8a3c994` (feat)

_TDD task: test commit followed by implementation commit_

## Files Created/Modified
- `src/maxpat/layout.py` - Column-based layout engine with apply_layout() entry point, topological sort, UI control positioning, presentation layout
- `tests/test_layout.py` - 14 tests covering column assignment, spacing, fan-out, diamond, disconnected nodes, UI positioning, presentation mode, complex graphs

## Decisions Made
- Disconnected nodes (zero incoming AND zero outgoing connections) are separated from source nodes (zero incoming but has outgoing) during topological sort. Source nodes go in column 0; disconnected nodes go in a final column. This prevents unrelated objects from mixing with the signal chain source.
- UI controls are extracted from their topological column and repositioned above their first connected target (same x, y = target_y - ui_height - V_SPACING/2). This matches the CLAUDE.md convention that UI controls sit above the objects they control.
- Presentation mode uses a 4-per-row grid starting at (20, 20) with 60px horizontal and 40px vertical spacing between items.

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] Fixed dynamic column width test using non-UI objects**
- **Found during:** Task 1 GREEN (test verification)
- **Issue:** The test_dynamic_column_width test used a toggle (UI control) as the "narrow" object in column 0, but the layout engine correctly repositions UI controls above their targets (moving them out of column 0). This caused the test to measure the wrong x-position.
- **Fix:** Changed the test to use `*~ 0.1` (non-UI object) as the narrow object so both objects stay in column 0 and the dynamic width calculation can be properly verified.
- **Files modified:** tests/test_layout.py
- **Verification:** All 14 tests pass
- **Committed in:** 8a3c994 (part of GREEN commit)

---

**Total deviations:** 1 auto-fixed (1 bug in test logic)
**Impact on plan:** Test refinement only. No scope creep. Implementation matches plan specification.

## Issues Encountered
None

## User Setup Required
None - no external service configuration required.

## Next Phase Readiness
- Layout engine ready for integration with validation pipeline (Plan 02-03)
- apply_layout() can be called on any Patcher instance after boxes and connections are added
- Plan 02-04 (public API) will wire layout into the generation pipeline

---
*Phase: 02-patch-generation-and-validation*
*Completed: 2026-03-10*
