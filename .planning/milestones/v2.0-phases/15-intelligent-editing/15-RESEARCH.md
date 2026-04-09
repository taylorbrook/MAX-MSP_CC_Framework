# Phase 15: Intelligent Editing - Research

**Researched:** 2026-03-16
**Domain:** Patch graph manipulation, in-place attribute editing, auto-positioning
**Confidence:** HIGH

## Summary

Phase 15 adds five intelligent editing capabilities to the existing Patcher/Box/Patchline model: in-place attribute modification (modify_box), connection insertion (insert_into_connection), object replacement (replace_box), graph traversal queries (upstream/downstream/signal_path/connected_components), and smart auto-positioning for newly added objects. All five are pure Python methods on the existing Patcher class with zero external dependencies.

The codebase is exceptionally well-prepared for this phase. Phase 14 established add_box, remove_box, add_connection, remove_connection, find_box/find_boxes with bounds checking and duplicate prevention. Phase 13 established the dual-path serialization (_raw round-trip vs creation path) that modify_box must respect. The layout module already contains _find_components (connected components via BFS), _build_graph (adjacency lists), _snap_to_grid, and _outlet_x/_inlet_x helpers that graph queries and auto-positioning can reuse directly.

**Primary recommendation:** Implement all five capabilities as new methods on Patcher, reusing existing graph infrastructure from layout.py. Build the lightweight adjacency graph lazily (on first query call) and expose it through clean traversal methods. All position math snaps to 15px grid.

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions
- When modify_box() changes args and I/O count shrinks, orphaned connections are auto-removed but returned in the result as a list -- caller knows what was lost and can rewire or warn
- replace_box() does NOT auto-remap connections -- all connections from the old object are orphaned and returned to the caller for manual rewiring
- When insert or modify encounters I/O mismatch, report the issue and let the caller decide how to proceed rather than silently doing partial work or hard-failing
- modify_box() changes attributes only: args (with I/O recomputation for variable_io), position, color, extra_attrs
- To change the object type (e.g., cycle~ to saw~), use replace_box() -- clear separation of concerns
- _raw dict updated in-place on modification to preserve round-trip fidelity
- Insert affects ALL matching connections between the source and destination objects (e.g., stereo connections both get the insert)
- One shared inserted object wired to all matching connections, not separate objects per connection
- If the inserted object has fewer inlets/outlets than connections being inserted into, report the mismatch and ask how to proceed rather than partial insert or hard fail
- Auto-position inserted objects below the source object with standard spacing (not midpoint)
- Upstream/downstream traversal: full chain by default (follow all the way to sources/sinks)
- Signal path tracing: trace audio signal chains (~ objects only), ignoring control connections
- Connected components: identify groups of interconnected objects isolated from the rest
- Signal vs control graph split: NOT included (3 of 4 capabilities selected)
- Traversal crosses subpatcher boundaries by default (follows through inlet~/outlet~ objects)
- Results ordered by outlet index (left to right) for natural signal-flow reading order
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

### Deferred Ideas (OUT OF SCOPE)
None -- discussion stayed within phase scope
</user_constraints>

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|-----------------|
| ED-01 | Modify object attributes in-place -- change args (with I/O recomputation), position, color, or any property without remove-and-recreate | modify_box() method on Patcher; uses db.compute_io_counts() for variable_io; updates _raw dict in-place; returns orphaned connections list |
| ED-02 | Insert object into existing connection -- original connection removed, new box wired between source and destination, auto-positioned | insert_into_connection() method; uses remove_connection + add_box + add_connection; positions below source with V_SPACING |
| ED-03 | Replace/swap object -- new object at same position, all connections returned as orphaned list | replace_box() method; creates new box at old position, removes old box, returns all old connections |
| ED-04 | Query patch graph -- upstream/downstream traversal, signal path tracing, connected components | Graph query methods using adjacency dict from _build_graph; BFS/DFS traversal; signal filtering by ~ suffix; reuse _find_components pattern from layout.py |
| ED-05 | Auto-position new objects intelligently near connection context | Smart positioning helper integrated into add_box and insert_into_connection; collision detection with nudge; 15px grid snap |
</phase_requirements>

## Standard Stack

### Core
| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| Python stdlib collections | 3.14 | defaultdict, deque for graph operations | Already used in layout.py for identical graph operations |
| Python stdlib typing | 3.14 | Type hints for return types | Project convention |

### Supporting
No additional libraries needed. All functionality builds on existing codebase.

### Alternatives Considered
| Instead of | Could Use | Tradeoff |
|------------|-----------|----------|
| Hand-rolled adjacency dict | networkx | Massive dependency for simple BFS/DFS; layout.py already proves hand-rolled is sufficient |
| Lazy graph building | Eager rebuild on every mutation | Eager is simpler but wasteful; lazy is fine since graph queries are read-only |

**Installation:**
```bash
# No new dependencies -- pure stdlib + existing codebase
```

## Architecture Patterns

### Recommended Project Structure
```
src/maxpat/
    patcher.py        # New methods: modify_box, insert_into_connection, replace_box,
                      #   upstream, downstream, signal_path, connected_components,
                      #   _auto_position (private helper)
    layout.py         # UNCHANGED -- existing _find_components, _build_graph, _snap_to_grid
                      #   reusable but NOT imported (graph queries need Patchline-level detail)
    defaults.py       # May add DEFAULT_COLLISION_PADDING constant
    db_lookup.py      # UNCHANGED -- compute_io_counts already exists
```

### Pattern 1: Orphaned Connection Return
**What:** All mutation methods that can orphan connections return them as a list of tuples.
**When to use:** modify_box (I/O shrink), replace_box (all connections), insert_into_connection (I/O mismatch).
**Example:**
```python
# Consistent return type across all mutation methods
@dataclass
class EditResult:
    """Result of an edit operation with orphaned connection tracking."""
    box: Box  # The modified/created box
    orphaned: list[dict]  # List of removed connection info dicts
    # Each orphaned entry: {"source_id", "source_outlet", "dest_id", "dest_inlet"}

def modify_box(self, box: Box, *, args=None, position=None, color=None,
               extra_attrs=None) -> EditResult:
    ...
```

### Pattern 2: _raw Dict In-Place Update for modify_box
**What:** When modifying a loaded box's attributes, update _raw dict directly to preserve round-trip fidelity.
**When to use:** modify_box() when the box has a _raw dict (loaded from file).
**Example:**
```python
# Round-trip-safe attribute modification
if box._raw is not None:
    if new_args is not None:
        # Update text in _raw
        box._raw["text"] = new_text
    if new_position is not None:
        box._raw["patching_rect"] = box.patching_rect
    # Other _raw fields updated similarly
```
**Key insight:** Box.to_dict() already overlays patching_rect, numinlets, numoutlets from Python attrs onto _raw. But text and other fields come directly from _raw in round-trip mode. So modify_box must update _raw["text"] when args change, or the old text will persist in round-trip output.

### Pattern 3: Graph Adjacency as Method-Local Build
**What:** Build directed adjacency dict inside each graph query method from self.lines.
**When to use:** upstream, downstream, signal_path, connected_components.
**Example:**
```python
def _build_adj(self, signal_only: bool = False) -> tuple[dict, dict]:
    """Build forward and reverse adjacency dicts from self.lines.

    Returns:
        (forward_adj, reverse_adj) where keys are box IDs and values are
        lists of (box_id, outlet_idx, inlet_idx) tuples.
    """
    forward = defaultdict(list)
    reverse = defaultdict(list)
    for line in self.lines:
        if signal_only:
            src_box = self._box_by_id.get(line.source_id)
            dst_box = self._box_by_id.get(line.dest_id)
            if not src_box or not dst_box:
                continue
            if not src_box.name.endswith("~") and not dst_box.name.endswith("~"):
                continue
        forward[line.source_id].append(line.dest_id)
        reverse[line.dest_id].append(line.source_id)
    return forward, reverse
```
**Design decision:** Build graph fresh each call rather than caching. Patch mutations (add/remove box/connection) would invalidate a cache. The graph build is O(lines) which is fast for typical MAX patches (< 1000 lines). If performance becomes a concern, add lazy caching with invalidation later.

### Pattern 4: Collision Detection with Nudge
**What:** Check if a proposed position overlaps any existing box, nudge right then down until clear.
**When to use:** Auto-positioning in insert_into_connection, smart add_box.
**Example:**
```python
GRID = 15.0
COLLISION_PAD = 5.0  # Extra padding around boxes for readability

def _find_clear_position(self, x: float, y: float, w: float, h: float) -> tuple[float, float]:
    """Find nearest non-overlapping position starting from (x, y)."""
    x = round(x / GRID) * GRID
    y = round(y / GRID) * GRID

    for attempt in range(50):  # Safety limit
        if not self._overlaps_any(x, y, w, h):
            return (x, y)
        # Try nudging right first
        x += GRID
        if x > 1200:  # Wrap to next row
            x = round(original_x / GRID) * GRID
            y += GRID
    return (x, y)  # Give up, return best effort
```

### Pattern 5: Subpatcher Boundary Traversal
**What:** Graph traversal follows connections through subpatcher boundaries via inlet~/outlet~ objects.
**When to use:** upstream/downstream traversal when recursive=True (default per CONTEXT.md).
**Example:**
```python
# When traversing downstream from a box and hitting a subpatcher:
# 1. The connection enters the subpatcher box at inlet N
# 2. Inside the subpatcher, find the inlet~ object at position N
# 3. Continue traversal from that inlet~ object's connections
# 4. When reaching an outlet~ object, return to parent patcher
#    and continue from the subpatcher box's corresponding outlet
```
**Key insight:** Subpatcher boundary crossing requires access to the parent-child patcher relationship. Each box with _inner_patcher contains the inner patcher. The inlet/outlet objects inside map 1:1 to the parent box's inlets/outlets by their argument number.

### Anti-Patterns to Avoid
- **Mutating during iteration:** When orphaning connections in modify_box, build the orphaned list first, then remove. remove_box already demonstrates this pattern (builds new list via comprehension).
- **Forgetting _raw sync:** Modifying box.text or box.args without updating box._raw["text"] will cause stale data in round-trip output. Always sync both.
- **Re-implementing graph operations:** layout.py has _build_graph and _find_components. The patcher.py graph queries need Patchline-level detail (outlet/inlet indices) that layout.py's version discards, so we need our own adjacency build. But the BFS/DFS patterns are identical.
- **Auto-layout on edit:** Phase 15 explicitly does NOT re-layout the patch. Only the new/modified object is positioned. Existing object positions are sacred.

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Variable I/O recomputation | Custom arg parsing per object type | `db.compute_io_counts(name, args)` | Already handles all variable_io rules from overrides.json |
| Outlet type derivation | Custom type inference | `db.get_outlet_types(name, args)` | Already handles signal/control/multichannel types |
| Box sizing after arg change | Manual width calculation | `calculate_box_size(text, maxclass)` | Already handles text-based sizing, UI sizes, width overrides |
| Connected components | New BFS implementation | Reuse pattern from `layout._find_components` | Same undirected BFS algorithm; copy the approach |
| Grid snapping | Manual rounding | `round(x / 15.0) * 15.0` pattern from `layout._snap_to_grid` | Consistent 15px grid already established |
| Signal type checking | Custom name parsing | `box.name.endswith("~")` | MAX convention: all signal objects end with ~ |

**Key insight:** The existing codebase has solved nearly every sub-problem Phase 15 needs. The new code orchestrates existing primitives rather than building from scratch.

## Common Pitfalls

### Pitfall 1: _raw Desync on Argument Change
**What goes wrong:** modify_box changes box.args and box.text but forgets to update box._raw["text"]. On serialization, Box.to_dict() uses _raw path and emits the OLD text.
**Why it happens:** Box.to_dict() round-trip path overlays patching_rect, numinlets, numoutlets from Python attrs, but text comes from _raw directly (it's not in the overlay list).
**How to avoid:** modify_box must explicitly update _raw["text"] whenever args change. Also update _raw["numinlets"], _raw["numoutlets"] for round-trip consistency (even though to_dict overlays these, keeping _raw accurate avoids confusion).
**Warning signs:** Test that modifies args on a loaded box, serializes, and checks text field in output.

### Pitfall 2: Orphaning Connections on I/O Shrink
**What goes wrong:** modify_box changes args, I/O count shrinks (e.g., "trigger b i f" -> "trigger b"), connections to removed outlets silently break.
**Why it happens:** Connections reference outlet/inlet indices that no longer exist after I/O recomputation.
**How to avoid:** After recomputing I/O counts, scan all connections to/from this box. Any connection with source_outlet >= new numoutlets or dest_inlet >= new numinlets is orphaned, removed, and returned.
**Warning signs:** Tests that shrink I/O and verify connection list changes.

### Pitfall 3: Insert with Multiple Matching Connections
**What goes wrong:** Source has stereo output to destination (outlet 0->inlet 0, outlet 0->inlet 1). Insert should splice into BOTH connections, not just the first found.
**Why it happens:** Only searching for one matching connection between source and destination.
**How to avoid:** Find ALL connections between the specified source and destination boxes. Wire the inserted object to all of them. If the inserted object has fewer inlets/outlets than connections found, report the mismatch.
**Warning signs:** Test with stereo connection (two connections between same pair of boxes).

### Pitfall 4: Subpatcher Traversal Infinite Loop
**What goes wrong:** Graph traversal enters a subpatcher, traverses inside, exits through outlet, and then the parent connection leads back to the same subpatcher, creating an infinite loop.
**Why it happens:** Feedback loops are valid in MAX patches (e.g., delay feedback). Traversal without visited-set tracking will recurse infinitely.
**How to avoid:** Always maintain a visited set of (patcher_id, box_id) tuples. Never re-visit a box+patcher combination.
**Warning signs:** Test with a feedback loop (box A -> subpatcher -> box B -> box A).

### Pitfall 5: Collision Detection False Positive on Self
**What goes wrong:** Auto-positioning detects the box being positioned as colliding with itself.
**Why it happens:** The box is already in patcher.boxes when checking for collisions.
**How to avoid:** Exclude the box being positioned from the collision check set.
**Warning signs:** Test that repositions an existing box to same coordinates succeeds.

### Pitfall 6: Box ID Lookup Performance
**What goes wrong:** Graph traversal repeatedly scans patcher.boxes list to find box by ID, O(n) per lookup, O(n*m) for full traversal.
**Why it happens:** No box-by-ID index maintained.
**How to avoid:** Build a `{id: Box}` lookup dict at the start of each graph method. This is what layout.py does with `box_map = {b.id: b for b in boxes}`.
**Warning signs:** Not a correctness issue, but noticeable with large patches (100+ objects).

## Code Examples

### Example 1: modify_box with I/O Recomputation
```python
def modify_box(
    self,
    box: Box,
    *,
    args: list[str] | None = None,
    position: list[float] | None = None,
    color: list[float] | None = None,
    extra_attrs: dict | None = None,
) -> EditResult:
    """Modify a box's attributes in-place.

    Args:
        box: The box to modify.
        args: New arguments (triggers I/O recomputation for variable_io).
        position: New [x, y] position.
        color: New box color [r, g, b, a].
        extra_attrs: Dict of additional attributes to set/update.

    Returns:
        EditResult with the modified box and any orphaned connections.
    """
    if box not in self.boxes:
        raise ValueError(f"Box {box.id} not found in this patcher")

    orphaned: list[dict] = []

    if args is not None:
        # Update args and text
        box.args = args
        parts = [box.name] + args
        box.text = " ".join(parts).strip()

        # Recompute I/O counts
        old_inlets, old_outlets = box.numinlets, box.numoutlets
        if self.db:
            box.numinlets, box.numoutlets = self.db.compute_io_counts(box.name, args)
            box.outlettype = self.db.get_outlet_types(box.name, args)

        # Recalculate box size
        from src.maxpat.sizing import calculate_box_size
        w, h = calculate_box_size(box.text, box.maxclass)
        box.patching_rect[2] = w
        box.patching_rect[3] = h

        # Orphan connections to removed outlets/inlets
        surviving = []
        for pl in self.lines:
            orphan = False
            if pl.source_id == box.id and pl.source_outlet >= box.numoutlets:
                orphan = True
            if pl.dest_id == box.id and pl.dest_inlet >= box.numinlets:
                orphan = True
            if orphan:
                orphaned.append({
                    "source_id": pl.source_id,
                    "source_outlet": pl.source_outlet,
                    "dest_id": pl.dest_id,
                    "dest_inlet": pl.dest_inlet,
                })
            else:
                surviving.append(pl)
        self.lines = surviving

        # Sync _raw
        if box._raw is not None:
            box._raw["text"] = box.text
            box._raw["numinlets"] = box.numinlets
            box._raw["numoutlets"] = box.numoutlets
            if "outlettype" in box._raw:
                box._raw["outlettype"] = box.outlettype
            box._raw["patching_rect"] = box.patching_rect

    if position is not None:
        box.patching_rect[0] = position[0]
        box.patching_rect[1] = position[1]
        if box._raw is not None:
            box._raw["patching_rect"] = box.patching_rect

    if color is not None:
        box.extra_attrs["bgcolor"] = color
        if box._raw is not None:
            box._raw["bgcolor"] = color

    if extra_attrs is not None:
        box.extra_attrs.update(extra_attrs)
        if box._raw is not None:
            box._raw.update(extra_attrs)

    return EditResult(box=box, orphaned=orphaned)
```

### Example 2: insert_into_connection
```python
def insert_into_connection(
    self,
    source: Box,
    dest: Box,
    name: str,
    args: list[str] | None = None,
) -> EditResult:
    """Insert a new object into all connections between source and dest.

    Finds all patchlines from source to dest, removes them, creates a new
    box, and wires source -> new -> dest for each connection.
    """
    # Find ALL connections between source and dest
    matching = [
        pl for pl in self.lines
        if pl.source_id == source.id and pl.dest_id == dest.id
    ]
    if not matching:
        raise ValueError(
            f"No connection found between {source.id} and {dest.id}"
        )

    # Create the new box
    new_box = self.add_box(name, args=args)

    # Check I/O capacity
    needed_inlets = len(set(pl.source_outlet for pl in matching))
    needed_outlets = len(set(pl.dest_inlet for pl in matching))
    orphaned = []

    if new_box.numinlets < len(matching) or new_box.numoutlets < len(matching):
        # Report mismatch -- return what we can't wire
        ...

    # Position below source with standard spacing
    new_box.patching_rect[0] = source.patching_rect[0]
    new_box.patching_rect[1] = (
        source.patching_rect[1] + source.patching_rect[3] + V_SPACING
    )
    # Collision check and nudge
    ...
    # Grid snap
    new_box.patching_rect[0] = round(new_box.patching_rect[0] / 15.0) * 15.0
    new_box.patching_rect[1] = round(new_box.patching_rect[1] / 15.0) * 15.0

    # Remove old connections, wire through new box
    for i, pl in enumerate(matching):
        self.remove_connection(source, pl.source_outlet, dest, pl.dest_inlet)
        inlet_idx = min(i, new_box.numinlets - 1)
        outlet_idx = min(i, new_box.numoutlets - 1)
        self.add_connection(source, pl.source_outlet, new_box, inlet_idx)
        self.add_connection(new_box, outlet_idx, dest, pl.dest_inlet)

    return EditResult(box=new_box, orphaned=orphaned)
```

### Example 3: Downstream Traversal with Subpatcher Crossing
```python
def downstream(self, box: Box, *, signal_only: bool = False) -> list[Box]:
    """Return all boxes downstream of the given box (BFS).

    Traverses through subpatcher boundaries by default.
    Results ordered by outlet index (left to right).
    """
    box_map = {b.id: b for b in self.boxes}
    visited: set[str] = set()
    result: list[Box] = []
    queue: deque[str] = deque()

    # Build adjacency sorted by outlet index
    adj: dict[str, list[tuple[str, int]]] = defaultdict(list)
    for pl in self.lines:
        if signal_only:
            src = box_map.get(pl.source_id)
            dst = box_map.get(pl.dest_id)
            if not src or not dst:
                continue
            if not src.name.endswith("~") or not dst.name.endswith("~"):
                continue
        adj[pl.source_id].append((pl.dest_id, pl.source_outlet))

    # Sort adjacency by outlet index for left-to-right ordering
    for k in adj:
        adj[k].sort(key=lambda t: t[1])

    queue.append(box.id)
    visited.add(box.id)

    while queue:
        current_id = queue.popleft()
        for next_id, _ in adj.get(current_id, []):
            if next_id not in visited:
                visited.add(next_id)
                next_box = box_map.get(next_id)
                if next_box:
                    result.append(next_box)
                    queue.append(next_id)

                    # Cross into subpatcher if present
                    if next_box._inner_patcher is not None:
                        # Recurse into inner patcher
                        ...

    return result
```

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| Delete and recreate to modify | In-place attribute editing | Phase 15 (this phase) | Preserves box ID, _raw, connections |
| Manual connection rewiring | insert_into_connection | Phase 15 (this phase) | Atomic insert operation |
| No graph queries | BFS/DFS traversal methods | Phase 15 (this phase) | Enables Phase 16 patch analysis |
| Layout engine graph ops only | Shared graph patterns | Phase 15 (this phase) | Graph queries match layout.py conventions |

**Deprecated/outdated:**
- None within this phase's scope.

## Open Questions

1. **EditResult as dataclass or namedtuple?**
   - What we know: Both modify_box and replace_box return orphaned connections. insert_into_connection returns the new box plus any I/O mismatch info.
   - What's unclear: Whether to use a single EditResult type for all three methods or method-specific return types.
   - Recommendation: Use a single dataclass. The planner should decide the exact fields, but keeping it consistent across all mutation methods reduces cognitive overhead for callers.

2. **Box ID lookup dict as instance attribute?**
   - What we know: Every graph query method needs {id: Box} mapping. Building it per-call is O(n) but safe.
   - What's unclear: Whether to cache it as self._box_index with invalidation on add/remove.
   - Recommendation: Build per-call for now (correctness over optimization). Patch sizes in this project are small (< 200 boxes). Add caching only if performance testing shows need.

3. **Subpatcher boundary traversal depth**
   - What we know: CONTEXT.md says "crosses subpatcher boundaries by default." Traversal needs to enter subpatchers, follow connections inside, and exit through outlet objects.
   - What's unclear: How to handle the parent <-> child patcher relationship efficiently. Each Box has _inner_patcher, but there's no reverse reference (inner patcher doesn't know its parent box).
   - Recommendation: Pass parent context through the traversal recursion. When entering a subpatcher, map the parent box's inlet/outlet indices to the inner inlet~/outlet~ objects by their argument number.

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | pytest 9.0.2 |
| Config file | pyproject.toml or pytest.ini (project root) |
| Quick run command | `python3 -m pytest tests/test_patcher.py -x -q` |
| Full suite command | `python3 -m pytest tests/ -x -q` |

### Phase Requirements -> Test Map
| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| ED-01 | modify_box changes args, position, color, extra_attrs | unit | `python3 -m pytest tests/test_patcher.py -k "TestModifyBox" -x` | No - Wave 0 |
| ED-01 | modify_box recomputes I/O for variable_io objects | unit | `python3 -m pytest tests/test_patcher.py -k "test_modify_box_io_recompute" -x` | No - Wave 0 |
| ED-01 | modify_box orphans connections on I/O shrink | unit | `python3 -m pytest tests/test_patcher.py -k "test_modify_box_orphan" -x` | No - Wave 0 |
| ED-01 | modify_box syncs _raw for round-trip fidelity | unit | `python3 -m pytest tests/test_round_trip.py -k "test_modify_preserves" -x` | No - Wave 0 |
| ED-02 | insert_into_connection wires through new box | unit | `python3 -m pytest tests/test_patcher.py -k "TestInsert" -x` | No - Wave 0 |
| ED-02 | insert handles stereo (multiple) connections | unit | `python3 -m pytest tests/test_patcher.py -k "test_insert_stereo" -x` | No - Wave 0 |
| ED-02 | insert auto-positions below source | unit | `python3 -m pytest tests/test_patcher.py -k "test_insert_position" -x` | No - Wave 0 |
| ED-03 | replace_box places new box at old position | unit | `python3 -m pytest tests/test_patcher.py -k "TestReplaceBox" -x` | No - Wave 0 |
| ED-03 | replace_box returns all old connections as orphaned | unit | `python3 -m pytest tests/test_patcher.py -k "test_replace_orphans" -x` | No - Wave 0 |
| ED-04 | downstream traversal returns correct chain | unit | `python3 -m pytest tests/test_patcher.py -k "TestDownstream" -x` | No - Wave 0 |
| ED-04 | upstream traversal returns correct chain | unit | `python3 -m pytest tests/test_patcher.py -k "TestUpstream" -x` | No - Wave 0 |
| ED-04 | signal_path traces ~ objects only | unit | `python3 -m pytest tests/test_patcher.py -k "TestSignalPath" -x` | No - Wave 0 |
| ED-04 | connected_components groups objects correctly | unit | `python3 -m pytest tests/test_patcher.py -k "TestConnectedComponents" -x` | No - Wave 0 |
| ED-05 | auto-position snaps to 15px grid | unit | `python3 -m pytest tests/test_patcher.py -k "test_auto_position_grid" -x` | No - Wave 0 |
| ED-05 | collision nudge finds clear space | unit | `python3 -m pytest tests/test_patcher.py -k "test_collision_nudge" -x` | No - Wave 0 |

### Sampling Rate
- **Per task commit:** `python3 -m pytest tests/test_patcher.py tests/test_round_trip.py -x -q`
- **Per wave merge:** `python3 -m pytest tests/ -x -q`
- **Phase gate:** Full suite green before `/gsd:verify-work`

### Wave 0 Gaps
- [ ] `tests/test_patcher.py` -- add TestModifyBox, TestInsert, TestReplaceBox, TestDownstream, TestUpstream, TestSignalPath, TestConnectedComponents, TestAutoPosition test classes
- [ ] `tests/test_round_trip.py` -- add TestModifyPreservesRoundTrip for _raw sync verification
- [ ] No framework install needed -- pytest 9.0.2 already available

## Sources

### Primary (HIGH confidence)
- Project codebase: `src/maxpat/patcher.py` (1472 lines) -- Box, Patcher, Patchline classes with full API
- Project codebase: `src/maxpat/layout.py` (970 lines) -- _build_graph, _find_components, _snap_to_grid, _outlet_x, _inlet_x
- Project codebase: `src/maxpat/db_lookup.py` (287 lines) -- compute_io_counts, get_outlet_types
- Project codebase: `src/maxpat/defaults.py` (133 lines) -- V_SPACING=20, grid_size=15.0, LayoutOptions
- Project codebase: `src/maxpat/sizing.py` (147 lines) -- calculate_box_size
- Project codebase: `tests/test_patcher.py` (1031 lines) -- 147 existing tests, test patterns
- Phase 15 CONTEXT.md -- all locked decisions and discretion areas

### Secondary (MEDIUM confidence)
- None needed -- all research based on existing project code

### Tertiary (LOW confidence)
- None

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH - zero new dependencies, pure stdlib + existing code
- Architecture: HIGH - patterns derived directly from existing layout.py and patcher.py code
- Pitfalls: HIGH - identified from actual code paths (_raw sync, iteration mutation, I/O shrink) with concrete line references
- Graph queries: HIGH - BFS/DFS is well-understood; layout.py already implements connected components and adjacency building

**Research date:** 2026-03-16
**Valid until:** No expiration -- project-internal research, not dependent on external libraries
