---
gsd_state_version: 1.0
milestone: v2.0
milestone_name: Direct .maxpat Editing
status: completed
stopped_at: Phase 18 context gathered
last_updated: "2026-03-16T22:24:13.639Z"
last_activity: 2026-03-16 -- Plan 17-03 complete (agent SKILL.md dual workflow documentation)
progress:
  total_phases: 11
  completed_phases: 10
  total_plans: 25
  completed_plans: 25
  percent: 100
---

# Project State

## Project Reference

See: .planning/PROJECT.md (updated 2026-03-15)

**Core value:** Claude can generate valid, well-structured MAX/MSP patches and code that an expert user opens in MAX and they work -- with as much automated validation as possible before manual testing.
**Current focus:** v2.0 Phase 17 complete -- Agent & Command Migration

## Current Position

Phase: 17 of 18 (Agent & Command Migration)
Plan: 3 of 3
Status: Complete
Last activity: 2026-03-16 -- Plan 17-03 complete (agent SKILL.md dual workflow documentation)

Progress: [██████████] 100%

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
| Phase 17 P01 | 2min | 2 tasks | 4 files |
| Phase 17 P02 | 3min | 2 tasks | 5 files |
| Phase 17 P03 | 3min | 2 tasks | 10 files |

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
- [Phase 17]: [17-01]: Unknown objects downgraded from error to warning so third-party patches pass validation
- [Phase 17]: [17-01]: Empty .maxpat uses Patcher + set_canvas_background for styled initial patch
- [Phase 17]: [17-02]: /max-build checks for existing .maxpat, offers overwrite or redirect to /max-iterate
- [Phase 17]: [17-02]: /max-iterate uses transparent strategy selection (surgical vs section rebuild)
- [Phase 17]: [17-02]: /max-onboard offers next steps after analysis (create project, iterate, or review)
- [Phase 17]: [17-03]: Editing section placed after Aesthetic Capabilities, before Output Protocol
- [Phase 17]: [17-03]: Output Protocol split into (New Patches) and (Edited Patches) subsections
- [Phase 17]: [17-03]: Domain focus notes use distinct examples per agent (route, cycle~, rnbo~, etc.)

### Pending Todos

None.

### Blockers/Concerns

- ~~from_dict() has zero test coverage~~ RESOLVED: 31 round-trip tests in test_round_trip.py
- ~~Patchline color drop bug~~ RESOLVED: Patchline now has color, extra_attrs, _raw fields (Plan 13-01)
- ~~2 remaining round-trip bugs (bpatcher attrs, parameter_enable)~~ RESOLVED: Box._raw preservation handles all round-trip bugs (Plan 13-02)
- No official .maxpat spec exists -- unknown keys must be preserved defensively

## Session Continuity

Last session: 2026-03-16T22:24:13.637Z
Stopped at: Phase 18 context gathered
Resume file: .planning/phases/18-v1-x-cleanup/18-CONTEXT.md
