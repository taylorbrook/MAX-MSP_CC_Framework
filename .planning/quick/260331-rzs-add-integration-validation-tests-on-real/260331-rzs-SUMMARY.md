---
phase: quick-260331-rzs
plan: 01
subsystem: testing
tags: [pytest, parametrize, validation, critics, integration-tests]

requires:
  - phase: quick-260322-dz9
    provides: validation pipeline and critic system
provides:
  - Shared get_box_name helper in src/maxpat/utils.py
  - Parametrized integration tests on all 18 real .maxpat files
affects: [validation, critics, future patch generation]

tech-stack:
  added: []
  patterns: [shared-utils-module, parametrized-integration-tests]

key-files:
  created:
    - src/maxpat/utils.py
    - tests/test_integration_patches.py
  modified:
    - src/maxpat/validation.py
    - src/maxpat/critics/dsp_critic.py
    - src/maxpat/critics/structure_critic.py

key-decisions:
  - "get_box_name() is public API (no underscore) since it is shared across 3 modules"
  - "mixer-strip.maxpat marked xfail for known gain source blocker rather than skipping"

patterns-established:
  - "Shared helpers live in src/maxpat/utils.py"
  - "Integration tests use parametrize over patches/*/generated/*.maxpat with xfail for known issues"

requirements-completed: [QUICK-260331-RZS]

duration: 2min
completed: 2026-03-31
---

# Quick Task 260331-rzs: Integration Validation Tests Summary

**Deduplicated get_box_name into shared utils module and added parametrized integration tests validating all 18 real .maxpat patches**

## Performance

- **Duration:** 2 min
- **Started:** 2026-04-01T03:12:24Z
- **Completed:** 2026-04-01T03:14:42Z
- **Tasks:** 2
- **Files modified:** 5

## Accomplishments
- Extracted 3 identical copies of _get_box_name into single shared get_box_name() in src/maxpat/utils.py
- Added 36 parametrized integration tests (18 validate_patch + 18 review_patch) on real .maxpat files
- 35 pass, 1 xfail (mixer-strip.maxpat gain source blocker) -- regression safety net established

## Task Commits

Each task was committed atomically:

1. **Task 1: Extract get_box_name to shared utils module** - `b7be400` (refactor)
2. **Task 2: Add parametrized integration tests** - `ed3c271` (test: TDD RED), `4f8af26` (feat: TDD GREEN)

## Files Created/Modified
- `src/maxpat/utils.py` - Shared get_box_name() helper (new)
- `tests/test_integration_patches.py` - Parametrized integration tests on real patches (new)
- `src/maxpat/validation.py` - Removed _get_box_name, imports from utils
- `src/maxpat/critics/dsp_critic.py` - Removed _get_box_name, imports from utils
- `src/maxpat/critics/structure_critic.py` - Removed _get_box_name, imports from utils

## Decisions Made
- get_box_name() is public API (no leading underscore) since it is now a shared utility
- mixer-strip.maxpat marked with pytest.mark.xfail rather than skip, to track regressions

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

None.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness
- Integration tests provide regression safety net for all future patch generation
- Known issue (mixer-strip.maxpat gain source) tracked via xfail

## Self-Check: PASSED

All files exist, all commits verified.

---
*Phase: quick-260331-rzs*
*Completed: 2026-03-31*
