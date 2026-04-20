---
quick_id: 260420-lla
description: Fix compute_io_counts FN-03 + FN-04 bugs and add regression tests
date: 2026-04-20
mode: quick-full
must_haves:
  truths:
    - "FN-03: _apply_io_formula's `arg_count` and `arg_count+1` branches return `default` when `args` is empty, instead of evaluating the formula. This causes `compute_io_counts('route', []) == (1, 3)` when MAX semantics demand `(1, 1)` (1 unmatched outlet)."
    - "FN-04: _apply_io_formula's `first_arg` branch silently returns `default` when args[0] is non-integer (e.g. `funnel XYZ`). Malformed patches pass through with no signal."
    - "TC-01 / TC-02: compute_io_counts and get_outlet_types have zero direct test coverage today. tests/test_db_lookup.py covers only has_complete_io, lookup, audit_empty_io, plus one FN-01 regression."
    - "Existing _maybe_warn_empty_io pattern (db_lookup.py:138-161) is the precedent for raising UserWarning at runtime — use the same warnings.warn(..., UserWarning, stacklevel=3) shape for FN-04."
  artifacts:
    - "src/maxpat/db_lookup.py — _apply_io_formula behavior changes for arg_count, arg_count+1, first_arg branches"
    - "tests/test_db_lookup.py — new TC-01 (compute_io_counts) and TC-02 (get_outlet_types) test groups"
  key_links:
    - ".planning/quick/260420-j15-review-the-objects-database-entries-and-/260420-j15-REVIEW.md (FN-03, FN-04, TC-01, TC-02)"
    - "src/maxpat/db_lookup.py:337-392 (_apply_io_formula)"
    - "src/maxpat/db_lookup.py:138-161 (_maybe_warn_empty_io — UserWarning precedent)"
    - "tests/test_db_lookup.py:201-228 (existing FN-01 regression test as the test-style precedent)"
---

# Quick Task 260420-lla: Fix compute_io_counts FN-03 + FN-04 bugs

## Goal

Close two correctness gaps in `_apply_io_formula` (db_lookup.py) and add the missing direct test coverage for `compute_io_counts` + `get_outlet_types` flagged by REVIEW 260420-j15.

## Context

REVIEW 260420-j15 (FN-03, FN-04) flagged two `_apply_io_formula` branches that mishandle empty/malformed args:

**FN-03** — `arg_count` and `arg_count+1` branches:
```python
if formula == "arg_count":
    return len(args) if args else default
if formula == "arg_count+1":
    return (len(args) + 1) if args else default
```
The `if args else default` short-circuit is unprincipled. When the formula IS `len(args)`, returning `default` for the empty-args case produces wrong counts. Concretely: `route` (`outlet_count="arg_count+1"`, `default_outlets=3`) returns `(1, 3)` for `compute_io_counts("route", [])`, but a no-arg `route` in MAX has 1 unmatched outlet — the correct count is `(1, 1)`.

**FN-04** — `first_arg` branch:
```python
if formula == "first_arg":
    if args:
        try:
            return int(args[0])
        except (ValueError, IndexError):
            return default
    return default
```
Returns `default` silently when args[0] is non-integer. A user who writes `funnel XYZ` gets `(2, 1)` with no warning — malformed patch, no signal.

**TC-01 / TC-02** — `compute_io_counts` and `get_outlet_types` have zero direct test coverage today. tests/test_db_lookup.py only tests `has_complete_io`, `lookup`, `audit_empty_io`, and one FN-01 regression for the lifted `cycle/combine/router` rules.

## Decisions (locked from review)

- **FN-03:** Always evaluate the formula. Drop the `if args else default` short-circuit on `arg_count` and `arg_count+1`. Empty args → `len([]) = 0` for `arg_count`, `0 + 1 = 1` for `arg_count+1`. Verification target: `compute_io_counts("route", []) == (1, 1)`.
- **FN-04:** Warn (UserWarning), do not raise. Mirror the `_maybe_warn_empty_io` pattern: `warnings.warn(msg, UserWarning, stacklevel=3)`. After warning, fall back to `default` (preserves caller robustness — the warning is the signal). Use a per-(canonical, args[0]) dedup set so repeat lookups don't spam.
- **TC-01:** Tests must cover variable_io with full args (`trigger ["b","i","f"] → (1, 3)`), no args after FN-03 fix (`route → (1, 1)`, `trigger → (1, 2)`), non-variable_io (`cycle~ → (2, 1)`), unknown objects (`__missing__ → (0, 0)`).
- **TC-02:** Tests must cover all-signal (`cycle~ → ["signal"]`), mixed (`sfplay~` — at least one signal + at least one control), variable expansion (`trigger ["b","i","f"] → ["", "", ""]`).

## Out of Scope

- FN-04 dedup behavior is a quality-of-life affordance, not a correctness requirement. If the warn dedup causes test friction, drop it and re-warn each call.
- The other 4 `_apply_io_formula` branches (`fixed:`, `first_arg+1`, `second_arg`) are NOT changed — only the three branches called out by FN-03/FN-04. Their `default` fallback for malformed input is consistent with FN-04's chosen semantics (warn then default), so future cleanup can mirror this pattern; deferred.
- No data changes (overrides.json, per-domain JSON). This task is `db_lookup.py` + tests only.
- DQ-* findings from the same review are already applied or deferred; not in scope.

## Tasks

### Task 1 — Fix FN-03 (arg_count / arg_count+1 empty-args semantics)

**Files:**
- src/maxpat/db_lookup.py (modify `_apply_io_formula`, lines ~362-366)

**Action:**
Replace:
```python
if formula == "arg_count":
    return len(args) if args else default

if formula == "arg_count+1":
    return (len(args) + 1) if args else default
```
With:
```python
if formula == "arg_count":
    return len(args)

if formula == "arg_count+1":
    return len(args) + 1
```

The `default` parameter is still used by `fixed:`, `first_arg`, `first_arg+1`, `second_arg` branches and the catch-all `return default` at the bottom — keep the parameter signature unchanged.

**Verify:**
```bash
python -c "
from src.maxpat.db_lookup import ObjectDatabase
db = ObjectDatabase()
assert db.compute_io_counts('route', []) == (1, 1), db.compute_io_counts('route', [])
assert db.compute_io_counts('trigger', []) == (1, 0), db.compute_io_counts('trigger', [])
print('FN-03 verified')
"
```
Note: `trigger` no-args goes from `(1, 2)` (default) to `(1, 0)` (formula). The REVIEW notes this is the unprincipled-but-coincidentally-correct path; after the fix, no-arg `trigger` reports 0 outlets, which IS what the formula `arg_count` evaluates to. This is the deliberate semantic shift FN-03 calls for. Test TC-01 in Task 3 will encode this expectation.

**Done:** route returns (1, 1) on no-args; trigger returns (1, 0) on no-args; existing test_compute_io_counts_honors_overrides_rules_for_lifted_objects continues passing (`router(['4','6'])`, `router([])` use `first_arg`/`second_arg`, unaffected; `cycle(['5'])`, `cycle([])` use `fixed:1`/`first_arg`, unaffected; `combine(['a','b','c'])` uses `arg_count` and asserts `(3, 1)` — still passes; `combine([])` asserts `(2, 1)` and uses `arg_count`/`fixed:1` — **NOTE: combine([]) currently asserts (2, 1) in the FN-01 regression test. After FN-03 fix, combine([]) becomes (0, 1). The FN-01 test must be updated as part of this task.**

### Task 2 — Fix FN-04 (first_arg non-integer warning)

**Files:**
- src/maxpat/db_lookup.py (modify `_apply_io_formula` first_arg branch + add `_first_arg_warned` instance state)

**Action:**

1. Add a dedup set in `__init__` (alongside `_empty_io_warned`, line 47):
```python
self._first_arg_warned: set[tuple[str, str]] = set()
```

2. Replace the `first_arg` branch (lines ~368-374):
```python
if formula == "first_arg":
    if args:
        try:
            return int(args[0])
        except (ValueError, IndexError):
            return default
    return default
```
With (keep no-args path returning `default` silently — that's a legitimate "no args provided yet" state, not a malformed patch):
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

3. Add a private helper near `_maybe_warn_empty_io` (after line 161):
```python
def _warn_non_integer_first_arg(self, formula: str, raw_arg: str, default: int) -> None:
    """Emit a one-time UserWarning when a 'first_arg' formula receives a
    non-integer first argument. Dedup keyed on (formula, raw_arg) to avoid
    spamming repeated lookups of the same malformed patch.
    """
    key = (formula, raw_arg)
    if key in self._first_arg_warned:
        return
    self._first_arg_warned.add(key)
    warnings.warn(
        f"variable_io formula '{formula}' received non-integer first arg "
        f"{raw_arg!r}; falling back to default count {default}. "
        "Patch may be malformed.",
        UserWarning,
        stacklevel=4,
    )
```

Note: `stacklevel=4` (not 3 like `_maybe_warn_empty_io`) because the call path is one frame deeper: user → `compute_io_counts` → `_apply_io_formula` → `_warn_non_integer_first_arg` → `warnings.warn`. `_maybe_warn_empty_io` is called directly from `lookup`, one fewer hop.

Note: Drop the `IndexError` from the `except` clause — it's unreachable after the `if not args` guard. ValueError is the only real failure mode for `int(str)`.

**Verify:**
```bash
python -c "
import warnings
from src.maxpat.db_lookup import ObjectDatabase
db = ObjectDatabase()
# Find a first_arg-formula object: 'cycle' uses outlet_count='first_arg', default_outlets=2
with warnings.catch_warnings(record=True) as caught:
    warnings.simplefilter('always')
    result = db.compute_io_counts('cycle', ['XYZ'])
assert result == (1, 2), result
user = [w for w in caught if issubclass(w.category, UserWarning)]
assert len(user) == 1, f'expected 1 warning, got {len(user)}'
assert 'non-integer' in str(user[0].message)
print('FN-04 verified')
"
```

**Done:** non-integer first_arg emits exactly one UserWarning per (formula, raw_arg); valid integer args pass through unchanged; no-args silently returns default (unchanged behavior); dedup prevents repeated warnings on the same malformed input.

### Task 3 — Add TC-01 + TC-02 regression tests, update FN-01 test

**Files:**
- tests/test_db_lookup.py (append two new test groups; update one existing assertion)

**Action:**

1. **Update FN-01 test for FN-03 semantics shift.** In the existing `test_compute_io_counts_honors_overrides_rules_for_lifted_objects`, change the `combine([])` assertion. Before:
   ```python
   assert db.compute_io_counts("combine", []) == (2, 1)
   ```
   After:
   ```python
   # FN-03 fix: arg_count formula returns len([])=0, not default 2
   assert db.compute_io_counts("combine", []) == (0, 1)
   ```

   Add a one-line comment block above the test's `combine` section noting the FN-03 dependency so a future reader understands why the no-args expectation differs from the `default_inlets: 2` configured in overrides.json.

2. **Append TC-01 group** (after the FN-01 test):
   ```python
   # ── compute_io_counts TC-01 (REVIEW 260420-j15) ─────────────────

   def test_compute_io_counts_unknown_object_returns_zero_zero():
       db = ObjectDatabase()
       assert db.compute_io_counts("__does_not_exist__", []) == (0, 0)
       assert db.compute_io_counts("__does_not_exist__", ["a", "b"]) == (0, 0)


   def test_compute_io_counts_non_variable_io_returns_db_arrays():
       db = ObjectDatabase()
       # cycle~: 2 inlets (signal freq + phase), 1 outlet (signal). Not variable_io.
       assert db.compute_io_counts("cycle~", []) == (2, 1)
       # Args are ignored for non-variable_io objects.
       assert db.compute_io_counts("cycle~", ["440"]) == (2, 1)


   def test_compute_io_counts_trigger_with_full_args():
       db = ObjectDatabase()
       # trigger b i f -> 1 inlet, 3 outlets (one per type letter)
       assert db.compute_io_counts("trigger", ["b", "i", "f"]) == (1, 3)


   def test_compute_io_counts_trigger_no_args_post_fn03():
       """FN-03: trigger uses outlet_count='arg_count'. Empty args → 0 outlets,
       not the default 2. This is the deliberate semantic shift from REVIEW
       260420-j15 — the formula now always evaluates instead of falling
       through to default on empty args.
       """
       db = ObjectDatabase()
       assert db.compute_io_counts("trigger", []) == (1, 0)


   def test_compute_io_counts_route_no_args_post_fn03():
       """FN-03: route uses outlet_count='arg_count+1'. Empty args → 1
       outlet (just the unmatched), not the default 3.
       """
       db = ObjectDatabase()
       assert db.compute_io_counts("route", []) == (1, 1)
   ```

3. **Append TC-02 group:**
   ```python
   # ── get_outlet_types TC-02 (REVIEW 260420-j15) ──────────────────

   def test_get_outlet_types_all_signal():
       db = ObjectDatabase()
       # cycle~ has a single signal outlet
       assert db.get_outlet_types("cycle~", []) == ["signal"]


   def test_get_outlet_types_mixed_signal_and_control():
       db = ObjectDatabase()
       # sfplay~: signal channels + control bang on completion. The exact
       # channel count varies by argument, but the multi-outlet result must
       # contain BOTH "signal" and "" entries to prove mixed-type rendering.
       types = db.get_outlet_types("sfplay~", [])
       assert "signal" in types, types
       assert "" in types, types


   def test_get_outlet_types_variable_expansion_inherits_control():
       """trigger b i f: 3 control outlets (no signal). Tests the
       expansion path in get_outlet_types where num_outlets exceeds
       len(db_outlets) and types are inherited from the last DB outlet.
       """
       db = ObjectDatabase()
       types = db.get_outlet_types("trigger", ["b", "i", "f"])
       assert types == ["", "", ""], types


   def test_get_outlet_types_unknown_returns_empty():
       db = ObjectDatabase()
       assert db.get_outlet_types("__does_not_exist__", []) == []
   ```

**Verify:**
```bash
PYTHONDONTWRITEBYTECODE=1 python -m pytest tests/test_db_lookup.py -x -v 2>&1 | tail -30
```

All previously-passing tests must still pass (12 baseline + 1 updated FN-01 assertion + 9 new TC-01/TC-02 tests = 21 expected, allowing for any pre-existing count drift).

**Done:** All tests pass. New TC-01 covers the 5 cases listed in REVIEW.TC-01. New TC-02 covers the 4 cases listed in REVIEW.TC-02 (all-signal, mixed, variable expansion, unknown). FN-01 test updated to reflect FN-03 semantics shift.

## Verification Checklist

- [ ] `compute_io_counts("route", []) == (1, 1)` (FN-03)
- [ ] `compute_io_counts("trigger", []) == (1, 0)` (FN-03)
- [ ] `compute_io_counts("trigger", ["b","i","f"]) == (1, 3)` (TC-01)
- [ ] `compute_io_counts("cycle~", []) == (2, 1)` (TC-01 non-variable_io)
- [ ] `compute_io_counts("__missing__", []) == (0, 0)` (TC-01 unknown)
- [ ] `compute_io_counts("cycle", ["XYZ"])` emits exactly one UserWarning, returns (1, 2) (FN-04)
- [ ] `get_outlet_types("cycle~", []) == ["signal"]` (TC-02 all-signal)
- [ ] `get_outlet_types("sfplay~", [])` contains both `"signal"` and `""` (TC-02 mixed)
- [ ] `get_outlet_types("trigger", ["b","i","f"]) == ["", "", ""]` (TC-02 expansion)
- [ ] `pytest tests/test_db_lookup.py -x` passes
