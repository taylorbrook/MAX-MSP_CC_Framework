"""Tests for M4L database entries, relationships, overrides, and terminal names."""

import json
from pathlib import Path

import pytest

from src.maxpat.db_lookup import ObjectDatabase

DB_ROOT = Path(__file__).resolve().parent.parent / ".claude" / "max-objects"


@pytest.fixture(scope="module")
def db():
    return ObjectDatabase()


@pytest.fixture(scope="module")
def relationships():
    path = DB_ROOT / "relationships.json"
    return json.loads(path.read_text())


class TestLiveAdsrTilde:
    """live.adsr~ must be in m4l/objects.json with correct schema."""

    def test_lookup_returns_dict(self, db):
        obj = db.lookup("live.adsr~")
        assert obj is not None, "live.adsr~ not found in ObjectDatabase"

    def test_domain_is_m4l(self, db):
        obj = db.lookup("live.adsr~")
        assert obj["domain"] == "M4L"

    def test_has_5_inlets(self, db):
        obj = db.lookup("live.adsr~")
        assert len(obj["inlets"]) == 5

    def test_has_4_outlets(self, db):
        obj = db.lookup("live.adsr~")
        assert len(obj["outlets"]) == 4

    def test_maxclass_is_newobj(self, db):
        obj = db.lookup("live.adsr~")
        assert obj["maxclass"] == "newobj"

    def test_verified_false(self, db):
        obj = db.lookup("live.adsr~")
        assert obj["verified"] is False


class TestLiveAdsrui:
    """live.adsrui must be in m4l/objects.json with correct schema."""

    def test_lookup_returns_dict(self, db):
        obj = db.lookup("live.adsrui")
        assert obj is not None, "live.adsrui not found in ObjectDatabase"

    def test_domain_is_m4l(self, db):
        obj = db.lookup("live.adsrui")
        assert obj["domain"] == "M4L"

    def test_has_1_inlet(self, db):
        obj = db.lookup("live.adsrui")
        assert len(obj["inlets"]) == 1

    def test_has_at_least_9_outlets(self, db):
        obj = db.lookup("live.adsrui")
        assert len(obj["outlets"]) >= 9

    def test_maxclass_is_live_adsrui(self, db):
        obj = db.lookup("live.adsrui")
        assert obj["maxclass"] == "live.adsrui"

    def test_verified_false(self, db):
        obj = db.lookup("live.adsrui")
        assert obj["verified"] is False


class TestLiveScopeDomain:
    """live.scope~ must be in m4l domain, not packages."""

    def test_domain_is_m4l(self, db):
        obj = db.lookup("live.scope~")
        assert obj is not None, "live.scope~ not found"
        assert obj["domain"] == "M4L"

    def test_not_in_packages_json(self):
        packages_path = DB_ROOT / "packages" / "objects.json"
        packages = json.loads(packages_path.read_text())
        assert "live.scope~" not in packages, "live.scope~ should be removed from packages"

    def test_in_m4l_json(self):
        m4l_path = DB_ROOT / "m4l" / "objects.json"
        m4l = json.loads(m4l_path.read_text())
        assert "live.scope~" in m4l, "live.scope~ should be in m4l/objects.json"


class TestPluginPlugoutOverrides:
    """plugin~ and plugout~ must resolve to maxclass=newobj via overrides."""

    def test_plugin_maxclass_newobj(self, db):
        obj = db.lookup("plugin~")
        assert obj is not None, "plugin~ not found"
        assert obj["maxclass"] == "newobj"

    def test_plugout_maxclass_newobj(self, db):
        obj = db.lookup("plugout~")
        assert obj is not None, "plugout~ not found"
        assert obj["maxclass"] == "newobj"


class TestM4LRelationships:
    """M4L companion pairs must exist in relationships.json."""

    def _find_pair(self, relationships, *names):
        """Find a pair entry containing all given names."""
        for pair in relationships["pairs"]:
            if all(name in pair["objects"] for name in names):
                return pair
        return None

    def test_plugin_plugout_pair(self, relationships):
        pair = self._find_pair(relationships, "plugin~", "plugout~")
        assert pair is not None, "plugin~/plugout~ pair not found"
        assert pair["relationship"] == "required_pair"

    def test_live_path_live_object_pair(self, relationships):
        pair = self._find_pair(relationships, "live.path", "live.object")
        assert pair is not None, "live.path/live.object pair not found"
        assert pair["relationship"] == "required_pair"

    def test_midiin_midiout_pair(self, relationships):
        pair = self._find_pair(relationships, "midiin", "midiout")
        assert pair is not None, "midiin/midiout pair not found"
        assert pair["relationship"] == "required_pair"

    def test_live_thisdevice_loadbang_pair(self, relationships):
        pair = self._find_pair(relationships, "live.thisdevice", "loadbang")
        assert pair is not None, "live.thisdevice/loadbang pair not found"
        assert pair["relationship"] == "common_pair"


class TestNewObjectsSchema:
    """All new objects must pass full schema validation."""

    REQUIRED_FIELDS = [
        "name", "maxclass", "module", "domain",
        "inlets", "outlets", "arguments", "messages",
        "min_version", "verified", "variable_io", "rnbo_compatible",
    ]

    @pytest.mark.parametrize("obj_name", ["live.adsr~", "live.adsrui"])
    def test_has_all_required_fields(self, db, obj_name):
        obj = db.lookup(obj_name)
        assert obj is not None, f"{obj_name} not found"
        for field in self.REQUIRED_FIELDS:
            assert field in obj, f"{obj_name} missing field: {field}"

    @pytest.mark.parametrize("obj_name", ["live.adsr~", "live.adsrui"])
    def test_inlets_have_required_keys(self, db, obj_name):
        obj = db.lookup(obj_name)
        for inlet in obj["inlets"]:
            assert "id" in inlet
            assert "type" in inlet
            assert "signal" in inlet

    @pytest.mark.parametrize("obj_name", ["live.adsr~", "live.adsrui"])
    def test_outlets_have_required_keys(self, db, obj_name):
        obj = db.lookup(obj_name)
        for outlet in obj["outlets"]:
            assert "id" in outlet
            assert "type" in outlet
            assert "signal" in outlet
