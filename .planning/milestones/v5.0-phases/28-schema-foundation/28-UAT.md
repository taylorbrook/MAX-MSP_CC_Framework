---
status: complete
phase: 28-schema-foundation
source: [28-01-SUMMARY.md, 28-02-SUMMARY.md, 28-03-SUMMARY.md]
started: 2026-04-28T05:41:15Z
updated: 2026-04-28T05:56:00Z
---

## Current Test

[testing complete]

## Tests

### 1. ObjectDatabase loads cleanly under new validators
expected: Running `python3 -c "from src.maxpat.db_lookup import ObjectDatabase; ObjectDatabase(); print('ok')"` prints `ok` without exception. Validator + write-through pass against current data.
result: pass

### 2. Schema-extension test suite passes
expected: `python3 -m pytest tests/test_schema_extensions.py -v` reports 39 passed (32 functions + 7 parametrize expansions), 0 failures, 0 errors. Covers TestSchemaValidation, TestWriteThrough, TestGetters, TestAuditFunctions.
result: pass

### 3. In-scope baseline still green
expected: `python3 -m pytest tests/test_object_schema.py tests/test_package_schema.py tests/test_db_lookup.py --deselect tests/test_package_schema.py::TestCommunityPackageStubs -q` reports 94 passed, 26 deselected. No regressions — matches Plan 28-01 / 28-02 / 28-03 baseline.
result: pass

### 4. Fixture probes return curated values
expected: Inline probe returns the four fixtures as documented — `get_signal_role('cycle~', 0) == 'audio'`, `get_signal_role('snapshot~', 0) == 'float'`, `get_domain_restrictions('floor~') == ['rnbo']`, `get_install_state('bach.llll2list') is False`.
result: pass

### 5. Fail-fast validator rejects bad signal_role
expected: Constructing ObjectDatabase against an isolated DB root containing `signal_role: "bogus"` raises ValueError at construction time, naming the offending object, field, and value. Demonstrates the closed-enum + fail-fast guarantee that protects Phase 30's bulk population.
result: pass

### 6. Audit functions return expected shapes
expected: `audit_install_coverage()` returns `{"unaudited": [...], "verified_false": [...]}` with both lists sorted alphabetically and disjoint; `bach.llll2list` appears in `verified_false`. `audit_domain_coverage()` returns `{"restricted_no_coverage": [...]}` with 0 entries (no orphaned restrictions in current data).
result: pass

## Summary

total: 6
passed: 6
issues: 0
pending: 0
skipped: 0
blocked: 0

## Gaps

[none yet]
