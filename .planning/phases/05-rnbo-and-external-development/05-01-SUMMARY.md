---
phase: 05-rnbo-and-external-development
plan: 01
subsystem: rnbo
tags: [rnbo, rnbo~, validation, export-targets, genexpr-params, box-new-pattern]

# Dependency graph
requires:
  - phase: 02-patch-generation-and-validation
    provides: Patcher/Box data model, Box.__new__ pattern, validation pipeline
  - phase: 03-code-generation
    provides: parse_genexpr_io pattern for code analysis
  - phase: 01-object-knowledge-base
    provides: rnbo/objects.json (560 RNBO objects), rnbo_compatible flags
provides:
  - RNBODatabase for RNBO-specific object lookup (avoids MSP namespace collision)
  - validate_rnbo_patch() with 3 layers (objects, target, self-contained)
  - RNBO_TARGET_CONSTRAINTS for plugin/web/cpp targets
  - parse_genexpr_params() for GenExpr Param extraction
  - add_rnbo() for rnbo~ container generation via Box.__new__ pattern
  - generate_rnbo_wrapper() for complete ready-to-export .maxpat
affects: [05-04-critics-and-agent-upgrades, max-rnbo-agent-skill]

# Tech tracking
tech-stack:
  added: []
  patterns: [RNBODatabase separate from ObjectDatabase for namespace isolation, rnbo-validation 3-layer pipeline, RNBO_TARGET_CONSTRAINTS dict pattern]

key-files:
  created: [src/maxpat/rnbo.py, src/maxpat/rnbo_validation.py, tests/test_rnbo.py]
  modified: []

key-decisions:
  - "RNBODatabase loads rnbo/objects.json directly to avoid MSP cycle~ (1 outlet) overwriting RNBO cycle~ (2 outlets)"
  - "RNBO validation uses 3 layers: rnbo-objects, rnbo-target, rnbo-contained (parallel to main validation pipeline)"
  - "add_rnbo() is a module-level function (not Patcher method) to avoid modifying patcher.py"
  - "rnbo~ inner patcher includes inport/outport for message I/O alongside in~/out~ for audio"
  - "C++ embedded target uses 128 param limit (practical MIDI CC count estimate)"

patterns-established:
  - "RNBODatabase singleton for validation during add_rnbo (lazy-loaded)"
  - "RNBO_TARGET_CONSTRAINTS dict with per-target validation rules"
  - "Self-containedness check via regex patterns for @file and audio file extensions"

requirements-completed: [CODE-06, CODE-07]

# Metrics
duration: 4min
completed: 2026-03-10
---

# Phase 5 Plan 01: RNBO Patch Generation Summary

**RNBODatabase with RNBO-specific I/O counts, 3-layer target-aware validation, add_rnbo() container generation, and GenExpr param extraction**

## Performance

- **Duration:** 4 min
- **Started:** 2026-03-10T17:51:46Z
- **Completed:** 2026-03-10T17:56:39Z
- **Tasks:** 2 (TDD: 4 commits each with red/green phases)
- **Files modified:** 3

## Accomplishments
- RNBODatabase loads 560+ RNBO objects independently of ObjectDatabase, avoiding the MSP namespace collision where cycle~ has different outlet counts
- validate_rnbo_patch() catches non-RNBO objects, enforces plugin/web/cpp target constraints, and enforces self-containedness
- add_rnbo() creates valid rnbo~ container with inner RNBO patcher containing in~/out~/param/inport/outport objects
- generate_rnbo_wrapper() produces complete .maxpat with adc~/rnbo~/dac~ connections ready to open and export
- parse_genexpr_params() extracts Param name/default/min/max declarations from GenExpr code
- 23 new tests, 579 total tests passing

## Task Commits

Each task was committed atomically (TDD red/green):

1. **Task 1: RNBODatabase and RNBO validation module**
   - RED: `cb0e89c` (test: 14 failing tests)
   - GREEN: `80510bf` (feat: RNBODatabase, validate_rnbo_patch, parse_genexpr_params)

2. **Task 2: add_rnbo() and rnbo~ wrapper generation**
   - RED: `224299d` (test: 9 failing tests for add_rnbo/wrapper)
   - GREEN: `4696ff1` (feat: add_rnbo, generate_rnbo_wrapper)

## Files Created/Modified
- `src/maxpat/rnbo.py` - RNBODatabase, parse_genexpr_params, add_rnbo, generate_rnbo_wrapper
- `src/maxpat/rnbo_validation.py` - validate_rnbo_patch, RNBO_TARGET_CONSTRAINTS, 3-layer validation
- `tests/test_rnbo.py` - 23 tests covering all RNBO generation and validation

## Decisions Made
- RNBODatabase loads rnbo/objects.json directly (not via ObjectDatabase which prioritizes core domains and would give MSP cycle~ with 1 outlet instead of RNBO cycle~ with 2)
- add_rnbo() is a standalone module-level function taking a Patcher argument, rather than a method on Patcher class, to avoid modifying patcher.py
- RNBO validation uses 3 separate layers (rnbo-objects, rnbo-target, rnbo-contained) following the pattern of the main validation pipeline but specialized for RNBO concerns
- Self-containedness enforcement is error-level (not warning) per user decision for strict enforcement
- Inner RNBO patcher includes both inport/outport for messages and in~/out~ for audio, with param objects using @name/@min/@max/@initial attributes

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

None.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness
- RNBO generation and validation complete, ready for Plan 05-04 (critics, agent upgrades, public API integration)
- RNBODatabase and validate_rnbo_patch provide the foundation for the RNBO critic and upgraded rnbo-agent skill
- generate_rnbo_wrapper() ready for integration into the public generate_patch() pipeline

## Self-Check: PASSED

All created files verified present. All 4 commit hashes verified in git log.

---
*Phase: 05-rnbo-and-external-development*
*Completed: 2026-03-10*
