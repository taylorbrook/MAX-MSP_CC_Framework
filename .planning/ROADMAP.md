# Roadmap: MaxSystem

## Milestones

- ✅ **v1.0 MVP** — Phases 1-7 (shipped 2026-03-10)
- ✅ **v1.1 Patch Quality & Aesthetics** — Phases 8-12 (shipped 2026-03-14)
- ✅ **v3.0.0 Direct .maxpat Editing** — Phases 13-19 (shipped 2026-04-09)
- 📋 **v4.0 Package Integration** — Phases 20-25 (in progress)

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

### 📋 v4.0 Package Integration (In Progress)

**Goal:** Integrate MAX packages (bundled + community) into the framework at full parity with core domains -- object DB entries with validation, agent guidance, templates, critics, and install-aware gating.

Canonical refs: `.planning/milestones/v4.0-package-integration-PROPOSAL.md`

- [x] Phase 20: DB Schema Foundation (2/2 plans) — completed 2026-04-13
  - **Goal:** Add package awareness to the object database so every object knows its source package
  - Package field added to all objects, package registry created, ObjectDatabase API extended
  - **Requirements:** PKG-01, PKG-02, PKG-03, PKG-04

- [x] Phase 21: Bundled Package Extraction (BEAP + Vizzie) (completed 2026-04-14)
  - **Goal:** Extract BEAP and Vizzie abstractions into the object DB using a new abstraction parser
  - Build `extract_abstractions.py` for bpatcher-based packages, extract ~192 BEAP + ~110 Vizzie modules, also extract Jitter Geometry + Jitter Tools via XML pipeline
  - **Plans:** 3 plans
  - Plans:
    - [x] 21-01-PLAN.md — Build extract_abstractions.py and extract BEAP + Vizzie into DB
    - [x] 21-02-PLAN.md — Extend extract_objects.py for Jitter Geometry + Jitter Tools extraction
    - [x] 21-03-PLAN.md — Verification tests, I/O cross-checks, and registry updates
  - **Requirements:** PKG-05, PKG-06, PKG-07, PKG-08

- [x] Phase 22: Package-Gated Generation (completed 2026-04-14)
  - **Goal:** Ensure agents never silently use package objects the user hasn't confirmed
  - Package selection in project config, `/max-new` and `/max-build` prompt for packages, ObjectDatabase filtering via allowed_packages
  - **Plans:** 3 plans
  - Plans:
    - [x] 22-01-PLAN.md — Project config read/write functions and package_info.json completion
    - [x] 22-02-PLAN.md — Patcher/Box allowed_packages threading and validation pipeline layer
    - [x] 22-03-PLAN.md — Agent SKILL.md updates for package selection and gating
  - **Requirements:** PKG-09, PKG-10, PKG-11, PKG-12, PKG-13
  - Depends on: Phase 20

- [x] Phase 23: Agent Package Intelligence (completed 2026-04-15)
  - **Goal:** Give agents deep knowledge of package-specific patterns, conventions, and workflows
  - DB-driven bpatcher sizing, adaptive layout spacing, PACKAGES.md shared reference, package relationship entries, per-agent SKILL.md guidance, parity tests
  - **Plans:** 3 plans
  - Plans:
    - [x] 23-01-PLAN.md — DB-driven bpatcher sizing and adaptive layout spacing
    - [x] 23-02-PLAN.md — PACKAGES.md shared reference and relationship entries
    - [x] 23-03-PLAN.md — Agent SKILL.md package intelligence sections and parity tests
  - **Requirements:** PKG-14, PKG-15, PKG-16, PKG-17, PKG-18

- [ ] Phase 24: Community Package Support
  - **Goal:** Provide DB presence for community packages even when not locally installed
  - Stub DB entries for FluCoMa, CNMAT, Bach, Odot, ml.*, IRCAM Spat; extraction commands for installed packages
  - **Plans:** 3 plans
  - Plans:
    - [ ] 24-01-PLAN.md — Curated stub entries for all 10 community packages
    - [ ] 24-02-PLAN.md — --package CLI flag for community package extraction
    - [ ] 24-03-PLAN.md — Validation block gate and agent install guidance
  - **Requirements:** PKG-19, PKG-20, PKG-21, PKG-22
  - Depends on: Phase 20

- [ ] Phase 25: Templates + Critics
  - **Goal:** Provide starter templates and package-aware validation for common package workflows
  - Starter templates per package, package-aware critics (BEAP signal conventions, Bach llll checker), template integration with `/max-new`
  - **Requirements:** PKG-23, PKG-24, PKG-25, PKG-26
  - Depends on: Phase 23, Phase 24

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
| 20. DB Schema Foundation | v4.0 | 2/2 | Complete | 2026-04-13 |
| 21. Bundled Package Extraction | v4.0 | 3/3 | Complete    | 2026-04-14 |
| 22. Package-Gated Generation | v4.0 | 3/3 | Complete   | 2026-04-14 |
| 23. Agent Package Intelligence | v4.0 | 3/3 | Complete    | 2026-04-15 |
| 24. Community Package Support | v4.0 | 0/3 | Planned | - |
| 25. Templates + Critics | v4.0 | 0/0 | Planned | - |

---
*Roadmap created: 2026-03-08*
*Last updated: 2026-04-15 -- Phase 24 planned (3 plans)*
