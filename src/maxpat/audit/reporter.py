"""Audit report generation and empty I/O coverage tracking.

Transforms AuditAnalyzer findings into structured JSON reports with
confidence scores, dimension filtering, and identification of objects
with empty inlet/outlet data in the database.
"""

from __future__ import annotations

import json
from datetime import datetime, timezone
from pathlib import Path
from typing import Any

from src.maxpat.audit.analyzer import ObjectFindings
from src.maxpat.db_lookup import ObjectDatabase

# Mapping from finding field names to dimension labels
_FINDING_TO_DIMENSION = {
    "outlet_type_finding": "outlet_types",
    "io_count_finding": "io_counts",
    "width_finding": "widths",
    "argument_finding": "arguments",
    "connection_finding": "connections",
}

# Reverse mapping: dimension label -> finding field name
_DIMENSION_TO_FINDING = {v: k for k, v in _FINDING_TO_DIMENSION.items()}


class AuditReporter:
    """Generates structured JSON audit reports from analyzer findings.

    Produces per-object discrepancy entries with confidence scores,
    summary statistics, dimension filtering, and empty I/O coverage tracking.
    """

    def __init__(self, db: ObjectDatabase) -> None:
        """Initialize reporter with an ObjectDatabase reference.

        Args:
            db: ObjectDatabase instance for empty I/O detection.
        """
        self._db = db

    def generate_report(
        self,
        findings: dict[str, ObjectFindings],
        parse_stats: dict[str, Any],
    ) -> dict:
        """Generate a complete audit report from analyzer findings.

        Args:
            findings: Dict mapping object name to ObjectFindings.
            parse_stats: Statistics from the parser (files_parsed, objects_found, etc.).

        Returns:
            Complete report dict with _audit_date, _audit_stats, summary, and objects.
        """
        report: dict[str, Any] = {
            "_audit_date": datetime.now(timezone.utc).isoformat(),
            "_audit_stats": parse_stats,
            "objects": {},
            "summary": {},
        }

        # Counters for summary
        by_confidence: dict[str, int] = {}
        by_dimension: dict[str, int] = {
            "outlet_types": 0,
            "io_counts": 0,
            "widths": 0,
            "arguments": 0,
            "connections": 0,
        }
        total_discrepancies = 0

        # Build per-object entries with only non-None findings
        objects_with_findings: dict[str, dict] = {}

        for obj_name, obj_findings in findings.items():
            entry: dict[str, Any] = {}

            for field_name, dim_label in _FINDING_TO_DIMENSION.items():
                finding_value = getattr(obj_findings, field_name, None)
                if finding_value is not None:
                    entry[field_name] = finding_value
                    total_discrepancies += 1
                    by_dimension[dim_label] += 1

                    # Count by confidence level
                    conf = finding_value.get("confidence")
                    if conf:
                        by_confidence[conf] = by_confidence.get(conf, 0) + 1

            if entry:
                entry["instance_count"] = obj_findings.instance_count
                objects_with_findings[obj_name] = entry

        # Sort objects alphabetically
        report["objects"] = dict(sorted(objects_with_findings.items()))

        # Build summary
        report["summary"] = {
            "files_parsed": parse_stats.get("files_parsed", 0),
            "objects_analyzed": len(findings),
            "objects_with_discrepancies": len(objects_with_findings),
            "discrepancies_found": total_discrepancies,
            "by_confidence": by_confidence,
            "by_dimension": by_dimension,
        }

        return report

    def filter_report(self, report: dict, dimension: str) -> dict:
        """Filter a report to show only a specific dimension.

        Args:
            report: A report dict from generate_report().
            dimension: One of "outlet_types", "io_counts", "widths", "arguments", "connections".

        Returns:
            Filtered report with only the specified dimension's findings.
        """
        finding_field = _DIMENSION_TO_FINDING.get(dimension)
        if not finding_field:
            return report

        filtered_objects: dict[str, dict] = {}

        for obj_name, entry in report.get("objects", {}).items():
            if finding_field in entry:
                filtered_entry = {
                    finding_field: entry[finding_field],
                    "instance_count": entry.get("instance_count", 0),
                }
                filtered_objects[obj_name] = filtered_entry

        filtered = {
            "_audit_date": report.get("_audit_date"),
            "_audit_stats": report.get("_audit_stats"),
            "objects": dict(sorted(filtered_objects.items())),
            "summary": report.get("summary"),
        }

        return filtered

    def find_empty_io_objects(
        self, findings: dict[str, ObjectFindings]
    ) -> dict:
        """Identify objects with empty inlet/outlet data in the database.

        Scans all objects in the DB for empty inlets or outlets arrays,
        then checks which ones have help patch data available in findings.

        Args:
            findings: Dict mapping object name to ObjectFindings (from analyzer).

        Returns:
            Dict with "objects" (per-object entries) and "summary" (counts).
        """
        empty_objects: dict[str, dict] = {}
        total_empty_inlet = 0
        total_empty_outlet = 0
        covered_by_help = 0

        for obj_name, obj_data in self._db._objects.items():
            inlets = obj_data.get("inlets", [])
            outlets = obj_data.get("outlets", [])

            empty_in = len(inlets) == 0
            empty_out = len(outlets) == 0

            if not empty_in and not empty_out:
                continue

            if empty_in:
                total_empty_inlet += 1
            if empty_out:
                total_empty_outlet += 1

            has_help = obj_name in findings and findings[obj_name] is not None
            # Check if the findings actually have useful data (any non-None finding)
            if has_help:
                obj_f = findings[obj_name]
                has_help = any(
                    getattr(obj_f, field, None) is not None
                    for field in _FINDING_TO_DIMENSION
                )

            if has_help:
                covered_by_help += 1

            # Build entry
            entry: dict[str, Any] = {
                "empty_inlets": empty_in,
                "empty_outlets": empty_out,
                "has_help_data": has_help,
                "domain": obj_data.get("domain", ""),
            }

            # Add proposed I/O from findings if available
            if has_help and obj_name in findings:
                io_finding = findings[obj_name].io_count_finding
                if io_finding:
                    entry["proposed_inlets"] = io_finding.get("help_inlets")
                    entry["proposed_outlets"] = io_finding.get("help_outlets")
                else:
                    entry["proposed_inlets"] = None
                    entry["proposed_outlets"] = None
            else:
                entry["proposed_inlets"] = None
                entry["proposed_outlets"] = None

            empty_objects[obj_name] = entry

        total_unique = len(empty_objects)
        not_covered = total_unique - covered_by_help

        return {
            "objects": dict(sorted(empty_objects.items())),
            "summary": {
                "total_empty_inlet": total_empty_inlet,
                "total_empty_outlet": total_empty_outlet,
                "total_unique": total_unique,
                "covered_by_help": covered_by_help,
                "not_covered": not_covered,
            },
        }

    def write_report(self, report: dict, output_path: Path) -> None:
        """Write report dict as pretty-printed JSON to a file.

        Args:
            report: The report dict to write.
            output_path: Path to the output JSON file.
        """
        output_path.parent.mkdir(parents=True, exist_ok=True)
        output_path.write_text(json.dumps(report, indent=2) + "\n")
