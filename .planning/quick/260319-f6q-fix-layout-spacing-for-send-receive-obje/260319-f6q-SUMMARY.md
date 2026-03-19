---
phase: quick-260319-f6q
plan: 01
subsystem: layout
tags: [sizing, box-width, override, text-width, send~, receive~]

requires:
  - phase: none
    provides: existing sizing.py with width override lookup
provides:
  - "calculate_box_size uses max(override, text_width) so overrides act as floor, not cap"
affects: [max-patch-agent, max-critic, layout]

tech-stack:
  added: []
  patterns: ["override-as-floor: width overrides are minimum widths, text can exceed them"]

key-files:
  created: []
  modified:
    - src/maxpat/sizing.py
    - tests/test_sizing.py

key-decisions:
  - "Override width is a floor (minimum), not an absolute value -- max(override, text_width)"

patterns-established:
  - "Override-as-floor: audit-measured widths set minimum box width, but text-proportional width wins when longer"

requirements-completed: [FIX-LAYOUT-SPACING]

duration: 1min
completed: 2026-03-19
---

# Quick Task 260319-f6q: Fix Layout Spacing for Send~/Receive~ Objects Summary

**Box sizing override branch now uses max(override, text_width) so long argument names get adequate space while bare objects retain audit-measured widths**

## Performance

- **Duration:** 1 min
- **Started:** 2026-03-19T18:04:00Z
- **Completed:** 2026-03-19T18:05:22Z
- **Tasks:** 2
- **Files modified:** 2

## Accomplishments
- Fixed calculate_box_size to use max(override_width, text_width) instead of returning override unconditionally
- receive~ mt-glide-freq-sig now gets 198.0px width (was clipped to 94.0px)
- Bare objects like cycle~ still correctly use their audit-measured override width (68.0px)
- 4 new tests validate the floor behavior; existing test updated for new semantics

## Task Commits

Each task was committed atomically:

1. **Task 1: Add tests for override-vs-text-width max() behavior** - `2f030d6` (test - TDD RED)
2. **Task 2: Fix sizing.py override branch and update affected existing test** - `bc1b6ed` (fix - TDD GREEN)

## Files Created/Modified
- `src/maxpat/sizing.py` - Changed override branch to compute max(override_width, text_width)
- `tests/test_sizing.py` - Added TestOverrideFloorBehavior class (4 tests) + updated existing test

## Decisions Made
- Override width is a floor (minimum), not an absolute value -- this means cycle~ 440 (10 chars, 86.0px text width) now exceeds the 68.0px override, which is correct since "cycle~ 440" needs 86px to display fully

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered
None.

## User Setup Required
None - no external service configuration required.

## Next Phase Readiness
- Layout spacing fix is complete and tested
- Any patch generation using send~/receive~ or other objects with long argument names will now produce correct widths

## Self-Check: PASSED

- [x] src/maxpat/sizing.py exists
- [x] tests/test_sizing.py exists
- [x] SUMMARY.md exists
- [x] Commit 2f030d6 exists (TDD RED)
- [x] Commit bc1b6ed exists (TDD GREEN fix)

---
*Phase: quick-260319-f6q*
*Completed: 2026-03-19*
