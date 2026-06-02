#!/usr/bin/env python3
"""
midi_to_timeline.py  --  psycography timeline data tool (Module 2)

Parses a Standard MIDI File's tempo + time-signature meta track and integrates
tick -> seconds -> sample, then emits the data files the transport module loads:

  <name>_measures.txt   coll:  measure(1-based) -> "sample num den"   (seek-to-measure)
  <name>_beats.txt      coll:  index(0-based)   -> "sample bar beat"  (bar:beat readout)
  <name>_timeline.json  debug dump (segments, measures, beats)

This is a DATA tool, not a patch generator (CLAUDE.md Rule #5 only forbids
regenerating .maxpat). No external dependencies -- pure-Python SMF parsing of:
  - PPQ division (SMPTE division is rejected)
  - FF 51 03  Set Tempo (microseconds per quarter note)   -- sudden AND gradual
  - FF 58 04  Time Signature (num, 2^dd, clocks/click, 32nds/quarter)

Usage:
  python midi_to_timeline.py INPUT.mid [--sr 48000] [--name psycography]
                             [--outdir DIR] [--extra-measures N]
"""
from __future__ import annotations
import argparse
import json
import struct
from pathlib import Path

DEFAULT_TEMPO = 500000  # us per quarter == 120 bpm
DEFAULT_METER = (4, 4)


# --------------------------------------------------------------------------- #
# Low-level SMF parsing
# --------------------------------------------------------------------------- #
def _read_vlq(data: bytes, i: int) -> tuple[int, int]:
    """Read a MIDI variable-length quantity. Returns (value, new_index)."""
    val = 0
    while True:
        b = data[i]
        i += 1
        val = (val << 7) | (b & 0x7F)
        if not (b & 0x80):
            break
    return val, i


def parse_smf(path: Path):
    """Parse an SMF. Returns (ppq, tempo_events, meter_events, max_tick).

    tempo_events: sorted list of (tick, us_per_quarter)
    meter_events: sorted list of (tick, num, den)
    max_tick:     last event tick across all tracks (piece length)
    """
    data = path.read_bytes()
    if data[0:4] != b"MThd":
        raise ValueError("Not a Standard MIDI File (missing MThd header)")
    hdr_len = struct.unpack(">I", data[4:8])[0]
    fmt, ntracks, division = struct.unpack(">HHH", data[8:8 + 6])
    if hdr_len != 6:
        # tolerate, but advance correctly
        pass
    if division & 0x8000:
        raise ValueError("SMPTE time division not supported; use PPQ (metrical) MIDI")
    ppq = division
    if ppq <= 0:
        raise ValueError(f"Invalid PPQ division: {ppq}")

    tempo_events: list[tuple[int, int]] = []
    meter_events: list[tuple[int, int, int]] = []
    max_tick = 0

    pos = 8 + hdr_len
    for _ in range(ntracks):
        if data[pos:pos + 4] != b"MTrk":
            # search forward for next MTrk (defensive)
            nxt = data.find(b"MTrk", pos)
            if nxt < 0:
                break
            pos = nxt
        trk_len = struct.unpack(">I", data[pos + 4:pos + 8])[0]
        i = pos + 8
        end = i + trk_len
        tick = 0
        running_status = None
        while i < end:
            delta, i = _read_vlq(data, i)
            tick += delta
            status = data[i]
            if status & 0x80:
                i += 1
                running_status = status
            else:
                status = running_status  # running status: reuse, byte is data
            if status is None:
                raise ValueError("Corrupt track: data byte with no running status")

            if status == 0xFF:  # meta event
                meta_type = data[i]; i += 1
                length, i = _read_vlq(data, i)
                payload = data[i:i + length]
                i += length
                if meta_type == 0x51 and length == 3:
                    us = (payload[0] << 16) | (payload[1] << 8) | payload[2]
                    tempo_events.append((tick, us))
                elif meta_type == 0x58 and length >= 2:
                    num = payload[0]
                    den = 2 ** payload[1]
                    meter_events.append((tick, num, den))
                # 0x2F end-of-track and others: ignored (tick already advanced)
            elif status in (0xF0, 0xF7):  # sysex
                length, i = _read_vlq(data, i)
                i += length
            else:  # channel voice
                high = status & 0xF0
                if high in (0xC0, 0xD0):  # program change, channel pressure: 1 data byte
                    i += 1
                else:                      # note on/off, aftertouch, CC, pitchbend: 2 data bytes
                    i += 2
        max_tick = max(max_tick, tick)
        pos = end

    # Guarantee anchors at tick 0
    if not any(t == 0 for t, _ in tempo_events):
        tempo_events.append((0, DEFAULT_TEMPO))
    if not any(t == 0 for t, _, _ in meter_events):
        meter_events.append((0, *DEFAULT_METER))
    tempo_events.sort()
    meter_events.sort()
    # Deduplicate identical-tick tempo events (keep last) -- ramps may stack
    dedup: dict[int, int] = {}
    for t, us in tempo_events:
        dedup[t] = us
    tempo_events = sorted(dedup.items())
    return ppq, tempo_events, meter_events, max_tick


# --------------------------------------------------------------------------- #
# Tick -> seconds integration (piecewise-constant tempo; ramps = dense events)
# --------------------------------------------------------------------------- #
class Timeline:
    def __init__(self, ppq: int, tempo_events: list[tuple[int, int]]):
        self.ppq = ppq
        self.tempo_events = tempo_events
        # Precompute cumulative seconds at each tempo event boundary.
        self._bound_ticks: list[int] = []
        self._bound_secs: list[float] = []
        self._bound_us: list[int] = []
        acc = 0.0
        prev_tick, prev_us = tempo_events[0]
        self._bound_ticks.append(prev_tick)
        self._bound_secs.append(0.0)
        self._bound_us.append(prev_us)
        for tick, us in tempo_events[1:]:
            acc += (tick - prev_tick) * (prev_us / 1_000_000.0) / ppq
            self._bound_ticks.append(tick)
            self._bound_secs.append(acc)
            self._bound_us.append(us)
            prev_tick, prev_us = tick, us

    def seconds(self, tick: int) -> float:
        """Absolute seconds at an arbitrary tick (extrapolates past last event)."""
        import bisect
        idx = bisect.bisect_right(self._bound_ticks, tick) - 1
        if idx < 0:
            idx = 0
        base_tick = self._bound_ticks[idx]
        base_sec = self._bound_secs[idx]
        us = self._bound_us[idx]
        return base_sec + (tick - base_tick) * (us / 1_000_000.0) / self.ppq


# --------------------------------------------------------------------------- #
# Measure + beat grid generation
# --------------------------------------------------------------------------- #
def build_grids(ppq, tempo_events, meter_events, max_tick, sr, extra_measures=1):
    tl = Timeline(ppq, tempo_events)
    meter_at = sorted(meter_events)

    def meter_for_tick(tick):
        cur = meter_at[0][1:]
        for mt, num, den in meter_at:
            if mt <= tick:
                cur = (num, den)
            else:
                break
        return cur

    measures = []  # (measure_no, tick, sample, num, den)
    beats = []     # (sample, bar, beat)

    tick = 0
    measure_no = 1
    # cover the whole piece plus a few measures of safety tail
    limit = max_tick
    while True:
        num, den = meter_for_tick(tick)
        sec = tl.seconds(tick)
        sample = round(sec * sr)
        measures.append((measure_no, tick, sample, num, den))
        beat_ticks = ppq * 4 // den  # ticks per notated beat
        for k in range(num):
            bt = tick + k * beat_ticks
            beats.append((round(tl.seconds(bt) * sr), measure_no, k + 1))
        measure_ticks = num * ppq * 4 // den
        tick += measure_ticks
        measure_no += 1
        if tick > limit:
            # emit `extra_measures` past the end, then stop
            if measure_no > 1 and (tick - limit) > extra_measures * measure_ticks:
                break
        if measure_no > 100000:  # runaway guard
            break

    return tl, measures, beats


# --------------------------------------------------------------------------- #
# coll file writers
# --------------------------------------------------------------------------- #
def write_measures_coll(path: Path, measures):
    lines = [f"{m}, {sample} {num} {den};" for (m, _tick, sample, num, den) in measures]
    path.write_text("\n".join(lines) + "\n")


def write_beats_coll(path: Path, beats):
    lines = [f"{i}, {sample} {bar} {beat};" for i, (sample, bar, beat) in enumerate(beats)]
    path.write_text("\n".join(lines) + "\n")


def write_debug_json(path: Path, ppq, tempo_events, meter_events, measures, beats, sr):
    obj = {
        "sr": sr,
        "ppq": ppq,
        "tempo_events": [{"tick": t, "us_per_q": us, "bpm": round(60_000_000 / us, 4)}
                         for t, us in tempo_events],
        "meter_events": [{"tick": t, "num": n, "den": d} for t, n, d in meter_events],
        "measures": [{"measure": m, "tick": tk, "sample": s, "num": n, "den": d}
                     for (m, tk, s, n, d) in measures],
        "beat_count": len(beats),
        "beats_head": [{"sample": s, "bar": b, "beat": be} for (s, b, be) in beats[:12]],
    }
    path.write_text(json.dumps(obj, indent=1) + "\n")


# --------------------------------------------------------------------------- #
def main():
    ap = argparse.ArgumentParser(description="MIDI tempo track -> psycography timeline coll data")
    ap.add_argument("input", help="input .mid file")
    ap.add_argument("--sr", type=int, default=48000, help="sample rate (default 48000)")
    ap.add_argument("--name", default="psycography", help="output basename")
    ap.add_argument("--outdir", default=None, help="output dir (default: ../generated next to tool)")
    ap.add_argument("--extra-measures", type=int, default=1)
    args = ap.parse_args()

    in_path = Path(args.input)
    if args.outdir:
        outdir = Path(args.outdir)
    else:
        # Always the project's generated/ dir (relative to this tool), regardless
        # of where the input MIDI lives.
        outdir = Path(__file__).resolve().parent.parent / "generated"
    outdir.mkdir(parents=True, exist_ok=True)

    ppq, tempo_events, meter_events, max_tick = parse_smf(in_path)
    tl, measures, beats = build_grids(ppq, tempo_events, meter_events, max_tick, args.sr,
                                      args.extra_measures)

    mpath = outdir / f"{args.name}_measures.txt"
    bpath = outdir / f"{args.name}_beats.txt"
    jpath = outdir / f"{args.name}_timeline.json"
    write_measures_coll(mpath, measures)
    write_beats_coll(bpath, beats)
    write_debug_json(jpath, ppq, tempo_events, meter_events, measures, beats, args.sr)

    print(f"PPQ={ppq}  tempo_events={len(tempo_events)}  meter_events={len(meter_events)}  "
          f"max_tick={max_tick}")
    print(f"measures={len(measures)}  beats={len(beats)}  sr={args.sr}")
    print(f"wrote: {mpath.name}, {bpath.name}, {jpath.name}  -> {outdir}")


if __name__ == "__main__":
    main()
