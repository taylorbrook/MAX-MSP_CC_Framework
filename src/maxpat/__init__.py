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
from src.maxpat.aesthetics import set_canvas_background, set_object_bgcolor
from src.maxpat.defaults import LayoutOptions
from src.maxpat.hooks import (
    write_patch,
    write_gendsp,
    write_js,
    validate_file,
    validate_code_file,
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


def generate_patch(
    patcher: Patcher,
    layout_options: LayoutOptions | None = None,
) -> tuple[dict, list[ValidationResult]]:
    """Generate a complete, laid-out, validated .maxpat dict from a Patcher.

    This is the core generation function. It:
    1. Applies auto-styling (canvas background, object highlights).
    2. Applies column-based layout to position all boxes.
    3. Serializes the Patcher to a .maxpat dict.
    4. Runs the four-layer validation pipeline.
    5. Raises PatchGenerationError if unfixable structural errors exist.

    Args:
        patcher: A Patcher instance containing boxes and connections.
        layout_options: Optional LayoutOptions to customize spacing,
            grid snapping, and alignment. Defaults to None (use defaults).

    Returns:
        (patch_dict, results) tuple where:
        - patch_dict: Complete .maxpat JSON-serializable dict.
        - results: List of ValidationResult (warnings, info, auto-fixed).

    Raises:
        PatchGenerationError: If has_blocking_errors is True.
    """
    # Step 1: Apply auto-styling
    _apply_auto_styling(patcher)

    # Step 2: Apply layout
    apply_layout(patcher, layout_options)

    # Step 3: Serialize to dict
    patch_dict = patcher.to_dict()

    # Step 4: Validate
    results = validate_patch(patch_dict, db=patcher.db)

    # Step 5: Block on unfixable errors
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
    "write_gendsp",
    "write_js",
    "validate_file",
    "validate_code_file",
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
]
