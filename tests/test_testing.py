"""Tests for manual test checklist generation from patch structure."""

from pathlib import Path

import pytest

from src.maxpat.testing import generate_test_checklist, save_test_results


def _make_patch(*object_names: str) -> dict:
    """Helper: build a minimal patch_dict with the given object names."""
    boxes = []
    for i, name in enumerate(object_names):
        boxes.append({
            "box": {
                "id": f"obj-{i}",
                "maxclass": "newobj",
                "text": name,
            }
        })
    return {
        "patcher": {
            "boxes": boxes,
            "lines": [],
        }
    }


class TestGenerateTestChecklist:
    """Tests for generate_test_checklist function."""

    def test_audio_patch_includes_audio_output_test(self):
        patch = _make_patch("cycle~", "*~ 0.5", "dac~")
        checklist = generate_test_checklist(patch, "audio-test")

        assert "audio" in checklist.lower() or "Audio" in checklist
        assert "dac~" in checklist or "sound" in checklist.lower() or "speakers" in checklist.lower()

    def test_midi_patch_includes_midi_test(self):
        patch = _make_patch("notein", "stripnote", "mtof")
        checklist = generate_test_checklist(patch, "midi-test")

        assert "MIDI" in checklist or "midi" in checklist

    def test_ui_patch_includes_toggle_test(self):
        patch = _make_patch("toggle", "metro 500")
        checklist = generate_test_checklist(patch, "ui-test")

        assert "toggle" in checklist.lower() or "click" in checklist.lower()

    def test_includes_setup_section(self):
        patch = _make_patch("cycle~", "dac~")
        checklist = generate_test_checklist(patch, "setup-test", patch_path="/path/to/patch.maxpat")

        assert "setup" in checklist.lower() or "Setup" in checklist
        assert "/path/to/patch.maxpat" in checklist or "patch.maxpat" in checklist

    def test_includes_audio_on_for_signal_objects(self):
        patch = _make_patch("cycle~", "dac~")
        checklist = generate_test_checklist(patch, "audio-setup")

        assert "audio on" in checklist.lower() or "Audio On" in checklist or "turn on audio" in checklist.lower()

    def test_numbered_format_with_action_expected(self):
        patch = _make_patch("cycle~", "dac~")
        checklist = generate_test_checklist(patch, "format-test")

        # Should have numbered steps
        assert "1." in checklist
        # Should have Action and Expected markers
        assert "Action" in checklist or "action" in checklist
        assert "Expected" in checklist or "expected" in checklist

    def test_empty_patch_returns_minimal_checklist(self):
        patch = _make_patch()
        checklist = generate_test_checklist(patch, "empty-test")

        # Should still have setup (open in MAX)
        assert "MAX" in checklist or "open" in checklist.lower()
        # Should have at least one test step
        assert "1." in checklist

    def test_gen_patch_includes_gen_test(self):
        patch = _make_patch("gen~", "dac~")
        checklist = generate_test_checklist(patch, "gen-test")

        assert "gen~" in checklist or "Gen" in checklist

    def test_button_includes_ui_test(self):
        patch = _make_patch("button", "message")
        checklist = generate_test_checklist(patch, "button-test")

        assert "button" in checklist.lower() or "click" in checklist.lower()

    def test_metro_includes_metro_test(self):
        patch = _make_patch("metro 500", "toggle")
        checklist = generate_test_checklist(patch, "metro-test")

        assert "metro" in checklist.lower() or "interval" in checklist.lower()

    def test_number_box_includes_number_test(self):
        patch = _make_patch("number", "print")
        checklist = generate_test_checklist(patch, "number-test")

        assert "number" in checklist.lower() or "value" in checklist.lower()

    def test_pass_fail_checkboxes(self):
        patch = _make_patch("cycle~", "dac~")
        checklist = generate_test_checklist(patch, "checkbox-test")

        assert "[ ] Pass" in checklist or "[  ] Pass" in checklist or "Pass" in checklist
        assert "[ ] Fail" in checklist or "[  ] Fail" in checklist or "Fail" in checklist


class TestSaveTestResults:
    """Tests for save_test_results function."""

    def test_writes_file_to_correct_location(self, tmp_path: Path):
        test_results_dir = tmp_path / "test-results"
        test_results_dir.mkdir()

        results_md = "# Test Results\n\n- [x] Pass: Audio output\n"
        result_path = save_test_results(tmp_path, "audio-check", results_md)

        assert result_path == test_results_dir / "audio-check.md"
        assert result_path.is_file()
        assert result_path.read_text() == results_md

    def test_creates_test_results_dir_if_missing(self, tmp_path: Path):
        results_md = "# Test Results\n\n- [x] Pass: Basic open\n"
        result_path = save_test_results(tmp_path, "basic-check", results_md)

        assert result_path.is_file()
        assert result_path.read_text() == results_md
