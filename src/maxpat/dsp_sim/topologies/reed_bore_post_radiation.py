"""Reed + bore + post-radiation waveguide topology (v0.4.2+ shape) -- STUB.

This minimal stub keeps the topology registry importable during Task 1.
Task 3 replaces this file with the full v0.4.2+ implementation.
"""

from __future__ import annotations

from dataclasses import dataclass, field

import numpy as np


@dataclass
class ReedBorePostRadiation:
    """Stub -- replaced in Task 3 with full v0.4.2+ implementation."""

    sample_rate: float
    params: dict[str, float]
    _initialized: bool = field(init=False, default=False)

    def __post_init__(self) -> None:  # pragma: no cover - replaced in Task 3
        self._initialized = True

    def step(self, in1: float, in2: float) -> float:  # pragma: no cover - replaced in Task 3
        return 0.0
