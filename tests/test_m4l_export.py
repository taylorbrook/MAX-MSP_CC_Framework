"""Tests for write_amxd() -- .amxd binary export.

Covers EXPORT-01: write_amxd() produces valid .amxd files with
correct 32-byte binary header per device type.
"""

import json
import struct
from pathlib import Path
from unittest.mock import patch as mock_patch

import pytest

from src.maxpat.m4l_constants import (
    AMXD_HEADER_FORMAT,
    AMXD_HEADER_SIZE,
    AMXD_TYPE_AUDIO_EFFECT,
    AMXD_TYPE_INSTRUMENT,
    AMXD_TYPE_MIDI_EFFECT,
)


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def _write_test_maxpat(tmp_path):
    """Write a minimal valid .maxpat JSON file and return its path."""
    data = {"patcher": {"boxes": [], "lines": []}}
    path = tmp_path / "test.maxpat"
    path.write_text(json.dumps(data, indent=4))
    return path


def _export(tmp_path, device_type="audio_effect"):
    """Export a test .maxpat as .amxd and return (output_path, raw_bytes)."""
    from src.maxpat.m4l_export import write_amxd

    patch_path = _write_test_maxpat(tmp_path)
    output_path = tmp_path / "out" / "test.amxd"
    with mock_patch("src.maxpat.m4l_export.auto_commit_patch"):
        result = write_amxd(patch_path, output_path, device_type)
    raw = result.read_bytes()
    return result, raw


# ---------------------------------------------------------------------------
# TestAmxdHeader
# ---------------------------------------------------------------------------

class TestAmxdHeader:
    """Verify each field of the 32-byte AMXD binary header."""

    def test_magic_bytes(self, tmp_path):
        _, raw = _export(tmp_path)
        assert raw[0:4] == b"ampf"

    def test_version(self, tmp_path):
        _, raw = _export(tmp_path)
        version = struct.unpack_from("<I", raw, 4)[0]
        assert version == 4

    def test_device_type_audio_effect(self, tmp_path):
        _, raw = _export(tmp_path, "audio_effect")
        assert raw[8:12] == b"aaaa"

    def test_meta_marker(self, tmp_path):
        _, raw = _export(tmp_path)
        assert raw[12:16] == b"meta"

    def test_meta_version(self, tmp_path):
        _, raw = _export(tmp_path)
        meta_ver = struct.unpack_from("<I", raw, 16)[0]
        assert meta_ver == 4

    def test_padding_zeroes(self, tmp_path):
        _, raw = _export(tmp_path)
        assert raw[20:24] == b"\x00\x00\x00\x00"

    def test_patch_marker(self, tmp_path):
        _, raw = _export(tmp_path)
        assert raw[24:28] == b"ptch"

    def test_json_length(self, tmp_path):
        _, raw = _export(tmp_path)
        json_len = struct.unpack_from("<I", raw, 28)[0]
        json_body = raw[AMXD_HEADER_SIZE:]
        assert json_len == len(json_body)

    def test_total_header_size(self, tmp_path):
        _, raw = _export(tmp_path)
        # Header must be exactly 32 bytes; verify JSON starts at 32
        json_body = raw[32:]
        json.loads(json_body)  # must parse


# ---------------------------------------------------------------------------
# TestAmxdBody
# ---------------------------------------------------------------------------

class TestAmxdBody:
    """Verify JSON body content and formatting."""

    def test_json_parses(self, tmp_path):
        _, raw = _export(tmp_path)
        body = raw[AMXD_HEADER_SIZE:]
        data = json.loads(body)
        assert "patcher" in data

    def test_json_matches_input(self, tmp_path):
        from src.maxpat.m4l_export import write_amxd

        patch_path = _write_test_maxpat(tmp_path)
        original = json.loads(patch_path.read_text())

        output_path = tmp_path / "out" / "body.amxd"
        with mock_patch("src.maxpat.m4l_export.auto_commit_patch"):
            result = write_amxd(patch_path, output_path, "audio_effect")

        body = result.read_bytes()[AMXD_HEADER_SIZE:]
        exported = json.loads(body)
        assert exported == original

    def test_tab_indentation(self, tmp_path):
        _, raw = _export(tmp_path)
        body_text = raw[AMXD_HEADER_SIZE:].decode("utf-8")
        lines = body_text.split("\n")
        # Find first indented line
        for line in lines:
            if line and line[0] in (" ", "\t"):
                assert line[0] == "\t", f"Expected tab indent, got: {repr(line[:5])}"
                break
        else:
            pytest.fail("No indented lines found in JSON body")


# ---------------------------------------------------------------------------
# TestAmxdDeviceTypes
# ---------------------------------------------------------------------------

class TestAmxdDeviceTypes:
    """Verify all 3 device types produce correct type bytes."""

    @pytest.mark.parametrize(
        "device_type, expected_bytes",
        [
            ("audio_effect", AMXD_TYPE_AUDIO_EFFECT),
            ("instrument", AMXD_TYPE_INSTRUMENT),
            ("midi_effect", AMXD_TYPE_MIDI_EFFECT),
        ],
    )
    def test_device_type_bytes(self, tmp_path, device_type, expected_bytes):
        _, raw = _export(tmp_path, device_type)
        assert raw[8:12] == expected_bytes


# ---------------------------------------------------------------------------
# TestAmxdErrors
# ---------------------------------------------------------------------------

class TestAmxdErrors:
    """Verify error handling for invalid inputs."""

    def test_invalid_device_type(self, tmp_path):
        from src.maxpat.m4l_export import write_amxd

        patch_path = _write_test_maxpat(tmp_path)
        output_path = tmp_path / "bad.amxd"
        with pytest.raises(KeyError):
            write_amxd(patch_path, output_path, "invalid_type")

    def test_missing_patch_file(self, tmp_path):
        from src.maxpat.m4l_export import write_amxd

        output_path = tmp_path / "missing.amxd"
        with pytest.raises(FileNotFoundError):
            write_amxd(tmp_path / "nonexistent.maxpat", output_path, "audio_effect")


# ---------------------------------------------------------------------------
# TestAmxdFileOps
# ---------------------------------------------------------------------------

class TestAmxdFileOps:
    """Verify file creation and return value."""

    def test_output_file_created(self, tmp_path):
        result, _ = _export(tmp_path)
        assert result.exists()

    def test_parent_dirs_created(self, tmp_path):
        from src.maxpat.m4l_export import write_amxd

        patch_path = _write_test_maxpat(tmp_path)
        output_path = tmp_path / "deep" / "nested" / "dir" / "test.amxd"
        with mock_patch("src.maxpat.m4l_export.auto_commit_patch"):
            result = write_amxd(patch_path, output_path, "audio_effect")
        assert result.exists()
        assert result.parent.name == "dir"

    def test_returns_path(self, tmp_path):
        result, _ = _export(tmp_path)
        assert isinstance(result, Path)

    def test_auto_commit_called(self, tmp_path):
        from src.maxpat.m4l_export import write_amxd

        patch_path = _write_test_maxpat(tmp_path)
        output_path = tmp_path / "commit" / "test.amxd"
        with mock_patch("src.maxpat.m4l_export.auto_commit_patch") as mock_commit:
            write_amxd(patch_path, output_path, "audio_effect")
        mock_commit.assert_called_once()
