# Phase 20: DB Schema Foundation - Context

**Gathered:** 2026-04-13
**Status:** Ready for planning

<domain>
## Phase Boundary

Every object in the database knows its source package, and ObjectDatabase supports package-aware queries and filtering. This phase adds the `package` field, creates the package registry, extends the ObjectDatabase API, migrates existing package objects to per-package subdirectories, and prepares empty subdirectories for Phase 21 extraction.

</domain>

<decisions>
## Implementation Decisions

### Package Naming
- **D-01:** Use MAX's exact Packages folder names as package identifiers: `"BEAP"`, `"Vizzie"`, `"ableton-dsp"`, `"Mira"`, `"FluCoMa"`, etc. No normalization to kebab-case or prefix-based names.
- **D-02:** `package_info.json` keys match these folder names exactly. Each entry has `prefix`, `tier`, `version`, `install_method`, and `description` fields.

### Core Object Tagging
- **D-03:** Core (non-package) objects do NOT get a `"package"` field added. Field absence = core. Only package objects carry `"package": "<name>"`. This avoids churn across ~1400 core domain objects.
- **D-04:** ObjectDatabase treats missing `package` field as core: `def is_core(obj): return "package" not in obj`.

### allowed_packages Defaults
- **D-05:** `ObjectDatabase.lookup()` without `allowed_packages` returns everything (core + all packages). Fully backward-compatible with existing code.
- **D-06:** `allowed_packages=[]` means core-only. `allowed_packages=["BEAP"]` means core + BEAP. Package gating at the agent/generation layer happens in Phase 22, not here.

### Migration
- **D-07:** Clean break: delete `packages/objects.json` entirely. Split into `packages/ableton-dsp/objects.json` (74 objects), `packages/Mira/objects.json` (2 objects), `packages/jit.mo/objects.json` (8 objects). Remaining 3 objects checked and allocated by actual package source.
- **D-08:** Update domain load to scan `packages/*/objects.json` instead of `packages/objects.json`.
- **D-09:** Create empty `packages/BEAP/objects.json` and `packages/Vizzie/objects.json` (and other known packages) as `{}` placeholders for Phase 21 extraction.

### Claude's Discretion
- `package_info.json` exact schema beyond the decided fields (name, tier, prefix, version, install_method, description) -- Claude can add fields useful for downstream phases
- Internal implementation of `list_packages()` and `get_package_objects()` methods
- Test structure and coverage approach
- Whether to add `is_core()` and `get_package()` convenience methods alongside the required API

</decisions>

<canonical_refs>
## Canonical References

**Downstream agents MUST read these before planning or implementing.**

### Database Structure
- `.claude/max-objects/packages/objects.json` -- Current monolithic package objects file (to be split)
- `.claude/max-objects/aliases.json` -- Alias resolution (may need package-aware updates)
- `.claude/max-objects/overrides.json` -- Override system (package objects may need overrides)

### Implementation
- `src/maxpat/db_lookup.py` -- ObjectDatabase class, the primary target for API extensions
- `.planning/milestones/v4.0-package-integration-PROPOSAL.md` -- Full milestone proposal with package inventory and phase breakdown

### Requirements
- `.planning/REQUIREMENTS.md` -- DBSI-01 through DBSI-06 define success criteria

</canonical_refs>

<code_context>
## Existing Code Insights

### Reusable Assets
- `ObjectDatabase._load()` already handles domain-ordered loading with priority -- extend for per-package subdirectory scanning
- `DOMAIN_LOAD_ORDER` constant controls load priority -- packages load before core domains (core wins on conflict)
- `compute_io_counts()` and `get_outlet_types()` work unchanged -- package objects use same schema

### Established Patterns
- Domain JSON files follow uniform schema: object name as key, object dict as value with `name`, `maxclass`, `module`, `domain`, `inlets`, `outlets`, etc.
- Overrides deep-merge onto base objects -- same pattern works for package objects
- Aliases resolve before lookup -- package objects can have aliases too

### Integration Points
- `DOMAIN_LOAD_ORDER` list in `db_lookup.py` -- needs to change from `"packages"` to dynamic subdirectory scanning
- All existing `db.lookup()` callers -- backward-compatible, no changes needed
- Validation pipeline (`validation.py`) -- Phase 22 adds package gating here, but Phase 20 just needs the API ready

</code_context>

<specifics>
## Specific Ideas

No specific requirements -- open to standard approaches.

</specifics>

<deferred>
## Deferred Ideas

None -- discussion stayed within phase scope.

</deferred>

---

*Phase: 20-db-schema-foundation*
*Context gathered: 2026-04-13*
