"""E2E integration tests for M4L device creation pipeline.

Tests scaffold->polish->layout->critic->export as a connected flow.
Layered on existing unit tests -- does not duplicate individual checks.
"""

import json
import struct
from unittest.mock import patch as mock_patch

import pytest

from src.maxpat.m4l_constants import (
    AMXD_HEADER_FORMAT,
    AMXD_HEADER_SIZE,
    AMXD_MAGIC,
    AMXD_TYPE_AUDIO_EFFECT,
    AMXD_TYPE_INSTRUMENT,
    AMXD_TYPE_MIDI_EFFECT,
)
from src.maxpat.m4l_layout import DEVICE_HEIGHT


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def _make_control(box_id, maxclass, varname, longname=None, **extras):
    """Build a live.* control box dict with required M4L attributes."""
    box = {
        "id": box_id,
        "maxclass": maxclass,
        "numinlets": 1,
        "numoutlets": 2,
        "outlettype": ["", "float"],
        "parameter_enable": 1,
        "varname": varname,
    }
    if longname:
        box.setdefault("saved_attribute_attributes", {}).setdefault(
            "valueof", {}
        )["parameter_longname"] = longname
    box.update(extras)
    return box


def _build_device(device_type, name, tmp_path, controls):
    """Scaffold a device, inject controls, return (patch_dict, project_dir, patch_path)."""
    with mock_patch("src.maxpat.project.auto_commit_patch"):
        from src.maxpat.project import create_m4l_project

        project_dir = create_m4l_project(device_type, name, tmp_path)

    patch_path = project_dir / "generated" / f"{name}.maxpat"
    with open(patch_path) as f:
        patch_dict = json.load(f)

    for ctrl in controls:
        patch_dict["patcher"]["boxes"].append({"box": ctrl.copy()})

    return (patch_dict, project_dir, patch_path)


def _run_pipeline(patch_dict, patch_path, device_type, tmp_path):
    """Run full pipeline: polish -> layout -> critic -> export. Returns (critic_results, amxd_path, amxd_bytes)."""
    from src.maxpat.m4l_polish import polish_m4l_device
    from src.maxpat.m4l_layout import layout_m4l_presentation
    from src.maxpat.critics import review_patch
    from src.maxpat.m4l_export import write_amxd

    polish_m4l_device(patch_dict)
    layout_m4l_presentation(patch_dict)

    # CRITICAL: write_amxd reads from file, not dict
    with open(patch_path, "w") as f:
        json.dump(patch_dict, f, indent=2)

    critic_results = review_patch(patch_dict)

    amxd_path = patch_path.parent / f"{patch_path.stem}.amxd"
    with mock_patch("src.maxpat.m4l_export.auto_commit_patch"):
        write_amxd(patch_path, amxd_path, device_type)

    amxd_bytes = amxd_path.read_bytes()
    return (critic_results, amxd_path, amxd_bytes)


def _assert_within_height(patch_dict):
    """Assert all presentation_rects fit within DEVICE_HEIGHT."""
    for box_entry in patch_dict["patcher"]["boxes"]:
        box = box_entry.get("box", box_entry)
        rect = box.get("presentation_rect")
        if rect and len(rect) == 4:
            y, h = rect[1], rect[3]
            assert y + h <= DEVICE_HEIGHT, (
                f"Box {box.get('id', '?')} exceeds 169px: "
                f"y={y} + h={h} = {y + h}"
            )


def _assert_valid_amxd(raw_bytes, device_type):
    """Validate AMXD binary structure and embedded JSON."""
    assert len(raw_bytes) > AMXD_HEADER_SIZE, "AMXD too small"
    assert raw_bytes[0:4] == AMXD_MAGIC, f"Bad magic: {raw_bytes[0:4]}"

    type_map = {
        "audio_effect": AMXD_TYPE_AUDIO_EFFECT,
        "instrument": AMXD_TYPE_INSTRUMENT,
        "midi_effect": AMXD_TYPE_MIDI_EFFECT,
    }
    expected_type = type_map[device_type]
    assert raw_bytes[8:12] == expected_type, (
        f"Wrong device type bytes: {raw_bytes[8:12]} != {expected_type}"
    )

    json_len = struct.unpack_from("<I", raw_bytes, 28)[0]
    assert len(raw_bytes[AMXD_HEADER_SIZE:]) == json_len, (
        f"JSON length mismatch: body={len(raw_bytes[AMXD_HEADER_SIZE:])} header={json_len}"
    )

    parsed = json.loads(raw_bytes[AMXD_HEADER_SIZE:])
    assert "patcher" in parsed, "Embedded JSON missing 'patcher' key"


def _assert_all_coords_int(patch_dict, control_ids=None):
    """Assert presentation_rect values are whole integers.

    If control_ids is provided, only checks those boxes (layout-assigned).
    Otherwise checks all boxes with presentation_rect.
    """
    for box_entry in patch_dict["patcher"]["boxes"]:
        box = box_entry.get("box", box_entry)
        if control_ids is not None and box.get("id") not in control_ids:
            continue
        rect = box.get("presentation_rect")
        if rect:
            for i, val in enumerate(rect):
                assert isinstance(val, int), (
                    f"Box {box.get('id', '?')} presentation_rect[{i}] "
                    f"is {type(val).__name__}({val}), expected int"
                )


# ---------------------------------------------------------------------------
# Control fixtures
# ---------------------------------------------------------------------------

AUDIO_EFFECT_CONTROLS = [
    _make_control("obj-ae-1", "live.dial", "filter_cutoff"),       # Filter group
    _make_control("obj-ae-2", "live.numbox", "filter_resonance"),  # Filter group (numbox to fit 169px)
    _make_control("obj-ae-3", "live.dial", "amp_volume"),          # Amp group
    _make_control("obj-ae-4", "live.dial", "delay_time"),          # FX group
    _make_control("obj-ae-5", "live.numbox", "delay_feedback"),    # FX group (numbox to fit 169px)
    _make_control("obj-ae-6", "live.dial", "mod_rate"),            # Mod group
    _make_control("obj-ae-7", "live.numbox", "mod_depth"),         # Mod group (numbox to fit 169px)
    _make_control("obj-ae-8", "live.dial", "dry_wet"),             # Mix group
]

INSTRUMENT_CONTROLS = [
    _make_control("obj-in-1", "live.dial", "pitch_tune"),          # Pitch group
    _make_control("obj-in-2", "live.dial", "pitch_detune"),        # Pitch group
    _make_control("obj-in-3", "live.dial", "filter_cutoff"),       # Filter group
    _make_control("obj-in-4", "live.dial", "filter_resonance"),    # Filter group
    _make_control("obj-in-5", "live.dial", "amp_volume"),          # Amp group
    _make_control("obj-in-6", "live.dial", "attack"),              # Envelope group
    _make_control("obj-in-7", "live.dial", "decay"),               # Envelope group
    _make_control("obj-in-8", "live.dial", "sustain"),             # Envelope group
    _make_control("obj-in-9", "live.dial", "release"),             # Envelope group
    _make_control("obj-in-10", "live.dial", "mod_depth"),          # Mod group
]

# 2 controls, 2 groups -- exercises single-page layout path
# (4 groups would trigger tabbed due to TAB_GROUP_THRESHOLD=3)
MIDI_EFFECT_CONTROLS = [
    _make_control("obj-me-1", "live.dial", "pitch_transpose"),     # Pitch group
    _make_control("obj-me-2", "live.dial", "velocity"),            # Amp group
]


# ---------------------------------------------------------------------------
# TestAudioEffectE2E
# ---------------------------------------------------------------------------

class TestAudioEffectE2E:
    """E2E tests for audio_effect device (8 controls, 5 groups, tabbed layout)."""

    def test_scaffold_has_required_objects(self, tmp_path):
        """Post-scaffold checkpoint: required M4L objects present."""
        patch_dict, _, _ = _build_device(
            "audio_effect", "ae-test", tmp_path, AUDIO_EFFECT_CONTROLS,
        )
        boxes = patch_dict["patcher"]["boxes"]
        texts = [b["box"].get("text", "") for b in boxes]
        maxclasses = [b["box"].get("maxclass", "") for b in boxes]

        assert any("plugin~" in t for t in texts), "Missing plugin~"
        assert any("plugout~" in t for t in texts), "Missing plugout~"
        assert "live.thisdevice" in maxclasses, "Missing live.thisdevice"
        assert patch_dict["patcher"]["openinpresentation"] == 1

    def test_full_pipeline_no_blockers(self, tmp_path):
        """Post-critic checkpoint: no blocker findings."""
        patch_dict, _, patch_path = _build_device(
            "audio_effect", "ae-pipe", tmp_path, AUDIO_EFFECT_CONTROLS,
        )
        critic_results, _, _ = _run_pipeline(
            patch_dict, patch_path, "audio_effect", tmp_path,
        )
        blockers = [r for r in critic_results if r.severity == "blocker"]
        assert blockers == [], f"Blockers found: {blockers}"

    def test_polish_derives_parameter_names(self, tmp_path):
        """Intermediate check: polish fills longname and shortname."""
        from src.maxpat.m4l_polish import polish_m4l_device

        patch_dict, _, _ = _build_device(
            "audio_effect", "ae-polish", tmp_path, AUDIO_EFFECT_CONTROLS,
        )
        polish_m4l_device(patch_dict)

        boxes = patch_dict["patcher"]["boxes"]
        for ctrl_def in AUDIO_EFFECT_CONTROLS:
            ctrl_id = ctrl_def["id"]
            box = next(
                b["box"] for b in boxes if b["box"].get("id") == ctrl_id
            )
            saa = box.get("saved_attribute_attributes", {})
            valueof = saa.get("valueof", {})
            assert valueof.get("parameter_longname"), (
                f"{ctrl_id} missing longname after polish"
            )
            assert valueof.get("parameter_shortname"), (
                f"{ctrl_id} missing shortname after polish"
            )

    def test_layout_assigns_presentation_rects(self, tmp_path):
        """Post-layout: all controls have presentation_rect."""
        from src.maxpat.m4l_polish import polish_m4l_device
        from src.maxpat.m4l_layout import layout_m4l_presentation

        patch_dict, _, _ = _build_device(
            "audio_effect", "ae-layout", tmp_path, AUDIO_EFFECT_CONTROLS,
        )
        polish_m4l_device(patch_dict)
        layout_m4l_presentation(patch_dict)

        boxes = patch_dict["patcher"]["boxes"]
        for ctrl_def in AUDIO_EFFECT_CONTROLS:
            ctrl_id = ctrl_def["id"]
            box = next(
                b["box"] for b in boxes if b["box"].get("id") == ctrl_id
            )
            assert box.get("presentation") == 1, (
                f"{ctrl_id} missing presentation=1"
            )
            rect = box.get("presentation_rect")
            assert rect is not None and len(rect) == 4, (
                f"{ctrl_id} missing or invalid presentation_rect"
            )

    def test_presentation_within_169px(self, tmp_path):
        """All controls fit within Ableton's 169px device height."""
        from src.maxpat.m4l_polish import polish_m4l_device
        from src.maxpat.m4l_layout import layout_m4l_presentation

        patch_dict, _, _ = _build_device(
            "audio_effect", "ae-height", tmp_path, AUDIO_EFFECT_CONTROLS,
        )
        polish_m4l_device(patch_dict)
        layout_m4l_presentation(patch_dict)
        _assert_within_height(patch_dict)

    def test_all_coords_whole_integers(self, tmp_path):
        """All presentation_rect coordinates are int, not float."""
        from src.maxpat.m4l_polish import polish_m4l_device
        from src.maxpat.m4l_layout import layout_m4l_presentation

        patch_dict, _, _ = _build_device(
            "audio_effect", "ae-int", tmp_path, AUDIO_EFFECT_CONTROLS,
        )
        polish_m4l_device(patch_dict)
        layout_m4l_presentation(patch_dict)
        ctrl_ids = {c["id"] for c in AUDIO_EFFECT_CONTROLS}
        _assert_all_coords_int(patch_dict, control_ids=ctrl_ids)

    def test_export_valid_amxd(self, tmp_path):
        """Full pipeline produces valid AMXD binary."""
        patch_dict, _, patch_path = _build_device(
            "audio_effect", "ae-export", tmp_path, AUDIO_EFFECT_CONTROLS,
        )
        _, _, amxd_bytes = _run_pipeline(
            patch_dict, patch_path, "audio_effect", tmp_path,
        )
        _assert_valid_amxd(amxd_bytes, "audio_effect")
