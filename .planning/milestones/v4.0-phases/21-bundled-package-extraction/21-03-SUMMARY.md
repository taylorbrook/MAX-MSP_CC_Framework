---
phase: 21-bundled-package-extraction
plan: 03
subsystem: testing
tags: [tests, extraction, beap, vizzie, jitter, cross-check, round-trip]
dependency_graph:
  requires: [21-01-beap-vizzie-extraction, 21-02-jitter-extraction]
  provides: [extraction-tests, io-cross-check, db-round-trip, updated-package-counts]
  affects: [test_package_schema, package_info]
tech_stack:
  added: []
  patterns: [help-patch-cross-check, db-round-trip-verification]
key_files:
  created:
    - tests/test_extraction.py
  modified:
    - tests/test_package_schema.py
    - .claude/max-objects/package_info.json
decisions:
  - Used dynamic >= 400 assertion for migration completeness instead of exact count (accommodates future extractions)
metrics:
  duration: 140s
  completed: "2026-04-14T14:37:00Z"
  tasks_completed: 2
  tasks_total: 2
  files_changed: 3
---

# Phase 21 Plan 03: Extraction Verification Tests Summary

Comprehensive test suite validating all 4 extracted packages (BEAP 185, Vizzie 110, Jitter Geometry 26, Jitter Tools 99) with I/O cross-checking against help patches and DB round-trip verification through ObjectDatabase.

## What Was Done

### Task 1: Create test_extraction.py with cross-check and round-trip tests
**Commit:** b99853a

Created `tests/test_extraction.py` (201 lines) with 4 test classes and 15 tests:

1. **TestBEAPExtraction (6 tests):** Count >= 180, schema fields (maxclass, package, domain, abstraction_file, bpatcher_dimensions, category, signal_convention), bp.Oscillator I/O (6 inlets, 2 outlets), 0-based sequential inlet/outlet ids, no internal helpers present, valid categories from 18-category set.

2. **TestVizzieExtraction (4 tests):** Count >= 100, schema fields including signal_convention="Jitter matrix", valid categories from 8-category set, descriptions present on >= 100 modules.

3. **TestIOCrossCheck (1 test, D-11):** Cross-checks extracted BEAP I/O counts against bpatcher instances found in help patches. Recursively searches help patch JSON for matching bpatcher boxes and compares numinlets/numoutlets. Verified >= 100 modules checked with <= 5 mismatches allowed.

4. **TestDBRoundTrip (4 tests, D-12):** Loads ObjectDatabase and verifies every object from all 4 packages (BEAP, Vizzie, Jitter Geometry, Jitter Tools) can be looked up with correct inlet/outlet counts matching the source JSON files.

### Task 2: Update test_package_schema.py and finalize package_info.json counts
**Commit:** 1fa8a0e

Updated `tests/test_package_schema.py`:
- `test_migration_completeness`: Changed `assert total == 88` to `assert total >= 400` (dynamic minimum)
- `test_per_package_directories`: Added BEAP, Vizzie, Jitter Geometry, Jitter Tools to expected directories
- Added 4 new test methods: `test_beap_package_objects`, `test_vizzie_package_objects`, `test_jitter_geometry_package_objects`, `test_jitter_tools_package_objects`

Updated `.claude/max-objects/package_info.json`:
- BEAP: object_count 0 -> 185, extracted false -> true
- Vizzie: object_count 0 -> 110, extracted false -> true
- Jitter Geometry and Jitter Tools already correct from Plan 02

## Deviations from Plan

None -- plan executed exactly as written.

## Verification Results

All 38 tests pass across both test files:
- 23 tests in test_package_schema.py (including 4 new package object tests)
- 15 tests in test_extraction.py (including I/O cross-check and DB round-trip)
- I/O cross-check: >= 100 BEAP modules verified against help patches
- DB round-trip: all 420 objects (185+110+26+99) load correctly in ObjectDatabase

## Self-Check: PASSED

All files exist, all commits verified:
- tests/test_extraction.py: FOUND
- tests/test_package_schema.py: FOUND (modified)
- .claude/max-objects/package_info.json: FOUND (modified)
- b99853a: FOUND in git log
- 1fa8a0e: FOUND in git log
