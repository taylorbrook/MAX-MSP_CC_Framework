"""Layout critic -- validates physical layout of boxes and cables.

Catches layout quality issues that the mechanical validation pipeline
does not detect:
  - Overlapping boxes (accounting for COLLISION_PAD)
  - Missing cable midpoints on offset/upward cables
  - Out-of-bounds placement (negative coordinates)

NOTE: Only checks the top-level patcher. Subpatcher layout is their
own concern and handled recursively by their own review_patch() call.
"""

from __future__ import annotations

from src.maxpat.critics.base import CriticResult
from src.maxpat.defaults import AESTHETIC_PALETTE, HORIZONTAL_THRESHOLD, UPWARD_BUS_THRESHOLD

# Collision padding from Phase 15-02 decision: 5px around all boxes
COLLISION_PAD = 5.0

# Decorative/background maxclasses excluded from overlap checks
_DECORATIVE_MAXCLASSES = frozenset({"comment", "panel"})

# Margin from box edge to first/last inlet/outlet center (matches layout.py)
_IO_MARGIN = 7.0


def review_layout(patch_dict: dict) -> list[CriticResult]:
    """Review physical layout of a patch for readability issues.

    Checks:
      1. Overlapping boxes (with COLLISION_PAD, excluding comments/panels)
      2. Missing cable midpoints on offset/upward cables
      3. Out-of-bounds placement (negative x or y)

    Args:
        patch_dict: A .maxpat-format dict.

    Returns:
        List of CriticResult findings.
    """
    results: list[CriticResult] = []

    patcher = patch_dict.get("patcher", {})
    boxes = patcher.get("boxes", [])
    lines = patcher.get("lines", [])

    # Extract raw box dicts
    box_list: list[dict] = []
    box_lookup: dict[str, dict] = {}
    for box_entry in boxes:
        box = box_entry.get("box", {})
        box_id = box.get("id")
        if box_id:
            box_list.append(box)
            box_lookup[box_id] = box

    # Run checks
    results.extend(_check_overlapping_boxes(box_list))
    results.extend(_check_missing_midpoints(box_lookup, lines))
    results.extend(_check_out_of_bounds(box_list))
    results.extend(_check_text_contrast(box_list, patcher))
    results.extend(_check_presentation_coverage(box_list))

    return results


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def _rects_overlap(r1: list[float], r2: list[float], pad: float) -> bool:
    """Check if two AABB rects are closer than ``pad`` pixels apart.

    Each rect is [x, y, width, height]. ``pad`` is the minimum required
    gap between the two rects -- if the gap on any axis is less than
    ``pad``, they are considered overlapping. We expand only one rect
    by half ``pad`` on each side (equivalent to Minkowski sum with a
    pad/2 border on each rect).
    """
    x1, y1, w1, h1 = r1
    x2, y2, w2, h2 = r2

    half = pad * 0.5

    # Expand rect1 by half-pad on each side
    left1, right1 = x1 - half, x1 + w1 + half
    top1, bottom1 = y1 - half, y1 + h1 + half
    # Expand rect2 by half-pad on each side
    left2, right2 = x2 - half, x2 + w2 + half
    top2, bottom2 = y2 - half, y2 + h2 + half

    # AABB overlap test: overlap if no separation on any axis
    if right1 <= left2 or right2 <= left1:
        return False
    if bottom1 <= top2 or bottom2 <= top1:
        return False
    return True


def _outlet_x(box: dict, outlet_idx: int) -> float:
    """Approximate x position of an outlet on a box (raw dict version)."""
    rect = box.get("patching_rect", [0, 0, 60, 22])
    x = rect[0]
    w = rect[2]
    n = box.get("numoutlets", 1)
    if n <= 1:
        return x + w * 0.5
    usable = w - 2 * _IO_MARGIN
    spacing = usable / (n - 1)
    return x + _IO_MARGIN + outlet_idx * spacing


def _inlet_x(box: dict, inlet_idx: int) -> float:
    """Approximate x position of an inlet on a box (raw dict version)."""
    rect = box.get("patching_rect", [0, 0, 60, 22])
    x = rect[0]
    w = rect[2]
    n = box.get("numinlets", 1)
    if n <= 1:
        return x + w * 0.5
    usable = w - 2 * _IO_MARGIN
    spacing = usable / (n - 1)
    return x + _IO_MARGIN + inlet_idx * spacing


def _box_label(box: dict) -> str:
    """Human-readable label for a box (text or maxclass)."""
    text = box.get("text", "")
    if text:
        return text.split()[0]
    return box.get("maxclass", "unknown")


# ---------------------------------------------------------------------------
# Check 1: Overlapping boxes
# ---------------------------------------------------------------------------

def _check_overlapping_boxes(box_list: list[dict]) -> list[CriticResult]:
    """Detect overlapping boxes (O(n^2) sweep, excluding decorative elements).

    Skips comment and panel boxes since they are background elements
    that intentionally overlap content.
    """
    results: list[CriticResult] = []

    # Filter to non-decorative boxes only
    check_boxes = [
        b for b in box_list
        if b.get("maxclass", "") not in _DECORATIVE_MAXCLASSES
    ]

    for i in range(len(check_boxes)):
        box_a = check_boxes[i]
        rect_a = box_a.get("patching_rect")
        if not rect_a or len(rect_a) < 4:
            continue

        for j in range(i + 1, len(check_boxes)):
            box_b = check_boxes[j]
            rect_b = box_b.get("patching_rect")
            if not rect_b or len(rect_b) < 4:
                continue

            if _rects_overlap(rect_a, rect_b, COLLISION_PAD):
                id_a = box_a.get("id", "?")
                id_b = box_b.get("id", "?")
                label_a = _box_label(box_a)
                label_b = _box_label(box_b)
                results.append(CriticResult(
                    "warning",
                    f"Overlapping boxes: '{label_a}' ({id_a}) and "
                    f"'{label_b}' ({id_b}) patching_rects overlap "
                    f"(within {COLLISION_PAD}px padding)",
                    "Adjust box positions to maintain at least "
                    f"{COLLISION_PAD}px clearance between objects",
                ))

    return results


# ---------------------------------------------------------------------------
# Check 2: Missing cable midpoints
# ---------------------------------------------------------------------------

def _check_missing_midpoints(
    box_lookup: dict[str, dict],
    lines: list[dict],
) -> list[CriticResult]:
    """Detect cables that need midpoints but don't have them.

    Checks two patterns:
    1. Horizontal offset > HORIZONTAL_THRESHOLD without midpoints
    2. Upward flow > UPWARD_BUS_THRESHOLD without midpoints
    """
    results: list[CriticResult] = []

    for line_entry in lines:
        patchline = line_entry.get("patchline", line_entry)
        source = patchline.get("source", [])
        destination = patchline.get("destination", [])
        midpoints = patchline.get("midpoints", [])

        if len(source) < 2 or len(destination) < 2:
            continue

        # Skip if midpoints already present
        if midpoints:
            continue

        src_id, src_outlet = source[0], source[1]
        dst_id, dst_inlet = destination[0], destination[1]

        src_box = box_lookup.get(src_id)
        dst_box = box_lookup.get(dst_id)
        if not src_box or not dst_box:
            continue

        src_rect = src_box.get("patching_rect")
        dst_rect = dst_box.get("patching_rect")
        if not src_rect or not dst_rect or len(src_rect) < 4 or len(dst_rect) < 4:
            continue

        # Compute outlet/inlet positions
        src_ox = _outlet_x(src_box, src_outlet)
        src_oy = src_rect[1] + src_rect[3]  # bottom of source box
        dst_ix = _inlet_x(dst_box, dst_inlet)
        dst_iy = dst_rect[1]  # top of destination box

        hdist = abs(src_ox - dst_ix)
        vdist = src_oy - dst_iy  # positive means upward flow

        # Check horizontal offset
        if hdist > HORIZONTAL_THRESHOLD and vdist <= 0:
            results.append(CriticResult(
                "warning",
                f"Missing midpoints: cable {src_id}[{src_outlet}] -> "
                f"{dst_id}[{dst_inlet}] has {hdist:.0f}px horizontal "
                f"offset without segmented routing",
                "Add midpoints for clean L-shaped cable routing",
            ))
        # Check upward flow
        elif vdist > UPWARD_BUS_THRESHOLD:
            results.append(CriticResult(
                "warning",
                f"Missing midpoints: upward cable {src_id}[{src_outlet}] -> "
                f"{dst_id}[{dst_inlet}] flows {vdist:.0f}px upward "
                f"without bus routing midpoints",
                "Add bus routing midpoints for upward-flowing cables",
            ))

    return results


# ---------------------------------------------------------------------------
# Check 3: Out-of-bounds placement
# ---------------------------------------------------------------------------

def _check_out_of_bounds(box_list: list[dict]) -> list[CriticResult]:
    """Detect boxes placed outside the visible canvas (negative coordinates)."""
    results: list[CriticResult] = []

    for box in box_list:
        rect = box.get("patching_rect")
        if not rect or len(rect) < 4:
            continue

        x, y = rect[0], rect[1]
        if x < 0 or y < 0:
            box_id = box.get("id", "?")
            label = _box_label(box)
            results.append(CriticResult(
                "warning",
                f"Out-of-bounds placement: '{label}' ({box_id}) at "
                f"position ({x:.1f}, {y:.1f}) is outside the visible canvas",
                "Move the object to a position with x >= 0 and y >= 0",
            ))

    return results


# ---------------------------------------------------------------------------
# Check 5: Presentation coverage
# ---------------------------------------------------------------------------

# Interactive param-entry widgets that belong in presentation mode when the
# patch uses it. Monitoring/level objects (gain~, meter~, scope~) and comments
# are deliberately excluded: they are often patching-side by design (e.g. a
# slaved stereo fader) and would produce persistent false positives.
_INTERACTIVE_MAXCLASSES = frozenset({
    "flonum", "number", "umenu", "toggle", "textedit", "kslider",
    "dial", "slider", "multislider", "rslider", "incdec", "tab",
    "pictslider", "matrixctrl", "textbutton",
    "live.dial", "live.slider", "live.numbox", "live.menu",
    "live.toggle", "live.tab", "live.text", "live.button",
})


def _check_presentation_coverage(box_list: list[dict]) -> list[CriticResult]:
    """Flag interactive controls missing from presentation mode.

    Only active when the patch uses presentation mode at all (at least one
    box has presentation=1). Every interactive param widget added by an
    edit must either join the presentation layout or be a deliberate,
    documented exclusion -- silent omission is the recurring failure this
    check exists to catch.
    """
    if not any(b.get("presentation") for b in box_list):
        return []  # patch does not use presentation mode

    results: list[CriticResult] = []
    for box in box_list:
        if box.get("maxclass") not in _INTERACTIVE_MAXCLASSES:
            continue
        if box.get("presentation"):
            continue
        box_id = box.get("id", "?")
        label = _box_label(box)
        results.append(CriticResult(
            "warning",
            f"Presentation coverage: interactive control '{label}' "
            f"({box_id}) is not in presentation mode, but this patch "
            "uses presentation mode",
            "Add it via Patcher.add_to_presentation(box, rect) with its "
            "label comment, or record a deliberate exclusion in context.md",
        ))
    return results


# ---------------------------------------------------------------------------
# Check 4: Low-contrast text
# ---------------------------------------------------------------------------


def _resolve_patcher_bg(patcher_props: dict) -> list[float]:
    """Patcher background, preferring the key MAX honors in locked mode."""
    for key in ("bgcolor", "editing_bgcolor", "locked_bgcolor"):
        value = patcher_props.get(key)
        if isinstance(value, list) and value:
            return list(value)
    return list(AESTHETIC_PALETTE["canvas_bg"])


def _check_text_contrast(box_list: list[dict], patcher_props: dict) -> list[CriticResult]:
    """Detect text boxes that fail WCAG contrast against their REAL background.

    Evaluates the EFFECTIVE background -- the box's own bgcolor, else the panel
    beneath it in whichever coordinate space the text is displayed in, else the
    patcher background -- rather than comparing against the palette canvas
    constant. The resolution logic is imported from src.maxpat.aesthetics so
    the critic and the generator cannot drift apart.

    Severity:
      - ``warning`` when the background is KNOWN and the ratio falls short.
      - ``note`` when the background had to be ASSUMED (panel with no color
        encoding), since the shortfall may not be real.
      - ``note`` for the D-1 case where presentation was chosen and patching
        mode is the compromised space.
    """
    from src.maxpat.aesthetics import (
        contrast_ratio,
        is_text_contrast_target,
        resolve_effective_background,
        resolve_panel_background,
    )
    from src.maxpat.defaults import MIN_CONTRAST_RATIO

    results: list[CriticResult] = []
    patcher_bg = _resolve_patcher_bg(patcher_props)

    panels = [b for b in box_list if b.get("maxclass") == "panel"]
    patching_layers = [
        (b.get("patching_rect"), resolve_panel_background(b)) for b in panels
    ]
    presentation_layers = [
        (b.get("presentation_rect"), resolve_panel_background(b))
        for b in panels
        if b.get("presentation") and b.get("presentation_rect")
    ]

    for box in box_list:
        if box.get("maxclass") == "panel":
            continue
        if not is_text_contrast_target(box.get("maxclass"), box):
            continue

        textcolor = box.get("textcolor")
        if not isinstance(textcolor, list) or len(textcolor) < 3:
            textcolor = [0.0, 0.0, 0.0, 1.0]

        resolution = resolve_effective_background(
            box,
            box.get("patching_rect"),
            bool(box.get("presentation")),
            box.get("presentation_rect"),
            patching_layers,
            presentation_layers,
            patcher_bg,
        )

        text = box.get("text") or ""
        label = text[:40] if text else "(empty)"
        ratio = contrast_ratio(textcolor, resolution.color)
        space = {
            "own": "own background",
            "presentation": "presentation-mode background",
            "patching": "patching-mode background",
        }[resolution.space]

        if ratio < MIN_CONTRAST_RATIO:
            if resolution.assumed:
                results.append(CriticResult(
                    "note",
                    f"Low contrast text: '{label}' scores {ratio:.2f}:1 against "
                    f"its {space}, below the WCAG AA minimum of "
                    f"{MIN_CONTRAST_RATIO}:1 -- but that background was ASSUMED "
                    "(the panel beneath it carries no color encoding), so the "
                    "shortfall may not be real",
                    "Give the panel an explicit bgcolor/bgfillcolor, then run "
                    "ensure_text_contrast() (new patches) or "
                    "repair_text_contrast(patcher) (existing patches)",
                ))
            else:
                results.append(CriticResult(
                    "warning",
                    f"Low contrast text: '{label}' scores {ratio:.2f}:1 against "
                    f"its {space}, below the WCAG AA minimum of "
                    f"{MIN_CONTRAST_RATIO}:1",
                    "Set textcolor via ensure_text_contrast() in the styling "
                    "pipeline, or repair_text_contrast(patcher) on an existing "
                    "patch",
                ))
            continue

        # D-1: presentation won, so patching mode may be the compromised space.
        if resolution.space == "presentation" and resolution.patching_color is not None:
            patch_ratio = contrast_ratio(textcolor, resolution.patching_color)
            if patch_ratio < MIN_CONTRAST_RATIO:
                results.append(CriticResult(
                    "note",
                    f"Presentation/patching contrast trade-off: '{label}' reads "
                    f"at {ratio:.2f}:1 in presentation but only "
                    f"{patch_ratio:.2f}:1 in patching mode. Presentation was "
                    "chosen because it is the user-facing surface (D-1)",
                    "No action needed unless this label is primarily read while "
                    "editing; if so, move it onto a panel in patching space too",
                ))

    return results
