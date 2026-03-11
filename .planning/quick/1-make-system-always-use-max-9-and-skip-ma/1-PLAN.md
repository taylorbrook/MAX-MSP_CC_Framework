---
phase: quick
plan: 1
type: execute
wave: 1
depends_on: []
files_modified:
  - CLAUDE.md
  - .claude/commands/max-new.md
  - .claude/commands/max-research.md
  - .claude/skills/max-lifecycle/SKILL.md
  - .claude/skills/max-lifecycle/references/project-structure.md
autonomous: true
requirements: [QUICK-01]
must_haves:
  truths:
    - "MAX 9 is the only supported version across all system files"
    - "New project kickoff flow does not ask about MAX version"
    - "Research command does not reference MAX 8 vs 9 comparison"
    - "CLAUDE.md states MAX 9 is mandatory, not conditional"
  artifacts:
    - path: "CLAUDE.md"
      provides: "Mandatory MAX 9 version policy"
      contains: "MAX 9 is the required version"
    - path: ".claude/commands/max-new.md"
      provides: "Kickoff flow without version question"
    - path: ".claude/commands/max-research.md"
      provides: "Research output without MAX 8 vs 9 notes"
    - path: ".claude/skills/max-lifecycle/SKILL.md"
      provides: "Lifecycle skill without version question"
    - path: ".claude/skills/max-lifecycle/references/project-structure.md"
      provides: "Project structure without target version field"
  key_links: []
---

<objective>
Remove all MAX version selection logic and make MAX 9 the hardcoded, mandatory target version across commands, skills, and project instructions.

Purpose: Eliminate unnecessary version question during new project kickoff and simplify the system by standardizing on MAX 9.
Output: Five updated files with consistent MAX 9-only policy.
</objective>

<execution_context>
@/Users/taylorbrook/.claude/get-shit-done/workflows/execute-plan.md
@/Users/taylorbrook/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@CLAUDE.md
@.claude/commands/max-new.md
@.claude/commands/max-research.md
@.claude/skills/max-lifecycle/SKILL.md
@.claude/skills/max-lifecycle/references/project-structure.md
</context>

<tasks>

<task type="auto">
  <name>Task 1: Make MAX 9 mandatory in CLAUDE.md and commands</name>
  <files>CLAUDE.md, .claude/commands/max-new.md, .claude/commands/max-research.md</files>
  <action>
1. In `CLAUDE.md`, replace the "Version Compatibility" section (lines 145-150) with:
   - Remove the bullet "When generating patches, note the target MAX version and avoid using objects above that version"
   - Remove the bullet "If no target version is specified, assume MAX 9 (current)"
   - Replace with: "All patches target MAX 9. This is the required version for all projects -- do not ask users to choose a version."
   - Keep the existing bullets about `min_version`, MAX 9 objects (`array.*`, `string.*`, `abl.*`), and MC objects as informational context.

2. In `.claude/commands/max-new.md`, line 24:
   - Remove the entire question "What is the target MAX version? (8, 9, or latest)" from the kickoff questions list
   - Change "ask 3-5 clarifying questions" to "ask 3-4 clarifying questions" on line 20
   - The remaining questions (audio/MIDI, signal flow, UI/presentation, specific objects) stay as-is

3. In `.claude/commands/max-research.md`, line 28:
   - Change "Any version compatibility notes (MAX 8 vs 9)" to "Any version compatibility notes for MAX 9 objects used"
   - This keeps version notes relevant (e.g., noting when a MAX 9-only object is used) without implying MAX 8 is supported
  </action>
  <verify>
    <automated>grep -n "target MAX version" CLAUDE.md .claude/commands/max-new.md .claude/commands/max-research.md; echo "EXIT: $?"; grep -c "MAX 9" CLAUDE.md</automated>
  </verify>
  <done>"target MAX version" no longer appears as a question in max-new.md. CLAUDE.md states MAX 9 is mandatory. max-research.md references MAX 9 without MAX 8 comparison.</done>
</task>

<task type="auto">
  <name>Task 2: Remove version references from lifecycle skill and project structure</name>
  <files>.claude/skills/max-lifecycle/SKILL.md, .claude/skills/max-lifecycle/references/project-structure.md</files>
  <action>
1. In `.claude/skills/max-lifecycle/SKILL.md`, line 39:
   - Change "ask clarifying questions about audio/MIDI requirements, signal flow, UI needs, target MAX version" to "ask clarifying questions about audio/MIDI requirements, signal flow, UI needs"
   - Simply remove ", target MAX version" from the end of that clause

2. In `.claude/skills/max-lifecycle/references/project-structure.md`, line 39:
   - Remove the line "- Target MAX version" from the context.md content list
   - The remaining items (Project description and goals, Audio/MIDI requirements, Signal flow description, UI needs, specific object preferences) stay as-is
  </action>
  <verify>
    <automated>grep -n "target MAX version" .claude/skills/max-lifecycle/SKILL.md .claude/skills/max-lifecycle/references/project-structure.md; echo "EXIT: $?"; grep -n "Target MAX version" .claude/skills/max-lifecycle/references/project-structure.md; echo "EXIT: $?"</automated>
  </verify>
  <done>"target MAX version" and "Target MAX version" no longer appear in lifecycle skill or project structure reference files.</done>
</task>

</tasks>

<verification>
Run across all modified files to confirm no stale version-choice references remain:
```bash
grep -rn "target MAX version\|MAX 8 vs 9\|8, 9, or latest" CLAUDE.md .claude/commands/ .claude/skills/max-lifecycle/
```
Should return zero matches.

Confirm MAX 9 is stated as mandatory in CLAUDE.md:
```bash
grep -n "required version\|mandatory" CLAUDE.md
```
Should return at least one match in the Version Compatibility section.
</verification>

<success_criteria>
- Zero occurrences of version-selection language ("target MAX version", "8, 9, or latest", "MAX 8 vs 9") across all five files
- CLAUDE.md Version Compatibility section states MAX 9 as the required version without conditional language
- New project kickoff flow has 4 questions (version question removed)
- Research command notes MAX 9 compatibility without MAX 8 comparison
</success_criteria>

<output>
After completion, create `.planning/quick/1-make-system-always-use-max-9-and-skip-ma/1-SUMMARY.md`
</output>
