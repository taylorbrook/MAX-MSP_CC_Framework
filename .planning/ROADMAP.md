# Roadmap: MaxSystem

## Overview

MaxSystem delivers a Claude Code development framework for MAX/MSP in five phases following the dependency chain: Object Knowledge Base (root of everything) -> Patch Generation (first working output) -> Code Generation (Gen~/js/Node) -> Agent System and Orchestration (multiplier on existing capabilities) -> RNBO and External Development (highest complexity expansion). Each phase delivers a complete, verifiable capability that the next phase builds on.

## Phases

**Phase Numbering:**
- Integer phases (1, 2, 3): Planned milestone work
- Decimal phases (2.1, 2.2): Urgent insertions (marked with INSERTED)

Decimal phases appear between their surrounding integers in numeric order.

- [x] **Phase 1: Object Knowledge Base** - Structured database of MAX objects extracted from refpages with domain, type, and version metadata
- [x] **Phase 2: Patch Generation and Validation** - End-to-end .maxpat file generation with layout engine and multi-layer validation pipeline
- [ ] **Phase 3: Code Generation** - Gen~ GenExpr, js/V8, and Node for Max code generation with syntax validation
- [ ] **Phase 4: Agent System and Orchestration** - Domain-specialized agents, generator-critic loops, persistent memory, multi-project isolation, and slash commands
- [ ] **Phase 5: RNBO and External Development** - RNBO-compatible patch generation with export awareness and C/C++ external scaffolding via Min-DevKit

## Phase Details

### Phase 1: Object Knowledge Base
**Goal**: Claude has a comprehensive, structured knowledge base of MAX objects that prevents hallucination and enables accurate patch generation
**Depends on**: Nothing (first phase)
**Requirements**: ODB-01, ODB-02, ODB-03, ODB-04, ODB-05, ODB-06, ODB-07, FRM-04
**Success Criteria** (what must be TRUE):
  1. Framework can look up any common MAX object and retrieve its name, maxclass, inlet count, outlet count, arguments, and message types
  2. Object database contains entries sourced from MAX installation XML refpages, py2max MaxRef, and manual curation -- not just one source
  3. Each object entry includes its domain (Max, MSP, Jitter, MC), signal vs control inlet/outlet types, and MAX 8/9 version compatibility
  4. RNBO-compatible objects are identifiable as a distinct subset within the database
  5. CLAUDE.md exists with MAX/MSP development rules, object reference guidance, and conventions that Claude follows during generation
**Plans**: 3 plans

Plans:
- [x] 01-01-PLAN.md -- Extract all MAX XML refpages into domain-organized JSON files with test scaffold
- [x] 01-02-PLAN.md -- Enrich database with RNBO flags, version tags, aliases, relationships, and overrides
- [x] 01-03-PLAN.md -- Create CLAUDE.md development rules and database validation script

### Phase 2: Patch Generation and Validation
**Goal**: Framework generates .maxpat files that open in MAX without errors, with readable layout and validated connections
**Depends on**: Phase 1
**Requirements**: PAT-01, PAT-02, PAT-03, PAT-04, PAT-05, PAT-06, PAT-07, PAT-08, FRM-05
**Success Criteria** (what must be TRUE):
  1. Generated .maxpat files open in MAX without errors and display the expected objects and connections
  2. Subpatchers and bpatchers generate correctly as nested patchers within the parent patch
  3. Connection validation catches outlet/inlet index out-of-bounds and signal-to-control type mismatches before output
  4. Objects are positioned with top-to-bottom signal flow, readable spacing (~80-120px vertical, ~150-200px horizontal), and no overlaps
  5. Multi-layer validation pipeline runs automatically: JSON structure validity, object existence against database, connection bounds and type checks, domain-specific rules
**Plans**: 4 plans

Plans:
- [x] 02-01-PLAN.md -- Core data model (Patcher/Box/Patchline), object database interface, maxclass resolution, box sizing
- [x] 02-02-PLAN.md -- Column-based layout engine with topological sort and spacing
- [x] 02-03-PLAN.md -- Four-layer validation pipeline with auto-fix and domain rules
- [x] 02-04-PLAN.md -- Public API, file write hooks, end-to-end integration tests

### Phase 3: Code Generation
**Goal**: Claude generates valid Gen~ GenExpr DSP code, js/V8 scripts, and Node for Max JavaScript that integrate correctly with MAX patches
**Depends on**: Phase 2
**Requirements**: CODE-01, CODE-02, CODE-03, CODE-04, CODE-05
**Success Criteria** (what must be TRUE):
  1. Generated Gen~ GenExpr code uses correct syntax (in/out keywords, Param declarations, C-style operators) and passes syntax validation
  2. Gen~ codebox objects embed correctly in .maxpat patches, and standalone .gendsp files generate for Gen~ patchers
  3. Node for Max (node.script) JavaScript generates with correct MAX API integration (handlers, post function, Dict access)
  4. js object V8 JavaScript generates with correct patcher API access (inlets, outlets, bang/msg_int/msg_float handlers)
**Plans**: 2 plans

Plans:
- [ ] 03-01-PLAN.md -- GenExpr code builder, gen~ codebox embedding in .maxpat, standalone .gendsp generation
- [ ] 03-02-PLAN.md -- N4M and js code generation, code validation (GenExpr/js/N4M), hook extension for .gendsp/.js

### Phase 4: Agent System and Orchestration
**Goal**: Domain-specialized agents with critic validation loops, persistent memory, and project lifecycle management enable Claude to work across MAX projects with accumulated expertise
**Depends on**: Phase 3
**Requirements**: AGT-01, AGT-02, AGT-03, AGT-04, AGT-05, AGT-06, AGT-07, FRM-01, FRM-02, FRM-03, FRM-06
**Success Criteria** (what must be TRUE):
  1. Domain-specialized agents exist for patch generation, DSP/Gen~, RNBO~, js/Node, externals, and UI/layout -- each loaded with relevant knowledge base context
  2. Generator-critic validation loops catch errors before user sees output: DSP critic checks signal flow and audio rate consistency, connection critic validates object usage and architecture
  3. Agent memory persists learned patterns across sessions and projects, with write-back on session completion and deduplication of stored patterns
  4. Each MAX project is isolated in its own directory with independent context, state, and status tracking
  5. Slash commands orchestrate the project lifecycle (ideation, research, planning, execution, verification) and a structured manual testing protocol exists for features requiring MAX to validate
**Plans**: TBD

Plans:
- [ ] 04-01: TBD
- [ ] 04-02: TBD

### Phase 5: RNBO and External Development
**Goal**: Framework generates RNBO-compatible patches with export target awareness and scaffolds C/C++ external projects with build system support
**Depends on**: Phase 4
**Requirements**: CODE-06, CODE-07, EXT-01, EXT-02, EXT-03, EXT-04, EXT-05
**Success Criteria** (what must be TRUE):
  1. RNBO~ patches generate using only the RNBO-compatible object subset, with validation rejecting non-RNBO objects
  2. RNBO~ generation is aware of export targets (VST3/AU, Web Audio, C++) and constrains patches accordingly
  3. C/C++ external project scaffolding generates correct directory structure and CMake/build system files for Min-DevKit
  4. External code generation produces inlet/outlet setup, message handling, and DSP processing methods that compile on macOS (Apple Silicon)
**Plans**: TBD

Plans:
- [ ] 05-01: TBD
- [ ] 05-02: TBD

## Progress

**Execution Order:**
Phases execute in numeric order: 1 -> 2 -> 3 -> 4 -> 5

| Phase | Plans Complete | Status | Completed |
|-------|----------------|--------|-----------|
| 1. Object Knowledge Base | 3/3 | Complete | 2026-03-09 |
| 2. Patch Generation and Validation | 4/4 | Complete | 2026-03-10 |
| 3. Code Generation | 1/2 | In Progress|  |
| 4. Agent System and Orchestration | 0/? | Not started | - |
| 5. RNBO and External Development | 0/? | Not started | - |

---
*Roadmap created: 2026-03-08*
*Last updated: 2026-03-10 (Phase 03 planned -- 2 plans in 2 waves)*
