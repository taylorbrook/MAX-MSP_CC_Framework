"""External code critic -- semantic review of generated C++ external code.

Catches structural issues in Min-DevKit C++ source files:
  - Missing MIN_EXTERNAL macro (required for MAX to load the external)
  - Missing #include "c74_min.h" (required header)
  - Class/MIN_EXTERNAL name mismatch
  - Missing inlet<>/outlet<> for message/scheduler archetypes
  - Missing sample_operator/vector_operator for DSP archetypes
  - Missing timer<> for scheduler archetypes
  - TODO comments (informational -- handlers need implementation)
"""

from __future__ import annotations

import re

from src.maxpat.critics.base import CriticResult


# Regex patterns for external code checks
_MIN_EXTERNAL_RE = re.compile(r"MIN_EXTERNAL\s*\(\s*(\w+)\s*\)")
_INCLUDE_C74_RE = re.compile(r'#include\s+[<"]c74_min\.h[>"]')
_CLASS_DECL_RE = re.compile(r"class\s+(\w+)\s*:")
_INLET_RE = re.compile(r"inlet<[^>]*>")
_OUTLET_RE = re.compile(r"outlet<[^>]*>")
_SAMPLE_OPERATOR_RE = re.compile(r"sample_operator|vector_operator")
_TIMER_RE = re.compile(r"timer<[^>]*>")
_TODO_RE = re.compile(r"//\s*TODO\b[^\n]*|/\*.*?TODO\b.*?\*/", re.DOTALL)


def review_external(
    code_str: str,
    archetype: str = "message",
) -> list[CriticResult]:
    """Review C++ external source code for structural issues.

    Checks for required includes, macros, and archetype-specific patterns.

    Args:
        code_str: Complete C++ source code string.
        archetype: One of "message", "dsp", "scheduler".

    Returns:
        List of CriticResult findings.
    """
    results: list[CriticResult] = []

    # Check 1: #include "c74_min.h"
    if not _INCLUDE_C74_RE.search(code_str):
        results.append(CriticResult(
            "blocker",
            'Missing #include "c74_min.h" -- required Min-DevKit header',
            'Add #include "c74_min.h" at the top of the source file',
        ))

    # Check 2: MIN_EXTERNAL macro
    min_ext_match = _MIN_EXTERNAL_RE.search(code_str)
    if not min_ext_match:
        results.append(CriticResult(
            "blocker",
            "Missing MIN_EXTERNAL() macro -- MAX cannot load the external "
            "without this registration",
            "Add MIN_EXTERNAL(ClassName) at the end of the source file",
        ))
    else:
        # Check 3: Class name matches MIN_EXTERNAL argument
        ext_class_name = min_ext_match.group(1)
        class_match = _CLASS_DECL_RE.search(code_str)
        if class_match:
            declared_class = class_match.group(1)
            if declared_class != ext_class_name:
                results.append(CriticResult(
                    "blocker",
                    f"MIN_EXTERNAL({ext_class_name}) does not match "
                    f"class declaration '{declared_class}'",
                    f"Change MIN_EXTERNAL to MIN_EXTERNAL({declared_class}) "
                    f"or rename the class to '{ext_class_name}'",
                ))

    # Check 4: Inlet presence for message/scheduler archetypes
    if archetype in ("message", "scheduler"):
        if not _INLET_RE.search(code_str):
            results.append(CriticResult(
                "warning",
                f"No inlet<> found for {archetype} archetype -- "
                f"external will have no input",
                "Add at least one inlet<> declaration to the class",
            ))

    # Check 5: DSP -- sample_operator or vector_operator
    if archetype == "dsp":
        if not _SAMPLE_OPERATOR_RE.search(code_str):
            results.append(CriticResult(
                "blocker",
                "DSP archetype requires sample_operator or vector_operator "
                "but neither was found",
                "Add a sample_operator or vector_operator method to process "
                "audio samples",
            ))

    # Check 6: Scheduler -- timer<>
    if archetype == "scheduler":
        if not _TIMER_RE.search(code_str):
            results.append(CriticResult(
                "blocker",
                "Scheduler archetype requires timer<> but none was found",
                "Add a timer<> member to drive scheduled events",
            ))

    # Check 7: TODO comments (informational)
    todo_matches = _TODO_RE.findall(code_str)
    if todo_matches:
        todo_summary = "; ".join(
            m.strip().lstrip("/ ").lstrip("*").strip()[:60]
            for m in todo_matches[:5]  # cap at 5
        )
        results.append(CriticResult(
            "note",
            f"Found {len(todo_matches)} TODO comment(s): {todo_summary}",
            "Implement the TODO items before using the external",
        ))

    return results
