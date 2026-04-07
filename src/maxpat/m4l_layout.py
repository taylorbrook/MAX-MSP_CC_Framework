"""M4L presentation layout engine -- column-packing within 169px device height.

Groups live.* controls by semantic function (using _classify_parameter from
m4l_polish.py) and positions them as vertical columns in presentation view.
Supports single-page and tabbed layout patterns.

Rules:
  D-01: Groups derived from _classify_parameter (semantic keyword matching)
  D-02: Each group gets a live.comment header label
  D-03: Groups flow left-to-right as vertical columns
  D-04: Tabbed layout uses live.tab + script hide/show via thispatcher
  D-05: Tab trigger: >8 controls or >3 groups
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

# Tabbed layout constants (Plan 02)
TAB_CONTROL_THRESHOLD = 8        # Total controls triggering tab mode (D-05)
TAB_GROUP_THRESHOLD = 3          # Groups triggering tab mode
TAB_HEIGHT = 20                  # live.tab presentation height
TAB_GAP = 4                      # Gap below live.tab
LAYOUT_VARNAME_PREFIX = "_layout_"  # Prefix for scripting names (Pitfall 3)

# Controls that always go on the first page (too tall for tabbed sub-pages)
_FIRST_PAGE_MAXCLASSES = {"live.gain~", "live.scope~"}

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
# Tabbed layout (Plan 02)
# ---------------------------------------------------------------------------

def _select_layout_pattern(
    groups: dict[str, list[dict]], patcher: dict,
) -> str:
    """Decide 'single' or 'tabbed' based on control/group count.

    Triggers tabbed when:
      - Total controls > TAB_CONTROL_THRESHOLD (D-05)
      - Number of groups > TAB_GROUP_THRESHOLD
    """
    total_controls = sum(len(ctrls) for ctrls in groups.values())
    if total_controls > TAB_CONTROL_THRESHOLD:
        return "tabbed"
    if len(groups) > TAB_GROUP_THRESHOLD:
        return "tabbed"
    return "single"


def _ensure_varname(box: dict, index: int) -> str:
    """Ensure box has a varname for scripting. Returns the varname.

    If box already has a varname, keeps it. Otherwise assigns one
    with LAYOUT_VARNAME_PREFIX to avoid collision (Pitfall 3).
    """
    existing = box.get("varname")
    if existing:
        return existing
    vn = f"{LAYOUT_VARNAME_PREFIX}ctrl_{index}"
    box["varname"] = vn
    return vn


def _create_tab_box(
    group_names: list[str], patcher: dict, device_width: int,
) -> dict:
    """Create live.tab box dict with proper M4L attributes.

    Returns the inner box dict (not wrapped in {"box": ...}).
    """
    tab_width = max(int(device_width - LEFT_MARGIN * 2), 100)
    tab_box = {
        "id": "obj-layout-tab",
        "maxclass": "live.tab",
        "numinlets": 1,
        "numoutlets": 3,
        "outlettype": ["", "", "float"],
        "patching_rect": [20, 20, int(tab_width), int(TAB_HEIGHT)],
        "presentation": 1,
        "presentation_rect": [
            int(LEFT_MARGIN), int(TOP_MARGIN),
            int(tab_width), int(TAB_HEIGHT),
        ],
        "livemode": 1,
        "num_lines_patching": 1,
        "num_lines_presentation": 1,
        "parameter_enable": 1,
        "saved_attribute_attributes": {
            "valueof": {
                "parameter_longname": "Page",
                "parameter_shortname": "Page",
                "parameter_type": 2,  # ENUM
                "parameter_enum": list(group_names),
            },
        },
    }
    return tab_box


def _create_tab_wiring(
    group_names: list[str],
    group_varnames: dict[str, list[str]],
    patcher: dict,
) -> None:
    """Create patching-mode wiring chain for tab switching.

    Chain: live.tab (outlet 0) -> select N -> message boxes -> thispatcher

    Each select outlet fires a message that shows one group's controls
    and hides all others via 'script show/hide' commands.
    """
    boxes = patcher.get("boxes", [])
    lines = patcher.setdefault("lines", [])

    n_pages = len(group_names)

    # select arguments: 0 1 2 ... (N-1)
    select_args = " ".join(str(i) for i in range(n_pages))
    select_id = "obj-layout-select"
    select_box = {
        "id": select_id,
        "maxclass": "newobj",
        "numinlets": 1,
        "numoutlets": n_pages + 1,  # N match outlets + 1 unmatched
        "outlettype": ["bang"] * n_pages + [""],
        "text": f"select {select_args}",
        "patching_rect": [20, 60, 150, 22],
    }
    boxes.append({"box": select_box})

    # thispatcher
    tp_id = "obj-layout-thispatcher"
    tp_box = {
        "id": tp_id,
        "maxclass": "thispatcher",
        "numinlets": 1,
        "numoutlets": 2,
        "outlettype": ["", ""],
        "patching_rect": [20, 200, 100, 22],
    }
    boxes.append({"box": tp_box})

    # Connect live.tab -> select
    lines.append({
        "patchline": {
            "source": ["obj-layout-tab", 0],
            "destination": [select_id, 0],
        },
    })

    # For each tab page, create a message box that shows that page's controls
    # and hides all other pages' controls
    all_varnames = []
    for gn in group_names:
        all_varnames.extend(group_varnames.get(gn, []))

    for page_idx, gn in enumerate(group_names):
        show_vns = group_varnames.get(gn, [])
        hide_vns = [
            vn for other_gn in group_names if other_gn != gn
            for vn in group_varnames.get(other_gn, [])
        ]

        # Build message text: show this page, hide others
        parts = []
        for vn in show_vns:
            parts.append(f"script show {vn}")
        for vn in hide_vns:
            parts.append(f"script hide {vn}")
        msg_text = ", ".join(parts)

        msg_id = f"obj-layout-msg-{page_idx}"
        msg_box = {
            "id": msg_id,
            "maxclass": "message",
            "numinlets": 2,
            "numoutlets": 1,
            "outlettype": [""],
            "text": msg_text,
            "patching_rect": [20 + page_idx * 160, 120, 150, 22],
        }
        boxes.append({"box": msg_box})

        # select outlet [page_idx] -> message inlet 0
        lines.append({
            "patchline": {
                "source": [select_id, page_idx],
                "destination": [msg_id, 0],
            },
        })

        # message outlet 0 -> thispatcher inlet 0
        lines.append({
            "patchline": {
                "source": [msg_id, 0],
                "destination": [tp_id, 0],
            },
        })


def _apply_tabbed_layout(
    groups: dict[str, list[dict]], patcher: dict,
) -> None:
    """Apply tabbed layout pattern with live.tab and script hide/show.

    - Creates live.tab at top with group names as tab labels
    - Positions each group's controls below the tab as a column
    - Sets hidden=1 on all pages except first
    - Assigns varnames with _layout_ prefix to controls lacking one
    - Special-cases live.gain~ / live.scope~ to always be on first page
    - Creates thispatcher + select + message wiring chain
    """
    boxes = patcher.get("boxes", [])

    # Sort groups by signal flow priority
    sorted_groups = sorted(
        groups.items(),
        key=lambda kv: GROUP_PRIORITY.get(kv[0], 99),
    )
    group_names = [gn for gn, _ in sorted_groups]

    # Separate first-page-only controls (live.gain~, live.scope~)
    first_page_extras: list[dict] = []
    filtered_groups: list[tuple[str, list[dict]]] = []
    for gn, ctrls in sorted_groups:
        normal = []
        for c in ctrls:
            if c.get("maxclass", "") in _FIRST_PAGE_MAXCLASSES:
                first_page_extras.append(c)
            else:
                normal.append(c)
        if normal:
            filtered_groups.append((gn, normal))

    # Update group_names to only include groups with remaining controls
    group_names = [gn for gn, _ in filtered_groups]

    # Assign varnames to all tabbed controls; track per-group varnames
    global_ctrl_index = 0
    group_varnames: dict[str, list[str]] = {}
    for gn, ctrls in filtered_groups:
        vns: list[str] = []
        for c in ctrls:
            vn = _ensure_varname(c, global_ctrl_index)
            vns.append(vn)
            global_ctrl_index += 1
        group_varnames[gn] = vns

    # Compute column widths per group (widest control in each)
    group_widths: dict[str, int] = {}
    for gn, ctrls in filtered_groups:
        max_w = 0
        for c in ctrls:
            w, _ = _get_control_size(c.get("maxclass", ""))
            if w > max_w:
                max_w = w
        group_widths[gn] = max(max_w, 44)

    # Compute device width needed for the widest tab page
    # Each page's groups get laid out as columns; the widest page determines devicewidth
    # But for simplicity, lay out ALL groups as columns (controls overlap by page)
    # Device width = sum of all group widths + gaps
    # Actually: each tab page shows only ONE group's controls. But the tab
    # itself spans the device. So device width = max(single group width) + margins
    # Wait -- the plan says groups become tab pages. Each tab page shows one group.

    # First-page extras (live.gain~) are always visible alongside the first page
    first_page_name = group_names[0] if group_names else None

    # Compute max content width across pages
    # Each page is a single group column (+ first_page_extras alongside)
    extra_width = 0
    if first_page_extras:
        for c in first_page_extras:
            w, _ = _get_control_size(c.get("maxclass", ""))
            extra_width = max(extra_width, w)
        extra_width += GROUP_H_GAP  # gap between extras and group column

    max_page_width = 0
    for gn in group_names:
        pw = group_widths.get(gn, 44)
        if gn == first_page_name:
            pw += extra_width
        if pw > max_page_width:
            max_page_width = pw

    device_width = max(
        LEFT_MARGIN + max_page_width + LEFT_MARGIN,
        DEFAULT_DEVICEWIDTH,
    )
    device_width = min(device_width, MAX_DEVICEWIDTH)

    # Create live.tab
    tab_box = _create_tab_box(group_names, patcher, device_width)
    boxes.append({"box": tab_box})

    # Position controls -- each group is a column below the tab
    tab_bottom = TOP_MARGIN + TAB_HEIGHT + TAB_GAP
    label_counter = 0

    for page_idx, (gn, ctrls) in enumerate(filtered_groups):
        is_first_page = (page_idx == 0)
        x = LEFT_MARGIN

        # If first page and there are extras, offset past them
        if is_first_page and first_page_extras:
            # Position first-page extras at left
            ey = tab_bottom
            for c in first_page_extras:
                w, h = _get_control_size(c.get("maxclass", ""))
                _set_pres_rect(c, x, ey, w, h)
                c["hidden"] = 0
                _ensure_varname(c, global_ctrl_index)
                global_ctrl_index += 1
                ey += h + CONTROL_V_GAP
                if w > extra_width - GROUP_H_GAP:
                    pass  # already accounted for
            x += extra_width

        # Position group controls in a column
        y = tab_bottom
        skip_label = _has_tall_control(ctrls)
        if not skip_label:
            label_id = f"obj-layout-label-{label_counter}"
            _add_group_label(
                boxes, gn, x, y, group_widths.get(gn, 44), label_id,
            )
            label_counter += 1
            y += GROUP_LABEL_HEIGHT + LABEL_GAP

        for c in ctrls:
            w, h = _get_control_size(c.get("maxclass", ""))
            _set_pres_rect(c, x, y, w, h)
            y += h + CONTROL_V_GAP

            # Set visibility: first page visible, others hidden
            if is_first_page:
                c["hidden"] = 0
            else:
                c["hidden"] = 1

    # Update devicewidth
    current_width = patcher.get("devicewidth", DEFAULT_DEVICEWIDTH)
    if device_width > current_width:
        patcher["devicewidth"] = int(device_width)

    # Also update tab width to match final device width
    final_dw = patcher.get("devicewidth", DEFAULT_DEVICEWIDTH)
    tab_w = max(int(final_dw - LEFT_MARGIN * 2), 100)
    tab_box["presentation_rect"][2] = int(tab_w)
    tab_box["patching_rect"][2] = int(tab_w)

    # Create wiring chain
    _create_tab_wiring(group_names, group_varnames, patcher)


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

    # Choose layout pattern (Plan 02)
    pattern = _select_layout_pattern(groups, patcher)

    if pattern == "tabbed":
        _apply_tabbed_layout(groups, patcher)
    else:
        # Apply single-page column layout
        _compute_columns(groups, boxes, patcher)

    return patch_dict
