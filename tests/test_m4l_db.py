"""Tests for M4L database gap closures (DB-01, DB-02, DB-03).

Verifies that overrides.json fixes domain classification and I/O data
for live.scope~, live.adsrui, and live.adsr~ objects, and that
relationships.json contains M4L object pairs.
"""

import json
from pathlib import Path

import pytest

from src.maxpat.db_lookup import ObjectDatabase

DB_ROOT = Path(__file__).resolve().parents[1] / ".claude" / "max-objects"


class TestM4LDatabase:
    """DB-01 and DB-02: M4L object overrides for domain and I/O."""

    @pytest.fixture(autouse=True)
    def setup_db(self):
        self.db = ObjectDatabase()

    def test_live_scope_domain_is_m4l(self):
        """DB-02: live.scope~ domain should be M4L, not Packages."""
        obj = self.db.lookup("live.scope~")
        assert obj is not None, "live.scope~ not found in database"
        assert obj["domain"] == "M4L"

    def test_live_adsrui_has_io(self):
        """DB-01: live.adsrui should have non-empty inlets and outlets."""
        obj = self.db.lookup("live.adsrui")
        assert obj is not None, "live.adsrui not found in database"
        assert len(obj["inlets"]) >= 1, "live.adsrui has no inlets"
        assert len(obj["outlets"]) >= 1, "live.adsrui has no outlets"

    def test_live_adsr_tilde_has_io(self):
        """DB-01: live.adsr~ should have inlets and at least one signal outlet."""
        obj = self.db.lookup("live.adsr~")
        assert obj is not None, "live.adsr~ not found in database"
        assert len(obj["inlets"]) >= 1, "live.adsr~ has no inlets"
        assert len(obj["outlets"]) >= 1, "live.adsr~ has no outlets"
        signal_outlets = [o for o in obj["outlets"] if o.get("signal")]
        assert len(signal_outlets) >= 1, "live.adsr~ has no signal outlets"

    def test_live_adsrui_domain_is_m4l(self):
        """DB-02: live.adsrui domain should be M4L."""
        obj = self.db.lookup("live.adsrui")
        assert obj is not None
        assert obj["domain"] == "M4L"

    def test_live_adsr_tilde_domain_is_m4l(self):
        """DB-02: live.adsr~ domain should be M4L."""
        obj = self.db.lookup("live.adsr~")
        assert obj is not None
        assert obj["domain"] == "M4L"


class TestM4LRelationships:
    """DB-03: M4L object relationship pairs in relationships.json."""

    @pytest.fixture(autouse=True)
    def load_relationships(self):
        rel_path = DB_ROOT / "relationships.json"
        data = json.loads(rel_path.read_text())
        self.pairs = data["pairs"]

    def _find_pair(self, obj_a: str, obj_b: str) -> dict | None:
        for entry in self.pairs:
            objs = entry["objects"]
            if obj_a in objs and obj_b in objs:
                return entry
        return None

    def test_plugin_plugout_pair(self):
        """DB-03: plugin~/plugout~ should be a required_pair."""
        pair = self._find_pair("plugin~", "plugout~")
        assert pair is not None, "plugin~/plugout~ pair not found in relationships.json"
        assert pair["relationship"] == "required_pair"

    def test_live_path_live_object_pair(self):
        """DB-03: live.path/live.object should be a required_pair."""
        pair = self._find_pair("live.path", "live.object")
        assert pair is not None, "live.path/live.object pair not found in relationships.json"
        assert pair["relationship"] == "required_pair"

    def test_midiin_midiout_pair(self):
        """DB-03: midiin/midiout should be a common_pair."""
        pair = self._find_pair("midiin", "midiout")
        assert pair is not None, "midiin/midiout pair not found in relationships.json"
        assert pair["relationship"] == "common_pair"
