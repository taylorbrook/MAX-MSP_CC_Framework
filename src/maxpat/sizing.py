"""Content-aware box sizing for MAX objects.

Computes (width, height) for any MAX object box:
- UI objects with fixed dimensions return their standard sizes.
- Objects with audit-based width data return measured widths from help patches.
- Text-based objects (newobj, comment, message) compute width from text length.

Values sourced from 02-RESEARCH.md Example 1, audit data, and MAX 9 default behavior.
"""

import json
from pathlib import Path

from src.maxpat.defaults import CHAR_WIDTH, PADDING, MIN_BOX_WIDTH, DEFAULT_HEIGHT


def _load_width_overrides() -> dict[str, dict[str, float]]:
    """Load width override table from audit data.

    Returns dict keyed by object_name, values are dicts with
    arg_count string keys ("0", "1", "default") mapping to widths.
    """
    override_path = Path(__file__).parent.parent.parent / ".claude" / "max-objects" / "audit" / "width-overrides.json"
    if not override_path.exists():
        return {}
    with open(override_path) as f:
        return json.load(f)


_WIDTH_OVERRIDES: dict[str, dict[str, float]] = _load_width_overrides()


def _load_bpatcher_dims() -> dict[str, tuple[float, float]]:
    """Load bpatcher dimensions from package DB entries.

    Scans .claude/max-objects/packages/*/objects.json at import time and
    builds a dict mapping object name to (width, height) for any entry
    with a ``bpatcher_dimensions`` field.
    """
    dims: dict[str, tuple[float, float]] = {}
    pkg_root = Path(__file__).parent.parent.parent / ".claude" / "max-objects" / "packages"
    if not pkg_root.is_dir():
        return dims
    for pkg_dir in pkg_root.iterdir():
        if not pkg_dir.is_dir():
            continue
        json_path = pkg_dir / "objects.json"
        if not json_path.exists():
            continue
        with open(json_path) as f:
            data = json.load(f)
        for name, obj in data.items():
            bp_dims = obj.get("bpatcher_dimensions")
            if bp_dims and len(bp_dims) >= 2:
                dims[name] = (float(bp_dims[0]), float(bp_dims[1]))
    return dims


_BPATCHER_DIMS: dict[str, tuple[float, float]] = _load_bpatcher_dims()


def get_bpatcher_dims(object_name: str) -> tuple[float, float] | None:
    """Return (width, height) for a known bpatcher object, or None."""
    return _BPATCHER_DIMS.get(object_name)


# Fixed sizes for UI objects: maxclass -> (width, height).
# None means the object uses text-based sizing (comment, message).
UI_SIZES: dict[str, tuple[float, float] | None] = {
    "toggle":        (24.0, 24.0),
    "button":        (24.0, 24.0),
    "slider":        (20.0, 140.0),
    "dial":          (40.0, 40.0),
    "number":        (50.0, 22.0),
    "flonum":        (50.0, 22.0),
    "led":           (24.0, 24.0),
    "rslider":       (20.0, 140.0),
    # For labeled parameter banks, override patching_rect height with MS_BAR_HEIGHT * size
    # (see defaults.py MS_BAR_HEIGHT and CLAUDE.md Rule #4 subsection)
    "multislider":   (200.0, 100.0),
    "kslider":       (336.0, 53.0),
    "nslider":       (40.0, 140.0),
    "panel":         (128.0, 128.0),
    "radiogroup":    (18.0, 82.0),
    "textbutton":    (100.0, 20.0),
    "tab":           (200.0, 24.0),
    "pictctrl":      (100.0, 100.0),
    "pictslider":    (100.0, 100.0),
    "incdec":        (20.0, 24.0),
    "swatch":        (128.0, 64.0),
    "colorpicker":   (221.0, 191.0),
    "chooser":       (100.0, 100.0),
    "listbox":       (100.0, 100.0),
    "umenu":         (100.0, 22.0),
    "textedit":      (200.0, 100.0),
    "attrui":        (150.0, 22.0),
    "preset":        (100.0, 40.0),
    "matrixctrl":    (130.0, 66.0),
    "nodes":         (200.0, 200.0),
    "jsui":          (100.0, 100.0),
    "fpic":          (100.0, 100.0),
    "lcd":           (128.0, 128.0),
    "hint":          (100.0, 22.0),
    "dropfile":      (100.0, 100.0),
    "ubutton":       (100.0, 100.0),
    "playbar":       (320.0, 24.0),
    # Patcher structure
    "inlet":         (30.0, 30.0),
    "outlet":        (30.0, 30.0),
    "patcher":       None,   # Text-based: "p subpatcher_name"
    "bpatcher":      (200.0, 100.0),
    # MSP UI
    "meter~":        (15.0, 100.0),
    "levelmeter~":   (24.0, 128.0),
    "spectroscope~": (300.0, 100.0),
    "scope~":        (130.0, 130.0),
    "number~":       (56.0, 22.0),
    "gain~":         (22.0, 140.0),
    "ezdac~":        (45.0, 45.0),
    "ezadc~":        (45.0, 45.0),
    # Gen~
    "gen~":          (150.0, 22.0),
    # Max for Live UI
    "live.dial":     (44.0, 66.0),
    "live.slider":   (39.0, 87.0),
    "live.numbox":   (56.0, 15.0),
    "live.toggle":   (15.0, 15.0),
    "live.button":   (15.0, 15.0),
    "live.text":     (44.0, 15.0),
    "live.menu":     (100.0, 15.0),
    "live.tab":      (100.0, 20.0),
    "live.meter~":   (5.0, 100.0),
    "live.gain~":    (48.0, 136.0),
    "live.scope~":   (131.0, 131.0),
    # Max for Live visual widgets (added)
    "live.arrows":   (54.0, 15.0),
    "live.banks":    (315.0, 45.0),
    "live.colors":   (168.0, 45.0),
    "live.comment":  (150.0, 18.0),
    "live.drop":     (140.0, 50.0),
    "live.grid":     (240.0, 165.0),
    "live.line":     (100.0, 35.0),
    "live.step":     (240.0, 60.0),
    # Max for Live non-visual utility objects (text-sized)
    "live.observer":     None,
    "live.thisdevice":   None,
    "live.path":         None,
    "live.object":       None,
    "live.map":          None,
    "live.routing":      None,
    "live.push":         None,
    "live.miditool.in":  None,
    "live.miditool.out": None,
    "live.remote~":      None,
    "live.param~":       None,
    "live.modulate~":    None,
    # Text-based UI objects
    "comment":       None,
    "message":       None,
}

# Comment box height (slightly shorter than newobj/message)
COMMENT_HEIGHT = 20.0


def text_width(text: str, maxclass: str = "newobj") -> float:
    """Return the rendered width of a MAX object given its full text.

    Use this to compute layout positions that account for actual object widths.
    Works for newobj, comment, message, and any text-based box.

    Example:
        w = text_width("prepend mallet_hardness")  # -> 177.0
        next_col_x = prev_col_x + w + H_GUTTER
    """
    w, _ = calculate_box_size(text, maxclass)
    return w


def calculate_box_size(text: str, maxclass: str) -> tuple[float, float]:
    """Calculate box dimensions for a MAX object.

    For UI objects with fixed sizes, returns the standard (width, height).
    For text-based objects (newobj, comment, message, or UI objects with None size),
    computes width from text length.

    Args:
        text: The display text of the object (e.g., "cycle~ 440").
        maxclass: The resolved maxclass (e.g., "newobj", "toggle", "comment").

    Returns:
        (width, height) as floats.
    """
    # Check if it's a UI object with a fixed size
    if maxclass in UI_SIZES:
        fixed_size = UI_SIZES[maxclass]
        if fixed_size is not None:
            return fixed_size

    # Width override lookup for newobj boxes
    if maxclass == "newobj" and text:
        parts = text.split()
        obj_name = parts[0]
        arg_count = len(parts) - 1
        overrides = _WIDTH_OVERRIDES.get(obj_name)
        if overrides:
            override_width = overrides.get(str(arg_count)) or overrides.get("default")
            if override_width:
                text_width = len(text) * CHAR_WIDTH + PADDING
                return (max(override_width, text_width), DEFAULT_HEIGHT)

    # Text-based sizing: newobj, comment, message, or UI objects with None size
    width = len(text) * CHAR_WIDTH + PADDING
    width = max(width, MIN_BOX_WIDTH)

    if maxclass == "comment":
        height = COMMENT_HEIGHT
    else:
        height = DEFAULT_HEIGHT

    return (width, height)
