---
phase: 22-package-gated-generation
plan: "01"
subsystem: project-config
tags: [config, packages, project-lifecycle]
dependency_graph:
  requires: []
  provides: [load_project_config, save_project_config, get_allowed_packages, complete-package-tiers]
  affects: [patcher-gating, validation-pipeline, agent-skills]
tech_stack:
  added: []
  patterns: [config-json-read-write, project-dir-convention]
key_files:
  created: []
  modified:
    - src/maxpat/project.py
    - tests/test_project.py
    - .claude/max-objects/package_info.json
decisions:
  - "config.json not created by create_project() -- written by /max-new skill after prompting (D-08)"
  - "get_allowed_packages() returns None for unconfigured projects, empty list for core-only"
metrics:
  duration: "103s"
  completed: "2026-04-14"
  tasks_completed: 2
  tasks_total: 2
---

# Phase 22 Plan 01: Project Config Read/Write Summary

Config.json read/write layer for package selection with load/save/get_allowed_packages functions and complete package_info.json tier classification for all 20 packages.

## Tasks Completed

| # | Task | Commit | Files |
|---|------|--------|-------|
| 1 | Add config.json read/write functions to project.py and tests (TDD) | 07f701a | src/maxpat/project.py, tests/test_project.py |
| 2 | Add tier entries for maxforlive-elements and VIDDLL to package_info.json | 96157ce | .claude/max-objects/package_info.json |

## What Was Built

### Config Read/Write Functions (project.py)
- `load_project_config(project_dir)` -- returns dict from config.json or None if absent
- `save_project_config(project_dir, config)` -- writes config dict as JSON
- `get_allowed_packages(project_dir)` -- extracts package list, None means unconfigured, empty list means core-only

### Test Coverage (test_project.py)
- `TestProjectConfig` class with 8 tests covering: load None, load dict, save, overwrite, get_allowed None, get_allowed empty, get_allowed list, round-trip

### Package Registry Completion (package_info.json)
- Added `maxforlive-elements` (bundled, 3 objects, m4l. prefix)
- Added `VIDDLL` (bundled, 3 objects, viddll. prefix)
- Registry now has 20 entries matching all 20 package directories

## Verification Results

```
tests/test_project.py: 58 passed
tests/test_package_schema.py: 23 passed
Total: 81 passed, 0 failed
```

## Deviations from Plan

None -- plan executed exactly as written.

## Decisions Made

1. **config.json not created during scaffolding** -- `create_project()` unchanged per D-08; config.json written by `/max-new` skill after user selects packages
2. **None vs empty list semantics** -- `get_allowed_packages()` returns None (unconfigured) vs [] (explicitly core-only), enabling D-03 block check in `/max-build`

## Self-Check: PASSED

- All 3 modified files exist on disk
- Both commit hashes (07f701a, 96157ce) found in git log
- All 3 functions exported from project.py
- TestProjectConfig class present in test file
- package_info.json has 20 entries
