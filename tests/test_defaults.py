"""Smoke tests for src/maxpat/defaults.py constants and LayoutOptions."""

from src.maxpat.defaults import (
    AESTHETIC_PALETTE,
    BUBBLE_BOTTOM,
    BUBBLE_LEFT,
    BUBBLE_RIGHT,
    BUBBLE_TOP,
    CHAR_WIDTH,
    DEFAULT_HEIGHT,
    DEFAULT_PATCHER_PROPS,
    FONT_SIZE,
    FONTFACE_BOLD,
    FONTFACE_BOLD_ITALIC,
    FONTFACE_ITALIC,
    FONTFACE_REGULAR,
    H_GUTTER,
    LayoutOptions,
    MIN_BOX_WIDTH,
    V_SPACING,
)


class TestNumericConstants:
    def test_font_and_sizing_constants_positive(self):
        assert FONT_SIZE > 0
        assert CHAR_WIDTH > 0
        assert MIN_BOX_WIDTH > 0
        assert DEFAULT_HEIGHT > 0

    def test_spacing_pins_claude_md_rule_4(self):
        """CLAUDE.md Rule #4: ~20px vertical, ~15px horizontal gutter."""
        assert V_SPACING == 20
        assert H_GUTTER == 15


class TestLayoutOptions:
    def test_instantiates_with_defaults(self):
        opts = LayoutOptions()
        assert opts.v_spacing == 20.0
        assert opts.h_gutter == 15.0
        assert opts.grid_snap is True
        assert opts.inlet_align is True


class TestDefaultPatcherProps:
    def test_is_dict_with_expected_keys(self):
        assert isinstance(DEFAULT_PATCHER_PROPS, dict)
        for key in (
            "fileversion", "appversion", "rect",
            "default_fontname", "default_fontsize",
            "boxes", "lines",
        ):
            assert key in DEFAULT_PATCHER_PROPS, key

    def test_targets_max_9(self):
        assert DEFAULT_PATCHER_PROPS["appversion"]["major"] == 9


class TestAestheticPalette:
    def test_entries_are_rgba_lists_in_unit_range(self):
        for name, value in AESTHETIC_PALETTE.items():
            assert isinstance(value, list), name
            assert len(value) == 4, name
            for channel in value:
                assert isinstance(channel, float), name
                assert 0.0 <= channel <= 1.0, name


class TestEnumStyleConstants:
    def test_fontface_values(self):
        assert (FONTFACE_REGULAR, FONTFACE_BOLD, FONTFACE_ITALIC,
                FONTFACE_BOLD_ITALIC) == (0, 1, 2, 3)

    def test_bubble_values(self):
        assert (BUBBLE_LEFT, BUBBLE_TOP, BUBBLE_RIGHT,
                BUBBLE_BOTTOM) == (0, 1, 2, 3)
