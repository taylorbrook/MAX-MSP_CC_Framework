# Shared Agent Capabilities

> Referenced by specialist agent SKILL.md files. Load this file alongside SKILL.md for full capability context.
> Path: `.claude/skills/references/shared-capabilities.md`

## Assistance Comments on Inlets/Outlets

- When calling `add_subpatcher()`, ALWAYS provide `inlet_comments` and `outlet_comments` with descriptive labels
- Example: `p.add_subpatcher("audio_proc", inlets=2, outlets=1, inlet_comments=["Audio Input Left", "Audio Input Right"], outlet_comments=["Processed Output"])`
- If you forget or cannot determine comments at creation time, call `patcher.populate_assistance_comments()` after building all connections -- it auto-infers from connection context
- Comments appear as mouseover tooltips in MAX when hovering over the parent object's inlets/outlets
- **Direct JSON edits:** When editing .maxpat JSON directly (not via the Python API), you MUST manually include a `"comment"` attribute on any inlet or outlet box dictionary being added or modified. Example: `{"maxclass": "inlet", "comment": "Audio Input Left", ...}`. The auto-populate method only works via the Patcher API, so direct JSON manipulation requires explicit comment attributes.

## Patch Finalization

- `finalize_patch(patcher, is_new=True)` -- single-call layout cleanup hook. For new patches (`is_new=True`): applies auto-styling, layout, assistance comments, midpoints. For edited patches (`is_new=False`): regenerates midpoints and populates assistance comments without moving objects.
- Import from `src.maxpat`: `from src.maxpat import finalize_patch`
- Replaces manual `_apply_auto_styling()` + `apply_layout()` + `populate_assistance_comments()` calls

## Z-Order Manipulation

In `.maxpat` files, z-order is implicit: objects **earlier** in the `boxes` array render **on top** (index 0 = topmost).

**Patcher methods:**
- `patcher.bring_to_front(box)` -- move box to index 0 (renders on top of everything)
- `patcher.send_to_back(box)` -- move box to end of array (renders behind everything)
- `patcher.set_z_index(box, index)` -- place box at specific array position (0 = front)

**Overlay readout pattern** (flonum/number displayed on top of dial/slider):
1. Create the interactive control (dial, slider, etc.)
2. Create the readout (flonum, number)
3. Call `patcher.bring_to_front(readout)` to move it to index 0 (renders on top of dial)
4. Set `extra_attrs["ignoreclick"] = 1` on the readout so mouse events pass through (omit for editable readouts)
5. Position readout overlapping the control

**Background elements** (panels, markers) use `background=1` attribute -- `add_panel()` and `add_step_marker()` set this automatically to force behind all objects regardless of array position.

## Control-Rate Fan-Out Rule (MUST)

When a control-rate outlet connects to 2+ destinations, you **MUST** use a `trigger` (t) object. Direct multi-connect from one outlet to multiple inlets is **NEVER** acceptable for control-rate connections.

**Signal-rate exemption:** MSP signal (~) fan-out is safe and does NOT require trigger. All signal inlets process simultaneously at audio rate, so execution order is not a concern for signal connections.

### Before/After Example

**WRONG -- direct fan-out (undefined execution order):**
```
[button]
  |  \
  |   \
  v    v
[counter] [toggle]
```
The outlet of button connects to both counter inlet 0 and toggle inlet 0. Execution order is undefined -- MAX may fire them in any order.

**RIGHT -- trigger for explicit ordering:**
```
[button]
  |
  v
[t b b]
  |   \
  v    v
[counter] [toggle]
```
trigger fires right-to-left: toggle gets bang first, then counter. Order is explicit and predictable.

### Enforcement

The structure critic (`src/maxpat/critics/structure_critic.py`) detects fan-out without trigger and flags it. Agents must not produce patterns that trigger this finding.

**This applies to ALL control-rate fan-out, even when execution order "does not matter." Always use trigger -- no exceptions for control-rate.**

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

## Version Comment

- `from src.maxpat.project import update_version_comment`
- `update_version_comment(patcher, version_string)` -- adds or updates a `vX.Y.Z` comment in top-right of patch
- Existing version comments are updated in place (no duplicates)
- Called automatically by `/max-iterate` after version bump, before save

## Patch Safety -- Auto-Commit and Isolation

Every `save_patch_roundtrip()`, `write_gendsp()`, and `write_js()` call automatically commits the saved file to git via `auto_commit_patch()`. This prevents work loss from stash operations, branch switches, or concurrent Claude instances.

### Rules

1. **Never use `git stash`** during patch work. Stash operations have caused orphaned work in the past (3 stashes with significant patch changes were found abandoned). If you need to switch context, commit first.
2. **Commit scope isolation** -- `auto_commit_patch()` only stages files within the specific project directory. This allows multiple Claude instances to work on different patches simultaneously without conflicts.
3. **Version entries track files** -- `bump_version()` accepts `files_changed` to record which files were modified in each version entry.
4. **Manual commit for multi-file saves** -- if a build/iterate produces multiple files saved via separate calls, run one explicit `auto_commit_patch()` at the end with all file paths to create a single clean commit (the per-file auto-commits are fine too, just noisier).

### Multi-Instance Safety

Multiple Claude instances can work on different patches concurrently because:
- Each instance commits only files under its active project's directory
- `auto_commit_patch()` uses `git add {specific files}`, not `git add .`
- No stash/merge/rebase operations are used during patch work
- If a merge conflict occurs (unlikely with project isolation), the instance should stop and alert the user rather than attempting resolution
