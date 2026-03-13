"""Integration tests for the audit CLI entry point.

Tests the CLI wiring: argparse flag handling, invalid path errors,
dry-run mode, and full pipeline execution against the synthetic fixture.
"""

import json
from pathlib import Path

import pytest

from src.maxpat.audit.cli import main

# Path to the test fixture directory containing sample_help.json
FIXTURES_DIR = Path(__file__).parent / "fixtures"


class TestCLIInvalidPaths:
    """Test error handling for invalid help directory paths."""

    def test_nonexistent_path_returns_1(self):
        """main() returns 1 when --help-dir points to a nonexistent path."""
        result = main(["--help-dir", "nonexistent/path/that/does/not/exist"])
        assert result == 1

    def test_file_instead_of_directory_returns_1(self):
        """main() returns 1 when --help-dir points to a file, not a directory."""
        result = main(["--help-dir", str(FIXTURES_DIR / "sample_help.json")])
        assert result == 1


class TestCLIDryRun:
    """Test dry-run mode: pipeline runs but no output files are written."""

    def test_dry_run_returns_0_on_fixture(self, tmp_path):
        """Dry-run mode completes successfully against the fixture directory."""
        result = main([
            "--help-dir", str(FIXTURES_DIR),
            "--output-dir", str(tmp_path),
            "--dry-run",
        ])
        assert result == 0

    def test_dry_run_produces_no_output_files(self, tmp_path):
        """Dry-run mode does not write any files to the output directory."""
        main([
            "--help-dir", str(FIXTURES_DIR),
            "--output-dir", str(tmp_path),
            "--dry-run",
        ])
        output_files = list(tmp_path.iterdir())
        assert len(output_files) == 0


class TestCLIFullPipeline:
    """Test full pipeline execution against the synthetic fixture."""

    def test_full_pipeline_returns_0(self, tmp_path):
        """Full pipeline execution completes successfully."""
        result = main([
            "--help-dir", str(FIXTURES_DIR),
            "--output-dir", str(tmp_path),
        ])
        assert result == 0

    def test_full_pipeline_writes_audit_report(self, tmp_path):
        """Full pipeline writes audit-report.json."""
        main([
            "--help-dir", str(FIXTURES_DIR),
            "--output-dir", str(tmp_path),
        ])
        report_path = tmp_path / "audit-report.json"
        assert report_path.exists()
        report = json.loads(report_path.read_text())
        assert "objects" in report
        assert "summary" in report

    def test_full_pipeline_writes_empty_io_coverage(self, tmp_path):
        """Full pipeline writes empty-io-coverage.json."""
        main([
            "--help-dir", str(FIXTURES_DIR),
            "--output-dir", str(tmp_path),
        ])
        path = tmp_path / "empty-io-coverage.json"
        assert path.exists()
        data = json.loads(path.read_text())
        assert "objects" in data
        assert "summary" in data

    def test_full_pipeline_writes_proposed_overrides(self, tmp_path):
        """Full pipeline writes proposed-overrides.json."""
        main([
            "--help-dir", str(FIXTURES_DIR),
            "--output-dir", str(tmp_path),
        ])
        path = tmp_path / "proposed-overrides.json"
        assert path.exists()
        data = json.loads(path.read_text())
        assert "objects" in data
        assert "conflicts" in data


class TestCLIFilters:
    """Test that --*-only flags filter the report correctly."""

    def test_outlets_only_filters_report(self, tmp_path):
        """--outlets-only flag produces a report with only outlet type findings."""
        main([
            "--help-dir", str(FIXTURES_DIR),
            "--output-dir", str(tmp_path),
            "--outlets-only",
        ])
        report = json.loads((tmp_path / "audit-report.json").read_text())
        # All objects in the report should only have outlet_type_finding (if any)
        for obj_name, entry in report.get("objects", {}).items():
            finding_keys = [k for k in entry.keys() if k.endswith("_finding")]
            for k in finding_keys:
                assert k == "outlet_type_finding", (
                    f"Expected only outlet_type_finding, got {k} for {obj_name}"
                )

    def test_widths_only_filters_report(self, tmp_path):
        """--widths-only flag produces a report with only width findings."""
        main([
            "--help-dir", str(FIXTURES_DIR),
            "--output-dir", str(tmp_path),
            "--widths-only",
        ])
        report = json.loads((tmp_path / "audit-report.json").read_text())
        for obj_name, entry in report.get("objects", {}).items():
            finding_keys = [k for k in entry.keys() if k.endswith("_finding")]
            for k in finding_keys:
                assert k == "width_finding", (
                    f"Expected only width_finding, got {k} for {obj_name}"
                )

    def test_verbose_flag_accepted(self, tmp_path, capsys):
        """--verbose flag is accepted and produces output."""
        result = main([
            "--help-dir", str(FIXTURES_DIR),
            "--output-dir", str(tmp_path),
            "--dry-run",
            "--verbose",
        ])
        assert result == 0
        captured = capsys.readouterr()
        assert "Parsing" in captured.out
