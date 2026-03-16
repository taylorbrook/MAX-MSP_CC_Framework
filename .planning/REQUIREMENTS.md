# Requirements: MaxSystem v2.0

**Defined:** 2026-03-15
**Core Value:** Claude can generate valid, well-structured MAX/MSP patches and code that an expert user opens in MAX and they work — with as much automated validation as possible before manual testing.

## v2.0 Requirements

Requirements for v2.0 Direct .maxpat Editing milestone. Each maps to roadmap phases.

### Read-Write Foundation

- [x] **RW-01**: Patcher can load any .maxpat file into fully populated Patcher/Box/Line objects — all maxclass types, recursive subpatchers, bpatcher attrs, unknown objects handled gracefully
- [x] **RW-02**: Loaded Patcher writes back to .maxpat with minimal diff — unchanged portions byte-for-byte identical, key ordering preserved, numeric precision maintained
- [x] **RW-03**: User can add objects to a loaded patch with unique IDs, correct I/O counts, and DB validation — existing objects undisturbed
- [x] **RW-04**: User can remove objects from a loaded patch — box and all connected patchlines removed cleanly
- [x] **RW-05**: User can add and remove connections between existing objects with inlet/outlet bounds checking
- [x] **RW-06**: All user state preserved on edit — positions, colors, presentation rects, varnames, scripting names, custom attrs, unknown keys survive load-edit-save cycle
- [x] **RW-07**: User can find objects by ID, name, maxclass, or text substring — with optional recursive search into subpatchers

### Intelligent Editing

- [x] **ED-01**: User can modify object attributes in-place — change args (with I/O recomputation), position, color, or any property without remove-and-recreate
- [x] **ED-02**: User can insert an object into an existing connection — original connection removed, new box wired between source and destination, auto-positioned at midpoint
- [x] **ED-03**: User can replace/swap an object — new object placed at same position, compatible connections remapped, incompatible connections reported
- [x] **ED-04**: User can query patch graph — upstream/downstream traversal, signal path tracing, connected components, separate signal vs control graphs
- [x] **ED-05**: New objects auto-positioned intelligently near their connection context — below source, above target, between both, or in nearest empty space

### Patch Analysis & Onboarding

- [x] **AN-01**: Patch analyzer produces structured summary — object inventory by domain, signal flow chains, control flow paths, subpatcher map, parameter list, complexity metrics
- [x] **AN-02**: /max-onboard command analyzes an existing .maxpat file from any source, builds understanding of its structure, and produces a human-readable summary
- [x] **AN-03**: Patch analyzer identifies functional sections by connected components and spatial proximity — grouping objects into logical units

### Agent & Command Migration

- [ ] **MG-01**: /max-build generates patches by directly creating and writing .maxpat files — no generate.py intermediary
- [ ] **MG-02**: /max-iterate reads existing .maxpat, understands its structure, makes surgical edits, and writes back — no generate.py modification
- [x] **MG-03**: /max-new creates project structure with direct .maxpat workflow — no generate.py scaffolding
- [ ] **MG-04**: /max-onboard implemented as new slash command for onboarding existing patches
- [ ] **MG-05**: All 6 specialist agent SKILL.md files updated to reference direct editing API instead of generate.py workflow
- [x] **MG-06**: Validation hooks adapted for direct editing — validate edits on demand, not on load; no DB rejection of unknown objects

### v1.x Cleanup

- [ ] **CL-01**: incremental.py module removed — manifest-based merge system eliminated
- [ ] **CL-02**: All .manifest.json sidecar files removed from existing patches
- [ ] **CL-03**: All generate.py scripts removed from existing patches — .maxpat files are standalone
- [ ] **CL-04**: Test suite updated — read path covered, write-only assumptions replaced with read-write tests, expand-then-contract migration pattern
- [ ] **CL-05**: hooks.py updated — write_patch uses direct save path, merge_and_write removed or redirected

## v3.0 Requirements

Deferred to future release. Tracked but not in current roadmap.

### Advanced Editing

- **ADV-01**: Batch operations with transaction semantics — checkpoint/rollback for atomic multi-step edits
- **ADV-02**: Subpatcher extraction — select objects, move into new subpatcher with auto-generated inlet/outlet mapping
- **ADV-03**: Subpatcher inlining — copy inner patcher objects to parent, reconnect, remove subpatcher box

### Deferred from v1.1

- **TMPL-01**: Template library for common MAX patterns (synthesis, sequencing, effects, control, Jitter)
- **M4L-01**: MAX for Live integration (Live API, device types, parameter mapping)
- **JITR-01**: Deep Jitter support (specialized agents, validation, templates for video/GL)
- **INTL-01**: Intelligent object selection — context-aware recommendations based on task
- **NLNG-01**: Patch-from-description natural language interface

## Out of Scope

Explicitly excluded. Documented to prevent scope creep.

| Feature | Reason |
|---------|--------|
| Full auto-layout on loaded patches | Destroys user positioning — the exact problem v2.0 solves. Only auto-position NEW objects. |
| Real-time MAX integration (OSC/MCP) | Creates fragile dependency on MAX running; Claude cannot test audio |
| Patch screenshot analysis | .maxpat JSON is the source of truth, not pixels |
| Backward compatibility with generate.py | Maintaining two editing paths recreates the dual-source-of-truth problem |
| DB validation on load | Would reject third-party objects and packages not in our database |
| py2max integration | Existing Patcher model is strictly more capable; incompatible naming conventions |

## Traceability

Which phases cover which requirements. Updated during roadmap creation.

| Requirement | Phase | Status |
|-------------|-------|--------|
| RW-01 | Phase 13 | Complete |
| RW-02 | Phase 13 | Complete |
| RW-06 | Phase 13 | Complete |
| RW-03 | Phase 14 | Complete |
| RW-04 | Phase 14 | Complete |
| RW-05 | Phase 14 | Complete |
| RW-07 | Phase 14 | Complete |
| ED-01 | Phase 15 | Complete |
| ED-02 | Phase 15 | Complete |
| ED-03 | Phase 15 | Complete |
| ED-04 | Phase 15 | Complete |
| ED-05 | Phase 15 | Complete |
| AN-01 | Phase 16 | Complete |
| AN-02 | Phase 16 | Complete |
| AN-03 | Phase 16 | Complete |
| MG-01 | Phase 17 | Pending |
| MG-02 | Phase 17 | Pending |
| MG-03 | Phase 17 | Complete |
| MG-04 | Phase 17 | Pending |
| MG-05 | Phase 17 | Pending |
| MG-06 | Phase 17 | Complete |
| CL-01 | Phase 18 | Pending |
| CL-02 | Phase 18 | Pending |
| CL-03 | Phase 18 | Pending |
| CL-04 | Phase 18 | Pending |
| CL-05 | Phase 18 | Pending |

**Coverage:**
- v2.0 requirements: 26 total
- Mapped to phases: 26
- Unmapped: 0

---
*Requirements defined: 2026-03-15*
*Last updated: 2026-03-15 -- phase mappings updated for 6-phase roadmap (13-18)*
