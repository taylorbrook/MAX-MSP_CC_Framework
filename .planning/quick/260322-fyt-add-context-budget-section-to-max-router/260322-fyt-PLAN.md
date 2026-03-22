---
phase: quick-260322-fyt
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - .claude/skills/max-router/SKILL.md
autonomous: true
requirements: [QUICK-FYT]

must_haves:
  truths:
    - "Router knows to load secondary agents partially for 3+ agent tasks"
    - "Section map tells router exactly which SKILL.md sections are domain-specific vs skippable"
    - "Total context stays under ~200 lines for 4-agent tasks instead of ~500+"
  artifacts:
    - path: ".claude/skills/max-router/SKILL.md"
      provides: "Context Budget section with per-agent section map"
      contains: "Context Budget"
  key_links:
    - from: ".claude/skills/max-router/SKILL.md"
      to: "all agent SKILL.md files"
      via: "section name references in the lookup table"
      pattern: "Domain-specific.*Capabilities"
---

<objective>
Add a "Context Budget" section to the max-router SKILL.md that instructs the router on how to optimize context loading for multi-domain tasks with 3+ agents.

Purpose: When 4 agents each load their full ~110-line SKILL.md, that is 440+ lines of context. Most of those lines are boilerplate shared across agents (output protocols, editing sections, bpatcher rules, shared-capabilities reference). The router should load only domain-specific sections for secondary agents.

Output: Updated `.claude/skills/max-router/SKILL.md` with Context Budget section inserted after "Multi-Domain Dispatch" (line 54) and before "Capabilities" (line 55).
</objective>

<execution_context>
@~/.claude/get-shit-done/workflows/execute-plan.md
@~/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@.claude/skills/max-router/SKILL.md
@.claude/skills/max-dsp-agent/SKILL.md
@.claude/skills/max-patch-agent/SKILL.md
@.claude/skills/max-ui-agent/SKILL.md
@.claude/skills/max-js-agent/SKILL.md
@.claude/skills/max-rnbo-agent/SKILL.md
</context>

<tasks>

<task type="auto">
  <name>Task 1: Add Context Budget section to max-router SKILL.md</name>
  <files>.claude/skills/max-router/SKILL.md</files>
  <action>
Insert a new "## Context Budget" section into `.claude/skills/max-router/SKILL.md` after the "## Multi-Domain Dispatch" section (after line 54, before the current "## Capabilities" at line 55).

The section must contain:

1. **Loading rules** (3 tiers):
   - 1 agent: load full SKILL.md (no change)
   - 2 agents: load both fully (no change)
   - 3+ agents: load lead agent SKILL.md fully; for secondary agents load ONLY their "Capabilities" and "Domain Context Loading" sections

2. **Per-agent section map table** showing which sections exist in each agent and their classification:

| Section | Classification | Agents That Have It |
|---------|---------------|---------------------|
| Domain Context Loading | domain-specific (always load) | all |
| Capabilities (+ subsections) | domain-specific (always load) | all |
| Editing Existing Patches | skip for secondaries | all |
| Output Protocol (New Patches) | skip for secondaries | all |
| Output Protocol (Edited Patches) | skip for secondaries | all |
| When to Use / When NOT to Use | skip for secondaries | all |
| Bpatcher Argument Substitution | skip for secondaries | patch, dsp |
| Shared Capabilities reference | skip for secondaries | all |

3. **Example** demonstrating the optimization:
   "MIDI-controlled FM synth with presets" -> lead: DSP (full SKILL.md ~107 lines), secondaries: Patch (Capabilities + Domain Context Loading ~40 lines), UI (Capabilities + Domain Context Loading ~50 lines), js (Capabilities + Domain Context Loading ~35 lines). Total: ~232 lines vs ~443 lines loading all fully.

4. **Target guideline:** Keep total loaded SKILL.md context under ~200 lines per generation task.

Keep the section concise -- lookup table format, not prose. The router reads this as a reference during dispatch, not a narrative.
  </action>
  <verify>
    <automated>grep -c "Context Budget" .claude/skills/max-router/SKILL.md | grep -q "1" && grep -q "domain-specific" .claude/skills/max-router/SKILL.md && grep -q "skip for secondaries" .claude/skills/max-router/SKILL.md && echo "PASS" || echo "FAIL"</automated>
  </verify>
  <done>
- Context Budget section exists between Multi-Domain Dispatch and Capabilities sections
- Loading rules cover 1-agent, 2-agent, and 3+ agent cases
- Per-agent section map table is present with classification column
- Example demonstrates line-count savings
- Section is concise (under 40 lines)
  </done>
</task>

</tasks>

<verification>
- `grep -n "^##" .claude/skills/max-router/SKILL.md` shows Context Budget section in correct position (after Multi-Domain Dispatch, before Capabilities)
- Section contains a table with "domain-specific" and "skip for secondaries" classifications
- Total file length is reasonable (under 130 lines -- was 84, adding ~40)
</verification>

<success_criteria>
Router SKILL.md contains a Context Budget section that a Claude instance acting as router can reference to decide which SKILL.md sections to load for secondary agents in 3+ agent dispatch scenarios.
</success_criteria>

<output>
After completion, create `.planning/quick/260322-fyt-add-context-budget-section-to-max-router/260322-fyt-SUMMARY.md`
</output>
