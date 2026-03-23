"""Tests for file write hooks and public API integration.

Tests validate_file(), finalize_patch(), and the public API importability from src.maxpat.
"""

import json
from pathlib import Path

import pytest


# ---------------------------------------------------------------------------
# Public API importability
# ---------------------------------------------------------------------------

def test_public_api_importable():
    """All public names importable from src.maxpat."""
    from src.maxpat import (
        Patcher,
        Box,
        Patchline,
        read_patch,
        save_patch_roundtrip,
        validate_file,
        ValidationResult,
        PatchGenerationError,
        PatchValidationError,
        ObjectDatabase,
        LayoutOptions,
        auto_size_panel,
        is_complex_patch,
    )
    # Sanity check types
    assert callable(read_patch)
    assert callable(save_patch_roundtrip)
    assert callable(validate_file)
    assert Patcher is not None
    assert Box is not None
    assert Patchline is not None
    assert ValidationResult is not None
    assert PatchGenerationError is not None
    assert PatchValidationError is not None
    assert ObjectDatabase is not None
    assert LayoutOptions is not None
    assert callable(auto_size_panel)
    assert callable(is_complex_patch)


# ---------------------------------------------------------------------------
# validate_file
# ---------------------------------------------------------------------------

def test_validate_file_loads_and_validates(tmp_path):
    """validate_file loads .maxpat from disk and runs validation."""
    from src.maxpat import Patcher, validate_file
    from src.maxpat.hooks import save_patch_roundtrip

    p = Patcher()
    osc = p.add_box("cycle~", ["440"])
    gain = p.add_box("*~", ["0.5"])
    dac = p.add_box("ezdac~")
    p.add_connection(osc, 0, gain, 0)
    p.add_connection(gain, 0, dac, 0)
    p.add_connection(gain, 0, dac, 1)

    out_path = tmp_path / "test.maxpat"
    save_patch_roundtrip(p.to_dict(), out_path)

    results = validate_file(out_path)
    assert isinstance(results, list)
    # A valid patch should not have blocking errors
    from src.maxpat import has_blocking_errors
    assert not has_blocking_errors(results)


def test_validate_file_missing_file():
    """validate_file raises FileNotFoundError for missing file."""
    from src.maxpat import validate_file

    with pytest.raises(FileNotFoundError):
        validate_file("/tmp/nonexistent_file_12345.maxpat")


def test_validate_file_invalid_json(tmp_path):
    """validate_file returns errors for invalid JSON file."""
    from src.maxpat import validate_file

    bad_file = tmp_path / "bad.maxpat"
    bad_file.write_text("{ this is not valid json }")

    results = validate_file(bad_file)
    assert len(results) > 0
    assert any(r.level == "error" for r in results)
    assert any("json" in r.message.lower() or "json" in r.layer.lower() for r in results)


# ---------------------------------------------------------------------------
# read_patch
# ---------------------------------------------------------------------------

class TestReadPatch:
    """Tests for read_patch() convenience function."""

    def _write_minimal_patch(self, path):
        """Write a minimal valid .maxpat JSON file and return its text."""
        from src.maxpat import Patcher
        p = Patcher()
        p.add_box("cycle~", ["440"])
        p.add_box("ezdac~")
        data = p.to_dict()
        text = json.dumps(data, indent=4)
        path.write_text(text)
        return text

    def test_returns_patcher_and_text(self, tmp_path):
        """read_patch returns (Patcher, str) tuple."""
        from src.maxpat.hooks import read_patch
        from src.maxpat.patcher import Patcher
        fpath = tmp_path / "test.maxpat"
        self._write_minimal_patch(fpath)
        result = read_patch(str(fpath))
        assert isinstance(result, tuple)
        assert len(result) == 2
        patcher, text = result
        assert isinstance(patcher, Patcher)
        assert isinstance(text, str)

    def test_patcher_has_correct_box_count(self, tmp_path):
        """Returned Patcher has boxes populated from file."""
        from src.maxpat.hooks import read_patch
        fpath = tmp_path / "test.maxpat"
        self._write_minimal_patch(fpath)
        patcher, _ = read_patch(str(fpath))
        assert len(patcher.boxes) == 2

    def test_original_text_matches_file(self, tmp_path):
        """Returned original_text matches what was written."""
        from src.maxpat.hooks import read_patch
        fpath = tmp_path / "test.maxpat"
        written = self._write_minimal_patch(fpath)
        _, text = read_patch(str(fpath))
        assert text == written

    def test_original_text_for_roundtrip(self, tmp_path):
        """original_text can be passed to save_patch_roundtrip for zero-diff."""
        from src.maxpat.hooks import read_patch, save_patch_roundtrip
        fpath = tmp_path / "test.maxpat"
        self._write_minimal_patch(fpath)
        patcher, original_text = read_patch(str(fpath))
        # Re-save with original_text
        out_path = tmp_path / "resaved.maxpat"
        save_patch_roundtrip(patcher.to_dict(), out_path, original_text)
        # Content should match original
        assert out_path.read_text() == original_text

    def test_accepts_pathlib_path(self, tmp_path):
        """read_patch accepts pathlib.Path argument."""
        from src.maxpat.hooks import read_patch
        from pathlib import Path
        fpath = tmp_path / "test.maxpat"
        self._write_minimal_patch(fpath)
        patcher, text = read_patch(Path(fpath))
        assert len(patcher.boxes) == 2

    def test_file_not_found_error(self):
        """read_patch raises FileNotFoundError on nonexistent file."""
        from src.maxpat.hooks import read_patch
        with pytest.raises(FileNotFoundError):
            read_patch("/tmp/nonexistent_12345.maxpat")

    def test_invalid_json_error(self, tmp_path):
        """read_patch raises json.JSONDecodeError on invalid JSON."""
        import json as json_mod
        from src.maxpat.hooks import read_patch
        fpath = tmp_path / "bad.maxpat"
        fpath.write_text("{ not valid json !!!")
        with pytest.raises(json_mod.JSONDecodeError):
            read_patch(str(fpath))

    def test_missing_patcher_key_error(self, tmp_path):
        """read_patch raises ValueError on JSON without 'patcher' key."""
        from src.maxpat.hooks import read_patch
        fpath = tmp_path / "no_patcher.maxpat"
        fpath.write_text(json.dumps({"foo": "bar"}))
        with pytest.raises(ValueError):
            read_patch(str(fpath))

    def test_loads_real_patch(self):
        """read_patch loads a real project patch and returns populated Patcher."""
        from src.maxpat.hooks import read_patch
        import os
        # Use kicksynth as a real test fixture
        real_path = os.path.join(
            os.path.dirname(__file__), "..",
            "patches", "kicksynth", "generated", "kicksynth.maxpat",
        )
        if not os.path.exists(real_path):
            pytest.skip("kicksynth.maxpat not available")
        patcher, text = read_patch(real_path)
        assert len(patcher.boxes) > 0
        assert len(text) > 0

    def test_importable_from_public_api(self):
        """read_patch is importable from src.maxpat."""
        from src.maxpat import read_patch
        assert callable(read_patch)


# ---------------------------------------------------------------------------
# finalize_patch
# ---------------------------------------------------------------------------

class TestFinalizePatch:
    """Tests for finalize_patch() hook function."""

    def test_new_patch_applies_layout(self):
        """finalize_patch(patcher, is_new=True) repositions boxes top-to-bottom."""
        from src.maxpat import Patcher
        from src.maxpat.hooks import finalize_patch

        p = Patcher()
        osc = p.add_box("cycle~", ["440"])
        gain = p.add_box("*~", ["0.5"])
        dac = p.add_box("ezdac~")
        p.add_connection(osc, 0, gain, 0)
        p.add_connection(gain, 0, dac, 0)
        p.add_connection(gain, 0, dac, 1)

        finalize_patch(p, is_new=True)

        # Boxes should be in top-to-bottom y order after layout
        assert osc.patching_rect[1] < gain.patching_rect[1]
        assert gain.patching_rect[1] < dac.patching_rect[1]

    def test_edit_patch_preserves_positions(self):
        """finalize_patch(patcher, is_new=False) does NOT reposition boxes."""
        from src.maxpat import Patcher
        from src.maxpat.hooks import finalize_patch

        p = Patcher()
        osc = p.add_box("cycle~", ["440"])
        gain = p.add_box("*~", ["0.5"])
        dac = p.add_box("ezdac~")
        p.add_connection(osc, 0, gain, 0)
        p.add_connection(gain, 0, dac, 0)
        p.add_connection(gain, 0, dac, 1)

        # Manually set specific positions (simulate loaded patch)
        osc.patching_rect = [100.0, 200.0, 80.0, 22.0]
        gain.patching_rect = [100.0, 250.0, 80.0, 22.0]
        dac.patching_rect = [100.0, 300.0, 80.0, 22.0]

        finalize_patch(p, is_new=False)

        # Original positions should be preserved
        assert osc.patching_rect[0] == 100.0
        assert osc.patching_rect[1] == 200.0
        assert gain.patching_rect[0] == 100.0
        assert gain.patching_rect[1] == 250.0
        assert dac.patching_rect[0] == 100.0
        assert dac.patching_rect[1] == 300.0

    def test_edit_patch_generates_midpoints_for_offset_cables(self):
        """finalize_patch(patcher, is_new=False) generates midpoints on offset cables."""
        from src.maxpat import Patcher
        from src.maxpat.hooks import finalize_patch

        p = Patcher()
        osc = p.add_box("cycle~", ["440"])
        gain = p.add_box("*~", ["0.5"])
        p.add_connection(osc, 0, gain, 0)

        # Place boxes with significant horizontal offset to trigger midpoints
        osc.patching_rect = [30.0, 30.0, 80.0, 22.0]
        gain.patching_rect = [250.0, 80.0, 80.0, 22.0]

        finalize_patch(p, is_new=False)

        # At least one line should have midpoints due to horizontal offset
        has_midpoints = any(line.midpoints for line in p.lines)
        assert has_midpoints, "Expected midpoints on horizontally offset cable"

    def test_new_patch_recurses_into_subpatchers(self):
        """finalize_patch(patcher, is_new=True) applies layout to subpatcher contents."""
        from src.maxpat import Patcher
        from src.maxpat.hooks import finalize_patch

        p = Patcher()
        # Add a subpatcher with objects inside
        sub_box, inner = p.add_subpatcher("audio_proc", inlets=1, outlets=1)
        osc = inner.add_box("cycle~", ["440"])
        gain = inner.add_box("*~", ["0.5"])
        inner.add_connection(osc, 0, gain, 0)

        finalize_patch(p, is_new=True)

        # Inner patcher objects should be laid out top-to-bottom
        assert osc.patching_rect[1] < gain.patching_rect[1]

    def test_importable_from_src_maxpat(self):
        """finalize_patch is importable from src.maxpat."""
        from src.maxpat import finalize_patch
        assert callable(finalize_patch)
