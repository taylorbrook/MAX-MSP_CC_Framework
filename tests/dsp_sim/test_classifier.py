"""Tests for the dsp_sim classifier verdict cascade.

Per Phase 32 CONTEXT.md D-03 (four distinct verdicts), D-05 (default
thresholds), D-09 (verdict priority cascade).

Validates:
  - The five verdicts (`pass` + four failure modes) emerge correctly on
    synthetic StepMeasurement lists.
  - D-09 priority ordering (`runaway` > `no_oscillation` > `mode_competition`
    > `phase_drift` > `pass`).
  - Suggested-fix strings match the D-03 table verbatim.
  - Threshold overrides propagate through `ClassifierThresholds`.
"""

from __future__ import annotations

import math

import pytest

from src.maxpat.dsp_sim.classifier import (
    MODE_COMPETITION,
    NO_OSCILLATION,
    PASS,
    PHASE_DRIFT,
    RUNAWAY,
    classify,
)
from src.maxpat.dsp_sim.measure import ClassifierThresholds

from tests.dsp_sim.conftest import make_step


# ===========================================================================
# Verdict cascade -- one test per failure mode + the pass case
# ===========================================================================


class TestClassifier:
    """Verify classify(measurements, thresholds) emits the expected verdict."""

    def test_pass_when_all_clean(self):
        """All-clean measurements -> verdict='pass', worst_step is None."""
        measurements = [
            make_step(param_value=i / 31.0, measured_hz=220.0, cents_offset=0.0)
            for i in range(32)
        ]
        verdict, worst, reason, fix = classify(measurements)
        assert verdict == PASS
        assert worst is None
        assert reason
        assert fix is None

    def test_runaway_preempts_mode_competition(self):
        """One step peak=12.0 plus a 200-cent jump -> runaway wins (D-09)."""
        measurements = [make_step() for _ in range(32)]
        # mode_competition trigger somewhere in the middle
        measurements[10] = make_step(cents_offset=200.0)
        # runaway later -- D-09 priority means runaway wins regardless of order
        measurements[20] = make_step(peak_amplitude=12.0)
        verdict, worst, reason, fix = classify(measurements)
        assert verdict == RUNAWAY
        assert worst == 20
        assert "runaway" in reason.lower()
        assert "Loop gain" in fix

    def test_runaway_on_nan_peak(self):
        """A NaN peak_amplitude trips runaway (D-09 priority 1)."""
        measurements = [make_step() for _ in range(8)]
        measurements[3] = make_step(peak_amplitude=float("nan"))
        verdict, worst, reason, fix = classify(measurements)
        assert verdict == RUNAWAY
        assert worst == 3
        assert fix is not None
        assert "Loop gain" in fix

    def test_no_oscillation_below_floor(self):
        """rms_amplitude below amplitude_floor at any step -> no_oscillation."""
        measurements = [make_step(rms_amplitude=5e-5) for _ in range(8)]
        verdict, worst, reason, fix = classify(measurements)
        assert verdict == NO_OSCILLATION
        assert worst == 0  # first step hitting the floor
        assert "no_oscillation" in reason.lower()
        assert "Loop dissipation" in fix

    def test_mode_competition_50_cent_jump(self):
        """A single step with |cents_offset| > 50 -> mode_competition."""
        measurements = [make_step(cents_offset=0.0) for _ in range(8)]
        measurements[4] = make_step(cents_offset=80.0)
        verdict, worst, reason, fix = classify(measurements)
        assert verdict == MODE_COMPETITION
        assert worst == 4
        assert "mode_competition" in reason.lower()
        assert "post-loop" in fix

    def test_phase_drift_smooth_drift_over_5_cents(self):
        """Smooth drift with range > 5 cents -> phase_drift."""
        # 32-step linear drift from -10 to +10 cents (range = 20 cents)
        measurements = [
            make_step(param_value=i / 31.0, cents_offset=-10.0 + 20.0 * i / 31.0)
            for i in range(32)
        ]
        verdict, worst, reason, fix = classify(measurements)
        assert verdict == PHASE_DRIFT
        assert worst is not None
        # worst is the step furthest from mean cents (mean ~ 0); ends are the extremes
        assert worst in (0, 31)
        assert "phase_drift" in reason.lower()
        assert "phase delay" in fix

    def test_return_tuple_shape(self):
        """classify returns (verdict, worst_step, reason, suggested_fix)."""
        result = classify([make_step()])
        assert isinstance(result, tuple)
        assert len(result) == 4

    def test_threshold_override_passes_drift(self):
        """Override cents_drift_limit=50.0 -> the 20-cent drift becomes pass."""
        measurements = [
            make_step(param_value=i / 31.0, cents_offset=-10.0 + 20.0 * i / 31.0)
            for i in range(32)
        ]
        loose = ClassifierThresholds(cents_drift_limit=50.0)
        verdict, _, _, fix = classify(measurements, loose)
        assert verdict == PASS
        assert fix is None
