---
phase: 28-schema-foundation
fixed_at: 2026-04-27T00:00:00Z
review_path: .planning/phases/28-schema-foundation/28-REVIEW.md
iteration: 1
findings_in_scope: 5
fixed: 5
skipped: 0
status: all_fixed
---

# Phase 28: Code Review Fix Report

**Fixed at:** 2026-04-27
**Source review:** `.planning/phases/28-schema-foundation/28-REVIEW.md`
**Iteration:** 1

**Summary:**
- Findings in scope: 5 (all info-level; fix scope = `all`)
- Fixed: 5
- Skipped: 0

All 5 info-level findings from the review were addressed and committed
atomically. The full schema-extension test suite (`tests/test_schema_extensions.py`,
39 tests) passes after every fix. No regressions in adjacent test files.

A pre-existing failure in `tests/test_critics.py::test_community_unextracted_warning`
and `tests/test_source_coverage.py::test_extraction_log_total` was confirmed
to exist before any of these fixes (touches code paths unrelated to this
phase) and is therefore not caused by these changes.

## Fixed Issues

### IN-01: Unused `all_objects` fixture parameter in TestWriteThrough

**Files modified:** `tests/test_schema_extensions.py`
**Commit:** f865037
**Applied fix:** Removed the unread `all_objects` parameter from
`test_no_signal_role_preserves_legacy_signal`. The test instantiates
`ObjectDatabase()` directly and only probes `phasor~`, so the fixture was
dead. Chose the parameter-removal option over the iterate-all-outlets
expansion to keep the diff minimal and focused; the docstring still
honestly describes the test as a single-probe regression anchor.

### IN-02: `audit_domain_coverage()` over-flags multi-domain restrictions

**Files modified:** `src/maxpat/db_lookup.py`
**Commit:** 755fba6
**Applied fix:** Switched the per-restriction loop from "any-mismatch
flags as orphan" to a Python `for/else` with `break` semantic — the object
is reported in `restricted_no_coverage` only when NONE of its listed
restrictions match `obj['domain']`. This is the recommended option 2 from
the review. Single-domain semantics (the only case in production today,
e.g. `floor~ → ["rnbo"]`) are unchanged; the existing audit test
(`test_audit_domain_coverage_detects_orphan`) still passes because
`cycle~` with `domain_restricted: ["m4l"]` and `obj_domain == "MSP"` still
fails to match the only listed restriction. The docstring was rewritten
to spell out the multi-domain semantic explicitly.

### IN-03: `_validate_schema_extensions()` and `_apply_signal_role_writethrough()` assume outlet entries are dicts

**Files modified:** `src/maxpat/db_lookup.py`
**Commit:** 5a0c1ab
**Applied fix:** Added an `isinstance(outlet, dict)` guard at the top of
the `for i, outlet in enumerate(...)` loop in `_validate_schema_extensions`,
raising `ValueError` naming the offending object and bad index when the
entry is not a dict. Mirrors the existing `isinstance(value, list)` guard
already used for `domain_restricted`. The same shape is used in
`_apply_signal_role_writethrough` defensively (silent skip rather than
crash) since the validator runs first and the writethrough sees only
post-validation data.

### IN-04: `_apply_signal_role_writethrough()` silently mutates loaded JSON

**Files modified:** `src/maxpat/db_lookup.py`
**Commit:** f983272
**Applied fix:** Added a "Note" section to `ObjectDatabase.lookup()`'s
docstring documenting the load-time projection from `signal_role` onto
the legacy `signal` bool. Names the projection contract
(`signal_role == "audio"` → `signal == True`; every other role → False),
points readers at `_apply_signal_role_writethrough` for the
implementation, and references the regression tests for verification.
This is a docstring-only change (no behavior change) and makes the
back-compat shim discoverable from the public surface where readers
encounter the projected `signal` value.

### IN-05: `_make_db_root` test helper omits supplementary files / silently drops nonexistent override keys

**Files modified:** `tests/test_schema_extensions.py`
**Commit:** 42b2c6b
**Applied fix:** Tightened the helper to assert that every non-comment
override key is in a new `_SEED_OBJECT_NAMES` set (today: just `"cycle~"`).
The assertion message explains the silent-drop trap so future test
authors hitting it understand why their typo'd override didn't raise.
Also added a docstring note about the deliberate omission of
`aliases.json`, `pd-blocklist.json`, and `package_info.json` so a future
refactor changing those `if path.exists()` guards to required reads
won't be surprised.

---

_Fixed: 2026-04-27_
_Fixer: Claude (gsd-code-fixer)_
_Iteration: 1_
