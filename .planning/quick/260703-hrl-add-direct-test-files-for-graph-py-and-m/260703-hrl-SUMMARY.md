---
phase: quick-260703-hrl
plan: 01
subsystem: testing
tags: [tests, graph, maxclass, smoke-coverage]
requires: []
provides:
  - Direct test coverage for graph.py, maxclass_map.py, defaults.py, utils.py, rnbo_validation.py, ext_validation.py, ext_templates.py, m4l_constants.py
affects: []
tech-stack:
  added: []
  patterns:
    - Class-grouped pytest files matching test_patcher.py conventions
key-files:
  created:
    - tests/test_graph.py
    - tests/test_maxclass_map.py
    - tests/test_defaults.py
    - tests/test_utils.py
    - tests/test_rnbo_validation.py
    - tests/test_ext_validation.py
    - tests/test_ext_templates.py
    - tests/test_m4l_constants.py
  modified: []
decisions:
  - "Pinned actual render_cmake_template behavior (project name from directory, not from the name arg) instead of the plan's assumed behavior — zero production changes"
  - "Used fabricated unknown object name for RNBO incompatibility test to avoid DB-content coupling"
metrics:
  duration: ~4 minutes
  completed: 2026-07-03
  tasks: 2
  tests-added: 68
status: complete
---

# Quick Task 260703-hrl: Direct Test Files for 8 Untested maxpat Modules Summary

Direct pytest coverage for graph.py (traversal semantics) and maxclass_map.py (UI-class resolution), plus smoke tests for the 6 remaining untested src/maxpat modules — 68 new tests, suite at 2098 passed / 4 xfailed.

## What Was Built

### Task 1 — Substantive coverage (commit 3f65222)

**tests/test_graph.py** (18 tests) — exercises GraphMixin through Patcher instances, deliberately avoiding duplication of the transitive ED-04 scenarios in test_patcher.py:
- `downstream`: linear chain ordering; fan-out sorted by outlet index even when wired out of order (trigger b i f, outlets connected 2→0→1)
- `upstream`: reverse chain ordering [B, A]; starting box excluded
- `signal_only`: both-endpoints-must-be-~ rule (control `number` branch skipped downstream and upstream; non-~→~ connection not followed)
- `signal_path`: mid-chain ~ box returns reversed-upstream + [box] + downstream; non-~ box excluded from its own path
- Subpatcher crossing: uses `inner.get_inlets()`/`get_outlets()` (never box.text search); inner inlets and inner chain boxes appear in downstream results
- `connected_components`: empty patcher → []; two disjoint chains + isolated box → 3 components sorted largest-first, isolated box as single-element group
- `_build_adj`: stale Patchlines referencing unknown box ids excluded from forward/reverse adjacency and from traversal

**tests/test_maxclass_map.py** (10 tests):
- `resolve_maxclass` both branches (12 UI widgets → own name; 7 non-UI objects → "newobj")
- `is_ui_object` mirrors set membership
- `UI_MAXCLASSES` invariants: frozenset, "newobj" not a member, entries clean lowercase non-empty strings
- Patcher consistency: `add_box("toggle")` serializes with maxclass "toggle" and no text field; `add_box("cycle~")` serializes as newobj with name in text — pins the CLAUDE.md rule that UI_MAXCLASSES is authoritative over the DB maxclass field

### Task 2 — Smoke coverage (commit 819ccc8)

- **tests/test_utils.py** (5): `get_box_name` all four branches
- **tests/test_defaults.py** (7): sizing constants positive; V_SPACING==20 / H_GUTTER==15 (pins CLAUDE.md Rule #4); LayoutOptions defaults; DEFAULT_PATCHER_PROPS keys + MAX 9 appversion; AESTHETIC_PALETTE 4-float RGBA in [0,1]; FONTFACE_*/BUBBLE_* values 0-3
- **tests/test_m4l_constants.py** (7): four IntEnums with representative members; `struct.calcsize(AMXD_HEADER_FORMAT) == AMXD_HEADER_SIZE == 32`; AMXD_MAGIC == b"ampf"; three distinct 4-byte type markers
- **tests/test_ext_templates.py** (8): message/dsp/scheduler renderers contain name + "public object<"; dsp embeds `sample_operator<N, M>`; cmake and test scaffolds well-formed (substring pins, not full-text equality)
- **tests/test_ext_validation.py** (6): `validate_mxo` early-return branches only (nonexistent path, wrong suffix, missing binary — no subprocess reached, per threat model T-quick-hrl-01); `parse_compiler_errors` structured extraction + empty case; BuildResult instantiation
- **tests/test_rnbo_validation.py** (6): compatible patch → no rnbo-objects errors; unknown object flagged; unknown target flagged; @file reference flagged as rnbo-contained error; RNBO_TARGET_CONSTRAINTS == {plugin, web, cpp}; cpp buffer/param constraints

## Verification

- All 8 new files pass: 68 tests
- Full suite: **2098 passed, 4 xfailed** (baseline 2030 + 68 new, zero regressions, xfails unchanged)
- `git diff --stat` on src/: no production files modified (only pre-existing unrelated `patches/.active-project.json` working-tree change, left unstaged)

## Deviations from Plan

### Adjusted assertions to pin actual behavior

**1. [Behavior-spec correction] render_cmake_template does not contain the name argument**
- **Found during:** Task 2
- **Issue:** Plan behavior spec said cmake template output should "contain the name", but the template derives the project name at CMake time via `get_filename_component(PROJECT_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME)` and never interpolates the `name` argument
- **Fix:** Test pins actual behavior (min-api scaffold structure) with an explanatory comment; no production change
- **Files modified:** tests/test_ext_templates.py
- **Commit:** 819ccc8

No production bugs were surfaced; no production code was modified.

## Known Stubs

None.

## Threat Flags

None — test-only change; ext_validation tests deliberately stop before any subprocess branch.

## Commits

| Task | Commit | Description |
|------|--------|-------------|
| 1 | 3f65222 | test_graph.py + test_maxclass_map.py (28 tests) |
| 2 | 819ccc8 | Six smoke test files (40 tests) |

## Self-Check: PASSED

- All 8 test files exist on disk
- Commits 3f65222 and 819ccc8 present in git log
- Full suite green at 2098 passed / 4 xfailed
