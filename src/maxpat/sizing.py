"""Content-aware box sizing for MAX objects.

Computes (width, height) for any MAX object box:
- UI objects with fixed dimensions return their standard sizes.
- Text-based objects (newobj, comment, message) compute width from text length.

Values sourced from 02-RESEARCH.md Example 1 and MAX 9 default behavior.
"""

from src.maxpat.defaults import CHAR_WIDTH, PADDING, MIN_BOX_WIDTH, DEFAULT_HEIGHT

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
    # Text-based UI objects
    "comment":       None,
    "message":       None,
}

# Comment box height (slightly shorter than newobj/message)
COMMENT_HEIGHT = 20.0


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

    # Text-based sizing: newobj, comment, message, or UI objects with None size
    width = len(text) * CHAR_WIDTH + PADDING
    width = max(width, MIN_BOX_WIDTH)

    if maxclass == "comment":
        height = COMMENT_HEIGHT
    else:
        height = DEFAULT_HEIGHT

    return (width, height)
