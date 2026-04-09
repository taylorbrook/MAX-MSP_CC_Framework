---
phase: 13-round-trip-foundation
plan: 02
subsystem: serialization
tags: [round-trip, raw-dict, maxpat, patcher, box, key-ordering]

# Dependency graph
requires:
  - "13-01: Round-trip test suite and patchline fix"
provides:
  - "Box._raw dict preservation for lossless round-trip of all box keys"
  - "Dual-path Box.to_dict: _raw-based round-trip vs scratch creation"
  - "Patcher key-order preservation via boxes/lines None placeholders in props"
  - "Zero spurious parameter_enable or outlettype on loaded boxes"
  - "All 10 project .maxpat files pass round-trip identity tests"
affects: [13-03-PLAN]

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "Box._raw: shallow copy of original JSON dict (sans nested patcher) stored during from_dict"
    - "Dual-path to_dict on Box: if _raw exists, start from original and overlay mutations; else build from scratch"
    - "All Box.__new__() bypass paths must initialize _raw = None for creation path"
    - "Patcher props uses None placeholders for boxes/lines to preserve key position"

key-files:
  created: []
  modified:
    - src/maxpat/patcher.py
    - src/maxpat/rnbo.py
    - src/maxpat/externals.py
    - tests/test_aesthetics.py
    - patches/performancepatchtest/generate.py
    - patches/scala-synth/generated/build_scala_synth.py
    - patches/kicksynth/generated/build_kicksynth.py

key-decisions:
  - "Box._raw stores shallow copy excluding nested patcher (inner patcher reconstructed from _inner_patcher to avoid stale data)"
  - "outlettype only emitted in round-trip path if present in original _raw (prevents spurious addition to comments)"
  - "parameter_enable removed from _handled_keys -- preserved automatically via _raw, no longer needs special handling"
  - "All Box.__new__() callers across the entire codebase updated to initialize _raw = None"

patterns-established:
  - "Box dual-path serialization mirrors Patchline dual-path pattern from Plan 01"
  - "Any new Box.__new__() bypass must always set _raw = None"
  - "Round-trip path overlays only mutable fields (patching_rect, numinlets, numoutlets, outlettype, presentation, patcher, saved_object_attributes)"

requirements-completed: [RW-01, RW-02]

# Metrics
duration: 6min
completed: 2026-03-16
---

# Phase 13 Plan 02: Raw Dict Preservation and Key-Order Summary

**Box._raw dict preservation eliminates all categories of round-trip data loss -- text, fonts, parameter_enable, outlettype, and key ordering -- in one architectural change**

## Performance

- **Duration:** 6 min
- **Started:** 2026-03-16T14:34:46Z
- **Completed:** 2026-03-16T14:41:26Z
- **Tasks:** 2
- **Files modified:** 7

## Accomplishments
- Implemented Box._raw preservation: loaded boxes store their original JSON dict and use it as the starting point for to_dict serialization
- Eliminated 5 categories of round-trip bugs simultaneously: text loss on UI widgets, font loss on codeboxes, spurious parameter_enable addition, spurious outlettype on comments, and key ordering drift
- All 10 project .maxpat files now pass round-trip identity tests (9 were previously xfailed)
- Updated 7 files across the codebase to initialize _raw = None on all Box.__new__() creation paths
- Full test suite: 945 tests pass, zero failures, zero xfails

## Task Commits

Each task was committed atomically:

1. **Task 1: Add _raw dict preservation to Box for lossless round-trip** - `aabb281` (feat)
2. **Task 2: Fix Patcher-level key ordering for boxes/lines position** - `a16ad10` (feat)

## Files Created/Modified
- `src/maxpat/patcher.py` - Box._raw attribute, dual-path to_dict, _raw storage in from_dict, parameter_enable removed from _handled_keys, None placeholders for boxes/lines in props
- `src/maxpat/rnbo.py` - Added _raw = None to 8 Box.__new__() creation paths
- `src/maxpat/externals.py` - Added _raw = None to Box.__new__() in scaffold_external
- `tests/test_aesthetics.py` - Added _raw = None to test helper Box creation
- `patches/performancepatchtest/generate.py` - Added _raw = None to 2 Box.__new__() paths
- `patches/scala-synth/generated/build_scala_synth.py` - Added _raw = None to 4 Box.__new__() paths
- `patches/kicksynth/generated/build_kicksynth.py` - Added _raw = None to scope Box.__new__() path

## Decisions Made
- Box._raw stores a shallow copy of the original box_data dict, excluding the "patcher" key (nested patcher is reconstructed from _inner_patcher to avoid serializing stale data)
- outlettype is only emitted in the round-trip path if it was present in the original _raw dict -- prevents spurious addition to comment boxes and other zero-outlet boxes
- parameter_enable removed from _handled_keys set entirely -- it flows into extra_attrs for boxes that have it, and the _raw dict handles round-trip preservation automatically
- All Box.__new__() callers across the entire codebase (patcher.py, rnbo.py, externals.py, test helpers, patch generation scripts) were updated to initialize _raw = None

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 3 - Blocking] Added _raw = None to Box.__new__() in externals.py**
- **Found during:** Task 1 (full test suite verification)
- **Issue:** externals.py scaffold_external uses Box.__new__(Box) without setting _raw, causing AttributeError when to_dict called
- **Fix:** Added `ext_box._raw = None` after other attribute initialization
- **Files modified:** src/maxpat/externals.py
- **Verification:** test_externals.py::TestScaffoldStructure passes
- **Committed in:** a16ad10 (Task 2 commit)

**2. [Rule 3 - Blocking] Added _raw = None to Box.__new__() in rnbo.py**
- **Found during:** Task 1 (proactive check of all Box.__new__() callers)
- **Issue:** rnbo.py has 8 Box.__new__() creation paths, none initializing _raw
- **Fix:** Added `_raw = None` to all 8 creation paths (in_box, out_box, param_box, inport_box, outport_box, user_box, parent_box)
- **Files modified:** src/maxpat/rnbo.py
- **Verification:** Full test suite passes
- **Committed in:** a16ad10 (Task 2 commit)

**3. [Rule 3 - Blocking] Added _raw = None to Box.__new__() in test helpers and patch scripts**
- **Found during:** Task 1 (proactive check of all Box.__new__() callers)
- **Issue:** test_aesthetics.py, generate.py, build_scala_synth.py, build_kicksynth.py use Box.__new__() without _raw
- **Fix:** Added `_raw = None` to all creation paths in these files
- **Files modified:** tests/test_aesthetics.py, patches/performancepatchtest/generate.py, patches/scala-synth/generated/build_scala_synth.py, patches/kicksynth/generated/build_kicksynth.py
- **Verification:** Full test suite passes (945 tests)
- **Committed in:** a16ad10 (Task 2 commit)

---

**Total deviations:** 3 auto-fixed (3 blocking)
**Impact on plan:** All auto-fixes are necessary correctness fixes to maintain backward compatibility with existing Box.__new__() creation patterns throughout the codebase. No scope creep.

## Issues Encountered
None

## User Setup Required
None - no external service configuration required.

## Next Phase Readiness
- Box._raw and Patcher key-order preservation complete -- the core "preserve-first" architecture is in place
- All 10 project .maxpat files pass round-trip identity tests (zero xfails remaining)
- Plan 03 can build on this foundation for any remaining edge cases (bpatcher attrs via extra_attrs, full file-level JSON identity)
- Pattern established: any new Box.__new__() code must always set `_raw = None`

## Self-Check: PASSED

All 7 modified files verified present. All 2 commit hashes verified in git log.

---
*Phase: 13-round-trip-foundation*
*Completed: 2026-03-16*
