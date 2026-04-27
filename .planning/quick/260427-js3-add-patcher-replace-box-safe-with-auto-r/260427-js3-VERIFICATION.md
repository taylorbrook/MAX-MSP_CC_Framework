---
phase: quick-260427-js3
verified: 2026-04-27T00:00:00Z
status: passed
score: 7/7 must-haves verified
overrides_applied: 0
---

# Phase quick-260427-js3: Add Patcher.replace_box_safe with auto-rewire — Verification Report

**Phase Goal:** Add `Patcher.replace_box_safe(old, new_name, args=None, rewire="auto")` providing a safer default alternative to `replace_box`. When new box's I/O layout matches the old, connections are auto-rewired by index. Implements FINDINGS § P1-1.
**Verified:** 2026-04-27
**Status:** passed
**Re-verification:** No — initial verification

## Goal Achievement

### Observable Truths

| #   | Truth                                                                                                                  | Status     | Evidence                                                                                                       |
| --- | ---------------------------------------------------------------------------------------------------------------------- | ---------- | -------------------------------------------------------------------------------------------------------------- |
| 1   | `replace_box_safe` exists with signature `(self, old_box, new_name, *, args=None, rewire="auto") -> EditResult`        | VERIFIED   | `inspect.signature` confirms params `[self, old_box, new_name, args, rewire]`, defaults `args=None, rewire="auto"` (patcher.py:1054-1061) |
| 2   | Auto-rewire produces empty `orphaned` list when old/new I/O counts match (numinlets AND numoutlets)                    | VERIFIED   | Test `test_auto_rewire_matching_io_zero_orphans` PASSES; impl returns `EditResult(box=..., orphaned=[])` at patcher.py:1133 after rewire loop |
| 3   | Manual mode (`rewire="manual"`) returns orphans identical in shape to existing `replace_box`                           | VERIFIED   | Test `test_manual_mode_skips_rewire_even_on_match` PASSES; impl returns `result` unchanged at patcher.py:1114 |
| 4   | I/O mismatch with `rewire="auto"` falls back to manual behavior (returns orphans, does not raise)                       | VERIFIED   | Test `test_auto_mismatched_io_falls_back_to_orphans` PASSES; impl returns `result` unchanged at patcher.py:1136 |
| 5   | Existing `replace_box` behavior unchanged (TestReplaceBox 7/7 pass)                                                    | VERIFIED   | `pytest tests/test_patcher.py::TestReplaceBox` → 7 passed; replace_box body at patcher.py:1002-1052 byte-equal to plan baseline |
| 6   | All four new tests in `tests/test_patcher.py` pass                                                                     | VERIFIED   | `pytest tests/test_patcher.py::TestReplaceBoxSafe -v` → 4 passed                                              |
| 7   | `ears.slice~` → `ears.split~` regression test passes (3 connections survive on new box)                                | VERIFIED   | `test_ears_slice_to_split_regression_preserves_connections` PASSES; tuple-set assertion confirms all 3 wires remap to new box id |

**Score:** 7/7 truths verified

### Required Artifacts

| Artifact                  | Expected                                          | Exists | Substantive               | Wired                                   | Status   |
| ------------------------- | ------------------------------------------------- | ------ | ------------------------- | --------------------------------------- | -------- |
| `src/maxpat/patcher.py`   | `replace_box_safe` method on Patcher class        | yes    | yes — full impl 84 lines  | `self.replace_box(...)` and `self.add_connection(...)` calls present | VERIFIED |
| `tests/test_patcher.py`   | `TestReplaceBoxSafe` class with 4 tests          | yes    | yes — 4 test methods, ~100 lines | 5 references to `replace_box_safe` (1 per test + class doc) | VERIFIED |
| `CLAUDE.md`               | Rule #8 paragraph referencing `replace_box_safe` | yes    | yes — full paragraph at line 142 | Located inside Rule #8 section, before Rule #9 | VERIFIED |

### Key Link Verification

| From                                       | To                                       | Via                                              | Status | Details                                                              |
| ------------------------------------------ | ---------------------------------------- | ------------------------------------------------ | ------ | -------------------------------------------------------------------- |
| `patcher.py:replace_box_safe`              | `patcher.py:replace_box`                 | `result = self.replace_box(old_box, new_name, args=args)` | WIRED  | Exactly 1 occurrence of `self.replace_box(` in file (line 1111)      |
| `patcher.py:replace_box_safe`              | `patcher.py:add_connection`              | `self.add_connection(src_box, ...)` in auto-rewire loop  | WIRED  | `self.add_connection(` in file 3x; auto-rewire body at line 1130-1132 |
| `tests/test_patcher.py:TestReplaceBoxSafe` | `patcher.py:replace_box_safe`            | direct method calls with `rewire` kwarg          | WIRED  | 5 references to `replace_box_safe` in test file (one per test + class) |

### Data-Flow Trace (Level 4)

N/A — this is a library method, not a UI/data-rendering artifact. Data flow is verified directly by the 4 unit tests asserting on `EditResult.orphaned` and `p.lines` post-state.

### Behavioral Spot-Checks

| Behavior                                                | Command                                                                  | Result                                                  | Status |
| ------------------------------------------------------- | ------------------------------------------------------------------------ | ------------------------------------------------------- | ------ |
| `replace_box_safe` callable with documented signature   | `python3 -c "import inspect; from src.maxpat.patcher import Patcher; print(inspect.signature(Patcher.replace_box_safe))"` | `(self, old_box, new_name, *, args=None, rewire='auto') -> EditResult` | PASS   |
| TestReplaceBoxSafe class — all 4 tests pass             | `pytest tests/test_patcher.py::TestReplaceBoxSafe -v`                    | 4 passed                                                | PASS   |
| TestReplaceBox regression — 7 existing tests still pass | `pytest tests/test_patcher.py::TestReplaceBox -v`                        | 7 passed                                                | PASS   |
| Full patcher suite — no regressions                     | `pytest tests/test_patcher.py`                                            | 193 passed                                              | PASS   |

### Requirements Coverage

| Requirement | Source Plan          | Description                                                                  | Status    | Evidence                                                                       |
| ----------- | -------------------- | ---------------------------------------------------------------------------- | --------- | ------------------------------------------------------------------------------ |
| P1-1        | `260427-js3-PLAN.md` | Add `Patcher.replace_box_safe` with auto-rewire to eliminate silent-orphan trap | SATISFIED | New method at patcher.py:1054 + 4 unit tests + CLAUDE.md Rule #8 update; ears.slice~→ears.split~ regression case validated |

### Anti-Patterns Found

None. Reviewed `src/maxpat/patcher.py:1054-1136`, `tests/test_patcher.py:1404-1503`, and `CLAUDE.md:142`:
- No TODO/FIXME/placeholder markers in new code
- No `return null/{}/[]` stubs (auto-rewire path is fully implemented)
- No `console.log`-only handlers
- No empty exception handlers
- ValueError raised with informative message for invalid `rewire` value (patcher.py:1098-1100)

### Human Verification Required

None. All must-haves are programmatically verifiable through unit tests and code inspection. The library-level behavior is fully covered by the 4 new tests including the exact bassoon regression case.

### Gaps Summary

No gaps. Phase goal fully achieved:

1. **Method exists** with the exact specified signature, placed at line 1054 (after `replace_box` at 1002, before `insert_into_connection` at 1138 — matches plan placement directive).
2. **Auto-rewire works** — connections by index when I/O matches, returning `EditResult.orphaned == []`.
3. **Manual mode preserved** — returns orphans untouched, byte-compatible with `replace_box`.
4. **Mismatch fallback** — returns orphans without raising, satisfying the "callers always have something to act on" contract.
5. **Existing replace_box untouched** — TestReplaceBox passes 7/7 with no modifications to lines 1002-1052.
6. **Tests pass 4/4** including the documented regression (`ears.slice~` → `ears.split~`).
7. **CLAUDE.md Rule #8** updated with the preferred-default paragraph.
8. **Full test suite green** at 193/193.
9. **Atomic commits** present in git log: `78708f8` (impl), `3b61967` (tests), `b48c9e1` (docs).

---

_Verified: 2026-04-27_
_Verifier: Claude (gsd-verifier)_
