---
phase: quick-260405-lne
plan: 01
subsystem: documentation
tags: [m4l, review, capability-audit, roadmap-input]
dependency_graph:
  requires: []
  provides: [m4l-capability-review, m4l-improvement-roadmap]
  affects: [project.py, critics, dispatch-rules, CLAUDE.md, m4l-objects-json]
tech_stack:
  added: []
  patterns: [capability-audit, gap-analysis]
key_files:
  created:
    - .planning/quick/260405-lne-review-m4l-device-creation-capabilities-/M4L-CAPABILITY-REVIEW.md
  modified: []
decisions:
  - "14 improvements prioritized across critical/high/medium/low with dependency ordering"
  - "Recommended starting with scaffold + routing + CLAUDE.md rules (zero dependencies)"
  - "Deferred presentation layout intelligence and .amxd export until more devices built"
  - "Identified plugin~/plugout~ maxclass discrepancy needing verification"
metrics:
  duration: 5min
  completed: "2026-04-05"
---

# Phase quick-260405-lne Plan 01: M4L Device Creation Capability Review Summary

Comprehensive audit of all M4L touchpoints across 12 codebase areas, producing a 327-line capability review with 14 prioritized improvements.

## What Was Done

### Task 1: Audit all M4L touchpoints and produce capability review document
- **Commit:** 48cb80d
- Audited all 12 areas: object DB (35 objects, 3 missing), maxclass_map (29 live.* mapped), sizing (all live.* sized), layout (basic M4L control support), analysis (domain classification works), critics (no M4L module), project (no M4L scaffold), hooks (generic), patcher (no M4L methods), skills (no M4L dispatch), CLAUDE.md (minimal M4L), tests (3 test classes)
- Analyzed kicksynth-m4l.maxpat as ground truth: 67 boxes, 26 M4L objects, 24 parameters with parameter_enable, presentation mode active, plugout~ present
- Identified 4 gap tiers: 2 critical (scaffold, routing), 4 high (critic, presentation layout, missing objects, relationships), 4 medium (CLAUDE.md rules, device type detection, maxclass mapping, SKILL.md instructions), 4 low (section signatures, parameter metadata, .amxd export, e2e tests)
- Produced 14 numbered improvements (M4L-01 through M4L-14) with priority, rationale, scope, dependencies, and affected files

## Key Findings

1. **Foundation is solid:** All live.* objects correctly mapped in UI_MAXCLASSES, UI_SIZES, and domain classification. Existing kicksynth-m4l proves the framework CAN build M4L devices.
2. **No M4L automation exists:** Zero M4L-specific critic checks, no device scaffold, no routing pathway, no agent instructions. Everything is manual.
3. **Critical gap:** No gain~ before plugout~ rule exists only in memory -- not in critics, not in CLAUDE.md, not in any agent skill.
4. **plugin~/plugout~ maxclass discrepancy:** DB says maxclass="plugout~" but kicksynth-m4l.maxpat uses maxclass="newobj". Needs verification.

## Deviations from Plan

None -- plan executed exactly as written.

## Self-Check: PASSED
