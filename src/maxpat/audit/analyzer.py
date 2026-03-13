"""Audit analysis engine for comparing help patch data against the object database.

Compares parser-extracted help patch data against the ObjectDatabase across
5 dimensions: outlet types, I/O counts, box widths, argument formats, and
connection patterns. Produces per-object findings with confidence scores.
"""

from __future__ import annotations

from collections import Counter
from dataclasses import dataclass, field
from typing import Any, Callable

from src.maxpat.audit import BoxInstance
from src.maxpat.audit.parser import parse_object_text
from src.maxpat.db_lookup import ObjectDatabase

# Signal outlet type strings recognized in help patches
SIGNAL_TYPES = {"signal", "multichannelsignal"}


def classify_outlet_type(help_type: str) -> tuple[bool, str]:
    """Map a help patch outlettype string to signal/control classification.

    Help patches use various strings for outlet types: "signal",
    "multichannelsignal", "", "bang", "int", "float", etc. This function
    classifies each into signal (True) or control (False).

    Args:
        help_type: The outlet type string from a help patch's outlettype array.

    Returns:
        Tuple of (is_signal, normalized_label).
        - Signal outlets: (True, "signal") or (True, "multichannelsignal")
        - Control outlets: (False, "")
    """
    if help_type in SIGNAL_TYPES:
        return (True, help_type)
    return (False, "")


def compute_confidence(
    instances: list,
    key_fn: Callable[[Any], Any],
) -> tuple[str, float, Any]:
    """Aggregate instances using key_fn, count agreement, and return confidence.

    Confidence levels:
        - HIGH: 100% agreement (ratio >= 1.0)
        - MEDIUM: >= 75% agreement
        - LOW: >= 50% agreement
        - CONFLICT: < 50% agreement
        - NONE: empty input

    Args:
        instances: List of items to analyze.
        key_fn: Function to extract the comparison key from each instance.

    Returns:
        Tuple of (level, ratio, consensus_value).
        consensus_value is the most common value according to key_fn.
    """
    if not instances:
        return ("NONE", 0.0, None)

    counts = Counter(key_fn(inst) for inst in instances)
    most_common_value, most_common_count = counts.most_common(1)[0]
    ratio = most_common_count / len(instances)

    if ratio >= 1.0:
        level = "HIGH"
    elif ratio >= 0.75:
        level = "MEDIUM"
    elif ratio >= 0.5:
        level = "LOW"
    else:
        level = "CONFLICT"

    return (level, ratio, most_common_value)


@dataclass
class ObjectFindings:
    """Aggregated findings for a single object across all analysis dimensions."""

    object_name: str
    """The object name (e.g., 'cycle~')."""

    instance_count: int
    """Number of instances analyzed."""

    outlet_type_finding: dict | None = None
    """Outlet type comparison: db_types, help_types, confidence, agreement, discrepancy_type."""

    io_count_finding: dict | None = None
    """I/O count comparison: db_inlets, db_outlets, help_inlets, help_outlets, confidence, variable_io."""

    width_finding: dict | None = None
    """Box width data: widths, median_width, min_width, max_width, instance_count."""

    argument_finding: dict | None = None
    """Argument patterns: patterns with counts, attribute_patterns."""

    connection_finding: dict | None = None
    """Connection patterns: outlet_connections, inlet_connections, total_connections."""


class AuditAnalyzer:
    """Comparison engine that analyzes help patch data against the object database.

    Consumes BoxInstance lists from the parser and produces ObjectFindings
    with confidence-scored discrepancy reports across 5 dimensions.
    """

    def __init__(self, db: ObjectDatabase) -> None:
        """Initialize the analyzer with an ObjectDatabase reference.

        Args:
            db: ObjectDatabase instance for DB-side comparisons.
        """
        self._db = db

    def analyze_outlet_types(
        self, name: str, instances: list[BoxInstance]
    ) -> dict | None:
        """Compare outlet types between DB and help patch instances.

        Classifies each outlet position as signal or control in both the DB
        and the help patches. Only flags signal/control mismatches -- variations
        like "int" vs "float" vs "" vs "bang" are all control and are NOT
        flagged as discrepancies.

        Args:
            name: Object name.
            instances: BoxInstance list for this object.

        Returns:
            Finding dict with discrepancy details, or None if types match.
        """
        db_types = self._db.get_outlet_types(name)
        if not db_types and not instances:
            return None

        # Classify DB types to signal/control
        db_classified = [classify_outlet_type(t) for t in db_types]

        # Collect help patch outlet types across instances, classify each
        # Build a per-position consensus of signal/control from help patches
        if not instances:
            return None

        max_outlets = max(len(inst.outlettype) for inst in instances)
        if max_outlets == 0:
            return None

        # For each outlet position, classify across all instances
        help_classified_per_pos: list[list[tuple[bool, str]]] = [
            [] for _ in range(max_outlets)
        ]
        for inst in instances:
            for i, ot in enumerate(inst.outlettype):
                if i < max_outlets:
                    help_classified_per_pos[i].append(classify_outlet_type(ot))

        # Build consensus for each position
        help_consensus: list[tuple[bool, str]] = []
        for pos_classifications in help_classified_per_pos:
            if not pos_classifications:
                help_consensus.append((False, ""))
                continue
            # Majority vote on is_signal
            signal_count = sum(1 for s, _ in pos_classifications if s)
            control_count = len(pos_classifications) - signal_count
            if signal_count > control_count:
                # Find majority signal label
                signal_labels = [lbl for s, lbl in pos_classifications if s]
                most_common_label = Counter(signal_labels).most_common(1)[0][0]
                help_consensus.append((True, most_common_label))
            else:
                help_consensus.append((False, ""))

        # Compare DB vs help patch at signal/control level
        # Pad shorter list to match longer
        max_len = max(len(db_classified), len(help_consensus))
        db_padded = db_classified + [(False, "")] * (max_len - len(db_classified))
        help_padded = help_consensus + [(False, "")] * (max_len - len(help_consensus))

        discrepancies = []
        for i in range(max_len):
            db_is_signal, db_label = db_padded[i]
            help_is_signal, help_label = help_padded[i]
            if db_is_signal != help_is_signal:
                discrepancies.append({
                    "outlet_index": i,
                    "db_is_signal": db_is_signal,
                    "db_label": db_label,
                    "help_is_signal": help_is_signal,
                    "help_label": help_label,
                })

        if not discrepancies:
            return None

        # Compute overall confidence from instance agreement
        # Use tuple of all classified types as the key
        level, ratio, _ = compute_confidence(
            instances,
            lambda inst: tuple(
                classify_outlet_type(ot)[0] for ot in inst.outlettype
            ),
        )

        return {
            "db_types": db_types,
            "help_types": [
                ("signal" if is_sig else "") for is_sig, _ in help_consensus
            ],
            "confidence": level,
            "agreement": ratio,
            "discrepancy_type": "signal_control_mismatch",
            "discrepancies": discrepancies,
        }

    def analyze_io_counts(
        self, name: str, instances: list[BoxInstance]
    ) -> dict | None:
        """Validate inlet/outlet counts between DB and help patch instances.

        For variable_io objects, computes expected counts from each instance's
        arguments. For fixed objects, compares against DB defaults.

        Args:
            name: Object name.
            instances: BoxInstance list for this object.

        Returns:
            Finding dict with discrepancy details, or None if counts match.
        """
        if not instances:
            return None

        obj_data = self._db.lookup(name)
        is_variable_io = obj_data.get("variable_io", False) if obj_data else False

        mismatches = []

        for inst in instances:
            _, args, _ = parse_object_text(inst.text)
            expected_inlets, expected_outlets = self._db.compute_io_counts(
                name, args if args else None
            )

            if inst.numinlets != expected_inlets or inst.numoutlets != expected_outlets:
                mismatches.append({
                    "text": inst.text,
                    "help_inlets": inst.numinlets,
                    "help_outlets": inst.numoutlets,
                    "expected_inlets": expected_inlets,
                    "expected_outlets": expected_outlets,
                })

        if not mismatches:
            return None

        # Compute confidence on the mismatch pattern
        level, ratio, consensus = compute_confidence(
            instances,
            lambda inst: (inst.numinlets, inst.numoutlets),
        )

        # Get DB default counts for summary
        db_inlets, db_outlets = self._db.compute_io_counts(name)

        return {
            "db_inlets": db_inlets,
            "db_outlets": db_outlets,
            "help_inlets": consensus[0] if consensus else None,
            "help_outlets": consensus[1] if consensus else None,
            "confidence": level,
            "agreement": ratio,
            "variable_io": is_variable_io,
            "mismatches": mismatches,
        }
