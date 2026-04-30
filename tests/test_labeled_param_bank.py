"""Tests for Patcher.add_labeled_param_bank (LAYOUT-02).

Codifies the CLAUDE.md "Multislider as Labeled Parameter Bank" recipe
(size*24 height, contdata=1, setstyle=1, orientation=0, setminmax envelope)
as a callable Patcher method. Phase 31, plan 02.

Coverage map (test -> 31-02-PLAN behavior + CONTEXT.md decision):
    test_returns_pair_shape                  -> D-09 (multislider, list[comment])
    test_multislider_size_baked              -> D-10 size = len(params)
    test_multislider_height_is_size_times_24 -> D-10 height = size*24
    test_orientation_horizontal_bars         -> D-10 orientation=0
    test_contdata_baked                      -> D-10 contdata=1
    test_setstyle_baked                      -> D-10 setstyle=1
    test_setminmax_envelope_across_params    -> D-10 setminmax envelope
    test_label_y_alignment_formula           -> D-08 ms.y + i*24
    test_label_x_left_of_multislider         -> D-08 left-aligned
    test_label_text_matches_param_name       -> D-07 label text from param name
    test_extra_attrs_deep_merge_caller_wins  -> D-10 caller wins on collision
    test_empty_params_raises                 -> guard rail
    test_label_side_right_raises             -> D-08 only 'left' shipped
    test_label_side_above_raises             -> D-08 only 'left' shipped
    test_returned_multislider_in_patcher_boxes -> in p.boxes
    test_returned_labels_in_patcher_boxes    -> in p.boxes
"""

import pytest

from src.maxpat.patcher import Patcher, Box


class TestLabeledParamBank:
    """Verify Patcher.add_labeled_param_bank codifies CLAUDE.md recipe correctly."""

    def _make_params(self):
        return [("freq", 0.0, 1.0), ("amp", 0.0, 1.0), ("res", 0.0, 1.0)]

    def test_returns_pair_shape(self):
        p = Patcher()
        params = self._make_params()
        ms, labels = p.add_labeled_param_bank(params, x=100.0, y=50.0)
        assert isinstance(labels, list)
        assert len(labels) == len(params)

    def test_multislider_size_baked(self):
        p = Patcher()
        params = self._make_params()
        ms, _ = p.add_labeled_param_bank(params, x=100.0, y=50.0)
        assert ms.extra_attrs["size"] == 3

    def test_multislider_height_is_size_times_24(self):
        p = Patcher()
        params = self._make_params()
        ms, _ = p.add_labeled_param_bank(params, x=100.0, y=50.0)
        assert ms.patching_rect[3] == 3 * 24.0

    def test_orientation_horizontal_bars(self):
        p = Patcher()
        ms, _ = p.add_labeled_param_bank(self._make_params(), x=100.0, y=50.0)
        assert ms.extra_attrs["orientation"] == 0

    def test_contdata_baked(self):
        p = Patcher()
        ms, _ = p.add_labeled_param_bank(self._make_params(), x=100.0, y=50.0)
        assert ms.extra_attrs["contdata"] == 1

    def test_setstyle_baked(self):
        p = Patcher()
        ms, _ = p.add_labeled_param_bank(self._make_params(), x=100.0, y=50.0)
        assert ms.extra_attrs["setstyle"] == 1

    def test_setminmax_envelope_across_params(self):
        p = Patcher()
        params = [("a", 0.0, 1.0), ("b", -5.0, 5.0)]
        ms, _ = p.add_labeled_param_bank(params, x=100.0, y=50.0)
        assert ms.extra_attrs["setminmax"] == [-5.0, 5.0]

    def test_label_y_alignment_formula(self):
        p = Patcher()
        params = self._make_params()
        ms, labels = p.add_labeled_param_bank(params, x=100.0, y=50.0)
        for i, label in enumerate(labels):
            assert label.patching_rect[1] == ms.patching_rect[1] + i * 24.0

    def test_label_x_left_of_multislider(self):
        p = Patcher()
        ms, labels = p.add_labeled_param_bank(self._make_params(), x=100.0, y=50.0)
        for label in labels:
            assert label.patching_rect[0] < ms.patching_rect[0]

    def test_label_text_matches_param_name(self):
        p = Patcher()
        params = self._make_params()
        ms, labels = p.add_labeled_param_bank(params, x=100.0, y=50.0)
        for i, (name, _, _) in enumerate(params):
            assert labels[i].text == name

    def test_extra_attrs_deep_merge_caller_wins(self):
        p = Patcher()
        params = self._make_params()
        ms, _ = p.add_labeled_param_bank(
            params, x=100.0, y=50.0,
            extra_attrs={"contdata": 0, "bgcolor": [1, 0, 0, 1]},
        )
        # Caller wins on collision
        assert ms.extra_attrs["contdata"] == 0
        # Caller-only keys merged in
        assert ms.extra_attrs["bgcolor"] == [1, 0, 0, 1]
        # Non-colliding baked attrs preserved
        assert ms.extra_attrs["size"] == 3
        assert ms.extra_attrs["orientation"] == 0
        assert ms.extra_attrs["setstyle"] == 1

    def test_empty_params_raises(self):
        p = Patcher()
        with pytest.raises(ValueError, match="empty"):
            p.add_labeled_param_bank([], x=100.0, y=50.0)

    def test_label_side_right_raises(self):
        p = Patcher()
        with pytest.raises(ValueError, match="left"):
            p.add_labeled_param_bank(
                self._make_params(), x=100.0, y=50.0, label_side='right'
            )

    def test_label_side_above_raises(self):
        p = Patcher()
        with pytest.raises(ValueError, match="left"):
            p.add_labeled_param_bank(
                self._make_params(), x=100.0, y=50.0, label_side='above'
            )

    def test_returned_multislider_in_patcher_boxes(self):
        p = Patcher()
        ms, _ = p.add_labeled_param_bank(self._make_params(), x=100.0, y=50.0)
        assert ms in p.boxes

    def test_returned_labels_in_patcher_boxes(self):
        p = Patcher()
        _, labels = p.add_labeled_param_bank(self._make_params(), x=100.0, y=50.0)
        for c in labels:
            assert c in p.boxes
