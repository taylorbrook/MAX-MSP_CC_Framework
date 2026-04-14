# Phase 21: Bundled Package Extraction (BEAP + Vizzie) - Context

**Gathered:** 2026-04-13
**Status:** Ready for planning

<domain>
## Phase Boundary

Extract BEAP (~192 modules), Vizzie (~114 modules), Jitter Geometry (~27 objects), and Jitter Tools (~99 objects) into the object database. Build a new abstraction parser for bpatcher-based packages (BEAP/Vizzie) and extend the existing XML pipeline for Jitter packages.

</domain>

<decisions>
## Implementation Decisions

### Abstraction Parsing Strategy
- **D-01:** Build a single unified `extract_abstractions.py` that handles both BEAP and Vizzie. BEAP uses embedded bpatchers (I/O in nested patcher), Vizzie uses top-level inlet/outlet objects -- detect pattern and branch accordingly.
- **D-02:** Extract object descriptions from `.maxhelp` help patches (172 BEAP, Vizzie has help dir). Richest source of description/digest text.
- **D-03:** Auto-discover categories from folder structure. BEAP: use `clippings/BEAP/{Category}/` subdirectory names (Oscillator, Filter, LFO, etc). Vizzie: derive from prefix patterns.
- **D-04:** Include ALL bp.*.maxpat files -- clippings (168) plus misc/marco_osc and misc extras (24). Total: 192 BEAP modules.

### DB Entry Format
- **D-05:** Use `maxclass: "bpatcher"` for all BEAP and Vizzie entries. Matches actual instantiation pattern in MAX.
- **D-06:** Include four extra fields beyond standard object entries:
  - `abstraction_file` -- relative path to .maxpat within MAX package (needed for bpatcher `name=` attribute)
  - `bpatcher_dimensions` -- default width/height from .maxpat rect (for layout)
  - `category` -- Oscillator, Filter, etc. from folder structure
  - `signal_convention` -- BEAP uses 0-5V CV range, Vizzie uses Jitter matrices
- **D-07:** Bpatcher instantiation only. No alt_maxclass for standalone abstraction mode -- BEAP/Vizzie are designed as bpatchers with presentation UIs.

### Jitter Geometry + Tools Extraction
- **D-08:** Run existing `extract_objects.py` XML pipeline. Add Jitter Geometry and Jitter Tools as new SOURCE_DIRS entries. No new code needed.
- **D-09:** Output to separate per-package directories (`packages/Jitter Geometry/objects.json`, `packages/Jitter Tools/objects.json`). Preserves package-level gating from Phase 20.
- **D-10:** Use XML refpages for all 99 Jitter Tools objects (compiled + abstraction-based). Refpages are authoritative for I/O and descriptions regardless of implementation type.

### Verification Approach
- **D-11:** Automated cross-check: compare extracted I/O counts against help patch bpatcher instances (`numinlets`/`numoutlets`). Flag mismatches. Extend existing audit pipeline at `src/maxpat/audit/`.
- **D-12:** DB round-trip integration test: load ObjectDatabase, look up every BEAP/Vizzie object by name, verify I/O counts match extracted data. Catches broken JSON, missing entries, alias issues.

### Claude's Discretion
- Parser implementation details (JSON traversal, error handling, output format)
- How to handle edge cases (BEAP modules with 0 I/O, malformed patches)
- Test structure and organization

</decisions>

<canonical_refs>
## Canonical References

**Downstream agents MUST read these before planning or implementing.**

### Milestone Proposal
- `.planning/milestones/v4.0-package-integration-PROPOSAL.md` -- Full milestone breakdown, phase scope, target packages table

### Requirements
- `.planning/REQUIREMENTS.md` §Extraction (Phase 21) -- PKG-05 through PKG-08

### Existing Extraction Pipeline
- `.claude/scripts/extract_objects.py` -- XML refpage extractor. SOURCE_DIRS and PACKAGE_GLOBS patterns show how to add new package sources.

### Object Database
- `src/maxpat/db_lookup.py` -- ObjectDatabase class with package-aware API (lookup, list_packages, get_package_objects). New entries must conform to existing schema.
- `.claude/max-objects/packages/` -- Per-package subdirectory structure. BEAP/ and Vizzie/ dirs exist but are empty.
- `.claude/max-objects/packages/package_info.json` -- Package registry (add entries for Jitter Geometry, Jitter Tools)

### MAX Package Sources (on disk)
- `/Applications/Max.app/Contents/Resources/C74/packages/BEAP/` -- clippings/BEAP/{Category}/ for modules, Help/ for .maxhelp files
- `/Applications/Max.app/Contents/Resources/C74/packages/Vizzie/` -- patchers/ for modules, help/ for help files
- `/Applications/Max.app/Contents/Resources/C74/packages/Jitter Geometry/` -- 27 XML refpages
- `/Applications/Max.app/Contents/Resources/C74/packages/Jitter Tools/` -- 99 XML refpages

### Existing Audit Pipeline
- `src/maxpat/audit/` -- analyzer.py, parser.py, merger.py, cli.py. Extend for help-patch cross-checking.

</canonical_refs>

<code_context>
## Existing Code Insights

### Reusable Assets
- `extract_objects.py` -- XML extraction pipeline. Jitter Geometry/Tools can plug directly into SOURCE_DIRS.
- `ObjectDatabase` -- Package-aware lookup, filtering, and listing already implemented in Phase 20.
- `src/maxpat/audit/` -- Help patch parsing and analysis pipeline. Extend for I/O cross-checking.

### Established Patterns
- Domain JSON files at `.claude/max-objects/{domain}/objects.json` -- standard schema for all objects.
- Per-package subdirs under `packages/` -- BEAP/ and Vizzie/ already exist with empty objects.json.
- Package registry in `package_info.json` -- each package has name, tier, prefix, version, install method.

### Integration Points
- `ObjectDatabase.__init__` scans `packages/` subdirectories and loads per-package JSON automatically. New entries will be picked up without code changes.
- `package_info.json` needs entries for Jitter Geometry and Jitter Tools (BEAP/Vizzie likely already have stubs).

</code_context>

<specifics>
## Specific Ideas

- BEAP clipping wrappers contain a single embedded bpatcher. The actual I/O is on the nested patcher's `inlet`/`outlet` objects (not top-level).
- BEAP bpatcher `numinlets`/`numoutlets` fields on the embedded bpatcher box are the authoritative I/O counts.
- Vizzie patchers have standard top-level `inlet`/`outlet` objects with descriptive `comment` attributes.
- BEAP misc/marco_osc/ contains additional oscillator variants by Marco Reckziegel (bp.Tuned Delay, bp.FM-OD, etc).

</specifics>

<deferred>
## Deferred Ideas

None -- discussion stayed within phase scope.

</deferred>

---

*Phase: 21-bundled-package-extraction*
*Context gathered: 2026-04-13*
