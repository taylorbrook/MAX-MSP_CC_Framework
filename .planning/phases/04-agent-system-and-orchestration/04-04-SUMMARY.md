---
phase: 04-agent-system-and-orchestration
plan: 04
subsystem: agents
tags: [skills, router, dispatch, multi-agent, specialist-agents, boundaries]

# Dependency graph
requires:
  - phase: 04-agent-system-and-orchestration (plans 01-03)
    provides: Critic modules, memory system, project lifecycle -- agents reference these
  - phase: 01-object-knowledge-base
    provides: Object database JSON files that agents load as domain context
  - phase: 02-patch-generation
    provides: Patcher/Box/generate_patch API that agents call
  - phase: 03-code-generation
    provides: GenExpr/js/N4M codegen functions that agents call
provides:
  - Router agent with keyword-to-specialist dispatch rules
  - 6 specialist agent skills (Patch, DSP, RNBO stub, js, Ext stub, UI)
  - Dispatch rules reference with domain keyword mapping
  - Merge protocol reference for multi-agent output coordination
  - BOUNDARIES.md for all 6 specialists defining scope limits
affects: [04-05-slash-commands, 04-06-integration, phase-5-rnbo-externals]

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "SKILL.md with frontmatter (name, description, allowed-tools, preconditions)"
    - "BOUNDARIES.md per specialist defining what the agent does and does not do"
    - "Domain context loading instructions in each SKILL.md"
    - "Phase 5 stub pattern: acknowledge request, defer generation, offer limited help"
    - "Dispatch rules as keyword-to-agent mapping with intent patterns"
    - "Merge protocol with single file ownership and lead agent designation"

key-files:
  created:
    - ".claude/skills/max-router/SKILL.md"
    - ".claude/skills/max-router/references/dispatch-rules.md"
    - ".claude/skills/max-router/references/merge-protocol.md"
    - ".claude/skills/max-patch-agent/SKILL.md"
    - ".claude/skills/max-patch-agent/BOUNDARIES.md"
    - ".claude/skills/max-dsp-agent/SKILL.md"
    - ".claude/skills/max-dsp-agent/BOUNDARIES.md"
    - ".claude/skills/max-rnbo-agent/SKILL.md"
    - ".claude/skills/max-rnbo-agent/BOUNDARIES.md"
    - ".claude/skills/max-js-agent/SKILL.md"
    - ".claude/skills/max-js-agent/BOUNDARIES.md"
    - ".claude/skills/max-ext-agent/SKILL.md"
    - ".claude/skills/max-ext-agent/BOUNDARIES.md"
    - ".claude/skills/max-ui-agent/SKILL.md"
    - ".claude/skills/max-ui-agent/BOUNDARIES.md"
  modified: []

key-decisions:
  - "Router dispatch uses keyword/intent analysis against per-domain keyword tables (not LLM classification)"
  - "Lead agent designation for multi-domain tasks follows DSP > Patch > js > UI hierarchy"
  - "Merge protocol enforces single file ownership -- no two agents write to same file"
  - "RNBO and Ext stubs offer limited help (compatibility checking, architecture discussion) rather than silent failure"
  - "Each agent specifies exactly which object DB files to load -- no full 2012-object context bloat"
  - "Presentation mode positions (presentation_rect) are UI agent authority; patching positions are lead agent authority"

patterns-established:
  - "Agent skill structure: frontmatter -> domain context loading -> capabilities -> output protocol -> when to use/not use"
  - "Stub agent pattern: status banner, deferral message, current limited capabilities, Phase 5 planned features"
  - "Boundary definition: explicit DOES/DOES NOT lists with handoff table"

requirements-completed: [AGT-01, AGT-02]

# Metrics
duration: 5min
completed: 2026-03-10
---

# Phase 4 Plan 04: Router and Specialist Agent Skills Summary

**Router agent with keyword dispatch rules and 6 specialist skills (Patch, DSP, RNBO stub, js, Ext stub, UI) each loading only domain-relevant context**

## Performance

- **Duration:** 5 min
- **Started:** 2026-03-10T15:19:38Z
- **Completed:** 2026-03-10T15:25:15Z
- **Tasks:** 1
- **Files created:** 15

## Accomplishments
- Router agent with dispatch-rules.md (keyword-to-agent mapping for 6 domains) and merge-protocol.md (multi-agent output coordination with single file ownership)
- 4 active specialist agents (Patch, DSP, js, UI) each specifying domain context loading, Python API references, output protocol, and usage criteria
- 2 stub agents (RNBO, Externals) with Phase 5 deferral messages and limited current capabilities (compatibility checking, architecture discussion)
- All 6 specialists have BOUNDARIES.md defining explicit scope limits and handoff points to other agents

## Task Commits

Each task was committed atomically:

1. **Task 1: Router agent and specialist agent skills** - `fd14daa` (feat)

## Files Created/Modified
- `.claude/skills/max-router/SKILL.md` - Router agent: task analysis, dispatch, multi-agent coordination
- `.claude/skills/max-router/references/dispatch-rules.md` - Detailed keyword-to-agent mapping with intent patterns and edge cases
- `.claude/skills/max-router/references/merge-protocol.md` - Multi-agent output merging: file ownership, I/O matching, conflict resolution
- `.claude/skills/max-patch-agent/SKILL.md` - Patch specialist: control flow, MIDI, message routing, subpatchers
- `.claude/skills/max-patch-agent/BOUNDARIES.md` - Patch agent scope limits and handoff points
- `.claude/skills/max-dsp-agent/SKILL.md` - DSP specialist: GenExpr, MSP signal chains, audio effects, gain staging
- `.claude/skills/max-dsp-agent/BOUNDARIES.md` - DSP agent scope limits and PD confusion guard reminder
- `.claude/skills/max-rnbo-agent/SKILL.md` - RNBO stub: compatibility checking only, Phase 5 deferral
- `.claude/skills/max-rnbo-agent/BOUNDARIES.md` - RNBO stub current vs Phase 5 planned capabilities
- `.claude/skills/max-js-agent/SKILL.md` - js specialist: N4M CommonJS scripts, V8 js scripts, validation
- `.claude/skills/max-js-agent/BOUNDARIES.md` - js agent scope limits: code only, no patches
- `.claude/skills/max-ext-agent/SKILL.md` - Externals stub: architecture discussion only, Phase 5 deferral
- `.claude/skills/max-ext-agent/BOUNDARIES.md` - Ext stub current vs Phase 5 planned capabilities
- `.claude/skills/max-ui-agent/SKILL.md` - UI specialist: presentation mode, control layout, visual hierarchy
- `.claude/skills/max-ui-agent/BOUNDARIES.md` - UI agent scope: positions controls, does not wire them

## Decisions Made
- Router dispatch uses keyword/intent tables per domain rather than LLM-based classification for deterministic routing
- Lead agent hierarchy for multi-domain tie-breaking: DSP > Patch > js > UI
- Merge protocol enforces single file ownership to prevent conflicting writes
- Stub agents provide limited current value (RNBO: compatibility checking; Ext: architecture discussion) rather than returning empty errors
- Each specialist loads only its domain's object JSON (e.g., DSP loads msp/ + gen/ = 437 objects, not all 2,012)
- Presentation_rect authority belongs to UI agent; patching_rect to lead agent or layout engine

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered
None

## User Setup Required
None - no external service configuration required.

## Next Phase Readiness
- All 7 agent skills ready for slash command wiring (Plan 05/06)
- Router dispatch rules ready for integration with /max:build command
- RNBO and Externals stubs will be expanded in Phase 5
- Critic, memory, and lifecycle agents (from Plans 01-03) complement these generation agents

## Self-Check: PASSED

All 15 created files verified present. Commit fd14daa verified in git log.

---
*Phase: 04-agent-system-and-orchestration*
*Completed: 2026-03-10*
