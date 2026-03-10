"""RNBO critic -- semantic review of RNBO patches.

Catches RNBO-specific issues that the mechanical RNBO validation pipeline
does not detect:
  - Param naming conventions (lowercase_with_underscores preferred)
  - I/O completeness (inner patcher must have in~/out~)
  - Duplicate param names
  - Target fitness warnings (e.g., cpp with many params)

NOTE: Overlaps intentionally with rnbo_validation.py at the semantic level.
rnbo_validation checks structural correctness (is it valid?), while this
critic checks design quality (is it well-designed?).
"""

from __future__ import annotations

import re

from src.maxpat.critics.base import CriticResult


# Regex to extract param @name from box text like "param @name foo @min 0 @max 1"
_PARAM_NAME_RE = re.compile(r"@name\s+(\S+)")

# Regex for lowercase_with_underscores convention
_LOWERCASE_UNDERSCORE_RE = re.compile(r"^[a-z][a-z0-9_]*$")


def review_rnbo(
    patch_dict: dict,
    code_context: dict | None = None,
) -> list[CriticResult]:
    """Review RNBO aspects of a patch.

    Scans for rnbo~ boxes in the patch and reviews their inner patchers
    for semantic issues: param naming, I/O completeness, duplicates,
    and target fitness.

    Args:
        patch_dict: A .maxpat-format dict.
        code_context: Optional dict. If it contains "rnbo_target", validates
            target-specific constraints.

    Returns:
        List of CriticResult findings.
    """
    results: list[CriticResult] = []

    patcher = patch_dict.get("patcher", {})
    boxes = patcher.get("boxes", [])

    # Find all rnbo~ boxes
    for box_entry in boxes:
        box = box_entry.get("box", {})
        maxclass = box.get("maxclass", "")

        if maxclass != "rnbo~":
            continue

        inner_patcher = box.get("patcher")
        if not inner_patcher:
            results.append(CriticResult(
                "blocker",
                f"rnbo~ box '{box.get('id', '?')}' has no inner patcher",
                "Add an inner patcher with in~/out~ and param objects",
            ))
            continue

        inner_boxes = inner_patcher.get("boxes", [])
        results.extend(_check_io_completeness(box, inner_boxes))
        results.extend(_check_param_naming(inner_boxes))
        results.extend(_check_duplicate_params(inner_boxes))

        # Target fitness check
        if code_context and "rnbo_target" in code_context:
            target = code_context["rnbo_target"]
            results.extend(_check_target_fitness(inner_boxes, target))

    return results


def _get_inner_object_name(box: dict) -> str:
    """Extract the object name from an inner RNBO patcher box."""
    maxclass = box.get("maxclass", "")
    if maxclass == "newobj":
        text = box.get("text", "")
        if text:
            return text.split()[0]
        return ""
    return maxclass


def _check_io_completeness(
    rnbo_box: dict,
    inner_boxes: list[dict],
) -> list[CriticResult]:
    """Check that the inner RNBO patcher has at least one in~ and one out~."""
    results: list[CriticResult] = []

    has_in = False
    has_out = False

    for entry in inner_boxes:
        box = entry.get("box", {})
        name = _get_inner_object_name(box)
        if name == "in~":
            has_in = True
        elif name == "out~":
            has_out = True

    rnbo_id = rnbo_box.get("id", "?")

    if not has_in:
        results.append(CriticResult(
            "blocker",
            f"rnbo~ '{rnbo_id}' inner patcher has no in~ object -- "
            f"audio input will not work",
            "Add at least one 'in~' object to the inner RNBO patcher",
        ))

    if not has_out:
        results.append(CriticResult(
            "blocker",
            f"rnbo~ '{rnbo_id}' inner patcher has no out~ object -- "
            f"audio output will not work",
            "Add at least one 'out~' object to the inner RNBO patcher",
        ))

    return results


def _extract_param_name(text: str) -> str | None:
    """Extract the param name from box text like 'param @name foo ...'."""
    match = _PARAM_NAME_RE.search(text)
    if match:
        return match.group(1)
    return None


def _check_param_naming(
    inner_boxes: list[dict],
) -> list[CriticResult]:
    """Check that param names follow lowercase_with_underscores convention."""
    results: list[CriticResult] = []

    for entry in inner_boxes:
        box = entry.get("box", {})
        name = _get_inner_object_name(box)
        if name != "param":
            continue

        text = box.get("text", "")
        param_name = _extract_param_name(text)
        if param_name is None:
            continue

        if not _LOWERCASE_UNDERSCORE_RE.match(param_name):
            results.append(CriticResult(
                "warning",
                f"RNBO param '{param_name}' does not follow "
                f"lowercase_with_underscores naming convention",
                f"Rename to '{_to_snake_case(param_name)}' for consistency "
                f"with RNBO parameter naming best practices",
            ))

    return results


def _to_snake_case(name: str) -> str:
    """Convert PascalCase or camelCase to snake_case."""
    # Insert underscore before uppercase letters
    s1 = re.sub(r"([A-Z]+)([A-Z][a-z])", r"\1_\2", name)
    s2 = re.sub(r"([a-z0-9])([A-Z])", r"\1_\2", s1)
    return s2.lower()


def _check_duplicate_params(
    inner_boxes: list[dict],
) -> list[CriticResult]:
    """Check for duplicate param names in the RNBO patcher."""
    results: list[CriticResult] = []
    seen_names: dict[str, str] = {}  # name -> first box id

    for entry in inner_boxes:
        box = entry.get("box", {})
        name = _get_inner_object_name(box)
        if name != "param":
            continue

        text = box.get("text", "")
        param_name = _extract_param_name(text)
        if param_name is None:
            continue

        box_id = box.get("id", "?")
        if param_name in seen_names:
            results.append(CriticResult(
                "blocker",
                f"Duplicate RNBO param name '{param_name}' in boxes "
                f"'{seen_names[param_name]}' and '{box_id}'",
                f"Each RNBO param must have a unique @name -- "
                f"rename one of the duplicate '{param_name}' params",
            ))
        else:
            seen_names[param_name] = box_id

    return results


def _check_target_fitness(
    inner_boxes: list[dict],
    target: str,
) -> list[CriticResult]:
    """Check target-specific fitness issues.

    For 'cpp' target: warn if many params (>128 practical limit).
    """
    results: list[CriticResult] = []

    param_count = sum(
        1 for entry in inner_boxes
        if _get_inner_object_name(entry.get("box", {})) == "param"
    )

    if target == "cpp" and param_count > 128:
        results.append(CriticResult(
            "warning",
            f"C++ embedded target has a practical limit of 128 params "
            f"(MIDI CC count), but patch has {param_count} params",
            "Reduce the number of params or use a different export target",
        ))

    return results
