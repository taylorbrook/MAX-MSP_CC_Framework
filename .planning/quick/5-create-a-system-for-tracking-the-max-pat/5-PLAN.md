---
phase: quick-5
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - src/maxpat/project.py
  - tests/test_project.py
  - patches/FDNVerb/versions.json
  - patches/granularsynthtest/versions.json
  - patches/performancepatchtest/versions.json
  - patches/rhythmic-sampler/versions.json
  - .claude/skills/max-lifecycle/SKILL.md
  - .claude/skills/max-lifecycle/references/status-tracking.md
  - .claude/skills/max-lifecycle/references/project-structure.md
autonomous: true
requirements: [QUICK-5]

must_haves:
  truths:
    - "New projects start at version 0.0.0 with an initial entry in versions.json"
    - "Versions can be bumped (patch/minor/major) with a description of what changed"
    - "Version history is queryable per project (list all versions with timestamps and descriptions)"
    - "Existing projects get initialized with version 0.0.0 when first versioned"
  artifacts:
    - path: "src/maxpat/project.py"
      provides: "Version management functions"
      exports: ["get_version", "bump_version", "list_versions", "init_versions"]
    - path: "tests/test_project.py"
      provides: "Tests for version management"
      contains: "TestVersioning"
    - path: "patches/rhythmic-sampler/versions.json"
      provides: "Example version file for existing project"
      contains: "0.0.0"
  key_links:
    - from: "src/maxpat/project.py"
      to: "patches/{project}/versions.json"
      via: "JSON read/write in version functions"
      pattern: "versions\\.json"
---

<objective>
Add a semver-based version tracking system to the MAX project lifecycle. Each project gets a `versions.json` file that records version bumps with timestamps and change descriptions. New projects start at 0.0.0. Versions follow x.x.x (major.minor.patch) convention.

Purpose: Enable tracking of patch iterations so the user can see what changed across versions, revert to understanding of prior states, and know the current version of any project at a glance.

Output: Version management functions in project.py, tests, initialized versions.json for all existing projects, updated lifecycle docs.
</objective>

<execution_context>
@/Users/taylorbrook/.claude/get-shit-done/workflows/execute-plan.md
@/Users/taylorbrook/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@src/maxpat/project.py
@tests/test_project.py
@.claude/skills/max-lifecycle/SKILL.md
@.claude/skills/max-lifecycle/references/status-tracking.md
@.claude/skills/max-lifecycle/references/project-structure.md

<interfaces>
<!-- Existing project.py exports the executor needs to integrate with -->

From src/maxpat/project.py:
```python
_PROJECT_NAME_RE = re.compile(r"^[a-z0-9]+(-[a-z0-9]+)*$")

def create_project(name: str, base_dir: Path) -> Path:
    # Creates patches/{name}/ with context.md, status.md, .max-memory/, generated/, test-results/

def read_status(project_dir: Path) -> dict:
    # Parses status.md key-value pairs

def update_status(project_dir: Path, **kwargs: str) -> None:
    # Updates fields in status.md

def list_projects(base_dir: Path) -> list[str]:
    # Returns sorted list of project directory names under patches/
```

From tests/test_project.py:
```python
# Uses pytest with tmp_path fixture
# Pattern: create_project("name", tmp_path) then assert on files/values
# Classes: TestCreateProject, TestActiveProject, TestReadStatus, TestUpdateStatus, TestListProjects
```
</interfaces>
</context>

<tasks>

<task type="auto" tdd="true">
  <name>Task 1: Add version management functions to project.py and tests</name>
  <files>src/maxpat/project.py, tests/test_project.py</files>
  <behavior>
    - init_versions(project_dir) creates versions.json with a single entry: version "0.0.0", description "Initial version", timestamp (ISO UTC)
    - init_versions(project_dir) is idempotent -- if versions.json exists, it does nothing and returns the current version string
    - get_version(project_dir) returns the current (latest) version string, e.g. "0.0.0"
    - get_version(project_dir) returns None if no versions.json exists
    - bump_version(project_dir, bump="patch", description="...") increments the patch number: 0.0.0 -> 0.0.1
    - bump_version(project_dir, bump="minor", description="...") increments minor, resets patch: 0.0.1 -> 0.1.0
    - bump_version(project_dir, bump="major", description="...") increments major, resets minor and patch: 0.1.0 -> 1.0.0
    - bump_version raises ValueError if bump is not "patch", "minor", or "major"
    - bump_version raises FileNotFoundError if versions.json does not exist (must init first)
    - bump_version returns the new version string
    - list_versions(project_dir) returns the full list of version entries (list of dicts with version, description, timestamp), newest first
    - list_versions returns empty list if no versions.json exists
    - create_project now also calls init_versions to set up 0.0.0 on new projects
  </behavior>
  <action>
    1. Write tests first in tests/test_project.py -- add a new TestVersioning class with tests for each behavior above. Import the new functions alongside existing imports. Use tmp_path and create_project to set up test projects.

    2. Run tests (expect RED -- functions don't exist yet).

    3. Implement in src/maxpat/project.py:

    **versions.json format:**
    ```json
    {
      "versions": [
        {
          "version": "0.0.0",
          "description": "Initial version",
          "timestamp": "2026-03-12T00:00:00+00:00"
        }
      ]
    }
    ```
    Versions list is ordered oldest-first on disk (append new versions). list_versions returns newest-first (reversed).

    **Functions to add:**

    - `init_versions(project_dir: Path) -> str` -- Create versions.json with 0.0.0 entry if it doesn't exist. Returns current version string.

    - `get_version(project_dir: Path) -> str | None` -- Read versions.json and return the last entry's version string. Return None if file doesn't exist.

    - `bump_version(project_dir: Path, bump: str = "patch", description: str = "") -> str` -- Parse current version, increment per bump type, append new entry to versions.json, return new version string. Validate bump type. Raise FileNotFoundError if versions.json missing.

    - `list_versions(project_dir: Path) -> list[dict]` -- Read and return all version entries, newest first. Return empty list if no file.

    **Update create_project:** After creating status.md and other files, call `init_versions(project_dir)` to create versions.json with the initial 0.0.0 entry.

    4. Run tests (expect GREEN).

    5. Export the new functions in the module docstring's import example if present.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python -m pytest tests/test_project.py -x -v</automated>
  </verify>
  <done>All version management functions implemented and tested. create_project initializes versions.json. Existing tests still pass. New TestVersioning class has tests for init, get, bump (all 3 types), list, edge cases (idempotent init, missing file, invalid bump type).</done>
</task>

<task type="auto">
  <name>Task 2: Initialize existing projects and update lifecycle docs</name>
  <files>patches/FDNVerb/versions.json, patches/granularsynthtest/versions.json, patches/performancepatchtest/versions.json, patches/rhythmic-sampler/versions.json, .claude/skills/max-lifecycle/SKILL.md, .claude/skills/max-lifecycle/references/status-tracking.md, .claude/skills/max-lifecycle/references/project-structure.md</files>
  <action>
    1. **Initialize versions.json for all 4 existing projects.** Run a Python one-liner or short script:
    ```python
    from src.maxpat.project import init_versions
    from pathlib import Path
    base = Path("patches")
    for p in ["FDNVerb", "granularsynthtest", "performancepatchtest", "rhythmic-sampler"]:
        init_versions(base / p)
    ```
    Each project gets a versions.json with the 0.0.0 initial entry.

    2. **Update project-structure.md** -- Add `versions.json` to the directory layout:
    ```
    patches/
      {project-name}/
        versions.json           # Version history (semver, auto-created at 0.0.0)
        context.md              # ...
    ```
    Add a `### versions.json` section explaining the format (array of {version, description, timestamp} entries).

    3. **Update status-tracking.md** -- Add a "## Version Tracking" section explaining:
    - New projects start at 0.0.0
    - Use bump_version(project_dir, bump="patch|minor|major", description="what changed") to increment
    - get_version(project_dir) returns current version
    - list_versions(project_dir) returns full history
    - Show the Python API examples

    4. **Update SKILL.md** -- Add a "### Version Tracking" subsection under Capabilities:
    - Track project versions with `init_versions(project_dir)`, `get_version(project_dir)`, `bump_version(project_dir, bump, description)`, `list_versions(project_dir)`
    - New projects auto-initialize at 0.0.0
    - Bump after significant changes (patch for fixes, minor for new features, major for breaking changes)
    - Add to the Python Interface import list: `init_versions, get_version, bump_version, list_versions`
    - Add to "When to Use": `/max:version` -- Show current version or bump version
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python -c "from src.maxpat.project import get_version; from pathlib import Path; [print(f'{p}: {get_version(Path(\"patches\") / p)}') for p in ['FDNVerb','granularsynthtest','performancepatchtest','rhythmic-sampler']]" && python -m pytest tests/test_project.py -x -v</automated>
  </verify>
  <done>All 4 existing projects have versions.json initialized at 0.0.0. Lifecycle docs (SKILL.md, status-tracking.md, project-structure.md) updated to document version tracking API and file format. Full test suite still passes.</done>
</task>

</tasks>

<verification>
- `python -m pytest tests/test_project.py -x -v` -- all tests pass (existing + new versioning tests)
- All 4 existing projects have `versions.json` with 0.0.0 entry
- `get_version()` returns "0.0.0" for all existing projects
- `bump_version()` correctly increments and records descriptions
- `create_project()` auto-creates versions.json for new projects
- Lifecycle docs reflect the new version tracking capability
</verification>

<success_criteria>
- Version tracking functions (init_versions, get_version, bump_version, list_versions) are implemented, tested, and exported from project.py
- New projects automatically start at 0.0.0
- All existing projects initialized at 0.0.0
- Lifecycle agent docs updated to cover versioning
- All existing tests continue to pass
</success_criteria>

<output>
After completion, create `.planning/quick/5-create-a-system-for-tracking-the-max-pat/5-SUMMARY.md`
</output>
