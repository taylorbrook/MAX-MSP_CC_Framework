---
phase: 21-scaffold-and-routing
verified: 2026-04-06T22:00:00Z
status: passed
score: 8/8 success criteria verified (2 satisfied-by-instruction per D-01/D-04)
gaps:
  - truth: "All live.* UI controls in scaffolded devices have parameter_enable=1 with complete saved_attribute_attributes blocks"
    status: partial
    reason: "Scaffold produces zero live.* UI controls (D-01 minimal boilerplate), so the requirement is vacuously satisfied but no automation is implemented. The roadmap SC implies a framework-level enforcement that does not exist — agents must apply parameter_enable manually per CLAUDE.md rules. No later phase in the roadmap explicitly adds this automation."
    artifacts:
      - path: "src/maxpat/project.py"
        issue: "create_m4l_project() does not add any live.* UI controls and has no parameter_enable enforcement mechanism. The precondition test (TestParameterEnable) verifies the scaffold has no live UI controls — not that parameter_enable is auto-enforced when controls are added."
    missing:
      - "Either: (a) accept this as an agent-instruction pattern (document that D-04 scopes this to agents, update REQUIREMENTS.md to mark SCAFFOLD-04 as partial/deferred), OR (b) implement parameter_enable auto-enforcement in the Patcher API when live.* controls are added in M4L context"
  - truth: "Named objects (buffer~, coll, dict, send, receive, send~, receive~, value) are auto-prefixed with '---' in M4L context"
    status: partial
    reason: "Scaffold produces zero named objects (D-01), so the requirement is vacuously satisfied but no auto-prefix automation is implemented. D-04 explicitly scoped this to agents applying --- manually per CLAUDE.md rules. No later roadmap phase covers this as an automated Patcher API feature."
    artifacts:
      - path: "src/maxpat/project.py"
        issue: "create_m4l_project() has no --- prefix logic. The precondition test (TestTripleDashPrefix) verifies the scaffold has no named objects — not that named objects are auto-prefixed when agents add them."
    missing:
      - "Either: (a) accept this as an agent-instruction pattern (update REQUIREMENTS.md SCAFFOLD-05 to mark as satisfied-by-instruction, not by code automation), OR (b) implement auto-prefix logic in Patcher.add_box() when the patcher is M4L-aware (openinpresentation=1)"
---

# Phase 21: Scaffold and Routing Verification Report

**Phase Goal:** Framework scaffolds complete M4L devices per type and routes agent tasks with M4L-specific context — the starting point for all M4L device creation
**Verified:** 2026-04-06T22:00:00Z
**Status:** gaps_found
**Re-verification:** No — initial verification

## Goal Achievement

### Observable Truths (from ROADMAP Success Criteria)

| # | Truth | Status | Evidence |
|---|-------|--------|----------|
| 1 | `create_m4l_project('audio_effect')` generates a valid .maxpat with plugin~, plugout~, live.thisdevice, openinpresentation=1, and devicewidth | VERIFIED | 8 tests in TestAudioEffect pass; function exists and imports; patch JSON confirmed |
| 2 | `create_m4l_project('instrument')` generates a valid .maxpat with plugout~, midiin, midiout, live.thisdevice | VERIFIED | 5 tests in TestInstrument pass including MIDI passthrough connection |
| 3 | `create_m4l_project('midi_effect')` generates a valid .maxpat with midiin, midiout, live.thisdevice (no audio I/O) | VERIFIED | 4 tests in TestMidiEffect pass including audio I/O absence check |
| 4 | All live.* UI controls in scaffolded devices have parameter_enable=1 with complete saved_attribute_attributes blocks | PARTIAL | Scaffold has zero live.* UI controls (D-01 minimal boilerplate). Vacuously true but no auto-enforcement mechanism exists. Tests verify absence of controls, not auto-enforcement. |
| 5 | Named objects are auto-prefixed with `---` in M4L context | PARTIAL | Scaffold has zero named objects (D-01). Vacuously true but no auto-prefix code exists. D-04 delegates this to agents via CLAUDE.md instruction. |
| 6 | All user-facing controls have presentation=1 and presentation_rect set | VERIFIED | live.thisdevice has presentation=1, presentation_rect=[0,0,120,20]; boilerplate objects have no presentation_rect per D-06. TestPresentation confirms both. |
| 7 | Router recognizes M4L keywords and dispatches with M4L-specific context | VERIFIED | dispatch-rules.md contains "### M4L Dispatch" with primary/secondary keywords, dispatch strategy, and context injection rules |
| 8 | Agent SKILL.md files contain M4L-specific instruction sections | VERIFIED | All 4 files updated: dsp (M4L Signal Chain Rules), patch (M4L MIDI Routing), ui (M4L Presentation Mode and Controls), critic (M4L Device Awareness) |

**Score:** 6/8 success criteria verified (2 partial — interpretation issue on SCAFFOLD-04/05)

### Required Artifacts

| Artifact | Expected | Status | Details |
|----------|----------|--------|---------|
| `src/maxpat/project.py` | `create_m4l_project()` function | VERIFIED | Function at lines 99-171, 173 lines including docstring |
| `tests/test_m4l_scaffold.py` | TDD tests for all 3 device types + edge cases | VERIFIED | 30 tests across 7 classes, 271 lines |
| `.claude/skills/max-router/references/dispatch-rules.md` | M4L keyword dispatch section | VERIFIED | "### M4L Dispatch (Max for Live Devices)" section with primary/secondary keywords |
| `.claude/skills/max-router/SKILL.md` | M4L row in quick reference table | VERIFIED | "M4L/Ableton | (multi-agent) | ..." row added with M4L dispatch paragraph |
| `.claude/skills/max-dsp-agent/SKILL.md` | M4L signal chain rules section | VERIFIED | "### M4L Signal Chain Rules" section at lines 100-108 |
| `.claude/skills/max-patch-agent/SKILL.md` | M4L MIDI routing section | VERIFIED | "### M4L MIDI Routing" section at lines 77-85 |
| `.claude/skills/max-ui-agent/SKILL.md` | M4L presentation mode section | VERIFIED | "### M4L Presentation Mode and Controls" section at lines 80-104 |
| `.claude/skills/max-critic/SKILL.md` | M4L awareness note | VERIFIED | "### M4L Device Awareness" section at lines 35-40 |
| `src/maxpat/m4l_constants.py` | M4L constants (Phase 20 dependency) | VERIFIED | Exists, ParamType/UnitStyle/ModMode/ParamVisibility enums + AMXD constants |

### Key Link Verification

| From | To | Via | Status | Details |
|------|----|-----|--------|---------|
| `src/maxpat/project.py` | `src/maxpat/patcher.py` | `Patcher(), add_box(), add_connection()` | VERIFIED | `add_box("plugin~")`, `add_box("plugout~")` etc. at lines 142-161 |
| `src/maxpat/project.py` | `src/maxpat/aesthetics.py` | `set_canvas_background()` | VERIFIED | `_set_canvas_bg(p)` at line 137 |
| `src/maxpat/project.py` | `src/maxpat/project.py` | `create_project()` for directory scaffolding | VERIFIED | `project_dir = create_project(name, base_dir)` at line 130 |
| `src/maxpat/project.py` | `src/maxpat/project.py` | `auto_commit_patch()` after save | VERIFIED | `auto_commit_patch(project_dir, base_dir, ...)` at line 169 |
| `.claude/skills/max-router/SKILL.md` | `.claude/skills/max-router/references/dispatch-rules.md` | Router reads dispatch-rules.md; SKILL.md references it | VERIFIED | "See `references/dispatch-rules.md` M4L section" paragraph in SKILL.md |
| `.claude/skills/max-router/references/dispatch-rules.md` | `CLAUDE.md` | M4L dispatch rules reference CLAUDE.md | VERIFIED | "read CLAUDE.md M4L section for authoritative rules" at dispatch-rules.md line 100 |

### Data-Flow Trace (Level 4)

Not applicable — `create_m4l_project()` is a scaffold generator, not a component that renders dynamic data. The output is a static JSON file on disk. Tests verify the JSON structure directly.

### Behavioral Spot-Checks

| Behavior | Command | Result | Status |
|----------|---------|--------|--------|
| Function is importable | `python3 -c "from src.maxpat.project import create_m4l_project; print('import OK')"` | "import OK" | PASS |
| All 30 scaffold tests pass | `python3 -m pytest tests/test_m4l_scaffold.py -v -q` | "30 passed in 0.79s" | PASS |
| M4L dispatch section exists in router | `grep -c "M4L Dispatch" .claude/skills/max-router/references/dispatch-rules.md` | "1" | PASS |
| All 4 agent SKILL.md files have M4L sections | grep for M4L Signal Chain, M4L MIDI, M4L Presentation, M4L Device Awareness | All 4 files matched | PASS |

### Requirements Coverage

| Requirement | Source Plan | Description | Status | Evidence |
|-------------|------------|-------------|--------|----------|
| SCAFFOLD-01 | Plan 01 | audio_effect with plugin~/plugout~/live.thisdevice/openinpresentation/devicewidth | SATISFIED | TestAudioEffect (8 tests) all pass |
| SCAFFOLD-02 | Plan 01 | instrument with midiin/midiout passthrough/plugout~/live.thisdevice | SATISFIED | TestInstrument (5 tests) all pass |
| SCAFFOLD-03 | Plan 01 | midi_effect with midiin/midiout/live.thisdevice, no audio I/O | SATISFIED | TestMidiEffect (4 tests) all pass |
| SCAFFOLD-04 | Plan 01 | Framework auto-sets parameter_enable=1 on live.* UI controls | PARTIAL | Tests verify precondition (no live UI controls in scaffold). No auto-enforcement code. D-01 defers to agent instruction via CLAUDE.md. |
| SCAFFOLD-05 | Plan 01 | Framework auto-prefixes named objects with `---` in M4L context | PARTIAL | Tests verify precondition (no named objects in scaffold). No auto-prefix code. D-04 delegates to agents. |
| SCAFFOLD-06 | Plan 01 | Presentation=1 and presentation_rect on user-facing objects | SATISFIED | TestPresentation confirms live.thisdevice has flags; boilerplate objects do not |
| ROUTING-01 | Plan 02 | Router recognizes M4L keywords with M4L-specific context | SATISFIED | M4L Dispatch section in dispatch-rules.md with primary/secondary keywords and context injection strategy |
| ROUTING-03 | Plan 02 | Agent SKILL.md files have M4L-specific instruction sections | SATISFIED | All 4 agents updated: dsp, patch, ui, critic |

**Orphaned requirements check:** ROUTING-02 (CLAUDE.md M4L rules section) is assigned to Phase 20 in REQUIREMENTS.md — correctly excluded from Phase 21. No orphaned requirements found.

### Anti-Patterns Found

| File | Line | Pattern | Severity | Impact |
|------|------|---------|----------|--------|
| None found | — | — | — | — |

No `gain~`, `live.dial`, `live.slider`, `return null`, `TODO`, or `FIXME` patterns in `create_m4l_project()`. No stub implementations detected.

**Pre-existing test failures (unrelated to Phase 21):**
- `tests/test_generation.py` — 2 failures (pre-existed before d46042a)
- `tests/test_hooks.py` — 1 failure (pre-existed)
- `tests/test_inlet_types.py` — 1 failure (pre-existed)
- `tests/test_analysis.py` and `tests/test_round_trip.py` and `tests/test_integration_patches.py` — failures referencing missing patch files (pre-existed)

These 4+ failing tests predate Phase 21 work and are not regressions introduced by this phase.

### Human Verification Required

None. All verification items are programmatically checkable.

### Gaps Summary

Phase 21 successfully delivers `create_m4l_project()` for all 3 M4L device types with correct boilerplate, connections, patcher properties, and presentation flags. The router dispatch rules are complete and all 4 agent SKILL.md files have M4L-specific sections. 30 tests pass with zero regressions attributable to this phase.

**The 2 gaps share a common root cause:** SCAFFOLD-04 and SCAFFOLD-05 in the roadmap describe framework-level automation ("auto-sets", "auto-prefixes") but the implementation satisfies these as preconditions only. The scaffold has no live.* UI controls and no named objects, so the behaviors are vacuously satisfied. The actual enforcement relies on agent instruction (CLAUDE.md) rather than Patcher API automation.

This was an explicit scope decision (D-01, D-04 in CONTEXT.md) — the planner chose to document the constraint in SKILL.md files rather than implement it as code. However, the roadmap success criteria are written to imply code-level automation. No later phase in the roadmap covers this automation gap.

**Resolution options for the planner:**
1. Accept as-is: Update REQUIREMENTS.md to mark SCAFFOLD-04/05 as "satisfied-by-instruction" and document that enforcement is agent-responsibility per CLAUDE.md
2. Implement: Add auto-enforcement in the Patcher API (e.g., in `add_box()` when the patcher has `openinpresentation=1`, reject named objects without `---` prefix and require `parameter_enable=1` on live.* controls)
3. Phase 22 scope: Add a validator check in the M4L critic that blocks devices with uncompliant live.* controls or non-prefixed named objects

---

_Verified: 2026-04-06T22:00:00Z_
_Verifier: Claude (gsd-verifier)_
