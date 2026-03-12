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
from src.maxpat.maxclass_map import is_ui_object

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
) -> list[ValidationResult]:
    """Run the full four-layer validation pipeline on a patch.

    Args:
        patch: Either a Patcher instance or a raw dict in .maxpat format.
        db: ObjectDatabase for lookups. If *patch* is a Patcher instance
            and *db* is None, the Patcher's own db is used.

    Returns:
        Combined list of ValidationResult from all layers.
    """
    # Import here to avoid circular imports at module level
    from src.maxpat.patcher import Patcher as PatcherClass

    # Accept Patcher instance: extract db and convert to dict
    if isinstance(patch, PatcherClass):
        if db is None:
            db = patch.db
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

    # Layer 3: Connection bounds and signal types (mutates lines in-place)
    results.extend(_validate_connections(patch_dict, db))

    # Layer 4: Domain-specific rules
    results.extend(_validate_domain_rules(patch_dict, db))

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
                "objects", "error",
                f"Unknown object: '{name}' -- not in database",
            ))

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

        # --- Signal type compatibility (only if bounds are OK) ---
        if not remove_this:
            src_outlettype = src_box.get("outlettype", [])
            is_signal_source = (
                src_outlet < len(src_outlettype)
                and src_outlettype[src_outlet] == "signal"
            )

            if is_signal_source:
                # Check if destination inlet accepts signal
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

    # --- Rule: Compound #N argument substitution ---
    results.extend(_check_compound_argument_substitution(box_lookup))

    # --- Rule: Unterminated signal chains ---
    results.extend(_check_unterminated_chains(box_lookup, has_signal_out))

    # --- Rule: Missing gain staging ---
    results.extend(_check_gain_staging(box_lookup, signal_adj))

    # --- Rule: Feedback loop detection ---
    results.extend(_check_feedback_loops(box_lookup, signal_adj))

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
