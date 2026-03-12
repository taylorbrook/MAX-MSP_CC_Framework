---
phase: quick-2
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - .planning/quick/2-review-the-effectiveness-of-the-agents/AGENT-REVIEW.md
autonomous: true
requirements: [QUICK-2]
must_haves:
  truths:
    - "User has a clear assessment of each agent's design quality, coverage gaps, and redundancies"
    - "User knows which agents are strong, which are weak, and what concrete improvements would have the highest impact"
    - "Assessment is grounded in actual file analysis, not abstract opinion"
  artifacts:
    - path: ".planning/quick/2-review-the-effectiveness-of-the-agents/AGENT-REVIEW.md"
      provides: "Comprehensive agent effectiveness review with per-agent assessments and prioritized recommendations"
  key_links: []
---

<objective>
Review the 10-agent system (6 specialists + router + critic + memory + lifecycle) for effectiveness, identifying strengths, weaknesses, coverage gaps, redundancies, and concrete improvement opportunities.

Purpose: The user has shipped v1.0 of the MAX development framework (16,557 LOC, 624 tests, 2,015 objects, 10 agents) and wants to assess agent quality before planning the next milestone.

Output: AGENT-REVIEW.md with per-agent assessments and a prioritized recommendation list.
</objective>

<execution_context>
@/Users/taylorbrook/.claude/get-shit-done/workflows/execute-plan.md
@/Users/taylorbrook/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@.planning/PROJECT.md
@.planning/STATE.md
@CLAUDE.md

Agents to review (all under .claude/skills/):
- max-router (orchestration + dispatch)
- max-critic (generate-review-revise loop)
- max-patch-agent (control-rate patch generation)
- max-dsp-agent (GenExpr + MSP signal chains)
- max-rnbo-agent (RNBO export)
- max-js-agent (js V8 + Node for Max)
- max-ext-agent (C++ externals via Min-DevKit)
- max-ui-agent (presentation mode + layout)
- max-memory-agent (persistent pattern memory)
- max-lifecycle (project management + testing)

Reference files:
- .claude/skills/max-router/references/dispatch-rules.md
- .claude/skills/max-router/references/merge-protocol.md
- .claude/skills/max-critic/references/critic-protocol.md
- .claude/skills/*/BOUNDARIES.md (6 specialist agents)
- .claude/skills/max-lifecycle/references/*.md (3 reference docs)

Python backing code:
- src/maxpat/ (patcher.py, codegen.py, code_validation.py, layout.py, memory.py, project.py, testing.py, hooks.py, validation.py, rnbo.py, rnbo_validation.py, externals.py, ext_validation.py, sizing.py, db_lookup.py, defaults.py, maxclass_map.py)
- src/maxpat/critics/ (__init__.py, base.py, dsp_critic.py, structure_critic.py, rnbo_critic.py, ext_critic.py)
- tests/test_agent_skills.py (structural tests for skill files)

Commands (10 slash commands under .claude/commands/):
max-build.md, max-discuss.md, max-iterate.md, max-memory.md, max-new.md, max-research.md, max-status.md, max-switch.md, max-test.md, max-verify.md
</context>

<tasks>

<task type="auto">
  <name>Task 1: Deep analysis of agent system architecture and per-agent effectiveness</name>
  <files>.planning/quick/2-review-the-effectiveness-of-the-agents/AGENT-REVIEW.md</files>
  <action>
Conduct a thorough review of all 10 agents by reading and analyzing:

**For each of the 10 agents, assess:**

1. **SKILL.md quality** -- Is the prompt well-structured? Does it give Claude enough specificity to act without interpretation? Are the "When to Use" / "When NOT to Use" sections clear and complete? Are Python API references accurate (cross-check function signatures against actual src/maxpat/ source files)?

2. **Context loading instructions** -- Are agents told to load the RIGHT files? Are they told NOT to load files outside their domain? Is the loading order logical (do they read what they need before generating)?

3. **Capability coverage** -- Does the agent's documented capability set match what the backing Python code actually provides? Are there Python functions that exist but no agent references? Are there agent capabilities claimed with no Python backing?

4. **Boundary clarity** -- For the 6 specialists with BOUNDARIES.md: Are boundaries crisp? Could an LLM get confused about which agent handles a cross-domain task? Are handoff points well-defined?

5. **Integration quality** -- How well does each agent integrate with the router dispatch, critic loop, and memory system? Are there dead ends where an agent produces output but nothing validates it?

**Cross-cutting analysis:**

6. **Router dispatch effectiveness** -- Is keyword-based dispatch robust enough? What task descriptions would cause misrouting? Is the ambiguity resolution scheme sound?

7. **Critic coverage gaps** -- There are 4 critic modules (DSP, structure, RNBO, external). Is there coverage for all agent outputs? What about js/N4M code -- does anything review it beyond syntax?

8. **Memory integration gaps** -- Does every agent that should use memory actually reference it in context loading? Is the write-back protocol realistic?

9. **Multi-agent merge realism** -- The merge protocol describes clean handoffs. In practice, would Claude actually follow the structured dict output format? Is the I/O verification step enforceable?

10. **Test coverage of agent behavior** -- test_agent_skills.py tests file structure, not behavior. Are there gaps where an agent could drift (wrong function signatures, stale references) without tests catching it?

**To perform this analysis, read:**
- All 10 SKILL.md files (already in context from planning)
- All BOUNDARIES.md files
- All reference docs (dispatch-rules, merge-protocol, critic-protocol, project-structure, status-tracking, test-protocol)
- Key Python source files to cross-check API signatures: src/maxpat/__init__.py, src/maxpat/patcher.py (Box, Patcher signatures), src/maxpat/codegen.py (build_genexpr, generate_gendsp, generate_n4m_script, generate_js_script), src/maxpat/code_validation.py (validate_genexpr, validate_js, validate_n4m), src/maxpat/rnbo.py (add_rnbo, generate_rnbo_wrapper, parse_genexpr_params, RNBODatabase), src/maxpat/externals.py (scaffold_external, generate_external_code, build_external, setup_min_devkit, generate_help_patch), src/maxpat/memory.py (MemoryStore, MemoryEntry), src/maxpat/project.py (create_project, get_active_project, etc.), src/maxpat/testing.py (generate_test_checklist), src/maxpat/hooks.py (write_patch, generate_patch), src/maxpat/layout.py (apply_layout)
- The 10 command files under .claude/commands/ to check if commands correctly invoke agents
- tests/test_agent_skills.py to assess structural test coverage

**Write AGENT-REVIEW.md with this structure:**

```markdown
# Agent System Effectiveness Review

## Executive Summary
[3-5 sentences: overall assessment, biggest strengths, biggest gaps]

## Per-Agent Assessments

### 1. max-router
- **Effectiveness:** [High/Medium/Low]
- **Strengths:** [bullet points]
- **Weaknesses:** [bullet points]
- **API accuracy:** [any signature mismatches found]
- **Recommendation:** [specific action or "no changes needed"]

[Repeat for all 10 agents]

## Cross-Cutting Findings

### Dispatch & Routing
[Assessment of router + dispatch rules]

### Critic Coverage
[Which agents have critic coverage, which don't]

### Memory Integration
[Which agents use memory, gaps]

### Multi-Agent Coordination
[Realism of merge protocol, gaps]

### Test Coverage
[What tests catch, what they miss]

## Prioritized Recommendations

| Priority | Area | Recommendation | Impact | Effort |
|----------|------|---------------|--------|--------|
| 1 | ... | ... | High/Med/Low | High/Med/Low |
| 2 | ... | ... | ... | ... |
[...]

## Summary Statistics

- Agents with no issues found: N/10
- Agents with minor issues: N/10
- Agents with significant gaps: N/10
- Total recommendations: N
- High-priority recommendations: N
```
  </action>
  <verify>
    <automated>test -f .planning/quick/2-review-the-effectiveness-of-the-agents/AGENT-REVIEW.md && wc -l .planning/quick/2-review-the-effectiveness-of-the-agents/AGENT-REVIEW.md | awk '{if ($1 > 100) print "PASS: " $1 " lines"; else print "FAIL: only " $1 " lines"}'</automated>
  </verify>
  <done>AGENT-REVIEW.md exists with per-agent assessments for all 10 agents, cross-cutting findings across 5 dimensions, and a prioritized recommendation table. Review is grounded in actual source code cross-referencing, not just SKILL.md surface reading.</done>
</task>

</tasks>

<verification>
- AGENT-REVIEW.md covers all 10 agents individually
- Cross-cutting analysis addresses dispatch, critics, memory, multi-agent, and tests
- Recommendations are prioritized and actionable (not vague)
- API signature cross-checks are documented (matches and mismatches)
</verification>

<success_criteria>
- AGENT-REVIEW.md is comprehensive (100+ lines) and grounded in source analysis
- Every agent has a clear High/Medium/Low effectiveness rating
- Recommendations are specific enough to act on (not "improve X" but "add Y to Z because W")
- User can use this review to prioritize v1.1 work
</success_criteria>

<output>
After completion, create `.planning/quick/2-review-the-effectiveness-of-the-agents/2-SUMMARY.md`
</output>
