"""Multi-layer validation pipeline for MAX patches.

Four layers run sequentially, stopping early on structural errors:
  Layer 1 (json):        JSON structure checks (patcher, boxes, lines)
  Layer 2 (objects):     Object existence against ObjectDatabase
  Layer 3 (connections): Connection index bounds and signal/control type checks
  Layer 4 (domain):      Domain-specific rules (gain staging, unterminated chains, feedback)

Auto-fix removes invalid connections in-place and reports what changed.
Only unfixable structural errors block output.
"""

from __future__ import annotations

import re as _re
from collections import defaultdict
from typing import TYPE_CHECKING

from src.maxpat.db_lookup import ObjectDatabase
from src.maxpat.maxclass_map import is_ui_object, UI_MAXCLASSES

if TYPE_CHECKING:
    from src.maxpat.patcher import Patcher


# ---------------------------------------------------------------------------
# Structural maxclasses that are skipped during object existence checks.
# These are patcher infrastructure, not user-created objects.
# ---------------------------------------------------------------------------
_STRUCTURAL_MAXCLASSES = frozenset({"inlet", "outlet", "patcher", "bpatcher"})

# Oscillator objects that need gain staging before dac~/ezdac~
_OSCILLATOR_NAMES = frozenset({
    "cycle~", "saw~", "rect~", "tri~", "noise~", "pink~",
})

# Gain objects that attenuate signal
_GAIN_NAMES = frozenset({"*~", "gain~"})

# Terminal signal objects (signal chain ends here, not unterminated)
_TERMINAL_NAMES = frozenset({"dac~", "ezdac~", "send~", "out~"})

# Objects that provide delay in a feedback loop
_DELAY_NAMES = frozenset({"tapin~", "tapout~", "gen~"})


# Role-aware connection tier table (D-04, D-19, VALID-01). Maps
# (src_outlet_role, dst_inlet_kind) -> (level, suggestion, auto_fix).
# Absent keys mean "fall through to legacy signal:bool branch unchanged"
# (D-02). Audio-source keys are INTENTIONALLY ABSENT — the legacy branch
# retains exclusive control of audio source paths so existing
# test_signal_to_signal_passes / test_signal_to_control_only_inlet_detected
# regression anchors remain unchanged (RESEARCH.md R2, R10).
_ROLE_TIER_TABLE: dict[tuple[str, str], tuple[str, str, bool]] = {
    # ERROR + auto-remove (mechanical fix exists)
    ("status",  "signal"): ("error", "use snapshot~", True),
    ("trigger", "signal"): ("error", "use sig~ or click~", True),
    ("data",    "signal"): ("error", "role mismatch; data outlet cannot drive signal inlet", True),
    ("list",    "signal"): ("error", "role mismatch; list outlet cannot drive signal inlet", True),
    # WARNING + preserve (judgment-laden intent)
    ("trigger", "float"):  ("warning", "trigger feeding float; user may intend bang counting", False),
    ("list",    "float"):  ("warning", "list outlet feeding float; bach.* often does this — verify", False),
}


# UI maxclasses whose primary inlet displays a float number. The DB
# annotates these inlets as type="control" because they accept any control
# message, but for role-aware tier-table lookup they classify as "float"
# (so trigger/list -> flonum/number triggers the WARNING tier). Keep this
# list narrow: only widgets whose inlet 0 explicitly stores/displays a
# numeric value.
_FLOAT_DISPLAY_MAXCLASSES = frozenset({
    "flonum", "number", "live.numbox",
})


# ===========================================================================
# ValidationResult
# ===========================================================================

class ValidationResult:
    """A single validation finding.

    Attributes:
        layer: Which validation layer produced this ("json", "objects",
               "connections", "domain").
        level: Severity ("error", "warning", "info", "fixed").
        message: Human-readable description.
        auto_fixed: True if the issue was automatically resolved.
    """

    __slots__ = ("layer", "level", "message", "auto_fixed")

    def __init__(
        self,
        layer: str,
        level: str,
        message: str,
        auto_fixed: bool = False,
    ):
        self.layer = layer
        self.level = level
        self.message = message
        self.auto_fixed = auto_fixed

    def __repr__(self) -> str:
        return f"[{self.layer}:{self.level}] {self.message}"


# ===========================================================================
# Public API
# ===========================================================================

def validate_patch(
    patch,
    db: ObjectDatabase | None = None,
    allowed_packages: list[str] | None = None,
) -> list[ValidationResult]:
    """Run the full four-layer validation pipeline on a patch.

    Args:
        patch: Either a Patcher instance or a raw dict in .maxpat format.
        db: ObjectDatabase for lookups. If *patch* is a Patcher instance
            and *db* is None, the Patcher's own db is used.
        allowed_packages: Package filter for Layer 2c. None=skip package
            check (default), []=core only, ["BEAP"]=core+BEAP objects.
            If *patch* is a Patcher instance and *allowed_packages* is
            None, the Patcher's own allowed_packages is used.

    Returns:
        Combined list of ValidationResult from all layers.
    """
    # Import here to avoid circular imports at module level
    from src.maxpat.patcher import Patcher as PatcherClass

    # Accept Patcher instance: extract db and convert to dict
    if isinstance(patch, PatcherClass):
        if db is None:
            db = patch.db
        if allowed_packages is None:
            allowed_packages = getattr(patch, "allowed_packages", None)
        patch_dict = patch.to_dict()
    else:
        patch_dict = patch

    if db is None:
        db = ObjectDatabase()

    results: list[ValidationResult] = []

    # Layer 1: JSON structure
    layer1 = _validate_json_structure(patch_dict)
    results.extend(layer1)
    if any(r.level == "error" for r in layer1):
        return results  # Stop early -- structure is broken

    # Layer 2: Object existence
    results.extend(_validate_objects_exist(patch_dict, db))

    # Layer 2b: Maxclass usage (non-UI objects should use "newobj")
    results.extend(_validate_maxclass_usage(patch_dict))

    # Layer 2c: Package gating (defense in depth)
    results.extend(_validate_package_gating(patch_dict, db, allowed_packages))

    # Layer 2d: Community package extracted check
    results.extend(_validate_community_extracted(patch_dict, db))

    # Layer 3: Connection bounds and signal types (mutates lines in-place)
    results.extend(_validate_connections(patch_dict, db))

    # Layer 4: Domain-specific rules
    results.extend(_validate_domain_rules(patch_dict, db))

    # Layer 4b: Domain restriction guard (Phase 29 / VALID-02)
    results.extend(_validate_domain_restrictions(patch_dict, db))

    return results


def has_blocking_errors(results: list[ValidationResult]) -> bool:
    """Check whether any unfixable errors exist.

    Auto-fixed errors (auto_fixed=True) do NOT block output.
    Warnings and info results do NOT block output.

    Returns:
        True if output should be blocked.
    """
    return any(r.level == "error" and not r.auto_fixed for r in results)


# ===========================================================================
# Layer 1: JSON Structure
# ===========================================================================

def _validate_json_structure(patch_dict: dict) -> list[ValidationResult]:
    """Check that the patch dict has the required .maxpat structure."""
    results: list[ValidationResult] = []

    if "patcher" not in patch_dict:
        results.append(ValidationResult(
            "json", "error",
            "Missing 'patcher' key at top level",
        ))
        return results

    patcher = patch_dict["patcher"]

    if not isinstance(patcher.get("boxes"), list):
        results.append(ValidationResult(
            "json", "error",
            "Missing or invalid 'boxes' array in patcher",
        ))

    if not isinstance(patcher.get("lines"), list):
        results.append(ValidationResult(
            "json", "error",
            "Missing or invalid 'lines' array in patcher",
        ))

    return results


# ===========================================================================
# Layer 2: Object Existence
# ===========================================================================

def _extract_object_name(box_dict: dict) -> str | None:
    """Extract the MAX object name from a box dict.

    For maxclass=="newobj", the name is the first token of the "text" field.
    For UI maxclasses, the name is the maxclass itself.
    Structural maxclasses (inlet, outlet, patcher, bpatcher) return None
    to signal they should be skipped.
    """
    maxclass = box_dict.get("maxclass", "")

    if maxclass in _STRUCTURAL_MAXCLASSES:
        return None

    if maxclass == "newobj":
        text = box_dict.get("text", "")
        if text:
            return text.split()[0]
        return None

    # UI objects: the maxclass IS the object name
    return maxclass


def _validate_objects_exist(
    patch_dict: dict,
    db: ObjectDatabase,
) -> list[ValidationResult]:
    """Check every object in the patch exists in the database."""
    results: list[ValidationResult] = []

    for box_entry in patch_dict["patcher"]["boxes"]:
        box = box_entry.get("box", {})
        name = _extract_object_name(box)

        if name is None:
            continue  # structural maxclass -- skip

        # Check existence (resolves aliases internally)
        if db.exists(name):
            continue

        # Check if it is a PD object with a MAX equivalent
        if db.is_pd_object(name):
            equivalent = db.get_pd_equivalent(name)
            results.append(ValidationResult(
                "objects", "error",
                f"'{name}' is a Pure Data object, not MAX. "
                f"Use {equivalent} instead.",
            ))
        else:
            # Check if it is a known UI maxclass that might not be in the db
            if is_ui_object(name):
                continue  # UI objects may not have db entries; that is OK
            results.append(ValidationResult(
                "objects", "warning",
                f"Unknown object: '{name}' -- not in database",
            ))

    return results


def _validate_maxclass_usage(patch_dict: dict) -> list[ValidationResult]:
    """Check that non-UI objects use maxclass='newobj', not their own name.

    Objects whose maxclass is neither 'newobj' nor a known UI maxclass are
    authored with incorrect maxclass values. For example, a box with
    maxclass='cycle~' instead of maxclass='newobj' with text='cycle~' will
    not load correctly in MAX (raises "invalid attribute maxclass" errors).

    Skips:
    - Structural maxclasses (inlet, outlet, patcher, bpatcher).
    - Boxes with an embedded ``patcher`` key (legitimate subpatcher
      containers like ``gen~``, ``poly~``, ``rnbo~``, ``codebox`` in
      embedded mode that carry their own maxclass with an inline patcher).

    Emits ``error`` (not warning) — this is a hard correctness check.
    """
    results: list[ValidationResult] = []

    for box_entry in patch_dict["patcher"]["boxes"]:
        box = box_entry.get("box", {})
        maxclass = box.get("maxclass", "")

        # Skip structural maxclasses
        if maxclass in _STRUCTURAL_MAXCLASSES:
            continue

        # Subpatcher containers (gen~, poly~, rnbo~, codebox in embedded mode)
        # carry their own maxclass legitimately when an embedded `patcher` key
        # is present.
        if "patcher" in box:
            continue

        # newobj is always correct for non-UI objects
        if maxclass == "newobj":
            continue

        # Known UI maxclasses are correct when used as their own maxclass
        if maxclass in UI_MAXCLASSES:
            continue

        # Non-UI, non-structural maxclass that isn't newobj -- flag as error.
        name = _extract_object_name(box) or maxclass
        results.append(ValidationResult(
            "objects", "error",
            f"Wrong maxclass: object '{name}' uses maxclass='{maxclass}' "
            f"but should use maxclass='newobj' with text='{name} ...' "
            f"(only UI widgets use their own name as maxclass; see "
            f"UI_MAXCLASSES in src/maxpat/maxclass_map.py)",
        ))

    return results


# ===========================================================================
# Layer 2c: Package Gating (Defense in Depth)
# ===========================================================================

def _validate_package_gating(
    patch_dict: dict,
    db: ObjectDatabase,
    allowed_packages: list[str] | None,
) -> list[ValidationResult]:
    """Check that no objects from non-allowed packages appear in the patch.

    This is defense-in-depth: Patcher-level gating should catch these during
    generation, but this catches violations in loaded/edited patches.

    Args:
        patch_dict: The .maxpat-style dict to validate.
        db: ObjectDatabase for package lookups.
        allowed_packages: Package filter. None=skip check, []=core only,
            ["BEAP"]=core+BEAP objects.

    Returns:
        List of ValidationResult for package violations.
    """
    if allowed_packages is None:
        return []  # No package config -- skip check

    results: list[ValidationResult] = []
    for box_entry in patch_dict["patcher"]["boxes"]:
        box = box_entry.get("box", {})
        name = _extract_object_name(box)
        if name is None:
            continue
        package = db.get_package(name)
        if package and package not in allowed_packages:
            results.append(ValidationResult(
                "packages", "error",
                f"Object '{name}' from package '{package}' not in allowed "
                f"packages (allowed: {allowed_packages})",
            ))
    return results


# ===========================================================================
# Layer 2d: Community Package Extracted Check
# ===========================================================================

def _validate_community_extracted(
    patch_dict: dict,
    db: ObjectDatabase,
) -> list[ValidationResult]:
    """Layer 2d: Warn when patch uses objects from unextracted community packages.

    Per D-07/D-09: Block generation with community packages that have not been
    locally extracted. The check uses the ``extracted`` flag in package_info.json
    (no filesystem probing).
    """
    results: list[ValidationResult] = []
    warned_packages: set[str] = set()

    for box_entry in patch_dict["patcher"]["boxes"]:
        box = box_entry.get("box", {})
        name = _extract_object_name(box)
        if name is None:
            continue
        package = db.get_package(name)
        if package is None or package in warned_packages:
            continue
        info = db.get_package_info(package)
        if info is None:
            continue
        tier = info.get("tier", "")
        if tier not in ("community", "licensed"):
            continue  # Bundled packages always available
        if info.get("extracted", False):
            continue  # Already extracted locally

        warned_packages.add(package)
        install_method = info.get("install_method", "package_manager")

        # IRCAM Spat gets a specific message per RESEARCH.md
        if package == "IRCAM Spat":
            msg = (
                "IRCAM Spat is not extracted. "
                "Download from https://forum.ircam.fr/projects/detail/spat/ "
                "(free IRCAM Forum account required), copy the spat5 folder to "
                "~/Documents/Max 9/Packages/, then run: "
                "python .claude/scripts/extract_objects.py --package \"IRCAM Spat\""
            )
        elif install_method == "package_manager":
            msg = (
                f"{package} is not extracted. "
                f"Install via MAX Package Manager (Help -> Package Manager -> search '{package}'), "
                f"then run: python .claude/scripts/extract_objects.py --package \"{package}\""
            )
        else:
            msg = (
                f"{package} is not extracted. "
                f"Download from the official source and copy to ~/Documents/Max 9/Packages/, "
                f"then run: python .claude/scripts/extract_objects.py --package \"{package}\""
            )

        results.append(ValidationResult("packages", "warning", msg))

    return results


# ===========================================================================
# Layer 3: Connection Validation (Bounds + Signal Types)
# ===========================================================================

def _validate_connections(
    patch_dict: dict,
    db: ObjectDatabase,
) -> list[ValidationResult]:
    """Validate connection index bounds and signal/control type compatibility.

    Invalid connections are removed from patch_dict["patcher"]["lines"]
    in-place (auto-fix) and reported with auto_fixed=True.
    """
    results: list[ValidationResult] = []

    # Build box lookup: id -> box dict
    box_lookup: dict[str, dict] = {}
    for box_entry in patch_dict["patcher"]["boxes"]:
        box = box_entry.get("box", {})
        box_id = box.get("id")
        if box_id:
            box_lookup[box_id] = box

    lines = patch_dict["patcher"]["lines"]
    to_remove: list[int] = []  # indices of lines to remove

    for idx, line_entry in enumerate(lines):
        patchline = line_entry.get("patchline", {})
        source = patchline.get("source", [])
        destination = patchline.get("destination", [])

        if len(source) < 2 or len(destination) < 2:
            results.append(ValidationResult(
                "connections", "error",
                f"Malformed patchline at index {idx}: "
                f"source={source}, destination={destination}",
                auto_fixed=True,
            ))
            to_remove.append(idx)
            continue

        src_id, src_outlet = source[0], source[1]
        dst_id, dst_inlet = destination[0], destination[1]

        src_box = box_lookup.get(src_id)
        dst_box = box_lookup.get(dst_id)

        if src_box is None or dst_box is None:
            results.append(ValidationResult(
                "connections", "error",
                f"Connection references missing box: "
                f"source={src_id}, dest={dst_id}",
                auto_fixed=True,
            ))
            to_remove.append(idx)
            continue

        remove_this = False

        # --- Check outlet bounds ---
        src_numoutlets = src_box.get("numoutlets", 0)
        if src_outlet >= src_numoutlets:
            results.append(ValidationResult(
                "connections", "error",
                f"Outlet index {src_outlet} out of bounds on '{src_id}' "
                f"(has {src_numoutlets} outlet(s)) -- connection removed",
                auto_fixed=True,
            ))
            remove_this = True

        # --- Check inlet bounds ---
        dst_numinlets = dst_box.get("numinlets", 0)
        if dst_inlet >= dst_numinlets:
            results.append(ValidationResult(
                "connections", "error",
                f"Inlet index {dst_inlet} out of bounds on '{dst_id}' "
                f"(has {dst_numinlets} inlet(s)) -- connection removed",
                auto_fixed=True,
            ))
            remove_this = True

        # --- Role-aware tier dispatch (VALID-01, D-01..D-04) ---
        # Runs BEFORE legacy signal:bool check. When src outlet has a
        # curated signal_role (Phase 28), look up (role, dst_kind) in
        # _ROLE_TIER_TABLE. Hit -> emit and skip legacy branch (D-02).
        # Miss / None / audio source -> fall through unchanged.
        if not remove_this:
            src_name = _extract_object_name(src_box)
            if src_name is not None:
                src_role = db.get_signal_role(src_name, src_outlet)
                if src_role is not None and src_role != "audio":
                    tier = _classify_role_mismatch(
                        src_role, dst_box, dst_inlet, db
                    )
                    if tier is not None:
                        level, _dst_kind, message, auto_fix = tier
                        results.append(ValidationResult(
                            "connections", level, message,
                            auto_fixed=auto_fix,
                        ))
                        if auto_fix:
                            remove_this = True
                            to_remove.append(idx)
                        # Tier result is final — skip legacy is_signal_source
                        # branch for this line (D-02 clean separation).
                        continue

        # --- Signal type compatibility (only if bounds are OK) ---
        if not remove_this:
            src_outlettype = src_box.get("outlettype", [])
            is_signal_source = (
                src_outlet < len(src_outlettype)
                and src_outlettype[src_outlet] == "signal"
            )

            if is_signal_source:
                # Guard: non-overridden MSP objects have unverified outlet types.
                # The MSP domain extraction marked ALL outlets as signal=true,
                # so for uncorrected objects a valid control outlet would be
                # incorrectly flagged. Emit a warning and preserve the connection.
                src_name = _extract_object_name(src_box)
                if src_name and src_name.endswith("~") and not db.is_overridden(src_name):
                    results.append(ValidationResult(
                        "connections", "warning",
                        f"Unverified outlet types: '{src_name}' outlet "
                        f"{src_outlet} -> '{dst_id}' inlet {dst_inlet} "
                        f"-- source MSP object not in overrides, "
                        f"connection preserved",
                        auto_fixed=False,
                    ))
                else:
                    # Overridden MSP or non-MSP: apply existing auto-removal
                    dst_accepts_signal = _inlet_accepts_signal(dst_box, dst_inlet, db)
                    if not dst_accepts_signal:
                        results.append(ValidationResult(
                            "connections", "error",
                            f"Signal outlet to control-only inlet: "
                            f"'{src_id}' outlet {src_outlet} -> "
                            f"'{dst_id}' inlet {dst_inlet} -- connection removed",
                            auto_fixed=True,
                        ))
                        remove_this = True

        if remove_this:
            to_remove.append(idx)

    # Remove invalid connections in reverse order to preserve indices
    for idx in reversed(to_remove):
        lines.pop(idx)

    return results


def _inlet_accepts_signal(box_dict: dict, inlet_idx: int, db: ObjectDatabase) -> bool:
    """Determine if a specific inlet on a box can accept a signal connection.

    Per CLAUDE.md: "signal/float inlets accept both signal and control connections."
    So we only return False when the inlet is purely control-only (signal: false
    and not a signal/float type).
    """
    # Try to get inlet info from the database
    name = _extract_object_name(box_dict)
    if name is None:
        return True  # structural objects -- allow anything

    obj_data = db.lookup(name)
    if obj_data is None:
        # Unknown object -- be permissive
        return True

    inlets = obj_data.get("inlets", [])
    if inlet_idx < len(inlets):
        inlet = inlets[inlet_idx]
        # If the inlet is marked as signal, it accepts signal
        if inlet.get("signal"):
            return True
        # Check the type field for "signal/float" pattern
        inlet_type = inlet.get("type", "").lower()
        if "signal" in inlet_type:
            return True
        # Purely control inlet
        return False

    # Inlet index beyond what database knows (e.g., variable I/O)
    # Be permissive
    return True


def _classify_dst_inlet(dst_box: dict, dst_inlet: int, db: ObjectDatabase) -> str:
    """Classify a destination inlet for role-aware tier-table lookup.

    Returns one of:
      "signal"   — inlet accepts signal (includes signal/float hybrid inlets;
                   the tier table treats both as a mechanical-fix mismatch
                   when the source role is status/trigger/data/list)
      "float"    — inlet stores/displays a numeric value (UI float widgets
                   like flonum/number, or control inlets with type='float')
      "control"  — generic control inlet OR unknown / structural box

    Used by _classify_role_mismatch to look up the dst_kind side of
    _ROLE_TIER_TABLE keys (D-04 message-format requirement).
    """
    # UI maxclass float-display widgets (flonum, number, live.numbox) carry
    # type="control" inlets in the DB but are float-display by nature — the
    # WARNING tier (trigger/list -> float) targets these by intent.
    maxclass = dst_box.get("maxclass", "")
    if maxclass in _FLOAT_DISPLAY_MAXCLASSES and dst_inlet == 0:
        return "float"

    name = _extract_object_name(dst_box)
    if name is None:
        return "control"  # structural maxclass; conservative
    obj = db.lookup(name)
    if obj is None:
        return "control"
    inlets = obj.get("inlets", [])
    if dst_inlet >= len(inlets):
        return "control"
    inlet = inlets[dst_inlet]
    inlet_type = (inlet.get("type") or "").lower()
    # "signal/float" inlets are still classified as "signal" for tier-table
    # purposes: a status/trigger/list/data outlet is an event-message stream,
    # not a numeric value, so the mechanical-fix tier still applies (snapshot~,
    # sig~, etc.). The tier table itself decides what's a mismatch — the
    # dst-kind label is intentionally coarse here.
    if inlet.get("signal"):
        return "signal"
    if "float" in inlet_type or inlet_type == "float":
        return "float"
    return "control"


def _classify_role_mismatch(
    src_role: str,
    dst_box: dict,
    dst_inlet: int,
    db: ObjectDatabase,
) -> tuple[str, str, str, bool] | None:
    """Look up (src_role, dst_kind) in _ROLE_TIER_TABLE.

    Returns (level, dst_kind, message, auto_fix) when a tier-table entry
    matches, or None to signal "fall through to legacy signal:bool branch"
    (D-02).

    Per D-04, the message is formatted as
    "{src_role} outlet → {dst_kind} inlet: {suggestion}" — concrete and
    suggestion-bearing, never generic "type mismatch".
    """
    dst_kind = _classify_dst_inlet(dst_box, dst_inlet, db)
    entry = _ROLE_TIER_TABLE.get((src_role, dst_kind))
    if entry is None:
        return None
    level, suggestion, auto_fix = entry
    message = f"{src_role} outlet → {dst_kind} inlet: {suggestion}"
    return (level, dst_kind, message, auto_fix)


# ===========================================================================
# Layer 4: Domain-Specific Rules
# ===========================================================================

def _validate_domain_rules(
    patch_dict: dict,
    db: ObjectDatabase,
) -> list[ValidationResult]:
    """Check domain-specific rules for MSP signal chains."""
    results: list[ValidationResult] = []

    boxes = patch_dict["patcher"]["boxes"]
    lines = patch_dict["patcher"]["lines"]

    # Build lookup structures
    box_lookup: dict[str, dict] = {}
    for box_entry in boxes:
        box = box_entry.get("box", {})
        box_id = box.get("id")
        if box_id:
            box_lookup[box_id] = box

    # Build signal graph (adjacency list): src_id -> list of dst_ids
    signal_adj: dict[str, list[str]] = defaultdict(list)
    # Also track which boxes have signal connections going OUT and IN
    has_signal_out: set[str] = set()
    has_signal_in: set[str] = set()

    for line_entry in lines:
        patchline = line_entry.get("patchline", {})
        source = patchline.get("source", [])
        destination = patchline.get("destination", [])
        if len(source) < 2 or len(destination) < 2:
            continue

        src_id, src_outlet = source[0], source[1]
        dst_id = destination[0]

        src_box = box_lookup.get(src_id)
        if not src_box:
            continue

        # Determine if this is a signal connection
        src_outlettype = src_box.get("outlettype", [])
        is_signal = (
            src_outlet < len(src_outlettype)
            and src_outlettype[src_outlet] == "signal"
        )

        if is_signal:
            signal_adj[src_id].append(dst_id)
            has_signal_out.add(src_id)
            has_signal_in.add(dst_id)

    # Build control adjacency: src_id -> list of dst_ids (non-signal connections)
    ctrl_adj: dict[str, list[str]] = defaultdict(list)

    for line_entry in lines:
        patchline = line_entry.get("patchline", {})
        source = patchline.get("source", [])
        destination = patchline.get("destination", [])
        if len(source) < 2 or len(destination) < 2:
            continue

        src_id, src_outlet = source[0], source[1]
        dst_id = destination[0]

        src_box = box_lookup.get(src_id)
        if not src_box:
            continue

        src_outlettype = src_box.get("outlettype", [])
        is_sig = (
            src_outlet < len(src_outlettype)
            and src_outlettype[src_outlet] == "signal"
        )
        if not is_sig:
            ctrl_adj[src_id].append(dst_id)

    # --- Rule: Compound #N argument substitution ---
    results.extend(_check_compound_argument_substitution(box_lookup))

    # --- Rule: Unterminated signal chains ---
    results.extend(_check_unterminated_chains(box_lookup, has_signal_out))

    # --- Rule: Missing gain staging ---
    results.extend(_check_gain_staging(box_lookup, signal_adj))

    # --- Rule: Unsafe gain values ---
    results.extend(_check_unsafe_gain_values(box_lookup))

    # --- Rule: Feedback loop detection ---
    results.extend(_check_feedback_loops(box_lookup, signal_adj))

    # --- Rule: GenExpr I/O syntax ---
    results.extend(_check_genexpr_io_syntax(box_lookup))

    # --- Rule: GenExpr delay usage ---
    results.extend(_check_genexpr_delay_usage(box_lookup))

    # --- Rule: gen~ @param message syntax ---
    results.extend(_check_gen_param_message_syntax(box_lookup, ctrl_adj))

    # --- Rule: Comment #N substitution ---
    results.extend(_check_comment_hash_substitution(box_lookup))

    # --- Rule: line~ comma messages ---
    results.extend(_check_line_tilde_comma_messages(box_lookup, ctrl_adj))

    # --- Rule: multislider fetchindex ---
    results.extend(_check_multislider_fetchindex(box_lookup))

    # --- Rule: umenu items format ---
    results.extend(_check_umenu_items_format(box_lookup))

    # --- Rule: Assistance comments ---
    results.extend(_check_assistance_comments(box_lookup))

    return results


# ===========================================================================
# Layer 4b: Domain Restriction Guard (Phase 29 / VALID-02 / D-05..D-08)
# ===========================================================================

def _validate_domain_restrictions(
    patch_dict: dict,
    db: ObjectDatabase,
) -> list[ValidationResult]:
    """Hard-block top-level boxes whose domain_restricted whitelist forbids
    the outer (non-rnbo, non-m4l, non-gen) MSP/Max context.

    Per D-05: explicit `domain_restricted` only — no canonical-domain
    inference. Per D-07: top-level scope only — no recursion into
    subpatchers or rnbo~ inner patchers. Per D-08: always ERROR severity,
    auto_fixed=False (auto-removing the box would mangle the patch; emit
    error and let the caller decide).

    Catches the canonical violation (`floor~` at MSP top level outside
    an `rnbo~` container) and stays simple. Edge cases like nested
    `p subpatcher` containing a domain-restricted object outside any
    rnbo~ are explicitly out of scope this phase (D-07).
    """
    results: list[ValidationResult] = []
    for box_entry in patch_dict["patcher"]["boxes"]:
        box = box_entry.get("box", {})
        name = _extract_object_name(box)
        if name is None:
            continue
        restrictions = db.get_domain_restrictions(name)
        if not restrictions:
            continue
        # Top-level patcher is by definition NOT inside any rnbo~/m4l/gen~
        # container. Any restriction list is a violation here (D-07).
        results.append(ValidationResult(
            "domain", "error",
            f"'{name}' is restricted to {restrictions}; "
            f"not allowed at MSP/Max top level. "
            f"Wrap in {restrictions[0]}~ container or use a non-restricted equivalent.",
            auto_fixed=False,
        ))
    return results


def _get_box_name(box_dict: dict) -> str:
    """Get the object name from a box dict."""
    maxclass = box_dict.get("maxclass", "")
    if maxclass == "newobj":
        text = box_dict.get("text", "")
        if text:
            return text.split()[0]
        return ""
    return maxclass


# Pattern matching compound #N usage: text containing #N preceded or followed
# by non-whitespace characters (e.g., "slot-#1", "#1-out", "my#2thing").
# Standalone #N (space-delimited or at start/end of text) is fine.
_COMPOUND_ARG_PATTERN = _re.compile(r'(?:\S)#\d+|#\d+(?=\S)')


def _check_compound_argument_substitution(
    box_lookup: dict[str, dict],
) -> list[ValidationResult]:
    """Warn about compound #N argument substitution in object/message text.

    In bpatchers and abstractions, #1 etc. must be standalone tokens.
    Compound forms like 'slot-#1' or '#1-out' do not substitute correctly.
    """
    results: list[ValidationResult] = []

    for box_id, box in box_lookup.items():
        text = box.get("text", "")
        if not text:
            continue

        # Only check objects/messages that actually use #N
        if "#" not in text:
            continue

        matches = _COMPOUND_ARG_PATTERN.findall(text)
        if matches:
            results.append(ValidationResult(
                "domain", "warning",
                f"Compound #N substitution in '{text}' ({box_id}) -- "
                f"#N must be a standalone token (e.g., 'buffer~ #1' not "
                f"'buffer~ slot-#1'). Pass the full name as the bpatcher arg.",
            ))

    return results


def _check_unterminated_chains(
    box_lookup: dict[str, dict],
    has_signal_out: set[str],
) -> list[ValidationResult]:
    """Find MSP objects with signal outlets but no downstream signal connection.

    Exceptions: dac~, ezdac~, send~, out~ (terminals), and objects that
    do have a downstream signal connection.
    """
    results: list[ValidationResult] = []

    for box_id, box in box_lookup.items():
        name = _get_box_name(box)

        # Only check MSP objects (name ends with ~)
        if not name.endswith("~"):
            continue

        # Skip terminal objects
        if name in _TERMINAL_NAMES:
            continue

        # Check if this object has signal outlets
        outlettype = box.get("outlettype", [])
        has_signal_outlet = any(ot == "signal" for ot in outlettype)
        if not has_signal_outlet:
            continue

        # Check if it has any downstream signal connection
        if box_id in has_signal_out:
            continue

        results.append(ValidationResult(
            "domain", "warning",
            f"Unterminated signal chain: '{name}' ({box_id}) has signal "
            f"outlet(s) but no downstream signal connection",
        ))

    return results


def _check_gain_staging(
    box_lookup: dict[str, dict],
    signal_adj: dict[str, list[str]],
) -> list[ValidationResult]:
    """Detect direct connections from oscillators to dac~/ezdac~ without gain.

    Uses BFS from each oscillator. If it reaches a dac~/ezdac~ without passing
    through a gain object (*~, gain~), emit a warning.
    """
    results: list[ValidationResult] = []

    # Find all oscillator box ids
    osc_ids = []
    for box_id, box in box_lookup.items():
        name = _get_box_name(box)
        if name in _OSCILLATOR_NAMES:
            osc_ids.append(box_id)

    # For each oscillator, BFS to see if it reaches dac~/ezdac~ without gain
    for osc_id in osc_ids:
        osc_name = _get_box_name(box_lookup[osc_id])
        # BFS: track (current_id, passed_through_gain)
        from collections import deque
        queue = deque([(osc_id, False)])
        visited: set[tuple[str, bool]] = set()

        while queue:
            current_id, has_gain = queue.popleft()
            if (current_id, has_gain) in visited:
                continue
            visited.add((current_id, has_gain))

            for next_id in signal_adj.get(current_id, []):
                next_box = box_lookup.get(next_id)
                if not next_box:
                    continue
                next_name = _get_box_name(next_box)

                next_has_gain = has_gain or (next_name in _GAIN_NAMES)

                # Reached dac~/ezdac~
                if next_name in ("dac~", "ezdac~"):
                    if not next_has_gain:
                        results.append(ValidationResult(
                            "domain", "warning",
                            f"Missing gain staging: '{osc_name}' ({osc_id}) "
                            f"connected to '{next_name}' ({next_id}) without "
                            f"passing through a gain object (*~ or gain~)",
                        ))
                    # Don't continue past dac~
                    continue

                queue.append((next_id, next_has_gain))

    return results


def _check_unsafe_gain_values(
    box_lookup: dict[str, dict],
) -> list[ValidationResult]:
    """Detect *~ objects with literal gain arguments > 1.0.

    A *~ with a constant multiplier > 1.0 amplifies signal beyond unity gain,
    which is dangerous for audio output. Values <= 1.0 are safe.
    """
    results: list[ValidationResult] = []

    for box_id, box in box_lookup.items():
        name = _get_box_name(box)
        if name != "*~":
            continue

        text = box.get("text", "")
        parts = text.split()
        if len(parts) < 2:
            continue  # No argument -- skip

        arg_str = parts[1]
        try:
            arg_val = float(arg_str)
        except ValueError:
            continue  # Not a number literal (could be a variable)

        if arg_val > 1.0:
            results.append(ValidationResult(
                "domain", "warning",
                f"Unsafe gain multiplier: '*~ {arg_str}' ({box_id}) has value "
                f"> 1.0 -- gain values should be 0.0-1.0 to prevent dangerous "
                f"audio levels",
            ))

    return results


def _check_feedback_loops(
    box_lookup: dict[str, dict],
    signal_adj: dict[str, list[str]],
) -> list[ValidationResult]:
    """Detect signal feedback loops without delay objects.

    Uses DFS cycle detection. If a cycle is found and none of its nodes are
    tapin~, tapout~, or gen~, emit a warning.
    """
    results: list[ValidationResult] = []

    # Standard DFS cycle detection with path tracking
    WHITE, GRAY, BLACK = 0, 1, 2
    color: dict[str, int] = defaultdict(int)  # default WHITE
    parent: dict[str, str | None] = {}
    cycles_found: list[list[str]] = []

    def dfs(node: str, path: list[str]) -> None:
        color[node] = GRAY
        path.append(node)

        for neighbor in signal_adj.get(node, []):
            if color[neighbor] == GRAY:
                # Found a back edge -- extract cycle
                cycle_start = path.index(neighbor)
                cycle = path[cycle_start:]
                cycles_found.append(list(cycle))
            elif color[neighbor] == WHITE:
                parent[neighbor] = node
                dfs(neighbor, path)

        path.pop()
        color[node] = BLACK

    # Run DFS from all nodes
    all_nodes = set(signal_adj.keys())
    for targets in signal_adj.values():
        all_nodes.update(targets)

    for node in all_nodes:
        if color[node] == WHITE:
            dfs(node, [])

    # Check each cycle for delay objects
    reported_cycles: set[frozenset[str]] = set()
    for cycle in cycles_found:
        cycle_key = frozenset(cycle)
        if cycle_key in reported_cycles:
            continue
        reported_cycles.add(cycle_key)

        # Check if cycle contains delay objects
        cycle_names = [_get_box_name(box_lookup[bid]) for bid in cycle if bid in box_lookup]
        has_delay = any(name in _DELAY_NAMES for name in cycle_names)

        if not has_delay:
            node_desc = ", ".join(
                f"{_get_box_name(box_lookup.get(bid, {}))} ({bid})"
                for bid in cycle
            )
            results.append(ValidationResult(
                "domain", "warning",
                f"Signal feedback loop without delay detected: {node_desc}",
            ))

    return results


# ===========================================================================
# Layer 4: GenExpr and API-usage checks
# ===========================================================================

def _check_genexpr_io_syntax(
    box_lookup: dict[str, dict],
) -> list[ValidationResult]:
    """Catch GenExpr codebox using 'in 1'/'out 2' instead of 'in1'/'out2'."""
    results: list[ValidationResult] = []

    for box_id, box in box_lookup.items():
        if box.get("maxclass") != "newobj":
            continue
        text = box.get("text", "")
        if not text.startswith("codebox"):
            continue
        code = box.get("code", "")
        if not code:
            continue
        if _re.search(r'\b(in|out)\s+\d', code):
            results.append(ValidationResult(
                "domain", "error",
                f"GenExpr codebox uses 'in1'/'out1' (no space), not "
                f"'in 1'/'out 1' ({box_id})",
            ))

    return results


def _check_genexpr_delay_usage(
    box_lookup: dict[str, dict],
) -> list[ValidationResult]:
    """Catch GenExpr codebox using delay() instead of Delay.read()/Delay.write()."""
    results: list[ValidationResult] = []

    for box_id, box in box_lookup.items():
        if box.get("maxclass") != "newobj":
            continue
        text = box.get("text", "")
        if not text.startswith("codebox"):
            continue
        code = box.get("code", "")
        if not code:
            continue
        if _re.search(r'\bdelay\s*\(', code):
            results.append(ValidationResult(
                "domain", "error",
                f"GenExpr uses Delay.read()/Delay.write(), not delay() "
                f"function ({box_id})",
            ))

    return results


def _check_gen_param_message_syntax(
    box_lookup: dict[str, dict],
    ctrl_adj: dict[str, list[str]],
) -> list[ValidationResult]:
    """Catch '@param $1' message syntax connected to gen~ (should be 'param $1')."""
    results: list[ValidationResult] = []

    for box_id, box in box_lookup.items():
        if box.get("maxclass") != "message":
            continue
        text = box.get("text", "")
        if not _re.search(r'@\w+\s+\$', text):
            continue
        # Check if any downstream box is gen~
        for dst_id in ctrl_adj.get(box_id, []):
            dst_box = box_lookup.get(dst_id)
            if not dst_box:
                continue
            dst_name = _get_box_name(dst_box)
            if dst_name == "gen~":
                results.append(ValidationResult(
                    "domain", "warning",
                    f"gen~ params use plain name messages ('depth $1'), "
                    f"not '@depth $1' ({box_id})",
                ))
                break  # one warning per message box

    return results


def _check_comment_hash_substitution(
    box_lookup: dict[str, dict],
) -> list[ValidationResult]:
    """Warn about #N text in comment boxes (comment doesn't support substitution)."""
    results: list[ValidationResult] = []

    for box_id, box in box_lookup.items():
        if box.get("maxclass") != "comment":
            continue
        text = box.get("text", "")
        if _re.search(r'#\d+', text):
            results.append(ValidationResult(
                "domain", "warning",
                f"Comment boxes don't support #N substitution; use "
                f"loadbang -> message -> set chain ({box_id})",
            ))

    return results


def _check_line_tilde_comma_messages(
    box_lookup: dict[str, dict],
    ctrl_adj: dict[str, list[str]],
) -> list[ValidationResult]:
    """Catch messages with commas connected to line~ (commas restart ramps)."""
    results: list[ValidationResult] = []

    for box_id, box in box_lookup.items():
        if box.get("maxclass") != "message":
            continue
        text = box.get("text", "")
        if "," not in text:
            continue
        # Check if any downstream box is line~
        for dst_id in ctrl_adj.get(box_id, []):
            dst_box = box_lookup.get(dst_id)
            if not dst_box:
                continue
            dst_name = _get_box_name(dst_box)
            if dst_name == "line~":
                results.append(ValidationResult(
                    "domain", "warning",
                    f"line~ replaces ramps on new messages; use single list "
                    f"without comma separators ({box_id})",
                ))
                break

    return results


def _check_multislider_fetchindex(
    box_lookup: dict[str, dict],
) -> list[ValidationResult]:
    """Catch messages using 'fetchindex' (doesn't exist; use 'fetch')."""
    results: list[ValidationResult] = []

    for box_id, box in box_lookup.items():
        if box.get("maxclass") != "message":
            continue
        text = box.get("text", "")
        if "fetchindex" in text:
            results.append(ValidationResult(
                "domain", "error",
                f"multislider uses 'fetch' not 'fetchindex'; "
                f"fetchindex does not exist ({box_id})",
            ))

    return results


def _check_umenu_items_format(
    box_lookup: dict[str, dict],
) -> list[ValidationResult]:
    """Catch umenu items without comma separators."""
    results: list[ValidationResult] = []

    for box_id, box in box_lookup.items():
        maxclass = box.get("maxclass", "")
        # umenu can be a UI maxclass or newobj with text "umenu"
        is_umenu = (
            maxclass == "umenu"
            or (maxclass == "newobj" and box.get("text", "").split()[0] == "umenu")
        )
        if not is_umenu:
            continue
        items = box.get("items")
        if not isinstance(items, list):
            continue
        if len(items) <= 1:
            continue
        if "," not in items:
            results.append(ValidationResult(
                "domain", "warning",
                f"umenu items need comma separators: "
                f"['LP', ',', 'HP', ',', 'BP'] ({box_id})",
            ))

    return results


def _check_assistance_comments(
    box_lookup: dict[str, dict],
) -> list[ValidationResult]:
    """Flag inlet/outlet boxes missing assistance comment tooltips."""
    results: list[ValidationResult] = []

    for box_id, box in box_lookup.items():
        maxclass = box.get("maxclass", "")
        if maxclass not in ("inlet", "outlet"):
            continue
        comment = box.get("comment", "")
        if not comment:
            results.append(ValidationResult(
                "domain", "info",
                f"{maxclass} missing assistance comment (tooltip) ({box_id})",
            ))

    return results
