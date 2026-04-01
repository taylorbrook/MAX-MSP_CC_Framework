---
phase: quick-260331-oua
plan: 01
subsystem: infra
tags: [git, auto-commit, work-safety, multi-instance, stash-recovery]

requires:
  - phase: none
    provides: n/a
provides:
  - auto_commit_patch() function for git-committing patch files after save
  - save_patch_roundtrip/write_gendsp/write_js auto-commit integration
  - bump_version files_changed tracking
  - CLAUDE.md Rule #7 stash prohibition
  - shared-capabilities.md Patch Safety section
  - max-build/max-iterate git commit steps
affects: [max-build, max-iterate, max-patch-agent, max-dsp-agent]

tech-stack:
  added: []
  patterns: [auto-commit-after-save, project-scoped-git-staging]

key-files:
  created: []
  modified:
    - src/maxpat/project.py
    - src/maxpat/hooks.py
    - .claude/commands/max-build.md
    - .claude/commands/max-iterate.md
    - .claude/skills/references/shared-capabilities.md
    - CLAUDE.md
    - .claude/max-objects/overrides.json
    - patches/mixer/versions.json

key-decisions:
  - "auto_commit_patch stages only project-specific files for multi-instance safety"
  - "Auto-commit failures silently skip to never block patch saves"
  - "Recovered multislider override and mixer v0.2.2 version entry from orphaned stashes; patch file changes superseded by newer work"

patterns-established:
  - "Every file write hook auto-commits via _auto_commit_saved_file helper"
  - "git stash prohibited during patch workflows (CLAUDE.md Rule #7)"

requirements-completed: [WORK-LOSS-01, WORK-LOSS-02, WORK-LOSS-03]

duration: 9min
completed: 2026-04-01
---

# Quick Task 260331-oua: Prevent MAX Patch Work Loss Summary

**Auto-commit after every patch save via auto_commit_patch(), stash prohibition rule, and recovery of 3 orphaned stashes**

## Performance

- **Duration:** 9 min
- **Started:** 2026-04-01T00:59:03Z
- **Completed:** 2026-04-01T01:08:27Z
- **Tasks:** 3
- **Files modified:** 8

## Accomplishments
- Added `auto_commit_patch()` to project.py that commits patch files to git with project-scoped staging
- Integrated auto-commit into all three write hooks: `save_patch_roundtrip`, `write_gendsp`, `write_js`
- Enhanced `bump_version()` to track `files_changed` in version entries
- Added git commit steps to max-build and max-iterate command protocols
- Added CLAUDE.md Rule #7 prohibiting `git stash` and mandating commit-after-save
- Added Patch Safety section to shared-capabilities.md with multi-instance isolation rules
- Recovered multislider outlet override and mixer v0.2.2 version entry from orphaned stashes
- Cleared all 3 orphaned stashes (stash list now empty)

## Task Commits

Each task was committed atomically:

1. **Task 1: Add auto_commit_patch() and integrate into save_patch_roundtrip** - `31ae35a` (feat)
2. **Task 2: Update commands, shared-capabilities, and CLAUDE.md with safety rules** - `cd330eb` (docs)
3. **Task 3: Recover orphaned stashes and verify** - `87f866a` (fix)

## Files Created/Modified
- `src/maxpat/project.py` - Added auto_commit_patch() function and files_changed param to bump_version
- `src/maxpat/hooks.py` - Added _auto_commit_saved_file helper, integrated into all 3 write functions
- `.claude/commands/max-build.md` - Added step 7 for git commit, auto_commit_patch import
- `.claude/commands/max-iterate.md` - Added step 19 for git commit, files_changed in bump_version call
- `.claude/skills/references/shared-capabilities.md` - Added Patch Safety section with isolation rules
- `CLAUDE.md` - Added Rule #7: Commit After Every Save, git stash prohibition
- `.claude/max-objects/overrides.json` - Recovered multislider outlet override from orphaned stash
- `patches/mixer/versions.json` - Recovered v0.2.2 version entry from orphaned stash

## Decisions Made
- auto_commit_patch stages only project-specific files (never `git add .`) for multi-instance safety
- Auto-commit failures silently skip (try/except pass) to never block patch saves
- Stash recovery: only extracted data not already superseded (multislider override, mixer version entry); patch file changes in all 3 stashes were superseded by newer committed work

## Deviations from Plan

None - plan executed exactly as written.

## Known Stubs

None.

## Issues Encountered
- Pre-existing test failures in test_agent_skills.py (test_patch_agent_references_max_objects) and test_round_trip.py (2 byte-identical tests) -- confirmed pre-existing, not caused by this plan's changes
- Accidental stash creation during pre-existing test check required careful stash pop recovery (ironic given the plan's purpose)

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness
- Auto-commit infrastructure in place for all patch save paths
- All stashes recovered/cleared, stash list empty
- Rules documented in CLAUDE.md and shared-capabilities.md

---
*Phase: quick-260331-oua*
*Completed: 2026-04-01*

## Self-Check: PASSED

All 8 files verified present. All 3 task commits verified in git log.
