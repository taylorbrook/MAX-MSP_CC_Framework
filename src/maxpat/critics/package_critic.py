"""Package critic -- checks BEAP conventions, Bach llll types, and community extraction.

Catches package-specific semantic errors that the generic validation pipeline
misses:
  - BEAP: missing output termination, missing VCA gain staging
  - Bach: llll/list type mismatches (non-bach, non-command source feeding an
    llll inlet) -- note severity (Q3 / E4)
  - Bach: ``@out`` mode (the fix-plan Q23 table row "bach.* outlet ->
    non-bach consumer without ``@out t``", carried out by Q39 so its quick
    fix has a finding to ride on) -- a bach box whose ``@out`` is missing or
    not all ``t`` cords a non-bang outlet into a non-bach, non-forwarder
    consumer; warning with a ``set_bach_out`` payload
  - Community: unextracted community package usage warnings

Every non-gen scope of the shared :class:`src.maxpat.graph.PatchGraph` is
reviewed (Q20); nested findings carry ``CriticResult.path`` and a
``[p synth] `` prefix. The packages used (which decide the BEAP and Bach
dispatch) are collected once across all non-gen scopes, and the community
and install-state findings are deduplicated per patch: each reports once,
at the first scope (pre-order) where it appears.
"""

from __future__ import annotations

from collections import deque

from src.maxpat import walk
from src.maxpat.critics.base import CriticResult, finding_ids, tag_results
from src.maxpat.critics.fixes import bach_out_fix
from src.maxpat.db_lookup import ObjectDatabase
from src.maxpat.graph import PatchGraph


# BEAP output module names (signal terminators with 0 outlets)
_BEAP_OUTPUT_NAMES = frozenset({
    "bp.Stereo", "bp.Mono", "bp.Calibrated",
    "bp.Calibrated_64bit", "bp.M4L Out", "bp.Recordr", "bp.Snapshotter",
})

# BEAP source categories that start signal chains
_BEAP_SOURCE_CATEGORIES = frozenset({"Oscillator", "Input", "Random", "LFO"})

# BEAP gain staging categories (contains bp.VCA)
_BEAP_GAIN_CATEGORIES = frozenset({"Level"})

# Sources that send bach commands/messages rather than llll data into an llll
# inlet (Q3 / E4). Message boxes are matched by maxclass. Evidence:
# physics-composition `addchord [ $1 [ $2 $3 $4 ] ]`, `domain $1 $2` and
# `receive roll-clear` into bach.roll inlet 0 were all false-positive blockers.
_BACH_COMMAND_SOURCES = frozenset({
    "attrui", "loadmess", "loadbang", "receive", "r", "button", "prepend",
})


def _get_object_name(box: dict) -> str:
    """Get object name, handling both bpatcher (name attr) and newobj (text field).

    BEAP/Vizzie objects have maxclass="bpatcher" with the abstraction name
    in the "name" attribute (used only when it is a str). Standard objects
    use walk.box_name().
    """
    if walk.box_maxclass(box) == "bpatcher":
        name = box.get("name", "")
        return name if isinstance(name, str) else ""
    return walk.box_name(box)


def collect_packages_used(graph: PatchGraph, db: ObjectDatabase) -> set:
    """Packages of every box in every non-gen scope of *graph*."""
    packages_used: set[str] = set()
    for scope in graph.scopes:
        if scope.context == "gen":
            continue
        for box in _scope_boxes(scope):
            name = _get_object_name(box)
            if name:
                pkg = db.get_package(name)
                if pkg:
                    packages_used.add(pkg)
    return packages_used


def _scope_boxes(scope):
    """Every box dict of *scope*'s raw boxes array (with or without an id)."""
    raw = scope.patcher.get("boxes")
    for entry in raw if isinstance(raw, list) else ():
        box = entry.get("box") if isinstance(entry, dict) else None
        if isinstance(box, dict):
            yield box


def review_packages(
    patch_dict: dict,
    db: ObjectDatabase | None = None,
    *,
    graph: PatchGraph | None = None,
) -> list[CriticResult]:
    """Review package-specific semantics.

    Dispatches to BEAP, Bach, and community checks based on
    which package objects are detected in the patch.

    Args:
        patch_dict: A .maxpat-format dict.
        db: Optional ObjectDatabase instance. Created internally if None.
        graph: The shared PatchGraph of *patch_dict* (review_patch passes
            it); built here when None.

    Returns:
        List of CriticResult findings, top level first, nested scopes in
        pre-order.
    """
    results: list[CriticResult] = []
    if db is None:
        db = ObjectDatabase()
    if graph is None:
        graph = PatchGraph.build(patch_dict)

    packages_used = collect_packages_used(graph, db)
    # One dedup state per call: a package / missing object reports once
    warned_packages: set[str] = set()
    flagged: set[str] = set()

    for scope in graph.scopes:
        if scope.context == "gen":
            continue
        box_lookup = scope.boxes
        found: list[CriticResult] = []

        # Conditional dispatch per D-12
        if "BEAP" in packages_used:
            found.extend(_check_beap_conventions(box_lookup, scope.edges, db))

        if "Bach" in packages_used:
            found.extend(_check_bach_llll_types(box_lookup, scope.edges, db))
            found.extend(_check_bach_out_mode(box_lookup, scope.edges, db))

        # Community extraction check (lightweight, always runs)
        found.extend(_check_community_extracted(box_lookup, db, warned_packages))

        # Install-state check (lightweight, always runs) -- D-06
        found.extend(_check_install_state(box_lookup, db, flagged))

        results.extend(tag_results(found, scope.path))

    return results


# ---------------------------------------------------------------------------
# BEAP convention checks
# ---------------------------------------------------------------------------

def _check_beap_conventions(
    box_lookup: dict[str, dict],
    edges: list,
    db: ObjectDatabase,
) -> list[CriticResult]:
    """Check BEAP signal chain conventions.

    Dispatches to output termination and VCA gain staging checks.
    """
    results: list[CriticResult] = []
    results.extend(_check_beap_output_termination(box_lookup, edges, db))
    results.extend(_check_beap_vca_staging(box_lookup, edges, db))
    return results


def _build_signal_adjacency(
    box_lookup: dict[str, dict],
    edges: list,
) -> dict[str, list[str]]:
    """Build forward signal adjacency from one scope's edges.

    For bpatcher boxes (BEAP modules), treat all connections as potential
    signal connections since outlettype may not be present in the box dict.
    Other sources follow ``edge.signal`` (graph.outlet_is_signal), so
    ``multichannelsignal`` counts (S1, Q20).
    """
    signal_adj: dict[str, list[str]] = {}
    for edge in edges:
        src_box = box_lookup.get(edge.src)
        if not src_box:
            continue

        # For bpatcher boxes, treat all connections as signal
        # (BEAP modules are signal processors)
        if walk.box_maxclass(src_box) == "bpatcher" or edge.signal:
            signal_adj.setdefault(edge.src, []).append(edge.dst)

    return signal_adj


def _get_beap_category(box: dict, db: ObjectDatabase) -> str | None:
    """Get the BEAP category for a box, or None if not BEAP."""
    name = _get_object_name(box)
    if not name:
        return None
    obj_entry = db.lookup(name)
    if obj_entry and obj_entry.get("package") == "BEAP":
        return obj_entry.get("category")
    return None


def _check_beap_output_termination(
    box_lookup: dict[str, dict],
    edges: list,
    db: ObjectDatabase,
) -> list[CriticResult]:
    """Check that BEAP signal chains terminate with an output module.

    BFS from each BEAP source (Oscillator/Input/Random/LFO) through signal
    adjacency. If no path reaches an Output category object, emit warning.
    """
    results: list[CriticResult] = []
    signal_adj = _build_signal_adjacency(box_lookup, edges)

    # Find BEAP source boxes
    beap_sources: list[tuple[str, str]] = []  # (box_id, name)
    for box_id, box in box_lookup.items():
        cat = _get_beap_category(box, db)
        if cat in _BEAP_SOURCE_CATEGORIES:
            beap_sources.append((box_id, _get_object_name(box)))

    # BFS from each source to find output modules
    for src_id, src_name in beap_sources:
        queue = deque([src_id])
        visited: set[str] = set()
        found_output = False

        while queue:
            current_id = queue.popleft()
            if current_id in visited:
                continue
            visited.add(current_id)

            current_box = box_lookup.get(current_id)
            if not current_box:
                continue

            current_name = _get_object_name(current_box)
            if current_name in _BEAP_OUTPUT_NAMES:
                found_output = True
                break

            for next_id in signal_adj.get(current_id, []):
                queue.append(next_id)

        if not found_output:
            results.append(CriticResult(
                "warning",
                f"BEAP missing output: '{src_name}' ({src_id}) signal chain "
                f"does not reach a BEAP output module (bp.Stereo, bp.Mono, etc.)",
                f"Add a bp.Stereo or bp.Mono at the end of the BEAP chain "
                f"to properly terminate the signal",
                rule="beap_output_termination",
                box_ids=finding_ids(src_id),
            ))

    return results


def _check_beap_vca_staging(
    box_lookup: dict[str, dict],
    edges: list,
    db: ObjectDatabase,
) -> list[CriticResult]:
    """Check that BEAP oscillators pass through VCA before output.

    BFS from each BEAP Oscillator to Output. If no Level category object
    (bp.VCA etc.) is in the path, emit warning.
    """
    results: list[CriticResult] = []
    signal_adj = _build_signal_adjacency(box_lookup, edges)

    # Find BEAP oscillator boxes specifically
    beap_oscillators: list[tuple[str, str]] = []
    for box_id, box in box_lookup.items():
        cat = _get_beap_category(box, db)
        if cat == "Oscillator":
            beap_oscillators.append((box_id, _get_object_name(box)))

    for osc_id, osc_name in beap_oscillators:
        # BFS tracking whether we've passed through a gain stage
        queue = deque([(osc_id, False)])  # (current_id, passed_through_gain)
        visited: set[tuple[str, bool]] = set()
        found_ungained_output = False

        while queue:
            current_id, has_gain = queue.popleft()
            state = (current_id, has_gain)
            if state in visited:
                continue
            visited.add(state)

            for next_id in signal_adj.get(current_id, []):
                next_box = box_lookup.get(next_id)
                if not next_box:
                    continue

                next_name = _get_object_name(next_box)
                next_cat = _get_beap_category(next_box, db)
                next_has_gain = has_gain or (next_cat in _BEAP_GAIN_CATEGORIES)

                if next_name in _BEAP_OUTPUT_NAMES:
                    if not next_has_gain:
                        found_ungained_output = True
                    continue  # Don't traverse past output

                queue.append((next_id, next_has_gain))

        if found_ungained_output:
            results.append(CriticResult(
                "warning",
                f"BEAP missing VCA: '{osc_name}' ({osc_id}) reaches output "
                f"without passing through a VCA or Level module for gain staging",
                f"Insert a bp.VCA between '{osc_name}' and the output module "
                f"for proper BEAP gain staging",
                rule="beap_vca_staging",
                box_ids=finding_ids(osc_id),
            ))

    return results


# ---------------------------------------------------------------------------
# Bach llll type checks
# ---------------------------------------------------------------------------

def _is_llll_inlet(obj_entry: dict, inlet_id: int) -> bool:
    """Check if an object's inlet expects llll data.

    Args:
        obj_entry: Object dict from the database.
        inlet_id: Inlet index to check.

    Returns:
        True if the inlet's digest contains 'llll'.
    """
    for inlet in obj_entry.get("inlets", []):
        if inlet.get("id") == inlet_id:
            return "llll" in inlet.get("digest", "").lower()
    return False


def _check_bach_llll_types(
    box_lookup: dict[str, dict],
    edges: list,
    db: ObjectDatabase,
) -> list[CriticResult]:
    """Detect non-bach objects connected to bach inlets expecting llll.

    For each patchline, check whether the destination is a Bach object whose
    inlet digest advertises llll. Command sources (message boxes and
    ``_BACH_COMMAND_SOURCES``) are skipped: they send bach commands, not
    llll data. Any other non-bach source emits a NOTE (Q3 / E4: a flat MAX
    list into a bach inlet is usually fine; the real trap is bach -> non-bach
    without ``@out t``, handled elsewhere).
    """
    results: list[CriticResult] = []

    for edge in edges:
        src_id = edge.src
        dst_id, dst_inlet = edge.dst, edge.inlet

        src_box = box_lookup.get(src_id)
        dst_box = box_lookup.get(dst_id)
        if not src_box or not dst_box:
            continue

        src_name = _get_object_name(src_box)
        dst_name = _get_object_name(dst_box)

        # Command sources send bach messages, not llll data (Q3 / E4)
        if (
            walk.box_maxclass(src_box) == "message"
            or src_name in _BACH_COMMAND_SOURCES
        ):
            continue

        # Only check connections TO bach objects
        dst_entry = db.lookup(dst_name)
        if not dst_entry or dst_entry.get("package") != "Bach":
            continue

        # Check if this inlet expects llll
        if not _is_llll_inlet(dst_entry, dst_inlet):
            continue

        # Source must be a bach object (outputs llll)
        src_entry = db.lookup(src_name)
        src_is_bach = src_entry is not None and src_entry.get("package") == "Bach"

        if not src_is_bach:
            results.append(CriticResult(
                "note",
                f"Bach llll type mismatch: '{src_name}' ({src_id}) "
                f"connected to '{dst_name}' ({dst_id}) inlet {dst_inlet} "
                f"which expects llll data -- plain MAX lists will silently "
                f"produce garbage",
                f"A flat MAX list can connect directly to a bach inlet -- if "
                f"'{src_name}' already emits a flat list, the structure is what "
                f"needs fixing, not the connection. For structured conversion "
                f"use 'bach.flat', 'bach.iter', or 'bach.pack'; to extract an "
                f"element use 'bach.nth N' (1-based, one call per index, with "
                f"'@unwrap 1' when the element is itself a sublist)",
                rule="bach_llll_types",
                box_ids=finding_ids(src_id, dst_id),
                port=dst_inlet,
            ))

    return results


# Consumers that pass a bach llll on unchanged (to another patcher level, a
# send/receive pair, a voice) or ignore its content (button) -- Q39 / Q23
_BACH_OUT_FORWARDERS = frozenset({
    "outlet", "send", "s", "forward", "p", "patcher", "bpatcher", "poly~",
    "mc.poly~", "button",
})


def _bach_out_value(box: dict) -> "str | None":
    """A bach box's ``@out`` value, or None when unset.

    An object box reads the token after ``@out`` in its arguments; a UI bach
    box (``bach.roll``, maxclass ``bach.roll``) reads its saved ``out``
    attribute (physics-composition obj-67 saves ``"out": "nnnnnnn"``).
    """
    if walk.box_maxclass(box) != "newobj":
        value = box.get("out")
        return value if isinstance(value, str) and value else None
    args = walk.box_args(box)
    for i, token in enumerate(args):
        if token == "@out":
            nxt = args[i + 1] if i + 1 < len(args) else None
            return nxt if nxt is not None and not nxt.startswith("@") else None
    return None


# @out letters plain MAX objects can read (bach refpages, attribute ``out``):
# t (text) and m (max) are regular MAX messages; x disables the outlet, so it
# sends nothing to misread. n (native, the default) and p (portal) are not.
_BACH_READABLE_OUT = frozenset("tmx")


def _bach_outlet_readable(entry: dict, value, outlet) -> bool:
    """True when ``@out`` *value* makes llll outlet *outlet* readable (IN-04).

    The bach refpages define ``@out`` as one character per llll outlet. The
    llll index of *outlet* is its rank among the DB outlets whose digest is
    not a bang; an index past the value's length takes its last character
    (so ``@out t`` keeps covering every outlet, as before -- the padding rule
    is not documented and awaits confirmation in MAX). An unset value is the
    default ``n``.
    """
    if not value:
        return False
    llll_index = 0
    for o in entry.get("outlets", []) or []:
        if not isinstance(o, dict) or not isinstance(o.get("id"), int):
            continue
        if o["id"] >= outlet:
            break
        digest = o.get("digest")
        if not (isinstance(digest, str) and "bang" in digest.lower()):
            llll_index += 1
    char = value[llll_index] if llll_index < len(value) else value[-1]
    return char in _BACH_READABLE_OUT


def _outlet_is_bang(entry: dict, outlet) -> bool:
    for o in entry.get("outlets", []) or []:
        if isinstance(o, dict) and o.get("id") == outlet:
            digest = o.get("digest")
            return isinstance(digest, str) and "bang" in digest.lower()
    return False


def _check_bach_out_mode(
    box_lookup: dict[str, dict],
    edges: list,
    db: ObjectDatabase,
) -> list[CriticResult]:
    """Flag a bach box sending native lllls to plain MAX objects (Q39 / Q23 row).

    Every bach object's ``@out`` defaults to ``n`` (native), which plain MAX
    objects reject with "wrong message or type" (shared-capabilities.md
    "bach (package) Rules"). A source is a Bach-package box whose ``@out``
    character for the cord's llll outlet is not readable by MAX
    (:func:`_bach_outlet_readable`: t, m or x; quick 261022-ud6 IN-04 --
    ``@out tn`` with outlet 0 feeding ``print`` is fine); an offending cord leaves an outlet whose DB digest has no "bang"
    and enters a consumer that is neither a Bach-package object nor in
    ``_BACH_OUT_FORWARDERS``. One warning per bach box (consumers in edge
    order), port = the first offending outlet, with a ``set_bach_out`` fix
    for an object box (a UI bach box saves ``out`` as an attribute, which no
    Q39 fix op sets, so it gets the warning without a fix).
    """
    offenders: dict = {}  # bach id -> [first outlet, [consumer ids]]
    for edge in edges:
        src_box = box_lookup.get(edge.src)
        dst_box = box_lookup.get(edge.dst)
        if not src_box or not dst_box:
            continue
        src_entry = db.lookup(_get_object_name(src_box))
        if not src_entry or src_entry.get("package") != "Bach":
            continue
        if _outlet_is_bang(src_entry, edge.outlet):
            continue
        if _bach_outlet_readable(src_entry, _bach_out_value(src_box), edge.outlet):
            continue
        dst_name = _get_object_name(dst_box)
        if not dst_name or dst_name in _BACH_OUT_FORWARDERS:
            continue
        dst_entry = db.lookup(dst_name)
        if dst_entry and dst_entry.get("package") == "Bach":
            continue
        slot = offenders.setdefault(edge.src, [edge.outlet, []])
        if edge.dst not in slot[1]:
            slot[1].append(edge.dst)

    results: list[CriticResult] = []
    for bach_id, (outlet, consumers) in offenders.items():
        box = box_lookup[bach_id]
        name = _get_object_name(box)
        names = ", ".join(
            f"'{_get_object_name(box_lookup[c])}' ({c})" for c in consumers
        )
        mode = _bach_out_value(box)
        mode_text = f"'@out {mode}'" if mode is not None else "the default '@out n'"
        results.append(CriticResult(
            "warning",
            f"Bach native llll output: '{name}' ({bach_id}) outlet {outlet} feeds "
            f"non-bach {names} with {mode_text} -- a native llll is rejected by "
            f"non-bach objects ('wrong message or type')",
            "Set '@out t' (one 't' per llll outlet) on a bach object feeding "
            "plain MAX objects, so flat lists arrive as regular MAX lists",
            rule="bach_out_mode",
            box_ids=finding_ids(bach_id, *consumers),
            port=outlet,
            fix=bach_out_fix(bach_id, walk.box_text(box)) if walk.box_maxclass(box) == "newobj" else None,
        ))
    return results


# ---------------------------------------------------------------------------
# Community extraction check
# ---------------------------------------------------------------------------

def _match_package_by_prefix(name: str, db: ObjectDatabase) -> str | None:
    """Match an object name to a package using prefix from package_info.json.

    Used as fallback when db.get_package() returns None (object not in DB,
    typical for unextracted community packages).
    """
    for pkg_name in db.list_packages():
        info = db.get_package_info(pkg_name)
        if not info:
            continue
        prefix = info.get("prefix", "")
        if prefix and name.startswith(prefix):
            return pkg_name
    return None


def _check_community_extracted(
    box_lookup: dict[str, dict],
    db: ObjectDatabase,
    warned_packages: set | None = None,
) -> list[CriticResult]:
    """Warn on community/licensed packages that haven't been extracted.

    Checks each unique package used in the patch. If a community or licensed
    package has extracted=False in package_info.json, emit a warning (once
    per package). Uses prefix matching as fallback for objects not in the DB.
    *warned_packages* is shared across the scopes of one review (Q20).
    """
    results: list[CriticResult] = []
    if warned_packages is None:
        warned_packages = set()

    for box_id, box in box_lookup.items():
        name = _get_object_name(box)
        if not name:
            continue

        # Try DB lookup first, fall back to prefix matching
        pkg = db.get_package(name)
        if not pkg:
            pkg = _match_package_by_prefix(name, db)
        if not pkg or pkg in warned_packages:
            continue

        info = db.get_package_info(pkg)
        if not info:
            continue

        tier = info.get("tier", "")
        extracted = info.get("extracted", True)

        if tier in ("community", "licensed") and not extracted:
            warned_packages.add(pkg)
            results.append(CriticResult(
                "warning",
                f"Unextracted community package: '{pkg}' objects used in patch "
                f"but package has not been extracted to the object database -- "
                f"validation coverage may be incomplete",
                f"Run package extraction for '{pkg}' to enable full validation "
                f"and object database lookups",
                rule="community_extracted",
            ))

    return results


# ---------------------------------------------------------------------------
# Install-state check
# ---------------------------------------------------------------------------

def _check_install_state(
    box_lookup: dict[str, dict],
    db: ObjectDatabase,
    flagged: set | None = None,
) -> list[CriticResult]:
    """Blocker on any object the database marks as missing from this install.

    The rule is name-agnostic: it reads the database's tri-state
    ``verified_installed`` flag via ``db.get_install_state()`` and never hardcodes
    an object name. Any object marked false today or in the future is covered by
    this one rule.

    Tri-state semantics matter (D-02/D-09): only an explicit ``False`` ("audited
    and known missing") fires. ``None`` ("unaudited") is deliberately silent --
    roughly 2,000 database entries are unaudited, and ``db.is_verified_installed()``
    collapses those to False, so using it here would blocker-flag nearly the whole
    database. The predicate must stay ``get_install_state(name) is False``.

    This is a critic-channel finding, distinct from the one-time ``UserWarning``
    that ``db.lookup()`` emits for the same condition. ``validate_patch()`` is a
    separate pipeline and is intentionally left untouched (D-12: the lookup warning
    remains the single validator channel), so no ValidationResult is produced here.

    Findings are deduped per canonical object name: the same missing object in
    several boxes yields exactly one blocker. *flagged* is shared across
    the scopes of one review (Q20), so that holds across subpatchers too.
    """
    results: list[CriticResult] = []
    if flagged is None:
        flagged = set()

    for box in box_lookup.values():
        name = _get_object_name(box)
        if not name or name in flagged:
            continue

        # Tri-state: explicit False only. get_install_state() resolves aliases
        # itself and emits no warning, so no db.lookup() call is needed.
        if db.get_install_state(name) is not False:
            continue

        flagged.add(name)
        results.append(CriticResult(
            "blocker",
            f"Object not installed: '{name}' is marked verified_installed: false "
            f"in the object database -- it is not present in this MAX install. "
            f"The patch will fail to load with \"No such object\" for '{name}'",
            f"Remove '{name}' or replace it with an object that exists in this "
            f"install; if the package really is installed, re-run package "
            f"extraction so the database records '{name}' as present",
            rule="install_state",
        ))

    return results
