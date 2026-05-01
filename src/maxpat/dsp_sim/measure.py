"""Measurement primitives for the DSP pre-flight simulator.

Per Phase 32 CONTEXT.md D-03 (StepMeasurement fields) and D-05 (default
thresholds). Measurement output feeds the classifier; one StepMeasurement
per sweep step.

The primitives are intentionally small and pure (no I/O, no global state)
so the classifier can be tested against synthetic StepMeasurement lists
without driving real numpy buffers.
"""

from __future__ import annotations

import math
from dataclasses import dataclass

import numpy as np
import scipy.signal


# ===========================================================================
# Per-step measurement record (D-03)
# ===========================================================================


@dataclass(frozen=True)
class StepMeasurement:
    """Measurement output for a single sweep step.

    Attributes:
        param_value: The swept parameter's value at this step.
        target_hz: Expected fundamental (typically `params['freq']`).
        measured_hz: Detected fundamental from autocorrelation/FFT.
        cents_offset: 1200 * log2(measured_hz / target_hz); 0 on perfect match.
        rms_amplitude: Post-settle RMS of the buffer (amplitude_floor check).
        peak_amplitude: Post-settle |peak|; NaN if any NaN in buffer.
    """

    param_value: float
    target_hz: float
    measured_hz: float
    cents_offset: float
    rms_amplitude: float
    peak_amplitude: float


# ===========================================================================
# Threshold knobs (D-05) -- frozen so classifier branches are referentially safe
# ===========================================================================


@dataclass(frozen=True)
class ClassifierThresholds:
    """Default failure-mode thresholds (D-05 LOCKED).

    All values overridable via run_simulation(...) kwargs but the override
    path is a quiet escape hatch, not the documented default.

    Attributes:
        cents_drift_limit: phase_drift trip if |max - min| cents > this.
        mode_competition_jump: mode_competition trip on |cents_offset| > this at any step.
        amplitude_floor: no_oscillation trip if rms_amplitude < this at any step.
        runaway_amplitude: runaway trip if peak_amplitude > this (or NaN/Inf).
        settle_ms: skip this many ms before measuring (transient swallow).
        sweep_steps: default linear-sweep step count.
        sample_rate: Hz; default audio rate.
    """

    cents_drift_limit: float = 5.0
    mode_competition_jump: float = 50.0
    amplitude_floor: float = 1e-4
    runaway_amplitude: float = 10.0
    settle_ms: int = 100
    sweep_steps: int = 32
    sample_rate: int = 44100


# ===========================================================================
# Measurement primitives
# ===========================================================================


def measure_rms(buf: np.ndarray) -> float:
    """RMS amplitude of a buffer.

    Returns 0.0 for an empty buffer; NaN if any sample is non-finite so that
    the classifier's runaway branch (D-09 priority 1) can short-circuit.
    """
    if buf.size == 0:
        return 0.0
    if not np.all(np.isfinite(buf)):
        return float("nan")
    return float(np.sqrt(np.mean(buf * buf)))


def measure_peak(buf: np.ndarray) -> float:
    """Absolute peak amplitude.

    Returns 0.0 for an empty buffer; NaN if any sample is NaN/Inf so the
    classifier's runaway branch sees a clear signal (D-09 priority 1).
    """
    if buf.size == 0:
        return 0.0
    if not np.all(np.isfinite(buf)):
        return float("nan")
    return float(np.max(np.abs(buf)))


def measure_fundamental(buf: np.ndarray, sample_rate: float) -> float:
    """Estimate fundamental frequency via autocorrelation peak detection.

    Uses scipy.signal.correlate then locates the first peak after the
    zero-lag lobe. Sub-sample accuracy via parabolic interpolation around
    the peak. Returns 0.0 if no clear period is detected (silence, noise,
    or non-finite buffer).

    Bounded by the [50 Hz, 4 kHz] inspection window: max_lag corresponds
    to the lower bound, min_lag to the upper. T-04 (DoS) mitigation: the
    autocorrelation region is bounded by buffer size, no unbounded math.
    """
    if buf.size < 64 or not np.all(np.isfinite(buf)):
        return 0.0
    # Remove DC, normalize to [-1, 1] so correlation peaks scale uniformly.
    x = buf - np.mean(buf)
    peak_abs = float(np.max(np.abs(x)))
    if peak_abs < 1e-9:
        return 0.0
    x = x / peak_abs
    corr = scipy.signal.correlate(x, x, mode="full")
    corr = corr[corr.size // 2:]  # positive lags only
    # Inspection window: max 4 kHz (smallest lag) -> min 50 Hz (largest lag).
    min_lag = max(2, int(sample_rate / 4000.0))
    max_lag = min(corr.size - 1, int(sample_rate / 50.0))
    if max_lag <= min_lag:
        return 0.0
    region = corr[min_lag:max_lag]
    peak_lag_local = int(np.argmax(region))
    peak_lag = float(peak_lag_local + min_lag)
    # Parabolic interpolation around the peak for sub-sample accuracy.
    if 1 <= peak_lag_local <= region.size - 2:
        y0 = region[peak_lag_local - 1]
        y1 = region[peak_lag_local]
        y2 = region[peak_lag_local + 1]
        denom = y0 - 2.0 * y1 + y2
        if abs(denom) > 1e-12:
            offset = 0.5 * (y0 - y2) / denom
            peak_lag = peak_lag + float(offset)
    if peak_lag <= 0.0:
        return 0.0
    return float(sample_rate / peak_lag)


def cents_offset(measured_hz: float, target_hz: float) -> float:
    """1200 * log2(measured / target).

    Returns 0.0 if either input is non-positive (avoids log of zero).
    """
    if measured_hz <= 0.0 or target_hz <= 0.0:
        return 0.0
    return 1200.0 * math.log2(measured_hz / target_hz)
