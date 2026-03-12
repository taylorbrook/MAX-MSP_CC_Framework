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

5. **Record results** -- after the user reports which tests passed/failed, call `save_test_results(project_dir, test_name, results_md)` from `src.maxpat.testing` to persist the results.

6. **Update status** -- record test results in the project status.

## Skills Referenced

- **max-lifecycle** -- project context, status tracking, test protocol execution

## Python Modules

```python
from src.maxpat.testing import generate_test_checklist, save_test_results
from src.maxpat.project import get_active_project, update_status
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
