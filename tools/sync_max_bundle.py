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
  per-package object files and ``package_info.json``. The only other write
  site is :func:`write_report` (``--json`` / ``--snapshot-io`` targets), which
  refuses any path inside ``patches/`` or the DB tree.

Sources of shape
----------------
* Names: the refpage ``<c74object name>`` attribute, never the filename --
  except for define-mapped objects (``max define ALIAS TARGET ARGS;`` lines in
  the bundle's ``*objectmappings*.txt``), whose refpage name attribute can be
  the implementing class (``v8``) or a typo. For those the alias is the name
  and the refpage is never merged into the object its name attribute points at.
* I/O counts: refpage, cross-checked against the help-patch box Max itself
  serialized. A disagreement aborts that object.
* Outlet types: the help-patch box ``outlettype``.
* Inherited attributes: Jitter object refpages name their shared (OB3D / MOP)
  attributes in a names-only ``<jitterattributelist>``; the definition lives
  in a group page (``jit.group-gl.maxref.xml``), which is a documentation
  page with no DB entry. The DB does not record inherited attributes as a
  rule, so these are report-only and land only for attribute names given
  explicitly to ``--apply inherited --attributes``.

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
import importlib.util
import json
import os
import re
import sys
import tempfile
import warnings
import xml.etree.ElementTree as ET
from pathlib import Path

# Project root: this file is at tools/sync_max_bundle.py
ROOT = Path(__file__).resolve().parent.parent

# Allow `from src.maxpat...` / `from tools.audit_db ...`
sys.path.insert(0, str(ROOT))

from src.maxpat.db_lookup import ObjectDatabase  # noqa: E402
from tools.audit_db import (  # noqa: E402
    CORE_REFPAGE_DIRS,
    DEFAULT_MAX_APP,
    OutputPathRejected,
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

APPLY_MODES = ("new", "define", "deltas", "inherited")

SECTION_KEYS = [
    "install",
    "new_objects",
    "define_missing",
    "deltas",
    "inherited_attributes",
    "collisions",
    "alias_docs",
    "shadowed_by_override",
]


class WriteRefused(Exception):
    """A write target is outside the DB allow-list (T-hwb-01)."""


class StyleUnreproducible(Exception):
    """No known serialization style reproduces a DB file's bytes."""


class AdditiveViolation(Exception):
    """A write would change or remove data on a pre-existing entry (T-hwb-02)."""


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


def _major_minor(short_version: str | None) -> float | None:
    """'9.2.0' -> 9.2 (C5). None when the version string is unusable."""
    if not short_version:
        return None
    match = re.match(r"^(\d+)\.(\d+)", short_version)
    if not match:
        return None
    return float(f"{match.group(1)}.{match.group(2)}")


_DEFINE_RE = re.compile(r"^\s*max\s+define\s+(\S+)\s+(\S+)\s*(.*?)\s*;?\s*$")


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


def _is_doc_page(ref: dict) -> bool:
    """A refpage with no inlets, outlets or methods documents a topic, not an object.

    So does any page whose name contains whitespace ("MC Wrapper Features",
    "Snapshot Messages"): the bundle's group pages carry empty inletlist /
    outletlist elements plus a shared methodlist, and a name with a space can
    never be the first token of an object box.
    """
    if any(ch.isspace() for ch in ref["name"]):
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


def _dedupe(items: list) -> list:
    seen = set()
    out = []
    for item in items:
        if item not in seen:
            seen.add(item)
            out.append(item)
    return out


def compute_deltas(index: dict, classified: dict, db: ObjectDatabase, raw_db: dict) -> dict:
    """Messages / attributes the bundle documents and the raw base entry lacks.

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
        ref_messages = _dedupe(parsed.get("messages", []))
        ref_attributes = parsed.get("attributes", {})

        located = locate_base_entry(resolved, name, raw_db)
        if located is None:
            unwritable.append(name)
            continue
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


def compute_inherited(index: dict, classified: dict, db: ObjectDatabase, raw_db: dict) -> dict:
    """Group-page attributes an object refpage lists and its raw base entry lacks.

    `_pending` is what --apply inherited can write, restricted there to an
    explicit attribute allow-list. `undefined` counts the referenced names no
    group page defines (they cannot be added: there is no type to record).
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
        for attr in referenced:
            if attr in raw_attributes:
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
    sections["deltas"] = deltas
    inherited = compute_inherited(index, classified, db, raw_db)
    inherited.pop("_pending")
    sections["inherited_attributes"] = inherited
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
    """
    for ensure_ascii in (False, True):
        body = json.dumps(data, indent=2, ensure_ascii=ensure_ascii)
        for trailing_newline in (True, False):
            if (body + ("\n" if trailing_newline else "")).encode("utf-8") == raw:
                return ensure_ascii, trailing_newline
    raise StyleUnreproducible(
        "no (indent=2, ensure_ascii, trailing newline) combination reproduces the file"
    )


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


def write_db_file(path: str | Path, new_data: dict, db_root: str | Path) -> bool:
    """Write one DB file. THE ONLY place this tool writes into the DB tree.

    Refuses anything off the allow-list, preserves the file's serialization
    style byte-for-byte, keeps sorted files sorted, runs the additive
    self-check, and replaces the file atomically. Returns False (and writes
    nothing) when the output would be byte-identical.
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
        return False

    handle, tmp_name = tempfile.mkstemp(prefix=".sync-", suffix=".tmp", dir=str(target.parent))
    try:
        with os.fdopen(handle, "wb") as fh:
            fh.write(payload)
        os.replace(tmp_name, target)
    finally:
        if os.path.exists(tmp_name):
            os.unlink(tmp_name)
    return True


def write_report(path: Path, payload: dict) -> None:
    """Write a --json / --snapshot-io document. `path` is already guarded."""
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(payload, indent=2, sort_keys=False) + "\n")


def guard_report_path(target: str | Path, repo_root: Path, db_root: Path) -> Path:
    """Refuse report targets under patches/, the repo DB tree, or the active DB root."""
    resolved = guard_output_path(target, repo_root)
    db = Path(db_root).resolve()
    if resolved == db or db in resolved.parents:
        raise OutputPathRejected(f"refusing to write {resolved}: inside the DB root {db}")
    return resolved


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


def update_package_counts(db_root: Path, packages: set[str]) -> list[str]:
    """Set `object_count` in package_info.json to each touched file's length."""
    info_path = db_root / "package_info.json"
    if not info_path.exists():
        return []
    info = json.loads(info_path.read_text())
    changed: list[str] = []
    for package in sorted(packages):
        row = info.get(package)
        if not isinstance(row, dict) or "object_count" not in row:
            continue
        count = len(json.loads((db_root / "packages" / package / "objects.json").read_text()))
        if row["object_count"] != count:
            row["object_count"] = count
            changed.append(package)
    if changed:
        write_db_file(info_path, info, db_root)
    return changed


def parse_min_version(text: str) -> int | float:
    """`--min-version` value: a Max major (`8`) or major.minor (`9.2`), 4 <= v < 10.

    Whole numbers stay ints, matching how the DB stores them.
    """
    if not re.fullmatch(r"\d+(\.\d+)?", text.strip()):
        raise argparse.ArgumentTypeError(f"not a Max version: {text!r}")
    value = float(text)
    if not 4 <= value < 10:
        raise argparse.ArgumentTypeError(f"outside the supported range 4 <= v < 10: {text!r}")
    return int(value) if value == int(value) else value


def apply_objects(
    modes: list[str],
    names: list[str],
    index: dict,
    db_root: Path,
    min_version: int | float | None = None,
) -> list[dict]:
    """--apply new / --apply define: land explicitly named objects only.

    `min_version` replaces C5's default (the installed major.minor) on every
    object landed by this call. It exists for objects the bundle has shipped
    since an earlier release and the DB only now picks up: tagging those with
    the installed version would claim they need it.
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

    for rel, entries in pending.items():
        data = dict(raw_db[rel])
        data.update(entries)
        write_db_file(db_root / rel, data, db_root)
    touched_packages = {rel.split("/")[1] for rel in pending if rel.startswith("packages/")}
    if touched_packages:
        update_package_counts(db_root, touched_packages)
    return results


def apply_deltas(index: dict, db_root: Path, names: list[str] | None) -> dict:
    """--apply deltas: append the documented messages / attributes."""
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
    for rel, data in touched.items():
        if write_db_file(db_root / rel, data, db_root):
            applied["files"].append(rel)
    applied["files"].sort()
    return applied


def apply_inherited(
    index: dict, db_root: Path, attributes: list[str], names: list[str] | None
) -> dict:
    """--apply inherited: add the NAMED group-page attributes where refpages list them."""
    db = load_db(db_root)
    raw_db = load_raw_db(db_root)
    classified = classify_refs(index, db, db_root)
    inherited = compute_inherited(index, classified, db, raw_db)
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
    for rel, data in touched.items():
        if write_db_file(db_root / rel, data, db_root):
            applied["files"].append(rel)
    applied["files"].sort()
    return applied


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
    lines.append(f"  collisions      : {s['collisions']['count']} (reported, ignored)")
    lines.append(f"  alias documents : {s['alias_docs']['count']}")
    shadow = s["shadowed_by_override"]
    lines.append(
        f"  shadowed by override: {shadow['count']} objects, "
        f"{len(shadow['with_missing_names'])} lacking refpage names"
        + (f": {', '.join(shadow['with_missing_names'])}" if shadow["with_missing_names"] else "")
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
        help="Apply mode; repeatable. new / define require --names; inherited requires --attributes.",
    )
    parser.add_argument(
        "--names",
        nargs="+",
        default=None,
        help="Explicit allow-list of object names (mandatory for new and define).",
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
            except (WriteRefused, AdditiveViolation, StyleUnreproducible) as exc:
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
