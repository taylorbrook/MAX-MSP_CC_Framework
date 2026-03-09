# Architecture Patterns

**Domain:** Claude Code development framework for MAX/MSP
**Researched:** 2026-03-08
**Confidence:** HIGH (architecture modeled after proven Plugin Freedom System; MAX/MSP format derived from reverse-engineering and py2max)

## Recommended Architecture

The MaxSystem framework lives entirely within `.claude/` and orchestrates Claude's ability to generate valid MAX/MSP patches, Gen~/RNBO~ code, JavaScript for Node for Max/js, and C/C++ externals. It adapts the Plugin Freedom System's proven patterns -- agents, skills, hooks, schemas, templates, critics, agent-memory -- to MAX/MSP's unique challenges: visual patch graphs stored as JSON, spatial layout, and a massive object ecosystem with undocumented format specifications.

### High-Level Structure

```
.claude/
  settings.json              # Hook wiring + preferences
  settings.local.json        # Local overrides (gitignored)
  system-config.json         # Platform detection (MAX path, SDK paths)
  preferences.json           # Workflow mode (express/manual)

  agents/                    # Domain-specialized subagents
  skills/                    # Orchestration + lifecycle skills
  hooks/                     # Python scripts for Claude Code hook events
    validators/              # Validation scripts invoked by hooks
  commands/                  # Slash commands
  schemas/                   # JSON schemas for contracts + reports
  critics/                   # Domain critic definitions
  agent-memory/              # Persistent learned patterns per agent
  templates/                 # Reusable patch/code patterns
    patch-patterns/          # .maxpat JSON snippets
    gen-code/                # GenExpr code templates
    rnbo-patterns/           # RNBO subpatcher templates
    n4m-code/                # Node for Max JavaScript templates
    external-code/           # C/C++ external templates
  references/                # Object database + domain knowledge
    object-db/               # MAX object definitions (JSON)
    gen-operators/           # Gen~ operator reference
    rnbo-operators/          # RNBO operator reference
  scripts/                   # Utility scripts (template lookup, DB query)

projects/                    # Per-project isolation (outside .claude/)
  [ProjectName]/
    .planning/               # Project-level planning docs
      BRIEF.md               # What we're building
      ARCHITECTURE.md        # Patch architecture
      ROADMAP.md             # Build plan
      STATUS.md              # Current state (stage, checksums)
      research/              # Project-specific research
    patches/                 # Generated .maxpat files
    code/                    # Gen~ / RNBO~ / js / N4M code
    externals/               # C/C++ external source
      build/                 # CMake build artifacts
    tests/                   # Validation results + manual test protocols
```

### Component Boundaries

| Component | Responsibility | Communicates With |
|-----------|---------------|-------------------|
| **Agents** | Domain-specialized execution (patching, DSP/Gen~, RNBO, N4M/js, externals, layout) | Skills (invoked by), Schemas (report format), Agent-Memory (read/write), Templates (read), References/Object-DB (read) |
| **Skills** | Orchestration, lifecycle management, project workflows | Agents (invoke via Task), Hooks (trigger), Commands (entry points), Schemas (contract validation) |
| **Hooks** | Automated validation at Claude Code lifecycle points (PostToolUse, SubagentStart/Stop, etc.) | Validators (dispatch to), Schemas (validate against), Agent-Memory (inject/persist) |
| **Validators** | Check generated output for correctness (patch structure, object validity, connections, code syntax) | Object-DB (lookup objects), Schemas (structural checks), Hooks (invoked by) |
| **Object Database** | Comprehensive MAX object reference (inlets, outlets, arguments, types, domains, version compat) | Validators (queried by), Agents (consulted during generation), Templates (cross-referenced) |
| **Templates** | Reusable patterns for common MAX constructs | Agents (consumed by), Scripts (indexed by template-lookup) |
| **Critics** | Post-execution quality review with scored categories | Skills (invoked at stage gates), Agents (review output of) |
| **Schemas** | JSON schemas for contracts, reports, and the object database itself | All components (structural source of truth) |
| **Commands** | Slash-command entry points for user interaction | Skills (delegate to) |
| **Scripts** | Utility programs (template lookup, object DB queries, layout calculations) | Templates (index), Object-DB (query), Validators (helper functions) |

### Data Flow

```
User Command (/patch, /gen, /external, etc.)
  |
  v
Command (entry point)
  |
  v
Skill (orchestration: discuss -> research -> plan -> execute -> verify)
  |
  |-- discuss: Gather requirements from user
  |-- research: Query object DB, check templates, validate feasibility
  |-- plan: Create project ARCHITECTURE.md, ROADMAP.md
  |-- execute: Invoke domain agent(s) via Task
  |     |
  |     v
  |   Agent (domain-specific generation)
  |     |-- Reads: Object DB, Templates, Project contracts
  |     |-- Generates: .maxpat JSON, Gen~ code, JS, C/C++
  |     |-- Writes: Output files to projects/[Name]/
  |     |-- Returns: JSON report (schema-validated)
  |     |
  |     |-- [PostToolUse hook fires on Write/Edit]
  |     |     |
  |     |     v
  |     |   Validator (structural checks)
  |     |     |-- Checks: patch structure, object validity, connection types
  |     |     |-- Queries: Object DB for inlet/outlet type matching
  |     |     |-- Returns: pass/fail with feedback
  |     |
  |     |-- [SubagentStop hook fires]
  |           |-- Persist agent memory
  |           |-- Merge critic reports
  |
  |-- verify: Run critic(s), validate against contracts
        |
        v
      Critic (quality gate)
        |-- Scores: patch quality, layout, signal flow, code correctness
        |-- Returns: PASSED / NEEDS_FIXES / ESCALATE
```

## Component Deep Dives

### 1. Object Database (references/object-db/)

The most critical and unique component. MAX has hundreds of objects across domains (Max, MSP, Jitter, MC, Gen~, RNBO~), each with specific inlet/outlet counts, types, argument requirements, and behavioral rules. No official public specification exists.

**Format: One JSON file per domain namespace**

```
references/object-db/
  _schema.json               # Schema for object definitions
  _index.json                # Master index with summary stats
  max-core.json              # Max control objects (route, trigger, gate, etc.)
  max-math.json              # Math objects (+, -, *, /, expr, etc.)
  max-data.json              # Data objects (coll, dict, table, buffer~, etc.)
  max-midi.json              # MIDI objects (notein, noteout, ctlin, etc.)
  max-osc.json               # OSC objects (udpsend, udpreceive, etc.)
  max-timing.json            # Timing objects (metro, delay, pipe, etc.)
  max-ui.json                # UI objects (slider, dial, number, etc.)
  msp-generators.json        # MSP generators (cycle~, noise~, phasor~, etc.)
  msp-filters.json           # MSP filters (biquad~, svf~, onepole~, etc.)
  msp-effects.json           # MSP effects (delay~, tapin~/tapout~, etc.)
  msp-analysis.json          # MSP analysis (fft~, peakamp~, snapshot~, etc.)
  msp-io.json                # MSP I/O (adc~, dac~, ezdac~, etc.)
  msp-math.json              # MSP math (+~, *~, etc.)
  jitter-core.json           # Jitter objects (jit.matrix, jit.gl.*, etc.)
  mc-core.json               # MC multichannel objects (mc.cycle~, etc.)
  gen-operators.json          # Gen~ operators (cross-referenced)
  rnbo-objects.json           # RNBO-specific objects
```

**Object definition schema (per object):**

```json
{
  "name": "cycle~",
  "domain": "msp",
  "category": "generators",
  "description": "Cosine wavetable oscillator",
  "inlets": [
    { "index": 0, "type": "signal/float", "description": "Frequency (Hz) or signal" },
    { "index": 1, "type": "float", "description": "Phase offset (0-1)" }
  ],
  "outlets": [
    { "index": 0, "type": "signal", "description": "Cosine wave output" }
  ],
  "arguments": [
    { "index": 0, "type": "float", "optional": true, "default": 0, "description": "Initial frequency" },
    { "index": 1, "type": "symbol", "optional": true, "description": "Buffer name for custom waveform" }
  ],
  "attributes": {
    "frequency": { "type": "float", "default": 0 }
  },
  "max_version": "5+",
  "related": ["phasor~", "saw~", "tri~", "rect~"],
  "notes": "Reads from a 512-sample wavetable. Send buffer name as argument for custom waveforms.",
  "maxclass": "newobj",
  "text_format": "cycle~ {freq} {buffer_name}"
}
```

**Data sources for populating the database (build order):**

1. **Manual curation of core objects** -- Start with the 80-100 most-used objects across domains, hand-verified
2. **Cycling '74 documentation scraping** -- Parse docs.cycling74.com reference pages for inlet/outlet/argument data
3. **Patch analysis** -- Extract object usage from existing .maxpat files to identify gaps
4. **Community resources** -- Cross-reference with py2max library data and community databases

**Confidence:** MEDIUM on completeness timeline. The database will grow incrementally. Phase 1 must prioritize the most commonly used objects to unblock patch generation.

### 2. .maxpat Generation Pipeline

This is the core output pipeline. A .maxpat file is JSON with this structure:

```json
{
  "patcher": {
    "fileversion": 1,
    "appversion": { "major": 8, "minor": 6, "revision": 5, "architecture": "x64", "modernui": 1 },
    "classnamespace": "box",
    "rect": [100, 100, 800, 600],
    "bglocked": 0,
    "openinpresentation": 0,
    "default_fontsize": 12.0,
    "default_fontname": "Arial",
    "default_fontface": 0,
    "gridonopen": 1,
    "gridsize": [15.0, 15.0],
    "gridsnaponopen": 1,
    "objectsnaponopen": 1,
    "statusbarvisible": 2,
    "toolbarvisible": 1,
    "lefttoolbarpinned": 0,
    "toptoolbarpinned": 0,
    "righttoolbarpinned": 0,
    "bottomtoolbarpinned": 0,
    "boxanimatetime": 200,
    "enablehscroll": 1,
    "enablevscroll": 1,
    "devicewidth": 0.0,
    "description": "",
    "digest": "",
    "tags": "",
    "style": "",
    "subpatcher_template": "",
    "boxes": [
      {
        "box": {
          "id": "obj-1",
          "maxclass": "newobj",
          "text": "cycle~ 440",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": ["signal"],
          "patching_rect": [100.0, 100.0, 80.0, 22.0],
          "fontname": "Arial",
          "fontsize": 12.0
        }
      }
    ],
    "lines": [
      {
        "patchline": {
          "source": ["obj-1", 0],
          "destination": ["obj-2", 0],
          "hidden": 0,
          "midpoints": []
        }
      }
    ],
    "dependency_cache": [],
    "autosave": 0
  }
}
```

**Generation flow:**

```
Patch Specification (from agent)
  |
  v
Object Resolution
  |-- Look up each object in Object DB
  |-- Validate: object exists, correct arguments, inlet/outlet counts
  |-- Resolve maxclass (most are "newobj", UI objects have specific classes)
  |
  v
Connection Validation
  |-- For each connection: source outlet type matches destination inlet type
  |-- Signal (~) outlets connect to signal inlets
  |-- Control outlets connect to control inlets
  |-- Flag: mixed signal/control where ambiguous
  |
  v
Layout Engine
  |-- Assign patching_rect coordinates
  |-- Top-to-bottom signal flow (standard MAX convention)
  |-- Left-to-right for parallel chains
  |-- Spacing: 15px grid alignment
  |-- Avoid overlapping boxes
  |-- Group related objects visually
  |-- Calculate patchline midpoints for clean routing
  |
  v
JSON Assembly
  |-- Assign unique IDs (obj-1, obj-2, ...)
  |-- Build boxes array with resolved properties
  |-- Build lines array with source/destination pairs
  |-- Add patcher metadata (fileversion, rect, etc.)
  |-- Set proper outlettype arrays from Object DB
  |
  v
Structural Validation (PostToolUse hook)
  |-- Valid JSON
  |-- Required fields present
  |-- All connection references resolve to existing box IDs
  |-- No orphaned objects (objects with no connections, unless intentional)
  |-- Object DB cross-check (all objects valid for target MAX version)
  |
  v
Output: .maxpat file
```

### 3. Agent Architecture

Adapted from PFS's proven 11-agent model, specialized for MAX/MSP domains.

| Agent | Domain | Generates | Key Knowledge |
|-------|--------|-----------|---------------|
| **patch-agent** | MAX patching (control flow, MIDI, data) | .maxpat JSON for Max-domain patches | Object DB (max-core, max-midi, max-data, max-timing), layout conventions, subpatcher organization |
| **dsp-agent** | MSP audio processing | .maxpat JSON with MSP objects, signal routing | Object DB (msp-*), signal flow rules, audio rate vs control rate, buffer management |
| **gen-agent** | Gen~ / gen DSP code | GenExpr code for codebox~, gen~ subpatchers | GenExpr syntax, gen operators, sample-rate processing, History/Data operators |
| **rnbo-agent** | RNBO~ export-ready patches | RNBO-compatible .maxpat, export configuration | RNBO object subset, export targets (VST/AU/Web/Raspberry Pi), codegen config, parameter exposure |
| **n4m-agent** | Node for Max / js | JavaScript files for node.script / js objects | max-api module, Node.js patterns, Dict/Buffer interop, async patterns |
| **external-agent** | C/C++ externals | C/C++ source, CMakeLists.txt | Max SDK / Min-DevKit API, inlet/outlet registration, atom types, A_GIMME, class_new |
| **layout-agent** | Visual patch organization | patching_rect coordinates, midpoints | Grid alignment, signal flow direction, visual grouping, presentation mode layout |
| **jitter-agent** | Jitter video/GL (lower priority) | .maxpat with Jitter objects | jit.matrix, jit.gl.*, texture flow, render context |
| **validation-agent** | Cross-domain validation | Validation reports | Object DB queries, connection type checking, structural verification |

**Agent invocation pattern (same as PFS):**

```
Skill (orchestrator)
  |-- Task("patch-agent", prompt_with_contracts)
  |     |-- SubagentStart hook: inject agent memory
  |     |-- Agent reads contracts, Object DB, templates
  |     |-- Agent generates output
  |     |-- PostToolUse hooks: validate output
  |     |-- Agent returns JSON report
  |     |-- SubagentStop hook: persist memory, merge critics
  |
  |-- Process report, update state
```

**Agent memory (persistent learning):**

Each agent accumulates learned patterns in `.claude/agent-memory/[agent-name].md`. Examples:
- `patch-agent.md`: "When building a step sequencer, use [counter] -> [select] pattern, not [if] chains"
- `dsp-agent.md`: "tapin~ buffer size must be declared before tapout~ in signal flow"
- `gen-agent.md`: "History operator default value matters for first-sample behavior"

### 4. Skill Lifecycle

Skills orchestrate multi-step workflows. The core skill is `patch-workflow`, modeled after PFS's `plugin-workflow`.

**Stages for a MAX project:**

```
Stage 0: Planning
  |-- Discuss: Gather requirements (what kind of patch? what domain?)
  |-- Research: Query object DB for needed objects, check templates
  |-- Plan: Create ARCHITECTURE.md (patch structure), ROADMAP.md
  |
Stage 1: Core Patch
  |-- Execute: Invoke patch-agent / dsp-agent for primary .maxpat
  |-- Validate: Structural validation, object checks
  |
Stage 2: Code Components
  |-- Execute: Gen~ code (gen-agent), JS code (n4m-agent), if applicable
  |-- Validate: Syntax validation, operator checks
  |
Stage 3: Integration + Layout
  |-- Execute: Connect subpatchers, finalize layout (layout-agent)
  |-- Validate: Full connectivity check, layout review
  |
Stage 4: Polish + Documentation
  |-- Execute: Comments, help patches, documentation
  |-- Validate: Final structural check
```

**Not all stages apply to every project.** A simple patch may skip Stage 2 entirely. A Gen~-only project may start at Stage 2. The skill determines which stages are relevant based on the ARCHITECTURE.md.

### 5. Hook System

Hooks wire into Claude Code's lifecycle events. Implemented as Python scripts in `.claude/hooks/`.

| Hook Event | Script | Purpose |
|------------|--------|---------|
| `SessionStart` | `SessionStart.py` | Load system config, detect MAX installation path, set environment |
| `PostToolUse` (Write\|Edit) | `PostToolUse.py` | Dispatch to validators when .maxpat or code files are written |
| `PostToolUse` (Write\|Edit) | `validators/validate-maxpat-structure.py` | Validate .maxpat JSON structure (required fields, valid IDs, connection integrity) |
| `PostToolUse` (Write\|Edit) | `validators/validate-objects.py` | Cross-reference objects against Object DB (valid objects, correct inlet/outlet counts) |
| `PostToolUse` (Write\|Edit) | `validators/validate-connections.py` | Check connection type compatibility (signal-to-signal, control-to-control) |
| `PostToolUse` (Write\|Edit) | `validators/validate-genexpr.py` | Validate Gen~ code syntax (in/out declarations, operator validity) |
| `PostToolUse` (Write\|Edit) | `validators/validate-js.py` | Validate JavaScript syntax for N4M/js objects |
| `SubagentStart` | `inject-agent-memory.py` | Load persistent memory for the target agent |
| `SubagentStop` | `write-back-agent-memory.py` | Persist learned patterns from agent session |
| `SubagentStop` | `SubagentStop.py` | Process agent completion, merge critic reports |
| `PreCompact` | `PreCompact.py` | Checkpoint state before context compaction |
| `TaskCompleted` | `task-validator-dispatch.py` | Route completed task output to relevant validators |

### 6. Validation Pipeline (Multi-Layer)

Validation happens at three levels, progressively:

**Layer 1: Structural (PostToolUse, immediate)**
- Valid JSON
- Required .maxpat fields present (patcher, boxes, lines)
- All box IDs unique
- All patchline source/destination IDs reference existing boxes
- Outlet index within range for source object
- Inlet index within range for destination object

**Layer 2: Semantic (PostToolUse, detailed)**
- Object names resolve in Object DB
- Argument counts and types match Object DB definitions
- Outlet types match inlet types across connections (signal vs control)
- MSP objects properly terminated (signal chain ends at dac~ or similar)
- No signal feedback loops without delay (tapin~/tapout~ or gen~ History)
- Subpatcher inlet/outlet counts match parent connections

**Layer 3: Domain (Critic, at stage gates)**
- Signal flow makes musical/technical sense
- DSP chain has proper gain staging
- Gen~ code uses valid operators and correct in/out declarations
- RNBO patches use only RNBO-compatible objects
- Layout is readable (no overlapping, logical flow direction)
- Code follows best practices (js: proper max-api usage; C++: correct SDK patterns)

### 7. Template Organization

Templates provide reusable patterns that agents reference during generation.

```
templates/
  patch-patterns/            # Common .maxpat structural patterns
    synthesis/
      subtractive-basic.json      # osc~ -> filter~ -> gain~ -> dac~
      fm-2op.json                 # carrier + modulator FM pair
      additive-8partial.json      # 8-partial additive synthesis
      wavetable-basic.json        # buffer~ + cycle~ wavetable
    sequencing/
      step-sequencer-8.json       # 8-step counter -> select pattern
      euclidean-rhythm.json       # Euclidean rhythm generator
      arpeggiator.json            # Note arpeggiator
    effects/
      stereo-delay.json           # tapin~/tapout~ stereo delay
      reverb-freeverb.json        # Freeverb algorithm in MSP
      filter-sweep.json           # LFO -> filter cutoff
      compressor-basic.json       # Peak detection -> gain reduction
    control/
      midi-note-handler.json      # notein -> stripnote -> pack pattern
      osc-receiver.json           # udpreceive -> route -> unpack
      preset-system.json          # pattrstorage preset management
    jitter/
      webcam-basic.json           # jit.grab -> jit.gl.videoplane
      shader-basic.json           # jit.gl.shader setup
    mc/
      mc-unison-8.json            # MC 8-voice unison pattern

  gen-code/                   # GenExpr code templates
    oscillators/
      phasor-osc.gendsp          # Phase accumulator oscillator
      wavetable-interp.gendsp    # Interpolating wavetable reader
    filters/
      svf-filter.gendsp          # State variable filter
      onepole.gendsp             # One-pole lowpass
    effects/
      delay-line.gendsp          # Circular buffer delay
      allpass.gendsp             # Allpass filter (reverb building block)
    utilities/
      param-smooth.gendsp        # Parameter smoothing (one-pole)
      dcblock.gendsp             # DC blocking filter

  rnbo-patterns/               # RNBO-compatible patterns
    instrument-basic.json        # RNBO instrument with parameters
    effect-basic.json            # RNBO effect with parameters
    export-config.json           # Export target configurations

  n4m-code/                    # Node for Max JavaScript templates
    osc-server.js                # OSC server template
    file-watcher.js              # File system watcher
    api-client.js                # REST API client
    dict-bridge.js               # Dict <-> Node data bridge

  external-code/               # C/C++ external templates
    min-devkit/
      basic-tilde.cpp            # Min-DevKit MSP external template
      basic-max.cpp              # Min-DevKit Max external template
    max-sdk/
      basic-tilde.c              # Max SDK MSP external template
      basic-max.c                # Max SDK Max external template
    CMakeLists.txt               # Build system template
```

**Template format (patch-patterns):**

```json
{
  "name": "Subtractive Basic",
  "category": "synthesis",
  "domain": "msp",
  "description": "Basic subtractive synthesis: oscillator -> filter -> amplifier -> output",
  "complexity": 1,
  "tags": ["synthesis", "subtractive", "beginner"],
  "objects_used": ["cycle~", "svf~", "*~", "ezdac~", "line~"],
  "parameters": {
    "frequency": { "object": "cycle~", "inlet": 0, "range": [20, 20000], "default": 440 },
    "cutoff": { "object": "svf~", "inlet": 0, "range": [20, 20000], "default": 1000 },
    "resonance": { "object": "svf~", "inlet": 1, "range": [0, 1], "default": 0.5 },
    "amplitude": { "object": "*~", "inlet": 1, "range": [0, 1], "default": 0.5 }
  },
  "patch": {
    "boxes": [ "..." ],
    "lines": [ "..." ]
  }
}
```

### 8. Project Isolation

Each MAX project gets its own directory under `projects/`, completely isolated from other projects. This mirrors PFS's `plugins/[PluginName]/` pattern.

```
projects/
  GranularSynth/
    .planning/
      BRIEF.md              # "Build a granular synthesizer with..."
      ARCHITECTURE.md       # Patch structure: grain engine, envelope, spatialization
      ROADMAP.md            # Stage breakdown with complexity score
      STATUS.md             # Current stage + contract checksums
      parameter-spec.md     # Exposed parameters (for RNBO export or UI)
      research/             # Project-specific research
    patches/
      GranularSynth.maxpat  # Main patch
      GranularEngine.maxpat # Subpatcher
    code/
      grain-engine.gendsp   # Gen~ grain processing
      grain-envelope.gendsp # Gen~ envelope
      gui-bridge.js         # Node for Max GUI bridge
    externals/
      grain-scheduler/      # Custom C++ external
        Source/
        CMakeLists.txt
    tests/
      validation-report.json
      manual-test-protocol.md

  StepSequencer/
    .planning/...
    patches/...
```

**Project registry** (at repo root or in `.claude/`):

```json
{
  "projects": [
    {
      "name": "GranularSynth",
      "status": "Stage 2",
      "domains": ["msp", "gen"],
      "created": "2026-03-15",
      "last_updated": "2026-03-20"
    }
  ]
}
```

### 9. System Configuration

**`.claude/system-config.json`** -- Detected platform and tool paths:

```json
{
  "platform": "darwin",
  "arch": "arm64",
  "max_path": "/Applications/Max.app",
  "max_version": "8.6.5",
  "max_packages_path": "~/Documents/Max 8/Packages",
  "max_sdk_path": null,
  "min_devkit_path": null,
  "node_path": "/usr/local/bin/node",
  "python_path": "/usr/local/bin/python3",
  "cmake_path": "/opt/homebrew/bin/cmake",
  "validated_at": "2026-03-08T00:00:00Z"
}
```

This is populated by the `/setup` command and validated at SessionStart.

## Patterns to Follow

### Pattern 1: Contract-Driven Generation

**What:** Every agent reads planning contracts (BRIEF.md, ARCHITECTURE.md, ROADMAP.md) before generating anything. Output must trace back to contracts.

**When:** Always. No freeform generation without contracts.

**Why:** Prevents drift between intent and output. Enables validation (did the agent build what was planned?).

```
BRIEF.md: "Build a 4-voice polyphonic subtractive synth"
  -> ARCHITECTURE.md: "4x [cycle~ -> svf~ -> *~ -> line~] -> [+~] -> [ezdac~]"
    -> patch-agent: generates .maxpat with exactly those objects
      -> validator: confirms all architecture components present
```

### Pattern 2: Object DB as Source of Truth

**What:** Every object reference in generated patches is validated against the Object Database. Agents never guess inlet/outlet counts or types.

**When:** During generation (agent reads DB) and after generation (validator cross-checks).

**Why:** MAX has hundreds of objects with specific, non-obvious behaviors. Getting inlet counts wrong produces patches that fail silently in MAX.

```python
# In validator:
obj = object_db.lookup("svf~")
assert obj["inlets"][0]["type"] == "signal"  # frequency input
assert len(obj["outlets"]) == 4              # lp, hp, bp, notch outputs
```

### Pattern 3: Multi-Layer Validation

**What:** Validation happens at three layers: structural (immediate), semantic (detailed), domain (critic at gates). Each layer catches different classes of errors.

**When:** Structural on every Write/Edit. Semantic on .maxpat writes. Domain at stage boundaries.

**Why:** Catching errors early (structural) prevents wasted agent effort. Deep checks (semantic, domain) catch subtle issues that structural checks miss.

### Pattern 4: Layout as First-Class Concern

**What:** Patch layout (patching_rect coordinates) is not an afterthought -- it follows explicit rules for readability.

**When:** During generation, with optional layout-agent refinement pass.

**Rules:**
- Signal flows top-to-bottom (inputs at top, outputs at bottom)
- Parallel signal chains flow left-to-right
- Grid alignment: 15px increments (matches MAX default)
- Minimum vertical spacing: 45px between connected objects
- Minimum horizontal spacing: 30px between parallel chains
- Comments above or beside the objects they describe
- Subpatchers grouped visually with spacing separators

### Pattern 5: Agent Memory Accumulation

**What:** Agents persist learned patterns across sessions. Memory is injected at SubagentStart and written back at SubagentStop.

**When:** Every agent invocation.

**Why:** Claude loses context between sessions. Learned patterns (e.g., "tapin~ must declare buffer size before tapout~ reads it") should persist.

## Anti-Patterns to Avoid

### Anti-Pattern 1: Generating Without Object DB Lookup

**What:** An agent generating .maxpat content by "guessing" object behavior from training data instead of consulting the Object Database.

**Why bad:** Training data may contain incorrect or outdated object information. Inlet/outlet counts, argument formats, and type compatibility must come from the verified database.

**Instead:** Every object reference must be resolved against Object DB. If an object is not in the DB, the agent must flag it and either add it (with documentation source) or use a known alternative.

### Anti-Pattern 2: Monolithic Patch Generation

**What:** Generating an entire complex patch as a single flat .maxpat file with dozens of objects.

**Why bad:** Hard to validate, hard to debug, hard to maintain. MAX users organize complex patches into subpatchers (bpatcher, p subpatcher).

**Instead:** Decompose into logical subpatchers. Main patch contains high-level routing. Processing details live in named subpatchers. Each subpatcher can be validated independently.

### Anti-Pattern 3: Hardcoded Object Properties

**What:** Hardcoding numinlets, numoutlets, outlettype values without referencing the Object DB.

**Why bad:** Object properties vary by arguments and configuration. `pack` has a variable number of inlets based on arguments. `route` outlet count depends on routing arguments. Hardcoding leads to invalid patches.

**Instead:** Derive inlet/outlet counts from Object DB, accounting for argument-dependent variations.

### Anti-Pattern 4: Ignoring Signal vs Control Rate

**What:** Connecting MSP signal outlets to Max control inlets (or vice versa) without conversion objects.

**Why bad:** Signal-rate (~) and control-rate connections are fundamentally different in MAX. Connecting them incorrectly produces silence or error messages.

**Instead:** Validators must check every connection. Signal-to-control requires `snapshot~`. Control-to-signal requires `sig~` or `line~`. The Object DB marks each inlet/outlet as "signal", "control", or "signal/control" (accepts both).

## Scalability Considerations

| Concern | 10 Objects | 100 Objects | 500+ Objects |
|---------|------------|-------------|-------------|
| Object DB size | Trivial | ~50KB JSON | ~250KB JSON, may need lazy loading |
| Patch generation | Single agent pass | Single agent pass | Decompose into subpatchers, multiple agent passes |
| Layout calculation | Trivial | Grid algorithm, ~1s | Need spatial partitioning, layout-agent pass |
| Validation time | <1s | 2-5s | 5-15s, parallelize validators |
| Connection checking | O(n) | O(n*m) manageable | Consider connection graph indexing |

## Suggested Build Order

Components have clear dependencies. Build in this order:

```
Phase 1: Foundation (no dependencies)
  1. System config detection (system-config.json)
  2. Directory structure (.claude/ skeleton)
  3. Core schemas (object DB schema, report schema)
  4. Object DB: Core objects (~80-100 most-used across Max + MSP)
  5. Basic settings.json with hooks skeleton

Phase 2: Generation Core (depends on Phase 1)
  6. patch-agent (reads Object DB, generates .maxpat)
  7. Layout engine (calculates patching_rect coordinates)
  8. Structural validator (validate-maxpat-structure.py)
  9. Object validator (validate-objects.py, queries Object DB)
  10. Connection validator (validate-connections.py)

Phase 3: Extended Agents (depends on Phase 2)
  11. dsp-agent (MSP-specific generation, signal flow)
  12. gen-agent (GenExpr code generation)
  13. GenExpr syntax validator (validate-genexpr.py)
  14. Templates: patch-patterns (synthesis, effects, control)
  15. Templates: gen-code (oscillators, filters, utilities)

Phase 4: Code Domains (depends on Phase 1, partially Phase 2)
  16. n4m-agent (Node for Max JavaScript)
  17. JS validator (validate-js.py)
  18. external-agent (C/C++ externals)
  19. Templates: n4m-code, external-code

Phase 5: Orchestration (depends on Phases 2-3)
  20. Skills: patch-workflow (stage orchestration)
  21. Commands: /patch, /gen, /external, /project
  22. Critics: patch-critic, code-critic
  23. Project isolation structure
  24. Agent memory system

Phase 6: Expansion (depends on Phases 3-5)
  25. RNBO agent + templates
  26. Jitter agent + object DB entries
  27. MC domain support
  28. Object DB expansion (full coverage)
  29. Advanced layout algorithms
  30. Help-patch generation
```

**Critical path:** Phase 1 (items 1-5) -> Phase 2 (items 6-10) -> Phase 3 (items 11-15). Everything else can parallelize after Phase 2.

**Phase dependencies visualized:**

```
[Phase 1: Foundation]
    |
    v
[Phase 2: Generation Core] -----> [Phase 4: Code Domains]
    |                                    |
    v                                    v
[Phase 3: Extended Agents] ------> [Phase 5: Orchestration]
                                        |
                                        v
                                  [Phase 6: Expansion]
```

## Sources

- Plugin Freedom System at `/Users/taylorbrook/Dev/VST-development` -- Proven architecture pattern (HIGH confidence)
- [py2max](https://github.com/shakfu/py2max) -- .maxpat JSON format reverse-engineering (MEDIUM confidence)
- [Cycling '74 .maxpat format forum discussion](https://cycling74.com/forums/specification-for-maxpat-json-format) -- Confirms no official specification (HIGH confidence)
- [Cycling '74 Objects documentation](https://docs.cycling74.com/userguide/objects/) -- Official object reference (HIGH confidence)
- [GenExpr documentation](https://docs.cycling74.com/legacy/max8/vignettes/gen_genexpr) -- Official Gen~ syntax (HIGH confidence)
- [Node for Max API](https://docs.cycling74.com/nodeformax/api/) -- Official N4M API (HIGH confidence)
- [Max SDK (GitHub)](https://github.com/Cycling74/max-sdk) -- C external development (HIGH confidence)
- [Min-DevKit (GitHub)](https://github.com/Cycling74/min-devkit) -- Modern C++ external development (HIGH confidence)
- [RNBO documentation](https://docs.cycling74.com/userguide/rnbo/) -- RNBO export and codegen (HIGH confidence)
- [Claude Code Hooks Reference](https://code.claude.com/docs/en/hooks) -- Official hook event documentation (HIGH confidence)
