"""Row-based layout engine with component grouping and midpoint generation.

Positions MAX objects in a patcher for readable top-to-bottom signal flow:
1. Connected component detection to separate independent signal chains
2. Kahn's algorithm (topological sort by levels) to assign boxes to rows
3. Row-based layout: levels flow top-to-bottom, objects spread horizontally
4. Within-row ordering by parent position to minimize cable crossings
5. UI control objects positioned above their targets
6. Disconnected objects (bpatchers, presentation-only) placed to the right
7. Midpoint generation for all cable types:
   a. Horizontal offset cables get L-shaped routing at the vertical midpoint
   b. Upward-flowing cables (init sections) get right-edge bus routing
   c. Parallel bus cables are spaced apart to avoid visual overlap
8. Auto-sizing patcher rect to fit all content including bus routes
9. Presentation mode grid layout for UI objects

Implements PAT-06 (top-to-bottom signal flow) and PAT-07 (readable spacing).
"""

from __future__ import annotations

from collections import defaultdict, deque
from typing import TYPE_CHECKING

from src.maxpat.defaults import (
    V_SPACING,
    H_GUTTER,
    HORIZONTAL_THRESHOLD,
    UPWARD_BUS_THRESHOLD,
    BUS_MARGIN,
    BUS_SPACING,
    PATCHER_PADDING,
)
from src.maxpat.maxclass_map import is_ui_object

if TYPE_CHECKING:
    from src.maxpat.patcher import Box, Patcher

# UI control object names that should be positioned above their targets
_UI_CONTROL_NAMES = frozenset({
    "toggle", "slider", "dial", "number", "flonum",
    "rslider", "button", "multislider", "kslider",
    "nslider", "led", "radiogroup", "umenu",
    "live.dial", "live.slider", "live.numbox",
    "live.toggle", "live.button",
})

# Companion objects placed beside their parent (monitoring/display sinks)
_COMPANION_NAMES = frozenset({
    "meter~", "levelmeter~", "scope~", "number~", "spectroscope~",
})

# Gap between a parent and its companion object placed beside it
_COMPANION_GAP = 5.0

# Starting position for the first row and first object
_START_X = 30.0
_START_Y = 30.0

# Gap between independent components laid out side by side
_COMPONENT_GAP = 40.0

# Margin from box edge to first/last inlet/outlet center
_IO_MARGIN = 7.0


def apply_layout(patcher: Patcher) -> None:
    """Position all boxes using row-based topological layout with component grouping.

    Signal flow is top-to-bottom: topological depth maps to y-position.
    Independent signal chains are placed side by side as vertical groups.
    Disconnected objects (bpatchers, presentation-only) go to the right.
    Backward-direction cables get midpoints for clean segmented routing.

    Args:
        patcher: A Patcher instance containing boxes and lines.
    """
    if not patcher.boxes:
        return

    # Build adjacency graph from patcher.lines
    adj, in_degree, reverse_adj = _build_graph(patcher.boxes, patcher.lines)

    # Separate connected components from disconnected objects
    components, disconnected = _find_components(patcher.boxes, adj)

    # Layout each component as a vertical group (top-to-bottom rows)
    cursor_x = _START_X
    for component_boxes in components:
        # Filter graph to this component
        comp_ids = {b.id for b in component_boxes}
        comp_adj = {
            k: [v for v in vs if v in comp_ids]
            for k, vs in adj.items() if k in comp_ids
        }
        comp_in_degree = {k: v for k, v in in_degree.items() if k in comp_ids}

        # Topological sort into levels (rows)
        rows = _topological_levels(component_boxes, comp_adj, comp_in_degree)
        if not rows:
            continue

        # Identify and extract UI controls
        ui_controls = _identify_ui_controls(component_boxes, patcher.lines, rows)
        for box_id in ui_controls:
            for row in rows:
                row[:] = [b for b in row if b.id != box_id]
        rows = [r for r in rows if r]
        if not rows:
            continue

        # Identify and extract companion objects (meter~, etc.)
        companions = _identify_companions(component_boxes, patcher.lines, rows)
        for box_id in companions:
            for row in rows:
                row[:] = [b for b in row if b.id != box_id]
        rows = [r for r in rows if r]
        if not rows:
            continue

        # Position this component starting at cursor_x
        comp_width = _position_component(
            rows, cursor_x, _START_Y, reverse_adj, patcher.boxes,
        )

        # Position UI controls above their targets
        _place_ui_controls(patcher.boxes, ui_controls)

        # Position companion objects beside their parents
        _place_companions(patcher.boxes, companions)

        # Recalculate component width after companion placement
        comp_right = max(
            b.patching_rect[0] + b.patching_rect[2]
            for b in component_boxes
        )
        comp_width = comp_right - cursor_x

        cursor_x += comp_width + _COMPONENT_GAP

    # Place disconnected objects to the right of all components
    if disconnected:
        _position_disconnected(disconnected, cursor_x, _START_Y)

    # Generate midpoints for all cables needing segmented routing
    _generate_midpoints(patcher)

    # Auto-size patcher rect to fit content and bus routing
    if not patcher._is_subpatcher:
        _auto_size_patcher_rect(patcher)

    # Recursively layout inner patchers (subpatchers, gen~, bpatchers)
    for box in patcher.boxes:
        if box._inner_patcher is not None and box._inner_patcher.boxes:
            apply_layout(box._inner_patcher)

    # Apply presentation mode layout if any boxes have presentation=True
    _apply_presentation_layout(patcher.boxes)


# ---------------------------------------------------------------------------
# Graph building
# ---------------------------------------------------------------------------


def _build_graph(
    boxes: list[Box],
    lines: list,
) -> tuple[dict[str, list[str]], dict[str, int], dict[str, list[str]]]:
    """Build adjacency, in-degree, and reverse-adjacency dicts from lines.

    Returns:
        (adjacency, in_degree, reverse_adjacency) tuple.
    """
    all_ids = {b.id for b in boxes}
    adj: dict[str, list[str]] = defaultdict(list)
    reverse_adj: dict[str, list[str]] = defaultdict(list)
    in_degree: dict[str, int] = {b.id: 0 for b in boxes}

    for line in lines:
        src = line.source_id
        dst = line.dest_id
        if src in all_ids and dst in all_ids:
            # Avoid duplicate edges
            if dst not in adj[src]:
                adj[src].append(dst)
                in_degree[dst] = in_degree.get(dst, 0) + 1
                reverse_adj[dst].append(src)

    return dict(adj), in_degree, dict(reverse_adj)


# ---------------------------------------------------------------------------
# Connected components
# ---------------------------------------------------------------------------


def _find_components(
    boxes: list[Box],
    adj: dict[str, list[str]],
) -> tuple[list[list[Box]], list[Box]]:
    """Find connected components and disconnected objects.

    Uses undirected BFS to group connected boxes. Objects with no
    connections at all are returned separately as disconnected.

    Returns:
        (components, disconnected) where components is a list of Box lists
        sorted largest-first, and disconnected is isolated Box objects.
    """
    # Build undirected adjacency
    undirected: dict[str, set[str]] = defaultdict(set)
    for src, dsts in adj.items():
        for dst in dsts:
            undirected[src].add(dst)
            undirected[dst].add(src)

    box_map = {b.id: b for b in boxes}
    visited: set[str] = set()
    components: list[list[Box]] = []
    disconnected: list[Box] = []

    for box in boxes:
        if box.id in visited:
            continue
        if box.id not in undirected:
            disconnected.append(box)
            visited.add(box.id)
            continue

        # BFS from this box
        component_ids: list[str] = []
        queue = deque([box.id])
        while queue:
            node = queue.popleft()
            if node in visited:
                continue
            visited.add(node)
            component_ids.append(node)
            for neighbor in undirected.get(node, set()):
                if neighbor not in visited:
                    queue.append(neighbor)

        comp_boxes = [box_map[bid] for bid in component_ids if bid in box_map]
        if comp_boxes:
            components.append(comp_boxes)

    # Largest component first for primary placement
    components.sort(key=len, reverse=True)

    return components, disconnected


# ---------------------------------------------------------------------------
# Topological sort
# ---------------------------------------------------------------------------


def _topological_levels(
    boxes: list[Box],
    adj: dict[str, list[str]],
    in_degree: dict[str, int],
) -> list[list[Box]]:
    """Assign boxes to levels using Kahn's algorithm (BFS by depth).

    Each level becomes a row in the layout. Source nodes (in-degree 0)
    are in level 0 (top row).
    """
    box_map = {b.id: b for b in boxes}
    comp_ids = {b.id for b in boxes}

    queue = deque()
    for box in boxes:
        if in_degree.get(box.id, 0) == 0:
            queue.append(box.id)

    levels: list[list[Box]] = []
    visited: set[str] = set()
    work_in_degree = dict(in_degree)

    while queue:
        level: list[Box] = []
        next_queue: deque[str] = deque()

        while queue:
            node_id = queue.popleft()
            if node_id in visited:
                continue
            visited.add(node_id)
            if node_id in box_map:
                level.append(box_map[node_id])

            for neighbor_id in adj.get(node_id, []):
                if neighbor_id not in comp_ids:
                    continue
                work_in_degree[neighbor_id] = work_in_degree.get(neighbor_id, 0) - 1
                if work_in_degree[neighbor_id] == 0 and neighbor_id not in visited:
                    next_queue.append(neighbor_id)

        if level:
            levels.append(level)
        queue = next_queue

    # Handle any remaining (cycle participants)
    remaining = [b for b in boxes if b.id not in visited]
    if remaining:
        levels.append(remaining)

    return levels


# ---------------------------------------------------------------------------
# Component positioning (row-based, top-to-bottom)
# ---------------------------------------------------------------------------


def _position_component(
    rows: list[list[Box]],
    start_x: float,
    start_y: float,
    reverse_adj: dict[str, list[str]],
    all_boxes: list[Box],
) -> float:
    """Position boxes in a component as top-to-bottom rows.

    Each topological level is a row. Within each row (except the first),
    objects are sorted by the average x-position of their parents to
    minimize cable crossings. Child objects are centered under their
    parent's center-x to reduce horizontal cable distance.

    Returns the total width of the component.
    """
    if not rows:
        return 0.0

    box_map = {b.id: b for b in all_boxes}

    # Compute y position for each row
    row_y: list[float] = [start_y]
    for i in range(1, len(rows)):
        prev_row = rows[i - 1]
        max_height = max(b.patching_rect[3] for b in prev_row)
        row_y.append(row_y[-1] + max_height + V_SPACING)

    # Position boxes row by row
    max_right = start_x
    for row_idx, row in enumerate(rows):
        y = row_y[row_idx]

        if row_idx == 0:
            # First row: pack left to right from start_x
            x = start_x
            for box in row:
                box.patching_rect[0] = x
                box.patching_rect[1] = y
                x += box.patching_rect[2] + H_GUTTER
        else:
            # Sort by parent x to reduce crossings
            if len(row) > 1:
                _sort_row_by_parent_x(row, reverse_adj, box_map)

            # Position each box centered under its parent's center-x,
            # then resolve overlaps by pushing right
            positions: list[float] = []
            for box in row:
                target_x = _parent_center_x(box, reverse_adj, box_map)
                # Center the box on the target x
                ideal_x = target_x - box.patching_rect[2] * 0.5
                ideal_x = max(ideal_x, start_x)

                # Prevent overlap with previous box
                if positions:
                    prev_right = positions[-1]
                    if ideal_x < prev_right + H_GUTTER:
                        ideal_x = prev_right + H_GUTTER

                box.patching_rect[0] = ideal_x
                box.patching_rect[1] = y
                positions.append(ideal_x + box.patching_rect[2])

        row_right = max(
            b.patching_rect[0] + b.patching_rect[2] for b in row
        )
        if row_right > max_right:
            max_right = row_right

    return max_right - start_x


def _parent_center_x(
    box: Box,
    reverse_adj: dict[str, list[str]],
    box_map: dict[str, Box],
) -> float:
    """Compute the average center-x of a box's parents."""
    parents = reverse_adj.get(box.id, [])
    if not parents:
        return box.patching_rect[0] + box.patching_rect[2] * 0.5
    cxs = []
    for pid in parents:
        parent = box_map.get(pid)
        if parent:
            cxs.append(parent.patching_rect[0] + parent.patching_rect[2] * 0.5)
    return sum(cxs) / len(cxs) if cxs else 0.0


def _sort_row_by_parent_x(
    row: list[Box],
    reverse_adj: dict[str, list[str]],
    box_map: dict[str, Box],
) -> None:
    """Sort objects in a row by the average x-position of their parents.

    Parents in previous rows are already positioned, so their patching_rect
    x values are valid. This reduces cable crossings.
    """
    def parent_avg_x(box: Box) -> float:
        parents = reverse_adj.get(box.id, [])
        if not parents:
            return 0.0
        xs = []
        for pid in parents:
            parent = box_map.get(pid)
            if parent:
                xs.append(parent.patching_rect[0])
        return sum(xs) / len(xs) if xs else 0.0

    row.sort(key=parent_avg_x)


# ---------------------------------------------------------------------------
# UI control identification and positioning
# ---------------------------------------------------------------------------


def _identify_ui_controls(
    boxes: list[Box],
    lines: list,
    rows: list[list[Box]],
) -> dict[str, Box]:
    """Identify UI control objects that should be placed above their targets.

    A UI control qualifies if:
    1. Its name is in _UI_CONTROL_NAMES
    2. It connects to a target (first connection target used)
    3. The target is in the same or the next row
    """
    row_index: dict[str, int] = {}
    for r_idx, row in enumerate(rows):
        for b in row:
            row_index[b.id] = r_idx

    box_map = {b.id: b for b in boxes}

    ui_connections: dict[str, str] = {}
    for line in lines:
        src = line.source_id
        if src not in ui_connections and src in box_map:
            src_box = box_map[src]
            if src_box.name in _UI_CONTROL_NAMES:
                ui_connections[src] = line.dest_id

    result: dict[str, Box] = {}
    for ui_id, target_id in ui_connections.items():
        if ui_id in row_index and target_id in row_index:
            ui_row = row_index[ui_id]
            target_row = row_index[target_id]
            if target_row == ui_row or target_row == ui_row + 1:
                if target_id in box_map:
                    result[ui_id] = box_map[target_id]

    return result


def _place_ui_controls(
    all_boxes: list[Box],
    ui_controls: dict[str, Box],
) -> None:
    """Position UI control objects above their targets.

    Sets the UI control's x to match target's x, and y above target.
    """
    box_map = {b.id: b for b in all_boxes}

    for ui_id, target_box in ui_controls.items():
        ui_box = box_map.get(ui_id)
        if ui_box is None:
            continue

        target_x = target_box.patching_rect[0]
        target_y = target_box.patching_rect[1]
        ui_height = ui_box.patching_rect[3]

        new_y = target_y - ui_height - V_SPACING * 0.5
        if new_y < 5.0:
            new_y = 5.0

        ui_box.patching_rect[0] = target_x
        ui_box.patching_rect[1] = new_y


# ---------------------------------------------------------------------------
# Companion object identification and positioning (meter~, scope~, etc.)
# ---------------------------------------------------------------------------


def _identify_companions(
    boxes: list[Box],
    lines: list,
    rows: list[list[Box]],
) -> dict[str, Box]:
    """Identify companion objects that should be placed beside their parent.

    A companion qualifies if:
    1. Its name is in _COMPANION_NAMES (e.g., meter~, scope~)
    2. It has exactly one incoming connection (a single parent)
    3. It is a display/monitoring sink (no downstream connections used for signal)
    """
    box_map = {b.id: b for b in boxes}
    comp_ids = {b.id for b in boxes}

    # Count incoming connections per box
    incoming: dict[str, list[str]] = {}
    outgoing: dict[str, int] = {}
    for line in lines:
        if line.source_id in comp_ids and line.dest_id in comp_ids:
            incoming.setdefault(line.dest_id, []).append(line.source_id)
            outgoing[line.source_id] = outgoing.get(line.source_id, 0) + 1

    result: dict[str, Box] = {}
    for box in boxes:
        if box.name not in _COMPANION_NAMES:
            continue
        parents = incoming.get(box.id, [])
        if len(parents) != 1:
            continue
        # Companion has exactly one parent - place beside it
        parent = box_map.get(parents[0])
        if parent is not None:
            result[box.id] = parent

    return result


def _place_companions(
    all_boxes: list[Box],
    companions: dict[str, Box],
) -> None:
    """Position companion objects beside their parent at the same y.

    The companion is placed to the right of the parent with a small gap.
    """
    box_map = {b.id: b for b in all_boxes}

    # Group companions by parent to handle multiple companions on one parent
    parent_companions: dict[str, list[str]] = {}
    for comp_id, parent_box in companions.items():
        parent_companions.setdefault(parent_box.id, []).append(comp_id)

    for parent_id, comp_ids in parent_companions.items():
        parent = box_map.get(parent_id)
        if parent is None:
            continue

        # Place companions to the right of parent, stacking if multiple
        cursor_x = parent.patching_rect[0] + parent.patching_rect[2] + _COMPANION_GAP
        for comp_id in comp_ids:
            comp_box = box_map.get(comp_id)
            if comp_box is None:
                continue
            comp_box.patching_rect[0] = cursor_x
            comp_box.patching_rect[1] = parent.patching_rect[1]
            cursor_x += comp_box.patching_rect[2] + _COMPANION_GAP


# ---------------------------------------------------------------------------
# Disconnected object positioning
# ---------------------------------------------------------------------------


def _position_disconnected(
    boxes: list[Box],
    start_x: float,
    start_y: float,
) -> None:
    """Place disconnected objects in a compact grid to the right of components.

    Groups subpatchers first, then other objects. Uses multi-column layout
    with wrapping to avoid excessively tall columns.
    """
    if not boxes:
        return

    # Separate subpatchers from other disconnected objects
    subpatchers = [b for b in boxes if b.name in ("patcher", "p")]
    others = [b for b in boxes if b.name not in ("patcher", "p")]

    # Compact vertical spacing for disconnected items
    disc_v_gap = 30.0
    disc_h_gap = H_GUTTER
    max_col_height = 400.0  # Wrap to next column after this height

    cursor_x = start_x
    cursor_y = start_y
    col_max_width = 0.0

    # Place subpatchers first (in a column, they're reference modules)
    for box in subpatchers:
        if cursor_y + box.patching_rect[3] > start_y + max_col_height and cursor_y > start_y:
            cursor_x += col_max_width + disc_h_gap
            cursor_y = start_y
            col_max_width = 0.0
        box.patching_rect[0] = cursor_x
        box.patching_rect[1] = cursor_y
        cursor_y += box.patching_rect[3] + disc_v_gap
        col_max_width = max(col_max_width, box.patching_rect[2])

    # Start new column for non-subpatcher objects if subpatchers were placed
    if subpatchers and others:
        cursor_x += col_max_width + disc_h_gap
        cursor_y = start_y
        col_max_width = 0.0

    # Place other disconnected objects (comments, etc.)
    for box in others:
        if cursor_y + box.patching_rect[3] > start_y + max_col_height and cursor_y > start_y:
            cursor_x += col_max_width + disc_h_gap
            cursor_y = start_y
            col_max_width = 0.0
        box.patching_rect[0] = cursor_x
        box.patching_rect[1] = cursor_y
        cursor_y += box.patching_rect[3] + disc_v_gap
        col_max_width = max(col_max_width, box.patching_rect[2])


# ---------------------------------------------------------------------------
# Midpoint generation for all cable types
# ---------------------------------------------------------------------------


def _outlet_x(box: Box, outlet_idx: int) -> float:
    """Approximate x position of an outlet on a box."""
    x = box.patching_rect[0]
    w = box.patching_rect[2]
    n = box.numoutlets
    if n <= 1:
        return x + w * 0.5
    usable = w - 2 * _IO_MARGIN
    spacing = usable / (n - 1)
    return x + _IO_MARGIN + outlet_idx * spacing


def _inlet_x(box: Box, inlet_idx: int) -> float:
    """Approximate x position of an inlet on a box."""
    x = box.patching_rect[0]
    w = box.patching_rect[2]
    n = box.numinlets
    if n <= 1:
        return x + w * 0.5
    usable = w - 2 * _IO_MARGIN
    spacing = usable / (n - 1)
    return x + _IO_MARGIN + inlet_idx * spacing


def _generate_midpoints(patcher: Patcher) -> None:
    """Add midpoints to patchlines for clean segmented cable routing.

    Handles three routing patterns:

    1. **Horizontal offset** (forward or backward): source and destination have
       significant horizontal distance. Creates a 2-midpoint horizontal segment
       at the vertical midpoint between source and dest.

    2. **Upward bus routing**: source is far below destination (e.g., loadbang
       init cables). Routes cables along the right edge of the patcher in a
       vertical bus, then turns left to the target. Parallel bus cables are
       spaced apart to avoid visual overlap.

    3. **Near-vertical**: cables with minimal horizontal offset get no midpoints
       (clean straight lines).

    Only adds midpoints to lines that don't already have them.
    """
    box_map = {b.id: b for b in patcher.boxes}

    # First pass: classify cables
    companion_lines: list = []  # Side-by-side objects (gain~ -> meter~)
    upward_lines: list = []
    normal_lines: list = []

    for line in patcher.lines:
        if line.midpoints:
            continue

        src_box = box_map.get(line.source_id)
        dst_box = box_map.get(line.dest_id)
        if not src_box or not dst_box:
            continue

        src_ox = _outlet_x(src_box, line.source_outlet)
        src_oy = src_box.patching_rect[1] + src_box.patching_rect[3]
        dst_ix = _inlet_x(dst_box, line.dest_inlet)
        dst_iy = dst_box.patching_rect[1]

        hdist = abs(src_ox - dst_ix)
        vdist = src_oy - dst_iy  # positive = upward flow

        # Companion pattern: objects at the same y, close together horizontally
        same_y = src_box.patching_rect[1] == dst_box.patching_rect[1]
        close_x = abs(src_box.patching_rect[0] - dst_box.patching_rect[0]) < 80
        if same_y and close_x and vdist > 0:
            companion_lines.append(
                (line, src_box, dst_box, src_ox, src_oy, dst_ix, dst_iy),
            )
        elif hdist > HORIZONTAL_THRESHOLD and vdist > UPWARD_BUS_THRESHOLD:
            upward_lines.append((line, src_ox, src_oy, dst_ix, dst_iy))
        else:
            normal_lines.append((line, src_ox, src_oy, dst_ix, dst_iy))

    # Route companion cables with tight local loop
    for line, src_box, dst_box, src_ox, src_oy, dst_ix, dst_iy in companion_lines:
        _route_companion_cable(line, src_box, dst_box, src_ox, src_oy, dst_ix, dst_iy)

    # Route upward cables via right-edge bus
    if upward_lines:
        _route_bus_cables(upward_lines, patcher.boxes)

    # Route normal cables with horizontal midpoints
    for line, src_ox, src_oy, dst_ix, dst_iy in normal_lines:
        hdist = abs(src_ox - dst_ix)
        if hdist > HORIZONTAL_THRESHOLD:
            mid_y = (src_oy + dst_iy) * 0.5
            line.midpoints = [src_ox, mid_y, dst_ix, mid_y]


def _route_companion_cable(
    line: object,
    src_box: Box,
    dst_box: Box,
    src_ox: float,
    src_oy: float,
    dst_ix: float,
    dst_iy: float,
) -> None:
    """Route a cable between side-by-side companion objects with a tight local loop.

    The cable exits the source outlet (bottom), goes right past the rightmost
    object edge, up to above the destination inlet (top), then left to the inlet.
    This produces a compact U-shaped route hugging the right side of the pair.
    """
    # Find the rightmost edge of both objects
    src_right = src_box.patching_rect[0] + src_box.patching_rect[2]
    dst_right = dst_box.patching_rect[0] + dst_box.patching_rect[2]
    pair_right = max(src_right, dst_right)

    bus_x = pair_right + 7.0  # Tight margin past the pair's right edge
    line.midpoints = [
        bus_x, src_oy + 5,
        bus_x, dst_iy - 8,
        dst_ix, dst_iy - 8,
    ]


def _route_bus_cables(
    upward_lines: list[tuple],
    boxes: list[Box],
) -> None:
    """Route upward-flowing cables via a right-edge vertical bus.

    Cables run horizontally to a bus X position on the right side of the
    patcher, then vertically up, then horizontally left to the destination.
    Parallel cables are spaced apart by BUS_SPACING to avoid overlap.

    Args:
        upward_lines: List of (line, src_ox, src_oy, dst_ix, dst_iy) tuples.
        boxes: All boxes in the patcher (for computing rightmost edge).
    """
    # Find rightmost object edge
    max_right = 0.0
    for box in boxes:
        right = box.patching_rect[0] + box.patching_rect[2]
        if right > max_right:
            max_right = right

    bus_start_x = max_right + BUS_MARGIN

    # Sort by destination Y (topmost target gets innermost bus position)
    upward_lines.sort(key=lambda t: t[4])  # sort by dst_iy ascending

    for i, (line, src_ox, src_oy, dst_ix, dst_iy) in enumerate(upward_lines):
        bus_x = bus_start_x + i * BUS_SPACING
        # 3-midpoint route: right to bus, up along bus, left to target
        line.midpoints = [
            bus_x, src_oy + 5,
            bus_x, dst_iy - 8,
            dst_ix, dst_iy - 8,
        ]


# ---------------------------------------------------------------------------
# Patcher rect auto-sizing
# ---------------------------------------------------------------------------


def _auto_size_patcher_rect(patcher: Patcher) -> None:
    """Set patcher rect to fit all objects and bus routing with padding.

    Computes the bounding box of all objects (including midpoint bus routes)
    and sets the patcher window size accordingly.
    """
    if not patcher.boxes:
        return

    max_right = 0.0
    max_bottom = 0.0

    for box in patcher.boxes:
        right = box.patching_rect[0] + box.patching_rect[2]
        bottom = box.patching_rect[1] + box.patching_rect[3]
        if right > max_right:
            max_right = right
        if bottom > max_bottom:
            max_bottom = bottom

    # Account for bus routing midpoints extending past objects
    for line in patcher.lines:
        if line.midpoints:
            for j in range(0, len(line.midpoints), 2):
                mx = line.midpoints[j]
                if mx > max_right:
                    max_right = mx
            for j in range(1, len(line.midpoints), 2):
                my = line.midpoints[j]
                if my > max_bottom:
                    max_bottom = my

    new_w = max_right + PATCHER_PADDING
    new_h = max_bottom + PATCHER_PADDING

    # Enforce minimum size
    new_w = max(new_w, 400.0)
    new_h = max(new_h, 300.0)

    rect = patcher.props.get("rect", [85.0, 104.0, 640.0, 480.0])
    rect[2] = new_w
    rect[3] = new_h
    patcher.props["rect"] = rect


# ---------------------------------------------------------------------------
# Presentation mode layout (unchanged)
# ---------------------------------------------------------------------------


def _apply_presentation_layout(boxes: list[Box]) -> None:
    """Set presentation_rect on boxes with presentation=True.

    Arranges presentation objects in a grid layout (left-to-right, wrapping).
    Only applies to boxes that don't already have a presentation_rect set.
    """
    pres_boxes = [b for b in boxes if b.presentation]
    if not pres_boxes:
        return

    grid_x_start = 20.0
    grid_y_start = 20.0
    grid_h_spacing = 60.0
    grid_v_spacing = 40.0
    max_per_row = 4

    for idx, box in enumerate(pres_boxes):
        # Respect existing presentation_rect (set by generator or UI agent)
        if box.presentation_rect is not None:
            continue
        col = idx % max_per_row
        row = idx // max_per_row
        w = box.patching_rect[2]
        h = box.patching_rect[3]
        px = grid_x_start + col * (w + grid_h_spacing)
        py = grid_y_start + row * (h + grid_v_spacing)
        box.presentation_rect = [px, py, w, h]
