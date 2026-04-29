---
phase: 29-validator-depth
plan: 02
subsystem: testing
tags: [genexpr, code-validation, validator, regex, dsp]

# Dependency graph
requires:
  - phase: 29-validator-depth
    provides: "validate_genexpr existing Checks 1-6, hooks.validate_code_file routing for .gendsp files"
provides:
  - "_DECL_PREFIXES module-level constant (reusable across validate_genexpr checks)"
  - "_strip_line_comments helper (// comment stripping for regex passes)"
  - "Check 7: delay() rejection in GenExpr (ERROR, D-14)"
  - "Check 8: clip() rejection in expr/GenExpr (ERROR, D-15)"
  - "Check 9: init-before-if/else flow analysis (ERROR, D-16, D-20)"
  - ".gendsp round-trip coverage via hooks.validate_code_file (Check 7 piped through end-to-end)"
affects: [29-03, 29-05, validator-depth, dsp-critic]

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "Module-level regex prefixes for cross-check reuse"
    - "Comment-stripping pre-pass before regex matchers"
    - "Brace-depth flow analysis with declaration exemption"
    - "First-error-and-stop posture (consistent with Check 5)"

key-files:
  created: []
  modified:
    - src/maxpat/code_validation.py
    - tests/test_code_validation.py

key-decisions:
  - "Reused existing TestValidateCodeFile class for .gendsp round-trip test (test_gendsp_with_delay_blocks) instead of creating duplicate class — keeps tests/test_code_validation.py free of name conflicts."
  - "Word-boundary regex `\\bdelay\\s*\\(` correctly distinguishes lowercase delay() from `Delay myDelay(...)` and `myDelay.read(...)` (case-sensitive by default; PCRE `\\b` is purely word-boundary, not case-aware)."
  - "Suggestion line phrased with lowercase 'if this is a false positive' to match D-20 contract verbatim."
  - "Comment-stripping applied only to Checks 7/8 (regex passes); Check 9 walks `lines` directly with its own `//` skip guard so line numbers remain accurate."

patterns-established:
  - "Hoist function-local constants to module scope when multiple checks reuse them (Check 5 + Check 9 share _DECL_PREFIXES)"
  - "Code-text validators stay opaque — pattern-match never executes; regexes are bounded constant prefixes (no ReDoS surface)"

requirements-completed: [VALID-04, VALID-05]

# Metrics
duration: ~25min
completed: 2026-04-29
---

# Phase 29 Plan 02: GenExpr Checks 7/8/9 Summary

**Three new ERROR-level validators in `validate_genexpr` — `delay()` rejection, `clip()` rejection, and init-before-if/else flow analysis — wired automatically through `hooks.validate_code_file` for `.gendsp` files.**

## Performance

- **Duration:** ~25 min
- **Started:** 2026-04-29T01:00:00Z
- **Completed:** 2026-04-29T01:24:40Z
- **Tasks:** 3
- **Files modified:** 2

## Accomplishments

- Hoisted `_DECL_PREFIXES` from `validate_genexpr` local scope to module scope so Checks 5 and 9 share a single source of truth.
- Added module-level `_strip_line_comments` helper that lets regex passes ignore `//`-commented examples.
- Implemented Check 7 (delay rejection, D-14), Check 8 (clip rejection, D-15), and Check 9 (init-before-if/else, D-16/D-20) — all `level="error"` per D-19.
- Added 9 new test cases under `TestGenExprChecks` plus a `.gendsp` round-trip test (`TestValidateCodeFile.test_gendsp_with_delay_blocks`) confirming Check 7 pipes through `hooks.validate_code_file`.
- Updated `validate_genexpr` docstring to enumerate all 9 active checks.

## Task Commits

Each task was committed atomically:

1. **Task 1: Hoist `_DECL_PREFIXES` + add `_strip_line_comments` helper** — `40b727a` (refactor)
2. **Task 3 (RED): TestGenExprChecks + .gendsp round-trip test class** — `e0e1446` (test)
3. **Task 2 (GREEN): Checks 7, 8, 9 in validate_genexpr** — `91d004f` (feat)
4. **Docstring sync (deviation Rule 2)** — `290d933` (docs)

_Note: Task 3 was committed before Task 2 to honor the plan's TDD posture — tests fail RED, then implementation lands GREEN._

## Files Created/Modified

- `src/maxpat/code_validation.py` — Module-level `_DECL_PREFIXES` constant, `_strip_line_comments` helper, three new ERROR checks (7, 8, 9), updated docstring.
- `tests/test_code_validation.py` — New `TestGenExprChecks` class (9 tests) + `test_gendsp_with_delay_blocks` method on existing `TestValidateCodeFile`.

## Decisions Made

- **Reused existing `TestValidateCodeFile` class** for the round-trip test rather than declaring a duplicate. The plan listed `class TestValidateCodeFile` as a new class; the file already had one. Adding `test_gendsp_with_delay_blocks` as a new method on the existing class satisfies all acceptance criteria and avoids redefining the class.
- **Lowercase "if this is a false positive"** in Check 9 message — D-20 contract specifies the literal substring lowercase, so the suggestion sentence is rephrased ("Restructure to assign … or if this is a false positive …") to keep it grammatical.

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 2 — Missing critical] Updated `validate_genexpr` docstring to list Checks 6/7/8/9**
- **Found during:** Task 2 (GREEN) verification
- **Issue:** Plan added Checks 7/8/9 to runtime but docstring still listed only Checks 1–5; out-of-sync developer-facing documentation would mislead consumers of the function.
- **Fix:** Extended the docstring's check inventory to include Checks 6, 7, 8, 9 with severity tags and D-NN citations.
- **Files modified:** `src/maxpat/code_validation.py`
- **Verification:** `python3 -m pytest tests/test_code_validation.py -q` (32 passed).
- **Committed in:** `290d933`

**2. [Plan ambiguity reconciled — message text]** Plan `<action>` block for Check 9 used `"If this is a false positive"` (capital I), but D-20 contract and test 8 require lowercase `"if this is a false positive"`. Followed the contract (must_haves D-20 + Test 8 assertion) and rephrased the suggestion sentence so the lowercase substring appears verbatim.
- **Found during:** Task 2 implementation
- **Fix:** Restructured suggestion line: `"… Restructure to assign '{name}' before the if/else, or if this is a false positive (e.g., shadowed inner declaration), declare via Param/History/Delay/Buffer/Data."`
- **Verification:** `test_check9_suggestion_documents_limitations` passes; D-20 substring contract satisfied.
- **Committed in:** `91d004f`

---

**Total deviations:** 2 auto-fixed (1 missing-critical doc sync, 1 plan-ambiguity reconciliation)
**Impact on plan:** Both deviations preserved D-NN contracts and developer experience. No scope creep.

## Issues Encountered

- During scope-boundary regression check, `tests/test_critics.py::TestPackageCritic::test_community_unextracted_warning` failed. Verified pre-existing (failure also occurs on the base commit `427a21e` against unmodified `code_validation.py` and `test_code_validation.py`). Logged as out-of-scope; no action taken.
- A mid-task `git checkout 427a21e -- src/maxpat/code_validation.py tests/test_code_validation.py` (run to confirm pre-existing failure) reverted Task 2 implementation in the worktree. Reapplied via Edit; final state verified by full test pass (32/32 in `test_code_validation.py`).

## Threat Flags

None — Plan 29-02's threat model (T-29-02, accepted) covers the regex passes; no new network/auth/file surface introduced.

## User Setup Required

None — pure validator extension, no external services.

## Next Phase Readiness

- VALID-04 (code-side half) and VALID-05 (severity ERROR for Checks 7/8/9) are satisfied.
- Plan 29-05 (embedded codebox walker) can re-emit these same `validate_genexpr` ValidationResults without modification — Check 7/8/9 contract messages match exactly.
- D-14, D-15, D-16, D-19, D-20 contracts implemented verbatim in source; Plan 05 tests can assert against the same literal substrings.

## Self-Check: PASSED

- File `src/maxpat/code_validation.py` modified — FOUND
- File `tests/test_code_validation.py` modified — FOUND
- Commit `40b727a` (Task 1) — FOUND
- Commit `e0e1446` (Task 3 RED) — FOUND
- Commit `91d004f` (Task 2 GREEN) — FOUND
- Commit `290d933` (docstring sync) — FOUND
- All 32 tests in `tests/test_code_validation.py` pass — VERIFIED
- 9 `TestGenExprChecks` tests + 1 `.gendsp` round-trip test pass — VERIFIED

---
*Phase: 29-validator-depth*
*Completed: 2026-04-29*
