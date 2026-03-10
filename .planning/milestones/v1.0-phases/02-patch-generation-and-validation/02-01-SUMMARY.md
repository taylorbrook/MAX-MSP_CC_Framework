---
phase: 02-patch-generation-and-validation
plan: 01
subsystem: patch-generation
tags: [maxpat, json, dataclass, object-database, sizing, maxclass]

# Dependency graph
requires:
  - phase: 01-object-knowledge-base
    provides: "Object database JSON files (.claude/max-objects/) with 1672 objects, aliases, variable I/O rules, PD blocklist"
provides:
  - "Patcher, Box, Patchline data model with .maxpat JSON serialization"
  - "ObjectDatabase class wrapping .claude/max-objects/ with lookup, exists, compute_io_counts"
  - "Maxclass resolver: UI_MAXCLASSES frozenset + resolve_maxclass function"
  - "Content-aware box sizing: calculate_box_size returns (width, height)"
  - "MAX 9 default patcher properties and constants"
affects: [02-02-layout, 02-03-validation, 02-04-public-api]

# Tech tracking
tech-stack:
  added: []
  patterns: ["dataclass-style Python classes with to_dict() serialization", "ObjectDatabase singleton pattern shared across Patcher instances", "TDD red-green commit flow for foundational modules"]

key-files:
  created:
    - src/maxpat/__init__.py
    - src/maxpat/defaults.py
    - src/maxpat/maxclass_map.py
    - src/maxpat/sizing.py
    - src/maxpat/db_lookup.py
    - src/maxpat/patcher.py
    - tests/test_patcher.py
    - tests/test_sizing.py
  modified: []

key-decisions:
  - "Control outlet types use empty string '' (not specific types like 'int') per research recommendation -- MAX accepts '' for all control outlets"
  - "ObjectDatabase deduplicates cross-domain objects by loading core domains last (MSP cycle~ overrides RNBO cycle~), resulting in 1672 unique objects"
  - "Box constructor raises ValueError for unknown objects (Rule #1 enforcement) unless the name is a known UI maxclass"
  - "Subpatcher boxes manually constructed via Box.__new__() to bypass database lookup (subpatchers are structural, not DB objects)"

patterns-established:
  - "to_dict() serialization: every data class has to_dict() returning the .maxpat JSON fragment"
  - "ObjectDatabase shared instance: Patcher creates once, passes to all Box constructors"
  - "UI vs newobj distinction: resolve_maxclass() is the single point of truth for maxclass field"
  - "Text-based sizing formula: width = len(text) * 7.0 + 16.0, minimum 40.0"

requirements-completed: [PAT-01, PAT-02, PAT-03]

# Metrics
duration: 7min
completed: 2026-03-09
---

# Phase 2 Plan 01: Core Data Model Summary

**Patcher/Box/Patchline data model with .maxpat JSON serialization, ObjectDatabase interface, maxclass resolution, and content-aware box sizing**

## Performance

- **Duration:** 7 min
- **Started:** 2026-03-09T23:30:48Z
- **Completed:** 2026-03-09T23:37:33Z
- **Tasks:** 2
- **Files modified:** 9

## Accomplishments
- Built 6-module src/maxpat/ package: defaults, maxclass_map, sizing, db_lookup, patcher, __init__
- Patcher produces valid .maxpat JSON matching MAX 9 format (fileversion 1, appversion major 9)
- Subpatchers and bpatchers generate with correct nesting, inlet/outlet objects, and saved_object_attributes
- ObjectDatabase loads 1672 unique objects, resolves aliases (t -> trigger), computes variable I/O (trigger b i f -> 1 inlet, 3 outlets)
- Maxclass resolution correctly distinguishes 59 UI objects from newobj objects
- Content-aware box sizing: text objects use len*7+16 formula, UI objects use fixed dimensions
- 85 tests passing across test_patcher.py (56) and test_sizing.py (29)

## Task Commits

Each task was committed atomically:

1. **Task 1: Foundation modules** - `d47ee2c` (test) + `3e85557` (feat)
   - RED: failing test_sizing.py with 29 tests
   - GREEN: defaults.py, maxclass_map.py, sizing.py, db_lookup.py
2. **Task 2: Patcher/Box/Patchline data model** - `65e8d06` (test) + `0dda717` (feat)
   - RED: failing test_patcher.py with 56 tests
   - GREEN: patcher.py with Patcher, Box, Patchline classes

_TDD tasks: test commits followed by implementation commits._

## Files Created/Modified
- `src/maxpat/__init__.py` - Package init (empty, public API added in Plan 04)
- `src/maxpat/defaults.py` - MAX 9 default patcher properties, font/spacing constants
- `src/maxpat/maxclass_map.py` - UI_MAXCLASSES frozenset (59 objects), resolve_maxclass(), is_ui_object()
- `src/maxpat/sizing.py` - UI_SIZES dict + calculate_box_size() for content-aware sizing
- `src/maxpat/db_lookup.py` - ObjectDatabase class with lookup, exists, compute_io_counts, PD detection
- `src/maxpat/patcher.py` - Patcher, Box, Patchline classes with add_box, add_subpatcher, add_bpatcher, to_dict
- `tests/test_sizing.py` - 29 tests for box sizing (text-based, UI fixed, comment, message, minimum width)
- `tests/test_patcher.py` - 56 tests covering PAT-01, PAT-02, PAT-03 (structure, serialization, nesting)
- `src/__init__.py` - Package init for src directory

## Decisions Made
- Control outlet types use `""` (empty string) for all non-signal outlets, matching research recommendation and observed .maxpat behavior
- 1672 unique objects after deduplication (core domains override RNBO variants for same-name objects)
- Box constructor enforces Rule #1 by raising ValueError for unknown objects
- Subpatcher/bpatcher boxes use Box.__new__() to bypass standard constructor (these are structural wrappers, not database-lookup objects)

## Deviations from Plan

None -- plan executed exactly as written.

## Issues Encountered
None.

## User Setup Required
None -- no external service configuration required.

## Next Phase Readiness
- Core data model complete: Patcher, Box, Patchline, ObjectDatabase all functional
- Ready for Plan 02 (layout engine) which uses Patcher.boxes for topological sort positioning
- Ready for Plan 03 (validation) which uses ObjectDatabase for connection checking
- Ready for Plan 04 (public API) which wraps Patcher with generate_patch() and validate_patch()

## Self-Check: PASSED

All 10 files found. All 4 commits verified.

---
*Phase: 02-patch-generation-and-validation*
*Completed: 2026-03-09*
