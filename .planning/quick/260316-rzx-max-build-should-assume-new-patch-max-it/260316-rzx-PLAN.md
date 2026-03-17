---
phase: quick
plan: 260316-rzx
type: execute
wave: 1
depends_on: []
files_modified:
  - .claude/commands/max-build.md
autonomous: true
requirements: [quick-task]

must_haves:
  truths:
    - "/max-build no longer checks for existing .maxpat or offers redirect to /max-iterate"
    - "/max-build proceeds directly to routing after loading project context and memory"
    - "Step numbering in max-build.md is sequential with no gaps"
  artifacts:
    - path: ".claude/commands/max-build.md"
      provides: "Updated build command without existing-patch check"
  key_links: []
---

<objective>
Remove the existing-patch detection logic from /max-build so it always assumes a fresh build.

Purpose: /max-build should always create a new patch. If users want to edit an existing patch, /max-iterate is the correct command. The current step 4 adds unnecessary friction by asking users to confirm intent when they already chose /max-build.

Output: Updated .claude/commands/max-build.md with step 4 removed and remaining steps renumbered.
</objective>

<execution_context>
@/Users/taylorbrook/.claude/get-shit-done/workflows/execute-plan.md
@/Users/taylorbrook/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@.claude/commands/max-build.md
</context>

<tasks>

<task type="auto">
  <name>Task 1: Remove existing-patch check from /max-build</name>
  <files>.claude/commands/max-build.md</files>
  <action>
    In `.claude/commands/max-build.md`:

    1. Delete step 4 entirely (lines 21-24), which reads:
       ```
       4. **Check for existing .maxpat** -- if the target `.maxpat` file already exists in `generated/`, warn the user and offer two options:
          - Overwrite: proceed with a fresh build (previous file is replaced)
          - Redirect: switch to `/max-iterate` to modify the existing patch instead
       ```

    2. Renumber the remaining steps:
       - Old step 5 ("Route through max-router") becomes step 4
       - Old step 6 ("Specialist generation") becomes step 5
       - Old step 7 ("Critic loop") becomes step 6
       - Old step 8 ("Write output") becomes step 7
       - Old step 9 ("Write-back memory") becomes step 8
       - Old step 10 ("Update status") becomes step 9

    No other content changes needed. The README.md Quick Start section does not mention existing-patch redirect behavior, so no README changes are required.
  </action>
  <verify>
    <automated>grep -c "Check for existing" .claude/commands/max-build.md | grep -q "^0$" && grep -c "Redirect.*max-iterate" .claude/commands/max-build.md | grep -q "^0$" && echo "PASS: step 4 removed" || echo "FAIL: step 4 still present"</automated>
  </verify>
  <done>
    - Step 4 (existing .maxpat check) is completely removed from max-build.md
    - Steps are numbered 1-9 sequentially with no gaps
    - All other content is unchanged
  </done>
</task>

</tasks>

<verification>
- max-build.md has exactly 9 numbered steps (was 10)
- No mention of "Check for existing .maxpat" or redirect to /max-iterate in the Behavior section
- Step numbering is sequential: 1, 2, 3, 4, 5, 6, 7, 8, 9
- All remaining step content is identical to original
</verification>

<success_criteria>
/max-build command file no longer contains any existing-patch detection or redirect logic. The command always proceeds with a fresh build regardless of whether a .maxpat already exists in generated/.
</success_criteria>

<output>
After completion, create `.planning/quick/260316-rzx-max-build-should-assume-new-patch-max-it/260316-rzx-SUMMARY.md`
</output>
