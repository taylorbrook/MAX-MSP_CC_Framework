---
phase: 11-layout-refinements
plan: 02
subsystem: sizing
tags: [width-overrides, audit-data, box-sizing, layout]

# Dependency graph
requires:
  - phase: 08-audit-infrastructure
    provides: audit-report.json with per-object width_finding data
provides:
  - width-overrides.json (513 objects with median widths from help patch audit)
  - audit-aware calculate_box_size() with override lookup before text-length fallback
affects: [11-03, layout, patch-generation]

# Tech tracking
tech-stack:
  added: []
  patterns: [width-override-lookup, lazy-json-load-at-import]

key-files:
  created:
    - .claude/max-objects/audit/width-overrides.json
  modified:
    - src/maxpat/sizing.py
    - tests/test_sizing.py

key-decisions:
  - "Override lookup keyed by object name with per-arg-count and default fallback"
  - "Only objects with >= 3 audit instances included in override table (513 of 1022)"
  - "Aliases (e.g. 't' for 'trigger') intentionally not resolved -- short alias names produce correctly small boxes via text-length fallback"
  - "Updated 4 existing tests to use non-override objects for text-length path testing"

patterns-established:
  - "_load_width_overrides pattern: JSON loaded once at import time, cached in module-level dict"
  - "Override lookup order: per-arg-count string key first, then 'default' fallback"

requirements-completed: [LYOT-01]

# Metrics
duration: 2min
completed: 2026-03-13
---

# Phase 11 Plan 02: Width Overrides Summary

**Audit-based width overrides for 513 objects integrated into calculate_box_size() with text-length fallback for unknown objects**

## Performance

- **Duration:** 2 min
- **Started:** 2026-03-13T23:45:53Z
- **Completed:** 2026-03-13T23:48:18Z
- **Tasks:** 1
- **Files modified:** 3

## Accomplishments
- Generated width-overrides.json with 513 objects from audit data (all with >= 3 help patch instances)
- Integrated override lookup into calculate_box_size() -- objects like cycle~ now return 68.0 instead of text-estimated 86.0
- Added 5 new tests for override behavior (known object, unknown fallback, UI unaffected, height, comments)
- Updated 4 existing tests to properly test text-length fallback path with non-override objects

## Task Commits

Each task was committed atomically:

1. **Task 1 (RED): Add failing tests for width override lookup** - `0c0b62e` (test)
2. **Task 1 (GREEN): Implement width overrides and fix existing tests** - `901deb3` (feat)

_TDD task with RED/GREEN commits._

## Files Created/Modified
- `.claude/max-objects/audit/width-overrides.json` - 513-object width override table extracted from audit-report.json
- `src/maxpat/sizing.py` - Added _load_width_overrides() and override lookup in calculate_box_size()
- `tests/test_sizing.py` - 5 new TestWidthOverrides tests + 4 updated existing tests

## Decisions Made
- Override lookup uses `text.split()[0]` to extract object name -- matches canonical names from audit data
- Per-arg-count lookup (`str(arg_count)`) checked before `"default"` to support future per-arg-count refinements
- Existing tests updated to use fabricated object names (zzz_testobj~, zzz_short, etc.) to isolate text-length path
- Only newobj maxclass checked for overrides; comment and message boxes always use text-length sizing

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

None.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness
- Width overrides are now live -- all generated patches will use audit-based widths for known objects
- Ready for 11-03 (layout refinements that depend on accurate box sizing)
- Future enhancement: add per-arg-count entries to width-overrides.json for objects with significantly different widths at different arg counts

## Self-Check: PASSED

All files verified present. All commit hashes verified in git log.

---
*Phase: 11-layout-refinements*
*Completed: 2026-03-13*
