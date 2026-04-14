# Phase 22: Package-Gated Generation - Context

**Gathered:** 2026-04-14
**Status:** Ready for planning

<domain>
## Phase Boundary

Ensure agents never silently use package objects the user hasn't confirmed. Package selection happens during project creation (`/max-new`), is stored in project config, and gates all object lookups and validation during generation.

</domain>

<decisions>
## Implementation Decisions

### Package Selection UX
- **D-01:** `/max-new` presents packages in two groups: "Bundled packages" (ship with MAX — BEAP, Vizzie, jit.mo, etc.) and "Community packages" (require install — FluCoMa, CNMAT, Bach, etc.)
- **D-02:** No preset bundles — user picks individual packages from the two lists
- **D-03:** `/max-build` hard-blocks if project hasn't configured packages yet — "Run `/max-new` or `/max-config` to set packages before building"

### Config Storage
- **D-04:** Package selection stored in new `patches/{name}/config.json` — separate from context.md (freeform) and status.md (transient state)
- **D-05:** Simple list format: `{"packages": ["BEAP", "Vizzie"]}` — names match DB package directory names. Metadata already in `package_info.json`.

### Gating Behavior
- **D-06:** Filtered-out package objects treated as non-existent — `lookup()` returns None, agent follows Rule #1 (Never Guess Objects). No special messaging.
- **D-07:** Validation pipeline also enforces package gating post-generation — checks every object in patch against allowed packages. Defense in depth with PKG-04 groundwork from Phase 20.

### Defaults and Mid-Project Changes
- **D-08:** Core only until configured — no packages enabled by default. `/max-new` prompts for selection as part of project creation.
- **D-09:** Users can add/remove packages after creation via direct `config.json` edit or a new `/max-config` command (same bundled/community split as `/max-new`).

### Claude's Discretion
- Implementation details of `/max-config` command (whether it's a new skill or extension of max-lifecycle)
- Exact wording of the `/max-build` block message
- Whether bundled/community classification lives in `package_info.json` or is derived from DB structure

</decisions>

<canonical_refs>
## Canonical References

**Downstream agents MUST read these before planning or implementing.**

### Object Database
- `src/maxpat/db_lookup.py` — ObjectDatabase class with `allowed_packages` filtering already implemented (Phase 20)
- `.claude/max-objects/package_info.json` — Package registry with name, version, install method per package
- `.claude/max-objects/packages/` — Per-package subdirectories with objects.json files (20 packages)

### Project System
- `src/maxpat/project.py` — `create_project()`, `get_active_project()`, project lifecycle functions
- `.claude/skills/max-lifecycle/references/project-structure.md` — Standard project directory layout
- `.claude/skills/max-lifecycle/SKILL.md` — Lifecycle agent capabilities and Python interface

### Agent Skills (need package-aware updates)
- `.claude/skills/max-patch-agent/SKILL.md` — Patch agent uses ObjectDatabase without allowed_packages
- `.claude/skills/max-dsp-agent/SKILL.md` — DSP agent uses ObjectDatabase without allowed_packages
- `.claude/skills/max-ui-agent/SKILL.md` — UI agent uses ObjectDatabase without allowed_packages
- `.claude/skills/max-rnbo-agent/SKILL.md` — RNBO agent uses RNBODatabase wrapping ObjectDatabase

### Requirements
- `.planning/REQUIREMENTS.md` §Generation Gating — PKG-09 through PKG-13

</canonical_refs>

<code_context>
## Existing Code Insights

### Reusable Assets
- `ObjectDatabase.lookup(allowed_packages=...)` — filtering already works, just needs to be called with project config
- `ObjectDatabase.list_packages()` — returns all 20 package names for selection UI
- `ObjectDatabase.get_package(name)` — identifies which package an object belongs to
- `ObjectDatabase.is_core(name)` — checks if object is non-package (always available)
- `_package_objects` dict on ObjectDatabase — maps package name to object list (useful for displaying what's in each package)

### Established Patterns
- Project config pattern: `patches/{name}/` directory with structured files (context.md, status.md, versions.json)
- Active project tracking: `patches/.active-project.json`
- Agent skill pattern: each SKILL.md has "Context Loading" section that reads project state before generation

### Integration Points
- `Patcher.__init__()` creates `ObjectDatabase()` without allowed_packages — needs to accept and pass through
- `Box.__init__()` receives `db` parameter from Patcher — filtering happens at DB level, Box doesn't need changes
- Agent skills read project context before generation — add config.json reading to that flow
- Validation pipeline (critics) — add package check as post-generation validation step

</code_context>

<specifics>
## Specific Ideas

No specific requirements — open to standard approaches

</specifics>

<deferred>
## Deferred Ideas

None — discussion stayed within phase scope

</deferred>

---

*Phase: 22-package-gated-generation*
*Context gathered: 2026-04-14*
