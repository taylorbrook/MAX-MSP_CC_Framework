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


# Declaration prefixes for Check 5 (declaration ordering) and Check 9 (init-
# before-if/else). Module-level so multiple checks can reuse without rebinding.
# Hoisted from validate_genexpr local scope (Phase 29 / VALID-04 / D-16).
_DECL_PREFIXES = ("Param ", "History ", "Delay ", "Buffer ", "Data ")


def _strip_line_comments(code: str) -> str:
    """Remove `//` line comments so regex checks (Checks 7, 8) can scan
    code text without false-positive matches inside commented-out
    examples. Block comments (`/* ... */`) are not used in GenExpr and
    are not handled. Single pass; preserves line count for error
    line-number reporting in Check 9.
    """
    return "\n".join(
        re.sub(r"//.*$", "", line) for line in code.split("\n")
    )


def validate_genexpr(
    code: str,
    db: "ObjectDatabase | None" = None,
) -> list[ValidationResult]:
    """Validate GenExpr DSP code.

    Checks:
    1. Balanced braces (error)
    2. Semicolons on statement lines (warning)
    3. in/out declarations (info)
    4. Param syntax min/max (warning)
    5. Declaration ordering (error)
    6. Operator existence against gen/objects.json (error)
    7. delay() rejection -- not supported in codebox (error, D-14)
    8. clip() rejection -- not supported in expr/GenExpr (error, D-15)
    9. Init-before-if/else flow analysis (error, D-16)

    All results use layer="code". Report-only, no auto-fix.

    Args:
        code: GenExpr source code string.
        db: ObjectDatabase instance. Created if None.

    Returns:
        List of ValidationResult.
    """
    results: list[ValidationResult] = []

    # Strip // line comments once so Checks 7/8 don't false-positive on
    # commented examples. Preserves line count for Check 9 line-number
    # reporting (Check 9 walks `lines` directly and uses its own //
    # skipping, so it does NOT use code_stripped).
    code_stripped = _strip_line_comments(code)

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
    # _DECL_PREFIXES is module-level (hoisted Phase 29 for Check 9 reuse).
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
    # as operators. These are variable names, not function calls. Scan the
    # comment-stripped source so an ALL-CAPS banner like
    # `// === SATURATION (Pade tanh) ===` is not tokenized -- the word before
    # `(` inside a // comment must never be treated as an operator call
    # (tape-wobble false positive: DRIFT/EQ/LFO/ROLLOFF/SATURATION/SIGNAL).
    declared_names = set()
    decl_pattern = re.compile(r"(?:Param|History|Delay|Buffer|Data)\s+(\w+)\s*\(")
    for match in decl_pattern.finditer(code_stripped):
        declared_names.add(match.group(1))

    # Extract function-call-style tokens: word followed by (
    func_pattern = re.compile(r"\b(\w+)\s*\(")
    used_funcs = set()
    for match in func_pattern.finditer(code_stripped):
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

    # Check 7: delay() rejection (D-14, VALID-04). Compile-fatal in MAX,
    # so ERROR severity. Word-boundary prevents matching Delay(...) or
    # myDelay.read(...). Comment-stripped via code_stripped.
    if re.search(r"\bdelay\s*\(", code_stripped):
        results.append(ValidationResult(
            "code", "error",
            "delay() is not supported in GenExpr codebox; "
            "use Delay.read/write (declare Delay myDelay(max_samples) first)",
        ))

    # Check 8: clip() rejection (D-15, VALID-04). expr/GenExpr have no
    # clip(). Compile-fatal, so ERROR. Word-boundary on \bclip\s*\(.
    if re.search(r"\bclip\s*\(", code_stripped):
        results.append(ValidationResult(
            "code", "error",
            "clip() does not exist in expr/GenExpr; "
            "use min(max(x, lo), hi)",
        ))

    # Check 9: init-before-if/else (D-16, D-20, VALID-04). Light flow
    # analysis. The genuine GenExpr "not defined" error is a READ of a name
    # at brace depth 0 whose only assignments live inside an if/else block --
    # i.e. on a path where the block did not run, the name was never
    # defined. A name assigned AND read entirely within the same branch is
    # valid GenExpr and must NOT be flagged (fixes scala-synth-voice,
    # timestretch, wormhole false positives). Two passes over `lines`:
    #   Pass 1: collect pre_block_inits (depth-0 LHS), declared
    #           (Param/History/Delay/Buffer/Data), and block_assigned
    #           (names assigned at depth >= 1 that are neither pre-init nor
    #           declared) with the line of first in-block assignment.
    #   Pass 2: walk again; on a depth-0 read of a block_assigned name
    #           (not pre-init, not a GenExpr keyword/builtin), record it as
    #           a genuine read-before-init occurrence.
    # First-error-and-stop matches Check 5 posture. Documented false-
    # positive limitations (D-20) surfaced in the suggestion line.
    declared = set()
    for match in re.finditer(
        r"(?:Param|History|Delay|Buffer|Data)\s+(\w+)\s*\(", code
    ):
        declared.add(match.group(1))

    # `assign_pattern` anchored at line start; a `(?!=)` guard keeps it from
    # matching equality (`==`). The start anchor preserves the documented
    # single-line-if false negative (`if (c) { y = 1; }` -> matches 'if').
    assign_pattern = re.compile(r"^(\w+)\s*=(?!=)")
    ident_pattern = re.compile(r"[A-Za-z_]\w*")

    # Pass 1: assignments.
    pre_block_inits: set[str] = set()
    block_assigned: dict[str, int] = {}
    depth = 0
    for i, line in enumerate(lines):
        stripped = line.strip()
        if not stripped or stripped.startswith("//") or stripped.startswith("#"):
            continue
        opens = stripped.count("{")
        closes = stripped.count("}")
        m = assign_pattern.match(stripped)
        if m:
            name = m.group(1)
            if depth == 0:
                pre_block_inits.add(name)
            elif name not in pre_block_inits and name not in declared:
                block_assigned.setdefault(name, i)
        depth += opens - closes
        if depth < 0:
            depth = 0  # unbalanced; Check 1 already flagged it

    # Pass 2: reads at depth 0. Depth is evaluated at the START of each line
    # (before applying this line's braces) so an `if (cond) {` condition and
    # a bare `out1 = name;` statement both count as depth-0 reads.
    if_else_inits: list[tuple[str, int]] = []
    seen_reads: set[str] = set()
    depth = 0
    for i, line in enumerate(lines):
        stripped = line.strip()
        if not stripped or stripped.startswith("//") or stripped.startswith("#"):
            opens = stripped.count("{")
            closes = stripped.count("}")
            depth += opens - closes
            if depth < 0:
                depth = 0
            continue
        opens = stripped.count("{")
        closes = stripped.count("}")
        if depth == 0:
            # Read portion: RHS of an assignment (LHS is a write, not a
            # read), else the whole line.
            m = assign_pattern.match(stripped)
            read_src = stripped[m.end():] if m else stripped
            for tok in ident_pattern.findall(read_src):
                if (
                    tok in block_assigned
                    and tok not in pre_block_inits
                    and tok not in _GENEXPR_KEYWORDS
                    and tok not in seen_reads
                ):
                    seen_reads.add(tok)
                    if_else_inits.append((tok, block_assigned[tok]))
        depth += opens - closes
        if depth < 0:
            depth = 0

    seen = set()
    for name, line_no in if_else_inits:
        if name in seen:
            continue
        seen.add(name)
        # Guard against block_start_line=-1 (assignment seen at depth>=1
        # without a tracked outermost-block opening line, e.g., malformed
        # input). Avoid misleading "(line 0)" output.
        line_display = (
            f"line {line_no + 1}" if line_no >= 0 else "in an if/else block"
        )
        results.append(ValidationResult(
            "code", "error",
            f"variable '{name}' used inside if/else without prior init "
            f"({line_display}); GenExpr errors with 'not defined'. "
            f"Restructure to assign '{name}' before the if/else, or "
            f"if this is a false positive (e.g., shadowed inner "
            f"declaration), declare via Param/History/Delay/Buffer/Data.",
        ))
        break  # first-error-and-stop, matches Check 5

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
