"""Tests for content-aware box sizing calculations."""

import pytest

from src.maxpat.sizing import calculate_box_size, UI_SIZES
from src.maxpat.defaults import CHAR_WIDTH, PADDING, MIN_BOX_WIDTH, DEFAULT_HEIGHT


class TestTextBasedSizing:
    """Text-based sizing for newobj, comment, and message boxes."""

    def test_newobj_text_width(self):
        """Width = len(text) * CHAR_WIDTH + PADDING for newobj (fallback path)."""
        # Use an object name not in width overrides to test text-length calculation
        w, h = calculate_box_size("zzz_testobj~ 440", "newobj")
        expected_w = len("zzz_testobj~ 440") * CHAR_WIDTH + PADDING
        assert w == expected_w
        assert h == DEFAULT_HEIGHT

    def test_short_text_minimum_width(self):
        """Very short text enforces MIN_BOX_WIDTH."""
        # Use an object name not in width overrides
        w, h = calculate_box_size("z", "newobj")
        assert w == MIN_BOX_WIDTH
        assert h == DEFAULT_HEIGHT

    def test_empty_text_minimum_width(self):
        """Empty text still returns minimum width."""
        w, h = calculate_box_size("", "newobj")
        assert w == MIN_BOX_WIDTH
        assert h == DEFAULT_HEIGHT

    def test_long_text_scales(self):
        """Longer text produces wider box (fallback path)."""
        # Use object names not in width overrides to test text-length scaling
        w1, _ = calculate_box_size("zzz_short", "newobj")
        w2, _ = calculate_box_size("zzz_short 0 0 0 0 0 0 0 0", "newobj")
        assert w2 > w1

    def test_trigger_text_width(self):
        """Text-length fallback works for objects not in overrides."""
        text = "zzz_myobj b i f s"
        w, h = calculate_box_size(text, "newobj")
        expected_w = len(text) * CHAR_WIDTH + PADDING
        assert w == expected_w
        assert h == DEFAULT_HEIGHT


class TestUIFixedSizes:
    """UI objects return fixed (width, height) from UI_SIZES."""

    def test_toggle_size(self):
        w, h = calculate_box_size("", "toggle")
        assert (w, h) == (24.0, 24.0)

    def test_button_size(self):
        w, h = calculate_box_size("", "button")
        assert (w, h) == (24.0, 24.0)

    def test_slider_size(self):
        w, h = calculate_box_size("", "slider")
        assert (w, h) == (20.0, 140.0)

    def test_dial_size(self):
        w, h = calculate_box_size("", "dial")
        assert (w, h) == (40.0, 40.0)

    def test_ezdac_size(self):
        w, h = calculate_box_size("", "ezdac~")
        assert (w, h) == (45.0, 45.0)

    def test_ezadc_size(self):
        w, h = calculate_box_size("", "ezadc~")
        assert (w, h) == (45.0, 45.0)

    def test_number_size(self):
        w, h = calculate_box_size("", "number")
        assert (w, h) == (50.0, 22.0)

    def test_flonum_size(self):
        w, h = calculate_box_size("", "flonum")
        assert (w, h) == (50.0, 22.0)

    def test_scope_size(self):
        w, h = calculate_box_size("", "scope~")
        assert (w, h) == (130.0, 130.0)

    def test_spectroscope_size(self):
        w, h = calculate_box_size("", "spectroscope~")
        assert (w, h) == (300.0, 100.0)

    def test_meter_size(self):
        w, h = calculate_box_size("", "meter~")
        assert (w, h) == (15.0, 100.0)

    def test_gain_size(self):
        w, h = calculate_box_size("", "gain~")
        assert (w, h) == (22.0, 140.0)

    def test_panel_size(self):
        w, h = calculate_box_size("", "panel")
        assert (w, h) == (128.0, 128.0)

    def test_inlet_size(self):
        w, h = calculate_box_size("", "inlet")
        assert (w, h) == (30.0, 30.0)

    def test_outlet_size(self):
        w, h = calculate_box_size("", "outlet")
        assert (w, h) == (30.0, 30.0)


class TestCommentAndMessageSizing:
    """Comment and message boxes use text-based sizing."""

    def test_comment_text_based(self):
        """Comment uses text-based width, height 20.0."""
        text = "// OSCILLATOR SECTION"
        w, h = calculate_box_size(text, "comment")
        expected_w = len(text) * CHAR_WIDTH + PADDING
        assert w == expected_w
        assert h == 20.0  # Comment height is 20, not 22

    def test_message_text_based(self):
        """Message uses text-based width, height DEFAULT_HEIGHT."""
        text = "440"
        w, h = calculate_box_size(text, "message")
        expected_w = max(len(text) * CHAR_WIDTH + PADDING, MIN_BOX_WIDTH)
        assert w == expected_w
        assert h == DEFAULT_HEIGHT

    def test_empty_comment_minimum(self):
        """Empty comment still gets minimum width."""
        w, h = calculate_box_size("", "comment")
        assert w == MIN_BOX_WIDTH
        assert h == 20.0

    def test_empty_message_minimum(self):
        """Empty message still gets minimum width."""
        w, h = calculate_box_size("", "message")
        assert w == MIN_BOX_WIDTH
        assert h == DEFAULT_HEIGHT


class TestUISizesDict:
    """Verify UI_SIZES dictionary has expected entries."""

    def test_has_toggle(self):
        assert "toggle" in UI_SIZES

    def test_has_slider(self):
        assert "slider" in UI_SIZES

    def test_comment_is_text_based(self):
        assert UI_SIZES.get("comment") is None

    def test_message_is_text_based(self):
        assert UI_SIZES.get("message") is None

    def test_inlet_and_outlet_present(self):
        assert "inlet" in UI_SIZES
        assert "outlet" in UI_SIZES


class TestWidthOverrides:
    """Test width override lookup from audit data."""

    def test_known_object_uses_override(self):
        """Known object returns audit-based width, not text-length."""
        from src.maxpat.sizing import _WIDTH_OVERRIDES
        w, h = calculate_box_size("cycle~ 440", "newobj")
        text_based_w = len("cycle~ 440") * CHAR_WIDTH + PADDING
        # cycle~ should be in overrides with ~68.0 median width
        if "cycle~" in _WIDTH_OVERRIDES:
            expected = _WIDTH_OVERRIDES["cycle~"].get("1") or _WIDTH_OVERRIDES["cycle~"].get("default")
            assert w == expected
            assert h == DEFAULT_HEIGHT

    def test_unknown_object_falls_back_to_text(self):
        """Object not in overrides uses text-length calculation."""
        w, h = calculate_box_size("zzz_fake_object 1 2 3", "newobj")
        expected_w = max(len("zzz_fake_object 1 2 3") * CHAR_WIDTH + PADDING, MIN_BOX_WIDTH)
        assert w == expected_w

    def test_ui_object_unaffected_by_overrides(self):
        """UI objects still return fixed sizes regardless of overrides."""
        w, h = calculate_box_size("", "toggle")
        assert (w, h) == (24.0, 24.0)

    def test_override_returns_default_height(self):
        """Override width pairs with DEFAULT_HEIGHT."""
        from src.maxpat.sizing import _WIDTH_OVERRIDES
        if _WIDTH_OVERRIDES:
            obj_name = next(iter(_WIDTH_OVERRIDES))
            w, h = calculate_box_size(obj_name, "newobj")
            assert h == DEFAULT_HEIGHT

    def test_comment_not_affected_by_overrides(self):
        """Comments use text-based sizing, not overrides."""
        w, h = calculate_box_size("test comment", "comment")
        expected_w = max(len("test comment") * CHAR_WIDTH + PADDING, MIN_BOX_WIDTH)
        assert w == expected_w
        assert h == 20.0
