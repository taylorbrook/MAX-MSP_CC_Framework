---
phase: 29-validator-depth
plan: 03
subsystem: validation
tags: [validation, role-aware, tier-dispatch, signal-types, msp]

# Dependency graph
requires:
  - phase: 28-schema-foundation
    provides: "ObjectDatabase.get_signal_role() + per-outlet signal_role enum + reverse-derivation contract"
provides:
  - "_ROLE_TIER_TABLE module constant — single source of truth for role-aware tier severity (D-04, D-19)"
  - "_classify_dst_inlet helper — coarse signal/float/control classifier for tier-table dst_kind lookup"
  - "_classify_role_mismatch helper — tier-table lookup with formatted message construction"
  - "Role-aware tier dispatch grafted into _validate_connections ahead of legacy signal:bool branch"
  - "TestRoleAwareValidation class with 10 tests covering ERROR tier, WARNING tier, audio fall-through, uncurated fall-through, audio-key invariant, severity contract"
affects: [29-04 install-state warnings, 29-05 codebox validation, future role curation phases that add status/data/list/trigger annotations to overrides.json]

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "Tier-table dispatch: (src_role, dst_kind) -> (level, suggestion, auto_fix) — module-level const, easy to extend with new role/kind pairs without touching the validator loop"
    - "Coarse dst_kind classification: signal/float hybrids classify as 'signal' for tier purposes, since event-message sources (status/trigger/list/data) shouldn't drive numeric inlets regardless of hybrid acceptance"
    - "Role-first dispatch: when get_signal_role returns curated role, run tier table; on miss/audio/None, fall through to legacy unchanged — clean separation per D-02"

key-files:
  created: []
  modified:
    - "src/maxpat/validation.py — added _ROLE_TIER_TABLE, _FLOAT_DISPLAY_MAXCLASSES, _classify_dst_inlet, _classify_role_mismatch, and tier dispatch block in _validate_connections"
    - "tests/test_validation.py — added TestRoleAwareValidation with 10 tests"

key-decisions:
  - "signal/float inlets classify as 'signal' for tier-table lookup. The CLAUDE.md 'signal/float accepts both' exception still holds for the legacy signal:bool branch (audio sources to signal/float inlets pass silently), but for non-audio role sources the mechanical-fix tier is the right call: a status/trigger/list/data outlet is an event-message stream, not a numeric value."
  - "_FLOAT_DISPLAY_MAXCLASSES (flonum, number, live.numbox) get inlet 0 classified as 'float' for tier purposes, even though their DB inlet type is 'control'. This makes the WARNING tier (trigger/list -> float) fire on the natural target (UI float widgets) without curating their inlet types in the DB."
  - "Tier dispatch uses `continue` to skip the legacy is_signal_source branch. ERROR tier sets remove_this=True AND appends to to_remove inline (so the trailing `if remove_this` block at the loop tail is bypassed by the continue) — single auto-remove path, no double append."

patterns-established:
  - "Role-aware tier dispatch: a module-level dict-keyed by (src_role, dst_kind) tuples is the cleanest extensibility point for future role contracts — each new mismatch adds a row, no validator-loop edits."
  - "Coarse-and-conservative classifier: keep dst_kind labels small ({signal, float, control}) so the table fits on screen and matches D-04 message format verbatim."
  - "Audio fall-through invariant (R2/R10): explicit guard `src_role != 'audio'` in the dispatch ensures audio sources never see the tier table, preserving every existing TestLayer3SignalTypes regression anchor."

requirements-completed: [VALID-01, VALID-05]

# Metrics
duration: ~25 min
completed: 2026-04-29
---

# Phase 29 Plan 03: Role-Aware Tier Dispatch Summary

**Layer 3 connection validator now emits role-aware ERROR with mechanical-fix suggestions ('use snapshot~', 'use sig~ or click~') for status/trigger/data/list -> signal mismatches, and WARNING with intent hints for trigger/list -> float, replacing generic type-mismatch wording for curated source roles while leaving audio-source paths and uncurated objects on the legacy signal:bool branch unchanged.**

## Performance

- **Duration:** ~25 min
- **Started:** 2026-04-29T01:05:00Z
- **Completed:** 2026-04-29T01:30:00Z
- **Tasks:** 3 (all completed)
- **Files modified:** 2 (1 source, 1 test)

## Accomplishments

- `_ROLE_TIER_TABLE` module constant ships the locked D-04/D-19 severity contract: 4 ERROR rows (status/trigger/data/list -> signal, all auto_fix=True) and 2 WARNING rows (trigger/list -> float, both auto_fix=False). Audio-source keys are intentionally absent.
- Two new helpers (`_classify_dst_inlet`, `_classify_role_mismatch`) handle dst-kind classification and tier-table lookup with the verbatim D-04 message format `{src_role} outlet → {dst_kind} inlet: {suggestion}`.
- Tier dispatch is grafted into `_validate_connections` ahead of the legacy `is_signal_source` branch. On hit (curated non-audio role + table match), it emits the result, optionally auto-removes, and `continue`s — bypassing the legacy branch (D-02 clean separation). On miss/audio/None, control falls through to legacy unchanged.
- `TestRoleAwareValidation` class adds 10 tests covering every D-19 row, both regression invariants (R2/R10 — audio fall-through and audio-key absence), uncurated fall-through, and the ERROR/WARNING auto_fix contract. All TestLayer3SignalTypes and TestLayer3OverrideGuard anchor tests stay green.

## Task Commits

Each task was committed atomically:

1. **Task 1: Add _ROLE_TIER_TABLE + _classify_dst_inlet + _classify_role_mismatch** — `1779f6a` (feat)
2. **Task 2: Graft tier dispatch into _validate_connections** — `5e65552` (feat)
3. **Task 2 follow-on: Classify signal/float as 'signal' for tier-table lookup** — `7492d47` (fix) — see Deviations below
4. **Task 3: Add TestRoleAwareValidation class with 10 tests** — `5ecc242` (test)

## Files Created/Modified

- `src/maxpat/validation.py` — Added `_ROLE_TIER_TABLE` (6 entries), `_FLOAT_DISPLAY_MAXCLASSES` (3 widgets), `_classify_dst_inlet` (35 lines), `_classify_role_mismatch` (20 lines), and tier dispatch block (24 lines) inside `_validate_connections`. Net +132 insertions across 3 commits.
- `tests/test_validation.py` — Added `TestRoleAwareValidation` class (250 lines, 10 tests) using `monkeypatch.setattr(db, 'get_signal_role', ...)` to drive synthetic role values without polluting overrides.json.
- `.planning/phases/29-validator-depth/deferred-items.md` — Created to log 2 pre-existing test failures unrelated to this plan (see Issues Encountered).

## Decisions Made

- **signal/float -> "signal" for tier purposes.** The plan's locked truths reference `snapshot~ -> *~` as a (status, signal) example, but `*~` inlet 0 is `signal/float` (hybrid). Returning `"signal/float"` would miss the tier table and fall through to legacy. The semantic call: event-message sources (status/trigger/list/data) feeding hybrid inlets are still mechanical mismatches — the `snapshot~`/`sig~` suggestion still applies. The CLAUDE.md "accepts both" exception keeps holding for the legacy branch (audio sources to hybrid inlets remain silent).
- **Float-display widget special case.** `flonum`/`number`/`live.numbox` carry `type: "control"` inlets in the DB but are float-display by purpose. Added `_FLOAT_DISPLAY_MAXCLASSES` so `_classify_dst_inlet` returns `"float"` for inlet 0 on these widgets, making the WARNING tier (trigger/list -> float) target the natural UI destination. Avoids curating UI-widget inlet types in the DB.
- **`continue` after tier dispatch.** Both ERROR and WARNING tiers `continue` to the next line. The auto-remove path appends to `to_remove` inline before the continue, so the trailing `if remove_this: to_remove.append(idx)` at the loop tail is bypassed — single append, no duplication.

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] _classify_dst_inlet originally returned "signal/float", missing the tier table**

- **Found during:** Task 3 (running `test_status_to_signal_emits_use_snapshot`)
- **Issue:** The plan's draft of `_classify_dst_inlet` returned `"signal/float"` for hybrid inlets (where `signal=True` AND `type` contains `"float"`). The default test destination `*~ 0.5` has signal/float inlets, so `(status, signal/float)` missed the tier table — but the plan's locked truths explicitly use `snapshot~ -> *~` as a (status, signal) example. Either change every test's destination to a strict-signal-inlet object (`tanh~`/`dac~`), or treat hybrid as signal for tier purposes.
- **Fix:** Removed the `"signal/float"` branch from `_classify_dst_inlet`. Hybrid inlets now classify as `"signal"`. Updated docstring to document the coarse-classification rationale: event-message sources never belong on signal-accepting inlets, hybrid or strict.
- **Files modified:** `src/maxpat/validation.py` (4 lines removed, 7 added)
- **Verification:** All 10 TestRoleAwareValidation tests pass; all 3 TestLayer3SignalTypes anchors stay green (audio sources still go to legacy branch via the `src_role != "audio"` guard, untouched).
- **Committed in:** `7492d47` (separate fix commit, kept distinct from Task 2's feature commit per Rule "create new commits not amends")

---

**Total deviations:** 1 auto-fixed (Rule 1 — bug fix to make Task 3 tests pass per the plan's locked truths)
**Impact on plan:** Refinement was load-bearing — without it, Task 3 acceptance would have required either changing every destination object in the test class (defeating the point of `*~ 0.5` as the ergonomic default) or adding `(status, "signal/float")`/`(trigger, "signal/float")`/etc. duplicate entries to the tier table (doubling its size for the same semantic). The coarse-classifier approach matches the D-19 row matrix exactly and keeps `_ROLE_TIER_TABLE` at 6 rows.

## Issues Encountered

- **2 pre-existing test failures** in `tests/test_validation.py::TestCommunityPackageBlock` (`test_community_block_warning`, `test_ircam_spat_specific_message`) fail on the base commit `427a21e` before any Plan 29-03 changes. Verified via stash-test-pop. Out of this plan's scope; logged in `.planning/phases/29-validator-depth/deferred-items.md`. Net effect of Plan 29-03: 0 new failures, +10 new passing tests, no tests broken.
- **Full-suite differential** (1646 collected, 4 xfailed): base commit has 49 failures (1589 passing), Plan 29-03 has 49 failures (1599 passing). `diff` between the two failure lists is empty — every failure on the post-plan run is also pre-existing on the base. The 49 unrelated failures (integration patches, package_schema, source_coverage) are out of scope; documented in deferred-items.md as the regression boundary.

## Next Phase Readiness

- **Plan 29-04 (Layer 4 install-state warnings):** Can layer cleanly alongside the tier dispatch — the role check fires inside `_validate_connections`; install-state warnings will fire elsewhere (likely in `_validate_objects_exist` or a new sibling). No conflict.
- **Plan 29-05 (embedded codebox validation):** Operates on a different surface (codebox text, not connection lines). No interaction with `_ROLE_TIER_TABLE` or tier dispatch.
- **Future role curation:** When `overrides.json` annotates more outlets with `signal_role: "status" | "trigger" | "data" | "list"`, the tier dispatch will start firing on production patches automatically — no validator changes needed. The defensive `test_role_tier_table_excludes_audio_keys` test will catch any regression that adds audio keys to the table.

## Self-Check

Verifying claimed artifacts exist:

- `.planning/phases/29-validator-depth/29-03-SUMMARY.md` — present (this file)
- `src/maxpat/validation.py` — modified (commits `1779f6a`, `5e65552`, `7492d47`)
- `tests/test_validation.py` — modified (commit `5ecc242`)
- `.planning/phases/29-validator-depth/deferred-items.md` — present

Verifying claimed commits exist in git log: `1779f6a`, `5e65552`, `7492d47`, `5ecc242` — all present in `git log --oneline -5`.

Verifying acceptance criteria via grep — all 10 required test methods, all 4 D-04 string literals, all 2 helper definitions, all 4 dispatch-graft anchors present. Manual probe `python3 -c "from src.maxpat.validation import _ROLE_TIER_TABLE; assert ('audio','signal') not in _ROLE_TIER_TABLE; assert ('status','signal') in _ROLE_TIER_TABLE; print('invariants hold')"` prints `invariants hold`.

## Self-Check: PASSED

---
*Phase: 29-validator-depth*
*Completed: 2026-04-29*
