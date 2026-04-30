---
phase: 31-layout-ux-builders
plan: 02
subsystem: ui
tags: [patcher-api, multislider, labeled-param-bank, layout-builders, pytest]

# Dependency graph
requires:
  - phase: 28-schema-foundation
    provides: ObjectDatabase + UI_MAXCLASSES authority for multislider/comment lookups
  - phase: 31-01-overlay-readout
    provides: builder-method placement convention (between add_step_marker and bring_to_front)
provides:
  - Patcher.add_labeled_param_bank method codifying CLAUDE.md "Multislider as Labeled Parameter Bank" recipe
  - 16 unit tests covering D-07 (params tuple shape), D-08 (label_side='left' only, y formula), D-09 (return shape, no prepend chain), D-10 (baked attrs + extra_attrs deep-merge)
affects: [31-03, 31-04, 31-05, max-patch-agent, max-ui-agent]

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "Builder factory: deep-merge baked defaults with caller's extra_attrs (caller wins on collision per D-10)"
    - "Pixel-aligned label-bar formula: ms.height = size*24, label.y = ms.y + i*24, fontsize=10 (CLAUDE.md spec)"

key-files:
  created:
    - tests/test_labeled_param_bank.py
  modified:
    - src/maxpat/patcher.py

key-decisions:
  - "Routed through self.add_box('multislider', skip_overlap_check=True) — multislider is in UI_MAXCLASSES (maxclass_map.py:20) and DB lookup verified non-empty I/O (1 inlet, 2 outlets)"
  - "ms_width = 200.0 default (CLAUDE.md doesn't lock multislider width); locked attrs are size, height, orientation, contdata, setstyle, setminmax — width left as a sensible default"
  - "Deep-merge order: baked.update(extra_attrs) before ms.extra_attrs.update(baked) — caller wins on collision per D-10 locked semantic"
  - "Comment label width estimated as len(name) * 6 + 14 (heuristic) so labels sit left of multislider with 8px gap; tests assert label.x < ms.x rather than exact pixel values"

patterns-established:
  - "Labeled-param-bank builder pattern: bake CLAUDE.md recipe attrs, deep-merge caller overrides, place comment labels at ms.y + i*24 with fontsize=10. Reusable as a reference for any future bar+label layout builder."

requirements-completed: [LAYOUT-02]

# Metrics
duration: 8min
completed: 2026-04-30
---

# Phase 31 Plan 02: Labeled Parameter Bank Builder Summary

**Patcher.add_labeled_param_bank codifies CLAUDE.md "Multislider as Labeled Parameter Bank" (size*24 height, contdata=1, setstyle=1, orientation=0, setminmax envelope) plus pixel-aligned per-bar comment labels into a single API call.**

## Performance

- **Duration:** ~8 min
- **Started:** 2026-04-30 (this session)
- **Completed:** 2026-04-30
- **Tasks:** 2 (Wave 0 scaffold + TDD implementation)
- **Files modified:** 2 (1 source method added, 1 new test file with 16 methods)

## Accomplishments

- Replaced the multi-bullet prose recipe in CLAUDE.md §"Multislider as Labeled Parameter Bank" with one-line API: `p.add_labeled_param_bank(params, x, y)`.
- 16 passing tests verifying every locked behavior in D-07..D-10 plus three guard rails (empty params, label_side='right', label_side='above').
- Zero regressions in scoped test set (`tests/test_overlay_readout.py`, `tests/test_layout.py`, `tests/test_m4l_polish.py`) — 117 prior tests still green alongside 16 new ones.
- LAYOUT-02 unblocked for downstream consumption (31-03 companion-pair logic, 31-05 SKILL.md "Builder API" section).

## Task Commits

Each task was committed atomically:

1. **Task 0: Scaffold tests/test_labeled_param_bank.py with failing stubs** — `c09c69c` (test)
2. **Task 1: Implement Patcher.add_labeled_param_bank + flesh out tests** — `26dbf71` (feat)

_Note: Task 1 is the TDD GREEN step. RED was task 0's stubs (skipped with Wave 0 message, not failing). REFACTOR was unnecessary — implementation matched the locked skeleton verbatim._

## Files Created/Modified

- `src/maxpat/patcher.py` — added `Patcher.add_labeled_param_bank(params, x, y, *, label_side='left', extra_attrs=None) -> tuple[Box, list[Box]]` method between `add_overlay_readout` and `bring_to_front` (~95 LOC including docstring).
- `tests/test_labeled_param_bank.py` — new file, 1 class `TestLabeledParamBank` with 16 test methods.

## Decisions Made

- **Routed through `self.add_box('multislider', skip_overlap_check=True)`.** `multislider` is in UI_MAXCLASSES (maxclass_map.py:20) and DB lookup confirmed non-empty I/O (1 inlet, 2 outlets) per the Wave 0 precondition. `add_box` handles DB validation, id generation, and proper Box init for free.
- **`ms_width = 200.0` left as a sensible default.** CLAUDE.md doesn't lock multislider width; D-10 locks only `size`, `height`, `orientation`, `contdata`, `setstyle`, `setminmax`. Width is a layout concern callers can override via the `extra_attrs` deep-merge or by reaching into `ms.patching_rect` after the call.
- **Deep-merge order: `baked.update(extra_attrs)` BEFORE `ms.extra_attrs.update(baked)`.** Locked semantic from D-10 — caller wins on collisions. Test `test_extra_attrs_deep_merge_caller_wins` covers all three sub-cases (caller override of `contdata`, caller-only `bgcolor`, baked-only `size/orientation/setstyle` preserved).
- **Comment label x-coordinate estimated heuristically (`len(name) * 6 + 14`).** CLAUDE.md fontsize=10 spacing isn't pixel-locked for label width; the test asserts `label.x < ms.x` rather than an exact value, so the heuristic stays simple and the test is robust to future tuning.
- **D-09 explicitly excludes prepend/route chain.** Builder returns `(multislider, list[comment])` only — caller wires `fetch $1` -> multislider input themselves and reads from RIGHT outlet (outlet 1) per memory `feedback_multislider_fetch.md`. The docstring surfaces this so callers don't accidentally wire outlet 0 or insert `split` between multislider and consumer.
- **`subpatcher_name=` kwarg deferred (out of scope per D-09).** Listed in CONTEXT.md "Deferred Ideas"; no plumbing added this phase.
- **`label_side='right'` and `'above'` raise ValueError mentioning 'left'** per D-08 — explicit guard rail prevents silent wrong-placement bugs and makes the "only 'left' shipped this phase" decision discoverable at runtime.

## Deviations from Plan

None — plan executed exactly as written. The implementation matches the RESEARCH §"Skeleton: add_labeled_param_bank" code verbatim with one micro-detail: the `_unused` tuple element names in the loop are spelled `_mn, _mx` (matches the plan's `<action>` block) rather than `_, _` from the RESEARCH skeleton. All test bodies match the verbatim test code in the plan's `<action>` section.

**Total deviations:** 0
**Impact on plan:** None.

## Issues Encountered

- Full suite (`pytest tests/`) shows 2 pre-existing failures in `tests/test_validation.py::TestCommunityPackageBlock` (community package warnings). These are pre-existing and already documented in `deferred-items.md` from plan 31-01. Per CLAUDE.md scope boundary, these are out of scope for plan 31-02 — no `add_labeled_param_bank` reference, no shared code path. The scoped suite per plan acceptance criteria (`pytest tests/test_labeled_param_bank.py tests/test_layout.py tests/test_m4l_polish.py tests/test_overlay_readout.py -x`) is fully green: 133 passed.

- Wave 0 multislider DB I/O precondition verified before scaffolding: `db.lookup('multislider')` returns 1 inlet and 2 outlets (non-empty per CLAUDE.md verification rule). No `overrides.json` patch needed.

## User Setup Required

None.

## Next Phase Readiness

- LAYOUT-02 complete: `Patcher.add_labeled_param_bank` is callable, documented, and tested.
- Plan 31-05 (SKILL.md updates) can now reference the canonical signature and the "fetch from outlet 1" caller wiring contract in the "Builder API" section for both `max-patch-agent` and `max-ui-agent`.
- Plan 31-04 (m4l_gen_synth) can reuse the deep-merge `extra_attrs` pattern for any baked-attrs builders that follow.

## Self-Check

Verified:
- `src/maxpat/patcher.py` contains `def add_labeled_param_bank` (count: 1)
- `src/maxpat/patcher.py` contains the `size = len(params)` and `height = size * 24.0` formula (D-10)
- `src/maxpat/patcher.py` contains `contdata`, `setstyle`, `orientation` baked-attr keys
- `tests/test_labeled_param_bank.py` exists with `class TestLabeledParamBank` (count: 1) and 16 `def test_` methods
- `tests/test_labeled_param_bank.py` contains zero `pytest.skip` calls (all stubs replaced)
- Commit `c09c69c` (Task 0 scaffold) present in `git log`
- Commit `26dbf71` (Task 1 implementation) present in `git log`
- `pytest tests/test_labeled_param_bank.py -x` exits 0 (16 passed)
- `pytest tests/test_layout.py tests/test_m4l_polish.py tests/test_overlay_readout.py -x` exits 0 (117 passed, no regressions)

## Self-Check: PASSED

---
*Phase: 31-layout-ux-builders*
*Plan: 02*
*Completed: 2026-04-30*
