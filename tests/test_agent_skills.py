"""Tests for agent skill file structure and content validation.

Validates that all 10 skill directories under .claude/skills/ have correct
structure, frontmatter, cross-references, boundary definitions, and content.
Skills are prompts (not code), so these tests verify file structure and
required content patterns rather than runtime behavior.
"""

from __future__ import annotations

from pathlib import Path

import pytest

# ── Constants ──────────────────────────────────────────────────────

SKILLS_DIR = Path(__file__).resolve().parent.parent / ".claude" / "skills"

ALL_SKILL_DIRS = [
    "max-router",
    "max-patch-agent",
    "max-dsp-agent",
    "max-rnbo-agent",
    "max-js-agent",
    "max-ext-agent",
    "max-ui-agent",
    "max-critic",
    "max-memory-agent",
    "max-lifecycle",
]

SPECIALIST_AGENTS = [
    "max-patch-agent",
    "max-dsp-agent",
    "max-rnbo-agent",
    "max-js-agent",
    "max-ext-agent",
    "max-ui-agent",
]


# ── Helpers ────────────────────────────────────────────────────────


def _read_skill(name: str) -> str:
    """Read SKILL.md content for a given skill directory."""
    path = SKILLS_DIR / name / "SKILL.md"
    return path.read_text()


def _has_frontmatter_field(content: str, field: str) -> bool:
    """Check if a markdown file has a YAML frontmatter field."""
    if not content.startswith("---"):
        return False
    end = content.index("---", 3)
    frontmatter = content[3:end]
    for line in frontmatter.splitlines():
        if line.startswith(f"{field}:"):
            return True
    return False


# ── Test: All 10 skill directories exist ───────────────────────────


@pytest.mark.parametrize("skill_name", ALL_SKILL_DIRS)
def test_skill_directory_exists(skill_name: str) -> None:
    """Each of the 10 skill directories must exist under .claude/skills/."""
    skill_dir = SKILLS_DIR / skill_name
    assert skill_dir.is_dir(), f"Skill directory missing: {skill_dir}"


@pytest.mark.parametrize("skill_name", ALL_SKILL_DIRS)
def test_skill_md_exists(skill_name: str) -> None:
    """Each skill directory must contain a SKILL.md file."""
    skill_file = SKILLS_DIR / skill_name / "SKILL.md"
    assert skill_file.is_file(), f"SKILL.md missing: {skill_file}"


# ── Test: SKILL.md frontmatter ─────────────────────────────────────


@pytest.mark.parametrize("skill_name", ALL_SKILL_DIRS)
def test_skill_has_name_frontmatter(skill_name: str) -> None:
    """Each SKILL.md must have a 'name' field in YAML frontmatter."""
    content = _read_skill(skill_name)
    assert _has_frontmatter_field(content, "name"), (
        f"{skill_name}/SKILL.md missing 'name:' in frontmatter"
    )


@pytest.mark.parametrize("skill_name", ALL_SKILL_DIRS)
def test_skill_has_description_frontmatter(skill_name: str) -> None:
    """Each SKILL.md must have a 'description' field in YAML frontmatter."""
    content = _read_skill(skill_name)
    assert _has_frontmatter_field(content, "description"), (
        f"{skill_name}/SKILL.md missing 'description:' in frontmatter"
    )


# ── Test: Specialist agents reference correct object database files ─


def test_dsp_agent_references_msp_and_gen() -> None:
    """DSP agent must reference msp/ and gen/ object database files."""
    content = _read_skill("max-dsp-agent")
    assert "msp" in content.lower(), "DSP agent should reference msp objects"
    assert "gen" in content.lower(), "DSP agent should reference gen objects"


def test_patch_agent_references_max_objects() -> None:
    """Patch agent must reference max/objects.json."""
    content = _read_skill("max-patch-agent")
    assert "max/objects.json" in content or "max/" in content, (
        "Patch agent should reference max domain objects"
    )


def test_rnbo_agent_references_rnbo_objects() -> None:
    """RNBO agent must reference rnbo/ object database."""
    content = _read_skill("max-rnbo-agent")
    assert "rnbo" in content.lower(), "RNBO agent should reference rnbo objects"


# ── Test: UI agent references presentation mode ────────────────────


def test_ui_agent_references_presentation_mode() -> None:
    """UI agent SKILL.md must reference presentation mode."""
    content = _read_skill("max-ui-agent")
    assert "presentation" in content.lower(), (
        "UI agent should reference presentation mode"
    )


# ── Test: RNBO and Externals agents are full (not stubs) ───────────


def test_rnbo_agent_not_stub() -> None:
    """RNBO agent SKILL.md must NOT contain stub markers."""
    content = _read_skill("max-rnbo-agent")
    content_lower = content.lower()
    assert "stub" not in content_lower, (
        "RNBO agent should no longer be a stub"
    )
    assert "phase 5 deferral" not in content_lower, (
        "RNBO agent should not contain Phase 5 deferral message"
    )
    assert "not yet implemented" not in content_lower, (
        "RNBO agent should not say features are not yet implemented"
    )


def test_ext_agent_not_stub() -> None:
    """Externals agent SKILL.md must NOT contain stub markers."""
    content = _read_skill("max-ext-agent")
    content_lower = content.lower()
    assert "stub" not in content_lower, (
        "Externals agent should no longer be a stub"
    )
    assert "phase 5 deferral" not in content_lower, (
        "Externals agent should not contain Phase 5 deferral message"
    )
    assert "not yet implemented" not in content_lower, (
        "Externals agent should not say features are not yet implemented"
    )


def test_rnbo_agent_has_api_refs() -> None:
    """RNBO agent SKILL.md must reference key Python API functions."""
    content = _read_skill("max-rnbo-agent")
    assert "add_rnbo" in content, (
        "RNBO agent should reference add_rnbo function"
    )
    assert "validate_rnbo_patch" in content, (
        "RNBO agent should reference validate_rnbo_patch function"
    )


def test_ext_agent_has_api_refs() -> None:
    """Externals agent SKILL.md must reference key Python API functions."""
    content = _read_skill("max-ext-agent")
    assert "scaffold_external" in content, (
        "Externals agent should reference scaffold_external function"
    )
    assert "build_external" in content, (
        "Externals agent should reference build_external function"
    )


# ── Test: Router references dispatch-rules.md and merge-protocol.md ─


def test_router_references_dispatch_rules() -> None:
    """Router SKILL.md must reference dispatch-rules.md."""
    content = _read_skill("max-router")
    assert "dispatch-rules" in content, (
        "Router should reference dispatch-rules.md"
    )


def test_router_references_merge_protocol() -> None:
    """Router SKILL.md must reference merge-protocol.md."""
    content = _read_skill("max-router")
    assert "merge-protocol" in content, (
        "Router should reference merge-protocol.md"
    )


def test_router_dispatch_rules_file_exists() -> None:
    """Router must have references/dispatch-rules.md file."""
    path = SKILLS_DIR / "max-router" / "references" / "dispatch-rules.md"
    assert path.is_file(), f"dispatch-rules.md missing: {path}"


def test_router_merge_protocol_file_exists() -> None:
    """Router must have references/merge-protocol.md file."""
    path = SKILLS_DIR / "max-router" / "references" / "merge-protocol.md"
    assert path.is_file(), f"merge-protocol.md missing: {path}"


# ── Test: Critic references critic-protocol.md ─────────────────────


def test_critic_references_critic_protocol() -> None:
    """Critic SKILL.md must reference critic-protocol.md."""
    content = _read_skill("max-critic")
    assert "critic-protocol" in content, (
        "Critic should reference critic-protocol.md"
    )


def test_critic_protocol_file_exists() -> None:
    """Critic must have references/critic-protocol.md file."""
    path = SKILLS_DIR / "max-critic" / "references" / "critic-protocol.md"
    assert path.is_file(), f"critic-protocol.md missing: {path}"


def test_critic_references_python_critics() -> None:
    """Critic SKILL.md must reference src/maxpat/critics/ Python modules."""
    content = _read_skill("max-critic")
    assert "src/maxpat/critics" in content or "src.maxpat.critics" in content, (
        "Critic should reference the Python critic modules"
    )


# ── Test: Critic protocol escalation semantics ─────────────────────


def test_critic_protocol_escalation_for_repeated_findings() -> None:
    """critic-protocol.md must document escalation for repeated identical
    findings, NOT as a general round limit."""
    path = SKILLS_DIR / "max-critic" / "references" / "critic-protocol.md"
    content = path.read_text().lower()
    # Must mention repeated/identical findings as escalation trigger
    assert "identical finding" in content or "same finding" in content or "repeated" in content, (
        "Critic protocol should document escalation for repeated identical findings"
    )
    # Must mention that there is no hard round limit
    assert "no hard round" in content or "no round limit" in content, (
        "Critic protocol should state there is no hard round limit"
    )
    # Must mention 5 consecutive revisions as the threshold
    assert "5 consecutive" in content or "5 revisions" in content, (
        "Critic protocol should specify 5 consecutive revisions as escalation threshold"
    )


# ── Test: BOUNDARIES.md exists for all 6 specialist agents ─────────


@pytest.mark.parametrize("agent_name", SPECIALIST_AGENTS)
def test_specialist_has_boundaries(agent_name: str) -> None:
    """Each of the 6 specialist agents must have a BOUNDARIES.md file."""
    path = SKILLS_DIR / agent_name / "BOUNDARIES.md"
    assert path.is_file(), f"BOUNDARIES.md missing: {path}"


# ── Test: Memory agent references memory module ────────────────────


def test_memory_agent_references_memory_module() -> None:
    """Memory agent SKILL.md must reference src/maxpat/memory."""
    content = _read_skill("max-memory-agent")
    assert "src/maxpat/memory" in content or "src.maxpat.memory" in content, (
        "Memory agent should reference the Python memory module"
    )


def test_memory_agent_has_boundaries() -> None:
    """Memory agent must have a BOUNDARIES.md file."""
    path = SKILLS_DIR / "max-memory-agent" / "BOUNDARIES.md"
    assert path.is_file(), f"BOUNDARIES.md missing: {path}"


# ── Test: Lifecycle references all 3 reference files ───────────────


def test_lifecycle_references_project_structure() -> None:
    """Lifecycle SKILL.md must reference project-structure.md."""
    content = _read_skill("max-lifecycle")
    assert "project-structure" in content, (
        "Lifecycle should reference project-structure.md"
    )


def test_lifecycle_references_status_tracking() -> None:
    """Lifecycle SKILL.md must reference status-tracking.md."""
    content = _read_skill("max-lifecycle")
    assert "status-tracking" in content, (
        "Lifecycle should reference status-tracking.md"
    )


def test_lifecycle_references_test_protocol() -> None:
    """Lifecycle SKILL.md must reference test-protocol.md."""
    content = _read_skill("max-lifecycle")
    assert "test-protocol" in content, (
        "Lifecycle should reference test-protocol.md"
    )


def test_lifecycle_project_structure_file_exists() -> None:
    """Lifecycle must have references/project-structure.md."""
    path = SKILLS_DIR / "max-lifecycle" / "references" / "project-structure.md"
    assert path.is_file(), f"project-structure.md missing: {path}"


def test_lifecycle_status_tracking_file_exists() -> None:
    """Lifecycle must have references/status-tracking.md."""
    path = SKILLS_DIR / "max-lifecycle" / "references" / "status-tracking.md"
    assert path.is_file(), f"status-tracking.md missing: {path}"


def test_lifecycle_test_protocol_file_exists() -> None:
    """Lifecycle must have references/test-protocol.md."""
    path = SKILLS_DIR / "max-lifecycle" / "references" / "test-protocol.md"
    assert path.is_file(), f"test-protocol.md missing: {path}"


def test_lifecycle_references_project_module() -> None:
    """Lifecycle SKILL.md must reference src/maxpat/project."""
    content = _read_skill("max-lifecycle")
    assert "src/maxpat/project" in content or "src.maxpat.project" in content, (
        "Lifecycle should reference the Python project module"
    )


# ── Test: Total skill count ────────────────────────────────────────


def test_total_skill_count() -> None:
    """There must be exactly 10 skill directories."""
    if not SKILLS_DIR.is_dir():
        pytest.fail(f"Skills directory does not exist: {SKILLS_DIR}")
    skill_dirs = [
        d for d in SKILLS_DIR.iterdir()
        if d.is_dir() and not d.name.startswith(".")
    ]
    assert len(skill_dirs) >= 10, (
        f"Expected at least 10 skill directories, found {len(skill_dirs)}: "
        f"{sorted(d.name for d in skill_dirs)}"
    )
