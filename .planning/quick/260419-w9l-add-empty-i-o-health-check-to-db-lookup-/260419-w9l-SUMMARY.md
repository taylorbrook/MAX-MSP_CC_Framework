---
phase: 260419-w9l
plan: 01
subsystem: db_lookup
tags: [db-health, observability, testing]
requires: []
provides:
  - ObjectDatabase.has_complete_io
  - ObjectDatabase.audit_empty_io
  - ObjectDatabase.lookup empty-I/O UserWarning
affects:
  - src/maxpat/db_lookup.py
  - tests/test_db_lookup.py
tech_stack:
  added: []
  patterns:
    - "warnings.warn(UserWarning) with stacklevel=3 for caller-blaming"
    - "per-instance dedup via _empty_io_warned: set[str]"
key_files:
  created:
    - tests/test_db_lookup.py
  modified:
    - src/maxpat/db_lookup.py
decisions:
  - "UserWarning chosen over DeprecationWarning: visible by default in end-user runtime; intent is to surface silent patch-generation failures, not deprecate an API."
  - "audit_empty_io.variable_io_ok mirrors _variable_io_rules registry (not gated on empty I/O) per plan D-choice — registry diagnostic, not empty-I/O subset."
  - "Helper _maybe_warn_empty_io invoked ONLY on lookup()'s success paths (after allowed_packages filter), so filtered-out objects stay silent."
metrics:
  duration: ~20min
  completed: 2026-04-20T06:28Z
  tasks_completed: 2
  files_changed: 2
  tests_added: 12
  tests_passing: 12
---

# Phase 260419-w9l Plan 01: Add Empty-I/O Health Check to db_lookup Summary

Added a code-level guardrail against silent-failure patch generation caused by DB entries with empty inlets AND empty outlets (130 such entries on live DB). `ObjectDatabase` now exposes a predicate, a one-time warning path, and a segmentation report — no JSON/data changes.

## What Was Added

### `src/maxpat/db_lookup.py`

1. **`has_complete_io(name: str) -> bool`** — predicate callers can use to gate object usage.
   - Resolves alias → checks `_variable_io_rules` (short-circuits True) → checks both inlets AND outlets populated.
   - Returns False for unknown names.

2. **`_maybe_warn_empty_io(canonical, obj)` private helper** — emits a one-time `UserWarning` when an empty-I/O object (not in variable_io_rules) is about to be returned by `lookup()`. Message: `"Object '{canonical}' has empty inlets/outlets in DB -- patch generation may fail silently. Consider adding an override to overrides.json."`
   - `stacklevel=3` so pytest blames the caller of `lookup()`, not the helper.
   - Dedup via `self._empty_io_warned: set[str]` (per-instance, per-canonical).

3. **`lookup()` modification** — invokes `_maybe_warn_empty_io` at each of the three success return paths (`allowed_packages is None`, `"package" not in obj`, `obj["package"] in allowed_packages`). Object-not-found and package-filtered paths remain silent.

4. **`audit_empty_io() -> dict[str, list[str]]`** — segmentation report with three sorted lists:
   - `variable_io_ok`: ALL keys in `_variable_io_rules` (registry diagnostic, not empty-I/O subset).
   - `covered_by_override`: empty-I/O canonicals that have overrides applied.
   - `critical`: empty-I/O canonicals with no rules and no override (silent-failure time bombs).

### `tests/test_db_lookup.py` (new, flat layout per project convention)

12 pytest tests covering:
- **has_complete_io (6):** `cycle~` True, `dsp` False, `trigger` True (rules exemption), alias `t → trigger`, unknown False, and a monkey-patched fake empty-I/O entry with a fake rules entry — proves the defensive variable_io short-circuit branch (not exercised by real data today).
- **lookup warning (5):** first call warns once, second call dedups, `trigger` silent (variable_io), `cycle~` silent (complete I/O), unknown silent, `ease` silent with `allowed_packages=[]` (proves helper runs AFTER package filter).
- **audit_empty_io (1):** shape keys `{critical, covered_by_override, variable_io_ok}`, all buckets sorted lists of str, `variable_io_ok` mirrors `_variable_io_rules.keys()` (= 20 entries), `trigger` in `variable_io_ok`, `cycle~` in no bucket, `critical ≥ 50` (loose bound), present-day disjointness.

## Warning Category Decision

**Chosen: `UserWarning`** (not `DeprecationWarning`).

**Rationale:** This is a runtime data-quality signal to the caller, not an API deprecation. Python filters out `DeprecationWarning` by default in the end-user runtime; `UserWarning` is visible by default. Since the intent is to surface silent failures immediately to whoever is generating patches, `UserWarning` is the correct category.

## Current Audit Report Counts

From `ObjectDatabase().audit_empty_io()` on live DB:

| Bucket | Count | Notes |
|---|---|---|
| `critical` | **130** | empty I/O, no rules, no override — the silent-failure targets |
| `covered_by_override` | **0** | no empty-I/O entries have overrides today |
| `variable_io_ok` | **20** | all keys in `_variable_io_rules` (trigger, pack, route, …) |

`cycle~` appears in NO bucket (complete I/O, not in rules) — regression guard.

## `audit_empty_io` Semantics Note

Per the plan's checker BLOCKER 1 resolution: **`variable_io_ok` lists ALL keys in `_variable_io_rules`** regardless of their default I/O state — it's a diagnostic of the rules registry, not a subset of the empty-I/O set. Today every variable_io entry has populated default I/O, so the three buckets are disjoint; this could change in the future if a rules entry were added with empty defaults (the function permits the overlap).

## Test File Path and Pytest Result

- Path: `tests/test_db_lookup.py`
- Command: `pytest tests/test_db_lookup.py -v`
- Result: **12 passed in 0.28s**

## Commits

| Task | Commit | Description |
|---|---|---|
| 1 | `06e340a` | `feat(db): warn on empty-I/O object lookups` — db_lookup.py implementation |
| 2 | `49caaaa` | `test(db): pytest for empty-I/O health check` — tests/test_db_lookup.py |

Scope-lock verified: `git diff HEAD~2 HEAD --name-only` shows only `src/maxpat/db_lookup.py` and `tests/test_db_lookup.py`. No `.json` files modified.

## Deviations from Plan

None — plan executed exactly as written. All 12 tests pass; all done-criteria satisfied.

The plan originally suggested a single commit (`feat(db): warn on empty-I/O object lookups` covering both tasks); per the executor constraints from the parent orchestrator, Task 2 was split into its own `test(db): …` commit. Two atomic commits total.

## Deferred Issues (Pre-existing, Out of Scope)

A broader `pytest tests/ -k "db or lookup or object"` run surfaced 3 pre-existing failures unrelated to this plan (confirmed pre-existing by running them on the Task 1 HEAD before Task 2 existed):

- `tests/test_inlet_types.py::TestMSPSignalInlets::test_tilde_objects_have_signal_io`
- `tests/test_package_schema.py::TestCommunityPackageStubs::test_community_stubs_signal_objects_have_signal_io`
- `tests/test_package_schema.py::TestCommunityPackageStubs::test_lookup_ears`

These are DB-content failures (e.g., `ears.slice` not in DB, community tilde-objects lacking signal I/O) — not regressions from this plan. Not fixed per executor scope rules (only auto-fix issues DIRECTLY caused by current task's changes).

The new empty-I/O `UserWarning` is visible in the warnings summary of unrelated tests (`tests/test_patcher.py`, `tests/test_sizing.py`, `tests/test_validation.py`). These are not errors — they are the warning fulfilling its intended purpose, surfacing DB entries (`outlet`, `bp.Mono`, `print`) that need override work. `print` in particular is a likely candidate for a future override-population task.

## Self-Check: PASSED

- `src/maxpat/db_lookup.py`: FOUND (modified, committed `06e340a`)
- `tests/test_db_lookup.py`: FOUND (created, committed `49caaaa`)
- commit `06e340a`: FOUND in `git log`
- commit `49caaaa`: FOUND in `git log`
- `pytest tests/test_db_lookup.py -v`: 12/12 PASSED
- `audit_empty_io()` shape: keys `{critical, covered_by_override, variable_io_ok}` present; counts 130 / 0 / 20
- scope-lock: `git diff HEAD~2 HEAD --name-only` = `src/maxpat/db_lookup.py` + `tests/test_db_lookup.py` only (no .json)
