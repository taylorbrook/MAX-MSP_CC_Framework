---
gsd_state_version: 1.0
milestone: v2.0
milestone_name: Direct .maxpat Editing
status: executing
stopped_at: Plan 16-01 complete (patch analysis)
last_updated: "2026-03-16T20:23:37Z"
last_activity: 2026-03-16 -- Plan 16-01 complete (Patcher.analyze() with all 7 facets)
progress:
  total_phases: 11
  completed_phases: 9
  total_plans: 22
  completed_plans: 22
  percent: 96
---

# Project State

## Project Reference

See: .planning/PROJECT.md (updated 2026-03-15)

**Core value:** Claude can generate valid, well-structured MAX/MSP patches and code that an expert user opens in MAX and they work -- with as much automated validation as possible before manual testing.
**Current focus:** v2.0 Phase 16 complete -- Patch Analysis

## Current Position

Phase: 16 of 18 (Patch Analysis)
Plan: 1 of 1
Status: Complete
Last activity: 2026-03-16 -- Plan 16-01 complete (Patcher.analyze() with all 7 facets)

Progress: [██████████] 96%

## Performance Metrics

**Velocity:**
- Total plans completed: 6 (v2.0) / 38 (lifetime)
- Average duration: 5min (v2.0)
- Total execution time: 30min (v2.0)

**By Phase:**

| Phase | Plans | Total | Avg/Plan |
|-------|-------|-------|----------|
| 13 | 2 | 11min | 5.5min |
| 14 | 2 | 9min | 4.5min |
| 15 | 2 | 10min | 5min |

*Updated after each plan completion*
| Phase 15 P03 | 5min | 2 tasks | 2 files |
| Phase 16 P01 | 6min | 2 tasks | 2 files |

## Accumulated Context

### Decisions

Decisions archived in PROJECT.md Key Decisions table.

Recent decisions for v2.0:
- [15-01]: EditResult uses @dataclass with default_factory for orphaned list
- [15-01]: modify_box syncs _raw["text"] explicitly (Box.to_dict round-trip path doesn't overlay text)
- [15-01]: replace_box captures orphaned connections before remove_box to preserve connection info
- [14-02]: Bounds checking is index-only (no signal type checking) per user decision in research phase
- [14-02]: Duplicate prevention returns existing patchline (idempotent) rather than raising
- [14-02]: remove_box() builds new list via comprehension to avoid mutating during iteration
- [14-01]: find_box short-circuits on first match; find_boxes collects all -- separate methods for ergonomics
- [14-01]: Alias resolution is bidirectional (t <-> trigger) via canonical form comparison
- [14-01]: read_patch delegates structural validation to from_dict() -- no extra strictness
- [13-02]: Box._raw excludes nested patcher key (inner patcher reconstructed from _inner_patcher to avoid stale data)
- [13-02]: outlettype only emitted in round-trip path if present in original _raw dict
- [13-02]: parameter_enable removed from _handled_keys -- preserved automatically via _raw
- [13-01]: Patchline dual-path to_dict -- _raw round-trip path preserves all original data; creation path builds from scratch
- [13-01]: Order=0 omitted in creation path to match MAX output format
- [13-01]: Patcher key ordering preserved by storing boxes/lines placeholders in props dict
- [Roadmap]: Split RW requirements across Phase 13 (round-trip) and Phase 14 (search + primitives) based on research dependency chain
- [Roadmap]: 6 phases derived from requirement dependencies, not category groupings -- round-trip must be proven before mutations
- [Research]: Zero new external dependencies -- all v2.0 built on existing codebase + stdlib
- [Phase 13]: save_patch_roundtrip preserves trailing newline status; detect_indent defaults to 4 spaces (MAX 9.1.2 format)
- [Phase 13]: save_patch_roundtrip is separate from write_patch -- creation path unchanged
- [Phase 15-02]: COLLISION_PAD = 5.0px around all boxes for collision detection readability
- [Phase 15-02]: insert_into_connection uses capacity = min(numinlets, numoutlets) for I/O mismatch handling
- [Phase 15-02]: I/O mismatch returns orphaned in EditResult (not ValueError) per CONTEXT.md locked decision
- [Phase 15-03]: signal_path excludes non-~ box itself from result (only ~ objects in signal chain)
- [Phase 15-03]: connected_components returns disconnected boxes as single-element groups (not separate list)
- [Phase 15-03]: Subpatcher crossing adds all inlet/outlet objects to result for full visibility
- [Phase 15-03]: _build_adj sorts adjacency by outlet/inlet index for left-to-right traversal order
- [Phase 16-01]: Prefix heuristics checked before tilde suffix (mc.foo~ is MC, not MSP)
- [Phase 16-01]: Section naming uses priority-based selection when multiple signatures found
- [Phase 16-01]: Signal chain wireless connections shown as "...-> receive~ name (wireless)" notation
- [Phase 16-01]: Control flow traces only notable origins (loadbang, metro, MIDI) -- not all control paths

### Pending Todos

None.

### Blockers/Concerns

- ~~from_dict() has zero test coverage~~ RESOLVED: 31 round-trip tests in test_round_trip.py
- ~~Patchline color drop bug~~ RESOLVED: Patchline now has color, extra_attrs, _raw fields (Plan 13-01)
- ~~2 remaining round-trip bugs (bpatcher attrs, parameter_enable)~~ RESOLVED: Box._raw preservation handles all round-trip bugs (Plan 13-02)
- No official .maxpat spec exists -- unknown keys must be preserved defensively

## Session Continuity

Last session: 2026-03-16T20:23:37Z
Stopped at: Plan 16-01 complete (patch analysis)
Resume file: .planning/phases/16-patch-analysis/16-01-SUMMARY.md
