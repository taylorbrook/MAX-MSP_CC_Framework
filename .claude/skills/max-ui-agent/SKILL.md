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
1. Read `CLAUDE.md` at project root -- follow Rule #4 (Patch Style) for spacing and organization
2. Use `ObjectDatabase` from `src.maxpat.db_lookup` for UI object lookups -- focus on UI-relevant objects: dial, slider, multislider, number, flonum, toggle, button, comment, panel, umenu, tab, radiogroup, swatch, pictctrl, message, live.dial, live.slider, live.numbox, live.toggle, live.menu, live.text, live.tab

**Domain focus:** UI objects and presentation layout. Signal processing is handled by the DSP agent.

## Capabilities

### Presentation Mode Layout
- Set `presentation` flag on boxes to include them in presentation view
- Position boxes with `presentation_rect` for the user-facing interface
- Create visual hierarchy: controls grouped by function, clear labels
- Panel objects as visual containers and section backgrounds
- Consistent spacing and alignment across control groups

### Layout Engine Integration (Patching Mode)
- `finalize_patch(patcher, is_new=True)` -- single-call layout cleanup: styling, layout, comments, midpoints (new); midpoints + comments (edit)
- `apply_layout(patcher)` from `src.maxpat.layout` -- row-based topological auto-layout for patching mode (called internally by finalize_patch)
- **Top-to-bottom signal flow:** topological depth maps to y-position (rows), objects at the same depth spread horizontally within each row
- **Connected component detection:** independent signal chains (e.g., transport vs mixer) are automatically detected and placed side by side as separate vertical groups
- **Within-row ordering:** objects in the same row are sorted by the average x-position of their parents to minimize cable crossings
- **Midpoint generation:** backward-direction cables (source outlet right of destination inlet) automatically get L-shaped midpoints for clean segmented routing
- **Disconnected objects** (bpatchers with send~/receive~, presentation-only comments) are placed to the right of all connected components
- **Recursive:** `apply_layout` automatically positions objects inside subpatchers, gen~ patchers, and embedded bpatchers -- no manual subpatcher layout needed
- **Presentation_rect is preserved:** If you set `presentation_rect` on a box BEFORE `apply_layout` runs, the layout engine will NOT overwrite it. Only boxes with `presentation=True` but NO `presentation_rect` get the fallback 4-per-row grid layout
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

### M4L Presentation Mode and Controls

When designing UI for M4L devices:

- **Presentation mode required:** M4L devices must set openinpresentation=1 on the top-level patcher. All user-facing controls need presentation=1 and presentation_rect attributes.
- **169px height constraint:** Ableton's device view is 169px tall. ALL presentation-mode controls must fit within this height. Controls placed below 169px are clipped and invisible.
- **devicewidth:** Set on the patcher (not rect[2]). Default is 300px. This controls the device width in Ableton's device chain.
- **live.* controls:** Use live.dial, live.slider, live.numbox, live.toggle, live.menu, live.tab, live.text instead of standard MAX UI objects for Ableton integration.
- **parameter_enable=1 required:** Every live.* UI control MUST have parameter_enable=1 in its box attributes and a complete saved_attribute_attributes block:
  ```json
  {
    "saved_attribute_attributes": {
      "valueof": {
        "parameter_longname": "Unique Name",
        "parameter_shortname": "8CharMax",
        "parameter_type": 1,
        "parameter_unitstyle": 0,
        "parameter_modmode": 0
      }
    }
  }
  ```
  parameter_type: 0=INT, 1=FLOAT, 2=ENUM. parameter_unitstyle: 0=INT, 1=FLOAT, 2=TIME(ms), 3=HERTZ, 4=DECIBEL, 5=PERCENT. See src/maxpat/m4l_constants.py for all values.
- **parameter_longname must be unique** across the entire device. Duplicate longnames cause Ableton to silently merge parameters.
- **parameter_shortname max 8 chars:** Displayed on Push controller. Truncate or abbreviate.

> **Shared Capabilities:** See `.claude/skills/references/shared-capabilities.md` for Assistance Comments, Z-Order Manipulation, Aesthetic Capabilities, Layout Options, Editing Functions, and Edit Workflow reference.

## Editing Existing Patches (via /max-iterate)

**Domain focus:** Edit presentation mode layouts, control positioning, bpatcher configurations.

## Output Protocol (New Patches)

1. Receive box list from lead agent (or create UI-specific boxes)
2. Design layout: determine grouping, spacing, and visual hierarchy
3. Set presentation mode attributes on relevant boxes
4. Apply positions via `presentation_rect` on each box
5. Add panel backgrounds and comment labels
6. Return layout modifications for critic review
7. Apply revisions if critic requests them

## Output Protocol (Edited Patches)

1. Load and analyze existing patch via `read_patch()` and `patcher.analyze()`
2. Make surgical edits or section rebuild using find/modify/replace/insert/remove
3. Finalize patch: `finalize_patch(patcher, is_new=False)` -- regenerates cable midpoints and populates assistance comments without repositioning existing objects
4. Validate via `validate_patch(patcher)`
5. Return for critic review
6. Save via `save_patch_roundtrip()`

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
