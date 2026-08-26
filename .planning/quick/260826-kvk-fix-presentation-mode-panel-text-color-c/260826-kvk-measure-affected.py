"""Measure -- do NOT fix -- text-contrast debt in already-generated patches.

Walks patches/*/generated/*.maxpat and, for every text-bearing box, computes
the WCAG contrast ratio against its EFFECTIVE background in the coordinate
space where it is displayed. Read-only: no .maxpat file is opened for writing
(locked decision D-4). The opt-in repair path is
`src.maxpat.aesthetics.repair_text_contrast(patcher)`, per patch.

Usage:  python3 .planning/quick/260826-kvk-*/260826-kvk-measure-affected.py
"""
import glob
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[3]))

from src.maxpat.aesthetics import (  # noqa: E402
    contrast_ratio,
    is_text_contrast_target,
    resolve_effective_background,
    resolve_panel_background,
)
from src.maxpat.defaults import AESTHETIC_PALETTE, MIN_CONTRAST_RATIO  # noqa: E402


def patcher_bg(props):
    for key in ("bgcolor", "editing_bgcolor", "locked_bgcolor"):
        v = props.get(key)
        if isinstance(v, list) and v:
            return list(v)
    return list(AESTHETIC_PALETTE["canvas_bg"])


def scan(props, out, depth=0):
    boxes = [e.get("box", {}) for e in props.get("boxes", [])]
    bg = patcher_bg(props)
    panels = [b for b in boxes if b.get("maxclass") == "panel"]
    pat_layers = [(b.get("patching_rect"), resolve_panel_background(b)) for b in panels]
    pre_layers = [
        (b.get("presentation_rect"), resolve_panel_background(b))
        for b in panels
        if b.get("presentation") and b.get("presentation_rect")
    ]
    for b in boxes:
        if b.get("maxclass") != "panel" and is_text_contrast_target(b.get("maxclass"), b):
            tc = b.get("textcolor")
            if isinstance(tc, list) and len(tc) >= 3:
                r = resolve_effective_background(
                    b, b.get("patching_rect"), bool(b.get("presentation")),
                    b.get("presentation_rect"), pat_layers, pre_layers, bg,
                )
                ratio = contrast_ratio(tc, r.color)
                out["total"] += 1
                if ratio < MIN_CONTRAST_RATIO:
                    (out["assumed"] if r.assumed else out["failing"]).append(
                        (b.get("text", "")[:30], round(ratio, 2), r.space)
                    )
        inner = b.get("patcher")
        if isinstance(inner, dict) and depth < 6:
            scan(inner, out, depth + 1)


def main():
    root = Path(__file__).resolve().parents[3]
    rows = []
    for f in sorted(glob.glob(str(root / "patches/*/generated/*.maxpat"))):
        try:
            data = json.load(open(f))
        except Exception as exc:
            rows.append((Path(f).relative_to(root).as_posix(), "-", "-", "-", f"unreadable: {exc}"))
            continue
        out = {"total": 0, "failing": [], "assumed": []}
        scan(data.get("patcher", {}), out)
        rows.append((
            Path(f).relative_to(root).as_posix(),
            out["total"], len(out["failing"]), len(out["assumed"]), "",
        ))

    affected = [r for r in rows if isinstance(r[2], int) and r[2] > 0]
    print(f"WCAG AA threshold: {MIN_CONTRAST_RATIO}:1")
    print(f"Files scanned: {len(rows)}   Files with failing text: {len(affected)}")
    print(f"Total text boxes: {sum(r[1] for r in rows if isinstance(r[1], int))}")
    print(f"Total failing (known bg): {sum(r[2] for r in rows if isinstance(r[2], int))}")
    print(f"Total flagged (assumed bg): {sum(r[3] for r in rows if isinstance(r[3], int))}")
    print()
    print(f"| {'file':<62} | text | fail | assumed |")
    print(f"|{'-'*64}|------|------|---------|")
    for path, total, fail, assumed, err in rows:
        if err:
            print(f"| {path:<62} | {err} |")
        elif fail or assumed:
            print(f"| {path:<62} | {total:>4} | {fail:>4} | {assumed:>7} |")


if __name__ == "__main__":
    main()
