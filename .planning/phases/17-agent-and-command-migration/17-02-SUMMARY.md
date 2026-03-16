---
phase: 17-agent-and-command-migration
plan: 02
subsystem: commands
tags: [slash-commands, max-build, max-iterate, max-new, max-onboard, direct-editing]

# Dependency graph
requires:
  - phase: 16-patch-analysis
    provides: "patcher.analyze() with 7-facet structural analysis"
  - phase: 13-round-trip-fidelity
    provides: "read_patch, save_patch_roundtrip for lossless editing"
  - phase: 14-search-and-edit-primitives
    provides: "find_box, modify_box, replace_box, insert_into_connection, remove_box"
  - phase: 15-advanced-graph-ops
    provides: "connected_components, signal_path for section rebuild scope"
provides:
  - "Updated /max-build documenting direct Patcher -> generate_patch -> write_patch workflow"
  - "Rewritten /max-iterate with analyze-first protocol and dual edit strategy"
  - "Updated /max-new with empty .maxpat creation on project scaffolding"
  - "New /max-onboard command for read_patch + analyze on any .maxpat"
  - "9 new test assertions for v2.0 API patterns in command files"
affects: [17-agent-and-command-migration, 18-cleanup]

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "Analyze-first protocol: always run analyze() before edits in /max-iterate"
    - "Dual save paths: write_patch for new, save_patch_roundtrip for edits"
    - "Existing-file guard: /max-build warns before overwriting .maxpat"

key-files:
  created:
    - ".claude/commands/max-onboard.md"
  modified:
    - ".claude/commands/max-build.md"
    - ".claude/commands/max-iterate.md"
    - ".claude/commands/max-new.md"
    - "tests/test_commands.py"

key-decisions:
  - "/max-build checks for existing .maxpat and offers overwrite or redirect to /max-iterate"
  - "/max-iterate uses transparent strategy selection: surgical edit for small changes, section rebuild for larger structural changes"
  - "/max-onboard offers next steps after analysis: create project, start iterating, or just review"

patterns-established:
  - "Command files document Python Modules section with exact import statements"
  - "New commands follow existing frontmatter schema (name, description, argument-hint)"

requirements-completed: [MG-01, MG-02, MG-03, MG-04]

# Metrics
duration: 3min
completed: 2026-03-16
---

# Phase 17 Plan 02: Slash Command Rewrite Summary

**Four slash commands rewritten for direct .maxpat editing: /max-build uses Patcher -> write_patch, /max-iterate uses analyze-first + read_patch/save_patch_roundtrip, /max-new creates empty .maxpat, new /max-onboard runs read_patch + analyze**

## Performance

- **Duration:** 3 min
- **Started:** 2026-03-16T21:58:54Z
- **Completed:** 2026-03-16T22:01:42Z
- **Tasks:** 2
- **Files modified:** 5

## Accomplishments
- Rewrote /max-build to document direct Patcher API flow with no generate.py references
- Rewrote /max-iterate with full analyze-first protocol, dual edit strategy, and save_patch_roundtrip
- Updated /max-new to document empty .maxpat creation on project scaffolding
- Created new /max-onboard command for analyzing any .maxpat file
- Added 9 new test assertions covering v2.0 API patterns across all 4 commands

## Task Commits

Each task was committed atomically:

1. **Task 1: Update test_commands.py with v2.0 assertions** - `a0bce37` (test)
2. **Task 2: Rewrite command files for v2.0 workflow** - `b6185ac` (feat)

## Files Created/Modified
- `tests/test_commands.py` - Added max-onboard to ALL_COMMANDS, 9 new v2.0 cross-reference tests
- `.claude/commands/max-build.md` - Rewritten for Patcher -> generate_patch -> write_patch, existing-file guard
- `.claude/commands/max-iterate.md` - Full rewrite with analyze-first protocol, surgical/section rebuild strategy
- `.claude/commands/max-new.md` - Added empty .maxpat creation step, no generate.py note
- `.claude/commands/max-onboard.md` - New command using read_patch + analyze for any .maxpat

## Decisions Made
- /max-build checks for existing .maxpat before creating, offering overwrite or redirect to /max-iterate
- /max-iterate transparently explains its edit strategy choice to the user before executing
- /max-onboard offers three next steps after analysis: create project, start iterating, or just review

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

None.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness
- All 4 slash commands document the v2.0 direct editing workflow
- Ready for Plan 17-03 (agent SKILL.md updates) which documents the same APIs from the specialist agent perspective
- All 73 test_commands.py tests pass (64 existing + 9 new)

## Self-Check: PASSED

All 5 created/modified files verified on disk. Both task commits (a0bce37, b6185ac) verified in git log.

---
*Phase: 17-agent-and-command-migration*
*Completed: 2026-03-16*
