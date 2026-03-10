"""Critic system -- semantic/architectural review of generated patches.

Provides review_patch() which combines DSP and structure critics to catch
design problems that the mechanical validation pipeline does not detect.
"""

from __future__ import annotations

from src.maxpat.critics.base import CriticResult
from src.maxpat.critics.dsp_critic import review_dsp

# Structure critic stub -- will be implemented in Task 2
try:
    from src.maxpat.critics.structure_critic import review_structure as _review_structure
except ImportError:
    _review_structure = None


def review_patch(
    patch_dict: dict,
    code_context: dict | None = None,
) -> list[CriticResult]:
    """Run all critics on a patch and return combined results.

    Args:
        patch_dict: A .maxpat-format dict.
        code_context: Optional dict with code strings for gen~ boxes, etc.

    Returns:
        Combined list of CriticResult from all active critics.
    """
    results: list[CriticResult] = []
    results.extend(review_dsp(patch_dict, code_context=code_context))
    if _review_structure is not None:
        results.extend(_review_structure(patch_dict))
    return results


__all__ = [
    "review_patch",
    "CriticResult",
    "review_dsp",
]
