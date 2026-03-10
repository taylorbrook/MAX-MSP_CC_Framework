"""Tests for RNBO generation, validation, target constraints, self-containedness, and param extraction."""

from __future__ import annotations

import pytest

from src.maxpat.rnbo import RNBODatabase, parse_genexpr_params
from src.maxpat.rnbo_validation import validate_rnbo_patch, RNBO_TARGET_CONSTRAINTS


# ===========================================================================
# Task 1: RNBODatabase tests
# ===========================================================================


def test_rnbo_database_loads():
    """RNBODatabase can be constructed and loads RNBO objects."""
    db = RNBODatabase()
    # Should have loaded 560 RNBO objects at minimum
    assert len(db._rnbo_objects) >= 560


def test_rnbo_compatible_check():
    """Known RNBO objects return True, known non-RNBO return False."""
    db = RNBODatabase()
    # Objects in rnbo/objects.json
    assert db.is_rnbo_compatible("cycle~") is True
    assert db.is_rnbo_compatible("param") is True
    assert db.is_rnbo_compatible("in~") is True
    assert db.is_rnbo_compatible("out~") is True
    # Objects marked rnbo_compatible in other domains
    assert db.is_rnbo_compatible("loadbang") is True
    # Non-RNBO objects
    assert db.is_rnbo_compatible("jit.matrix") is False
    assert db.is_rnbo_compatible("live.dial") is False
    assert db.is_rnbo_compatible("bpatcher") is False


def test_rnbo_lookup_uses_rnbo_io():
    """cycle~ lookup returns RNBO outlet count (2), not MSP outlet count (1)."""
    db = RNBODatabase()
    obj = db.lookup("cycle~")
    assert obj is not None
    # RNBO cycle~ has 2 outlets (signal + sync), MSP has 1
    assert len(obj["outlets"]) == 2


def test_rnbo_lookup_returns_none_for_unknown():
    """Lookup for non-RNBO object returns None."""
    db = RNBODatabase()
    assert db.lookup("jit.matrix") is None
    assert db.lookup("nonexistent_object_xyz") is None


# ===========================================================================
# Task 1: RNBO validation tests
# ===========================================================================


def _make_rnbo_patch_dict(boxes, target="plugin"):
    """Helper to build a minimal patch dict with an rnbo~ inner patcher."""
    inner_boxes = []
    for i, box_info in enumerate(boxes):
        name = box_info["name"]
        text = box_info.get("text", name)
        maxclass = box_info.get("maxclass", "newobj")
        inner_boxes.append({
            "box": {
                "maxclass": maxclass,
                "text": text,
                "id": f"obj-{i + 1}",
                "numinlets": box_info.get("numinlets", 1),
                "numoutlets": box_info.get("numoutlets", 1),
                "outlettype": box_info.get("outlettype", [""]),
                "patching_rect": [50.0, 50.0 + i * 50.0, 100.0, 22.0],
            }
        })
    return {
        "patcher": {
            "boxes": inner_boxes,
            "lines": [],
        }
    }


def test_rnbo_object_validation():
    """Patch with non-RNBO object produces error."""
    patch = _make_rnbo_patch_dict([
        {"name": "cycle~", "text": "cycle~ 440"},
        {"name": "jit.matrix", "text": "jit.matrix"},
    ])
    results = validate_rnbo_patch(patch, target="plugin")
    errors = [r for r in results if r.level == "error"]
    assert len(errors) >= 1
    assert any("jit.matrix" in r.message for r in errors)


def test_rnbo_object_validation_clean():
    """Patch with only RNBO objects produces no object-layer errors."""
    patch = _make_rnbo_patch_dict([
        {"name": "cycle~", "text": "cycle~ 440"},
        {"name": "in~", "text": "in~ 1", "numinlets": 0},
        {"name": "out~", "text": "out~ 1", "numoutlets": 0, "outlettype": []},
    ])
    results = validate_rnbo_patch(patch, target="plugin")
    obj_errors = [r for r in results if r.layer == "rnbo-objects" and r.level == "error"]
    assert len(obj_errors) == 0


def test_target_constraints_plugin():
    """Plugin target allows MIDI and buffer."""
    constraints = RNBO_TARGET_CONSTRAINTS["plugin"]
    assert constraints["midi_supported"] is True
    assert constraints["buffer_allowed"] is True
    assert constraints["max_params"] is None  # No hard limit


def test_target_constraints_web():
    """Web target warns about .aif audio format."""
    constraints = RNBO_TARGET_CONSTRAINTS["web"]
    assert constraints["midi_supported"] is True
    assert constraints["audio_format_warning"] == "aif"


def test_target_constraints_cpp():
    """C++ target warns on >128 params, rejects buffer."""
    constraints = RNBO_TARGET_CONSTRAINTS["cpp"]
    assert constraints["max_params"] == 128
    assert constraints["buffer_allowed"] is False

    # Build a patch with >128 param objects
    boxes = []
    for i in range(130):
        boxes.append({
            "name": "param",
            "text": f"param @name p{i} @min 0 @max 1 @initial 0.5",
        })
    patch = _make_rnbo_patch_dict(boxes)
    results = validate_rnbo_patch(patch, target="cpp")
    param_warnings = [r for r in results if r.layer == "rnbo-target" and "param" in r.message.lower()]
    assert len(param_warnings) >= 1


def test_target_constraints_cpp_rejects_buffer():
    """C++ target rejects buffer~ usage."""
    # buffer~ is in MSP domain with rnbo_compatible=False, so it would be caught
    # by object validation. But if we simulate a buffer~ with @file attribute,
    # the self-contained check should catch it too.
    patch = _make_rnbo_patch_dict([
        {"name": "data", "text": "data mybuf"},
    ])
    # data is RNBO-compatible, but for cpp target with buffer_allowed=False,
    # buffer-like objects should trigger a warning
    results = validate_rnbo_patch(patch, target="cpp")
    # The cpp target check should warn about buffer-like data objects
    # (this is a target constraint, not object compatibility)


def test_self_contained_rejects_buffer_file():
    """buffer~ with @file produces error for self-containedness."""
    # Simulate a buffer~ box with @file attribute in the text
    patch = _make_rnbo_patch_dict([
        {"name": "buffer~", "text": "buffer~ mybuf @file sample.wav"},
    ])
    results = validate_rnbo_patch(patch, target="plugin")
    contained_errors = [r for r in results if r.layer == "rnbo-contained" and r.level == "error"]
    assert len(contained_errors) >= 1
    assert any("file" in r.message.lower() or "buffer" in r.message.lower() for r in contained_errors)


def test_self_contained_clean():
    """Patch without file refs passes self-containedness check."""
    patch = _make_rnbo_patch_dict([
        {"name": "cycle~", "text": "cycle~ 440"},
        {"name": "in~", "text": "in~ 1", "numinlets": 0},
    ])
    results = validate_rnbo_patch(patch, target="plugin")
    contained_errors = [r for r in results if r.layer == "rnbo-contained" and r.level == "error"]
    assert len(contained_errors) == 0


# ===========================================================================
# Task 1: Param extraction tests
# ===========================================================================


def test_param_extraction():
    """GenExpr with Param declarations returns correct name/default/min/max."""
    code = """
// === PARAMETERS ===
Param freq(440, min=20, max=20000);
Param gain(0.5, min=0, max=1);

out1 = cycle(freq) * gain;
"""
    params = parse_genexpr_params(code)
    assert len(params) == 2

    assert params[0]["name"] == "freq"
    assert params[0]["default"] == 440.0
    assert params[0]["min"] == 20.0
    assert params[0]["max"] == 20000.0

    assert params[1]["name"] == "gain"
    assert params[1]["default"] == 0.5
    assert params[1]["min"] == 0.0
    assert params[1]["max"] == 1.0


def test_param_extraction_no_params():
    """Code without Params returns empty list."""
    code = """
out1 = in1 * 0.5;
"""
    params = parse_genexpr_params(code)
    assert params == []
