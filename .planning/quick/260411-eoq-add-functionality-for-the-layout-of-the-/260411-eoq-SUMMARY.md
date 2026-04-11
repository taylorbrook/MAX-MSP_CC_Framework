# Quick Task 260411-eoq: Font Contrast Readability

**Date:** 2026-04-11
**Status:** Complete

## What Was Done

### Task 1: `ensure_text_contrast()` + pipeline integration
- Added `ensure_text_contrast()` to `src/maxpat/aesthetics.py` — iterates all comment/text boxes, detects overlapping panels via point-in-rect, and sets textcolor for WCAG-compliant contrast
- Added `_point_in_rect()` and `_get_panel_bgcolor()` helpers
- Integrated into `apply_auto_styling()` pipeline so contrast is applied automatically
- Exported from `src/maxpat/__init__.py`
- 11 tests in `tests/test_aesthetics.py` (`TestEnsureTextContrast`)

### Task 2: Layout critic contrast check
- Added `_check_text_contrast()` to `src/maxpat/critics/layout_critic.py`
- Integrated into `review_layout()` for catching low-contrast in loaded/edited patches
- 2 tests in `tests/test_aesthetics.py` (`TestContrastCritic`)

## Commits
- `4d51f7b` test(quick-260411-eoq): add failing tests for ensure_text_contrast
- `1f15ef7` feat(quick-260411-eoq): implement ensure_text_contrast with pipeline integration
- `87ba2ec` feat(quick-260411-eoq): add text contrast check to layout critic

## Files Modified
- `src/maxpat/aesthetics.py` — `ensure_text_contrast()`, `_point_in_rect()`, `_get_panel_bgcolor()`
- `src/maxpat/__init__.py` — export `ensure_text_contrast`
- `src/maxpat/critics/layout_critic.py` — `_check_text_contrast()` in `review_layout()`
- `tests/test_aesthetics.py` — 13 new tests
