"""DSP pre-flight simulator -- offline numpy waveguide stability harness.

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
