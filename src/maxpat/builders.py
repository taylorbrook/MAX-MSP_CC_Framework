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
from src.maxpat.sizing import calculate_box_size
from src.maxpat.patcher import Box, Patchline


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
            skip_overlap_check: If False (default), automatically nudges the
                box to avoid overlapping pre-existing boxes. Set True when the
                caller handles its own positioning (e.g., replace_box,
                insert_into_connection, add_subpatcher).

        Returns:
            The created Box instance.

        Raises:
            ValueError: If object not found in database (Rule #1).
        """
        box_id = self._gen_id()
        box = Box(name=name, args=args, box_id=box_id, db=self.db, x=x, y=y,
                  allowed_packages=self.allowed_packages)

        if not skip_overlap_check:
            w = box.patching_rect[2]
            h = box.patching_rect[3]
            new_x, new_y = self._find_clear_position(x, y, w, h)
            if new_x != x or new_y != y:
                box.patching_rect[0] = new_x
                box.patching_rect[1] = new_y

        self.boxes.append(box)
        return box

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
        panel = Box.__new__(Box)
        panel.name = "panel"
        panel.args = []
        panel.id = self._gen_id()
        panel.maxclass = "panel"
        panel.text = ""
        panel.numinlets = 1
        panel.numoutlets = 0
        panel.outlettype = []
        panel.patching_rect = [x, y, width, height]
        panel.fontname = FONT_NAME
        panel.fontsize = FONT_SIZE
        panel.presentation = False
        panel.presentation_rect = None
        panel.target_id = None
        panel._inner_patcher = None
        panel._saved_object_attributes = None
        panel._bpatcher_attrs = None
        panel._raw = None

        panel.extra_attrs = {
            "background": 1,
            "ignoreclick": 1,
            "border": 0,
            "rounded": 7,
            "mode": 0,
        }

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
        marker = Box.__new__(Box)
        marker.name = "textbutton"
        marker.args = []
        marker.id = self._gen_id()
        marker.maxclass = "textbutton"
        marker.text = ""
        marker.numinlets = 1
        marker.numoutlets = 3
        marker.outlettype = ["", "", "int"]
        marker.patching_rect = [x, y, 24.0, 24.0]
        marker.fontname = FONT_NAME
        marker.fontsize = 11.0
        marker.presentation = False
        marker.presentation_rect = None
        marker.target_id = None
        marker._inner_patcher = None
        marker._saved_object_attributes = None
        marker._bpatcher_attrs = None
        marker._raw = None

        # Text color is DERIVED from the chip color, not hardcoded. The old
        # hardcoded white scored only 2.23:1 on the amber chip -- well under
        # WCAG AA. The step_marker_text palette entry is retained for
        # back-compat but is no longer what gets written.
        from src.maxpat.aesthetics import best_text_color
        chip = list(AESTHETIC_PALETTE["step_marker_bg"])

        marker.extra_attrs = {
            "background": 1,
            "ignoreclick": 1,
            "rounded": 60.0,
            "text": str(number),
            "textcolor": best_text_color([chip]),
            "bgcolor": chip,
            "fontface": FONTFACE_BOLD,
            "parameter_enable": 0,
        }

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

        Codifies the CLAUDE.md Rule #6 overlay-readout recipe: ``bring_to_front``
        (overlay renders on top) plus ``ignoreclick=1`` (clicks pass through to
        the underlying control). The readout copies ``target.patching_rect`` by
        default; ``offset_x``/``offset_y`` fine-tune the position without
        aliasing the target's rect.

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
        if not editable:
            readout.extra_attrs["ignoreclick"] = 1
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

        Codifies the CLAUDE.md "Multislider as Labeled Parameter Bank" recipe:
        size*24 px height, contdata=1, setstyle=1, orientation=0 (horizontal
        bars stacked vertically), setminmax derived as ``[min(mins),
        max(maxes)]`` envelope across all params (D-10). Returns
        ``(multislider, [comment, ...])``; caller wires ``fetch $1`` -> the
        multislider input themselves and reads values from the multislider's
        RIGHT outlet (outlet 1) per D-09 and memory note
        ``feedback_multislider_fetch.md`` (``fetch`` not ``fetchindex``;
        outlet 1 not 0; do NOT insert ``split`` between multislider and
        consumer).

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
                        allowed_packages=self.allowed_packages)

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

        parent_box = Box.__new__(Box)
        parent_box.name = "patcher"
        parent_box.args = [name]
        parent_box.id = box_id
        parent_box.maxclass = "newobj"
        parent_box.text = text
        parent_box.numinlets = inlets
        parent_box.numoutlets = outlets
        # Outlet types: all control by default for subpatchers
        parent_box.outlettype = [""] * outlets
        parent_box.patching_rect = [x, y, w, h]
        parent_box.fontname = FONT_NAME
        parent_box.fontsize = FONT_SIZE
        parent_box.presentation = False
        parent_box.presentation_rect = None
        parent_box.target_id = None
        parent_box.extra_attrs = {}
        parent_box._inner_patcher = inner
        parent_box._saved_object_attributes = {
            "description": "",
            "digest": "",
            "globalpatchername": "",
            "tags": "",
        }
        parent_box._bpatcher_attrs = None
        parent_box._raw = None

        self.boxes.append(parent_box)
        return (parent_box, inner)

    def add_bpatcher(
        self,
        filename: str | None = None,
        embedded: bool = False,
        args: list[str] | None = None,
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
            args: bpatcher arguments.
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
        if args is None:
            args = []

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

        # Create the bpatcher box manually
        bpatch_box = Box.__new__(Box)
        bpatch_box.name = "bpatcher"
        bpatch_box.args = args
        bpatch_box.id = box_id
        bpatch_box.maxclass = "bpatcher"
        bpatch_box.text = ""
        bpatch_box.numinlets = numinlets
        bpatch_box.numoutlets = numoutlets
        bpatch_box.outlettype = [""] * numoutlets
        bpatch_box.patching_rect = [x, y, width, height]
        bpatch_box.fontname = FONT_NAME
        bpatch_box.fontsize = FONT_SIZE
        bpatch_box.presentation = False
        bpatch_box.presentation_rect = None
        bpatch_box.target_id = None
        bpatch_box.extra_attrs = {}
        bpatch_box._saved_object_attributes = None
        bpatch_box._raw = None

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

        bpatch_box._bpatcher_attrs = bpatcher_attrs

        if embedded:
            from src.maxpat.patcher import Patcher
            inner = Patcher(db=self.db, is_subpatcher=True,
                            allowed_packages=self.allowed_packages)
            inner.props["rect"] = [0.0, 0.0, width, height]
            bpatch_box._inner_patcher = inner
            self.boxes.append(bpatch_box)
            return (bpatch_box, inner)
        else:
            bpatch_box._inner_patcher = None
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
            num_inputs: Number of signal inputs. Auto-detected from code if None.
            num_outputs: Number of signal outputs. Auto-detected from code if None.
            x: Horizontal position of the gen~ box.
            y: Vertical position of the gen~ box.

        Returns:
            (parent_box, inner_patcher) tuple.
        """
        from src.maxpat.codegen import parse_genexpr_io, reorder_genexpr_declarations

        # Auto-fix declaration ordering (Param/History/Delay must precede expressions)
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
                        allowed_packages=self.allowed_packages)
        inner.props["bgcolor"] = list(GEN_PATCHER_BGCOLOR)
        inner.props["rect"] = [100.0, 100.0, 600.0, 450.0]

        # Add in objects inside the inner patcher
        in_boxes: list[Box] = []
        for i in range(num_inputs):
            in_box = Box.__new__(Box)
            in_box.name = "in"
            in_box.args = [str(i + 1)]
            in_box.id = inner._gen_id()
            in_box.maxclass = "newobj"
            in_box.text = f"in {i + 1}"
            in_box.numinlets = 0
            in_box.numoutlets = 1
            in_box.outlettype = [""]
            in_box.patching_rect = [50.0 + i * 80.0, 20.0, 30.0, 22.0]
            in_box.fontname = FONT_NAME
            in_box.fontsize = FONT_SIZE
            in_box.presentation = False
            in_box.presentation_rect = None
            in_box.target_id = None
            in_box.extra_attrs = {}
            in_box._inner_patcher = None
            in_box._saved_object_attributes = None
            in_box._bpatcher_attrs = None
            in_box._raw = None
            inner.boxes.append(in_box)
            in_boxes.append(in_box)

        # Create codebox (structural, not a DB object)
        codebox = Box.__new__(Box)
        codebox.name = "codebox"
        codebox.args = []
        codebox.id = inner._gen_id()
        codebox.maxclass = "codebox"
        codebox.text = ""
        codebox.numinlets = num_inputs
        codebox.numoutlets = num_outputs
        codebox.outlettype = [""] * num_outputs
        codebox.patching_rect = [50.0, 80.0, 400.0, 200.0]
        codebox.fontname = FONT_NAME
        codebox.fontsize = FONT_SIZE
        codebox.presentation = False
        codebox.presentation_rect = None
        codebox.target_id = None
        codebox.extra_attrs = {
            "code": code,
            "fontname": FONT_NAME,
            "fontsize": FONT_SIZE,
        }
        codebox._inner_patcher = None
        codebox._saved_object_attributes = None
        codebox._bpatcher_attrs = None
        codebox._raw = None
        inner.boxes.append(codebox)

        # Add out objects inside the inner patcher
        out_boxes: list[Box] = []
        for i in range(num_outputs):
            out_box = Box.__new__(Box)
            out_box.name = "out"
            out_box.args = [str(i + 1)]
            out_box.id = inner._gen_id()
            out_box.maxclass = "newobj"
            out_box.text = f"out {i + 1}"
            out_box.numinlets = 1
            out_box.numoutlets = 0
            out_box.outlettype = []
            out_box.patching_rect = [50.0 + i * 80.0, 320.0, 30.0, 22.0]
            out_box.fontname = FONT_NAME
            out_box.fontsize = FONT_SIZE
            out_box.presentation = False
            out_box.presentation_rect = None
            out_box.target_id = None
            out_box.extra_attrs = {}
            out_box._inner_patcher = None
            out_box._saved_object_attributes = None
            out_box._bpatcher_attrs = None
            out_box._raw = None
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

        parent_box = Box.__new__(Box)
        parent_box.name = "gen~"
        parent_box.args = []
        parent_box.id = box_id
        parent_box.maxclass = "newobj"
        parent_box.text = "gen~"
        parent_box.numinlets = num_inputs
        parent_box.numoutlets = num_outputs
        parent_box.outlettype = ["signal"] * num_outputs
        parent_box.patching_rect = [x, y, w, h]
        parent_box.fontname = FONT_NAME
        parent_box.fontsize = FONT_SIZE
        parent_box.presentation = False
        parent_box.presentation_rect = None
        parent_box.target_id = None
        parent_box.extra_attrs = {}
        parent_box._inner_patcher = inner
        parent_box._saved_object_attributes = None
        parent_box._bpatcher_attrs = None
        parent_box._raw = None

        self.boxes.append(parent_box)
        return (parent_box, inner)

    def add_m4l_gen_synth(
        self,
        params: list[tuple[str, float, float]],
        *,
        gen_varname: str = "synth",
        gen_code: str | None = None,
    ) -> tuple["Box", list["Box"], "Box"]:
        """Build a Live-ready M4L gen synth skeleton.

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

        ``gen~`` gets a stable ``varname`` matching the prefix in
        ``param_connect``. There is NO ``gain~``/``live.gain~``/``ezdac~``
        between ``gen~`` and ``plugout~`` (CLAUDE.md M4L rule -- Ableton's
        channel strip handles volume). Caller fills in DSP via ``gen_code``
        or by editing the gen~ inner patcher returned via ``gen_obj``.

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
            ValueError: If ``params`` is empty.
        """
        from src.maxpat.m4l_constants import ParamType, UnitStyle, ModMode

        if not params:
            raise ValueError("params must not be empty")

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

        # plugout~ is NOT in UI_MAXCLASSES (newobj with text "plugout~ 1").
        # add_box handles maxclass resolution via DB.
        plugout = self.add_box("plugout~", args=["1"], x=200.0, y=400.0)
        # Direct gen~ -> plugout~ wiring (D-15: NO gain~/live.gain~/ezdac~).
        self.add_connection(gen_obj, 0, plugout, 0)

        # live.dial row above gen~. live.dial is in UI_MAXCLASSES + DB.
        dials: list[Box] = []
        dial_x = 50.0
        dial_y = 100.0
        dial_spacing_x = 60.0
        for i, (name, mn, mx) in enumerate(params):
            d = self.add_box(
                "live.dial",
                x=dial_x + i * dial_spacing_x,
                y=dial_y,
                skip_overlap_check=True,
            )
            # Top-level box attributes -- Box.to_dict flattens extra_attrs
            # last (patcher.py creation path), so these surface at the box
            # dict's top level. Pitfall 4 mitigation: round-trip test
            # asserts param_connect lands at top-level.
            d.extra_attrs["varname"] = name
            d.extra_attrs["param_connect"] = f"{gen_varname}::{name}"
            d.extra_attrs["parameter_enable"] = 1
            d.extra_attrs["saved_attribute_attributes"] = {
                "valueof": {
                    "parameter_initial": [(mn + mx) / 2.0],
                    "parameter_initial_enable": 1,
                    "parameter_longname": name,
                    "parameter_shortname": name,
                    "parameter_mmin": mn,
                    "parameter_mmax": mx,
                    "parameter_modmode": int(ModMode.ABSOLUTE),
                    "parameter_type": int(ParamType.FLOAT),
                    "parameter_unitstyle": int(UnitStyle.FLOAT),
                },
            }
            dials.append(d)

        return gen_obj, dials, plugout

    def add_node_script(
        self,
        filename: str,
        code: str | None = None,
        num_outlets: int = 2,
        x: float = 0.0,
        y: float = 0.0,
    ) -> tuple[Box, str | None]:
        """Add a node.script box for Node for Max.

        node.script is NOT in the object database (it is a MAX infrastructure
        object). Uses Box.__new__ to bypass DB lookup.

        Args:
            filename: JavaScript file name (e.g., "myscript.js").
            code: Optional N4M JavaScript code string. Caller is responsible
                for writing it to disk.
            num_outlets: Number of outlets (default 2: data + status).
            x: Horizontal position.
            y: Vertical position.

        Returns:
            (box, code) tuple. code is None if not provided.
        """
        box_id = self._gen_id()
        text = f"node.script {filename}"

        box = Box.__new__(Box)
        box.name = "node.script"
        box.args = [filename]
        box.id = box_id
        box.maxclass = "newobj"
        box.text = text
        box.numinlets = 1
        box.numoutlets = num_outlets
        box.outlettype = [""] * num_outlets
        w, h = calculate_box_size(text, "newobj")
        box.patching_rect = [x, y, w, h]
        box.fontname = FONT_NAME
        box.fontsize = FONT_SIZE
        box.presentation = False
        box.presentation_rect = None
        box.target_id = None
        box.extra_attrs = {}
        box._inner_patcher = None
        box._saved_object_attributes = None
        box._bpatcher_attrs = None
        box._raw = None

        self.boxes.append(box)
        return (box, code)

    def add_js(
        self,
        filename: str,
        code: str | None = None,
        num_inlets: int = 1,
        num_outlets: int = 1,
        x: float = 0.0,
        y: float = 0.0,
    ) -> tuple[Box, str | None]:
        """Add a js object box for V8 JavaScript.

        In .maxpat files, js uses maxclass="newobj" with text="js filename.js"
        (not maxclass="js"). Uses Box.__new__ to bypass DB lookup and ensure
        the correct maxclass.

        Args:
            filename: JavaScript file name (e.g., "myobject.js").
            code: Optional js V8 JavaScript code string. Caller is responsible
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

        box = Box.__new__(Box)
        box.name = "js"
        box.args = [filename]
        box.id = box_id
        box.maxclass = "newobj"
        box.text = text
        box.numinlets = num_inlets
        box.numoutlets = num_outlets
        box.outlettype = [""] * num_outlets
        w, h = calculate_box_size(text, "newobj")
        box.patching_rect = [x, y, w, h]
        box.fontname = FONT_NAME
        box.fontsize = FONT_SIZE
        box.presentation = False
        box.presentation_rect = None
        box.target_id = None
        box.extra_attrs = {}
        box._inner_patcher = None
        box._saved_object_attributes = None
        box._bpatcher_attrs = None
        box._raw = None

        self.boxes.append(box)
        return (box, code)
