"""File write hooks that trigger validation on .maxpat, .gendsp, and .js output.

Implements FRM-05: auto hook on file write triggers validation.

Provides:
- finalize_patch: Single-call layout cleanup hook for new and edited patches.
- write_gendsp: Generate and write a .gendsp file to disk.
- write_js: Write JavaScript code and run code validation.
- validate_file: Load and validate an existing .maxpat file from disk.
- validate_code_file: Validate .gendsp or .js code files from disk.
- PatchGenerationError: Raised when unfixable errors prevent generation.
- PatchValidationError: Raised when validation blocks file write.
"""

from __future__ import annotations

import json
import os
from pathlib import Path
from typing import TYPE_CHECKING

from src.maxpat.validation import validate_patch, has_blocking_errors, ValidationResult

if TYPE_CHECKING:
    from src.maxpat.patcher import Patcher


def _write_and_sync(path: Path, content: str) -> None:
    """Write content to file and fsync to ensure Finder/MAX see changes."""
    with open(path, "w", encoding="utf-8") as f:
        f.write(content)
        f.flush()
        os.fsync(f.fileno())


def finalize_patch(patcher: "Patcher", is_new: bool = True) -> None:
    """Single-call layout cleanup hook for new and edited patches.

    For new patches (is_new=True):
        Applies auto-styling, full topological layout, assistance comments,
        and midpoint generation for all patchers and subpatchers.

    For edited patches (is_new=False):
        Regenerates cable midpoints and populates assistance comments
        without repositioning existing objects.

    Args:
        patcher: The Patcher instance to finalize.
        is_new: True for newly created patches, False for loaded/edited patches.
    """
    from src.maxpat.aesthetics import apply_auto_styling
    from src.maxpat.layout import apply_layout, _generate_midpoints

    if is_new:
        apply_auto_styling(patcher)
        apply_layout(patcher)
        patcher.populate_assistance_comments()
    else:
        patcher.populate_assistance_comments()
        _finalize_midpoints_recursive(patcher, _generate_midpoints)


def _finalize_midpoints_recursive(
    patcher: "Patcher",
    generate_fn: "callable",
) -> None:
    """Clear and regenerate midpoints on a patcher and all nested subpatchers.

    Args:
        patcher: The Patcher instance to process.
        generate_fn: The _generate_midpoints function from layout module.
    """
    # Clear existing midpoints before regenerating
    for line in patcher.lines:
        line.midpoints = []
    generate_fn(patcher)

    # Recurse into subpatchers
    for box in patcher.boxes:
        if box._inner_patcher is not None and box._inner_patcher.boxes:
            _finalize_midpoints_recursive(box._inner_patcher, generate_fn)


def detect_indent(file_text: str) -> str:
    """Detect the indentation style used in a JSON file.

    Reads the first indented line and returns the whitespace prefix.
    Returns 4 spaces (MAX default) if no indented line is found.

    Args:
        file_text: Raw file content as a string.

    Returns:
        The indentation string (e.g., "    ", "  ", "\\t").
    """
    for line in file_text.split("\n"):
        stripped = line.lstrip()
        if stripped and line != stripped:
            # Found an indented line -- extract the leading whitespace
            indent_chars = line[: len(line) - len(stripped)]
            return indent_chars
    return "    "  # Default: 4 spaces (MAX 9.1.2 format per user decision)


def save_patch_roundtrip(
    patch_dict: dict,
    path: "str | Path",
    original_text: str | None = None,
) -> None:
    """Save a .maxpat dict preserving the original file's indentation.

    For round-trip saves (load -> edit -> save), pass the original file text
    so indentation is preserved. For new files, omit original_text to use
    MAX's default 4-space indentation.

    Args:
        patch_dict: The .maxpat dict (output of Patcher.to_dict()).
        path: Destination file path.
        original_text: Original file content (for indent detection). If None,
            uses 4-space indent (MAX 9.1.2 default).
    """
    path = Path(path)

    if original_text is not None:
        indent = detect_indent(original_text)
    else:
        indent = "    "  # MAX default: 4 spaces

    # json.dumps indent parameter accepts str for custom indentation
    output = json.dumps(patch_dict, indent=indent, ensure_ascii=False)

    # Preserve trailing newline status of original file
    if original_text is not None and original_text.endswith("\n"):
        output += "\n"

    path.parent.mkdir(parents=True, exist_ok=True)
    _write_and_sync(path, output)


def read_patch(path: "str | Path") -> tuple["Patcher", str]:
    """Load a .maxpat file into a Patcher ready for querying and editing.

    Returns (patcher, original_text) tuple. Pass original_text to
    save_patch_roundtrip() for indent-preserving saves.

    Args:
        path: Path to the .maxpat file (str or pathlib.Path).

    Returns:
        (patcher, original_text) tuple.

    Raises:
        FileNotFoundError: If the file does not exist.
        json.JSONDecodeError: If the file is not valid JSON.
        ValueError: If the JSON structure is not a valid .maxpat
            (missing 'patcher' key).
    """
    path = Path(path)
    if not path.exists():
        raise FileNotFoundError(f"File not found: {path}")
    original_text = path.read_text()
    data = json.loads(original_text)
    from src.maxpat.patcher import Patcher
    patcher = Patcher.from_dict(data)
    return (patcher, original_text)


class PatchGenerationError(Exception):
    """Raised when unfixable structural errors prevent patch generation."""


class PatchValidationError(Exception):
    """Raised when validation finds blocking errors that prevent file write."""


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
    _write_and_sync(path, json.dumps(gendsp_dict, indent=2))

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
    _write_and_sync(path, code)

    # Run validation on the written file
    return validate_code_file(path)
