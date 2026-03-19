---
phase: quick-260318-ujk
plan: 01
subsystem: patcher-api
tags: [maxpat, inlet, outlet, assistance, comments, tooltips, subpatcher]

# Dependency graph
requires:
  - phase: 13-round-trip
    provides: "Box.extra_attrs serialization, Patcher.add_subpatcher"
provides:
  - "add_subpatcher inlet_comments/outlet_comments parameters"
  - "Patcher.populate_assistance_comments() auto-inference method"
  - "Agent skill instructions for assistance comment usage"
affects: [max-patch-agent, max-dsp-agent]

# Tech tracking
tech-stack:
  added: []
  patterns: ["auto-inference from patchline connections for metadata population"]

key-files:
  created: []
  modified:
    - src/maxpat/patcher.py
    - tests/test_patcher.py
    - .claude/skills/max-patch-agent/SKILL.md
    - .claude/skills/max-dsp-agent/SKILL.md

key-decisions:
  - "Signal prefix heuristic: use 'signal' if inlet/outlet or connected object name ends with ~, otherwise 'data'"
  - "Positional fallback uses 1-indexed ('inlet 1', 'outlet 2') to match MAX UI conventions"
  - "Static recursive helper method avoids public API surface for internal traversal"

patterns-established:
  - "Assistance comments on subpatcher I/O: always label inlets/outlets for mouseover tooltips"

requirements-completed: [QUICK-UJK]

# Metrics
duration: 5min
completed: 2026-03-19
---

# Quick Task 260318-ujk: Auto-populate Assistance Comments Summary

**add_subpatcher() with explicit inlet/outlet comment params and populate_assistance_comments() auto-inference from connection context**

## Performance

- **Duration:** 5 min
- **Started:** 2026-03-19T05:03:42Z
- **Completed:** 2026-03-19T05:08:00Z
- **Tasks:** 2
- **Files modified:** 4

## Accomplishments
- add_subpatcher() now accepts optional inlet_comments and outlet_comments parameters for explicit labeling
- New populate_assistance_comments() method auto-infers descriptive text from patchline connections
- 10 new tests covering explicit comments, auto-inference, backward compatibility, no-connection fallback, recursion, and chaining
- Agent skill files updated to instruct agents to always provide assistance comments

## Task Commits

Each task was committed atomically:

1. **Task 1 (RED): Failing tests for assistance comments** - `c9fb350` (test)
2. **Task 1 (GREEN): Implement assistance comment population** - `64f41d8` (feat)
3. **Task 2: Update agent skill files** - `0ac3df2` (docs)

_Note: Task 1 used TDD with RED-GREEN commits._

## Files Created/Modified
- `src/maxpat/patcher.py` - Added inlet_comments/outlet_comments params to add_subpatcher, added populate_assistance_comments() and _populate_comments_recursive() methods
- `tests/test_patcher.py` - Added TestAssistanceComments class with 10 tests
- `.claude/skills/max-patch-agent/SKILL.md` - Updated Key Functions list and added Assistance Comments section
- `.claude/skills/max-dsp-agent/SKILL.md` - Added Assistance Comments section with DSP-focused example

## Decisions Made
- Signal prefix heuristic: use "signal" if inlet/outlet or connected object name ends with ~, otherwise "data" -- simple and correct for the common case
- Positional fallback uses 1-indexed ("inlet 1", "outlet 2") to match MAX UI conventions where inlets/outlets are numbered starting from 1
- Static recursive helper _populate_comments_recursive() keeps the public API clean with just populate_assistance_comments() returning self for chaining

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

None.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness
- Assistance comment functionality is complete and tested
- Agents are instructed to use the new parameters going forward
- No blockers

## Self-Check: PASSED

All 4 files verified on disk. All 3 task commits verified in git history.

---
*Phase: quick-260318-ujk*
*Completed: 2026-03-19*
