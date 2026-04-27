---
phase: quick-260427-knk
verified: 2026-04-27T22:00:00Z
status: passed
score: 6/6 must-haves verified
overrides_applied: 0
---

# Quick 260427-knk: Layer-2 Maxclass Validation Check — Verification Report

**Phase Goal:** Add a Layer-2 check in `src/maxpat/validation.py` that verifies `maxclass=='newobj'` for any object whose name is NOT in `UI_MAXCLASSES`. Catch the residual maxclass-confusion bug class. Emit `ValidationResult` error with the wrong-maxclass→correct-pair info. Add tests for both directions: UI widget passes; non-UI object with own-name maxclass fails. Reference: FINDINGS P1-5.

**Verified:** 2026-04-27
**Status:** passed
**Re-verification:** No — initial verification

## Goal Achievement

### Observable Truths

| # | Truth | Status | Evidence |
|---|-------|--------|----------|
| 1 | `_validate_maxclass_usage` emits `level='error'` for non-structural, non-newobj, non-UI maxclass | VERIFIED | `src/maxpat/validation.py:300` — `ValidationResult("objects", "error", ...)`. Docstring at line 271 explicitly states "Emits ``error`` (not warning)". Test `test_non_ui_object_wrong_maxclass_triggers_error` passes asserting exactly one `level=="error"` result. |
| 2 | Error message includes both wrong pair AND correct pair (with `text='<name> ...'`) | VERIFIED | `src/maxpat/validation.py:301-304` — message string contains `maxclass='{maxclass}'` AND `maxclass='newobj' with text='{name} ...'`. Test `test_error_message_includes_correct_pair` (lines 1112-1131) asserts `"maxclass='cycle~'"`, `"maxclass='newobj'"`, AND `"text='cycle~"` all appear in the message. |
| 3 | Boxes with embedded `patcher` key are skipped | VERIFIED | `src/maxpat/validation.py:286-287` — `if "patcher" in box: continue` after the structural check, before the newobj/UI checks. Test `test_subpatcher_container_with_patcher_key_passes` (lines 1096-1110) asserts a `gen~` maxclass with `patcher: {boxes: [], lines: []}` produces 0 maxclass errors. |
| 4 | `UI_MAXCLASSES` includes `playlist~`, `dict.view`, `dada.bounce`, `bach.roll` | VERIFIED | `src/maxpat/maxclass_map.py:52-56` — all four names present under "Specialty / package UI widgets" section. Comments document each (`Max-bundled clip-player`, `Max-bundled dict viewer`, `dada package physics-balls`, `bach package notation-roll`). |
| 5 | `TestMaxclassUsage` has 8 tests covering both directions | VERIFIED | 8 tests confirmed in `tests/test_validation.py:973-1131`: (a) `test_non_ui_object_wrong_maxclass_triggers_error`, (b) `test_ui_object_own_maxclass_no_error`, (c) `test_structural_maxclass_no_error`, (d) `test_standard_newobj_no_error`, (e) `test_ui_widgets_button_dial_gain_pass`, (f) `test_multiple_non_ui_own_maxclass_each_errors`, (g) `test_subpatcher_container_with_patcher_key_passes`, (h) `test_error_message_includes_correct_pair`. All 8 pass: `pytest tests/test_validation.py::TestMaxclassUsage -v` → `8 passed in 0.04s`. |
| 6 | No regressions caused by this plan | VERIFIED | Full validation suite: `82 passed, 2 failed`. The 2 failures (`TestCommunityPackageBlock::test_community_block_warning`, `TestCommunityPackageBlock::test_ircam_spat_specific_message`) confirmed pre-existing on base commit `980ca1c`. Direct invocation of `_validate_maxclass_usage` against all 27 real patches (`patches/*/generated/*.maxpat`) and all fixtures (`tests/fixtures/**/*.maxpat`) yields 0 maxclass errors. |

**Score:** 6/6 truths verified

### Required Artifacts

| Artifact | Expected | Status | Details |
|----------|----------|--------|---------|
| `src/maxpat/validation.py` | `_validate_maxclass_usage` updated (error level, patcher-key skip, new message) | VERIFIED | Lines 257-307. Skip at line 286 (`patcher` key), level=`"error"` at line 300, dual-pair message at lines 301-304. Docstring at lines 258-272 reflects new behavior. |
| `src/maxpat/maxclass_map.py` | `UI_MAXCLASSES` expanded with 4 package widgets | VERIFIED | Lines 52-56 add the 4 widgets in a dedicated "Specialty / package UI widgets" group. `frozenset` semantics preserved. |
| `tests/test_validation.py` | `TestMaxclassUsage` with 8 tests covering both directions | VERIFIED | Lines 973-1131. Class docstring updated to reflect hard-error semantics. 4 renamed (warning→error) + 4 new tests. |

### Key Link Verification

| From | To | Via | Status | Details |
|------|----|----|--------|---------|
| `validate_patch` (line 131) | `_validate_maxclass_usage` | `results.extend(...)` call | WIRED | Call site unchanged per plan. Layer 2b is invoked between Layer 2 (object existence) and Layer 2c (package gating). |
| `_validate_maxclass_usage` | `UI_MAXCLASSES` | `if maxclass in UI_MAXCLASSES` (line 294) | WIRED | Direct membership check against the expanded frozenset. |
| `_validate_maxclass_usage` | `_STRUCTURAL_MAXCLASSES` | `if maxclass in _STRUCTURAL_MAXCLASSES` (line 280) | WIRED | Pre-existing structural skip, unchanged. |
| TestMaxclassUsage | `validate_patch` (entry point) | All 8 tests call `validate_patch(patch, db=db)` | WIRED | Tests exercise the full validate_patch pipeline, not just the helper — proves the function is wired into the public API. |

### Behavioral Spot-Checks

| Behavior | Command | Result | Status |
|----------|---------|--------|--------|
| Focused test class passes | `pytest tests/test_validation.py::TestMaxclassUsage -v` | 8 passed in 0.04s | PASS |
| Full validation suite (no new regressions) | `pytest tests/test_validation.py -q` | 82 passed, 2 failed (both pre-existing on base) | PASS |
| 4 UI widget names membership check | `python3 -c "from src.maxpat.maxclass_map import UI_MAXCLASSES; print(all(n in UI_MAXCLASSES for n in ('playlist~','dict.view','dada.bounce','bach.roll')))"` | `True` | PASS |
| Real-patch direct check (27 patches) | Direct invocation of `_validate_maxclass_usage` on all `patches/*/generated/*.maxpat` | 0 errors | PASS |
| Fixture direct check | Direct invocation on `tests/fixtures/**/*.maxpat` | 0 errors | PASS |
| Error message contains both pairs | Test `test_error_message_includes_correct_pair` | passes | PASS |

### Anti-Patterns Found

None. The implementation follows existing patterns in the file:
- Returns `list[ValidationResult]` consistent with sibling functions.
- Iteration over `patch_dict["patcher"]["boxes"]` matches existing helpers.
- Skip conditions stack in the same order/style as `_validate_objects_exist`.
- No TODO/FIXME, no stubs, no console.log, no hardcoded test data outside tests.

### Pre-existing Failures (NOT caused by this plan)

Documented in SUMMARY.md and re-verified:

| Test | Failure | Pre-existing? |
|------|---------|---------------|
| `test_integration_patches.py::test_validate_patch_no_errors` (×27) | `TypeError: validate_patch() got an unexpected keyword argument 'patch_dir'` | YES — `validate_patch()` has no `patch_dir` kwarg in current code (line 76); test wrapper has stale API call. |
| `test_integration_patches.py::test_review_patch_no_blockers` (×14) | Fan-out without trigger blocker | YES — landed in `quick-260427-kbe` (commits `98bbc3a`/`a57acf4`). Real-patch fixtures need updating to the new severity. |
| `test_validation.py::TestCommunityPackageBlock::test_community_block_warning` | `assert 0 >= 1` (no warnings emitted) | YES — confirmed by checking out base commit `980ca1c` and re-running: same failure. Package-layer concern, unrelated to maxclass. |
| `test_validation.py::TestCommunityPackageBlock::test_ircam_spat_specific_message` | `assert 0 >= 1` | YES — same as above; confirmed pre-existing on base. |

These do not affect goal achievement and are explicitly out-of-scope per the plan.

### Gaps Summary

None. All 6 must-haves verified. Implementation is complete, correct, well-tested, and produces zero false positives on the existing real-patch corpus. The error message format encodes a self-explaining wrong-pair → correct-pair contract with a pointer to the authoritative source. Subpatcher-container escape via `patcher` key correctly handles `gen~`/`poly~`/`rnbo~`/`codebox` embedded mode.

---

_Verified: 2026-04-27_
_Verifier: Claude (gsd-verifier)_
