"""Code validation for GenExpr, js object V8, and Node for Max JavaScript.

Report-only validators that catch common errors before opening MAX.
No auto-fix -- all results are informational or diagnostic.

Exports:
- validate_genexpr: Validate GenExpr DSP code (operators, syntax, Params)
- validate_js: Validate js object V8 JavaScript (inlets/outlets, handlers, bounds)
- validate_n4m: Validate Node for Max JavaScript (require, handlers, outlet)
- detect_js_type: Detect whether JavaScript code is N4M or js V8
"""

from __future__ import annotations

import re
from typing import TYPE_CHECKING

from src.maxpat.validation import ValidationResult

if TYPE_CHECKING:
    from src.maxpat.db_lookup import ObjectDatabase


# GenExpr keywords and built-ins that should NOT be checked against the operator database
_GENEXPR_KEYWORDS = frozenset({
    "if", "else", "for", "while", "return", "break", "continue",
    "Param", "History", "Delay", "Buffer", "Data", "SampleRate", "FixedArray",
    "in", "out", "min", "max", "abs", "sqrt", "pow", "exp", "log",
    "sin", "cos", "tan", "asin", "acos", "atan", "atan2",
    "floor", "ceil", "round", "trunc", "fract",
    "clamp", "wrap", "fold", "scale", "sign",
    "mix", "smoothstep", "step",
    "noise", "latch", "sah", "peek", "poke",
    "fixdenorm", "isnan", "isinf",
    "selector", "gate", "switch",
    "sample", "nearest", "interp",
})


def validate_genexpr(
    code: str,
    db: "ObjectDatabase | None" = None,
) -> list[ValidationResult]:
    """Validate GenExpr DSP code.

    Checks:
    1. Balanced braces
    2. Semicolons on statement lines
    3. in/out declarations (info-level)
    4. Param syntax (min/max presence)
    5. Operator existence against gen/objects.json

    All results use layer="code". Report-only, no auto-fix.

    Args:
        code: GenExpr source code string.
        db: ObjectDatabase instance. Created if None.

    Returns:
        List of ValidationResult.
    """
    results: list[ValidationResult] = []

    # Check 1: Balanced braces
    open_count = code.count("{")
    close_count = code.count("}")
    if open_count != close_count:
        results.append(ValidationResult(
            "code", "error",
            f"Unbalanced braces: {open_count} opening vs {close_count} closing",
        ))

    # Check 2: Semicolons on statement lines
    lines = code.split("\n")
    for i, line in enumerate(lines):
        stripped = line.strip()

        # Skip empty, comments, braces-only, preprocessor
        if not stripped:
            continue
        if stripped.startswith("//"):
            continue
        if stripped in ("{", "}", "};", "){"):
            continue
        if stripped.startswith("#"):
            continue

        # Is this a statement line? (has assignment, function call, or declaration)
        is_statement = (
            "=" in stripped
            or re.search(r"\w+\s*\(", stripped)
            or stripped.startswith("Param ")
            or stripped.startswith("History ")
            or stripped.startswith("Buffer ")
            or stripped.startswith("Data ")
        )

        if is_statement and not stripped.endswith(";") and not stripped.endswith("{") and not stripped.endswith("}"):
            results.append(ValidationResult(
                "code", "warning",
                f"Line {i + 1}: possible missing semicolon: '{stripped}'",
            ))

    # Check 3: in/out declarations
    in_matches = re.findall(r"\bin(\d+)\b", code)
    out_matches = re.findall(r"\bout(\d+)\b", code)
    max_in = max((int(n) for n in in_matches), default=0)
    max_out = max((int(n) for n in out_matches), default=0)
    if max_in > 0 or max_out > 0:
        results.append(ValidationResult(
            "code", "info",
            f"Detected I/O: {max_in} input(s), {max_out} output(s)",
        ))

    # Check 4: Param validation
    param_pattern = re.compile(r"Param\s+(\w+)\s*\(([^)]*)\)")
    for match in param_pattern.finditer(code):
        param_name = match.group(1)
        param_args = match.group(2)

        if "min" not in param_args or "max" not in param_args:
            results.append(ValidationResult(
                "code", "warning",
                f"Param '{param_name}' missing min/max range specification "
                f"(recommended: Param {param_name}(default, min=N, max=N))",
            ))

    # Check 5: Declaration ordering -- all declarations must precede expressions
    _DECL_PREFIXES = ("Param ", "History ", "Delay ", "Buffer ", "Data ")
    last_decl_line = -1
    first_expr_line = -1
    for i, line in enumerate(lines):
        stripped = line.strip()
        if not stripped or stripped.startswith("//") or stripped.startswith("#"):
            continue
        if any(stripped.startswith(p) for p in _DECL_PREFIXES):
            last_decl_line = i
            if first_expr_line >= 0:
                results.append(ValidationResult(
                    "code", "error",
                    f"Line {i + 1}: declaration '{stripped.split('(')[0].strip()}' "
                    f"appears after expression on line {first_expr_line + 1}. "
                    f"All Param/Delay/History/Buffer/Data declarations must come "
                    f"before any expressions in GenExpr.",
                ))
                break  # one error is enough to flag the issue
        elif "=" in stripped or re.search(r"\w+\.\w+\(", stripped):
            if first_expr_line < 0:
                first_expr_line = i

    # Check 6: Operator validation against gen/objects.json
    if db is None:
        from src.maxpat.db_lookup import ObjectDatabase
        db = ObjectDatabase()

    # Extract names declared by Param/History/Buffer/Data so we can skip them
    # as operators. These are variable names, not function calls.
    declared_names = set()
    decl_pattern = re.compile(r"(?:Param|History|Delay|Buffer|Data)\s+(\w+)\s*\(")
    for match in decl_pattern.finditer(code):
        declared_names.add(match.group(1))

    # Extract function-call-style tokens: word followed by (
    func_pattern = re.compile(r"\b(\w+)\s*\(")
    used_funcs = set()
    for match in func_pattern.finditer(code):
        func_name = match.group(1)
        if func_name not in _GENEXPR_KEYWORDS and func_name not in declared_names:
            used_funcs.add(func_name)

    # Check each function against gen/objects.json
    for func_name in sorted(used_funcs):
        # Look up in gen domain
        obj = db.lookup(func_name)
        if obj is None:
            results.append(ValidationResult(
                "code", "error",
                f"Unknown GenExpr operator: '{func_name}' "
                f"(not found in gen/objects.json)",
            ))

    return results


def validate_js(code: str) -> list[ValidationResult]:
    """Validate js object V8 JavaScript code.

    Checks:
    1. inlets declaration present
    2. outlets declaration present
    3. Handler function presence
    4. outlet() index bounds

    All results use layer="code". Report-only, no auto-fix.

    Args:
        code: js V8 JavaScript source code string.

    Returns:
        List of ValidationResult.
    """
    results: list[ValidationResult] = []

    # Check 1: inlets declaration
    inlets_match = re.search(r"inlets\s*=\s*(\d+)", code)
    if not inlets_match:
        results.append(ValidationResult(
            "code", "error",
            "Missing 'inlets' declaration (required for js object)",
        ))

    # Check 2: outlets declaration
    outlets_match = re.search(r"outlets\s*=\s*(\d+)", code)
    if not outlets_match:
        results.append(ValidationResult(
            "code", "error",
            "Missing 'outlets' declaration (required for js object)",
        ))

    # Check 3: Handler presence
    handler_names = ["bang", "msg_int", "msg_float", "list", "anything"]
    found_handlers = []
    for handler in handler_names:
        if re.search(rf"function\s+{handler}\s*\(", code):
            found_handlers.append(handler)

    if not found_handlers:
        results.append(ValidationResult(
            "code", "warning",
            "No handler functions found (expected at least one of: "
            "bang, msg_int, msg_float, list, anything)",
        ))
    else:
        results.append(ValidationResult(
            "code", "info",
            f"Handler functions found: {', '.join(found_handlers)}",
        ))

    # Check 4: outlet() index bounds
    if outlets_match:
        num_outlets = int(outlets_match.group(1))
        outlet_calls = re.findall(r"outlet\(\s*(\d+)", code)
        for idx_str in outlet_calls:
            idx = int(idx_str)
            if idx >= num_outlets:
                results.append(ValidationResult(
                    "code", "error",
                    f"outlet() index {idx} out of bounds "
                    f"(declared outlets = {num_outlets}, valid indices: 0-{num_outlets - 1})",
                ))

    return results


def validate_n4m(code: str) -> list[ValidationResult]:
    """Validate Node for Max JavaScript code.

    Checks:
    1. require('max-api') present
    2. addHandler names are string literals
    3. maxAPI.outlet() called

    All results use layer="code". Report-only, no auto-fix.

    Args:
        code: N4M JavaScript source code string.

    Returns:
        List of ValidationResult.
    """
    results: list[ValidationResult] = []

    # Check 1: require('max-api')
    require_pattern = re.compile(r"""require\s*\(\s*['"]max-api['"]\s*\)""")
    if not require_pattern.search(code):
        results.append(ValidationResult(
            "code", "error",
            "Missing require('max-api') or require(\"max-api\") -- "
            "required for Node for Max scripts",
        ))

    # Check 2: addHandler calls
    handler_pattern = re.compile(r"""addHandler\s*\(\s*['"]([^'"]+)['"]""")
    handler_names = handler_pattern.findall(code)
    if handler_names:
        results.append(ValidationResult(
            "code", "info",
            f"Registered handlers: {', '.join(handler_names)}",
        ))

    # Also check for addHandler calls with non-string arguments
    non_string_pattern = re.compile(r"""addHandler\s*\(\s*[^'"\s]""")
    for match in non_string_pattern.finditer(code):
        # Make sure this isn't just a string we already matched
        pos = match.start()
        if not handler_pattern.search(code[pos:pos + 50]):
            results.append(ValidationResult(
                "code", "warning",
                "addHandler called with non-string name literal",
            ))

    # Check 3: maxAPI.outlet()
    outlet_pattern = re.compile(r"maxAPI\.outlet\(")
    if not outlet_pattern.search(code):
        results.append(ValidationResult(
            "code", "warning",
            "No maxAPI.outlet() call found -- script may not send data back to MAX",
        ))

    return results


def detect_js_type(code: str) -> str | None:
    """Detect whether JavaScript code is Node for Max or js V8.

    Args:
        code: JavaScript source code string.

    Returns:
        "n4m" if code contains require('max-api'),
        "js" if code contains inlets declaration,
        None if neither is detected.
    """
    if re.search(r"""require\s*\(\s*['"]max-api['"]\s*\)""", code):
        return "n4m"
    if re.search(r"inlets\s*=", code):
        return "js"
    return None
