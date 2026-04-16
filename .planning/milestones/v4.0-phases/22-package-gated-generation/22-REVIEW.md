---
phase: 22-package-gated-generation
reviewed: 2026-04-14T13:50:00Z
depth: standard
files_reviewed: 6
files_reviewed_list:
  - src/maxpat/project.py
  - src/maxpat/patcher.py
  - src/maxpat/validation.py
  - tests/test_project.py
  - tests/test_patcher.py
  - tests/test_validation.py
findings:
  critical: 0
  warning: 3
  info: 3
  total: 6
status: issues_found
---

# Phase 22: Code Review Report

**Reviewed:** 2026-04-14T13:50:00Z
**Depth:** standard
**Files Reviewed:** 6
**Status:** issues_found

## Summary

Reviewed the package-gated generation feature across core source files (project.py, patcher.py, validation.py) and their test suites. The new `allowed_packages` plumbing, config management (`load_project_config`, `save_project_config`, `get_allowed_packages`), and validation Layer 2c (`_validate_package_gating`) are well-structured and properly tested. One missing attribute initialization in `from_dict` will cause crashes when adding boxes to round-tripped Patchers. Two missing error-handling paths in project.py can raise unhandled exceptions on corrupted/missing files. No security issues found.

## Warnings

### WR-01: `Patcher.from_dict()` missing `allowed_packages` attribute

**File:** `src/maxpat/patcher.py:1933-1937`
**Issue:** `from_dict()` initializes a Patcher via `cls.__new__(cls)` and sets `db`, `boxes`, `lines`, `_is_subpatcher` -- but never sets `allowed_packages`. Any subsequent call to `add_box()` (line 433) or `add_comment()` (line 463) on a Patcher created via `from_dict()` will raise `AttributeError: 'Patcher' object has no attribute 'allowed_packages'`. This is hit during patch editing workflows (load, modify, save).
**Fix:**
```python
p = cls.__new__(cls)
p.db = db if db is not None else ObjectDatabase()
p.allowed_packages = None  # Add this line
p.boxes = []
p.lines = []
p._is_subpatcher = False
```

### WR-02: `get_active_project` does not handle malformed JSON

**File:** `src/maxpat/project.py:131`
**Issue:** `json.loads(active_file.read_text())` is called without a try/except. If `.active-project.json` is corrupted (e.g., empty file, partial write from crash, concurrent access), this raises `json.JSONDecodeError` instead of returning `None` as the docstring contract implies ("Returns None if no .active-project.json exists"). The function already handles the missing-file and missing-directory cases gracefully -- malformed content should follow the same pattern.
**Fix:**
```python
try:
    data = json.loads(active_file.read_text())
except (json.JSONDecodeError, ValueError):
    return None
```

### WR-03: `read_status` crashes on missing status.md

**File:** `src/maxpat/project.py:149`
**Issue:** `status_file.read_text()` is called without checking `status_file.is_file()`. If `read_status` is called on a project directory that lacks a `status.md` (e.g., manually created directory, interrupted `create_project`), it raises `FileNotFoundError`. Other project functions (`get_version`, `load_project_config`) handle the missing-file case gracefully. This function should be consistent.
**Fix:**
```python
def read_status(project_dir: Path) -> dict:
    status_file = project_dir / "status.md"
    if not status_file.is_file():
        return {}
    content = status_file.read_text()
    # ... rest unchanged
```

## Info

### IN-01: Redundant `import json as _json` in `create_project`

**File:** `src/maxpat/project.py:82`
**Issue:** `json` is already imported at module level (line 14). The local `import json as _json` alias is unnecessary and inconsistent -- the function uses `_json.dumps()` but the rest of the module uses `json.dumps()`.
**Fix:** Remove `import json as _json` and use `json.dumps(patch_dict, indent=2)` instead of `_json.dumps(patch_dict, indent=2)`.

### IN-02: `deque` imported inside function body

**File:** `src/maxpat/validation.py:731`
**Issue:** `from collections import deque` is imported inside the `_check_gain_staging` function body. While this works, it executes on every call (once per oscillator) and is inconsistent with the module's other stdlib imports (`defaultdict` is imported at module level on line 9). Moving it to the top reduces per-call overhead.
**Fix:** Add `from collections import deque` next to the existing `from collections import defaultdict` import at line 9.

### IN-03: Dead code branch in `_populate_comments_recursive`

**File:** `src/maxpat/patcher.py:1603`
**Issue:** The expression `prefix = "signal" if inlet_box.name.endswith("~") else "signal" if downstream.name.endswith("~") else "data"` has a dead first branch. `inlet_box.name` is always `"inlet"` (never ends with `~`), so the first ternary condition is always False. The same pattern repeats at line 1622 for outlet processing where `outlet_box.name` is always `"outlet"`. The logic works correctly despite this because the fallback conditions handle it, but the dead branch is misleading.
**Fix:**
```python
prefix = "signal" if downstream.name.endswith("~") else "data"
```
And for outlets:
```python
prefix = "signal" if upstream.name.endswith("~") else "data"
```

---

_Reviewed: 2026-04-14T13:50:00Z_
_Reviewer: Claude (gsd-code-reviewer)_
_Depth: standard_
