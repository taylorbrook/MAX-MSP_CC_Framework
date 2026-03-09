---
phase: 01-object-knowledge-base
plan: 01
subsystem: database
tags: [xml-parsing, json, max-objects, extraction, pytest]

# Dependency graph
requires: []
provides:
  - "Domain-organized JSON object database (2,015 objects across 8 domains)"
  - "XML extraction script with standard, Gen~, and RNBO parser branches"
  - "Test scaffold covering ODB-01, ODB-02, ODB-05, ODB-06"
  - "Extraction log with statistics and error tracking"
affects: [01-02-PLAN, 01-03-PLAN, 02-patch-generation]

# Tech tracking
tech-stack:
  added: [pytest]
  patterns: [xml.etree.ElementTree extraction, domain-organized JSON, inlet type normalization, hot/cold inference]

key-files:
  created:
    - ".claude/scripts/extract_objects.py"
    - ".claude/max-objects/max/objects.json"
    - ".claude/max-objects/msp/objects.json"
    - ".claude/max-objects/jitter/objects.json"
    - ".claude/max-objects/mc/objects.json"
    - ".claude/max-objects/gen/objects.json"
    - ".claude/max-objects/m4l/objects.json"
    - ".claude/max-objects/rnbo/objects.json"
    - ".claude/max-objects/packages/objects.json"
    - ".claude/max-objects/extraction-log.json"
    - "tests/conftest.py"
    - "tests/test_object_schema.py"
    - "tests/test_source_coverage.py"
    - "tests/test_domain_classification.py"
    - "tests/test_inlet_types.py"
  modified: []

key-decisions:
  - "JSON files per domain for object storage (not SQLite) -- optimized for Claude context injection"
  - "Core domains prioritized over RNBO in name lookups (RNBO cycle~ has 2 outlets vs MSP 1)"
  - "Signal type inference for ~ objects with generic INLET_TYPE -- domain-based classification"
  - "UI ~ objects (filtergraph~, waveform~, zplane~) excluded from signal I/O requirement"
  - "Package objects with empty module classified as Packages domain (not Max fallback)"
  - "Gen~ objects get maxclass='gen~' since they live inside gen~ patchers"

patterns-established:
  - "INLET_TYPE_MAP: comprehensive normalization map for 50+ raw XML type variants"
  - "Domain inference: mc.* prefix -> MC, ~ suffix with INLET_TYPE -> signal, empty module + package source -> Packages"
  - "Hot/cold convention: inlet 0 = hot for control, all signal inlets = hot for MSP"
  - "Variable I/O rules: rule-based descriptions for objects with argument-dependent I/O counts"

requirements-completed: [ODB-01, ODB-02, ODB-05, ODB-06]

# Metrics
duration: 11min
completed: 2026-03-09
---

# Phase 1 Plan 1: Object Extraction Summary

**Extracted 2,015 MAX/MSP objects from XML refpages into 8 domain-organized JSON files with full schema (name, maxclass, inlets, outlets, arguments, messages, domain, signal types, hot/cold) and 36-test validation suite**

## Performance

- **Duration:** 11 min
- **Started:** 2026-03-09T21:22:58Z
- **Completed:** 2026-03-09T21:34:28Z
- **Tasks:** 2
- **Files modified:** 21

## Accomplishments
- Extracted 2,015 objects across 8 domains from MAX 9.1.2 installation with 0 parsing errors
- Domain breakdown: max=470, msp=248, jitter=210, mc=215, gen=189, m4l=33, rnbo=560, packages=87
- Every object has normalized schema: name, maxclass, module, domain, inlets (with type/signal/hot), outlets, arguments, messages, attributes, seealso, tags, min_version, verified, variable_io
- 36 tests pass covering schema validation (ODB-01), coverage thresholds (ODB-02), domain classification (ODB-05), and inlet type normalization (ODB-06)
- Extraction is fully idempotent (re-run produces identical checksums)

## Task Commits

Each task was committed atomically:

1. **Task 1: Create test scaffold and extraction script** - `311a626` (feat)
2. **Task 2: Run extraction and verify database** - `ba24e0e` (feat)

## Files Created/Modified
- `.claude/scripts/extract_objects.py` - XML extraction script with 3 parser branches (standard, Gen~, RNBO)
- `.claude/max-objects/max/objects.json` - 470 Max domain objects (control flow, data, UI)
- `.claude/max-objects/msp/objects.json` - 248 MSP domain objects (audio processing)
- `.claude/max-objects/jitter/objects.json` - 210 Jitter domain objects (video/matrix)
- `.claude/max-objects/mc/objects.json` - 215 MC multichannel objects
- `.claude/max-objects/gen/objects.json` - 189 Gen~ operator objects (DSP + Jitter + common)
- `.claude/max-objects/m4l/objects.json` - 33 Max for Live objects
- `.claude/max-objects/rnbo/objects.json` - 560 RNBO objects (for Plan 02 cross-referencing)
- `.claude/max-objects/packages/objects.json` - 87 package objects (ableton-dsp, jit.mo, mira, etc.)
- `.claude/max-objects/extraction-log.json` - Extraction statistics and metadata
- `tests/conftest.py` - Shared fixtures: db_root, all_objects, objects_by_domain, object_by_name, extraction_log
- `tests/test_object_schema.py` - ODB-01: 11 tests for required schema fields + spot checks
- `tests/test_source_coverage.py` - ODB-02: 10 tests for extraction count thresholds
- `tests/test_domain_classification.py` - ODB-05: 6 tests for domain/module normalization
- `tests/test_inlet_types.py` - ODB-06: 9 tests for type normalization, signal boolean, hot/cold

## Decisions Made
- Used JSON files per domain (not SQLite) -- optimized for Claude context injection and git-diffable
- Core domains loaded last in test fixtures so MSP cycle~ (1 outlet) wins over RNBO cycle~ (2 outlets) in name lookups
- Added signal type inference for MSP/MC ~ objects that have generic INLET_TYPE in XML -- 591+ objects affected
- UI ~ objects excluded from signal I/O requirement (filtergraph~, waveform~, zplane~)
- Package objects with empty XML module attribute classified as Packages domain, not fallback to Max
- Gen~ objects get maxclass="gen~" since they execute inside gen~ patchers

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] Fixed conftest import causing test collection error**
- **Found during:** Task 2 (test execution)
- **Issue:** test_source_coverage.py and test_domain_classification.py used `from conftest import` which fails with pytest's auto-loading
- **Fix:** Removed direct imports, duplicated constants where needed
- **Files modified:** tests/test_source_coverage.py, tests/test_domain_classification.py
- **Verification:** Tests collect and run successfully
- **Committed in:** ba24e0e (Task 2 commit)

**2. [Rule 1 - Bug] Fixed RNBO objects overwriting core objects in name lookup**
- **Found during:** Task 2 (cycle~ spot check failed -- showed 2 outlets)
- **Issue:** RNBO domain loaded last, RNBO cycle~ (2 outlets) overwrote MSP cycle~ (1 outlet) in flat index
- **Fix:** Changed DOMAIN_DIRS ordering to load RNBO first so core domains take priority
- **Files modified:** tests/conftest.py
- **Verification:** cycle~ spot check now returns MSP version with 1 outlet
- **Committed in:** ba24e0e (Task 2 commit)

**3. [Rule 1 - Bug] Fixed generic INLET_TYPE not inferred as signal for MSP/MC ~ objects**
- **Found during:** Task 2 (mc.cosh~ failed signal I/O test)
- **Issue:** 591+ XML files use INLET_TYPE instead of signal type; normalized to "control" but should be "signal" for ~ objects
- **Fix:** Added `infer_signal_types_for_tilde_objects()` post-processing in extraction script
- **Files modified:** .claude/scripts/extract_objects.py
- **Verification:** mc.cosh~ now has mc_signal type, all ~ objects have signal I/O
- **Committed in:** ba24e0e (Task 2 commit)

**4. [Rule 1 - Bug] Fixed package objects classified as Max domain**
- **Found during:** Task 2 (packages had only 2 objects instead of expected 87)
- **Issue:** 85 package objects (ableton-dsp, jit.mo) had empty module in XML, fallback set module to "max"
- **Fix:** Added explicit check: empty module + Packages source hint -> Packages domain
- **Files modified:** .claude/scripts/extract_objects.py
- **Verification:** packages/objects.json now has 87 objects
- **Committed in:** ba24e0e (Task 2 commit)

**5. [Rule 1 - Bug] Added UI ~ object exceptions to signal I/O test**
- **Found during:** Task 2 (filtergraph~, waveform~, zplane~ failed signal test)
- **Issue:** These are UI/control objects that have explicit float/list types in XML, not signal
- **Fix:** Added TILDE_UI_EXCEPTIONS set in test_inlet_types.py
- **Files modified:** tests/test_inlet_types.py
- **Verification:** All 36 tests pass
- **Committed in:** ba24e0e (Task 2 commit)

---

**Total deviations:** 5 auto-fixed (5 bugs via Rule 1)
**Impact on plan:** All fixes were necessary for correct extraction and test accuracy. No scope creep. Fixes address known pitfalls from research (INLET_TYPE generics, module inconsistency).

## Issues Encountered
- Package file count (91 XML files in packages) lower than research estimate due to some packages having files in non-standard locations (docs/ instead of docs/refpages/)
- Total 2,015 objects vs research estimate of 2,148 -- difference is 133 objects, mostly from RNBO max/ subdirectory overlap and files in non-refpage locations

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness
- Object database ready for Plan 02 enrichment (RNBO flags, version tags, aliases, relationships, overrides)
- 560 RNBO objects extracted and ready for cross-reference flagging
- Variable I/O rules defined for 17 objects
- 133 objects with empty inlets and 159 with empty outlets flagged for review in enrichment

## Self-Check: PASSED

- All 15 key files verified present on disk
- Both task commits (311a626, ba24e0e) verified in git log
- 36/36 tests pass

---
*Phase: 01-object-knowledge-base*
*Completed: 2026-03-09*
