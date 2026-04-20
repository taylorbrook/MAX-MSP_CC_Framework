---
quick_id: 260420-lla
description: Fix compute_io_counts FN-03 + FN-04 bugs and add regression tests
date: 2026-04-20
status: complete
commits:
  - b02d33e — fix FN-03 (arg_count empty-args)
  - 039a5ba — fix FN-04 (first_arg non-integer warning)
  - 8b0c310 — TC-01 + TC-02 regression tests + FN-01 update
files_changed:
  - src/maxpat/db_lookup.py
  - tests/test_db_lookup.py
tests:
  before: 13 (12 baseline + 1 FN-01 regression)
  after: 22 (12 baseline + 1 FN-01 updated + 9 new TC-01/TC-02)
  status: passed
---

# Summary — Quick Task 260420-lla

## What changed

Three commits closing two `_apply_io_formula` correctness bugs and adding the missing direct test coverage for `compute_io_counts` + `get_outlet_types` flagged by REVIEW 260420-j15.

### FN-03 — `arg_count` / `arg_count+1` always evaluate the formula

`db_lookup.py:362-366`. Replaced the `if args else default` short-circuit with literal formula evaluation:

```python
# Before
if formula == "arg_count":
    return len(args) if args else default
if formula == "arg_count+1":
    return (len(args) + 1) if args else default

# After
if formula == "arg_count":
    return len(args)
if formula == "arg_count+1":
    return len(args) + 1
```

**Behavioral shift (intentional):**
- `compute_io_counts("route", []) == (1, 1)` (was `(1, 3)`)
- `compute_io_counts("trigger", []) == (1, 0)` (was `(1, 2)`)
- `compute_io_counts("combine", []) == (0, 1)` (was `(2, 1)`)

The empty-args path now reflects what the formula actually evaluates to. Callers that depended on the default-fallback behavior should pass real args or rely on the per-rule defaults via the `fixed:`/`first_arg`/`second_arg` formulas (which still fall back to `default` for malformed input).

### FN-04 — `first_arg` warns on non-integer args

`db_lookup.py:368-374`. Replaced the silent `default` fallback with a one-time UserWarning per `(formula, raw_arg)` tuple:

```python
if formula == "first_arg":
    if not args:
        return default
    try:
        return int(args[0])
    except ValueError:
        self._warn_non_integer_first_arg(formula, args[0], default)
        return default
```

New helper `_warn_non_integer_first_arg` mirrors the existing `_maybe_warn_empty_io` shape (instance dedup set, `warnings.warn(..., UserWarning, stacklevel=4)`). `stacklevel=4` (not 3) accounts for the deeper call path: user → `compute_io_counts` → `_apply_io_formula` → helper.

Added `self._first_arg_warned: set[tuple[str, str]] = set()` to `__init__`.

Dropped the unreachable `IndexError` from the `except` clause — the `if not args` guard makes `args[0]` safe.

### TC-01 + TC-02 — Tests

`tests/test_db_lookup.py`. Added 9 new tests:

| # | Test | Covers |
|---|------|--------|
| 1 | `test_compute_io_counts_unknown_object_returns_zero_zero` | unknown → (0, 0) |
| 2 | `test_compute_io_counts_non_variable_io_returns_db_arrays` | cycle~ ignores args, returns (2, 1) |
| 3 | `test_compute_io_counts_trigger_with_full_args` | trigger b i f → (1, 3) |
| 4 | `test_compute_io_counts_trigger_no_args_post_fn03` | FN-03 regression: trigger [] → (1, 0) |
| 5 | `test_compute_io_counts_route_no_args_post_fn03` | FN-03 regression: route [] → (1, 1) |
| 6 | `test_get_outlet_types_all_signal` | cycle~ → ["signal"] |
| 7 | `test_get_outlet_types_mixed_signal_and_control` | sfplay~ contains both "signal" and "" |
| 8 | `test_get_outlet_types_variable_expansion_inherits_control` | trigger b i f → ["", "", ""] |
| 9 | `test_get_outlet_types_unknown_returns_empty` | unknown → [] |

Updated existing `test_compute_io_counts_honors_overrides_rules_for_lifted_objects` to reflect the FN-03 semantic shift (`combine([]) == (0, 1)`, not `(2, 1)`).

## Verification

```
pytest tests/test_db_lookup.py -x -v
22 passed in 0.52s
```

All previously-passing tests still pass; 9 new tests added; 1 existing test updated for FN-03 semantics.

## Out of scope (deferred)

- The other 4 `_apply_io_formula` branches (`fixed:`, `first_arg+1`, `second_arg`) were not changed. Their `default` fallback for malformed input is consistent with FN-04's chosen semantics (warn then default); future cleanup can mirror the new pattern.
- No data changes (overrides.json, per-domain JSON).
- DQ-* findings from REVIEW 260420-j15 already applied or deferred per that review.
