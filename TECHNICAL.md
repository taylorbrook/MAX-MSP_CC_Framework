# Technical Documentation

This document covers the internals of the MAX/MSP Claude Code Framework — the object database, agent system, validation pipeline, code generation, and layout engine.

For setup and usage, see [README.md](README.md).

---

## Table of Contents

- [Architecture Overview](#architecture-overview)
- [Object Database](#object-database)
- [Agent System](#agent-system)
- [Python Generation Engine](#python-generation-engine)
- [Validation Pipeline](#validation-pipeline)
- [Critic System](#critic-system)
- [DSP Pre-Flight Simulation](#dsp-pre-flight-simulation)
- [Code Generation](#code-generation)
- [Layout Engine](#layout-engine)
- [Project Lifecycle](#project-lifecycle)

---

## Architecture Overview

The framework has four core layers that work together during patch creation and editing:

```
User Request (build new or iterate on existing)
    │
    ▼
┌─────────────────┐
│   max-router     │  Analyzes task, dispatches to specialist agent(s)
└────────┬────────┘
         │
    ┌────┴────┐
    ▼         ▼
┌────────┐ ┌────────┐
│ Agent  │ │ Agent  │  Specialist agents (DSP, Patch, RNBO, js, UI, Ext)
│  Lead  │ │ Support│  read, edit, and write .maxpat files directly
└────┬───┘ └───┬────┘
     │         │
     ▼         ▼
┌─────────────────┐
│  Python Engine   │  Patcher/Box/Patchline classes, ObjectDatabase,
│  (src/maxpat/)   │  read/edit/save, layout, analysis, code generation
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   Validation     │  5-layer structural validation (auto-fixes where safe)
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   Critic Loop    │  Semantic review (DSP, structure, layout, RNBO, M4L, C++, package)
│                  │  Blockers → revision → re-review until clean
└────────┬────────┘
         │
         ▼
   patches/{project}/generated/
```

---

## Object Database

The knowledge base lives at `.claude/max-objects/` with one JSON file per domain.

### Domain Files

| File | Domain | Objects | Coverage |
|------|--------|---------|----------|
| `max/objects.json` | Control, data, UI, MIDI, OSC | 473 | Core MAX objects |
| `msp/objects.json` | Audio, signal processing | 247 | All MSP~ objects |
| `jitter/objects.json` | Video, matrix, OpenGL | 222 | Jitter pipeline |
| `mc/objects.json` | Multichannel wrappers | 222 | MC signal routing |
| `gen/objects.json` | Gen~ DSP operators | 189 | GenExpr operators |
| `m4l/objects.json` | Max for Live | 35 | Live API objects |
| `rnbo/objects.json` | RNBO export-compatible | 560 | Export-safe subset |

**Core domains: 1,948 objects across 7 files.**

Package objects no longer live in a single `packages/objects.json`. As of v4.0 package integration they are stored as **29 per-package files** under `.claude/max-objects/packages/<Name>/objects.json` (BEAP, Vizzie, FluCoMa, CNMAT, Bach, and more), totaling **1,497 objects** with per-package source tracking.

**Grand total: 3,445 objects** (1,948 core + 1,497 package).

### Object Entry Schema

Each object is keyed by name in its domain file. Full schema:

```json
{
  "name": "trigger",
  "maxclass": "trigger",
  "module": "max",
  "domain": "Max",
  "category": "Control, Right-to-Left",
  "digest": "Send input to many places",
  "description": "Outputs any input formatted according to object-argument specified.",
  "inlets": [
    {
      "id": 0,
      "type": "control",
      "signal": false,
      "digest": "Message to be Fanned to Multiple Outputs",
      "hot": true
    }
  ],
  "outlets": [
    {"id": 0, "type": "control", "signal": false, "digest": "Output Order 2 (int)"},
    {"id": 1, "type": "control", "signal": false, "digest": "Output Order 1 (int)"}
  ],
  "arguments": [
    {"name": "formats", "type": "symbol", "optional": true, "digest": "Output types"}
  ],
  "messages": ["bang", "int", "float", "list", "anything"],
  "attributes": {},
  "seealso": ["bangbang", "jstrigger", "message"],
  "tags": ["Max", "Control", "Right-to-Left"],
  "min_version": "8",
  "verified": true,
  "variable_io": true,
  "rnbo_compatible": true
}
```

Key fields:
- **`inlets`/`outlets`**: Arrays with `id`, `type`, `signal` (bool), `hot` (inlets only)
- **`variable_io`**: If `true`, actual I/O count depends on arguments — compute it with `db.compute_io_counts(name, args)` (rules live in `overrides.json` → `variable_io_rules` and `src/maxpat/io_resolvers.py`; see Variable I/O Rules below)
- **`rnbo_compatible`**: Whether the object can be used in RNBO export patches
- **`min_version`**: Minimum MAX version required, as a version string (`"8"`, `"8.1"`, `"9.2"`; all patches target MAX 9)

#### Schema-Hardening Fields (v5.0, Phase 28)

The v5.0 schema delta added three curated fields, validated fail-fast at load by `_validate_schema_extensions` (which runs after the deep-merge of `overrides.json`):

- **`signal_role`**: Per-outlet closed enum describing what the outlet actually carries. The loader projects it onto the legacy `outlet['signal']` bool via `_apply_signal_role_writethrough` (`signal_role == "audio"` → `signal: true`), so **`signal: bool` is now a derived back-compat shim** rather than authoritative data. Removal of the shim is deferred to a later major release (it was not part of 6.0.0).
- **`domain_restricted`**: Per-object list of domain enums marking objects that are only valid inside specific domains.
- **`verified_installed`**: Per-object strict bool recording whether the object was confirmed present in an actual installation (as opposed to community-extracted stub metadata).

### Variable I/O Rules

Objects with `variable_io: true` change inlet/outlet count based on arguments. The domain files carry only that flag; the counts come from two places, both applied by `db.compute_io_counts(name, args)`:

- **`overrides.json` → `variable_io_rules`**, keyed by object name. Each entry has `inlet_count` / `outlet_count` formulas, optional `default_inlets` / `default_outlets` for the no-argument case, and a `description` (plus `trailing_outlets` where the last outlets keep their own types). `_validate_variable_io_rules` rejects any formula outside `SUPPORTED_IO_FORMULAS` (or `fixed:N`) at load.
- **`IO_RESOLVERS`** in `src/maxpat/io_resolvers.py`: text-aware resolvers for objects whose counts depend on parsing the box text (`select`, `route`, `routepass`, `expr`, `vexpr`, `if`, `sprintf`, `pipe`, `receive`, `ctlin`, `notein`).

| Formula | Meaning | Example (`compute_io_counts`) |
|---------|---------|---------|
| `arg_count` | One I/O per argument | `mc.separate~ 2 2 1` → 3 outlets |
| `arg_count+1` | Arguments plus one extra | — (no rule uses it) |
| `arg_count_or_default` | One I/O per argument, `default_*` when there are none | `trigger b i f` → 3 outlets; bare `trigger` → 2 |
| `first_arg` | First argument is the count | `gate 3` → 3 outlets |
| `first_arg+1` | First argument plus one | `switch 3` → 4 inlets |
| `second_arg` | Second argument is the count | `router 4 2` → 2 outlets |
| `second_arg+1` | Second argument plus one | `matrix~ 4 2` → 3 outlets (2 signal + 1 dump) |
| `second_arg+2` | Second argument plus two | `record~ buf 2` → 4 inlets |
| `sfplay_outlets` | Channels + position flag (0-2) + done-bang; a leading sflist~ name is skipped | `sfplay~ sf.cues 2 0 1` → 4 outlets |
| `inherited_from_subpatch` | Counts follow the inlet/outlet boxes of the loaded subpatcher | `bpatcher` |
| `fixed:N` | Always N regardless of args | `pack 0 0 0 0` → 1 outlet (`fixed:1`) |

### Supplementary Files

**`aliases.json`** — Shorthand mappings to canonical names:
```json
{
  "t": "trigger",
  "b": "bangbang",
  "sel": "select",
  "r": "receive",
  "s": "send",
  "r~": "receive~",
  "s~": "send~"
}
```

**`relationships.json`** — Common object pairings:
```json
{
  "pairs": [
    {"objects": ["tapin~", "tapout~"], "relationship": "required_pair",
     "note": "tapin~ always needs tapout~ to read the delay buffer"},
    {"objects": ["buffer~", "play~"], "relationship": "common_pair",
     "note": "play~ reads from buffer~"},
    {"objects": ["metro", "counter"], "relationship": "common_pair",
     "note": "metro drives counter for sequencing"}
  ]
}
```

Relationship types: `required_pair`, `common_pair`, `equivalent`, `required_group`.

**`overrides.json`** — Expert corrections that take precedence over extracted data. Contains three sections:
- **`objects`**: Corrected inlet/outlet types, counts, and metadata (e.g., `buffer~` outlets are control not signal, `line~` has mixed outlets)
- **`version_map`**: Maps MAX version numbers to object prefixes (e.g., MAX 9 → `array.*`, `string.*`)
- **`variable_io_rules`**: Formulas for computing I/O counts from arguments (plus `trailing_inlets` for objects like `record~ buf N` whose leading inlets repeat; `ObjectDatabase.resolve_inlet`)

Corrected entries carry an `_evidence` comment key; MC signal outlets are typed as MAX saves them (`multichannelsignal` or `signal`). The audit merger (`src/maxpat/audit/merger.py`) skips proposals with no base entry, keys new entries canonically and rehearses a DB load before writing (`OverridesLoadError`, nothing written). Detail: `.claude/skills/references/db-maintenance.md`.

**`idioms.json`** — every cord the installed bundle's help patches ship (`tools/sync_max_bundle.py --apply idioms`); Layer 3 never type/role-checks a listed cord, and `ObjectDatabase.is_shipped_signal_inlet` lets any source feed a signal into an inlet a shipped cord feeds with one. **`version_io.json`** — per-version I/O changes mined from help boxes saved by different Max builds (`--apply version-io`), read by `validate_patch(target_version=...)`. **`groups.json`** — inherited group names (mc wrapper, shared Jitter, thispatcher), merged at call time.

**`pd-blocklist.json`** — Pure Data objects that do not exist in MAX:
```json
{
  "blocklist": {
    "osc~": {"max_equivalent": "cycle~", "reason": "PD sinusoidal oscillator"},
    "lop~": {"max_equivalent": "onepole~", "reason": "PD one-pole lowpass"},
    "hip~": {"max_equivalent": "onepole~", "reason": "PD one-pole highpass"},
    "bp~": {"max_equivalent": "reson~", "reason": "PD bandpass filter"},
    "throw~": {"max_equivalent": "send~", "reason": "PD audio bus send"},
    "catch~": {"max_equivalent": "receive~", "reason": "PD audio bus receive"}
  }
}
```

### ObjectDatabase Class

`src/maxpat/db_lookup.py` provides the `ObjectDatabase` class — the single programmatic interface to the knowledge base.

**Key methods:**

| Method | Returns | Purpose |
|--------|---------|---------|
| `lookup(name)` | `dict \| None` | Full object metadata, resolves aliases automatically |
| `exists(name)` | `bool` | Quick existence check |
| `is_pd_object(name)` | `bool` | Checks PD blocklist |
| `get_pd_equivalent(name)` | `str \| None` | MAX equivalent for a PD object |
| `compute_io_counts(name, args)` | `(int, int)` | Actual (inlets, outlets) accounting for variable I/O |
| `get_outlet_types(name, args)` | `list[str]` | Outlet type array (`"signal"`, `""`, `"multichannelsignal"`) |

**Schema-hardening accessors (v5.0):**

| Method | Returns | Purpose |
|--------|---------|---------|
| `get_signal_role(name, outlet)` | `str \| None` | Curated per-outlet `signal_role` enum |
| `get_domain_restrictions(name)` | `list[str]` | Domain enums the object is restricted to |
| `is_domain_restricted(name)` | `bool` | Whether the object carries any domain restriction |
| `get_install_state(name)` | `bool \| None` | Raw `verified_installed` value |
| `is_verified_installed(name)` | `bool` | Strict install-verification check |
| `audit_signal_role_coverage()` | `dict` | Coverage report for `signal_role` metadata |
| `audit_install_coverage()` | `dict` | Coverage report for `verified_installed` |
| `audit_domain_coverage()` | `dict` | Coverage report for `domain_restricted` |
| `audit_empty_io()` | `dict` | Entries with empty inlets/outlets, with a `by_source` per-package breakdown |

**Load order**: `rnbo → packages → m4l → gen → mc → jitter → msp → max`. Later domains override earlier ones, so core MAX definitions take precedence.

---

## Agent System

The framework uses 9 specialist agents defined in `.claude/skills/`. Each agent has access to the object database and Python engine.

### Router (max-router)

Entry point for all generation tasks. Analyzes the user's task description using keyword matching against domain-specific vocabularies.

**Dispatch logic:**
1. Count primary/secondary keyword matches per domain
2. Check intent patterns (e.g., "export as VST" → RNBO)
3. Identify lead agent for multi-domain tasks
4. Default hierarchy for ties: DSP > Patch > js > UI

**Single-agent dispatch examples:**
- Pure control-rate → max-patch-agent
- Pure audio/DSP → max-dsp-agent
- RNBO export → max-rnbo-agent
- JavaScript → max-js-agent

**Multi-agent dispatch examples:**
- "synth with controls" → DSP (lead) + UI
- "step sequencer with MIDI" → Patch (lead) + js

After generation, the router passes output through the critic loop before writing files.

### Specialist Agents

| Agent | Domain | Generates | Key Rules |
|-------|--------|-----------|-----------|
| **max-patch-agent** | Control, MIDI, routing | `.maxpat` | Hot/cold inlet ordering, explicit `trigger` for fan-out |
| **max-dsp-agent** | Audio, Gen~ | `.maxpat`, `.gendsp` | GenExpr declarations before expressions, gain staging, `dac~` termination |
| **max-rnbo-agent** | RNBO export | `.maxpat` | Only `rnbo_compatible` objects, self-contained patches, target constraints. **Experimental:** not yet confirmed in MAX. |
| **max-js-agent** | JavaScript | `.js` | N4M uses CommonJS (`require`), the `js` object (Legacy Engine, ES5) uses global scope |
| **max-ui-agent** | UI layout | `.maxpat` modifications | Presentation mode attributes, spacing rules |
| **max-ext-agent** | C++ externals | `.cpp`, `.mxo` | Min-DevKit scaffolding, cmake/make build loop, Mach-O validation |

### Support Agents

| Agent | Role | Behavior |
|-------|------|----------|
| **max-critic** | Quality assurance | Orchestrates generate-review-revise loop using Python critics. No hard round limit — loops until clean. |
| **max-lifecycle** | Project management | Creates projects, tracks stages (ideation → discuss → research → build → verify), generates test checklists |

---

## Python Engine

`src/maxpat/` contains the core Python library (~40,800 LOC).

### Core Classes (`patcher.py`)

**Patcher** — Container for boxes and patchlines:

| Method | Purpose |
|--------|---------|
| `from_dict(data)` | Load a `.maxpat` JSON dict into Patcher/Box/Patchline objects (recursive subpatchers) |
| `to_dict()` | Serialize to complete `.maxpat` JSON structure (round-trip safe) |
| `add_box(name, args, x, y)` | Create and add a Box (auto-generates ID, validates against DB); keeps an explicit position unless the box truly overlaps another, then moves it down and warns `BoxMovedWarning` (`box.nudged_from` holds the requested position) |
| `add_comment(text, x, y)` | Create comment box |
| `add_message(text, x, y)` | Create message box |
| `add_connection(src, outlet, dst, inlet)` | Create patchline between boxes (with bounds checking) |
| `add_subpatcher(name, inlets, outlets, x, y)` | Create embedded subpatcher with inlet/outlet objects |
| `add_bpatcher(filename=None, embedded=False, args=None, x=0.0, y=0.0, ...)` | Create bpatcher (file reference or embedded); numeric-string `args` (`"0"`, `"1.5"`) are stored as JSON numbers so `#N` substitutes a number (the caller's list is untouched; `1e3` stays a symbol) |
| `add_gen(code, inputs, outputs, x, y)` | Create gen~ with embedded codebox |
| `add_js(filename, code, inlets, outlets, x, y)` | Create js object box |
| `find_box(*, id=None, name=None, maxclass=None, text=None, recursive=False)` | Find first matching box by id, name, maxclass, or text |
| `find_boxes(*, id=None, name=None, maxclass=None, text=None, recursive=False)` | Find all matching boxes |
| `remove_box(box)` | Remove box and all connected patchlines |
| `remove_connection(src, outlet, dst, inlet)` | Remove a specific patchline |
| `modify_box(box, *, args=None, position=None, color=None, extra_attrs=None)` | Modify box attributes in-place (with I/O recomputation). `args` sets the text of a newobj, message, comment or text-bearing UI box (textbutton, live.text, live.comment, textedit; size kept) and raises `ValueError` on any other UI box (use `extra_attrs`). `extra_attrs` keys `patching_rect` / `text` / `saved_object_attributes` set the model fields; `id`, `maxclass`, `numinlets`, `numoutlets`, `outlettype` and `patcher` raise |
| `insert_into_connection(source, dest, name, args=None)` | Insert a new object between two connected boxes |
| `replace_box(old_box, new_name, *, args=None)` | Replace object, keeping the box id, size and identity; every old connection comes back in `EditResult.orphaned` and must be rewired (Rule #8) -- prefer `replace_box_safe`. An embedded patcher moves to the new box only for the same name or `gen~` <-> `mc.gen~`; any other replace of a box with an embedded patcher raises `ValueError` |
| `downstream(box)` / `upstream(box)` | Graph traversal from a box |
| `signal_path(box)` | Trace signal-only path from a box |
| `connected_components()` | Find independent subgraphs |
| `bring_to_front(box)` | Move box to index 0 (renders on top) |
| `send_to_back(box)` | Move box to end of array (renders behind) |
| `set_z_index(box, index)` | Set explicit z-order position |

**Codified layout/UX builders (v5.0, Phase 31)** — one-call helpers that encode the CLAUDE.md recipes by construction:

| Method | Purpose |
|--------|---------|
| `add_overlay_readout(target, *, format="%.2f", type="flonum", editable=False, offset_x=0.0, offset_y=0.0) -> Box` | Overlay a readout on an interactive control (Rule #6 recipe: `bring_to_front` + `ignoreclick` click pass-through) |
| `add_labeled_param_bank(params, x, y, *, label_side="left", extra_attrs=None) -> (multislider, [comment, ...])` | Build a labeled multislider parameter bank (size×24 height, `contdata=1`, `setstyle=1`, `orientation=0`) with aligned comment labels |
| `replace_box_safe(old_box, new_name, *, args=None, rewire="auto") -> EditResult` | Replace a box keeping its identity (id, list position, presentation rect, varname, colours, parameter blocks; size for the same fixed-size UI class or unchanged text) and rewire every cord whose index still exists on the new box; the rest come back in `orphaned`. Same embedded-patcher rule as `replace_box` |
| `add_m4l_gen_synth(params, *, gen_varname="synth", gen_code=None) -> (gen_obj, [live_dial, ...], plugout_obj)` | Build a Live-ready M4L gen-synth skeleton (`live.dial`↔`Param` via `param_connect`; no `gain~` before `plugout~`), built on `add_m4l_device`. **Experimental:** not yet confirmed in MAX or Live. |
| `add_m4l_device(kind, params=None, *, audio_source=None, midi_source=None, midi_in=True, init_chain=True, banks=True, presentation=True, modmode=None, info_text=None)` | Device skeleton for `instrument` / `audio_effect` / `midi_effect` (Q40): Live-template wiring, `live.thisdevice` init chain, `live.dial` params with inferred unit/type, unique short names, Push banks, dial info text. Reuses existing top-scope device I/O (never a second pass-through; two of one name raise `ValueError`) and refuses a param name or explicit short name already in the patch. Export with `m4l_device.export_amxd(maxpat_path, out_path=None, kind=None)`, which warns on a kind mismatch and refuses a `live.thisdevice`-only helper abstraction unless `kind=` is given. **Experimental:** not yet confirmed in Live. |

Patcher internals are decomposed into mixins for maintainability: `GraphMixin` (`graph.py`) handles adjacency/traversal and `AnalysisMixin` (`analysis.py`) handles patch analysis. `utils.py` provides shared helpers like `get_box_name()`. The public API is unchanged.

**Box** — Individual MAX object:
- Resolves object name through ObjectDatabase (enforces Rule #1)
- Preserves all original attributes via `_raw` dict for lossless round-trip
- Computes `numinlets`, `numoutlets`, `outlettype` from database
- Auto-sizes based on object name and argument text width
- Stores position in `patching_rect = [x, y, width, height]`

**Patchline** — Connection between two boxes:
- Stores source/destination box IDs and outlet/inlet indices
- Preserves color, midpoints, and extra attributes through round-trip
- Serializes to `{"patchline": {...}}` format

### Read/Write Functions

| Function | Purpose |
|----------|---------|
| `read_patch(path)` | Load a `.maxpat` file from disk into a Patcher (returns Patcher + raw JSON string) |
| `save_patch_roundtrip(patch_dict, path, original_text=None, *, force=False)` | Write back with lossless preservation (key order, numeric and string spellings, trailing newline, CRLF) and the file's JSON layout (`format_patch_text`: MAX 9.1+ inline arrays, the Max 5-9.0.x tab layout via `maxjson.dumps_legacy`, or the framework's expanded layout via `maxjson.dumps_expanded`); when the new dict is `maxjson.json_identical` to the file the original text is kept, so a no-op save is byte-identical in every layout and an unchanged file is never rewritten; pass `patcher.to_dict()` |
| `edit_patch(path, *, force=False) -> EditSession` | The sanctioned edit path (Q36): `with edit_patch(path) as p:` re-reads the file, and a clean exit routes only touched cords, recolours only added boxes that carry an explicit textcolor (locked decision B11), computes `session.diff`, and saves through `save_patch_roundtrip` (no-op sessions write nothing) |
| `Patcher.diff(other)` | Semantic diff (boxes added / removed / moved / resized, text, attrs, presentation, cords and `cord_attrs` such as order / hidden / color, nested paths); `.render()` gives compact text |

### Patch Analysis (`analysis.py`)

`patcher.analyze()` produces a 7-facet structured summary:
- **Inventory** — object counts by domain (MAX, MSP, Jitter, MC, Gen~, etc.)
- **Sections** — functional groups detected by connected components and spatial proximity
- **Signal chains** — audio paths from sources to `dac~`
- **Control flow** — notable control paths (loadbang, metro, MIDI origins)
- **Hierarchy** — subpatcher/bpatcher/gen~ nesting map
- **Parameters** — user-controllable parameters (sliders, dials, number boxes)
- **Complexity** — object count, connection count, nesting depth, domain spread

---

## Validation Pipeline

Every generated patch passes through a 5-layer validation pipeline (`src/maxpat/validation.py`), several layers with sub-layers. The pipeline runs on demand via `validate_patch(patch, db=None, allowed_packages=None, *, scope=None, target_version=None, patch_path=None, original=None)` and inside the save gate (see write hooks below).

**Per scope.** The layers run on the top level and then on every embedded patcher (`p`, embedded bpatcher / poly~, gen~ / mc.gen~ `data.patcher`, jit.gen, rnbo~ ...) that `walk.iter_patchers` yields, each with its own scope (max / gen / rnbo). A nested result carries `ValidationResult.path` (the box-id chain, `obj-1/obj-2`) and a `[p synth > gen~] ` message prefix. A gen scope skips Layers 4 and 4c. `validate_patch` never mutates its input.

**Structured identity.** Every `ValidationResult` carries a non-empty `rule` (`unknown_object`, `outlet_out_of_bounds`, `role_mismatch`, `line_tilde_comma`, `expr_clip`, `bpatcher_numeric_args`, `message_selector`, `patcher_bgcolor`, `version_min_version`, ...), `box_ids` (`(src, dst)` for a cord, the box for a box finding, `()` for a scope finding) and `port`. The save gate keys on them.

### Layer 1: JSON Structure

Checks that the patch has valid top-level structure:
- `patcher` key exists at root
- `boxes` array exists and is a list
- `lines` array exists and is a list

**Severity**: error (blocks all downstream layers)

### Layer 2: Object Existence

Checks every object exists in the ObjectDatabase:
- Extracts object name from `text` field (first token for `newobj`)
- Checks PD blocklist and suggests MAX equivalents
- Skips structural maxclasses (`inlet`, `outlet`, `patcher`, `bpatcher`)

Sub-layers:
- **Layer 2b — maxclass usage**: flags a non-UI `maxclass` set on `newobj`-style objects (and vice versa)
- **Layer 2c — package gating**: defense-in-depth check that package objects used are within the project's `allowed_packages`
- **Layer 2d — community-extracted check**: flags objects backed only by community-extracted stub metadata (not `verified_installed`)

**Severity**: error for a Pure Data name and for an RNBO- or Gen-only name outside its scope (in every max scope, nested ones included). A name not in the database is a **warning** (`Unknown object`) when no `patch_path` is given. With `patch_path=` (the save gate and `validate_file` always pass it) the name is resolved against the abstractions MAX can load (`NAME.maxpat` / `.js` / `.gendsp` beside the patch or anywhere in its `patches/<project>/` tree, case-insensitive): resolved gives no finding, unresolved is an **error**. Rule #1 forbids unknown objects either way.

### Layer 3: Connection Validation

Validates all patchlines:
- **Outlet bounds**: source outlet index < source object's outlet count
- **Inlet bounds**: destination inlet index < destination object's inlet count
- **Signal compatibility**: signal-type checks now consult the curated `signal_role` metadata — signal outlets only connect to signal-accepting inlets (exception: `signal/float` inlets accept both)

- **Malformed ports**: a non-int, bool or negative port, or an unusable box id, is a `Malformed patchline` error with a proposed removal (never a crash)
- **MC flavours and shipped cords**: `signal` and `multichannelsignal` both count as signal; an `inlet` box source is never type-checked; the destination inlet is resolved from the box's args (`ObjectDatabase.resolve_inlet`, e.g. `record~ buf N`); an inlet any shipped help cord feeds with a signal (`is_shipped_signal_inlet`) accepts a signal from every source; companion pairs and `idioms.json` cords skip type/role checks

**Severity**: error with a **proposed removal** — the cord's `(src_id, src_outlet, dst_id, dst_inlet)` is set on `ValidationResult.proposed_removal`, in the scope its `path` names. `validate_patch` never mutates its input; only an explicit `apply_fixes(patch, results)` removes the cords (it returns 4-tuples for top-level cords and 5-tuples `(path, src_id, src_outlet, dst_id, dst_inlet)` for nested ones). `signal_role` mismatches are warnings and keep the cord.

### Layer 4: Domain-Specific Rules

Semantic checks for common MAX pitfalls:

| Check | What It Catches | Severity |
|-------|----------------|----------|
| Compound `#N` substitution | `buffer~ slot-#1` instead of `buffer~ #1` | warning |
| Unterminated signal chains | MSP objects with signal outlets going nowhere (a `*~ 0` / `mc.*~ 0` with an unfed gain inlet is a mute terminator) | warning |
| Missing gain staging | Oscillator → `dac~` without `*~` or `gain~` in between | warning |
| Feedback loops | Signal cycles without delay objects (`tapin~`/`tapout~`/`gen~`) | warning |
| Maxclass mismatch | `newobj` maxclass on non-UI objects that should use specific maxclass | warning |
| External .gendsp I/O mismatch | Gen~ box I/O count doesn't match referenced .gendsp file | warning |
| MC oscillator gain staging | MC oscillators reaching mc.dac~ without gain control | warning |
| `line~` comma segments | A message into `line~` where a ramp segment (2+ tokens) is followed by another comma segment (`1 10, 0 500`): only the last ramp plays. A leading jump (`0, 1 500`) is fine | error |
| Comment `#N` | `#N` in a comment box (no substitution); prose (5+ words with sentence punctuation) is skipped | warning |
| Gen `@param` syntax | `@name $1` sent to gen~ (attribute syntax; gen~ needs `name $1`) | warning |

**Layer 4c — vocabulary checks (Q23)**, non-gen scopes:

| Check | What It Catches | Severity |
|-------|----------------|----------|
| `expr_clip` | `expr` / `vexpr` / `if` calling `clip()` ("function clip not found"; max scope) | error |
| `bpatcher_numeric_args` | bpatcher `args` holding numeric strings (`"0"` substitutes as a quoted symbol) | error |
| `message_selector` | A message box whose selector the destination (inlet 0) does not list in `db.selectors`; containers, scripts, gen hosts and `bach.` / `cage.` / `dada.` / `ears.` destinations are never judged (max scope) | warning |
| `patcher_bgcolor` | A patcher that sets `editing_bgcolor` / `locked_bgcolor` but no `bgcolor` (MAX falls back to its light default when locked) | warning |

**Layer 4b — domain-restriction guard (VALID-02)**: flags objects used outside the domains listed in their `domain_restricted` metadata.

### Layer 5: Embedded GenExpr Codebox Walker (VALID-04)

Walks the codeboxes of every gen patcher embedded in each scope (top level and nested) and applies `validate_genexpr` (declaration ordering, functions before statements, operator existence, balanced structure, tabs, ...) to code that lives inline in the `.maxpat` rather than in a standalone `.gendsp` file. With `original=` (the patch as loaded; the save gate passes the baseline), each codebox is matched by scope path + container id + codebox id and validated with `validate_genexpr(original=...)`, so tab lines already in the loaded codebox are one warning and only new tab lines are an error.

### Blocking Behavior

`has_blocking_errors(results, is_new=True)` counts only `error` results; warnings and info never block. An error carrying a `proposed_removal` blocks when `is_new` is True (a new patch must not ship a cord the validator would drop) and is reported but not blocking with `is_new=False`. Every other error blocks. `auto_fixed` is a legacy flag `validate_patch` never sets, and the `"fixed"` level is never emitted. Saves are decided by the save gate (see Write Hooks), which blocks on errors and critic blockers the save introduces. Full contract: `.claude/skills/references/severity-contract.md`.

### Code Validation

Separate validators for code files (`src/maxpat/code_validation.py`). Run standalone (`validate_code_file(path, *, engine=None, loaded=True)`, `write_js`) they are **report-only** and never block; `write_gendsp` does not apply them to its own codebox either. `validate_code_file` treats a `.gendsp` on disk as loaded code (tab lines warn); pass `loaded=False` right after writing generated code. GenExpr in a codebox of any gen patcher embedded in a `.maxpat` goes through Layer 5, so its errors do block a save that introduces them.

**GenExpr** (`validate_genexpr(code, db=None, *, original=None)`):
- Balanced braces
- Semicolons on statement lines (statement-aware: operator continuations, Allman headers and brace-less two-line `if` are not flagged)
- Declaration ordering (all `Param`/`History`/`Delay`/`Buffer`/`Data` before expressions); a user function after a statement is an error, after declarations only a warning (functions, then declarations, then statements; `add_gen` reorders to this form)
- Operator existence in gen~ database
- Built-in constant names used as variables (`genexpr_parse.BUILTIN_CONSTANTS`: the 13 lower-case names, `phi`, and every upper-case alias)
- Tabs: an error in generated code (`original=None`) and in new lines; tab lines found verbatim in `original` are one warning

**js object** (`validate_js`):
- `inlets` and `outlets` declarations present
- At least one handler function (`bang`, `msg_int`, `msg_float`, `list`, `anything`)
- `outlet()` index within bounds

**Node for Max** (`validate_n4m`):
- `require('max-api')` present
- `addHandler` registrations
- `maxAPI.outlet()` calls

### RNBO Validation

Additional validation for RNBO export patches (`src/maxpat/rnbo_validation.py`):

| Check | What It Catches | Severity |
|-------|----------------|----------|
| Object compatibility | Non-RNBO objects in RNBO patch | error |
| Target constraints | Too many params for C++ (max 128), buffers in embedded target | warning |
| Self-containedness | External file references (`@file`, audio file paths) | error |

### Write Hooks

`src/maxpat/hooks.py` runs a save gate before writing `.maxpat` and `.gendsp` files (`.js` validation is report-only):

| Function | Validates | Blocks on Error |
|----------|-----------|----------------|
| `save_patch_roundtrip(patch_dict, path, original_text=None, *, force=False)` | Stale-file check, then the save gate: `validate_patch` (on a deepcopy) + `review_patch` with one cached DB, cord-removal warning, port x-rank check; auto-commits to git via `auto_commit_patch()` | New blockers / port reorder (`force=True` overrides) |
| `write_gendsp(code, path, ..., *, force=False)` | Edits an existing file in place (codebox code, in/out ports) through `save_patch_roundtrip`, or generates a new one; the same save gate; auto-commits to git | New blockers / port reorder (`force=True` overrides) |
| `write_js(code, path)` | Code validation (report-only); auto-commits to git | No |

The gate compares blocking findings with a baseline: `original_text`, else `git show HEAD:<path>`, else the file on disk. With no baseline the file is new and every blocker refuses (and `review_patch` runs with `is_new=True`). Both sides are validated with `patch_path=path` (so an unresolved unknown object is a blocker) and the new side with `original=baseline` (so only new codebox tab lines block). Findings are matched on a structured key -- origin, `rule`, sorted box ids plus proposed-removal ids, `port`, `proposed_removal` and scope `path` -- with a text template (box ids, quoted names and numbers masked) only as the fallback for a result without a rule or box ids; gate patcher paths key on box id + maxclass, so renaming a subpatcher changes no key, and `replace_box` keeps box ids. Keys are counted as a multiset, so only blockers the save introduces raise `PatchValidationError`. Findings that existed before the save never block, which is why third-party objects in user patches don't reject load-edit-save cycles. Cords present in HEAD (and in `original_text`) but missing from the new patch, walked recursively through subpatchers, emit one `SaveGateWarning`. A changed x-rank of any inlet/outlet present in both versions (subpatchers and abstraction top levels) blocks, because parent cords address ports by x-rank; a port appended rightmost does not. `force=True` saves anyway with a `SaveGateWarning` listing what was bypassed. `PatchValidationError` carries `findings` (the new ValidationResult/CriticResult objects), `port_changes` and `path`. Nothing is written or committed before the gate passes. When the new dict is identical to the file, nothing is rewritten. `validate_file()` (which passes the file's path and treats the file as loaded) remains on demand.

`finalize_patch(patcher, is_new=True, *, force_layout=False)` runs before a save in the build flow: with `is_new=True` it first checks the layout guard and raises `LayoutRefusedError` (a `ValueError` from `src.maxpat.layout`) on a MAX-saved patcher or one over the box limit, before any box is restyled or moved; pass `force_layout=True` for a large new build. `is_new=False` never moves or restyles, never clears midpoints, and routes only new or touched cords without midpoints. `write_gendsp` on an existing file never removes ports from auto-detected counts: pass `num_inputs` / `num_outputs` explicitly to remove surplus `in N` / `out N` boxes. `auto_commit_patch()` called directly raises `RuntimeError` on any git failure; the save wrappers catch it and warn.

---

## Critic System

Critics perform **semantic review** that structural validation cannot detect. They answer "is this well-designed?" rather than "is this structurally correct?"

Critics live in `src/maxpat/critics/` and are coordinated by the `review_patch()` function in `critics/__init__.py`.

### Severity Levels

| Severity | Meaning | Action |
|----------|---------|--------|
| **blocker** | Design defect preventing correctness | Triggers revision in critic loop |
| **warning** | Non-optimal pattern or best-practice violation | Reported in the review summary; no revision |
| **note** | Informational finding | FYI only |

### Structure Critic (`structure_critic.py`)

Reviews patch architecture and connection patterns.

| Check | Detects | Severity |
|-------|---------|----------|
| Fan-out without trigger | Control outlet connected to 2+ destinations without an explicit `trigger`; signal outlets, display-only sinks and `preset` membership outlets are exempt | blocker when the branches reconverge on one box with one branch at its hot inlet 0 and another at a DB-cold inlet (a branch that enters a box only at a cold inlet is not followed through it), otherwise warning |
| Hot/cold inlet ordering | Multiple sources feeding one object's hot and cold inlets without trigger-based ordering (skipped when the fan-out check already reports that outlet) | warning |
| Trigger types (`trigger_types`) | A single lower-case letter outside `b i f l s` in a `trigger` (`t a` outputs the literal `a`) | blocker |
| Trigger order (`trigger_order`) | A trigger that feeds a box's hot inlet before its cold inlets | blocker |
| `$N` arity (`dollar_arity`) | A message box whose highest `$N` its feeders can never fill | blocker |
| Uninitialized state (`uninitialized_state`) | A UI value holder that reaches DSP with nothing setting it at load | blocker with `is_new=True`, warning otherwise |
| Redundant connections | Duplicate patchlines (same source outlet → same destination inlet) | warning |
| Unmatched names (`unmatched_names`) | A send / receive, send~ / receive~ (and mc. forms), `; name` remote target, value / pv or buffer name with no partner anywhere in a closed patch tree; `#N`, `---` and numeric names are ignored | warning |
| Int truncation (`int_truncation`) | A float source (flonum, float-output dial / slider / live.*, `t f`, `f`, float-arg math) into arg-less `+ - * /`, arg-less `ftom` or an int-range `scale` | warning |
| MC bare list (`mc_bare_list`) | A bare numeric list into an `mc.*` object that takes `applyvalues` (lists do not distribute per channel) | note |

### DSP Critic (`dsp_critic.py`)

Reviews signal flow semantics.

| Check | Detects | Severity |
|-------|---------|----------|
| gen~ I/O mismatch | GenExpr code declares different I/O count than the `gen~` / `mc.gen~` box | blocker |
| Gain staging | Oscillator reaching `dac~` / `ezdac~` without a `*~` / `gain~` stage | blocker |
| MIDI-range gain values (`unsafe_gain_sources`) | Raw 0-127 control sources reaching a gain inlet of `*~` / `mc.*~`, directly or through `line~` (scaled ramps traced as the product), without a normalizer. A `*~` counts as a gain stage only when its other inlet carries audio and its output reaches neither an oscillator inlet nor a filter cutoff / Q / delay inlet (`lores~`, `svf~`, `onepole~`, `reson~` 2-3, `cross~`, `comb~`, `allpass~`, `filtercoeff~`), so FM depth and LFO-to-cutoff modulation pass | blocker |
| Gen `@param` messages (`gen_param_message_syntax`) | `@name $1` into gen~ (carries a `rewrite_gen_param` quick fix) | warning |

The gen~ I/O check compares the box with the highest `in N` / `out N` operator its codeboxes use; codeboxes wired in series or fed by params pass, and `code_context` is used only when no wired codebox has code.

### RNBO Critic (`rnbo_critic.py`)

Reviews RNBO export design. Only invoked when `rnbo~` boxes are detected.

| Check | Detects | Severity |
|-------|---------|----------|
| Missing I/O | No `in~` / `out~` and no event output in the inner RNBO patcher; an event-only patch (midiout / noteout / ctlout / outport / `out` and no `out~`) is a note | blocker |
| Param naming | Params not using `snake_case` convention | warning |
| Duplicate params | Multiple params with the same name, in either the positional `param <name> ...` form (what `add_rnbo` writes) or `@name` | blocker |
| Target fitness | Param count > 128 for C++ target | warning |

### External Critic (`ext_critic.py`)

Reviews C++ external source code (Min-DevKit). Only invoked when external code is provided.

| Check | Detects | Severity |
|-------|---------|----------|
| Missing `#include "c74_min.h"` | Required header absent | blocker |
| Missing `MIN_EXTERNAL` macro | Registration macro absent | blocker |
| Class name mismatch | Class name doesn't match `MIN_EXTERNAL` argument | blocker |
| Missing archetype methods | DSP missing `sample_operator`, scheduler missing `timer<>` | blocker |
| TODO comments | Unimplemented sections | note |

### Layout Critic (`layout_critic.py`)

Reviews visual/spatial design and adherence to the codified layout recipes.

| Check | Detects | Severity |
|-------|---------|----------|
| Overlapping boxes | Boxes sharing screen space (with 5px collision padding; comments and panels excluded) | warning |
| Missing midpoints | Horizontally offset or upward-flowing cables without midpoints | warning |
| Out-of-bounds placement | Boxes at negative x or y | warning |
| Low contrast text | Text below the WCAG AA 4.5:1 minimum against its effective background | warning (note when the background is assumed, or for a presentation/patching trade-off) |
| Presentation coverage | Interactive control missing from presentation mode in a patch that uses presentation | warning |

Every non-gen scope is checked: findings come top level first, nested scopes in pre-order, each with its `path`. The contrast check skips boxes that paint their own background in an unrecorded colour (`aesthetics.paints_unknown_background`: bach.roll, jit.cellblock, textedit, ...) and reads untinted number / flonum / textbutton boxes against their theme fills (`aesthetics.THEME_FILLS`). A "Low contrast text" finding on a comment without a `textcolor` is a known false positive: MAX renders it in the theme text colour, so do not recolour it.

### Package Critic (`package_critic.py`)

Reviews package-object conventions across the enabled packages.

| Check | Detects | Severity |
|-------|---------|----------|
| BEAP missing output | A BEAP source chain that never reaches an output module (`bp.Stereo`, `bp.Mono`, ...) | warning |
| BEAP missing VCA | A BEAP source reaching an output without a VCA / Level module | warning |
| Bach llll typing | A non-bach, non-command source feeding a `bach.*` llll inlet | note |
| Bach `@out` mode (`bach_out_mode`) | A bach object with native `@out n` output feeding a non-bach consumer (set `@out t`; each `@out` character maps to an llll outlet) | warning |
| Community extraction | Objects from a community package that has not been extracted to the DB | warning |
| Object not installed | An object marked `verified_installed: false` in the DB | blocker |

### M4L Critic (`m4l_critic.py`)

Reviews Max for Live devices. Only invoked when `detect_m4l_device_type` finds `plugin~`, `plugout~` or `live.thisdevice` in any non-gen scope. A patch whose only marker is `live.thisdevice` (no `plugin~` / `plugout~` / `midiin` / `midiout`) is `m4l_abstraction`, a helper abstraction: it gets the per-scope checks and parameter uniqueness only, and `export_amxd` refuses it without an explicit `kind=`. The per-scope checks walk every non-gen scope.

| Check | Detects | Severity |
|-------|---------|----------|
| Gain stage before `plugout~` | `gain~` / `live.gain~` on a signal path to `plugout~` (Live's channel strip handles volume) | blocker |
| `ezdac~` in a device | Any `ezdac~` in the device (every scope) | blocker |
| Missing required objects | Audio effects and instruments need `plugout~`; MIDI effects need `midiin` + `midiout` | blocker |
| Duplicate parameter names | Two boxes with the same `parameter_longname` (subpatchers included) | blocker |
| Empty parameter name | `parameter_enable` set without a `parameter_longname` | warning |
| Device presentation | Missing `openinpresentation=1` or `devicewidth` | warning |
| Parameter enable | Parameter-capable `live.*` control without `parameter_enable=1` | warning |
| Info text | Parameter control without info text (annotation) | warning |
| Push banks | Parameter controls but no `live.banks` | warning |
| Duplicate device I/O (`duplicate_device_io`) | Two `plugin~` / `plugout~` / `midiin` / `midiout` / `live.thisdevice` at the device's top scope (two pass-throughs double the signal) | warning |
| Stereo out (`stereo_out`) | A bare `plugout~` that gets signal on only one of its two inlets (a mono source should feed both) | warning |
| MIDI pass-through (`midi_passthrough`) | MIDI effects only: a `midiin` with no outgoing cord or a `midiout` with no incoming one | warning |
| Short name length (`shortname_length`) | `parameter_shortname` longer than 8 characters (Push / device title) | note |
| Short name unique (`shortname_unique`) | Two parameters with the same short name | warning |
| Int param range (`int_param_range`) | An Int parameter whose range spans more than 256 values | warning |
| Param range (`param_range`) | `parameter_mmin` >= `parameter_mmax`, or an initial value outside the range (checked only when `parameter_initial_enable` is set) | warning |
| Bank refs (`bank_refs`) | A `parameterbanks` entry naming a parameter the device does not have | warning |
| Device height (`device_height`) | Presentation content taller than a Live device (169 px) | warning |

### Critic Loop

`review_patch()` in `critics/__init__.py` wires **seven** critics into the review pass. DSP, structure and layout always run; RNBO, M4L, package and external run only when their trigger is present (`rnbo~` boxes, an M4L device object, package objects, or `ext_code`).

The `max-critic` agent orchestrates the generate-review-revise cycle:

1. Agent generates patch
2. `review_patch()` runs all applicable critics
3. If blockers found → agent receives findings and revises
4. Re-run critics on revised output
5. Loop continues until clean (no hard round limit)
6. Escalates after 5 consecutive identical findings

`review_patch(..., is_new=True)` is the build-loop call for a file that does not exist yet (the save gate reviews a file with no baseline that way, so an uninitialized control is a blocker there); edits keep the default `is_new=False`.

**Quick fixes.** Some findings carry a machine-applicable `CriticResult.fix` (Q39): an ordered `t ...` for a reconverging fan-out, `@param $1` -> `param $1` for gen~, a `scale` / `clip` before an unsafe gain, `@out t` on a bach object. `src/maxpat/quickfix.py` applies them through one `edit_patch` session, and `/max-iterate --fix` previews the semantic diff and applies the selected fixes.

---

## DSP Pre-Flight Simulation

`src/maxpat/dsp_sim/` (v5.0, Phase 32) is an **offline numpy waveguide-stability harness** that runs a patch's DSP topology numerically before it is ever opened in MAX. It is not a general audio preview — it targets specific reed/bore waveguide topologies and answers a single question: will this configuration oscillate stably, or misbehave?

### Public API

```python
run_simulation(*, patch_path=None, topology=None, mirror=None, params, sweep_param, sweep,
               sample_rate=44100, settle_ms=100, sweep_steps=None, ...) -> SimulationReport
```

Every argument is keyword-only (a positional call raises `TypeError`). Runs the simulation for a given topology (or a `mirror=` callable) and parameter set, sweeping one parameter across `sweep = (lo, hi, steps)`, and returns a `SimulationReport`.

### Classifier Verdicts

`classify()` emits one of five verdicts:

| Verdict | Meaning |
|---------|---------|
| `PASS` | Stable, self-sustaining oscillation |
| `PHASE_DRIFT` | Oscillation present but phase/pitch drifts |
| `MODE_COMPETITION` | Multiple modes competing (unstable timbre) |
| `NO_OSCILLATION` | Fails to start oscillating |
| `RUNAWAY` | Amplitude diverges (unstable) |

### Curated Topologies

Two waveguide topologies are supported: `reed_bore` and `reed_bore_post_radiation` (`get_topology(name)`; `bore_only` was removed in Q25 and now raises `TopologyError`).

### CLI

```bash
python3 -m src.maxpat.dsp_sim --patch <p> --topology <t> [--param ... --sweep ...]
```

Exit codes mirror the verdict priority so the harness can gate a build: `0` pass, `1` phase_drift, `2` mode_competition, `3` no_oscillation, `4` runaway, `64` usage error with nothing run (argparse errors, a malformed `--sweep` / `--params` / `--mirror`, an undeclared `--param`; BSD `EX_USAGE`, deliberately not 2). The `max-dsp-agent` skill gates waveguide patches on a matching `tests/dsp_sim/test_<stem>.py` (SKILL.md-level gate).

### Codebox smoke test (`smoke`)

```bash
python3 -m src.maxpat.dsp_sim smoke patches/<project>/generated/<name>.maxpat [--seconds S] [--input K=SPEC] [--json]
```

A general-purpose, advisory (never a save gate) GenExpr smoke test for any gen~ / mc.gen~ codebox (Q35), run by the pure-Python interpreter `dsp_sim.genexpr_interp` (no `eval` / `exec`). It runs each codebox at its Param corners with a stimulus per inlet and reports PASS / WARN / FAIL / UNSUPPORTED.

- **Port kinds come from the host patch** (`dsp_sim.host_graph`): an outlet that reaches `dac~`, `plugout~`, `out~`, `gain~` / `live.gain~`, a meter or a recorder through signal consumers (following `send~` / `receive~`, subpatchers, abstractions and downstream gen~ dataflow) is **audio** and gets every check (peak, silence, self-sustain, DC, NaN / inf, denormal); any other outlet is **control** (Hz, ms, indices, flags) and gets only the NaN / inf FAIL and the `denormal` WARN. Inlets are traced upstream: `click~` / signal comparisons give a trigger (`gate`) stimulus, `sig~` / `line~` / `curve~` / `adsr~` a control one, an unconnected inlet zero, anything else audio noise.
- A standalone `.gendsp` finds its host among sibling `.maxpat` files; with no host every port is audio. A `// smoke:` comment in the codebox overrides the inferred kinds: `// smoke: control out2 trigger in1 in3=phasor:2`.
- A silence hit triggers a louder rerun; it is a FAIL only if that also stays silent, otherwise a `silence` WARN.
- Build-time WARN lints: `loop_bound_param` (a `for` bound reads a Param / `samplerate`), `hoist_alias`, `implicit_channel` (`peek` / `poke` without the channel), `smoke_directive` (an unusable `// smoke:` token), `output_typo` (only on locals never read).
- Exit codes: `0` all passed (warnings allowed), `1` any FAIL, `2` usage or read error, `3` an unsupported codebox (and no FAIL) or nothing to smoke. Full reference: `src/maxpat/dsp_sim/README.md`.

---

## Code Generation

`src/maxpat/codegen.py` provides functions for generating Gen~ DSP code and JavaScript.

### GenExpr (`build_genexpr`)

Builds formatted GenExpr code with proper section ordering:

```
// === PARAMETERS ===
Param cutoff(1000, min=20, max=20000);
Param resonance(0.5, min=0, max=1);

// === DSP ===
out1 = in1 * cutoff;
```

**Critical rule**: All declarations (`Param`, `History`, `Delay`, `Buffer`, `Data`) must appear before any expressions, and user functions come before both. The validator enforces this (a function after a statement is an error), and `reorder_genexpr_declarations` (used by `add_gen`) emits functions, then declarations, then statements.

### Gen~ Patcher (`generate_gendsp`)

Generates complete `.gendsp` JSON structure:
- Creates `in` objects (top row), `codebox` (middle), `out` objects (bottom row)
- Connects `in` → codebox inlets, codebox outlets → `out`
- Auto-detects I/O count from code if not specified; the codebox is written with `numinlets: max(1, n_in)`
- Returns `{"patcher": {...}}` ready for JSON serialization

Editing an existing `.gendsp` goes through `write_gendsp(code, path, num_inputs=None, num_outputs=None, *, force=False)` instead: codebox fields are written only when they change (unchanged code is a byte-identical no-op), auto-detected counts never shrink ports (pass explicit counts to remove `in N` / `out N` boxes), and added port boxes step right along the port row until they clear every box.

### RNBO (`add_rnbo`, `generate_rnbo_wrapper`)

**Experimental:** not yet confirmed in MAX. `add_rnbo` builds a newobj `rnbo~` with `max(1, #in~)` inlets and `#out~ + 1` outlets (the last one a `list` outlet), writes `inletInfo` / `outletInfo`, sets the inner patcher's `classnamespace` to `rnbo`, and writes params in the positional form `param <name> <initial> @min <lo> @max <hi>`. The shapes are pinned against 7 MAX-saved boxes from the Max 9.2 RNBO help patches (`tests/fixtures/expected/rnbo_box_shapes.json`).

### Node for Max (`generate_n4m_script`)

Generates Node.js scripts for `node.script`:
- Includes `const maxAPI = require("max-api")`
- Creates `maxAPI.addHandler()` registrations from handler definitions
- Generates async dict getter/setter helpers with error handling

### js Object (`generate_js_script`)

Generates ES5 JavaScript for `js` objects (Legacy Engine; `v8` is the separate Modern Engine object):
- Declares `inlets = N` and `outlets = N`
- Creates handler functions: `bang()`, `msg_int(v)`, `msg_float(v)`, `list()`, `anything`. Handler bodies must read the selector from `messagename` and the values via `arrayfromargs(arguments)` -- MAX passes neither as a named parameter
- Default handlers output to outlet 0

---

## Layout Engine

`src/maxpat/layout.py` automatically positions boxes for readable top-to-bottom signal flow.

### Algorithm (`apply_layout`)

1. **Build graph** — adjacency lists and in-degree counts from patchlines
2. **Detect components** — undirected BFS finds independent signal chains
3. **Topological sort** — Kahn's algorithm assigns boxes to rows; source nodes (in-degree 0) at top
4. **Row layout** — each topological level becomes a horizontal row stacking top-to-bottom
5. **Within-row ordering** — sorts by average parent x-position to minimize cable crossings
6. **UI extraction** — identifies controls (toggle, slider, dial) and positions them above their targets
7. **Midpoint generation** — creates L-shaped cable routes for backward-direction connections
8. **Disconnected objects** — places unconnected boxes to the right of main components
9. **Recursive layout** — applies layout to inner patchers (subpatchers, gen~, bpatchers)
10. **Presentation mode** — grid layout for boxes with `presentation=True`

### Spacing Constants

| Constant | Value | Purpose |
|----------|-------|---------|
| `V_SPACING` | 20px | Vertical gap between rows (`defaults.py`) |
| `H_GUTTER` | 15px | Horizontal gap between objects in a row (`defaults.py`) |
| `COMPONENT_GAP` | 40px | Gap between independent signal chains (`layout.py`) |
| `START_X` / `START_Y` | 30px | Top-left margin (`layout.py`) |
| `PATCHER_PADDING` | 40px | Padding around content for the auto-sized patcher rect (`defaults.py`) |

### Presentation Mode

Boxes with `presentation: 1` are separately laid out in a grid for the patch's presentation view. The layout engine preserves any `presentation_rect` values set before layout runs.

---

## Project Lifecycle

Projects follow a structured workflow managed by `src/maxpat/project.py` and the `max-lifecycle` agent.

### Stages

| Stage | Description | Triggered By |
|-------|-------------|-------------|
| **ideation** | Initial concept capture | `/max-new` |
| **discuss** | Design conversation, decisions recorded | `/max-discuss` |
| **research** | Technique research, object selection | `/max-research` |
| **build** | Patch and code generation | `/max-build` |
| **verify** | Validation and manual testing | `/max-verify`, `/max-test` |

### Project Directory Structure

```
patches/{project-name}/
├── context.md          # Vision, requirements, decisions, research notes
├── status.md           # Current stage, progress %, timestamps
├── generated/          # All output from agents
│   ├── *.maxpat        # MAX patches
│   ├── *.gendsp        # Gen~ patches
│   └── *.js            # Node for Max or js scripts
└── test-results/       # Manual test records
    └── <test_name>.md  # Checklist with Pass/Fail markings (rewritten on each save)
```

### Active Project Tracking

`patches/.active-project.json` tracks which project is currently active:

```json
{"name": "my-synth", "activated": "2026-03-12T10:30:00Z"}
```

All generation commands operate on the active project. Switch with `/max-switch`.

### Test Protocol

`/max-test` generates a manual test checklist based on detected objects in the patch. For example, a patch containing `dac~`, `cycle~`, and `slider` would generate:

```
[ ] 1. Open patch — verify no errors in MAX console
[ ] 2. Enable dac~ — no audio distortion or unexpected sound
[ ] 3. Adjust slider — value changes reflected in connected objects
[ ] 4. Listen to cycle~ output — clean sine tone at expected frequency
```

Results are saved by `save_test_results(project_dir, test_name, ...)` to `test-results/<test_name>.md`; saving the same test name again overwrites it.

### Live check in MAX (`/max-verify --live`)

`tools/max_verify_live.py` loads each top-level patch into the running MAX 9.2 through the max-bridge (`tools/max_bridge.py`; open the bridge patch `tools/max_bridge/max-bridge.maxpat` once, which ships in releases) and maps every `max_bridge.py check` report to blocker / warning / note findings (console errors, NaN / runaway output, clipping, ...). Live findings are report-only: never part of the save gate. A file that is not a readable patch is listed as `refused` (`cannot read <path>: ...`) and the batch continues. Exit codes: 0 notes only; 1 any live blocker or warning; 2 skipped, aborted or a usage error. Severity table: `.claude/skills/references/severity-contract.md` section 7.

---

## Test Suite

The project includes 7,509 tests across 134 test files covering all modules (`python3 -m pytest --collect-only -q`; 6.0.0). Run with:

```bash
python3 -m pytest tests/ -v
```

Key test areas:
- Patcher/Box/Patchline creation and serialization
- Round-trip load-save preservation (byte-identical for all project patches)
- Search and mutation primitives (find, add, remove, connect)
- Intelligent editing (modify, insert, replace, graph queries)
- Patch analysis (inventory, sections, signal chains, complexity)
- Layout engine (topological ordering, component detection, midpoints)
- All validation layers (structure, object existence + sub-layers, signal-role-aware connections, domain rules + restriction guard, embedded GenExpr)
- Code validation (GenExpr, js, N4M)
- All seven wired critics (structure, DSP, layout, RNBO, M4L, external, package)
- DSP pre-flight simulation (topologies, classifier verdicts, CLI exit codes) and the codebox smoke test (port inference, directives, a pinned verdict for every committed gen~ codebox)
- Object database schema and lookup, including v5.0 schema-hardening fields and audit accessors
- RNBO database and validation
- Write hooks and file operations

---

## Release

`.github/workflows/release.yml` runs on full semver tags only (`vX.Y.Z`). The release job needs the test workflow (Python 3.10 and 3.12 plus a `vermin` 3.10-floor check), then:

1. builds the archive with `scripts/build_release.sh` (`git archive` of the tag, governed by the anchored `.gitattributes` export-ignore rules: `.planning/`, `tests/`, `patches/`, `scripts/`, `installer/` and `.github/` never ship);
2. extracts the tag's `CHANGELOG.md` section with `scripts/release_notes.sh` (a tag without a section fails here, before anything is published);
3. stamps the installer version from the tag, runs `npm publish --dry-run`, then publishes `create-max-framework` with npm **trusted publishing** (OIDC, `npm publish --provenance --access public`; no `NPM_TOKEN` secret; Node 24 and npm >= 11.5.1). A re-run skips a version already on npm;
4. creates the GitHub release with the archive and the changelog section as its body.

The trusted publisher is linked on npmjs.com (`create-max-framework` -> Settings -> Trusted Publisher -> GitHub Actions, workflow `release.yml`, no environment).
