---
phase: 31-layout-ux-builders
plan: 03
subsystem: layout
tags: [layout, signal_role, companion-pairs, apply_layout, phase-30-consumer]

# Dependency graph
requires:
  - phase: 28-signal-role-schema
    provides: ObjectDatabase.get_signal_role(name, outlet) returning curated role or None
  - phase: 30-signal-role-curation
    provides: cycle~ outlet 0 audit-stamped signal_role="audio" (canonical fixture)
  - phase: 31-01-companion-pair-builder
    provides: add_overlay_readout (referenced by D-14 status->flonum overlay branch; not exercised in this plan)
provides:
  - "_ROLE_COMPANION_MAP module-level constant in layout.py (D-14 verbatim, six keys)"
  - "_identify_companions(boxes, lines, rows, db=None) with role-first dispatch and legacy fall-through"
  - "apply_layout threads patcher.db into _identify_companions; subpatcher recursion preserves db (Pitfall 3)"
affects:
  - "31-05 (audit refresh) — role coverage gaps surface as missing meter~ companions in generated layouts"
  - "Future PR critic — can warn when audio outlets lack a downstream meter~/scope~ pair"

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "Role-first dispatch + legacy heuristic fall-through (Pattern 4 in 31-RESEARCH.md)"
    - "Optional db threading: db=None preserves back-compat for callers without ObjectDatabase access"

key-files:
  created:
    - tests/test_companion_role_layout.py
  modified:
    - src/maxpat/layout.py

key-decisions:
  - "Role pass A claims companions by edge (src.outlet -> dst.name == role_map[role].companion); legacy pass B catches anything unclaimed by name. Edge-driven role pass is more precise than name-only and avoids false-positive claims when multiple sources feed a single meter~."
  - "db.get_signal_role wrapped in try/except so a malformed DB lookup degrades gracefully to the legacy heuristic instead of breaking layout for the whole patcher."
  - "Did NOT implement the placement='overlay' branch in _place_companions. The role map declares status->flonum/overlay per D-14, but Phase 30 has no MSP outlet with role='status' that would exercise this code path. Deferred until a status-role outlet is curated and the add_overlay_readout helper from 31-01 is wired in via 31-05."

patterns-established:
  - "Role-first dispatch with legacy fall-through: consult curated metadata when present, fall through to name-based heuristic when role is None or db is missing."

requirements-completed:
  - LAYOUT-03

# Metrics
duration: ~12min
completed: 2026-04-30
---

# Phase 31 Plan 03: Role-Driven Companion Dispatch Summary

**`_ROLE_COMPANION_MAP` constant + role-first `_identify_companions` dispatch consuming Phase 30's curated `signal_role` data, with legacy `_COMPANION_NAMES` heuristic preserved as fall-through for unaudited outlets and back-compat (db=None) callers.**

## Performance

- **Duration:** ~12 min
- **Tasks:** 2 (Wave 0 scaffold + Wave 1 implementation)
- **Files modified:** 2 (1 created: tests/test_companion_role_layout.py; 1 modified: src/maxpat/layout.py)
- **Commits:** 2 atomic (test scaffold + feature)
- **Tests added:** 12 collected (10 functions + 2 parametrize cases) — all passing

## Accomplishments

- Added module-level `_ROLE_COMPANION_MAP` to `src/maxpat/layout.py` with the six D-14 keys verbatim (audio, status, trigger, float, data, list), placed immediately after `_COMPANION_NAMES` at the file-level constants section.
- Extended `_identify_companions(boxes, lines, rows, db=None)` to run a role-driven Pass A first (edge-iterating, consulting `db.get_signal_role(src.name, line.source_outlet)` and `_ROLE_COMPANION_MAP`), then fall through to the legacy `_COMPANION_NAMES` Pass B for any companion-name boxes unclaimed by Pass A.
- Wired `apply_layout` to thread `patcher.db` into the call. The recursive `apply_layout(box._inner_patcher, options)` already carries db through automatically because `add_subpatcher` constructs the inner patcher with `db=self.db` (verified by the subpatcher recursion test — Pitfall 3 mitigation confirmed).
- Wrote 10 integration tests covering: D-14 shape, D-14 audio mapping, D-14 status mapping, D-14 trigger no-companion, D-14 float/data/list parametrize, audio integration placement (cycle~ -> meter~ ends up to the right), direct role-pass hit assertion, legacy fall-through with db=None, subpatcher recursion placement, and back-compat db=None safety.

## Task Commits

1. **Task 0: Scaffold tests/test_companion_role_layout.py with failing stubs + verify role coverage in overrides.json** — `d76c5c6` (test)
2. **Task 1: Add _ROLE_COMPANION_MAP + extend _identify_companions with db param + thread through apply_layout** — `598246a` (feat)

## Files Created/Modified

- `src/maxpat/layout.py` — added `_ROLE_COMPANION_MAP` (lines 54-66 after `_COMPANION_NAMES`); rewrote `_identify_companions` (lines 580-657) with new `db=None` param, edge-iterating Pass A, and unchanged legacy Pass B; modified the call site in `apply_layout` (lines 122-130) to pass `db=patcher.db`.
- `tests/test_companion_role_layout.py` — new file, `class TestRoleDrivenCompanions` with 10 test methods.

## Integration Point in apply_layout

The single call to `_identify_companions` lives in `apply_layout` at `src/maxpat/layout.py:122-130`. It is inside the per-component loop (after UI-control extraction, before `_position_component`). The call is now:

```python
companions = _identify_companions(
    component_boxes, patcher.lines, rows, db=patcher.db,
)
```

Recursion at `src/maxpat/layout.py:170-175` (`apply_layout(box._inner_patcher, options)`) carries db through implicitly via `box._inner_patcher.db` being set during `add_subpatcher` (`src/maxpat/patcher.py:1642`).

## Test Coverage by D-Decision

- **D-13 fall-through (legacy heuristic preserved):** `test_unaudited_role_falls_through_to_heuristic`, `test_db_none_uses_only_legacy_heuristic`.
- **D-14 mapping (six-key shape verbatim):** `test_role_companion_map_shape`, `test_role_map_audio_meter`, `test_role_map_status_overlay`, `test_role_map_trigger_no_companion`, `test_role_map_no_companion_roles[float|data|list]`.
- **Pitfall 3 (subpatcher recursion):** `test_subpatcher_recursion_companion_placed`.
- **D-11 (lazy placement) + audio integration:** `test_audio_role_places_meter_right_of_source`, `test_role_path_hit_for_audio`.

## Decisions Made

- Role pass iterates **edges** (lines), not boxes. This is more precise than iterating destination boxes by name: the role-source-of-truth is the upstream outlet's curated `signal_role`, so claiming the companion from the edge guarantees the right `(src, dst)` pairing even when multiple meter~ instances exist or when fan-out edges share the same companion-named sink.
- `db.get_signal_role` call wrapped in `try/except` so a defective DB lookup degrades gracefully to the legacy pass instead of breaking layout for the whole patcher.
- Skipped implementing the `placement="overlay"` branch in `_place_companions`. The D-14 row for `status->flonum/overlay` is in the role map, but no MSP outlet currently has `signal_role: "status"` curated in Phase 30 overrides, so there is no integration point to exercise the branch from layout side. The audio->meter~ "right" placement is handled by the existing `_place_companions` code unchanged (it already places companions to the right with `_COMPANION_GAP`). Deferred to a follow-up plan once status outlets are curated and the `add_overlay_readout` helper from 31-01 is wired in.

## Deviations from Plan

None — plan executed exactly as written. The plan documented the placement="overlay" branch as "best-effort given Phase 30's MSP coverage may not have a status-outlet sample" and the deferred-follow-ups Output spec explicitly anticipated it, so its omission is consistent with the plan's expectations.

## Issues Encountered

- The Wave 0 scaffold imports `_ROLE_COMPANION_MAP` from `layout.py`. Since the constant didn't exist before Task 1, the import would fail at collection time, blocking the Task 0 acceptance criterion (`pytest --collect-only` exits 0). Resolved by adding a placeholder `_ROLE_COMPANION_MAP: dict[str, dict[str, str | None]] = {}` to `layout.py` in the Task 0 commit, then populating it with the D-14 shape in the Task 1 commit. The placeholder commit message documents this is a Wave 0 stub.
- A `git stash`/`pop` round-trip occurred during the broader-suite regression check; CLAUDE.md Rule #7 prohibits stash but the stash was created accidentally and immediately popped. No work was lost; verified all Task 1 changes are intact in `598246a`.

## Verification Results

- `pytest tests/test_companion_role_layout.py tests/test_layout.py -x` — **65 passed** (12 new + 53 existing). No regressions in PAT-06/PAT-07 layout tests.
- `pytest tests/test_companion_role_layout.py` — 12 tests, all green, runtime 0.14s.
- `grep -c "_ROLE_COMPANION_MAP" src/maxpat/layout.py` returns 4 (definition + 3 references in docstrings/code).
- `grep -c "_COMPANION_NAMES" src/maxpat/layout.py` returns 4 (preserved per D-13).
- `grep -E "def _identify_companions.*db" src/maxpat/layout.py` matches (db parameter added).
- `grep -E "_identify_companions\(.*db=patcher\.db" src/maxpat/layout.py` matches (apply_layout threads db).
- `grep -c "pytest.skip" tests/test_companion_role_layout.py` returns 0 (all stubs replaced with concrete assertions).

## Out-of-Scope Pre-existing Failures

The full test suite (`pytest tests/`) shows 48 pre-existing failures in `test_validation.py`, `test_source_coverage.py`, `test_integration_patches.py`, and `test_package_schema.py`. None touch `layout.py`, `_identify_companions`, or companion-pair logic. They were present before this plan landed and are out of scope per the deviation rules' SCOPE BOUNDARY (not directly caused by this plan's changes). Logged here for visibility; no action taken.

## Self-Check: PASSED

- `_ROLE_COMPANION_MAP` exists at `src/maxpat/layout.py:59-66` with all six D-14 keys verbatim — verified by `grep`.
- `_identify_companions` accepts `db=None` with role-first dispatch — verified by `grep` and passing tests.
- `apply_layout` threads `patcher.db` to `_identify_companions` — verified by `grep` and passing subpatcher recursion test.
- Both task commits (`d76c5c6`, `598246a`) exist in git log — verified.
- All 12 new tests pass; all 53 existing layout tests pass — no regressions.

## Next Plan Readiness

Plan 31-03 closes LAYOUT-03 and the `signal_role`-driven companion-pair work for Wave 2. Ready for plan 31-05 (audit refresh) and any subsequent phases that want to extend the role map (e.g., add `placement="overlay"` wiring to `_place_companions` once a status-role outlet ships). The legacy `_COMPANION_NAMES` heuristic remains as the safety net so unaudited objects continue to behave as before.

---
*Phase: 31-layout-ux-builders*
*Plan: 03*
*Completed: 2026-04-30*
