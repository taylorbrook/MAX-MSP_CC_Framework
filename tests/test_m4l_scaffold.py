"""Tests for create_m4l_project() -- M4L device scaffolding.

Covers SCAFFOLD-01 through SCAFFOLD-06:
- audio_effect: plugin~, plugout~, live.thisdevice, stereo connections
- instrument: midiin, midiout, plugout~, live.thisdevice, MIDI passthrough
- midi_effect: midiin, midiout, live.thisdevice, no audio I/O, MIDI passthrough
- Presentation flags on live.thisdevice only
- No live.* UI controls in scaffold (parameter_enable precondition)
- No named objects in scaffold (--- prefix precondition)
- Edge cases: invalid type, custom devicewidth, auto_commit_patch call
"""

import json
from unittest.mock import patch as mock_patch

import pytest


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def _scaffold_and_load(device_type, tmp_path, **kwargs):
    """Scaffold a device and return (patch_dict, project_dir)."""
    with mock_patch("src.maxpat.project.auto_commit_patch"):
        from src.maxpat.project import create_m4l_project
        project_dir = create_m4l_project(device_type, "test-device", tmp_path, **kwargs)
    patch_path = project_dir / "generated" / "test-device.maxpat"
    with open(patch_path) as f:
        return json.load(f), project_dir


def _find_box_by_text(data, text):
    """Find first box whose text field matches exactly."""
    for box in data["patcher"]["boxes"]:
        if box["box"].get("text") == text:
            return box["box"]
    return None


def _find_box_by_maxclass(data, maxclass):
    """Find first box whose maxclass field matches."""
    for box in data["patcher"]["boxes"]:
        if box["box"].get("maxclass") == maxclass:
            return box["box"]
    return None


def _find_boxes_by_text_containing(data, substring):
    """Find all boxes whose text contains the substring."""
    results = []
    for box in data["patcher"]["boxes"]:
        text = box["box"].get("text", "")
        if substring in text:
            results.append(box["box"])
    return results


def _find_patchline(data, src_text, src_outlet, dst_text, dst_inlet):
    """Check if a patchline exists between boxes identified by text."""
    # Build id -> text map
    id_to_text = {}
    for box in data["patcher"]["boxes"]:
        box_id = box["box"]["id"]
        box_text = box["box"].get("text", box["box"].get("maxclass", ""))
        id_to_text[box_id] = box_text

    # Find source and dest IDs
    src_ids = [bid for bid, t in id_to_text.items() if t == src_text]
    dst_ids = [bid for bid, t in id_to_text.items() if t == dst_text]

    for line in data["patcher"]["lines"]:
        pl = line["patchline"]
        if (pl["source"][0] in src_ids and pl["source"][1] == src_outlet
                and pl["destination"][0] in dst_ids and pl["destination"][1] == dst_inlet):
            return True
    return False


# ---------------------------------------------------------------------------
# TestAudioEffect (SCAFFOLD-01)
# ---------------------------------------------------------------------------

class TestAudioEffect:
    def test_creates_project_directory(self, tmp_path):
        data, project_dir = _scaffold_and_load("audio_effect", tmp_path)
        assert project_dir.exists()
        assert project_dir.is_dir()

    def test_has_plugin_tilde(self, tmp_path):
        data, _ = _scaffold_and_load("audio_effect", tmp_path)
        assert _find_box_by_text(data, "plugin~") is not None

    def test_has_plugout_tilde(self, tmp_path):
        data, _ = _scaffold_and_load("audio_effect", tmp_path)
        assert _find_box_by_text(data, "plugout~") is not None

    def test_has_live_thisdevice(self, tmp_path):
        data, _ = _scaffold_and_load("audio_effect", tmp_path)
        assert _find_box_by_maxclass(data, "live.thisdevice") is not None

    def test_plugin_to_plugout_stereo(self, tmp_path):
        data, _ = _scaffold_and_load("audio_effect", tmp_path)
        assert _find_patchline(data, "plugin~", 0, "plugout~", 0), "Missing L channel connection"
        assert _find_patchline(data, "plugin~", 1, "plugout~", 1), "Missing R channel connection"

    def test_openinpresentation(self, tmp_path):
        data, _ = _scaffold_and_load("audio_effect", tmp_path)
        assert data["patcher"]["openinpresentation"] == 1

    def test_devicewidth(self, tmp_path):
        data, _ = _scaffold_and_load("audio_effect", tmp_path)
        assert data["patcher"]["devicewidth"] == 300.0

    def test_no_midiin_midiout(self, tmp_path):
        data, _ = _scaffold_and_load("audio_effect", tmp_path)
        assert _find_boxes_by_text_containing(data, "midiin") == []
        assert _find_boxes_by_text_containing(data, "midiout") == []


# ---------------------------------------------------------------------------
# TestInstrument (SCAFFOLD-02)
# ---------------------------------------------------------------------------

class TestInstrument:
    def test_has_midiin_midiout(self, tmp_path):
        data, _ = _scaffold_and_load("instrument", tmp_path)
        assert _find_box_by_text(data, "midiin") is not None
        assert _find_box_by_text(data, "midiout") is not None

    def test_has_plugout_tilde(self, tmp_path):
        data, _ = _scaffold_and_load("instrument", tmp_path)
        assert _find_box_by_text(data, "plugout~") is not None

    def test_has_live_thisdevice(self, tmp_path):
        data, _ = _scaffold_and_load("instrument", tmp_path)
        assert _find_box_by_maxclass(data, "live.thisdevice") is not None

    def test_midi_passthrough(self, tmp_path):
        data, _ = _scaffold_and_load("instrument", tmp_path)
        assert _find_patchline(data, "midiin", 0, "midiout", 0), "Missing MIDI passthrough"

    def test_no_plugin_tilde(self, tmp_path):
        data, _ = _scaffold_and_load("instrument", tmp_path)
        assert _find_box_by_text(data, "plugin~") is None


# ---------------------------------------------------------------------------
# TestMidiEffect (SCAFFOLD-03)
# ---------------------------------------------------------------------------

class TestMidiEffect:
    def test_has_midiin_midiout(self, tmp_path):
        data, _ = _scaffold_and_load("midi_effect", tmp_path)
        assert _find_box_by_text(data, "midiin") is not None
        assert _find_box_by_text(data, "midiout") is not None

    def test_has_live_thisdevice(self, tmp_path):
        data, _ = _scaffold_and_load("midi_effect", tmp_path)
        assert _find_box_by_maxclass(data, "live.thisdevice") is not None

    def test_midi_passthrough(self, tmp_path):
        data, _ = _scaffold_and_load("midi_effect", tmp_path)
        assert _find_patchline(data, "midiin", 0, "midiout", 0), "Missing MIDI passthrough"

    def test_no_audio_io(self, tmp_path):
        data, _ = _scaffold_and_load("midi_effect", tmp_path)
        assert _find_box_by_text(data, "plugin~") is None
        assert _find_box_by_text(data, "plugout~") is None


# ---------------------------------------------------------------------------
# TestPresentation (SCAFFOLD-06)
# ---------------------------------------------------------------------------

class TestPresentation:
    def test_live_thisdevice_presentation(self, tmp_path):
        data, _ = _scaffold_and_load("audio_effect", tmp_path)
        thisdevice = _find_box_by_maxclass(data, "live.thisdevice")
        assert thisdevice is not None
        assert thisdevice.get("presentation") == 1
        assert thisdevice.get("presentation_rect") is not None

    def test_boilerplate_no_presentation_rect(self, tmp_path):
        data, _ = _scaffold_and_load("audio_effect", tmp_path)
        plugin = _find_box_by_text(data, "plugin~")
        plugout = _find_box_by_text(data, "plugout~")
        assert plugin is not None
        assert plugout is not None
        assert "presentation_rect" not in plugin
        assert "presentation_rect" not in plugout


# ---------------------------------------------------------------------------
# TestParameterEnable (SCAFFOLD-04 precondition)
# ---------------------------------------------------------------------------

LIVE_UI_CONTROLS = {
    "live.dial", "live.slider", "live.numbox", "live.toggle",
    "live.menu", "live.tab", "live.text", "live.adsrui",
}


class TestParameterEnable:
    @pytest.mark.parametrize("device_type", ["audio_effect", "instrument", "midi_effect"])
    def test_scaffold_has_no_live_ui_controls(self, device_type, tmp_path):
        data, _ = _scaffold_and_load(device_type, tmp_path)
        boxes = data["patcher"]["boxes"]
        for box in boxes:
            maxclass = box["box"].get("maxclass", "")
            assert maxclass not in LIVE_UI_CONTROLS, f"Scaffold should not contain {maxclass}"

    def test_live_thisdevice_has_no_parameter_enable(self, tmp_path):
        data, _ = _scaffold_and_load("audio_effect", tmp_path)
        thisdevice = _find_box_by_maxclass(data, "live.thisdevice")
        assert thisdevice is not None
        assert thisdevice.get("parameter_enable", 0) != 1


# ---------------------------------------------------------------------------
# TestTripleDashPrefix (SCAFFOLD-05 precondition)
# ---------------------------------------------------------------------------

NAMED_OBJECTS = {
    "buffer~", "coll", "dict", "send", "receive",
    "send~", "receive~", "value",
}


class TestTripleDashPrefix:
    @pytest.mark.parametrize("device_type", ["audio_effect", "instrument", "midi_effect"])
    def test_scaffold_has_no_named_objects(self, device_type, tmp_path):
        data, _ = _scaffold_and_load(device_type, tmp_path)
        boxes = data["patcher"]["boxes"]
        for box in boxes:
            text = box["box"].get("text", "")
            obj_name = text.split()[0] if text else ""
            assert obj_name not in NAMED_OBJECTS, f"Scaffold should not contain named object {obj_name}"


# ---------------------------------------------------------------------------
# TestEdgeCases
# ---------------------------------------------------------------------------

class TestEdgeCases:
    def test_invalid_device_type(self, tmp_path):
        with mock_patch("src.maxpat.project.auto_commit_patch"):
            from src.maxpat.project import create_m4l_project
            with pytest.raises(ValueError):
                create_m4l_project("invalid", "test-device", tmp_path)

    def test_custom_devicewidth(self, tmp_path):
        data, _ = _scaffold_and_load("audio_effect", tmp_path, devicewidth=500.0)
        assert data["patcher"]["devicewidth"] == 500.0

    def test_reuses_create_project_dir_structure(self, tmp_path):
        _, project_dir = _scaffold_and_load("audio_effect", tmp_path)
        assert (project_dir / "context.md").exists()
        assert (project_dir / "status.md").exists()
        assert (project_dir / "generated").is_dir()
        assert (project_dir / "versions.json").exists()

    def test_calls_auto_commit_patch(self, tmp_path):
        with mock_patch("src.maxpat.project.auto_commit_patch") as mock_commit:
            from src.maxpat.project import create_m4l_project
            project_dir = create_m4l_project("audio_effect", "test-device", tmp_path)
            mock_commit.assert_called_once()
            call_args = mock_commit.call_args
            assert call_args[0][0] == project_dir  # project_dir
            assert call_args[0][1] == tmp_path      # base_dir
