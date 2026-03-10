---
phase: 06-fix-skill-documentation-signatures
plan: 01
subsystem: documentation
tags: [skill-docs, api-signatures, agent-prompts, gap-closure]

# Dependency graph
requires:
  - phase: 05-rnbo-and-external-development
    provides: Full agent SKILL.md files and Python API surface
provides:
  - Correct API signatures in all 3 specialist agent SKILL.md files
  - Correct import paths in max-verify.md command
  - 8 signature-accuracy regression tests
affects: [max-patch-agent, max-dsp-agent, max-js-agent, max-verify]

# Tech tracking
tech-stack:
  added: []
  patterns: [documentation-source verification via pytest]

key-files:
  created: []
  modified:
    - tests/test_agent_skills.py
    - .claude/skills/max-patch-agent/SKILL.md
    - .claude/skills/max-dsp-agent/SKILL.md
    - .claude/skills/max-js-agent/SKILL.md
    - .claude/commands/max-verify.md

key-decisions:
  - "TDD approach: wrote 8 failing tests first, then fixed all 9 mismatches to make them pass"
  - "Used from src.maxpat import (public API) for max-verify.md imports, not internal module paths"

patterns-established:
  - "Signature-accuracy tests: each SKILL.md has corresponding tests asserting correct function signatures"

requirements-completed: [AGT-01, FRM-02]

# Metrics
duration: 3min
completed: 2026-03-10
---

# Phase 6 Plan 1: Fix Skill Documentation Signatures Summary

**Corrected 9 API signature mismatches across 3 SKILL.md files and max-verify.md, with 8 regression tests proving accuracy against actual Python API**

## Performance

- **Duration:** 3 min
- **Started:** 2026-03-10T20:14:57Z
- **Completed:** 2026-03-10T20:18:25Z
- **Tasks:** 2
- **Files modified:** 5

## Accomplishments
- All 9 API signature mismatches from DOC-SIG-01 audit gap are fixed
- 8 new signature-accuracy tests prevent future regressions
- Full test suite passes (621 tests)
- Integration gap DOC-SIG-01 is now closed

## Task Commits

Each task was committed atomically:

1. **Task 1: Add signature-accuracy tests** - `da6635c` (test) -- TDD RED: 8 failing tests
2. **Task 2: Fix all signature mismatches** - `cd9b696` (fix) -- TDD GREEN: all 8 tests pass

_TDD approach: tests written first (RED), documentation fixed to pass (GREEN)_

## Files Created/Modified
- `tests/test_agent_skills.py` - Added 8 signature-accuracy tests and COMMANDS_DIR constant + _read_command helper
- `.claude/skills/max-patch-agent/SKILL.md` - Fixed add_connection (was connect) and write_patch(patcher) (was patch_dict)
- `.claude/skills/max-dsp-agent/SKILL.md` - Fixed build_genexpr param order, add_gen (removed name param), generate_gendsp params
- `.claude/skills/max-js-agent/SKILL.md` - Fixed generate_n4m_script (dict_access not options) and generate_js_script (num_inlets first)
- `.claude/commands/max-verify.md` - Fixed import paths to use src.maxpat public API

## Decisions Made
- Used TDD approach: wrote 8 failing tests first, then fixed documentation to make them pass
- Used `from src.maxpat import` (public API) for max-verify.md imports rather than internal module paths (src.maxpat.hooks)
- Combined validate_file and validate_code_file into single import line for cleanliness

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered
None

## User Setup Required
None - no external service configuration required.

## Next Phase Readiness
- All documentation now matches actual Python API
- Claude agents will generate correct function calls when referencing SKILL.md files
- Regression tests prevent future signature drift

---
*Phase: 06-fix-skill-documentation-signatures*
*Completed: 2026-03-10*
