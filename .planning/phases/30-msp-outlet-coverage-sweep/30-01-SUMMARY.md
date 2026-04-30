---
phase: 30-msp-outlet-coverage-sweep
plan: 01
subsystem: object-database
tags: [database, audit, infrastructure, signal_role, cli]
dependency_graph:
  requires:
    - "ObjectDatabase (Phase 28: signal_role schema + writethrough projection)"
    - "_SIGNAL_ROLE_ENUM closed enum (Phase 28 D-04)"
    - "audit_empty_io / audit_install_coverage / audit_domain_coverage (Phase 28 D-12 sibling pattern)"
  provides:
    - "ObjectDatabase.audit_signal_role_coverage() — per-domain {msp, mc} coverage report"
    - "scripts/audit_signal_role.py — CLI scaffold (report-only mode + apply stub)"
    - "tests/test_audit_signal_role.py — shape + bucketing + edge case suite"
  affects:
    - "Plans 30-02/03/04 — all gate on audit_signal_role_coverage().gap_count < 20 per domain (D-10)"
tech_stack:
  added: []
  patterns:
    - "Audit-fn pattern: pure read-only, sorted dict-of-lists, mirrors audit_empty_io / audit_install_coverage / audit_domain_coverage verbatim"
    - "argparse subcommand CLI with sys.path bootstrap via Path(__file__).resolve().parents[1]"
    - "TDD RED→GREEN with isolated _make_isolated_db helper (mirrors tests/test_schema_extensions.py)"
key_files:
  created:
    - "scripts/audit_signal_role.py"
    - "tests/test_audit_signal_role.py"
  modified:
    - "src/maxpat/db_lookup.py (added audit_signal_role_coverage method)"
decisions:
  - "Followed D-13 verbatim: per-domain nested {covered, uncovered, by_role, gap_count} shape"
  - "Initialized by_role from sorted(_SIGNAL_ROLE_ENUM) for deterministic key ordering and to keep all six canonical keys present even when unused"
  - "by_role tallies count OUTLETS not OBJECTS (one 3-outlet object contributes 3 to by_role[role])"
  - "Empty-outlet objects are SKIPPED (audit_empty_io owns those gaps per D-13)"
  - "apply subcommand exits with code 2 (not 0) to prevent automation from misinterpreting the stub as success — T-30-01-04"
metrics:
  duration_seconds: 223
  duration_minutes: 3.7
  tasks_completed: 3
  files_changed: 3
  commits: 4
  completed_date: "2026-04-30"
---

# Phase 30 Plan 01: MSP Outlet Coverage Sweep — Audit Infrastructure Summary

**One-liner:** Added `ObjectDatabase.audit_signal_role_coverage()` returning per-domain `{msp, mc}` coverage buckets, plus `scripts/audit_signal_role.py` CLI scaffold (report-only) and 13-test shape/bucketing suite — pure infrastructure, zero data migration.

## Tasks Completed

| Task | Name                                                            | Commit    | Files                                  |
| ---- | --------------------------------------------------------------- | --------- | -------------------------------------- |
| 1a   | RED: failing probe for audit_signal_role_coverage               | `985e959` | tests/test_audit_signal_role.py        |
| 1b   | GREEN: add audit_signal_role_coverage to ObjectDatabase         | `2fb8571` | src/maxpat/db_lookup.py                |
| 2    | Expand test suite with full D-13 + D-15 coverage (13 tests)     | `8444e03` | tests/test_audit_signal_role.py        |
| 3    | Scaffold scripts/audit_signal_role.py CLI (report-only)         | `45a05a7` | scripts/audit_signal_role.py           |

## What Was Built

### `audit_signal_role_coverage()` (db_lookup.py)

Sibling of `audit_empty_io` / `audit_install_coverage` / `audit_domain_coverage`. Returns:

```python
{
  "msp": {
    "covered":   [sorted names whose every outlet has signal_role],
    "uncovered": [sorted names with at least one outlet missing signal_role],
    "by_role":   {"audio": N, "trigger": N, "status": N, "float": N, "data": N, "list": N},
    "gap_count": int,  # == len(uncovered)
  },
  "mc": { ...same shape... },
}
```

**Implementation notes:**
- Iterates `self._objects.items()`, buckets by `obj["domain"]` (`"MSP"` → msp, `"MC"` → mc, others silently skipped per D-09).
- Empty-outlet objects (`outlets == []`) are skipped — their gaps belong to `audit_empty_io` (D-13 disjoint-bucket guarantee).
- Object is `covered` only if EVERY outlet has truthy `signal_role`; otherwise `uncovered`.
- `by_role` counts every outlet with a `signal_role` (not every object), initialized from `sorted(_SIGNAL_ROLE_ENUM)` so all six canonical keys are present with deterministic ordering.
- Pure read-only — no mutation, no warnings, no classifier coupling. Audits the source-of-truth `signal_role`, NOT the projected `signal:bool`.
- Positioned at line 937 of `db_lookup.py`, immediately after `audit_domain_coverage` (line 891).

**Current production-DB output:** msp `gap_count=232`, mc `gap_count=215` (expected pre-migration; Plans 30-02/03/04 drive these to <20).

### `scripts/audit_signal_role.py` (CLI scaffold)

Standalone CLI per D-07:
- **`audit`** subcommand (default): prints per-domain coverage, gates on `--threshold` (default 20 per D-10), exits 0/1.
- **`apply`** subcommand: stub — exits 2 with stderr `not implemented in Plan 30-01` (Plan 30-03 fills in the digest classifier + apply path).

Path bootstrap via `Path(__file__).resolve().parents[1]` (no cwd dependency, addresses T-30-01-01).

### `tests/test_audit_signal_role.py` (13 tests)

`TestAuditSignalRoleCoverage` covers D-13 + D-15:
1. `test_returns_msp_and_mc_keys` — top-level shape
2. `test_each_domain_has_required_subkeys` (param: msp, mc) — sub-keys
3. `test_gap_count_equals_len_uncovered` (param: msp, mc) — D-13 derivation
4. `test_by_role_keys_match_canonical_enum` (param: msp, mc) — closed enum
5. `test_real_db_constructs_without_error` — production-DB smoke
6. `test_mixed_outlet_object_is_uncovered` — partial-audit bucketing
7. `test_fully_audited_object_is_covered` — full-audit bucketing
8. `test_empty_outlets_excluded` — disjoint with audit_empty_io
9. `test_lists_are_sorted` — sort stability
10. `test_non_msp_mc_objects_not_counted` — D-09 scope guard
11. `test_by_role_counts_outlets_not_objects` — outlet-tally semantics
12. `test_by_role_distribution_uses_only_canonical_enum` — closed enum init
13. `test_mc_domain_buckets_independently` — MSP/MC isolation

Helpers: `_make_isolated_db` (with `_SEED_OBJECT_NAMES` typo guard), `_msp_obj`/`_mc_obj`/`_max_obj` fixture builders.

## Verification

- `pytest tests/test_audit_signal_role.py tests/test_schema_extensions.py -q` → **63 passed, 0 failures**.
- `python3 scripts/audit_signal_role.py audit --threshold 9999` → exit 0, prints `[msp]` and `[mc]` sections.
- `python3 scripts/audit_signal_role.py apply` → exit 2, stderr contains `not implemented in Plan 30-01`.
- `python3 scripts/audit_signal_role.py` (no args) → exit 1 (current msp gap_count=232 ≥ 20, expected pre-migration).
- `grep -c "signal_role" .claude/max-objects/overrides.json` → 4 (unchanged byte-for-byte from baseline; the plan's quoted "currently 2" was stale, but the invariant "unchanged byte-for-byte" holds — confirmed via `git diff d7f2787 HEAD -- .claude/max-objects/overrides.json` returning empty).

## Deviations from Plan

None — plan executed exactly as written.

The plan's verification block claimed `grep -c "signal_role" .claude/max-objects/overrides.json` should equal "currently 2"; on the baseline commit the actual count is 4. This is a stale plan annotation, not a real divergence — `git diff d7f2787 HEAD -- .claude/max-objects/overrides.json` is empty, so the file is genuinely unchanged. The "no data migration" success criterion (overrides.json byte-for-byte unchanged) is satisfied.

## Authentication Gates

None.

## Deferred Issues

None.

## Self-Check: PASSED

Verified files and commits exist:

```
FOUND: src/maxpat/db_lookup.py (audit_signal_role_coverage at line 937)
FOUND: scripts/audit_signal_role.py (executable, all 4 named functions present)
FOUND: tests/test_audit_signal_role.py (13 test methods, _SIGNAL_ROLE_ENUM imported)
FOUND: 985e959 (RED test commit)
FOUND: 2fb8571 (GREEN implementation commit)
FOUND: 8444e03 (expanded test suite commit)
FOUND: 45a05a7 (CLI scaffold commit)
```

Test runs:
- `pytest tests/test_audit_signal_role.py -q` → 16 passed
- `pytest tests/test_audit_signal_role.py tests/test_schema_extensions.py -q` → 63 passed
- `python3 scripts/audit_signal_role.py audit --threshold 9999` → exit 0
- `python3 scripts/audit_signal_role.py apply` → exit 2 (stub)

Acceptance criteria from plan all met:
- [x] `def audit_signal_role_coverage(` literal in db_lookup.py
- [x] Method positioned AFTER `audit_domain_coverage` (line 937 > 891)
- [x] Inline command prints `msp gap_count:` and `mc gap_count:` without raising
- [x] `r['msp']['by_role']` keys equal `_SIGNAL_ROLE_ENUM` exactly
- [x] `covered` and `uncovered` lists sorted alphabetically
- [x] Pre-existing tests stay green (47 → 47 in test_schema_extensions.py)
- [x] `class TestAuditSignalRoleCoverage` exists; 13 ≥ 8 test methods
- [x] CLI executable, all named functions present, threshold + apply stub work
- [x] No data migration — `overrides.json` byte-for-byte unchanged from baseline
