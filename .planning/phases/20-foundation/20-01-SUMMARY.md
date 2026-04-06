---
phase: 20-foundation
plan: 01
subsystem: database
tags: [m4l, object-database, validation, overrides, relationships]

requires:
  - phase: 19-tech-debt-cleanup
    provides: clean codebase with ObjectDatabase as primary lookup
provides:
  - live.adsr~ and live.adsrui in m4l/objects.json
  - live.scope~ moved to M4L domain
  - plugin~/plugout~ maxclass=newobj overrides
  - M4L companion pairs in relationships.json
  - plugout~ in _TERMINAL_NAMES for both validation and DSP critic
affects: [20-02, 21-scaffold, 22-critic, m4l-agents]

tech-stack:
  added: []
  patterns: [override-for-maxclass-correction, domain-move-between-json-files]

key-files:
  created:
    - tests/test_m4l_db.py
  modified:
    - .claude/max-objects/m4l/objects.json
    - .claude/max-objects/packages/objects.json
    - .claude/max-objects/relationships.json
    - .claude/max-objects/overrides.json
    - src/maxpat/validation.py
    - src/maxpat/critics/dsp_critic.py

key-decisions:
  - "plugin~/plugout~ maxclass corrected via overrides.json (not direct msp/objects.json edit) per established pattern"
  - "live.adsrui set to 9 outlets (best-guess from ADSR parameters), marked verified=false per D-08"
  - "live.scope~ inlet added (signal input) when moving from packages to m4l"

patterns-established:
  - "Domain correction via move: delete from source JSON, add to target JSON with updated domain/module"
  - "Override for maxclass correction: overrides.json entry with just {maxclass: newobj}"

requirements-completed: [DB-01, DB-02, DB-03, VALID-05]

duration: 6min
completed: 2026-04-06
---

# Phase 20 Plan 01: M4L Object Database and Terminal Names Summary

**M4L objects (live.adsr~, live.adsrui, live.scope~) added to database with plugin~/plugout~ maxclass fix and terminal name recognition for M4L signal chains**

## Performance

- **Duration:** 6 min
- **Started:** 2026-04-06T05:09:37Z
- **Completed:** 2026-04-06T05:15:17Z
- **Tasks:** 2
- **Files modified:** 7

## Accomplishments
- Added live.adsr~ (5 inlets, 4 outlets) and live.adsrui (1 inlet, 9 outlets) to m4l/objects.json
- Moved live.scope~ from packages to m4l domain with corrected domain/module fields
- Fixed plugin~/plugout~ maxclass to "newobj" via overrides.json (ground truth from kicksynth-m4l.maxpat)
- Added 4 M4L companion pairs to relationships.json (plugin~/plugout~, live.path/live.object, midiin/midiout, live.thisdevice/loadbang)
- Added plugout~ to _TERMINAL_NAMES in both validation.py and dsp_critic.py
- Created 27-test test file covering all DB changes

## Task Commits

Each task was committed atomically:

1. **Task 1: Add M4L objects, fix live.scope~ domain, add relationships, add overrides** - `c400efb` (feat)
2. **Task 2: Add plugout~ to terminal names in validation.py and dsp_critic.py** - `6d31216` (feat)

## Files Created/Modified
- `.claude/max-objects/m4l/objects.json` - Added live.adsr~, live.adsrui, live.scope~ (38 total objects)
- `.claude/max-objects/packages/objects.json` - Removed live.scope~ entry
- `.claude/max-objects/relationships.json` - Added 4 M4L companion pairs
- `.claude/max-objects/overrides.json` - Added plugin~/plugout~ maxclass=newobj overrides
- `src/maxpat/validation.py` - Added plugout~ to _TERMINAL_NAMES
- `src/maxpat/critics/dsp_critic.py` - Added plugout~ to _TERMINAL_NAMES
- `tests/test_m4l_db.py` - 27 tests for all DB changes

## Decisions Made
- plugin~/plugout~ maxclass corrected via overrides.json (not direct msp/objects.json edit) per established pattern for expert corrections
- live.adsrui set to 9 outlets (best-guess from ADSR parameters: attack, attack slope, decay, decay slope, sustain, release, release slope, initial, peak), marked verified=false per D-08
- live.scope~ given signal inlet when moved to m4l domain (it visualizes audio signal)

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered
None.

## User Setup Required
None - no external service configuration required.

## Next Phase Readiness
- M4L object database foundation complete for downstream scaffold, critic, and export code
- plugin~/plugout~ correctly resolve to maxclass=newobj for patch generation
- M4L signal chains ending in plugout~ will pass validation without false positives
- live.adsr~ and live.adsrui marked verified=false -- Phase 25 testing will correct if wrong

---
*Phase: 20-foundation*
*Completed: 2026-04-06*
