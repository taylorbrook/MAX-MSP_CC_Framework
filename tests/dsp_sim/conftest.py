"""Shared fixtures for dsp_sim tests.

Per Phase 32 CONTEXT.md `<canonical_refs>` -- mirrors the bassoon Param
defaults so any topology test or regression fixture can rely on the
canonical sweep without hand-rolling the dict each time.
"""

from __future__ import annotations

import pytest

from src.maxpat.dsp_sim.measure import ClassifierThresholds, StepMeasurement


SAMPLE_RATE = 44100
BELL_BRIGHT_SWEEP = (0.0, 1.0, 32)


@pytest.fixture(scope="session")
def default_params() -> dict[str, float]:
    """Bassoon-typical Param defaults (matches bassoon.gendsp Param defaults)."""
    return {
        "freq": 220.0,
        "breath": 0.6,
        "bore_damp": 0.3,
        "bell_bright": 0.5,
        "reed_stiff": 0.5,
        "reed_aper": 0.0,
    }


@pytest.fixture(scope="session")
def default_thresholds() -> ClassifierThresholds:
    """ClassifierThresholds with D-05 LOCKED defaults."""
    return ClassifierThresholds()


def make_step(
    param_value: float = 0.5,
    target_hz: float = 220.0,
    measured_hz: float = 220.0,
    cents_offset: float = 0.0,
    rms_amplitude: float = 0.5,
    peak_amplitude: float = 0.7,
) -> StepMeasurement:
    """Helper to build a StepMeasurement in tests.

    Mirrors `tests/test_critics.py::_make_patch` style -- a small builder
    that supplies sensible defaults so the test body only specifies the
    fields the assertion cares about.
    """
    return StepMeasurement(
        param_value=param_value,
        target_hz=target_hz,
        measured_hz=measured_hz,
        cents_offset=cents_offset,
        rms_amplitude=rms_amplitude,
        peak_amplitude=peak_amplitude,
    )
