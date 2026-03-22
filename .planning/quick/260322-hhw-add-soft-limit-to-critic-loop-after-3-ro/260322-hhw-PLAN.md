---
phase: quick-260322-hhw
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - .claude/skills/max-critic/SKILL.md
  - .claude/skills/max-critic/references/critic-protocol.md
autonomous: true
requirements: [SOFT-LIMIT]

must_haves:
  truths:
    - "After 3 rounds of revision, the critic loop pauses and asks the user whether to continue or accept"
    - "The pause includes a summary of all findings across all rounds"
    - "The existing 5-identical-finding escalation rule is unchanged"
    - "If the user says continue, the loop resumes normally"
  artifacts:
    - path: ".claude/skills/max-critic/SKILL.md"
      provides: "Updated critic loop summary with soft limit mention"
      contains: "soft limit"
    - path: ".claude/skills/max-critic/references/critic-protocol.md"
      provides: "Full soft limit specification with examples"
      contains: "Soft Round Limit"
  key_links:
    - from: ".claude/skills/max-critic/SKILL.md"
      to: ".claude/skills/max-critic/references/critic-protocol.md"
      via: "SKILL.md references critic-protocol.md for full spec"
      pattern: "references/critic-protocol.md"
---

<objective>
Add a soft round limit to the critic loop: after 3 total revision rounds, log a cumulative summary of all findings across all rounds and ask the user whether to continue revising or accept the current state. This prevents unbounded context consumption when novel findings keep appearing each round.

Purpose: The existing escalation rule (5 identical findings) only catches stuck loops. A loop that discovers new issues each round runs indefinitely, consuming context. The soft limit catches this case.
Output: Updated SKILL.md and critic-protocol.md with the soft limit specification.
</objective>

<execution_context>
@~/.claude/get-shit-done/workflows/execute-plan.md
@~/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@.claude/skills/max-critic/SKILL.md
@.claude/skills/max-critic/references/critic-protocol.md
</context>

<tasks>

<task type="auto">
  <name>Task 1: Add soft round limit to critic-protocol.md</name>
  <files>.claude/skills/max-critic/references/critic-protocol.md</files>
  <action>
Add a new section "## Soft Round Limit" BEFORE the existing "## Escalation Rules" section. This section specifies:

1. After completing Round 3 (i.e., 3 total revision rounds, not counting the initial generation), the critic loop pauses before requesting further revisions.

2. At the pause, the critic must:
   - Log a cumulative summary table of all findings across all rounds, showing: round number, finding text, severity, and resolution status (resolved/persists/new)
   - Present the summary to the user
   - Ask: "3 revision rounds completed. Continue revising or accept current state?"
   - Options: "continue" (resume loop normally) or "accept" (proceed with current output, treating remaining blockers as warnings for annotation)

3. If the user says "continue", the loop resumes with no further soft-limit pauses (the next stop would be the existing 5-identical-finding escalation).

4. If the user says "accept", remaining blockers are downgraded to warnings, annotated inline, and output is approved.

Also update the "## Escalation Rules" section:
- In the paragraph that starts "The loop runs until clean with no hard round cap", change it to clarify: "The loop runs until clean. A soft limit pauses after 3 rounds for user confirmation (see above). The 5-identical-finding escalation below is a separate mechanism."
- Keep all existing escalation content unchanged otherwise.

Add an example under "## Examples" showing the soft limit in action:

```
### Soft Limit Pause
Round 1: [blocker: missing dac~]
-> Generator adds dac~
Round 2: [blocker: gain safety on *~ inlet]
-> Generator adds gain scaling
Round 3: [blocker: fan-out without trigger]
-> Soft limit reached. Summary:
   | Round | Finding | Status |
   |-------|---------|--------|
   | 1 | missing dac~ | resolved |
   | 2 | gain safety on *~ inlet | resolved |
   | 3 | fan-out without trigger | persists |
-> User: "accept"
-> Fan-out finding downgraded to warning, annotated, output approved
```
  </action>
  <verify>
    <automated>grep -c "Soft Round Limit" .claude/skills/max-critic/references/critic-protocol.md | grep -q "1" && grep -c "3 revision rounds" .claude/skills/max-critic/references/critic-protocol.md | grep -q "1" && echo "PASS"</automated>
  </verify>
  <done>critic-protocol.md contains the soft round limit section with specification, integration with existing escalation rules, and an example</done>
</task>

<task type="auto">
  <name>Task 2: Update SKILL.md critic loop summary</name>
  <files>.claude/skills/max-critic/SKILL.md</files>
  <action>
Update the "## Critic Loop Protocol" section's summary list. Currently lines 38-44 read:

```
1. Generator produces output
2. Critic runs `review_patch()` on the output
3. If blockers found: format findings, request revision from generator
4. If only warnings/notes: annotate inline and proceed
5. If clean (no findings): approve output
6. Loop continues until clean -- there is NO hard round limit
7. Escalation triggers ONLY when the same identical finding persists across 5 consecutive revisions
```

Replace with:

```
1. Generator produces output
2. Critic runs `review_patch()` on the output
3. If blockers found: format findings, request revision from generator
4. If only warnings/notes: annotate inline and proceed
5. If clean (no findings): approve output
6. **Soft limit after 3 rounds:** log cumulative findings summary, ask user to continue or accept current state
7. Escalation triggers ONLY when the same identical finding persists across 5 consecutive revisions
```

This replaces the "NO hard round limit" language with the soft limit description. The key distinction: this is a soft limit (user can choose to continue), not a hard cap.
  </action>
  <verify>
    <automated>grep -c "Soft limit after 3 rounds" .claude/skills/max-critic/SKILL.md | grep -q "1" && ! grep -q "NO hard round limit" .claude/skills/max-critic/SKILL.md && echo "PASS"</automated>
  </verify>
  <done>SKILL.md summary list updated to mention the soft 3-round limit; old "NO hard round limit" language removed</done>
</task>

</tasks>

<verification>
- critic-protocol.md has "Soft Round Limit" section with full spec
- critic-protocol.md example section includes soft limit scenario
- critic-protocol.md escalation section updated to reference the soft limit
- SKILL.md summary mentions soft limit after 3 rounds
- SKILL.md no longer says "NO hard round limit"
- Existing 5-identical-finding escalation rule is preserved in both files
</verification>

<success_criteria>
Both SKILL.md and critic-protocol.md updated. The soft 3-round limit is specified clearly: pause, summarize, ask user. The existing 5-identical-finding escalation is untouched. A reader of either file understands both mechanisms and how they interact.
</success_criteria>

<output>
After completion, create `.planning/quick/260322-hhw-add-soft-limit-to-critic-loop-after-3-ro/260322-hhw-SUMMARY.md`
</output>
