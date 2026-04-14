---
phase: 21-bundled-package-extraction
plan: 01
subsystem: object-database
tags: [extraction, beap, vizzie, bpatcher, packages]
dependency_graph:
  requires: []
  provides: [beap-objects-json, vizzie-objects-json, extract-abstractions-script]
  affects: [db_lookup, test_package_schema]
tech_stack:
  added: []
  patterns: [bpatcher-io-extraction, vizzie-position-ordering, help-patch-description]
key_files:
  created:
    - .claude/scripts/extract_abstractions.py
  modified:
    - .claude/max-objects/packages/BEAP/objects.json
    - .claude/max-objects/packages/Vizzie/objects.json
    - tests/test_package_schema.py
decisions:
  - Used horizontal position (patching_rect x) for Vizzie inlet/outlet ordering since all index fields are 0
  - Added 3 pfft subpatches (bp.fp_fft, bp.pvoc.pfft, bp.pvoc.rec.pfft) to internal helpers exclusion list beyond the 4 in the plan
  - BEAP misc standalone modules use position-based ordering (same as Vizzie) since they lack 1-based index fields
metrics:
  duration: 216s
  completed: "2026-04-14T14:27:04Z"
  tasks_completed: 2
  tasks_total: 2
  files_changed: 4
---

# Phase 21 Plan 01: BEAP + Vizzie Extraction Summary

Unified bpatcher extraction pipeline extracting 185 BEAP modules and 110 Vizzie modules into the object database with correct I/O counts, categories, dimensions, and descriptions.

## What Was Done

### Task 1: Build extract_abstractions.py and extract BEAP + Vizzie
**Commit:** af3fb64

Built `.claude/scripts/extract_abstractions.py` (430 lines) as a standalone Python script (stdlib only) handling three extraction patterns:

1. **BEAP Clippings (168 modules):** Parse embedded bpatcher boxes, extract I/O from inner patcher inlet/outlet objects sorted by 1-based index, dimensions from patching_rect, categories from parent directory names.

2. **BEAP Misc (17 modules):** Three sub-patterns -- embedded bpatcher (same as clippings), in~/out~ objects (marco_osc pattern with 7 modules), and top-level inlet/outlet objects (10 standalone abstractions). 7 internal helpers excluded (4 poly/pfft from plan + 3 additional pfft subpatches discovered).

3. **Vizzie (110 modules):** Top-level inlet/outlet objects sorted by horizontal position (x coordinate) since all index fields are 0. Categories from patcher.tags field, descriptions from patcher.description (100% coverage). I/O typed as "matrix" or "control" based on comment keyword analysis.

BEAP descriptions extracted from 161 help patches using longest non-instructional comment heuristic.

**Results:**
- BEAP: 185 modules (>= 180 floor) across 18 categories
- Vizzie: 110 modules across 8 categories
- bp.Oscillator: 6 inlets, 2 outlets, bpatcher_dimensions=[314.0, 116.0], category=Oscillator
- vz.analyzr: 5 inlets, 3 outlets, category=Generate, signal_convention="Jitter matrix"

### Task 2: Verify ObjectDatabase loads BEAP and Vizzie objects
**Commit:** 558aafd

Verified ObjectDatabase auto-discovers and loads all BEAP/Vizzie objects. Updated `test_list_packages_excludes_empty` to `test_list_packages_includes_populated` since BEAP and Vizzie are now populated. All 18 package schema tests pass (excluding migration_completeness hardcoded count, updated in Plan 03).

Package-aware filtering confirmed: `lookup("bp.Oscillator", allowed_packages=[])` returns None, `lookup("bp.Oscillator", allowed_packages=["BEAP"])` returns the object.

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 2 - Missing] Extended internal helpers exclusion list**
- **Found during:** Task 1
- **Issue:** Plan listed 4 internal helpers to exclude (bp.freqshift.poly, bp.polydronevoice, bp.rgrain, bp.diodeladder.poly). Three additional pfft subpatches (bp.fp_fft, bp.pvoc.pfft, bp.pvoc.rec.pfft) had no inlet/outlet/in~/out~ objects and only contained fftin~/fftout~ objects.
- **Fix:** Added 3 pfft files to INTERNAL_HELPERS set. Total excluded: 7.
- **Files modified:** .claude/scripts/extract_abstractions.py

**2. [Rule 1 - Bug] Vizzie inlet ordering uses position instead of index**
- **Found during:** Task 1
- **Issue:** Plan stated Vizzie uses 0-based index field for ordering. All Vizzie inlet/outlet objects have `index=0` regardless of position. Ordering must use horizontal position (patching_rect x coordinate).
- **Fix:** Sort inlets/outlets by x position (left-to-right) instead of index field.
- **Files modified:** .claude/scripts/extract_abstractions.py

**3. [Rule 1 - Bug] Updated stale test assertion**
- **Found during:** Task 2
- **Issue:** `test_list_packages_excludes_empty` asserted BEAP/Vizzie have 0 objects, which was true before extraction but now incorrect.
- **Fix:** Renamed to `test_list_packages_includes_populated` and asserted BEAP/Vizzie are present.
- **Files modified:** tests/test_package_schema.py
- **Commit:** 558aafd

## Verification Results

All automated checks passed:
- extract_abstractions.py --dry-run exits 0
- BEAP: 185 objects (>= 180 floor)
- Vizzie: 110 objects (>= 100 floor)
- bp.Oscillator: maxclass=bpatcher, package=BEAP, 6 inlets, 2 outlets, has abstraction_file/bpatcher_dimensions/signal_convention
- vz.analyzr: maxclass=bpatcher, package=Vizzie, has all required fields
- Every BEAP entry has package=BEAP, maxclass=bpatcher, non-empty category, abstraction_file, bpatcher_dimensions
- Every Vizzie entry has package=Vizzie, maxclass=bpatcher, non-empty category, abstraction_file, bpatcher_dimensions
- No internal helpers in output
- ObjectDatabase integration: exists, list_packages, get_package_objects, allowed_packages filtering all pass
- 18/18 package schema tests pass (1 skipped: migration_completeness)

## Self-Check: PASSED

All files exist, all commits verified, line count (430) exceeds minimum (200), key content present in output JSON files.
