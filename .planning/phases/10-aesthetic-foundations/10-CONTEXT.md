# Phase 10: Aesthetic Foundations - Context

**Gathered:** 2026-03-13
**Status:** Ready for planning

<domain>
## Phase Boundary

Generated patches include professional visual styling -- styled section comments, background panels, bubble annotations, patcher canvas colors, and step markers -- so patches look authored rather than machine-generated. This phase builds the styling primitives and API; Phase 12 wires them into the generation pipeline.

</domain>

<decisions>
## Implementation Decisions

### Comment styling tiers
- Three distinct tiers with bold contrast: section headers, subsection labels, inline annotations
- Section headers: 16pt bold + color, with background color and text color using comment box's own styling attributes (bgcolor, textcolor, fontface, fontsize)
- Subsection labels: 12pt bold, dark gray
- Inline annotations: 10pt italic, light gray
- No separate panel objects behind headers -- use the comment box's built-in styling capabilities fully
- Bubble comments are opt-in only, not automatic -- agents/users explicitly request them for specific objects
- Default bubble direction: top (arrow points down), keeping vertical flow clean

### Panel design
- Gradient fills by default -- subtle depth on every panel (bgfillcolor dict with type: "gradient", color1, color2, angle)
- Auto-sizing from object groups: compute bounding box of grouped objects + configurable padding (15-20px)
- Borderless -- no visible border, fill contrast against canvas defines the region
- Rounded corners (6-8px radius) for modern look matching MAX 9 UI
- Panels inserted at index 0 in boxes array with background: 1 and ignoreclick: 1 for correct z-order

### Color palette
- One semantic palette dict with named roles: header_color, annotation_color, panel_fill, panel_gradient_end, canvas_bg, warning_color
- Cool/neutral temperature: blues, grays, slate tones -- professional, matching MAX 9's default UI
- Patcher canvas background: slight off-white tint (e.g., [0.97, 0.97, 0.98, 1.0]) -- subtle enough to feel intentional vs. default white
- No per-object background coloring by default -- only when explicitly requested by user/agent
- All elements draw from the same palette for visual consistency

### Step markers
- Auto-generated on complex patches (Claude determines complexity heuristic)
- Amber/gold textbutton circles: amber background, white number, rounded=60, background layer
- Positioned at top-left of section panel, slightly overlapping the edge
- Opt-in for simple patches, automatic for complex ones

### Claude's Discretion
- Exact color values for the semantic palette (within cool/neutral range)
- Complexity heuristic for auto step markers (signal stages, object count, subpatcher presence, or combination)
- Gradient angle and proportion values for default panels
- Corner radius exact value (within 6-8px range)
- Auto-size padding exact value (within 15-20px range)
- Internal API design (helper functions, class structure, method signatures)

</decisions>

<specifics>
## Specific Ideas

- Use comment box's own styling attributes fully (bgcolor, textcolor, fontface, fontsize) rather than creating separate panel objects for styled headers
- Gradient panels should be subtle -- light to slightly lighter, not dramatic color shifts
- The semantic palette should produce patches that feel "authored by a person who cares about presentation" without being flashy
- Step markers at top-left of panels create a clean visual flow: number -> header -> content

</specifics>

<code_context>
## Existing Code Insights

### Reusable Assets
- `Box.extra_attrs` dict: Main extension point for all styling -- textcolor, fontface, bgcolor, bubble, bubbleside all inject via this mechanism
- `Box.to_dict()` (patcher.py:232): Merges extra_attrs last, so styling attributes cleanly override defaults
- `Patcher.add_comment()` (patcher.py:296): Creates comment boxes with text/fontname/fontsize -- extend this for styled variants
- `Patcher.props` (deep-copied from DEFAULT_PATCHER_PROPS): editing_bgcolor and locked_bgcolor go here for canvas background
- `defaults.py`: Central location for constants -- palette and styling defaults belong here

### Established Patterns
- Box creation pattern: `Box.__init__` handles sizing, I/O, and font; extra_attrs handles everything else
- Patcher serialization: `Patcher.to_dict()` deep-copies props, appends boxes/lines -- no filtering or transformation
- Gen~ already sets bgcolor via props: `"bgcolor": list(GEN_PATCHER_BGCOLOR)` in patcher.py:580
- comment maxclass serialization includes text, fontname, fontsize (patcher.py:201-205)

### Integration Points
- `Patcher.add_comment()` -- entry point for styled comment variants (add_section_header, add_annotation, etc.)
- `Patcher.props` dict -- patcher-level canvas colors (editing_bgcolor, locked_bgcolor)
- `defaults.py` -- palette constants and styling defaults
- Panel is a new box type (maxclass: "panel") not currently generated -- needs new add_panel() method on Patcher
- textbutton for step markers is a UI object -- needs add_step_marker() method

</code_context>

<deferred>
## Deferred Ideas

None -- discussion stayed within phase scope

</deferred>

---

*Phase: 10-aesthetic-foundations*
*Context gathered: 2026-03-13*
