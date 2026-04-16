---
phase: 25-templates-and-critics
plan: 03
subsystem: agent-skills
tags: [templates, flucoMa, beap, bach, lifecycle, packages]
dependency_graph:
  requires: []
  provides:
    - FluCoMa workflow templates in DSP agent SKILL.md
    - BEAP extended templates (FM synthesis, sequenced pattern) in DSP agent SKILL.md
    - Bach workflow templates in patch agent SKILL.md
    - Template suggestion guidance in lifecycle SKILL.md
    - PACKAGES.md cross-references to agent templates
  affects:
    - .claude/skills/max-dsp-agent/SKILL.md
    - .claude/skills/max-patch-agent/SKILL.md
    - .claude/skills/max-lifecycle/SKILL.md
    - .claude/max-objects/PACKAGES.md
tech_stack:
  added: []
  patterns:
    - Structured signal chain templates with connection tables
    - Cross-reference pattern between PACKAGES.md and agent SKILL.md files
key_files:
  created: []
  modified:
    - .claude/skills/max-dsp-agent/SKILL.md
    - .claude/skills/max-patch-agent/SKILL.md
    - .claude/skills/max-lifecycle/SKILL.md
    - .claude/max-objects/PACKAGES.md
decisions:
  - Templates are structured text with connection tables, not .maxpat files (per D-02)
  - FluCoMa/BEAP templates in DSP agent, Bach templates in patch agent (domain alignment)
  - Lifecycle suggests templates as guidance only, no auto-scaffolding (per D-09)
metrics:
  duration_seconds: 172
  completed: "2026-04-15T23:41:34Z"
  tasks_completed: 2
  tasks_total: 2
  files_modified: 4
---

# Phase 25 Plan 03: Package Workflow Templates Summary

FluCoMa, BEAP, and Bach workflow templates added to agent SKILL.md files with connection tables, parameter ranges, and gotchas; lifecycle suggests templates on package selection; PACKAGES.md cross-references both agent template sections.

## Task Results

| Task | Name | Commit | Files |
|------|------|--------|-------|
| 1 | Add FluCoMa and BEAP workflow templates to max-dsp-agent SKILL.md | df5be97 | .claude/skills/max-dsp-agent/SKILL.md |
| 2 | Add Bach templates, lifecycle integration, and PACKAGES.md cross-references | 7bc412e | .claude/skills/max-patch-agent/SKILL.md, .claude/skills/max-lifecycle/SKILL.md, .claude/max-objects/PACKAGES.md |

## What Was Built

### DSP Agent Templates (Task 1)
- **FluCoMa: Real-Time Audio Analysis Chain** -- fluid.melbands~ -> fluid.stats -> fluid.normalize with parameter ranges and async gotchas
- **FluCoMa: Offline Buffer Processing Pipeline** -- buffer~ -> fluid.bufnmf -> fluid.dataset -> fluid.kdtree with bang-on-completion pattern
- **FluCoMa: ML Classification Pipeline** -- train phase (buf* -> dataset -> mlpclassifier) and predict phase (real-time analysis -> classifier)
- **BEAP: FM Synthesis Chain** -- bp.LFOscillator -> bp.FM -> bp.SVF -> bp.VCA -> bp.Stereo with CV routing
- **BEAP: Sequenced Pattern** -- bp.Steppr gate/CV -> bp.ADSR + bp.Oscillator -> bp.VCA -> bp.Stereo

### Patch Agent Templates (Task 2, Part A)
- **Bach: llll Construction and Manipulation** -- bach.list2llll -> bach.join/flat/nth -> bach.score with 1-indexed gotchas
- **Bach: Notation Display Workflow** -- bach.score with dual llll/message input, pitch representation in MIDI cents
- **Bach: Algorithmic Composition Pipeline** -- metro -> random -> bach.list2llll -> bach.collect -> bach.quantize -> bach.score

### Lifecycle Integration (Task 2, Part B)
- Template suggestion guidance added after Community Package Extraction Gate section
- BEAP, FluCoMa, Bach each have specific guidance text pointing to the correct agent SKILL.md

### PACKAGES.md Cross-References (Task 2, Part C)
- BEAP Templates section references DSP agent for FM synthesis and sequenced pattern templates
- Community Packages section has new Workflow Templates subsection referencing both agent SKILL.md files

## Deviations from Plan

None -- plan executed exactly as written.

## Decisions Made

1. **Template format:** Each template includes use case, chain description, connection table (#/Source/Outlet/Destination/Inlet/Type columns), parameter ranges with defaults, and gotchas section
2. **FluCoMa ML template uses two-phase layout:** Train and Predict phases shown in a single connection table with a Phase column to distinguish offline training from real-time prediction
3. **Bach algorithmic composition template uses trigger for fan-out:** Following CLAUDE.md Rule #3 for correct ordering

## Verification Results

All plan verification checks pass:
- Both SKILL.md files contain "Package Workflow Templates" section
- Lifecycle SKILL.md has "Template Suggestions on Package Selection"
- DSP agent has 5 Gotchas sections (3 FluCoMa + 2 BEAP)
- Patch agent has 3 Gotchas sections (3 Bach templates)
- PACKAGES.md references both max-dsp-agent/SKILL.md and max-patch-agent/SKILL.md
