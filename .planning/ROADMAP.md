# Roadmap: MaxSystem

## Milestones

- ✅ **v1.0 MVP** — Phases 1-7 (shipped 2026-03-10)
- ✅ **v1.1 Patch Quality & Aesthetics** — Phases 8-12 (shipped 2026-03-14)
- ✅ **v3.0.0 Direct .maxpat Editing** — Phases 13-19 (shipped 2026-04-09)
- ✅ **v4.0 Package Integration** — Phases 20-25 (shipped 2026-04-15)
- 🚧 **v5.0 DB Schema Hardening + Validator Depth** — Phases 28-32 (started 2026-04-27)

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

<details>
<summary>✅ v4.0 Package Integration (Phases 20-25) — SHIPPED 2026-04-15</summary>

- [x] Phase 20: DB Schema Foundation (2/2 plans) — completed 2026-04-13
- [x] Phase 21: Bundled Package Extraction (3/3 plans) — completed 2026-04-14
- [x] Phase 22: Package-Gated Generation (3/3 plans) — completed 2026-04-14
- [x] Phase 23: Agent Package Intelligence (3/3 plans) — completed 2026-04-15
- [x] Phase 24: Community Package Support (3/3 plans) — completed 2026-04-15
- [x] Phase 25: Templates + Critics (3/3 plans) — completed 2026-04-15

Full details: `.planning/milestones/v4.0-ROADMAP.md`

</details>

### 🚧 v5.0 DB Schema Hardening + Validator Depth (Phases 28-32)

- [x] **Phase 28: Schema Foundation** — Typed signal_role / domain_restricted / verified_installed fields land in overrides + db_lookup with back-compat shim (completed 2026-04-28)
- [x] **Phase 29: Validator Depth** — Layer-3 role-aware errors, RNBO domain hard guard, install-state warnings, external `.gendsp` validation (completed 2026-04-29)
- [x] **Phase 30: MSP Outlet Coverage Sweep** — Migrate 16 existing overrides + populate ~80 unverified MSP objects + bulk audit script (completed 2026-04-30)
- [ ] **Phase 31: Layout & UX Builders** — `add_overlay_readout`, `add_labeled_param_bank`, signal_role-aware companion pairs, `m4l_gen_synth` skeleton
- [ ] **Phase 32: DSP Pre-Flight Simulation** — numpy waveguide stability sweep harness wired into max-dsp-agent

Optional Phase 33 (Critic Tier Hardening) deferred — judgment call after Phase 29 lands. Promoted to scope only if empirical case is clear.

## Phase Details

### Phase 28: Schema Foundation
**Goal**: The object database carries per-outlet signal roles, domain restrictions, and install-verification status as typed first-class fields without breaking any existing consumer
**Depends on**: Nothing (foundation phase for v5.0)
**Requirements**: SCHEMA-01, SCHEMA-02, SCHEMA-03, SCHEMA-04, SCHEMA-05, SCHEMA-06, SCHEMA-07
**Success Criteria** (what must be TRUE):
  1. A developer can declare `signal_role: "audio" | "trigger" | "status" | "float" | "data" | "list"` on any outlet entry in `overrides.json` and `ObjectDatabase` exposes it via `get_signal_role(name, outlet)`
  2. Existing code that reads `outlet["signal"]` (boolean) continues to work unchanged — the boolean is derived from `signal_role` so no consumer breaks during migration
  3. A developer can mark an object `domain_restricted: ["rnbo"]` and query it via `db.is_domain_restricted(name)` to determine where it can legally appear
  4. A developer can mark an object `verified_installed: true/false` and query it via `db.is_verified_installed(name)` to know whether it was confirmed against `_pkg-source/`
  5. Three sibling audit functions — `db.audit_empty_io()` (unchanged), `db.audit_install_coverage()` (unverified-installed), `db.audit_domain_coverage()` (domain-restricted-without-coverage) — surface coverage gaps from focused entry points (per locked decision D-12)
**Plans**: 3 plans
- [x] 28-01-PLAN.md — Schema validation infrastructure (enums + fail-fast validator + signal_role write-through)
- [x] 28-02-PLAN.md — Five getter methods (get_signal_role, get_install_state, is_verified_installed, get_domain_restrictions, is_domain_restricted)
- [x] 28-03-PLAN.md — Audit functions + example fixtures + test suite (>=15 tests)

### Phase 29: Validator Depth
**Goal**: Validators and critics read the new schema and produce specific, actionable errors instead of generic type-mismatch warnings; external `.gendsp` files get the same DSP rigor as embedded codeboxes
**Depends on**: Phase 28
**Requirements**: VALID-01, VALID-02, VALID-03, VALID-04, VALID-05
**Success Criteria** (what must be TRUE):
  1. Connecting a `status` outlet directly to a signal inlet produces a Layer-3 error message naming the role mismatch and suggesting `snapshot~` (not a generic "type mismatch")
  2. Using an `rnbo`-only object (e.g. `floor~`) at MSP top level outside an `rnbo~` container blocks output with a hard error pointing at the domain restriction
  3. Using an object marked `verified_installed: false` (e.g. `bach.llll2list`) emits a lookup-time warning that names the object and the suspected install gap
  4. Saving a standalone `.gendsp` file runs the DSP critic with the same checks as embedded codeboxes — declaration-ordering, `Delay.read/write` vs `delay()`, init-before-if/else, `clip()` rejection
  5. Every validation finding clearly distinguishes `error` (blocks output) from `warning` (surfaces but allows) across all four new check families, so callers can reliably gate on severity
**Plans**: 5 plans
- [x] 29-01-PLAN.md — Install-state warning in db.lookup() (VALID-03)
- [x] 29-02-PLAN.md — GenExpr Checks 7/8/9 in validate_genexpr (VALID-04)
- [x] 29-03-PLAN.md — Layer 3 role-aware tier dispatch (VALID-01, VALID-05)
- [x] 29-04-PLAN.md — Layer 4b domain restriction guard (VALID-02, VALID-05)
- [x] 29-05-PLAN.md — Embedded gen~ codebox walker (VALID-04 parity, VALID-05)

### Phase 30: MSP Outlet Coverage Sweep
**Goal**: The typed signal-role contract is dense enough across MSP that role-aware validation (Phase 29) actually fires on real patches instead of falling back to the boolean shim
**Depends on**: Phase 28
**Requirements**: MSPCOV-01, MSPCOV-02, MSPCOV-03, MSPCOV-04, MSPCOV-05
**Success Criteria** (what must be TRUE):
  1. All ~16 existing MSP outlet-type overrides are migrated from `signal: bool` to `signal_role` and a developer can read role data on every previously-overridden object
  2. At least 80 previously unverified MSP objects (`saw~`, `*~`, `noise~`, `sig~`, `gen~`, `selector~`, etc. from the 260331-n24 flagged list) have per-outlet `signal_role` populated
  3. A developer can run a bulk audit script that classifies any remaining `signal: true` outlet by digest keyword (bang/done/index/status) and produces a candidate-overrides report
  4. The audit-script output is committed alongside the migration so future drift between extracted facts and curated roles is visible in git history
  5. Running `audit_empty_io()` and the new `audit_signal_role_coverage()` post-migration reports fewer than 20 remaining MSP gaps
**Plans**: TBD

### Phase 31: Layout & UX Builders
**Goal**: Layout/UX recipes that currently live as prose in CLAUDE.md become callable builder functions that agents invoke directly, with companion-pair smarts powered by the new `signal_role` data
**Depends on**: Phase 28
**Requirements**: LAYOUT-01, LAYOUT-02, LAYOUT-03, LAYOUT-04, LAYOUT-05
**Success Criteria** (what must be TRUE):
  1. A developer calls `p.add_overlay_readout(target, format=...)` and gets a properly z-ordered flonum/comment readout overlapping the target with `bring_to_front` + `ignoreclick=1` baked in
  2. A developer calls `p.add_labeled_param_bank(params, ...)` and gets a multislider sized `size×24` with `contdata=1`/`setstyle=1` plus pixel-aligned comment labels — no manual recipe required
  3. A developer creates a `gain~`, `meter~`, dial+flonum overlay, or live.dial+text-label and the framework auto-places the companion using `signal_role` (e.g. `status` outlets get readout overlays, `audio` outlets get meter companions)
  4. A developer calls `m4l_gen_synth(params=[...])` and gets a Live-ready `.amxd` skeleton with gen~ + `live.dial`s correctly bound via `param_connect`, no `gain~` before `plugout~`
  5. `max-patch-agent` and `max-ui-agent` reach all four builders via documented entry points — agents pick up the new APIs without prose-rule retraining
**Plans**: TBD
**UI hint**: yes

### Phase 32: DSP Pre-Flight Simulation
**Goal**: DSP stability bugs of the bassoon v0.4–0.5 class (high-Q-in-loop, group-vs-phase-delay) are caught by an offline numpy simulator before the patch ships, not after manual MAX testing
**Depends on**: Nothing (conceptually independent — could ship first or last in v5.0)
**Requirements**: DSPSIM-01, DSPSIM-02, DSPSIM-03, DSPSIM-04, DSPSIM-05
**Success Criteria** (what must be TRUE):
  1. A developer imports `src/maxpat/dsp_sim/` and runs a sample-accurate waveguide loop simulation with arbitrary Param sweeps
  2. The simulator measures fundamental stability via autocorrelation/FFT and flags Q values where the loop fails to oscillate or drifts off-frequency
  3. `max-dsp-agent` invokes the simulator before committing waveguide patches and surfaces the stability report in its summary — the agent will not commit a patch that fails its own simulation
  4. The simulator detects both the high-Q-in-loop failure mode and the group-vs-phase-delay failure mode that motivated the bassoon-model rework, validated against the known-bad bassoon v0.4 fixture
  5. Simulator output is reproducible from a `(patch_path, param_name, sweep_range)` triple so any failure can be reduced to a regression test
**Plans**: TBD

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
| 24. Community Package Support | v4.0 | 3/3 | Complete    | 2026-04-15 |
| 25. Templates + Critics | v4.0 | 3/3 | Complete    | 2026-04-15 |
| 28. Schema Foundation | v5.0 | 3/3 | Complete    | 2026-04-28 |
| 29. Validator Depth | v5.0 | 5/5 | Complete    | 2026-04-29 |
| 30. MSP Outlet Coverage Sweep | v5.0 | 4/4 | Complete    | 2026-04-30 |
| 31. Layout & UX Builders | v5.0 | 0/0 | Not started | - |
| 32. DSP Pre-Flight Simulation | v5.0 | 0/0 | Not started | - |

---
*Roadmap created: 2026-03-08*
*Last updated: 2026-04-27 -- v5.0 milestone phases added (28-32); SCHEMA-07 success-criterion realigned to D-12 three-sibling shape*
