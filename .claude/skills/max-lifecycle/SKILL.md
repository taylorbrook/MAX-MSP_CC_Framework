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
5. Read active project's `config.json` via `load_project_config()` for package configuration

## Python Interface

```python
from src.maxpat.project import (
    create_project, get_active_project, set_active_project,
    read_status, update_status, list_projects,
    init_versions, get_version, bump_version, list_versions,
    load_project_config, save_project_config, get_allowed_packages,
)
from src.maxpat.testing import generate_test_checklist, save_test_results
```

## Capabilities

### Project Creation
- Create new project with `create_project(name, base_dir)` which scaffolds the full directory structure
- `create_project()` also creates an empty .maxpat file at `patches/{name}/generated/{name}.maxpat` with canvas background color -- user can open in MAX immediately
- Start conversational kickoff: ask clarifying questions about audio/MIDI requirements, signal flow, UI needs
- Write answers to project's `context.md`
- See `references/project-structure.md` for standard directory layout

### Package Configuration
- After `create_project()`, prompt the user to select packages for the project
- Present packages in two groups using `ObjectDatabase().list_packages()` and `get_package_info()`:
  - **Bundled packages** (tier == "bundled" in package_info.json): ship with MAX, always available
  - **Community packages** (tier == "community" or "licensed"): require separate install
- User picks individual packages from each group (no preset bundles)
- Write selection with `save_project_config(project_dir, {"packages": [selected_names]})`
- Package names must exactly match keys in package_info.json (e.g., "BEAP", "Vizzie", "ableton-dsp")
- If user selects no packages, write `{"packages": []}` (core-only, per D-08)
- Users can change packages later via `/max-config` (same bundled/community split)

### Community Package Extraction Gate

When a user selects a community package (tier == "community" in package_info.json):
- Check `extracted` field in package_info.json via `ObjectDatabase().get_package_info(name)`
- If `extracted` is `false`, the package has stub data only -- do NOT generate patches with its objects
- Show the user the install + extract path:
  - Package Manager packages (FluCoMa, CNMAT, Bach, Odot, ml-lib, Cage, Dada, EARS, Rhythmic Time Toolkit): "Install via MAX Package Manager (Help -> Package Manager -> search '{name}'), then run: `python .claude/scripts/extract_objects.py --package \"{name}\"`"
  - IRCAM Spat: "Download from https://forum.ircam.fr/projects/detail/spat/ (free account required), copy spat5 folder to ~/Documents/Max 9/Packages/, then run: `python .claude/scripts/extract_objects.py --package \"IRCAM Spat\"`"
- After extraction completes, `extracted` flips to `true` and the package is unblocked
- Bach ecosystem note: Cage, Dada, and EARS all require Bach installed first. If user selects any of these, ensure Bach is also selected and extracted.

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

### Version Tracking
- Track project versions with `init_versions(project_dir)`, `get_version(project_dir)`, `bump_version(project_dir, bump, description)`, `list_versions(project_dir)`
- New projects auto-initialize at 0.0.0 via `create_project()`
- Bump after significant changes: patch for fixes, minor for new features, major for breaking changes
- See `references/status-tracking.md` for version tracking API details

### Test Protocol Execution
- Generate manual test checklist from patch with `generate_test_checklist(patch_dict, patch_name, patch_path="")`
- Save test results with `save_test_results(project_dir, test_name, results_md)`
- See `references/test-protocol.md` for checklist format and result recording

## References

- `references/project-structure.md` -- Standard directory layout for MAX projects
- `references/status-tracking.md` -- Stage definitions and progress format
- `references/test-protocol.md` -- Manual test checklist generation and result recording

## When to Use

- `/max-new` -- Create new project
- `/max-status` -- Show project overview and progress
- `/max-switch` -- Change active project
- `/max-test` -- Generate test checklist from generated patches
- `/max-version` -- Show current version or bump version
- `/max-config` -- View or change project package configuration
- Any command that needs to read/update project state

## When NOT to Use

- For patch/code generation (use specialist agents via router)
- For critic review (use max-critic)
