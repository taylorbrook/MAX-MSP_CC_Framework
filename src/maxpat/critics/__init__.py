"""Critic system -- semantic/architectural review of generated patches.

Provides review_patch() which combines DSP, structure, RNBO, and external
critics to catch design problems that the mechanical validation pipeline
does not detect.

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
from src.maxpat.critics.rnbo_critic import review_rnbo
from src.maxpat.critics.ext_critic import review_external


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
    and external critic (code structure, archetype requirements).

    The RNBO critic is only invoked when rnbo~ boxes are detected
    in the patch. The external critic is only invoked when ext_code
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

    # RNBO critic: auto-invoke when rnbo~ boxes detected
    if _has_rnbo_boxes(patch_dict):
        results.extend(review_rnbo(patch_dict, code_context=code_context))

    # External critic: invoke when ext_code provided
    if ext_code is not None:
        results.extend(review_external(ext_code, archetype=ext_archetype))

    return results


__all__ = [
    "review_patch",
    "review_dsp",
    "review_structure",
    "review_rnbo",
    "review_external",
    "CriticResult",
]
