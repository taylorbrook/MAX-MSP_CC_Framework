---
phase: 20-foundation
plan: 02
subsystem: m4l
tags: [m4l, constants, intenum, amxd, device-detection, claude-md]

# Dependency graph
requires:
  - phase: 16-patch-analysis
    provides: analysis.py AnalysisMixin structure
provides:
  - m4l_constants.py with ParamType, UnitStyle, ModMode, ParamVisibility IntEnums and AMXD binary format constants
  - detect_device_type() standalone function for M4L device type identification
  - CLAUDE.md M4L domain rules for all agents
affects: [21-scaffold, 22-critic-export, 23-banks, max-onboard, max-new]

# Tech tracking
tech-stack:
  added: []
  patterns: [IntEnum for .maxpat integer constants, standalone function on raw dict for cross-workflow detection]

key-files:
  created:
    - src/maxpat/m4l_constants.py
    - tests/test_m4l_detection.py
    - .planning/phases/20-foundation/20-VALIDATION.md
  modified:
    - src/maxpat/analysis.py
    - CLAUDE.md

key-decisions:
  - "detect_device_type() as standalone function (not AnalysisMixin method) per Pitfall 6 -- works on raw patch_dict without Patcher instantiation"
  - "M4L rules inserted between MSP and Gen~ sections in CLAUDE.md (M4L builds on MSP concepts)"

patterns-established:
  - "IntEnum for .maxpat integer constants: ParamType(1) == FLOAT for direct JSON comparison"
  - "Device detection via object-name scanning on raw patch_dict for both /max-onboard and /max-new flows"

requirements-completed: [DB-04, VALID-04, ROUTING-02]

# Metrics
duration: 9min
completed: 2026-04-05
---

# Phase 20 Plan 02: M4L Constants and Device Detection Summary

**M4L constants module with 4 IntEnums + AMXD format constants, device type detection function with confidence scoring, and comprehensive CLAUDE.md M4L domain rules**

## Performance

- **Duration:** 9 min
- **Started:** 2026-04-06T05:09:49Z
- **Completed:** 2026-04-06T05:19:00Z
- **Tasks:** 2
- **Files modified:** 5

## Accomplishments
- Created m4l_constants.py with ParamType (4 values), UnitStyle (10 values), ModMode (4 values), ParamVisibility (3 values) IntEnums and AMXD binary header constants (magic, version, type codes, format string)
- Implemented detect_device_type() as standalone function in analysis.py that correctly identifies audio_effect, instrument, midi_effect, and uncertain patterns with confidence scoring (0.0-1.0)
- Added 14-bullet M4L domain rules section to CLAUDE.md covering device types, gain~/plugout~ prohibition, --- naming, parameter_enable, presentation mode, 169px height constraint, Live API patterns, and AMXD export
- 30 tests covering all enum values, AMXD constants, and 6 detection scenarios

## Task Commits

Each task was committed atomically:

1. **Task 1: Create m4l_constants.py and detect_device_type()** - `1246c76` (feat)
2. **Task 2: Add M4L domain rules to CLAUDE.md and finalize VALIDATION.md** - `9e783f7` (docs)

## Files Created/Modified
- `src/maxpat/m4l_constants.py` - IntEnum classes for M4L parameter types, unit styles, modulation modes, visibility, plus AMXD binary format constants
- `src/maxpat/analysis.py` - Added DeviceTypeResult dataclass and detect_device_type() standalone function
- `tests/test_m4l_detection.py` - 30 tests for constants and device detection
- `CLAUDE.md` - M4L domain rules section with 14 bullet rules; m4l object count updated to 36
- `.planning/phases/20-foundation/20-VALIDATION.md` - Finalized with nyquist_compliant: true

## Decisions Made
- detect_device_type() implemented as standalone module-level function (not AnalysisMixin method) per Pitfall 6 -- works on raw patch_dict without requiring Patcher instantiation, enabling use in both /max-onboard and /max-new flows
- M4L rules section placed between MSP and Gen~ (M4L builds on MSP audio concepts)
- dataclass import added to analysis.py for DeviceTypeResult

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered
- Pre-existing test failure in test_analysis.py::TestOnboard::test_performancepatchtest (missing fixture file in worktree) -- not caused by this plan's changes, confirmed via git stash comparison

## User Setup Required
None - no external service configuration required.

## Next Phase Readiness
- m4l_constants.py ready for import by scaffold (Phase 21), critic (Phase 22), and export (Phase 22) code
- detect_device_type() ready for /max-onboard and /max-new workflow integration
- CLAUDE.md M4L rules active for all agent sessions

## Self-Check: PASSED

All files exist, all commits found.

---
*Phase: 20-foundation*
*Completed: 2026-04-05*
