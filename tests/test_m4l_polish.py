"""Tests for M4L polish -- parameter naming intelligence.

Covers POLISH-01: auto-derive longname, shortname, varname for M4L
live.* controls. Tests verify D-01 (preserve existing), D-02 (longname
from varname), D-03 (shortname abbreviation), D-04 (varname from longname).
"""

from __future__ import annotations

import pytest


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def _make_live_control(
    box_id: str = "obj-1",
    maxclass: str = "live.dial",
    varname: str | None = None,
    longname: str | None = None,
    shortname: str | None = None,
    parameter_enable: int = 1,
    text: str | None = None,
) -> dict:
    """Build a live.* control box dict with configurable naming."""
    box: dict = {
        "id": box_id,
        "maxclass": maxclass,
        "numinlets": 1,
        "numoutlets": 2,
        "outlettype": ["", "float"],
        "parameter_enable": parameter_enable,
    }
    if varname is not None:
        box["varname"] = varname
    if text is not None:
        box["text"] = text

    # Build saved_attribute_attributes.valueof if any param name is set
    valueof: dict = {}
    if longname is not None:
        valueof["parameter_longname"] = longname
    if shortname is not None:
        valueof["parameter_shortname"] = shortname
    if valueof:
        box["saved_attribute_attributes"] = {"valueof": valueof}

    return box


def _make_patch_with_controls(controls: list[dict], **patcher_props) -> dict:
    """Wrap control box dicts in proper patch_dict structure."""
    patcher = {
        "boxes": [{"box": c} for c in controls],
        "lines": [],
    }
    patcher.update(patcher_props)
    return {"patcher": patcher}


# ===========================================================================
# TestNameDerivation -- POLISH-01
# ===========================================================================

class TestNameDerivation:
    """Test derive_parameter_names auto-derives longname/shortname/varname."""

    def test_longname_from_varname(self):
        """D-02: box with varname="filter_cutoff", no longname -> longname "Filter Cutoff"."""
        from src.maxpat.m4l_polish import derive_parameter_names

        ctrl = _make_live_control(varname="filter_cutoff")
        patch = _make_patch_with_controls([ctrl])
        derive_parameter_names(patch)

        valueof = patch["patcher"]["boxes"][0]["box"]["saved_attribute_attributes"]["valueof"]
        assert valueof["parameter_longname"] == "Filter Cutoff"

    def test_longname_from_box_text(self):
        """Box with no varname, text="live.dial pitch_start" -> longname from text tokens."""
        from src.maxpat.m4l_polish import derive_parameter_names

        ctrl = _make_live_control(text="live.dial pitch_start")
        patch = _make_patch_with_controls([ctrl])
        derive_parameter_names(patch)

        valueof = patch["patcher"]["boxes"][0]["box"]["saved_attribute_attributes"]["valueof"]
        # Should derive from "pitch_start" token
        assert valueof["parameter_longname"] == "Pitch Start"

    def test_shortname_abbreviation(self):
        """D-03: longname="Filter Frequency" -> shortname abbreviates words."""
        from src.maxpat.m4l_polish import derive_parameter_names

        ctrl = _make_live_control(longname="Filter Frequency")
        patch = _make_patch_with_controls([ctrl])
        derive_parameter_names(patch)

        valueof = patch["patcher"]["boxes"][0]["box"]["saved_attribute_attributes"]["valueof"]
        short = valueof["parameter_shortname"]
        assert "Filt" in short or "Freq" in short
        assert len(short) <= 8

    def test_shortname_truncation(self):
        """Shortname never exceeds 8 characters even after abbreviation."""
        from src.maxpat.m4l_polish import derive_parameter_names

        ctrl = _make_live_control(longname="Modulation Depth Amount")
        patch = _make_patch_with_controls([ctrl])
        derive_parameter_names(patch)

        valueof = patch["patcher"]["boxes"][0]["box"]["saved_attribute_attributes"]["valueof"]
        assert len(valueof["parameter_shortname"]) <= 8

    def test_shortname_short_already(self):
        """longname="Pan" -> shortname="Pan" (no abbreviation needed)."""
        from src.maxpat.m4l_polish import derive_parameter_names

        ctrl = _make_live_control(longname="Pan")
        patch = _make_patch_with_controls([ctrl])
        derive_parameter_names(patch)

        valueof = patch["patcher"]["boxes"][0]["box"]["saved_attribute_attributes"]["valueof"]
        assert valueof["parameter_shortname"] == "Pan"

    def test_varname_from_longname(self):
        """D-04: longname="Filter Cutoff", no varname -> varname="filter_cutoff"."""
        from src.maxpat.m4l_polish import derive_parameter_names

        ctrl = _make_live_control(longname="Filter Cutoff")
        patch = _make_patch_with_controls([ctrl])
        derive_parameter_names(patch)

        box = patch["patcher"]["boxes"][0]["box"]
        assert box["varname"] == "filter_cutoff"

    def test_preserves_existing_longname(self):
        """D-01: box already has longname="My Custom Name" -> not overridden."""
        from src.maxpat.m4l_polish import derive_parameter_names

        ctrl = _make_live_control(
            varname="some_var",
            longname="My Custom Name",
        )
        patch = _make_patch_with_controls([ctrl])
        derive_parameter_names(patch)

        valueof = patch["patcher"]["boxes"][0]["box"]["saved_attribute_attributes"]["valueof"]
        assert valueof["parameter_longname"] == "My Custom Name"

    def test_preserves_existing_shortname(self):
        """D-01: box already has shortname="Custom" -> not overridden."""
        from src.maxpat.m4l_polish import derive_parameter_names

        ctrl = _make_live_control(
            longname="Some Long Name",
            shortname="Custom",
        )
        patch = _make_patch_with_controls([ctrl])
        derive_parameter_names(patch)

        valueof = patch["patcher"]["boxes"][0]["box"]["saved_attribute_attributes"]["valueof"]
        assert valueof["parameter_shortname"] == "Custom"

    def test_preserves_existing_varname(self):
        """D-01: box already has varname="my_var" -> not overridden."""
        from src.maxpat.m4l_polish import derive_parameter_names

        ctrl = _make_live_control(
            varname="my_var",
            longname="Filter Cutoff",
        )
        patch = _make_patch_with_controls([ctrl])
        derive_parameter_names(patch)

        box = patch["patcher"]["boxes"][0]["box"]
        assert box["varname"] == "my_var"

    def test_skips_non_parameter_live_objects(self):
        """live.thisdevice, live.banks etc. untouched."""
        from src.maxpat.m4l_polish import derive_parameter_names

        boxes = [
            {
                "id": "obj-1",
                "maxclass": "live.thisdevice",
                "numinlets": 1,
                "numoutlets": 2,
                "outlettype": ["", ""],
            },
            {
                "id": "obj-2",
                "maxclass": "live.banks",
                "numinlets": 1,
                "numoutlets": 1,
                "outlettype": [""],
            },
        ]
        patch = _make_patch_with_controls(boxes)
        # Should not raise, and should not add any parameter naming attributes
        derive_parameter_names(patch)
        for box_entry in patch["patcher"]["boxes"]:
            box = box_entry["box"]
            assert "saved_attribute_attributes" not in box or \
                "valueof" not in box.get("saved_attribute_attributes", {}) or \
                "parameter_longname" not in box["saved_attribute_attributes"]["valueof"]

    def test_recurses_into_subpatchers(self):
        """live.dial inside a subpatcher gets names derived."""
        from src.maxpat.m4l_polish import derive_parameter_names

        inner_ctrl = _make_live_control(
            box_id="sub-obj-1",
            varname="reverb_size",
        )
        subpatcher_box = {
            "id": "obj-2",
            "maxclass": "newobj",
            "text": "p effects",
            "numinlets": 1,
            "numoutlets": 1,
            "outlettype": [""],
            "patcher": {
                "boxes": [{"box": inner_ctrl}],
                "lines": [],
            },
        }
        patch = {
            "patcher": {
                "boxes": [{"box": subpatcher_box}],
                "lines": [],
            },
        }
        derive_parameter_names(patch)

        inner_box = patch["patcher"]["boxes"][0]["box"]["patcher"]["boxes"][0]["box"]
        valueof = inner_box["saved_attribute_attributes"]["valueof"]
        assert valueof["parameter_longname"] == "Reverb Size"

    def test_no_duplicate_longnames(self):
        """If derivation would create duplicate longname, append index suffix."""
        from src.maxpat.m4l_polish import derive_parameter_names

        ctrl1 = _make_live_control(
            box_id="obj-1",
            varname="filter_cutoff",
        )
        ctrl2 = _make_live_control(
            box_id="obj-2",
            varname="filter_cutoff",
        )
        patch = _make_patch_with_controls([ctrl1, ctrl2])
        derive_parameter_names(patch)

        boxes = patch["patcher"]["boxes"]
        ln1 = boxes[0]["box"]["saved_attribute_attributes"]["valueof"]["parameter_longname"]
        ln2 = boxes[1]["box"]["saved_attribute_attributes"]["valueof"]["parameter_longname"]
        assert ln1 != ln2
        # One should be base name, other should have suffix
        assert "Filter Cutoff" in ln1 or "Filter Cutoff" in ln2
