---
phase: quick-260322-fee
plan: 01
subsystem: skills
tags: [deduplication, agent-skills, shared-capabilities]

provides:
  - "Single-source-of-truth for shared agent capability blocks"
  - "Reference directive pattern for SKILL.md deduplication"
affects: [max-patch-agent, max-dsp-agent, max-rnbo-agent, max-js-agent, max-ext-agent, max-ui-agent]

key-files:
  created:
    - ".claude/skills/references/shared-capabilities.md"
  modified:
    - ".claude/skills/max-patch-agent/SKILL.md"
    - ".claude/skills/max-dsp-agent/SKILL.md"
    - ".claude/skills/max-rnbo-agent/SKILL.md"
    - ".claude/skills/max-js-agent/SKILL.md"
    - ".claude/skills/max-ext-agent/SKILL.md"
    - ".claude/skills/max-ui-agent/SKILL.md"
    - "tests/test_agent_skills.py"

key-decisions:
  - "Use blockquote reference directive format for SKILL.md cross-references"
  - "Shared file uses patch-agent version as canonical source for Assistance Comments"
  - "Tests combine SKILL.md + shared file via _read_skill_with_shared() helper"

patterns-established:
  - "Shared capabilities reference: duplicated agent blocks extracted to .claude/skills/references/"

requirements-completed: [DEDUP-01]

duration: 4min
completed: 2026-03-22
---

# Quick Task 260322-fee: Extract Duplicated Content Blocks Summary

**Extracted 5 shared content blocks (~53 lines each) from 6 SKILL.md files into shared-capabilities.md, eliminating 249 lines of duplication**

## Performance

- **Duration:** 4 min
- **Started:** 2026-03-22T18:09:29Z
- **Completed:** 2026-03-22T18:14:21Z
- **Tasks:** 2
- **Files modified:** 8

## Accomplishments
- Created `.claude/skills/references/shared-capabilities.md` with 67 lines covering Assistance Comments, Aesthetic Capabilities, Layout Options, Editing Functions, and Edit Workflow
- Reduced 6 SKILL.md files by 48-55 lines each (total 249 lines removed)
- Updated 9 content-checking tests + added 2 new tests; all 139 tests pass

## Task Commits

1. **Task 1: Create shared-capabilities.md and update SKILL.md files** - `63d3821` (refactor)
2. **Task 2: Update tests to validate shared reference pattern** - `4f324a2` (test)

## Files Created/Modified
- `.claude/skills/references/shared-capabilities.md` - Canonical source for 5 shared agent capability blocks
- `.claude/skills/max-patch-agent/SKILL.md` - Replaced 55 lines with reference directive
- `.claude/skills/max-dsp-agent/SKILL.md` - Replaced 55 lines with reference directive
- `.claude/skills/max-rnbo-agent/SKILL.md` - Replaced 55 lines with reference directive
- `.claude/skills/max-js-agent/SKILL.md` - Replaced 48 lines with reference directive (no Assistance Comments block)
- `.claude/skills/max-ext-agent/SKILL.md` - Replaced 48 lines with reference directive (no Assistance Comments block)
- `.claude/skills/max-ui-agent/SKILL.md` - Replaced 55 lines with reference directive
- `tests/test_agent_skills.py` - Added shared file helper, 2 new tests, updated 9 tests

## Decisions Made
- Used blockquote reference directive format (`> **Shared Capabilities:** See ...`) for clean inline references
- Shared file uses patch-agent's Assistance Comments example as canonical (most complete version)
- Edit Workflow uses generic placeholders (`target_object`, `new_value`) instead of domain-specific examples
- Tests concatenate SKILL.md + shared file to simulate full agent context at read time

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

None.

## Known Stubs

None.

---
*Phase: quick-260322-fee*
*Completed: 2026-03-22*
