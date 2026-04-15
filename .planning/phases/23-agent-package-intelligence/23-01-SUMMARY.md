---
phase: 23-agent-package-intelligence
plan: 01
subsystem: layout
tags: [bpatcher, sizing, layout, packages, BEAP, Vizzie]

# Dependency graph
requires:
  - phase: 21-bundled-package-extraction
    provides: bpatcher_dimensions field on package DB entries
provides:
  - DB-driven bpatcher sizing via add_bpatcher(object_name=)
  - get_bpatcher_dims() public API for dimension lookup
  - _BPATCHER_DIMS static cache of all package bpatcher dimensions
  - Adaptive vertical spacing for rows with tall elements (>100px)
affects: [max-patch-agent, max-ui-agent, layout-engine]

# Tech tracking
tech-stack:
  added: []
  patterns: [static-dimension-cache-at-import, adaptive-proportional-spacing]

key-files:
  created: []
  modified:
    - src/maxpat/sizing.py
    - src/maxpat/patcher.py
    - src/maxpat/layout.py
    - tests/test_sizing.py
    - tests/test_layout.py

key-decisions:
  - "Static bpatcher dimension cache at module import time instead of passing DB parameter to calculate_box_size()"
  - "Adaptive gap formula: v_spacing + (max_height - 100) * 0.1 for heights > 100px"
  - "Auto-set numinlets/numoutlets from DB when object_name provided to add_bpatcher()"

patterns-established:
  - "DB-driven sizing: add_bpatcher(object_name='bp.Oscillator') auto-sizes from package DB"
  - "Adaptive row spacing: proportional gap increase for tall bpatcher rows"

requirements-completed: [PKG-17]

# Metrics
duration: 4min
completed: 2026-04-14
---

# Phase 23 Plan 01: DB-Driven Bpatcher Sizing Summary

**DB-driven bpatcher sizing from package DB dimensions with adaptive row spacing for tall modules (52-895px range)**

## Performance

- **Duration:** 4 min
- **Started:** 2026-04-15T00:38:21Z
- **Completed:** 2026-04-15T00:42:30Z
- **Tasks:** 2
- **Files modified:** 5

## Accomplishments
- add_bpatcher(object_name="bp.Oscillator") now returns box with actual 314x116 dimensions instead of default 200x100
- Layout engine adds proportional vertical gap for rows with tall bpatchers (58.4px gap for 484px modules vs 20px for standard objects)
- Auto-sets numinlets/numoutlets from DB when object_name provided (bp.Oscillator: 6 inlets, 2 outlets)
- All 294 existing tests pass (52 sizing + 53 layout + 189 patcher), zero regressions

## Task Commits

Each task was committed atomically:

1. **Task 1: DB-driven bpatcher sizing** - `a2d8d57` (test) + `1ffed6d` (feat)
2. **Task 2: Adaptive layout spacing** - `d754812` (test) + `6f6e800` (feat)

_TDD tasks have separate test and implementation commits._

## Files Created/Modified
- `src/maxpat/sizing.py` - Added _load_bpatcher_dims(), _BPATCHER_DIMS cache, get_bpatcher_dims() API
- `src/maxpat/patcher.py` - Modified add_bpatcher() with object_name parameter, DB dimension/IO lookup
- `src/maxpat/layout.py` - Added adaptive gap formula for tall bpatcher rows
- `tests/test_sizing.py` - 11 new tests in TestBpatcherDBSizing class
- `tests/test_layout.py` - 4 new tests in TestAdaptiveBpatcherSpacing class

## Decisions Made
- Used static dimension cache (_BPATCHER_DIMS) loaded at import time rather than passing DB parameter to calculate_box_size() -- avoids breaking 15+ call sites
- Adaptive gap formula uses 0.1 coefficient: gap = v_spacing + (max_height - 100) * 0.1 -- gives 21.6px for standard BEAP (116px), 58.4px for large modules (484px)
- Auto-set I/O counts from DB only when caller used default numinlets=1/numoutlets=1 -- preserves explicit overrides

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered
None.

## User Setup Required
None - no external service configuration required.

## Next Phase Readiness
- Bpatcher sizing and adaptive spacing ready for use by all agents
- get_bpatcher_dims() API available for downstream plans (PACKAGES.md, SKILL.md updates)
- Pre-existing test_inlet_types.py failure is out of scope (MSP signal I/O types, not related to this plan)

## Self-Check: PASSED

All 5 files exist, all 4 commits verified, all 6 code patterns confirmed.

---
*Phase: 23-agent-package-intelligence*
*Completed: 2026-04-14*
