# Phase 21: Scaffold and Routing - Context

**Gathered:** 2026-04-06
**Status:** Ready for planning

<domain>
## Phase Boundary

Framework scaffolds complete M4L devices per type (audio_effect, instrument, midi_effect) and routes agent tasks with M4L-specific context. This is the starting point for all M4L device creation -- users get a valid device skeleton from `create_m4l_project()` and agents receive M4L-aware instructions when generating device content.

</domain>

<decisions>
## Implementation Decisions

### Scaffold Scope
- **D-01:** Minimal boilerplate only -- scaffold generates required objects per device type (plugin~/plugout~/midiin/midiout/live.thisdevice) plus openinpresentation=1 and devicewidth. No example controls, signal chains, or comments. Agents add everything else during /max-build.
- **D-02:** `create_m4l_project(device_type, name, base_dir)` is a separate function in project.py. Does not extend or modify existing `create_project()`.
- **D-03:** Instrument and midi_effect scaffolds include midiin -> midiout connected passthrough. MIDI flows through even if the device doesn't process it -- prevents silent MIDI drops.

### --- Prefix Integration
- **D-04:** `---` prefix applied at scaffold-time only. `create_m4l_project()` prefixes named objects in the scaffold. During /max-build and /max-iterate, agents follow CLAUDE.md rules to add `---` manually. No Patcher API changes needed.

### Presentation Defaults
- **D-05:** Default devicewidth is 300px (Ableton's stock device default, fits 4-5 dials in a row).
- **D-06:** Scaffold sets presentation flags only: openinpresentation=1 on patcher, presentation=1 and presentation_rect on live.thisdevice. No presentation_rect on boilerplate objects (plugin~, plugout~, midiin, midiout). Phase 24 Layout engine handles all presentation positioning.

### Router and Agent Updates
- **D-07:** Router dispatches M4L tasks to existing agents (dsp, patch, ui) with M4L-specific context injected. No dedicated M4L agent. Matches existing RNBO dispatch pattern.
- **D-08:** Router detects M4L keywords ("Max for Live", "M4L", "Ableton device", "audio effect device", "instrument device", "MIDI effect") and injects device type context into the dispatch.
- **D-09:** Four agents get M4L-specific SKILL.md sections: max-patch-agent (MIDI routing, live.path/live.object), max-dsp-agent (plugin~/plugout~ I/O, gain~/plugout~ prohibition), max-ui-agent (live.* controls, parameter_enable, presentation mode, 169px), max-router (M4L keyword detection, dispatch-rules.md M4L section).
- **D-10:** max-critic gets a brief M4L awareness note -- M4L devices will have a dedicated critic in Phase 22. Prevents the general critic from flagging M4L-specific patterns as errors.

### Claude's Discretion
- Object positioning within scaffold patches (patching_rect coordinates for boilerplate objects)
- Exact M4L keyword list for router dispatch (beyond the core ones specified in D-08)
- Internal structure of M4L context injection (how device type info is passed to agents)

</decisions>

<canonical_refs>
## Canonical References

**Downstream agents MUST read these before planning or implementing.**

### Scaffold Implementation
- `src/maxpat/project.py` -- Existing create_project() function, auto_commit_patch(), project lifecycle patterns
- `src/maxpat/m4l_constants.py` -- ParamType, UnitStyle, ModMode, ParamVisibility enums, AMXD binary format constants
- `src/maxpat/m4l_detection.py` -- detect_device_type() function (Phase 20 output)

### Reference Device
- `patches/kicksynth/generated/kicksynth-m4l.maxpat` -- Ground-truth M4L device structure (plugin~/plugout~ wiring, parameter_enable blocks, presentation rects, saved_attribute_attributes)

### Router and Agent Skills
- `.claude/skills/max-router/SKILL.md` -- Current router dispatch rules and context budget strategy
- `.claude/skills/max-router/references/dispatch-rules.md` -- Full keyword-to-agent mapping (needs M4L section)
- `.claude/skills/max-patch-agent/SKILL.md` -- Needs M4L MIDI routing section
- `.claude/skills/max-dsp-agent/SKILL.md` -- Needs M4L signal chain section
- `.claude/skills/max-ui-agent/SKILL.md` -- Needs M4L presentation/controls section
- `.claude/skills/max-critic/SKILL.md` -- Needs M4L awareness note

### Requirements
- `.planning/REQUIREMENTS.md` -- SCAFFOLD-01 through SCAFFOLD-06, ROUTING-01, ROUTING-03

</canonical_refs>

<code_context>
## Existing Code Insights

### Reusable Assets
- `create_project()` in project.py -- Directory structure creation pattern (patches/{name}/, context.md, status.md, generated/, versions.json). `create_m4l_project()` can reuse the directory scaffolding and version init.
- `Patcher` class -- add_box(), add_connection(), to_dict(), save via JSON. Used directly to build scaffold patches.
- `ObjectDatabase` -- lookup() for verifying M4L object I/O counts at scaffold time.
- `set_canvas_background()` in aesthetics.py -- Already applied in create_project() to new patches.
- `auto_commit_patch()` -- Git commit helper for patch saves.

### Established Patterns
- New patches created via `Patcher()` + `add_box()` + `to_dict()` + JSON write (see create_project() lines 80-88)
- Plugin~/plugout~ use maxclass="newobj" via overrides (Phase 20)
- Router dispatch rules in markdown reference files, not hardcoded
- SKILL.md files use frontmatter + markdown sections with clear domain boundaries

### Integration Points
- `/max-new` command reads create_project() -- needs to also call create_m4l_project() when device type is detected
- Router reads dispatch-rules.md at dispatch time -- M4L section added there
- All agents read CLAUDE.md M4L rules (already in place from Phase 20)
- detect_device_type() from Phase 20 feeds into both /max-new kickoff and /max-onboard analysis

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

*Phase: 21-scaffold-and-routing*
*Context gathered: 2026-04-06*
