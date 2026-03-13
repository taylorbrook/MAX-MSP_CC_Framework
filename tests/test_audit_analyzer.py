"""Tests for the audit analyzer module.

Tests the 5 analysis dimensions: outlet types, I/O counts, box widths,
argument formats, and connection patterns. Uses BoxInstance fixtures
and mock/real ObjectDatabase for DB comparison.
"""

from unittest.mock import MagicMock

from src.maxpat.audit import BoxInstance
from src.maxpat.audit.analyzer import (
    AuditAnalyzer,
    ObjectFindings,
    classify_outlet_type,
    compute_confidence,
)


# ---------------------------------------------------------------------------
# Fixtures
# ---------------------------------------------------------------------------


def make_box(
    name: str = "cycle~",
    text: str = "cycle~ 440",
    numinlets: int = 2,
    numoutlets: int = 1,
    outlettype: list[str] | None = None,
    patching_rect: list[float] | None = None,
    box_id: str = "obj-1",
    depth: int = 0,
    is_connected: bool = True,
    connections: list[tuple] | None = None,
    source_file: str = "cycle~.maxhelp",
) -> BoxInstance:
    """Create a BoxInstance with sensible defaults for testing."""
    return BoxInstance(
        name=name,
        text=text,
        numinlets=numinlets,
        numoutlets=numoutlets,
        outlettype=outlettype if outlettype is not None else ["signal"],
        patching_rect=patching_rect if patching_rect is not None else [100.0, 200.0, 85.0, 22.0],
        box_id=box_id,
        depth=depth,
        is_connected=is_connected,
        connections=connections if connections is not None else [],
        source_file=source_file,
    )


def make_db_mock(
    outlet_types: list[str] | None = None,
    io_counts: tuple[int, int] = (2, 1),
    obj_data: dict | None = None,
) -> MagicMock:
    """Create a mock ObjectDatabase with configurable return values."""
    db = MagicMock()
    db.get_outlet_types.return_value = outlet_types if outlet_types is not None else ["signal"]
    db.compute_io_counts.return_value = io_counts
    db.lookup.return_value = obj_data if obj_data is not None else {
        "inlets": [{"id": 0}, {"id": 1}],
        "outlets": [{"id": 0, "signal": True}],
        "variable_io": False,
    }
    return db


# ---------------------------------------------------------------------------
# classify_outlet_type tests
# ---------------------------------------------------------------------------


class TestClassifyOutletType:
    """Test outlet type classification from help patch strings."""

    def test_signal_type(self):
        is_signal, label = classify_outlet_type("signal")
        assert is_signal is True
        assert label == "signal"

    def test_multichannelsignal_type(self):
        is_signal, label = classify_outlet_type("multichannelsignal")
        assert is_signal is True
        assert label == "multichannelsignal"

    def test_empty_string_is_control(self):
        is_signal, label = classify_outlet_type("")
        assert is_signal is False
        assert label == ""

    def test_bang_is_control(self):
        is_signal, label = classify_outlet_type("bang")
        assert is_signal is False
        assert label == ""

    def test_int_is_control(self):
        is_signal, label = classify_outlet_type("int")
        assert is_signal is False
        assert label == ""

    def test_float_is_control(self):
        is_signal, label = classify_outlet_type("float")
        assert is_signal is False
        assert label == ""


# ---------------------------------------------------------------------------
# compute_confidence tests
# ---------------------------------------------------------------------------


class TestComputeConfidence:
    """Test confidence scoring from instance agreement."""

    def test_all_agree_high(self):
        """5/5 agreeing instances returns HIGH."""
        instances = [1, 1, 1, 1, 1]
        level, ratio, value = compute_confidence(instances, lambda x: x)
        assert level == "HIGH"
        assert ratio == 1.0
        assert value == 1

    def test_three_of_four_medium(self):
        """3/4 agreeing returns MEDIUM."""
        instances = ["a", "a", "a", "b"]
        level, ratio, value = compute_confidence(instances, lambda x: x)
        assert level == "MEDIUM"
        assert ratio == 0.75
        assert value == "a"

    def test_three_of_five_low(self):
        """3/5 agreeing returns LOW."""
        instances = ["a", "a", "a", "b", "c"]
        level, ratio, value = compute_confidence(instances, lambda x: x)
        assert level == "LOW"
        assert ratio == 0.6
        assert value == "a"

    def test_two_of_five_conflict(self):
        """2/5 agreeing returns CONFLICT."""
        instances = ["a", "a", "b", "c", "d"]
        level, ratio, value = compute_confidence(instances, lambda x: x)
        assert level == "CONFLICT"
        assert ratio == 0.4
        assert value == "a"

    def test_empty_list_none(self):
        """Empty list returns NONE."""
        level, ratio, value = compute_confidence([], lambda x: x)
        assert level == "NONE"
        assert ratio == 0.0
        assert value is None


# ---------------------------------------------------------------------------
# Outlet type analysis tests
# ---------------------------------------------------------------------------


class TestAnalyzeOutletTypes:
    """Test outlet type comparison against DB."""

    def test_detects_signal_control_mismatch(self):
        """DB says all-signal but help patch shows mixed signal/control."""
        db = make_db_mock(outlet_types=["signal", "signal"])
        analyzer = AuditAnalyzer(db)

        # Help patches show outlet 0 is signal, outlet 1 is control ("")
        instances = [
            make_box(outlettype=["signal", ""], numoutlets=2, box_id="obj-1"),
            make_box(outlettype=["signal", ""], numoutlets=2, box_id="obj-2"),
            make_box(outlettype=["signal", ""], numoutlets=2, box_id="obj-3"),
        ]

        finding = analyzer.analyze_outlet_types("cycle~", instances)
        assert finding is not None
        assert finding["db_types"] == ["signal", "signal"]
        # The help patches show different types than the DB
        assert finding["discrepancy_type"] is not None

    def test_no_flag_int_float_variation(self):
        """int vs float variation is NOT a signal/control discrepancy -- both are control."""
        db = make_db_mock(outlet_types=["", ""])
        analyzer = AuditAnalyzer(db)

        # Some help patches say "int", others say "float" -- both are control
        instances = [
            make_box(outlettype=["int", "float"], numoutlets=2, box_id="obj-1"),
            make_box(outlettype=["bang", ""], numoutlets=2, box_id="obj-2"),
            make_box(outlettype=["", "int"], numoutlets=2, box_id="obj-3"),
        ]

        finding = analyzer.analyze_outlet_types("trigger", instances)
        # Should be None because all outlets are control in both DB and help patches
        assert finding is None

    def test_matching_types_returns_none(self):
        """When DB and help patches agree, no finding returned."""
        db = make_db_mock(outlet_types=["signal"])
        analyzer = AuditAnalyzer(db)

        instances = [
            make_box(outlettype=["signal"], numoutlets=1, box_id="obj-1"),
            make_box(outlettype=["signal"], numoutlets=1, box_id="obj-2"),
        ]

        finding = analyzer.analyze_outlet_types("cycle~", instances)
        assert finding is None


# ---------------------------------------------------------------------------
# I/O count analysis tests
# ---------------------------------------------------------------------------


class TestAnalyzeIoCounts:
    """Test inlet/outlet count validation."""

    def test_variable_io_from_arguments(self):
        """Variable I/O objects use argument-computed expected counts."""
        db = make_db_mock(
            obj_data={"inlets": [{"id": 0}], "outlets": [{"id": 0}], "variable_io": True},
        )
        # Trigger with args ["b", "i", "f"] -> 1 inlet, 3 outlets
        # Default (no args) -> 1 inlet, 1 outlet
        def compute_io_side_effect(name, args=None):
            if args and len(args) == 3:
                return (1, 3)
            return (1, 1)

        db.compute_io_counts.side_effect = compute_io_side_effect
        analyzer = AuditAnalyzer(db)

        instances = [
            make_box(
                name="trigger",
                text="trigger b i f",
                numinlets=1,
                numoutlets=3,
                outlettype=["bang", "int", "float"],
                box_id="obj-1",
            ),
        ]

        # DB should be called with args from the text
        finding = analyzer.analyze_io_counts("trigger", instances)
        # When counts match the computed values, no finding
        assert finding is None

    def test_fixed_io_mismatch(self):
        """Fixed I/O object count mismatch flagged."""
        db = make_db_mock(
            io_counts=(2, 1),
            obj_data={"inlets": [{"id": 0}, {"id": 1}], "outlets": [{"id": 0}], "variable_io": False},
        )
        analyzer = AuditAnalyzer(db)

        # Help patch says 3 inlets but DB says 2
        instances = [
            make_box(name="cycle~", text="cycle~", numinlets=3, numoutlets=1, box_id="obj-1"),
            make_box(name="cycle~", text="cycle~", numinlets=3, numoutlets=1, box_id="obj-2"),
        ]

        finding = analyzer.analyze_io_counts("cycle~", instances)
        assert finding is not None
        assert finding["db_inlets"] == 2
        assert finding["help_inlets"] is not None

    def test_matching_counts_returns_none(self):
        """When counts match, no finding returned."""
        db = make_db_mock(
            io_counts=(2, 1),
            obj_data={"inlets": [{"id": 0}, {"id": 1}], "outlets": [{"id": 0}], "variable_io": False},
        )
        analyzer = AuditAnalyzer(db)

        instances = [
            make_box(name="cycle~", text="cycle~", numinlets=2, numoutlets=1, box_id="obj-1"),
        ]

        finding = analyzer.analyze_io_counts("cycle~", instances)
        assert finding is None
