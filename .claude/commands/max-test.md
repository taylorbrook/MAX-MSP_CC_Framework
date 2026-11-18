---
name: max-test
description: Generate a manual test checklist for MAX patches
argument-hint: "[patch-name?]"
---

# /max-test

Generate a manual test checklist for patches in the active project, then record test results after the user runs them in MAX.

## Behavior

1. **Load active project** -- read `patches/.active-project.json` for the current project. If no active project, prompt the user.

2. **Identify target patches:**
   - If a patch name is provided, locate that specific `.maxpat` file in `generated/`
   - If no name provided, find all `.maxpat` files in the project's `generated/` directory

3. **Generate test checklist** -- for each patch, call `generate_test_checklist(patch_dict, patch_name, patch_path="")` from `src.maxpat.testing`:
   - The checklist is based on detected objects: audio objects get signal flow tests, MIDI objects get note tests, UI objects get interaction tests
   - Each checklist item describes what to do in MAX and what to expect

4. **Display checklist** -- present the test checklist to the user in a clear, numbered format:
   ```
   Test Checklist for: {patch-name}
   ================================
   [ ] 1. Open patch in MAX -- verify it loads without errors
   [ ] 2. {test item based on detected objects}
   [ ] 3. {test item based on detected objects}
   ...
   ```

5. **Record results** -- after the user reports which tests passed/failed, call `save_test_results(project_dir, test_name, results_md)` from `src.maxpat.testing` to persist the results. It overwrites a same-named file, so name it `v<version>-<slug>-checklist` (version from `get_version(project_dir)`). Commit the results file by explicit path: `auto_commit_patch(project_dir, base_dir, description="test results v<version> <slug>", files=[str(path)])`; it raises `RuntimeError` on any git failure, so report that to the user (the results file is written but not committed).

6. **Record confirmations** -- whenever the user confirms in MAX that a feature works (a passing checklist item, or in conversation, including after a `/max-iterate` fix), record it:
   ```python
   path = record_confirmation(project_dir, feature, evidence, version=version, max_version="9.2.1", files=["generated/<name>.maxpat"])
   ```
   - `evidence` is the user's own words; `feature` is one short line.
   - This writes `test-results/v<version>-<slug>-confirmed.md` (`<date>-<slug>-confirmed.md` for an unversioned project), never overwrites an earlier confirmation (`-2`, `-3`, ...), and commits only that path.
   - It refuses private paths (`/Users/`, `/home/`, `~/.claude`, memory-note filenames) and files outside the project.

7. **Offer a proven-forms lesson** -- only when the confirmation teaches general MAX knowledge that holds beyond this project (a form that works, a trap the database or validator misses):
   - Draft it with `format_proven_form(title, rule, form, why, evidence)` and evidence `[confirmed] <project> v<version> (<date>)`. Tiers and the entry format are in `.claude/skills/references/proven-forms.md`.
   - Show the drafted entry verbatim and ask (multiple choice): **(a)** append as drafted, **(b)** edit first, **(c)** skip.
   - On append, call `append_proven_form(section, title, rule, form, why, evidence)`, then commit by explicit path:
     ```
     git add .claude/skills/references/proven-forms.md
     git commit -m "docs(proven-forms): <title>" -- .claude/skills/references/proven-forms.md
     ```
   - Never copy private paths or project-only facts into proven-forms.md.

8. **Update status** -- record test results in the project status with `update_status(project_dir, progress=...)`; for a confirmation the note is `v<version> <feature> confirmed in MAX <date>`.

## Skills Referenced

- **max-lifecycle** -- project context, status tracking, test protocol execution

## Python Modules

```python
from src.maxpat.testing import (
    generate_test_checklist, save_test_results,
    record_confirmation, format_proven_form, append_proven_form,
)
from src.maxpat.project import get_active_project, get_version, update_status, auto_commit_patch
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| patch-name | No | Specific patch file to test (e.g., `my-synth.maxpat`) |

## Examples

```
/max-test my-synth.maxpat
/max-test
```
