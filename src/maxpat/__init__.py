"""MAX patch generation library -- public API.

Generate valid .maxpat JSON files programmatically. This module re-exports
the essential types and functions so callers can do:

    from src.maxpat import Patcher, generate_patch, write_patch, validate_file

The generation pipeline is: Patcher -> layout -> validation -> .maxpat JSON.
"""

from __future__ import annotations

from src.maxpat.patcher import Patcher, Box, Patchline
from src.maxpat.validation import (
    validate_patch,
    has_blocking_errors,
    ValidationResult,
)
from src.maxpat.layout import apply_layout
from src.maxpat.hooks import (
    write_patch,
    validate_file,
    PatchGenerationError,
    PatchValidationError,
)
from src.maxpat.db_lookup import ObjectDatabase


def generate_patch(patcher: Patcher) -> tuple[dict, list[ValidationResult]]:
    """Generate a complete, laid-out, validated .maxpat dict from a Patcher.

    This is the core generation function. It:
    1. Applies column-based layout to position all boxes.
    2. Serializes the Patcher to a .maxpat dict.
    3. Runs the four-layer validation pipeline.
    4. Raises PatchGenerationError if unfixable structural errors exist.

    Args:
        patcher: A Patcher instance containing boxes and connections.

    Returns:
        (patch_dict, results) tuple where:
        - patch_dict: Complete .maxpat JSON-serializable dict.
        - results: List of ValidationResult (warnings, info, auto-fixed).

    Raises:
        PatchGenerationError: If has_blocking_errors is True.
    """
    # Step 1: Apply layout
    apply_layout(patcher)

    # Step 2: Serialize to dict
    patch_dict = patcher.to_dict()

    # Step 3: Validate
    results = validate_patch(patch_dict, db=patcher.db)

    # Step 4: Block on unfixable errors
    if has_blocking_errors(results):
        error_msgs = [r.message for r in results if r.level == "error" and not r.auto_fixed]
        raise PatchGenerationError(
            f"Patch generation blocked by unfixable errors:\n" +
            "\n".join(f"  - {m}" for m in error_msgs)
        )

    return (patch_dict, results)


__all__ = [
    # Core types
    "Patcher",
    "Box",
    "Patchline",
    # Generation
    "generate_patch",
    # File I/O
    "write_patch",
    "validate_file",
    # Validation
    "validate_patch",
    "has_blocking_errors",
    "ValidationResult",
    # Errors
    "PatchGenerationError",
    "PatchValidationError",
    # Database
    "ObjectDatabase",
]
