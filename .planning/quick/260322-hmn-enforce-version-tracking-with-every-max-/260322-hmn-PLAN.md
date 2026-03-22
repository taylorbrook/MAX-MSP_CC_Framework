---
phase: quick-260322-hmn
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - src/maxpat/project.py
  - tests/test_project.py
  - .claude/commands/max-iterate.md
  - .claude/skills/references/shared-capabilities.md
autonomous: true
requirements: [VER-01, VER-02, VER-03]

must_haves:
  truths:
    - "Every max-iterate run produces a version comment in the patch"
    - "Existing version comments are updated in place rather than duplicated"
    - "Version bump happens before comment update so the comment shows the new version"
  artifacts:
    - path: "src/maxpat/project.py"
      provides: "update_version_comment() function"
      contains: "def update_version_comment"
    - path: "tests/test_project.py"
      provides: "Tests for update_version_comment"
      contains: "TestUpdateVersionComment"
    - path: ".claude/commands/max-iterate.md"
      provides: "Hard version tracking steps"
      contains: "update_version_comment"
  key_links:
    - from: ".claude/commands/max-iterate.md"
      to: "src/maxpat/project.py"
      via: "update_version_comment import"
      pattern: "update_version_comment"
    - from: "src/maxpat/project.py"
      to: "src/maxpat/patcher.py"
      via: "find_boxes + add_comment API"
      pattern: "find_boxes.*maxclass.*comment"
---

<objective>
Add `update_version_comment()` to project.py and make version tracking a hard requirement in max-iterate.

Purpose: Every patch iteration should embed the current version as a visible comment in the patch, and versions.json must always be bumped. Currently step 17 is a soft instruction that agents can skip.
Output: New function with tests, updated max-iterate steps, updated shared-capabilities.md
</objective>

<execution_context>
@~/.claude/get-shit-done/workflows/execute-plan.md
@~/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@src/maxpat/project.py
@src/maxpat/patcher.py (add_comment at line 489, find_boxes at line 1192)
@tests/test_project.py
@.claude/commands/max-iterate.md
@.claude/skills/references/shared-capabilities.md
</context>

<tasks>

<task type="auto" tdd="true">
  <name>Task 1: Add update_version_comment() and tests</name>
  <files>src/maxpat/project.py, tests/test_project.py</files>
  <behavior>
    - Test 1: update_version_comment on empty patcher adds a comment box with text "v0.1.0" (given version string)
    - Test 2: comment is positioned in top-right area (x >= 500, y <= 30 relative to default 640-wide patcher)
    - Test 3: update_version_comment on patcher with existing version comment (text matching r"^v\d+\.\d+\.\d+$") updates the text in place, does not add a second comment
    - Test 4: update_version_comment on patcher with non-version comments leaves them untouched and still adds the version comment
    - Test 5: returns the Box object for the version comment
  </behavior>
  <action>
    Add `update_version_comment(patcher, version_string)` to `src/maxpat/project.py`:

    1. Import `re` (already imported) and type hint for Patcher (use TYPE_CHECKING block to avoid circular import -- `from __future__ import annotations` is already present, add `from src.maxpat.patcher import Patcher` inside TYPE_CHECKING).
    2. Define `_VERSION_COMMENT_RE = re.compile(r"^v\d+\.\d+\.\d+$")` at module level.
    3. The function signature: `def update_version_comment(patcher: Patcher, version: str) -> Box:`
    4. Search for existing version comment: `matches = patcher.find_boxes(maxclass="comment")` then filter by `_VERSION_COMMENT_RE.match(box.text)`.
    5. If found: update `box.text = f"v{version}"` on the first match, return it.
    6. If not found: call `patcher.add_comment(f"v{version}", x=550.0, y=10.0)` and return the new box.
    7. The version string passed in should NOT have the "v" prefix -- the function adds it. So `update_version_comment(p, "0.1.0")` produces comment text "v0.1.0".

    Add `TestUpdateVersionComment` class to `tests/test_project.py` with the 5 tests above. Import `update_version_comment` in the test imports. Tests should create a Patcher instance directly (no need for tmp_path/project structure -- this is a pure in-memory Patcher operation).
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python -m pytest tests/test_project.py::TestUpdateVersionComment -x -v</automated>
  </verify>
  <done>update_version_comment() exists in project.py, all 5 tests pass, existing tests still pass</done>
</task>

<task type="auto">
  <name>Task 2: Harden max-iterate version steps and update shared-capabilities</name>
  <files>.claude/commands/max-iterate.md, .claude/skills/references/shared-capabilities.md</files>
  <action>
    **max-iterate.md** -- Replace steps 16-17 with explicit, ordered version tracking. The new steps 16-18 should be:

    Step 16 (was "Save patch"): **Bump version** -- call `bump_version(project_dir, "patch", description)` to get the new version string. Use `"minor"` for significant reworks, `"major"` for breaking changes.

    Step 17 (new): **Embed version comment** -- call `update_version_comment(patcher, new_version)` to add or update the version comment box in the patch. This MUST happen after bump (to get the new string) and before save (so the comment is in the saved file).

    Step 18 (was step 16): **Save patch** -- `save_patch_roundtrip(patcher.to_dict(), path, original_text)`.

    Step 19 (was step 18): **Update progress** -- same as before.

    Update the Python Modules section to add `update_version_comment` to the import from `src.maxpat.project`.

    Add a note after step 17: "The version comment is a visible `v0.1.0`-style comment placed in the top-right of the patch. Agents MUST NOT skip this step."

    **shared-capabilities.md** -- Add a new section "## Version Comment" after the "Edit Workflow" section:

    ```
    ## Version Comment

    - `from src.maxpat.project import update_version_comment`
    - `update_version_comment(patcher, version_string)` -- adds or updates a `vX.Y.Z` comment in top-right of patch
    - Existing version comments are updated in place (no duplicates)
    - Called automatically by `/max-iterate` after version bump, before save
    ```
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && grep -q "update_version_comment" .claude/commands/max-iterate.md && grep -q "update_version_comment" .claude/skills/references/shared-capabilities.md && echo "PASS" || echo "FAIL"</automated>
  </verify>
  <done>max-iterate steps 16-19 enforce bump -> comment -> save ordering. shared-capabilities.md documents the version comment pattern. Python Modules import list updated.</done>
</task>

</tasks>

<verification>
- `python -m pytest tests/test_project.py -x -v` -- all project tests pass (old + new)
- `grep "update_version_comment" src/maxpat/project.py` shows the function exists
- `grep "update_version_comment" .claude/commands/max-iterate.md` confirms it's referenced
- max-iterate step ordering is bump -> comment -> save (not save -> bump)
</verification>

<success_criteria>
- update_version_comment() function exists and handles both create and update paths
- 5 new tests pass in TestUpdateVersionComment
- max-iterate enforces version bump + comment as hard steps (not optional)
- Step ordering is correct: bump version -> update comment -> save patch
- shared-capabilities.md documents the version comment API
</success_criteria>

<output>
After completion, create `.planning/quick/260322-hmn-enforce-version-tracking-with-every-max-/260322-hmn-SUMMARY.md`
</output>
