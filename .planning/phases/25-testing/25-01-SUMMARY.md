---
phase: 25-testing
plan: 01
subsystem: testing
tags: [pytest, e2e, m4l, integration-test, amxd]

# Dependency graph
requires:
  - phase: 21-scaffold-and-routing
    provides: create_m4l_project scaffold
  - phase: 22-validation-and-export
    provides: m4l_critic, write_amxd export
  - phase: 23-polish
    provides: polish_m4l_device parameter naming
  - phase: 24-layout
    provides: layout_m4l_presentation positioning
provides:
  - E2E integration tests for complete M4L pipeline (scaffold->polish->layout->critic->export)
  - Test coverage for audio_effect, instrument, midi_effect device types
  - Regression safety net for M4L pipeline changes
affects: []

# Tech tracking
tech-stack:
  added: []
  patterns: [e2e-pipeline-test, fixture-driven-device-creation, amxd-binary-validation]

key-files:
  created:
    - tests/test_m4l_e2e.py
  modified: []

key-decisions:
  - "Control fixtures use live.numbox (15px) alongside live.dial (66px) in multi-control groups to fit within 169px tabbed layout height"
  - "MIDI effect fixture uses 2 controls in 2 groups (not 4 in 4) to exercise single-page layout path, since TAB_GROUP_THRESHOLD=3 would trigger tabbed with 4 groups"
  - "_assert_all_coords_int checks only layout-assigned controls (by ID set), not scaffold-created boxes which use float coords"

patterns-established:
  - "E2E test pattern: _build_device injects controls into scaffolded patch, _run_pipeline exercises full chain"
  - "AMXD validation pattern: check magic bytes, device type bytes, JSON length field, and embedded patcher structure"

requirements-completed: [TEST-01]

# Metrics
duration: 4min
completed: 2026-04-07
---

# Phase 25 Plan 01: M4L E2E Integration Tests Summary

**15 E2E tests covering scaffold-through-export pipeline for all 3 M4L device types with AMXD binary validation**

## Performance

- **Duration:** 4 min
- **Started:** 2026-04-07T21:25:02Z
- **Completed:** 2026-04-07T21:29:13Z
- **Tasks:** 2
- **Files modified:** 1

## Accomplishments
- TestAudioEffectE2E: 7 tests covering scaffold, polish, layout, critic, and export for 8-control tabbed device
- TestInstrumentE2E: 4 tests covering scaffold, critic, 169px height, and AMXD export for 10-control tabbed device
- TestMidiEffectE2E: 4 tests covering scaffold, critic, 169px height, and AMXD export for 2-control single-page device
- All 204 M4L tests pass (189 existing + 15 new E2E) with zero regressions

## Task Commits

Each task was committed atomically:

1. **Task 1: Create test file with helpers and audio_effect E2E tests** - `1c3fb36` (test)
2. **Task 2: Add instrument and midi_effect E2E test classes** - `a5e89aa` (test)

## Files Created/Modified
- `tests/test_m4l_e2e.py` - E2E integration tests with 3 test classes, 5 helper functions, 3 control fixtures

## Decisions Made
- Control fixtures sized to fit 169px tabbed layout: groups with multiple controls use live.numbox (15px) alongside live.dial (66px) to prevent vertical overflow
- MIDI effect fixture reduced to 2 controls / 2 groups to exercise single-page layout path (TAB_GROUP_THRESHOLD=3 triggers tabbed with 4+ groups)
- Integer coordinate assertion scoped to layout-assigned controls only, since scaffold boxes (live.thisdevice) use float presentation_rect values

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] Adjusted audio_effect fixture to prevent 169px overflow**
- **Found during:** Task 1 (audio_effect E2E tests)
- **Issue:** Plan's fixture had 2 live.dial controls (66px each) per group, which stacks to 186px in tabbed layout, exceeding 169px height cap
- **Fix:** Changed second control in multi-control groups from live.dial to live.numbox (15px), keeping 8 total controls across 5 groups
- **Files modified:** tests/test_m4l_e2e.py
- **Verification:** test_presentation_within_169px passes
- **Committed in:** 1c3fb36

**2. [Rule 1 - Bug] Scoped _assert_all_coords_int to layout-assigned controls**
- **Found during:** Task 1 (audio_effect E2E tests)
- **Issue:** Scaffold-created live.thisdevice has float presentation_rect (0.0, 0.0, 120.0, 20.0) which is expected scaffold behavior, but the assertion failed on it
- **Fix:** Added optional control_ids parameter to _assert_all_coords_int, tests pass only layout-assigned control IDs
- **Files modified:** tests/test_m4l_e2e.py
- **Verification:** test_all_coords_whole_integers passes
- **Committed in:** 1c3fb36

**3. [Rule 1 - Bug] Adjusted instrument fixture envelope group for 169px compliance**
- **Found during:** Task 2 (instrument E2E tests)
- **Issue:** Envelope group with 1 dial + 3 numboxes totaled 173px in tabbed layout
- **Fix:** Changed attack from live.dial to live.numbox, keeping all 4 envelope controls but fitting within height cap
- **Files modified:** tests/test_m4l_e2e.py
- **Verification:** test_presentation_within_169px passes for instrument
- **Committed in:** a5e89aa

---

**Total deviations:** 3 auto-fixed (3 Rule 1 bugs)
**Impact on plan:** All fixture adjustments maintain the plan's intent (8/10/2 controls across 5/5/2 groups). The height overflow is a real layout constraint that the test fixtures must respect.

## Issues Encountered
None beyond the fixture sizing deviations documented above.

## User Setup Required
None - no external service configuration required.

## Next Phase Readiness
- E2E pipeline tests complete, providing regression safety net for M4L pipeline
- Ready for Plan 02 (if any additional testing plans exist in phase 25)

---
*Phase: 25-testing*
*Completed: 2026-04-07*
