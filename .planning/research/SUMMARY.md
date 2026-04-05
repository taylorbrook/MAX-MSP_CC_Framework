# Project Research Summary

**Project:** MaxSystem v3.0 — M4L Device Creation
**Domain:** Max for Live device authoring within existing Python patch generation framework
**Researched:** 2026-04-05
**Confidence:** HIGH

## Executive Summary

This milestone adds first-class M4L device authoring support to the existing framework. The framework already proves it can generate valid M4L devices — kicksynth-m4l.maxpat (67 boxes, 24 automatable parameters, tabbed presentation UI) was built with it — but every M4L-specific convention required manual developer knowledge: device type selection, parameter metadata blocks, presentation mode flags, plugout~ instead of dac~, --- namespace scoping. v3.0 automates all of that. The stack requires no new dependencies; every addition is data structures, constants, and new functions in existing modules.

The recommended approach is surgical integration at 6 insertion points: a new `m4l_constants.py` (data only), `create_m4l_project()` in `project.py`, `m4l_critic.py` following the rnbo_critic pattern, two additive fixes to `validation.py` and `dsp_critic.py`, an M4L-aware branch in `layout.py`, `write_amxd()` in `hooks.py`, and M4L keyword additions to dispatch rules and agent SKILL.md files. No new abstractions, no new agents, no architectural rewrites. The .amxd export — previously considered a deferred item due to a "partially opaque format" — is fully reverse-engineered from kicksynth-m4l.amxd: a 32-byte fixed header + identical JSON. 15 lines of Python. Ships in v3.0.

The primary risks are structural. Duplicate `parameter_longname` values silently break Ableton automation (potential crash). `plugout~` is missing from the existing terminal-object sets, causing every M4L device to generate false-positive "unterminated chain" warnings while passing dangerous gain staging configurations unchecked. The 169px Ableton device height constraint will clip controls if the current grid layout runs unmodified for presentation mode. All three are caught by the M4L critic, but the terminal-set fix (adding `plugout~` to `_TERMINAL_NAMES` in two files) is a prerequisite that must land before any other M4L work.

## Key Findings

### Recommended Stack

No new dependencies. The entire v3.0 M4L feature set is achievable with the existing Python + JSON stack. The M4L parameter system, .amxd binary format, and device type conventions are fully documented in a new `m4l_constants.py` as `IntEnum` classes. Everything flows through the existing `extra_attrs` mechanism on Box objects — no new Box attributes, no subclasses.

**Core technologies:**
- **Python + existing Patcher API** — all M4L device authoring, unchanged from today
- **`m4l_constants.py` (new, data-only)** — `ParamType`, `UnitStyle`, `ModMode`, `ParamVisibility` IntEnums + `AMXD_*` binary format constants; verified against kicksynth-m4l ground truth
- **`struct.pack`** — .amxd binary header (stdlib, 15 LOC total)
- **`extra_attrs` + `configure_m4l_parameter()` convenience method** — parameter metadata without API fragmentation; keeps Box class generic

### Expected Features

**Must have (table stakes):**
- **TS-1: Device Type Scaffold** — eliminates all boilerplate for audio_effect/instrument/midi_effect
- **TS-2: Automatic parameter_enable** — live.* controls are automatable in Ableton by default
- **TS-3: Presentation Mode Setup** — `openinpresentation=1`, `devicewidth`, integer coordinates enforced
- **TS-4: No gain~ Before plugout~ Rule** — critic check, prevents double-volume-control bug documented in project memory
- **TS-5: Device Completeness Validation** — catches missing plugout~, midiin, midiout, live.thisdevice
- **TS-6: Local Naming Convention** — auto-prefix `---` on all named objects for per-instance isolation
- **TS-7: M4L Dispatch + Agent Routing** — router injects M4L context into existing agents
- **TS-8: Device Type Detection** — confidence-scored heuristic (not single-object binary) to avoid false positives
- **TS-9: .amxd Export** — trivial 15-LOC implementation; completes device creation loop

**Should have (differentiators):**
- **DF-2: Parameter Naming Intelligence** — auto-derive longname/shortname/varname/unitstyle from semantic context
- **DF-4: Info Text / Annotations** — populates Ableton Info View tooltips; explicit quality marker in Ableton guidelines
- **DF-5: M4L Relationships in DB** — plugin~/plugout~, live.path chains, live.dial/prepend pattern for gen~ routing
- **DF-6: Missing M4L Objects** — live.adsrui, live.adsr~, live.scope~ domain correction (currently blocked by Rule #1)
- **DF-1: Intelligent Presentation Layout** — M4L-aware layout replacing crude grid fallback

**Defer (v2+):**
- **DF-3: Push Controller Banks** — per-device customization, low universal demand
- **AF-1: Live API path automation** — live.path strings require full Ableton object model knowledge; silent failures on wrong paths
- **AF-2: Modulator device type** — custom Map-button paradigm, insufficient demand signal
- **AF-5: Frozen device export** — requires Live's internal freeze process, not externally accessible

### Architecture Approach

M4L integrates via 6 surgical insertion points in existing modules — no new abstractions or architectural layers. The pattern mirrors RNBO: a new critic file, a new constants file, additive changes to `critics/__init__.py` auto-detection, and small modifications to existing functions. `patcher.py` and `Box` are unchanged. The scaffold lives in `project.py` (alongside `create_project()`), the critic lives in `critics/m4l_critic.py` (following rnbo_critic.py shape exactly), and .amxd export is a single function in `hooks.py`.

**Major components:**
1. **`m4l_constants.py`** — parameter enums, device type constants, .amxd binary format constants (new file, pure data, no logic)
2. **`project.py` `create_m4l_project()`** — scaffold with correct boilerplate per device type; calls existing `create_project()` internally
3. **`critics/m4l_critic.py`** — 6 checks: plugout~ presence, gain~/plugout~ chain, parameter_enable completeness, parameter_longname uniqueness, live.thisdevice presence, openinpresentation flag
4. **`hooks.py` `write_amxd()`** — 32-byte header + JSON payload; device type encoded in bytes 8-11 as ASCII 4-char code
5. **`layout.py` `_apply_m4l_presentation_layout()`** — 169px height cap, integer coordinates, group-by-varname-prefix positioning
6. **`analysis.py` `detect_device_type()`** — confidence-scored heuristic; counter-signal from `dac~`/`ezdac~` presence

### Critical Pitfalls

1. **Duplicate parameter_longname** — two live.* controls with the same longname cause Ableton to crash on load or produce broken automation lanes with duplicate entries. M4L critic must enforce uniqueness as a blocker. Scaffold must never generate duplicate defaults.

2. **`plugout~` missing from `_TERMINAL_NAMES`** — every M4L device generates false-positive "unterminated chain" warnings (trains developer to ignore warnings), and gain staging BFS never reaches plugout~ (oscillator at full volume passes silently). Add `"plugout~"` to `_TERMINAL_NAMES` in `validation.py` line 41 and `dsp_critic.py` line 33. Two-line additive fix, zero regression risk. Do this before any other M4L work.

3. **Missing `saved_attribute_attributes` block** — `parameter_enable=1` without the full valueof block silently disables automation in Ableton while appearing fully functional in MAX standalone. Scaffold must generate complete blocks including `parameter_longname`, `parameter_shortname`, `parameter_type`, `parameter_initial`, and `parameter_unitstyle`.

4. **169px height constraint** — current `_apply_presentation_layout` grid puts row 2 bottom edge at 244px for standard live.dial size: 75px past the Ableton clip boundary. M4L layout branch must hard-cap at 169px and prefer tabbed or wide horizontal layouts.

5. **Router "live" keyword false positives** — "live" is massively overloaded in this domain. M4L dispatch keywords must be multi-word phrases: "Max for Live", "M4L", "Ableton device". Never add bare "live", "device", or "instrument" as standalone triggers.

## Implications for Roadmap

Based on the dependency graph in FEATURES.md and the integration analysis in ARCHITECTURE.md, the recommended structure is a mandatory prerequisite hotfix followed by 4 phases.

### Pre-Phase: Terminal Name Hotfix
**Rationale:** Two additive lines unblock correct M4L validation and eliminate false positives before any M4L code is written. Zero risk. Must land first so the test suite starts with a clean baseline.
**Delivers:** `plugout~` treated as terminal in both `validation.py` and `dsp_critic.py`; M4L signal chains stop generating false-positive warnings; gain staging BFS correctly traverses to plugout~.
**Avoids:** Pitfall 2 (silent gain staging pass-through), training developers to ignore validator output.

### Phase 1: Foundation (Data and Constants)
**Rationale:** Pure data additions — no behavior changes. All downstream components (scaffold, critic, export) depend on these. All 4 tasks are fully parallelizable.
**Delivers:** `m4l_constants.py` with typed enums; `live.adsrui`, `live.adsr~`, corrected `live.scope~` in `m4l/objects.json`; M4L relationship entries in `relationships.json`; `detect_device_type()` with confidence scoring in `analysis.py`; M4L rules added to CLAUDE.md; plugin~/plugout~ maxclass verified in MAX (resolve Pitfall 12 before touching DB).
**Addresses:** TS-8, DF-5, DF-6
**Avoids:** Pitfall 15 (magic number parameter_type errors), Pitfall 9 (false positive critic invocation), Pitfall 12 (accidental maxclass change)
**Research flag:** Standard patterns, no additional research needed.

### Phase 2: Scaffold and Routing
**Rationale:** Creates the starting point for all M4L devices and routes agent tasks correctly. Depends on Phase 1 constants and device type detection. Scaffold and dispatch tasks are parallelizable.
**Delivers:** `create_m4l_project()` generating per-type boilerplate (plugin~, plugout~, midiin/midiout, live.thisdevice, openinpresentation=1, devicewidth, --- prefixed named objects, complete saved_attribute_attributes blocks on all live.* controls with auto-generated unique parameter names); M4L dispatch keywords in router using multi-word phrases only; M4L sections in agent SKILL.md files.
**Addresses:** TS-1, TS-2, TS-3, TS-6, TS-7
**Avoids:** Pitfall 3 (missing saved_attribute_attributes), Pitfall 4 (missing openinpresentation), Pitfall 8 (namespace collision), Pitfall 10 (router false positives)
**Research flag:** Established patterns. `create_project()` is the direct template. No research phase needed.

### Phase 3: Validation and Export
**Rationale:** Validates what Phase 2 scaffolds — requires scaffold output as test fixtures. .amxd export is trivial and belongs here to complete the creation loop. Critic module and `__init__.py` wiring are sequential; .amxd export is independent.
**Delivers:** `critics/m4l_critic.py` with 6 checks (plugout~ presence, gain~ chain, parameter_enable completeness, parameter_longname uniqueness, live.thisdevice presence, openinpresentation); confidence-scored auto-detection wired into `critics/__init__.py`; `write_amxd()` in `hooks.py`; plugin~/plugout~ added to `_IO_OBJECT_NAMES` in `layout.py` line 1091.
**Addresses:** TS-4, TS-5, TS-9
**Avoids:** Pitfall 1 (duplicate longnames), Pitfall 5 (gain~/plugout~ double volume), Pitfall 14 (subpatcher extraction of plugout~)
**Research flag:** Critic pattern from rnbo_critic.py is a direct template. .amxd format fully confirmed. No research phase needed.

### Phase 4: Polish (Layout and UX)
**Rationale:** Most subjective components; require real devices built in Phases 2-3 as test inputs for layout tuning. Presentation layout is the highest-effort item and benefits from observing actual usage patterns before automation strategy is locked in.
**Delivers:** M4L-aware `_apply_m4l_presentation_layout()` in `layout.py` with 169px hard cap, integer coordinate enforcement, group-by-varname-prefix layout, tabbed pattern support; parameter naming intelligence (auto-derive shortname, varname, unitstyle from semantic context); info text/annotations on live.* controls; end-to-end test suite (`tests/test_m4l_workflow.py`).
**Addresses:** DF-1, DF-2, DF-4
**Avoids:** Pitfall 6 (169px height overflow), Pitfall 13 (fractional pixel blurry rendering)
**Research flag:** Layout automation strategy needs validation against 3-5 real devices built with the Phase 2 scaffold before the heuristics are coded. Run a mini research phase at the start of Phase 4 planning.

### Phase Ordering Rationale

- **Terminal fix before everything** — false-positive warnings corrupt developer trust in the validation signal; fixing it costs 2 lines and enables reliable test baselines.
- **Constants before scaffold** — scaffold, critic, and export all import from `m4l_constants.py`; building in reverse requires refactoring.
- **Scaffold before critic** — critic tests use `create_m4l_project()` as fixture factory; handcrafted JSON fixtures are fragile and miss edge cases.
- **Critic before layout** — structural validity (plugout~ present, parameters complete) must be confirmed before visual polish is worth iterating.
- **Layout last** — only component that benefits from a corpus of real devices built with the scaffold; crude grid fallback is functional in the interim.

### Research Flags

Needs research during planning:
- **Phase 4 (layout engine):** Optimal strategy for inferring layout pattern (single-page/tabbed/overlay) and control grouping from device structure is TBD. Build 3-5 real devices with Phase 2 scaffold first, then research layout heuristics.

Standard patterns (skip research-phase):
- **Pre-phase hotfix:** Two known lines in two known files.
- **Phase 1:** All values verified against ground truth and official docs.
- **Phase 2:** `create_project()` is the direct scaffold template; router dispatch is additive config.
- **Phase 3:** rnbo_critic.py is the direct critic template; .amxd format fully reverse-engineered.

## Confidence Assessment

| Area | Confidence | Notes |
|------|------------|-------|
| Stack | HIGH | No new dependencies confirmed. All M4L parameter enum values verified against kicksynth-m4l.maxpat ground truth and Cycling 74 official docs. |
| Features | HIGH | Table stakes verified against official Cycling 74 docs + Ableton production guidelines. .amxd format upgraded from MEDIUM to HIGH after full reverse-engineering from working binary. |
| Architecture | HIGH | Based on direct codebase analysis of all 8 affected modules with specific line numbers. RNBO integration provides proven template for every new component. |
| Pitfalls | HIGH (critical 1-5), MEDIUM (moderate 6-12) | Critical pitfalls verified against framework source code line numbers and ground truth. Moderate pitfalls (device type false positives, router ambiguity) are architecturally predicted but not runtime-tested. |

**Overall confidence:** HIGH

### Gaps to Address

- **Presentation layout automation strategy (Phase 4):** How to programmatically infer layout pattern and control grouping without explicit developer hints. Flag for mini research-phase before Phase 4 planning. Can be deferred until the scaffold produces a real device corpus.

- **`parameter_modmode` omission consequences:** Omitting `parameter_modmode` from `saved_attribute_attributes` has LOW-confidence documented consequences. Scaffold should include it (value 0 is safe default) but specific failure modes are undocumented. Monitor during Phase 2 testing in Ableton.

- **Patcher-level `parameters` dict necessity:** Kicksynth-m4l.maxpat has no patcher-level `parameters` dict and works correctly in Live. Forum reports suggest it may be needed for some Push/preset scenarios. Do not pre-build; validate during Phase 3 end-to-end testing.

- **`plugin~/plugout~` maxclass:** DB says `maxclass: "plugout~"`, kicksynth-m4l shows `maxclass: "newobj"`. Current behavior works. Resolve with a 30-second MAX verification in Phase 1 before touching any plugin~/plugout~ DB entries.

- **UnitStyle values 5-8, 10 verification:** Only values 1-4 and 9 are verified against ground truth. Values 5 (%), 6 (Pan), 7 (Semitones), 8 (MIDI) are from docs ordering only. Build a device using them and check Live display during Phase 2 testing.

## Sources

### Primary (HIGH confidence)
- `patches/kicksynth/generated/kicksynth-m4l.maxpat` — ground truth: 67-box M4L instrument, 24 live.dials with complete saved_attribute_attributes, verified working in Live
- `patches/kicksynth/generated/kicksynth-m4l.amxd` — reverse-engineered .amxd binary format (32-byte header + identical JSON confirmed)
- [Cycling 74: Device Parameters in Max for Live](https://docs.cycling74.com/userguide/m4l/live_parameters/) — parameter_type, unitstyle, modmode
- [Cycling 74: Creating Audio Effect Devices](https://docs.cycling74.com/userguide/m4l/live_audiodevices/) — plugin~/plugout~ requirements
- [Cycling 74: Creating MIDI Effects](https://docs.cycling74.com/userguide/m4l/live_midieffects/) — midiin/midiout requirements, midiselect
- [Ableton M4L Production Guidelines](https://github.com/Ableton/maxdevtools/blob/main/m4l-production-guidelines/m4l-production-guidelines.md) — --- naming, annotations, pixel-perfect layout, 169px height constraint
- Framework source: `validation.py` (lines 41, 635), `dsp_critic.py` (lines 33, 235), `layout.py` (lines 1057, 1091), `patcher.py` (line 320), `project.py` (~93), `defaults.py` (lines 51-93), `critics/__init__.py`, `critics/rnbo_critic.py`

### Secondary (MEDIUM confidence)
- [Cycling 74 Forum: .amxd file format](https://cycling74.com/forums/max-for-live-device-file-format) — community format analysis (confirmed by direct reverse-engineering)
- [Cycling 74 Forum: Initialization order inconsistency](https://cycling74.com/forums/initialization-order-inconsistency) — live.thisdevice timing race conditions on project load
- [Cycling 74: Parameter Mode](https://docs.cycling74.com/userguide/parameter_mode/) — parameter_visibility enum values
- [Cycling 74 Forum: bPatchers creating duplicate automation lanes](https://cycling74.com/forums/bpatchers-creating-duplicate-automation-lanes-in-live) — parameter_longname collision consequences
- `.planning/quick/260405-lne-review-m4l-device-creation-capabilities-/M4L-CAPABILITY-REVIEW.md` — gap analysis motivating this research
- Project memory: `feedback_m4l_no_gain.md` — gain~/plugout~ rule documented from prior experience

### Tertiary (LOW confidence)
- Cycling 74 Forums: patcher-level `parameters` dict for preset/Push scenarios — not observed in kicksynth-m4l ground truth; validate during Phase 3 before building
- Forum reports of .amxd checksums — not observed in reverse-engineered file; likely only applies to Live-frozen devices

---
*Research completed: 2026-04-05*
*Ready for roadmap: yes*
