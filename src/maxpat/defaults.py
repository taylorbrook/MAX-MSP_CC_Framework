"""MAX 9 default patcher properties, font constants, spacing constants.

All values match the MAX 9 .maxpat JSON structure verified in 02-RESEARCH.md Pattern 1.
"""

from dataclasses import dataclass

# Font constants (MAX 9 defaults)
FONT_NAME = "Arial"
FONT_SIZE = 12.0
CHAR_WIDTH = 7.0       # Approximate pixels per character at 12pt Arial
PADDING = 16.0          # Left + right padding inside a box
MIN_BOX_WIDTH = 40.0    # Minimum box width for very short objects
DEFAULT_HEIGHT = 22.0   # Standard text box height (newobj, message)

# Layout spacing constants
V_SPACING = 20          # Vertical gap between rows (~16-20px matches real MAX patches)
H_GUTTER = 15           # Horizontal gap between objects in a row

# Midpoint generation thresholds
HORIZONTAL_THRESHOLD = 20.0   # Min horizontal offset to trigger midpoint generation
UPWARD_BUS_THRESHOLD = 60.0   # Min upward distance to use right-edge bus routing
BUS_MARGIN = 30.0             # Gap between rightmost object and bus start X
BUS_SPACING = 8.0             # Spacing between parallel bus cables
PATCHER_PADDING = 40.0        # Padding around content for auto-sized patcher rect


@dataclass
class LayoutOptions:
    """Configurable layout parameters for patch generation.

    Default values match existing module-level constants for backward
    compatibility. Pass to apply_layout() to customize spacing and alignment.
    """
    v_spacing: float = 20.0
    h_gutter: float = 15.0
    patcher_padding: float = 40.0
    grid_size: float = 15.0
    grid_snap: bool = True
    inlet_align: bool = True
    comment_gap: float = 10.0


# Subpatcher default window size
SUBPATCHER_RECT = [100.0, 100.0, 400.0, 300.0]

# Gen~ inner patcher background color (light gray, matches MAX default)
GEN_PATCHER_BGCOLOR = [0.9, 0.9, 0.9, 1.0]

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

# Fontface constants (bitmask encoding used in .maxpat JSON)
FONTFACE_REGULAR = 0
FONTFACE_BOLD = 1
FONTFACE_ITALIC = 2
FONTFACE_BOLD_ITALIC = 3

# Bubbleside constants (comment box bubble arrow direction)
BUBBLE_LEFT = 0     # Arrow points left, bubble on right
BUBBLE_TOP = 1      # Arrow points up, bubble below (default)
BUBBLE_RIGHT = 2    # Arrow points right, bubble on left
BUBBLE_BOTTOM = 3   # Arrow points down, bubble above

# Semantic color palette -- all RGBA values in [0.0, 1.0] range.
# Cool/neutral temperature: blues, grays, slate tones matching MAX 9 UI.
AESTHETIC_PALETTE = {
    # Comment tiers
    "header_color": [0.20, 0.25, 0.42, 1.0],         # deep slate blue text
    "header_bgcolor": [0.88, 0.90, 0.95, 1.0],        # light blue-gray background
    "subsection_color": [0.30, 0.30, 0.35, 1.0],      # dark gray
    "annotation_color": [0.55, 0.55, 0.60, 1.0],      # light gray
    "warning_color": [0.75, 0.22, 0.17, 1.0],         # muted red for warnings

    # Panel fills
    "panel_fill": [0.94, 0.94, 0.96, 1.0],            # very light cool gray
    "panel_gradient_end": [0.88, 0.89, 0.92, 1.0],    # slightly darker cool gray

    # Canvas
    "canvas_bg": [0.333, 0.333, 0.333, 1.0],           # standard MAX 9 dark grey

    # Step markers
    "step_marker_bg": [0.85, 0.65, 0.13, 1.0],        # amber/gold
    "step_marker_text": [1.0, 1.0, 1.0, 1.0],         # white

    # Object emphasis (when explicitly requested)
    "emphasis_loadbang": [0.85, 0.92, 0.85, 1.0],     # pale green
    "emphasis_dac": [0.92, 0.85, 0.85, 1.0],          # pale red
    "emphasis_processor": [0.85, 0.87, 0.95, 1.0],    # pale blue
}
