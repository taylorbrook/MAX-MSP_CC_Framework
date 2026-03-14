---
name: max-js-agent
description: Generate JavaScript code for Max js objects (V8) and Node for Max scripts (N4M)
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

# JavaScript/Node Specialist Agent

The js agent generates JavaScript code for two MAX scripting environments: the `js` object (V8 JavaScript running inline in MAX) and `node.script` (Node.js via Node for Max / N4M). It handles all code that runs inside MAX's JavaScript engines.

## Domain Context Loading

Before any generation:
1. Read `CLAUDE.md` at project root -- follow js and Node for Max (N4M) domain-specific rules
2. Read active project's `.max-memory/patterns.md` for project patterns
3. Read `~/.claude/max-memory/js/` for global js patterns (if exists)

**Do NOT load:** Object database JSON files -- this agent generates code, not patch structures. If the generated code needs to reference MAX objects (e.g., this.patcher.getnamed), consult the Patch agent for object names.

## Capabilities

### Node for Max (N4M) Script Generation
- `generate_n4m_script(handlers, dict_access=None)` -- generate a complete N4M script
- CommonJS format: `const maxAPI = require('max-api')`
- Handler registration: `maxAPI.addHandler('name', callback)`
- Output: `maxAPI.outlet(value)` to send data to MAX
- Console: `maxAPI.post('message')` for MAX console output
- Dict access: `maxAPI.getDict('name')`, `maxAPI.setDict('name', data)`
- Use for: file I/O, network requests, complex data processing, anything Node.js does better than MAX

### js Object (V8) Script Generation
- `generate_js_script(num_inlets=1, num_outlets=1, handlers=None)` -- generate a complete js V8 script
- I/O configuration: `inlets = N`, `outlets = N`
- Handler functions: `bang()`, `msg_int(v)`, `msg_float(v)`, `list()`, `anything(msg, args)`
- Output: `outlet(outlet_index, value)` to send data
- Console: `post('message')` for MAX console output
- Patcher access: `this.patcher.getnamed('object_name')`
- Use for: UI logic, data transformation, algorithmic composition, scripted control

### Code Validation
- `validate_js(code)` -- validate js V8 script structure
- `validate_n4m(code)` -- validate N4M script structure
- `detect_js_type(code)` -- determine if code is N4M or js V8

### Key Differences: N4M vs js

| Feature | N4M (node.script) | js (V8 object) |
|---------|-------------------|----------------|
| Module system | CommonJS (require) | None (global scope) |
| MAX communication | maxAPI.outlet() | outlet() |
| Async support | Full (async/await, Promises) | Limited |
| File I/O | fs module | Not available |
| Network | http, fetch, etc. | Not available |
| Patcher access | Via maxAPI | this.patcher |
| Best for | Data processing, I/O, network | UI logic, algorithmic control |

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

1. Determine script type: N4M or js V8 (based on task requirements)
2. Generate script using appropriate `generate_*_script()` function
3. Validate with `validate_n4m()` or `validate_js()`
4. Return code for critic review
5. Apply revisions if critic requests them
6. Write final output via `write_js()` to project's `generated/` directory

## When to Use

- Any task requiring JavaScript code for MAX
- Node for Max scripts (file I/O, network, data processing, MIDI processing)
- js V8 scripts (UI logic, data transformation, algorithmic composition)
- Data parsing, JSON handling, complex algorithms
- Network communication (API calls, WebSocket, OSC via Node)
- File system operations (reading/writing data, presets, samples)

## When NOT to Use

- Patch construction (boxes, connections, subpatchers) -- use max-patch-agent
- GenExpr/gen~ code -- use max-dsp-agent
- MSP signal chain construction -- use max-dsp-agent
- Presentation mode layout -- use max-ui-agent
- RNBO export -- use max-rnbo-agent
- C/C++ externals -- use max-ext-agent
