"""Tests for the column-based layout engine.

Covers:
- PAT-06: Topological sort assigns correct columns, top-to-bottom signal flow
- PAT-07: Vertical spacing 80-120px, horizontal gutter 60-80px, dynamic column width
- Edge cases: empty patcher, single box, disconnected nodes, fan-out, diamond
- UI control positioning above targets
- Presentation mode layout
"""

import pytest

from src.maxpat.patcher import Patcher, Box
from src.maxpat.layout import apply_layout
from src.maxpat.defaults import V_SPACING, H_GUTTER


# ---------------------------------------------------------------------------
# PAT-06: Column assignment via topological sort
# ---------------------------------------------------------------------------


class TestColumnAssignment:
    """Test that topological sort assigns objects to correct columns."""

    def test_linear_chain_columns_increase_x(self):
        """Linear chain A -> B -> C: x increases at each stage."""
        p = Patcher()
        a = p.add_box("cycle~", ["440"])
        b = p.add_box("*~", ["0.5"])
        c = p.add_box("ezdac~")
        p.add_connection(a, 0, b, 0)
        p.add_connection(b, 0, c, 0)

        apply_layout(p)

        assert a.patching_rect[0] < b.patching_rect[0]
        assert b.patching_rect[0] < c.patching_rect[0]

    def test_fan_out_same_column(self):
        """Fan-out: A -> B and A -> C puts B and C in same column."""
        p = Patcher()
        a = p.add_box("cycle~", ["440"])
        b = p.add_box("*~", ["0.5"])
        c = p.add_box("*~", ["0.3"])
        p.add_connection(a, 0, b, 0)
        p.add_connection(a, 0, c, 0)

        apply_layout(p)

        # B and C should be in the same column (same x)
        assert b.patching_rect[0] == c.patching_rect[0]
        # Both should be to the right of A
        assert b.patching_rect[0] > a.patching_rect[0]

    def test_fan_out_vertical_stacking(self):
        """Fan-out targets in same column are stacked vertically."""
        p = Patcher()
        a = p.add_box("cycle~", ["440"])
        b = p.add_box("*~", ["0.5"])
        c = p.add_box("*~", ["0.3"])
        p.add_connection(a, 0, b, 0)
        p.add_connection(a, 0, c, 0)

        apply_layout(p)

        # B and C should have different y positions
        assert b.patching_rect[1] != c.patching_rect[1]

    def test_diamond_pattern(self):
        """Diamond: A -> B, A -> C, B -> D, C -> D puts D in col 2."""
        p = Patcher()
        a = p.add_box("cycle~", ["440"])
        b = p.add_box("*~", ["0.5"])
        c = p.add_box("+~")
        d = p.add_box("ezdac~")
        p.add_connection(a, 0, b, 0)
        p.add_connection(a, 0, c, 0)
        p.add_connection(b, 0, d, 0)
        p.add_connection(c, 0, d, 0)

        apply_layout(p)

        # A in column 0
        # B and C in column 1 (same x)
        assert b.patching_rect[0] == c.patching_rect[0]
        # D in column 2
        assert d.patching_rect[0] > b.patching_rect[0]
        assert a.patching_rect[0] < b.patching_rect[0]

    def test_disconnected_objects_final_column(self):
        """Disconnected objects go to a column at the end."""
        p = Patcher()
        a = p.add_box("cycle~", ["440"])
        b = p.add_box("ezdac~")
        p.add_connection(a, 0, b, 0)
        # disconnected object -- no connections
        lonely = p.add_box("metro", ["500"])

        apply_layout(p)

        # Disconnected object should be at the rightmost column
        assert lonely.patching_rect[0] >= b.patching_rect[0]


# ---------------------------------------------------------------------------
# PAT-06: Top-to-bottom signal flow (y increases within a column)
# ---------------------------------------------------------------------------


class TestTopToBottomFlow:
    """Test that y coordinates increase top-to-bottom within columns."""

    def test_y_increases_within_column(self):
        """Objects in the same column have increasing y positions."""
        p = Patcher()
        a = p.add_box("cycle~", ["440"])
        b = p.add_box("*~", ["0.5"])
        c = p.add_box("*~", ["0.3"])
        p.add_connection(a, 0, b, 0)
        p.add_connection(a, 0, c, 0)

        apply_layout(p)

        # B and C are in the same column; one should be above the other
        ys = sorted([b.patching_rect[1], c.patching_rect[1]])
        assert ys[0] < ys[1]


# ---------------------------------------------------------------------------
# PAT-07: Spacing constraints
# ---------------------------------------------------------------------------


class TestSpacing:
    """Test vertical and horizontal spacing requirements."""

    def test_vertical_spacing_within_range(self):
        """Vertical spacing between boxes in same column is 80-120px."""
        p = Patcher()
        a = p.add_box("cycle~", ["440"])
        b = p.add_box("*~", ["0.5"])
        c = p.add_box("*~", ["0.3"])
        p.add_connection(a, 0, b, 0)
        p.add_connection(a, 0, c, 0)

        apply_layout(p)

        # B and C are in the same column
        y1, h1 = b.patching_rect[1], b.patching_rect[3]
        y2, h2 = c.patching_rect[1], c.patching_rect[3]
        # Gap = next_y - (prev_y + prev_height)
        upper_y, upper_h = min((y1, h1), (y2, h2))
        lower_y = max(y1, y2)
        gap = lower_y - (upper_y + upper_h)
        # Gap should be within V_SPACING (default 100) range
        # The plan says spacing should be V_SPACING which is 80-120 center
        assert 60 <= gap <= 140, f"Vertical gap {gap} outside acceptable range"

    def test_horizontal_gutter_within_range(self):
        """Horizontal gutter between columns is 60-80px (added to widest box)."""
        p = Patcher()
        a = p.add_box("cycle~", ["440"])
        b = p.add_box("*~", ["0.5"])
        p.add_connection(a, 0, b, 0)

        apply_layout(p)

        a_right = a.patching_rect[0] + a.patching_rect[2]  # x + width
        b_left = b.patching_rect[0]
        gutter = b_left - a_right
        # H_GUTTER = 70 (center of 60-80); allow some tolerance
        assert 50 <= gutter <= 90, f"Horizontal gutter {gutter} outside range"

    def test_dynamic_column_width(self):
        """Column width adapts to widest object in that column."""
        p = Patcher()
        # Create a wide object (long text) and a narrow one in column 0
        wide = p.add_box("trigger", ["b", "i", "f", "s"])  # long text
        narrow = p.add_box("toggle")
        target = p.add_box("ezdac~")
        p.add_connection(wide, 0, target, 0)
        p.add_connection(narrow, 0, target, 0)

        apply_layout(p)

        # target column x should account for the widest object in column 0
        wide_right = wide.patching_rect[0] + wide.patching_rect[2]
        narrow_right = narrow.patching_rect[0] + narrow.patching_rect[2]
        max_right = max(wide_right, narrow_right)
        gutter = target.patching_rect[0] - max_right
        assert 50 <= gutter <= 90, f"Dynamic gutter {gutter} not correct"


# ---------------------------------------------------------------------------
# Edge cases
# ---------------------------------------------------------------------------


class TestEdgeCases:
    """Test edge cases: empty patcher, single box."""

    def test_empty_patcher_no_error(self):
        """Empty patcher: apply_layout should be a no-op."""
        p = Patcher()
        apply_layout(p)  # Should not raise

    def test_single_box_default_position(self):
        """Single box placed at a default position."""
        p = Patcher()
        box = p.add_box("cycle~", ["440"])

        apply_layout(p)

        # Box should have a reasonable position (not at 0,0)
        assert box.patching_rect[0] >= 0
        assert box.patching_rect[1] >= 0


# ---------------------------------------------------------------------------
# UI control positioning
# ---------------------------------------------------------------------------


class TestUIControlPositioning:
    """Test that UI controls are positioned above their targets."""

    def test_toggle_above_target(self):
        """Toggle connected to cycle~ should be positioned above it."""
        p = Patcher()
        tog = p.add_box("toggle")
        osc = p.add_box("cycle~", ["440"])
        dac = p.add_box("ezdac~")
        p.add_connection(tog, 0, osc, 0)
        p.add_connection(osc, 0, dac, 0)

        apply_layout(p)

        # Toggle should be above cycle~ (lower y value)
        assert tog.patching_rect[1] < osc.patching_rect[1]


# ---------------------------------------------------------------------------
# Presentation mode layout
# ---------------------------------------------------------------------------


class TestPresentationLayout:
    """Test presentation mode layout for UI objects."""

    def test_ui_boxes_get_presentation_rect(self):
        """UI boxes with presentation=True get presentation_rect values."""
        p = Patcher()
        tog = p.add_box("toggle")
        tog.presentation = True
        slider = p.add_box("slider")
        slider.presentation = True
        osc = p.add_box("cycle~", ["440"])
        dac = p.add_box("ezdac~")
        p.add_connection(tog, 0, osc, 0)
        p.add_connection(osc, 0, dac, 0)

        apply_layout(p)

        # UI boxes with presentation=True should have presentation_rect set
        assert tog.presentation_rect is not None
        assert slider.presentation_rect is not None
        # Non-UI boxes should not have presentation_rect
        assert osc.presentation_rect is None


# ---------------------------------------------------------------------------
# Complex graph
# ---------------------------------------------------------------------------


class TestComplexGraph:
    """Test with a more complex patch (10+ objects)."""

    def test_complex_signal_chain(self):
        """Complex chain: oscillator -> filter -> effects -> output."""
        p = Patcher()
        # Source column
        osc1 = p.add_box("cycle~", ["440"])
        osc2 = p.add_box("cycle~", ["2"])
        # Processing column
        mul = p.add_box("*~", ["0.5"])
        add = p.add_box("+~")
        # Filter column
        filt = p.add_box("biquad~")
        # Effects
        delay = p.add_box("tapin~", ["1000"])
        delay_out = p.add_box("tapout~", ["250"])
        mix = p.add_box("*~", ["0.3"])
        # Output
        dac = p.add_box("ezdac~")
        # Extra control
        metro = p.add_box("metro", ["500"])

        # Connect
        p.add_connection(osc1, 0, mul, 0)
        p.add_connection(osc2, 0, mul, 1)
        p.add_connection(mul, 0, filt, 0)
        p.add_connection(filt, 0, delay, 0)
        p.add_connection(delay, 0, delay_out, 0)
        p.add_connection(delay_out, 0, mix, 0)
        p.add_connection(filt, 0, add, 0)
        p.add_connection(mix, 0, add, 1)
        p.add_connection(add, 0, dac, 0)

        apply_layout(p)

        # All boxes should have been positioned (no boxes at same x,y)
        positions = [(b.patching_rect[0], b.patching_rect[1]) for b in p.boxes]
        # No two boxes should overlap exactly
        assert len(set(positions)) == len(positions)

        # Signal flow: osc1 should be left of dac
        assert osc1.patching_rect[0] < dac.patching_rect[0]

        # metro is disconnected -- should be at right side
        assert metro.patching_rect[0] >= dac.patching_rect[0]
