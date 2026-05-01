"""Reed + bore + post-radiation waveguide topology (v0.4.2+ bassoon shape).

Mirrors patches/bassoon-model/generated/bassoon.gendsp at version 0.4.2+:
  - In-loop:    bore delay + onepole bore_damp (low-Q, phase-delay
                compensation appropriate)
  - POST-LOOP:  body formant peaking EQ (fixed +6 dB @500 Hz, Q=3)
                bell radiation LPF (variable cutoff via bell_bright)
                reed BPF resonance (reed_res_freq, reed_res_q) -- v0.5.1+
  - Register input scales reed_aper above the loop closure.

The v0.4.0 (group-delay compensation) and v0.4.1 (in-loop bell biquad)
regressions are reproduced by mirrors in tests/dsp_sim/fixtures/, NOT here.
This topology is the canonical PASSING shape -- the live bassoon test
(tests/dsp_sim/test_bassoon-model.py) gates against it.

Per CLAUDE.md "Gen~ (GenExpr DSP Code)" Gen~ -> numpy mapping.
Per CONTEXT.md D-01 (curated catalog), D-06 (bassoon shape covered here).
Per memory feedback_waveguide_loop_phase_comp.md: Q > ~1 filters MUST be
post-loop; only low-Q in-loop filters need phase-delay compensation.

T-04 mitigation: all post-loop biquad coefficients computed from clamped
inputs (bell_bright in [0,1], reed_res_q >= 0.1); reed math saturates via
clamp on delta_p; cannot diverge unboundedly.
"""

from __future__ import annotations

import math
from dataclasses import dataclass, field

import numpy as np


_BORE_BUFFER_SIZE = 8192


@dataclass
class ReedBorePostRadiation:
    """Reed + bore + post-radiation chain. Bell + reed BPF live POST-LOOP.

    Args:
        sample_rate: Sample rate in Hz.
        params: Accepts freq, breath, bore_damp, bell_bright, reed_stiff,
            reed_aper, reed_res_freq, reed_res_q, register, cone_loss.

    Attributes:
        Loop state: _buffer, _wi, _bore_lp, _ap_x_prev, _ap_y_prev, _breath_smooth.
        Body formant biquad state (post-loop): _bf_x1, _bf_x2, _bf_y1, _bf_y2.
        Bell LPF biquad state (post-loop): _bell_x1, _bell_x2, _bell_y1, _bell_y2.
        Reed BPF state (post-loop): _reed_x1, _reed_x2, _reed_y1, _reed_y2.
    """

    sample_rate: float
    params: dict[str, float]
    _buffer: np.ndarray = field(init=False)
    _wi: int = field(init=False, default=0)
    _bore_lp: float = field(init=False, default=0.0)
    _ap_x_prev: float = field(init=False, default=0.0)
    _ap_y_prev: float = field(init=False, default=0.0)
    _breath_smooth: float = field(init=False, default=0.0)
    # Body formant biquad coefficients (computed once in __post_init__)
    _bf_b0: float = field(init=False, default=0.0)
    _bf_b1: float = field(init=False, default=0.0)
    _bf_b2: float = field(init=False, default=0.0)
    _bf_a1: float = field(init=False, default=0.0)
    _bf_a2: float = field(init=False, default=0.0)
    _bf_x1: float = field(init=False, default=0.0)
    _bf_x2: float = field(init=False, default=0.0)
    _bf_y1: float = field(init=False, default=0.0)
    _bf_y2: float = field(init=False, default=0.0)
    # Bell LPF biquad state (coefficients recomputed per step from bell_bright)
    _bell_x1: float = field(init=False, default=0.0)
    _bell_x2: float = field(init=False, default=0.0)
    _bell_y1: float = field(init=False, default=0.0)
    _bell_y2: float = field(init=False, default=0.0)
    # Reed BPF state
    _reed_x1: float = field(init=False, default=0.0)
    _reed_x2: float = field(init=False, default=0.0)
    _reed_y1: float = field(init=False, default=0.0)
    _reed_y2: float = field(init=False, default=0.0)

    def __post_init__(self) -> None:
        self._buffer = np.zeros(_BORE_BUFFER_SIZE, dtype=np.float64)
        # Body formant: peaking EQ +6 dB @500 Hz, Q=3 (RBJ formulae).
        # Coefficients are fixed by the model (not user-tweakable), so compute once.
        bf_freq = 500.0
        bf_gain_db = 6.0
        bf_q = 3.0
        A = 10.0 ** (bf_gain_db / 40.0)
        w0 = 2.0 * math.pi * bf_freq / self.sample_rate
        alpha = math.sin(w0) / (2.0 * bf_q)
        cos_w0 = math.cos(w0)
        b0 = 1.0 + alpha * A
        b1 = -2.0 * cos_w0
        b2 = 1.0 - alpha * A
        a0 = 1.0 + alpha / A
        a1 = -2.0 * cos_w0
        a2 = 1.0 - alpha / A
        self._bf_b0 = b0 / a0
        self._bf_b1 = b1 / a0
        self._bf_b2 = b2 / a0
        self._bf_a1 = a1 / a0
        self._bf_a2 = a2 / a0

    def step(self, in1: float, in2: float) -> float:
        """One sample of v0.4.2+ bassoon shape. in1=freq Hz, in2=breath 0..1."""
        freq = max(20.0, float(in1))
        breath_in = float(in2)
        bore_damp = float(self.params.get("bore_damp", 0.3))
        bell_bright = float(self.params.get("bell_bright", 0.5))
        reed_stiff = float(self.params.get("reed_stiff", 0.5))
        reed_aper = float(self.params.get("reed_aper", 0.0))
        cone_loss = float(self.params.get("cone_loss", 0.85))
        register = float(self.params.get("register", 0.0))
        reed_res_freq = float(self.params.get("reed_res_freq", 1500.0))
        # T-04: reed_res_q clamped >= 0.1 to avoid biquad coefficient blowup.
        reed_res_q = float(self.params.get("reed_res_q", 0.7071068))

        # ---- Loop body (low-Q in-loop only) ----
        smooth_coef = 0.999
        self._breath_smooth = (
            smooth_coef * self._breath_smooth + (1.0 - smooth_coef) * breath_in
        )
        breath = self._breath_smooth

        period = self.sample_rate / freq
        delay_samples = max(2.0, period * 0.5)
        if delay_samples >= _BORE_BUFFER_SIZE - 1:
            delay_samples = _BORE_BUFFER_SIZE - 2
        int_delay = int(delay_samples)
        frac = delay_samples - int_delay
        ri = (self._wi - int_delay) % _BORE_BUFFER_SIZE
        delayed = float(self._buffer[ri])

        denom_ap = 1.0 + frac
        coeff = (1.0 - frac) / denom_ap if denom_ap != 0.0 else 0.0
        ap_y = coeff * delayed + self._ap_x_prev - coeff * self._ap_y_prev
        self._ap_x_prev = delayed
        self._ap_y_prev = ap_y

        b = max(0.0, min(0.999, 1.0 - bore_damp))
        self._bore_lp = b * self._bore_lp + (1.0 - b) * ap_y
        cone_return = -cone_loss * self._bore_lp

        # McIntyre-Woodhouse rectified reed (bassoon.gendsp verbatim).
        # T-04: clamp delta_p prevents reed flow from diverging.
        delta_p = max(
            0.0, min(1.0, breath - cone_return + reed_aper + register * 0.1)
        )
        reed_ratio = delta_p * (1.0 / 0.85)
        reed_opening = max(0.0, 1.0 - reed_ratio * reed_ratio)
        reed_flow = delta_p * math.sqrt(reed_opening)
        stiff_gain = 0.75 - reed_stiff * 0.45
        reed_sig = reed_flow * stiff_gain

        bore_in = reed_sig + cone_return
        self._buffer[self._wi] = bore_in
        self._wi = (self._wi + 1) % _BORE_BUFFER_SIZE
        loop_out = reed_sig + cone_return

        # ---- POST-LOOP radiation chain (v0.4.2+ fix: biquads OUTSIDE the loop) ----
        # Stage 1: body formant peaking EQ (+6 dB @500 Hz, Q=3, RBJ form).
        bf_out = (
            self._bf_b0 * loop_out
            + self._bf_b1 * self._bf_x1
            + self._bf_b2 * self._bf_x2
            - self._bf_a1 * self._bf_y1
            - self._bf_a2 * self._bf_y2
        )
        self._bf_x2 = self._bf_x1
        self._bf_x1 = loop_out
        self._bf_y2 = self._bf_y1
        self._bf_y1 = bf_out

        # Stage 2: bell radiation LPF (variable cutoff via bell_bright; RBJ
        # Butterworth Q=0.7071). Coefficients recomputed per sample because
        # bell_bright is the swept Param in the bassoon test.
        # T-04: clamp bell_bright into [0,1] before computing fc.
        bb_clamped = max(0.0, min(1.0, bell_bright))
        bell_freq = 800.0 + 5000.0 * bb_clamped
        w0b = 2.0 * math.pi * bell_freq / self.sample_rate
        alpha_b = math.sin(w0b) / (2.0 * 0.7071068)
        cos_w0b = math.cos(w0b)
        a0b = 1.0 + alpha_b
        b0b = (1.0 - cos_w0b) * 0.5 / a0b
        b1b = (1.0 - cos_w0b) / a0b
        b2b = (1.0 - cos_w0b) * 0.5 / a0b
        a1b = -2.0 * cos_w0b / a0b
        a2b = (1.0 - alpha_b) / a0b
        bell_out = (
            b0b * bf_out
            + b1b * self._bell_x1
            + b2b * self._bell_x2
            - a1b * self._bell_y1
            - a2b * self._bell_y2
        )
        self._bell_x2 = self._bell_x1
        self._bell_x1 = bf_out
        self._bell_y2 = self._bell_y1
        self._bell_y1 = bell_out

        # Stage 3: reed BPF (post-loop per v0.5.1 fix). RBJ bandpass with
        # constant skirt gain. Q ~ 0.7 default means it's effectively flat.
        # T-04: clamp reed_res_q >= 0.1.
        rrq = max(0.1, reed_res_q)
        w0r = 2.0 * math.pi * max(20.0, reed_res_freq) / self.sample_rate
        alpha_r = math.sin(w0r) / (2.0 * rrq)
        cos_w0r = math.cos(w0r)
        a0r = 1.0 + alpha_r
        b0r = alpha_r / a0r
        b1r = 0.0
        b2r = -alpha_r / a0r
        a1r = -2.0 * cos_w0r / a0r
        a2r = (1.0 - alpha_r) / a0r
        reed_out = (
            b0r * bell_out
            + b1r * self._reed_x1
            + b2r * self._reed_x2
            - a1r * self._reed_y1
            - a2r * self._reed_y2
        )
        self._reed_x2 = self._reed_x1
        self._reed_x1 = bell_out
        self._reed_y2 = self._reed_y1
        self._reed_y1 = reed_out

        # Mix reed BPF emphasis with the dry post-bell signal (typical
        # post-loop blend; reed BPF colors timbre without participating in
        # the loop's feedback per memory feedback_waveguide_loop_phase_comp.md).
        out = 0.7 * bell_out + 0.3 * reed_out
        return out * 0.25  # final attenuation matching bassoon.gendsp `out1 = rad_out * 0.25`
