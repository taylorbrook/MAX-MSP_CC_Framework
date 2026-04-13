# Feature Landscape

**Domain:** MAX/MSP Package Integration for AI-Assisted Patch Generation Framework
**Researched:** 2026-04-12
**Confidence:** HIGH for Tier 1 bundled package structure (verified on-disk at `/Applications/Max.app/Contents/Resources/C74/packages/`); MEDIUM for Tier 2 community packages (web research only, not installed locally); HIGH for existing system integration points (verified against codebase)

---

## Context: What Exists vs What Is Needed

The current system has 2,015 objects across 8 domain JSON files (max, msp, jitter, mc, gen, m4l, rnbo, packages). The `packages/objects.json` already contains 87 objects -- all `abl.*` DSP objects plus some `jit.mo`, `live.*`, and `mira.*` objects. These are individual external objects, not bpatcher modules.

BEAP and Vizzie -- the two largest bundled packages -- are entirely bpatcher-based. They contain zero externals. Their "objects" are `.maxpat` files loaded as embedded bpatchers with fixed dimensions, named inlets/outlets, and presentation-mode UIs. The current system cannot generate patches using these modules because:

1. No DB entries exist for bpatcher modules (bp.Oscillator, bp.LPF, vz.brcosr, etc.)
2. The Patcher API's `add_bpatcher()` exists but has no package-module awareness (doesn't know sizing, I/O, signal conventions)
3. Validation Layer 2 skips bpatcher entirely (`_STRUCTURAL_MAXCLASSES`) -- no module-level I/O checking
4. The router has no package-domain keywords and would dispatch "BEAP synth" to max-dsp-agent which would build raw signal chains
5. Critics know nothing about package idioms (BEAP's +/-5V convention, Vizzie's Jitter matrix flow)

**Verified on-disk package inventory (Tier 1 bundled):**

| Package | Categories | Clippings | Patchers | Externals | Module Style |
|---------|-----------|-----------|----------|-----------|-------------|
| BEAP | 17 | 168 | 4 | 0 | bpatcher (embedded, `bp.*` naming) |
| Vizzie | 8 | 110 | 157 | 0 | bpatcher (clippings) + abstraction (`vz.*` naming) |
| Jitter Geometry | -- | 0 | 5 | 1 | external + abstraction |
| Jitter Tools | -- | 0 | 54 | 4 | external + abstraction + pass-effects |
| ableton-dsp | -- | 0 | 2 | 74 | external (already in packages/objects.json as `abl.*`) |
| jit.mo | -- | 0 | 10 | 5 | external + abstraction |

---

## Table Stakes

Features users expect. Missing = package integration feels incomplete.

### TS-1: Package Object Database (per-package domain files)

| Aspect | Detail |
|--------|--------|
| **Why expected** | Core system requires DB entries for every object used. Without entries, validation Layer 2 rejects objects as unknown, and the "Never Guess Objects" rule blocks agents from using them. This is the single prerequisite that gates all other package features. |
| **What it does** | Create per-package JSON files in `.claude/max-objects/` with complete metadata: name, module type (bpatcher vs abstraction vs external), domain, inlets (with types, signal flags, comments), outlets (with types), arguments, messages, dimensions (for bpatchers), and signal convention (e.g., +/-5V for BEAP). |
| **Complexity** | High |
| **Dependencies** | Extraction pipeline (`audit/parser.py`, `audit/analyzer.py`) extended to parse bpatcher `.maxpat` files recursively -- counting inlet/outlet objects inside the embedded patcher, extracting their `comment` attributes for descriptions, and reading `patching_rect` for module dimensions. |
| **Scope** | BEAP: 168 modules across 17 categories. Vizzie: 110 modules (clippings) + 110 `vz.*` abstractions. Jitter Geometry: ~6 objects. Jitter Tools: ~58 objects. Total: ~452 new DB entries for Tier 1. |
| **Key behaviors** | Each bpatcher module entry needs: fixed `patching_rect` dimensions (bp.Oscillator = 314x116), inlet count and per-inlet metadata (signal type, comment/description), outlet count and types, category tag (Oscillator, Filter, LFO, etc.), and the file path to the `.maxpat` module file. |

### TS-2: bpatcher-Aware Patch Generation

| Aspect | Detail |
|--------|--------|
| **Why expected** | BEAP and Vizzie are bpatcher-only packages. Users expect "build a BEAP subtractive synth" to produce bpatcher instances of bp.Oscillator, bp.LPF, bp.VCA, bp.ASR, bp.Keyboard, bp.Stereo -- wired together correctly. Without this, packages are in the DB but unusable. |
| **What it does** | Extend the Patcher API to instantiate package modules as bpatchers with correct dimensions, embed flag, I/O counts, outlet types, and positioning. The API must handle BEAP's wider modules (314px+) differently from standard objects (~80px wide). |
| **Complexity** | High |
| **Dependencies** | TS-1 (package DB). The existing `add_bpatcher()` method handles basic bpatcher creation. Needs enhancement for: (a) looking up module dimensions from DB, (b) setting correct `numinlets`/`numoutlets`/`outlettype` from DB, (c) either embedding the patcher content or referencing the file path, (d) layout spacing for bpatcher-heavy patches. |
| **Key behaviors** | BEAP modules use embedded patchers (the `embed: 1` flag is set, full inner patcher JSON included). Vizzie clippings also embed. But Vizzie abstractions (`vz.*`) work as file references. Both patterns must be supported. Module positioning must account for the larger bpatcher sizes -- BEAP modules are 200-400px wide, not the 80px of standard objects. |

### TS-3: Per-Patch Permission Gating

| Aspect | Detail |
|--------|--------|
| **Why expected** | Explicit user requirement: per-patch permission, not blanket project access. `/max-iterate` must ask before introducing a new package dependency. Without this, the system could silently add FluCoMa dependencies to a patch on a machine without FluCoMa installed. |
| **What it does** | Add an `allowed_packages` field to project configuration. The router checks this before dispatching to package-aware generation. When `/max-iterate` detects a request that would introduce a new package, it prompts the user first. Validation warns if a patch uses objects from non-allowed packages. |
| **Complexity** | Medium |
| **Dependencies** | Package detection (TS-4), project config format (project.py). |
| **Key behaviors** | Default: no packages allowed (conservative). User grants access per-package per-patch (or per-project with explicit opt-in). The prompt must explain what the package provides and whether it's installed. Bundled packages (BEAP, Vizzie) have lower friction than community packages. |

### TS-4: Package Availability Detection

| Aspect | Detail |
|--------|--------|
| **Why expected** | System must know what's installed before suggesting package objects. Generating a FluCoMa patch when FluCoMa isn't present is a waste. Also needed for permission gating (TS-3) and validation. |
| **What it does** | Scan MAX package directories to discover installed packages. Parse `package-info.json` for name, version, compatibility. Report installed vs available. |
| **Complexity** | Low |
| **Dependencies** | None. Pure file system scan. |
| **Key behaviors** | Scan locations: (1) `/Applications/Max.app/Contents/Resources/C74/packages/` (bundled, always present), (2) `~/Documents/Max 9/Packages/` (user-installed), (3) `/Users/Shared/Max 9/Packages/` (system-wide). Parse `package-info.json` for metadata. Return structured inventory of installed packages with versions. |

### TS-5: Validation Pipeline Extension for Package Objects

| Aspect | Detail |
|--------|--------|
| **Why expected** | Validation Layer 2 (object existence) currently skips bpatchers entirely via `_STRUCTURAL_MAXCLASSES`. This means a bpatcher with the wrong number of connections passes validation silently. Layer 3 (connection bounds) also can't check bpatcher I/O. |
| **What it does** | Teach validation to look up specific bpatcher modules in the package DB. A `bpatcher` box whose embedded patcher or file reference matches a known module gets its I/O validated against the DB entry. Unknown bpatchers remain permissive (skip, don't reject). |
| **Complexity** | Medium |
| **Dependencies** | TS-1 (package DB with I/O metadata). |
| **Key behaviors** | Layer 2: if a bpatcher references a known module, verify it exists in the package DB. Layer 3: check that connections to/from the bpatcher respect the module's actual inlet/outlet count. Layer 4: check domain-specific rules (BEAP signal levels, Vizzie matrix types). |

### TS-6: Package-Aware Router Dispatch

| Aspect | Detail |
|--------|--------|
| **Why expected** | "Build a BEAP modular synth" currently routes to max-dsp-agent which builds raw cycle~+filter chains. The router needs package domain keywords to dispatch correctly. |
| **What it does** | Add package-domain keyword detection to the router. BEAP, Vizzie, FluCoMa, etc. each have distinctive keywords. When detected, the router dispatches to a package-aware agent (or adds package context to existing agents). |
| **Complexity** | Medium |
| **Dependencies** | TS-1 (package DB), TS-3 (permission check before dispatch). |
| **Key behaviors** | BEAP keywords: modular, eurorack, cv, voltage, 1v/oct, beap, bp., VCA, VCO, VCF. Vizzie keywords: vj, video processing, vizzie, vz., jitter effects, video mixer. FluCoMa: corpus, decomposition, nmf, mfcc, descriptor, slicing, flucoma, fluid. The router must check permission gating before dispatching to a package domain. |

### TS-7: Package Relationships and Companions

| Aspect | Detail |
|--------|--------|
| **Why expected** | BEAP modules have required companions: bp.Oscillator is useless without bp.Stereo (output), bp.ASR needs bp.Keyboard (trigger source). Missing output modules = silent patches. The current `relationships.json` has 23 core pairs but zero package pairs. |
| **What it does** | Add per-package relationship data. Required pairs (oscillator needs output), common pairs (envelope typically feeds VCA), category-level rules (every BEAP patch needs at least one Output module and one Input module). |
| **Complexity** | Low |
| **Dependencies** | TS-1 (package DB with category metadata). |
| **Key behaviors** | BEAP required: every patch must have an Output module (bp.Stereo or bp.Mono Output). BEAP common: Oscillator + Filter + VCA + Envelope is the basic subtractive chain. Vizzie required: every chain should end at an Output module (PROJECTR, RECORDR). Vizzie common: INPUT + EFFECT + OUTPUT is the basic video chain. |

### TS-8: Package-Specific Domain Rules

| Aspect | Detail |
|--------|--------|
| **Why expected** | BEAP operates in +/-5V eurorack signal domain, not 0.0-1.0 normalized audio. The DSP critic's gain staging checks (flag values outside 0-1 before dac~) would produce false positives on every BEAP patch. Vizzie uses Jitter matrices, not MSP signals -- signal-type connection validation is wrong. |
| **What it does** | Define per-package signal conventions so validation and critics produce correct results. BEAP: +/-5V control voltage, all connections are signal-rate. Vizzie: Jitter matrix connections, `jit.gl.texture` type outlets. FluCoMa: standard MSP signals plus buffer references. |
| **Complexity** | Medium |
| **Dependencies** | TS-1 (package DB), TS-5 (validation extension). |
| **Key behaviors** | BEAP patches: suppress gain staging warnings for BEAP modules (they handle their own levels internally). Vizzie patches: suppress signal-type mismatch warnings (matrix outlets connecting to matrix inlets). Per-package convention documentation in the DB metadata. |

---

## Differentiators

Features that set this apart. Not expected, but provide significant value.

### D-1: Module-Level Template Library

| Aspect | Detail |
|--------|--------|
| **Value proposition** | Pre-built connection patterns for common package workflows. "BEAP subtractive synth" = Keyboard + Oscillator + LPF + VCA + ASR + Stereo with standard wiring. "Vizzie video mixer" = PLAYR x2 + MIXFADR + PROJECTR. Saves massive time vs manual bpatcher discovery and wiring. |
| **Complexity** | High |
| **Dependencies** | TS-1 (DB), TS-2 (bpatcher generation), TS-7 (relationships). |
| **Notes** | Analogous to `ext_templates.py` for externals. A `package_templates.py` with recipe functions per package: `beap_subtractive()`, `beap_fm()`, `beap_sequenced()`, `vizzie_basic_vj()`, `vizzie_feedback_loop()`. Each returns a Patcher with modules wired. |

### D-2: Cross-Domain Package Mixing

| Aspect | Detail |
|--------|--------|
| **Value proposition** | Patches combining BEAP audio with Vizzie video, connected via bridge objects (snapshot~ to Jitter, audio analysis to visual parameters). Or FluCoMa analysis feeding bach notation. This is where AI generation truly shines -- users struggle with cross-package integration. |
| **Complexity** | High |
| **Dependencies** | All table stakes, deep per-package domain knowledge. |
| **Notes** | Bridge patterns are well-known but manual: BEAP audio -> snapshot~ -> scale -> Jitter matrix. FluCoMa descriptors -> bach lllls for notation. The AI can suggest and wire these bridges automatically. |

### D-3: Package-Specific Critics

| Aspect | Detail |
|--------|--------|
| **Value proposition** | Semantic checks beyond validation. BEAP critic: "You have bp.Oscillator but no Output module -- patch will be silent." Vizzie critic: "PLAYR needs a media file path." FluCoMa critic: "fluid.bufcompose~ needs a source buffer." |
| **Complexity** | Medium per critic |
| **Dependencies** | TS-1, TS-5, TS-7. |
| **Notes** | Follows existing pattern: dsp_critic.py, rnbo_critic.py, m4l_critic.py, ext_critic.py. Each package critic is a new file in `critics/`. Start with BEAP (largest, most structured). |

### D-4: Automatic bpatcher Extraction from Existing Patches

| Aspect | Detail |
|--------|--------|
| **Value proposition** | Parse a user's existing .maxpat, detect which sections could be replaced by package modules, suggest "this oscillator+filter chain could be bp.Oscillator + bp.LPF". Leverages the `analyze()` section detection already in the system. |
| **Complexity** | High |
| **Dependencies** | TS-1, analysis.py section detection, pattern matching. |

### D-5: Inline Package Documentation

| Aspect | Detail |
|--------|--------|
| **Value proposition** | Generated patches include comment boxes explaining module behavior, parameter ranges, and CV conventions. The inlet comment metadata is already rich: bp.Oscillator's inlets have descriptions like "CV1: 1v/oct pitch modulation input." |
| **Complexity** | Low |
| **Dependencies** | TS-1 (inlet comment metadata from DB). |

### D-6: Tier 2 Package Onboarding Wizard

| Aspect | Detail |
|--------|--------|
| **Value proposition** | Instead of manually cataloging every community package, provide a command (`/max-onboard-package FluCoMa`) that scans an installed package, extracts object metadata from help patches and patchers, and generates a domain JSON file. This is the scalability play for the long tail of ~15+ community packages. |
| **Complexity** | High |
| **Dependencies** | TS-4 (detection), audit pipeline for extraction. |

### D-7: Package-Aware `/max-research`

| Aspect | Detail |
|--------|--------|
| **Value proposition** | When researching approaches, consider available package solutions. "How to do spectral processing?" should mention FluCoMa (if installed), BEAP's Phase Vocoder module, and core pfft~ -- ranked by complexity and capability. |
| **Complexity** | Low |
| **Dependencies** | TS-1, TS-4. |

---

## Anti-Features

Features to explicitly NOT build.

| Anti-Feature | Why Avoid | What to Do Instead |
|--------------|-----------|-------------------|
| Blanket project-level package access | User explicitly requested per-patch permission gating. Auto-enabling all installed packages removes user control over dependencies. | Require explicit `allowed_packages` per patch. `/max-iterate` prompts before first use of a new package. |
| Package auto-installation | Downloading packages touches the user's MAX installation, could break existing patches, and has licensing implications (IRCAM Spat = paid license, bach = free but large). | Detect what's installed, report what's missing, let user install manually. |
| Generating package module internals | BEAP/Vizzie modules are authored by package maintainers. Recreating the guts of bp.Oscillator in gen~ would be fragile, wrong, and miss the point. | Use modules as bpatcher black boxes. Generate wiring between modules, not module internals. |
| Exhaustive Tier 2 support at launch | Cataloging all ~1,000+ Tier 2 objects (bach: 250+, Spat: 300+, cage: 80+, dada: 30+, EARS: 40+) before shipping anything creates months of prerequisite work for zero user value. | Ship Tier 1 (bundled packages) first with full parity. Add Tier 2 incrementally via onboarding wizard (D-6). |
| Custom module creation tooling | Building tools for users to create their own BEAP-style or Vizzie-style modules is module development, not patch generation. | Focus on consuming existing modules. Regular bpatcher abstractions via `/max-build` for custom needs. |
| Real-time package update checking | Polling GitHub/Package Manager for new versions is IDE functionality. | Record version at generation time. Passive check on next use only. |

---

## Feature Dependencies

```
TS-4: Package Availability Detection (independent, start first)
  |
  v
TS-1: Package Object Database
  |
  +---> TS-2: bpatcher-Aware Generation
  |       |
  |       +---> D-1: Module Template Library
  |       +---> D-2: Cross-Domain Mixing
  |
  +---> TS-5: Validation Pipeline Extension
  |       |
  |       +---> TS-8: Package-Specific Domain Rules
  |       +---> D-3: Package-Specific Critics
  |
  +---> TS-7: Relationships / Companions
  |       |
  |       +---> D-1: Module Template Library
  |
  +---> TS-6: Package-Aware Router Dispatch
  |       |
  |       +---> D-7: Package-Aware /max-research
  |
  +---> D-5: Inline Documentation
  +---> D-4: Automatic bpatcher Extraction

TS-3: Per-Patch Permission Gating (independent, can parallelize with TS-1)
  |
  +---> TS-6: Router integration (must-ask-before-dispatch)

D-6: Tier 2 Onboarding Wizard (post-Tier-1, reuses extraction pipeline)
```

---

## MVP Recommendation

Prioritize in this order:

1. **TS-4: Package availability detection** -- scan bundled + user package directories, parse `package-info.json`, report inventory. Low complexity, unblocks everything. (Est: 1-2h)
2. **TS-1: Package object DB for Tier 1** -- extend extraction pipeline to parse bpatcher modules from the installed BEAP/Vizzie/Jitter packages. Extract inlet/outlet metadata, dimensions, categories. High complexity but the audit pipeline already exists. (Est: 8-12h)
3. **TS-3: Per-patch permission gating** -- `allowed_packages` in project config, router checks, `/max-iterate` prompt. Aligns with explicit user requirement. (Est: 3-4h)
4. **TS-2: bpatcher-aware generation** -- enhance Patcher API for package module instantiation with correct dimensions and I/O. (Est: 6-8h)
5. **TS-7: Package relationships** -- companion data for BEAP categories and Vizzie flow patterns. (Est: 3-4h)
6. **TS-5: Validation extension** -- teach Layer 2 and 3 about bpatcher module I/O. (Est: 4-5h)
7. **TS-6: Router dispatch** -- package keyword detection and dispatch rules. (Est: 2-3h)
8. **TS-8: Domain rules** -- BEAP +/-5V convention, Vizzie matrix types. (Est: 3-4h)

**Defer to post-MVP:**
- **D-1: Template library** -- build after generation works and patterns emerge from real usage
- **D-2: Cross-domain mixing** -- requires deep per-package knowledge, ship single-package first
- **D-3: Package critics** -- validation covers correctness; critics add polish
- **D-4: bpatcher extraction** -- analysis feature, not generation prerequisite
- **D-6: Tier 2 onboarding** -- ship Tier 1 fully first, then build the scaling pipeline
- **D-7: Package-aware research** -- low effort but low priority

---

## Complexity Estimates

| Feature | New Files | Modified Files | Estimated Effort |
|---------|-----------|----------------|-----------------|
| TS-4: Package detection | 1 (`package_detection.py`) | None | Small (1-2h) |
| TS-1: Package object DB | 4-6 new domain JSONs in `.claude/max-objects/` | `audit/analyzer.py`, `audit/parser.py`, `db_lookup.py` | Large (8-12h) |
| TS-3: Permission gating | None new | `project.py`, router SKILL.md, `max-iterate.md` | Medium (3-4h) |
| TS-2: bpatcher generation | 1 (`package_generation.py`) or extend `patcher.py` | `patcher.py`, `sizing.py`, `defaults.py` | Large (6-8h) |
| TS-7: Relationships | 2-4 per-package relationship JSONs | `db_lookup.py` or `relationships.json` | Medium (3-4h) |
| TS-5: Validation extension | None new | `validation.py` (Layer 2 + 3) | Medium (4-5h) |
| TS-6: Router dispatch | None new | `max-router/SKILL.md`, dispatch-rules.md | Small (2-3h) |
| TS-8: Domain rules | None new | `validation.py` (Layer 4), `critics/dsp_critic.py` | Medium (3-4h) |
| D-1: Template library | 1 (`package_templates.py`) | None | Medium (4-6h) |
| D-3: Package critics | 2-4 new (`beap_critic.py`, etc.) | `critics/__init__.py` | Medium per critic (3-4h each) |
| D-6: Tier 2 onboarding | 1 new command, 1 script | Audit pipeline | Large (8-12h) |

**Total MVP estimate:** ~30-42h across 8 table stakes features.

---

## Sources

- **On-disk verification:** `/Applications/Max.app/Contents/Resources/C74/packages/` -- enumerated all 17 bundled packages, counted modules per category for BEAP (168 clippings across 17 categories) and Vizzie (110 clippings across 8 categories), examined bpatcher internal structure (bp.Oscillator: 93 inner boxes, 6 inlets with descriptive comments, 2 signal outlets, 314x116 dimensions)
- [Cycling '74 Package Documentation](https://docs.cycling74.com/userguide/packages/) -- package folder structure (26 standard directories), `package-info.json` schema, package discovery mechanism
- [BEAP GitHub Wiki](https://github.com/stretta/BEAP/wiki/BEAP-Modular---Overview-and-Install) -- BEAP signal conventions (+/-5V eurorack standard), portability guarantees
- [Vizzie Package Page](https://cycling74.com/packages/vizzie) -- Vizzie module naming convention (`vz.*` abstractions), dual-mode usage (bpatcher clippings + abstraction objects)
- [bach Project](https://www.bachproject.net/) -- bach/cage/dada family scope (~250+ objects, lllls data type, notation support)
- [FluCoMa Installation](https://learn.flucoma.org/installation/max/) -- FluCoMa package structure, installation path
- [IRCAM Spat5](https://forum.ircam.fr/projects/detail/spat/) -- Spat5 scope (~300 objects), licensing (paid via IRCAM Forum)
- [ml.star Package](https://cycling74.com/packages/mlstar) -- ml.* object inventory (~8 objects: ml.art, ml.fcm, ml.kdtree, ml.lzw, ml.mlp, ml.som, ml.spatial, ml.hmm, ml.markov)
- **Codebase verification:** `src/maxpat/db_lookup.py` (DOMAIN_LOAD_ORDER, ObjectDatabase class), `src/maxpat/validation.py` (4-layer pipeline, `_STRUCTURAL_MAXCLASSES`), `src/maxpat/critics/` (5 critic files), `.claude/max-objects/packages/objects.json` (87 existing abl.*/jit.mo/live/mira objects), `.claude/commands/max-iterate.md` and `.claude/commands/max-build.md` (existing command workflows), `.claude/skills/max-router/SKILL.md` (dispatch rules and keyword tables)
