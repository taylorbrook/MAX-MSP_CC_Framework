---
phase: 15-intelligent-editing
plan: 02
subsystem: api
tags: [patcher, mutation, auto-position, collision-detection, grid-snap, insert]

# Dependency graph
requires:
  - phase: 15-01
    provides: "EditResult dataclass, modify_box, replace_box, add_box/remove_box/add_connection/remove_connection primitives"
provides:
  - "_find_clear_position() collision-avoiding position finder with 15px grid snap"
  - "_auto_position() smart placement below near_box or at patcher center"
  - "insert_into_connection() atomic connection splice operation"
  - "COLLISION_PAD constant (5px) for readability spacing"
affects: [15-03-PLAN, 16-patch-analysis]

# Tech tracking
tech-stack:
  added: []
  patterns: ["collision detection with COLLISION_PAD padding", "insert_into_connection uses capacity-based I/O mismatch handling"]

key-files:
  created: []
  modified:
    - "src/maxpat/patcher.py"
    - "tests/test_patcher.py"

key-decisions:
  - "COLLISION_PAD = 5.0 added around all boxes for collision detection readability"
  - "_find_clear_position nudges right by 15px on collision, wraps to next row when x > 1200"
  - "insert_into_connection uses capacity = min(numinlets, numoutlets) to determine how many connections fit"
  - "I/O mismatch returns orphaned connections in EditResult (not ValueError) per CONTEXT.md locked decision"

patterns-established:
  - "Auto-positioning pattern: _auto_position(box, near_box) composes _find_clear_position with grid snap"
  - "Insert splice pattern: remove old connections, wire through new box, orphan excess via capacity check"

requirements-completed: [ED-02, ED-05]

# Metrics
duration: 5min
completed: 2026-03-16
---

# Phase 15 Plan 02: Auto-positioning and insert_into_connection Summary

**Auto-positioning with 15px grid snap, collision detection (5px padding), and insert_into_connection splice that wires through one shared box with capacity-based orphan handling**

## Performance

- **Duration:** 5 min
- **Started:** 2026-03-16T18:06:00Z
- **Completed:** 2026-03-16T18:11:33Z
- **Tasks:** 2 (both TDD: RED + GREEN)
- **Files modified:** 2

## Accomplishments
- _find_clear_position() finds non-overlapping positions with 15px grid snap, rightward nudge on collision, row wrap at x>1200
- _auto_position() places boxes below a reference box (with V_SPACING gap) or at patcher center when no reference
- insert_into_connection() splices a new box into ALL connections between source and dest, with one shared inserted object
- I/O capacity check: wires as many connections as min(numinlets, numoutlets) allows; excess returned as orphaned in EditResult
- 17 new tests (8 auto-position + 9 insert) all green with 0 regressions (185 total)

## Task Commits

Each task was committed atomically:

1. **Task 1 RED: Failing auto-position tests** - `d079211` (test)
2. **Task 1 GREEN: Auto-positioning implementation** - `99720fc` (feat)
3. **Task 2 RED: Failing insert_into_connection tests** - `a3fed34` (test)
4. **Task 2 GREEN: insert_into_connection implementation** - `ce8bed3` (feat)

## Files Created/Modified
- `src/maxpat/patcher.py` - Added COLLISION_PAD constant, _find_clear_position(), _auto_position(), insert_into_connection() methods
- `tests/test_patcher.py` - Added TestAutoPosition (8 tests) and TestInsertIntoConnection (9 tests)

## Decisions Made
- COLLISION_PAD = 5.0px around all boxes provides readable spacing without excessive gaps
- _find_clear_position uses 50-attempt limit to prevent infinite loops in dense patchers
- insert_into_connection uses `capacity = min(numinlets, numoutlets)` to determine how many connections the new box can handle
- Orphaned connections returned in EditResult for caller to decide (per CONTEXT.md: "report mismatch, let caller decide")
- V_SPACING imported from defaults module (V_SPACING = 20) for auto-positioning gap

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] Fixed invalid object names in tests**
- **Found during:** Task 1 GREEN (auto-positioning)
- **Issue:** Tests used "bang" which is not a valid MAX object name (it's a message, not an object)
- **Fix:** Changed to "button" (the actual UI object) and other valid objects
- **Files modified:** tests/test_patcher.py
- **Verification:** All tests pass with valid object names

**2. [Rule 1 - Bug] Fixed stereo test I/O assumptions**
- **Found during:** Task 2 GREEN (insert_into_connection)
- **Issue:** Stereo test used `*~` (2 in, 1 out) which can't handle 2 outlet-to-inlet connections; I/O mismatch test used `unpack` dest which has 1 inlet not 2
- **Fix:** Used `swap` (2 in, 2 out) for stereo test; used `trigger b b` -> `pack 0 0` for I/O mismatch test
- **Files modified:** tests/test_patcher.py
- **Verification:** All 9 insert_into_connection tests pass

---

**Total deviations:** 2 auto-fixed (2 bugs in test setup)
**Impact on plan:** Test corrections only -- all test logic and assertions match plan intent. No scope creep.

## Issues Encountered
None beyond the test fixture corrections noted above.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness
- Auto-positioning and insert_into_connection ready for Plan 15-03 (graph queries)
- All Phase 15 editing primitives (modify, replace, insert, auto-position) now available
- 185 total tests passing, zero regressions

## Self-Check: PASSED

- All 2 source/test files exist and were modified
- All 4 task commits verified in git log
- _find_clear_position, _auto_position, insert_into_connection methods exist on Patcher
- COLLISION_PAD constant present in patcher.py

---
*Phase: 15-intelligent-editing*
*Completed: 2026-03-16*
