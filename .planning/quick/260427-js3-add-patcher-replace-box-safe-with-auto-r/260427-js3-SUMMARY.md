---
phase: quick-260427-js3
plan: 01
subsystem: maxpat
tags: [patcher, replace-box, auto-rewire, P1-1]
requires:
  - src/maxpat/patcher.py:replace_box (delegated to internally)
  - src/maxpat/patcher.py:add_connection (used to rewire orphans)
provides:
  - src/maxpat/patcher.py:replace_box_safe (new method, line 1054)
  - tests/test_patcher.py:TestReplaceBoxSafe (new class, 4 tests)
affects:
  - CLAUDE.md (Rule #8 — added preferred-default paragraph)
tech-stack:
  added: []
  patterns:
    - delegation: replace_box_safe wraps replace_box and post-processes orphans
    - I/O-match guard: only auto-rewire when numinlets AND numoutlets match
    - fallback-no-raise: I/O mismatch returns orphans, never raises
key-files:
  created: []
  modified:
    - src/maxpat/patcher.py
    - tests/test_patcher.py
    - CLAUDE.md
decisions:
  - "Delegate to replace_box rather than fork its body — keeps single source of truth for orphan capture, removal, and box creation"
  - "Capture old_numinlets/numoutlets BEFORE delegating because replace_box removes the old box; comparing post-removal would be unsafe"
  - "Build id->box map once for O(1) orphan resolution rather than per-orphan list scan"
  - "Self-loops (old_box on both sides of an orphan) handled naturally by the same id→result.box redirect on each side"
  - "Mismatch returns orphans without raising — preserves the 'callers always have something to act on' contract from replace_box"
metrics:
  duration: ~7 min
  tasks_completed: 3
  files_modified: 3
  tests_added: 4
  tests_passing: 193 (full tests/test_patcher.py)
  completed_date: "2026-04-27"
---

# Phase quick-260427-js3 Plan 01: Add replace_box_safe with auto-rewire Summary

**One-liner:** Adds `Patcher.replace_box_safe()` — a safer default that delegates to `replace_box` and auto-rewires orphans by index when the new box's I/O layout matches, eliminating the silent-disconnect trap that caused the bassoon `ears.slice~ → ears.split~` regression.

## Final Method Signature and Placement

```python
def replace_box_safe(
    self,
    old_box: Box,
    new_name: str,
    *,
    args: list[str] | None = None,
    rewire: str = "auto",
) -> EditResult
```

- File: `src/maxpat/patcher.py`
- Method definition starts at line 1054 (immediately after `replace_box` at line 1002, before `insert_into_connection` at line 1138)
- 84 lines added (no edits to surrounding methods; existing `replace_box` is byte-for-byte unchanged)

## Behavior Matrix

| `rewire` | I/O match | Result |
| --- | --- | --- |
| `"auto"` | Yes | Connections rewired by index. `orphaned == []`. |
| `"auto"` | No | Falls back to `replace_box` shape: orphans returned, no raise. |
| `"manual"` | (any) | Same as `replace_box`: orphans returned, no rewire attempt. |
| (other) | n/a | `ValueError("rewire must be 'auto' or 'manual', got ...")` |

## Tests

`tests/test_patcher.py::TestReplaceBoxSafe` — 4 tests, all green:

1. `test_auto_rewire_matching_io_zero_orphans` — `cycle~ → saw~` (both 2/1). Asserts `orphaned == []`, three patchlines remap `old.id → new.id` cleanly.
2. `test_auto_mismatched_io_falls_back_to_orphans` — `cycle~` (2/1) → `pack 0 0 0` (3/1). Asserts 2 orphans returned, no patchlines connected to new box.
3. `test_manual_mode_skips_rewire_even_on_match` — explicit `rewire="manual"` returns orphan even with matching I/O.
4. `test_ears_slice_to_split_regression_preserves_connections` — bassoon regression. `ears.slice~ → ears.split~` (both 2/2) with three real connections (outlet 0, inlet 0, inlet 1). All three survive on the new box.

### Test Suite Status

| Suite | Pass | Notes |
| --- | --- | --- |
| `TestReplaceBoxSafe` (new) | 4/4 | — |
| `TestReplaceBox` (existing) | 7/7 | `replace_box` unchanged |
| `tests/test_patcher.py` (full) | 193/193 | No regressions |

## ears.slice~ → ears.split~ Regression — Confirmed Fixed

The plan's Task 2 Test 4 reproduces the exact bassoon regression case documented in `feedback_replace_box_orphans.md`. Both objects are 2 inlets / 2 outlets in the package DB. After `replace_box_safe`, all three connections (outgoing from outlet 0, incoming on inlets 0 and 1) wire through to the new box; `EditResult.orphaned == []`.

## Commits (atomic per task)

| Task | Commit | Description |
| --- | --- | --- |
| 1 — Implement | `78708f8` | feat: add Patcher.replace_box_safe with auto-rewire |
| 2 — Tests | `3b61967` | test: cover replace_box_safe auto-rewire behavior |
| 3 — Docs | `b48c9e1` | docs: point Rule #8 at replace_box_safe as preferred default |

## Files Modified

- `src/maxpat/patcher.py` — +84 lines: `replace_box_safe` method between `replace_box` and `insert_into_connection`. No edits to existing methods.
- `tests/test_patcher.py` — +102 lines: `TestReplaceBoxSafe` class with 4 tests, placed immediately after `TestReplaceBox`.
- `CLAUDE.md` — +2 lines: appended paragraph to Rule #8 introducing `replace_box_safe` as the preferred default for new code. Existing two paragraphs unchanged.

## Deviations from Plan

None — plan executed exactly as written.

DB-data note: the plan inline-described `cycle~`/`saw~` as "1 inlet, 1 outlet" but the actual DB entries are 2 in / 1 out. They still match (so Test 1 still works as the plan intended). Verified with `ObjectDatabase.lookup()` before writing tests; updated test docstrings/comments to reflect actual values.

## Self-Check: PASSED

- File `src/maxpat/patcher.py` — FOUND, contains `def replace_box_safe` at line 1054
- File `tests/test_patcher.py` — FOUND, contains `class TestReplaceBoxSafe` (4 tests)
- File `CLAUDE.md` — FOUND, contains `replace_box_safe` (1 occurrence in Rule #8)
- Commit `78708f8` — FOUND in git log
- Commit `3b61967` — FOUND in git log
- Commit `b48c9e1` — FOUND in git log
- `python3 -m pytest tests/test_patcher.py -x -q` — 193 passed
