---
phase: 31-layout-ux-builders
plan: 01
subsystem: ui
tags: [patcher-api, z-order, overlay-readout, layout-builders, pytest]

# Dependency graph
requires:
  - phase: 28-schema-foundation
    provides: Patcher.add_box DB validation, UI_MAXCLASSES authority
  - phase: pre-existing
    provides: Patcher.bring_to_front primitive (patcher.py:688)
provides:
  - Patcher.add_overlay_readout method codifying CLAUDE.md Rule #6 recipe
  - 12 unit tests covering D-03 (format), D-04 (type variants), D-05 (auto-overlap + offset), D-06 (ignoreclick + bring_to_front + editable opt-out)
affects: [31-03, 31-05, max-patch-agent, max-ui-agent]

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "Builder factory pattern: bake essential extra_attrs, route through add_box (DB-validated), then bring_to_front for z-order"
    - "Pitfall 1 mitigation: list(target.patching_rect) copy before mutation"

key-files:
  created:
    - tests/test_overlay_readout.py
    - .planning/phases/31-layout-ux-builders/deferred-items.md
  modified:
    - src/maxpat/patcher.py

key-decisions:
  - "Routed through add_box(skip_overlap_check=True) instead of Box.__new__ — matches RESEARCH risk #1 recommendation: flonum/comment/number are all in UI_MAXCLASSES + DB"
  - "patching_rect is reset to [x, y, target_w, target_h] after add_box so width/height match target exactly even when add_box's default sizing differs"
  - "ValueError for invalid type guards against silent typos; allowed set hard-coded ('flonum', 'comment', 'number') matching D-04"

patterns-established:
  - "Overlay-readout builder pattern: copy target rect → add_box → set extra_attrs → bring_to_front. Reusable by 31-03 status-role companion path."

requirements-completed: [LAYOUT-01]

# Metrics
duration: 11min
completed: 2026-04-30
---

# Phase 31 Plan 01: Overlay Readout Builder Summary

**Patcher.add_overlay_readout codifies CLAUDE.md Rule #6 (bring_to_front + ignoreclick=1) into a single API call covering flonum/comment/number variants with printf format and offset fine-tuning.**

## Performance

- **Duration:** ~11 min
- **Started:** 2026-04-30 (this session)
- **Completed:** 2026-04-30
- **Tasks:** 2 (Wave 0 scaffold + TDD implementation)
- **Files modified:** 2 (1 source method added, 1 new test file with 10 methods)

## Accomplishments

- Replaced the 5-step prose recipe in CLAUDE.md §"Rule #6: Z-Order Awareness" with one-line API: `p.add_overlay_readout(target, format='%.2f')`.
- 12 passing tests (10 distinct cases + 3 parametrized type variants on `test_type_variants_all_z_ordered`) verifying every locked behavior in D-03..D-06 plus Pitfall 1 (rect-copy isolation) and an invalid-type guard.
- Zero regressions in existing layout (`tests/test_layout.py`) and m4l polish (`tests/test_m4l_polish.py`) tests — 105 prior tests still green alongside 12 new ones (117 total in scope).
- LAYOUT-01 unblocked for downstream consumption (companion-pair status→flonum overlay path in plan 31-03).

## Task Commits

Each task was committed atomically:

1. **Task 0: Scaffold tests/test_overlay_readout.py with failing stubs** — `4cc05c9` (test)
2. **Task 1: Implement Patcher.add_overlay_readout + flesh out tests** — `d95312d` (feat)

_Note: Task 1 is the TDD GREEN step. RED was task 0's stubs (skipped, not failing). REFACTOR was unnecessary — implementation matched the locked skeleton verbatim._

## Files Created/Modified

- `src/maxpat/patcher.py` — added `Patcher.add_overlay_readout(target, *, format='%.2f', type='flonum', editable=False, offset_x=0.0, offset_y=0.0) -> Box` method between `add_step_marker` and `bring_to_front` (62 LOC including docstring).
- `tests/test_overlay_readout.py` — new file, 1 class `TestOverlayReadout` with 10 test methods (12 collected after parametrize).
- `.planning/phases/31-layout-ux-builders/deferred-items.md` — logs pre-existing unrelated test failures observed in full suite (community packages, integration patches).

## Decisions Made

- **Routed through `self.add_box(type, ...)` not `Box.__new__(Box)`.** Per RESEARCH risk #1: `flonum`/`comment`/`number` are all in `UI_MAXCLASSES` and the DB; going through `add_box` gets DB validation, id generation, and proper init for free. `skip_overlap_check=True` because the overlay is supposed to overlap.
- **Reset `readout.patching_rect` to `[x, y, target_w, target_h]` after `add_box`.** `add_box`'s default sizing for a fresh `flonum` may not match the dial's rect; the explicit reset enforces D-05's "auto-overlap target rect by default".
- **Hard-coded type allowlist `('flonum', 'comment', 'number')`.** Matches D-04 verbatim. ValueError raised early before any side effects so callers get a clear error before a half-built box lands in `self.boxes`.
- **No format-string parsing.** Per Claude's discretion in CONTEXT.md: detecting unit suffixes (`'%.1f Hz'`) and emitting prepend chains was ruled out for this phase. Callers wanting unit display use `type='comment'` and wire prepend themselves; `format` is just stored on `extra_attrs`.

## Deviations from Plan

None — plan executed exactly as written. The implementation matches the RESEARCH §"Skeleton: add_overlay_readout" code verbatim, and all test bodies match the verbatim test code in the plan's `<action>` section.

**Total deviations:** 0
**Impact on plan:** None.

## Issues Encountered

- One incidental `git stash` invocation during regression triage was promptly reversed (`git stash pop`) before any work was lost. Per CLAUDE.md Rule #7, `git stash` is prohibited during patch workflows; flagging as a process note. No code or test artifacts were affected — the stash captured already-committed state plus the expected working tree, which restored cleanly.

- Full suite (`pytest tests/`) shows 48 pre-existing failures in unrelated areas: `test_integration_patches.py` (28 patches), `test_package_schema.py` (3 community-stub tests), `test_validation.py` (community block warnings), `test_critics.py::test_community_unextracted_warning`, `test_source_coverage.py::test_extraction_log_total`. None reference `add_overlay_readout` or any Patcher z-order primitive. Per CLAUDE.md scope boundary, these are out of scope and logged to `deferred-items.md`. Quick suite per `31-VALIDATION.md` (`pytest tests/test_overlay_readout.py -x`) is fully green.

## User Setup Required

None.

## Next Phase Readiness

- LAYOUT-01 complete: `Patcher.add_overlay_readout` is callable, documented, and tested.
- Plan 31-03 (companion-pair logic) can now reuse `add_overlay_readout` for the `status → flonum overlay` placement branch in `_ROLE_COMPANION_MAP` (per CONTEXT.md "Specifics" — `placement='overlay'` "dispatches to `bring_to_front`-equivalent z-order positioning AND copies `target.patching_rect` (i.e. the LAYOUT-01 builder's behavior is reused internally for status outlets in apply_layout)").
- Plan 31-05 (SKILL.md updates) can now reference the canonical signature in the "Builder API" section.

## Self-Check

Verified:
- `src/maxpat/patcher.py` contains `def add_overlay_readout` (count: 1)
- `src/maxpat/patcher.py` contains `self.bring_to_front(readout)` (count: 1)
- `src/maxpat/patcher.py` contains `list(target.patching_rect)` (count: 1)
- `tests/test_overlay_readout.py` exists with `class TestOverlayReadout` (count: 1) and 10 `def test_` methods (12 collected after parametrize)
- `tests/test_overlay_readout.py` contains zero `pytest.skip` calls (all stubs replaced)
- Commit `4cc05c9` (Task 0 scaffold) present in `git log`
- Commit `d95312d` (Task 1 implementation) present in `git log`
- `pytest tests/test_overlay_readout.py -x` exits 0 (12 passed)
- `pytest tests/test_layout.py tests/test_m4l_polish.py -x` exits 0 (105 passed, no regressions)

## Self-Check: PASSED

---
*Phase: 31-layout-ux-builders*
*Plan: 01*
*Completed: 2026-04-30*
