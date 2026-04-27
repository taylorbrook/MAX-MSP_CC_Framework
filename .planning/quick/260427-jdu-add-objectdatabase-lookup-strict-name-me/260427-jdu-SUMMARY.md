---
phase: quick-260427-jdu
plan: 01
subsystem: db_lookup
tags: [db-lookup, lookup-strict, empty-io, additive-api]
requires:
  - existing ObjectDatabase.lookup() (delegated to)
  - existing ObjectDatabase._aliases (alias resolution)
  - existing ObjectDatabase._variable_io_rules (exemption registry)
provides:
  - ObjectDatabase.lookup_strict(name, *, allowed_packages=None)
affects:
  - src/maxpat/db_lookup.py (additive only — lookup() byte-identical)
  - tests/test_db_lookup.py (4 new tests)
tech-stack:
  added: []
  patterns: [delegation, predicate-inversion]
key-files:
  created: []
  modified:
    - src/maxpat/db_lookup.py
    - tests/test_db_lookup.py
decisions:
  - "Delegate to lookup() instead of duplicating alias/package logic — preserves the one-time empty-I/O UserWarning by design (callers learn about data quality AND get strict None)."
  - "Use _variable_io_rules membership as the exemption check (matches has_complete_io semantics inverted), not the per-object variable_io boolean — single source of truth."
  - "Return None for empty-I/O without exemption (rather than raising) — keeps the strict variant a drop-in replacement at call sites that already check `if obj is None`."
metrics:
  duration_seconds: 166
  duration_human: "~2 min"
  tasks_completed: 2
  files_modified: 2
  tests_added: 4
  tests_passing: 38
  completed_date: "2026-04-27"
commits:
  - hash: 2c640ce
    message: "feat(quick-260427-jdu-01): add ObjectDatabase.lookup_strict() method"
  - hash: 62aa741
    message: "test(quick-260427-jdu-02): cover ObjectDatabase.lookup_strict() behavior"
---

# Quick 260427-jdu: Add `ObjectDatabase.lookup_strict()` Summary

Strict-mode object lookup that returns `None` for empty-I/O DB entries without a `variable_io_rules` exemption — closes FINDINGS P1-2 by giving patch builders a fail-fast variant of `lookup()`.

## Final Method Signature

```python
def lookup_strict(self, name: str, *, allowed_packages: list[str] | None = None) -> dict | None:
    """Look up an object by name, returning None for unusable empty-I/O entries.
    ...
    """
    obj = self.lookup(name, allowed_packages=allowed_packages)
    if obj is None:
        return None
    canonical = self._aliases.get(name, name)
    if canonical in self._variable_io_rules:
        return obj
    if obj.get("inlets") and obj.get("outlets"):
        return obj
    return None
```

Located in `src/maxpat/db_lookup.py` immediately after `lookup()` (line ~205) and before `_maybe_warn_empty_io()`.

## Predicate (When `lookup_strict` Returns None vs the Object)

The strict gate is `(canonical in _variable_io_rules) OR (inlets AND outlets are both populated)`. If the predicate is true, return the dict; otherwise return `None`.

This is exactly `has_complete_io()` semantics applied as a return-value gate, with the same defensive variable-I/O exemption. Equivalent table:

| Case | DB hit? | inlets | outlets | in `_variable_io_rules`? | `lookup()` returns | `lookup_strict()` returns |
|------|---------|--------|---------|---------------------------|--------------------|---------------------------|
| Normal hit (`cycle~`)              | yes | populated | populated | no  | object | object |
| Empty-I/O entry (`dsp`)            | yes | empty     | empty     | no  | object (+ UserWarning) | **None** |
| Variable-I/O w/ populated defaults (`trigger`) | yes | populated | populated | yes | object | object |
| Variable-I/O w/ empty defaults     | yes | empty     | empty     | yes | object | object (exempted) |
| Unknown name                        | no  | —         | —         | —   | None   | None |
| Package-filtered                    | yes | —         | —         | —   | None   | None |

## Test Additions

Added a new section to `tests/test_db_lookup.py` (after `# ── lookup() warning behavior ──`, before `# ── audit_empty_io() ──`) with 4 tests, matching the existing style (one assertion per behavior, no fixtures, direct `db = ObjectDatabase()` instantiation, box-drawing section header):

1. `test_lookup_strict_returns_object_for_normal_hit` — `cycle~` returns the cycle~ dict.
2. `test_lookup_strict_returns_none_for_empty_io_entry` — `dsp` returns `None`; baseline `lookup("dsp")` still hits (proves they diverge as designed).
3. `test_lookup_strict_returns_object_for_variable_io_with_empty_defaults` — synthetic injected entry `__test_var_io_strict__` with empty I/O + variable_io_rules entry returns the object (mirrors `test_has_complete_io_respects_variable_io_exemption` pattern).
4. `test_lookup_strict_resolves_alias` — `t` resolves to `trigger`.

## Confirmation: `lookup()` Was Not Modified

`git diff HEAD~2 src/maxpat/db_lookup.py` shows additions only inside the new `lookup_strict` method block. No edits to existing lines. No changes to `lookup()`, `_maybe_warn_empty_io()`, `has_complete_io()`, `_aliases`, `_variable_io_rules`, or any other pre-existing method.

## Verification

```bash
$ python3 -m pytest tests/test_db_lookup.py -v
============================== 38 passed in 0.86s ==============================
```

All 38 tests pass: 34 pre-existing + 4 new `lookup_strict` tests. No regressions.

Targeted run for the new tests only:

```bash
$ python3 -m pytest tests/test_db_lookup.py -k lookup_strict -v
======================= 4 passed, 34 deselected in 0.14s =======================
```

Broader suite (`pytest tests/`) reports 36 pre-existing failures in `test_integration_patches.py`, `test_validation.py`, `test_package_schema.py`, and `test_source_coverage.py` — all unrelated to `db_lookup` (patch-content drift and extraction-log staleness). These failures exist on the base commit `6be059d` and are out-of-scope per the constraints (Rule "scope boundary").

## Deviations from Plan

None — plan executed exactly as written. Implementation matches the docstring and predicate spec; tests match the four cases enumerated in the plan's `<behavior>` block; no additional fixes or refactors were needed.

## Follow-ups

- **Migrate existing patch-builder call sites from `lookup()` to `lookup_strict()`** — out of scope for this task. Candidate sites are in `src/maxpat/builders/`, validation passes, and any code path that today relies on `lookup()` returning empty-I/O hits as "found." Track as a separate quick task per FINDINGS P1-2 (the original review that motivated this strict variant). The migration should be one-call-site-at-a-time with regression tests at each site, since some callers may legitimately want the inspection-only `lookup()` behavior (audits, diagnostics, the `has_complete_io` test scaffolding).

## Self-Check: PASSED

- `src/maxpat/db_lookup.py` — FOUND, contains `def lookup_strict`
- `tests/test_db_lookup.py` — FOUND, 10 occurrences of `lookup_strict`
- Commit `2c640ce` (Task 1, feat) — FOUND
- Commit `62aa741` (Task 2, test) — FOUND
- Full `tests/test_db_lookup.py` (38 tests) — all PASSED
