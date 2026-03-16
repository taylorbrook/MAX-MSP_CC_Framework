# Project Research Summary

**Project:** MaxSystem v2.0 -- Patcher Library Refactor to Read-Write Editor
**Domain:** .maxpat file direct reading, surgical editing, and patch analysis
**Researched:** 2026-03-15
**Confidence:** HIGH

## Executive Summary

The v2.0 milestone replaces the current write-only Python generation pipeline with a direct read-write editing model where the .maxpat file is the single source of truth. Research confirms this is both feasible and well-scoped: the existing codebase already contains 90% of what is needed. `Patcher.from_dict()` loads .maxpat JSON into structured Box/Patchline objects, the layout engine builds topology graphs, and the validation pipeline checks correctness. The critical missing pieces are (1) hardened round-trip fidelity for `from_dict()`/`to_dict()`, (2) surgical mutation methods on Patcher (remove, replace, rewire), (3) a query/search API, and (4) a patch analysis module for understanding unknown patches. No external dependencies are needed -- the entire v2.0 runs on Python 3.14 stdlib plus the existing codebase.

The recommended approach is a strict load-edit-save cycle: read the .maxpat from disk into a Patcher, make targeted modifications via new edit methods, validate the changes, and write the full JSON back. This eliminates the `generate.py` scripts, the `.manifest.json` sidecar files, and the manifest-based merge system (`incremental.py`) that created the dual-source-of-truth problem v1.x suffered from. The .maxpat file becomes the only authoritative artifact. Agents call Patcher methods directly instead of generating intermediate Python scripts.

The primary risk is round-trip data loss: loading a user's .maxpat and writing it back must not silently drop attributes that MAX or the user added. The current `from_dict()`/`to_dict()` cycle has verified bugs (patchline `color` attribute dropped, bpatcher attributes mishandled, `parameter_enable` conditionally lost). These must be fixed and tested against real MAX-saved patches before any edit functionality is built on top. The secondary risk is the migration period where some patches still use `generate.py` while others use direct editing -- this requires a clear per-project mode marker and fail-fast detection to prevent competing edit paths.

## Key Findings

### Recommended Stack

No new external dependencies. Every library evaluated (py2max, jsonpatch, deepdiff, NetworkX) was rejected because the existing codebase already provides equivalent or better functionality. py2max lacks object validation and uses incompatible naming conventions. JSON Patch (RFC 6902) operates on brittle array-index paths wrong for .maxpat's ID-based structure. DeepDiff is overkill for comparing objects with known structure. NetworkX would add a 10MB dependency to replace ~100 lines of existing graph code.

**Core technologies (all existing):**
- **Python 3.14 stdlib (json, pathlib, collections):** .maxpat parsing, serialization, graph algorithms -- already working
- **Patcher/Box/Patchline data model (patcher.py):** 1:1 mapping to .maxpat JSON structure -- extend with mutation methods
- **ObjectDatabase (db_lookup.py):** 2,015-object knowledge base for creation-time validation -- unchanged
- **4-layer validation pipeline (validation.py):** Already operates on dicts -- adapt for edit-time incremental checks
- **Layout engine graph utilities (layout.py):** BFS, topological sort, component detection -- extract to shared topology module

**New modules to create (all in-house, no deps):**
- **query.py:** PatchQuery class for find/traverse/analyze operations on loaded patches
- **topology.py:** Extracted graph utilities shared between layout and query modules
- **analysis.py:** Patch summarization for /max-onboard command

**Modules to remove:**
- **incremental.py:** Manifest-based merge replaced by load-edit-save cycle
- **generate.py scripts per patch:** Agents edit .maxpat directly
- **versions.json / .manifest.json sidecars:** Version tracking via git, not custom files

See [STACK.md](./STACK.md) for full analysis including detailed rejection rationale for every external library considered.

### Expected Features

**Must have (table stakes):**
- **TS-1: Load any .maxpat into structured objects** -- foundation of everything; enhance `from_dict()` for full-fidelity loading
- **TS-2: Write back with minimal diff** -- byte-identical round-trip for unchanged portions; key ordering and numeric precision preservation
- **TS-3: Add object to existing patch** -- existing `add_box()` should work once `from_dict()` properly initializes `_next_id`
- **TS-4: Remove object** -- new `remove_box()` with cascade connection removal
- **TS-5: Rewire connections** -- new `remove_connection()`, `find_connections()` methods
- **TS-6: Preserve all user state on edit** -- never recompute positions, strip attributes, or reorder existing boxes
- **TS-7: Find objects by name/ID/type/text** -- query methods enabling all editing operations

**Should have (differentiators):**
- **D-1: Modify object attributes in-place** -- change arguments/position/color without delete-recreate
- **D-7: Insert object into existing connection** -- the most common surgical edit ("insert gain~ between osc and dac")
- **D-5: Replace/swap object** -- preserve position and compatible connections
- **D-2: Graph queries (upstream/downstream/path)** -- understand signal flow for intelligent editing
- **D-4: Intelligent auto-positioning** -- place new objects sensibly near related content
- **D-3: Patch summary/understanding** -- core of /max-onboard; object inventory, signal chains, parameters
- **D-6: Batch operations with transactions** -- checkpoint/rollback for multi-step edits

**Defer (v2+):**
- **D-8: Subpatcher extraction/inlining** -- high complexity (inlet/outlet mapping), lower frequency of use

See [FEATURES.md](./FEATURES.md) for complete feature analysis with complexity estimates, dependency graph, and prior art comparison.

### Architecture Approach

The v2.0 architecture follows a strict read-modify-write cycle centered on the .maxpat file as single source of truth. Components are cleanly separated: PatchReader (`from_dict`) handles loading, PatchEditor (new Patcher methods) handles mutation, PatchWriter (`write_patch_direct`) handles serialization without layout interference, and PatchAnalyzer (new module) handles read-only inspection. Only 3 of 10 slash commands need rewriting (build, iterate, new); the rest already operate on .maxpat files or are pipeline-independent.

**Major components:**
1. **Enhanced `Patcher.from_dict()`** -- full-fidelity loading with optional DB enrichment, permissive of unknown objects
2. **PatchEditor methods on Patcher** -- `remove_box()`, `replace_box()`, `disconnect()`, `rewire()`, `move_box()`, `set_attr()`, `auto_position_near()`
3. **PatchAnalyzer (analyzer.py)** -- inventory, signal chain tracing, parameter identification, purpose classification
4. **Direct write path (write_patch_direct)** -- serializes without layout, preserves all loaded state
5. **PatchQuery (query.py)** -- find by name/ID/type, upstream/downstream traversal, connected components

See [ARCHITECTURE.md](./ARCHITECTURE.md) for complete data flow diagrams (v1.x vs v2.0), anti-patterns to avoid, and suggested build order.

### Critical Pitfalls

1. **Round-trip data loss in from_dict/to_dict** -- Verified bugs: Patchline drops `color` attribute, bpatcher attrs mishandled, `parameter_enable` conditionally lost. **Prevention:** Add `extra_attrs` to Patchline, treat ALL unknown keys as preservable, write round-trip diff tests before any API changes.

2. **Dual source of truth during migration** -- If some patches use `generate.py` while others use direct editing, agents can overwrite changes via the wrong pipeline. **Prevention:** Add per-project `editing_mode` marker, fail-fast if direct-edit is attempted on a generated patch or vice versa, migrate patches atomically.

3. **ID collision when adding objects to loaded patches** -- Subpatcher IDs are scoped per patcher level; non-standard ID formats can break `_next_id` calculation. **Prevention:** Track all used IDs in a set, verify new IDs don't collide, handle non-numeric ID formats gracefully.

4. **Breaking 283 patcher-related tests** -- Tests assume write-only API; adding read-write changes output shapes. **Prevention:** Expand-then-contract pattern (add new capabilities before removing old ones), categorize tests, keep CI green throughout.

5. **Layout engine interference on direct edits** -- Current `write_patch()` always calls `apply_layout()`, which would destroy user positioning. **Prevention:** New `write_patch_direct()` never auto-layouts; layout only runs on new objects or explicit request.

See [PITFALLS.md](./PITFALLS.md) for all 11 pitfalls with evidence, consequences, phase-specific warnings, and detection strategies.

## Implications for Roadmap

Based on research, suggested phase structure:

### Phase 1: Round-Trip Foundation
**Rationale:** Everything builds on loading and saving .maxpat files without data loss. Research identified 3 verified round-trip bugs that must be fixed before any editing code is written. This is the highest-risk phase -- if round-trip fidelity fails, the entire v2.0 approach fails.
**Delivers:** A hardened `from_dict()`/`to_dict()` cycle that passes round-trip diff tests against all existing project .maxpat files and MAX-saved patches. `extra_attrs` on Patchline. bpatcher attr reconstruction. ID collision prevention.
**Addresses:** TS-1 (Load), TS-2 (Write Back), TS-6 (Preserve State)
**Avoids:** Pitfall 1 (round-trip data loss), Pitfall 3 (ID collision), Pitfall 7 (JSON key ordering)
**Scope:** Modify `patcher.py` only. No new modules. No agent changes. All 913 existing tests must stay green.

### Phase 2: Search and Query
**Rationale:** Every editing operation starts with finding the target. Search methods are a prerequisite for remove, replace, and rewire operations. Extract topology utilities from `layout.py` into shared module.
**Delivers:** `find_box()`, `find_boxes()`, `find_connections_from/to()` on Patcher. `read_patch()` convenience function in hooks.py. Shared `topology.py` module.
**Addresses:** TS-7 (Find Objects), D-2 (Graph Queries) foundation
**Avoids:** Pitfall 6 (over-engineering) -- keep queries simple, don't build full graph analysis yet
**Scope:** New `query.py` and `topology.py` modules. Extend `hooks.py`. No agent changes yet.

### Phase 3: Surgical Edit Operations
**Rationale:** With load and search working, add the mutation methods that replace the generation pipeline. These are the core operations agents will use.
**Delivers:** `remove_box()`, `disconnect()`, `rewire()`, `replace_box()`, `move_box()`, `set_attr()`, `auto_position_near()`, `insert_into_connection()`. New `write_patch_direct()` in hooks.py.
**Addresses:** TS-3 (Add Object), TS-4 (Remove Object), TS-5 (Rewire), D-1 (Modify Attrs), D-5 (Replace/Swap), D-7 (Insert Into Connection), D-4 (Auto-Position)
**Avoids:** Pitfall 11 (layout interference) -- `write_patch_direct()` never auto-layouts
**Scope:** Extend `patcher.py` with edit methods. New write path in `hooks.py`. No agent changes yet.

### Phase 4: Patch Analysis
**Rationale:** With read and edit working, add the understanding layer that powers /max-onboard. This is the differentiator that makes agents intelligent editors rather than blind mutation tools.
**Delivers:** `analyzer.py` with object inventory, signal chain tracing, parameter identification, purpose classification, health check. /max-onboard output format.
**Addresses:** D-3 (Patch Summary), D-6 (Transactions -- checkpoint/rollback for complex edits)
**Scope:** New `analyzer.py` module. Graph query enhancements. No agent changes yet.

### Phase 5: Agent and Command Migration
**Rationale:** All infrastructure is tested and working. Now rewire the agent workflows and slash commands to use read-edit-write instead of generate-merge-write. This is the phase where the user-facing behavior changes.
**Delivers:** Rewritten `/max-build`, `/max-iterate`, `/max-new` commands. New `/max-onboard` command. Updated SKILL.md files for all 6 agents. Per-project `editing_mode` marker.
**Addresses:** Agent integration, command rewrites
**Avoids:** Pitfall 2 (dual source of truth), Pitfall 8 (stale agent skills) -- batch-update all skills and commands together
**Scope:** Command and skill file rewrites. Public API updates in `__init__.py`. Integration tests.

### Phase 6: v1.x Cleanup
**Rationale:** After all commands work via direct editing, remove the generation pipeline artifacts. This must come last because existing generate.py scripts must keep working until commands are migrated.
**Delivers:** Removal of `incremental.py`, `Manifest` class, `merge_and_write()`. Deletion of `generate.py`/`build_*.py` scripts and `.manifest.json` files per patch. Updated tests replacing the 23 incremental merge tests.
**Addresses:** AF-4 (no manifest sidecars), AF-6 (no generate.py compatibility)
**Avoids:** Pitfall 4 (test breakage) -- only remove after new tests cover the same scenarios, Pitfall 9 (manifest leftovers)
**Scope:** Delete dead code and files. Update test suite. Final CI verification.

### Phase Ordering Rationale

- **Phases 1-3 are a strict dependency chain:** You cannot edit what you cannot find, and you cannot find what you cannot load. Each phase builds directly on the previous.
- **Phase 4 (Analysis) is semi-independent** but benefits from the graph queries in Phase 2 and the edit methods in Phase 3 (for the health check integration). Could theoretically start after Phase 2.
- **Phase 5 must come after Phases 1-4** because agent commands must use tested, working infrastructure. Updating agent skills against unstable APIs wastes effort.
- **Phase 6 must come last** because the expand-then-contract pattern requires the old pipeline to keep working until the new one is proven. Premature removal breaks existing workflows.
- **The biggest pitfall (round-trip data loss) is addressed first** because it is the foundation of trust. A single dropped attribute in Phase 1 would invalidate all subsequent phases.

### Research Flags

Phases likely needing deeper research during planning:
- **Phase 1 (Round-Trip Foundation):** Needs investigation of MAX-saved .maxpat files to discover all metadata keys that must be preserved. No official .maxpat spec exists. Create test fixtures by opening generated patches in MAX, editing, and saving.
- **Phase 4 (Patch Analysis):** Heuristic quality for purpose classification and signal flow description is uncertain. The "identify what this patch does" problem is inherently fuzzy. May need iterative refinement based on real patches.

Phases with standard patterns (skip research-phase):
- **Phase 2 (Search and Query):** Well-documented graph traversal patterns. py2max and MAX's JS API provide clear prior art for the query interface.
- **Phase 3 (Surgical Edit Operations):** Standard mutable collection operations. The edit API design is well-understood from ARCHITECTURE.md analysis.
- **Phase 5 (Agent Migration):** Prompt engineering and command rewriting. The new workflow is simple (read-edit-write) and the command structure already exists.
- **Phase 6 (Cleanup):** Straightforward deletion. No design decisions needed.

## Confidence Assessment

| Area | Confidence | Notes |
|------|------------|-------|
| Stack | HIGH | All decisions based on direct codebase comparison. Zero new dependencies needed. Every rejected library has a clear rationale. |
| Features | HIGH | Table stakes verified against existing codebase gaps. Dependency tree is clear. Complexity estimates grounded in existing code. |
| Architecture | HIGH | All components are custom Python with no external dependencies to verify. Build order validated against dependency analysis. |
| Pitfalls | HIGH (code-level), MEDIUM (MAX metadata) | Round-trip bugs confirmed by code reading. MAX-internal metadata behavior is partially unknown due to no official .maxpat specification. |

**Overall confidence:** HIGH

### Gaps to Address

- **No official .maxpat specification:** MAX's JSON format is undocumented. All knowledge comes from reverse engineering examples. New MAX versions could add keys that break assumptions. **Mitigation:** The "preserve all unknown keys" strategy handles this defensively. Create MAX-saved test fixtures to discover undocumented keys.
- **Zero existing tests for `Patcher.from_dict()`:** The read path has no test coverage despite being the foundation of v2.0. **Mitigation:** Phase 1 must begin by writing round-trip tests before modifying any code.
- **Patch analysis heuristics are unvalidated:** The purpose classification and signal flow description features (Phase 4) are inherently heuristic. Quality depends on pattern matching against real-world patches. **Mitigation:** Start with simple, conservative heuristics. Iterate based on /max-onboard usage on real patches.
- **Agent context window limits:** A 1000-box patch serialized to Python method calls is enormous. The analyzer must provide compact summaries that agents can work from without seeing every box. **Mitigation:** Design analyzer output for agent consumption from the start.

## Sources

### Primary (HIGH confidence)
- Direct codebase analysis: `src/maxpat/patcher.py` (1134 lines, `from_dict()` at L1012-1122, `to_dict()`, Box/Patchline classes)
- Direct codebase analysis: `src/maxpat/incremental.py` (476 lines, manifest system, merge logic)
- Direct codebase analysis: `src/maxpat/layout.py` (970 lines, graph algorithms, topological sort)
- Direct codebase analysis: `src/maxpat/validation.py` (669 lines, 4-layer pipeline)
- Direct codebase analysis: `src/maxpat/hooks.py` (269 lines, write_patch, validate_file)
- Direct codebase analysis: `.claude/commands/max-*.md` (10 command files)
- Real .maxpat file analysis: kicksynth (5,950 lines), performancepatchtest, scala-synth, minitaur
- Verified: Patchline.to_dict() drops `color` attribute (data loss bug)
- Verified: 913 existing tests, 283 patcher-related, 0 for from_dict()
- Project memory: `feedback_iterate_via_generator.md`, `project_incremental_patching.md`

### Secondary (MEDIUM confidence)
- [py2max GitHub](https://github.com/shakfu/py2max) -- round-trip editing reference, API patterns
- [Cycling '74 Patcher JS API](https://docs.cycling74.com/apiref/js/patcher/) -- apply/applydeep patterns, connect/disconnect API
- [Cycling '74 .maxpat format forum discussion](https://cycling74.com/forums/specification-for-maxpat-json-format) -- confirms no official spec
- [jsonpatch on PyPI](https://pypi.org/project/jsonpatch/) -- v1.33, RFC 6902; rejected for array-index-based paths
- [deepdiff on PyPI](https://pypi.org/project/deepdiff/) -- v8.6.1; rejected, overkill for known structure
- [NetworkX on PyPI](https://pypi.org/project/networkx/) -- v3.6.1; rejected, 10MB for ~100 lines of existing code

### Tertiary (LOW confidence)
- MAX-internal metadata behavior (editing_bgcolor, saved_attribute_attributes, dependency_cache) -- inferred from .maxpat file inspection, no documentation exists

---
*Research completed: 2026-03-15*
*Ready for roadmap: yes*
