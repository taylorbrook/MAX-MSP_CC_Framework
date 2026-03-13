"""CLI entry point for the help patch audit pipeline.

Wires parser, analyzer, reporter, and override generator into a single-pass
audit pipeline that can be invoked from the command line.
"""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

from src.maxpat.audit.analyzer import AuditAnalyzer
from src.maxpat.audit.overrides import OverrideGenerator
from src.maxpat.audit.parser import HelpPatchParser, filter_degenerate
from src.maxpat.audit.reporter import AuditReporter
from src.maxpat.db_lookup import ObjectDatabase

DEFAULT_HELP_DIR = Path("/Applications/Max.app/Contents/Resources/C74/help")
DEFAULT_OUTPUT_DIR = Path(".claude/max-objects/audit")

# Mapping from CLI flag names to reporter dimension labels
_FLAG_TO_DIMENSION = {
    "outlets_only": "outlet_types",
    "widths_only": "widths",
    "empty_io_only": "empty_io",
    "connections_only": "connections",
    "args_only": "arguments",
}


def main(argv: list[str] | None = None) -> int:
    """Run the full audit pipeline.

    Args:
        argv: Command-line arguments. Defaults to sys.argv[1:] if None.

    Returns:
        0 on success, 1 on error.
    """
    parser = argparse.ArgumentParser(
        prog="audit",
        description="Audit MAX help patches against the object database.",
    )
    parser.add_argument(
        "--help-dir",
        type=Path,
        default=DEFAULT_HELP_DIR,
        help=f"Path to MAX help directory (default: {DEFAULT_HELP_DIR})",
    )
    parser.add_argument(
        "--output-dir",
        type=Path,
        default=DEFAULT_OUTPUT_DIR,
        help=f"Output directory for audit results (default: {DEFAULT_OUTPUT_DIR})",
    )
    parser.add_argument(
        "--outlets-only",
        action="store_true",
        help="Filter report to outlet type findings only",
    )
    parser.add_argument(
        "--widths-only",
        action="store_true",
        help="Filter report to width findings only",
    )
    parser.add_argument(
        "--empty-io-only",
        action="store_true",
        help="Filter report to empty I/O coverage only",
    )
    parser.add_argument(
        "--connections-only",
        action="store_true",
        help="Filter report to connection findings only",
    )
    parser.add_argument(
        "--args-only",
        action="store_true",
        help="Filter report to argument findings only",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Run analysis but don't write output files",
    )
    parser.add_argument(
        "--verbose",
        action="store_true",
        help="Print progress during parsing",
    )

    args = parser.parse_args(argv)

    # Validate help directory
    if not args.help_dir.exists():
        print(f"Error: help directory not found: {args.help_dir}", file=sys.stderr)
        return 1

    if not args.help_dir.is_dir():
        print(f"Error: not a directory: {args.help_dir}", file=sys.stderr)
        return 1

    # Initialize components
    db = ObjectDatabase()
    help_parser = HelpPatchParser()
    analyzer = AuditAnalyzer(db)
    reporter = AuditReporter(db)
    override_gen = OverrideGenerator(db)

    # ---- Parse phase ----
    if args.verbose:
        print(f"Parsing help patches in: {args.help_dir}")

    parse_stats: dict = {
        "files_parsed": 0,
        "files_failed": [],
        "total_instances": 0,
        "unique_objects": 0,
    }

    # Parse all .maxhelp files
    help_files = sorted(args.help_dir.glob("*.maxhelp"))
    instances_by_object: dict[str, list] = {}
    all_instances: list = []

    for help_file in help_files:
        try:
            instances = help_parser.parse_file(help_file, db=db)
            parse_stats["files_parsed"] += 1

            # Group by object name
            for inst in instances:
                if inst.name not in instances_by_object:
                    instances_by_object[inst.name] = []
                instances_by_object[inst.name].append(inst)
                all_instances.append(inst)

            if args.verbose and parse_stats["files_parsed"] % 100 == 0:
                print(f"  Parsed {parse_stats['files_parsed']} files...")

        except Exception as e:
            parse_stats["files_failed"].append({
                "file": str(help_file.name),
                "error": str(e),
            })

    parse_stats["total_instances"] = len(all_instances)
    parse_stats["unique_objects"] = len(instances_by_object)

    if args.verbose:
        print(
            f"Parsed {parse_stats['files_parsed']} files, "
            f"{len(parse_stats['files_failed'])} failed, "
            f"{parse_stats['total_instances']} instances, "
            f"{parse_stats['unique_objects']} unique objects"
        )

    # ---- Filter phase ----
    if args.verbose:
        print("Filtering degenerate instances...")

    for obj_name in list(instances_by_object.keys()):
        instances_by_object[obj_name] = filter_degenerate(
            instances_by_object[obj_name], db
        )
        # Remove objects with no instances after filtering
        if not instances_by_object[obj_name]:
            del instances_by_object[obj_name]

    # Rebuild all_instances after filtering
    all_instances = []
    for objs in instances_by_object.values():
        all_instances.extend(objs)

    if args.verbose:
        print(
            f"After filtering: {len(instances_by_object)} objects, "
            f"{len(all_instances)} instances"
        )

    # ---- Analyze phase ----
    if args.verbose:
        print("Analyzing discrepancies...")

    findings = analyzer.analyze_all(instances_by_object, all_instances)

    # ---- Report phase ----
    if args.verbose:
        print("Generating report...")

    report = reporter.generate_report(findings, parse_stats)

    # Apply dimension filter if any --*-only flag is set
    active_filter = None
    for flag_name, dimension in _FLAG_TO_DIMENSION.items():
        if getattr(args, flag_name, False):
            active_filter = dimension
            break

    if active_filter and active_filter != "empty_io":
        report = reporter.filter_report(report, active_filter)

    # Get empty I/O coverage data
    empty_io_data = reporter.find_empty_io_objects(findings)

    # ---- Override phase ----
    if args.verbose:
        print("Generating proposed overrides...")

    proposed_overrides = override_gen.generate_proposed_overrides(
        findings, empty_io_data
    )

    # ---- Write phase ----
    if not args.dry_run:
        output_dir = args.output_dir
        output_dir.mkdir(parents=True, exist_ok=True)

        if args.verbose:
            print(f"Writing output to: {output_dir}")

        # Write audit report
        report_path = output_dir / "audit-report.json"
        reporter.write_report(report, report_path)

        # Write empty I/O coverage
        empty_io_path = output_dir / "empty-io-coverage.json"
        reporter.write_report(empty_io_data, empty_io_path)

        # Write proposed overrides
        overrides_path = output_dir / "proposed-overrides.json"
        override_gen.write_proposed_overrides(proposed_overrides, overrides_path)

    # ---- Summary ----
    summary = report.get("summary", {})
    by_confidence = summary.get("by_confidence", {})
    conflicts_count = len(proposed_overrides.get("conflicts", {}))

    print(f"\nAudit complete:")
    print(f"  Files parsed: {parse_stats['files_parsed']}")
    print(f"  Files failed: {len(parse_stats['files_failed'])}")
    print(f"  Objects analyzed: {summary.get('objects_analyzed', 0)}")
    print(f"  Objects with discrepancies: {summary.get('objects_with_discrepancies', 0)}")
    print(f"  Discrepancies by confidence:")
    for level in ["HIGH", "MEDIUM", "LOW", "CONFLICT"]:
        count = by_confidence.get(level, 0)
        if count:
            print(f"    {level}: {count}")
    print(f"  Conflicts with manual overrides: {conflicts_count}")
    if proposed_overrides.get("objects"):
        print(f"  Proposed override entries: {len(proposed_overrides['objects'])}")

    if not args.dry_run:
        print(f"\n  Output written to: {args.output_dir}")

    return 0


if __name__ == "__main__":
    sys.exit(main())
