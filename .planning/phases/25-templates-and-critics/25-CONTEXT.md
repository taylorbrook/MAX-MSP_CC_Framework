# Phase 25: Templates + Critics - Context

**Gathered:** 2026-04-15
**Status:** Ready for planning

<domain>
## Phase Boundary

Provide starter templates and package-aware validation for common package workflows. Templates guide agents through idiomatic package usage patterns. Critics catch package-specific semantic errors (BEAP signal conventions, Bach llll type mismatches) that the generic validation pipeline misses.

</domain>

<decisions>
## Implementation Decisions

### Template Scope
- **D-01:** High-value packages only: FluCoMa (audio analysis chains), BEAP (modular synth chains from Phase 23 D-03/D-04), Bach (algorithmic composition workflows). These have the most complex workflows where agents need structured guidance.
- **D-02:** Templates are structured signal chain descriptions in agent SKILL.md files — NOT pre-built .maxpat files. Agents use them as generation blueprints. Example: "FluCoMa analysis chain: audio source → fluid.mfcc~ → fluid.kdtree (train) → fluid.kdtree (query) → result mapping".
- **D-03:** Each template includes: which objects to use, connection order, expected I/O types, common parameter ranges, and gotchas. Enough detail that an agent can generate a working patch from the template.

### Critic Targets
- **D-04:** Two new critics: BEAP signal convention checker and Bach llll type checker (per PKG-26).
- **D-05:** BEAP critic checks: CV range (0-5V, not ±1), audio range (±1 after VCA), always terminate with bp.Stereo/bp.Mono, gain staging through bp.VCA. Severity: warnings (convention violations, not hard errors).
- **D-06:** Bach critic checks: llll/list type mismatches (connecting regular MAX list outlets to bach object inlets expecting llll), missing bach.list2llll/bach.llll2list conversion objects, connecting non-bach outlets to bach inlets. Severity: blockers (llll mismatch always produces silent failures).
- **D-07:** Community package critic: warn if patch uses community package objects from unextracted packages. Reuses the validation layer 2d from Phase 24 — critic wraps it for the review_patch() pipeline.

### Template Integration
- **D-08:** Templates live in agent SKILL.md files (max-patch-agent, max-dsp-agent) under a "Package Workflow Templates" section. Referenced from PACKAGES.md community/bundled sections.
- **D-09:** Template integration with `/max-new`: when a project selects packages, the lifecycle skill suggests relevant templates. No automated scaffolding — just guidance text.

### Critic Wiring
- **D-10:** New `src/maxpat/critics/package_critic.py` module with `review_packages()` function. Follows existing pattern (review_dsp, review_structure, etc.).
- **D-11:** Auto-invoked by `review_patch()` in `__init__.py` when patch uses package objects (detected by checking object names against ObjectDatabase package field).
- **D-12:** BEAP checks only run when BEAP objects detected. Bach checks only run when Bach objects detected. No overhead for non-package patches.

### Claude's Discretion
- Exact template chain compositions beyond the canonical examples
- Wording and formatting of template sections in SKILL.md files
- Which specific BEAP convention violations to check (beyond the core four in D-05)
- How to detect llll/list type mismatches in Bach critic (object name prefix matching vs. DB field)
- Test fixture design for package critics

</decisions>

<canonical_refs>
## Canonical References

**Downstream agents MUST read these before planning or implementing.**

### Milestone Proposal
- `.planning/milestones/v4.0-package-integration-PROPOSAL.md` — Phase 25 scope, requirements PKG-23 through PKG-26

### Requirements
- `.planning/REQUIREMENTS.md` §Templates/Critics (Phase 25) — PKG-23 through PKG-26

### Critic System
- `src/maxpat/critics/__init__.py` — `review_patch()` dispatcher, existing critic imports
- `src/maxpat/critics/base.py` — `CriticResult` class (severity, finding, suggestion)
- `src/maxpat/critics/dsp_critic.py` — Reference pattern for how to write a domain critic
- `src/maxpat/critics/m4l_critic.py` — M4L-specific critic, good pattern for package-specific checks

### Object Database
- `.claude/max-objects/packages/BEAP/objects.json` — 185 BEAP modules with signal_convention, category fields
- `.claude/max-objects/packages/Bach/objects.json` — 80 Bach stub entries with domain info
- `.claude/max-objects/PACKAGES.md` — Shared package reference, community package section from Phase 24
- `src/maxpat/db_lookup.py` — ObjectDatabase class, `get_package()`, `get_package_info()`

### Agent Skills
- `.claude/skills/max-patch-agent/SKILL.md` — Needs package workflow templates section
- `.claude/skills/max-dsp-agent/SKILL.md` — Needs FluCoMa/BEAP DSP templates
- `.claude/skills/max-lifecycle/SKILL.md` — Needs template suggestion on package selection

### Validation Pipeline
- `src/maxpat/validation.py` — Layer 2d `_validate_community_extracted()` from Phase 24 (reuse pattern for critic)

### Prior Phase Context
- `.planning/phases/23-agent-package-intelligence/23-CONTEXT.md` — BEAP modular patterns D-03/D-04/D-05, Vizzie patterns
- `.planning/phases/24-community-package-support/24-CONTEXT.md` — Community package blocking, extraction gating

</canonical_refs>

<code_context>
## Existing Code Insights

### Reusable Assets
- `CriticResult` class with severity/finding/suggestion pattern — all new critics use this
- `review_patch()` dispatcher — add new critic import and call here
- `_has_rnbo_boxes()` pattern — conditional invocation based on patch content, reuse for package detection
- `ObjectDatabase.get_package()` — returns package name for any object, use to detect package usage
- Phase 23 BEAP signal_convention field on DB entries — data source for BEAP critic checks
- Phase 24 validation `_validate_community_extracted()` — pattern for package-aware checking

### Established Patterns
- Each critic is a standalone module: `review_{domain}(patch_dict, ...) -> list[CriticResult]`
- Critics imported in `__init__.py` and called in `review_patch()`
- Conditional invocation based on patch content (RNBO only when rnbo~ detected)
- Severity levels: "blocker" (must fix), "warning" (should fix), "note" (informational)

### Integration Points
- `review_patch()` in `critics/__init__.py` — add `review_packages()` call
- Agent SKILL.md files — add "Package Workflow Templates" sections
- PACKAGES.md — reference templates from package entries
- `/max-new` lifecycle — suggest templates when packages selected

</code_context>

<specifics>
## Specific Ideas

- BEAP templates should reference the functional roles from Phase 23 D-05: Sources → Processors → Modulators → Output → Utility
- Bach llll type checking is critical — connecting a regular MAX list to a bach.score inlet silently produces garbage. This is the #1 pitfall for Bach usage.
- FluCoMa has two distinct workflow patterns: real-time (signal objects with ~) and offline (buf* objects that output bang on completion). Templates should cover both.
- CNMAT objects have bare names (no prefix) — critic can't detect them by prefix alone, must use DB lookup

</specifics>

<deferred>
## Deferred Ideas

None — discussion stayed within phase scope.

</deferred>

---

*Phase: 25-templates-and-critics*
*Context gathered: 2026-04-15*
