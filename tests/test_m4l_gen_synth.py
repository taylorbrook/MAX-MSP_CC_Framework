"""Tests for Patcher.add_m4l_gen_synth -- LAYOUT-04.

Covers D-15 (minimum-viable M4L gen synth skeleton): gen~ with stable
varname, live.dials with param_connect + saved_attribute_attributes.valueof
block, plugout~ wired DIRECTLY to gen~ (no gain~ in path), and the T-31-04
threat mitigation that asserts every dial's param_connect prefix matches
the gen_varname literally.
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
        p, gen, dials, plugout, params = self._basic_synth()
        assert isinstance(dials, list)
        assert len(dials) == len(params)
        assert gen is not None
        assert plugout is not None

    def test_gen_obj_has_varname(self):
        p, gen, _, _, _ = self._basic_synth()
        assert gen.extra_attrs.get("varname") == "synth"

    def test_gen_obj_custom_varname_applied(self):
        p = Patcher()
        gen, _, _ = p.add_m4l_gen_synth(
            [("freq", 100.0, 1000.0)], gen_varname="myosc",
        )
        assert gen.extra_attrs.get("varname") == "myosc"

    def test_each_dial_has_param_connect(self):
        p, _, dials, _, _ = self._basic_synth()
        for d in dials:
            assert "param_connect" in d.extra_attrs

    def test_param_connect_prefix_matches_gen_varname(self):
        # T-31-04: typo'd param_connect prefix would silently break Live binding.
        # The implementation must construct param_connect as
        # f"{gen_varname}::{name}" so this assertion catches mutations.
        p, gen, dials, _, _ = self._basic_synth()
        prefix = f"{gen.extra_attrs['varname']}::"
        for d in dials:
            assert d.extra_attrs["param_connect"].startswith(prefix), (
                f"param_connect={d.extra_attrs['param_connect']!r} does not "
                f"start with {prefix!r}"
            )

    def test_param_connect_suffix_matches_param_name(self):
        p, _, dials, _, params = self._basic_synth()
        for i, (name, _mn, _mx) in enumerate(params):
            assert dials[i].extra_attrs["param_connect"].endswith(f"::{name}")

    def test_each_dial_has_varname_matching_param_name(self):
        p, _, dials, _, params = self._basic_synth()
        for i, (name, _mn, _mx) in enumerate(params):
            assert dials[i].extra_attrs.get("varname") == name

    def test_parameter_enable_set(self):
        p, _, dials, _, _ = self._basic_synth()
        for d in dials:
            assert d.extra_attrs.get("parameter_enable") == 1

    def test_valueof_block_complete(self):
        p, _, dials, _, _ = self._basic_synth()
        required_keys = {
            "parameter_initial", "parameter_initial_enable",
            "parameter_longname", "parameter_shortname",
            "parameter_mmin", "parameter_mmax",
            "parameter_modmode", "parameter_type", "parameter_unitstyle",
        }
        for d in dials:
            saa = d.extra_attrs.get("saved_attribute_attributes", {})
            valueof = saa.get("valueof", {})
            missing = required_keys - set(valueof.keys())
            assert not missing, f"missing keys in valueof: {missing}"

    def test_valueof_modmode_absolute(self):
        p, _, dials, _, _ = self._basic_synth()
        for d in dials:
            valueof = d.extra_attrs["saved_attribute_attributes"]["valueof"]
            assert valueof["parameter_modmode"] == int(ModMode.ABSOLUTE)

    def test_valueof_type_float(self):
        p, _, dials, _, _ = self._basic_synth()
        for d in dials:
            valueof = d.extra_attrs["saved_attribute_attributes"]["valueof"]
            assert valueof["parameter_type"] == int(ParamType.FLOAT)

    def test_valueof_unitstyle_float(self):
        p, _, dials, _, _ = self._basic_synth()
        for d in dials:
            valueof = d.extra_attrs["saved_attribute_attributes"]["valueof"]
            assert valueof["parameter_unitstyle"] == int(UnitStyle.FLOAT)

    def test_valueof_mmin_mmax_match_params(self):
        p, _, dials, _, params = self._basic_synth()
        for i, (_name, mn, mx) in enumerate(params):
            valueof = dials[i].extra_attrs["saved_attribute_attributes"]["valueof"]
            assert valueof["parameter_mmin"] == mn
            assert valueof["parameter_mmax"] == mx

    def test_parameter_initial_is_one_element_list(self):
        # Pitfall A2: parameter_initial is a 1-element list per
        # bassoon-model.maxpat, not a scalar.
        p, _, dials, _, _ = self._basic_synth()
        for d in dials:
            valueof = d.extra_attrs["saved_attribute_attributes"]["valueof"]
            initial = valueof["parameter_initial"]
            assert isinstance(initial, list), (
                f"parameter_initial is {type(initial)}"
            )
            assert len(initial) == 1

    def test_plugout_directly_wired_to_gen(self):
        p, gen, _, plugout, _ = self._basic_synth()
        # Find the line out of gen~. Should land on plugout~.
        gen_outgoing = [
            line for line in p.lines if line.source_id == gen.id
        ]
        assert len(gen_outgoing) >= 1
        plugout_dst = [
            line for line in gen_outgoing if line.dest_id == plugout.id
        ]
        assert len(plugout_dst) >= 1, "gen~ does not connect directly to plugout~"

    def test_no_gain_between_gen_and_plugout(self):
        # CLAUDE.md M4L rule: NO gain~/live.gain~/ezdac~ in the output path.
        p, _, _, _, _ = self._basic_synth()
        forbidden = {"gain~", "live.gain~", "ezdac~"}
        offenders = [b for b in p.boxes if b.name in forbidden]
        assert not offenders, (
            f"forbidden gain-stage objects found: "
            f"{[b.name for b in offenders]}"
        )

    def test_param_connect_top_level_after_to_dict(self):
        # Pitfall 4: extra_attrs flattens to top-level via to_dict.
        # If this fails, live.dial bindings break in actual MAX.
        p, _, dials, _, _ = self._basic_synth()
        d = p.to_dict()
        boxes = d["patcher"]["boxes"]
        dial_dicts = [
            b["box"] for b in boxes
            if b["box"].get("maxclass") == "live.dial"
        ]
        assert len(dial_dicts) == len(dials)
        for box_dict in dial_dicts:
            assert "param_connect" in box_dict, (
                f"param_connect not at top-level of box dict: "
                f"{list(box_dict.keys())}"
            )

    def test_polish_pipeline_compatible(self):
        # D-15: skeleton is polish-ready. ensure_parameter_enable does not
        # need to add parameter_enable (already 1).
        p, _, _, _, _ = self._basic_synth()
        d_before = p.to_dict()
        before_pe = [
            b["box"].get("parameter_enable")
            for b in d_before["patcher"]["boxes"]
            if b["box"].get("maxclass") == "live.dial"
        ]
        d_after = ensure_parameter_enable(d_before)
        after_pe = [
            b["box"].get("parameter_enable")
            for b in d_after["patcher"]["boxes"]
            if b["box"].get("maxclass") == "live.dial"
        ]
        assert before_pe == after_pe == [1] * len(before_pe)

    def test_empty_params_raises(self):
        p = Patcher()
        with pytest.raises(ValueError, match="empty"):
            p.add_m4l_gen_synth([])

    def test_returned_boxes_in_patcher(self):
        p, gen, dials, plugout, _ = self._basic_synth()
        assert gen in p.boxes
        assert plugout in p.boxes
        for d in dials:
            assert d in p.boxes
