---
phase: 04-agent-system-and-orchestration
plan: 03
subsystem: framework
tags: [project-lifecycle, testing, directory-isolation, status-tracking, checklist-generation]

requires:
  - phase: 02-patch-generation
    provides: Patcher/Box types and patch_dict format for test checklist scanning
provides:
  - Project creation with full directory structure (context.md, status.md, .max-memory/, generated/, test-results/)
  - Active project tracking with desync detection
  - Status read/write with stage transitions
  - Manual test checklist generation from patch contents
  - Test results storage per project
affects: [04-agent-system-and-orchestration, 05-rnbo-and-externals]

tech-stack:
  added: []
  patterns: [project-directory-isolation, key-value-status-files, patch-object-scanning]

key-files:
  created:
    - src/maxpat/project.py
    - src/maxpat/testing.py
    - tests/test_project.py
    - tests/test_testing.py
  modified: []

key-decisions:
  - "Status.md uses simple key-value format (not YAML frontmatter) for lightweight parsing"
  - "Project name validation via regex: ^[a-z0-9]+(-[a-z0-9]+)*$ (no leading/trailing hyphens)"
  - "Desync detection: get_active_project returns None when referenced project dir is missing"
  - "Test checklist detects object types by scanning box text first-word and maxclass for UI objects"

patterns-established:
  - "Project directory structure: patches/{name}/ with context.md, status.md, .max-memory/, generated/, test-results/"
  - "Active project tracking via patches/.active-project.json with desync detection"
  - "Test checklist generation from patch_dict object scanning with numbered Pass/Fail format"

requirements-completed: [FRM-01, FRM-03, FRM-06]

duration: 3min
completed: 2026-03-10
---

# Phase 04 Plan 03: Project Lifecycle and Test Checklist Summary

**Project directory isolation with status tracking and manual test checklist generation from patch object scanning**

## Performance

- **Duration:** 3 min
- **Started:** 2026-03-10T15:12:06Z
- **Completed:** 2026-03-10T15:15:27Z
- **Tasks:** 2
- **Files modified:** 4

## Accomplishments
- Project creation with full directory structure (context.md, status.md, .max-memory/patterns.md, generated/, test-results/)
- Active project tracking via .active-project.json with desync detection (returns None when project dir missing)
- Status read/write supporting stage transitions (ideation -> discuss -> research -> build -> verify)
- Test checklist generation producing numbered step-by-step checklists based on patch object types (dac~/MIDI/toggle/button/gen~/number/metro)
- 33 tests passing with full filesystem isolation via tmp_path

## Task Commits

Each task was committed atomically (TDD: test -> feat):

1. **Task 1: Project creation and active project tracking**
   - `a3ba2fa` test(04-03): add failing tests for project lifecycle management
   - `d2be355` feat(04-03): implement project lifecycle management
2. **Task 2: Manual test checklist generation**
   - `5fd3ddb` test(04-03): add failing tests for test checklist generation
   - `ffaeffd` feat(04-03): implement test checklist generation

## Files Created/Modified
- `src/maxpat/project.py` - Project creation, active tracking, status read/write, listing (6 functions)
- `src/maxpat/testing.py` - Test checklist generation and results storage (3 functions)
- `tests/test_project.py` - 19 tests covering project CRUD, status, and desync detection
- `tests/test_testing.py` - 14 tests covering checklist generation for various object types

## Decisions Made
- Status.md uses simple key-value format (not YAML frontmatter) for lightweight parsing without external dependencies
- Project name validation via regex `^[a-z0-9]+(-[a-z0-9]+)*$` -- rejects spaces, uppercase, special chars, leading/trailing hyphens
- Desync detection: get_active_project returns None when referenced project directory is missing (stale .active-project.json)
- Test checklist detects object types by scanning box text first-word and maxclass for UI objects (toggle, button, number, flonum)

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

- Pre-existing test failures in test_memory.py (missing module) and test_critics.py (unrelated DSP critic test) -- both out of scope, not caused by this plan's changes.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness
- Project infrastructure ready for agent system to use (project creation, status tracking)
- Test checklist generation ready for integration into agent verify stage
- 347 total tests passing (no regressions from pre-existing suite)

## Self-Check: PASSED

- All 4 created files exist on disk
- All 4 commit hashes verified in git log

---
*Phase: 04-agent-system-and-orchestration*
*Completed: 2026-03-10*
