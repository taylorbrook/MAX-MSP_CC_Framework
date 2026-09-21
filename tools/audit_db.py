#!/usr/bin/env python3
"""Read-only audit of .claude/max-objects/ against the installed Max bundle.

Answers "is the object DB still true against the installed Max?" on demand,
without a full ad-hoc review. Emits a short text summary to stdout and,
optionally, one JSON document via --json.

Read-only contract
------------------
* The ONLY file this tool ever opens for writing is the ``--json`` target,
  and that path is screened by :func:`guard_output_path`, which refuses any
  path resolving under ``<repo-root>/patches`` or
  ``<repo-root>/.claude/max-objects``.
* The Max binary is NEVER executed. The installed version is read from
  ``Contents/Info.plist`` with :mod:`plistlib`.
* The only subprocesses spawned are ``git`` invocations, always passed as
  argv lists (never a shell string).

Sections
--------
``install``             installed Max version + refpage roots (Info.plist)
``db_age``              extraction timestamp age + per-domain count drift
``missing_from_db``     refpage object names ObjectDatabase.lookup() misses
``absent_from_bundle``  core-domain DB names with no installed refpage
``empty_io``            audit_empty_io() / audit_half_empty_io() + refpage flag
``patch_objects``       object resolution across committed .maxpat files
``ui_maxclasses_gap``   observed maxclasses not in UI_MAXCLASSES

Every section key is always present in the envelope, and every section
degrades to ``{"available": false, "reason": ...}`` rather than raising, so
a machine with no Max installed still gets the DB- and patch-derived data.

Usage
-----
    python3 tools/audit_db.py
    python3 tools/audit_db.py --json /tmp/db-audit.json
    python3 tools/audit_db.py --max-app /Applications/Max.app --patch-source head

Origin: NH-01 in .planning/quick/260921-g5d-.../260921-g5d-REVIEW-FINDINGS.md,
promoted to a committed harness by quick-260921-knq. Provenance style follows
tools/extract_pkg_io.py.
"""

from __future__ import annotations

import argparse
import json
import plistlib
import sys
from datetime import datetime, timezone
from pathlib import Path

# Project root: this file is at tools/audit_db.py
ROOT = Path(__file__).resolve().parent.parent

# Allow `from src.maxpat.db_lookup import ObjectDatabase`
sys.path.insert(0, str(ROOT))

from src.maxpat.db_lookup import DOMAIN_LOAD_ORDER, ObjectDatabase  # noqa: E402

DEFAULT_MAX_APP = Path("/Applications/Max.app")

# Core refpage directories, relative to <max-app>/Contents/Resources/C74.
CORE_REFPAGE_DIRS = [
    "docs/refpages/max-ref",
    "docs/refpages/msp-ref",
    "docs/refpages/jit-ref",
    "docs/refpages/m4l-ref",
]

# Bundled packages ship their own refpages under packages/<Pkg>/docs/refpages.
PACKAGE_REFPAGE_GLOB = "packages/*/docs/refpages"

# Domain dirs holding a single objects.json (DOMAIN_LOAD_ORDER minus the
# "packages" sentinel, which is a directory of per-package dirs).
CORE_DOMAIN_DIRS = [d for d in DOMAIN_LOAD_ORDER if d != "packages"]

# Bound on recursion into nested `patcher` dicts when walking .maxpat boxes,
# so a malformed or adversarially nested file cannot exhaust the stack.
MAX_PATCHER_DEPTH = 32

# Sections the envelope always carries, in emit order.
SECTION_KEYS = [
    "install",
    "db_age",
    "missing_from_db",
    "absent_from_bundle",
    "empty_io",
    "patch_objects",
    "ui_maxclasses_gap",
]


class OutputPathRejected(ValueError):
    """Raised when a --json target resolves inside a protected tree."""


# Trees this tool must never write into. Relative to the repo root.
PROTECTED_SUBTREES = ("patches", ".claude/max-objects")


def guard_output_path(json_path: str | Path, repo_root: str | Path) -> Path:
    """Resolve a --json target, refusing any path inside a protected tree.

    This is the single structural guarantee behind the tool's "writes nothing
    under patches/ or .claude/max-objects/" claim (T-knq-01), and the only
    place the tool opens a file for writing. Kept as a named, importable
    function so the test suite can exercise it directly.

    Args:
        json_path: The requested output path (may be relative).
        repo_root: The repository root the protected trees are relative to.

    Returns:
        The resolved absolute output path.

    Raises:
        OutputPathRejected: when the resolved path is the protected tree
            itself or lives anywhere beneath it.
    """
    root = Path(repo_root).resolve()
    # strict=False: the output file legitimately does not exist yet.
    target = Path(json_path).resolve()
    for sub in PROTECTED_SUBTREES:
        protected = (root / sub).resolve()
        if target == protected or protected in target.parents:
            raise OutputPathRejected(
                f"refusing to write {target}: resolves inside the read-only "
                f"tree {protected}. This tool never writes under "
                f"{' or '.join(PROTECTED_SUBTREES)}."
            )
    return target


# ---------------------------------------------------------------------------
# Section: install
# ---------------------------------------------------------------------------


def _refpage_roots(c74: Path) -> list[Path]:
    """Existing core + bundled-package refpage directories under Contents/Resources/C74."""
    roots: list[Path] = []
    for rel in CORE_REFPAGE_DIRS:
        candidate = c74 / rel
        try:
            if candidate.is_dir():
                roots.append(candidate)
        except (PermissionError, OSError):
            continue
    try:
        roots.extend(sorted(p for p in c74.glob(PACKAGE_REFPAGE_GLOB) if p.is_dir()))
    except (PermissionError, OSError):
        pass
    return roots


def _split_short_version(raw: object) -> tuple[str | None, str | None]:
    """Split a CFBundleShortVersionString into (version, build id).

    Max 9.1.5 ships ``CFBundleShortVersionString = "9.1.5 (3db35fa476d)"`` and
    ``CFBundleVersion = "9.1.5"`` -- i.e. the build identifier lives in the
    *short* version string, not in CFBundleVersion. Normalising to the leading
    whitespace-delimited token keeps ``short_version`` comparable across
    installs while ``build_id`` preserves the hash.
    """
    if not isinstance(raw, str) or not raw.strip():
        return (None, None)
    text = raw.strip()
    version = text.split()[0]
    build_id = None
    if "(" in text and text.rstrip().endswith(")"):
        build_id = text[text.index("(") + 1 : text.rindex(")")].strip() or None
    return (version, build_id)


def audit_install(max_app: str | Path) -> dict:
    """Report the installed Max version, read from Info.plist (never executed)."""
    app = Path(max_app)
    plist_path = app / "Contents" / "Info.plist"
    try:
        with open(plist_path, "rb") as fh:
            plist = plistlib.load(fh)
    except FileNotFoundError:
        return {
            "available": False,
            "app_path": str(app),
            "reason": f"Info.plist not found at {plist_path}",
        }
    except PermissionError as exc:  # TCC-blocked bundle (SF-05)
        return {
            "available": False,
            "app_path": str(app),
            "reason": f"permission denied reading {plist_path}: {exc}",
        }
    except (OSError, plistlib.InvalidFileException, ValueError) as exc:
        return {
            "available": False,
            "app_path": str(app),
            "reason": f"could not parse {plist_path}: {exc}",
        }

    c74 = app / "Contents" / "Resources" / "C74"
    raw_short = plist.get("CFBundleShortVersionString")
    short_version, build_id = _split_short_version(raw_short)
    return {
        "available": True,
        "app_path": str(app),
        "short_version": short_version,
        "short_version_raw": raw_short,
        "build_version": plist.get("CFBundleVersion"),
        "build_id": build_id,
        "refpage_roots": [str(p) for p in _refpage_roots(c74)],
    }


# ---------------------------------------------------------------------------
# Section: db_age
# ---------------------------------------------------------------------------


def _live_domain_counts(db_root: Path) -> dict[str, int]:
    """Count objects actually on disk per domain, mirroring ObjectDatabase._load."""
    counts: dict[str, int] = {}
    for domain in CORE_DOMAIN_DIRS:
        path = db_root / domain / "objects.json"
        try:
            if path.exists():
                counts[domain] = len(json.loads(path.read_text()))
        except (PermissionError, OSError, json.JSONDecodeError):
            continue
    pkg_root = db_root / "packages"
    try:
        if pkg_root.is_dir():
            total = 0
            for pkg_dir in sorted(pkg_root.iterdir()):
                json_path = pkg_dir / "objects.json"
                if pkg_dir.is_dir() and json_path.exists():
                    total += len(json.loads(json_path.read_text()))
            counts["packages"] = total
    except (PermissionError, OSError, json.JSONDecodeError):
        pass
    return counts


def _parse_timestamp(raw: str) -> datetime:
    """Parse an ISO-8601 timestamp, tolerating a trailing Z and naive input."""
    text = raw.strip()
    if text.endswith("Z"):
        text = text[:-1] + "+00:00"
    parsed = datetime.fromisoformat(text)
    if parsed.tzinfo is None:
        parsed = parsed.replace(tzinfo=timezone.utc)
    return parsed


def audit_db_age(db_root: str | Path, now: datetime | None = None) -> dict:
    """Report the extraction-log age and per-domain count drift vs. disk."""
    root = Path(db_root)
    log_path = root / "extraction-log.json"
    try:
        log = json.loads(log_path.read_text())
    except FileNotFoundError:
        return {
            "available": False,
            "reason": f"extraction-log.json not found at {log_path}",
        }
    except (PermissionError, OSError, json.JSONDecodeError) as exc:
        return {"available": False, "reason": f"could not read {log_path}: {exc}"}

    now = now or datetime.now(timezone.utc)
    raw_ts = log.get("extraction_timestamp") or ""
    try:
        extracted_at = _parse_timestamp(raw_ts)
        age_days = (now - extracted_at).total_seconds() / 86400.0
        age_out: float | None = round(age_days, 2)
        ts_out: str | None = extracted_at.isoformat()
        reason = None
    except (TypeError, ValueError) as exc:
        age_out = None
        ts_out = raw_ts or None
        reason = f"unparseable extraction_timestamp {raw_ts!r}: {exc}"

    logged = log.get("domain_counts") or {}
    live = _live_domain_counts(root)
    domains = sorted(set(logged) | set(live))
    comparison = {
        domain: {
            "logged": logged.get(domain),
            "live": live.get(domain),
            "matches": logged.get(domain) == live.get(domain),
        }
        for domain in domains
    }

    section = {
        "available": True,
        "log_path": str(log_path),
        "extraction_timestamp": ts_out,
        "age_days": age_out,
        "max_installation_path": log.get("max_installation_path"),
        "domain_counts": comparison,
        "domains_drifted": sorted(
            d for d, c in comparison.items() if not c["matches"]
        ),
    }
    if reason:
        section["reason"] = reason
    return section


# ---------------------------------------------------------------------------
# Envelope + summary
# ---------------------------------------------------------------------------


def _unavailable(reason: str) -> dict:
    return {"available": False, "reason": reason}


def run_audit(
    repo_root: str | Path | None = None,
    db_root: str | Path | None = None,
    max_app: str | Path | None = None,
    patch_source: str = "head",
) -> dict:
    """Run every audit section and return the full envelope.

    Every key in SECTION_KEYS is always present, so downstream consumers
    never KeyError. Sections that cannot be computed report
    ``{"available": false, "reason": ...}``.
    """
    root = Path(repo_root) if repo_root is not None else ROOT
    db = Path(db_root) if db_root is not None else root / ".claude" / "max-objects"
    app = Path(max_app) if max_app is not None else DEFAULT_MAX_APP

    sections: dict[str, dict] = {
        key: _unavailable("section not implemented") for key in SECTION_KEYS
    }
    sections["install"] = audit_install(app)
    sections["db_age"] = audit_db_age(db)

    return {
        "generated_at": datetime.now(timezone.utc).isoformat(),
        "repo_root": str(root.resolve()),
        "max_app": str(app),
        "patch_source": patch_source,
        "sections": sections,
    }


def _headline(section: dict, render) -> str:
    """Render a section's headline count, or its unavailable reason."""
    if section.get("available") is False:
        return f"unavailable ({section.get('reason', 'no reason given')})"
    try:
        return render(section)
    except (KeyError, TypeError, ValueError) as exc:  # defensive
        return f"unreportable ({exc})"


def format_summary(report: dict) -> str:
    """Render the ~10-line scannable text summary read before opening the JSON."""
    s = report["sections"]
    lines = [
        f"MAX object DB audit  ({report['generated_at']})",
        f"  repo root       : {report['repo_root']}",
        "  install         : "
        + _headline(
            s["install"],
            lambda x: f"Max {x.get('short_version')} "
            f"(build {x.get('build_id') or x.get('build_version')}), "
            f"{len(x.get('refpage_roots', []))} refpage roots",
        ),
        "  db age          : "
        + _headline(
            s["db_age"],
            lambda x: f"{x.get('age_days')} days (extracted {x.get('extraction_timestamp')}), "
            f"drifted domains: {', '.join(x['domains_drifted']) or 'none'}",
        ),
        "  missing from DB : "
        + _headline(s["missing_from_db"], lambda x: f"{x['count']} refpage names unresolved"),
        "  absent from Max : "
        + _headline(
            s["absent_from_bundle"], lambda x: f"{x['count']} DB names with no refpage"
        ),
        "  empty I/O       : "
        + _headline(
            s["empty_io"],
            lambda x: f"{x['critical_count']} critical, {x['sinks_count']} sinks, "
            f"{x['sources_count']} sources",
        ),
        "  patch objects   : "
        + _headline(
            s["patch_objects"],
            lambda x: f"{x['files_scanned']} .maxpat ({x['enumeration']}), "
            f"{len(x['objects_referenced'])} distinct objects, "
            f"{len(x['unresolved'])} unresolved",
        ),
        "  maxclass gap    : "
        + _headline(
            s["ui_maxclasses_gap"],
            lambda x: f"{x['count']} observed maxclasses outside UI_MAXCLASSES"
            + (f": {', '.join(x['gap'])}" if x["gap"] else ""),
        ),
    ]
    return "\n".join(lines)


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="audit_db.py",
        description=(
            "Read-only audit of .claude/max-objects/ against the installed "
            "Max bundle. Writes nothing except the optional --json target."
        ),
    )
    parser.add_argument(
        "--repo-root",
        default=None,
        help="Repository root (default: the repo this tool lives in).",
    )
    parser.add_argument(
        "--db-root",
        default=None,
        help="Object DB root (default: <repo-root>/.claude/max-objects).",
    )
    parser.add_argument(
        "--max-app",
        default=str(DEFAULT_MAX_APP),
        help="Installed Max application bundle (default: /Applications/Max.app).",
    )
    parser.add_argument(
        "--json",
        dest="json_path",
        default=None,
        help="Write the full JSON report here. Omit for the text summary only.",
    )
    parser.add_argument(
        "--patch-source",
        choices=("head", "worktree"),
        default="head",
        help="Read committed .maxpat content from git HEAD (default) or from disk.",
    )
    return parser


def main(argv: list[str] | None = None) -> int:
    args = build_parser().parse_args(argv)
    repo_root = Path(args.repo_root) if args.repo_root else ROOT

    # Screen the output path BEFORE doing any work, so a rejected target
    # costs nothing and can never be partially written.
    out_path: Path | None = None
    if args.json_path:
        try:
            out_path = guard_output_path(args.json_path, repo_root)
        except OutputPathRejected as exc:
            print(f"error: {exc}", file=sys.stderr)
            return 2

    report = run_audit(
        repo_root=repo_root,
        db_root=args.db_root,
        max_app=args.max_app,
        patch_source=args.patch_source,
    )

    if out_path is not None:
        out_path.parent.mkdir(parents=True, exist_ok=True)
        out_path.write_text(json.dumps(report, indent=2, sort_keys=False) + "\n")

    print(format_summary(report))
    if out_path is not None:
        print(f"  json            : {out_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
