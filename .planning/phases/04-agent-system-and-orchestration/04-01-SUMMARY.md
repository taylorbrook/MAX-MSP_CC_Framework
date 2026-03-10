---
phase: 04-agent-system-and-orchestration
plan: 01
subsystem: validation
tags: [critics, dsp, structure, gain-staging, gen~, fan-out, hot-cold]

# Dependency graph
requires:
  - phase: 03-code-generation
    provides: parse_genexpr_io for gen~ I/O detection
  - phase: 02-patch-generation
    provides: validation.py pipeline, patcher data model, .maxpat format
provides:
  - review_patch() public API combining DSP and structure critics
  - CriticResult dataclass with severity/finding/suggestion
  - review_dsp() checking gen~ I/O, gain staging, audio rate consistency
  - review_structure() checking fan-out, hot/cold ordering, duplicate connections
affects: [04-05-PLAN, agent-skills, generator-critic-loops]

# Tech tracking
tech-stack:
  added: []
  patterns: [critic-pattern, BFS-gain-tracking, adjacency-based-fan-out]

key-files:
  created:
    - src/maxpat/critics/__init__.py
    - src/maxpat/critics/base.py
    - src/maxpat/critics/dsp_critic.py
    - src/maxpat/critics/structure_critic.py
    - tests/test_critics.py
  modified: []

key-decisions:
  - "Control-to-signal check only flags inlet 0 to reduce false positives (secondary inlets often accept float)"
  - "Signal connections exempted from fan-out and hot/cold checks (all hot in audio domain per Rule #3)"
  - "gen~ I/O check supports both embedded codebox and external code_context dict"
  - "CriticResult uses __slots__ for lightweight instances matching ValidationResult pattern"

patterns-established:
  - "Critic pattern: separate review_*() functions per domain, combined via review_patch()"
  - "BFS with state tracking for gain staging path analysis"
  - "Adjacency counting per (source_id, outlet) for fan-out detection"

requirements-completed: [AGT-03, AGT-04, AGT-05]

# Metrics
duration: 5min
completed: 2026-03-10
---

# Phase 4 Plan 01: Critic System Summary

**DSP and structure critics catching gen~ I/O mismatches, missing gain staging, fan-out without trigger, and hot/cold ordering issues via review_patch() API**

## Performance

- **Duration:** 5 min
- **Started:** 2026-03-10T15:11:51Z
- **Completed:** 2026-03-10T15:17:08Z
- **Tasks:** 2
- **Files created:** 5

## Accomplishments
- DSP critic catches gen~ I/O mismatches (blocker), missing gain staging (warning), and control-to-signal rate issues (warning)
- Structure critic catches fan-out without trigger (warning), hot/cold ordering issues (warning), and duplicate patchlines (warning)
- review_patch() combines both critics into a single API call returning CriticResult list
- 18 comprehensive tests covering all check types with positive and negative cases

## Task Commits

Each task was committed atomically:

1. **Task 1: Create critic base and DSP critic** - `a3ba2fa` (test: RED) -> `79075bf` (feat: GREEN)
2. **Task 2: Create structure critic** - `48bb7de` (test: RED) -> `55dad46` (feat: GREEN)

_TDD workflow: each task has test commit (RED) then implementation commit (GREEN)_

## Files Created/Modified
- `src/maxpat/critics/__init__.py` - Public API: review_patch() combining both critics, exports CriticResult
- `src/maxpat/critics/base.py` - CriticResult dataclass with severity/finding/suggestion and __repr__
- `src/maxpat/critics/dsp_critic.py` - review_dsp() with gen~ I/O match, gain staging BFS, audio rate consistency
- `src/maxpat/critics/structure_critic.py` - review_structure() with fan-out detection, hot/cold ordering, duplicate patchlines
- `tests/test_critics.py` - 18 tests with patch_dict fixtures for all critic checks

## Decisions Made
- Control-to-signal rate check only flags inlet 0 (primary signal input) to reduce noise, since secondary signal inlets commonly accept float values
- Signal (~) connections are exempted from structure checks because all signal inlets are hot in the audio domain per CLAUDE.md Rule #3
- gen~ I/O detection supports both embedded codebox extraction and external code_context dict for flexibility
- CriticResult uses __slots__ matching the existing ValidationResult pattern for consistency

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

Pre-existing broken test file `tests/test_testing.py` (imports non-existent `src.maxpat.testing` module) -- unrelated to this plan, not a regression.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness
- Critics are ready for integration into generator-critic loops (Plan 04-05)
- review_patch() API is stable and can be called from agent skills
- No blockers for subsequent plans

## Self-Check: PASSED

- All 5 created files verified on disk
- All 4 task commits verified in git history (a3ba2fa, 79075bf, 48bb7de, 55dad46)
- 18 tests pass, 373 total tests pass (no regressions)

---
*Phase: 04-agent-system-and-orchestration*
*Completed: 2026-03-10*
