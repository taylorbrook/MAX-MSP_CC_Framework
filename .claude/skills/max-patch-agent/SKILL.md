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
4. Read project `config.json` via `load_project_config()` from `src.maxpat.project` for allowed packages. Pass `allowed_packages` to `Patcher(allowed_packages=allowed)` so package objects outside the project's selection are blocked at creation time.

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

> **Shared Capabilities:** See `.claude/skills/references/shared-capabilities.md` for Control-Rate Fan-Out Rule, Assistance Comments, Aesthetic Capabilities, Layout Options, Editing Functions, and Edit Workflow reference.

## Package Intelligence

When generating patches with package objects (BEAP, Vizzie, etc.), read `.claude/max-objects/PACKAGES.md` for:
- Signal conventions (BEAP: 0-5V CV, +/-1 audio; Vizzie: Jitter matrices)
- Functional roles and canonical module selection
- Template signal chains with connection order

### BEAP Modular Patching

BEAP modules are bpatchers that emulate analog modular synthesis:
- Use `add_bpatcher(object_name="bp.Oscillator", filename="bp.Oscillator.maxpat")` for auto-sized placement
- Follow signal chain order: Sources -> Processors -> Output (see PACKAGES.md templates)
- Always terminate with bp.Stereo or bp.Mono -- never leave signal chains unterminated
- CV connections carry control voltage (0-5V), separate from audio signal paths
- Use bp.VCA for all gain control -- never connect oscillators directly to output
- Keyboard provides pitch CV (outlet 0), gate (outlet 1), velocity (outlet 2), aftertouch (outlet 3)

### Community Packages

Community packages (FluCoMa, CNMAT, Bach, Odot, ml-lib, IRCAM Spat, Cage, Dada, EARS, Rhythmic Time Toolkit) have stub DB entries but require local extraction before generation.

**Before using any community package object:**
1. Check `ObjectDatabase().get_package_info(package_name)["extracted"]`
2. If `false`: inform the user they must install and extract first (see max-lifecycle SKILL.md for exact messages)
3. If `true`: proceed normally -- extracted data is verified and safe for generation

**Package-specific notes:**
- **FluCoMa** (`fluid.*`): Audio analysis/decomposition. Signal objects + offline buf* objects.
- **CNMAT**: OSC, resonance, spectral. Objects have NO prefix (bare names like `resonators~`, `analyzer~`).
- **Bach** (`bach.*`): Uses llll data type (NOT standard MAX lists). Never mix llll with regular lists. Use `bach.list2llll`/`bach.llll2list` for conversion.
- **Cage/Dada/EARS**: Bach ecosystem -- all require Bach installed. Operate on lllls.
- **Odot** (`o.*`): OSC bundle-based expression language.
- **ml-lib** (`ml.*`): Machine learning. All follow add/train/map pattern.
- **IRCAM Spat** (`spat5.*`): Spatial audio. Parameters via OSC bundles.
- **Rhythmic Time Toolkit** (`rtk.*`): Signal-rate RNBO sequencing.

### Vizzie Video Chains

Vizzie modules pass Jitter matrices (video frames) between bpatchers:
- Use `add_bpatcher(object_name="vz.playr", filename="vz.playr.maxpat")` for auto-sized placement
- Follow matrix chain order: Sources -> Effects -> Compositing -> Output
- Always terminate with vz.viewr (window) or vz.projectr (fullscreen)
- Control inlets accept int/float messages for parameter adjustment

## Package Workflow Templates

Structured workflow blueprints for generating working package patches. Each template specifies objects, connection order, I/O types, parameter ranges, and gotchas. Templates are generation guidance -- not pre-built .maxpat files.

### Bach: llll Construction and Manipulation

**Use case:** Build nested list structures for algorithmic composition
**Chain:** data source (message/number) -> bach.list2llll -> bach.join / bach.flat / bach.nth (llll manipulation) -> bach.score or bach.roll

| # | Source | Outlet | Destination | Inlet | Type |
|---|--------|--------|-------------|-------|------|
| 1 | (MAX list source) | 0 | bach.list2llll | 0 (list in) | list |
| 2 | bach.list2llll | 0 (llll out) | bach.join | 0 (llll in 1) | llll |
| 3 | bach.list2llll | 0 (llll out) | bach.join | 1 (llll in 2) | llll |
| 4 | bach.join | 0 (joined llll) | bach.flat | 0 (llll in) | llll |
| 5 | bach.flat | 0 (flattened llll) | bach.nth | 0 (llll in) | llll |
| 6 | bach.nth | 0 (extracted element) | bach.score | 0 (llll data) | llll |

**Parameter ranges:**
- bach.join: `@numins` default 2 (number of llll inlets to join)
- bach.nth: index argument is 1-based (e.g., `bach.nth 1` extracts the first element)
- bach.flat: depth argument controls flattening depth (0 = fully flatten)

**Gotchas:**
- ALWAYS convert MAX lists to llll via bach.list2llll before feeding ANY bach object
- bach.llll2list converts back to MAX lists when feeding non-bach objects
- llll is 1-indexed (not 0-indexed like MAX lists)
- bach.nth extracts by position; bach.flat removes nesting levels
- Connecting a standard MAX list outlet directly to a bach llll inlet will silently produce garbage -- the package critic will flag this as a blocker

### Bach: Notation Display Workflow

**Use case:** Display and edit musical notation with bach.score or bach.roll
**Chain:** bach.score (or bach.roll) <- llll data via inlet 0; message box commands (addchord, delete) via inlet 0

| # | Source | Outlet | Destination | Inlet | Type |
|---|--------|--------|-------------|-------|------|
| 1 | (llll data source) | 0 | bach.score | 0 (llll data / commands) | llll |
| 2 | message box ("addchord ...") | 0 | bach.score | 0 (command) | message |
| 3 | bach.score | 0 (modified llll) | (downstream bach processing) | 0 | llll |
| 4 | bach.score | 1 (notifications) | (status display) | 0 | list |

**Parameter ranges:**
- bach.score: display width/height should be generous (300x200 minimum for readability)
- Pitch representation: MIDI cents (6000 = middle C, 100 cents per semitone)
- Duration representation: rationals (1/4 = quarter note, 1/8 = eighth note)

**Gotchas:**
- bach.score accepts both llll data AND messages on inlet 0 (messages like "addchord" are distinct from llll data)
- To initialize: send the full llll to inlet 0
- To modify: send command messages ("addchord", "delete", "setpitch") to inlet 0
- bach.score is a UI object -- it needs presentation mode and adequate display size
- Pitch representation: MIDI cents (6000 = middle C, 100 cents per semitone)
- bach.roll is the proportional (non-quantized) equivalent of bach.score

### Bach: Algorithmic Composition Pipeline

**Use case:** Generate musical material algorithmically and display in notation
**Chain:** algorithm source (metro + counter / random) -> bach.list2llll -> bach.collect -> bach.quantize -> bach.score

| # | Source | Outlet | Destination | Inlet | Type |
|---|--------|--------|-------------|-------|------|
| 1 | metro | 0 (bang) | trigger b b | 0 | bang |
| 2 | trigger | 0 | random 12700 | 0 (bang) | bang |
| 3 | random | 0 (pitch value) | bach.list2llll | 0 | list |
| 4 | bach.list2llll | 0 (llll) | bach.collect | 0 (llll in) | llll |
| 5 | trigger | 1 | bach.collect | 0 (bang to flush) | bang |
| 6 | bach.collect | 0 (collected llll) | bach.quantize | 0 (llll in) | llll |
| 7 | bach.quantize | 0 (quantized llll) | bach.score | 0 (llll data) | llll |

**Parameter ranges:**
- metro: interval in ms (e.g., 250 for sixteenth notes at 60 BPM)
- random: range for MIDI cents (e.g., 0-12700 for full MIDI range)
- bach.quantize: quantization grid llll on inlet 1 (e.g., 1/4 for quarter note grid)

**Gotchas:**
- bach.collect accumulates lllls until bang -- send bang to collect then route to quantize
- bach.quantize snaps pitches/durations to musical grid (needs quantization llll on inlet 1)
- Output of bach.quantize is an llll ready for bach.score
- Use bach.iter to iterate over llll elements for processing individual notes
- Use trigger for fan-out to ensure correct ordering (bang to flush collect, then generate next)

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
