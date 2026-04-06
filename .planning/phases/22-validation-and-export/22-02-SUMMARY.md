---
phase: 22-validation-and-export
plan: 02
subsystem: export
tags: [amxd, binary, m4l, struct, tdd]

# Dependency graph
requires:
  - phase: 21-scaffold-and-routing
    provides: m4l_constants.py with AMXD_* binary format constants
provides:
  - write_amxd() standalone export function producing valid .amxd files
  - Public API re-export from src.maxpat
affects: [23-polish, max-patch-agent, max-dsp-agent]

# Tech tracking
tech-stack:
  added: []
  patterns: [binary header packing via struct.pack, tab-indented JSON body for AMXD convention]

key-files:
  created:
    - src/maxpat/m4l_export.py
    - tests/test_m4l_export.py
  modified:
    - src/maxpat/__init__.py

key-decisions:
  - "Auto-commit uses path inspection (patches/{name}/) to find project_dir -- same pattern as hooks.py _auto_commit_saved_file"
  - "KeyError (not ValueError) for invalid device_type -- natural from dict lookup, documented in docstring"
  - "Test auto_commit path requires patches/{name}/ in output path to trigger commit logic"

patterns-established:
  - "Binary export pattern: struct.pack header + json.dumps body + os.fsync + auto_commit"

requirements-completed: [EXPORT-01]

# Metrics
duration: 5min
completed: 2026-04-06
---

# Phase 22 Plan 02: write_amxd() Export Summary

**TDD write_amxd() producing valid .amxd files with 32-byte binary header, tab-indented JSON body, and auto-commit for all 3 M4L device types**

## Performance

- **Duration:** 5 min
- **Started:** 2026-04-06T22:42:22Z
- **Completed:** 2026-04-06T22:47:17Z
- **Tasks:** 1 (TDD: RED + GREEN)
- **Files modified:** 3

## Accomplishments
- write_amxd() exports .maxpat files as .amxd with correct 32-byte binary header (magic, version, device type, meta, patch marker, JSON length)
- All 3 device types supported: audio_effect (b"aaaa"), instrument (b"iiii"), midi_effect (b"mmmm")
- 21 tests across 5 test classes covering header fields, JSON body, device types, error handling, and file operations
- Public API re-exported from src.maxpat

## Task Commits

Each task was committed atomically:

1. **Task 1 RED: Failing tests for write_amxd** - `37e58db` (test)
2. **Task 1 GREEN: Implement write_amxd** - `b9710c3` (feat)

## Files Created/Modified
- `src/maxpat/m4l_export.py` - write_amxd() standalone export function with binary header packing
- `tests/test_m4l_export.py` - 21 tests: TestAmxdHeader, TestAmxdBody, TestAmxdDeviceTypes, TestAmxdErrors, TestAmxdFileOps
- `src/maxpat/__init__.py` - Added write_amxd import and __all__ entry

## Decisions Made
- Auto-commit uses path inspection (patches/{name}/) to find project_dir -- same pattern as hooks.py
- KeyError for invalid device_type -- natural from dict lookup, documented in docstring
- Test auto_commit requires patches/{name}/ in output path to trigger commit logic

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] Fixed test_auto_commit_called path to trigger commit logic**
- **Found during:** Task 1 GREEN phase
- **Issue:** Test used tmp_path / "commit" / "test.amxd" which doesn't contain "patches" segment, so auto_commit_patch was never called
- **Fix:** Changed output path to tmp_path / "patches" / "my-device" / "generated" / "test.amxd"
- **Files modified:** tests/test_m4l_export.py
- **Verification:** mock_commit.assert_called_once() passes
- **Committed in:** b9710c3

---

**Total deviations:** 1 auto-fixed (1 bug)
**Impact on plan:** Test path fix necessary for auto-commit verification. No scope creep.

## Issues Encountered
- Worktree was behind main -- merged main to get m4l_constants.py and Phase 22 plan files
- 2 pre-existing test failures (test_hooks, test_inlet_types) confirmed unrelated to this plan's changes

## User Setup Required
None - no external service configuration required.

## Next Phase Readiness
- write_amxd() is available via `from src.maxpat import write_amxd`
- Agents can now complete the M4L creation loop: scaffold -> build -> export
- Ready for Phase 22-01 (M4L validation critic) if not already complete

---
*Phase: 22-validation-and-export*
*Completed: 2026-04-06*
