"""RNBO patch generation: RNBODatabase, param extraction, add_rnbo, wrapper generation.

Provides a dedicated RNBO object database that avoids the core-domain-priority
issue in ObjectDatabase (where MSP cycle~ overwrites RNBO cycle~ with different
outlet count). Also provides GenExpr Param extraction and rnbo~ container
generation following the established Box.__new__ pattern.

Exports:
- RNBODatabase: RNBO-specific object lookup
- parse_genexpr_params: Extract Param declarations from GenExpr code
- add_rnbo: Create rnbo~ container box with inner RNBO patcher
- generate_rnbo_wrapper: Build complete ready-to-export .maxpat
"""

from __future__ import annotations

import json
import re
from pathlib import Path
from typing import Any


class RNBODatabase:
    """RNBO-specific object database for generation and validation.

    Reads .claude/max-objects/rnbo/objects.json directly to get RNBO-specific
    I/O counts (avoiding the namespace collision where ObjectDatabase gives
    MSP cycle~ with 1 outlet instead of RNBO cycle~ with 2 outlets).

    Also scans other domains for objects marked rnbo_compatible=true to build
    the full RNBO compatibility set.
    """

    def __init__(self, db_root: str | Path | None = None):
        """Initialize the RNBO database.

        Args:
            db_root: Path to .claude/max-objects/. Defaults to project root.
        """
        if db_root is None:
            db_root = Path(__file__).resolve().parents[2] / ".claude" / "max-objects"
        else:
            db_root = Path(db_root)

        self._rnbo_objects: dict[str, dict] = {}
        self._compat_objects: set[str] = set()
        self._load(db_root)

    def _load(self, db_root: Path) -> None:
        """Load RNBO object data from disk."""
        # Load RNBO-specific objects (authoritative for I/O counts)
        rnbo_path = db_root / "rnbo" / "objects.json"
        if rnbo_path.exists():
            self._rnbo_objects = json.loads(rnbo_path.read_text())

        # Start with all RNBO domain objects as compatible
        self._compat_objects = set(self._rnbo_objects.keys())

        # Scan other domains for rnbo_compatible=true flags
        for domain in ["max", "msp", "gen", "mc", "jitter"]:
            domain_path = db_root / domain / "objects.json"
            if domain_path.exists():
                data = json.loads(domain_path.read_text())
                for name, obj in data.items():
                    if obj.get("rnbo_compatible"):
                        self._compat_objects.add(name)

    def is_rnbo_compatible(self, name: str) -> bool:
        """Check if an object can be used in RNBO patches.

        Returns True if the object is in rnbo/objects.json OR marked
        rnbo_compatible in any other domain.

        Args:
            name: Object name.

        Returns:
            True if RNBO-compatible.
        """
        return name in self._compat_objects

    def lookup(self, name: str) -> dict | None:
        """Look up RNBO object data with RNBO-specific I/O counts.

        Only returns data from the RNBO domain. Use is_rnbo_compatible()
        to check if an object from another domain can be used in RNBO.

        Args:
            name: Object name.

        Returns:
            RNBO object dict, or None if not in RNBO domain.
        """
        return self._rnbo_objects.get(name)


def parse_genexpr_params(code: str) -> list[dict]:
    """Extract Param declarations from GenExpr code.

    Matches patterns like: Param name(default, min=min_val, max=max_val);
    Returns a list of dicts with name/default/min/max.

    Args:
        code: GenExpr source code string.

    Returns:
        List of param dicts: [{"name": str, "default": float, "min": float, "max": float}]
    """
    pattern = r"Param\s+(\w+)\(([^)]+)\);"
    params: list[dict] = []

    for match in re.finditer(pattern, code):
        name = match.group(1)
        args_str = match.group(2)

        # Parse: default, min=val, max=val
        parts = [p.strip() for p in args_str.split(",")]
        default = float(parts[0]) if parts else 0.0
        min_val = 0.0
        max_val = 1.0

        for part in parts[1:]:
            if part.startswith("min="):
                min_val = float(part[4:])
            elif part.startswith("max="):
                max_val = float(part[4:])

        params.append({
            "name": name,
            "default": default,
            "min": min_val,
            "max": max_val,
        })

    return params
