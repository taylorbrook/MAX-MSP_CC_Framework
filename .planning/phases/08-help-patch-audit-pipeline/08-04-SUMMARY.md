---
phase: 08-help-patch-audit-pipeline
plan: 04
subsystem: tooling
tags: [cli, argparse, audit-pipeline, integration, end-to-end, maxhelp, help-patches]

# Dependency graph
requires:
  - phase: 08-03
    provides: AuditReporter, OverrideGenerator for report generation and proposed overrides
provides:
  - CLI entry point (src/maxpat/audit/cli.py) wiring parser, analyzer, reporter, and override generator
  - Single-command audit pipeline: parse -> filter -> analyze -> report -> generate overrides
  - Verified audit output files in .claude/max-objects/audit/
affects: [09-01, 11-01]

# Tech tracking
tech-stack:
  added: [argparse]
  patterns: [single-pass-pipeline, modular-cli-with-filter-flags, recursive-maxhelp-discovery]

key-files:
  created:
    - src/maxpat/audit/cli.py
    - tests/test_audit_cli.py
    - .claude/max-objects/audit/audit-report.json
    - .claude/max-objects/audit/proposed-overrides.json
    - .claude/max-objects/audit/empty-io-coverage.json
  modified:
    - src/maxpat/audit/__init__.py

key-decisions:
  - "CLI uses rglob('*.maxhelp') for recursive discovery instead of glob, ensuring subdirectory help files are found"
  - "Audit output directory is .claude/max-objects/audit/ -- co-located with the object database for easy reference"
  - "Full audit against 973 .maxhelp files: 12,952 instances, 1,022 unique objects, 0 parse failures"

patterns-established:
  - "CLI entry point pattern: argparse with filter flags, argv injection for testability, non-zero exit on error"
  - "Audit pipeline order: parse_directory -> filter_degenerate -> analyze_all -> generate_report -> generate_proposed_overrides -> write outputs"

requirements-completed: [AUDIT-01, AUDIT-02, AUDIT-03, AUDIT-04, AUDIT-05, AUDIT-06, AUDIT-07, AUDIT-08, AUDIT-09, AUDIT-10]

# Metrics
duration: 6min
completed: 2026-03-13
---

# Phase 8 Plan 04: CLI Entry Point and End-to-End Verification Summary

**Argparse CLI wiring all audit modules into single-pass pipeline, verified against 973 real .maxhelp files producing 211 proposed overrides with 0 parse failures**

## Performance

- **Duration:** 6 min
- **Started:** 2026-03-13T15:00:00Z
- **Completed:** 2026-03-13T15:06:00Z
- **Tasks:** 2
- **Files modified:** 6

## Accomplishments
- CLI entry point (`src/maxpat/audit/cli.py`, 262 lines) wires HelpPatchParser, AuditAnalyzer, AuditReporter, and OverrideGenerator into a single-pass pipeline with argparse flags for filtering and dry-run
- Full audit ran against 973 .maxhelp files with 0 parse failures, extracting 12,952 object instances across 1,022 unique objects
- Audit identified 334 discrepancies (208 HIGH, 33 MEDIUM, 67 LOW, 26 CONFLICT confidence) across outlet types, I/O counts, widths, arguments, and connections
- 211 proposed override entries generated while protecting all existing manual entries (8 conflicts flagged for human review)
- 193 empty I/O objects identified (72 with help patch data available for correction, 121 without)

## Task Commits

Each task was committed atomically:

1. **Task 1: Implement CLI entry point and integration tests** - `6a9bfb4` (feat)
   - Task 1a (Rule 3 auto-fix): Recursive .maxhelp discovery - `17c1cf5` (fix)
2. **Task 2: Run full audit against real MAX help patches** - checkpoint:human-verify (approved by user, no separate commit -- output files are untracked artifacts)

## Files Created/Modified
- `src/maxpat/audit/cli.py` - CLI entry point with argparse, single-pass pipeline, progress output, filter flags (262 lines)
- `src/maxpat/audit/__init__.py` - Updated to export `run_audit` convenience function
- `tests/test_audit_cli.py` - 11 integration tests covering invalid paths, dry-run, filter flags, full pipeline on fixtures (147 lines)
- `.claude/max-objects/audit/audit-report.json` - Full audit report with per-object discrepancies and confidence scores (3.7MB)
- `.claude/max-objects/audit/proposed-overrides.json` - 211 proposed override entries matching overrides.json format (137KB)
- `.claude/max-objects/audit/empty-io-coverage.json` - 193 empty I/O objects with coverage status (38KB)

## Decisions Made
- Used `rglob('*.maxhelp')` instead of `glob('*.maxhelp')` for recursive subdirectory discovery -- some MAX help files live in subdirectories
- Audit output directory placed at `.claude/max-objects/audit/` to co-locate with the object database it references
- All 973 .maxhelp files parsed successfully with 0 failures, validating the parser's robustness

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 3 - Blocking] Fixed recursive .maxhelp discovery**
- **Found during:** Task 1 (CLI implementation)
- **Issue:** `glob('*.maxhelp')` only found files in the top-level help directory, missing help files in subdirectories
- **Fix:** Changed to `rglob('*.maxhelp')` for recursive discovery
- **Files modified:** src/maxpat/audit/cli.py
- **Verification:** Full audit now finds all 973 .maxhelp files
- **Committed in:** 17c1cf5

---

**Total deviations:** 1 auto-fixed (1 blocking)
**Impact on plan:** Essential fix for correctness -- without recursive discovery the audit would miss help files in subdirectories.

## Issues Encountered

None -- pipeline executed cleanly against real MAX help patches.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness
- Phase 8 complete: all 4 plans executed, full audit pipeline operational
- Audit output in `.claude/max-objects/audit/` is ready for Phase 9 (Object DB Corrections) to review and merge verified corrections
- Per-object width data in audit-report.json is ready for Phase 11 (Layout Refinements) to build width override tables
- 211 proposed overrides await human review before merging into overrides.json

## Self-Check: PASSED

All created files verified on disk. All task commits (6a9bfb4, 17c1cf5) verified in git log. Line counts exceed minimums (cli.py: 262 >= 50, test_audit_cli.py: 147 >= 30). Audit output files present (audit-report.json: 3.7MB, proposed-overrides.json: 137KB, empty-io-coverage.json: 38KB).

---
*Phase: 08-help-patch-audit-pipeline*
*Completed: 2026-03-13*
