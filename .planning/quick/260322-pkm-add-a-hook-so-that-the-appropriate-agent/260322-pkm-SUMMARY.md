---
phase: quick-260322-pkm
plan: 01
subsystem: hooks
tags: [layout, finalize, agents, skill-md]

requires: []
provides:
  - finalize_patch() hook function in src/maxpat/hooks.py
  - Centralized layout cleanup for all agent workflows
affects: [max-patch-agent, max-dsp-agent, max-ui-agent, max-js-agent, max-ext-agent, max-rnbo-agent]

tech-stack:
  added: []
  patterns: [single-hook finalization pattern, circular import avoidance via aesthetics.py]

key-files:
  created: []
  modified:
    - src/maxpat/hooks.py
    - src/maxpat/__init__.py
    - src/maxpat/aesthetics.py
    - tests/test_hooks.py
    - .claude/skills/max-patch-agent/SKILL.md
    - .claude/skills/max-dsp-agent/SKILL.md
    - .claude/skills/max-ui-agent/SKILL.md
    - .claude/skills/max-js-agent/SKILL.md
    - .claude/skills/max-ext-agent/SKILL.md
    - .claude/skills/max-rnbo-agent/SKILL.md
    - .claude/skills/references/shared-capabilities.md

key-decisions:
  - "Moved _apply_auto_styling and _AUTO_HIGHLIGHT from __init__.py to aesthetics.py to avoid circular imports; kept backward compat alias in __init__.py"
  - "finalize_patch edit flow clears midpoints before regenerating to ensure clean cable routing"

patterns-established:
  - "Single-call finalize_patch hook: agents call one function instead of manually orchestrating styling/layout/comments"

requirements-completed: [QUICK-PKM]

duration: 4min
completed: 2026-03-22
---

# Quick Task 260322-pkm: finalize_patch() Hook Summary

**finalize_patch() hook centralizing layout cleanup, midpoint generation, and assistance comments into a single call for all agent workflows**

## Performance

- **Duration:** 4 min
- **Started:** 2026-03-23T01:30:40Z
- **Completed:** 2026-03-23T01:35:00Z
- **Tasks:** 3
- **Files modified:** 11

## Accomplishments
- Created `finalize_patch(patcher, is_new=True)` in hooks.py with dual-mode behavior
- Moved `_apply_auto_styling` to aesthetics.py to avoid circular imports (backward compat preserved)
- Updated all 7 agent/reference SKILL.md files to use finalize_patch in Output Protocols
- 5 new tests covering both flows, subpatcher recursion, midpoint generation, and importability

## Task Commits

Each task was committed atomically:

1. **Task 1 (RED): Add failing tests** - `ec359f9` (test)
2. **Task 1 (GREEN): Implement finalize_patch()** - `c8c9b2d` (feat)
3. **Task 2: Update agent SKILL.md files** - `442853f` (docs)

_Task 3 was verification-only (no code changes)._

## Files Created/Modified
- `src/maxpat/hooks.py` - Added finalize_patch() and _finalize_midpoints_recursive()
- `src/maxpat/__init__.py` - Re-export finalize_patch, import apply_auto_styling from aesthetics
- `src/maxpat/aesthetics.py` - Added apply_auto_styling() and _AUTO_HIGHLIGHT (moved from __init__)
- `tests/test_hooks.py` - 5 new TestFinalizePatch tests
- `.claude/skills/max-patch-agent/SKILL.md` - New/Edit protocols use finalize_patch
- `.claude/skills/max-dsp-agent/SKILL.md` - New/Edit protocols use finalize_patch
- `.claude/skills/max-ui-agent/SKILL.md` - Edit protocol uses finalize_patch
- `.claude/skills/max-js-agent/SKILL.md` - Edit protocol uses finalize_patch
- `.claude/skills/max-ext-agent/SKILL.md` - Edit protocol uses finalize_patch
- `.claude/skills/max-rnbo-agent/SKILL.md` - Edit protocol uses finalize_patch
- `.claude/skills/references/shared-capabilities.md` - Added Patch Finalization section

## Decisions Made
- Moved `_apply_auto_styling` and `_AUTO_HIGHLIGHT` from `__init__.py` to `aesthetics.py` to avoid circular imports when hooks.py needs auto-styling. Backward compat alias `_apply_auto_styling = apply_auto_styling` kept in `__init__.py`.
- Edit-mode finalize clears all existing midpoints before regenerating to ensure clean cable routing after edits.

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] Fixed test using add_subpatcher return type**
- **Found during:** Task 1 (TDD GREEN)
- **Issue:** Test assumed `add_subpatcher` returns a Box, but it returns `(Box, Patcher)` tuple
- **Fix:** Unpacked tuple correctly: `sub_box, inner = p.add_subpatcher(...)`
- **Files modified:** tests/test_hooks.py
- **Verification:** Test passes
- **Committed in:** c8c9b2d

---

**Total deviations:** 1 auto-fixed (1 bug)
**Impact on plan:** Trivial test fix. No scope creep.

## Issues Encountered
- Pre-existing test failure `test_patch_agent_references_max_objects` checks for `"max/"` literal string in patch agent SKILL.md -- unrelated to this task, not fixed.

## User Setup Required
None - no external service configuration required.

## Next Phase Readiness
- finalize_patch is ready for use by all agents in /max-build and /max-iterate workflows
- No blockers

## Self-Check: PASSED

All 11 files verified present. All 3 commits verified in git log.

---
*Phase: quick-260322-pkm*
*Completed: 2026-03-22*
