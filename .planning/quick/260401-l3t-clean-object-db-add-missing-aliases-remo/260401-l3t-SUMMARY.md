---
phase: quick-260401-l3t
plan: 01
subsystem: object-database
tags: [aliases, overrides, msp, data-cleanup]

requires:
  - phase: quick-260401-jyk
    provides: Database audit report identifying P0 issues

provides:
  - Clean aliases.json with v->value and del->delay mappings
  - MSP objects.json without phantom documentation entries
  - Overrides.json without non-object keys and with normalized case

affects: [db_lookup, patch-generation, validation]

tech-stack:
  added: []
  patterns: []

key-files:
  modified:
    - .claude/max-objects/aliases.json
    - .claude/max-objects/msp/objects.json
    - .claude/max-objects/overrides.json

key-decisions:
  - "Bucket/Uzi overrides renamed to lowercase to match domain JSON convention"
  - "5 non-object override entries removed (!, 1, 2, >p, ?) -- patch metadata artifacts"

metrics:
  duration: 1min
  completed: "2026-04-01T22:15:06Z"
  tasks: 2
  files: 3
---

# Quick Task 260401-l3t: Clean Object DB -- Add Missing Aliases, Remove Phantoms

P0 data correctness fixes from the 260401-jyk database audit: 2 new aliases, 2 phantom MSP entries removed, 7 override keys cleaned.

## Task Summary

| # | Task | Commit | Key Changes |
|---|------|--------|-------------|
| 1 | Add missing aliases and remove non-real MSP entries | c49e954 | +v->value, +del->delay aliases; -MC Wrapper Features, -Snapshot Messages |
| 2 | Clean overrides -- remove non-objects, normalize case | a62bcd4 | -5 non-object keys; Bucket->bucket, Uzi->uzi |

## Verification Results

- `python3 -m pytest tests/test_object_schema.py` -- 15/15 passed
- `ObjectDatabase.lookup("v")` resolves to value object
- `ObjectDatabase.lookup("del")` resolves to delay object
- `ObjectDatabase.lookup("bucket")` resolves with override applied
- `ObjectDatabase.lookup("uzi")` resolves with override applied

## Deviations from Plan

None -- plan executed exactly as written.

## Known Stubs

None.

## Self-Check: PASSED
