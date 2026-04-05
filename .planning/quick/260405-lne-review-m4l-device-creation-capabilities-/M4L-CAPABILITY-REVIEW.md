# M4L Device Creation Capability Review

## Executive Summary

The framework has solid foundational M4L support: 35 objects in the M4L database, all live.* objects correctly mapped in UI_MAXCLASSES and UI_SIZES, domain classification works, and a real M4L device (kicksynth-m4l) has been successfully generated with presentation mode, parameter_enable, and plugin~/plugout~ wiring. However, there is no M4L-specific automation, validation, or agent guidance -- M4L device creation relies entirely on the developer manually knowing what an M4L device needs. The biggest gaps are: no device scaffold/template, no M4L-specific critic checks, no dedicated routing for M4L tasks, and no presentation mode layout intelligence beyond a basic grid fallback.

## Current State

### 1. Object Database

**M4L domain file** (`.claude/max-objects/m4l/objects.json`): 35 objects.

| Category | Count | Objects |
|----------|-------|---------|
| Live UI Objects | 18 | live.dial, live.slider, live.numbox, live.toggle, live.button, live.text, live.menu, live.tab, live.arrows, live.banks, live.colors, live.comment, live.drop, live.grid, live.line, live.step, live.meter~, live.gain~ |
| Live API Objects | 6 | live.thisdevice, live.path, live.object, live.observer, live.map, live.routing |
| Live MSP Objects | 3 | live.remote~, live.param~, live.modulate~ |
| Live MIDI Objects | 2 | live.miditool.in, live.miditool.out |
| Live Control Surface | 1 | live.banks (also in UI) |
| M4L API Utility | 2 | M4L.api.ObserveTransport, M4L.api.ToggleTransport |
| Host Object | 1 | amxd~ |
| Meta/Unlisted | 2 | Parameter Properties, paraminspector |

**Missing objects:**
- `live.adsrui` -- envelope editor UI widget (referenced in overrides.json `_domain_other` seealso list but not in m4l DB)
- `live.adsr~` -- ADSR envelope generator (referenced in overrides.json `_domain_other` seealso list but not in m4l DB)
- `live.scope~` -- exists in packages/objects.json and overrides.json, but NOT in m4l/objects.json (categorization gap; it IS in UI_SIZES and UI_MAXCLASSES correctly)

**plugin~/plugout~ (in msp/objects.json):**
- Both present with correct I/O (2 inlets, 2 outlets for stereo)
- Both have `seealso` linking to each other
- Descriptions correctly reference Max for Live
- maxclass is their own name (`plugin~`, `plugout~`) -- correct for UI objects

**Gaps in object metadata:**
- No M4L objects have `parameter_enable` metadata or parameter type info (enum, float, int ranges)
- No automation range metadata on live.dial, live.slider, live.numbox
- `relationships.json` has ZERO M4L entries -- no plugin~/plugout~ pairing, no live.thisdevice/live.path pairing, no live.dial/live.param~ pairing
- Most M4L objects have `verified: false`

### 2. Code Support Matrix

| Module | File | M4L Support | Gaps |
|--------|------|-------------|------|
| maxclass_map | `maxclass_map.py` | All 29 live.* objects in UI_MAXCLASSES | plugin~/plugout~ NOT in UI_MAXCLASSES (they're in msp/objects.json as UI objects but not mapped here -- however they ARE correctly identified as maxclass=plugin~/plugout~ in the MSP DB, so resolve_maxclass would need to check MSP DB too or add them explicitly) |
| sizing | `sizing.py` | All 11 visual widgets have fixed sizes; 12 non-visual have None; live.scope~ sized at (131, 131) | plugin~/plugout~ have no entry in UI_SIZES (they render as boxes but have no fixed size guidance) |
| layout | `layout.py` | live.dial, live.slider, live.numbox, live.toggle, live.button in `_UI_CONTROL_NAMES` for above-target positioning | No plugin~/plugout~ special positioning; no M4L presentation mode layout intelligence; presentation fallback is a crude 4-per-row grid |
| analysis | `analysis.py` | Domain classification via `live.` prefix heuristic and DB lookup; live.dial in `_analyze_parameters` ui_controls set | No M4L device type detection (audio_effect vs instrument vs midi_effect); no plugin~/plugout~ presence detection; no parameter inspector analysis; SECTION_SIGNATURES has no M4L entries |
| dsp_critic | `dsp_critic.py` | live.dial, live.slider, live.numbox in `_MIDI_RANGE_SOURCES` for gain safety | No M4L-specific checks: no gain~ before plugout~ detection (per memory feedback_m4l_no_gain.md), no device completeness validation, no parameter_enable requirement checking |
| critics/__init__ | `critics/__init__.py` | No M4L critic | No M4L-specific critic module exists; no auto-invocation for M4L devices (unlike RNBO critic which auto-invokes on rnbo~ detection) |
| project | `project.py` | create_project creates generic MAX project | No M4L device type option; no .amxd metadata; no device scaffold template |
| hooks | `hooks.py` | finalize_patch works generically | No M4L-specific finalization (e.g., ensuring plugin~/plugout~ present, parameter_enable set) |
| patcher | `patcher.py` | No M4L-specific methods | No add_plugin_io(), no set_device_type(), no M4L template creation |
| validation | `validation.py` | No M4L-specific validation | No plugin~/plugout~ presence checks, no parameter_enable validation |

### 3. Agent/Skill Coverage

**Router dispatch (`dispatch-rules.md`):**
- NO M4L-specific dispatch rules or keywords
- "Max for Live", "M4L", "Ableton", "Live device", "audio effect", "instrument", "MIDI effect", "plugin~", "plugout~", "live.dial", "live.slider" -- NONE of these are dispatch keywords
- live.dial and live.slider appear only as secondary UI keywords
- An M4L task would currently route to DSP + UI agents without any M4L-specific guidance

**Agent SKILL.md files:**
- `max-dsp-agent`: No M4L-specific instructions. Has gen~ patterns, signal chain construction, but no device structure guidance.
- `max-ui-agent`: Lists live.* objects in capabilities section. Knows about presentation mode. But no M4L-specific layout patterns, parameter inspector setup, or device UI conventions.
- `max-lifecycle`: No M4L device type in create_project. No .amxd export.
- `max-critic`: No M4L critic module listed. No M4L validation.
- `max-router`: No M4L dispatch pathway.
- `max-patch-agent`: Not checked for M4L, but would need plugin~/plugout~ wiring patterns.

**Shared capabilities (`shared-capabilities.md`):**
- ZERO mentions of M4L, live.*, plugin~, plugout~, or Max for Live

**CLAUDE.md:**
- M4L mentioned only in object database listing ("m4l/objects.json -- Max for Live objects (33 objects)")
- No M4L-specific rules, patterns, or guidance
- The memory note `feedback_m4l_no_gain.md` captures "no gain~ before plugout~" rule, but it's only in memory, not in CLAUDE.md or any critic

### 4. Test Coverage

| Test File | M4L Tests | What They Cover |
|-----------|-----------|-----------------|
| `test_sizing.py` | `TestLiveObjectSizes` class (4 tests) | All live.* in UI_MAXCLASSES, visual widgets have fixed sizes, non-visual have None |
| `test_analysis.py` | `test_known_m4l_object`, `test_unknown_live_prefix_heuristic`, `test_live_dial` | Domain classification for live.dial returns "M4L"; unknown live.custom falls back to M4L via prefix heuristic; live.dial in parameter analysis |
| `test_patcher.py` | `TestLiveScopeOverride` (2 tests) | live.scope~ has signal inlets, is connectable |

**Not tested:**
- M4L device type detection
- plugin~/plugout~ handling
- M4L presentation mode layout
- M4L parameter_enable validation
- M4L-specific critic checks
- M4L device scaffold creation
- M4L end-to-end device generation

### 5. Existing M4L Patch Analysis (kicksynth-m4l.maxpat)

Ground truth from the successfully generated kicksynth-m4l device:

| Aspect | Value | Framework Support |
|--------|-------|-------------------|
| Total boxes | 67 | Generated via Patcher API |
| M4L UI objects | 26 (24x live.dial, live.tab, live.scope~, live.meter~) | All correctly sized and typed |
| plugin~/plugout~ | plugout~ present (newobj maxclass) | Manually wired, no helper |
| Presentation mode | Yes -- all UI objects have presentation=1 | Manually configured, no template |
| parameter_enable | 24 boxes | Manually set, no validation |
| live.thisdevice | Not present | Not auto-added |
| Device type metadata | None | No framework support |
| .amxd export | Exists alongside .maxpat | Manually created outside framework |

**Patterns used that should be codified:**
1. All live.dial objects have `parameter_enable: 1` for Ableton automation
2. live.tab for section/page switching (tabbed UI pattern)
3. plugout~ at signal chain terminus (not dac~)
4. No gain~ before plugout~ (Ableton channel strip handles volume)
5. Presentation mode layout with organized control groups
6. All UI controls labeled with parameter names for Ableton's UI

## Gap Analysis

### Critical Gaps (blocks M4L device creation workflow)

**G1. No M4L device template/scaffold**
- **What:** No way to create a new project as an M4L device with the correct boilerplate (plugin~/plugout~, live.thisdevice, device metadata)
- **Why it matters:** Every M4L device starts with the same structure. Without a template, the developer must manually add plugin~/plugout~, set device type metadata, configure presentation mode -- prone to forgetting steps
- **Affected workflow:** `/max-new` (project creation), `/max-build` (initial patch generation)

**G2. No M4L dispatch pathway in router**
- **What:** Router has no keywords or rules for M4L tasks. "Build me a Max for Live audio effect" would dispatch generically to DSP + UI without M4L-specific guidance
- **Why it matters:** Agents don't know they're building an M4L device, so they won't add plugin~/plugout~, parameter_enable, presentation mode setup, or any M4L conventions
- **Affected workflow:** All `/max-build` and `/max-iterate` commands for M4L devices

### High-Priority Gaps (degrades M4L device quality)

**G3. No M4L critic module**
- **What:** No critic checks for M4L device completeness, no gain~ before plugout~ validation, no parameter_enable verification
- **Why it matters:** Devices can be generated missing required M4L components (plugout~, parameter_enable) with no automated warning. The gain~ before plugout~ rule (from memory) is undocumented in critics.
- **Affected workflow:** Critic loop during `/max-build` and `/max-iterate`

**G4. No presentation mode layout intelligence**
- **What:** Presentation layout is a crude 4-per-row grid fallback. No M4L-specific layout patterns (e.g., controls grouped by function, meters on the right, macro controls prominent)
- **Why it matters:** M4L devices are primarily experienced through presentation mode. A professional-looking presentation layout is essential for usability in Ableton.
- **Affected workflow:** UI agent during device layout

**G5. Missing M4L objects in database**
- **What:** live.adsrui and live.adsr~ not in m4l/objects.json. live.scope~ in packages/ but not m4l/
- **Why it matters:** Rule #1 (Never Guess Objects) means agents will refuse to use these objects, even though they're real M4L objects
- **Affected workflow:** Any device using ADSR envelopes or scope visualization

**G6. No relationships.json entries for M4L**
- **What:** Zero M4L object pairings. Missing: plugin~/plugout~, live.thisdevice/live.path, live.dial/live.param~, live.observer/live.path/live.object chain
- **Why it matters:** Relationship data informs agents about common object pairings. Without it, agents don't know to add plugout~ when they add plugin~, or to use live.path with live.object.
- **Affected workflow:** Object suggestion and companion pairing during generation

### Medium-Priority Gaps (nice to have for workflow quality)

**G7. No M4L-specific CLAUDE.md rules**
- **What:** CLAUDE.md has no M4L section. Rules like "no gain~ before plugout~", "always set parameter_enable on live.* controls", "use plugout~ not dac~ for M4L" exist only in memory notes
- **Why it matters:** New sessions or agents without memory context will miss these rules
- **Affected workflow:** All M4L generation sessions

**G8. No device type detection in analysis**
- **What:** analysis.py cannot determine if a patch is an M4L audio_effect, instrument, or midi_effect based on plugin~/plugout~ and MIDI I/O patterns
- **Why it matters:** Device type affects valid structure (instruments need MIDI input, audio effects need plugin~/plugout~, MIDI effects don't need signal I/O)
- **Affected workflow:** Patch analysis, validation, and critic checks

**G9. plugin~/plugout~ not in maxclass_map or sizing**
- **What:** plugin~/plugout~ are MSP objects that use their own maxclass but aren't in UI_MAXCLASSES or UI_SIZES
- **Why it matters:** resolve_maxclass() returns "newobj" for these, which would produce incorrect .maxpat output. However, the kicksynth-m4l.maxpat shows plugout~ with maxclass="newobj" -- so either MAX accepts both, or the DB maxclass field is informational only. Needs verification.
- **Affected workflow:** Patch generation with plugin~/plugout~

**G10. No .amxd export support**
- **What:** No function to create .amxd bundles. The kicksynth-m4l.amxd was created manually outside the framework.
- **Why it matters:** M4L devices are distributed as .amxd files. Without export support, the last mile is manual.
- **Affected workflow:** Device distribution and testing in Ableton

### Low-Priority Gaps (polish)

**G11. SECTION_SIGNATURES missing M4L entries**
- **What:** analysis.py SECTION_SIGNATURES has no entries for plugin~, plugout~, live.thisdevice, or other M4L objects
- **Why it matters:** When analyzing an M4L device, sections containing these objects would get generic "Section N" names instead of meaningful labels like "Audio Input (M4L)" or "Device Configuration"
- **Affected workflow:** `/max-iterate --full` analysis output

**G12. No M4L parameter metadata in object DB**
- **What:** M4L objects lack parameter_enable metadata, automation range info, parameter type classifications
- **Why it matters:** Agents can't automatically set correct parameter ranges or types without this metadata. Currently relies on developer knowledge.
- **Affected workflow:** Parameter configuration during device creation

**G13. No M4L-specific test coverage for end-to-end workflows**
- **What:** No test that creates an M4L device from scratch and validates it has all required components
- **Why it matters:** Regression risk -- changes to the framework could break M4L device generation without detection
- **Affected workflow:** CI/testing

## Prioritized Improvements

### Critical

**M4L-01: Add M4L device scaffold to project creation**
- **Priority:** Critical
- **Summary:** Add device_type parameter to create_project() that scaffolds M4L boilerplate
- **Rationale:** Every M4L device needs the same base structure. Manual setup is error-prone and defeats the framework's purpose.
- **Scope:** Medium -- extend create_project(), add template logic, add convenience methods to Patcher
- **Dependencies:** None
- **Affected files:** `src/maxpat/project.py`, `src/maxpat/patcher.py`

**M4L-02: Add M4L dispatch rules to router**
- **Priority:** Critical
- **Summary:** Add M4L keywords, intent patterns, and dispatch rules to max-router
- **Rationale:** Without routing, M4L tasks get generic handling. This is the entry point for all M4L work.
- **Scope:** Small -- add keywords to dispatch-rules.md, update SKILL.md context budget table
- **Dependencies:** None
- **Affected files:** `.claude/skills/max-router/SKILL.md`, `.claude/skills/max-router/references/dispatch-rules.md`

### High

**M4L-03: Create M4L critic module**
- **Priority:** High
- **Summary:** New critic module (m4l_critic.py) checking device completeness, gain~/plugout~ rule, parameter_enable, plugin~/plugout~ presence
- **Rationale:** Automates the knowledge currently only in developer memory. Prevents incomplete devices from passing the critic loop.
- **Scope:** Medium -- new critic module, add to __init__.py auto-detection, write tests
- **Dependencies:** M4L-08 (device type detection, for knowing what to check)
- **Affected files:** `src/maxpat/critics/m4l_critic.py`, `src/maxpat/critics/__init__.py`, `tests/test_m4l_critic.py`

**M4L-04: Add M4L presentation mode layout patterns**
- **Priority:** High
- **Summary:** M4L-aware presentation layout engine that groups controls by function, positions meters, labels, and uses Ableton-like layout conventions
- **Rationale:** Presentation mode IS the device UI. The current grid fallback produces unusable layouts for M4L.
- **Scope:** Large -- extend layout.py with M4L presentation strategies, possibly new layout module
- **Dependencies:** M4L-01 (device scaffold to mark patches as M4L)
- **Affected files:** `src/maxpat/layout.py`, possibly new `src/maxpat/m4l_layout.py`

**M4L-05: Add missing M4L objects to database**
- **Priority:** High
- **Summary:** Add live.adsrui, live.adsr~ to m4l/objects.json; move live.scope~ from packages/ to m4l/
- **Rationale:** Rule #1 compliance -- agents won't use objects not in the DB
- **Scope:** Small -- add 2-3 object entries with verified I/O data
- **Dependencies:** None
- **Affected files:** `.claude/max-objects/m4l/objects.json`, possibly `maxclass_map.py`, `sizing.py`

**M4L-06: Add M4L entries to relationships.json**
- **Priority:** High
- **Summary:** Add companion pairs: plugin~/plugout~, live.thisdevice/live.path, live.observer/live.path/live.object, live.dial/live.param~
- **Rationale:** Enables agents to suggest companion objects and validate completeness
- **Scope:** Small -- add entries to relationships.json
- **Dependencies:** None
- **Affected files:** `.claude/max-objects/relationships.json`

### Medium

**M4L-07: Add M4L section to CLAUDE.md**
- **Priority:** Medium
- **Summary:** Document M4L-specific rules: no gain~ before plugout~, always parameter_enable, plugout~ not dac~, device type conventions
- **Rationale:** Codifies memory notes into permanent rules. All agents see CLAUDE.md.
- **Scope:** Small -- add domain-specific rules section
- **Dependencies:** None
- **Affected files:** `CLAUDE.md`

**M4L-08: Add M4L device type detection to analysis**
- **Priority:** Medium
- **Summary:** Detect audio_effect/instrument/midi_effect from plugin~/plugout~/MIDI object patterns
- **Rationale:** Device type affects what the critic should check and what the scaffold should include
- **Scope:** Small -- add method to AnalysisMixin, add SECTION_SIGNATURES entries
- **Dependencies:** None
- **Affected files:** `src/maxpat/analysis.py`

**M4L-09: Resolve plugin~/plugout~ maxclass mapping**
- **Priority:** Medium
- **Summary:** Verify whether plugin~/plugout~ need UI_MAXCLASSES/UI_SIZES entries; add if needed
- **Rationale:** Correct maxclass resolution prevents malformed .maxpat output. The kicksynth-m4l.maxpat uses maxclass="newobj" for plugout~, suggesting they may use newobj not their own name despite the DB saying otherwise.
- **Scope:** Small -- test in MAX, update maps if needed, update msp/objects.json if DB is wrong
- **Dependencies:** None
- **Affected files:** `src/maxpat/maxclass_map.py`, `src/maxpat/sizing.py`, possibly `.claude/max-objects/msp/objects.json`

**M4L-10: Add M4L-specific agent instructions to SKILL.md files**
- **Priority:** Medium
- **Summary:** Add M4L sections to max-dsp-agent, max-ui-agent, and max-patch-agent SKILL.md files with M4L-specific patterns and conventions
- **Rationale:** Agents need domain-specific guidance for M4L tasks even when properly routed
- **Scope:** Small -- add sections to 3 SKILL.md files
- **Dependencies:** M4L-02 (dispatch rules first)
- **Affected files:** `.claude/skills/max-dsp-agent/SKILL.md`, `.claude/skills/max-ui-agent/SKILL.md`, `.claude/skills/max-patch-agent/SKILL.md`

### Low

**M4L-11: Add M4L SECTION_SIGNATURES entries**
- **Priority:** Low
- **Summary:** Add plugin~, plugout~, live.thisdevice to SECTION_SIGNATURES for better analysis naming
- **Rationale:** Better analysis output readability for M4L devices
- **Scope:** Small -- add dict entries
- **Dependencies:** None
- **Affected files:** `src/maxpat/analysis.py`

**M4L-12: Add M4L parameter metadata to object DB**
- **Priority:** Low
- **Summary:** Add parameter_enable, parameter type, automation range metadata to live.* objects in m4l/objects.json
- **Rationale:** Enables automated parameter configuration during generation
- **Scope:** Medium -- research correct values from MAX documentation, update all 18 UI objects
- **Dependencies:** None
- **Affected files:** `.claude/max-objects/m4l/objects.json`

**M4L-13: Add .amxd export support**
- **Priority:** Low
- **Summary:** Function to package a .maxpat as an .amxd bundle with device metadata
- **Rationale:** Completes the M4L workflow from creation to distribution. Currently manual.
- **Scope:** Large -- research .amxd format (which may be opaque/undocumented), implement packaging
- **Dependencies:** M4L-01 (device scaffold for metadata)
- **Affected files:** `src/maxpat/project.py` or new `src/maxpat/m4l_export.py`

**M4L-14: Add M4L end-to-end test coverage**
- **Priority:** Low
- **Summary:** Test that creates an M4L device via the framework and validates all required components
- **Rationale:** Regression prevention for the M4L workflow
- **Scope:** Medium -- new test file with multiple test cases
- **Dependencies:** M4L-01 (scaffold), M4L-03 (critic)
- **Affected files:** `tests/test_m4l_workflow.py`

## Recommendations

1. **Start with M4L-01 + M4L-02 + M4L-07** (scaffold, routing, CLAUDE.md rules). These are zero-dependency improvements that immediately enable M4L-aware device creation. The scaffold is the single highest-impact improvement -- it eliminates the manual boilerplate that currently gates every M4L project.

2. **Follow with M4L-03 + M4L-05 + M4L-06** (critic, missing objects, relationships). These make the quality loop aware of M4L requirements. The critic is especially important because it automates the "no gain~ before plugout~" rule and device completeness checks that currently live only in developer memory.

3. **Defer M4L-04 (presentation layout intelligence) until real usage patterns emerge.** The kicksynth-m4l was laid out manually and successfully. Premature layout automation for M4L may not match actual device design needs. Better to build more devices first and extract patterns.

4. **Defer M4L-13 (.amxd export) -- investigate feasibility first.** The .amxd format may be partially proprietary or require Live-specific tooling. A quick research spike should determine if programmatic .amxd creation is viable before committing to implementation.

5. **M4L-09 (plugin~/plugout~ maxclass) is a quick verification task** that should be done early to ensure correct .maxpat output. The kicksynth-m4l evidence suggests plugout~ uses maxclass="newobj" with text="plugout~", which contradicts the DB saying maxclass="plugout~". One is wrong -- resolve it.
