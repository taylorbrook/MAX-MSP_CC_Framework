"""MAX patch generation library -- public API.

Generate valid .maxpat JSON files programmatically. This module re-exports
the essential types and functions so callers can do:

    from src.maxpat import Patcher, read_patch, save_patch_roundtrip, validate_file

Provides Patcher model, direct read/write, validation, and code generation for .maxpat files.
"""

from __future__ import annotations

from src.maxpat.patcher import Patcher, Box, Patchline, EditResult
from src.maxpat.validation import (
    validate_patch,
    has_blocking_errors,
    ValidationResult,
)
from src.maxpat.layout import apply_layout
from src.maxpat.aesthetics import set_canvas_background, set_object_bgcolor, auto_size_panel, is_complex_patch
from src.maxpat.defaults import LayoutOptions
from src.maxpat.hooks import (
    write_gendsp,
    write_js,
    validate_file,
    validate_code_file,
    detect_indent,
    save_patch_roundtrip,
    read_patch,
    PatchGenerationError,
    PatchValidationError,
)
from src.maxpat.codegen import (
    build_genexpr,
    parse_genexpr_io,
    generate_gendsp,
    generate_n4m_script,
    generate_js_script,
)
from src.maxpat.code_validation import (
    validate_genexpr,
    validate_js,
    validate_n4m,
    detect_js_type,
)
from src.maxpat.db_lookup import ObjectDatabase
from src.maxpat.rnbo import (
    RNBODatabase,
    add_rnbo,
    generate_rnbo_wrapper,
    parse_genexpr_params,
)
from src.maxpat.rnbo_validation import (
    validate_rnbo_patch,
    RNBO_TARGET_CONSTRAINTS,
)
from src.maxpat.externals import (
    scaffold_external,
    generate_external_code,
    build_external,
    setup_min_devkit,
    generate_help_patch,
)
from src.maxpat.ext_validation import validate_mxo, BuildResult


_AUTO_HIGHLIGHT = {
    "dac~": "emphasis_dac",
    "ezdac~": "emphasis_dac",
    "loadbang": "emphasis_loadbang",
}


def _apply_auto_styling(patcher: Patcher) -> None:
    """Apply default aesthetic styling to a patcher.

    Sets the canvas background color and highlights special objects
    (dac~, ezdac~, loadbang) with subtle palette colors. Skips boxes
    that already have a user-set bgcolor.
    """
    set_canvas_background(patcher)
    for box in patcher.boxes:
        palette_key = _AUTO_HIGHLIGHT.get(box.name)
        if palette_key and "bgcolor" not in box.extra_attrs:
            set_object_bgcolor(box, palette_key=palette_key)


__all__ = [
    # Core types
    "Patcher",
    "Box",
    "Patchline",
    "EditResult",
    # File I/O
    "write_gendsp",
    "write_js",
    "validate_file",
    "validate_code_file",
    "detect_indent",
    "save_patch_roundtrip",
    "read_patch",
    # Code generation
    "build_genexpr",
    "parse_genexpr_io",
    "generate_gendsp",
    "generate_n4m_script",
    "generate_js_script",
    # Code validation
    "validate_genexpr",
    "validate_js",
    "validate_n4m",
    "detect_js_type",
    # Patch validation
    "validate_patch",
    "has_blocking_errors",
    "ValidationResult",
    # Errors
    "PatchGenerationError",
    "PatchValidationError",
    # Database
    "ObjectDatabase",
    # RNBO
    "RNBODatabase",
    "add_rnbo",
    "generate_rnbo_wrapper",
    "parse_genexpr_params",
    "validate_rnbo_patch",
    "RNBO_TARGET_CONSTRAINTS",
    # Externals
    "scaffold_external",
    "generate_external_code",
    "build_external",
    "setup_min_devkit",
    "generate_help_patch",
    "validate_mxo",
    "BuildResult",
    # Layout
    "LayoutOptions",
    # Aesthetics
    "set_canvas_background",
    "set_object_bgcolor",
    "auto_size_panel",
    "is_complex_patch",
]
