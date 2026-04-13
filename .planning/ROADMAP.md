# Roadmap: MaxSystem

## Milestones

- ✅ **v1.0 MVP** — Phases 1-7 (shipped 2026-03-10)
- ✅ **v1.1 Patch Quality & Aesthetics** — Phases 8-12 (shipped 2026-03-14)
- ✅ **v3.0.0 Direct .maxpat Editing** — Phases 13-19 (shipped 2026-04-09)
- **v4.0 Package Integration** — Phases 20-25

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

<details>
<summary>✅ v3.0.0 Direct .maxpat Editing (Phases 13-19) — SHIPPED 2026-04-09</summary>

- [x] Phase 13: Round-Trip Foundation (3/3 plans) — completed 2026-03-16
- [x] Phase 14: Search and Mutation Primitives (2/2 plans) — completed 2026-03-16
- [x] Phase 15: Intelligent Editing (3/3 plans) — completed 2026-03-16
- [x] Phase 16: Patch Analysis (1/1 plan) — completed 2026-03-16
- [x] Phase 17: Agent and Command Migration (3/3 plans) — completed 2026-03-16
- [x] Phase 18: v1.x Cleanup (2/2 plans) — completed 2026-03-16
- [x] Phase 19: Tech Debt Cleanup (1/1 plan) — completed 2026-03-17

Full details: `.planning/milestones/v2.0-ROADMAP.md`

</details>

### v4.0 Package Integration

**Milestone Goal:** Integrate MAX packages (bundled + community) into the framework at full parity with core domains -- object DB entries, extraction pipelines, per-patch package gating, agent intelligence, and starter templates.

- [ ] **Phase 20: DB Schema Foundation** - Package field on every object, package registry, per-package subdirectories, ObjectDatabase extensions
- [ ] **Phase 21: Bundled Package Extraction** - AbstractionExtractor for BEAP/Vizzie bpatchers, XML pipeline for Jitter Geo/Tools, signal type inference
- [ ] **Phase 22: Generation & Gating** - DB-driven add_box() routing, per-patch package permission prompts, validation warnings
- [ ] **Phase 23: Agent Intelligence** - Router dispatch by package, relationships.json, SKILL.md updates, BEAP domain rules, layout overrides
- [ ] **Phase 24: Community & Licensed Packages** - Stub entries for 11 packages, extraction commands for installed packages, install guidance
- [ ] **Phase 25: Templates & Critics** - Starter templates, package-aware critics, /max-new integration

## Phase Details

### Phase 20: DB Schema Foundation
**Goal**: Every object in the database knows its source package, and ObjectDatabase supports package-aware queries and filtering
**Depends on**: Phase 19 (v3.0.0 complete)
**Requirements**: DBSI-01, DBSI-02, DBSI-03, DBSI-04, DBSI-05, DBSI-06
**Success Criteria** (what must be TRUE):
  1. `db.lookup("cycle~")` returns an object with `"package": null` (core) and `db.lookup("abl.live.gain~")` returns `"package": "ableton-dsp"`
  2. `db.list_packages()` returns all known package names; `db.get_package_objects("ableton-dsp")` returns the 74 abl.* objects
  3. `db.lookup("bp.Oscillator", allowed_packages=["beap"])` succeeds while `db.lookup("bp.Oscillator", allowed_packages=[])` returns None
  4. Per-package subdirectories exist (`packages/beap/objects.json`, `packages/vizzie/objects.json`, etc.) and existing 87 abl.*/mira.* objects are migrated there
  5. `package_info.json` exists with name, tier, version, install method, prefix, and description for every known package
**Plans**: TBD

### Phase 21: Bundled Package Extraction
**Goal**: All bundled MAX packages have complete, verified DB entries with correct inlet/outlet counts and signal types
**Depends on**: Phase 20
**Requirements**: EXTR-01, EXTR-02, EXTR-03, EXTR-04, EXTR-05, EXTR-06, EXTR-07
**Success Criteria** (what must be TRUE):
  1. BEAP modules (~168) have DB entries with correct inlet count, outlet count, and signal/control type per port (verified against help patches)
  2. Vizzie modules (~110) have DB entries with correct inlet and outlet counts
  3. Jitter Geometry (~27) and Jitter Tools (~99) objects extracted and present in DB under their respective package subdirectories
  4. Signal type inference correctly distinguishes signal vs control inlets/outlets from bpatcher connection topology (spot-checked against known BEAP modules)
  5. Inlet/outlet descriptions extracted from help patches or presentation-mode comments where available
**Plans**: TBD

### Phase 22: Generation & Gating
**Goal**: Agents never silently use package objects without explicit per-patch user permission, and bpatcher-based packages generate correctly
**Depends on**: Phase 20
**Requirements**: GENG-01, GENG-02, GENG-03, GENG-04, GENG-05
**Success Criteria** (what must be TRUE):
  1. `add_box("bp.Oscillator")` auto-routes to `add_bpatcher()` with correct dimensions and outlet types from DB metadata
  2. `/max-build` prompts user for per-patch package permission before generating any package objects (not silently included)
  3. `/max-iterate` prompts user before introducing package objects not already present in the patch being edited
  4. Validation Layer 2 emits a warning when a patch contains package objects that were not explicitly approved for that patch
  5. `add_bpatcher()` auto-populates outlet types and dimensions from DB metadata when creating bpatcher-based package modules
**Plans**: TBD

### Phase 23: Agent Intelligence
**Goal**: Agents have deep, package-specific knowledge that produces correct patterns, not just correct object names
**Depends on**: Phase 20
**Requirements**: AGNT-01, AGNT-02, AGNT-03, AGNT-04, AGNT-05
**Success Criteria** (what must be TRUE):
  1. Agent router dispatches to correct specialist when user mentions BEAP, Vizzie, FluCoMa, Bach, or other package keywords
  2. `relationships.json` contains package-specific companion pairs (BEAP module chains, Vizzie processing chains) and agents use them for suggestions
  3. BEAP patches do not trigger false positive DSP critic warnings for +/-5V signal range conventions
  4. Layout engine applies bpatcher-specific dimension overrides (larger than standard newobj) when placing BEAP/Vizzie modules
  5. All relevant agent SKILL.md files contain package-specific guidance sections covering domain conventions and common workflows
**Plans**: TBD

### Phase 24: Community & Licensed Packages
**Goal**: All 11 community/licensed packages have DB presence, and users with installed packages can extract full DB entries
**Depends on**: Phase 20
**Requirements**: COMM-01, COMM-02, COMM-03, COMM-04, EXTR-08
**Success Criteria** (what must be TRUE):
  1. All 11 community packages (FluCoMa, CNMAT, Bach, Odot, ml.*, IRCAM Spat, RNBO, Cage, Dada, EARS, Rhythmic & Time Toolkit) have stub entries in the DB with package name, prefix, and install instructions
  2. Stub entries are flagged with `extracted: false` and agents can distinguish stubs from fully extracted entries
  3. Running extraction commands against an installed community package populates full DB entries (tested with at least one package if available)
  4. When an agent references a stub object, it surfaces install guidance to the user rather than silently failing
**Plans**: TBD

### Phase 25: Templates & Critics
**Goal**: Users can scaffold new patches from package-specific templates, and critics catch package-specific mistakes
**Depends on**: Phase 21, Phase 23, Phase 24
**Requirements**: TMPL-01, TMPL-02, TMPL-03, TMPL-04
**Success Criteria** (what must be TRUE):
  1. Starter templates exist for at least 3 package workflows (BEAP subtractive synth, Vizzie VJ chain, FluCoMa analysis pipeline)
  2. BEAP critic detects silent-patch conditions (missing audio output module) and signal convention violations
  3. Bach critic detects llll type mismatches (standard MAX list connected where llll expected)
  4. `/max-new` offers package-specific templates during project scaffolding when the user has selected relevant packages
**Plans**: TBD
**UI hint**: yes

## Progress

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
| 13. Round-Trip Foundation | v3.0.0 | 3/3 | Complete | 2026-03-16 |
| 14. Search and Mutation Primitives | v3.0.0 | 2/2 | Complete | 2026-03-16 |
| 15. Intelligent Editing | v3.0.0 | 3/3 | Complete | 2026-03-16 |
| 16. Patch Analysis | v3.0.0 | 1/1 | Complete | 2026-03-16 |
| 17. Agent and Command Migration | v3.0.0 | 3/3 | Complete | 2026-03-16 |
| 18. v1.x Cleanup | v3.0.0 | 2/2 | Complete | 2026-03-16 |
| 19. Tech Debt Cleanup | v3.0.0 | 1/1 | Complete | 2026-03-17 |
| 20. DB Schema Foundation | v4.0 | 0/0 | Not started | - |
| 21. Bundled Package Extraction | v4.0 | 0/0 | Not started | - |
| 22. Generation & Gating | v4.0 | 0/0 | Not started | - |
| 23. Agent Intelligence | v4.0 | 0/0 | Not started | - |
| 24. Community & Licensed Packages | v4.0 | 0/0 | Not started | - |
| 25. Templates & Critics | v4.0 | 0/0 | Not started | - |

---
*Roadmap created: 2026-03-08*
*Last updated: 2026-04-13 -- v4.0 Package Integration roadmap finalized*
