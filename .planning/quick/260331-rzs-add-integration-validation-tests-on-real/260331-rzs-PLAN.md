---
phase: quick-260331-rzs
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - src/maxpat/utils.py
  - src/maxpat/validation.py
  - src/maxpat/critics/dsp_critic.py
  - src/maxpat/critics/structure_critic.py
  - tests/test_integration_patches.py
autonomous: true
requirements: [QUICK-260331-RZS]

must_haves:
  truths:
    - "All 18 patches/*/generated/*.maxpat files pass validate_patch() with zero errors"
    - "All 18 patches pass all 5 critics (DSP, structure, layout, RNBO, external) via review_patch() with zero blockers"
    - "_get_box_name exists once in src/maxpat/utils.py and is imported by all consumers"
  artifacts:
    - path: "src/maxpat/utils.py"
      provides: "Shared get_box_name helper"
      exports: ["get_box_name"]
    - path: "tests/test_integration_patches.py"
      provides: "Parametrized integration tests on real patches"
      min_lines: 40
  key_links:
    - from: "src/maxpat/validation.py"
      to: "src/maxpat/utils.py"
      via: "import get_box_name"
      pattern: "from src\\.maxpat\\.utils import get_box_name"
    - from: "src/maxpat/critics/dsp_critic.py"
      to: "src/maxpat/utils.py"
      via: "import get_box_name"
      pattern: "from src\\.maxpat\\.utils import get_box_name"
    - from: "src/maxpat/critics/structure_critic.py"
      to: "src/maxpat/utils.py"
      via: "import get_box_name"
      pattern: "from src\\.maxpat\\.utils import get_box_name"
---

<objective>
Extract the duplicated `_get_box_name()` helper into `src/maxpat/utils.py`, then add parametrized integration tests that run `validate_patch()` and `review_patch()` on every real `.maxpat` file in `patches/*/generated/`.

Purpose: Eliminate code duplication (3 identical copies) and establish a regression safety net ensuring generated patches remain valid.
Output: `src/maxpat/utils.py` with shared helper, updated imports in 3 files, new integration test file.
</objective>

<execution_context>
@$HOME/.claude/get-shit-done/workflows/execute-plan.md
@$HOME/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@src/maxpat/utils.py (to be created)
@src/maxpat/validation.py
@src/maxpat/critics/dsp_critic.py
@src/maxpat/critics/structure_critic.py
@src/maxpat/critics/__init__.py
@src/maxpat/critics/base.py
</context>

<tasks>

<task type="auto">
  <name>Task 1: Extract get_box_name to shared utils module</name>
  <files>src/maxpat/utils.py, src/maxpat/validation.py, src/maxpat/critics/dsp_critic.py, src/maxpat/critics/structure_critic.py</files>
  <action>
1. Create `src/maxpat/utils.py` with a single public function `get_box_name(box: dict) -> str` (no leading underscore -- it is now a shared API). The body is identical to the existing `_get_box_name`:
   - If maxclass is "newobj", return first word of text (or "" if empty).
   - Otherwise return maxclass.

2. In `src/maxpat/validation.py`:
   - Add `from src.maxpat.utils import get_box_name` near the top imports.
   - Delete the `_get_box_name` function definition (lines ~524-532).
   - Replace all calls to `_get_box_name(` with `get_box_name(` throughout the file.

3. In `src/maxpat/critics/dsp_critic.py`:
   - Add `from src.maxpat.utils import get_box_name` near the top imports.
   - Delete the `_get_box_name` function definition (lines ~169-177).
   - Replace all calls to `_get_box_name(` with `get_box_name(` throughout the file.

4. In `src/maxpat/critics/structure_critic.py`:
   - Add `from src.maxpat.utils import get_box_name` near the top imports.
   - Delete the `_get_box_name` function definition (lines ~64-72).
   - Replace all calls to `_get_box_name(` with `get_box_name(` throughout the file.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python -m pytest tests/test_validation.py tests/test_critics.py -x -q</automated>
  </verify>
  <done>_get_box_name no longer exists in any of the 3 files. get_box_name lives only in utils.py. All existing validation and critic tests pass.</done>
</task>

<task type="auto" tdd="true">
  <name>Task 2: Add parametrized integration tests on real patches</name>
  <files>tests/test_integration_patches.py</files>
  <behavior>
    - Test 1 (parametrized): For each .maxpat in patches/*/generated/, json.load succeeds + validate_patch() returns zero errors (warnings/info/fixed OK).
    - Test 2 (parametrized): For each .maxpat in patches/*/generated/, review_patch() returns zero blockers.
  </behavior>
  <action>
Create `tests/test_integration_patches.py`:

1. Use `pathlib.Path` to glob `patches/*/generated/*.maxpat` relative to repo root. Build a list of Path objects.

2. Create a module-scoped `db` fixture returning `ObjectDatabase()`.

3. Create a parametrized test `test_validate_patch_no_errors`:
   - Parameter: each .maxpat path, with `ids=` set to relative path string for readable output.
   - Load the file with `json.load`.
   - Call `validate_patch(patch_dict, db)`.
   - Filter results to only `level == "error"` where `auto_fixed is False` (use `has_blocking_errors` logic).
   - Assert zero blocking errors. On failure, format the errors into the assertion message.

4. Create a parametrized test `test_review_patch_no_blockers`:
   - Same parametrization.
   - Load the file with `json.load`.
   - Call `review_patch(patch_dict)` from `src.maxpat.critics`.
   - Filter results to only `severity == "blocker"`.
   - Assert zero blockers. On failure, format the blockers into the assertion message.

5. If any patches currently fail either test, mark them individually with `pytest.mark.xfail(reason="known issue: ...")` rather than skipping. This ensures we track regressions without blocking CI.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python -m pytest tests/test_integration_patches.py -x -q</automated>
  </verify>
  <done>18 .maxpat files tested for validation errors and critic blockers. All pass (or are marked xfail with documented reason). Test output shows parametrized IDs like "patches/mixer/generated/mixer.maxpat".</done>
</task>

</tasks>

<verification>
```bash
# All tests pass
cd /Users/taylorbrook/Dev/MAX && python -m pytest tests/test_validation.py tests/test_critics.py tests/test_integration_patches.py -x -q

# No remaining _get_box_name definitions in the 3 source files
grep -rn "def _get_box_name" src/maxpat/validation.py src/maxpat/critics/dsp_critic.py src/maxpat/critics/structure_critic.py && echo "FAIL: still has copies" || echo "OK: deduplicated"

# get_box_name lives only in utils.py
grep -rn "def get_box_name" src/maxpat/utils.py
```
</verification>

<success_criteria>
- src/maxpat/utils.py exists with get_box_name
- Zero copies of _get_box_name remain in validation.py, dsp_critic.py, structure_critic.py
- All existing tests still pass (no regressions)
- 18 real .maxpat files tested via parametrized integration tests
- Zero validation errors and zero critic blockers on real patches (or documented xfails)
</success_criteria>

<output>
After completion, create `.planning/quick/260331-rzs-add-integration-validation-tests-on-real/260331-rzs-SUMMARY.md`
</output>
