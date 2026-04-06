---
phase: 22-validation-and-export
plan: 01
subsystem: validation
tags: [m4l, critic, tdd, max-for-live, device-validation]

# Dependency graph
requires:
  - phase: 21-scaffold-and-routing
    provides: create_m4l_project() scaffolding and device type detection
  - phase: 20-foundation
    provides: M4L constants, database entries, detect_device_type()
provides:
  - review_m4l() function with 4 validation checks (gain~/plugout~, completeness, parameter uniqueness, device quality)
  - _detect_m4l_device() auto-detection wired into review_patch()
  - plugout~ in terminal name sets (dsp_critic, validation)
  - plugin~/plugout~ in layout IO name set
affects: [22-02-export, 23-polish, 24-layout, 25-testing]

# Tech tracking
tech-stack:
  added: []
  patterns: [m4l-critic-pattern, recursive-parameter-collection, device-type-auto-detection]

key-files:
  created:
    - src/maxpat/critics/m4l_critic.py
    - tests/test_m4l_critic.py
  modified:
    - src/maxpat/critics/__init__.py
    - src/maxpat/critics/dsp_critic.py
    - src/maxpat/validation.py
    - src/maxpat/layout.py
    - tests/test_critics.py

key-decisions:
  - "plugin~ alone (without plugout~) classifies as audio_effect since plugin~ only exists in M4L audio effects"
  - "live.thisdevice, live.banks, live.path, live.object, live.observer, live.remote~, live.scope~, live.colors excluded from parameter_enable check"

patterns-established:
  - "M4L critic follows rnbo_critic pattern: public review_m4l() delegates to private _check_* helpers"
  - "Recursive _collect_parameter_longnames() traverses subpatchers for device-wide parameter uniqueness"
  - "Auto-detection in __init__.py: _detect_m4l_device() scans for indicator objects, review_patch() invokes critic when detected"

requirements-completed: [VALID-01, VALID-02, VALID-03]

# Metrics
duration: 7min
completed: 2026-04-06
---

# Phase 22 Plan 01: M4L Critic Summary

**TDD M4L critic with gain~/plugout~ detection, device completeness, parameter uniqueness, quality checks, and auto-detection wired into review_patch()**

## Performance

- **Duration:** 7 min
- **Started:** 2026-04-06T22:42:27Z
- **Completed:** 2026-04-06T22:49:40Z
- **Tasks:** 1 (TDD: RED + GREEN)
- **Files modified:** 7

## Accomplishments
- M4L critic detects gain~ connected to plugout~ (VALID-01), missing required objects per device type (VALID-02), and duplicate parameter_longname across device including subpatchers (VALID-03)
- Auto-detection wired into review_patch() via _detect_m4l_device() -- M4L critic runs automatically when live.thisdevice is present
- plugout~ added to _TERMINAL_NAMES in dsp_critic.py and validation.py; plugin~/plugout~ added to _IO_OBJECT_NAMES in layout.py
- Device quality checks: openinpresentation, devicewidth, parameter_enable on live.* controls
- 26 new tests across 6 test classes + 1 integration test in test_critics.py

## Task Commits

Each task was committed atomically:

1. **Task 1 RED: TDD failing tests** - `b5428fd` (test)
2. **Task 1 GREEN: Implementation + wiring** - `d0cf7d2` (feat)

_TDD task: RED committed separately from GREEN_

## Files Created/Modified
- `src/maxpat/critics/m4l_critic.py` - New M4L critic: review_m4l() with 4 check functions
- `src/maxpat/critics/__init__.py` - _detect_m4l_device() and review_m4l wiring into review_patch()
- `src/maxpat/critics/dsp_critic.py` - Added plugout~ to _TERMINAL_NAMES
- `src/maxpat/validation.py` - Added plugout~ to _TERMINAL_NAMES
- `src/maxpat/layout.py` - Added plugin~/plugout~ to _IO_OBJECT_NAMES
- `tests/test_m4l_critic.py` - 26 tests: terminal names, gain/plugout, completeness, params, detection, quality
- `tests/test_critics.py` - TestReviewPatchM4L integration test

## Decisions Made
- plugin~ alone (without plugout~) classifies as audio_effect in _detect_m4l_device() since plugin~ only exists in M4L audio effects -- needed for completeness check to catch missing plugout~
- Excluded live.thisdevice, live.banks, live.path, live.object, live.observer, live.remote~, live.scope~, live.colors from parameter_enable warning (non-parameter live.* objects)

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] Fixed _detect_m4l_device missing plugin~-only case**
- **Found during:** Task 1 GREEN (test_review_patch_includes_m4l_findings failed)
- **Issue:** Detection logic required both plugin~ AND plugout~ for audio_effect, but test case had plugin~ without plugout~ to verify completeness check catches it
- **Fix:** Added `if has_plugin and not has_plugout: return "audio_effect"` clause before instrument/midi_effect checks
- **Files modified:** src/maxpat/critics/__init__.py
- **Verification:** All 26 M4L critic tests pass
- **Committed in:** d0cf7d2

---

**Total deviations:** 1 auto-fixed (1 bug)
**Impact on plan:** Auto-fix was necessary for correct detection of incomplete audio_effect devices. No scope creep.

## Issues Encountered
- Pre-existing test failures (3) unrelated to this plan: test_analysis.py missing fixture file, test_generation.py/test_hooks.py/test_integration_patches.py `patch_dir` keyword argument TypeError in hooks.py. All confirmed pre-existing by testing without our changes. Logged but not fixed (out of scope).

## User Setup Required
None - no external service configuration required.

## Next Phase Readiness
- M4L critic complete and wired in -- ready for Phase 22-02 (.amxd export)
- Phase 23 (Polish) and Phase 24 (Layout) can proceed in parallel
- All validation checks (VALID-01/02/03) passing with comprehensive test coverage

## Self-Check: PASSED

- All 8 key files: FOUND
- Commit b5428fd: FOUND
- Commit d0cf7d2: FOUND

---
*Phase: 22-validation-and-export*
*Completed: 2026-04-06*
