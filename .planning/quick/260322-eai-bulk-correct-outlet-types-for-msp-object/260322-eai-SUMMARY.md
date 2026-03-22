---
phase: quick-260322-eai
plan: 01
subsystem: object-database
tags: [msp, outlet-types, overrides, data-correction]
dependency_graph:
  requires: []
  provides: [gain~-outlet-correction, index~-outlet-correction]
  affects: [validation, connection-checking, dsp-critics]
tech_stack:
  added: []
  patterns: [tdd-red-green, override-deep-merge]
key_files:
  created: []
  modified:
    - .claude/max-objects/overrides.json
    - tests/test_object_schema.py
decisions:
  - "gain~ outlet 1 is control (slider value int), not signal -- confirmed via official Cycling '74 docs"
  - "index~ has 1 outlet, not 2 -- outlet 1 was extraction error (inlet 1 digest duplicated)"
metrics:
  duration: 3min
  completed: "2026-03-22T17:31:17Z"
---

# Quick Task 260322-eai: Bulk-Correct MSP Outlet Types Summary

Corrected outlet metadata for gain~ (outlet 1 is control, not signal) and index~ (1 outlet, not 2) in overrides.json, with TDD verification.

## What Was Done

### Task 1: Add gain~ and index~ overrides with TDD tests

**TDD RED (441cb0f):** Added `TestMspOutletOverrides` class to `tests/test_object_schema.py` with 4 tests:
- `test_gain_tilde_outlet_1_is_control` -- asserts outlet 1 signal=false
- `test_index_tilde_has_single_outlet` -- asserts exactly 1 outlet
- `test_gain_tilde_is_overridden` -- asserts is_overridden returns True
- `test_index_tilde_is_overridden` -- asserts is_overridden returns True

All 4 tests failed as expected (gain~ outlet 1 was signal=true, index~ had 2 outlets).

**TDD GREEN (c2c88f1):** Added override entries to `.claude/max-objects/overrides.json` in the MSP section, alphabetically between existing entries:
- **gain~:** 2 outlets -- outlet 0 signal, outlet 1 control (slider value int)
- **index~:** 1 outlet -- outlet 0 signal (removed erroneous outlet 1 from extraction)

All 4 tests pass.

### Task 2: Regression verification

Full test suite: 1201 passed, 0 failed from this change. Two pre-existing failures excluded (layout inlet alignment, minitaur round-trip em-dash encoding).

## Deviations from Plan

None -- plan executed exactly as written.

## Pre-existing Test Failures (out of scope)

- `tests/test_layout.py::TestInletAlignment::test_child_inlet_aligns_under_parent_outlet` -- inlet alignment off by 21px (threshold 15px)
- `tests/test_round_trip.py::TestSubpatcherByteIdentity::test_byte_identical_round_trip[minitaur/generated/minitaur.maxpat]` -- em-dash encoding difference

## Known Stubs

None.

## Self-Check: PASSED
