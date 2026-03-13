"""Tests for help patch parser: recursive descent, parse_object_text, and connections."""

import json
from pathlib import Path

import pytest

from src.maxpat.audit import BoxInstance
from src.maxpat.audit.parser import (
    HelpPatchParser,
    parse_object_text,
    traverse_patcher,
)


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
