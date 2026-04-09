# Phase 15: Intelligent Editing - Context

**Gathered:** 2026-03-16
**Status:** Ready for planning

<domain>
## Phase Boundary

Higher-level edit operations on loaded patches: modify attributes in-place, insert objects into connections, replace/swap objects, graph queries (traversal and analysis), and smart auto-positioning. Covers requirements ED-01, ED-02, ED-03, ED-04, ED-05.

Scope: modify_box(), insert_into_connection(), replace_box(), graph traversal/query methods, auto-positioning. NOT patch analysis/summarization (Phase 16) or agent migration (Phase 17).

</domain>

<decisions>
## Implementation Decisions

### Connection fate on edits
- When modify_box() changes args and I/O count shrinks, orphaned connections are auto-removed but returned in the result as a list -- caller knows what was lost and can rewire or warn
- replace_box() does NOT auto-remap connections -- all connections from the old object are orphaned and returned to the caller for manual rewiring
- When insert or modify encounters I/O mismatch, report the issue and let the caller decide how to proceed rather than silently doing partial work or hard-failing

### Modify scope
- modify_box() changes attributes only: args (with I/O recomputation for variable_io), position, color, extra_attrs
- To change the object type (e.g., cycle~ to saw~), use replace_box() -- clear separation of concerns
- _raw dict updated in-place on modification to preserve round-trip fidelity

### Insert semantics
- Insert affects ALL matching connections between the source and destination objects (e.g., stereo connections both get the insert)
- One shared inserted object wired to all matching connections, not separate objects per connection
- If the inserted object has fewer inlets/outlets than connections being inserted into, report the mismatch and ask how to proceed rather than partial insert or hard fail
- Auto-position inserted objects below the source object with standard spacing (not midpoint)

### Graph queries
- Upstream/downstream traversal: full chain by default (follow all the way to sources/sinks)
- Signal path tracing: trace audio signal chains (~ objects only), ignoring control connections
- Connected components: identify groups of interconnected objects isolated from the rest
- Signal vs control graph split: NOT included (3 of 4 capabilities selected)
- Traversal crosses subpatcher boundaries by default (follows through inlet~/outlet~ objects)
- Results ordered by outlet index (left to right) for natural signal-flow reading order

### Auto-positioning
- Basic collision nudge: try ideal position first, if occupied nudge right or down until empty spot found
- Always snap to MAX's 15px grid (consistent with Phase 11 layout engine)
- Default position for add_box() without explicit coordinates: center of patcher's visible rect area
- Insert positioning: below the source object with standard spacing
- No full patch re-layout -- only the new object is positioned

### Claude's Discretion
- Internal data structures for graph traversal (adjacency list, lazy vs eager building)
- Exact collision detection box size/padding
- Error message wording
- Whether graph queries use generator/iterator or return full lists
- _raw dict update strategy details for modify_box()

</decisions>

<specifics>
## Specific Ideas

- Orphaned connection return pattern should be consistent across modify_box() and replace_box() -- both return a list of removed connections
- replace_box() returning ALL old connections as orphaned (no auto-remap) is a deliberate choice for safety -- agents can implement their own remapping logic on top
- Graph traversal crossing subpatcher boundaries differs from Phase 14's find_boxes() which defaults to current patcher only -- this reflects that graph analysis is inherently about following connections wherever they go

</specifics>

<code_context>
## Existing Code Insights

### Reusable Assets
- `add_connection()` (patcher.py:641): bounds checking and duplicate prevention already implemented -- insert_into_connection() uses this
- `remove_connection()` (patcher.py:734): exact tuple removal -- used by insert and replace operations
- `remove_box()` (patcher.py:714): auto-removes connected patchlines -- pattern for replace_box()
- `find_boxes()` (patcher.py:768): recursive search with alias resolution -- graph traversal can use similar recursion
- `db.compute_io_counts()` (db_lookup.py:132): variable I/O recomputation -- needed when modify_box() changes args
- Grid snapping: Phase 11 layout engine already snaps to 15px grid -- reuse snap function
- `_raw` dict pattern: Box.to_dict() already overlays mutations onto _raw for round-trip -- modify_box() extends this

### Established Patterns
- Dual-path serialization (_raw round-trip vs creation path) -- modify_box() must keep _raw in sync
- Orphaned connection list pattern: new to Phase 15 but consistent with how remove_box() handles cleanup
- `_inner_patcher` for subpatcher traversal -- graph queries traverse through these

### Integration Points
- `patcher.py` Patcher class: new methods (modify_box, insert_into_connection, replace_box, upstream, downstream, signal_path, connected_components)
- `patcher.py` Box class: modify_box() may be a Patcher method (needs access to lines list) or Box method with patcher reference
- `defaults.py` LayoutOptions: may need auto-position defaults added
- `sizing.py` calculate_box_size(): called when modify_box() changes text/args

</code_context>

<deferred>
## Deferred Ideas

None -- discussion stayed within phase scope

</deferred>

---

*Phase: 15-intelligent-editing*
*Context gathered: 2026-03-16*
