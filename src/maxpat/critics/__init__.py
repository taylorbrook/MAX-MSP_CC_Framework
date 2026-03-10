"""Critic system -- semantic/architectural review of generated patches.

Provides review_patch() which combines DSP and structure critics to catch
design problems that the mechanical validation pipeline does not detect.

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


def review_patch(
    patch_dict: dict,
    code_context: dict | None = None,
) -> list[CriticResult]:
    """Run all critics on a patch and return combined results.

    Combines DSP critic (signal flow, gen~ I/O, gain staging) and
    structure critic (fan-out, hot/cold ordering, duplicates).

    Args:
        patch_dict: A .maxpat-format dict.
        code_context: Optional dict with code strings for gen~ boxes, etc.

    Returns:
        Combined list of CriticResult from all active critics.
    """
    results: list[CriticResult] = []
    results.extend(review_dsp(patch_dict, code_context=code_context))
    results.extend(review_structure(patch_dict))
    return results


__all__ = [
    "review_patch",
    "review_dsp",
    "review_structure",
    "CriticResult",
]
