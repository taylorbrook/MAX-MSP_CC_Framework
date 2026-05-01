"""Reed + bore waveguide topology -- STUB (filled in Task 2 of plan 32-02).

This minimal stub keeps the topology registry importable during Task 1.
Task 2 replaces this file with the full McIntyre-Woodhouse reed model.
"""

from __future__ import annotations

from dataclasses import dataclass, field

import numpy as np


@dataclass
class ReedBore:
    """Stub -- replaced in Task 2 with full reed + bore implementation."""

    sample_rate: float
    params: dict[str, float]
    _initialized: bool = field(init=False, default=False)

    def __post_init__(self) -> None:  # pragma: no cover - replaced in Task 2
        self._initialized = True

    def step(self, in1: float, in2: float) -> float:  # pragma: no cover - replaced in Task 2
        return 0.0
