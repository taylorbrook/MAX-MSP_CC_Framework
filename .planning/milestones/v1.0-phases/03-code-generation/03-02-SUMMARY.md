---
phase: 03-code-generation
plan: 02
subsystem: code-generation
tags: [n4m, node-for-max, js, v8, javascript, code-validation, genexpr, hooks]

# Dependency graph
requires:
  - phase: 03-code-generation
    provides: GenExpr code builder (parse_genexpr_io, build_genexpr), gen~ codebox embedding (add_gen), .gendsp generation, hooks infrastructure
provides:
  - N4M code generation (generate_n4m_script with CommonJS require, addHandler, async dict access)
  - js V8 code generation (generate_js_script with inlets/outlets, handler functions)
  - Patcher.add_node_script and Patcher.add_js box creation methods
  - GenExpr validation against gen/objects.json (189 operators)
  - js validation (inlets/outlets, handlers, outlet index bounds)
  - N4M validation (require max-api, addHandler, outlet presence)
  - detect_js_type auto-detection (N4M vs js V8)
  - validate_code_file hook for .gendsp and .js files
  - write_js hook with auto-validation
affects: [04-agent-framework, 05-rnbo-externals]

# Tech tracking
tech-stack:
  added: []
  patterns: [N4M CommonJS template with async dict access, js V8 template with handler functions, code validation pipeline (report-only), Box.__new__ pattern for node.script and js boxes]

key-files:
  created:
    - src/maxpat/code_validation.py
  modified:
    - src/maxpat/codegen.py
    - src/maxpat/patcher.py
    - src/maxpat/hooks.py
    - src/maxpat/__init__.py
    - tests/test_codegen.py
    - tests/test_code_validation.py

key-decisions:
  - "node.script box via Box.__new__ (not in DB per Research pitfall #2) with maxclass=newobj, text=node.script filename"
  - "js box via Box.__new__ with maxclass=newobj (not maxclass=js) to match actual .maxpat format"
  - "N4M uses CommonJS format (require, not ESM import) per user decision"
  - "All code validation is report-only (no auto-fix) per user decision"
  - "GenExpr validator skips declared variable names (Param/History/Buffer/Data declarations) when checking operators"
  - "detect_js_type checks require('max-api') first (N4M), then inlets= (js V8)"

patterns-established:
  - "Code generators return complete source strings ready for file write"
  - "add_node_script/add_js return (Box, code|None) tuple, caller writes file"
  - "validate_code_file dispatches to type-specific validator via detect_js_type"
  - "write_js writes first, validates second (never blocks write)"

requirements-completed: [CODE-04, CODE-05, CODE-01]

# Metrics
duration: 5min
completed: 2026-03-10
---

# Phase 3 Plan 2: N4M/js Code Generation and Code Validation Summary

**Node for Max and js V8 JavaScript generators with three-domain code validation (GenExpr/js/N4M) and auto-validating file write hooks**

## Performance

- **Duration:** 5 min
- **Started:** 2026-03-10T03:34:37Z
- **Completed:** 2026-03-10T03:39:54Z
- **Tasks:** 3
- **Files modified:** 7

## Accomplishments
- N4M code generator produces CommonJS scripts with require("max-api"), addHandler patterns, and async dict access with try/catch error handling
- js V8 code generator produces scripts with inlets/outlets declarations and standard handler functions (bang, msg_int, msg_float, list)
- Patcher.add_node_script and add_js create correct boxes using Box.__new__ pattern (bypassing DB lookup for infrastructure objects)
- GenExpr validator catches unknown operators against 189 gen operators in database, unbalanced braces, missing semicolons, and incomplete Param specs
- js validator catches missing inlets/outlets declarations, absent handlers, and outlet index out-of-bounds errors
- N4M validator catches missing require('max-api'), absent maxAPI.outlet() calls, and reports registered handler names
- Hook system extended with validate_code_file (auto-dispatches to correct validator) and write_js (writes + validates)
- 35 new tests added, full suite at 314 (279 existing + 35 new), all green

## Task Commits

Each task was committed atomically:

1. **Task 1: N4M and js code generation + patch integration** - `c3c4a0a` (test) + `cc911dd` (feat)
2. **Task 2: Code validation for GenExpr, js, and N4M** - `3417685` (test) + `4b30afb` (feat)
3. **Task 3: Hook extension and public API finalization** - `5802e67` (feat)

_Note: Tasks 1 and 2 used TDD with separate test and implementation commits._

## Files Created/Modified
- `src/maxpat/code_validation.py` - Three validators (validate_genexpr, validate_js, validate_n4m) plus detect_js_type
- `src/maxpat/codegen.py` - Added generate_n4m_script and generate_js_script
- `src/maxpat/patcher.py` - Added add_node_script and add_js methods
- `src/maxpat/hooks.py` - Added validate_code_file and write_js functions
- `src/maxpat/__init__.py` - Public API exports for all new functions
- `tests/test_codegen.py` - Extended with TestN4M, TestJsObject, TestHookIntegration classes
- `tests/test_code_validation.py` - New file with TestGenExprValidator, TestJsValidator, TestN4MValidator, TestDetectJsType, TestValidateCodeFile classes

## Decisions Made
- node.script box created via Box.__new__ because node.script is not in the object database (Research pitfall #2)
- js box uses Box.__new__ with maxclass="newobj" because in .maxpat files js objects use maxclass="newobj" with text="js filename.js" (not maxclass="js")
- N4M scripts use CommonJS format (const maxAPI = require("max-api")) per user decision
- All validation is report-only with no auto-fix per user decision
- GenExpr validator extracts declared names from Param/History/Buffer/Data statements and excludes them from operator validation
- detect_js_type prioritizes N4M detection (require('max-api')) over js detection (inlets=) since N4M files may not have inlets declarations

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] Fixed GenExpr operator validation false positives on declared variable names**
- **Found during:** Task 2 (Code validation)
- **Issue:** `History h(0)` caused `h` to be treated as an operator function call, triggering false "unknown operator" error
- **Fix:** Added declared_names extraction from Param/History/Buffer/Data statements, excluded them from operator validation
- **Files modified:** src/maxpat/code_validation.py
- **Verification:** test_known_operators passes with History declarations
- **Committed in:** 4b30afb (Task 2 commit)

---

**Total deviations:** 1 auto-fixed (1 bug fix)
**Impact on plan:** Auto-fix necessary for correct GenExpr validation. No scope creep.

## Issues Encountered
None

## User Setup Required
None - no external service configuration required.

## Next Phase Readiness
- All Phase 3 code generation capabilities complete
- N4M and js code generation ready for agent-generated scripts
- Code validation ready for pre-flight checks before opening MAX
- Hook system auto-validates .gendsp and .js files on write
- Phase 4 (Agent Framework) can leverage code generation + validation pipeline

## Self-Check: PASSED

All created files verified on disk. All task commits verified in git log.

---
*Phase: 03-code-generation*
*Completed: 2026-03-10*
