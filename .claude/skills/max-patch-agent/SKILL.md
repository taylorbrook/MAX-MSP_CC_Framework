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
1. Read `CLAUDE.md` at project root -- follow all 5 rules and patch style guidelines
2. Use `ObjectDatabase` from `src.maxpat.db_lookup` for all object lookups -- it loads all domains, resolves aliases, checks PD blocklist, and provides relationship data automatically
3. Read `.claude/max-objects/relationships.json` for common object pairings (if needed for design decisions)

**Domain focus:** Max control/data/UI objects. Signal processing and RNBO are handled by their respective agents.

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
- `Patcher.add_subpatcher(name, inlets, outlets, inlet_comments, outlet_comments)` -- add a subpatcher with labeled I/O
- `Patcher.populate_assistance_comments()` -- auto-fill empty inlet/outlet comments from connection context
- `finalize_patch(patcher, is_new=True)` -- single-call layout cleanup: styling, layout, comments, midpoints (new); midpoints + comments (edit)
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
- **MUST** use `trigger` (t) for ALL control-rate fan-out -- connecting one outlet to 2+ destinations without trigger is a structural defect (see shared-capabilities.md "Control-Rate Fan-Out Rule")
- **MUST** send to cold inlets FIRST, hot inlet LAST -- use `trigger` to guarantee ordering (CLAUDE.md Rule #3)
- Named send/receive for long-distance connections
- Subpatcher organization for complex logic
- Comment objects on non-obvious connections
- For dial, number, and control appearance, consult `.claude/skills/references/ui-presets.md`

### M4L MIDI Routing

When generating control/MIDI flow for M4L devices (instrument or midi_effect):

- **MIDI passthrough:** Instrument and midi_effect devices MUST have midiin connected to midiout. MIDI flows through even when the device doesn't process it -- prevents silent MIDI drops in Ableton.
- **midiin/midiout use maxclass="newobj":** They are NOT UI objects. Use add_box("midiin") and add_box("midiout") -- the Box constructor resolves maxclass correctly.
- **live.path / live.object:** Used together to interact with the Live API. live.path resolves an API path string (e.g., "live_set tracks 0"), live.object sends messages to the resolved object. They are a required pair -- never use one without the other.
- **--- prefix on named objects:** All named objects (buffer~, coll, dict, send, receive, send~, receive~, value) in M4L devices MUST use --- prefix (e.g., buffer~ ---mybuffer). MAX replaces --- with a unique device instance ID at runtime, preventing name collisions when multiple instances are loaded.
- **live.thisdevice:** Every M4L device includes live.thisdevice for device initialization. It outputs device ID and state on load.

> **Shared Capabilities:** See `.claude/skills/references/shared-capabilities.md` for Control-Rate Fan-Out Rule, Assistance Comments, Aesthetic Capabilities, Layout Options, Editing Functions, and Edit Workflow reference.

## Editing Existing Patches (via /max-iterate)

**Domain focus:** Edit control flow routing, message handling, subpatcher organization.

## Output Protocol (New Patches)

1. Create Patcher and build patch structure
2. Finalize patch: `finalize_patch(patcher, is_new=True)` -- applies styling, layout, assistance comments, and midpoint generation for all patchers and subpatchers
3. Serialize and validate: `patch_dict = patcher.to_dict()`, `results = validate_patch(patch_dict, db=patcher.db)`
4. Return `(patch_dict, results)` tuple for critic review
5. Apply revisions if critic requests them
6. Write final output via `save_patch_roundtrip(patch_dict, path)` to project's `generated/` directory

## Output Protocol (Edited Patches)

1. Load and analyze existing patch via `read_patch()` and `patcher.analyze()`
2. Make surgical edits or section rebuild using find/modify/replace/insert/remove
3. Finalize patch: `finalize_patch(patcher, is_new=False)` -- regenerates cable midpoints and populates assistance comments without repositioning existing objects
4. Validate via `validate_patch(patcher)`
5. Return for critic review
6. Save via `save_patch_roundtrip()`

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
