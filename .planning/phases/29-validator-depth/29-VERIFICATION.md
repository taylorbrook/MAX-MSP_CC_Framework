---
phase: 29-validator-depth
verified: 2026-04-28T00:00:00Z
status: passed
score: 11/11 must-haves verified
overrides_applied: 0
---

# Phase 29: Validator Depth Verification Report

**Phase Goal:** Validators and critics read the new schema and produce specific, actionable errors instead of generic type-mismatch warnings; external `.gendsp` files get the same DSP rigor as embedded codeboxes
**Verified:** 2026-04-28
**Status:** PASSED
**Re-verification:** No — initial verification

## Goal Achievement

### Observable Truths

| # | Truth | Status | Evidence |
|---|-------|--------|----------|
| 1 | VALID-01: Layer 3 emits role-aware errors with suggestions instead of generic type-mismatch | VERIFIED | `_ROLE_TIER_TABLE` at validation.py:54; tier dispatch at line 533; `TestRoleAwareValidation` (10 tests, all pass) |
| 2 | VALID-02: Domain-restricted guard hard-blocks RNBO-only objects at MSP top level | VERIFIED | `_validate_domain_restrictions` at validation.py:834; call site at line 176; `TestDomainGuard` (5 tests, all pass); `floor~` emits `[domain:error]` with restriction list |
| 3 | VALID-03: Lookup-time install-state warnings fire for `verified_installed: false` objects | VERIFIED | `_maybe_warn_install_state` at db_lookup.py:406; `_install_warned` cache at line 91; 3 call sites in `lookup()`; `TestInstallWarning` (6 tests, all pass) |
| 4 | VALID-04: External `.gendsp` files validated same as embedded codeboxes (Checks 7/8/9) | VERIFIED | `validate_genexpr` Checks 7/8/9 at code_validation.py:210-290; `_validate_embedded_genexpr` walker at validation.py:877; `TestGenExprChecks` (9 tests) + `TestEmbeddedGenExpr` (8 tests), all pass |
| 5 | VALID-05: Severity vocabulary consistent across all check families | VERIFIED | ERROR tier in tier table (auto_fix=True); WARNING tier (auto_fix=False); install state = UserWarning (not ValidationResult); domain guard = always ERROR + auto_fixed=False; Checks 7/8/9 = always level="error" |
| 6 | D-09/D-10/D-11/D-12: install warning once-per-name, silent on None, UserWarning category, no ValidationResult | VERIFIED | `is not False` guard at db_lookup.py:418; `_install_warned` dedup; `test_no_validation_result_emitted` passes |
| 7 | D-13/D-17: validate_genexpr is single entry point; walker re-emits tagged findings with layer="code" | VERIFIED | Deferred import in `_validate_embedded_genexpr` at validation.py:902; re-emission with `gen~ '{gen_id}' codebox:` tag at line 933 |
| 8 | D-07: Domain guard + codebox walker are top-level only, no recursion into subpatchers | VERIFIED | `test_floor_tilde_in_gen_subpatcher_silent` passes; `test_gen_without_codebox_silent` passes |
| 9 | D-02: Role check runs first; audio and None sources fall through to legacy branch unchanged | VERIFIED | `src_role != "audio"` guard at validation.py:542; `test_audio_to_signal_silent_via_legacy` passes; `test_uncurated_role_falls_through` passes |
| 10 | Audio-key invariant: `_ROLE_TIER_TABLE` contains no `("audio", *)` keys | VERIFIED | `python3 -c "from src.maxpat.validation import _ROLE_TIER_TABLE; assert ('audio','signal') not in _ROLE_TIER_TABLE"` passes |
| 11 | Check 9 false-positive limitation documented in error message | VERIFIED | `"if this is a false positive"` substring at code_validation.py:277; `test_check9_suggestion_documents_limitations` passes |

**Score:** 11/11 truths verified

### Required Artifacts

| Artifact | Expected | Status | Details |
|----------|----------|--------|---------|
| `src/maxpat/db_lookup.py` | `_install_warned` cache + `_maybe_warn_install_state` helper + 3 call sites | VERIFIED | Line 91 (cache), 406 (helper), 331/336/341 (3 call sites); `is not False` guard at 418 |
| `src/maxpat/code_validation.py` | `_DECL_PREFIXES` module-level + `_strip_line_comments` + Checks 7/8/9 | VERIFIED | Lines 43/46/210/220/225 present; `_DECL_PREFIXES` is module-level (not local) |
| `src/maxpat/validation.py` | `_ROLE_TIER_TABLE` + `_classify_dst_inlet` + `_classify_role_mismatch` + tier dispatch | VERIFIED | Lines 54/640/684/533; tier dispatch in `_validate_connections` |
| `src/maxpat/validation.py` | `_validate_domain_restrictions` + call site | VERIFIED | Lines 834/176 |
| `src/maxpat/validation.py` | `_validate_embedded_genexpr` + call site | VERIFIED | Lines 877/179 |
| `tests/test_schema_extensions.py` | `TestInstallWarning` + `TestInstallWarningSurface` (6+ tests) | VERIFIED | Lines 463/486; 8 tests total, all pass |
| `tests/test_code_validation.py` | `TestGenExprChecks` (9 tests) + `TestValidateCodeFile.test_gendsp_with_delay_blocks` | VERIFIED | Lines 88/408; 10 new tests, all pass |
| `tests/test_validation.py` | `TestRoleAwareValidation` (10 tests) | VERIFIED | Line 294; all 10 pass |
| `tests/test_validation.py` | `TestDomainGuard` (5 tests) | VERIFIED | Line 628; all 5 pass |
| `tests/test_validation.py` | `TestEmbeddedGenExpr` (8 tests) | VERIFIED | Line 753; all 8 pass |

### Key Link Verification

| From | To | Via | Status | Details |
|------|----|-----|--------|---------|
| `ObjectDatabase.lookup()` | `_maybe_warn_install_state` | 3 call sites in `lookup()` after each `_maybe_warn_empty_io` | WIRED | Confirmed: 3 call sites at lines 331, 336, 341 |
| `_maybe_warn_install_state` | `self._install_warned` | `is not False` guard + set dedup | WIRED | Lines 418-422 |
| `validate_genexpr` | `_strip_line_comments` | Called at function entry (line 90); Checks 7/8 use `code_stripped` | WIRED | Line 90 confirmed |
| `validate_genexpr` | `_DECL_PREFIXES` (module-level) | Check 9 declaration-exemption scan | WIRED | Module-level at line 43; Check 9 uses it via `re.finditer` |
| `_validate_connections` | `_classify_role_mismatch` | Tier dispatch block ahead of legacy `is_signal_source` branch | WIRED | Line 543; `src_role != "audio"` guard at 542 |
| `_classify_role_mismatch` | `_ROLE_TIER_TABLE` | `dict.get((src_role, dst_kind))` | WIRED | `_ROLE_TIER_TABLE.get` in `_classify_role_mismatch` body |
| `_classify_role_mismatch` | `db.get_signal_role` | Phase 28 getter consumed in tier dispatch | WIRED | Line 541 in `_validate_connections` |
| `validate_patch` | `_validate_domain_restrictions` | `results.extend(...)` call after `_validate_domain_rules` | WIRED | Line 176 |
| `_validate_domain_restrictions` | `db.get_domain_restrictions` | Per-box restriction lookup | WIRED | Line 858 |
| `validate_patch` | `_validate_embedded_genexpr` | `results.extend(...)` call after `_validate_domain_restrictions` | WIRED | Line 179 |
| `_validate_embedded_genexpr` | `validate_genexpr` (code_validation.py) | Deferred import inside function | WIRED | Line 902 — avoids circular import |

### Data-Flow Trace (Level 4)

Not applicable — all phase 29 artifacts are validators (pure function pipelines consuming dict input and returning ValidationResult lists). No state/props rendered to UI. Data-flow Level 4 is for components rendering dynamic data from external sources.

### Behavioral Spot-Checks

| Behavior | Command | Result | Status |
|----------|---------|--------|--------|
| `db.lookup('bach.llll2list')` emits exactly 1 UserWarning, second call silent | `python3 -c "..."` runtime probe | 1 warning captured, second lookup silent | PASS |
| `validate_genexpr` Check 7: `delay()` → ERROR | `validate_genexpr('out1 = delay(in1, 100);')` | `[code:error]` with `"delay() is not supported in GenExpr codebox"` | PASS |
| `validate_genexpr` Check 8: `clip()` → ERROR | `validate_genexpr('out1 = clip(in1, 0., 1.);')` | `[code:error]` with `"clip() does not exist in expr/GenExpr"` | PASS |
| `validate_genexpr` Check 9: init-before-if → ERROR | Multi-line code with bare if-block assignment | `[code:error]` with `"variable 'y' used inside if/else without prior init"` | PASS |
| Comment-skip: `// delay(...)` in code does not trigger Check 7 | `validate_genexpr('// out1 = delay(...);...')` | No delay() error emitted | PASS |
| Domain guard: `floor~` at top level → `[domain:error]` with restriction list | `validate_patch(patch, db=db)` | Exactly 1 domain error with `"['rnbo']"` and `"Wrap in"` | PASS |
| Embedded walker: gen~ codebox with `delay(` → tagged `[code:error]` | `validate_patch(patch_with_gen_codebox, db=db)` | `"gen~ 'g1' codebox: delay() is not supported..."` | PASS |
| `_ROLE_TIER_TABLE` has no `("audio", *)` keys | `assert ('audio','signal') not in _ROLE_TIER_TABLE` | No audio keys found | PASS |

### Requirements Coverage

| Requirement | Source Plan | Description | Status | Evidence |
|-------------|------------|-------------|--------|----------|
| VALID-01 | 29-03 | Role-aware connection errors with suggestions | SATISFIED | `_ROLE_TIER_TABLE`, tier dispatch, `TestRoleAwareValidation` (10 tests pass) |
| VALID-02 | 29-04 | Domain-restricted guard for RNBO-only objects | SATISFIED | `_validate_domain_restrictions`, `TestDomainGuard` (5 tests pass) |
| VALID-03 | 29-01 | Install-state UserWarning at lookup time | SATISFIED | `_maybe_warn_install_state`, `TestInstallWarning` (6 tests pass) |
| VALID-04 | 29-02, 29-05 | .gendsp + embedded codebox DSP parity (Checks 7/8/9) | SATISFIED | `validate_genexpr` Checks 7-9, `_validate_embedded_genexpr` walker, 17 new tests pass |
| VALID-05 | 29-01 through 29-05 | Consistent severity vocabulary across all families | SATISFIED | ERROR tier (auto_fix=True); WARNING tier (auto_fix=False); UserWarning install; D-19 enforced per test class |

### Anti-Patterns Found

| File | Line | Pattern | Severity | Impact |
|------|------|---------|----------|--------|
| `src/maxpat/code_validation.py` | 202 | Empty-I/O `UserWarning` for object `'read'` during Check 6 operator validation | Info | Pre-existing; fired when `db.lookup('read')` returns a zero-I/O entry. Not introduced by phase 29. No functional impact on Check 7/8/9 results. |
| `src/maxpat/validation.py` | 617 | Empty-I/O `UserWarning` for `'print'` and `'send~'` during Layer 3 signal-type check | Info | Pre-existing; `print` and `send~` have empty-I/O DB entries. Not introduced by phase 29. |

No stubs, no placeholder implementations, no TODO/FIXME markers in any phase 29 modified files.

### Human Verification Required

None. All observable truths are verifiable programmatically via the test suite and behavioral spot-checks. No UI rendering, no real-time behavior, no external service calls introduced by this phase.

### Gaps Summary

No gaps. All 5 plans executed to completion. All VALID-01 through VALID-05 requirements satisfied. The 2 pre-existing `TestCommunityPackageBlock` failures in `test_validation.py` are documented in `deferred-items.md` and confirmed pre-existing at base commit `427a21e` — not introduced by phase 29. The broader suite (184 pass, 2 fail) matches the documented pre-existing regression boundary.

---

_Verified: 2026-04-28_
_Verifier: Claude (gsd-verifier)_
