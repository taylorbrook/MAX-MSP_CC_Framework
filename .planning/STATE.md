---
gsd_state_version: 1.0
milestone: v2.0
milestone_name: Direct .maxpat Editing
status: executing
stopped_at: Phase 14 context gathered
last_updated: "2026-03-16T15:56:39.252Z"
last_activity: 2026-03-16 -- Plan 13-02 complete (Box _raw dict preservation + key-order)
progress:
  total_phases: 11
  completed_phases: 6
  total_plans: 16
  completed_plans: 16
  percent: 15
---

# Project State

## Project Reference

See: .planning/PROJECT.md (updated 2026-03-15)

**Core value:** Claude can generate valid, well-structured MAX/MSP patches and code that an expert user opens in MAX and they work -- with as much automated validation as possible before manual testing.
**Current focus:** v2.0 Phase 13 -- Round-Trip Foundation (Plans 01-02 complete, Plan 03 next)

## Current Position

Phase: 13 of 18 (Round-Trip Foundation)
Plan: 3 of 3
Status: Executing
Last activity: 2026-03-16 -- Plan 13-02 complete (Box _raw dict preservation + key-order)

Progress: [##░░░░░░░░] 15%

## Performance Metrics

**Velocity:**
- Total plans completed: 2 (v2.0) / 34 (lifetime)
- Average duration: 5.5min (v2.0)
- Total execution time: 11min (v2.0)

**By Phase:**

| Phase | Plans | Total | Avg/Plan |
|-------|-------|-------|----------|
| 13 | 2 | 11min | 5.5min |

*Updated after each plan completion*
| Phase 13 P03 | 4min | 3 tasks | 3 files |

## Accumulated Context

### Decisions

Decisions archived in PROJECT.md Key Decisions table.

Recent decisions for v2.0:
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

### Pending Todos

None.

### Blockers/Concerns

- ~~from_dict() has zero test coverage~~ RESOLVED: 31 round-trip tests in test_round_trip.py
- ~~Patchline color drop bug~~ RESOLVED: Patchline now has color, extra_attrs, _raw fields (Plan 13-01)
- ~~2 remaining round-trip bugs (bpatcher attrs, parameter_enable)~~ RESOLVED: Box._raw preservation handles all round-trip bugs (Plan 13-02)
- No official .maxpat spec exists -- unknown keys must be preserved defensively

## Session Continuity

Last session: 2026-03-16T15:56:39.246Z
Stopped at: Phase 14 context gathered
Resume file: .planning/phases/14-search-and-mutation-primitives/14-CONTEXT.md
