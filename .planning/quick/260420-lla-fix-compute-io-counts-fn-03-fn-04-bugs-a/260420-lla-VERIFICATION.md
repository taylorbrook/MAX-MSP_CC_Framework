---
quick_id: 260420-lla
status: passed
date: 2026-04-20
---

# Verification — Quick Task 260420-lla

## 1. FN-03 fix actually applied — PASS

`src/maxpat/db_lookup.py:385-389` now reads literally:
```python
if formula == "arg_count":
    return len(args)
if formula == "arg_count+1":
    return len(args) + 1
```
The `if args else default` short-circuit is gone on both branches, matching the locked decision in PLAN.md.

## 2. FN-03 behavioral target hit — PASS

`compute_io_counts("route", []) == (1, 1)` confirmed via direct REPL invocation. Output: `OK route`.

## 3. FN-04 fix actually applied — PASS

- `_apply_io_formula` first_arg branch (`db_lookup.py:391-398`) now calls `self._warn_non_integer_first_arg(formula, args[0], default)` on `ValueError` (only — `IndexError` correctly dropped per the `if not args` guard).
- Helper `_warn_non_integer_first_arg` exists at `db_lookup.py:164-184` with `warnings.warn(..., UserWarning, stacklevel=4)` and per-(formula, raw_arg) dedup via `self._first_arg_warned`.
- `__init__` initializes `self._first_arg_warned: set[tuple[str, str]] = set()` at `db_lookup.py:48`.

## 4. FN-04 behavioral target hit — PASS

`compute_io_counts("cycle", ["XYZ"])` returns `(1, 2)` and emits exactly one `UserWarning` containing the substring `non-integer`. Output: `OK cycle warning`.

## 5. TC-01 + TC-02 tests exist and pass — PASS

`pytest tests/test_db_lookup.py -v` reports **22 passed in 0.56s**.

TC-01 (5 new compute_io_counts tests): `unknown_object_returns_zero_zero`, `non_variable_io_returns_db_arrays`, `trigger_with_full_args`, `trigger_no_args_post_fn03`, `route_no_args_post_fn03` — all passing.

TC-02 (4 new get_outlet_types tests): `all_signal`, `mixed_signal_and_control`, `variable_expansion_inherits_control`, `unknown_returns_empty` — all passing.

## 6. Scope discipline — PASS

`git log --oneline -5` shows three commits scoped to this quick (`b02d33e`, `039a5ba`, `8b0c310`). `git show --stat HEAD~2..HEAD` confirms only `src/maxpat/db_lookup.py` (commits 1+2) and `tests/test_db_lookup.py` (commit 3) were touched. No data files (overrides.json, per-domain JSON) modified.

## 7. Existing tests still pass — PASS

All 12 baseline empty-I/O / lookup / audit tests pass. `test_compute_io_counts_honors_overrides_rules_for_lifted_objects` passes with the updated `combine([]) == (0, 1)` assertion (db_lookup.py:226), reflecting the FN-03 semantic shift; the comment block above the assertion documents the FN-03 dependency for future readers.

## Summary

All 7 verification checks pass. The two correctness bugs are fixed exactly as specified, the 9 new regression tests exist and pass, the FN-01 test was correctly updated for the FN-03 semantic shift, and scope held to db_lookup.py + test_db_lookup.py only.
