# MAX/MSP Claude Code Framework

An AI-assisted MAX/MSP/Jitter/RNBO development system that enables conversational creation and editing of MAX patches and externals. Design, build, and iterate on MAX through dialogue with [Claude Code](https://claude.ai/claude-code).

> **Note:** Patches must be opened and tested in MAX. This framework produces and edits valid `.maxpat` files, Gen~ code, JavaScript, and C++ externals — but there is no in-framework audio preview. The offline checks (`dsp_sim` waveguide simulation and codebox smoke test) and the opt-in `/max-verify --live` console/level check in a running MAX catch some failures, but listening tests are manual in MAX 9. There are safety checks in place, but audio coding done by AI is still risky so don't blow your ears off!

## Features

- **Direct .maxpat editing** — reads, edits, and writes `.maxpat` files directly with lossless round-trip preservation; the patch file is the single source of truth
- **Conversational patch creation** — describe what you want in natural language; Claude generates valid `.maxpat` files
- **Patch analysis and onboarding** — analyze any existing `.maxpat` file to understand its structure, signal flow, and sections before editing or extending it
- **Intelligent editing** — `edit_patch` sessions that modify objects in-place, insert into signal chains, replace/swap objects (box ids kept), query upstream/downstream signal paths, auto-position new objects, and show a semantic diff of what changed; a no-op save is byte-identical for patches from any Max version
- **3,467-object knowledge base** — verified database covering MAX, MSP, Jitter, MC, Gen~, Max for Live, RNBO, and 30 packages (BEAP, Vizzie, FluCoMa, CNMAT, Bach, and more) with full inlet/outlet schemas and typed per-outlet signal metadata (`signal_role`) backing the connection validator
- **Package-aware generation** — project-level package selection, DB-driven bpatcher sizing, allowed_packages gating, and community package stubs with extraction CLI for installed packages
- **9 specialist agents** — router, patch, DSP/Gen~, RNBO, JavaScript, UI layout, C++ externals, critic, and lifecycle management with package-specific domain guidance
- **5-layer validation pipeline** — run on every subpatcher scope: structure checks, `signal_role`-aware connection verification, vocabulary checks (`expr clip()`, `line~` comma segments, bpatcher args, message selectors), domain-restriction guards, seven domain-specific critics (DSP signal flow, structure, layout, RNBO compatibility, C++ review, package conventions, Max for Live device conventions), and iterative revision
- **Codified layout/UX builders** — one-call helpers for labeled parameter banks, overlay readouts, safe box replacement with auto-rewiring, and Max for Live device skeletons with `.amxd` export. The Max for Live builders (`add_m4l_device`, `add_m4l_gen_synth`, `polish_m4l_device`, `export_amxd`): **Experimental:** not yet confirmed in MAX or Live.
- **Offline DSP pre-flight simulation** — a numerical waveguide-stability harness (`dsp_sim`) that classifies specific reed/bore topologies before you open the patch in MAX, plus a GenExpr codebox smoke test (`python3 -m src.maxpat.dsp_sim smoke`) that infers audio vs control outputs from the host patch and flags NaN, runaway, silence and self-sustain (not a general audio preview)
- **Gen~ / GenExpr code generation** — sample-rate DSP code with proper declaration ordering, feedback loops, and parameter mapping
- **RNBO export support** — generate export-ready patches for VST3/AU plugins, Web Audio, and C++ embedded targets. The RNBO builders (`add_rnbo`, `generate_rnbo_wrapper`): **Experimental:** not yet confirmed in MAX.
- **Node for Max & js scripting** — generate JavaScript for `js` objects (Legacy Engine, ES5), `v8` objects (Modern Engine), and Node for Max `node.script`
- **C++ external development** — scaffold, generate, and build Min-DevKit externals with help patches
- **Help patch audit pipeline** — offline tool (`python3 tools/audit_db.py --help-io`) that compares every box in 2,114 bundle .maxhelp files (Max 9.2.0) and 1,333 installed-package help files with the database; reviewed corrections land through `tools/sync_max_bundle.py --apply`
- **Professional patch aesthetics** — styled section comments, background panels, contrast-aware text colors, obstacle-avoiding cord routing, grid-snapped layout, and inlet-aligned cables for polished output; edits never restyle a patch you arranged in MAX
- **Project lifecycle management** — structured workflow from ideation through build and verification with automatic version tracking

## Prerequisites

- **macOS only.** The framework assumes macOS throughout: it reads the Max bundle at `/Applications/Max.app` and packages under `~/Documents/Max 9/Packages`, and checks built externals as arm64 Mach-O binaries with `file` and `lipo`.
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) (requires an Anthropic account)
- [MAX 9](https://cycling74.com/products/max) (required for opening and testing generated patches; the Vision package `jit.vis.*` objects and the other objects tagged `min_version` 9.2, listed in `.claude/skills/references/max-9.2-changes.md`, need Max 9.2+)
- Python 3.10+ (for the validation and editing engine), with the packages in `requirements-dev.txt`: numpy and scipy (the `dsp_sim` DSP pre-flight simulation) and pytest (the test suite, and the DSP agent's pre-flight gate, which runs the simulation tests before saving). Install them with `python3 -m pip install -r requirements-dev.txt`; `npx create-max-framework --check-deps` or `install.sh --check-deps` re-checks Python, these packages and git without installing.
- git (every patch save is auto-committed)
- RNBO (optional — only needed for export targets)
- System tools needed only for some features:
  - Node.js / `npx` — install Option A (`npx create-max-framework`)
  - cmake (with make, through the Unix Makefiles generator) — building C++ externals
  - `file` and `lipo` (both ship with macOS) — validating built externals

## Quick Start

### 1. Install

**Option A: npx (recommended)**

```bash
npx create-max-framework my-project
cd my-project
claude
```

**Option B: Shell script**

```bash
curl -fsSL https://raw.githubusercontent.com/taylorbrook/MAX-MSP_CC_Framework/main/install.sh | bash -s my-project
cd my-project
claude
```

**Option C: Git clone (for contributors)**

```bash
git clone https://github.com/taylorbrook/MAX-MSP_CC_Framework.git my-project
cd my-project
claude
```

### 2. Create a project

```
/max-new my-synth
```

Claude walks you through a full project kickoff in one continuous conversation:
1. **Kickoff** — asks about your goals, audio/MIDI requirements, signal flow, UI needs, and which packages to use (BEAP, Vizzie, FluCoMa, etc.)
2. **Discuss** — dives deeper into implementation decisions (object choices, signal architecture, control design)
3. **Research** — looks up the best MAX objects, patterns, and techniques from the 3,467-object database

By the end, all findings are saved to `patches/my-synth/context.md` and Claude suggests a concrete `/max-build` command.

### 3. Build

```
/max-build subtractive synth with resonant filter and ADSR envelope
```

The router analyzes your request, dispatches to the appropriate agent(s), and directly writes a new `.maxpat` file. Output lands in `patches/my-synth/generated/`.

### 4. Onboard an existing patch (optional)

```
/max-onboard /path/to/existing-patch.maxpat
```

Analyzes any `.maxpat` file — from MAX's own examples, third-party sources, or your own work — and produces a structured summary of its objects, signal flow, sections, and complexity.

### 5. Verify

```
/max-verify
```

Runs all generated files through the full validation pipeline — structure checks, connection bounds, signal flow analysis. Reports blockers, warnings, and notes. `/max-verify --live` also loads each patch in the running MAX through the max-bridge (open `tools/max_bridge/max-bridge.maxpat` first) and reports console errors and output levels.

### 6. Test in MAX

```
/max-test
```

Generates a manual test checklist based on the objects and signal flow in your patch. Open the `.maxpat` in MAX 9, run through the checklist, and report results back.

### 7. Iterate

```
/max-iterate add a chorus effect after the filter
/max-iterate --full redesign the delay feedback path
/max-iterate --discuss --research add sidechain compression
```

Reads the existing `.maxpat`, analyzes its structure, makes surgical edits, and writes back — preserving all positions, colors, connections, and manual changes you've made in MAX. Every iteration automatically bumps the project version and embeds a `vX.Y.Z` comment in the patch.

Optional flags prepend phases before the edit:

| Flag | Description |
|------|-------------|
| `--full` | Run discuss + research + plan before building |
| `--discuss` | Clarify implementation approach interactively |
| `--research` | Look up objects and techniques from the database |
| `--plan` | Outline edit steps and get approval before executing |
| `--fix` | List critic findings that carry a quick fix, preview the diff, and apply the selected fixes |

Flags are composable (`--discuss --research`) and can be combined with inline project switching (`/max-iterate stutter --full add granular engine`).

## Commands

| Command | Description |
|---------|-------------|
| `/max-new` | Create a new project with kickoff, discussion, and research in one flow |
| `/max-build` | Generate patches and code via agent dispatch |
| `/max-iterate` | Read, edit, and write back existing patches or code (`--full`, `--discuss`, `--research`, `--plan`, `--fix`) |
| `/max-onboard` | Analyze an existing `.maxpat` file and produce a structured summary |
| `/max-verify` | Run validation and critic review on all output (`--live` adds a load-and-listen check in the running MAX) |
| `/max-diagnose` | Map pasted MAX console output to causes and fixes, locate the offending boxes, and propose a `/max-iterate` fix (read-only) |
| `/max-test` | Generate a manual test checklist for MAX |
| `/max-status` | Show project overview, progress, and current stage |
| `/max-discuss` | Capture implementation decisions |
| `/max-research` | Research MAX-specific techniques and approaches |
| `/max-switch` | Change the active project |

## Patches

The `patches/` directory contains example and user-created projects. It is repository-only: releases (`npx create-max-framework`, `install.sh`) ship an empty `patches/` for your own projects.

| Project | Description | Files |
|---------|-------------|-------|
| **amplitude-follower** | Smoothed RMS amplitude follower in gen~ with a single smoothing-time parameter, outputting a 0–1 signal usable as a modulation source | `.maxpat` |
| **barnett-dbap** | 8-channel Distance-Based Amplitude Panning (DBAP) spatializer for the Roy Barnett Recital Hall speaker rig, ported from the O-Octagon VST | `.maxpat`, `.js` |
| **bassoon-model** | Physical model of a bassoon with conical waveguide and reed nonlinearity for high-accuracy microtonal pitch | `.maxpat`, `.gendsp` |
| **disintegrate** | One-knob stereo "disintegration" effect in a single gen~ codebox — filtering, saturation, and detuning sweep the sound from bypass to silence | `.maxpat` |
| **face-tracker** | Vision package face tracking showcase (jit.vis.face / facemesh) with normalized `face.*` sends, live feature readouts and a drone sonification demo | `.maxpat` |
| **FDNVerb** | Feedback delay network reverb with 8 delay lines, Hadamard matrix, decay/diffusion/damping/freeze controls | `.maxpat`, `.gendsp`, `.maxhelp` |
| **gen-eq** | 5-band parametric EQ with TPT SVF filters in gen~, Neve-warm asymmetric saturation, and SSL-style horizontal UI | `.maxpat`, `.gendsp` |
| **gong-model** | Physical model of a gong using gen~ modal synthesis with pitch/timbre control, MIDI and audio excitation, drift engine | `.maxpat`, `.gendsp`, `.js` |
| **granularsynthtest** | Granular synthesizer with Gen~ DSP engine and MC multichannel output for flexible speaker arrays | `.maxpat`, `.gendsp` |
| **intelligent-corpus-remixer** | Corpus-based concatenative synthesis using FluCoMa (MFCC + UMAP + k-means), EARS, and Odot; 2D plotter-triggered playback | `.maxpat`, `.js` |
| **ji-harmonizer** | Wavetable pad synth where one MIDI note triggers a full chord, every pitch tuned by a microtonal engine (temperaments, Scala .scl/.kbm, scale generators), ported from the O-IntonationPad VST | `.maxpat`, `.js` |
| **kicksynth** | Kick drum synthesizer with Gen~ pitch envelopes, click/sub/noise layers, and drive/saturation | `.maxpat`, `.js` |
| **knock** | Deep knocking-sound generator — a gen~ kick-style voice triggered by velocity, with randomness and bassiness controls that vary each hit | `.maxpat` |
| **looper** | Pedal-style audio looper with one-button record/play/overdub cycling, overdub feedback, and a waveform display | `.maxpat`, `.gendsp` |
| **max-bridge** | Fixtures and manual checklists for the resident UDP/OSC bridge driven by tools/max_bridge.py (opens a patch in running MAX, captures console errors, records output, screenshots the window). The bridge patch itself ships at `tools/max_bridge/max-bridge.maxpat` | `.maxpat` |
| **minitaur** | Digital recreation of the Moog Minitaur bass synthesizer with dual VCOs, Moog ladder filter, and LFO modulation | `.maxpat`, `.js` |
| **mixer** | Virtual mixing console with channel strips, aux buses, master section, and per-track sends | `.maxpat`, `.js` |
| **performancepatchtest** | Live performance cue system with multiband compression, feedback delay, distortion, and soundfile playback | `.maxpat`, `.gendsp` |
| **physics-composition** | Audiovisual instrument where a 2D bouncing-ball simulation (dada.bounce) drives microtonal note generation with bach.roll score display | `.maxpat` |
| **q29-check** | Throwaway MAX check patch for the Q29 fixes: write_gendsp in-place grow, replace_box_safe identity + rewire, add_box companion placement, no-op save byte-identity | `.maxpat`, `.gendsp` |
| **reverse-delay** | gen~ granular reverse delay ported from the O-ReverseDelay VST, with tempo sync, factory presets, and mono or stereo input | `.maxpat` |
| **rhythmic-corpus-chopper** | Sample-accurate beat slicer and re-sequencer using FluCoMa onset detection and the Rhythmic Time Toolkit for signal-rate sequencing | `.maxpat`, `.js` |
| **rhythmic-sampler** | 8-slot sampler with slice-based sequencing, time-stretching, and per-slot FX | `.maxpat`, `.js` |
| **sample-layers** | Long-grain sample layer player — six buffers each play randomized 3–20 s grains with a Tukey window, random per-grain pan, and global attack/release | `.maxpat` |
| **scala-synth** | 16-voice polyphonic additive synthesizer with Scala (.scl) file support for microtonal playback | `.maxpat`, `.js` |
| **simple-fm** | Teaching patch that demonstrates the essentials of FM synthesis so learners can hear and see what each parameter does | `.maxpat` |
| **spectraldetector** | Detects whether an audio input is mostly a sustained pitch or noise | `.maxpat` |
| **stereo-feedback-delay** | Mono-in, stereo-out feedback delay with a gen~ engine — damping, tape-warble modulation, and soft-clip saturation in the feedback path | `.maxpat` |
| **stutter** | Glitchy stutter effect with rhythmic and chaotic modes, built around a Gen~ stutter engine | `.maxpat`, `.gendsp` |
| **subtractive-synth** | Monophonic subtractive synth built from native MSP objects — two oscillators, a filter with its own ADSR, an amp ADSR, and a routable LFO | `.maxpat` |
| **tape-wobble** | Stereo tape wobble effect with wow/flutter, saturation, and degradation controls | `.maxpat` |
| **terrain-synth** | Wave-terrain / geometry-derived wavetable synthesizer with two oscillator engines behind a MIDI/poly~ front end and a Jitter view of the terrain and orbit | `.maxpat`, `.js` |
| **timestretch** | Granular time-stretching instrument in gen~ with real-time and offline modes, WSOLA-enhanced overlap-add engine | `.maxpat` |
| **wormhole** | Spectral effects processor with warp, pitch/frequency shifting, dual reverb, and stereo delay | `.maxpat` |

## How It Works

The framework has four core layers:

**Direct .maxpat Editing (v3.0)** — The `.maxpat` file is the single source of truth. Patches are loaded into `Patcher`/`Box`/`Patchline` objects, edited with search, mutation, and graph query methods inside a `with edit_patch(path) as p:` session, and written back with lossless round-trip preservation in the file's own JSON layout. All user state — positions, colors, varnames, custom attributes, manual edits made in MAX — survives the load-edit-save cycle. Every patch save under `patches/<project>/` auto-commits just that file to git for safety. No intermediate code generation step.

**Object Database** — A verified knowledge base of 3,467 MAX objects (`.claude/max-objects/`) across 7 core domains plus 30 packages (bundled and community) with full inlet/outlet schemas, typed per-outlet signal metadata (`signal_role`), domain-restriction and install-state flags, argument formats, variable I/O rules, RNBO compatibility flags, and package source tracking. Package objects include DB-driven bpatcher dimensions for layout. Every object used in generation is looked up here — nothing is guessed.

**Agent System** — A router analyzes your task description and dispatches to one or more specialist agents (DSP, patch, RNBO, js, UI, externals). Agents read existing patches, analyze their structure, make surgical edits or build new ones, and write the result directly.

**Validation Pipeline** — Every patch passes through structure validation, `signal_role`-aware connection bounds and signal-type checking, package gating, domain-restriction guards, and an embedded GenExpr codebox walker, followed by seven domain-specific critics (DSP signal flow, structure, layout, RNBO compatibility, C++ code review, package conventions — BEAP signal standards, Bach llll type checking, community package extraction verification — and Max for Live device conventions). Blockers trigger automatic revision before output is written. As a backstop, `save_patch_roundtrip` and `write_gendsp` re-run validation and the critics before writing: they refuse any blocker the save would introduce (blockers already in the file being edited are allowed), including an unknown object that no abstraction beside the patch resolves, and any change to a subpatcher's port order, and warn about removed cords; `force=True` overrides. Validation never removes anything itself: an invalid cord is reported as a proposed removal. Aesthetic styling (panels, comments, patcher colors) is applied automatically during generation.

For full technical documentation — agent internals, validation details, object database schema, and architecture — see [TECHNICAL.md](TECHNICAL.md).

## Project Structure

```
MAX-MSP_CC_Framework/
├── .claude/
│   ├── max-objects/        # Object database (3,467 objects across 7 core domains + 30 packages)
│   ├── skills/             # Agent definitions (9 specialist agents)
│   └── commands/           # Slash command definitions
├── src/maxpat/             # Python editing, validation, and analysis engine (~40,800 LOC)
├── tools/                  # DB audit/sync tools, max-bridge client + bridge patch (tools/max_bridge/)
├── tests/                  # Test suite (7,550 tests)
├── patches/                # Your projects live here
│   ├── .active-project.json
│   └── {project-name}/
│       ├── context.md      # Design conversation and decisions
│       ├── status.md       # Project stage and progress
│       ├── versions.json   # Version history (bumped on every iteration)
│       ├── generated/      # Output (.maxpat, .gendsp, .js)
│       └── test-results/   # Manual test records
├── CHANGELOG.md            # Release notes (each section is the GitHub release body)
└── CLAUDE.md               # Framework rules (enforced automatically)
```

## Development with GSD (to build on the system, not required for building MAX patches)

This project uses the [Get Shit Done (GSD)](https://github.com/gsd-build/get-shit-done) planning framework for structured development with Claude Code. GSD provides milestone planning, phased execution, and verification workflows. It is recommended for those who want to iterate on the framework itself (agents, validation pipeline, object database) — you do not need GSD to create MAX patches, but it you plan on iterating on the system itself, I suggest using GSD.

### Available GSD commands

| Command | Description |
|---------|-------------|
| `/gsd-discuss-phase` | Discuss and scope a phase before planning |
| `/gsd-plan-phase` | Create executable plans with dependency analysis |
| `/gsd-execute-phase` | Run plans with automated verification |
| `/gsd-verify-work` | Validate built features through conversational UAT |

### Project planning state

Planning artifacts live in `.planning/`:

- `ROADMAP.md` -- milestone and phase definitions
- `STATE.md` -- current position, decisions, blockers
- `PROJECT.md` -- project identity and technical context
- `phases/` -- per-phase plans, summaries, and verification results

| Milestone | Shipped | Phases | Plans | Highlights |
|-----------|---------|--------|-------|------------|
| **v1.0 MVP** | 2026-03-10 | 7 | 21 | Object database, agent system, validation pipeline, code generation |
| **v1.1 Patch Quality** | 2026-03-14 | 5 | 13 | Help patch audit, aesthetic styling, layout refinements |
| **v2.0 Direct Editing** | 2026-03-17 | 7 | 19 | Lossless round-trip, search/mutation API, patch analysis, agent migration, v1.x cleanup |
| **v2.1 Iteration & Polish** | 2026-03-20 | — | — | Interactive iterate modes, version tracking, project lifecycle improvements |
| **v2.2 Gen~ Patterns & Hooks** | 2026-03-22 | — | — | Gen~ pattern library (19 .gendsp), finalize_patch hook, fsync reliability, gen-eq project |
| **v2.3 Reliability & Validation** | 2026-03-31 | — | — | Z-order API, auto-commit safety hooks, MSP outlet type verification (202 objects), patcher decomposition (GraphMixin/AnalysisMixin), integration tests on real patches, trigger enforcement hardening, round-trip text bug fix, external .gendsp validation, maxclass validation |
| **v2.3.1 DB Cleanup & Patches** | 2026-04-01 | — | — | Object DB cleanup (21 missing objects added, alias normalization, overrides cleanup), tape-wobble patch, rhythmic-sampler iteration, scala-synth v1.0 |
| **v2.4.0 Visual Organization** | 2026-04-05 | — | — | Obstacle-aware cord routing (dog-leg around intermediate objects), 21 live.* objects added to UI system, contrast-adaptive text colors, subpatcher grouping heuristic |
| **v3.0.0 Milestone Archive** | 2026-04-09 | 7 | 15 | v2.0 milestone archived — 26/26 requirements verified, full PROJECT.md evolution, retrospective |
| **v4.0 Package Integration** | 2026-04-15 | 6 | 17 | Package-aware DB (2,450 objects), bundled extraction (BEAP/Vizzie/Jitter), generation gating, agent intelligence, community stubs (10 packages), package critics |
| **v5.0 DB Schema Hardening + Validator Depth** | 2026-05-01 | 5 | 24 | `signal_role`/`domain_restricted`/`verified_installed` schema fields, deepened validation pipeline (Layers 1-5 with sub-layers), MSP outlet coverage sweep, Phase 31 layout/UX builders (labeled param banks, overlay readouts, safe box replacement, M4L gen-synth), dsp_sim pre-flight simulation |
| **v6.0.0 Non-destructive Validation + Safe Saves** | 2026-10-23 | — | — | Fix-plan Q1-Q40 + review fixes: non-destructive `validate_patch` + `apply_fixes`, per-scope validation and critics, save gate (`PatchValidationError`, `LayoutRefusedError`), byte-identical no-op saves for every Max layout, `edit_patch` sessions + semantic diff, Q23 vocabulary checks, codebox smoke test, `/max-diagnose`, `/max-verify --live`, critic quick fixes, M4L device builder + `.amxd` export (experimental), npm trusted publishing. See [CHANGELOG.md](CHANGELOG.md) |
| **v6.1.0 Vision Package** | 2026-10-25 | — | — | Cycling '74 Vision 1.0.2 in the object DB (22 `jit.vis.*` entries, Max 9.2+), `dict.unpack` variable outlet count. See [CHANGELOG.md](CHANGELOG.md) |

## License

This project is licensed under the [MIT License](LICENSE).
