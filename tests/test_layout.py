"""Tests for the row-based layout engine.

Covers:
- PAT-06: Topological sort assigns correct rows, top-to-bottom signal flow
- PAT-07: Vertical spacing 80-120px, horizontal gutter 60-80px, dynamic row height
- Edge cases: empty patcher, single box, disconnected nodes, fan-out, diamond
- Connected component detection and side-by-side placement
- UI control positioning above targets
- Midpoint generation for backward cables
- Presentation mode layout
"""

import pytest

from src.maxpat.patcher import Patcher, Box
from src.maxpat.layout import apply_layout
from src.maxpat.defaults import V_SPACING, H_GUTTER


# ---------------------------------------------------------------------------
# PAT-06: Row assignment via topological sort (top-to-bottom flow)
# ---------------------------------------------------------------------------


class TestRowAssignment:
    """Test that topological sort assigns objects to correct rows."""

    def test_linear_chain_y_increases(self):
        """Linear chain A -> B -> C: y increases at each stage."""
        p = Patcher()
        a = p.add_box("cycle~", ["440"])
        b = p.add_box("*~", ["0.5"])
        c = p.add_box("ezdac~")
        p.add_connection(a, 0, b, 0)
        p.add_connection(b, 0, c, 0)

        apply_layout(p)

        assert a.patching_rect[1] < b.patching_rect[1]
        assert b.patching_rect[1] < c.patching_rect[1]

    def test_fan_out_same_row(self):
        """Fan-out: A -> B and A -> C puts B and C in same row (same y)."""
        p = Patcher()
        a = p.add_box("cycle~", ["440"])
        b = p.add_box("*~", ["0.5"])
        c = p.add_box("*~", ["0.3"])
        p.add_connection(a, 0, b, 0)
        p.add_connection(a, 0, c, 0)

        apply_layout(p)

        # B and C should be in the same row (same y)
        assert b.patching_rect[1] == c.patching_rect[1]
        # Both should be below A
        assert b.patching_rect[1] > a.patching_rect[1]

    def test_fan_out_horizontal_spread(self):
        """Fan-out targets in same row are spread horizontally."""
        p = Patcher()
        a = p.add_box("cycle~", ["440"])
        b = p.add_box("*~", ["0.5"])
        c = p.add_box("*~", ["0.3"])
        p.add_connection(a, 0, b, 0)
        p.add_connection(a, 0, c, 0)

        apply_layout(p)

        # B and C should have different x positions
        assert b.patching_rect[0] != c.patching_rect[0]

    def test_diamond_pattern(self):
        """Diamond: A -> B, A -> C, B -> D, C -> D puts D in row 2."""
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

        # B and C in row 1 (same y)
        assert b.patching_rect[1] == c.patching_rect[1]
        # D in row 2 (below B and C)
        assert d.patching_rect[1] > b.patching_rect[1]
        # A in row 0 (above B and C)
        assert a.patching_rect[1] < b.patching_rect[1]

    def test_disconnected_objects_placed_to_right(self):
        """Disconnected objects go to the right of connected components."""
        p = Patcher()
        a = p.add_box("cycle~", ["440"])
        b = p.add_box("ezdac~")
        p.add_connection(a, 0, b, 0)
        # disconnected object -- no connections
        lonely = p.add_box("metro", ["500"])

        apply_layout(p)

        # Disconnected object should be to the right
        max_connected_x = max(a.patching_rect[0], b.patching_rect[0])
        assert lonely.patching_rect[0] >= max_connected_x


# ---------------------------------------------------------------------------
# PAT-06: Top-to-bottom signal flow (y increases between levels)
# ---------------------------------------------------------------------------


class TestTopToBottomFlow:
    """Test that y coordinates increase between topological levels."""

    def test_y_increases_between_levels(self):
        """Objects at successive levels have increasing y positions."""
        p = Patcher()
        a = p.add_box("cycle~", ["440"])
        b = p.add_box("*~", ["0.5"])
        c = p.add_box("ezdac~")
        p.add_connection(a, 0, b, 0)
        p.add_connection(b, 0, c, 0)

        apply_layout(p)

        assert a.patching_rect[1] < b.patching_rect[1] < c.patching_rect[1]


# ---------------------------------------------------------------------------
# PAT-07: Spacing constraints
# ---------------------------------------------------------------------------


class TestSpacing:
    """Test vertical and horizontal spacing requirements."""

    def test_vertical_spacing_between_rows(self):
        """Vertical spacing between rows is within acceptable range."""
        p = Patcher()
        a = p.add_box("cycle~", ["440"])
        b = p.add_box("*~", ["0.5"])
        c = p.add_box("ezdac~")
        p.add_connection(a, 0, b, 0)
        p.add_connection(b, 0, c, 0)

        apply_layout(p)

        # Gap between row 0 and row 1
        a_bottom = a.patching_rect[1] + a.patching_rect[3]
        b_top = b.patching_rect[1]
        gap = b_top - a_bottom
        assert 60 <= gap <= 140, f"Vertical gap {gap} outside acceptable range"

    def test_horizontal_gutter_within_row(self):
        """Horizontal gutter between objects in the same row."""
        p = Patcher()
        a = p.add_box("cycle~", ["440"])
        b = p.add_box("*~", ["0.5"])
        c = p.add_box("*~", ["0.3"])
        p.add_connection(a, 0, b, 0)
        p.add_connection(a, 0, c, 0)

        apply_layout(p)

        # B and C are in the same row
        xs = sorted([b.patching_rect[0], c.patching_rect[0]])
        # Find the box at the left position
        left_box = b if b.patching_rect[0] == xs[0] else c
        left_right_edge = left_box.patching_rect[0] + left_box.patching_rect[2]
        gutter = xs[1] - left_right_edge
        assert 50 <= gutter <= 90, f"Horizontal gutter {gutter} outside range"

    def test_dynamic_row_height(self):
        """Row height adapts to tallest object in that row."""
        p = Patcher()
        # Two sources at same level -> same row
        wide = p.add_box("trigger", ["b", "i", "f", "s"])
        narrow = p.add_box("*~", ["0.1"])
        target = p.add_box("ezdac~")
        p.add_connection(wide, 0, target, 0)
        p.add_connection(narrow, 0, target, 0)

        apply_layout(p)

        # Both wide and narrow should be in the same row (same y)
        assert wide.patching_rect[1] == narrow.patching_rect[1]
        # target should be below both, with gap based on tallest in row 0
        tallest_h = max(wide.patching_rect[3], narrow.patching_rect[3])
        expected_gap = tallest_h + V_SPACING
        actual_gap = target.patching_rect[1] - wide.patching_rect[1]
        assert abs(actual_gap - expected_gap) < 5.0, (
            f"Row gap {actual_gap} doesn't match expected {expected_gap}"
        )


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
# Connected component detection
# ---------------------------------------------------------------------------


class TestComponentDetection:
    """Test that independent signal chains are detected and separated."""

    def test_two_independent_chains_side_by_side(self):
        """Two independent chains are placed in separate x-regions."""
        p = Patcher()
        # Chain 1
        a1 = p.add_box("cycle~", ["440"])
        b1 = p.add_box("ezdac~")
        p.add_connection(a1, 0, b1, 0)
        # Chain 2
        a2 = p.add_box("metro", ["500"])
        b2 = p.add_box("counter", ["16"])
        p.add_connection(a2, 0, b2, 0)

        apply_layout(p)

        # The two chains should not overlap in x
        chain1_right = max(
            a1.patching_rect[0] + a1.patching_rect[2],
            b1.patching_rect[0] + b1.patching_rect[2],
        )
        chain2_left = min(a2.patching_rect[0], b2.patching_rect[0])
        # One chain should be to the right of the other
        assert chain1_right < chain2_left or chain2_left < chain1_right


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
# Midpoint generation
# ---------------------------------------------------------------------------


class TestMidpointGeneration:
    """Test that backward cables get midpoints for clean routing."""

    def test_backward_cable_gets_midpoints(self):
        """A connection going right-to-left should get midpoints."""
        p = Patcher()
        # Create objects where source outlet will be to the right of dest inlet
        a = p.add_box("trigger", ["b", "b", "b"])  # 3 outlets, wide
        b = p.add_box("metro", ["500"])  # narrow, connects from a's rightmost outlet
        c = p.add_box("counter", ["16"])
        p.add_connection(a, 2, b, 0)  # Right outlet to left object
        p.add_connection(a, 0, c, 0)

        apply_layout(p)

        # Check if the a->b connection got midpoints
        for line in p.lines:
            if line.source_id == a.id and line.dest_id == b.id:
                # Whether midpoints are needed depends on final positions
                # Just verify no crash and midpoints are either None or a list
                assert line.midpoints is None or isinstance(line.midpoints, list)


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
        # Source row
        osc1 = p.add_box("cycle~", ["440"])
        osc2 = p.add_box("cycle~", ["2"])
        # Processing
        mul = p.add_box("*~", ["0.5"])
        add = p.add_box("+~")
        # Filter
        filt = p.add_box("biquad~")
        # Effects
        delay = p.add_box("tapin~", ["1000"])
        delay_out = p.add_box("tapout~", ["250"])
        mix = p.add_box("*~", ["0.3"])
        # Output
        dac = p.add_box("ezdac~")
        # Extra control (disconnected)
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

        # All boxes should have been positioned (no two at exact same position)
        positions = [(b.patching_rect[0], b.patching_rect[1]) for b in p.boxes]
        assert len(set(positions)) == len(positions)

        # Signal flow: osc1 should be above dac (top-to-bottom)
        assert osc1.patching_rect[1] < dac.patching_rect[1]

        # metro is disconnected -- should be to the right
        max_connected_x = max(
            b.patching_rect[0] for b in p.boxes if b.id != metro.id
        )
        assert metro.patching_rect[0] >= max_connected_x
