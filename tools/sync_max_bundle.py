#!/usr/bin/env python3
"""Report and apply the difference between the installed Max bundle and the object DB.

Provenance: quick-261001-hwb (Max 9.2.0 update). Companion to the read-only
``tools/audit_db.py``: the audit answers "is the DB still true?", this tool
closes the gap it finds.

What this is, and is not
------------------------
* A JSON data tool. It edits ``.claude/max-objects/`` object files; it never
  generates or regenerates a ``.maxpat`` (CLAUDE.md Rule #5 forbids only
  that).
* Additive only. A pre-existing DB entry never loses or changes a field:
  ``messages`` may only grow (old list kept as a prefix), ``attributes`` may
  only gain keys, and inlets / outlets / every other field are untouched.
  :func:`check_additive` enforces this before every write.
* It never executes the Max binary and spawns no subprocess. The installed
  version comes from ``Info.plist`` via ``audit_install`` (plistlib).
* ``overrides.json`` is read only through ``ObjectDatabase``. The tool has no
  write path to it: :func:`write_db_file` -- the single function that writes
  into the DB tree -- accepts only the core domain object files, the
  per-package object files and ``package_info.json``. The only other writers
  into the DB tree are :func:`write_groups_file` (``--apply groups``), which
  can only write ``<db-root>/groups.json``, :func:`write_aliases_file`
  (``--apply aliases``), which can only add to ``<db-root>/aliases.json``,
  :func:`write_idioms_file` (``--apply idioms``, Q38), which can only
  additively write ``<db-root>/idioms.json``, and
  :func:`write_version_io_file` (``--apply version-io``, Q38), which can only
  write ``<db-root>/version_io.json``.
  The other write sites
  are :func:`write_report` (``--json`` / ``--snapshot-io`` targets), which
  refuses any path inside ``patches/`` or the DB tree, and
  :func:`write_extraction_log` (``--refresh-log``), which can only replace
  ``<db-root>/extraction-log.json``.
* Atomic and mode-preserving (Q30 / I6). Every DB-tree writer goes through
  ``src/maxpat/atomic_io.py``: a temp file beside the target, fsync, the
  target's existing mode (a new file gets the umask default), then
  ``os.replace``. A multi-file apply (``--apply new / define / deltas /
  inherited``) is one transaction: :func:`write_db_files` prepares and checks
  every file (package_info.json counts included) before writing any, then
  replaces all of them or, if a replace fails, restores the ones already
  replaced.
* Versions are strings (Q30 / I6): the installed major.minor (``"9.2"``,
  ``"9.10"``) and ``--min-version`` land as ``min_version`` strings; a float
  would turn 9.10 into 9.1. The DB's existing numeric values are untouched.
* It never writes ``src/maxpat/maxclass_map.py`` or ``src/maxpat/sizing.py``;
  the ``ui_maxclasses`` section only reports against them.

Sources of shape
----------------
* Names: the refpage ``<c74object name>`` attribute, never the filename --
  except for define-mapped objects (``max define ALIAS TARGET ARGS;`` lines in
  the bundle's ``*objectmappings*.txt``), whose refpage name attribute can be
  the implementing class (``v8``) or a typo. For those the alias is the name
  and the refpage is never merged into the object its name attribute points at.
  The deltas pass diffs such an alias document against the alias's own entry
  (keyed by the filename stem) and skips an alias the DB lacks or one whose
  lookup lands on any other entry (quick-261118-j2w).
* I/O counts: refpage, cross-checked against the help-patch box Max itself
  serialized. A disagreement aborts that object.
* Outlet types: the help-patch box ``outlettype``.
* Inherited attributes: Jitter object refpages name their shared (OB3D / MOP)
  attributes in a names-only ``<jitterattributelist>``; the definition lives
  in a group page (``jit.group-gl.maxref.xml``), which is a documentation
  page with no DB entry. The DB does not record inherited attributes as a
  rule, so these are report-only and land only for attribute names given
  explicitly to ``--apply inherited --attributes``.
* Inherited group membership (review C8 / Q14): the per-object refpage
  lists -- ``<mcwrapper>`` for MC wrappers, ``<jittermethodlist>`` /
  ``<jitterattributelist>`` for Jitter objects -- never a name prefix (51
  ``mc.*`` objects are native, not wrappers). thispatcher's selectors come
  from its help patch. ``--apply groups`` records them in ``groups.json``
  (each group once, merged at call time by ``ObjectDatabase``); attribute
  types come only from non-ambiguous group-page definitions.
* objectfile aliases (Q30 / I6): every ``max objectfile NAME FILE [CLASS];``
  line in every bundle init file (not only ``*objectmappings*``). Section
  ``objectfile_aliases`` lists each name the DB cannot resolve with a
  proposed alias target, how it was derived (``basis``) and help-box
  evidence; names that resolve only to RNBO / Gen entries are listed apart
  (``domain_shadowed``). ``--apply aliases --names`` adds named, verified
  aliases to ``aliases.json`` through :func:`write_aliases_file`, its only
  writer (additive, style- and mode-preserving, rolled back if the DB then
  fails to load or resolve them).
* Shipped idioms (Q38): every cord a bundle ``*.maxhelp`` ships between two
  idiom-eligible boxes, keyed (source, outlet, source-outlet signal class,
  destination, inlet) by ``tools/help_io.scan_help_idioms``. Section
  ``idioms``; ``--apply idioms`` writes ``idioms.json`` (additive, canonical).
  Validation Layer 3 never type/role-checks a listed cord; bounds always.
* Per-version I/O (Q38): bundle help boxes whose saving Max versions
  (``appversion``) disagree on (numinlets, numoutlets) for the same name and
  arguments, recorded only for a strict version-ordered partition
  (``tools/help_io.scan_version_io``). Section ``version_io``;
  ``--apply version-io`` regenerates ``version_io.json`` wholesale (mined
  evidence, not curation -- the dry-run's +/-/~ counts are the review step).
* UI maxclasses: every box maxclass the bundle's .maxpat/.maxhelp files carry
  (section ``ui_maxclasses``, review C5 / Q13), diffed against UI_MAXCLASSES;
  report-only.

The refpage parser is the repo's one parser, ``parse_standard_xml`` in
``.claude/scripts/extract_objects.py``, loaded by file path -- not a copy.

Usage
-----
    python3 tools/sync_max_bundle.py                         # dry-run report
    python3 tools/sync_max_bundle.py --json /tmp/sync.json   # + full JSON
    python3 tools/sync_max_bundle.py --apply new --names dspstress~ jit.web
    python3 tools/sync_max_bundle.py --apply define --names jit.gl.web jit.gl.tex2mat
    python3 tools/sync_max_bundle.py --apply define --names OLD.ALIAS --min-version 8
    python3 tools/sync_max_bundle.py --apply deltas
    python3 tools/sync_max_bundle.py --apply inherited --attributes alpha_mode
    python3 tools/sync_max_bundle.py --apply groups
    python3 tools/sync_max_bundle.py --apply aliases --names hslider mc.times~
    python3 tools/sync_max_bundle.py --apply aliases --shadowed --names list.len
    python3 tools/sync_max_bundle.py --apply idioms
    python3 tools/sync_max_bundle.py --apply version-io
    python3 tools/sync_max_bundle.py --refresh-log           # after an apply
    python3 tools/sync_max_bundle.py --snapshot-io /tmp/io.json
    python3 tools/sync_max_bundle.py --compare-io /tmp/io.json

Exit codes: 0 for a completed run (dry-run and unavailable bundle included);
1 when a requested apply could not land everything asked for (a named object
aborted, or the bundle was unavailable) or ``--compare-io`` found a change;
2 for a write-guard refusal, an additive-check violation, an unreproducible
file style, or a rejected report path.
"""

from __future__ import annotations

import argparse
import copy
import datetime as _dt
import hashlib
import importlib.util
import json
import re
import statistics
import sys
import warnings
import xml.etree.ElementTree as ET
from pathlib import Path

# Project root: this file is at tools/sync_max_bundle.py
ROOT = Path(__file__).resolve().parent.parent

# Allow `from src.maxpat...` / `from tools.audit_db ...`
sys.path.insert(0, str(ROOT))

from src.maxpat.atomic_io import atomic_write_bytes, atomic_write_many, json_style  # noqa: E402
from src.maxpat.db_lookup import ObjectDatabase  # noqa: E402
from src.maxpat.maxclass_map import UI_MAXCLASSES  # noqa: E402
from tools import help_io  # noqa: E402
from tools.audit_db import (  # noqa: E402
    CORE_DOMAIN_DIRS,
    CORE_REFPAGE_DIRS,
    DEFAULT_MAX_APP,
    OutputPathRejected,
    _live_domain_counts,
    audit_install,
    guard_output_path,
)

EXTRACTOR_PATH = ROOT / ".claude" / "scripts" / "extract_objects.py"
DEFAULT_DB_ROOT = ROOT / ".claude" / "max-objects"

_REFPAGE_SUFFIX = ".maxref.xml"
_HELP_SUFFIX = ".maxhelp"

# (module_hint, domain_hint) per core refpage directory, as extract_objects.py
# passes them to parse_standard_xml.
CORE_ROOT_HINTS = {
    "max-ref": ("max", "Max"),
    "msp-ref": ("msp", "MSP"),
    "jit-ref": ("jit", "Jitter"),
    "m4l-ref": ("m4l", "M4L"),
}
PACKAGE_HINTS = ("max", "Packages")

# Gen and RNBO ship prefix-keyed refpages with their own parsers; audit_db.py
# covers them and reports none missing.
SKIPPED_PACKAGES = frozenset({"Gen", "RNBO"})

# Entry `domain` value -> core domain directory this tool may write.
DOMAIN_TO_DIR = {"Max": "max", "MSP": "msp", "Jitter": "jitter", "MC": "mc", "M4L": "m4l"}
WRITABLE_CORE_DIRS = tuple(DOMAIN_TO_DIR.values())
# Read (never written) so the I/O snapshot covers every name in the DB.
READ_ONLY_CORE_DIRS = ("gen", "rnbo")

# Unfilled Cycling '74 refpage template placeholders (CLAUDE.md, Object
# Database section). The first three are matched as substrings; "undefined"
# and "Dummy" only as the whole value, since both are ordinary words.
_SUBSTRING_TOKENS = ("TEXT_HERE", "INLET_TYPE", "OUTLET_TYPE", "OBJARG_NAME", "OBJARG_TYPE")
_WHOLE_VALUE_TOKENS = ("undefined", "Dummy")

# Bound on recursion into nested patchers when walking help patches (T-hwb-06).
MAX_PATCHER_DEPTH = 32

APPLY_MODES = (
    "new", "define", "deltas", "inherited", "groups", "aliases", "idioms", "version-io",
)

SECTION_KEYS = [
    "install",
    "new_objects",
    "define_missing",
    "objectfile_aliases",
    "deltas",
    "inherited_attributes",
    "groups",
    "idioms",
    "version_io",
    "collisions",
    "alias_docs",
    "shadowed_by_override",
    "ui_maxclasses",
]


class WriteRefused(Exception):
    """A write target is outside the DB allow-list (T-hwb-01)."""


class StyleUnreproducible(Exception):
    """No known serialization style reproduces a DB file's bytes."""


class AdditiveViolation(Exception):
    """A write would change or remove data on a pre-existing entry (T-hwb-02)."""


class AliasVerificationFailed(Exception):
    """aliases.json was restored: after the write the DB did not load or resolve (Q30 PD-6)."""


# ---------------------------------------------------------------------------
# Reused refpage parser
# ---------------------------------------------------------------------------

_EXTRACTOR = None


def extractor():
    """Load .claude/scripts/extract_objects.py by path (it is not a package)."""
    global _EXTRACTOR
    if _EXTRACTOR is None:
        spec = importlib.util.spec_from_file_location("_sync_extract_objects", EXTRACTOR_PATH)
        module = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(module)
        _EXTRACTOR = module
    return _EXTRACTOR


def parse_refpage(ref: dict) -> dict | None:
    """Run the repo's parse_standard_xml on one indexed refpage file."""
    return extractor().parse_standard_xml(
        Path(ref["file"]), ref["module_hint"], ref["domain_hint"]
    )


# ---------------------------------------------------------------------------
# Bundle index
# ---------------------------------------------------------------------------


def _major_minor(short_version: str | None) -> str | None:
    """'9.2.0' -> '9.2', '9.10.0' -> '9.10' (C5; Q30 PD-3). None when unusable.

    A string, never a float: 9.10 as a float is 9.1. Each part goes through
    int(), so '09.2' -> '9.2'; a '.0' minor is kept ('9.0.0' -> '9.0').
    """
    if not short_version:
        return None
    match = re.match(r"^(\d+)\.(\d+)", short_version)
    if not match:
        return None
    return f"{int(match.group(1))}.{int(match.group(2))}"


# Q30 PD-2: alias and target exclude `;`, so an argument-less line
# (`max define A B;`) yields target "B", not "B;".
_DEFINE_RE = re.compile(r"^\s*max\s+define\s+([^\s;]+)\s+([^\s;]+)\s*(.*?)\s*;?\s*$")


def parse_define_mappings(c74: Path) -> dict[str, dict]:
    """Collect every `max define ALIAS TARGET ARGS;` line, keyed by alias."""
    defines: dict[str, dict] = {}
    files: list[tuple[Path, str | None]] = []
    try:
        files.extend((p, None) for p in sorted((c74 / "init").glob("*objectmappings*.txt")))
        files.extend(
            (p, p.parent.parent.name)
            for p in sorted(c74.glob("packages/*/init/*objectmappings*.txt"))
        )
    except (PermissionError, OSError):
        return defines
    for path, package in files:
        try:
            text = path.read_text(errors="replace")
        except (PermissionError, OSError):
            continue
        for line in text.splitlines():
            match = _DEFINE_RE.match(line)
            if not match:
                continue
            alias, target, args = match.group(1), match.group(2), match.group(3)
            defines.setdefault(
                alias,
                {
                    "alias": alias,
                    "target": target,
                    "args": args,
                    "package": package,
                    "mapping_file": str(path),
                    "line": line.strip(),
                },
            )
    return defines


# Q30 PD-6: `max objectfile NAME FILE [CLASS ARGS...];` -- the name Max
# instantiates by loading FILE (an external, an abstraction or a wrapper).
_OBJECTFILE_RE = re.compile(r"^\s*max\s+objectfile\s+([^\s;]+)\s+([^\s;]+)\s*(.*?)\s*;?\s*$")


def parse_objectfile_mappings(c74: Path) -> dict:
    """Every `max objectfile` line in the bundle's init files (Q30 PD-6).

    Reads every ``init/*.txt`` and ``packages/*/init/*.txt`` (Max runs every
    init file, not only the ``*objectmappings*`` ones). Returns
    ``{"records": {name: {name, file, class, args, package, mapping_file,
    line}}, "lines": int, "files": [paths holding a line], "duplicates":
    [names]}``. ``class`` is the first token after the file (None when
    absent), ``args`` the rest. The first line for a name wins; later lines
    for it are listed in ``duplicates``.
    """
    result: dict = {"records": {}, "lines": 0, "files": [], "duplicates": []}
    paths: list[tuple[Path, str | None]] = []
    try:
        paths.extend((p, None) for p in sorted((c74 / "init").glob("*.txt")))
        paths.extend(
            (p, p.parent.parent.name) for p in sorted(c74.glob("packages/*/init/*.txt"))
        )
    except (PermissionError, OSError):
        return result
    records = result["records"]
    for path, package in paths:
        try:
            text = path.read_text(errors="replace")
        except (PermissionError, OSError):
            continue
        seen_line = False
        for line in text.splitlines():
            match = _OBJECTFILE_RE.match(line)
            if not match:
                continue
            seen_line = True
            result["lines"] += 1
            name, file_, rest = match.group(1), match.group(2), match.group(3)
            tokens = rest.split()
            if name in records:
                if name not in result["duplicates"]:
                    result["duplicates"].append(name)
                continue
            records[name] = {
                "name": name,
                "file": file_,
                "class": tokens[0] if tokens else None,
                "args": " ".join(tokens[1:]),
                "package": package,
                "mapping_file": str(path),
                "line": line.strip(),
            }
        if seen_line:
            result["files"].append(str(path))
    return result


def _scan_refpage_file(path: Path, root_kind: str, package: str | None, hints) -> dict | None:
    """Index one refpage. Returns None for non-object XML; raises on parse error."""
    element = ET.parse(path).getroot()
    if element.tag != "c74object":
        return None
    stem = path.name[: -len(_REFPAGE_SUFFIX)]
    attr = (element.get("name") or "").strip()
    inletlist = element.find("inletlist")
    outletlist = element.find("outletlist")
    methodlist = element.find("methodlist")
    return {
        "file": str(path),
        "stem": stem,
        "name": attr or stem,
        "name_attribute": attr,
        "root": root_kind,
        "package": package,
        "module_hint": hints[0],
        "domain_hint": hints[1],
        "inlets": len(inletlist.findall("inlet")) if inletlist is not None else None,
        "outlets": len(outletlist.findall("outlet")) if outletlist is not None else None,
        "inlet_types": (
            [el.get("type") for el in inletlist.findall("inlet")]
            if inletlist is not None
            else None
        ),
        "methods": (
            [m.get("name", "") for m in methodlist.findall("method")]
            if methodlist is not None
            else None
        ),
        # Names-only references to attributes a group page defines.
        "inherited_attributes": [
            a.get("name", "")
            for a in element.findall("jitterattributelist/jitterattribute")
            if a.get("name")
        ],
        # Names-only references to inherited group messages / attributes
        # (review C8 / Q14): the MC wrapper and shared Jitter method lists.
        "mcwrapper_methods": [
            m.get("name", "")
            for m in element.findall("mcwrapper/mcwrappermethod")
            if m.get("name")
        ],
        "mcwrapper_attributes": [
            a.get("name", "")
            for a in element.findall("mcwrapper/mcwrapperattr")
            if a.get("name")
        ],
        "jitter_methods": [
            m.get("name", "")
            for m in element.findall("jittermethodlist/jittermethod")
            if m.get("name")
        ],
        "class": "normal",
    }


def package_docs_dirs(c74: Path) -> list[tuple[Path, str]]:
    """(docs directory, package name) for every bundled package this tool walks.

    Flat docs/ (ableton-dsp, jit.mo, Jitter Geometry, Jitter Tools),
    docs/refpages/ (VIDDLL, Node for Max) and nested groups such as Jitter
    Tools' docs/jit.fx/ are all reached by one recursive walk from docs/.
    Gen and RNBO are skipped (SKIPPED_PACKAGES). Shared with
    ``tools/audit_db.py`` so both tools see the same package refpages.
    """
    packages = c74 / "packages"
    try:
        package_dirs = sorted(p for p in packages.iterdir() if p.is_dir())
    except (FileNotFoundError, PermissionError, OSError):
        return []
    found: list[tuple[Path, str]] = []
    for pkg in package_dirs:
        if pkg.name in SKIPPED_PACKAGES:
            continue
        docs = pkg / "docs"
        try:
            if docs.is_dir():
                found.append((docs, pkg.name))
        except (PermissionError, OSError):
            continue
    return found


def scan_refpages(c74: Path) -> tuple[list[dict], list[dict]]:
    """Index every walked refpage file. Parse failures are tallied, never fatal."""
    refs: list[dict] = []
    errors: list[dict] = []

    def scan_dir(directory: Path, root_kind: str, package: str | None, hints) -> None:
        try:
            files = sorted(directory.rglob("*" + _REFPAGE_SUFFIX))
        except (PermissionError, OSError) as exc:
            errors.append({"file": str(directory), "reason": str(exc)})
            return
        for path in files:
            try:
                ref = _scan_refpage_file(path, root_kind, package, hints)
            except ET.ParseError as exc:
                errors.append({"file": str(path), "reason": f"parse error: {exc}"})
                continue
            except (PermissionError, OSError) as exc:
                errors.append({"file": str(path), "reason": str(exc)})
                continue
            if ref is not None:
                refs.append(ref)

    for rel in CORE_REFPAGE_DIRS:
        directory = c74 / rel
        if directory.is_dir():
            scan_dir(directory, "core", None, CORE_ROOT_HINTS.get(directory.name, ("max", "Max")))

    for docs, package in package_docs_dirs(c74):
        scan_dir(docs, "package", package, PACKAGE_HINTS)
    return refs, errors


def build_help_index(c74: Path) -> dict[str, list[str]]:
    """Index every bundled .maxhelp by filename stem (core help + package help)."""
    index: dict[str, list[str]] = {}
    roots = [c74 / "help"]
    try:
        roots.extend(sorted(c74.glob("packages/*/help")))
    except (PermissionError, OSError):
        pass
    for root in roots:
        try:
            if not root.is_dir():
                continue
            files = sorted(root.rglob("*" + _HELP_SUFFIX))
        except (PermissionError, OSError):
            continue
        for path in files:
            index.setdefault(path.name[: -len(_HELP_SUFFIX)], []).append(str(path))
    return index


def _walk_help_boxes(patcher, name: str, found: list[dict], ui: list[dict], depth: int) -> None:
    if depth > MAX_PATCHER_DEPTH or not isinstance(patcher, dict):
        return
    boxes = patcher.get("boxes")
    if not isinstance(boxes, list):
        return
    for entry in boxes:
        box = entry.get("box") if isinstance(entry, dict) else None
        if not isinstance(box, dict):
            continue
        text = (box.get("text") or "").strip() if isinstance(box.get("text"), str) else ""
        record = {
            "numinlets": int(box.get("numinlets") or 0),
            "numoutlets": int(box.get("numoutlets") or 0),
            "outlettype": list(box.get("outlettype") or []),
            "text": text,
        }
        if box.get("maxclass") == "newobj" and text and text.split()[0] == name:
            found.append(record)
        elif box.get("maxclass") == name:
            ui.append(record)
        _walk_help_boxes(box.get("patcher"), name, found, ui, depth + 1)


def find_help_boxes(index: dict, name: str, extra_stems: tuple[str, ...] = ()) -> dict:
    """newobj boxes whose first text token is `name`, from the bundle's help patches.

    Searches the help file named after the object first, then the help files
    named in `extra_stems` (a define target), stopping at the first stem that
    yields a box.
    """
    errors: list[dict] = []
    for stem in (name, *extra_stems):
        boxes: list[dict] = []
        ui_boxes: list[dict] = []
        files = index["help"].get(stem, [])
        for path in files:
            try:
                data = json.loads(Path(path).read_text())
            except (PermissionError, OSError, ValueError) as exc:
                errors.append({"file": path, "reason": str(exc)})
                continue
            _walk_help_boxes(data.get("patcher") if isinstance(data, dict) else None, name, boxes, ui_boxes, 0)
        if boxes or ui_boxes:
            return {
                "help_stem": stem,
                "files": files,
                "boxes": boxes,
                "ui_boxes": ui_boxes,
                "errors": errors,
            }
    return {"help_stem": None, "files": [], "boxes": [], "ui_boxes": [], "errors": errors}


# ---------------------------------------------------------------------------
# UI maxclass survey (review C5, Q13) -- report-only
# ---------------------------------------------------------------------------


def _survey_boxes(patcher, depth: int, rel: str, observed: dict, newobj: dict) -> None:
    if depth > MAX_PATCHER_DEPTH or not isinstance(patcher, dict):
        return
    boxes = patcher.get("boxes")
    if not isinstance(boxes, list):
        return
    for entry in boxes:
        box = entry.get("box") if isinstance(entry, dict) else None
        if not isinstance(box, dict):
            continue
        maxclass = box.get("maxclass")
        text = box.get("text")
        has_text = isinstance(text, str) and bool(text.strip())
        if maxclass == "newobj":
            if has_text:
                token = text.split()[0]
                newobj[token] = newobj.get(token, 0) + 1
        elif isinstance(maxclass, str) and maxclass:
            rec = observed.setdefault(maxclass, {
                "boxes": 0, "files": set(), "top_level_boxes": 0,
                "text_boxes": 0, "widths": [], "heights": [], "example": rel,
            })
            rec["boxes"] += 1
            rec["files"].add(rel)
            if depth == 0:
                rec["top_level_boxes"] += 1
            if has_text:
                rec["text_boxes"] += 1
            rect = box.get("patching_rect")
            if (
                isinstance(rect, list) and len(rect) == 4
                and all(isinstance(v, (int, float)) and not isinstance(v, bool) for v in rect)
            ):
                rec["widths"].append(float(rect[2]))
                rec["heights"].append(float(rect[3]))
        _survey_boxes(box.get("patcher"), depth + 1, rel, observed, newobj)


def survey_maxclasses(c74: Path) -> dict:
    """Every box maxclass (and newobj first token) in the bundle's patches.

    Walks all .maxpat/.maxhelp files under *c74* at any patcher depth (bounded
    by MAX_PATCHER_DEPTH). Read-only.
    """
    c74 = Path(c74)
    try:
        files = sorted(
            p for p in c74.rglob("*") if p.suffix in (".maxpat", ".maxhelp") and p.is_file()
        )
    except (PermissionError, OSError):
        files = []
    observed: dict[str, dict] = {}
    newobj: dict[str, int] = {}
    read_errors: list[dict] = []
    scanned = 0
    for path in files:
        rel = path.relative_to(c74).as_posix()
        try:
            data = json.loads(path.read_text(encoding="utf-8"))
        except (OSError, ValueError) as exc:
            read_errors.append({"file": rel, "reason": str(exc)})
            continue
        scanned += 1
        if not isinstance(data, dict):
            continue
        _survey_boxes(data.get("patcher"), 0, rel, observed, newobj)
    out: dict[str, dict] = {}
    for mc in sorted(observed):
        rec = observed[mc]
        median = None
        if rec["widths"]:
            median = [
                round(statistics.median(rec["widths"]), 1),
                round(statistics.median(rec["heights"]), 1),
            ]
        out[mc] = {
            "boxes": rec["boxes"],
            "files": len(rec["files"]),
            "top_level_boxes": rec["top_level_boxes"],
            "text_boxes": rec["text_boxes"],
            "median_size": median,
            "example": rec["example"],
        }
    return {
        "files_scanned": scanned,
        "read_errors": read_errors,
        "observed": out,
        "newobj": dict(sorted(newobj.items())),
    }


def section_ui_maxclasses(survey: dict, ui_set=UI_MAXCLASSES) -> dict:
    """Diff the bundle maxclass survey against UI_MAXCLASSES (report-only)."""
    observed = survey["observed"]
    newobj = survey["newobj"]
    missing = sorted(set(observed) - set(ui_set))
    newobj_only = sorted(n for n in ui_set if n not in observed and newobj.get(n, 0) >= 1)
    unobserved = sorted(n for n in ui_set if n not in observed and newobj.get(n, 0) < 1)
    both = sorted(n for n in observed if newobj.get(n, 0) >= 1)
    evidence = {
        n: {**observed[n], "newobj_boxes": newobj.get(n, 0)}
        for n in sorted(set(missing) | set(both))
    }
    return {
        "available": True,
        "files_scanned": survey["files_scanned"],
        "read_errors": survey["read_errors"],
        "ui_set_size": len(ui_set),
        "survey_set": sorted(observed),
        "missing_from_ui_set": missing,
        "newobj_only_in_bundle": newobj_only,
        "unobserved_in_bundle": unobserved,
        "written_both_ways": both,
        "evidence": evidence,
        "newobj_evidence": {n: newobj[n] for n in newobj_only},
        "note": (
            "Report only: UI_MAXCLASSES (src/maxpat/maxclass_map.py) and UI_SIZES "
            "(src/maxpat/sizing.py) are edited by hand; add a missing name only after "
            "checking it is a widget MAX saves with its own maxclass, and remove a "
            "newobj-only name."
        ),
    }


def build_bundle_index(max_app: str | Path) -> dict:
    """Everything the tool reads from the bundle, gathered once."""
    install = audit_install(max_app)
    if not install.get("available"):
        return {
            "available": False,
            "reason": install.get("reason", "Max bundle unavailable"),
            "install": install,
        }
    c74 = Path(install["app_path"]) / "Contents" / "Resources" / "C74"
    refs, errors = scan_refpages(c74)
    return {
        "available": True,
        "install": install,
        "version": _major_minor(install.get("short_version")),
        "c74": str(c74),
        "defines": parse_define_mappings(c74),
        "objectfiles": parse_objectfile_mappings(c74),
        "refs": refs,
        "parse_errors": errors,
        "help": build_help_index(c74),
    }


# ---------------------------------------------------------------------------
# DB access
# ---------------------------------------------------------------------------


def _muted_lookup(db: ObjectDatabase, name: str) -> dict | None:
    """ObjectDatabase.lookup() without its advisory warnings."""
    with warnings.catch_warnings():
        warnings.simplefilter("ignore")
        return db.lookup(name)


def load_db(db_root: Path) -> ObjectDatabase:
    with warnings.catch_warnings():
        warnings.simplefilter("ignore")
        return ObjectDatabase(db_root)


def load_raw_db(db_root: Path) -> dict[str, dict]:
    """Raw base-file contents keyed by path relative to the DB root.

    This is the data the tool can write -- before ObjectDatabase applies
    overrides. gen / rnbo are loaded for the I/O snapshot only.
    """
    raw: dict[str, dict] = {}
    for domain in (*WRITABLE_CORE_DIRS, *READ_ONLY_CORE_DIRS):
        path = db_root / domain / "objects.json"
        if path.exists():
            raw[f"{domain}/objects.json"] = json.loads(path.read_text())
    pkg_root = db_root / "packages"
    if pkg_root.is_dir():
        for pkg_dir in sorted(pkg_root.iterdir()):
            path = pkg_dir / "objects.json"
            if pkg_dir.is_dir() and path.exists():
                raw[f"packages/{pkg_dir.name}/objects.json"] = json.loads(path.read_text())
    return raw


def db_package_dir(db_root: Path, bundle_package: str) -> str | None:
    """Map a bundle package directory to the DB package directory of the same name."""
    pkg_root = db_root / "packages"
    try:
        names = [p.name for p in pkg_root.iterdir() if (p / "objects.json").exists()]
    except (FileNotFoundError, PermissionError, OSError):
        return None
    if bundle_package in names:
        return bundle_package
    folded = [n for n in names if n.casefold() == bundle_package.casefold()]
    return folded[0] if len(folded) == 1 else None


def locate_base_entry(resolved: dict, name: str, raw_db: dict) -> tuple[str, str] | None:
    """The (file, key) holding the entry that lookup resolved to, if writable.

    Package entries live in their package file; core entries in the domain
    file matching their `domain`. Names that exist only in gen / rnbo (or
    duplicates there) are never written.
    """
    package = resolved.get("package")
    if package:
        rel = f"packages/{package}/objects.json"
    else:
        directory = DOMAIN_TO_DIR.get(resolved.get("domain"))
        if directory is None:
            return None
        rel = f"{directory}/objects.json"
    data = raw_db.get(rel)
    if not isinstance(data, dict):
        return None
    for key in (name, resolved.get("name")):
        if key and key in data:
            return rel, key
    return None


# ---------------------------------------------------------------------------
# Classification
# ---------------------------------------------------------------------------


def classify_refs(index: dict, db: ObjectDatabase, db_root: Path) -> dict:
    """Decide which refpage file speaks for which object name.

    (a) alias document -- the filename stem is a `max define` alias and the
        name attribute differs from the stem. It documents the alias and is
        never merged into the object the name attribute points at.
    (b) collision -- several files share a name attribute. The authoritative
        one is the file whose stem equals the name, otherwise the first
        core-root file; the rest are reported and ignored. A package refpage
        whose name attribute differs from its stem and resolves to an object
        that package does not own is the same trap with the core page
        missing, and is ignored the same way.
    (c) normal.
    """
    defines = index["defines"]
    alias_docs: list[dict] = []
    collisions: list[dict] = []
    by_name: dict[str, list[dict]] = {}

    for ref in index["refs"]:
        ref["class"] = "normal"
        if ref["stem"] in defines and ref["name"] != ref["stem"]:
            ref["class"] = "alias_doc"
            alias_docs.append(
                {
                    "alias": ref["stem"],
                    "name_attribute": ref["name_attribute"],
                    "file": ref["file"],
                    "package": ref["package"],
                }
            )
            continue
        by_name.setdefault(ref["name"], []).append(ref)

    authoritative: dict[str, dict] = {}
    for name, group in by_name.items():
        if len(group) > 1:
            winner = next((r for r in group if r["stem"] == name), None)
            if winner is None:
                winner = next((r for r in group if r["root"] == "core"), group[0])
            losers = [r for r in group if r is not winner]
            for ref in losers:
                ref["class"] = "collision"
            collisions.append(
                {
                    "name": name,
                    "kind": "shared_name_attribute",
                    "authoritative": winner["file"],
                    "ignored": [r["file"] for r in losers],
                }
            )
        else:
            winner = group[0]
            if winner["root"] == "package" and winner["name"] != winner["stem"]:
                resolved = _muted_lookup(db, name)
                owner = db_package_dir(db_root, winner["package"] or "")
                if resolved is not None and resolved.get("package") != owner:
                    winner["class"] = "collision"
                    collisions.append(
                        {
                            "name": name,
                            "kind": "foreign_name_attribute",
                            "authoritative": None,
                            "ignored": [winner["file"]],
                        }
                    )
                    continue
        authoritative[name] = winner

    return {"authoritative": authoritative, "alias_docs": alias_docs, "collisions": collisions}


# ---------------------------------------------------------------------------
# Entry builder (new refpage-backed objects)
# ---------------------------------------------------------------------------


def _is_template(value) -> bool:
    """True when a refpage string is an unfilled Cycling '74 template token."""
    if value is None:
        return True
    if not isinstance(value, str):
        return False
    text = value.strip()
    if text in _WHOLE_VALUE_TOKENS:
        return True
    return any(token in text for token in _SUBSTRING_TOKENS)


def scrub_templates(entry: dict) -> list[str]:
    """C2: blank unfilled template tokens. Returns the scrubbed field paths.

    Nothing is written in their place -- the DB never gets prose of ours.
    """
    scrubbed: list[str] = []
    for field in ("digest", "description", "category"):
        value = entry.get(field)
        if isinstance(value, str) and value and _is_template(value):
            entry[field] = ""
            scrubbed.append(field)
    for kind in ("inlets", "outlets"):
        for port in entry.get(kind, []):
            if port.get("digest") and _is_template(port["digest"]):
                port["digest"] = ""
                scrubbed.append(f"{kind}[{port.get('id')}].digest")
    kept_args = []
    for i, arg in enumerate(entry.get("arguments", [])):
        if _is_template(arg.get("name") or ""):
            # A placeholder argument documents nothing (precedent:
            # node.codebox in quick-260921-j0h).
            scrubbed.append(f"arguments[{i}]")
            continue
        if arg.get("digest") and _is_template(arg["digest"]):
            arg["digest"] = ""
            scrubbed.append(f"arguments[{i}].digest")
        kept_args.append(arg)
    entry["arguments"] = kept_args
    kept_tags = [t for t in entry.get("tags", []) if not _is_template(t)]
    if len(kept_tags) != len(entry.get("tags", [])):
        scrubbed.append("tags")
        entry["tags"] = kept_tags
    return scrubbed


def _type_inlets(entry: dict, ref: dict) -> None:
    """C3: an explicit refpage inlet type is kept; a templated one is signal
    only when the methodlist carries a `signal` method.

    This deliberately overrides the extractor's blanket tilde inference: the
    jit.web~ inlet takes messages, not audio.
    """
    raw_types = ref.get("inlet_types") or []
    has_signal_method = "signal" in (ref.get("methods") or [])
    for inlet, raw in zip(entry.get("inlets", []), raw_types):
        if not _is_template(raw):
            continue
        if has_signal_method:
            if not inlet.get("signal"):
                inlet["type"] = "signal"
                inlet["signal"] = True
        else:
            inlet["type"] = "control"
            inlet["signal"] = False


def _hot_flags(entry: dict) -> None:
    """C7: every inlet carries `hot`, by the extractor's own rule."""
    ext = extractor()
    entry["inlets"] = ext.infer_hot_cold(entry.get("inlets", []), entry.get("module", ""))
    if "~" in entry.get("name", "") and (
        entry.get("module") == "msp" or entry.get("domain") in ("MSP", "MC")
    ):
        for inlet in entry["inlets"]:
            if inlet.get("signal"):
                inlet["hot"] = True


def outlet_from_help(index_: int, raw: str, refpage_digest: str) -> dict:
    """C4: map one help-box outlettype value to a DB outlet record."""
    if raw == "signal":
        otype, is_signal = "signal", True
    elif raw == "multichannelsignal":
        otype, is_signal = "multichannelsignal", True
    elif raw == "jit_matrix":
        otype, is_signal = "matrix", False
    else:
        # "", jit_gl_texture, and anything else Max does not treat as audio.
        otype, is_signal = "control", False
    digest = refpage_digest or (raw if otype == "control" else "")
    return {"id": index_, "type": otype, "signal": is_signal, "digest": digest}


def apply_help_io(entry: dict, ref: dict | None, evidence: dict, notes: dict) -> str | None:
    """C4: outlet types (and undeclared counts) from the help-patch box.

    Returns an abort reason, or None on success.
    """
    boxes = evidence["boxes"]
    if not boxes:
        if evidence["ui_boxes"]:
            return (
                "only UI-class boxes (maxclass == object name) found in the help "
                "patch; a UI widget needs a UI_MAXCLASSES review, not this tool"
            )
        notes["io_source"] = "refpage (no help-patch box found)"
        return None

    counts = sorted({(b["numinlets"], b["numoutlets"]) for b in boxes})
    if len(counts) > 1:
        return f"help boxes disagree on inlet/outlet counts: {counts}"
    num_in, num_out = counts[0]

    declared_in = ref is not None and ref.get("inlets") is not None
    declared_out = ref is not None and ref.get("outlets") is not None
    if declared_in and len(entry["inlets"]) != num_in:
        return (
            f"refpage declares {len(entry['inlets'])} inlets but the help box has "
            f"{num_in}"
        )
    if declared_out and len(entry["outlets"]) != num_out:
        return (
            f"refpage declares {len(entry['outlets'])} outlets but the help box has "
            f"{num_out}"
        )

    sources = []
    if not declared_in:
        signal = "signal" in ((ref or {}).get("methods") or [])
        entry["inlets"] = [
            {
                "id": i,
                "type": "signal" if signal else "control",
                "signal": signal,
                "digest": "",
            }
            for i in range(num_in)
        ]
        sources.append("inlet count from help box")
    if not declared_out:
        sources.append("outlet count from help box")

    outlettypes = boxes[0]["outlettype"]
    if any(b["outlettype"] != outlettypes for b in boxes):
        notes["outlettype_variants"] = sorted({json.dumps(b["outlettype"]) for b in boxes})
    old_outlets = entry.get("outlets", [])
    entry["outlets"] = [
        outlet_from_help(
            i,
            outlettypes[i] if i < len(outlettypes) else "",
            old_outlets[i].get("digest", "") if i < len(old_outlets) else "",
        )
        for i in range(num_out)
    ]
    sources.append("outlet types from help box")
    notes["io_source"] = f"{evidence['help_stem']}.maxhelp: " + ", ".join(sources)
    return None


def order_like(entry: dict, template_keys: list[str]) -> dict:
    return {key: entry[key] for key in template_keys}


def match_key_template(entry: dict, dest_data: dict) -> list[str] | None:
    """C6: the key order of an existing entry with exactly the same key set."""
    wanted = set(entry)
    for existing in dest_data.values():
        if isinstance(existing, dict) and set(existing) == wanted:
            return list(existing)
    return None


def build_refpage_entry(
    name: str,
    ref: dict,
    index: dict,
    *,
    package_dir: str | None = None,
    help_stems: tuple[str, ...] = (),
) -> dict:
    """Build a DB entry for a refpage-backed object.

    Starts from parse_standard_xml, then applies the curation steps the
    extractor cannot do (C1-C7, see the comments at each step).
    """
    result = {"name": name, "status": "aborted", "source": ref["file"], "notes": {}}
    parsed = parse_refpage(ref)
    if parsed is None or "_error" in parsed:
        result["reason"] = f"refpage did not parse: {(parsed or {}).get('_error', 'not an object page')}"
        return result
    entry = copy.deepcopy(parsed)
    entry["name"] = name

    # C2: blank unfilled template tokens before anything reads the digests.
    result["notes"]["scrubbed"] = scrub_templates(entry)
    # C3: inlet typing from the methodlist, not from the tilde in the name.
    _type_inlets(entry, ref)
    # C4: outlet typing from the help-patch box Max itself serialized.
    evidence = find_help_boxes(index, name, help_stems)
    result["notes"]["help_boxes"] = len(evidence["boxes"])
    reason = apply_help_io(entry, ref, evidence, result["notes"])
    if reason:
        result["reason"] = reason
        return result
    # C7: hot flags, by the extractor's rule.
    _hot_flags(entry)
    # C1: nothing extracted from a Max refpage is RNBO-export-verified.
    entry["rnbo_compatible"] = False
    # C5: the object is new in the installed major.minor.
    if index.get("version") is None:
        result["reason"] = "installed Max version is not parseable as major.minor"
        return result
    entry["min_version"] = index["version"]
    entry["verified"] = bool(entry["inlets"] or entry["outlets"])
    # C6: package objects carry domain Packages and their DB package directory.
    if package_dir is not None:
        entry["domain"] = "Packages"
        entry["package"] = package_dir

    result["status"] = "built"
    result["entry"] = entry
    return result


# ---------------------------------------------------------------------------
# Report sections
# ---------------------------------------------------------------------------


def is_doc_page_name(name: str) -> bool:
    """A refpage name containing whitespace documents a topic, never an object.

    "MC Wrapper Features", "Snapshot Messages": a name with a space can never
    be the first token of an object box. Shared with
    ``.claude/scripts/extract_objects.py`` (Q30 PD-7), which applies only
    this rule.
    """
    return any(ch.isspace() for ch in name)


def _is_doc_page(ref: dict) -> bool:
    """A refpage with no inlets, outlets or methods documents a topic, not an object.

    So does any page whose name contains whitespace (:func:`is_doc_page_name`):
    the bundle's group pages carry empty inletlist / outletlist elements plus
    a shared methodlist.
    """
    if is_doc_page_name(ref["name"]):
        return True
    return not ref["inlets"] and not ref["outlets"] and not ref["methods"]


def _help_summary(evidence: dict) -> dict:
    return {
        "help_stem": evidence["help_stem"],
        "boxes": [
            {
                "numinlets": b["numinlets"],
                "numoutlets": b["numoutlets"],
                "outlettype": b["outlettype"],
                "text": b["text"],
            }
            for b in evidence["boxes"]
        ],
        "ui_boxes": len(evidence["ui_boxes"]),
    }


def section_new_objects(index: dict, classified: dict, db: ObjectDatabase) -> dict:
    """Refpage names (normal classification) that ObjectDatabase cannot resolve."""
    objects = []
    for name in sorted(classified["authoritative"]):
        ref = classified["authoritative"][name]
        if _muted_lookup(db, name) is not None:
            continue
        kind = "doc_page" if _is_doc_page(ref) else "object"
        define = index["defines"].get(name)
        evidence = find_help_boxes(index, name, (define["target"],) if define else ())
        objects.append(
            {
                "name": name,
                "kind": kind,
                "file": ref["file"],
                "package": ref["package"],
                "refpage_inlets": ref["inlets"],
                "refpage_outlets": ref["outlets"],
                "help": _help_summary(evidence),
            }
        )
    return {
        "available": True,
        "count": len(objects),
        "names": [o["name"] for o in objects if o["kind"] == "object"],
        "doc_pages": [o["name"] for o in objects if o["kind"] == "doc_page"],
        "objects": objects,
    }


def section_define_missing(index: dict, db: ObjectDatabase) -> dict:
    """`max define` aliases that ObjectDatabase cannot resolve."""
    stems = {}
    for ref in index["refs"]:
        stems.setdefault(ref["stem"], ref)
    entries = []
    for alias in sorted(index["defines"]):
        if _muted_lookup(db, alias) is not None:
            continue
        define = index["defines"][alias]
        ref = stems.get(alias)
        evidence = find_help_boxes(index, alias, (define["target"],))
        entries.append(
            {
                "alias": alias,
                "target": define["target"],
                "args": define["args"],
                "package": define["package"],
                "mapping_file": define["mapping_file"],
                "refpage": ref["file"] if ref else None,
                "refpage_name_attribute": ref["name_attribute"] if ref else None,
                "help": _help_summary(evidence),
            }
        )
    return {
        "available": True,
        "count": len(entries),
        "names": [e["alias"] for e in entries],
        "entries": entries,
    }


_RNBO_GEN_DOMAINS = ("RNBO", "Gen")


def _objectfile_canonical(db: ObjectDatabase, records: dict, x: str | None) -> str | None:
    """The DB name lookup() gives `x`, else the DB name of the first objectfile
    alias (in name order) whose file is `x` and which resolves (Q30 PD-6)."""
    if not x:
        return None
    hit = _muted_lookup(db, x)
    if hit is not None:
        return hit.get("name", x)
    for name in sorted(records):
        if records[name]["file"] == x:
            via = _muted_lookup(db, name)
            if via is not None:
                return via.get("name", name)
    return None


def objectfile_candidate(record: dict, db: ObjectDatabase, records: dict) -> tuple[str | None, str | None]:
    """(candidate alias target, basis) for one objectfile record (Q30 PD-6).

    By line shape, the first rule that yields a name the DB resolves:
    * file ``mc.wrapper~`` -> basis ``mc_wrapper``: "mc." + canonical(class),
      with no fallback to the mono class;
    * file ending ``.maxpat`` / ``.js`` -> basis ``abstraction``: the file stem;
    * otherwise basis ``class``: canonical(class) when it differs from the
      alias, else basis ``file``: canonical(file).
    (None, None) when no rule yields a resolvable name.
    """
    name, file_, cls = record["name"], record["file"], record["class"]

    def resolved(candidate: str | None) -> str | None:
        if not candidate or candidate == name:
            return None
        hit = _muted_lookup(db, candidate)
        return hit.get("name", candidate) if hit is not None else None

    if file_ == "mc.wrapper~":
        mono = _objectfile_canonical(db, records, cls)
        target = resolved("mc." + mono) if mono else None
        return (target, "mc_wrapper") if target else (None, None)
    if file_.endswith((".maxpat", ".js")):
        target = resolved(file_.rsplit(".", 1)[0])
        return (target, "abstraction") if target else (None, None)
    target = resolved(_objectfile_canonical(db, records, cls))
    if target:
        return target, "class"
    target = resolved(_objectfile_canonical(db, records, file_))
    if target:
        return target, "file"
    return None, None


def _io_counts(db: ObjectDatabase, name: str, args: list[str]) -> list[int] | None:
    try:
        with warnings.catch_warnings():
            warnings.simplefilter("ignore")
            inlets, outlets = db.compute_io_counts(name, args)
    except Exception:  # noqa: BLE001 -- evidence only; an unresolvable count is "no evidence"
        return None
    return [inlets, outlets]


def objectfile_evidence(index: dict, db: ObjectDatabase, name: str, candidate: str | None) -> dict:
    """Help-box evidence for aliasing `name` to `candidate` (Q30 PD-6).

    ``help_io`` lists each help box's [numinlets, numoutlets];
    ``help_io_agrees`` is True when every box equals
    ``compute_io_counts(candidate, box args)``, False when any differs, None
    with no box (or no candidate).
    """
    evidence = find_help_boxes(index, name, (candidate,) if candidate else ())
    boxes = evidence["boxes"]
    help_io = [[b["numinlets"], b["numoutlets"]] for b in boxes]
    agrees: bool | None = None
    if boxes and candidate:
        agrees = all(
            _io_counts(db, candidate, b["text"].split()[1:]) == [b["numinlets"], b["numoutlets"]]
            for b in boxes
        )
    return {"help_stem": evidence["help_stem"], "help_io": help_io, "help_io_agrees": agrees}


def _objectfile_entry(index: dict, db: ObjectDatabase, records: dict, record: dict) -> dict:
    candidate, basis = objectfile_candidate(record, db, records)
    target = _muted_lookup(db, candidate) if candidate else None
    entry = {key: record[key] for key in ("name", "file", "class", "args", "package", "mapping_file", "line")}
    entry.update(
        {
            "candidate": candidate,
            "basis": basis,
            "candidate_domain": target.get("domain") if target else None,
            "candidate_io": _io_counts(db, candidate, []) if candidate else None,
        }
    )
    entry.update(objectfile_evidence(index, db, record["name"], candidate))
    return entry


def section_objectfile_aliases(index: dict, db: ObjectDatabase) -> dict:
    """`max objectfile` names the DB cannot resolve, with a proposed alias (Q30 PD-6).

    Report-only; aliases land only through ``--apply aliases --names``. Names
    whose lookup() entry is an RNBO or Gen entry (the list.* family) resolve,
    so they are not unresolved, but Max instantiates the objectfile instead:
    they are listed apart under ``domain_shadowed``.
    """
    parsed = index.get("objectfiles") or {"records": {}, "lines": 0, "files": [], "duplicates": []}
    records = parsed["records"]
    entries: list[dict] = []
    shadowed: list[dict] = []
    resolved = 0
    for name in sorted(records):
        hit = _muted_lookup(db, name)
        if hit is None:
            entries.append(_objectfile_entry(index, db, records, records[name]))
            continue
        resolved += 1
        if hit.get("domain") in _RNBO_GEN_DOMAINS:
            item = _objectfile_entry(index, db, records, records[name])
            item["domain"] = hit.get("domain")
            shadowed.append(item)
    by_basis: dict[str, int] = {}
    for entry in entries:
        key = entry["basis"] or "none"
        by_basis[key] = by_basis.get(key, 0) + 1
    return {
        "available": True,
        "files": parsed["files"],
        "lines": parsed["lines"],
        "names": len(records),
        "duplicates": parsed["duplicates"],
        "resolved": resolved,
        "unresolved_count": len(entries),
        "names_unresolved": [e["name"] for e in entries],
        "by_basis": dict(sorted(by_basis.items())),
        "domain_shadowed": shadowed,
        "entries": entries,
    }


def _dedupe(items: list) -> list:
    seen = set()
    out = []
    for item in items:
        if item not in seen:
            seen.add(item)
            out.append(item)
    return out


def _diff_ref_against_entry(
    parsed: dict,
    resolved: dict,
    located: tuple[str, str],
    raw_db: dict,
    objects: list[dict],
    shadowed: list[dict],
) -> None:
    """Append one parsed refpage's delta / shadow rows for the raw entry at `located`."""
    ref_messages = _dedupe(parsed.get("messages", []))
    ref_attributes = parsed.get("attributes", {})

    rel, key = located
    raw = raw_db[rel][key]
    raw_messages = raw.get("messages")
    raw_attributes = raw.get("attributes")

    new_messages = (
        [m for m in ref_messages if m not in raw_messages]
        if isinstance(raw_messages, list)
        else []
    )
    new_attributes = (
        {k: v for k, v in ref_attributes.items() if k not in raw_attributes}
        if isinstance(raw_attributes, dict)
        else {}
    )
    if new_messages or new_attributes:
        objects.append(
            {
                "name": key,
                "file": rel,
                "messages": new_messages,
                "attributes": new_attributes,
            }
        )

    # An override that carries its own list replaces the base list, so the
    # resolved list differs from the raw one. Detected through lookup();
    # overrides.json itself is never opened here.
    shadow_messages: list | None = None
    shadow_attributes: list | None = None
    resolved_messages = resolved.get("messages")
    resolved_attributes = resolved.get("attributes")
    if isinstance(resolved_messages, list) and resolved_messages != raw_messages:
        shadow_messages = [m for m in ref_messages if m not in resolved_messages]
    if isinstance(resolved_attributes, dict) and resolved_attributes != raw_attributes:
        shadow_attributes = [k for k in ref_attributes if k not in resolved_attributes]
    if shadow_messages is not None or shadow_attributes is not None:
        shadowed.append(
            {
                "name": key,
                "messages_missing": shadow_messages or [],
                "attributes_missing": shadow_attributes or [],
            }
        )


def compute_deltas(index: dict, classified: dict, db: ObjectDatabase, raw_db: dict) -> dict:
    """Messages / attributes the bundle documents and the raw base entry lacks.

    Two passes. The first diffs every authoritative refpage against the entry
    its name attribute resolves to. The second (quick-261118-j2w) diffs every
    define-mapped alias document (``ref["class"] == "alias_doc"``, set by
    :func:`classify_refs`, which must run first) against the ALIAS's own
    entry, keyed by the filename stem: the alias is the real object name, and
    the refpage's name attribute (``v8``, ``jit.geom.tomatrix``, ...) is never
    written. An alias missing from the DB, or one whose lookup lands on any
    entry other than its own key, is skipped; ``define_missing`` still lists
    the former.

    `objects` is what --apply deltas writes. `shadowed` lists objects whose
    overrides.json entry replaces the messages / attributes list, with the
    refpage names that override list lacks -- report-only, never applied and
    not counted in the pending totals.
    """
    objects: list[dict] = []
    shadowed: list[dict] = []
    unwritable: list[str] = []
    for name in sorted(classified["authoritative"]):
        ref = classified["authoritative"][name]
        resolved = _muted_lookup(db, name)
        if resolved is None:
            continue
        parsed = parse_refpage(ref)
        if parsed is None or "_error" in parsed:
            continue
        located = locate_base_entry(resolved, name, raw_db)
        if located is None:
            unwritable.append(name)
            continue
        _diff_ref_against_entry(parsed, resolved, located, raw_db, objects, shadowed)

    handled = {o["name"] for o in objects} | set(classified["authoritative"])
    alias_refs = sorted(
        (r for r in index.get("refs", []) if r.get("class") == "alias_doc"),
        key=lambda r: (r["stem"], r["file"]),
    )
    for ref in alias_refs:
        alias = ref["stem"]
        if alias in handled:
            continue
        handled.add(alias)
        resolved = _muted_lookup(db, alias)
        if resolved is None:
            continue
        located = locate_base_entry(resolved, alias, raw_db)
        if located is None or located[1] != alias:
            continue
        parsed = parse_refpage(ref)
        if parsed is None or "_error" in parsed:
            continue
        _diff_ref_against_entry(parsed, resolved, located, raw_db, objects, shadowed)

    with_messages = [o for o in objects if o["messages"]]
    with_attributes = [o for o in objects if o["attributes"]]
    return {
        "available": True,
        "object_count": len(objects),
        "objects_gaining_messages": len(with_messages),
        "objects_gaining_attributes": len(with_attributes),
        "pending_messages": sum(len(o["messages"]) for o in objects),
        "pending_attributes": sum(len(o["attributes"]) for o in objects),
        "files": sorted({o["file"] for o in objects}),
        "objects": objects,
        "unwritable": unwritable,
        "_shadowed": shadowed,
    }


def group_attribute_definitions(index: dict) -> tuple[dict[str, dict], list[str]]:
    """Attribute definitions carried by the bundle's group (documentation) pages.

    A group page is a refpage whose name contains whitespace ("Jitter GL
    Object (OB3D) Messages", "Jitter Matrix Operators"): it can never be an
    object box. Returns ({attribute: {"definition", "source"}}, ambiguous
    names). A name two group pages define differently is ambiguous and never
    offered.
    """
    definitions: dict[str, dict] = {}
    ambiguous: set[str] = set()
    for ref in index["refs"]:
        if ref["class"] != "normal" or not any(ch.isspace() for ch in ref["name"]):
            continue
        parsed = parse_refpage(ref)
        if parsed is None or "_error" in parsed:
            continue
        for attr, definition in (parsed.get("attributes") or {}).items():
            known = definitions.get(attr)
            if known is not None and not _same(known["definition"], definition):
                ambiguous.add(attr)
                continue
            definitions.setdefault(attr, {"definition": definition, "source": ref["file"]})
    for attr in ambiguous:
        definitions.pop(attr, None)
    return definitions, sorted(ambiguous)


def compute_inherited(
    index: dict,
    classified: dict,
    db: ObjectDatabase,
    raw_db: dict,
    groups: dict | None = None,
) -> dict:
    """Group-page attributes an object refpage lists and its raw base entry lacks.

    `_pending` is what --apply inherited can write, restricted there to an
    explicit attribute allow-list. `undefined` counts the referenced names no
    group page defines (they cannot be added: there is no type to record).
    A name `groups` (the groups.json data) already records for the member
    counts as recorded: it is neither pending nor undefined.
    """
    definitions, ambiguous = group_attribute_definitions(index)
    objects: list[dict] = []
    by_attribute: dict[str, int] = {}
    undefined: dict[str, int] = {}
    for name in sorted(classified["authoritative"]):
        ref = classified["authoritative"][name]
        referenced = _dedupe(ref.get("inherited_attributes") or [])
        if not referenced or _is_doc_page(ref):
            continue
        resolved = _muted_lookup(db, name)
        if resolved is None:
            continue
        located = locate_base_entry(resolved, name, raw_db)
        if located is None:
            continue
        rel, key = located
        raw_attributes = raw_db[rel][key].get("attributes")
        if not isinstance(raw_attributes, dict):
            continue
        pending = {}
        recorded = _effective_names(groups, key)
        for attr in referenced:
            if attr in raw_attributes or attr in recorded:
                continue
            if attr in definitions:
                pending[attr] = copy.deepcopy(definitions[attr]["definition"])
                by_attribute[attr] = by_attribute.get(attr, 0) + 1
            elif attr not in ambiguous:
                undefined[attr] = undefined.get(attr, 0) + 1
        if pending:
            objects.append({"name": key, "file": rel, "attributes": pending})
    return {
        "available": True,
        "note": (
            "report-only: the DB does not record inherited group attributes as a "
            "rule; --apply inherited needs an explicit --attributes list"
        ),
        "object_count": len(objects),
        "pending_attributes": sum(len(o["attributes"]) for o in objects),
        "by_attribute": dict(sorted(by_attribute.items())),
        "group_pages": sorted({d["source"] for d in definitions.values()}),
        "undefined": dict(sorted(undefined.items())),
        "ambiguous": ambiguous,
        "objects": [
            {"name": o["name"], "file": o["file"], "attributes": sorted(o["attributes"])}
            for o in objects
        ],
        "_pending": objects,
    }


# ---------------------------------------------------------------------------
# Inherited group profiles (review C8 / Q14) -- groups.json
# ---------------------------------------------------------------------------

GROUPS_FILE = "groups.json"

GROUPS_COMMENT = (
    "Inherited group messages/attributes (review C8 / Q14). Written only by "
    "tools/sync_max_bundle.py --apply groups. Merged at call time by "
    "ObjectDatabase.messages/attributes/selectors; never copied into domain files."
)

# Profile `source` per refpage-list family.
GROUP_SOURCES = {
    "mc": "refpage <mcwrapper>",
    "jit": "refpage <jittermethodlist>/<jitterattributelist>",
}

# thispatcher's selectors come from its help patch (decision 7), one profile.
THISPATCHER_PROFILE = "thispatcher-help"

# Upstream hops walked from a thispatcher box in its help patch.
THISPATCHER_HOPS = 3

_NUMERIC_TOKEN = re.compile(r"^-?\d")


def canonical_groups_bytes(data: dict) -> bytes:
    """The one serialization groups.json is ever written in."""
    return (json.dumps(data, indent=2, sort_keys=True, ensure_ascii=False) + "\n").encode("utf-8")


def load_groups(db_root: str | Path) -> dict | None:
    """The groups.json on disk, or None when there is none."""
    path = Path(db_root) / GROUPS_FILE
    if not path.exists():
        return None
    data = json.loads(path.read_text(encoding="utf-8"))
    if (
        not isinstance(data, dict)
        or not isinstance(data.get("profiles"), dict)
        or not isinstance(data.get("members"), dict)
    ):
        raise ValueError(f"{path}: not a groups file (object with dict profiles / members)")
    return data


def _effective_names(groups: dict | None, key: str) -> set[str]:
    """Every message and attribute name a member's profiles give it."""
    if not groups:
        return set()
    profiles = groups.get("profiles") or {}
    names: set[str] = set()
    for pid in (groups.get("members") or {}).get(key, []):
        profile = profiles.get(pid)
        if isinstance(profile, dict):
            names.update(profile.get("messages") or [])
            names.update(profile.get("attributes") or [])
    return names


def _profile_id(family: str, messages, attributes) -> str:
    """family + first 8 hex of the sha256 of the sorted name lists."""
    body = json.dumps({"attributes": sorted(attributes), "messages": sorted(messages)}, sort_keys=True)
    return f"{family}-{hashlib.sha256(body.encode('utf-8')).hexdigest()[:8]}"


def _ref_group_lists(ref: dict) -> dict[str, tuple[list[str], list[str]]]:
    """{family: (messages, attributes)} a refpage lists by name, non-empty only."""
    lists = {
        "mc": (ref.get("mcwrapper_methods") or [], ref.get("mcwrapper_attributes") or []),
        "jit": (ref.get("jitter_methods") or [], ref.get("inherited_attributes") or []),
    }
    return {family: pair for family, pair in lists.items() if pair[0] or pair[1]}


def _box_text(box: dict) -> str:
    text = box.get("text")
    return text.strip() if isinstance(text, str) else ""


def _upstream_selectors(box: dict) -> list[str]:
    """Selectors a message box or `prepend X` box sends downstream."""
    text = _box_text(box)
    if box.get("maxclass") == "message":
        if text.startswith(";"):
            return []
        out = []
        for segment in text.split(","):
            tokens = segment.split()
            if tokens and not tokens[0].startswith("$") and not _NUMERIC_TOKEN.match(tokens[0]):
                out.append(tokens[0])
        return out
    if box.get("maxclass") == "newobj":
        tokens = text.split()
        if len(tokens) > 1 and tokens[0] == "prepend":
            return [tokens[1]]
    return []


def _walk_thispatcher_help(patcher, depth: int, found: set[str]) -> None:
    if depth > MAX_PATCHER_DEPTH or not isinstance(patcher, dict):
        return
    boxes: dict[str, dict] = {}
    for entry in patcher.get("boxes") or []:
        box = entry.get("box") if isinstance(entry, dict) else None
        if isinstance(box, dict) and isinstance(box.get("id"), str):
            boxes[box["id"]] = box
    upstream: dict[str, list[str]] = {}
    for entry in patcher.get("lines") or []:
        line = entry.get("patchline") if isinstance(entry, dict) else None
        if not isinstance(line, dict):
            continue
        source, destination = line.get("source"), line.get("destination")
        if isinstance(source, list) and isinstance(destination, list) and source and destination:
            upstream.setdefault(destination[0], []).append(source[0])
    for bid, box in boxes.items():
        tokens = _box_text(box).split()
        if box.get("maxclass") != "newobj" or tokens[:1] != ["thispatcher"]:
            continue
        visited = {bid}
        frontier = [bid]
        for _hop in range(THISPATCHER_HOPS):
            following = []
            for current in frontier:
                for src in upstream.get(current, []):
                    if src in visited or src not in boxes:
                        continue
                    visited.add(src)
                    found.update(_upstream_selectors(boxes[src]))
                    following.append(src)
            frontier = following
    for box in boxes.values():
        _walk_thispatcher_help(box.get("patcher"), depth + 1, found)


def thispatcher_help_selectors(index: dict) -> dict | None:
    """Selectors the thispatcher help patch sends to a thispatcher box.

    For every newobj ``thispatcher`` box (any patcher depth, bounded by
    MAX_PATCHER_DEPTH), walks patch cords upstream up to THISPATCHER_HOPS
    hops and collects the first token of each message-box segment (``;``
    remote-send boxes, ``$N`` and numeric tokens skipped) and the X of each
    ``prepend X``. Returns None when the bundle ships no thispatcher help.
    """
    files = index["help"].get("thispatcher", [])
    if not files:
        return None
    found: set[str] = set()
    errors: list[dict] = []
    for path in files:
        try:
            data = json.loads(Path(path).read_text(encoding="utf-8"))
        except (OSError, ValueError) as exc:
            errors.append({"file": path, "reason": str(exc)})
            continue
        _walk_thispatcher_help(data.get("patcher") if isinstance(data, dict) else None, 0, found)
    source = Path(files[0])
    try:
        source_rel = source.relative_to(Path(index["c74"])).as_posix()
    except ValueError:
        source_rel = source.as_posix()
    return {"selectors": sorted(found), "source": source_rel, "errors": errors}


def compute_groups(
    index: dict, classified: dict, db: ObjectDatabase, raw_db: dict, existing: dict | None
) -> dict:
    """The groups.json target plus its dry-run report.

    Membership comes only from the per-object refpage lists (``<mcwrapper>``,
    ``<jittermethodlist>`` / ``<jitterattributelist>``), never from a name
    prefix, plus the thispatcher help-patch selectors (fixed profile id
    ``thispatcher-help``); members are keyed by the DB key
    :func:`locate_base_entry` returns. Names an existing groups.json already
    records are unioned in (a bundle update never shrinks a member). The
    target is in ``_target``.
    """
    wanted: dict[str, dict[str, dict]] = {}
    unresolved: list[str] = []
    for name in sorted(classified["authoritative"]):
        ref = classified["authoritative"][name]
        # Group pages (whitespace in the name) are never members. A refpage
        # with no inlet/outlet/method lists can still document a real object
        # (jit.graph, jit.plot); locate_base_entry decides membership.
        if any(ch.isspace() for ch in ref["name"]):
            continue
        lists = _ref_group_lists(ref)
        if not lists:
            continue
        resolved = _muted_lookup(db, name)
        located = locate_base_entry(resolved, name, raw_db) if resolved is not None else None
        if located is None:
            unresolved.append(name)
            continue
        key = located[1]
        for family, (messages, attributes) in lists.items():
            slot = wanted.setdefault(key, {}).setdefault(
                family, {"messages": set(), "attributes": set(), "source": GROUP_SOURCES[family]}
            )
            slot["messages"].update(messages)
            slot["attributes"].update(attributes)

    thispatcher_source = None
    help_errors: list[dict] = []
    help_selectors = thispatcher_help_selectors(index)
    if help_selectors is not None:
        help_errors = help_selectors["errors"]
        resolved = _muted_lookup(db, "thispatcher")
        located = (
            locate_base_entry(resolved, "thispatcher", raw_db) if resolved is not None else None
        )
        if help_selectors["selectors"] and located is not None:
            thispatcher_source = help_selectors["source"]
            slot = wanted.setdefault(located[1], {}).setdefault(
                "thispatcher",
                {"messages": set(), "attributes": set(), "source": thispatcher_source},
            )
            slot["messages"].update(help_selectors["selectors"])

    existing_members = (existing or {}).get("members") or {}
    existing_profiles = (existing or {}).get("profiles") or {}
    for key, pids in existing_members.items():
        for pid in pids:
            profile = existing_profiles.get(pid)
            if not isinstance(profile, dict):
                continue
            slot = wanted.setdefault(key, {}).setdefault(
                profile.get("family"),
                {"messages": set(), "attributes": set(), "source": profile.get("source")},
            )
            slot["messages"].update(profile.get("messages") or [])
            slot["attributes"].update(profile.get("attributes") or [])

    profiles: dict[str, dict] = {}
    members: dict[str, list[str]] = {}
    for key in sorted(wanted):
        ids: list[str] = []
        for family in sorted(wanted[key], key=str):
            slot = wanted[key][family]
            messages = sorted(slot["messages"])
            attributes = sorted(slot["attributes"])
            if not messages and not attributes:
                continue
            pid = (
                THISPATCHER_PROFILE
                if family == "thispatcher"
                else _profile_id(family, messages, attributes)
            )
            body = {
                "family": family,
                "messages": messages,
                "attributes": attributes,
                "source": slot["source"],
            }
            known = profiles.get(pid)
            if known is not None and not _same(known, body):
                raise RuntimeError(f"groups.json profile id collision: {pid}")
            profiles[pid] = body
            ids.append(pid)
        if ids:
            members[key] = sorted(ids)

    definitions, ambiguous = group_attribute_definitions(index)
    referenced: set[str] = set()
    for profile in profiles.values():
        referenced.update(profile["attributes"])
    attribute_definitions = copy.deepcopy((existing or {}).get("attribute_definitions") or {})
    c74 = Path(index["c74"])
    for attr in sorted(referenced):
        if attr in attribute_definitions or attr not in definitions:
            continue
        source = Path(definitions[attr]["source"])
        try:
            source_rel = source.relative_to(c74).as_posix()
        except ValueError:
            source_rel = source.as_posix()
        attribute_definitions[attr] = {
            "definition": copy.deepcopy(definitions[attr]["definition"]),
            "source": source_rel,
        }

    target = {
        "_comment": GROUPS_COMMENT,
        "max_version": index["install"].get("short_version"),
        "attribute_definitions": attribute_definitions,
        "profiles": profiles,
        "members": members,
    }
    by_family: dict[str, int] = {}
    for pids in members.values():
        for pid in pids:
            family = profiles[pid]["family"]
            by_family[family] = by_family.get(family, 0) + 1
    return {
        "available": True,
        "note": (
            "inherited group names (MC wrapper / Jitter refpage lists, thispatcher "
            "help selectors) live in groups.json, merged at call time by "
            "ObjectDatabase.messages/attributes/selectors; --apply groups writes it"
        ),
        "members": len(members),
        "by_family": dict(sorted(by_family.items())),
        "profiles": len(profiles),
        "attribute_definitions": len(attribute_definitions),
        "pending_members": sum(1 for key in members if key not in existing_members),
        "pending_names": sum(
            len(_effective_names(target, key) - _effective_names(existing, key)) for key in members
        ),
        "undefined_attributes": sorted(
            a for a in referenced if a not in attribute_definitions and a not in ambiguous
        ),
        "ambiguous_attributes": sorted(a for a in referenced if a in ambiguous),
        "unresolved": unresolved,
        "thispatcher_source": thispatcher_source,
        "help_read_errors": help_errors,
        "_target": target,
    }


def _unavailable(reason: str) -> dict:
    return {"available": False, "reason": reason}


def run_report(db_root: str | Path, max_app: str | Path, index: dict | None = None) -> dict:
    """The dry-run report: every section always present in the envelope."""
    db_root = Path(db_root)
    index = index if index is not None else build_bundle_index(max_app)
    sections: dict[str, dict] = {"install": index["install"]}
    if not index["available"]:
        for key in SECTION_KEYS[1:]:
            sections[key] = _unavailable(index["reason"])
        return {"tool": "sync_max_bundle", "db_root": str(db_root), "sections": sections}

    db = load_db(db_root)
    raw_db = load_raw_db(db_root)
    classified = classify_refs(index, db, db_root)
    deltas = compute_deltas(index, classified, db, raw_db)
    shadowed = deltas.pop("_shadowed")

    sections["new_objects"] = section_new_objects(index, classified, db)
    sections["define_missing"] = section_define_missing(index, db)
    sections["objectfile_aliases"] = section_objectfile_aliases(index, db)
    sections["deltas"] = deltas
    existing_groups = load_groups(db_root)
    inherited = compute_inherited(index, classified, db, raw_db, groups=existing_groups)
    inherited.pop("_pending")
    sections["inherited_attributes"] = inherited
    groups = compute_groups(index, classified, db, raw_db, existing_groups)
    groups.pop("_target")
    sections["groups"] = groups
    sections["idioms"] = section_idioms(index, db_root)
    sections["version_io"] = section_version_io(index, db_root)
    sections["collisions"] = {
        "available": True,
        "count": len(classified["collisions"]),
        "entries": classified["collisions"],
    }
    sections["alias_docs"] = {
        "available": True,
        "count": len(classified["alias_docs"]),
        "entries": classified["alias_docs"],
    }
    sections["shadowed_by_override"] = {
        "available": True,
        "count": len(shadowed),
        "with_missing_names": [
            s["name"] for s in shadowed if s["messages_missing"] or s["attributes_missing"]
        ],
        "entries": shadowed,
    }
    sections["ui_maxclasses"] = section_ui_maxclasses(survey_maxclasses(Path(index["c74"])))
    return {
        "tool": "sync_max_bundle",
        "db_root": str(db_root),
        "refpage_files": len(index["refs"]),
        "parse_errors": index["parse_errors"],
        "sections": sections,
    }


# ---------------------------------------------------------------------------
# Writer -- the only function that writes into the DB tree
# ---------------------------------------------------------------------------


def allowed_db_target(path: str | Path, db_root: str | Path) -> str:
    """Return the DB-relative path of an allow-listed write target, or raise.

    Allow-list: the five writable core domain files, `packages/NAME/objects.json`
    and `package_info.json`. Everything else -- overrides.json above all --
    raises WriteRefused (T-hwb-01).
    """
    root = Path(db_root).resolve()
    target = Path(path).resolve()
    try:
        rel = target.relative_to(root).as_posix()
    except ValueError:
        raise WriteRefused(f"refusing to write {target}: outside the DB root {root}")
    parts = rel.split("/")
    allowed = (
        rel == "package_info.json"
        or (len(parts) == 2 and parts[0] in WRITABLE_CORE_DIRS and parts[1] == "objects.json")
        or (len(parts) == 3 and parts[0] == "packages" and parts[2] == "objects.json")
    )
    if not allowed:
        raise WriteRefused(
            f"refusing to write {rel}: not an allow-listed DB file (core domain "
            f"objects.json, packages/NAME/objects.json, package_info.json)"
        )
    return rel


def detect_style(raw: bytes, data) -> tuple[bool, bool]:
    """(ensure_ascii, trailing_newline) that reproduces `raw` from `data`.

    DB files are indent-2 JSON that differ in escaping and trailing newline;
    normalising either would rewrite thousands of unrelated lines. A pure-ASCII
    file reproduces both ways, in which case UTF-8 output is preferred.
    Delegates to :func:`src.maxpat.atomic_io.json_style` (shared with the
    audit merger) and raises StyleUnreproducible when it finds no style.
    """
    style = json_style(raw, data)
    if style is None:
        raise StyleUnreproducible(
            "no (indent=2, ensure_ascii, trailing newline) combination reproduces the file"
        )
    return style


def _same(a, b) -> bool:
    return json.dumps(a, sort_keys=True) == json.dumps(b, sort_keys=True)


def check_additive(old: dict, new: dict, rel: str) -> None:
    """Raise AdditiveViolation unless `new` only adds to `old` (T-hwb-02).

    Object files: every pre-existing entry keeps every field identical, except
    that `messages` may grow with the old list as a prefix and `attributes`
    may gain keys. package_info.json: only `object_count` may change, and only
    upward.
    """
    for key, old_entry in old.items():
        if key not in new:
            raise AdditiveViolation(f"{rel}: entry {key!r} would be removed")
        new_entry = new[key]
        if not isinstance(old_entry, dict) or not isinstance(new_entry, dict):
            if not _same(old_entry, new_entry):
                raise AdditiveViolation(f"{rel}: entry {key!r} would change")
            continue
        if set(new_entry) != set(old_entry):
            raise AdditiveViolation(
                f"{rel}: entry {key!r} would change its field set "
                f"({sorted(set(new_entry) ^ set(old_entry))})"
            )
        for field, old_value in old_entry.items():
            new_value = new_entry[field]
            if rel == "package_info.json":
                if field == "object_count":
                    if not isinstance(new_value, int) or new_value < old_value:
                        raise AdditiveViolation(
                            f"{rel}: {key!r} object_count would shrink "
                            f"({old_value} -> {new_value})"
                        )
                    continue
            elif field == "messages" and isinstance(old_value, list) and isinstance(new_value, list):
                if not _same(new_value[: len(old_value)], old_value):
                    raise AdditiveViolation(
                        f"{rel}: {key!r} messages would lose or reorder existing names"
                    )
                continue
            elif field == "attributes" and isinstance(old_value, dict) and isinstance(new_value, dict):
                for attr, attr_value in old_value.items():
                    if attr not in new_value or not _same(new_value[attr], attr_value):
                        raise AdditiveViolation(
                            f"{rel}: {key!r} attribute {attr!r} would be removed or changed"
                        )
                continue
            if not _same(old_value, new_value):
                raise AdditiveViolation(f"{rel}: {key!r} field {field!r} would change")
    if rel == "package_info.json" and set(new) != set(old):
        raise AdditiveViolation(f"{rel}: the package set would change")


def prepare_db_file(path: str | Path, new_data: dict, db_root: str | Path) -> bytes | None:
    """Every check of a DB object-file write, without writing (Q30 PD-5).

    Refuses anything off the allow-list (WriteRefused), reproduces the file's
    serialization style (StyleUnreproducible), runs the additive self-check
    (AdditiveViolation), keeps a sorted file sorted and appends new keys to an
    unsorted one. Returns the payload, or None when the output would be
    byte-identical.
    """
    rel = allowed_db_target(path, db_root)
    target = Path(path)
    raw = target.read_bytes()
    old = json.loads(raw)
    ensure_ascii, trailing_newline = detect_style(raw, old)
    check_additive(old, new_data, rel)

    old_keys = list(old)
    if old_keys == sorted(old_keys):
        ordered = {key: new_data[key] for key in sorted(new_data)}
    else:
        added = [key for key in new_data if key not in old]
        ordered = {key: new_data[key] for key in (*old_keys, *added)}

    text = json.dumps(ordered, indent=2, ensure_ascii=ensure_ascii)
    payload = (text + ("\n" if trailing_newline else "")).encode("utf-8")
    if payload == raw:
        return None
    return payload


def write_db_file(path: str | Path, new_data: dict, db_root: str | Path) -> bool:
    """Write one DB object file: :func:`prepare_db_file`, then an atomic replace.

    The replace keeps the file's mode (Q30 PD-4). Returns False (and writes
    nothing) when the output would be byte-identical.
    """
    payload = prepare_db_file(path, new_data, db_root)
    if payload is None:
        return False
    atomic_write_bytes(Path(path), payload)
    return True


def write_db_files(items: list[tuple[str | Path, dict]], db_root: str | Path) -> list[str]:
    """Write several DB object files all-or-nothing (Q30 PD-5).

    Every item is prepared first, so any WriteRefused, StyleUnreproducible or
    AdditiveViolation raises before a byte is written. The payloads then go
    through one :func:`src.maxpat.atomic_io.atomic_write_many`: a failed
    replace restores the files already replaced (bytes and mode). Returns the
    DB-relative paths written, in item order (byte-identical items skipped).
    """
    root = Path(db_root).resolve()
    staged: list[tuple[Path, bytes]] = []
    written: list[str] = []
    for path, data in items:
        payload = prepare_db_file(path, data, db_root)
        if payload is None:
            continue
        staged.append((Path(path), payload))
        written.append(Path(path).resolve().relative_to(root).as_posix())
    if staged:
        atomic_write_many(staged)
    return written


def check_groups_additive(old: dict, new: dict) -> None:
    """Raise AdditiveViolation unless groups.json `new` only adds to `old`.

    No member is removed, no member's effective name set (the union of its
    profiles' messages and attributes) shrinks, and no existing
    attribute_definitions entry changes. `max_version` / `_comment` may
    change and orphan profiles may be dropped.
    """
    new_members = new.get("members") or {}
    for key in old.get("members") or {}:
        if key not in new_members:
            raise AdditiveViolation(f"{GROUPS_FILE}: member {key!r} would be removed")
        lost = _effective_names(old, key) - _effective_names(new, key)
        if lost:
            raise AdditiveViolation(
                f"{GROUPS_FILE}: member {key!r} would lose names {sorted(lost)}"
            )
    new_definitions = new.get("attribute_definitions") or {}
    for attr, value in (old.get("attribute_definitions") or {}).items():
        if attr not in new_definitions or not _same(new_definitions[attr], value):
            raise AdditiveViolation(
                f"{GROUPS_FILE}: attribute definition {attr!r} would be removed or changed"
            )


def write_groups_file(path: str | Path, data: dict, db_root: str | Path) -> bool:
    """Write <db_root>/groups.json -- the only other DB-tree writer.

    Refuses any other path, refuses an existing file that is not in the
    canonical serialization, runs :func:`check_groups_additive`, and replaces
    the file atomically, keeping its mode (a new file gets the umask default).
    Returns False (writes nothing) on identical bytes.
    """
    root = Path(db_root).resolve()
    target = Path(path).resolve()
    if target != root / GROUPS_FILE:
        raise WriteRefused(f"refusing to write {target}: the groups writer only writes {root / GROUPS_FILE}")
    payload = canonical_groups_bytes(data)
    if target.exists():
        raw = target.read_bytes()
        old = json.loads(raw)
        if not isinstance(old, dict) or raw != canonical_groups_bytes(old):
            raise StyleUnreproducible(f"{target} is not in the canonical groups.json serialization")
        check_groups_additive(old, data)
        if payload == raw:
            return False
    atomic_write_bytes(target, payload)
    return True


IDIOMS_FILE = "idioms.json"

IDIOMS_COMMENT = (
    "Cords the installed Max bundle's own help patches ship (Q38): validation "
    "Layer 3 never type/role-checks a listed (source, outlet, class, "
    "destination, inlet) cord while index bounds are always checked, and only "
    "tools/sync_max_bundle.py --apply idioms writes this file, additively."
)
IDIOMS_GENERATOR = "tools/sync_max_bundle.py --apply idioms"
IDIOMS_SOURCE = "bundle help (*.maxhelp under Contents/Resources/C74)"


def _sorted_idiom_pairs(pairs: dict) -> dict:
    return {
        name: sorted(set(items), key=help_io._idiom_sort_key)
        for name, items in sorted(pairs.items())
    }


def canonical_idioms_bytes(data: dict) -> bytes:
    """The one serialization idioms.json is ever written in.

    Indent 2, ``ensure_ascii=False``, a trailing newline, top-level keys in
    the order given, ``pairs`` keys sorted and each list sorted by (outlet,
    class, destination, inlet).
    """
    out = dict(data)
    out["pairs"] = _sorted_idiom_pairs(data.get("pairs") or {})
    return (json.dumps(out, indent=2, ensure_ascii=False) + "\n").encode("utf-8")


def load_idioms(db_root: str | Path) -> dict | None:
    """The idioms.json on disk, or None when there is none.

    Raises StyleUnreproducible for a file that is not an object with a
    ``pairs`` object (this tool could not rewrite it faithfully).
    """
    path = Path(db_root) / IDIOMS_FILE
    if not path.exists():
        return None
    data = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(data, dict) or not isinstance(data.get("pairs"), dict):
        raise StyleUnreproducible(f"{path}: not an idioms file (object with a `pairs` object)")
    return data


def _idiom_items(data: dict | None) -> set[tuple[str, str]]:
    pairs = (data or {}).get("pairs") or {}
    return {(name, item) for name, items in pairs.items() for item in items}


def check_idioms_additive(old: dict, new: dict) -> None:
    """Raise AdditiveViolation if any committed pair is missing from `new`."""
    lost = sorted(_idiom_items(old) - _idiom_items(new))
    if lost:
        shown = ", ".join(f"{n}: {i}" for n, i in lost[:5])
        more = f" (+{len(lost) - 5} more)" if len(lost) > 5 else ""
        raise AdditiveViolation(f"{IDIOMS_FILE}: {len(lost)} pairs would be removed: {shown}{more}")


def write_idioms_file(path: str | Path, data: dict, db_root: str | Path) -> bool:
    """Write <db_root>/idioms.json -- its only writer (Q38).

    Refuses any other path (WriteRefused), refuses to drop a committed pair
    (:func:`check_idioms_additive`), writes :func:`canonical_idioms_bytes`
    atomically keeping the file's mode. Returns False (writes nothing) on
    identical bytes.
    """
    root = Path(db_root).resolve()
    target = Path(path).resolve()
    if target != root / IDIOMS_FILE:
        raise WriteRefused(f"refusing to write {target}: the idioms writer only writes {root / IDIOMS_FILE}")
    payload = canonical_idioms_bytes(data)
    if target.exists():
        old = load_idioms(root)
        check_idioms_additive(old, data)
        if payload == target.read_bytes():
            return False
    atomic_write_bytes(target, payload)
    return True


def build_idioms_target(scan: dict, existing: dict | None, install: dict) -> dict:
    """The idioms.json document: committed pairs united with the mined ones."""
    merged: dict[str, set[str]] = {}
    for source in ((existing or {}).get("pairs") or {}, scan.get("pairs") or {}):
        for name, items in source.items():
            merged.setdefault(name, set()).update(items)
    return {
        "_comment": IDIOMS_COMMENT,
        "generator": IDIOMS_GENERATOR,
        "max_version": install.get("short_version"),
        "source": IDIOMS_SOURCE,
        "pairs": _sorted_idiom_pairs(merged),
    }


_IDIOM_STATS = (
    "files", "cords", "recorded_cords", "excluded_cords", "unclassified_cords",
    "malformed_cords", "internal_patchers_skipped", "depth_capped",
)


def section_idioms(index: dict, db_root: str | Path) -> dict:
    """Dry-run section: mined pair count, committed count, pending pairs."""
    scan = help_io.scan_help_idioms(index["install"]["app_path"])
    if not scan.get("available"):
        return _unavailable(scan.get("reason") or "help scan unavailable")
    existing = load_idioms(db_root)
    mined = _idiom_items(scan)
    committed = _idiom_items(existing)
    return {
        "available": True,
        **{k: scan[k] for k in _IDIOM_STATS},
        "bad_files": scan["bad_files"],
        "pairs": len(mined),
        "committed": len(committed),
        "pending": len(mined - committed),
        "file": IDIOMS_FILE,
    }


def apply_idioms(index: dict, db_root: Path) -> dict:
    """--apply idioms: add every mined help cord key to idioms.json (additive)."""
    scan = help_io.scan_help_idioms(index["install"]["app_path"])
    if not scan.get("available"):
        raise OSError(f"cannot mine help cords: {scan.get('reason')}")
    existing = load_idioms(db_root)
    target = build_idioms_target(scan, existing, index["install"])
    added = len(_idiom_items(target) - _idiom_items(existing))
    written = write_idioms_file(Path(db_root) / IDIOMS_FILE, target, db_root)
    return {"written": written, "pairs": len(_idiom_items(target)), "added": added, "file": IDIOMS_FILE}


VERSION_IO_FILE = "version_io.json"

VERSION_IO_COMMENT = (
    "Per-version I/O changes mined from the installed Max bundle's help boxes "
    "(Q38): a change is recorded only when boxes of one name and argument list, "
    "saved by different Max versions, form a strict version-ordered partition "
    "of their (numinlets, numoutlets). validate_patch(target_version=...) warns "
    "on ports an older build lacks. Regenerated wholesale, only by "
    "tools/sync_max_bundle.py --apply version-io."
)
VERSION_IO_GENERATOR = "tools/sync_max_bundle.py --apply version-io"
VERSION_IO_SOURCE = "bundle help (*.maxhelp under Contents/Resources/C74), patcher.appversion"


def canonical_version_io_bytes(data: dict) -> bytes:
    """The one serialization version_io.json is ever written in.

    Indent 2, ``ensure_ascii=False``, a trailing newline, top-level keys in
    the order given and ``objects`` keys sorted.
    """
    out = dict(data)
    out["objects"] = dict(sorted((data.get("objects") or {}).items()))
    return (json.dumps(out, indent=2, ensure_ascii=False) + "\n").encode("utf-8")


def load_version_io(db_root: str | Path) -> dict | None:
    """The version_io.json on disk, or None when there is none."""
    path = Path(db_root) / VERSION_IO_FILE
    if not path.exists():
        return None
    data = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(data, dict) or not isinstance(data.get("objects"), dict):
        raise StyleUnreproducible(f"{path}: not a version_io file (object with an `objects` object)")
    return data


def write_version_io_file(path: str | Path, data: dict, db_root: str | Path) -> bool:
    """Write <db_root>/version_io.json -- its only writer (Q38).

    Refuses any other path (WriteRefused). Regenerates the file wholesale:
    it is mined evidence, not curation, so no additive check applies (the
    dry-run's +/-/~ counts are the review step). Atomic, keeps the file's
    mode; returns False (writes nothing) on identical bytes.
    """
    root = Path(db_root).resolve()
    target = Path(path).resolve()
    if target != root / VERSION_IO_FILE:
        raise WriteRefused(
            f"refusing to write {target}: the version-io writer only writes {root / VERSION_IO_FILE}"
        )
    payload = canonical_version_io_bytes(data)
    if target.exists() and target.read_bytes() == payload:
        return False
    atomic_write_bytes(target, payload)
    return True


def build_version_io_target(scan: dict, install: dict) -> dict:
    """The version_io.json document for one scan."""
    return {
        "_comment": VERSION_IO_COMMENT,
        "generator": VERSION_IO_GENERATOR,
        "max_version": install.get("short_version"),
        "source": VERSION_IO_SOURCE,
        "objects": dict(sorted((scan.get("objects") or {}).items())),
    }


def _scan_version_io(index: dict, db_root: str | Path) -> dict:
    return help_io.scan_version_io(
        index["install"]["app_path"], load_db(Path(db_root)),
        installed=index["install"].get("short_version"),
    )


def section_version_io(index: dict, db_root: str | Path) -> dict:
    """Dry-run section: mined names and +/-/~ against the committed file."""
    scan = _scan_version_io(index, db_root)
    if not scan.get("available"):
        return _unavailable(scan.get("reason") or "help scan unavailable")
    new = scan["objects"]
    old = (load_version_io(db_root) or {}).get("objects") or {}
    return {
        "available": True,
        "files": scan["files"],
        "bad_files": scan["bad_files"],
        "names": len(new),
        "objects": sorted(new),
        "newer_than_installed": sorted(
            n for n, e in new.items() if any(c.get("newer_than_installed") for c in e["changes"])
        ),
        "ambiguous_groups": scan["ambiguous_groups"],
        "ambiguous_names": scan["ambiguous_names"],
        "conflicting": scan["conflicting"],
        "added": len(set(new) - set(old)),
        "removed": len(set(old) - set(new)),
        "changed": sum(1 for n in set(new) & set(old) if not _same(new[n], old[n])),
        "file": VERSION_IO_FILE,
    }


def apply_version_io(index: dict, db_root: Path) -> dict:
    """--apply version-io: regenerate version_io.json wholesale from the bundle.

    Mined evidence, not curation: the file is rewritten from the scan each
    time (a name whose evidence vanished is dropped). Review the dry-run's
    +added -removed ~changed counts before applying.
    """
    scan = _scan_version_io(index, db_root)
    if not scan.get("available"):
        raise OSError(f"cannot mine help boxes: {scan.get('reason')}")
    target = build_version_io_target(scan, index["install"])
    written = write_version_io_file(Path(db_root) / VERSION_IO_FILE, target, db_root)
    return {"written": written, "names": len(target["objects"]), "file": VERSION_IO_FILE}


ALIASES_FILE = "aliases.json"


def write_aliases_file(db_root: str | Path, additions: dict[str, str]) -> bool:
    """Add `additions` to <db_root>/aliases.json -- its only writer (Q30 PD-6).

    Additive only: every existing top-level key and alias stays as it is
    (AdditiveViolation if an addition would change one); existing aliases
    keep their order and new ones are appended in name order. The file's own
    style is reproduced (StyleUnreproducible otherwise) and the replace is
    atomic and keeps the file's mode. Returns False (writes nothing) on
    identical bytes.
    """
    target = Path(db_root) / ALIASES_FILE
    raw = target.read_bytes()
    old = json.loads(raw)
    style = json_style(raw, old)
    if style is None:
        raise StyleUnreproducible(f"{target}: no indent-2 style reproduces the file")
    if not isinstance(old, dict) or not isinstance(old.get("aliases"), dict):
        raise StyleUnreproducible(f"{target}: not an aliases file (object with an `aliases` object)")
    new = copy.deepcopy(old)
    for name in sorted(additions):
        current = old["aliases"].get(name)
        if current is not None and current != additions[name]:
            raise AdditiveViolation(
                f"{ALIASES_FILE}: alias {name!r} would change ({current!r} -> {additions[name]!r})"
            )
        if current is None:
            new["aliases"][name] = additions[name]
    for key, value in old.items():
        if key == "aliases":
            continue
        if not _same(new.get(key), value):  # pragma: no cover -- defensive
            raise AdditiveViolation(f"{ALIASES_FILE}: top-level key {key!r} would change")
    ensure_ascii, trailing_newline = style
    payload = (
        json.dumps(new, indent=2, ensure_ascii=ensure_ascii) + ("\n" if trailing_newline else "")
    ).encode("utf-8")
    if payload == raw:
        return False
    atomic_write_bytes(target, payload)
    return True


def write_report(path: Path, payload: dict) -> None:
    """Write a --json / --snapshot-io document. `path` is already guarded."""
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(payload, indent=2, sort_keys=False) + "\n")


def guard_report_path(target: str | Path, repo_root: Path, db_root: Path) -> Path:
    """Refuse report targets under patches/, the repo DB tree, or the active DB root."""
    return guard_output_path(target, repo_root, db_root)


# ---------------------------------------------------------------------------
# Apply modes
# ---------------------------------------------------------------------------


def _core_destination(entry: dict) -> str | None:
    directory = DOMAIN_TO_DIR.get(entry.get("domain"))
    return f"{directory}/objects.json" if directory else None


def _abort(result: dict, reason: str) -> dict:
    result["status"] = "aborted"
    result["reason"] = reason
    result.pop("entry", None)
    return result


def _stem_refpage(index: dict, stem: str) -> dict | None:
    """The refpage FILE named after `stem`, whatever its name attribute says."""
    return next((ref for ref in index["refs"] if ref["stem"] == stem), None)


def _fresh_inlets(count: int, signal: bool) -> list[dict]:
    return [
        {"id": i, "type": "signal" if signal else "control", "signal": signal, "digest": ""}
        for i in range(count)
    ]


def _new_refpage_object(
    name: str, ref: dict, index: dict, db_root: Path, raw_db: dict
) -> tuple[dict, str | None]:
    """--apply new for one name: build the entry and pick its destination (S4)."""
    package_dir = None
    if ref["root"] == "package":
        # Bundled-package objects go to that package's DB file, which must
        # already exist -- this tool never creates a package.
        package_dir = db_package_dir(db_root, ref["package"] or "")
        if package_dir is None:
            return (
                _abort(
                    {"name": name, "source": ref["file"], "notes": {}},
                    f"bundle package {ref['package']!r} has no DB package directory "
                    "with an objects.json",
                ),
                None,
            )
    define = index["defines"].get(name)
    built = build_refpage_entry(
        name,
        ref,
        index,
        package_dir=package_dir,
        help_stems=(define["target"],) if define else (),
    )
    if built["status"] != "built":
        return built, None
    if package_dir is not None:
        rel = f"packages/{package_dir}/objects.json"
    else:
        rel = _core_destination(built["entry"])
    if rel is None or rel not in raw_db:
        return (
            _abort(built, f"no writable destination for domain {built['entry'].get('domain')!r}"),
            None,
        )
    return built, rel


def build_define_entry(
    alias: str, index: dict, db: ObjectDatabase, raw_db: dict, db_root: Path
) -> tuple[dict, str | None]:
    """--apply define for one alias: mapping line + help-patch box (S5, S6).

    I/O counts and outlet types come from the help box Max serialized.
    Descriptive fields come from the refpage whose filename stem is the alias
    (whatever its name attribute says), else messages / attributes are
    inherited from the define target's resolved DB entry.
    """
    result: dict = {"name": alias, "status": "aborted", "notes": {}}
    define = index["defines"].get(alias)
    if define is None:
        return _abort(result, f"no `max define {alias} ...` mapping line in the bundle"), None
    result["source"] = define["mapping_file"]
    result["notes"]["define"] = define["line"]
    if index.get("version") is None:
        return _abort(result, "installed Max version is not parseable as major.minor"), None

    evidence = find_help_boxes(index, alias, (define["target"],))
    boxes = evidence["boxes"]
    result["notes"]["help_boxes"] = len(boxes)
    if not boxes:
        return (
            _abort(
                result,
                f"no help-patch box found for {alias!r} (searched {alias}.maxhelp, "
                f"then {define['target']}.maxhelp)",
            ),
            None,
        )
    counts = sorted({(b["numinlets"], b["numoutlets"]) for b in boxes})
    if len(counts) > 1:
        return _abort(result, f"help boxes disagree on inlet/outlet counts: {counts}"), None
    num_in, num_out = counts[0]
    result["notes"]["io_source"] = f"{evidence['help_stem']}.maxhelp: counts and outlet types"

    target = _muted_lookup(db, define["target"])
    ref = _stem_refpage(index, alias)
    refpage_outlets: list[dict] = []
    if ref is not None:
        parsed = parse_refpage(ref)
        if parsed is None or "_error" in parsed:
            return _abort(result, f"alias refpage did not parse: {ref['file']}"), None
        entry = copy.deepcopy(parsed)
        entry["name"] = alias
        result["notes"]["refpage"] = ref["file"]
        result["notes"]["scrubbed"] = scrub_templates(entry)  # C2
        _type_inlets(entry, ref)  # C3
        named = _muted_lookup(db, ref["name"]) if ref["name"] != alias else None
        if named is not None and entry["messages"] and entry["messages"] == named.get("messages"):
            # A refpage cloned from the implementing class documents that
            # class, not the alias.
            entry["messages"] = []
            entry["attributes"] = {}
            result["notes"]["cloned_template"] = (
                f"refpage message list is identical to {ref['name']!r}'s DB entry; "
                "messages and attributes left empty"
            )
        if len(entry["inlets"]) != num_in:
            result["notes"]["refpage_inlets_ignored"] = (
                f"refpage declares {len(entry['inlets'])} inlets, help box has {num_in}"
            )
            entry["inlets"] = _fresh_inlets(num_in, "signal" in (ref.get("methods") or []))
        if len(entry["outlets"]) == num_out:
            refpage_outlets = entry["outlets"]
        elif entry["outlets"]:
            result["notes"]["refpage_outlets_ignored"] = (
                f"refpage declares {len(entry['outlets'])} outlets, help box has {num_out}"
            )
    else:
        if target is None:
            return (
                _abort(
                    result,
                    f"define target {define['target']!r} is not in the DB and the alias "
                    "has no refpage to describe it",
                ),
                None,
            )
        messages = list(target.get("messages") or [])
        digest = " ".join(part for part in (target.get("digest", ""), f"({define['line']})") if part)
        entry = {
            "name": alias,
            "maxclass": "newobj",
            "module": target.get("module", "max"),
            "domain": target.get("domain"),
            "category": target.get("category", ""),
            "digest": digest,
            "description": "",
            "inlets": _fresh_inlets(num_in, "signal" in messages),
            "outlets": [],
            "arguments": [],
            "messages": messages,
            "attributes": copy.deepcopy(target.get("attributes") or {}),
            "seealso": [],
            "tags": [],
            "variable_io": False,
        }
        result["notes"]["inherited_from"] = define["target"]

    outlettypes = boxes[0]["outlettype"]
    entry["outlets"] = [
        outlet_from_help(  # C4
            i,
            outlettypes[i] if i < len(outlettypes) else "",
            refpage_outlets[i].get("digest", "") if i < len(refpage_outlets) else "",
        )
        for i in range(num_out)
    ]
    entry["maxclass"] = "newobj"
    _hot_flags(entry)  # C7
    entry["rnbo_compatible"] = False  # C1
    entry["min_version"] = index["version"]  # C5
    entry["verified"] = bool(entry["inlets"] or entry["outlets"])

    # S4: the package that owns the mapping line, else the core domain file
    # that holds the define target (precedent: jit.gl.movie beside jit.movie).
    if define["package"] is not None:
        package_dir = db_package_dir(db_root, define["package"])
        if package_dir is None:
            return (
                _abort(
                    result,
                    f"bundle package {define['package']!r} has no DB package directory "
                    "with an objects.json",
                ),
                None,
            )
        entry["domain"] = "Packages"  # C6
        entry["package"] = package_dir
        rel = f"packages/{package_dir}/objects.json"
    else:
        located = locate_base_entry(target, define["target"], raw_db) if target else None
        if located is None or located[0].startswith("packages/"):
            return (
                _abort(
                    result,
                    f"define target {define['target']!r} is not held by a writable core "
                    "domain file",
                ),
                None,
            )
        rel = located[0]
        entry["domain"] = target.get("domain")

    result["status"] = "built"
    result["entry"] = entry
    return result, rel


def stage_package_counts(
    db_root: Path, staged: dict[str, dict], packages: set[str]
) -> tuple[dict | None, list[str]]:
    """package_info.json with `object_count` set from the STAGED package files (Q30 PD-5).

    `staged` maps DB-relative paths to the data about to be written; counts
    come from it, not from re-reading disk, so the object files and the count
    update land in one :func:`write_db_files` transaction. Returns
    ``(new_info, changed_packages)``; new_info is None when nothing changes or
    there is no package_info.json.
    """
    info_path = db_root / "package_info.json"
    if not info_path.exists():
        return None, []
    info = json.loads(info_path.read_text())
    changed: list[str] = []
    for package in sorted(packages):
        row = info.get(package)
        if not isinstance(row, dict) or "object_count" not in row:
            continue
        rel = f"packages/{package}/objects.json"
        data = staged.get(rel)
        if data is None:
            data = json.loads((db_root / rel).read_text())
        count = len(data)
        if row["object_count"] != count:
            row["object_count"] = count
            changed.append(package)
    return (info if changed else None), changed


def parse_min_version(text: str) -> str:
    """`--min-version` value: a Max major (`8`) or major.minor (`9.2`), 4 <= major < 10.

    Returns the canonical version STRING (Q30 PD-3): "8", "9.1", "9.10" --
    a float would turn 9.10 into 9.1. Each part goes through int().
    """
    text = text.strip()
    if not re.fullmatch(r"\d+(\.\d+)?", text):
        raise argparse.ArgumentTypeError(f"not a Max version: {text!r}")
    parts = [int(part) for part in text.split(".")]
    if not 4 <= parts[0] < 10:
        raise argparse.ArgumentTypeError(f"outside the supported range 4 <= v < 10: {text!r}")
    return ".".join(str(part) for part in parts)


def apply_objects(
    modes: list[str],
    names: list[str],
    index: dict,
    db_root: Path,
    min_version: str | None = None,
) -> list[dict]:
    """--apply new / --apply define: land explicitly named objects only.

    `min_version` (a version string) replaces C5's default (the installed
    major.minor) on every object landed by this call. It exists for objects
    the bundle has shipped since an earlier release and the DB only now picks
    up: tagging those with the installed version would claim they need it.

    Every destination file and the package_info.json count update are written
    in ONE :func:`write_db_files` call: all of them or none (Q30 PD-5).
    """
    db = load_db(db_root)
    raw_db = load_raw_db(db_root)
    classified = classify_refs(index, db, db_root)
    results: list[dict] = []
    pending: dict[str, dict[str, dict]] = {}

    for name in names:
        if _muted_lookup(db, name) is not None:
            results.append({"name": name, "status": "skipped", "reason": "already in the DB"})
            continue
        ref = classified["authoritative"].get(name)
        if "new" in modes and ref is not None and not _is_doc_page(ref):
            built, rel = _new_refpage_object(name, ref, index, db_root, raw_db)
        elif "define" in modes:
            built, rel = build_define_entry(name, index, db, raw_db, db_root)
        else:
            built, rel = (
                _abort(
                    {"name": name, "notes": {}},
                    "not a new refpage-backed object in this bundle (documentation "
                    "page, alias document, or unknown name)",
                ),
                None,
            )
        if built["status"] != "built" or rel is None:
            results.append(built)
            continue

        # C6: the new entry must look exactly like its neighbours.
        template = match_key_template(built["entry"], raw_db[rel])
        if template is None:
            results.append(_abort(built, f"key set does not match any existing entry in {rel}"))
            continue
        entry = order_like(built.pop("entry"), template)
        if min_version is not None:
            entry["min_version"] = min_version
            built["notes"]["min_version"] = f"{min_version} (explicit --min-version)"
        pending.setdefault(rel, {})[name] = entry
        built["status"] = "written"
        built["file"] = rel
        built["io"] = [len(entry["inlets"]), len(entry["outlets"])]
        results.append(built)

    staged: dict[str, dict] = {}
    for rel, entries in pending.items():
        data = dict(raw_db[rel])
        data.update(entries)
        staged[rel] = data
    touched_packages = {rel.split("/")[1] for rel in pending if rel.startswith("packages/")}
    items = [(db_root / rel, data) for rel, data in staged.items()]
    if touched_packages:
        info, _changed = stage_package_counts(db_root, staged, touched_packages)
        if info is not None:
            items.append((db_root / "package_info.json", info))
    if items:
        write_db_files(items, db_root)
    return results


def apply_deltas(index: dict, db_root: Path, names: list[str] | None) -> dict:
    """--apply deltas: append the documented messages / attributes.

    Every touched file is written in one all-or-nothing :func:`write_db_files` call.
    """
    db = load_db(db_root)
    raw_db = load_raw_db(db_root)
    classified = classify_refs(index, db, db_root)
    deltas = compute_deltas(index, classified, db, raw_db)
    touched: dict[str, dict] = {}
    applied = {"objects": 0, "messages": 0, "attributes": 0, "files": []}
    for item in deltas["objects"]:
        if names is not None and item["name"] not in names:
            continue
        data = touched.setdefault(item["file"], copy.deepcopy(raw_db[item["file"]]))
        entry = data[item["name"]]
        if item["messages"]:
            entry["messages"] = list(entry["messages"]) + item["messages"]
        for attr, value in item["attributes"].items():
            entry["attributes"][attr] = value
        applied["objects"] += 1
        applied["messages"] += len(item["messages"])
        applied["attributes"] += len(item["attributes"])
    applied["files"] = sorted(
        write_db_files([(db_root / rel, data) for rel, data in touched.items()], db_root)
    )
    return applied


def apply_inherited(
    index: dict, db_root: Path, attributes: list[str], names: list[str] | None
) -> dict:
    """--apply inherited: add the NAMED group-page attributes where refpages list them.

    Every touched file is written in one all-or-nothing :func:`write_db_files` call.
    """
    db = load_db(db_root)
    raw_db = load_raw_db(db_root)
    classified = classify_refs(index, db, db_root)
    inherited = compute_inherited(index, classified, db, raw_db, groups=load_groups(db_root))
    wanted = set(attributes)
    touched: dict[str, dict] = {}
    applied = {"objects": [], "attributes": 0, "files": []}
    applied["not_offered"] = sorted(wanted - set(inherited["by_attribute"]))
    for item in inherited["_pending"]:
        if names is not None and item["name"] not in names:
            continue
        chosen = {k: v for k, v in item["attributes"].items() if k in wanted}
        if not chosen:
            continue
        data = touched.setdefault(item["file"], copy.deepcopy(raw_db[item["file"]]))
        data[item["name"]]["attributes"].update(chosen)
        applied["objects"].append(item["name"])
        applied["attributes"] += len(chosen)
    applied["files"] = sorted(
        write_db_files([(db_root / rel, data) for rel, data in touched.items()], db_root)
    )
    return applied


def _override_keys(db_root: Path) -> set[str]:
    """The literal ``objects`` keys of <db_root>/overrides.json (read only)."""
    path = Path(db_root) / "overrides.json"
    if not path.exists():
        return set()
    data = json.loads(path.read_text(encoding="utf-8"))
    objects = data.get("objects") if isinstance(data, dict) else None
    return set(objects) if isinstance(objects, dict) else set()


def apply_aliases(index: dict, db_root: Path, names: list[str], shadowed: bool = False) -> list[dict]:
    """--apply aliases: add NAMED objectfile aliases to aliases.json (Q30 PD-6).

    Per name: a name lookup() already resolves is skipped -- except, with
    ``shadowed`` (``--shadowed``, Q38), a name whose only resolution is an
    RNBO / Gen entry (the list.* family Max instantiates as zl.*), which
    proceeds as if unresolved and is aborted when its candidate is itself
    RNBO / Gen. A name keyed in overrides.json ``objects`` is always aborted:
    override keys canonicalise through aliases, so an alias would silently
    retarget that override onto the candidate. No objectfile line, no
    candidate, or help boxes that disagree with the candidate's counts abort
    it; otherwise ``aliases[name] = candidate``. After the write the DB must
    load and resolve every written alias to its candidate, else the original
    bytes are restored and AliasVerificationFailed is raised.
    """
    db = load_db(db_root)
    records = (index.get("objectfiles") or {}).get("records", {})
    override_keys = _override_keys(db_root)
    results: list[dict] = []
    additions: dict[str, str] = {}
    for name in names:
        result: dict = {"name": name, "status": "aborted", "notes": {}}
        hit = _muted_lookup(db, name)
        shadow_hit = hit is not None and shadowed and hit.get("domain") in _RNBO_GEN_DOMAINS
        if hit is not None and not shadow_hit:
            results.append(
                {
                    "name": name,
                    "status": "skipped",
                    "reason": f"already resolves in the DB (domain {hit.get('domain')})",
                }
            )
            continue
        if shadow_hit:
            result["notes"]["shadowed_domain"] = hit.get("domain")
        record = records.get(name)
        if record is None:
            results.append(_abort(result, f"no `max objectfile {name} ...` line in the bundle"))
            continue
        result["source"] = record["mapping_file"]
        result["notes"]["objectfile"] = record["line"]
        candidate, basis = objectfile_candidate(record, db, records)
        if candidate is None:
            results.append(_abort(result, "no candidate target the DB resolves"))
            continue
        if name in override_keys:
            results.append(
                _abort(
                    result,
                    f"overrides.json has an entry keyed {name}; an alias would retarget "
                    f"it onto {candidate} -- remove or move it first",
                )
            )
            continue
        if shadow_hit:
            cand_domain = (_muted_lookup(db, candidate) or {}).get("domain")
            if cand_domain in _RNBO_GEN_DOMAINS:
                results.append(
                    _abort(
                        result,
                        f"candidate {candidate!r} is itself a {cand_domain} entry; "
                        "an alias would not reach a Max object",
                    )
                )
                continue
        evidence = objectfile_evidence(index, db, name, candidate)
        result["notes"].update(evidence)
        if evidence["help_io_agrees"] is False:
            results.append(
                _abort(
                    result,
                    f"help boxes {evidence['help_io']} disagree with {candidate!r} I/O counts",
                )
            )
            continue
        additions[name] = candidate
        result.update({"status": "written", "target": candidate, "basis": basis, "file": ALIASES_FILE})
        results.append(result)

    if additions:
        path = Path(db_root) / ALIASES_FILE
        original = path.read_bytes()
        if write_aliases_file(db_root, additions):
            try:
                reloaded = load_db(db_root)
                bad = [
                    name
                    for name, candidate in additions.items()
                    if (_muted_lookup(reloaded, name) or {}).get("name") != candidate
                ]
                reason = f"aliases did not resolve to their candidates: {bad}" if bad else None
            except Exception as exc:  # noqa: BLE001 -- any load failure means restore
                reason = f"the DB did not load after the write: {type(exc).__name__}: {exc}"
            if reason is not None:
                atomic_write_bytes(path, original)
                raise AliasVerificationFailed(f"{ALIASES_FILE} restored -- {reason}")
    return results


def apply_groups(index: dict, db_root: Path) -> dict:
    """--apply groups: (re)write groups.json from the bundle's group lists."""
    db = load_db(db_root)
    raw_db = load_raw_db(db_root)
    classified = classify_refs(index, db, db_root)
    report = compute_groups(index, classified, db, raw_db, load_groups(db_root))
    written = write_groups_file(Path(db_root) / GROUPS_FILE, report["_target"], db_root)
    return {
        "written": written,
        "members": report["members"],
        "profiles": report["profiles"],
        "names_added": report["pending_names"],
        "file": GROUPS_FILE,
    }


# ---------------------------------------------------------------------------
# Extraction log
# ---------------------------------------------------------------------------

EXTRACTION_LOG = "extraction-log.json"

# What a superseded log state keeps in `history`.
_LOG_HISTORY_FIELDS = (
    "extraction_timestamp",
    "total_files_found",
    "total_objects",
    "domain_counts",
    "max_version",
    "max_build",
)


def restate_extraction_log(
    db_root: Path, old: dict, now: _dt.datetime, extra: dict | None = None
) -> dict:
    """The extraction log re-stated from the DB on disk (Q30 PD-7).

    The log's own fields keep their names, order and meaning: counts are
    recomputed over every ``objects.json`` the DB holds, with the traversal
    ``tests/conftest.py`` and ``tools/audit_db.py`` use. Fields that cannot be
    recomputed (``errors``, ``error_count``, ``inlet_type_fallback_count``,
    ``max_installation_path``) are carried over, every other old key is kept,
    then ``extra`` is applied. The superseded state is appended to
    ``history``; nothing recorded there is ever dropped. Shared by
    ``--refresh-log`` and ``.claude/scripts/extract_objects.py``.
    """
    files = [db_root / domain / "objects.json" for domain in CORE_DOMAIN_DIRS]
    pkg_root = db_root / "packages"
    if pkg_root.is_dir():
        files.extend(sorted(d / "objects.json" for d in pkg_root.iterdir() if d.is_dir()))
    files = [path for path in files if path.exists()]
    variable_io = empty_inlets = empty_outlets = 0
    for path in files:
        for entry in json.loads(path.read_text()).values():
            if not isinstance(entry, dict):
                continue
            variable_io += bool(entry.get("variable_io"))
            empty_inlets += not entry.get("inlets")
            empty_outlets += not entry.get("outlets")
    live = _live_domain_counts(db_root)
    # Keep the log's own domain order; domains it never listed go last.
    order = [*(old.get("domain_counts") or {}), *CORE_DOMAIN_DIRS, "packages"]
    domain_counts = {d: live[d] for d in dict.fromkeys(order) if d in live}

    history = list(old.get("history") or [])
    if old:
        history.append({k: old[k] for k in _LOG_HISTORY_FIELDS if k in old})

    log = dict(old)
    log.update(
        {
            "total_files_found": len(files),
            "total_objects": sum(domain_counts.values()),
            "domain_counts": domain_counts,
            "error_count": old.get("error_count", 0),
            "errors": old.get("errors", []),
            "inlet_type_fallback_count": old.get("inlet_type_fallback_count", 0),
            "variable_io_count": variable_io,
            "empty_inlets_count": empty_inlets,
            "empty_outlets_count": empty_outlets,
            "extraction_timestamp": now.isoformat(),
            "max_installation_path": old.get("max_installation_path", str(db_root)),
        }
    )
    if extra:
        log.update(extra)
    log["history"] = history
    return log


def build_extraction_log(db_root: Path, report: dict, old: dict, now: _dt.datetime) -> dict:
    """The extraction log re-stated from the DB on disk, after a sync.

    :func:`restate_extraction_log` plus this sync's record: the installed Max
    version and build and the ``sync`` summary.
    """
    sections = report["sections"]
    install = sections["install"]
    return restate_extraction_log(
        db_root,
        old,
        now,
        extra={
            "max_version": install.get("short_version"),
            "max_build": install.get("build_id"),
            "sync": {
                "tool": "tools/sync_max_bundle.py --refresh-log",
                "refpage_files": report.get("refpage_files"),
                "pending_new_objects": len(sections["new_objects"]["names"]),
                "documentation_pages": len(sections["new_objects"]["doc_pages"]),
                "define_missing": sections["define_missing"]["names"],
                "pending_messages": sections["deltas"]["pending_messages"],
                "pending_attributes": sections["deltas"]["pending_attributes"],
                "group_members": sections.get("groups", {}).get("members"),
                "pending_group_names": sections.get("groups", {}).get("pending_names"),
            },
        },
    )


def write_extraction_log(db_root: Path, log: dict) -> Path:
    """Replace <db-root>/extraction-log.json atomically. The path is not a parameter.

    The replace keeps an existing log's mode; a new log gets the umask default.
    """
    target = Path(db_root) / EXTRACTION_LOG
    payload = (json.dumps(log, indent=2, ensure_ascii=False) + "\n").encode("utf-8")
    atomic_write_bytes(target, payload)
    return target


def refresh_extraction_log(db_root: Path, report: dict, now: _dt.datetime | None = None) -> dict:
    """--refresh-log: record this sync in the extraction log."""
    path = Path(db_root) / EXTRACTION_LOG
    try:
        old = json.loads(path.read_text())
    except FileNotFoundError:
        old = {}
    if not isinstance(old, dict):
        raise StyleUnreproducible(f"{path} is not a JSON object; refusing to replace it")
    log = build_extraction_log(Path(db_root), report, old, now or _dt.datetime.now(_dt.timezone.utc))
    write_extraction_log(Path(db_root), log)
    return log


# ---------------------------------------------------------------------------
# I/O regression guard
# ---------------------------------------------------------------------------


def snapshot_io(db_root: Path) -> dict:
    """Inlets and outlets that lookup() returns, for every name in the DB."""
    db = load_db(db_root)
    names: set[str] = set()
    for data in load_raw_db(db_root).values():
        names.update(data)
    snapshot = {}
    for name in sorted(names):
        obj = _muted_lookup(db, name)
        if obj is None:
            continue
        snapshot[name] = {"inlets": obj.get("inlets", []), "outlets": obj.get("outlets", [])}
    return {"tool": "sync_max_bundle", "kind": "io_snapshot", "objects": snapshot}


def compare_io(db_root: Path, before: dict) -> list[dict]:
    """Names in the snapshot whose inlets or outlets now differ (or vanished)."""
    current = snapshot_io(db_root)["objects"]
    changed = []
    for name, old in before.get("objects", {}).items():
        new = current.get(name)
        if new is None:
            changed.append({"name": name, "change": "no longer resolves"})
        elif not _same(old, new):
            changed.append({"name": name, "change": "inlets or outlets differ"})
    return changed


# ---------------------------------------------------------------------------
# Text summary
# ---------------------------------------------------------------------------


def format_summary(report: dict) -> str:
    s = report["sections"]
    install = s["install"]
    lines = ["Max bundle sync (bundle vs .claude/max-objects)"]
    if not install.get("available"):
        lines.append(f"  install         : bundle unavailable -- {install.get('reason')}")
        lines.append("  (nothing to compare; DB untouched)")
        return "\n".join(lines)
    lines.append(
        f"  install         : Max {install.get('short_version')} "
        f"(build {install.get('build_id')})"
    )
    lines.append(
        f"  refpages        : {report.get('refpage_files')} files, "
        f"{len(report.get('parse_errors', []))} parse errors"
    )
    new = s["new_objects"]
    lines.append(
        f"  new objects     : {len(new['names'])}"
        + (f": {', '.join(new['names'])}" if new["names"] else "")
        + f" (+{len(new['doc_pages'])} documentation pages)"
    )
    missing = s["define_missing"]
    lines.append(
        f"  define missing  : {missing['count']}"
        + (f": {', '.join(missing['names'])}" if missing["names"] else "")
    )
    of = s["objectfile_aliases"]
    lines.append(
        f"  objectfile      : {of['lines']} lines, {of['names']} names, "
        f"{of['unresolved_count']} unresolved ("
        + ", ".join(f"{k} {v}" for k, v in of["by_basis"].items())
        + f"), {len(of['domain_shadowed'])} RNBO/Gen-shadowed "
        "(report-only; --apply aliases --names NAME)"
    )
    d = s["deltas"]
    lines.append(
        f"  deltas          : {d['object_count']} objects -- "
        f"{d['pending_messages']} messages on {d['objects_gaining_messages']}, "
        f"{d['pending_attributes']} attributes on {d['objects_gaining_attributes']}"
    )
    inherited = s["inherited_attributes"]
    lines.append(
        f"  inherited attrs : {len(inherited['by_attribute'])} group-page attributes "
        f"unrecorded on {inherited['object_count']} objects (report-only; "
        "--apply inherited --attributes NAME)"
    )
    groups = s["groups"]
    by_family = groups["by_family"]
    lines.append(
        f"  groups          : {groups['members']} members (mc {by_family.get('mc', 0)} / "
        f"jit {by_family.get('jit', 0)} / thispatcher {by_family.get('thispatcher', 0)}), "
        f"{groups['profiles']} profiles, +{groups['pending_names']} names pending "
        "(--apply groups)"
    )
    idioms = s["idioms"]
    if idioms.get("available"):
        lines.append(
            f"  idioms          : {idioms['pairs']} pairs from {idioms['recorded_cords']} help cords "
            f"({idioms['excluded_cords']} excluded, {idioms['unclassified_cords']} unclassified), "
            f"+{idioms['pending']} pending (--apply idioms)"
        )
    else:
        lines.append(f"  idioms          : unavailable ({idioms.get('reason')})")
    vio = s["version_io"]
    if vio.get("available"):
        lines.append(
            f"  version io      : {vio['names']} names with per-version I/O changes "
            f"({vio['ambiguous_groups']} ambiguous arg groups, {len(vio['conflicting'])} conflicting); "
            f"+{vio['added']} -{vio['removed']} ~{vio['changed']} vs version_io.json "
            "(--apply version-io)"
        )
    else:
        lines.append(f"  version io      : unavailable ({vio.get('reason')})")
    lines.append(f"  collisions      : {s['collisions']['count']} (reported, ignored)")
    lines.append(f"  alias documents : {s['alias_docs']['count']}")
    shadow = s["shadowed_by_override"]
    lines.append(
        f"  shadowed by override: {shadow['count']} objects, "
        f"{len(shadow['with_missing_names'])} lacking refpage names"
        + (f": {', '.join(shadow['with_missing_names'])}" if shadow["with_missing_names"] else "")
    )
    ui = s["ui_maxclasses"]
    lines.append(
        f"  ui maxclasses   : {len(ui['survey_set'])} in bundle survey "
        f"({ui['files_scanned']} files); "
        f"{len(ui['missing_from_ui_set'])} missing from UI_MAXCLASSES"
        + (f": {', '.join(ui['missing_from_ui_set'])}" if ui["missing_from_ui_set"] else "")
        + f"; {len(ui['newobj_only_in_bundle'])} UI entries MAX writes only as newobj"
        + (f": {', '.join(ui['newobj_only_in_bundle'])}" if ui["newobj_only_in_bundle"] else "")
        + f"; {len(ui['unobserved_in_bundle'])} unobserved (report-only)"
    )
    return "\n".join(lines)


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="sync_max_bundle.py",
        description=(
            "Report (default) and additively apply the difference between the "
            "installed Max bundle and .claude/max-objects/."
        ),
    )
    parser.add_argument("--repo-root", default=None, help="Repository root (default: this repo).")
    parser.add_argument(
        "--db-root", default=None, help="Object DB root (default: <repo-root>/.claude/max-objects)."
    )
    parser.add_argument(
        "--max-app", default=str(DEFAULT_MAX_APP), help="Installed Max application bundle."
    )
    parser.add_argument("--json", dest="json_path", default=None, help="Write the full JSON report here.")
    parser.add_argument(
        "--apply",
        action="append",
        choices=APPLY_MODES,
        default=[],
        help=(
            "Apply mode; repeatable. new / define / aliases require --names; inherited "
            "requires --attributes; groups takes no allow-list and writes only "
            "groups.json; aliases writes only aliases.json; idioms takes no "
            "allow-list and writes only idioms.json; version-io takes no "
            "allow-list and regenerates only version_io.json."
        ),
    )
    parser.add_argument(
        "--names",
        nargs="+",
        default=None,
        help="Explicit allow-list of object names (mandatory for new, define and aliases).",
    )
    parser.add_argument(
        "--shadowed",
        action="store_true",
        help=(
            "With --apply aliases only: let an alias replace an RNBO/Gen-only "
            "resolution, for names `max objectfile` maps to a Max object (the "
            "list.* family -> zl.*)."
        ),
    )
    parser.add_argument(
        "--attributes",
        nargs="+",
        default=None,
        help="Explicit allow-list of group-page attribute names (mandatory for inherited).",
    )
    parser.add_argument(
        "--min-version",
        type=parse_min_version,
        default=None,
        help=(
            "min_version for the objects landed by --apply new / define "
            "(default: the installed major.minor). Use for objects that predate "
            "the installed Max."
        ),
    )
    parser.add_argument(
        "--refresh-log",
        action="store_true",
        help=(
            "Re-state extraction-log.json from the DB on disk (counts, timestamp, "
            "installed Max version) after any apply in this run; the superseded "
            "state is appended to its history."
        ),
    )
    parser.add_argument("--snapshot-io", default=None, help="Write an I/O snapshot of every DB name.")
    parser.add_argument(
        "--compare-io", default=None, help="Exit non-zero if any snapshotted name's I/O changed."
    )
    return parser


def main(argv: list[str] | None = None) -> int:
    args = build_parser().parse_args(argv)
    repo_root = Path(args.repo_root) if args.repo_root else ROOT
    db_root = Path(args.db_root) if args.db_root else repo_root / ".claude" / "max-objects"
    modes = list(dict.fromkeys(args.apply))

    # Screen every report path before doing any work.
    try:
        json_path = guard_report_path(args.json_path, repo_root, db_root) if args.json_path else None
        snapshot_path = (
            guard_report_path(args.snapshot_io, repo_root, db_root) if args.snapshot_io else None
        )
    except OutputPathRejected as exc:
        print(f"error: {exc}", file=sys.stderr)
        return 2

    object_modes = [m for m in modes if m in ("new", "define")]
    if object_modes and not args.names:
        print(
            "error: --apply new / --apply define require --names: this tool never "
            "lands an object nobody named.",
            file=sys.stderr,
        )
        return 2
    if "aliases" in modes and not args.names:
        print(
            "error: --apply aliases requires --names: objectfile aliases land only by name.",
            file=sys.stderr,
        )
        return 2
    if args.shadowed and "aliases" not in modes:
        print("error: --shadowed applies only to --apply aliases.", file=sys.stderr)
        return 2
    if "inherited" in modes and not args.attributes:
        print(
            "error: --apply inherited requires --attributes: inherited group "
            "attributes land only by name.",
            file=sys.stderr,
        )
        return 2
    if args.min_version is not None and not object_modes:
        print("error: --min-version applies only to --apply new / --apply define.", file=sys.stderr)
        return 2
    exit_code = 0
    applied: dict = {}
    index = build_bundle_index(args.max_app)

    if modes:
        if not index["available"]:
            print(f"error: cannot apply -- {index['reason']}", file=sys.stderr)
            exit_code = 1
        else:
            try:
                if object_modes:
                    applied["objects"] = apply_objects(
                        object_modes, args.names, index, db_root, args.min_version
                    )
                    if any(r["status"] == "aborted" for r in applied["objects"]):
                        exit_code = 1
                if "deltas" in modes:
                    applied["deltas"] = apply_deltas(
                        index, db_root, args.names if not object_modes else None
                    )
                if "inherited" in modes:
                    applied["inherited"] = apply_inherited(
                        index, db_root, args.attributes, args.names if not object_modes else None
                    )
                if "groups" in modes:
                    applied["groups"] = apply_groups(index, db_root)
                if "idioms" in modes:
                    applied["idioms"] = apply_idioms(index, db_root)
                if "version-io" in modes:
                    applied["version_io"] = apply_version_io(index, db_root)
                if "aliases" in modes:
                    applied["aliases"] = apply_aliases(
                        index, db_root, args.names, shadowed=args.shadowed
                    )
                    if any(r["status"] == "aborted" for r in applied["aliases"]):
                        exit_code = 1
            except (
                WriteRefused,
                AdditiveViolation,
                StyleUnreproducible,
                AliasVerificationFailed,
                OSError,
            ) as exc:
                print(f"error: {type(exc).__name__}: {exc}", file=sys.stderr)
                return 2

    report = run_report(db_root, args.max_app, index=index)
    if applied:
        report["applied"] = applied

    print(format_summary(report))
    for result in applied.get("objects", []):
        detail = result.get("reason") or result.get("notes", {}).get("io_source", "")
        where = f" -> {result['file']} {result['io']}" if result["status"] == "written" else ""
        print(f"  {result['status']:8s}: {result['name']}{where}" + (f" ({detail})" if detail else ""))
    for result in applied.get("aliases", []):
        detail = result.get("reason") or result.get("basis", "")
        where = f" -> {result['target']}" if result["status"] == "written" else ""
        print(f"  alias {result['status']:8s}: {result['name']}{where}" + (f" ({detail})" if detail else ""))
    if "deltas" in applied:
        a = applied["deltas"]
        print(
            f"  applied deltas  : {a['messages']} messages, {a['attributes']} attributes "
            f"on {a['objects']} objects in {len(a['files'])} files"
        )

    if "inherited" in applied:
        a = applied["inherited"]
        print(
            f"  applied inherited: {a['attributes']} attributes on {len(a['objects'])} "
            f"objects in {len(a['files'])} files"
            + (f"; no refpage offers: {', '.join(a['not_offered'])}" if a["not_offered"] else "")
        )

    if "groups" in applied:
        a = applied["groups"]
        if a["written"]:
            print(
                f"  applied groups  : {a['file']} -- {a['members']} members, "
                f"{a['profiles']} profiles, +{a['names_added']} names"
            )
        else:
            print(f"  applied groups  : {a['file']} unchanged")

    if "idioms" in applied:
        a = applied["idioms"]
        if a["written"]:
            print(f"  applied idioms  : {a['file']} -- {a['pairs']} pairs, +{a['added']} added")
        else:
            print(f"  applied idioms  : {a['file']} unchanged ({a['pairs']} pairs)")

    if "version_io" in applied:
        a = applied["version_io"]
        state = "written" if a["written"] else "unchanged"
        print(f"  applied version io: {a['file']} {state} -- {a['names']} names")

    if args.refresh_log:
        if not index["available"]:
            print(f"error: cannot refresh the log -- {index['reason']}", file=sys.stderr)
            exit_code = 1
        else:
            try:
                log = refresh_extraction_log(db_root, report)
            except (StyleUnreproducible, OSError, ValueError) as exc:
                print(f"error: {type(exc).__name__}: {exc}", file=sys.stderr)
                return 2
            print(
                f"  extraction log  : {log['total_objects']} objects in "
                f"{log['total_files_found']} files, Max {log['max_version']}, "
                f"{len(log['history'])} earlier states kept"
            )

    if json_path is not None:
        write_report(json_path, report)
        print(f"  json            : {json_path}")

    if snapshot_path is not None:
        snapshot = snapshot_io(db_root)
        write_report(snapshot_path, snapshot)
        print(f"  io snapshot     : {snapshot_path} ({len(snapshot['objects'])} names)")

    if args.compare_io:
        try:
            before = json.loads(Path(args.compare_io).read_text())
        except (OSError, ValueError) as exc:
            print(f"error: cannot read I/O snapshot {args.compare_io}: {exc}", file=sys.stderr)
            return 2
        changed = compare_io(db_root, before)
        if changed:
            print(f"  io compare      : {len(changed)} pre-existing names CHANGED", file=sys.stderr)
            for item in changed[:50]:
                print(f"    {item['name']}: {item['change']}", file=sys.stderr)
            return 1
        print(f"  io compare      : {len(before.get('objects', {}))} names unchanged")

    return exit_code


if __name__ == "__main__":
    raise SystemExit(main())
