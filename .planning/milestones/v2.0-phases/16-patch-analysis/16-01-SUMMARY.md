---
phase: 16-patch-analysis
plan: 01
subsystem: analysis
tags: [patch-analysis, signal-flow, connected-components, send-receive, markdown]

# Dependency graph
requires:
  - phase: 15-intelligent-editing
    provides: "connected_components(), signal_path(), _build_adj(), downstream(), upstream()"
  - phase: 14-search-primitives
    provides: "find_boxes(), ObjectDatabase.lookup() with domain field"
provides:
  - "Patcher.analyze() method returning structured Markdown summary"
  - "SECTION_SIGNATURES dict for section auto-naming"
  - "_classify_domain() for object domain classification"
  - "_resolve_send_receive_pairs() for wireless connection detection"
  - "_merge_components_by_send_receive() via union-find"
  - "Signal chain tree rendering with fork points and wireless notation"
affects: [17-agent-migration, max-onboard]

# Tech tracking
tech-stack:
  added: []
  patterns: [union-find for component merging, priority-based section naming, recursive metric counting]

key-files:
  created:
    - tests/test_analysis.py
  modified:
    - src/maxpat/patcher.py

key-decisions:
  - "Prefix heuristics checked before tilde suffix (mc.foo~ is MC, not MSP)"
  - "Section naming uses priority-based selection when multiple signatures found"
  - "Signal chain trees show wireless connections via '...-> receive~ name (wireless)' notation"
  - "Control flow traces only notable origins (loadbang, metro, MIDI) -- not all control paths"

patterns-established:
  - "Analysis facet pattern: each facet is a private _analyze_* method returning Markdown string"
  - "Union-find merging for connected component consolidation by send/receive pairs"
  - "Recursive _count_recursive() for subpatcher metric aggregation"

requirements-completed: [AN-01, AN-02, AN-03]

# Metrics
duration: 6min
completed: 2026-03-16
---

# Phase 16 Plan 01: Patch Analysis Summary

**Patcher.analyze() produces structured Markdown summaries with 7 facets -- complexity metrics, object inventory, section detection via send~/receive~ merging, signal chain trees, control flow paths, subpatcher hierarchy, and parameter listing**

## Performance

- **Duration:** 6 min
- **Started:** 2026-03-16T20:17:31Z
- **Completed:** 2026-03-16T20:23:37Z
- **Tasks:** 2
- **Files modified:** 2

## Accomplishments
- Full analyze() method on Patcher producing readable Markdown from any .maxpat file
- Section detection merges connected components via send~/receive~ and send/receive pair resolution (all 8 alias forms)
- Signal chain trees with fork points and wireless connection notation
- Integration test passes against real performancepatchtest.maxpat (68 objects, 6 subpatchers)

## Task Commits

Each task was committed atomically (TDD: test + feat):

1. **Task 1: Section detection with send~/receive~ merging and auto-naming**
   - `ea9cae1` (test: failing tests for section detection)
   - `94ee212` (feat: implement section detection with send~/receive~ merging)

2. **Task 2: Full analyze() method with all facets and integration tests**
   - `8f4fd22` (test: failing tests for analyze() facets and integration)
   - `5d87454` (feat: implement full analyze() method with all 7 facets)

## Files Created/Modified
- `src/maxpat/patcher.py` - Added SECTION_SIGNATURES constant, _SECTION_NAME_PRIORITY, and 13 analysis methods to Patcher class (~590 lines added)
- `tests/test_analysis.py` - New test file with 53 tests across 11 test classes covering all analysis facets

## Decisions Made
- Prefix heuristics (jit., mc., live.) checked before tilde suffix -- mc.custom~ is MC, not MSP
- Priority-based section naming: audio sources (90) > processing (70) > output (20) when multiple signatures present
- Signal chain wireless connections shown as "...-> receive~ name (wireless)" for clarity
- Control flow traces only notable origins (loadbang, metro, notein, ctlin, midiin, counter) -- not all message paths
- _analyze_hierarchy returns str (not list[str]) with "## Subpatchers" header for consistency with other facets

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] Fixed heuristic ordering for domain classification**
- **Found during:** Task 1 (section detection)
- **Issue:** mc.custom~ classified as "MSP" because tilde suffix check ran before mc. prefix check
- **Fix:** Reordered heuristics: prefix checks (jit., mc., live.) before tilde suffix
- **Files modified:** src/maxpat/patcher.py
- **Verification:** test_unknown_mc_prefix_heuristic passes
- **Committed in:** 94ee212 (Task 1 commit)

---

**Total deviations:** 1 auto-fixed (1 bug fix)
**Impact on plan:** Necessary for correctness. No scope creep.

## Issues Encountered
None

## User Setup Required
None - no external service configuration required.

## Next Phase Readiness
- analyze() is ready for /max-onboard command wiring (Phase 17)
- read_patch() + analyze() tested against real .maxpat files
- All 1129 tests pass (53 new, 1076 existing) with zero regressions

## Self-Check: PASSED

All files found, all commit hashes verified.

---
*Phase: 16-patch-analysis*
*Completed: 2026-03-16*
