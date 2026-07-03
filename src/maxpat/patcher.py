"""Patcher, Box, and Patchline data model with .maxpat JSON serialization.

This module provides the core types for building MAX patches programmatically.
Patcher holds boxes and connections; Box represents a single MAX object;
Patchline represents a connection between two boxes.

All JSON output follows the .maxpat format verified in 02-RESEARCH.md.
"""

from __future__ import annotations

import copy
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

from src.maxpat.maxclass_map import resolve_maxclass, is_ui_object, UI_MAXCLASSES
from src.maxpat.graph import GraphMixin
from src.maxpat.analysis import AnalysisMixin, SECTION_SIGNATURES, _SECTION_NAME_PRIORITY
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
    ) -> None:
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
        allowed_packages: list[str] | None = None,
    ) -> None:
        """Create a Box.

        Args:
            name: MAX object name (e.g., "cycle~", "toggle", "pack").
            args: Object arguments (e.g., ["440"] for cycle~ 440).
            box_id: Unique box identifier (e.g., "obj-1").
            db: ObjectDatabase instance for lookup. Required for non-UI
                objects to verify existence and get I/O counts.
            x: Horizontal position.
            y: Vertical position.
            allowed_packages: Package filter. None=allow all (default),
                []=core only, ["BEAP"]=core+BEAP objects.

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
            obj_data = db.lookup(name, allowed_packages=allowed_packages)

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

    @property
    def right_edge(self) -> float:
        """X coordinate of the box's right edge (x + width)."""
        return self.patching_rect[0] + self.patching_rect[2]

    @property
    def bottom_edge(self) -> float:
        """Y coordinate of the box's bottom edge (y + height)."""
        return self.patching_rect[1] + self.patching_rect[3]

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


from src.maxpat.builders import BuildersMixin


class Patcher(GraphMixin, AnalysisMixin, BuildersMixin):
    """A MAX patcher containing boxes and patchlines.

    The top-level container for a .maxpat file. Serializes to the complete
    .maxpat JSON structure with patcher wrapper, boxes array, and lines array.

    Inherits graph traversal (GraphMixin) and analysis (AnalysisMixin) methods
    via mixin classes for maintainability.
    """

    def __init__(
        self,
        db: ObjectDatabase | None = None,
        is_subpatcher: bool = False,
        allowed_packages: list[str] | None = None,
    ) -> None:
        """Create a new Patcher.

        Args:
            db: ObjectDatabase instance. Created automatically if None.
            is_subpatcher: If True, uses SUBPATCHER_RECT for window size.
            allowed_packages: Package filter passed to Box creation.
                None=allow all (default), []=core only,
                ["BEAP"]=core+BEAP objects.
        """
        if db is None:
            db = ObjectDatabase()

        self.db = db
        self.allowed_packages = allowed_packages
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

    def bring_to_front(self, box: Box) -> None:
        """Move box to index 0 in boxes array (renders on top of all other objects).

        In .maxpat files, z-order is implicit: objects EARLIER in the boxes
        array render on top of later ones. This moves the box to index 0.

        Args:
            box: Box to bring to front.

        Raises:
            ValueError: If box is not in this patcher.
        """
        try:
            self.boxes.remove(box)
        except ValueError:
            raise ValueError(f"Box {box.id!r} not in this patcher")
        self.boxes.insert(0, box)

    def send_to_back(self, box: Box) -> None:
        """Move box to end of boxes array (renders behind all other objects).

        In .maxpat files, z-order is implicit: objects LATER in the boxes
        array render behind earlier ones. This moves the box to the last
        position.

        Args:
            box: Box to send to back.

        Raises:
            ValueError: If box is not in this patcher.
        """
        try:
            self.boxes.remove(box)
        except ValueError:
            raise ValueError(f"Box {box.id!r} not in this patcher")
        self.boxes.append(box)

    def set_z_index(self, box: Box, index: int) -> None:
        """Move box to a specific position in the boxes array for z-order control.

        Index 0 = on top of everything (same as bring_to_front).
        Index -1 or len(boxes) = behind everything (same as send_to_back).
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
            # Sync presentation attrs to Python fields so to_dict()
            # round-trip path (which reads box.presentation /
            # box.presentation_rect) stays consistent with _raw.
            if "presentation" in extra_attrs:
                box.presentation = bool(extra_attrs["presentation"])
            if "presentation_rect" in extra_attrs:
                box.presentation_rect = list(extra_attrs["presentation_rect"])
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

        # Create replacement box at old position (skip overlap -- intentional placement)
        new_box = self.add_box(new_name, args=args, x=old_x, y=old_y, skip_overlap_check=True)

        return EditResult(box=new_box, orphaned=orphaned)

    def replace_box_safe(
        self,
        old_box: Box,
        new_name: str,
        *,
        args: list[str] | None = None,
        rewire: str = "auto",
    ) -> EditResult:
        """Replace a box and auto-rewire connections when I/O layout matches.

        Safer default alternative to ``replace_box``. Delegates to
        ``replace_box`` internally to capture orphans, then in ``"auto"``
        mode reconnects every orphan by index when the new box has the
        same inlet AND outlet count as the old box. On match, the returned
        ``EditResult.orphaned`` is empty -- connections are preserved
        transparently. On I/O mismatch the orphans are returned unchanged
        (no exception), so callers always have something to act on.
        Use ``rewire="manual"`` to opt back into the explicit-orphan
        workflow of ``replace_box`` regardless of I/O match.

        Mirrors P1-1 in 260427-hox FINDINGS. Use this in preference to
        ``replace_box`` for new code; ``replace_box`` is preserved for
        explicit orphan handling.

        Args:
            old_box: The box to replace (must be in this patcher).
            new_name: Name of the replacement object (e.g., "saw~").
            args: Optional arguments for the new object.
            rewire: ``"auto"`` (default) auto-reconnects orphans by index
                when I/O counts match; on mismatch falls back to returning
                orphans. ``"manual"`` always returns orphans without
                rewiring (same shape as ``replace_box``).

        Returns:
            EditResult with the new box. ``orphaned`` is empty on
            successful auto-rewire; populated on manual mode or I/O
            mismatch.

        Raises:
            ValueError: If ``old_box`` is not in this patcher (raised by
                the underlying ``replace_box``), or if ``rewire`` is not
                ``"auto"`` or ``"manual"``.
        """
        if rewire not in ("auto", "manual"):
            raise ValueError(
                f"rewire must be 'auto' or 'manual', got {rewire!r}"
            )

        # Capture old box I/O counts BEFORE delegating, since replace_box
        # removes the old box and we need the counts to compare against
        # the new box's I/O.
        old_numinlets = old_box.numinlets
        old_numoutlets = old_box.numoutlets
        old_id = old_box.id

        # Delegate -- handles validation, orphan capture, removal, and
        # creating the new box at the old position.
        result = self.replace_box(old_box, new_name, args=args)

        if rewire == "manual":
            return result

        # Auto mode: rewire only when I/O layout matches exactly.
        if (
            result.box.numinlets == old_numinlets
            and result.box.numoutlets == old_numoutlets
        ):
            # Build an id->box map once for O(1) resolution. The new box
            # stands in for the old id on either side of every orphan
            # (handles self-loops naturally).
            box_by_id = {b.id: b for b in self.boxes}
            for o in result.orphaned:
                src_id = o["source_id"]
                dst_id = o["dest_id"]
                src_box = result.box if src_id == old_id else box_by_id[src_id]
                dst_box = result.box if dst_id == old_id else box_by_id[dst_id]
                self.add_connection(
                    src_box, o["source_outlet"], dst_box, o["dest_inlet"]
                )
            return EditResult(box=result.box, orphaned=[])

        # Mismatch: return orphans intact (caller handles rewiring).
        return result

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

        # Create the new box (skip overlap -- _auto_position handles positioning)
        new_box = self.add_box(name, args=args, skip_overlap_check=True)

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

        Nudges down by 15px on collision to preserve horizontal signal flow.
        Wraps to the next column (x += 15, y resets) when y > 2400.

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
        start_y = y

        for _ in range(200):
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
            # Nudge down first (preserves horizontal signal flow)
            y += 15.0
            if y > 2400:
                y = start_y
                x += 15.0
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

    def get_inlets(self) -> list[Box]:
        """Return all inlet objects in this patcher, sorted left-to-right.

        Used to find inlet objects inside subpatchers for connecting to them.
        All inlet objects have identical text="inlet", so they cannot be
        distinguished by text -- use list index instead.

        Returns:
            List of inlet Box objects sorted by x-position (leftmost first).
        """
        inlets = [b for b in self.boxes if b.maxclass == "inlet"]
        inlets.sort(key=lambda b: b.patching_rect[0])
        return inlets

    def get_outlets(self) -> list[Box]:
        """Return all outlet objects in this patcher, sorted left-to-right.

        Used to find outlet objects inside subpatchers for connecting from them.
        All outlet objects have identical text="outlet", so they cannot be
        distinguished by text -- use list index instead.

        Returns:
            List of outlet Box objects sorted by x-position (leftmost first).
        """
        outlets = [b for b in self.boxes if b.maxclass == "outlet"]
        outlets.sort(key=lambda b: b.patching_rect[0])
        return outlets

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
        p.allowed_packages = None
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
