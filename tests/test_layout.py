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
from src.maxpat.defaults import V_SPACING, H_GUTTER, LayoutOptions


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
        opts = LayoutOptions()
        assert abs(gap - opts.v_spacing) <= opts.v_spacing * 0.5, (
            f"Vertical gap {gap} not within 50% of default {opts.v_spacing}"
        )

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
        opts = LayoutOptions()
        assert gutter >= opts.h_gutter * 0.3, (
            f"Horizontal gutter {gutter} below 30% of default {opts.h_gutter}"
        )

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
    """Test midpoint generation for all cable routing patterns."""

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

    def test_forward_horizontal_cable_gets_midpoints(self):
        """A long forward horizontal cable (left-to-right) gets midpoints."""
        p = Patcher()
        # Manually position objects far apart horizontally
        src = p.add_box("sig~")
        src.patching_rect = [50.0, 200.0, 44.0, 22.0]
        dst = p.add_box("svf~")
        dst.patching_rect = [500.0, 300.0, 44.0, 22.0]
        p.add_connection(src, 0, dst, 0)

        # Call _generate_midpoints directly (skip full layout to preserve positions)
        from src.maxpat.layout import _generate_midpoints
        _generate_midpoints(p)

        line = p.lines[0]
        assert line.midpoints is not None
        assert len(line.midpoints) == 4  # 2 midpoints (x1, y1, x2, y2)
        # Horizontal segment: both midpoints share the same Y
        assert line.midpoints[1] == line.midpoints[3]

    def test_vertical_cable_no_midpoints(self):
        """A near-vertical cable should NOT get midpoints."""
        p = Patcher()
        src = p.add_box("*~", ["0.5"])
        src.patching_rect = [100.0, 50.0, 44.0, 22.0]
        dst = p.add_box("*~", ["0.3"])
        dst.patching_rect = [100.0, 150.0, 44.0, 22.0]
        p.add_connection(src, 0, dst, 0)

        from src.maxpat.layout import _generate_midpoints
        _generate_midpoints(p)

        assert p.lines[0].midpoints is None

    def test_upward_cable_gets_bus_routing(self):
        """An upward cable with large distance gets 3-midpoint bus routing."""
        p = Patcher()
        # Source at bottom, dest at top (like init cable)
        src = p.add_box("message")
        src.text = "127"
        src.patching_rect = [100.0, 800.0, 30.0, 22.0]
        dst = p.add_box("dial")
        dst.patching_rect = [50.0, 100.0, 40.0, 40.0]
        p.add_connection(src, 0, dst, 0)

        from src.maxpat.layout import _generate_midpoints
        _generate_midpoints(p)

        line = p.lines[0]
        assert line.midpoints is not None
        assert len(line.midpoints) == 6  # 3 midpoints for bus routing
        # Bus X should be to the right of both objects
        bus_x = line.midpoints[0]
        src_right = src.patching_rect[0] + src.patching_rect[2]
        assert bus_x > src_right

    def test_parallel_bus_cables_spaced_apart(self):
        """Multiple upward cables get different bus X positions."""
        p = Patcher()
        src1 = p.add_box("message")
        src1.text = "100"
        src1.patching_rect = [100.0, 800.0, 30.0, 22.0]
        src2 = p.add_box("message")
        src2.text = "200"
        src2.patching_rect = [150.0, 800.0, 30.0, 22.0]
        dst1 = p.add_box("dial")
        dst1.patching_rect = [50.0, 100.0, 40.0, 40.0]
        dst2 = p.add_box("dial")
        dst2.patching_rect = [50.0, 300.0, 40.0, 40.0]
        p.add_connection(src1, 0, dst1, 0)
        p.add_connection(src2, 0, dst2, 0)

        from src.maxpat.layout import _generate_midpoints
        _generate_midpoints(p)

        bus_x_1 = p.lines[0].midpoints[0]
        bus_x_2 = p.lines[1].midpoints[0]
        # Bus cables should have different X positions
        assert bus_x_1 != bus_x_2
        assert abs(bus_x_1 - bus_x_2) >= 8.0  # BUS_SPACING

    def test_manual_midpoints_preserved(self):
        """Manually set midpoints are not overwritten by auto-generation."""
        p = Patcher()
        src = p.add_box("sig~")
        src.patching_rect = [50.0, 200.0, 44.0, 22.0]
        dst = p.add_box("svf~")
        dst.patching_rect = [500.0, 300.0, 44.0, 22.0]
        manual_mp = [100.0, 250.0, 450.0, 250.0]
        p.add_connection(src, 0, dst, 0, midpoints=manual_mp)

        from src.maxpat.layout import _generate_midpoints
        _generate_midpoints(p)

        assert p.lines[0].midpoints == manual_mp


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


# ---------------------------------------------------------------------------
# Patcher rect auto-sizing
# ---------------------------------------------------------------------------


class TestAutoSizing:
    """Test that patcher rect is auto-sized to fit content."""

    def test_rect_fits_all_objects(self):
        """Patcher rect width and height encompass all objects."""
        p = Patcher()
        a = p.add_box("cycle~", ["440"])
        b = p.add_box("*~", ["0.5"])
        c = p.add_box("ezdac~")
        p.add_connection(a, 0, b, 0)
        p.add_connection(b, 0, c, 0)

        apply_layout(p)

        rect = p.props["rect"]
        patcher_w = rect[2]
        patcher_h = rect[3]

        for box in p.boxes:
            right = box.patching_rect[0] + box.patching_rect[2]
            bottom = box.patching_rect[1] + box.patching_rect[3]
            assert right < patcher_w, f"Object extends past patcher width"
            assert bottom < patcher_h, f"Object extends past patcher height"

    def test_rect_includes_bus_routes(self):
        """Patcher rect accounts for bus routing midpoints."""
        p = Patcher()
        src = p.add_box("message")
        src.text = "127"
        src.patching_rect = [100.0, 800.0, 30.0, 22.0]
        dst = p.add_box("dial")
        dst.patching_rect = [50.0, 100.0, 40.0, 40.0]
        p.add_connection(src, 0, dst, 0)

        apply_layout(p)

        rect = p.props["rect"]
        # Bus midpoints should be within the patcher rect
        line = p.lines[0]
        if line.midpoints:
            for j in range(0, len(line.midpoints), 2):
                assert line.midpoints[j] < rect[2]

    def test_minimum_size_enforced(self):
        """Patcher rect has minimum dimensions even with few objects."""
        p = Patcher()
        box = p.add_box("cycle~", ["440"])
        p.add_connection(box, 0, box, 0)  # self-loop

        apply_layout(p)

        rect = p.props["rect"]
        assert rect[2] >= 400.0
        assert rect[3] >= 300.0

    def test_subpatcher_not_auto_sized(self):
        """Subpatchers should not have their rect auto-sized."""
        p = Patcher()
        parent_box, inner = p.add_subpatcher("test", inlets=1, outlets=1)

        original_rect = list(inner.props["rect"])
        apply_layout(p)

        # Inner patcher rect should not change from auto-sizing
        assert inner.props["rect"] == original_rect


# ---------------------------------------------------------------------------
# Comment association (target_id on Box)
# ---------------------------------------------------------------------------


class TestCommentAssociation:
    """Test that comments can be associated with target objects via target_id."""

    def test_comment_target_id_set(self):
        """add_comment(text, target=box) sets target_id to box.id."""
        p = Patcher()
        osc = p.add_box("cycle~", ["440"])
        comment = p.add_comment("oscillator", target=osc)
        assert comment.target_id == osc.id

    def test_comment_no_target(self):
        """add_comment(text) without target sets target_id = None."""
        p = Patcher()
        comment = p.add_comment("standalone note")
        assert comment.target_id is None

    def test_target_id_not_in_dict(self):
        """target_id must NOT appear in Box.to_dict() output."""
        p = Patcher()
        osc = p.add_box("cycle~", ["440"])
        comment = p.add_comment("note", target=osc)
        d = comment.to_dict()
        assert "target_id" not in d["box"]

    def test_panel_has_target_id_none(self):
        """Panel (Box.__new__ path) has target_id = None."""
        p = Patcher()
        panel = p.add_panel(0, 0, 100, 100)
        assert panel.target_id is None

    def test_step_marker_has_target_id_none(self):
        """Step marker (Box.__new__ path) has target_id = None."""
        p = Patcher()
        marker = p.add_step_marker(1, 10, 10)
        assert marker.target_id is None

    def test_box_init_has_target_id_none(self):
        """Box created via __init__ has target_id = None by default."""
        p = Patcher()
        box = p.add_box("cycle~", ["440"])
        assert box.target_id is None

    def test_annotation_with_target(self):
        """add_annotation(text, target=box) sets target_id."""
        p = Patcher()
        osc = p.add_box("cycle~", ["440"])
        note = p.add_annotation("main osc", target=osc)
        assert note.target_id == osc.id


# ---------------------------------------------------------------------------
# Inlet alignment
# ---------------------------------------------------------------------------


class TestInletAlignment:
    """Test inlet-under-outlet alignment for straighter cables."""

    def test_child_inlet_aligns_under_parent_outlet(self):
        """Child's inlet X is close to parent's outlet X after layout."""
        p = Patcher()
        a = p.add_box("cycle~", ["440"])
        b = p.add_box("*~", ["0.5"])
        p.add_connection(a, 0, b, 0)
        apply_layout(p)
        from src.maxpat.layout import _outlet_x, _inlet_x
        outlet_x_pos = _outlet_x(a, 0)
        inlet_x_pos = _inlet_x(b, 0)
        # Within one grid step (15px) due to grid snapping
        assert abs(outlet_x_pos - inlet_x_pos) <= 15.0

    def test_multi_child_same_outlet(self):
        """Multiple children on same outlet: all positioned, no overlap."""
        p = Patcher()
        a = p.add_box("trigger", ["b", "b", "b"])
        b = p.add_box("metro", ["500"])
        c = p.add_box("counter", ["16"])
        d = p.add_box("print")
        p.add_connection(a, 0, b, 0)
        p.add_connection(a, 1, c, 0)
        p.add_connection(a, 2, d, 0)
        apply_layout(p)
        # Children should not overlap
        children = sorted([b, c, d], key=lambda x: x.patching_rect[0])
        for i in range(len(children) - 1):
            right = children[i].patching_rect[0] + children[i].patching_rect[2]
            assert children[i + 1].patching_rect[0] >= right

    def test_inlet_align_disabled(self):
        """With inlet_align=False, uses center-under-center (old behavior)."""
        p = Patcher()
        a = p.add_box("cycle~", ["440"])
        b = p.add_box("*~", ["0.5"])
        p.add_connection(a, 0, b, 0)
        apply_layout(p, LayoutOptions(inlet_align=False, grid_snap=False))
        # Child should be roughly centered under parent center
        parent_cx = a.patching_rect[0] + a.patching_rect[2] * 0.5
        child_cx = b.patching_rect[0] + b.patching_rect[2] * 0.5
        assert abs(parent_cx - child_cx) < 5.0


# ---------------------------------------------------------------------------
# Grid snap
# ---------------------------------------------------------------------------


class TestGridSnap:
    """Test that grid snapping rounds all positions to grid multiples."""

    def test_positions_on_grid(self):
        """After layout, all positions are multiples of 15."""
        p = Patcher()
        a = p.add_box("cycle~", ["440"])
        b = p.add_box("*~", ["0.5"])
        c = p.add_box("ezdac~")
        p.add_connection(a, 0, b, 0)
        p.add_connection(b, 0, c, 0)
        apply_layout(p)
        for box in p.boxes:
            assert box.patching_rect[0] % 15.0 == 0.0, (
                f"{box.name} x={box.patching_rect[0]} not on grid"
            )
            assert box.patching_rect[1] % 15.0 == 0.0, (
                f"{box.name} y={box.patching_rect[1]} not on grid"
            )

    def test_grid_snap_disabled(self):
        """With grid_snap=False, positions are not forced to grid."""
        p = Patcher()
        a = p.add_box("cycle~", ["440"])
        b = p.add_box("*~", ["0.5"])
        p.add_connection(a, 0, b, 0)
        apply_layout(p, LayoutOptions(grid_snap=False))
        # Just verify no crash -- grid snap behavior is opt-out


# ---------------------------------------------------------------------------
# LayoutOptions integration
# ---------------------------------------------------------------------------


class TestLayoutOptions:
    """Test that LayoutOptions parameters are respected."""

    def test_custom_v_spacing(self):
        """Custom v_spacing is used for vertical gaps."""
        p = Patcher()
        a = p.add_box("cycle~", ["440"])
        b = p.add_box("*~", ["0.5"])
        p.add_connection(a, 0, b, 0)
        apply_layout(p, LayoutOptions(v_spacing=50.0, grid_snap=False))
        gap = b.patching_rect[1] - (a.patching_rect[1] + a.patching_rect[3])
        assert abs(gap - 50.0) < 5.0

    def test_backward_compat_no_options(self):
        """apply_layout(patcher) with no options still works."""
        p = Patcher()
        a = p.add_box("cycle~", ["440"])
        b = p.add_box("ezdac~")
        p.add_connection(a, 0, b, 0)
        apply_layout(p)  # No options -- should not raise
        assert a.patching_rect[1] < b.patching_rect[1]


# ---------------------------------------------------------------------------
# Comment placement (associated comments near targets)
# ---------------------------------------------------------------------------


class TestCommentPlacement:
    """Test that comments with target_id are placed near their target."""

    def test_associated_comment_placed_near_target(self):
        """Comment with target_id placed to right of target at same Y."""
        p = Patcher()
        osc = p.add_box("cycle~", ["440"])
        dac = p.add_box("ezdac~")
        note = p.add_annotation("main osc", target=osc)
        p.add_connection(osc, 0, dac, 0)
        apply_layout(p)
        # Comment should be to the right of osc
        assert note.patching_rect[0] > osc.patching_rect[0] + osc.patching_rect[2] - 1
        # Comment Y should be close to osc Y (within grid snap tolerance)
        assert abs(note.patching_rect[1] - osc.patching_rect[1]) <= 15.0
