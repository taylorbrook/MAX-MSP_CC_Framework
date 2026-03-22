---
phase: quick-260322-bbh
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - .planning/quick/260322-bbh-review-the-repo-and-make-suggestions-tha/REVIEW.md
autonomous: true
requirements: [REVIEW-01]

must_haves:
  truths:
    - "A comprehensive written review exists identifying specific, actionable improvements to the MAX framework's effectiveness at generating correct patches"
    - "The review covers all five dimensions: project organization, persistent issue patterns, agent/skill effectiveness, validation/critic pipeline gaps, and memory system utilization"
    - "Each finding includes a concrete recommendation with estimated impact (high/medium/low)"
  artifacts:
    - path: ".planning/quick/260322-bbh-review-the-repo-and-make-suggestions-tha/REVIEW.md"
      provides: "Comprehensive system effectiveness review with prioritized recommendations"
      min_lines: 150
  key_links: []
---

<objective>
Produce a detailed written review of the MAX framework's effectiveness at creating MAX/MSP patches, analyzing five dimensions: (1) project organization, (2) persistent issue patterns from memory/feedback, (3) agent and skill architecture effectiveness, (4) validation/critic pipeline coverage gaps, (5) memory system utilization. Each finding must include a specific actionable recommendation.

Purpose: Identify the highest-leverage improvements to reduce patch generation errors and increase first-pass correctness
Output: REVIEW.md with prioritized findings and recommendations
</objective>

<execution_context>
@~/.claude/get-shit-done/workflows/execute-plan.md
@~/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@.planning/PROJECT.md
@.planning/STATE.md
@CLAUDE.md
@src/maxpat/__init__.py
@src/maxpat/critics/__init__.py
@src/maxpat/critics/dsp_critic.py
@src/maxpat/validation.py
@src/maxpat/memory.py
@src/maxpat/hooks.py
@.claude/skills/max-router/SKILL.md
@.claude/skills/max-critic/SKILL.md
@.claude/skills/max-patch-agent/SKILL.md
@.claude/skills/max-dsp-agent/SKILL.md
@.claude/commands/max-build.md
@.claude/commands/max-iterate.md
</context>

<tasks>

<task type="auto">
  <name>Task 1: Deep analysis across all five review dimensions</name>
  <files>.planning/quick/260322-bbh-review-the-repo-and-make-suggestions-tha/REVIEW.md</files>
  <action>
Conduct a systematic review of the MAX framework by reading and analyzing the following sources, then write findings to REVIEW.md:

**Dimension 1 -- Project Organization:**
- Read the full directory structure (src/maxpat/, .claude/skills/, .claude/commands/, patches/, tests/)
- Assess: Are skills, commands, and source modules well-separated? Is there redundancy? Are there orphaned/stale files?
- Check for the 2 failing tests (test_layout inlet alignment off by 6px, test_round_trip minitaur em-dash encoding) and whether they indicate systemic issues
- Review whether the object database structure (8 separate JSON files + overrides + aliases + relationships + pd-blocklist) is optimal or creates lookup overhead

**Dimension 2 -- Persistent Issue Patterns:**
- Read ALL 13 feedback memory files in ~/.claude/projects/-Users-taylorbrook-Dev-MAX/memory/
- Categorize issues by root cause: (a) object database inaccuracy, (b) MAX API/format misunderstanding, (c) agent not loading correct context, (d) validation gap
- For each category, identify: How many issues fall in it? Are fixes reactive (memory feedback) or proactive (validation rule)? What would prevent recurrence?
- Specific issues to analyze: maxclass confusion (667 objects wrong), GenExpr syntax confusion (in1 vs in 1), bpatcher #N substitution failures, line~ comma behavior, multislider outlet confusion

**Dimension 3 -- Agent/Skill Architecture:**
- Read all 10 SKILL.md files and all 11 command files
- Assess the router dispatch model: Does keyword matching produce correct routing? Are there ambiguous cases?
- Evaluate context loading: Each agent loads different database subsets. Are there cases where an agent needs data outside its designated scope?
- Assess the multi-agent merge protocol: Is it well-defined? Are there documented failure modes?
- Check: Are the agents actually invoked as separate Claude sub-agents, or is this a single-session prompt routing pattern? Does the architecture actually achieve isolation?
- Evaluate the --full/--discuss/--research/--plan flags on /max-iterate: Are they effective or overhead?

**Dimension 4 -- Validation/Critic Pipeline Gaps:**
- Read validation.py (4-layer pipeline) and all 5 critics (dsp, structure, layout, rnbo, external)
- Map the 13 feedback issues against the validation pipeline: Which issues would the current pipeline catch? Which would slip through?
- Identify specific gaps: Does validation catch bpatcher #N compound strings? Does it catch GenExpr in1 vs in 1? Does it catch line~ comma misuse? Does it catch multislider outlet confusion?
- Assess the critic loop escalation: "no hard round limit, escalate after 5 identical findings" -- is this effective or does it waste context?
- Evaluate the gain safety critic: It checks oscillator->dac~ and MIDI->*~ but does it cover all hearing-safety scenarios?

**Dimension 5 -- Memory System Utilization:**
- Verify that ALL 10 project .max-memory/patterns.md files are empty (3 lines, placeholder only)
- The memory system code exists (memory.py, MemoryStore, MemoryEntry) but is never written to during generation
- Assess: Is the memory write-back step in /max-build and /max-iterate actually executed? Or is it documented but not implemented?
- Compare the Claude project memory (13 feedback files) vs the in-app memory system (0 entries): Why the gap?
- Recommendation: Should memory be automated (critic findings auto-stored) or manual (user-triggered)?

**Writing the REVIEW.md:**
Structure as:
1. Executive Summary (5-10 bullet points of highest-impact findings)
2. Dimension sections (each with Findings, Evidence, and Recommendations)
3. Prioritized Action Items table (impact: high/medium/low, effort: small/medium/large)
4. Two failing tests analysis

Each recommendation must be specific enough that someone could implement it without further research. Reference specific files, line numbers, and code patterns.
  </action>
  <verify>
    <automated>test -f /Users/taylorbrook/Dev/MAX/.planning/quick/260322-bbh-review-the-repo-and-make-suggestions-tha/REVIEW.md && wc -l /Users/taylorbrook/Dev/MAX/.planning/quick/260322-bbh-review-the-repo-and-make-suggestions-tha/REVIEW.md | awk '{if ($1 >= 150) print "PASS: " $1 " lines"; else print "FAIL: only " $1 " lines"}'</automated>
  </verify>
  <done>REVIEW.md exists with 150+ lines covering all five dimensions, each finding has a concrete recommendation with impact rating, and the executive summary highlights the top 5 highest-leverage improvements</done>
</task>

</tasks>

<verification>
- REVIEW.md exists and covers all 5 dimensions
- Each dimension has at least 2 specific findings with evidence
- Recommendations are actionable (reference specific files and code)
- Prioritized action items table exists with impact/effort ratings
</verification>

<success_criteria>
- Written review identifies at least 10 specific improvement opportunities
- Each recommendation is implementable without further research
- The review surfaces the root causes behind the 13 feedback memory entries, not just the symptoms
- Failing tests are analyzed for systemic implications
</success_criteria>

<output>
After completion, create `.planning/quick/260322-bbh-review-the-repo-and-make-suggestions-tha/260322-bbh-SUMMARY.md`
</output>
