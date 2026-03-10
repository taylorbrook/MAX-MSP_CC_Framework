---
name: max-switch
description: Change the active MAX project
argument-hint: "[project-name]"
---

# /max-switch

Switch the active MAX project to a different existing project.

## Behavior

1. **If project name provided:**
   - Validate the project exists under `patches/{name}/`
   - Call `set_active_project(name, base_dir)` to update `.active-project.json`
   - Display confirmation with the project's current status summary (stage, progress, last activity)

2. **If no project name provided:**
   - List all available projects via `list_projects(base_dir)`
   - Display each project with its current stage and last activity
   - Ask the user to choose which project to switch to

3. **Error handling:**
   - If the named project does not exist, show available projects and suggest correct names
   - If no projects exist at all, suggest `/max-new` to create one

## Skills Referenced

- **max-lifecycle** -- project switching, project listing, status reading

## Python Modules

```python
from src.maxpat.project import set_active_project, list_projects, get_active_project, read_status
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| project-name | No | Name of the project to switch to |

## Examples

```
/max-switch my-synth
/max-switch step-sequencer
/max-switch
```
