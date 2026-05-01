"""DSP pre-flight simulator orchestrator.

Per Phase 32 CONTEXT.md D-01 (topology library + mirror escape hatch --
one API, two on-ramps), D-03 (SimulationReport shape), D-05 (default
thresholds), D-09 (verdict priority).

Public surface:
  - run_simulation(...) -- single entry point.
  - SimulationReport -- dataclass returned by run_simulation.
  - TopologyError -- raised on unknown topology or mirror/topology conflict.

Threat refs (Phase 32 32-01-PLAN <threat_model>):
  - T-01 (Elevation): mirror= callable comes from dev-authored test code,
    no string eval/exec, no third-party plugin loading.
  - T-04 (DoS): per-step buffer is bounded by `settle_samples + 0.5*sample_rate`;
    runaway early-exit short-circuits the sweep loop on NaN/Inf or peak
    above runaway_amplitude so divergent topologies cannot run unbounded.
"""

from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path
from typing import Any, Callable

import numpy as np

from src.maxpat.dsp_sim.classifier import (
    Verdict,
    classify,
)
from src.maxpat.dsp_sim.measure import (
    ClassifierThresholds,
    StepMeasurement,
    cents_offset as _cents_offset,
    measure_fundamental,
    measure_peak,
    measure_rms,
)


# ===========================================================================
# Exceptions
# ===========================================================================


class TopologyError(Exception):
    """Raised when topology name is unknown or mirror/topology conflict detected."""


# ===========================================================================
# Result shape (D-03)
# ===========================================================================


@dataclass
class SimulationReport:
    """Result of a run_simulation(...) call.

    Attributes:
        verdict: One of 'pass', 'phase_drift', 'mode_competition',
            'no_oscillation', 'runaway' (D-03, D-09 priority cascade).
        measurements: One StepMeasurement per sweep step
            (length == sweep_steps unless an early-exit runaway shortened it).
        worst_step: Index of the step that triggered the failure; None on pass.
        reason: Human-readable diagnostic string.
        suggested_fix: Lifted from feedback_waveguide_loop_phase_comp.md;
            None on pass.
        sweep_param: The parameter that was swept.
        sweep_range: (lo, hi, n) triple driving the sweep.
        sample_rate: Sample rate used for the simulation.
        patch_path: Reference path; carried through for reproducibility (DSPSIM-05).
    """

    verdict: Verdict
    measurements: list[StepMeasurement]
    worst_step: int | None
    reason: str
    suggested_fix: str | None
    sweep_param: str
    sweep_range: tuple[float, float, int]
    sample_rate: int
    patch_path: str | None = None


# ===========================================================================
# Mirror/topology resolution (D-01)
# ===========================================================================


def _resolve_stepper_factory(
    topology: str | None,
    mirror: Callable | None,
) -> Callable:
    """Return a callable (sample_rate, params) -> stepper.

    Stepper has either a .step(in1, in2) -> float method or is itself a
    callable (n_samples, params) -> ndarray. Topology classes use the
    .step(...) form per D-01.

    Mutually exclusive with topology= per D-01.
    """
    if topology is not None and mirror is not None:
        raise TopologyError("topology= and mirror= are mutually exclusive (D-01)")
    if topology is None and mirror is None:
        raise TopologyError("must supply either topology= or mirror= (D-01)")
    if mirror is not None:
        return mirror
    # topology= path -- import topology library lazily so 32-01 can ship
    # before 32-02 lands the actual topology classes.
    try:
        from src.maxpat.dsp_sim.topologies import get_topology  # type: ignore[import-not-found]
    except ImportError as exc:
        raise TopologyError(
            f"topology library not available: {exc}. "
            f"Use mirror= until 32-02 lands."
        )
    cls = get_topology(topology)  # raises TopologyError on miss

    def factory(sample_rate, params):
        return cls(sample_rate=sample_rate, params=params)

    return factory


# ===========================================================================
# Sweep execution
# ===========================================================================


def _render_step(
    stepper: Any,
    n_samples: int,
    params: dict[str, float],
) -> np.ndarray:
    """Run the stepper for n_samples and return the output buffer.

    Excitation: in1 = params['freq'] (Hz scalar), in2 = params.get('breath', 0.6).
    Per CONTEXT.md "Claude's Discretion" the settle window swallows the
    excitation transient; no explicit ramp is applied.

    Stepper protocol:
      - Object with `.step(in1, in2) -> float` method, OR
      - Callable accepting (n_samples, params) -> np.ndarray (vectorised mirrors).
    """
    in1 = float(params.get("freq", 220.0))
    in2 = float(params.get("breath", 0.6))
    if hasattr(stepper, "step"):
        out = np.zeros(n_samples, dtype=np.float64)
        for i in range(n_samples):
            out[i] = stepper.step(in1, in2)
        return out
    # Callable mirror form -- mirror returns a buffer directly.
    return stepper(n_samples, params)


def _measure_step(
    buf: np.ndarray,
    settle_samples: int,
    sample_rate: int,
    target_hz: float,
    param_value: float,
) -> StepMeasurement:
    """Reduce a buffer to a StepMeasurement; skip the first settle_samples."""
    tail = buf[settle_samples:] if buf.size > settle_samples else buf
    measured = measure_fundamental(tail, sample_rate)
    return StepMeasurement(
        param_value=param_value,
        target_hz=target_hz,
        measured_hz=measured,
        cents_offset=_cents_offset(measured, target_hz),
        rms_amplitude=measure_rms(tail),
        peak_amplitude=measure_peak(tail),
    )


# ===========================================================================
# Public entry point (D-01)
# ===========================================================================


def run_simulation(
    *,
    patch_path: str | Path | None = None,
    topology: str | None = None,
    mirror: Callable | None = None,
    params: dict[str, float],
    sweep_param: str,
    sweep: tuple[float, float, int],
    sample_rate: int = 44100,
    settle_ms: int = 100,
    sweep_steps: int | None = None,
    cents_drift_limit: float = 5.0,
    mode_competition_jump: float = 50.0,
    amplitude_floor: float = 1e-4,
    runaway_amplitude: float = 10.0,
) -> SimulationReport:
    """Run a parameter sweep against a topology or custom mirror.

    Per CONTEXT.md D-01 (topology + mirror on-ramps), D-03 (SimulationReport
    fields), D-05 (default thresholds), D-09 (verdict priority).

    Args:
        patch_path: Reference path; carried in the report for reproducibility
            (DSPSIM-05). Optional -- fixtures using mirror= often pass a
            synthetic stub.
        topology: Name of a curated topology
            (mutually exclusive with mirror=).
        mirror: Callable (sample_rate, params) -> stepper
            (mutually exclusive with topology=).
        params: Base parameter dict. The swept parameter overrides
            params[sweep_param] per step.
        sweep_param: Name of the swept parameter.
        sweep: (lo, hi, n) -- n linear steps from lo to hi inclusive.
        sample_rate: Hz; default 44100.
        settle_ms: Skip this many ms before measuring (transient swallow).
        sweep_steps: Override the third element of `sweep` when supplied.
        cents_drift_limit, mode_competition_jump, amplitude_floor,
            runaway_amplitude: D-05 threshold overrides.

    Returns:
        SimulationReport with verdict, measurements, worst_step, reason,
        suggested_fix.

    Raises:
        TopologyError: Unknown topology or topology+mirror conflict.
    """
    factory = _resolve_stepper_factory(topology, mirror)
    lo, hi, n = sweep
    if sweep_steps is not None:
        n = sweep_steps
    if n < 2:
        raise TopologyError(f"sweep must have >= 2 steps; got n={n}")
    settle_samples = int(settle_ms / 1000.0 * sample_rate)
    # T-04 mitigation: per-step buffer is bounded by this fixed window.
    n_samples = settle_samples + int(0.5 * sample_rate)  # 500ms post-settle

    thresholds = ClassifierThresholds(
        cents_drift_limit=cents_drift_limit,
        mode_competition_jump=mode_competition_jump,
        amplitude_floor=amplitude_floor,
        runaway_amplitude=runaway_amplitude,
        settle_ms=settle_ms,
        sweep_steps=n,
        sample_rate=sample_rate,
    )

    # ---- Sweep phase ----
    measurements: list[StepMeasurement] = []
    for i in range(n):
        param_value = lo + i * (hi - lo) / (n - 1)
        step_params = dict(params)
        step_params[sweep_param] = param_value
        target_hz = float(step_params.get("freq", 220.0))
        stepper = factory(sample_rate=sample_rate, params=step_params)
        buf = _render_step(stepper, n_samples, step_params)
        measurements.append(
            _measure_step(buf, settle_samples, sample_rate, target_hz, param_value)
        )
        # T-04 mitigation: early-exit on runaway so divergent topologies
        # don't waste cycles after a NaN/Inf or peak-overshoot is already
        # detected. The classifier still sees the runaway StepMeasurement
        # and emits verdict='runaway' per D-09 priority 1.
        if buf.size and (
            not np.all(np.isfinite(buf))
            or float(np.max(np.abs(buf))) > runaway_amplitude
        ):
            break

    # ---- Classify phase ----
    verdict, worst_step, reason, suggested_fix = classify(measurements, thresholds)

    return SimulationReport(
        verdict=verdict,
        measurements=measurements,
        worst_step=worst_step,
        reason=reason,
        suggested_fix=suggested_fix,
        sweep_param=sweep_param,
        sweep_range=(lo, hi, n),
        sample_rate=sample_rate,
        patch_path=str(patch_path) if patch_path is not None else None,
    )
