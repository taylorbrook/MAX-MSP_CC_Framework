---
phase: quick-260322-eva
plan: 01
subsystem: agent-system
tags: [memory, cleanup, dead-code-removal, skills, commands]

# Dependency graph
requires: []
provides:
  - Clean agent skill/command files with zero memory references
  - Removed 10 empty .max-memory/ directories from patches/
  - Simplified project scaffolding (no .max-memory/ created)
affects: [max-build, max-iterate, max-router, all-specialist-agents]

# Tech tracking
tech-stack:
  added: []
  patterns:
    - Claude built-in project memory replaces in-app memory system entirely

key-files:
  created: []
  modified:
    - .claude/commands/max-build.md
    - .claude/commands/max-iterate.md
    - .claude/skills/max-router/SKILL.md
    - .claude/skills/max-dsp-agent/SKILL.md
    - .claude/skills/max-patch-agent/SKILL.md
    - .claude/skills/max-ui-agent/SKILL.md
    - .claude/skills/max-js-agent/SKILL.md
    - .claude/skills/max-critic/SKILL.md
    - .claude/skills/max-lifecycle/SKILL.md
    - .claude/skills/max-lifecycle/references/project-structure.md
    - src/maxpat/project.py
    - tests/test_commands.py
    - tests/test_agent_skills.py
    - tests/test_project.py

key-decisions:
  - "Python memory module (src/maxpat/memory.py) and its tests kept intact -- only agent/command/scaffold wiring removed"

patterns-established: []

requirements-completed: []

# Metrics
duration: 4min
completed: 2026-03-22
---

# Quick Task 260322-eva: Retire the In-App Memory System Summary

**Removed dead max-memory-agent skill, /max-memory command, 10 empty .max-memory/ directories, and all memory references from commands/skills**

## Performance

- **Duration:** 4 min
- **Started:** 2026-03-22T17:47:29Z
- **Completed:** 2026-03-22T17:51:33Z
- **Tasks:** 2
- **Files modified:** 27 (23 deleted + 4 edited in code/tests)

## Accomplishments
- Deleted max-memory-agent skill directory (SKILL.md + BOUNDARIES.md) and /max-memory command
- Deleted all 10 .max-memory/ directories from patches/ (all contained 0 learned entries)
- Stripped memory injection/write-back steps from max-build (steps 3 and 8) and max-iterate (step 18)
- Removed memory context loading from router and all 4 specialist agents (dsp, patch, ui, js)
- Removed memory references from critic and lifecycle "When NOT to Use" sections
- Updated project.py to stop scaffolding .max-memory/ directories
- Updated all 3 test files to remove memory-related tests and list entries
- All 266 tests pass (244 command/skill/project + 22 memory module tests)

## Task Commits

1. **Task 1: Delete memory agent files and remove all memory references** - `fc0cfea` (chore)
2. **Task 2: Update project.py scaffolding and fix tests** - `b4d20a3` (fix)

## Files Created/Modified

**Deleted:**
- `.claude/skills/max-memory-agent/SKILL.md` - Memory agent skill definition
- `.claude/skills/max-memory-agent/BOUNDARIES.md` - Memory agent boundaries
- `.claude/commands/max-memory.md` - Memory command
- `patches/*/.max-memory/patterns.md` - 10 empty pattern files

**Modified:**
- `.claude/commands/max-build.md` - Removed memory inject/write-back steps, memory import
- `.claude/commands/max-iterate.md` - Removed memory write-back step, memory import
- `.claude/skills/max-router/SKILL.md` - Removed memory loading from context, capabilities, output protocol
- `.claude/skills/max-dsp-agent/SKILL.md` - Removed memory context loading steps 6-7
- `.claude/skills/max-patch-agent/SKILL.md` - Removed memory context loading steps 6-7
- `.claude/skills/max-ui-agent/SKILL.md` - Removed memory context loading steps 3-4
- `.claude/skills/max-js-agent/SKILL.md` - Removed memory context loading steps 2-3
- `.claude/skills/max-critic/SKILL.md` - Removed memory agent from "When NOT to Use"
- `.claude/skills/max-lifecycle/SKILL.md` - Removed memory agent from "When NOT to Use"
- `.claude/skills/max-lifecycle/references/project-structure.md` - Removed .max-memory from layout
- `src/maxpat/project.py` - Removed .max-memory dir creation and patterns.md init
- `tests/test_commands.py` - Removed max-memory from command list and memory test
- `tests/test_agent_skills.py` - Removed max-memory-agent from skill list and memory tests
- `tests/test_project.py` - Removed .max-memory assertions from create_project test

## Decisions Made
- Python memory module (src/maxpat/memory.py) and tests/test_memory.py kept intact as instructed -- only agent/command/scaffold wiring removed

## Deviations from Plan
None - plan executed exactly as written.

## Issues Encountered
None.

## User Setup Required
None - no external service configuration required.

## Known Stubs
None.

## Self-Check: PASSED

- All 15 key files verified present on disk
- Commits fc0cfea and b4d20a3 verified in git log
- 266 tests pass (244 command/skill/project + 22 memory)
- Zero max-memory references in .claude/ directory
- Zero .max-memory directories in patches/
- src/maxpat/memory.py intact

---
*Phase: quick-260322-eva*
*Completed: 2026-03-22*
