---
phase: 14-search-and-mutation-primitives
plan: 02
subsystem: api
tags: [patcher, mutation, crud, round-trip, bounds-checking]

# Dependency graph
requires:
  - phase: 14-search-and-mutation-primitives
    provides: find_box/find_boxes search methods, read_patch loading
provides:
  - remove_box() method with automatic patchline cleanup
  - remove_connection() method with identity-based matching
  - Bounds-checked add_connection() with clear error messages
  - Duplicate connection prevention (returns existing patchline)
  - Mutation-safe round-trip verified on project patches
affects: [15-incremental-mutations, 16-generate-integration]

# Tech tracking
tech-stack:
  added: []
  patterns: [mutation-with-cleanup, bounds-checking-before-create, duplicate-prevention-idempotent]

key-files:
  created: []
  modified:
    - src/maxpat/patcher.py
    - tests/test_patcher.py
    - tests/test_round_trip.py

key-decisions:
  - "Bounds checking is index-only (no signal type checking) per user decision in research phase"
  - "Duplicate prevention returns existing patchline object (idempotent) rather than raising"
  - "remove_box() builds new list via comprehension to avoid mutating during iteration"

patterns-established:
  - "Mutation methods raise ValueError on invalid input with descriptive messages including box ID and valid ranges"
  - "Idempotent add_connection: safe to call multiple times, returns existing on duplicate"

requirements-completed: [RW-03, RW-04, RW-05]

# Metrics
duration: 5min
completed: 2026-03-16
---

# Phase 14 Plan 02: Mutation Primitives Summary

**remove_box/remove_connection with bounds-checked add_connection and mutation-safe round-trip verification on loaded patches**

## Performance

- **Duration:** 5 min
- **Started:** 2026-03-16T16:25:11Z
- **Completed:** 2026-03-16T16:30:16Z
- **Tasks:** 3
- **Files modified:** 3

## Accomplishments
- Added remove_box() that removes box and all connected patchlines automatically
- Added remove_connection() for precise connection removal by identity fields
- Hardened add_connection() with outlet/inlet bounds checking and duplicate prevention
- Verified mutations on loaded project patches (kicksynth) preserve round-trip fidelity of untouched objects
- All 1014 tests pass (29 new tests added)

## Task Commits

Each task was committed atomically:

1. **Task 1: remove_box() and remove_connection() methods** - `b8a6de0` (feat)
2. **Task 2: Bounds checking and duplicate prevention in add_connection()** - `cf93d83` (feat)
3. **Task 3: Mutation-safe round-trip verification** - `c1fbe74` (test)

_All 3 tasks followed TDD: RED (failing tests) -> GREEN (implementation) -> verify_

## Files Created/Modified
- `src/maxpat/patcher.py` - Added remove_box(), remove_connection(), bounds checking, duplicate prevention
- `tests/test_patcher.py` - Added TestRemoveBox (6), TestRemoveConnection (4), TestAddConnectionBoundsCheck (10), TestDuplicateConnectionPrevention (3) test classes
- `tests/test_round_trip.py` - Added TestMutationPreservesRoundTrip (5) integration tests

## Decisions Made
- Bounds checking is index-only (no signal type checking) -- per user decision in research phase
- Duplicate prevention returns existing patchline object (idempotent) rather than raising an error
- remove_box() builds new list via comprehension to avoid mutating list during iteration

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] Fixed test_add_connection_preserves_existing_lines using wrong box pair**
- **Found during:** Task 3 (mutation round-trip tests)
- **Issue:** Test used obj-10 (panel) as source, but panel has 0 outlets -- bounds checking correctly rejected it
- **Fix:** Changed to obj-12 (button, 1 outlet) and obj-15 (stripnote, 2 inlets) which are valid and unconnected
- **Files modified:** tests/test_round_trip.py
- **Verification:** All mutation tests pass
- **Committed in:** c1fbe74 (Task 3 commit)

---

**Total deviations:** 1 auto-fixed (1 bug in test setup)
**Impact on plan:** Test setup fix only -- no scope creep, no code changes.

## Issues Encountered
None

## User Setup Required
None - no external service configuration required.

## Next Phase Readiness
- CRUD operations complete: add_box, add_connection, remove_box, remove_connection all working with validation
- Search primitives ready: find_box, find_boxes with alias resolution
- Round-trip fidelity proven through mutations on loaded patches
- Phase 14 complete -- ready for Phase 15 (incremental mutations / generate.py integration)

---
*Phase: 14-search-and-mutation-primitives*
*Completed: 2026-03-16*
