# Project Retrospective

*A living document updated after each milestone. Lessons feed forward into future planning.*

## Milestone: v1.0 — MVP

**Shipped:** 2026-03-10
**Phases:** 7 | **Plans:** 21

### What Was Built
- 2,015-object MAX knowledge base extracted from XML refpages across 8 domains
- .maxpat generation pipeline: Patcher/Box data model, column-based layout, 4-layer validation
- Code generation for Gen~ GenExpr, Node for Max (CommonJS), js V8
- Agent system: 6 specialists, router dispatch, DSP/structure/RNBO/external critics, persistent memory
- RNBO patch generation with export target awareness (VST3/AU, Web Audio, C++)
- C/C++ external scaffolding via Min-DevKit with cmake build loop and .mxo validation
- 10 slash commands for project lifecycle management

### What Worked
- Dependency-ordered phases (ODB -> PAT -> CODE -> AGT -> RNBO/EXT) — each phase had a solid foundation to build on
- TDD approach for gap closure phases (6, 7) — regression tests written before fixes
- Box.__new__ bypass pattern for structural objects not in DB — clean, consistent across subpatchers, gen~ codebox, node.script
- Wave-based parallel plan execution in Phases 4 and 5 saved time
- 3-source cross-reference audit caught documentation drift before shipping

### What Was Inefficient
- Phases 6 and 7 were documentation-only gap closures that could have been caught during Phase 4/5 execution
- Some agent SKILL.md files were written with stale signatures — verification should happen at plan completion, not milestone audit
- Nyquist compliance was partial (1/7 phases) — validation scaffolding exists but wasn't consistently generated

### Patterns Established
- Box.__new__ bypass for non-DB structural objects (subpatcher, bpatcher, gen~ codebox, node.script, js)
- 3-layer RNBO validation parallel to main validation pipeline (objects, target, self-contained)
- Domain JSON files as primary object truth source with overrides.json for expert corrections
- Commands -> Skills -> Python modules layered abstraction for agent system
- Router keyword/intent tables for deterministic specialist dispatch

### Key Lessons
1. Documentation accuracy should be verified at plan completion, not deferred to milestone audit — would have eliminated Phases 6-7 entirely
2. Object database design (JSON per domain, not SQLite) was correct for Claude context injection — fast lookups, easy to extend
3. RNBO namespace collision (cycle~ has 2 outlets in RNBO, 1 in MSP) requires separate database — RNBODatabase pattern
4. Code validation as report-only (not auto-fix) is the right default for expert users who want to understand findings

### Cost Observations
- Model mix: primarily Opus for execution, Sonnet for research/planning agents
- Total execution: ~2 hours across all 21 plans
- Notable: Plans averaged 4-5 minutes each — fast iteration enabled by clear requirements and TDD

---

## Milestone: v3.0.0 — Direct .maxpat Editing

**Shipped:** 2026-04-09
**Phases:** 7 | **Plans:** 15

### What Was Built
- Lossless .maxpat round-trip via Box._raw preservation — all 10 project patches byte-identical through load-save
- Full editing API: find_box, modify_box, insert_into_connection, replace_box, auto-positioning with collision detection
- Graph query engine: BFS upstream/downstream, signal_path tracing, connected_components with subpatcher crossing
- Patch analysis: 7-facet structured summaries (complexity, inventory, sections, signal chains, control flow, hierarchy, parameters)
- All slash commands and 9 agent SKILL.md files migrated to v2.0 workflow
- Old pipeline removed: incremental.py, 8 generate.py scripts, 6 manifests, 7 versions.json (4,254 lines deleted)

### What Worked
- Box._raw dual-path serialization — one architectural change eliminated 5 categories of round-trip bugs simultaneously
- TDD approach: xfail tests written first, promoted to hard passes as fixes landed
- Expand-then-contract test migration: added v2.0 read-write tests before removing v1.x write-only tests, CI stayed green throughout
- Dependency-ordered phases: round-trip -> search -> editing -> analysis -> migration -> cleanup — each phase had solid foundation

### What Was Inefficient
- Phase 19 tech debt (subpatcher key ordering) could have been caught during Phase 13 if golden file tests included subpatcher-heavy patches
- SUMMARY frontmatter requirements_completed field inconsistently populated across 4 phases — documentation gap carried through to audit
- v1.1 phase directories (8-12) not archived at v1.1 milestone completion — had to carry them through v2.0

### Patterns Established
- Box._raw / Patchline._raw dual-path to_dict: any new model classes should follow this pattern for round-trip fidelity
- read_patch() -> edit -> save_patch_roundtrip() as the canonical edit workflow
- Validation warns (not errors) on unknown objects — load anything, validate on demand
- Phase details moved to milestone archive after completion, keeping ROADMAP.md constant-size

### Key Lessons
1. One architectural change (Box._raw) can fix entire categories of bugs — worth investing in the right abstraction rather than patching individual symptoms
2. Expand-then-contract is the safe way to migrate tests — never delete old tests before new ones prove the same invariants
3. Golden file tests should cover the hardest cases early (subpatchers, nested gen~) not just the simple cases

### Cost Observations
- Model mix: primarily Opus for execution
- Plans averaged ~5 minutes each — fast iteration from clear phase dependencies
- Notable: Phases 13-18 all completed on 2026-03-16 (single day); Phase 19 tech debt on 2026-03-17

---

## Milestone: v4.0 — Package Integration

**Shipped:** 2026-04-15
**Phases:** 6 | **Plans:** 17

### What Was Built
- Package-aware object database: all objects tagged with source package, 16-package registry, allowed_packages filtering
- Bundled package extraction: BEAP (~192), Vizzie (~110), Jitter Geometry (26), Jitter Tools (99) via abstraction parser and XML pipeline
- Generation gating: package selection in project config, agent prompting, validation blocks unavailable packages
- Agent package intelligence: DB-driven bpatcher sizing, adaptive layout spacing, PACKAGES.md shared reference, 5 SKILL.md files updated
- Community package support: stub DB entries for 10 community packages, --package CLI extraction flag
- Package-aware critics: BEAP signal conventions, Bach llll type checker, community extraction validator, workflow templates

### What Worked
- Proposal-driven milestone: v4.0-package-integration-PROPOSAL.md defined all 6 phases and 26 requirements upfront — clean execution with no scope drift
- Phase dependency ordering (DB schema -> extraction -> gating -> intelligence -> community -> critics) — each layer built on the previous
- Stub pattern for community packages: provide DB presence without requiring local installation, with extraction path when available
- Splitting bundled vs community packages into separate phases avoided conflating two different extraction patterns

### What Was Inefficient
- REQUIREMENTS.md checkboxes for phases 21-25 were never checked off during phase execution — requirements tracking only done in ROADMAP.md phase entries
- The gsd-tools CLI milestone complete command pulled accomplishments from phases outside v4.0 range (phases 8-12 from v1.1) — required manual cleanup

### Patterns Established
- Package as first-class DB concept: package field on every object, package_info.json registry, per-package subdirectories
- Stub DB entries for uninstalled packages with extraction commands for when they become available
- Package critics as separate module (package_critic.py) dispatched from the main review_patch() pipeline
- PACKAGES.md as shared reference document cross-referenced from agent SKILL.md files

### Key Lessons
1. Requirements checkboxes should be checked off as part of phase completion, not left for milestone archive
2. Proposal-driven milestones with upfront phase/requirement mapping produce clean execution with no scope drift
3. Community package stubs are the right abstraction — full extraction when installed, graceful guidance when not

### Cost Observations
- Model mix: primarily Opus for execution, Sonnet for research/planning agents
- 10-day execution window (2026-04-05 to 2026-04-15) across 6 phases
- Notable: Phases 23-25 all completed on 2026-04-15 (single day) — mature framework patterns enable fast execution

---

## Milestone: v5.0 — DB Schema Hardening + Validator Depth

**Shipped:** 2026-05-01
**Phases:** 5 | **Plans:** 24

### What Was Built
- Schema foundation: typed `signal_role` (audio/trigger/status/float/data/list), `domain_restricted`, `verified_installed` with fail-fast validator and `signal:bool` write-through back-compat shim (D-15)
- Five new ObjectDatabase getter methods (get_signal_role, get_install_state, is_verified_installed, get_domain_restrictions, is_domain_restricted) + three sibling audit functions per D-12 (audit_empty_io, audit_install_coverage, audit_domain_coverage)
- Validator depth: Layer-3 role-aware connection errors with mechanical-fix suggestions (snapshot~ / sig~ / click~), Layer-4b RNBO domain hard-block, lookup-time install-state warnings via `warnings.warn`, embedded gen~ codebox + standalone .gendsp parity (delay/clip rejection, init-before-if/else flow analysis)
- MSP outlet coverage: 16 existing overrides migrated, ~80 unverified MSP objects populated, sibling-auto-mirror dropped MC gap_count 215→0, bulk audit script (audit_signal_role.py) committed
- Layout/UX builders: add_overlay_readout (Rule #6 z-order + ignoreclick), add_labeled_param_bank (size×24 multislider formula), add_m4l_gen_synth (Live-ready skeleton with param_connect bindings), role-driven companion auto-place dispatch consuming Phase 30 signal_role data
- DSP pre-flight simulation: numpy waveguide loop simulator with autocorrelation pitch tracker, D-09 verdict cascade (runaway > no_oscillation > mode_competition > phase_drift), three curated topologies (bore_only / reed_bore / reed_bore_post_radiation), bassoon v0.4.0 + v0.4.1 regression mirrors, live-patch gate via tests/dsp_sim/test_<stem>.py filename convention, `python -m src.maxpat.dsp_sim` CLI with verdict-priority exit codes, max-dsp-agent SKILL.md mandate

### What Worked
- Foundation-first ordering (Phase 28 schema → Phase 29 validators → Phase 30 coverage → Phase 31 UX builders) — every downstream phase had typed schema to consume
- Phase 32 (DSP pre-flight) declared independent of Phase 28 in advance — parallelization opportunity preserved without forcing sync
- Wave-based parallel plan execution within phases (visible in 28, 29, 30, 31, 32 wave-by-wave commit cadence)
- Sibling-auto-mirror code path for MC: one targeted invariant (inlet+outlet parity gate) replaced ~215 manual override entries
- D-09 verdict cascade with priority-ordered exit codes makes DSP failures programmatically reducible to regression tests
- Pre-existing `_validate_variable_io_rules` precedent gave Phase 28 a clean fail-fast template (matches D-15 load order)

### What Was Inefficient
- Nyquist VALIDATION.md generation never automated — 0/5 phases compliant (3 missing, 2 draft with `nyquist_compliant: false`); same gap pattern as v1.0/v3.0.0 retros warned about, persisted into v5.0
- Phase 31 ended with 11 tracked debt items — concentration suggests the phase was scoped too broad (4 builders + companion dispatch + skill docs + 2 gap-closure plans)
- SUMMARY.md `requirements_completed` frontmatter empty for 7 plans across phases 30/31/32 — same documentation drift the v1.0/v3.0.0 retros flagged; the gsd-sdk milestone.complete one-liner extraction surfaced the gap as garbage strings ("One-liner:", "Files claimed:")
- `replace_box` orphan trap (Rule #8) caused multi-version debug cycles before `replace_box_safe` shipped late in milestone — should have been the default from v3.0.0
- 4 Phase 31 human-UAT scenarios (overlay readout drag, M4L parameter binding in Live, auto-companion visual layout, 14-param bank pixel alignment) blocked at the runtime check — no plan to schedule the manual MAX 9 / Live session
- 80 quick-task orphans surfaced during pre-close audit — accumulated since v1.0; cleanup deferred again

### Patterns Established
- Closed-enum frozenset → fail-fast validator → in-place mutation projection (matches `_validate_variable_io_rules`); reusable for future schema extensions
- Three-sibling audit-function pattern (D-12): focused entry points beat one mega-audit with flag combinations
- Role-aware Layer-3 dispatch with curated-source / legacy-fallback split: new schema lights up where data is dense, falls back transparently where it isn't
- D-09 priority-ordered DSP verdict cascade: runaway > no_oscillation > mode_competition > phase_drift; CLI exit code follows verdict priority
- Filename-convention live-patch gate (tests/dsp_sim/test_<stem>.py) — opt-in, no global hook, matches D-04 SKILL.md-only DSP gate pattern
- "Extract Backlog before rewriting ROADMAP, re-append after" — codified in complete-milestone workflow but no Backlog existed in v5.0 (clean rewrite)

### Key Lessons
1. **Nyquist gap is a process problem, not a one-off oversight.** Three milestones in a row (v1.0, v3.0.0, v5.0) shipped with VALIDATION.md gaps. Either bake `/gsd-validate-phase` into the phase-completion gate or stop pretending Nyquist is a target.
2. **Empty `requirements_completed` arrays in SUMMARY frontmatter shouldn't be possible to ship.** Add a hook or pre-commit check; the v5.0 audit had to manually cross-reference VERIFICATION.md to confirm coverage.
3. **By-design bypass mechanisms (D-04 SKILL.md-only DSP gate, D-09/D-10 warnings.warn install-state) are bypassable.** They're acceptable architectural choices, but track them as known surface area where regressions can slip through silently — log to retro lesson #1's process gate when one ever fires unnoticed.
4. **`replace_box_safe` should have shipped at v3.0.0.** The orphan-return semantics caught real bugs but the silent-disconnection trap cost more than the explicit-orphan workflow ever saved. Default-safe with opt-in legacy is the right shape.
5. **Schema delta scoped to 3 fields (signal_role / domain_restricted / verified_installed) was the right size.** Larger schema evolution would have ballooned Phase 28 and forced premature design choices on inlet roles / message taxonomy. Reversibility preserved via `signal: bool` write-through.

### Cost Observations
- Model mix: primarily Opus for execution and gap-closure, Sonnet for research/planning/integration agents
- 5-day execution window (2026-04-27 to 2026-05-01) across 5 phases — fastest milestone density yet
- 204 commits, 344 files modified, +52,496/-13,921 lines
- Notable: Phases 30, 31, 32 all completed within 48 hours — late-milestone parallelism enabled by foundation phases (28, 29) shipping cleanly

---

## Cross-Milestone Trends

### Process Evolution

| Milestone | Phases | Plans | Key Change |
|-----------|--------|-------|------------|
| v1.0 | 7 | 21 | Initial framework build — established all patterns |
| v3.0.0 | 7 | 15 | Write-only to read-write editor — .maxpat as single source of truth |
| v4.0 | 6 | 17 | Package integration — bundled + community packages as first-class citizens |
| v5.0 | 5 | 24 | Schema hardening — flat extracted facts → typed install-aware contract; DSP pre-flight simulation |

### Cumulative Quality

| Milestone | Tests | Requirements | Audit Score |
|-----------|-------|--------------|-------------|
| v1.0 | 624 | 40/40 | passed |
| v3.0.0 | 700+ | 26/26 | passed (76/76 must-haves) |
| v4.0 | 750+ | 26/26 | no audit (yolo mode) |
| v5.0 | 800+ | 28/28 | tech_debt (28/28 reqs satisfied; 32 debt items + 4 human-UAT pending) |

### Top Lessons (Verified Across Milestones)

1. TDD with xfail-to-pass promotion works well for both gap closure (v1.0) and architectural changes (v3.0.0)
2. Dependency-ordered phases consistently deliver — each phase has a solid foundation from the previous one
3. Documentation accuracy should be verified at plan completion, not deferred — v1.0, v3.0.0, **and v5.0** all had doc gaps caught at audit time. **This is now a process problem requiring a hook, not a per-milestone reminder.**
4. Proposal-driven milestones with upfront phase/requirement mapping produce the cleanest execution — validated in v4.0 and v5.0
5. **Nyquist VALIDATION.md generation must be a phase-completion gate, not a milestone audit finding.** Three milestones now (v1.0 partial, v3.0.0 partial, v5.0 0/5 compliant) have shipped with this gap.
6. **Default-safe APIs with opt-in legacy paths beat explicit-orphan defaults.** The `replace_box` → `replace_box_safe` migration in v5.0 confirms what v3.0.0's Box._raw dual-path established: silent-disconnection bugs cost more than verbose-but-explicit error paths save.
