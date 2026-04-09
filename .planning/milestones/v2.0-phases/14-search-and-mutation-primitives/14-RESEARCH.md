# Phase 14: Search and Mutation Primitives - Research

**Researched:** 2026-03-16
**Domain:** Python data model extension -- search, add, remove, connect operations on Patcher/Box/Patchline
**Confidence:** HIGH

## Summary

Phase 14 extends the existing Patcher data model (proven in Phase 13's round-trip foundation) with search and mutation capabilities. The work is entirely within `src/maxpat/patcher.py` and `src/maxpat/hooks.py` -- no new dependencies, no new files, no new external libraries. All changes are additive methods on the existing `Patcher` class plus a `read_patch()` convenience function.

The codebase is well-positioned for this phase. Phase 13 already established `_next_id` scanning in `from_dict()` (line 1233), the `Box.__new__(Box)` bypass pattern for loaded objects, and `save_patch_roundtrip()` in hooks.py. The existing `add_box()` and `add_connection()` methods work correctly on loaded patches -- they just need bounds checking and search needs to be added.

**Primary recommendation:** Implement as additive methods on the Patcher class. Search methods (`find_box`, `find_boxes`), mutation methods (`remove_box`, `remove_connection` with cleanup), bounds checking in `add_connection`, and `read_patch()` in hooks.py. Zero new dependencies.

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions
- **Search API**: Dual methods: `find_box()` returns first match (or None), `find_boxes()` returns list of all matches
- **Search criteria**: ID (exact), name (exact), maxclass (exact), text (substring) -- all four supported
- **Multiple criteria combine as AND** (all must match)
- **Opt-in recursion**: search current patcher only by default, pass `recursive=True` to search subpatchers
- **Recursive results return Box objects directly** (not tuples with path info)
- **Alias resolution**: searching by name resolves aliases automatically (e.g., "t" finds "trigger" objects)
- **Not found**: `find_box()` returns None, `find_boxes()` returns empty list -- no exceptions
- **DB validation by default**: `add_box()` validates against object DB and gets correct I/O counts (matching RW-03)
- **ID collision avoidance**: `from_dict()` scans all existing box IDs on load, sets `_next_id` to max+1
- **Explicit positioning**: `add_box()` accepts x, y coordinates (defaults to 0, 0 if not specified)
- **Auto-cleanup**: `remove_box()` automatically removes all patchlines connected to the box (matching RW-04)
- **Index bounds checking only**: verify outlet/inlet indices are within range, raise ValueError if out of bounds
- **No signal type compatibility checking** (loaded patches may have unknown objects without DB info)
- **Box objects only**: `add_connection()` and `remove_connection()` take Box instances, not string IDs
- **Exact tuple removal**: `remove_connection(src, outlet, dst, inlet)` removes that specific connection
- **Duplicate prevention**: `add_connection()` checks for existing identical connection, returns existing patchline if found
- **read_patch() returns (patcher, original_text) tuple** -- caller passes original_text to `save_patch_roundtrip()` for indent-preserving saves
- **Accepts both str and pathlib.Path** for file path
- **Structural validation on load**: verify "patcher" key and "boxes" array exist, raise ValueError on corrupt files
- **No object-level DB validation on load**
- **Auto-positioning is Phase 15** (ED-05) -- not in scope here

### Claude's Discretion
- Whether read_patch() lives in hooks.py (alongside write_patch/save_patch_roundtrip) or as Patcher.from_file() class method
- Internal implementation of recursive search (generator vs list accumulation)
- How existing add_box() is refactored vs adding new methods (may need add_box_raw() for structural objects)
- Error message wording for bounds checking and validation failures

### Deferred Ideas (OUT OF SCOPE)
None -- discussion stayed within phase scope
</user_constraints>

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|-----------------|
| RW-03 | User can add objects to a loaded patch with unique IDs, correct I/O counts, and DB validation -- existing objects undisturbed | `add_box()` already works on loaded patches (verified: _next_id=147 after loading kicksynth, new box gets obj-147). Need: duplicate prevention check. |
| RW-04 | User can remove objects from a loaded patch -- box and all connected patchlines removed cleanly | New `remove_box()` method. Must filter `self.lines` for any Patchline referencing the removed box's ID. |
| RW-05 | User can add and remove connections between existing objects with inlet/outlet bounds checking | `add_connection()` exists but has no bounds checking (verified: accepts outlet=999 without error). Need: bounds check + duplicate prevention + `remove_connection()`. |
| RW-07 | User can find objects by ID, name, maxclass, or text substring -- with optional recursive search into subpatchers | New `find_box()` and `find_boxes()` methods on Patcher. Alias resolution via `self.db._aliases`. |
</phase_requirements>

## Standard Stack

### Core
| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| Python stdlib only | 3.14+ | All implementation | Zero external dependencies per project decision |
| pathlib | stdlib | Path handling for read_patch() | Already used in hooks.py |
| json | stdlib | JSON parsing for read_patch() | Already used in hooks.py |

### Supporting
No new libraries needed. All operations are in-memory list/dict manipulations.

### Alternatives Considered
| Instead of | Could Use | Tradeoff |
|------------|-----------|----------|
| Linear list scan for search | Dict index by ID | Premature optimization -- patches have <500 boxes, O(n) scan is <1ms |
| Box ID string matching | Regex matching | Overkill -- IDs are exact match, text is simple `in` substring |

## Architecture Patterns

### Recommended Project Structure
No new files needed. All changes are in existing files:
```
src/maxpat/
  patcher.py   # New methods: find_box, find_boxes, remove_box, remove_connection
               # Modified: add_connection (bounds check + duplicate prevention)
  hooks.py     # New function: read_patch()
  __init__.py   # Export: read_patch
```

### Pattern 1: Search Methods on Patcher

**What:** `find_box()` and `find_boxes()` as instance methods on Patcher class, matching the established pattern of `add_box()`, `add_connection()`, etc.

**When to use:** Always -- search is a Patcher operation.

**Key design notes:**
- `find_box()` short-circuits on first match (performance for large patches)
- `find_boxes()` collects all matches into a list
- Both accept keyword arguments: `id=`, `name=`, `maxclass=`, `text=`
- Multiple criteria: AND semantics (all must match)
- `recursive=True` walks `box._inner_patcher` recursively
- Alias resolution: when `name=` is specified, resolve via `self.db._aliases` before comparison

**Example:**
```python
# Search by name (alias resolved: "t" matches boxes with name "trigger")
box = patcher.find_box(name="t")

# Search by text substring
boxes = patcher.find_boxes(text="cycle~")

# Search by multiple criteria (AND)
box = patcher.find_box(maxclass="newobj", text="dac~")

# Recursive search into subpatchers
all_cycle = patcher.find_boxes(name="cycle~", recursive=True)
```

**Implementation detail -- alias resolution:**
```python
# When name= is provided, also match boxes whose name equals the canonical form
# For loaded boxes, box.name is derived from text.split()[0]
# So searching name="t" should match boxes where text starts with "t " or "trigger "
# Resolution: resolve alias to canonical, then match box.name against BOTH alias and canonical
```

**Critical subtlety:** For loaded boxes, `box.name` is derived from `box.text.split()[0]`. A box loaded from a patch containing `"text": "t b i f"` will have `box.name = "t"`. Searching `name="trigger"` should find this box (reverse alias resolution), and searching `name="t"` should also find it. The search must compare against both the alias and canonical name.

### Pattern 2: Mutation Methods with Cleanup

**What:** `remove_box()` removes a box AND all connected patchlines. `remove_connection()` removes a specific patchline.

**Key design notes:**
- `remove_box(box)` takes a Box instance (consistent with `add_connection` taking Box instances)
- Must remove from `self.boxes` list AND filter `self.lines` to remove any Patchline where `source_id == box.id` or `dest_id == box.id`
- `remove_connection(src, outlet, dst, inlet)` finds and removes the matching Patchline

**Example:**
```python
# Remove a box -- all connected lines auto-cleaned
patcher.remove_box(old_box)

# Remove a specific connection
patcher.remove_connection(src_box, 0, dst_box, 0)
```

### Pattern 3: Bounds Checking in add_connection

**What:** Add inlet/outlet index validation to the existing `add_connection()` method.

**Key design notes:**
- Check `src_outlet < src_box.numoutlets` (0-indexed)
- Check `dst_inlet < dst_box.numinlets` (0-indexed)
- Also check `src_outlet >= 0` and `dst_inlet >= 0`
- Raise `ValueError` with clear message including box ID, requested index, and actual count
- Check for existing identical connection before creating (duplicate prevention)

**Example error:**
```python
ValueError: "Outlet index 2 out of range for box obj-1 (cycle~ 440) which has 1 outlet(s) (valid: 0..0)"
```

### Pattern 4: read_patch() Convenience Function

**What:** Single function that loads a .maxpat file, validates structure, returns (Patcher, original_text) tuple.

**Recommendation for Claude's Discretion:** Place in `hooks.py` alongside `save_patch_roundtrip()`. The two form a natural read/write pair. A `Patcher.from_file()` class method would work too, but would need to return a tuple (Patcher, original_text) which is awkward for a class method. `hooks.py` already has the file I/O pattern established.

**Implementation:**
```python
def read_patch(path: str | Path) -> tuple[Patcher, str]:
    """Load a .maxpat file into a Patcher ready for querying and editing.

    Returns (patcher, original_text) tuple. Pass original_text to
    save_patch_roundtrip() for indent-preserving saves.
    """
    path = Path(path)
    original_text = path.read_text()
    data = json.loads(original_text)

    # Structural validation (already in from_dict, but check here for better error)
    if "patcher" not in data:
        raise ValueError(f"Invalid .maxpat file: {path} -- missing 'patcher' key")

    patcher = Patcher.from_dict(data)
    return (patcher, original_text)
```

### Anti-Patterns to Avoid
- **Searching by string ID instead of Box reference for mutations:** The API uses Box objects for add/remove connection, not string IDs. This prevents stale-reference bugs.
- **Modifying self.lines during iteration:** When removing lines connected to a box, build a new list via list comprehension rather than removing in-place during iteration.
- **Forgetting recursive _next_id:** Inner patchers have their own `_next_id` scope. Adding a box to an inner patcher must use that patcher's `_next_id`, not the parent's. This already works correctly because `add_box` uses `self._gen_id()`.
- **Breaking round-trip for existing boxes:** New boxes added via `add_box()` will not have `_raw` (they use the creation path). Existing loaded boxes must keep their `_raw` untouched. This is already handled correctly by the dual-path serialization.

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Alias resolution | Custom alias dict | `self.db._aliases` (already loaded) | Single source of truth, stays in sync with aliases.json |
| Variable I/O counts | Manual inlet/outlet counting | `self.db.compute_io_counts()` | Handles trigger, pack, route, etc. correctly per formulas |
| JSON indentation | Custom formatter | `json.dumps(indent=...)` + `detect_indent()` | Already proven in Phase 13 |
| Box dict structure | Custom dict builder | `Box.to_dict()` dual-path | Already handles round-trip vs creation path |

## Common Pitfalls

### Pitfall 1: Alias Direction in Search
**What goes wrong:** Only matching `name="t"` against boxes with `box.name == "t"`, missing boxes that were created with the canonical name "trigger" and stored as `box.name = "trigger"`.
**Why it happens:** Alias resolution is one-directional (alias -> canonical) but search needs to work in both directions.
**How to avoid:** When `name=` is provided to search, compute the canonical form. Then match boxes where `box.name == given_name` OR `box.name == canonical_name`. Also match boxes where `box.name` is an alias that resolves to the same canonical.
**Warning signs:** `find_box(name="trigger")` finds nothing when the patch was built with `add_box("trigger")` but the loaded text says "trigger".

### Pitfall 2: Patchline Cleanup Missing Inner Patcher References
**What goes wrong:** Removing a box that has connections only in the parent patcher, but forgetting that patchlines reference boxes by ID string, not by object reference.
**Why it happens:** `Patchline.source_id` and `Patchline.dest_id` are strings matching `Box.id`.
**How to avoid:** `remove_box()` must filter `self.lines` matching on `box.id` string comparison.
**Warning signs:** Dangling patchlines after removal -- patchline references a box ID that no longer exists.

### Pitfall 3: Mutation After Load Breaks Round-Trip for Untouched Boxes
**What goes wrong:** Adding a new box or connection causes other boxes' `_raw` dicts to be modified.
**Why it happens:** Accidental shared references from `copy.deepcopy` shortcutting.
**How to avoid:** `add_box()` and `add_connection()` only create new objects and append to lists. They never touch existing boxes' `_raw`. Verify with tests.
**Warning signs:** Round-trip test fails after adding a new box to a loaded patch.

### Pitfall 4: Bounds Check Uses Wrong Comparison
**What goes wrong:** Using `>=` instead of `>` (or vice versa) for outlet/inlet bounds checking.
**Why it happens:** Outlets/inlets are 0-indexed. A box with `numoutlets=1` has valid outlet index `0` only.
**How to avoid:** Check `src_outlet >= src_box.numoutlets` (not `>`), since valid range is `0..numoutlets-1`.
**Warning signs:** Off-by-one: either rejecting valid index N-1 or accepting invalid index N.

### Pitfall 5: Duplicate Connection Check Missing Order/Hidden Fields
**What goes wrong:** Two connections with same src/outlet/dst/inlet but different order values are considered duplicates.
**Why it happens:** Checking all four fields (src, outlet, dst, inlet) is correct for duplicate detection. Order and hidden are metadata, not identity.
**How to avoid:** Duplicate detection should only compare the four identity fields: source_id, source_outlet, dest_id, dest_inlet. MAX itself treats these as the connection identity.
**Warning signs:** MAX patch has multiple lines between the same outlet/inlet pair with different order values (rare but valid).

### Pitfall 6: read_patch() Error on Bare Patcher Dict
**What goes wrong:** Some .maxpat files may be bare patcher dicts without the top-level `{"patcher": ...}` wrapper.
**Why it happens:** `from_dict()` already handles this case (line 1113-1118), but `read_patch()` might add an extra check that's too strict.
**How to avoid:** Let `from_dict()` handle the structural validation -- it already supports both formats. `read_patch()` should just call `from_dict()` after JSON parsing.
**Warning signs:** `read_patch()` raises on valid files that `from_dict()` would accept.

## Code Examples

Verified patterns from the existing codebase:

### Existing add_box() (patcher.py:352) -- No Changes Needed
```python
def add_box(
    self,
    name: str,
    args: list[str] | None = None,
    x: float = 0.0,
    y: float = 0.0,
) -> Box:
    box_id = self._gen_id()
    box = Box(name=name, args=args, box_id=box_id, db=self.db, x=x, y=y)
    self.boxes.append(box)
    return box
```
This already works correctly on loaded patches because `_next_id` is set to `max_id_num + 1` during `from_dict()`.

### Existing add_connection() (patcher.py:641) -- Needs Bounds Check + Duplicate Prevention
```python
def add_connection(
    self,
    src_box: Box,
    src_outlet: int,
    dst_box: Box,
    dst_inlet: int,
    order: int = 0,
    hidden: bool = False,
    midpoints: list[float] | None = None,
) -> Patchline:
    # CURRENT: No bounds checking, no duplicate prevention
    pl = Patchline(...)
    self.lines.append(pl)
    return pl
```

### Existing from_dict() ID Scanning (patcher.py:1204-1233)
```python
# Already in place from Phase 13
# Track max ID number
try:
    id_num = int(box.id.split("-")[-1])
    if id_num > max_id_num:
        max_id_num = id_num
except (ValueError, IndexError):
    pass  # Non-standard IDs handled gracefully

p._next_id = max_id_num + 1
```

### Alias Resolution (db_lookup.py:83-93)
```python
def lookup(self, name: str) -> dict | None:
    canonical = self._aliases.get(name, name)
    return self._objects.get(canonical)
```
The `_aliases` dict maps: `{"t": "trigger", "b": "bangbang", "sel": "select", ...}`

### Patchline Identity Fields
```python
# A patchline is uniquely identified by these four fields:
source_id: str      # e.g., "obj-1"
source_outlet: int  # e.g., 0
dest_id: str        # e.g., "obj-2"
dest_inlet: int     # e.g., 0
```

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| generate.py scripts | Direct .maxpat editing | v2.0 (current) | Patches are standalone, no intermediary scripts |
| Write-only Patcher | Read-write Patcher | Phase 13 (complete) | from_dict() loads any .maxpat with lossless round-trip |
| No ID tracking on load | _next_id = max_id_num + 1 | Phase 13 Plan 03 | New boxes on loaded patches get unique IDs |

## Open Questions

1. **Reverse alias resolution for search**
   - What we know: `_aliases` maps alias -> canonical (e.g., "t" -> "trigger"). Loaded boxes have `box.name = text.split()[0]`, which preserves the original alias form.
   - What's unclear: Should `find_box(name="trigger")` match a box loaded from text "t b i f"? The box's `name` field is "t", not "trigger".
   - Recommendation: Build a reverse lookup (canonical -> set of aliases) from `_aliases`. When searching by name, check both the given name AND all aliases/canonical forms. This ensures bidirectional matching. Cost: one-time dict build on first search call.

2. **Whether to build a box-by-ID index for O(1) lookup**
   - What we know: `find_box(id="obj-42")` currently requires linear scan.
   - What's unclear: Whether patches are large enough to warrant an index.
   - Recommendation: Don't build an index yet. MAX patches rarely exceed 500 boxes. Linear scan is <1ms. An index would need invalidation on add/remove, adding complexity for negligible gain. If profiling later shows this is a bottleneck, it can be added without API changes.

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | pytest 9.0.2 |
| Config file | pyproject.toml or implicit discovery |
| Quick run command | `python3 -m pytest tests/test_round_trip.py tests/test_patcher.py -x -q` |
| Full suite command | `python3 -m pytest tests/ -q` |

### Phase Requirements to Test Map
| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| RW-03 | add_box on loaded patch: unique ID, correct I/O, DB validation | unit | `python3 -m pytest tests/test_patcher.py -x -k "add_box"` | Partial (creation-path tests exist, no loaded-patch tests) |
| RW-04 | remove_box removes box + connected patchlines | unit | `python3 -m pytest tests/test_patcher.py -x -k "remove_box"` | No -- Wave 0 |
| RW-05 | add_connection bounds check + remove_connection | unit | `python3 -m pytest tests/test_patcher.py -x -k "connection"` | Partial (add_connection exists, no bounds check tests) |
| RW-07 | find_box/find_boxes by ID/name/maxclass/text, recursive, alias | unit | `python3 -m pytest tests/test_patcher.py -x -k "find"` | No -- Wave 0 |
| RW-07+RW-03 | read_patch loads file and returns (Patcher, original_text) | unit | `python3 -m pytest tests/test_hooks.py -x -k "read_patch"` | No -- Wave 0 |
| RW-02+RW-03 | add_box on loaded patch preserves existing boxes' round-trip | integration | `python3 -m pytest tests/test_round_trip.py -x` | No -- Wave 0 |

### Sampling Rate
- **Per task commit:** `python3 -m pytest tests/test_patcher.py tests/test_round_trip.py tests/test_hooks.py -x -q`
- **Per wave merge:** `python3 -m pytest tests/ -q`
- **Phase gate:** Full suite green before `/gsd:verify-work`

### Wave 0 Gaps
- [ ] `tests/test_patcher.py` needs new test classes: `TestFindBox`, `TestFindBoxes`, `TestRemoveBox`, `TestRemoveConnection`, `TestAddConnectionBoundsCheck`, `TestAddBoxOnLoadedPatch`
- [ ] `tests/test_hooks.py` needs new test class: `TestReadPatch`
- [ ] `tests/test_round_trip.py` needs new test class: `TestMutationPreservesRoundTrip` (add box to loaded patch, verify existing boxes unchanged)

## Sources

### Primary (HIGH confidence)
- **Codebase inspection**: `src/maxpat/patcher.py` (1259 lines) -- complete read of Patcher, Box, Patchline classes
- **Codebase inspection**: `src/maxpat/hooks.py` (325 lines) -- complete read of save_patch_roundtrip, detect_indent
- **Codebase inspection**: `src/maxpat/db_lookup.py` (200 lines) -- alias resolution, I/O computation
- **Codebase inspection**: `tests/test_round_trip.py` (907 lines) -- 31 round-trip tests, all passing
- **Codebase inspection**: `tests/test_patcher.py` (68 tests) -- creation path tests, all passing
- **Runtime verification**: `_next_id=147` after loading kicksynth.maxpat (146 boxes), `add_box()` generates `obj-147` with no collision
- **Runtime verification**: `add_connection(b1, 999, b2, 888)` succeeds without error (confirming no bounds checking)
- **Runtime verification**: All project patches use standard `obj-N` ID format (no non-standard IDs found)

### Secondary (MEDIUM confidence)
- **CONTEXT.md decisions**: Locked by user in discussion phase -- all implementation choices verified against codebase feasibility

### Tertiary (LOW confidence)
- None

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH -- zero new dependencies, all stdlib, verified against existing codebase
- Architecture: HIGH -- all patterns are additive methods on existing classes, no structural changes
- Pitfalls: HIGH -- all pitfalls identified from actual codebase inspection and runtime verification

**Research date:** 2026-03-16
**Valid until:** 2026-04-16 (stable -- internal Python codebase, no external dependency drift)
