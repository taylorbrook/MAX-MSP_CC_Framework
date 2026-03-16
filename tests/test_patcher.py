"""Tests for Patcher, Box, and Patchline data model with JSON serialization.

Covers requirements PAT-01 (valid .maxpat JSON), PAT-02 (patcher wrapper,
boxes, lines), and PAT-03 (subpatcher/bpatcher nesting).
"""

import json

import pytest

from src.maxpat.patcher import Patcher, Box, Patchline


class TestPatcherStructure:
    """PAT-01/PAT-02: Patcher.to_dict() produces valid .maxpat JSON structure."""

    def test_empty_patcher_has_patcher_wrapper(self):
        """Top-level dict has single 'patcher' key."""
        p = Patcher()
        d = p.to_dict()
        assert "patcher" in d
        assert isinstance(d["patcher"], dict)

    def test_empty_patcher_has_boxes_and_lines(self):
        """Patcher dict contains boxes and lines arrays."""
        p = Patcher()
        d = p.to_dict()
        patcher = d["patcher"]
        assert "boxes" in patcher
        assert "lines" in patcher
        assert isinstance(patcher["boxes"], list)
        assert isinstance(patcher["lines"], list)

    def test_empty_patcher_boxes_and_lines_empty(self):
        """New patcher has no boxes or lines."""
        p = Patcher()
        d = p.to_dict()
        assert len(d["patcher"]["boxes"]) == 0
        assert len(d["patcher"]["lines"]) == 0

    def test_patcher_has_max9_defaults(self):
        """Patcher includes MAX 9 fileversion and appversion."""
        p = Patcher()
        d = p.to_dict()
        patcher = d["patcher"]
        assert patcher["fileversion"] == 1
        assert patcher["appversion"]["major"] == 9
        assert patcher["classnamespace"] == "box"

    def test_patcher_has_rect(self):
        """Patcher has rect property."""
        p = Patcher()
        d = p.to_dict()
        assert "rect" in d["patcher"]
        assert len(d["patcher"]["rect"]) == 4

    def test_patcher_has_font_defaults(self):
        """Patcher has default font settings."""
        p = Patcher()
        d = p.to_dict()
        patcher = d["patcher"]
        assert patcher["default_fontname"] == "Arial"
        assert patcher["default_fontsize"] == 12.0

    def test_patcher_to_dict_is_valid_json(self):
        """to_dict() output can be serialized and deserialized as JSON."""
        p = Patcher()
        b1 = p.add_box("cycle~", args=["440"])
        b2 = p.add_box("ezdac~")
        p.add_connection(b1, 0, b2, 0)
        d = p.to_dict()
        json_str = json.dumps(d)
        reparsed = json.loads(json_str)
        assert reparsed["patcher"]["boxes"] is not None


class TestBoxSerialization:
    """PAT-02: Box objects correctly included in boxes array."""

    def test_add_box_returns_box(self):
        """add_box returns a Box instance."""
        p = Patcher()
        b = p.add_box("cycle~", args=["440"])
        assert isinstance(b, Box)

    def test_box_in_boxes_array(self):
        """Added box appears in patcher boxes array."""
        p = Patcher()
        p.add_box("cycle~", args=["440"])
        d = p.to_dict()
        assert len(d["patcher"]["boxes"]) == 1

    def test_non_ui_box_has_newobj_maxclass(self):
        """Non-UI object gets maxclass 'newobj'."""
        p = Patcher()
        b = p.add_box("cycle~", args=["440"])
        bd = b.to_dict()
        assert bd["box"]["maxclass"] == "newobj"

    def test_non_ui_box_has_text_field(self):
        """Non-UI object has text field with name and args."""
        p = Patcher()
        b = p.add_box("cycle~", args=["440"])
        bd = b.to_dict()
        assert bd["box"]["text"] == "cycle~ 440"

    def test_non_ui_box_has_font_fields(self):
        """Non-UI object has fontname and fontsize."""
        p = Patcher()
        b = p.add_box("cycle~")
        bd = b.to_dict()
        assert bd["box"]["fontname"] == "Arial"
        assert bd["box"]["fontsize"] == 12.0

    def test_non_ui_box_has_patching_rect(self):
        """Box has patching_rect with 4 values."""
        p = Patcher()
        b = p.add_box("cycle~", args=["440"])
        bd = b.to_dict()
        rect = bd["box"]["patching_rect"]
        assert len(rect) == 4
        assert all(isinstance(v, float) for v in rect)

    def test_non_ui_box_has_io_counts(self):
        """Box has numinlets and numoutlets from database."""
        p = Patcher()
        b = p.add_box("cycle~")
        bd = b.to_dict()
        assert bd["box"]["numinlets"] == 2
        assert bd["box"]["numoutlets"] == 1

    def test_non_ui_box_has_outlettype(self):
        """Box has outlettype array matching outlet count."""
        p = Patcher()
        b = p.add_box("cycle~")
        bd = b.to_dict()
        assert bd["box"]["outlettype"] == ["signal"]

    def test_non_ui_box_has_id(self):
        """Box has a unique string ID."""
        p = Patcher()
        b = p.add_box("cycle~")
        bd = b.to_dict()
        assert isinstance(bd["box"]["id"], str)
        assert bd["box"]["id"].startswith("obj-")

    def test_ui_box_has_own_maxclass(self):
        """UI object uses its own name as maxclass."""
        p = Patcher()
        b = p.add_box("toggle")
        bd = b.to_dict()
        assert bd["box"]["maxclass"] == "toggle"

    def test_ui_box_has_parameter_enable(self):
        """UI objects include parameter_enable field."""
        p = Patcher()
        b = p.add_box("toggle")
        bd = b.to_dict()
        assert "parameter_enable" in bd["box"]
        assert bd["box"]["parameter_enable"] == 0

    def test_ui_box_has_io_counts(self):
        """UI box has correct numinlets/numoutlets from database."""
        p = Patcher()
        b = p.add_box("toggle")
        bd = b.to_dict()
        assert bd["box"]["numinlets"] == 1
        assert bd["box"]["numoutlets"] == 1
        assert bd["box"]["outlettype"] == [""]  # control outlets use "" per research

    def test_ui_box_fixed_size(self):
        """UI box has fixed-size patching_rect."""
        p = Patcher()
        b = p.add_box("toggle")
        bd = b.to_dict()
        rect = bd["box"]["patching_rect"]
        # toggle is 24x24
        assert rect[2] == 24.0
        assert rect[3] == 24.0


class TestCommentAndMessageBoxes:
    """Comment and message box serialization."""

    def test_comment_box_maxclass(self):
        """Comment box has maxclass 'comment'."""
        p = Patcher()
        b = p.add_comment("// OSCILLATOR")
        bd = b.to_dict()
        assert bd["box"]["maxclass"] == "comment"

    def test_comment_box_has_text(self):
        """Comment box has text field."""
        p = Patcher()
        b = p.add_comment("// OSCILLATOR")
        bd = b.to_dict()
        assert bd["box"]["text"] == "// OSCILLATOR"

    def test_comment_box_has_font(self):
        """Comment box has font fields."""
        p = Patcher()
        b = p.add_comment("test")
        bd = b.to_dict()
        assert bd["box"]["fontname"] == "Arial"
        assert bd["box"]["fontsize"] == 12.0

    def test_comment_box_zero_outlets(self):
        """Comment box has 0 outlets (per database)."""
        p = Patcher()
        b = p.add_comment("test")
        bd = b.to_dict()
        assert bd["box"]["numoutlets"] == 0

    def test_message_box_maxclass(self):
        """Message box has maxclass 'message'."""
        p = Patcher()
        b = p.add_message("440")
        bd = b.to_dict()
        assert bd["box"]["maxclass"] == "message"

    def test_message_box_has_text(self):
        """Message box has text field."""
        p = Patcher()
        b = p.add_message("440")
        bd = b.to_dict()
        assert bd["box"]["text"] == "440"

    def test_message_box_io_counts(self):
        """Message box has 2 inlets, 1 outlet."""
        p = Patcher()
        b = p.add_message("440")
        bd = b.to_dict()
        assert bd["box"]["numinlets"] == 2
        assert bd["box"]["numoutlets"] == 1


class TestPatchlineSerialization:
    """PAT-02: Patchline objects in lines array."""

    def test_connection_in_lines_array(self):
        """add_connection creates patchline in lines array."""
        p = Patcher()
        b1 = p.add_box("cycle~", args=["440"])
        b2 = p.add_box("ezdac~")
        p.add_connection(b1, 0, b2, 0)
        d = p.to_dict()
        assert len(d["patcher"]["lines"]) == 1

    def test_patchline_source_destination(self):
        """Patchline has correct source and destination."""
        p = Patcher()
        b1 = p.add_box("cycle~", args=["440"])
        b2 = p.add_box("ezdac~")
        pl = p.add_connection(b1, 0, b2, 0)
        pld = pl.to_dict()
        assert pld["patchline"]["source"] == [b1.id, 0]
        assert pld["patchline"]["destination"] == [b2.id, 0]

    def test_patchline_omits_order_when_zero(self):
        """Patchline omits order field when order=0 (matches MAX output)."""
        p = Patcher()
        b1 = p.add_box("cycle~")
        b2 = p.add_box("ezdac~")
        pl = p.add_connection(b1, 0, b2, 0)
        pld = pl.to_dict()
        assert "order" not in pld["patchline"]

    def test_patchline_includes_nonzero_order(self):
        """Patchline includes order field when order is non-zero."""
        p = Patcher()
        b1 = p.add_box("cycle~")
        b2 = p.add_box("ezdac~")
        pl = p.add_connection(b1, 0, b2, 0, order=1)
        pld = pl.to_dict()
        assert pld["patchline"]["order"] == 1

    def test_patchline_hidden(self):
        """Hidden patchline includes hidden field."""
        p = Patcher()
        b1 = p.add_box("cycle~")
        b2 = p.add_box("ezdac~")
        pl = p.add_connection(b1, 0, b2, 0, hidden=True)
        pld = pl.to_dict()
        assert pld["patchline"].get("hidden") == 1

    def test_multiple_connections(self):
        """Multiple connections all appear in lines array."""
        p = Patcher()
        osc = p.add_box("cycle~", args=["440"])
        dac = p.add_box("ezdac~")
        p.add_connection(osc, 0, dac, 0)
        p.add_connection(osc, 0, dac, 1)
        d = p.to_dict()
        assert len(d["patcher"]["lines"]) == 2


class TestVariableIO:
    """Variable I/O: inlet/outlet counts match arguments."""

    def test_trigger_three_args(self):
        """Trigger with 3 args has 1 inlet and 3 outlets."""
        p = Patcher()
        b = p.add_box("trigger", args=["b", "i", "f"])
        bd = b.to_dict()
        assert bd["box"]["numinlets"] == 1
        assert bd["box"]["numoutlets"] == 3

    def test_pack_three_args(self):
        """Pack with 3 args has 3 inlets and 1 outlet."""
        p = Patcher()
        b = p.add_box("pack", args=["0", "0", "0"])
        bd = b.to_dict()
        assert bd["box"]["numinlets"] == 3
        assert bd["box"]["numoutlets"] == 1

    def test_route_two_args(self):
        """Route with 2 args has 1 inlet and 3 outlets (2 + unmatched)."""
        p = Patcher()
        b = p.add_box("route", args=["foo", "bar"])
        bd = b.to_dict()
        assert bd["box"]["numinlets"] == 1
        assert bd["box"]["numoutlets"] == 3

    def test_trigger_alias_t(self):
        """Alias 't' works like 'trigger' for variable I/O."""
        p = Patcher()
        b = p.add_box("t", args=["b", "b"])
        bd = b.to_dict()
        assert bd["box"]["numinlets"] == 1
        assert bd["box"]["numoutlets"] == 2


class TestPresentationMode:
    """Presentation mode adds presentation and presentation_rect."""

    def test_presentation_on_box(self):
        """Box with presentation=True includes presentation in dict."""
        p = Patcher()
        b = p.add_box("slider")
        b.presentation = True
        b.presentation_rect = [20.0, 20.0, 20.0, 140.0]
        bd = b.to_dict()
        assert bd["box"]["presentation"] == 1
        assert bd["box"]["presentation_rect"] == [20.0, 20.0, 20.0, 140.0]

    def test_no_presentation_by_default(self):
        """Box without presentation=True does not include presentation."""
        p = Patcher()
        b = p.add_box("slider")
        bd = b.to_dict()
        assert "presentation" not in bd["box"]
        assert "presentation_rect" not in bd["box"]


class TestIDUniqueness:
    """Multiple boxes get unique IDs."""

    def test_unique_ids(self):
        """Each box gets a unique ID."""
        p = Patcher()
        boxes = [p.add_box("cycle~") for _ in range(10)]
        ids = {b.id for b in boxes}
        assert len(ids) == 10

    def test_id_format(self):
        """IDs follow obj-N format."""
        p = Patcher()
        b = p.add_box("cycle~")
        assert b.id.startswith("obj-")
        # The numeric part should be an integer
        num_part = b.id.split("-")[1]
        assert num_part.isdigit()


class TestSubpatcher:
    """PAT-03: Subpatcher generation with nested patcher."""

    def test_add_subpatcher_returns_tuple(self):
        """add_subpatcher returns (parent_box, inner_patcher) tuple."""
        p = Patcher()
        result = p.add_subpatcher("my_sub")
        assert isinstance(result, tuple)
        assert len(result) == 2
        parent_box, inner_patcher = result
        assert isinstance(parent_box, Box)
        assert isinstance(inner_patcher, Patcher)

    def test_subpatcher_parent_box_text(self):
        """Parent box has text 'p my_sub'."""
        p = Patcher()
        parent_box, _ = p.add_subpatcher("my_sub")
        bd = parent_box.to_dict()
        assert bd["box"]["text"] == "p my_sub"

    def test_subpatcher_parent_box_maxclass(self):
        """Parent box has maxclass 'newobj'."""
        p = Patcher()
        parent_box, _ = p.add_subpatcher("my_sub")
        bd = parent_box.to_dict()
        assert bd["box"]["maxclass"] == "newobj"

    def test_subpatcher_has_embedded_patcher(self):
        """Parent box dict includes 'patcher' key with nested structure."""
        p = Patcher()
        parent_box, inner = p.add_subpatcher("my_sub")
        bd = parent_box.to_dict()
        assert "patcher" in bd["box"]
        inner_dict = bd["box"]["patcher"]
        assert "boxes" in inner_dict
        assert "lines" in inner_dict

    def test_subpatcher_has_inlet_outlet_objects(self):
        """Inner patcher has inlet and outlet objects."""
        p = Patcher()
        parent_box, inner = p.add_subpatcher("my_sub", inlets=1, outlets=1)
        inner_dict = parent_box.to_dict()["box"]["patcher"]
        maxclasses = [b["box"]["maxclass"] for b in inner_dict["boxes"]]
        assert "inlet" in maxclasses
        assert "outlet" in maxclasses

    def test_subpatcher_inlet_count_matches(self):
        """Parent box numinlets matches number of inlet objects inside."""
        p = Patcher()
        parent_box, inner = p.add_subpatcher("my_sub", inlets=2, outlets=3)
        bd = parent_box.to_dict()
        assert bd["box"]["numinlets"] == 2
        assert bd["box"]["numoutlets"] == 3

    def test_subpatcher_saved_object_attributes(self):
        """Parent box has saved_object_attributes."""
        p = Patcher()
        parent_box, _ = p.add_subpatcher("my_sub")
        bd = parent_box.to_dict()
        assert "saved_object_attributes" in bd["box"]

    def test_subpatcher_uses_subpatcher_rect(self):
        """Inner patcher uses SUBPATCHER_RECT for its rect."""
        p = Patcher()
        parent_box, inner = p.add_subpatcher("my_sub")
        inner_dict = parent_box.to_dict()["box"]["patcher"]
        assert inner_dict["rect"] == [100.0, 100.0, 400.0, 300.0]

    def test_inner_patcher_can_have_boxes(self):
        """Inner patcher can have boxes added to it."""
        p = Patcher()
        parent_box, inner = p.add_subpatcher("my_sub", inlets=1, outlets=1)
        inner.add_box("cycle~", args=["440"])
        inner_dict = parent_box.to_dict()["box"]["patcher"]
        # Inner patcher has inlet + outlet + cycle~ = 3 boxes
        assert len(inner_dict["boxes"]) == 3

    def test_multiple_inlets_subpatcher(self):
        """Subpatcher with multiple inlets creates corresponding inlet objects."""
        p = Patcher()
        parent_box, inner = p.add_subpatcher("multi_in", inlets=3, outlets=1)
        inner_dict = parent_box.to_dict()["box"]["patcher"]
        inlet_count = sum(1 for b in inner_dict["boxes"] if b["box"]["maxclass"] == "inlet")
        assert inlet_count == 3


class TestBpatcher:
    """PAT-03: bpatcher generation (file reference and embedded)."""

    def test_bpatcher_file_reference(self):
        """bpatcher with filename references external file."""
        p = Patcher()
        b = p.add_bpatcher("my_control.maxpat")
        bd = b.to_dict()
        assert bd["box"]["maxclass"] == "bpatcher"
        assert bd["box"]["name"] == "my_control.maxpat"

    def test_bpatcher_has_required_attrs(self):
        """bpatcher has bgmode, border, clickthrough, etc."""
        p = Patcher()
        b = p.add_bpatcher("my_control.maxpat")
        bd = b.to_dict()
        box = bd["box"]
        assert "bgmode" in box
        assert "border" in box
        assert "clickthrough" in box
        assert "enablehscroll" in box
        assert "enablevscroll" in box
        assert "lockeddragscroll" in box
        assert "offset" in box
        assert "viewvisibility" in box

    def test_bpatcher_embedded(self):
        """Embedded bpatcher has inner patcher."""
        p = Patcher()
        result = p.add_bpatcher(embedded=True)
        assert isinstance(result, tuple)
        parent_box, inner = result
        bd = parent_box.to_dict()
        assert bd["box"]["maxclass"] == "bpatcher"
        assert "patcher" in bd["box"]

    def test_bpatcher_args(self):
        """bpatcher can have args."""
        p = Patcher()
        b = p.add_bpatcher("my_control.maxpat", args=["1", "2"])
        bd = b.to_dict()
        assert bd["box"]["args"] == ["1", "2"]


class TestEndToEndSerialization:
    """End-to-end: create patch, serialize, verify JSON."""

    def test_simple_patch_roundtrip(self):
        """Create a simple patch and verify JSON roundtrip."""
        p = Patcher()
        osc = p.add_box("cycle~", args=["440"])
        dac = p.add_box("ezdac~")
        p.add_connection(osc, 0, dac, 0)
        p.add_connection(osc, 0, dac, 1)

        d = p.to_dict()
        json_str = json.dumps(d, indent=2)
        reparsed = json.loads(json_str)

        patcher = reparsed["patcher"]
        assert len(patcher["boxes"]) == 2
        assert len(patcher["lines"]) == 2
        assert patcher["fileversion"] == 1

    def test_patch_with_ui_and_comments(self):
        """Patch with mixed UI, non-UI, comment, and message boxes."""
        p = Patcher()
        p.add_comment("// OSCILLATOR")
        osc = p.add_box("cycle~", args=["440"])
        gain = p.add_box("*~", args=["0.5"])
        msg = p.add_message("440")
        toggle = p.add_box("toggle")
        dac = p.add_box("ezdac~")

        p.add_connection(osc, 0, gain, 0)
        p.add_connection(gain, 0, dac, 0)

        d = p.to_dict()
        json_str = json.dumps(d, indent=2)
        reparsed = json.loads(json_str)

        assert len(reparsed["patcher"]["boxes"]) == 6
        assert len(reparsed["patcher"]["lines"]) == 2


class TestFindBox:
    """find_box() returns first matching Box or None."""

    def test_find_by_id(self):
        """find_box(id=...) returns box with exact ID match."""
        p = Patcher()
        b1 = p.add_box("cycle~", args=["440"])
        b2 = p.add_box("ezdac~")
        result = p.find_box(id=b1.id)
        assert result is b1

    def test_find_by_id_not_found(self):
        """find_box(id=...) returns None when ID not found."""
        p = Patcher()
        p.add_box("cycle~")
        result = p.find_box(id="obj-999")
        assert result is None

    def test_find_by_name(self):
        """find_box(name=...) returns first box with matching name."""
        p = Patcher()
        b1 = p.add_box("cycle~", args=["440"])
        b2 = p.add_box("ezdac~")
        result = p.find_box(name="cycle~")
        assert result is b1

    def test_find_by_name_alias_forward(self):
        """find_box(name='t') also finds boxes named 'trigger' via alias."""
        p = Patcher()
        b1 = p.add_box("trigger", args=["b", "i"])
        result = p.find_box(name="t")
        assert result is b1

    def test_find_by_name_alias_reverse(self):
        """find_box(name='trigger') finds boxes named 't' via reverse alias."""
        p = Patcher()
        b1 = p.add_box("t", args=["b", "i"])
        result = p.find_box(name="trigger")
        assert result is b1

    def test_find_by_maxclass(self):
        """find_box(maxclass=...) returns first box with matching maxclass."""
        p = Patcher()
        b1 = p.add_box("toggle")
        b2 = p.add_box("cycle~")
        result = p.find_box(maxclass="toggle")
        assert result is b1

    def test_find_by_text_substring(self):
        """find_box(text=...) returns first box whose text contains substring."""
        p = Patcher()
        b1 = p.add_box("cycle~", args=["440"])
        b2 = p.add_box("cycle~", args=["880"])
        result = p.find_box(text="cycle~ 440")
        assert result is b1

    def test_find_combined_criteria(self):
        """find_box(maxclass=..., text=...) combines criteria with AND."""
        p = Patcher()
        b1 = p.add_box("cycle~", args=["440"])
        b2 = p.add_box("cycle~", args=["880"])
        # Both are maxclass="newobj" -- text narrows it down
        result = p.find_box(maxclass="newobj", text="880")
        assert result is b2

    def test_find_no_match_returns_none(self):
        """find_box() returns None when no box matches."""
        p = Patcher()
        p.add_box("cycle~")
        result = p.find_box(name="ezdac~")
        assert result is None

    def test_find_recursive(self):
        """find_box(recursive=True) searches into subpatchers."""
        p = Patcher()
        p.add_box("cycle~")
        _, inner = p.add_subpatcher("sub", inlets=1, outlets=1)
        inner_box = inner.add_box("noise~")
        result = p.find_box(name="noise~", recursive=True)
        assert result is inner_box

    def test_find_recursive_prefers_parent(self):
        """find_box(recursive=True) returns parent match before inner match."""
        p = Patcher()
        parent_box = p.add_box("cycle~")
        _, inner = p.add_subpatcher("sub", inlets=1, outlets=1)
        inner.add_box("cycle~")
        result = p.find_box(name="cycle~", recursive=True)
        assert result is parent_box

    def test_find_no_db_works_for_non_alias_criteria(self):
        """find_box works when db is None for non-alias criteria."""
        p = Patcher()
        p.db = None
        b1 = p.add_box.__wrapped__(p, "cycle~") if hasattr(p.add_box, '__wrapped__') else None
        # Build a box manually to avoid DB dependency
        box = Box.__new__(Box)
        box.id = "obj-1"
        box.name = "cycle~"
        box.maxclass = "newobj"
        box.text = "cycle~ 440"
        box.args = ["440"]
        box.numinlets = 2
        box.numoutlets = 1
        box.outlettype = ["signal"]
        box.patching_rect = [0, 0, 60, 22]
        box.fontname = "Arial"
        box.fontsize = 12.0
        box.presentation = False
        box.presentation_rect = None
        box.target_id = None
        box.extra_attrs = {}
        box._inner_patcher = None
        box._saved_object_attributes = None
        box._bpatcher_attrs = None
        box._raw = None
        p.boxes.append(box)
        result = p.find_box(id="obj-1")
        assert result is box

    def test_find_no_db_name_exact_match_only(self):
        """find_box(name=...) with db=None falls back to exact name match."""
        p = Patcher()
        p.db = None
        box = Box.__new__(Box)
        box.id = "obj-1"
        box.name = "trigger"
        box.maxclass = "newobj"
        box.text = "trigger b i"
        box.args = ["b", "i"]
        box.numinlets = 1
        box.numoutlets = 2
        box.outlettype = ["", ""]
        box.patching_rect = [0, 0, 60, 22]
        box.fontname = "Arial"
        box.fontsize = 12.0
        box.presentation = False
        box.presentation_rect = None
        box.target_id = None
        box.extra_attrs = {}
        box._inner_patcher = None
        box._saved_object_attributes = None
        box._bpatcher_attrs = None
        box._raw = None
        p.boxes.append(box)
        # "t" should NOT match "trigger" when db is None (no alias resolution)
        result = p.find_box(name="t")
        assert result is None
        # But exact match should work
        result = p.find_box(name="trigger")
        assert result is box


class TestFindBoxes:
    """find_boxes() returns list of all matching boxes."""

    def test_find_all_by_name(self):
        """find_boxes(name=...) returns all boxes with matching name."""
        p = Patcher()
        b1 = p.add_box("cycle~", args=["440"])
        b2 = p.add_box("cycle~", args=["880"])
        b3 = p.add_box("ezdac~")
        results = p.find_boxes(name="cycle~")
        assert results == [b1, b2]

    def test_find_boxes_no_match_returns_empty(self):
        """find_boxes() returns empty list when no match."""
        p = Patcher()
        p.add_box("cycle~")
        results = p.find_boxes(name="noise~")
        assert results == []

    def test_find_boxes_recursive(self):
        """find_boxes(recursive=True) finds boxes inside subpatchers."""
        p = Patcher()
        p.add_box("cycle~")
        _, inner = p.add_subpatcher("sub", inlets=1, outlets=1)
        inner.add_box("cycle~")
        results = p.find_boxes(name="cycle~", recursive=True)
        assert len(results) == 2

    def test_find_boxes_recursive_finds_inlet(self):
        """find_boxes(name='inlet', recursive=True) finds inlet boxes inside subpatchers."""
        p = Patcher()
        _, inner = p.add_subpatcher("sub", inlets=2, outlets=1)
        results = p.find_boxes(name="inlet", recursive=True)
        assert len(results) == 2

    def test_find_boxes_no_parent_duplicates(self):
        """find_boxes(recursive=True) does not duplicate parent boxes."""
        p = Patcher()
        b1 = p.add_box("cycle~")
        _, inner = p.add_subpatcher("sub", inlets=1, outlets=1)
        inner.add_box("cycle~")
        results = p.find_boxes(name="cycle~", recursive=True)
        # Should have exactly 2 (one parent, one inner) -- no duplicates
        assert len(results) == 2
        assert b1 in results

    def test_find_boxes_combined_criteria(self):
        """find_boxes with multiple criteria combines as AND."""
        p = Patcher()
        p.add_box("cycle~", args=["440"])
        p.add_box("cycle~", args=["880"])
        p.add_box("ezdac~")
        results = p.find_boxes(maxclass="newobj", text="440")
        assert len(results) == 1

    def test_find_boxes_alias_resolution(self):
        """find_boxes(name='t') finds both 't' and 'trigger' boxes."""
        p = Patcher()
        b1 = p.add_box("t", args=["b", "i"])
        b2 = p.add_box("trigger", args=["b", "f"])
        b3 = p.add_box("cycle~")
        results = p.find_boxes(name="t")
        assert len(results) == 2
        assert b1 in results
        assert b2 in results


class TestRemoveBox:
    """remove_box() removes a box and cleans up connected patchlines."""

    def test_remove_box_with_connections(self):
        """Remove a box with connections -- verify box gone AND connected lines gone."""
        p = Patcher()
        b1 = p.add_box("cycle~", args=["440"])
        b2 = p.add_box("*~", args=["0.5"])
        b3 = p.add_box("ezdac~")
        p.add_connection(b1, 0, b2, 0)
        p.add_connection(b2, 0, b3, 0)
        assert len(p.boxes) == 3
        assert len(p.lines) == 2

        p.remove_box(b2)

        assert len(p.boxes) == 2
        assert b2 not in p.boxes
        assert len(p.lines) == 0  # Both connections involved b2

    def test_remove_box_no_connections(self):
        """Remove a box with no connections -- verify only box gone."""
        p = Patcher()
        b1 = p.add_box("cycle~")
        b2 = p.add_box("ezdac~")
        assert len(p.boxes) == 2
        assert len(p.lines) == 0

        p.remove_box(b1)

        assert len(p.boxes) == 1
        assert b1 not in p.boxes
        assert b2 in p.boxes

    def test_remove_box_as_source(self):
        """Remove a box that is a connection source -- verify source-side lines removed."""
        p = Patcher()
        b1 = p.add_box("cycle~", args=["440"])
        b2 = p.add_box("ezdac~")
        p.add_connection(b1, 0, b2, 0)
        p.add_connection(b1, 0, b2, 1)

        p.remove_box(b1)

        assert b1 not in p.boxes
        assert len(p.lines) == 0

    def test_remove_box_as_destination(self):
        """Remove a box that is a connection destination -- verify dest-side lines removed."""
        p = Patcher()
        b1 = p.add_box("cycle~", args=["440"])
        b2 = p.add_box("*~", args=["0.5"])
        b3 = p.add_box("ezdac~")
        p.add_connection(b1, 0, b2, 0)
        p.add_connection(b1, 0, b3, 0)

        p.remove_box(b2)

        assert b2 not in p.boxes
        assert len(p.lines) == 1  # Only b1->b3 remains
        assert p.lines[0].dest_id == b3.id

    def test_remove_box_not_in_patcher(self):
        """Remove a box not in patcher -- verify ValueError."""
        p = Patcher()
        b1 = p.add_box("cycle~")

        p2 = Patcher()
        b_other = p2.add_box("noise~")

        with pytest.raises(ValueError, match="not found"):
            p.remove_box(b_other)

    def test_remove_box_preserves_other_boxes_and_connections(self):
        """After removal, other boxes and their connections are untouched."""
        p = Patcher()
        b1 = p.add_box("cycle~", args=["440"])
        b2 = p.add_box("*~", args=["0.5"])
        b3 = p.add_box("ezdac~")
        b4 = p.add_box("noise~")
        p.add_connection(b1, 0, b2, 0)
        p.add_connection(b2, 0, b3, 0)
        p.add_connection(b4, 0, b3, 1)

        p.remove_box(b2)

        assert b1 in p.boxes
        assert b3 in p.boxes
        assert b4 in p.boxes
        assert len(p.lines) == 1  # Only b4->b3 remains
        assert p.lines[0].source_id == b4.id
        assert p.lines[0].dest_id == b3.id


class TestRemoveConnection:
    """remove_connection() removes a specific connection by identity fields."""

    def test_remove_connection(self):
        """Remove a specific connection -- verify line count decreases by 1."""
        p = Patcher()
        b1 = p.add_box("cycle~", args=["440"])
        b2 = p.add_box("ezdac~")
        p.add_connection(b1, 0, b2, 0)
        p.add_connection(b1, 0, b2, 1)
        assert len(p.lines) == 2

        p.remove_connection(b1, 0, b2, 0)

        assert len(p.lines) == 1
        assert p.lines[0].dest_inlet == 1

    def test_remove_connection_multiple_same_boxes(self):
        """Remove connection between boxes with multiple connections -- only specified one removed."""
        p = Patcher()
        b1 = p.add_box("cycle~", args=["440"])
        b2 = p.add_box("ezdac~")
        p.add_connection(b1, 0, b2, 0)
        p.add_connection(b1, 0, b2, 1)

        p.remove_connection(b1, 0, b2, 1)

        assert len(p.lines) == 1
        remaining = p.lines[0]
        assert remaining.source_id == b1.id
        assert remaining.dest_inlet == 0

    def test_remove_connection_not_found(self):
        """Remove connection that doesn't exist -- verify ValueError."""
        p = Patcher()
        b1 = p.add_box("cycle~", args=["440"])
        b2 = p.add_box("ezdac~")

        with pytest.raises(ValueError, match="Connection not found"):
            p.remove_connection(b1, 0, b2, 0)

    def test_remove_connection_preserves_others(self):
        """After removal, other connections are untouched."""
        p = Patcher()
        b1 = p.add_box("cycle~", args=["440"])
        b2 = p.add_box("*~", args=["0.5"])
        b3 = p.add_box("ezdac~")
        pl1 = p.add_connection(b1, 0, b2, 0)
        pl2 = p.add_connection(b2, 0, b3, 0)

        p.remove_connection(b1, 0, b2, 0)

        assert len(p.lines) == 1
        assert p.lines[0] is pl2


class TestAddConnectionBoundsCheck:
    """add_connection() rejects out-of-bounds indices with clear error messages."""

    def test_valid_connection_still_works(self):
        """Valid connection still works (regression test)."""
        p = Patcher()
        b1 = p.add_box("cycle~", args=["440"])  # 1 outlet
        b2 = p.add_box("ezdac~")  # 2 inlets
        pl = p.add_connection(b1, 0, b2, 0)
        assert pl is not None
        assert len(p.lines) == 1

    def test_outlet_ge_numoutlets_raises(self):
        """Outlet index >= numoutlets raises ValueError."""
        p = Patcher()
        b1 = p.add_box("cycle~")  # 1 outlet (index 0 only)
        b2 = p.add_box("ezdac~")
        with pytest.raises(ValueError, match="Outlet index 1 out of range"):
            p.add_connection(b1, 1, b2, 0)

    def test_inlet_ge_numinlets_raises(self):
        """Inlet index >= numinlets raises ValueError."""
        p = Patcher()
        b1 = p.add_box("cycle~")
        b2 = p.add_box("toggle")  # 1 inlet (index 0 only)
        with pytest.raises(ValueError, match="Inlet index 1 out of range"):
            p.add_connection(b1, 0, b2, 1)

    def test_negative_outlet_raises(self):
        """Negative outlet raises ValueError."""
        p = Patcher()
        b1 = p.add_box("cycle~")
        b2 = p.add_box("ezdac~")
        with pytest.raises(ValueError, match="Outlet index -1 out of range"):
            p.add_connection(b1, -1, b2, 0)

    def test_negative_inlet_raises(self):
        """Negative inlet raises ValueError."""
        p = Patcher()
        b1 = p.add_box("cycle~")
        b2 = p.add_box("ezdac~")
        with pytest.raises(ValueError, match="Inlet index -1 out of range"):
            p.add_connection(b1, 0, b2, -1)

    def test_error_message_includes_box_id_and_range(self):
        """Error message includes box ID and valid range."""
        p = Patcher()
        b1 = p.add_box("cycle~")  # 1 outlet
        b2 = p.add_box("ezdac~")
        with pytest.raises(ValueError, match=r"obj-\d+.*valid: 0\.\.0"):
            p.add_connection(b1, 5, b2, 0)

    def test_max_valid_outlet_succeeds(self):
        """Outlet index numoutlets-1 succeeds (boundary test)."""
        p = Patcher()
        b1 = p.add_box("cycle~")  # 1 outlet -> max index 0
        b2 = p.add_box("ezdac~")
        pl = p.add_connection(b1, 0, b2, 0)
        assert pl is not None

    def test_zero_outlets_any_index_raises(self):
        """Box with 0 outlets: any outlet index raises ValueError."""
        p = Patcher()
        b1 = p.add_comment("test")  # 0 outlets
        b2 = p.add_box("ezdac~")
        with pytest.raises(ValueError, match="none.*0 outlet"):
            p.add_connection(b1, 0, b2, 0)

    def test_large_outlet_index_raises(self):
        """Very large outlet index raises ValueError."""
        p = Patcher()
        b1 = p.add_box("cycle~")
        b2 = p.add_box("ezdac~")
        with pytest.raises(ValueError, match="Outlet index 999 out of range"):
            p.add_connection(b1, 999, b2, 0)

    def test_large_inlet_index_raises(self):
        """Very large inlet index raises ValueError."""
        p = Patcher()
        b1 = p.add_box("cycle~")
        b2 = p.add_box("ezdac~")
        with pytest.raises(ValueError, match="Inlet index 999 out of range"):
            p.add_connection(b1, 0, b2, 999)


class TestDuplicateConnectionPrevention:
    """add_connection() returns existing patchline for duplicate connections."""

    def test_duplicate_returns_existing(self):
        """Duplicate connection returns existing Patchline (same object)."""
        p = Patcher()
        b1 = p.add_box("cycle~", args=["440"])
        b2 = p.add_box("ezdac~")
        pl1 = p.add_connection(b1, 0, b2, 0)
        pl2 = p.add_connection(b1, 0, b2, 0)
        assert pl2 is pl1

    def test_duplicate_line_count_unchanged(self):
        """After duplicate, line count unchanged."""
        p = Patcher()
        b1 = p.add_box("cycle~", args=["440"])
        b2 = p.add_box("ezdac~")
        p.add_connection(b1, 0, b2, 0)
        p.add_connection(b1, 0, b2, 0)
        assert len(p.lines) == 1

    def test_different_outlets_not_duplicate(self):
        """Connections with same boxes but different outlet/inlet are NOT duplicates."""
        p = Patcher()
        b1 = p.add_box("cycle~", args=["440"])
        b2 = p.add_box("ezdac~")
        pl1 = p.add_connection(b1, 0, b2, 0)
        pl2 = p.add_connection(b1, 0, b2, 1)
        assert pl1 is not pl2
        assert len(p.lines) == 2


# --- Phase 15: Intelligent Editing ---


class TestModifyBox:
    """ED-01: modify_box in-place attribute editing."""

    def test_modify_args_updates_text(self):
        """modify_box(box, args=["880"]) changes text to 'cycle~ 880'."""
        from src.maxpat.patcher import EditResult
        p = Patcher()
        box = p.add_box("cycle~", args=["440"])
        result = p.modify_box(box, args=["880"])
        assert isinstance(result, EditResult)
        assert box.text == "cycle~ 880"
        assert box.args == ["880"]

    def test_modify_args_returns_edit_result(self):
        """modify_box returns EditResult with box and orphaned fields."""
        from src.maxpat.patcher import EditResult
        p = Patcher()
        box = p.add_box("cycle~", args=["440"])
        result = p.modify_box(box, args=["880"])
        assert result.box is box
        assert isinstance(result.orphaned, list)
        assert len(result.orphaned) == 0

    def test_modify_args_recomputes_io(self):
        """modify_box(box, args=["b"]) on trigger recomputes I/O (1 arg = 1 outlet)."""
        from src.maxpat.patcher import EditResult
        p = Patcher()
        box = p.add_box("trigger", args=["b", "i", "f"])
        assert box.numoutlets == 3
        result = p.modify_box(box, args=["b"])
        assert box.numoutlets == 1
        assert box.numinlets == 1

    def test_modify_args_orphans_connections_on_shrink(self):
        """modify_box on variable_io object where I/O shrinks returns orphaned connections."""
        from src.maxpat.patcher import EditResult
        p = Patcher()
        trigger = p.add_box("trigger", args=["b", "i", "f"])
        b1 = p.add_box("print", args=["first"])
        b2 = p.add_box("print", args=["second"])
        b3 = p.add_box("print", args=["third"])
        p.add_connection(trigger, 0, b1, 0)
        p.add_connection(trigger, 1, b2, 0)
        p.add_connection(trigger, 2, b3, 0)
        assert len(p.lines) == 3

        result = p.modify_box(trigger, args=["b"])
        # After shrink to 1 outlet, connections to outlets 1 and 2 are orphaned
        assert len(result.orphaned) == 2
        assert len(p.lines) == 1  # Only outlet 0 connection survives

    def test_modify_position_changes_patching_rect(self):
        """modify_box(box, position=[100, 200]) changes position without touching args."""
        from src.maxpat.patcher import EditResult
        p = Patcher()
        box = p.add_box("cycle~", args=["440"])
        original_text = box.text
        result = p.modify_box(box, position=[100.0, 200.0])
        assert box.patching_rect[0] == 100.0
        assert box.patching_rect[1] == 200.0
        assert box.text == original_text
        assert len(result.orphaned) == 0

    def test_modify_color_sets_bgcolor(self):
        """modify_box(box, color=[1,0,0,1]) sets extra_attrs['bgcolor']."""
        from src.maxpat.patcher import EditResult
        p = Patcher()
        box = p.add_box("cycle~")
        result = p.modify_box(box, color=[1.0, 0.0, 0.0, 1.0])
        assert box.extra_attrs["bgcolor"] == [1.0, 0.0, 0.0, 1.0]

    def test_modify_extra_attrs_updates(self):
        """modify_box(box, extra_attrs={"fontsize": 14}) updates extra_attrs."""
        from src.maxpat.patcher import EditResult
        p = Patcher()
        box = p.add_box("cycle~")
        result = p.modify_box(box, extra_attrs={"fontsize": 14})
        assert box.extra_attrs["fontsize"] == 14

    def test_modify_syncs_raw_on_loaded_box(self):
        """modify_box on loaded box (with _raw) updates _raw fields."""
        import json
        from src.maxpat.patcher import EditResult
        data = {
            "patcher": {
                "fileversion": 1,
                "appversion": {"major": 9, "minor": 0, "revision": 0},
                "classnamespace": "box",
                "rect": [100.0, 100.0, 640.0, 480.0],
                "boxes": [
                    {
                        "box": {
                            "maxclass": "newobj",
                            "text": "cycle~ 440",
                            "id": "obj-1",
                            "numinlets": 2,
                            "numoutlets": 1,
                            "outlettype": ["signal"],
                            "patching_rect": [100.0, 100.0, 80.0, 22.0],
                            "fontname": "Arial",
                            "fontsize": 12.0,
                        }
                    }
                ],
                "lines": [],
            }
        }
        p = Patcher.from_dict(data)
        box = p.boxes[0]
        assert box._raw is not None

        result = p.modify_box(box, args=["880"])
        assert box._raw["text"] == "cycle~ 880"
        assert box.text == "cycle~ 880"

    def test_modify_syncs_raw_position(self):
        """modify_box on loaded box updates _raw['patching_rect']."""
        data = {
            "patcher": {
                "fileversion": 1,
                "appversion": {"major": 9, "minor": 0, "revision": 0},
                "classnamespace": "box",
                "rect": [100.0, 100.0, 640.0, 480.0],
                "boxes": [
                    {
                        "box": {
                            "maxclass": "newobj",
                            "text": "cycle~ 440",
                            "id": "obj-1",
                            "numinlets": 2,
                            "numoutlets": 1,
                            "outlettype": ["signal"],
                            "patching_rect": [100.0, 100.0, 80.0, 22.0],
                            "fontname": "Arial",
                            "fontsize": 12.0,
                        }
                    }
                ],
                "lines": [],
            }
        }
        p = Patcher.from_dict(data)
        box = p.boxes[0]
        p.modify_box(box, position=[200.0, 300.0])
        assert box._raw["patching_rect"][0] == 200.0
        assert box._raw["patching_rect"][1] == 300.0

    def test_modify_raises_on_unknown_box(self):
        """modify_box raises ValueError if box not in patcher."""
        p = Patcher()
        p2 = Patcher()
        foreign_box = p2.add_box("cycle~")
        with pytest.raises(ValueError, match="not found"):
            p.modify_box(foreign_box, args=["880"])

    def test_modify_no_changes_returns_empty_orphaned(self):
        """modify_box with no args/position/color returns EditResult with empty orphaned."""
        from src.maxpat.patcher import EditResult
        p = Patcher()
        box = p.add_box("cycle~", args=["440"])
        result = p.modify_box(box)
        assert isinstance(result, EditResult)
        assert result.box is box
        assert result.orphaned == []


class TestReplaceBox:
    """ED-03: replace_box object swap with orphaned connections."""

    def test_replace_basic(self):
        """replace_box(old_box, 'saw~') creates new box with name 'saw~'."""
        from src.maxpat.patcher import EditResult
        p = Patcher()
        old = p.add_box("cycle~", args=["440"])
        result = p.replace_box(old, "saw~")
        assert isinstance(result, EditResult)
        assert result.box.name == "saw~"

    def test_replace_with_args(self):
        """replace_box(old_box, 'pack', args=['0', '0']) passes args to new box."""
        from src.maxpat.patcher import EditResult
        p = Patcher()
        old = p.add_box("cycle~", args=["440"])
        result = p.replace_box(old, "pack", args=["0", "0"])
        assert result.box.name == "pack"
        assert result.box.args == ["0", "0"]
        assert result.box.numinlets == 2  # pack with 2 args has 2 inlets

    def test_replace_preserves_position(self):
        """New box has same patching_rect[0:2] as old box (position preserved)."""
        from src.maxpat.patcher import EditResult
        p = Patcher()
        old = p.add_box("cycle~", args=["440"], x=150.0, y=250.0)
        result = p.replace_box(old, "saw~")
        assert result.box.patching_rect[0] == 150.0
        assert result.box.patching_rect[1] == 250.0

    def test_replace_returns_all_connections_as_orphaned(self):
        """replace_box returns ALL old connections as orphaned (no auto-remap)."""
        from src.maxpat.patcher import EditResult
        p = Patcher()
        old = p.add_box("cycle~", args=["440"])
        dest = p.add_box("ezdac~")
        src = p.add_box("message")
        p.add_connection(old, 0, dest, 0)
        p.add_connection(old, 0, dest, 1)
        p.add_connection(src, 0, old, 0)

        result = p.replace_box(old, "saw~")
        assert len(result.orphaned) == 3

    def test_replace_removes_old_box(self):
        """Old box is removed from patcher.boxes after replace."""
        from src.maxpat.patcher import EditResult
        p = Patcher()
        old = p.add_box("cycle~", args=["440"])
        old_id = old.id
        result = p.replace_box(old, "saw~")
        # Old box should not be in patcher
        assert all(b.id != old_id for b in p.boxes)
        # New box should be in patcher
        assert result.box in p.boxes

    def test_replace_removes_all_patchlines(self):
        """All patchlines to/from old box are removed."""
        from src.maxpat.patcher import EditResult
        p = Patcher()
        b1 = p.add_box("cycle~", args=["440"])
        b2 = p.add_box("ezdac~")
        b3 = p.add_box("noise~")
        p.add_connection(b1, 0, b2, 0)
        p.add_connection(b3, 0, b2, 1)
        assert len(p.lines) == 2

        result = p.replace_box(b1, "saw~")
        # Only the b3->b2 connection should remain
        assert len(p.lines) == 1
        assert p.lines[0].source_id == b3.id

    def test_replace_raises_on_unknown_box(self):
        """replace_box raises ValueError if old box not in patcher."""
        p = Patcher()
        p2 = Patcher()
        foreign = p2.add_box("cycle~")
        with pytest.raises(ValueError, match="not found"):
            p.replace_box(foreign, "saw~")


class TestAutoPosition:
    """ED-05: auto-positioning with collision detection and grid snap."""
    pass


class TestInsertIntoConnection:
    """ED-02: insert_into_connection splice operation."""
    pass


class TestDownstream:
    """ED-04: downstream graph traversal."""
    pass


class TestUpstream:
    """ED-04: upstream graph traversal."""
    pass


class TestSignalPath:
    """ED-04: signal-only path tracing."""
    pass


class TestConnectedComponents:
    """ED-04: connected component detection."""
    pass
