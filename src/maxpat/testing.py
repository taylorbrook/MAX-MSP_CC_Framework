"""Manual test checklist generation from patch structure.

Bridges automated validation and manual MAX testing by generating
step-by-step checklists based on the objects found in a patch.
"""

from __future__ import annotations

from pathlib import Path


def generate_test_checklist(
    patch_dict: dict, patch_name: str, patch_path: str = ""
) -> str:
    """Generate a markdown test checklist from a patch dictionary.

    Scans the patch for object types and builds relevant manual test steps.
    Each step has a numbered item, descriptive name, action, and expected result
    with Pass/Fail checkboxes.

    Args:
        patch_dict: A .maxpat-style dict with patcher.boxes.
        patch_name: Human-readable name for the test checklist.
        patch_path: Optional file path for the setup section.

    Returns:
        Complete markdown string with numbered test steps.
    """
    boxes = patch_dict.get("patcher", {}).get("boxes", [])
    object_names = _extract_object_names(boxes)

    has_signal = any(name.endswith("~") for name in object_names)
    has_dac = any(name in ("dac~", "ezdac~") for name in object_names)
    has_midi = any(name in ("notein", "midiin", "ctlin", "pgmin", "bendin") for name in object_names)
    has_toggle = "toggle" in object_names
    has_button = "button" in object_names
    has_gen = "gen~" in object_names
    has_number = any(name in ("number", "flonum") for name in object_names)
    has_metro = any(name.startswith("metro") for name in object_names)

    lines: list[str] = []
    lines.append(f"# Test Checklist: {patch_name}")
    lines.append("")

    # Setup section
    lines.append("## Setup")
    lines.append("")
    if patch_path:
        lines.append(f"1. Open `{patch_path}` in MAX")
    else:
        lines.append(f"1. Open the patch in MAX")
    if has_signal:
        lines.append("2. Turn on audio (Audio Status -> Audio On)")
    lines.append("")

    # Test steps
    lines.append("## Tests")
    lines.append("")
    step = 1

    if has_dac:
        lines.append(f"### {step}. Audio Output")
        lines.append("")
        lines.append(f"- **Action:** Toggle audio on. Verify sound comes from speakers/headphones.")
        lines.append(f"- **Expected:** Audio signal audible at safe volume level.")
        lines.append(f"- [ ] Pass  [ ] Fail")
        lines.append("")
        step += 1

    if has_midi:
        lines.append(f"### {step}. MIDI Input")
        lines.append("")
        lines.append(f"- **Action:** Play a MIDI note from controller or virtual keyboard.")
        lines.append(f"- **Expected:** Pitch change or note value displayed downstream.")
        lines.append(f"- [ ] Pass  [ ] Fail")
        lines.append("")
        step += 1

    if has_toggle:
        lines.append(f"### {step}. Toggle Interaction")
        lines.append("")
        lines.append(f"- **Action:** Click the toggle to change its state.")
        lines.append(f"- **Expected:** State change propagates to downstream objects.")
        lines.append(f"- [ ] Pass  [ ] Fail")
        lines.append("")
        step += 1

    if has_button:
        lines.append(f"### {step}. Button Click")
        lines.append("")
        lines.append(f"- **Action:** Click the button to send a bang.")
        lines.append(f"- **Expected:** Downstream objects trigger correctly.")
        lines.append(f"- [ ] Pass  [ ] Fail")
        lines.append("")
        step += 1

    if has_gen:
        lines.append(f"### {step}. gen~ Processing")
        lines.append("")
        lines.append(f"- **Action:** Enable audio and verify gen~ processes signal correctly.")
        lines.append(f"- **Expected:** gen~ output matches expected DSP behavior.")
        lines.append(f"- [ ] Pass  [ ] Fail")
        lines.append("")
        step += 1

    if has_number:
        lines.append(f"### {step}. Number Box Input")
        lines.append("")
        lines.append(f"- **Action:** Double-click number box and type a value. Press Enter.")
        lines.append(f"- **Expected:** Value propagates to connected objects.")
        lines.append(f"- [ ] Pass  [ ] Fail")
        lines.append("")
        step += 1

    if has_metro:
        lines.append(f"### {step}. Metro Timing")
        lines.append("")
        lines.append(f"- **Action:** Turn on metro (connect toggle or send bang).")
        lines.append(f"- **Expected:** Regular bangs at specified interval.")
        lines.append(f"- [ ] Pass  [ ] Fail")
        lines.append("")
        step += 1

    # Always include a basic "open and inspect" test
    if step == 1:
        # Empty or unrecognized patch -- minimal checklist
        lines.append(f"### {step}. Open and Inspect")
        lines.append("")
        lines.append(f"- **Action:** Open patch in MAX. Verify it loads without errors.")
        lines.append(f"- **Expected:** Patch opens cleanly, no error messages in console.")
        lines.append(f"- [ ] Pass  [ ] Fail")
        lines.append("")

    return "\n".join(lines)


def save_test_results(
    project_dir: Path, test_name: str, results_md: str
) -> Path:
    """Write test results to the project's test-results/ directory.

    Args:
        project_dir: Path to the project directory.
        test_name: Name for the test results file (without extension).
        results_md: Markdown content to write.

    Returns:
        Path to the written file.
    """
    results_dir = project_dir / "test-results"
    results_dir.mkdir(parents=True, exist_ok=True)

    result_path = results_dir / f"{test_name}.md"
    result_path.write_text(results_md)

    return result_path


def _extract_object_names(boxes: list[dict]) -> list[str]:
    """Extract object names from a list of box dicts.

    Handles both 'text' field (newobj) and 'maxclass' for UI objects.
    For text like "metro 500", extracts the base name "metro".
    """
    names = []
    for box_wrapper in boxes:
        box = box_wrapper.get("box", {})
        text = box.get("text", "")
        maxclass = box.get("maxclass", "")

        if text:
            # First word of text is the object name
            base_name = text.split()[0]
            names.append(base_name)
            # Also keep full text for pattern matching (e.g., "metro 500")
            if base_name != text:
                names.append(text)

        # UI objects use maxclass directly
        if maxclass in ("toggle", "button", "number", "flonum", "slider",
                        "dial", "comment", "message", "live.dial"):
            if maxclass not in names:
                names.append(maxclass)

    return names
