"""Structure critic -- checks patch architecture and connection patterns.

Catches structural issues that the mechanical validation pipeline does
not detect:
  - Fan-out without trigger (ordering ambiguity)
  - Hot/cold inlet ordering issues (stale value computation)
  - Redundant/duplicate patchlines

NOTE: Does NOT duplicate validation.py checks. Focus is on architectural
patterns a MAX expert would flag during code review.
"""

from __future__ import annotations

from collections import defaultdict

from src.maxpat.critics.base import CriticResult


# Object names that provide explicit ordering for fan-out
_TRIGGER_NAMES = frozenset({"trigger", "t"})


def review_structure(patch_dict: dict) -> list[CriticResult]:
    """Review structural aspects of a patch.

    Checks:
      1. Fan-out without trigger (2+ destinations from one outlet)
      2. Hot/cold inlet ordering (multiple inlets fed without trigger ordering)
      3. Redundant/duplicate patchlines

    Args:
        patch_dict: A .maxpat-format dict.

    Returns:
        List of CriticResult findings.
    """
    results: list[CriticResult] = []

    patcher = patch_dict.get("patcher", {})
    boxes = patcher.get("boxes", [])
    lines = patcher.get("lines", [])

    # Build box lookup
    box_lookup: dict[str, dict] = {}
    for box_entry in boxes:
        box = box_entry.get("box", {})
        box_id = box.get("id")
        if box_id:
            box_lookup[box_id] = box

    # Run checks
    results.extend(_check_fan_out_without_trigger(box_lookup, lines))
    results.extend(_check_hot_cold_ordering(box_lookup, lines))
    results.extend(_check_redundant_connections(lines))

    return results


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def _get_box_name(box: dict) -> str:
    """Get the object name from a box dict."""
    maxclass = box.get("maxclass", "")
    if maxclass == "newobj":
        text = box.get("text", "")
        if text:
            return text.split()[0]
        return ""
    return maxclass


def _is_trigger_object(box: dict) -> bool:
    """Check if a box is a trigger/t object."""
    name = _get_box_name(box)
    return name in _TRIGGER_NAMES


def _is_signal_object(box: dict) -> bool:
    """Check if a box is a signal-rate (~) object."""
    name = _get_box_name(box)
    return name.endswith("~")


# ---------------------------------------------------------------------------
# Check 1: Fan-out without trigger
# ---------------------------------------------------------------------------

def _check_fan_out_without_trigger(
    box_lookup: dict[str, dict],
    lines: list[dict],
) -> list[CriticResult]:
    """Detect outlets connected to 2+ destinations without trigger.

    Per CLAUDE.md Rule #4: "Use explicit trigger objects for fan-out
    instead of connecting one outlet to multiple inlets."
    """
    results: list[CriticResult] = []

    # Count connections per (source_id, outlet_index)
    fan_out_count: dict[tuple[str, int], list[str]] = defaultdict(list)

    for line_entry in lines:
        patchline = line_entry.get("patchline", line_entry)
        source = patchline.get("source", [])
        destination = patchline.get("destination", [])
        if len(source) < 2 or len(destination) < 2:
            continue

        src_id, src_outlet = source[0], source[1]
        dst_id = destination[0]
        fan_out_count[(src_id, src_outlet)].append(dst_id)

    for (src_id, src_outlet), destinations in fan_out_count.items():
        if len(destinations) < 2:
            continue

        src_box = box_lookup.get(src_id)
        if not src_box:
            continue

        # Skip if source IS a trigger object (that is the whole point)
        if _is_trigger_object(src_box):
            continue

        # Skip signal connections -- all signal inlets are hot per Rule #3
        if _is_signal_object(src_box):
            continue

        src_name = _get_box_name(src_box)
        dst_names = []
        for dst_id in destinations:
            dst_box = box_lookup.get(dst_id)
            if dst_box:
                dst_names.append(f"'{_get_box_name(dst_box)}' ({dst_id})")
            else:
                dst_names.append(dst_id)

        results.append(CriticResult(
            "warning",
            f"Fan-out without trigger: '{src_name}' ({src_id}) outlet "
            f"{src_outlet} connected to {len(destinations)} destinations "
            f"({', '.join(dst_names)}) -- execution order is undefined",
            f"Use a 'trigger' (t) object to explicitly control the order "
            f"of execution for multiple destinations",
        ))

    return results


# ---------------------------------------------------------------------------
# Check 2: Hot/cold inlet ordering
# ---------------------------------------------------------------------------

def _check_hot_cold_ordering(
    box_lookup: dict[str, dict],
    lines: list[dict],
) -> list[CriticResult]:
    """Detect hot/cold inlet ordering issues.

    When multiple separate sources feed different inlets of the same
    destination box, and neither source comes from a trigger object that
    controls ordering, the computation may use stale values.

    Per CLAUDE.md Rule #3: "Send to cold inlets FIRST (right to left),
    send to hot inlet LAST (leftmost, inlet 0) -- this triggers computation."

    Skip signal (~) connections -- all signal inlets are hot in the audio
    domain (Rule #3).
    """
    results: list[CriticResult] = []

    # Group connections by destination box
    # dst_id -> {inlet_idx -> list of (src_id, src_outlet)}
    dst_inlets: dict[str, dict[int, list[tuple[str, int]]]] = defaultdict(
        lambda: defaultdict(list)
    )

    for line_entry in lines:
        patchline = line_entry.get("patchline", line_entry)
        source = patchline.get("source", [])
        destination = patchline.get("destination", [])
        if len(source) < 2 or len(destination) < 2:
            continue

        src_id, src_outlet = source[0], source[1]
        dst_id, dst_inlet = destination[0], destination[1]
        dst_inlets[dst_id][dst_inlet].append((src_id, src_outlet))

    for dst_id, inlets_map in dst_inlets.items():
        dst_box = box_lookup.get(dst_id)
        if not dst_box:
            continue

        # Skip signal objects -- all inlets hot in audio domain
        if _is_signal_object(dst_box):
            continue

        # Only flag if multiple inlets are being fed (hot + cold)
        if len(inlets_map) < 2:
            continue

        # Check if inlet 0 (hot) is present
        if 0 not in inlets_map:
            continue

        # Get all source box IDs feeding this destination
        all_source_ids: set[str] = set()
        for inlet_sources in inlets_map.values():
            for src_id, _ in inlet_sources:
                all_source_ids.add(src_id)

        # Check if sources feeding hot inlet come from a trigger
        hot_sources = inlets_map[0]
        cold_inlet_indices = [idx for idx in inlets_map if idx > 0]

        # If a trigger feeds the hot inlet AND also feeds the cold inlets
        # (through different outlets), ordering is explicit -- no warning
        hot_from_trigger = False
        for src_id, _ in hot_sources:
            src_box = box_lookup.get(src_id)
            if src_box and _is_trigger_object(src_box):
                hot_from_trigger = True
                break

        if hot_from_trigger:
            continue

        # Multiple separate sources feeding hot and cold inlets
        # without trigger-based ordering
        dst_name = _get_box_name(dst_box)
        cold_desc = ", ".join(str(idx) for idx in sorted(cold_inlet_indices))

        results.append(CriticResult(
            "warning",
            f"Hot/cold inlet ordering issue: '{dst_name}' ({dst_id}) "
            f"receives data on inlet 0 (hot) and inlet(s) {cold_desc} "
            f"(cold) from separate sources without trigger ordering -- "
            f"cold inlets may contain stale values when hot inlet triggers",
            f"Use a 'trigger' (t) object to ensure cold inlets are "
            f"updated before hot inlet fires",
        ))

    return results


# ---------------------------------------------------------------------------
# Check 3: Redundant/duplicate connections
# ---------------------------------------------------------------------------

def _check_redundant_connections(
    lines: list[dict],
) -> list[CriticResult]:
    """Detect duplicate patchlines (same source -> same destination)."""
    results: list[CriticResult] = []

    seen: set[tuple[str, int, str, int]] = set()

    for line_entry in lines:
        patchline = line_entry.get("patchline", line_entry)
        source = patchline.get("source", [])
        destination = patchline.get("destination", [])
        if len(source) < 2 or len(destination) < 2:
            continue

        key = (source[0], source[1], destination[0], destination[1])

        if key in seen:
            results.append(CriticResult(
                "warning",
                f"Duplicate patchline: {source[0]} outlet {source[1]} -> "
                f"{destination[0]} inlet {destination[1]} appears multiple times",
                "Remove the duplicate connection",
            ))
        else:
            seen.add(key)

    return results
