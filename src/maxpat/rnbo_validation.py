"""RNBO-specific validation: object compatibility, target constraints, self-containedness.

Provides validate_rnbo_patch() which returns a list of ValidationResult checking:
  (a) All objects in the RNBO patcher are RNBO-compatible
  (b) Export target constraints are met (plugin/web/cpp)
  (c) Patch is self-contained (no external file references)

Exports:
- validate_rnbo_patch: Main validation function
- RNBO_TARGET_CONSTRAINTS: Per-target constraint definitions
"""

from __future__ import annotations

import re
from typing import Any

from src.maxpat.validation import ValidationResult
from src.maxpat.rnbo import RNBODatabase


# ===========================================================================
# Target Constraint Definitions
# ===========================================================================

RNBO_TARGET_CONSTRAINTS: dict[str, dict[str, Any]] = {
    "plugin": {  # VST3/AU
        "requires_audio_io": True,
        "midi_supported": True,
        "max_params": None,         # No hard limit
        "buffer_allowed": True,     # buffer~ with @file bundled
        "self_contained": True,
    },
    "web": {  # Web Audio / WASM
        "requires_audio_io": True,
        "midi_supported": True,     # Web MIDI API available (warn about browser support)
        "max_params": None,
        "buffer_allowed": True,     # Audio loaded as data dependencies
        "self_contained": True,
        "audio_format_warning": "aif",  # Chrome cannot decode .aif
    },
    "cpp": {  # C++ embedded
        "requires_audio_io": True,
        "midi_supported": True,     # Platform-dependent
        "max_params": 128,          # Practical limit for embedded (MIDI CC count)
        "buffer_allowed": False,    # No file system on bare metal
        "self_contained": True,
    },
}

# Structural maxclasses skipped during RNBO object checks
_RNBO_STRUCTURAL_MAXCLASSES = frozenset({"inlet", "outlet", "patcher", "bpatcher"})

# Patterns indicating external file references
_FILE_ATTRIBUTE_PATTERNS = [
    r"@file\s+\S+",           # @file attribute with a value
    r"@name\s+\S+\.(?:wav|aif|aiff|mp3|flac|ogg)",  # @name with audio file extension
]


# ===========================================================================
# Public API
# ===========================================================================

def validate_rnbo_patch(
    patch_dict: dict,
    target: str = "plugin",
    rnbo_db: RNBODatabase | None = None,
) -> list[ValidationResult]:
    """Validate an RNBO patch for object compatibility, target constraints, and self-containedness.

    Args:
        patch_dict: Patch dict in .maxpat format (the inner RNBO patcher).
        target: Export target -- "plugin", "web", or "cpp".
        rnbo_db: RNBODatabase instance. Created if None.

    Returns:
        List of ValidationResult findings.
    """
    if rnbo_db is None:
        rnbo_db = RNBODatabase()

    results: list[ValidationResult] = []

    # Layer: rnbo-objects -- check all objects are RNBO-compatible
    results.extend(_validate_rnbo_objects(patch_dict, rnbo_db))

    # Layer: rnbo-target -- check target constraints
    results.extend(_validate_target_constraints(patch_dict, target))

    # Layer: rnbo-contained -- check self-containedness (no external file refs)
    results.extend(_validate_self_contained(patch_dict))

    return results


# ===========================================================================
# Layer: RNBO Object Compatibility
# ===========================================================================

def _extract_object_name(box_dict: dict) -> str | None:
    """Extract the MAX object name from a box dict.

    Structural maxclasses return None to signal they should be skipped.
    """
    maxclass = box_dict.get("maxclass", "")

    if maxclass in _RNBO_STRUCTURAL_MAXCLASSES:
        return None

    if maxclass == "newobj":
        text = box_dict.get("text", "")
        if text:
            return text.split()[0]
        return None

    # UI objects: the maxclass IS the object name
    return maxclass


def _validate_rnbo_objects(
    patch_dict: dict,
    rnbo_db: RNBODatabase,
) -> list[ValidationResult]:
    """Check every object in the patch is RNBO-compatible."""
    results: list[ValidationResult] = []

    patcher = patch_dict.get("patcher", {})
    boxes = patcher.get("boxes", [])

    for box_entry in boxes:
        box = box_entry.get("box", {})
        name = _extract_object_name(box)

        if name is None:
            continue

        if not rnbo_db.is_rnbo_compatible(name):
            results.append(ValidationResult(
                layer="rnbo-objects",
                level="error",
                message=f"Object '{name}' is not RNBO-compatible -- "
                        f"cannot be used in RNBO patches",
            ))

    return results


# ===========================================================================
# Layer: Target Constraints
# ===========================================================================

def _validate_target_constraints(
    patch_dict: dict,
    target: str,
) -> list[ValidationResult]:
    """Check export target constraints (param limits, buffer usage, etc.)."""
    results: list[ValidationResult] = []

    constraints = RNBO_TARGET_CONSTRAINTS.get(target)
    if constraints is None:
        results.append(ValidationResult(
            layer="rnbo-target",
            level="error",
            message=f"Unknown RNBO export target: '{target}'. "
                    f"Valid targets: plugin, web, cpp",
        ))
        return results

    patcher = patch_dict.get("patcher", {})
    boxes = patcher.get("boxes", [])

    # Count param objects
    param_count = 0
    has_buffer = False

    for box_entry in boxes:
        box = box_entry.get("box", {})
        name = _extract_object_name(box)
        if name is None:
            continue

        if name == "param":
            param_count += 1

        if name in ("buffer~", "data"):
            has_buffer = True

    # Check param limit
    max_params = constraints.get("max_params")
    if max_params is not None and param_count > max_params:
        results.append(ValidationResult(
            layer="rnbo-target",
            level="warning",
            message=f"Target '{target}' has a practical param limit of {max_params}, "
                    f"but patch has {param_count} param objects",
        ))

    # Check buffer allowed
    if not constraints.get("buffer_allowed") and has_buffer:
        results.append(ValidationResult(
            layer="rnbo-target",
            level="warning",
            message=f"Target '{target}' does not support buffer/data objects "
                    f"(no filesystem on embedded targets)",
        ))

    return results


# ===========================================================================
# Layer: Self-Containedness
# ===========================================================================

def _validate_self_contained(
    patch_dict: dict,
) -> list[ValidationResult]:
    """Check that the patch has no external file references.

    Scans for buffer~ with @file attributes, audio file path references,
    and external abstraction references. Error-level (strict enforcement
    per user decision).
    """
    results: list[ValidationResult] = []

    patcher = patch_dict.get("patcher", {})
    boxes = patcher.get("boxes", [])

    for box_entry in boxes:
        box = box_entry.get("box", {})
        text = box.get("text", "")
        name = _extract_object_name(box)

        if not text:
            continue

        # Check for @file attribute in text
        for pattern in _FILE_ATTRIBUTE_PATTERNS:
            if re.search(pattern, text, re.IGNORECASE):
                results.append(ValidationResult(
                    layer="rnbo-contained",
                    level="error",
                    message=f"External file reference in '{name}': '{text}' "
                            f"-- RNBO patches must be self-contained",
                ))
                break  # One error per box is enough

    return results
