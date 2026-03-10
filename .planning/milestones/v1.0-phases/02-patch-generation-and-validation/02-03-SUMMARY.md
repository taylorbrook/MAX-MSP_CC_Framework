---
phase: 02-patch-generation-and-validation
plan: 03
subsystem: validation
tags: [validation, auto-fix, signal-type-check, connection-bounds, domain-rules, msp]

# Dependency graph
requires:
  - phase: 02-01
    provides: "Patcher/Box/Patchline data model, ObjectDatabase, maxclass_map"
provides:
  - "Four-layer validation pipeline: JSON structure, object existence, connection bounds/types, domain rules"
  - "validate_patch() accepts Patcher instance or raw dict"
  - "has_blocking_errors() distinguishes fixable from unfixable errors"
  - "Auto-fix removes invalid connections in-place and reports changes"
affects: [02-04, agent-system, patch-generation]

# Tech tracking
tech-stack:
  added: []
  patterns: ["four-layer validation pipeline", "auto-fix-and-report", "signal graph BFS/DFS analysis"]

key-files:
  created:
    - src/maxpat/validation.py
    - tests/test_validation.py
  modified: []

key-decisions:
  - "Auto-fixed connections removed in-place from patch_dict lines array (mutating) rather than returning a new copy"
  - "Signal type compatibility uses database inlet metadata (signal field + type field) for accurate signal/float detection"
  - "Unterminated chain check only applies to MSP objects (name ends with ~) with signal outlets"
  - "Gain staging BFS tracks gain-pass-through state to handle intermediate gain objects"
  - "Feedback loop detection uses DFS with GRAY/BLACK coloring, checks for tapin~/tapout~/gen~ as delay providers"

patterns-established:
  - "ValidationResult with layer/level/message/auto_fixed as structured validation output"
  - "Early termination on Layer 1 errors prevents meaningless downstream checks"
  - "has_blocking_errors filters auto_fixed to avoid false blocking"

requirements-completed: [PAT-04, PAT-05, PAT-08]

# Metrics
duration: 2min
completed: 2026-03-10
---

# Phase 2 Plan 3: Validation Pipeline Summary

**Four-layer validation pipeline (JSON structure, object existence, connection bounds/types, domain rules) with auto-fix that removes invalid connections and only blocks on unfixable errors**

## Performance

- **Duration:** 2 min
- **Started:** 2026-03-10T00:03:05Z
- **Completed:** 2026-03-10T00:05:19Z
- **Tasks:** 1 (TDD: RED + GREEN)
- **Files modified:** 2

## Accomplishments
- Four-layer validation catches structural errors, unknown/PD objects, connection bound/type violations, and domain issues
- Auto-fix removes invalid connections in-place and reports changes with auto_fixed flag
- Domain rules detect unterminated signal chains, missing gain staging, and feedback loops without delay
- validate_patch accepts both Patcher instances and raw dicts for flexibility
- Only unfixable structural errors block output; auto-fixed issues pass through

## Task Commits

Each task was committed atomically:

1. **Task 1 (RED): Add failing tests** - `7bfb402` (test)
2. **Task 1 (GREEN): Implement validation pipeline** - `7e9bea3` (feat)

_TDD task: RED commit contains all 34 tests, GREEN commit contains the implementation._

## Files Created/Modified
- `src/maxpat/validation.py` - Four-layer validation pipeline with auto-fix (ValidationResult, validate_patch, has_blocking_errors)
- `tests/test_validation.py` - 34 tests covering all layers, bounds, types, domain rules, blocking logic, and both input formats

## Decisions Made
- Auto-fixed connections are removed in-place from the patch dict lines array (mutating) for simplicity and efficiency
- Signal type compatibility checks use the database inlet metadata (signal field and type field) to accurately distinguish signal/float inlets from control-only inlets
- Unterminated chain detection only applies to MSP objects (name ends with ~) that have signal outlets but no downstream signal connection
- Gain staging uses BFS from oscillator objects, tracking whether a gain object was passed through
- Feedback loop detection uses DFS with three-color marking, exempting cycles that contain tapin~/tapout~/gen~

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered
None

## User Setup Required
None - no external service configuration required.

## Next Phase Readiness
- Validation pipeline ready for Plan 02-04 (public API, file write hooks, integration tests)
- validate_patch can be called from hooks.py for FRM-05 auto-validation on .maxpat writes
- All 201 tests pass (153 Phase 1 + 14 layout + 34 validation)

---
*Phase: 02-patch-generation-and-validation*
*Completed: 2026-03-10*
