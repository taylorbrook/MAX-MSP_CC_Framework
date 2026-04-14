"""PKG-05 through PKG-08, D-11, D-12: Extraction pipeline verification tests.

Tests validate extracted data files from Plans 01 (BEAP/Vizzie) and 02 (Jitter Geometry/Tools).
"""

import json
from pathlib import Path

import pytest


class TestBEAPExtraction:
    """PKG-06: BEAP modules extracted with correct I/O counts and signal types."""

    @pytest.fixture(scope="class")
    def beap_objects(self, db_root):
        data = json.loads((db_root / "packages" / "BEAP" / "objects.json").read_text())
        return data

    def test_beap_count(self, beap_objects):
        """At least 180 BEAP modules extracted (168 clippings + misc)."""
        assert len(beap_objects) >= 180, f"Expected >= 180 BEAP objects, got {len(beap_objects)}"

    def test_beap_schema_fields(self, beap_objects):
        """Every BEAP object has required fields per D-05, D-06."""
        for name, obj in beap_objects.items():
            assert obj["maxclass"] == "bpatcher", f"{name}: maxclass should be bpatcher"
            assert obj["package"] == "BEAP", f"{name}: package should be BEAP"
            assert obj["domain"] == "Packages", f"{name}: domain should be Packages"
            assert isinstance(obj.get("abstraction_file"), str) and obj["abstraction_file"], (
                f"{name}: missing abstraction_file"
            )
            assert isinstance(obj.get("bpatcher_dimensions"), list) and len(obj["bpatcher_dimensions"]) == 2, (
                f"{name}: bad bpatcher_dimensions"
            )
            assert isinstance(obj.get("category"), str) and obj["category"], f"{name}: missing category"
            assert obj.get("signal_convention") == "0-5V CV", f"{name}: signal_convention should be '0-5V CV'"

    def test_beap_oscillator_io(self, beap_objects):
        """bp.Oscillator: 6 inlets, 2 outlets (verified from file inspection)."""
        osc = beap_objects.get("bp.Oscillator")
        assert osc is not None, "bp.Oscillator not found"
        assert len(osc["inlets"]) == 6, f"Expected 6 inlets, got {len(osc['inlets'])}"
        assert len(osc["outlets"]) == 2, f"Expected 2 outlets, got {len(osc['outlets'])}"

    def test_beap_inlets_zero_based_sorted(self, beap_objects):
        """Inlet/outlet ids are 0-based and sequential."""
        for name, obj in beap_objects.items():
            for i, inlet in enumerate(obj.get("inlets", [])):
                assert inlet["id"] == i, f"{name}: inlet {i} has id {inlet['id']}"
            for i, outlet in enumerate(obj.get("outlets", [])):
                assert outlet["id"] == i, f"{name}: outlet {i} has id {outlet['id']}"

    def test_beap_no_internal_helpers(self, beap_objects):
        """Internal helper files excluded (poly voices, pfft subpatches)."""
        forbidden = {"bp.freqshift.poly", "bp.polydronevoice", "bp.rgrain", "bp.diodeladder.poly"}
        for name in forbidden:
            assert name not in beap_objects, f"Internal helper {name} should not be extracted"

    def test_beap_categories_from_folders(self, beap_objects):
        """Categories match known BEAP clipping subdirectory names."""
        valid_categories = {
            "Analysis", "Effects", "Envelope", "Filter", "Input", "Level",
            "LFO", "MIDI", "Mixers", "Oscillator", "Output", "Quantizer",
            "Random", "Scope", "Sequencer", "Serialosc", "Waveshapers", "Misc",
        }
        for name, obj in beap_objects.items():
            assert obj["category"] in valid_categories, (
                f"{name}: category '{obj['category']}' not in valid set"
            )


class TestVizzieExtraction:
    """PKG-07: Vizzie modules extracted with correct I/O counts."""

    @pytest.fixture(scope="class")
    def vizzie_objects(self, db_root):
        return json.loads((db_root / "packages" / "Vizzie" / "objects.json").read_text())

    def test_vizzie_count(self, vizzie_objects):
        assert len(vizzie_objects) >= 100

    def test_vizzie_schema_fields(self, vizzie_objects):
        for name, obj in vizzie_objects.items():
            assert obj["maxclass"] == "bpatcher"
            assert obj["package"] == "Vizzie"
            assert obj["domain"] == "Packages"
            assert isinstance(obj.get("abstraction_file"), str) and obj["abstraction_file"]
            assert isinstance(obj.get("bpatcher_dimensions"), list)
            assert isinstance(obj.get("category"), str) and obj["category"]
            assert obj.get("signal_convention") == "Jitter matrix"

    def test_vizzie_categories_from_tags(self, vizzie_objects):
        valid_categories = {
            "Generate", "Effect", "Control", "Transform",
            "Mix-Composite", "Utility", "Output", "Input",
        }
        for name, obj in vizzie_objects.items():
            assert obj["category"] in valid_categories, (
                f"{name}: category '{obj['category']}' not valid"
            )

    def test_vizzie_has_descriptions(self, vizzie_objects):
        """Vizzie modules have descriptions from patcher.description field."""
        with_desc = sum(1 for obj in vizzie_objects.values() if obj.get("description"))
        assert with_desc >= 100, f"Expected >= 100 Vizzie modules with descriptions, got {with_desc}"


class TestIOCrossCheck:
    """D-11: Automated cross-check of I/O counts against help patches."""

    BEAP_HELP_DIR = Path("/Applications/Max.app/Contents/Resources/C74/packages/BEAP/Help")

    @pytest.fixture(scope="class")
    def beap_objects(self, db_root):
        return json.loads((db_root / "packages" / "BEAP" / "objects.json").read_text())

    def _find_bpatcher_io_in_help(self, help_path, module_name):
        """Recursively find bpatcher instances matching module_name in help patch."""
        data = json.loads(help_path.read_text())
        results = []

        def search(patcher):
            for box in patcher.get("boxes", []):
                b = box["box"]
                name_field = b.get("name", "")
                if b.get("maxclass") == "bpatcher" and module_name in name_field:
                    results.append((b.get("numinlets", 0), b.get("numoutlets", 0)))
                inner = b.get("patcher", {})
                if inner:
                    search(inner)

        search(data.get("patcher", {}))
        return results

    def test_beap_io_matches_help_patches(self, beap_objects):
        """Compare extracted I/O against help patch bpatcher numinlets/numoutlets."""
        if not self.BEAP_HELP_DIR.exists():
            pytest.skip("BEAP Help directory not found")

        mismatches = []
        checked = 0
        for name, obj in beap_objects.items():
            help_file = self.BEAP_HELP_DIR / f"{name}.maxhelp"
            if not help_file.exists():
                continue
            checked += 1
            refs = self._find_bpatcher_io_in_help(help_file, name)
            expected_in = len(obj["inlets"])
            expected_out = len(obj["outlets"])
            for ref_in, ref_out in refs:
                if ref_in != expected_in or ref_out != expected_out:
                    mismatches.append(
                        f"{name}: extracted ({expected_in},{expected_out}) vs help ({ref_in},{ref_out})"
                    )
                    break  # One mismatch per module is enough

        assert checked >= 100, f"Cross-checked only {checked} modules (expected >= 100)"
        # Allow small number of mismatches (edge cases) but flag them
        assert len(mismatches) <= 5, f"Too many I/O mismatches:\n" + "\n".join(mismatches)


class TestDBRoundTrip:
    """D-12: DB round-trip -- every extracted object loads correctly in ObjectDatabase."""

    @pytest.fixture(scope="class")
    def db(self):
        from src.maxpat.db_lookup import ObjectDatabase
        return ObjectDatabase()

    def test_all_beap_objects_in_db(self, db, db_root):
        beap_data = json.loads((db_root / "packages" / "BEAP" / "objects.json").read_text())
        for name in beap_data:
            obj = db.lookup(name)
            assert obj is not None, f"BEAP object {name} not found in ObjectDatabase"
            assert len(obj.get("inlets", [])) == len(beap_data[name]["inlets"]), (
                f"{name}: inlet count mismatch in DB"
            )
            assert len(obj.get("outlets", [])) == len(beap_data[name]["outlets"]), (
                f"{name}: outlet count mismatch in DB"
            )

    def test_all_vizzie_objects_in_db(self, db, db_root):
        vizzie_data = json.loads((db_root / "packages" / "Vizzie" / "objects.json").read_text())
        for name in vizzie_data:
            obj = db.lookup(name)
            assert obj is not None, f"Vizzie object {name} not found in ObjectDatabase"
            assert len(obj.get("inlets", [])) == len(vizzie_data[name]["inlets"])
            assert len(obj.get("outlets", [])) == len(vizzie_data[name]["outlets"])

    def test_all_jitter_geometry_objects_in_db(self, db, db_root):
        jg_data = json.loads((db_root / "packages" / "Jitter Geometry" / "objects.json").read_text())
        for name in jg_data:
            obj = db.lookup(name)
            assert obj is not None, f"Jitter Geometry object {name} not found in ObjectDatabase"

    def test_all_jitter_tools_objects_in_db(self, db, db_root):
        jt_data = json.loads((db_root / "packages" / "Jitter Tools" / "objects.json").read_text())
        for name in jt_data:
            obj = db.lookup(name)
            assert obj is not None, f"Jitter Tools object {name} not found in ObjectDatabase"
