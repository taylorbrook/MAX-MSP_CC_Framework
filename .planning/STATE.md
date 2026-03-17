---
gsd_state_version: 1.0
milestone: v2.0
milestone_name: Direct .maxpat Editing
status: completed
stopped_at: Completed quick-260316-rzx-PLAN.md
last_updated: "2026-03-17T03:12:31.108Z"
last_activity: 2026-03-17 -- Plan 19-01 complete (tech debt cleanup - subpatcher round-trip fix)
progress:
  total_phases: 12
  completed_phases: 12
  total_plans: 28
  completed_plans: 28
  percent: 100
---

# Project State

## Project Reference

See: .planning/PROJECT.md (updated 2026-03-15)

**Core value:** Claude can generate valid, well-structured MAX/MSP patches and code that an expert user opens in MAX and they work -- with as much automated validation as possible before manual testing.
**Current focus:** v2.0 complete + tech debt cleanup

## Current Position

Phase: 19 of 19 (Tech Debt Cleanup)
Plan: 1 of 1
Status: Complete
Last activity: 2026-03-17 - Completed quick task 260316-rzx: max-build should assume new patch, max-iterate for existing patches

Progress: [██████████] 100%

## Performance Metrics

**Velocity:**
- Total plans completed: 7 (v2.0) / 39 (lifetime)
- Average duration: 6min (v2.0)
- Total execution time: 41min (v2.0)

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
| Phase 18 P01 | 2min | 2 tasks | 21 files |
| Phase 18 P02 | 11min | 2 tasks | 18 files |
| Phase 19 P01 | 2min | 2 tasks | 4 files |

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
- [Phase 18]: Untracked files deleted from disk only; 14 tracked files staged as git deletions
- [Phase 18]: SKILL.md verification tests updated to check v2.0 API names (save_patch_roundtrip) instead of v1.x (write_patch)
- [Phase 19]: [19-01]: Sentinel raw["patcher"] = None preserves key ordering instead of pop() which destroys ordered dict position

### Pending Todos

None.

### Quick Tasks Completed

| # | Description | Date | Commit | Directory |
|---|-------------|------|--------|-----------|
| 260316-rzx | max-build should assume new patch, max-iterate for existing patches | 2026-03-17 | d8b2e22 | [260316-rzx-max-build-should-assume-new-patch-max-it](./quick/260316-rzx-max-build-should-assume-new-patch-max-it/) |

### Blockers/Concerns

- ~~from_dict() has zero test coverage~~ RESOLVED: 31 round-trip tests in test_round_trip.py
- ~~Patchline color drop bug~~ RESOLVED: Patchline now has color, extra_attrs, _raw fields (Plan 13-01)
- ~~2 remaining round-trip bugs (bpatcher attrs, parameter_enable)~~ RESOLVED: Box._raw preservation handles all round-trip bugs (Plan 13-02)
- No official .maxpat spec exists -- unknown keys must be preserved defensively

## Session Continuity

Last session: 2026-03-17T03:12:31.105Z
Stopped at: Completed quick-260316-rzx-PLAN.md
Resume file: None
