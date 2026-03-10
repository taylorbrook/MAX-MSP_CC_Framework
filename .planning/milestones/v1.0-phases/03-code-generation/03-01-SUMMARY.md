---
phase: 03-code-generation
plan: 01
subsystem: code-generation
tags: [genexpr, gen~, codebox, gendsp, dsp]

# Dependency graph
requires:
  - phase: 02-patch-generation
    provides: Patcher/Box model with nested patcher support (add_subpatcher), maxclass resolution, hooks infrastructure
provides:
  - GenExpr code builder (parse_genexpr_io, build_genexpr)
  - gen~ codebox embedding via Patcher.add_gen()
  - .gendsp standalone file generation (generate_gendsp, write_gendsp)
  - gen~ maxclass fix (gen~ in UI_MAXCLASSES)
affects: [03-code-generation, 04-agent-framework, 05-rnbo-externals]

# Tech tracking
tech-stack:
  added: []
  patterns: [gen~ codebox embedding via Box.__new__ with inner patcher, GenExpr I/O auto-detection via regex]

key-files:
  created:
    - src/maxpat/codegen.py
    - tests/test_codegen.py
    - tests/fixtures/expected/gen_codebox.maxpat
    - tests/fixtures/expected/simple.gendsp
  modified:
    - src/maxpat/patcher.py
    - src/maxpat/maxclass_map.py
    - src/maxpat/defaults.py
    - src/maxpat/sizing.py
    - src/maxpat/hooks.py
    - src/maxpat/__init__.py

key-decisions:
  - "gen~ codebox via Box.__new__ pattern (same as add_subpatcher) -- bypasses DB lookup for structural objects"
  - "Codebox code stored in extra_attrs dict for automatic inclusion in to_dict() serialization"
  - "GenExpr I/O auto-detection uses word-boundary regex to avoid false matches on variable names like 'index'"
  - "Codebox outlettype uses empty string (gen~ operates at sample rate internally, types implicit)"

patterns-established:
  - "add_gen pattern: dedicated method for creating gen~ boxes with inner patcher, following add_subpatcher precedent"
  - "GenExpr builder with section headers (// === SECTION ===) and full Param range specs"
  - "Structural boxes (codebox, in, out) created via Box.__new__ with manual attribute assignment"

requirements-completed: [CODE-01, CODE-02, CODE-03]

# Metrics
duration: 5min
completed: 2026-03-10
---

# Phase 3 Plan 1: GenExpr Code Generation Summary

**GenExpr code builder with parse/build/generate functions, gen~ codebox embedding via Patcher.add_gen(), and standalone .gendsp file generation with write support**

## Performance

- **Duration:** 5 min
- **Started:** 2026-03-10T03:25:44Z
- **Completed:** 2026-03-10T03:31:18Z
- **Tasks:** 3
- **Files modified:** 10

## Accomplishments
- GenExpr code builder produces well-formatted code with section headers, Param declarations with min/max/default, and descriptive variables
- Patcher.add_gen() creates gen~ boxes with inner patcher containing codebox + in/out objects + patchlines, auto-detecting I/O from code
- Standalone .gendsp files generate with correct JSON structure (patcher wrapper, codebox, in/out objects, patchlines)
- gen~ maxclass resolution fixed (gen~ in UI_MAXCLASSES returns "gen~" not "newobj")
- 42 new tests added, full suite at 279 (237 existing + 42 new), all green

## Task Commits

Each task was committed atomically:

1. **Task 1: GenExpr code builder and maxclass fixes** - `d5813e3` (test) + `b54d6ca` (feat)
2. **Task 2: gen~ codebox embedding in Patcher** - `a9d1a13` (test) + `8552276` (feat)
3. **Task 3: .gendsp file write support and integration** - `e480cc6` (feat)

_Note: Tasks 1 and 2 used TDD with separate test and implementation commits._

## Files Created/Modified
- `src/maxpat/codegen.py` - GenExpr code builder: parse_genexpr_io, build_genexpr, generate_gendsp
- `src/maxpat/patcher.py` - add_gen method for gen~ codebox embedding
- `src/maxpat/maxclass_map.py` - gen~ added to UI_MAXCLASSES
- `src/maxpat/defaults.py` - GEN_PATCHER_BGCOLOR constant
- `src/maxpat/sizing.py` - gen~ default size (150x22)
- `src/maxpat/hooks.py` - write_gendsp function
- `src/maxpat/__init__.py` - Public API exports for all codegen functions
- `tests/test_codegen.py` - 42 tests across 6 test classes
- `tests/fixtures/expected/gen_codebox.maxpat` - gen~ codebox fixture
- `tests/fixtures/expected/simple.gendsp` - .gendsp fixture

## Decisions Made
- gen~ codebox created via Box.__new__ pattern (same as add_subpatcher) to bypass DB lookup for structural objects
- Codebox code attribute stored in extra_attrs dict for automatic inclusion in to_dict() serialization via d.update()
- GenExpr I/O auto-detection uses word-boundary regex (\bin\d+\b, \bout\d+\b) to avoid false matches on variable names
- Codebox outlettype uses empty string [""] (gen~ operates at sample rate internally, outlet types are implicit)
- Codebox fontname/fontsize included via extra_attrs since codebox is not "newobj" in to_dict branch

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered
None

## User Setup Required
None - no external service configuration required.

## Next Phase Readiness
- GenExpr code generation complete, ready for code validation (CODE-01 validator)
- gen~ codebox embedding ready for use in agent-generated patches
- .gendsp write support ready for standalone Gen~ file generation
- Remaining Phase 3 plans: js/N4M code generation, code validation

## Self-Check: PASSED

All 5 created files verified on disk. All 5 task commits verified in git log.

---
*Phase: 03-code-generation*
*Completed: 2026-03-10*
