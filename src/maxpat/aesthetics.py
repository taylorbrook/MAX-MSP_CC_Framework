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
