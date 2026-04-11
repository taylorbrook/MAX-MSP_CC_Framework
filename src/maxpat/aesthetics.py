"""Aesthetic styling helpers for MAX patcher generation.

Provides palette access, canvas background setting, object background
color helpers, panel auto-sizing, and patch complexity heuristics.
All colors come from AESTHETIC_PALETTE in defaults.py.
"""

from __future__ import annotations

from typing import TYPE_CHECKING, Any

from src.maxpat.defaults import AESTHETIC_PALETTE

if TYPE_CHECKING:
    from src.maxpat.patcher import Box, Patcher


def contrast_text_color(bg_color: list[float] | None) -> list[float]:
    """Return a text color with good contrast against the given background.

    Uses perceived brightness (luminance) to choose dark or light text.

    Args:
        bg_color: RGBA background color, or None for default canvas.

    Returns:
        RGBA color list suitable for readable text on the background.
    """
    if bg_color is None:
        return list(AESTHETIC_PALETTE["annotation_color"])

    # Perceived brightness: L = 0.299*R + 0.587*G + 0.114*B
    luminance = 0.299 * bg_color[0] + 0.587 * bg_color[1] + 0.114 * bg_color[2]

    if luminance > 0.5:
        # Light background -> dark text
        return [0.20, 0.20, 0.25, 1.0]
    else:
        # Dark background -> light text
        return [0.80, 0.80, 0.82, 1.0]


def set_canvas_background(
    patcher: Patcher,
    color: list[float] | None = None,
) -> None:
    """Set patcher canvas background color.

    Sets both editing_bgcolor (unlocked mode) and locked_bgcolor (locked mode)
    to the same color for visual consistency.

    Args:
        patcher: The Patcher instance to style.
        color: Custom RGBA color list. Defaults to AESTHETIC_PALETTE["canvas_bg"].
    """
    bg = color if color is not None else AESTHETIC_PALETTE["canvas_bg"]
    patcher.props["editing_bgcolor"] = list(bg)
    patcher.props["locked_bgcolor"] = list(bg)


def set_object_bgcolor(
    box: Box,
    palette_key: str | None = None,
    color: list[float] | None = None,
) -> None:
    """Apply background color to a Box via extra_attrs.

    One of palette_key or color must be provided. If both are provided,
    palette_key takes precedence.

    Args:
        box: The Box instance to style.
        palette_key: Key in AESTHETIC_PALETTE to use for the color.
        color: Custom RGBA color list.

    Raises:
        ValueError: If neither palette_key nor color is provided.
    """
    if palette_key is not None:
        box.extra_attrs["bgcolor"] = list(AESTHETIC_PALETTE[palette_key])
    elif color is not None:
        box.extra_attrs["bgcolor"] = list(color)
    else:
        raise ValueError("One of palette_key or color must be provided")


def auto_size_panel(
    boxes: list[Box],
    padding: float = 18.0,
) -> tuple[float, float, float, float]:
    """Compute bounding box for a panel enclosing the given boxes.

    Returns (x, y, width, height) where the panel surrounds all boxes
    with the specified padding on every side.

    Args:
        boxes: List of Box instances to enclose. Each must have patching_rect.
        padding: Padding in pixels added on all four sides.

    Returns:
        (x, y, width, height) tuple. Returns (0.0, 0.0, 0.0, 0.0) if
        boxes is empty.
    """
    if not boxes:
        return (0.0, 0.0, 0.0, 0.0)

    min_x = min(b.patching_rect[0] for b in boxes)
    min_y = min(b.patching_rect[1] for b in boxes)
    max_x = max(b.patching_rect[0] + b.patching_rect[2] for b in boxes)
    max_y = max(b.patching_rect[1] + b.patching_rect[3] for b in boxes)

    return (
        min_x - padding,
        min_y - padding,
        (max_x - min_x) + 2 * padding,
        (max_y - min_y) + 2 * padding,
    )


_AUTO_HIGHLIGHT = {
    "dac~": "emphasis_dac",
    "ezdac~": "emphasis_dac",
    "loadbang": "emphasis_loadbang",
}


def apply_auto_styling(patcher: Patcher) -> None:
    """Apply default aesthetic styling to a patcher.

    Sets the canvas background color and highlights special objects
    (dac~, ezdac~, loadbang) with subtle palette colors. Skips boxes
    that already have a user-set bgcolor.
    """
    set_canvas_background(patcher)
    for box in patcher.boxes:
        palette_key = _AUTO_HIGHLIGHT.get(box.name)
        if palette_key and "bgcolor" not in box.extra_attrs:
            set_object_bgcolor(box, palette_key=palette_key)
    ensure_text_contrast(patcher)


def _point_in_rect(px: float, py: float, rect: list[float]) -> bool:
    """Check if point (px, py) is inside [x, y, w, h] rect."""
    x, y, w, h = rect
    return x <= px <= x + w and y <= py <= y + h


def _get_panel_bgcolor(panel: Box) -> list[float] | None:
    """Extract effective background color from a panel box.

    For gradient panels, uses color1 (the primary fill).
    For solid panels, uses bgcolor.
    Returns None if no color can be determined.
    """
    ea = panel.extra_attrs
    # Gradient panel: bgfillcolor.color1
    bgfill = ea.get("bgfillcolor")
    if bgfill and isinstance(bgfill, dict):
        color1 = bgfill.get("color1")
        if color1:
            return list(color1)
    # Solid panel: bgcolor
    bgcolor = ea.get("bgcolor")
    if bgcolor:
        return list(bgcolor)
    return None


def ensure_text_contrast(patcher: Patcher) -> None:
    """Set textcolor on all comment boxes for readability against their background.

    For each comment box, determines the effective background color:
    - If the comment center falls inside a panel, uses the panel's color
    - Otherwise uses the canvas background color

    Then sets textcolor via contrast_text_color() for maximum readability.
    Overrides semantic tier colors (header, subsection, annotation) because
    readability trumps cosmetic coloring on dark canvases.

    Args:
        patcher: The Patcher instance to process.
    """
    # Collect panels (maxclass == "panel")
    panels = [b for b in patcher.boxes if b.maxclass == "panel"]

    # Get canvas background color
    canvas_bg = (
        patcher.props.get("editing_bgcolor")
        or patcher.props.get("locked_bgcolor")
        or AESTHETIC_PALETTE["canvas_bg"]
    )

    for box in patcher.boxes:
        if box.maxclass != "comment":
            continue

        # Compute center point of comment box
        rect = box.patching_rect
        cx = rect[0] + rect[2] * 0.5
        cy = rect[1] + rect[3] * 0.5

        # Find the effective background: last panel whose rect contains the center
        effective_bg = list(canvas_bg)
        for panel in panels:
            if _point_in_rect(cx, cy, panel.patching_rect):
                panel_color = _get_panel_bgcolor(panel)
                if panel_color is not None:
                    effective_bg = panel_color

        box.extra_attrs["textcolor"] = contrast_text_color(effective_bg)


def is_complex_patch(patcher: Patcher) -> bool:
    """Heuristic to determine if a patch is visually complex.

    A patch is considered complex if it has 10 or more boxes, or if any
    box contains a subpatcher (inner patcher).

    Args:
        patcher: The Patcher instance to evaluate.

    Returns:
        True if the patch is complex, False otherwise.
    """
    if len(patcher.boxes) >= 10:
        return True
    for box in patcher.boxes:
        if box._inner_patcher is not None:
            return True
    return False
