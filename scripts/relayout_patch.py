"""Re-layout an existing .maxpat file using the layout engine.

Reads a .maxpat JSON, hydrates lightweight Box/Patchline objects,
runs apply_layout() to reposition everything, then writes updated
positions and midpoints back to the JSON.
"""

import json
import sys
from pathlib import Path

# Add project root to path
sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from src.maxpat.layout import apply_layout


class _LayoutBox:
    """Lightweight Box stand-in for the layout engine."""

    def __init__(self, box_dict: dict):
        self.id = box_dict["id"]
        self.name = box_dict.get("text", box_dict.get("maxclass", "")).split()[0]
        self.patching_rect = list(box_dict["patching_rect"])
        self.numinlets = box_dict.get("numinlets", 1)
        self.numoutlets = box_dict.get("numoutlets", 0)
        self.presentation = bool(box_dict.get("presentation", 0))
        self.presentation_rect = box_dict.get("presentation_rect")
        self._inner_patcher = None


class _LayoutLine:
    """Lightweight Patchline stand-in for the layout engine."""

    def __init__(self, line_dict: dict):
        pl = line_dict["patchline"]
        self.source_id = pl["source"][0]
        self.source_outlet = pl["source"][1]
        self.dest_id = pl["destination"][0]
        self.dest_inlet = pl["destination"][1]
        self.midpoints = []  # Clear existing midpoints for re-generation


class _LayoutPatcher:
    """Lightweight Patcher stand-in for the layout engine."""

    def __init__(self, patcher_dict: dict, is_subpatcher: bool = False):
        self.boxes: list[_LayoutBox] = []
        self.lines: list[_LayoutLine] = []
        self.props = patcher_dict
        self._is_subpatcher = is_subpatcher

        for b in patcher_dict.get("boxes", []):
            box = _LayoutBox(b["box"])
            # Recursively hydrate inner patchers
            if "patcher" in b["box"]:
                inner_dict = b["box"]["patcher"]
                box._inner_patcher = _LayoutPatcher(inner_dict, is_subpatcher=True)
            self.boxes.append(box)

        for l in patcher_dict.get("lines", []):
            self.lines.append(_LayoutLine(l))


def _write_back(patcher_dict: dict, layout_patcher: _LayoutPatcher) -> None:
    """Write layout positions and midpoints back to the raw JSON dict."""
    # Build lookup from layout boxes
    box_map = {b.id: b for b in layout_patcher.boxes}

    for b in patcher_dict.get("boxes", []):
        box_data = b["box"]
        lb = box_map.get(box_data["id"])
        if lb is None:
            continue
        box_data["patching_rect"] = lb.patching_rect

        # Write back presentation_rect if set by layout
        if lb.presentation_rect is not None:
            box_data["presentation_rect"] = lb.presentation_rect

        # Recursively handle inner patchers
        if "patcher" in box_data and lb._inner_patcher is not None:
            _write_back(box_data["patcher"], lb._inner_patcher)

    # Build lookup from layout lines by (source_id, source_outlet, dest_id, dest_inlet)
    line_map: dict[tuple, _LayoutLine] = {}
    for ll in layout_patcher.lines:
        key = (ll.source_id, ll.source_outlet, ll.dest_id, ll.dest_inlet)
        line_map[key] = ll

    for l in patcher_dict.get("lines", []):
        pl = l["patchline"]
        key = (pl["source"][0], pl["source"][1],
               pl["destination"][0], pl["destination"][1])
        ll = line_map.get(key)
        if ll is None:
            continue
        if ll.midpoints:
            pl["midpoints"] = ll.midpoints
        elif "midpoints" in pl:
            del pl["midpoints"]

    # Update patcher rect
    rect = layout_patcher.props.get("rect")
    if rect:
        patcher_dict["rect"] = rect


def relayout(path: str) -> None:
    """Re-layout a .maxpat file in place."""
    with open(path) as f:
        data = json.load(f)

    patcher_dict = data["patcher"]
    layout_patcher = _LayoutPatcher(patcher_dict)

    apply_layout(layout_patcher)

    _write_back(patcher_dict, layout_patcher)

    with open(path, "w") as f:
        json.dump(data, f, indent=2)
        f.write("\n")

    print(f"Re-laid out: {path}")
    print(f"  {len(layout_patcher.boxes)} boxes, {len(layout_patcher.lines)} lines")


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python relayout_patch.py <path-to-maxpat>")
        sys.exit(1)
    relayout(sys.argv[1])
