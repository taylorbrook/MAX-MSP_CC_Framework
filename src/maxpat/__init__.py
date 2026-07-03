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
from src.maxpat.aesthetics import (
    set_canvas_background,
    set_object_bgcolor,
    auto_size_panel,
    is_complex_patch,
    apply_auto_styling,
    ensure_text_contrast,
)
from src.maxpat.defaults import LayoutOptions
from src.maxpat.sizing import text_width
from src.maxpat.hooks import (
    write_gendsp,
    write_js,
    validate_file,
    validate_code_file,
    detect_indent,
    save_patch_roundtrip,
    read_patch,
    finalize_patch,
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


# Backward compat alias -- canonical location is src.maxpat.aesthetics
_apply_auto_styling = apply_auto_styling


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
    # Sizing
    "text_width",
    # Hooks
    "finalize_patch",
    # Aesthetics
    "set_canvas_background",
    "set_object_bgcolor",
    "auto_size_panel",
    "is_complex_patch",
    "ensure_text_contrast",
]
