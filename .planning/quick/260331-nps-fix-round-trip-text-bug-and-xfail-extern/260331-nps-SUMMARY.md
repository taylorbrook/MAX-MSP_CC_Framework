---
phase: quick-260331-nps
plan: 01
subsystem: patcher
tags: [round-trip, from_dict, xfail, text-bug]

requires:
  - phase: 13-round-trip
    provides: from_dict/to_dict round-trip pipeline
provides:
  - Fixed text:"" injection bug in from_dict for UI boxes
  - Clean test suite with xfailed external-cause byte-identity failures
affects: [round-trip, patch-editing]

tech-stack:
  added: []
  patterns: [box_data.get("text") returns None for UI widgets without text key]

key-files:
  created: []
  modified:
    - src/maxpat/patcher.py
    - tests/test_round_trip.py

key-decisions:
  - "box_data.get('text') returns None (not '') when original box has no text key -- to_dict already handles None correctly at line 352"
  - "Only minitaur byte-identity test xfailed -- text fix resolved all other round-trip failures including performancepatchtest which exists on disk"

patterns-established: []

requirements-completed: []

duration: 3min
completed: 2026-03-31
---

# Quick Task 260331-nps: Fix Round-Trip Text Bug and Xfail Extern Summary

**Fixed text:"" injection bug in from_dict() and xfailed minitaur byte-identity test for MAX compact array formatting difference**

## Performance

- **Duration:** 3 min
- **Started:** 2026-04-01T00:08:37Z
- **Completed:** 2026-04-01T00:11:12Z
- **Tasks:** 1
- **Files modified:** 2

## Accomplishments
- Fixed `box_data.get("text", "")` -> `box_data.get("text")` in from_dict() so UI boxes (dial, meter~, inlet, outlet, flonum, codebox) without text keys don't get spurious `"text": ""` injected on round-trip
- All 10 TestRoundTripIdentity parametrized tests now pass (were all 10 failing before)
- TestFileLevelRoundTrip byte-identical tests now pass (both MAX-saved and framework-generated files)
- TestSubpatcherByteIdentity minitaur test xfailed with documented reason (MAX compact array formatting differs from json.dumps)

## Task Commits

1. **Task 1: Fix text:"" bug in from_dict and xfail external-cause test failures** - `ea844a1` (fix)

## Files Created/Modified
- `src/maxpat/patcher.py` - Changed `box_data.get("text", "")` to `box_data.get("text")` at line 1889
- `tests/test_round_trip.py` - Added xfail marker on minitaur entry in TestSubpatcherByteIdentity parametrize

## Decisions Made
- Plan called for removing performancepatchtest.maxpat from _PROJECT_PATCHES and xfailing 3 file-level tests, but the text fix resolved all those failures -- only the minitaur byte-identity xfail was needed
- Pre-existing test_agent_skills failure (test_patch_agent_references_max_objects) is out of scope -- fails on unmodified code

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 3 - Blocking] Plan over-scoped xfails; text fix resolved more than expected**
- **Found during:** Task 1
- **Issue:** Plan assumed performancepatchtest.maxpat was deleted from disk and that test_max_saved_file_byte_identical and test_framework_file_byte_identical would fail. In the clean worktree, the file exists and all three tests pass after the text fix.
- **Fix:** Applied only the minitaur xfail (the only test that still fails after the text fix). Did not remove performancepatchtest from _PROJECT_PATCHES or xfail the two file-level tests.
- **Files modified:** tests/test_round_trip.py
- **Verification:** 52 passed, 1 xfailed, 0 failed in test_round_trip.py; 1085 passed, 1 xfailed across full suite (excluding pre-existing agent_skills failure)

---

**Total deviations:** 1 (plan scope adjustment -- fewer xfails needed than planned)
**Impact on plan:** Positive -- the fix was more effective than anticipated, requiring fewer workarounds.

## Issues Encountered
None.

## Next Phase Readiness
- Round-trip identity tests are clean for all project patches
- Only external-cause failure (minitaur compact JSON formatting) is documented via xfail

---
*Phase: quick-260331-nps*
*Completed: 2026-03-31*
