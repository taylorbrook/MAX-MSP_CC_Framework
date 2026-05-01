"""Tests for the curated waveguide topology library.

Covers the registry (TOPOLOGIES + get_topology) and per-topology invariants
for BoreOnly, ReedBore, and ReedBorePostRadiation. Per CONTEXT.md D-01
(curated catalog) and D-11 (v0.4.2+ shape).
"""

from __future__ import annotations

import math

import numpy as np
import pytest


# ===========================================================================
# Helpers
# ===========================================================================

_SAMPLE_RATE = 44100


def _drive(stepper, in1: float, in2: float, n: int) -> np.ndarray:
    """Run `stepper.step(in1, in2)` for n samples; return numpy buffer."""
    out = np.zeros(n, dtype=np.float64)
    for i in range(n):
        out[i] = stepper.step(in1, in2)
    return out


def _post_settle_rms(buf: np.ndarray, settle_samples: int) -> float:
    """RMS of the buffer after skipping the first settle_samples."""
    tail = buf[settle_samples:]
    if tail.size == 0:
        return 0.0
    return float(np.sqrt(np.mean(tail * tail)))


def _measure_fundamental_hz(
    buf: np.ndarray,
    sample_rate: float,
    target_hz: float | None = None,
    search_octaves: float = 0.5,
) -> float:
    """FFT-based fundamental tracker with optional narrow-band search.

    When `target_hz` is provided, searches only within +/-`search_octaves`
    around the target. This is essential for post-radiation topologies where
    the bell LPF / reed BPF can produce louder spectral peaks than the
    loop's actual fundamental -- the v0.4.2+ invariant test cares about the
    LOOP fundamental, not the loudest radiated component.

    When `target_hz` is None, falls back to global peak detection.
    """
    if buf.size < 64:
        return 0.0
    # Hann window to suppress sidelobe leakage
    w = np.hanning(buf.size)
    spec = np.abs(np.fft.rfft(buf * w))
    if spec.size < 4:
        return 0.0
    bin_hz = sample_rate / buf.size

    if target_hz is not None and target_hz > 0:
        lo_hz = target_hz / (2.0 ** search_octaves)
        hi_hz = target_hz * (2.0 ** search_octaves)
        lo_bin = max(1, int(lo_hz / bin_hz))
        hi_bin = min(spec.size - 1, int(hi_hz / bin_hz) + 1)
        if hi_bin <= lo_bin:
            return 0.0
        sub = spec[lo_bin:hi_bin]
        k = int(np.argmax(sub)) + lo_bin
    else:
        k = int(np.argmax(spec[1:])) + 1

    if k <= 0 or k >= spec.size - 1:
        return float(k * bin_hz)
    # Parabolic interpolation around peak bin
    a = spec[k - 1]
    b = spec[k]
    c = spec[k + 1]
    denom = (a - 2.0 * b + c)
    if abs(denom) < 1e-12:
        return float(k * bin_hz)
    delta = 0.5 * (a - c) / denom
    return float((k + delta) * bin_hz)


# ===========================================================================
# Registry tests
# ===========================================================================

class TestRegistry:
    """Topology registry membership + dispatch."""

    def test_module_imports(self):
        """Public surface is importable from src.maxpat.dsp_sim.topologies."""
        from src.maxpat.dsp_sim.topologies import (  # noqa: F401
            TOPOLOGIES,
            get_topology,
            BoreOnly,
            ReedBore,
            ReedBorePostRadiation,
        )

    def test_registry_keys_are_exact(self):
        """TOPOLOGIES must expose exactly the three curated names (D-01)."""
        from src.maxpat.dsp_sim.topologies import TOPOLOGIES
        assert set(TOPOLOGIES.keys()) == {
            "bore_only",
            "reed_bore",
            "reed_bore_post_radiation",
        }

    def test_get_topology_returns_class(self):
        """get_topology('bore_only') returns the BoreOnly class."""
        from src.maxpat.dsp_sim.topologies import get_topology, BoreOnly
        assert get_topology("bore_only") is BoreOnly

    def test_get_topology_unknown_raises(self):
        """Unknown topology name raises TopologyError with 'unknown topology'."""
        from src.maxpat.dsp_sim.topologies import get_topology, TopologyError
        with pytest.raises(TopologyError) as excinfo:
            get_topology("nonexistent")
        assert "unknown topology" in str(excinfo.value).lower()


# ===========================================================================
# BoreOnly tests
# ===========================================================================

class TestBoreOnly:
    """Passive bore waveguide invariants."""

    def _make(self, **overrides) -> "BoreOnly":  # type: ignore[name-defined]
        from src.maxpat.dsp_sim.topologies import BoreOnly
        params = {"freq": 220.0, "bore_damp": 0.3, "cone_loss": 0.85}
        params.update(overrides)
        return BoreOnly(sample_rate=_SAMPLE_RATE, params=params)

    def test_step_returns_finite_float(self):
        """Single sample step returns a finite scalar."""
        b = self._make()
        v = b.step(220.0, 0.5)
        assert math.isfinite(float(v))

    def test_constant_drive_produces_finite_buffer(self):
        """4096 samples of constant drive yields fully finite output."""
        b = self._make()
        buf = _drive(b, 220.0, 0.5, 4096)
        assert np.all(np.isfinite(buf))

    def test_constant_drive_produces_nonzero_rms(self):
        """Bore loop carries the input — RMS > 0 even passive."""
        b = self._make()
        buf = _drive(b, 220.0, 0.5, 4096)
        rms = _post_settle_rms(buf, settle_samples=512)
        assert rms > 0.0


# ===========================================================================
# ReedBore tests
# ===========================================================================

class TestReedBore:
    """Reed + bore waveguide (v0.3.x ancestor) invariants."""

    def _make(self, **overrides) -> "ReedBore":  # type: ignore[name-defined]
        from src.maxpat.dsp_sim.topologies import ReedBore
        params = {
            "freq": 220.0,
            "breath": 0.6,
            "bore_damp": 0.3,
            "reed_stiff": 0.5,
            "reed_aper": 0.0,
            "cone_loss": 0.85,
        }
        params.update(overrides)
        return ReedBore(sample_rate=_SAMPLE_RATE, params=params)

    def test_step_returns_finite_float(self):
        """Single sample step returns a finite scalar."""
        r = self._make()
        v = r.step(220.0, 0.6)
        assert math.isfinite(float(v))

    def test_oscillates_above_no_oscillation_floor(self):
        """4096 samples at (220, 0.6) produces RMS > 1e-3 (oscillates)."""
        r = self._make()
        buf = _drive(r, 220.0, 0.6, 4096)
        assert np.all(np.isfinite(buf))
        rms = _post_settle_rms(buf, settle_samples=2048)
        assert rms > 1e-3, f"RMS {rms} below 1e-3 oscillation floor"

    def test_accepts_documented_param_surface(self):
        """Accepts freq/breath/bore_damp/reed_stiff/reed_aper/cone_loss without KeyError."""
        from src.maxpat.dsp_sim.topologies import ReedBore
        r = ReedBore(
            sample_rate=_SAMPLE_RATE,
            params={
                "freq": 220.0,
                "breath": 0.6,
                "bore_damp": 0.3,
                "reed_stiff": 0.5,
                "reed_aper": 0.0,
                "cone_loss": 0.85,
            },
        )
        # Single step exercises the full param read path
        _ = r.step(220.0, 0.6)

    def test_settles_to_silence_with_no_breath(self):
        """breath=0 settles to ~0 within 4096 samples."""
        r = self._make(breath=0.0)
        buf = _drive(r, 220.0, 0.0, 4096)
        # Tail RMS approaches zero
        rms = _post_settle_rms(buf, settle_samples=3072)
        assert rms < 1e-3, f"Tail RMS {rms} too loud for no-breath case"


# ===========================================================================
# ReedBorePostRadiation tests (v0.4.2+ shape)
# ===========================================================================

class TestReedBorePostRadiation:
    """v0.4.2+ canonical bassoon shape — bell biquad and reed BPF strictly post-loop."""

    def _make(self, **overrides) -> "ReedBorePostRadiation":  # type: ignore[name-defined]
        from src.maxpat.dsp_sim.topologies import ReedBorePostRadiation
        params = {
            "freq": 220.0,
            "breath": 0.6,
            "bore_damp": 0.3,
            "bell_bright": 0.5,
            "reed_stiff": 0.5,
            "reed_aper": 0.0,
            "cone_loss": 0.85,
            "register": 0.0,
            "reed_res_freq": 1500.0,
            "reed_res_q": 0.7071068,
        }
        params.update(overrides)
        return ReedBorePostRadiation(sample_rate=_SAMPLE_RATE, params=params)

    def test_accepts_full_param_surface(self):
        """Accepts the verbatim Param names from bassoon.gendsp."""
        from src.maxpat.dsp_sim.topologies import ReedBorePostRadiation
        r = ReedBorePostRadiation(
            sample_rate=_SAMPLE_RATE,
            params={
                "freq": 220.0,
                "breath": 0.6,
                "bore_damp": 0.3,
                "bell_bright": 0.5,
                "reed_stiff": 0.5,
                "reed_aper": 0.0,
                "reed_res_freq": 1500.0,
                "reed_res_q": 0.7071068,
                "register": 0.0,
                "cone_loss": 0.85,
            },
        )
        _ = r.step(220.0, 0.6)

    def test_oscillates_above_floor(self):
        """8192 samples at (220, 0.6, bell_bright=0.5) produces RMS > 1e-3."""
        r = self._make()
        buf = _drive(r, 220.0, 0.6, 8192)
        assert np.all(np.isfinite(buf))
        rms = _post_settle_rms(buf, settle_samples=4096)
        assert rms > 1e-3, f"RMS {rms} below 1e-3 oscillation floor"

    def test_bell_bright_sweep_does_not_detune_fundamental(self):
        """v0.4.2+ invariant: post-loop bell biquad cannot detune the loop's fundamental.

        Sweep bell_bright across 8 steps, measure fundamental at each, verify
        cents-offset range stays under 5 cents (the D-05 phase_drift threshold).
        """
        target_freq = 220.0
        n_samples = 8192
        settle = 4096
        cents_offsets = []
        for bb in np.linspace(0.0, 1.0, 8):
            r = self._make(bell_bright=float(bb))
            buf = _drive(r, target_freq, 0.6, n_samples)
            measured = _measure_fundamental_hz(
                buf[settle:], _SAMPLE_RATE, target_hz=target_freq
            )
            if measured <= 0.0:
                pytest.skip(f"FFT could not detect fundamental at bell_bright={bb}")
            cents = 1200.0 * math.log2(measured / target_freq)
            cents_offsets.append(cents)
        spread = max(cents_offsets) - min(cents_offsets)
        assert spread < 5.0, (
            f"bell_bright sweep detunes fundamental by {spread:.2f} cents "
            f"(post-loop placement should keep this < 5 cents). "
            f"cents_offsets={cents_offsets}"
        )

    def test_settles_to_silence_with_no_breath(self):
        """breath=0 settles to ~0 within 4096 samples."""
        r = self._make(breath=0.0)
        buf = _drive(r, 220.0, 0.0, 4096)
        rms = _post_settle_rms(buf, settle_samples=3072)
        assert rms < 1e-3, f"Tail RMS {rms} too loud for no-breath case"

    def test_module_docstring_cites_provenance(self):
        """Module docstring explicitly cites v0.4.2 provenance."""
        import src.maxpat.dsp_sim.topologies.reed_bore_post_radiation as mod
        doc = mod.__doc__ or ""
        assert "v0.4.2" in doc, "module docstring must cite v0.4.2 provenance"
