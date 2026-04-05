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
            override_w = _WIDTH_OVERRIDES["cycle~"].get("1") or _WIDTH_OVERRIDES["cycle~"].get("default")
            text_based_w = len("cycle~ 440") * CHAR_WIDTH + PADDING
            # After fix: override acts as floor, text_width can exceed it
            assert w == max(override_w, text_based_w)
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


class TestOverrideFloorBehavior:
    """Override width acts as a floor, not a cap -- max(override, text_width)."""

    def test_long_arg_exceeds_override_uses_text_width(self):
        """receive~ with long arg: text width (198.0) > override (94.0), text wins."""
        from src.maxpat.sizing import _WIDTH_OVERRIDES
        text = "receive~ mt-glide-freq-sig"
        w, h = calculate_box_size(text, "newobj")
        text_width = len(text) * CHAR_WIDTH + PADDING
        # text_width = 26 * 7.0 + 16.0 = 198.0
        assert text_width == 198.0
        if "receive~" in _WIDTH_OVERRIDES:
            override_w = _WIDTH_OVERRIDES["receive~"].get("1") or _WIDTH_OVERRIDES["receive~"].get("default")
            assert override_w < text_width, "Override should be smaller than text width for this test"
            assert w == text_width, f"Expected text_width {text_width}, got {w}"
        assert h == DEFAULT_HEIGHT

    def test_long_send_arg_exceeds_override(self):
        """send~ with long arg: text width > override (88.0), text wins."""
        from src.maxpat.sizing import _WIDTH_OVERRIDES
        text = "send~ my-very-long-signal-name"
        w, h = calculate_box_size(text, "newobj")
        text_width = len(text) * CHAR_WIDTH + PADDING
        if "send~" in _WIDTH_OVERRIDES:
            override_w = _WIDTH_OVERRIDES["send~"].get("1") or _WIDTH_OVERRIDES["send~"].get("default")
            assert w > override_w, f"Width {w} should exceed override {override_w}"
            assert w == text_width, f"Expected text_width {text_width}, got {w}"
        assert h == DEFAULT_HEIGHT

    def test_bare_object_keeps_override(self):
        """cycle~ (no args): override 68.0 > text_width 58.0, override wins."""
        from src.maxpat.sizing import _WIDTH_OVERRIDES
        w, h = calculate_box_size("cycle~", "newobj")
        text_width = len("cycle~") * CHAR_WIDTH + PADDING
        # text_width = 6 * 7.0 + 16.0 = 58.0
        assert text_width == 58.0
        if "cycle~" in _WIDTH_OVERRIDES:
            override_w = _WIDTH_OVERRIDES["cycle~"].get("0") or _WIDTH_OVERRIDES["cycle~"].get("default")
            assert override_w == 68.0
            assert w == 68.0
        assert h == DEFAULT_HEIGHT

    def test_bare_receive_keeps_override(self):
        """receive~ (no args): override 94.0 > text_width 72.0, override wins."""
        from src.maxpat.sizing import _WIDTH_OVERRIDES
        w, h = calculate_box_size("receive~", "newobj")
        text_width = len("receive~") * CHAR_WIDTH + PADDING
        # text_width = 8 * 7.0 + 16.0 = 72.0
        assert text_width == 72.0
        if "receive~" in _WIDTH_OVERRIDES:
            override_w = _WIDTH_OVERRIDES["receive~"].get("0") or _WIDTH_OVERRIDES["receive~"].get("default")
            assert override_w == 94.0
            assert w == 94.0
        assert h == DEFAULT_HEIGHT


class TestLiveObjectSizes:
    """Tests for live.* object sizing and maxclass completeness."""

    # All live.* objects from m4l/objects.json
    ALL_LIVE_OBJECTS = [
        "live.arrows", "live.banks", "live.button", "live.colors",
        "live.comment", "live.dial", "live.drop", "live.gain~",
        "live.grid", "live.line", "live.map", "live.menu",
        "live.meter~", "live.miditool.in", "live.miditool.out",
        "live.modulate~", "live.numbox", "live.object", "live.observer",
        "live.param~", "live.path", "live.push", "live.remote~",
        "live.routing", "live.slider", "live.step", "live.tab",
        "live.text", "live.thisdevice", "live.toggle",
    ]

    # Visual widgets with fixed sizes
    VISUAL_WIDGETS = {
        "live.arrows": (54.0, 15.0),
        "live.banks": (315.0, 45.0),
        "live.colors": (168.0, 45.0),
        "live.comment": (150.0, 18.0),
        "live.drop": (140.0, 50.0),
        "live.grid": (240.0, 165.0),
        "live.line": (100.0, 35.0),
        "live.step": (240.0, 60.0),
        "live.scope~": (131.0, 131.0),
    }

    # Non-visual utility objects (None = text-sized)
    NON_VISUAL = [
        "live.observer", "live.thisdevice", "live.path", "live.object",
        "live.map", "live.routing", "live.push", "live.miditool.in",
        "live.miditool.out", "live.remote~", "live.param~", "live.modulate~",
    ]

    def test_all_live_in_ui_maxclasses(self):
        """All live.* objects from m4l DB are in UI_MAXCLASSES."""
        from src.maxpat.maxclass_map import UI_MAXCLASSES
        for obj_name in self.ALL_LIVE_OBJECTS:
            assert obj_name in UI_MAXCLASSES, f"{obj_name} missing from UI_MAXCLASSES"

    def test_visual_widgets_have_fixed_sizes(self):
        """Visual live.* widgets return correct (w,h) from calculate_box_size."""
        for obj_name, expected_size in self.VISUAL_WIDGETS.items():
            w, h = calculate_box_size("", obj_name)
            assert (w, h) == expected_size, (
                f"{obj_name}: expected {expected_size}, got ({w}, {h})"
            )

    def test_non_visual_have_none_in_ui_sizes(self):
        """Non-visual utility live.* objects have None in UI_SIZES."""
        for obj_name in self.NON_VISUAL:
            assert obj_name in UI_SIZES, f"{obj_name} missing from UI_SIZES"
            assert UI_SIZES[obj_name] is None, (
                f"{obj_name} should be None in UI_SIZES, got {UI_SIZES[obj_name]}"
            )
