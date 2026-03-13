---
phase: 08-help-patch-audit-pipeline
plan: 02
subsystem: tooling
tags: [analyzer, confidence-scoring, outlet-types, io-counts, widths, arguments, connections, audit]

# Dependency graph
requires:
  - phase: 08-01
    provides: BoxInstance dataclass, HelpPatchParser, parse_object_text
provides:
  - AuditAnalyzer with 5-dimension comparison engine (outlet types, I/O counts, widths, arguments, connections)
  - ObjectFindings dataclass aggregating all analysis dimensions per object
  - classify_outlet_type for signal/control classification of help patch outlet strings
  - compute_confidence for threshold-based agreement scoring (HIGH/MEDIUM/LOW/CONFLICT/NONE)
affects: [08-03, 08-04, 09-01]

# Tech tracking
tech-stack:
  added: []
  patterns: [per-position-outlet-consensus, signal-control-only-comparison, argument-frequency-ranking, connection-id-resolution]

key-files:
  created:
    - src/maxpat/audit/analyzer.py
  modified:
    - tests/test_audit_analyzer.py

key-decisions:
  - "Outlet type comparison operates at signal/control level only -- int/float/bang/''/etc are all 'control' and variations between them are not flagged"
  - "Confidence scoring uses 4 thresholds: HIGH (100%), MEDIUM (>=75%), LOW (>=50%), CONFLICT (<50%), plus NONE for empty input"
  - "Connection analysis resolves box IDs to object names using per-source-file lookup tables"

patterns-established:
  - "Per-position consensus voting: each outlet position gets majority vote across instances for signal/control classification"
  - "Argument pattern frequency ranking: Counter-based grouping with descending sort for pattern discovery"
  - "Connection aggregation: per-outlet and per-inlet frequency tables with box ID to object name resolution within source file scope"

requirements-completed: [AUDIT-03, AUDIT-04, AUDIT-05, AUDIT-06, AUDIT-07]

# Metrics
duration: 5min
completed: 2026-03-13
---

# Phase 8 Plan 02: Audit Analyzer Summary

**5-dimension analysis engine comparing help patch data against object DB with confidence-scored outlet type, I/O count, width, argument, and connection findings**

## Performance

- **Duration:** 5 min
- **Started:** 2026-03-13T14:37:40Z
- **Completed:** 2026-03-13T14:42:39Z
- **Tasks:** 2
- **Files modified:** 2

## Accomplishments
- AuditAnalyzer compares parsed help patch data against the object database across 5 dimensions with confidence scoring on each
- Outlet type analysis correctly classifies signal/control at each outlet position using majority consensus, without false-flagging int/float/bang variation as discrepancies
- I/O count validation handles variable_io objects by computing expected counts from parsed arguments before comparison
- Box width extraction, argument frequency ranking, and connection pattern analysis provide downstream data for report generation and override proposals

## Task Commits

Each task was committed atomically:

1. **Task 1: Outlet type comparison, I/O count validation, confidence scoring** - `cc560ee` (test RED), `a35cb5f` (feat GREEN)
2. **Task 2: Width extraction, argument analysis, connection patterns, integration** - `3d53104` (test RED), `dfa7f54` (feat GREEN)

_Note: TDD tasks have multiple commits (test -> feat)_

## Files Created/Modified
- `src/maxpat/audit/analyzer.py` - AuditAnalyzer class with 5 analyze_* methods, ObjectFindings dataclass, classify_outlet_type and compute_confidence helpers
- `tests/test_audit_analyzer.py` - 30 tests covering all 5 analysis dimensions plus integration tests

## Decisions Made
- Outlet type comparison operates at the signal/control binary level only; int vs float vs bang vs empty are all "control" and not differentiated, preventing false positive discrepancy reports
- Confidence thresholds set at natural breakpoints: 100% = HIGH, 75% = MEDIUM, 50% = LOW, below 50% = CONFLICT
- Connection analysis resolves box IDs to object names within the same source file scope to produce meaningful frequency tables

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

None.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness
- AuditAnalyzer output (ObjectFindings per object) is ready for consumption by the report generator (08-03)
- analyze_all produces a dict[str, ObjectFindings] that maps directly to report entries
- Width findings provide the per-object width data needed for Phase 11 layout work
- Argument and connection findings provide the metadata needed for override proposal generation

## Self-Check: PASSED

All created files verified on disk. All task commits (cc560ee, a35cb5f, 3d53104, dfa7f54) verified in git log.

---
*Phase: 08-help-patch-audit-pipeline*
*Completed: 2026-03-13*
