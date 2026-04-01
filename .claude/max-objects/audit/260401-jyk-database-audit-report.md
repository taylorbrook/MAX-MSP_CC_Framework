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

---

## 11. Cross-Domain Duplicates (Check 4)

**301 objects** appear in 2 or more domain files. Of these, **197 have mismatches** in inlet count, outlet count, or maxclass between domains. **104 are fully consistent** across domains.

### Mismatch Breakdown

| Category | Count | Notes |
|----------|-------|-------|
| maxclass-only (gen~ convention) | 89 | Gen domain uses `maxclass: "gen~"` for all objects -- expected behavior |
| I/O mismatch only | 62 | Inlet/outlet counts differ between domains |
| Both I/O and maxclass | 46 | Both maxclass and I/O counts differ |
| **Total mismatched** | **197** | |
| Consistent duplicates | 104 | Same inlets, outlets, maxclass across all domains |

### I/O Mismatches Between Non-Gen Domains (71)

These are the actionable mismatches -- same object name in max/msp vs rnbo with different I/O counts. Most reflect genuine RNBO behavioral differences (RNBO objects often have different I/O from their MAX counterparts), but 12 overlap with `variable_io` objects where default counts may simply differ by convention.

**Variable I/O objects (12)** -- expected to differ, low concern:
`gate`, `join`, `matrix~`, `pack`, `route`, `routepass`, `select`, `selector~`, `switch`, `trigger`, `unjoin`, `unpack`

**RNBO objects with 0 inlets or 0 outlets (14)** -- likely incomplete RNBO DB entries:

| Object | RNBO inlets | RNBO outlets | MAX/MSP inlets | MAX/MSP outlets |
|--------|-------------|--------------|----------------|-----------------|
| expr | 0 | 0 | 1 | 1 |
| ftom | 2 | 0 | 1 | 1 |
| ftom~ | 2 | 0 | 1 | 1 |
| gate | 2 | 0 | 2 | 1 |
| gen~ | 1 | 0 | 2 | 1 |
| mtof | 2 | 0 | 1 | 1 |
| mtof~ | 2 | 0 | 1 | 1 |
| pack | 0 | 1 | 2 | 1 |
| pak | 0 | 1 | 2 | 1 |
| patcher | 0 | 0 | 1 | 0 |
| pipe | 0 | 0 | 2 | 1 |
| sah~ | 3 | 0 | 2 | 1 |
| trigger | 1 | 0 | 1 | 2 |
| waveform~ | 0 | 0 | 5 | 6 |

**MIDI objects with RNBO differences (8)** -- RNBO adds explicit port/channel inlets and status outlets:

| Object | MAX in/out | RNBO in/out |
|--------|-----------|-------------|
| bendout | 2/0 | 3/1 |
| ctlin | 1/3 | 3/3 |
| ctlout | 3/0 | 4/1 |
| midiformat | 0/2 | 7/1 |
| notein | 1/3 | 2/4 |
| noteout | 3/0 | 5/1 |
| pgmout | 2/0 | 3/1 |
| touchout | 2/0 | 3/1 |

**MSP vs RNBO signal objects with real I/O differences (18)**:

| Object | MSP in/out | RNBO in/out | Delta |
|--------|-----------|-------------|-------|
| adsr~ | 5/4 | 5/2 | outlets -2 |
| average~ | 1/1 | 3/1 | inlets +2 |
| cycle~ | 2/1 | 2/2 | outlets +1 |
| gain~ | 1/2 | 2/2 | inlets +1 |
| log~ | 2/1 | 1/1 | inlets -1 |
| lookup~ | 3/1 | 2/2 | inlets -1, outlets +1 |
| mstosamps~ | 1/2 | 1/1 | outlets -1 |
| peek~ | 3/1 | 2/2 | inlets -1, outlets +1 |
| poke~ | 3/1 | 4/0 | inlets +1, outlets -1 |
| record~ | 3/1 | 4/1 | inlets +1 |
| rect~ | 3/1 | 3/2 | outlets +1 |
| reson~ | 4/1 | 3/1 | inlets -1 |
| sampstoms~ | 1/2 | 1/1 | outlets -1 |
| saw~ | 2/1 | 2/2 | outlets +1 |
| swing~ | 1/3 | 1/2 | outlets -1 |
| train~ | 3/2 | 3/1 | outlets -1 |
| tri~ | 3/1 | 3/2 | outlets +1 |
| wave~ | 3/1 | 4/3 | inlets +1, outlets +2 |

**MAX control objects with RNBO differences (19)**:

| Object | MAX in/out | RNBO in/out |
|--------|-----------|-------------|
| accum | 3/1 | 2/1 |
| append | 1/1 | 2/1 |
| bag | 2/1 | 2/2 |
| iter | 1/1 | 2/1 |
| midiout | 1/0 | 2/0 |
| midiparse | 1/8 | 1/7 |
| number | 1/2 | 1/1 |
| param | 1/2 | 2/2 |
| polyout | 3/0 | 4/1 |
| prepend | 1/1 | 2/1 |
| receive | 1/1 | 0/1 |
| sig~ | 1/1 | 2/1 |
| sysexin | 1/1 | 1/2 |
| tempo | 4/1 | 1/1 |
| thresh | 2/1 | 3/1 |
| timer | 2/2 | 2/1 |
| transport | 2/9 | 2/8 |
| zerox~ | 1/2 | 1/1 |
| receive~ | 1/1 | 0/1 |

**Recommendation:** Most RNBO differences are by design (RNBO is a different runtime). However, 14 RNBO entries with 0 inlets/outlets likely represent incomplete extraction and should be verified manually. The framework already uses domain-specific lookups via `ObjectDatabase`, so cross-domain differences do not cause connection errors as long as each domain's data is correct for its context.

## 12. Structural Integrity (Check 5)

**0 issues found.** Every object across all 8 domain files (2,012 total) has all 6 required fields (`name`, `maxclass`, `module`, `domain`, `inlets`, `outlets`) present with correct types. `inlets` and `outlets` are lists in every case.

| Domain | Objects Checked | Issues |
|--------|----------------|--------|
| max | 470 | 0 |
| msp | 248 | 0 |
| jitter | 210 | 0 |
| mc | 215 | 0 |
| gen | 189 | 0 |
| m4l | 33 | 0 |
| rnbo | 560 | 0 |
| packages | 87 | 0 |
| **Total** | **2,012** | **0** |

The database has clean structural integrity.

## 13. PD Blocklist Consistency (Check 6)

**0 missing equivalents.** All `max_equivalent` references in `pd-blocklist.json` resolve to objects that exist in at least one domain file.

| Metric | Count |
|--------|-------|
| Blocklist entries | 19 |
| Equivalents checked | 27 |
| Found in DB | 26 |
| Not found in DB | 0 |
| Descriptive/special cases | 1 |

### All Equivalents Verified

| PD Object | MAX Equivalent(s) | Found |
|-----------|--------------------|-------|
| osc~ | cycle~ | Yes |
| lop~ | onepole~ | Yes |
| hip~ | onepole~ | Yes |
| bp~ | reson~ | Yes |
| vcf~ | reson~, biquad~ | Yes, Yes |
| tabread~ | index~, play~, wave~ | Yes, Yes, Yes |
| tabwrite~ | poke~, record~ | Yes, Yes |
| catch~ | receive~ | Yes |
| throw~ | send~ | Yes |
| readsf~ | sfplay~ | Yes |
| writesf~ | sfrecord~ | Yes |
| tabread | table, coll | Yes, Yes |
| tabwrite | table, coll | Yes, Yes |
| soundfiler | buffer~ | Yes |
| vline~ | line~ | Yes |
| netsend | udpsend, mxj | Yes, Yes |
| netreceive | udpreceive, mxj | Yes, Yes |
| wrap~ | pong~ | Yes |
| clip~ | *(descriptive note -- clip~ exists in both PD and MAX)* | N/A |

The PD blocklist is fully consistent with the object database.

---

## Check Summary (11-13)

| Check | Description | Issues Found |
|-------|-------------|-------------|
| 11. Cross-domain duplicates | Objects in 2+ domains with differing I/O or maxclass | **197 mismatched** (89 gen~ convention only; 71 real I/O mismatches between non-gen domains; 14 likely incomplete RNBO entries) |
| 12. Structural integrity | Required fields and types on all 2,012 objects | **0 issues** |
| 13. PD blocklist consistency | max_equivalent references resolve to DB objects | **0 missing equivalents** |
