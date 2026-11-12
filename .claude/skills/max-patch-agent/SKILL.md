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
1. Read `CLAUDE.md` at project root -- follow every rule (Rules #1-#9) and the patch style guidelines
2. Read `.claude/skills/references/shared-capabilities.md` for the rules moved out of CLAUDE.md: "bach (package) Rules" (any bach object)
3. Use `ObjectDatabase` from `src.maxpat.db_lookup` for all object lookups -- it loads all domains, resolves aliases, checks PD blocklist, and provides relationship data automatically
4. Read `.claude/max-objects/relationships.json` for common object pairings (if needed for design decisions)
5. Read project `config.json` via `load_project_config()` from `src.maxpat.project` for allowed packages. Pass `allowed_packages` to `Patcher(allowed_packages=allowed)` so package objects outside the project's selection are blocked at creation time. If `load_project_config()` returns None (no config.json), use `allowed = []` (core-only), never None -- None allows every package.

**Domain focus:** Max control/data/UI objects. Signal processing and RNBO are handled by their respective agents.

## Capabilities

### Patch Construction
- Create `Patcher` instances with boxes and connections via `src.maxpat.patcher`
- Create standard objects with `patcher.add_box(name, args, x, y)` -- it looks the name up in ObjectDatabase (Rule #1) and returns the Box
- Create structural objects with the dedicated builders: `add_subpatcher()`, `add_bpatcher()`, `add_gen()`
- Connect boxes with `Patcher.add_connection(src_box, src_outlet, dst_box, dst_inlet)`

### Key Functions
- `Patcher()` -- create a new patch
- `Patcher.add_box(name, args=None, x=0.0, y=0.0)` -- create a DB-validated box and add it to the patch (returns the Box). An explicit position is kept unless the box would truly overlap another; then it moves down in 15px steps and a `BoxMovedWarning` names the move (`box.nudged_from` holds the requested position).
- `Patcher.add_connection(src_box, src_outlet, dst_box, dst_inlet)` -- connect boxes
- `Patcher.add_subpatcher(name, inlets=1, outlets=1, x=0.0, y=0.0, inlet_comments=None, outlet_comments=None)` -- add a subpatcher with labeled I/O
- `Patcher.populate_assistance_comments()` -- auto-fill empty inlet/outlet comments from connection context
- `finalize_patch(patcher, is_new=True, force_layout=False)` -- single-call layout cleanup: styling, layout, comments, midpoints (new); comments + routing of new or touched cords that have no midpoints, never moving boxes or clearing midpoints (edit). With `is_new=True` it raises `LayoutRefusedError` (from `src.maxpat.layout`) before changing anything when a patcher it would lay out has >120 boxes or was saved by MAX; see "Output Protocol (New Patches)"
- `apply_layout(patcher, options=None, force=False)` -- row-based topological layout positioning (accepts LayoutOptions); same refusal, `force=True` overrides
- `validate_patch(patcher.to_dict(), db=patcher.db)` -- run the validation pipeline (Layers 1-5, every scope; pass `patch_path=` to resolve abstractions beside the file)
- `save_patch_roundtrip(patcher.to_dict(), path)` -- write .maxpat to disk
- `Patcher.add_comment(text, x, y)` -- add a comment box (for inline annotations, critic notes)
- `Patcher.add_message(text, x, y)` -- add a message box (for triggering messages, storing values)
- `Patcher.add_box("node.script", ["myscript.js"], x=0.0, y=0.0)` -- add a node.script box for Node for Max (DB entry: fixed 1 inlet / 2 outlets); write the script file with `write_js(code, path)`
- `Patcher.add_js(filename, code=None, num_inlets=1, num_outlets=1, x=0.0, y=0.0)` -- add a js object box (Legacy Engine, ES5 JavaScript) (returns tuple of Box and code string)

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

## Builder API (Phase 31)

Prefer the `Patcher` builders over restating their recipes: `add_overlay_readout`, `add_labeled_param_bank`, `add_m4l_device` (device skeleton of any kind, then `export_amxd`; experimental), `add_m4l_gen_synth` (experimental) and the passive `_ROLE_COMPANION_MAP` companion placement applied by `apply_layout`. Signatures, arguments and the quick-reference table: "Builder API" in `.claude/skills/references/shared-capabilities.md`.

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
- **Bach** (`bach.*`): Uses llll data type (NOT standard MAX lists). Never mix llll with regular lists. A flat MAX list connects directly to a bach inlet; for structured conversion use `bach.flat`, `bach.iter`, or `bach.pack`, and extract elements with `bach.nth N`.
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
**Chain:** data source (flat MAX list) -> bach.join / bach.flat / bach.nth (llll manipulation) -> bach.score or bach.roll

| # | Source | Outlet | Destination | Inlet | Type |
|---|--------|--------|-------------|-------|------|
| 1 | (flat MAX list source) | 0 | bach.join | 0 (llll in 1) | list |
| 2 | (flat MAX list source) | 0 | bach.join | 1 (llll in 2) | list |
| 3 | bach.join | 0 (joined llll) | bach.flat | 0 (llll in) | llll |
| 4 | bach.flat | 0 (flattened llll) | bach.nth | 0 (llll in) | llll |
| 5 | bach.nth | 0 (extracted element) | bach.score | 0 (llll data) | llll |

**Parameter ranges:**
- bach.join: `@numins` default 2 (number of llll inlets to join)
- bach.nth: index argument is 1-based (e.g., `bach.nth 1` extracts the first element)
- bach.flat: depth argument controls flattening depth (0 = fully flatten)

**Gotchas:**
- A flat MAX list connects directly to a bach inlet -- there is no converter object to insert (the ones named in older docs are not present in the installed bach package). For structured conversion use `bach.flat`, `bach.iter`, or `bach.pack`
- To extract a sub-llll value use `bach.nth N` (1-based, one call per index), adding `@unwrap 1` when the extracted element is itself a sublist
- When a bach outlet feeds a plain MAX object, set `@out t` (text format) on the bach object -- the default `@out n` (native) is rejected by objects like `f`, `select`, `unpack`, and `expr`
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
**Chain:** algorithm source (metro + counter / random) -> bach.collect -> bach.quantize -> bach.score

| # | Source | Outlet | Destination | Inlet | Type |
|---|--------|--------|-------------|-------|------|
| 1 | metro | 0 (bang) | trigger b b | 0 | bang |
| 2 | trigger | 0 | random 12700 | 0 (bang) | bang |
| 3 | random | 0 (pitch value) | bach.collect | 0 (llll in) | int |
| 4 | trigger | 1 | bach.collect | 0 (bang to flush) | bang |
| 5 | bach.collect | 0 (collected llll) | bach.quantize | 0 (llll in) | llll |
| 6 | bach.quantize | 0 (quantized llll) | bach.score | 0 (llll data) | llll |

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
2. Finalize patch: `finalize_patch(patcher, is_new=True)` -- applies styling, layout, assistance comments, and midpoint generation for all patchers and subpatchers.
   - **LayoutRefusedError** (`from src.maxpat.layout import LayoutRefusedError`, a `ValueError`): raised when the patcher, or any subpatcher the layout recurses into, has more than 120 boxes or was saved by MAX. Nothing has changed when it is raised (no styling, no moves).
   - Large NEW build (every box made by this build): call `finalize_patch(patcher, is_new=True, force_layout=True)`.
   - A build that embeds a MAX-saved patcher or edits a file from disk: never force. Use `finalize_patch(patcher, is_new=False)` (or `edit_patch(path)`), which never repositions existing boxes.
3. Serialize and validate a copy: `patch_dict = patcher.to_dict()`, then `results = validate_patch(copy.deepcopy(patch_dict), db=patcher.db)`. Validation never mutates its input; the deepcopy is defense in depth.
4. Proposed removals mean inspect, don't save. If `has_blocking_errors(results, is_new=True)` is True, or any result has `proposed_removal` set, do NOT save. Inspect each `(src_id, outlet, dst_id, inlet)`: a real wiring mistake -> fix the build and re-validate; a validator false positive -> keep the cord and report the checker gap. Call `apply_fixes(patch_dict, results)` only when removal is explicitly wanted, then re-validate.
5. Return `(patch_dict, results)` tuple for critic review
6. Apply revisions if critic requests them
7. Only after the step-4 gate passes, write final output via `save_patch_roundtrip(patch_dict, path)` to project's `generated/` directory

## Output Protocol (Edited Patches)

Follow "Output Protocol (Edited Patches)" in `.claude/skills/references/shared-capabilities.md`.

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
