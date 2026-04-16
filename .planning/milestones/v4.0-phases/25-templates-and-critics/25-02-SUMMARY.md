---
phase: 25-templates-and-critics
plan: "02"
subsystem: critics
tags: [package-critic, wiring, integration, beap, bach, community]
dependency_graph:
  requires: ["25-01"]
  provides: ["review_patch() with package critic auto-invocation"]
  affects: ["src/maxpat/critics/__init__.py", ".claude/skills/max-critic/SKILL.md"]
tech_stack:
  added: []
  patterns: ["conditional critic dispatch based on detected objects"]
key_files:
  created: []
  modified:
    - src/maxpat/critics/__init__.py
    - tests/test_critics.py
    - .claude/skills/max-critic/SKILL.md
decisions:
  - "Package critic placed after external critic in review_patch() dispatch order"
  - "_has_package_boxes uses ObjectDatabase internally (lazy import to avoid circular)"
metrics:
  duration: "2m 23s"
  completed: "2026-04-15T23:52:37Z"
  tasks_completed: 2
  tasks_total: 2
  files_modified: 3
---

# Phase 25 Plan 02: Package Critic Wiring Summary

Wire review_packages() into review_patch() with conditional dispatch based on detected package objects, plus critic SKILL.md documentation update.

## Tasks Completed

| Task | Name | Commit | Key Changes |
|------|------|--------|-------------|
| 1 | Wire review_packages() into review_patch() | ae6dc7e | Added import, _has_package_boxes(), conditional invocation, __all__ export, 2 integration tests |
| 2 | Update critic SKILL.md | 6da9d61 | Package critic capability, severity table, loop protocol update |

## Implementation Details

### Task 1: review_patch() Wiring

- Added `from src.maxpat.critics.package_critic import review_packages` import
- Added `_has_package_boxes()` detection function that scans patch boxes using ObjectDatabase.get_package() -- handles both bpatcher (name attr) and newobj (text field) patterns
- Conditional invocation after external critic block: only runs when package objects are detected
- Added `review_packages` to `__all__` exports
- Two integration tests verify the wiring:
  - `test_review_patch_includes_package_critic`: BEAP patch with missing VCA triggers package critic via review_patch()
  - `test_review_patch_no_packages_skips_critic`: Pure MSP patch (cycle~ -> *~ -> dac~) produces zero package findings

### Task 2: SKILL.md Documentation

- Added package critic to Capabilities section alongside RNBO and external critics
- Added Package Critic Severities table with 4 checks: BEAP output termination (warning), BEAP VCA staging (warning), Bach llll mismatch (blocker), community extraction (warning)
- Updated Critic Loop Protocol summary to note conditional package critic inclusion

## Deviations from Plan

None -- plan executed exactly as written.

## Verification Results

- 69/69 critic tests pass (including 2 new integration tests)
- Pre-existing failure in test_inlet_types.py (MSP objects missing signal I/O) is unrelated to this plan

## Self-Check: PASSED
