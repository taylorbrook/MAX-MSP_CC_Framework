"""Column-based layout engine with topological sort and position assignment.

Positions MAX objects in a patcher for readable signal flow using:
1. Kahn's algorithm (topological sort by levels) to assign boxes to columns
2. Dynamic column widths based on widest object per column
3. Vertical stacking within columns with V_SPACING
4. UI control objects positioned above their targets
5. Presentation mode grid layout for UI objects

Implements PAT-06 (top-to-bottom signal flow) and PAT-07 (readable spacing).
"""

from __future__ import annotations

from collections import defaultdict, deque
from typing import TYPE_CHECKING

from src.maxpat.defaults import V_SPACING, H_GUTTER
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

# Starting position for the first column and first object
_START_X = 30.0
_START_Y = 30.0


def apply_layout(patcher: Patcher) -> None:
    """Position all boxes in a patcher using column-based topological layout.

    Mutates box patching_rect positions in-place. This is the main entry point
    for the layout engine.

    Args:
        patcher: A Patcher instance containing boxes and lines.
    """
    if not patcher.boxes:
        return

    # Build adjacency graph from patcher.lines
    adj, in_degree, reverse_adj = _build_graph(patcher.boxes, patcher.lines)

    # Assign boxes to columns via topological sort (Kahn's algorithm)
    columns = _topological_columns(patcher.boxes, adj, in_degree)

    # Identify UI controls that should be positioned above their targets
    ui_controls = _identify_ui_controls(patcher.boxes, patcher.lines, columns)

    # Remove UI controls from their columns (they'll be placed above targets)
    for box_id in ui_controls:
        for col in columns:
            col[:] = [b for b in col if b.id != box_id]
    # Clean up any empty columns that resulted from removing UI controls
    columns = [col for col in columns if col]

    # Compute x-positions for each column
    col_x_positions = _compute_column_positions(columns)

    # Assign positions to boxes in each column
    for col_idx, column in enumerate(columns):
        x = col_x_positions[col_idx]
        y = _START_Y
        for box in column:
            box.patching_rect[0] = x
            box.patching_rect[1] = y
            y += box.patching_rect[3] + V_SPACING

    # Position UI controls above their targets
    _place_ui_controls(patcher, ui_controls, columns, col_x_positions)

    # Apply presentation mode layout if any boxes have presentation=True
    _apply_presentation_layout(patcher.boxes)


def _build_graph(
    boxes: list[Box],
    lines: list,
) -> tuple[dict[str, list[str]], dict[str, int], dict[str, list[str]]]:
    """Build adjacency and in-degree dicts from boxes and lines.

    Args:
        boxes: List of Box objects.
        lines: List of Patchline objects.

    Returns:
        (adjacency, in_degree, reverse_adjacency) tuple.
        adjacency: source_id -> [dest_ids]
        in_degree: box_id -> number of incoming connections
        reverse_adjacency: dest_id -> [source_ids]
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


def _topological_columns(
    boxes: list[Box],
    adj: dict[str, list[str]],
    in_degree: dict[str, int],
) -> list[list[Box]]:
    """Assign boxes to columns using Kahn's algorithm (BFS by levels).

    Each level in the BFS becomes one column. Source nodes (in-degree 0)
    are in the first column.

    Args:
        boxes: List of Box objects.
        adj: Adjacency dict (source_id -> [dest_ids]).
        in_degree: In-degree dict (box_id -> count).

    Returns:
        List of columns, each column is a list of Box objects.
    """
    box_map = {b.id: b for b in boxes}

    # Identify truly disconnected nodes (no incoming AND no outgoing connections)
    has_connections = set()
    for box_id in adj:
        has_connections.add(box_id)
        for neighbor_id in adj[box_id]:
            has_connections.add(neighbor_id)

    disconnected_ids = {b.id for b in boxes if b.id not in has_connections}

    # Initialize queue with source nodes (in-degree 0, but NOT disconnected)
    queue = deque()
    for box in boxes:
        if in_degree.get(box.id, 0) == 0 and box.id not in disconnected_ids:
            queue.append(box.id)

    columns: list[list[Box]] = []
    visited: set[str] = set()

    # Track working in-degrees (don't mutate original)
    work_in_degree = dict(in_degree)

    while queue:
        column: list[Box] = []
        next_queue: deque[str] = deque()

        while queue:
            node_id = queue.popleft()
            if node_id in visited:
                continue
            visited.add(node_id)
            if node_id in box_map:
                column.append(box_map[node_id])

            for neighbor_id in adj.get(node_id, []):
                work_in_degree[neighbor_id] = work_in_degree.get(neighbor_id, 0) - 1
                if work_in_degree[neighbor_id] == 0 and neighbor_id not in visited:
                    next_queue.append(neighbor_id)

        if column:
            columns.append(column)
        queue = next_queue

    # Handle disconnected nodes (not visited by topological sort)
    remaining = [b for b in boxes if b.id not in visited]
    if remaining:
        columns.append(remaining)

    return columns


def _compute_column_positions(columns: list[list[Box]]) -> list[float]:
    """Compute the x-position for each column.

    First column starts at _START_X. Each subsequent column's x is:
    previous_x + max(width of all boxes in previous column) + H_GUTTER.

    Args:
        columns: List of columns (each a list of Box objects).

    Returns:
        List of x-positions, one per column.
    """
    if not columns:
        return []

    positions = [_START_X]

    for i in range(1, len(columns)):
        prev_col = columns[i - 1]
        # Find widest box in previous column
        max_width = max(b.patching_rect[2] for b in prev_col) if prev_col else 0
        next_x = positions[i - 1] + max_width + H_GUTTER
        positions.append(next_x)

    return positions


def _identify_ui_controls(
    boxes: list[Box],
    lines: list,
    columns: list[list[Box]],
) -> dict[str, Box]:
    """Identify UI control objects that should be placed above their targets.

    A UI control qualifies if:
    1. Its name is in _UI_CONTROL_NAMES
    2. It connects to exactly one target (first connection target used)
    3. The target is in the same or the next column

    Args:
        boxes: All boxes in the patcher.
        lines: All patchlines.
        columns: Current column assignment.

    Returns:
        Dict mapping box_id -> target Box for UI controls to reposition.
    """
    # Build column index: box_id -> column_index
    col_index: dict[str, int] = {}
    for c_idx, col in enumerate(columns):
        for b in col:
            col_index[b.id] = c_idx

    # Build box lookup
    box_map = {b.id: b for b in boxes}

    # Find connections from UI controls
    ui_connections: dict[str, str] = {}  # ui_box_id -> first target_id
    for line in lines:
        src = line.source_id
        if src not in ui_connections and src in box_map:
            src_box = box_map[src]
            if src_box.name in _UI_CONTROL_NAMES:
                ui_connections[src] = line.dest_id

    # Filter: only those where target is in same or next column
    result: dict[str, Box] = {}
    for ui_id, target_id in ui_connections.items():
        if ui_id in col_index and target_id in col_index:
            ui_col = col_index[ui_id]
            target_col = col_index[target_id]
            if target_col == ui_col or target_col == ui_col + 1:
                result[ui_id] = box_map[target_id]

    return result


def _place_ui_controls(
    patcher: Patcher,
    ui_controls: dict[str, Box],
    columns: list[list[Box]],
    col_x_positions: list[float],
) -> None:
    """Position UI control objects above their targets.

    Sets the UI control's x to match target's x, and y to target_y - ui_height - V_SPACING/2.
    If this would create negative y or overlap with other objects, keeps reasonable position.

    Args:
        patcher: The patcher (to look up boxes by id).
        ui_controls: Dict of ui_box_id -> target Box.
        columns: Column lists (after UI controls removed).
        col_x_positions: X positions per column.
    """
    box_map = {b.id: b for b in patcher.boxes}

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


def _apply_presentation_layout(boxes: list[Box]) -> None:
    """Set presentation_rect on boxes with presentation=True.

    Arranges presentation objects in a grid layout (left-to-right, wrapping).
    Uses presentation_rect = [20 + col*spacing, 20 + row*spacing, w, h].

    Args:
        boxes: All boxes in the patcher.
    """
    pres_boxes = [b for b in boxes if b.presentation]
    if not pres_boxes:
        return

    # Grid layout parameters
    grid_x_start = 20.0
    grid_y_start = 20.0
    grid_h_spacing = 60.0  # horizontal spacing between grid items
    grid_v_spacing = 40.0  # vertical spacing between grid rows
    max_per_row = 4

    for idx, box in enumerate(pres_boxes):
        col = idx % max_per_row
        row = idx // max_per_row
        w = box.patching_rect[2]
        h = box.patching_rect[3]
        px = grid_x_start + col * (w + grid_h_spacing)
        py = grid_y_start + row * (h + grid_v_spacing)
        box.presentation_rect = [px, py, w, h]
