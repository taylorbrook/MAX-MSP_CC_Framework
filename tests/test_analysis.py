"""Tests for Patcher.analyze() and all analysis facet helpers.

Covers: domain classification, send/receive pair resolution, component merging
via send/receive, section auto-naming, section detection, complexity metrics,
object inventory, signal chain tracing, control flow paths, subpatcher
hierarchy, parameter detection, and full analyze() integration.
"""

from __future__ import annotations

import pytest

from src.maxpat.patcher import Patcher, Box, SECTION_SIGNATURES


# ---------------------------------------------------------------------------
# Helpers -- build small patchers programmatically
# ---------------------------------------------------------------------------

def _make_patcher() -> Patcher:
    """Create a fresh Patcher (with real ObjectDatabase)."""
    return Patcher()


def _quick_box(p: Patcher, name: str, args: list[str] | None = None) -> Box:
    """Add a box, tolerating objects not in the DB (for heuristic tests)."""
    try:
        return p.add_box(name, args=args)
    except ValueError:
        # Object not in DB -- build a Box manually for testing heuristics
        box_id = p._gen_id()
        box = Box.__new__(Box)
        box.name = name
        box.args = args or []
        box.id = box_id
        box.maxclass = "newobj"
        box.text = f"{name} {' '.join(args)}" if args else name
        box.numinlets = 1
        box.numoutlets = 1
        box.outlettype = [""]
        box.patching_rect = [0.0, 0.0, 80.0, 22.0]
        box.fontname = "Arial"
        box.fontsize = 12.0
        box.presentation = False
        box.presentation_rect = None
        box.extra_attrs = {}
        box.target_id = None
        box._inner_patcher = None
        box._saved_object_attributes = None
        box._bpatcher_attrs = None
        box._raw = None
        p.boxes.append(box)
        return box


# ===========================================================================
# TestClassifyDomain
# ===========================================================================

class TestClassifyDomain:
    """Domain classification with DB lookup and heuristic fallback."""

    def test_known_msp_object(self):
        p = _make_patcher()
        box = _quick_box(p, "cycle~", ["440"])
        assert p._classify_domain(box) == "MSP"

    def test_known_jitter_object(self):
        p = _make_patcher()
        box = _quick_box(p, "jit.gl.render")
        assert p._classify_domain(box) == "Jitter"

    def test_known_mc_object(self):
        p = _make_patcher()
        box = _quick_box(p, "mc.mixdown~")
        assert p._classify_domain(box) == "MC"

    def test_known_m4l_object(self):
        p = _make_patcher()
        box = _quick_box(p, "live.dial")
        assert p._classify_domain(box) == "M4L"

    def test_unknown_tilde_heuristic(self):
        p = _make_patcher()
        box = _quick_box(p, "unknown_synth~")
        assert p._classify_domain(box) == "MSP"

    def test_unknown_jit_prefix_heuristic(self):
        p = _make_patcher()
        box = _quick_box(p, "jit.custom.thing")
        assert p._classify_domain(box) == "Jitter"

    def test_unknown_mc_prefix_heuristic(self):
        p = _make_patcher()
        box = _quick_box(p, "mc.custom~")
        assert p._classify_domain(box) == "MC"

    def test_unknown_live_prefix_heuristic(self):
        p = _make_patcher()
        box = _quick_box(p, "live.custom")
        assert p._classify_domain(box) == "M4L"

    def test_unknown_object_fallback(self):
        p = _make_patcher()
        box = _quick_box(p, "unknown_object")
        assert p._classify_domain(box) == "External/Unknown"

    def test_known_max_domain_object(self):
        p = _make_patcher()
        box = _quick_box(p, "trigger", ["b", "i"])
        assert p._classify_domain(box) == "Max"

    def test_ui_maxclass_classified_as_max(self):
        """UI objects like toggle should be classified as 'Max' domain."""
        p = _make_patcher()
        box = _quick_box(p, "toggle")
        # toggle has maxclass="toggle" and is in UI_MAXCLASSES
        result = p._classify_domain(box)
        assert result == "Max"


# ===========================================================================
# TestSendReceivePairs
# ===========================================================================

class TestSendReceivePairs:
    """Pair resolution for all alias forms."""

    def test_signal_send_receive(self):
        p = _make_patcher()
        s = _quick_box(p, "send~", ["audio-bus"])
        r = _quick_box(p, "receive~", ["audio-bus"])
        pairs = p._resolve_send_receive_pairs()
        assert "audio-bus" in pairs
        senders, receivers = pairs["audio-bus"]
        assert s.id in senders
        assert r.id in receivers

    def test_control_send_receive(self):
        p = _make_patcher()
        s = _quick_box(p, "send", ["ctrl-bus"])
        r = _quick_box(p, "receive", ["ctrl-bus"])
        pairs = p._resolve_send_receive_pairs()
        assert "ctrl-bus" in pairs
        senders, receivers = pairs["ctrl-bus"]
        assert s.id in senders
        assert r.id in receivers

    def test_alias_s_tilde_r_tilde(self):
        p = _make_patcher()
        s = _quick_box(p, "s~", ["bus1"])
        r = _quick_box(p, "r~", ["bus1"])
        pairs = p._resolve_send_receive_pairs()
        assert "bus1" in pairs
        assert s.id in pairs["bus1"][0]
        assert r.id in pairs["bus1"][1]

    def test_alias_s_r(self):
        p = _make_patcher()
        s = _quick_box(p, "s", ["ctrl"])
        r = _quick_box(p, "r", ["ctrl"])
        pairs = p._resolve_send_receive_pairs()
        assert "ctrl" in pairs
        assert s.id in pairs["ctrl"][0]
        assert r.id in pairs["ctrl"][1]

    def test_empty_args_skipped(self):
        """send~ with no args should be skipped gracefully."""
        p = _make_patcher()
        _quick_box(p, "send~", [])
        pairs = p._resolve_send_receive_pairs()
        assert pairs == {}

    def test_multiple_senders_single_channel(self):
        p = _make_patcher()
        s1 = _quick_box(p, "send~", ["mix"])
        s2 = _quick_box(p, "send~", ["mix"])
        r = _quick_box(p, "receive~", ["mix"])
        pairs = p._resolve_send_receive_pairs()
        senders, receivers = pairs["mix"]
        assert len(senders) == 2
        assert s1.id in senders
        assert s2.id in senders
        assert r.id in receivers


# ===========================================================================
# TestSendReceiveMerge
# ===========================================================================

class TestSendReceiveMerge:
    """Component merging via send~/receive~ channels."""

    def test_signal_merge(self):
        """cycle~ -> send~ foo  and  receive~ foo -> dac~ should merge."""
        p = _make_patcher()
        osc = _quick_box(p, "cycle~", ["440"])
        s = _quick_box(p, "send~", ["foo"])
        r = _quick_box(p, "receive~", ["foo"])
        dac = _quick_box(p, "dac~")
        p.add_connection(osc, 0, s, 0)
        p.add_connection(r, 0, dac, 0)

        components = p.connected_components()
        # Without merging, cycle~->send~ is one component, receive~->dac~ is another
        assert len(components) == 2

        merged = p._merge_components_by_send_receive(components)
        # After merging, they should be one component
        assert len(merged) == 1
        ids = {b.id for b in merged[0]}
        assert osc.id in ids
        assert s.id in ids
        assert r.id in ids
        assert dac.id in ids

    def test_control_merge(self):
        """send/receive (control rate) should also merge components."""
        p = _make_patcher()
        metro = _quick_box(p, "metro", ["500"])
        s = _quick_box(p, "send", ["tick"])
        r = _quick_box(p, "receive", ["tick"])
        counter = _quick_box(p, "counter", ["16"])
        p.add_connection(metro, 0, s, 0)
        p.add_connection(r, 0, counter, 0)

        components = p.connected_components()
        merged = p._merge_components_by_send_receive(components)
        assert len(merged) == 1

    def test_no_merge_when_no_pairs(self):
        """Components without send/receive stay separate."""
        p = _make_patcher()
        a = _quick_box(p, "cycle~", ["440"])
        b = _quick_box(p, "dac~")
        c = _quick_box(p, "metro", ["500"])
        p.add_connection(a, 0, b, 0)

        components = p.connected_components()
        merged = p._merge_components_by_send_receive(components)
        # cycle~->dac~ and metro should remain separate
        assert len(merged) == 2

    def test_alias_merge(self):
        """s~/r~ aliases should also trigger merge."""
        p = _make_patcher()
        osc = _quick_box(p, "cycle~", ["440"])
        s = _quick_box(p, "s~", ["bus"])
        r = _quick_box(p, "r~", ["bus"])
        dac = _quick_box(p, "dac~")
        p.add_connection(osc, 0, s, 0)
        p.add_connection(r, 0, dac, 0)

        components = p.connected_components()
        merged = p._merge_components_by_send_receive(components)
        assert len(merged) == 1


# ===========================================================================
# TestSectionNaming
# ===========================================================================

class TestSectionNaming:
    """Auto-naming from signature objects."""

    def test_oscillator_section(self):
        p = _make_patcher()
        boxes = [_quick_box(p, "cycle~", ["440"]), _quick_box(p, "dac~")]
        name = p._name_section(boxes)
        assert name == "Oscillator"

    def test_filter_section(self):
        p = _make_patcher()
        boxes = [_quick_box(p, "svf~")]
        name = p._name_section(boxes)
        assert name == "Filter"

    def test_audio_output_section(self):
        p = _make_patcher()
        boxes = [_quick_box(p, "dac~")]
        name = p._name_section(boxes)
        assert name == "Audio Output"

    def test_fallback_section_n(self):
        p = _make_patcher()
        boxes = [_quick_box(p, "print"), _quick_box(p, "prepend")]
        name = p._name_section(boxes, section_num=3)
        assert name == "Section 3"

    def test_priority_source_over_output(self):
        """When both cycle~ and dac~ are in a section, prefer source label."""
        p = _make_patcher()
        boxes = [_quick_box(p, "cycle~", ["440"]), _quick_box(p, "dac~")]
        name = p._name_section(boxes)
        # Source (Oscillator) should win over output (Audio Output)
        assert name == "Oscillator"


# ===========================================================================
# TestSections
# ===========================================================================

class TestSections:
    """End-to-end section detection excluding comments/panels."""

    def test_basic_section_detection(self):
        p = _make_patcher()
        osc = _quick_box(p, "cycle~", ["440"])
        dac = _quick_box(p, "dac~")
        p.add_connection(osc, 0, dac, 0)

        result = p._analyze_sections()
        assert "## Sections" in result
        assert "Oscillator" in result

    def test_comments_excluded(self):
        """Comment-only components should not appear in section output."""
        p = _make_patcher()
        osc = _quick_box(p, "cycle~", ["440"])
        dac = _quick_box(p, "dac~")
        p.add_connection(osc, 0, dac, 0)
        # Add standalone comment (disconnected)
        p.add_comment("This is a comment")

        result = p._analyze_sections()
        # Should have the oscillator section but not a separate comment section
        assert "Oscillator" in result
        lines = [l for l in result.split("\n") if l.startswith("- **")]
        # Only the oscillator section, no comment section
        assert len(lines) == 1

    def test_panels_excluded(self):
        """Panel-only components should not appear in section output."""
        p = _make_patcher()
        osc = _quick_box(p, "cycle~", ["440"])
        dac = _quick_box(p, "dac~")
        p.add_connection(osc, 0, dac, 0)
        # Add a panel
        p.add_panel(0, 0, 200, 100)

        result = p._analyze_sections()
        lines = [l for l in result.split("\n") if l.startswith("- **")]
        assert len(lines) == 1

    def test_send_receive_merge_in_sections(self):
        """Sections should merge components linked by send~/receive~."""
        p = _make_patcher()
        osc = _quick_box(p, "cycle~", ["440"])
        s = _quick_box(p, "send~", ["audio"])
        r = _quick_box(p, "receive~", ["audio"])
        dac = _quick_box(p, "dac~")
        p.add_connection(osc, 0, s, 0)
        p.add_connection(r, 0, dac, 0)

        result = p._analyze_sections()
        # Should be ONE section (merged via send~/receive~)
        lines = [l for l in result.split("\n") if l.startswith("- **")]
        assert len(lines) == 1
        assert "Oscillator" in result
