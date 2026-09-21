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
import subprocess
import sys
import warnings
import xml.etree.ElementTree as ET
from datetime import datetime, timezone
from pathlib import Path

# Project root: this file is at tools/audit_db.py
ROOT = Path(__file__).resolve().parent.parent

# Allow `from src.maxpat.db_lookup import ObjectDatabase`
sys.path.insert(0, str(ROOT))

from src.maxpat.db_lookup import DOMAIN_LOAD_ORDER, ObjectDatabase  # noqa: E402
from src.maxpat.maxclass_map import UI_MAXCLASSES  # noqa: E402

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
# Refpage index (shared by missing_from_db / absent_from_bundle / empty_io)
# ---------------------------------------------------------------------------

_REFPAGE_SUFFIX = ".maxref.xml"


def build_refpage_index(install: dict) -> dict:
    """Index every installed *.maxref.xml by its authoritative object name.

    The object name is the root element's ``name`` attribute, falling back to
    the filename stem (with ``.maxref`` stripped) only when the attribute is
    absent or empty -- mirroring ``parse_standard_xml`` in
    ``.claude/scripts/extract_objects.py``. Keying on the filename instead
    manufactures ~795 phantom gaps (SF-07), so ``name_vs_filename_differs``
    is emitted as this harness's own self-check that it is keyed correctly.

    Per-file XML parse failures and per-root permission failures are tallied
    into ``parse_errors`` / ``unreadable_roots`` rather than aborting the walk
    (T-knq-03; TCC-blocked trees per SF-05).
    """
    if not install.get("available"):
        return {
            "available": False,
            "reason": install.get("reason", "Max bundle unavailable"),
            "objects": {},
        }

    objects: dict[str, dict] = {}
    parse_errors: list[dict] = []
    unreadable_roots: list[dict] = []
    files_scanned = 0
    name_differs = 0

    for root in (Path(p) for p in install.get("refpage_roots", [])):
        try:
            files = sorted(root.rglob("*" + _REFPAGE_SUFFIX))
        except (PermissionError, OSError) as exc:
            unreadable_roots.append({"root": str(root), "reason": str(exc)})
            continue
        for path in files:
            files_scanned += 1
            try:
                element = ET.parse(path).getroot()
            except ET.ParseError as exc:
                parse_errors.append({"file": str(path), "reason": f"parse error: {exc}"})
                continue
            except (PermissionError, OSError) as exc:
                parse_errors.append({"file": str(path), "reason": str(exc)})
                continue
            if element.tag != "c74object":
                continue
            stem = path.name[: -len(_REFPAGE_SUFFIX)]
            attr = (element.get("name") or "").strip()
            name = attr or stem
            if attr and attr != stem:
                name_differs += 1
            inletlist = element.find("inletlist")
            outletlist = element.find("outletlist")
            objects.setdefault(
                name,
                {
                    "file": str(path),
                    "filename_stem": stem,
                    "inlets": len(list(inletlist)) if inletlist is not None else None,
                    "outlets": len(list(outletlist)) if outletlist is not None else None,
                },
            )

    return {
        "available": True,
        "roots": [str(p) for p in install.get("refpage_roots", [])],
        "files_scanned": files_scanned,
        "object_count": len(objects),
        "name_vs_filename_differs": name_differs,
        "parse_errors": parse_errors,
        "unreadable_roots": unreadable_roots,
        "objects": objects,
    }


def _lookup_many(db: ObjectDatabase, names) -> dict[str, dict | None]:
    """Resolve names via ObjectDatabase.lookup(), muting the DB's advisory warnings.

    The audit reports empty-I/O and install-state facts structurally in the
    ``empty_io`` section, so the per-lookup UserWarnings would be duplicate
    noise on stderr across thousands of names.
    """
    with warnings.catch_warnings():
        warnings.simplefilter("ignore")
        return {name: db.lookup(name) for name in names}


# ---------------------------------------------------------------------------
# Section: missing_from_db
# ---------------------------------------------------------------------------


def audit_missing_from_db(refpages: dict, db: ObjectDatabase) -> dict:
    """Installed refpage object names that ObjectDatabase.lookup() cannot resolve.

    Against a matched bundle this is single-digit. A result in the hundreds
    means the name derivation regressed to filename keying (SF-07).
    """
    if not refpages.get("available"):
        return _unavailable(refpages.get("reason", "refpage index unavailable"))
    resolved = _lookup_many(db, refpages["objects"])
    names = sorted(n for n, obj in resolved.items() if obj is None)
    return {
        "available": True,
        "count": len(names),
        "names": names,
        "refpage_names_checked": len(resolved),
        "keyed_on": "c74object@name attribute (filename stem only as fallback)",
    }


# ---------------------------------------------------------------------------
# Section: absent_from_bundle
# ---------------------------------------------------------------------------


_ABSENT_SCOPE = (
    "Core domain files only (" + ", ".join(CORE_DOMAIN_DIRS) + "). The "
    "per-package dirs under packages/ are NOT walked: their upstream sources "
    "live in user package trees that are TCC-blocked (SF-05), so an absence "
    "there would not be evidence. This count is not full-DB coverage."
)


def audit_absent_from_bundle(db_root: str | Path, refpages: dict) -> dict:
    """Core-domain DB names with no corresponding refpage in the installed bundle."""
    if not refpages.get("available"):
        return _unavailable(refpages.get("reason", "refpage index unavailable"))
    root = Path(db_root)
    db_names: set[str] = set()
    read_errors: list[dict] = []
    for domain in CORE_DOMAIN_DIRS:
        path = root / domain / "objects.json"
        try:
            if path.exists():
                db_names.update(json.loads(path.read_text()))
        except (PermissionError, OSError, json.JSONDecodeError) as exc:
            read_errors.append({"file": str(path), "reason": str(exc)})
    absent = sorted(n for n in db_names if n not in refpages["objects"])
    return {
        "available": True,
        "count": len(absent),
        "names": absent,
        "db_names_checked": len(db_names),
        "scope": _ABSENT_SCOPE,
        "read_errors": read_errors,
    }


# ---------------------------------------------------------------------------
# Section: empty_io
# ---------------------------------------------------------------------------


def audit_empty_io_section(db: ObjectDatabase, refpages: dict) -> dict:
    """Empty-I/O DB health, annotated with installed-refpage availability.

    Delegates wholly to ObjectDatabase.audit_empty_io() and
    audit_half_empty_io() -- neither set is re-derived here. When the bundle
    is unavailable ``has_refpage`` is null, not false: an unreadable bundle is
    a measurement gap, not evidence of absence.
    """
    empty = db.audit_empty_io()
    half = db.audit_half_empty_io()
    known = bool(refpages.get("available"))
    index = refpages.get("objects", {})

    def annotate(names: list[str]) -> list[dict]:
        return [
            {"name": n, "has_refpage": (n in index) if known else None} for n in names
        ]

    return {
        "available": True,
        "critical": annotate(empty["critical"]),
        "critical_count": len(empty["critical"]),
        "covered_by_override": empty["covered_by_override"],
        "covered_by_override_count": len(empty["covered_by_override"]),
        "sinks": annotate(half["sinks"]),
        "sinks_count": len(half["sinks"]),
        "sources": annotate(half["sources"]),
        "sources_count": len(half["sources"]),
        "by_source": empty["by_source"],
        "refpage_coverage_known": known,
    }


# ---------------------------------------------------------------------------
# Section: patch_objects + ui_maxclasses_gap (one shared .maxpat walk)
# ---------------------------------------------------------------------------


_PATCH_LIMITATIONS = (
    "Message-box contents, attribute arguments, and objects created at "
    "runtime via scripting are not covered. Only box `text` first tokens "
    "(newobj) and `maxclass` values (every other box) are resolved."
)


def _git(root: Path, *args: str):
    """Run git as an argv list. The ONLY subprocess site in this tool (T-knq-02)."""
    return subprocess.run(["git", *args], cwd=str(root), capture_output=True, text=True, check=False)  # noqa: E501


def _walk_boxes(patcher: dict, depth: int, names: set[str], maxclasses: set[str]) -> None:
    """Collect object names + maxclasses, recursing into nested patchers under a depth cap."""
    if depth > MAX_PATCHER_DEPTH or not isinstance(patcher, dict):
        return
    boxes = patcher.get("boxes")
    if not isinstance(boxes, list):
        return
    for entry in boxes:
        if not isinstance(entry, dict):
            continue
        box = entry.get("box")
        if not isinstance(box, dict):
            continue
        maxclass = box.get("maxclass")
        if isinstance(maxclass, str) and maxclass:
            maxclasses.add(maxclass)
            if maxclass == "newobj":
                text = box.get("text")
                tokens = text.split() if isinstance(text, str) else []
                if tokens:
                    names.add(tokens[0])
            else:
                names.add(maxclass)
        _walk_boxes(box.get("patcher"), depth + 1, names, maxclasses)


def _enumerate_patch_files(root: Path, patch_source: str) -> tuple[list[tuple[str, str, str]], str]:
    """Yield (relative_path, content, source) per .maxpat, plus the enumeration mode."""
    listing = _git(root, "ls-files", "--", "*.maxpat")
    if listing.returncode != 0:
        found = sorted(root.glob("patches/**/*.maxpat"))
        results = []
        for path in found:
            try:
                results.append((str(path.relative_to(root)), path.read_text(), "worktree"))
            except (PermissionError, OSError, UnicodeDecodeError):
                continue
        return results, "filesystem"

    results = []
    for rel in sorted(filter(None, (ln.strip() for ln in listing.stdout.splitlines()))):
        if patch_source == "head":
            blob = _git(root, "show", f"HEAD:{rel}")
            if blob.returncode == 0:
                results.append((rel, blob.stdout, "head"))
                continue
            # Blob absent at HEAD (newly added file) -- fall back to disk.
        try:
            results.append((rel, (root / rel).read_text(), "worktree"))
        except (PermissionError, OSError, UnicodeDecodeError):
            continue
    return results, "git"


def collect_patch_usage(repo_root: str | Path, patch_source: str = "head") -> dict:
    """Walk committed .maxpat files, collecting object names and maxclasses per file."""
    root = Path(repo_root)
    try:
        files, enumeration = _enumerate_patch_files(root, patch_source)
    except (FileNotFoundError, PermissionError, OSError) as exc:
        return {"available": False, "reason": f"could not enumerate .maxpat files: {exc}"}

    name_to_files: dict[str, set[str]] = {}
    maxclass_to_files: dict[str, set[str]] = {}
    maxclass_tally: dict[str, int] = {}
    read_errors: list[dict] = []
    sources_used: dict[str, int] = {}
    files_scanned = 0

    for rel, content, source in files:
        try:
            data = json.loads(content)
        except (json.JSONDecodeError, TypeError) as exc:
            read_errors.append({"file": rel, "reason": f"invalid JSON: {exc}"})
            continue
        if not isinstance(data, dict):
            read_errors.append({"file": rel, "reason": "top level is not an object"})
            continue
        files_scanned += 1
        sources_used[source] = sources_used.get(source, 0) + 1
        names: set[str] = set()
        maxclasses: set[str] = set()
        _walk_boxes(data.get("patcher"), 0, names, maxclasses)
        for name in names:
            name_to_files.setdefault(name, set()).add(rel)
        for maxclass in maxclasses:
            maxclass_tally[maxclass] = maxclass_tally.get(maxclass, 0) + 1
            maxclass_to_files.setdefault(maxclass, set()).add(rel)

    return {
        "available": True,
        "files_scanned": files_scanned,
        "enumeration": enumeration,
        "content_sources": sources_used,
        "read_errors": read_errors,
        "patch_files": sorted(rel for rel, _c, _s in files),
        "name_to_files": {n: sorted(f) for n, f in name_to_files.items()},
        "maxclass_tally": dict(sorted(maxclass_tally.items())),
        "maxclass_to_files": {m: sorted(f) for m, f in maxclass_to_files.items()},
    }


def _same_project(a: str, b: str) -> bool:
    """True when two repo-relative .maxpat paths share a MAX abstraction search scope.

    MAX resolves an abstraction by filename from the patch's own folder and
    the enclosing project. Same directory always qualifies; so does any two
    paths under the same ``patches/<project>/`` tree.
    """
    pa, pb = Path(a), Path(b)
    if pa.parent == pb.parent:
        return True
    partsa, partsb = pa.parts, pb.parts
    return (
        len(partsa) > 1
        and len(partsb) > 1
        and partsa[0] == partsb[0] == "patches"
        and partsa[1] == partsb[1]
    )


def _resolve_local_abstraction(name: str, referencing: list[str], patch_files: list[str]) -> list[str] | None:
    """Return the sibling .maxpat paths that define ``name`` as an abstraction.

    A newobj whose first token names a sibling ``<name>.maxpat`` is an
    abstraction instance, not an unknown object -- the DB legitimately has no
    entry for it. Returns None unless EVERY referencing file has an in-scope
    definition, so a genuinely-unknown name cannot be masked by an unrelated
    same-named patch elsewhere in the repo.
    """
    candidates = [p for p in patch_files if Path(p).stem == name]
    if not candidates:
        return None
    resolving: set[str] = set()
    for ref in referencing:
        matches = [c for c in candidates if c != ref and _same_project(c, ref)]
        if not matches:
            return None
        resolving.update(matches)
    return sorted(resolving)


def audit_patch_objects(usage: dict, db: ObjectDatabase) -> dict:
    """Resolve every object referenced by a committed .maxpat against the DB."""
    if not usage.get("available"):
        return _unavailable(usage.get("reason", "patch walk unavailable"))
    name_to_files = usage["name_to_files"]
    patch_files = usage.get("patch_files", [])
    resolved = _lookup_many(db, name_to_files)

    unresolved = []
    empty_io_hits = []
    local_abstractions = []
    for name in sorted(name_to_files):
        obj = resolved[name]
        files = name_to_files[name]
        if obj is None:
            defined_by = _resolve_local_abstraction(name, files, patch_files)
            if defined_by is not None:
                local_abstractions.append(
                    {"name": name, "files": files, "defined_by": defined_by}
                )
            else:
                unresolved.append({"name": name, "files": files})
        elif not obj.get("inlets") and not obj.get("outlets"):
            empty_io_hits.append({"name": name, "files": files})

    return {
        "available": True,
        "files_scanned": usage["files_scanned"],
        "enumeration": usage["enumeration"],
        "content_sources": usage["content_sources"],
        "objects_referenced": sorted(name_to_files),
        "unresolved": unresolved,
        "local_abstractions": local_abstractions,
        "empty_io_hits": empty_io_hits,
        "read_errors": usage["read_errors"],
        "limitations": _PATCH_LIMITATIONS,
    }


def audit_ui_maxclasses_gap(usage: dict) -> dict:
    """Observed .maxpat maxclasses that UI_MAXCLASSES does not admit.

    ``newobj`` is subtracted as a structural value (it is the generic text-box
    class, not a UI widget). On a healthy tree the residual is empty, so any
    entry here is a real finding rather than noise.
    """
    if not usage.get("available"):
        return _unavailable(usage.get("reason", "patch walk unavailable"))
    tally = usage["maxclass_tally"]
    per_file = usage.get("maxclass_to_files", {})
    gap = sorted(set(tally) - set(UI_MAXCLASSES) - {"newobj"})
    return {
        "available": True,
        "count": len(gap),
        "gap": gap,
        "gap_files": {m: per_file.get(m, []) for m in gap},
        "observed_maxclasses": tally,
        "ui_maxclasses_size": len(UI_MAXCLASSES),
        "structural_exemptions": ["newobj"],
    }


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
        key: _unavailable("section not computed") for key in SECTION_KEYS
    }
    sections["install"] = audit_install(app)
    sections["db_age"] = audit_db_age(db)

    refpages = build_refpage_index(sections["install"])

    try:
        database: ObjectDatabase | None = ObjectDatabase(db_root=db)
        db_reason = None
    except Exception as exc:  # noqa: BLE001 -- any load failure degrades, never raises
        database = None
        db_reason = f"could not load object database at {db}: {exc}"

    if database is not None:
        sections["missing_from_db"] = audit_missing_from_db(refpages, database)
        sections["absent_from_bundle"] = audit_absent_from_bundle(db, refpages)
        sections["empty_io"] = audit_empty_io_section(database, refpages)
    else:
        for key in ("missing_from_db", "absent_from_bundle", "empty_io"):
            sections[key] = _unavailable(db_reason)

    usage = collect_patch_usage(root, patch_source)
    sections["patch_objects"] = (
        audit_patch_objects(usage, database) if database is not None
        else _unavailable(db_reason)
    )
    sections["ui_maxclasses_gap"] = audit_ui_maxclasses_gap(usage)

    # Index payload is large and redundant with the sections above; keep only
    # its provenance + self-check counters in the emitted document.
    refpage_meta = {k: v for k, v in refpages.items() if k != "objects"}

    return {
        "refpage_index": refpage_meta,
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
        "  refpages        : "
        + _headline(
            report.get("refpage_index", {}),
            lambda x: f"{x['object_count']} objects from {x['files_scanned']} files, "
            f"{x['name_vs_filename_differs']} name!=filename, "
            f"{len(x['parse_errors'])} parse errors",
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
            f"{len(x['unresolved'])} unresolved, "
            f"{len(x['local_abstractions'])} local abstractions",
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
