---
phase: quick-11
plan: 01
subsystem: codegen
tags: [incremental-patching, manifest, merge, maxpat]

# Dependency graph
requires:
  - phase: core
    provides: Patcher, Box, Patchline, write_patch pipeline
provides:
  - Manifest class for tracking generator-owned box IDs and connections
  - merge_and_write() incremental write function preserving user objects
  - Patcher.from_dict() classmethod for loading .maxpat JSON
affects: [all generate.py scripts, agent workflows that generate patches]

# Tech tracking
tech-stack:
  added: []
  patterns: [manifest-sidecar, incremental-merge]

key-files:
  created:
    - src/maxpat/incremental.py
    - tests/test_incremental.py
    - patches/performancepatchtest/generated/performancepatchtest.manifest.json
  modified:
    - src/maxpat/patcher.py
    - src/maxpat/__init__.py
    - patches/performancepatchtest/generate.py

key-decisions:
  - "Box IDs are the stable identity key; generator assigns deterministic IDs, MAX assigns different IDs for user-created objects"
  - "Manifest is a simple JSON sidecar file, not embedded in .maxpat (avoids polluting MAX format)"
  - "Connection identity is the 4-tuple (source_id, source_outlet, dest_id, dest_inlet)"
  - "merge_and_write delegates to write_patch for fresh writes, only diverges when existing patch found"
  - "Key ordering in merged output matches DEFAULT_PATCHER_PROPS for idempotency"

patterns-established:
  - "Manifest sidecar: .manifest.json next to .maxpat tracks generator ownership"
  - "Incremental merge: user objects (not in manifest) preserved, stale manifest objects removed"

requirements-completed: [QUICK-11]

# Metrics
duration: 7min
completed: 2026-03-14
---

# Quick Task 11: Incremental Patching Summary

**Manifest-tracked incremental patching with merge_and_write() preserving user-added MAX objects across regeneration**

## Performance

- **Duration:** 7 min
- **Started:** 2026-03-14T18:14:46Z
- **Completed:** 2026-03-14T18:21:46Z
- **Tasks:** 2
- **Files modified:** 6

## Accomplishments
- Manifest class tracks generator-owned box IDs and connections in JSON sidecar
- merge_and_write() merges generator changes into existing .maxpat preserving user objects
- Patcher.from_dict() enables round-trip loading of .maxpat JSON back into Patcher instances
- performancepatchtest/generate.py updated as working proof of concept
- 18 tests covering all incremental patching behaviors
- All 906 existing tests pass unchanged

## Task Commits

Each task was committed atomically:

1. **Task 1: Implement incremental patching infrastructure (TDD)**
   - `13c1e1e` (test: add failing tests for incremental patching)
   - `e2326fb` (feat: implement incremental patching infrastructure)
2. **Task 2: Update generate.py to use incremental patching** - `7caba99` (feat)

## Files Created/Modified
- `src/maxpat/incremental.py` - Manifest class, load_existing_patch, merge_and_write
- `src/maxpat/patcher.py` - Added Patcher.from_dict() classmethod
- `src/maxpat/__init__.py` - Added Manifest and merge_and_write to public API
- `tests/test_incremental.py` - 18 tests covering all incremental patching behaviors
- `patches/performancepatchtest/generate.py` - Updated to use merge_and_write
- `patches/performancepatchtest/generated/performancepatchtest.manifest.json` - Generated manifest sidecar

## Decisions Made
- Box IDs as stable identity: generator uses deterministic obj-N IDs, user-created objects in MAX get different IDs (natural separation)
- Manifest as JSON sidecar: keeps .maxpat format clean, easy to inspect/debug
- Connection identity as 4-tuple: (source_id, outlet, dest_id, inlet) uniquely identifies connections
- Key ordering matches DEFAULT_PATCHER_PROPS: ensures byte-identical idempotent output
- Auto-styling only applied when validate=True: matches write_patch behavior for consistency

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] Fixed JSON key ordering for idempotency**
- **Found during:** Task 1 (TDD GREEN phase)
- **Issue:** Merged output placed boxes/lines in different position relative to trailing props (dependency_cache, autosave), causing non-idempotent output
- **Fix:** Rebuild merged dict following DEFAULT_PATCHER_PROPS key order: main props, boxes, lines, trailing props
- **Files modified:** src/maxpat/incremental.py
- **Verification:** Idempotency test passes
- **Committed in:** e2326fb (Task 1 commit)

**2. [Rule 1 - Bug] Fixed auto-styling inconsistency between fresh and merge paths**
- **Found during:** Task 1 (TDD GREEN phase)
- **Issue:** merge path called _apply_auto_styling unconditionally, but write_patch only applies it when validate=True
- **Fix:** Conditional auto-styling: only apply when validate=True
- **Files modified:** src/maxpat/incremental.py
- **Verification:** All 18 incremental tests pass
- **Committed in:** e2326fb (Task 1 commit)

---

**Total deviations:** 2 auto-fixed (2 bugs)
**Impact on plan:** Both fixes necessary for correctness (idempotency guarantee). No scope creep.

## Issues Encountered
None beyond the auto-fixed deviations above.

## User Setup Required
None - no external service configuration required.

## Next Phase Readiness
- merge_and_write() is ready for adoption in all generate.py scripts
- Other patches (kicksynth, scala-synth) can migrate to incremental patching
- Manifest tracking enables future features: diff reporting, selective regeneration

---
*Phase: quick-11*
*Completed: 2026-03-14*
