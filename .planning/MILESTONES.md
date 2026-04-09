# Milestones

## v2.0 Direct .maxpat Editing (Shipped: 2026-04-09)

**Phases completed:** 7 phases (13-19), 15 plans
**Timeline:** 23 days (2026-03-16 to 2026-04-08)
**Stats:** 77 commits, 81 files modified, +11,778/-1,694 lines, 33,430 LOC Python
**Requirements:** 26/26 satisfied
**Audit:** passed (26/26 requirements, 7/7 phases, 26/26 integration, 5/5 E2E flows)

**Delivered:** Replaced the Python generation pipeline with direct .maxpat reading and editing — the .maxpat file is now the single source of truth, enabling true back-and-forth between Claude and manual MAX editing.

**Key accomplishments:**

1. Lossless .maxpat round-trip — Box._raw preservation, detect_indent, save_patch_roundtrip; all 10 project patches round-trip byte-identically
2. Full editing API — find_box/find_boxes with alias resolution, modify_box with I/O recompute, insert_into_connection, replace_box, auto-positioning with collision detection
3. Graph query engine — BFS upstream/downstream traversal, signal_path tracing, connected_components with subpatcher boundary crossing
4. Patch analysis — Patcher.analyze() produces 7-facet structured summaries (complexity, inventory, sections, signal chains, control flow, hierarchy, parameters)
5. All slash commands and 9 agent SKILL.md files migrated to direct .maxpat editing workflow
6. Old pipeline removed — incremental.py, 8 generate.py scripts, 6 manifests, 7 versions.json deleted (4,254 lines); 60+ tests rewritten for v2.0 API

**Git range:** test(13-01) → docs(phase-19)

---

## v1.0 MVP (Shipped: 2026-03-10)

**Phases completed:** 7 phases, 21 plans
**Timeline:** 3 days (2026-03-08 to 2026-03-10)
**Stats:** 126 commits, 183 files, 16,557 LOC Python, 624 tests passing
**Requirements:** 40/40 satisfied
**Audit:** passed (40/40 requirements, 7/7 phases, 6/6 integration, 6/6 E2E flows)

**Delivered:** A complete Claude Code development framework for MAX/MSP — from object knowledge base through patch/code generation to agent orchestration and RNBO/external support.

**Key accomplishments:**

1. Comprehensive MAX object knowledge base — 2,015 objects across 8 domains extracted from XML refpages with RNBO flags, version tags, aliases, and overrides
2. .maxpat patch generation with Patcher/Box data model, column-based layout engine, and 4-layer validation pipeline (JSON structure, object existence, connection bounds/types, domain rules)
3. Gen~ GenExpr, Node for Max, and js V8 code generation with syntax validation and .gendsp standalone generation
4. Agent system — 6 specialist agents (Patch, DSP, RNBO, js, Ext, UI), critic validation loops, persistent memory with deduplication, multi-project isolation, 10 slash commands
5. RNBO-compatible patch generation with export target awareness (VST3/AU, Web Audio, C++) and C/C++ external scaffolding via Min-DevKit with build system support
6. Full documentation accuracy — 9 API signature mismatches fixed, 3 stale stub labels removed, all with regression tests

**Git range:** initial commit → 0245247

---
