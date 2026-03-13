# Phase 10: Aesthetic Foundations - Research

**Researched:** 2026-03-13
**Domain:** MAX/MSP .maxpat JSON visual styling (comments, panels, patcher colors, step markers)
**Confidence:** HIGH

## Summary

Phase 10 adds professional visual styling primitives to the patch generation system. The work is entirely in the Python `src/maxpat/` module -- adding new methods to `Patcher`, new constants to `defaults.py`, and a new `aesthetics.py` module for the semantic palette and styling helpers. All styling is achieved through JSON attributes in the .maxpat format; no external dependencies are needed.

The research verified exact JSON structures for all target features by examining 4,798 panel instances, 761+ bubble comments, and gradient fill configurations across the MAX 9 application bundle. The critical finding is that panel gradients use TWO different formats in the wild: the old-style `mode: 1` + `grad1`/`grad2` (116 instances found) and the modern `bgfillcolor` dict format (17 instances found). The CONTEXT.md decision specifies `bgfillcolor` dict format, which is the forward-looking approach and is supported by panel's documented `bgfillcolor` attribute.

**Primary recommendation:** Build a new `src/maxpat/aesthetics.py` module containing the semantic palette, comment tier helpers, panel builder, and step marker builder. Wire these into `Patcher` as new convenience methods (add_section_header, add_annotation, add_panel, add_step_marker). Keep all color constants in `defaults.py`.

<user_constraints>

## User Constraints (from CONTEXT.md)

### Locked Decisions
- Three distinct comment tiers with bold contrast: section headers (16pt bold + color with bgcolor/textcolor), subsection labels (12pt bold, dark gray), inline annotations (10pt italic, light gray)
- No separate panel objects behind headers -- use comment box's own styling attributes fully
- Bubble comments are opt-in only, not automatic; default bubble direction: top (arrow points down)
- Gradient fills by default on panels -- subtle depth using bgfillcolor dict with type "gradient", color1, color2, angle, proportion (capped below 1.0)
- Auto-sizing from object groups: compute bounding box of grouped objects + configurable padding (15-20px)
- Borderless panels -- no visible border, fill contrast against canvas defines the region
- Rounded corners (6-8px radius) for modern look matching MAX 9 UI
- Panels inserted at index 0 in boxes array with background: 1 and ignoreclick: 1 for correct z-order
- One semantic palette dict with named roles: header_color, annotation_color, panel_fill, panel_gradient_end, canvas_bg, warning_color
- Cool/neutral temperature: blues, grays, slate tones -- professional, matching MAX 9 default UI
- Patcher canvas background: slight off-white tint (e.g., [0.97, 0.97, 0.98, 1.0])
- No per-object background coloring by default -- only when explicitly requested
- Step markers: amber/gold textbutton circles, white number, rounded=60, background layer
- Step markers positioned at top-left of section panel, slightly overlapping the edge
- Auto-generated on complex patches, opt-in for simple ones

### Claude's Discretion
- Exact color values for the semantic palette (within cool/neutral range)
- Complexity heuristic for auto step markers (signal stages, object count, subpatcher presence, or combination)
- Gradient angle and proportion values for default panels
- Corner radius exact value (within 6-8px range)
- Auto-size padding exact value (within 15-20px range)
- Internal API design (helper functions, class structure, method signatures)

### Deferred Ideas (OUT OF SCOPE)
None -- discussion stayed within phase scope

</user_constraints>

<phase_requirements>

## Phase Requirements

| ID | Description | Research Support |
|----|-------------|-----------------|
| CMNT-01 | Section header comments with configurable fontsize (14-18pt), fontface (bold), textcolor | Verified: comment box supports fontsize, fontface (1=bold), textcolor as direct box attributes. See Comment Styling Patterns section. |
| CMNT-02 | Bubble comment annotations with bubble outline, configurable bubbleside, arrow pointing toward target | Verified: comment box supports bubble: 1, bubbleside (0=left, 2=right, 3=bottom, default=top), bubble_bgcolor, bubble_outlinecolor. See Bubble Comment section. |
| CMNT-03 | Hierarchical three-tier comment system: section header, subsection label, inline annotation | Verified: all three tiers implementable via fontsize + fontface + textcolor on comment boxes. See Comment Tier Architecture section. |
| CMNT-04 | Semantic color palette for consistent colors across generated patches | Pure Python implementation; palette dict in defaults.py with named roles. See Semantic Palette section. |
| PANL-01 | Panel objects with bgfillcolor, rounded corners, border, correct background layer placement | Verified: panel maxclass supports bgfillcolor dict, rounded attribute, border attribute, background: 1. See Panel JSON Structure section. |
| PANL-02 | Panels at index 0 in boxes array with background: 1 and ignoreclick: 1 | Implementation detail in Patcher.add_panel() -- insert at index 0 in self.boxes list. See Panel Z-Order section. |
| PANL-03 | Panel auto-sizing from bounding box of positioned object groups + configurable padding | Pure Python bounding box computation over Box.patching_rect values. See Auto-Sizing section. |
| PANL-04 | Gradient panel support via bgfillcolor dict with type "gradient", color1, color2, angle, proportion | Verified at patcher level; panel's bgfillcolor attribute documented. See Gradient Format section. |
| PANL-05 | Step marker numbering using textbutton circles with amber bg, rounded=60, background layer | Verified: textbutton supports rounded (float), bgcolor, textcolor, text attributes. See Step Marker section. |
| PTCH-01 | Patcher-level editing_bgcolor and locked_bgcolor via patcher props | Verified: editing_bgcolor is a standard patcher prop, found in MAX 9 tour patches. See Patcher Background section. |
| PTCH-02 | Object bgcolor applied to key architectural objects via extra_attrs | Verified: comment box supports bgcolor attribute; for newobj boxes, bgcolor goes in extra_attrs which merges last in to_dict(). See Object Background section. |

</phase_requirements>

## Standard Stack

### Core
| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| Python 3.14 | 3.14 | Implementation language | Existing project runtime |
| pytest | 9.0.2 | Test framework | Existing project test runner |

### Supporting
No external libraries needed. All styling is achieved through .maxpat JSON attributes.

### Existing Project Modules (Modified)
| Module | Purpose | Changes Needed |
|--------|---------|----------------|
| `src/maxpat/defaults.py` | Constants and defaults | Add palette colors, panel defaults, comment tier configs |
| `src/maxpat/patcher.py` | Patcher/Box model | Add add_section_header, add_subsection, add_annotation, add_bubble, add_panel, add_step_marker methods |
| `src/maxpat/sizing.py` | Box sizing | May need height adjustment for styled comments with larger fonts |

### New Project Modules
| Module | Purpose |
|--------|---------|
| `src/maxpat/aesthetics.py` | Semantic palette, panel builder, step marker builder, auto-sizing, complexity heuristic |

## Architecture Patterns

### Recommended Project Structure
```
src/maxpat/
    aesthetics.py        # NEW: palette, panel builder, step marker, auto-sizing
    defaults.py          # MODIFIED: add palette constants, panel/comment tier defaults
    patcher.py           # MODIFIED: add styled convenience methods on Patcher
    sizing.py            # MODIFIED: height calc for styled comments
```

### Pattern 1: Comment Styling via Box Attributes
**What:** All three comment tiers use the same maxclass "comment" with different attribute combinations. No separate panel objects needed for headers.
**When to use:** Every styled comment in generated patches.
**Source:** Verified from MAX 9 comment.maxhelp and 761+ bubble comment instances across help patches.

```python
# Section header: 16pt bold, colored text, colored background
def add_section_header(self, text: str, x: float = 0.0, y: float = 0.0) -> Box:
    box = self.add_comment(text, x, y)
    box.fontsize = 16.0
    box.extra_attrs["fontface"] = 1       # bold
    box.extra_attrs["textcolor"] = PALETTE["header_color"]
    box.extra_attrs["bgcolor"] = PALETTE["header_bgcolor"]
    # Recalculate size for larger font
    box.patching_rect[2] = len(text) * 9.5 + 20.0   # wider chars at 16pt
    box.patching_rect[3] = 24.0                       # taller for 16pt
    return box

# Subsection label: 12pt bold, dark gray
def add_subsection(self, text: str, x: float = 0.0, y: float = 0.0) -> Box:
    box = self.add_comment(text, x, y)
    box.extra_attrs["fontface"] = 1       # bold
    box.extra_attrs["textcolor"] = PALETTE["subsection_color"]
    return box

# Inline annotation: 10pt italic, light gray
def add_annotation(self, text: str, x: float = 0.0, y: float = 0.0) -> Box:
    box = self.add_comment(text, x, y)
    box.fontsize = 10.0
    box.extra_attrs["fontface"] = 2       # italic
    box.extra_attrs["textcolor"] = PALETTE["annotation_color"]
    # Recalculate size for smaller font
    box.patching_rect[2] = len(text) * 6.0 + 14.0
    box.patching_rect[3] = 18.0
    return box
```

### Pattern 2: Panel with Gradient Fill (bgfillcolor dict)
**What:** Panel objects use `bgfillcolor` dict for modern gradient fills. The dict structure has `type`, `color`, `color1`, `color2`, `angle`, `proportion`.
**When to use:** Section background panels in generated patches.
**Source:** Verified from 17 panel instances with bgfillcolor in MAX app bundle, plus patcher-level gradient examples.

```python
# Panel with gradient fill, rounded corners, background layer
def add_panel(self, x, y, width, height, gradient=True) -> Box:
    box_id = self._gen_id()
    panel = Box.__new__(Box)
    panel.name = "panel"
    panel.id = box_id
    panel.maxclass = "panel"
    panel.numinlets = 1
    panel.numoutlets = 0
    panel.outlettype = []
    panel.patching_rect = [x, y, width, height]
    panel.fontname = FONT_NAME
    panel.fontsize = FONT_SIZE
    panel.presentation = False
    panel.presentation_rect = None
    panel.text = ""
    panel.args = []
    panel._inner_patcher = None
    panel._saved_object_attributes = None
    panel._bpatcher_attrs = None
    panel.extra_attrs = {
        "background": 1,       # background layer
        "ignoreclick": 1,      # non-interactive
        "border": 0,           # borderless
        "rounded": 7,          # 6-8px range
        "mode": 0,             # solid fill mode for bgfillcolor
    }
    if gradient:
        panel.extra_attrs["bgfillcolor"] = {
            "type": "gradient",
            "color1": PALETTE["panel_fill"],
            "color2": PALETTE["panel_gradient_end"],
            "color": PALETTE["panel_fill"],    # fallback solid
            "angle": 270.0,                     # top-to-bottom
            "proportion": 0.39,
            "autogradient": 0,
        }
    else:
        panel.extra_attrs["bgcolor"] = PALETTE["panel_fill"]
    # Insert at index 0 for correct z-order (behind all other boxes)
    self.boxes.insert(0, panel)
    return panel
```

### Pattern 3: Step Marker using textbutton
**What:** Numbered circle markers using textbutton with high rounded value, amber background, white text.
**When to use:** Tutorial-style patches where step ordering matters.
**Source:** Verified from textbutton.maxhelp -- textbutton supports rounded (float), bgcolor, textcolor, text attributes.

```python
def add_step_marker(self, number: int, x: float, y: float) -> Box:
    box_id = self._gen_id()
    marker = Box.__new__(Box)
    marker.name = "textbutton"
    marker.id = box_id
    marker.maxclass = "textbutton"
    marker.numinlets = 1
    marker.numoutlets = 3
    marker.outlettype = ["", "", "int"]
    marker.patching_rect = [x, y, 24.0, 24.0]  # small circle
    marker.fontname = FONT_NAME
    marker.fontsize = 11.0
    marker.presentation = False
    marker.presentation_rect = None
    marker.text = ""
    marker.args = []
    marker._inner_patcher = None
    marker._saved_object_attributes = None
    marker._bpatcher_attrs = None
    marker.extra_attrs = {
        "background": 1,
        "ignoreclick": 1,
        "rounded": 60.0,      # high rounding -> circle
        "text": str(number),
        "textcolor": [1.0, 1.0, 1.0, 1.0],          # white
        "bgcolor": PALETTE["step_marker_bg"],          # amber/gold
        "fontface": 1,         # bold
        "parameter_enable": 0,
    }
    # Insert at beginning for background layer
    self.boxes.insert(0, marker)
    return marker
```

### Pattern 4: Patcher Canvas Background
**What:** Set editing_bgcolor and/or locked_bgcolor at patcher props level for canvas background color.
**When to use:** Every generated patch that uses the aesthetic system.
**Source:** Verified from MAX 9 tour patch: `editing_bgcolor: [0.333, 0.333, 0.333, 1.0]`.

```python
# In Patcher or aesthetics module
def set_canvas_background(patcher: Patcher, color: list[float] | None = None):
    """Set patcher canvas background color."""
    bg = color or PALETTE["canvas_bg"]
    patcher.props["editing_bgcolor"] = list(bg)
    # locked_bgcolor is optional -- same as editing for consistency
    patcher.props["locked_bgcolor"] = list(bg)
```

### Anti-Patterns to Avoid
- **Creating panel objects behind styled headers:** User explicitly decided against this. Use comment box's own bgcolor/textcolor instead.
- **Using mode: 1 + grad1/grad2 for panel gradients:** Old-style format. Use bgfillcolor dict as specified in CONTEXT.md.
- **Setting proportion >= 1.0:** CONTEXT.md explicitly says "proportion capped below 1.0". Use 0.39 as the standard value (matches MAX's own convention from help patches).
- **Bubble comments on every annotation:** Bubbles are opt-in only, not automatic.
- **Hard-coding colors in individual methods:** All colors must come from the semantic palette dict.

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Gradient math | Custom gradient interpolation | bgfillcolor dict with type "gradient" | MAX renders the gradient natively from color1/color2/angle |
| Z-ordering | Manual index management | boxes.insert(0, panel) + background: 1 | MAX's background layer system handles overlap |
| Bubble arrow rendering | Custom arrow drawing | bubble: 1 + bubbleside attr | Comment box has built-in bubble rendering |
| Font metric calculation | Character width tables per font/size | Approximate char_width * fontsize/12.0 scaling | Exact pixel-perfect sizing not needed; MAX auto-wraps |

## Common Pitfalls

### Pitfall 1: Panel Covers Objects (Z-Order)
**What goes wrong:** Panel added after objects in boxes array appears ON TOP of them, hiding everything.
**Why it happens:** .maxpat renders boxes in array order; later boxes render on top.
**How to avoid:** Insert panels at index 0 in boxes array AND set `"background": 1` attribute.
**Warning signs:** Objects invisible when patch opens in MAX.

### Pitfall 2: bgfillcolor Format Mismatch
**What goes wrong:** Panel renders as solid black or ignores gradient.
**Why it happens:** bgfillcolor dict is missing required keys, or `type` is wrong, or `mode` conflicts.
**How to avoid:** Always include all keys: `type`, `color`, `color1`, `color2`, `angle`, `proportion`, `autogradient`. Set panel `mode: 0` when using bgfillcolor (mode 0 = solid/bgfillcolor mode; mode 1 = old grad1/grad2 mode).
**Warning signs:** Panel appears solid-colored instead of gradient.

### Pitfall 3: Bubble Comment Size
**What goes wrong:** Bubble comment box is too small, text truncated or arrow misplaced.
**Why it happens:** Bubble adds visual padding around the comment text; the patching_rect must account for bubble chrome.
**How to avoid:** Add approximately 17px to width and 5px to height when `bubble: 1` is set (observed from help patches: bubble comments consistently use ~25pt height vs 20pt for non-bubble).
**Warning signs:** Bubble arrow overlaps text or extends past box boundary.

### Pitfall 4: fontface Values
**What goes wrong:** Text appears in wrong style (italic instead of bold).
**Why it happens:** fontface uses bitmask encoding: 0=regular, 1=bold, 2=italic, 3=bold+italic. Easy to confuse.
**How to avoid:** Use named constants: `FONTFACE_REGULAR = 0`, `FONTFACE_BOLD = 1`, `FONTFACE_ITALIC = 2`, `FONTFACE_BOLD_ITALIC = 3`.
**Warning signs:** Comment text style doesn't match expected appearance.

### Pitfall 5: Box.__new__ Bypass Initialization
**What goes wrong:** AttributeError at runtime because a field is missing.
**Why it happens:** Using `Box.__new__(Box)` to bypass DB validation requires manually setting ALL instance fields (name, args, id, maxclass, text, numinlets, numoutlets, outlettype, patching_rect, fontname, fontsize, presentation, presentation_rect, extra_attrs, _inner_patcher, _saved_object_attributes, _bpatcher_attrs).
**How to avoid:** Use a helper function that sets all required fields. Copy the pattern from existing add_subpatcher/add_bpatcher/add_gen methods which already use Box.__new__. Count: 16 fields must be set.
**Warning signs:** AttributeError on box serialization.

### Pitfall 6: bubbleside Direction Mapping
**What goes wrong:** Arrow points wrong direction.
**Why it happens:** bubbleside values are not intuitive: 0=left, 1=top (default), 2=right, 3=bottom. The "side" refers to where the bubble is drawn relative to the arrow point, not where the arrow points.
**How to avoid:** Use named constants: `BUBBLE_LEFT = 0`, `BUBBLE_TOP = 1`, `BUBBLE_RIGHT = 2`, `BUBBLE_BOTTOM = 3`. Default is 1 (top), matching CONTEXT.md's "default bubble direction: top".
**Warning signs:** Bubble arrow points away from target object.

### Pitfall 7: Modifying Box.fontsize Directly vs extra_attrs
**What goes wrong:** fontsize is set but doesn't appear in serialized JSON for comment boxes.
**Why it happens:** `Box.to_dict()` at line 204 emits `d["fontsize"] = self.fontsize` for comment maxclass. But extra_attrs merges AFTER this at line 232, so `extra_attrs["fontsize"]` would override. The safe approach: modify `box.fontsize` directly for font size (it's already emitted), and use `extra_attrs` for everything else (fontface, textcolor, bgcolor, bubble, etc.).
**How to avoid:** For comment boxes, set `box.fontsize` directly. For fontface/textcolor/bgcolor/bubble, use `box.extra_attrs`.
**Warning signs:** Duplicate fontsize keys in JSON or fontsize not taking effect.

## Code Examples

### Verified Panel JSON (from MAX app bundle)
```json
{
    "maxclass": "panel",
    "id": "obj-1",
    "numinlets": 1,
    "numoutlets": 0,
    "patching_rect": [38.0, 193.0, 180.0, 90.0],
    "mode": 0,
    "border": 0,
    "rounded": 7,
    "background": 1,
    "ignoreclick": 1,
    "bgfillcolor": {
        "type": "gradient",
        "color": [0.9, 0.9, 0.92, 1.0],
        "color1": [0.94, 0.94, 0.96, 1.0],
        "color2": [0.88, 0.88, 0.91, 1.0],
        "angle": 270.0,
        "proportion": 0.39,
        "autogradient": 0
    }
}
```
*Source: Composite from verified panel instances in MAX app bundle. The bgfillcolor "gradient" type structure is verified from Device.DeviceParameterMap.maxpat and similar M4L patches at the patcher level.*

### Verified Bubble Comment JSON (from comment.maxhelp)
```json
{
    "maxclass": "comment",
    "id": "obj-23",
    "numinlets": 1,
    "numoutlets": 0,
    "fontname": "Arial",
    "fontsize": 13.0,
    "patching_rect": [210.0, 312.0, 57.0, 25.0],
    "text": "clear",
    "bubble": 1
}
```
*Source: Directly from /Applications/Max.app/.../help/max/comment.maxhelp, obj-23.*

### Verified Bubble Comment with bubbleside (from matrixctrl.maxhelp)
```json
{
    "maxclass": "comment",
    "text": "drag cells up and down to change cell values",
    "fontsize": 13.0,
    "fontname": "Arial",
    "bubble": 1,
    "bubbleside": 0
}
```
*Source: Directly from matrixctrl.maxhelp.*

### Verified Styled Comment with fontface + textcolor (from progress.maxhelp)
```json
{
    "maxclass": "comment",
    "text": "progress",
    "fontsize": 20.871338,
    "fontface": 3,
    "fontname": "Arial",
    "textcolor": [0.93, 0.93, 0.97, 1.0]
}
```
*Source: Directly from progress.maxhelp.*

### Verified Bold Comment (from mtr.maxhelp)
```json
{
    "maxclass": "comment",
    "text": "NOTE:",
    "fontface": 1
}
```
*Source: Directly from mtr.maxhelp. fontface 1 = bold.*

### Verified Textbutton with rounded (from textbutton.maxhelp)
```json
{
    "maxclass": "textbutton",
    "id": "obj-3",
    "numinlets": 1,
    "numoutlets": 3,
    "outlettype": ["", "", "int"],
    "parameter_enable": 0,
    "patching_rect": [57.5, 172.0, 75.0, 75.0],
    "rounded": 100.0
}
```
*Source: Directly from textbutton.maxhelp, obj-3. High rounded value creates circle.*

### Verified Textbutton with colors (from textbutton.maxhelp)
```json
{
    "maxclass": "textbutton",
    "id": "obj-30",
    "numinlets": 1,
    "numoutlets": 3,
    "outlettype": ["", "", "int"],
    "parameter_enable": 0,
    "mode": 1,
    "fontsize": 48.0,
    "fontlink": 1,
    "patching_rect": [226.32, 189.03, 176.08, 61.63],
    "text": "I am off",
    "textcolor": [0.0, 0.8, 0.4, 1.0],
    "bgoncolor": [0.70, 0.17, 0.22, 1.0],
    "texton": "I am on",
    "textoncolor": [0.09, 0.89, 1.0, 1.0]
}
```
*Source: Directly from textbutton.maxhelp, obj-30.*

### Verified Patcher editing_bgcolor (from MAX 9 tour)
```json
{
    "patcher": {
        "editing_bgcolor": [0.333333, 0.333333, 0.333333, 1.0],
        ...
    }
}
```
*Source: Directly from tour_max9_1_welcome.maxpat.*

### Verified Patcher bgfillcolor Gradient (from M4L patches)
```json
{
    "patcher": {
        "bgfillcolor": {
            "angle": 270.0,
            "autogradient": 0,
            "color": [0.290196, 0.309804, 0.301961, 1.0],
            "color1": [0.862745, 0.870588, 0.878431, 1.0],
            "color2": [0.65098, 0.666667, 0.662745, 1.0],
            "proportion": 0.39,
            "type": "gradient"
        },
        ...
    }
}
```
*Source: Directly from Device.DeviceParameterMap.maxpat.*

## Semantic Palette Design

Recommended palette values (Claude's discretion, within cool/neutral range):

```python
# In defaults.py
AESTHETIC_PALETTE = {
    # Comment tiers
    "header_color": [0.20, 0.25, 0.42, 1.0],       # deep slate blue text
    "header_bgcolor": [0.88, 0.90, 0.95, 1.0],      # light blue-gray background
    "subsection_color": [0.30, 0.30, 0.35, 1.0],    # dark gray
    "annotation_color": [0.55, 0.55, 0.60, 1.0],    # light gray
    "warning_color": [0.75, 0.22, 0.17, 1.0],        # muted red for warnings

    # Panel fills
    "panel_fill": [0.94, 0.94, 0.96, 1.0],          # very light cool gray
    "panel_gradient_end": [0.88, 0.89, 0.92, 1.0],  # slightly darker cool gray

    # Canvas
    "canvas_bg": [0.97, 0.97, 0.98, 1.0],           # off-white with blue tint

    # Step markers
    "step_marker_bg": [0.85, 0.65, 0.13, 1.0],      # amber/gold
    "step_marker_text": [1.0, 1.0, 1.0, 1.0],       # white

    # Object emphasis (when explicitly requested)
    "emphasis_loadbang": [0.85, 0.92, 0.85, 1.0],   # pale green
    "emphasis_dac": [0.92, 0.85, 0.85, 1.0],        # pale red
    "emphasis_processor": [0.85, 0.87, 0.95, 1.0],  # pale blue
}
```

## Key JSON Attribute Reference

### fontface bitmask
| Value | Style |
|-------|-------|
| 0 | Regular |
| 1 | Bold |
| 2 | Italic |
| 3 | Bold + Italic |

### bubbleside mapping
| Value | Arrow Direction | Bubble Position |
|-------|----------------|-----------------|
| 0 | Points left | Bubble on right of arrow |
| 1 (default) | Points up | Bubble below arrow |
| 2 | Points right | Bubble on left of arrow |
| 3 | Points down | Bubble above arrow |

### Panel mode
| Value | Behavior |
|-------|----------|
| 0 | Solid fill (uses bgcolor or bgfillcolor) |
| 1 | Gradient fill (old-style: uses grad1/grad2) |

### bgfillcolor dict keys (modern gradient)
| Key | Type | Description |
|-----|------|-------------|
| type | string | "color" for solid, "gradient" for gradient |
| color | [r,g,b,a] | Fallback solid color |
| color1 | [r,g,b,a] | Gradient start color |
| color2 | [r,g,b,a] | Gradient end color |
| angle | float | Gradient angle in degrees (270.0 = top-to-bottom) |
| proportion | float | Gradient midpoint, capped below 1.0 (standard: 0.39) |
| autogradient | int | 0 = use manual colors, 1 = auto |

### Panel background layer attributes
| Attribute | Value | Purpose |
|-----------|-------|---------|
| background | 1 | Render in background layer |
| ignoreclick | 1 | Non-interactive (click-through) |

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| mode: 1 + grad1/grad2 | bgfillcolor dict | MAX 7+ | Both work; bgfillcolor is forward-looking |
| No editing_bgcolor | editing_bgcolor on patcher | MAX 6+ | Allows custom canvas backgrounds |
| No bubble attribute | bubble: 1 on comment | MAX 5+ | Built-in bubble rendering |

**Note:** All approaches are stable and well-established in MAX 9. No deprecation risk.

## Integration Points

### Existing Code Touchpoints

1. **`defaults.py`** -- Add: AESTHETIC_PALETTE dict, fontface constants, bubbleside constants, panel default values, comment tier configs
2. **`patcher.py` Patcher class** -- Add methods: `add_section_header()`, `add_subsection()`, `add_annotation()`, `add_bubble()`, `add_panel()`, `add_step_marker()`, `set_canvas_background()`, `set_object_bgcolor()`
3. **`patcher.py` Box.to_dict()`** -- No changes needed; extra_attrs already merges last (line 232), which handles all styling attributes
4. **`sizing.py`** -- May need to handle larger font sizes for section headers (16pt chars are wider than 12pt)
5. **`maxclass_map.py`** -- No changes; panel and textbutton already in UI_MAXCLASSES

### New Code

1. **`aesthetics.py`** -- Semantic palette access, auto_size_panel() helper, is_complex_patch() heuristic, apply_aesthetic_defaults() for batch styling

### Box.__new__ Field Checklist
When creating panel/textbutton via Box.__new__(Box), all 16 fields must be set:
```
name, args, id, maxclass, text, numinlets, numoutlets, outlettype,
patching_rect, fontname, fontsize, presentation, presentation_rect,
extra_attrs, _inner_patcher, _saved_object_attributes, _bpatcher_attrs
```

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | pytest 9.0.2 |
| Config file | None (uses default discovery) |
| Quick run command | `python3 -m pytest tests/test_aesthetics.py -x` |
| Full suite command | `python3 -m pytest -x` |

### Phase Requirements -> Test Map
| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| CMNT-01 | Section header with fontsize/fontface/textcolor | unit | `python3 -m pytest tests/test_aesthetics.py::TestCommentTiers::test_section_header -x` | Wave 0 |
| CMNT-02 | Bubble comment with bubble/bubbleside attrs | unit | `python3 -m pytest tests/test_aesthetics.py::TestBubbleComments -x` | Wave 0 |
| CMNT-03 | Three-tier hierarchy produces distinct styles | unit | `python3 -m pytest tests/test_aesthetics.py::TestCommentTiers -x` | Wave 0 |
| CMNT-04 | Semantic palette has all required role keys | unit | `python3 -m pytest tests/test_aesthetics.py::TestPalette -x` | Wave 0 |
| PANL-01 | Panel with bgfillcolor, rounded, border, background | unit | `python3 -m pytest tests/test_aesthetics.py::TestPanels::test_panel_attributes -x` | Wave 0 |
| PANL-02 | Panel at index 0 with background:1 ignoreclick:1 | unit | `python3 -m pytest tests/test_aesthetics.py::TestPanels::test_panel_z_order -x` | Wave 0 |
| PANL-03 | Auto-sizing from bounding box + padding | unit | `python3 -m pytest tests/test_aesthetics.py::TestPanels::test_auto_size -x` | Wave 0 |
| PANL-04 | Gradient bgfillcolor dict structure | unit | `python3 -m pytest tests/test_aesthetics.py::TestPanels::test_gradient_fill -x` | Wave 0 |
| PANL-05 | Step marker textbutton with amber bg, rounded=60 | unit | `python3 -m pytest tests/test_aesthetics.py::TestStepMarkers -x` | Wave 0 |
| PTCH-01 | editing_bgcolor/locked_bgcolor in patcher props | unit | `python3 -m pytest tests/test_aesthetics.py::TestPatcherStyling::test_canvas_background -x` | Wave 0 |
| PTCH-02 | Object bgcolor via extra_attrs | unit | `python3 -m pytest tests/test_aesthetics.py::TestPatcherStyling::test_object_bgcolor -x` | Wave 0 |

### Sampling Rate
- **Per task commit:** `python3 -m pytest tests/test_aesthetics.py -x`
- **Per wave merge:** `python3 -m pytest -x`
- **Phase gate:** Full suite green (778 existing + new aesthetic tests) before verify

### Wave 0 Gaps
- [ ] `tests/test_aesthetics.py` -- covers CMNT-01..04, PANL-01..05, PTCH-01..02
- [ ] Framework install: None needed (pytest 9.0.2 already installed)

## Open Questions

1. **bgfillcolor gradient on panel objects specifically**
   - What we know: bgfillcolor dict with type "gradient" is verified working at the patcher level (Device.DeviceParameterMap.maxpat). Panel has a documented bgfillcolor attribute. The old-style mode:1/grad1/grad2 works for panel gradients (116 instances). 17 panel instances use bgfillcolor dict but with type "color" not "gradient".
   - What's unclear: Whether type "gradient" on panel's bgfillcolor specifically renders a gradient, since no existing patches in the MAX bundle use that exact combination on panels. The attribute exists, the format exists, but the specific combination panel + bgfillcolor + type:gradient is unverified at runtime.
   - Recommendation: Implement with bgfillcolor type "gradient" as CONTEXT.md specifies. If visual testing in MAX shows it doesn't render gradient, fall back to mode:1/grad1/grad2. Both approaches are trivially swappable since they're just different JSON attributes. Add a comment in the code noting this is the forward-looking format.

2. **Comment box bgcolor rendering**
   - What we know: The comment object database entry lists bgcolor as an attribute. CONTEXT.md says "use the comment box's built-in styling capabilities fully (bgcolor, textcolor, fontface, fontsize)".
   - What's unclear: How comment bgcolor renders visually -- does it fill behind the text only, or does it create a colored rectangle behind the entire patching_rect area? This affects whether section headers look like "highlighted text" or "colored labels".
   - Recommendation: Implement as specified and verify in MAX. The visual result is acceptable either way for section headers.

## Sources

### Primary (HIGH confidence)
- `/Applications/Max.app/.../help/max/comment.maxhelp` -- bubble comment structure, fontface values, textcolor
- `/Applications/Max.app/.../help/max/panel.maxhelp` -- 16 panel instances with mode/grad/rounded/shadow/border
- `/Applications/Max.app/.../help/max/textbutton.maxhelp` -- 13 textbutton instances with rounded/bgcolor/textcolor
- `/Applications/Max.app/.../docs/refpages/max-ref/panel.maxref.xml` -- panel attribute documentation (bgfillcolor, rounded, mode, border)
- `/Applications/Max.app/.../tours/max_9_tour/tour_max9_1_welcome.maxpat` -- editing_bgcolor at patcher level
- `/Applications/Max.app/.../packages/Max for Live/.../Device.DeviceParameterMap.maxpat` -- bgfillcolor gradient dict format

### Secondary (MEDIUM confidence)
- Cross-referenced analysis of 4,798 panel objects across MAX app bundle for usage patterns
- Cross-referenced analysis of 761+ bubble comments across help patches for bubbleside value distribution

### Tertiary (LOW confidence)
- bgfillcolor type "gradient" on panel object specifically (documented attribute + verified format, but no existing instance combining both found in bundle)

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH - pure Python, no external deps, existing project patterns
- Architecture: HIGH - verified JSON structures from MAX app bundle, existing codebase patterns clear
- Pitfalls: HIGH - verified from real help patch analysis, existing Box.__new__ patterns in codebase
- Palette colors: MEDIUM - discretionary values within user-specified range, visual testing needed
- Panel gradient format: MEDIUM - bgfillcolor attribute documented on panel, gradient type verified at patcher level, but specific combination untested at runtime

**Research date:** 2026-03-13
**Valid until:** 2026-06-13 (stable domain, MAX 9 JSON format well-established)
