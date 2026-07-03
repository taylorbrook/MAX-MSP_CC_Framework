"""Smoke tests for src/maxpat/m4l_constants.py enums and AMXD format constants."""

import struct
from enum import IntEnum

from src.maxpat.m4l_constants import (
    AMXD_HEADER_FORMAT,
    AMXD_HEADER_SIZE,
    AMXD_MAGIC,
    AMXD_TYPE_AUDIO_EFFECT,
    AMXD_TYPE_INSTRUMENT,
    AMXD_TYPE_MIDI_EFFECT,
    ModMode,
    ParamType,
    ParamVisibility,
    UnitStyle,
)


class TestEnums:
    def test_all_are_int_enums(self):
        for enum_cls in (ParamType, UnitStyle, ModMode, ParamVisibility):
            assert issubclass(enum_cls, IntEnum), enum_cls.__name__

    def test_param_type_members(self):
        assert ParamType.INT == 0
        assert ParamType.FLOAT == 1
        assert ParamType.ENUM == 2
        assert ParamType.BLOB == 3

    def test_unit_style_representative_members(self):
        assert UnitStyle.INT == 0
        assert UnitStyle.HERTZ == 3
        assert UnitStyle.DECIBEL == 4
        assert UnitStyle.CUSTOM == 9

    def test_mod_mode_members(self):
        assert ModMode.UNIPOLAR == 0
        assert ModMode.BIPOLAR == 1

    def test_param_visibility_members(self):
        assert ParamVisibility.AUTOMATED_AND_STORED == 0
        assert ParamVisibility.HIDDEN == 2


class TestAmxdFormat:
    def test_header_format_packs_to_declared_size(self):
        assert struct.calcsize(AMXD_HEADER_FORMAT) == AMXD_HEADER_SIZE == 32

    def test_magic_bytes(self):
        assert AMXD_MAGIC == b"ampf"

    def test_device_type_markers_distinct_4_byte_values(self):
        markers = {AMXD_TYPE_AUDIO_EFFECT, AMXD_TYPE_INSTRUMENT,
                   AMXD_TYPE_MIDI_EFFECT}
        assert len(markers) == 3
        for marker in markers:
            assert isinstance(marker, bytes)
            assert len(marker) == 4
