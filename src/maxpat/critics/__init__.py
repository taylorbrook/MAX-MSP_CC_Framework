"""Critic system -- semantic/architectural review of generated patches.

Provides review_patch() which combines DSP, structure, layout, RNBO, M4L,
and external critics to catch design problems that the mechanical validation
pipeline does not detect.

Usage:
    from src.maxpat.critics import review_patch, CriticResult

    results = review_patch(patch_dict)
    for r in results:
        print(r)  # [severity] finding
"""

from __future__ import annotations

from src.maxpat.critics.base import CriticResult
from src.maxpat.critics.dsp_critic import review_dsp
from src.maxpat.critics.structure_critic import review_structure
from src.maxpat.critics.layout_critic import review_layout
from src.maxpat.critics.rnbo_critic import review_rnbo
from src.maxpat.critics.ext_critic import review_external
from src.maxpat.critics.m4l_critic import review_m4l
from src.maxpat.utils import get_box_name


def detect_device_type(patch_dict: dict) -> str | None:
    """Public API for M4L device type detection.

    Scans boxes for M4L indicator objects (live.thisdevice, plugin~,
    plugout~, midiin, midiout). Must have live.thisdevice to be M4L.

    Returns:
        "audio_effect", "instrument", "midi_effect", or None.
    """
    patcher = patch_dict.get("patcher", {})
    boxes = patcher.get("boxes", [])

    has_live_thisdevice = False
    has_plugin = False
    has_plugout = False
    has_midiin = False
    has_midiout = False

    for box_entry in boxes:
        box = box_entry.get("box", {})
        maxclass = box.get("maxclass", "")
        name = get_box_name(box)

        if maxclass == "live.thisdevice" or name == "live.thisdevice":
            has_live_thisdevice = True
        if name == "plugin~":
            has_plugin = True
        if name == "plugout~":
            has_plugout = True
        if name == "midiin":
            has_midiin = True
        if name == "midiout":
            has_midiout = True

    if not has_live_thisdevice:
        return None

    # Classify device type
    if has_plugin and has_plugout:
        return "audio_effect"
    if has_plugin and not has_plugout:
        return "audio_effect"  # plugin~ only exists in M4L audio effects
    if has_plugout and has_midiin:
        return "instrument"
    if has_midiin and has_midiout and not has_plugout:
        return "midi_effect"
    if has_plugout:
        return "audio_effect"

    return None


# Backward-compat alias -- old private name still works
_detect_m4l_device = detect_device_type


def _has_rnbo_boxes(patch_dict: dict) -> bool:
    """Check if a patch contains any rnbo~ boxes."""
    patcher = patch_dict.get("patcher", {})
    boxes = patcher.get("boxes", [])
    for box_entry in boxes:
        box = box_entry.get("box", {})
        if box.get("maxclass") == "rnbo~":
            return True
    return False


def review_patch(
    patch_dict: dict,
    code_context: dict | None = None,
    ext_code: str | None = None,
    ext_archetype: str = "message",
) -> list[CriticResult]:
    """Run all critics on a patch and return combined results.

    Combines DSP critic (signal flow, gen~ I/O, gain staging),
    structure critic (fan-out, hot/cold ordering, duplicates),
    RNBO critic (param naming, I/O completeness, duplicates),
    M4L critic (device completeness, gain~/plugout~, params),
    and external critic (code structure, archetype requirements).

    The RNBO critic is only invoked when rnbo~ boxes are detected
    in the patch. The M4L critic is only invoked when an M4L device
    type is detected. The external critic is only invoked when ext_code
    is provided.

    Args:
        patch_dict: A .maxpat-format dict.
        code_context: Optional dict with code strings for gen~ boxes, etc.
            May also contain "rnbo_target" for RNBO target fitness checks.
        ext_code: Optional C++ source code string for external code review.
        ext_archetype: Archetype for external code review ("message", "dsp",
            "scheduler"). Only used when ext_code is provided.

    Returns:
        Combined list of CriticResult from all active critics.
    """
    results: list[CriticResult] = []
    results.extend(review_dsp(patch_dict, code_context=code_context))
    results.extend(review_structure(patch_dict))
    results.extend(review_layout(patch_dict))

    # RNBO critic: auto-invoke when rnbo~ boxes detected
    if _has_rnbo_boxes(patch_dict):
        results.extend(review_rnbo(patch_dict, code_context=code_context))

    # External critic: invoke when ext_code provided
    if ext_code is not None:
        results.extend(review_external(ext_code, archetype=ext_archetype))

    # M4L critic: auto-invoke when M4L device detected
    device_type = detect_device_type(patch_dict)
    if device_type is not None:
        results.extend(review_m4l(patch_dict, device_type=device_type))

    return results


__all__ = [
    "review_patch",
    "review_dsp",
    "review_structure",
    "review_layout",
    "review_rnbo",
    "review_external",
    "review_m4l",
    "detect_device_type",
    "_detect_m4l_device",
    "CriticResult",
]
