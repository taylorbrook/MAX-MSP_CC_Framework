"""Bore-only passive waveguide topology.

Mirrors the bore loop from patches/bassoon-model/generated/bassoon.gendsp:
  - Data bore(8192)              -> np.zeros(8192) circular buffer
  - History bore_lp(0)           -> _bore_lp scalar (onepole filter state)
  - History ap_x_prev/ap_y_prev  -> allpass-interpolation state
  - cone_loss = 0.85             -> per-roundtrip attenuation

Used as a sanity-check structure: should oscillate when fed a periodic
excitation, used in unit tests to validate the simulator harness on a
known-stable shape. Per CONTEXT.md D-01 curated catalog.

Per CLAUDE.md "Gen~ (GenExpr DSP Code)" mapping:
  History x   -> scalar `_x` field, field(init=False, default=0.0)
  Data buf(N) -> np.zeros(N) + `_wi` write index
  Delay.read  -> indexed read with mod-arithmetic on the buffer
"""

from __future__ import annotations

from dataclasses import dataclass, field

import numpy as np


_BORE_BUFFER_SIZE = 8192


@dataclass
class BoreOnly:
    """Passive bore waveguide. step(in1, in2) -> output sample.

    Args:
        sample_rate: Sample rate in Hz (typically 44100).
        params: Param dict accepting `freq`, `bore_damp`, `cone_loss` (defaults
            to bassoon.gendsp values when missing).

    Attributes:
        _buffer: Circular delay buffer (numpy float64).
        _wi: Write index into _buffer.
        _bore_lp: Onepole low-pass state (analog of `History bore_lp`).
        _ap_x_prev / _ap_y_prev: Allpass-interpolation state.
    """

    sample_rate: float
    params: dict[str, float]
    _buffer: np.ndarray = field(init=False)
    _wi: int = field(init=False, default=0)
    _bore_lp: float = field(init=False, default=0.0)
    _ap_x_prev: float = field(init=False, default=0.0)
    _ap_y_prev: float = field(init=False, default=0.0)

    def __post_init__(self) -> None:
        self._buffer = np.zeros(_BORE_BUFFER_SIZE, dtype=np.float64)

    def step(self, in1: float, in2: float) -> float:
        """One sample of passive bore loop.

        in1 = freq Hz (drives delay-line length).
        in2 = excitation amplitude (constant pressure-equivalent input).
        """
        freq = max(20.0, float(in1))
        cone_loss = float(self.params.get("cone_loss", 0.85))
        bore_damp = float(self.params.get("bore_damp", 0.3))

        # Delay-line length in samples (round-trip period from freq).
        # T-04 mitigation: clamp delay_samples below buffer size to prevent
        # any unbounded indexing into the numpy buffer.
        period = self.sample_rate / freq
        delay_samples = period * 0.5  # half-period for a closed-open bore
        if delay_samples >= _BORE_BUFFER_SIZE - 1:
            delay_samples = _BORE_BUFFER_SIZE - 2
        if delay_samples < 2.0:
            delay_samples = 2.0
        int_delay = int(delay_samples)
        frac = delay_samples - int_delay

        # Read delayed sample
        ri = (self._wi - int_delay) % _BORE_BUFFER_SIZE
        delayed = float(self._buffer[ri])

        # First-order allpass for fractional delay (Steiglitz form)
        denom = 1.0 + frac
        coeff = (1.0 - frac) / denom if denom != 0.0 else 0.0
        ap_y = coeff * delayed + self._ap_x_prev - coeff * self._ap_y_prev
        self._ap_x_prev = delayed
        self._ap_y_prev = ap_y

        # Onepole low-pass (bore damping) -- analog of `History bore_lp`.
        # bore_damp=0 -> b=1 (pass-through), bore_damp=1 -> b=0 (full LPF).
        b = max(0.0, min(0.999, 1.0 - bore_damp))
        self._bore_lp = b * self._bore_lp + (1.0 - b) * ap_y
        damped = self._bore_lp

        # Reflection with cone_loss attenuation, summed with excitation
        reflected = -cone_loss * damped
        new_in = float(in2) + reflected

        # Write back to delay buffer
        self._buffer[self._wi] = new_in
        self._wi = (self._wi + 1) % _BORE_BUFFER_SIZE

        return damped
