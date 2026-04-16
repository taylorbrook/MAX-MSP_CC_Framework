# Phase 23: Agent Package Intelligence - Context

**Gathered:** 2026-04-14
**Status:** Ready for planning

<domain>
## Phase Boundary

Give agents deep knowledge of package-specific patterns, conventions, and workflows so they generate idiomatic package patches — not just valid ones. Covers all bundled packages with full depth for BEAP and Vizzie, lighter coverage for others.

</domain>

<decisions>
## Implementation Decisions

### Knowledge Distribution
- **D-01:** Hybrid approach — shared reference doc at `.claude/max-objects/PACKAGES.md` for common facts (naming, signal conventions, bpatcher dimensions, categories), plus per-agent domain-specific sections in each SKILL.md
- **D-02:** Scope: bundled packages only (BEAP, Vizzie, jit.mo, Jitter Geometry, Jitter Tools, ableton-dsp, Mira, maxforlive-elements). Community packages get guidance in Phase 24/25 when they have proper DB entries.

### BEAP Modular Patterns
- **D-03:** Both templates + rules. Short rules section (CV is 0-5V, audio is ±1, always terminate with bp.Stereo/bp.Mono, use bp.VCA for gain control, 1V/oct for pitch tracking) plus 3-5 canonical signal chain templates (subtractive synth, FM synth, sequenced patch, audio effect, analysis)
- **D-04:** Each template lists which bp.* modules to use and connection order (e.g., subtractive: Keyboard→Oscillator(CV1), Oscillator→Filter→VCA→Stereo, ADSR→VCA(CV))
- **D-05:** BEAP objects fall into functional roles: Sources (Oscillator, Keyboard, Noise), Processors (VCA, Filter, Effects), Modulators (LFO, ADSR, Envelope Follower), Output (Stereo, Mono), Utility (Mixer, Scope, Sequencer). Document these roles in PACKAGES.md.

### Vizzie Patterns
- **D-06:** Same depth as BEAP — templates for common video chains (effects chain, VJ setup, camera processing) plus Jitter matrix conventions. Vizzie has 110 objects across similar functional categories.

### Relationship Entries
- **D-07:** Essential pairs only — 15-25 key pairs covering BEAP signal chain connections (bp.Oscillator+bp.VCA, bp.ADSR+bp.VCA, bp.Keyboard+bp.Oscillator), Vizzie equivalents, and cross-package pairs
- **D-08:** Add to existing relationships.json alongside the 19 core pairs. Tag package pairs with a `"package"` field for filtering.

### Layout Overrides
- **D-09:** DB-driven sizing — when placing a bpatcher, look up its `bpatcher_dimensions` from the DB and use actual size instead of the 200x100 default. BEAP ranges from 52x24 to 895x484. Flow dimensions through `calculate_box_size()` in sizing.py.
- **D-10:** Adapt spacing too — when a row contains large bpatchers, increase vertical spacing proportionally. Use `bpatcher_dimensions` to compute per-row spacing. Prevents overlap with large modules.

### Claude's Discretion
- Exact wording and formatting of PACKAGES.md sections
- Which specific BEAP/Vizzie modules appear in each template chain (beyond the canonical examples)
- How per-agent SKILL.md sections reference the shared PACKAGES.md
- Specific spacing formula for bpatcher rows (proportional vs. fixed padding tiers)
- How `calculate_box_size()` accesses DB dimensions (parameter, lookup, or cached)

</decisions>

<canonical_refs>
## Canonical References

**Downstream agents MUST read these before planning or implementing.**

### Milestone Proposal
- `.planning/milestones/v4.0-package-integration-PROPOSAL.md` — Phase 23 scope, target packages table, full requirements

### Requirements
- `.planning/REQUIREMENTS.md` §Agent Intelligence (Phase 23) — PKG-14 through PKG-18

### Object Database
- `.claude/max-objects/packages/BEAP/objects.json` — 185 BEAP modules with `bpatcher_dimensions`, `signal_convention`, `category` fields
- `.claude/max-objects/packages/Vizzie/objects.json` — 110 Vizzie modules with `bpatcher_dimensions`, `category` fields
- `.claude/max-objects/relationships.json` — 19 core pairs, needs package pair additions
- `.claude/max-objects/package_info.json` — Package registry with tier, prefix, description per package

### Agent Skills (need package guidance sections)
- `.claude/skills/max-patch-agent/SKILL.md` — Patch agent, needs BEAP modular patterns, Vizzie chains
- `.claude/skills/max-dsp-agent/SKILL.md` — DSP agent, needs CV signal conventions, BEAP audio patterns
- `.claude/skills/max-ui-agent/SKILL.md` — UI agent, needs bpatcher layout rules, presentation mode for packages
- `.claude/skills/max-rnbo-agent/SKILL.md` — RNBO agent, note BEAP/Vizzie are NOT RNBO-compatible
- `.claude/skills/max-js-agent/SKILL.md` — JS agent, may need package-aware scripting patterns

### Layout Engine
- `src/maxpat/sizing.py` — `calculate_box_size()` returns 200x100 for all bpatchers, needs DB-driven override
- `src/maxpat/layout.py` — Layout engine, needs adaptive spacing for bpatcher rows
- `src/maxpat/defaults.py` — Spacing constants, may need bpatcher-specific values

### Prior Phase Context
- `.planning/phases/21-bundled-package-extraction/21-CONTEXT.md` — Extraction decisions, DB entry format, signal conventions
- `.planning/phases/22-package-gated-generation/22-CONTEXT.md` — Gating decisions, config.json format, allowed_packages flow

</canonical_refs>

<code_context>
## Existing Code Insights

### Reusable Assets
- `bpatcher_dimensions` field on all BEAP/Vizzie DB entries — actual width/height from source .maxpat files
- `signal_convention` field on BEAP entries — all use "0-5V CV"
- `category` field on BEAP/Vizzie entries — functional grouping (Oscillator, Filter, LFO, etc.)
- `ObjectDatabase.get_package_objects(pkg)` — returns all objects for a package
- `ObjectDatabase.list_packages()` — returns all 20 package names
- SKILL.md files already have basic `load_project_config()` → `allowed_packages` gating (from Phase 22)

### Established Patterns
- Agent SKILL.md files have structured sections: capabilities, context loading, generation rules
- relationships.json uses `{"objects": [...], "relationship": "type", "note": "..."}` format
- sizing.py `UI_SIZES` dict maps maxclass to (width, height) tuples
- Layout engine uses `calculate_box_size()` return values for placement math

### Integration Points
- `calculate_box_size("", "bpatcher")` → currently returns (200, 100) → needs to accept object name and query DB
- Layout engine row spacing → currently fixed → needs per-row adaptive spacing based on tallest element
- SKILL.md files → add package knowledge sections that reference shared PACKAGES.md
- relationships.json → add `"package"` field to new entries for filtering

</code_context>

<specifics>
## Specific Ideas

- BEAP functional roles (Sources, Processors, Modulators, Output, Utility) map directly to modular synth paradigms — use this categorization in PACKAGES.md
- BEAP inlet descriptions already encode patching conventions ("1v/oct pitch modulation", "0 to +5v scales signal") — reference these in templates
- Vizzie uses Jitter matrices between modules — different paradigm from BEAP's signal/CV split
- bp.Keyboard has 4 outputs (pitch CV, gate, velocity, aftertouch) — a key "source" module in BEAP chains

</specifics>

<deferred>
## Deferred Ideas

None — discussion stayed within phase scope

</deferred>

---

*Phase: 23-agent-package-intelligence*
*Context gathered: 2026-04-14*
