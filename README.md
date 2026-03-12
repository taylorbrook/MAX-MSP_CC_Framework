# MAX/MSP Claude Code Framework

An AI-assisted MAX/MSP/Jitter/RNBO development system that enables conversational creation of MAX patches and externals. Design, build, and iterate on MAX through dialogue with [Claude Code](https://claude.ai/claude-code).

> **Note:** Generated patches must be opened and tested in MAX. This framework produces valid `.maxpat` files, Gen~ code, JavaScript, and C++ externals — but there is no in-framework audio preview or simulation. All testing is manual in MAX 9.

## Features

- **Conversational patch creation** — describe what you want in natural language; Claude generates valid `.maxpat` files
- **2,015-object knowledge base** — verified database covering MAX, MSP, Jitter, MC, Gen~, Max for Live, RNBO, and package objects with full inlet/outlet schemas
- **10 specialist agents** — router, patch, DSP/Gen~, RNBO, JavaScript, UI layout, C++ externals, critic, memory, and lifecycle management
- **4-layer validation pipeline** — structure checks, connection verification, domain-specific critics (DSP signal flow, RNBO compatibility, C++ review), and iterative revision
- **Gen~ / GenExpr code generation** — sample-rate DSP code with proper declaration ordering, feedback loops, and parameter mapping
- **RNBO export support** — generate export-ready patches for VST3/AU plugins, Web Audio, and C++ embedded targets
- **Node for Max & js scripting** — generate JavaScript for both V8 `js` objects and Node.js `node.script`
- **C++ external development** — scaffold, generate, and build Min-DevKit externals with help patches
- **Persistent memory system** — learns patterns across sessions (global and per-project scopes)
- **Project lifecycle management** — structured workflow from ideation through build and verification

## Prerequisites

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) (requires an Anthropic account)
- [MAX 9](https://cycling74.com/products/max) (required for opening and testing generated patches)
- Python 3.10+ (for the validation and generation engine)
- RNBO (optional — only needed for export targets)

## Quick Start

### 1. Clone and open

```bash
git clone https://github.com/taylorbrook/MAX-MSP_CC_Framework.git
cd MAX-MSP_CC_Framework
claude
```

### 2. Create a project

```
/max-new my-synth
```

Claude will ask about your goals — what kind of patch, audio requirements, signal flow, UI needs. Your answers are saved to `patches/my-synth/context.md` and guide all subsequent generation.

### 3. Build

```
/max-build subtractive synth with resonant filter and ADSR envelope
```

The router analyzes your request, dispatches to the appropriate agent(s), generates the patch, and runs it through the critic pipeline. The output lands in `patches/my-synth/generated/`.

### 4. Verify

```
/max-verify
```

Runs all generated files through the full validation pipeline — structure checks, connection bounds, signal flow analysis. Reports blockers, warnings, and notes.

### 5. Test in MAX

```
/max-test
```

Generates a manual test checklist based on the objects and signal flow in your patch. Open the `.maxpat` in MAX 9, run through the checklist, and report results back.

### 6. Iterate

```
/max-iterate add a chorus effect after the filter
```

Loads your existing patch, applies changes, and re-validates — preserving positions, connections, and previous decisions.

## Commands

| Command | Description |
|---------|-------------|
| `/max-new` | Create a new project with conversational kickoff |
| `/max-build` | Generate patches and code via agent dispatch |
| `/max-iterate` | Modify existing patches or code |
| `/max-verify` | Run validation and critic review on all output |
| `/max-test` | Generate a manual test checklist for MAX |
| `/max-status` | Show project overview, progress, and current stage |
| `/max-discuss` | Capture implementation decisions |
| `/max-research` | Research MAX-specific techniques and approaches |
| `/max-switch` | Change the active project |
| `/max-memory` | View, list, or manage stored pattern memories |

## Example Projects

The `patches/` directory includes complete example projects you can open in MAX 9:

| Project | Description | Domains |
|---------|-------------|---------|
| **rhythmic-sampler** | 8-slot sampler with slice-based sequencing, time-stretching, and per-slot FX (pitch, filter, stutter, bitcrush) | MSP, js, bpatcher |
| **FDNVerb** | Feedback delay network reverb with 8 delay lines, Hadamard matrix, decay/diffusion/damping/freeze controls | Gen~ |
| **granularsynthtest** | Granular synthesizer with Gen~ DSP engine and MC multichannel output for flexible speaker arrays | Gen~, MC |
| **performancepatchtest** | Live performance cue system with multiband compression, feedback delay, distortion, and soundfile playback | MSP, routing |

Each project contains a `context.md` with the full design conversation and a `generated/` directory with the output files.

## How It Works

The framework has three core layers:

**Object Database** — A verified knowledge base of 2,015 MAX objects (`.claude/max-objects/`) with full inlet/outlet schemas, signal types, argument formats, variable I/O rules, and RNBO compatibility flags. Every object used in generation is looked up here — nothing is guessed.

**Agent System** — A router analyzes your task description and dispatches to one or more specialist agents (DSP, patch, RNBO, js, UI, externals). For multi-domain tasks (e.g., "synth with knobs"), a lead agent generates the core patch and secondary agents contribute their domain.

**Validation Pipeline** — Every generated patch passes through structure validation, connection bounds checking, and domain-specific critics (DSP signal flow, RNBO compatibility, C++ code review). Blockers trigger automatic revision before output is written.

For full technical documentation — agent internals, validation details, object database schema, memory system, and architecture — see [TECHNICAL.md](TECHNICAL.md).

## Project Structure

```
MAX-MSP_CC_Framework/
├── .claude/
│   ├── max-objects/        # Object database (2,015 objects across 8 domains)
│   ├── skills/             # Agent definitions (10 specialist agents)
│   └── commands/           # Slash command definitions
├── src/maxpat/             # Python generation and validation engine
├── tests/                  # Test suite (626 tests)
├── patches/                # Your projects live here
│   ├── .active-project.json
│   └── {project-name}/
│       ├── context.md      # Design conversation and decisions
│       ├── status.md       # Project stage and progress
│       ├── generated/      # Output (.maxpat, .gendsp, .js)
│       └── test-results/   # Manual test records
└── CLAUDE.md               # Framework rules (enforced automatically)
```

## License

This project is licensed under the [MIT License](LICENSE).

---

Built for MAX 9 with [Claude Code](https://claude.ai/claude-code).
