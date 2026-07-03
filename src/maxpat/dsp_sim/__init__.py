"""DSP pre-flight simulator -- offline numpy waveguide stability harness.

SCOPE: This is the bassoon-waveguide-specific pre-flight harness for the
bassoon-model patch, NOT a general-purpose DSP simulator. It exists to serve
the CLAUDE.md Gen~ rule that any new in-loop waveguide filter must be
pre-flighted with a numpy simulation before committing (catch pitch-lock /
mode-competition / runaway / no-oscillation before a bassoon patch ships).
The curated topology library ships three bassoon shapes -- `bore_only`,
`reed_bore`, and `reed_bore_post_radiation` (the last encodes the v0.4.2+
"resonant filters go POST-LOOP" invariant) -- each mirroring
patches/bassoon-model/generated/bassoon.gendsp. The `mirror=` escape hatch
(run_simulation(mirror=callable)) covers off-catalogue patches without adding
a topology. See README.md in this package for scope, topologies, and usage.

Per Phase 32 CONTEXT.md D-01 (topology + mirror on-ramps), D-03 (four
distinct failure-mode verdicts), D-04 (max-dsp-agent gate), D-05 (tight
default thresholds), D-09 (verdict priority cascade).

Usage:
    from src.maxpat.dsp_sim import run_simulation, SimulationReport

    report = run_simulation(
        patch_path="patches/bassoon-model/generated/bassoon-model.maxpat",
        topology="reed_bore_post_radiation",
        params={"freq": 220.0, "breath": 0.6, ...},
        sweep_param="bell_bright",
        sweep=(0.0, 1.0, 32),
    )
    assert report.verdict == "pass", report.reason
"""

from __future__ import annotations

from src.maxpat.dsp_sim.classifier import (
    MODE_COMPETITION,
    NO_OSCILLATION,
    PASS,
    PHASE_DRIFT,
    RUNAWAY,
    Verdict,
    classify,
)
from src.maxpat.dsp_sim.measure import (
    ClassifierThresholds,
    StepMeasurement,
    cents_offset,
    measure_fundamental,
    measure_peak,
    measure_rms,
)
from src.maxpat.dsp_sim.runner import (
    SimulationReport,
    TopologyError,
    run_simulation,
)


__all__ = [
    "run_simulation",
    "SimulationReport",
    "StepMeasurement",
    "ClassifierThresholds",
    "TopologyError",
    "classify",
    "Verdict",
    "PASS",
    "PHASE_DRIFT",
    "MODE_COMPETITION",
    "NO_OSCILLATION",
    "RUNAWAY",
    "measure_fundamental",
    "measure_peak",
    "measure_rms",
    "cents_offset",
]
