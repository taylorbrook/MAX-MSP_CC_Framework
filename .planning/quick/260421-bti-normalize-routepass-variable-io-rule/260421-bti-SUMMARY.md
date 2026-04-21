---
id: 260421-bti
title: Normalize routepass variable_io rule (DQ-02 judgment)
date: 2026-04-21
status: complete
type: quick
commits:
  - 62b2607 refactor(quick-260421-bti): DQ-02 — normalize routepass default_outlets to match DB entry
must_haves_verified:
  - routepass has explicit entry in overrides.json:variable_io_rules ✓
  - outlet_count formula is "arg_count+1" (supported by _apply_io_formula) ✓
  - default_outlets=2 (matches routepass DB entry) ✓
  - compute_io_counts("routepass", ["a","b"]) == (1, 3) ✓ (asserted by both b3a and bti tests)
---

# Summary

Closed the last judgment-required item from REVIEW-260420-j15 DQ-02 (routepass formula-naming normalization).

## What changed

**overrides.json:variable_io_rules.routepass:**
- `default_outlets`: 3 → 2 (aligns with routepass DB entry's 2 outlets)
- `description` updated to note the 2-outlet default
- `_audit` block extended to cite quick-260421-bti alongside review-260421-b3a

**tests/test_db_lookup.py:**
- Added `test_compute_io_counts_routepass_normalized_default_outlets` — asserts `compute_io_counts("routepass", ["a","b"]) == (1, 3)` with a docstring anchoring this quick task's spec.

## State on entry (important context)

The core normalization — lifting routepass into `overrides.json:variable_io_rules` with the `arg_count+1` formula — already shipped in **quick-260421-b3a (commit 9a0b1f5)** as part of the FN-01/DQ-02 bundle. That commit also added a regression test (`test_compute_io_counts_routepass_uses_loaded_formula` at tests/test_db_lookup.py:307) asserting the exact `(1, 3)` invariant the user specified.

This quick task therefore executed two residual normalizations:
1. `default_outlets` field aligned with the routepass DB entry (cosmetic — `arg_count+1` formula never falls through to `default_outlets`, so behaviorally identical).
2. New test explicitly tied to quick-260421-bti to provide a traceable regression signal if default_outlets ever drifts again.

## Verification

```
$ pytest tests/test_db_lookup.py -x -q
..........................                                               [100%]
26 passed in 0.56s
```

25 baseline tests (from b3a) + 1 new bti test.

## Behavior check

```
compute_io_counts("routepass", []) = (1, 1)      # formula: len([])+1 = 1
compute_io_counts("routepass", ["a","b"]) = (1, 3)   # formula: len(["a","b"])+1 = 3  ✓
compute_io_counts("routepass", ["a","b","c"]) = (1, 4)   # formula: 3+1 = 4
```

`default_outlets=2` is unreferenced by the formula path but now documents the natural-default invariant for the object.

## Next

None. DQ-02's remaining judgment item (`o.route` with `io_rule: None` — Odot package) is independent and still deferred per the original review.
