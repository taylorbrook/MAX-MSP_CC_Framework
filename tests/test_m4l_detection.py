"""Tests for detect_device_type() public API (VALID-04)."""

import pytest

from src.maxpat.critics import detect_device_type, _detect_m4l_device


def _make_patch(*box_texts):
    """Helper: create minimal patch_dict with given box text strings."""
    boxes = []
    for i, text in enumerate(box_texts):
        # live.thisdevice uses its own maxclass
        if text == "live.thisdevice":
            boxes.append(
                {
                    "box": {
                        "id": f"obj-{i}",
                        "maxclass": "live.thisdevice",
                        "text": "live.thisdevice",
                    }
                }
            )
        else:
            boxes.append(
                {"box": {"id": f"obj-{i}", "maxclass": "newobj", "text": text}}
            )
    return {"patcher": {"boxes": boxes}}


class TestDetectDeviceType:
    def test_audio_effect(self):
        patch = _make_patch("live.thisdevice", "plugin~", "plugout~")
        assert detect_device_type(patch) == "audio_effect"

    def test_instrument(self):
        patch = _make_patch("live.thisdevice", "plugout~", "midiin", "midiout")
        assert detect_device_type(patch) == "instrument"

    def test_midi_effect(self):
        patch = _make_patch("live.thisdevice", "midiin", "midiout")
        assert detect_device_type(patch) == "midi_effect"

    def test_not_m4l(self):
        patch = _make_patch("dac~", "cycle~")
        assert detect_device_type(patch) is None

    def test_plugin_only_is_audio_effect(self):
        patch = _make_patch("live.thisdevice", "plugin~")
        assert detect_device_type(patch) == "audio_effect"

    def test_backward_compat_alias(self):
        assert detect_device_type is _detect_m4l_device

    def test_importable_from_top_level(self):
        from src.maxpat import detect_device_type as dt

        assert callable(dt)
