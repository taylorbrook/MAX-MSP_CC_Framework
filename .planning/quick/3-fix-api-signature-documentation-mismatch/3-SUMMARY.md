---
phase: quick-3
plan: 01
subsystem: docs
tags: [api-signatures, skill-docs, disambiguation, agent-context]

requires:
  - phase: quick-2
    provides: Agent effectiveness review identifying doc mismatches
provides:
  - Correct function signatures in all agent SKILL.md files
  - Complete function listings for patch-agent and dsp-agent
  - Router disambiguation for ambiguous terms (filter, buffer, delay)
affects: [max-lifecycle, max-critic, max-patch-agent, max-dsp-agent, max-router]

tech-stack:
  added: []
  patterns:
    - "All documented function signatures must exactly match Python source definitions"

key-files:
  created: []
  modified:
    - .claude/skills/max-critic/SKILL.md
    - .claude/skills/max-critic/references/critic-protocol.md
    - .claude/skills/max-patch-agent/SKILL.md
    - .claude/skills/max-dsp-agent/SKILL.md
    - .claude/skills/max-router/references/dispatch-rules.md

key-decisions:
  - "Lifecycle SKILL.md and test-protocol.md already had correct signatures -- verified rather than re-applied"
  - "write_gendsp documented with explicit import source note (src.maxpat.hooks) to prevent import confusion"

patterns-established:
  - "Doc sync: function signatures in SKILL.md must match source code exactly"

requirements-completed: [DOC-SYNC]

duration: 3min
completed: 2026-03-12
---

# Quick Task 3: Fix API Signature Documentation Mismatch Summary

**Corrected function signatures across 5 agent docs, added 5 missing functions, and added 7 disambiguation rows to router dispatch rules**

## Performance

- **Duration:** 3 min
- **Started:** 2026-03-12T16:36:40Z
- **Completed:** 2026-03-12T16:39:38Z
- **Tasks:** 3
- **Files modified:** 5

## Accomplishments
- Fixed review_patch signature in critic SKILL.md to include ext_code and ext_archetype params
- Documented all 4 critic modules (DSP, structure, RNBO, external) in critic-protocol.md
- Added 4 missing Patcher methods (add_comment, add_message, add_node_script, add_js) to patch-agent SKILL.md
- Added write_gendsp with import source to dsp-agent SKILL.md
- Added 7 disambiguation rows for filter/buffer/delay terms to router dispatch-rules.md

## Task Commits

Each task was committed atomically:

1. **Task 1: Fix function signatures in lifecycle and critic docs** - `d0f445b` (fix)
2. **Task 2: Add missing functions to patch-agent and dsp-agent SKILL.md** - `f4a0a9f` (feat)
3. **Task 3: Add disambiguation rows to router dispatch-rules.md** - `74e6c77` (feat)

## Files Created/Modified
- `.claude/skills/max-critic/SKILL.md` - Added ext_code/ext_archetype to review_patch signature, RNBO/external critic notes
- `.claude/skills/max-critic/references/critic-protocol.md` - Documented all 4 critic modules, updated code example with full signature
- `.claude/skills/max-patch-agent/SKILL.md` - Added add_comment, add_message, add_node_script, add_js functions
- `.claude/skills/max-dsp-agent/SKILL.md` - Added write_gendsp with import source and params
- `.claude/skills/max-router/references/dispatch-rules.md` - Added 7 disambiguation rows and explanatory paragraph

## Decisions Made
- Lifecycle files (SKILL.md and test-protocol.md) already contained correct signatures from prior work -- verified correct rather than duplicating changes
- Documented write_gendsp with explicit import source note (from src.maxpat.hooks, not src.maxpat.patcher) to prevent agent import confusion

## Deviations from Plan

None - plan executed exactly as written. The lifecycle files were already correct (signatures had been fixed in a prior commit), so those edits were no-ops verified by automated checks.

## Issues Encountered
- Xcode license agreement blocking system git -- resolved by using homebrew git at /opt/homebrew/bin/git

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness
- All agent SKILL.md files now have accurate function signatures
- Router can disambiguate filter/buffer/delay terms between data and audio domains
- Ready for any future agent invocations with correct API context

## Self-Check: PASSED

All 5 modified files exist on disk. All 3 task commits (d0f445b, f4a0a9f, 74e6c77) verified in git log.
