---
phase: 27-scaffold-auto-enforcement
plan: 01
subsystem: m4l-polish
tags: [m4l, scaffold, parameter-enable, prefix-enforcement, tdd]
dependency_graph:
  requires: []
  provides: [ensure_parameter_enable, ensure_m4l_prefixes]
  affects: [polish_m4l_device]
tech_stack:
  added: []
  patterns: [gap-fill-only enforcement, recursive box scan, idempotent mutation]
key_files:
  created: []
  modified:
    - src/maxpat/m4l_polish.py
    - tests/test_m4l_polish.py
decisions:
  - "ensure_parameter_enable runs before derive_parameter_names so valueof dict exists for naming pass"
  - "ensure_m4l_prefixes uses _prefix_boxes recursive helper separate from _collect_live_controls"
  - "ParamType.FLOAT (1) and UnitStyle.FLOAT (1) used as defaults for parameter_type and parameter_unitstyle"
metrics:
  duration: 3min
  completed: "2026-04-08T17:37:09Z"
  tasks: 2
  files: 2
requirements: [SCAFFOLD-04, SCAFFOLD-05]
---

# Phase 27 Plan 01: Scaffold Auto-Enforcement Summary

TDD enforcement passes for M4L parameter_enable and --- prefix via gap-fill-only mutation in polish_m4l_device

## What Was Done

### Task 1: TDD RED -- Failing tests (cb889d9)

Appended 3 new test classes (16 tests total) to `tests/test_m4l_polish.py`:

- **TestParameterEnableEnforcement** (7 tests): sets parameter_enable=1, creates saa defaults, preserves existing values, skips non-parameter live objects, idempotent, recurses into subpatchers
- **TestM4LPrefixEnforcement** (8 tests): adds --- prefix, all 8 named object types, skips already-prefixed, skips #N substitution, skips unnamed, preserves extra args, idempotent, recurses
- **TestEnforcementIntegration** (1 test): end-to-end via polish_m4l_device verifying both SCAFFOLD-04 and SCAFFOLD-05 run before POLISH-01 naming

All 36 existing tests continued passing; 16 new tests failed with ImportError (RED phase verified).

### Task 2: TDD GREEN -- Implementation (043f8fb)

Added to `src/maxpat/m4l_polish.py`:

- **`ensure_parameter_enable()`**: Collects live.* controls via `_collect_live_controls`, sets `parameter_enable=1` if missing/falsy, creates `saved_attribute_attributes.valueof` with `parameter_type=1` (FLOAT) and `parameter_unitstyle=1` (FLOAT) as defaults. Uses `setdefault` for gap-fill-only semantics.
- **`_NAMED_OBJECTS`** frozenset: `buffer~`, `coll`, `dict`, `send`, `receive`, `send~`, `receive~`, `value`
- **`ensure_m4l_prefixes()`**: Entry point that delegates to `_prefix_boxes` recursive helper
- **`_prefix_boxes()`**: Recursively scans boxes, splits text into tokens, prepends `---` to name argument if object type is in `_NAMED_OBJECTS` and name doesn't start with `---` or `#`
- **`polish_m4l_device()`** updated: now calls 5 passes in order (ensure_parameter_enable, ensure_m4l_prefixes, derive_parameter_names, organize_push_banks, populate_info_text)
- **Import**: Added `ParamType` to existing `m4l_constants` import

All 52 tests pass (36 existing + 16 new). Full suite has zero regressions from this plan.

## Deviations from Plan

None -- plan executed exactly as written.

## Commits

| Task | Commit | Type | Description |
|------|--------|------|-------------|
| 1 | cb889d9 | test | Add failing tests for ensure_parameter_enable and ensure_m4l_prefixes |
| 2 | 043f8fb | feat | Implement ensure_parameter_enable and ensure_m4l_prefixes |

## Self-Check: PASSED
