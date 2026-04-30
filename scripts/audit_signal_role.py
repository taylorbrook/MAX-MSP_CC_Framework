#!/usr/bin/env python3
"""Audit signal_role coverage across MSP and MC tilde domains.

Plan 30-01 (this commit): scaffold + report-only mode. The script imports
ObjectDatabase, calls audit_signal_role_coverage(), prints per-domain
gap counts, and exits.

Plan 30-03: extends with a digest-keyword classifier (high/medium/low
confidence per D-08) that proposes signal_role values for uncovered
outlets, writes SIGNAL-ROLE-REVIEW.md + signal-role-audit.json under
.planning/phases/30-msp-outlet-coverage-sweep/, and gains an --apply
subcommand that reads the curator-edited review file and writes
resolved roles into .claude/max-objects/overrides.json.

Per CONTEXT.md D-09/D-10 the success bar is gap_count < 20 for BOTH
msp and mc domains. This skeleton is the gate that the migration
plans verify against.
"""

from __future__ import annotations

import argparse
import sys
from pathlib import Path

# Ensure project root on path when invoked as `python scripts/audit_signal_role.py`
_PROJECT_ROOT = Path(__file__).resolve().parents[1]
if str(_PROJECT_ROOT) not in sys.path:
    sys.path.insert(0, str(_PROJECT_ROOT))

from src.maxpat.db_lookup import ObjectDatabase  # noqa: E402


def cmd_audit(args: argparse.Namespace) -> int:
    """Default subcommand: print current per-domain signal_role coverage.

    Exits 0 when both msp and mc gap_counts are below the threshold (20
    per D-10), 1 otherwise. Plan 30-03 extends this to also write the
    review file + json snapshot.
    """
    db = ObjectDatabase()
    result = db.audit_signal_role_coverage()
    threshold = args.threshold

    print("signal_role coverage audit")
    print("=" * 40)
    for domain in ("msp", "mc"):
        bucket = result[domain]
        print(f"\n[{domain}]")
        print(f"  covered   : {len(bucket['covered'])}")
        print(f"  uncovered : {len(bucket['uncovered'])} (gap_count={bucket['gap_count']})")
        print(f"  by_role   : {bucket['by_role']}")
        if bucket["gap_count"] >= threshold:
            print(f"  status    : ABOVE THRESHOLD ({bucket['gap_count']} >= {threshold})")
        else:
            print(f"  status    : OK ({bucket['gap_count']} < {threshold})")

    over_threshold = [
        d for d in ("msp", "mc") if result[d]["gap_count"] >= threshold
    ]
    if over_threshold:
        print(f"\nFAIL: domains over threshold: {over_threshold}")
        return 1
    print("\nOK: all domains under threshold.")
    return 0


def cmd_apply(args: argparse.Namespace) -> int:
    """Apply curator-edited SIGNAL-ROLE-REVIEW.md to overrides.json.

    Plan 30-01: stub -- exits 2 with a not-implemented message.
    Plan 30-03: full implementation (read review file, validate,
    deep-merge into .claude/max-objects/overrides.json).
    """
    # Plan 30-01 leaves this unimplemented. Plan 30-03 will replace this
    # stub with the digest-classifier-driven apply path that reads the
    # curator-edited SIGNAL-ROLE-REVIEW.md and writes resolved roles into
    # overrides.json.
    print(
        "ERROR: --apply is not implemented in Plan 30-01.\n"
        "       This subcommand lands in Plan 30-03 alongside the "
        "digest classifier.",
        file=sys.stderr,
    )
    return 2


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="audit_signal_role",
        description=(
            "Audit signal_role coverage across MSP/MC tilde domains. "
            "Plan 30-01 ships report-only; Plan 30-03 adds the digest "
            "classifier and --apply."
        ),
    )
    sub = parser.add_subparsers(dest="cmd")

    audit = sub.add_parser("audit", help="Report current coverage (default)")
    audit.add_argument(
        "--threshold",
        type=int,
        default=20,
        help="Per-domain gap_count threshold (D-10 locks default at 20).",
    )
    audit.set_defaults(func=cmd_audit)

    apply_cmd = sub.add_parser(
        "apply", help="Apply curator-resolved review file (Plan 30-03)"
    )
    apply_cmd.set_defaults(func=cmd_apply)

    return parser


def main(argv: list[str] | None = None) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)
    if not hasattr(args, "func"):
        # No subcommand → default to audit with default threshold
        args = parser.parse_args(["audit"])
    return args.func(args)


if __name__ == "__main__":
    raise SystemExit(main())
