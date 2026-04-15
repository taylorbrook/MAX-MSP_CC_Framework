"""DBSI-01 through DBSI-06: Package schema, registry, and API tests."""

import json
from pathlib import Path

import pytest


class TestPackageObjectSchema:
    """DBSI-01, DBSI-05, DBSI-06: Package objects have correct tags and structure."""

    def test_package_objects_have_package_field(self, db_root):
        """DBSI-01: Every object in packages/*/objects.json has a 'package' string field."""
        pkg_root = db_root / "packages"
        for pkg_dir in sorted(pkg_root.iterdir()):
            if not pkg_dir.is_dir():
                continue
            json_path = pkg_dir / "objects.json"
            if not json_path.exists():
                continue
            data = json.loads(json_path.read_text())
            for name, obj in data.items():
                assert isinstance(obj.get("package"), str), (
                    f"Object '{name}' in packages/{pkg_dir.name}/ missing 'package' string field"
                )
                assert obj["package"] == pkg_dir.name, (
                    f"Object '{name}' package field '{obj['package']}' != directory '{pkg_dir.name}'"
                )

    def test_core_objects_have_no_package_field(self, db_root):
        """D-03: Objects from core domains (max, msp, jitter, etc.) do NOT have a 'package' field."""
        core_dirs = ["max", "msp", "jitter", "mc", "gen", "m4l", "rnbo"]
        for domain_dir in core_dirs:
            json_path = db_root / domain_dir / "objects.json"
            if not json_path.exists():
                continue
            data = json.loads(json_path.read_text())
            for name, obj in data.items():
                assert "package" not in obj, (
                    f"Core object '{name}' in {domain_dir}/ should NOT have a 'package' field"
                )

    def test_per_package_directories(self, db_root):
        """DBSI-05: All extracted packages have directories with objects.json."""
        expected = ["ableton-dsp", "Mira", "jit.mo", "BEAP", "Vizzie", "Jitter Geometry", "Jitter Tools"]
        for pkg_name in expected:
            pkg_dir = db_root / "packages" / pkg_name
            assert pkg_dir.is_dir(), f"Package directory '{pkg_name}' does not exist"
            json_path = pkg_dir / "objects.json"
            assert json_path.exists(), f"Package '{pkg_name}' missing objects.json"

    def test_migration_completeness(self, db_root):
        """DBSI-06: Total objects across per-package dirs >= 400 (BEAP+Vizzie+Jitter+existing)."""
        pkg_root = db_root / "packages"
        total = 0
        for pkg_dir in sorted(pkg_root.iterdir()):
            if not pkg_dir.is_dir():
                continue
            json_path = pkg_dir / "objects.json"
            if json_path.exists():
                data = json.loads(json_path.read_text())
                total += len(data)
        assert total >= 400, f"Expected >= 400 total package objects (BEAP+Vizzie+Jitter+existing), got {total}"


class TestPackageInfoSchema:
    """DBSI-02: package_info.json has required fields for every entry."""

    REQUIRED_FIELDS = [
        "name", "tier", "prefix", "version", "install_method",
        "description", "object_count", "extracted",
    ]

    def test_package_info_exists(self, db_root):
        """package_info.json must exist."""
        assert (db_root / "package_info.json").exists()

    def test_package_info_schema(self, db_root):
        """DBSI-02: Every entry has required fields with correct types."""
        data = json.loads((db_root / "package_info.json").read_text())
        assert isinstance(data, dict), "package_info.json must be a JSON object"
        assert len(data) > 0, "package_info.json must not be empty"
        for key, entry in data.items():
            for field in self.REQUIRED_FIELDS:
                assert field in entry, (
                    f"Package '{key}' missing required field '{field}'"
                )
            assert isinstance(entry["name"], str)
            assert isinstance(entry["tier"], str)
            assert isinstance(entry["extracted"], bool)

    def test_package_info_keys_match_names(self, db_root):
        """D-01: Each key in package_info.json equals entry['name']."""
        data = json.loads((db_root / "package_info.json").read_text())
        for key, entry in data.items():
            assert key == entry["name"], (
                f"Key '{key}' does not match entry name '{entry['name']}'"
            )


class TestPackageAPI:
    """DBSI-03, DBSI-04: ObjectDatabase package-aware API methods."""

    @pytest.fixture(scope="class")
    def db(self):
        from src.maxpat.db_lookup import ObjectDatabase
        return ObjectDatabase()

    # --- allowed_packages filtering (DBSI-03) ---

    def test_allowed_packages_none_returns_all(self, db):
        """D-05: lookup() without allowed_packages returns package objects."""
        obj = db.lookup("abl.device.autofilter~")
        assert obj is not None, "abl.device.autofilter~ should be found with no filtering"

    def test_allowed_packages_empty_returns_core_only(self, db):
        """D-06: allowed_packages=[] returns None for package objects, obj for core."""
        pkg_obj = db.lookup("abl.device.autofilter~", allowed_packages=[])
        assert pkg_obj is None, "Package object should be filtered out with allowed_packages=[]"
        core_obj = db.lookup("cycle~", allowed_packages=[])
        assert core_obj is not None, "Core object should pass through with allowed_packages=[]"

    def test_allowed_packages_specific(self, db):
        """DBSI-03: Specific package in allowed list returns its objects."""
        obj = db.lookup("abl.device.autofilter~", allowed_packages=["ableton-dsp"])
        assert obj is not None, "Object should be found when its package is allowed"
        obj_wrong = db.lookup("abl.device.autofilter~", allowed_packages=["BEAP"])
        assert obj_wrong is None, "Object should NOT be found when its package is not allowed"

    # --- list_packages / get_package_objects (DBSI-04) ---

    def test_list_packages(self, db):
        """DBSI-04: list_packages() returns sorted list of populated packages."""
        packages = db.list_packages()
        assert isinstance(packages, list)
        assert "ableton-dsp" in packages
        assert "Mira" in packages
        assert "jit.mo" in packages
        # Verify sorted
        assert packages == sorted(packages)

    def test_list_packages_includes_populated(self, db):
        """DBSI-04: list_packages() includes populated packages."""
        packages = db.list_packages()
        assert "BEAP" in packages, "BEAP should be in list_packages after extraction"
        assert "Vizzie" in packages, "Vizzie should be in list_packages after extraction"

    def test_get_package_objects(self, db):
        """DBSI-04: get_package_objects() returns objects for a package."""
        objs = db.get_package_objects("ableton-dsp")
        assert isinstance(objs, list)
        assert len(objs) == 77, f"Expected 77 ableton-dsp objects, got {len(objs)}"
        for obj in objs:
            assert isinstance(obj.get("name"), str), "Each object must have a name"

    def test_get_package_objects_unknown(self, db):
        """DBSI-04: get_package_objects() returns empty list for unknown package."""
        objs = db.get_package_objects("nonexistent")
        assert objs == []

    # --- Convenience methods ---

    def test_is_core(self, db):
        """is_core() returns True for core objects, False for package objects."""
        assert db.is_core("cycle~") is True
        assert db.is_core("abl.device.autofilter~") is False

    def test_get_package(self, db):
        """get_package() returns package name or None."""
        assert db.get_package("abl.device.autofilter~") == "ableton-dsp"
        assert db.get_package("cycle~") is None

    def test_get_package_info(self, db):
        """get_package_info() returns registry entry from package_info.json."""
        info = db.get_package_info("ableton-dsp")
        assert info is not None
        assert info["name"] == "ableton-dsp"
        assert "tier" in info

    def test_get_package_info_unknown(self, db):
        """get_package_info() returns None for unknown package."""
        assert db.get_package_info("nonexistent") is None

    # --- Migration verification ---

    def test_beap_package_objects(self, db):
        """BEAP objects accessible via get_package_objects."""
        objs = db.get_package_objects("BEAP")
        assert len(objs) >= 180

    def test_vizzie_package_objects(self, db):
        """Vizzie objects accessible via get_package_objects."""
        objs = db.get_package_objects("Vizzie")
        assert len(objs) >= 100

    def test_jitter_geometry_package_objects(self, db):
        """Jitter Geometry objects accessible via get_package_objects."""
        objs = db.get_package_objects("Jitter Geometry")
        assert len(objs) >= 25

    def test_jitter_tools_package_objects(self, db):
        """Jitter Tools objects accessible via get_package_objects."""
        objs = db.get_package_objects("Jitter Tools")
        assert len(objs) >= 90

    # --- Migration verification ---

    def test_jit_mo_sin_migrated(self, db):
        """jit.mo.sin should be in jit.mo package with Packages domain."""
        obj = db.lookup("jit.mo.sin")
        assert obj is not None, "jit.mo.sin not found in database"
        assert obj.get("package") == "jit.mo", (
            f"jit.mo.sin package should be 'jit.mo', got '{obj.get('package')}'"
        )
        assert obj.get("domain") == "Packages", (
            f"jit.mo.sin domain should be 'Packages', got '{obj.get('domain')}'"
        )


class TestPackageRelationships:
    """Package relationship entries in relationships.json."""

    @pytest.fixture(scope="class")
    def relationships(self, db_root):
        data = json.loads((db_root / "relationships.json").read_text())
        return data["pairs"]

    def test_relationships_has_package_pairs(self, relationships):
        """relationships.json must have >= 15 entries with 'package' field."""
        pkg_pairs = [p for p in relationships if "package" in p]
        assert len(pkg_pairs) >= 15, (
            f"Expected >= 15 package pairs, got {len(pkg_pairs)}"
        )

    def test_package_pairs_have_required_fields(self, relationships):
        """Every entry with 'package' must also have 'objects', 'relationship', 'note'."""
        for pair in relationships:
            if "package" not in pair:
                continue
            assert "objects" in pair, f"Package pair missing 'objects': {pair}"
            assert "relationship" in pair, f"Package pair missing 'relationship': {pair}"
            assert "note" in pair, f"Package pair missing 'note': {pair}"
            assert isinstance(pair["objects"], list), f"'objects' must be a list: {pair}"
            assert len(pair["objects"]) >= 2, f"'objects' must have >= 2 items: {pair}"

    def test_core_pairs_unchanged(self, relationships):
        """Entries without 'package' field must be >= 19 (original count)."""
        core_pairs = [p for p in relationships if "package" not in p]
        assert len(core_pairs) >= 19, (
            f"Expected >= 19 core pairs (original count), got {len(core_pairs)}"
        )

    def test_package_pair_objects_in_db(self, relationships):
        """For each package pair, both objects must exist in the DB."""
        from src.maxpat.db_lookup import ObjectDatabase
        db = ObjectDatabase()
        for pair in relationships:
            if "package" not in pair:
                continue
            for obj_name in pair["objects"]:
                assert db.lookup(obj_name) is not None, (
                    f"Object '{obj_name}' from package pair not found in DB"
                )

    def test_relationship_types_valid(self, relationships):
        """All 'relationship' values must be from the allowed set."""
        valid_types = {
            "required_pair", "common_pair", "equivalent",
            "required_group", "signal_chain", "cv_pair", "matrix_chain",
        }
        for pair in relationships:
            assert pair["relationship"] in valid_types, (
                f"Invalid relationship type '{pair['relationship']}' in {pair}"
            )


class TestPackagesReference:
    """PACKAGES.md shared reference document tests."""

    @pytest.fixture(scope="class")
    def packages_md(self, db_root):
        path = db_root / "PACKAGES.md"
        assert path.exists(), "PACKAGES.md must exist"
        return path.read_text()

    def test_packages_md_exists(self, db_root):
        """.claude/max-objects/PACKAGES.md must exist."""
        assert (db_root / "PACKAGES.md").exists()

    def test_packages_md_has_signal_conventions(self, packages_md):
        """Content must contain signal conventions."""
        assert "Signal Conventions" in packages_md
        assert "0-5V" in packages_md or "0 to +5V" in packages_md

    def test_packages_md_has_beap_templates(self, packages_md):
        """Content must contain BEAP templates."""
        assert "Subtractive" in packages_md
        assert "bp.Oscillator" in packages_md

    def test_packages_md_has_vizzie_templates(self, packages_md):
        """Content must contain Vizzie templates."""
        assert "vz.playr" in packages_md
        assert "vz.viewr" in packages_md
