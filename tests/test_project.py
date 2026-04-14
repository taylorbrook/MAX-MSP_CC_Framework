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
    init_versions,
    get_version,
    bump_version,
    list_versions,
    build_examples_catalog,
    update_version_comment,
    load_project_config,
    save_project_config,
    get_allowed_packages,
)


class TestCreateProject:
    """Tests for create_project function."""

    def test_creates_all_expected_directories_and_files(self, tmp_path: Path):
        project_path = create_project("my-synth", tmp_path)

        assert project_path == tmp_path / "patches" / "my-synth"
        assert project_path.is_dir()

        # Directories
        assert (project_path / "generated").is_dir()
        assert (project_path / "test-results").is_dir()

        # Files
        assert (project_path / "context.md").is_file()
        assert (project_path / "status.md").is_file()

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

    def test_creates_empty_maxpat(self, tmp_path: Path):
        """create_project produces a valid empty .maxpat in generated/."""
        project_path = create_project("my-synth", tmp_path)
        maxpat_file = project_path / "generated" / "my-synth.maxpat"
        assert maxpat_file.is_file()
        data = json.loads(maxpat_file.read_text())
        assert "patcher" in data
        assert isinstance(data["patcher"]["boxes"], list)
        assert isinstance(data["patcher"]["lines"], list)


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


class TestVersioning:
    """Tests for version management: init_versions, get_version, bump_version, list_versions."""

    def test_init_versions_creates_file(self, tmp_path: Path):
        project_dir = create_project("my-synth", tmp_path)
        # create_project now auto-calls init_versions, but let's verify the file exists
        versions_file = project_dir / "versions.json"
        assert versions_file.is_file()
        data = json.loads(versions_file.read_text())
        assert len(data["versions"]) == 1
        assert data["versions"][0]["version"] == "0.0.0"
        assert data["versions"][0]["description"] == "Initial version"
        assert "timestamp" in data["versions"][0]

    def test_init_versions_idempotent(self, tmp_path: Path):
        project_dir = create_project("my-synth", tmp_path)
        # Already initialized by create_project -- calling again should be a no-op
        result = init_versions(project_dir)
        assert result == "0.0.0"
        data = json.loads((project_dir / "versions.json").read_text())
        assert len(data["versions"]) == 1

    def test_init_versions_returns_current_version(self, tmp_path: Path):
        project_dir = create_project("my-synth", tmp_path)
        result = init_versions(project_dir)
        assert result == "0.0.0"

    def test_get_version_returns_current(self, tmp_path: Path):
        project_dir = create_project("my-synth", tmp_path)
        assert get_version(project_dir) == "0.0.0"

    def test_get_version_returns_none_no_file(self, tmp_path: Path):
        project_dir = tmp_path / "no-project"
        project_dir.mkdir()
        assert get_version(project_dir) is None

    def test_bump_version_patch(self, tmp_path: Path):
        project_dir = create_project("my-synth", tmp_path)
        new_ver = bump_version(project_dir, bump="patch", description="Fixed a bug")
        assert new_ver == "0.0.1"
        assert get_version(project_dir) == "0.0.1"

    def test_bump_version_minor(self, tmp_path: Path):
        project_dir = create_project("my-synth", tmp_path)
        bump_version(project_dir, bump="patch", description="Fix")
        new_ver = bump_version(project_dir, bump="minor", description="Added feature")
        assert new_ver == "0.1.0"
        assert get_version(project_dir) == "0.1.0"

    def test_bump_version_major(self, tmp_path: Path):
        project_dir = create_project("my-synth", tmp_path)
        bump_version(project_dir, bump="minor", description="Feature")
        new_ver = bump_version(project_dir, bump="major", description="Breaking change")
        assert new_ver == "1.0.0"
        assert get_version(project_dir) == "1.0.0"

    def test_bump_version_invalid_type_raises(self, tmp_path: Path):
        project_dir = create_project("my-synth", tmp_path)
        with pytest.raises(ValueError, match="must be"):
            bump_version(project_dir, bump="hotfix", description="Nope")

    def test_bump_version_no_file_raises(self, tmp_path: Path):
        project_dir = tmp_path / "no-project"
        project_dir.mkdir()
        with pytest.raises(FileNotFoundError):
            bump_version(project_dir, bump="patch", description="Nope")

    def test_bump_version_returns_new_version(self, tmp_path: Path):
        project_dir = create_project("my-synth", tmp_path)
        result = bump_version(project_dir, bump="patch", description="Test")
        assert result == "0.0.1"

    def test_list_versions_returns_newest_first(self, tmp_path: Path):
        project_dir = create_project("my-synth", tmp_path)
        bump_version(project_dir, bump="patch", description="First fix")
        bump_version(project_dir, bump="minor", description="New feature")

        versions = list_versions(project_dir)
        assert len(versions) == 3
        # Newest first
        assert versions[0]["version"] == "0.1.0"
        assert versions[1]["version"] == "0.0.1"
        assert versions[2]["version"] == "0.0.0"

    def test_list_versions_empty_no_file(self, tmp_path: Path):
        project_dir = tmp_path / "no-project"
        project_dir.mkdir()
        assert list_versions(project_dir) == []

    def test_list_versions_has_descriptions(self, tmp_path: Path):
        project_dir = create_project("my-synth", tmp_path)
        bump_version(project_dir, bump="patch", description="Fixed oscillator")

        versions = list_versions(project_dir)
        assert versions[0]["description"] == "Fixed oscillator"
        assert versions[0]["version"] == "0.0.1"
        assert "timestamp" in versions[0]

    def test_create_project_initializes_versions(self, tmp_path: Path):
        """create_project should auto-create versions.json with 0.0.0."""
        project_dir = create_project("auto-versioned", tmp_path)
        assert (project_dir / "versions.json").is_file()
        assert get_version(project_dir) == "0.0.0"

    def test_bump_minor_resets_patch(self, tmp_path: Path):
        project_dir = create_project("my-synth", tmp_path)
        bump_version(project_dir, bump="patch", description="p1")
        bump_version(project_dir, bump="patch", description="p2")
        assert get_version(project_dir) == "0.0.2"
        new_ver = bump_version(project_dir, bump="minor", description="minor bump")
        assert new_ver == "0.1.0"

    def test_bump_major_resets_minor_and_patch(self, tmp_path: Path):
        project_dir = create_project("my-synth", tmp_path)
        bump_version(project_dir, bump="minor", description="m1")
        bump_version(project_dir, bump="patch", description="p1")
        assert get_version(project_dir) == "0.1.1"
        new_ver = bump_version(project_dir, bump="major", description="major bump")
        assert new_ver == "1.0.0"


def _setup_test_project(tmp_path: Path, name: str, files: dict[str, str],
                         context_md: str = "# test\n\nA test project.\n",
                         version: str = "0.0.0") -> Path:
    """Helper to create a minimal project structure for catalog tests."""
    project_dir = tmp_path / "patches" / name
    generated_dir = project_dir / "generated"
    generated_dir.mkdir(parents=True)

    # Write generated files
    for fname, content in files.items():
        (generated_dir / fname).write_text(content)

    # Write context.md
    (project_dir / "context.md").write_text(context_md)

    # Write versions.json
    versions_data = {
        "versions": [
            {"version": version, "description": "Initial", "timestamp": "2026-01-01T00:00:00Z"}
        ]
    }
    (project_dir / "versions.json").write_text(json.dumps(versions_data, indent=2))

    return project_dir


class TestBuildExamplesCatalog:
    """Tests for build_examples_catalog function."""

    def test_creates_examples_directories(self, tmp_path: Path):
        """Test 1: build_examples_catalog() creates examples/{project}/ directories."""
        _setup_test_project(tmp_path, "alpha", {"patch.maxpat": '{"patcher": {}}'})
        _setup_test_project(tmp_path, "beta", {"synth.maxpat": '{"patcher": {}}'})

        build_examples_catalog(tmp_path)

        assert (tmp_path / "examples" / "alpha").is_dir()
        assert (tmp_path / "examples" / "beta").is_dir()

    def test_only_copies_patch_files(self, tmp_path: Path):
        """Test 2: Only .maxpat, .gendsp, and .js files are copied."""
        _setup_test_project(tmp_path, "myproj", {
            "main.maxpat": '{"patcher": {}}',
            "engine.gendsp": '{"patcher": {}}',
            "helper.js": 'var x = 1;',
            "build.py": 'print("hello")',
            "notes.txt": 'some notes',
            "data.json": '{}',
        })

        build_examples_catalog(tmp_path)

        examples_dir = tmp_path / "examples" / "myproj"
        copied_files = sorted(f.name for f in examples_dir.iterdir())
        assert copied_files == ["engine.gendsp", "helper.js", "main.maxpat"]

    def test_copied_files_are_identical(self, tmp_path: Path):
        """Test 3: Copied files are byte-identical to originals."""
        content = '{"patcher": {"boxes": []}}'
        _setup_test_project(tmp_path, "myproj", {"main.maxpat": content})

        build_examples_catalog(tmp_path)

        source = tmp_path / "patches" / "myproj" / "generated" / "main.maxpat"
        dest = tmp_path / "examples" / "myproj" / "main.maxpat"
        assert source.read_bytes() == dest.read_bytes()

    def test_patches_md_created_with_project_info(self, tmp_path: Path):
        """Test 4: PATCHES.md is created with project names, versions, descriptions, and file lists."""
        _setup_test_project(tmp_path, "alpha", {"patch.maxpat": '{}'},
                           context_md="# alpha\n\nMy alpha project.\n", version="1.2.3")

        result = build_examples_catalog(tmp_path)

        assert result == tmp_path / "PATCHES.md"
        assert result.is_file()
        content = result.read_text()
        assert "alpha" in content
        assert "1.2.3" in content
        assert "My alpha project." in content
        assert "patch.maxpat" in content

    def test_patches_md_has_table_row_per_project(self, tmp_path: Path):
        """Test 5: PATCHES.md contains a table row for each project with version."""
        _setup_test_project(tmp_path, "alpha", {"a.maxpat": '{}'},
                           context_md="# alpha\n\nAlpha desc.\n", version="0.1.0")
        _setup_test_project(tmp_path, "beta", {"b.maxpat": '{}'},
                           context_md="# beta\n\nBeta desc.\n", version="0.2.0")

        build_examples_catalog(tmp_path)

        content = (tmp_path / "PATCHES.md").read_text()
        # Check table header
        assert "| Project | Version | Description |" in content
        # Check table rows contain project info
        assert "alpha" in content
        assert "0.1.0" in content
        assert "beta" in content
        assert "0.2.0" in content

    def test_idempotent_rebuild(self, tmp_path: Path):
        """Test 6: Running build_examples_catalog() twice is idempotent."""
        _setup_test_project(tmp_path, "myproj", {"main.maxpat": '{"data": 1}'})

        build_examples_catalog(tmp_path)
        first_content = (tmp_path / "PATCHES.md").read_text()
        first_files = sorted(f.name for f in (tmp_path / "examples" / "myproj").iterdir())

        build_examples_catalog(tmp_path)
        second_content = (tmp_path / "PATCHES.md").read_text()
        second_files = sorted(f.name for f in (tmp_path / "examples" / "myproj").iterdir())

        assert first_content == second_content
        assert first_files == second_files

    def test_description_from_context_md(self, tmp_path: Path):
        """Test 7: Project description is extracted from first non-empty, non-heading line of context.md."""
        _setup_test_project(tmp_path, "myproj", {"main.maxpat": '{}'},
                           context_md="# myproj\n\nThis is the real description.\n\n## Details\nMore stuff.\n")

        build_examples_catalog(tmp_path)

        content = (tmp_path / "PATCHES.md").read_text()
        assert "This is the real description." in content

    def test_description_fallback_no_context(self, tmp_path: Path):
        """Description defaults to 'No description' when context.md has only headings."""
        _setup_test_project(tmp_path, "myproj", {"main.maxpat": '{}'},
                           context_md="# myproj\n\n## Section\n\n### Subsection\n")

        build_examples_catalog(tmp_path)

        content = (tmp_path / "PATCHES.md").read_text()
        assert "No description" in content


class TestUpdateVersionComment:
    """Tests for update_version_comment function."""

    def test_adds_version_comment_to_empty_patcher(self):
        """Test 1: update_version_comment on empty patcher adds a comment box with text 'v0.1.0'."""
        from src.maxpat.patcher import Patcher

        p = Patcher()
        update_version_comment(p, "0.1.0")

        comments = p.find_boxes(maxclass="comment")
        assert len(comments) == 1
        assert comments[0].text == "v0.1.0"

    def test_comment_positioned_in_top_right(self):
        """Test 2: comment is positioned in top-right area (x >= 500, y <= 30)."""
        from src.maxpat.patcher import Patcher

        p = Patcher()
        box = update_version_comment(p, "0.1.0")

        x = box.patching_rect[0]
        y = box.patching_rect[1]
        assert x >= 500, f"x={x} should be >= 500"
        assert y <= 30, f"y={y} should be <= 30"

    def test_updates_existing_version_comment_in_place(self):
        """Test 3: update on patcher with existing version comment updates text, no duplicate."""
        from src.maxpat.patcher import Patcher

        p = Patcher()
        update_version_comment(p, "0.1.0")
        update_version_comment(p, "0.2.0")

        comments = p.find_boxes(maxclass="comment")
        version_comments = [c for c in comments if c.text.startswith("v") and "." in c.text]
        assert len(version_comments) == 1
        assert version_comments[0].text == "v0.2.0"

    def test_leaves_non_version_comments_untouched(self):
        """Test 4: non-version comments are untouched, version comment still added."""
        from src.maxpat.patcher import Patcher

        p = Patcher()
        p.add_comment("This is a regular comment", x=10.0, y=10.0)
        p.add_comment("Another note", x=10.0, y=30.0)
        update_version_comment(p, "1.0.0")

        comments = p.find_boxes(maxclass="comment")
        assert len(comments) == 3  # 2 regular + 1 version
        texts = sorted(c.text for c in comments)
        assert "Another note" in texts
        assert "This is a regular comment" in texts
        assert "v1.0.0" in texts

    def test_returns_box_object(self):
        """Test 5: returns the Box object for the version comment."""
        from src.maxpat.patcher import Patcher, Box

        p = Patcher()
        result = update_version_comment(p, "0.1.0")
        assert isinstance(result, Box)
        assert result.text == "v0.1.0"


class TestProjectConfig:
    """Tests for project config (config.json) read/write functions."""

    def test_load_returns_none_when_no_config(self, tmp_path: Path):
        """load_project_config returns None when config.json does not exist."""
        project_dir = create_project("my-synth", tmp_path)
        result = load_project_config(project_dir)
        assert result is None

    def test_load_returns_dict_when_config_exists(self, tmp_path: Path):
        """load_project_config returns dict when config.json exists."""
        project_dir = create_project("my-synth", tmp_path)
        config = {"packages": ["BEAP"]}
        (project_dir / "config.json").write_text(json.dumps(config, indent=2) + "\n")

        result = load_project_config(project_dir)
        assert isinstance(result, dict)
        assert result == {"packages": ["BEAP"]}

    def test_save_writes_config_json(self, tmp_path: Path):
        """save_project_config writes config.json with correct JSON content."""
        project_dir = create_project("my-synth", tmp_path)
        config = {"packages": ["BEAP", "Vizzie"]}
        save_project_config(project_dir, config)

        config_path = project_dir / "config.json"
        assert config_path.is_file()
        data = json.loads(config_path.read_text())
        assert data == {"packages": ["BEAP", "Vizzie"]}

    def test_save_overwrites_existing_config(self, tmp_path: Path):
        """save_project_config overwrites existing config.json."""
        project_dir = create_project("my-synth", tmp_path)
        save_project_config(project_dir, {"packages": ["BEAP"]})
        save_project_config(project_dir, {"packages": ["Vizzie", "FluCoMa"]})

        data = json.loads((project_dir / "config.json").read_text())
        assert data == {"packages": ["Vizzie", "FluCoMa"]}

    def test_get_allowed_packages_none_when_no_config(self, tmp_path: Path):
        """get_allowed_packages returns None when no config.json exists."""
        project_dir = create_project("my-synth", tmp_path)
        result = get_allowed_packages(project_dir)
        assert result is None

    def test_get_allowed_packages_empty_list_when_empty(self, tmp_path: Path):
        """get_allowed_packages returns empty list when packages key is empty."""
        project_dir = create_project("my-synth", tmp_path)
        save_project_config(project_dir, {"packages": []})

        result = get_allowed_packages(project_dir)
        assert result == []

    def test_get_allowed_packages_returns_package_list(self, tmp_path: Path):
        """get_allowed_packages returns package names from config."""
        project_dir = create_project("my-synth", tmp_path)
        save_project_config(project_dir, {"packages": ["BEAP", "Vizzie"]})

        result = get_allowed_packages(project_dir)
        assert result == ["BEAP", "Vizzie"]

    def test_round_trip_preserves_data(self, tmp_path: Path):
        """Round-trip save then load preserves data exactly."""
        project_dir = create_project("my-synth", tmp_path)
        original = {"packages": ["BEAP", "Vizzie"], "extra_key": "extra_value"}
        save_project_config(project_dir, original)

        loaded = load_project_config(project_dir)
        assert loaded == original
