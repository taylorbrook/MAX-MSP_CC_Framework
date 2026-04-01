---
phase: quick-260331-snl
plan: 01
subsystem: validation
tags: [gen~, gendsp, mc, multichannel, gain-staging, validation]

requires:
  - phase: quick-260331-rzs
    provides: integration test infrastructure and get_box_name utility
provides:
  - External .gendsp I/O validation for gen~ @gen references
  - MC oscillator gain staging checks (mc.cycle~, mc.saw~, mc.rect~, mc.tri~)
  - patch_dir parameter on validate_patch() for file-relative validation
affects: [validation, dsp-critic, hooks]

tech-stack:
  added: []
  patterns: ["patch_dir parameter enables file-system-relative validation"]

key-files:
  created: []
  modified:
    - src/maxpat/validation.py
    - src/maxpat/critics/dsp_critic.py
    - src/maxpat/hooks.py
    - tests/test_validation.py
    - tests/test_integration_patches.py

key-decisions:
  - "External .gendsp not found emits info (not error) -- file may exist in MAX search path at runtime"
  - "multichannelsignal outlet type treated as signal for gain staging and unterminated chain checks"
  - "patch_dir=None (default) silently skips .gendsp validation for backward compatibility"

patterns-established:
  - "patch_dir parameter pattern: file-relative resource resolution in validation pipeline"

requirements-completed: [QUICK-SNL]

duration: 4min
completed: 2026-04-01
---

# Quick Task 260331-snl: External .gendsp Validation and MC Oscillator Checks Summary

**gen~ @gen .gendsp I/O validation against referenced files plus MC oscillator gain staging in both validation.py and dsp_critic.py**

## Performance

- **Duration:** 4 min
- **Started:** 2026-04-01T03:41:55Z
- **Completed:** 2026-04-01T03:46:04Z
- **Tasks:** 1 (TDD: RED + GREEN)
- **Files modified:** 5

## Accomplishments
- Added `_check_external_gendsp_io()` to validation.py Layer 4: loads .gendsp files referenced by `gen~ @gen`, counts in/out objects, compares to gen~ box numinlets/numoutlets
- Added `patch_dir` parameter to `validate_patch()` for file-relative .gendsp resolution
- Added mc.cycle~, mc.saw~, mc.rect~, mc.tri~ to `_OSCILLATOR_NAMES` in both validation.py and dsp_critic.py
- Updated signal type detection to include `"multichannelsignal"` for MC objects in gain staging, unterminated chain, and control adjacency checks
- Updated `validate_file()` in hooks.py to pass `patch_dir=path.parent`
- Updated integration tests to pass `patch_dir` for real patch validation
- All 164 tests pass (7 new + 157 existing), 1 xfail

## Task Commits

Each task was committed atomically:

1. **Task 1 (RED): Add failing tests** - `bb1d562` (test)
2. **Task 1 (GREEN): Implement validation** - `7fd9239` (feat)

_TDD task with RED/GREEN commits._

## Files Created/Modified
- `src/maxpat/validation.py` - Added patch_dir param, _check_external_gendsp_io(), MC oscillators, multichannelsignal support
- `src/maxpat/critics/dsp_critic.py` - Added MC oscillators to _OSCILLATOR_NAMES
- `src/maxpat/hooks.py` - Pass patch_dir=path.parent in validate_file()
- `tests/test_validation.py` - 7 new tests: TestExternalGendspValidation (4) + TestMCOscillatorGainStaging (3)
- `tests/test_integration_patches.py` - Pass patch_dir for real patch .gendsp validation

## Decisions Made
- External .gendsp not found emits info (not error) because the file may exist in the MAX search path at runtime
- `"multichannelsignal"` outlet type treated as signal for gain staging and unterminated chain checks
- `patch_dir=None` (default) silently skips .gendsp validation for backward compatibility

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] multichannelsignal outlet type not recognized as signal**
- **Found during:** Task 1 (MC oscillator gain staging test)
- **Issue:** Signal graph building only matched `"signal"` exactly, so MC oscillators with `"multichannelsignal"` outlets were invisible to gain staging and unterminated chain checks
- **Fix:** Updated 3 signal detection points in _validate_domain_rules() to check `in ("signal", "multichannelsignal")`
- **Files modified:** src/maxpat/validation.py
- **Verification:** mc.cycle~ -> dac~ test now correctly triggers gain staging warning

---

**Total deviations:** 1 auto-fixed (1 bug)
**Impact on plan:** Fix was essential for MC oscillator checks to work. No scope creep.

## Issues Encountered
None

## User Setup Required
None - no external service configuration required.

## Next Phase Readiness
- Validation pipeline now covers external .gendsp references and MC oscillators
- Real patches with @gen references (gen-eq, performancepatchtest) pass integration validation

## Self-Check: PASSED

---
*Phase: quick-260331-snl*
*Completed: 2026-04-01*
