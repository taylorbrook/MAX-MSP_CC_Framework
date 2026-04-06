"""M4L critic -- semantic review of Max for Live devices.

Catches M4L-specific issues that the mechanical validation pipeline
does not detect:
  - gain~ connected directly to plugout~ (Ableton handles volume)
  - Missing required objects per device type
  - Duplicate parameter_longname across device (including subpatchers)
  - Device quality: openinpresentation, devicewidth, parameter_enable
"""

from __future__ import annotations

from src.maxpat.critics.base import CriticResult
from src.maxpat.utils import get_box_name


# Required objects per M4L device type
_REQUIRED_OBJECTS = {
    "audio_effect": {"plugout~", "live.thisdevice"},
    "instrument": {"plugout~", "midiin", "midiout", "live.thisdevice"},
    "midi_effect": {"midiin", "midiout", "live.thisdevice"},
}

# live.* maxclasses that should NOT require parameter_enable
_LIVE_NO_PARAM = frozenset({"live.thisdevice", "live.banks", "live.path",
                             "live.object", "live.observer", "live.remote~",
                             "live.scope~", "live.colors"})


def review_m4l(
    patch_dict: dict,
    device_type: str | None = None,
) -> list[CriticResult]:
    """Review M4L aspects of a patch.

    Args:
        patch_dict: A .maxpat-format dict.
        device_type: One of "audio_effect", "instrument", "midi_effect".
            If None, returns empty list (caller should detect type).

    Returns:
        List of CriticResult findings.
    """
    if device_type is None:
        return []

    results: list[CriticResult] = []

    patcher = patch_dict.get("patcher", {})
    boxes = patcher.get("boxes", [])
    lines = patcher.get("lines", [])

    results.extend(_check_gain_plugout(boxes, lines))
    results.extend(_check_device_completeness(boxes, device_type))
    results.extend(_check_parameter_uniqueness(boxes))
    results.extend(_check_device_quality(patcher, boxes))

    return results


# ---------------------------------------------------------------------------
# Check 1: gain~ -> plugout~ detection
# ---------------------------------------------------------------------------

def _check_gain_plugout(
    boxes: list[dict],
    lines: list[dict],
) -> list[CriticResult]:
    """Detect gain~ connected directly to plugout~.

    In M4L devices, Ableton's channel strip handles volume control.
    gain~ before plugout~ is unnecessary and may cause issues.
    """
    results: list[CriticResult] = []

    # Build box lookup
    box_lookup: dict[str, dict] = {}
    for box_entry in boxes:
        box = box_entry.get("box", box_entry)
        box_id = box.get("id")
        if box_id:
            box_lookup[box_id] = box

    for line_entry in lines:
        patchline = line_entry.get("patchline", line_entry)
        source = patchline.get("source", [])
        destination = patchline.get("destination", [])
        if len(source) < 2 or len(destination) < 2:
            continue

        src_id = source[0]
        dst_id = destination[0]

        src_box = box_lookup.get(src_id)
        dst_box = box_lookup.get(dst_id)
        if not src_box or not dst_box:
            continue

        src_name = get_box_name(src_box)
        dst_name = get_box_name(dst_box)

        if src_name == "gain~" and dst_name == "plugout~":
            results.append(CriticResult(
                "blocker",
                f"gain~ ({src_id}) connected directly to plugout~ ({dst_id}) "
                f"-- Ableton's channel strip handles volume, gain~ is "
                f"unnecessary and may cause issues",
                "Remove gain~ and connect signal source directly to plugout~",
            ))

    return results


# ---------------------------------------------------------------------------
# Check 2: Device completeness
# ---------------------------------------------------------------------------

def _check_device_completeness(
    boxes: list[dict],
    device_type: str,
) -> list[CriticResult]:
    """Check that all required objects are present for the device type."""
    results: list[CriticResult] = []

    required = _REQUIRED_OBJECTS.get(device_type)
    if not required:
        return results

    # Collect all object names present in the patch
    present_names: set[str] = set()
    for box_entry in boxes:
        box = box_entry.get("box", box_entry)
        name = get_box_name(box)
        if name:
            present_names.add(name)
        # Also check maxclass for live.thisdevice
        maxclass = box.get("maxclass", "")
        if maxclass == "live.thisdevice":
            present_names.add("live.thisdevice")

    for obj_name in sorted(required):
        if obj_name not in present_names:
            results.append(CriticResult(
                "blocker",
                f"M4L {device_type} missing required object: {obj_name}",
                f"Add {obj_name} to the device",
            ))

    return results


# ---------------------------------------------------------------------------
# Check 3: Parameter longname uniqueness
# ---------------------------------------------------------------------------

def _collect_parameter_longnames(
    boxes: list[dict],
) -> list[tuple[str, str, str]]:
    """Recursively collect (longname, box_id, status) from all boxes.

    status is "ok" for non-empty longnames, "empty" for empty/missing.
    Recurses into subpatcher boxes.
    """
    results: list[tuple[str, str, str]] = []

    for box_entry in boxes:
        box = box_entry.get("box", box_entry)
        box_id = box.get("id", "?")

        # Check for parameter_longname in saved_attribute_attributes
        saa = box.get("saved_attribute_attributes", {})
        valueof = saa.get("valueof", {})
        longname = valueof.get("parameter_longname")

        if longname is not None:
            if longname == "" or longname.strip() == "":
                results.append((longname, box_id, "empty"))
            else:
                results.append((longname, box_id, "ok"))

        # Recurse into subpatcher
        inner_patcher = box.get("patcher")
        if inner_patcher:
            inner_boxes = inner_patcher.get("boxes", [])
            results.extend(_collect_parameter_longnames(inner_boxes))

    return results


def _check_parameter_uniqueness(
    boxes: list[dict],
) -> list[CriticResult]:
    """Check for duplicate parameter_longname across the entire device."""
    results: list[CriticResult] = []

    all_params = _collect_parameter_longnames(boxes)

    # Warn about empty longnames
    for longname, box_id, status in all_params:
        if status == "empty":
            results.append(CriticResult(
                "warning",
                f"Parameter in box '{box_id}' has empty longname -- "
                f"parameter_enable is set but no explicit parameter_longname",
                "Set a descriptive parameter_longname for the control",
            ))

    # Check for duplicates among non-empty longnames
    seen: dict[str, str] = {}  # longname -> first box_id
    for longname, box_id, status in all_params:
        if status != "ok":
            continue
        if longname in seen:
            results.append(CriticResult(
                "blocker",
                f"Duplicate parameter_longname '{longname}' in boxes "
                f"'{seen[longname]}' and '{box_id}' -- each parameter must "
                f"have a unique longname",
                f"Rename one of the duplicate '{longname}' parameters",
            ))
        else:
            seen[longname] = box_id

    return results


# ---------------------------------------------------------------------------
# Check 4: Device quality
# ---------------------------------------------------------------------------

def _check_device_quality(
    patcher: dict,
    boxes: list[dict],
) -> list[CriticResult]:
    """Check M4L device quality: presentation mode, width, parameter_enable."""
    results: list[CriticResult] = []

    # Check patcher-level properties
    if not patcher.get("openinpresentation"):
        results.append(CriticResult(
            "warning",
            "M4L device missing openinpresentation=1 -- device UI will not "
            "display in Ableton",
            "Set openinpresentation=1 on the patcher",
        ))

    if not patcher.get("devicewidth"):
        results.append(CriticResult(
            "warning",
            "M4L device missing devicewidth -- Ableton will use default width",
            "Set devicewidth to control device width in Ableton (e.g., 300.0)",
        ))

    # Check live.* controls for parameter_enable
    for box_entry in boxes:
        box = box_entry.get("box", box_entry)
        maxclass = box.get("maxclass", "")

        if not maxclass.startswith("live."):
            continue

        # Skip non-parameter live objects
        if maxclass in _LIVE_NO_PARAM:
            continue

        if not box.get("parameter_enable"):
            box_id = box.get("id", "?")
            results.append(CriticResult(
                "warning",
                f"{maxclass} ({box_id}) missing parameter_enable=1 -- "
                f"control will not be automatable or saveable in Ableton",
                f"Set parameter_enable=1 on {maxclass} and add "
                f"saved_attribute_attributes with longname/shortname",
            ))

    return results
