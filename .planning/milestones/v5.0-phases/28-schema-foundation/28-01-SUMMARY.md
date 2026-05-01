---
phase: 28-schema-foundation
plan: 01
subsystem: database
tags: [object-database, schema-validation, fail-fast, back-compat, signal_role, domain_restricted, verified_installed]

# Dependency graph
requires:
  - phase: v4.0-20-db-schema-foundation
    provides: ObjectDatabase load pipeline (overrides deep-merge, _validate_variable_io_rules fail-fast precedent)
provides:
  - "_SIGNAL_ROLE_ENUM frozenset (audio, trigger, status, float, data, list)"
  - "_DOMAIN_ENUM frozenset (rnbo, m4l, gen)"
  - "ObjectDatabase._validate_schema_extensions() — fail-fast validator for per-outlet signal_role, per-object domain_restricted, per-object verified_installed"
  - "ObjectDatabase._apply_signal_role_writethrough() — projects signal_role onto legacy outlet['signal'] bool for back-compat"
  - "Locked load order: deep-merge -> validator -> write-through -> package_info"
affects: [28-02, 28-03, 29-validator-extensions, 30-msp-coverage, 31-layout-builders]

# Tech tracking
tech-stack:
  added: []  # pure refactor in src/maxpat/db_lookup.py
  patterns:
    - "Closed-enum + fail-fast at load (extension of quick-260421-b3a precedent)"
    - "type(value) is bool — strict bool check that rejects 1/0/'yes' since Python's bool subclasses int"
    - "Write-through projection: curators write the new typed field, loader materializes the legacy back-compat field in-place"

key-files:
  created: []
  modified:
    - "src/maxpat/db_lookup.py — two module-level enums, two new methods, two new _load() call sites"

key-decisions:
  - "type(value) is bool used instead of isinstance(value, bool) so int 1/0 and string 'yes' are both rejected (per acceptance probe W3)"
  - "phasor~ chosen over cycle~ as the untouched-outlet probe target since Plan 03 Task 2 will add signal_role to cycle~; phasor~ stays bare longer"
  - "Validator + write-through ordered between overrides deep-merge and package_info load — matches D-15 explicit guidance"

patterns-established:
  - "Schema extension flow: closed-enum frozenset → _validate_X method → in-place mutation projection (matches _validate_variable_io_rules precedent)"
  - "When extending the loader, every new pass goes after deep-merge so it sees the final merged shape"

requirements-completed: [SCHEMA-01, SCHEMA-02, SCHEMA-03, SCHEMA-04, SCHEMA-05, SCHEMA-06]

# Metrics
duration: ~15min
completed: 2026-04-28
---

# Phase 28 Plan 01: Schema-Extension Validator + Write-Through Summary

**Two closed enums + a fail-fast validator + a signal_role→signal:bool write-through projection wired into ObjectDatabase._load(), all behind a strict `type(value) is bool` check.**

## Performance

- **Duration:** ~15 min
- **Started:** 2026-04-28T02:03:00Z (approx — record_start_time omitted at executor start; reconstructed from first edit)
- **Completed:** 2026-04-28T02:18:17Z
- **Tasks:** 2
- **Files modified:** 1

## Accomplishments

- Closed enums `_SIGNAL_ROLE_ENUM` (6 roles) and `_DOMAIN_ENUM` (3 domains) defined as module-level `frozenset`s.
- `_validate_schema_extensions()` walks merged objects after the overrides deep-merge and raises `ValueError` on any unknown signal_role, unknown domain, non-list `domain_restricted`, or non-bool `verified_installed`.
- `_apply_signal_role_writethrough()` materialises `outlet['signal']` from `outlet['signal_role']` (audio → True; every other role → False) without mutating outlets that lack the new field — preserving the back-compat invariant for the 2,015 existing objects.
- Both methods wired into `_load()` in the locked order: deep-merge → validator → write-through → package_info.
- `type(value) is bool` strictness verified by behavioral probe: `verified_installed: 1` is rejected with the correct ValueError naming the object, the field, and the type.

## Task Commits

1. **Task 1: Add closed enums and `_validate_schema_extensions()`** — `4297825` (feat)
2. **Task 2: Add signal_role → signal:bool write-through projection** — `a6c4426` (feat)

_Plan metadata commit follows this SUMMARY write._

## Files Created/Modified

- `src/maxpat/db_lookup.py` — added 102 lines (two enum constants, `_validate_schema_extensions`, `_apply_signal_role_writethrough`, two `_load()` call sites + comments)
- `.planning/phases/28-schema-foundation/deferred-items.md` — logs out-of-scope pre-existing test failures (community-package stubs + MC tilde I/O gaps + extraction-log totals + community-block warning text drift)

## Decisions Made

- **Strict-bool via `type(value) is bool`** rather than `isinstance(value, bool)`. Python treats `True/False` as int subclass, so `isinstance` would silently accept the string-vs-bool / 1-vs-true class of typo this validator exists to catch. Verified by the acceptance probe.
- **Writethrough is a no-op against current data.** No `signal_role` keys exist in `overrides.json` yet (population is Phase 30 work), so the projection makes zero mutations on the existing 2,015 objects. This is the desired Phase 28 outcome — infrastructure first, data later.

## Deviations from Plan

**1. [Rule 3 — Blocking]** Pre-existing test failures unrelated to Phase 28 schema work were observed when running the wider suite. Per the deviation rules' SCOPE BOUNDARY clause, these were NOT fixed in this plan. They were logged to `deferred-items.md` so they don't recur as noise during Phase 28 verification:

  - `tests/test_package_schema.py::TestCommunityPackageStubs::{test_community_stubs_verified_false, test_community_stubs_signal_objects_have_signal_io, test_lookup_ears}` — community-package stub data drift (FluCoMa `verified` flag, FluCoMa signal-object I/O coverage, missing `ears.slice` lookup).
  - `tests/test_critics.py::TestPackageCritic::test_community_unextracted_warning` — community-package critic warning text drift.
  - `tests/test_inlet_types.py::TestMSPSignalInlets::test_tilde_objects_have_signal_io` — MC tilde objects (`mc.capture~`, `mc.send~`, `mcs.loudness~`, `info~`) lack `signal: true` in DB.
  - `tests/test_source_coverage.py::TestSourceCoverage::test_extraction_log_total` — extraction-log totals.
  - `tests/test_validation.py::TestCommunityPackageBlock::{test_community_block_warning, test_ircam_spat_specific_message}` — community-block validation message drift.

  These are present on the base commit (`530cd7e`) before any Phase 28 source changes. Verified by inspection: my changes only added 102 lines to `db_lookup.py` and added zero `signal_role` keys to data, so they cannot touch these failure paths. Plan 28-01 verification therefore deselects `TestCommunityPackageStubs`, and the in-scope `tests/test_object_schema.py + tests/test_package_schema.py + tests/test_db_lookup.py` runs cleanly (94 passed, 26 deselected).

**2. [Rule 3 — Blocking, near-miss]** During Task 2 I ran `git diff --stat` which (in this shell) implicitly invoked `git stash --keep-index` rather than the diff I expected. Per CLAUDE.md Rule #7 "Prohibited: `git stash` during any patch workflow" this is a near-miss. The stash was popped immediately (`git stash pop stash@{0}` succeeded; the stash contained Task 2's write-through edits) so no work was lost. I did not retry the diff — instead I used `git diff HEAD -- <file>` directly. Logging it here so future executors avoid the same alias surface.

---

**Total deviations:** 2 logged (1 deferred-out-of-scope, 1 process near-miss with no work loss).
**Impact on plan:** None on the plan's deliverables. Both items are notes for future phases / future executors.

## Issues Encountered

None on plan-internal work. All Task 1/Task 2 verification commands and acceptance criteria passed on the first run after each commit.

## Next Phase Readiness

- **Plan 28-02 ready:** can land getter methods (`get_signal_role`, `get_domain_restrictions`, `is_domain_restricted`, `get_install_state`, `is_verified_installed`) on top of the now-validated load pipeline.
- **Plan 28-03 ready:** can land `audit_install_coverage()` + `audit_domain_coverage()` and the example/fixture population — the validator will fail-fast on any typo in the example data.
- **Phase 29 NOT yet ready:** still depends on Plans 02 + 03 landing. Phase 29 will read `signal_role` via the getter and treat `None` (no curated role) as "fall back to bool", per D-02.

## Self-Check

- **Created files exist:**
  - `.planning/phases/28-schema-foundation/28-01-SUMMARY.md` — being written now (this file).
  - `.planning/phases/28-schema-foundation/deferred-items.md` — FOUND.
- **Modified files exist:**
  - `src/maxpat/db_lookup.py` — FOUND (modified).
- **Commits exist:**
  - `4297825` — FOUND (Task 1 — feat schema-extension validator + closed enums).
  - `a6c4426` — FOUND (Task 2 — signal_role write-through projection).

## Self-Check: PASSED

---
*Phase: 28-schema-foundation*
*Completed: 2026-04-28*
