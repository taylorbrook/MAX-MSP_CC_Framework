# MaxSystem

## What This Is

A Claude Code development framework for MAX/MSP that directly reads, edits, and writes `.maxpat` files — plus Gen~/RNBO~/js/Node for Max code and C/C++ externals. Provides 2,015-object knowledge base, 4-layer validation pipeline, 6 specialist agents with critic loops, patch analysis engine, persistent memory, and project lifecycle management via 10 slash commands. The .maxpat file is the single source of truth — no generation scripts, no manifests.

## Core Value

Claude can generate valid, well-structured MAX/MSP patches and code that an expert user opens in MAX and they work — with as much automated validation as possible before manual testing.

## Requirements

### Validated

- ✓ Framework generates valid `.maxpat` JSON files with correct object definitions, connections, and layout — v1.0
- ✓ Comprehensive MAX object knowledge base (2,015 objects, 8 domains) sourced from MAX extraction, curation, and docs — v1.0
- ✓ Specialized agents for different MAX development domains (patching, DSP/Gen~, RNBO~, js/Node, externals, UI) — v1.0
- ✓ Skills for project lifecycle (ideation, research, planning, execution, verification) scoped per MAX project — v1.0
- ✓ Hooks for validation (patch structure, object validity, connection checks, code syntax) — v1.0
- ✓ Gen~ code generation and syntax validation — v1.0
- ✓ RNBO~ patch generation and code export support — v1.0
- ✓ Node for Max and js/v8 code generation with testable JavaScript — v1.0
- ✓ C/C++ external development support (Min-DevKit scaffolding, build system, .mxo validation) — v1.0
- ✓ Multi-project structure — each MAX project isolated with independent context and state — v1.0
- ✓ Domain coverage: MSP (audio), Max (control/MIDI/OSC), Jitter (video/GL), MC (multichannel) — v1.0
- ✓ Patch layout engine — objects positioned for readability in MAX's visual editor — v1.0
- ✓ Persistent agent memory — learned patterns accumulate across projects — v1.0
- ✓ Multi-layer validation (pre-generation scan, post-generation structure check, domain-specific critics) — v1.0
- ✓ Generator-critic validation loops — critics review output before user sees it — v1.0
- ✓ Object database audit — outlet types, messages, arguments corrected via help patch analysis — v1.1
- ✓ Patch aesthetics — panels, background colors, comment styling, auto-highlighting — v1.1
- ✓ Refined layout engine — width overrides, inlet alignment, grid snap, comment association — v1.1
- ✓ Agent accuracy improvements — audit corrections fed back to specialist agents — v1.1
- ✓ Lossless .maxpat round-trip — any patch loads and saves back with zero diff — v3.0.0
- ✓ Direct .maxpat editing replaces Python generation pipeline — no generate.py intermediary — v3.0.0
- ✓ Full editing API — find, modify, insert-into-connection, replace, graph queries, auto-positioning — v3.0.0
- ✓ Patch analysis engine — 7-facet structured summaries for onboarding existing patches — v3.0.0
- ✓ All agents and slash commands migrated to direct .maxpat editing workflow — v3.0.0
- ✓ Old pipeline removed — incremental.py, generate.py scripts, manifests all deleted — v3.0.0
- ✓ Package-aware object database — all objects tagged with source package, 16-package registry, allowed_packages filtering — v4.0
- ✓ Bundled package extraction — BEAP, Vizzie, Jitter Geometry, Jitter Tools extracted into per-package DB — v4.0
- ✓ Package-gated generation — project config selection, agent prompting, validation blocking — v4.0
- ✓ Agent package intelligence — DB-driven bpatcher sizing, adaptive layout, PACKAGES.md reference, SKILL.md guidance — v4.0
- ✓ Community package support — stub DB entries for 10 community packages, --package CLI extraction — v4.0
- ✓ Package-aware critics — BEAP signal conventions, Bach llll type checker, workflow templates — v4.0
- ✓ Schema foundation — typed `signal_role` (audio/trigger/status/float/data/list), `domain_restricted`, `verified_installed` with fail-fast validator + signal:bool back-compat write-through; five getter methods + three audit functions (audit_empty_io, audit_install_coverage, audit_domain_coverage) (SCHEMA-01..07) — v5.0 (Phase 28)
- ✓ Validator depth — role-aware tier dispatch, domain-restriction guard, install-state warnings, embedded codebox parity (VALID-01..05) — v5.0 (Phase 29)
- ✓ MSP outlet coverage sweep — 16 existing overrides migrated to signal_role + ~80 unverified MSP objects populated + sibling-auto-mirror dropped MC gap_count 215→0; bulk audit script committed alongside migration (MSPCOV-01..05) — v5.0 (Phase 30)
- ✓ Layout & UX builders — `add_overlay_readout`, `add_labeled_param_bank`, `add_m4l_gen_synth`, role-driven companion dispatch with overlay placement + single-parent guard; SKILL.md byte-identical Builder API sections (LAYOUT-01..05) — v5.0 (Phase 31)
- ✓ DSP pre-flight simulation — offline numpy waveguide simulator (`src/maxpat/dsp_sim/`) with autocorrelation pitch tracker, D-09 verdict cascade (`runaway > no_oscillation > mode_competition > phase_drift`), three curated topologies, regression mirrors for bassoon v0.4.0/v0.4.1, live-patch gate via `tests/dsp_sim/test_<stem>.py` filename convention; `python -m src.maxpat.dsp_sim` CLI with verdict-priority exit codes; max-dsp-agent SKILL.md gate (DSPSIM-01..05) — v5.0 (Phase 32)

### Active

(None — v5.0 shipped 2026-05-01. Next milestone TBD via `/gsd-new-milestone`.)

### Future

- [ ] Template library for common MAX patterns (synthesis, sequencing, effects, control, Jitter)
- [ ] MAX for Live integration (Live API, device types, parameter mapping)
- [ ] Deep Jitter support (specialized agents, validation, templates for video/GL)
- [ ] Intelligent object selection — context-aware recommendations based on task
- [ ] Patch-from-description natural language interface

### Out of Scope

- Building actual MAX/MSP projects (granular synth, sequencer, etc.) — use framework to build them, not framework scope
- Real-time audio testing — requires MAX running, which Claude cannot do
- Standalone application export — focus on patches and externals first
- Real-time MAX control via OSC/MCP — creates fragile dependency on MAX running
- Patch-from-screenshot analysis — .maxpat JSON is the source of truth

## Context

Shipped v5.0 (2026-05-01) with ~45,300 LOC Python (post-refactor; `patcher.py` decomposition continues).
Tech stack: Python (editing + validation + DSP simulation), JSON (object DB + .maxpat), C++ (Min-DevKit externals), GenExpr (DSP code), JavaScript (js/N4M), numpy (offline DSP pre-flight simulator).
Object database: 2,015+ objects across 8 domains, now with typed `signal_role` per outlet (~96 MSP objects curated), `domain_restricted` for RNBO-only objects, `verified_installed` flag. Three audit functions surface coverage gaps as first-class entry points.
Agent system: 6 specialists + router, DSP/structure/RNBO/external/package critics, dual-scope memory; `max-dsp-agent` runs offline waveguide simulation pre-flight before committing patches.
Validator pipeline: Layer-3 role-aware connection errors (snapshot~ / sig~ / click~ suggestions), Layer-4b RNBO domain hard guard, lookup-time install-state warnings, embedded gen~ codebox + standalone .gendsp parity (delay() / clip() rejection, init-before-if/else flow analysis).
Layout/UX: 4 builders (`add_overlay_readout`, `add_labeled_param_bank`, `add_m4l_gen_synth`, role-driven companion auto-place) replace prose recipes in CLAUDE.md.
Known v5.0 tech debt: 5 phases need VALIDATION.md to reach Nyquist compliance; 4 Phase 31 human-UAT scenarios pending MAX 9 / Live runtime checks; 32 deferred items tracked in `.planning/milestones/v5.0-MILESTONE-AUDIT.md` and STATE.md Deferred Items.

## Key Decisions

| Decision | Rationale | Outcome |
|----------|-----------|---------|
| Framework-only scope for v1 | Prove the tooling before building projects with it | ✓ Good — framework complete, ready for real projects |
| Full domain coverage (MSP, Jitter, Max, MC) | Expert user works across all domains | ✓ Good — 2,015 objects across all domains |
| Comprehensive object DB from multiple sources | Single source insufficient for MAX's object ecosystem | ✓ Good — XML refpages + py2max + manual curation |
| Modeled after Plugin Freedom System | Proven architecture for project-scoped AI-assisted development | ✓ Good — same agent/critic/memory patterns |
| C/C++ externals as core feature | Critical capability, not secondary | ✓ Good — Min-DevKit scaffolding + build + .mxo validation |
| JSON per domain (not SQLite) | Optimized for Claude context injection | ✓ Good — fast lookups, easy to extend |
| Box.__new__ bypass for structural objects | Subpatchers, gen~ codebox, node.script not in DB | ✓ Good — clean separation of structural vs DB objects |
| N4M CommonJS (not ESM) | User preference, MAX compatibility | ✓ Good — consistent with MAX ecosystem |
| Code validation report-only (no auto-fix) | User preference for transparency | ✓ Good — findings surfaced, user decides |
| Min-DevKit over raw Max SDK | Modern C++ API, CMake build system | ✓ Good — headless builds, clean templates |
| TDD approach for gap closure (Phases 6-7) | Tests written before fixes ensure no regressions | ✓ Good — 11 regression tests prevent doc drift |

## Constraints

- **Platform:** macOS (MAX/MSP primary platform)
- **MAX version:** Current (MAX 8/9) — object database tracks version compatibility
- **Patch format:** `.maxpat` JSON — must produce files MAX can open without errors
- **External SDK:** Min-DevKit (C++) — CMake build system, Apple Silicon support
- **No MAX automation:** Claude cannot launch or control MAX — all validation is offline

| .maxpat as single source of truth | Python generation creates two competing sources of truth; user edits get lost on regeneration | ✓ Good — v3.0.0 eliminated generation pipeline |
| Box._raw preservation for round-trip | Dual-path to_dict (raw-based round-trip vs scratch creation) eliminates all data loss categories | ✓ Good — zero-diff on all 10 project patches |
| Expand-then-contract test migration | Add v2.0 read-write tests before removing v1.x write-only tests; CI stays green throughout | ✓ Good — 60+ tests rewritten without breakage |
| Validation warns (not errors) on unknown objects | DB rejection on load would block third-party packages and user objects | ✓ Good — unknown objects load cleanly |
| Schema delta scoped to 3 fields (signal_role, domain_restricted, verified_installed) | Larger schema evolution would balloon Phase 28 and risk breaking existing consumers | ✓ Good — v5.0 landed cleanly; broader inlet-role / message-taxonomy work deferred to v6.0+ |
| `signal: bool` retained as derived back-compat shim through v5.0 (D-15) | Removing the boolean field mid-milestone would break every existing consumer that reads `outlet["signal"]` | ✓ Good — write-through projection from `signal_role` keeps v5.0 reversible; removal scheduled for v6.0+ |
| Install-state surfaces as `warnings.warn`, not ValidationResult (D-09/D-10) | Matches existing empty-I/O warning pattern; lookup is the right chokepoint | ⚠️ Revisit — silenced if a caller suppresses UserWarnings; reconsider channel if visibility complaints arise |
| DSP pre-flight gate is SKILL.md-enforced, not a hooks.py hard block (D-04) | Opt-in agent gate matches the simulator's domain (waveguides only); a global hook would over-fire on non-waveguide DSP | ⚠️ Revisit — bypassable if agent skips the SKILL.md check; consider programmatic backstop if waveguide regressions slip through |
| Three-sibling audit functions: `audit_empty_io`, `audit_install_coverage`, `audit_domain_coverage` (D-12) | Focused entry points beat one mega-audit with flag combinations; matches D-12 locked decision | ✓ Good — each surfaces a distinct gap class for curator/CI workflows |
| Schema validators land between deep-merge and package_info load (D-15) | Validators must see the final merged shape; package_info needs validated state | ✓ Good — load-order locked; matches `_validate_variable_io_rules` precedent |
| `replace_box_safe` introduced as default for new code; legacy `replace_box` orphan-return preserved | Auto-rewire by I/O index for matching layouts eliminates the silent-disconnection footgun while keeping explicit-orphan path for I/O mismatches | ✓ Good — new code path defaults to safe; legacy callers keep working |

## Evolution

This document evolves at phase transitions and milestone boundaries.

**After each phase transition** (via `/gsd-transition`):
1. Requirements invalidated? → Move to Out of Scope with reason
2. Requirements validated? → Move to Validated with phase reference
3. New requirements emerged? → Add to Active
4. Decisions to log? → Add to Key Decisions
5. "What This Is" still accurate? → Update if drifted

**After each milestone** (via `/gsd-complete-milestone`):
1. Full review of all sections
2. Core Value check — still the right priority?
3. Audit Out of Scope — reasons still valid?
4. Update Context with current state

---
*Last updated: 2026-05-01 after v5.0 milestone — DB Schema Hardening + Validator Depth shipped (Phases 28-32). 28/28 requirements validated; 32 tracked tech-debt items + 4 human-UAT runtime checks deferred (see `.planning/milestones/v5.0-MILESTONE-AUDIT.md` and STATE.md Deferred Items).*
