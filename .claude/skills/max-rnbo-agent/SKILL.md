---
name: max-rnbo-agent
description: RNBO export-aware patch generation, target validation, and param mapping
allowed-tools:
  - Read
  - Grep
  - Write
  - Edit
  - Bash
preconditions:
  - Active project must exist
---

# RNBO Specialist Agent

Generate RNBO patches for VST3/AU plugin, Web Audio, and C++ embedded export targets. Handles rnbo~ container creation, target-aware validation, param mapping, and self-contained patch generation.

## Capabilities

- **RNBO patch generation**: Create rnbo~ containers with inner patchers via `add_rnbo` or full wrapper patches via `generate_rnbo_wrapper`
- **Target-aware validation**: Validate patches against export target constraints (plugin, web, cpp) using `validate_rnbo_patch`
- **Param mapping**: Extract GenExpr Param declarations and map to RNBO param objects for plugin parameter export
- **Object compatibility**: Check RNBO compatibility of any object via `RNBODatabase`
- **Semantic review**: Run RNBO critic to catch param naming issues, missing I/O, and duplicate params

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

## Domain Context Loading

When invoked:
1. Read `.claude/max-objects/rnbo/objects.json` (560 RNBO-compatible objects)
2. Read `.claude/max-objects/msp/objects.json` and `.claude/max-objects/gen/objects.json` for companion objects
3. Read `CLAUDE.md` RNBO section for export rules and constraints

## Python API References

```python
from src.maxpat.rnbo import (
    RNBODatabase,
    add_rnbo,
    generate_rnbo_wrapper,
    parse_genexpr_params,
)
from src.maxpat.rnbo_validation import (
    validate_rnbo_patch,
    RNBO_TARGET_CONSTRAINTS,
)
from src.maxpat.critics import review_patch
from src.maxpat.hooks import save_patch_roundtrip
```

### Key Functions

- `RNBODatabase()`: RNBO-specific object database; `.is_rnbo_compatible(name)` and `.lookup(name)` methods
- `add_rnbo(patcher, objects, params, target, audio_ins, audio_outs)`: Add rnbo~ container to an existing Patcher
- `generate_rnbo_wrapper(params, target, audio_ins, audio_outs)`: Build complete adc~ -> rnbo~ -> dac~ wrapper Patcher
- `parse_genexpr_params(code)`: Extract Param declarations from GenExpr code
- `validate_rnbo_patch(patch_dict, target)`: 3-layer validation on the **inner RNBO patcher** (not the full rnbo~ wrapper). Checks: rnbo-objects, rnbo-target, rnbo-contained
- `RNBO_TARGET_CONSTRAINTS`: Per-target constraint definitions (plugin, web, cpp)

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
3. Find targets: `box = patcher.find_box(name="rnbo~")`
4. Make changes: `result = patcher.modify_box(box, args=["mypatch"])`
5. Validate: `results = validate_patch(patcher)`
6. Save: `save_patch_roundtrip(patcher.to_dict(), path, original_text)`

**Domain focus:** Edit RNBO patcher contents, param objects, export-compatible structures.

## Output Protocol (New Patches)

1. **Build RNBO patcher** using `add_rnbo` (add to existing patch) or `generate_rnbo_wrapper` (standalone wrapper)
2. **Run `validate_rnbo_patch`** with the export target to check object compatibility, target constraints, and self-containedness
3. **Run `review_patch`** for semantic critic review (param naming, I/O completeness, duplicates)
4. **Fix any blockers** found by validation or critic
5. **Save wrapper .maxpat** via `save_patch_roundtrip(patch_dict, path)` for the final output

## Output Protocol (Edited Patches)

1. Load and analyze existing patch via `read_patch()` and `patcher.analyze()`
2. Make surgical edits or section rebuild using find/modify/replace/insert/remove
3. Validate via `validate_patch(patcher)`
4. Return for critic review
5. Save via `save_patch_roundtrip()` -- never `apply_layout()` on loaded patches

### Export Target Reference

| Target | Use Case | Constraints |
|--------|----------|-------------|
| `plugin` | VST3/AU | Self-contained, audio I/O required |
| `web` | Web Audio / WASM | Self-contained, .aif format warning for Chrome |
| `cpp` | C++ embedded | Max 128 params, no buffer~/data, self-contained |

## When to Use

- User asks about RNBO export or plugin creation
- User wants to generate a VST3/AU plugin, Web Audio export, or C++ embedded target
- User needs target-aware RNBO patch validation
- Router dispatches an RNBO-related task

## When NOT to Use

- Standard MSP/gen~ generation (not targeting RNBO) -- use max-dsp-agent
- General patch construction -- use max-patch-agent
- GenExpr authoring for gen~ (not RNBO) -- use max-dsp-agent
- UI layout or presentation mode -- use max-ui-agent
