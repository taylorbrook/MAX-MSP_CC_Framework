---
phase: quick-260322-dz9
verified: 2026-03-22T17:15:00Z
status: passed
score: 8/8 must-haves verified
re_verification: false
---

# Quick Task 260322-dz9: 8 New Validation Checks — Verification Report

**Task Goal:** Add 8 new validation checks for MAX API misunderstandings that currently slip through validation. Each check uses regex/string matching on patch content.
**Verified:** 2026-03-22T17:15:00Z
**Status:** passed
**Re-verification:** No — initial verification

## Goal Achievement

### Observable Truths

| # | Truth | Status | Evidence |
|---|-------|--------|----------|
| 1 | GenExpr codebox with 'in 1' or 'out 2' triggers error | VERIFIED | `_check_genexpr_io_syntax` at validation.py:779; regex `\b(in\|out)\s+\d`; tests pass |
| 2 | GenExpr codebox with delay() call triggers error | VERIFIED | `_check_genexpr_delay_usage` at validation.py:804; regex `\bdelay\s*\(`; tests pass |
| 3 | Message box with @param syntax connected to gen~ triggers warning | VERIFIED | `_check_gen_param_message_syntax` at validation.py:829; uses ctrl_adj to confirm gen~ destination; tests pass |
| 4 | Comment box with #N text triggers warning | VERIFIED | `_check_comment_hash_substitution` at validation.py:859; checks maxclass=="comment" only; tests pass |
| 5 | Message connected to line~ with comma separator triggers warning | VERIFIED | `_check_line_tilde_comma_messages` at validation.py:879; uses ctrl_adj to confirm line~ destination; tests pass |
| 6 | Message with fetchindex text triggers error | VERIFIED | `_check_multislider_fetchindex` at validation.py:909; literal string match; tests pass |
| 7 | umenu with plain items array (no comma separators) triggers warning | VERIFIED | `_check_umenu_items_format` at validation.py:929; checks both maxclass=="umenu" and newobj+text; tests pass |
| 8 | Inlet/outlet boxes without comment attribute trigger info note | VERIFIED | `_check_assistance_comments` at validation.py:959; checks maxclass in ("inlet","outlet"); tests pass |

**Score:** 8/8 truths verified

### Required Artifacts

| Artifact | Expected | Status | Details |
|----------|----------|--------|---------|
| `src/maxpat/validation.py` | 8 new validation sub-functions called from `_validate_domain_rules` | VERIFIED | All 8 `_check_*` functions present at lines 779-976; all 8 wired via `results.extend(...)` at lines 498-519 |
| `tests/test_validation.py` | Tests for all 8 checks with positive and negative cases | VERIFIED | `TestLayer4GenExprChecks` class at line 660; 21 test methods covering positive triggers, negative no-trigger, and edge cases |

### Key Link Verification

| From | To | Via | Status | Details |
|------|----|-----|--------|---------|
| `src/maxpat/validation.py` | `_validate_domain_rules` | `results.extend(_check_*` calls | VERIFIED | 8 calls at lines 498-519; pattern `results\.extend\(_check_` confirmed present |
| `_validate_domain_rules` | `ctrl_adj` | second loop over `lines` at line 457 | VERIFIED | `ctrl_adj: dict[str, list[str]] = defaultdict(list)` built at line 458; non-signal connections appended at line 480 |
| checks 3 and 5 | `ctrl_adj` | parameter passed to `_check_gen_param_message_syntax` and `_check_line_tilde_comma_messages` | VERIFIED | Both functions receive `ctrl_adj` as second argument; use `ctrl_adj.get(box_id, [])` to resolve destinations |

### Requirements Coverage

| Requirement | Description | Status | Evidence |
|-------------|-------------|--------|----------|
| VAL-GENEXPR-IO | GenExpr I/O syntax error | SATISFIED | `_check_genexpr_io_syntax` + 3 tests |
| VAL-GENEXPR-DELAY | GenExpr delay() usage error | SATISFIED | `_check_genexpr_delay_usage` + 2 tests |
| VAL-GEN-PARAM-MSG | gen~ @param message syntax warning | SATISFIED | `_check_gen_param_message_syntax` + 3 tests |
| VAL-COMMENT-HASH | Comment #N substitution warning | SATISFIED | `_check_comment_hash_substitution` + 2 tests |
| VAL-LINE-COMMA | line~ comma in messages warning | SATISFIED | `_check_line_tilde_comma_messages` + 2 tests |
| VAL-MULTISLIDER-FETCH | multislider fetchindex error | SATISFIED | `_check_multislider_fetchindex` + 2 tests |
| VAL-UMENU-ITEMS | umenu items format warning | SATISFIED | `_check_umenu_items_format` + 3 tests |
| VAL-ASSISTANCE-COMMENTS | Assistance comments info note | SATISFIED | `_check_assistance_comments` + 4 tests |

### Anti-Patterns Found

None. All 8 functions have real logic with regex/string matching. No stubs, placeholders, or empty returns.

### Human Verification Required

None — all checks are pure logic (regex + dict traversal) with no visual, real-time, or external service behavior.

### Test Suite Results

108 tests passed, 0 failed, 0 regressions.

- `tests/test_validation.py`: 64 tests (21 new in `TestLayer4GenExprChecks`)
- `tests/test_critics.py`: 44 tests (all pre-existing, all passing)

---

_Verified: 2026-03-22T17:15:00Z_
_Verifier: Claude (gsd-verifier)_
