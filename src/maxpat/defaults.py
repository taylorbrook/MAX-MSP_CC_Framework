"""MAX 9 default patcher properties, font constants, spacing constants.

All values match the MAX 9 .maxpat JSON structure verified in 02-RESEARCH.md Pattern 1.
"""

# Font constants (MAX 9 defaults)
FONT_NAME = "Arial"
FONT_SIZE = 12.0
CHAR_WIDTH = 7.0       # Approximate pixels per character at 12pt Arial
PADDING = 16.0          # Left + right padding inside a box
MIN_BOX_WIDTH = 40.0    # Minimum box width for very short objects
DEFAULT_HEIGHT = 22.0   # Standard text box height (newobj, message)

# Layout spacing constants
V_SPACING = 100         # Vertical spacing between objects (center of 80-120 range)
H_GUTTER = 70           # Horizontal gutter between columns (center of 60-80 range)

# Subpatcher default window size
SUBPATCHER_RECT = [100.0, 100.0, 400.0, 300.0]

# Complete MAX 9 patcher wrapper defaults (from 02-RESEARCH.md Pattern 1)
DEFAULT_PATCHER_PROPS = {
    "fileversion": 1,
    "appversion": {
        "major": 9,
        "minor": 0,
        "revision": 0,
        "architecture": "x64",
        "modernui": 1,
    },
    "classnamespace": "box",
    "rect": [85.0, 104.0, 640.0, 480.0],
    "bglocked": 0,
    "openinpresentation": 0,
    "default_fontsize": 12.0,
    "default_fontface": 0,
    "default_fontname": "Arial",
    "gridonopen": 1,
    "gridsize": [15.0, 15.0],
    "gridsnaponopen": 1,
    "objectsnaponopen": 1,
    "statusbarvisible": 2,
    "toolbarvisible": 1,
    "lefttoolbarpinned": 0,
    "toptoolbarpinned": 0,
    "righttoolbarpinned": 0,
    "bottomtoolbarpinned": 0,
    "toolbars_unpinned_last_save": 0,
    "tallnewobj": 0,
    "boxanimatetime": 200,
    "enablehscroll": 1,
    "enablevscroll": 1,
    "devicewidth": 0.0,
    "description": "",
    "digest": "",
    "tags": "",
    "style": "",
    "subpatcher_template": "",
    "assistshowspatchername": 0,
    "boxes": [],
    "lines": [],
    "dependency_cache": [],
    "autosave": 0,
}
