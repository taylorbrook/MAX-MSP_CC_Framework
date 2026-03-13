"""Tests for aesthetic styling: palette, comment tiers, bubble comments, patcher styling,
panels, step markers, auto-sizing, and patch complexity heuristic.

Covers CMNT-01..04, PANL-01..05, PTCH-01, PTCH-02 requirements from phase 10.
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
from src.maxpat.patcher import Box, Patcher
from src.maxpat.aesthetics import (
    auto_size_panel,
    is_complex_patch,
    set_canvas_background,
    set_object_bgcolor,
)


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


# ---------------------------------------------------------------------------
# Plan 02 tests: Panels, Auto-Sizing, Step Markers, Complexity
# ---------------------------------------------------------------------------

def _make_box_at(x: float, y: float, w: float = 80.0, h: float = 22.0) -> Box:
    """Helper: create a minimal Box at a known position (bypasses DB)."""
    b = Box.__new__(Box)
    b.name = "comment"
    b.args = []
    b.id = "obj-test"
    b.maxclass = "comment"
    b.text = ""
    b.numinlets = 1
    b.numoutlets = 0
    b.outlettype = []
    b.patching_rect = [x, y, w, h]
    b.fontname = "Arial"
    b.fontsize = 12.0
    b.presentation = False
    b.presentation_rect = None
    b.extra_attrs = {}
    b._inner_patcher = None
    b._saved_object_attributes = None
    b._bpatcher_attrs = None
    return b


class TestPanels:
    """Tests for Patcher.add_panel() -- gradient and solid fill panels."""

    def test_panel_attributes(self):
        """add_panel creates Box with maxclass='panel' and correct rect."""
        p = Patcher()
        panel = p.add_panel(50, 50, 300, 200)
        assert panel.maxclass == "panel"
        assert panel.numinlets == 1
        assert panel.numoutlets == 0
        assert panel.outlettype == []
        assert panel.patching_rect == [50, 50, 300, 200]

    def test_panel_background_layer(self):
        """Panel has background=1 and ignoreclick=1."""
        p = Patcher()
        panel = p.add_panel(0, 0, 100, 100)
        assert panel.extra_attrs["background"] == 1
        assert panel.extra_attrs["ignoreclick"] == 1

    def test_panel_borderless(self):
        """Panel has border=0."""
        p = Patcher()
        panel = p.add_panel(0, 0, 100, 100)
        assert panel.extra_attrs["border"] == 0

    def test_panel_rounded(self):
        """Panel has rounded value in range 6-8 (default 7)."""
        p = Patcher()
        panel = p.add_panel(0, 0, 100, 100)
        assert 6 <= panel.extra_attrs["rounded"] <= 8

    def test_panel_mode(self):
        """Panel has mode=0 (solid/bgfillcolor mode)."""
        p = Patcher()
        panel = p.add_panel(0, 0, 100, 100)
        assert panel.extra_attrs["mode"] == 0

    def test_gradient_fill(self):
        """Default panel has bgfillcolor gradient dict with correct structure."""
        p = Patcher()
        panel = p.add_panel(0, 0, 100, 100)
        bg = panel.extra_attrs["bgfillcolor"]
        assert bg["type"] == "gradient"
        assert bg["color1"] == list(AESTHETIC_PALETTE["panel_fill"])
        assert bg["color2"] == list(AESTHETIC_PALETTE["panel_gradient_end"])
        assert bg["color"] == list(AESTHETIC_PALETTE["panel_fill"])
        assert bg["angle"] == 270.0
        assert bg["proportion"] == pytest.approx(0.39)
        assert bg["autogradient"] == 0

    def test_gradient_proportion_capped(self):
        """Proportion value in bgfillcolor is below 1.0."""
        p = Patcher()
        panel = p.add_panel(0, 0, 100, 100)
        assert panel.extra_attrs["bgfillcolor"]["proportion"] < 1.0

    def test_solid_fill(self):
        """add_panel(gradient=False) has bgcolor and NO bgfillcolor."""
        p = Patcher()
        panel = p.add_panel(0, 0, 100, 100, gradient=False)
        assert panel.extra_attrs["bgcolor"] == list(AESTHETIC_PALETTE["panel_fill"])
        assert "bgfillcolor" not in panel.extra_attrs

    def test_panel_z_order(self):
        """After adding boxes then a panel, panel is at index 0."""
        p = Patcher()
        p.add_box("cycle~", ["440"])
        p.add_box("dac~")
        p.add_panel(0, 0, 400, 300)
        assert p.boxes[0].maxclass == "panel"

    def test_panel_z_order_multiple(self):
        """Adding 2 panels: second panel at index 0, first panel at index 1."""
        p = Patcher()
        first = p.add_panel(0, 0, 100, 100)
        second = p.add_panel(10, 10, 200, 200)
        assert p.boxes[0] is second
        assert p.boxes[1] is first

    def test_panel_serialization(self):
        """panel.to_dict()['box'] has maxclass='panel' and bgfillcolor dict."""
        p = Patcher()
        panel = p.add_panel(50, 50, 300, 200)
        d = panel.to_dict()["box"]
        assert d["maxclass"] == "panel"
        assert "bgfillcolor" in d
        assert d["bgfillcolor"]["type"] == "gradient"
        assert d["background"] == 1
        assert d["border"] == 0

    def test_panel_has_all_box_fields(self):
        """Panel Box has all 16 fields set (no AttributeError on to_dict)."""
        p = Patcher()
        panel = p.add_panel(0, 0, 100, 100)
        # Access all 16 fields -- should not raise
        _ = panel.name
        _ = panel.args
        _ = panel.id
        _ = panel.maxclass
        _ = panel.text
        _ = panel.numinlets
        _ = panel.numoutlets
        _ = panel.outlettype
        _ = panel.patching_rect
        _ = panel.fontname
        _ = panel.fontsize
        _ = panel.presentation
        _ = panel.presentation_rect
        _ = panel._inner_patcher
        _ = panel._saved_object_attributes
        _ = panel._bpatcher_attrs
        # to_dict should work without error
        d = panel.to_dict()
        assert "box" in d


class TestAutoSize:
    """Tests for auto_size_panel() bounding box helper."""

    def test_auto_size_basic(self):
        """auto_size_panel computes bounding box with padding around two boxes."""
        box1 = _make_box_at(100, 50, 80, 22)
        box2 = _make_box_at(200, 100, 80, 22)
        x, y, w, h = auto_size_panel([box1, box2], padding=20)
        assert x == pytest.approx(80)   # 100 - 20
        assert y == pytest.approx(30)   # 50 - 20
        # width covers 100..280 (200+80) + 2*20 padding
        assert w == pytest.approx(220)  # (280-100) + 40
        # height covers 50..122 (100+22) + 2*20 padding
        assert h == pytest.approx(112)  # (122-50) + 40

    def test_auto_size_padding(self):
        """Different padding values produce different coordinates."""
        box1 = _make_box_at(100, 50, 80, 22)
        _, _, w15, h15 = auto_size_panel([box1], padding=15)
        _, _, w20, h20 = auto_size_panel([box1], padding=20)
        assert w15 != w20
        assert h15 != h20

    def test_auto_size_single_box(self):
        """auto_size_panel with one box returns box rect + padding on all sides."""
        box = _make_box_at(100, 50, 80, 22)
        x, y, w, h = auto_size_panel([box], padding=20)
        assert x == pytest.approx(80)    # 100 - 20
        assert y == pytest.approx(30)    # 50 - 20
        assert w == pytest.approx(120)   # 80 + 2*20
        assert h == pytest.approx(62)    # 22 + 2*20

    def test_auto_size_empty(self):
        """auto_size_panel with empty list returns (0, 0, 0, 0)."""
        result = auto_size_panel([])
        assert result == (0.0, 0.0, 0.0, 0.0)


class TestStepMarkers:
    """Tests for Patcher.add_step_marker() -- numbered textbutton circles."""

    def test_marker_attributes(self):
        """add_step_marker creates Box with maxclass='textbutton' and 24x24 size."""
        p = Patcher()
        m = p.add_step_marker(1, 50, 50)
        assert m.maxclass == "textbutton"
        assert m.patching_rect == [50, 50, 24.0, 24.0]

    def test_marker_circle(self):
        """Marker has rounded=60.0 to make it circular."""
        p = Patcher()
        m = p.add_step_marker(1, 0, 0)
        assert m.extra_attrs["rounded"] == 60.0

    def test_marker_colors(self):
        """Marker has amber bg and white text colors."""
        p = Patcher()
        m = p.add_step_marker(1, 0, 0)
        assert m.extra_attrs["bgcolor"] == list(AESTHETIC_PALETTE["step_marker_bg"])
        assert m.extra_attrs["textcolor"] == list(AESTHETIC_PALETTE["step_marker_text"])

    def test_marker_text(self):
        """add_step_marker(3, ...) has text='3'."""
        p = Patcher()
        m = p.add_step_marker(3, 0, 0)
        assert m.extra_attrs["text"] == "3"

    def test_marker_background_layer(self):
        """Marker has background=1 and ignoreclick=1."""
        p = Patcher()
        m = p.add_step_marker(1, 0, 0)
        assert m.extra_attrs["background"] == 1
        assert m.extra_attrs["ignoreclick"] == 1

    def test_marker_z_order(self):
        """Marker is inserted at index 0 in patcher.boxes."""
        p = Patcher()
        p.add_box("cycle~", ["440"])
        p.add_step_marker(1, 0, 0)
        assert p.boxes[0].maxclass == "textbutton"

    def test_marker_no_parameter(self):
        """Marker has parameter_enable=0."""
        p = Patcher()
        m = p.add_step_marker(1, 0, 0)
        assert m.extra_attrs["parameter_enable"] == 0

    def test_marker_bold(self):
        """Marker has fontface=1 (bold)."""
        p = Patcher()
        m = p.add_step_marker(1, 0, 0)
        assert m.extra_attrs["fontface"] == FONTFACE_BOLD

    def test_marker_serialization(self):
        """Marker to_dict() has correct maxclass and all extra_attrs merged."""
        p = Patcher()
        m = p.add_step_marker(5, 10, 20)
        d = m.to_dict()["box"]
        assert d["maxclass"] == "textbutton"
        assert d["text"] == "5"
        assert d["bgcolor"] == list(AESTHETIC_PALETTE["step_marker_bg"])
        assert d["rounded"] == 60.0
        assert d["background"] == 1

    def test_marker_has_all_box_fields(self):
        """Marker Box has all 16 fields set (no AttributeError on to_dict)."""
        p = Patcher()
        m = p.add_step_marker(1, 0, 0)
        _ = m.name
        _ = m.args
        _ = m.id
        _ = m.maxclass
        _ = m.text
        _ = m.numinlets
        _ = m.numoutlets
        _ = m.outlettype
        _ = m.patching_rect
        _ = m.fontname
        _ = m.fontsize
        _ = m.presentation
        _ = m.presentation_rect
        _ = m._inner_patcher
        _ = m._saved_object_attributes
        _ = m._bpatcher_attrs
        d = m.to_dict()
        assert "box" in d


class TestComplexity:
    """Tests for is_complex_patch() heuristic."""

    def test_simple_patch(self):
        """Patcher with 3 boxes is NOT complex."""
        p = Patcher()
        for _ in range(3):
            p.add_box("toggle")
        assert is_complex_patch(p) is False

    def test_complex_by_object_count(self):
        """Patcher with 15 boxes IS complex."""
        p = Patcher()
        for _ in range(15):
            p.add_box("toggle")
        assert is_complex_patch(p) is True

    def test_complex_by_subpatcher(self):
        """Patcher with a subpatcher IS complex regardless of box count."""
        p = Patcher()
        p.add_box("toggle")
        p.add_subpatcher("mysub")
        assert is_complex_patch(p) is True
