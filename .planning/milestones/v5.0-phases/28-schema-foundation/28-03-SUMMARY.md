---
phase: 28-schema-foundation
plan: 03
subsystem: database
tags: [object-database, audit-functions, fixtures, test-coverage, signal_role, domain_restricted, verified_installed, back-compat]

# Dependency graph
requires:
  - phase: 28-01
    provides: "_validate_schema_extensions() + _apply_signal_role_writethrough() in ObjectDatabase._load() — fail-fast validator runs before fixture data is loaded so any typo in the fixture would have surfaced at construction"
  - phase: 28-02
    provides: "Five getter methods (get_signal_role, get_install_state, is_verified_installed, get_domain_restrictions, is_domain_restricted) — TestGetters class exercises all five end-to-end against the fixtures landed in this plan"
provides:
  - "_DOMAIN_TO_FIELD module-level constant mapping domain_restricted enum values to canonical 'domain' field strings (rnbo->RNBO, m4l->M4L, gen->Gen)"
  - "ObjectDatabase.audit_install_coverage() -> {unaudited, verified_false} sorted lists (D-12)"
  - "ObjectDatabase.audit_domain_coverage() -> {restricted_no_coverage} sorted list (D-12)"
  - "Four example fixture rows in overrides.json exercising all three new schema fields end-to-end (cycle~, snapshot~, floor~, bach.llll2list)"
  - "tests/test_schema_extensions.py — 32 test functions across 4 test classes covering SCHEMA-01..07 and back-compat invariants (39 tests after parametrize expansion)"
affects: [29-validator-extensions, 30-msp-coverage, 31-layout-builders, 32-dsp-preflight]

# Tech tracking
tech-stack:
  added: []  # pure additions on existing surface — no new deps
  patterns:
    - "Audit function family: return-dict-of-sorted-lists keyed by classification bucket (matches audit_empty_io sibling)"
    - "Fixture-driven schema exercise: one canonical example per new field landed in overrides.json so back-compat is verified end-to-end without waiting for Phase 30 population"
    - "Isolated tmp_path DB roots for fail-fast tests — minimal MSP-only objects.json + overrides.json with a bad value, expect ValueError at ObjectDatabase() construction"
    - "Class-scoped db fixture for getter/audit tests — single ObjectDatabase() construction shared across all tests in TestGetters and TestAuditFunctions"
    - "Negative invariant tests (test_no_umbrella_audit_method, test_audit_empty_io_shape_unchanged) lock D-12/D-13 decisions against future drift"

key-files:
  created:
    - "tests/test_schema_extensions.py — 422 lines, 32 test functions across 4 classes (TestSchemaValidation, TestWriteThrough, TestGetters, TestAuditFunctions)"
  modified:
    - "src/maxpat/db_lookup.py — added 73 lines (one module-level constant + two new audit methods)"
    - ".claude/max-objects/overrides.json — added 45 lines (extended cycle~ entry with outlets/signal_role; added snapshot~, floor~, bach.llll2list new entries)"

key-decisions:
  - "Used phasor~ as the bare-signal probe in test_no_signal_role_preserves_legacy_signal because cycle~ now has a curated signal_role from this plan's fixture additions — same call-out the Plan 28-01 SUMMARY made when it picked phasor~ for the same reason"
  - "Fixture choice: cycle~ + snapshot~ for signal_role (audio + non-audio role to exercise both write-through projection branches), floor~ for domain_restricted (canonical RNBO-only object per CLAUDE.md), bach.llll2list for verified_installed: false (canonical 'audited and known missing' per memory feedback_bach_no_llll2list)"
  - "Used type(value) is bool strictness assertion in test_verified_installed_int_raises — exercises the same Plan 28-01 design choice that rejects 1/0/True/False ints since Python treats bool as int subclass"

patterns-established:
  - "Test schema-extension validator with isolated tmp_path: minimal msp/objects.json (one cycle~ entry) + overrides.json with the bad value -- the smallest possible failure-mode reproduction that loads cleanly except for the validation"
  - "Audit function family signature: dict[str, list[str]] returning sorted lists keyed by classification bucket; do NOT add an umbrella wrapper this phase (D-13)"
  - "_audit blocks on every new override entry — source citation, confidence level, finding — so the diff is self-documenting and future curators can trace why each fixture exists"

requirements-completed: [SCHEMA-02, SCHEMA-07]

# Metrics
duration: ~16min
completed: 2026-04-28
---

# Phase 28 Plan 03: Audit Functions, Fixtures, Test Coverage Summary

**Two new audit functions (`audit_install_coverage`, `audit_domain_coverage`) per D-12; four example fixture rows in `overrides.json` exercising all three new schema fields end-to-end; one new test file (`tests/test_schema_extensions.py`) with 32 test functions across 4 classes locking the SCHEMA-01..07 surface plus the back-compat regression anchor against drift.**

## Performance

- **Started:** 2026-04-28T02:28:37Z
- **Completed:** 2026-04-28T02:44:15Z (approx — wall-clock from epoch delta)
- **Duration:** ~16 min
- **Tasks:** 3
- **Files created:** 1 (tests/test_schema_extensions.py)
- **Files modified:** 2 (src/maxpat/db_lookup.py, .claude/max-objects/overrides.json)
- **Commits:** 3 task commits + 1 plan-metadata commit (after this SUMMARY write)

## Accomplishments

### Task 1 — Two new audit functions on ObjectDatabase

- **`audit_install_coverage()`** returns `{"unaudited": [...], "verified_false": [...]}` with both lists sorted alphabetically and disjoint by construction. `unaudited` collects every canonical name where `verified_installed` is absent (the Phase 30 coverage metric per D-11); `verified_false` collects only explicit `False` (the Phase 29 warning target per D-10). Production DB returns 3,074 unaudited / 1 verified_false at this plan's completion (the 1 is `bach.llll2list` from Task 2's fixture).
- **`audit_domain_coverage()`** returns `{"restricted_no_coverage": [...]}` sorted alphabetically. Surfaces canonical names whose `domain_restricted: ["X"]` does not match the object's actual `domain` field — i.e., orphaned restrictions caused by override typos or extraction gaps. Production DB returns 0 entries at completion (the only fixture, `floor~`, has its restriction matching its RNBO domain).
- **Module-level `_DOMAIN_TO_FIELD`** constant near the existing `_DOMAIN_ENUM` maps the three lowercase enum values to the canonical `domain` field strings (`rnbo` → `RNBO`, `m4l` → `M4L`, `gen` → `Gen`). Used only by `audit_domain_coverage()`; declared at module level so tests can import and assert its shape.
- **D-12/D-13/D-14 invariants preserved:** `audit_empty_io()` shape unchanged (`{critical, covered_by_override, variable_io_ok}`); no umbrella `audit()` wrapper added; zero per-domain JSONs modified.

### Task 2 — Example fixture rows in overrides.json

Four example fixtures exercise the schema end-to-end:

| Object | Field added | Value | Purpose |
|---|---|---|---|
| `cycle~` | per-outlet `signal_role` | `"audio"` | Canonical audio-rate role; write-through projects to `signal: True` |
| `snapshot~` | per-outlet `signal_role` | `"float"` | Canonical non-audio role; write-through projects to `signal: False` |
| `floor~` | `domain_restricted` | `["rnbo"]` | Canonical RNBO-only object per CLAUDE.md MSP section |
| `bach.llll2list` | `verified_installed` | `false` | Canonical "audited and known missing" per memory `feedback_bach_no_llll2list` |

Each new entry includes an `_audit` block with source, confidence, and finding so the diff is self-documenting. The cycle~ entry already existed (with only `min_version: 4`); it was extended with a new `outlets` array. Per D-14, only `overrides.json` was modified — no per-domain JSON files touched.

### Task 3 — Comprehensive test coverage

`tests/test_schema_extensions.py` (422 lines, 32 test functions, 39 tests after parametrize expansion):

- **TestSchemaValidation (9 functions, 16 parametrize-expanded tests)** — fail-fast at load on every malformed shape. Each parametrized test exercises every value of `_SIGNAL_ROLE_ENUM` (6 values) and `_DOMAIN_ENUM` (3 values) for accepted-value coverage.
- **TestWriteThrough (3 tests)** — projection from `signal_role` onto `outlet[signal]`. Audio role projects True over an explicit False; non-audio role projects False over an explicit True; pristine outlets without `signal_role` preserve the legacy bool unchanged (back-compat regression anchor against the 2,015+ existing readers).
- **TestGetters (11 tests)** — all five Plan 02 getters exercised, including alias resolution (`'t'` → `'trigger'`), out-of-range outlet, unknown object, legacy `signal: false` → `None` (D-02 distinguishes uncurated from known-not-audio), tri-state preservation through `is_verified_installed` (D-10), and list-copy mutation isolation on `get_domain_restrictions` (T-28-04).
- **TestAuditFunctions (9 tests)** — both new audit functions, sorted invariant, disjoint invariant, fixture inclusion (`bach.llll2list` in `verified_false`), `audit_empty_io` shape unchanged (D-12), no umbrella `audit()` method (D-13), and the orphan-detection logic exercised end-to-end via an isolated `tmp_path` DB where an MSP-domain object is incorrectly restricted to `m4l`.

All 39 new tests pass. All 94 existing in-scope tests in `test_object_schema.py + test_package_schema.py + test_db_lookup.py` remain green (identical to the Plan 28-01 / Plan 28-02 baseline).

## Task Commits

1. **Task 1: Add `audit_install_coverage` and `audit_domain_coverage`** — `bfdffcf` (feat)
2. **Task 2: Add example fixture rows for new schema fields** — `3f3b4a0` (feat)
3. **Task 3: Add `tests/test_schema_extensions.py` with 32 schema-extension tests** — `24df553` (test)

_Plan metadata commit follows this SUMMARY write._

## Files Created/Modified

- **Created:** `tests/test_schema_extensions.py` (422 lines, 32 test functions, 4 test classes)
- **Modified:** `src/maxpat/db_lookup.py` (+73 lines: `_DOMAIN_TO_FIELD` constant + `audit_install_coverage` + `audit_domain_coverage`)
- **Modified:** `.claude/max-objects/overrides.json` (+45 lines net: extended `cycle~` entry; added `snapshot~`, `floor~`, `bach.llll2list` new entries)

## Decisions Made

- **`phasor~` as the bare-signal probe** in `test_no_signal_role_preserves_legacy_signal`. Because Plan 28-03 Task 2 added `signal_role: "audio"` to `cycle~`, that object can no longer serve as the "uncurated outlet" probe — Plan 28-01's SUMMARY pre-empted this by recommending `phasor~` for exactly the same reason. The test asserts `phasor~` outlet 0 has no `signal_role` and that its `signal: True` is preserved unchanged through the write-through (which only mutates outlets that DO have a curated role).
- **Fixture object selection for end-to-end exercise.** `cycle~` and `snapshot~` together cover both branches of the write-through projection: audio-role-True-projection and non-audio-role-False-projection. `floor~` is the canonical RNBO-restricted example documented in CLAUDE.md's MSP section. `bach.llll2list` is the canonical "audited but known missing" example documented in memory `feedback_bach_no_llll2list`. These four fixtures cover every test path the validator and getters expose.
- **Strict-bool test target choice.** `test_verified_installed_int_raises` uses the integer `1`, not `0`, because the `type(value) is bool` check rejects both — but `1` makes the intent of the test most legible (since `True` and `1` are equal in Python semantics, the test's value is showing that the validator treats them differently).
- **Class-scoped db fixture for TestGetters and TestAuditFunctions.** Avoids reconstructing `ObjectDatabase` (which loads ~3000 objects across 8 domains) per test. TestSchemaValidation cannot share a class fixture because each test needs an isolated `tmp_path` DB root with a different bad value.

## Deviations from Plan

**1. [Rule 3 — Blocking, scope-bounded]** Pre-existing test failures already logged in `.planning/phases/28-schema-foundation/deferred-items.md` by Wave 1 (Plan 28-01) re-surface when running the wider suite. Per the deviation rules' SCOPE BOUNDARY clause, these were NOT fixed in this plan — they predate any Phase 28 work and are out of scope. Verification used the established Wave 1/Wave 2 pattern: deselect `TestCommunityPackageStubs`, which produced 94 passed / 26 deselected — exactly matching the Plan 28-01 and Plan 28-02 baselines.

  My changes (addition of two methods + four override entries + a new test file) cannot regress these failures: the new methods are pure read paths over `self._objects`, the override entries don't touch the community-stub data path, and the new test file is independent of the community-stub fixtures.

**2. [Rule 2 — Auto-add critical functionality]** Test `test_get_domain_restrictions_returns_list_copy` was strengthened beyond the plan-spec to also assert the post-mutation result equals `["rnbo"]` exactly (not just "doesn't contain 'hacked'"). Plan §action only required asserting "mutating the returned list does not affect a subsequent call." Adding the equality assertion makes the test fail loudly if the underlying schema ever shifts away from a single-element rnbo restriction on `floor~`, which would be the more useful failure mode.

---

**Total deviations:** 2 logged (1 scope-bounded re-surface of Wave-1-deferred failures, 1 Rule-2 test-strengthening that exceeds plan spec).
**Impact on plan deliverables:** None on plan-scope deliverables; test strengthening (#2) makes the suite more durable.

## Issues Encountered

None on plan-internal work. All three tasks' verification commands and acceptance criteria passed on the first run after each commit. The 39 new tests (32 functions + 7 parametrize expansions) passed in 0.15s.

## Verification Results

### Overall verification (per plan §verification)

1. **`python3 -m pytest tests/test_schema_extensions.py -v`** — 39 passed in 0.15s (32 functions, 7 from parametrize expansion).
2. **`python3 -m pytest tests/test_object_schema.py tests/test_package_schema.py tests/test_db_lookup.py --deselect tests/test_package_schema.py::TestCommunityPackageStubs -x -q`** — 94 passed, 26 deselected, identical to the Plan 28-01 / Plan 28-02 baselines.
3. **End-to-end fixture exercise** —
   - `db.get_signal_role('cycle~', 0)` returns `'audio'` ✓
   - `db.get_domain_restrictions('floor~')` returns `['rnbo']` ✓
   - `db.get_install_state('bach.llll2list')` returns `False` ✓
4. **Audit functions return shape and sorted invariants** — both verified by behavioral probe and by tests `test_audit_install_coverage_keys` / `test_audit_install_coverage_sorted` / `test_audit_domain_coverage_keys` / `test_audit_domain_coverage_sorted`.
5. **`audit_empty_io()` shape unchanged** — verified by `test_audit_empty_io_shape_unchanged` (D-12 invariant locked against drift).
6. **No `audit()` umbrella exists** — verified by `test_no_umbrella_audit_method` (D-13 invariant locked against drift).
7. **Only `overrides.json` touched under `.claude/max-objects/`** — `git diff --stat .claude/max-objects/` returns one file (overrides.json, +45/-1 lines).

### Acceptance criteria (per task)

- **Task 1:** `def audit_install_coverage` count = 1; `def audit_domain_coverage` count = 1; `_DOMAIN_TO_FIELD` references = 2 (declaration + use); no `def audit\b` umbrella; no `.claude/max-objects/` files modified by this task. ✓
- **Task 2:** overrides.json valid JSON; ≥1 entry per new field (4 entries total); ObjectDatabase loads cleanly; write-through projection materializes `signal: bool` from every fixtured `signal_role` correctly; no per-domain JSONs modified; `variable_io_rules` untouched. ✓
- **Task 3:** test file exists; all 4 classes present; ≥15 test functions (32 functions, 39 with parametrize); new tests pass; existing 94 tests still pass; fail-fast tests exist for all three new fields; write-through tests = 3; D-13 invariant test = 1; D-12 audit_empty_io invariant test = 1; orphan-detection test = 1. ✓

## Next Phase Readiness

- **Phase 28 complete.** All seven SCHEMA-* requirements (SCHEMA-01 through SCHEMA-07) are satisfied across the three plans:
  - SCHEMA-01..03: closed-enum field declarations + fail-fast validator (Plan 28-01)
  - SCHEMA-04: write-through back-compat shim (Plan 28-01)
  - SCHEMA-05..06: getter API (Plan 28-02)
  - SCHEMA-07: audit functions (Plan 28-03)
- **Phase 29 ready (validator-extensions):** the Plan 02 getters (`get_signal_role`, `get_install_state`, etc.) plus this plan's audit functions are the stable surface Phase 29's role-aware connection validator, install-state warning, and domain hard-guard will read against. Per D-02, Phase 29 must treat `get_signal_role()` returning `None` as "fall back to the bool check, do not emit a role-mismatch error."
- **Phase 30 ready (msp-coverage):** Phase 30 will populate `signal_role` across MSP objects in bulk; the Phase 28 validator + write-through guarantee that any typo will fail loudly at load time, and the `audit_install_coverage().unaudited` count is the locked Phase 30 success metric per D-11.
- **Phase 31 ready (layout-builders):** Plan 02 getters give the layout engine a typed signal_role surface to consult for companion-pair patterns.

## Threat Flags

None. This plan introduces no new network endpoints, auth paths, file access patterns, or schema changes at trust boundaries beyond what was already declared in the plan's `<threat_model>`. The fixture additions in `overrides.json` are additive, version-controlled, and reviewed via git diff (T-28-06 disposition: accept, identical to T-20-03). The audit functions perform an O(N) walk over the in-memory object dict — no I/O, no external dependencies (T-28-07 disposition: accept). The list-copy invariant on `get_domain_restrictions` (T-28-08) is now under regression test via `test_get_domain_restrictions_returns_list_copy`.

## Self-Check

- **Created files exist:**
  - `tests/test_schema_extensions.py` — FOUND.
  - `.planning/phases/28-schema-foundation/28-03-SUMMARY.md` — being written now (this file).
- **Modified files exist:**
  - `src/maxpat/db_lookup.py` — FOUND (modified, +73 lines).
  - `.claude/max-objects/overrides.json` — FOUND (modified, +45/-1 lines).
- **Commits exist:**
  - `bfdffcf` — FOUND (Task 1 — feat audit functions).
  - `3f3b4a0` — FOUND (Task 2 — feat fixture rows).
  - `24df553` — FOUND (Task 3 — test schema extensions).

## Self-Check: PASSED

---
*Phase: 28-schema-foundation*
*Completed: 2026-04-28*
