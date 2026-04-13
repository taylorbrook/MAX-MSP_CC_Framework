# Integrate MAX Packages into Framework - Research

**Researched:** 2026-04-12
**Domain:** MAX/MSP package ecosystem, object DB architecture, extraction pipelines
**Confidence:** HIGH

## Summary

The framework's object DB currently has 87 package objects (74 ableton-dsp `abl.*`, 8 `jit.mo`, 2 `mira`, 3 `live.*`) extracted from XML refpages. Bundled Cycling'74 packages (BEAP, Vizzie) are abstraction-based -- they have NO XML refpages, only `.maxpat` bpatcher abstractions with `.maxhelp` help patches. This means the existing `extract_objects.py` pipeline (XML-based) cannot extract them; a new bpatcher/abstraction extraction path is required.

Community packages (CNMAT, Bach, FluCoMa, IRCAM Spat, Odot, ml.*) are external downloads that may or may not be installed. They use a mix of compiled externals (with XML refpages when installed) and abstractions. The key architectural challenge is making the DB **install-aware** -- agents must know which packages are available before using their objects.

**Primary recommendation:** Two-tier extraction: extend `extract_objects.py` for XML-bearing packages (already proven), build a new `extract_abstractions.py` for bpatcher-based packages (BEAP, Vizzie). Add `package` field to every object entry. Add package registry to project config. Gate agent object usage on project-level package selection.

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions
- Bundled Cycling'74 packages: BEAP, VIZZIE, Mira (partial exists), RNBO examples
- Popular community packages: CNMAT, Bach, IRCAM Spat, Odot, FluCoMa, ml.*, and others as identified
- Two-tier approach: bundled first (guaranteed installed), then community (require install)
- Full parity with core domains -- not just DB entries
- Object DB entries with validation, alias resolution, connection checking
- Agent-specific guidance per package (BEAP modular patterns, VIZZIE chains, FluCoMa analysis workflows)
- Starter templates for common package workflows
- Dedicated critics, layout overrides, and relationships.json entries per package
- All package objects MUST be tagged with their source package
- Installation requirements tracked per package (package name, version, install method)
- `/max-new` asks user which packages they want to use
- If not decided at creation, `/max-build` prompts before generating with package objects
- Package selection stored in project config and gates which objects agents can use
- No silent generation with unavailable packages -- always user-confirmed

### Claude's Discretion
- Which additional community packages beyond the named ones
- Internal DB structure (per-package domain files vs single packages file vs hybrid)
- Extraction pipeline architecture details

### Deferred Ideas (OUT OF SCOPE)
None stated.
</user_constraints>

## Package Ecosystem Survey

### Tier 1: Bundled Packages (shipped with MAX)

| Package | Objects | Type | XML Refpages | Help Patches | Extraction Method |
|---------|---------|------|-------------|--------------|-------------------|
| **BEAP** | ~172 modules | bpatcher abstractions (`bp.*`) | 0 | 172 | Abstraction parser (NEW) |
| **Vizzie** | ~110 modules | bpatcher abstractions (`vz.*`) | 0 | 114 | Abstraction parser (NEW) |
| **ableton-dsp** | 74 objects | compiled externals (`abl.*`) | 74 | 74 | XML extraction (EXISTING -- already in DB) |
| **jit.mo** | 8 objects | compiled externals | 8 | 12 | XML extraction (EXISTING -- already in DB) |
| **Mira** | 2 objects | compiled externals | partial | 3 | XML extraction (EXISTING -- already in DB) |
| **Jitter Geometry** | ~26 objects | compiled externals | check | 26 | XML extraction |
| **Jitter Tools** | ~99 objects | compiled + abstractions | check | 99 | XML/hybrid |
| **RNBO** | ~560 objects | compiled externals | 560 | 560 | XML extraction (EXISTING -- already in DB) |

[VERIFIED: filesystem scan of /Applications/Max.app/Contents/Resources/C74/packages/]

### Tier 2: Community Packages (require installation)

| Package | Est. Objects | Type | Install Method | MAX Version | Notes |
|---------|-------------|------|---------------|-------------|-------|
| **FluCoMa** | ~60 | compiled externals (`fluid.*`) | Package Manager | 7+ | Audio analysis, ML, decomposition [VERIFIED: learn.flucoma.org/reference] |
| **CNMAT Externals** | ~30 | compiled externals | Package Manager / GitHub | 6+ | OSC, mapping, spectral analysis [CITED: github.com/CNMAT/CNMAT-Externs] |
| **Odot** | ~40 | compiled externals (`o.*`) | Package Manager | 7+ | OSC expression language, data processing [CITED: cycling74.com/articles/cnmat-odot] |
| **Bach** | ~250+ | externals + abstractions (`bach.*`) | Package Manager | 7.3.5+ | CAC, notation, lllls -- very large [ASSUMED -- exact count unverified] |
| **IRCAM Spat** | ~300 | compiled externals (`spat5.*`) | IRCAM Forum (license) | 8+ | Spatialization -- requires IRCAM subscription [CITED: forum.ircam.fr/projects/detail/spat/] |
| **ml.star / ml-lib** | ~8 | compiled externals (`ml.*`) | Package Manager | 7+ | ML: MLP, SOM, KDTree, clustering [CITED: benjamindaysmith.com/ml-machine-learning-toolkit-in-max] |

**Key finding:** Community packages are NOT installed on this machine. Only bundled packages exist at `/Applications/Max.app/Contents/Resources/C74/packages/`. User packages directory (`~/Documents/Max 9/Packages/`) does not exist yet. [VERIFIED: filesystem check]

## Existing DB Architecture

### Current Structure
```
.claude/max-objects/
  packages/objects.json    # 87 objects (abl.*, jit.mo.*, mira.*, live.*)
  max/objects.json         # 470 core Max objects
  msp/objects.json         # 248 MSP objects
  ...
```

Each object has: `name`, `maxclass`, `module`, `domain`, `inlets[]`, `outlets[]`, `arguments[]`, `messages[]`, `attributes{}`, `min_version`, `verified`, `rnbo_compatible`, `variable_io`.

**Missing field:** No `package` field. All 87 package objects have `"module": "max"` or `"module": "mira"` -- no way to filter by source package. [VERIFIED: objects.json analysis]

### ObjectDatabase Load Order
```python
DOMAIN_LOAD_ORDER = ["rnbo", "packages", "m4l", "gen", "mc", "jitter", "msp", "max"]
```
Core domains load LAST and take priority (e.g., MSP `cycle~` overrides RNBO `cycle~`). Packages load early, so core objects correctly shadow package duplicates. [VERIFIED: db_lookup.py]

### Extraction Pipeline
1. **`extract_objects.py`**: Parses XML `.maxref.xml` refpages from MAX installation. Maps source dirs to domains. Outputs per-domain JSON. [VERIFIED: .claude/scripts/extract_objects.py]
2. **`audit/`**: Help-patch-based audit pipeline. Parses `.maxhelp` files, extracts `BoxInstance` data (name, numinlets, numoutlets, outlettype, connections). Compares against DB to find discrepancies. Generates proposed overrides. [VERIFIED: src/maxpat/audit/]

### What Needs to Change

| Component | Current | Required Change |
|-----------|---------|-----------------|
| Object entries | No `package` field | Add `"package": "beap"` (or `null` for core) to every object |
| `packages/objects.json` | Single file, 87 objects | Split into per-package files OR add package field + keep single file |
| `extract_objects.py` | XML refpages only | Add abstraction extraction mode for bpatcher packages |
| `db_lookup.py` | No package filtering | Add `lookup(name, allowed_packages=None)`, `list_packages()`, `get_package_objects(pkg)` |
| `validation.py` | Warns on unknown objects | Also warn when using package object not in project's allowed packages |
| Project config (`status.md`) | No package field | Add `packages: [beap, vizzie, ...]` to project config |
| Agent prompts | No package awareness | Add package context to agent system prompts based on project config |
| `relationships.json` | 23 pairs, core only | Add package-specific pairs (e.g., BEAP `bp.VCA` + `bp.Oscillator`) |

## Extraction Approach

### Path A: XML Refpages (existing pipeline -- reuse)
Works for: ableton-dsp (done), Jitter Geometry, Jitter Tools, FluCoMa, CNMAT, Bach (externals portion), IRCAM Spat, ml.*, Odot
**How:** Extend `PACKAGE_GLOBS` in `extract_objects.py` to include new package paths. Add `package` field to output.

### Path B: Abstraction/Bpatcher Extraction (NEW -- must build)
Works for: BEAP (~172 modules), Vizzie (~110 modules)
**How:** Parse help patches to find bpatcher boxes matching the module name. Extract `numinlets`, `numoutlets` from the bpatcher box definition. For signal type info, open the actual `.maxpat` abstraction and scan for `inlet~`/`outlet~` objects inside.

**Proof of concept verified:** Scanning BEAP help patches successfully extracted I/O counts for 90 of 172 modules (the remaining 82 lack a self-referencing bpatcher in their help patch -- will need the alternative approach of opening the abstraction .maxpat directly). [VERIFIED: live test in this session]

### Path C: Community Package Extraction (deferred until installed)
Community packages are not installed on this machine. Extraction must handle: (1) packages that ARE installed -- extract normally, (2) packages that are NOT installed -- provide stub DB entries with metadata only (name, package, install instructions), marked `"extracted": false`.

**Recommendation:** Build the extraction tools now. Provide manual extraction commands (`python extract_objects.py --package flucomca --path ~/Documents/Max\ 9/Packages/FluidCorpusManipulation`). Ship stub entries for community packages so agents know about them even when not installed.

## Common Pitfalls

### Pitfall 1: Abstraction vs External Confusion
**What goes wrong:** BEAP/Vizzie modules are `.maxpat` bpatcher abstractions, not compiled externals. They use `maxclass: "bpatcher"` with a `name` attribute pointing to the `.maxpat` file, NOT `maxclass: "newobj"` with text.
**How to avoid:** The DB entry for BEAP/Vizzie objects must specify `"maxclass": "bpatcher"` and include `"abstraction_file"` field. Patch generation must use `add_bpatcher()` not `add_box()`.

### Pitfall 2: Package Object Name Shadowing
**What goes wrong:** Some package objects share prefixes with core objects (e.g., `live.dial` is core M4L, `live.adsrui` could be confused). BEAP uses `bp.*` prefix (unique), Vizzie uses `vz.*` prefix (unique), but some packages may shadow core names.
**How to avoid:** Load order matters. Document shadowing risks per package. Test for conflicts during extraction.

### Pitfall 3: Missing Package at Runtime
**What goes wrong:** Agent generates a patch using BEAP modules, user doesn't have BEAP installed (unlikely for bundled, critical for community packages). Patch opens with missing objects.
**How to avoid:** Package gating in project config. Validation warns on unconfirmed packages. `/max-build` refuses to use package objects unless package is in project's allowed list.

### Pitfall 4: BEAP Signal Convention
**What goes wrong:** BEAP modules use CV-style signaling (0-5V range for pitch/gate) internally, not standard MAX signal conventions. Connecting raw MSP audio into BEAP CV inputs or vice versa produces wrong results.
**How to avoid:** Agent guidance must document BEAP signal conventions. Add this to BEAP-specific agent prompt section. [ASSUMED -- needs verification from BEAP documentation]

### Pitfall 5: Bach Data Types
**What goes wrong:** Bach introduces `llll` (Lisp-like linked list) data types that don't interoperate with standard MAX lists. Connecting `bach.roll` output to a standard `unpack` fails silently.
**How to avoid:** Agent guidance for Bach must emphasize using `bach.` objects for all llll manipulation. Never mix bach lllls with standard MAX list processing. [ASSUMED -- based on Bach documentation description]

## Milestone Phasing Recommendation

### Phase 1: DB Schema + Package Field
- Add `"package"` field to all existing objects (null for core, package name for packages)
- Add `"package_info"` metadata file per package (name, version, install method, tier, prefix)
- Update `ObjectDatabase` with package-aware methods

### Phase 2: Bundled Package Extraction (BEAP + Vizzie)
- Build abstraction extraction pipeline
- Extract ~172 BEAP modules and ~110 Vizzie modules
- Verify I/O counts, add to DB

### Phase 3: Package-Gated Generation
- Add package selection to project config
- Update `/max-new` to prompt for packages
- Update validation to warn on ungated package objects
- Update `db_lookup.py` filtering

### Phase 4: Agent Package Intelligence
- Package-specific guidance in agent prompts
- BEAP modular patching patterns, Vizzie chains, FluCoMa workflows
- Package-specific relationships.json entries
- Layout overrides (BEAP modules are large bpatchers)

### Phase 5: Community Package Support
- Stub entries for FluCoMa, CNMAT, Bach, Odot, ml.*, IRCAM Spat
- Extraction commands for installed packages
- Install guidance in agent prompts

### Phase 6: Templates + Critics
- Starter templates per package
- Package-aware critics (BEAP signal conventions, Bach llll handling)

## Assumptions Log

| # | Claim | Section | Risk if Wrong |
|---|-------|---------|---------------|
| A1 | Bach has ~250+ objects | Package Survey | Low -- exact count affects DB sizing but not architecture |
| A2 | BEAP uses CV-style 0-5V signaling | Pitfall 4 | Medium -- incorrect agent guidance if wrong |
| A3 | Bach lllls don't interoperate with standard lists | Pitfall 5 | Medium -- incorrect agent guidance if wrong |
| A4 | Community packages provide XML refpages when installed | Extraction Approach | High -- if they don't, extraction pipeline needs another path |

## Open Questions

1. **Per-package domain files vs unified packages file?**
   - Option A: One `packages/objects.json` with `package` field (simpler, current approach scaled up)
   - Option B: Per-package files `packages/beap/objects.json`, `packages/vizzie/objects.json` (cleaner isolation)
   - Recommendation: Option B -- cleaner for selective loading, easier to update individual packages

2. **How to handle abstraction I/O types (signal vs control)?**
   - bpatcher boxes in help patches show `numinlets`/`numoutlets` but not signal vs control
   - Need to open the actual `.maxpat` abstraction and scan for `inlet`/`outlet` objects with signal connections
   - This is feasible but requires deeper parsing

3. **Should stub entries for uninstalled community packages block or warn?**
   - Recommendation: Warn-only. Agent should explain the package isn't installed and offer alternatives.

## Sources

### Primary (HIGH confidence)
- Filesystem scan of `/Applications/Max.app/Contents/Resources/C74/packages/` -- package inventory, help patch counts, XML refpage presence
- `extract_objects.py` source -- extraction pipeline architecture
- `db_lookup.py` source -- ObjectDatabase API
- `validation.py` source -- unknown object handling
- `packages/objects.json` -- current DB schema and contents

### Secondary (MEDIUM confidence)
- [FluCoMa reference](https://learn.flucoma.org/reference/) -- 60 objects listed
- [CNMAT Externs GitHub](https://github.com/CNMAT/CNMAT-Externs) -- external listing
- [IRCAM Spat5](https://forum.ircam.fr/projects/detail/spat/) -- 300+ modules
- [ml.star](https://www.benjamindaysmith.com/ml-machine-learning-toolkit-in-max) -- 8 objects listed
- [Bach project](https://www.bachproject.net/) -- large library, exact count unverified

### Tertiary (LOW confidence)
- Bach object count (~250+) -- extrapolated from "large collection" descriptions
- BEAP signal conventions -- inferred from modular synthesis context

## Metadata

**Confidence breakdown:**
- DB Architecture: HIGH -- fully verified from source code
- Bundled package survey: HIGH -- filesystem verified
- Community package survey: MEDIUM -- web research, packages not installed locally
- Extraction approach: HIGH -- proof of concept tested for both XML and abstraction paths
- Pitfalls: MEDIUM -- some assumed from domain knowledge

**Research date:** 2026-04-12
**Valid until:** 2026-05-12 (stable -- MAX package ecosystem changes slowly)
