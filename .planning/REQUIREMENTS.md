# Requirements: MaxSystem

**Defined:** 2026-03-08
**Core Value:** Claude can generate valid, well-structured MAX/MSP patches and code that an expert user opens in MAX and they work -- with as much automated validation as possible before manual testing.

## v1 Requirements

Requirements for initial release. Each maps to roadmap phases.

### Object Database

- [x] **ODB-01**: Framework includes structured knowledge base of MAX objects with name, maxclass, inlets, outlets, arguments, and message types
- [x] **ODB-02**: Object database sourced from MAX installation XML refpages (1,924 files), py2max MaxRef, and manual curation
- [x] **ODB-03**: Objects version-tagged for MAX 8 vs MAX 9 compatibility
- [x] **ODB-04**: MAX 9 objects included (ABL devices, step sequencer, array, string objects)
- [x] **ODB-05**: Object entries include domain classification (Max, MSP, Jitter, MC)
- [x] **ODB-06**: Object entries include signal vs control inlet/outlet types
- [x] **ODB-07**: RNBO-compatible object subset marked separately in database

### Patch Generation

- [x] **PAT-01**: Framework generates valid .maxpat JSON files that open in MAX without errors
- [x] **PAT-02**: Generated patches include correct patcher wrapper, boxes array, and lines array structure
- [x] **PAT-03**: Subpatcher and bpatcher generation supported (nested patchers)
- [x] **PAT-04**: Connection validation checks outlet/inlet index bounds before output
- [x] **PAT-05**: Connection validation enforces signal/control type matching (MSP outlets to MSP inlets)
- [x] **PAT-06**: Patch layout engine positions objects with top-to-bottom signal flow convention
- [x] **PAT-07**: Layout engine spaces objects readably (~80-120px vertical, ~150-200px horizontal)
- [x] **PAT-08**: Multi-layer validation pipeline: JSON validity, object existence, connection bounds, domain-specific checks

### Code Generation

- [x] **CODE-01**: Gen~ GenExpr code generation with correct syntax (in/out keywords, Param declarations, C-style operators)
- [x] **CODE-02**: Gen~ codebox objects embedded correctly in .maxpat patches
- [x] **CODE-03**: Standalone .gendsp file generation for Gen~ patchers
- [x] **CODE-04**: Node for Max (node.script) JavaScript generation with MAX API integration
- [x] **CODE-05**: js object V8 JavaScript generation with patcher API access
- [ ] **CODE-06**: RNBO~ patch generation using only RNBO-compatible object subset
- [ ] **CODE-07**: RNBO~ export target awareness (VST3/AU, Web Audio, C++)

### External Development

- [x] **EXT-01**: C/C++ MAX external project scaffolding (directory structure, CMake/build system)
- [x] **EXT-02**: External development supports Min-DevKit and/or Max SDK (research determines choice)
- [x] **EXT-03**: External inlet/outlet setup and message handling code generation
- [x] **EXT-04**: External DSP processing method generation for audio objects
- [ ] **EXT-05**: External build and compilation support for macOS (Apple Silicon)

### Agent System

- [x] **AGT-01**: Domain-specialized agents for patch generation, DSP/Gen~, RNBO~, js/Node, externals
- [x] **AGT-02**: UI/layout specialist agent handling both presentation mode and patching mode
- [x] **AGT-03**: Generator-critic validation loops -- critics review output before user sees it
- [x] **AGT-04**: DSP critic checks signal flow, audio rate consistency, feedback loops
- [x] **AGT-05**: Connection/structure critic validates object usage and patch architecture
- [x] **AGT-06**: Persistent agent memory -- learned patterns accumulate across sessions and projects
- [x] **AGT-07**: Agent memory write-back on session completion with deduplication

### Framework

- [x] **FRM-01**: Multi-project isolation -- each MAX project gets its own directory, context, and state
- [x] **FRM-02**: Slash commands for project lifecycle: ideation, research, planning, execution, verification
- [x] **FRM-03**: Project status tracking per MAX project (stage, phase, completion state)
- [x] **FRM-04**: CLAUDE.md with MAX/MSP development rules, conventions, and object reference guidance
- [x] **FRM-05**: Hooks for pre/post validation (file writes trigger patch validation)
- [x] **FRM-06**: Structured manual testing protocol for features requiring MAX to validate

## v2 Requirements

Deferred to future release. Tracked but not in current roadmap.

### Templates & Patterns

- **TMPL-01**: Template library for common synthesis patterns (subtractive, FM, granular, additive)
- **TMPL-02**: Template library for common effects (delay, reverb, filter, distortion)
- **TMPL-03**: Template library for sequencing patterns (step, euclidean, generative)
- **TMPL-04**: Template library for control patterns (MIDI I/O, OSC, sensor input)
- **TMPL-05**: Composable templates -- synth templates droppable into sequencer templates

### Advanced Features

- **ADV-01**: Intelligent object selection -- context-aware recommendations based on task
- **ADV-02**: MAX for Live integration (Live API, device types, parameter mapping)
- **ADV-03**: Deep Jitter support (specialized agents, validation, templates for video/GL)
- **ADV-04**: Patch-from-description natural language interface

## Out of Scope

| Feature | Reason |
|---------|--------|
| Real-time MAX control via OSC/MCP | Claude cannot process audio; creates fragile dependency on MAX running |
| Patch-from-screenshot analysis | .maxpat JSON is the source of truth; screenshots are lossy |
| Automatic patch complexity management | Overrides expert user's architectural judgment |
| py2max as runtime dependency | Adds Python overhead; extract knowledge instead |
| Agent teams for patch generation | Single-file conflict; use teams for read-only research/review only |
| MAX for Live (v1) | Separate domain with its own API; defer until standalone MAX is solid |

## Traceability

Which phases cover which requirements. Updated during roadmap creation.

| Requirement | Phase | Status |
|-------------|-------|--------|
| ODB-01 | Phase 1 | Complete |
| ODB-02 | Phase 1 | Complete |
| ODB-03 | Phase 1 | Complete |
| ODB-04 | Phase 1 | Complete |
| ODB-05 | Phase 1 | Complete |
| ODB-06 | Phase 1 | Complete |
| ODB-07 | Phase 1 | Complete |
| PAT-01 | Phase 2 | Complete |
| PAT-02 | Phase 2 | Complete |
| PAT-03 | Phase 2 | Complete |
| PAT-04 | Phase 2 | Complete |
| PAT-05 | Phase 2 | Complete |
| PAT-06 | Phase 2 | Complete |
| PAT-07 | Phase 2 | Complete |
| PAT-08 | Phase 2 | Complete |
| CODE-01 | Phase 3 | Complete |
| CODE-02 | Phase 3 | Complete |
| CODE-03 | Phase 3 | Complete |
| CODE-04 | Phase 3 | Complete |
| CODE-05 | Phase 3 | Complete |
| CODE-06 | Phase 5 | Pending |
| CODE-07 | Phase 5 | Pending |
| EXT-01 | Phase 5 | Complete |
| EXT-02 | Phase 5 | Complete |
| EXT-03 | Phase 5 | Complete |
| EXT-04 | Phase 5 | Complete |
| EXT-05 | Phase 5 | Pending |
| AGT-01 | Phase 4 | Complete |
| AGT-02 | Phase 4 | Complete |
| AGT-03 | Phase 4 | Complete |
| AGT-04 | Phase 4 | Complete |
| AGT-05 | Phase 4 | Complete |
| AGT-06 | Phase 4 | Complete |
| AGT-07 | Phase 4 | Complete |
| FRM-01 | Phase 4 | Complete |
| FRM-02 | Phase 4 | Complete |
| FRM-03 | Phase 4 | Complete |
| FRM-04 | Phase 1 | Complete |
| FRM-05 | Phase 2 | Complete |
| FRM-06 | Phase 4 | Complete |

**Coverage:**
- v1 requirements: 40 total
- Mapped to phases: 40
- Unmapped: 0

---
*Requirements defined: 2026-03-08*
*Last updated: 2026-03-10 after Plan 02-04 completion (Phase 2 complete, FRM-05 complete)*
