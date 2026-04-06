"""Tests for M4L constants and device type detection.

Covers: IntEnum classes (ParamType, UnitStyle, ModMode, ParamVisibility),
AMXD binary format constants, and detect_device_type() heuristics.
"""

from __future__ import annotations

import pytest

from src.maxpat.m4l_constants import (
    ParamType,
    UnitStyle,
    ModMode,
    ParamVisibility,
    AMXD_MAGIC,
    AMXD_VERSION,
    AMXD_META_MARKER,
    AMXD_META_VERSION,
    AMXD_PATCH_MARKER,
    AMXD_TYPE_AUDIO_EFFECT,
    AMXD_TYPE_INSTRUMENT,
    AMXD_TYPE_MIDI_EFFECT,
    AMXD_HEADER_FORMAT,
    AMXD_HEADER_SIZE,
)
from src.maxpat.analysis import detect_device_type, DeviceTypeResult


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def _make_patch(*object_names: str) -> dict:
    """Build a minimal patch_dict with the given object names."""
    boxes = [{"box": {"text": name}} for name in object_names]
    return {"patcher": {"boxes": boxes}}


# ---------------------------------------------------------------------------
# IntEnum Tests
# ---------------------------------------------------------------------------

class TestParamType:
    def test_values(self):
        assert ParamType.INT == 0
        assert ParamType.FLOAT == 1
        assert ParamType.ENUM == 2
        assert ParamType.BLOB == 3

    def test_member_count(self):
        assert len(ParamType) == 4


class TestUnitStyle:
    def test_values(self):
        assert UnitStyle.INT == 0
        assert UnitStyle.FLOAT == 1
        assert UnitStyle.TIME == 2
        assert UnitStyle.HERTZ == 3
        assert UnitStyle.DECIBEL == 4
        assert UnitStyle.PERCENT == 5
        assert UnitStyle.PAN == 6
        assert UnitStyle.SEMITONES == 7
        assert UnitStyle.MIDI == 8
        assert UnitStyle.CUSTOM == 9

    def test_member_count(self):
        assert len(UnitStyle) == 10


class TestModMode:
    def test_values(self):
        assert ModMode.UNIPOLAR == 0
        assert ModMode.BIPOLAR == 1
        assert ModMode.ADDITIVE == 2
        assert ModMode.ABSOLUTE == 3

    def test_member_count(self):
        assert len(ModMode) == 4


class TestParamVisibility:
    def test_values(self):
        assert ParamVisibility.AUTOMATED_AND_STORED == 0
        assert ParamVisibility.STORED_ONLY == 1
        assert ParamVisibility.HIDDEN == 2

    def test_member_count(self):
        assert len(ParamVisibility) == 3


# ---------------------------------------------------------------------------
# AMXD Constants Tests
# ---------------------------------------------------------------------------

class TestAMXDConstants:
    def test_magic(self):
        assert AMXD_MAGIC == b"ampf"

    def test_version(self):
        assert AMXD_VERSION == 4

    def test_meta_marker(self):
        assert AMXD_META_MARKER == b"meta"

    def test_meta_version(self):
        assert AMXD_META_VERSION == 4

    def test_patch_marker(self):
        assert AMXD_PATCH_MARKER == b"ptch"

    def test_device_type_codes(self):
        assert AMXD_TYPE_AUDIO_EFFECT == b"aaaa"
        assert AMXD_TYPE_INSTRUMENT == b"iiii"
        assert AMXD_TYPE_MIDI_EFFECT == b"mmmm"

    def test_header_size(self):
        assert AMXD_HEADER_SIZE == 32

    def test_header_format_produces_correct_size(self):
        import struct
        size = struct.calcsize(AMXD_HEADER_FORMAT)
        assert size == AMXD_HEADER_SIZE


# ---------------------------------------------------------------------------
# Device Type Detection Tests
# ---------------------------------------------------------------------------

class TestDetectDeviceType:
    def test_audio_effect(self):
        """plugin~ + plugout~ with no MIDI -> audio_effect, confidence 1.0"""
        result = detect_device_type(_make_patch("plugin~", "plugout~"))
        assert result.device_type == "audio_effect"
        assert result.confidence == 1.0

    def test_midi_effect(self):
        """midiin + midiout with no audio -> midi_effect, confidence 1.0"""
        result = detect_device_type(_make_patch("midiin", "midiout"))
        assert result.device_type == "midi_effect"
        assert result.confidence == 1.0

    def test_instrument(self):
        """plugout~ + midiin (no plugin~) -> instrument, confidence 0.9"""
        result = detect_device_type(_make_patch("plugout~", "midiin"))
        assert result.device_type == "instrument"
        assert result.confidence == 0.9

    def test_ambiguous_plugin_midiin(self):
        """plugin~ + midiin -> uncertain, confidence 0.5"""
        result = detect_device_type(_make_patch("plugin~", "midiin"))
        assert result.device_type == "uncertain"
        assert result.confidence == 0.5

    def test_dac_only_non_m4l(self):
        """dac~ without plugout~ -> uncertain, confidence 0.3"""
        result = detect_device_type(_make_patch("dac~"))
        assert result.device_type == "uncertain"
        assert result.confidence == 0.3

    def test_ezdac_non_m4l(self):
        """ezdac~ without plugout~ -> uncertain, confidence 0.3"""
        result = detect_device_type(_make_patch("ezdac~"))
        assert result.device_type == "uncertain"
        assert result.confidence == 0.3

    def test_empty_patch(self):
        """Empty patch -> uncertain, confidence 0.0"""
        result = detect_device_type({"patcher": {"boxes": []}})
        assert result.device_type == "uncertain"
        assert result.confidence == 0.0

    def test_completely_empty_dict(self):
        """No patcher key -> uncertain, confidence 0.0"""
        result = detect_device_type({})
        assert result.device_type == "uncertain"
        assert result.confidence == 0.0

    def test_evidence_audio_effect(self):
        """Evidence dict has correct boolean values for audio_effect."""
        result = detect_device_type(_make_patch("plugin~", "plugout~"))
        assert result.evidence == {
            "plugin~": True,
            "plugout~": True,
            "midiin": False,
            "midiout": False,
            "dac~": False,
        }

    def test_evidence_instrument(self):
        """Evidence dict has correct boolean values for instrument."""
        result = detect_device_type(_make_patch("plugout~", "midiin"))
        assert result.evidence == {
            "plugin~": False,
            "plugout~": True,
            "midiin": True,
            "midiout": False,
            "dac~": False,
        }

    def test_evidence_empty(self):
        """Evidence dict all False for empty patch."""
        result = detect_device_type({"patcher": {"boxes": []}})
        assert all(v is False for v in result.evidence.values())

    def test_returns_dataclass(self):
        """Result is a DeviceTypeResult dataclass."""
        result = detect_device_type({})
        assert isinstance(result, DeviceTypeResult)

    def test_boxes_with_arguments(self):
        """Objects with arguments (e.g., 'plugin~ 2') still detected."""
        result = detect_device_type(_make_patch("plugin~ 2", "plugout~ 2"))
        assert result.device_type == "audio_effect"

    def test_boxes_without_text(self):
        """Boxes without text key are safely skipped."""
        patch = {"patcher": {"boxes": [
            {"box": {}},
            {"box": {"text": "plugin~"}},
            {"box": {"text": "plugout~"}},
        ]}}
        result = detect_device_type(patch)
        assert result.device_type == "audio_effect"
