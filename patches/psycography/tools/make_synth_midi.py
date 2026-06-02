#!/usr/bin/env python3
"""
make_synth_midi.py  --  test fixture for midi_to_timeline.py

Writes a small format-1 SMF with PPQ=480 exercising every code path:
  - tempo at tick 0           : 120 bpm, 4/4
  - sudden tempo change (m5)  : 90 bpm
  - gradual accelerando m9-m13: 90 -> 140 bpm via 16 dense Set-Tempo events
  - meter change at m13       : 3/4, tempo 140 bpm
  - a notes track using running status (so the parser's skip path is tested)

This is a TEST FIXTURE generator (produces a .mid), not a patch generator.

Usage:  python make_synth_midi.py [out.mid]
"""
from __future__ import annotations
import struct
import sys
from pathlib import Path

PPQ = 480


def vlq(n: int) -> bytes:
    if n == 0:
        return bytes([0])
    out = [n & 0x7F]
    n >>= 7
    while n:
        out.append((n & 0x7F) | 0x80)
        n >>= 7
    return bytes(reversed(out))


def tempo_evt(bpm: float) -> bytes:
    us = round(60_000_000 / bpm)
    return bytes([0xFF, 0x51, 0x03]) + us.to_bytes(3, "big")


def timesig_evt(num: int, den: int) -> bytes:
    dd = den.bit_length() - 1  # log2(den): 4->2, 8->3
    return bytes([0xFF, 0x58, 0x04, num, dd, 24, 8])


EOT = bytes([0xFF, 0x2F, 0x00])


def build_track(events: list[tuple[int, bytes]]) -> bytes:
    """events: list of (abs_tick, data). Returns an MTrk chunk."""
    events = sorted(events, key=lambda e: e[0])
    body = b""
    prev = 0
    for tick, data in events:
        body += vlq(tick - prev) + data
        prev = tick
    body += vlq(0) + EOT
    return b"MTrk" + struct.pack(">I", len(body)) + body


def main():
    out = Path(sys.argv[1]) if len(sys.argv) > 1 else Path(__file__).resolve().parent / "synthetic_tempo.mid"

    m = lambda meas: (meas - 1)  # 0-based measure index helper
    # measure-start ticks: 4/4 = 1920 ticks for m1..m12, then 3/4 = 1440 for m13+
    t_m5 = 4 * 1920            # 7680
    t_m9 = 8 * 1920            # 15360
    t_m13 = 12 * 1920          # 23040
    t_end = t_m13 + 4 * 1440   # 28800 (m17 start)

    tempo_meter = []
    tempo_meter.append((0, timesig_evt(4, 4)))
    tempo_meter.append((0, tempo_evt(120)))
    tempo_meter.append((t_m5, tempo_evt(90)))           # sudden change
    # gradual accelerando 90 -> 140 over m9..m13 (16 beats, every 480 ticks)
    for i in range(16):
        bpm = 90 + (140 - 90) * i / 15
        tempo_meter.append((t_m9 + i * 480, tempo_evt(bpm)))
    tempo_meter.append((t_m13, timesig_evt(3, 4)))      # meter change
    tempo_meter.append((t_m13, tempo_evt(140)))
    # explicit length anchor
    tempo_meter.append((t_end, bytes([0xFF, 0x06, 0x03]) + b"end"))  # marker meta (harmless)

    track0 = build_track(tempo_meter)

    # notes track: running status note-on / note-on(vel0) pairs
    notes = [
        (0,   bytes([0x90, 0x3C, 0x64])),   # note on C4
        (480, bytes([0x3C, 0x00])),         # running status -> note off
        (480, bytes([0x3E, 0x64])),         # running status note on E4 (same tick as prev off)
        (960, bytes([0x3E, 0x00])),         # running status -> note off
    ]
    track1 = build_track(notes)

    header = b"MThd" + struct.pack(">IHHH", 6, 1, 2, PPQ)
    out.write_bytes(header + track0 + track1)
    print(f"wrote {out}  ({out.stat().st_size} bytes, PPQ={PPQ}, end_tick={t_end})")


if __name__ == "__main__":
    main()
