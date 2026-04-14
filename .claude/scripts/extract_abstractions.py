#!/usr/bin/env python3
"""Extract BEAP and Vizzie bpatcher abstractions into the object database.

Parses .maxpat files from the local MAX installation to extract I/O counts,
descriptions, categories, and bpatcher dimensions for BEAP and Vizzie modules.

Usage:
    python3 .claude/scripts/extract_abstractions.py                    # Extract all
    python3 .claude/scripts/extract_abstractions.py --package beap     # BEAP only
    python3 .claude/scripts/extract_abstractions.py --package vizzie   # Vizzie only
    python3 .claude/scripts/extract_abstractions.py --dry-run          # Count only
    python3 .claude/scripts/extract_abstractions.py --max-path /path   # Custom path
    python3 .claude/scripts/extract_abstractions.py --output dir       # Custom output
"""

import argparse
import json
import sys
from collections import defaultdict
from pathlib import Path

# ---------------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------------

DEFAULT_MAX_PATH = Path("/Applications/Max.app/Contents/Resources/C74")

BEAP_CLIPPINGS_REL = "packages/BEAP/clippings/BEAP"
BEAP_MISC_REL = "packages/BEAP/misc"
BEAP_HELP_REL = "packages/BEAP/Help"
VIZZIE_PATCHERS_REL = "packages/Vizzie/patchers"

# Internal helpers to skip -- poly~/pfft subpatches, not user-facing modules
INTERNAL_HELPERS = {
    "bp.freqshift.poly",
    "bp.polydronevoice",
    "bp.rgrain",
    "bp.diodeladder.poly",
    "bp.fp_fft",
    "bp.pvoc.pfft",
    "bp.pvoc.rec.pfft",
}

# Instructional comment prefixes to filter out when extracting descriptions
INSTRUCTIONAL_PREFIXES = ("try", "click", "Connect", "hover", "Turn", "Press",
                          "Use ", "Note:", "Tip:", "double", "Double")

# Vizzie comment keywords indicating video/matrix type
VIZZIE_VIDEO_KEYWORDS = {"video", "matrix", "texture", "image", "jitter",
                         "gl", "movie", "camera", "capture", "syphon",
                         "visual", "frame", "pixel"}


# ---------------------------------------------------------------------------
# BEAP Extraction
# ---------------------------------------------------------------------------

def extract_beap_clipping(filepath: Path, category: str) -> dict | None:
    """Extract a BEAP module from a clipping .maxpat (embedded bpatcher pattern).

    Args:
        filepath: Path to the clipping .maxpat file.
        category: Category name from parent directory.

    Returns:
        Object entry dict, or None if extraction failed.
    """
    try:
        data = json.loads(filepath.read_text())
    except (json.JSONDecodeError, OSError) as e:
        print(f"  WARNING: Failed to parse {filepath.name}: {e}", file=sys.stderr)
        return None

    patcher = data.get("patcher", {})
    boxes = patcher.get("boxes", [])

    # Find the embedded bpatcher box
    bpatcher_box = None
    for box in boxes:
        b = box.get("box", {})
        if b.get("maxclass") == "bpatcher":
            bpatcher_box = b
            break

    if bpatcher_box is None:
        print(f"  WARNING: No bpatcher found in {filepath.name}", file=sys.stderr)
        return None

    name = filepath.stem  # e.g., "bp.Oscillator"

    # Extract I/O from inner patcher
    inlets, outlets = _extract_inner_io(bpatcher_box)

    # Extract dimensions from patching_rect [x, y, width, height]
    rect = bpatcher_box.get("patching_rect", [0, 0, 300, 200])
    dimensions = [rect[2], rect[3]] if len(rect) >= 4 else [300.0, 200.0]

    # Build relative path for abstraction_file
    abstraction_file = f"clippings/BEAP/{category}/{filepath.name}"

    return _build_beap_entry(name, category, inlets, outlets, dimensions,
                             abstraction_file)


def extract_beap_misc(filepath: Path) -> dict | None:
    """Extract a BEAP module from misc/ directory.

    Handles three patterns:
    1. Embedded bpatcher (same as clippings)
    2. in~/out~ objects (marco_osc pattern)
    3. Top-level inlet/outlet objects (standalone abstractions)

    Args:
        filepath: Path to the misc .maxpat file.

    Returns:
        Object entry dict, or None if extraction failed.
    """
    name = filepath.stem
    if name in INTERNAL_HELPERS:
        return None

    try:
        data = json.loads(filepath.read_text())
    except (json.JSONDecodeError, OSError) as e:
        print(f"  WARNING: Failed to parse {filepath.name}: {e}", file=sys.stderr)
        return None

    patcher = data.get("patcher", {})
    boxes = patcher.get("boxes", [])

    # Pattern 1: Embedded bpatcher
    for box in boxes:
        b = box.get("box", {})
        if b.get("maxclass") == "bpatcher":
            inlets, outlets = _extract_inner_io(b)
            rect = b.get("patching_rect", [0, 0, 300, 200])
            dimensions = [rect[2], rect[3]] if len(rect) >= 4 else [300.0, 200.0]
            # Determine relative path
            rel = filepath.relative_to(filepath.parents[1])  # relative to misc parent
            abstraction_file = f"misc/{rel}"
            return _build_beap_entry(name, "Misc", inlets, outlets, dimensions,
                                     abstraction_file)

    # Pattern 2: in~/out~ objects (marco_osc pattern)
    signal_ins = []
    signal_outs = []
    for box in boxes:
        b = box.get("box", {})
        text = b.get("text", "")
        if text.startswith("in~ "):
            try:
                idx = int(text.split()[1])
            except (IndexError, ValueError):
                idx = len(signal_ins) + 1
            signal_ins.append(idx)
        elif text.startswith("out~ "):
            try:
                idx = int(text.split()[1])
            except (IndexError, ValueError):
                idx = len(signal_outs) + 1
            signal_outs.append(idx)

    if signal_ins or signal_outs:
        signal_ins.sort()
        signal_outs.sort()
        inlets = [
            {"id": i, "type": "signal", "signal": True, "hot": i == 0,
             "digest": f"Signal input {idx}"}
            for i, idx in enumerate(signal_ins)
        ]
        outlets = [
            {"id": i, "type": "signal", "signal": True,
             "digest": f"Signal output {idx}"}
            for i, idx in enumerate(signal_outs)
        ]
        # Determine relative path
        rel = filepath.relative_to(filepath.parents[1])
        abstraction_file = f"misc/{rel}"
        return _build_beap_entry(name, "Misc", inlets, outlets,
                                 [300.0, 200.0], abstraction_file)

    # Pattern 3: Top-level inlet/outlet objects
    raw_inlets = []
    raw_outlets = []
    for box in boxes:
        b = box.get("box", {})
        mc = b.get("maxclass", "")
        if mc == "inlet":
            rect = b.get("patching_rect", [0, 0, 0, 0])
            raw_inlets.append({
                "x": rect[0] if rect else 0,
                "comment": b.get("comment", ""),
            })
        elif mc == "outlet":
            rect = b.get("patching_rect", [0, 0, 0, 0])
            raw_outlets.append({
                "x": rect[0] if rect else 0,
                "comment": b.get("comment", ""),
            })

    if not raw_inlets and not raw_outlets:
        # No I/O found -- skip this file (likely another internal helper)
        return None

    # Sort by x position for ordering
    raw_inlets.sort(key=lambda r: r["x"])
    raw_outlets.sort(key=lambda r: r["x"])

    inlets = [
        {"id": i, "type": "signal", "signal": True, "hot": i == 0,
         "digest": ri["comment"]}
        for i, ri in enumerate(raw_inlets)
    ]
    outlets = [
        {"id": i, "type": "signal", "signal": True,
         "digest": ro["comment"]}
        for i, ro in enumerate(raw_outlets)
    ]

    rel = filepath.relative_to(filepath.parents[1])
    abstraction_file = f"misc/{rel}"
    return _build_beap_entry(name, "Misc", inlets, outlets,
                             [300.0, 200.0], abstraction_file)


def _extract_inner_io(bpatcher_box: dict) -> tuple[list, list]:
    """Extract inlet/outlet info from a bpatcher's inner patcher.

    Args:
        bpatcher_box: The bpatcher box dict containing a nested patcher.

    Returns:
        (inlets, outlets) tuple of lists in schema format.
    """
    inner = bpatcher_box.get("patcher", {})
    raw_inlets = []
    raw_outlets = []

    for box in inner.get("boxes", []):
        b = box.get("box", {})
        mc = b.get("maxclass", "")
        if mc == "inlet":
            raw_inlets.append({
                "index": b.get("index", 0),
                "comment": b.get("comment", ""),
            })
        elif mc == "outlet":
            raw_outlets.append({
                "index": b.get("index", 0),
                "comment": b.get("comment", ""),
            })

    # Sort by index (1-based in BEAP), convert to 0-based id
    raw_inlets.sort(key=lambda x: x["index"])
    raw_outlets.sort(key=lambda x: x["index"])

    inlets = [
        {"id": i, "type": "signal", "signal": True, "hot": i == 0,
         "digest": ri["comment"]}
        for i, ri in enumerate(raw_inlets)
    ]
    outlets = [
        {"id": i, "type": "signal", "signal": True,
         "digest": ro["comment"]}
        for i, ro in enumerate(raw_outlets)
    ]

    return inlets, outlets


def _build_beap_entry(name: str, category: str, inlets: list, outlets: list,
                      dimensions: list, abstraction_file: str) -> dict:
    """Build a complete BEAP object entry in the database schema."""
    return {
        "name": name,
        "maxclass": "bpatcher",
        "module": "max",
        "domain": "Packages",
        "category": category,
        "digest": "",
        "description": "",
        "inlets": inlets,
        "outlets": outlets,
        "arguments": [],
        "messages": [],
        "attributes": {},
        "seealso": [],
        "tags": ["BEAP", category],
        "min_version": 8,
        "verified": True,
        "variable_io": False,
        "rnbo_compatible": False,
        "package": "BEAP",
        "abstraction_file": abstraction_file,
        "bpatcher_dimensions": dimensions,
        "signal_convention": "0-5V CV",
    }


def extract_beap_descriptions(help_dir: Path, objects: dict) -> int:
    """Extract descriptions from BEAP .maxhelp files and attach to objects.

    Uses the longest non-instructional comment found in the help patch
    (top-level and first-level subpatchers).

    Args:
        help_dir: Path to BEAP Help/ directory.
        objects: Dict of BEAP object entries (modified in place).

    Returns:
        Number of descriptions found.
    """
    if not help_dir.is_dir():
        return 0

    found = 0
    for name, obj in objects.items():
        help_path = help_dir / f"{name}.maxhelp"
        if not help_path.exists():
            continue

        try:
            data = json.loads(help_path.read_text())
        except (json.JSONDecodeError, OSError):
            continue

        desc = _find_best_description(data.get("patcher", {}))
        if desc:
            obj["digest"] = desc
            obj["description"] = desc
            found += 1

    return found


def _find_best_description(patcher: dict) -> str:
    """Find the best description comment in a help patch.

    Searches top-level and first-level subpatchers for the longest
    non-instructional comment.

    Args:
        patcher: The help patch's patcher dict.

    Returns:
        Best description string, or empty string if none found.
    """
    comments = []

    # Collect comments from top-level
    for box in patcher.get("boxes", []):
        b = box.get("box", {})
        if b.get("maxclass") == "comment":
            text = b.get("text", "").strip()
            if text and len(text) > 15 and not _is_instructional(text):
                comments.append(text)

        # Also check first-level subpatchers
        inner = b.get("patcher")
        if inner:
            for inner_box in inner.get("boxes", []):
                ib = inner_box.get("box", {})
                if ib.get("maxclass") == "comment":
                    text = ib.get("text", "").strip()
                    if text and len(text) > 15 and not _is_instructional(text):
                        comments.append(text)

    if not comments:
        return ""

    # Return the longest comment as the best description candidate
    return max(comments, key=len)


def _is_instructional(text: str) -> bool:
    """Check if a comment is instructional (not a description)."""
    return any(text.startswith(prefix) for prefix in INSTRUCTIONAL_PREFIXES)


def extract_all_beap(max_path: Path) -> dict:
    """Extract all BEAP modules from clippings and misc directories.

    Args:
        max_path: Path to the C74 directory.

    Returns:
        Dict of BEAP object entries keyed by name.
    """
    objects = {}
    stats = defaultdict(int)
    errors = []

    # Pattern 1: Clippings
    clippings_dir = max_path / BEAP_CLIPPINGS_REL
    if clippings_dir.is_dir():
        for category_dir in sorted(clippings_dir.iterdir()):
            if not category_dir.is_dir():
                continue
            category = category_dir.name
            for filepath in sorted(category_dir.glob("bp.*.maxpat")):
                entry = extract_beap_clipping(filepath, category)
                if entry:
                    objects[entry["name"]] = entry
                    stats[category] += 1
                else:
                    errors.append(f"clipping: {filepath.name}")

    # Pattern 2 + 3: Misc standalone + marco_osc
    misc_dir = max_path / BEAP_MISC_REL
    if misc_dir.is_dir():
        # Direct misc bp.* files
        for filepath in sorted(misc_dir.glob("bp.*.maxpat")):
            entry = extract_beap_misc(filepath)
            if entry:
                objects[entry["name"]] = entry
                stats["Misc"] += 1

        # marco_osc subdirectory
        marco_dir = misc_dir / "marco_osc"
        if marco_dir.is_dir():
            for filepath in sorted(marco_dir.glob("bp.*.maxpat")):
                entry = extract_beap_misc(filepath)
                if entry:
                    objects[entry["name"]] = entry
                    stats["Misc"] += 1

    # Extract descriptions from help patches
    help_dir = max_path / BEAP_HELP_REL
    desc_count = extract_beap_descriptions(help_dir, objects)

    print(f"\nBEAP Extraction Summary:")
    print(f"  Total modules: {len(objects)}")
    print(f"  With descriptions: {desc_count}")
    print(f"  Category breakdown:")
    for cat in sorted(stats):
        print(f"    {cat}: {stats[cat]}")
    if errors:
        print(f"  Errors ({len(errors)}):")
        for e in errors:
            print(f"    {e}")

    return objects


# ---------------------------------------------------------------------------
# Vizzie Extraction
# ---------------------------------------------------------------------------

def extract_vizzie_module(filepath: Path) -> dict | None:
    """Extract a Vizzie module from a .maxpat file.

    Args:
        filepath: Path to the vz.*.maxpat file.

    Returns:
        Object entry dict, or None if extraction failed.
    """
    try:
        data = json.loads(filepath.read_text())
    except (json.JSONDecodeError, OSError) as e:
        print(f"  WARNING: Failed to parse {filepath.name}: {e}", file=sys.stderr)
        return None

    patcher = data.get("patcher", {})
    name = filepath.stem  # e.g., "vz.analyzr"

    # Extract description from patcher.description
    description = patcher.get("description", "")

    # Extract category from patcher.tags (format: "Vizzie Generate, analyzr")
    tags_str = patcher.get("tags", "")
    category = _extract_vizzie_category(tags_str)

    # Extract dimensions from patcher.rect [x, y, width, height]
    rect = patcher.get("rect", [0, 0, 300, 200])
    dimensions = [rect[2], rect[3]] if len(rect) >= 4 else [300.0, 200.0]

    # Extract inlet/outlet objects (sorted by x position since index is always 0)
    raw_inlets = []
    raw_outlets = []
    for box in patcher.get("boxes", []):
        b = box.get("box", {})
        mc = b.get("maxclass", "")
        if mc == "inlet":
            prect = b.get("patching_rect", [0, 0, 0, 0])
            raw_inlets.append({
                "x": prect[0] if prect else 0,
                "comment": b.get("comment", ""),
            })
        elif mc == "outlet":
            prect = b.get("patching_rect", [0, 0, 0, 0])
            raw_outlets.append({
                "x": prect[0] if prect else 0,
                "comment": b.get("comment", ""),
            })

    # Sort by x position (left to right)
    raw_inlets.sort(key=lambda r: r["x"])
    raw_outlets.sort(key=lambda r: r["x"])

    # Classify inlet types based on comment keywords
    inlets = []
    for i, ri in enumerate(raw_inlets):
        io_type = _classify_vizzie_io(ri["comment"])
        inlets.append({
            "id": i,
            "type": io_type,
            "signal": False,
            "hot": i == 0,
            "digest": ri["comment"],
        })

    outlets = []
    for i, ro in enumerate(raw_outlets):
        io_type = _classify_vizzie_io(ro["comment"])
        outlets.append({
            "id": i,
            "type": io_type,
            "signal": False,
            "digest": ro["comment"],
        })

    abstraction_file = f"patchers/{filepath.name}"

    return {
        "name": name,
        "maxclass": "bpatcher",
        "module": "max",
        "domain": "Packages",
        "category": category,
        "digest": description,
        "description": description,
        "inlets": inlets,
        "outlets": outlets,
        "arguments": [],
        "messages": [],
        "attributes": {},
        "seealso": [],
        "tags": ["Vizzie", category],
        "min_version": 8,
        "verified": True,
        "variable_io": False,
        "rnbo_compatible": False,
        "package": "Vizzie",
        "abstraction_file": abstraction_file,
        "bpatcher_dimensions": dimensions,
        "signal_convention": "Jitter matrix",
    }


def _extract_vizzie_category(tags_str: str) -> str:
    """Extract category from Vizzie tags string.

    Format: "Vizzie Generate, analyzr" -> "Generate"

    Args:
        tags_str: The tags string from the patcher.

    Returns:
        Category name, or "Uncategorized" if not found.
    """
    if not tags_str:
        return "Uncategorized"

    # Tags are comma-separated; look for "Vizzie {Category}" pattern
    parts = [p.strip() for p in tags_str.split(",")]
    for part in parts:
        if part.startswith("Vizzie "):
            category = part[7:]  # Remove "Vizzie " prefix
            # Handle hyphenated categories like "Mix-Composite"
            return category

    return "Uncategorized"


def _classify_vizzie_io(comment: str) -> str:
    """Classify a Vizzie inlet/outlet as matrix or control based on comment.

    Args:
        comment: The comment/description text from the inlet/outlet.

    Returns:
        "matrix" for video/matrix I/O, "control" otherwise.
    """
    if not comment:
        return "control"

    comment_lower = comment.lower()
    for keyword in VIZZIE_VIDEO_KEYWORDS:
        if keyword in comment_lower:
            return "matrix"
    return "control"


def extract_all_vizzie(max_path: Path) -> dict:
    """Extract all Vizzie modules from patchers/ directory.

    Args:
        max_path: Path to the C74 directory.

    Returns:
        Dict of Vizzie object entries keyed by name.
    """
    objects = {}
    stats = defaultdict(int)
    errors = []

    patchers_dir = max_path / VIZZIE_PATCHERS_REL
    if not patchers_dir.is_dir():
        print(f"  WARNING: Vizzie patchers dir not found: {patchers_dir}",
              file=sys.stderr)
        return objects

    # Only process top-level vz.*.maxpat files (skip subdirectories)
    for filepath in sorted(patchers_dir.glob("vz.*.maxpat")):
        if not filepath.is_file():
            continue
        entry = extract_vizzie_module(filepath)
        if entry:
            objects[entry["name"]] = entry
            stats[entry["category"]] += 1
        else:
            errors.append(filepath.name)

    print(f"\nVizzie Extraction Summary:")
    print(f"  Total modules: {len(objects)}")
    print(f"  Category breakdown:")
    for cat in sorted(stats):
        print(f"    {cat}: {stats[cat]}")
    if errors:
        print(f"  Errors ({len(errors)}):")
        for e in errors:
            print(f"    {e}")

    return objects


# ---------------------------------------------------------------------------
# Output
# ---------------------------------------------------------------------------

def write_output(objects: dict, output_path: Path, package_name: str) -> None:
    """Write extracted objects to a JSON file.

    Args:
        objects: Dict of object entries keyed by name.
        output_path: Directory to write to (package subdir created if needed).
        package_name: Name of the package (e.g., "BEAP", "Vizzie").
    """
    pkg_dir = output_path / package_name
    pkg_dir.mkdir(parents=True, exist_ok=True)
    out_file = pkg_dir / "objects.json"

    # Sort keys for deterministic output
    sorted_objects = dict(sorted(objects.items()))

    out_file.write_text(
        json.dumps(sorted_objects, indent=2, ensure_ascii=False) + "\n"
    )
    print(f"\nWrote {len(objects)} objects to {out_file}")


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(
        description="Extract BEAP and Vizzie bpatcher abstractions into the object database."
    )
    parser.add_argument(
        "--max-path", type=Path, default=DEFAULT_MAX_PATH,
        help=f"Path to MAX C74 directory (default: {DEFAULT_MAX_PATH})"
    )
    parser.add_argument(
        "--output", type=Path, default=None,
        help="Output directory for package JSON files (default: .claude/max-objects/packages)"
    )
    parser.add_argument(
        "--package", choices=["beap", "vizzie"], default=None,
        help="Extract only the specified package (default: both)"
    )
    parser.add_argument(
        "--dry-run", action="store_true",
        help="Count extractable files without writing output"
    )
    args = parser.parse_args()

    # Determine output directory
    if args.output:
        output_dir = args.output
    else:
        # Default: project root / .claude / max-objects / packages
        script_dir = Path(__file__).resolve().parent
        output_dir = script_dir.parent / "max-objects" / "packages"

    if not args.max_path.is_dir():
        print(f"ERROR: MAX path not found: {args.max_path}", file=sys.stderr)
        sys.exit(1)

    print(f"MAX path: {args.max_path}")
    print(f"Output:   {output_dir}")
    if args.dry_run:
        print("Mode:     DRY RUN (no files written)")

    total = 0

    # Extract BEAP
    if args.package is None or args.package == "beap":
        beap_objects = extract_all_beap(args.max_path)
        total += len(beap_objects)
        if not args.dry_run and beap_objects:
            write_output(beap_objects, output_dir, "BEAP")

    # Extract Vizzie
    if args.package is None or args.package == "vizzie":
        vizzie_objects = extract_all_vizzie(args.max_path)
        total += len(vizzie_objects)
        if not args.dry_run and vizzie_objects:
            write_output(vizzie_objects, output_dir, "Vizzie")

    print(f"\n{'=' * 50}")
    print(f"Total extracted: {total} modules")
    if args.dry_run:
        print("(dry run -- no files written)")


if __name__ == "__main__":
    main()
