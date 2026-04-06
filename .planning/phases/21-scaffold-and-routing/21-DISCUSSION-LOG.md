# Phase 21: Scaffold and Routing - Discussion Log

> **Audit trail only.** Do not use as input to planning, research, or execution agents.
> Decisions are captured in CONTEXT.md -- this log preserves the alternatives considered.

**Date:** 2026-04-06
**Phase:** 21-scaffold-and-routing
**Areas discussed:** Scaffold scope, --- prefix integration, Presentation defaults, SKILL.md updates

---

## Scaffold Scope

### Boilerplate level

| Option | Description | Selected |
|--------|-------------|----------|
| Minimal boilerplate | Only required objects per device type + openinpresentation + devicewidth | ✓ |
| Starter template | Required objects + basic signal chain + example live.dial + section comments | |
| Reference device | Full working device skeleton matching kicksynth-m4l.maxpat patterns | |

**User's choice:** Minimal boilerplate
**Notes:** Agents add everything else during /max-build.

### API design

| Option | Description | Selected |
|--------|-------------|----------|
| Separate function | New create_m4l_project(device_type, name, base_dir) in project.py | ✓ |
| Extend create_project() | Add optional device_type param to existing function | |

**User's choice:** Separate function
**Notes:** Matches roadmap success criteria naming. create_project() stays unchanged.

### MIDI passthrough

| Option | Description | Selected |
|--------|-------------|----------|
| Connected passthrough | midiin -> midiout connected in scaffold | ✓ |
| Placed but unconnected | Objects placed but no connections | |

**User's choice:** Connected passthrough
**Notes:** Prevents silent MIDI drops. Matches M4L convention.

---

## --- Prefix Integration

| Option | Description | Selected |
|--------|-------------|----------|
| Scaffold-time only | create_m4l_project() prefixes named objects. Agents follow CLAUDE.md rules. | ✓ |
| Patcher API helper | m4l_name() helper function for agents to use | |
| Deep integration | Patcher tracks is_m4l flag, add_box() auto-prefixes | |

**User's choice:** Scaffold-time only
**Notes:** No API changes needed. Simple approach.

---

## Presentation Defaults

### Device width

| Option | Description | Selected |
|--------|-------------|----------|
| 300px | Ableton's stock device default, fits 4-5 dials | ✓ |
| 200px | Compact starting point for simple effects | |
| User-specified | Optional param with 300 default | |

**User's choice:** 300px

### Layout scope

| Option | Description | Selected |
|--------|-------------|----------|
| Flags only | openinpresentation=1 + presentation=1 on live.thisdevice. No presentation_rect on boilerplate. | ✓ |
| Basic grid | Assign presentation_rect to all scaffold objects | |

**User's choice:** Flags only
**Notes:** Phase 24 Layout engine handles all positioning.

---

## SKILL.md Updates

### Dispatch model

| Option | Description | Selected |
|--------|-------------|----------|
| Existing agents + M4L context | Router injects M4L context into existing agent dispatches | ✓ |
| Dedicated M4L agent | New max-m4l-agent for all M4L-specific logic | |

**User's choice:** Existing agents + M4L context
**Notes:** Matches how RNBO works with existing agents. No new agent needed.

### Agent selection

| Option | Description | Selected |
|--------|-------------|----------|
| max-patch-agent | MIDI routing, live.path/live.object chains | ✓ |
| max-dsp-agent | plugin~/plugout~ I/O, gain~/plugout~ prohibition | ✓ |
| max-ui-agent | live.* controls, parameter_enable, presentation mode, 169px | ✓ |
| max-router | M4L keyword detection, dispatch-rules.md M4L section | ✓ |

**User's choice:** All four agents
**Notes:** All selected.

### Critic awareness

| Option | Description | Selected |
|--------|-------------|----------|
| Yes, add a note | Brief M4L awareness section in max-critic SKILL.md | ✓ |
| No, handle in Phase 22 | Wait for dedicated M4L critic | |

**User's choice:** Yes, add a note

---

## Claude's Discretion

- Object positioning within scaffold patches
- Exact M4L keyword list for router dispatch
- Internal structure of M4L context injection

## Deferred Ideas

None -- discussion stayed within phase scope
