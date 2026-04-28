---
phase: 28-schema-foundation
verified: 2026-04-28T00:00:00Z
status: passed
score: 6/6 must-haves verified
overrides_applied: 0
---

# Phase 28: Schema Foundation Verification Report

**Phase Goal:** The object database carries per-outlet signal roles, domain restrictions, and install-verification status as typed first-class fields without breaking any existing consumer.
**Verified:** 2026-04-28
**Status:** passed
**Re-verification:** No — initial verification

## Goal Achievement

### Observable Truths (ROADMAP Success Criteria)

| #   | Truth                                                                                                                                                                                                                          | Status     | Evidence                                                                                                                                                                                                       |
| --- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1   | Developer can declare `signal_role: "audio" \| "trigger" \| "status" \| "float" \| "data" \| "list"` on any outlet in `overrides.json` and `ObjectDatabase` exposes it via `get_signal_role(name, outlet)`                       | ✓ VERIFIED | `_SIGNAL_ROLE_ENUM` at db_lookup.py:41-43 contains exactly six values; `get_signal_role` defined at line 529 with reverse derivation per D-02; runtime probe `db.get_signal_role('cycle~', 0) == 'audio'` ✓     |
| 2   | Existing code reading legacy `outlet["signal"]` continues to work unchanged — boolean derived from `signal_role` so no consumer breaks                                                                                          | ✓ VERIFIED | `_apply_signal_role_writethrough` at line 270 materializes `outlet['signal'] = (role == 'audio')`; back-compat readers preserved (patcher.py:250, db_lookup.py:741, rnbo.py:413); 94 existing tests still pass |
| 3   | Developer can mark object `domain_restricted: ["rnbo"]` and query via `db.is_domain_restricted(name)`                                                                                                                          | ✓ VERIFIED | `_DOMAIN_ENUM` at line 48 contains `{rnbo, m4l, gen}`; `get_domain_restrictions` line 588 returns list copy; `is_domain_restricted` line 603 sugar; `db.is_domain_restricted('floor~')` returns True ✓          |
| 4   | Developer can mark object `verified_installed: true/false` and query via `db.is_verified_installed(name)` (tri-state preserved)                                                                                                | ✓ VERIFIED | `get_install_state` line 563 returns `Optional[bool]` (None=unaudited, True=verified, False=missing); `is_verified_installed` line 578 collapses to `state is True`; `bach.llll2list` returns False ✓          |
| 5   | Three sibling audit functions — `audit_empty_io()` (unchanged), `audit_install_coverage()`, `audit_domain_coverage()` — surface coverage gaps from focused entry points                                                          | ✓ VERIFIED | `audit_empty_io` line 764 (unchanged shape `{critical, covered_by_override, variable_io_ok}`); `audit_install_coverage` line 806 returns `{unaudited, verified_false}` (3074/1 in production); `audit_domain_coverage` line 836 returns `{restricted_no_coverage}`; no umbrella `audit()` per D-13 ✓ |
| 6   | Schema validator rejects unknown enum values and wrong types at load (fail-fast)                                                                                                                                                | ✓ VERIFIED | `_validate_schema_extensions` line 213 walks merged objects after deep-merge; raises ValueError naming object + field; `type(value) is bool` strictness rejects int 1; 16 fail-fast tests pass                |

**Score:** 6/6 truths verified

### Required Artifacts

| Artifact                                       | Expected                                                                                                              | Status     | Details                                                                                                                                                                                |
| ---------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- | ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `src/maxpat/db_lookup.py`                      | Schema validator + write-through projection + 5 getters + 2 new audit functions + 2 module-level enums + DOMAIN_TO_FIELD | ✓ VERIFIED | All constants/methods present (verified via grep at lines 41, 48, 56, 165, 170, 213, 270, 529, 563, 578, 588, 603, 806, 836)                                                            |
| `.claude/max-objects/overrides.json`           | ≥3 example fixture rows exercising signal_role, domain_restricted, verified_installed                                  | ✓ VERIFIED | 4 fixtures present: `cycle~` (signal_role=audio), `snapshot~` (signal_role=float), `floor~` (domain_restricted=[rnbo]), `bach.llll2list` (verified_installed=false)                     |
| `tests/test_schema_extensions.py`              | ≥15 tests covering SCHEMA-01..07 and back-compat invariants                                                            | ✓ VERIFIED | 32 test functions across 4 classes (TestSchemaValidation, TestWriteThrough, TestGetters, TestAuditFunctions); 39 tests pass after parametrize expansion in 0.13s                       |

### Key Link Verification

| From                                                | To                                                            | Via                                                  | Status     | Details                                                                                                                                          |
| --------------------------------------------------- | ------------------------------------------------------------- | ---------------------------------------------------- | ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| `db_lookup.py:_load()`                               | `_validate_schema_extensions()`                               | called after overrides deep-merge                    | ✓ WIRED    | Line 165, after deep-merge loop at lines 150-159 and before `_apply_signal_role_writethrough` at line 170 and package_info at line 173            |
| `db_lookup.py:_load()`                               | `_apply_signal_role_writethrough()`                           | called after validator                                | ✓ WIRED    | Line 170, after validator at line 165 and before package_info load                                                                                |
| `db_lookup.py:get_signal_role`                       | `outlet['signal_role']` else fallback to `outlet['signal']`    | alias resolution then outlet lookup                  | ✓ WIRED    | Line 547-561: canonical alias resolution → outlet dict → role first, else legacy bool reverse derivation per D-02                                 |
| `db_lookup.py:get_install_state`                    | `obj['verified_installed']`                                   | alias resolution then per-object key lookup           | ✓ WIRED    | Line 572-576: canonical alias resolution → `obj.get('verified_installed')` returns Optional[bool]                                                  |
| `db_lookup.py:get_domain_restrictions`              | `obj['domain_restricted']`                                    | alias resolution then per-object key lookup; absent→[] | ✓ WIRED    | Line 597-601: canonical alias resolution → `list(obj.get('domain_restricted', []))` returns fresh copy (T-28-04 mitigation)                      |
| `db_lookup.py:audit_install_coverage`                | `self._objects[*].verified_installed`                         | walk all, classify by absent/True/False              | ✓ WIRED    | Line 822-834: walks `self._objects.items()`, separates `unaudited` (None) from `verified_false` (explicit False); production: 3074/1              |
| `db_lookup.py:audit_domain_coverage`                | `self._objects[*].domain_restricted` vs `_DOMAIN_TO_FIELD`     | walk restricted objects, check domain match          | ✓ WIRED    | Line 850-867: orphan-detection logic exercised by `test_audit_domain_coverage_detects_orphan` (cycle~ in MSP restricted to m4l → flagged)         |

### Data-Flow Trace (Level 4)

| Artifact                       | Data Variable                  | Source                                                                       | Produces Real Data | Status      |
| ------------------------------ | ------------------------------ | ---------------------------------------------------------------------------- | ------------------ | ----------- |
| `db.get_signal_role(...)`      | role string / None              | `outlet['signal_role']` from overrides.json deep-merge (post-validation)      | Yes (4 fixtures)   | ✓ FLOWING   |
| `db.get_install_state(...)`    | bool / None                     | `obj['verified_installed']` from overrides.json (validated as strict bool)    | Yes (1 fixture)    | ✓ FLOWING   |
| `db.get_domain_restrictions(...)` | list[str]                       | `obj['domain_restricted']` from overrides.json (validated list of enum)        | Yes (1 fixture)    | ✓ FLOWING   |
| `db.audit_install_coverage()`  | sorted lists                    | iterates `self._objects` post-load                                            | Yes (3074/1)       | ✓ FLOWING   |
| `db.audit_domain_coverage()`   | sorted list                     | iterates `self._objects` filtering `domain_restricted` against domain field   | Yes (0 today)      | ✓ FLOWING   |
| `outlet['signal']` (back-compat) | bool                            | `_apply_signal_role_writethrough` projects `signal_role == 'audio'` → True     | Yes (cycle~/snapshot~ fixtures verified True/False respectively) | ✓ FLOWING   |

### Behavioral Spot-Checks

| Behavior                                                                            | Command                                                                                                                              | Result                                                       | Status |
| ----------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------ | ------ |
| Schema-extension test suite passes                                                  | `python3 -m pytest tests/test_schema_extensions.py -v`                                                                                 | 39 passed in 0.13s                                            | ✓ PASS |
| Existing schema/db tests still green (back-compat anchor)                           | `python3 -m pytest tests/test_object_schema.py tests/test_package_schema.py tests/test_db_lookup.py --deselect TestCommunityPackageStubs -x -q` | 94 passed, 26 deselected (deferred per deferred-items.md)     | ✓ PASS |
| All success criteria observable via DB instance                                     | Combined runtime probe (enums, getters, audit shapes, write-through correctness, no-umbrella invariant)                                | All assertions pass; production unaudited=3074, verified_false=1 | ✓ PASS |
| Strict-bool rejection for `verified_installed: 1`                                   | Fail-fast probe via isolated tmp_path overrides                                                                                       | Raises ValueError mentioning `bool` and `cycle~`              | ✓ PASS |
| Write-through correctness: `signal_role=audio` → `signal=True`, others → False     | Inspect `cycle~` outlet 0 (audio) and `snapshot~` outlet 0 (float) after load                                                          | cycle~ signal=True, snapshot~ signal=False                    | ✓ PASS |

### Requirements Coverage

| Requirement | Source Plan         | Description                                                                                                                                                                        | Status      | Evidence                                                                                                            |
| ----------- | ------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- | ------------------------------------------------------------------------------------------------------------------- |
| SCHEMA-01   | 28-01               | Every outlet entry can declare a `signal_role` of `audio \| trigger \| status \| float \| data \| list`                                                                              | ✓ SATISFIED | `_SIGNAL_ROLE_ENUM` (db_lookup.py:41-43); fixtures in overrides.json (cycle~, snapshot~)                             |
| SCHEMA-02   | 28-01, 28-02, 28-03 | Existing `signal: bool` continues to work — derived from `signal_role` so no consumer breaks during migration                                                                       | ✓ SATISFIED | `_apply_signal_role_writethrough` (line 270); back-compat readers preserved at patcher.py:250, db_lookup.py:741       |
| SCHEMA-03   | 28-01               | Object entries can declare `domain_restricted: ["rnbo"]` (or other domains)                                                                                                         | ✓ SATISFIED | `_DOMAIN_ENUM` (line 48); fixture floor~ in overrides.json                                                            |
| SCHEMA-04   | 28-01               | Object entries carry a `verified_installed: bool` flag                                                                                                                              | ✓ SATISFIED | Validation (line 262-268) with strict-bool check; fixture bach.llll2list in overrides.json                            |
| SCHEMA-05   | 28-01, 28-02        | `overrides.json` schema extended to accept the three new fields and deep-merge them onto base objects                                                                                | ✓ SATISFIED | Deep-merge at lines 150-159 picks up new keys via the existing per-key loop; validation runs after merge              |
| SCHEMA-06   | 28-01, 28-02        | `db_lookup.ObjectDatabase` loads, validates, and exposes new schema fields via getter methods                                                                                       | ✓ SATISFIED | Five getters exist: get_signal_role (529), get_install_state (563), is_verified_installed (578), get_domain_restrictions (588), is_domain_restricted (603) |
| SCHEMA-07   | 28-03               | Three sibling audit functions — `audit_empty_io()` (unchanged), `audit_install_coverage()`, `audit_domain_coverage()`                                                                | ✓ SATISFIED | `audit_install_coverage` (line 806), `audit_domain_coverage` (line 836); `audit_empty_io` shape unchanged; no umbrella audit() per D-13 |

All 7 requirements satisfied. No orphaned requirements (every SCHEMA-* in REQUIREMENTS.md is claimed by at least one Phase 28 plan).

### Anti-Patterns Found

| File                                          | Line    | Pattern                            | Severity | Impact                                                                                                                                                                                                                       |
| --------------------------------------------- | ------- | ---------------------------------- | -------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| (none)                                        | -       | -                                  | -        | No TODO/FIXME/XXX/HACK markers introduced; no placeholder/empty implementations; no console.log-only handlers; no hardcoded empty data flowing to render paths                                                                |
| Code review info-level findings (28-REVIEW.md) | various | 5 info-level observations          | ℹ️ Info  | Unused `all_objects` fixture in TestWriteThrough (IN-01); multi-domain orphan over-flag latent bug (IN-02); missing dict-type guard in validator (IN-03); writethrough doc gap on lookup() (IN-04); test-helper looseness (IN-05). All non-blocking, no critical/warning findings. |

## Gaps Summary

No gaps. All six success criteria from ROADMAP are verified end-to-end:

- Two closed enums (`_SIGNAL_ROLE_ENUM`, `_DOMAIN_ENUM`) plus `_DOMAIN_TO_FIELD` mapping land at module level.
- `_validate_schema_extensions` runs after deep-merge and fails fast with object-name + field + value in the ValueError message.
- `_apply_signal_role_writethrough` materializes legacy `outlet['signal']` from `signal_role` (audio→True, others→False), preserving every existing back-compat reader (patcher.py:250, db_lookup.py:741, rnbo.py:413).
- Five public getters (`get_signal_role`, `get_install_state`, `is_verified_installed`, `get_domain_restrictions`, `is_domain_restricted`) expose the schema, all alias-resolved, with honest D-02 reverse derivation and T-28-04 list-copy mutation isolation.
- Three sibling audit functions (`audit_empty_io` unchanged, `audit_install_coverage` returning `{unaudited, verified_false}`, `audit_domain_coverage` returning `{restricted_no_coverage}`) all return sorted lists; no umbrella `audit()` wrapper exists per D-13.
- Four fixture rows in `overrides.json` (cycle~, snapshot~, floor~, bach.llll2list) exercise all three new fields end-to-end including both branches of the write-through projection.
- 39 tests in `tests/test_schema_extensions.py` pass; 94 existing schema/db tests still green (deferred-items.md pre-existing failures excluded as documented).

The 5 info-level findings in 28-REVIEW.md are non-blocking quality observations, not gaps. Phase 28 is complete and Phase 29 can proceed against the stable schema-extension surface.

---

_Verified: 2026-04-28_
_Verifier: Claude (gsd-verifier)_
