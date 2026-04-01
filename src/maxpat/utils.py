"""Shared utility helpers for the maxpat package."""

from __future__ import annotations


def get_box_name(box: dict) -> str:
    """Get the MAX object name from a box dict.

    For maxclass == "newobj", returns the first word of the text field.
    Otherwise returns the maxclass itself.
    """
    maxclass = box.get("maxclass", "")
    if maxclass == "newobj":
        text = box.get("text", "")
        if text:
            return text.split()[0]
        return ""
    return maxclass
