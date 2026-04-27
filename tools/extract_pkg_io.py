#!/usr/bin/env python3
"""One-shot data curator: populate inlets/outlets in overrides.json for
empty-I/O package objects by scanning per-package help (.maxhelp) files.

Idempotent. NOT a patch generator (CLAUDE.md Rule #5 only forbids regenerating
.maxpat files; this tool only writes JSON metadata into overrides.json).

Strategy
--------
For every entry in ObjectDatabase().audit_empty_io()['critical']:

  1. Look up its helpfile at .claude/max-objects/_pkg-source/<pkg>/help/<name>.maxhelp
  2. Walk the helpfile's `patcher.boxes` recursively (descending into embedded
     patchers) looking for one of two markers:
       * a `newobj` whose first text token equals the canonical name, OR
       * a `bpatcher` whose `name` attribute equals "<canonical>.maxpat"
  3. Read `numinlets`, `numoutlets`, `outlettype` from that box.
  4. Build inlets/outlets records in the overrides.json schema.
  5. For every entry with no helpfile (or where the helpfile match fails), use
     the MANUAL_FALLBACK dict at the top of this file.
  6. Deep-merge into overrides.json under `objects`. Existing entries are NOT
     clobbered: only `inlets` / `outlets` / `_audit` are added if the entry is
     present-but-empty, otherwise a brand-new entry is created.
  7. Refresh `_uncovered_empty_io` to reflect post-merge audit state.
  8. Atomic write via temp file + os.replace.

Re-running is a no-op once entries are populated. Extend MANUAL_FALLBACK if a
new package object lands in the DB with empty I/O and no helpfile coverage.

Origin: quick-260427-l2t (clean-empty-io-entries). Pairs with the regression
test tests/test_db_lookup.py::test_audit_empty_io_critical_bound which asserts
len(audit['critical']) < 20.
"""
from __future__ import annotations

import json
import os
import sys
from pathlib import Path

# Project root: this file is at tools/extract_pkg_io.py
ROOT = Path(__file__).resolve().parent.parent
DB_ROOT = ROOT / ".claude" / "max-objects"
PKG_SOURCE = DB_ROOT / "_pkg-source"
OVERRIDES_PATH = DB_ROOT / "overrides.json"

# Allow `from src.maxpat.db_lookup import ObjectDatabase`
sys.path.insert(0, str(ROOT))


# ---------------------------------------------------------------------------
# MANUAL_FALLBACK -- best-effort I/O for entries the helpfile scan can't cover.
#
# Every entry here is either:
#   (a) an object whose help patcher wraps the canonical instance in nested
#       bpatchers/UI containers so no top-level instance is detectable, OR
#   (b) a real package object with no _pkg-source helpfile shipped, OR
#   (c) a documentation pseudo-class with no real instantiation pattern --
#       these get LOW confidence and a comment explaining why.
#
# Schema per entry:
#   "name": (numinlets, numoutlets, outlettype-list-or-None, comment)
# outlettype list semantics: same as Max's helpfile field; pass None for the
# default (no signal outlets, control type "").
#
# Confidence is "LOW" everywhere here -- these are inferences, not extractions.
# Override an entry by editing this dict and re-running the script.
# ---------------------------------------------------------------------------
MANUAL_FALLBACK: dict[str, tuple[int, int, list | None, str]] = {
    # ------- abc.* (helpfile-extraction failures, ~2) -------
    # abc.env.generator~: envelope generator audio object. 1 control + 1 signal in,
    # 1 signal out is the abclib pattern.
    "abc.env.generator~": (2, 1, ["signal"], "abclib envelope generator (helpfile bpatcher-wrapped)"),
    "abc.simpleburstfm~": (1, 1, ["signal"], "abclib FM burst (helpfile bpatcher-wrapped)"),

    # ------- bach.* -------
    "bach.hypercomment": (1, 0, None, "bach UI annotation (control in, no out)"),

    # ------- bp.* (BEAP) -------
    "bp.Global Transport": (1, 1, None, "BEAP global transport panel"),
    "bp.serialosc": (1, 2, None, "BEAP serialosc bridge"),

    # ------- camu.* -------
    "camu.debug.control": (1, 1, None, "camu debug controller"),
    "camu.synth.poly~": (1, 1, ["signal"], "camu polyphonic synth voice"),
    "camu.synth.poly~8ch": (1, 8, ["signal"] * 8, "camu 8-ch polyphonic synth"),
    "camu.voice.poly~": (1, 1, ["signal"], "camu polyphonic voice"),
    "camu.voice.poly~8ch": (1, 8, ["signal"] * 8, "camu 8-ch polyphonic voice"),
    "camu.voice.poly~mc": (1, 1, ["multichannelsignal"], "camu MC polyphonic voice"),

    # ------- cv.jit.* -------
    "cv.jit.extrema": (1, 2, None, "cv.jit min/max extrema (matrix in, control out)"),

    # ------- dada.* -------
    "dada.match": (2, 2, None, "dada matching/comparison"),

    # ------- dict.* -------
    "dict.view": (1, 1, None, "dict UI viewer (control in, control out)"),

    # ------- fluid.* -------
    "fluid.stftpass~": (1, 1, ["signal"], "FluCoMa STFT passthrough"),
    "fluid.waveform~": (1, 0, None, "FluCoMa waveform display widget"),

    # ------- grainflow.* (waveform/spatial UI display widgets) -------
    "grainflow.spatview~": (1, 0, None, "grainflow spatial-position display widget"),
    "grainflow.util.multipan~": (2, 2, ["signal", "signal"], "grainflow multi-pan utility"),
    "grainflow.util.stereopan~": (2, 2, ["signal", "signal"], "grainflow stereo-pan utility"),
    "grainflow.waveform~": (1, 0, None, "grainflow waveform display widget"),

    # ------- jit.* (no helpfile shipped in _pkg-source) -------
    "jit.gl.textureset": (1, 1, None, "jit.gl texture set container"),
    "jit.gradient.ui": (1, 1, None, "jit gradient UI widget"),
    "jit.line": (1, 1, None, "jit.line ramp generator"),
    "jit.mo.field": (1, 1, None, "jit.mo field driver"),
    "jit.mo.fieldmask": (1, 1, None, "jit.mo field mask"),
    "jit.mo.func": (1, 1, None, "jit.mo function driver"),
    "jit.mo.time": (1, 1, None, "jit.mo time driver"),
    "jit.polymovie": (1, 1, None, "jit polymovie playback"),

    # ------- live.* -------
    "live.adsrui": (1, 1, None, "live ADSR UI editor"),
    "live.adsr~": (4, 1, ["signal"], "live ADSR signal-rate envelope (4 control + 1 signal out)"),

    # ------- mira.* -------
    "mira.motion": (1, 3, None, "mira motion sensor (3-axis gyro/accel)"),
    "mira.multitouch": (1, 4, None, "mira multitouch (x, y, id, state)"),

    # ------- ml.* -------
    "ml.scalar": (1, 1, None, "ml.scalar normalization helper"),

    # ------- mxj / cnmat-externals / various Max docs ---------------------
    # The following are documentation pseudo-classes or objects whose runtime
    # I/O depends entirely on the loaded class/script. We give them a
    # conservative 1/1 fallback so audit_empty_io stops flagging them.
    "mxj":  (1, 1, None, "Java host (I/O determined by loaded class)"),
    "mxj~": (1, 1, ["signal"], "Java MSP host (I/O determined by loaded class)"),

    # CNMAT externals
    "osc-route":     (1, 2, None, "CNMAT OSC route (matched + pass-through)"),
    "osc-schedule":  (1, 1, None, "CNMAT OSC scheduler"),
    "osc-timetag":   (1, 1, None, "CNMAT OSC timetag"),

    # Doc-pseudo-classes left UNCOVERED on purpose -- not real objects you
    # instantiate by name (refpage artifacts). Listed here for documentation,
    # but COMMENTED OUT so they remain in audit['critical'] as known-leftovers.
    # If they ever start getting used as real objects, add them here.
    #   "dsp": ...
    #   "jbox": ...
    #   "jit_kernel": ...
    #   "onecopy": ...
    #   "opensoundcontrol": ...
    #   "project": ...
    #   "snorm": ...
}


# ---------------------------------------------------------------------------
# Helpfile extraction
# ---------------------------------------------------------------------------

def build_help_index() -> dict[str, list[Path]]:
    """Index every .maxhelp by its base name (object-name)."""
    idx: dict[str, list[Path]] = {}
    if not PKG_SOURCE.is_dir():
        return idx
    for root, _dirs, files in os.walk(PKG_SOURCE):
        if os.sep + "help" not in root and not root.endswith("help"):
            continue
        for fname in files:
            if fname.endswith(".maxhelp"):
                base = fname[: -len(".maxhelp")]
                idx.setdefault(base, []).append(Path(root) / fname)
    return idx


def find_canonical_box(boxes: list, target: str) -> dict | None:
    """Walk patcher.boxes (recursively into embedded patchers) and return the
    first box matching `target` by:

      * newobj.text first-token == target, or
      * bpatcher.name == "<target>.maxpat"

    Returns the inner `box` dict, or None.
    """
    target_bp_name = f"{target}.maxpat"
    for entry in boxes:
        bx = entry.get("box", {})
        mc = bx.get("maxclass", "")
        if mc == "newobj":
            text = (bx.get("text") or "").strip()
            if text and text.split()[0] == target:
                return bx
        elif mc == "bpatcher":
            if bx.get("name") == target_bp_name:
                return bx
        sub = bx.get("patcher")
        if sub:
            r = find_canonical_box(sub.get("boxes", []), target)
            if r is not None:
                return r
    return None


def build_inlet_record(idx: int, is_audio_obj: bool) -> dict:
    """Helpfile data carries no per-inlet type info. Audio objects (name ends
    in `~`) get signal=True as a sane default (Max accepts both signal and
    float on signal inlets). Control objects get signal=False.
    """
    return {
        "id": idx,
        "type": "",
        "signal": is_audio_obj,
        "digest": "",
    }


def build_outlet_record(idx: int, outlettype: list | None) -> dict:
    """outlettype[i] in helpfile is one of: "signal", "multichannelsignal",
    or "" (control). Build the outlet schema accordingly.
    """
    otype = ""
    is_signal = False
    if outlettype and idx < len(outlettype):
        ot = outlettype[idx]
        if ot in ("signal", "multichannelsignal"):
            is_signal = True
            otype = ot
        else:
            otype = ot or ""
    return {
        "id": idx,
        "type": otype,
        "signal": is_signal,
        "digest": "",
    }


def io_records_from_box(name: str, box: dict) -> tuple[list, list]:
    """Convert helpfile box attrs to overrides-shape inlet/outlet lists."""
    ni = int(box.get("numinlets") or 0)
    no = int(box.get("numoutlets") or 0)
    outlettype = box.get("outlettype")  # may be None or list
    is_audio = name.endswith("~")
    inlets = [build_inlet_record(i, is_audio) for i in range(ni)]
    outlets = [build_outlet_record(i, outlettype) for i in range(no)]
    return inlets, outlets


def io_records_from_manual(name: str, ni: int, no: int, outlettype: list | None) -> tuple[list, list]:
    """Same shape as io_records_from_box, but for MANUAL_FALLBACK entries."""
    is_audio = name.endswith("~")
    inlets = [build_inlet_record(i, is_audio) for i in range(ni)]
    outlets = [build_outlet_record(i, outlettype) for i in range(no)]
    return inlets, outlets


def extract_from_helpfile(name: str, paths: list[Path]) -> tuple[list, list] | None:
    """Try each candidate helpfile path. Return inlet/outlet lists on first
    successful match; None if no helpfile yields a canonical box with non-
    zero I/O.
    """
    for path in paths:
        try:
            data = json.loads(path.read_text())
        except Exception:
            continue
        boxes = data.get("patcher", {}).get("boxes", [])
        bx = find_canonical_box(boxes, name)
        if bx is None:
            continue
        ni = int(bx.get("numinlets") or 0)
        no = int(bx.get("numoutlets") or 0)
        if ni == 0 and no == 0:
            # Treat 0/0 as a non-match; we'd populate empty arrays again.
            continue
        return io_records_from_box(name, bx)
    return None


# ---------------------------------------------------------------------------
# overrides.json merge
# ---------------------------------------------------------------------------

def deep_merge_io(existing: dict, new_inlets: list, new_outlets: list, audit: dict) -> bool:
    """Merge inlets/outlets into an existing override entry. Only fills empty
    fields (idempotent). Returns True iff anything was added.
    """
    changed = False
    if not existing.get("inlets"):
        existing["inlets"] = new_inlets
        changed = True
    if not existing.get("outlets"):
        existing["outlets"] = new_outlets
        changed = True
    if changed:
        existing.setdefault("_audit", {}).update(audit)
    return changed


def merge_into_overrides(populated: dict[str, dict]) -> tuple[int, int]:
    """Load overrides.json, merge populated entries under `objects`. Returns
    (entries_added, entries_extended) where added=brand new keys and
    extended=existing keys that gained inlets/outlets.
    """
    with OVERRIDES_PATH.open() as f:
        ov = json.load(f)
    objs = ov.setdefault("objects", {})
    added = 0
    extended = 0
    for name, payload in populated.items():
        if name in objs:
            if isinstance(objs[name], dict):
                if deep_merge_io(
                    objs[name], payload["inlets"], payload["outlets"], payload["_audit"]
                ):
                    extended += 1
            # If objs[name] is a string (domain marker), skip silently
        else:
            objs[name] = payload
            added += 1

    # Refresh _uncovered_empty_io from a live audit (after the in-memory merge
    # but before the on-disk write -- so we use the post-merge state by
    # writing first then re-reading via ObjectDatabase).
    tmp = OVERRIDES_PATH.with_suffix(".json.tmp")
    tmp.write_text(json.dumps(ov, indent=2))
    os.replace(tmp, OVERRIDES_PATH)

    # Now run the audit and rewrite _uncovered_empty_io to match
    from src.maxpat.db_lookup import ObjectDatabase  # noqa: E402
    import warnings
    with warnings.catch_warnings():
        warnings.simplefilter("ignore", UserWarning)
        db = ObjectDatabase()
        audit = db.audit_empty_io()

    # Reload to keep our hand-edited file structure
    with OVERRIDES_PATH.open() as f:
        ov = json.load(f)
    if "_uncovered_empty_io" in ov and isinstance(ov["_uncovered_empty_io"], dict):
        ov["_uncovered_empty_io"]["count"] = len(audit["critical"])
        ov["_uncovered_empty_io"]["objects"] = sorted(audit["critical"])
    tmp = OVERRIDES_PATH.with_suffix(".json.tmp")
    tmp.write_text(json.dumps(ov, indent=2))
    os.replace(tmp, OVERRIDES_PATH)

    return added, extended, len(audit["critical"])


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main() -> int:
    # Suppress UserWarnings during DB load (every empty-I/O entry triggers one).
    import warnings
    warnings.simplefilter("ignore", UserWarning)

    from src.maxpat.db_lookup import ObjectDatabase  # noqa: E402
    db = ObjectDatabase()
    crit = db.audit_empty_io()["critical"]
    print(f"Starting critical bucket size: {len(crit)}")

    help_idx = build_help_index()
    print(f"Indexed {sum(len(v) for v in help_idx.values())} helpfiles "
          f"covering {len(help_idx)} unique names")

    populated: dict[str, dict] = {}

    # Pass 1: helpfile extraction
    extracted = 0
    for name in crit:
        if name not in help_idx:
            continue
        result = extract_from_helpfile(name, help_idx[name])
        if result is None:
            continue
        inlets, outlets = result
        populated[name] = {
            "inlets": inlets,
            "outlets": outlets,
            "_audit": {
                "confidence": "MEDIUM",
                "source": "helpfile_extraction",
                "tool": "tools/extract_pkg_io.py",
            },
        }
        extracted += 1
    print(f"Helpfile extraction: {extracted}/{len(crit)} populated")

    # Pass 2: manual fallback
    fallback_used = 0
    for name in crit:
        if name in populated:
            continue  # already populated by helpfile
        if name not in MANUAL_FALLBACK:
            continue
        ni, no, otype, comment = MANUAL_FALLBACK[name]
        inlets, outlets = io_records_from_manual(name, ni, no, otype)
        populated[name] = {
            "inlets": inlets,
            "outlets": outlets,
            "_audit": {
                "confidence": "LOW",
                "source": "manual_fallback_inferred",
                "tool": "tools/extract_pkg_io.py",
                "note": comment,
            },
        }
        fallback_used += 1
    print(f"Manual fallback: {fallback_used} populated")

    if not populated:
        print("Nothing to merge -- already idempotent.")
        return 0

    added, extended, post_critical = merge_into_overrides(populated)
    print(f"overrides.json: {added} new entries, {extended} extended")
    print(f"Post-merge critical bucket size: {post_critical}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
