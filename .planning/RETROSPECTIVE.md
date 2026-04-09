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

## Cross-Milestone Trends

### Process Evolution

| Milestone | Phases | Plans | Key Change |
|-----------|--------|-------|------------|
| v1.0 | 7 | 21 | Initial framework build — established all patterns |
| v3.0.0 | 7 | 15 | Write-only to read-write editor — .maxpat as single source of truth |

### Cumulative Quality

| Milestone | Tests | Requirements | Audit Score |
|-----------|-------|--------------|-------------|
| v1.0 | 624 | 40/40 | passed |
| v3.0.0 | 700+ | 26/26 | passed (76/76 must-haves) |

### Top Lessons (Verified Across Milestones)

1. TDD with xfail-to-pass promotion works well for both gap closure (v1.0) and architectural changes (v2.0)
2. Dependency-ordered phases consistently deliver — each phase has a solid foundation from the previous one
3. Documentation accuracy should be verified at plan completion, not deferred — both milestones had doc gaps caught at audit time
