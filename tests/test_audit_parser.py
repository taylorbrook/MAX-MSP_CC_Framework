"""Tests for help patch parser: recursive descent, parse_object_text, and connections."""

import json
from pathlib import Path

import pytest

from src.maxpat.audit import BoxInstance
from src.maxpat.audit.parser import (
    HelpPatchParser,
    filter_degenerate,
    is_degenerate,
    parse_object_text,
    traverse_patcher,
)
from src.maxpat.db_lookup import ObjectDatabase


FIXTURE_PATH = Path(__file__).parent / "fixtures" / "sample_help.json"


@pytest.fixture
def sample_patcher():
    """Load the sample help fixture's top-level patcher."""
    with open(FIXTURE_PATH) as f:
        data = json.load(f)
    return data["patcher"]


@pytest.fixture
def all_instances(sample_patcher):
    """All BoxInstance objects extracted from the sample fixture."""
    return traverse_patcher(sample_patcher, depth=0, source_file="sample_help.json")


# ---------------------------------------------------------------------------
# Test: top-level extraction
# ---------------------------------------------------------------------------

class TestTopLevelExtraction:
    """Parsing a help file with top-level newobj boxes extracts all instances
    with correct name, text, numinlets, numoutlets, outlettype, patching_rect."""

    def test_top_level_newobj_count(self, all_instances):
        top_level = [i for i in all_instances if i.depth == 0]
        # cycle~ 440, dac~, and p basic (which is a newobj subpatcher)
        assert len(top_level) == 3

    def test_cycle_instance_fields(self, all_instances):
        cycle = [i for i in all_instances if i.name == "cycle~"][0]
        assert cycle.text == "cycle~ 440"
        assert cycle.numinlets == 2
        assert cycle.numoutlets == 1
        assert cycle.outlettype == ["signal"]
        assert cycle.patching_rect == [100.0, 100.0, 80.0, 22.0]
        assert cycle.box_id == "obj-1"
        assert cycle.depth == 0

    def test_dac_instance_fields(self, all_instances):
        dac = [i for i in all_instances if i.name == "dac~"][0]
        assert dac.numoutlets == 0
        assert dac.outlettype == []


# ---------------------------------------------------------------------------
# Test: subpatcher descent (depth 1)
# ---------------------------------------------------------------------------

class TestSubpatcherDepth1:
    """Parsing a help file with subpatcher tabs (depth 1) finds instances inside."""

    def test_depth1_instances_found(self, all_instances):
        depth1 = [i for i in all_instances if i.depth == 1]
        # trigger b i, print, and p details (newobj subpatcher)
        assert len(depth1) == 3

    def test_trigger_at_depth1(self, all_instances):
        trigger = [i for i in all_instances if i.name == "trigger"][0]
        assert trigger.depth == 1
        assert trigger.text == "trigger b i"

    def test_print_at_depth1(self, all_instances):
        pr = [i for i in all_instances if i.name == "print"][0]
        assert pr.depth == 1


# ---------------------------------------------------------------------------
# Test: nested subpatcher descent (depth 2)
# ---------------------------------------------------------------------------

class TestSubpatcherDepth2:
    """Parsing a help file with nested subpatchers (depth 2) finds instances at all levels."""

    def test_depth2_instances_found(self, all_instances):
        depth2 = [i for i in all_instances if i.depth == 2]
        # metro 500 and counter 16
        assert len(depth2) == 2

    def test_metro_at_depth2(self, all_instances):
        metro = [i for i in all_instances if i.name == "metro"][0]
        assert metro.depth == 2
        assert metro.text == "metro 500"

    def test_total_instances_all_depths(self, all_instances):
        # depth 0: cycle~, dac~, p (3)
        # depth 1: trigger, print, p (3)
        # depth 2: metro, counter (2)
        assert len(all_instances) == 8


# ---------------------------------------------------------------------------
# Test: non-newobj boxes are excluded
# ---------------------------------------------------------------------------

class TestNonNewobjExclusion:
    """Non-newobj boxes (comment, message, number, button, toggle) are not extracted."""

    def test_comment_not_extracted(self, all_instances):
        names = [i.name for i in all_instances]
        # The comment "This is a help patch" should not appear
        assert "comment" not in names
        assert "This" not in names

    def test_message_not_extracted(self, all_instances):
        names = [i.name for i in all_instances]
        assert "message" not in names
        assert "start" not in names


# ---------------------------------------------------------------------------
# Test: connection data
# ---------------------------------------------------------------------------

class TestConnectionData:
    """Connection data is correctly associated with each box."""

    def test_cycle_is_connected(self, all_instances):
        cycle = [i for i in all_instances if i.name == "cycle~"][0]
        assert cycle.is_connected is True

    def test_dac_is_connected(self, all_instances):
        dac = [i for i in all_instances if i.name == "dac~"][0]
        assert dac.is_connected is True

    def test_cycle_connections(self, all_instances):
        cycle = [i for i in all_instances if i.name == "cycle~"][0]
        # cycle~ -> dac~ connection
        assert len(cycle.connections) == 1
        src_id, src_outlet, dst_id, dst_inlet = cycle.connections[0]
        assert src_id == "obj-1"
        assert src_outlet == 0
        assert dst_id == "obj-2"
        assert dst_inlet == 0


# ---------------------------------------------------------------------------
# Test: connection scoping
# ---------------------------------------------------------------------------

class TestConnectionScoping:
    """Box connections are scoped per-patcher -- boxes in different subpatchers
    with same ID do not cross-contaminate."""

    def test_depth2_connections_scoped(self, all_instances):
        """metro and counter are connected at depth 2, not to depth-0 boxes."""
        metro = [i for i in all_instances if i.name == "metro"][0]
        assert metro.is_connected is True
        assert len(metro.connections) == 1
        # metro (obj-9) connects to counter (obj-10)
        src_id, src_outlet, dst_id, dst_inlet = metro.connections[0]
        assert src_id == "obj-9"
        assert dst_id == "obj-10"

    def test_depth1_connections_scoped(self, all_instances):
        """trigger and print are connected at depth 1."""
        trigger = [i for i in all_instances if i.name == "trigger"][0]
        assert trigger.is_connected is True
        pr = [i for i in all_instances if i.name == "print"][0]
        assert pr.is_connected is True


# ---------------------------------------------------------------------------
# Test: parse_object_text
# ---------------------------------------------------------------------------

class TestParseObjectText:
    """parse_object_text correctly splits object text into name, args, attributes."""

    def test_simple_args(self):
        name, args, attrs = parse_object_text("cycle~ 440")
        assert name == "cycle~"
        assert args == ["440"]
        assert attrs == {}

    def test_attribute_syntax(self):
        name, args, attrs = parse_object_text("line~ @activeout 1")
        assert name == "line~"
        assert args == []
        assert attrs == {"activeout": "1"}

    def test_multiple_positional_args(self):
        name, args, attrs = parse_object_text("t b i f")
        assert name == "t"
        assert args == ["b", "i", "f"]
        assert attrs == {}

    def test_empty_text(self):
        name, args, attrs = parse_object_text("")
        assert name == ""
        assert args == []
        assert attrs == {}


# ---------------------------------------------------------------------------
# Test: HelpPatchParser.parse_file
# ---------------------------------------------------------------------------

class TestHelpPatchParser:
    """HelpPatchParser.parse_file loads a JSON file and returns BoxInstances."""

    def test_parse_file_returns_instances(self):
        parser = HelpPatchParser()
        instances = parser.parse_file(FIXTURE_PATH)
        assert len(instances) == 8

    def test_parse_file_sets_source_file(self):
        parser = HelpPatchParser()
        instances = parser.parse_file(FIXTURE_PATH)
        for inst in instances:
            assert str(FIXTURE_PATH) in inst.source_file or FIXTURE_PATH.name in inst.source_file


# ---------------------------------------------------------------------------
# Test: degenerate instance filtering
# ---------------------------------------------------------------------------

@pytest.fixture
def db():
    """ObjectDatabase loaded with default DB for realistic filtering tests."""
    return ObjectDatabase()


class TestDegenerateFiltering:
    """Degenerate instance filtering identifies label objects while preserving
    legitimate sinks and connected instances."""

    def test_unconnected_matching_io_is_not_filtered(self, db):
        """An unconnected box whose I/O counts match the DB is NOT filtered.
        e.g., print has 1 inlet, 0 outlets in DB."""
        inst = BoxInstance(
            name="print",
            text="print",
            numinlets=1,
            numoutlets=0,
            outlettype=[],
            patching_rect=[0, 0, 33, 22],
            box_id="obj-1",
            depth=0,
            is_connected=False,
        )
        assert is_degenerate(inst, db) is False

    def test_unconnected_mismatched_io_is_filtered(self, db):
        """An unconnected box whose I/O counts do NOT match the DB IS filtered.
        e.g., a cycle~ used as a label with numinlets=0, numoutlets=0."""
        inst = BoxInstance(
            name="cycle~",
            text="cycle~",
            numinlets=0,
            numoutlets=0,
            outlettype=[],
            patching_rect=[0, 0, 50, 22],
            box_id="obj-2",
            depth=0,
            is_connected=False,
        )
        assert is_degenerate(inst, db) is True

    def test_connected_box_never_filtered(self, db):
        """A connected box is NEVER filtered, regardless of I/O count mismatch."""
        inst = BoxInstance(
            name="cycle~",
            text="cycle~",
            numinlets=0,
            numoutlets=0,
            outlettype=[],
            patching_rect=[0, 0, 50, 22],
            box_id="obj-3",
            depth=0,
            is_connected=True,
        )
        assert is_degenerate(inst, db) is False

    def test_unknown_object_no_connections_is_filtered(self, db):
        """An unknown object (not in DB) with no connections IS filtered."""
        inst = BoxInstance(
            name="totally_fake_object_xyz",
            text="totally_fake_object_xyz",
            numinlets=1,
            numoutlets=1,
            outlettype=[""],
            patching_rect=[0, 0, 100, 22],
            box_id="obj-4",
            depth=0,
            is_connected=False,
        )
        assert is_degenerate(inst, db) is True

    def test_variable_io_unconnected_not_filtered(self, db):
        """A variable_io object with no connections is NOT filtered
        (can't reliably determine expected counts)."""
        inst = BoxInstance(
            name="trigger",
            text="trigger b i f",
            numinlets=1,
            numoutlets=3,
            outlettype=["bang", "int", "float"],
            patching_rect=[0, 0, 80, 22],
            box_id="obj-5",
            depth=0,
            is_connected=False,
        )
        assert is_degenerate(inst, db) is False

    def test_legitimate_sinks_not_filtered(self, db):
        """Legitimate sink objects (dac~, print, send) with 0 outlets and no
        outgoing connections are NOT filtered when their counts match DB."""
        # dac~ has 2 inlets and 0 outlets in the DB
        inst = BoxInstance(
            name="dac~",
            text="dac~",
            numinlets=2,
            numoutlets=0,
            outlettype=[],
            patching_rect=[0, 0, 35, 22],
            box_id="obj-6",
            depth=0,
            is_connected=False,
        )
        assert is_degenerate(inst, db) is False

    def test_filter_degenerate_preserves_order(self, db):
        """filter_degenerate returns non-degenerate instances in original order."""
        good = BoxInstance(
            name="print", text="print", numinlets=1, numoutlets=0,
            outlettype=[], patching_rect=[0, 0, 33, 22], box_id="obj-1",
            depth=0, is_connected=False,
        )
        bad = BoxInstance(
            name="cycle~", text="cycle~", numinlets=0, numoutlets=0,
            outlettype=[], patching_rect=[0, 0, 50, 22], box_id="obj-2",
            depth=0, is_connected=False,
        )
        good2 = BoxInstance(
            name="metro", text="metro 500", numinlets=2, numoutlets=1,
            outlettype=["bang"], patching_rect=[0, 0, 68, 22], box_id="obj-3",
            depth=0, is_connected=True,
        )
        result = filter_degenerate([good, bad, good2], db)
        assert len(result) == 2
        assert result[0].name == "print"
        assert result[1].name == "metro"


class TestParseFileWithFiltering:
    """HelpPatchParser.parse_file with db parameter applies degenerate filtering."""

    def test_parse_file_with_db_filters(self, db):
        parser = HelpPatchParser()
        # Without DB: all instances
        all_inst = parser.parse_file(FIXTURE_PATH)
        # With DB: filtered instances (some may be removed)
        filtered_inst = parser.parse_file(FIXTURE_PATH, db=db)
        assert len(filtered_inst) <= len(all_inst)

    def test_parse_file_without_db_no_filtering(self):
        parser = HelpPatchParser()
        instances = parser.parse_file(FIXTURE_PATH)
        assert len(instances) == 8  # All instances returned
