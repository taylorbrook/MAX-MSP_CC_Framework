"""Direct tests for src/maxpat/graph.py (GraphMixin).

GraphMixin is exercised through Patcher instances since the mixin requires
the host class's boxes/lines/db. Scenarios here deliberately differ from
the transitive ED-04 coverage in tests/test_patcher.py: out-of-order
fan-out wiring, mid-chain signal_path, get_inlets()-based subpatcher
assertions, stale-line adjacency guards, and mixed-component sorting.
"""

import pytest

from src.maxpat.patcher import Patcher, Patchline


class TestDownstream:
    """downstream() BFS traversal semantics."""

    def test_linear_chain_ordered(self):
        """A->B->C: downstream(A) returns [B, C] in chain order."""
        p = Patcher()
        a = p.add_box("phasor~", args=["2"])
        b = p.add_box("trunc~")
        c = p.add_box("snapshot~", args=["50"])
        p.add_connection(a, 0, b, 0)
        p.add_connection(b, 0, c, 0)
        assert p.downstream(a) == [b, c]

    def test_fanout_ordered_by_outlet_index(self):
        """Fan-out neighbors are ordered by outlet index (left to right),
        regardless of connection creation order."""
        p = Patcher()
        src = p.add_box("trigger", args=["b", "i", "f"])
        first = p.add_box("button")
        second = p.add_box("number")
        third = p.add_box("flonum")
        # Wire deliberately out of order: outlet 2, then 0, then 1
        p.add_connection(src, 2, third, 0)
        p.add_connection(src, 0, first, 0)
        p.add_connection(src, 1, second, 0)
        assert p.downstream(src) == [first, second, third]

    def test_valueerror_on_foreign_box(self):
        """downstream() raises ValueError for a box from another patcher."""
        p = Patcher()
        p.add_box("cycle~", args=["440"])
        other = Patcher()
        foreign = other.add_box("dac~")
        with pytest.raises(ValueError, match="not in this patcher"):
            p.downstream(foreign)


class TestUpstream:
    """upstream() BFS traversal semantics."""

    def test_linear_chain_reverse_ordered(self):
        """A->B->C: upstream(C) returns [B, A] (nearest first)."""
        p = Patcher()
        a = p.add_box("phasor~", args=["1"])
        b = p.add_box("trunc~")
        c = p.add_box("dac~")
        p.add_connection(a, 0, b, 0)
        p.add_connection(b, 0, c, 0)
        assert p.upstream(c) == [b, a]

    def test_starting_box_excluded(self):
        """The starting box never appears in upstream results."""
        p = Patcher()
        a = p.add_box("toggle")
        b = p.add_box("metro", args=["500"])
        p.add_connection(a, 0, b, 0)
        result = p.upstream(b)
        assert b not in result
        assert result == [a]

    def test_valueerror_on_foreign_box(self):
        """upstream() raises ValueError for a box from another patcher."""
        p = Patcher()
        p.add_box("dac~")
        other = Patcher()
        foreign = other.add_box("cycle~", args=["440"])
        with pytest.raises(ValueError, match="not in this patcher"):
            p.upstream(foreign)


class TestSignalOnly:
    """signal_only=True follows connections only when BOTH endpoints are ~."""

    def test_downstream_excludes_control_branch(self):
        """Mixed chain: control-rate number branch is skipped entirely."""
        p = Patcher()
        osc = p.add_box("cycle~", args=["440"])
        gain = p.add_box("*~", args=["0.5"])
        out = p.add_box("dac~")
        num = p.add_box("number")
        prnt = p.add_box("print")
        p.add_connection(osc, 0, gain, 0)
        p.add_connection(gain, 0, out, 0)
        # Control branch: number feeds the gain's right inlet; osc also
        # drives print (a ~ -> non-~ connection that must be skipped)
        p.add_connection(num, 0, gain, 1)
        p.add_connection(osc, 0, prnt, 0)
        result = p.downstream(osc, signal_only=True)
        assert result == [gain, out]
        assert num not in result
        assert prnt not in result

    def test_upstream_excludes_control_source(self):
        """Upstream signal_only skips the non-~ side of a mixed fan-in."""
        p = Patcher()
        osc = p.add_box("cycle~", args=["440"])
        num = p.add_box("number")
        gain = p.add_box("*~", args=["0.5"])
        p.add_connection(osc, 0, gain, 0)
        p.add_connection(num, 0, gain, 1)
        result = p.upstream(gain, signal_only=True)
        assert result == [osc]

    def test_control_to_signal_connection_not_followed(self):
        """A non-~ -> ~ connection is not followed even though dest is ~."""
        p = Patcher()
        num = p.add_box("number")
        gain = p.add_box("*~", args=["0.5"])
        p.add_connection(num, 0, gain, 1)
        assert p.downstream(num, signal_only=True) == []


class TestSignalPath:
    """signal_path() combines reversed upstream + box + downstream."""

    def test_mid_chain_tilde_box(self):
        """For a mid-chain ~ box: sources first, box in the middle, sinks last."""
        p = Patcher()
        osc = p.add_box("cycle~", args=["440"])
        g1 = p.add_box("*~", args=["0.5"])
        g2 = p.add_box("*~", args=["0.25"])
        out = p.add_box("dac~")
        p.add_connection(osc, 0, g1, 0)
        p.add_connection(g1, 0, g2, 0)
        p.add_connection(g2, 0, out, 0)
        assert p.signal_path(g1) == [osc, g1, g2, out]

    def test_non_tilde_box_excluded_from_path(self):
        """A non-~ box is not itself included in its signal_path."""
        p = Patcher()
        osc = p.add_box("cycle~", args=["440"])
        num = p.add_box("number")
        gain = p.add_box("*~", args=["0.5"])
        p.add_connection(osc, 0, gain, 0)
        p.add_connection(num, 0, gain, 1)
        result = p.signal_path(num)
        assert num not in result

    def test_valueerror_on_foreign_box(self):
        """signal_path() raises ValueError for a box from another patcher."""
        p = Patcher()
        p.add_box("cycle~", args=["440"])
        other = Patcher()
        foreign = other.add_box("*~", args=["0.5"])
        with pytest.raises(ValueError, match="not in this patcher"):
            p.signal_path(foreign)


class TestSubpatcherCrossing:
    """Traversal crosses subpatcher boundaries via inner inlet objects."""

    def test_downstream_includes_inner_inlets(self):
        """downstream() from a box wired into a subpatcher includes the
        inner inlet objects (accessed via get_inlets(), never box.text)."""
        p = Patcher()
        osc = p.add_box("cycle~", args=["440"])
        sub_box, inner = p.add_subpatcher("proc", inlets=2, outlets=1)
        p.add_connection(osc, 0, sub_box, 0)

        inlets = inner.get_inlets()
        assert len(inlets) == 2

        result = p.downstream(osc)
        assert sub_box in result
        for inlet_box in inlets:
            assert inlet_box in result

    def test_downstream_follows_inner_chain(self):
        """Traversal continues from inner inlets through inner boxes."""
        p = Patcher()
        osc = p.add_box("cycle~", args=["440"])
        sub_box, inner = p.add_subpatcher("proc", inlets=1, outlets=1)
        p.add_connection(osc, 0, sub_box, 0)

        inlets = inner.get_inlets()
        outlets = inner.get_outlets()
        inner_gain = inner.add_box("*~", args=["0.5"])
        inner.add_connection(inlets[0], 0, inner_gain, 0)
        inner.add_connection(inner_gain, 0, outlets[0], 0)

        result = p.downstream(osc)
        assert inner_gain in result
        assert outlets[0] in result


class TestConnectedComponents:
    """connected_components() undirected grouping."""

    def test_empty_patcher(self):
        """An empty patcher yields no components."""
        p = Patcher()
        assert p.connected_components() == []

    def test_disjoint_chains_and_isolated_box(self):
        """Two disjoint chains + one unconnected box -> 3 components,
        sorted largest-first; isolated box is a single-element group."""
        p = Patcher()
        # Chain 1: 3 boxes
        a = p.add_box("cycle~", args=["440"])
        b = p.add_box("*~", args=["0.5"])
        c = p.add_box("dac~")
        p.add_connection(a, 0, b, 0)
        p.add_connection(b, 0, c, 0)
        # Chain 2: 2 boxes
        d = p.add_box("toggle")
        e = p.add_box("metro", args=["250"])
        p.add_connection(d, 0, e, 0)
        # Isolated box
        lone = p.add_box("button")

        components = p.connected_components()
        assert len(components) == 3
        assert [len(comp) for comp in components] == [3, 2, 1]
        assert set(components[0]) == {a, b, c}
        assert set(components[1]) == {d, e}
        assert components[2] == [lone]


class TestBuildAdjStaleLines:
    """_build_adj ignores lines referencing removed/unknown box ids."""

    def test_stale_line_ignored_in_adjacency(self):
        """A line referencing an unknown box id appears in neither the
        forward nor reverse adjacency."""
        p = Patcher()
        a = p.add_box("cycle~", args=["440"])
        b = p.add_box("dac~")
        p.add_connection(a, 0, b, 0)
        # Simulate a stale line left behind by an external edit: it
        # references ids that no longer exist in the box list.
        p.lines.append(Patchline("obj-ghost-src", 0, "obj-ghost-dst", 0))
        p.lines.append(Patchline(a.id, 0, "obj-ghost-dst", 0))

        forward, reverse, box_map = p._build_adj()
        assert "obj-ghost-src" not in forward
        assert "obj-ghost-dst" not in reverse
        # The valid connection survives; the a->ghost line is dropped.
        assert forward[a.id] == [(b.id, 0)]
        assert reverse[b.id] == [(a.id, 0)]
        assert "obj-ghost-src" not in box_map

    def test_traversal_unaffected_by_stale_lines(self):
        """downstream() over a patch with stale lines yields only real boxes."""
        p = Patcher()
        a = p.add_box("cycle~", args=["440"])
        b = p.add_box("dac~")
        p.add_connection(a, 0, b, 0)
        p.lines.append(Patchline(a.id, 0, "obj-ghost-dst", 0))
        assert p.downstream(a) == [b]
