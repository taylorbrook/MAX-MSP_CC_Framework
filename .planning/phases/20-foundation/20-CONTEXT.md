# Phase 20: Foundation - Context

**Gathered:** 2026-04-05
**Status:** Ready for planning

<domain>
## Phase Boundary

All M4L data structures, database entries, detection logic, and CLAUDE.md rules needed before any M4L-specific code generation or validation can begin. This is the data foundation for v3.0.

</domain>

<decisions>
## Implementation Decisions

### Detection Heuristics
- **D-01:** `detect_device_type()` returns definitive type for unambiguous patterns (midi_effect = midiin+midiout with no audio I/O; audio_effect = plugin~+plugout~ with no MIDI). For ambiguous patterns (e.g., plugin~ + midiin), returns uncertain and the system asks the user during project kickoff.
- **D-02:** Detection works on both existing patches (/max-onboard flow) and during new project creation (/max-new).
- **D-03:** Confidence scoring uses numeric 0.0-1.0 (not enum). Allows downstream code to set thresholds.

### AMXD Constants Scope
- **D-04:** Researcher investigates .amxd binary header format (32-byte header, community-documented). No user-provided reference material.
- **D-05:** Include ALL known parameter_type, parameter_unitstyle, and parameter_modmode values in IntEnum classes -- comprehensive reference, not a common subset.

### CLAUDE.md M4L Rules
- **D-06:** M4L rules section covers core device rules AND Live API patterns: gain~/plugout~ prohibition, `---` naming convention, parameter_enable requirement, plugin~/plugout~ boilerplate, device type differences, live.path/live.object usage, live.banks, parameter metadata conventions.
- **D-07:** Include 169px height constraint and presentation mode conventions (openinpresentation) in Phase 20 rules -- agents need this knowledge from the start, even before the layout engine exists in Phase 24.

### DB Entry Sourcing
- **D-08:** live.adsrui and live.adsr~ sourced via research (docs, community). Added with verified=false, corrected during testing (Phase 25) if wrong.
- **D-09:** plugin~/plugout~ maxclass question (DB says "plugin~"/"plugout~", ground truth may be "newobj") resolved via research. If inconclusive, noted for manual verification.

</decisions>

<canonical_refs>
## Canonical References

**Downstream agents MUST read these before planning or implementing.**

### Project & Requirements
- `.planning/PROJECT.md` -- Project vision, constraints, key decisions
- `.planning/REQUIREMENTS.md` -- v3.0 requirements with traceability (DB-01 through DB-04, VALID-04, VALID-05, ROUTING-02 mapped to Phase 20)
- `.planning/ROADMAP.md` -- Phase 20 success criteria and dependency chain

### Object Database
- `.claude/max-objects/m4l/objects.json` -- Current M4L objects (33 objects, missing live.adsrui and live.adsr~)
- `.claude/max-objects/msp/objects.json` -- plugin~/plugout~ definitions (lines ~14362-14487)
- `.claude/max-objects/relationships.json` -- Companion pairs (no M4L entries yet)
- `.claude/max-objects/overrides.json` -- Expert corrections applied on top of base objects

### Validation Code
- `src/maxpat/validation.py` line 41 -- `_TERMINAL_NAMES` needs plugout~
- `src/maxpat/critics/dsp_critic.py` line 33 -- `_TERMINAL_NAMES` needs plugout~

### Research (Phase 20)
- `.planning/research/SUMMARY.md` -- v3.0 research summary (M4L architecture, .amxd format, parameter system)

No external specs -- requirements fully captured in decisions above. Researcher should investigate .amxd binary header format and live.adsrui/live.adsr~ I/O from community documentation.

</canonical_refs>

<code_context>
## Existing Code Insights

### Reusable Assets
- `ObjectDatabase` class (`src/maxpat/db_lookup.py`) -- Handles all object lookups, alias resolution, override merging. New M4L entries slot into existing m4l/objects.json.
- `relationships.json` -- Existing pair/group structure supports M4L companion entries directly.
- `_TERMINAL_NAMES` frozensets -- Simple set additions for plugout~.

### Established Patterns
- Object DB is JSON-per-domain at `.claude/max-objects/{domain}/objects.json` -- new objects follow existing schema exactly.
- Constants/enums in Python use standard patterns (see existing code in `src/maxpat/`).
- CLAUDE.md domain sections follow consistent structure (### Domain Name, bullet rules, code examples).

### Integration Points
- `m4l_constants.py` will be imported by scaffold (Phase 21), critic (Phase 22), and export (Phase 22) code.
- `detect_device_type()` used by /max-onboard analysis and /max-new project creation.
- CLAUDE.md rules read by all agents during generation.

</code_context>

<specifics>
## Specific Ideas

- Device type detection should be part of the standard new-patch discussion flow -- "if uncertain, ask" rather than guessing
- plugin~/plugout~ maxclass needs ground-truth verification via research (STATE.md blocker)

</specifics>

<deferred>
## Deferred Ideas

None -- discussion stayed within phase scope

</deferred>

---

*Phase: 20-foundation*
*Context gathered: 2026-04-05*
