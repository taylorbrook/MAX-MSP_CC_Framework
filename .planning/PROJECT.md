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

### Active

(Next milestone requirements TBD — run `/gsd-new-milestone`)

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

Shipped v4.0 with ~88,000 LOC Python.
Tech stack: Python (editing + validation), JSON (object DB + .maxpat), C++ (Min-DevKit externals), GenExpr (DSP code), JavaScript (js/N4M).
Object database: 2,015+ objects across 8 domains (Max, MSP, Jitter, MC, Gen, M4L, RNBO, Packages) plus bundled packages (BEAP, Vizzie, Jitter Geometry, Jitter Tools) and 10 community package stubs.
Agent system: 6 specialists + router, DSP/structure/RNBO/external/package critics, dual-scope memory.
Package integration: DB-driven bpatcher sizing, allowed_packages gating, extraction CLI for community packages.
v4.0 shipped full package integration — bundled and community MAX packages are first-class citizens with DB entries, validation, agent intelligence, critics, and workflow templates.

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

---
*Last updated: 2026-04-15 after v4.0 milestone*
