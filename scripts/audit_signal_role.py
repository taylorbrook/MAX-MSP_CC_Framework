#!/usr/bin/env python3
"""Audit signal_role coverage across MSP and MC tilde domains.

Plan 30-01 (initial): scaffold + report-only mode. The script imports
ObjectDatabase, calls audit_signal_role_coverage(), prints per-domain
gap counts, and exits.

Plan 30-03 (this commit): extends with a digest-keyword classifier
(high/medium/low confidence per D-08) that proposes signal_role values
for uncovered outlets, writes SIGNAL-ROLE-REVIEW.md +
signal-role-audit.json under .planning/phases/30-msp-outlet-coverage-sweep/,
and gains an --apply subcommand that reads the curator-edited review
file and writes resolved roles into .claude/max-objects/overrides.json.

Per CONTEXT.md D-09/D-10 the success bar is gap_count < 20 for BOTH
msp and mc domains.

Synonym sets are RESTRICTED to CONTEXT.md D-05's locked tokens:
    data:  parameter, index, count, position
    float: value, ms, samples, dB (matched as "db"), note
    list:  symbol (and the literal word "list")

Tokens NOT permitted in any synonym set (per Blocker 3 lockdown):
    info, channel, name, metadata, hz, freq, amp
"""

from __future__ import annotations

import argparse
import json
import re as _re
import sys
from pathlib import Path

# Ensure project root on path when invoked as `python scripts/audit_signal_role.py`
_PROJECT_ROOT = Path(__file__).resolve().parents[1]
if str(_PROJECT_ROOT) not in sys.path:
    sys.path.insert(0, str(_PROJECT_ROOT))

from src.maxpat.db_lookup import ObjectDatabase, _SIGNAL_ROLE_ENUM  # noqa: E402


# ── Module constants ──────────────────────────────────────────────

# Phase 30 review-file location (inside the phase dir per CONTEXT.md D-06).
_PHASE_DIR = (
    _PROJECT_ROOT / ".planning" / "phases" / "30-msp-outlet-coverage-sweep"
)
_DEFAULT_REVIEW_FILE = _PHASE_DIR / "SIGNAL-ROLE-REVIEW.md"
_DEFAULT_AUDIT_JSON = _PHASE_DIR / "signal-role-audit.json"
_DEFAULT_OVERRIDES = _PROJECT_ROOT / ".claude" / "max-objects" / "overrides.json"

# Per CONTEXT.md D-05: STRICT regex for trigger/status (high confidence —
# auto-apply directly because false positives in this lane would
# auto-remove patch connections in role-aware validation).
_TRIGGER_KEYWORDS = frozenset({"bang", "done"})
_STATUS_KEYWORDS = frozenset({"state", "mute", "flag", "active", "busy"})

# Per CONTEXT.md D-05 LOCKED synonym set. The broad map is:
#   data:  parameter, index, count, position
#   float: value, ms, samples, dB (matched as "db"), note
#   list:  symbol (and the literal word "list")
# Tokens NOT permitted in any synonym set (per Blocker 3 lockdown):
#   info, channel, name, metadata, hz, freq, amp
# Adding any of these here is a CONTEXT D-05 violation. Test
# `test_unauthorized_synonyms_classify_as_low` enforces the lockdown.
_LIST_SYNONYMS = frozenset({"symbol"})
_DATA_SYNONYMS = frozenset({"parameter", "index", "count", "position"})
_FLOAT_SYNONYMS = frozenset({"value", "ms", "samples", "db", "note"})

# The literal token "list" is also a list-classifier hit (D-05's prose
# example names "list" and "symbol" as list-shapes). Kept separate from
# the synonym set so the lockdown audit grep is unambiguous.
_LIST_LITERAL = "list"

# Whole-word matching: tokenize digest into lowercased alphanumeric runs.
_TOKEN_RE = _re.compile(r"[A-Za-z]+")

# Markdown review-table column header (must match exactly for the parser
# to find the table start).
_REVIEW_HEADER = (
    "| object | outlet_id | digest | suggested_role | confidence | curator_role |\n"
    "|---|---|---|---|---|---|\n"
)


# ── Classifier ────────────────────────────────────────────────────


def _classify_digest(
    object_name: str,
    outlet_id: int,
    digest: str,
    signal: bool,
) -> tuple[str | None, str, str]:
    """Classify a single outlet into (role, confidence, rationale).

    Per CONTEXT.md D-04 (signal:true wins), D-05 LOCKED synonym set
    (data={parameter,index,count,position}; float={value,ms,samples,db,note};
    list={symbol, literal "list"}), D-08 (three-tier confidence:
    high/medium/low).

    Tokens OUTSIDE the locked set (info/channel/name/metadata/hz/freq/amp)
    do NOT match any synonym; they fall through to (None, "low", "no_match").

    Returns (None, "low", "no_match") for unmatchable digests; curator
    must fill curator_role in SIGNAL-ROLE-REVIEW.md before --apply.
    """
    # D-04: signal:true ALWAYS classifies as audio, ignoring digest text.
    if signal is True:
        return ("audio", "high", "signal_true")

    tokens = {t.lower() for t in _TOKEN_RE.findall(digest or "")}

    # D-05: strict trigger/status (high confidence — auto-apply).
    if tokens & _TRIGGER_KEYWORDS:
        return ("trigger", "high", "trigger_keyword")
    if tokens & _STATUS_KEYWORDS:
        return ("status", "high", "status_keyword")

    # D-05: broad synonyms (medium confidence — auto-apply with # verify).
    # Order matters: list → float → data so a digest like "list of values"
    # classifies as `list` not `float`.
    if (tokens & _LIST_SYNONYMS) or (_LIST_LITERAL in tokens):
        return ("list", "medium", "list_synonym")
    if tokens & _FLOAT_SYNONYMS:
        return ("float", "medium", "float_synonym")
    if tokens & _DATA_SYNONYMS:
        return ("data", "medium", "data_synonym")

    # D-08: low — curator must fill curator_role.
    return (None, "low", "no_match")


def _classify_outlet(
    name: str,
    obj: dict,
    outlet_idx: int,
) -> dict:
    """Classify a single outlet and return a ClassifiedRow dict.

    Blocker 2 fix: extracted from _classify_db's inner loop so Plan 30-04's
    MC fall-through path (sibling-mirror parity-mismatch + inherited-no-role
    cases) can call this helper directly per outlet.

    Args:
      name: canonical object name (e.g., "gain~", "mc.cycle~")
      obj: the full object dict from db.lookup(name)
      outlet_idx: 0-based outlet index into obj["outlets"]

    Returns:
      dict with keys: object, outlet_id, digest, suggested_role,
                      confidence, curator_role (always ""), rationale
    """
    outlets = obj.get("outlets", []) or []
    if outlet_idx >= len(outlets):
        return {
            "object": name,
            "outlet_id": outlet_idx,
            "digest": "",
            "suggested_role": "",
            "confidence": "low",
            "curator_role": "",
            "rationale": "no_match",
        }
    outlet = outlets[outlet_idx]
    if not isinstance(outlet, dict):
        return {
            "object": name,
            "outlet_id": outlet_idx,
            "digest": "",
            "suggested_role": "",
            "confidence": "low",
            "curator_role": "",
            "rationale": "no_match",
        }
    role, conf, rat = _classify_digest(
        object_name=name,
        outlet_id=outlet.get("id", outlet_idx),
        digest=outlet.get("digest", ""),
        signal=bool(outlet.get("signal", False)),
    )
    return {
        "object": name,
        "outlet_id": outlet.get("id", outlet_idx),
        "digest": outlet.get("digest", ""),
        "suggested_role": role or "",
        "confidence": conf,
        "curator_role": "",
        "rationale": rat,
    }


def _classify_db(domains: tuple[str, ...]) -> list[dict]:
    """Walk uncovered MSP/MC outlets and emit ClassifiedRow dicts.

    Refactored per Blocker 2 to delegate per-outlet classification to
    `_classify_outlet(name, obj, outlet_idx)`. The walker handles
    domain filtering and skip-already-covered logic; the helper handles
    the per-outlet shape.
    """
    db = ObjectDatabase()
    coverage = db.audit_signal_role_coverage()
    rows: list[dict] = []
    domain_field = {"msp": "MSP", "mc": "MC"}
    for d in domains:
        if d not in domain_field:
            raise ValueError(f"unknown domain {d!r}")
        for name in coverage[d]["uncovered"]:
            obj = db.lookup(name)
            if not obj:
                continue
            for i, outlet in enumerate(obj.get("outlets", []) or []):
                if not isinstance(outlet, dict):
                    continue
                if outlet.get("signal_role"):
                    continue  # already covered (mixed-coverage object)
                rows.append(_classify_outlet(name, obj, i))
    rows.sort(key=lambda r: (r["object"], r["outlet_id"]))
    return rows


# ── Review-file writer / parser (Warning 5: pipe-escape) ─────────


def _escape_pipe(cell: str) -> str:
    """Escape literal `|` in a cell to `\\|` so the markdown table parser
    sees one cell, not two. Companion to _parse_review_md's unescape."""
    return (cell or "").replace("|", "\\|")


def _write_review_md(path: Path, rows: list[dict]) -> None:
    lines = [
        "# Signal Role Review (Plan 30-03)",
        "",
        (
            "Curator: edit `curator_role` column for any row where you "
            "disagree with `suggested_role`, OR for low-confidence rows "
            "(suggested_role empty). Then run "
            "`python scripts/audit_signal_role.py apply` from the project root."
        ),
        "",
        "Confidence tiers (D-08):",
        "- **high**: auto-applied. Override only if extraction was wrong.",
        "- **medium**: auto-applied with `# verify` marker. Spot-check.",
        "- **low**: NOT applied. Curator MUST fill `curator_role`.",
        "",
        _REVIEW_HEADER.rstrip(),
    ]
    for r in rows:
        suggested = r["suggested_role"]
        if r["confidence"] == "medium" and suggested:
            suggested = f"{suggested} # verify"
        lines.append(
            f"| {r['object']} | {r['outlet_id']} | "
            f"{_escape_pipe(r['digest'])} | "
            f"{suggested} | {r['confidence']} | {r['curator_role']} |"
        )
    path.write_text("\n".join(lines) + "\n", encoding="utf-8")


def _write_audit_json(path: Path, rows: list[dict]) -> None:
    path.write_text(
        json.dumps(rows, indent=2, sort_keys=False, ensure_ascii=False) + "\n",
        encoding="utf-8",
    )


def _parse_review_md(text: str) -> list[dict]:
    """Parse a 6-column markdown table. Skip header + separator. Strict shape.

    Warning 5 fix: unescape `\\|` → `|` on each cell so digests containing
    literal pipes round-trip (writer escapes via _escape_pipe; parser
    unescapes here by merging cells whose previous segment ends with a
    backslash — that backslash was the escape character for the original
    pipe).
    """
    rows: list[dict] = []
    in_table = False
    for line in text.splitlines():
        if line.startswith("| object | outlet_id |"):
            in_table = True
            continue
        if not in_table:
            continue
        if line.startswith("|---"):
            continue
        if not line.strip().startswith("|"):
            continue

        # Split on `|` then merge cells where the previous cell ended
        # with a backslash (the `|` was escaped to `\|`).
        raw_cells = line.strip().strip("|").split("|")
        merged: list[str] = []
        i = 0
        while i < len(raw_cells):
            cell = raw_cells[i]
            while cell.endswith("\\") and i + 1 < len(raw_cells):
                cell = cell[:-1] + "|" + raw_cells[i + 1]
                i += 1
            merged.append(cell.strip())
            i += 1
        cells = merged
        if len(cells) != 6:
            raise ValueError(
                f"malformed review row (expected 6 cells, got {len(cells)}): {line!r}"
            )
        obj, oid_s, digest, suggested, conf, curator = cells
        try:
            oid = int(oid_s)
        except ValueError as e:
            raise ValueError(f"malformed outlet_id in row: {line!r}") from e
        # Strip the # verify marker (re-added at write time).
        suggested = suggested.split("#", 1)[0].strip()
        rows.append({
            "object": obj,
            "outlet_id": oid,
            "digest": digest,
            "suggested_role": suggested,
            "confidence": conf,
            "curator_role": curator,
        })
    return rows


# ── audit subcommand ──────────────────────────────────────────────


def cmd_audit_run(
    write_review: bool = False,
    review_dir: Path | None = None,
    domains: tuple[str, ...] = ("msp", "mc"),
    threshold: int = 20,
) -> int:
    """Print current per-domain signal_role coverage and optionally write
    SIGNAL-ROLE-REVIEW.md + signal-role-audit.json under review_dir.

    Returns 0 if all in-scope domains' gap_counts < threshold, else 1.
    """
    db = ObjectDatabase()
    result = db.audit_signal_role_coverage()
    print("signal_role coverage audit")
    print("=" * 40)
    over: list[str] = []
    for d in ("msp", "mc"):
        if d not in domains:
            continue
        bucket = result[d]
        print(f"\n[{d}]")
        print(f"  covered   : {len(bucket['covered'])}")
        print(
            f"  uncovered : {len(bucket['uncovered'])} "
            f"(gap_count={bucket['gap_count']})"
        )
        print(f"  by_role   : {bucket['by_role']}")
        if bucket["gap_count"] >= threshold:
            print(
                f"  status    : ABOVE THRESHOLD "
                f"({bucket['gap_count']} >= {threshold})"
            )
            over.append(d)
        else:
            print(f"  status    : OK ({bucket['gap_count']} < {threshold})")
    if write_review:
        target = review_dir or _PHASE_DIR
        target.mkdir(parents=True, exist_ok=True)
        rows = _classify_db(domains)
        _write_review_md(target / "SIGNAL-ROLE-REVIEW.md", rows)
        _write_audit_json(target / "signal-role-audit.json", rows)
        print(f"\nwrote {target / 'SIGNAL-ROLE-REVIEW.md'}")
        print(f"wrote {target / 'signal-role-audit.json'}")
    if over:
        print(f"\nFAIL: domains over threshold: {over}")
        return 1
    print("\nOK: all domains under threshold.")
    return 0


def cmd_audit(args: argparse.Namespace) -> int:
    return cmd_audit_run(
        write_review=getattr(args, "write_review", False),
        review_dir=getattr(args, "review_dir", None),
        threshold=args.threshold,
    )


# ── apply subcommand ──────────────────────────────────────────────


def cmd_apply_run(
    review_file: Path,
    overrides_file: Path | None = None,
    force: bool = False,
) -> int:
    """Apply curator-edited review-file rows to overrides.json.

    Enforces (per CONTEXT.md D-04/D-05/D-08 + threat model):
    - path-traversal guard: review_file must resolve INSIDE
      .planning/phases/30-msp-outlet-coverage-sweep/
    - closed-enum validation: resolved_role must be in _SIGNAL_ROLE_ENUM
    - low-confidence rows must have a curator_role filled
    - existing signal_role overwrite refused without --force
    - post-write loader-acceptance check (when overrides_file is the
      canonical default; tests use isolated paths so the loader check
      is skipped — the round-trip JSON validation still runs)

    Returns:
      0  on success (including idempotent no-op)
      1  if review_file or overrides_file is missing
      2  on any validation/guard failure
    """
    overrides_file = Path(overrides_file or _DEFAULT_OVERRIDES).resolve()
    review_file = Path(review_file).resolve()

    # T-30-03-01: path-traversal guard. Review file MUST resolve INSIDE
    # the phase dir (or a tmp_path equivalent matching the same suffix).
    # Check the path's three nearest parents are
    # [".planning", "phases", "30-msp-outlet-coverage-sweep"].
    parents = list(review_file.parents)[:3]
    parent_names = [p.name for p in parents]
    if parent_names != ["30-msp-outlet-coverage-sweep", "phases", ".planning"]:
        print(
            f"ERROR: review file must live under "
            f".planning/phases/30-msp-outlet-coverage-sweep/; "
            f"got {review_file} (outside phase dir)",
            file=sys.stderr,
        )
        return 2

    if not review_file.is_file():
        print(
            f"ERROR: review file does not exist: {review_file}",
            file=sys.stderr,
        )
        return 1
    if not overrides_file.is_file():
        print(
            f"ERROR: overrides file does not exist: {overrides_file}",
            file=sys.stderr,
        )
        return 1

    # Parse the review file.
    try:
        rows = _parse_review_md(review_file.read_text(encoding="utf-8"))
    except ValueError as e:
        print(f"ERROR: {e}", file=sys.stderr)
        return 2

    # Resolve each row.
    resolved: list[tuple[str, int, str]] = []
    for r in rows:
        if r["confidence"] == "low" and not r["curator_role"]:
            print(
                f"ERROR: low-confidence row has empty curator_role: "
                f"{r['object']} outlet {r['outlet_id']}",
                file=sys.stderr,
            )
            return 2
        chosen = r["curator_role"] or r["suggested_role"]
        if chosen not in _SIGNAL_ROLE_ENUM:
            print(
                f"ERROR: invalid role {chosen!r} for {r['object']} "
                f"outlet {r['outlet_id']} "
                f"(must be in {sorted(_SIGNAL_ROLE_ENUM)})",
                file=sys.stderr,
            )
            return 2
        resolved.append((r["object"], r["outlet_id"], chosen))

    # Load overrides, mutate, validate, write atomically.
    data = json.loads(overrides_file.read_text(encoding="utf-8"))
    objects = data.setdefault("objects", {})
    changed = False
    for obj_name, outlet_id, role in resolved:
        entry = objects.setdefault(obj_name, {"outlets": []})
        outlets = entry.setdefault("outlets", [])
        # Find or create the outlet by id.
        target = None
        for o in outlets:
            if isinstance(o, dict) and o.get("id") == outlet_id:
                target = o
                break
        if target is None:
            target = {"id": outlet_id, "type": "", "digest": ""}
            outlets.append(target)
        existing = target.get("signal_role")
        if existing == role:
            continue  # idempotent
        if existing and existing != role and not force:
            print(
                f"ERROR: refusing to overwrite signal_role={existing!r} "
                f"with {role!r} on {obj_name} outlet {outlet_id} "
                f"(use --force to override)",
                file=sys.stderr,
            )
            return 2
        target["signal_role"] = role
        # Per Plan 30-02 D-03: drop legacy bool when role is written.
        target.pop("signal", None)
        changed = True

    if not changed:
        return 0

    new_text = json.dumps(data, indent=2, ensure_ascii=False) + "\n"
    # Round-trip validate before writing.
    try:
        json.loads(new_text)
    except json.JSONDecodeError as e:
        print(f"ERROR: produced invalid JSON: {e}", file=sys.stderr)
        return 2

    # Atomic write.
    tmp = overrides_file.with_suffix(".json.tmp")
    tmp.write_text(new_text, encoding="utf-8")
    tmp.replace(overrides_file)

    # Loader-acceptance check (closed-enum guard, schema validator).
    # Only run for the canonical default file — isolated test paths
    # don't live under .claude/max-objects/ and the constructor reads
    # the canonical path.
    if overrides_file == _DEFAULT_OVERRIDES.resolve():
        try:
            ObjectDatabase()
        except Exception as e:  # noqa: BLE001
            print(
                f"ERROR: post-write loader rejected overrides.json: {e}",
                file=sys.stderr,
            )
            return 2

    return 0


def cmd_apply(args: argparse.Namespace) -> int:
    return cmd_apply_run(
        review_file=Path(args.review_file or _DEFAULT_REVIEW_FILE),
        overrides_file=Path(args.overrides_file or _DEFAULT_OVERRIDES),
        force=bool(args.force),
    )


# ── argparse wiring ───────────────────────────────────────────────


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="audit_signal_role",
        description=(
            "Audit signal_role coverage across MSP/MC tilde domains. "
            "Plan 30-03 ships the digest classifier and --apply."
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
    audit.add_argument(
        "--write-review",
        action="store_true",
        help=(
            "Also write SIGNAL-ROLE-REVIEW.md and signal-role-audit.json "
            "under the phase dir."
        ),
    )
    audit.set_defaults(func=cmd_audit)

    apply_cmd = sub.add_parser(
        "apply", help="Apply curator-resolved review file (Plan 30-03)"
    )
    apply_cmd.add_argument(
        "--review-file",
        default=None,
        help=f"Default: {_DEFAULT_REVIEW_FILE}",
    )
    apply_cmd.add_argument(
        "--overrides-file",
        default=None,
        help=f"Default: {_DEFAULT_OVERRIDES}",
    )
    apply_cmd.add_argument(
        "--force",
        action="store_true",
        help="Overwrite existing signal_role values (D-04 conflict consent).",
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
