---
phase: 28-schema-foundation
plan: 02
subsystem: database
tags: [object-database, getter-api, signal_role, domain_restricted, verified_installed, alias-resolution, back-compat]

# Dependency graph
requires:
  - phase: 28-01
    provides: "_validate_schema_extensions() + _apply_signal_role_writethrough() — Wave 1 already runs at _load() time, so getters can trust the data shape"
provides:
  - "ObjectDatabase.get_signal_role(name, outlet) -> str | None — alias-resolved, reverse-derived from legacy signal: bool when no curated role exists (D-02)"
  - "ObjectDatabase.get_install_state(name) -> bool | None — tri-state preserving D-09 (None=unaudited, False=known missing, True=verified)"
  - "ObjectDatabase.is_verified_installed(name) -> bool — collapses to `state is True` per D-10"
  - "ObjectDatabase.get_domain_restrictions(name) -> list[str] — returns fresh list copy (T-28-04 mutation isolation), [] when absent per D-07"
  - "ObjectDatabase.is_domain_restricted(name) -> bool — sugar for `bool(get_domain_restrictions(name))` per D-08"
affects: [28-03, 29-validator-extensions, 30-msp-coverage, 31-layout-builders]

# Tech tracking
tech-stack:
  added: []  # pure API additions on existing class — no new deps
  patterns:
    - "Alias-resolution-first invariant: every public getter starts with `canonical = self._aliases.get(name, name)` (matches lookup() / is_overridden() / is_core() / get_package())"
    - "Mutation isolation on list returns: `list(obj.get('domain_restricted', []))` returns a fresh copy so caller mutation cannot leak into the schema"
    - "Reverse derivation as honest fallback: signal: True -> 'audio', signal: False -> None (NOT False) — per D-02 'None means not yet curated, fall back to bool check'"
    - "Tri-state preservation through getter chain: is_verified_installed delegates to get_install_state, never coerces None to False at the source"

key-files:
  created: []
  modified:
    - "src/maxpat/db_lookup.py — added 78 lines (five public getter methods between get_package_info and compute_io_counts)"

key-decisions:
  - "Place all five getters together immediately after get_package_info() — keeps the schema-extension API surface co-located for readability and matches plan §action positioning"
  - "is_verified_installed and is_domain_restricted delegate to their list/state siblings rather than duplicating alias resolution — single source of truth for canonical lookup, less duplication"
  - "AST probe (acceptance criterion) verified the alias-resolution invariant on all three direct-resolving getters; the two delegating getters get it transitively"

patterns-established:
  - "Schema-extension API shape: one focused getter per typed field + optional bool sugar where it shortens calling code"
  - "Honest reverse derivation default: signal-side returns the string equivalent when it can be safely inferred ('audio' from True), but returns None (not False) when the legacy boolean carries no role information — distinguishes 'known not audio' from 'genuinely uncurated'"

requirements-completed: [SCHEMA-02, SCHEMA-05, SCHEMA-06]

# Metrics
duration: ~10min
completed: 2026-04-28
---

# Phase 28 Plan 02: Schema-Extension Getters Summary

**Five new ObjectDatabase methods exposing per-outlet `signal_role`, per-object `domain_restricted`, and per-object `verified_installed` to downstream Phase 29 validators — all alias-resolved, with honest D-02 reverse derivation and T-28-04 mutation isolation on the list return.**

## Performance

- **Started:** 2026-04-28T02:18:00Z (approx — recorded after worktree base reset)
- **Completed:** 2026-04-28T02:24:02Z
- **Duration:** ~6 min
- **Tasks:** 1
- **Files modified:** 1
- **Commits:** 1 (task) + 1 plan-metadata commit appended after this SUMMARY

## Accomplishments

- **`get_signal_role(name, outlet)`** lands with the D-02 honest reverse derivation: returns the curated `signal_role` string when present, falls back to `"audio"` only when legacy `signal: True` is the sole information, and returns `None` (NOT `"control"` or `False`) when the outlet has only `signal: False` — distinguishing "known not audio" from "uncurated."
- **`get_install_state(name)`** preserves the D-09 tri-state through a thin pass-through: `None` (absent), `True` (verified present), `False` (known missing). Phase 29 will read this directly to warn ONLY on explicit `False`, never on `None`.
- **`is_verified_installed(name)`** collapses correctly per D-10: `state is True` only; `None` and `False` both return `False`. The bool sugar does not lose the tri-state distinction at the lower API.
- **`get_domain_restrictions(name)`** returns a fresh list copy per `list(obj.get(...))` — mitigates T-28-04 (caller mutation cannot leak into the schema). Verified by inline probe (`restrictions.append('hacked')` did not affect a subsequent call).
- **`is_domain_restricted(name)`** is `bool(get_domain_restrictions(name))` per D-08.
- **All three direct-resolving getters** (`get_signal_role`, `get_install_state`, `get_domain_restrictions`) start with `canonical = self._aliases.get(name, name)` — matches the existing `lookup()` / `is_overridden()` / `is_core()` / `get_package()` invariant. Verified by AST probe (acceptance criterion N1-fix-v2).
- **Both delegating getters** (`is_verified_installed`, `is_domain_restricted`) get alias resolution transitively — no duplicated lookup logic.

## Task Commits

1. **Task 1: Add five getter methods on ObjectDatabase** — `fe62916` (feat)

_Plan metadata commit follows this SUMMARY write._

## Files Created/Modified

- `src/maxpat/db_lookup.py` — added 78 lines (five public getter methods inserted between `get_package_info()` and `compute_io_counts()`)

## Decisions Made

- **Co-located placement after `get_package_info()`** — plan §action specified "around line 416" (which was the line in an older snapshot); the actual current insertion point is immediately after `get_package_info()` ends at line 517. The intent — "place all five together immediately after `get_package_info()`" — was honored exactly.
- **Delegation over duplication** for the two bool-sugar getters: `is_verified_installed` calls `self.get_install_state(name)`, and `is_domain_restricted` calls `self.get_domain_restrictions(name)`. They get alias resolution transitively without each method needing to repeat `canonical = self._aliases.get(name, name)`. The AST acceptance probe (N1-fix-v2) explicitly only checks the three direct-resolving getters for this reason — confirmed by the plan text: "is_verified_installed and is_domain_restricted delegate to those three so they don't need their own alias resolution."
- **Reverse-derivation default for `signal: False` outlets is `None`, not `"control"` or `False`** — this is D-02 verbatim. Phase 29's role-aware validators must distinguish "no curated role, fall back to bool" (`None`) from "curated as not-audio" (e.g., `"trigger"`/`"status"`). Returning `False` or `"control"` here would have collapsed that distinction and triggered the warning storm D-10 was designed to prevent.

## Deviations from Plan

**1. [Rule 3 — Blocking, scope-bounded]** The pre-existing test failures already logged in `.planning/phases/28-schema-foundation/deferred-items.md` by Wave 1 (Plan 28-01) re-surfaced when running the full in-scope test set. Per the deviation rules' SCOPE BOUNDARY clause, these were NOT fixed in this plan — they predate any Phase 28 work and are out of scope. Verification used the Wave 1-established pattern: deselect `TestCommunityPackageStubs`, which produced 94 passed / 26 deselected — exactly matching the Plan 28-01 baseline.

  Affected (already in `deferred-items.md`):
  - `tests/test_package_schema.py::TestCommunityPackageStubs::test_community_stubs_verified_false` (FluCoMa `verified=true` on objects that the stub-policy expects to be `false`)
  - Other community-package and MC tilde I/O failures previously logged.

  My changes added zero data (no new entries in `overrides.json` or any domain JSON) and only added five methods to `db_lookup.py`. No code path I introduced touches the failing assertions.

---

**Total deviations:** 1 logged (scope-bounded re-surfacing of Wave-1-deferred failures, no new work in this plan).
**Impact on plan deliverables:** None.

## Issues Encountered

None on plan-internal work. The inline verification probe, the AST acceptance probe, and the in-scope test suite all passed on the first run after the Edit.

## Verification Results

- **Inline probe** (8 assertions including alias resolution, mutation isolation, out-of-range outlet, unknown-object graceful miss): `PASS: all five getters work with current DB state`
- **AST probe** (alias resolution invariant on the three direct-resolving getters): `OK: alias-resolution verified for ['get_domain_restrictions', 'get_install_state', 'get_signal_role']`
- **`grep -c "def <method>"`** for each of the five method names: returns `1` per name (no duplicate definitions, no missing methods).
- **Test suite** (`tests/test_object_schema.py + tests/test_package_schema.py + tests/test_db_lookup.py` with `TestCommunityPackageStubs` deselected): **94 passed, 26 deselected, 6 warnings** — identical to the Plan 28-01 baseline. Zero new failures introduced.
- **Alias resolution end-to-end:** `db.get_signal_role('t', 0) == db.get_signal_role('trigger', 0) == None` (both return `None` because trigger's outlet 0 has `signal: False` and no curated role — this is D-02 honest reverse derivation in action).
- **Reverse derivation, signal:True case:** `db.get_signal_role('cycle~', 0) == 'audio'` ✓
- **Reverse derivation, signal:False case:** `db.get_signal_role('trigger', 0) is None` ✓ (verified across `trigger`, `pack`, `route`, `flonum`)

## Next Phase Readiness

- **Plan 28-03 ready:** can land `audit_install_coverage()` and `audit_domain_coverage()` on top of the now-validated, now-readable schema. The example/fixture population task can use the new getters to verify back-compat end-to-end.
- **Phase 29 ready (gating still on 28-03):** the five getters are the stable surface Phase 29's role-aware validators, install-state warnings, and domain hard-guard will read against. Per D-02, Phase 29 must treat `get_signal_role()` returning `None` as "fall back to the bool check, do not emit a role-mismatch error."

## Self-Check

- **Created files exist:**
  - `.planning/phases/28-schema-foundation/28-02-SUMMARY.md` — being written now (this file).
- **Modified files exist:**
  - `src/maxpat/db_lookup.py` — FOUND (modified, 78 lines added).
- **Commits exist:**
  - `fe62916` — FOUND (Task 1 — feat: five getters).

## Self-Check: PASSED

---
*Phase: 28-schema-foundation*
*Completed: 2026-04-28*
