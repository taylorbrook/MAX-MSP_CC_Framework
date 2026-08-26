"""Aesthetic styling helpers for MAX patcher generation.

Provides palette access, canvas background setting, object background
color helpers, panel auto-sizing, and patch complexity heuristics.
All colors come from AESTHETIC_PALETTE in defaults.py.
"""

from __future__ import annotations

from typing import TYPE_CHECKING, Any, NamedTuple

from src.maxpat.defaults import (
    AESTHETIC_PALETTE,
    MAX_DEFAULT_PANEL_BG,
    MIN_CONTRAST_RATIO,
)

if TYPE_CHECKING:
    from src.maxpat.patcher import Box, Patcher


# Candidate text colors the generator is allowed to assign, dark first.
# Tie-breaking iterates this order and only accepts a strict improvement, so
# an exact tie resolves to the dark candidate.
TEXT_COLOR_CANDIDATES: tuple[list[float], ...] = (
    [0.20, 0.20, 0.25, 1.0],   # dark
    [0.80, 0.80, 0.82, 1.0],   # light
)


def relative_luminance(rgba: list[float]) -> float:
    """WCAG 2.1 relative luminance of an sRGB color.

    Each channel is linearized (divided by 12.92 below the 0.03928 knee,
    otherwise ``((c + 0.055) / 1.055) ** 2.4``) and then weighted
    0.2126 / 0.7152 / 0.0722. Alpha is ignored.

    Args:
        rgba: RGBA (or RGB) color with channels in [0.0, 1.0].

    Returns:
        Relative luminance in [0.0, 1.0].
    """
    lin = []
    for c in rgba[:3]:
        c = min(max(float(c), 0.0), 1.0)
        lin.append(c / 12.92 if c <= 0.03928 else ((c + 0.055) / 1.055) ** 2.4)
    return 0.2126 * lin[0] + 0.7152 * lin[1] + 0.0722 * lin[2]


def contrast_ratio(fg: list[float], bg: list[float]) -> float:
    """WCAG 2.1 contrast ratio between two colors.

    ``(lighter + 0.05) / (darker + 0.05)`` over the two relative luminances.
    Symmetric in its arguments; ranges from 1.0 (identical) to 21.0
    (black on white).
    """
    l1 = relative_luminance(fg)
    l2 = relative_luminance(bg)
    lighter, darker = (l1, l2) if l1 >= l2 else (l2, l1)
    return (lighter + 0.05) / (darker + 0.05)


def best_text_color(
    backgrounds: list[list[float]],
    candidates: tuple[list[float], ...] | list[list[float]] | None = None,
) -> list[float]:
    """Pick the text color that reads best across a set of candidate backgrounds.

    Pass a single-element list when the background is known. Pass several when
    the background is indeterminate (e.g. an uncolored panel, where MAX's real
    fill is not discoverable -- see MAX_DEFAULT_PANEL_BG). The chosen candidate
    maximizes the MINIMUM contrast ratio across ``backgrounds``, so an
    indeterminate surface still gets the least-bad color rather than one that
    happens to be right for a guess.

    Ties break toward the dark candidate.

    Args:
        backgrounds: One or more RGBA backgrounds to read against.
        candidates: Text colors to choose from. Defaults to
            TEXT_COLOR_CANDIDATES.

    Returns:
        A new RGBA list (never a shared reference to a module constant).
    """
    cands = TEXT_COLOR_CANDIDATES if candidates is None else candidates
    if not backgrounds:
        return list(cands[0])

    best = None
    best_score = float("-inf")
    for cand in cands:
        score = min(contrast_ratio(cand, bg) for bg in backgrounds)
        if score > best_score:
            best_score = score
            best = cand
    return list(best)


def contrast_text_color(bg_color: list[float] | None) -> list[float]:
    """Return a text color with good contrast against the given background.

    Thin back-compat wrapper over ``best_text_color([bg_color])``.

    Args:
        bg_color: RGBA background color, or None for default canvas.

    Returns:
        RGBA color list suitable for readable text on the background.
    """
    if bg_color is None:
        return list(AESTHETIC_PALETTE["annotation_color"])
    return best_text_color([bg_color])


def set_canvas_background(
    patcher: Patcher,
    color: list[float] | None = None,
) -> None:
    """Set patcher canvas background color.

    Sets bgcolor, editing_bgcolor (unlocked mode) and locked_bgcolor (locked
    mode) to the same color for visual consistency.

    ``bgcolor`` is the patcher-level key MAX honors for locked and presentation
    mode (finding F-1: 11 of MAX's own shipped patchers set it, vs 2 setting
    editing_bgcolor). Leaving it unset makes MAX fall back to its light default
    while generator-side contrast logic assumes the dark canvas.

    Args:
        patcher: The Patcher instance to style.
        color: Custom RGBA color list. Defaults to AESTHETIC_PALETTE["canvas_bg"].
    """
    bg = color if color is not None else AESTHETIC_PALETTE["canvas_bg"]
    patcher.props["bgcolor"] = list(bg)
    patcher.props["editing_bgcolor"] = list(bg)
    patcher.props["locked_bgcolor"] = list(bg)


def set_object_bgcolor(
    box: Box,
    palette_key: str | None = None,
    color: list[float] | None = None,
) -> None:
    """Apply background color to a Box via extra_attrs.

    One of palette_key or color must be provided. If both are provided,
    palette_key takes precedence.

    Args:
        box: The Box instance to style.
        palette_key: Key in AESTHETIC_PALETTE to use for the color.
        color: Custom RGBA color list.

    Raises:
        ValueError: If neither palette_key nor color is provided.
    """
    if palette_key is not None:
        box.extra_attrs["bgcolor"] = list(AESTHETIC_PALETTE[palette_key])
    elif color is not None:
        box.extra_attrs["bgcolor"] = list(color)
    else:
        raise ValueError("One of palette_key or color must be provided")


def auto_size_panel(
    boxes: list[Box],
    padding: float = 18.0,
) -> tuple[float, float, float, float]:
    """Compute bounding box for a panel enclosing the given boxes.

    Returns (x, y, width, height) where the panel surrounds all boxes
    with the specified padding on every side.

    Args:
        boxes: List of Box instances to enclose. Each must have patching_rect.
        padding: Padding in pixels added on all four sides.

    Returns:
        (x, y, width, height) tuple. Returns (0.0, 0.0, 0.0, 0.0) if
        boxes is empty.
    """
    if not boxes:
        return (0.0, 0.0, 0.0, 0.0)

    min_x = min(b.patching_rect[0] for b in boxes)
    min_y = min(b.patching_rect[1] for b in boxes)
    max_x = max(b.patching_rect[0] + b.patching_rect[2] for b in boxes)
    max_y = max(b.patching_rect[1] + b.patching_rect[3] for b in boxes)

    return (
        min_x - padding,
        min_y - padding,
        (max_x - min_x) + 2 * padding,
        (max_y - min_y) + 2 * padding,
    )


_AUTO_HIGHLIGHT = {
    "dac~": "emphasis_dac",
    "ezdac~": "emphasis_dac",
    "loadbang": "emphasis_loadbang",
}


def apply_auto_styling(patcher: Patcher) -> None:
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
    ensure_text_contrast(patcher)


def _point_in_rect(px: float, py: float, rect: list[float]) -> bool:
    """Check if point (px, py) is inside [x, y, w, h] rect."""
    x, y, w, h = rect
    return x <= px <= x + w and y <= py <= y + h


class ResolvedBackground(NamedTuple):
    """A background color plus whether it was FOUND or ASSUMED.

    ``assumed=True`` means no color encoding was present and
    MAX_DEFAULT_PANEL_BG stood in for it. Callers must treat that case as
    indeterminate: feed the assumed color together with the surrounding
    surface into ``best_text_color()``, and downgrade critic findings to a
    ``note``.
    """

    color: list[float]
    assumed: bool


def resolve_fill_color(attrs: dict) -> list[float] | None:
    """Read a fill color out of a plain MAX attribute dict, or None.

    Takes a PLAIN dict so both entry points share one implementation:
    ``Box.extra_attrs`` on the object side, and the raw box dict on the
    critic side.

    Encodings, in priority order (counts from finding F-2 across this repo's
    58 generated panels):
      1. ``bgfillcolor`` dict -- ``color1``, else ``color``   (2 panels)
      2. flat top-level ``grad1``                             (37 panels)
      3. ``bgcolor``                                          (19 panels)
    """
    bgfill = attrs.get("bgfillcolor")
    if isinstance(bgfill, dict):
        for key in ("color1", "color"):
            value = bgfill.get(key)
            if isinstance(value, list) and value:
                return list(value)

    grad1 = attrs.get("grad1")
    if isinstance(grad1, list) and grad1:
        return list(grad1)

    bgcolor = attrs.get("bgcolor")
    if isinstance(bgcolor, list) and bgcolor:
        return list(bgcolor)

    return None


def resolve_panel_background(attrs: dict) -> ResolvedBackground:
    """Effective background of a panel, never None.

    Falls back to MAX_DEFAULT_PANEL_BG (flagged ``assumed=True``) when the
    panel carries no color encoding at all -- 84 of MAX's own shipped panels
    are in that state and MAX ships no discoverable default for it (F-3).
    """
    color = resolve_fill_color(attrs)
    if color is not None:
        return ResolvedBackground(color, False)
    return ResolvedBackground(list(MAX_DEFAULT_PANEL_BG), True)


def _get_panel_bgcolor(panel: Box) -> ResolvedBackground:
    """Box-object wrapper over resolve_panel_background()."""
    return resolve_panel_background(panel.extra_attrs)


def _resolve_patcher_bg(patcher: Patcher) -> list[float]:
    """Effective patcher background, preferring the key MAX actually honors.

    ``bgcolor`` is what MAX uses for locked/presentation mode; the two
    editing-specific keys are fallbacks for patches written before
    set_canvas_background() started emitting bgcolor.
    """
    for key in ("bgcolor", "editing_bgcolor", "locked_bgcolor"):
        value = patcher.props.get(key)
        if value:
            return list(value)
    return list(AESTHETIC_PALETTE["canvas_bg"])


def _bg_under_rect(
    rect: list[float] | None,
    panel_layers: list[tuple[list[float] | None, ResolvedBackground]],
    fallback: list[float],
) -> ResolvedBackground | None:
    """Background visible beneath the center of ``rect`` in one coordinate space.

    ``panel_layers`` is a list of (panel_rect, ResolvedBackground) in patcher
    box order; the LAST containing panel wins. Returns None when ``rect`` is
    None (the box is absent from that space).
    """
    if rect is None:
        return None
    cx = rect[0] + rect[2] * 0.5
    cy = rect[1] + rect[3] * 0.5
    result = ResolvedBackground(list(fallback), False)
    for panel_rect, panel_bg in panel_layers:
        if panel_rect is None:
            continue
        if _point_in_rect(cx, cy, panel_rect):
            result = ResolvedBackground(list(panel_bg.color), panel_bg.assumed)
    return result


class BackgroundResolution(NamedTuple):
    """Everything a caller needs to choose and justify a text color."""

    color: list[float]          # the effective background
    assumed: bool               # True when the color is a documented guess
    space: str                  # "own" | "presentation" | "patching"
    candidates: list[list[float]]   # backgrounds to feed best_text_color()
    patching_color: list[float] | None  # patching-space bg, for D-1 notes


# A box is a contrast target if it is a comment, or if it already carries a
# generator-set textcolor (this is what pulls in add_step_marker's textbutton
# while leaving plain objects like `toggle` alone).
_TEXT_BEARING_MAXCLASSES = frozenset({"comment"})


def is_text_contrast_target(maxclass: str | None, attrs: dict) -> bool:
    """Whether a box's text color is the generator's to control."""
    if maxclass in _TEXT_BEARING_MAXCLASSES:
        return True
    return "textcolor" in attrs


def resolve_effective_background(
    attrs: dict,
    patching_rect: list[float] | None,
    presentation: bool,
    presentation_rect: list[float] | None,
    patching_layers: list[tuple[list[float] | None, ResolvedBackground]],
    presentation_layers: list[tuple[list[float] | None, ResolvedBackground]],
    patcher_bg: list[float],
) -> BackgroundResolution:
    """Resolve the background a box's text actually renders over.

    Precedence:
      1. D-2 -- the box's OWN background, if it paints one. A box that paints
         its own background IS its own background, in both coordinate spaces.
      2. Presentation space, when the box is in presentation (D-1: presentation
         is the user-facing surface, so it decides on conflict).
      3. Patching space.

    When the winning background was assumed rather than found, the canvas is
    added as a second candidate so ``best_text_color`` can maximize the worst
    case across both plausible surfaces.
    """
    own = resolve_fill_color(attrs)
    if own is not None:
        return BackgroundResolution(own, False, "own", [own], own)

    patching_bg = _bg_under_rect(patching_rect, patching_layers, patcher_bg)

    if presentation and presentation_rect:
        primary = _bg_under_rect(presentation_rect, presentation_layers, patcher_bg)
        space = "presentation"
    else:
        primary = patching_bg
        space = "patching"

    if primary is None:
        primary = ResolvedBackground(list(patcher_bg), False)

    candidates = [list(primary.color)]
    if primary.assumed and list(patcher_bg) != list(primary.color):
        candidates.append(list(patcher_bg))

    return BackgroundResolution(
        list(primary.color),
        primary.assumed,
        space,
        candidates,
        list(patching_bg.color) if patching_bg is not None else None,
    )


def _set_textcolor(box: Box, color: list[float]) -> None:
    """Write a resolved textcolor to BOTH destinations a Box can serialize from.

    ``extra_attrs`` alone is not enough. For a round-tripped box (``_raw`` is
    populated) ``Patcher.to_dict()`` starts from ``_raw`` and overlays only
    text / rects / IO / inner-patcher -- generic ``extra_attrs`` entries are
    silently dropped (CLAUDE.md Rule #5). Writing only ``extra_attrs`` would
    make every in-memory assertion pass while nothing lands on disk.
    """
    box.extra_attrs["textcolor"] = list(color)
    if box._raw is not None:
        box._raw["textcolor"] = list(color)


def _apply_text_contrast(patcher: Patcher) -> int:
    """Shared engine behind ensure_text_contrast() and repair_text_contrast().

    Returns the number of boxes whose textcolor changed.
    """
    panels = [b for b in patcher.boxes if b.maxclass == "panel"]
    patcher_bg = _resolve_patcher_bg(patcher)

    patching_layers = [(p.patching_rect, _get_panel_bgcolor(p)) for p in panels]
    presentation_layers = [
        (p.presentation_rect, _get_panel_bgcolor(p))
        for p in panels
        if p.presentation and p.presentation_rect
    ]

    changed = 0
    for box in patcher.boxes:
        if box.maxclass == "panel":
            continue
        if not is_text_contrast_target(box.maxclass, box.extra_attrs):
            continue

        resolution = resolve_effective_background(
            box.extra_attrs,
            box.patching_rect,
            box.presentation,
            box.presentation_rect,
            patching_layers,
            presentation_layers,
            patcher_bg,
        )
        color = best_text_color(resolution.candidates)
        if box.extra_attrs.get("textcolor") != color:
            changed += 1
        _set_textcolor(box, color)

    return changed


def ensure_text_contrast(patcher: Patcher) -> None:
    """Set textcolor on text boxes for readability against their real background.

    The effective background is resolved per box, in this precedence order:

    - The box's OWN background, if it paints one (D-2). ``add_section_header``
      pairs a light ``header_bgcolor`` with its text; that pairing, not the
      dark canvas behind it, is what the reader sees.
    - Presentation space: the box's ``presentation_rect`` center against the
      ``presentation_rect`` of panels that are themselves in presentation.
    - Patching space: the box's ``patching_rect`` center against each panel's
      ``patching_rect``.

    Backgrounds fall back to the patcher background (``bgcolor``, then the two
    editing-specific keys, then the palette canvas) when no panel contains the
    box.

    When a box exists in both spaces and the two demand opposite text colors,
    the PRESENTATION result wins (locked decision D-1): presentation is the
    user-facing surface, so a patching-mode compromise is the acceptable half
    of the trade. The layout critic surfaces that compromise as a ``note`` so
    it is visible rather than silent.

    Colors are chosen by WCAG contrast ratio via ``best_text_color()``, not by
    a luminance>0.5 flip. Overrides semantic tier colors (header, subsection,
    annotation) because readability trumps cosmetic coloring.

    Args:
        patcher: The Patcher instance to process.
    """
    _apply_text_contrast(patcher)


def repair_text_contrast(patcher: Patcher) -> int:
    """Recompute text contrast on an ALREADY-LOADED patcher. Opt-in only.

    This is deliberately NOT wired into any automatic path (locked decision
    D-4). ``hooks.finalize_patch()`` runs ``apply_auto_styling`` -- and hence
    ``ensure_text_contrast`` -- only when ``is_new=True``, so editing an
    existing patch never silently restyles it. Call this explicitly, per
    patch, when you want an existing patch repaired.

    Args:
        patcher: A Patcher, typically from ``Patcher.from_dict(read_patch(...))``.

    Returns:
        Number of boxes whose textcolor changed. Idempotent: a second call on
        an unchanged patcher returns 0.
    """
    return _apply_text_contrast(patcher)


def is_complex_patch(patcher: Patcher) -> bool:
    """Heuristic to determine if a patch is visually complex.

    A patch is considered complex if it has 10 or more boxes, or if any
    box contains a subpatcher (inner patcher).

    Args:
        patcher: The Patcher instance to evaluate.

    Returns:
        True if the patch is complex, False otherwise.
    """
    if len(patcher.boxes) >= 10:
        return True
    for box in patcher.boxes:
        if box._inner_patcher is not None:
            return True
    return False
