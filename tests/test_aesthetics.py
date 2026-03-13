"""Tests for aesthetic styling: palette, comment tiers, bubble comments, patcher styling.

Covers CMNT-01..04, PTCH-01, PTCH-02 requirements from phase 10.
"""

import pytest

from src.maxpat.defaults import (
    AESTHETIC_PALETTE,
    BUBBLE_BOTTOM,
    BUBBLE_LEFT,
    BUBBLE_RIGHT,
    BUBBLE_TOP,
    FONTFACE_BOLD,
    FONTFACE_BOLD_ITALIC,
    FONTFACE_ITALIC,
    FONTFACE_REGULAR,
)
from src.maxpat.patcher import Patcher
from src.maxpat.aesthetics import set_canvas_background, set_object_bgcolor


class TestPalette:
    """Tests for AESTHETIC_PALETTE constants and fontface/bubble constants."""

    def test_palette_has_all_roles(self):
        """AESTHETIC_PALETTE has all 13 named role keys."""
        expected_keys = {
            "header_color",
            "header_bgcolor",
            "subsection_color",
            "annotation_color",
            "panel_fill",
            "panel_gradient_end",
            "canvas_bg",
            "warning_color",
            "step_marker_bg",
            "step_marker_text",
            "emphasis_loadbang",
            "emphasis_dac",
            "emphasis_processor",
        }
        assert set(AESTHETIC_PALETTE.keys()) == expected_keys

    def test_palette_values_are_rgba(self):
        """Every palette value is a list of 4 floats in [0.0, 1.0]."""
        for key, value in AESTHETIC_PALETTE.items():
            assert isinstance(value, list), f"{key} is not a list"
            assert len(value) == 4, f"{key} does not have 4 elements"
            for i, component in enumerate(value):
                assert isinstance(component, float), (
                    f"{key}[{i}] is not a float"
                )
                assert 0.0 <= component <= 1.0, (
                    f"{key}[{i}] = {component} not in [0.0, 1.0]"
                )

    def test_fontface_constants(self):
        """Fontface constants match MAX bitmask encoding."""
        assert FONTFACE_REGULAR == 0
        assert FONTFACE_BOLD == 1
        assert FONTFACE_ITALIC == 2
        assert FONTFACE_BOLD_ITALIC == 3

    def test_bubble_constants(self):
        """Bubble direction constants match MAX bubbleside values."""
        assert BUBBLE_LEFT == 0
        assert BUBBLE_TOP == 1
        assert BUBBLE_RIGHT == 2
        assert BUBBLE_BOTTOM == 3


class TestCommentTiers:
    """Tests for section header, subsection, and annotation comment methods."""

    def test_section_header(self):
        """add_section_header produces a comment box with 16pt bold, header colors."""
        p = Patcher()
        box = p.add_section_header("Audio Input")
        assert box.maxclass == "comment"
        assert box.fontsize == 16.0
        assert box.extra_attrs["fontface"] == FONTFACE_BOLD
        assert box.extra_attrs["textcolor"] == list(AESTHETIC_PALETTE["header_color"])
        assert box.extra_attrs["bgcolor"] == list(AESTHETIC_PALETTE["header_bgcolor"])

    def test_section_header_sizing(self):
        """Section header patching_rect accounts for 16pt chars."""
        p = Patcher()
        box = p.add_section_header("Audio Input")
        # Width should account for wider chars at 16pt
        expected_width = len("Audio Input") * 9.5 + 20.0
        assert box.patching_rect[2] == pytest.approx(expected_width)
        # Height should be >= 24.0 for 16pt text
        assert box.patching_rect[3] >= 24.0

    def test_subsection(self):
        """add_subsection produces a comment box with 12pt bold, dark gray."""
        p = Patcher()
        box = p.add_subsection("Filter")
        assert box.maxclass == "comment"
        assert box.fontsize == 12.0
        assert box.extra_attrs["fontface"] == FONTFACE_BOLD
        assert box.extra_attrs["textcolor"] == list(
            AESTHETIC_PALETTE["subsection_color"]
        )
        # Subsection should NOT have bgcolor
        assert "bgcolor" not in box.extra_attrs

    def test_annotation(self):
        """add_annotation produces a comment box with 10pt italic, light gray."""
        p = Patcher()
        box = p.add_annotation("signal flow")
        assert box.maxclass == "comment"
        assert box.fontsize == 10.0
        assert box.extra_attrs["fontface"] == FONTFACE_ITALIC
        assert box.extra_attrs["textcolor"] == list(
            AESTHETIC_PALETTE["annotation_color"]
        )

    def test_annotation_sizing(self):
        """Annotation patching_rect accounts for 10pt chars (narrower)."""
        p = Patcher()
        box = p.add_annotation("signal flow")
        # Width should account for narrower chars at 10pt
        expected_width = len("signal flow") * 6.0 + 14.0
        assert box.patching_rect[2] == pytest.approx(expected_width)
        # Height should be <= 20.0 for 10pt text
        assert box.patching_rect[3] <= 20.0

    def test_three_tiers_distinct(self):
        """All three tiers produce different fontsize, fontface, and textcolor."""
        p = Patcher()
        header = p.add_section_header("H")
        subsection = p.add_subsection("S")
        annotation = p.add_annotation("A")

        # fontsize must differ across all three
        sizes = {header.fontsize, subsection.fontsize, annotation.fontsize}
        assert len(sizes) == 3, f"Expected 3 distinct fontsizes, got {sizes}"

        # fontface must differ (bold vs bold vs italic -- header and subsection
        # share bold, but annotation is italic)
        faces = {
            header.extra_attrs["fontface"],
            subsection.extra_attrs["fontface"],
            annotation.extra_attrs["fontface"],
        }
        assert len(faces) >= 2, f"Expected at least 2 distinct fontfaces, got {faces}"

        # textcolor must differ across all three
        colors = {
            tuple(header.extra_attrs["textcolor"]),
            tuple(subsection.extra_attrs["textcolor"]),
            tuple(annotation.extra_attrs["textcolor"]),
        }
        assert len(colors) == 3, f"Expected 3 distinct textcolors, got {colors}"

    def test_comment_serialization(self):
        """Box.to_dict()['box'] for each tier has correct structure."""
        p = Patcher()

        # Section header
        header = p.add_section_header("Test Header")
        hd = header.to_dict()["box"]
        assert hd["maxclass"] == "comment"
        assert hd["text"] == "Test Header"
        assert hd["fontname"] == "Arial"
        assert hd["fontsize"] == 16.0
        assert hd["fontface"] == FONTFACE_BOLD
        assert hd["textcolor"] == list(AESTHETIC_PALETTE["header_color"])
        assert hd["bgcolor"] == list(AESTHETIC_PALETTE["header_bgcolor"])

        # Subsection
        sub = p.add_subsection("Test Sub")
        sd = sub.to_dict()["box"]
        assert sd["maxclass"] == "comment"
        assert sd["text"] == "Test Sub"
        assert sd["fontsize"] == 12.0
        assert sd["fontface"] == FONTFACE_BOLD
        assert sd["textcolor"] == list(AESTHETIC_PALETTE["subsection_color"])
        assert "bgcolor" not in sd

        # Annotation
        ann = p.add_annotation("test note")
        ad = ann.to_dict()["box"]
        assert ad["maxclass"] == "comment"
        assert ad["text"] == "test note"
        assert ad["fontsize"] == 10.0
        assert ad["fontface"] == FONTFACE_ITALIC
        assert ad["textcolor"] == list(AESTHETIC_PALETTE["annotation_color"])


class TestBubbleComments:
    """Tests for bubble comment method."""

    def test_bubble_basic(self):
        """add_bubble produces a comment box with bubble=1."""
        p = Patcher()
        box = p.add_bubble("clear", 10.0, 20.0)
        assert box.maxclass == "comment"
        assert box.extra_attrs["bubble"] == 1

    def test_bubble_default_direction(self):
        """Default bubbleside is 1 (top, arrow points down)."""
        p = Patcher()
        box = p.add_bubble("clear", 10.0, 20.0)
        assert box.extra_attrs["bubbleside"] == BUBBLE_TOP
        assert box.extra_attrs["bubbleside"] == 1

    def test_bubble_custom_direction(self):
        """Custom bubbleside is applied correctly."""
        p = Patcher()
        box = p.add_bubble("clear", 10.0, 20.0, bubbleside=BUBBLE_LEFT)
        assert box.extra_attrs["bubbleside"] == 0

    def test_bubble_sizing(self):
        """Bubble comment has extra width (~17px) and height ~25.0."""
        p = Patcher()
        # Create a regular comment for comparison
        regular = p.add_comment("clear", 0.0, 0.0)
        regular_width = regular.patching_rect[2]

        bubble = p.add_bubble("clear", 0.0, 0.0)
        # Bubble should be wider by ~17px
        assert bubble.patching_rect[2] == pytest.approx(regular_width + 17.0)
        # Bubble height should be ~25.0
        assert bubble.patching_rect[3] == pytest.approx(25.0)


class TestPatcherStyling:
    """Tests for canvas background and object bgcolor helpers."""

    def test_canvas_background(self):
        """set_canvas_background sets editing_bgcolor and locked_bgcolor."""
        p = Patcher()
        set_canvas_background(p)
        assert p.props["editing_bgcolor"] == list(AESTHETIC_PALETTE["canvas_bg"])
        assert p.props["locked_bgcolor"] == list(AESTHETIC_PALETTE["canvas_bg"])

    def test_canvas_background_custom(self):
        """set_canvas_background with custom color uses that color."""
        p = Patcher()
        custom = [0.5, 0.5, 0.5, 1.0]
        set_canvas_background(p, custom)
        assert p.props["editing_bgcolor"] == custom
        assert p.props["locked_bgcolor"] == custom

    def test_object_bgcolor(self):
        """set_object_bgcolor with palette_key uses AESTHETIC_PALETTE value."""
        p = Patcher()
        box = p.add_comment("test", 0.0, 0.0)
        set_object_bgcolor(box, palette_key="emphasis_loadbang")
        assert box.extra_attrs["bgcolor"] == list(
            AESTHETIC_PALETTE["emphasis_loadbang"]
        )

    def test_object_bgcolor_custom(self):
        """set_object_bgcolor with custom color uses the RGBA list."""
        p = Patcher()
        box = p.add_comment("test", 0.0, 0.0)
        custom = [0.9, 0.8, 0.7, 1.0]
        set_object_bgcolor(box, color=custom)
        assert box.extra_attrs["bgcolor"] == custom

    def test_object_bgcolor_requires_argument(self):
        """set_object_bgcolor raises ValueError without palette_key or color."""
        p = Patcher()
        box = p.add_comment("test", 0.0, 0.0)
        with pytest.raises(ValueError):
            set_object_bgcolor(box)
