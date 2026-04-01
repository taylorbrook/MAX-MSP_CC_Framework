"""Patcher, Box, and Patchline data model with .maxpat JSON serialization.

This module provides the core types for building MAX patches programmatically.
Patcher holds boxes and connections; Box represents a single MAX object;
Patchline represents a connection between two boxes.

All JSON output follows the .maxpat format verified in 02-RESEARCH.md.
"""

from __future__ import annotations

import copy
from collections import Counter, deque
from dataclasses import dataclass, field
from typing import Any

from src.maxpat.defaults import (
    AESTHETIC_PALETTE,
    BUBBLE_TOP,
    DEFAULT_PATCHER_PROPS,
    FONT_NAME,
    FONT_SIZE,
    FONTFACE_BOLD,
    FONTFACE_ITALIC,
    GEN_PATCHER_BGCOLOR,
    SUBPATCHER_RECT,
    V_SPACING,
)

# Collision detection padding (px) around boxes for readability
COLLISION_PAD = 5.0

# ---------------------------------------------------------------------------
# Section signature mapping: object name -> section label
# Used by _name_section() for auto-naming connected components.
# ---------------------------------------------------------------------------
SECTION_SIGNATURES: dict[str, str] = {
    # Audio sources (priority: high)
    "cycle~": "Oscillator",
    "saw~": "Oscillator",
    "rect~": "Oscillator",
    "tri~": "Oscillator",
    "phasor~": "Oscillator",
    "noise~": "Noise Generator",
    "sfplay~": "Sample Player",
    "play~": "Sample Player",
    "groove~": "Sample Player",
    "buffer~": "Buffer",
    # Processing (priority: medium)
    "svf~": "Filter",
    "biquad~": "Filter",
    "onepole~": "Filter",
    "reson~": "Filter",
    "filtergraph~": "Filter",
    "lores~": "Filter",
    # Dynamics / envelope
    "adsr~": "Envelope",
    "function": "Envelope",
    "line~": "Envelope/Ramp",
    # Effects
    "tapin~": "Delay",
    "tapout~": "Delay",
    "freqshift~": "Frequency Shifter",
    "pitchshift~": "Pitch Shifter",
    "reverb~": "Reverb",
    # Output (priority: low)
    "dac~": "Audio Output",
    "ezdac~": "Audio Output",
    "adc~": "Audio Input",
    "ezadc~": "Audio Input",
    # MIDI
    "notein": "MIDI Input",
    "noteout": "MIDI Output",
    "ctlin": "MIDI Control",
    "makenote": "MIDI Note Builder",
    # Mixing
    "gain~": "Gain/Mixer",
    "*~": "Gain/Mixer",
    # Gen
    "gen~": "Gen~ DSP",
    # Control
    "metro": "Clock/Sequencer",
    "counter": "Counter/Sequencer",
    "loadbang": "Initialization",
    # Jitter
    "jit.gl.render": "OpenGL Render",
    "jit.matrix": "Matrix Processing",
}

# Priority ordering for section naming: higher number = higher priority.
# When multiple signature objects appear in a section, prefer the one with
# the highest priority to name the section.
_SECTION_NAME_PRIORITY: dict[str, int] = {
    "Oscillator": 90,
    "Noise Generator": 85,
    "Sample Player": 85,
    "Gen~ DSP": 80,
    "Filter": 70,
    "Envelope": 65,
    "Envelope/Ramp": 60,
    "Delay": 60,
    "Frequency Shifter": 60,
    "Pitch Shifter": 60,
    "Reverb": 60,
    "Gain/Mixer": 50,
    "Buffer": 40,
    "MIDI Input": 75,
    "MIDI Output": 55,
    "MIDI Control": 70,
    "MIDI Note Builder": 65,
    "Clock/Sequencer": 70,
    "Counter/Sequencer": 65,
    "Initialization": 30,
    "Audio Output": 20,
    "Audio Input": 80,
    "OpenGL Render": 75,
    "Matrix Processing": 70,
}
from src.maxpat.maxclass_map import resolve_maxclass, is_ui_object, UI_MAXCLASSES
from src.maxpat.sizing import calculate_box_size
from src.maxpat.db_lookup import ObjectDatabase


class Patchline:
    """A connection between two boxes in a MAX patcher.

    Serializes to: {"patchline": {"source": [id, outlet], "destination": [id, inlet], ...}}

    Supports optional midpoints for segmented cable routing. Midpoints is a
    flat list of [x1, y1, x2, y2, ...] coordinates that the cable routes
    through, creating right-angle bends instead of diagonal lines.
    """

    def __init__(
        self,
        source_id: str,
        source_outlet: int,
        dest_id: str,
        dest_inlet: int,
        order: int = 0,
        hidden: bool = False,
        midpoints: list[float] | None = None,
        color: list | None = None,
        extra_attrs: dict | None = None,
        _raw: dict | None = None,
    ):
        self.source_id = source_id
        self.source_outlet = source_outlet
        self.dest_id = dest_id
        self.dest_inlet = dest_inlet
        self.order = order
        self.hidden = hidden
        self.midpoints = midpoints
        self.color = color
        self.extra_attrs = extra_attrs if extra_attrs is not None else {}
        self._raw = _raw

    def to_dict(self) -> dict[str, Any]:
        """Serialize to .maxpat patchline JSON structure.

        Uses dual-path serialization:
        - Round-trip path (self._raw exists): start from original dict, overlay
          mutable fields for lossless preservation of unknown keys and key order.
        - Creation path (no _raw): build dict from scratch for new connections.
        """
        if self._raw is not None:
            # Round-trip path: preserve original dict structure
            d = dict(self._raw)
            d["source"] = [self.source_id, self.source_outlet]
            d["destination"] = [self.dest_id, self.dest_inlet]
            # Update color if changed from what was in _raw
            if self.color is not None:
                d["color"] = self.color
            elif "color" in d and self.color is None:
                del d["color"]
            # Sync midpoints: add/update/remove as needed
            if self.midpoints:
                d["midpoints"] = list(self.midpoints)
            elif "midpoints" in d:
                del d["midpoints"]
            return {"patchline": d}
        else:
            # Creation path: build from scratch
            d: dict[str, Any] = {
                "source": [self.source_id, self.source_outlet],
                "destination": [self.dest_id, self.dest_inlet],
            }
            # Only include "order" if non-zero (MAX omits order=0)
            if self.order != 0:
                d["order"] = self.order
            if self.hidden:
                d["hidden"] = 1
            if self.midpoints:
                d["midpoints"] = list(self.midpoints)
            if self.color is not None:
                d["color"] = self.color
            d.update(self.extra_attrs)
            return {"patchline": d}


@dataclass
class EditResult:
    """Result of an edit operation with orphaned connection tracking.

    Returned by modify_box() and replace_box() to provide the caller with
    the edited/created box and any connections that were orphaned during
    the operation (e.g., due to I/O count shrink or object replacement).
    """
    box: Box
    orphaned: list[dict] = field(default_factory=list)
    # Each orphaned entry: {"source_id", "source_outlet", "dest_id", "dest_inlet"}


class Box:
    """A single MAX object box in a patcher.

    Handles maxclass resolution, content-aware sizing, and .maxpat JSON
    serialization. Supports both UI objects (maxclass = own name) and non-UI
    objects (maxclass = "newobj" with text field).
    """

    def __init__(
        self,
        name: str,
        args: list[str] | None = None,
        box_id: str = "obj-0",
        db: ObjectDatabase | None = None,
        x: float = 0.0,
        y: float = 0.0,
    ):
        """Create a Box.

        Args:
            name: MAX object name (e.g., "cycle~", "toggle", "pack").
            args: Object arguments (e.g., ["440"] for cycle~ 440).
            box_id: Unique box identifier (e.g., "obj-1").
            db: ObjectDatabase instance for lookup. Required for non-UI
                objects to verify existence and get I/O counts.
            x: Horizontal position.
            y: Vertical position.

        Raises:
            ValueError: If name is not found in database and not a known
                       UI maxclass (Rule #1: Never Guess Objects).
        """
        if args is None:
            args = []

        self.name = name
        self.args = args
        self.id = box_id

        # Resolve the canonical name (handle aliases like t -> trigger)
        canonical = name
        if db:
            canonical = db._aliases.get(name, name)

        # Resolve maxclass
        self.maxclass = resolve_maxclass(canonical)

        # Build text field (name + args)
        parts = [name] + args
        self.text = " ".join(parts).strip()

        # Look up object in database for I/O counts and outlet types
        obj_data = None
        if db:
            obj_data = db.lookup(name)

        if obj_data is None and not is_ui_object(canonical):
            # Object not in database and not a known UI type -- Rule #1 violation
            raise ValueError(
                f"Unknown object: '{name}' -- not in database, verify manually. "
                f"(Rule #1: Never Guess Objects)"
            )

        # Compute I/O counts
        if db and obj_data:
            self.numinlets, self.numoutlets = db.compute_io_counts(name, args)
            self.outlettype = db.get_outlet_types(name, args)
        elif obj_data:
            self.numinlets = len(obj_data.get("inlets", []))
            self.numoutlets = len(obj_data.get("outlets", []))
            self.outlettype = self._derive_outlet_types(obj_data)
        else:
            # UI object not in database -- use defaults
            self.numinlets = 1
            self.numoutlets = 1
            self.outlettype = [""]

        # Compute box size
        w, h = calculate_box_size(self.text, self.maxclass)
        self.patching_rect = [x, y, w, h]

        # Font (for non-UI and text-based UI objects)
        self.fontname = FONT_NAME
        self.fontsize = FONT_SIZE

        # Presentation mode
        self.presentation = False
        self.presentation_rect: list[float] | None = None

        # Extra attributes (for custom box properties)
        self.extra_attrs: dict[str, Any] = {}

        # Comment association: layout-time only, not serialized to .maxpat
        self.target_id: str | None = None

        # Internal: track if this is a subpatcher/bpatcher with embedded patcher
        self._inner_patcher: Patcher | None = None
        self._saved_object_attributes: dict[str, Any] | None = None
        self._bpatcher_attrs: dict[str, Any] | None = None

        # Raw dict for lossless round-trip (None for newly created boxes)
        self._raw: dict | None = None

    @staticmethod
    def _derive_outlet_types(obj_data: dict) -> list[str]:
        """Derive outlettype array from object database outlets."""
        result = []
        for outlet in obj_data.get("outlets", []):
            if outlet.get("signal"):
                otype = outlet.get("type", "")
                if "multichannel" in otype.lower():
                    result.append("multichannelsignal")
                else:
                    result.append("signal")
            else:
                result.append("")
        return result

    def to_dict(self) -> dict[str, Any]:
        """Serialize to .maxpat box JSON structure.

        Uses dual-path serialization:
        - Round-trip path (self._raw exists): start from original dict, overlay
          mutable fields for lossless preservation of unknown keys and key order.
        - Creation path (no _raw): build dict from scratch for new boxes.

        Returns:
            {"box": {...}} dict matching the .maxpat format.
        """
        if self._raw is not None:
            # === ROUND-TRIP PATH ===
            # Start from original dict, overlay any mutations
            d = dict(self._raw)

            # Overlay mutable fields that Python code may have changed
            d["patching_rect"] = self.patching_rect
            d["numinlets"] = self.numinlets
            d["numoutlets"] = self.numoutlets
            if self.text is not None:
                d["text"] = self.text
            if "outlettype" in self._raw:
                d["outlettype"] = self.outlettype

            # Presentation mode
            if self.presentation:
                d["presentation"] = 1
                if self.presentation_rect is not None:
                    d["presentation_rect"] = self.presentation_rect
            elif "presentation" in d:
                del d["presentation"]
                d.pop("presentation_rect", None)

            # Inner patcher (subpatcher/bpatcher embed)
            if self._inner_patcher is not None:
                d["patcher"] = self._inner_patcher.to_dict()["patcher"]
            elif "patcher" in self._raw:
                # Inner patcher was removed -- don't emit stale copy
                d.pop("patcher", None)

            # saved_object_attributes
            if self._saved_object_attributes is not None:
                d["saved_object_attributes"] = self._saved_object_attributes
            elif "saved_object_attributes" not in self._raw:
                d.pop("saved_object_attributes", None)

            return {"box": d}
        else:
            # === CREATION PATH (existing logic) ===
            d: dict[str, Any] = {
                "maxclass": self.maxclass,
                "id": self.id,
                "numinlets": self.numinlets,
                "numoutlets": self.numoutlets,
                "outlettype": self.outlettype,
                "patching_rect": self.patching_rect,
            }

            # Non-UI objects: include text and font
            if self.maxclass == "newobj":
                d["text"] = self.text
                d["fontname"] = self.fontname
                d["fontsize"] = self.fontsize
            elif self.maxclass in ("comment", "message"):
                # Text-based UI objects
                d["text"] = self.text
                d["fontname"] = self.fontname
                d["fontsize"] = self.fontsize
            elif self.maxclass == "bpatcher":
                # bpatcher may or may not have text
                pass
            else:
                # Fixed-size UI objects get parameter_enable
                d["parameter_enable"] = 0

            # bpatcher-specific attributes
            if self._bpatcher_attrs:
                d.update(self._bpatcher_attrs)

            # Embedded patcher (subpatcher or embedded bpatcher)
            if self._inner_patcher is not None:
                d["patcher"] = self._inner_patcher.to_dict()["patcher"]

            # Saved object attributes (for subpatchers)
            if self._saved_object_attributes is not None:
                d["saved_object_attributes"] = self._saved_object_attributes

            # Presentation mode
            if self.presentation:
                d["presentation"] = 1
                if self.presentation_rect is not None:
                    d["presentation_rect"] = self.presentation_rect

            # Extra attributes
            d.update(self.extra_attrs)

            return {"box": d}


class Patcher:
    """A MAX patcher containing boxes and patchlines.

    The top-level container for a .maxpat file. Serializes to the complete
    .maxpat JSON structure with patcher wrapper, boxes array, and lines array.
    """

    def __init__(self, db: ObjectDatabase | None = None, is_subpatcher: bool = False):
        """Create a new Patcher.

        Args:
            db: ObjectDatabase instance. Created automatically if None.
            is_subpatcher: If True, uses SUBPATCHER_RECT for window size.
        """
        if db is None:
            db = ObjectDatabase()

        self.db = db
        self.boxes: list[Box] = []
        self.lines: list[Patchline] = []
        self.props = copy.deepcopy(DEFAULT_PATCHER_PROPS)
        self._next_id = 1
        self._is_subpatcher = is_subpatcher

        if is_subpatcher:
            self.props["rect"] = list(SUBPATCHER_RECT)

    def _gen_id(self) -> str:
        """Generate the next unique box ID."""
        box_id = f"obj-{self._next_id}"
        self._next_id += 1
        return box_id

    def add_box(
        self,
        name: str,
        args: list[str] | None = None,
        x: float = 0.0,
        y: float = 0.0,
    ) -> Box:
        """Add a MAX object box to the patcher.

        Args:
            name: Object name (e.g., "cycle~", "toggle", "t").
            args: Object arguments (e.g., ["440"]).
            x: Horizontal position (default 0, set by layout engine later).
            y: Vertical position (default 0, set by layout engine later).

        Returns:
            The created Box instance.

        Raises:
            ValueError: If object not found in database (Rule #1).
        """
        box_id = self._gen_id()
        box = Box(name=name, args=args, box_id=box_id, db=self.db, x=x, y=y)
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
        box = Box(name="comment", args=[], box_id=box_id, db=self.db, x=x, y=y)
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

        # Insert at index 0 for correct z-order (behind all objects)
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

        marker.extra_attrs = {
            "background": 1,
            "ignoreclick": 1,
            "rounded": 60.0,
            "text": str(number),
            "textcolor": list(AESTHETIC_PALETTE["step_marker_text"]),
            "bgcolor": list(AESTHETIC_PALETTE["step_marker_bg"]),
            "fontface": FONTFACE_BOLD,
            "parameter_enable": 0,
        }

        # Insert at index 0 for background layer z-order
        self.boxes.insert(0, marker)
        return marker

    def bring_to_front(self, box: Box) -> None:
        """Move box to end of boxes array (renders on top of all other objects).

        In .maxpat files, z-order is implicit: objects later in the boxes array
        render on top of earlier ones. This moves the box to the last position.

        Args:
            box: Box to bring to front.

        Raises:
            ValueError: If box is not in this patcher.
        """
        try:
            self.boxes.remove(box)
        except ValueError:
            raise ValueError(f"Box {box.id!r} not in this patcher")
        self.boxes.append(box)

    def send_to_back(self, box: Box) -> None:
        """Move box to index 0 in boxes array (renders behind all other objects).

        In .maxpat files, z-order is implicit: objects earlier in the boxes array
        render behind later ones. This moves the box to the first position.

        Args:
            box: Box to send to back.

        Raises:
            ValueError: If box is not in this patcher.
        """
        try:
            self.boxes.remove(box)
        except ValueError:
            raise ValueError(f"Box {box.id!r} not in this patcher")
        self.boxes.insert(0, box)

    def set_z_index(self, box: Box, index: int) -> None:
        """Move box to a specific position in the boxes array for z-order control.

        Index 0 = behind everything (same as send_to_back).
        Index -1 or len(boxes) = on top of everything (same as bring_to_front).
        Out-of-range indices are clamped to valid range.

        Args:
            box: Box to reposition.
            index: Target index in boxes array.

        Raises:
            ValueError: If box is not in this patcher.
        """
        try:
            self.boxes.remove(box)
        except ValueError:
            raise ValueError(f"Box {box.id!r} not in this patcher")
        # Clamp index to valid range after removal
        max_idx = len(self.boxes)
        if index < 0:
            index = max(0, max_idx + 1 + index)
        index = min(index, max_idx)
        self.boxes.insert(index, box)

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
        box = Box(name="message", args=[], box_id=box_id, db=self.db, x=x, y=y)
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

    # ------------------------------------------------------------------
    # Mutation / removal
    # ------------------------------------------------------------------

    def remove_box(self, box: Box) -> None:
        """Remove a box and all patchlines connected to it.

        Args:
            box: The box to remove.

        Raises:
            ValueError: If the box is not in this patcher.
        """
        if box not in self.boxes:
            raise ValueError(
                f"Box {box.id} not found in this patcher"
            )
        # Filter out all patchlines referencing this box (build new list)
        self.lines = [
            pl for pl in self.lines
            if pl.source_id != box.id and pl.dest_id != box.id
        ]
        self.boxes.remove(box)

    def remove_connection(
        self,
        src_box: Box,
        src_outlet: int,
        dst_box: Box,
        dst_inlet: int,
    ) -> None:
        """Remove a specific connection between two boxes.

        Args:
            src_box: Source box.
            src_outlet: Source outlet index.
            dst_box: Destination box.
            dst_inlet: Destination inlet index.

        Raises:
            ValueError: If no matching connection exists.
        """
        for i, pl in enumerate(self.lines):
            if (pl.source_id == src_box.id
                    and pl.source_outlet == src_outlet
                    and pl.dest_id == dst_box.id
                    and pl.dest_inlet == dst_inlet):
                self.lines.pop(i)
                return
        raise ValueError(
            f"Connection not found: {src_box.id}[{src_outlet}] -> "
            f"{dst_box.id}[{dst_inlet}]"
        )

    def modify_box(
        self,
        box: Box,
        *,
        args: list[str] | None = None,
        position: list[float] | None = None,
        color: list[float] | None = None,
        extra_attrs: dict | None = None,
    ) -> EditResult:
        """Modify a box's attributes in-place.

        Changes args (with I/O recomputation for variable_io), position,
        color, or extra_attrs. When I/O count shrinks, orphaned connections
        are auto-removed and returned in the result.

        Args:
            box: The box to modify (must be in this patcher).
            args: New arguments (triggers I/O recomputation for variable_io).
            position: New [x, y] position.
            color: New box color [r, g, b, a] -- sets extra_attrs["bgcolor"].
            extra_attrs: Dict of additional attributes to set/update.

        Returns:
            EditResult with the modified box and any orphaned connections.

        Raises:
            ValueError: If box is not in this patcher.
        """
        if box not in self.boxes:
            raise ValueError(
                f"Box {box.id} not found in this patcher"
            )

        orphaned: list[dict] = []

        if args is not None:
            # Update args and text
            box.args = list(args)
            parts = [box.name] + list(args)
            box.text = " ".join(parts).strip()

            # Recompute I/O counts via database
            if self.db:
                box.numinlets, box.numoutlets = self.db.compute_io_counts(
                    box.name, args
                )
                box.outlettype = self.db.get_outlet_types(box.name, args)

            # Recalculate box size
            w, h = calculate_box_size(box.text, box.maxclass)
            box.patching_rect[2] = w
            box.patching_rect[3] = h

            # Orphan connections to removed outlets/inlets
            surviving = []
            for pl in self.lines:
                orphan = False
                if pl.source_id == box.id and pl.source_outlet >= box.numoutlets:
                    orphan = True
                if pl.dest_id == box.id and pl.dest_inlet >= box.numinlets:
                    orphan = True
                if orphan:
                    orphaned.append({
                        "source_id": pl.source_id,
                        "source_outlet": pl.source_outlet,
                        "dest_id": pl.dest_id,
                        "dest_inlet": pl.dest_inlet,
                    })
                else:
                    surviving.append(pl)
            self.lines = surviving

            # Sync _raw dict
            if box._raw is not None:
                box._raw["text"] = box.text
                box._raw["numinlets"] = box.numinlets
                box._raw["numoutlets"] = box.numoutlets
                if "outlettype" in box._raw:
                    box._raw["outlettype"] = box.outlettype
                box._raw["patching_rect"] = box.patching_rect

        if position is not None:
            box.patching_rect[0] = position[0]
            box.patching_rect[1] = position[1]
            if box._raw is not None:
                box._raw["patching_rect"] = box.patching_rect

        if color is not None:
            box.extra_attrs["bgcolor"] = color
            if box._raw is not None:
                box._raw["bgcolor"] = color

        if extra_attrs is not None:
            box.extra_attrs.update(extra_attrs)
            if box._raw is not None:
                box._raw.update(extra_attrs)

        return EditResult(box=box, orphaned=orphaned)

    def replace_box(
        self,
        old_box: Box,
        new_name: str,
        *,
        args: list[str] | None = None,
    ) -> EditResult:
        """Replace a box with a new object of a different type.

        Creates a new box at the old box's position, removes the old box,
        and returns ALL old connections as orphaned (no auto-remap per
        CONTEXT.md locked decision). The caller handles rewiring.

        Args:
            old_box: The box to replace (must be in this patcher).
            new_name: Name of the replacement object (e.g., "saw~").
            args: Optional arguments for the new object.

        Returns:
            EditResult with the new box and all old connections as orphaned.

        Raises:
            ValueError: If old_box is not in this patcher.
        """
        if old_box not in self.boxes:
            raise ValueError(
                f"Box {old_box.id} not found in this patcher"
            )

        # Capture ALL connections to/from old box as orphaned dicts
        orphaned: list[dict] = []
        for pl in self.lines:
            if pl.source_id == old_box.id or pl.dest_id == old_box.id:
                orphaned.append({
                    "source_id": pl.source_id,
                    "source_outlet": pl.source_outlet,
                    "dest_id": pl.dest_id,
                    "dest_inlet": pl.dest_inlet,
                })

        # Record old position
        old_x = old_box.patching_rect[0]
        old_y = old_box.patching_rect[1]

        # Remove old box and its patchlines
        self.remove_box(old_box)

        # Create replacement box at old position
        new_box = self.add_box(new_name, args=args, x=old_x, y=old_y)

        return EditResult(box=new_box, orphaned=orphaned)

    def insert_into_connection(
        self,
        source: Box,
        dest: Box,
        name: str,
        args: list[str] | None = None,
    ) -> EditResult:
        """Insert a new box into all connections between source and dest.

        Splices a new object into existing connections: removes old
        source->dest connections and creates source->new and new->dest
        connections for each. One shared inserted object handles all
        matching connections.

        When the inserted object has fewer inlets/outlets than connections
        found, wires what fits and returns the rest as orphaned in
        EditResult (no hard failure for I/O mismatch).

        Args:
            source: Source box of the connection(s) to splice into.
            dest: Destination box of the connection(s) to splice into.
            name: Object name for the inserted box (e.g., "*~").
            args: Optional arguments for the inserted box.

        Returns:
            EditResult with the new box and any orphaned connections.

        Raises:
            ValueError: If no connections exist between source and dest,
                or source/dest not in patcher.
        """
        if source not in self.boxes:
            raise ValueError(f"Box {source.id} not found in this patcher")
        if dest not in self.boxes:
            raise ValueError(f"Box {dest.id} not found in this patcher")

        # Find ALL patchlines between source and dest
        matching = [
            pl for pl in self.lines
            if pl.source_id == source.id and pl.dest_id == dest.id
        ]
        if not matching:
            raise ValueError(
                f"No connection found between {source.id} and {dest.id}"
            )

        # Create the new box
        new_box = self.add_box(name, args=args)

        # Auto-position below source
        self._auto_position(new_box, near_box=source)

        # Determine I/O capacity
        capacity = min(new_box.numinlets, new_box.numoutlets)

        orphaned: list[dict] = []

        for i, pl in enumerate(matching):
            # Remove old connection
            self.lines = [ln for ln in self.lines if ln is not pl]

            if i < capacity:
                # Wire through the new box: source->new and new->dest
                self.add_connection(source, pl.source_outlet, new_box, i)
                self.add_connection(new_box, i, dest, pl.dest_inlet)
            else:
                # I/O capacity exceeded -- orphan this connection
                orphaned.append({
                    "source_id": pl.source_id,
                    "source_outlet": pl.source_outlet,
                    "dest_id": pl.dest_id,
                    "dest_inlet": pl.dest_inlet,
                })

        return EditResult(box=new_box, orphaned=orphaned)

    # ------------------------------------------------------------------
    # Auto-positioning
    # ------------------------------------------------------------------

    def _find_clear_position(
        self,
        x: float,
        y: float,
        w: float,
        h: float,
        exclude_box: Box | None = None,
    ) -> tuple[float, float]:
        """Find a non-overlapping position starting from (x, y), snapped to 15px grid.

        Nudges right by 15px on collision; wraps to the next row when x > 1200.

        Args:
            x: Starting x position.
            y: Starting y position.
            w: Width of the box to place.
            h: Height of the box to place.
            exclude_box: Optional box to exclude from collision checks (self-reposition).

        Returns:
            (x, y) tuple snapped to 15px grid with no overlap.
        """
        # Snap to 15px grid
        x = round(x / 15.0) * 15.0
        y = round(y / 15.0) * 15.0
        start_x = x

        for _ in range(50):
            collision = False
            for box in self.boxes:
                if box is exclude_box:
                    continue
                bx, by, bw, bh = box.patching_rect
                # Check overlap with COLLISION_PAD on both rects
                if not (
                    x + w + COLLISION_PAD <= bx - COLLISION_PAD
                    or x - COLLISION_PAD >= bx + bw + COLLISION_PAD
                    or y + h + COLLISION_PAD <= by - COLLISION_PAD
                    or y - COLLISION_PAD >= by + bh + COLLISION_PAD
                ):
                    collision = True
                    break
            if not collision:
                return (x, y)
            # Nudge right
            x += 15.0
            if x > 1200:
                x = start_x
                y += 15.0
        return (x, y)

    def _auto_position(self, box: Box, near_box: Box | None = None) -> None:
        """Position a box automatically, avoiding collisions.

        If near_box is provided, places below it with V_SPACING gap.
        Otherwise, places at the center of the patcher visible rect.

        Args:
            box: The box to position.
            near_box: Optional reference box to position relative to.
        """
        if near_box is not None:
            ideal_x = near_box.patching_rect[0]
            ideal_y = (
                near_box.patching_rect[1]
                + near_box.patching_rect[3]
                + V_SPACING
            )
        else:
            ideal_x = self.props["rect"][2] / 2.0
            ideal_y = self.props["rect"][3] / 2.0

        w = box.patching_rect[2]
        h = box.patching_rect[3]
        new_x, new_y = self._find_clear_position(ideal_x, ideal_y, w, h)
        box.patching_rect[0] = new_x
        box.patching_rect[1] = new_y

        # Sync _raw if present (round-trip fidelity)
        if box._raw is not None:
            box._raw["patching_rect"] = box.patching_rect

    # ------------------------------------------------------------------
    # Search / query
    # ------------------------------------------------------------------

    def find_boxes(
        self,
        *,
        id: str | None = None,
        name: str | None = None,
        maxclass: str | None = None,
        text: str | None = None,
        recursive: bool = False,
    ) -> list[Box]:
        """Return all boxes matching the given criteria (AND combination).

        Args:
            id: Exact match against ``box.id``.
            name: Match against ``box.name`` with bidirectional alias
                resolution when a DB is available.
            maxclass: Exact match against ``box.maxclass``.
            text: Substring match against ``box.text``.
            recursive: If True, also search boxes inside subpatchers.

        Returns:
            List of matching Box objects (may be empty).
        """
        # Resolve the search name to its canonical form for alias matching
        canonical_search: str | None = None
        if name is not None:
            aliases = getattr(self.db, "_aliases", None) if self.db else None
            if aliases:
                canonical_search = aliases.get(name, name)
            else:
                canonical_search = name

        results: list[Box] = []
        for box in self.boxes:
            if not self._box_matches(box, id, name, maxclass, text, canonical_search):
                continue
            results.append(box)
        if recursive:
            for box in self.boxes:
                if box._inner_patcher is not None:
                    results.extend(
                        box._inner_patcher.find_boxes(
                            id=id, name=name, maxclass=maxclass,
                            text=text, recursive=True,
                        )
                    )
        return results

    def find_box(
        self,
        *,
        id: str | None = None,
        name: str | None = None,
        maxclass: str | None = None,
        text: str | None = None,
        recursive: bool = False,
    ) -> Box | None:
        """Return the first box matching the given criteria, or None.

        Same criteria as :meth:`find_boxes` but short-circuits on first
        match.  When *recursive* is True, parent boxes are checked before
        inner-patcher boxes (depth-first).

        Args:
            id: Exact match against ``box.id``.
            name: Match against ``box.name`` with bidirectional alias
                resolution when a DB is available.
            maxclass: Exact match against ``box.maxclass``.
            text: Substring match against ``box.text``.
            recursive: If True, also search boxes inside subpatchers.

        Returns:
            First matching Box, or None.
        """
        # Resolve the search name to its canonical form for alias matching
        canonical_search: str | None = None
        if name is not None:
            aliases = getattr(self.db, "_aliases", None) if self.db else None
            if aliases:
                canonical_search = aliases.get(name, name)
            else:
                canonical_search = name

        for box in self.boxes:
            if self._box_matches(box, id, name, maxclass, text, canonical_search):
                return box
        if recursive:
            for box in self.boxes:
                if box._inner_patcher is not None:
                    found = box._inner_patcher.find_box(
                        id=id, name=name, maxclass=maxclass,
                        text=text, recursive=True,
                    )
                    if found is not None:
                        return found
        return None

    def _box_matches(
        self,
        box: Box,
        id: str | None,
        name: str | None,
        maxclass: str | None,
        text: str | None,
        canonical_search: str | None,
    ) -> bool:
        """Return True if *box* satisfies all non-None criteria."""
        if id is not None and box.id != id:
            return False
        if name is not None:
            aliases = getattr(self.db, "_aliases", None) if self.db else None
            if aliases:
                canonical_box = aliases.get(box.name, box.name)
                if canonical_box != canonical_search:
                    return False
            else:
                if box.name != name:
                    return False
        if maxclass is not None and box.maxclass != maxclass:
            return False
        if text is not None and text not in box.text:
            return False
        return True

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
        inner = Patcher(db=self.db, is_subpatcher=True)

        # Add inlet objects inside the subpatcher
        inlet_spacing = 80.0
        for i in range(inlets):
            inlet_box = inner.add_box("inlet", x=50.0 + i * inlet_spacing, y=30.0)
            comment = ""
            if inlet_comments and i < len(inlet_comments):
                comment = inlet_comments[i]
            inlet_box.extra_attrs["comment"] = comment

        # Add outlet objects inside the subpatcher
        for i in range(outlets):
            outlet_box = inner.add_box("outlet", x=50.0 + i * inlet_spacing, y=250.0)
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
        width: float = 200.0,
        height: float = 100.0,
        numinlets: int = 1,
        numoutlets: int = 1,
    ) -> Box | tuple[Box, Patcher]:
        """Add a bpatcher box (file reference or embedded).

        Args:
            filename: Path to external .maxpat file (for file reference).
            embedded: If True, create embedded bpatcher with inner Patcher.
            args: bpatcher arguments.
            x: Horizontal position.
            y: Vertical position.
            width: bpatcher display width.
            height: bpatcher display height.
            numinlets: Number of inlets.
            numoutlets: Number of outlets.

        Returns:
            Box if file reference, (Box, Patcher) tuple if embedded.
        """
        if args is None:
            args = []

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
            inner = Patcher(db=self.db, is_subpatcher=True)
            inner.props["rect"] = [0.0, 0.0, width, height]
            bpatch_box._inner_patcher = inner
            self.boxes.append(bpatch_box)
            return (bpatch_box, inner)
        else:
            bpatch_box._inner_patcher = None
            self.boxes.append(bpatch_box)
            return bpatch_box

    def populate_assistance_comments(self) -> "Patcher":
        """Auto-populate empty assistance comments on inlet/outlet objects.

        Walks all boxes in this patcher looking for subpatchers (boxes with
        _inner_patcher set). For each inner patcher, finds inlet/outlet objects
        with empty comment attributes and infers descriptive text from their
        connections:

        - For inlets: looks at what the inlet connects to downstream and
          generates a comment like "signal to cycle~ 440".
        - For outlets: looks at what connects upstream to the outlet and
          generates a comment like "signal from *~ 0.5".
        - If no connections found, uses positional fallback: "inlet 1",
          "outlet 2", etc.
        - Skips inlet/outlet objects that already have non-empty comments.
        - Recurses into nested subpatchers.

        Returns:
            self for method chaining.
        """
        self._populate_comments_recursive(self)
        return self

    @staticmethod
    def _populate_comments_recursive(patcher: "Patcher") -> None:
        """Recursively populate assistance comments in a patcher and its subpatchers."""
        for box in patcher.boxes:
            if box._inner_patcher is not None:
                inner = box._inner_patcher
                # Build a lookup from box id to box object for the inner patcher
                id_to_box: dict[str, Box] = {b.id: b for b in inner.boxes}

                # Find inlet and outlet boxes, track their position index
                inlet_boxes: list[Box] = []
                outlet_boxes: list[Box] = []
                for b in inner.boxes:
                    if b.maxclass == "inlet":
                        inlet_boxes.append(b)
                    elif b.maxclass == "outlet":
                        outlet_boxes.append(b)

                # Sort by x position to get correct index ordering
                inlet_boxes.sort(key=lambda b: b.patching_rect[0])
                outlet_boxes.sort(key=lambda b: b.patching_rect[0])

                # Process inlets: find downstream connections
                for idx, inlet_box in enumerate(inlet_boxes):
                    if inlet_box.extra_attrs.get("comment", "") != "":
                        continue  # Skip non-empty comments
                    # Find patchlines where this inlet is the source
                    downstream = None
                    for line in inner.lines:
                        if line.source_id == inlet_box.id:
                            dest_box = id_to_box.get(line.dest_id)
                            if dest_box is not None:
                                downstream = dest_box
                                break
                    if downstream is not None:
                        prefix = "signal" if inlet_box.name.endswith("~") else "signal" if downstream.name.endswith("~") else "data"
                        desc = downstream.text[:40] if downstream.text else downstream.name
                        inlet_box.extra_attrs["comment"] = f"{prefix} to {desc}"
                    else:
                        inlet_box.extra_attrs["comment"] = f"inlet {idx + 1}"

                # Process outlets: find upstream connections
                for idx, outlet_box in enumerate(outlet_boxes):
                    if outlet_box.extra_attrs.get("comment", "") != "":
                        continue  # Skip non-empty comments
                    # Find patchlines where this outlet is the destination
                    upstream = None
                    for line in inner.lines:
                        if line.dest_id == outlet_box.id:
                            src_box = id_to_box.get(line.source_id)
                            if src_box is not None:
                                upstream = src_box
                                break
                    if upstream is not None:
                        prefix = "signal" if outlet_box.name.endswith("~") else "signal" if upstream.name.endswith("~") else "data"
                        desc = upstream.text[:40] if upstream.text else upstream.name
                        outlet_box.extra_attrs["comment"] = f"{prefix} from {desc}"
                    else:
                        outlet_box.extra_attrs["comment"] = f"outlet {idx + 1}"

                # Recurse into the inner patcher
                Patcher._populate_comments_recursive(inner)

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
        from src.maxpat.codegen import parse_genexpr_io

        # Auto-detect I/O from code if not specified
        if num_inputs is None or num_outputs is None:
            detected_in, detected_out = parse_genexpr_io(code)
            if num_inputs is None:
                num_inputs = detected_in
            if num_outputs is None:
                num_outputs = detected_out

        box_id = self._gen_id()

        # Create inner Gen patcher
        inner = Patcher(db=self.db, is_subpatcher=True)
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

    @classmethod
    def from_dict(cls, data: dict[str, Any], db: "ObjectDatabase | None" = None) -> "Patcher":
        """Reconstruct a Patcher from a raw .maxpat JSON dict.

        Takes the full {"patcher": {...}} structure and rebuilds a Patcher
        with boxes and lines populated from the JSON. Boxes are created via
        Box.__new__(Box) to bypass DB validation (we are loading, not creating).

        Args:
            data: A raw .maxpat dict with top-level "patcher" key.
            db: Optional ObjectDatabase instance.

        Returns:
            Reconstructed Patcher instance.
        """
        # Fail fast on structural errors (per CONTEXT.md locked decision)
        if "patcher" not in data and "boxes" not in data:
            raise ValueError(
                "Invalid .maxpat structure: dict must contain a 'patcher' key "
                "(or be a patcher dict itself with 'boxes')"
            )
        patcher_data = data.get("patcher", data)
        boxes_raw = patcher_data.get("boxes", [])
        if not isinstance(boxes_raw, list):
            raise TypeError(
                f"Invalid .maxpat structure: 'boxes' must be a list, "
                f"got {type(boxes_raw).__name__}"
            )

        p = cls.__new__(cls)
        p.db = db if db is not None else ObjectDatabase()
        p.boxes = []
        p.lines = []
        p._is_subpatcher = False

        # Rebuild props preserving key order (include boxes/lines placeholders)
        p.props = {}
        for key, val in patcher_data.items():
            if key == "boxes":
                p.props["boxes"] = None  # placeholder -- actual data in p.boxes
            elif key == "lines":
                p.props["lines"] = None  # placeholder -- actual data in p.lines
            else:
                p.props[key] = copy.deepcopy(val)

        # Rebuild boxes
        max_id_num = 0
        for box_entry in boxes_raw:
            box_data = box_entry.get("box", {})

            box = Box.__new__(Box)
            box.id = box_data.get("id", "obj-0")
            box.maxclass = box_data.get("maxclass", "newobj")
            box.text = box_data.get("text")
            box.numinlets = box_data.get("numinlets", 1)
            box.numoutlets = box_data.get("numoutlets", 0)
            box.outlettype = box_data.get("outlettype", [])
            box.patching_rect = box_data.get("patching_rect", [0.0, 0.0, 60.0, 22.0])
            box.fontname = box_data.get("fontname", FONT_NAME)
            box.fontsize = box_data.get("fontsize", FONT_SIZE)

            # Derive name from text field or maxclass
            if box.text and box.maxclass == "newobj":
                box.name = box.text.split()[0] if box.text else ""
                parts = box.text.split()
                box.args = parts[1:] if len(parts) > 1 else []
            elif box.maxclass in ("comment", "message"):
                box.name = box.maxclass
                box.args = []
            else:
                box.name = box.maxclass
                box.args = []

            # Presentation
            box.presentation = bool(box_data.get("presentation", 0))
            pres_rect = box_data.get("presentation_rect")
            box.presentation_rect = list(pres_rect) if pres_rect else None

            # Internal fields
            box.target_id = None
            box._inner_patcher = None
            box._saved_object_attributes = box_data.get("saved_object_attributes")
            box._bpatcher_attrs = None

            # Reconstruct inner patcher if present
            if "patcher" in box_data:
                box._inner_patcher = Patcher.from_dict({"patcher": box_data["patcher"]}, db=p.db)

            # Extra attrs: everything not already handled
            _handled_keys = {
                "id", "maxclass", "text", "numinlets", "numoutlets",
                "outlettype", "patching_rect", "fontname", "fontsize",
                "presentation", "presentation_rect", "patcher",
                "saved_object_attributes",
            }
            box.extra_attrs = {
                k: v for k, v in box_data.items() if k not in _handled_keys
            }

            # Preserve raw box dict for lossless round-trip
            # Exclude nested patcher -- handled separately via _inner_patcher
            raw = dict(box_data)
            if "patcher" in raw:
                raw["patcher"] = None  # sentinel preserves key position in ordered dict
            box._raw = raw

            p.boxes.append(box)

            # Track max ID number
            try:
                id_num = int(box.id.split("-")[-1])
                if id_num > max_id_num:
                    max_id_num = id_num
            except (ValueError, IndexError):
                pass

        # Rebuild lines with color, extra attrs, and raw dict preservation
        _handled_line_keys = {"source", "destination", "order", "hidden", "midpoints", "color"}
        for line_entry in patcher_data.get("lines", []):
            line_data = line_entry.get("patchline", {})
            src = line_data.get("source", ["", 0])
            dst = line_data.get("destination", ["", 0])
            pl_extra = {k: v for k, v in line_data.items() if k not in _handled_line_keys}
            pl = Patchline(
                source_id=src[0],
                source_outlet=src[1],
                dest_id=dst[0],
                dest_inlet=dst[1],
                order=line_data.get("order", 0),
                hidden=bool(line_data.get("hidden", 0)),
                midpoints=line_data.get("midpoints"),
                color=line_data.get("color"),
                extra_attrs=pl_extra,
                _raw=dict(line_data),
            )
            p.lines.append(pl)

        p._next_id = max_id_num + 1
        return p

    def to_dict(self) -> dict[str, Any]:
        """Serialize to complete .maxpat JSON structure.

        Preserves key ordering from the original file when round-tripping.
        boxes/lines placeholders in props mark their original position.

        Returns:
            {"patcher": {...}} dict matching the .maxpat format.
        """
        result: dict[str, Any] = {}
        for key, val in self.props.items():
            if key == "boxes":
                result["boxes"] = [box.to_dict() for box in self.boxes]
            elif key == "lines":
                result["lines"] = [line.to_dict() for line in self.lines]
            else:
                result[key] = copy.deepcopy(val)
        # If boxes/lines were not in props (new patcher), append them
        if "boxes" not in result:
            result["boxes"] = [box.to_dict() for box in self.boxes]
        if "lines" not in result:
            result["lines"] = [line.to_dict() for line in self.lines]
        return {"patcher": result}

    # ------------------------------------------------------------------
    # Graph traversal / query
    # ------------------------------------------------------------------

    def _build_adj(
        self, signal_only: bool = False
    ) -> tuple[dict[str, list[tuple[str, int]]], dict[str, list[tuple[str, int]]], dict[str, Box]]:
        """Build forward and reverse adjacency dicts from self.lines.

        Args:
            signal_only: If True, skip connections where either source or
                destination box name does not end with ``~``.

        Returns:
            (forward, reverse, box_map) where:
            - forward[source_id] = sorted list of (dest_id, source_outlet) tuples
            - reverse[dest_id] = sorted list of (source_id, dest_inlet) tuples
            - box_map maps id -> Box for fast lookups
        """
        box_map: dict[str, Box] = {b.id: b for b in self.boxes}
        forward: dict[str, list[tuple[str, int]]] = {}
        reverse: dict[str, list[tuple[str, int]]] = {}

        for line in self.lines:
            src_id = line.source_id
            dst_id = line.dest_id
            if src_id not in box_map or dst_id not in box_map:
                continue
            if signal_only:
                src_box = box_map[src_id]
                dst_box = box_map[dst_id]
                if not src_box.name.endswith("~") or not dst_box.name.endswith("~"):
                    continue
            forward.setdefault(src_id, []).append((dst_id, line.source_outlet))
            reverse.setdefault(dst_id, []).append((src_id, line.dest_inlet))

        # Sort by outlet/inlet index for left-to-right ordering
        for v in forward.values():
            v.sort(key=lambda t: t[1])
        for v in reverse.values():
            v.sort(key=lambda t: t[1])

        return forward, reverse, box_map

    def downstream(self, box: Box, *, signal_only: bool = False) -> list[Box]:
        """Return all boxes reachable downstream from *box* (BFS, full chain).

        Results are ordered by outlet index (left to right) for natural
        signal-flow reading. The starting box is NOT included.

        Traversal crosses subpatcher boundaries: when a downstream neighbor
        has ``_inner_patcher``, the traversal follows through inlet objects
        inside the subpatcher and continues out through outlet objects.

        Args:
            box: Starting box.
            signal_only: If True, only follow connections where both source
                and destination box names end with ``~``.

        Returns:
            List of downstream Box objects.

        Raises:
            ValueError: If *box* is not in this patcher.
        """
        if box not in self.boxes:
            raise ValueError(
                f"Box '{box.id}' ({box.name}) is not in this patcher"
            )
        return self._traverse(box, direction="downstream", signal_only=signal_only)

    def upstream(self, box: Box, *, signal_only: bool = False) -> list[Box]:
        """Return all boxes reachable upstream from *box* (BFS, full chain).

        Results are ordered by inlet index (left to right). The starting
        box is NOT included.

        Traversal crosses subpatcher boundaries by following outlet objects
        inside subpatchers back to their sources.

        Args:
            box: Starting box.
            signal_only: If True, only follow connections where both source
                and destination box names end with ``~``.

        Returns:
            List of upstream Box objects.

        Raises:
            ValueError: If *box* is not in this patcher.
        """
        if box not in self.boxes:
            raise ValueError(
                f"Box '{box.id}' ({box.name}) is not in this patcher"
            )
        return self._traverse(box, direction="upstream", signal_only=signal_only)

    def _traverse(
        self,
        start: Box,
        *,
        direction: str,
        signal_only: bool = False,
    ) -> list[Box]:
        """BFS traversal in given direction, crossing subpatcher boundaries.

        Args:
            start: The starting box.
            direction: ``"downstream"`` or ``"upstream"``.
            signal_only: Filter to signal-only connections.

        Returns:
            Ordered list of reachable Box objects (starting box excluded).
        """
        result: list[Box] = []
        # visited tracks (id(patcher), box_id) to handle cross-patcher traversal
        visited: set[tuple[int, str]] = set()
        visited.add((id(self), start.id))

        # Queue items: (patcher, box_id) -- the patcher that owns the box
        queue: deque[tuple[Patcher, str]] = deque()

        # Seed the queue with immediate neighbors in this patcher
        self._enqueue_neighbors(
            queue, visited, result, self, start, direction, signal_only
        )

        while queue:
            patcher, box_id = queue.popleft()
            box_map = {b.id: b for b in patcher.boxes}
            current_box = box_map.get(box_id)
            if current_box is None:
                continue

            # If this box has an inner patcher, cross the boundary
            if current_box._inner_patcher is not None:
                self._cross_subpatcher(
                    queue, visited, result, patcher, current_box,
                    direction, signal_only
                )

            # Enqueue neighbors of current_box within its own patcher
            self._enqueue_neighbors(
                queue, visited, result, patcher, current_box, direction, signal_only
            )

        return result

    def _enqueue_neighbors(
        self,
        queue: deque[tuple[Patcher, str]],
        visited: set[tuple[int, str]],
        result: list[Box],
        patcher: Patcher,
        box: Box,
        direction: str,
        signal_only: bool,
    ) -> None:
        """Add unvisited neighbors of *box* to the BFS queue and result."""
        forward, reverse, box_map = patcher._build_adj(signal_only=signal_only)

        if direction == "downstream":
            neighbors = forward.get(box.id, [])
        else:
            neighbors = reverse.get(box.id, [])

        for neighbor_id, _index in neighbors:
            key = (id(patcher), neighbor_id)
            if key in visited:
                continue
            visited.add(key)
            neighbor_box = box_map.get(neighbor_id)
            if neighbor_box is not None:
                result.append(neighbor_box)
                queue.append((patcher, neighbor_id))

    def _cross_subpatcher(
        self,
        queue: deque[tuple[Patcher, str]],
        visited: set[tuple[int, str]],
        result: list[Box],
        parent_patcher: Patcher,
        sub_box: Box,
        direction: str,
        signal_only: bool,
    ) -> None:
        """Cross into a subpatcher boundary during traversal.

        For downstream: find inlet/inlet~ objects inside and continue from them.
        For upstream: find outlet/outlet~ objects inside and trace back from them.
        """
        inner = sub_box._inner_patcher
        if inner is None:
            return

        if direction == "downstream":
            # Find connections entering sub_box in parent, map to inner inlet objects
            # Then find outlet/outlet~ objects in inner, map back to parent connections
            # Step 1: find inlet objects inside
            for inner_box in inner.boxes:
                if inner_box.name in ("inlet", "inlet~"):
                    key = (id(inner), inner_box.id)
                    if key not in visited:
                        visited.add(key)
                        result.append(inner_box)
                        queue.append((inner, inner_box.id))

            # Step 2: find outlet objects that lead back to parent
            for inner_box in inner.boxes:
                if inner_box.name in ("outlet", "outlet~"):
                    key = (id(inner), inner_box.id)
                    if key not in visited:
                        visited.add(key)
                        result.append(inner_box)
                        # Outlet objects map back to parent's sub_box outlets
                        # Enqueue sub_box's downstream in parent (already handled
                        # by normal traversal since sub_box is in the result path)
        else:
            # upstream: find outlet objects inside and trace backwards
            for inner_box in inner.boxes:
                if inner_box.name in ("outlet", "outlet~"):
                    key = (id(inner), inner_box.id)
                    if key not in visited:
                        visited.add(key)
                        result.append(inner_box)
                        queue.append((inner, inner_box.id))

            # Also expose inlet objects (they connect back to parent upstream)
            for inner_box in inner.boxes:
                if inner_box.name in ("inlet", "inlet~"):
                    key = (id(inner), inner_box.id)
                    if key not in visited:
                        visited.add(key)
                        result.append(inner_box)

    def signal_path(self, box: Box) -> list[Box]:
        """Return the full signal chain passing through *box* (~ objects only).

        Combines upstream signal sources (reversed) + box + downstream signal
        sinks. Only includes boxes whose name ends with ``~``.

        Args:
            box: The box to trace the signal path through.

        Returns:
            Ordered list of ~ boxes from source to sink.

        Raises:
            ValueError: If *box* is not in this patcher.
        """
        if box not in self.boxes:
            raise ValueError(
                f"Box '{box.id}' ({box.name}) is not in this patcher"
            )
        upstream_signal = self.upstream(box, signal_only=True)
        downstream_signal = self.downstream(box, signal_only=True)
        # Reverse upstream so sources come first
        upstream_signal = list(reversed(upstream_signal))
        is_signal = box.name.endswith("~")
        if is_signal:
            return upstream_signal + [box] + downstream_signal
        else:
            return upstream_signal + downstream_signal

    def connected_components(self) -> list[list[Box]]:
        """Return groups of interconnected boxes.

        Uses undirected BFS. Disconnected objects (no connections) are
        returned as single-element groups. Components are sorted by size
        (largest first).

        Returns:
            List of Box lists, each list is a connected component.
        """
        if not self.boxes:
            return []

        # Build undirected adjacency from lines
        undirected: dict[str, set[str]] = {}
        box_map: dict[str, Box] = {b.id: b for b in self.boxes}

        for line in self.lines:
            src = line.source_id
            dst = line.dest_id
            if src in box_map and dst in box_map:
                undirected.setdefault(src, set()).add(dst)
                undirected.setdefault(dst, set()).add(src)

        visited: set[str] = set()
        components: list[list[Box]] = []

        for box in self.boxes:
            if box.id in visited:
                continue
            visited.add(box.id)

            if box.id not in undirected:
                # Disconnected box -> single-element group
                components.append([box])
                continue

            # BFS to find connected component
            component: list[Box] = [box]
            queue: deque[str] = deque()
            for neighbor in undirected.get(box.id, set()):
                if neighbor not in visited:
                    queue.append(neighbor)

            while queue:
                node_id = queue.popleft()
                if node_id in visited:
                    continue
                visited.add(node_id)
                node_box = box_map.get(node_id)
                if node_box is not None:
                    component.append(node_box)
                for neighbor in undirected.get(node_id, set()):
                    if neighbor not in visited:
                        queue.append(neighbor)

            components.append(component)

        # Sort largest first
        components.sort(key=lambda c: len(c), reverse=True)
        return components

    # ------------------------------------------------------------------
    # Patch analysis
    # ------------------------------------------------------------------

    def _classify_domain(self, box: Box) -> str:
        """Classify a box's domain using DB lookup with heuristic fallback.

        Returns one of: "Max", "MSP", "Jitter", "MC", "M4L", "Gen",
        "Packages", "RNBO", or "External/Unknown".
        """
        # Try DB lookup first
        if self.db:
            obj_data = self.db.lookup(box.name)
            if obj_data and "domain" in obj_data:
                return obj_data["domain"]

        # Heuristic fallback for unknown objects
        # Check prefixes BEFORE tilde suffix -- mc.foo~ is MC, not MSP
        name = box.name
        if name.startswith("jit."):
            return "Jitter"
        if name.startswith("mc."):
            return "MC"
        if name.startswith("live."):
            return "M4L"
        if name.endswith("~"):
            return "MSP"
        # Check maxclass for UI objects
        if box.maxclass in UI_MAXCLASSES and box.maxclass not in (
            "newobj", "comment", "message",
        ):
            return "Max"
        return "External/Unknown"

    def _resolve_send_receive_pairs(
        self,
    ) -> dict[str, tuple[list[str], list[str]]]:
        """Build mapping: channel_name -> (sender_box_ids, receiver_box_ids).

        Scans self.boxes for send~/receive~ (and aliases s~/r~, send/receive,
        s/r). Boxes with empty args are skipped.
        """
        pairs: dict[str, tuple[list[str], list[str]]] = {}
        send_names = {"send~", "send", "s~", "s"}
        recv_names = {"receive~", "receive", "r~", "r"}
        for box in self.boxes:
            if box.name in send_names and box.args:
                channel = box.args[0]
                pairs.setdefault(channel, ([], []))
                pairs[channel][0].append(box.id)
            elif box.name in recv_names and box.args:
                channel = box.args[0]
                pairs.setdefault(channel, ([], []))
                pairs[channel][1].append(box.id)
        return pairs

    def _merge_components_by_send_receive(
        self,
        components: list[list[Box]],
    ) -> list[list[Box]]:
        """Merge connected components linked by send~/receive~ name pairs.

        Uses union-find to merge components that share a send/receive channel.
        Returns merged components sorted largest-first.
        """
        if not components:
            return []

        # Build box_id -> component_index mapping
        box_to_comp: dict[str, int] = {}
        for i, comp in enumerate(components):
            for box in comp:
                box_to_comp[box.id] = i

        # Union-find
        parent = list(range(len(components)))

        def find(x: int) -> int:
            while parent[x] != x:
                parent[x] = parent[parent[x]]
                x = parent[x]
            return x

        def union(a: int, b: int) -> None:
            ra, rb = find(a), find(b)
            if ra != rb:
                parent[rb] = ra

        # Find send/receive pairs and union their components
        pairs = self._resolve_send_receive_pairs()
        for _channel, (senders, receivers) in pairs.items():
            comp_indices: set[int] = set()
            for box_id in senders + receivers:
                if box_id in box_to_comp:
                    comp_indices.add(box_to_comp[box_id])
            indices = list(comp_indices)
            for i in range(1, len(indices)):
                union(indices[0], indices[i])

        # Rebuild merged components
        merged: dict[int, list[Box]] = {}
        for i, comp in enumerate(components):
            root = find(i)
            merged.setdefault(root, []).extend(comp)

        result = list(merged.values())
        result.sort(key=lambda c: len(c), reverse=True)
        return result

    def _name_section(
        self,
        boxes: list[Box],
        section_num: int = 0,
    ) -> str:
        """Auto-name a section from its signature objects.

        Uses SECTION_SIGNATURES to find labels, picks the highest-priority
        label when multiple signatures are found. Falls back to
        "Section {section_num}" when no signatures match.

        Args:
            boxes: The boxes in the section.
            section_num: Fallback section number (used if no signature found).

        Returns:
            The section name string.
        """
        best_name: str | None = None
        best_priority = -1
        for box in boxes:
            label = SECTION_SIGNATURES.get(box.name)
            if label:
                priority = _SECTION_NAME_PRIORITY.get(label, 0)
                if priority > best_priority:
                    best_priority = priority
                    best_name = label
        if best_name:
            return best_name
        return f"Section {section_num}"

    def _analyze_sections(self) -> str:
        """Detect functional sections via connected components + send/receive merging.

        Filters out single-element groups consisting of only a comment or panel.
        Merges components linked by send~/receive~ or send/receive name pairs.
        Auto-names each section from signature objects.

        Returns:
            Markdown string with "## Sections" header.
        """
        components = self.connected_components()

        # Filter out comment/panel-only single-element groups
        filtered: list[list[Box]] = []
        for comp in components:
            if len(comp) == 1 and comp[0].maxclass in ("comment", "panel"):
                continue
            filtered.append(comp)

        # Merge via send/receive pairs
        merged = self._merge_components_by_send_receive(filtered)

        lines = ["## Sections", ""]
        if not merged:
            lines.append("(no sections detected)")
            return "\n".join(lines)

        section_counter = 1
        for comp in merged:
            name = self._name_section(comp, section_num=section_counter)
            if name.startswith("Section "):
                section_counter += 1
            obj_count = len(comp)
            # Build 1-line description from key objects (top 3 unique names)
            unique_names: list[str] = []
            seen: set[str] = set()
            for box in comp:
                if box.name not in seen and box.maxclass != "comment":
                    seen.add(box.name)
                    unique_names.append(box.name)
                    if len(unique_names) >= 3:
                        break
            desc = ", ".join(unique_names)
            lines.append(f"- **{name}** ({obj_count} objects) -- {desc}")

        return "\n".join(lines)

    # -- Complexity metrics ---------------------------------------------------

    def _count_recursive(self) -> tuple[int, int, int]:
        """Recursively count objects, connections, and max nesting depth.

        Returns:
            (total_objects, total_connections, max_depth)
        """
        total_objs = len(self.boxes)
        total_conns = len(self.lines)
        max_depth = 0
        for box in self.boxes:
            if box._inner_patcher is not None:
                sub_objs, sub_conns, sub_depth = box._inner_patcher._count_recursive()
                total_objs += sub_objs
                total_conns += sub_conns
                max_depth = max(max_depth, sub_depth + 1)
        return total_objs, total_conns, max_depth

    def _analyze_complexity(self) -> str:
        """Compute complexity metrics for the patch.

        Includes top-level counts, recursive totals, unique object types,
        and domain breakdown percentages.

        Returns:
            Markdown string with "## Overview" header.
        """
        top_objects = len(self.boxes)
        top_connections = len(self.lines)
        total_objects, total_connections, max_depth = self._count_recursive()
        unique_names = len({b.name for b in self.boxes})

        # Domain breakdown
        domain_counts: dict[str, int] = {}
        for box in self.boxes:
            domain = self._classify_domain(box)
            domain_counts[domain] = domain_counts.get(domain, 0) + 1

        lines = ["## Overview", ""]
        lines.append(f"- **Objects:** {top_objects} (top level), {total_objects} (recursive total)")
        lines.append(f"- **Connections:** {top_connections} (top level), {total_connections} (recursive total)")
        lines.append(f"- **Max nesting depth:** {max_depth}")
        lines.append(f"- **Unique object types:** {unique_names}")

        if domain_counts and top_objects > 0:
            parts = []
            for domain, count in sorted(domain_counts.items(), key=lambda x: -x[1]):
                pct = round(100 * count / top_objects)
                parts.append(f"{domain} {pct}%")
            lines.append(f"- **Domain breakdown:** {', '.join(parts)}")

        return "\n".join(lines)

    # -- Object inventory -----------------------------------------------------

    def _analyze_inventory(self) -> str:
        """Group top-level boxes by domain with counts and key objects.

        Returns:
            Markdown string with "## Object Inventory" header and table.
        """
        domain_boxes: dict[str, list[str]] = {}
        for box in self.boxes:
            domain = self._classify_domain(box)
            domain_boxes.setdefault(domain, []).append(box.name)

        lines = ["## Object Inventory", ""]
        if not domain_boxes:
            lines.append("(no objects)")
            return "\n".join(lines)

        lines.append("| Domain | Count | Key Objects |")
        lines.append("|--------|-------|-------------|")
        for domain, names in sorted(domain_boxes.items(), key=lambda x: -len(x[1])):
            count = len(names)
            top_objs = Counter(names).most_common(5)
            key_str = ", ".join(f"{n}({c})" if c > 1 else n for n, c in top_objs)
            lines.append(f"| {domain} | {count} | {key_str} |")

        return "\n".join(lines)

    # -- Signal chain tracing -------------------------------------------------

    def _analyze_signal_chains(self) -> str:
        """Trace signal chains from audio sources and render as trees.

        Finds signal chain roots (~ objects with no signal inputs), builds
        trees via DFS, and integrates send~/receive~ wireless connections.

        Returns:
            Markdown string with "## Signal Flow" header.
        """
        forward, reverse, box_map = self._build_adj(signal_only=True)

        # Find signal chain roots: ~ objects with no signal-rate inputs
        roots: list[str] = []
        for box in self.boxes:
            if not box.name.endswith("~"):
                continue
            if box.id not in reverse:
                roots.append(box.id)

        if not roots:
            return "## Signal Flow\n\n(no signal objects detected)"

        # Build send~/receive~ mapping for wireless connections
        sr_pairs = self._resolve_send_receive_pairs()
        # Map send~ box_id -> channel name for wireless annotation
        send_channels: dict[str, str] = {}
        recv_channels: dict[str, list[str]] = {}  # channel -> receiver box_ids
        for channel, (senders, receivers) in sr_pairs.items():
            for sid in senders:
                send_channels[sid] = channel
            recv_channels[channel] = receivers

        lines = ["## Signal Flow", ""]
        visited_global: set[str] = set()

        def render_tree(box_id: str, indent: int, visited: set[str]) -> None:
            box = box_map.get(box_id)
            if box is None:
                return
            prefix = "  " * indent + ("-> " if indent > 0 else "")
            label = box.text if box.text else box.name
            lines.append(f"{prefix}{label}")
            visited.add(box_id)
            visited_global.add(box_id)

            # Check if this is a send~ -- show wireless continuation
            if box_id in send_channels:
                channel = send_channels[box_id]
                for recv_id in recv_channels.get(channel, []):
                    recv_box = box_map.get(recv_id)
                    if recv_box and recv_id not in visited:
                        wireless_label = f"...-> receive~ {channel} (wireless)"
                        lines.append("  " * (indent + 1) + wireless_label)
                        visited.add(recv_id)
                        visited_global.add(recv_id)
                        # Continue tree from receive~'s downstream
                        for neighbor_id, _ in forward.get(recv_id, []):
                            if neighbor_id not in visited:
                                render_tree(neighbor_id, indent + 2, visited)
                return

            # Normal downstream children
            for neighbor_id, _ in forward.get(box_id, []):
                if neighbor_id not in visited:
                    render_tree(neighbor_id, indent + 1, visited)

        for root_id in roots:
            if root_id not in visited_global:
                render_tree(root_id, 0, set())
                lines.append("")

        return "\n".join(lines).rstrip()

    # -- Control flow paths ---------------------------------------------------

    def _analyze_control_paths(self) -> str:
        """Show notable control flow origins and their downstream chains.

        Traces from loadbang, notein, ctlin, midiin, metro, counter objects.
        Shows first 3-5 downstream objects per origin.

        Returns:
            Markdown string with "## Control Flow" header.
        """
        notable_origins = {"loadbang", "notein", "ctlin", "midiin", "metro", "counter"}
        forward, _reverse, box_map = self._build_adj(signal_only=False)

        origins: list[Box] = []
        for box in self.boxes:
            if box.name in notable_origins:
                origins.append(box)

        if not origins:
            return "## Control Flow\n\n(no notable control sources detected)"

        lines = ["## Control Flow", ""]
        for origin in origins:
            # BFS to get first few downstream objects
            chain: list[str] = []
            visited: set[str] = {origin.id}
            queue: deque[str] = deque()
            for neighbor_id, _ in forward.get(origin.id, []):
                if neighbor_id not in visited:
                    queue.append(neighbor_id)
            while queue and len(chain) < 5:
                nid = queue.popleft()
                if nid in visited:
                    continue
                visited.add(nid)
                nbox = box_map.get(nid)
                if nbox:
                    chain.append(nbox.name)
                    for next_id, _ in forward.get(nid, []):
                        if next_id not in visited:
                            queue.append(next_id)

            chain_str = " -> ".join(chain)
            if len(chain) >= 5:
                chain_str += " -> ..."
            origin_label = origin.text if origin.text else origin.name
            lines.append(f"- **{origin_label}** -> {chain_str}")

        return "\n".join(lines)

    # -- Subpatcher hierarchy -------------------------------------------------

    def _hierarchy_lines(self, depth: int = 0) -> list[str]:
        """Build indented hierarchy of subpatchers (recursive helper).

        Args:
            depth: Current indentation depth.

        Returns:
            List of formatted lines.
        """
        lines: list[str] = []
        for box in self.boxes:
            if box._inner_patcher is not None:
                indent = "  " * depth
                sub_name = box.args[0] if box.args else box.name
                inner_count = len(box._inner_patcher.boxes)
                lines.append(f"{indent}- **{sub_name}** ({inner_count} objects)")
                lines.extend(box._inner_patcher._hierarchy_lines(depth + 1))
        return lines

    def _analyze_hierarchy(self) -> str:
        """List subpatcher tree with indentation and object counts.

        Returns:
            Markdown string with "## Subpatchers" header.
        """
        hier_lines = self._hierarchy_lines()
        lines = ["## Subpatchers", ""]
        if hier_lines:
            lines.extend(hier_lines)
        else:
            lines.append("(none)")
        return "\n".join(lines)

    # -- Parameters / UI Controls ---------------------------------------------

    def _analyze_parameters(self) -> str:
        """List UI controls and parameter objects.

        Detects objects by maxclass against a known set of UI control types.
        Uses varname from extra_attrs as label when available.

        Returns:
            Markdown string with "## Parameters / UI Controls" header.
        """
        ui_controls = {
            "slider", "dial", "rslider", "multislider",
            "number", "flonum", "toggle", "button",
            "kslider", "nslider", "umenu", "textbutton",
            "tab", "gain~", "live.dial", "live.slider",
            "live.numbox", "live.toggle", "live.button",
            "live.menu", "live.tab", "live.gain~",
        }
        params: list[str] = []
        for box in self.boxes:
            if box.maxclass in ui_controls:
                varname = box.extra_attrs.get("varname", "")
                label = varname if varname else box.maxclass
                params.append(f"- {label} ({box.maxclass})")

        lines = ["## Parameters / UI Controls", ""]
        if params:
            lines.extend(params)
        else:
            lines.append("(none detected)")
        return "\n".join(lines)

    # -- Public analyze method ------------------------------------------------

    def analyze(self) -> str:
        """Produce structured Markdown summary of patch contents.

        Computes all analysis facets and assembles them into a single
        Markdown string covering: complexity overview, object inventory,
        functional sections, signal flow chains, control flow paths,
        subpatcher hierarchy, and parameters.

        Returns:
            Complete Markdown analysis string.
        """
        complexity = self._analyze_complexity()
        inventory = self._analyze_inventory()
        sections = self._analyze_sections()
        signal_chains = self._analyze_signal_chains()
        control_paths = self._analyze_control_paths()
        hierarchy = self._analyze_hierarchy()
        parameters = self._analyze_parameters()

        parts = [
            "# Patch Analysis",
            "",
            complexity,
            "",
            inventory,
            "",
            sections,
            "",
            signal_chains,
            "",
            control_paths,
            "",
            hierarchy,
            "",
            parameters,
        ]
        return "\n".join(parts)
