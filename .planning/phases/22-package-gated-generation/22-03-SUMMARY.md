---
phase: 22-package-gated-generation
plan: "03"
subsystem: agent-skills
tags: [skills, lifecycle, router, package-gating]
dependency_graph:
  requires: [load_project_config, save_project_config, get_allowed_packages, patcher-allowed-packages]
  provides: [max-new-package-prompt, max-build-config-gate, agent-allowed-packages-threading]
  affects: [max-lifecycle, max-router, max-patch-agent, max-dsp-agent, max-ui-agent, max-rnbo-agent]
tech_stack:
  added: []
  patterns: [skill-md-documentation, config-gate-pattern]
key_files:
  created: []
  modified:
    - .claude/skills/max-lifecycle/SKILL.md
    - .claude/skills/max-lifecycle/references/project-structure.md
    - .claude/skills/max-router/SKILL.md
    - .claude/skills/max-patch-agent/SKILL.md
    - .claude/skills/max-dsp-agent/SKILL.md
    - .claude/skills/max-ui-agent/SKILL.md
    - .claude/skills/max-rnbo-agent/SKILL.md
decisions:
  - "Router blocks /max-build when config.json missing (D-03)"
  - "All generation agents load config and pass allowed_packages to Patcher"
metrics:
  completed: "2026-04-14"
  tasks_completed: 2
  tasks_total: 2
---

# Phase 22 Plan 03: Agent SKILL.md Wiring Summary

Updated 7 SKILL.md files to wire package config end-to-end: /max-new prompts for packages, /max-build gates on config.json, all generation agents pass allowed_packages to Patcher.

## Tasks Completed

| # | Task | Commit | Files |
|---|------|--------|-------|
| 1 | Update max-lifecycle SKILL.md for package selection and /max-config | e457539 | .claude/skills/max-lifecycle/SKILL.md, .claude/skills/max-lifecycle/references/project-structure.md |
| 2 | Update max-router and generation agent SKILL.md files for package gating | 48138da | .claude/skills/max-router/SKILL.md, .claude/skills/max-patch-agent/SKILL.md, .claude/skills/max-dsp-agent/SKILL.md, .claude/skills/max-ui-agent/SKILL.md, .claude/skills/max-rnbo-agent/SKILL.md |

## What Was Built

### max-lifecycle Updates
- Added `load_project_config`, `save_project_config`, `get_allowed_packages` to Python Interface import block
- Added `### Package Configuration` section with bundled/community group presentation
- Added `/max-config` to When to Use section
- Added config.json context loading step
- Updated project-structure.md with config.json in directory layout and documentation section

### max-router Updates
- Added config.json gate check in Domain Context Loading (step 3)
- Router blocks dispatch when config.json is missing with clear user message
- Added `allowed_packages` pass-through to specialist agents in Output Protocol

### Generation Agent Updates (4 agents)
- max-patch-agent: Step 4 in Domain Context Loading for config.json and allowed_packages
- max-dsp-agent: Step 4 in Domain Context Loading for config.json and allowed_packages
- max-ui-agent: Step 3 in Domain Context Loading for config.json and allowed_packages
- max-rnbo-agent: Step 4 with RNBO-specific note about RNBODatabase wrapping ObjectDatabase

## Verification Results

All 7 SKILL.md files contain required `allowed_packages` and `config.json` references.

## Deviations from Plan

None -- plan executed exactly as written.
