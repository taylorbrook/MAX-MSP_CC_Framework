---
phase: 24-community-package-support
plan: 03
subsystem: validation-and-agents
tags: [community-packages, validation, agent-prompts, extraction-gate]
dependency_graph:
  requires: [24-01]
  provides: [validation-layer-2d, community-package-guidance]
  affects: [src/maxpat/validation.py, agent-skill-files, PACKAGES.md]
tech_stack:
  added: []
  patterns: [extraction-gate-validation, dual-gate-defense-in-depth]
key_files:
  created: []
  modified:
    - src/maxpat/validation.py
    - tests/test_validation.py
    - .claude/skills/max-lifecycle/SKILL.md
    - .claude/skills/max-patch-agent/SKILL.md
    - .claude/skills/max-dsp-agent/SKILL.md
    - .claude/max-objects/PACKAGES.md
decisions:
  - IRCAM Spat gets dedicated download message (forum.ircam.fr) vs generic Package Manager path
  - Used spat5.panning~ (not spat5.panoramix~) in test since panoramix has no tilde suffix
metrics:
  duration: 241s
  completed: "2026-04-15T18:09:26Z"
  tasks_completed: 2
  tasks_total: 2
  files_modified: 6
---

# Phase 24 Plan 03: Community Package Block Gating and Agent Guidance Summary

Validation layer 2d blocks unextracted community packages with actionable install+extract instructions; agent SKILL.md files guide users through the install-extract workflow; PACKAGES.md documents all 10 community packages with data type warnings.

## Commits

| Task | Commit | Description |
|------|--------|-------------|
| 1 (RED) | 7014dec | Failing tests for community package extracted check |
| 1 (GREEN) | d37c80f | Layer 2d _validate_community_extracted() implementation |
| 2 | 53297e5 | Agent SKILL.md updates and PACKAGES.md community section |

## Task Details

### Task 1: Community Package Extracted Check (TDD)

Added `_validate_community_extracted()` to the validation pipeline as Layer 2d, wired after Layer 2c (package gating). The function:
- Iterates patch boxes, resolves each to its package via `db.get_package()`
- Checks `extracted` flag in `package_info.json` via `db.get_package_info()`
- Skips bundled tier packages (always available)
- Emits warning with full unblock path per D-07/D-08:
  - Package Manager packages: install via Help -> Package Manager, then extract
  - IRCAM Spat: specific forum.ircam.fr download URL
- Deduplicates warnings per package (one warning per package, not per object)
- 5 tests in `TestCommunityPackageBlock`: block warning, bundled no-warn, core no-warn, extracted override, IRCAM Spat specific message

### Task 2: Agent SKILL.md Files and PACKAGES.md

- **max-lifecycle SKILL.md**: Added "Community Package Extraction Gate" section with install+extract paths for Package Manager and IRCAM Spat, plus Bach ecosystem dependency note
- **max-patch-agent SKILL.md**: Added "Community Packages" section with extracted check instructions and package-specific notes (prefixes, data types, usage patterns)
- **max-dsp-agent SKILL.md**: Added "Community DSP Packages" section focused on signal processing capabilities
- **PACKAGES.md**: Added "Community Packages" section with 10-package reference table, data type warnings (Bach llll, Odot bundles, FluCoMa async), and extraction command

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] Fixed IRCAM Spat test object name**
- **Found during:** Task 1 GREEN phase
- **Issue:** Plan used `spat5.panoramix~` but the stub object is `spat5.panoramix` (no tilde) and `spat5.panning~` (with tilde)
- **Fix:** Changed test to use `spat5.panning~` which exists in stubs
- **Files modified:** tests/test_validation.py
- **Commit:** d37c80f

## Verification

- `python -m pytest tests/test_validation.py -x -q -k "community"`: 5 passed
- `python -m pytest tests/test_validation.py -x -q`: 80 passed (full validation suite)
- All acceptance criteria strings verified present in target files
- All 10 community package names present in PACKAGES.md reference table

## Self-Check: PASSED

All 7 files found on disk. All 3 commit hashes verified in git log.
