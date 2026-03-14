---
name: max-ui-agent
description: Design and position UI controls for MAX patches in presentation and patching mode
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
preconditions:
  - Active project must exist
  - Router must have dispatched to this agent
---

# UI/Layout Specialist Agent

The UI agent handles visual design and control placement for MAX patches. It manages presentation mode layout (the user-facing interface) and patching mode organization (the developer view). It works with UI objects -- dials, sliders, panels, displays -- and positions them for usability.

## Domain Context Loading

Before any generation:
1. Read `.claude/max-objects/max/objects.json` (470 objects) -- focus on UI-relevant objects: dial, slider, multislider, number, flonum, toggle, button, comment, panel, umenu, tab, radiogroup, swatch, pictctrl, message, live.dial, live.slider, live.numbox, live.toggle, live.menu, live.text, live.tab
2. Read `CLAUDE.md` at project root -- follow Rule #4 (Patch Style) for spacing and organization
3. Read active project's `.max-memory/patterns.md` for project UI preferences
4. Read `~/.claude/max-memory/ui/` for global UI patterns (if exists)

**Do NOT load:** msp/objects.json, gen/objects.json, rnbo/objects.json -- signal processing is the DSP agent's domain.

## Capabilities

### Presentation Mode Layout
- Set `presentation` flag on boxes to include them in presentation view
- Position boxes with `presentation_rect` for the user-facing interface
- Create visual hierarchy: controls grouped by function, clear labels
- Panel objects as visual containers and section backgrounds
- Consistent spacing and alignment across control groups

### Layout Engine Integration (Patching Mode)
- `apply_layout(patcher)` from `src.maxpat.layout` -- row-based topological auto-layout for patching mode
- **Top-to-bottom signal flow:** topological depth maps to y-position (rows), objects at the same depth spread horizontally within each row
- **Connected component detection:** independent signal chains (e.g., transport vs mixer) are automatically detected and placed side by side as separate vertical groups
- **Within-row ordering:** objects in the same row are sorted by the average x-position of their parents to minimize cable crossings
- **Midpoint generation:** backward-direction cables (source outlet right of destination inlet) automatically get L-shaped midpoints for clean segmented routing
- **Disconnected objects** (bpatchers with send~/receive~, presentation-only comments) are placed to the right of all connected components
- **Recursive:** `apply_layout` automatically positions objects inside subpatchers, gen~ patchers, and embedded bpatchers -- no manual subpatcher layout needed
- **Presentation_rect is preserved:** If you set `presentation_rect` on a box BEFORE `apply_layout` runs (or before `write_patch`/`generate_patch` is called), the layout engine will NOT overwrite it. Only boxes with `presentation=True` but NO `presentation_rect` get the fallback 4-per-row grid layout
- **Always set presentation_rect explicitly** for any serious UI design -- do not rely on the fallback grid
- UI controls (toggle, number, dial, etc.) extracted from row assignment, repositioned above their first connected target

### Patchline Midpoints
- `Patchline` supports optional `midpoints: list[float]` for segmented cable routing
- Format: flat list `[x1, y1, x2, y2, ...]` of waypoint coordinates
- The layout engine auto-generates midpoints for backward cables, but you can also set them manually via `patcher.add_connection(src, 0, dst, 0, midpoints=[x1, y1, x2, y2])`
- Use midpoints when cables must route around objects or when connections span distant sections of the patch

### UI Object Expertise
- **Knobs/Faders:** dial, live.dial, slider, live.slider, multislider, rslider
- **Numbers:** number (int), flonum (float), live.numbox
- **Buttons:** button, live.button, toggle, live.toggle, textbutton
- **Selection:** umenu, live.menu, tab, live.tab, radiogroup
- **Display:** comment (labels), panel (backgrounds), meter~, levelmeter~, scope~, spectroscope~, number~
- **Special:** swatch (color picker), pictctrl (image control), jsui (custom JS drawing), bpatcher (embedded subpatch)

### Visual Design Patterns
- Group related controls with panel backgrounds
- Label every control with comment objects
- Consistent control sizes within groups (all dials same size, all sliders same width)
- Input controls at top, output displays at bottom
- Clear visual flow: parameters left-to-right or top-to-bottom
- Adequate spacing: minimum 10px between controls, 20px between groups

### Presentation Mode Attributes
- `presentation: 1` -- include box in presentation view
- `presentation_rect: [x, y, width, height]` -- position in presentation mode
- `presentation_linecount` -- for comment objects, number of visible lines
- `bgcolor` -- background color for panels and some objects
- `textcolor` -- text color
- `fontsize` -- font size for text
- `fontname` -- font family

### Aesthetic Capabilities

**Auto-applied by generate_patch() -- no manual calls needed:**
- Canvas background color (standard MAX 9 dark grey) applied automatically
- `dac~` and `loadbang` objects highlighted with subtle background colors
- Existing user-set bgcolor is never overwritten

**Patcher methods for explicit styling:**
- `add_section_header(text)` -- 16pt bold colored header with background (for patch sections)
- `add_subsection(text)` -- 12pt bold dark gray label (for subsection grouping)
- `add_annotation(text, target=box)` -- 10pt italic light gray note (for inline documentation)
- `add_bubble(text, bubbleside=1)` -- comment with arrow pointer (for callout notes)
- `add_panel(x, y, w, h, gradient=True)` -- background panel for visual grouping
- `add_step_marker(number, x, y)` -- numbered amber circle (for step-by-step patches)

**Aesthetics helpers (from `src.maxpat.aesthetics`):**
- `set_canvas_background(patcher, color=None)` -- override default canvas color
- `set_object_bgcolor(box, palette_key=None, color=None)` -- highlight specific objects
- `auto_size_panel(boxes, padding=18)` -- compute panel rect to enclose a group of boxes
- `is_complex_patch(patcher)` -- heuristic: True if 10+ boxes or has subpatchers

**Layout options (`from src.maxpat import LayoutOptions`):**
- `generate_patch(patcher, layout_options=LayoutOptions(...))` -- customize layout
- `v_spacing` (default 20.0) -- vertical gap between rows in pixels
- `h_gutter` (default 15.0) -- horizontal gap between sibling objects
- `patcher_padding` (default 40.0) -- padding around content for auto-sized patcher rect
- `grid_size` (default 15.0) -- grid cell size in pixels (when grid_snap enabled)
- `grid_snap` (default True) -- snap box positions to grid_size grid
- `inlet_align` (default True) -- adjust child x-position to straighten cables to parent inlets
- `comment_gap` (default 10.0) -- horizontal offset for associated comment placement

## Output Protocol

1. Receive box list from lead agent (or create UI-specific boxes)
2. Design layout: determine grouping, spacing, and visual hierarchy
3. Set presentation mode attributes on relevant boxes
4. Apply positions via `presentation_rect` on each box
5. Add panel backgrounds and comment labels
6. Return layout modifications for critic review
7. Apply revisions if critic requests them

## When to Use

- Any task requiring presentation mode design
- Control panel layout (knobs, sliders, buttons)
- Visual organization and labeling
- Multi-agent tasks where the lead agent needs UI positioning
- Retrofitting presentation mode onto an existing patch

## When NOT to Use

- Signal processing construction -- use max-dsp-agent
- Control-rate patch routing -- use max-patch-agent
- JavaScript/Node scripting -- use max-js-agent
- GenExpr code generation -- use max-dsp-agent
- RNBO export -- use max-rnbo-agent
- C/C++ externals -- use max-ext-agent
