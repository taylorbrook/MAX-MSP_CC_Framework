"""Tests for file write hooks and public API integration.

Tests write_patch(), validate_file(), generate_patch(), and the public API
importability from src.maxpat.
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
        generate_patch,
        write_patch,
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
    assert callable(generate_patch)
    assert callable(write_patch)
    assert callable(validate_file)
    assert LayoutOptions is not None
    assert callable(auto_size_panel)
    assert callable(is_complex_patch)


# ---------------------------------------------------------------------------
# generate_patch
# ---------------------------------------------------------------------------

def test_generate_patch_returns_dict_and_results():
    """generate_patch(patcher) returns (dict, list[ValidationResult])."""
    from src.maxpat import Patcher, generate_patch, ValidationResult

    p = Patcher()
    osc = p.add_box("cycle~", ["440"])
    gain = p.add_box("*~", ["0.5"])
    dac = p.add_box("ezdac~")
    p.add_connection(osc, 0, gain, 0)
    p.add_connection(gain, 0, dac, 0)
    p.add_connection(gain, 0, dac, 1)

    patch_dict, results = generate_patch(p)

    assert isinstance(patch_dict, dict)
    assert "patcher" in patch_dict
    assert isinstance(results, list)
    for r in results:
        assert isinstance(r, ValidationResult)


def test_generate_patch_applies_layout():
    """generate_patch applies layout -- boxes have non-zero positions."""
    from src.maxpat import Patcher, generate_patch

    p = Patcher()
    osc = p.add_box("cycle~", ["440"])
    dac = p.add_box("ezdac~")
    p.add_connection(osc, 0, dac, 0)

    patch_dict, _ = generate_patch(p)

    boxes = patch_dict["patcher"]["boxes"]
    # At least one box should have a non-zero x or y position (layout applied)
    has_nonzero_pos = any(
        b["box"]["patching_rect"][0] > 0 or b["box"]["patching_rect"][1] > 0
        for b in boxes
    )
    assert has_nonzero_pos, "Layout should set non-zero positions"


def test_generate_patch_runs_validation():
    """generate_patch runs validation and returns results."""
    from src.maxpat import Patcher, generate_patch

    p = Patcher()
    # cycle~ directly to ezdac~ -- should produce gain staging warning
    osc = p.add_box("cycle~", ["440"])
    dac = p.add_box("ezdac~")
    p.add_connection(osc, 0, dac, 0)
    p.add_connection(osc, 0, dac, 1)

    _, results = generate_patch(p)
    # Should have at least one validation result (gain staging warning)
    assert len(results) > 0
    msgs = [r.message for r in results]
    assert any("gain" in m.lower() for m in msgs), f"Expected gain warning, got: {msgs}"


# ---------------------------------------------------------------------------
# write_patch
# ---------------------------------------------------------------------------

def test_write_patch_creates_file(tmp_path):
    """write_patch creates a .maxpat file on disk."""
    from src.maxpat import Patcher, write_patch

    p = Patcher()
    osc = p.add_box("cycle~", ["440"])
    gain = p.add_box("*~", ["0.5"])
    dac = p.add_box("ezdac~")
    p.add_connection(osc, 0, gain, 0)
    p.add_connection(gain, 0, dac, 0)
    p.add_connection(gain, 0, dac, 1)

    out_path = tmp_path / "test.maxpat"
    write_patch(p, out_path)

    assert out_path.exists()
    assert out_path.stat().st_size > 0


def test_write_patch_valid_json(tmp_path):
    """Written file is valid JSON loadable by json.loads."""
    from src.maxpat import Patcher, write_patch

    p = Patcher()
    osc = p.add_box("cycle~", ["440"])
    gain = p.add_box("*~", ["0.5"])
    dac = p.add_box("ezdac~")
    p.add_connection(osc, 0, gain, 0)
    p.add_connection(gain, 0, dac, 0)
    p.add_connection(gain, 0, dac, 1)

    out_path = tmp_path / "test.maxpat"
    write_patch(p, out_path)

    data = json.loads(out_path.read_text())
    assert "patcher" in data
    assert isinstance(data["patcher"]["boxes"], list)
    assert isinstance(data["patcher"]["lines"], list)


def test_write_patch_creates_parent_directories(tmp_path):
    """write_patch creates parent directories if they don't exist."""
    from src.maxpat import Patcher, write_patch

    p = Patcher()
    p.add_box("ezdac~")

    out_path = tmp_path / "deep" / "nested" / "dir" / "test.maxpat"
    write_patch(p, out_path)

    assert out_path.exists()


def test_write_patch_blocks_on_unfixable_errors(tmp_path):
    """write_patch raises PatchValidationError on unfixable errors."""
    from src.maxpat import Patcher, write_patch, PatchGenerationError

    # Create a patcher and add a box, then corrupt the box to produce
    # an unfixable validation error. We monkeypatch to_dict to return
    # a dict that fails structural validation.
    p = Patcher()
    p.add_box("ezdac~")

    # Save original to_dict and replace with one that returns corrupted data
    original_to_dict = p.to_dict

    def corrupted_to_dict():
        d = original_to_dict()
        # Replace boxes with a non-list to trigger JSON structure error
        d["patcher"]["boxes"] = "not_a_list"
        return d

    p.to_dict = corrupted_to_dict

    out_path = tmp_path / "should_not_exist.maxpat"
    with pytest.raises(PatchGenerationError):
        write_patch(p, str(out_path))


def test_write_patch_returns_results(tmp_path):
    """write_patch returns validation results (warnings visible to caller)."""
    from src.maxpat import Patcher, write_patch

    p = Patcher()
    osc = p.add_box("cycle~", ["440"])
    gain = p.add_box("*~", ["0.5"])
    dac = p.add_box("ezdac~")
    p.add_connection(osc, 0, gain, 0)
    p.add_connection(gain, 0, dac, 0)
    p.add_connection(gain, 0, dac, 1)

    out_path = tmp_path / "test.maxpat"
    results = write_patch(p, out_path)

    assert isinstance(results, list)


def test_write_patch_validate_false_skips_validation(tmp_path):
    """write_patch with validate=False skips validation."""
    from src.maxpat import Patcher, write_patch

    p = Patcher()
    # cycle~ -> ezdac~ with no gain -- normally produces warning
    osc = p.add_box("cycle~", ["440"])
    dac = p.add_box("ezdac~")
    p.add_connection(osc, 0, dac, 0)

    out_path = tmp_path / "test.maxpat"
    results = write_patch(p, out_path, validate=False)

    # With validate=False, no validation results should be returned
    assert results == []
    assert out_path.exists()


def test_write_patch_indent(tmp_path):
    """write_patch uses json.dumps with indent=2 for readable output."""
    from src.maxpat import Patcher, write_patch

    p = Patcher()
    p.add_box("ezdac~")

    out_path = tmp_path / "test.maxpat"
    write_patch(p, out_path)

    content = out_path.read_text()
    # Indented JSON should have newlines and leading spaces
    assert "\n" in content
    assert "  " in content


# ---------------------------------------------------------------------------
# validate_file
# ---------------------------------------------------------------------------

def test_validate_file_loads_and_validates(tmp_path):
    """validate_file loads .maxpat from disk and runs validation."""
    from src.maxpat import Patcher, write_patch, validate_file

    p = Patcher()
    osc = p.add_box("cycle~", ["440"])
    gain = p.add_box("*~", ["0.5"])
    dac = p.add_box("ezdac~")
    p.add_connection(osc, 0, gain, 0)
    p.add_connection(gain, 0, dac, 0)
    p.add_connection(gain, 0, dac, 1)

    out_path = tmp_path / "test.maxpat"
    write_patch(p, out_path)

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
# write_patch layout_options forwarding
# ---------------------------------------------------------------------------

def test_write_patch_forwards_layout_options(tmp_path):
    """write_patch with layout_options writes file without error."""
    from src.maxpat import Patcher, write_patch
    from src.maxpat.defaults import LayoutOptions

    p = Patcher()
    osc = p.add_box("cycle~", ["440"])
    gain = p.add_box("*~", ["0.5"])
    dac = p.add_box("ezdac~")
    p.add_connection(osc, 0, gain, 0)
    p.add_connection(gain, 0, dac, 0)
    p.add_connection(gain, 0, dac, 1)

    out_path = tmp_path / "layout_opts.maxpat"
    results = write_patch(p, out_path, layout_options=LayoutOptions(v_spacing=50))

    assert out_path.exists()
    # Verify valid JSON was written
    data = json.loads(out_path.read_text())
    assert "patcher" in data
    assert isinstance(results, list)


def test_write_patch_validate_false_with_layout_options(tmp_path):
    """write_patch with validate=False and layout_options still writes file."""
    from src.maxpat import Patcher, write_patch
    from src.maxpat.defaults import LayoutOptions

    p = Patcher()
    osc = p.add_box("cycle~", ["440"])
    dac = p.add_box("ezdac~")
    p.add_connection(osc, 0, dac, 0)

    out_path = tmp_path / "no_validate.maxpat"
    results = write_patch(
        p, out_path, validate=False, layout_options=LayoutOptions(v_spacing=50),
    )

    assert out_path.exists()
    assert results == []
    # Verify valid JSON was written
    data = json.loads(out_path.read_text())
    assert "patcher" in data


def test_write_patch_backward_compat(tmp_path):
    """write_patch without layout_options still works as before."""
    from src.maxpat import Patcher, write_patch

    p = Patcher()
    osc = p.add_box("cycle~", ["440"])
    gain = p.add_box("*~", ["0.5"])
    dac = p.add_box("ezdac~")
    p.add_connection(osc, 0, gain, 0)
    p.add_connection(gain, 0, dac, 0)
    p.add_connection(gain, 0, dac, 1)

    out_path = tmp_path / "backward_compat.maxpat"
    results = write_patch(p, out_path)

    assert out_path.exists()
    assert isinstance(results, list)


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
