---
phase: quick-260319-mnh
plan: 01
subsystem: validation
tags: [dsp, gain-safety, audio-safety, validation, critic]

# Dependency graph
requires:
  - phase: 17
    provides: "validation pipeline and DSP critic infrastructure"
provides:
  - "Layer 4 unsafe gain literal detection (_check_unsafe_gain_values)"
  - "DSP critic unsafe gain source detection (_check_unsafe_gain_sources)"
  - "Blocker-level severity for missing gain staging"
  - "CLAUDE.md gain safety rule documentation"
affects: [max-patch-agent, max-dsp-agent, max-critic]

# Tech tracking
tech-stack:
  added: []
  patterns: ["BFS backward trace through control graph for unsafe source detection"]

key-files:
  created: []
  modified:
    - "src/maxpat/validation.py"
    - "src/maxpat/critics/dsp_critic.py"
    - "tests/test_validation.py"
    - "tests/test_critics.py"
    - "CLAUDE.md"

key-decisions:
  - "MIDI-range sources (ctlin, notein, number, slider, etc.) feeding *~ inlet 1 without normalization is a blocker, not a warning"
  - "Missing gain staging (osc->dac) upgraded from warning to blocker for hearing safety"
  - "Normalizers (scale, zmap, clip, / 127., * 0.007, expr, vexpr) suppress unsafe gain findings"
  - "Only *~ inlet 1 (gain control) is checked -- inlet 0 (signal input) is not flagged"

patterns-established:
  - "Backward BFS trace: trace control connections backward from target inlet to find unsafe sources"
  - "Normalizer detection: check object name in frozenset OR parse text for division/multiplication patterns"

requirements-completed: [GAIN-SAFETY]

# Metrics
duration: 13min
completed: 2026-03-19
---

# Quick Task 260319-mnh: Add Gain Safety Guards Summary

**Gain safety validation: *~ literal > 1.0 flagged as domain warning; MIDI-range sources feeding *~ gain inlet without normalization blocked by DSP critic**

## Performance

- **Duration:** 13min
- **Started:** 2026-03-19T17:14:49-07:00
- **Completed:** 2026-03-19T17:27:54-07:00
- **Tasks:** 2 (TDD Task 1 + Task 2)
- **Files modified:** 5

## Accomplishments
- Validation pipeline (Layer 4) catches `*~ 127` and similar unsafe gain literals > 1.0
- DSP critic traces backward from `*~` inlet 1 through control connections; flags MIDI-range sources (ctlin, notein, number, slider, etc.) that reach gain inlet without passing through a normalizer
- Missing gain staging (oscillator directly to dac~) upgraded from warning to blocker severity
- CLAUDE.md MSP section documents the 0.0-1.0 gain range rule
- All 84 validation + critic tests pass; no regressions

## Task Commits

Each task was committed atomically (TDD flow for Task 1):

1. **Task 1 RED: Add failing tests for gain safety guards** - `814ff3c` (test)
2. **Task 1 GREEN: Implement gain safety guards** - `d66a5b5` (feat)
3. **Task 2: Update CLAUDE.md and fix test severities** - `6e591ef` (docs)

## Files Created/Modified
- `src/maxpat/validation.py` - Added `_check_unsafe_gain_values()` for Layer 4 domain checks
- `src/maxpat/critics/dsp_critic.py` - Added `_check_unsafe_gain_sources()`, `_MIDI_RANGE_SOURCES`, `_NORMALIZER_NAMES`, `_is_normalizer()`; upgraded gain staging to blocker
- `tests/test_validation.py` - Added `TestLayer4UnsafeGainValues` (5 tests)
- `tests/test_critics.py` - Added `TestDSPCriticGainSafety` (5 tests); updated existing tests to expect blocker severity
- `CLAUDE.md` - Added gain safety rule to MSP section

## Decisions Made
- MIDI-range sources feeding *~ inlet 1 without normalization is a blocker (not warning) -- hearing safety is critical
- Missing gain staging (osc->dac) upgraded from warning to blocker -- same hearing safety rationale
- Signal sources (cycle~, noise~) feeding *~ inlet 1 are NOT flagged -- signal modulation is valid DSP practice
- Normalizer detection is pragmatic: frozenset check + text pattern matching for `/ 127.`, `* 0.007`

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

None.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness
- Gain safety guards are fully operational in the validation pipeline and DSP critic
- Pre-existing test_layout.py failure (`test_child_inlet_aligns_under_parent_outlet`) is unrelated to this task

---
*Phase: quick-260319-mnh*
*Completed: 2026-03-19*

## Self-Check: PASSED

All files verified present. All commit hashes verified in git log.
