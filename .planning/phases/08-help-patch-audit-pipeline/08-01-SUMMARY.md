---
phase: 08-help-patch-audit-pipeline
plan: 01
subsystem: tooling
tags: [parser, json, recursive-descent, dataclass, audit, maxhelp]

# Dependency graph
requires: []
provides:
  - BoxInstance dataclass for representing extracted help patch object instances
  - HelpPatchParser with recursive subpatcher descent and degenerate filtering
  - parse_object_text for splitting newobj text into name, args, attributes
  - is_degenerate and filter_degenerate for identifying label/decoration objects
  - Synthetic test fixture (sample_help.json) with 3-level nesting
affects: [08-02, 08-03, 08-04, 09-01]

# Tech tracking
tech-stack:
  added: []
  patterns: [recursive-patcher-traversal, per-scope-connection-resolution, degenerate-instance-filtering]

key-files:
  created:
    - src/maxpat/audit/__init__.py
    - src/maxpat/audit/parser.py
    - tests/fixtures/sample_help.json
    - tests/test_audit_parser.py
  modified: []

key-decisions:
  - "BoxInstance dataclass uses flat fields (not nested dicts) for easy downstream consumption"
  - "Degenerate filtering requires both no-connections AND I/O mismatch to flag -- single criterion insufficient"
  - "Variable I/O objects are never filtered as degenerate since expected counts are argument-dependent"

patterns-established:
  - "Per-patcher-scope connection resolution: each recursive level builds its own id_map and connected_ids set"
  - "parse_object_text splits on @ to separate positional args from attributes"
  - "TDD: failing tests first, then minimal implementation, for both parser and filtering"

requirements-completed: [AUDIT-01, AUDIT-02]

# Metrics
duration: 4min
completed: 2026-03-13
---

# Phase 8 Plan 01: Help Patch Parser Summary

**Recursive help patch parser with BoxInstance dataclass, per-scope connection resolution, and DB-based degenerate instance filtering**

## Performance

- **Duration:** 4 min
- **Started:** 2026-03-13T14:31:00Z
- **Completed:** 2026-03-13T14:35:13Z
- **Tasks:** 2
- **Files modified:** 4

## Accomplishments
- BoxInstance dataclass captures all metadata needed for downstream audit analysis (name, text, I/O counts, outlettype, patching_rect, connections, depth, source_file)
- Recursive parser traverses nested subpatcher tabs at any depth, with per-scope connection resolution that prevents cross-contamination between patcher levels
- Degenerate filtering correctly identifies label objects (no connections + mismatched I/O) while preserving legitimate sinks (print, send, dac~) and variable_io objects
- 31 passing tests covering extraction, scoping, text parsing, and all 6 degenerate filtering behaviors

## Task Commits

Each task was committed atomically:

1. **Task 1: Define BoxInstance dataclass and implement recursive parser** - `9796821` (feat)
2. **Task 2: Implement degenerate instance filtering** - `621f2cd` (feat)

## Files Created/Modified
- `src/maxpat/audit/__init__.py` - Package init with BoxInstance dataclass (name, text, I/O counts, outlettype, patching_rect, connections, depth)
- `src/maxpat/audit/parser.py` - HelpPatchParser, traverse_patcher, parse_object_text, is_degenerate, filter_degenerate
- `tests/fixtures/sample_help.json` - Synthetic .maxhelp-format JSON with 3 nesting levels, 8 objects, connections at each scope
- `tests/test_audit_parser.py` - 31 tests covering recursive descent, connection scoping, text parsing, degenerate filtering

## Decisions Made
- BoxInstance uses flat dataclass fields rather than nested dicts for simplicity and type safety
- Degenerate detection requires dual criteria (no connections AND I/O mismatch) to avoid false positives on legitimate unconnected objects
- Variable I/O objects are never flagged as degenerate since their expected counts depend on arguments that may differ across instances

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

None.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness
- Parser output (list[BoxInstance]) is ready for consumption by the analysis engine (08-02)
- parse_object_text provides the name/args/attrs split needed for outlet type comparison and argument analysis
- Degenerate filtering ensures only real working instances feed into confidence scoring

## Self-Check: PASSED

All created files verified on disk. All task commits (9796821, 621f2cd) verified in git log.

---
*Phase: 08-help-patch-audit-pipeline*
*Completed: 2026-03-13*
