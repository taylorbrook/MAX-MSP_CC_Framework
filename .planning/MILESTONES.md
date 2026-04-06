# Milestones

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

## v2.0 Direct .maxpat Editing (Shipped: 2026-03-17)

**Phases completed:** 7 phases (13-19), 15 plans
**Timeline:** 2 days (2026-03-15 to 2026-03-17)
**Requirements:** 6/6 satisfied

**Delivered:** Read-write Patcher API replacing the Python generation pipeline. .maxpat files are now the single source of truth — load, parse, edit, and write with full round-trip fidelity.

**Key accomplishments:**
1. Round-trip read/write with indent detection, key ordering, and trailing newline preservation
2. Search and mutation primitives — find_box, find_boxes, add/remove connections, replace_box, insert_into_connection
3. Intelligent editing — collision detection, graph traversal, signal path analysis, connected components
4. Patch analysis — domain classification, section signatures, parameter detection, signal chain tracing
5. Agent and command migration — /max-build, /max-iterate, /max-onboard all work directly with .maxpat
6. 40+ quick tasks for polish, DB cleanup, gen~ patterns, z-order API, and documentation

**Git range:** 0245247 → 4234af7

---
