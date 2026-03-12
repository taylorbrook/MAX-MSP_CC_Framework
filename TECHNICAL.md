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
- [Code Generation](#code-generation)
- [Layout Engine](#layout-engine)
- [Memory System](#memory-system)
- [Project Lifecycle](#project-lifecycle)

---

## Architecture Overview

The framework has three core layers that work together during patch generation:

```
User Request
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
│  Lead  │ │ Support│  generate patches using the Python engine
└────┬───┘ └───┬────┘
     │         │
     ▼         ▼
┌─────────────────┐
│  Python Engine   │  Patcher/Box/Patchline classes, ObjectDatabase,
│  (src/maxpat/)   │  layout, code generation
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   Validation     │  4-layer structural validation (auto-fixes where safe)
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   Critic Loop    │  Semantic review (DSP, structure, RNBO, C++)
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
| `max/objects.json` | Control, data, UI, MIDI, OSC | 470 | Core MAX objects |
| `msp/objects.json` | Audio, signal processing | 248 | All MSP~ objects |
| `jitter/objects.json` | Video, matrix, OpenGL | 210 | Jitter pipeline |
| `mc/objects.json` | Multichannel wrappers | 215 | MC signal routing |
| `gen/objects.json` | Gen~ DSP operators | 189 | GenExpr operators |
| `m4l/objects.json` | Max for Live | 33 | Live API objects |
| `rnbo/objects.json` | RNBO export-compatible | 560 | Export-safe subset |
| `packages/objects.json` | Package objects | 87 | Third-party packages |

**Total: 2,015 objects**

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

**Load order**: `rnbo → packages → m4l → gen → mc → jitter → msp → max`. Later domains override earlier ones, so core MAX definitions take precedence.

---

## Agent System

The framework uses 10 specialist agents defined in `.claude/skills/`. Each agent has access to the object database and Python engine.

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
| **max-memory-agent** | Pattern persistence | Auto-injects relevant memory before generation, writes back new patterns after successful generation |

---

## Python Generation Engine

`src/maxpat/` contains the core Python library (24 modules, ~16,500 LOC).

### Core Classes (`patcher.py`)

**Patcher** — Container for boxes and patchlines:

| Method | Purpose |
|--------|---------|
| `add_box(name, args, x, y)` | Create and add a Box (auto-generates ID, validates against DB) |
| `add_comment(text, x, y)` | Create comment box |
| `add_message(text, x, y)` | Create message box |
| `add_connection(src, outlet, dst, inlet)` | Create patchline between boxes |
| `add_subpatcher(name, inlets, outlets, x, y)` | Create embedded subpatcher with inlet/outlet objects |
| `add_bpatcher(filename, args, x, y)` | Create bpatcher (file reference or embedded) |
| `add_gen(code, inputs, outputs, x, y)` | Create gen~ with embedded codebox |
| `add_node_script(filename, code, outlets, x, y)` | Create node.script box |
| `add_js(filename, code, inlets, outlets, x, y)` | Create js object box |
| `to_dict()` | Serialize to complete `.maxpat` JSON structure |

**Box** — Individual MAX object:
- Resolves object name through ObjectDatabase (enforces Rule #1)
- Computes `numinlets`, `numoutlets`, `outlettype` from database
- Auto-sizes based on object name and argument text width
- Stores position in `patching_rect = [x, y, width, height]`

**Patchline** — Connection between two boxes:
- Stores source/destination box IDs and outlet/inlet indices
- Supports midpoints for L-shaped cable routing
- Serializes to `{"patchline": {...}}` format

---

## Validation Pipeline

Every generated patch passes through a 4-layer validation pipeline (`src/maxpat/validation.py`). The pipeline runs automatically via write hooks (`hooks.py`).

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

**Severity**: error

### Layer 3: Connection Validation

Validates all patchlines:
- **Outlet bounds**: source outlet index < source object's outlet count
- **Inlet bounds**: destination inlet index < destination object's inlet count
- **Signal compatibility**: signal outlets only connect to signal-accepting inlets (exception: `signal/float` inlets accept both)

**Severity**: error with **auto-fix** — invalid connections are removed in-place

### Layer 4: Domain-Specific Rules

Semantic checks for common MAX pitfalls:

| Check | What It Catches | Severity |
|-------|----------------|----------|
| Compound `#N` substitution | `buffer~ slot-#1` instead of `buffer~ #1` | warning |
| Unterminated signal chains | MSP objects with signal outlets going nowhere | warning |
| Missing gain staging | Oscillator → `dac~` without `*~` or `gain~` in between | warning |
| Feedback loops | Signal cycles without delay objects (`tapin~`/`tapout~`/`gen~`) | warning |

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
| `write_patch(patcher, path)` | Full 4-layer pipeline | Yes — raises `PatchValidationError` |
| `write_gendsp(code, path)` | None (write-only) | No |
| `write_js(code, path)` | Code validation (report-only) | No |

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

### Critic Loop

The `max-critic` agent orchestrates the generate-review-revise cycle:

1. Agent generates patch
2. `review_patch()` runs all applicable critics
3. If blockers found → agent receives findings and revises
4. Re-run critics on revised output
5. Loop continues until clean (no hard round limit)
6. Escalates after 5 consecutive identical findings

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

The framework learns patterns across sessions using a dual-scope persistent memory system (`src/maxpat/memory.py`).

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

- **Auto-inject**: Before generation, the memory agent loads all project memory plus domain-filtered global memory and provides it as context to the generating agent
- **Auto-write-back**: After successful generation, the memory agent identifies genuinely new patterns and writes them back
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

The project includes 626 tests across 27 test files covering all modules. Run with:

```bash
python3 -m pytest tests/ -v
```

Key test areas:
- Patcher/Box/Patchline creation and serialization
- Layout engine (topological ordering, component detection, midpoints)
- All validation layers (structure, bounds, signal flow, domain rules)
- Code validation (GenExpr, js, N4M)
- All critics (structure, DSP, RNBO, external)
- Object database schema and lookup
- RNBO database and validation
- Memory store operations
- Write hooks and file operations
