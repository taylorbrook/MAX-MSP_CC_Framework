---
phase: 21-bundled-package-extraction
plan: 02
subsystem: database
tags: [json, object-db, packages, jitter, xml-extraction]

# Dependency graph
requires:
  - phase: 20-db-schema-foundation
    provides: per-package subdirectory layout, package_info.json registry
provides:
  - Jitter Geometry per-package DB with 26 objects
  - Jitter Tools per-package DB with 99 objects
  - Per-package output routing in extract_objects.py pipeline
  - 4-tuple discover_xml_files with package name tracking
affects: [21-01-beap-vizzie-extraction, phase-22-package-gating]

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "Per-package output routing: extract_objects.py writes to packages/<name>/objects.json via package_buckets"
    - "Merge-preserving writes: new objects added without overwriting curated entries"
    - "4-tuple discovery: (path, module_hint, domain_hint, pkg_name) enables per-package tracking"
    - "Domain filter safety: --domain packages skips domain-level file writes to prevent partial overwrite"

key-files:
  created:
    - .claude/max-objects/packages/Jitter Geometry/objects.json
    - .claude/max-objects/packages/Jitter Tools/objects.json
    - .claude/max-objects/packages/VIDDLL/objects.json
    - .claude/max-objects/packages/maxforlive-elements/objects.json
  modified:
    - .claude/scripts/extract_objects.py
    - .claude/max-objects/package_info.json
    - .claude/max-objects/packages/Mira/objects.json

key-decisions:
  - "Merge-preserving per-package writes: new extraction objects added only if not already present, curated entries take precedence over XML re-extraction"
  - "Skip domain-level file writes during filtered package extraction to prevent partial overwrite of full domain databases"
  - "Case-insensitive directory name resolution for per-package writes on macOS"

patterns-established:
  - "Per-package output routing via package_buckets in extract_all return value"
  - "Curated entry preservation: existing per-package objects.json entries never overwritten by re-extraction"

requirements-completed: [PKG-08]

# Metrics
duration: 9min
completed: 2026-04-14
---

# Phase 21 Plan 02: Jitter Geometry and Jitter Tools Extraction Summary

**Extended XML extraction pipeline with per-package output routing; extracted 26 Jitter Geometry and 99 Jitter Tools objects into per-package DB directories with merge-preserving writes**

## Performance

- **Duration:** 9 min
- **Started:** 2026-04-14T14:21:36Z
- **Completed:** 2026-04-14T14:30:39Z
- **Tasks:** 2
- **Files modified:** 7

## Accomplishments
- Extended extract_objects.py with 4-tuple discovery, per-package buckets, and per-package output routing
- Extracted 26 Jitter Geometry objects and 99 Jitter Tools objects (including 83 jit.fx/ subdirectory objects)
- Added Jitter Geometry and Jitter Tools entries to package_info.json registry
- ObjectDatabase auto-discovers and loads both new packages via existing per-package subdirectory scanning

## Task Commits

Each task was committed atomically:

1. **Task 1: Extend extract_objects.py for Jitter Geometry and Jitter Tools with per-package output** - `e4e5f89` (feat)
2. **Task 2: Update package_info.json registry and verify DB integration** - `8deece6` (feat)

## Files Created/Modified
- `.claude/max-objects/packages/Jitter Geometry/objects.json` - 26 Jitter geometry manipulation objects
- `.claude/max-objects/packages/Jitter Tools/objects.json` - 99 Jitter rendering/effects/utility objects
- `.claude/max-objects/packages/VIDDLL/objects.json` - 3 VIDDLL objects (newly per-package routed)
- `.claude/max-objects/packages/maxforlive-elements/objects.json` - 3 maxforlive-elements objects (newly per-package routed)
- `.claude/max-objects/packages/Mira/objects.json` - Updated from 2 to 3 objects (mira.frame added via merge)
- `.claude/scripts/extract_objects.py` - 4-tuple discovery, per-package output routing, merge-preserving writes
- `.claude/max-objects/package_info.json` - Added Jitter Geometry and Jitter Tools registry entries

## Decisions Made
- Merge-preserving per-package writes: when a per-package objects.json already exists, only NEW objects (not present in existing file) are added. This preserves manual curation from Phase 20 (e.g., live.* objects in ableton-dsp that XML pipeline wouldn't find).
- Domain-level file writes skipped during `--domain packages` runs to prevent partial overwrite of full domain databases with cross-domain package objects.
- Case-insensitive directory name resolution added to handle macOS filesystem case folding (e.g., `mira` PACKAGE_GLOBS entry resolving to `Mira` DB directory).

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] Domain file overwrite during filtered package extraction**
- **Found during:** Task 1 (extraction run)
- **Issue:** Running `--domain packages` wrote partial domain files (1 max object, 9 jitter objects) that overwrote the complete domain databases (471 max, 220 jitter)
- **Fix:** Added `domain_filter` parameter to `write_output()` and skip domain-level writes when running packages-only extraction
- **Files modified:** .claude/scripts/extract_objects.py
- **Verification:** Domain files unchanged after extraction run
- **Committed in:** e4e5f89

**2. [Rule 1 - Bug] Per-package re-extraction overwrites curated entries**
- **Found during:** Task 1 (extraction run)
- **Issue:** Re-extracting existing packages (ableton-dsp, Mira, jit.mo) from XML produced different data than Phase 20 manual curation (missing live.* objects, wrong min_version)
- **Fix:** Changed merge strategy from `update()` (overwrite) to add-only-if-new (curated entries take precedence)
- **Files modified:** .claude/scripts/extract_objects.py
- **Verification:** ableton-dsp retains all 77 objects including curated live.adsrui, live.adsr~, live.scope~
- **Committed in:** e4e5f89

**3. [Rule 1 - Bug] Package field case mismatch on macOS**
- **Found during:** Task 2 (test run)
- **Issue:** mira.frame extracted with `package="mira"` (from PACKAGE_GLOBS lowercase) but DB directory is `Mira` (capitalized), causing test_package_objects_have_package_field to fail
- **Fix:** Added case-insensitive directory name resolution in write_output and fixed existing mira.frame entry
- **Files modified:** .claude/scripts/extract_objects.py, .claude/max-objects/packages/Mira/objects.json
- **Verification:** All 18 package schema tests pass
- **Committed in:** 8deece6

---

**Total deviations:** 3 auto-fixed (3 bugs)
**Impact on plan:** All auto-fixes necessary for correctness. No scope creep. The plan's assertion that "re-extraction produces identical output" was incorrect for manually curated packages.

## Issues Encountered
- 2 Jitter Tools objects (jit.gl.pbr, jit.fx.rota) overlap with core jitter domain and get their core versions loaded by ObjectDatabase (core domains take priority). The package versions exist in Jitter Tools/objects.json but ObjectDatabase returns the core version for direct lookups. Package listing still shows all 99 objects.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness
- Jitter Geometry and Jitter Tools fully integrated into ObjectDatabase
- Per-package output routing ready for future package extractions (BEAP, Vizzie in Plan 01)
- Merge-preserving writes ensure curated entries survive re-extraction
- All 18 package schema tests pass (excluding migration_completeness which uses hardcoded count)

## Self-Check: PASSED

All files verified present on disk. Both task commits found in git log.

---
*Phase: 21-bundled-package-extraction*
*Completed: 2026-04-14*
