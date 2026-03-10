---
phase: 05-rnbo-and-external-development
plan: 02
subsystem: externals
tags: [min-devkit, c++, cmake, code-generation, scaffolding, maxhelp]

# Dependency graph
requires:
  - phase: 02-patch-generation
    provides: "Patcher/Box data model and write_patch for help patch generation"
provides:
  - "C++ code templates for three Min-DevKit archetypes (message, DSP, scheduler)"
  - "External project scaffolding with directory structure, CMakeLists.txt, and help patches"
  - "generate_external_code for programmatic C++ generation without file I/O"
affects: [05-03-build-and-compile, 05-04-agent-skill-upgrade]

# Tech tracking
tech-stack:
  added: [min-devkit-templates, cmake-generation]
  patterns: [archetype-template-rendering, box-new-bypass-for-custom-externals]

key-files:
  created:
    - src/maxpat/ext_templates.py
    - src/maxpat/externals.py
    - tests/test_externals.py
  modified: []

key-decisions:
  - "Python f-strings for C++ template rendering (not Jinja2) -- templates are small, no external dependency"
  - "Box.__new__ bypass for external object in help patches -- custom externals not in DB"
  - "Help patch writes raw JSON (not write_patch) to avoid validation on non-DB objects"
  - "DSP help patch includes *~ 0.25 gain stage between external and dac~ for safety"

patterns-established:
  - "Archetype template pattern: render_*_template functions return complete C++ strings"
  - "Scaffold pattern: scaffold_external creates directory + files + returns path dict"
  - "External Box.__new__ pattern: custom externals bypass DB lookup in help patches"

requirements-completed: [EXT-01, EXT-02, EXT-03, EXT-04]

# Metrics
duration: 4min
completed: 2026-03-10
---

# Phase 5 Plan 02: External Scaffolding Summary

**Min-DevKit C++ scaffolding with three archetypes (message/DSP/scheduler), CMakeLists.txt generation, and .maxhelp help patches via Patcher pipeline**

## Performance

- **Duration:** 4 min
- **Started:** 2026-03-10T17:51:37Z
- **Completed:** 2026-03-10T17:55:44Z
- **Tasks:** 2
- **Files modified:** 3

## Accomplishments
- Three C++ archetype templates render correct Min-DevKit C++17 code (no classic Max SDK patterns)
- scaffold_external creates documented directory structure with source/, help/, CMakeLists.txt
- Help patches are valid .maxpat JSON with archetype-appropriate demo objects
- Intent-driven generation: description flows through to MIN_DESCRIPTION in generated code
- 40 tests covering all archetypes, scaffolding, help patches, and edge cases

## Task Commits

Each task was committed atomically:

1. **Task 1: C++ templates for three Min-DevKit archetypes** - `7d39826` (feat)
2. **Task 2: External scaffolding and help patch generation** - `2e4887c` (feat)

_Both tasks used TDD: tests written first (RED), implementation to pass (GREEN)._

## Files Created/Modified
- `src/maxpat/ext_templates.py` - C++ code templates: render_message_template, render_dsp_template, render_scheduler_template, render_cmake_template, render_test_template
- `src/maxpat/externals.py` - Scaffolding: scaffold_external, generate_external_code, generate_help_patch with Box.__new__ pattern
- `tests/test_externals.py` - 40 tests: 29 template tests + 11 scaffolding/help patch tests

## Decisions Made
- Python f-strings for C++ template rendering (not Jinja2) -- templates are small (<100 lines each), no external dependency needed
- Box.__new__ bypass for custom external objects in help patches -- these objects are not in the database and cannot use standard Box constructor
- Help patches write raw JSON via Patcher.to_dict() rather than write_patch to avoid validation rejecting non-DB objects
- DSP help patch includes *~ 0.25 gain stage between external output and dac~ for audio safety (per CLAUDE.md MSP rule)

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered
- Pre-existing import error in tests/test_rnbo.py (references add_rnbo not yet implemented from Plan 05-01) -- out of scope, did not affect this plan's 556 passing tests

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness
- Templates and scaffolding ready for Plan 03 (build and compilation support)
- scaffold_external returns path dict that build_external can consume
- CMakeLists.txt template has correct min-api paths for cmake invocation

## Self-Check: PASSED

All files verified present. All commit hashes found in git log.

---
*Phase: 05-rnbo-and-external-development*
*Completed: 2026-03-10*
