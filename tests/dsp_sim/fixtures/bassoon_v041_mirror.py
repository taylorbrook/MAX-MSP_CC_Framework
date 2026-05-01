"""Regression mirror: bassoon v0.4.1 (correct phase-delay compensation,
but bell biquad still IN-LOOP at high Q).

Per patches/bassoon-model/versions.json v0.4.1: D4 phase-delay compensation
was fixed (atan2-based, correct for the onepole part), but the bell
radiation biquad remained inside the loop. The bug: with bell_q ~ 2.5 the
biquad's resonance competes with the bore's self-excited mode and "locks"
the fundamental onto the biquad peak when bell_bright sweeps the biquad
cutoff close to the played fundamental -> 50+ cent jumps -> mode_competition.

Per CONTEXT.md D-06: asserts verdict in {mode_competition, phase_drift}
when bell_bright sweeps [0, 1] with bell_q=2.5. Per memory
feedback_waveguide_loop_phase_comp.md: "Resonant (Q>1) filters must go
POST-LOOP in waveguides" -- this mirror demonstrates the failure mode.
"""

from __future__ import annotations

import math
from dataclasses import dataclass, field

import numpy as np


_BORE_BUFFER_SIZE = 8192


def build_v041_mirror(sample_rate: float, params: dict[str, float]):
    """Factory matching run_simulation(mirror=callable) contract (D-01)."""
    # Force HIGH Q default to expose the v0.4.1 mode-competition mode.
    p = dict(params)
    p.setdefault("bell_q", 2.5)
    return _BassoonV041Mirror(sample_rate=sample_rate, params=p)


@dataclass
class _BassoonV041Mirror:
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
        bell_q = float(self.params.get("bell_q", 2.5))  # v0.4.1 HIGH Q in-loop

        # Bell biquad RBJ LPF (HIGH Q resonant). Sweep brackets the play
        # frequency: bell_freq ranges 200-800 Hz so resonance crosses 220 Hz.
        bell_freq = 200.0 + 600.0 * max(0.0, min(1.0, bell_bright))
        w0b = 2.0 * math.pi * bell_freq / self.sample_rate
        alpha_b = math.sin(w0b) / (2.0 * max(0.1, bell_q))
        cos_w0b = math.cos(w0b)
        a0b = 1.0 + alpha_b
        b0b = (1.0 - cos_w0b) / 2.0 / a0b
        b1b = (1.0 - cos_w0b) / a0b
        b2b = (1.0 - cos_w0b) / 2.0 / a0b
        a1b = -2.0 * cos_w0b / a0b
        a2b = (1.0 - alpha_b) / a0b

        # v0.4.1 fix: D4 PHASE-delay compensation (atan2 of complex B/A).
        # phase delay = -phi(w) / w. Correct for the onepole part, but the
        # high-Q biquad still IN-LOOP destabilises the loop math.
        w_play = 2.0 * math.pi * freq / self.sample_rate
        num = b0b + b1b * np.exp(-1j * w_play) + b2b * np.exp(-2j * w_play)
        den = 1.0 + a1b * np.exp(-1j * w_play) + a2b * np.exp(-2j * w_play)
        phi = float(np.angle(num / den))
        phase_delay_samples = -phi / w_play if w_play > 1e-9 else 0.0

        # Bore round-trip WITH correct phase-delay compensation.
        period = self.sample_rate / freq
        delay_samples = max(2.0, period * 0.5 - phase_delay_samples)
        if delay_samples >= _BORE_BUFFER_SIZE - 1:
            delay_samples = _BORE_BUFFER_SIZE - 2
        int_delay = int(delay_samples)
        ri = (self._wi - int_delay) % _BORE_BUFFER_SIZE
        delayed = float(self._buffer[ri])

        # Bore onepole damping (low-Q in-loop).
        b = max(0.0, min(0.999, 1.0 - bore_damp))
        self._bore_lp = b * self._bore_lp + (1.0 - b) * delayed

        # Bell biquad still INSIDE the loop at HIGH Q (the v0.4.1 bug).
        # tanh saturator bounds the loop so the classifier sees the real
        # failure mode (mode_competition / phase_drift), not numerical runaway
        # from the ~Q dB resonance gain. Real waveguides have this implicitly.
        bell_in = self._bore_lp
        bell_out = math.tanh(
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
