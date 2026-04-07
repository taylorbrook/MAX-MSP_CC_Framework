---
phase: 25-testing
plan: 02
subsystem: testing
tags: [pytest, e2e, m4l, violation-tests, critic, push-banks]

# Dependency graph
requires:
  - phase: 25-testing
    plan: 01
    provides: E2E test file with helpers, fixtures, and 3 device type test classes
  - phase: 22-validation-and-export
    provides: m4l_critic gain~/plugout~ check, parameter uniqueness check, device quality check
  - phase: 23-polish
    provides: polish_m4l_device duplicate longname resolution, push bank organization
provides:
  - TestViolationE2E class with 3 violation detection E2E tests
  - Push bank organization E2E assertion in TestAudioEffectE2E
affects: []

# Tech tracking
tech-stack:
  added: []
  patterns: [violation-e2e-test, pre-post-polish-assertion, push-bank-validation]

key-files:
  created: []
  modified:
    - tests/test_m4l_e2e.py

key-decisions:
  - "Duplicate longname test uses pre-polish/post-polish dual assertion pattern since polish auto-resolves duplicates -- verifies both critic detection AND polish fix in sequence"
  - "Push bank test asserts structural properties (name is string, parameters is list of 8) not exact bank names or parameter assignments"

patterns-established:
  - "Pre/post-polish dual assertion: test critic detection before polish, then verify polish resolves the issue"

requirements-completed: [TEST-01]

# Metrics
duration: 3min
completed: 2026-04-07
---

# Phase 25 Plan 02: M4L Violation E2E Tests Summary

**TestViolationE2E with gain~/plugout~ blocker, duplicate longname, and parameter_enable warnings through full pipeline, plus Push bank E2E assertion**

## Performance

- **Duration:** 3 min
- **Started:** 2026-04-07T21:31:57Z
- **Completed:** 2026-04-07T21:34:50Z
- **Tasks:** 2
- **Files modified:** 1

## Accomplishments
- TestViolationE2E: 3 tests verifying critic catches violations in full pipeline context (gain~/plugout~ blocker, duplicate longname blocker, missing parameter_enable warning)
- Push bank E2E: verifies live.banks box with valid _parameter_banks structure after polish
- Full M4L regression green: 208 tests (189 existing + 19 E2E) with zero regressions
- test_m4l_critic.py untouched per D-04

## Task Commits

Each task was committed atomically:

1. **Task 1: Add TestViolationE2E class** - `2de40b4` (test)
2. **Task 2: Add push bank E2E assertion** - `df382bb` (test)

## Files Created/Modified
- `tests/test_m4l_e2e.py` - Added TestViolationE2E class (3 tests) and test_push_banks_organized to TestAudioEffectE2E

## Decisions Made
- Duplicate longname test uses dual pre/post-polish assertion: confirms critic catches raw duplicates as blocker, then confirms polish resolves them. This tests the critic detection AND the polish fix in pipeline sequence rather than just one or the other.
- Push bank test asserts structural properties (name type, parameters list length of 8) rather than exact values, avoiding brittleness if bank classification keywords change.

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered
None.

## User Setup Required
None - no external service configuration required.

## Next Phase Readiness
- All E2E tests complete: 19 tests covering 3 device types, 3 violation scenarios, and Push bank organization
- Full M4L test suite (208 tests) provides regression safety net for any future pipeline changes

---
*Phase: 25-testing*
*Completed: 2026-04-07*
