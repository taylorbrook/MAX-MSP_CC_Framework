---
phase: quick-260322-g3q
plan: 01
subsystem: testing
tags: [dsp-critic, gain-staging, line~, mc, expr, vexpr]

requires:
  - phase: quick-260319-mnh
    provides: Initial gain safety guards for *~ and gain~
provides:
  - Conservative expr/vexpr normalizer detection (pattern-match only)
  - MC gain object support (mc.*~, mc.gain~)
  - line~ backward tracing through signal connections to detect unsafe gain
affects: [max-critic, dsp-critic]

tech-stack:
  added: []
  patterns: [signal-predecessor-map, line~-backward-tracing, conservative-normalizer-detection]

key-files:
  created: []
  modified:
    - src/maxpat/critics/dsp_critic.py
    - tests/test_critics.py

key-decisions:
  - "expr/vexpr normalizer requires explicit division/scaling pattern (/ 127, / 255, * 0.x) -- no blanket pass"
  - "mc.gain~ in _GAIN_NAMES for recognition only; excluded from inlet-1 checks (single inlet object)"
  - "line~ tracing builds signal predecessor map alongside control map to cross signal/control boundary"

patterns-established:
  - "Signal predecessor map pattern: build (dst_id, dst_inlet) -> src_ids for signal connections alongside control map"
  - "Message text parsing for line~: even-indexed values are targets, odd are times"

requirements-completed: [GAIN-LINE, GAIN-EXPR, GAIN-MC]

duration: 5min
completed: 2026-03-22
---

# Quick Task 260322-g3q: Extend DSP Critic Gain Staging Summary

**Conservative expr/vexpr normalizer detection, MC gain object support, and line~ backward tracing for unsafe gain sources**

## Performance

- **Duration:** 5 min
- **Started:** 2026-03-22T19:15:09Z
- **Completed:** 2026-03-22T19:20:15Z
- **Tasks:** 2
- **Files modified:** 2

## Accomplishments
- expr/vexpr no longer blanket-pass as normalizers -- must contain division/scaling patterns
- mc.*~ and mc.gain~ added to gain staging recognition; mc.*~ gets inlet-1 unsafe-source checks
- line~ feeding *~ gain inlet traced backward through signal connections to detect >1.0 message values and MIDI sources
- 12 new tests (56 total, up from 44)

## Task Commits

Each task was committed atomically (TDD: test then feat):

1. **Task 1: Fix _is_normalizer for expr/vexpr and add MC gain objects**
   - `27c751c` (test: failing tests for expr/vexpr normalizer and MC gain objects)
   - `a01f0a6` (feat: conservative expr/vexpr normalizer + MC gain objects)
2. **Task 2: Add line~ backward tracing for >1.0 message sources**
   - `d6c5948` (test: failing tests for line~ backward tracing)
   - `c4524b6` (feat: line~ backward tracing for unsafe gain sources)

## Files Created/Modified
- `src/maxpat/critics/dsp_critic.py` - Extended gain staging: conservative expr/vexpr, MC objects, line~ tracing
- `tests/test_critics.py` - 12 new tests for all three improvements

## Decisions Made
- expr/vexpr normalizer requires explicit division/scaling pattern (/ 127, / 255, * 0.x) via `re.search` -- generic expressions like `$i1 + $i2` are no longer considered normalizers
- mc.gain~ added to `_GAIN_NAMES` for gain staging BFS recognition but excluded from inlet-1 checks (it has only 1 inlet per mc/objects.json)
- line~ tracing builds a signal predecessor map `(dst_id, dst_inlet) -> src_ids` alongside the control map, then crosses from signal to control domain when line~ is detected

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

None.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness
- Gain staging checks now cover the three gaps identified in the plan
- All 56 tests pass (44 original + 12 new)

## Self-Check: PASSED

All files exist, all 4 commits verified, 56/56 tests passing.

---
*Phase: quick-260322-g3q*
*Completed: 2026-03-22*
