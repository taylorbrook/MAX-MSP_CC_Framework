#!/usr/bin/env python3
"""Render O-IntonationPad wavetable banks to float32 WAV for buffer~ loading.

Verbatim port of the VST's WavetableData.h generation math
(plugins/O-IntonationPad, v2.8.4):

- 256 frames x 2048 samples x 11 mipmap levels per bank
- Partial recipe per bank: (ratio, fadeInStart, fadeInEnd, maxAmp, phaseOffset)
- sin^2 fade curve by frame position (calculateFade)
- Partial excluded from a mipmap level when
  mipmapBaseFreqs[level] * 2 * ratio > 0.9 * NYQUIST  (ASSUMED_SAMPLE_RATE 48000)
- Per-sample normalization by 1 / max(totalAmplitude, 1)

Output layout (one mono file per bank, mipmaps concatenated):
    sample_index = mip * (256 * 2048) + frame * 2048 + sample
    total = 11 * 256 * 2048 = 5,767,168 samples (~23 MB float32)

Usage:
    python3 render_wavetables.py               # render bank 0 to ../generated/
    python3 render_wavetables.py 0 1 4        # render selected banks
    python3 render_wavetables.py --all        # render all 20 banks
"""

from __future__ import annotations

import struct
import sys
from pathlib import Path

import numpy as np

NUM_FRAMES = 256
SAMPLES_PER_FRAME = 2048
NUM_MIPMAPS = 11
ASSUMED_SAMPLE_RATE = 48000.0
NYQUIST = ASSUMED_SAMPLE_RATE / 2.0
PI = np.pi

MIPMAP_BASE_FREQS = [20.0, 40.0, 80.0, 160.0, 320.0, 640.0,
                     1280.0, 2560.0, 5120.0, 10240.0, 20480.0]

# ---------------------------------------------------------------------------
# Bank partial recipes — (ratio, fadeInStart, fadeInEnd, maxAmp, phaseOffset)
# Transcribed verbatim from WavetableData.h.
# ---------------------------------------------------------------------------

BANKS: list[tuple[str, list[tuple[float, float, float, float, float]]]] = [
    ("ji-harmonic", [
        (1.0,      0.00, 0.00, 1.00, 0.0),
        (2.0,      0.05, 0.25, 0.70, 0.0),
        (1.5,      0.10, 0.35, 0.50, 0.0),
        (1.25,     0.15, 0.40, 0.40, 0.0),
        (3.0,      0.25, 0.50, 0.35, 0.0),
        (2.5,      0.30, 0.55, 0.30, 0.0),
        (4.0,      0.35, 0.60, 0.25, 0.0),
        (1.875,    0.40, 0.65, 0.20, 0.0),
        (1.2,      0.50, 0.75, 0.18, 0.0),
        (5.0,      0.55, 0.80, 0.15, 0.0),
        (6.0,      0.65, 0.85, 0.12, 0.0),
        (1.666667, 0.70, 0.90, 0.10, 0.0),
    ]),
    ("warm-analog", [
        (1.0,  0.00, 0.00, 1.00, 0.0),
        (2.0,  0.03, 0.15, 0.50, 0.0),
        (3.0,  0.08, 0.25, 0.33, 0.0),
        (4.0,  0.12, 0.30, 0.25, 0.0),
        (5.0,  0.18, 0.40, 0.20, 0.0),
        (6.0,  0.25, 0.45, 0.16, 0.0),
        (7.0,  0.30, 0.50, 0.14, 0.0),
        (8.0,  0.38, 0.55, 0.12, 0.0),
        (9.0,  0.45, 0.65, 0.10, 0.0),
        (10.0, 0.52, 0.72, 0.08, 0.0),
        (11.0, 0.60, 0.80, 0.06, 0.0),
        (12.0, 0.70, 0.90, 0.05, 0.0),
    ]),
    ("choir", [
        (1.0,    0.00, 0.00, 1.00, 0.0),
        (1.003,  0.02, 0.08, 0.80, 1.2),
        (0.997,  0.02, 0.08, 0.80, 2.5),
        (2.0,    0.04, 0.15, 0.50, 0.4),
        (2.005,  0.06, 0.18, 0.40, 1.8),
        (3.0,    0.08, 0.22, 0.75, 0.7),
        (4.0,    0.12, 0.30, 0.25, 1.5),
        (5.0,    0.16, 0.35, 0.65, 2.2),
        (6.0,    0.20, 0.40, 0.70, 0.3),
        (7.0,    0.28, 0.48, 0.20, 1.9),
        (8.0,    0.35, 0.55, 0.18, 2.8),
        (9.0,    0.40, 0.60, 0.45, 0.6),
        (10.0,   0.45, 0.65, 0.50, 3.1),
        (12.0,   0.55, 0.75, 0.35, 1.4),
        (14.0,   0.62, 0.82, 0.20, 2.0),
        (16.0,   0.72, 0.90, 0.10, 0.9),
    ]),
    ("strings", [
        (1.0,  0.00, 0.00, 1.00, 0.0),
        (2.0,  0.04, 0.18, 0.55, 0.0),
        (3.0,  0.08, 0.22, 0.40, 0.0),
        (4.0,  0.12, 0.28, 0.30, 0.0),
        (5.0,  0.16, 0.35, 0.24, 0.0),
        (6.0,  0.22, 0.42, 0.20, 0.0),
        (7.0,  0.28, 0.50, 0.17, 0.0),
        (8.0,  0.35, 0.58, 0.14, 0.0),
        (9.0,  0.42, 0.65, 0.11, 0.0),
        (10.0, 0.50, 0.72, 0.09, 0.0),
        (11.0, 0.58, 0.80, 0.07, 0.0),
        (12.0, 0.66, 0.88, 0.05, 0.0),
    ]),
    ("glass", [
        (1.0,    0.00, 0.00, 1.00, 0.0),
        (2.76,   0.05, 0.20, 0.55, 0.0),
        (5.404,  0.10, 0.30, 0.40, 0.0),
        (8.933,  0.18, 0.40, 0.25, 0.0),
        (1.506,  0.25, 0.45, 0.45, 0.0),
        (3.516,  0.32, 0.52, 0.30, 0.0),
        (6.684,  0.40, 0.62, 0.20, 0.0),
        (2.0,    0.15, 0.35, 0.35, 0.0),
        (4.0,    0.48, 0.68, 0.18, 0.0),
        (11.34,  0.55, 0.75, 0.12, 0.0),
        (7.21,   0.62, 0.82, 0.10, 0.0),
        (14.07,  0.70, 0.90, 0.06, 0.0),
    ]),
    ("evolving", [
        (1.0,   0.00, 0.00, 1.00, 0.0),
        (1.5,   0.02, 0.12, 0.50, 0.0),
        (3.0,   0.05, 0.20, 0.35, 0.0),
        (2.0,   0.25, 0.45, 0.55, 0.0),
        (5.0,   0.20, 0.40, 0.30, 0.0),
        (4.0,   0.40, 0.60, 0.40, 0.0),
        (7.0,   0.35, 0.55, 0.20, 0.0),
        (6.0,   0.55, 0.75, 0.25, 0.0),
        (8.0,   0.60, 0.80, 0.18, 0.0),
        (1.25,  0.50, 0.70, 0.30, 0.0),
        (10.0,  0.70, 0.88, 0.12, 0.0),
        (9.0,   0.75, 0.92, 0.10, 0.0),
    ]),
    ("organ", [
        (1.0,  0.00, 0.00, 1.00, 0.0),
        (2.0,  0.03, 0.12, 0.70, 0.0),
        (3.0,  0.08, 0.20, 0.55, 0.0),
        (4.0,  0.14, 0.28, 0.50, 0.0),
        (5.0,  0.20, 0.38, 0.35, 0.0),
        (6.0,  0.28, 0.45, 0.30, 0.0),
        (8.0,  0.35, 0.52, 0.25, 0.0),
        (0.5,  0.40, 0.58, 0.45, 0.0),
        (10.0, 0.48, 0.68, 0.15, 0.0),
        (12.0, 0.55, 0.75, 0.12, 0.0),
        (16.0, 0.65, 0.85, 0.08, 0.0),
        (0.25, 0.72, 0.90, 0.20, 0.0),
    ]),
    ("ethereal", [
        (1.0,   0.00, 0.00, 1.00, 0.0),
        (2.0,   0.05, 0.20, 0.40, 0.0),
        (3.0,   0.15, 0.35, 0.25, 0.0),
        (4.0,   0.30, 0.55, 0.15, 0.0),
        (1.498, 0.08, 0.28, 0.50, 0.0),
        (2.003, 0.10, 0.30, 0.30, 0.0),
        (5.0,   0.40, 0.65, 0.10, 0.0),
        (3.003, 0.45, 0.70, 0.12, 0.0),
        (6.0,   0.55, 0.78, 0.08, 0.0),
        (8.0,   0.65, 0.85, 0.06, 0.0),
        (0.999, 0.20, 0.50, 0.15, 0.0),
        (1.001, 0.22, 0.52, 0.15, 0.0),
    ]),
    ("dark-matter", [
        (1.0,   0.00, 0.00, 1.00, 0.0),
        (0.5,   0.03, 0.15, 0.80, 0.0),
        (0.25,  0.08, 0.25, 0.50, 0.0),
        (2.0,   0.15, 0.35, 0.30, 0.0),
        (0.333, 0.20, 0.40, 0.35, 0.0),
        (1.5,   0.30, 0.50, 0.20, 0.0),
        (3.0,   0.45, 0.65, 0.12, 0.0),
        (0.75,  0.35, 0.55, 0.25, 0.0),
        (4.0,   0.60, 0.80, 0.08, 0.0),
        (0.667, 0.50, 0.72, 0.18, 0.0),
        (5.0,   0.72, 0.90, 0.05, 0.0),
        (0.125, 0.40, 0.65, 0.25, 0.0),
    ]),
    ("sine", [
        (1.0, 0.00, 0.00, 1.00, 0.0),
    ]),
    ("square", [
        (1.0,  0.00, 0.00, 1.0000, 0.0),
        (3.0,  0.05, 0.20, 0.3333, 0.0),
        (5.0,  0.10, 0.30, 0.2000, 0.0),
        (7.0,  0.15, 0.40, 0.1429, 0.0),
        (9.0,  0.20, 0.50, 0.1111, 0.0),
        (11.0, 0.28, 0.58, 0.0909, 0.0),
        (13.0, 0.35, 0.65, 0.0769, 0.0),
        (15.0, 0.42, 0.72, 0.0667, 0.0),
        (17.0, 0.50, 0.78, 0.0588, 0.0),
        (19.0, 0.55, 0.82, 0.0526, 0.0),
        (21.0, 0.62, 0.87, 0.0476, 0.0),
        (23.0, 0.70, 0.92, 0.0435, 0.0),
    ]),
    ("triangle", [
        (1.0,  0.00, 0.00, 1.0000, 0.0),
        (3.0,  0.05, 0.20, 0.1111, PI),
        (5.0,  0.12, 0.32, 0.0400, 0.0),
        (7.0,  0.20, 0.45, 0.0204, PI),
        (9.0,  0.30, 0.55, 0.0123, 0.0),
        (11.0, 0.42, 0.68, 0.0083, PI),
        (13.0, 0.55, 0.78, 0.0059, 0.0),
        (15.0, 0.65, 0.88, 0.0044, PI),
    ]),
    ("spectral-cloud", [
        (1.0,    0.00, 0.00, 1.00, 0.0),
        (1.003,  0.02, 0.10, 0.70, 1.2),
        (0.997,  0.02, 0.10, 0.70, 2.8),
        (2.0,    0.05, 0.20, 0.45, 0.5),
        (2.01,   0.08, 0.25, 0.40, 1.9),
        (1.498,  0.10, 0.30, 0.50, 3.1),
        (1.503,  0.10, 0.30, 0.50, 0.7),
        (3.0,    0.15, 0.35, 0.30, 2.2),
        (0.5,    0.20, 0.40, 0.55, 1.4),
        (4.0,    0.25, 0.50, 0.20, 0.3),
        (2.5,    0.30, 0.55, 0.25, 2.6),
        (1.333,  0.35, 0.60, 0.30, 1.8),
        (5.0,    0.45, 0.70, 0.15, 3.4),
        (3.5,    0.50, 0.75, 0.18, 0.9),
        (6.0,    0.60, 0.82, 0.10, 2.0),
        (7.01,   0.70, 0.90, 0.08, 1.1),
    ]),
    ("metallic-resonance", [
        (1.0,    0.00, 0.00, 1.00, 0.0),
        (1.593,  0.05, 0.18, 0.65, 0.8),
        (2.136,  0.10, 0.28, 0.50, 1.6),
        (2.296,  0.08, 0.22, 0.55, 2.4),
        (2.653,  0.15, 0.35, 0.40, 0.4),
        (3.156,  0.22, 0.45, 0.30, 3.0),
        (3.501,  0.30, 0.55, 0.25, 1.2),
        (4.059,  0.38, 0.62, 0.18, 2.0),
        (4.601,  0.48, 0.72, 0.12, 0.6),
        (5.132,  0.55, 0.78, 0.10, 2.8),
        (5.406,  0.65, 0.85, 0.08, 1.4),
        (6.345,  0.72, 0.92, 0.05, 3.2),
    ]),
    ("formant-vowel", [
        (1.0,   0.00, 0.00, 1.00, 0.0),
        (2.0,   0.00, 0.00, 0.75, 0.0),
        (3.0,   0.00, 0.08, 0.60, 0.0),
        (4.0,   0.05, 0.18, 0.45, 0.0),
        (5.0,   0.16, 0.32, 0.55, 0.0),
        (6.0,   0.24, 0.42, 0.65, 0.0),
        (7.0,   0.34, 0.52, 0.40, 0.0),
        (8.0,   0.44, 0.62, 0.30, 0.0),
        (9.0,   0.48, 0.65, 0.55, 0.0),
        (10.0,  0.56, 0.74, 0.25, 0.0),
        (11.0,  0.66, 0.82, 0.18, 0.0),
        (12.0,  0.76, 0.92, 0.10, 0.0),
    ]),
    ("warm-sub", [
        (1.0,    0.00, 0.00, 1.00, 0.0),
        (0.5,    0.00, 0.00, 0.85, 0.0),
        (0.25,   0.05, 0.15, 0.50, 0.0),
        (0.333,  0.08, 0.22, 0.40, 0.0),
        (0.75,   0.10, 0.25, 0.35, 0.0),
        (1.5,    0.20, 0.40, 0.25, 0.0),
        (2.0,    0.30, 0.50, 0.30, 0.0),
        (3.0,    0.42, 0.62, 0.18, 0.0),
        (4.0,    0.55, 0.75, 0.12, 0.0),
        (5.0,    0.68, 0.88, 0.06, 0.0),
    ]),
    ("soft-flute", [
        (1.0,   0.00, 0.00, 1.00, 0.0),
        (2.0,   0.08, 0.25, 0.25, 0.0),
        (3.0,   0.12, 0.35, 0.15, 0.0),
        (4.0,   0.25, 0.50, 0.08, 0.0),
        (5.0,   0.40, 0.65, 0.05, 0.0),
        (1.002, 0.05, 0.18, 0.20, 1.5),
        (0.998, 0.05, 0.18, 0.20, 2.8),
        (6.0,   0.55, 0.78, 0.03, 0.0),
        (2.003, 0.15, 0.38, 0.12, 0.9),
        (7.0,   0.65, 0.88, 0.02, 0.0),
    ]),
    ("velvet-pad", [
        (1.0,   0.00, 0.00, 1.00, 0.0),
        (2.0,   0.03, 0.15, 0.60, 0.0),
        (4.0,   0.08, 0.25, 0.35, 0.0),
        (6.0,   0.15, 0.38, 0.20, 0.0),
        (8.0,   0.25, 0.48, 0.12, 0.0),
        (3.0,   0.30, 0.55, 0.10, 0.0),
        (10.0,  0.40, 0.65, 0.06, 0.0),
        (5.0,   0.45, 0.68, 0.05, 0.0),
        (12.0,  0.55, 0.78, 0.03, 0.0),
        (0.5,   0.20, 0.42, 0.30, 0.0),
    ]),
    ("whisper", [
        (1.0,    0.00, 0.00, 0.80, 0.0),
        (1.004,  0.02, 0.08, 0.65, 1.3),
        (0.996,  0.02, 0.08, 0.65, 2.7),
        (2.0,    0.10, 0.30, 0.20, 0.0),
        (2.007,  0.12, 0.32, 0.18, 1.8),
        (1.997,  0.12, 0.32, 0.18, 3.1),
        (1.5,    0.20, 0.45, 0.15, 0.5),
        (1.502,  0.22, 0.48, 0.12, 2.2),
        (3.0,    0.35, 0.60, 0.08, 0.0),
        (3.005,  0.38, 0.62, 0.06, 1.0),
        (4.0,    0.50, 0.75, 0.04, 0.0),
        (0.5,    0.15, 0.40, 0.25, 0.0),
        (5.0,    0.60, 0.82, 0.03, 0.0),
        (1.333,  0.45, 0.70, 0.06, 1.6),
    ]),
    ("deep-haze", [
        (1.0,    0.00, 0.00, 1.00, 0.0),
        (0.5,    0.00, 0.00, 0.75, 0.0),
        (0.25,   0.05, 0.20, 0.45, 0.0),
        (2.0,    0.20, 0.50, 0.30, 0.0),
        (0.75,   0.08, 0.28, 0.35, 0.0),
        (1.5,    0.30, 0.58, 0.20, 0.0),
        (3.0,    0.45, 0.72, 0.10, 0.0),
        (0.333,  0.12, 0.35, 0.30, 0.0),
        (4.0,    0.60, 0.82, 0.05, 0.0),
        (1.001,  0.10, 0.30, 0.15, 1.4),
        (0.999,  0.10, 0.30, 0.15, 2.6),
        (2.0,    0.55, 0.78, 0.08, 1.0),
    ]),
]

AMP_EPSILON = 0.0001  # amplitude gate from generateFrame()


def calculate_fade(frame_pos: np.ndarray, fade_start: float, fade_end: float) -> np.ndarray:
    """Vectorized port of calculateFade — sin^2 ramp between fadeStart and fadeEnd."""
    if fade_start >= fade_end:
        return np.ones_like(frame_pos)
    t = np.clip((frame_pos - fade_start) / (fade_end - fade_start), 0.0, 1.0)
    s = np.sin(t * PI * 0.5)
    out = s * s
    out[frame_pos <= fade_start] = 0.0
    out[frame_pos >= fade_end] = 1.0
    return out


def partial_would_alias(ratio: float, mipmap_level: int) -> bool:
    max_fundamental = MIPMAP_BASE_FREQS[mipmap_level] * 2.0
    return max_fundamental * ratio > NYQUIST * 0.9


def render_bank(bank_index: int) -> np.ndarray:
    """Render one bank to a flat float32 array: [mip][frame][sample] concatenated."""
    _, partials = BANKS[bank_index]
    frame_pos = np.arange(NUM_FRAMES, dtype=np.float64) / (NUM_FRAMES - 1)
    phase = np.arange(SAMPLES_PER_FRAME, dtype=np.float64) / SAMPLES_PER_FRAME

    out = np.zeros((NUM_MIPMAPS, NUM_FRAMES, SAMPLES_PER_FRAME), dtype=np.float32)

    for mip in range(NUM_MIPMAPS):
        active = [p for p in partials if not partial_would_alias(p[0], mip)]
        if not active:
            continue  # all partials alias — level stays silent (VST behavior)

        # amps: (frames, partials); sines: (partials, samples)
        amps = np.stack([
            max_amp * calculate_fade(frame_pos, fs, fe)
            for (_, fs, fe, max_amp, _) in active
        ], axis=1)
        sines = np.stack([
            np.sin(phase * 2.0 * PI * ratio + ph_off)
            for (ratio, _, _, _, ph_off) in active
        ], axis=0)

        # generateFrame gates each partial on amplitude > 0.0001 before summing
        # into both the sample value and totalAmplitude
        gated = np.where(amps > AMP_EPSILON, amps, 0.0)
        total_amp = gated.sum(axis=1)                       # (frames,)
        values = gated @ sines                              # (frames, samples)
        norm = np.where(total_amp > 0.0, 1.0 / np.maximum(total_amp, 1.0), 1.0)
        out[mip] = (values * norm[:, None]).astype(np.float32)

    return out.reshape(-1)


def write_float32_wav(path: Path, data: np.ndarray, sample_rate: int = 48000) -> None:
    """Write mono float32 WAV (format 3, IEEE float) without scipy."""
    payload = data.astype("<f4").tobytes()
    n = len(payload)
    header = b"RIFF" + struct.pack("<I", 4 + 26 + 12 + 8 + n) + b"WAVE"
    # fmt chunk (18 bytes, cbSize=0) + fact chunk (required for non-PCM)
    fmt = struct.pack("<HHIIHHH", 3, 1, sample_rate, sample_rate * 4, 4, 32, 0)
    fact = struct.pack("<I", len(data))
    with open(path, "wb") as f:
        f.write(header)
        f.write(b"fmt " + struct.pack("<I", len(fmt)) + fmt)
        f.write(b"fact" + struct.pack("<I", len(fact)) + fact)
        f.write(b"data" + struct.pack("<I", n) + payload)


def sanity_check(bank_index: int, flat: np.ndarray) -> list[str]:
    """Verify frame 0 ≈ sine on levels where the fundamental survives."""
    name, partials = BANKS[bank_index]
    report = []
    table = flat.reshape(NUM_MIPMAPS, NUM_FRAMES, SAMPLES_PER_FRAME)
    ref_sine = np.sin(np.arange(SAMPLES_PER_FRAME) / SAMPLES_PER_FRAME * 2 * PI)
    for mip in range(NUM_MIPMAPS):
        frame0 = table[mip, 0]
        rms = float(np.sqrt(np.mean(frame0 ** 2)))
        if partial_would_alias(1.0, mip):
            status = "silent (fundamental aliases)" if rms < 1e-9 else f"UNEXPECTED rms={rms:.4f}"
        else:
            # frame 0: only partials with fadeStart>=fadeEnd contribute
            always_on = [p for p in partials
                         if p[1] >= p[2] and not partial_would_alias(p[0], mip)]
            if len(always_on) == 1 and always_on[0][0] == 1.0:
                err = float(np.max(np.abs(frame0 - ref_sine * always_on[0][3])))
                status = f"sine ok (max err {err:.2e})" if err < 1e-5 else f"SINE MISMATCH err={err:.4f}"
            else:
                status = f"rms={rms:.4f} ({len(always_on)} always-on partials)"
        report.append(f"  mip {mip:2d} (base {MIPMAP_BASE_FREQS[mip]:7.1f} Hz): {status}")
    peak = float(np.max(np.abs(flat)))
    report.append(f"  peak amplitude: {peak:.4f}")
    return report


def main() -> None:
    out_dir = Path(__file__).resolve().parent.parent / "generated"
    args = sys.argv[1:]
    if "--all" in args:
        indices = list(range(len(BANKS)))
    elif args:
        indices = [int(a) for a in args]
    else:
        indices = [0]

    for idx in indices:
        name, _ = BANKS[idx]
        flat = render_bank(idx)
        path = out_dir / f"bank{idx:02d}-{name}.wav"
        write_float32_wav(path, flat)
        print(f"bank {idx} '{name}' -> {path.name} "
              f"({len(flat)} samples, {path.stat().st_size / 1e6:.1f} MB)")
        for line in sanity_check(idx, flat):
            print(line)


if __name__ == "__main__":
    main()
