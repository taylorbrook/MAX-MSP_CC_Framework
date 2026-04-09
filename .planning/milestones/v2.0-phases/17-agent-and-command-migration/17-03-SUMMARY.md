---
phase: 17-agent-and-command-migration
plan: 03
subsystem: agent-skills
tags: [skill-md, editing-api, dual-workflow, read-patch, find-box, modify-box]

# Dependency graph
requires:
  - phase: 15-mutation-primitives
    provides: "Editing API methods (find_box, modify_box, replace_box, etc.)"
  - phase: 16-patch-analysis
    provides: "patcher.analyze() for 7-facet patch summary"
provides:
  - "All 9 agent SKILL.md files document dual workflow (create-new + edit-existing)"
  - "32 new test assertions for editing API references"
affects: [17-01, 17-02]

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "Dual Output Protocol pattern: (New Patches) vs (Edited Patches) sections"
    - "Domain-specific edit focus notes per specialist agent"

key-files:
  created: []
  modified:
    - ".claude/skills/max-patch-agent/SKILL.md"
    - ".claude/skills/max-dsp-agent/SKILL.md"
    - ".claude/skills/max-rnbo-agent/SKILL.md"
    - ".claude/skills/max-js-agent/SKILL.md"
    - ".claude/skills/max-ext-agent/SKILL.md"
    - ".claude/skills/max-ui-agent/SKILL.md"
    - ".claude/skills/max-lifecycle/SKILL.md"
    - ".claude/skills/max-router/SKILL.md"
    - ".claude/skills/max-critic/SKILL.md"
    - "tests/test_agent_skills.py"

key-decisions:
  - "Editing section placed after Aesthetic Capabilities, before Output Protocol -- keeps aesthetic/styling context accessible during edits"
  - "Output Protocol split into (New Patches) and (Edited Patches) subsections for clarity"
  - "Domain focus notes use distinct examples per agent (route for patch, cycle~ for DSP, rnbo~ for RNBO, etc.)"

patterns-established:
  - "Agent SKILL.md dual workflow: every specialist documents both create and edit paths"
  - "Edit workflow always ends with save_patch_roundtrip, never write_patch or apply_layout"

requirements-completed: [MG-05]

# Metrics
duration: 3min
completed: 2026-03-16
---

# Phase 17 Plan 03: Agent SKILL.md Dual Workflow Summary

**All 9 agent SKILL.md files updated with editing API documentation (read_patch, find_box, modify_box, save_patch_roundtrip) and dual output protocols**

## Performance

- **Duration:** 3 min
- **Started:** 2026-03-16T21:58:59Z
- **Completed:** 2026-03-16T22:02:07Z
- **Tasks:** 2
- **Files modified:** 10

## Accomplishments
- Added 32 new test assertions across 7 test functions for editing API coverage
- All 6 specialist agents now document the dual workflow: create-new (via Patcher + generate_patch + write_patch) and edit-existing (via read_patch + find_box + modify_box + save_patch_roundtrip)
- Orchestration agents updated: lifecycle references empty .maxpat, router references analysis context for /max-iterate, critic references save_patch_roundtrip for edit path
- Full test suite green: 1176 tests pass including 138 agent skill tests

## Task Commits

Each task was committed atomically:

1. **Task 1: Add editing API tests** - `a0bce37` (test)
2. **Task 2: Update all 9 SKILL.md files** - `ff417a0` (feat)

## Files Created/Modified
- `tests/test_agent_skills.py` - 7 new test functions with 32 assertions for editing API references
- `.claude/skills/max-patch-agent/SKILL.md` - Editing section + dual output protocol
- `.claude/skills/max-dsp-agent/SKILL.md` - Editing section + dual output protocol
- `.claude/skills/max-rnbo-agent/SKILL.md` - Editing section + dual output protocol
- `.claude/skills/max-js-agent/SKILL.md` - Editing section + dual output protocol
- `.claude/skills/max-ext-agent/SKILL.md` - Editing section + dual output protocol
- `.claude/skills/max-ui-agent/SKILL.md` - Editing section + dual output protocol
- `.claude/skills/max-lifecycle/SKILL.md` - Empty .maxpat creation reference
- `.claude/skills/max-router/SKILL.md` - /max-iterate analysis context routing
- `.claude/skills/max-critic/SKILL.md` - Edit workflow save path (save_patch_roundtrip)

## Decisions Made
- Editing section placed after Aesthetic Capabilities, before Output Protocol -- keeps aesthetic/styling context accessible during edits
- Output Protocol split into (New Patches) and (Edited Patches) subsections for clarity
- Domain focus notes use distinct examples per agent (route for patch, cycle~ for DSP, rnbo~ for RNBO, etc.)

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

None.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness
- All agent skills now document both create and edit workflows
- Plans 17-01 and 17-02 (command files) can reference these SKILL.md files for consistent API documentation
- Ready for command migration to reference the editing API

## Self-Check: PASSED

All 11 files verified present. Both commit hashes (a0bce37, ff417a0) confirmed in git log.

---
*Phase: 17-agent-and-command-migration*
*Completed: 2026-03-16*
