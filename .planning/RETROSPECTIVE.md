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

## Cross-Milestone Trends

### Process Evolution

| Milestone | Phases | Plans | Key Change |
|-----------|--------|-------|------------|
| v1.0 | 7 | 21 | Initial framework build — established all patterns |

### Cumulative Quality

| Milestone | Tests | Requirements | Audit Score |
|-----------|-------|--------------|-------------|
| v1.0 | 624 | 40/40 | passed |

### Top Lessons (Verified Across Milestones)

1. (Awaiting v1.1 for cross-validation)
