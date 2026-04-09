---
phase: 13-round-trip-foundation
plan: 01
subsystem: testing
tags: [round-trip, patchline, maxpat, pytest, TDD]

# Dependency graph
requires: []
provides:
  - "Round-trip test suite with 31 tests covering RW-01, RW-02, RW-06"
  - "Colored patchline fixture for color/extra_attrs testing"
  - "Patchline class with color, extra_attrs, _raw for lossless round-trip"
  - "Structural validation in from_dict (ValueError/TypeError on invalid input)"
  - "Patcher key-order preservation via boxes/lines placeholders in props"
affects: [13-02-PLAN, 13-03-PLAN]

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "Dual-path to_dict: _raw-based round-trip path vs scratch creation path"
    - "_handled_line_keys set pattern for patchline extra_attrs extraction"
    - "Props key-order preservation via placeholder entries for boxes/lines"

key-files:
  created:
    - tests/test_round_trip.py
    - tests/fixtures/colored_patchlines.maxpat
  modified:
    - src/maxpat/patcher.py
    - tests/test_patcher.py

key-decisions:
  - "Patchline uses dual-path to_dict: _raw round-trip path preserves all original data; creation path builds from scratch"
  - "Order=0 omitted in creation path to match MAX output format"
  - "Patcher key ordering preserved by storing boxes/lines placeholders in props dict during from_dict"

patterns-established:
  - "Dual-path serialization: _raw-based round-trip vs scratch creation -- will extend to Box in Plan 02"
  - "xfail parametrized tests: round-trip identity tests xfail until fixed, auto-pass when code improves"
  - "_handled_keys pattern on patchlines mirrors existing Box pattern for extra_attrs"

requirements-completed: [RW-06]

# Metrics
duration: 5min
completed: 2026-03-16
---

# Phase 13 Plan 01: Round-Trip Test Suite and Patchline Fix Summary

**31-test round-trip suite with TDD fixtures, plus Patchline color/extra_attrs/raw preservation and structural validation in from_dict**

## Performance

- **Duration:** 5 min
- **Started:** 2026-03-16T14:25:55Z
- **Completed:** 2026-03-16T14:31:15Z
- **Tasks:** 2
- **Files modified:** 4

## Accomplishments
- Created comprehensive round-trip test suite with 31 tests across 10 test classes covering RW-01, RW-02, RW-06
- Fixed Patchline class to preserve color, extra_attrs, and raw dict through round-trip (verified bug fix for RW-06)
- Added structural validation in from_dict: fail-fast on missing patcher key and non-list boxes
- Preserved patcher-level key ordering (boxes/lines stay at original position)
- Eliminated spurious "order": 0 emission in creation path (matches MAX output)

## Task Commits

Each task was committed atomically:

1. **Task 1: Create round-trip test suite and fixtures** - `6f503f2` (test) -- TDD RED phase
2. **Task 2: Fix Patchline model and add structural validation** - `c8eb1f1` (feat) -- TDD GREEN phase

## Files Created/Modified
- `tests/test_round_trip.py` - 31-test round-trip suite covering patchline attrs, identity, key ordering, subpatchers, bpatchers, unknown objects, numeric precision, user state, extra attrs, structural errors
- `tests/fixtures/colored_patchlines.maxpat` - Synthetic fixture with colored patchline and custom_line_attr for RW-06 testing
- `src/maxpat/patcher.py` - Patchline class gains color/extra_attrs/_raw fields, dual-path to_dict, structural validation in from_dict, key-order preservation in Patcher.to_dict
- `tests/test_patcher.py` - Updated patchline order test to match correct behavior (order=0 omitted)

## Decisions Made
- Patchline dual-path to_dict: when _raw exists (loaded from file), start from original dict and overlay mutable fields; when no _raw (new connection), build from scratch with only non-default values
- Order=0 omitted in creation path: MAX itself omits order when 0, so our output should match
- Key-order preservation: store "boxes" and "lines" as placeholder entries in props during from_dict, then replace with actual data in to_dict

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] Updated test_patchline_has_order to match correct behavior**
- **Found during:** Task 2 (verification)
- **Issue:** Existing test asserted that `order` is always in patchline dict, but correct behavior (matching MAX output) is to omit order when 0
- **Fix:** Replaced test with two tests: one verifying order=0 is omitted, one verifying non-zero order is included
- **Files modified:** tests/test_patcher.py
- **Verification:** All 936 tests pass
- **Committed in:** c8eb1f1 (Task 2 commit)

**2. [Rule 1 - Bug] Removed xfail from test_all_patcher_keys_in_order**
- **Found during:** Task 2 (verification)
- **Issue:** Key-order preservation fix made the xfailed test pass (XPASS)
- **Fix:** Removed xfail decorator since the test now correctly passes
- **Files modified:** tests/test_round_trip.py
- **Committed in:** c8eb1f1 (Task 2 commit)

---

**Total deviations:** 2 auto-fixed (2 bugs)
**Impact on plan:** Both auto-fixes are correctness improvements. No scope creep.

## Issues Encountered
None

## User Setup Required
None - no external service configuration required.

## Next Phase Readiness
- Round-trip test suite ready for Plan 02 (Box raw-dict preservation) and Plan 03 (full file-level round-trip)
- 9 xfailed TestRoundTripIdentity tests will become real passes as Plans 02/03 fix remaining bugs
- Patchline dual-path pattern established as template for Box.to_dict in Plan 02

## Self-Check: PASSED

All 4 files verified present. All 2 commit hashes verified in git log.

---
*Phase: 13-round-trip-foundation*
*Completed: 2026-03-16*
