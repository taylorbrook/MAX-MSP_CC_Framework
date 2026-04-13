# Quick Task 260412-qy8: Integrate MAX Packages into Framework - Context

**Gathered:** 2026-04-13
**Status:** Ready for planning

<domain>
## Task Boundary

Plan a new milestone that integrates MAX packages into the framework — covering which packages to include, object DB population, validation, agent support, and installation/version handling.

</domain>

<decisions>
## Implementation Decisions

### Package Scope
- Bundled Cycling'74 packages: BEAP, VIZZIE, Mira (partial exists), RNBO examples
- Popular community packages: CNMAT, Bach, IRCAM Spat, Odot, FluCoMa, ml.*, and others as identified
- Two-tier approach: bundled first (guaranteed installed), then community (require install)

### Integration Depth
- Full parity with core domains — not just DB entries
- Object DB entries with validation, alias resolution, connection checking
- Agent-specific guidance per package (BEAP modular patterns, VIZZIE chains, FluCoMa analysis workflows)
- Starter templates for common package workflows
- Dedicated critics, layout overrides, and relationships.json entries per package
- All package objects MUST be tagged with their source package so they can be filtered/avoided if the package is not available
- Installation requirements tracked per package (package name, version, install method)

### Installation Handling
- `/max-new` slash command asks user which packages they want to use for the project
- If not decided at project creation, `/max-build` prompts before generating with package objects
- Package selection stored in project config and gates which objects agents can use
- No silent generation with unavailable packages — always user-confirmed

</decisions>

<specifics>
## Specific Ideas

- FluCoMa (Fluid Corpus Manipulation) for ML/audio analysis workflows
- ml.* objects for machine learning in MAX
- Bach for computer-aided composition
- CNMAT for OSC, mapping, and data structures
- IRCAM Spat for spatialization
- Odot for expression-based data processing
- Package objects tagged by source so the DB can filter by installed packages

</specifics>

<canonical_refs>
## Canonical References

- Existing packages DB: `.claude/max-objects/packages/objects.json` (87 objects, only max/mira modules currently)
- Object DB architecture: `.claude/max-objects/` with per-domain JSON files
- ObjectDatabase class: `src.maxpat.db_lookup` handles lookups, aliases, overrides, PD blocklist
- Project config lives in per-project directories under `projects/`

</canonical_refs>
