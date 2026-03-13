"""Audit analysis engine for comparing help patch data against the object database.

Compares parser-extracted help patch data against the ObjectDatabase across
5 dimensions: outlet types, I/O counts, box widths, argument formats, and
connection patterns. Produces per-object findings with confidence scores.
"""

from __future__ import annotations

import statistics
from collections import Counter, defaultdict
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

    def analyze_widths(
        self, name: str, instances: list[BoxInstance]
    ) -> dict | None:
        """Extract box width statistics from patching_rect data.

        Collects the width component (index 2) from each instance's
        patching_rect and computes median, min, max statistics.

        Args:
            name: Object name.
            instances: BoxInstance list for this object.

        Returns:
            Finding dict with width statistics, or None if no width data.
        """
        widths: list[float] = []
        for inst in instances:
            rect = inst.patching_rect
            if rect and len(rect) >= 3:
                widths.append(rect[2])

        if not widths:
            return None

        return {
            "widths": widths,
            "median_width": statistics.median(widths),
            "min_width": min(widths),
            "max_width": max(widths),
            "instance_count": len(widths),
        }

    def analyze_arguments(
        self, name: str, instances: list[BoxInstance]
    ) -> dict | None:
        """Extract argument format patterns from box text fields.

        Parses each instance's text via parse_object_text, collects
        positional argument patterns as tuples, and counts frequency.
        Attributes (@key value pairs) are captured separately.

        Args:
            name: Object name.
            instances: BoxInstance list for this object.

        Returns:
            Finding dict with patterns sorted by frequency, or None if
            no instances have arguments.
        """
        arg_patterns: list[tuple[str, ...]] = []
        attr_patterns: list[tuple[str, ...]] = []

        for inst in instances:
            _, args, attrs = parse_object_text(inst.text)
            if args:
                arg_patterns.append(tuple(args))
            if attrs:
                attr_patterns.append(
                    tuple(sorted(f"{k}={v}" for k, v in attrs.items()))
                )

        if not arg_patterns and not attr_patterns:
            return None

        # Count argument pattern frequency
        arg_counts = Counter(arg_patterns)
        sorted_patterns = sorted(
            arg_counts.items(), key=lambda x: x[1], reverse=True
        )

        # Count attribute pattern frequency
        attr_counts = Counter(attr_patterns)
        sorted_attrs = sorted(
            attr_counts.items(), key=lambda x: x[1], reverse=True
        )

        return {
            "patterns": [(list(pattern), count) for pattern, count in sorted_patterns],
            "attribute_patterns": [
                (list(pattern), count) for pattern, count in sorted_attrs
            ],
            "instance_count": len(instances),
        }

    def analyze_connections(
        self,
        name: str,
        instances: list[BoxInstance],
        all_instances: list[BoxInstance] | None = None,
    ) -> dict | None:
        """Analyze connection patterns for an object.

        Builds a lookup from box_id to object_name across all_instances
        in the same source file, then constructs outlet-to-inlet and
        inlet-to-outlet frequency tables.

        Args:
            name: Object name.
            instances: BoxInstance list for this object.
            all_instances: All BoxInstance objects across all objects (for
                resolving box IDs to names within the same source file).

        Returns:
            Finding dict with connection frequency tables, or None if no
            connection data.
        """
        if all_instances is None:
            all_instances = instances

        # Build per-file box_id -> object_name lookup
        id_to_name: dict[str, dict[str, str]] = defaultdict(dict)
        for inst in all_instances:
            id_to_name[inst.source_file][inst.box_id] = inst.name

        # Collect outlet and inlet connections
        outlet_connections: dict[int, list[tuple[str, int, int]]] = defaultdict(list)
        inlet_connections: dict[int, list[tuple[str, int, int]]] = defaultdict(list)
        total_connections = 0

        for inst in instances:
            file_lookup = id_to_name.get(inst.source_file, {})

            for src_id, src_outlet, dst_id, dst_inlet in inst.connections:
                total_connections += 1

                if src_id == inst.box_id:
                    # This instance is the source -- record outlet connection
                    target_name = file_lookup.get(dst_id, dst_id)
                    outlet_connections[src_outlet].append(
                        (target_name, dst_inlet, 1)
                    )
                elif dst_id == inst.box_id:
                    # This instance is the destination -- record inlet connection
                    source_name = file_lookup.get(src_id, src_id)
                    inlet_connections[dst_inlet].append(
                        (source_name, src_outlet, 1)
                    )

        if total_connections == 0:
            return None

        # Aggregate counts for repeated connections
        def aggregate_connections(
            conn_dict: dict[int, list[tuple[str, int, int]]],
        ) -> dict[int, list[tuple[str, int, int]]]:
            result: dict[int, list[tuple[str, int, int]]] = {}
            for idx, conns in conn_dict.items():
                counter: Counter = Counter()
                for target_name, target_port, _ in conns:
                    counter[(target_name, target_port)] += 1
                result[idx] = [
                    (tn, tp, count) for (tn, tp), count in counter.most_common()
                ]
            return result

        return {
            "outlet_connections": aggregate_connections(dict(outlet_connections)),
            "inlet_connections": aggregate_connections(dict(inlet_connections)),
            "total_connections": total_connections,
        }

    def analyze_object(
        self,
        name: str,
        instances: list[BoxInstance],
        all_instances: list[BoxInstance] | None = None,
    ) -> ObjectFindings:
        """Run all 5 analysis dimensions for a single object.

        Args:
            name: Object name.
            instances: BoxInstance list for this object.
            all_instances: All BoxInstance objects across all objects
                (for connection analysis ID resolution).

        Returns:
            ObjectFindings with all dimensions populated.
        """
        return ObjectFindings(
            object_name=name,
            instance_count=len(instances),
            outlet_type_finding=self.analyze_outlet_types(name, instances),
            io_count_finding=self.analyze_io_counts(name, instances),
            width_finding=self.analyze_widths(name, instances),
            argument_finding=self.analyze_arguments(name, instances),
            connection_finding=self.analyze_connections(
                name, instances, all_instances
            ),
        )

    def analyze_all(
        self,
        instances_by_object: dict[str, list[BoxInstance]],
        all_instances: list[BoxInstance] | None = None,
    ) -> dict[str, ObjectFindings]:
        """Run analysis across all objects.

        Args:
            instances_by_object: Dict mapping object name to BoxInstance list.
            all_instances: All BoxInstance objects across all objects
                (for connection analysis). If None, built from instances_by_object.

        Returns:
            Dict mapping object name to ObjectFindings.
        """
        if all_instances is None:
            all_instances = []
            for objs in instances_by_object.values():
                all_instances.extend(objs)

        results: dict[str, ObjectFindings] = {}
        for obj_name, instances in instances_by_object.items():
            results[obj_name] = self.analyze_object(
                obj_name, instances, all_instances
            )

        return results
