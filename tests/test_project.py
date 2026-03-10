"""Tests for project lifecycle management -- creation, tracking, status."""

import json
from pathlib import Path

import pytest

from src.maxpat.project import (
    create_project,
    get_active_project,
    set_active_project,
    read_status,
    update_status,
    list_projects,
)


class TestCreateProject:
    """Tests for create_project function."""

    def test_creates_all_expected_directories_and_files(self, tmp_path: Path):
        project_path = create_project("my-synth", tmp_path)

        assert project_path == tmp_path / "patches" / "my-synth"
        assert project_path.is_dir()

        # Directories
        assert (project_path / ".max-memory").is_dir()
        assert (project_path / "generated").is_dir()
        assert (project_path / "test-results").is_dir()

        # Files
        assert (project_path / "context.md").is_file()
        assert (project_path / "status.md").is_file()
        assert (project_path / ".max-memory" / "patterns.md").is_file()

    def test_invalid_name_uppercase_raises(self, tmp_path: Path):
        with pytest.raises(ValueError, match="Invalid project name"):
            create_project("MyProject", tmp_path)

    def test_invalid_name_spaces_raises(self, tmp_path: Path):
        with pytest.raises(ValueError, match="Invalid project name"):
            create_project("my project", tmp_path)

    def test_invalid_name_special_chars_raises(self, tmp_path: Path):
        with pytest.raises(ValueError, match="Invalid project name"):
            create_project("my_synth!", tmp_path)

    def test_invalid_name_leading_hyphen_raises(self, tmp_path: Path):
        with pytest.raises(ValueError, match="Invalid project name"):
            create_project("-bad-name", tmp_path)

    def test_valid_name_lowercase_hyphens(self, tmp_path: Path):
        project_path = create_project("cool-synth-3", tmp_path)
        assert project_path.is_dir()

    def test_existing_project_raises(self, tmp_path: Path):
        create_project("my-synth", tmp_path)
        with pytest.raises(ValueError, match="already exists"):
            create_project("my-synth", tmp_path)

    def test_status_md_initialized_correctly(self, tmp_path: Path):
        project_path = create_project("my-synth", tmp_path)
        status = read_status(project_path)
        assert status["stage"] == "ideation"
        assert status["progress"] == ""
        assert "created" in status


class TestActiveProject:
    """Tests for set_active_project / get_active_project."""

    def test_set_active_writes_json(self, tmp_path: Path):
        create_project("my-synth", tmp_path)
        set_active_project("my-synth", tmp_path)

        active_file = tmp_path / "patches" / ".active-project.json"
        assert active_file.is_file()
        data = json.loads(active_file.read_text())
        assert data["name"] == "my-synth"
        assert "activated" in data

    def test_get_active_returns_dict(self, tmp_path: Path):
        create_project("my-synth", tmp_path)
        set_active_project("my-synth", tmp_path)

        result = get_active_project(tmp_path)
        assert isinstance(result, dict)
        assert result["name"] == "my-synth"

    def test_get_active_returns_none_when_no_file(self, tmp_path: Path):
        result = get_active_project(tmp_path)
        assert result is None

    def test_get_active_returns_none_when_project_dir_missing(self, tmp_path: Path):
        """Desync detection: .active-project.json references a project that no longer exists."""
        patches_dir = tmp_path / "patches"
        patches_dir.mkdir(parents=True)
        active_file = patches_dir / ".active-project.json"
        active_file.write_text(json.dumps({"name": "deleted-project", "activated": "2026-01-01T00:00:00Z"}))

        result = get_active_project(tmp_path)
        assert result is None


class TestReadStatus:
    """Tests for read_status function."""

    def test_reads_initialized_fields(self, tmp_path: Path):
        project_path = create_project("my-synth", tmp_path)
        status = read_status(project_path)

        assert "stage" in status
        assert "progress" in status
        assert "created" in status
        assert status["stage"] == "ideation"


class TestUpdateStatus:
    """Tests for update_status function."""

    def test_changes_stage(self, tmp_path: Path):
        project_path = create_project("my-synth", tmp_path)
        update_status(project_path, stage="build")

        status = read_status(project_path)
        assert status["stage"] == "build"

    def test_changes_progress(self, tmp_path: Path):
        project_path = create_project("my-synth", tmp_path)
        update_status(project_path, progress="50% complete")

        status = read_status(project_path)
        assert status["progress"] == "50% complete"

    def test_changes_multiple_fields(self, tmp_path: Path):
        project_path = create_project("my-synth", tmp_path)
        update_status(project_path, stage="verify", progress="testing audio chain")

        status = read_status(project_path)
        assert status["stage"] == "verify"
        assert status["progress"] == "testing audio chain"


class TestListProjects:
    """Tests for list_projects function."""

    def test_returns_project_names(self, tmp_path: Path):
        create_project("alpha", tmp_path)
        create_project("beta", tmp_path)
        create_project("gamma", tmp_path)

        projects = list_projects(tmp_path)
        assert sorted(projects) == ["alpha", "beta", "gamma"]

    def test_excludes_hidden_files(self, tmp_path: Path):
        create_project("my-synth", tmp_path)
        set_active_project("my-synth", tmp_path)

        projects = list_projects(tmp_path)
        assert ".active-project.json" not in projects
        assert "my-synth" in projects

    def test_empty_when_no_patches_dir(self, tmp_path: Path):
        projects = list_projects(tmp_path)
        assert projects == []
