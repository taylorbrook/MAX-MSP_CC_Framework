"""External project scaffolding, code generation, build, and help patch generation.

Provides:
- scaffold_external: Creates complete Min-DevKit project directory structure
  with CMakeLists.txt, C++ source file, and .maxhelp help patch.
- generate_external_code: Returns C++ code string for an archetype.
- generate_help_patch: Builds a Patcher for the .maxhelp file.
- setup_min_devkit: Initializes Min-DevKit as a git submodule.
- build_external: cmake/make build loop with auto-fix and .mxo validation.
- auto_fix: Attempts to fix known compiler error patterns.

Three supported archetypes: message, dsp, scheduler.
"""

from __future__ import annotations

import hashlib
import json
import re
import subprocess
from pathlib import Path
from typing import Any

from src.maxpat.ext_templates import (
    render_cmake_template,
    render_dsp_template,
    render_message_template,
    render_scheduler_template,
)
from src.maxpat.patcher import Box, Patcher
from src.maxpat.defaults import FONT_NAME, FONT_SIZE
from src.maxpat.sizing import calculate_box_size

VALID_ARCHETYPES = ("message", "dsp", "scheduler")


def generate_external_code(
    name: str,
    archetype: str,
    description: str,
    **kwargs: Any,
) -> str:
    """Generate C++ code string for an external archetype.

    Delegates to the appropriate render function in ext_templates.py.
    No file I/O -- returns the code as a string.

    Args:
        name: External object name (valid C++ identifier).
        archetype: One of "message", "dsp", "scheduler".
        description: Human-readable description.
        **kwargs: Archetype-specific parameters passed through to template.

    Returns:
        Complete C++ source code string.

    Raises:
        ValueError: If archetype is not one of the valid choices.
    """
    if archetype not in VALID_ARCHETYPES:
        raise ValueError(
            f"Invalid archetype '{archetype}'. "
            f"Must be one of: {', '.join(VALID_ARCHETYPES)}"
        )

    if archetype == "message":
        return render_message_template(
            name=name,
            description=description,
            inlets=kwargs.get("inlets", [{"comment": "(anything) input"}]),
            outlets=kwargs.get("outlets", [{"comment": "(anything) output"}]),
            handlers=kwargs.get("handlers", ["bang"]),
        )
    elif archetype == "dsp":
        return render_dsp_template(
            name=name,
            description=description,
            num_inputs=kwargs.get("num_inputs", 1),
            num_outputs=kwargs.get("num_outputs", 1),
            params=kwargs.get("params", []),
        )
    else:  # scheduler
        return render_scheduler_template(
            name=name,
            description=description,
            interval_default=kwargs.get("interval_default", 500.0),
            attributes=kwargs.get("attributes", []),
        )


def generate_help_patch(
    name: str,
    archetype: str,
    inlets: list[dict] | None = None,
    outlets: list[dict] | None = None,
) -> Patcher:
    """Build a Patcher for the .maxhelp file.

    Creates a demonstration patch with the external object and
    supporting objects appropriate for the archetype:
    - message: button -> external -> display
    - dsp: cycle~ -> external -> dac~
    - scheduler: toggle -> external -> print

    Args:
        name: External object name.
        archetype: One of "message", "dsp", "scheduler".
        inlets: Inlet descriptions (for comment generation).
        outlets: Outlet descriptions (for comment generation).

    Returns:
        Patcher instance (caller writes via write_patch or manual JSON).
    """
    from src.maxpat.db_lookup import ObjectDatabase

    db = ObjectDatabase()
    p = Patcher(db=db)

    # Comment header
    p.add_comment(f"{name} - help patch", x=20.0, y=20.0)

    if archetype == "message":
        _build_message_help(p, name, db)
    elif archetype == "dsp":
        _build_dsp_help(p, name, db)
    elif archetype == "scheduler":
        _build_scheduler_help(p, name, db)

    return p


def _create_external_box(
    p: Patcher,
    name: str,
    numinlets: int = 1,
    numoutlets: int = 1,
    outlettype: list[str] | None = None,
    x: float = 0.0,
    y: float = 0.0,
) -> Box:
    """Create a box for the custom external (not in DB, uses Box.__new__)."""
    if outlettype is None:
        outlettype = [""] * numoutlets

    box_id = p._gen_id()
    w, h = calculate_box_size(name, "newobj")

    ext_box = Box.__new__(Box)
    ext_box.name = name
    ext_box.args = []
    ext_box.id = box_id
    ext_box.maxclass = "newobj"
    ext_box.text = name
    ext_box.numinlets = numinlets
    ext_box.numoutlets = numoutlets
    ext_box.outlettype = outlettype
    ext_box.patching_rect = [x, y, w, h]
    ext_box.fontname = FONT_NAME
    ext_box.fontsize = FONT_SIZE
    ext_box.presentation = False
    ext_box.presentation_rect = None
    ext_box.extra_attrs = {}
    ext_box._inner_patcher = None
    ext_box._saved_object_attributes = None
    ext_box._bpatcher_attrs = None

    p.boxes.append(ext_box)
    return ext_box


def _build_message_help(p: Patcher, name: str, db: "ObjectDatabase") -> None:
    """Build help patch for message archetype: button -> ext -> display."""
    btn = p.add_box("button", x=100.0, y=80.0)
    ext = _create_external_box(p, name, numinlets=1, numoutlets=1, x=100.0, y=160.0)
    display = p.add_box("message", x=100.0, y=240.0)

    p.add_connection(btn, 0, ext, 0)
    p.add_connection(ext, 0, display, 0)


def _build_dsp_help(p: Patcher, name: str, db: "ObjectDatabase") -> None:
    """Build help patch for DSP archetype: cycle~ -> ext -> dac~."""
    src = p.add_box("cycle~", args=["440"], x=100.0, y=80.0)
    ext = _create_external_box(
        p, name,
        numinlets=1, numoutlets=1,
        outlettype=["signal"],
        x=100.0, y=160.0,
    )
    gain = p.add_box("*~", args=["0.25"], x=100.0, y=240.0)
    dac = p.add_box("dac~", x=100.0, y=320.0)

    p.add_connection(src, 0, ext, 0)
    p.add_connection(ext, 0, gain, 0)
    p.add_connection(gain, 0, dac, 0)


def _build_scheduler_help(p: Patcher, name: str, db: "ObjectDatabase") -> None:
    """Build help patch for scheduler archetype: toggle -> ext -> print."""
    tog = p.add_box("toggle", x=100.0, y=80.0)
    ext = _create_external_box(p, name, numinlets=1, numoutlets=1, x=100.0, y=160.0)
    prn = p.add_box("print", args=[name], x=100.0, y=240.0)

    p.add_connection(tog, 0, ext, 0)
    p.add_connection(ext, 0, prn, 0)


def scaffold_external(
    project_dir: Path | str,
    name: str,
    archetype: str,
    description: str,
    **kwargs: Any,
) -> dict[str, Path]:
    """Create a complete Min-DevKit external project directory.

    Creates:
    - {project_dir}/{name}/
    - {project_dir}/{name}/source/{name}.cpp
    - {project_dir}/{name}/help/{name}.maxhelp
    - {project_dir}/{name}/CMakeLists.txt

    Does NOT create min-devkit/ submodule or build/ directory
    (handled in Plan 03 build step).

    Args:
        project_dir: Parent directory for the external project.
        name: External object name (used for directory and file names).
        archetype: One of "message", "dsp", "scheduler".
        description: Human-readable description.
        **kwargs: Archetype-specific parameters.

    Returns:
        Dict with paths: {"root", "source", "cmake", "help"}.

    Raises:
        ValueError: If archetype is not valid.
    """
    if archetype not in VALID_ARCHETYPES:
        raise ValueError(
            f"Invalid archetype '{archetype}'. "
            f"Must be one of: {', '.join(VALID_ARCHETYPES)}"
        )

    project_dir = Path(project_dir)
    root = project_dir / name

    # Create directory structure
    source_dir = root / "source"
    help_dir = root / "help"
    source_dir.mkdir(parents=True, exist_ok=True)
    help_dir.mkdir(parents=True, exist_ok=True)

    # Generate and write C++ source
    cpp_code = generate_external_code(name, archetype, description, **kwargs)
    cpp_path = source_dir / f"{name}.cpp"
    cpp_path.write_text(cpp_code)

    # Generate and write CMakeLists.txt
    cmake_content = render_cmake_template(name)
    cmake_path = root / "CMakeLists.txt"
    cmake_path.write_text(cmake_content)

    # Generate and write help patch
    inlets = kwargs.get("inlets")
    outlets = kwargs.get("outlets")
    help_patcher = generate_help_patch(name, archetype, inlets, outlets)
    help_path = help_dir / f"{name}.maxhelp"
    help_dict = help_patcher.to_dict()
    help_path.write_text(json.dumps(help_dict, indent=2))

    return {
        "root": root,
        "source": cpp_path,
        "cmake": cmake_path,
        "help": help_path,
    }


# ── Plan 03: Build system integration ────────────────────────────────────


def setup_min_devkit(ext_dir: Path) -> bool:
    """Initialize Min-DevKit as a git submodule in the external project.

    Checks if min-devkit/source/min-api already exists (already set up).
    If not, runs ``git submodule add`` with recursive init to pull
    min-devkit and its nested min-api submodule.

    Args:
        ext_dir: Root directory of the external project.

    Returns:
        True if min-devkit is present (or successfully initialized),
        False if setup failed.
    """
    min_api_marker = ext_dir / "min-devkit" / "source" / "min-api"
    if min_api_marker.exists():
        return True

    # Attempt git submodule add
    try:
        result = subprocess.run(
            [
                "git", "submodule", "add",
                "https://github.com/Cycling74/min-devkit.git",
                "min-devkit",
            ],
            cwd=str(ext_dir),
            capture_output=True,
            text=True,
            timeout=120,
        )
        if result.returncode != 0:
            return False

        # Recursive init for nested submodules (min-api)
        result = subprocess.run(
            ["git", "submodule", "update", "--init", "--recursive"],
            cwd=str(ext_dir),
            capture_output=True,
            text=True,
            timeout=120,
        )
        if result.returncode != 0:
            return False

        # Verify min-api headers exist after setup
        return min_api_marker.exists()

    except (FileNotFoundError, subprocess.TimeoutExpired):
        return False


def build_external(
    ext_dir: Path,
    max_attempts: int = 5,
) -> "BuildResult":
    """Build a Min-DevKit external using cmake/make with auto-fix loop.

    Steps per attempt:
    1. cmake -G "Unix Makefiles" .. (configure)
    2. cmake --build . --config Release (build)
    3. On success: find .mxo, validate, return BuildResult(success=True)
    4. On error: parse errors, attempt auto_fix, track error hashes
    5. If same error hash seen twice, stop (loop detected)
    6. After max_attempts: return BuildResult(success=False)

    Uses "Unix Makefiles" generator (NOT Xcode) for headless operation
    per Pitfall #5 in research.

    Args:
        ext_dir: Root directory of the external project (contains
            source/, CMakeLists.txt).
        max_attempts: Maximum number of build attempts before giving up.

    Returns:
        BuildResult with success status, .mxo path, errors, and attempts.
    """
    from src.maxpat.ext_validation import BuildResult, validate_mxo, parse_compiler_errors

    build_dir = ext_dir / "build"
    build_dir.mkdir(exist_ok=True)

    seen_error_hashes: set[str] = set()
    last_errors: list[str] = []

    for attempt in range(1, max_attempts + 1):
        # Step 1: Configure
        configure_result = subprocess.run(
            ["cmake", "-G", "Unix Makefiles", ".."],
            cwd=str(build_dir),
            capture_output=True,
            text=True,
            timeout=60,
        )
        if configure_result.returncode != 0:
            # Parse configure errors
            parsed = parse_compiler_errors(configure_result.stderr)
            last_errors = [e["message"] for e in parsed] if parsed else [configure_result.stderr.strip()]

            # Check for loop
            error_hash = _hash_errors(last_errors)
            if error_hash in seen_error_hashes:
                return BuildResult(
                    success=False,
                    mxo_path=None,
                    errors=last_errors,
                    attempts=attempt,
                    message=f"Build failed: repeated configure error after {attempt} attempts",
                )
            seen_error_hashes.add(error_hash)

            # Try auto-fix on parsed errors
            if parsed and auto_fix(parsed, ext_dir):
                continue
            # No fix possible -- keep trying until max
            continue

        # Step 2: Build
        build_result = subprocess.run(
            ["cmake", "--build", ".", "--config", "Release"],
            cwd=str(build_dir),
            capture_output=True,
            text=True,
            timeout=120,
        )
        if build_result.returncode == 0:
            # Step 3: Find and validate .mxo
            mxo_files = list(build_dir.rglob("*.mxo"))
            if mxo_files:
                mxo_path = mxo_files[0]
                valid, msg = validate_mxo(mxo_path)
                return BuildResult(
                    success=valid,
                    mxo_path=mxo_path if valid else None,
                    errors=[] if valid else [msg],
                    attempts=attempt,
                    message=msg,
                )
            return BuildResult(
                success=False,
                mxo_path=None,
                errors=["Build succeeded but no .mxo found"],
                attempts=attempt,
                message="Build succeeded but no .mxo output found",
            )

        # Step 4: Parse compiler errors
        parsed = parse_compiler_errors(build_result.stderr)
        last_errors = [e["message"] for e in parsed] if parsed else [build_result.stderr.strip()]

        # Step 5: Loop detection
        error_hash = _hash_errors(last_errors)
        if error_hash in seen_error_hashes:
            return BuildResult(
                success=False,
                mxo_path=None,
                errors=last_errors,
                attempts=attempt,
                message=f"Build failed: same errors recurring after {attempt} attempts",
            )
        seen_error_hashes.add(error_hash)

        # Step 6: Attempt auto-fix
        if parsed:
            auto_fix(parsed, ext_dir)

    return BuildResult(
        success=False,
        mxo_path=None,
        errors=last_errors,
        attempts=max_attempts,
        message=f"Build failed after {max_attempts} attempts",
    )


def _hash_errors(errors: list[str]) -> str:
    """Create a hash of error messages for loop detection."""
    combined = "\n".join(sorted(errors))
    return hashlib.md5(combined.encode()).hexdigest()


# Regex patterns for auto-fixable compiler errors
_MISSING_SEMICOLON_RE = re.compile(
    r"expected\s+';'",
    re.IGNORECASE,
)
_MISSING_INCLUDE_RE = re.compile(
    r"'([^']+\.h)'\s+file\s+not\s+found",
    re.IGNORECASE,
)


def auto_fix(
    errors: list[dict],
    ext_dir: Path,
) -> bool:
    """Attempt to fix known compiler error patterns in source files.

    Handles:
    - Missing semicolons: adds `;` at the indicated line.
    - Missing includes: adds ``#include "header.h"`` to the source file.

    Only fixes well-known patterns. Complex or unknown errors are
    left unfixed (returns False), causing the caller to escalate
    per Pitfall #6.

    Args:
        errors: Parsed compiler error dicts from parse_compiler_errors.
        ext_dir: Root directory of the external project.

    Returns:
        True if at least one fix was applied, False if all errors
        are unfixable.
    """
    any_fixed = False

    for error in errors:
        file_path = Path(error["file"])
        if not file_path.is_absolute():
            file_path = ext_dir / file_path
        if not file_path.exists():
            continue

        message = error["message"]
        line_num = error["line"]

        # Fix: missing semicolon
        if _MISSING_SEMICOLON_RE.search(message):
            if _fix_missing_semicolon(file_path, line_num):
                any_fixed = True
                continue

        # Fix: missing include
        include_match = _MISSING_INCLUDE_RE.search(message)
        if include_match:
            header = include_match.group(1)
            if _fix_missing_include(file_path, header):
                any_fixed = True
                continue

    return any_fixed


def _fix_missing_semicolon(file_path: Path, line_num: int) -> bool:
    """Add a semicolon at the end of the indicated line."""
    try:
        lines = file_path.read_text().splitlines(keepends=True)
        if line_num < 1 or line_num > len(lines):
            return False

        idx = line_num - 1
        line = lines[idx].rstrip("\n")
        if not line.rstrip().endswith(";"):
            lines[idx] = line.rstrip() + ";\n"
            file_path.write_text("".join(lines))
            return True
        return False
    except OSError:
        return False


def _fix_missing_include(file_path: Path, header: str) -> bool:
    """Add a missing #include directive at the top of the file."""
    try:
        content = file_path.read_text()
        include_line = f'#include "{header}"'
        if include_line in content:
            return False  # Already present

        # Insert after existing includes or at the top
        lines = content.splitlines(keepends=True)
        insert_idx = 0
        for i, line in enumerate(lines):
            if line.strip().startswith("#include"):
                insert_idx = i + 1

        lines.insert(insert_idx, include_line + "\n")
        file_path.write_text("".join(lines))
        return True
    except OSError:
        return False
