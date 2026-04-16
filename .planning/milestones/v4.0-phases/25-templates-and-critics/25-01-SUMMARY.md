---
phase: 25-templates-and-critics
plan: 01
subsystem: critics
tags: [package-critic, beap, bach, community, tdd]
dependency_graph:
  requires: []
  provides: [review_packages, package_critic_module]
  affects: [critics/__init__.py]
tech_stack:
  added: []
  patterns: [BFS-graph-traversal, prefix-matching-fallback, conditional-dispatch]
key_files:
  created:
    - src/maxpat/critics/package_critic.py
  modified:
    - tests/test_critics.py
decisions:
  - "Used _get_object_name() bpatcher-aware resolver instead of extending get_box_name() -- keeps utils.py generic"
  - "Added _match_package_by_prefix() fallback for unextracted community packages whose objects aren't in DB"
  - "BFS treats all bpatcher connections as signal (BEAP modules are signal processors, outlettype may be absent)"
metrics:
  duration: 6m
  completed: "2026-04-15"
  tasks: 2
  files_created: 1
  files_modified: 1
  tests_added: 11
  tests_total: 67
---

# Phase 25 Plan 01: Package Critic Summary

Package critic module with BEAP convention checks, Bach llll type mismatch detection, and community extraction warnings -- catches package-specific semantic errors the generic validation pipeline misses.

## What Was Built

`src/maxpat/critics/package_critic.py` with `review_packages()` entry point that conditionally dispatches to three sub-checks based on detected package objects:

1. **BEAP convention checks** (severity: warning)
   - `_check_beap_output_termination`: BFS from source objects (Oscillator/Input/Random/LFO) to output modules (bp.Stereo, bp.Mono, etc.). Warns if no path reaches an output.
   - `_check_beap_vca_staging`: BFS from oscillators to outputs tracking gain stages. Warns if oscillator reaches output without passing through a Level category module (bp.VCA).

2. **Bach llll type checker** (severity: blocker)
   - `_check_bach_llll_types`: Iterates patchlines, checks if non-bach objects connect to bach inlets with "llll" in their digest. Skips bach.list2llll (converter), allows bach-to-bach connections.

3. **Community extraction checker** (severity: warning)
   - `_check_community_extracted`: Detects community/licensed packages with `extracted=false` in package_info.json. Uses `_match_package_by_prefix()` fallback for objects not in DB (typical for unextracted packages).

Key helper: `_get_object_name(box)` resolves bpatcher boxes via `name` attribute and standard boxes via `get_box_name()`.

## Commits

| Task | Commit | Description |
|------|--------|-------------|
| T1 RED | e94de3c | Failing BEAP convention tests (5 methods) |
| T1 GREEN | 4ccd0f2 | Package critic implementation with BEAP checks |
| T2 | 34b746f | Bach llll + community extraction critic + 6 tests |

## Test Coverage

11 new tests in `TestPackageCritic`:
- `test_beap_missing_vca` -- osc -> output without VCA (warning)
- `test_beap_clean_chain` -- osc -> VCA -> output (no findings)
- `test_beap_missing_output` -- osc -> VCA, no output (warning)
- `test_no_beap_no_findings` -- pure MSP patch (empty results)
- `test_beap_mixed_patch` -- BEAP + MSP, only BEAP checked
- `test_bach_llll_mismatch` -- pack -> bach.score (blocker)
- `test_bach_to_bach_clean` -- bach.rev -> bach.score (no findings)
- `test_bach_list2llll_allowed` -- unpack -> bach.list2llll (no findings)
- `test_bach_non_llll_inlet` -- pack -> bach.write (no findings)
- `test_community_unextracted_warning` -- fluid.mfcc~ (warning)
- `test_community_extracted_clean` -- BEAP objects (no community findings)

67 total critic tests pass. 336 core tests pass (critics + validation + patcher).

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 3 - Blocking] Added prefix-matching fallback for community extraction check**
- **Found during:** Task 2
- **Issue:** `db.get_package("fluid.mfcc~")` returns None because FluCoMa objects aren't in the DB (extracted=false, object_count=0). The community check couldn't detect unextracted packages.
- **Fix:** Added `_match_package_by_prefix()` that matches object names against package prefixes from `package_info.json` when DB lookup fails.
- **Files modified:** src/maxpat/critics/package_critic.py
- **Commit:** 34b746f

## Known Stubs

None -- all functions are fully implemented with real DB lookups and graph traversal.

## Self-Check: PASSED

- [x] src/maxpat/critics/package_critic.py exists
- [x] Commit e94de3c exists (T1 RED)
- [x] Commit 4ccd0f2 exists (T1 GREEN)
- [x] Commit 34b746f exists (T2)
- [x] 67 critic tests pass
- [x] 336 core tests pass (no regressions)
