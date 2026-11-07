"""Object database interface wrapping .claude/max-objects/.

Provides ObjectDatabase class for looking up MAX objects, resolving aliases,
computing variable I/O counts, and checking PD blocklist. This is the single
source of truth for object existence and metadata during patch generation.
"""

import copy
import itertools
import json
import re
import warnings
from collections import defaultdict
from pathlib import Path

from src.maxpat.io_resolvers import IO_RESOLVERS, normalize_args

# Load core domains last so they take priority over RNBO duplicates
# (e.g., MSP cycle~ has 1 outlet, RNBO cycle~ has 2)
DOMAIN_LOAD_ORDER = [
    "rnbo", "packages", "m4l", "gen", "mc", "jitter", "msp", "max"
]

# Formulas accepted by _apply_io_formula (inlet_count / outlet_count).
# Any other value in overrides.json:variable_io_rules is a typo or a
# silently-broken rule that falls back to the default count. The
# ObjectDatabase constructor validates every loaded rule against this set
# (quick-260421-b3a). Special cases:
#   ""                         → use default count (no formula)
#   "inherited_from_subpatch"  → bpatcher: I/O inferred from loaded .maxpat,
#                                not args; _apply_io_formula returns default
SUPPORTED_IO_FORMULAS = frozenset({
    "",
    "arg_count",
    "arg_count+1",
    "arg_count_or_default",
    "first_arg",
    "first_arg+1",
    "second_arg",
    "second_arg+1",
    "second_arg+2",
    "sfplay_outlets",
    "inherited_from_subpatch",
})

# Closed enum for per-outlet signal_role (SCHEMA-01, D-04). Any other value
# in overrides.json:objects[name].outlets[i].signal_role is a typo. The
# ObjectDatabase constructor validates every loaded role against this set,
# mirroring _validate_variable_io_rules (the quick-260421-b3a precedent).
_SIGNAL_ROLE_ENUM = frozenset({
    "audio", "trigger", "status", "float", "data", "list",
})

# Closed enum for per-object domain_restricted whitelist (SCHEMA-03, D-06).
# Means "this object is only legal in the listed domain(s)."
# Adding a new domain later = one-line enum extension.
_DOMAIN_ENUM = frozenset({
    "rnbo", "m4l", "gen",
})

# Maps domain_restricted enum values to the corresponding object 'domain' field
# string. Used by audit_domain_coverage() to detect orphaned restrictions
# (e.g., an override claiming domain_restricted: ["rnbo"] for an object whose
# canonical entry is in the MSP domain JSON, not RNBO).
_DOMAIN_TO_FIELD = {
    "rnbo": "RNBO",
    "m4l": "M4L",
    "gen": "Gen",
}

# ---------------------------------------------------------------------------
# Domain scope (Q12 / review C3)
# ---------------------------------------------------------------------------
# The patcher scopes a box can live in. "max" is any Max/MSP/Jitter/M4L
# patcher; "gen" is a gen~/mc.gen~/jit.gen/jit.pix patcher (or a .gendsp /
# .genjit file); "rnbo" is an rnbo~ patcher (or a .rnbopat file).
DOMAIN_SCOPES = ("max", "gen", "rnbo")

# A name whose DB entries all come from these source directories exists only
# in RNBO and/or Gen: MAX says "No such object" for it in a Max patcher
# (``expr~``, ``wrap~``, ``counter~``, ``history``). Such names are
# implicitly restricted to their source domains unless an explicit
# ``domain_restricted`` key (even ``[]``) says otherwise.
IMPLIED_RESTRICTION_SOURCES = frozenset({"rnbo", "gen"})

# patcher["classnamespace"] -> scope, as MAX writes it (Max 9.2 bundle
# survey: gen~/gen/mcs.gen~ inner patchers carry dsp.gen; jit.gen, jit.pix
# and jit.gl.pix carry jit.gen; rnbo~ inner patchers and .rnbopat carry rnbo).
SCOPE_BY_CLASSNAMESPACE = {"dsp.gen": "gen", "jit.gen": "gen", "rnbo": "rnbo"}

# File suffix -> scope of the file's top-level patcher.
SCOPE_BY_SUFFIX = {".gendsp": "gen", ".genjit": "gen", ".rnbopat": "rnbo"}

# Container objects whose embedded patcher is a Gen / RNBO patcher.
GEN_CONTAINER_NAMES = frozenset({
    "gen~", "mc.gen~", "mcs.gen~", "gen", "jit.gen", "jit.pix", "jit.gl.pix",
})
RNBO_CONTAINER_NAMES = frozenset({"rnbo~", "mc.rnbo~"})


def detect_patcher_scope(patcher_dict: dict, default: str = "max") -> str:
    """Return the scope ("max" / "gen" / "rnbo") of a patcher dict.

    Accepts either a ``{"patcher": {...}}`` file dict or a bare patcher dict.
    Resolution order:

    1. ``classnamespace`` mapped through :data:`SCOPE_BY_CLASSNAMESPACE`;
    2. ``"gen"`` when any top-level box has ``maxclass == "codebox"`` -- MAX
       writes the code box as maxclass ``codebox`` only inside Gen/RNBO
       patchers, and generator-written .gendsp files carry classnamespace
       ``box`` (``generate_gendsp``), so the code box is the reliable mark;
    3. *default*.
    """
    if not isinstance(patcher_dict, dict):
        return default
    patcher = patcher_dict.get("patcher")
    if not isinstance(patcher, dict):
        patcher = patcher_dict
    scope = SCOPE_BY_CLASSNAMESPACE.get(patcher.get("classnamespace"))
    if scope is not None:
        return scope
    for entry in patcher.get("boxes", []) or []:
        box = entry.get("box") if isinstance(entry, dict) else None
        if isinstance(box, dict) and box.get("maxclass") == "codebox":
            return "gen"
    return default


def inner_patcher_scope(box_dict: dict, parent_scope: str) -> str:
    """Return the scope of the patcher embedded in *box_dict*.

    The box name is the first whitespace token of ``text`` for a newobj box,
    else its maxclass. Gen containers (:data:`GEN_CONTAINER_NAMES` or
    maxclass ``gen~``) give ``"gen"``; RNBO containers
    (:data:`RNBO_CONTAINER_NAMES` or maxclass ``rnbo~``) give ``"rnbo"``;
    anything else (``p``, ``bpatcher``, ``poly~`` ...) takes the embedded
    patcher's own classnamespace / codebox scope, defaulting to
    *parent_scope* (subpatchers inherit).
    """
    maxclass = box_dict.get("maxclass", "")
    name = maxclass
    if maxclass == "newobj":
        text = box_dict.get("text")
        tokens = text.split() if isinstance(text, str) else []
        name = tokens[0] if tokens else ""
    if name in GEN_CONTAINER_NAMES or maxclass == "gen~":
        return "gen"
    if name in RNBO_CONTAINER_NAMES or maxclass == "rnbo~":
        return "rnbo"
    return detect_patcher_scope(box_dict.get("patcher") or {}, default=parent_scope)

# Placeholder port text written by the override generator
# (src/maxpat/audit/overrides.py ``_build_outlet_array`` /
# ``_build_inlet_array``). It carries no information, so the per-port merge
# never lets it replace a real base digest/description (Q11 / C6).
OVERRIDE_PLACEHOLDER_DIGESTS = frozenset({"", "Control output", "Signal output"})


def _is_control_port(port: dict) -> bool:
    """True when a base port is control: not ``signal: true`` and no
    "signal" in its (lower-cased) type."""
    if port.get("signal") is True:
        return False
    ptype = port.get("type")
    return not (isinstance(ptype, str) and "signal" in ptype.lower())


def merge_override_ports(base_ports: list, override_ports: list) -> list:
    """Merge an overrides.json ``inlets``/``outlets`` array onto base ports.

    Q11 / C6: override arrays used to replace the base array whole, so a
    generator-written port (digest "Control output", type "") wiped the base
    digest, ``hot`` flag, name and type. Now:

    * The override sets the port COUNT: the result has
      ``len(override_ports)`` entries (longer appends, shorter truncates).
    * Port i with no base port i (or a non-dict on either side) is a shallow
      copy of the override port; a non-dict passes through unchanged (the
      schema validator still rejects it).
    * Otherwise port i starts as a shallow copy of base port i and each
      override key replaces only that key, except:

      - ``digest`` / ``description``: a non-string or placeholder value
        (:data:`OVERRIDE_PLACEHOLDER_DIGESTS`) never replaces a non-empty
        base string;
      - ``type``: ``""`` never replaces a non-empty type on a CONTROL base
        port (on a signal base port the empty type is a real signal ->
        control correction and applies).

    So ``{"id": N}`` inherits base port N unchanged. Inputs are not mutated.
    """
    merged: list = []
    for i, over in enumerate(override_ports):
        base = base_ports[i] if i < len(base_ports) else None
        if not isinstance(over, dict) or not isinstance(base, dict):
            merged.append(dict(over) if isinstance(over, dict) else over)
            continue
        port = dict(base)
        for key, value in over.items():
            if key in ("digest", "description"):
                base_value = base.get(key)
                if (
                    (not isinstance(value, str) or value in OVERRIDE_PLACEHOLDER_DIGESTS)
                    and isinstance(base_value, str) and base_value
                ):
                    continue
            elif key == "type":
                base_type = base.get("type")
                if (
                    value == ""
                    and isinstance(base_type, str) and base_type
                    and _is_control_port(base)
                ):
                    continue
            port[key] = value
        merged.append(port)
    return merged


# Q38: optional bundle-mined DB files (tools/sync_max_bundle.py writes them).
IDIOMS_FILE = "idioms.json"
VERSION_IO_FILE = "version_io.json"

_VERSION_RE = re.compile(r"^\d+(\.\d+){0,2}$")


def parse_version(text) -> tuple[int, int, int]:
    """A Max version string as ``(major, minor, revision)`` (Q38).

    ``"9"`` -> (9, 0, 0), ``"9.0"`` -> (9, 0, 0), ``"9.0.3"`` -> (9, 0, 3),
    ``"9.10"`` -> (9, 10, 0). Only a str of one to three dot-separated ASCII
    decimal parts is accepted; anything else (numbers and bools included)
    raises ValueError.
    """
    if not isinstance(text, str) or not text.isascii() or not _VERSION_RE.match(text):
        raise ValueError(f"not a Max version string: {text!r} (expected e.g. '9', '9.0' or '9.0.3')")
    parts = [int(part) for part in text.split(".")]
    parts += [0] * (3 - len(parts))
    return (parts[0], parts[1], parts[2])

_SIGNAL_OUTLET_TYPES = ("signal", "multichannelsignal")


def saved_outlet_type(outlet) -> str:
    """The ``outlettype`` string MAX saves for DB outlet entry *outlet*.

    ``""`` for a control outlet (or a non-dict); for a signal outlet
    ``"multichannelsignal"`` when its DB type names a multichannel signal
    (contains ``multichannel``, or the extractor's ``mc_signal``), else
    ``"signal"``. overrides.json types every MC-family signal outlet from
    MAX-saved help boxes (CR-01): ``mc.cycle~`` is multichannel,
    ``mc.sum~`` / ``mc.unpack~`` are plain ``signal``.
    """
    if not isinstance(outlet, dict) or not outlet.get("signal"):
        return ""
    otype = outlet.get("type")
    otype = otype.lower() if isinstance(otype, str) else ""
    if "multichannel" in otype or otype == "mc_signal":
        return "multichannelsignal"
    return "signal"


def _is_port_token(text: str) -> bool:
    """A non-negative ASCII decimal port index."""
    return text.isascii() and text.isdigit()


def outlet_signal_class(outlettype, index) -> str | None:
    """Signal class of outlet *index* of a saved ``outlettype`` list (Q38).

    ``"signal"`` for ``signal`` / ``multichannelsignal``, ``"control"`` for
    any other string, None when *outlettype* is not a list, *index* is not
    an int (bools excluded) or is out of range, or the entry is not a str.
    The help-cord miner (``tools/help_io.py``) and the idiom query
    (validation Layer 3, ``Patcher._rewire_type_gated``) share this one
    definition, so a mined key and a queried key always agree.
    """
    if not isinstance(outlettype, list):
        return None
    if not isinstance(index, int) or isinstance(index, bool):
        return None
    if not 0 <= index < len(outlettype):
        return None
    value = outlettype[index]
    if not isinstance(value, str):
        return None
    return "signal" if value in _SIGNAL_OUTLET_TYPES else "control"


class ObjectDatabase:
    """Interface to the MAX object knowledge base.

    Loads all 8 domain JSON files plus supplementary files (aliases, overrides,
    PD blocklist) and provides lookup, existence, I/O computation, and PD
    detection methods.
    """

    def __init__(self, db_root: str | Path | None = None):
        """Initialize the object database.

        Args:
            db_root: Path to the .claude/max-objects/ directory.
                     Defaults to project root / .claude / max-objects.
        """
        if db_root is None:
            # Navigate from this file: src/maxpat/db_lookup.py -> project root
            db_root = Path(__file__).resolve().parents[2] / ".claude" / "max-objects"
        else:
            db_root = Path(db_root)

        # The directory this database was loaded from (the audit merger's
        # rehearsal load mirrors it; CR-02).
        self.db_root: Path = db_root
        self._objects: dict[str, dict] = {}
        self._aliases: dict[str, str] = {}
        self._variable_io_rules: dict[str, dict] = {}
        self._pd_blocklist: dict[str, dict] = {}
        self._package_objects: dict[str, list[str]] = defaultdict(list)
        self._package_info: dict[str, dict] = {}
        # Raw per-file empty-I/O provenance, captured during _load BEFORE the
        # per-port override merge and BEFORE canonical-name shadowing collapses
        # duplicates. Maps source label ("max", "packages/Bach", ...) to the
        # empty-I/O object names in that raw file. Surfaces package entries
        # that self._objects shadows behind populated same-named core entries.
        self._empty_io_by_source: dict[str, list[str]] = defaultdict(list)
        self._empty_io_warned: set[str] = set()
        self._install_warned: set[str] = set()
        self._first_arg_warned: set[tuple[str, str]] = set()
        # Unordered, alias-canonical companion pairs from relationships.json
        # (review A1: Layer 3 never flags a known pair's type/role).
        self._known_pairs: set[frozenset[str]] = set()
        # Q12 / C3: source labels per raw name ("rnbo", "gen", "msp",
        # "packages/Bach", ...) -- later domain loads overwrite
        # self._objects[name], so this is the only record of every file a
        # name appears in. _implied_restrictions holds the derived
        # rnbo/gen-only restriction; _equivalents the alias-canonical
        # relationships.json "equivalent" partners (MAX-equivalent hints).
        self._sources: dict[str, set[str]] = defaultdict(set)
        self._implied_restrictions: dict[str, list[str]] = {}
        self._equivalents: dict[str, list[str]] = defaultdict(list)
        # Review C8 / Q14: inherited group names from groups.json, keyed by
        # canonical name -> profile ids. Merged at call time by messages();
        # never written into self._objects, so lookup() is unchanged.
        self._group_members: dict[str, list[str]] = {}
        self._group_profiles: dict[str, dict] = {}
        self._group_attribute_definitions: dict[str, dict] = {}
        # Q38: cords the bundle's help patches ship, alias-canonical
        # (src, outlet, class, dst, inlet). Layer 3 never type/role-checks one.
        self._idioms: set[tuple[str, int, str, str, int]] = set()
        # (dst, inlet) pairs some shipped idiom feeds with a signal cord;
        # built from _idioms on first use (is_shipped_signal_inlet).
        self._idiom_signal_inlets: frozenset | None = None
        # Q38: per-version I/O changes mined from bundle help boxes
        # (version_io.json), canonical name -> changes sorted by `by`.
        self._version_io: dict[str, list[dict]] = {}
        self._version_io_max_version: str | None = None
        self._load(db_root)

    def _load(self, db_root: Path) -> None:
        """Load all database files from disk."""
        # Load aliases
        aliases_path = db_root / "aliases.json"
        if aliases_path.exists():
            data = json.loads(aliases_path.read_text())
            self._aliases = data.get("aliases", {})

        # Load known companion pairs (after aliases, so names canonicalise).
        # A group of N objects expands to every 2-combination; the file has
        # no direction field, so pairs are unordered.
        relationships_path = db_root / "relationships.json"
        if relationships_path.exists():
            data = json.loads(relationships_path.read_text())
            for entry in data.get("pairs", []):
                names = {
                    self._aliases.get(n, n)
                    for n in entry.get("objects", [])
                    if isinstance(n, str)
                }
                for a, b in itertools.combinations(sorted(names), 2):
                    self._known_pairs.add(frozenset((a, b)))
                # Q12: "equivalent" pairs feed suggest_max_equivalent.
                if entry.get("relationship") == "equivalent":
                    for member in sorted(names):
                        self._equivalents[member] = sorted(names - {member})

        # Parse overrides.json exactly once (quick-260421-b3a FN-02). Both
        # the variable_io_rules registry and the per-object per-port merge
        # payload come from this file; the prior implementation parsed it
        # twice.
        overrides_path = db_root / "overrides.json"
        overrides_data: dict = {}
        if overrides_path.exists():
            overrides_data = json.loads(overrides_path.read_text())
            self._variable_io_rules = overrides_data.get("variable_io_rules", {})

        # Fail fast on unsupported formulas. Any rule whose inlet_count or
        # outlet_count is outside SUPPORTED_IO_FORMULAS (or is not a
        # 'fixed:N' literal) silently falls back to the default count in
        # compute_io_counts — the exact silent-drift bug that let routepass
        # return the right answer for the wrong reason (REVIEW-260420-j15
        # FN-01, DQ-02). This validation makes the bug class impossible at
        # load time.
        self._validate_variable_io_rules()

        # Load PD blocklist
        pd_path = db_root / "pd-blocklist.json"
        if pd_path.exists():
            data = json.loads(pd_path.read_text())
            self._pd_blocklist = data.get("blocklist", {})

        # Load domain objects (core domains last for priority)
        for domain_dir in DOMAIN_LOAD_ORDER:
            if domain_dir == "packages":
                # Scan per-package subdirectories instead of monolithic file
                pkg_root = db_root / "packages"
                if pkg_root.is_dir():
                    for pkg_dir in sorted(pkg_root.iterdir()):
                        if pkg_dir.is_dir():
                            json_path = pkg_dir / "objects.json"
                            if json_path.exists():
                                data = json.loads(json_path.read_text())
                                source = f"packages/{pkg_dir.name}"
                                for name, obj in data.items():
                                    self._objects[name] = obj
                                    self._sources[name].add(source)
                                    self._package_objects[pkg_dir.name].append(name)
                                    if not obj.get("inlets") and not obj.get("outlets"):
                                        self._empty_io_by_source[source].append(name)
            else:
                json_path = db_root / domain_dir / "objects.json"
                if json_path.exists():
                    data = json.loads(json_path.read_text())
                    for name, obj in data.items():
                        self._objects[name] = obj
                        self._sources[name].add(domain_dir)
                        if not obj.get("inlets") and not obj.get("outlets"):
                            self._empty_io_by_source[domain_dir].append(name)

        # Apply object overrides (per-port merge of inlets/outlets, whole
        # replacement of every other field) using the already-parsed
        # overrides_data — no second disk read.
        self._overridden_objects: set[str] = set()
        self._apply_object_overrides(overrides_data)

        # Inherited group profiles (review C8 / Q14). Optional file, written
        # only by tools/sync_max_bundle.py --apply groups.
        groups_path = db_root / "groups.json"
        if groups_path.exists():
            self._load_groups(json.loads(groups_path.read_text(encoding="utf-8")))

        # Shipped idioms (Q38). Optional file, written only by
        # tools/sync_max_bundle.py --apply idioms.
        idioms_path = db_root / IDIOMS_FILE
        if idioms_path.exists():
            self._load_idioms(json.loads(idioms_path.read_text(encoding="utf-8")))

        # Per-version I/O (Q38). Optional file, written only by
        # tools/sync_max_bundle.py --apply version-io.
        version_io_path = db_root / VERSION_IO_FILE
        if version_io_path.exists():
            self._load_version_io(json.loads(version_io_path.read_text(encoding="utf-8")))

        # Fail-fast on the v5.0 schema-extension fields (signal_role,
        # domain_restricted, verified_installed). Runs AFTER the merge so
        # the validator sees the final merged shape, BEFORE package_info
        # so any load-time error surfaces during DB construction.
        self._validate_schema_extensions()

        # Project signal_role onto the legacy outlet['signal'] bool so all
        # existing back-compat readers see unchanged data. Runs after the
        # validator so role values are known valid (D-01, D-03).
        self._apply_signal_role_writethrough()

        # Derive the rnbo/gen-only implied restrictions (Q12 / C3). Runs
        # after the override merge so an explicit domain_restricted (even
        # []) is visible and pre-empts the derivation.
        self._compute_implied_restrictions()

        # Load package registry
        pkg_info_path = db_root / "package_info.json"
        if pkg_info_path.exists():
            self._package_info = json.loads(pkg_info_path.read_text())

        # Derived variable_io flag (Q10 / C1): every canonical name with an
        # I/O resolver or a variable_io_rules entry computes its counts from
        # its args, so it reports variable_io True in memory -- one answer
        # for Box construction, Patcher.modify_box, _io_is_content_defined
        # and the audit parser/analyzer. The domain JSON files are untouched.
        for name in itertools.chain(self._variable_io_rules, IO_RESOLVERS):
            if name.startswith("_"):
                continue
            obj = self._objects.get(name)
            if obj is not None:
                obj["variable_io"] = True

    def _apply_object_overrides(self, overrides_data: dict) -> None:
        """Apply overrides.json ``objects`` onto the loaded domain entries.

        * Keys are canonicalized through aliases.json (Q11 / C7): alias keys
          such as ``del`` / ``v`` used to be silently ignored because only
          literal object names matched.
        * Two keys that map to the same canonical name raise ValueError.
        * A key whose canonical name has no domain entry raises ValueError
          (it would otherwise be a silently inactive override).
        * ``inlets`` / ``outlets`` lists merge per port via
          :func:`merge_override_ports` (Q11 / C6); every other non-``_``
          field replaces the base value whole. ``_``-prefixed keys are
          comments and never applied.
        """
        seen: dict[str, str] = {}
        for key, overrides in overrides_data.get("objects", {}).items():
            if key.startswith("_"):
                continue  # skip comment keys
            canonical = self._aliases.get(key, key)
            if canonical in seen:
                raise ValueError(
                    f"overrides.json objects keys {seen[canonical]!r} and "
                    f"{key!r} both resolve to {canonical!r} through "
                    "aliases.json; merge them into one entry keyed by the "
                    "canonical name."
                )
            seen[canonical] = key
            obj = self._objects.get(canonical)
            if obj is None:
                via = f" (alias of {canonical!r})" if canonical != key else ""
                raise ValueError(
                    f"overrides.json objects key {key!r}{via} has no base "
                    "domain entry; add the object to a domain objects.json "
                    "file or delete the override."
                )
            for field, value in overrides.items():
                if field.startswith("_"):
                    continue  # skip comments
                if field in ("inlets", "outlets") and isinstance(value, list):
                    base_ports = obj.get(field)
                    if not isinstance(base_ports, list):
                        base_ports = []
                    obj[field] = merge_override_ports(base_ports, value)
                else:
                    obj[field] = value
            self._overridden_objects.add(canonical)

    def _load_idioms(self, data) -> None:
        """Index idioms.json ``pairs`` into :attr:`_idioms` (Q38).

        Each ``pairs[src]`` item is ``"<outlet> <class> <dst> <inlet>"``
        (single spaces, int ports, class ``signal`` / ``control``); both
        names canonicalise through aliases.json. Anything else raises
        ValueError naming the file (fail fast, the variable_io_rules policy).
        """
        pairs = data.get("pairs") if isinstance(data, dict) else None
        if not isinstance(pairs, dict):
            raise ValueError(f"{IDIOMS_FILE} must be an object with a `pairs` object")
        for src, items in pairs.items():
            if not isinstance(items, list):
                raise ValueError(f"{IDIOMS_FILE} pairs[{src!r}] must be a list")
            csrc = self._aliases.get(src, src)
            for item in items:
                parts = item.split(" ") if isinstance(item, str) else []
                if (
                    len(parts) != 4
                    or not _is_port_token(parts[0]) or not _is_port_token(parts[3])
                    or parts[1] not in ("signal", "control") or not parts[2]
                ):
                    raise ValueError(
                        f"{IDIOMS_FILE} pairs[{src!r}] item {item!r} is not "
                        f"'<outlet> <signal|control> <dst> <inlet>'"
                    )
                dst = parts[2]
                self._idioms.add(
                    (csrc, int(parts[0]), parts[1], self._aliases.get(dst, dst), int(parts[3]))
                )

    def _load_version_io(self, data) -> None:
        """Index version_io.json ``objects`` into :attr:`_version_io` (Q38).

        Keys canonicalise through aliases.json. Each change needs str
        ``after`` / ``by`` that :func:`parse_version` accepts with
        ``after < by``, and int ``inlets`` / ``outlets`` deltas. Anything
        else raises ValueError naming the file.
        """
        objects = data.get("objects") if isinstance(data, dict) else None
        if not isinstance(objects, dict):
            raise ValueError(f"{VERSION_IO_FILE} must be an object with an `objects` object")
        max_version = data.get("max_version")
        self._version_io_max_version = max_version if isinstance(max_version, str) else None
        for name, entry in objects.items():
            changes = entry.get("changes") if isinstance(entry, dict) else None
            if not isinstance(changes, list):
                raise ValueError(f"{VERSION_IO_FILE} objects[{name!r}] needs a `changes` list")
            checked: list[dict] = []
            for change in changes:
                ok = isinstance(change, dict)
                try:
                    ok = ok and parse_version(change.get("after")) < parse_version(change.get("by"))
                except ValueError:
                    ok = False
                for key in ("inlets", "outlets"):
                    value = change.get(key) if isinstance(change, dict) else None
                    if not isinstance(value, int) or isinstance(value, bool):
                        ok = False
                if not ok:
                    raise ValueError(
                        f"{VERSION_IO_FILE} objects[{name!r}] change {change!r} needs str "
                        "after < by (Max versions) and int inlets / outlets deltas"
                    )
                checked.append(copy.deepcopy(change))
            canonical = self._aliases.get(name, name)
            merged = self._version_io.setdefault(canonical, [])
            merged.extend(checked)
            merged.sort(key=lambda c: parse_version(c["by"]))

    def _load_groups(self, data: dict) -> None:
        """Index groups.json members / profiles; never touches ``_objects``.

        Member keys canonicalise through aliases.json (two keys that meet
        merge their profile lists). A member with no domain entry, or one
        that references a missing profile, raises ValueError (fail fast, the
        overrides.json policy).
        """
        if not isinstance(data, dict):
            raise ValueError("groups.json must be a JSON object")
        profiles = data.get("profiles") or {}
        members = data.get("members") or {}
        definitions = data.get("attribute_definitions") or {}
        if not isinstance(profiles, dict) or not isinstance(members, dict) or not isinstance(
            definitions, dict
        ):
            raise ValueError(
                "groups.json profiles / members / attribute_definitions must be objects"
            )
        for key, ids in members.items():
            canonical = self._aliases.get(key, key)
            if canonical not in self._objects:
                via = f" (alias of {canonical!r})" if canonical != key else ""
                raise ValueError(
                    f"groups.json member {key!r}{via} has no domain entry; "
                    "re-run tools/sync_max_bundle.py --apply groups."
                )
            if not isinstance(ids, list):
                raise ValueError(f"groups.json member {key!r} must list profile ids")
            for pid in ids:
                if pid not in profiles:
                    raise ValueError(
                        f"groups.json member {key!r} references missing profile {pid!r}"
                    )
            merged = self._group_members.setdefault(canonical, [])
            for pid in ids:
                if pid not in merged:
                    merged.append(pid)
        self._group_profiles = profiles
        self._group_attribute_definitions = definitions

    def _group_names(self, canonical: str, field: str) -> list[str]:
        """A member's inherited `messages` or `attributes`, profile order, deduped."""
        out: list[str] = []
        for pid in self._group_members.get(canonical, []):
            for item in self._group_profiles[pid].get(field) or []:
                if item not in out:
                    out.append(item)
        return out

    def messages(self, name: str) -> list[str] | None:
        """Every message an object accepts: own list, then inherited group names.

        ``lookup()`` returns only the object's own ``messages`` (the
        overrides.json list where one exists); this adds the names its
        groups.json profiles give it (MC wrapper methods, shared Jitter
        methods, thispatcher help selectors), deduplicated in order. Returns
        a fresh list, or None for an unknown name.
        """
        canonical = self._aliases.get(name, name)
        obj = self._objects.get(canonical)
        if obj is None:
            return None
        own = obj.get("messages")
        out = list(own) if isinstance(own, list) else []
        for item in self._group_names(canonical, "messages"):
            if item not in out:
                out.append(item)
        return out

    def attributes(self, name: str) -> dict | None:
        """Typed attributes: own definitions, plus inherited group-page ones.

        ``lookup()`` returns only the object's own ``attributes``; this adds
        each groups.json inherited attribute that has a group-page definition
        (OB3D ``position`` -> float, MC ``chans`` -> int, ...). Own definitions
        always win. Inherited names no group page types (``dim``, ``fun``,
        ...) are left out -- see :meth:`selectors`. Returns a deep copy, or
        None for an unknown name.
        """
        canonical = self._aliases.get(name, name)
        obj = self._objects.get(canonical)
        if obj is None:
            return None
        own = obj.get("attributes")
        out = copy.deepcopy(own) if isinstance(own, dict) else {}
        for attr in self._group_names(canonical, "attributes"):
            definition = self._group_attribute_definitions.get(attr)
            if isinstance(definition, dict) and "definition" in definition:
                out.setdefault(attr, copy.deepcopy(definition["definition"]))
        return out

    def selectors(self, name: str) -> set[str] | None:
        """Every selector an object accepts: messages, own and inherited attributes.

        The union of :meth:`messages`, the object's own attribute names, and
        EVERY inherited attribute name (typed or not), since MAX accepts an
        attribute name as a message. Use this for "is this message legal"
        checks. Returns a fresh set, or None for an unknown name.

        Message entries that are dicts (bach.roll, dada.bounce, Odot: the
        extracted ``{"name": ..., "args": ...}`` form) contribute their
        ``name``; any other non-str entry is skipped (fix-plan Q23 D10 --
        this used to raise TypeError).
        """
        canonical = self._aliases.get(name, name)
        obj = self._objects.get(canonical)
        if obj is None:
            return None
        out: set[str] = set()
        for item in self.messages(canonical) or []:
            if isinstance(item, dict):
                item = item.get("name")
            if isinstance(item, str):
                out.add(item)
        own = obj.get("attributes")
        if isinstance(own, dict):
            out.update(own)
        out.update(self._group_names(canonical, "attributes"))
        return out

    def _validate_variable_io_rules(self) -> None:
        """Assert every loaded rule uses a supported formula.

        Raises ValueError naming the offending object, the role
        ('inlet_count' or 'outlet_count'), and the unknown formula. The
        supported set mirrors what _apply_io_formula actually consumes —
        anything else would silently fall back to the default count.

        Also raises when an object has both a resolver in
        ``io_resolvers.IO_RESOLVERS`` and a rule here (Q10 / S6): the
        resolver would silently win, so the rule must be deleted.
        """
        conflicts = sorted(set(self._variable_io_rules) & set(IO_RESOLVERS))
        if conflicts:
            raise ValueError(
                f"variable_io_rules entries {conflicts} conflict with I/O "
                "resolvers in src/maxpat/io_resolvers.py (the resolver wins); "
                "delete the rule from overrides.json variable_io_rules."
            )
        for name, rule in self._variable_io_rules.items():
            trailing = rule.get("trailing_outlets")
            if trailing is not None and (
                type(trailing) is not int or trailing < 1
            ):
                raise ValueError(
                    f"variable_io_rules[{name!r}].trailing_outlets must be a "
                    f"positive int, got {trailing!r}"
                )
            trailing_in = rule.get("trailing_inlets")
            if trailing_in is not None and (
                type(trailing_in) is not int or trailing_in < 0
            ):
                raise ValueError(
                    f"variable_io_rules[{name!r}].trailing_inlets must be a "
                    f"non-negative int, got {trailing_in!r}"
                )
            for role in ("inlet_count", "outlet_count"):
                formula = rule.get(role, "")
                if not isinstance(formula, str):
                    raise ValueError(
                        f"variable_io_rules[{name!r}].{role} must be a "
                        f"string, got {type(formula).__name__}: {formula!r}"
                    )
                if formula in SUPPORTED_IO_FORMULAS:
                    continue
                if formula.startswith("fixed:"):
                    # Validate the integer payload too — "fixed:" with no
                    # number or a non-integer is as broken as a typo.
                    payload = formula.split(":", 1)[1]
                    try:
                        int(payload)
                    except ValueError:
                        raise ValueError(
                            f"variable_io_rules[{name!r}].{role} has "
                            f"non-integer fixed payload: {formula!r}"
                        )
                    continue
                raise ValueError(
                    f"Unknown variable_io formula {formula!r} for object "
                    f"{name!r} ({role}). Supported: "
                    f"{sorted(SUPPORTED_IO_FORMULAS)} or 'fixed:N'."
                )

    def _validate_schema_extensions(self) -> None:
        """Fail-fast validator for the v5.0 schema-extension fields.

        Walks self._objects after the per-port overrides merge has completed and
        enforces three schema invariants (SCHEMA-01..03, D-04, D-06, D-15):

          1. Every outlet's `signal_role` (when present) is a member of
             _SIGNAL_ROLE_ENUM.
          2. Every object's `domain_restricted` (when present) is a list of
             strings, each a member of _DOMAIN_ENUM.
          3. Every object's `verified_installed` (when present) is exactly
             a bool — `type(value) is bool`, NOT isinstance() (which would
             silently accept Python ints since bool is an int subclass).

        Raises ValueError naming the offending object, the field, and the
        unknown / wrong-typed value. Mirrors _validate_variable_io_rules
        (the quick-260421-b3a fail-fast precedent).
        """
        for name, obj in self._objects.items():
            # 1. signal_role per-outlet enum check
            for i, outlet in enumerate(obj.get("outlets", [])):
                if not isinstance(outlet, dict):
                    raise ValueError(
                        f"outlets[{i}] on object {name!r} must be a dict, "
                        f"got {type(outlet).__name__}: {outlet!r}"
                    )
                if "signal_role" not in outlet:
                    continue
                role = outlet["signal_role"]
                if role not in _SIGNAL_ROLE_ENUM:
                    raise ValueError(
                        f"Unknown signal_role {role!r} on outlet index {i} "
                        f"of object {name!r}. Supported: "
                        f"{sorted(_SIGNAL_ROLE_ENUM)}."
                    )

            # 2. domain_restricted per-object list-of-enum check
            if "domain_restricted" in obj:
                value = obj["domain_restricted"]
                if not isinstance(value, list):
                    raise ValueError(
                        f"domain_restricted on object {name!r} must be a "
                        f"list, got {type(value).__name__}: {value!r}"
                    )
                for elem in value:
                    if elem not in _DOMAIN_ENUM:
                        raise ValueError(
                            f"Unknown domain {elem!r} in domain_restricted "
                            f"for object {name!r}. Supported: "
                            f"{sorted(_DOMAIN_ENUM)}."
                        )

            # 3. verified_installed strict-bool check (not isinstance — Python
            # treats True/False as int subclass; we want to reject 1/0/"yes").
            if "verified_installed" in obj:
                value = obj["verified_installed"]
                if type(value) is not bool:
                    raise ValueError(
                        f"verified_installed on object {name!r} must be "
                        f"bool, got {type(value).__name__}: {value!r}"
                    )

    def _apply_signal_role_writethrough(self) -> None:
        """Materialize outlet['signal'] from outlet['signal_role'] (D-01, D-03).

        Curators write signal_role only; the loader projects it onto the legacy
        signal: bool so existing readers (patcher.py:250, dsp_critic outlettype
        derivation, get_outlet_types) need zero code changes during the v5.0
        back-compat window. signal_role == "audio" → True; every other role
        (trigger, status, float, data, list) → False.

        Must run AFTER _validate_schema_extensions() so role values are known
        valid, and BEFORE any audit/getter reads self._objects.
        """
        for name, obj in self._objects.items():
            for outlet in obj.get("outlets", []):
                if not isinstance(outlet, dict):
                    # _validate_schema_extensions runs first and rejects
                    # non-dict outlet entries, so this branch is defensive
                    # only -- skip silently rather than crash if validation
                    # is ever bypassed.
                    continue
                role = outlet.get("signal_role")
                if role is None:
                    continue
                outlet["signal"] = (role == "audio")

    def _compute_implied_restrictions(self) -> None:
        """Derive implied domain restrictions from DB sources (Q12 / C3).

        A name whose DB entries all come from ``rnbo/`` and/or ``gen/``
        (:data:`IMPLIED_RESTRICTION_SOURCES`) exists only in RNBO / Gen:
        MAX says "No such object" for it in a Max patcher. It is restricted
        to ``sorted(sources)`` unless

        * it is an aliases.json key (lookups never reach its own entry; the
          alias target decides -- e.g. ``f`` -> ``float``), or
        * its merged object carries an explicit ``domain_restricted`` key.
          An explicit key always wins, including ``[]``: the real Max
          objects among the RNBO-domain entries (``rnbo~``, ``list.*``,
          ...) carry ``[]`` with bundle evidence in their overrides.json
          ``_domain_scope`` note.
        """
        self._implied_restrictions = {}
        for name, sources in self._sources.items():
            if name in self._aliases:
                continue
            obj = self._objects.get(name)
            if obj is None or "domain_restricted" in obj:
                continue
            if sources and sources <= IMPLIED_RESTRICTION_SOURCES:
                self._implied_restrictions[name] = sorted(sources)

    def lookup(self, name: str, *, allowed_packages: list[str] | None = None) -> dict | None:
        """Look up an object by name, resolving aliases.

        Args:
            name: Object name or alias (e.g., "cycle~", "t").
            allowed_packages: Package filter. None=return all (default),
                []=core only, ["BEAP"]=core+BEAP objects.

        Returns:
            Object dict from the database, or None if not found or filtered.
            Its ``messages`` / ``attributes`` are the object's OWN lists only:
            names inherited from a group (MC wrapper, Jitter OB3D/MOP,
            thispatcher help selectors; groups.json) are excluded. Use
            :meth:`messages`, :meth:`attributes` or :meth:`selectors` for
            message / attribute questions.

        Note:
            When an outlet has both `signal_role` and `signal` set in the
            source JSON, the loader projects `signal_role` onto `signal`
            at load time (D-01, D-03). The returned outlet's `signal`
            value reflects the projection, NOT the raw JSON value:
            `signal_role == "audio"` -> `signal == True`; every other
            role -> `signal == False`. This is the back-compat shim that
            lets legacy `outlet.get("signal")` readers work unchanged
            while curators write only the typed `signal_role` field.
            See `_apply_signal_role_writethrough` for the contract and
            `tests/test_schema_extensions.py::TestWriteThrough` for
            verification.
        """
        canonical = self._aliases.get(name, name)
        obj = self._objects.get(canonical)
        if obj is None:
            return None
        if allowed_packages is None:
            self._maybe_warn_empty_io(canonical, obj)
            self._maybe_warn_install_state(canonical, obj)  # VALID-03 / D-09
            return obj
        # Core objects (no package field) always pass through
        if "package" not in obj:
            self._maybe_warn_empty_io(canonical, obj)
            self._maybe_warn_install_state(canonical, obj)  # VALID-03 / D-09
            return obj
        # Package objects must be in the allowed list
        if obj.get("package") in allowed_packages:
            self._maybe_warn_empty_io(canonical, obj)
            self._maybe_warn_install_state(canonical, obj)  # VALID-03 / D-09
            return obj
        return None

    def lookup_strict(self, name: str, *, allowed_packages: list[str] | None = None) -> dict | None:
        """Look up an object by name, returning None for unusable empty-I/O entries.

        Stricter variant of `lookup()` for patch-builder call sites that need
        to fail fast. An entry is treated as "not found" when BOTH `inlets`
        and `outlets` are empty AND there is no `variable_io_rules` entry
        for the canonical name -- i.e., when the entry has no usable I/O
        schema and is not a dynamically-sized object.

        Variable-I/O objects (e.g., `trigger`, `pack`, `route`) are returned
        even when their static `inlets`/`outlets` arrays are empty, because
        their I/O is computed from arguments at runtime via
        `compute_io_counts()`.

        Aliases, package filtering, and the one-time empty-I/O UserWarning
        emitted by `lookup()` are preserved (this method delegates to
        `lookup()` for those concerns).

        Args:
            name: Object name or alias.
            allowed_packages: Package filter, identical to lookup().

        Returns:
            Object dict, or None if not found, filtered out, or empty-I/O
            without a variable_io_rules exemption.
        """
        obj = self.lookup(name, allowed_packages=allowed_packages)
        if obj is None:
            return None
        canonical = self._aliases.get(name, name)
        if canonical in self._variable_io_rules:
            return obj
        if obj.get("inlets") and obj.get("outlets"):
            return obj
        return None

    def _maybe_warn_empty_io(self, canonical: str, obj: dict) -> None:
        """Emit a one-time UserWarning if this canonical has BOTH inlets and
        outlets empty and no variable_io_rules exemption. Dedup via
        _empty_io_warned.

        Intent is to surface silent patch-generation failures caused by DB
        entries with no inlet/outlet schema. UserWarning (not
        DeprecationWarning) is used because this is a runtime data-quality
        signal to the caller; DeprecationWarning would be filtered out by
        default in Python's end-user runtime.

        Predicate (MF-03 / D-01, quick-260921-hll): fires only when BOTH
        sides are empty -- bit-for-bit the same rule `audit_empty_io()`
        applies at its own `continue` guard, and pinned to it by
        tests/test_db_lookup.py::
        test_warning_predicate_matches_audit_empty_io_exactly. It previously
        fired when EITHER side was empty, which meant 218 names warned while
        the audit reported 9.

        A zero-outlet sink (`dac~`, `ezdac~`, `scope~`, `send~`, `print`) or a
        zero-inlet source (`begin~`, `bp.Input`) is legitimate DB data, not a
        defect -- that is why the warning no longer fires on it. The
        one-side-empty set is not lost: `audit_half_empty_io()` enumerates it
        as `sinks`/`sources`. `lookup_strict()` and `has_complete_io()` keep
        their own stricter "both sides populated" rule (D-03).
        """
        if canonical in self._variable_io_rules:
            return
        if obj.get("inlets") or obj.get("outlets"):
            return
        if canonical in self._empty_io_warned:
            return
        self._empty_io_warned.add(canonical)
        warnings.warn(
            f"Object '{canonical}' has empty inlets/outlets in DB -- "
            "patch generation may fail silently. Consider adding an "
            "override to overrides.json.",
            UserWarning,
            stacklevel=3,
        )

    def _maybe_warn_install_state(self, canonical: str, obj: dict) -> None:
        """Emit a one-time UserWarning when this canonical is explicitly
        verified_installed: false. Dedup via _install_warned. Per D-10,
        absent (None) is silent — only explicit False fires.

        UserWarning category matches _maybe_warn_empty_io so callers can
        silence both with a single
        warnings.filterwarnings("ignore", category=UserWarning,
        module="db_lookup"). stacklevel=4 matches the empty-io sibling
        (call path: user -> lookup -> _maybe_warn_install_state ->
        warnings.warn).
        """
        if obj.get("verified_installed") is not False:
            return
        if canonical in self._install_warned:
            return
        self._install_warned.add(canonical)
        warnings.warn(
            f"{canonical} marked verified_installed: false — not present "
            f"in this install. Run package extraction or remove from "
            f"overrides.json if intentional.",
            UserWarning,
            stacklevel=4,
        )

    def _warn_non_integer_first_arg(
        self, formula: str, raw_arg: str, default: int
    ) -> None:
        """Emit a one-time UserWarning when a 'first_arg' formula receives a
        non-integer first argument. Dedup keyed on (formula, raw_arg) to avoid
        spamming repeated lookups of the same malformed patch.

        stacklevel=4 (one deeper than _maybe_warn_empty_io) because the call
        path is user → compute_io_counts → _apply_io_formula → here.
        """
        key = (formula, raw_arg)
        if key in self._first_arg_warned:
            return
        self._first_arg_warned.add(key)
        warnings.warn(
            f"variable_io formula '{formula}' received non-integer first arg "
            f"{raw_arg!r}; falling back to default count {default}. "
            "Patch may be malformed.",
            UserWarning,
            stacklevel=4,
        )

    def exists(self, name: str) -> bool:
        """Check whether an object exists in the database.

        Args:
            name: Object name or alias.

        Returns:
            True if the object (or its alias target) is in the database.
        """
        canonical = self._aliases.get(name, name)
        return canonical in self._objects

    def is_known_pair(self, a: str, b: str) -> bool:
        """True if *a* and *b* are listed together in relationships.json.

        Unordered (the file has no direction field) and alias-canonical
        (``s``/``r`` resolve to ``send``/``receive``). Returns False for the
        same name twice. Used by validation Layer 3 to exempt a known pair
        from type/role checks only -- index bounds are still enforced.
        """
        ca = self._aliases.get(a, a)
        cb = self._aliases.get(b, b)
        if ca == cb:
            return False
        return frozenset((ca, cb)) in self._known_pairs

    def is_shipped_idiom(
        self,
        src_name: str,
        src_outlet: int,
        src_class: str | None,
        dst_name: str,
        dst_inlet: int,
    ) -> bool:
        """True if a bundle help patch ships this cord (idioms.json, Q38).

        The key is (source name, outlet, the source outlet's signal class,
        destination name, inlet); both names are alias-canonical (a pair
        stored under ``sel`` matches a query for ``select`` and the
        reverse). *src_class* is :func:`outlet_signal_class` of the
        validated box's own ``outlettype``; None never matches. Like
        :meth:`is_known_pair` this exempts type/role checks only -- index
        bounds are always enforced. False when idioms.json is absent.
        """
        if src_class is None or not self._idioms:
            return False
        key = (
            self._aliases.get(src_name, src_name), src_outlet, src_class,
            self._aliases.get(dst_name, dst_name), dst_inlet,
        )
        return key in self._idioms

    def io_changes(self, name: str) -> list[dict]:
        """Per-version I/O changes of *name* from version_io.json (Q38).

        Alias-canonical. Each change is ``{"after", "by", "inlets",
        "outlets", ...}``: help boxes saved by Max ``after`` and earlier show
        the old I/O, boxes saved by ``by`` and later show it changed by the
        ``inlets`` / ``outlets`` deltas. Deep copies, sorted by ``by``;
        ``[]`` for an unknown name or without the file.
        """
        canonical = self._aliases.get(name, name)
        return copy.deepcopy(self._version_io.get(canonical, []))

    @property
    def version_io_max_version(self) -> str | None:
        """The installed Max version version_io.json was mined from, or None."""
        return self._version_io_max_version

    def min_version(self, name: str) -> str | None:
        """The ``min_version`` string of *name* (alias-canonical), or None.

        Q38 stores every DB min_version as a string; a stray number is
        returned as ``str(value)``. None for an unknown name or a missing
        field.
        """
        canonical = self._aliases.get(name, name)
        obj = self._objects.get(canonical)
        if obj is None:
            return None
        value = obj.get("min_version")
        if value is None or isinstance(value, bool):
            return None
        return value if isinstance(value, str) else str(value)

    def is_overridden(self, name: str) -> bool:
        """Check whether an object has expert-verified overrides applied.

        Args:
            name: Object name or alias.

        Returns:
            True if the object (or its alias target) has overrides in overrides.json.
        """
        canonical = self._aliases.get(name, name)
        return canonical in self._overridden_objects

    def has_complete_io(self, name: str) -> bool:
        """Check whether an object has usable I/O metadata.

        Returns True if:
          - the canonical name is in variable_io_rules (I/O is computed from
            args; default arrays may legitimately be empty), OR
          - both inlets and outlets arrays are populated.

        Returns False if the name is not in the DB, or if inlets OR outlets is
        empty AND the canonical has no variable_io_rules entry.

        Args:
            name: Object name or alias.
        """
        canonical = self._aliases.get(name, name)
        obj = self._objects.get(canonical)
        if obj is None:
            return False
        if canonical in self._variable_io_rules:
            # Defensive: allow variable_io entries to have empty default
            # arrays. Today all 20 rules targets have populated defaults, but
            # this short-circuit protects against future DB drift.
            return True
        return bool(obj.get("inlets")) and bool(obj.get("outlets"))

    def is_pd_object(self, name: str) -> bool:
        """Check whether a name is a Pure Data object (not in MAX).

        Args:
            name: Object name to check.

        Returns:
            True if the name is in the PD blocklist.
        """
        return name in self._pd_blocklist

    def get_pd_equivalent(self, name: str) -> str | None:
        """Get the MAX equivalent for a Pure Data object.

        Args:
            name: PD object name.

        Returns:
            MAX equivalent name, or None if not a PD object.
        """
        entry = self._pd_blocklist.get(name)
        if entry:
            return entry.get("max_equivalent")
        return None

    def list_packages(self) -> list[str]:
        """Return sorted list of package names that have at least one object loaded."""
        return sorted(self._package_objects.keys())

    def get_package_objects(self, package: str) -> list[dict]:
        """Return all objects belonging to a specific package.

        Args:
            package: Package name (e.g., "ableton-dsp").

        Returns:
            List of object dicts, or empty list if package unknown/empty.
        """
        return [self._objects[name] for name in self._package_objects.get(package, [])
                if name in self._objects]

    def is_core(self, name: str) -> bool:
        """Check whether an object is a core (non-package) object.

        Args:
            name: Object name or alias.

        Returns:
            True if the object exists and has no 'package' field.
        """
        canonical = self._aliases.get(name, name)
        obj = self._objects.get(canonical)
        return obj is not None and "package" not in obj

    def get_package(self, name: str) -> str | None:
        """Return the package name for an object, or None if core/not found.

        Args:
            name: Object name or alias.

        Returns:
            Package name string, or None.
        """
        canonical = self._aliases.get(name, name)
        obj = self._objects.get(canonical)
        if obj is None:
            return None
        return obj.get("package")

    def get_package_info(self, package: str) -> dict | None:
        """Return registry metadata for a package from package_info.json.

        Args:
            package: Package name (e.g., "ableton-dsp").

        Returns:
            Package info dict, or None if not in registry.
        """
        return self._package_info.get(package)

    def _resolve_outlet(
        self, canonical: str, obj: dict, outlet: int, args: list[str] | None
    ) -> dict | None:
        """Map an outlet index on a box WITH ARGS to its DB outlet entry.

        Without args, or for objects whose variable_io rule has no
        `trailing_outlets`, this is a plain index into the DB outlets array
        (None when out of range). With `trailing_outlets: K` and an outlet
        count expanded by the args (`sfplay~ 2` -> 3 outlets), the last K
        outlets map to the DB's last K entries and every leading outlet
        repeats DB outlet 0: `sfplay~ 2` outlets = (audio, audio, trigger),
        not (audio, trigger, <beyond>).
        """
        db_outlets = obj.get("outlets", [])
        if outlet < 0:
            return None
        rule = self._variable_io_rules.get(canonical, {})
        trailing = rule.get("trailing_outlets")
        if args is not None and isinstance(trailing, int) and 0 < trailing < len(db_outlets):
            _, count = self.compute_io_counts(canonical, args)
            if outlet >= count:
                return None
            from_end = count - outlet
            if from_end <= trailing:
                return db_outlets[len(db_outlets) - from_end]
            return db_outlets[0]
        if outlet >= len(db_outlets):
            return None
        return db_outlets[outlet]

    def resolve_inlet(
        self,
        name: str,
        inlet: int,
        args: list[str] | None = None,
        *,
        count: int | None = None,
    ) -> dict | None:
        """The DB inlet entry for inlet *inlet* of a box (CR-01, Q10 gap).

        Without *args*, or for an object whose ``variable_io_rules`` entry
        has no ``trailing_inlets``, this is a plain index into the DB inlets
        array (None when out of range). With ``trailing_inlets: K`` and
        *args*, the inlet count is *count* (the box's saved ``numinlets``)
        or else :meth:`compute_io_counts`; the last K inlets map to the DB's
        last K entries and every leading inlet repeats DB inlet 0:
        ``record~ buf 2`` (K 2) = (signal, signal, start, end), not
        (signal, start, end, <beyond>). ``K == 0`` (``sfrecord~ N``,
        ``jit.catch~ N``) makes every inlet repeat DB inlet 0. None for an
        unknown name, a negative or non-int *inlet*, or an inlet at or past
        the count.
        """
        if type(inlet) is not int or inlet < 0:
            return None
        canonical = self._aliases.get(name, name)
        obj = self._objects.get(canonical)
        if obj is None:
            return None
        db_inlets = obj.get("inlets", [])
        if not isinstance(db_inlets, list):
            return None
        trailing = self._variable_io_rules.get(canonical, {}).get("trailing_inlets")
        if (
            args is not None and db_inlets
            and type(trailing) is int and 0 <= trailing <= len(db_inlets)
        ):
            n = (
                count if type(count) is int and count >= 0
                else self.compute_io_counts(canonical, args)[0]
            )
            if inlet >= n:
                return None
            from_end = n - inlet
            if from_end <= trailing:
                return db_inlets[len(db_inlets) - from_end]
            return db_inlets[0]
        if inlet >= len(db_inlets):
            return None
        return db_inlets[inlet]

    def is_shipped_signal_inlet(self, dst_name: str, inlet: int) -> bool:
        """True when a bundle help patch ships a SIGNAL cord into inlet
        *inlet* of *dst_name* from any source (idioms.json, Q38; CR-01).

        :meth:`is_shipped_idiom` matches one exact (source, outlet,
        destination, inlet) cord, so ``<~ -> phasor~ 1`` passed while
        ``click~ -> phasor~ 1`` was flagged. MAX accepting a signal cord at
        that inlet is a property of the destination inlet, so validation
        Layer 3 also asks this. Alias-canonical; False without idioms.json.
        """
        if self._idiom_signal_inlets is None:
            self._idiom_signal_inlets = frozenset(
                (dst, port) for (_s, _o, cls, dst, port) in self._idioms
                if cls == "signal"
            )
        return (self._aliases.get(dst_name, dst_name), inlet) in self._idiom_signal_inlets

    def get_signal_role(
        self, name: str, outlet: int, args: list[str] | None = None
    ) -> str | None:
        """Return the signal_role for a specific outlet, with honest reverse derivation.

        Per D-02 (28-CONTEXT.md): for outlets that have only the legacy signal: bool
        (no curated signal_role), this returns "audio" when signal: true and None
        when signal: false. None means "not yet curated" — Phase 29's role-aware
        validators MUST treat None as "fall back to the boolean check, do not emit
        a role-mismatch error."

        Args:
            name: Object name or alias.
            outlet: Zero-indexed outlet position.
            args: Optional box arguments. When given, objects whose outlet count
                grows with their args (variable_io_rules `trailing_outlets`)
                resolve the outlet by layout, so `sfplay~ 2` outlet 1 is audio.

        Returns:
            One of {"audio","trigger","status","float","data","list"} when curated,
            "audio" when only legacy signal: true exists, None when signal: false
            or out-of-range outlet or unknown object.
        """
        canonical = self._aliases.get(name, name)
        obj = self._objects.get(canonical)
        if obj is None:
            return None
        outlet_dict = self._resolve_outlet(canonical, obj, outlet, args)
        if outlet_dict is None:
            return None
        role = outlet_dict.get("signal_role")
        if role is not None:
            return role
        # Reverse derivation from legacy signal: bool (D-02).
        if outlet_dict.get("signal"):
            return "audio"
        return None

    def get_install_state(self, name: str) -> bool | None:
        """Return the tri-state install verification flag.

        Per D-09: absent → None ("unaudited"); explicit true → True ("audited and
        present in _pkg-source/"); explicit false → False ("audited and known
        missing from this install"). Phase 29 must distinguish these — it warns
        ONLY on explicit False, NEVER on None, so the existing 2,015 absent-field
        objects don't generate a warning storm before Phase 30's audit lands.
        """
        canonical = self._aliases.get(name, name)
        obj = self._objects.get(canonical)
        if obj is None:
            return None
        return obj.get("verified_installed")

    def is_verified_installed(self, name: str) -> bool:
        """Return True ONLY when the object is explicitly verified installed.

        Per D-10: collapses to `state is True`. Any other state (including None
        "unaudited" and explicit False "known missing") returns False. Phase 29's
        install-state warning must NOT fire on the False return alone — it
        inspects get_install_state() to distinguish None from False.
        """
        return self.get_install_state(name) is True

    def get_domain_restrictions(self, name: str) -> list[str]:
        """Return the list of domains this object is restricted to, [] if unrestricted.

        Per D-07: absent → [] (no tri-state ceremony). Per D-08: Phase 29 iterates
        this to emit errors like "object X is restricted to {rnbo}; not allowed at
        MSP top level".

        Returns a fresh list copy so callers can't mutate the underlying schema.
        """
        canonical = self._aliases.get(name, name)
        obj = self._objects.get(canonical)
        if obj is None:
            return []
        return list(obj.get("domain_restricted", []))

    def is_domain_restricted(self, name: str) -> bool:
        """bool sugar for `bool(get_domain_restrictions(name))` (D-08)."""
        return bool(self.get_domain_restrictions(name))

    def get_sources(self, name: str) -> list[str]:
        """Sorted source labels ("rnbo", "msp", "packages/Bach", ...) of every
        DB file that has an entry for *name* (alias-resolved; Q12 / C3).
        Unknown names give []."""
        canonical = self._aliases.get(name, name)
        return sorted(self._sources.get(canonical, ()))

    def get_implied_restrictions(self, name: str) -> list[str]:
        """Domains an rnbo/gen-only name is implicitly restricted to (Q12 / C3).

        Non-empty only when every DB entry for the alias-canonical name comes
        from ``rnbo/`` and/or ``gen/`` and no explicit ``domain_restricted``
        key is set (an explicit key, even ``[]``, wins). Returns a fresh list;
        [] for unrestricted or unknown names. ``get_domain_restrictions``
        stays explicit-only (D-05).
        """
        canonical = self._aliases.get(name, name)
        return list(self._implied_restrictions.get(canonical, ()))

    def get_effective_restrictions(self, name: str) -> list[str]:
        """Where *name* may be used: the explicit ``domain_restricted`` list
        when the key is set (even ``[]``), else the implied list (Q12 / C3).
        [] means anywhere; unknown names give []. Returns a fresh list."""
        canonical = self._aliases.get(name, name)
        obj = self._objects.get(canonical)
        if obj is None:
            return []
        if "domain_restricted" in obj:
            return list(obj["domain_restricted"])
        return list(self._implied_restrictions.get(canonical, ()))

    def is_gen_operator(self, name: str) -> bool:
        """True when the raw *name* has an entry in ``gen/objects.json``.

        Not alias-resolved: aliases.json is the Max box namespace (``t``,
        ``sel``, ``f`` mean nothing in GenExpr). Used by validate_genexpr to
        check codebox calls against the gen domain only (Q12 / G3).
        """
        return "gen" in self._sources.get(name, ())

    def suggest_max_equivalent(self, name: str) -> str | None:
        """A MAX equivalent for a name that cannot be used here, or None.

        Tried in order (Q12 / C3): the pd-blocklist ``max_equivalent`` for
        the raw name, then for the alias-canonical name; then the first
        relationships.json ``equivalent`` partner that exists and has no
        effective restriction.
        """
        canonical = self._aliases.get(name, name)
        for key in (name, canonical):
            entry = self._pd_blocklist.get(key)
            if entry and entry.get("max_equivalent"):
                return entry["max_equivalent"]
        for partner in self._equivalents.get(canonical, ()):
            if self.exists(partner) and not self.get_effective_restrictions(partner):
                return partner
        return None

    def compute_io_counts(self, name: str, args: list[str] | None = None) -> tuple[int, int]:
        """Compute actual inlet/outlet counts, handling variable I/O objects.

        ``args`` are first normalized the way MAX reads box text
        (``io_resolvers.normalize_args``): joined, re-tokenized with double
        quotes and backslash escapes respected, and truncated at the first
        ``@attribute`` token. Pre-split and quote-joined args therefore give
        the same answer (``t "a b"`` has one argument).

        Then, in order:

        1. Unknown object -> ``(0, 0)``.
        2. A per-object resolver in ``io_resolvers.IO_RESOLVERS`` (Q10 / S6:
           receive, select/route/routepass, expr/vexpr/if, sprintf, pipe,
           notein, ctlin) gets ``(args, (db_inlets, db_outlets))``.
        3. Otherwise variable_io objects apply their overrides.json
           ``variable_io_rules`` formula; everything else returns the DB
           array lengths.

        Args:
            name: Object name or alias.
            args: Arguments to the object (e.g., ["b", "i", "f"] for trigger).

        Returns:
            (inlets, outlets) tuple.
        """
        args = normalize_args(args)

        canonical = self._aliases.get(name, name)
        obj = self._objects.get(canonical)

        if not obj:
            return (0, 0)

        defaults = (len(obj.get("inlets", [])), len(obj.get("outlets", [])))

        resolver = IO_RESOLVERS.get(canonical)
        if resolver is not None:
            return resolver(args, defaults)

        # If not a variable_io object, return default counts from database
        if not obj.get("variable_io"):
            return defaults

        # Apply variable I/O rules
        rule = self._variable_io_rules.get(canonical, {})
        if not rule:
            # No rule found -- fall back to defaults
            return (len(obj.get("inlets", [])), len(obj.get("outlets", [])))

        inlets = self._apply_io_formula(
            rule.get("inlet_count", ""),
            args,
            rule.get("default_inlets", len(obj.get("inlets", []))),
        )
        outlets = self._apply_io_formula(
            rule.get("outlet_count", ""),
            args,
            rule.get("default_outlets", len(obj.get("outlets", []))),
        )
        return (inlets, outlets)

    def _apply_io_formula(self, formula: str, args: list[str], default: int) -> int:
        """Apply a variable I/O formula to compute an inlet or outlet count.

        Supported formulas (from overrides.json):
        - "arg_count": number of args
        - "arg_count+1": number of args + 1
        - "arg_count_or_default": number of args, or default when no args
          (adc~/dac~: one port per channel arg, 2 with none)
        - "fixed:N": always N
        - "first_arg": first numeric argument
        - "first_arg+1": first numeric argument + 1
        - "second_arg": second numeric argument
        - "second_arg+1": second numeric argument + 1 (matrix~ N M: M audio
          outlets + the dump outlet; play~ buf N: N audio + the done-bang)
        - "second_arg+2": second numeric argument + 2 (mc.matrix~ N M: M
          audio outlets + 2 control outlets, per MAX-saved help boxes)
        - "sfplay_outlets": sfplay~ ``[sflist-name] [chans] [bufsize]
          [posflag] [refname]``: chans signal outlets + posflag (0-2)
          position outlets + the done-bang. A leading symbol is the sflist~
          name and is skipped; no numeric args -> ``default`` (refpage
          objarglist; ``sfplay~ sf.cues 2 0 1`` = L, R, position, bang).
        The second_arg family falls back to ``default`` with fewer than 2
        args, and warns once and falls back on a non-integer second arg.

        Args:
            formula: The formula string from variable_io_rules.
            args: Object arguments.
            default: Default count if args are empty or formula doesn't apply.

        Returns:
            Computed count.
        """
        if not formula:
            return default

        if formula.startswith("fixed:"):
            return int(formula.split(":")[1])

        if formula == "arg_count":
            return len(args)

        if formula == "arg_count+1":
            return len(args) + 1

        if formula == "arg_count_or_default":
            return len(args) if args else default

        if formula == "first_arg":
            if not args:
                return default
            try:
                return int(args[0])
            except ValueError:
                self._warn_non_integer_first_arg(formula, args[0], default)
                return default

        if formula == "first_arg+1":
            if not args:
                return default
            try:
                return int(args[0]) + 1
            except ValueError:
                self._warn_non_integer_first_arg(formula, args[0], default)
                return default

        if formula == "sfplay_outlets":
            nums: list[int] = []
            for i, tok in enumerate(args):
                try:
                    nums.append(int(float(tok)))
                except ValueError:
                    if i == 0 and not nums:
                        continue  # leading sflist~ name
                    break  # trailing object-reference name
            if not nums:
                return default
            chans = max(nums[0], 1)
            posflag = nums[2] if len(nums) >= 3 and nums[2] in (1, 2) else 0
            return chans + posflag + 1

        if formula in ("second_arg", "second_arg+1", "second_arg+2"):
            if len(args) < 2:
                return default
            offset = {"second_arg": 0, "second_arg+1": 1, "second_arg+2": 2}[formula]
            try:
                return int(args[1]) + offset
            except ValueError:
                self._warn_non_integer_first_arg(formula, args[1], default)
                return default

        return default

    def get_outlet_types(self, name: str, args: list[str] | None = None) -> list[str]:
        """Get the outlettype array for a box.

        Returns a list of outlet type strings: "signal" for signal outlets,
        "" (empty string) for control outlets, "multichannelsignal" for MC
        outlets (a DB type containing ``multichannel`` or ``mc_signal``;
        see :func:`saved_outlet_type`), so a Patcher-built MC box records
        what MAX saves (CR-01).

        The length matches the computed outlet count (handling variable I/O).

        Args:
            name: Object name or alias.
            args: Arguments to the object.

        Returns:
            List of outlet type strings.
        """
        if args is None:
            args = []

        canonical = self._aliases.get(name, name)
        obj = self._objects.get(canonical)

        if not obj:
            return []

        _, num_outlets = self.compute_io_counts(name, args)
        db_outlets = obj.get("outlets", [])

        # Objects with a `trailing_outlets` layout (sfplay~ N) resolve each
        # outlet through _resolve_outlet; everything else keeps plain indexing.
        layout = isinstance(
            self._variable_io_rules.get(canonical, {}).get("trailing_outlets"), int
        )

        result = []
        for i in range(num_outlets):
            if layout or i < len(db_outlets):
                outlet = (
                    self._resolve_outlet(canonical, obj, i, args) or {}
                    if layout else db_outlets[i]
                )
                result.append(saved_outlet_type(outlet))
            else:
                # Beyond the database outlets (variable I/O expansion).
                # Inherit the last known outlet's type, or default to "".
                result.append(saved_outlet_type(db_outlets[-1]) if db_outlets else "")

        return result

    def audit_empty_io(self) -> dict[str, list[str]]:
        """Report on DB health regarding empty-I/O entries and variable_io rules.

        Returns a dict with three sorted lists:

          variable_io_ok: ALL canonical names present in self._variable_io_rules,
            regardless of whether their default inlets/outlets arrays are empty.
            This is a registry diagnostic -- it tells you which objects are
            exempt from the empty-I/O warning path.

          covered_by_override: canonical names with EMPTY default I/O
            (both inlets and outlets empty), NOT in variable_io_rules, AND
            present in self._overridden_objects. These had an override applied
            but it did not populate I/O -- manual review flag.

          critical: canonical names with EMPTY default I/O, NOT in
            variable_io_rules, NOT in self._overridden_objects. These are the
            silent-failure time bombs.

          by_source: additive view mapping each raw source label (bare domain
            name like "max", or "packages/<pkgdir>" like "packages/Bach") to a
            sorted list of empty-I/O object names captured directly from that
            file at load time. Unlike the three canonical-name buckets above,
            this is NOT deduplicated by canonical name -- it is the mechanism
            that surfaces package entries shadowed in self._objects by a
            populated same-named core-domain object (e.g. bach.hypercomment,
            osc-route, jit.gl.textureset). Its grand total equals the raw
            empty-I/O count across every domain file on disk.

        The first three lists are sorted. In practice they are disjoint today
        because every variable_io_rules entry has populated default I/O, but
        this function permits a canonical to appear in variable_io_ok and one
        of the empty-I/O buckets if a future rules entry has empty defaults.
        """
        critical: list[str] = []
        covered: list[str] = []
        variable_ok: list[str] = sorted(self._variable_io_rules.keys())
        for canonical, obj in self._objects.items():
            if canonical in self._variable_io_rules:
                continue  # accounted for in variable_io_ok
            if obj.get("inlets") or obj.get("outlets"):
                continue  # at least one side populated -- not empty-I/O
            if canonical in self._overridden_objects:
                covered.append(canonical)
            else:
                critical.append(canonical)
        return {
            "critical": sorted(critical),
            "covered_by_override": sorted(covered),
            "variable_io_ok": variable_ok,
            "by_source": {
                src: sorted(names)
                for src, names in self._empty_io_by_source.items()
            },
        }

    def audit_half_empty_io(self) -> dict[str, list[str]]:
        """Report the canonical names with exactly ONE side of their I/O empty.

        Returns a dict with two sorted lists:

          sinks: canonical names with a populated `inlets` array and an EMPTY
            `outlets` array, NOT in variable_io_rules. These are terminal
            objects -- `dac~`, `ezdac~`, `scope~`, `send~`, `print`, `panel`,
            `outlet`, `out~`, `mc.dac~` -- and an empty outlets array is
            correct data for them, not a defect.

          sources: canonical names with a populated `outlets` array and an
            EMPTY `inlets` array, NOT in variable_io_rules. These are origin
            objects (`begin~`, `bp.Input`, ...), likewise correct data.

        Names with BOTH sides empty belong to `audit_empty_io()` (its
        `critical` / `covered_by_override` buckets) and are skipped here;
        names with both sides populated are healthy and appear in neither.
        variable_io_rules entries are excluded exactly as `audit_empty_io()`
        excludes them, since their real I/O is computed from arguments at
        connection time by `compute_io_counts()`.

        The union of this result and `audit_empty_io()`'s both-empty buckets
        is precisely the set the empty-I/O lookup warning covered before
        MF-03 narrowed it (quick-260921-hll, NH-02): the information channel
        moved to an explicit audit surface, it was not deleted. Reading at
        time of writing (2026-09-21): 9 both-empty, 109 sinks, 100 sources.
        """
        sinks: list[str] = []
        sources: list[str] = []
        for canonical, obj in self._objects.items():
            if canonical in self._variable_io_rules:
                continue  # I/O computed from args -- see compute_io_counts
            has_inlets = bool(obj.get("inlets"))
            has_outlets = bool(obj.get("outlets"))
            if has_inlets and not has_outlets:
                sinks.append(canonical)
            elif has_outlets and not has_inlets:
                sources.append(canonical)
            # both populated -> healthy; both empty -> audit_empty_io()
        return {
            "sinks": sorted(sinks),
            "sources": sorted(sources),
        }

    def audit_install_coverage(self) -> dict[str, list[str]]:
        """Report on verified_installed coverage across the DB (SCHEMA-07, D-12).

        Returns a dict with two sorted lists:

          unaudited: canonical names where the verified_installed field is absent.
            Per D-09, absent means "unaudited" (not "known missing"). Per D-11,
            Phase 30's coverage metric is to drive this list down.

          verified_false: canonical names with explicit verified_installed: false,
            meaning the object was audited and is known missing from this install.
            Per D-10, Phase 29's install-state warning fires only on this set,
            NOT on `unaudited` (which would generate a 2,000+ warning storm).

        Lists are sorted alphabetically. The two lists are disjoint by construction.
        """
        unaudited: list[str] = []
        verified_false: list[str] = []
        for canonical, obj in self._objects.items():
            state = obj.get("verified_installed")
            if state is None:
                unaudited.append(canonical)
            elif state is False:
                verified_false.append(canonical)
            # state is True -> "verified present" -> not in either bucket
        return {
            "unaudited": sorted(unaudited),
            "verified_false": sorted(verified_false),
        }

    def audit_domain_coverage(self) -> dict[str, list[str]]:
        """Report on domain_restricted coverage (SCHEMA-07, D-12).

        Returns a dict with one sorted list:

          restricted_no_coverage: canonical names flagged
            domain_restricted: [...] whose canonical entry's `domain` does
            NOT match ANY of the listed restrictions. An orphaned
            restriction usually means the override contains a typo or the
            object was never extracted into any listed domain -- either way
            it's a coverage gap to surface.

        Multi-domain semantic (D-12 refinement): a name appears in the
        result only when NONE of the listed restrictions match
        `obj['domain']`. For an object with
        `domain_restricted: ["rnbo", "m4l"]` whose canonical entry lives in
        the RNBO domain JSON, the RNBO restriction matches and the M4L
        restriction is treated as a legitimate compatibility tag (not an
        orphan). Reporting on a per-restriction basis would always flag
        multi-domain entries since the canonical entry can only live in
        one domain JSON file.
        """
        no_coverage: list[str] = []
        for canonical, obj in self._objects.items():
            restrictions = obj.get("domain_restricted", [])
            if not restrictions:
                continue
            obj_domain = obj.get("domain", "")
            for restricted_to in restrictions:
                expected_field = _DOMAIN_TO_FIELD.get(restricted_to)
                if expected_field is None:
                    # Should be unreachable -- _validate_schema_extensions rejects
                    # unknown domains at load. Defensive skip anyway.
                    continue
                if obj_domain == expected_field:
                    # At least one listed restriction matches the canonical
                    # entry's domain -> coverage is intact, stop scanning.
                    break
            else:
                # for/else: ran to completion without break -> no listed
                # restriction matched obj_domain -> orphaned coverage.
                no_coverage.append(canonical)
        return {
            "restricted_no_coverage": sorted(no_coverage),
        }

    def audit_domain_scope(self) -> dict[str, list[str]]:
        """Report the domain-scope picture (Q12 / C3), sorted lists:

          implied: names restricted by derivation (rnbo/gen-only sources,
            no explicit key, not an alias key).
          explicit: names with a non-empty explicit ``domain_restricted``.
          exempt: names with an explicit ``domain_restricted: []`` whose
            sources are all rnbo/gen -- RNBO/Gen-domain entries that the
            Max bundle shows are real Max objects.
        """
        explicit: list[str] = []
        exempt: list[str] = []
        for name, obj in self._objects.items():
            if "domain_restricted" not in obj:
                continue
            if obj["domain_restricted"]:
                explicit.append(name)
            else:
                sources = self._sources.get(name, set())
                if sources and sources <= IMPLIED_RESTRICTION_SOURCES:
                    exempt.append(name)
        return {
            "implied": sorted(self._implied_restrictions),
            "explicit": sorted(explicit),
            "exempt": sorted(exempt),
        }

    def audit_signal_role_coverage(self) -> dict[str, dict]:
        """Report on signal_role coverage across MSP and MC tilde domains
        (MSPCOV-05, Phase 30 D-13).

        Returns a per-domain nested dict:

          {
            "msp": {
              "covered":   [sorted list of object names whose every outlet
                            has signal_role],
              "uncovered": [sorted list of object names with at least one
                            outlet missing signal_role],
              "by_role":   {"audio": N, "trigger": N, "status": N,
                            "float": N, "data": N, "list": N},
              "gap_count": int,  # equals len(uncovered)
            },
            "mc": { ...same shape... },
          }

        Excludes objects with empty outlets (those are in audit_empty_io's
        buckets) -- the disjoint-bucket guarantee with audit_empty_io is
        preserved by D-13.

        Pure read-only -- no mutation, no classifier coupling. Audits the
        source-of-truth `signal_role` field, NOT the projected `signal:bool`
        (which would over-count `audio` and miss control roles).

        Domains other than MSP and MC (Max, Jitter, RNBO, Gen, M4L, package)
        are silently skipped per Phase 30 D-09 (this phase is MSP+MC only).
        """
        msp_covered: list[str] = []
        msp_uncovered: list[str] = []
        mc_covered: list[str] = []
        mc_uncovered: list[str] = []
        # Initialize from the closed enum so dict ordering is deterministic
        # and only the six canonical roles are tallied.
        msp_by_role: dict[str, int] = {role: 0 for role in sorted(_SIGNAL_ROLE_ENUM)}
        mc_by_role: dict[str, int] = {role: 0 for role in sorted(_SIGNAL_ROLE_ENUM)}

        for canonical, obj in self._objects.items():
            domain = obj.get("domain", "")
            if domain == "MSP":
                covered_bucket = msp_covered
                uncovered_bucket = msp_uncovered
                by_role = msp_by_role
            elif domain == "MC":
                covered_bucket = mc_covered
                uncovered_bucket = mc_uncovered
                by_role = mc_by_role
            else:
                # Non-MSP/MC domains are out of scope for Phase 30 (D-09).
                continue

            outlets = obj.get("outlets", [])
            if not outlets:
                # Empty-outlets objects belong to audit_empty_io's buckets
                # (D-13 disjoint-bucket guarantee with audit_empty_io).
                continue

            # Tally by_role across every outlet (covered or uncovered).
            # by_role counts OUTLETS, not objects (D-13 wording).
            all_audited = True
            for outlet in outlets:
                role = outlet.get("signal_role")
                if role is None:
                    all_audited = False
                elif role in by_role:
                    by_role[role] += 1
                # Unknown roles cannot reach here -- the loader's
                # _validate_schema_extensions fails fast on any signal_role
                # outside _SIGNAL_ROLE_ENUM.

            if all_audited:
                covered_bucket.append(canonical)
            else:
                uncovered_bucket.append(canonical)

        return {
            "msp": {
                "covered": sorted(msp_covered),
                "uncovered": sorted(msp_uncovered),
                "by_role": msp_by_role,
                "gap_count": len(msp_uncovered),
            },
            "mc": {
                "covered": sorted(mc_covered),
                "uncovered": sorted(mc_uncovered),
                "by_role": mc_by_role,
                "gap_count": len(mc_uncovered),
            },
        }
