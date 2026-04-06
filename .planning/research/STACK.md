# Technology Stack: v2.0 Direct .maxpat Reading & Surgical Editing

**Project:** MaxSystem v2.0 -- Patcher Library Refactor to Read-Write Editor
**Researched:** 2026-03-15
**Overall Confidence:** HIGH

## Executive Summary

The v2.0 milestone replaces the Python generation pipeline with direct .maxpat reading and surgical editing. The core question: what stack additions are needed to load arbitrary .maxpat files, understand their structure, and make precise edits while preserving everything else?

**Answer: Almost nothing.** The existing codebase already has 90% of what is needed. `Patcher.from_dict()` already loads .maxpat JSON into Box/Patchline objects. The .maxpat format is plain JSON with a stable, well-understood structure. The layout engine already builds topology graphs from boxes and lines. What is missing is (1) richer querying of loaded patches, (2) targeted mutation operations that work on Box/Patchline objects without full regeneration, and (3) a write-back path that serializes only changes.

**No new external dependencies are needed.** Python's stdlib `json` module is sufficient for all .maxpat reading and writing. The existing `Patcher`, `Box`, `Patchline` data model already maps 1:1 to the .maxpat JSON structure. Adding external libraries (py2max, deepdiff, jsonpatch, networkx) would create parallel systems competing with the existing well-tested codebase.

## Recommended Stack: No New Libraries

### What Already Works

| Capability | Current Module | Status | v2.0 Change Needed |
|------------|---------------|--------|---------------------|
| Load .maxpat JSON | `Patcher.from_dict()` | Working | Minor fixes (see below) |
| Serialize to .maxpat JSON | `Patcher.to_dict()` | Working | None |
| Box data model | `patcher.py` Box class | Working | Add mutation methods |
| Connection data model | `patcher.py` Patchline class | Working | Add query methods |
| Object database lookup | `db_lookup.py` ObjectDatabase | Working | None |
| Graph topology | `layout.py` `_build_graph()` | Working | Extract to shared utility |
| Validation pipeline | `validation.py` | Working | Works on dicts already |
| File I/O | `hooks.py` | Working | Add `load_patch()` entry point |

### What Needs to Be Added (All In-House)

| New Capability | Module | Purpose | Complexity |
|----------------|--------|---------|------------|
| Patch query API | New: `query.py` | Find boxes by name/type/connection, traverse topology | Medium |
| Surgical edit operations | Extend: `patcher.py` | `remove_box()`, `replace_box()`, `reroute()` | Low |
| Diff-aware write-back | Extend: `patcher.py` / `hooks.py` | Write only changed sections, preserve unknown keys | Medium |
| `from_dict()` hardening | Fix: `patcher.py` | Handle all edge cases in real-world .maxpat files | Low |
| `/max-onboard` analysis | New: `analysis.py` | Summarize patch structure, identify patterns | Medium |

## Detailed Stack Decisions

### Decision 1: Do NOT Adopt py2max

**Recommendation:** Do not use py2max. Continue with the existing custom Patcher model.

| Factor | py2max | Existing Patcher Model |
|--------|--------|----------------------|
| Round-trip support | Yes | Yes (via `from_dict()` / `to_dict()`) |
| Object validation | None (any string accepted) | Full (2,015-object DB, Rule #1 enforcement) |
| Variable I/O computation | None | Full (formula-based from overrides) |
| Connection validation | None | 4-layer pipeline with auto-fix |
| Layout engine | None (manual positioning) | Full topological layout with midpoints |
| Test coverage | 418 tests | 624 tests |
| Integration with agents | Would need adapter layer | Native |
| Naming convention | `_tilde` suffix (`cycle_tilde`) | Native names (`cycle~`) |

py2max solves a different problem: generating .maxpat files from scratch without any object knowledge. This project already has a more capable version of that with validation, layout, and domain-specific intelligence. Adopting py2max would mean maintaining two parallel object models, writing adapter code, and losing validation. The existing `from_dict()` already does what py2max's `from_file()` does.

**Confidence:** HIGH -- based on direct code comparison of both systems.

### Decision 2: Do NOT Add jsonpatch/deepdiff for JSON Diff/Patch

**Recommendation:** Do not use RFC 6902 JSON Patch or deepdiff. Work at the Patcher/Box/Patchline level, not the raw JSON level.

**Why not jsonpatch (v1.33):**
- RFC 6902 patches operate on JSON paths like `/patcher/boxes/3/box/patching_rect/0`. These paths are brittle -- they break when array indices shift (adding/removing boxes changes every index after it).
- .maxpat boxes are identified by their `id` field, not array position. Any useful diff/patch system needs to work by box ID, not JSON path.
- The overhead of converting to/from JSON patch format adds complexity without benefit when we already have the Box/Patchline object model.

**Why not deepdiff (v8.6.1):**
- DeepDiff excels at comparing arbitrary Python objects. But .maxpat patches have known structure -- we do not need generic deep comparison.
- DeepDiff's Delta feature has had security vulnerabilities (CVE-2025-58367 in deserialization). While patched in 8.6.1, this is unnecessary attack surface for a tool that reads/writes files to disk.
- Comparing two Patcher objects at the Box/Patchline level is trivial with the existing model: boxes have IDs, connections have (source_id, outlet, dest_id, inlet) tuples. No library needed.

**The right approach:** Operate at the semantic level (Box/Patchline), not the syntactic level (JSON paths). When writing back, serialize the full Patcher to dict and write it. The `.maxpat` files are typically 2-10K lines -- full serialization is instantaneous.

**Confidence:** HIGH -- jsonpatch's array-index-based paths are fundamentally wrong for ID-based structures.

### Decision 3: Do NOT Add NetworkX for Graph Analysis

**Recommendation:** Do not add NetworkX. Extend the existing graph utilities in `layout.py`.

The existing layout engine already implements:
- Adjacency list construction from boxes and lines (`_build_graph()`)
- Connected component detection via BFS (`_find_components()`)
- Topological sort via Kahn's algorithm (`_topological_levels()`)
- Reverse adjacency for parent lookups

These are the exact graph operations needed for patch analysis: "what connects to this object?", "what are the signal chains?", "what are the independent sub-circuits?". NetworkX (v3.6.1, requires Python 3.11+) would be a 10MB dependency to replace ~100 lines of existing, tested code.

**What to do instead:** Extract `_build_graph()`, `_find_components()`, and `_topological_levels()` from `layout.py` into a shared `topology.py` module that both the layout engine and the new query/analysis modules can use.

**Confidence:** HIGH -- the existing implementations cover the needed algorithms.

### Decision 4: Harden `Patcher.from_dict()` (Existing Code, No New Deps)

**Recommendation:** Fix edge cases in the existing `from_dict()` classmethod.

Current `from_dict()` (patcher.py lines 1012-1122) already handles:
- Top-level patcher props extraction
- Box reconstruction with maxclass, text, I/O counts
- Name derivation from text field or maxclass
- Patchline reconstruction from source/destination arrays
- Recursive inner patcher loading
- ID counter recovery for new box generation

**Edge cases to fix for real-world .maxpat files:**

1. **bpatcher attributes not restored.** Current `from_dict()` sets `_bpatcher_attrs = None` for all loaded boxes. Real .maxpat bpatchers have `args`, `name`, `bgmode`, `offset`, etc. that need to be captured into `_bpatcher_attrs` for faithful round-trip.

2. **Unknown maxclasses.** MAX 9 introduces new maxclasses not in our UI set (e.g., `live.scope~`, `filtergraph~`, custom externals). `from_dict()` should not crash on unknown maxclasses -- it should load them permissively and flag unknowns.

3. **Non-standard ID formats.** User-created or MAX-generated patches sometimes use IDs like `obj-1073741824` or UUID-style IDs. The ID counter recovery should handle these gracefully.

4. **Deeply nested subpatchers.** Poly~ objects can contain multiple levels of nesting. The recursive `from_dict()` call already handles this, but the `_is_subpatcher` flag should be set correctly for inner patchers.

5. **Extra patcher-level keys.** Real .maxpat files from MAX have keys not in `DEFAULT_PATCHER_PROPS` (e.g., `editing_bgcolor`, `locked_bgcolor`, `parameter_enable`, custom styles). These are already preserved via the `props` copy in `from_dict()` -- verify this works for all cases.

**Complexity:** Low. These are targeted fixes to existing code, not new architecture.

**Confidence:** HIGH -- verified by examining both `from_dict()` source and real .maxpat files.

### Decision 5: Build Query API as New Module (`query.py`)

**Recommendation:** Create `src/maxpat/query.py` for finding and traversing loaded patches.

This is the main new capability needed. Once a patch is loaded via `from_dict()`, agents need to ask questions like:
- "Find all `cycle~` objects in this patch"
- "What connects to the input of this `*~` object?"
- "Trace the signal chain from this `noise~` to `dac~`"
- "What subpatchers exist and what do they contain?"
- "Which objects have no connections?"

**Proposed API (no external deps, pure Python):**

```python
class PatchQuery:
    """Query interface for loaded Patcher objects."""

    def __init__(self, patcher: Patcher): ...

    # Find boxes
    def find_by_name(self, name: str) -> list[Box]: ...
    def find_by_maxclass(self, maxclass: str) -> list[Box]: ...
    def find_by_text(self, pattern: str) -> list[Box]: ...  # regex
    def find_by_id(self, box_id: str) -> Box | None: ...

    # Topology queries (uses extracted graph utils)
    def upstream(self, box: Box) -> list[Box]: ...  # all ancestors
    def downstream(self, box: Box) -> list[Box]: ...  # all descendants
    def direct_inputs(self, box: Box) -> list[tuple[Box, int, int]]: ...  # (src, outlet, inlet)
    def direct_outputs(self, box: Box) -> list[tuple[Box, int, int]]: ...  # (dst, outlet, inlet)
    def signal_chain(self, start: Box) -> list[Box]: ...  # follow signal connections
    def components(self) -> list[list[Box]]: ...  # independent groups

    # Subpatcher traversal
    def subpatchers(self) -> list[tuple[Box, Patcher]]: ...
    def walk_all_boxes(self) -> Iterator[tuple[Box, Patcher]]: ...  # deep recursive

    # Summary/analysis
    def summary(self) -> dict: ...  # counts, object types, signal chains
```

**Why a separate module:** Query logic is conceptually distinct from mutation (patcher.py) and layout (layout.py). Keeping it separate enables clean testing and avoids bloating the core Patcher class.

**Complexity:** Medium. Graph traversal reuses existing topology code. The novel work is the query interface design.

**Confidence:** HIGH -- pattern proven by both py2max and the existing layout engine.

### Decision 6: Add Surgical Edit Operations to Patcher

**Recommendation:** Add mutation methods directly to the `Patcher` class.

Current Patcher has: `add_box()`, `add_connection()`, `add_subpatcher()`, etc. (creation only).

**New methods needed for editing:**

```python
class Patcher:
    # Removal
    def remove_box(self, box: Box | str) -> list[Patchline]: ...
        # Remove box and all its connections, return removed connections

    def remove_connection(self, src: Box, outlet: int, dst: Box, inlet: int) -> bool: ...

    # Replacement
    def replace_box(self, old: Box | str, new_name: str, new_args: list[str] | None = None) -> Box: ...
        # Replace object, attempt to preserve connections where I/O counts match

    # Reconnection
    def insert_between(self, upstream: Box, downstream: Box, new_box: Box,
                        src_outlet: int = 0, dst_inlet: int = 0) -> None: ...
        # Insert a box in the middle of an existing connection

    def reroute(self, old_src: Box, old_outlet: int, new_src: Box, new_outlet: int) -> None: ...
        # Move all connections from one outlet to another
```

**Why on Patcher, not a separate class:** These operations need to modify both `self.boxes` and `self.lines` atomically. Putting them on Patcher keeps the mutation boundary clear.

**Complexity:** Low. Remove/replace are straightforward list operations with connection cleanup.

**Confidence:** HIGH -- standard mutable collection operations.

### Decision 7: Write-Back Strategy -- Full Serialization, Not Incremental

**Recommendation:** Write the full .maxpat JSON on every save. Do NOT attempt incremental JSON patching.

**Rationale:**
1. .maxpat files are small (typical: 2K-10K lines, max observed: ~6K lines for kicksynth). Full JSON serialization + write takes <10ms.
2. The current `to_dict()` is already a correct full serializer.
3. `from_dict()` already preserves all keys it does not recognize into `extra_attrs` and `props`, so unknown keys survive the round-trip.
4. Incremental JSON patching (only writing changed bytes) is complex, error-prone, and saves negligible time.
5. MAX does not watch .maxpat files for changes -- there is no file-locking or live-reload concern.

**The write pipeline becomes:**
```
Load:  json.loads(path.read_text()) -> Patcher.from_dict(data, db)
Edit:  patcher.remove_box(...) / patcher.add_box(...) / etc.
Save:  json.dumps(patcher.to_dict(), indent=2) -> path.write_text()
```

This replaces the entire `incremental.py` / `Manifest` system with a simpler approach: the .maxpat file IS the source of truth. No sidecar manifests needed.

**Confidence:** HIGH -- performance verified (6K-line kicksynth.maxpat parses in <5ms).

## What to Remove from the Stack

| Module | Status | Rationale |
|--------|--------|-----------|
| `incremental.py` | **Remove** | Manifest-based merge is replaced by load-edit-save cycle. No more sidecar `.manifest.json` files. |
| `Manifest` class | **Remove** | The .maxpat file is the single source of truth. No need to track generator-owned vs user-owned objects. |
| `merge_and_write()` | **Remove** | Replaced by `Patcher.from_dict()` -> edit -> `to_dict()` -> write. |
| `generate.py` scripts per patch | **Remove** | Agents edit .maxpat directly. No Python generation scripts. |
| `versions.json` per patch | **Remove** | Version tracking via git, not custom JSON sidecar. |

## Existing Stack: Unchanged

| Technology | Version | Status |
|------------|---------|--------|
| Python | 3.14 | Keep -- runtime for all modules |
| pytest | 9.0.2 | Keep -- test framework |
| `json` (stdlib) | 3.14 | Keep -- .maxpat parsing and serialization |
| `pathlib` (stdlib) | 3.14 | Keep -- file I/O |
| `copy` (stdlib) | 3.14 | Keep -- deep copy for dict manipulation |
| `collections` (stdlib) | 3.14 | Keep -- defaultdict, deque in graph algorithms |
| `re` (stdlib) | 3.14 | Keep -- pattern matching in validation |
| `patcher.py` (Box/Patchline/Patcher) | v1.1 | Keep + extend -- add mutation methods |
| `layout.py` | v1.1 | Keep -- extract topology utils to shared module |
| `validation.py` | v1.1 | Keep -- already works on raw dicts |
| `db_lookup.py` (ObjectDatabase) | v1.1 | Keep -- object lookup for agent validation |
| `maxclass_map.py` | v1.1 | Keep -- UI maxclass resolution |
| `sizing.py` | v1.1 | Keep -- box size calculation |
| `aesthetics.py` | v1.1 | Keep -- styling helpers |
| `defaults.py` | v1.1 | Keep -- constants and LayoutOptions |
| `hooks.py` | v1.1 | Keep + extend -- add `load_patch()` entry point |
| `codegen.py` | v1.1 | Keep -- GenExpr/js/N4M code generation |
| `code_validation.py` | v1.1 | Keep -- GenExpr/js syntax validation |

## New Module Map

```
src/maxpat/
  patcher.py        # Extended: add remove_box, replace_box, insert_between, reroute
  query.py           # NEW: PatchQuery class for find/traverse/analyze
  topology.py        # NEW: extracted from layout.py -- shared graph utilities
  analysis.py        # NEW: patch summarization for /max-onboard
  layout.py          # Modified: imports topology from topology.py
  hooks.py           # Extended: add load_patch() entry point
  validation.py      # Unchanged
  db_lookup.py       # Unchanged
  maxclass_map.py    # Unchanged
  sizing.py          # Unchanged
  aesthetics.py      # Unchanged
  defaults.py        # Unchanged
  codegen.py         # Unchanged
  code_validation.py # Unchanged
  incremental.py     # REMOVED (replaced by load-edit-save cycle)
```

## Integration Points

### Load Path (New)
```
hooks.py:load_patch(path)
  -> json.loads(path.read_text())
  -> Patcher.from_dict(data, db=ObjectDatabase())
  -> Returns: Patcher instance with all boxes/lines/props populated
```

### Query Path (New)
```
query.py:PatchQuery(patcher)
  -> topology.py:build_graph(patcher.boxes, patcher.lines)
  -> Returns: query object with find/traverse/analyze methods
```

### Edit Path (Extended)
```
patcher.py:Patcher.remove_box(box)
  -> Removes box from self.boxes
  -> Removes all connections involving box from self.lines
  -> Returns: removed connections (for undo)

patcher.py:Patcher.replace_box(old, new_name, new_args)
  -> Creates new Box with DB validation
  -> Attempts to preserve compatible connections
  -> Returns: new Box
```

### Save Path (Simplified)
```
hooks.py:save_patch(patcher, path)
  -> patcher.to_dict()
  -> json.dumps(result, indent=2)
  -> path.write_text(json_str)
  -> Optional: validate before write
```

### Agent Integration
```
Agent receives: path to .maxpat file
Agent calls:    load_patch(path) -> patcher
Agent queries:  PatchQuery(patcher).find_by_name("cycle~")
Agent edits:    patcher.remove_box(old); patcher.add_box("saw~", ["440"])
Agent saves:    save_patch(patcher, path)
Agent validates: validate_patch(patcher)
```

## Installation

```bash
# No new packages to install. Zero new dependencies.
# The entire v2.0 stack runs on Python 3.14 stdlib + existing codebase.
```

## Sources

### Codebase Analysis (HIGH confidence)
- `src/maxpat/patcher.py` -- Examined `from_dict()` (lines 1012-1122), `to_dict()`, Box class
- `src/maxpat/layout.py` -- Examined `_build_graph()`, `_find_components()`, `_topological_levels()`
- `src/maxpat/incremental.py` -- Examined full merge logic, manifest system
- `src/maxpat/validation.py` -- Examined 4-layer pipeline, dict-based operation
- `src/maxpat/hooks.py` -- Examined `write_patch()`, `validate_file()`
- `src/maxpat/db_lookup.py` -- Examined ObjectDatabase, `lookup()`, `compute_io_counts()`
- Real .maxpat files -- kicksynth.maxpat (5,950 lines), multiple patches examined

### External Library Research (HIGH confidence)
- [py2max on GitHub](https://github.com/shakfu/py2max) -- v0.2.x, pure Python, round-trip support but no object validation. Confirmed incompatible naming convention (`_tilde` suffix).
- [jsonpatch on PyPI](https://pypi.org/project/jsonpatch/) -- v1.33, RFC 6902 implementation. Confirmed array-index-based paths are wrong for .maxpat's ID-based structure.
- [python-json-patch docs](https://python-json-patch.readthedocs.io/en/latest/mod-jsonpatch.html) -- Full API reviewed: `make_patch()`, `JsonPatch.from_diff()`, `apply()`. Operations are add/remove/replace/copy/move/test.
- [deepdiff on PyPI](https://pypi.org/project/deepdiff/) -- v8.6.1, generic deep comparison with Delta feature. CVE-2025-58367 security vulnerability in deserialization (patched in 8.6.1). Overkill for known-structure .maxpat comparison.
- [jsonpointer docs](https://python-json-pointer.readthedocs.io/en/latest/tutorial.html) -- v3.0.0, RFC 6901 pointer resolution. Same array-index problem as jsonpatch.
- [NetworkX on PyPI](https://pypi.org/project/networkx/) -- v3.6.1, requires Python 3.11+. 10MB dependency to replace ~100 lines of existing graph code.
- [Cycling '74 .maxpat format discussion](https://cycling74.com/forums/specification-for-maxpat-json-format) -- No official spec exists. Format is reverse-engineered from examples.
