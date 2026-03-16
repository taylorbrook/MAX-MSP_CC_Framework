---
phase: 14-search-and-mutation-primitives
plan: 01
subsystem: api
tags: [patcher, search, query, alias-resolution, round-trip, maxpat]

# Dependency graph
requires:
  - phase: 13-round-trip-foundation
    provides: "Patcher.from_dict(), save_patch_roundtrip(), Box._raw preservation"
provides:
  - "find_box() and find_boxes() search methods on Patcher class"
  - "read_patch() convenience function for loading .maxpat files"
  - "Bidirectional alias resolution in search (t <-> trigger)"
affects: [14-02-mutation-primitives, future patch editing workflows]

# Tech tracking
tech-stack:
  added: []
  patterns: ["keyword-only search API with AND criteria combination", "bidirectional alias resolution via db._aliases"]

key-files:
  created: []
  modified:
    - src/maxpat/patcher.py
    - src/maxpat/hooks.py
    - src/maxpat/__init__.py
    - tests/test_patcher.py
    - tests/test_hooks.py

key-decisions:
  - "find_box short-circuits on first match; find_boxes collects all -- separate methods for ergonomics"
  - "Alias resolution is bidirectional: searching 't' finds 'trigger' boxes and vice versa"
  - "read_patch delegates structural validation to Patcher.from_dict() -- no extra checks"
  - "No-db fallback uses exact name match only (no alias resolution)"

patterns-established:
  - "Keyword-only search API: find_box(*, id=, name=, maxclass=, text=, recursive=)"
  - "read_patch returns (Patcher, original_text) tuple for roundtrip workflow"

requirements-completed: [RW-07]

# Metrics
duration: 4min
completed: 2026-03-16
---

# Phase 14 Plan 01: Search and Read Primitives Summary

**find_box/find_boxes search methods with bidirectional alias resolution and read_patch() file loader for the load-edit-save workflow**

## Performance

- **Duration:** 4 min
- **Started:** 2026-03-16T16:18:12Z
- **Completed:** 2026-03-16T16:21:50Z
- **Tasks:** 2
- **Files modified:** 5

## Accomplishments
- find_box() and find_boxes() on Patcher with 4 search criteria (id, name, maxclass, text), AND combination, recursive subpatcher search
- Bidirectional alias resolution: searching "t" finds "trigger" boxes and vice versa, with graceful no-db fallback
- read_patch() convenience function that returns (Patcher, original_text) tuple for the load-edit-save roundtrip workflow
- 30 new tests across test_patcher.py and test_hooks.py (20 find tests + 10 read_patch tests)

## Task Commits

Each task was committed atomically (TDD: test then feat):

1. **Task 1: find_box() and find_boxes() tests (RED)** - `63ab89c` (test)
2. **Task 1: find_box() and find_boxes() implementation (GREEN)** - `f27cc6b` (feat)
3. **Task 2: read_patch() tests (RED)** - `ef7d418` (test)
4. **Task 2: read_patch() implementation (GREEN)** - `e1e0397` (feat)

## Files Created/Modified
- `src/maxpat/patcher.py` - Added find_box(), find_boxes(), _box_matches() methods to Patcher class
- `src/maxpat/hooks.py` - Added read_patch() convenience function
- `src/maxpat/__init__.py` - Exported read_patch in public API and __all__
- `tests/test_patcher.py` - Added TestFindBox (12 tests) and TestFindBoxes (7 tests) classes
- `tests/test_hooks.py` - Added TestReadPatch (10 tests) class

## Decisions Made
- find_box short-circuits on first match; find_boxes collects all -- two separate methods rather than a single method with a flag, for API ergonomics
- Alias resolution is bidirectional: resolve both the search name and each box.name to their canonical forms, then compare. This means searching "t" finds "trigger" and searching "trigger" finds "t"
- read_patch delegates structural validation entirely to Patcher.from_dict() -- per Research pitfall #6, no extra strictness layer added
- When db is None, name matching falls back to exact match only (no alias resolution possible)
- Fixed test for combined criteria: ezdac~ has its own maxclass (not "newobj"), so adjusted test to use a valid AND combination

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] Fixed combined criteria test case**
- **Found during:** Task 1 (GREEN phase)
- **Issue:** Plan specified `find_box(maxclass="newobj", text="dac~")` should find ezdac~, but ezdac~ is a UI object with maxclass="ezdac~", not "newobj"
- **Fix:** Changed test to use two cycle~ boxes with different args, filtering by maxclass="newobj" + text="880"
- **Files modified:** tests/test_patcher.py
- **Verification:** All 20 find tests pass
- **Committed in:** f27cc6b (Task 1 feat commit)

---

**Total deviations:** 1 auto-fixed (1 bug in test specification)
**Impact on plan:** Minimal -- test logic unchanged, only the specific objects used were corrected to match actual MAX behavior.

## Issues Encountered
None

## User Setup Required
None - no external service configuration required.

## Next Phase Readiness
- Search primitives ready for use by mutation plan (14-02)
- read_patch() provides the entry point for load-edit-save workflow
- All 104 tests pass (77 patcher + 27 hooks)

---
## Self-Check: PASSED

- All 5 source/test files: FOUND
- All 4 commit hashes: FOUND
- find_box/find_boxes methods: FOUND
- read_patch in hooks.py: FOUND
- read_patch in public API: FOUND

---
*Phase: 14-search-and-mutation-primitives*
*Completed: 2026-03-16*
