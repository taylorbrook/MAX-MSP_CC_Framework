---
phase: quick-260322-pxv
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - src/maxpat/hooks.py
  - tests/test_hooks.py
autonomous: true
requirements: [CACHE-01]

must_haves:
  truths:
    - "All patch/gendsp/js file writes call os.fsync() before closing"
    - "Finder and MAX see updated file content immediately after save"
  artifacts:
    - path: "src/maxpat/hooks.py"
      provides: "_write_and_sync helper; patched save_patch_roundtrip, write_gendsp, write_js"
      contains: "_write_and_sync"
    - path: "tests/test_hooks.py"
      provides: "Tests verifying fsync is called on all write paths"
      contains: "test_write_and_sync"
  key_links:
    - from: "src/maxpat/hooks.py:save_patch_roundtrip"
      to: "_write_and_sync"
      via: "function call replaces path.write_text()"
      pattern: "_write_and_sync\\(path"
    - from: "src/maxpat/hooks.py:write_gendsp"
      to: "_write_and_sync"
      via: "function call replaces path.write_text()"
      pattern: "_write_and_sync\\(path"
    - from: "src/maxpat/hooks.py:write_js"
      to: "_write_and_sync"
      via: "function call replaces path.write_text()"
      pattern: "_write_and_sync\\(path"
---

<objective>
Fix macOS file caching issue where edited .maxpat files opened from Finder show stale content.

Purpose: `pathlib.Path.write_text()` does not call `fsync()` after writing, so macOS FSEvents may not fire and Finder/MAX may serve cached content. Adding explicit `os.fsync()` forces the kernel to flush to disk.

Output: A `_write_and_sync()` helper in hooks.py used by all three write functions, with tests.
</objective>

<execution_context>
@~/.claude/get-shit-done/workflows/execute-plan.md
@~/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@src/maxpat/hooks.py
@tests/test_hooks.py
</context>

<tasks>

<task type="auto" tdd="true">
  <name>Task 1: Add _write_and_sync helper and replace all write_text calls</name>
  <files>src/maxpat/hooks.py, tests/test_hooks.py</files>
  <behavior>
    - Test 1: _write_and_sync writes file content correctly (read back matches)
    - Test 2: _write_and_sync calls os.fsync on the file descriptor (mock os.fsync, assert called)
    - Test 3: save_patch_roundtrip uses _write_and_sync (mock _write_and_sync, save a patch, assert called)
    - Test 4: write_gendsp uses _write_and_sync (mock _write_and_sync, write gendsp, assert called)
    - Test 5: write_js uses _write_and_sync (mock _write_and_sync, write js, assert called)
  </behavior>
  <action>
    1. Add `import os` to hooks.py imports.

    2. Create `_write_and_sync(path: Path, content: str) -> None` helper function near the top of hooks.py (after imports, before `finalize_patch`):
       ```python
       def _write_and_sync(path: Path, content: str) -> None:
           """Write content to file and fsync to ensure Finder/MAX see changes."""
           fd = os.open(str(path), os.O_WRONLY | os.O_CREAT | os.O_TRUNC)
           try:
               os.write(fd, content.encode("utf-8"))
               os.fsync(fd)
           finally:
               os.close(fd)
       ```

    3. Replace `path.write_text(output)` on line 128 in `save_patch_roundtrip` with `_write_and_sync(path, output)`.

    4. Replace `path.write_text(json.dumps(gendsp_dict, indent=2))` on line 196 in `write_gendsp` with `_write_and_sync(path, json.dumps(gendsp_dict, indent=2))`.

    5. Replace `path.write_text(code)` on line 333 in `write_js` with `_write_and_sync(path, code)`.

    6. Add test class `TestWriteAndSync` in tests/test_hooks.py:
       - `test_write_and_sync_writes_content`: Call _write_and_sync, read back, assert match.
       - `test_write_and_sync_calls_fsync`: Use `unittest.mock.patch("os.fsync")` to verify fsync is called.
       - `test_save_patch_roundtrip_uses_sync`: Use `unittest.mock.patch("src.maxpat.hooks._write_and_sync")` to verify save_patch_roundtrip calls it.
       - `test_write_gendsp_uses_sync`: Same mock pattern for write_gendsp.
       - `test_write_js_uses_sync`: Same mock pattern for write_js.

    IMPORTANT: Do NOT change any other behavior. The mkdir calls stay. The indent detection stays. Only the final write_text call in each function changes.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python -m pytest tests/test_hooks.py -x -v -k "sync" 2>&1 | tail -20</automated>
  </verify>
  <done>All 5 sync tests pass. No path.write_text() calls remain in save_patch_roundtrip, write_gendsp, or write_js. Existing tests still pass.</done>
</task>

<task type="auto">
  <name>Task 2: Verify no regressions in full test suite</name>
  <files>tests/test_hooks.py</files>
  <action>
    Run the full test suite to confirm no regressions from the write path change. All existing hook tests (validate_file, read_patch, finalize_patch) must still pass. Also run tests that exercise save_patch_roundtrip indirectly (test_round_trip.py, test_project.py).
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python -m pytest tests/test_hooks.py tests/test_round_trip.py tests/test_project.py -x -v 2>&1 | tail -30</automated>
  </verify>
  <done>All existing tests pass with zero failures. The _write_and_sync helper is functionally equivalent to write_text for content, with added fsync.</done>
</task>

</tasks>

<verification>
- `grep -n "write_text" src/maxpat/hooks.py` returns zero matches in save_patch_roundtrip, write_gendsp, write_js
- `grep -n "_write_and_sync" src/maxpat/hooks.py` shows usage in all three write functions
- `python -m pytest tests/test_hooks.py -x -v` all pass
</verification>

<success_criteria>
- _write_and_sync helper exists and calls os.fsync()
- All three write functions (save_patch_roundtrip, write_gendsp, write_js) use _write_and_sync
- 5 new tests verify fsync behavior
- Zero regressions in existing tests
</success_criteria>

<output>
After completion, create `.planning/quick/260322-pxv-investigate-and-fix-patch-file-caching-i/260322-pxv-SUMMARY.md`
</output>
