---
phase: quick-260401-lak
plan: 01
subsystem: object-database
tags: [database, coverage, jitter, mc, m4l, max]
dependency_graph:
  requires: [quick-260401-jyk, quick-260401-l3t]
  provides: [21 domain entries for audit-identified missing objects]
  affects: [ObjectDatabase.lookup, validation, codegen]
tech_stack:
  added: []
  patterns: [domain-json-entry-structure]
key_files:
  created: []
  modified:
    - .claude/max-objects/jitter/objects.json
    - .claude/max-objects/mc/objects.json
    - .claude/max-objects/max/objects.json
    - .claude/max-objects/m4l/objects.json
decisions:
  - "maxclass='newobj' for all 21 objects (consistent with existing domain entries)"
  - "Inlet/outlet data copied verbatim from overrides.json _domain_other section"
  - "hot=true for inlet 0, hot=false for others (matching existing pattern)"
metrics:
  duration: 1min
  completed: "2026-04-01"
---

# Quick Task 260401-lak: Add Missing Objects to Domain Files Summary

21 audit-identified objects added to 4 domain JSON files with full field coverage, matching overrides.json I/O data exactly.

## Task Results

| Task | Name | Commit | Files |
|------|------|--------|-------|
| 1 | Add 21 missing objects to domain JSON files | bfed726 | jitter/objects.json, mc/objects.json, max/objects.json, m4l/objects.json |

## Changes Made

### Jitter (11 objects added, 210 -> 221)
- `jit.*` - Matrix multiply (2 in, 2 out)
- `jit.fx.rota` - FX rotation (1 in, 1 out)
- `jit.gl.layer` - GL rendering layer (1 in, 2 out)
- `jit.gl.movie` - GL movie playback (1 in, 2 out)
- `jit.gl.pbr` - Physically-based rendering (8 in, 2 out)
- `jit.gl.polymovie` - GL polymovie (1 in, 3 out)
- `jit.mo.sin` - Motion sine generator (1 in, 2 out)
- `jit.time` - Time base (1 in, 2 out)
- `jit.time.perlin` - Perlin noise time (1 in, 2 out)
- `jit.time.saw` - Sawtooth time (1 in, 2 out)
- `jit.time.sin` - Time-based sine (1 in, 2 out)

### MC (7 objects added, 215 -> 222)
- `mc.capture~` - Signal capture (1 in, 0 out)
- `mc.receive~` - Wireless receive (1 in, 1 signal out)
- `mc.send~` - Wireless send (1 in, 0 out)
- `mc.sum~` - Sum to mono (1 in, 1 signal out)
- `mcp.record~` - Record parameter (3 in, 1 signal out)
- `mcs.loudness~` - Loudness analysis (1 in, 6 out)
- `mcs.sfizz~` - SFZ player (2 in, 1 signal out)

### Max (1 object added, 470 -> 471)
- `array.at` - Array element accessor (2 in, 2 out, min_version 9)

### M4L (2 objects added, 33 -> 35)
- `M4L.api.ObserveTransport` - Observe Live transport (1 in, 1 out)
- `M4L.api.ToggleTransport` - Toggle Live transport (1 in, 0 out)

## Verification

- All 4 JSON files parse cleanly
- All 21 objects resolve via `ObjectDatabase.lookup()`
- All 12 required fields present on every entry
- I/O counts match overrides.json source of truth

## Deviations from Plan

None - plan executed exactly as written.

## Known Stubs

None.

## Self-Check: PASSED

- All 5 files FOUND
- Commit bfed726 FOUND
