# Deferred Items - Phase 08

## Pre-existing Test Failure

- **Test:** `tests/test_codegen.py::TestGenBox::test_add_gen_creates_box`
- **Issue:** Uncommitted changes to `src/maxpat/patcher.py` cause `box.maxclass` to return `"newobj"` instead of `"gen~"`
- **Scope:** Not caused by Phase 8 changes. Pre-existing uncommitted modifications.
- **Discovered during:** Plan 08-03 execution
