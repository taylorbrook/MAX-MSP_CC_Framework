"""Reed + bore waveguide topology (v0.3.x bassoon ancestor).

Mirrors patches/bassoon-model/generated/bassoon.gendsp BEFORE the v0.4.0
bell-biquad addition: rectified McIntyre-Woodhouse reed feeding a bore loop
with onepole damping. No body formant, no bell biquad, no post-radiation
chain -- those live in reed_bore_post_radiation.py.

Per CLAUDE.md "Gen~ (GenExpr DSP Code)" Gen~ -> numpy mapping. Reed math
follows bassoon.gendsp Reed Model section verbatim:
  delta_p     = clamp(breath - cone_return + reed_aper, 0, 1)
  reed_ratio  = delta_p * (1 / 0.85)            # 0.85 = reference pressure
  reed_opening = max(0, 1 - reed_ratio * reed_ratio)
  reed_flow   = delta_p * sqrt(reed_opening)
  stiff_gain  = 0.75 - reed_stiff * 0.45
  reed_sig    = reed_flow * stiff_gain

Per CONTEXT.md D-01 curated catalog. T-04 mitigation: reed math saturates
via clamp on delta_p (cannot diverge unboundedly) and delay_samples
clamped below _BORE_BUFFER_SIZE.
"""

from __future__ import annotations

import math
from dataclasses import dataclass, field

import numpy as np


_BORE_BUFFER_SIZE = 8192


@dataclass
class ReedBore:
    """Reed + bore waveguide (no radiation chain).

    Args:
        sample_rate: Sample rate in Hz.
        params: Accepts freq, breath, bore_damp, reed_stiff, reed_aper, cone_loss.

    Attributes:
        _buffer: Bore delay buffer.
        _wi: Write index.
        _bore_lp: Onepole bore-damping state.
        _ap_x_prev / _ap_y_prev: Allpass-interpolation state.
        _breath_smooth: One-pole-smoothed breath input.
    """

    sample_rate: float
    params: dict[str, float]
    _buffer: np.ndarray = field(init=False)
    _wi: int = field(init=False, default=0)
    _bore_lp: float = field(init=False, default=0.0)
    _ap_x_prev: float = field(init=False, default=0.0)
    _ap_y_prev: float = field(init=False, default=0.0)
    _breath_smooth: float = field(init=False, default=0.0)

    def __post_init__(self) -> None:
        self._buffer = np.zeros(_BORE_BUFFER_SIZE, dtype=np.float64)

    def step(self, in1: float, in2: float) -> float:
        """One sample of reed + bore loop. in1=freq Hz, in2=breath 0..1."""
        freq = max(20.0, float(in1))
        breath_in = float(in2)
        bore_damp = float(self.params.get("bore_damp", 0.3))
        reed_stiff = float(self.params.get("reed_stiff", 0.5))
        reed_aper = float(self.params.get("reed_aper", 0.0))
        cone_loss = float(self.params.get("cone_loss", 0.85))

        # Smooth breath envelope -- mirrors bassoon.gendsp asymmetric onepole
        # but simplified to a single coefficient here (faster on numpy and the
        # discrimination tests exercise sustained behaviour, not attack edges).
        smooth_coef = 0.999
        self._breath_smooth = (
            smooth_coef * self._breath_smooth + (1.0 - smooth_coef) * breath_in
        )
        breath = self._breath_smooth

        # Read delayed sample (bore round-trip).
        # T-04: clamp delay below buffer size.
        period = self.sample_rate / freq
        delay_samples = max(2.0, period * 0.5)
        if delay_samples >= _BORE_BUFFER_SIZE - 1:
            delay_samples = _BORE_BUFFER_SIZE - 2
        int_delay = int(delay_samples)
        frac = delay_samples - int_delay
        ri = (self._wi - int_delay) % _BORE_BUFFER_SIZE
        delayed = float(self._buffer[ri])

        # Allpass fractional delay
        denom = 1.0 + frac
        coeff = (1.0 - frac) / denom if denom != 0.0 else 0.0
        ap_y = coeff * delayed + self._ap_x_prev - coeff * self._ap_y_prev
        self._ap_x_prev = delayed
        self._ap_y_prev = ap_y

        # Bore onepole damping (low-Q in-loop -- phase delay compensation
        # appropriate per memory feedback_waveguide_loop_phase_comp.md).
        b = max(0.0, min(0.999, 1.0 - bore_damp))
        self._bore_lp = b * self._bore_lp + (1.0 - b) * ap_y
        cone_return = -cone_loss * self._bore_lp

        # McIntyre-Woodhouse rectified reed (bassoon.gendsp verbatim).
        # T-04: clamp delta_p prevents reed flow from diverging.
        delta_p = max(0.0, min(1.0, breath - cone_return + reed_aper))
        reed_ratio = delta_p * (1.0 / 0.85)
        reed_opening = max(0.0, 1.0 - reed_ratio * reed_ratio)
        reed_flow = delta_p * math.sqrt(reed_opening)
        stiff_gain = 0.75 - reed_stiff * 0.45
        reed_sig = reed_flow * stiff_gain

        # Inject reed signal + cone return into bore
        bore_in = reed_sig + cone_return
        self._buffer[self._wi] = bore_in
        self._wi = (self._wi + 1) % _BORE_BUFFER_SIZE

        return reed_sig + cone_return  # bore_only-like output, no radiation
