---
phase: 13-round-trip-foundation
plan: 03
subsystem: serialization
tags: [round-trip, indentation, maxpat, patcher, file-save, zero-diff]

# Dependency graph
requires:
  - "13-02: Box _raw dict preservation and key-order"
provides:
  - "All 10 project .maxpat files pass round-trip identity tests as hard passes (zero xfail)"
  - "detect_indent() utility for identifying file indentation style"
  - "save_patch_roundtrip() for indentation-preserving file writes"
  - "Edge-case round-trip tests: unknown externals, empty patchers, nested subpatchers, creation path"
  - "File-level byte-identical round-trip for both MAX-saved (4-space) and framework (2-space) files"
affects: [14-PLAN, 17-PLAN]

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "detect_indent: scan first indented line for whitespace pattern"
    - "save_patch_roundtrip: json.dumps with string indent parameter for custom indentation"
    - "Trailing newline preservation: match original file's trailing newline status"

key-files:
  created: []
  modified:
    - src/maxpat/hooks.py
    - src/maxpat/__init__.py
    - tests/test_round_trip.py

key-decisions:
  - "save_patch_roundtrip preserves trailing newline status of original file (original files have no trailing newline)"
  - "detect_indent defaults to 4 spaces (MAX 9.1.2 format) when no indented line found"
  - "save_patch_roundtrip is a new function -- existing write_patch() unchanged for backward compatibility"
  - "Task 1 required no code changes -- Plan 02 already fixed all 10 golden file round-trip tests"

patterns-established:
  - "Use save_patch_roundtrip for round-trip saves, write_patch for creation saves"
  - "Pass original file text to save_patch_roundtrip for indentation detection"

requirements-completed: [RW-01, RW-02, RW-06]

# Metrics
duration: 4min
completed: 2026-03-16
---

# Phase 13 Plan 03: Verification Gate and Indentation-Preserving Save Summary

**Zero-diff file-level round-trip with detect_indent/save_patch_roundtrip, all 10 golden file tests promoted to hard passes, and 11 new edge-case tests added**

## Performance

- **Duration:** 4 min
- **Started:** 2026-03-16T14:45:12Z
- **Completed:** 2026-03-16T14:49:23Z
- **Tasks:** 3
- **Files modified:** 3

## Accomplishments
- All 10 project .maxpat files pass round-trip identity tests as hard passes (zero xfail markers remaining)
- Added detect_indent() and save_patch_roundtrip() for file-level zero-diff round-trip
- MAX-saved 4-space files and framework 2-space files both produce byte-identical output
- Added 11 new tests: 4 edge-case round-trip tests + 7 file-level round-trip tests
- Full test suite: 956 tests pass, zero failures, zero xfails

## Task Commits

Each task was committed atomically:

1. **Task 1: Fix remaining round-trip edge cases** - No commit needed (Plan 02 already fixed all 10 golden file tests)
2. **Task 2: Remove xfail markers and finalize test suite** - `b44e48a` (test)
3. **Task 3: Add indentation-preserving file save** - `5e7f130` (test/RED), `277fa80` (feat/GREEN)

_Note: Task 3 followed TDD: RED phase (failing tests), GREEN phase (implementation)._

## Files Created/Modified
- `src/maxpat/hooks.py` - Added detect_indent() and save_patch_roundtrip() functions
- `src/maxpat/__init__.py` - Exported detect_indent and save_patch_roundtrip in public API
- `tests/test_round_trip.py` - Removed xfail markers, added 4 edge-case tests + 7 file-level tests

## Decisions Made
- save_patch_roundtrip preserves the trailing newline status of the original file -- since project .maxpat files don't end with a newline, round-tripped output matches
- detect_indent defaults to 4 spaces (MAX 9.1.2 format) when no indented line is found in the file text
- save_patch_roundtrip is a new separate function, not a modification to write_patch -- write_patch remains unchanged for the creation workflow
- Task 1 required zero code changes to patcher.py since Plan 02's Box._raw architecture already achieved perfect round-trip for all 10 files

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered
None

## User Setup Required
None - no external service configuration required.

## Next Phase Readiness
- Phase 13 round-trip foundation is fully complete: all 3 plans delivered
- RW-01 (load any .maxpat), RW-02 (minimal-diff write-back), RW-06 (user state preservation) all satisfied
- detect_indent and save_patch_roundtrip ready for Phase 17 (MG-06) to wire into the agent workflow
- Pattern established: use save_patch_roundtrip for round-trip saves, write_patch for creation saves

## Self-Check: PASSED

All 3 modified files verified present. All 3 commit hashes verified in git log. detect_indent and save_patch_roundtrip exported from public API.

---
*Phase: 13-round-trip-foundation*
*Completed: 2026-03-16*
