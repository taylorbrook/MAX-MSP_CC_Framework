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
        assert bd["box"]["outlettype"] == ["int"]

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

    def test_patchline_has_order(self):
        """Patchline includes order field."""
        p = Patcher()
        b1 = p.add_box("cycle~")
        b2 = p.add_box("ezdac~")
        pl = p.add_connection(b1, 0, b2, 0)
        pld = pl.to_dict()
        assert "order" in pld["patchline"]

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
