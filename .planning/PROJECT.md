# MaxSystem

## What This Is

A Claude Code development framework for building MAX/MSP patches and objects. Provides specialized agents, skills, hooks, templates, validation, and a comprehensive object knowledge base — enabling Claude to effectively generate `.maxpat` files, Gen~/RNBO~/js/Node for Max code, and C/C++ externals. Modeled after the Plugin Freedom System for VST development, with adaptations for MAX's visual patching paradigm.

## Core Value

Claude can generate valid, well-structured MAX/MSP patches and code that an expert user opens in MAX and they work — with as much automated validation as possible before manual testing.

## Requirements

### Validated

(None yet — ship to validate)

### Active

- [ ] Framework generates valid `.maxpat` JSON files with correct object definitions, connections, and layout
- [ ] Comprehensive MAX object knowledge base (inlets, outlets, arguments, behavior) sourced from MAX extraction, curation, and Cycling '74 docs
- [ ] Specialized agents for different MAX development domains (patching, DSP/Gen~, RNBO~, js/Node, externals, UI)
- [ ] Skills for project lifecycle (ideation, research, planning, execution, verification) scoped per MAX project
- [ ] Hooks for validation (patch structure, object validity, connection checks, code syntax)
- [ ] Template library for common MAX patterns (synthesis, sequencing, effects, control, Jitter)
- [ ] Gen~ code generation and syntax validation
- [ ] RNBO~ patch generation and code export support
- [ ] Node for Max and js/v8 code generation with testable JavaScript
- [ ] C/C++ external development support (SDK research needed for build system choice)
- [ ] Multi-project structure — each MAX project isolated like plugins in Plugin Freedom System
- [ ] Domain coverage: MSP (audio), Max (control/MIDI/OSC), Jitter (video/GL), MC (multichannel)
- [ ] Patch layout engine — objects positioned for readability when opened in MAX's visual editor
- [ ] Persistent agent memory — learned patterns accumulate across projects
- [ ] Multi-layer validation (pre-generation scan, post-generation structure check, domain-specific critics)

### Out of Scope

- Building actual MAX/MSP projects (granular synth, sequencer, etc.) — deferred to future milestones using this framework
- Real-time audio testing — requires MAX running, which Claude cannot do
- MAX for Live integration — separate domain, defer
- Standalone application export — focus on patches and externals first
- Video/Jitter as a priority — supported but MSP/audio is primary focus

## Context

- **Inspiration:** Plugin Freedom System at `/Users/taylorbrook/Dev/VST-development` — 11 agents, 27 skills, multi-layer validation, contract-driven data flow, persistent agent memory, template library, staged decomposition
- **Key challenge:** MAX patches are visual graphs stored as JSON. Unlike code-based development, Claude must generate spatially-aware object layouts with precise connection routing
- **Code entry points:** Gen~ (GenExpr DSP code), RNBO~ (exportable patches), Node for Max (JavaScript), js/v8 (inline JS), and C/C++ externals provide code-based interfaces where Claude operates naturally
- **Testing gap:** Patch behavior can only be fully validated by running MAX. Framework must maximize what's verifiable without MAX (structure, objects, connections, code syntax) and provide clear manual testing protocols for what remains
- **User profile:** Expert MAX/MSP user — framework speaks MAX fluently, no hand-holding on object behavior
- **Workflow:** Claude generates patches/code → user opens in MAX → user reports results → Claude iterates. Goal: minimize manual testing rounds through aggressive pre-validation

## Constraints

- **Platform:** macOS (MAX/MSP primary platform)
- **MAX version:** Current (MAX 8/9) — object database must track version compatibility
- **Patch format:** `.maxpat` JSON — must produce files MAX can open without errors
- **External SDK:** To be researched — Max SDK (C) vs Min-DevKit (C++) vs both
- **No MAX automation:** Claude cannot launch or control MAX — all validation must be offline

## Key Decisions

| Decision | Rationale | Outcome |
|----------|-----------|---------|
| Framework-only scope for v1 | Prove the tooling before building projects with it | — Pending |
| Full domain coverage (MSP, Jitter, Max, MC) | Expert user works across all domains | — Pending |
| Comprehensive object DB from multiple sources | Single source insufficient for MAX's object ecosystem | — Pending |
| Modeled after Plugin Freedom System | Proven architecture for project-scoped AI-assisted development | — Pending |
| C/C++ externals as core feature | Critical capability, not secondary | — Pending |

---
*Last updated: 2026-03-08 after initialization*
