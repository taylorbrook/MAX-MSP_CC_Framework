# Object Database & Overrides Audit Report

**Date:** 2026-04-01
**Task:** 260401-jyk

## Executive Summary

The object database contains **2,012 objects** across 8 domain files, with **438 override entries** providing corrections. Of these overrides, **243** contain actual data corrections (inlets/outlets) and **195** are metadata-only confirmations. The database is functional and ObjectDatabase.lookup() correctly merges overrides, but several quality issues should be addressed.

**Key findings:**
- 41 phantom objects in overrides reference objects not in any domain file
- 116 objects have I/O count corrections (most impactful category)
- 149 signal type changes across 77 objects
- 7 overrides with <80% agreement (unreliable)
- 2 missing common aliases (`v` -> `value`, `del` -> `delay`)
- 2 non-real entries in MSP domain ("MC Wrapper Features", "Snapshot Messages")
- 195 metadata-only override entries add no value (could be pruned)

## 1. Database Overview

| Metric | Count |
|--------|-------|
| Total DB objects (all domains) | 2,012 |
| Unique object names | 1,672 |
| Total override entries | 438 |
| Corrective overrides (has inlet/outlet data) | 243 |
| Metadata-only overrides (no corrections) | 195 |
| Manual overrides (human-verified) | 6 |
| Aliases defined | 10 |

### By Domain

| Domain | Objects | Has Override Coverage |
|--------|---------|---------------------|
| max | 470 | Well covered |
| msp | 248 | 246 real objects covered (2 non-real entries) |
| jitter | 210 | Partial |
| mc | 215 | Partial |
| gen | 189 | Partial |
| m4l | 33 | Partial |
| rnbo | 560 | Partial |
| packages | 87 | Partial |

### Confidence Distribution

| Confidence | Count | Description |
|-----------|-------|-------------|
| HIGH | 384 | Automated extraction with strong agreement |
| MEDIUM | 30 | Lower instance count or agreement |
| HELP_PATCH | 6 | Manually researched from help patches |

## 2. Phantom Objects (41 total)

These override entries reference objects not found in any domain file. They fall into several categories:

### 2a. Missing from Jitter DB (11)

Real Jitter objects that should be added to `jitter/objects.json`:

| Object | Instances | Notes |
|--------|-----------|-------|
| jit.gl.layer | 15 | GL rendering layer |
| jit.mo.sin | 3 | Motion sine generator |
| jit.time.sin | 2 | Time-based sine |
| jit.* | 2 | Jitter matrix multiply |
| jit.fx.rota | 1 | FX rotation |
| jit.gl.movie | 1 | GL movie playback |
| jit.gl.pbr | 1 | Physically-based rendering |
| jit.gl.polymovie | 1 | Polymovie GL |
| jit.time | 1 | Time base |
| jit.time.perlin | 1 | Perlin noise |
| jit.time.saw | 1 | Sawtooth time |

### 2b. Missing from MC DB (7)

| Object | Instances |
|--------|-----------|
| mc.receive~ | 2 |
| mc.send~ | 2 |
| mc.sum~ | 2 |
| mc.capture~ | 1 |
| mcp.record~ | 1 |
| mcs.loudness~ | 1 |
| mcs.sfizz~ | 1 |

### 2c. Missing from M4L DB (2)

| Object | Instances |
|--------|-----------|
| M4L.api.ObserveTransport | 1 |
| M4L.api.ToggleTransport | 1 |

### 2d. Case Mismatches (2)

Override uses different capitalization than DB entry:

| Override Name | DB Name |
|--------------|---------|
| Bucket | bucket |
| Uzi | uzi |

**Recommendation:** Normalize to match DB casing or add case-insensitive handling.

### 2e. Missing Aliases (3)

| Override Name | Should Resolve To | Instances |
|--------------|-------------------|-----------|
| r | receive | 109 |
| v | value | 11 |
| del | delay | 10 |

Note: `r` is already in aliases.json and resolves correctly via ObjectDatabase. `v` and `del` are **missing** from aliases.json.

### 2f. Not Real Objects (5)

Extracted from patch metadata, not actual MAX objects:

`!`, `1`, `2`, `>p`, `?`

**Recommendation:** Remove these override entries.

### 2g. User Abstractions / Third-Party (10)

Low-instance objects from specific patches, not stock MAX objects:

`fswap`, `pan2`, `pan2S`, `pcontrol_ExamplePatch`, `poobah`, `thru`, `transratio`, `urn-jb`, `xbendout2`, `yafr2`

**Recommendation:** Remove these override entries -- they reference user-specific abstractions.

### 2h. Missing from DB (1)

| Object | Instances | Notes |
|--------|-----------|-------|
| array.at | 2 | MAX 9 array accessor -- should be in max/objects.json |

## 3. I/O Count Corrections (116 objects)

The most impactful override category. These correct inlet/outlet counts that were wrong in the extracted base data.

### Notable Patterns

**array.* objects:** 14 array objects have inlets corrected from 2 to 1. The extraction likely counted a second inlet that doesn't exist.

**string.* objects:** 7 string objects similarly corrected from 2 inlets to 1.

**MC objects:** 18 MC objects have outlet count corrections, most adding 1-4 additional outlets not captured in extraction.

**MSP objects:** 19 MSP objects corrected. Notable: `vst~` outlets 8->4, `sfizz~` outlets 2->8, `fffb~` outlets 4->8.

**Gen objects:** 11 Gen objects corrected, mostly adding missing outlets.

### High-Impact Corrections

| Object | Domain | Change | Impact |
|--------|--------|--------|--------|
| vst~ | msp | outlets 8->4 | Prevents out-of-bounds connections |
| poly~ | msp | outlets 0->1 | Object was listed with no outlets |
| mcs.poly~ | msp | outlets 0->1 | Same |
| fffb~ | msp | outlets 4->8 | Doubles outlet count |
| index~ | msp | outlets 2->1 | Removes phantom outlet |
| bangbang | max | outlets 2->3 | Default b with no args has 2 outlets |
| router | max | inlets 2->4, outlets 2->5 | Major I/O change |

## 4. Signal Type Corrections (77 objects, 149 I/Os)

These override entries fix incorrect signal flags. In the base DB, some control-rate objects were marked as signal, and some signal-rate I/Os were marked as control.

### Most Critical

| Object | Domain | I/O | Change | Risk |
|--------|--------|-----|--------|------|
| buffer~ | msp | inlet 0 + outlets 0,1 | signal->control | Would cause wrong connection types |
| dspstate~ | msp | outlets 0-3 | signal->control | All outlets are control |
| int | max | inlet 0, outlet 0 | signal->control | int is never signal |
| max | max | inlet 0,1, outlet 0 | signal->control | max is control |

These are critical correctness fixes -- without them, the framework would generate signal-type connections to control-only objects.

## 5. Low Agreement Overrides (7)

These overrides had <80% agreement in the extraction audit, meaning patch instances disagreed on I/O counts:

| Object | Agreement | Instances | Notes |
|--------|-----------|-----------|-------|
| receive | 0.78 | 9 | Variable I/O based on type? |
| bondo | 0.75 | 4 | Variable I/O based on args |
| mousestate | 0.75 | 4 | Outlet count varies |
| pipe | 0.75 | 12 | Variable I/O based on args |
| jit.gl.pix | 0.75 | 4 | Varies with connections |
| jit.phys.multiple | 0.75 | 4 | Varies with connections |
| mc.targetlist | 0.75 | 8 | Varies |

**Recommendation:** These should be manually verified. Several are variable_io objects where disagreement is expected.

## 6. Metadata-Only Entries (195)

These override entries contain only `_audit` metadata with no actual corrections. They confirm that the base DB data is correct for those objects.

**Examples:** `!-~`, `!/~`, `!=~`, `%~`, `*~`, `+=~`, `+~`, `-~`, `/~`, `<=~`

**Recommendation:** These could be moved to a separate "verified" tracking file to reduce overrides.json size (currently 8,877 lines). Not urgent but would improve maintainability.

## 7. Missing Aliases

Currently defined aliases (10):

| Alias | Canonical |
|-------|-----------|
| t | trigger |
| b | bangbang |
| i | int |
| f | float |
| p | patcher |
| sel | select |
| r | receive |
| s | send |
| r~ | receive~ |
| s~ | send~ |

**Missing common aliases:**

| Alias | Should Map To | Frequency in Patches |
|-------|--------------|---------------------|
| v | value | 11 instances found |
| del | delay | 10 instances found |

## 8. Non-Real DB Entries

The MSP domain file contains 2 entries that are not actual objects:

- **MC Wrapper Features** -- Documentation entry, not an object
- **Snapshot Messages** -- Documentation entry, not an object

These should be removed or moved to a separate metadata section.

## 9. ObjectDatabase Verification

Tested 20 randomly sampled override objects through ObjectDatabase.lookup():
- **13/13 real objects passed** (overrides correctly merged)
- **7/7 phantom objects returned NOT_FOUND** (expected -- no base entry to merge onto)

The ObjectDatabase correctly applies overrides to base data.

## 10. Manual Overrides (Human-Verified)

6 objects have `_manual_original` tracking showing what was changed manually:

| Object | What Was Fixed |
|--------|---------------|
| coll | Inlet types/count |
| curve~ | Outlet types |
| info~ | Inlets and outlets (10 outlets, all non-signal) |
| line~ | Outlet types |
| thispoly~ | Outlet count (3->2) |
| vst~ | Outlet count and types (8->4) |

These are the most reliable corrections -- verified by human expertise.

## Recommendations (Priority Order)

### P0 -- Data Correctness
1. **Add missing aliases:** `v` -> `value`, `del` -> `delay` to aliases.json
2. **Remove non-real MSP entries:** "MC Wrapper Features", "Snapshot Messages"
3. **Remove not-real-object overrides:** `!`, `1`, `2`, `>p`, `?`

### P1 -- Coverage Gaps
4. **Add missing Jitter objects** (11) to jitter/objects.json -- especially `jit.gl.layer` (15 instances)
5. **Add missing MC objects** (7) to mc/objects.json
6. **Add `array.at`** to max/objects.json
7. **Normalize case mismatches:** Bucket->bucket, Uzi->uzi in overrides

### P2 -- Maintenance
8. **Remove user abstraction overrides** (10 entries) -- they reference patch-specific objects
9. **Separate metadata-only entries** (195) into a verified-objects.json tracking file
10. **Manually verify low-agreement overrides** (7) -- especially `pipe`, `receive`, `mousestate`

### P3 -- Nice to Have
11. Add missing M4L objects (2) to m4l/objects.json
12. Consider adding `variable_io` flags to objects where patch instances disagreed on I/O counts
