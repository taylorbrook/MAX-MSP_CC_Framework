---
phase: 29-validator-depth
fixed_at: 2026-04-29T03:30:00Z
review_path: .planning/phases/29-validator-depth/29-REVIEW.md
iteration: 1
findings_in_scope: 3
fixed: 3
skipped: 0
status: all_fixed
---

# Phase 29: Code Review Fix Report

**Fixed at:** 2026-04-29T03:30:00Z
**Source review:** .planning/phases/29-validator-depth/29-REVIEW.md
**Iteration:** 1

**Summary:**
- Findings in scope: 3 (Critical: 0, Warning: 3)
- Fixed: 3
- Skipped: 0

Info findings (IN-01 through IN-05) were out of scope for this fix pass
(`fix_scope: critical_warning`).

## Fixed Issues

### WR-01: Check 9 misreports line number when block_start_line is -1

**Files modified:** `src/maxpat/code_validation.py`
**Commit:** bbf44cc
**Applied fix:**
- Updated the `if/else` opening detection regex to allow leading `}` and
  whitespace (`^[}\s]*(if|else)\b`), so `} else {` patterns at depth 0
  correctly update `block_start_line` instead of leaving it at `-1`.
- Added a `line_display` guard around the error message: when
  `block_start_line` is still `-1` at report time, the message now reads
  "in an if/else block" instead of the misleading "(line 0)".
- Per verification_strategy: this is a logic-adjacent fix (regex change
  affects which lines are tracked). Tier 1 + Tier 2 (python ast.parse +
  full pytest run on test_code_validation.py: 33 passed) both pass. No
  pre-existing tests regressed.

### WR-02: Check 9 misses single-line if/else assignments

**Files modified:** `tests/test_code_validation.py`
**Commit:** 1c61059
**Applied fix:**
- Followed the reviewer's recommendation to **document the gap rather
  than fix it** (the depth-walking heuristic is brittle by design --
  D-20). Added `test_check9_single_line_if_block_false_negative` that
  asserts the current behavior: a single-line `if (cond) { y = 1; }`
  construct is silently missed by the line-by-line walker. The test's
  failure message instructs future contributors to update it if they
  add inline-block scanning.
- The brittle inline-scan fix from the reviewer's secondary suggestion
  was deliberately NOT applied -- the recommendation explicitly defers
  the fix in favor of the documenting test.

### WR-03: Layer 5 walker assumes `inner` is dict-shaped

**Files modified:** `src/maxpat/validation.py`
**Commit:** f8ba5ca
**Applied fix:**
- Replaced `if not inner: continue` with `if not isinstance(inner, dict):
  continue`. This matches the defensive pattern in
  `_apply_signal_role_writethrough` and prevents an `AttributeError` on
  `.get()` if a malformed `.maxpat` file sets `"patcher": []` (truthy
  non-dict).
- Verified via Tier 1 (re-read modified section) + Tier 2 (python
  ast.parse + full pytest run on test_validation.py: 102 passed,
  excluding the 2 pre-existing `TestCommunityPackageBlock` failures
  documented as out-of-scope in REVIEW.md lines 47-48).

---

_Fixed: 2026-04-29T03:30:00Z_
_Fixer: Claude (gsd-code-fixer)_
_Iteration: 1_
