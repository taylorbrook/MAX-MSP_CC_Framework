# Roadmap: MaxSystem

## Milestones

- ✅ **v1.0 MVP** — Phases 1-7 (shipped 2026-03-10)
- ✅ **v1.1 Patch Quality & Aesthetics** — Phases 8-12 (shipped 2026-03-14)
- 📋 **v2.0 Direct .maxpat Editing** — Phases 13-18 (planned)

## Phases

<details>
<summary>✅ v1.0 MVP (Phases 1-7) — SHIPPED 2026-03-10</summary>

- [x] Phase 1: Object Knowledge Base (3/3 plans) — completed 2026-03-09
- [x] Phase 2: Patch Generation and Validation (4/4 plans) — completed 2026-03-10
- [x] Phase 3: Code Generation (2/2 plans) — completed 2026-03-10
- [x] Phase 4: Agent System and Orchestration (6/6 plans) — completed 2026-03-10
- [x] Phase 5: RNBO and External Development (4/4 plans) — completed 2026-03-10
- [x] Phase 6: Fix Skill Documentation Signatures (1/1 plan) — completed 2026-03-10
- [x] Phase 7: Fix Stale Agent Documentation (1/1 plan) — completed 2026-03-10

Full details: `.planning/milestones/v1.0-ROADMAP.md`

</details>

<details>
<summary>✅ v1.1 Patch Quality & Aesthetics (Phases 8-12) — SHIPPED 2026-03-14</summary>

- [x] Phase 8: Help Patch Audit Pipeline (4/4 plans) — completed 2026-03-13
- [ ] Phase 9: Object DB Corrections (0/2 plans) — deferred (low priority, audit data available for manual use)
- [x] Phase 10: Aesthetic Foundations (2/2 plans) — completed 2026-03-13
- [x] Phase 11: Layout Refinements (3/3 plans) — completed 2026-03-13
- [x] Phase 12: Pipeline Integration & Agent Updates (2/2 plans) — completed 2026-03-14

Full details: see phase details below (archived in-place)

</details>

### 📋 v2.0 Direct .maxpat Editing (Planned)

**Milestone Goal:** Replace the Python generation pipeline with direct .maxpat reading and editing, making the .maxpat file the single source of truth and enabling true back-and-forth between Claude and manual MAX editing.

**Phase Numbering:**
- Integer phases (13, 14, 15, 16, 17, 18): Planned milestone work
- Decimal phases (e.g., 14.1): Urgent insertions if needed (marked with INSERTED)

- [x] **Phase 13: Round-Trip Foundation** — Harden from_dict/to_dict for lossless .maxpat load-save cycle (completed 2026-03-16)
- [ ] **Phase 14: Search and Mutation Primitives** — Find objects and make basic add/remove/connect edits on loaded patches
- [ ] **Phase 15: Intelligent Editing** — Higher-level edit operations: modify-in-place, insert-into-connection, replace, graph queries, auto-position
- [ ] **Phase 16: Patch Analysis** — Structured patch understanding for onboarding existing patches from any source
- [ ] **Phase 17: Agent and Command Migration** — Rewire slash commands and agent skills to use direct .maxpat editing
- [ ] **Phase 18: v1.x Cleanup** — Remove generation pipeline artifacts (incremental.py, generate.py, manifests)

## Phase Details

### Phase 8: Help Patch Audit Pipeline
**Goal**: The framework has a reliable, offline audit tool that extracts ground truth object metadata from MAX's own help patches and identifies every discrepancy in the current database
**Depends on**: Nothing (first phase in v1.1)
**Requirements**: AUDIT-01, AUDIT-02, AUDIT-03, AUDIT-04, AUDIT-05, AUDIT-06, AUDIT-07, AUDIT-08, AUDIT-09, AUDIT-10
**Success Criteria** (what must be TRUE):
  1. Running the audit tool against the MAX help patch directory parses all 973 .maxhelp files, including content inside subpatcher tabs, and reports per-file parse status
  2. The audit report shows outlet type discrepancies between the DB and help patches, with confidence scores, for every object where they differ
  3. The audit produces proposed overrides.json entries that preserve all existing manually corrected entries without overwriting them
  4. Per-object box width measurements are extracted from help patches and available as data for downstream layout work
  5. The 292 objects with empty inlet/outlet data in the current DB are identified, prioritized, and have proposed corrections where help patch data exists
**Plans**: 4 plans

Plans:
- [x] 08-01-PLAN.md -- Data models, recursive help patch parser, and degenerate instance filtering
- [x] 08-02-PLAN.md -- Analysis engine: outlet types, I/O counts, widths, arguments, connections
- [x] 08-03-PLAN.md -- Report generation, override proposals, and empty I/O coverage tracker
- [x] 08-04-PLAN.md -- CLI entry point and end-to-end verification against real MAX help patches

### Phase 9: Object DB Corrections
**Goal**: The object database contains verified, help-patch-sourced corrections so that connection validation and patch generation use accurate outlet types, inlet/outlet counts, and argument formats
**Depends on**: Phase 8
**Requirements**: DBCX-01, DBCX-02, DBCX-03, DBCX-04
**Success Criteria** (what must be TRUE):
  1. High-confidence outlet type corrections are merged into overrides.json and db_lookup.py returns the corrected data without any code changes
  2. Objects that previously had empty inlet/outlet data now have help-patch-verified I/O definitions
  3. All 624 existing tests pass after corrections are applied (zero regressions)
  4. Corrections are organized by domain in the audit report so each domain's changes can be reviewed independently
**Plans**: 2 plans

Plans:
- [ ] 09-01-PLAN.md -- OverrideMerger class, unit tests, and CLI --merge flag integration
- [ ] 09-02-PLAN.md -- Execute merge with conflict resolution, regression verification, and user approval

### Phase 10: Aesthetic Foundations
**Goal**: Generated patches include professional visual styling -- styled section comments, background panels, bubble annotations, patcher colors, and step markers -- so patches look authored rather than machine-generated
**Depends on**: Nothing (can run in parallel with Phase 9; touches different files)
**Requirements**: CMNT-01, CMNT-02, CMNT-03, CMNT-04, PANL-01, PANL-02, PANL-03, PANL-04, PANL-05, PTCH-01, PTCH-02
**Success Criteria** (what must be TRUE):
  1. A generated patch opened in MAX shows styled section header comments with configurable font size, bold face, and color -- visually distinct from inline annotations
  2. Panel objects appear behind grouped objects (not covering them) with correct background layer placement, and gradient panels render without visual artifacts
  3. Bubble comments with outlines and directional arrows appear next to annotated objects when opened in MAX
  4. Patcher background color is set on generated patches, and key architectural objects (loadbang, dac~) have distinguishing background color
  5. Numbered step markers using amber textbutton circles appear in the background layer for tutorial-style patches
**Plans**: 2 plans

Plans:
- [x] 10-01-PLAN.md -- Palette constants, comment tier styling (section/subsection/annotation/bubble), and patcher canvas/object background color API
- [x] 10-02-PLAN.md -- Panel objects with gradient fill and z-order, step marker textbutton circles, auto-sizing, and complexity heuristic

### Phase 11: Layout Refinements
**Goal**: Object positioning produces tighter, more professional layouts with accurate box sizing, aligned cables, grid-snapped positions, and configurable spacing parameters
**Depends on**: Phase 8 (uses per-object width data from audit); layout tests refactored before any constant changes
**Requirements**: LYOT-01, LYOT-02, LYOT-03, LYOT-04, LYOT-05, LYOT-06
**Success Criteria** (what must be TRUE):
  1. Object box widths in generated patches closely match actual MAX rendering widths (using per-object override table from help patch measurements)
  2. Child objects are positioned so their inlets align under parent outlet X positions, producing straighter vertical cables instead of diagonal ones
  3. All object positions in generated patches snap to MAX's 15px native grid
  4. Comments are placed near their target objects with consistent offset, and layout spacing is configurable via a LayoutOptions dataclass rather than hardcoded constants
**Plans**: 3 plans

Plans:
- [x] 11-01-PLAN.md -- LayoutOptions dataclass and test assertion refactoring for resilient spacing tests
- [x] 11-02-PLAN.md -- Width override table from audit data and sizing.py integration
- [x] 11-03-PLAN.md -- Inlet alignment, grid snapping, comment association, and LayoutOptions integration into layout engine

### Phase 12: Pipeline Integration & Agent Updates
**Goal**: Aesthetic styling and layout improvements are wired into the main patch generation pipeline so users get polished patches by default, and agent documentation reflects all corrected object data and new capabilities
**Depends on**: Phase 9, Phase 10, Phase 11
**Requirements**: AGNT-01, AGNT-02
**Success Criteria** (what must be TRUE):
  1. generate_patch() produces patches with aesthetic styling applied (panels, styled comments, patcher colors) without requiring manual post-processing
  2. Agent SKILL.md files reference corrected outlet types and connection patterns from audit findings, so agents generate valid connections for previously-broken objects
  3. Agent documentation describes aesthetic capabilities (comment styling, panels, layout options) so agents can use them when generating patches
**Plans**: 2 plans

Plans:
- [x] 12-01-PLAN.md -- Auto-styling in generate_patch(), LayoutOptions parameter and public API export
- [x] 12-02-PLAN.md -- Aesthetic capabilities documentation in all 6 agent SKILL.md files

### Phase 13: Round-Trip Foundation
**Goal**: Any .maxpat file can be loaded into Patcher objects and written back with zero data loss -- the trust foundation for all direct editing
**Depends on**: Nothing (first phase in v2.0)
**Requirements**: RW-01, RW-02, RW-06
**Success Criteria** (what must be TRUE):
  1. User can load any project .maxpat file (kicksynth, scala-synth, performancepatchtest, minitaur) into Patcher/Box/Patchline objects and all objects are present including recursive subpatchers
  2. Loading a .maxpat and immediately writing it back produces a file with minimal diff -- key ordering preserved, numeric precision maintained, unchanged portions identical
  3. All user state survives the load-save cycle -- positions, colors, presentation rects, varnames, scripting names, custom attributes, and unknown keys are not dropped or reordered
  4. Patchline attributes (color, midpoints, hidden) are preserved through round-trip -- the verified color-drop bug is fixed
  5. Bpatcher attributes (offset, name, args, embed, lockeddragscroll) reconstruct correctly and are not lost or misplaced on save
**Plans**: 3 plans

Plans:
- [ ] 13-01-PLAN.md -- Round-trip test suite, fixtures, and Patchline model fix (color, extra_attrs, _raw)
- [ ] 13-02-PLAN.md -- Box _raw dict preservation and Patcher key-order fix
- [ ] 13-03-PLAN.md -- Golden file integration tests passing for all 10 project .maxpat files

### Phase 14: Search and Mutation Primitives
**Goal**: Users can find objects in loaded patches and make basic structural edits (add, remove, connect) without disturbing existing content
**Depends on**: Phase 13
**Requirements**: RW-03, RW-04, RW-05, RW-07
**Success Criteria** (what must be TRUE):
  1. User can find objects by ID, name, maxclass, or text substring -- including recursive search into subpatchers
  2. User can add a new object to a loaded patch and it gets a unique ID, correct I/O counts from DB validation, and does not collide with any existing object
  3. User can remove an object from a loaded patch and all connected patchlines are automatically cleaned up -- no dangling connections remain
  4. User can add and remove connections between existing objects with inlet/outlet bounds checking that prevents invalid wiring
  5. A read_patch() convenience function loads a .maxpat from disk into a Patcher ready for querying and editing
**Plans**: TBD

### Phase 15: Intelligent Editing
**Goal**: Users can make sophisticated patch edits -- modify attributes in-place, insert objects into signal chains, swap objects, trace signal paths, and get smart auto-positioning
**Depends on**: Phase 14
**Requirements**: ED-01, ED-02, ED-03, ED-04, ED-05
**Success Criteria** (what must be TRUE):
  1. User can modify an object's arguments, position, color, or any attribute in-place without delete-and-recreate -- and I/O count recomputes when arguments change for variable_io objects
  2. User can insert an object into an existing connection (e.g., "insert *~ 0.5 between cycle~ and dac~") -- original connection removed, new object wired in between, auto-positioned at midpoint
  3. User can replace an object with a different one -- new object placed at same position, compatible connections remapped, incompatible connections listed in return value
  4. User can query the patch graph -- upstream/downstream traversal from any object, signal path tracing, connected component detection, with signal and control graphs separated
  5. New objects added near their connection context are auto-positioned intelligently -- below a source, above a target, between both, or in the nearest empty space
**Plans**: TBD

### Phase 16: Patch Analysis
**Goal**: The framework can analyze any .maxpat file and produce a structured, human-readable summary of what the patch does -- enabling /max-onboard for existing patches
**Depends on**: Phase 14 (uses search/query infrastructure), Phase 15 (uses graph traversal)
**Requirements**: AN-01, AN-02, AN-03
**Success Criteria** (what must be TRUE):
  1. Patch analyzer produces a structured summary including: object inventory by domain, signal flow chains (audio source to dac~), control flow paths, subpatcher hierarchy map, parameter list, and complexity metrics
  2. /max-onboard command takes any .maxpat file path, runs analysis, and outputs a human-readable summary that a user can review to understand the patch without opening MAX
  3. Analyzer identifies functional sections by detecting connected components and spatial proximity -- grouping objects into logical units (e.g., "oscillator section", "filter chain", "envelope generator")
**Plans**: TBD

### Phase 17: Agent and Command Migration
**Goal**: All slash commands and agent skills use direct .maxpat editing instead of the Python generation pipeline -- the user-visible behavior change
**Depends on**: Phase 13, Phase 14, Phase 15, Phase 16
**Requirements**: MG-01, MG-02, MG-03, MG-04, MG-05, MG-06
**Success Criteria** (what must be TRUE):
  1. /max-build creates patches by directly constructing Patcher objects and writing .maxpat files -- no generate.py script is created
  2. /max-iterate reads an existing .maxpat, understands its structure (via analyzer), makes surgical edits (via edit methods), and writes back -- no generate.py modification
  3. /max-new creates project structure with direct .maxpat workflow -- project scaffolding produces .maxpat files, not Python generation scripts
  4. /max-onboard is implemented as a working slash command that runs patch analysis and produces onboarding output
  5. All 6 specialist agent SKILL.md files reference the direct editing API (Patcher.from_dict, add_box, remove_box, find_box, etc.) instead of the generate.py workflow
  6. Validation hooks work with direct editing -- validate on demand after edits, do not reject unknown objects on load, write_patch_direct() never auto-layouts
**Plans**: TBD

### Phase 18: v1.x Cleanup
**Goal**: The old generation pipeline is fully removed -- no generate.py scripts, no manifests, no incremental.py -- the .maxpat file is the only artifact
**Depends on**: Phase 17
**Requirements**: CL-01, CL-02, CL-03, CL-04, CL-05
**Success Criteria** (what must be TRUE):
  1. incremental.py is deleted and its Manifest class, merge logic, and all imports are removed from the codebase -- no code references the manifest system
  2. All .manifest.json sidecar files are deleted from every patch directory in the project
  3. All generate.py and build_*.py scripts are deleted from patch directories -- .maxpat files stand alone without generation scripts
  4. Test suite covers the read-write path -- from_dict() has dedicated tests, write-only assumptions are replaced with round-trip tests, and the expand-then-contract migration keeps CI green throughout
  5. hooks.py write_patch uses the direct save path and merge_and_write is removed or raises a clear deprecation error
**Plans**: TBD

## Progress

**Execution Order:**
Phases execute in numeric order: 13 -> 14 -> 15 -> 16 -> 17 -> 18
Phase 16 (Analysis) could begin after Phase 14 completes, but depends on Phase 15 for graph traversal.

| Phase | Milestone | Plans Complete | Status | Completed |
|-------|-----------|----------------|--------|-----------|
| 1. Object Knowledge Base | v1.0 | 3/3 | Complete | 2026-03-09 |
| 2. Patch Generation and Validation | v1.0 | 4/4 | Complete | 2026-03-10 |
| 3. Code Generation | v1.0 | 2/2 | Complete | 2026-03-10 |
| 4. Agent System and Orchestration | v1.0 | 6/6 | Complete | 2026-03-10 |
| 5. RNBO and External Development | v1.0 | 4/4 | Complete | 2026-03-10 |
| 6. Fix Skill Documentation Signatures | v1.0 | 1/1 | Complete | 2026-03-10 |
| 7. Fix Stale Agent Documentation | v1.0 | 1/1 | Complete | 2026-03-10 |
| 8. Help Patch Audit Pipeline | v1.1 | 4/4 | Complete | 2026-03-13 |
| 9. Object DB Corrections | v1.1 | 0/2 | Deferred | - |
| 10. Aesthetic Foundations | v1.1 | 2/2 | Complete | 2026-03-13 |
| 11. Layout Refinements | v1.1 | 3/3 | Complete | 2026-03-13 |
| 12. Pipeline Integration & Agent Updates | v1.1 | 2/2 | Complete | 2026-03-14 |
| 13. Round-Trip Foundation | 3/3 | Complete   | 2026-03-16 | - |
| 14. Search and Mutation Primitives | v2.0 | 0/0 | Not started | - |
| 15. Intelligent Editing | v2.0 | 0/0 | Not started | - |
| 16. Patch Analysis | v2.0 | 0/0 | Not started | - |
| 17. Agent and Command Migration | v2.0 | 0/0 | Not started | - |
| 18. v1.x Cleanup | v2.0 | 0/0 | Not started | - |

---
*Roadmap created: 2026-03-08*
*Last updated: 2026-03-15 -- Phase 13 plans created (3 plans in 3 waves)*
