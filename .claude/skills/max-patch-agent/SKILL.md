---
name: max-patch-agent
description: Generate MAX patches with control flow, message routing, subpatcher organization, and MIDI handling
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

# Patch Generation Specialist

The Patch agent generates MAX/MSP .maxpat files focused on control-rate operations: object routing, message passing, subpatcher organization, MIDI handling, and data management.

## Domain Context Loading

Before any generation:
1. Read `.claude/max-objects/max/objects.json` (470 Max control/data/UI objects)
2. Read `CLAUDE.md` at project root -- follow all 4 rules and patch style guidelines
3. Read `.claude/max-objects/aliases.json` for shortcut resolution
4. Read `.claude/max-objects/relationships.json` for common object pairings
5. Read `.claude/max-objects/pd-blocklist.json` to avoid PD object confusion
6. Read active project's `.max-memory/patterns.md` for project patterns
7. Read `~/.claude/max-memory/patch/` for global patch patterns (if exists)

**Do NOT load:** msp/objects.json, gen/objects.json, rnbo/objects.json -- those are other agents' domains.

## Capabilities

### Patch Construction
- Create `Patcher` instances with boxes and connections via `src.maxpat.patcher`
- Use `Box` constructor for all standard objects (validates against ObjectDatabase)
- Use `Box.__new__()` bypass for structural objects: subpatchers, bpatcher
- Connect boxes with `Patcher.add_connection(src_box, src_outlet, dst_box, dst_inlet)`

### Key Functions
- `Patcher()` -- create a new patch
- `Box(name, args, db)` -- create a validated box
- `Patcher.add_box(box)` -- add box to patch
- `Patcher.add_connection(src_box, src_outlet, dst_box, dst_inlet)` -- connect boxes
- `Patcher.add_subpatcher(name)` -- add a subpatcher
- `_apply_auto_styling(patcher)` -- apply canvas background and object highlights
- `apply_layout(patcher, layout_options=None)` -- row-based topological layout positioning (accepts LayoutOptions)
- `validate_patch(patcher.to_dict(), db=patcher.db)` -- run four-layer validation pipeline
- `save_patch_roundtrip(patcher.to_dict(), path)` -- write .maxpat to disk
- `Patcher.add_comment(text, x, y)` -- add a comment box (for inline annotations, critic notes)
- `Patcher.add_message(text, x, y)` -- add a message box (for triggering messages, storing values)
- `Patcher.add_node_script(filename, code=None, num_outlets=2, x, y)` -- add a node.script box for Node for Max (returns tuple of Box and code string)
- `Patcher.add_js(filename, code=None, num_inlets=1, num_outlets=1, x, y)` -- add a js object box for V8 JavaScript (returns tuple of Box and code string)

### Object Expertise
- Control flow: trigger, gate, switch, select, route, if, expr
- Data: pack, unpack, zl, coll, dict, table, pattr, preset
- MIDI: notein, noteout, ctlin, ctlout, makenote, stripnote, borax
- Timing: metro, counter, timer, delay, pipe, buddy, thresh
- Communication: send/receive, forward, pattr, pattrstorage
- Organization: subpatcher, bpatcher, abstraction references

### Bpatcher Argument Substitution
- `#N` tokens in bpatcher subpatches must be **standalone** (space-delimited), never embedded in compound strings
- WRONG: `buffer~ slot-#1` -- compound substitution fails silently in MAX
- RIGHT: `buffer~ #1` with bpatcher arg `"slot-1"` -- standalone token works correctly
- When multiple distinct names are needed, use separate args (`#1`, `#2`, etc.)
- Example args: `["slot-1", "slot-1-out"]` where `#1` = buffer name, `#2` = send name
- See CLAUDE.md "Bpatcher and Abstraction Arguments" section for full details

### Pattern Application
- Top-to-bottom signal flow (CLAUDE.md Rule #4)
- Explicit `trigger` objects for fan-out (never multi-connect from one outlet)
- Cold inlets first, hot inlet last (CLAUDE.md Rule #3)
- Named send/receive for long-distance connections
- Subpatcher organization for complex logic
- Comment objects on non-obvious connections

### Aesthetic Capabilities

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

**Layout options (`from src.maxpat import LayoutOptions`):**
- `apply_layout(patcher, layout_options=LayoutOptions(...))` -- customize layout
- `v_spacing` (default 20.0) -- vertical gap between rows in pixels
- `h_gutter` (default 15.0) -- horizontal gap between sibling objects
- `patcher_padding` (default 40.0) -- padding around content for auto-sized patcher rect
- `grid_size` (default 15.0) -- grid cell size in pixels (when grid_snap enabled)
- `grid_snap` (default True) -- snap box positions to grid_size grid
- `inlet_align` (default True) -- adjust child x-position to straighten cables to parent inlets
- `comment_gap` (default 10.0) -- horizontal offset for associated comment placement

## Editing Existing Patches (via /max-iterate)

### Editing Functions
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

### Edit Workflow
1. Load patch: `patcher, original_text = read_patch(path)`
2. Analyze: `summary = patcher.analyze()`
3. Find targets: `box = patcher.find_box(name="route")`
4. Make changes: `result = patcher.modify_box(box, args=["foo", "bar"])`
5. Validate: `results = validate_patch(patcher)`
6. Save: `save_patch_roundtrip(patcher.to_dict(), path, original_text)`

**Domain focus:** Edit control flow routing, message handling, subpatcher organization.

## Output Protocol (New Patches)

1. Create Patcher and build patch structure
2. Apply styling and layout: `_apply_auto_styling(patcher)`, `apply_layout(patcher)`
3. Serialize and validate: `patch_dict = patcher.to_dict()`, `results = validate_patch(patch_dict, db=patcher.db)`
4. Return `(patch_dict, results)` tuple for critic review
5. Apply revisions if critic requests them
6. Write final output via `save_patch_roundtrip(patch_dict, path)` to project's `generated/` directory

## Output Protocol (Edited Patches)

1. Load and analyze existing patch via `read_patch()` and `patcher.analyze()`
2. Make surgical edits or section rebuild using find/modify/replace/insert/remove
3. Validate via `validate_patch(patcher)`
4. Return for critic review
5. Save via `save_patch_roundtrip()` -- never `apply_layout()` on loaded patches

## When to Use

- Pure control-rate patches (sequencers, MIDI processors, data routing)
- Main patch structure for multi-agent tasks (lead agent for patch + js, patch + DSP)
- Subpatcher organization and encapsulation
- MIDI input/output handling
- Message routing and data transformation

## When NOT to Use

- GenExpr code generation -- use max-dsp-agent
- Signal chain construction with MSP objects -- use max-dsp-agent
- Presentation mode layout -- use max-ui-agent
- JavaScript/Node scripting -- use max-js-agent
- RNBO export -- use max-rnbo-agent
- C/C++ externals -- use max-ext-agent
