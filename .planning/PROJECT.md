# MaxSystem

## What This Is

A Claude Code development framework for MAX/MSP that generates valid `.maxpat` patches, Gen~/RNBO~/js/Node for Max code, and C/C++ externals. Provides 2,015-object knowledge base, 4-layer validation pipeline, 6 specialist agents with critic loops, persistent memory, and project lifecycle management via 10 slash commands.

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

### Active

- [ ] Comprehensive object database audit via help patches — correct outlet types, message names, argument formats, connection patterns for all ~2,015 objects
- [ ] Patch aesthetics — panels, background colors, comment styling for professional-looking generated patches
- [ ] Refined object positioning — layout engine improvements informed by help patch analysis and MAX UI best practices
- [ ] Agent accuracy improvements — feed corrected object data and layout patterns back to specialist agents

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

Shipped v1.0 with 16,557 LOC Python across 183 files.
Tech stack: Python (generation + validation), JSON (object DB + .maxpat), C++ (Min-DevKit externals), GenExpr (DSP code), JavaScript (js/N4M).
624 tests passing covering all 40 requirements.
Object database: 2,015 objects across 8 domains (Max, MSP, Jitter, MC, Gen, M4L, RNBO, Packages).
Agent system: 6 specialists + router, DSP/structure/RNBO/external critics, dual-scope memory.

## Current Milestone: v1.1 Patch Quality & Aesthetics

**Goal:** Improve the accuracy and visual quality of generated MAX patches through systematic object database auditing and aesthetic refinements.

**Target features:**
- Full help patch audit of all ~2,015 objects to correct outlet types, messages, arguments, and connection patterns
- Patch aesthetics — panels, background colors, comment styling
- Refined object positioning informed by help patch layouts and MAX UI best practices
- Agent improvements informed by audit findings

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

---
*Last updated: 2026-03-13 after v1.1 milestone start*
