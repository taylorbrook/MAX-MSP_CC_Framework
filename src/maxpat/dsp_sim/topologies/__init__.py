"""Curated waveguide topology library for the DSP pre-flight simulator.

Per CONTEXT.md D-01: three topologies cover the bassoon shapes -- `bore_only`
(passive bore + onepole damping; sanity-check structure), `reed_bore`
(bore + McIntyre-Woodhouse reed; v0.3.x ancestor), and
`reed_bore_post_radiation` (v0.4.2+ shape with post-loop bell biquad and
post-loop reed BPF). Mirrors patches/bassoon-model/generated/bassoon.gendsp.

The custom-mirror escape hatch (run_simulation(mirror=callable)) covers
off-catalogue patches; this catalog covers the canonical bassoon path.

Usage:
    from src.maxpat.dsp_sim.topologies import get_topology, TOPOLOGIES

    cls = get_topology("reed_bore_post_radiation")
    stepper = cls(sample_rate=44100, params={"freq": 220.0, "breath": 0.6, ...})
    out = stepper.step(220.0, 0.6)
"""

from __future__ import annotations

from src.maxpat.dsp_sim.topologies.bore_only import BoreOnly
from src.maxpat.dsp_sim.topologies.reed_bore import ReedBore
from src.maxpat.dsp_sim.topologies.reed_bore_post_radiation import (
    ReedBorePostRadiation,
)


# TopologyError lives in src.maxpat.dsp_sim.runner (Plan 32-01). Lazy-import
# at first use to avoid circulars; if 32-01 has not landed yet (e.g., during
# isolated worktree execution of 32-02), fall back to a local definition with
# the same name and shape so tests pass standalone. After post-wave merge the
# canonical runner.TopologyError is the one users see.
try:
    from src.maxpat.dsp_sim.runner import TopologyError  # type: ignore[no-redef]
except (ImportError, ModuleNotFoundError):
    class TopologyError(Exception):
        """Raised when a topology name is unknown or mirror conflict detected."""


TOPOLOGIES: dict[str, type] = {
    "bore_only": BoreOnly,
    "reed_bore": ReedBore,
    "reed_bore_post_radiation": ReedBorePostRadiation,
}


def get_topology(name: str) -> type:
    """Return the topology class for `name` or raise TopologyError.

    Args:
        name: Registry key -- one of 'bore_only', 'reed_bore',
            'reed_bore_post_radiation'.

    Returns:
        The topology class (instantiate with sample_rate + params).

    Raises:
        TopologyError: If `name` is not a registered topology. Matches the
            D-01 contract used by run_simulation's _resolve_stepper_factory.
    """
    if name not in TOPOLOGIES:
        known = ", ".join(sorted(TOPOLOGIES.keys()))
        raise TopologyError(f"unknown topology '{name}'. Known: {known}")
    return TOPOLOGIES[name]


__all__ = [
    "TOPOLOGIES",
    "get_topology",
    "TopologyError",
    "BoreOnly",
    "ReedBore",
    "ReedBorePostRadiation",
]
