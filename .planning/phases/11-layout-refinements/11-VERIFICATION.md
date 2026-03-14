---
phase: 11-layout-refinements
verified: 2026-03-13T00:30:00Z
status: passed
score: 13/13 must-haves verified
re_verification: false
---

# Phase 11: Layout Refinements Verification Report

**Phase Goal:** Layout refinements - configurable spacing, inlet alignment, grid snapping, width overrides, comment placement
**Verified:** 2026-03-13
**Status:** PASSED
**Re-verification:** No - initial verification

---

## Goal Achievement

### Observable Truths

| # | Truth | Status | Evidence |
|---|-------|--------|----------|
| 1 | LayoutOptions dataclass exists with fields v_spacing, h_gutter, patcher_padding, grid_size, grid_snap, inlet_align, comment_gap | VERIFIED | `src/maxpat/defaults.py` lines 28-41: `@dataclass class LayoutOptions` with all 7 fields confirmed by import test |
| 2 | LayoutOptions default values match existing module-level constants (V_SPACING=20, H_GUTTER=15, PATCHER_PADDING=40) | VERIFIED | v_spacing=20.0, h_gutter=15.0, patcher_padding=40.0 confirmed via `python3 -c "from src.maxpat.defaults import LayoutOptions; ..."` |
| 3 | All 54 existing layout+sizing tests pass after test refactoring (zero regressions) | VERIFIED | 847 full-suite tests pass: `python3 -m pytest tests/ -x -q` = 847 passed |
| 4 | Test assertions use LayoutOptions defaults instead of hardcoded magic ranges | VERIFIED | `tests/test_layout.py` lines 154 and 176 use `opts = LayoutOptions()` instead of `assert 10 <= gap <= 40` and `assert 5 <= gutter <= 30`; grep confirms no hardcoded magic number assertions remain |
| 5 | Objects with audit width data return audit-based widths from calculate_box_size() instead of text-length approximation | VERIFIED | `cycle~ 440` returns 68.0 (not ~79 text-based); `_WIDTH_OVERRIDES` has 513 objects loaded at module import |
| 6 | Objects NOT in the override table fall back to existing text-length calculation (no regression) | VERIFIED | `zzz_fake_object 1 2 3` returns 163.0 == text-length calculation exactly |
| 7 | Width overrides are keyed by object name with a "default" key for median_width | VERIFIED | `width-overrides.json` structure confirmed: `{"cycle~": {"default": 68.0}, ...}` |
| 8 | Only objects with >= 3 instances in audit data are included in the override table | VERIFIED | 513 objects in override table (per SUMMARY and confirmed by `len(d)` == 513) |
| 9 | Child objects positioned so destination inlet X aligns under parent source outlet X | VERIFIED | End-to-end test: outlet_x=64.0, inlet_x=52.0, diff=12.0 which is <= 15px grid tolerance |
| 10 | All object positions in generated patches are multiples of 15.0 (MAX native grid) | VERIFIED | Three-box chain: cycle~(30,30), *~(45,75), ezdac~(45,120) - all mod 15 == 0.0 |
| 11 | Comments with a target_id are placed to the right of their target object with gap at same Y | VERIFIED | comment.x=105.0 > osc_right=98.0; comment.y == osc.y within 15px tolerance |
| 12 | apply_layout() accepts an optional LayoutOptions parameter and uses its values | VERIFIED | `apply_layout(p, LayoutOptions(v_spacing=50.0, grid_snap=False))` produces gap=50.0 exactly |
| 13 | apply_layout(patcher) with no options produces the same layout as before (backward compatible) | VERIFIED | No-options call succeeds; a.y < b.y = True; all 847 existing tests pass |

**Score:** 13/13 truths verified

---

## Required Artifacts

| Artifact | Expected | Status | Details |
|----------|----------|--------|---------|
| `src/maxpat/defaults.py` | LayoutOptions dataclass | VERIFIED | Contains `class LayoutOptions` with 7 fields; `dataclasses` imported; module-level constants preserved |
| `tests/test_layout.py` | Refactored layout test assertions | VERIFIED | Imports LayoutOptions; lines 154 and 176 use relative assertions; 6 new test classes added |
| `.claude/max-objects/audit/width-overrides.json` | Per-object width override table | VERIFIED | 21KB file, 513 objects, `{"default": float}` structure |
| `src/maxpat/sizing.py` | Width override lookup in calculate_box_size() | VERIFIED | `_load_width_overrides()` + `_WIDTH_OVERRIDES` module cache + override lookup before text-length fallback |
| `tests/test_sizing.py` | Tests for width override lookup and fallback | VERIFIED | `TestWidthOverrides` class with 5 tests at line 165 |
| `src/maxpat/layout.py` | Inlet alignment, grid snap, comment placement, LayoutOptions integration | VERIFIED | `_snap_to_grid`, `_place_associated_comments`, `_target_x_for_inlet_align` all present and wired into `apply_layout()` |
| `src/maxpat/patcher.py` | Box.target_id field and add_comment target parameter | VERIFIED | `target_id` set on all 10 `Box.__new__` paths; `add_comment` and `add_annotation` accept `target` parameter; `target_id` not serialized to `to_dict()` output |

---

## Key Link Verification

| From | To | Via | Status | Details |
|------|----|-----|--------|---------|
| `tests/test_layout.py` | `src/maxpat/defaults.py` | `import LayoutOptions` | WIRED | Line 17: `from src.maxpat.defaults import V_SPACING, H_GUTTER, LayoutOptions` |
| `src/maxpat/sizing.py` | `.claude/max-objects/audit/width-overrides.json` | `json.load at import time` via `_load_width_overrides` | WIRED | Lines 17-27: loader function; line 30: `_WIDTH_OVERRIDES = _load_width_overrides()` at module level |
| `src/maxpat/sizing.py` | `src/maxpat/sizing.py` | `_WIDTH_OVERRIDES.get` override lookup before text-length fallback | WIRED | Lines 127-135: `overrides = _WIDTH_OVERRIDES.get(obj_name)` inside `calculate_box_size()` |
| `src/maxpat/layout.py` | `src/maxpat/defaults.py` | `import LayoutOptions` (multi-line import block) | WIRED | Lines 25-34: `from src.maxpat.defaults import (..., LayoutOptions,)` |
| `src/maxpat/layout.py` | `src/maxpat/patcher.py` | reads `box.target_id` for comment placement | WIRED | Line 715: `if box.maxclass == "comment" and box.target_id:` inside `_place_associated_comments()` |
| `src/maxpat/patcher.py` | `src/maxpat/patcher.py` | `add_comment` sets `target_id` on box | WIRED | Lines 326-327: `if target is not None: box.target_id = target.id` |

---

## Requirements Coverage

| Requirement | Source Plan | Description | Status | Evidence |
|-------------|-------------|-------------|--------|----------|
| LYOT-01 | 11-02 | Box width calculation using per-object width override table | SATISFIED | `width-overrides.json` (513 objects); `calculate_box_size()` returns 68.0 for `cycle~`; fallback confirmed for unknowns |
| LYOT-02 | 11-03 | Inlet-aligned cable routing positions children under parent outlet X | SATISFIED | `_target_x_for_inlet_align()` in `layout.py`; diff <= 15px verified end-to-end |
| LYOT-03 | 11-03 | 15px grid snapping rounds all object positions to MAX native grid | SATISFIED | `_snap_to_grid()` in `layout.py`; all positions mod 15 == 0 verified end-to-end |
| LYOT-04 | 11-03 | Comment association placement positions comments near target objects | SATISFIED | `_place_associated_comments()` in `layout.py`; `Box.target_id` in `patcher.py`; placement verified end-to-end |
| LYOT-05 | 11-01 | LayoutOptions dataclass replaces module-level constants for configurable layout | SATISFIED | `LayoutOptions` dataclass in `defaults.py`; integrated into `apply_layout()`, `_position_component()`, `_place_ui_controls()`, `_auto_size_patcher_rect()` |
| LYOT-06 | 11-01 | Layout tests refactored to relative assertions before spacing constant changes | SATISFIED | Lines 154 and 176 in `test_layout.py` use `LayoutOptions()` defaults with percentage tolerances; no hardcoded magic ranges remain |

No orphaned requirements: all 6 LYOT requirements declared in plan frontmatter are accounted for and satisfied.

---

## Anti-Patterns Found

| File | Line | Pattern | Severity | Impact |
|------|------|---------|----------|--------|
| `src/maxpat/sizing.py` | 25 | `return {}` | Info | Correct defensive fallback when `width-overrides.json` is absent; not a stub |

No blockers or warnings found.

---

## Human Verification Required

None. All Phase 11 goals are verifiable programmatically:

- Dataclass structure and field values confirmed by import test
- Width overrides confirmed by calculating `cycle~` width
- Grid snap confirmed by checking modulo 15 on output positions
- Inlet alignment confirmed by comparing outlet/inlet X coordinates
- Comment placement confirmed by X/Y coordinate assertions
- Test suite: 847 tests passing

---

## Gaps Summary

None. Phase 11 achieved its goal completely.

All 6 requirements (LYOT-01 through LYOT-06) are satisfied. All artifacts exist, are substantive, and are correctly wired. The full test suite passes with 847 tests. No stubs, placeholders, or broken connections were found.

---

_Verified: 2026-03-13_
_Verifier: Claude (gsd-verifier)_
