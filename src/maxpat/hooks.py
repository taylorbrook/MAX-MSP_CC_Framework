"""File write hooks that trigger validation on .maxpat output.

Implements FRM-05: auto hook on .maxpat file write triggers validation.

Provides:
- write_patch: Generate, validate, and write a .maxpat file to disk.
- validate_file: Load and validate an existing .maxpat file from disk.
- PatchGenerationError: Raised when unfixable errors prevent generation.
- PatchValidationError: Raised when validation blocks file write.
"""

from __future__ import annotations

import json
from pathlib import Path
from typing import TYPE_CHECKING

from src.maxpat.validation import validate_patch, has_blocking_errors, ValidationResult

if TYPE_CHECKING:
    from src.maxpat.patcher import Patcher


class PatchGenerationError(Exception):
    """Raised when unfixable structural errors prevent patch generation."""


class PatchValidationError(Exception):
    """Raised when validation finds blocking errors that prevent file write."""


def write_patch(
    patcher: Patcher,
    path: str | Path,
    validate: bool = True,
) -> list[ValidationResult]:
    """Generate, validate, and write a .maxpat file to disk.

    This is the main entry point for writing patches. It:
    1. Calls generate_patch to apply layout and run validation.
    2. Blocks if unfixable errors exist (raises PatchValidationError).
    3. Creates parent directories if needed.
    4. Writes JSON with indent=2 for readability.
    5. Returns validation results so caller can inspect warnings.

    Args:
        patcher: A Patcher instance containing boxes and connections.
        path: Output file path for the .maxpat file.
        validate: If False, skip validation entirely. Default True.

    Returns:
        List of ValidationResult from validation (empty if validate=False).

    Raises:
        PatchGenerationError: If unfixable structural errors prevent generation.
        PatchValidationError: If validation finds blocking errors.
    """
    # Import here to avoid circular imports
    from src.maxpat import generate_patch

    path = Path(path)

    if not validate:
        # Skip validation: just serialize and write
        from src.maxpat.layout import apply_layout
        apply_layout(patcher)
        patch_dict = patcher.to_dict()
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(json.dumps(patch_dict, indent=2))
        return []

    # Generate with layout + validation
    patch_dict, results = generate_patch(patcher)

    # Block on unfixable errors
    if has_blocking_errors(results):
        error_msgs = [r.message for r in results if r.level == "error" and not r.auto_fixed]
        raise PatchValidationError(
            f"Validation found blocking errors:\n" +
            "\n".join(f"  - {m}" for m in error_msgs)
        )

    # Create parent directories
    path.parent.mkdir(parents=True, exist_ok=True)

    # Write JSON with readable formatting
    path.write_text(json.dumps(patch_dict, indent=2))

    return results


def write_gendsp(
    code: str,
    path: str | Path,
    num_inputs: int | None = None,
    num_outputs: int | None = None,
) -> dict:
    """Generate and write a .gendsp file to disk.

    Creates a standalone .gendsp file containing a Gen patcher with
    codebox, in/out objects, and patchlines.

    Args:
        code: GenExpr source code for the codebox.
        path: Output file path for the .gendsp file.
        num_inputs: Number of inputs. Auto-detected from code if None.
        num_outputs: Number of outputs. Auto-detected from code if None.

    Returns:
        The generated .gendsp dict.
    """
    from src.maxpat.codegen import generate_gendsp

    path = Path(path)
    gendsp_dict = generate_gendsp(code, num_inputs, num_outputs)

    # Create parent directories if needed
    path.parent.mkdir(parents=True, exist_ok=True)

    # Write JSON with readable formatting
    path.write_text(json.dumps(gendsp_dict, indent=2))

    return gendsp_dict


def validate_file(path: str | Path) -> list[ValidationResult]:
    """Load and validate an existing .maxpat file from disk.

    Args:
        path: Path to the .maxpat file.

    Returns:
        List of ValidationResult from the validation pipeline.

    Raises:
        FileNotFoundError: If the file does not exist.
    """
    path = Path(path)

    if not path.exists():
        raise FileNotFoundError(f"File not found: {path}")

    # Try to load JSON
    try:
        data = json.loads(path.read_text())
    except json.JSONDecodeError as e:
        return [ValidationResult(
            "json", "error",
            f"Invalid JSON: {e}",
        )]

    # Run the validation pipeline on the loaded dict
    return validate_patch(data)
