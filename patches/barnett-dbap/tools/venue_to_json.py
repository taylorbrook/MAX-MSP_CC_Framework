#!/usr/bin/env python3
"""Convert an O-Octagon `.venue` file (XML) into the JSON that barnett-dbap's `dict venue` reads.

Build-time data tool (context.md D24). It writes a DATA file, never a patch.

    python3 patches/barnett-dbap/tools/venue_to_json.py hall.venue            # -> hall.json
    python3 patches/barnett-dbap/tools/venue_to_json.py hall.venue -o out.json

In MAX: click `read` in the host's VENUE section and pick the .json. The host then re-bangs every
source (`venue`) and the alignment-delay stage.

Format (O-Octagon `Data/VenueModel.h`):
    <VENUE name rakeFront rakeRear schemaVersion>
      <SPEAKER index="1..8" x y z trimDb delayMs label/> x 8
Speakers are located by @index, not by child order. Like the plugin's loader, every attribute the
file does not carry falls back PER ATTRIBUTE to the OQ4 default venue, never to zero.

Output (the exact shape of the embedded `dict venue`):
    {"name", "units": "metres",
     "speakers": {"s1": {"x", "y", "z", "delayMs"}, ... "s8": {...}},
     "rake": {"front", "rear"}}

`trimDb` is NOT written: per-speaker trims live in scenes (D11). The values are printed so they can
be copied into the TRIMS bank. `label` (the plugin's channel-map label) has no meaning here:
speaker N is always `mc.dac~` output N.
"""
from __future__ import annotations

import argparse
import json
import math
import sys
import xml.etree.ElementTree as ET
from pathlib import Path

NUM_SPEAKERS = 8
MAX_DELAY_MS = 50.0  # VenueGeometry.h kMaxAlignDelayMs (the plugin's 0..50 ms rail)

# O-Octagon OQ4 traced layout (context.md "Venue data"): x, y, z in metres.
DEFAULT_SPEAKERS = [
    (0.50, 4.50, 4.50),
    (12.50, 4.50, 4.50),
    (12.50, 9.85, 4.70),
    (12.50, 16.00, 5.10),
    (9.80, 19.50, 5.40),
    (3.20, 19.50, 5.40),
    (0.50, 16.00, 5.10),
    (0.50, 9.85, 4.70),
]
DEFAULT_RAKE_FRONT = 1.10
DEFAULT_RAKE_REAR = 3.20
DEFAULT_NAME = "Roy Barnett Recital Hall (O-Octagon OQ4 traced layout, not measured)"


def read_float(node: ET.Element, attr: str, fallback: float, notes: list[str], where: str) -> float:
    """Per-attribute fallback: missing, unparsable or non-finite -> the default."""
    raw = node.get(attr)
    if raw is None:
        return fallback
    try:
        value = float(raw)
    except ValueError:
        notes.append(f"{where} @{attr}={raw!r} is not a number, using default {fallback}")
        return fallback
    if not math.isfinite(value):
        notes.append(f"{where} @{attr}={raw!r} is not finite, using default {fallback}")
        return fallback
    return value


def convert(venue_path: Path) -> tuple[dict, list[float], list[str]]:
    """Return (venue dict, trimDb per speaker, notes)."""
    root = ET.parse(venue_path).getroot()
    if root.tag != "VENUE":
        found = root.find(".//VENUE")  # a VENUE child inside a saved plugin state
        if found is None:
            raise ValueError(f"no <VENUE> element in {venue_path}")
        root = found

    notes: list[str] = []
    by_index: dict[int, ET.Element] = {}
    for node in root.findall("SPEAKER"):
        raw = node.get("index")
        try:
            index = int(raw) if raw is not None else 0
        except ValueError:
            index = 0
        if not 1 <= index <= NUM_SPEAKERS:
            notes.append(f"SPEAKER with @index={raw!r} ignored (expected 1..{NUM_SPEAKERS})")
            continue
        if index in by_index:
            notes.append(f"duplicate SPEAKER @index={index}, keeping the first")
            continue
        by_index[index] = node

    speakers: dict[str, dict[str, float]] = {}
    trims: list[float] = []
    for index in range(1, NUM_SPEAKERS + 1):
        dx, dy, dz = DEFAULT_SPEAKERS[index - 1]
        node = by_index.get(index)
        if node is None:
            notes.append(f"SPEAKER {index} missing, using the default position")
            node = ET.Element("SPEAKER")
        where = f"SPEAKER {index}"
        delay = read_float(node, "delayMs", 0.0, notes, where)
        if not 0.0 <= delay <= MAX_DELAY_MS:
            clamped = min(max(delay, 0.0), MAX_DELAY_MS)
            notes.append(f"{where} @delayMs={delay} outside 0..{MAX_DELAY_MS:g} ms, clamped to {clamped:g}")
            delay = clamped
        speakers[f"s{index}"] = {
            "x": read_float(node, "x", dx, notes, where),
            "y": read_float(node, "y", dy, notes, where),
            "z": read_float(node, "z", dz, notes, where),
            "delayMs": delay,
        }
        trims.append(read_float(node, "trimDb", 0.0, notes, where))

    venue = {
        "name": root.get("name") or DEFAULT_NAME,
        "units": "metres",
        "speakers": speakers,
        "rake": {
            "front": read_float(root, "rakeFront", DEFAULT_RAKE_FRONT, notes, "VENUE"),
            "rear": read_float(root, "rakeRear", DEFAULT_RAKE_REAR, notes, "VENUE"),
        },
    }
    return venue, trims, notes


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    parser.add_argument("venue", type=Path, help="O-Octagon .venue file (XML)")
    parser.add_argument("-o", "--output", type=Path, help="output .json (default: next to the input)")
    args = parser.parse_args(argv)

    try:
        venue, trims, notes = convert(args.venue)
    except (OSError, ET.ParseError, ValueError) as exc:
        print(f"error: {exc}", file=sys.stderr)
        return 1

    out_path = args.output or args.venue.with_suffix(".json")
    if out_path.suffix.lower() != ".json":
        # dict's `read` picks the parser from the extension
        print(f"error: output must end in .json (got {out_path.name})", file=sys.stderr)
        return 1
    out_path.write_text(json.dumps(venue, indent=2) + "\n")

    print(f"venue   {venue['name']}")
    print(f"wrote   {out_path}")
    print(f"rake    front {venue['rake']['front']:g} m, rear {venue['rake']['rear']:g} m")
    print("spk        x        y        z   delayMs    trimDb (not written: trims live in scenes, D11)")
    for index in range(1, NUM_SPEAKERS + 1):
        s = venue["speakers"][f"s{index}"]
        print(f"{index:>3} {s['x']:8.3f} {s['y']:8.3f} {s['z']:8.3f} {s['delayMs']:9.3f} {trims[index - 1]:9.2f}")
    if any(abs(t) > 1e-9 for t in trims):
        print("trims   " + " ".join(f"{t:g}" for t in trims) + "   <- paste into a message box -> the TRIMS bank")
    for note in notes:
        print(f"note    {note}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
