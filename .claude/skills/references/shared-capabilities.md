# Shared Agent Capabilities

> Referenced by specialist agent SKILL.md files. Load this file alongside SKILL.md for full capability context.
> Path: `.claude/skills/references/shared-capabilities.md`

## Assistance Comments on Inlets/Outlets

- When calling `add_subpatcher()`, ALWAYS provide `inlet_comments` and `outlet_comments` with descriptive labels
- Example: `p.add_subpatcher("audio_proc", inlets=2, outlets=1, inlet_comments=["Audio Input Left", "Audio Input Right"], outlet_comments=["Processed Output"])`
- If you forget or cannot determine comments at creation time, call `patcher.populate_assistance_comments()` after building all connections -- it auto-infers from connection context
- Comments appear as mouseover tooltips in MAX when hovering over the parent object's inlets/outlets
- **Direct JSON edits:** When editing .maxpat JSON directly (not via the Python API), you MUST manually include a `"comment"` attribute on any inlet or outlet box dictionary being added or modified. Example: `{"maxclass": "inlet", "comment": "Audio Input Left", ...}`. The auto-populate method only works via the Patcher API, so direct JSON manipulation requires explicit comment attributes.

## Aesthetic Capabilities

**Aesthetic auto-styling (call explicitly for new patches):**
- `from src.maxpat import _apply_auto_styling; _apply_auto_styling(patcher)` -- sets canvas background, highlights dac~/loadbang
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

## Layout Options

`from src.maxpat import LayoutOptions`

- `apply_layout(patcher, layout_options=LayoutOptions(...))` -- customize layout
- `v_spacing` (default 20.0) -- vertical gap between rows in pixels
- `h_gutter` (default 15.0) -- horizontal gap between sibling objects
- `patcher_padding` (default 40.0) -- padding around content for auto-sized patcher rect
- `grid_size` (default 15.0) -- grid cell size in pixels (when grid_snap enabled)
- `grid_snap` (default True) -- snap box positions to grid_size grid
- `inlet_align` (default True) -- adjust child x-position to straighten cables to parent inlets
- `comment_gap` (default 10.0) -- horizontal offset for associated comment placement

## Editing Functions

- `read_patch(path)` -- load .maxpat into (Patcher, original_text) tuple
- `patcher.analyze()` -- structured 7-facet summary of patch contents
- `patcher.find_box(name=..., maxclass=..., text=...)` -- search for a single object
- `patcher.find_boxes(name=..., maxclass=..., text=...)` -- search for multiple objects
- `patcher.modify_box(box, args=..., position=..., color=...)` -- in-place attribute editing
- `patcher.insert_into_connection(src, dst, new_box)` -- insert object between connected pair
- `patcher.replace_box(box, new_name, new_args)` -- swap object type, remap connections
- `patcher.remove_box(box)` -- remove object and clean up connections
- `patcher.connected_components()` -- identify groups for section rebuild scope
- `save_patch_roundtrip(patcher.to_dict(), path, original_text)` -- save preserving positions

## Edit Workflow

1. Load patch: `patcher, original_text = read_patch(path)`
2. Analyze: `summary = patcher.analyze()`
3. Find targets: `box = patcher.find_box(name="target_object")`
4. Make changes: `result = patcher.modify_box(box, args=["new_value"])`
5. Validate: `results = validate_patch(patcher)`
6. Save: `save_patch_roundtrip(patcher.to_dict(), path, original_text)`
