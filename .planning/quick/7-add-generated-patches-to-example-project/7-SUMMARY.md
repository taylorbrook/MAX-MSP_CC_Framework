---
phase: quick-7
plan: 01
subsystem: tooling
tags: [examples, catalog, file-copy, markdown]

requires:
  - phase: quick-5
    provides: version tracking system (versions.json, get_version)
provides:
  - build_examples_catalog() function for regenerating examples/ and PATCHES.md
  - examples/ directory with browsable patch files organized by project
  - PATCHES.md catalog listing all projects with versions and descriptions
affects: [project-lifecycle, documentation]

tech-stack:
  added: [shutil]
  patterns: [idempotent-rebuild, context-md-description-extraction]

key-files:
  created:
    - examples/FDNVerb/FDNVerb.maxpat
    - examples/FDNVerb/FDNverb.gendsp
    - examples/granularsynthtest/granularsynthtest.maxpat
    - examples/granularsynthtest/granular-engine.gendsp
    - examples/performancepatchtest/performancepatchtest.maxpat
    - examples/performancepatchtest/comp-band.maxpat
    - examples/performancepatchtest/comp-engine.gendsp
    - examples/performancepatchtest/crossover-4band.gendsp
    - examples/rhythmic-sampler/rhythmic-sampler.maxpat
    - examples/rhythmic-sampler/slot.maxpat
    - examples/rhythmic-sampler/slot-engine.js
    - examples/scala-synth/scala-synth.maxpat
    - examples/scala-synth/scala-synth-voice.maxpat
    - examples/scala-synth/scala-parser.js
    - examples/scala-synth/partial-display.js
    - PATCHES.md
  modified:
    - src/maxpat/project.py
    - tests/test_project.py

key-decisions:
  - "Description extracted from first non-empty non-heading line of context.md with 'No description' fallback"
  - "Only .maxpat, .gendsp, .js files copied; .py, .txt, and other files excluded"
  - "Idempotent rebuild via shutil.rmtree before copy"

patterns-established:
  - "examples/ directory mirrors patches/ structure with only user-facing files"
  - "PATCHES.md uses summary table + per-project detail sections format"

requirements-completed: [QUICK-7]

duration: 2min
completed: 2026-03-14
---

# Quick Task 7: Add Generated Patches to Examples Directory Summary

**Reusable build_examples_catalog() function that copies 15 patch/gendsp/js files across 5 projects to examples/ and generates a PATCHES.md catalog with versions and descriptions**

## Performance

- **Duration:** 2 min
- **Started:** 2026-03-14T04:58:03Z
- **Completed:** 2026-03-14T05:00:20Z
- **Tasks:** 2
- **Files modified:** 18

## Accomplishments
- Added `build_examples_catalog()` function to `src/maxpat/project.py` with TDD (8 tests)
- Populated `examples/` with 15 files across 5 project directories (FDNVerb, granularsynthtest, performancepatchtest, rhythmic-sampler, scala-synth)
- Generated `PATCHES.md` with summary table and per-project detail sections including versions and descriptions

## Task Commits

Each task was committed atomically:

1. **Task 1: Add build_examples_catalog() with tests** - `be478f2` (test: RED), `e4f2304` (feat: GREEN)
2. **Task 2: Run build_examples_catalog() to populate examples/ and PATCHES.md** - `db041bc` (feat)

## Files Created/Modified
- `src/maxpat/project.py` - Added `build_examples_catalog()`, `_read_project_description()`, `_EXAMPLE_EXTENSIONS`
- `tests/test_project.py` - Added `TestBuildExamplesCatalog` class with 8 tests
- `PATCHES.md` - Generated catalog with 5 projects, versions, descriptions
- `examples/FDNVerb/` - 2 files (FDNVerb.maxpat, FDNverb.gendsp)
- `examples/granularsynthtest/` - 2 files (granularsynthtest.maxpat, granular-engine.gendsp)
- `examples/performancepatchtest/` - 4 files (performancepatchtest.maxpat, comp-band.maxpat, comp-engine.gendsp, crossover-4band.gendsp)
- `examples/rhythmic-sampler/` - 3 files (rhythmic-sampler.maxpat, slot.maxpat, slot-engine.js)
- `examples/scala-synth/` - 4 files (scala-synth.maxpat, scala-synth-voice.maxpat, scala-parser.js, partial-display.js)

## Decisions Made
- Description extraction reads the first non-empty, non-heading line from context.md -- falls back to "No description" if only headings exist
- File filtering uses a whitelist of extensions (.maxpat, .gendsp, .js) to exclude build scripts (.py) and data files (.txt, .json)
- Idempotent rebuild: shutil.rmtree clears existing examples/{project}/ before copying

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered
None.

## User Setup Required
None - no external service configuration required.

## Next Phase Readiness
- `build_examples_catalog()` can be called any time to regenerate examples/ and PATCHES.md after new patches are created
- Function is tested (8 tests) and importable from `src.maxpat.project`

## Self-Check: PASSED

All 18 created files verified present. All 3 commits (be478f2, e4f2304, db041bc) verified in git history.

---
*Phase: quick-7*
*Completed: 2026-03-14*
