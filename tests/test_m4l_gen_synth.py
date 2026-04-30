"""Tests for Patcher.add_m4l_gen_synth -- LAYOUT-04.

Covers D-15 (minimum-viable M4L gen synth skeleton): gen~ with stable
varname, live.dials with param_connect + saved_attribute_attributes.valueof
block, plugout~ wired DIRECTLY to gen~ (no gain~ in path), and the T-31-04
threat mitigation that asserts every dial's param_connect prefix matches
the gen_varname literally.

Wave 0 stubs land first (all skipped); Task 1 fleshes out bodies under TDD.
"""

from __future__ import annotations

import pytest

from src.maxpat.patcher import Patcher, Box
from src.maxpat.m4l_polish import ensure_parameter_enable
from src.maxpat.m4l_constants import ParamType, UnitStyle, ModMode


class TestM4LGenSynth:
    """Phase 31 plan 04 unit tests for add_m4l_gen_synth."""

    def _basic_synth(self):
        p = Patcher()
        params = [("freq", 100.0, 1000.0), ("amp", 0.0, 1.0)]
        gen, dials, plugout = p.add_m4l_gen_synth(params)
        return p, gen, dials, plugout, params

    def test_returns_three_tuple_shape(self):
        pytest.skip("Wave 0 stub — implementation lands in task 1")

    def test_gen_obj_has_varname(self):
        pytest.skip("Wave 0 stub — implementation lands in task 1")

    def test_gen_obj_custom_varname_applied(self):
        pytest.skip("Wave 0 stub — implementation lands in task 1")

    def test_each_dial_has_param_connect(self):
        pytest.skip("Wave 0 stub — implementation lands in task 1")

    def test_param_connect_prefix_matches_gen_varname(self):
        # T-31-04: typo'd param_connect prefix would silently break Live binding.
        # Task 1 body: assert dial.extra_attrs["param_connect"].startswith(prefix)
        # so a mutation in the f-string fails this test rather than Live.
        pytest.skip("Wave 0 stub — implementation lands in task 1")

    def test_param_connect_suffix_matches_param_name(self):
        pytest.skip("Wave 0 stub — implementation lands in task 1")

    def test_each_dial_has_varname_matching_param_name(self):
        pytest.skip("Wave 0 stub — implementation lands in task 1")

    def test_parameter_enable_set(self):
        pytest.skip("Wave 0 stub — implementation lands in task 1")

    def test_valueof_block_complete(self):
        pytest.skip("Wave 0 stub — implementation lands in task 1")

    def test_valueof_modmode_absolute(self):
        pytest.skip("Wave 0 stub — implementation lands in task 1")

    def test_valueof_type_float(self):
        pytest.skip("Wave 0 stub — implementation lands in task 1")

    def test_valueof_unitstyle_float(self):
        pytest.skip("Wave 0 stub — implementation lands in task 1")

    def test_valueof_mmin_mmax_match_params(self):
        pytest.skip("Wave 0 stub — implementation lands in task 1")

    def test_parameter_initial_is_one_element_list(self):
        # Pitfall A2: parameter_initial is a 1-element list per
        # bassoon-model.maxpat, not a scalar.
        pytest.skip("Wave 0 stub — implementation lands in task 1")

    def test_plugout_directly_wired_to_gen(self):
        pytest.skip("Wave 0 stub — implementation lands in task 1")

    def test_no_gain_between_gen_and_plugout(self):
        # CLAUDE.md M4L rule: NO gain~/live.gain~/ezdac~ in the output path.
        pytest.skip("Wave 0 stub — implementation lands in task 1")

    def test_param_connect_top_level_after_to_dict(self):
        # Pitfall 4: extra_attrs flattens to top-level via to_dict.
        # If this fails, live.dial bindings break in actual MAX.
        pytest.skip("Wave 0 stub — implementation lands in task 1")

    def test_polish_pipeline_compatible(self):
        # D-15: skeleton is polish-ready. ensure_parameter_enable does not
        # need to add parameter_enable (already 1).
        pytest.skip("Wave 0 stub — implementation lands in task 1")

    def test_empty_params_raises(self):
        pytest.skip("Wave 0 stub — implementation lands in task 1")

    def test_returned_boxes_in_patcher(self):
        pytest.skip("Wave 0 stub — implementation lands in task 1")
