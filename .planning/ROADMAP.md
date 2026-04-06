# Roadmap: MaxSystem

## Milestones

- ✅ **v1.0 MVP** -- Phases 1-7 (shipped 2026-03-10)
- ✅ **v1.1 Patch Quality & Aesthetics** -- Phases 8-12 (shipped 2026-03-14)
- ✅ **v2.0 Direct .maxpat Editing** -- Phases 13-19 (shipped 2026-03-17)
- 🚧 **v3.0 M4L Device Creation** -- Phases 20-25 (in progress)

## Phases

<details>
<summary>✅ v1.0 MVP (Phases 1-7) -- SHIPPED 2026-03-10</summary>

- [x] Phase 1: Object Knowledge Base (3/3 plans) -- completed 2026-03-09
- [x] Phase 2: Patch Generation and Validation (4/4 plans) -- completed 2026-03-10
- [x] Phase 3: Code Generation (2/2 plans) -- completed 2026-03-10
- [x] Phase 4: Agent System and Orchestration (6/6 plans) -- completed 2026-03-10
- [x] Phase 5: RNBO and External Development (4/4 plans) -- completed 2026-03-10
- [x] Phase 6: Fix Skill Documentation Signatures (1/1 plan) -- completed 2026-03-10
- [x] Phase 7: Fix Stale Agent Documentation (1/1 plan) -- completed 2026-03-10

Full details: `.planning/milestones/v1.0-ROADMAP.md`

</details>

<details>
<summary>✅ v1.1 Patch Quality & Aesthetics (Phases 8-12) -- SHIPPED 2026-03-14</summary>

- [x] Phase 8: Help Patch Audit Pipeline (4/4 plans) -- completed 2026-03-13
- [ ] Phase 9: Object DB Corrections (0/2 plans) -- deferred (low priority, audit data available for manual use)
- [x] Phase 10: Aesthetic Foundations (2/2 plans) -- completed 2026-03-13
- [x] Phase 11: Layout Refinements (3/3 plans) -- completed 2026-03-13
- [x] Phase 12: Pipeline Integration & Agent Updates (2/2 plans) -- completed 2026-03-14

Full details: see phase details below (archived in-place)

</details>

<details>
<summary>✅ v2.0 Direct .maxpat Editing (Phases 13-19) -- SHIPPED 2026-03-17</summary>

- [x] Phase 13: Round-Trip Foundation (3/3 plans) -- completed 2026-03-16
- [x] Phase 14: Search and Mutation Primitives (2/2 plans) -- completed 2026-03-16
- [x] Phase 15: Intelligent Editing (3/3 plans) -- completed 2026-03-16
- [x] Phase 16: Patch Analysis (1/1 plan) -- completed 2026-03-16
- [x] Phase 17: Agent and Command Migration (3/3 plans) -- completed 2026-03-16
- [x] Phase 18: v1.x Cleanup (2/2 plans) -- completed 2026-03-16
- [x] Phase 19: Tech Debt Cleanup (1/1 plan) -- completed 2026-03-17

Full details: `.planning/milestones/v2.0-ROADMAP.md`

</details>

### 🚧 v3.0 M4L Device Creation (In Progress)

**Milestone Goal:** First-class Max for Live device authoring -- from project creation through validated output, with M4L-aware scaffolding, routing, critics, and presentation layout.

**Phase Numbering:**
- Integer phases (20, 21, 22, 23, 24, 25): Planned milestone work
- Decimal phases (e.g., 21.1): Urgent insertions if needed (marked with INSERTED)

- [ ] **Phase 20: Foundation** -- M4L constants, DB objects, relationships, CLAUDE.md rules, terminal names hotfix, device type detection
- [ ] **Phase 21: Scaffold & Routing** -- Device scaffold for 3 types, parameter_enable, local naming, presentation flags, dispatch rules, SKILL.md updates
- [ ] **Phase 22: Validation & Export** -- M4L critic module, device completeness checks, gain~/plugout~ rule, parameter uniqueness, .amxd export
- [ ] **Phase 23: Polish** -- Parameter naming intelligence, info text annotations, Push controller banks
- [ ] **Phase 24: Layout** -- M4L presentation mode layout engine with grouping, tabbed/single/overlay patterns, whole pixel enforcement
- [ ] **Phase 25: Testing** -- End-to-end M4L device tests for all device types

## Phase Details

### Phase 20: Foundation
**Goal**: The framework has all M4L data structures, database entries, and detection logic needed before any M4L-specific code generation or validation can begin
**Depends on**: Nothing (first phase in v3.0)
**Requirements**: DB-01, DB-02, DB-03, DB-04, VALID-04, VALID-05, ROUTING-02
**Success Criteria** (what must be TRUE):
  1. `m4l_constants.py` exists with IntEnum classes for parameter_type, parameter_unitstyle, parameter_modmode, and AMXD binary format constants -- importable by downstream scaffold, critic, and export code
  2. `live.adsrui`, `live.adsr~` are in m4l/objects.json with verified inlet/outlet counts, and `live.scope~` has domain corrected to M4L
  3. relationships.json contains M4L companion entries (plugin~/plugout~, live.path/live.object, midiin/midiout) so agents discover correct pairings
  4. `detect_device_type()` returns audio_effect/instrument/midi_effect with confidence scores from patch structure analysis (plugin~/plugout~/midiin presence)
  5. `plugout~` is in `_TERMINAL_NAMES` in both validation.py and dsp_critic.py -- M4L signal chains no longer generate false-positive unterminated warnings
**Plans:** 2 plans

Plans:
- [ ] 20-01-PLAN.md -- Object DB entries (live.adsr~, live.adsrui, live.scope~), overrides (plugin~/plugout~ maxclass), M4L relationships, terminal names fix
- [ ] 20-02-PLAN.md -- M4L constants module, device type detection, CLAUDE.md M4L rules

### Phase 21: Scaffold & Routing
**Goal**: Users can create M4L devices of any type with correct boilerplate auto-generated, and the agent system routes M4L tasks with device-aware context
**Depends on**: Phase 20
**Requirements**: SCAFFOLD-01, SCAFFOLD-02, SCAFFOLD-03, SCAFFOLD-04, SCAFFOLD-05, SCAFFOLD-06, ROUTING-01, ROUTING-03
**Success Criteria** (what must be TRUE):
  1. Creating an audio_effect device produces a patch with plugin~, plugout~, live.thisdevice, openinpresentation=1, and devicewidth -- ready to open in Live
  2. Creating an instrument device produces a patch with midiin, midiout, plugout~, and live.thisdevice -- MIDI passes through and audio outputs correctly
  3. Creating a midi_effect device produces a patch with midiin, midiout, live.thisdevice, and no audio I/O objects
  4. All live.* UI controls in scaffolded devices have parameter_enable=1 with complete saved_attribute_attributes blocks, and all named objects (buffer~, coll, send, receive, etc.) are prefixed with `---`
  5. Router recognizes M4L keywords ("Max for Live", "M4L", "Ableton device") and dispatches with M4L-specific context; agent SKILL.md files contain M4L instruction sections
**Plans**: TBD
**UI hint**: yes

### Phase 22: Validation & Export
**Goal**: The framework catches M4L-specific errors before the user opens the device in Live, and can produce .amxd files directly
**Depends on**: Phase 21
**Requirements**: VALID-01, VALID-02, VALID-03, EXPORT-01
**Success Criteria** (what must be TRUE):
  1. M4L critic flags gain~ connected to plugout~ as an error (Ableton channel strip handles volume)
  2. M4L critic validates device completeness per type -- missing plugout~, midiin, midiout, or live.thisdevice are flagged as errors
  3. M4L critic detects duplicate parameter_longname values across the device and flags as error (prevents Ableton automation crashes)
  4. `write_amxd()` produces a valid .amxd file with correct 32-byte binary header per device type, openable in Live
**Plans**: TBD

### Phase 23: Polish
**Goal**: M4L devices have professional parameter metadata and Ableton integration details auto-populated
**Depends on**: Phase 21
**Requirements**: POLISH-01, POLISH-02, POLISH-03
**Success Criteria** (what must be TRUE):
  1. Parameter naming intelligence auto-derives longname, shortname, and varname from object context (e.g., a live.dial connected to a filter cutoff gets "Filter Cutoff" / "Cutoff" / "filter_cutoff")
  2. live.banks object is auto-generated with Push controller bank organization grouping related parameters
  3. Info text / annotations are auto-populated on live.* controls so Ableton's Info View shows meaningful tooltips
**Plans**: TBD
**UI hint**: yes

### Phase 24: Layout
**Goal**: M4L devices have professional presentation mode layouts that respect Ableton's constraints and organize controls intelligently
**Depends on**: Phase 21
**Requirements**: LAYOUT-01, LAYOUT-02, LAYOUT-03
**Success Criteria** (what must be TRUE):
  1. M4L presentation layout engine groups controls by function within the 169px height constraint -- no controls are clipped in Ableton's device view
  2. Layout supports tabbed, single-page, and overlay patterns -- choosing the appropriate pattern based on control count and device complexity
  3. All presentation coordinates are enforced as whole pixels -- no fractional values that cause blurry rendering in Live
**Plans**: TBD
**UI hint**: yes

### Phase 25: Testing
**Goal**: The complete M4L device creation workflow is verified end-to-end with automated tests
**Depends on**: Phase 22, Phase 23, Phase 24
**Requirements**: TEST-01
**Success Criteria** (what must be TRUE):
  1. End-to-end tests create an audio_effect, instrument, and midi_effect device and validate all required components are present with correct attributes
  2. Tests verify the full pipeline: scaffold produces valid device, critic catches intentional errors, .amxd export succeeds, and layout respects constraints
**Plans**: TBD

## Progress

**Execution Order:**
Phases execute in numeric order: 20 -> 21 -> 22 -> 23 -> 24 -> 25
Phase 23 (Polish) and Phase 24 (Layout) can run in parallel after Phase 21. Phase 25 depends on all prior phases.

| Phase | Milestone | Plans Complete | Status | Completed |
|-------|-----------|----------------|--------|-----------|
| 1. Object Knowledge Base | v1.0 | 3/3 | Complete | 2026-03-09 |
| 2. Patch Generation and Validation | v1.0 | 4/4 | Complete | 2026-03-10 |
| 3. Code Generation | v1.0 | 2/2 | Complete | 2026-03-10 |
| 4. Agent System and Orchestration | v1.0 | 6/6 | Complete | 2026-03-10 |
| 5. RNBO and External Development | v1.0 | 4/4 | Complete | 2026-03-10 |
| 6. Fix Skill Documentation Signatures | v1.0 | 1/1 | Complete | 2026-03-10 |
| 7. Fix Stale Agent Documentation | v1.0 | 1/1 | Complete | 2026-03-10 |
| 8. Help Patch Audit Pipeline | v1.1 | 4/4 | Complete | 2026-03-13 |
| 9. Object DB Corrections | v1.1 | 0/2 | Deferred | - |
| 10. Aesthetic Foundations | v1.1 | 2/2 | Complete | 2026-03-13 |
| 11. Layout Refinements | v1.1 | 3/3 | Complete | 2026-03-13 |
| 12. Pipeline Integration & Agent Updates | v1.1 | 2/2 | Complete | 2026-03-14 |
| 13. Round-Trip Foundation | v2.0 | 3/3 | Complete | 2026-03-16 |
| 14. Search and Mutation Primitives | v2.0 | 2/2 | Complete | 2026-03-16 |
| 15. Intelligent Editing | v2.0 | 3/3 | Complete | 2026-03-16 |
| 16. Patch Analysis | v2.0 | 1/1 | Complete | 2026-03-16 |
| 17. Agent and Command Migration | v2.0 | 3/3 | Complete | 2026-03-16 |
| 18. v1.x Cleanup | v2.0 | 2/2 | Complete | 2026-03-16 |
| 19. Tech Debt Cleanup | v2.0 | 1/1 | Complete | 2026-03-17 |
| 20. Foundation | v3.0 | 0/2 | Not started | - |
| 21. Scaffold & Routing | v3.0 | 0/TBD | Not started | - |
| 22. Validation & Export | v3.0 | 0/TBD | Not started | - |
| 23. Polish | v3.0 | 0/TBD | Not started | - |
| 24. Layout | v3.0 | 0/TBD | Not started | - |
| 25. Testing | v3.0 | 0/TBD | Not started | - |

---
*Roadmap created: 2026-03-08*
*Last updated: 2026-04-05 -- Phase 20 planned (2 plans, 1 wave)*
