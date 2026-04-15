"""Package critic -- checks BEAP conventions, Bach llll types, and community extraction.

Catches package-specific semantic errors that the generic validation pipeline
misses:
  - BEAP: missing output termination, missing VCA gain staging
  - Bach: llll/list type mismatches (non-bach feeding llll inlet)
  - Community: unextracted community package usage warnings
"""

from __future__ import annotations

from collections import deque

from src.maxpat.critics.base import CriticResult
from src.maxpat.db_lookup import ObjectDatabase
from src.maxpat.utils import get_box_name


# BEAP output module names (signal terminators with 0 outlets)
_BEAP_OUTPUT_NAMES = frozenset({
    "bp.Stereo", "bp.Mono", "bp.Calibrated",
    "bp.Calibrated_64bit", "bp.M4L Out", "bp.Recordr", "bp.Snapshotter",
})

# BEAP source categories that start signal chains
_BEAP_SOURCE_CATEGORIES = frozenset({"Oscillator", "Input", "Random", "LFO"})

# BEAP gain staging categories (contains bp.VCA)
_BEAP_GAIN_CATEGORIES = frozenset({"Level"})


def _get_object_name(box: dict) -> str:
    """Get object name, handling both bpatcher (name attr) and newobj (text field).

    BEAP/Vizzie objects have maxclass="bpatcher" with the abstraction name
    in the "name" attribute. Standard objects use get_box_name().
    """
    if box.get("maxclass") == "bpatcher":
        return box.get("name", "")
    return get_box_name(box)


def review_packages(
    patch_dict: dict,
    db: ObjectDatabase | None = None,
) -> list[CriticResult]:
    """Review package-specific semantics.

    Dispatches to BEAP, Bach, and community checks based on
    which package objects are detected in the patch.

    Args:
        patch_dict: A .maxpat-format dict.
        db: Optional ObjectDatabase instance. Created internally if None.

    Returns:
        List of CriticResult findings.
    """
    results: list[CriticResult] = []
    if db is None:
        db = ObjectDatabase()

    patcher = patch_dict.get("patcher", {})
    boxes = patcher.get("boxes", [])
    lines = patcher.get("lines", [])

    # Build box lookup and detect which packages are used
    packages_used: set[str] = set()
    box_lookup: dict[str, dict] = {}
    for box_entry in boxes:
        box = box_entry.get("box", {})
        box_id = box.get("id")
        if box_id:
            box_lookup[box_id] = box
        name = _get_object_name(box)
        if name:
            pkg = db.get_package(name)
            if pkg:
                packages_used.add(pkg)

    # Conditional dispatch per D-12
    if "BEAP" in packages_used:
        results.extend(_check_beap_conventions(box_lookup, lines, db))

    if "Bach" in packages_used:
        results.extend(_check_bach_llll_types(box_lookup, lines, db))

    # Community extraction check (lightweight, always runs)
    results.extend(_check_community_extracted(box_lookup, db))

    return results


# ---------------------------------------------------------------------------
# BEAP convention checks
# ---------------------------------------------------------------------------

def _check_beap_conventions(
    box_lookup: dict[str, dict],
    lines: list[dict],
    db: ObjectDatabase,
) -> list[CriticResult]:
    """Check BEAP signal chain conventions.

    Dispatches to output termination and VCA gain staging checks.
    """
    results: list[CriticResult] = []
    results.extend(_check_beap_output_termination(box_lookup, lines, db))
    results.extend(_check_beap_vca_staging(box_lookup, lines, db))
    return results


def _build_signal_adjacency(
    box_lookup: dict[str, dict],
    lines: list[dict],
) -> dict[str, list[str]]:
    """Build forward signal adjacency from patchlines.

    For bpatcher boxes (BEAP modules), treat all connections as potential
    signal connections since outlettype may not be present in the box dict.
    """
    signal_adj: dict[str, list[str]] = {}
    for line_entry in lines:
        patchline = line_entry.get("patchline", line_entry)
        source = patchline.get("source", [])
        destination = patchline.get("destination", [])
        if len(source) < 2 or len(destination) < 2:
            continue

        src_id, src_outlet = source[0], source[1]
        dst_id = destination[0]

        src_box = box_lookup.get(src_id)
        if not src_box:
            continue

        # For bpatcher boxes, treat all connections as signal
        # (BEAP modules are signal processors)
        if src_box.get("maxclass") == "bpatcher":
            signal_adj.setdefault(src_id, []).append(dst_id)
            continue

        # For other boxes, check outlettype
        src_outlettype = src_box.get("outlettype", [])
        is_signal = (
            src_outlet < len(src_outlettype)
            and src_outlettype[src_outlet] == "signal"
        )
        if is_signal:
            signal_adj.setdefault(src_id, []).append(dst_id)

    return signal_adj


def _get_beap_category(box: dict, db: ObjectDatabase) -> str | None:
    """Get the BEAP category for a box, or None if not BEAP."""
    name = _get_object_name(box)
    if not name:
        return None
    obj_entry = db.lookup(name)
    if obj_entry and obj_entry.get("package") == "BEAP":
        return obj_entry.get("category")
    return None


def _check_beap_output_termination(
    box_lookup: dict[str, dict],
    lines: list[dict],
    db: ObjectDatabase,
) -> list[CriticResult]:
    """Check that BEAP signal chains terminate with an output module.

    BFS from each BEAP source (Oscillator/Input/Random/LFO) through signal
    adjacency. If no path reaches an Output category object, emit warning.
    """
    results: list[CriticResult] = []
    signal_adj = _build_signal_adjacency(box_lookup, lines)

    # Find BEAP source boxes
    beap_sources: list[tuple[str, str]] = []  # (box_id, name)
    for box_id, box in box_lookup.items():
        cat = _get_beap_category(box, db)
        if cat in _BEAP_SOURCE_CATEGORIES:
            beap_sources.append((box_id, _get_object_name(box)))

    # BFS from each source to find output modules
    for src_id, src_name in beap_sources:
        queue = deque([src_id])
        visited: set[str] = set()
        found_output = False

        while queue:
            current_id = queue.popleft()
            if current_id in visited:
                continue
            visited.add(current_id)

            current_box = box_lookup.get(current_id)
            if not current_box:
                continue

            current_name = _get_object_name(current_box)
            if current_name in _BEAP_OUTPUT_NAMES:
                found_output = True
                break

            for next_id in signal_adj.get(current_id, []):
                queue.append(next_id)

        if not found_output:
            results.append(CriticResult(
                "warning",
                f"BEAP missing output: '{src_name}' ({src_id}) signal chain "
                f"does not reach a BEAP output module (bp.Stereo, bp.Mono, etc.)",
                f"Add a bp.Stereo or bp.Mono at the end of the BEAP chain "
                f"to properly terminate the signal",
            ))

    return results


def _check_beap_vca_staging(
    box_lookup: dict[str, dict],
    lines: list[dict],
    db: ObjectDatabase,
) -> list[CriticResult]:
    """Check that BEAP oscillators pass through VCA before output.

    BFS from each BEAP Oscillator to Output. If no Level category object
    (bp.VCA etc.) is in the path, emit warning.
    """
    results: list[CriticResult] = []
    signal_adj = _build_signal_adjacency(box_lookup, lines)

    # Find BEAP oscillator boxes specifically
    beap_oscillators: list[tuple[str, str]] = []
    for box_id, box in box_lookup.items():
        cat = _get_beap_category(box, db)
        if cat == "Oscillator":
            beap_oscillators.append((box_id, _get_object_name(box)))

    for osc_id, osc_name in beap_oscillators:
        # BFS tracking whether we've passed through a gain stage
        queue = deque([(osc_id, False)])  # (current_id, passed_through_gain)
        visited: set[tuple[str, bool]] = set()
        found_ungained_output = False

        while queue:
            current_id, has_gain = queue.popleft()
            state = (current_id, has_gain)
            if state in visited:
                continue
            visited.add(state)

            for next_id in signal_adj.get(current_id, []):
                next_box = box_lookup.get(next_id)
                if not next_box:
                    continue

                next_name = _get_object_name(next_box)
                next_cat = _get_beap_category(next_box, db)
                next_has_gain = has_gain or (next_cat in _BEAP_GAIN_CATEGORIES)

                if next_name in _BEAP_OUTPUT_NAMES:
                    if not next_has_gain:
                        found_ungained_output = True
                    continue  # Don't traverse past output

                queue.append((next_id, next_has_gain))

        if found_ungained_output:
            results.append(CriticResult(
                "warning",
                f"BEAP missing VCA: '{osc_name}' ({osc_id}) reaches output "
                f"without passing through a VCA or Level module for gain staging",
                f"Insert a bp.VCA between '{osc_name}' and the output module "
                f"for proper BEAP gain staging",
            ))

    return results


# ---------------------------------------------------------------------------
# Bach llll type checks
# ---------------------------------------------------------------------------

def _is_llll_inlet(obj_entry: dict, inlet_id: int) -> bool:
    """Check if an object's inlet expects llll data.

    Args:
        obj_entry: Object dict from the database.
        inlet_id: Inlet index to check.

    Returns:
        True if the inlet's digest contains 'llll'.
    """
    for inlet in obj_entry.get("inlets", []):
        if inlet.get("id") == inlet_id:
            return "llll" in inlet.get("digest", "").lower()
    return False


def _check_bach_llll_types(
    box_lookup: dict[str, dict],
    lines: list[dict],
    db: ObjectDatabase,
) -> list[CriticResult]:
    """Detect non-bach objects connected to bach inlets expecting llll.

    For each patchline, check if the destination is a Bach object with an
    llll inlet. If the source is not a Bach object and not bach.list2llll,
    emit a blocker.
    """
    results: list[CriticResult] = []

    for line_entry in lines:
        patchline = line_entry.get("patchline", line_entry)
        source = patchline.get("source", [])
        destination = patchline.get("destination", [])
        if len(source) < 2 or len(destination) < 2:
            continue

        src_id = source[0]
        dst_id, dst_inlet = destination[0], destination[1]

        src_box = box_lookup.get(src_id)
        dst_box = box_lookup.get(dst_id)
        if not src_box or not dst_box:
            continue

        src_name = _get_object_name(src_box)
        dst_name = _get_object_name(dst_box)

        # Only check connections TO bach objects
        dst_entry = db.lookup(dst_name)
        if not dst_entry or dst_entry.get("package") != "Bach":
            continue

        # Skip bach.list2llll -- it's designed to accept plain lists
        if dst_name == "bach.list2llll":
            continue

        # Check if this inlet expects llll
        if not _is_llll_inlet(dst_entry, dst_inlet):
            continue

        # Source must be a bach object (outputs llll) or bach.list2llll
        if src_name == "bach.list2llll":
            continue  # Converter output is llll
        src_entry = db.lookup(src_name)
        src_is_bach = src_entry is not None and src_entry.get("package") == "Bach"

        if not src_is_bach:
            results.append(CriticResult(
                "blocker",
                f"Bach llll type mismatch: '{src_name}' ({src_id}) "
                f"connected to '{dst_name}' ({dst_id}) inlet {dst_inlet} "
                f"which expects llll data -- plain MAX lists will silently "
                f"produce garbage",
                f"Insert 'bach.list2llll' between '{src_name}' and "
                f"'{dst_name}' to convert MAX list to llll format",
            ))

    return results


# ---------------------------------------------------------------------------
# Community extraction check
# ---------------------------------------------------------------------------

def _check_community_extracted(
    box_lookup: dict[str, dict],
    db: ObjectDatabase,
) -> list[CriticResult]:
    """Warn on community/licensed packages that haven't been extracted.

    Checks each unique package used in the patch. If a community or licensed
    package has extracted=False in package_info.json, emit a warning (once
    per package).
    """
    results: list[CriticResult] = []
    warned_packages: set[str] = set()

    for box_id, box in box_lookup.items():
        name = _get_object_name(box)
        if not name:
            continue

        pkg = db.get_package(name)
        if not pkg or pkg in warned_packages:
            continue

        info = db.get_package_info(pkg)
        if not info:
            continue

        tier = info.get("tier", "")
        extracted = info.get("extracted", True)

        if tier in ("community", "licensed") and not extracted:
            warned_packages.add(pkg)
            results.append(CriticResult(
                "warning",
                f"Unextracted community package: '{pkg}' objects used in patch "
                f"but package has not been extracted to the object database -- "
                f"validation coverage may be incomplete",
                f"Run package extraction for '{pkg}' to enable full validation "
                f"and object database lookups",
            ))

    return results
