# Phase 24: Community Package Support - Context

**Gathered:** 2026-04-15
**Status:** Ready for planning

<domain>
## Phase Boundary

Provide DB presence for community packages even when not locally installed. Curated stub entries for all 10 community packages (FluCoMa, CNMAT, Bach, Odot, ml-lib, IRCAM Spat, Cage, Dada, EARS, Rhythmic Time Toolkit). CLI extraction commands for installed packages. Block generation with unextracted community packages.

</domain>

<decisions>
## Implementation Decisions

### Stub Entry Depth
- **D-01:** Curated object lists per package with object names, approximate I/O counts, signal types, and categories. Not just name-only stubs -- enough detail that agents understand what objects exist and their basic signatures.
- **D-02:** Data sourced from official documentation + GitHub repos as primary source, supplemented by local extraction for any packages installed on the developer's machine.
- **D-03:** Stubs marked with `extracted: false` in package_info.json. Agents can check this flag to know data is approximate. After local extraction via CLI, entries upgrade to `extracted: true` with verified data.

### Extraction UX
- **D-04:** CLI command via `extract_objects.py --package FluCoMa`. Extends existing extraction pipeline with `--package` flag for community packages.
- **D-05:** Auto-detect install path first -- check `~/Documents/Max 9/Packages/{name}` and `/Applications/Max.app/.../packages/{name}`. Fall back to `--path /custom/location` if not found.
- **D-06:** Use existing XML pipeline (`extract_objects.py`) for compiled externals (FluCoMa, CNMAT, Odot, ml-lib, IRCAM Spat). Fall back to `extract_abstractions.py` for mixed packages (Bach, Cage, Dada, EARS). Auto-detect which pipeline based on package contents.

### Install Guidance
- **D-07:** Block generation with unextracted community packages. Do NOT generate with stub data. User must install the package and run extraction first.
- **D-08:** Block message includes full unblock path: "FluCoMa is not installed. Install via MAX Package Manager, then run: `python extract_objects.py --package FluCoMa`"
- **D-09:** Block check uses `extracted: false` flag in package_info.json. Simple boolean check -- no filesystem probing. After user runs extraction, flag flips to true and they're unblocked.

### Package Coverage
- **D-10:** All 10 community packages in package_info.json get curated stubs: FluCoMa, CNMAT, Bach, Odot, ml-lib, IRCAM Spat, Cage, Dada, EARS, Rhythmic Time Toolkit.
- **D-11:** RNBO left as-is -- already has full DB coverage in `rnbo/objects.json` (560 objects) with its own agent and database wrapper. No community package treatment.

### Claude's Discretion
- Exact object lists per community package (determined by documentation research)
- How to structure the `--package` flag integration in extract_objects.py
- Pipeline auto-detection logic (XML vs. abstraction based on package contents)
- Exact wording of block messages per install method (Package Manager vs. installer vs. GitHub)
- How extraction updates package_info.json `extracted` and `object_count` fields

</decisions>

<canonical_refs>
## Canonical References

**Downstream agents MUST read these before planning or implementing.**

### Milestone Proposal
- `.planning/milestones/v4.0-package-integration-PROPOSAL.md` -- Phase 24 scope, target packages table with all community packages, install methods, prefixes

### Requirements
- `.planning/REQUIREMENTS.md` §Community (Phase 24) -- PKG-19 through PKG-22

### Object Database
- `.claude/max-objects/package_info.json` -- Package registry with all 10 community packages already registered (tier, prefix, install_method, extracted: false)
- `.claude/max-objects/packages/` -- Per-package subdirectories with empty objects.json files for all community packages
- `src/maxpat/db_lookup.py` -- ObjectDatabase class with `allowed_packages` filtering, `lookup()`, `list_packages()`, `get_package_objects()`

### Extraction Pipelines
- `.claude/scripts/extract_objects.py` -- XML refpage extraction pipeline. Needs `--package` flag addition for community packages.
- `.claude/scripts/extract_abstractions.py` -- Abstraction extraction for bpatcher-based packages (BEAP/Vizzie). Reuse for Bach/Cage/Dada/EARS.

### Prior Phase Context
- `.planning/phases/20-db-schema-foundation/` -- Package field schema, package_info.json design
- `.planning/phases/21-bundled-package-extraction/21-CONTEXT.md` -- Extraction patterns, DB entry format, both pipelines
- `.planning/phases/22-package-gated-generation/22-CONTEXT.md` -- Gating behavior, config.json, allowed_packages flow

### Community Package Documentation (for curation)
- FluCoMa: https://learn.flucoma.org/reference/ -- Full object reference with I/O descriptions
- Bach: https://bachproject.net/docs/ -- Object reference for 250+ objects
- CNMAT: GitHub cnmat/CNMAT-Externals -- Object list and descriptions
- Odot: GitHub CNMAT/ODOT -- o.* object reference
- IRCAM Spat: https://forum.ircam.fr/projects/detail/spat/ -- spat5.* reference (requires account)
- ml-lib: GitHub irllabs/ml-lib -- ml.* object reference
- Cage/Dada/EARS: Part of Bach ecosystem -- bachproject.net

</canonical_refs>

<code_context>
## Existing Code Insights

### Reusable Assets
- `extract_objects.py` -- XML pipeline already handles bundled packages. Community packages with XML refpages slot in directly.
- `extract_abstractions.py` -- Abstraction parser for bpatcher-based packages. Handles BEAP/Vizzie pattern already.
- `ObjectDatabase` -- Package-aware filtering, listing, lookup all implemented. New stubs will be loaded automatically from `packages/{name}/objects.json`.
- `package_info.json` -- All 10 community packages already registered with correct tier, prefix, install_method. Just needs `extracted` flag check enforcement.

### Established Patterns
- Per-package subdirectories at `.claude/max-objects/packages/{name}/objects.json` -- empty files exist for all community packages
- Package registry entries follow consistent schema: name, tier, prefix, version, install_method, description, object_count, extracted
- Extraction scripts update both `objects.json` and `package_info.json` (object_count, extracted flag)

### Integration Points
- `ObjectDatabase.__init__` auto-loads all `packages/*/objects.json` -- new stub data will be picked up without code changes
- Phase 22 gating checks `allowed_packages` -- community package blocking needs to additionally check `extracted` flag
- Agent SKILL.md files have package context loading sections (from Phase 23) -- add community package install guidance there

</code_context>

<specifics>
## Specific Ideas

- Bach ecosystem is tightly coupled: Bach, Cage, Dada, EARS all share the llll data type. Stubs should note this dependency.
- FluCoMa has the best online documentation of any community package -- likely easiest to curate.
- IRCAM Spat requires a paid IRCAM Forum subscription, different from Package Manager installs. Block message should reflect this.
- ml-lib is very small (~8 objects) -- quick curation.
- Rhythmic Time Toolkit is newer and less documented -- may need more manual curation.

</specifics>

<deferred>
## Deferred Ideas

None -- discussion stayed within phase scope.

</deferred>

---

*Phase: 24-community-package-support*
*Context gathered: 2026-04-15*
