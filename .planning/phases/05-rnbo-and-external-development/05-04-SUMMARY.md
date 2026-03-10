---
phase: 05-rnbo-and-external-development
plan: 04
subsystem: critics, agents, api
tags: [rnbo, externals, critic, agent-skills, public-api, min-devkit]

# Dependency graph
requires:
  - phase: 05-01
    provides: "RNBODatabase, add_rnbo, generate_rnbo_wrapper, validate_rnbo_patch"
  - phase: 05-02
    provides: "scaffold_external, generate_external_code, generate_help_patch"
  - phase: 05-03
    provides: "build_external, setup_min_devkit, validate_mxo, BuildResult"
provides:
  - "RNBO semantic critic (param naming, I/O completeness, duplicate params)"
  - "External code critic (MIN_EXTERNAL, includes, archetype-specific checks)"
  - "review_patch auto-invokes RNBO critic when rnbo~ detected"
  - "Full RNBO agent (no longer stub)"
  - "Full external agent (no longer stub)"
  - "12 new public API exports for RNBO and externals"
affects: []

# Tech tracking
tech-stack:
  added: []
  patterns: ["RNBO critic as semantic layer over validation", "ext critic for code review", "auto-detect rnbo~ for critic invocation"]

key-files:
  created:
    - "src/maxpat/critics/rnbo_critic.py"
    - "src/maxpat/critics/ext_critic.py"
  modified:
    - "src/maxpat/critics/__init__.py"
    - "src/maxpat/__init__.py"
    - ".claude/skills/max-rnbo-agent/SKILL.md"
    - ".claude/skills/max-rnbo-agent/BOUNDARIES.md"
    - ".claude/skills/max-ext-agent/SKILL.md"
    - ".claude/skills/max-ext-agent/BOUNDARIES.md"
    - "tests/test_critics.py"
    - "tests/test_agent_skills.py"

key-decisions:
  - "RNBO critic checks param naming convention (lowercase_with_underscores), I/O completeness, and duplicate params"
  - "External critic checks MIN_EXTERNAL, c74_min.h, class/macro match, archetype-specific requirements"
  - "review_patch auto-detects rnbo~ boxes and invokes RNBO critic automatically"
  - "review_patch accepts ext_code parameter for external code review"
  - "Agent SKILL.md files rewritten from scratch (not patched) to ensure clean non-stub content"

patterns-established:
  - "Auto-detect pattern: review_patch scans for maxclass to decide which critics to invoke"
  - "Param naming convention: RNBO params use lowercase_with_underscores"

requirements-completed: [CODE-06, CODE-07, EXT-01, EXT-02, EXT-03, EXT-04, EXT-05]

# Metrics
duration: 5min
completed: 2026-03-10
---

# Phase 5 Plan 4: RNBO/External Critics, Agent Upgrades, and Public API Summary

**RNBO and external semantic critics with auto-detection in review_patch, stub agents upgraded to full generation capabilities, and 12 new public API exports**

## Performance

- **Duration:** 5 min
- **Started:** 2026-03-10T18:08:29Z
- **Completed:** 2026-03-10T18:14:20Z
- **Tasks:** 3
- **Files modified:** 10

## Accomplishments
- RNBO critic catches param naming issues, missing I/O, and duplicate params in rnbo~ inner patchers
- External critic catches structural C++ issues (missing includes, macros, archetype-specific requirements)
- review_patch auto-invokes RNBO critic when rnbo~ boxes detected, accepts ext_code for external review
- RNBO and external agents upgraded from Phase 4 stubs to full generation agents with complete API references
- Public API exports 12 new RNBO and external symbols (RNBODatabase, add_rnbo, scaffold_external, build_external, etc.)
- Full test suite: 613 tests pass with zero failures

## Task Commits

Each task was committed atomically:

1. **Task 1: RNBO and external critic modules** - `d61b5fb` (test: TDD RED) + `6f07e7c` (feat: TDD GREEN)
2. **Task 2: Upgrade stub agents and extend public API** - `638d9bb` (feat)
3. **Task 3: Full test suite verification** - no code changes (verification only)

## Files Created/Modified
- `src/maxpat/critics/rnbo_critic.py` - RNBO semantic critic (param naming, I/O, duplicates, target fitness)
- `src/maxpat/critics/ext_critic.py` - External code critic (MIN_EXTERNAL, includes, DSP operators, timer, TODOs)
- `src/maxpat/critics/__init__.py` - Extended review_patch with RNBO auto-detection and ext_code param
- `src/maxpat/__init__.py` - Public API with 12 new RNBO and external exports
- `.claude/skills/max-rnbo-agent/SKILL.md` - Full RNBO generation agent (replaced stub)
- `.claude/skills/max-rnbo-agent/BOUNDARIES.md` - Full RNBO agent boundaries
- `.claude/skills/max-ext-agent/SKILL.md` - Full external development agent (replaced stub)
- `.claude/skills/max-ext-agent/BOUNDARIES.md` - Full external agent boundaries
- `tests/test_critics.py` - 11 new RNBO and external critic tests (29 total)
- `tests/test_agent_skills.py` - 4 new agent tests (not-stub, has-API-refs)

## Decisions Made
- RNBO critic checks param naming convention (lowercase_with_underscores) as warning, not blocker
- External critic archetype-specific checks (DSP needs operator, scheduler needs timer) are blockers
- review_patch auto-detects rnbo~ by scanning box maxclass, avoiding unnecessary critic invocation
- Agent SKILL.md files rewritten entirely (not patched) to ensure clean non-stub content
- Public API __all__ list organized by category (core, RNBO, externals)

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

None.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness
- Phase 5 is now COMPLETE: all 4 plans executed successfully
- All 5 phases of the v1.0 milestone are complete
- Full test suite: 613 tests pass with zero failures
- All RNBO and external capabilities implemented and integrated

## Self-Check: PASSED

All 11 files verified present. All 3 task commit hashes verified in git log.

---
*Phase: 05-rnbo-and-external-development*
*Completed: 2026-03-10*
