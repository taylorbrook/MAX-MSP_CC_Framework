"""Tests for slash command file structure, frontmatter, and cross-references.

Validates that all 10 command files under .claude/commands/ have correct
YAML frontmatter, naming convention, descriptions, and reference the
appropriate skills and Python modules.
"""

from __future__ import annotations

from pathlib import Path

import pytest

# -- Constants ----------------------------------------------------------------

COMMANDS_DIR = Path(__file__).resolve().parent.parent / ".claude" / "commands"

ALL_COMMANDS = [
    "max-new",
    "max-build",
    "max-discuss",
    "max-research",
    "max-iterate",
    "max-verify",
    "max-test",
    "max-status",
    "max-memory",
    "max-switch",
]


# -- Helpers ------------------------------------------------------------------


def _read_command(name: str) -> str:
    """Read the contents of a command markdown file."""
    path = COMMANDS_DIR / f"{name}.md"
    return path.read_text()


def _parse_frontmatter(content: str) -> dict[str, str]:
    """Parse YAML frontmatter fields from markdown content."""
    result: dict[str, str] = {}
    if not content.startswith("---"):
        return result
    end = content.index("---", 3)
    frontmatter = content[3:end]
    for line in frontmatter.strip().splitlines():
        if ":" in line:
            key, _, value = line.partition(":")
            result[key.strip()] = value.strip().strip('"').strip("'")
    return result


# -- Test: All 10 command files exist -----------------------------------------


@pytest.mark.parametrize("cmd_name", ALL_COMMANDS)
def test_command_file_exists(cmd_name: str) -> None:
    """Each of the 10 command files must exist under .claude/commands/."""
    path = COMMANDS_DIR / f"{cmd_name}.md"
    assert path.is_file(), f"Command file missing: {path}"


def test_total_command_count() -> None:
    """There must be at least 10 command files matching max-*.md."""
    if not COMMANDS_DIR.is_dir():
        pytest.fail(f"Commands directory does not exist: {COMMANDS_DIR}")
    cmd_files = list(COMMANDS_DIR.glob("max-*.md"))
    assert len(cmd_files) >= 10, (
        f"Expected at least 10 command files, found {len(cmd_files)}: "
        f"{sorted(f.name for f in cmd_files)}"
    )


# -- Test: Frontmatter structure ----------------------------------------------


@pytest.mark.parametrize("cmd_name", ALL_COMMANDS)
def test_command_starts_with_frontmatter(cmd_name: str) -> None:
    """Each command file must start with YAML frontmatter delimited by ---."""
    content = _read_command(cmd_name)
    assert content.startswith("---"), (
        f"{cmd_name}.md does not start with '---' frontmatter delimiter"
    )
    assert content.count("---") >= 2, (
        f"{cmd_name}.md missing closing '---' frontmatter delimiter"
    )


@pytest.mark.parametrize("cmd_name", ALL_COMMANDS)
def test_frontmatter_has_name(cmd_name: str) -> None:
    """Each command frontmatter must have a 'name' field matching max-{something}."""
    content = _read_command(cmd_name)
    fm = _parse_frontmatter(content)
    assert "name" in fm, f"{cmd_name}.md frontmatter missing 'name' field"
    assert fm["name"].startswith("max-"), (
        f"{cmd_name}.md name field '{fm['name']}' does not start with 'max-'"
    )


@pytest.mark.parametrize("cmd_name", ALL_COMMANDS)
def test_frontmatter_has_description(cmd_name: str) -> None:
    """Each command frontmatter must have a non-empty 'description' field."""
    content = _read_command(cmd_name)
    fm = _parse_frontmatter(content)
    assert "description" in fm, (
        f"{cmd_name}.md frontmatter missing 'description' field"
    )
    assert len(fm["description"]) > 0, (
        f"{cmd_name}.md 'description' field is empty"
    )


# -- Test: Cross-references to skills and Python modules ----------------------


def test_build_references_max_router() -> None:
    """max-build.md must reference the max-router skill for dispatch."""
    content = _read_command("max-build")
    assert "max-router" in content, (
        "max-build.md should reference max-router skill"
    )


def test_new_references_create_project() -> None:
    """max-new.md must reference create_project or project creation."""
    content = _read_command("max-new")
    assert "create_project" in content, (
        "max-new.md should reference create_project from project module"
    )


def test_test_references_generate_test_checklist() -> None:
    """max-test.md must reference generate_test_checklist."""
    content = _read_command("max-test")
    assert "generate_test_checklist" in content, (
        "max-test.md should reference generate_test_checklist from testing module"
    )


def test_memory_references_memory_store() -> None:
    """max-memory.md must reference MemoryStore from memory module."""
    content = _read_command("max-memory")
    assert "MemoryStore" in content, (
        "max-memory.md should reference MemoryStore from memory module"
    )


def test_verify_references_review_patch() -> None:
    """max-verify.md must reference review_patch or critic review."""
    content = _read_command("max-verify")
    assert "review_patch" in content, (
        "max-verify.md should reference review_patch from critics module"
    )


# -- Test: Minimum file sizes ------------------------------------------------


@pytest.mark.parametrize("cmd_name", ALL_COMMANDS)
def test_command_has_minimum_content(cmd_name: str) -> None:
    """Each command file must have meaningful content (at least 15 lines)."""
    content = _read_command(cmd_name)
    line_count = len(content.strip().splitlines())
    assert line_count >= 15, (
        f"{cmd_name}.md has only {line_count} lines, expected at least 15"
    )


# -- Test: Additional skill/module cross-references ---------------------------


def test_build_references_critic() -> None:
    """max-build.md must reference the critic loop for quality assurance."""
    content = _read_command("max-build")
    assert "max-critic" in content or "review_patch" in content, (
        "max-build.md should reference critic loop"
    )


def test_iterate_references_router() -> None:
    """max-iterate.md must reference max-router for domain dispatch."""
    content = _read_command("max-iterate")
    assert "max-router" in content, (
        "max-iterate.md should reference max-router skill"
    )


def test_new_references_lifecycle_skill() -> None:
    """max-new.md must reference the max-lifecycle skill."""
    content = _read_command("max-new")
    assert "max-lifecycle" in content, (
        "max-new.md should reference max-lifecycle skill"
    )
