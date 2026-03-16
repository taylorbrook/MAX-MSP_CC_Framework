# Phase 18: v1.x Cleanup - Context

**Gathered:** 2026-03-16
**Status:** Ready for planning

<domain>
## Phase Boundary

Remove the old v1.x generation pipeline entirely. Delete incremental.py, all generate.py/build_*.py/gen_*.py scripts, all .manifest.json sidecars, all versions.json files, and clean up hooks.py and __init__.py exports. The .maxpat file becomes the sole artifact with no generation intermediaries.

</domain>

<decisions>
## Implementation Decisions

### Test migration
- Delete test_incremental.py outright -- its 23 tests cover merge logic that no longer exists
- test_round_trip.py's 31 tests are sufficient coverage for the replacement read-write path
- No new tests needed to cover gaps -- no gap is created by removing tests for deleted code
- Claude handles finding and cleaning up any references to incremental/Manifest/merge_and_write in other test files

### hooks.py write path
- Remove write_patch() entirely -- v2.0 commands use write_patch_direct/save_patch_roundtrip
- Remove generate_patch() entirely -- it was the old pipeline orchestrator (layout + validate + serialize)
- Keep write_patch_direct and validate_and_write as-is -- both serve distinct v2.0 purposes and are referenced by agent SKILL.md files
- Clean up __init__.py: remove Manifest, merge_and_write, generate_patch, write_patch from __all__ and imports -- no deprecation shims, direct removal

### Generate script handling
- Delete ALL Python scripts from patch directories: build_*.py, generate.py, and gen_*.py -- all are v1.x artifacts
- Delete all 6 .manifest.json sidecar files -- they served the incremental merge system
- Delete all 7 versions.json files -- they tracked generator versions, irrelevant with direct editing
- Keep generated/ subdirectory structure -- .maxpat files stay in place, MAX project references preserved
- Clean up __pycache__ files for removed modules

### Removal sequencing
- Two-wave approach, CI green after each:
  - Wave 1: Delete all patch artifacts (scripts, manifests, versions.json) -- no code imports these
  - Wave 2: Delete incremental.py, clean __init__.py exports, remove write_patch/generate_patch from hooks.py, delete test_incremental.py -- single atomic commit
- Claude checks .gitignore and project config for stale patterns referencing removed artifacts
- Update .planning/ docs (ARCHITECTURE.md, SUMMARY.md, etc.) to reflect removed artifacts

### Claude's Discretion
- Exact .gitignore cleanup (if any stale patterns exist)
- Which .planning/ doc references to update and how
- Any additional stale references discovered during cleanup

</decisions>

<specifics>
## Specific Ideas

No specific requirements -- standard cleanup with clear deletion targets.

</specifics>

<code_context>
## Existing Code Insights

### Deletion targets
- `src/maxpat/incremental.py` (475 lines): Manifest class, merge_and_write, load_existing_patch
- `tests/test_incremental.py` (572 lines): 23 incremental merge tests
- `src/maxpat/__init__.py`: exports Manifest, merge_and_write (lines 66, 200)
- `src/maxpat/hooks.py`: write_patch() calling generate_patch()
- Patch scripts: kicksynth/build_kicksynth.py, minitaur/generate.py, performancepatchtest/generate.py + build_compressor.py, rhythmic-sampler/build_slot.py + gen_rhythmic_sampler.py, scala-synth/build_scala_synth.py, FDNVerb/gen_FDNVerb.py
- Manifests: 6 .manifest.json files across kicksynth, minitaur, performancepatchtest, rhythmic-sampler (slot), scala-synth (2)
- Metadata: 7 versions.json across all patch directories

### Preserved assets
- `write_patch_direct()` in hooks.py -- the v2.0 write path
- `validate_and_write()` in hooks.py -- validate then write
- `save_patch_roundtrip()` in patcher.py -- round-trip save
- `test_round_trip.py` (31 tests) -- covers the read-write path
- All .maxpat files in generated/ directories -- untouched

### Integration points
- `src/maxpat/__init__.py` -- public API surface needs 4 exports removed
- Agent SKILL.md files -- already updated in Phase 17 to reference v2.0 API
- .planning/ research docs -- historical references to update

</code_context>

<deferred>
## Deferred Ideas

None -- discussion stayed within phase scope

</deferred>

---

*Phase: 18-v1-x-cleanup*
*Context gathered: 2026-03-16*
