---
phase: quick-260321-6mo
plan: 01
subsystem: commands
tags: [slash-commands, workflow, max-iterate, discuss, research]

# Dependency graph
requires:
  - phase: 17-commands
    provides: /max-iterate, /max-discuss, /max-research slash commands
provides:
  - "--full, --discuss, --research, --plan flags for /max-iterate pipeline"
affects: [max-iterate, max-discuss, max-research]

# Tech tracking
tech-stack:
  added: []
  patterns: ["composable flag parsing in slash command specs", "conditional pipeline phases gated by boolean flags"]

key-files:
  created: []
  modified: [".claude/commands/max-iterate.md"]

key-decisions:
  - "Flags parsed after inline project switch but before project load (step 2)"
  - "--full expands to all three sub-flags (discuss + research + plan) for convenience"
  - "Each conditional phase appends to context.md, building cumulative context for the build phase"
  - "--plan flag included as independent option (not just part of --full)"

patterns-established:
  - "Composable flags: individual flags combinable, --full as shorthand for all"
  - "Conditional pipeline phases: steps gated by boolean flags, skipped entirely when absent"

requirements-completed: [ITERATE-FULL-FLAG]

# Metrics
duration: 3min
completed: 2026-03-21
---

# Quick Task 260321-6mo: Add --full Flag to /max-iterate Summary

**Composable --full/--discuss/--research/--plan flags for /max-iterate enabling discuss-research-plan pipeline before patch edits**

## Performance

- **Duration:** 3 min
- **Started:** 2026-03-21T11:49:53Z
- **Completed:** 2026-03-21T11:52:28Z
- **Tasks:** 1
- **Files modified:** 1

## Accomplishments
- Added flag parsing step (step 2) that strips --full, --discuss, --research, --plan from change description
- Added three conditional pipeline phases: discuss (step 7), research (step 8), plan (step 9)
- Added Flags table documenting composable behavior and flag semantics
- Updated examples section with flag usage patterns for all combinations
- Renumbered original 15 steps to 19 steps with zero behavioral change when no flags present

## Task Commits

Each task was committed atomically:

1. **Task 1: Add flag parsing and full pipeline to max-iterate.md** - `491bdd0` (feat)

## Files Created/Modified
- `.claude/commands/max-iterate.md` - Added flag parsing, 3 conditional pipeline phases, Flags table, updated examples

## Decisions Made
- Flags parsed after inline project switch but before project load -- ensures project context is available for all pipeline phases
- --full expands to discuss + research + plan (all three) as a convenience shorthand
- --plan included as an independent flag, not just part of --full, for users who want structured planning without discussion
- Each conditional phase appends to context.md to build cumulative context for the build phase
- Discuss phase is interactive (waits for user), research and plan phases present findings then proceed

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered
None

## User Setup Required
None - no external service configuration required.

## Next Phase Readiness
- /max-iterate now supports the full discuss-research-plan pipeline via --full flag
- The --discuss and --research phases reference the same protocols as /max-discuss and /max-research
- No code changes needed -- this is a command spec update only

## Self-Check: PASSED

- FOUND: .claude/commands/max-iterate.md
- FOUND: .planning/quick/260321-6mo-add-full-flag-to-max-iterate-for-discuss/260321-6mo-SUMMARY.md
- FOUND: commit 491bdd0

---
*Phase: quick-260321-6mo*
*Completed: 2026-03-21*
