---
phase: quick-12
plan: 01
subsystem: incremental-patching
tags: [merge, maxpat, python, tdd, layout, subpatcher]

requires:
  - phase: quick-11
    provides: "Incremental patching infrastructure with manifest sidecar and merge_and_write"
provides:
  - "Attribute-level merge preserving user positions and visual attrs on regeneration"
  - "Recursive subpatcher content preservation during merge"
  - "Conditional layout: only on fresh writes, not merge runs"
affects: [max-patch-agent, max-lifecycle, generate.py scripts]

tech-stack:
  added: []
  patterns: [generator-owned vs user-owned attribute split, recursive inner patcher merge]

key-files:
  created: []
  modified:
    - src/maxpat/incremental.py
    - tests/test_incremental.py

key-decisions:
  - "Generator-owned keys: text, maxclass, numinlets, numoutlets, outlettype, fontname, fontsize; everything else is user-owned"
  - "Structural extra keys (code, args) always come from generator even if user modified them"
  - "Inner patcher merge uses generator box IDs as known set since Manifest only tracks top-level"
  - "Midpoints cleared on generator lines during merge since layout is not recomputed"

patterns-established:
  - "_merge_box_attrs: attribute-level merge pattern for generator/user ownership split"
  - "_merge_inner_patcher: recursive merge for nested subpatcher content"

requirements-completed: []

duration: 3min
completed: 2026-03-16
---

# Quick Task 12: Fix Python Generation Script Overwriting Summary

**Attribute-level box merge with generator/user ownership split, recursive subpatcher preservation, and conditional layout skip on merge runs**

## Performance

- **Duration:** 3 min
- **Started:** 2026-03-16T00:14:36Z
- **Completed:** 2026-03-16T00:17:49Z
- **Tasks:** 2
- **Files modified:** 2

## Accomplishments
- Generator-owned boxes now preserve user's patching_rect, bgcolor, and visual attrs on regeneration
- Subpatcher inner content (user-added objects) survives merge runs via recursive _merge_inner_patcher
- Layout engine skipped on merge runs -- existing file positions preserved, fresh writes still get full layout
- All 25 incremental tests pass (18 existing + 7 new), full suite of 913 tests green
- Real patch (performancepatchtest) confirmed idempotent across 3 consecutive runs

## Task Commits

Each task was committed atomically:

1. **Task 1 RED: Failing tests** - `3fd7073` (test)
2. **Task 1 GREEN: Implementation** - `bc096ff` (feat)
3. **Task 2: Real patch validation** - no code changes needed (generate.py already used merge_and_write)

_TDD task had RED and GREEN commits._

## Files Created/Modified
- `src/maxpat/incremental.py` - Added _merge_box_attrs(), _merge_inner_patcher(), removed layout call from merge path, clear stale midpoints
- `tests/test_incremental.py` - Added 7 new tests: TestMergePreservesUserPositions (3), TestMergePreservesSubpatcherContent (2), TestMergeLayoutSkippedOnMerge (1), TestMergeFreshWriteStillLayouts (1)

## Decisions Made
- Generator-owned keys are a frozen set of structural attributes; user owns everything else (patching_rect, presentation, bgcolor, etc.)
- Structural extra keys (code for gen~ codeboxes, args for bpatchers) always come from generator even in user-owned territory
- Inner patcher merge uses generator's inner box IDs as the "known set" since Manifest.from_patcher() only tracks top-level IDs
- Midpoints on generator lines are cleared during merge to avoid stale routing from non-recomputed layout

## Deviations from Plan
None - plan executed exactly as written.

## Issues Encountered
None.

## User Setup Required
None - no external service configuration required.

## Next Phase Readiness
- Incremental patching is now safe for iterative development workflows
- Users can freely move objects, add content to subpatchers, and set visual attrs without losing changes on regeneration
- All generate.py scripts using merge_and_write benefit immediately

## Self-Check: PASSED

---
*Phase: quick-12*
*Completed: 2026-03-16*
