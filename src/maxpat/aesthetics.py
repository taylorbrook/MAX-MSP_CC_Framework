"""Aesthetic styling helpers for MAX patcher generation.

Provides palette access, canvas background setting, and object background
color helpers. All colors come from AESTHETIC_PALETTE in defaults.py.
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
