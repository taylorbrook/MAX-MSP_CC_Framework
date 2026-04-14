# Feature Landscape: v2.0 Direct .maxpat Reading & Editing

**Domain:** Patch file reading, surgical editing, state preservation, and patch analysis
**Researched:** 2026-03-15
**Confidence:** HIGH for .maxpat JSON format behavior (verified against codebase + real patches); HIGH for editing operations (well-understood JSON manipulation); MEDIUM for analysis/understanding features (pattern recognition heuristics, no formal specification)

---

## Context: What Exists vs What Is Needed

The v1.x system has a **write-only pipeline**: `Patcher.add_box()` builds objects in memory, `apply_layout()` positions them, `to_dict()` serializes to JSON, `write_patch()` writes to disk. A `Patcher.from_dict()` reader exists (added for incremental merge in v1.x) but only populates enough fields for merge logic -- it does not reconstruct a fully editable Patcher with DB validation, I/O counts, or graph-aware operations.

The incremental merge system (`incremental.py`) works but is the wrong abstraction: it assumes a `generate.py` script is the source of truth, with a sidecar manifest tracking "generator-owned" vs "user-owned" objects. The v2.0 goal eliminates this distinction -- the `.maxpat` file IS the single source of truth, and Claude reads it, understands it, and edits it directly.

**What this research covers:** The specific features needed for reading, editing, preserving, and analyzing .maxpat files. NOT the infrastructure refactoring (covered in ARCHITECTURE.md) or technology choices (covered in STACK.md).

---

## Table Stakes

Features that must work for the v2.0 milestone to be considered complete. Missing any of these means the direct-editing workflow is broken.

### TS-1: Load Any .maxpat into Structured Objects

| Aspect | Detail |
|--------|--------|
| **Why expected** | Foundation of everything. Cannot edit what you cannot read. Every agent, skill, and hook needs to load a .maxpat and work with structured Python objects, not raw JSON dicts. |
| **What it does** | Read a .maxpat file from disk, parse the JSON, and reconstruct a `Patcher` instance with fully populated `Box` and `Patchline` objects. Every box must have: `id`, `name`, `maxclass`, `text`, `args`, `numinlets`, `numoutlets`, `outlettype`, `patching_rect`, font info, presentation state, extra_attrs, and inner patchers (recursive). |
| **Complexity** | MEDIUM |
| **Dependencies** | Existing `Patcher.from_dict()` provides 70% of this. Needs: proper name/args parsing from text field, bpatcher attribute reconstruction, recursive inner patcher loading, ID counter sync, and consistent handling of all maxclass types. |
| **Existing foundation** | `from_dict()` at patcher.py:1012-1122 already handles boxes, lines, inner patchers, extra_attrs. Gaps: does not set `_bpatcher_attrs` on load (only checks `patcher` key), does not validate against DB on load (by design -- but edit operations will need DB access). |
| **Key behaviors** | Must handle: standard newobj boxes, UI objects (maxclass != "newobj"), comment/message boxes, bpatcher (file ref + embedded), subpatcher (p name), gen~ (with codebox), node.script, js, panel, and any unknown maxclass gracefully. Must preserve every JSON key, even ones the library does not understand (future-proofing). |

### TS-2: Write Back with Minimal Diff

| Aspect | Detail |
|--------|--------|
| **Why expected** | If load-then-save produces a different file than the original, the tool is not trustworthy. Users must be able to `git diff` after a Claude edit and see ONLY the intended changes, not reformatting noise. |
| **What it does** | Serialize a loaded-and-edited Patcher back to .maxpat JSON that is byte-for-byte identical to the original for unchanged portions. Edited boxes show only changed keys. No reordering of boxes or lines unless explicitly requested. |
| **Complexity** | HIGH |
| **Dependencies** | Requires careful JSON serialization. The current `to_dict()` method reconstructs from Python objects, losing key ordering and inserting defaults. Needs ordered dict handling and a "write only what was there plus changes" strategy. |
| **Existing foundation** | `from_dict()` stores all non-handled keys in `extra_attrs` and `props`. `to_dict()` inserts font keys, parameter_enable, etc. that may not have been in the original. The incremental merge (`_merge_box_attrs`) already has the concept of "generator-owned" vs "user-owned" keys -- this needs to evolve into "original value" vs "edited value". |
| **Key behaviors** | Preserve: key ordering within box dicts, numeric precision (don't turn `45.0` into `45`), string escaping, array formatting. Box array ordering must match the original (z-order matters for panels/background objects). Line array ordering should be preserved. New boxes get appended. Removed boxes are excised. |

### TS-3: Add Object to Existing Patch

| Aspect | Detail |
|--------|--------|
| **Why expected** | The most basic editing operation. "Add a cycle~ here" must work without rebuilding the entire patch. |
| **What it does** | Create a new Box in a loaded Patcher. The box gets a unique ID (higher than any existing ID), is validated against the ObjectDatabase, gets correct I/O counts and outlet types, and is positioned at a specified location (or auto-positioned intelligently). |
| **Complexity** | LOW |
| **Dependencies** | Existing `Patcher.add_box()` does this for new patchers. Needs to work when called on a loaded patcher where `_next_id` is synced to existing IDs. `from_dict()` already syncs `_next_id` (line 1121). |
| **Existing foundation** | `add_box()`, `add_comment()`, `add_message()`, `add_subpatcher()`, `add_bpatcher()`, `add_gen()`, `add_node_script()`, `add_js()` -- all exist and work. The main gap is that these methods were designed for construction, not insertion into an existing loaded patch. They should work as-is once `from_dict()` properly initializes the Patcher. |
| **Key behaviors** | New boxes must not collide IDs with existing boxes. Position can be explicit (x, y) or "near this other box". DB validation still applies (Rule #1). Must not disturb existing boxes or connections. |

### TS-4: Remove Object from Existing Patch

| Aspect | Detail |
|--------|--------|
| **Why expected** | Second most basic edit. "Remove this loadbang" or "delete the meter~" must be clean -- removing the box AND all connections to/from it. |
| **What it does** | Given a box ID or reference, remove it from `patcher.boxes` and remove all `Patchline`s where it appears as source or destination. If the box has an inner patcher, that is removed too. |
| **Complexity** | LOW |
| **Dependencies** | None beyond the loaded Patcher model. |
| **Existing foundation** | No `remove_box()` method exists. The incremental merge handles removal at the JSON dict level (filtering by manifest IDs). Needs a proper method on Patcher. |
| **Key behaviors** | Remove box from boxes list. Remove all lines where `source_id == box.id` or `dest_id == box.id`. Return the removed connections (caller may want to rewire). Raise if ID not found. |

### TS-5: Rewire Connections (Add/Remove Patchlines)

| Aspect | Detail |
|--------|--------|
| **Why expected** | Editing connections is the core of patch editing. "Connect the output of this filter to the dac~" or "disconnect the noise~ from the mixer". |
| **What it does** | Add new connections between existing boxes (with index bounds checking). Remove specific connections. Optionally: rewire (remove old, add new in one operation). |
| **Complexity** | LOW |
| **Dependencies** | Existing `add_connection()` does creation. Needs `remove_connection()` and `rewire()`. |
| **Existing foundation** | `add_connection()` exists (patcher.py:564). Connection validation exists in validation.py Layer 3 (bounds checking, signal type checking). No `remove_connection()` or `find_connections()` methods exist. |
| **Key behaviors** | `add_connection(src, outlet, dst, inlet)` -- already works. `remove_connection(src, outlet, dst, inlet)` -- find and remove matching Patchline. `find_connections(box_id)` -- return all connections to/from a box. Bounds checking on add (outlet index < numoutlets, inlet index < numinlets). |

### TS-6: Preserve All User State on Edit

| Aspect | Detail |
|--------|--------|
| **Why expected** | The entire motivation for v2.0. The v1.x pipeline destroys user customizations (positions, colors, presentation rects, varnames, scripting names) on regeneration. If v2.0 does the same thing, it has failed. |
| **What it does** | When editing a patch (adding/removing/modifying objects), ALL properties of untouched objects remain exactly as they were. This includes: `patching_rect` (positions), `presentation_rect`, colors (`bgcolor`, `textcolor`, `bgfillcolor`), font overrides, `varname`, `scripting_name`, custom attributes, hidden state, lock state, and any unknown keys. |
| **Complexity** | MEDIUM (mostly an architecture concern -- the read-modify-write cycle must be pristine) |
| **Dependencies** | TS-1 (complete loading) and TS-2 (minimal diff writing). |
| **Existing foundation** | `from_dict()` already preserves unknown keys in `extra_attrs` and patcher-level props. The incremental merge has an ownership model for this. The new system is simpler: load everything, edit what you want, save everything back. No ownership tracking needed because there is no "generator" vs "user" distinction. |
| **Key behaviors** | Never recompute `patching_rect` for existing boxes (no auto-layout on loaded boxes). Never strip unknown attributes. Never reorder boxes or lines. Never change patcher-level props (rect, bgcolor, openinpresentation) unless explicitly asked. |

### TS-7: Find Objects by Name/ID/Type/Text

| Aspect | Detail |
|--------|--------|
| **Why expected** | Every editing operation starts with finding the target. "Find the dac~" or "find all cycle~ objects" or "find box obj-15". Without search, the agent has to iterate manually. |
| **What it does** | Query methods on Patcher: `find_by_id(id)`, `find_by_name(name)` (object name like "cycle~"), `find_by_maxclass(maxclass)`, `find_by_text(text_substring)`. All return Box references (or lists). |
| **Complexity** | LOW |
| **Dependencies** | TS-1 (loaded Patcher with populated Box objects). |
| **Existing foundation** | No search methods exist. The `from_dict()` loader populates `box.name`, `box.maxclass`, `box.text`, `box.id` -- all searchable. py2max has `find_by_id()`, `find_by_text()`, `find_by_type()` as prior art. |
| **Key behaviors** | `find_by_id("obj-5")` returns single Box or None. `find_by_name("cycle~")` returns list of matching Boxes. `find_by_maxclass("comment")` returns list. `find_by_text("440")` returns boxes where text contains substring. Should search recursively into inner patchers with an optional flag. |

---

## Differentiators

Features that make the v2.0 system notably more useful than basic load/edit/save. Not required for MVP but provide significant value.

### D-1: Modify Object Attributes In-Place

| Aspect | Detail |
|--------|--------|
| **Value proposition** | Change an object's arguments, position, color, or any property without removing and re-adding it. "Change the cycle~ frequency from 440 to 880" should modify `box.text` and `box.args`, not delete and recreate. |
| **Complexity** | LOW-MEDIUM |
| **Dependencies** | TS-1, TS-7. |
| **Notes** | Changing `text` and `args` is simple string manipulation. Changing arguments that affect I/O counts (e.g., changing `trigger b i` to `trigger b i f`) requires recomputing `numinlets`/`numoutlets` and potentially invalidating connections. Need a `modify_args()` method that recomputes I/O and warns about broken connections. Position changes are trivial (`box.patching_rect = [x, y, w, h]`). Attribute changes go through `box.extra_attrs`. |

### D-2: Graph Queries (Upstream/Downstream/Path)

| Aspect | Detail |
|--------|--------|
| **Value proposition** | Understanding signal flow is critical for intelligent editing. "What feeds into this dac~?" or "Trace the signal path from MIDI input to audio output." The current layout engine already builds adjacency graphs (`_build_graph` in layout.py) -- expose this as a query API. |
| **Complexity** | MEDIUM |
| **Dependencies** | TS-1, TS-5. |
| **Notes** | Build directed graph from Patchline list. Provide: `upstream(box_id)` -- all boxes that feed into this box (BFS backward). `downstream(box_id)` -- all boxes fed by this box (BFS forward). `signal_path(src_id, dst_id)` -- find path(s) between two boxes. `signal_chain(box_id)` -- the complete chain from source to sink containing this box. `connected_component(box_id)` -- all boxes in the same connected component. Separate signal (audio) graph from control (message) graph based on outlettype. |

### D-3: Patch Summary / Understanding

| Aspect | Detail |
|--------|--------|
| **Value proposition** | When Claude opens an unknown .maxpat (from a user or third party), it needs to quickly understand what the patch does. A structured summary enables intelligent editing suggestions. This is the core of /max-onboard. |
| **Complexity** | MEDIUM-HIGH |
| **Dependencies** | TS-1, D-2. |
| **Notes** | Analyze a loaded patch and produce: (1) Object inventory -- count by type, domain breakdown (MSP vs Max vs Jitter). (2) Signal flow summary -- identify audio chains from sources to sinks. (3) Control flow summary -- identify MIDI/control paths. (4) Subpatcher map -- list all subpatchers/bpatchers and their purpose (from text/comments). (5) Functional sections -- group objects into logical sections by connected components and spatial proximity. (6) Parameter list -- find all named parameters (varname, scripting_name, param objects). (7) Complexity metrics -- object count, connection count, nesting depth, domain mix. |

### D-4: Intelligent Auto-Positioning for New Objects

| Aspect | Detail |
|--------|--------|
| **Value proposition** | When adding an object to an existing patch, auto-position it sensibly: below its upstream source, above its downstream target, near related objects. The current layout engine (`apply_layout`) is designed for full-patch layout of new patches -- it would destroy existing positions if applied to a loaded patch. Need a targeted "place this new box" algorithm. |
| **Complexity** | MEDIUM |
| **Dependencies** | TS-3, D-2. |
| **Notes** | Strategy: (1) If connected upstream, place below the source (source_y + source_h + v_spacing), aligned to the source's outlet X. (2) If connected downstream, place above the target. (3) If both, place between them. (4) If neither (disconnected), place in the nearest empty space. (5) Check for overlaps with existing boxes and shift if needed. This is a local placement algorithm, not a full relayout. The full `apply_layout()` should NEVER run on a loaded patch unless explicitly requested. |

### D-5: Replace Object (Swap)

| Aspect | Detail |
|--------|--------|
| **Value proposition** | "Replace this onepole~ with a biquad~" is a common edit. Needs to: remove old box, add new box at same position, reconnect as many connections as possible (matching inlet/outlet indices where compatible). |
| **Complexity** | MEDIUM |
| **Dependencies** | TS-3, TS-4, TS-5, D-1. |
| **Notes** | Algorithm: (1) Record old box's position, connections (with indices), and presentation state. (2) Create new box with new name/args at old position. (3) For each old connection, attempt to recreate with new box if the index is within bounds. (4) Report which connections could not be remapped (old box had 3 outlets, new has 2 -- outlet 2 connections are lost). This is extremely useful for the agent workflow where Claude suggests "swap X for Y". |

### D-6: Batch Operations with Transaction Semantics

| Aspect | Detail |
|--------|--------|
| **Value proposition** | Complex edits involve multiple coordinated changes: "Insert a gain~ between the oscillator and the dac~" requires adding a box AND rewiring two connections. If the rewire fails, the add should be rolled back. |
| **Complexity** | MEDIUM |
| **Dependencies** | All TS features. |
| **Notes** | Implement as a snapshot/restore pattern: `patcher.checkpoint()` saves current state, `patcher.rollback()` restores it, `patcher.commit()` discards the checkpoint. Internally, checkpoint saves a deep copy of boxes and lines lists. Not a full undo system -- just one level for atomic multi-step operations. |

### D-7: Insert Object Into Existing Connection

| Aspect | Detail |
|--------|--------|
| **Value proposition** | The single most common surgical edit: "Insert a *~ 0.5 between the cycle~ and the dac~." Requires: identify the connection, remove it, add new box, connect source->new->destination. |
| **Complexity** | LOW-MEDIUM |
| **Dependencies** | TS-3, TS-4, TS-5, D-4. |
| **Notes** | `insert_into_connection(patchline, new_box, inlet=0, outlet=0)`: removes the original connection, connects original source -> new_box inlet, connects new_box outlet -> original destination. Position new_box between source and destination (midpoint Y, aligned X). This is such a common operation it deserves a dedicated method. |

### D-8: Subpatcher Extraction / Inlining

| Aspect | Detail |
|--------|--------|
| **Value proposition** | "Move these 5 objects into a subpatcher" or "Inline this subpatcher's contents." Organizational refactoring that experienced MAX users do regularly. |
| **Complexity** | HIGH |
| **Dependencies** | TS-3, TS-4, TS-5, D-2. |
| **Notes** | Extract: select objects by ID list, identify connections that cross the boundary (these become inlet/outlet objects in the subpatcher), move objects into inner patcher, replace with subpatcher box, rewire boundary connections through inlets/outlets. Inline: reverse -- copy inner patcher objects to parent, reconnect, remove subpatcher box. Both are complex because they must handle the inlet/outlet mapping correctly and preserve connection semantics. Defer to later phase if needed. |

---

## Anti-Features

Features to explicitly NOT build. Each was considered and rejected for specific reasons.

### AF-1: Full Auto-Layout on Loaded Patches

| Anti-Feature | Why Avoid | What to Do Instead |
|--------------|-----------|-------------------|
| Running `apply_layout()` on a loaded patch | Destroys all user positioning. The layout engine assumes it is laying out a fresh patch from scratch. Applying it to a loaded patch with carefully arranged objects would reposition everything, breaking the user's visual organization. This is the exact problem v2.0 is solving. | Only auto-position NEW objects (D-4). Provide an explicit `relayout()` command for when the user wants a fresh layout (opt-in, not default). |

### AF-2: Real-Time MAX Integration (OSC/MCP Control)

| Anti-Feature | Why Avoid | What to Do Instead |
|--------------|-----------|-------------------|
| Controlling MAX in real-time via OSC or MCP | PROJECT.md explicitly lists this as out of scope. Creates fragile dependency on MAX running. Claude cannot test audio output. | Keep the offline editing model. Claude edits .maxpat files, user opens them in MAX. The .maxpat file is the communication channel. |

### AF-3: Patch Screenshot Analysis

| Anti-Feature | Why Avoid | What to Do Instead |
|--------------|-----------|-------------------|
| Analyzing screenshot images of patches to understand them | PROJECT.md explicitly lists this as out of scope. OCR on visual patches is unreliable. .maxpat JSON contains all information needed. | Use /max-onboard to analyze .maxpat JSON directly (D-3). JSON is the source of truth, not pixels. |

### AF-4: Manifest/Sidecar Files for Ownership Tracking

| Anti-Feature | Why Avoid | What to Do Instead |
|--------------|-----------|-------------------|
| Continuing the `.manifest.json` sidecar system | The manifest exists because the generate.py pipeline needed to know what it "owns" vs what the user added. With direct editing, there is no generator vs user distinction. Every object in the .maxpat is equally editable. The manifest adds complexity and a second file to track. | Remove the manifest system entirely. The .maxpat file is the single source of truth. Track edits through git history if provenance matters. |

### AF-5: Automatic DB Validation on Load

| Anti-Feature | Why Avoid | What to Do Instead |
|--------------|-----------|-------------------|
| Rejecting or flagging unknown objects when loading a .maxpat | Users may have objects from packages, externals, or MAX versions not in our 2,015-object database. A loader that rejects unknown objects is hostile. Loading must be permissive. | Load everything without validation. Validate only on explicit request or when adding NEW objects. The DB is for creation-time safety (Rule #1), not for gatekeeping loaded files. Unknown objects get best-effort Box reconstruction with the data present in the JSON. |

### AF-6: Python Generation Script (.generate.py) Compatibility

| Anti-Feature | Why Avoid | What to Do Instead |
|--------------|-----------|-------------------|
| Maintaining backward compatibility with the generate.py workflow | The entire point of v2.0 is to eliminate this pipeline. Keeping it working means maintaining two editing paths, which is the dual-source-of-truth problem we are solving. | Migrate existing patches to standalone .maxpat files. Remove generate.py scripts and manifests. Preserve the scripts in git history for reference. |

---

## Feature Dependencies

```
TS-1 (Load) --> TS-2 (Write Back)
TS-1 (Load) --> TS-3 (Add Object)
TS-1 (Load) --> TS-4 (Remove Object)
TS-1 (Load) --> TS-5 (Rewire)
TS-1 (Load) --> TS-6 (Preserve State)
TS-1 (Load) --> TS-7 (Find Objects)

TS-3 + TS-4 + TS-5 --> D-1 (Modify Attrs)
TS-1 + TS-5 --> D-2 (Graph Queries)
TS-1 + D-2 --> D-3 (Patch Summary)
TS-3 + D-2 --> D-4 (Auto-Position)
TS-3 + TS-4 + TS-5 + D-1 --> D-5 (Replace/Swap)
All TS --> D-6 (Transactions)
TS-3 + TS-5 + D-4 --> D-7 (Insert Into Connection)
TS-3 + TS-4 + TS-5 + D-2 --> D-8 (Subpatcher Extract/Inline)
```

The dependency tree is rooted at TS-1 (Load). Everything else builds on having a fully loaded, structured Patcher model.

---

## MVP Recommendation

### Phase 1: Core Read-Write (all Table Stakes)

Build in this order:

1. **TS-1: Load .maxpat** -- Foundation. Enhance `from_dict()` to produce fully populated Patcher.
2. **TS-7: Find Objects** -- Needed by everything else. Simple query methods.
3. **TS-3: Add Object** -- Verify existing `add_box()` works on loaded patchers.
4. **TS-4: Remove Object** -- New `remove_box()` method.
5. **TS-5: Rewire Connections** -- New `remove_connection()`, `find_connections()`.
6. **TS-6: Preserve State** -- Mostly an architecture test: load, edit, save, diff. No code beyond ensuring TS-1 and TS-2 are correct.
7. **TS-2: Write Back with Minimal Diff** -- JSON serialization refinements. Test by round-tripping real patches.

### Phase 2: Intelligent Editing (priority differentiators)

1. **D-1: Modify Attributes** -- Simple, high value.
2. **D-7: Insert Into Connection** -- The most common surgical edit.
3. **D-5: Replace/Swap Object** -- High-value compound operation.
4. **D-2: Graph Queries** -- Foundation for understanding.
5. **D-4: Auto-Position New Objects** -- Quality of life for the agent.

### Phase 3: Understanding & Analysis

1. **D-3: Patch Summary** -- Core of /max-onboard.
2. **D-6: Transactions** -- Safety net for complex edits.

### Defer

- **D-8: Subpatcher Extract/Inline** -- High complexity, lower frequency of use. Can be added later when the core editing workflow is proven.

---

## Complexity Estimates

| Feature | Complexity | Estimated Effort | Risk |
|---------|-----------|-----------------|------|
| TS-1: Load .maxpat | MEDIUM | 4-6h | Low -- from_dict() is 70% done |
| TS-2: Write Minimal Diff | HIGH | 6-10h | Medium -- JSON key ordering is fiddly |
| TS-3: Add Object | LOW | 1-2h | Low -- existing add_box() should work |
| TS-4: Remove Object | LOW | 2-3h | Low -- straightforward list operations |
| TS-5: Rewire | LOW | 2-3h | Low -- straightforward |
| TS-6: Preserve State | MEDIUM | 3-5h (testing) | Medium -- subtle serialization issues |
| TS-7: Find Objects | LOW | 2-3h | Low -- simple filtering |
| D-1: Modify Attrs | LOW-MED | 3-4h | Low -- but I/O recomputation adds edge cases |
| D-2: Graph Queries | MEDIUM | 4-6h | Low -- algorithms exist in layout.py |
| D-3: Patch Summary | MED-HIGH | 6-10h | Medium -- heuristic quality varies |
| D-4: Auto-Position | MEDIUM | 4-6h | Medium -- edge cases with overlaps |
| D-5: Replace/Swap | MEDIUM | 4-5h | Low -- compound of simpler operations |
| D-6: Transactions | MEDIUM | 3-4h | Low -- deep copy is sufficient |
| D-7: Insert Into Connection | LOW-MED | 3-4h | Low -- well-defined algorithm |
| D-8: Subpatcher Extract | HIGH | 8-12h | High -- inlet/outlet mapping is complex |

---

## Integration with Existing System

### What Changes

| Component | Current Role | New Role |
|-----------|-------------|----------|
| `patcher.py` Patcher class | Write-only builder | Read-write editor (add find/remove/modify methods) |
| `patcher.py` Box class | Write-only data holder | Read-write data holder (add attribute modification) |
| `patcher.py` from_dict() | Minimal loader for merge | Full-fidelity loader |
| `incremental.py` | Manifest-based merge | REMOVED (replaced by direct editing) |
| `layout.py` apply_layout() | Always runs on write | Only runs on NEW patches or explicit request |
| `validation.py` | Validates generated output | Validates edits (on demand, not on load) |
| `hooks.py` write_patch() | Generate + validate + write | Load + edit + validate + write (or just write) |
| `__init__.py` public API | generate_patch() central | edit_patch() / save_patch() central |
| Agent skills | Call generate.py scripts | Read .maxpat, make edits, write .maxpat |

### What Stays the Same

| Component | Why Unchanged |
|-----------|--------------|
| `db_lookup.py` ObjectDatabase | Still needed for creation-time validation (Rule #1) |
| `sizing.py` calculate_box_size() | Still needed for new objects |
| `maxclass_map.py` resolve_maxclass() | Still needed for new objects |
| `defaults.py` constants | Still needed for defaults |
| `aesthetics.py` styling helpers | Still needed for styling new objects |
| `validation.py` pipeline | Still needed (on demand) |
| `critics/` domain critics | Still needed for semantic review |
| `.claude/max-objects/` database | Core knowledge base unchanged |

---

## Prior Art Comparison

### py2max (shakfu/py2max)

py2max is the closest existing tool. It provides:
- `Patcher.from_file()` for loading .maxpat files
- `find_by_id()`, `find_by_text()`, `find_by_type()` for searching
- `save_as()` for writing back
- `MaxRefDB` with 1,157 objects in SQLite

**Our advantages over py2max:**
- 2,015-object database (vs 1,157) with overrides, aliases, relationships
- 4-layer validation pipeline (py2max has basic connection validation)
- Domain-specific critics (DSP, structure, RNBO, externals)
- Layout engine (py2max has basic layout)
- Content-aware box sizing from audit data
- Aesthetic styling system (panels, comments, backgrounds)
- Agent integration (py2max is a standalone library)

**What we should learn from py2max:**
- The `find_by_*` API pattern -- clean and intuitive
- Round-trip file handling approach
- Permissive loading (don't reject unknown objects)

### Cycling '74 JS API (Patcher object)

MAX's built-in JS API provides:
- `firstobject` + `apply()` for iteration
- `getnamed()` for finding by varname
- `getlogical()` for conditional search
- `connect()` / `disconnect()` for wiring
- `newdefault()` for positioned creation
- `applydeep()` for recursive traversal

**What we should learn from the JS API:**
- The `apply/applydeep` pattern for recursive operations
- Separate `connect`/`disconnect` (not combined "rewire")
- The `getlogical(testFn)` pattern -- filter by predicate

---

## Sources

- [py2max GitHub repository](https://github.com/shakfu/py2max) -- Python library for .maxpat generation and round-trip editing
- [Cycling '74 Patcher JS API](https://docs.cycling74.com/apiref/js/patcher/) -- Official MAX JS API for patcher manipulation
- [Cycling '74 .maxpat format discussion](https://cycling74.com/forums/specification-for-maxpat-json-format) -- No official spec exists; format is undocumented but stable JSON
- Codebase analysis: `src/maxpat/patcher.py`, `src/maxpat/incremental.py`, `src/maxpat/layout.py`, `src/maxpat/validation.py`, `src/maxpat/hooks.py`
- Real .maxpat analysis: `tests/fixtures/expected/simple_synth.maxpat`, `patches/kicksynth/generated/kicksynth.maxpat`
