---
phase: 23-agent-package-intelligence
plan: 03
subsystem: agent-knowledge
tags: [packages, beap, vizzie, skill-md, agent-intelligence, parity-tests]

# Dependency graph
requires:
  - phase: 23-01
    provides: add_bpatcher(object_name=) auto-sizing, get_bpatcher_dims() API
  - phase: 23-02
    provides: PACKAGES.md shared reference, package relationship pairs in relationships.json
provides:
  - Package Intelligence sections in 5 agent SKILL.md files
  - BEAP modular patching guidance (max-patch-agent)
  - BEAP CV signal conventions (max-dsp-agent)
  - Bpatcher layout rules with object_name auto-sizing (max-ui-agent)
  - BEAP/Vizzie NOT RNBO-compatible warning (max-rnbo-agent)
  - Package-aware scripting notes (max-js-agent)
  - Package-vs-core parity verification tests (TestPackageParity)
affects: [agent-skills, patch-generation, package-intelligence]

# Tech tracking
tech-stack:
  added: []
  patterns: [shared-preamble-plus-domain-specific-guidance, parity-verification-testing]

key-files:
  created: []
  modified:
    - .claude/skills/max-patch-agent/SKILL.md
    - .claude/skills/max-dsp-agent/SKILL.md
    - .claude/skills/max-ui-agent/SKILL.md
    - .claude/skills/max-rnbo-agent/SKILL.md
    - .claude/skills/max-js-agent/SKILL.md
    - tests/test_agent_skills.py
    - tests/test_package_schema.py

key-decisions:
  - "All 5 agents share identical PACKAGES.md preamble, then add domain-specific subsections"
  - "Adjusted PACKAGES.md template regex to match actual #### numbered headers instead of ### headers"

patterns-established:
  - "Package Intelligence section pattern: shared preamble referencing PACKAGES.md + agent-specific subsection"
  - "Parity verification: TestPackageParity checks fields, dimensions, relationships, agent coverage, and templates"

requirements-completed: [PKG-14, PKG-18]

# Metrics
duration: 3min
completed: 2026-04-15
---

# Phase 23 Plan 03: Per-Agent Package Intelligence Summary

**Package Intelligence sections added to 5 specialist SKILL.md files with BEAP/Vizzie domain guidance, plus parity tests confirming package objects match core domain coverage**

## Performance

- **Duration:** 3 min
- **Started:** 2026-04-15T00:45:39Z
- **Completed:** 2026-04-15T00:49:06Z
- **Tasks:** 2
- **Files modified:** 7

## Accomplishments
- All 5 specialist agents now have Package Intelligence sections with shared PACKAGES.md reference plus domain-specific guidance
- max-patch-agent documents BEAP modular patterns (signal chain order, bp.VCA gain control, Keyboard I/O) and Vizzie video chains
- max-dsp-agent documents BEAP CV conventions (0-5V range, MSP/BEAP scaling with *~ 5.0 / *~ 0.2, 1V/oct pitch tracking)
- max-ui-agent documents bpatcher layout rules (object_name auto-sizing, dimension ranges, adaptive spacing formula)
- max-rnbo-agent warns BEAP/Vizzie/jit.mo/Jitter packages are NOT RNBO-compatible with alternatives
- max-js-agent documents package-aware scripting (patcher.getnamed(), CV scaling, control inlet messages)
- TestPackageParity class verifies field coverage, dimension coverage >= 90%, relationship entries, agent guidance, and template sections

## Task Commits

Each task was committed atomically:

1. **Task 1: Add Package Intelligence to 5 SKILL.md files** - `be4c1a2` (feat)
2. **Task 2: Package-vs-core parity tests** - `b6c99dc` (test)

## Files Created/Modified
- `.claude/skills/max-patch-agent/SKILL.md` - Added BEAP modular patching and Vizzie video chain sections
- `.claude/skills/max-dsp-agent/SKILL.md` - Added BEAP/MSP integration and CV signal conventions
- `.claude/skills/max-ui-agent/SKILL.md` - Added bpatcher layout rules with auto-sizing documentation
- `.claude/skills/max-rnbo-agent/SKILL.md` - Added package compatibility warning (NOT RNBO-compatible)
- `.claude/skills/max-js-agent/SKILL.md` - Added package-aware scripting patterns
- `tests/test_agent_skills.py` - 14 new tests (10 parametrized + 4 specific content tests)
- `tests/test_package_schema.py` - 8 new tests in TestPackageParity class

## Decisions Made
- All 5 agents share an identical preamble referencing PACKAGES.md, then diverge into domain-specific subsections
- Adjusted template regex in parity test from `###` to `#### N.` pattern to match actual PACKAGES.md structure (plan's regex didn't match)

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] Fixed PACKAGES.md template section regex**
- **Found during:** Task 2
- **Issue:** Plan's suggested regex `r'^###\s+.*(?:Synth|Chain|Setup|Effect|Analysis|Camera|VJ)'` matched 0 headers because PACKAGES.md uses `####` numbered headers (e.g., `#### 1. Subtractive Synthesizer`)
- **Fix:** Used `r'^####\s+\d+\.\s+'` which correctly matches all 8 template sections
- **Files modified:** `tests/test_package_schema.py`
- **Commit:** b6c99dc

---

**Total deviations:** 1 auto-fixed (1 bug in plan spec)
**Impact on plan:** Necessary fix for test correctness. No scope creep.

## Issues Encountered
- Pre-existing test_inlet_types.py failure (MSP signal I/O types for mc.capture~, mc.send~, mcs.loudness~, info~) is unrelated to this plan, documented in Plan 01 SUMMARY as out of scope

## User Setup Required
None - no external service configuration required.

## Next Phase Readiness
- All 5 agents have package intelligence, ready for package-aware patch generation
- Parity tests ensure package coverage stays at core level going forward
- Phase 23 all 3 plans complete: sizing/layout (01), knowledge docs (02), agent skills (03)

## Self-Check: PASSED

- [x] All 7 files exist
- [x] Commit be4c1a2 verified
- [x] Commit b6c99dc verified
- [x] All 5 SKILL.md files contain "Package Intelligence" section
- [x] test_specialist_has_package_intelligence in test_agent_skills.py
- [x] TestPackageParity class in test_package_schema.py
- [x] 193 plan-relevant tests pass (153 agent_skills + 40 package_schema)

---
*Phase: 23-agent-package-intelligence*
*Completed: 2026-04-15*
