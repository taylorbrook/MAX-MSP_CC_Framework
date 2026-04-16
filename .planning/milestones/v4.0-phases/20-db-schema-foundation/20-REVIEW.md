---
phase: 20-db-schema-foundation
reviewed: 2026-04-14T02:06:07Z
depth: standard
files_reviewed: 3
files_reviewed_list:
  - src/maxpat/db_lookup.py
  - tests/conftest.py
  - tests/test_package_schema.py
findings:
  critical: 0
  warning: 4
  info: 8
  total: 12
status: issues_found
---

# Phase 20: Code Review Report

**Reviewed:** 2026-04-14T02:06:07Z
**Depth:** standard
**Files Reviewed:** 3
**Status:** issues_found

## Summary

Reviewed `ObjectDatabase` implementation and its test suite introduced in phase 20. The implementation is structurally sound — load order, alias resolution, override application, and variable I/O logic are all correct. No security issues or data-loss risks found.

Four warnings: two in the implementation (redundant double file-read of `overrides.json`, silent fragility in outlet type detection), one in `conftest.py` (fixture data diverges from `ObjectDatabase` for overridden objects), and one in the test file (no guard against missing `packages/` directory). Eight info items cover hardcoded counts, dead defensive code, and brittle assertions.

---

## Warnings

### WR-01: `overrides.json` read twice — TOCTOU pattern and wasted I/O

**File:** `src/maxpat/db_lookup.py:57-101`

**Issue:** `overrides.json` is parsed at line 59 (to extract `variable_io_rules`) and again at line 92 (to extract `objects`). If the file is replaced between reads — e.g., during a hot-reload scenario or concurrent test run — `variable_io_rules` and the applied overrides could come from different versions of the file. Even without that race, it's unnecessary I/O and doubled JSON parsing on every `ObjectDatabase()` construction.

**Fix:**
```python
def _load(self, db_root: Path) -> None:
    # Load overrides once
    overrides_path = db_root / "overrides.json"
    overrides_data: dict = {}
    if overrides_path.exists():
        overrides_data = json.loads(overrides_path.read_text())
        self._variable_io_rules = overrides_data.get("variable_io_rules", {})

    # ... (aliases, pd-blocklist, domain loading unchanged) ...

    # Apply object overrides (use already-parsed overrides_data)
    self._overridden_objects: set[str] = set()
    for name, overrides in overrides_data.get("objects", {}).items():
        if name.startswith("_"):
            continue
        if name in self._objects:
            for key, value in overrides.items():
                if key.startswith("_"):
                    continue
                self._objects[name][key] = value
            self._overridden_objects.add(name)
```

---

### WR-02: `get_outlet_types` multichannel check is a substring match on an unconstrained field

**File:** `src/maxpat/db_lookup.py:373`

**Issue:** `"multichannel" in otype.lower()` tests an arbitrary substring of the `type` field. The `type` field is not validated or constrained by any schema, so if a database object has `"type": "multichannelsignal"` (the known value) it works, but if a future object uses `"type": "mc_signal"` or any other variant, the check silently falls through to plain `"signal"` — wrong outlet type, no error, no warning. The impact is incorrect `outlettype` arrays in generated patches.

**Fix:** Match against known discrete values rather than substring:

```python
MULTICHANNEL_OUTLET_TYPES = {"multichannelsignal", "mc.signal"}

# In get_outlet_types:
otype = outlet.get("type", "")
if otype.lower() in MULTICHANNEL_OUTLET_TYPES:
    result.append("multichannelsignal")
else:
    result.append("signal")
```

---

### WR-03: `object_by_name` fixture bypasses overrides — diverges from `ObjectDatabase.lookup()`

**File:** `tests/conftest.py:72-78`

**Issue:** `object_by_name` builds its index directly from raw domain JSON (line 74: `{obj["name"]: obj for obj in all_objects}`). `ObjectDatabase._load()` applies deep-merge overrides from `overrides.json` after loading domain files. Any object with entries in `overrides.json` will return pre-override data from `object_by_name` but post-override data from `db.lookup()`. Tests that cross-reference both sources will see inconsistent values for overridden objects (e.g., inlet/outlet counts on MSP objects that have known corrections).

**Fix:** Either document the fixture as "raw, pre-override" in its docstring and scope its use accordingly, or apply overrides when building the index:

```python
@pytest.fixture(scope="session")
def object_by_name(db_root: Path) -> Callable[[str], dict | None]:
    """Lookup via ObjectDatabase (includes overrides). Mirrors production behavior."""
    from src.maxpat.db_lookup import ObjectDatabase
    db = ObjectDatabase(db_root)
    def _lookup(name: str) -> dict | None:
        return db.lookup(name)
    return _lookup
```

---

### WR-04: `test_package_objects_have_package_field` and `test_migration_completeness` crash with `FileNotFoundError` if `packages/` is missing

**File:** `tests/test_package_schema.py:15, 56`

**Issue:** Both tests call `sorted(pkg_root.iterdir())` without checking `pkg_root.is_dir()` first. If the `packages/` directory does not exist (e.g., in a fresh checkout where package extraction hasn't run), the test suite crashes with an unhandled `FileNotFoundError` rather than a clean assertion failure.

**Fix:**
```python
pkg_root = db_root / "packages"
if not pkg_root.is_dir():
    pytest.skip("packages/ directory does not exist — run package extraction first")
for pkg_dir in sorted(pkg_root.iterdir()):
    ...
```

---

## Info

### IN-01: `get_package_objects` contains unreachable guard

**File:** `src/maxpat/db_lookup.py:195`

**Issue:** `if name in self._objects` in the list comprehension is dead code. `_package_objects[pkg]` is only populated at line 81 immediately after `self._objects[name] = obj`, so every name in `_package_objects` is guaranteed to be in `_objects`. The guard misleads readers into thinking the two dicts can diverge.

**Fix:** Remove the guard:
```python
return [self._objects[name] for name in self._package_objects.get(package, [])]
```

---

### IN-02: Magic number `88` in `test_migration_completeness`

**File:** `tests/test_package_schema.py:63`

**Issue:** `assert total == 88` asserts an exact count. Adding any package object breaks the test with "Expected 88, got 89" — no indication of which package changed or why. This tests "nothing changed" rather than "structure is correct."

**Fix:** Replace with a structural assertion, or at minimum add a comment explaining the magic number and where it comes from:
```python
# If this fails, update the count and check which package gained/lost objects.
# Current distribution: ableton-dsp(77) + Mira(8) + jit.mo(3) = 88
assert total == 88, (
    f"Expected 88 total package objects, got {total}. "
    "Update this count if a package was intentionally added/modified."
)
```

---

### IN-03: Magic number `77` in `test_get_package_objects`

**File:** `tests/test_package_schema.py:154`

**Issue:** `assert len(objs) == 77` — same pattern as IN-02. Any addition to `ableton-dsp` breaks this with no actionable message.

**Fix:** Add context to the assertion message:
```python
assert len(objs) == 77, (
    f"Expected 77 ableton-dsp objects, got {len(objs)}. "
    "Update if ableton-dsp objects were added or removed."
)
```

---

### IN-04: Hardcoded package names in `test_per_package_directories`

**File:** `tests/test_package_schema.py:45`

**Issue:** `expected = ["ableton-dsp", "Mira", "jit.mo"]` is a fixed list of three packages. This doesn't validate that all `extracted: true` packages in `package_info.json` have their directories, only that these three specific ones do. New packages added to `package_info.json` aren't validated.

**Fix:** Derive the expected list from `package_info.json`:
```python
def test_per_package_directories(self, db_root):
    info = json.loads((db_root / "package_info.json").read_text())
    extracted = [k for k, v in info.items() if v.get("extracted")]
    for pkg_name in extracted:
        pkg_dir = db_root / "packages" / pkg_name
        assert pkg_dir.is_dir(), f"Extracted package '{pkg_name}' has no directory"
        assert (pkg_dir / "objects.json").exists(), f"'{pkg_name}' missing objects.json"
```

---

### IN-05: `test_list_packages_excludes_empty` hardcodes assumption BEAP and Vizzie have 0 objects

**File:** `tests/test_package_schema.py:147-148`

**Issue:** The test asserts `"BEAP" not in packages` with the comment "BEAP has 0 objects." Both BEAP and Vizzie directories exist in `packages/` on disk. If objects are ever added to either, the test fails with a misleading comment ("has 0 objects") when the real behavior changed intentionally.

**Fix:** Assert the invariant directly — packages with no objects.json or empty objects.json should not appear:
```python
def test_list_packages_excludes_empty(self, db):
    packages = db.list_packages()
    # Every listed package must have at least one object
    for pkg_name in packages:
        objs = db.get_package_objects(pkg_name)
        assert len(objs) > 0, f"list_packages() includes '{pkg_name}' but it has no objects"
```

---

### IN-06: `object_by_name` fixture crashes on missing `"name"` field with unhelpful error

**File:** `tests/conftest.py:74`

**Issue:** `{obj["name"]: obj for obj in all_objects}` raises `KeyError` if any object dict lacks a `"name"` field. This fails all tests using the fixture at setup time with a confusing traceback rather than a targeted schema error.

**Fix:**
```python
index = {}
for obj in all_objects:
    name = obj.get("name")
    if name is None:
        raise ValueError(f"Object missing 'name' field: {obj!r}")
    index[name] = obj
```

---

### IN-07: Commented-out note on monolithic file in `test_migration_completeness`

**File:** `tests/test_package_schema.py:64-65`

**Issue:** Lines 64-65 contain a comment explaining what the test intentionally does NOT check ("Monolithic file should not be loaded..."). If the monolithic `packages/objects.json` actually matters, there should be an explicit assertion for its absence rather than a comment.

**Fix:** Add the assertion or remove the comment:
```python
monolithic = db_root / "packages" / "objects.json"
assert not monolithic.exists(), (
    "Monolithic packages/objects.json must not exist — use per-package subdirectories"
)
```

---

### IN-08: `_load` reads `aliases.json` unconditionally but silently skips on missing file

**File:** `src/maxpat/db_lookup.py:51-54`

**Issue:** All supplementary files (`aliases.json`, `overrides.json`, `pd-blocklist.json`) are silently ignored if missing — no warning is emitted. A misconfigured `db_root` pointing to the wrong directory would result in an `ObjectDatabase` that appears to work but has no aliases, no overrides, and no PD protection, with no indication of the problem. This is a silent misconfiguration risk.

**Fix:** At the end of `_load`, log a warning if core supplementary files are absent:
```python
missing = [
    p.name for p in [aliases_path, overrides_path, pd_path]
    if not p.exists()
]
if missing:
    import warnings
    warnings.warn(
        f"ObjectDatabase: missing supplementary files {missing} in {db_root}. "
        "Aliases, overrides, and PD blocklist will not be applied.",
        stacklevel=3,
    )
```

---

_Reviewed: 2026-04-14T02:06:07Z_
_Reviewer: Claude (gsd-code-reviewer)_
_Depth: standard_
