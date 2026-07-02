---
phase: 260702-gk6-extend-objectdatabase-audit-empty-io-to-
plan: 01
subsystem: maxpat-db
tags: [db-health, audit, diagnostics]
status: complete
requires: [ObjectDatabase._load, audit_empty_io]
provides: [audit_empty_io.by_source]
affects: [tools/extract_pkg_io.py (read-only consumer, unchanged)]
tech-stack:
  added: []
  patterns: [load-time provenance capture before canonical-name shadowing]
key-files:
  created: []
  modified:
    - src/maxpat/db_lookup.py
    - tests/test_db_lookup.py
    - tests/test_schema_extensions.py
decisions:
  - "by_source mirrors raw per-file state (no variable_io/override exclusion) so it matches the independent brute-force oracle bit-for-bit"
metrics:
  duration: ~8m
  completed: 2026-07-02
  tasks: 2
  files: 3
---

# Quick Task 260702-gk6: Extend audit_empty_io to cover all domain sources — Summary

Added an additive `by_source` view to `ObjectDatabase.audit_empty_io()` that reports every empty-I/O entry across all 8 domain sources (164 total) grouped by source domain/package, exposing the 121 package entries previously shadowed in the merged `self._objects` dict.

## What Was Built

- **Load-time provenance capture** (`db_lookup.py` `__init__` + `_load`): a new `self._empty_io_by_source: defaultdict(list)` is populated as each raw domain/package JSON file is read — before the override deep-merge and before canonical-name shadowing collapses duplicates. Core domains use the bare domain name as source label; packages use `packages/<pkgdir>`. Empty predicate is `not obj.get("inlets") and not obj.get("outlets")`.
- **Additive `by_source` key** on `audit_empty_io()`: `{src: sorted(names)}`. The three original buckets (`critical`, `covered_by_override`, `variable_io_ok`) are computed identically and semantically unchanged. Docstring updated to document the new key.
- **Regression test** (`test_audit_empty_io_covers_all_domain_files`): an independent oracle that walks every domain file itself (own file walk + `json.load`, no production helper) and asserts the audit's grand total and per-source counts equal the brute-force recount (164 on current DB, never a hardcoded literal), plus shadow-fix assertions for `bach.hypercomment`, `osc-route`, `jit.gl.textureset`.
- **Shape-test updates**: `tests/test_db_lookup.py:220` and `tests/test_schema_extensions.py:442` updated additively to include `by_source` while still asserting the three original keys (D-12 back-compat intent preserved).

## Verification

- `python3 -m pytest tests/test_db_lookup.py tests/test_schema_extensions.py -q` → 87 passed.
- Spot check: total 164 across 24 sources; critical bucket = 9 (unchanged).
- `tools/extract_pkg_io.py` consumer reads `audit_empty_io()["critical"]` only — no edit required, still working.

## TDD Gate Compliance

- RED: `test(quick-260702-gk6)` 3dd6095 — new test fails with `KeyError: 'by_source'`, no production code changed.
- GREEN: `feat(quick-260702-gk6)` 676b638 — implementation + additive shape-test updates, full suite green.
- REFACTOR: none needed.

## Deviations from Plan

None - plan executed exactly as written.

## Self-Check: PASSED

- FOUND: src/maxpat/db_lookup.py (modified)
- FOUND: tests/test_db_lookup.py (modified)
- FOUND: tests/test_schema_extensions.py (modified)
- FOUND commit: 3dd6095 (RED)
- FOUND commit: 676b638 (GREEN)
