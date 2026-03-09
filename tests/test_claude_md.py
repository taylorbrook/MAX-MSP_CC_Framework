"""Tests that CLAUDE.md has all required sections and content (FRM-04)."""

from pathlib import Path

import pytest

CLAUDE_MD = Path(__file__).resolve().parent.parent / "CLAUDE.md"


@pytest.fixture(scope="module")
def claude_content() -> str:
    """Load CLAUDE.md content."""
    assert CLAUDE_MD.exists(), f"CLAUDE.md not found at {CLAUDE_MD}"
    return CLAUDE_MD.read_text()


def test_claude_md_exists():
    """CLAUDE.md exists at project root."""
    assert CLAUDE_MD.exists()


def test_claude_md_min_length(claude_content: str):
    """CLAUDE.md is at least 100 lines long."""
    lines = claude_content.strip().splitlines()
    assert len(lines) >= 100, f"CLAUDE.md has only {len(lines)} lines, expected >= 100"


def test_object_database_section(claude_content: str):
    """Contains '## Object Database' section."""
    assert "## Object Database" in claude_content


def test_rules_section(claude_content: str):
    """Contains '## Rules' section."""
    assert "## Rules" in claude_content


def test_never_guess_rule(claude_content: str):
    """Contains Rule #1 about never guessing objects."""
    content_lower = claude_content.lower()
    assert "never guess" in content_lower, "CLAUDE.md must contain 'never guess' rule"
    assert "rule #1" in content_lower, "CLAUDE.md must have Rule #1"


def test_domain_specific_rules_section(claude_content: str):
    """Contains '## Domain-Specific Rules' section."""
    assert "## Domain-Specific Rules" in claude_content


def test_msp_subsection(claude_content: str):
    """Contains MSP subsection under Domain-Specific Rules."""
    assert "### MSP" in claude_content


def test_gen_subsection(claude_content: str):
    """Contains Gen~ subsection under Domain-Specific Rules."""
    assert "### Gen~" in claude_content


def test_rnbo_subsection(claude_content: str):
    """Contains RNBO subsection under Domain-Specific Rules."""
    assert "### RNBO" in claude_content


def test_n4m_subsection(claude_content: str):
    """Contains Node for Max subsection under Domain-Specific Rules."""
    assert "### Node for Max" in claude_content or "### N4M" in claude_content


def test_pd_confusion_guard_section(claude_content: str):
    """Contains '## PD Confusion Guard' section."""
    assert "## PD Confusion Guard" in claude_content


def test_version_compatibility_section(claude_content: str):
    """Contains '## Version Compatibility' section."""
    assert "## Version Compatibility" in claude_content


def test_variable_io_section(claude_content: str):
    """Contains '## Variable I/O Objects' section."""
    assert "## Variable I/O Objects" in claude_content


def test_references_object_database_path(claude_content: str):
    """CLAUDE.md references the .claude/max-objects/ path."""
    assert ".claude/max-objects/" in claude_content


def test_verify_before_connect_rule(claude_content: str):
    """Contains Rule #2 about verifying connections."""
    assert "Rule #2" in claude_content
    assert "Verify Before Connect" in claude_content


def test_hot_cold_inlet_rule(claude_content: str):
    """Contains Rule #3 about hot/cold inlet ordering."""
    assert "Rule #3" in claude_content
    assert "Hot/Cold" in claude_content


def test_file_conventions_section(claude_content: str):
    """Contains file conventions section."""
    assert "## File Conventions" in claude_content
    assert ".maxpat" in claude_content
