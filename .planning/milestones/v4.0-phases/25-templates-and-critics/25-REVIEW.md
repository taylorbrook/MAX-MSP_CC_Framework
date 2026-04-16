---
phase: 25-templates-and-critics
reviewed: 2026-04-15T12:00:00Z
depth: standard
files_reviewed: 8
files_reviewed_list:
  - src/maxpat/critics/package_critic.py
  - src/maxpat/critics/__init__.py
  - tests/test_critics.py
  - .claude/skills/max-critic/SKILL.md
  - .claude/skills/max-dsp-agent/SKILL.md
  - .claude/skills/max-patch-agent/SKILL.md
  - .claude/skills/max-lifecycle/SKILL.md
  - .claude/max-objects/PACKAGES.md
findings:
  critical: 0
  warning: 3
  info: 2
  total: 5
status: issues_found
---

# Phase 25: Code Review Report

**Reviewed:** 2026-04-15T12:00:00Z
**Depth:** standard
**Files Reviewed:** 8
**Status:** issues_found

## Summary

Reviewed the package critic module, the critics `__init__.py` integration layer, and the test suite. The package_critic.py implementation is solid -- clean BFS graph traversal for BEAP checks, proper llll type checking for Bach, and sensible community extraction gating. The code is well-structured with clear separation of concerns across the three check categories.

Found no critical/security issues. Three warnings around redundant ObjectDatabase instantiation, a missing category check in the BEAP output termination logic, and a potential false negative in the Bach llll checker. Two info items for minor quality improvements.

## Warnings

### WR-01: Double ObjectDatabase instantiation on package-containing patches

**File:** `src/maxpat/critics/__init__.py:41` and `src/maxpat/critics/package_critic.py:61`
**Issue:** `_has_package_boxes()` at line 41 of `__init__.py` creates an `ObjectDatabase()` instance to check if any package objects exist. If the check returns `True`, `review_packages()` at line 61 of `package_critic.py` creates a second `ObjectDatabase()` instance. `ObjectDatabase.__init__` loads 8+ JSON domain files from disk on every instantiation, making this a wasteful double-load on every patch that contains package objects.
**Fix:** Pass the `ObjectDatabase` instance from the gate check into `review_packages()`, or restructure so `review_packages()` always runs but returns early internally (which it already does via the `packages_used` set check). The simplest fix is to remove `_has_package_boxes()` and always call `review_packages()` -- it already exits cheaply when no package objects are found:
```python
# In review_patch(), replace:
#   if _has_package_boxes(patch_dict):
#       results.extend(review_packages(patch_dict))
# With:
results.extend(review_packages(patch_dict))
```

### WR-02: BEAP output termination check uses name set but not category

**File:** `src/maxpat/critics/package_critic.py:203`
**Issue:** The BFS in `_check_beap_output_termination` checks `if current_name in _BEAP_OUTPUT_NAMES` using a hardcoded set of 7 module names. If a BEAP Output-category module is added to the database in the future but not to `_BEAP_OUTPUT_NAMES`, it will produce false positive "missing output" warnings. The VCA check at line 262 correctly uses `_get_beap_category()` to check the category from the database, but the output check does not -- it only checks the name set.
**Fix:** Add a category-based fallback alongside the name check:
```python
current_cat = _get_beap_category(current_box, db)
if current_name in _BEAP_OUTPUT_NAMES or current_cat == "Output":
    found_output = True
    break
```

### WR-03: Bach llll check does not trace through bach.list2llll as a SOURCE

**File:** `src/maxpat/critics/package_critic.py:348`
**Issue:** The check at line 348 skips when `src_name == "bach.list2llll"` (correct -- its output IS llll). However, the `_is_llll_inlet` function relies on the inlet digest containing the word "llll". If a Bach object has an inlet that accepts llll data but the digest text does not literally contain "llll" (e.g., abbreviated as "data" or simply missing the word), the check will produce a false negative -- silently passing a type mismatch. This is a data dependency risk rather than a code logic bug, but worth noting since the Bach package has stub data currently (`extracted: false`).
**Fix:** Once Bach is extracted with real inlet data, verify that all llll-accepting inlets have "llll" in their digest text. Consider adding a secondary heuristic such as checking if the inlet type field contains "llll" in addition to the digest field.

## Info

### IN-01: _get_object_name duplicates logic from get_box_name

**File:** `src/maxpat/critics/package_critic.py:32-40`
**Issue:** `_get_object_name()` adds bpatcher handling on top of `get_box_name()`. This is the correct approach for BEAP/Vizzie objects, but `get_box_name()` in `src/maxpat/utils.py` returns the `maxclass` string for non-newobj boxes (line 18: `return maxclass`), which means for bpatcher boxes it returns `"bpatcher"` -- not the abstraction name. The local `_get_object_name` correctly handles this. However, this pattern will likely be needed elsewhere as package support expands. Consider moving the bpatcher-aware name lookup into `get_box_name()` itself or into a shared utility.

### IN-02: Test module re-imports review_packages at line 1707

**File:** `tests/test_critics.py:1707`
**Issue:** `from src.maxpat.critics.package_critic import review_packages` appears at line 1707, mid-file, despite `review_packages` already being importable through `from src.maxpat.critics import review_packages` (it is listed in `__all__`). The other critic functions are imported at the top of the file (lines 14-18). This mid-file import breaks the pattern and could cause confusion about which import path is canonical.
**Fix:** Move the import to the top of the file alongside the other critic imports:
```python
from src.maxpat.critics.package_critic import review_packages
```

---

_Reviewed: 2026-04-15T12:00:00Z_
_Reviewer: Claude (gsd-code-reviewer)_
_Depth: standard_
