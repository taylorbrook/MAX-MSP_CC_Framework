# Phase 23: Polish - Context

**Gathered:** 2026-04-06
**Status:** Ready for planning

<domain>
## Phase Boundary

Parameter metadata intelligence and UX polish -- auto-derived naming, Push controller banks, and info text make M4L devices feel professionally authored. Covers POLISH-01 (parameter naming), POLISH-02 (Push banks), POLISH-03 (info text/annotations).

</domain>

<decisions>
## Implementation Decisions

### Parameter Naming Derivation
- **D-01:** Dual approach -- agents set names during /max-build via SKILL.md rules, post-process function fills gaps and derives missing names. Post-process does NOT normalize or override agent-set names.
- **D-02:** Longname fallback derives from varname or box text. If varname is "filter_cutoff", longname becomes "Filter Cutoff" (underscore-to-space, title case).
- **D-03:** Shortname uses abbreviation table (Frequency->Freq, Resonance->Reso, Envelope->Env, Modulation->Mod, etc.) then truncates to 8 chars max.
- **D-04:** Varname auto-derived from longname as snake_case lowercase: "Filter Cutoff" -> "filter_cutoff".

### Push Bank Organization
- **D-05:** Parameters grouped into banks of 8 by semantic function, auto-detected from parameter names/varnames. E.g., pitch params in bank 1, amp params in bank 2, filter in bank 3.
- **D-06:** Bank names auto-derived from parameter group content. Bank containing Cutoff/Resonance/Drive -> "Filter".
- **D-07:** Partial banks padded with empty slots -- standard Push behavior, no merging of small groups.

### Info Text / Annotations
- **D-08:** Contextual info text that describes what the parameter does and how it affects the sound. E.g., "Controls the lowpass filter cutoff. Higher values brighten the sound."
- **D-09:** Info text includes unit style and range from parameter_unitstyle. E.g., "Range: 20-20000 Hz" or "Range: 0-127 (MIDI)".
- **D-10:** Agents generate contextual info text during build (they understand DSP context). Post-process fills generic fallbacks for anything missed.

### Pipeline Integration
- **D-11:** New standalone module `src/maxpat/m4l_polish.py` with `polish_m4l_device(patch_dict)` function.
- **D-12:** Explicit call -- agents call polish after build, before export. Not auto-triggered on save or wired into hooks.
- **D-13:** M4L critic (m4l_critic.py) expanded to flag missing info text and absent live.banks as warnings -- gentle nudge to run polish.

### Claude's Discretion
- Abbreviation table contents (specific word->abbreviation mappings beyond the examples)
- Semantic clustering algorithm for Push bank grouping (keyword matching, varname prefix analysis, etc.)
- Generic fallback info text templates for post-process gap-filling
- Function signatures and internal structure of m4l_polish.py

</decisions>

<canonical_refs>
## Canonical References

**Downstream agents MUST read these before planning or implementing.**

### M4L Constants and Reference
- `src/maxpat/m4l_constants.py` -- ParamType, UnitStyle, ModMode, ParamVisibility enums. UnitStyle values needed for info text range formatting.
- `patches/kicksynth/generated/kicksynth.maxpat` -- Ground-truth M4L device with varname patterns on controls (pitch_start, amp_decay, etc.)

### Critic (needs polish warnings added)
- `src/maxpat/critics/m4l_critic.py` -- Existing parameter_longname validation. Needs new checks for missing info text and absent live.banks (D-13).
- `src/maxpat/critics/base.py` -- CriticResult class definition, severity levels.

### Object Database
- `.claude/max-objects/m4l/objects.json` -- M4L object definitions including live.banks I/O and attributes.

### Requirements
- `.planning/REQUIREMENTS.md` -- POLISH-01, POLISH-02, POLISH-03

</canonical_refs>

<code_context>
## Existing Code Insights

### Reusable Assets
- `m4l_constants.py` UnitStyle enum -- Maps to display units for info text (Hz, dB, %, ms, etc.)
- `m4l_critic.py` `_collect_parameter_longnames()` -- Already recursively collects parameter data from all boxes including subpatchers. Can be extended or reused for polish parameter discovery.
- `_LIVE_NO_PARAM` frozenset in m4l_critic.py -- List of live.* objects that don't take parameters (live.thisdevice, live.banks, live.path, etc.). Reusable for filtering.
- `sizing.py` live.banks entry -- Default size (315x45) already defined.
- `maxclass_map.py` -- live.banks listed as M4L maxclass.

### Established Patterns
- Standalone module pattern: `m4l_export.py` is a standalone function called explicitly by agents. `m4l_polish.py` follows same pattern.
- Critic report pattern: CriticResult with severity/finding/suggestion. New polish warnings follow this.
- `auto_commit_patch()` in project.py for git commits after file changes.

### Integration Points
- `m4l_critic.py` -- Add warning checks for missing info text and absent live.banks (D-13).
- Agent SKILL.md files (max-ui-agent, max-dsp-agent) -- Need M4L parameter naming and info text generation instructions.
- `m4l_polish.py` (new) -- Called by agents between build and export steps.

</code_context>

<specifics>
## Specific Ideas

No specific requirements -- open to standard approaches

</specifics>

<deferred>
## Deferred Ideas

None -- discussion stayed within phase scope

</deferred>

---

*Phase: 23-polish*
*Context gathered: 2026-04-06*
