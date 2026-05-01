"""Regression mirror: bassoon v0.4.0 (group-delay compensation form).

Reproduces the v0.4.0 GenExpr math from patches/bassoon-model/versions.json:
  - Bell radiation biquad INSIDE the bore loop (NOT post-loop as in v0.4.2+).
  - D4 compensation uses biquad GROUP delay at freq_mod (-d/dw of phase),
    NOT phase delay (atan2 of complex B/A).

Group delay overshoots phase delay near resonance; sweeping bell_bright
(which moves the bell biquad cutoff and therefore its group-delay near the
played fundamental) detunes the loop and the fundamental drifts. Exactly
the regression that motivated the v0.4.1 D4 phase-delay rewrite.

Per CONTEXT.md D-06: asserts verdict == 'phase_drift' when bell_bright
sweeps [0, 1] -- proves the simulator catches the v0.4.0 bug.
Per D-11: hand-coded numpy, NOT auto-extracted from the .gendsp; targets
the failure mechanism, not bit-exact reproduction.
"""

from __future__ import annotations

import math
from dataclasses import dataclass, field

import numpy as np


_BORE_BUFFER_SIZE = 8192


def build_v040_mirror(sample_rate: float, params: dict[str, float]):
    """Factory matching run_simulation(mirror=callable) contract (D-01)."""
    return _BassoonV040Mirror(sample_rate=sample_rate, params=params)


@dataclass
class _BassoonV040Mirror:
    sample_rate: float
    params: dict[str, float]
    _buffer: np.ndarray = field(init=False)
    _wi: int = field(init=False, default=0)
    _bore_lp: float = field(init=False, default=0.0)
    _bell_x1: float = field(init=False, default=0.0)
    _bell_x2: float = field(init=False, default=0.0)
    _bell_y1: float = field(init=False, default=0.0)
    _bell_y2: float = field(init=False, default=0.0)
    _breath_smooth: float = field(init=False, default=0.0)

    def __post_init__(self) -> None:
        self._buffer = np.zeros(_BORE_BUFFER_SIZE, dtype=np.float64)

    def step(self, in1: float, in2: float) -> float:
        # in1 = freq Hz, in2 = breath
        freq = max(20.0, float(in1))
        bore_damp = float(self.params.get("bore_damp", 0.3))
        bell_bright = float(self.params.get("bell_bright", 0.5))
        reed_stiff = float(self.params.get("reed_stiff", 0.5))
        reed_aper = float(self.params.get("reed_aper", 0.0))
        cone_loss = float(self.params.get("cone_loss", 0.85))
        bell_q = float(self.params.get("bell_q", 0.7071068))  # v0.4.0 Butterworth

        # Bell biquad RBJ LPF (recomputed per step from bell_bright).
        bell_freq = 800.0 + 5000.0 * max(0.0, min(1.0, bell_bright))
        w0b = 2.0 * math.pi * bell_freq / self.sample_rate
        alpha_b = math.sin(w0b) / (2.0 * max(0.1, bell_q))
        cos_w0b = math.cos(w0b)
        a0b = 1.0 + alpha_b
        b0b = (1.0 - cos_w0b) / 2.0 / a0b
        b1b = (1.0 - cos_w0b) / a0b
        b2b = (1.0 - cos_w0b) / 2.0 / a0b
        a1b = -2.0 * cos_w0b / a0b
        a2b = (1.0 - alpha_b) / a0b

        # v0.4.0 bug: D4 GROUP-delay compensation. Group delay = -d(phase)/d(omega)
        # via finite difference of unwrapped phase. Group delay overshoots phase
        # delay near resonance -> loop period wrong -> fundamental drifts.
        w_play = 2.0 * math.pi * freq / self.sample_rate
        eps = 1e-4

        def _phi(w: float) -> float:
            num = b0b + b1b * np.exp(-1j * w) + b2b * np.exp(-2j * w)
            den = 1.0 + a1b * np.exp(-1j * w) + a2b * np.exp(-2j * w)
            return float(np.angle(num / den))

        group_delay_samples = -(_phi(w_play + eps) - _phi(w_play - eps)) / (2.0 * eps)

        # Bore round-trip with WRONG (group-delay-based) compensation.
        period = self.sample_rate / freq
        delay_samples = max(2.0, period * 0.5 - group_delay_samples)
        if delay_samples >= _BORE_BUFFER_SIZE - 1:
            delay_samples = _BORE_BUFFER_SIZE - 2
        int_delay = int(delay_samples)
        ri = (self._wi - int_delay) % _BORE_BUFFER_SIZE
        delayed = float(self._buffer[ri])

        # Bore onepole damping (low-Q in-loop).
        b = max(0.0, min(0.999, 1.0 - bore_damp))
        self._bore_lp = b * self._bore_lp + (1.0 - b) * delayed

        # Bell biquad INSIDE the loop (v0.4.0 bug).
        bell_in = self._bore_lp
        bell_out = (
            b0b * bell_in + b1b * self._bell_x1 + b2b * self._bell_x2
            - a1b * self._bell_y1 - a2b * self._bell_y2
        )
        self._bell_x2, self._bell_x1 = self._bell_x1, bell_in
        self._bell_y2, self._bell_y1 = self._bell_y1, bell_out
        cone_return = -cone_loss * bell_out

        # Reed (McIntyre-Woodhouse rectified, matches bassoon.gendsp).
        self._breath_smooth = 0.999 * self._breath_smooth + 0.001 * float(in2)
        delta_p = max(0.0, min(1.0, self._breath_smooth - cone_return + reed_aper))
        reed_ratio = delta_p * (1.0 / 0.85)
        reed_opening = max(0.0, 1.0 - reed_ratio * reed_ratio)
        reed_sig = delta_p * math.sqrt(reed_opening) * (0.75 - reed_stiff * 0.45)

        bore_in = reed_sig + cone_return
        self._buffer[self._wi] = bore_in
        self._wi = (self._wi + 1) % _BORE_BUFFER_SIZE
        return reed_sig + cone_return
