"""Tests for Patcher.add_overlay_readout (LAYOUT-01).

Codifies the CLAUDE.md Rule #6 overlay-readout recipe (bring_to_front +
ignoreclick=1) as a callable Patcher method. Phase 31, plan 01.

Coverage map (test → CONTEXT.md decision):
    test_returns_flonum_by_default         → D-04 default
    test_readout_at_index_zero             → D-06 unconditional bring_to_front
    test_default_ignoreclick_is_one        → D-06 default ignoreclick
    test_editable_disables_ignoreclick     → D-06 editable=True opt-out
    test_format_string_baked               → D-03 printf format on flonum
    test_offset_applied                    → D-05 fine-tune offsets
    test_default_overlaps_target_rect      → D-05 default rect copy
    test_target_rect_not_mutated           → Pitfall 1: list copy
    test_type_variants_all_z_ordered       → D-04 flonum/comment/number
    test_invalid_type_raises               → guard rail
"""

import pytest

from src.maxpat.patcher import Patcher, Box


class TestOverlayReadout:
    """Verify Patcher.add_overlay_readout codifies CLAUDE.md Rule #6 correctly."""

    def test_returns_flonum_by_default(self):
        p = Patcher()
        target = p.add_box("dial", x=10.0, y=20.0)
        readout = p.add_overlay_readout(target)
        assert readout.name == "flonum"

    def test_readout_at_index_zero(self):
        p = Patcher()
        target = p.add_box("dial", x=10.0, y=20.0)
        readout = p.add_overlay_readout(target)
        assert p.boxes[0] is readout

    def test_default_ignoreclick_is_one(self):
        p = Patcher()
        target = p.add_box("dial", x=10.0, y=20.0)
        readout = p.add_overlay_readout(target)
        assert readout.extra_attrs.get("ignoreclick") == 1

    def test_editable_disables_ignoreclick(self):
        p = Patcher()
        target = p.add_box("dial", x=10.0, y=20.0)
        readout = p.add_overlay_readout(target, editable=True)
        assert readout.extra_attrs.get("ignoreclick", 0) == 0
        assert p.boxes[0] is readout  # bring_to_front still applied

    def test_format_string_baked(self):
        p = Patcher()
        target = p.add_box("dial", x=10.0, y=20.0)
        readout = p.add_overlay_readout(target, format="%.1f Hz")
        assert readout.extra_attrs.get("format") == "%.1f Hz"

    def test_offset_applied(self):
        p = Patcher()
        target = p.add_box("dial", x=10.0, y=20.0)
        readout = p.add_overlay_readout(target, offset_x=5.0, offset_y=4.0)
        assert readout.patching_rect[0] == target.patching_rect[0] + 5.0
        assert readout.patching_rect[1] == target.patching_rect[1] + 4.0
        assert readout.patching_rect[2] == target.patching_rect[2]
        assert readout.patching_rect[3] == target.patching_rect[3]

    def test_default_overlaps_target_rect(self):
        p = Patcher()
        target = p.add_box("dial", x=10.0, y=20.0)
        readout = p.add_overlay_readout(target)
        assert readout.patching_rect == list(target.patching_rect)

    def test_target_rect_not_mutated(self):
        p = Patcher()
        target = p.add_box("dial", x=10.0, y=20.0)
        original_target_x = target.patching_rect[0]
        readout = p.add_overlay_readout(target)
        readout.patching_rect[0] = 999.0
        assert target.patching_rect[0] == original_target_x

    @pytest.mark.parametrize("type_", ["flonum", "comment", "number"])
    def test_type_variants_all_z_ordered(self, type_):
        p = Patcher()
        target = p.add_box("dial", x=10.0, y=20.0)
        readout = p.add_overlay_readout(target, type=type_)
        assert readout.name == type_
        assert p.boxes[0] is readout

    def test_invalid_type_raises(self):
        p = Patcher()
        target = p.add_box("dial", x=10.0, y=20.0)
        with pytest.raises(ValueError, match="flonum"):
            p.add_overlay_readout(target, type="button")
