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


# ===========================================================================
# RNBO Container Generation
# ===========================================================================

# Singleton RNBODatabase for validation during add_rnbo
_rnbo_db_instance: RNBODatabase | None = None


def _get_rnbo_db() -> RNBODatabase:
    """Get or create the singleton RNBODatabase."""
    global _rnbo_db_instance
    if _rnbo_db_instance is None:
        _rnbo_db_instance = RNBODatabase()
    return _rnbo_db_instance


# RNBO patcher background color (light blue-gray, distinct from gen~)
RNBO_PATCHER_BGCOLOR = [0.85, 0.88, 0.92, 1.0]


def add_rnbo(
    patcher: Any,
    objects: list[dict] | None = None,
    params: list[dict] | None = None,
    target: str = "plugin",
    audio_ins: int = 2,
    audio_outs: int = 2,
    x: float = 0.0,
    y: float = 0.0,
) -> tuple[Any, Any]:
    """Add an rnbo~ object with inner RNBO patcher to a Patcher.

    Creates a parent rnbo~ box (via Box.__new__ bypass pattern) containing
    an inner RNBO patcher with in~/out~ for audio, param objects for
    parameters, inport/outport for messages, and user-specified objects.

    Args:
        patcher: Patcher instance to add the rnbo~ box to.
        objects: Optional list of object dicts to add inside the RNBO patcher.
            Each dict has "name" (str) and optional "args" (list[str]).
        params: Optional list of param dicts, each with "name", "default",
            "min", "max" keys.
        target: Export target ("plugin", "web", "cpp").
        audio_ins: Number of audio input channels.
        audio_outs: Number of audio output channels.
        x: Horizontal position of the rnbo~ box.
        y: Vertical position of the rnbo~ box.

    Returns:
        (parent_box, inner_patcher) tuple.

    Raises:
        ValueError: If any object in objects list is not RNBO-compatible.
    """
    # Lazy imports to avoid circular dependencies
    from src.maxpat.patcher import Box, Patcher as PatcherClass
    from src.maxpat.defaults import FONT_NAME, FONT_SIZE
    from src.maxpat.sizing import calculate_box_size

    if objects is None:
        objects = []
    if params is None:
        params = []

    rnbo_db = _get_rnbo_db()

    # Validate all user-specified objects are RNBO-compatible
    for obj_spec in objects:
        name = obj_spec["name"]
        if not rnbo_db.is_rnbo_compatible(name):
            raise ValueError(
                f"Object '{name}' is not RNBO-compatible -- "
                f"cannot be used in RNBO patches"
            )

    # Generate box ID from the parent patcher
    box_id = patcher._gen_id()

    # Create inner RNBO patcher
    inner = PatcherClass(db=patcher.db, is_subpatcher=True)
    inner.props["bgcolor"] = list(RNBO_PATCHER_BGCOLOR)
    inner.props["rect"] = [100.0, 100.0, 700.0, 500.0]

    # Add in~ objects (audio inputs)
    for i in range(audio_ins):
        in_box = Box.__new__(Box)
        in_box.name = "in~"
        in_box.args = [str(i + 1)]
        in_box.id = inner._gen_id()
        in_box.maxclass = "newobj"
        in_box.text = f"in~ {i + 1}"
        in_box.numinlets = 0
        in_box.numoutlets = 1
        in_box.outlettype = ["signal"]
        in_box.patching_rect = [50.0 + i * 100.0, 30.0, 40.0, 22.0]
        in_box.fontname = FONT_NAME
        in_box.fontsize = FONT_SIZE
        in_box.presentation = False
        in_box.presentation_rect = None
        in_box.extra_attrs = {}
        in_box._inner_patcher = None
        in_box._saved_object_attributes = None
        in_box._bpatcher_attrs = None
        inner.boxes.append(in_box)

    # Add out~ objects (audio outputs)
    for i in range(audio_outs):
        out_box = Box.__new__(Box)
        out_box.name = "out~"
        out_box.args = [str(i + 1)]
        out_box.id = inner._gen_id()
        out_box.maxclass = "newobj"
        out_box.text = f"out~ {i + 1}"
        out_box.numinlets = 1
        out_box.numoutlets = 0
        out_box.outlettype = []
        out_box.patching_rect = [50.0 + i * 100.0, 400.0, 40.0, 22.0]
        out_box.fontname = FONT_NAME
        out_box.fontsize = FONT_SIZE
        out_box.presentation = False
        out_box.presentation_rect = None
        out_box.extra_attrs = {}
        out_box._inner_patcher = None
        out_box._saved_object_attributes = None
        out_box._bpatcher_attrs = None
        inner.boxes.append(out_box)

    # Add param objects
    for i, param in enumerate(params):
        param_name = param["name"]
        param_default = param.get("default", 0.0)
        param_min = param.get("min", 0.0)
        param_max = param.get("max", 1.0)
        param_text = (
            f"param @name {param_name} "
            f"@min {param_min} @max {param_max} @initial {param_default}"
        )

        param_box = Box.__new__(Box)
        param_box.name = "param"
        param_box.args = []
        param_box.id = inner._gen_id()
        param_box.maxclass = "newobj"
        param_box.text = param_text
        param_box.numinlets = 2
        param_box.numoutlets = 2
        param_box.outlettype = ["", ""]
        param_box.patching_rect = [
            50.0 + (audio_ins + i) * 100.0,
            30.0,
            len(param_text) * 7.0 + 16.0,
            22.0,
        ]
        param_box.fontname = FONT_NAME
        param_box.fontsize = FONT_SIZE
        param_box.presentation = False
        param_box.presentation_rect = None
        param_box.extra_attrs = {}
        param_box._inner_patcher = None
        param_box._saved_object_attributes = None
        param_box._bpatcher_attrs = None
        inner.boxes.append(param_box)

    # Add inport (message input)
    inport_box = Box.__new__(Box)
    inport_box.name = "inport"
    inport_box.args = []
    inport_box.id = inner._gen_id()
    inport_box.maxclass = "newobj"
    inport_box.text = "inport"
    inport_box.numinlets = 0
    inport_box.numoutlets = 1
    inport_box.outlettype = [""]
    inport_box.patching_rect = [500.0, 30.0, 50.0, 22.0]
    inport_box.fontname = FONT_NAME
    inport_box.fontsize = FONT_SIZE
    inport_box.presentation = False
    inport_box.presentation_rect = None
    inport_box.extra_attrs = {}
    inport_box._inner_patcher = None
    inport_box._saved_object_attributes = None
    inport_box._bpatcher_attrs = None
    inner.boxes.append(inport_box)

    # Add outport (message output)
    outport_box = Box.__new__(Box)
    outport_box.name = "outport"
    outport_box.args = []
    outport_box.id = inner._gen_id()
    outport_box.maxclass = "newobj"
    outport_box.text = "outport"
    outport_box.numinlets = 1
    outport_box.numoutlets = 0
    outport_box.outlettype = []
    outport_box.patching_rect = [500.0, 400.0, 50.0, 22.0]
    outport_box.fontname = FONT_NAME
    outport_box.fontsize = FONT_SIZE
    outport_box.presentation = False
    outport_box.presentation_rect = None
    outport_box.extra_attrs = {}
    outport_box._inner_patcher = None
    outport_box._saved_object_attributes = None
    outport_box._bpatcher_attrs = None
    inner.boxes.append(outport_box)

    # Add user-specified objects (validated above)
    for obj_spec in objects:
        obj_name = obj_spec["name"]
        obj_args = obj_spec.get("args", [])
        obj_text = " ".join([obj_name] + obj_args).strip()

        user_box = Box.__new__(Box)
        user_box.name = obj_name
        user_box.args = obj_args
        user_box.id = inner._gen_id()
        user_box.maxclass = "newobj"
        user_box.text = obj_text
        # Look up RNBO I/O counts if available
        rnbo_obj = rnbo_db.lookup(obj_name)
        if rnbo_obj:
            user_box.numinlets = len(rnbo_obj.get("inlets", []))
            user_box.numoutlets = len(rnbo_obj.get("outlets", []))
            user_box.outlettype = _derive_outlet_types(rnbo_obj)
        else:
            user_box.numinlets = 1
            user_box.numoutlets = 1
            user_box.outlettype = [""]
        user_box.patching_rect = [200.0, 200.0, len(obj_text) * 7.0 + 16.0, 22.0]
        user_box.fontname = FONT_NAME
        user_box.fontsize = FONT_SIZE
        user_box.presentation = False
        user_box.presentation_rect = None
        user_box.extra_attrs = {}
        user_box._inner_patcher = None
        user_box._saved_object_attributes = None
        user_box._bpatcher_attrs = None
        inner.boxes.append(user_box)

    # Create the parent rnbo~ box via Box.__new__ (structural container)
    w, h = calculate_box_size("rnbo~", "newobj")

    parent_box = Box.__new__(Box)
    parent_box.name = "rnbo~"
    parent_box.args = []
    parent_box.id = box_id
    parent_box.maxclass = "rnbo~"
    parent_box.text = "rnbo~"
    parent_box.numinlets = audio_ins + 1    # audio inputs + 1 message inlet
    parent_box.numoutlets = audio_outs + 1  # audio outputs + 1 message outlet
    parent_box.outlettype = ["signal"] * audio_outs + [""]
    parent_box.patching_rect = [x, y, w, h]
    parent_box.fontname = FONT_NAME
    parent_box.fontsize = FONT_SIZE
    parent_box.presentation = False
    parent_box.presentation_rect = None
    parent_box.extra_attrs = {}
    parent_box._inner_patcher = inner
    parent_box._saved_object_attributes = None
    parent_box._bpatcher_attrs = None

    patcher.boxes.append(parent_box)
    return (parent_box, inner)


def _derive_outlet_types(obj_data: dict) -> list[str]:
    """Derive outlettype array from RNBO object data."""
    result = []
    for outlet in obj_data.get("outlets", []):
        if outlet.get("signal"):
            result.append("signal")
        else:
            result.append("")
    return result


def generate_rnbo_wrapper(
    params: list[dict] | None = None,
    target: str = "plugin",
    audio_ins: int = 2,
    audio_outs: int = 2,
) -> Any:
    """Build a complete Patcher ready to open in MAX and export via RNBO.

    Creates a top-level Patcher with:
    - adc~ for audio input
    - rnbo~ container (via add_rnbo)
    - dac~ for audio output
    - Connections: adc~ -> rnbo~ -> dac~

    Args:
        params: Optional list of param dicts for RNBO param objects.
        target: Export target ("plugin", "web", "cpp").
        audio_ins: Number of audio input channels.
        audio_outs: Number of audio output channels.

    Returns:
        Patcher instance (caller can use to_dict() or write to file).
    """
    from src.maxpat.patcher import Patcher as PatcherClass
    from src.maxpat.sizing import calculate_box_size

    if params is None:
        params = []

    p = PatcherClass()

    # Add adc~ for audio input
    adc_args = [str(audio_ins)] if audio_ins > 1 else []
    adc_box = p.add_box("adc~", args=adc_args, x=50.0, y=50.0)

    # Add rnbo~ container
    rnbo_box, inner = add_rnbo(
        p,
        params=params,
        target=target,
        audio_ins=audio_ins,
        audio_outs=audio_outs,
        x=50.0,
        y=200.0,
    )

    # Add dac~ for audio output
    dac_args = [str(audio_outs)] if audio_outs > 1 else []
    dac_box = p.add_box("dac~", args=dac_args, x=50.0, y=350.0)

    # Connect adc~ -> rnbo~ (signal inputs)
    for i in range(audio_ins):
        p.add_connection(adc_box, i, rnbo_box, i)

    # Connect rnbo~ -> dac~ (signal outputs)
    for i in range(audio_outs):
        p.add_connection(rnbo_box, i, dac_box, i)

    return p
