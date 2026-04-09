# Phase 18: v1.x Cleanup - Research

**Researched:** 2026-03-16
**Domain:** Legacy code removal, Python module cleanup, test migration
**Confidence:** HIGH

## Summary

Phase 18 is a deletion-heavy cleanup phase that removes the v1.x generation pipeline: `incremental.py`, all `generate.py`/`build_*.py`/`gen_*.py` scripts, all `.manifest.json` sidecars, all `versions.json` files, and the `write_patch()`/`generate_patch()` functions from the public API. The .maxpat file becomes the sole artifact with no generation intermediaries.

Research confirms all deletion targets exist at the expected paths and the two-wave approach (patch artifacts first, then code modules) is sound. The test suite baseline is 1176 tests, all passing (8.91s). Removing `test_incremental.py` deletes 25 tests. However, **removing `write_patch` and `generate_patch` has significant cascading impact** beyond what the CONTEXT.md decisions describe: 28 tests in `test_generation.py`, 27 tests in `test_hooks.py`, and 1 test in `test_codegen.py` directly import these functions. Additionally, 8+ agent SKILL.md files and the `/max-build` slash command reference them. The planner must account for this impact.

**Primary recommendation:** Execute Wave 1 (delete patch artifacts) as a clean deletion with no code changes. Execute Wave 2 as a carefully sequenced set of changes: delete `incremental.py` and `test_incremental.py` first, then update `__init__.py` and `hooks.py`, then update or remove affected tests in `test_generation.py`/`test_hooks.py`/`test_codegen.py`, then update SKILL.md files and slash commands. Verify CI green after each step.

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions
- Delete test_incremental.py outright -- its 23 tests cover merge logic that no longer exists
- test_round_trip.py's 31 tests are sufficient coverage for the replacement read-write path
- No new tests needed to cover gaps -- no gap is created by removing tests for deleted code
- Claude handles finding and cleaning up any references to incremental/Manifest/merge_and_write in other test files
- Remove write_patch() entirely -- v2.0 commands use write_patch_direct/save_patch_roundtrip
- Remove generate_patch() entirely -- it was the old pipeline orchestrator (layout + validate + serialize)
- Keep write_patch_direct and validate_and_write as-is -- both serve distinct v2.0 purposes and are referenced by agent SKILL.md files
- Clean up __init__.py: remove Manifest, merge_and_write, generate_patch, write_patch from __all__ and imports -- no deprecation shims, direct removal
- Delete ALL Python scripts from patch directories: build_*.py, generate.py, and gen_*.py
- Delete all 6 .manifest.json sidecar files
- Delete all 7 versions.json files
- Keep generated/ subdirectory structure -- .maxpat files stay in place
- Clean up __pycache__ files for removed modules
- Two-wave approach, CI green after each:
  - Wave 1: Delete all patch artifacts (scripts, manifests, versions.json)
  - Wave 2: Delete incremental.py, clean __init__.py exports, remove write_patch/generate_patch from hooks.py, delete test_incremental.py
- Claude checks .gitignore and project config for stale patterns referencing removed artifacts
- Update .planning/ docs (ARCHITECTURE.md, SUMMARY.md, etc.) to reflect removed artifacts

### Claude's Discretion
- Exact .gitignore cleanup (if any stale patterns exist)
- Which .planning/ doc references to update and how
- Any additional stale references discovered during cleanup

### Deferred Ideas (OUT OF SCOPE)
None -- discussion stayed within phase scope
</user_constraints>

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|-----------------|
| CL-01 | incremental.py module removed -- manifest-based merge system eliminated | File confirmed at `src/maxpat/incremental.py` (475 lines). Manifest class, merge_and_write, load_existing_patch all live here. Import in `__init__.py` line 66. Referenced by test_incremental.py only (no other src/ files import it). |
| CL-02 | All .manifest.json sidecar files removed from existing patches | 6 files confirmed: kicksynth, minitaur, performancepatchtest, rhythmic-sampler/slot, scala-synth (2). No code reads these at runtime. |
| CL-03 | All generate.py scripts removed from existing patches -- .maxpat files are standalone | 8 scripts confirmed: 2 generate.py, 4 build_*.py, 2 gen_*.py. Plus 7 versions.json. No runtime imports from these. |
| CL-04 | Test suite updated -- read path covered, write-only assumptions replaced with read-write tests, expand-then-contract migration keeps CI green throughout | test_round_trip.py has 31 tests covering from_dict/to_dict. test_incremental.py (25 tests) targets deleted code. **Critical: test_generation.py (28 tests) and test_hooks.py (27 tests) heavily use generate_patch/write_patch.** |
| CL-05 | hooks.py updated -- write_patch uses direct save path, merge_and_write removed or redirected | write_patch is in hooks.py (lines 120-180). generate_patch is in __init__.py (lines 90-136). Both must be removed per CONTEXT.md. |
</phase_requirements>

## Standard Stack

### Core
| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| Python | 3.14 | Runtime | Project's Python version |
| pytest | 9.0.2 | Test framework | Already in use, 1176 tests passing |
| json (stdlib) | N/A | .maxpat file I/O | Only dependency for patch read/write |
| pathlib (stdlib) | N/A | File path operations | Used throughout codebase |

### No New Dependencies
This phase adds zero new libraries. It only removes code and files.

## Architecture Patterns

### Deletion Inventory (Verified)

#### Wave 1: Patch Artifacts (no code imports these)
```
patches/minitaur/generate.py
patches/performancepatchtest/generate.py
patches/performancepatchtest/generated/build_compressor.py
patches/rhythmic-sampler/generated/build_slot.py
patches/scala-synth/generated/build_scala_synth.py
patches/kicksynth/generated/build_kicksynth.py
patches/FDNVerb/generated/gen_FDNVerb.py
patches/rhythmic-sampler/generated/gen_rhythmic_sampler.py
patches/performancepatchtest/generated/performancepatchtest.manifest.json
patches/minitaur/generated/minitaur.manifest.json
patches/kicksynth/generated/kicksynth.manifest.json
patches/scala-synth/generated/scala-synth-voice.manifest.json
patches/scala-synth/generated/scala-synth.manifest.json
patches/rhythmic-sampler/generated/slot.manifest.json
patches/FDNVerb/versions.json
patches/granularsynthtest/versions.json
patches/scala-synth/versions.json
patches/kicksynth/versions.json
patches/performancepatchtest/versions.json
patches/minitaur/versions.json
patches/rhythmic-sampler/versions.json
```
**Total: 21 files**

#### Wave 2: Code and Tests
```
src/maxpat/incremental.py              (475 lines -- Manifest, merge_and_write, load_existing_patch)
tests/test_incremental.py              (572 lines -- 25 tests)
src/maxpat/__init__.py                 (line 66: import; lines 199-200: __all__; lines 90-136: generate_patch def)
src/maxpat/hooks.py                    (lines 120-180: write_patch def)
```

### Current __init__.py Exports to Remove
```python
# Line 66 -- import to remove:
from src.maxpat.incremental import Manifest, merge_and_write

# Lines 90-136 -- function to remove:
def generate_patch(patcher, layout_options=None): ...

# Lines 199-200 -- __all__ entries to remove:
"Manifest",
"merge_and_write",

# Line 146 -- __all__ entry to remove:
"generate_patch",

# Line 148 -- __all__ entry to remove:
"write_patch",

# Line 23 -- import to remove:
write_patch,
```

### Current hooks.py Functions to Remove
```python
# Lines 120-180 -- write_patch() function definition
def write_patch(patcher, path, validate=True, layout_options=None): ...
```

### Functions to KEEP in hooks.py
```python
detect_indent()           # Used by save_patch_roundtrip
save_patch_roundtrip()    # v2.0 round-trip save path
read_patch()              # v2.0 load path
write_gendsp()            # GenExpr file writer
write_js()                # JavaScript file writer
validate_file()           # On-disk validation
validate_code_file()      # Code file validation
PatchGenerationError      # Exception class
PatchValidationError      # Exception class
```

### Cascade Impact: Tests That Use Removed Functions

**test_hooks.py (27 tests):**
- `test_public_api_importable` -- imports `generate_patch, write_patch` (needs update)
- `test_generate_patch_returns_dict_and_results` -- calls `generate_patch` (needs removal or rewrite)
- `test_generate_patch_applies_layout` -- calls `generate_patch` (needs removal or rewrite)
- `test_generate_patch_runs_validation` -- calls `generate_patch` (needs removal or rewrite)
- `test_write_patch_creates_file` through `test_write_patch_backward_compat` -- 8 tests calling `write_patch` (needs removal or rewrite)
- `test_validate_file_*` -- 3 tests (one uses write_patch as setup) (needs update)
- `test_write_patch_forwards_layout_options` through `test_write_patch_backward_compat` -- 3 tests (needs removal or rewrite)
- `TestReadPatch` class (11 tests) -- does NOT use write_patch/generate_patch, KEEP as-is

**test_generation.py (28 tests):**
- Nearly all tests import and call `generate_patch` for end-to-end pipeline testing
- `test_write_and_validate` imports `write_patch`
- `TestFullPipeline.test_full_pipeline` imports both `generate_patch` and `write_patch`
- `TestAutoStyling` (6 tests) -- all use `generate_patch` to verify auto-styling

**test_codegen.py (1 test):**
- `test_add_gen_generate_patch` -- calls `generate_patch`

**Total tests directly affected: ~40-45 tests (beyond the 25 in test_incremental.py)**

### Cascade Impact: SKILL.md and Command Files

**Slash commands referencing removed functions:**
- `.claude/commands/max-build.md` lines 39, 47, 63: `generate_patch`, `write_patch`

**SKILL.md files referencing removed functions:**
| File | References |
|------|------------|
| max-patch-agent/SKILL.md | `generate_patch` (line 46), `write_patch` (lines 47, 138) |
| max-dsp-agent/SKILL.md | `generate_patch` (lines 73, 87, 93, 130), `write_patch` (line 134) |
| max-ui-agent/SKILL.md | `generate_patch` (lines 46, 83, 103), `write_patch` (line 46) |
| max-js-agent/SKILL.md | `generate_patch` (lines 67, 87) |
| max-ext-agent/SKILL.md | `generate_patch` (lines 31, 51) |
| max-rnbo-agent/SKILL.md | `generate_patch` (lines 28, 48), `write_patch` (lines 78, 120) |
| max-lifecycle/references/project-structure.md | `write_patch` (line 75) |

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| File deletion | Manual rm commands | `git rm` for tracked files, `rm` for untracked | git rm updates index cleanly |
| __pycache__ cleanup | Manual find-and-delete | `find patches/ -name __pycache__ -type d -exec rm -rf {} +` | Recursive cleanup |
| Import reference finding | Manual grep | `grep -rn` across src/ and tests/ | Must verify zero remaining references |

## Common Pitfalls

### Pitfall 1: Removing write_patch/generate_patch Breaks 40+ Tests
**What goes wrong:** Deleting `write_patch` from hooks.py and `generate_patch` from __init__.py causes ImportError in test_generation.py (28 tests), test_hooks.py (16 tests), and test_codegen.py (1 test).
**Why it happens:** These tests were written to test the v1.x creation pipeline which used `generate_patch` and `write_patch`. The CONTEXT.md says to remove these, but the test cascade was scoped only to test_incremental.py.
**How to avoid:** Must either (a) remove or rewrite all tests that import these functions, or (b) keep the functions while removing only the incremental/manifest parts. The CONTEXT.md decision is clear: remove them. So ~45 tests need deletion or rewriting.
**Warning signs:** `ImportError: cannot import name 'generate_patch' from 'src.maxpat'` in CI.

### Pitfall 2: SKILL.md and Command Files Reference Removed Functions
**What goes wrong:** After removing `generate_patch` and `write_patch`, the agent SKILL.md files and `/max-build` command still reference these functions. Agents following their SKILL.md would generate code that fails at runtime.
**Why it happens:** Phase 17 updated SKILL.md files to add the v2.0 editing workflow but kept the v1.x creation workflow references alongside.
**How to avoid:** Update all SKILL.md files: replace `generate_patch(patcher)` + `write_patch(patcher, path)` with the equivalent direct calls (apply_layout + _apply_auto_styling + validate + to_dict + save_patch_roundtrip or json.dumps). Update `/max-build` command.
**Warning signs:** Agents producing code with `from src.maxpat import generate_patch` that fails.

### Pitfall 3: write_patch_direct and validate_and_write Do Not Exist
**What goes wrong:** CONTEXT.md says "Keep write_patch_direct and validate_and_write as-is" but these functions do not exist anywhere in the codebase.
**Why it happens:** The discussion may have used these names to refer to conceptual functions that were never created, or may have been naming `save_patch_roundtrip` and `validate_file` differently.
**How to avoid:** The planner should interpret this as: keep `save_patch_roundtrip` (the v2.0 round-trip save path) and `validate_and_write` as concepts, not literal function names. The actual functions to keep are: `save_patch_roundtrip()`, `read_patch()`, `validate_file()`, `write_gendsp()`, `write_js()`.
**Warning signs:** Searching for `write_patch_direct` returns zero results.

### Pitfall 4: generate_patch's _apply_auto_styling Functionality Lost
**What goes wrong:** `generate_patch()` currently applies auto-styling (canvas background, dac~/loadbang highlights) before layout. If removed entirely, new patch creation loses these aesthetic defaults.
**Why it happens:** `generate_patch` bundles 4 steps: auto-styling, layout, serialization, validation. Removing it removes auto-styling from the creation pipeline.
**How to avoid:** The `_apply_auto_styling` helper function should remain in `__init__.py` (it's private, not exported). Agent SKILL.md "New Patches" workflow should call it explicitly: `from src.maxpat import _apply_auto_styling; _apply_auto_styling(patcher)` before layout. Or the SKILL.md can document the manual steps.
**Warning signs:** New patches lack canvas background color and dac~/loadbang highlights.

### Pitfall 5: Stale __pycache__ Files After Module Deletion
**What goes wrong:** Deleting `incremental.py` leaves behind `__pycache__/incremental.cpython-314.pyc` which can cause confusing import behavior.
**Why it happens:** Python's import cache persists bytecode files.
**How to avoid:** Delete `src/maxpat/__pycache__/incremental.cpython-314.pyc` and `tests/__pycache__/test_incremental.cpython-314-pytest-9.0.2.pyc` explicitly. Check git status for these.
**Warning signs:** `__pycache__` entries in git status.

### Pitfall 6: .gitignore Has No Stale Patterns (Non-Issue)
**What goes wrong:** N/A -- no .gitignore file exists in the project root. File operations targeting .gitignore cleanup can be skipped.
**Why it happens:** Project does not use .gitignore (all files managed explicitly or via global gitignore).
**How to avoid:** Skip .gitignore cleanup step. No action needed.

## Code Examples

### Pattern: Safe Module Deletion Sequence
```python
# 1. Verify no remaining imports of the module
# grep -rn "from src.maxpat.incremental" src/ tests/
# grep -rn "import incremental" src/ tests/

# 2. Remove from __init__.py __all__ list
# Remove: "Manifest", "merge_and_write"

# 3. Remove import statement
# Remove: from src.maxpat.incremental import Manifest, merge_and_write

# 4. Delete the file
# git rm src/maxpat/incremental.py

# 5. Delete the test file
# git rm tests/test_incremental.py

# 6. Clean __pycache__
# rm -f src/maxpat/__pycache__/incremental.cpython-314.pyc
# rm -f tests/__pycache__/test_incremental.cpython-314-pytest-9.0.2.pyc
```

### Pattern: Updated __init__.py (After Cleanup)
```python
# Imports to keep (hooks.py):
from src.maxpat.hooks import (
    write_gendsp,
    write_js,
    validate_file,
    validate_code_file,
    detect_indent,
    save_patch_roundtrip,
    read_patch,
    PatchGenerationError,
    PatchValidationError,
)

# _apply_auto_styling stays as private helper (not in __all__)
# generate_patch function definition removed
# write_patch import removed
# Manifest, merge_and_write import removed
```

### Pattern: Test Cleanup for Removed Functions
```python
# Tests that ONLY test write_patch behavior -> DELETE
# Tests that ONLY test generate_patch behavior -> DELETE
# Tests that use write_patch as setup for validate_file -> REWRITE to use save_patch_roundtrip
# Tests in TestReadPatch class -> KEEP (no dependency on removed functions)
# Tests in test_generation.py for layout/validation -> KEEP if rewritten to call components directly
```

## State of the Art

| Old Approach (v1.x) | Current Approach (v2.0) | When Changed | Impact |
|---------------------|-------------------------|--------------|--------|
| `generate.py` scripts build Patcher | Agents call Patcher methods directly | Phase 17 (commands) | No more intermediary scripts |
| `merge_and_write()` preserves user edits | `read_patch()` + edit + `save_patch_roundtrip()` | Phase 13 (round-trip) | No manifest tracking needed |
| `.manifest.json` tracks ownership | No ownership tracking -- .maxpat is source of truth | Phase 13 | Sidecar files obsolete |
| `write_patch()` = layout + validate + write | `save_patch_roundtrip()` = indent-preserving write | Phase 13 | Direct save, no layout recompute |
| `generate_patch()` = styling + layout + validate + serialize | Individual steps called as needed | Phase 15+ | More control, less coupling |

## Open Questions

1. **What replaces generate_patch/write_patch in the "New Patches" creation workflow?**
   - What we know: `save_patch_roundtrip` handles the save step. `_apply_auto_styling`, `apply_layout`, `validate_patch` handle the other steps individually. The SKILL.md "New Patches" output protocol would need to call these individually.
   - What's unclear: Should the planner create a replacement convenience function, or should SKILL.md files document the individual steps? CONTEXT.md says "direct removal" with no deprecation shims.
   - Recommendation: Update SKILL.md "New Patches" output protocol to call `_apply_auto_styling(patcher)`, `apply_layout(patcher)`, `validate_patch(patcher.to_dict())`, then `save_patch_roundtrip(patcher.to_dict(), path)`. No new convenience function -- the explicit steps are clearer.

2. **How many tests survive Wave 2?**
   - What we know: Current baseline is 1176 tests. Removing test_incremental.py drops 25. Removing write_patch/generate_patch-dependent tests drops ~45 more.
   - What's unclear: Which test_generation.py tests test behaviors worth preserving (e.g., auto-styling, layout, validation warnings) vs. which just test the pipeline orchestration that's being removed?
   - Recommendation: The 6 auto-styling tests and the validation warning test cover real behaviors. These should be rewritten to call `_apply_auto_styling` + `apply_layout` + `patcher.to_dict()` + `validate_patch()` directly rather than through `generate_patch`. The 10 test_hooks.py write_patch tests can be deleted (write_patch is being removed). Keep TestReadPatch (11 tests) unchanged.

3. **What about patches/.active-project.json?**
   - What we know: Contains `{"name": "minitaur", "activated": "..."}`. This is a runtime project state file, not a v1.x artifact.
   - Recommendation: Leave unchanged. Not a cleanup target.

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | pytest 9.0.2 |
| Config file | pyproject.toml or pytest.ini (standard discovery) |
| Quick run command | `python3 -m pytest tests/ -x -q` |
| Full suite command | `python3 -m pytest tests/ -q` |

### Phase Requirements -> Test Map
| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| CL-01 | incremental.py fully removed, no imports remain | smoke | `python3 -c "import src.maxpat; assert not hasattr(src.maxpat, 'Manifest')"` | Wave 0: needs verification script |
| CL-02 | No .manifest.json files exist | smoke | `test -z "$(find patches/ -name '*.manifest.json')"` | Wave 0 |
| CL-03 | No generate.py/build_*.py/gen_*.py in patches/ | smoke | `test -z "$(find patches/ -name 'generate.py' -o -name 'build_*.py' -o -name 'gen_*.py')"` | Wave 0 |
| CL-04 | Test suite passes with read-write coverage | unit+integration | `python3 -m pytest tests/ -q` | Existing (1176 tests baseline, will shrink to ~1100+) |
| CL-05 | hooks.py has no write_patch, no merge_and_write | smoke | `python3 -c "from src.maxpat import hooks; assert not hasattr(hooks, 'write_patch')"` | Wave 0 |

### Sampling Rate
- **Per task commit:** `python3 -m pytest tests/ -x -q` (stop at first failure)
- **Per wave merge:** `python3 -m pytest tests/ -q` (full suite)
- **Phase gate:** Full suite green + no .manifest.json + no generate.py + no incremental.py imports

### Wave 0 Gaps
- None -- existing test infrastructure covers all phase requirements. No new test files needed. The phase REMOVES tests rather than adding them.

## Sources

### Primary (HIGH confidence)
- Direct codebase analysis of all files in `src/maxpat/`, `tests/`, `patches/`, `.claude/skills/`, `.claude/commands/`
- `grep`/`glob` search results for all deletion targets and cross-references
- Full test suite run: 1176 tests, all passing, 8.91s baseline
- CONTEXT.md locked decisions

### Secondary (MEDIUM confidence)
- ARCHITECTURE.md and SUMMARY.md from `.planning/research/` (historical documentation, may be slightly stale)

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH -- no new dependencies, all existing Python stdlib
- Architecture: HIGH -- all deletion targets verified by file existence and grep
- Pitfalls: HIGH -- all cascade impacts verified by grep across entire codebase
- Test impact: HIGH -- test counts verified by `pytest --co -q` collection

**Research date:** 2026-03-16
**Valid until:** 2026-04-16 (stable -- deletion phase, no moving targets)
