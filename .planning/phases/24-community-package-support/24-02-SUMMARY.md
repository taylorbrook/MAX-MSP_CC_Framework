---
phase: 24-community-package-support
plan: 02
subsystem: extraction-pipeline
tags: [cli, community-packages, extraction, pipeline-detection]
dependency_graph:
  requires: [24-01]
  provides: [community-package-extraction-cli]
  affects: [extract_objects.py, package_info.json]
tech_stack:
  added: []
  patterns: [importlib-script-loading, rglob-pipeline-detection]
key_files:
  created: []
  modified:
    - .claude/scripts/extract_objects.py
    - tests/test_extraction.py
decisions:
  - "Used importlib.util for test imports since .claude/scripts/ is not a Python package"
  - "Abstraction pipeline prints follow-up command rather than importing across scripts (keeps scripts decoupled)"
metrics:
  duration: "2m 22s"
  completed: "2026-04-15"
  tasks_completed: 1
  tasks_total: 1
---

# Phase 24 Plan 02: Community Package Extraction CLI Summary

**--package CLI flag with auto-detect path resolution, XML/abstraction pipeline detection, and package_info.json registry update**

## What Was Done

### Task 1: Add --package flag, path resolution, pipeline auto-detection, and registry update

Added community package extraction support to `extract_objects.py` via TDD:

1. **COMMUNITY_PACKAGE_FOLDER_NAMES** -- Maps 10 display names to filesystem folder names (e.g., `FluCoMa` -> `FluidCorpusManipulation`, `IRCAM Spat` -> `spat5`)

2. **COMMUNITY_PACKAGE_SEARCH_PATHS** -- Searches `~/Documents/Max 9/Packages`, `~/Documents/Max 8/Packages`, and `/Applications/Max.app/.../packages` in order

3. **resolve_community_package_path()** -- Resolves package name to filesystem path; supports `--path` override for custom locations

4. **detect_pipeline()** -- Auto-detects extraction pipeline: `"xml"` if `.maxref.xml` files present, `"abstraction"` if only `.maxpat`, defaults to `"xml"`

5. **update_package_registry()** -- Flips `extracted: true` and sets `object_count` in `package_info.json` after extraction

6. **CLI integration** -- `--package` and `--path` arguments; XML pipeline routes to per-package subdirectory with merge; abstraction pipeline prints `extract_abstractions.py` follow-up command

## Commits

| Commit | Type | Description |
|--------|------|-------------|
| `efa0cf8` | test | Add failing tests for community package extraction (RED) |
| `7bf850a` | feat | Implement --package flag with path resolution, pipeline detection, registry update (GREEN) |

## Verification

- `python3 .claude/scripts/extract_objects.py --help` shows `--package` and `--path` flags
- `python3 -m pytest tests/test_extraction.py -x -q -k "community"` -- 7 passed
- `COMMUNITY_PACKAGE_FOLDER_NAMES` contains all 10 community packages

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 3 - Blocking] Fixed test import path for .claude/scripts/**
- **Found during:** Task 1 (TDD RED)
- **Issue:** Plan specified `from claude.scripts.extract_objects import ...` but `.claude/scripts/` is not a Python package (no `__init__.py`, dot-prefixed directory)
- **Fix:** Used `importlib.util.spec_from_file_location()` to load the script as a module from its filesystem path; added `_load_extract_objects()` helper and class-scoped fixture
- **Files modified:** tests/test_extraction.py
- **Commit:** efa0cf8

## Self-Check: PASSED
