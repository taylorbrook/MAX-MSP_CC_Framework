# Phase 14: Search and Mutation Primitives - Context

**Gathered:** 2026-03-16
**Status:** Ready for planning

<domain>
## Phase Boundary

Find objects in loaded patches and make basic structural edits (add, remove, connect) without disturbing existing content. Covers requirements RW-03 (add objects), RW-04 (remove objects), RW-05 (add/remove connections), RW-07 (find objects).

Scope: search methods, add/remove box, add/remove connection, read_patch() convenience function. NOT in-place modification, insert-into-connection, graph traversal, or auto-positioning (Phase 15+).

</domain>

<decisions>
## Implementation Decisions

### Search API
- Dual methods: `find_box()` returns first match (or None), `find_boxes()` returns list of all matches
- Search criteria: ID (exact), name (exact), maxclass (exact), text (substring) -- all four supported
- Multiple criteria combine as AND (all must match)
- Opt-in recursion: search current patcher only by default, pass `recursive=True` to search subpatchers
- Recursive results return Box objects directly (not tuples with path info)
- Alias resolution: searching by name resolves aliases automatically (e.g., "t" finds "trigger" objects)
- Not found: `find_box()` returns None, `find_boxes()` returns empty list -- no exceptions

### Add objects to loaded patches
- DB validation by default: `add_box()` validates against object DB and gets correct I/O counts (matching RW-03)
- ID collision avoidance: `from_dict()` scans all existing box IDs on load, sets `_next_id` to max+1
- Explicit positioning: `add_box()` accepts x, y coordinates (defaults to 0, 0 if not specified)
- Auto-positioning is Phase 15 (ED-05) -- not in scope here

### Remove objects
- Auto-cleanup: `remove_box()` automatically removes all patchlines connected to the box (matching RW-04)
- No dangling connections after removal

### Connection validation
- Index bounds checking only: verify outlet/inlet indices are within range, raise ValueError if out of bounds
- No signal type compatibility checking (loaded patches may have unknown objects without DB info)
- Box objects only: `add_connection()` and `remove_connection()` take Box instances, not string IDs
- Exact tuple removal: `remove_connection(src, outlet, dst, inlet)` removes that specific connection
- Duplicate prevention: `add_connection()` checks for existing identical connection, returns existing patchline if found (matches MAX behavior)

### read_patch() convenience function
- Returns `(patcher, original_text)` tuple -- caller passes original_text to `save_patch_roundtrip()` for indent-preserving saves
- Accepts both `str` and `pathlib.Path` for file path
- Structural validation on load: verify "patcher" key and "boxes" array exist, raise ValueError on corrupt files
- No object-level DB validation on load (consistent with Phase 13 decision)

### Claude's Discretion
- Whether read_patch() lives in hooks.py (alongside write_patch/save_patch_roundtrip) or as Patcher.from_file() class method
- Internal implementation of recursive search (generator vs list accumulation)
- How existing add_box() is refactored vs adding new methods (may need add_box_raw() for structural objects)
- Error message wording for bounds checking and validation failures

</decisions>

<specifics>
## Specific Ideas

- The existing `add_box()` API signature (name, args, x, y) should be preserved -- new behavior is additive
- `_next_id` scan in `from_dict()` should handle non-standard ID formats gracefully (some patches may have non-"obj-N" IDs)
- `add_connection()` already exists but lacks bounds checking -- this phase adds bounds checking to the existing method

</specifics>

<code_context>
## Existing Code Insights

### Reusable Assets
- `add_box()` (patcher.py:352): already creates validated boxes with DB lookup -- needs ID collision fix for loaded patches
- `add_connection()` (patcher.py:641): already connects boxes by Box object -- needs bounds checking added
- `_gen_id()` (patcher.py:346): simple incrementing counter -- needs `_next_id` to be set correctly after loading
- `from_dict()` (patcher.py:1098): loads patches from dicts -- needs to scan max ID
- `save_patch_roundtrip()` (hooks.py:49): indent-preserving saves -- read_patch() complements this
- `aliases.json`: alias-to-canonical-name mapping -- used for alias resolution in search

### Established Patterns
- `Box.__new__()` bypass: creates structural objects (subpatchers, gen~, etc.) without DB validation -- pattern for loaded objects
- `_handled_keys` / `extra_attrs` pattern: known keys get named fields, unknown keys go to extra_attrs dict
- `_raw` dict: round-trip preservation of original data -- new boxes won't have _raw (creation path)

### Integration Points
- `patcher.py` Patcher class: find_box/find_boxes/remove_box/remove_connection added as methods
- `hooks.py`: read_patch() added alongside existing write functions
- `from_dict()`: needs _next_id scan added at end of loading
- `add_connection()`: needs bounds checking added to existing method

</code_context>

<deferred>
## Deferred Ideas

None -- discussion stayed within phase scope

</deferred>

---

*Phase: 14-search-and-mutation-primitives*
*Context gathered: 2026-03-16*
