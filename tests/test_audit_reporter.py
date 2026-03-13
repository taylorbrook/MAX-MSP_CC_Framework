"""Tests for audit reporting and override generation modules.

Tests the report generation, dimension filtering, empty I/O coverage
tracking, and proposed override generation with manual entry protection.
"""

from unittest.mock import MagicMock

from src.maxpat.audit import BoxInstance
from src.maxpat.audit.analyzer import ObjectFindings


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


def make_findings(
    name: str = "test_obj",
    instance_count: int = 5,
    outlet_type_finding: dict | None = None,
    io_count_finding: dict | None = None,
    width_finding: dict | None = None,
    argument_finding: dict | None = None,
    connection_finding: dict | None = None,
) -> ObjectFindings:
    """Create an ObjectFindings with configurable findings."""
    return ObjectFindings(
        object_name=name,
        instance_count=instance_count,
        outlet_type_finding=outlet_type_finding,
        io_count_finding=io_count_finding,
        width_finding=width_finding,
        argument_finding=argument_finding,
        connection_finding=connection_finding,
    )


def make_db_mock_with_objects(objects: dict | None = None) -> MagicMock:
    """Create a mock ObjectDatabase with a configurable _objects dict."""
    db = MagicMock()
    if objects is None:
        objects = {
            "cycle~": {
                "name": "cycle~",
                "domain": "msp",
                "inlets": [{"id": 0}, {"id": 1}],
                "outlets": [{"id": 0, "signal": True}],
            },
            "trigger": {
                "name": "trigger",
                "domain": "max",
                "inlets": [{"id": 0}],
                "outlets": [{"id": 0}, {"id": 1}],
            },
        }
    db._objects = objects
    return db


# ---------------------------------------------------------------------------
# AuditReporter: Report generation tests
# ---------------------------------------------------------------------------


class TestReportGeneration:
    """Test AuditReporter.generate_report produces valid JSON structure."""

    def test_report_has_per_object_entries_with_discrepancy_dimensions(self):
        """Report contains entries keyed by object name with all finding dimensions."""
        from src.maxpat.audit.reporter import AuditReporter

        db = make_db_mock_with_objects()
        reporter = AuditReporter(db)

        findings = {
            "line~": make_findings(
                name="line~",
                outlet_type_finding={
                    "db_types": ["signal", "signal"],
                    "help_types": ["signal", ""],
                    "confidence": "HIGH",
                    "agreement": 1.0,
                    "discrepancy_type": "signal_control_mismatch",
                    "discrepancies": [{"outlet_index": 1, "db_is_signal": True, "help_is_signal": False}],
                },
            ),
        }

        report = reporter.generate_report(findings, {"files_parsed": 10, "objects_found": 50})
        assert "objects" in report
        assert "line~" in report["objects"]
        entry = report["objects"]["line~"]
        assert "outlet_type_finding" in entry
        assert entry["outlet_type_finding"]["confidence"] == "HIGH"

    def test_report_includes_summary_stats(self):
        """Report includes summary with files_parsed, objects_analyzed, discrepancies_found, by_confidence."""
        from src.maxpat.audit.reporter import AuditReporter

        db = make_db_mock_with_objects()
        reporter = AuditReporter(db)

        findings = {
            "line~": make_findings(
                name="line~",
                outlet_type_finding={
                    "db_types": ["signal", "signal"],
                    "help_types": ["signal", ""],
                    "confidence": "HIGH",
                    "agreement": 1.0,
                    "discrepancy_type": "signal_control_mismatch",
                    "discrepancies": [],
                },
            ),
            "cycle~": make_findings(name="cycle~"),
        }

        report = reporter.generate_report(findings, {"files_parsed": 10, "objects_found": 50})
        assert "summary" in report
        summary = report["summary"]
        assert summary["files_parsed"] == 10
        assert summary["objects_analyzed"] == 2
        assert "discrepancies_found" in summary
        assert "by_confidence" in summary

    def test_report_entries_include_confidence_and_agreement(self):
        """Each finding entry includes confidence level and agreement ratio."""
        from src.maxpat.audit.reporter import AuditReporter

        db = make_db_mock_with_objects()
        reporter = AuditReporter(db)

        findings = {
            "buffer~": make_findings(
                name="buffer~",
                outlet_type_finding={
                    "db_types": ["signal"],
                    "help_types": [""],
                    "confidence": "MEDIUM",
                    "agreement": 0.8,
                    "discrepancy_type": "signal_control_mismatch",
                    "discrepancies": [],
                },
            ),
        }

        report = reporter.generate_report(findings, {"files_parsed": 5})
        entry = report["objects"]["buffer~"]
        assert entry["outlet_type_finding"]["confidence"] == "MEDIUM"
        assert entry["outlet_type_finding"]["agreement"] == 0.8

    def test_report_objects_sorted_alphabetically(self):
        """Report objects are sorted alphabetically by name."""
        from src.maxpat.audit.reporter import AuditReporter

        db = make_db_mock_with_objects()
        reporter = AuditReporter(db)

        findings = {
            "zigzag~": make_findings(
                name="zigzag~",
                outlet_type_finding={"confidence": "HIGH", "agreement": 1.0, "discrepancies": []},
            ),
            "buffer~": make_findings(
                name="buffer~",
                outlet_type_finding={"confidence": "HIGH", "agreement": 1.0, "discrepancies": []},
            ),
            "adc~": make_findings(
                name="adc~",
                io_count_finding={"confidence": "HIGH", "agreement": 1.0},
            ),
        }

        report = reporter.generate_report(findings, {})
        keys = list(report["objects"].keys())
        assert keys == sorted(keys)

    def test_report_only_includes_objects_with_findings(self):
        """Objects with no findings (all None) are excluded from the report."""
        from src.maxpat.audit.reporter import AuditReporter

        db = make_db_mock_with_objects()
        reporter = AuditReporter(db)

        findings = {
            "cycle~": make_findings(name="cycle~"),  # all findings are None
            "line~": make_findings(
                name="line~",
                outlet_type_finding={"confidence": "HIGH", "agreement": 1.0, "discrepancies": []},
            ),
        }

        report = reporter.generate_report(findings, {})
        assert "cycle~" not in report["objects"]
        assert "line~" in report["objects"]

    def test_report_summary_counts_by_confidence(self):
        """Summary counts discrepancies grouped by confidence level."""
        from src.maxpat.audit.reporter import AuditReporter

        db = make_db_mock_with_objects()
        reporter = AuditReporter(db)

        findings = {
            "obj_a": make_findings(
                name="obj_a",
                outlet_type_finding={"confidence": "HIGH", "agreement": 1.0, "discrepancies": []},
            ),
            "obj_b": make_findings(
                name="obj_b",
                io_count_finding={"confidence": "MEDIUM", "agreement": 0.8},
            ),
            "obj_c": make_findings(
                name="obj_c",
                outlet_type_finding={"confidence": "HIGH", "agreement": 1.0, "discrepancies": []},
                io_count_finding={"confidence": "LOW", "agreement": 0.6},
            ),
        }

        report = reporter.generate_report(findings, {})
        by_conf = report["summary"]["by_confidence"]
        assert by_conf["HIGH"] == 2  # obj_a outlet + obj_c outlet
        assert by_conf["MEDIUM"] == 1  # obj_b io
        assert by_conf["LOW"] == 1  # obj_c io

    def test_report_summary_counts_by_dimension(self):
        """Summary counts discrepancies grouped by dimension."""
        from src.maxpat.audit.reporter import AuditReporter

        db = make_db_mock_with_objects()
        reporter = AuditReporter(db)

        findings = {
            "obj_a": make_findings(
                name="obj_a",
                outlet_type_finding={"confidence": "HIGH", "agreement": 1.0, "discrepancies": []},
                width_finding={"median_width": 80.0, "widths": [80.0]},
            ),
            "obj_b": make_findings(
                name="obj_b",
                io_count_finding={"confidence": "MEDIUM", "agreement": 0.8},
            ),
        }

        report = reporter.generate_report(findings, {})
        by_dim = report["summary"]["by_dimension"]
        assert by_dim["outlet_types"] == 1
        assert by_dim["io_counts"] == 1
        assert by_dim["widths"] == 1


# ---------------------------------------------------------------------------
# AuditReporter: Filtering tests
# ---------------------------------------------------------------------------


class TestReportFiltering:
    """Test report filtering by dimension."""

    def test_filter_by_outlet_types_only(self):
        """Filtering by 'outlet_types' removes objects without outlet_type_finding."""
        from src.maxpat.audit.reporter import AuditReporter

        db = make_db_mock_with_objects()
        reporter = AuditReporter(db)

        findings = {
            "line~": make_findings(
                name="line~",
                outlet_type_finding={"confidence": "HIGH", "agreement": 1.0, "discrepancies": []},
                io_count_finding={"confidence": "MEDIUM", "agreement": 0.8},
            ),
            "cycle~": make_findings(
                name="cycle~",
                io_count_finding={"confidence": "LOW", "agreement": 0.6},
            ),
        }

        report = reporter.generate_report(findings, {})
        filtered = reporter.filter_report(report, "outlet_types")
        assert "line~" in filtered["objects"]
        assert "cycle~" not in filtered["objects"]
        # The line~ entry should only show the outlet_type_finding
        entry = filtered["objects"]["line~"]
        assert "outlet_type_finding" in entry
        assert "io_count_finding" not in entry

    def test_filter_by_io_counts(self):
        """Filtering by 'io_counts' keeps only io_count_finding entries."""
        from src.maxpat.audit.reporter import AuditReporter

        db = make_db_mock_with_objects()
        reporter = AuditReporter(db)

        findings = {
            "line~": make_findings(
                name="line~",
                outlet_type_finding={"confidence": "HIGH", "agreement": 1.0, "discrepancies": []},
                io_count_finding={"confidence": "MEDIUM", "agreement": 0.8},
            ),
        }

        report = reporter.generate_report(findings, {})
        filtered = reporter.filter_report(report, "io_counts")
        assert "line~" in filtered["objects"]
        entry = filtered["objects"]["line~"]
        assert "io_count_finding" in entry
        assert "outlet_type_finding" not in entry

    def test_filter_removes_objects_without_requested_dimension(self):
        """Objects without the filtered dimension are completely removed."""
        from src.maxpat.audit.reporter import AuditReporter

        db = make_db_mock_with_objects()
        reporter = AuditReporter(db)

        findings = {
            "cycle~": make_findings(name="cycle~", width_finding={"median_width": 85.0, "widths": [85.0]}),
            "dac~": make_findings(name="dac~", io_count_finding={"confidence": "HIGH", "agreement": 1.0}),
        }

        report = reporter.generate_report(findings, {})
        filtered = reporter.filter_report(report, "widths")
        assert "cycle~" in filtered["objects"]
        assert "dac~" not in filtered["objects"]


# ---------------------------------------------------------------------------
# AuditReporter: Empty I/O coverage tracker tests
# ---------------------------------------------------------------------------


class TestEmptyIOTracker:
    """Test empty I/O object identification and help patch coverage."""

    def test_identifies_objects_with_empty_inlets(self):
        """Tracker finds objects with empty inlets array in DB."""
        from src.maxpat.audit.reporter import AuditReporter

        db = make_db_mock_with_objects({
            "empty_in": {"name": "empty_in", "domain": "max", "inlets": [], "outlets": [{"id": 0}]},
            "normal": {"name": "normal", "domain": "max", "inlets": [{"id": 0}], "outlets": [{"id": 0}]},
        })
        reporter = AuditReporter(db)

        result = reporter.find_empty_io_objects({})
        assert "empty_in" in result["objects"]
        assert result["objects"]["empty_in"]["empty_inlets"] is True
        assert "normal" not in result["objects"]

    def test_identifies_objects_with_empty_outlets(self):
        """Tracker finds objects with empty outlets array in DB."""
        from src.maxpat.audit.reporter import AuditReporter

        db = make_db_mock_with_objects({
            "empty_out": {"name": "empty_out", "domain": "msp", "inlets": [{"id": 0}], "outlets": []},
            "normal": {"name": "normal", "domain": "max", "inlets": [{"id": 0}], "outlets": [{"id": 0}]},
        })
        reporter = AuditReporter(db)

        result = reporter.find_empty_io_objects({})
        assert "empty_out" in result["objects"]
        assert result["objects"]["empty_out"]["empty_outlets"] is True

    def test_marks_objects_with_help_data_as_covered(self):
        """Objects with findings data are marked has_help_data=True."""
        from src.maxpat.audit.reporter import AuditReporter

        db = make_db_mock_with_objects({
            "empty_obj": {"name": "empty_obj", "domain": "max", "inlets": [], "outlets": []},
        })
        reporter = AuditReporter(db)

        findings = {
            "empty_obj": make_findings(name="empty_obj", io_count_finding={"confidence": "HIGH"}),
        }

        result = reporter.find_empty_io_objects(findings)
        assert result["objects"]["empty_obj"]["has_help_data"] is True

    def test_marks_objects_without_help_data_as_not_covered(self):
        """Objects without findings are marked has_help_data=False."""
        from src.maxpat.audit.reporter import AuditReporter

        db = make_db_mock_with_objects({
            "empty_obj": {"name": "empty_obj", "domain": "max", "inlets": [], "outlets": []},
        })
        reporter = AuditReporter(db)

        result = reporter.find_empty_io_objects({})
        assert result["objects"]["empty_obj"]["has_help_data"] is False

    def test_includes_summary_counts(self):
        """Tracker includes summary with total_empty_inlet, total_empty_outlet, covered_by_help, not_covered."""
        from src.maxpat.audit.reporter import AuditReporter

        db = make_db_mock_with_objects({
            "empty_in": {"name": "empty_in", "domain": "max", "inlets": [], "outlets": [{"id": 0}]},
            "empty_out": {"name": "empty_out", "domain": "msp", "inlets": [{"id": 0}], "outlets": []},
            "empty_both": {"name": "empty_both", "domain": "max", "inlets": [], "outlets": []},
            "normal": {"name": "normal", "domain": "max", "inlets": [{"id": 0}], "outlets": [{"id": 0}]},
        })
        reporter = AuditReporter(db)

        findings = {
            "empty_in": make_findings(name="empty_in", io_count_finding={"confidence": "HIGH"}),
        }

        result = reporter.find_empty_io_objects(findings)
        summary = result["summary"]
        assert summary["total_empty_inlet"] == 2  # empty_in and empty_both
        assert summary["total_empty_outlet"] == 2  # empty_out and empty_both
        assert summary["total_unique"] == 3  # empty_in, empty_out, empty_both
        assert summary["covered_by_help"] == 1  # only empty_in has findings
        assert summary["not_covered"] == 2  # empty_out and empty_both

    def test_includes_domain_in_entry(self):
        """Each empty I/O entry includes its domain."""
        from src.maxpat.audit.reporter import AuditReporter

        db = make_db_mock_with_objects({
            "empty_obj": {"name": "empty_obj", "domain": "msp", "inlets": [], "outlets": []},
        })
        reporter = AuditReporter(db)

        result = reporter.find_empty_io_objects({})
        assert result["objects"]["empty_obj"]["domain"] == "msp"

    def test_includes_proposed_io_from_findings(self):
        """When help data exists with io_count_finding, proposed inlets/outlets are populated."""
        from src.maxpat.audit.reporter import AuditReporter

        db = make_db_mock_with_objects({
            "empty_obj": {"name": "empty_obj", "domain": "max", "inlets": [], "outlets": []},
        })
        reporter = AuditReporter(db)

        findings = {
            "empty_obj": make_findings(
                name="empty_obj",
                io_count_finding={
                    "confidence": "HIGH",
                    "agreement": 1.0,
                    "help_inlets": 2,
                    "help_outlets": 1,
                },
            ),
        }

        result = reporter.find_empty_io_objects(findings)
        entry = result["objects"]["empty_obj"]
        assert entry["proposed_inlets"] == 2
        assert entry["proposed_outlets"] == 1


# ---------------------------------------------------------------------------
# OverrideGenerator: Format and conflict detection tests
# ---------------------------------------------------------------------------


def make_mock_overrides_file(tmp_path, objects: dict | None = None) -> str:
    """Create a temporary overrides.json file and return its path."""
    import json

    overrides = {
        "_comment": "Test overrides",
        "objects": objects if objects is not None else {
            "buffer~": {
                "inlets": [{"id": 0, "type": "anything", "signal": False, "digest": "Messages"}],
                "outlets": [
                    {"id": 0, "type": "", "signal": False, "digest": "Mouse pos"},
                    {"id": 1, "type": "", "signal": False, "digest": "Bang on done"},
                ],
                "_note": "buffer~ outlets are control",
            },
        },
        "version_map": {},
        "variable_io_rules": {},
    }
    path = tmp_path / "overrides.json"
    path.write_text(json.dumps(overrides, indent=2))
    return str(path)


class TestOverrideFormat:
    """Test that generated proposed overrides match overrides.json format."""

    def test_proposed_overrides_match_overrides_json_structure(self, tmp_path):
        """Generated proposed overrides have objects dict with inlet/outlet arrays."""
        from src.maxpat.audit.overrides import OverrideGenerator

        overrides_path = make_mock_overrides_file(tmp_path, objects={})
        db = make_db_mock_with_objects()
        gen = OverrideGenerator(db, overrides_path=overrides_path)

        findings = {
            "test_obj": make_findings(
                name="test_obj",
                instance_count=10,
                outlet_type_finding={
                    "db_types": ["signal", "signal"],
                    "help_types": ["signal", ""],
                    "confidence": "HIGH",
                    "agreement": 1.0,
                    "discrepancy_type": "signal_control_mismatch",
                    "discrepancies": [{"outlet_index": 1}],
                },
            ),
        }

        proposed = gen.generate_proposed_overrides(findings)
        assert "objects" in proposed
        assert "test_obj" in proposed["objects"]
        entry = proposed["objects"]["test_obj"]
        # Outlets array should have dicts with id, type, signal, digest keys
        assert "outlets" in entry
        assert len(entry["outlets"]) == 2
        outlet = entry["outlets"][0]
        assert "id" in outlet
        assert "type" in outlet
        assert "signal" in outlet
        assert "digest" in outlet

    def test_outlet_array_construction_from_help_types(self, tmp_path):
        """Outlet arrays correctly map signal/control from help patch types."""
        from src.maxpat.audit.overrides import OverrideGenerator

        overrides_path = make_mock_overrides_file(tmp_path, objects={})
        db = make_db_mock_with_objects()
        gen = OverrideGenerator(db, overrides_path=overrides_path)

        # help_types: ["signal", ""] means outlet 0 is signal, outlet 1 is control
        findings = {
            "mixed_obj": make_findings(
                name="mixed_obj",
                instance_count=10,
                outlet_type_finding={
                    "db_types": ["signal", "signal"],
                    "help_types": ["signal", ""],
                    "confidence": "HIGH",
                    "agreement": 1.0,
                    "discrepancy_type": "signal_control_mismatch",
                    "discrepancies": [{"outlet_index": 1}],
                },
            ),
        }

        proposed = gen.generate_proposed_overrides(findings)
        outlets = proposed["objects"]["mixed_obj"]["outlets"]
        assert outlets[0]["signal"] is True
        assert outlets[0]["type"] == "signal"
        assert outlets[1]["signal"] is False
        assert outlets[1]["type"] == ""


class TestConflictDetection:
    """Test that existing manual overrides are protected."""

    def test_existing_manual_entries_flagged_as_conflict(self, tmp_path):
        """Objects already in existing overrides.json appear in conflicts, not objects."""
        from src.maxpat.audit.overrides import OverrideGenerator

        # buffer~ is in existing overrides
        overrides_path = make_mock_overrides_file(tmp_path)
        db = make_db_mock_with_objects()
        gen = OverrideGenerator(db, overrides_path=overrides_path)

        findings = {
            "buffer~": make_findings(
                name="buffer~",
                instance_count=20,
                outlet_type_finding={
                    "db_types": ["signal"],
                    "help_types": [""],
                    "confidence": "HIGH",
                    "agreement": 1.0,
                    "discrepancy_type": "signal_control_mismatch",
                    "discrepancies": [{"outlet_index": 0}],
                },
            ),
        }

        proposed = gen.generate_proposed_overrides(findings)
        # buffer~ should NOT be in proposed objects
        assert "buffer~" not in proposed["objects"]
        # buffer~ SHOULD be in conflicts
        assert "buffer~" in proposed["conflicts"]

    def test_conflict_includes_both_values(self, tmp_path):
        """Conflict entries include both audit-proposed and existing-manual values."""
        from src.maxpat.audit.overrides import OverrideGenerator

        overrides_path = make_mock_overrides_file(tmp_path)
        db = make_db_mock_with_objects()
        gen = OverrideGenerator(db, overrides_path=overrides_path)

        findings = {
            "buffer~": make_findings(
                name="buffer~",
                instance_count=20,
                outlet_type_finding={
                    "db_types": ["signal"],
                    "help_types": [""],
                    "confidence": "HIGH",
                    "agreement": 1.0,
                    "discrepancy_type": "signal_control_mismatch",
                    "discrepancies": [{"outlet_index": 0}],
                },
            ),
        }

        proposed = gen.generate_proposed_overrides(findings)
        conflict = proposed["conflicts"]["buffer~"]
        assert "audit_proposed" in conflict
        assert "existing_manual" in conflict

    def test_non_conflicting_objects_in_proposed(self, tmp_path):
        """Objects NOT in existing overrides go into proposed objects."""
        from src.maxpat.audit.overrides import OverrideGenerator

        overrides_path = make_mock_overrides_file(tmp_path, objects={"buffer~": {"outlets": []}})
        db = make_db_mock_with_objects()
        gen = OverrideGenerator(db, overrides_path=overrides_path)

        findings = {
            "new_obj": make_findings(
                name="new_obj",
                instance_count=10,
                outlet_type_finding={
                    "db_types": ["signal"],
                    "help_types": [""],
                    "confidence": "HIGH",
                    "agreement": 1.0,
                    "discrepancy_type": "signal_control_mismatch",
                    "discrepancies": [{"outlet_index": 0}],
                },
            ),
        }

        proposed = gen.generate_proposed_overrides(findings)
        assert "new_obj" in proposed["objects"]
        assert "new_obj" not in proposed["conflicts"]


class TestConfidenceThreshold:
    """Test that only HIGH/MEDIUM confidence findings generate overrides."""

    def test_low_confidence_excluded(self, tmp_path):
        """LOW confidence findings do not generate proposed overrides."""
        from src.maxpat.audit.overrides import OverrideGenerator

        overrides_path = make_mock_overrides_file(tmp_path, objects={})
        db = make_db_mock_with_objects()
        gen = OverrideGenerator(db, overrides_path=overrides_path)

        findings = {
            "low_obj": make_findings(
                name="low_obj",
                outlet_type_finding={
                    "db_types": ["signal"],
                    "help_types": [""],
                    "confidence": "LOW",
                    "agreement": 0.6,
                    "discrepancy_type": "signal_control_mismatch",
                    "discrepancies": [{"outlet_index": 0}],
                },
            ),
        }

        proposed = gen.generate_proposed_overrides(findings)
        assert "low_obj" not in proposed["objects"]

    def test_conflict_confidence_excluded(self, tmp_path):
        """CONFLICT confidence findings do not generate proposed overrides."""
        from src.maxpat.audit.overrides import OverrideGenerator

        overrides_path = make_mock_overrides_file(tmp_path, objects={})
        db = make_db_mock_with_objects()
        gen = OverrideGenerator(db, overrides_path=overrides_path)

        findings = {
            "conflict_obj": make_findings(
                name="conflict_obj",
                outlet_type_finding={
                    "db_types": ["signal"],
                    "help_types": [""],
                    "confidence": "CONFLICT",
                    "agreement": 0.3,
                    "discrepancy_type": "signal_control_mismatch",
                    "discrepancies": [{"outlet_index": 0}],
                },
            ),
        }

        proposed = gen.generate_proposed_overrides(findings)
        assert "conflict_obj" not in proposed["objects"]

    def test_high_confidence_included(self, tmp_path):
        """HIGH confidence findings generate proposed overrides."""
        from src.maxpat.audit.overrides import OverrideGenerator

        overrides_path = make_mock_overrides_file(tmp_path, objects={})
        db = make_db_mock_with_objects()
        gen = OverrideGenerator(db, overrides_path=overrides_path)

        findings = {
            "high_obj": make_findings(
                name="high_obj",
                instance_count=20,
                outlet_type_finding={
                    "db_types": ["signal"],
                    "help_types": [""],
                    "confidence": "HIGH",
                    "agreement": 1.0,
                    "discrepancy_type": "signal_control_mismatch",
                    "discrepancies": [{"outlet_index": 0}],
                },
            ),
        }

        proposed = gen.generate_proposed_overrides(findings)
        assert "high_obj" in proposed["objects"]

    def test_medium_confidence_included(self, tmp_path):
        """MEDIUM confidence findings generate proposed overrides."""
        from src.maxpat.audit.overrides import OverrideGenerator

        overrides_path = make_mock_overrides_file(tmp_path, objects={})
        db = make_db_mock_with_objects()
        gen = OverrideGenerator(db, overrides_path=overrides_path)

        findings = {
            "med_obj": make_findings(
                name="med_obj",
                instance_count=8,
                outlet_type_finding={
                    "db_types": ["signal"],
                    "help_types": [""],
                    "confidence": "MEDIUM",
                    "agreement": 0.8,
                    "discrepancy_type": "signal_control_mismatch",
                    "discrepancies": [{"outlet_index": 0}],
                },
            ),
        }

        proposed = gen.generate_proposed_overrides(findings)
        assert "med_obj" in proposed["objects"]


class TestAuditMetadata:
    """Test that proposed overrides include _audit metadata."""

    def test_proposed_entry_includes_audit_metadata(self, tmp_path):
        """Each proposed override entry includes _audit with confidence, instances, agreement."""
        from src.maxpat.audit.overrides import OverrideGenerator

        overrides_path = make_mock_overrides_file(tmp_path, objects={})
        db = make_db_mock_with_objects()
        gen = OverrideGenerator(db, overrides_path=overrides_path)

        findings = {
            "test_obj": make_findings(
                name="test_obj",
                instance_count=15,
                outlet_type_finding={
                    "db_types": ["signal", "signal"],
                    "help_types": ["signal", ""],
                    "confidence": "HIGH",
                    "agreement": 1.0,
                    "discrepancy_type": "signal_control_mismatch",
                    "discrepancies": [{"outlet_index": 1}],
                },
            ),
        }

        proposed = gen.generate_proposed_overrides(findings)
        entry = proposed["objects"]["test_obj"]
        assert "_audit" in entry
        audit = entry["_audit"]
        assert audit["confidence"] == "HIGH"
        assert audit["instances"] == 15
        assert audit["agreement"] == 1.0


class TestEmptyIOOverrides:
    """Test that empty I/O objects with help data generate proposed overrides."""

    def test_empty_io_objects_with_help_data_generate_proposals(self, tmp_path):
        """Empty I/O objects with has_help_data=True get proposed I/O entries."""
        from src.maxpat.audit.overrides import OverrideGenerator

        overrides_path = make_mock_overrides_file(tmp_path, objects={})
        db = make_db_mock_with_objects()
        gen = OverrideGenerator(db, overrides_path=overrides_path)

        findings = {}  # No outlet_type_finding needed

        empty_io_data = {
            "objects": {
                "empty_obj": {
                    "empty_inlets": True,
                    "empty_outlets": True,
                    "has_help_data": True,
                    "proposed_inlets": 2,
                    "proposed_outlets": 1,
                    "domain": "max",
                },
            },
            "summary": {},
        }

        proposed = gen.generate_proposed_overrides(findings, empty_io_data=empty_io_data)
        assert "empty_obj" in proposed["objects"]
        entry = proposed["objects"]["empty_obj"]
        assert "inlets" in entry
        assert len(entry["inlets"]) == 2

    def test_empty_io_conflict_with_existing_manual(self, tmp_path):
        """Empty I/O objects already in manual overrides go to conflicts."""
        from src.maxpat.audit.overrides import OverrideGenerator

        overrides_path = make_mock_overrides_file(tmp_path, objects={"buffer~": {"outlets": []}})
        db = make_db_mock_with_objects()
        gen = OverrideGenerator(db, overrides_path=overrides_path)

        empty_io_data = {
            "objects": {
                "buffer~": {
                    "empty_inlets": True,
                    "empty_outlets": True,
                    "has_help_data": True,
                    "proposed_inlets": 1,
                    "proposed_outlets": 2,
                    "domain": "msp",
                },
            },
            "summary": {},
        }

        proposed = gen.generate_proposed_overrides({}, empty_io_data=empty_io_data)
        assert "buffer~" not in proposed["objects"]
        assert "buffer~" in proposed["conflicts"]
