---
phase: quick-260331-eqh
plan: 01
subsystem: patcher-api
tags: [z-order, overlay, api, documentation]
dependency_graph:
  requires: []
  provides: [bring_to_front, send_to_back, set_z_index, z-order-docs]
  affects: [patcher.py, CLAUDE.md, shared-capabilities.md]
tech_stack:
  added: []
  patterns: [z-order-manipulation, overlay-readout-pattern]
key_files:
  created: []
  modified:
    - src/maxpat/patcher.py
    - tests/test_aesthetics.py
    - CLAUDE.md
    - .claude/skills/references/shared-capabilities.md
decisions:
  - "Z-order methods placed after add_step_marker, before add_message in Patcher class"
  - "ValueError raised for missing box (consistent with list.remove behavior)"
  - "set_z_index clamps out-of-range indices rather than raising"
metrics:
  duration: 3min
  completed: "2026-03-31T17:45:18Z"
---

# Quick Task 260331-eqh: Z-Order API and Documentation Summary

Z-order manipulation API (bring_to_front, send_to_back, set_z_index) on Patcher with CLAUDE.md Rule #6 and agent skill docs for overlay readout pattern.

## Tasks Completed

### Task 1: Add z-order manipulation methods to Patcher and tests (TDD)

**Commits:** 76d1d59 (RED), 0aa8ba6 (GREEN)

Added three methods to Patcher class:
- `bring_to_front(box)` -- moves box to end of boxes array (renders on top)
- `send_to_back(box)` -- moves box to index 0 (renders behind everything)
- `set_z_index(box, index)` -- explicit position with clamping for out-of-range

10 unit tests in `TestZOrder` class covering: normal operation, ValueError on missing box, index clamping, middle insertion, object identity preservation.

### Task 2: Document z-order in CLAUDE.md and shared agent capabilities

**Commit:** adaa5ef

- CLAUDE.md: Added Rule #6 (Z-Order Awareness) documenting array-order rendering semantics and the overlay readout pattern with ignoreclick=1
- shared-capabilities.md: Added Z-Order Manipulation section with API reference and overlay readout recipe

## Deviations from Plan

None -- plan executed exactly as written.

## Known Stubs

None.

## Verification Results

- 59/59 aesthetics tests pass (49 existing + 10 new)
- All three methods present in patcher.py
- Rule #6 present in CLAUDE.md
- Z-Order Manipulation section present in shared-capabilities.md

## Self-Check: PASSED
