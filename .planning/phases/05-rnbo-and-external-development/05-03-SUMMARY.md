---
phase: 05-rnbo-and-external-development
plan: 03
subsystem: externals
tags: [cmake, build-system, mach-o, arm64, auto-fix, subprocess, min-devkit, mxo-validation]

# Dependency graph
requires:
  - phase: 05-rnbo-and-external-development
    plan: 02
    provides: "scaffold_external, generate_external_code, CMakeLists.txt template"
provides:
  - "build_external: cmake/make build loop with auto-fix and .mxo validation"
  - "validate_mxo: post-compile Mach-O arm64 bundle verification"
  - "setup_min_devkit: recursive git submodule initialization"
  - "parse_compiler_errors: structured error extraction from gcc/clang output"
  - "auto_fix: known compiler error pattern correction (missing semicolons, includes)"
  - "BuildResult: dataclass capturing build outcome with path, errors, attempts"
affects: [05-04-agent-skill-upgrade]

# Tech tracking
tech-stack:
  added: [subprocess-build-loop, mach-o-validation, compiler-error-parsing]
  patterns: [auto-fix-with-loop-detection, error-hash-tracking, unix-makefiles-headless]

key-files:
  created:
    - src/maxpat/ext_validation.py
  modified:
    - src/maxpat/externals.py
    - tests/test_externals.py

key-decisions:
  - "Unix Makefiles generator (not Xcode) for headless cmake builds per Pitfall #5"
  - "Error hash tracking via MD5 of sorted error messages for loop detection"
  - "Auto-fix limited to missing semicolons and missing includes only (per Pitfall #6)"
  - "subprocess.run with timeout guards for all external process calls"

patterns-established:
  - "Build loop pattern: configure -> build -> parse errors -> auto-fix -> repeat with hash tracking"
  - "Auto-fix pattern: regex-matched error categories dispatched to targeted fixers"
  - "Validation chain: build success -> find .mxo -> validate_mxo (structure + file + lipo)"

requirements-completed: [EXT-05]

# Metrics
duration: 4min
completed: 2026-03-10
---

# Phase 5 Plan 03: External Build System Summary

**cmake/make build loop with auto-fix error correction, .mxo arm64 Mach-O validation, and Min-DevKit recursive submodule setup**

## Performance

- **Duration:** 4 min
- **Started:** 2026-03-10T18:00:14Z
- **Completed:** 2026-03-10T18:04:40Z
- **Tasks:** 2
- **Files modified:** 3

## Accomplishments
- BuildResult dataclass and validate_mxo provide complete post-compile verification chain (exists, Mach-O type, arm64 architecture)
- parse_compiler_errors extracts file/line/column/severity/message from gcc/clang output for auto-fix processing
- build_external runs cmake with Unix Makefiles generator in a retry loop with error hash tracking to detect infinite loops
- auto_fix handles missing semicolons and missing includes; unfixable errors escalate to caller
- setup_min_devkit initializes recursive git submodule with nested min-api headers verification
- 21 new tests (12 for Task 1, 9 for Task 2), all 61 externals tests pass, 600 total suite

## Task Commits

Each task was committed atomically:

1. **Task 1: .mxo validation and build result types** - `8a0bbac` (feat)
2. **Task 2: Build loop with auto-fix and Min-DevKit submodule setup** - `7bdfb57` (feat)

_Both tasks used TDD: tests written first (RED), implementation to pass (GREEN)._

## Files Created/Modified
- `src/maxpat/ext_validation.py` - BuildResult dataclass, validate_mxo (Mach-O + arm64 check), parse_compiler_errors (gcc/clang output)
- `src/maxpat/externals.py` - Extended with build_external, setup_min_devkit, auto_fix, _fix_missing_semicolon, _fix_missing_include
- `tests/test_externals.py` - Extended with 21 new tests for validation, build, auto-fix, loop detection, submodule setup

## Decisions Made
- Unix Makefiles generator for cmake (not Xcode) ensures headless operation without code signing prompts
- Error hash tracking uses MD5 of sorted error messages to detect loops efficiently
- Auto-fix restricted to two well-known patterns (missing semicolons, missing includes) to avoid cascading fixes per Pitfall #6
- All subprocess calls have timeout guards (10s for validation, 60s for configure, 120s for build and submodule operations)

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

None.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness
- Complete external development pipeline ready: scaffold -> build -> validate
- Plan 04 (agent skill upgrade) can now wire these functions into the ext-agent skill
- build_external returns BuildResult that agents can inspect for success/failure/error details

## Self-Check: PASSED

All files verified present. All commit hashes found in git log.

---
*Phase: 05-rnbo-and-external-development*
*Completed: 2026-03-10*
