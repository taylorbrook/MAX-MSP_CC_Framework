"""Failure-mode classifier for the DSP pre-flight simulator.

Per Phase 32 CONTEXT.md D-03 (four distinct verdicts + suggested-fix
strings), D-05 (default thresholds), D-09 (verdict priority cascade).

Verdict priority (D-09): runaway > no_oscillation > mode_competition >
phase_drift > pass. Single verdict per run; the full per-step measurement
table remains available on the SimulationReport for debugging.

Suggested-fix strings (D-03) are lifted from
feedback_waveguide_loop_phase_comp.md so the agent's failure message
matches the user's existing mental model. Match the wording verbatim --
unit tests assert specific substrings.
"""

from __future__ import annotations

import math
from typing import Literal

from src.maxpat.dsp_sim.measure import ClassifierThresholds, StepMeasurement


# ===========================================================================
# Verdict literals (D-03) -- re-exported via dsp_sim/__init__.py
# ===========================================================================

PASS: Literal["pass"] = "pass"
PHASE_DRIFT: Literal["phase_drift"] = "phase_drift"
MODE_COMPETITION: Literal["mode_competition"] = "mode_competition"
NO_OSCILLATION: Literal["no_oscillation"] = "no_oscillation"
RUNAWAY: Literal["runaway"] = "runaway"

Verdict = Literal[
    "pass", "phase_drift", "mode_competition", "no_oscillation", "runaway"
]


# ===========================================================================
# Suggested-fix table (D-03)
# Wording lifted from feedback_waveguide_loop_phase_comp.md
# ===========================================================================

_SUGGESTED_FIX: dict[str, str] = {
    PHASE_DRIFT: (
        "Use phase delay (atan2-based) compensation, not group delay. "
        "Onepole: pd = atan(b*sin(w)/(1-b*cos(w))) / w. "
        "Biquad: evaluate B(e^jw)/A(e^jw) phase, subtract."
    ),
    MODE_COMPETITION: (
        "Move the high-Q (Q > ~1) filter post-loop. In-loop resonant filters "
        "compete with the bore's self-excited mode and detune the fundamental."
    ),
    NO_OSCILLATION: (
        "Loop dissipation likely too high. Check cone_loss / damping coefficients; "
        "verify excitation reaches the loop."
    ),
    RUNAWAY: (
        "Loop gain >= 1. Add a saturator (tanh, clamp) or reduce reflection "
        "scalar to keep |loop_gain| < 1."
    ),
}


# ===========================================================================
# classify() -- verdict cascade per D-09 priority
# ===========================================================================


def classify(
    measurements: list[StepMeasurement],
    thresholds: ClassifierThresholds | None = None,
) -> tuple[Verdict, int | None, str, str | None]:
    """Run the verdict cascade against measurement output.

    Args:
        measurements: One StepMeasurement per sweep step.
        thresholds: Threshold knobs; defaults from ClassifierThresholds().

    Returns:
        Tuple (verdict, worst_step, reason, suggested_fix).
        worst_step is None on pass.
        suggested_fix is None on pass.
    """
    if thresholds is None:
        thresholds = ClassifierThresholds()

    if not measurements:
        return (PASS, None, "no measurements", None)

    # D-09 priority 1: runaway (NaN/Inf or peak above runaway_amplitude).
    for i, m in enumerate(measurements):
        if (not math.isfinite(m.peak_amplitude)
                or m.peak_amplitude > thresholds.runaway_amplitude):
            reason = (
                f"runaway: step {i} peak_amplitude={m.peak_amplitude} "
                f"exceeded threshold {thresholds.runaway_amplitude} "
                f"(or non-finite)"
            )
            return (RUNAWAY, i, reason, _SUGGESTED_FIX[RUNAWAY])

    # D-09 priority 2: no_oscillation (RMS below amplitude_floor at any step).
    for i, m in enumerate(measurements):
        if m.rms_amplitude < thresholds.amplitude_floor:
            reason = (
                f"no_oscillation: step {i} rms_amplitude={m.rms_amplitude:.2e} "
                f"below floor {thresholds.amplitude_floor:.2e} "
                f"at param_value={m.param_value}"
            )
            return (NO_OSCILLATION, i, reason, _SUGGESTED_FIX[NO_OSCILLATION])

    # D-09 priority 3: mode_competition (any step's |cents_offset| > jump).
    for i, m in enumerate(measurements):
        if abs(m.cents_offset) > thresholds.mode_competition_jump:
            reason = (
                f"mode_competition: step {i} cents_offset={m.cents_offset:.1f} "
                f"exceeded jump limit {thresholds.mode_competition_jump} "
                f"at param_value={m.param_value}"
            )
            return (
                MODE_COMPETITION, i, reason, _SUGGESTED_FIX[MODE_COMPETITION]
            )

    # D-09 priority 4: phase_drift (cents range across sweep > drift limit).
    cents_values = [m.cents_offset for m in measurements]
    drift_range = max(cents_values) - min(cents_values)
    if drift_range > thresholds.cents_drift_limit:
        # worst_step = step furthest from sweep mean cents_offset
        mean_cents = sum(cents_values) / len(cents_values)
        worst = max(
            range(len(measurements)),
            key=lambda i: abs(measurements[i].cents_offset - mean_cents),
        )
        reason = (
            f"phase_drift: fundamental shifted {drift_range:.1f} cents over sweep "
            f"(limit {thresholds.cents_drift_limit})"
        )
        return (PHASE_DRIFT, worst, reason, _SUGGESTED_FIX[PHASE_DRIFT])

    return (PASS, None, f"all {len(measurements)} steps within thresholds", None)
