"""Patcher, Box, and Patchline data model with .maxpat JSON serialization.

This module provides the core types for building MAX patches programmatically.
Patcher holds boxes and connections; Box represents a single MAX object;
Patchline represents a connection between two boxes.

All JSON output follows the .maxpat format verified in 02-RESEARCH.md.
"""

from __future__ import annotations

import copy
from typing import Any

from src.maxpat.defaults import (
    DEFAULT_PATCHER_PROPS,
    FONT_NAME,
    FONT_SIZE,
    GEN_PATCHER_BGCOLOR,
    SUBPATCHER_RECT,
)
from src.maxpat.maxclass_map import resolve_maxclass, is_ui_object, UI_MAXCLASSES
from src.maxpat.sizing import calculate_box_size
from src.maxpat.db_lookup import ObjectDatabase


class Patchline:
    """A connection between two boxes in a MAX patcher.

    Serializes to: {"patchline": {"source": [id, outlet], "destination": [id, inlet], "order": N}}
    """

    def __init__(
        self,
        source_id: str,
        source_outlet: int,
        dest_id: str,
        dest_inlet: int,
        order: int = 0,
        hidden: bool = False,
    ):
        self.source_id = source_id
        self.source_outlet = source_outlet
        self.dest_id = dest_id
        self.dest_inlet = dest_inlet
        self.order = order
        self.hidden = hidden

    def to_dict(self) -> dict[str, Any]:
        """Serialize to .maxpat patchline JSON structure."""
        d: dict[str, Any] = {
            "source": [self.source_id, self.source_outlet],
            "destination": [self.dest_id, self.dest_inlet],
            "order": self.order,
        }
        if self.hidden:
            d["hidden"] = 1
        return {"patchline": d}


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

        # Internal: track if this is a subpatcher/bpatcher with embedded patcher
        self._inner_patcher: Patcher | None = None
        self._saved_object_attributes: dict[str, Any] | None = None
        self._bpatcher_attrs: dict[str, Any] | None = None

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

        Returns:
            {"box": {...}} dict matching the .maxpat format.
        """
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

    def add_comment(self, text: str, x: float = 0.0, y: float = 0.0) -> Box:
        """Add a comment box to the patcher.

        Args:
            text: Comment text.
            x: Horizontal position.
            y: Vertical position.

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
        self.boxes.append(box)
        return box

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
    ) -> Patchline:
        """Add a connection (patchline) between two boxes.

        Args:
            src_box: Source box.
            src_outlet: Source outlet index.
            dst_box: Destination box.
            dst_inlet: Destination inlet index.
            order: Execution order (default 0).
            hidden: Whether the connection is hidden.

        Returns:
            The created Patchline.
        """
        pl = Patchline(
            source_id=src_box.id,
            source_outlet=src_outlet,
            dest_id=dst_box.id,
            dest_inlet=dst_inlet,
            order=order,
            hidden=hidden,
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
            inlet_box.extra_attrs["comment"] = ""

        # Add outlet objects inside the subpatcher
        for i in range(outlets):
            outlet_box = inner.add_box("outlet", x=50.0 + i * inlet_spacing, y=250.0)
            outlet_box.extra_attrs["comment"] = ""

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
        parent_box.extra_attrs = {}
        parent_box._inner_patcher = inner
        parent_box._saved_object_attributes = {
            "description": "",
            "digest": "",
            "globalpatchername": "",
            "tags": "",
        }
        parent_box._bpatcher_attrs = None

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
        bpatch_box.extra_attrs = {}
        bpatch_box._saved_object_attributes = None

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
            in_box.extra_attrs = {}
            in_box._inner_patcher = None
            in_box._saved_object_attributes = None
            in_box._bpatcher_attrs = None
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
        codebox.extra_attrs = {
            "code": code,
            "fontname": FONT_NAME,
            "fontsize": FONT_SIZE,
        }
        codebox._inner_patcher = None
        codebox._saved_object_attributes = None
        codebox._bpatcher_attrs = None
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
            out_box.extra_attrs = {}
            out_box._inner_patcher = None
            out_box._saved_object_attributes = None
            out_box._bpatcher_attrs = None
            inner.boxes.append(out_box)
            out_boxes.append(out_box)

        # Add patchlines: in -> codebox
        for i, in_box in enumerate(in_boxes):
            inner.add_connection(in_box, 0, codebox, i)

        # Add patchlines: codebox -> out
        for i, out_box in enumerate(out_boxes):
            inner.add_connection(codebox, i, out_box, 0)

        # Create the parent gen~ box
        w, h = calculate_box_size("gen~", "gen~")

        parent_box = Box.__new__(Box)
        parent_box.name = "gen~"
        parent_box.args = []
        parent_box.id = box_id
        parent_box.maxclass = "gen~"
        parent_box.text = "gen~"
        parent_box.numinlets = num_inputs
        parent_box.numoutlets = num_outputs
        parent_box.outlettype = ["signal"] * num_outputs
        parent_box.patching_rect = [x, y, w, h]
        parent_box.fontname = FONT_NAME
        parent_box.fontsize = FONT_SIZE
        parent_box.presentation = False
        parent_box.presentation_rect = None
        parent_box.extra_attrs = {}
        parent_box._inner_patcher = inner
        parent_box._saved_object_attributes = None
        parent_box._bpatcher_attrs = None

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
        box.extra_attrs = {}
        box._inner_patcher = None
        box._saved_object_attributes = None
        box._bpatcher_attrs = None

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
        box.extra_attrs = {}
        box._inner_patcher = None
        box._saved_object_attributes = None
        box._bpatcher_attrs = None

        self.boxes.append(box)
        return (box, code)

    def to_dict(self) -> dict[str, Any]:
        """Serialize to complete .maxpat JSON structure.

        Returns:
            {"patcher": {...}} dict matching the .maxpat format.
        """
        props = copy.deepcopy(self.props)
        props["boxes"] = [box.to_dict() for box in self.boxes]
        props["lines"] = [line.to_dict() for line in self.lines]
        return {"patcher": props}
