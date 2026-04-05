---
phase: quick-260405-lne
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - .planning/quick/260405-lne-review-m4l-device-creation-capabilities-/M4L-CAPABILITY-REVIEW.md
autonomous: true
requirements: [M4L-REVIEW]

must_haves:
  truths:
    - "Review document catalogs every M4L-related file in the codebase with its current capability"
    - "Review identifies all gaps between current M4L support and what a production M4L workflow needs"
    - "Improvements are categorized by priority (critical/high/medium/low) with effort estimates"
    - "Each improvement has a clear rationale tied to real M4L device creation pain points"
  artifacts:
    - path: ".planning/quick/260405-lne-review-m4l-device-creation-capabilities-/M4L-CAPABILITY-REVIEW.md"
      provides: "Comprehensive M4L capability review with prioritized improvements"
      min_lines: 150
  key_links: []
---

<objective>
Produce a detailed capability review document analyzing the current state of Max for Live device creation support in this framework, cataloging every relevant touchpoint (object DB, sizing, layout, analysis, critics, skills, CLAUDE.md rules), identifying gaps, and recommending prioritized improvements.

Purpose: Inform the next milestone's roadmap for M4L-optimized device creation.
Output: M4L-CAPABILITY-REVIEW.md with current state, gap analysis, and prioritized improvement recommendations.
</objective>

<execution_context>
@$HOME/.claude/get-shit-done/workflows/execute-plan.md
@$HOME/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@.planning/STATE.md
@CLAUDE.md

Key source files to audit:
@.claude/max-objects/m4l/objects.json
@src/maxpat/analysis.py
@src/maxpat/sizing.py
@src/maxpat/layout.py
@src/maxpat/maxclass_map.py
@src/maxpat/critics/dsp_critic.py
@src/maxpat/project.py
@src/maxpat/patcher.py
@src/maxpat/hooks.py
@.claude/skills/max-dsp-agent/SKILL.md
@.claude/skills/max-ui-agent/SKILL.md
@.claude/skills/max-lifecycle/SKILL.md
@.claude/skills/max-critic/SKILL.md
@.claude/skills/max-router/SKILL.md
@.claude/skills/max-router/references/dispatch-rules.md
@patches/kicksynth/generated/kicksynth-m4l.maxpat
@tests/test_sizing.py (TestLiveObjectSizes class)
@tests/test_analysis.py (M4L domain classification tests)
</context>

<tasks>

<task type="auto">
  <name>Task 1: Audit all M4L touchpoints and produce capability review document</name>
  <files>.planning/quick/260405-lne-review-m4l-device-creation-capabilities-/M4L-CAPABILITY-REVIEW.md</files>
  <action>
Systematically audit every file in the codebase that touches M4L functionality. For each touchpoint, document WHAT it does, WHAT is MISSING, and HOW important the gap is.

**Audit these areas in order:**

1. **Object Database** (`m4l/objects.json`, `overrides.json`, `relationships.json`):
   - Count and categorize all 33+ M4L objects by type (UI, API, MSP, utility)
   - Check if `plugin~` and `plugout~` (in msp/objects.json) have correct I/O, descriptions, and `seealso` links
   - Check if M4L objects have proper `parameter_enable`, parameter type metadata, automation range info
   - Check `relationships.json` for M4L object pairings (e.g., plugin~/plugout~, live.thisdevice/live.path)
   - Identify any missing M4L objects not yet in the database

2. **Maxclass Map** (`maxclass_map.py`):
   - Verify all M4L objects listed in UI_MAXCLASSES are correct
   - Check if plugin~/plugout~ are in the right category
   - Identify any M4L objects missing from the map

3. **Sizing** (`sizing.py`):
   - Verify all visual M4L widgets have fixed sizes in UI_SIZES
   - Check if sizes match actual MAX 9 defaults (cross-reference with kicksynth-m4l.maxpat as ground truth)
   - Identify any unsized visual M4L objects

4. **Layout** (`layout.py`):
   - Check if M4L controls are in UI_CONTROLS for special layout handling
   - Assess presentation mode support -- does layout engine handle M4L presentation optimization?
   - Check if plugin~/plugout~ get special positioning (they should be at signal chain boundaries)

5. **Analysis** (`analysis.py`):
   - Verify domain classification for live.* prefix objects
   - Check parameter detection for M4L controls
   - Assess if analysis can identify M4L device type (audio_effect vs instrument vs midi_effect)
   - Check if analysis detects plugin~/plugout~ presence

6. **Critics** (`dsp_critic.py`, critic __init__):
   - Check MIDI-range flagging for live.dial, live.slider, live.numbox
   - Assess if there's any M4L-specific validation (device completeness, plugin~/plugout~ presence, parameter inspector requirements)
   - Check if gain~ before plugout~ is flagged (per memory note feedback_m4l_no_gain.md)

7. **Project/Lifecycle** (`project.py`, `hooks.py`):
   - Check if create_project supports M4L device type
   - Check if there's .amxd export support
   - Check if device metadata (name, category, author) is handled

8. **Patcher API** (`patcher.py`):
   - Check for any M4L-specific methods (add_plugin_io, set_device_type, etc.)
   - Check if presentation mode is well-supported for M4L layouts

9. **Skills/Agents** (all SKILL.md files, dispatch-rules.md):
   - Check if any agent has M4L-specific instructions
   - Check if router dispatches M4L tasks to the right agent(s)
   - Assess if a dedicated M4L agent/skill would be beneficial

10. **CLAUDE.md Rules**:
    - Assess current M4L coverage (currently minimal -- just object count mention)
    - Identify what M4L-specific rules should exist

11. **Tests**:
    - Catalog existing M4L test coverage (TestLiveObjectSizes, domain classification, etc.)
    - Identify untested M4L scenarios

12. **Existing M4L Patch** (kicksynth-m4l.maxpat):
    - Analyze as ground truth for what a real M4L device looks like
    - Identify patterns used that the framework should codify

**Write the review document with these sections:**

```
# M4L Device Creation Capability Review

## Executive Summary
[2-3 sentence overview of current state and biggest gaps]

## Current State

### Object Database
[Findings from audit area 1]

### Code Support Matrix
[Table: module | M4L support | gaps]

### Agent/Skill Coverage
[Findings from audit areas 9-10]

### Test Coverage
[Findings from audit area 11]

## Gap Analysis

### Critical Gaps (blocks M4L device creation)
[Each gap: what, why it matters, affected workflow]

### High-Priority Gaps (degrades M4L device quality)
[Same format]

### Medium-Priority Gaps (nice to have)
[Same format]

### Low-Priority Gaps (polish)
[Same format]

## Prioritized Improvements

[Numbered list, grouped by priority tier. Each improvement:]
- ID: M4L-NN
- Priority: critical/high/medium/low
- Summary: one line
- Rationale: why this matters for M4L device creation
- Scope: small/medium/large (effort estimate)
- Dependencies: which improvements must come first
- Affected files: which source files would change

## Recommendations
[Top 3-5 recommendations for next steps, informed by the full audit]
```
  </action>
  <verify>
    <automated>test -f ".planning/quick/260405-lne-review-m4l-device-creation-capabilities-/M4L-CAPABILITY-REVIEW.md" && wc -l ".planning/quick/260405-lne-review-m4l-device-creation-capabilities-/M4L-CAPABILITY-REVIEW.md" | awk '{if ($1 >= 150) print "PASS: " $1 " lines"; else print "FAIL: only " $1 " lines"}'</automated>
  </verify>
  <done>M4L-CAPABILITY-REVIEW.md exists with 150+ lines, covers all 12 audit areas, has gap analysis with priority tiers, and includes numbered improvement recommendations with IDs, rationale, scope, and dependencies</done>
</task>

</tasks>

<verification>
- Review document covers all 12 audit areas listed in the action
- Every gap has a priority classification (critical/high/medium/low)
- Improvements are numbered with IDs (M4L-01, M4L-02, etc.)
- Each improvement has rationale, scope estimate, and dependency info
- Document references specific file paths and line numbers where relevant
</verification>

<success_criteria>
- Comprehensive M4L capability review document produced
- All M4L-related code touchpoints cataloged with current capability
- Gaps categorized by severity with clear rationale
- Improvements prioritized and actionable (could drive a roadmap phase)
- Existing kicksynth-m4l.maxpat analyzed as ground truth
</success_criteria>

<output>
After completion, create `.planning/quick/260405-lne-review-m4l-device-creation-capabilities-/260405-lne-SUMMARY.md`
</output>
