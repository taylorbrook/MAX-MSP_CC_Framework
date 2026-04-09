---
phase: 19-tech-debt-cleanup
plan: 01
subsystem: core
tags: [round-trip, patcher, json, serialization, tech-debt]

# Dependency graph
requires:
  - phase: 13-round-trip
    provides: "Patcher.from_dict/to_dict round-trip infrastructure"
provides:
  - "Byte-identical round-trip for subpatcher-containing patches"
  - "Clean docstrings referencing current API (save_patch_roundtrip)"
  - "Removal of leftover one-off fix scripts"
affects: []

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "Sentinel None value preserves key position in ordered dict during round-trip"

key-files:
  created: []
  modified:
    - "src/maxpat/patcher.py"
    - "src/maxpat/externals.py"
    - "tests/test_round_trip.py"
    - "patches/rhythmic-sampler/generated/_fix2.py (deleted)"

key-decisions:
  - "Sentinel raw['patcher'] = None preserves key ordering instead of pop() which destroys it"

patterns-established:
  - "Sentinel pattern: Use None assignment instead of pop() when key position matters in ordered dicts"

requirements-completed: ["RW-02 (gap closure)", "CL-05 (gap closure)"]

# Metrics
duration: 2min
completed: 2026-03-17
---

# Phase 19 Plan 01: Tech Debt Cleanup Summary

**Sentinel fix for subpatcher key ordering bug enabling byte-identical round-trips, plus stale docstring and leftover script cleanup**

## Performance

- **Duration:** 2 min
- **Started:** 2026-03-17T00:27:19Z
- **Completed:** 2026-03-17T00:29:40Z
- **Tasks:** 2
- **Files modified:** 4

## Accomplishments
- Fixed subpatcher key ordering bug: `raw.pop("patcher", None)` replaced with sentinel `raw["patcher"] = None` to preserve key position in ordered dict
- 3 subpatcher-containing patches (minitaur, performancepatchtest, scala-synth) now byte-identical through from_dict/to_dict cycle
- Cleaned stale docstring in externals.py referencing removed `write_patch` function
- Deleted leftover one-off fix script `_fix2.py` (178 lines)

## Task Commits

Each task was committed atomically:

1. **Task 1 (RED): Failing test for subpatcher byte identity** - `aa9876f` (test)
2. **Task 1 (GREEN): Sentinel fix for key ordering** - `bedaeab` (feat)
3. **Task 2: Docstring fix and script deletion** - `9900d39` (chore)

_TDD task had separate RED/GREEN commits._

## Files Created/Modified
- `src/maxpat/patcher.py` - Sentinel preservation for subpatcher key ordering in from_dict
- `src/maxpat/externals.py` - Docstring updated: write_patch -> save_patch_roundtrip
- `tests/test_round_trip.py` - TestSubpatcherByteIdentity class with 3 parametrized tests
- `patches/rhythmic-sampler/generated/_fix2.py` - Deleted (leftover one-off fix script)

## Decisions Made
- Sentinel `raw["patcher"] = None` preserves key ordering instead of `raw.pop("patcher", None)` which destroys position in ordered dict

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered
None.

## User Setup Required
None - no external service configuration required.

## Next Phase Readiness
- v2.0 milestone gap closure requirements (RW-02, CL-05) are now fully clean
- All 1141 tests pass with zero regressions

## Self-Check: PASSED

All files verified present. All 3 commits verified in git log. _fix2.py confirmed deleted.

---
*Phase: 19-tech-debt-cleanup*
*Completed: 2026-03-17*
