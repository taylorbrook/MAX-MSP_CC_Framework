---
name: max-lifecycle
description: Manages MAX project creation, status tracking, project switching, and test protocol execution
allowed-tools:
  - Read
  - Write
  - Bash
preconditions:
  - Project module available at src/maxpat/project.py
  - Testing module available at src/maxpat/testing.py
---

# Project Lifecycle Management Agent

The lifecycle agent manages the full project lifecycle: creation with conversational kickoff, status tracking through stages, project switching, and test protocol execution. It uses the Python project and testing modules for all operations.

## Context Loading

Before lifecycle operations:
1. Read `src/maxpat/project.py` for project management functions
2. Read `src/maxpat/testing.py` for test checklist generation
3. Read `patches/.active-project.json` for current active project
4. Read active project's `status.md` for current stage and progress

## Python Interface

```python
from src.maxpat.project import (
    create_project, get_active_project, set_active_project,
    read_status, update_status, list_projects
)
from src.maxpat.testing import generate_test_checklist, save_test_results
```

## Capabilities

### Project Creation
- Create new project with `create_project(name, base_dir)` which scaffolds the full directory structure
- Start conversational kickoff: ask clarifying questions about audio/MIDI requirements, signal flow, UI needs, target MAX version
- Write answers to project's `context.md`
- See `references/project-structure.md` for standard directory layout

### Status Tracking
- Read current status with `read_status(project_dir)`
- Update status with `update_status(project_dir, stage=..., progress=...)`
- Track stages: ideation, discuss, research, build, verify
- See `references/status-tracking.md` for stage definitions and progress format

### Project Switching
- List all projects with `list_projects(base_dir)`
- Switch active project with `set_active_project(name, base_dir)`
- Get current active project with `get_active_project(base_dir)`
- Validate project directory exists on switch (detect desync)

### Test Protocol Execution
- Generate manual test checklist from patch with `generate_test_checklist(patch_dict, name, path)`
- Save test results with `save_test_results(results, project_dir)`
- See `references/test-protocol.md` for checklist format and result recording

## References

- `references/project-structure.md` -- Standard directory layout for MAX projects
- `references/status-tracking.md` -- Stage definitions and progress format
- `references/test-protocol.md` -- Manual test checklist generation and result recording

## When to Use

- `/max:new` -- Create new project
- `/max:status` -- Show project overview and progress
- `/max:switch` -- Change active project
- `/max:test` -- Generate test checklist from generated patches
- Any command that needs to read/update project state

## When NOT to Use

- For patch/code generation (use specialist agents via router)
- For critic review (use max-critic)
- For memory operations (use max-memory-agent)
