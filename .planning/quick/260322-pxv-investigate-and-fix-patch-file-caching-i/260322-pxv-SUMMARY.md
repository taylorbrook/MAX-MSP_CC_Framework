---
phase: quick-260322-pxv
plan: 01
subsystem: file-io
tags: [fsync, macOS, caching, write-hook]

requires:
  - phase: none
    provides: n/a
provides:
  - "_write_and_sync helper for reliable file writes with os.fsync"
  - "All patch/gendsp/js write paths flush to disk immediately"
affects: [hooks, save_patch_roundtrip, write_gendsp, write_js]

tech-stack:
  added: []
  patterns: ["_write_and_sync wraps open+write+flush+fsync for all file output"]

key-files:
  created: []
  modified:
    - src/maxpat/hooks.py
    - tests/test_hooks.py

key-decisions:
  - "Used open()+write()+flush()+fsync() instead of low-level os.open() for normal file permissions"

patterns-established:
  - "_write_and_sync: all file writes in hooks.py go through this helper to guarantee disk flush"

requirements-completed: [CACHE-01]

duration: 2min
completed: 2026-03-22
---

# Quick Task 260322-pxv: Fix Patch File Caching Summary

**Added _write_and_sync helper with os.fsync() to all file write paths so macOS Finder/MAX see updated content immediately**

## Performance

- **Duration:** 2 min
- **Started:** 2026-03-23T01:47:23Z
- **Completed:** 2026-03-23T01:49:40Z
- **Tasks:** 2
- **Files modified:** 2

## Accomplishments
- Created `_write_and_sync()` helper that writes, flushes, and fsyncs to guarantee macOS FSEvents fire
- Replaced `path.write_text()` in `save_patch_roundtrip`, `write_gendsp`, and `write_js` with the new helper
- Added 5 tests verifying fsync behavior and integration with all write paths
- Zero regressions across 125 existing tests

## Task Commits

Each task was committed atomically:

1. **Task 1: Add _write_and_sync helper and replace all write_text calls** - `6b57e00` (feat)
2. **Task 2: Verify no regressions in full test suite** - verification only, no code changes

## Files Created/Modified
- `src/maxpat/hooks.py` - Added `import os`, `_write_and_sync()` helper, replaced 3 `write_text` calls
- `tests/test_hooks.py` - Added `TestWriteAndSync` class with 5 tests

## Decisions Made
- Used `open()` + `f.write()` + `f.flush()` + `os.fsync(f.fileno())` instead of low-level `os.open()` to preserve normal file creation permissions (0o644 by default)

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

Pre-existing test failure in `test_byte_identical_round_trip[minitaur]` -- the minitaur.maxpat file was modified outside the framework, causing byte-identity mismatch. Unrelated to this task's changes. Logged but not fixed (out of scope).

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness
- All write paths now fsync; Finder and MAX should see updated file content immediately after save
- No blockers

## Self-Check: PASSED

- [x] src/maxpat/hooks.py exists
- [x] tests/test_hooks.py exists
- [x] SUMMARY.md exists
- [x] Commit 6b57e00 exists
- [x] _write_and_sync appears 4 times in hooks.py (1 def + 3 calls)
- [x] write_text appears 0 times in hooks.py

---
*Phase: quick-260322-pxv*
*Completed: 2026-03-22*
