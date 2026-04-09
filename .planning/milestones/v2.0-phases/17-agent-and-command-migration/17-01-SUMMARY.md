---
phase: 17-agent-and-command-migration
plan: 01
subsystem: validation
tags: [validation, project-lifecycle, maxpat]

# Dependency graph
requires:
  - phase: 13-round-trip-fidelity
    provides: Patcher.to_dict() for empty patch creation
provides:
  - Unknown objects produce warnings not errors in validate_patch()
  - create_project() writes a valid empty .maxpat to generated/
affects: [17-02, 17-03, agent-skills]

# Tech tracking
tech-stack:
  added: []
  patterns: [warning-level for unknown objects, empty-maxpat on project creation]

key-files:
  created: []
  modified:
    - src/maxpat/validation.py
    - src/maxpat/project.py
    - tests/test_validation.py
    - tests/test_project.py

key-decisions:
  - "Unknown objects downgraded from error to warning so third-party patches pass validation"
  - "Empty .maxpat uses Patcher + set_canvas_background for styled initial patch"

patterns-established:
  - "Deferred imports inside create_project body to avoid circular imports"

requirements-completed: [MG-03, MG-06]

# Metrics
duration: 2min
completed: 2026-03-16
---

# Phase 17 Plan 01: Validation & Project Adaptation Summary

**Unknown objects downgraded to warnings in validation; create_project now writes styled empty .maxpat**

## Performance

- **Duration:** 2 min
- **Started:** 2026-03-16T21:58:54Z
- **Completed:** 2026-03-16T22:00:41Z
- **Tasks:** 2
- **Files modified:** 4

## Accomplishments
- Unknown objects in loaded patches now produce warnings instead of errors, allowing third-party patches to pass validation
- PD objects still produce errors with MAX equivalent suggestions (unchanged)
- has_blocking_errors() returns False for patches with only unknown-object warnings
- create_project() writes a valid empty .maxpat with styled canvas background to generated/{name}.maxpat

## Task Commits

Each task was committed atomically:

1. **Task 1: Change unknown object validation from error to warning** - `3bd7938` (feat)
2. **Task 2: Add empty .maxpat creation to create_project** - `7135b19` (feat)

_Both tasks followed TDD: RED (failing test) -> GREEN (implementation) -> verify_

## Files Created/Modified
- `src/maxpat/validation.py` - Changed unknown object level from "error" to "warning" in _validate_objects_exist
- `src/maxpat/project.py` - Added empty .maxpat creation via Patcher + set_canvas_background in create_project()
- `tests/test_validation.py` - Renamed test_unknown_object_error to test_unknown_object_warning, added test_unknown_object_not_blocking
- `tests/test_project.py` - Added test_creates_empty_maxpat verifying .maxpat file structure

## Decisions Made
- Unknown objects downgraded from error to warning so third-party patches pass validation without blocking
- Empty .maxpat uses Patcher + set_canvas_background for a styled initial patch (same styling as generated patches)
- Imports for Patcher and set_canvas_background placed inside create_project function body to avoid circular imports

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered
None

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness
- Validation and project creation adapted for v2.0 workflow
- Ready for 17-02 (command migration) and 17-03 (agent skill updates) which depend on these changes

## Self-Check: PASSED

All 5 files verified present. Both commit hashes (3bd7938, 7135b19) found in git log.

---
*Phase: 17-agent-and-command-migration*
*Completed: 2026-03-16*
