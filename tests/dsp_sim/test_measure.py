"""Unit tests for dsp_sim measurement primitives.

Per Phase 32 CONTEXT.md D-03 (StepMeasurement fields) and D-05 (default
thresholds).
"""

from __future__ import annotations

import math

import numpy as np
import pytest

from src.maxpat.dsp_sim.measure import (
    ClassifierThresholds,
    StepMeasurement,
    cents_offset,
    measure_fundamental,
    measure_peak,
    measure_rms,
)


# ===========================================================================
# Measurement primitives
# ===========================================================================


class TestMeasureFundamental:
    """Verify autocorrelation-based pitch tracking."""

    def test_pure_sine_220_hz_recovered(self):
        """A 220 Hz sine on a 4096-sample buffer recovers within +/- 0.5 Hz."""
        sample_rate = 44100
        n = 4096
        t = np.arange(n) / sample_rate
        buf = np.sin(2 * np.pi * 220.0 * t)
        measured = measure_fundamental(buf, sample_rate)
        assert measured == pytest.approx(220.0, abs=0.5)


class TestMeasureRms:
    """Verify RMS amplitude primitive."""

    def test_zeros_returns_zero(self):
        """RMS of all-zero buffer is exactly 0.0."""
        assert measure_rms(np.zeros(1024)) == 0.0

    def test_unit_returns_one(self):
        """RMS of all-ones buffer is exactly 1.0."""
        assert measure_rms(np.ones(1024)) == 1.0


class TestMeasurePeak:
    """Verify peak-amplitude primitive (must propagate NaN)."""

    def test_returns_absolute_peak(self):
        """measure_peak picks the largest |sample|."""
        assert measure_peak(np.array([1.0, -2.5, 0.3])) == 2.5

    def test_nan_propagates(self):
        """Any NaN in the buffer collapses to NaN (runaway detector hint)."""
        result = measure_peak(np.array([np.nan, 0.0]))
        assert math.isnan(result)


# ===========================================================================
# Dataclasses (D-03 + D-05)
# ===========================================================================


class TestStepMeasurement:
    """Verify StepMeasurement field surface."""

    def test_fields_exposed(self):
        """All six required fields are float-typed and accessible."""
        m = StepMeasurement(
            param_value=0.5,
            target_hz=220.0,
            measured_hz=219.5,
            cents_offset=-3.94,
            rms_amplitude=0.5,
            peak_amplitude=0.7,
        )
        assert m.param_value == 0.5
        assert m.target_hz == 220.0
        assert m.measured_hz == 219.5
        assert m.cents_offset == pytest.approx(-3.94)
        assert m.rms_amplitude == 0.5
        assert m.peak_amplitude == 0.7


class TestClassifierThresholdsDefaults:
    """Verify D-05 LOCKED defaults are the documented baseline."""

    def test_default_values_locked(self):
        """All seven D-05 thresholds match the locked baseline."""
        t = ClassifierThresholds()
        assert t.cents_drift_limit == 5.0
        assert t.mode_competition_jump == 50.0
        assert t.amplitude_floor == 1e-4
        assert t.runaway_amplitude == 10.0
        assert t.settle_ms == 100
        assert t.sweep_steps == 32
        assert t.sample_rate == 44100


# ===========================================================================
# cents_offset helper
# ===========================================================================


class TestCentsOffset:
    """Verify cents helper."""

    def test_perfect_match_zero(self):
        """measured == target -> 0 cents."""
        assert cents_offset(220.0, 220.0) == 0.0

    def test_octave_up(self):
        """440 over 220 -> +1200 cents."""
        assert cents_offset(440.0, 220.0) == pytest.approx(1200.0)

    def test_zero_input_safe(self):
        """Non-positive input returns 0.0 (not -inf)."""
        assert cents_offset(0.0, 220.0) == 0.0
        assert cents_offset(220.0, 0.0) == 0.0
