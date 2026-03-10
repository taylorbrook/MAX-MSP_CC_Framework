"""DSP critic -- checks signal flow, gen~ I/O matching, and gain staging.

Stub implementation -- all checks return empty lists. Will be implemented
to make tests pass.
"""

from __future__ import annotations

from src.maxpat.critics.base import CriticResult


def review_dsp(
    patch_dict: dict,
    code_context: dict | None = None,
) -> list[CriticResult]:
    """Review DSP aspects of a patch.

    Stub -- returns empty list. Tests should FAIL.
    """
    return []
