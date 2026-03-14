# Roadmap: MaxSystem

## Milestones

- ✅ **v1.0 MVP** — Phases 1-7 (shipped 2026-03-10)
- 🚧 **v1.1 Patch Quality & Aesthetics** — Phases 8-12 (in progress)

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

### 🚧 v1.1 Patch Quality & Aesthetics (In Progress)

**Milestone Goal:** Improve the accuracy and visual quality of generated MAX patches through systematic object database auditing and aesthetic refinements.

**Phase Numbering:**
- Integer phases (8, 9, 10, 11, 12): Planned milestone work
- Decimal phases (e.g., 9.1): Urgent insertions (marked with INSERTED)

- [x] **Phase 8: Help Patch Audit Pipeline** — Build offline audit tool that parses 973 .maxhelp files and extracts ground truth object metadata (completed 2026-03-13)
- [ ] **Phase 9: Object DB Corrections** — Review audit results and merge verified corrections into overrides.json
- [x] **Phase 10: Aesthetic Foundations** — Add comment styling, panels, patcher backgrounds, and visual polish to generated patches (completed 2026-03-13)
- [x] **Phase 11: Layout Refinements** — Improve object positioning with better sizing, inlet alignment, grid snapping, and configurable options (completed 2026-03-13)
- [x] **Phase 12: Pipeline Integration & Agent Updates** — Wire aesthetics and layout into generate_patch() and update agent documentation (completed 2026-03-14)

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

## Progress

**Execution Order:**
Phases execute in numeric order: 8 -> 9 -> 10 -> 11 -> 12
Note: Phase 10 can begin before Phase 9 completes (independent files). Phase 11 can begin after Phase 8 completes.

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
| 9. Object DB Corrections | v1.1 | 0/2 | Not started | - |
| 10. Aesthetic Foundations | v1.1 | 2/2 | Complete | 2026-03-13 |
| 11. Layout Refinements | v1.1 | 3/3 | Complete | 2026-03-13 |
| 12. Pipeline Integration & Agent Updates | 2/2 | Complete   | 2026-03-14 | - |

---
*Roadmap created: 2026-03-08*
*Last updated: 2026-03-14 -- Phase 12 planned (2 plans)*
