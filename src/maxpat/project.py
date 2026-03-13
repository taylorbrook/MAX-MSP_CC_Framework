"""Project lifecycle management -- creation, tracking, status.

Each MAX project lives in its own directory under patches/ with independent
context, state, and generated files. This module handles:

- Project creation with full directory structure
- Active project tracking via .active-project.json
- Status read/write (stage, progress, created date)
- Project listing
"""

from __future__ import annotations

import json
import re
from datetime import datetime, timezone
from pathlib import Path

# Valid project name: lowercase alphanumeric + hyphens, no leading/trailing hyphen
_PROJECT_NAME_RE = re.compile(r"^[a-z0-9]+(-[a-z0-9]+)*$")


def create_project(name: str, base_dir: Path) -> Path:
    """Create a new project with full directory structure.

    Creates patches/{name}/ with:
    - context.md (empty template)
    - status.md (stage: ideation, progress: empty, created: ISO date)
    - .max-memory/patterns.md (empty)
    - generated/ (empty directory)
    - test-results/ (empty directory)

    Args:
        name: Project name (lowercase alphanumeric + hyphens only).
        base_dir: Root directory containing the patches/ folder.

    Returns:
        Path to the created project directory.

    Raises:
        ValueError: If name is invalid or project already exists.
    """
    if not _PROJECT_NAME_RE.match(name):
        raise ValueError(
            f"Invalid project name '{name}'. "
            "Must be lowercase alphanumeric with hyphens (e.g., 'my-synth')."
        )

    project_dir = base_dir / "patches" / name
    if project_dir.exists():
        raise ValueError(f"Project '{name}' already exists at {project_dir}")

    # Create directory tree
    project_dir.mkdir(parents=True)
    (project_dir / ".max-memory").mkdir()
    (project_dir / "generated").mkdir()
    (project_dir / "test-results").mkdir()

    # Initialize context.md
    (project_dir / "context.md").write_text(
        f"# {name}\n\nProject context and notes.\n"
    )

    # Initialize .max-memory/patterns.md
    (project_dir / ".max-memory" / "patterns.md").write_text(
        f"# {name} -- Learned Patterns\n\nPatterns discovered during development.\n"
    )

    # Initialize status.md
    now = datetime.now(timezone.utc).isoformat()
    status_content = (
        f"stage: ideation\n"
        f"progress: \n"
        f"created: {now}\n"
    )
    (project_dir / "status.md").write_text(status_content)

    # Initialize version tracking at 0.0.0
    init_versions(project_dir)

    return project_dir


def set_active_project(name: str, base_dir: Path) -> None:
    """Set the active project by writing .active-project.json.

    Args:
        name: Project name to activate.
        base_dir: Root directory containing the patches/ folder.
    """
    patches_dir = base_dir / "patches"
    patches_dir.mkdir(parents=True, exist_ok=True)

    active_file = patches_dir / ".active-project.json"
    data = {
        "name": name,
        "activated": datetime.now(timezone.utc).isoformat(),
    }
    active_file.write_text(json.dumps(data, indent=2) + "\n")


def get_active_project(base_dir: Path) -> dict | None:
    """Get the currently active project.

    Returns None if:
    - No .active-project.json exists
    - The referenced project directory doesn't exist (desync detection)

    Args:
        base_dir: Root directory containing the patches/ folder.

    Returns:
        Dict with 'name' and 'activated' keys, or None.
    """
    active_file = base_dir / "patches" / ".active-project.json"
    if not active_file.is_file():
        return None

    data = json.loads(active_file.read_text())
    project_dir = base_dir / "patches" / data["name"]
    if not project_dir.is_dir():
        return None

    return data


def read_status(project_dir: Path) -> dict:
    """Parse status.md and return dict with stage, progress, created fields.

    Args:
        project_dir: Path to the project directory.

    Returns:
        Dict with 'stage', 'progress', 'created' keys.
    """
    status_file = project_dir / "status.md"
    content = status_file.read_text()

    result = {}
    for line in content.strip().splitlines():
        if ":" in line:
            key, _, value = line.partition(":")
            result[key.strip()] = value.strip()

    return result


def update_status(project_dir: Path, **kwargs: str) -> None:
    """Update specific fields in status.md.

    Args:
        project_dir: Path to the project directory.
        **kwargs: Fields to update (e.g., stage="build", progress="50%").
    """
    current = read_status(project_dir)
    current.update(kwargs)

    lines = [f"{key}: {value}" for key, value in current.items()]
    (project_dir / "status.md").write_text("\n".join(lines) + "\n")


def init_versions(project_dir: Path) -> str:
    """Initialize versions.json with a 0.0.0 entry if it doesn't exist.

    Idempotent -- if versions.json already exists, returns the current version
    without modifying the file.

    Args:
        project_dir: Path to the project directory.

    Returns:
        Current version string (e.g., "0.0.0").
    """
    versions_file = project_dir / "versions.json"
    if versions_file.is_file():
        data = json.loads(versions_file.read_text())
        return data["versions"][-1]["version"]

    data = {
        "versions": [
            {
                "version": "0.0.0",
                "description": "Initial version",
                "timestamp": datetime.now(timezone.utc).isoformat(),
            }
        ]
    }
    versions_file.write_text(json.dumps(data, indent=2) + "\n")
    return "0.0.0"


def get_version(project_dir: Path) -> str | None:
    """Get the current (latest) version string for a project.

    Args:
        project_dir: Path to the project directory.

    Returns:
        Version string (e.g., "0.1.0") or None if no versions.json exists.
    """
    versions_file = project_dir / "versions.json"
    if not versions_file.is_file():
        return None

    data = json.loads(versions_file.read_text())
    return data["versions"][-1]["version"]


def bump_version(
    project_dir: Path, bump: str = "patch", description: str = ""
) -> str:
    """Increment the project version and record the change.

    Args:
        project_dir: Path to the project directory.
        bump: One of "patch", "minor", or "major".
        description: Human-readable description of what changed.

    Returns:
        The new version string.

    Raises:
        ValueError: If bump is not "patch", "minor", or "major".
        FileNotFoundError: If versions.json does not exist (must init first).
    """
    if bump not in ("patch", "minor", "major"):
        raise ValueError(
            f"bump must be 'patch', 'minor', or 'major', got '{bump}'"
        )

    versions_file = project_dir / "versions.json"
    if not versions_file.is_file():
        raise FileNotFoundError(
            f"No versions.json in {project_dir}. Call init_versions() first."
        )

    data = json.loads(versions_file.read_text())
    current = data["versions"][-1]["version"]
    parts = [int(x) for x in current.split(".")]

    if bump == "major":
        parts = [parts[0] + 1, 0, 0]
    elif bump == "minor":
        parts = [parts[0], parts[1] + 1, 0]
    else:  # patch
        parts = [parts[0], parts[1], parts[2] + 1]

    new_version = ".".join(str(p) for p in parts)
    data["versions"].append(
        {
            "version": new_version,
            "description": description,
            "timestamp": datetime.now(timezone.utc).isoformat(),
        }
    )
    versions_file.write_text(json.dumps(data, indent=2) + "\n")
    return new_version


def list_versions(project_dir: Path) -> list[dict]:
    """List all version entries for a project, newest first.

    Args:
        project_dir: Path to the project directory.

    Returns:
        List of version entry dicts (version, description, timestamp),
        ordered newest first. Empty list if no versions.json.
    """
    versions_file = project_dir / "versions.json"
    if not versions_file.is_file():
        return []

    data = json.loads(versions_file.read_text())
    return list(reversed(data["versions"]))


def list_projects(base_dir: Path) -> list[str]:
    """List all project names (directories under patches/ excluding hidden files).

    Args:
        base_dir: Root directory containing the patches/ folder.

    Returns:
        Sorted list of project directory names.
    """
    patches_dir = base_dir / "patches"
    if not patches_dir.is_dir():
        return []

    return sorted(
        d.name
        for d in patches_dir.iterdir()
        if d.is_dir() and not d.name.startswith(".")
    )
