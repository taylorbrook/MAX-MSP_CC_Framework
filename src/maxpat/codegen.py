"""GenExpr code builder, .gendsp file generation, and JavaScript code generators.

Provides tools for building syntactically correct GenExpr DSP code,
generating standalone .gendsp files with correct patcher structure,
and generating Node for Max (N4M) and js object V8 JavaScript.

Exports:
- parse_genexpr_io: Extract input/output counts from GenExpr code
- build_genexpr: Build formatted GenExpr code with Params and sections
- generate_gendsp: Generate a complete .gendsp JSON dict
- generate_n4m_script: Generate Node for Max JavaScript with CommonJS require
- generate_js_script: Generate js object V8 JavaScript with handlers
"""

from __future__ import annotations

import copy
import re

from src.maxpat.defaults import DEFAULT_PATCHER_PROPS, FONT_NAME, FONT_SIZE, GEN_PATCHER_BGCOLOR


def parse_genexpr_io(code: str) -> tuple[int, int]:
    """Extract input and output counts from GenExpr code.

    Scans for ``in1``, ``in2``, ... and ``out1``, ``out2``, ... patterns
    using word-boundary-aware regex to avoid matching variable names like
    ``index`` or ``input``.

    Args:
        code: GenExpr source code string.

    Returns:
        (num_inputs, num_outputs) tuple. Returns (0, 0) if none found.
    """
    # Match standalone in1, in2, ... (word boundary before 'in', digit after)
    in_matches = re.findall(r"\bin(\d+)\b", code)
    out_matches = re.findall(r"\bout(\d+)\b", code)

    max_in = max((int(n) for n in in_matches), default=0)
    max_out = max((int(n) for n in out_matches), default=0)

    return (max_in, max_out)


def build_genexpr(
    params: list[dict],
    code_body: str,
    num_inputs: int = 1,
    num_outputs: int = 1,
) -> str:
    """Build a complete, well-formatted GenExpr code string.

    Follows the project's locked style decisions:
    - Section headers with ``// === SECTION_NAME ===`` format
    - Full Param range specs: ``Param name(default, min=min_val, max=max_val);``
    - Descriptive variable names in code_body

    Args:
        params: List of parameter dicts, each with keys:
            ``name``, ``default``, ``min``, ``max``.
        code_body: The DSP logic section (raw GenExpr code). May already
            contain ``out1 = ...`` lines.
        num_inputs: Number of inputs (informational, not used in output).
        num_outputs: Number of outputs (informational, not used in output).

    Returns:
        Formatted GenExpr code string.
    """
    sections: list[str] = []

    # Parameters section
    if params:
        lines = ["// === PARAMETERS ==="]
        for p in params:
            name = p["name"]
            default = p["default"]
            min_val = p["min"]
            max_val = p["max"]
            lines.append(f"Param {name}({default}, min={min_val}, max={max_val});")
        sections.append("\n".join(lines))

    # Code body section
    if code_body.strip():
        sections.append(code_body.strip())

    return "\n\n".join(sections) + "\n"


def generate_gendsp(
    code: str,
    num_inputs: int | None = None,
    num_outputs: int | None = None,
) -> dict:
    """Generate a complete .gendsp JSON dict.

    Builds the standard .gendsp file structure: a patcher wrapper containing
    ``in`` objects, a codebox with GenExpr code, ``out`` objects, and
    patchlines connecting them.

    Args:
        code: GenExpr source code for the codebox.
        num_inputs: Number of inputs. Auto-detected from code if None.
        num_outputs: Number of outputs. Auto-detected from code if None.

    Returns:
        Complete .gendsp JSON-serializable dict with ``"patcher"`` top-level key.
    """
    # Auto-detect I/O from code if not specified
    if num_inputs is None or num_outputs is None:
        detected_in, detected_out = parse_genexpr_io(code)
        if num_inputs is None:
            num_inputs = detected_in
        if num_outputs is None:
            num_outputs = detected_out

    # Build patcher properties
    patcher = copy.deepcopy(DEFAULT_PATCHER_PROPS)
    patcher["bgcolor"] = list(GEN_PATCHER_BGCOLOR)
    patcher["rect"] = [100.0, 100.0, 600.0, 450.0]

    boxes: list[dict] = []
    lines: list[dict] = []
    next_id = 1

    def gen_id() -> str:
        nonlocal next_id
        box_id = f"obj-{next_id}"
        next_id += 1
        return box_id

    # Create in objects (positioned at top)
    in_ids: list[str] = []
    for i in range(num_inputs):
        box_id = gen_id()
        in_ids.append(box_id)
        boxes.append({
            "box": {
                "maxclass": "newobj",
                "text": f"in {i + 1}",
                "id": box_id,
                "numinlets": 0,
                "numoutlets": 1,
                "outlettype": [""],
                "patching_rect": [50.0 + i * 80.0, 20.0, 30.0, 22.0],
                "fontname": FONT_NAME,
                "fontsize": FONT_SIZE,
            }
        })

    # Create codebox
    codebox_id = gen_id()
    boxes.append({
        "box": {
            "maxclass": "codebox",
            "id": codebox_id,
            "code": code,
            "numinlets": num_inputs,
            "numoutlets": num_outputs,
            "outlettype": [""] * num_outputs,
            "patching_rect": [50.0, 80.0, 400.0, 200.0],
            "fontname": FONT_NAME,
            "fontsize": FONT_SIZE,
        }
    })

    # Create out objects (positioned at bottom)
    out_ids: list[str] = []
    for i in range(num_outputs):
        box_id = gen_id()
        out_ids.append(box_id)
        boxes.append({
            "box": {
                "maxclass": "newobj",
                "text": f"out {i + 1}",
                "id": box_id,
                "numinlets": 1,
                "numoutlets": 0,
                "outlettype": [],
                "patching_rect": [50.0 + i * 80.0, 320.0, 30.0, 22.0],
                "fontname": FONT_NAME,
                "fontsize": FONT_SIZE,
            }
        })

    # Create patchlines: in -> codebox
    for i, in_id in enumerate(in_ids):
        lines.append({
            "patchline": {
                "source": [in_id, 0],
                "destination": [codebox_id, i],
            }
        })

    # Create patchlines: codebox -> out
    for i, out_id in enumerate(out_ids):
        lines.append({
            "patchline": {
                "source": [codebox_id, i],
                "destination": [out_id, 0],
            }
        })

    patcher["boxes"] = boxes
    patcher["lines"] = lines

    return {"patcher": patcher}


def generate_n4m_script(
    handlers: list[dict],
    dict_access: list[str] | None = None,
) -> str:
    """Generate a complete Node for Max JavaScript string.

    Produces CommonJS-style code with ``require("max-api")``, handler
    registrations via ``maxAPI.addHandler``, and optional async dict
    access functions with try/catch error handling.

    Args:
        handlers: List of handler dicts, each with keys:
            ``name`` (str), ``args`` (list[str]), ``body`` (str).
        dict_access: Optional list of dict names to generate async
            getter/setter helper functions for.

    Returns:
        Complete N4M JavaScript source string.
    """
    sections: list[str] = []

    # Require statement
    sections.append('const maxAPI = require("max-api");')

    # Dict access helpers (async with try/catch)
    if dict_access:
        sections.append("")
        sections.append("// === DICT ACCESS ===")
        for dict_name in dict_access:
            sections.append(f"""
async function getDict_{dict_name}() {{
    try {{
        const data = await maxAPI.getDict("{dict_name}");
        return data;
    }} catch (e) {{
        maxAPI.post("Error getting dict {dict_name}: " + e.message);
        return null;
    }}
}}

async function setDict_{dict_name}(data) {{
    try {{
        await maxAPI.setDict("{dict_name}", data);
    }} catch (e) {{
        maxAPI.post("Error setting dict {dict_name}: " + e.message);
    }}
}}""".rstrip())

    # Handlers
    sections.append("")
    sections.append("// === HANDLERS ===")
    for handler in handlers:
        name = handler["name"]
        args = handler.get("args", [])
        body = handler.get("body", "")
        args_str = ", ".join(args)

        # Indent body lines
        body_lines = body.strip().split("\n")
        indented_body = "\n".join(f"    {line}" for line in body_lines)

        sections.append(f"""
maxAPI.addHandler("{name}", ({args_str}) => {{
{indented_body}
}});""".rstrip())

    return "\n".join(sections) + "\n"


def generate_js_script(
    num_inlets: int = 1,
    num_outlets: int = 1,
    handlers: list[dict] | None = None,
) -> str:
    """Generate a complete js object V8 JavaScript string.

    Produces code with ``inlets``/``outlets`` declarations and handler
    functions. If no handlers are specified, generates default handlers
    for bang, msg_int, msg_float, and list with placeholder bodies.

    Args:
        num_inlets: Number of inlets to declare.
        num_outlets: Number of outlets to declare.
        handlers: Optional list of handler dicts, each with keys:
            ``type`` (str -- one of bang, msg_int, msg_float, list,
            anything) and ``body`` (str).
            If None, default handlers are generated.

    Returns:
        Complete js object V8 JavaScript source string.
    """
    sections: list[str] = []

    # I/O declarations
    sections.append(f"inlets = {num_inlets};")
    sections.append(f"outlets = {num_outlets};")

    if handlers is None:
        # Default handlers with placeholder bodies
        handlers = [
            {"type": "bang", "body": "outlet(0, \"bang\");"},
            {"type": "msg_int", "body": "outlet(0, v);"},
            {"type": "msg_float", "body": "outlet(0, v);"},
            {"type": "list", "body": "outlet(0, arrayfromargs(arguments));"},
        ]

    # Standard argument signatures for handler types
    _handler_args = {
        "bang": "",
        "msg_int": "v",
        "msg_float": "v",
        "list": "",
        "anything": "msg",
    }

    for handler in handlers:
        handler_type = handler["type"]
        body = handler.get("body", "")
        args_str = _handler_args.get(handler_type, "")

        # Indent body lines
        body_lines = body.strip().split("\n")
        indented_body = "\n".join(f"    {line}" for line in body_lines)

        sections.append(f"""
function {handler_type}({args_str}) {{
{indented_body}
}}""".rstrip())

    return "\n".join(sections) + "\n"
