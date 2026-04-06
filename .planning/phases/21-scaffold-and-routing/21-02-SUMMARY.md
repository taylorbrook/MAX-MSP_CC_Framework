---
phase: 21-scaffold-and-routing
plan: 02
subsystem: routing
tags: [m4l, max-for-live, dispatch, skill-docs, ableton]

# Dependency graph
requires:
  - phase: 20-foundation
    provides: M4L constants, detection, CLAUDE.md M4L rules
provides:
  - M4L dispatch rules in router (keyword detection, context injection strategy)
  - M4L-specific instruction sections in 4 agent SKILL.md files
  - M4L awareness note in critic to prevent false positives
affects: [22-m4l-critic, 23-m4l-parameters, 24-m4l-layout]

# Tech tracking
tech-stack:
  added: []
  patterns: [m4l-context-injection-dispatch, agent-augmentation-not-dedicated-agent]

key-files:
  created: []
  modified:
    - .claude/skills/max-router/references/dispatch-rules.md
    - .claude/skills/max-router/SKILL.md
    - .claude/skills/max-dsp-agent/SKILL.md
    - .claude/skills/max-patch-agent/SKILL.md
    - .claude/skills/max-ui-agent/SKILL.md
    - .claude/skills/max-critic/SKILL.md

key-decisions:
  - "M4L dispatches to existing agents with context injection, not a dedicated M4L agent (per D-07)"
  - "M4L section placed after Capabilities in each agent SKILL.md for consistent structure"

patterns-established:
  - "M4L context injection: router detects M4L keywords, injects device type + constraint reminders into agent dispatch"
  - "Agent augmentation pattern: domain agents receive M4L-specific rule sections rather than a separate M4L agent handling everything"

requirements-completed: [ROUTING-01, ROUTING-03]

# Metrics
duration: 3min
completed: 2026-04-06
---

# Phase 21 Plan 02: M4L Router Dispatch and Agent SKILL.md Updates Summary

**M4L keyword dispatch rules added to router with domain-specific M4L instruction sections in DSP, Patch, UI, and Critic agents**

## Performance

- **Duration:** 3 min
- **Started:** 2026-04-06T21:04:07Z
- **Completed:** 2026-04-06T21:07:48Z
- **Tasks:** 2
- **Files modified:** 6

## Accomplishments
- Router dispatch-rules.md has complete M4L keyword section with primary/secondary keywords, dispatch strategy, context injection rules, and intent patterns
- Router SKILL.md quick reference table includes M4L/Ableton row with dispatch paragraph
- Four agent SKILL.md files have domain-specific M4L sections: DSP (signal chain), Patch (MIDI routing), UI (presentation/controls), Critic (awareness note)
- Ambiguity resolution table extended with 3 M4L edge cases

## Task Commits

Each task was committed atomically:

1. **Task 1: Add M4L dispatch section to dispatch-rules.md and update router SKILL.md** - `01a8097` (feat)
2. **Task 2: Add M4L sections to 4 agent SKILL.md files + critic awareness note** - `50648a9` (feat)

## Files Created/Modified
- `.claude/skills/max-router/references/dispatch-rules.md` - M4L Dispatch section with keywords, dispatch strategy, context injection, intent patterns; 3 M4L edge cases in ambiguity table
- `.claude/skills/max-router/SKILL.md` - M4L/Ableton row in quick reference table, M4L dispatch paragraph
- `.claude/skills/max-dsp-agent/SKILL.md` - M4L Signal Chain Rules (plugin~/plugout~ I/O, gain~ prohibition, no dac~, stereo convention)
- `.claude/skills/max-patch-agent/SKILL.md` - M4L MIDI Routing (midiin/midiout passthrough, --- prefix, live.path/live.object, live.thisdevice)
- `.claude/skills/max-ui-agent/SKILL.md` - M4L Presentation Mode and Controls (169px height, parameter_enable, saved_attribute_attributes template, devicewidth, parameter uniqueness)
- `.claude/skills/max-critic/SKILL.md` - M4L Device Awareness (don't flag plugin~/plugout~, missing dac~, or live.* as errors; Phase 22 dedicated critic note)

## Decisions Made
- M4L dispatches to existing agents with context injection, not a dedicated M4L agent (per D-07)
- M4L section placed after Capabilities in each agent SKILL.md for consistent structure
- All M4L content is domain-specific and consistent with CLAUDE.md M4L rules (single source of truth)

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered
None

## User Setup Required
None - no external service configuration required.

## Next Phase Readiness
- Router and agents are M4L-aware, ready for Phase 22 (M4L critic) and scaffold implementation (Plan 01)
- Agent SKILL.md M4L sections reference Phase 22 for dedicated M4L critic module

---
*Phase: 21-scaffold-and-routing*
*Completed: 2026-04-06*
