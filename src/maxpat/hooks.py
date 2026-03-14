"""File write hooks that trigger validation on .maxpat, .gendsp, and .js output.

Implements FRM-05: auto hook on file write triggers validation.

Provides:
- write_patch: Generate, validate, and write a .maxpat file to disk.
- write_gendsp: Generate and write a .gendsp file to disk.
- write_js: Write JavaScript code and run code validation.
- validate_file: Load and validate an existing .maxpat file from disk.
- validate_code_file: Validate .gendsp or .js code files from disk.
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
    from src.maxpat.defaults import LayoutOptions


class PatchGenerationError(Exception):
    """Raised when unfixable structural errors prevent patch generation."""


class PatchValidationError(Exception):
    """Raised when validation finds blocking errors that prevent file write."""


def write_patch(
    patcher: Patcher,
    path: str | Path,
    validate: bool = True,
    layout_options: "LayoutOptions | None" = None,
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
        layout_options: Optional LayoutOptions to customize spacing,
            grid snapping, and alignment. Forwarded to apply_layout().

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
        apply_layout(patcher, layout_options)
        patch_dict = patcher.to_dict()
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(json.dumps(patch_dict, indent=2))
        return []

    # Generate with layout + validation
    patch_dict, results = generate_patch(patcher, layout_options=layout_options)

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


def validate_code_file(path: str | Path) -> list[ValidationResult]:
    """Validate a .gendsp or .js code file from disk.

    For .gendsp files: parses JSON, extracts codebox code attribute,
    and runs validate_genexpr on it.

    For .js files: reads content, uses detect_js_type to determine
    if N4M or js V8, and runs the appropriate validator.

    Args:
        path: Path to the .gendsp or .js file.

    Returns:
        List of ValidationResult from the code validator.

    Raises:
        FileNotFoundError: If the file does not exist.
    """
    from src.maxpat.code_validation import (
        validate_genexpr,
        validate_js,
        validate_n4m,
        detect_js_type,
    )

    path = Path(path)

    if not path.exists():
        raise FileNotFoundError(f"File not found: {path}")

    content = path.read_text()

    if path.suffix == ".gendsp":
        # Parse JSON and extract codebox code
        try:
            data = json.loads(content)
        except json.JSONDecodeError as e:
            return [ValidationResult(
                "json", "error",
                f"Invalid JSON in .gendsp file: {e}",
            )]

        # Find the codebox and extract code
        code = None
        for box_entry in data.get("patcher", {}).get("boxes", []):
            box = box_entry.get("box", {})
            if box.get("maxclass") == "codebox" and "code" in box:
                code = box["code"]
                break

        if code is None:
            return [ValidationResult(
                "code", "warning",
                "No codebox with 'code' attribute found in .gendsp file",
            )]

        return validate_genexpr(code)

    elif path.suffix == ".js":
        js_type = detect_js_type(content)
        if js_type == "n4m":
            return validate_n4m(content)
        elif js_type == "js":
            return validate_js(content)
        else:
            return [ValidationResult(
                "code", "warning",
                "Could not determine JavaScript type (N4M or js V8) -- "
                "missing require('max-api') or inlets declaration",
            )]

    else:
        return [ValidationResult(
            "code", "warning",
            f"Unsupported file extension: {path.suffix} "
            f"(expected .gendsp or .js)",
        )]


def write_js(
    code: str,
    path: str | Path,
) -> list[ValidationResult]:
    """Write JavaScript code to disk and run code validation.

    Writes the code to the specified .js file path, then runs
    validate_code_file on the written file. Validation is report-only
    and never blocks the write.

    Args:
        code: JavaScript source code (N4M or js V8).
        path: Output file path for the .js file.

    Returns:
        List of ValidationResult from code validation.
    """
    path = Path(path)

    # Create parent directories if needed
    path.parent.mkdir(parents=True, exist_ok=True)

    # Write the file first (never blocked by validation)
    path.write_text(code)

    # Run validation on the written file
    return validate_code_file(path)
