"""Tests for Patcher.add_overlay_readout (LAYOUT-01).

Codifies the CLAUDE.md Rule #6 overlay-readout recipe (bring_to_front +
ignoreclick=1) as a callable Patcher method. Phase 31, plan 01.

Coverage map (test → CONTEXT.md decision):
    test_returns_flonum_by_default                       → D-04 default
    test_readout_at_index_zero                           → D-06 unconditional bring_to_front
    test_default_ignoreclick_is_one                      → D-06 default ignoreclick
    test_editable_disables_ignoreclick                   → D-06 editable=True opt-out
    test_format_translates_to_numdecimalplaces           → D-03 (CR-01 fix) printf %.Nf → numdecimalplaces=N on flonum
    test_format_default_is_two_decimals                  → CR-01 default '%.2f' → numdecimalplaces=2
    test_format_zero_decimals                            → CR-01 '%.0f' → numdecimalplaces=0
    test_number_type_translates_format                   → CR-01 number type also translates
    test_flonum_rejects_non_pure_format                  → CR-01 unit suffix / non-pure format raises ValueError
    test_number_rejects_unit_suffix                      → CR-01 number applies same rule
    test_comment_accepts_any_format_string_no_attr_written → CR-01 comment accepts any string informationally
    test_comment_with_pure_numeric_format_no_attr_written  → CR-01 comment never writes format/numdecimalplaces
    test_offset_applied                                  → D-05 fine-tune offsets
    test_default_overlaps_target_rect                    → D-05 default rect copy
    test_target_rect_not_mutated                         → Pitfall 1: list copy
    test_type_variants_all_z_ordered                     → D-04 flonum/comment/number
    test_invalid_type_raises                             → guard rail
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

    def test_format_translates_to_numdecimalplaces(self):
        """D-03 (corrected per CR-01 fix): '%.Nf' baked as numdecimalplaces=N.

        flonum has no `format` attribute (verified against DB). The format
        kwarg is the agent-facing surface; numdecimalplaces is the actual
        MAX attribute carrying the value. The kwarg name is unchanged; only
        the storage attribute is corrected.
        """
        p = Patcher()
        target = p.add_box("dial", x=10.0, y=20.0)
        readout = p.add_overlay_readout(target, format="%.4f")
        assert readout.extra_attrs.get("numdecimalplaces") == 4
        # Regression guard: the dead 'format' key MUST NOT be written.
        assert "format" not in readout.extra_attrs

    def test_format_default_is_two_decimals(self):
        """Default format='%.2f' produces numdecimalplaces=2 (back-compat)."""
        p = Patcher()
        target = p.add_box("dial", x=10.0, y=20.0)
        readout = p.add_overlay_readout(target)  # default format="%.2f"
        assert readout.extra_attrs.get("numdecimalplaces") == 2
        assert "format" not in readout.extra_attrs

    def test_format_zero_decimals(self):
        """format='%.0f' produces numdecimalplaces=0."""
        p = Patcher()
        target = p.add_box("dial", x=10.0, y=20.0)
        readout = p.add_overlay_readout(target, format="%.0f")
        assert readout.extra_attrs.get("numdecimalplaces") == 0
        assert "format" not in readout.extra_attrs

    def test_number_type_translates_format(self):
        """type='number': '%.Nf' also translates to numdecimalplaces=N.

        number has BOTH a `format` (int enum: 0=int, 1=float, ...) AND a
        `numdecimalplaces` int attribute. We use numdecimalplaces and
        never write the int-enum `format`.
        """
        p = Patcher()
        target = p.add_box("dial", x=10.0, y=20.0)
        readout = p.add_overlay_readout(target, type="number", format="%.3f")
        assert readout.extra_attrs.get("numdecimalplaces") == 3
        assert "format" not in readout.extra_attrs

    @pytest.mark.parametrize("bad_format", [
        "%.1f Hz",         # unit suffix
        "freq: %.2f",      # literal prefix
        "hello",           # no template at all
        "%d",              # %d not %.Nf
        "%.f",             # missing N
        "%.2g",            # %g not %f
    ])
    def test_flonum_rejects_non_pure_format(self, bad_format):
        """flonum with anything other than pure '%.Nf' raises ValueError
        pointing at type='comment'.
        """
        p = Patcher()
        target = p.add_box("dial", x=10.0, y=20.0)
        with pytest.raises(ValueError, match="comment"):
            p.add_overlay_readout(target, format=bad_format)

    def test_number_rejects_unit_suffix(self):
        """type='number' applies the same pure-'%.Nf' rule."""
        p = Patcher()
        target = p.add_box("dial", x=10.0, y=20.0)
        with pytest.raises(ValueError, match="comment"):
            p.add_overlay_readout(target, type="number", format="%.1f Hz")

    def test_comment_accepts_any_format_string_no_attr_written(self):
        """type='comment' accepts the format kwarg as informational only;
        nothing is written to extra_attrs (no native formatting attribute).
        """
        p = Patcher()
        target = p.add_box("dial", x=10.0, y=20.0)
        readout = p.add_overlay_readout(
            target, type="comment", format="%.1f Hz"
        )
        assert readout.name == "comment"
        assert "format" not in readout.extra_attrs
        assert "numdecimalplaces" not in readout.extra_attrs

    def test_comment_with_pure_numeric_format_no_attr_written(self):
        """Even pure '%.Nf' on comment writes nothing — comments have no
        decimals attribute.
        """
        p = Patcher()
        target = p.add_box("dial", x=10.0, y=20.0)
        readout = p.add_overlay_readout(
            target, type="comment", format="%.2f"
        )
        assert "format" not in readout.extra_attrs
        assert "numdecimalplaces" not in readout.extra_attrs

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
