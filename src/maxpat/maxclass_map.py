"""Maxclass resolver: UI object set and resolve_maxclass function.

In .maxpat files, UI objects use their own name as maxclass (e.g., "toggle"),
while non-UI objects use "newobj" with the object name in the "text" field.

The UI_MAXCLASSES set is derived from 02-RESEARCH.md Pattern 7, verified against
MAX SDK scripting docs and py2max.
"""

# All UI maxclass names that use their own name (NOT "newobj") in .maxpat files.
# Verified from 02-RESEARCH.md Pattern 7 + MAX SDK scripting docs.
UI_MAXCLASSES: frozenset[str] = frozenset({
    # Text/display UI
    "comment", "message",
    # Number UI
    "number", "flonum",
    # Toggle/button UI
    "toggle", "button",
    # Slider/dial UI
    "slider", "dial", "rslider", "multislider",
    # Keyboard UI
    "kslider", "nslider",
    # Panel/display
    "panel", "led", "radiogroup",
    # Text interaction UI
    "textbutton", "tab", "umenu", "textedit",
    # Specialized UI
    "pictctrl", "pictslider", "incdec",
    "swatch", "colorpicker", "chooser", "listbox",
    "attrui", "preset", "matrixctrl", "nodes",
    # Special display
    "jsui", "fpic", "lcd", "hint",
    "dropfile", "ubutton", "playbar",
    # Patcher structure
    "inlet", "outlet", "patcher", "bpatcher",
    # MSP UI
    "meter~", "levelmeter~", "spectroscope~", "scope~",
    "number~", "gain~", "ezdac~", "ezadc~",
    # Max for Live UI
    "live.dial", "live.slider", "live.numbox",
    "live.toggle", "live.button", "live.text",
    "live.menu", "live.tab", "live.meter~", "live.gain~",
})


def resolve_maxclass(object_name: str) -> str:
    """Resolve the .maxpat maxclass field for a given object name.

    UI objects use their own name as maxclass.
    Non-UI objects use "newobj" with the object name in the "text" field.

    Args:
        object_name: The MAX object name (e.g., "cycle~", "toggle", "pack").

    Returns:
        The maxclass string for use in .maxpat JSON.
    """
    if object_name in UI_MAXCLASSES:
        return object_name
    return "newobj"


def is_ui_object(object_name: str) -> bool:
    """Check whether an object is a UI object.

    Args:
        object_name: The MAX object name.

    Returns:
        True if the object uses its own name as maxclass in .maxpat files.
    """
    return object_name in UI_MAXCLASSES
