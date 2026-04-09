---
phase: 15-intelligent-editing
plan: 01
subsystem: api
tags: [patcher, mutation, dataclass, variable-io, round-trip]

# Dependency graph
requires:
  - phase: 14-search-and-mutation-primitives
    provides: "add_box, remove_box, add_connection, remove_connection, find_box/find_boxes with bounds checking"
  - phase: 13-round-trip
    provides: "Dual-path serialization (_raw round-trip vs creation path), Box._raw preservation"
provides:
  - "EditResult dataclass for orphaned connection tracking across all mutation methods"
  - "modify_box() for in-place attribute editing with I/O recomputation"
  - "replace_box() for object swapping with orphaned connection return"
affects: [15-02-PLAN, 15-03-PLAN, 16-patch-analysis]

# Tech tracking
tech-stack:
  added: []
  patterns: ["EditResult return pattern for mutation methods", "orphaned connection tracking via dict list"]

key-files:
  created: []
  modified:
    - "src/maxpat/patcher.py"
    - "src/maxpat/__init__.py"
    - "tests/test_patcher.py"
    - "tests/test_round_trip.py"

key-decisions:
  - "EditResult uses dataclass with default_factory for orphaned list, not namedtuple"
  - "modify_box syncs _raw dict in-place for all changed fields (text, numinlets, numoutlets, outlettype, patching_rect, bgcolor, extra_attrs)"
  - "replace_box captures orphaned connections before remove_box call to avoid losing connection info"

patterns-established:
  - "EditResult return pattern: all mutation methods that can orphan connections return EditResult(box, orphaned)"
  - "Orphaned connection format: list of dicts with source_id, source_outlet, dest_id, dest_inlet"
  - "_raw sync pattern: modify_box always updates box._raw when not None for round-trip fidelity"

requirements-completed: [ED-01, ED-03]

# Metrics
duration: 5min
completed: 2026-03-16
---

# Phase 15 Plan 01: EditResult, modify_box, and replace_box Summary

**EditResult dataclass with modify_box (in-place args/position/color editing with I/O recompute and orphan tracking) and replace_box (object swap returning all connections as orphaned)**

## Performance

- **Duration:** 5 min
- **Started:** 2026-03-16T17:57:44Z
- **Completed:** 2026-03-16T18:02:31Z
- **Tasks:** 3 (Task 0 + 2 TDD tasks)
- **Files modified:** 4

## Accomplishments
- EditResult dataclass established as the standard return type for mutation operations
- modify_box changes args (with I/O recomputation via db.compute_io_counts), position, color, extra_attrs in-place with _raw sync
- modify_box auto-removes orphaned connections when I/O count shrinks and returns them in EditResult
- replace_box creates new box at old position, removes old box, returns ALL old connections as orphaned (no auto-remap)
- 21 new tests (11 modify, 3 round-trip, 7 replace) all green with 0 regressions

## Task Commits

Each task was committed atomically:

1. **Task 0: Create test class shells** - `556ce32` (chore)
2. **Task 1 RED: Failing tests for modify_box** - `01b0f4e` (test)
3. **Task 1 GREEN: EditResult + modify_box implementation** - `c8fb93a` (feat)
4. **Task 2 RED: Failing tests for replace_box** - `3bbea20` (test)
5. **Task 2 GREEN: replace_box implementation** - `5dd38cb` (feat)

## Files Created/Modified
- `src/maxpat/patcher.py` - Added EditResult dataclass, modify_box() and replace_box() methods on Patcher
- `src/maxpat/__init__.py` - Exported EditResult in public API
- `tests/test_patcher.py` - Added 8 Phase 15 test class shells + TestModifyBox (11 tests) + TestReplaceBox (7 tests)
- `tests/test_round_trip.py` - Added TestModifyPreservesRoundTrip (3 tests)

## Decisions Made
- EditResult uses `@dataclass` with `field(default_factory=list)` for the orphaned list -- cleaner than namedtuple, supports default values
- modify_box syncs _raw["text"] explicitly because Box.to_dict() round-trip path does not overlay text (per Pitfall 1 from RESEARCH.md)
- replace_box captures orphaned connections before calling remove_box to avoid losing connection info (remove_box filters lines by list comprehension)
- color parameter in modify_box sets extra_attrs["bgcolor"] and syncs box._raw["bgcolor"] directly

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered
None.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness
- EditResult pattern established for use by Plan 15-02 (insert_into_connection) and Plan 15-03 (graph queries, auto-positioning)
- Test class shells for all remaining Phase 15 features are in place
- 168 total tests passing, zero regressions

## Self-Check: PASSED

- All 5 source/test files exist
- All 5 task commits verified in git log
- EditResult imports successfully
- modify_box and replace_box methods exist on Patcher

---
*Phase: 15-intelligent-editing*
*Completed: 2026-03-16*
