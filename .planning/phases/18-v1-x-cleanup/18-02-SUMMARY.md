---
phase: 18-v1-x-cleanup
plan: 02
subsystem: infra
tags: [cleanup, api-removal, v2-transition, code-deletion]

# Dependency graph
requires:
  - phase: 18-01
    provides: Clean patch directories with no v1.x generation artifacts
provides:
  - Clean codebase with only v2.0 API paths
  - No generate_patch, write_patch, Manifest, or merge_and_write in public API
  - All agent SKILL.md files reference only v2.0 API
affects: []

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "v2.0 pipeline: _apply_auto_styling -> apply_layout -> to_dict -> validate_patch -> save_patch_roundtrip"

key-files:
  created: []
  modified:
    - src/maxpat/__init__.py
    - src/maxpat/hooks.py
    - tests/test_hooks.py
    - tests/test_generation.py
    - tests/test_codegen.py
    - tests/test_agent_skills.py
    - tests/test_commands.py
    - .claude/commands/max-build.md
    - .claude/skills/max-patch-agent/SKILL.md
    - .claude/skills/max-dsp-agent/SKILL.md
    - .claude/skills/max-ui-agent/SKILL.md
    - .claude/skills/max-js-agent/SKILL.md
    - .claude/skills/max-ext-agent/SKILL.md
    - .claude/skills/max-rnbo-agent/SKILL.md
    - .claude/skills/max-critic/SKILL.md
    - .claude/skills/max-lifecycle/references/project-structure.md

key-decisions:
  - "Tests for generate_patch/write_patch in SKILL.md verification updated to check v2.0 API names (auto-fix)"

patterns-established:
  - "v2.0 output protocol: _apply_auto_styling(p), apply_layout(p), patch_dict=p.to_dict(), validate_patch(patch_dict, db=p.db), save_patch_roundtrip(patch_dict, path)"

requirements-completed: [CL-01, CL-04, CL-05]

# Metrics
duration: 11min
completed: 2026-03-16
---

# Phase 18 Plan 02: Remove v1.x Code Infrastructure Summary

**Deleted incremental.py module, removed generate_patch/write_patch from public API, rewrote 60+ tests to use v2.0 individual-step pipeline, updated all 7 agent SKILL.md files and /max-build command**

## Performance

- **Duration:** 11 min
- **Started:** 2026-03-16T22:53:05Z
- **Completed:** 2026-03-16T23:04:05Z
- **Tasks:** 2
- **Files modified:** 18 (2 deleted, 16 modified)

## Accomplishments
- Deleted incremental.py (476 lines) and test_incremental.py (573 lines) -- removed Manifest, merge_and_write, and all incremental patching infrastructure
- Removed generate_patch() function (47 lines) and write_patch() function (62 lines) from public API
- Rewrote 3 test files (test_hooks.py, test_generation.py, test_codegen.py) to use v2.0 pipeline steps
- Updated all 7 agent SKILL.md files and /max-build slash command to reference only v2.0 API
- Full test suite (1138 tests) passes with zero import errors

## Task Commits

Each task was committed atomically:

1. **Task 1: Delete incremental.py, clean __init__.py and hooks.py, delete/update affected tests** - `447500c` (chore)
2. **Task 2: Update SKILL.md files and slash commands to v2.0 API only** - `ea78d78` (docs)
3. **Auto-fix: Update agent/command verification tests for v2.0 API** - `1e6476d` (fix)

**Plan metadata:** pending (docs: complete plan)

## Files Created/Modified
- `src/maxpat/incremental.py` - Deleted (Manifest, merge_and_write, all merge logic)
- `src/maxpat/__init__.py` - Removed generate_patch, write_patch, Manifest, merge_and_write from imports and __all__
- `src/maxpat/hooks.py` - Removed write_patch function, updated docstring
- `tests/test_incremental.py` - Deleted (38 tests for incremental patching)
- `tests/test_hooks.py` - Removed 14 generate_patch/write_patch tests, rewrote validate_file test to use save_patch_roundtrip
- `tests/test_generation.py` - Replaced all generate_patch/write_patch calls with _run_pipeline helper using individual steps
- `tests/test_codegen.py` - Renamed test_add_gen_generate_patch to test_add_gen_pipeline, updated imports
- `tests/test_agent_skills.py` - Updated write_patch signature test to check save_patch_roundtrip
- `tests/test_commands.py` - Updated max-build write_patch reference test to check save_patch_roundtrip
- `.claude/commands/max-build.md` - Replaced generate_patch/write_patch with v2.0 API
- `.claude/skills/max-patch-agent/SKILL.md` - Replaced all v1.x API references
- `.claude/skills/max-dsp-agent/SKILL.md` - Replaced all v1.x API references
- `.claude/skills/max-ui-agent/SKILL.md` - Replaced all v1.x API references
- `.claude/skills/max-js-agent/SKILL.md` - Replaced all v1.x API references
- `.claude/skills/max-ext-agent/SKILL.md` - Replaced all v1.x API references
- `.claude/skills/max-rnbo-agent/SKILL.md` - Replaced all v1.x API references
- `.claude/skills/max-critic/SKILL.md` - Removed write_patch reference from critic section

## Decisions Made
- Tests verifying SKILL.md content (test_agent_skills.py, test_commands.py) updated to check v2.0 API names instead of v1.x names

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 3 - Blocking] Updated agent/command verification tests for v2.0 API**
- **Found during:** Task 2 verification (full test suite run)
- **Issue:** test_patch_agent_write_patch_signature and test_build_references_write_patch asserted SKILL.md files contain write_patch references -- failed after v2.0 updates
- **Fix:** Renamed tests and updated assertions to check for save_patch_roundtrip instead
- **Files modified:** tests/test_agent_skills.py, tests/test_commands.py
- **Verification:** Full test suite (1138 tests) passes
- **Committed in:** `1e6476d`

---

**Total deviations:** 1 auto-fixed (1 blocking)
**Impact on plan:** Auto-fix necessary for test suite correctness after API removal. No scope creep.

## Issues Encountered
None

## User Setup Required
None - no external service configuration required.

## Next Phase Readiness
- v2.0 transition complete: no v1.x code paths remain in codebase
- All agent documentation references v2.0 API exclusively
- Phase 18 (v1.x Cleanup) is fully complete

## Self-Check: PASSED

- SUMMARY.md exists: FOUND
- incremental.py deleted: CONFIRMED
- test_incremental.py deleted: CONFIRMED
- Commit 447500c (Task 1): FOUND
- Commit ea78d78 (Task 2): FOUND
- Commit 1e6476d (Auto-fix): FOUND

---
*Phase: 18-v1-x-cleanup*
*Completed: 2026-03-16*
