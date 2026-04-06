---
phase: 21-scaffold-and-routing
plan: 01
subsystem: scaffold
tags: [m4l, max-for-live, patcher, device-type, tdd]

requires:
  - phase: 20-foundation
    provides: m4l_constants.py enums, overrides.json plugin~/plugout~ maxclass corrections
provides:
  - create_m4l_project() function scaffolding audio_effect, instrument, midi_effect devices
  - 30 TDD tests covering all M4L device types and edge cases
affects: [22-m4l-critic, 23-live-banks, 24-presentation-layout, max-new-command]

tech-stack:
  added: []
  patterns:
    - "create_m4l_project() reuses create_project() for directory scaffolding then replaces .maxpat"
    - "Presentation flags on live.thisdevice only; boilerplate objects get no presentation_rect"
    - "auto_commit_patch() called after every scaffold save per CLAUDE.md Rule #7"

key-files:
  created:
    - tests/test_m4l_scaffold.py
  modified:
    - src/maxpat/project.py

key-decisions:
  - "live.thisdevice presentation_rect set to [0, 0, 120, 20] -- small top-left placement"
  - "Boilerplate objects (plugin~, plugout~, midiin, midiout) positioned at fixed coordinates for readability"
  - "auto_commit_patch mocked in tests to avoid git side effects during test runs"

patterns-established:
  - "M4L scaffold pattern: create_project() for dirs, Patcher for M4L-specific patch, auto_commit_patch for git"
  - "TDD test helper _scaffold_and_load() with auto_commit_patch mock for fast isolated testing"

requirements-completed: [SCAFFOLD-01, SCAFFOLD-02, SCAFFOLD-03, SCAFFOLD-04, SCAFFOLD-05, SCAFFOLD-06]

duration: 2min
completed: 2026-04-06
---

# Phase 21 Plan 01: M4L Scaffold Summary

**TDD create_m4l_project() scaffolding all 3 M4L device types with correct boilerplate, stereo/MIDI connections, presentation flags, and auto_commit_patch**

## Performance

- **Duration:** 2 min
- **Started:** 2026-04-06T21:04:20Z
- **Completed:** 2026-04-06T21:06:57Z
- **Tasks:** 1 (TDD RED-GREEN)
- **Files modified:** 2

## Accomplishments
- create_m4l_project() function in project.py scaffolds audio_effect, instrument, and midi_effect devices with correct boilerplate objects
- 30 tests covering all 7 test classes (TestAudioEffect, TestInstrument, TestMidiEffect, TestPresentation, TestParameterEnable, TestTripleDashPrefix, TestEdgeCases)
- SCAFFOLD-01 through SCAFFOLD-06 requirements verified via automated tests
- Zero regressions in existing test suite (1310 passing)

## Task Commits

Each task was committed atomically:

1. **Task 1 RED: TDD failing tests** - `d46042a` (test)
2. **Task 1 GREEN: implement create_m4l_project()** - `9558b7a` (feat)

## Files Created/Modified
- `tests/test_m4l_scaffold.py` - 30 TDD tests for M4L device scaffolding across 7 test classes
- `src/maxpat/project.py` - Added create_m4l_project() function with device_type validation, Patcher construction, and auto_commit_patch

## Decisions Made
- live.thisdevice presentation_rect = [0, 0, 120, 20] -- small footprint, top-left of device view
- Boilerplate object positions: live.thisdevice at (20, 20), audio I/O at (50, 80)/(50, 200), plugout~ for instrument at (200, 200) offset from MIDI chain
- Tests mock auto_commit_patch to avoid git operations in tmp_path test directories

## Deviations from Plan

None -- plan executed exactly as written.

## Issues Encountered

None.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness
- create_m4l_project() ready for /max-new command integration
- Plan 21-02 (router and agent SKILL.md updates) can proceed independently
- Downstream phases (22-25) can build on scaffold output

## Self-Check: PASSED

---
*Phase: 21-scaffold-and-routing*
*Completed: 2026-04-06*
