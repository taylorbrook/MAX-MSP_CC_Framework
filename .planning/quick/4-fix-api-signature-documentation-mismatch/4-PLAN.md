---
phase: quick-4
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - .claude/commands/max-test.md
autonomous: true
requirements: [DOC-SYNC]

must_haves:
  truths:
    - "max-test.md command file documents save_test_results(project_dir, test_name, results_md) matching the actual Python source"
    - "max-test.md command file documents generate_test_checklist(patch_dict, patch_name, patch_path) matching the actual Python source"
  artifacts:
    - path: ".claude/commands/max-test.md"
      provides: "Corrected API signatures for testing functions"
      contains: "save_test_results(project_dir, test_name, results_md)"
  key_links:
    - from: ".claude/commands/max-test.md"
      to: "src/maxpat/testing.py"
      via: "function signature documentation"
      pattern: "save_test_results\\(project_dir"
---

<objective>
Fix the two remaining API signature mismatches in `.claude/commands/max-test.md`.

Quick task 3 fixed all SKILL.md and reference files, but missed the command file `max-test.md` which still has:
- Line 19: `generate_test_checklist(patch_dict, name, path)` -- should be `generate_test_checklist(patch_dict, patch_name, patch_path="")`
- Line 33: `save_test_results(results, project_dir)` -- should be `save_test_results(project_dir, test_name, results_md)`

Purpose: Ensure all documentation files match actual Python source signatures so agents calling these functions use the correct parameter order.
Output: Corrected max-test.md command file.
</objective>

<execution_context>
@/Users/taylorbrook/.claude/get-shit-done/workflows/execute-plan.md
@/Users/taylorbrook/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@.claude/commands/max-test.md
@src/maxpat/testing.py
</context>

<tasks>

<task type="auto">
  <name>Task 1: Fix API signatures in max-test.md command file</name>
  <files>.claude/commands/max-test.md</files>
  <action>
In `.claude/commands/max-test.md`, make these two corrections:

1. Line 19: Change `generate_test_checklist(patch_dict, name, path)` to `generate_test_checklist(patch_dict, patch_name, patch_path="")` -- parameter names must match the source definition in `src/maxpat/testing.py` line 12-13.

2. Line 33: Change `save_test_results(results, project_dir)` to `save_test_results(project_dir, test_name, results_md)` -- the parameter order is wrong and missing the `test_name` parameter. Must match `src/maxpat/testing.py` line 137-138.

Do NOT change any other content in the file. These are the only two lines that need correction.
  </action>
  <verify>
    <automated>grep -n "generate_test_checklist(patch_dict, patch_name, patch_path" /Users/taylorbrook/Dev/MAX/.claude/commands/max-test.md && grep -n "save_test_results(project_dir, test_name, results_md)" /Users/taylorbrook/Dev/MAX/.claude/commands/max-test.md && echo "PASS: Both signatures correct"</automated>
  </verify>
  <done>Both function signatures in max-test.md exactly match the Python source definitions in src/maxpat/testing.py</done>
</task>

</tasks>

<verification>
- `grep "save_test_results(project_dir, test_name, results_md)" .claude/commands/max-test.md` returns a match
- `grep "generate_test_checklist(patch_dict, patch_name, patch_path" .claude/commands/max-test.md` returns a match
- No occurrences of old signatures remain: `grep "save_test_results(results" .claude/commands/max-test.md` returns nothing
</verification>

<success_criteria>
All function signatures in .claude/commands/max-test.md match the actual Python source in src/maxpat/testing.py. No documentation file in the project contains stale API signatures for save_test_results or generate_test_checklist.
</success_criteria>

<output>
After completion, create `.planning/quick/4-fix-api-signature-documentation-mismatch/4-SUMMARY.md`
</output>
