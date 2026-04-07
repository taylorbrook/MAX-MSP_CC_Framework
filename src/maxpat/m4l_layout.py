"""M4L presentation layout engine -- column-packing within 169px device height.

Groups live.* controls by semantic function (using _classify_parameter from
m4l_polish.py) and positions them as vertical columns in presentation view.

Rules:
  D-01: Groups derived from _classify_parameter (semantic keyword matching)
  D-02: Each group gets a live.comment header label
  D-03: Groups flow left-to-right as vertical columns
  D-07: Label 18px + 4px gap before first control
  D-08: Control sizes from UI_SIZES (exact, no scaling)
  D-09: Horizontal gap between group columns
  D-10: All presentation_rect values are whole integers
  D-11: Auto-fit devicewidth, starting at 300px default
  D-12: Standalone module, layout_m4l_presentation(patch_dict) entry point
  D-14: Controls with existing presentation_rect are not repositioned

Pipeline: agents build -> polish -> layout -> export (D-13).
"""

from __future__ import annotations

from src.maxpat.m4l_polish import _classify_parameter, _collect_live_controls
from src.maxpat.sizing import UI_SIZES


# ---------------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------------

DEVICE_HEIGHT = 169          # Ableton M4L device height cap
TOP_MARGIN = 4               # Top margin
BOTTOM_MARGIN = 4            # Bottom margin
LEFT_MARGIN = 4              # Left edge margin
GROUP_LABEL_HEIGHT = 18      # live.comment label height
LABEL_GAP = 4                # Gap between label and first control
CONTROL_V_GAP = 4            # Vertical gap between stacked controls
GROUP_H_GAP = 10             # Horizontal gap between group columns
DEFAULT_DEVICEWIDTH = 300    # Starting devicewidth
MAX_DEVICEWIDTH = 900        # Ableton max device width
TALL_CONTROL_THRESHOLD = 100 # Controls taller than this skip group label
DEFAULT_CONTROL_SIZE = (100, 22)  # Fallback for unknown controls

# Group ordering by typical synth signal flow
GROUP_PRIORITY: dict[str, int] = {
    "Pitch": 0,
    "Filter": 1,
    "Amp": 2,
    "Envelope": 3,
    "Mod": 4,
    "FX": 5,
    "Noise": 6,
    "Mix": 7,
    "Main": 8,
}


# ---------------------------------------------------------------------------
# Internal helpers
# ---------------------------------------------------------------------------

def _get_control_size(maxclass: str) -> tuple[int, int]:
    """Look up control size from UI_SIZES. Returns (w, h) as ints."""
    size = UI_SIZES.get(maxclass)
    if size is not None:
        return (int(size[0]), int(size[1]))
    return (int(DEFAULT_CONTROL_SIZE[0]), int(DEFAULT_CONTROL_SIZE[1]))


def _set_pres_rect(box: dict, x: int, y: int, w: int, h: int) -> None:
    """Set presentation=1 and presentation_rect with all int values."""
    box["presentation"] = 1
    box["presentation_rect"] = [int(x), int(y), int(w), int(h)]


def _add_group_label(
    boxes: list,
    name: str,
    x: int,
    y: int,
    width: int,
    label_id: str,
) -> dict:
    """Create a live.comment label box and append to boxes list.

    Returns the created box dict.
    """
    label_box = {
        "id": label_id,
        "maxclass": "live.comment",
        "numinlets": 1,
        "numoutlets": 0,
        "outlettype": [],
        "text": name,
        "presentation": 1,
        "presentation_rect": [
            int(x), int(y), int(width), int(GROUP_LABEL_HEIGHT),
        ],
        "textjustification": 1,  # Center-aligned
    }
    boxes.append({"box": label_box})
    return label_box


def _get_longname(box: dict) -> str:
    """Extract parameter_longname from box dict."""
    saa = box.get("saved_attribute_attributes", {})
    valueof = saa.get("valueof", {})
    return valueof.get("parameter_longname", "")


def _group_controls(controls: list[dict]) -> dict[str, list[dict]]:
    """Group controls by semantic function using _classify_parameter.

    Uses parameter_longname from saved_attribute_attributes.valueof.
    Falls back to varname if longname is missing.
    """
    groups: dict[str, list[dict]] = {}
    for box in controls:
        longname = _get_longname(box)
        if not longname:
            longname = box.get("varname", "")
        if not longname:
            longname = "unknown"
        group = _classify_parameter(longname)
        groups.setdefault(group, []).append(box)
    return groups


def _has_tall_control(controls: list[dict]) -> bool:
    """Check if any control in the group exceeds TALL_CONTROL_THRESHOLD."""
    for box in controls:
        _, h = _get_control_size(box.get("maxclass", ""))
        if h >= TALL_CONTROL_THRESHOLD:
            return True
    return False


def _layout_column(
    group_name: str,
    controls: list[dict],
    x: int,
    boxes: list,
    label_counter: int,
) -> tuple[int, int]:
    """Position controls in a vertical column starting at x.

    Adds group label (unless all controls are tall).
    Returns (column_width, updated_label_counter).
    """
    y = TOP_MARGIN
    skip_label = _has_tall_control(controls)

    # Track widest control to determine column width
    max_width = 0

    # Add group label if not skipped
    if not skip_label:
        # Compute label width from widest control
        for box in controls:
            w, _ = _get_control_size(box.get("maxclass", ""))
            if w > max_width:
                max_width = w

        label_width = max(max_width, 44)  # At least 44px wide
        label_id = f"obj-layout-label-{label_counter}"
        _add_group_label(boxes, group_name, x, y, label_width, label_id)
        label_counter += 1
        y += GROUP_LABEL_HEIGHT + LABEL_GAP

    # Position each control vertically
    for box in controls:
        w, h = _get_control_size(box.get("maxclass", ""))
        _set_pres_rect(box, x, y, w, h)
        y += h + CONTROL_V_GAP
        if w > max_width:
            max_width = w

    return (max_width, label_counter)


def _compute_columns(
    groups: dict[str, list[dict]],
    boxes: list,
    patcher: dict,
) -> None:
    """Iterate groups left-to-right, position as columns.

    Updates devicewidth if columns exceed default width.
    """
    # Sort groups by signal flow priority
    sorted_groups = sorted(
        groups.items(),
        key=lambda kv: GROUP_PRIORITY.get(kv[0], 99),
    )

    x = LEFT_MARGIN
    label_counter = 0

    for group_name, controls in sorted_groups:
        col_width, label_counter = _layout_column(
            group_name, controls, x, boxes, label_counter,
        )
        x += col_width + GROUP_H_GAP

    # Total used width (subtract last gap, add right margin)
    total_width = x - GROUP_H_GAP + LEFT_MARGIN

    # Update devicewidth if needed
    current_width = patcher.get("devicewidth", DEFAULT_DEVICEWIDTH)
    if total_width > current_width:
        patcher["devicewidth"] = min(int(total_width), MAX_DEVICEWIDTH)


# ---------------------------------------------------------------------------
# Main entry point
# ---------------------------------------------------------------------------

def layout_m4l_presentation(patch_dict: dict) -> dict:
    """Position live.* controls in M4L presentation view.

    Mutates patch_dict in place. Returns the same dict.
    Pipeline: agents build -> polish -> layout -> export (D-13).

    - Collects live controls via _collect_live_controls
    - Filters to those without presentation_rect (D-14)
    - Groups via _classify_parameter (D-01)
    - Sorts groups by GROUP_PRIORITY
    - Computes column positions, adds group labels (D-02)
    - Sets presentation_rect with int() rounding (D-10)
    - Updates devicewidth if needed (D-11)
    """
    patcher = patch_dict.get("patcher", {})
    boxes = patcher.get("boxes", [])
    controls = _collect_live_controls(boxes)

    if not controls:
        return patch_dict

    # Filter to controls without existing presentation_rect (D-14)
    needs_layout = [c for c in controls if not c.get("presentation_rect")]
    if not needs_layout:
        return patch_dict

    # Group by semantic function (D-01)
    groups = _group_controls(needs_layout)

    if not groups:
        return patch_dict

    # Apply column layout
    _compute_columns(groups, boxes, patcher)

    return patch_dict
