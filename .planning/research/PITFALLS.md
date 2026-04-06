# Domain Pitfalls: v2.0 Direct .maxpat Editing

**Domain:** Refactoring from Python generation pipeline to direct .maxpat reading/editing
**Researched:** 2026-03-15
**Confidence:** HIGH for round-trip data loss and ID scoping (verified against actual codebase and .maxpat files), HIGH for test migration (verified against 913 existing tests), MEDIUM for MAX-internal metadata handling (no official .maxpat spec exists)

## Critical Pitfalls

Mistakes that cause rewrites, data loss, or major regressions.

### Pitfall 1: Round-Trip Data Loss in from_dict/to_dict

**What goes wrong:** Loading a .maxpat with `Patcher.from_dict()` and writing it back with `to_dict()` silently drops attributes that MAX or the user added. Verified bugs in the current codebase:

1. **Patchline extra attributes lost.** `Patchline.to_dict()` only serializes `source`, `destination`, `order`, `hidden`, and `midpoints`. MAX adds `color` (per-cable coloring) and potentially other attributes to patchlines. These are silently dropped during round-trip. The `Patchline.__init__` has no `extra_attrs` mechanism.

2. **parameter_enable handled but conditionally re-emitted.** `from_dict()` lists `parameter_enable` in `_handled_keys`, stripping it from `extra_attrs`. But `Box.to_dict()` only emits `parameter_enable` for certain maxclass branches (UI objects that aren't `newobj`/`comment`/`message`). For edge cases where a newobj-based box has `parameter_enable`, it could be lost.

3. **bpatcher attributes not reconstructed.** `from_dict()` doesn't set `box._bpatcher_attrs` for loaded bpatcher boxes. The bpatcher-specific keys (`args`, `bgmode`, `border`, `clickthrough`, `enablehscroll`, `enablevscroll`, `lockeddragscroll`, `offset`, `viewvisibility`, `name`) end up in `extra_attrs` instead of `_bpatcher_attrs`. This means `Box.to_dict()` emits them via `extra_attrs` rather than the dedicated `_bpatcher_attrs` path, which works but is structurally inconsistent and could cause issues if code checks `_bpatcher_attrs is not None`.

**Why it happens:** The current `from_dict()` was built as a minimal read path for `merge_and_write()`. It reconstructs enough structure to identify boxes by ID, but never aimed for lossless round-trip fidelity. The write path (`to_dict()`) was designed for generation, not for re-serializing loaded data.

**Consequences:** Silent data corruption when loading a user's patch, editing it, and writing it back. The user opens their patch in MAX and discovers cable colors are gone, parameter mappings are broken, or bpatcher references behave differently. Worst case: the patch loads in MAX but sounds or behaves differently because a parameter_enable flag was dropped, causing gain~ to lose its parameter mapping.

**Prevention:**
- Add comprehensive round-trip tests before any refactoring: load real .maxpat files (including MAX-saved ones with extra metadata), round-trip through from_dict/to_dict, and diff the JSON
- Add `extra_attrs` dict to `Patchline` class, same pattern as `Box`
- Make `from_dict()` treat ALL unknown keys as extra_attrs (for both Box and Patchline)
- Make `to_dict()` emit all extra_attrs without filtering
- Golden rule: **if a key exists in the input JSON, it must exist in the output JSON**

**Detection:** Round-trip diff tests. Load a .maxpat, serialize back, compare JSON structure key-by-key. Any key present in original but absent in output is a bug.

**Phase:** Must be fixed in Phase 1 (Patcher library refactoring) before any direct editing code is written.

### Pitfall 2: Dual Source of Truth During Migration

**What goes wrong:** During the transition period, some patches still use `generate.py` while others use direct editing. An agent or skill file references the old `generate_patch()` / `write_patch()` / `merge_and_write()` pipeline for a patch that has been migrated to direct editing, or vice versa. The result: competing modifications where the generation pipeline overwrites direct edits, or direct edits are made to a patch that's still being regenerated.

This exact problem already happened in the project's history (documented in memory: `feedback_iterate_via_generator.md`): "subpatcher open buttons and comp-band bpatchers were lost" because changes were made directly to the .maxpat instead of through generate.py.

**Why it happens:** The project has 6 agent SKILL.md files, 10 slash commands, and multiple generate.py scripts across patches. All of them reference the generation pipeline API. During a phased migration, some will be updated and some won't, creating an inconsistent state where the system doesn't know whether a given patch is "generated" or "directly edited."

**Consequences:** User loses manual work when an agent runs a stale generate.py. Or: an agent tries to directly edit a patch that's still managed by a generation script, and the next regeneration wipes the edit. The user experience is unpredictable -- sometimes changes stick, sometimes they vanish.

**Prevention:**
- Add a clear marker to each patch project directory: either a `generate.py` exists (old pipeline) or it doesn't (new direct-edit mode)
- Detect and fail-fast: if a direct-edit operation is attempted on a patch with a `generate.py`, warn the user
- Migrate patches atomically: remove `generate.py` + manifest at the same time as switching the agent workflow
- Update all 6 SKILL.md files simultaneously, not incrementally
- Add a "mode" field to `.active-project.json` or equivalent: `"editing_mode": "direct"` vs `"editing_mode": "generated"`

**Detection:** Pre-edit check: does this patch directory contain a `generate.py`? If yes, refuse direct edits. If no, refuse generation-pipeline operations.

**Phase:** Must be addressed in Phase 2 (agent/skill migration) with a clear migration gate.

### Pitfall 3: ID Collision When Adding Objects to Existing Patches

**What goes wrong:** Adding new objects to a loaded patch creates box IDs that collide with existing ones. The current `Patcher._gen_id()` generates sequential IDs (`obj-1`, `obj-2`, ...). When loading an existing patch, `from_dict()` sets `_next_id` to `max_id_num + 1`, which works IF all existing IDs follow the `obj-N` pattern. But:

1. **MAX can renumber IDs when saving.** If a user opens and saves a patch in MAX, MAX may renumber some box IDs, potentially creating gaps or non-sequential numbers.

2. **Subpatcher IDs are scoped per patcher level** (verified: subpatcher inner objects reuse `obj-1`, `obj-2`, etc., independent of parent). The current `from_dict()` tracks only top-level max ID. Adding objects to an inner patcher loaded via `from_dict()` could collide if the inner `_next_id` isn't set correctly.

3. **User-created IDs might not follow `obj-N` pattern.** If a user creates objects via MAX's scripting interface or a third-party tool, IDs could be arbitrary strings. The `int(box.id.split("-")[-1])` extraction in `from_dict()` would silently fail and not advance `_next_id` past these.

**Why it happens:** The ID generation system was designed for write-only workflows where the generator controls all IDs from scratch. It doesn't account for the read-then-modify workflow where IDs come from an external source.

**Consequences:** Duplicate IDs within a patcher level. MAX may fail to load the patch, or worse, load it but route connections incorrectly (connecting to the wrong box because two boxes share an ID).

**Prevention:**
- After `from_dict()`, scan ALL box IDs (including nested subpatchers) and set `_next_id` to one past the global maximum
- Handle non-numeric IDs: track all existing ID strings in a set, generate IDs that don't collide
- When adding objects to a loaded patcher, verify the new ID doesn't exist in the current box list
- Add a `_used_ids: set[str]` field to Patcher that gets populated during `from_dict()` and checked during `_gen_id()`
- Test: load a patch with gaps in ID sequence, add objects, verify no collisions

**Detection:** Validation check after any add_box call on a loaded patcher: assert no two boxes share an ID at the same patcher level.

**Phase:** Must be fixed in Phase 1 alongside from_dict improvements.

### Pitfall 4: Breaking 283 Patcher-Related Tests During Migration

**What goes wrong:** The existing 913 tests (283 in patcher-related files) all assume the write-only API. Changing `Patcher`, `Box`, or `Patchline` classes to support read-write operations risks breaking these tests in subtle ways:

1. **Tests that check exact `to_dict()` output** will break if new fields are added to support round-trip fidelity (e.g., adding `extra_attrs` to Patchline changes its serialization).

2. **Tests that rely on deterministic IDs** (`obj-1`, `obj-2`) will break if ID generation logic changes to accommodate loaded patches.

3. **Tests that use `Box.__new__(Box)` bypass** (structural objects like subpatchers, gen~ codebox) -- there are at least 8 such patterns in the generation scripts. These manually set all fields. If new fields are added to Box (like `_used_ids`), these bypasses won't set them, causing AttributeError.

4. **Tests in `test_incremental.py`** (23 tests) test the manifest-based merge workflow. If the migration removes manifests, all these tests become invalid.

**Why it happens:** Write-only tests assert specific output shapes. Making the system read-write changes what constitutes valid output (more keys preserved, different serialization paths).

**Consequences:** Test suite goes red, blocking CI. Team spends time updating tests instead of building features. Risk of "fixing" tests by weakening assertions rather than fixing actual bugs.

**Prevention:**
- Run test suite BEFORE starting any refactoring, save as baseline
- Categorize tests: (a) structural tests that should survive unchanged, (b) output-shape tests that need updating, (c) generation-pipeline tests that should be replaced
- Use the "expand, then contract" pattern: add new read-write capabilities without removing old ones first, then deprecate old paths after new ones are tested
- Add new tests for the read path BEFORE modifying existing code
- For `Box.__new__(Box)` bypasses: add a `Box._init_defaults()` classmethod that sets all required fields, then use it in both `__init__` and bypass patterns
- Keep `test_incremental.py` tests passing until manifests are explicitly removed; don't break them as a side effect

**Detection:** CI must stay green throughout migration. Any test breakage is a signal to pause and fix before continuing.

**Phase:** Addressed throughout all phases -- each phase must maintain green CI.

## Moderate Pitfalls

### Pitfall 5: Losing MAX-Internal Metadata That Affects Behavior

**What goes wrong:** MAX adds metadata to .maxpat files that affects runtime behavior but isn't part of the "user-visible" patch structure. Examples found in real patches:

- `editing_bgcolor` / `locked_bgcolor`: Canvas colors for edit vs locked mode (affects visual appearance)
- `saved_attribute_attributes`: Parameter mapping data (affects DAW integration, M4L parameter exposure)
- `dependency_cache`: MAX's record of required externals (affects loading in standalone builds)
- `varname`: Scripting name for pattr/autopattr (affects state saving)
- `parameter_mappable`: Whether a parameter can be mapped to MIDI/automation
- `saved_object_attributes` on subpatcher boxes: `globalpatchername`, `description`, etc.

**Why it happens:** The .maxpat format has no official specification (confirmed by Cycling '74 forum posts). MAX adds keys silently based on user actions (naming an object, enabling parameter mode, etc.). Without documentation, there's no way to enumerate all possible keys.

**Prevention:**
- Adopt a whitelist-inversion strategy: instead of listing known keys and dropping the rest, preserve ALL keys and only specifically handle the ones you need to modify
- The `extra_attrs` pattern on Box already does this correctly -- extend it to Patchline and to patcher-level props
- Never delete a key from loaded JSON unless explicitly instructed by the user
- Test with patches that have been opened and saved by MAX (not just generator-produced patches)

**Detection:** Create a "MAX-saved patch" test fixture: take a generated patch, open it in MAX, move some objects, save it, then use the MAX-saved version as a round-trip test fixture. Any key loss between original and round-tripped version is a bug.

**Phase:** Phase 1 (Patcher library refactoring).

### Pitfall 6: Over-Engineering the Read Path

**What goes wrong:** Building a full "patch understanding" system when all that's needed is surgical editing. Examples of over-engineering:

1. **Building a complete object graph from loaded patches.** The direct-edit workflow only needs to find objects by ID or text, modify attributes, and add/remove objects. Building adjacency graphs, topological sorts, or signal flow analysis of LOADED patches is unnecessary -- the layout engine already handles that for NEW patches.

2. **Validating loaded patches against the object database.** Loaded patches may contain objects from packages, third-party externals, or MAX versions newer than the database covers. Validating loaded patches would produce false-positive errors. Validation should only apply to objects the tool adds, not to objects that already exist and work.

3. **Rebuilding Box objects with full DB lookup from loaded data.** The current `from_dict()` uses `Box.__new__()` to bypass DB validation, which is correct. Over-engineering would be to validate every loaded object against the DB and reject patches with unknown objects.

**Why it happens:** The generation pipeline has a thorough validation system (4-layer pipeline, 913 tests). There's a natural temptation to apply the same rigor to the read path. But the read path's contract is different: the patch already works in MAX, the tool just needs to make targeted modifications without breaking it.

**Prevention:**
- Define the read path's contract clearly: "preserve everything, modify only what's explicitly requested"
- Validation applies to ADDED objects only, not loaded ones
- Layout applies to ADDED objects only (or explicitly requested re-layout)
- Keep `from_dict()` as a thin JSON-to-objects mapper, not a patch analyzer
- The existing `Box.__new__()` bypass pattern for loaded objects is correct -- don't replace it with DB-validated construction

**Detection:** Code review question: "Does this read-path code need to understand the patch's semantics, or just its structure?" If the answer is semantics, it's probably over-engineering.

**Phase:** Phase 1 design decision, enforced throughout.

### Pitfall 7: JSON Key Ordering Sensitivity

**What goes wrong:** When writing .maxpat files, the key ordering in JSON matters for readability and diff-friendliness, but may also matter for MAX in edge cases. Observed patterns:

1. **MAX expects `boxes` before `lines`** in the patcher dict. The current `DEFAULT_PATCHER_PROPS` enforces this order.
2. **Box keys follow a conventional order** in MAX-saved files: `maxclass`, `text`, `id`, `numinlets`, `numoutlets`, `outlettype`, `patching_rect`, then extras. Python dicts preserve insertion order (3.7+), but loading then re-serializing may reorder keys.
3. **Patchline keys**: MAX writes `source` before `destination`. Reordering these shouldn't break MAX but creates noisy diffs.
4. **After round-tripping through from_dict/to_dict**, the key order may change from what MAX saved, creating unnecessary diffs when the user saves again in MAX.

**Why it happens:** JSON spec doesn't guarantee key ordering, but .maxpat files have a conventional order that MAX follows. Python dicts preserve insertion order, but `from_dict()` reconstructs dicts in code-order rather than preserving original ordering.

**Prevention:**
- For patcher-level keys: use `OrderedDict` or careful insertion ordering that matches `DEFAULT_PATCHER_PROPS`
- For box-level keys: preserve the original key order from the loaded JSON (store ordered dict or maintain insertion order)
- The existing `merge_and_write()` already handles patcher-level key ordering via `DEFAULT_PATCHER_PROPS` -- the direct-edit path should use the same approach
- For diff-friendliness: write JSON with `indent=2` and `sort_keys=False` (already done)

**Detection:** Diff test: load a MAX-saved .maxpat, write it back without modifications, diff. Ideally zero structural changes (only whitespace differences are acceptable).

**Phase:** Phase 1, but lower priority than data loss bugs.

### Pitfall 8: Stale Agent Skills and Slash Commands

**What goes wrong:** The 6 agent SKILL.md files and slash commands reference the generation-pipeline API extensively:
- `max-patch-agent/SKILL.md`: References `Patcher()`, `Box()`, `generate_patch()`, `write_patch()`, `merge_and_write()`, layout options, aesthetic helpers
- `max-dsp-agent/SKILL.md`: References `build_genexpr()`, `generate_gendsp()`, `write_gendsp()`, `Patcher.add_gen()`
- All agents reference the "Output Protocol" of create-generate-validate-write workflow

If these SKILL files aren't updated atomically, agents will use the old API on patches that have been migrated to direct editing, or try to use new API on patches still using the generation pipeline.

**Why it happens:** SKILL files are documentation, not code. They don't break CI when they're wrong -- they cause agents to generate incorrect code at runtime. The failure mode is "agent writes a generate.py for a patch that no longer uses one."

**Prevention:**
- Update all SKILL files in a single commit/phase, not incrementally
- Add a "v2.0 API" section to each SKILL file that covers the new read-edit-write workflow
- Remove references to `generate.py`, `merge_and_write()`, and `Manifest` when those concepts are retired
- Test agent SKILL files: the existing `test_agent_skills.py` tests could be extended to verify API references are valid

**Detection:** Grep SKILL files for deprecated API references after each phase.

**Phase:** Phase 2 (agent/skill migration), done as a batch update.

## Minor Pitfalls

### Pitfall 9: Manifest Sidecar Files Left Behind

**What goes wrong:** When migrating from the generation pipeline to direct editing, `.manifest.json` sidecar files from the old system remain on disk. These are confusing artifacts that:
- Suggest the patch is still using the generation pipeline
- Could be accidentally read by old code paths, causing unexpected merge behavior
- Clutter the project directory

**Prevention:**
- Add a cleanup step to the migration process: delete `.manifest.json` files when converting a patch to direct-edit mode
- Add a warning if a `.manifest.json` is found alongside a patch that's in direct-edit mode

**Phase:** Phase 3 (existing project cleanup).

### Pitfall 10: Patcher.from_dict() Doesn't Handle MAX 8 vs MAX 9 Differences

**What goes wrong:** The current `from_dict()` doesn't check `appversion`. A MAX 8 patch has `"major": 8` and may use different default properties or box formats. If someone loads a MAX 8 patch and the tool assumes MAX 9 conventions, subtle differences could cause issues.

**Prevention:**
- Check `appversion.major` during `from_dict()` and log a warning if it's not 9
- Don't reject MAX 8 patches, but flag them for the user's awareness
- The tool already targets MAX 9 (documented in CLAUDE.md), so this is a documentation/warning issue, not a blocking one

**Phase:** Phase 1, low priority.

### Pitfall 11: Layout Engine Interference on Direct Edits

**What goes wrong:** The current `write_patch()` function always calls `apply_layout()` before writing. For direct edits, this would reposition ALL objects in the patch, destroying the user's carefully arranged layout.

The `merge_and_write()` function already handles this correctly by skipping layout on merge runs. But if the migration introduces a new write path that doesn't have this protection, layouts could be destroyed.

**Prevention:**
- The new direct-edit write path must NEVER call `apply_layout()` by default
- Layout should only run when explicitly requested (e.g., for newly added objects)
- Consider a `layout_new_only()` function that positions only objects without existing positions (patching_rect at 0,0)
- Test: load a patch, add one object, write back -- verify all existing object positions are unchanged

**Detection:** Position-preservation test: load a patch with known positions, add an object, save, verify original positions unchanged.

**Phase:** Phase 1 (write path design).

## Phase-Specific Warnings

| Phase Topic | Likely Pitfall | Mitigation |
|-------------|---------------|------------|
| Phase 1: Patcher library refactoring | Round-trip data loss (Pitfall 1) | Round-trip diff tests before any API changes |
| Phase 1: Patcher library refactoring | ID collision (Pitfall 3) | Used-ID tracking set, scoped per patcher level |
| Phase 1: Patcher library refactoring | Over-engineering read path (Pitfall 6) | Clear contract: preserve all, modify only requested |
| Phase 2: Agent/skill migration | Dual source of truth (Pitfall 2) | Editing-mode marker per project, fail-fast detection |
| Phase 2: Agent/skill migration | Stale SKILL files (Pitfall 8) | Batch update all 6 SKILLs + slash commands together |
| Phase 3: Project cleanup | Manifest leftovers (Pitfall 9) | Automated cleanup of .manifest.json files |
| All phases | Test breakage (Pitfall 4) | CI stays green, expand-then-contract pattern |
| All phases | Layout interference (Pitfall 11) | Never auto-layout loaded patches |

## Integration Pitfalls Between Old and New Approaches

### The Manifest Problem

The manifest system (`Manifest` class, `.manifest.json` sidecars) is the bridge between old and new. During migration:

1. **Old patches with manifests** should continue to work with `merge_and_write()` until they're migrated
2. **New direct-edit patches** should not create manifests
3. **The transition point** is when a patch's `generate.py` is deleted and its manifest is removed
4. **Risk:** Code that checks for manifest existence to decide behavior. If the manifest is deleted but the code still expects it, the patch falls into a "fresh write" code path and gets fully regenerated, losing user changes.

### The generate.py Dependency Chain

Each `generate.py` imports from `src.maxpat`:
```python
from src.maxpat import Patcher, write_patch
from src.maxpat.incremental import merge_and_write
```

If Phase 1 changes the Patcher API in a breaking way, ALL existing `generate.py` scripts break simultaneously. Since there are 7 generation scripts across 5 patch projects, this is a blast radius problem.

**Mitigation:** Phase 1 must be additive-only. Add new methods (`load()`, `edit()`, `save()`) without removing existing ones. Existing `generate.py` scripts should keep working until they're explicitly retired in Phase 3.

### Validation Pipeline Assumptions

The 4-layer validation pipeline (`validation.py`) assumes it's validating a freshly-generated patch:
- Layer 2 (objects): Checks all objects against ObjectDatabase. This will fail on loaded patches containing third-party objects.
- Layer 3 (connections): Checks inlet/outlet bounds. This will fail on loaded objects whose I/O counts differ from the database (due to variable_io, packages, or DB inaccuracies).
- Layer 4 (domain): Checks gain staging, unterminated chains. This will produce warnings for patterns the user intentionally chose.

**Mitigation:** Validation on direct-edit operations should only validate the DIFF -- objects and connections that were added or modified, not the entire loaded patch.

## Sources

- Codebase analysis: `src/maxpat/patcher.py` (Patcher.from_dict round-trip testing)
- Codebase analysis: `src/maxpat/incremental.py` (merge logic, manifest system)
- Codebase analysis: `tests/test_incremental.py` (23 existing merge tests)
- Codebase analysis: `patches/performancepatchtest/generated/performancepatchtest.maxpat` (real .maxpat structure)
- Project memory: `feedback_iterate_via_generator.md` (historical data loss from dual source of truth)
- Project memory: `project_incremental_patching.md` (incremental patching architecture)
- [Cycling '74 forum: Specification for .maxpat JSON format?](https://cycling74.com/forums/specification-for-maxpat-json-format) -- confirms no official spec
- [py2max: Python library for .maxpat generation](https://github.com/shakfu/py2max) -- round-trip editing reference
- [Cycling '74 docs: Saving State with pattr](https://docs.cycling74.com/userguide/pattr/) -- state vs structure distinction
- Verified: Box IDs are scoped per patcher level (not globally unique) -- subpatchers reuse obj-1, obj-2 independently
- Verified: Patchline.to_dict() drops `color` attribute (data loss bug)
- Verified: from_dict() `_handled_keys` can silently swallow attributes
- Verified: 913 existing tests, 283 in patcher-related files, 0 tests for Patcher.from_dict()
