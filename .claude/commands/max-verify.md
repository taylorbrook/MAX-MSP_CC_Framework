---
name: max-verify
description: Run validation and critic review on generated output
---

# /max-verify

Run the full validation pipeline and critic review on all generated files in the active project.

## Behavior

1. **Load active project** -- read `patches/.active-project.json` for the current project. If no active project, prompt the user.

2. **Find generated files** -- scan the project's `generated/` directory for all `.maxpat`, `.gendsp`, and `.js` files.

3. **Run mechanical validation** -- for each file:
   - `.maxpat` files: call `validate_file()` from `src.maxpat` to check JSON structure, object validity, connection bounds
   - `.js` / `.gendsp` files: call `validate_code_file()` from `src.maxpat` for code-level validation

4. **Run critic review** -- invoke the max-critic skill:
   - Call `review_patch(patch_dict, code_context)` from `src.maxpat.critics`
   - Collect all `CriticResult` findings across files

5. **Display results** grouped by severity:
   - **Blockers** -- must be fixed before the patch will work correctly. Suggest specific fixes.
   - **Warnings** -- potential issues that may cause unexpected behavior. Annotate with explanation.
   - **Notes** -- informational observations about style or best practices.

6. **Update status** -- record verification results in project status.

## Skills Referenced

- **max-critic** -- critic review loop with `review_patch()` and `CriticResult`
- **max-lifecycle** -- project context and status updates

## Python Modules

```python
from src.maxpat import validate_file, validate_code_file
from src.maxpat.critics import review_patch, CriticResult
from src.maxpat.project import get_active_project, update_status
```

## Arguments

None required. Verifies all generated files in the active project.

## Examples

```
/max-verify
```

## Output Format

```
Verification Results for: {project-name}
=========================================

{filename}:
  BLOCKER: {description} -- Fix: {suggestion}
  WARNING: {description}
  NOTE: {description}

Summary: {blockers} blockers, {warnings} warnings, {notes} notes
```
