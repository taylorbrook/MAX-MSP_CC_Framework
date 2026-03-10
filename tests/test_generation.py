"""End-to-end generation tests with known-good fixture comparison.

Tests the full pipeline: Patcher creation -> layout -> validation -> file write
-> file validation. Uses fixture patches for regression testing.
"""

import json
import subprocess
import sys
from pathlib import Path

import pytest


FIXTURES_DIR = Path(__file__).parent / "fixtures" / "expected"


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def _extract_object_names(patch_dict: dict) -> set[str]:
    """Extract all object names from a patch dict's boxes array."""
    names = set()
    for box_entry in patch_dict["patcher"]["boxes"]:
        box = box_entry["box"]
        mc = box["maxclass"]
        if mc == "newobj":
            text = box.get("text", "")
            if text:
                names.add(text.split()[0])
        else:
            names.add(mc)
    return names


def _extract_connection_topology(patch_dict: dict) -> list[tuple[str, str]]:
    """Extract connection topology as (source_name, dest_name) pairs."""
    # Build id -> name mapping
    id_to_name: dict[str, str] = {}
    for box_entry in patch_dict["patcher"]["boxes"]:
        box = box_entry["box"]
        box_id = box["id"]
        mc = box["maxclass"]
        if mc == "newobj":
            text = box.get("text", "")
            id_to_name[box_id] = text.split()[0] if text else ""
        else:
            id_to_name[box_id] = mc

    topology = []
    for line_entry in patch_dict["patcher"]["lines"]:
        pl = line_entry["patchline"]
        src_id = pl["source"][0]
        dst_id = pl["destination"][0]
        src_name = id_to_name.get(src_id, src_id)
        dst_name = id_to_name.get(dst_id, dst_id)
        topology.append((src_name, dst_name))
    return topology


# ---------------------------------------------------------------------------
# Simple Synth Tests
# ---------------------------------------------------------------------------

class TestSimpleSynth:
    """Test the simple synth patch: cycle~ 440 -> *~ 0.5 -> ezdac~."""

    def _make_synth(self):
        from src.maxpat import Patcher, generate_patch
        p = Patcher()
        osc = p.add_box("cycle~", ["440"])
        gain = p.add_box("*~", ["0.5"])
        dac = p.add_box("ezdac~")
        p.add_connection(osc, 0, gain, 0)
        p.add_connection(gain, 0, dac, 0)
        p.add_connection(gain, 0, dac, 1)
        return generate_patch(p)

    def test_box_count(self):
        """Simple synth generates 3 boxes."""
        d, _ = self._make_synth()
        assert len(d["patcher"]["boxes"]) == 3

    def test_connection_count(self):
        """Simple synth generates 3 connections (osc->gain, gain->dac L, gain->dac R)."""
        d, _ = self._make_synth()
        assert len(d["patcher"]["lines"]) == 3

    def test_maxclass_values(self):
        """All maxclass values are correct."""
        d, _ = self._make_synth()
        maxclasses = [b["box"]["maxclass"] for b in d["patcher"]["boxes"]]
        assert "newobj" in maxclasses
        assert "ezdac~" in maxclasses

    def test_numinlets_numoutlets(self):
        """numinlets and numoutlets are correct for each box."""
        d, _ = self._make_synth()
        boxes = {_get_name(b): b["box"] for b in d["patcher"]["boxes"]}

        assert boxes["cycle~"]["numinlets"] == 2
        assert boxes["cycle~"]["numoutlets"] == 1
        assert boxes["*~"]["numinlets"] == 2
        assert boxes["*~"]["numoutlets"] == 1
        assert boxes["ezdac~"]["numinlets"] == 2
        assert boxes["ezdac~"]["numoutlets"] == 0

    def test_outlettype(self):
        """outlettype arrays are correct."""
        d, _ = self._make_synth()
        boxes = {_get_name(b): b["box"] for b in d["patcher"]["boxes"]}

        assert boxes["cycle~"]["outlettype"] == ["signal"]
        assert boxes["*~"]["outlettype"] == ["signal"]
        assert boxes["ezdac~"]["outlettype"] == []

    def test_layout_applied(self):
        """Layout applied -- boxes have positioned patching_rect."""
        d, _ = self._make_synth()
        for b in d["patcher"]["boxes"]:
            rect = b["box"]["patching_rect"]
            assert len(rect) == 4
            # All rects should have non-zero width and height
            assert rect[2] > 0
            assert rect[3] > 0

    def test_required_fields(self):
        """All required fields present on each box."""
        d, _ = self._make_synth()
        required = {"maxclass", "id", "numinlets", "numoutlets", "outlettype", "patching_rect"}
        for b in d["patcher"]["boxes"]:
            box = b["box"]
            assert required.issubset(set(box.keys())), (
                f"Missing fields in {box.get('id', '?')}: "
                f"{required - set(box.keys())}"
            )


# ---------------------------------------------------------------------------
# Fixture Comparison Tests
# ---------------------------------------------------------------------------

class TestFixtureComparison:
    """Compare generated patches against known-good fixture files."""

    def test_simple_synth_fixture(self):
        """Generated simple synth matches fixture structure."""
        from src.maxpat import Patcher, generate_patch

        p = Patcher()
        osc = p.add_box("cycle~", ["440"])
        gain = p.add_box("*~", ["0.5"])
        dac = p.add_box("ezdac~")
        p.add_connection(osc, 0, gain, 0)
        p.add_connection(gain, 0, dac, 0)
        p.add_connection(gain, 0, dac, 1)

        d, _ = generate_patch(p)

        # Load fixture
        fixture = json.loads((FIXTURES_DIR / "simple_synth.maxpat").read_text())

        # Compare structural properties (NOT exact positions)
        assert len(d["patcher"]["boxes"]) == len(fixture["patcher"]["boxes"])
        assert len(d["patcher"]["lines"]) == len(fixture["patcher"]["lines"])

        gen_names = _extract_object_names(d)
        fix_names = _extract_object_names(fixture)
        assert gen_names == fix_names

        gen_topo = sorted(_extract_connection_topology(d))
        fix_topo = sorted(_extract_connection_topology(fixture))
        assert gen_topo == fix_topo

    def test_subpatcher_fixture(self):
        """Generated subpatcher matches fixture structure."""
        from src.maxpat import Patcher, generate_patch

        p = Patcher()
        osc = p.add_box("cycle~", ["440"])
        gain = p.add_box("*~", ["0.5"])
        dac = p.add_box("ezdac~")
        sub_box, inner = p.add_subpatcher("my_filter", inlets=1, outlets=1)

        reson = inner.add_box("reson~", ["1000", "0.5"])
        inner_inlet = inner.boxes[0]
        inner_outlet = inner.boxes[1]
        inner.add_connection(inner_inlet, 0, reson, 0)
        inner.add_connection(reson, 0, inner_outlet, 0)

        p.add_connection(osc, 0, gain, 0)
        p.add_connection(gain, 0, dac, 0)
        p.add_connection(gain, 0, dac, 1)

        d, _ = generate_patch(p)

        # Load fixture
        fixture = json.loads((FIXTURES_DIR / "subpatcher_example.maxpat").read_text())

        # Compare main patch structure
        assert len(d["patcher"]["boxes"]) == len(fixture["patcher"]["boxes"])
        assert len(d["patcher"]["lines"]) == len(fixture["patcher"]["lines"])

        gen_names = _extract_object_names(d)
        fix_names = _extract_object_names(fixture)
        assert gen_names == fix_names


# ---------------------------------------------------------------------------
# Subpatcher Tests
# ---------------------------------------------------------------------------

class TestSubpatcher:
    """Test subpatcher generation."""

    def test_subpatcher_structure(self):
        """Subpatcher box has nested patcher with boxes and lines."""
        from src.maxpat import Patcher, generate_patch

        p = Patcher()
        sub_box, inner = p.add_subpatcher("my_sub", inlets=1, outlets=1)
        inner_inlet = inner.boxes[0]
        inner_outlet = inner.boxes[1]

        d, _ = generate_patch(p)

        # Find the subpatcher box
        sub = None
        for b in d["patcher"]["boxes"]:
            if b["box"].get("text", "").startswith("p "):
                sub = b["box"]
                break

        assert sub is not None, "Subpatcher box not found"
        assert "patcher" in sub, "Subpatcher missing nested patcher"
        assert isinstance(sub["patcher"]["boxes"], list)
        assert isinstance(sub["patcher"]["lines"], list)

    def test_subpatcher_inlet_outlet_count(self):
        """Parent box numinlets/numoutlets match inner inlet/outlet count."""
        from src.maxpat import Patcher, generate_patch

        p = Patcher()
        sub_box, inner = p.add_subpatcher("two_io", inlets=2, outlets=3)

        d, _ = generate_patch(p)

        sub = None
        for b in d["patcher"]["boxes"]:
            if b["box"].get("text", "").startswith("p "):
                sub = b["box"]
                break

        assert sub is not None
        assert sub["numinlets"] == 2
        assert sub["numoutlets"] == 3

    def test_subpatcher_inner_has_inlets_outlets(self):
        """Inner patcher has correct number of inlet/outlet objects."""
        from src.maxpat import Patcher, generate_patch

        p = Patcher()
        sub_box, inner = p.add_subpatcher("my_sub", inlets=2, outlets=1)

        d, _ = generate_patch(p)

        sub = None
        for b in d["patcher"]["boxes"]:
            if b["box"].get("text", "").startswith("p "):
                sub = b["box"]
                break

        inner_boxes = sub["patcher"]["boxes"]
        inlets = [b for b in inner_boxes if b["box"]["maxclass"] == "inlet"]
        outlets = [b for b in inner_boxes if b["box"]["maxclass"] == "outlet"]

        assert len(inlets) == 2
        assert len(outlets) == 1


# ---------------------------------------------------------------------------
# bpatcher Tests
# ---------------------------------------------------------------------------

class TestBpatcher:
    """Test bpatcher generation."""

    def test_bpatcher_file_ref(self):
        """bpatcher referencing external file has correct maxclass and name."""
        from src.maxpat import Patcher, generate_patch

        p = Patcher()
        bp = p.add_bpatcher(filename="control.maxpat")

        d, _ = generate_patch(p)

        bp_box = None
        for b in d["patcher"]["boxes"]:
            if b["box"]["maxclass"] == "bpatcher":
                bp_box = b["box"]
                break

        assert bp_box is not None
        assert bp_box["maxclass"] == "bpatcher"
        assert bp_box["name"] == "control.maxpat"

    def test_bpatcher_embedded(self):
        """Embedded bpatcher has patcher key inside box."""
        from src.maxpat import Patcher, generate_patch

        p = Patcher()
        bp_box, bp_inner = p.add_bpatcher(embedded=True)

        d, _ = generate_patch(p)

        bp_dict = None
        for b in d["patcher"]["boxes"]:
            if b["box"]["maxclass"] == "bpatcher":
                bp_dict = b["box"]
                break

        assert bp_dict is not None
        assert "patcher" in bp_dict


# ---------------------------------------------------------------------------
# Multi-Domain Test
# ---------------------------------------------------------------------------

class TestMultiDomain:
    """Test a mixed MIDI + audio domain patch."""

    def test_multi_domain_patch(self):
        """notein -> stripnote -> mtof -> cycle~ -> *~ 0.5 -> ezdac~ with comments."""
        from src.maxpat import Patcher, generate_patch

        p = Patcher()
        p.add_comment("// MIDI INPUT")
        notein = p.add_box("notein")
        strip = p.add_box("stripnote")
        mtof = p.add_box("mtof")

        p.add_comment("// OSCILLATOR")
        osc = p.add_box("cycle~")
        gain = p.add_box("*~", ["0.5"])
        dac = p.add_box("ezdac~")

        # notein outlet 0 (note) -> stripnote inlet 0
        # notein outlet 1 (velocity) -> stripnote inlet 1
        p.add_connection(notein, 0, strip, 0)
        p.add_connection(notein, 1, strip, 1)
        # stripnote outlet 0 (note) -> mtof
        p.add_connection(strip, 0, mtof, 0)
        # mtof -> cycle~ frequency
        p.add_connection(mtof, 0, osc, 0)
        # cycle~ -> gain -> dac
        p.add_connection(osc, 0, gain, 0)
        p.add_connection(gain, 0, dac, 0)
        p.add_connection(gain, 0, dac, 1)

        d, results = generate_patch(p)

        # Verify all objects are present
        names = _extract_object_names(d)
        assert "notein" in names
        assert "stripnote" in names
        assert "mtof" in names
        assert "cycle~" in names
        assert "*~" in names
        assert "ezdac~" in names
        assert "comment" in names

        # Verify connections exist
        assert len(d["patcher"]["lines"]) == 7

        # Verify layout applied
        for b in d["patcher"]["boxes"]:
            rect = b["box"]["patching_rect"]
            assert rect[2] > 0 and rect[3] > 0


# ---------------------------------------------------------------------------
# Variable I/O Test
# ---------------------------------------------------------------------------

class TestVariableIO:
    """Test objects with variable inlet/outlet counts."""

    def test_trigger_outlets(self):
        """trigger b i f generates box with correct outlet count in JSON."""
        from src.maxpat import Patcher, generate_patch

        p = Patcher()
        trig = p.add_box("trigger", ["b", "i", "f"])

        d, _ = generate_patch(p)

        trig_box = d["patcher"]["boxes"][0]["box"]
        # trigger b i f should have 3 outlets
        assert trig_box["numoutlets"] == 3

    def test_pack_inlets(self):
        """pack 0 0 0 generates box with correct inlet count in JSON."""
        from src.maxpat import Patcher, generate_patch

        p = Patcher()
        pk = p.add_box("pack", ["0", "0", "0"])

        d, _ = generate_patch(p)

        pack_box = d["patcher"]["boxes"][0]["box"]
        # pack 0 0 0 should have 3 inlets
        assert pack_box["numinlets"] == 3


# ---------------------------------------------------------------------------
# Presentation Mode Test
# ---------------------------------------------------------------------------

class TestPresentationMode:
    """Test presentation mode layout on UI objects."""

    def test_presentation_rect_on_ui(self):
        """UI boxes with presentation=True get presentation and presentation_rect."""
        from src.maxpat import Patcher, generate_patch

        p = Patcher()
        toggle = p.add_box("toggle")
        toggle.presentation = True
        slider = p.add_box("slider")
        slider.presentation = True
        osc = p.add_box("cycle~")
        p.add_connection(toggle, 0, osc, 0)
        p.add_connection(slider, 0, osc, 0)

        d, _ = generate_patch(p)

        for b in d["patcher"]["boxes"]:
            box = b["box"]
            mc = box["maxclass"]
            if mc in ("toggle", "slider"):
                assert box.get("presentation") == 1, (
                    f"{mc} should have presentation=1"
                )
                assert "presentation_rect" in box, (
                    f"{mc} should have presentation_rect"
                )
                pr = box["presentation_rect"]
                assert len(pr) == 4
                assert all(isinstance(v, (int, float)) for v in pr)


# ---------------------------------------------------------------------------
# Write and Validate Pipeline Test
# ---------------------------------------------------------------------------

class TestWriteAndValidate:
    """Test the full write -> validate pipeline."""

    def test_write_and_validate(self, tmp_path):
        """write_patch then validate_file: no blocking errors."""
        from src.maxpat import Patcher, write_patch, validate_file, has_blocking_errors

        p = Patcher()
        osc = p.add_box("cycle~", ["440"])
        gain = p.add_box("*~", ["0.5"])
        dac = p.add_box("ezdac~")
        p.add_connection(osc, 0, gain, 0)
        p.add_connection(gain, 0, dac, 0)
        p.add_connection(gain, 0, dac, 1)

        out = tmp_path / "synth.maxpat"
        write_results = write_patch(p, out)

        assert out.exists()
        assert out.stat().st_size > 0

        val_results = validate_file(out)
        assert not has_blocking_errors(val_results)


# ---------------------------------------------------------------------------
# Validation Warning Test
# ---------------------------------------------------------------------------

class TestValidationWarnings:
    """Test that validation produces expected warnings."""

    def test_gain_staging_warning(self):
        """cycle~ -> ezdac~ (no gain) produces gain staging warning."""
        from src.maxpat import Patcher, generate_patch

        p = Patcher()
        osc = p.add_box("cycle~", ["440"])
        dac = p.add_box("ezdac~")
        p.add_connection(osc, 0, dac, 0)
        p.add_connection(osc, 0, dac, 1)

        d, results = generate_patch(p)

        # Should still generate (warning, not error)
        assert "patcher" in d

        # Should have gain staging warning
        msgs = [r.message for r in results]
        assert any("gain" in m.lower() for m in msgs), (
            f"Expected gain staging warning, got: {msgs}"
        )


# ---------------------------------------------------------------------------
# Full Pipeline Test
# ---------------------------------------------------------------------------

class TestFullPipeline:
    """Comprehensive end-to-end test of the complete pipeline."""

    def test_full_pipeline(self, tmp_path):
        """Create complex patch -> write -> validate from disk -> verify structure."""
        from src.maxpat import (
            Patcher, generate_patch, write_patch, validate_file,
            has_blocking_errors, ValidationResult,
        )

        p = Patcher()
        # Build a complex patch
        p.add_comment("// SYNTH SECTION")
        osc = p.add_box("cycle~", ["440"])
        gain = p.add_box("*~", ["0.5"])
        dac = p.add_box("ezdac~")

        # Connections
        p.add_connection(osc, 0, gain, 0)
        p.add_connection(gain, 0, dac, 0)
        p.add_connection(gain, 0, dac, 1)

        # Write to disk
        out = tmp_path / "complex_test.maxpat"
        write_results = write_patch(p, out)
        assert isinstance(write_results, list)

        # Validate from disk
        disk_results = validate_file(out)
        assert not has_blocking_errors(disk_results)

        # Load and verify structure
        data = json.loads(out.read_text())
        assert "patcher" in data
        assert isinstance(data["patcher"]["boxes"], list)
        assert isinstance(data["patcher"]["lines"], list)

        # Verify objects
        names = _extract_object_names(data)
        assert "cycle~" in names
        assert "*~" in names
        assert "ezdac~" in names
        assert "comment" in names

        # Verify connections
        assert len(data["patcher"]["lines"]) == 3

        # Verify patcher metadata
        assert data["patcher"]["fileversion"] == 1
        assert data["patcher"]["appversion"]["major"] == 9


# ---------------------------------------------------------------------------
# Regression Test
# ---------------------------------------------------------------------------

class TestRegression:
    """Verify Phase 1 tests still pass (no regressions)."""

    def test_phase1_tests_still_pass(self):
        """Phase 1 tests pass without regression."""
        result = subprocess.run(
            [
                sys.executable, "-m", "pytest",
                "tests/test_object_schema.py",
                "tests/test_rnbo_flag.py",
                "-x", "--tb=short", "-q",
            ],
            capture_output=True,
            text=True,
            cwd=str(Path(__file__).parent.parent),
        )
        assert result.returncode == 0, (
            f"Phase 1 tests failed:\n{result.stdout}\n{result.stderr}"
        )


# ---------------------------------------------------------------------------
# Helper
# ---------------------------------------------------------------------------

def _get_name(box_entry: dict) -> str:
    """Get human-readable name from a box entry."""
    box = box_entry["box"]
    mc = box["maxclass"]
    if mc == "newobj":
        text = box.get("text", "")
        return text.split()[0] if text else ""
    return mc
