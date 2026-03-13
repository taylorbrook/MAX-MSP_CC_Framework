"""Proposed override generation with manual entry protection.

Transforms audit findings into proposed overrides.json entries that match
the established format, while detecting conflicts with existing manually
corrected entries and excluding low-confidence proposals.
"""

from __future__ import annotations

import json
from datetime import datetime, timezone
from pathlib import Path
from typing import Any

from src.maxpat.audit.analyzer import SIGNAL_TYPES, ObjectFindings
from src.maxpat.db_lookup import ObjectDatabase

# Confidence levels that are eligible for proposed overrides
_ELIGIBLE_CONFIDENCE = {"HIGH", "MEDIUM"}


class OverrideGenerator:
    """Generates proposed overrides from audit findings with conflict detection.

    Produces override entries matching the established overrides.json format,
    protects existing manual entries from being overwritten, and only includes
    proposals from high-confidence findings.
    """

    def __init__(
        self,
        db: ObjectDatabase,
        overrides_path: str | Path | None = None,
    ) -> None:
        """Initialize with ObjectDatabase and existing overrides path.

        Args:
            db: ObjectDatabase instance.
            overrides_path: Path to existing overrides.json. Defaults to
                project_root/.claude/max-objects/overrides.json.
        """
        self._db = db

        if overrides_path is None:
            overrides_path = (
                Path(__file__).resolve().parents[3]
                / ".claude"
                / "max-objects"
                / "overrides.json"
            )
        else:
            overrides_path = Path(overrides_path)

        self._overrides_path = overrides_path
        self._existing_overrides: dict = {}
        self._existing_objects: set[str] = set()

        if overrides_path.exists():
            data = json.loads(overrides_path.read_text())
            self._existing_overrides = data
            self._existing_objects = set(data.get("objects", {}).keys())

    def generate_proposed_overrides(
        self,
        findings: dict[str, ObjectFindings],
        empty_io_data: dict | None = None,
    ) -> dict:
        """Generate proposed overrides from audit findings.

        Args:
            findings: Dict mapping object name to ObjectFindings.
            empty_io_data: Optional dict from AuditReporter.find_empty_io_objects()
                with objects that have empty I/O data and help patch coverage.

        Returns:
            Dict with _comment, _audit_date, _audit_stats, objects, and conflicts.
        """
        proposed: dict[str, Any] = {
            "_comment": "Auto-generated proposed overrides from help patch audit. Review before merging.",
            "_audit_date": datetime.now(timezone.utc).isoformat(),
            "objects": {},
            "conflicts": {},
        }

        # Process outlet type findings
        for obj_name, obj_findings in findings.items():
            self._process_outlet_type_finding(proposed, obj_name, obj_findings)
            self._process_io_count_finding(proposed, obj_name, obj_findings)

        # Process empty I/O objects with help data
        if empty_io_data:
            self._process_empty_io_objects(proposed, empty_io_data)

        # Sort objects and conflicts alphabetically
        proposed["objects"] = dict(sorted(proposed["objects"].items()))
        proposed["conflicts"] = dict(sorted(proposed["conflicts"].items()))

        return proposed

    def _process_outlet_type_finding(
        self,
        proposed: dict,
        obj_name: str,
        obj_findings: ObjectFindings,
    ) -> None:
        """Process outlet type finding for a single object.

        Adds to proposed["objects"] or proposed["conflicts"] based on
        conflict detection and confidence threshold.
        """
        finding = obj_findings.outlet_type_finding
        if finding is None:
            return

        confidence = finding.get("confidence", "")
        if confidence not in _ELIGIBLE_CONFIDENCE:
            return

        help_types = finding.get("help_types", [])
        if not help_types:
            return

        outlets = self._build_outlet_array(help_types)
        entry = {
            "outlets": outlets,
            "_audit": {
                "confidence": confidence,
                "instances": obj_findings.instance_count,
                "agreement": finding.get("agreement", 0.0),
                "source": "outlet_type_finding",
            },
        }

        if obj_name in self._existing_objects:
            # Conflict with manual override
            proposed["conflicts"][obj_name] = {
                "audit_proposed": entry,
                "existing_manual": self._existing_overrides.get("objects", {}).get(
                    obj_name, {}
                ),
                "reason": "CONFLICT_WITH_MANUAL",
            }
        else:
            proposed["objects"][obj_name] = entry

    def _process_io_count_finding(
        self,
        proposed: dict,
        obj_name: str,
        obj_findings: ObjectFindings,
    ) -> None:
        """Process I/O count finding for a single object.

        If the object already has an outlet_type_finding entry, merge I/O data.
        """
        finding = obj_findings.io_count_finding
        if finding is None:
            return

        confidence = finding.get("confidence", "")
        if confidence not in _ELIGIBLE_CONFIDENCE:
            return

        help_inlets = finding.get("help_inlets")
        help_outlets = finding.get("help_outlets")

        if help_inlets is None and help_outlets is None:
            return

        io_entry: dict[str, Any] = {}
        if help_inlets is not None:
            io_entry["inlets"] = self._build_inlet_array(help_inlets)
        if help_outlets is not None and "outlets" not in proposed["objects"].get(
            obj_name, {}
        ):
            io_entry["outlets"] = self._build_outlet_array(
                [""] * help_outlets
            )

        if not io_entry:
            return

        audit_meta = {
            "confidence": confidence,
            "instances": obj_findings.instance_count,
            "agreement": finding.get("agreement", 0.0),
            "source": "io_count_finding",
        }

        if obj_name in self._existing_objects:
            existing_conflict = proposed["conflicts"].get(obj_name, {})
            if existing_conflict:
                existing_conflict["audit_proposed"].update(io_entry)
            else:
                proposed["conflicts"][obj_name] = {
                    "audit_proposed": {**io_entry, "_audit": audit_meta},
                    "existing_manual": self._existing_overrides.get(
                        "objects", {}
                    ).get(obj_name, {}),
                    "reason": "CONFLICT_WITH_MANUAL",
                }
        else:
            if obj_name in proposed["objects"]:
                proposed["objects"][obj_name].update(io_entry)
            else:
                proposed["objects"][obj_name] = {
                    **io_entry,
                    "_audit": audit_meta,
                }

    def _process_empty_io_objects(
        self,
        proposed: dict,
        empty_io_data: dict,
    ) -> None:
        """Process empty I/O objects that have help patch data.

        Only proposes entries for objects where has_help_data is True
        and the object is not already in manual overrides.
        """
        for obj_name, obj_info in empty_io_data.get("objects", {}).items():
            if not obj_info.get("has_help_data"):
                continue

            # Skip if already processed from findings
            if obj_name in proposed["objects"] or obj_name in proposed["conflicts"]:
                continue

            proposed_inlets = obj_info.get("proposed_inlets")
            proposed_outlets = obj_info.get("proposed_outlets")

            if proposed_inlets is None and proposed_outlets is None:
                continue

            entry: dict[str, Any] = {}
            if proposed_inlets is not None:
                entry["inlets"] = self._build_inlet_array(proposed_inlets)
            if proposed_outlets is not None:
                entry["outlets"] = self._build_outlet_array(
                    [""] * proposed_outlets
                )

            entry["_audit"] = {
                "confidence": "HELP_PATCH",
                "source": "empty_io_coverage",
            }

            if obj_name in self._existing_objects:
                proposed["conflicts"][obj_name] = {
                    "audit_proposed": entry,
                    "existing_manual": self._existing_overrides.get(
                        "objects", {}
                    ).get(obj_name, {}),
                    "reason": "CONFLICT_WITH_MANUAL",
                }
            else:
                proposed["objects"][obj_name] = entry

    def _build_outlet_array(self, outlettype: list[str]) -> list[dict]:
        """Build outlet array matching overrides.json format.

        Args:
            outlettype: List of outlet type strings (e.g., ["signal", ""]).

        Returns:
            List of outlet dicts with id, type, signal, digest keys.
        """
        outlets = []
        for i, type_str in enumerate(outlettype):
            is_signal = type_str in SIGNAL_TYPES
            outlets.append({
                "id": i,
                "type": type_str if is_signal else "",
                "signal": is_signal,
                "digest": "Signal output" if is_signal else "Control output",
            })
        return outlets

    def _build_inlet_array(self, count: int) -> list[dict]:
        """Build inlet array matching overrides.json format.

        Args:
            count: Number of inlets to create.

        Returns:
            List of inlet dicts with id, type, signal, digest keys.
        """
        return [
            {
                "id": i,
                "type": "",
                "signal": False,
                "digest": "",
            }
            for i in range(count)
        ]

    def write_proposed_overrides(
        self, proposed: dict, output_path: Path
    ) -> None:
        """Write proposed overrides as pretty-printed JSON.

        Args:
            proposed: The proposed overrides dict.
            output_path: Path to the output JSON file.
        """
        output_path.parent.mkdir(parents=True, exist_ok=True)
        output_path.write_text(json.dumps(proposed, indent=2) + "\n")
