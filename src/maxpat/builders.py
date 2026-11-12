"""Object-builder mixin for Patcher.

Provides the ``add_*`` builder methods that construct boxes and connections on
a Patcher (comments, panels, subpatchers, gen~, bpatchers, M4L synths,
JS/Node scripts, etc.). Extracted from patcher.py for maintainability,
mirroring the GraphMixin/AnalysisMixin split.

The methods reference sibling Patcher helpers (``_gen_id``, ``_auto_position``,
``_find_clear_position``, ``bring_to_front``, ``set_z_index``, ``get_inlets``,
``get_outlets``, ``modify_box``, ``add_connection``, ...) and state
(``self.boxes``, ``self.lines``, ``self.db``, ``self.allowed_packages``,
``self.props``) via ``self`` at runtime, resolved through the host class.
"""

from __future__ import annotations

import re
import warnings
from typing import Any

from src.maxpat.defaults import (
    AESTHETIC_PALETTE,
    BUBBLE_TOP,
    FONT_NAME,
    FONT_SIZE,
    FONTFACE_BOLD,
    FONTFACE_ITALIC,
    GEN_PATCHER_BGCOLOR,
)
from src.maxpat.maxclass_map import is_ui_object
from src.maxpat.sizing import calculate_box_size, is_max_saved, rendered_rect
from src.maxpat.patcher import Box, Patchline

# A numeric string add_bpatcher stores as a JSON number (Q23 D11; the same
# predicate as validation._NUMERIC_STRING_RE, no exponent forms).
_NUMERIC_ARG_RE = re.compile(r"[+-]?(\d+\.?\d*|\.\d+)")


def _bpatcher_arg(value):
    """*value*, or the int / float a numeric string spells (Q23 D11)."""
    if isinstance(value, str) and _NUMERIC_ARG_RE.fullmatch(value):
        return float(value) if "." in value else int(value)
    return value


class BuildersMixin:
    """``add_*`` builder methods mixed into Patcher.

    Expects the host class (Patcher) to provide ``self.boxes``, ``self.lines``,
    ``self.db``, ``self.allowed_packages``, ``self.props``, and the sibling
    helper methods listed in the module docstring.
    """

    def add_box(
        self,
        name: str,
        args: list[str] | None = None,
        x: float = 0.0,
        y: float = 0.0,
        skip_overlap_check: bool = False,
    ) -> Box:
        """Add a MAX object box to the patcher.

        Args:
            name: Object name (e.g., "cycle~", "toggle", "t").
            args: Object arguments (e.g., ["440"]).
            x: Horizontal position (default 0, set by layout engine later).
            y: Vertical position (default 0, set by layout engine later).
            skip_overlap_check: If False (default), the requested position
                is kept unless the box truly overlaps (positive-area
                intersection) an existing box, both measured by
                ``sizing.rendered_rect`` (Q27 / F5) -- companion layouts
                such as a ``meter~`` 5px right of a ``gain~`` stay put and
                nothing snaps to a grid (Q29 / B10). On a real overlap the
                box moves down in 15px steps (a column right after y 2400)
                to at least 5px clearance, ``box.nudged_from`` records the
                requested (x, y), and a ``BoxMovedWarning`` names the box,
                both positions and the box it overlapped -- except for the
                default origin (0, 0), which means "let layout place it".
                Set True when the caller handles its own positioning (e.g.,
                replace_box, insert_into_connection, add_subpatcher); the
                box is then never moved.

        Returns:
            The created Box instance (``nudged_from`` is None unless it was
            moved).

        Raises:
            ValueError: If object not found in database (Rule #1); if
                *name* is ``p``/``patcher`` (use ``add_subpatcher``; review
                C4, Q13); if *name* is a UI maxclass with no DB entry, whose
                inlets/outlets would be guessed (Rule #1; today ``markup``
                and ``progress``); or if its effective domain restriction
                excludes this patcher's ``domain_context`` (an RNBO/Gen-only
                name such as ``expr~`` or ``history`` in a Max patcher;
                Q12 / C3). These checks run first, so a refusal changes
                nothing.
        """
        self._require_buildable(name)
        self._require_domain_scope(name)
        box_id = self._gen_id()
        x, y = float(x), float(y)
        box = Box(name=name, args=args, box_id=box_id, db=self.db, x=x, y=y,
                  allowed_packages=self.allowed_packages)

        if not skip_overlap_check:
            r = rendered_rect(box, max_saved=is_max_saved(self.props))
            if r is not None:
                w, h = r[2], r[3]
            else:
                w, h = box.patching_rect[2], box.patching_rect[3]
            # Move only on a real overlap, and report it (Q29 / B10)
            new_x, new_y, hit = self._nudge_off_overlap(x, y, w, h)
            if new_x != x or new_y != y:
                box.patching_rect[0] = new_x
                box.patching_rect[1] = new_y
                box.nudged_from = (x, y)
                if (x, y) != (0.0, 0.0):
                    from src.maxpat.patcher import BoxMovedWarning
                    hit_id = hit.id if hit is not None else None
                    warnings.warn(
                        BoxMovedWarning(
                            f"add_box moved {box.text or name!r} ({box.id}) from "
                            f"({x:g}, {y:g}) to ({new_x:g}, {new_y:g}): it "
                            f"overlapped {hit_id}"
                        ),
                        stacklevel=2,
                    )

        self.boxes.append(box)
        # A port box inside a subpatcher/bpatcher grows the parent box's
        # port count and shifts parent cords at or above its x-rank (Q28 / B7).
        if (box.maxclass in ("inlet", "outlet")
                and not getattr(self, "_port_sync_suspended", False)):
            self._sync_parent_ports_after_add(box)
        return box

    def _require_buildable(self, name: str) -> None:
        """Raise ValueError when add_box cannot build *name* correctly.

        - ``p``/``patcher``: MAX saves a subpatcher as a newobj ``p <name>``
          box carrying its embedded patcher (review C4, Q13); add_box would
          write a box with no inner patcher. Use ``add_subpatcher``.
        - A UI maxclass (C5, Q13) with no object-DB entry: Box would guess
          its inlets/outlets (Rule #1: Never Guess Objects).

        ``add_subpatcher``, ``add_comment`` and ``add_message`` build their
        boxes directly and are unaffected.
        """
        canonical = self.db._aliases.get(name, name)
        if canonical == "patcher":
            raise ValueError(
                f"'{name}' cannot be built with add_box: MAX saves a "
                f"subpatcher as a newobj 'p <name>' box that carries its "
                f"embedded patcher (review C4). Use "
                f"add_subpatcher(name, inlets=..., outlets=...), which returns "
                f"(box, inner_patcher)."
            )
        if is_ui_object(canonical) and not self.db.exists(name):
            raise ValueError(
                f"'{name}' is a UI maxclass (MAX saves it with its own "
                f"maxclass), but the object DB has no entry for it, so its "
                f"inlets/outlets would be guessed (Rule #1: Never Guess "
                f"Objects). It cannot be built until the DB has it."
            )

    def _require_domain_scope(self, name: str) -> None:
        """Raise ValueError when *name* may not live in this patcher's scope.

        Uses ``db.get_effective_restrictions`` (explicit ``domain_restricted``
        else the implied rnbo/gen-only restriction; Q12 / C3) against
        ``self.domain_context`` (default "max"). An ``m4l`` restriction
        allows a Max patcher: an M4L device is a Max patcher (Layer 4b
        still reports explicit m4l tags as before).
        """
        restr = self.db.get_effective_restrictions(name)
        if not restr:
            return
        ctx = getattr(self, "domain_context", "max")
        allowed = set(restr)
        if "m4l" in allowed:
            allowed.add("max")
        if ctx in allowed:
            return
        msg = (
            f"'{name}' is restricted to {restr} and cannot be added to a "
            f"{ctx} patcher (Rule #1: MAX says \"No such object\" for it here). "
            f"Add it inside an add_rnbo/add_gen inner patcher, or use a MAX object."
        )
        equivalent = self.db.suggest_max_equivalent(name)
        if equivalent:
            msg += f" MAX equivalent: {equivalent}"
        raise ValueError(msg)

    def add_comment(
        self, text: str, x: float = 0.0, y: float = 0.0, target: Box | None = None,
    ) -> Box:
        """Add a comment box to the patcher.

        Args:
            text: Comment text.
            x: Horizontal position.
            y: Vertical position.
            target: Optional target box. If provided, the comment's target_id
                is set to target.id for layout-time association.

        Returns:
            The created comment Box.
        """
        box_id = self._gen_id()
        box = Box(name="comment", args=[], box_id=box_id, db=self.db, x=x, y=y,
                  allowed_packages=self.allowed_packages)
        # Override text: comment's text is the comment itself, not "comment"
        box.text = text
        # Recalculate size based on actual text
        from src.maxpat.sizing import calculate_box_size
        w, h = calculate_box_size(text, "comment")
        box.patching_rect = [x, y, w, h]
        if target is not None:
            box.target_id = target.id
        self.boxes.append(box)
        return box

    def add_section_header(
        self, text: str, x: float = 0.0, y: float = 0.0
    ) -> Box:
        """Add a section header comment (16pt bold, colored text + background).

        Args:
            text: Header text.
            x: Horizontal position.
            y: Vertical position.

        Returns:
            The created styled comment Box.
        """
        box = self.add_comment(text, x, y)
        box.fontsize = 16.0
        box.extra_attrs["fontface"] = FONTFACE_BOLD
        box.extra_attrs["textcolor"] = list(AESTHETIC_PALETTE["header_color"])
        box.extra_attrs["bgcolor"] = list(AESTHETIC_PALETTE["header_bgcolor"])
        # Recalculate size for 16pt chars (wider than default 12pt)
        box.patching_rect[2] = len(text) * 9.5 + 20.0
        box.patching_rect[3] = 24.0
        return box

    def add_subsection(
        self, text: str, x: float = 0.0, y: float = 0.0
    ) -> Box:
        """Add a subsection label comment (12pt bold, dark gray).

        Args:
            text: Subsection text.
            x: Horizontal position.
            y: Vertical position.

        Returns:
            The created styled comment Box.
        """
        box = self.add_comment(text, x, y)
        # fontsize stays at 12.0 (default)
        box.extra_attrs["fontface"] = FONTFACE_BOLD
        box.extra_attrs["textcolor"] = list(AESTHETIC_PALETTE["subsection_color"])
        # No bgcolor for subsections
        return box

    def add_annotation(
        self, text: str, x: float = 0.0, y: float = 0.0, target: Box | None = None,
    ) -> Box:
        """Add an inline annotation comment (10pt italic, light gray).

        Args:
            text: Annotation text.
            x: Horizontal position.
            y: Vertical position.
            target: Optional target box for layout-time association.

        Returns:
            The created styled comment Box.
        """
        box = self.add_comment(text, x, y, target=target)
        box.fontsize = 10.0
        box.extra_attrs["fontface"] = FONTFACE_ITALIC
        box.extra_attrs["textcolor"] = list(AESTHETIC_PALETTE["annotation_color"])
        # Recalculate size for 10pt chars (narrower than default 12pt)
        box.patching_rect[2] = len(text) * 6.0 + 14.0
        box.patching_rect[3] = 18.0
        return box

    def add_bubble(
        self,
        text: str,
        x: float = 0.0,
        y: float = 0.0,
        bubbleside: int | None = None,
    ) -> Box:
        """Add a bubble comment with arrow pointer.

        Args:
            text: Comment text.
            x: Horizontal position.
            y: Vertical position.
            bubbleside: Arrow direction (0=left, 1=top, 2=right, 3=bottom).
                Defaults to BUBBLE_TOP (1).

        Returns:
            The created bubble comment Box.
        """
        box = self.add_comment(text, x, y)
        box.extra_attrs["bubble"] = 1
        box.extra_attrs["bubbleside"] = (
            bubbleside if bubbleside is not None else BUBBLE_TOP
        )
        # Adjust sizing for bubble chrome
        box.patching_rect[2] += 17.0
        box.patching_rect[3] = 25.0
        return box

    def add_panel(
        self,
        x: float,
        y: float,
        width: float,
        height: float,
        gradient: bool = True,
    ) -> Box:
        """Add a panel box for visual grouping of objects.

        Panels render in the background layer behind all objects. By default
        they use a gradient fill; pass gradient=False for solid fill.

        Args:
            x: Horizontal position.
            y: Vertical position.
            width: Panel width.
            height: Panel height.
            gradient: If True (default), use gradient bgfillcolor. If False,
                use solid bgcolor.

        Returns:
            The created panel Box (inserted at index 0 for z-order).
        """
        panel = Box.structural(
            "panel", "", 1, 0, [], [x, y, width, height],
            box_id=self._gen_id(),
            background=1,
            ignoreclick=1,
            border=0,
            rounded=7,
            mode=0,
        )

        if gradient:
            panel.extra_attrs["bgfillcolor"] = {
                "type": "gradient",
                "color1": list(AESTHETIC_PALETTE["panel_fill"]),
                "color2": list(AESTHETIC_PALETTE["panel_gradient_end"]),
                "color": list(AESTHETIC_PALETTE["panel_fill"]),
                "angle": 270.0,
                "proportion": 0.39,
                "autogradient": 0,
            }
        else:
            panel.extra_attrs["bgcolor"] = list(AESTHETIC_PALETTE["panel_fill"])

        # Insert at index 0 (visually front, but background=1 forces behind)
        self.boxes.insert(0, panel)
        return panel

    def add_step_marker(self, number: int, x: float, y: float) -> Box:
        """Add a numbered step marker circle.

        Creates a textbutton styled as a small amber circle with a white
        bold number. Renders in the background layer.

        Args:
            number: Step number to display.
            x: Horizontal position.
            y: Vertical position.

        Returns:
            The created step marker Box (inserted at index 0 for z-order).
        """
        # Text color is DERIVED from the chip color, not hardcoded. The old
        # hardcoded white scored only 2.23:1 on the amber chip -- well under
        # WCAG AA. The step_marker_text palette entry is retained for
        # back-compat but is no longer what gets written.
        from src.maxpat.aesthetics import best_text_color
        chip = list(AESTHETIC_PALETTE["step_marker_bg"])

        marker = Box.structural(
            "textbutton", "", 1, 3, ["", "", "int"], [x, y, 24.0, 24.0],
            box_id=self._gen_id(),
            font=(FONT_NAME, 11.0),
            background=1,
            ignoreclick=1,
            rounded=60.0,
            text=str(number),
            textcolor=best_text_color([chip]),
            bgcolor=chip,
            fontface=FONTFACE_BOLD,
            parameter_enable=0,
        )

        # Insert at index 0 (visually front, but background=1 forces behind)
        self.boxes.insert(0, marker)
        return marker

    def add_overlay_readout(
        self,
        target: "Box",
        *,
        format: str = "%.2f",
        type: str = "flonum",
        editable: bool = False,
        offset_x: float = 0.0,
        offset_y: float = 0.0,
    ) -> "Box":
        """Create a flonum/comment/number readout overlapping a target control.

        Home of the overlay-readout recipe; CLAUDE.md Rule #6 "Z-Order
        Awareness" points here. Codifies it as ``bring_to_front`` (overlay
        renders on top) plus ``ignoreclick=1`` (clicks pass through to the
        underlying control). The readout copies ``target.patching_rect`` by
        default; ``offset_x``/``offset_y`` fine-tune the position without
        aliasing the target's rect. When the target is in presentation, the
        readout is added to presentation too, at the target's
        ``presentation_rect`` plus the same offsets (Rule #9; Q27 / F7); a
        target outside presentation leaves the readout out of it. A
        ``type='comment'`` readout starts with empty text (fill it with
        ``set ...``), never the literal word "comment".

        Z-order model: in ``.maxpat`` files objects earlier in the ``boxes``
        array render on top of later ones (index 0 = topmost).

        Manual equivalent (the overlay readout pattern, from gen-eq):

        1. Create the interactive control (e.g., ``dial``).
        2. Create the readout display (e.g., ``flonum``).
        3. Call ``bring_to_front(readout)`` to move it to index 0 (renders on
           top of the dial).
        4. Set ``ignoreclick=1`` on the readout so the dial remains
           interactive (omit for editable readouts).
        5. Position the readout overlapping the dial (same or overlapping
           coordinates).

        Background elements (panels, step markers): ``add_panel()`` /
        ``add_step_marker()`` set ``background=1`` to force them behind all
        objects regardless of array position. For explicit control use
        ``bring_to_front(box)`` (index 0 = top), ``send_to_back(box)`` (end =
        bottom) or ``set_z_index(box, index)``.

        Args:
            target: The Box to overlay (typically a dial or numeric control).
            format: printf-style format template (D-03). Translates ``"%.Nf"``
                to the readout's ``numdecimalplaces`` int attribute (the actual
                MAX attribute on flonum/number — flonum has no printf-string
                ``format`` attribute; number's ``format`` is an int enum, not
                a template). For ``type='flonum'`` and ``type='number'``, only
                pure ``"%.Nf"`` templates are accepted; unit suffixes
                (``'%.1f Hz'``) or literal-text prefixes raise ValueError —
                route those through ``type='comment'`` plus a prepend chain
                (e.g. ``message 'set %.1f Hz' -> comment``). For
                ``type='comment'``, the format kwarg is informational only;
                comments display literal text and have no native formatting
                attribute (the kwarg is NOT stored on extra_attrs).
            type: One of ``'flonum'`` (default, D-04), ``'comment'``,
                ``'number'``.
            editable: If True, ``ignoreclick`` is NOT set (caller wants the
                readout itself editable). Default False bakes ``ignoreclick=1``
                so clicks pass through to the underlying control.
            offset_x: Horizontal offset relative to target's x (D-05).
            offset_y: Vertical offset relative to target's y.

        Returns:
            The newly-created readout Box, already z-ordered to index 0
            (renders on top of target via ``bring_to_front``).

        Raises:
            ValueError: If ``type`` is not one of the allowed maxclasses, or
                if ``type`` is ``'flonum'``/``'number'`` and ``format`` is not
                a pure ``"%.Nf"`` template.
        """
        if type not in ("flonum", "comment", "number"):
            raise ValueError(
                f"type must be 'flonum'|'comment'|'number', got {type!r}"
            )
        rect = list(target.patching_rect)  # COPY — Pitfall 1: don't alias
        x = rect[0] + offset_x
        y = rect[1] + offset_y
        readout = self.add_box(type, x=x, y=y, skip_overlap_check=True)
        # Re-set patching_rect so width/height match target exactly (D-05)
        readout.patching_rect = [x, y, rect[2], rect[3]]
        # Translate printf-style `format=` kwarg to the actual MAX attribute.
        # flonum/number have no `format` printf attribute (flonum has none;
        # number's `format` is an int enum, not a template). The only decimals
        # control on both is `numdecimalplaces` (int). Strict pure-`%.Nf` only —
        # unit suffixes ("%.1f Hz") and prefixes have no flonum/number rendering
        # path and must route through type='comment' + a prepend chain.
        # Reconciles CONTEXT.md D-03 against the DB (CR-01 from 31-VERIFICATION).
        import re as _re_overlay
        _PURE_PCT_NF = _re_overlay.compile(r"^%\.(\d+)f$")
        if type in ("flonum", "number"):
            m = _PURE_PCT_NF.match(format)
            if m is None:
                raise ValueError(
                    f"format={format!r} is not a pure '%.Nf' template; flonum/number "
                    f"only support decimal-place control via numdecimalplaces. For "
                    f"unit suffixes or literal text, use type='comment' with a "
                    f"separate prepend chain (e.g. message 'set %.1f Hz' -> comment)."
                )
            readout.extra_attrs["numdecimalplaces"] = int(m.group(1))
        # type='comment' has no native format/decimals attribute; the format kwarg
        # is informational only (callers wanting unit display wire prepend->comment).
        # Intentionally NOT written to extra_attrs (CR-01: don't ship dead keys).
        if type == "comment":
            readout.text = ""
        if not editable:
            readout.extra_attrs["ignoreclick"] = 1
        # Presentation parity (Rule #9; Q27 / F7): copy the target's
        # presentation rect, offset like the patching rect.
        prect = target.presentation_rect
        if (
            target.presentation
            and isinstance(prect, (list, tuple))
            and len(prect) >= 4
            and all(isinstance(v, (int, float)) and not isinstance(v, bool)
                    for v in prect[:4])
        ):
            self.add_to_presentation(
                readout,
                [prect[0] + offset_x, prect[1] + offset_y, prect[2], prect[3]],
            )
        # Unconditional bring_to_front per D-06 (always renders on top)
        self.bring_to_front(readout)
        return readout

    def add_labeled_param_bank(
        self,
        params: list[tuple[str, float, float]],
        x: float,
        y: float,
        *,
        label_side: str = "left",
        extra_attrs: dict | None = None,
    ) -> tuple["Box", list["Box"]]:
        """Build a multislider parameter bank with aligned comment labels.

        Home of the multislider labeled-parameter-bank recipe; CLAUDE.md Rule #4
        "Multislider as Labeled Parameter Bank" points here. Codifies it as
        size*24 px height, contdata=1, setstyle=1, orientation=0 (horizontal
        bars stacked vertically), setminmax derived as ``[min(mins),
        max(maxes)]`` envelope across all params (D-10). Returns
        ``(multislider, [comment, ...])``; caller wires ``fetch $1`` -> the
        multislider input themselves and reads values from the multislider's
        RIGHT outlet (outlet 1) per D-09 and shared-capabilities.md
        "Reading values by index" (``fetch`` not ``fetchindex``;
        outlet 1 not 0; do NOT insert ``split`` between multislider and
        consumer).

        Recipe (manual equivalent), when multislider bars represent labeled
        parameters with comment labels alongside:

        - Set ``orientation: 0`` (horizontal bars stacked vertically)
          explicitly.
        - Bar-to-label alignment formula: multislider height =
          ``size * label_spacing`` where label_spacing matches comment
          spacing (typically 24px for fontsize=10 labels).
        - Comment labels start at the same Y as the multislider top, spaced
          at ``ms_height / ms_size`` intervals.
        - For fontsize=10 labels: use height=18, spacing=24px, so
          multislider height = size * 24.
        - Always set ``contdata: 1`` for real-time feedback during drag.
        - Always set ``setstyle: 1`` for bar display.
        - When adding utility/routing objects (prepend chains, init messages,
          js engines), encapsulate them in named subpatchers (``p drift``,
          ``p settings``, etc.) to keep top-level patch clean.
        - Example extra_attrs for a 14-param bank:
          ``{"size": 14, "setminmax": [0.0, 1.0], "orientation": 0,
          "contdata": 1, "setstyle": 1}``

        Reading values by index: send ``fetch $1`` (NOT ``fetchindex`` -- it
        does not exist). The fetched value emerges from the **right** outlet
        (outlet 1); outlet 0 is for direct-edit/drag interaction. Don't insert
        ``split`` between multislider and the consumer -- multislider already
        emits the correct values, and ``split`` filters out valid step data.

        Note on per-bar ranges: multislider supports a single ``setminmax``
        for all bars; per-bar ranges require runtime config messages, not
        attrs (deferred per CONTEXT.md). Use this builder for params with
        similar ranges; widely-varying ranges yield an envelope that doesn't
        enforce per-bar limits.

        Args:
            params: List of ``(name, min, max)`` tuples (D-07). One bar per
                tuple. Drives label text, ``setminmax`` envelope, and bar count.
            x: Multislider x position.
            y: Multislider y position. Labels start at the same y.
            label_side: Only ``'left'`` is supported in Phase 31 (D-08).
                Raises ValueError on any other value.
            extra_attrs: Optional dict deep-merged over baked defaults (D-10).
                Caller values win on collisions.

        Returns:
            ``(multislider_box, [comment_box, ...])`` where comments are in
            the same order as ``params``.

        Raises:
            ValueError: If params is empty, or label_side is not 'left'.
        """
        if not params:
            raise ValueError("params must not be empty")
        if label_side != "left":
            raise ValueError(
                f"only label_side='left' is supported in Phase 31, got "
                f"{label_side!r}"
            )

        size = len(params)
        height = size * 24.0
        mins = [p[1] for p in params]
        maxes = [p[2] for p in params]
        setminmax = [min(mins), max(maxes)]
        ms_width = 200.0  # sensible default; CLAUDE.md doesn't lock width

        ms = self.add_box("multislider", x=x, y=y, skip_overlap_check=True)
        ms.patching_rect = [x, y, ms_width, height]

        # Bake defaults (D-10), then deep-merge caller's extra_attrs over
        # them. Caller wins on collisions per the locked semantic.
        baked = {
            "size": size,
            "setminmax": setminmax,
            "orientation": 0,
            "contdata": 1,
            "setstyle": 1,
        }
        if extra_attrs:
            baked.update(extra_attrs)  # caller wins on collisions
        ms.extra_attrs.update(baked)

        # Place labels left of bars; y formula matches CLAUDE.md fontsize=10
        # spacing (D-08): each label at ms.y + i * 24.
        label_gap = 8.0
        labels: list[Box] = []
        for i, (name, _mn, _mx) in enumerate(params):
            # Approximate label width so labels sit left of the multislider.
            approx_w = len(name) * 6.0 + 14.0
            lx = x - approx_w - label_gap
            ly = y + i * 24.0
            c = self.add_comment(name, x=lx, y=ly)
            # Tighten height to 18px (CLAUDE.md fontsize=10 spec).
            c.patching_rect[3] = 18.0
            c.fontsize = 10.0
            labels.append(c)

        return ms, labels

    def add_message(self, text: str, x: float = 0.0, y: float = 0.0) -> Box:
        """Add a message box to the patcher.

        Args:
            text: Message content.
            x: Horizontal position.
            y: Vertical position.

        Returns:
            The created message Box.
        """
        box_id = self._gen_id()
        box = Box(name="message", args=[], box_id=box_id, db=self.db, x=x, y=y,
                  allowed_packages=self.allowed_packages)
        # Override text: message's text is the content, not "message"
        box.text = text
        # Recalculate size based on actual text
        from src.maxpat.sizing import calculate_box_size
        w, h = calculate_box_size(text, "message")
        box.patching_rect = [x, y, w, h]
        self.boxes.append(box)
        return box

    def add_connection(
        self,
        src_box: Box,
        src_outlet: int,
        dst_box: Box,
        dst_inlet: int,
        order: int = 0,
        hidden: bool = False,
        midpoints: list[float] | None = None,
    ) -> Patchline:
        """Add a connection (patchline) between two boxes.

        Args:
            src_box: Source box.
            src_outlet: Source outlet index.
            dst_box: Destination box.
            dst_inlet: Destination inlet index.
            order: Execution order (default 0).
            hidden: Whether the connection is hidden.
            midpoints: Optional cable routing waypoints as flat [x1, y1, x2, y2, ...]
                      list. Creates segmented cables with right-angle bends.

        Returns:
            The created Patchline, or the existing Patchline if a duplicate.
        """
        # Bounds checking
        if src_outlet < 0 or src_outlet >= src_box.numoutlets:
            valid_range = (
                f"0..{src_box.numoutlets - 1}"
                if src_box.numoutlets > 0
                else "none (0 outlets)"
            )
            raise ValueError(
                f"Outlet index {src_outlet} out of range for box {src_box.id} "
                f"({src_box.text or src_box.name}) which has "
                f"{src_box.numoutlets} outlet(s) (valid: {valid_range})"
            )
        if dst_inlet < 0 or dst_inlet >= dst_box.numinlets:
            valid_range = (
                f"0..{dst_box.numinlets - 1}"
                if dst_box.numinlets > 0
                else "none (0 inlets)"
            )
            raise ValueError(
                f"Inlet index {dst_inlet} out of range for box {dst_box.id} "
                f"({dst_box.text or dst_box.name}) which has "
                f"{dst_box.numinlets} inlet(s) (valid: {valid_range})"
            )

        # Duplicate prevention
        for pl in self.lines:
            if (pl.source_id == src_box.id
                    and pl.source_outlet == src_outlet
                    and pl.dest_id == dst_box.id
                    and pl.dest_inlet == dst_inlet):
                return pl

        pl = Patchline(
            source_id=src_box.id,
            source_outlet=src_outlet,
            dest_id=dst_box.id,
            dest_inlet=dst_inlet,
            order=order,
            hidden=hidden,
            midpoints=midpoints,
        )
        self.lines.append(pl)
        return pl

    def add_subpatcher(
        self,
        name: str,
        inlets: int = 1,
        outlets: int = 1,
        x: float = 0.0,
        y: float = 0.0,
        inlet_comments: list[str] | None = None,
        outlet_comments: list[str] | None = None,
    ) -> tuple[Box, Patcher]:
        """Add a subpatcher (p name) with embedded patcher.

        Creates a box with maxclass "newobj", text "p {name}", and an inner
        Patcher with inlet/outlet objects. The parent box's numinlets/numoutlets
        are set to match the number of inlet/outlet objects inside.

        Args:
            name: Subpatcher name (appears as "p {name}").
            inlets: Number of inlet objects to create inside.
            outlets: Number of outlet objects to create inside.
            x: Horizontal position.
            y: Vertical position.
            inlet_comments: Optional list of descriptive comments for each inlet.
                If provided, each string maps to the corresponding inlet's
                "comment" attribute (mouseover tooltip in MAX). If the list is
                shorter than inlets, extra inlets get empty string.
            outlet_comments: Optional list of descriptive comments for each outlet.
                Same behavior as inlet_comments but for outlet objects.

        Returns:
            (parent_box, inner_patcher) tuple.
        """
        box_id = self._gen_id()

        # Create inner patcher
        from src.maxpat.patcher import Patcher
        inner = Patcher(db=self.db, is_subpatcher=True,
                        allowed_packages=self.allowed_packages,
                        domain_context=getattr(self, "domain_context", "max"))

        # Add inlet objects inside the subpatcher
        inlet_spacing = 80.0
        for i in range(inlets):
            inlet_box = inner.add_box("inlet", x=50.0 + i * inlet_spacing, y=30.0, skip_overlap_check=True)
            comment = ""
            if inlet_comments and i < len(inlet_comments):
                comment = inlet_comments[i]
            inlet_box.extra_attrs["comment"] = comment

        # Add outlet objects inside the subpatcher
        for i in range(outlets):
            outlet_box = inner.add_box("outlet", x=50.0 + i * inlet_spacing, y=250.0, skip_overlap_check=True)
            comment = ""
            if outlet_comments and i < len(outlet_comments):
                comment = outlet_comments[i]
            outlet_box.extra_attrs["comment"] = comment

        # Create the parent box manually (subpatcher uses "newobj" maxclass)
        text = f"p {name}"
        from src.maxpat.sizing import calculate_box_size
        w, h = calculate_box_size(text, "newobj")

        # Outlet types: all control by default for subpatchers
        parent_box = Box.structural(
            "newobj", text, inlets, outlets, [""] * outlets, [x, y, w, h],
            box_id=box_id,
            name="patcher",
            args=[name],
            inner=inner,
            saved_attrs={
                "description": "",
                "digest": "",
                "globalpatchername": "",
                "tags": "",
            },
        )

        # Back-refs for the parent port sync, set after the inner ports
        # exist so building them does not resync (Q28 / B7).
        inner._parent_box = parent_box
        inner._parent_patcher = self

        self.boxes.append(parent_box)
        return (parent_box, inner)

    def add_bpatcher(
        self,
        filename: str | None = None,
        embedded: bool = False,
        args: list | None = None,
        x: float = 0.0,
        y: float = 0.0,
        width: float | None = None,
        height: float | None = None,
        numinlets: int = 1,
        numoutlets: int = 1,
        object_name: str | None = None,
    ) -> Box | tuple[Box, Patcher]:
        """Add a bpatcher box (file reference or embedded).

        Args:
            filename: Path to external .maxpat file (for file reference).
            embedded: If True, create embedded bpatcher with inner Patcher.
            args: bpatcher arguments. Numeric strings (``"0"``, ``"-3"``,
                ``"1.5"``, ``".5"``; no exponent forms) are stored as JSON
                numbers (int without a ``.``, else float): a string
                substitutes into ``#N`` as a quoted symbol and ``-~ #2``
                fails with "bad arguments" (CLAUDE.md "Bpatcher and
                Abstraction Arguments"; fix-plan Q23 D11). The caller's list
                is never mutated.
            x: Horizontal position.
            y: Vertical position.
            width: bpatcher display width (None = auto from DB or 200).
            height: bpatcher display height (None = auto from DB or 100).
            numinlets: Number of inlets.
            numoutlets: Number of outlets.
            object_name: Package object name (e.g. 'bp.Oscillator') for
                DB-driven dimension and I/O lookup.

        Returns:
            Box if file reference, (Box, Patcher) tuple if embedded.
        """
        args = [_bpatcher_arg(a) for a in (args or [])]

        # DB-driven dimension lookup when object_name provided
        if object_name:
            from src.maxpat.sizing import get_bpatcher_dims
            dims = get_bpatcher_dims(object_name)
            if dims:
                if width is None:
                    width = dims[0]
                if height is None:
                    height = dims[1]
            # Auto-set I/O from DB when caller used defaults
            if self.db and numinlets == 1 and numoutlets == 1:
                obj_info = self.db.lookup(object_name)
                if obj_info:
                    if "inlets" in obj_info:
                        numinlets = len(obj_info["inlets"])
                    if "outlets" in obj_info:
                        numoutlets = len(obj_info["outlets"])

        # Fallback to standard defaults
        if width is None:
            width = 200.0
        if height is None:
            height = 100.0

        box_id = self._gen_id()

        # bpatcher-specific attributes (from research Pattern 5)
        bpatcher_attrs: dict[str, Any] = {
            "args": args,
            "bgmode": 0,
            "border": 0,
            "clickthrough": 0,
            "enablehscroll": 0,
            "enablevscroll": 0,
            "lockeddragscroll": 0,
            "offset": [0.0, 0.0],
            "viewvisibility": 1,
        }

        if filename is not None:
            bpatcher_attrs["name"] = filename

        # One args list, shared with bpatcher_attrs["args"]
        bpatch_box = Box.structural(
            "bpatcher", "", numinlets, numoutlets, [""] * numoutlets,
            [x, y, width, height],
            box_id=box_id,
            args=args,
            bpatcher_attrs=bpatcher_attrs,
        )

        if embedded:
            from src.maxpat.patcher import Patcher
            inner = Patcher(db=self.db, is_subpatcher=True,
                            allowed_packages=self.allowed_packages,
                            domain_context=getattr(self, "domain_context", "max"))
            inner.props["rect"] = [0.0, 0.0, width, height]
            bpatch_box._inner_patcher = inner
            # Back-refs for the parent port sync (Q28 / B7)
            inner._parent_box = bpatch_box
            inner._parent_patcher = self
            self.boxes.append(bpatch_box)
            return (bpatch_box, inner)
        else:
            self.boxes.append(bpatch_box)
            return bpatch_box

    def add_gen(
        self,
        code: str,
        num_inputs: int | None = None,
        num_outputs: int | None = None,
        x: float = 0.0,
        y: float = 0.0,
    ) -> tuple[Box, "Patcher"]:
        """Add a gen~ object with embedded codebox.

        Creates a parent gen~ box with an inner Gen patcher containing
        in objects, a codebox with GenExpr code, out objects, and
        patchlines connecting in -> codebox -> out.

        Args:
            code: GenExpr source code for the codebox.
            num_inputs: Number of signal inputs (`in` objects). Auto-detected
                from code if None. The gen~ box always has at least 1 inlet,
                so with 0 inputs it still accepts `param` messages.
            num_outputs: Number of signal outputs. Auto-detected from code if None.
            x: Horizontal position of the gen~ box.
            y: Vertical position of the gen~ box.

        Returns:
            (parent_box, inner_patcher) tuple.
        """
        from src.maxpat.codegen import parse_genexpr_io, reorder_genexpr_declarations

        # Auto-fix ordering: functions, then Param/History/Delay/Buffer/Data,
        # then statements (Max user guide; gen.maxhelp). A Param is never
        # hoisted above a function definition (quick 261022-ud6 WP4, WR-03);
        # code already in that order is left byte-identical.
        code = reorder_genexpr_declarations(code)

        # Auto-detect I/O from code if not specified
        if num_inputs is None or num_outputs is None:
            detected_in, detected_out = parse_genexpr_io(code)
            if num_inputs is None:
                num_inputs = detected_in
            if num_outputs is None:
                num_outputs = detected_out

        # Validate GenExpr as diagnostic (warn but don't block)
        from src.maxpat.code_validation import validate_genexpr
        for result in validate_genexpr(code, db=self.db):
            if result.level == "error":
                import warnings
                warnings.warn(f"GenExpr: {result.message}", stacklevel=2)

        box_id = self._gen_id()

        # Create inner Gen patcher
        from src.maxpat.patcher import Patcher
        inner = Patcher(db=self.db, is_subpatcher=True,
                        allowed_packages=self.allowed_packages,
                        domain_context="gen")
        inner.props["bgcolor"] = list(GEN_PATCHER_BGCOLOR)
        inner.props["rect"] = [100.0, 100.0, 600.0, 450.0]

        # Add in objects inside the inner patcher
        in_boxes: list[Box] = []
        for i in range(num_inputs):
            in_box = Box.structural(
                "newobj", f"in {i + 1}", 0, 1, [""],
                [50.0 + i * 80.0, 20.0, 30.0, 22.0],
                box_id=inner._gen_id(),
                args=[str(i + 1)],
            )
            inner.boxes.append(in_box)
            in_boxes.append(in_box)

        # Create codebox (structural, not a DB object)
        codebox = Box.structural(
            "codebox", "", num_inputs, num_outputs, [""] * num_outputs,
            [50.0, 80.0, 400.0, 200.0],
            box_id=inner._gen_id(),
            code=code,
            fontname=FONT_NAME,
            fontsize=FONT_SIZE,
        )
        inner.boxes.append(codebox)

        # Add out objects inside the inner patcher
        out_boxes: list[Box] = []
        for i in range(num_outputs):
            out_box = Box.structural(
                "newobj", f"out {i + 1}", 1, 0, [],
                [50.0 + i * 80.0, 320.0, 30.0, 22.0],
                box_id=inner._gen_id(),
                args=[str(i + 1)],
            )
            inner.boxes.append(out_box)
            out_boxes.append(out_box)

        # Add patchlines: in -> codebox
        for i, in_box in enumerate(in_boxes):
            inner.add_connection(in_box, 0, codebox, i)

        # Add patchlines: codebox -> out
        for i, out_box in enumerate(out_boxes):
            inner.add_connection(codebox, i, out_box, 0)

        # Create the parent gen~ box (uses maxclass="newobj" like all non-UI objects)
        w, h = calculate_box_size("gen~", "newobj")

        # MAX always gives gen~ at least one inlet: it carries `param`
        # messages even when the gen patcher has no `in` objects (D3).
        parent_box = Box.structural(
            "newobj", "gen~", max(1, num_inputs), num_outputs,
            ["signal"] * num_outputs, [x, y, w, h],
            box_id=box_id,
            inner=inner,
        )

        self.boxes.append(parent_box)
        return (parent_box, inner)

    def add_m4l_device(
        self,
        kind: str,
        params: list[dict] | None = None,
        *,
        audio_source: Any = None,
        midi_source: Any = None,
        midi_in: bool = True,
        init_chain: bool = True,
        banks: bool = True,
        presentation: bool = True,
        modmode: Any = None,
        info_text: bool | None = None,
    ) -> Any:
        """Build a Max for Live device skeleton of one of three kinds. EXPERIMENTAL.

        EXPERIMENTAL -- not yet confirmed in Live (the combined Q15/Q40 Live
        check is pending; quick 261022-pqu, fix-plan Q40). Thin delegate to
        :func:`src.maxpat.m4l_device.build_m4l_device`.

        Wiring per kind is copied from Live 12's own "Max Devices" templates;
        plugin~ and plugout~ are always bare (stereo, no channel argument):

        - ``"audio_effect"``: plugin~ 0 -> plugout~ 0 and plugin~ 1 ->
          plugout~ 1 (pass-through).
        - ``"midi_effect"``: midiin 0 -> midiout 0 (pass-through; no plugin~).
        - ``"instrument"``: a midiin (omit with ``midi_in=False``) and an
          unwired plugout~.

        ``audio_source=(box, outlet)`` (instrument / audio_effect) replaces
        the pass-through and feeds plugout~ inlets 0 AND 1 (a mono source
        on both channels, the Q15 stereo form); ``((L, o), (R, o))`` feeds
        L -> 0 and R -> 1. ``midi_source=(box, outlet)`` (midi_effect)
        replaces midiin -> midiout. With a source, an audio_effect /
        midi_effect reuses the chain's existing plugin~ / midiin (build the
        chain from it first; none -> ValueError) rather than adding a second,
        unwired one. Sources, and dial varnames against the patcher's
        existing varnames, are validated before any box is created. With
        ``presentation=True`` the dial grid starts right of any existing
        presentation UI and ``devicewidth`` only grows; Push banks cover
        every parameter already in the patcher plus the new ones.

        Existing device content is reused, never doubled (review BL-01,
        quick 261022-ud6), so a second call extends the same device:

        - The kind's top-scope ``plugin~`` / ``plugout~`` / ``midiin`` /
          ``midiout`` and ``live.thisdevice`` are reused when present; two
          of one name raise ValueError (ambiguous).
        - The pass-through only feeds output inlets nothing feeds yet, so a
          ``plugin~ -> fx -> plugout~`` chain never gets a dry path (no
          +6 dB). A source into an inlet another source already feeds
          raises ValueError; the same cord again is a no-op.
        - A reused ``live.thisdevice`` keeps one cord from outlet 0: an
          all-bang ``t b ...`` it feeds is extended for the new dials,
          other cords move onto a new ``t b ...``.
        - Refusal (review WR-01): a param name equal to an existing
          ``parameter_longname``, or an explicit short name equal to an
          existing one (or to another explicit one), raises ValueError; auto
          short names avoid existing ones (``Amount2``).
        - New boxes that would overlap a pre-existing box shift right
          together, as one block.

        Info text (review IN-06): new dials get ``annotation`` /
        ``annotation_name`` (Live's Info View) when ``info_text`` is True;
        ``info_text=None`` follows ``presentation``.

        Each param dict ``{name, min, max, default, unit?, type?, steps?,
        short_name?, varname?, param_connect?, modmode?}`` becomes one
        ``live.dial`` with ``parameter_enable: 1`` and a
        ``saved_attribute_attributes.valueof`` block. Explicit keys always
        win; otherwise type/unit are inferred from whole name tokens and the
        range (ms -> Time, hz -> Hertz, db -> deciBel, a 0-1 float range ->
        Float, attack/decay/... -> Time, freq/cutoff -> Hertz, gain/volume/
        level below 0 -> deciBel, pan -> Pan, transpose/semitones ->
        Semitones, all-int -> Int unit; Int type only for an int span <=
        255). Short names are abbreviated to 8 characters and made unique
        ("Amount", "Amount2"). ``param_connect`` binds a dial to a gen~
        Param (``"<gen varname>::<Param>"``).

        With ``init_chain=True`` a ``live.thisdevice`` is added after the
        dials; its outlet 0 (device initialized, preset loaded, device
        saved) bangs every dial that has no ``param_connect`` -- directly
        for one, through ``t b b ...`` for two or more -- so the caller's
        DSP receives the restored values. gen~-bound dials get no cord.

        With ``banks=True`` (and at least one param)
        ``patcher.parameters.parameterbanks`` is planned by
        ``m4l_polish.plan_push_banks`` (the planner polish uses), and one
        newobj ``live.banks`` is added or reused. User-defined banks already
        in the patcher are kept with a UserWarning.

        With ``presentation=True`` every dial goes into a presentation grid
        inside Live's 169 px device height and the patcher gets
        ``openinpresentation 1``, ``devicewidth``, ``openrect`` and
        ``latency 0``.

        Args:
            kind: "instrument", "audio_effect" or "midi_effect".
            params: Parameter spec dicts (see above); None for none.
            audio_source: ``(Box, outlet)`` or a ``((Box, o), (Box, o))`` pair.
            midi_source: ``(Box, outlet)`` feeding midiout (midi_effect only).
            midi_in: Add a midiin to an instrument (Live's template has one).
            init_chain: Add the live.thisdevice init chain.
            banks: Write Push parameterbanks and a live.banks box.
            presentation: Lay the dials out in presentation (Rule #9).
            modmode: Default ``parameter_modmode`` for specs without one
                (None = ``ModMode.NONE``, as kicksynth-m4l used).
            info_text: Write dial info text; None (default) = ``presentation``.

        Returns:
            An :class:`src.maxpat.m4l_device.M4LDevice` naming the boxes.

        Raises:
            ValueError: unknown kind, a bad source, an invalid param spec
                (see ``resolve_param_specs``), a param / short name already
                taken in the patcher, or two top-scope boxes of one device
                I/O name. Nothing is created.
        """
        from src.maxpat.m4l_constants import ModMode
        from src.maxpat.m4l_device import build_m4l_device

        return build_m4l_device(
            self,
            kind,
            params,
            audio_source=audio_source,
            midi_source=midi_source,
            midi_in=midi_in,
            init_chain=init_chain,
            banks=banks,
            presentation=presentation,
            modmode=ModMode.NONE if modmode is None else modmode,
            info_text=info_text,
        )

    def add_m4l_gen_synth(
        self,
        params: list[tuple[str, float, float]],
        *,
        gen_varname: str = "synth",
        gen_code: str | None = None,
    ) -> tuple["Box", list["Box"], "Box"]:
        """Build a Live-ready M4L gen synth skeleton (built on add_m4l_device).

        Since Q40 (quick 261022-pqu) this is a variant of
        :meth:`add_m4l_device`: it adds the gen~, then calls
        ``add_m4l_device("instrument", ..., audio_source=(gen_obj, 0),
        midi_in=False, init_chain=False, banks=False, presentation=False)``
        with fully explicit param specs, so its output is byte-identical to
        the pre-Q40 builder (golden test). EXPERIMENTAL in Live like
        add_m4l_device (the combined Q15/Q40 Live check is pending).

        D-15 minimum-viable skeleton: ``gen~`` + ``live.dial`` row +
        ``plugout~``. Each ``live.dial`` is bound to a gen~ ``Param`` via:
          - top-level ``param_connect: "<gen_varname>::<param_name>"``
          - top-level ``varname: <param_name>``
          - ``parameter_enable: 1``
          - full ``saved_attribute_attributes.valueof`` block
            (``parameter_initial`` as a 1-element list, ``parameter_longname``,
            ``parameter_shortname``, ``parameter_mmin``, ``parameter_mmax``,
            ``parameter_modmode = ABSOLUTE``, ``parameter_type = FLOAT``,
            ``parameter_unitstyle = FLOAT``, ``parameter_initial_enable``).

        With the corrected enums these serialize as ``parameter_type`` 0,
        ``parameter_modmode`` 4 and ``parameter_unitstyle`` 1
        (parameters.maxref.xml order; review D1).

        ``gen~`` gets a stable ``varname`` matching the prefix in
        ``param_connect``. ``plugout~`` is bare (no channel argument) and
        gen~ outlet 0 feeds BOTH of its inlets, so the device is stereo.
        There is NO ``gain~``/``live.gain~``/``ezdac~``
        between ``gen~`` and ``plugout~`` (shared-capabilities.md
        "Max for Live Device Rules" -- Ableton's channel strip handles
        volume). Caller fills in DSP via ``gen_code`` or by editing the
        gen~ inner patcher returned via ``gen_obj``.

        The skeleton is polish-pipeline compatible: running
        ``ensure_parameter_enable`` / ``polish_m4l_device`` from
        ``m4l_polish.py`` over ``patcher.to_dict()`` is a no-op for the
        ``parameter_enable`` field on every dial produced here.

        T-31-04 mitigation: ``param_connect`` is constructed as a single
        f-string ``f"{gen_varname}::{name}"`` so the unit test
        ``test_param_connect_prefix_matches_gen_varname`` catches mutations
        before they silently break Live binding.

        Args:
            params: List of ``(name, min, max)`` tuples. One ``live.dial`` is
                emitted per param. ``name`` MUST be a valid MAX symbol (used
                as both ``varname`` and Param suffix; no spaces, leading
                letter).
            gen_varname: gen~'s ``varname`` (default ``'synth'``). Must be
                unique within a patcher (Pitfall 7); caller must pass distinct
                values when adding multiple skeletons to the same patcher.
            gen_code: Optional GenExpr body. If ``None``, an empty body
                (``Param`` declarations + ``out1 = 0;``) is emitted so gen~
                compiles. Caller is expected to replace this with real DSP.

        Returns:
            ``(gen_obj, [live_dial, ...], plugout_obj)``.

        Raises:
            ValueError: If ``params`` is empty; and (since Q40, from
                add_m4l_device's spec validation) for duplicate names,
                ``min >= max`` or non-numeric bounds.
        """
        from src.maxpat.m4l_constants import ParamType, UnitStyle, ModMode

        if not params:
            raise ValueError("params must not be empty")

        # Fully explicit specs: inference, short-name abbreviation and the
        # ModMode default never run, so the serialized output is the
        # pre-Q40 one (tests/test_m4l_gen_synth_golden.py). T-31-04: the
        # binding string stays this single f-string.
        specs = [
            {
                "name": name,
                "min": mn,
                "max": mx,
                "default": (mn + mx) / 2.0,
                "varname": name,
                "short_name": name,
                "type": ParamType.FLOAT,
                "unit": UnitStyle.FLOAT,
                "modmode": ModMode.ABSOLUTE,
                "param_connect": f"{gen_varname}::{name}",
            }
            for name, mn, mx in params
        ]
        # Validate before the first box exists, so a bad spec leaves the
        # patcher untouched (add_m4l_device validates again; pure).
        from src.maxpat.m4l_device import check_varname_collisions, resolve_param_specs

        resolve_param_specs(specs)
        # gen~ is created next with gen_varname; a param of the same name
        # would duplicate it and make param_connect ambiguous (review WR-02).
        if gen_varname in {name for name, _mn, _mx in params}:
            raise ValueError(
                f"param name {gen_varname!r} equals gen_varname; pass a distinct gen_varname"
            )
        check_varname_collisions(self, [gen_varname] + [s["varname"] for s in specs])

        # Default empty-but-compilable body so gen~ has Params declared.
        if gen_code is None:
            param_decls = "\n".join(
                f"Param {n}({(mn + mx) / 2.0}, min={mn}, max={mx});"
                for n, mn, mx in params
            )
            gen_code = param_decls + "\nout1 = 0;"

        # Reuse add_gen -- it handles I/O detection, declaration reordering,
        # validate_genexpr diagnostics, and inner patcher construction.
        gen_obj, _gen_inner = self.add_gen(
            gen_code, num_inputs=0, num_outputs=1, x=200.0, y=200.0,
        )
        gen_obj.extra_attrs["varname"] = gen_varname

        # Bare plugout~ (stereo pair) with the mono gen~ outlet 0 on BOTH
        # inlets (review D3); NO gain~/live.gain~/ezdac~ (D-15). The legacy
        # skeleton has no midiin, init chain, banks or presentation.
        dev = self.add_m4l_device(
            "instrument",
            specs,
            audio_source=(gen_obj, 0),
            midi_in=False,
            init_chain=False,
            banks=False,
            presentation=False,
        )
        return gen_obj, dev.dials, dev.plugout

    def add_js(
        self,
        filename: str,
        code: str | None = None,
        num_inlets: int = 1,
        num_outlets: int = 1,
        x: float = 0.0,
        y: float = 0.0,
    ) -> tuple[Box, str | None]:
        """Add a js object box (Legacy Engine, ES5 JavaScript).

        In .maxpat files, js uses maxclass="newobj" with text="js filename.js"
        (not maxclass="js"). Built with Box.structural to bypass DB lookup and
        ensure the correct maxclass.

        Args:
            filename: JavaScript file name (e.g., "myobject.js").
            code: Optional js object JavaScript code string. Caller is responsible
                for writing it to disk.
            num_inlets: Number of inlets.
            num_outlets: Number of outlets.
            x: Horizontal position.
            y: Vertical position.

        Returns:
            (box, code) tuple. code is None if not provided.
        """
        box_id = self._gen_id()
        text = f"js {filename}"

        w, h = calculate_box_size(text, "newobj")
        box = Box.structural(
            "newobj", text, num_inlets, num_outlets, [""] * num_outlets,
            [x, y, w, h],
            box_id=box_id,
            args=[filename],
        )

        self.boxes.append(box)
        return (box, code)
