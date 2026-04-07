---
phase: 23-polish
plan: 03
subsystem: m4l
tags: [m4l, critic, polish-warnings, info-text, live-banks, tdd]

requires:
  - phase: 23-polish
    plan: 02
    provides: "polish_m4l_device(), populate_info_text(), organize_push_banks()"
provides:
  - "_check_missing_info_text() warns on parameterized live.* controls without annotation"
  - "_check_missing_live_banks() warns when device has params but no live.banks"
affects: [25-testing]

tech-stack:
  added: []
  patterns: [recursive box scanning, conditional warning emission]

key-files:
  created: []
  modified:
    - src/maxpat/critics/m4l_critic.py
    - tests/test_m4l_critic.py

key-decisions:
  - "Info text check recurses into subpatchers (same pattern as _collect_parameter_longnames)"
  - "Banks check only scans top-level boxes (live.banks is always top-level)"
  - "Both checks only fire on parameterized controls (parameter_enable set)"

patterns-established:
  - "Polish gap warnings as severity 'warning' with suggestion to run compositor"

requirements-completed: [POLISH-01, POLISH-02, POLISH-03]

duration: 2min
completed: 2026-04-07
---

# Phase 23 Plan 03: Critic Polish Warnings Summary

**TDD two M4L critic checks that warn about missing info text (annotation) on parameterized live.* controls and absent live.banks when device has parameters, both severity "warning" with suggestions referencing polish_m4l_device()**

## Performance

- **Duration:** 2 min
- **Started:** 2026-04-07T05:52:40Z
- **Completed:** 2026-04-07T05:54:28Z
- **Tasks:** 1 (TDD: RED-GREEN)
- **Files modified:** 2

## Accomplishments

- _check_missing_info_text recurses boxes and flags live.* controls with parameter_enable but no annotation (D-13)
- _check_missing_live_banks flags devices that have parameter controls but no live.banks box
- Both checks wired into review_m4l as checks 5 and 6
- All warnings are severity "warning" (not "blocker") -- devices still export, but get polish nudge
- Suggestions mention polish_m4l_device() to encourage running the compositor
- Non-parameter live objects (live.thisdevice, live.path, etc.) correctly skipped via _LIVE_NO_PARAM
- Info text check recurses into subpatchers (bounded by Python recursion limit per T-23-05)
- 8 new test methods in TestPolishWarnings class

## Task Commits

Each task was committed atomically:

1. **Task 1 RED: Failing tests for polish warnings** - `843ee4c` (test)
2. **Task 1 GREEN: Implement _check_missing_info_text and _check_missing_live_banks** - `01d8566` (feat)

_TDD task -- RED committed separately from GREEN._

## Files Created/Modified

- `src/maxpat/critics/m4l_critic.py` - Added _check_missing_info_text (check 5), _check_missing_live_banks (check 6), updated module docstring, wired into review_m4l
- `tests/test_m4l_critic.py` - Added TestPolishWarnings (8 tests): info text warning/no-warning/suggestion, banks warning/no-warning/params-only, severity check, non-param skip

## Decisions Made

- Info text check recurses into subpatchers using same pattern as existing _collect_parameter_longnames
- Banks check only scans top-level boxes since live.banks is always placed at top level in M4L devices
- Both checks gate on parameter_enable -- no false positives on utility live objects

## Deviations from Plan

None -- plan executed exactly as written.

## Issues Encountered

Pre-existing test failure in test_analysis.py (missing performancepatchtest.maxpat file) -- not caused by this plan's changes. All 256 other tests pass.

## User Setup Required

None -- no external service configuration required.

## Self-Check: PASSED

- [x] src/maxpat/critics/m4l_critic.py contains `_check_missing_info_text`
- [x] src/maxpat/critics/m4l_critic.py contains `_check_missing_live_banks`
- [x] tests/test_m4l_critic.py contains `TestPolishWarnings` with 8 tests
- [x] Commit 843ee4c exists (RED)
- [x] Commit 01d8566 exists (GREEN)
- [x] 34/34 m4l_critic tests pass
- [x] 256/257 full suite pass (1 pre-existing failure unrelated)

---
*Phase: 23-polish*
*Completed: 2026-04-07*
