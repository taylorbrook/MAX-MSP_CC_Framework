---
name: max-status
description: Show project overview, progress, and current stage
---

# /max-status

Display the status of the active MAX project, including current stage, progress, generated files, and recent activity.

## Behavior

1. **Read active project** -- check `patches/.active-project.json` for the current active project.

2. **If active project exists:**
   - Read the project's `status.md` via `read_status(project_dir)`
   - Display: project name, current stage, progress percentage, files generated, last activity timestamp
   - List generated files in the project's `generated/` directory
   - Show any stored test results

3. **If no active project or desync detected:**
   - List all available projects in `patches/` via `list_projects(base_dir)`
   - Show warning if `.active-project.json` references a project directory that no longer exists (desync)
   - Suggest using `/max-switch` to select a project or `/max-new` to create one

4. **Display format:**
   ```
   Project: {name}
   Stage: {stage} (ideation | discuss | research | build | verify)
   Progress: {percentage}%
   Files: {count} generated
   Last Activity: {timestamp}
   ```

## Skills Referenced

- **max-lifecycle** -- project status reading, project listing

## Python Modules

```python
from src.maxpat.project import get_active_project, read_status, list_projects
```

## Arguments

None required.

## Examples

```
/max-status
```
