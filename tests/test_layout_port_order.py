"""Regression test: apply_layout must not remap subpatcher port indices.

MAX resolves a subpatcher's inlet/outlet indices from the x-order of the
inlet/outlet boxes inside it. Before this fix, the recursive layout pass
repositioned port boxes by topology, silently rewiring the parent's
connections (found in ji-harmonizer v0.0.1: init "dump" landed on a number
box, param messages hit the wrong prepends).
"""

from src.maxpat.db_lookup import ObjectDatabase
from src.maxpat.layout import apply_layout
from src.maxpat.patcher import Patcher


def _port_rank(inner, port_class):
    ports = [b for b in inner.boxes if b.maxclass == port_class]
    return [b.id for b in sorted(ports, key=lambda b: b.patching_rect[0])]


def test_subpatcher_inlet_outlet_order_survives_layout():
    db = ObjectDatabase()
    p = Patcher(db=db)

    _, inner = p.add_subpatcher("params", inlets=5, outlets=3, x=30, y=30)
    inlets = inner.get_inlets()
    outlets = inner.get_outlets()
    inlet_ids_before = [b.id for b in inlets]
    outlet_ids_before = [b.id for b in outlets]

    # Wire inlets to distinguishable targets at staggered depths so the
    # topological layout has every reason to shuffle the ports around.
    tags = ["voicecount", "complexity", "tonic", "mastertune", "voicingmode"]
    prev = None
    for i, tag in enumerate(tags):
        pre = inner.add_box("prepend", [tag], x=30 + i * 130, y=100)
        inner.add_connection(inlets[i], 0, pre, 0)
        inner.add_connection(pre, 0, outlets[i % 3], 0)
        if prev is not None:
            extra = inner.add_box("prepend", [f"deep{i}"], x=30 + i * 130, y=160)
            inner.add_connection(prev, 0, extra, 0)
        prev = pre

    apply_layout(p)

    assert _port_rank(inner, "inlet") == inlet_ids_before, (
        "inlet x-order changed across apply_layout -- parent connection "
        "indices would be remapped by MAX"
    )
    assert _port_rank(inner, "outlet") == outlet_ids_before, (
        "outlet x-order changed across apply_layout -- parent connection "
        "indices would be remapped by MAX"
    )

    # x-order must also be strictly increasing (no ambiguous ties)
    for port_class in ("inlet", "outlet"):
        xs = [
            b.patching_rect[0]
            for b in sorted(
                (b for b in inner.boxes if b.maxclass == port_class),
                key=lambda b: b.patching_rect[0],
            )
        ]
        assert all(b > a for a, b in zip(xs, xs[1:]))
