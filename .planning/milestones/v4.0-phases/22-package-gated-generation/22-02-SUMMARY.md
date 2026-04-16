---
phase: 22-package-gated-generation
plan: "02"
subsystem: patcher-gating
tags: [packages, patcher, validation, gating]
dependency_graph:
  requires: [load_project_config, get_allowed_packages]
  provides: [patcher-allowed-packages, validation-package-layer]
  affects: [agent-skills, max-build-flow]
tech_stack:
  added: []
  patterns: [constructor-threading, defense-in-depth-validation]
key_files:
  created: []
  modified:
    - src/maxpat/patcher.py
    - src/maxpat/validation.py
    - tests/test_patcher.py
    - tests/test_validation.py
decisions:
  - "allowed_packages threaded explicitly through Patcher->Box->db.lookup() -- no global state"
  - "from_dict() unchanged -- loading never gates packages (uses Box.__new__)"
  - "validation reads allowed_packages from Patcher instance if caller doesn't pass it"
metrics:
  duration: "296s"
  completed: "2026-04-14"
  tasks_completed: 2
  tasks_total: 2
---

# Phase 22 Plan 02: Patcher/Validation Package Gating Summary

allowed_packages threaded through Patcher/Box constructors to db.lookup() for generation-time gating, plus Layer 2c validation for defense-in-depth post-generation checking.

## Tasks Completed

| # | Task | Commit | Files |
|---|------|--------|-------|
| 1 | Thread allowed_packages through Patcher and Box constructors (TDD) | c99d37d | src/maxpat/patcher.py, tests/test_patcher.py |
| 2 | Add package validation layer to validation pipeline (TDD) | f9fbf51 | src/maxpat/validation.py, tests/test_validation.py |

## What Was Built

### Patcher/Box Package Threading (patcher.py)
- `Patcher.__init__(allowed_packages=None)` -- stores filter, default None for backward compat
- `Box.__init__(allowed_packages=None)` -- passes to `db.lookup(name, allowed_packages=...)`
- `add_box()`, `add_comment()`, `add_message()` -- all pass `allowed_packages=self.allowed_packages` to Box
- `add_subpatcher()`, `add_bpatcher()` (embedded), `add_gen()` -- all pass `allowed_packages=self.allowed_packages` to inner Patcher
- `from_dict()` unchanged -- uses `Box.__new__(Box)`, bypasses gating entirely (correct for loading)

### Validation Package Layer (validation.py)
- `validate_patch(allowed_packages=None)` -- new parameter, reads from Patcher instance if not passed
- `_validate_package_gating()` -- Layer 2c, checks every object against allowed packages
- Package violations produce `ValidationResult(layer="packages", level="error")`
- Returns empty list when `allowed_packages` is None (backward compat)

### Test Coverage
- `TestPackageGating` (test_patcher.py) -- 7 tests: backward compat, core allowed, package blocked, matching package, wrong package, subpatcher inheritance, from_dict no gating
- `TestPackageValidation` (test_validation.py) -- 7 tests: no filter, empty filter, matching package, wrong package, core never flagged, error format, Patcher instance auto-read

## Verification Results

```
tests/test_patcher.py: 189 passed (7 new)
tests/test_validation.py: 75 passed (7 new)
Total: 264 passed, 0 failed
```

Note: `test_inlet_types.py::test_tilde_objects_have_signal_io` has a pre-existing failure unrelated to this plan's changes.

## Deviations from Plan

None -- plan executed exactly as written.

## Decisions Made

1. **Explicit threading over global state** -- `allowed_packages` passed through constructor chain (Patcher -> Box -> db.lookup), no state stored on ObjectDatabase instance
2. **from_dict() deliberately unchanged** -- Uses `Box.__new__(Box)` bypass; loading existing patches should never reject objects (T-22-04 accepted risk)
3. **Validation reads Patcher's allowed_packages** -- When `validate_patch(patcher_instance)` is called without explicit `allowed_packages`, it reads `patcher.allowed_packages` automatically

## Self-Check: PASSED

- src/maxpat/patcher.py: FOUND
- src/maxpat/validation.py: FOUND
- tests/test_patcher.py: FOUND
- tests/test_validation.py: FOUND
- Commit c99d37d: FOUND
- Commit f9fbf51: FOUND
