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


class TestAssistanceComments:
    """Tests for assistance comment population on inlet/outlet objects."""

    def test_explicit_inlet_comments(self):
        """add_subpatcher with inlet_comments sets those comments on inner inlet boxes."""
        p = Patcher()
        parent_box, inner = p.add_subpatcher(
            "my_sub", inlets=2, outlets=1,
            inlet_comments=["Audio In", "MIDI In"],
        )
        inner_dict = parent_box.to_dict()["box"]["patcher"]
        inlets = [b["box"] for b in inner_dict["boxes"] if b["box"]["maxclass"] == "inlet"]
        assert inlets[0]["comment"] == "Audio In"
        assert inlets[1]["comment"] == "MIDI In"

    def test_explicit_outlet_comments(self):
        """add_subpatcher with outlet_comments sets that comment on inner outlet box."""
        p = Patcher()
        parent_box, inner = p.add_subpatcher(
            "my_sub", inlets=1, outlets=1,
            outlet_comments=["Audio Out"],
        )
        inner_dict = parent_box.to_dict()["box"]["patcher"]
        outlets = [b["box"] for b in inner_dict["boxes"] if b["box"]["maxclass"] == "outlet"]
        assert outlets[0]["comment"] == "Audio Out"

    def test_no_comments_backward_compatible(self):
        """add_subpatcher without comment params still sets empty string."""
        p = Patcher()
        parent_box, inner = p.add_subpatcher("my_sub", inlets=1, outlets=1)
        inner_dict = parent_box.to_dict()["box"]["patcher"]
        inlets = [b["box"] for b in inner_dict["boxes"] if b["box"]["maxclass"] == "inlet"]
        outlets = [b["box"] for b in inner_dict["boxes"] if b["box"]["maxclass"] == "outlet"]
        assert inlets[0]["comment"] == ""
        assert outlets[0]["comment"] == ""

    def test_fewer_comments_than_inlets(self):
        """add_subpatcher with fewer comments than inlets -- extra inlets get empty string."""
        p = Patcher()
        parent_box, inner = p.add_subpatcher(
            "my_sub", inlets=3, outlets=1,
            inlet_comments=["Audio In"],
        )
        inner_dict = parent_box.to_dict()["box"]["patcher"]
        inlets = [b["box"] for b in inner_dict["boxes"] if b["box"]["maxclass"] == "inlet"]
        assert inlets[0]["comment"] == "Audio In"
        assert inlets[1]["comment"] == ""
        assert inlets[2]["comment"] == ""

    def test_populate_infers_from_downstream(self):
        """populate_assistance_comments() infers comment from first downstream object for inlet."""
        p = Patcher()
        parent_box, inner = p.add_subpatcher("my_sub", inlets=1, outlets=1)
        # Add a cycle~ connected from the inlet
        inlet_box = [b for b in inner.boxes if b.maxclass == "inlet"][0]
        cyc = inner.add_box("cycle~", args=["440"])
        inner.add_connection(inlet_box, 0, cyc, 0)
        # Populate
        p.populate_assistance_comments()
        assert inlet_box.extra_attrs["comment"] == "signal to cycle~ 440"

    def test_populate_infers_from_upstream(self):
        """populate_assistance_comments() infers comment from first upstream object for outlet."""
        p = Patcher()
        parent_box, inner = p.add_subpatcher("my_sub", inlets=1, outlets=1)
        # Add a *~ connected to the outlet
        outlet_box = [b for b in inner.boxes if b.maxclass == "outlet"][0]
        mul = inner.add_box("*~", args=["0.5"])
        inner.add_connection(mul, 0, outlet_box, 0)
        # Populate
        p.populate_assistance_comments()
        assert outlet_box.extra_attrs["comment"] == "signal from *~ 0.5"

    def test_populate_skips_nonempty_comments(self):
        """populate_assistance_comments() skips inlet/outlet objects that already have non-empty comments."""
        p = Patcher()
        parent_box, inner = p.add_subpatcher(
            "my_sub", inlets=1, outlets=1,
            inlet_comments=["My Custom Comment"],
        )
        inlet_box = [b for b in inner.boxes if b.maxclass == "inlet"][0]
        cyc = inner.add_box("cycle~", args=["440"])
        inner.add_connection(inlet_box, 0, cyc, 0)
        # Populate should not overwrite
        p.populate_assistance_comments()
        assert inlet_box.extra_attrs["comment"] == "My Custom Comment"

    def test_populate_no_connections_fallback(self):
        """populate_assistance_comments() handles inlet/outlet with no connections (sets 'inlet N' / 'outlet N')."""
        p = Patcher()
        parent_box, inner = p.add_subpatcher("my_sub", inlets=2, outlets=2)
        p.populate_assistance_comments()
        inlets = [b for b in inner.boxes if b.maxclass == "inlet"]
        outlets = [b for b in inner.boxes if b.maxclass == "outlet"]
        assert inlets[0].extra_attrs["comment"] == "inlet 1"
        assert inlets[1].extra_attrs["comment"] == "inlet 2"
        assert outlets[0].extra_attrs["comment"] == "outlet 1"
        assert outlets[1].extra_attrs["comment"] == "outlet 2"

    def test_populate_recurses_into_nested_subpatchers(self):
        """populate_assistance_comments() recurses into nested subpatchers."""
        p = Patcher()
        parent_box, inner = p.add_subpatcher("outer", inlets=1, outlets=1)
        # Create a nested subpatcher inside inner
        nested_box, nested = inner.add_subpatcher("nested", inlets=1, outlets=1)
        nested_inlet = [b for b in nested.boxes if b.maxclass == "inlet"][0]
        cyc = nested.add_box("cycle~", args=["880"])
        nested.add_connection(nested_inlet, 0, cyc, 0)
        # Populate from the top-level patcher
        p.populate_assistance_comments()
        # Should recurse and populate the nested inlet
        assert nested_inlet.extra_attrs["comment"] == "signal to cycle~ 880"

    def test_populate_returns_self_for_chaining(self):
        """populate_assistance_comments() returns self for chaining."""
        p = Patcher()
        result = p.populate_assistance_comments()
        assert result is p


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
        old = p.add_box("cycle~", args=["440"], x=150.0, y=255.0)
        result = p.replace_box(old, "saw~")
        assert result.box.patching_rect[0] == 150.0
        assert result.box.patching_rect[1] == 255.0

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


class TestReplaceBoxSafe:
    """P1-1: replace_box_safe auto-rewires connections when I/O matches."""

    def test_auto_rewire_matching_io_zero_orphans(self):
        """Auto mode + matching I/O: zero orphans, all connections survive on new box."""
        from src.maxpat.patcher import EditResult
        p = Patcher()
        # cycle~ and saw~ both have 2 inlets / 1 outlet -- matching I/O.
        old = p.add_box("cycle~", args=["440"])
        src = p.add_box("number")
        dst = p.add_box("ezdac~")
        p.add_connection(src, 0, old, 0)
        p.add_connection(old, 0, dst, 0)
        p.add_connection(old, 0, dst, 1)

        result = p.replace_box_safe(old, "saw~")

        assert isinstance(result, EditResult)
        assert result.box.name == "saw~"
        assert result.orphaned == []
        assert len(p.lines) == 3
        # All three connections remap old.id -> result.box.id.
        actual = {
            (pl.source_id, pl.source_outlet, pl.dest_id, pl.dest_inlet)
            for pl in p.lines
        }
        expected = {
            (src.id, 0, result.box.id, 0),
            (result.box.id, 0, dst.id, 0),
            (result.box.id, 0, dst.id, 1),
        }
        assert actual == expected

    def test_auto_mismatched_io_falls_back_to_orphans(self):
        """Auto mode + mismatched I/O: orphans returned, no auto-rewire."""
        from src.maxpat.patcher import EditResult
        p = Patcher()
        # cycle~: 2 in / 1 out. pack 0 0 0: 3 in / 1 out -- numinlets mismatch.
        old = p.add_box("cycle~", args=["440"])
        src = p.add_box("number")
        dst = p.add_box("ezdac~")
        p.add_connection(src, 0, old, 0)
        p.add_connection(old, 0, dst, 0)

        result = p.replace_box_safe(old, "pack", args=["0", "0", "0"])

        assert isinstance(result, EditResult)
        assert result.box.name == "pack"
        assert len(result.orphaned) == 2
        # No connections to or from the new box on the patcher.
        assert all(
            pl.source_id != result.box.id and pl.dest_id != result.box.id
            for pl in p.lines
        )
        assert len(p.lines) == 0

    def test_manual_mode_skips_rewire_even_on_match(self):
        """Manual mode: orphans returned even when I/O would have matched."""
        from src.maxpat.patcher import EditResult
        p = Patcher()
        old = p.add_box("cycle~", args=["440"])
        dst = p.add_box("ezdac~")
        p.add_connection(old, 0, dst, 0)

        result = p.replace_box_safe(old, "saw~", rewire="manual")

        assert isinstance(result, EditResult)
        assert result.box.name == "saw~"
        assert len(result.orphaned) == 1
        assert len(p.lines) == 0

    def test_ears_slice_to_split_regression_preserves_connections(self):
        """Bassoon regression: ears.slice~ -> ears.split~ preserves all 3 wires."""
        from src.maxpat.patcher import EditResult
        # Both ears.slice~ and ears.split~ are 2 in / 2 out (matching I/O).
        p = Patcher()
        old = p.add_box("ears.slice~")
        trig = p.add_box("trigger", args=["l", "l"])
        zlreg = p.add_box("zl.reg")
        trig2 = p.add_box("trigger", args=["b", "l"])
        p.add_connection(old, 0, trig, 0)
        p.add_connection(zlreg, 0, old, 0)
        p.add_connection(trig2, 1, old, 1)

        result = p.replace_box_safe(old, "ears.split~")

        assert isinstance(result, EditResult)
        assert result.box.name == "ears.split~"
        assert result.orphaned == []
        assert len(p.lines) == 3
        actual = {
            (pl.source_id, pl.source_outlet, pl.dest_id, pl.dest_inlet)
            for pl in p.lines
        }
        expected = {
            (result.box.id, 0, trig.id, 0),
            (zlreg.id, 0, result.box.id, 0),
            (trig2.id, 1, result.box.id, 1),
        }
        assert actual == expected


class TestAutoPosition:
    """ED-05: auto-positioning with collision detection and grid snap."""

    def test_grid_snap_basic(self):
        """Positions are snapped to 15px grid."""
        p = Patcher()
        box = p.add_box("toggle", x=7.0, y=11.0)
        p._auto_position(box)
        # Should snap to nearest 15px grid
        assert box.patching_rect[0] % 15 == 0
        assert box.patching_rect[1] % 15 == 0

    def test_near_box_positioning(self):
        """Box positioned below near_box with V_SPACING gap."""
        p = Patcher()
        source = p.add_box("cycle~", args=["440"], x=60.0, y=45.0)
        new_box = p.add_box("dac~", x=0.0, y=0.0)
        p._auto_position(new_box, near_box=source)
        # Should be below source: y = source.y + source.h + V_SPACING
        expected_y = source.patching_rect[1] + source.patching_rect[3] + 20
        # Snapped to 15px grid
        expected_y_snapped = round(expected_y / 15.0) * 15.0
        assert new_box.patching_rect[1] == expected_y_snapped
        # x should be at source x, snapped
        expected_x_snapped = round(source.patching_rect[0] / 15.0) * 15.0
        assert new_box.patching_rect[0] == expected_x_snapped

    def test_center_positioning_no_near_box(self):
        """With no near_box, positions at center of patcher rect."""
        p = Patcher()
        # Default patcher rect is [85, 104, 640, 480]
        box = p.add_box("toggle", x=0.0, y=0.0)
        p._auto_position(box)
        # Center: x = 640/2 = 320 (snapped), y = 480/2 = 240 (snapped)
        assert box.patching_rect[0] == 315.0  # round(320/15)*15 = 315
        assert box.patching_rect[1] == 240.0  # round(240/15)*15 = 240

    def test_collision_nudge_down(self):
        """Overlapping box causes downward nudge (down-first, not right-first)."""
        p = Patcher()
        existing = p.add_box("toggle", x=60.0, y=60.0, skip_overlap_check=True)
        # Place a blocker at the exact near_box target position
        target_y = existing.patching_rect[1] + existing.patching_rect[3] + 20
        blocker = p.add_box("button", x=60.0, y=target_y, skip_overlap_check=True)
        # Snap blocker to grid to match where _auto_position would try
        blocker.patching_rect[0] = round(60.0 / 15.0) * 15.0
        blocker.patching_rect[1] = round(target_y / 15.0) * 15.0
        new_box = p.add_box("toggle", x=0.0, y=0.0, skip_overlap_check=True)
        p._auto_position(new_box, near_box=existing)
        # Should have nudged DOWN to avoid blocker (y changed, not x)
        assert new_box.patching_rect[1] != blocker.patching_rect[1]

    def test_collision_wrap_to_next_column(self):
        """When y exceeds 2400, wraps to next column (x shifts right, y resets)."""
        p = Patcher()
        # Fill a vertical column with blockers near y=2400 to force wrap
        blocker = p.add_box("toggle", x=60.0, y=2400.0, skip_overlap_check=True)
        blocker.patching_rect = [60.0, 2400.0, 24.0, 24.0]
        # Start searching at a position that collides with blocker
        fx, fy = p._find_clear_position(60.0, 2400.0, 24.0, 24.0)
        # After nudge down past 2400 threshold, should wrap to next column (x changes)
        assert fx > 60.0

    def test_exclude_box_self_collision(self):
        """exclude_box prevents collision with itself."""
        p = Patcher()
        box = p.add_box("toggle", x=60.0, y=60.0)
        # _find_clear_position at box's own position, excluding itself
        fx, fy = p._find_clear_position(
            60.0, 60.0, box.patching_rect[2], box.patching_rect[3],
            exclude_box=box,
        )
        assert fx == 60.0
        assert fy == 60.0

    def test_no_boxes_trivial(self):
        """Empty patcher: position returned as-is (snapped)."""
        p = Patcher()
        fx, fy = p._find_clear_position(33.0, 47.0, 40.0, 22.0)
        assert fx == 30.0  # round(33/15)*15
        assert fy == 45.0  # round(47/15)*15

    def test_padding_respected(self):
        """5px collision padding prevents boxes from touching."""
        p = Patcher()
        existing = p.add_box("toggle", x=60.0, y=60.0)
        existing.patching_rect = [60.0, 60.0, 24.0, 24.0]
        # Place right at the edge: x = 60 + 24 = 84 -- within 5px padding
        fx, fy = p._find_clear_position(84.0, 60.0, 24.0, 24.0)
        # 84 snaps to 90, but 90 is within 5px of edge 84, so might still
        # overlap. The actual check: (84+24) vs (60) and (60+24+5) vs 84
        # existing extends to 60+24+5=89 with pad, so 84 < 89 = overlap
        # Should nudge
        assert fx > 84.0 or fy > 60.0


class TestAddBoxOverlapDetection:
    """Overlap detection in add_box() with down-first nudge."""

    def test_add_box_nudges_on_overlap(self):
        """add_box at occupied position nudges the new box downward."""
        p = Patcher()
        box_a = p.add_box("toggle", x=60.0, y=60.0)
        box_b = p.add_box("toggle", x=60.0, y=60.0)
        # box_b should have been nudged away from box_a
        assert box_b.patching_rect[:2] != box_a.patching_rect[:2]
        # Nudged downward (y increased)
        assert box_b.patching_rect[1] > box_a.patching_rect[1]

    def test_add_box_no_overlap_exact_position(self):
        """add_box with no collision returns exact position (on grid)."""
        p = Patcher()
        box = p.add_box("toggle", x=60.0, y=60.0)
        assert box.patching_rect[0] == 60.0
        assert box.patching_rect[1] == 60.0

    def test_add_box_skip_overlap_check(self):
        """add_box with skip_overlap_check=True allows overlap."""
        p = Patcher()
        box_a = p.add_box("toggle", x=60.0, y=60.0)
        box_b = p.add_box("toggle", x=60.0, y=60.0, skip_overlap_check=True)
        # Exact same position -- overlap allowed
        assert box_b.patching_rect[0] == 60.0
        assert box_b.patching_rect[1] == 60.0

    def test_add_box_multiple_same_position(self):
        """Multiple add_box calls at same position get different y positions."""
        p = Patcher()
        boxes = [p.add_box("toggle", x=60.0, y=60.0) for _ in range(5)]
        y_positions = [b.patching_rect[1] for b in boxes]
        # All unique
        assert len(set(y_positions)) == 5
        # Ascending y order (each nudged further down)
        assert y_positions == sorted(y_positions)

    def test_add_box_snaps_to_grid(self):
        """add_box snaps position to 15px grid via overlap detection."""
        p = Patcher()
        box = p.add_box("toggle", x=67.0, y=53.0)
        # Should snap to nearest 15px grid
        assert box.patching_rect[0] % 15 == 0
        assert box.patching_rect[1] % 15 == 0

    def test_find_clear_position_nudges_down_not_right(self):
        """_find_clear_position nudges DOWN first (y += 15), not right."""
        p = Patcher()
        blocker = p.add_box("toggle", x=60.0, y=60.0, skip_overlap_check=True)
        blocker.patching_rect = [60.0, 60.0, 24.0, 24.0]
        fx, fy = p._find_clear_position(60.0, 60.0, 24.0, 24.0)
        # x should stay the same (no rightward nudge), y should increase
        assert fx == 60.0
        assert fy > 60.0


class TestInsertIntoConnection:
    """ED-02: insert_into_connection splice operation."""

    def test_basic_single_insert(self):
        """Insert a box into a single connection between two boxes."""
        from src.maxpat.patcher import EditResult
        p = Patcher()
        src = p.add_box("cycle~", args=["440"])
        dst = p.add_box("dac~")
        p.add_connection(src, 0, dst, 0)
        result = p.insert_into_connection(src, dst, "*~", args=["0.5"])
        assert isinstance(result, EditResult)
        assert result.box.name == "*~"
        assert result.orphaned == []
        # Old connection removed, two new connections present
        assert len(p.lines) == 2

    def test_stereo_insert(self):
        """Insert into stereo (two parallel connections) -- single shared object."""
        from src.maxpat.patcher import EditResult
        p = Patcher()
        # Use swap (2 in, 2 out) as the inserted object
        src = p.add_box("pack", args=["0", "0"])   # 2 inlets, 1 outlet
        dst = p.add_box("unpack", args=["0", "0"]) # 1 inlet, 2 outlets
        # But we need source with 2 outlets and dest with 2 inlets
        # Use trigger (2 out) -> pack (2 in)
        src2 = p.add_box("trigger", args=["b", "b"])  # 1 inlet, 2 outlets
        dst2 = p.add_box("pack", args=["0", "0"])     # 2 inlets, 1 outlet
        p.add_connection(src2, 0, dst2, 0)
        p.add_connection(src2, 1, dst2, 1)
        # Insert swap (2 in, 2 out) -- can handle both connections
        result = p.insert_into_connection(src2, dst2, "swap")
        assert isinstance(result, EditResult)
        assert result.box.name == "swap"
        # 2 old removed, 4 new added (src->new x2, new->dst x2)
        assert len(p.lines) == 4
        assert result.orphaned == []

    def test_position_below_source(self):
        """Inserted box is positioned below the source box."""
        p = Patcher()
        src = p.add_box("cycle~", args=["440"], x=60.0, y=60.0)
        dst = p.add_box("dac~", x=60.0, y=200.0)
        p.add_connection(src, 0, dst, 0)
        result = p.insert_into_connection(src, dst, "*~", args=["0.5"])
        # y should be below source
        assert result.box.patching_rect[1] > src.patching_rect[1]

    def test_grid_snap_on_insert(self):
        """Inserted box position is snapped to 15px grid."""
        p = Patcher()
        src = p.add_box("cycle~", args=["440"], x=67.0, y=43.0)
        dst = p.add_box("dac~", x=67.0, y=200.0)
        p.add_connection(src, 0, dst, 0)
        result = p.insert_into_connection(src, dst, "*~", args=["0.5"])
        assert result.box.patching_rect[0] % 15 == 0
        assert result.box.patching_rect[1] % 15 == 0

    def test_no_connection_raises_valueerror(self):
        """Raises ValueError when no connection exists between source and dest."""
        p = Patcher()
        src = p.add_box("cycle~", args=["440"])
        dst = p.add_box("dac~")
        # No connection added
        with pytest.raises(ValueError, match="No connection found"):
            p.insert_into_connection(src, dst, "*~")

    def test_io_mismatch_returns_orphaned(self):
        """I/O mismatch returns EditResult with orphaned, not ValueError."""
        from src.maxpat.patcher import EditResult
        p = Patcher()
        # trigger b b has 1 inlet, 2 outlets; pack 0 0 has 2 inlets, 1 outlet
        src = p.add_box("trigger", args=["b", "b"])
        dst = p.add_box("pack", args=["0", "0"])
        p.add_connection(src, 0, dst, 0)
        p.add_connection(src, 1, dst, 1)
        # toggle has 1 inlet, 1 outlet -- cannot handle 2 connections
        result = p.insert_into_connection(src, dst, "toggle")
        assert isinstance(result, EditResult)
        # Only 1 connection fits (index 0); second is orphaned
        assert len(result.orphaned) == 1
        assert result.orphaned[0]["source_outlet"] == 1
        assert result.orphaned[0]["dest_inlet"] == 1

    def test_args_forwarded(self):
        """Arguments are passed through to the new box."""
        p = Patcher()
        src = p.add_box("cycle~", args=["440"])
        dst = p.add_box("dac~")
        p.add_connection(src, 0, dst, 0)
        result = p.insert_into_connection(src, dst, "*~", args=["0.5"])
        assert result.box.args == ["0.5"]
        assert "0.5" in result.box.text

    def test_connections_properly_rewired(self):
        """Old connection removed, new connections (src->new and new->dst) present."""
        p = Patcher()
        src = p.add_box("cycle~", args=["440"])
        dst = p.add_box("dac~")
        p.add_connection(src, 0, dst, 0)
        result = p.insert_into_connection(src, dst, "*~", args=["0.5"])
        new_box = result.box
        # Check no direct src->dst connection remains
        direct = [
            pl for pl in p.lines
            if pl.source_id == src.id and pl.dest_id == dst.id
        ]
        assert len(direct) == 0
        # Check src->new connection
        src_to_new = [
            pl for pl in p.lines
            if pl.source_id == src.id and pl.dest_id == new_box.id
        ]
        assert len(src_to_new) == 1
        # Check new->dst connection
        new_to_dst = [
            pl for pl in p.lines
            if pl.source_id == new_box.id and pl.dest_id == dst.id
        ]
        assert len(new_to_dst) == 1

    def test_orphaned_list_details(self):
        """Orphaned list has correct connection details for excess connections."""
        from src.maxpat.patcher import EditResult
        p = Patcher()
        # trigger has variable outlets; trigger b b has 2 outlets
        src = p.add_box("trigger", args=["b", "b", "b"])
        dst = p.add_box("pack", args=["0", "0", "0"])
        # Create 3 connections: outlet 0->0, outlet 1->1, outlet 2->2
        p.add_connection(src, 0, dst, 0)
        p.add_connection(src, 1, dst, 1)
        p.add_connection(src, 2, dst, 2)
        # Insert toggle (1 inlet, 1 outlet) -- can only handle index 0
        result = p.insert_into_connection(src, dst, "toggle")
        assert len(result.orphaned) == 2
        # Orphaned should be the connections at index 1 and 2
        orphan_outlets = sorted([o["source_outlet"] for o in result.orphaned])
        assert orphan_outlets == [1, 2]


class TestDownstream:
    """ED-04: downstream graph traversal."""

    def test_linear_chain(self):
        """A->B->C: downstream(A) returns [B, C]."""
        p = Patcher()
        a = p.add_box("cycle~", args=["440"])
        b = p.add_box("*~", args=["0.5"])
        c = p.add_box("dac~")
        p.add_connection(a, 0, b, 0)
        p.add_connection(b, 0, c, 0)
        result = p.downstream(a)
        assert result == [b, c]

    def test_branching_left_to_right(self):
        """Branching: outlet 0 targets come before outlet 1 targets."""
        p = Patcher()
        src = p.add_box("trigger", args=["b", "b"])
        left = p.add_box("toggle")
        right = p.add_box("button")
        # outlet 0 -> left, outlet 1 -> right
        p.add_connection(src, 0, left, 0)
        p.add_connection(src, 1, right, 0)
        result = p.downstream(src)
        assert result == [left, right]

    def test_signal_only_filters_control(self):
        """signal_only=True skips non-~ boxes."""
        p = Patcher()
        osc = p.add_box("cycle~", args=["440"])
        gain = p.add_box("*~", args=["0.5"])
        meter = p.add_box("meter~")
        # Also connect osc to a control object via snapshot~->print
        snap = p.add_box("snapshot~", args=["50"])
        prnt = p.add_box("print")
        p.add_connection(osc, 0, gain, 0)
        p.add_connection(gain, 0, meter, 0)
        p.add_connection(osc, 0, snap, 0)
        p.add_connection(snap, 0, prnt, 0)
        result = p.downstream(osc, signal_only=True)
        # snapshot~ ends with ~ so it IS included, but print does not
        assert gain in result
        assert meter in result
        assert snap in result
        assert prnt not in result

    def test_empty_when_no_downstream(self):
        """Sink box with no outgoing connections returns empty list."""
        p = Patcher()
        a = p.add_box("dac~")
        result = p.downstream(a)
        assert result == []

    def test_feedback_loop_terminates(self):
        """Visited set prevents infinite loop in feedback patches."""
        p = Patcher()
        a = p.add_box("cycle~", args=["440"])
        b = p.add_box("*~", args=["0.5"])
        # Create feedback: a->b and b->a
        p.add_connection(a, 0, b, 0)
        p.add_connection(b, 0, a, 0)
        result = p.downstream(a)
        assert b in result
        # a should NOT be in result (starting box excluded), but loop terminates
        assert a not in result

    def test_valueerror_on_missing_box(self):
        """Raises ValueError if box is not in this patcher."""
        p = Patcher()
        p.add_box("cycle~", args=["440"])
        other_p = Patcher()
        foreign_box = other_p.add_box("dac~")
        with pytest.raises(ValueError, match="not in this patcher"):
            p.downstream(foreign_box)

    def test_starting_box_not_in_result(self):
        """Starting box is excluded from the returned list."""
        p = Patcher()
        a = p.add_box("cycle~", args=["440"])
        b = p.add_box("dac~")
        p.add_connection(a, 0, b, 0)
        result = p.downstream(a)
        assert a not in result
        assert b in result

    def test_subpatcher_crossing_downstream(self):
        """Traversal crosses into subpatcher via inlet objects."""
        p = Patcher()
        osc = p.add_box("cycle~", args=["440"])
        # Create a subpatcher with 1 inlet, 1 outlet
        sub_box, inner = p.add_subpatcher("mysub", inlets=1, outlets=1)
        out = p.add_box("dac~")
        # Connect osc -> subpatcher inlet 0
        p.add_connection(osc, 0, sub_box, 0)
        # Connect subpatcher outlet 0 -> dac~
        p.add_connection(sub_box, 0, out, 0)
        # Inside subpatcher: wire inlet -> some_box -> outlet
        inner_boxes = inner.boxes  # inlet at index 0, outlet at index 1
        inner_gain = inner.add_box("*~", args=["0.5"])
        inner.add_connection(inner_boxes[0], 0, inner_gain, 0)
        inner.add_connection(inner_gain, 0, inner_boxes[1], 0)
        # downstream(osc) should see: sub_box, inner_gain, out
        result = p.downstream(osc)
        assert sub_box in result
        assert inner_gain in result
        assert out in result


class TestUpstream:
    """ED-04: upstream graph traversal."""

    def test_linear_chain_upstream(self):
        """A->B->C: upstream(C) returns [B, A]."""
        p = Patcher()
        a = p.add_box("cycle~", args=["440"])
        b = p.add_box("*~", args=["0.5"])
        c = p.add_box("dac~")
        p.add_connection(a, 0, b, 0)
        p.add_connection(b, 0, c, 0)
        result = p.upstream(c)
        assert result == [b, a]

    def test_signal_only_filters_control(self):
        """signal_only=True skips non-~ boxes upstream."""
        p = Patcher()
        osc = p.add_box("cycle~", args=["440"])
        gain = p.add_box("*~", args=["0.5"])
        out = p.add_box("dac~")
        # Also a control path into gain
        slider = p.add_box("slider")
        p.add_connection(osc, 0, gain, 0)
        p.add_connection(slider, 0, gain, 1)
        p.add_connection(gain, 0, out, 0)
        result = p.upstream(out, signal_only=True)
        assert gain in result
        assert osc in result
        assert slider not in result

    def test_empty_when_no_upstream(self):
        """Source box with no incoming connections returns empty list."""
        p = Patcher()
        a = p.add_box("cycle~", args=["440"])
        result = p.upstream(a)
        assert result == []

    def test_valueerror_on_missing_box(self):
        """Raises ValueError if box is not in this patcher."""
        p = Patcher()
        p.add_box("dac~")
        other_p = Patcher()
        foreign = other_p.add_box("cycle~", args=["440"])
        with pytest.raises(ValueError, match="not in this patcher"):
            p.upstream(foreign)

    def test_subpatcher_crossing_upstream(self):
        """Traversal crosses into subpatcher via outlet objects upstream."""
        p = Patcher()
        osc = p.add_box("cycle~", args=["440"])
        sub_box, inner = p.add_subpatcher("mysub", inlets=1, outlets=1)
        out = p.add_box("dac~")
        p.add_connection(osc, 0, sub_box, 0)
        p.add_connection(sub_box, 0, out, 0)
        # Inside: inlet -> gain -> outlet
        inner_boxes = inner.boxes
        inner_gain = inner.add_box("*~", args=["0.5"])
        inner.add_connection(inner_boxes[0], 0, inner_gain, 0)
        inner.add_connection(inner_gain, 0, inner_boxes[1], 0)
        # upstream(out) should see: sub_box, inner_gain, osc
        result = p.upstream(out)
        assert sub_box in result
        assert inner_gain in result
        assert osc in result

    def test_starting_box_excluded(self):
        """Starting box is never in the result."""
        p = Patcher()
        a = p.add_box("cycle~", args=["440"])
        b = p.add_box("dac~")
        p.add_connection(a, 0, b, 0)
        result = p.upstream(b)
        assert b not in result


class TestSignalPath:
    """ED-04: signal-only path tracing."""

    def test_linear_audio_chain(self):
        """cycle~->*~->dac~ returns full ordered path through the box."""
        p = Patcher()
        osc = p.add_box("cycle~", args=["440"])
        gain = p.add_box("*~", args=["0.5"])
        out = p.add_box("dac~")
        p.add_connection(osc, 0, gain, 0)
        p.add_connection(gain, 0, out, 0)
        result = p.signal_path(gain)
        # upstream reversed + [gain] + downstream
        assert result == [osc, gain, out]

    def test_mixed_signal_control_returns_only_tilde(self):
        """Non-~ boxes are excluded from signal path."""
        p = Patcher()
        osc = p.add_box("cycle~", args=["440"])
        gain = p.add_box("*~", args=["0.5"])
        out = p.add_box("dac~")
        slider = p.add_box("slider")
        prnt = p.add_box("print")
        p.add_connection(osc, 0, gain, 0)
        p.add_connection(slider, 0, gain, 1)
        p.add_connection(gain, 0, out, 0)
        p.add_connection(gain, 0, prnt, 0)  # control connection from ~ to non-~
        result = p.signal_path(gain)
        assert osc in result
        assert gain in result
        assert out in result
        assert slider not in result
        assert prnt not in result

    def test_single_tilde_object_no_connections(self):
        """Single ~ object with no connections returns just itself."""
        p = Patcher()
        osc = p.add_box("cycle~", args=["440"])
        result = p.signal_path(osc)
        assert result == [osc]

    def test_non_tilde_box_returns_upstream_and_downstream_signal(self):
        """Non-~ box in signal_path returns only the ~ upstream/downstream."""
        p = Patcher()
        osc = p.add_box("cycle~", args=["440"])
        gain = p.add_box("*~", args=["0.5"])
        out = p.add_box("dac~")
        prnt = p.add_box("print")
        p.add_connection(osc, 0, gain, 0)
        p.add_connection(gain, 0, out, 0)
        p.add_connection(osc, 0, prnt, 0)
        # print is not ~, so signal_path(print) returns just the signal parts
        result = p.signal_path(prnt)
        assert prnt not in result  # non-~ box itself excluded
        # No signal-only upstream or downstream from print
        assert result == []

    def test_valueerror_on_missing_box(self):
        """Raises ValueError if box is not in patcher."""
        p = Patcher()
        p.add_box("cycle~", args=["440"])
        other_p = Patcher()
        foreign = other_p.add_box("dac~")
        with pytest.raises(ValueError, match="not in this patcher"):
            p.signal_path(foreign)


class TestConnectedComponents:
    """ED-04: connected component detection."""

    def test_two_separate_groups(self):
        """Two disconnected groups detected as separate components."""
        p = Patcher()
        a = p.add_box("cycle~", args=["440"])
        b = p.add_box("dac~")
        p.add_connection(a, 0, b, 0)
        c = p.add_box("toggle")
        d = p.add_box("print")
        p.add_connection(c, 0, d, 0)
        result = p.connected_components()
        assert len(result) == 2
        # Each group has 2 boxes
        sizes = sorted([len(g) for g in result])
        assert sizes == [2, 2]

    def test_single_connected_patch(self):
        """Fully connected patch returns one component."""
        p = Patcher()
        a = p.add_box("cycle~", args=["440"])
        b = p.add_box("*~", args=["0.5"])
        c = p.add_box("dac~")
        p.add_connection(a, 0, b, 0)
        p.add_connection(b, 0, c, 0)
        result = p.connected_components()
        assert len(result) == 1
        assert len(result[0]) == 3

    def test_disconnected_objects_as_single_groups(self):
        """Disconnected objects (no connections) returned as single-element groups."""
        p = Patcher()
        a = p.add_box("cycle~", args=["440"])
        b = p.add_box("toggle")
        # No connections -- both are isolated
        result = p.connected_components()
        assert len(result) == 2
        sizes = sorted([len(g) for g in result])
        assert sizes == [1, 1]

    def test_empty_patcher_returns_empty_list(self):
        """Empty patcher has no components."""
        p = Patcher()
        result = p.connected_components()
        assert result == []

    def test_components_sorted_largest_first(self):
        """Components are sorted by size, largest first."""
        p = Patcher()
        # Group 1: 3 boxes
        a = p.add_box("cycle~", args=["440"])
        b = p.add_box("*~", args=["0.5"])
        c = p.add_box("dac~")
        p.add_connection(a, 0, b, 0)
        p.add_connection(b, 0, c, 0)
        # Group 2: 2 boxes
        d = p.add_box("toggle")
        e = p.add_box("print")
        p.add_connection(d, 0, e, 0)
        # Group 3: 1 isolated box
        p.add_box("button")
        result = p.connected_components()
        assert len(result) == 3
        assert len(result[0]) == 3  # largest first
        assert len(result[1]) == 2
        assert len(result[2]) == 1


# ---------------------------------------------------------------------------
# TestSubpatcherInletHelpers
# ---------------------------------------------------------------------------

class TestSubpatcherInletHelpers:
    """Tests for get_inlets() and get_outlets() helpers."""

    def test_get_inlets_returns_inlet_boxes(self):
        from src.maxpat import Patcher
        p = Patcher()
        _, inner = p.add_subpatcher("sub", inlets=3, outlets=1)
        inlets = inner.get_inlets()
        assert len(inlets) == 3
        assert all(b.maxclass == "inlet" for b in inlets)

    def test_get_outlets_returns_outlet_boxes(self):
        from src.maxpat import Patcher
        p = Patcher()
        _, inner = p.add_subpatcher("sub", inlets=1, outlets=2)
        outlets = inner.get_outlets()
        assert len(outlets) == 2
        assert all(b.maxclass == "outlet" for b in outlets)

    def test_get_inlets_sorted_by_x(self):
        from src.maxpat import Patcher
        p = Patcher()
        _, inner = p.add_subpatcher("sub", inlets=4, outlets=1)
        inlets = inner.get_inlets()
        xs = [b.patching_rect[0] for b in inlets]
        assert xs == sorted(xs)

    def test_get_inlets_empty_for_no_inlets(self):
        from src.maxpat import Patcher
        p = Patcher()
        _, inner = p.add_subpatcher("sub", inlets=0, outlets=1)
        assert inner.get_inlets() == []

    def test_get_inlets_connectable(self):
        """Inlet boxes from get_inlets() can be wired with add_connection."""
        from src.maxpat import Patcher
        p = Patcher()
        _, inner = p.add_subpatcher("sub", inlets=2, outlets=1)
        mul = inner.add_box("*~", args=["0.5"])
        inlets = inner.get_inlets()
        inner.add_connection(inlets[0], 0, mul, 0)
        assert len(inner.lines) == 1


# ---------------------------------------------------------------------------
# TestLiveScopeOverride
# ---------------------------------------------------------------------------

class TestLiveScopeOverride:
    """Verify live.scope~ has correct I/O from override."""

    def test_live_scope_has_signal_inlets(self):
        from src.maxpat import Patcher
        p = Patcher()
        box = p.add_box("live.scope~")
        assert box.numinlets == 2
        assert box.numoutlets == 0

    def test_live_scope_connectable(self):
        """Can connect signal sources to live.scope~ inlets."""
        from src.maxpat import Patcher
        p = Patcher()
        osc = p.add_box("cycle~", args=["440"])
        scope = p.add_box("live.scope~")
        p.add_connection(osc, 0, scope, 0)
        assert len(p.lines) == 1


class TestPackageGating:
    """PKG-12: Patcher(allowed_packages=...) gates Box creation for package objects."""

    def test_no_allowed_packages_allows_all(self):
        """Backward compat: Patcher() with no allowed_packages creates any object."""
        p = Patcher()
        box = p.add_box("abl.device.autofilter~")
        assert box.name == "abl.device.autofilter~"

    def test_empty_allowed_raises_for_package_object(self):
        """allowed_packages=[] means core only -- package objects raise ValueError."""
        p = Patcher(allowed_packages=[])
        with pytest.raises(ValueError, match="Unknown object"):
            p.add_box("abl.device.autofilter~")

    def test_empty_allowed_permits_core_objects(self):
        """allowed_packages=[] still allows core objects like cycle~."""
        p = Patcher(allowed_packages=[])
        box = p.add_box("cycle~", args=["440"])
        assert box.name == "cycle~"

    def test_matching_package_allows_object(self):
        """allowed_packages=["ableton-dsp"] allows ableton-dsp objects."""
        p = Patcher(allowed_packages=["ableton-dsp"])
        box = p.add_box("abl.device.autofilter~")
        assert box.name == "abl.device.autofilter~"

    def test_wrong_package_raises(self):
        """allowed_packages=["BEAP"] rejects ableton-dsp objects."""
        p = Patcher(allowed_packages=["BEAP"])
        with pytest.raises(ValueError, match="Unknown object"):
            p.add_box("abl.device.autofilter~")

    def test_subpatcher_inherits_allowed_packages(self):
        """add_subpatcher inner Patcher inherits allowed_packages from parent."""
        p = Patcher(allowed_packages=["BEAP"])
        _, inner = p.add_subpatcher("test_sub")
        assert inner.allowed_packages == ["BEAP"]

    def test_from_dict_no_gating(self):
        """from_dict() does NOT enforce package gating (loads all objects)."""
        # Create a patch with a package object, serialize, reload
        p = Patcher()
        p.add_box("abl.device.autofilter~")
        d = p.to_dict()
        # Load it back -- should NOT raise even though the object is a package object
        loaded = Patcher.from_dict(d)
        assert len(loaded.boxes) == 1
        assert loaded.boxes[0].name == "abl.device.autofilter~"
