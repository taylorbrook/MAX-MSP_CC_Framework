---
phase: 29-validator-depth
fixed_at: 2026-04-29T03:33:21Z
review_path: .planning/phases/29-validator-depth/29-REVIEW.md
iteration: 2
findings_in_scope: 8
fixed: 5
skipped: 0
status: all_fixed
---

# Phase 29: Code Review Fix Report

**Fixed at:** 2026-04-29T03:33:21Z
**Source review:** .planning/phases/29-validator-depth/29-REVIEW.md
**Iteration:** 2

**Summary:**
- Findings in scope: 8 (Warning: 3, Info: 5)
- Already fixed (iteration 1): 3
- Fixed this pass: 5
- Skipped: 0

This iteration extends fix coverage to the 5 Info findings that were
out-of-scope under iteration 1's `critical_warning` filter. The 3 Warning
findings were verified in source as still-present from iteration 1; no
re-application was needed.

## Already Fixed (Iteration 1)

### WR-01: Check 9 misreports line number when block_start_line is -1

**Files modified:** `src/maxpat/code_validation.py`
**Commit:** bbf44cc (iteration 1)
**Status:** verified-present
**Note:** The `^[}\s]*(if|else)\b` regex and `line_display` guard for
`block_start_line == -1` are both present at
`src/maxpat/code_validation.py:241-280` (the leading `^` was tightened
further this pass under IN-02, but the WR-01 semantics hold). No
re-application needed.

### WR-02: Check 9 misses single-line if/else assignments

**Files modified:** `tests/test_code_validation.py`
**Commit:** 1c61059 (iteration 1)
**Status:** verified-present
**Note:** `test_check9_single_line_if_block_false_negative` continues to
document the false-negative gap per the reviewer's recommended deferral.

### WR-03: Layer 5 walker assumes `inner` is dict-shaped

**Files modified:** `src/maxpat/validation.py`
**Commit:** f8ba5ca (iteration 1)
**Status:** verified-present
**Note:** The `if not isinstance(inner, dict): continue` guard is in
place at `src/maxpat/validation.py:919-927`.

## Fixed This Pass

### IN-01: Layer 5 walker docstring overstates duplicate-emission risk

**Files modified:** `src/maxpat/validation.py`
**Commit:** 76d0b7b
**Applied fix:** Replaced the docstring's overstated "ALSO fire on
embedded codeboxes" claim with the accurate description of the actual
overlap surface — the existing Layer 4 helpers iterate `box_lookup`
(top-level only) and match `maxclass=='newobj'` boxes, so embedded
codeboxes (`maxclass=='codebox'` inside `inner.boxes`) do NOT overlap in
the canonical case. Top-level codeboxes remain a rare corner case.

### IN-02: `re.match(r"\b(if|else)\b", ...)` has redundant leading word boundary

**Files modified:** `src/maxpat/code_validation.py`
**Commit:** 95b6a75
**Applied fix:** Dropped the redundant leading `^` anchor from the Check 9
if/else detection regex (`re.match` is already start-anchored). Added a
comment explaining the trailing `\b` is the meaningful guard against
matching tokens like `ifelse`. Behavior unchanged; 33 code-validation
tests pass.

### IN-03: `_apply_io_formula` `first_arg+1` and `second_arg` swallow IndexError unreachably

**Files modified:** `src/maxpat/db_lookup.py`
**Commit:** dc92a4f
**Applied fix:** Reshaped both branches to mirror the `first_arg`
pattern: explicit length guard returns `default`, then a `try/except
ValueError` calls `_warn_non_integer_first_arg(formula, args[i],
default)` and falls back to `default`. The dead `IndexError` clause is
gone, and malformed `first_arg+1` / `second_arg` formulas now surface a
UserWarning at lookup time (matching the `first_arg` channel).
Verification: 138 validation/code-validation tests pass; only the 2
pre-existing `TestCommunityPackageBlock` failures remain (out-of-scope
per REVIEW.md).

### IN-04: `_validate_domain_restrictions` would mis-flag a top-level subpatcher container

**Files modified:** `src/maxpat/validation.py`
**Commit:** 688e208
**Applied fix:** Added a `if "patcher" in box: continue` guard at the top
of the box loop, mirroring the escape hatch in `_validate_maxclass_usage`.
Subpatcher containers (gen~/rnbo~/m4l-anything) carry their own maxclass
legitimately and may someday acquire `domain_restricted` markers; the
guard prevents a false-positive against the canonical `gen~` /  `rnbo~`
at top level. Latent fix — no current overrides exercise the path.
Verification: 105 validation tests pass.

### IN-05: Unused captured `_dst_kind` in tier dispatch return

**Files modified:** `src/maxpat/validation.py`
**Commit:** 7818072
**Applied fix:** Refactored `_classify_role_mismatch` from a 4-tuple
return `(level, dst_kind, message, auto_fix)` to a 3-tuple
`(level, message, auto_fix)` — the `dst_kind` was already folded into
the pre-formatted message and the only caller discarded it as
`_dst_kind`. Updated the single caller in
`_validate_connection_bounds` (line 547). Updated docstring. Mechanical
change, no behavior delta. Verification: 138 validation/code-validation
tests pass.

---

_Fixed: 2026-04-29T03:33:21Z_
_Fixer: Claude (gsd-code-fixer)_
_Iteration: 2_
