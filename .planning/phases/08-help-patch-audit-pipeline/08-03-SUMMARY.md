---
phase: 08-help-patch-audit-pipeline
plan: 03
subsystem: tooling
tags: [reporter, overrides, json-report, confidence-scoring, empty-io, conflict-detection, audit]

# Dependency graph
requires:
  - phase: 08-02
    provides: AuditAnalyzer with ObjectFindings dataclass, classify_outlet_type, compute_confidence
provides:
  - AuditReporter for JSON report generation with per-object discrepancies and confidence scores
  - AuditReporter.filter_report for dimension-scoped report views
  - AuditReporter.find_empty_io_objects for empty I/O coverage tracking
  - OverrideGenerator for proposed overrides with manual entry conflict detection
affects: [08-04, 09-01]

# Tech tracking
tech-stack:
  added: []
  patterns: [per-dimension-filtering, manual-override-conflict-detection, confidence-threshold-gating]

key-files:
  created:
    - src/maxpat/audit/reporter.py
    - src/maxpat/audit/overrides.py
  modified:
    - tests/test_audit_reporter.py

key-decisions:
  - "Only HIGH and MEDIUM confidence findings generate proposed overrides; LOW and CONFLICT are excluded to avoid noisy proposals"
  - "All 24 existing manual override entries are detected and flagged as conflicts, never overwritten"
  - "Empty I/O objects with help patch data get proposed corrections routed through the same conflict detection pipeline"

patterns-established:
  - "Dimension filtering: report can be scoped to a single analysis dimension (outlet_types, io_counts, widths, arguments, connections)"
  - "Conflict detection: objects already in manual overrides go to 'conflicts' dict with both audit and manual values for human review"
  - "Proposed overrides include _audit metadata (confidence, instances, agreement, source) for provenance tracking"

requirements-completed: [AUDIT-08, AUDIT-09, AUDIT-10]

# Metrics
duration: 5min
completed: 2026-03-13
---

# Phase 8 Plan 03: Report Generation and Override Proposals Summary

**JSON audit report with per-object confidence-scored discrepancies, dimension filtering, empty I/O coverage tracker, and safe override generation protecting 24 existing manual entries**

## Performance

- **Duration:** 5 min
- **Started:** 2026-03-13T14:45:22Z
- **Completed:** 2026-03-13T14:50:15Z
- **Tasks:** 2
- **Files modified:** 3

## Accomplishments
- AuditReporter generates structured JSON reports with per-object discrepancy entries, summary stats (by_confidence, by_dimension counts), and alphabetical sorting
- Report filtering allows scoping to a single dimension (outlet_types, io_counts, widths, arguments, connections) for focused review
- Empty I/O coverage tracker identifies all objects with empty inlet/outlet data in the DB and marks which have help patch data available for correction
- OverrideGenerator produces proposed overrides matching established overrides.json format while protecting all 24 existing manual entries from being overwritten

## Task Commits

Each task was committed atomically:

1. **Task 1: Audit report generation and empty I/O coverage tracker** - `bf9c3d9` (test RED), `859d8b1` (feat GREEN)
2. **Task 2: Proposed override generation with manual entry protection** - `24f7b41` (test RED), `b70b7f3` (feat GREEN)

_Note: TDD tasks have multiple commits (test -> feat)_

## Files Created/Modified
- `src/maxpat/audit/reporter.py` - AuditReporter class with generate_report, filter_report, find_empty_io_objects, write_report (239 lines)
- `src/maxpat/audit/overrides.py` - OverrideGenerator class with generate_proposed_overrides, conflict detection, _build_outlet_array/_build_inlet_array (308 lines)
- `tests/test_audit_reporter.py` - 29 tests covering report generation, filtering, empty I/O tracking, override format, conflict detection, confidence thresholds, audit metadata, empty I/O proposals (873 lines)

## Decisions Made
- Only HIGH and MEDIUM confidence findings generate proposed overrides; LOW and CONFLICT are excluded to prevent noisy, unreliable proposals from reaching the merge stage
- All 24 existing manual override entries are detected by name and routed to the conflicts dict, never added to proposed objects
- Empty I/O objects with help patch data go through the same conflict detection pipeline as outlet type findings

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

- Pre-existing test failure in `tests/test_codegen.py::TestGenBox::test_add_gen_creates_box` caused by uncommitted changes to `src/maxpat/patcher.py`. Not related to this plan's changes. Logged to `deferred-items.md`.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness
- AuditReporter and OverrideGenerator are ready for CLI wiring in Plan 08-04
- reporter.generate_report() accepts the dict[str, ObjectFindings] output from AuditAnalyzer.analyze_all()
- reporter.find_empty_io_objects() provides the empty_io_data parameter for OverrideGenerator.generate_proposed_overrides()
- reporter.write_report() and generator.write_proposed_overrides() handle file output with directory creation

## Self-Check: PASSED

All created files verified on disk. All task commits (bf9c3d9, 859d8b1, 24f7b41, b70b7f3) verified in git log. Line counts exceed minimums (reporter.py: 239 >= 80, overrides.py: 308 >= 60, test_audit_reporter.py: 873 >= 80).

---
*Phase: 08-help-patch-audit-pipeline*
*Completed: 2026-03-13*
