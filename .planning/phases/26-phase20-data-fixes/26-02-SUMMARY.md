---
phase: 26-phase20-data-fixes
plan: 02
subsystem: critics, m4l
tags: [gap-closure, public-api, validation, m4l]
dependency_graph:
  requires: []
  provides: [detect_device_type-public-api, valid-04, valid-05-verification, db-04-verification]
  affects: [src/maxpat/critics/__init__.py, src/maxpat/__init__.py]
tech_stack:
  added: []
  patterns: [backward-compat-alias, verification-tests]
key_files:
  created:
    - tests/test_m4l_detection.py
  modified:
    - src/maxpat/critics/__init__.py
    - src/maxpat/__init__.py
decisions:
  - "detect_device_type is the public name; _detect_m4l_device kept as backward-compat alias (same object)"
metrics:
  duration: 2min
  completed: "2026-04-08T06:28:46Z"
---

# Phase 26 Plan 02: Public detect_device_type API & Verification Summary

Public detect_device_type() exported from src.maxpat.critics and src.maxpat; VALID-05 (plugout~ terminal) and DB-04 (m4l_constants IntEnums) verified by dedicated tests.

## What Was Done

### Task 1: Create public detect_device_type() and dedicated tests (VALID-04)

- Renamed `_detect_m4l_device` to `detect_device_type` in `src/maxpat/critics/__init__.py`
- Added backward-compat alias: `_detect_m4l_device = detect_device_type`
- Updated `__all__` to include both names
- Updated internal call in `review_patch()` to use new public name
- Added import and `__all__` entry in `src/maxpat/__init__.py`
- Created `tests/test_m4l_detection.py` with 7 tests (TDD: RED then GREEN)
- All 47 tests pass (7 new + 34 existing critic tests + 6 verification)

### Task 2: Verify VALID-05 and DB-04 are satisfied

- Added `TestVALID05TerminalNames` (2 tests): plugout~ in both `validation.py` and `dsp_critic.py` `_TERMINAL_NAMES`
- Added `TestDB04Constants` (4 tests): ParamType, UnitStyle, ModMode, ParamVisibility IntEnums verified with correct values
- All verification tests pass on first run (no code changes needed)

## Commits

| # | Hash | Message |
|---|------|---------|
| 1 | 2f1bdae | test(26-02): add failing tests for detect_device_type() public API |
| 2 | 453d013 | feat(26-02): export detect_device_type() as public API (VALID-04) |
| 3 | 0e6a695 | test(26-02): verify VALID-05 and DB-04 are satisfied |

## Deviations from Plan

None -- plan executed exactly as written.

## Requirements Closed

- **VALID-04**: detect_device_type() public API -- implemented and tested
- **VALID-05**: plugout~ in terminal names -- verified by tests
- **DB-04**: m4l_constants IntEnums -- verified by tests

## Verification Results

```
47 passed in 0.02s
VALID-04 OK
DB-04 OK
```
