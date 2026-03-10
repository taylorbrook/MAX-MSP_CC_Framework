"""External project scaffolding, code generation, and help patch generation.

Provides:
- scaffold_external: Creates complete Min-DevKit project directory structure
  with CMakeLists.txt, C++ source file, and .maxhelp help patch.
- generate_external_code: Returns C++ code string for an archetype.
- generate_help_patch: Builds a Patcher for the .maxhelp file.

Three supported archetypes: message, dsp, scheduler.
Build and compilation are handled in Plan 03 (not in this module).
"""

from __future__ import annotations

import json
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
