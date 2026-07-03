# Technical Documentation

This document covers the internals of the MAX/MSP Claude Code Framework — the object database, agent system, validation pipeline, code generation, layout engine, and memory system.

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
- [Memory System](#memory-system)
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
│   Critic Loop    │  Semantic review (DSP, structure, layout, RNBO, C++, package)
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
| `max/objects.json` | Control, data, UI, MIDI, OSC | 471 | Core MAX objects |
| `msp/objects.json` | Audio, signal processing | 246 | All MSP~ objects |
| `jitter/objects.json` | Video, matrix, OpenGL | 218 | Jitter pipeline |
| `mc/objects.json` | Multichannel wrappers | 222 | MC signal routing |
| `gen/objects.json` | Gen~ DSP operators | 189 | GenExpr operators |
| `m4l/objects.json` | Max for Live | 35 | Live API objects |
| `rnbo/objects.json` | RNBO export-compatible | 560 | Export-safe subset |

**Core domains: 1,941 objects across 7 files.**

Package objects no longer live in a single `packages/objects.json`. As of v4.0 package integration they are stored as **29 per-package files** under `.claude/max-objects/packages/<Name>/objects.json` (BEAP, Vizzie, FluCoMa, CNMAT, Bach, and more), totaling **1,489 objects** with per-package source tracking.

**Grand total: 3,430 objects** (1,941 core + 1,489 package).

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
  "min_version": 8,
  "verified": true,
  "variable_io": true,
  "io_rule": {
    "inlet_count": "fixed:1",
    "outlet_count": "arg_count",
    "default_outlets": 2,
    "description": "Number of arguments determines outlets. Default: 2."
  },
  "rnbo_compatible": true
}
```

Key fields:
- **`inlets`/`outlets`**: Arrays with `id`, `type`, `signal` (bool), `hot` (inlets only)
- **`variable_io`**: If `true`, actual I/O count depends on arguments — use `io_rule` formulas
- **`rnbo_compatible`**: Whether the object can be used in RNBO export patches
- **`min_version`**: Minimum MAX version required (all patches target MAX 9)

#### Schema-Hardening Fields (v5.0, Phase 28)

The v5.0 schema delta added three curated fields, validated fail-fast at load by `_validate_schema_extensions` (which runs after the deep-merge of `overrides.json`):

- **`signal_role`**: Per-outlet closed enum describing what the outlet actually carries. The loader projects it onto the legacy `outlet['signal']` bool via `_apply_signal_role_writethrough` (`signal_role == "audio"` → `signal: true`), so **`signal: bool` is now a derived back-compat shim** rather than authoritative data. Removal of the shim is scheduled for v6.0+.
- **`domain_restricted`**: Per-object list of domain enums marking objects that are only valid inside specific domains.
- **`verified_installed`**: Per-object strict bool recording whether the object was confirmed present in an actual installation (as opposed to community-extracted stub metadata).

### Variable I/O Rules

Objects with `variable_io: true` change inlet/outlet count based on arguments. The `io_rule` field contains formulas:

| Formula | Meaning | Example |
|---------|---------|---------|
| `arg_count` | One I/O per argument | `trigger b i f` → 3 outlets |
| `arg_count+1` | Arguments plus one extra | `route foo bar` → 3 outlets (2 match + 1 unmatched) |
| `fixed:N` | Always N regardless of args | `pack` always has 1 outlet |
| `first_arg` | First argument is the count | `gate 3` → 3 outlets |
| `second_arg` | Second argument is the count | `matrix~ 4 2` → 2 outlets |

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
- **`variable_io_rules`**: Formulas for computing I/O counts from arguments

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
| **max-rnbo-agent** | RNBO export | `.maxpat` | Only `rnbo_compatible` objects, self-contained patches, target constraints |
| **max-js-agent** | JavaScript | `.js` | N4M uses CommonJS (`require`), js V8 uses global scope |
| **max-ui-agent** | UI layout | `.maxpat` modifications | Presentation mode attributes, spacing rules |
| **max-ext-agent** | C++ externals | `.cpp`, `.mxo` | Min-DevKit scaffolding, cmake/make build loop, Mach-O validation |

### Support Agents

| Agent | Role | Behavior |
|-------|------|----------|
| **max-critic** | Quality assurance | Orchestrates generate-review-revise loop using Python critics. No hard round limit — loops until clean. |
| **max-lifecycle** | Project management | Creates projects, tracks stages (ideation → discuss → research → build → verify), generates test checklists |

> **No memory agent.** There is no `max-memory-agent` skill. Memory persistence is a **library only**: the `MemoryStore` API (`src/maxpat/memory.py`) and `patterns.md` files remain available, but nothing auto-injects memory into generation or writes new patterns back automatically.

---

## Python Engine

`src/maxpat/` contains the core Python library (~18,600 LOC).

### Core Classes (`patcher.py`)

**Patcher** — Container for boxes and patchlines:

| Method | Purpose |
|--------|---------|
| `from_dict(data)` | Load a `.maxpat` JSON dict into Patcher/Box/Patchline objects (recursive subpatchers) |
| `to_dict()` | Serialize to complete `.maxpat` JSON structure (round-trip safe) |
| `add_box(name, args, x, y)` | Create and add a Box (auto-generates ID, validates against DB) |
| `add_comment(text, x, y)` | Create comment box |
| `add_message(text, x, y)` | Create message box |
| `add_connection(src, outlet, dst, inlet)` | Create patchline between boxes (with bounds checking) |
| `add_subpatcher(name, inlets, outlets, x, y)` | Create embedded subpatcher with inlet/outlet objects |
| `add_bpatcher(filename, args, x, y)` | Create bpatcher (file reference or embedded) |
| `add_gen(code, inputs, outputs, x, y)` | Create gen~ with embedded codebox |
| `add_node_script(filename, code, outlets, x, y)` | Create node.script box |
| `add_js(filename, code, inlets, outlets, x, y)` | Create js object box |
| `find_box(query, by, recursive)` | Find first matching box by id, name, maxclass, or text |
| `find_boxes(query, by, recursive)` | Find all matching boxes |
| `remove_box(box)` | Remove box and all connected patchlines |
| `remove_connection(src, outlet, dst, inlet)` | Remove a specific patchline |
| `modify_box(box, **attrs)` | Modify box attributes in-place (with I/O recomputation) |
| `insert_into_connection(patchline, name, args)` | Insert new object into an existing connection |
| `replace_box(old_box, name, args)` | Replace object, remap compatible connections |
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
| `replace_box_safe(old_box, new_name, *, args=None, rewire="auto") -> EditResult` | Replace a box and auto-rewire orphaned connections by index when the new I/O layout matches |
| `add_m4l_gen_synth(params, *, gen_varname="synth", gen_code=None) -> (gen_obj, [live_dial, ...], plugout_obj)` | Build a Live-ready M4L gen-synth skeleton (`live.dial`↔`Param` via `param_connect`; no `gain~` before `plugout~`) |

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
| `save_patch_roundtrip(patcher, path)` | Write back with lossless preservation (key order, numeric precision, trailing newline) |

### Patch Analysis (`analysis.py`)

`analyze(patcher)` produces a 7-facet structured summary:
- **Inventory** — object counts by domain (MAX, MSP, Jitter, MC, Gen~, etc.)
- **Sections** — functional groups detected by connected components and spatial proximity
- **Signal chains** — audio paths from sources to `dac~`
- **Control flow** — notable control paths (loadbang, metro, MIDI origins)
- **Hierarchy** — subpatcher/bpatcher/gen~ nesting map
- **Parameters** — user-controllable parameters (sliders, dials, number boxes)
- **Complexity** — object count, connection count, nesting depth, domain spread

---

## Validation Pipeline

Every generated patch passes through a 5-layer validation pipeline (`src/maxpat/validation.py`), several layers with sub-layers. The pipeline runs on demand via `validate_patch()` (see write hooks below).

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

**Severity**: error

### Layer 3: Connection Validation

Validates all patchlines:
- **Outlet bounds**: source outlet index < source object's outlet count
- **Inlet bounds**: destination inlet index < destination object's inlet count
- **Signal compatibility**: signal-type checks now consult the curated `signal_role` metadata — signal outlets only connect to signal-accepting inlets (exception: `signal/float` inlets accept both)

**Severity**: error with **auto-fix** — invalid connections are removed in-place

### Layer 4: Domain-Specific Rules

Semantic checks for common MAX pitfalls:

| Check | What It Catches | Severity |
|-------|----------------|----------|
| Compound `#N` substitution | `buffer~ slot-#1` instead of `buffer~ #1` | warning |
| Unterminated signal chains | MSP objects with signal outlets going nowhere | warning |
| Missing gain staging | Oscillator → `dac~` without `*~` or `gain~` in between | warning |
| Feedback loops | Signal cycles without delay objects (`tapin~`/`tapout~`/`gen~`) | warning |
| Maxclass mismatch | `newobj` maxclass on non-UI objects that should use specific maxclass | warning |
| External .gendsp I/O mismatch | Gen~ box I/O count doesn't match referenced .gendsp file | warning |
| MC oscillator gain staging | MC oscillators reaching mc.dac~ without gain control | warning |

**Layer 4b — domain-restriction guard (VALID-02)**: flags objects used outside the domains listed in their `domain_restricted` metadata.

### Layer 5: Embedded GenExpr Codebox Walker (VALID-04)

Walks embedded `gen~` codebox contents inside the patch and applies GenExpr checks (declaration ordering, operator existence, balanced structure) to code that lives inline in the `.maxpat` rather than in a standalone `.gendsp` file.

### Blocking Behavior

Only **unfixed errors** block output. Auto-fixed errors (Layer 3 connection removal) and all warnings/info are non-blocking. The `has_blocking_errors()` function determines whether a patch can be written to disk.

### Code Validation

Separate validators for code files (`src/maxpat/code_validation.py`). These are **report-only** — they never block output.

**GenExpr** (`validate_genexpr`):
- Balanced braces
- Semicolons on statement lines
- Declaration ordering (all `Param`/`History`/`Delay`/`Buffer`/`Data` before expressions)
- Operator existence in gen~ database

**js V8** (`validate_js`):
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

`src/maxpat/hooks.py` automatically triggers validation when writing files:

| Function | Validates | Blocks on Error |
|----------|-----------|----------------|
| `save_patch_roundtrip(patcher, path)` | Lossless round-trip; auto-commits to git via `auto_commit_patch()` | No |
| `write_gendsp(code, path)` | Auto-commits to git | No |
| `write_js(code, path)` | Code validation (report-only); auto-commits to git | No |

Validation is run on demand via `validate_patch()` rather than automatically on every save — this avoids rejecting third-party objects on load-edit-save cycles.

---

## Critic System

Critics perform **semantic review** that structural validation cannot detect. They answer "is this well-designed?" rather than "is this structurally correct?"

Critics live in `src/maxpat/critics/` and are coordinated by the `review_patch()` function in `critics/__init__.py`.

### Severity Levels

| Severity | Meaning | Action |
|----------|---------|--------|
| **blocker** | Design defect preventing correctness | Triggers revision in critic loop |
| **warning** | Non-optimal pattern or best-practice violation | Annotated, no revision |
| **note** | Informational finding | FYI only |

### Structure Critic (`structure_critic.py`)

Reviews patch architecture and connection patterns.

| Check | Detects | Severity |
|-------|---------|----------|
| Fan-out without trigger | Outlet connected to 2+ destinations without explicit `trigger` object | warning |
| Hot/cold inlet ordering | Multiple sources feeding one object without trigger-based ordering | warning |
| Redundant connections | Duplicate patchlines (same source outlet → same destination inlet) | warning |

### DSP Critic (`dsp_critic.py`)

Reviews signal flow semantics.

| Check | Detects | Severity |
|-------|---------|----------|
| gen~ I/O mismatch | GenExpr code declares different I/O count than gen~ box | blocker |
| Gain staging | Oscillator reaching `dac~` without gain control | warning |
| Audio rate consistency | Control-rate object feeding signal inlet | warning |
| MIDI-range gain values | Raw 0-127 values feeding `*~` or `gain~` without normalization | blocker |

### RNBO Critic (`rnbo_critic.py`)

Reviews RNBO export design. Only invoked when `rnbo~` boxes are detected.

| Check | Detects | Severity |
|-------|---------|----------|
| Missing I/O | No `in~` or `out~` in inner RNBO patcher | blocker |
| Param naming | Params not using `snake_case` convention | warning |
| Duplicate params | Multiple params with same `@name` | blocker |
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
| Overlapping boxes | Non-overlay boxes sharing screen space | warning |
| Off-canvas objects | Boxes positioned outside the visible patch area | warning |
| Companion misalignment | Readouts/labels not aligned with their target controls | warning |

### Package Critic (`package_critic.py`)

Reviews package-object conventions across the enabled packages.

| Check | Detects | Severity |
|-------|---------|----------|
| BEAP signal standards | BEAP objects wired outside their expected signal conventions | warning |
| Bach llll typing | `bach.*` objects fed plain-MAX types without `@out t` | warning |
| Community extraction | Use of community-extracted objects not verified against an install | warning |

### Critic Loop

`review_patch()` in `critics/__init__.py` wires **six** critics into the review pass: DSP, structure, layout, RNBO, external, and package. (An `m4l_critic.py` module exists but is **not** called by `review_patch()`.)

The `max-critic` agent orchestrates the generate-review-revise cycle:

1. Agent generates patch
2. `review_patch()` runs all applicable critics
3. If blockers found → agent receives findings and revises
4. Re-run critics on revised output
5. Loop continues until clean (no hard round limit)
6. Escalates after 5 consecutive identical findings

---

## DSP Pre-Flight Simulation

`src/maxpat/dsp_sim/` (v5.0, Phase 32) is an **offline numpy waveguide-stability harness** that runs a patch's DSP topology numerically before it is ever opened in MAX. It is not a general audio preview — it targets specific reed/bore waveguide topologies and answers a single question: will this configuration oscillate stably, or misbehave?

### Public API

```python
run_simulation(patch_path, topology, params, sweep_param, sweep) -> SimulationReport
```

Runs the simulation for a given topology and parameter set, optionally sweeping one parameter across a range, and returns a `SimulationReport`.

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

Three waveguide topologies are supported: `bore_only`, `reed_bore`, and `reed_bore_post_radiation`.

### CLI

```bash
python3 -m src.maxpat.dsp_sim --patch <p> --topology <t> [--param ... --sweep ...]
```

Exit codes mirror the verdict priority so the harness can gate a build. The `max-dsp-agent` skill gates waveguide patches on a matching `tests/dsp_sim/test_<stem>.py` (SKILL.md-level gate).

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

**Critical rule**: All declarations (`Param`, `History`, `Delay`, `Buffer`, `Data`) must appear before any expressions. The validator enforces this.

### Gen~ Patcher (`generate_gendsp`)

Generates complete `.gendsp` JSON structure:
- Creates `in` objects (top row), `codebox` (middle), `out` objects (bottom row)
- Connects `in` → codebox inlets, codebox outlets → `out`
- Auto-detects I/O count from code if not specified
- Returns `{"patcher": {...}}` ready for JSON serialization

### Node for Max (`generate_n4m_script`)

Generates Node.js scripts for `node.script`:
- Includes `const maxAPI = require("max-api")`
- Creates `maxAPI.addHandler()` registrations from handler definitions
- Generates async dict getter/setter helpers with error handling

### js Object (`generate_js_script`)

Generates V8 JavaScript for `js` objects:
- Declares `inlets = N` and `outlets = N`
- Creates handler functions: `bang()`, `msg_int(v)`, `msg_float(v)`, `list()`, `anything(msg)`
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
| `V_SPACING` | 100px | Vertical gap between rows |
| `H_GUTTER` | 70px | Horizontal gap between columns |
| `COMPONENT_GAP` | 120px | Gap between independent signal chains |
| `START_X` / `START_Y` | 30px | Top-left margin |

### Presentation Mode

Boxes with `presentation: 1` are separately laid out in a grid for the patch's presentation view. The layout engine preserves any `presentation_rect` values set before layout runs.

---

## Memory System

A dual-scope persistent memory **library** (`src/maxpat/memory.py`) is available for storing patterns across sessions.

> **Library, not agent.** There is no memory agent, and nothing drives auto-inject or auto-write-back. `MemoryStore` is a plain API — code that wants to persist or recall patterns calls it explicitly.

### Scopes

| Scope | Location | Contains |
|-------|----------|----------|
| **Global** | `~/.claude/max-memory/` | Cross-project patterns, organized by domain subdirectories |
| **Project** | `patches/{project}/.max-memory/` | Project-specific patterns in a single `patterns.md` file |

### Memory Entry

```python
MemoryEntry(
    pattern: str,    # Pattern name (e.g., "prefer line~ for gain control")
    domain: str,     # Domain category (dsp, patch, ui, js, routing, layout, node)
    observed: str,   # ISO date when pattern was observed
    context: str,    # How/where it was discovered
    rule: str        # Actionable rule for future generations
)
```

### Behavior

- **Manual inject/recall**: There is no automatic injection. A caller reads project memory plus domain-filtered global memory via `MemoryStore.read()` when it wants prior patterns as context.
- **Manual write-back**: New patterns are persisted only when a caller explicitly invokes `MemoryStore.write()` — nothing writes back automatically after generation.
- **Deduplication**: Entries are deduplicated by pattern name (case-insensitive) within the same domain

### MemoryStore API

| Method | Purpose |
|--------|---------|
| `write(entry)` | Append entry (returns `False` if duplicate) |
| `read(domain=None)` | Read entries, optionally filtered by domain |
| `list_domains()` | List all domains with stored entries |
| `delete(pattern, domain)` | Remove entry by pattern name |

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
├── .max-memory/
│   └── patterns.md     # Project-specific learned patterns
├── generated/          # All output from agents
│   ├── *.maxpat        # MAX patches
│   ├── *.gendsp        # Gen~ patches
│   └── *.js            # Node for Max or js scripts
└── test-results/       # Manual test records
    └── test-001.md     # Checklist with Pass/Fail markings
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

Results are saved to `test-results/` for tracking.

---

## Test Suite

The project includes 2,034 tests across 46 test files covering all modules. Run with:

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
- All six wired critics (structure, DSP, layout, RNBO, external, package)
- DSP pre-flight simulation (topologies, classifier verdicts, CLI exit codes)
- Object database schema and lookup, including v5.0 schema-hardening fields and audit accessors
- RNBO database and validation
- Memory store operations
- Write hooks and file operations
