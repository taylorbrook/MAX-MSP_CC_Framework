"""Object database interface wrapping .claude/max-objects/.

Provides ObjectDatabase class for looking up MAX objects, resolving aliases,
computing variable I/O counts, and checking PD blocklist. This is the single
source of truth for object existence and metadata during patch generation.
"""

import json
import warnings
from collections import defaultdict
from pathlib import Path

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
    "first_arg",
    "first_arg+1",
    "second_arg",
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

        self._objects: dict[str, dict] = {}
        self._aliases: dict[str, str] = {}
        self._variable_io_rules: dict[str, dict] = {}
        self._pd_blocklist: dict[str, dict] = {}
        self._package_objects: dict[str, list[str]] = defaultdict(list)
        self._package_info: dict[str, dict] = {}
        self._empty_io_warned: set[str] = set()
        self._install_warned: set[str] = set()
        self._first_arg_warned: set[tuple[str, str]] = set()
        self._load(db_root)

    def _load(self, db_root: Path) -> None:
        """Load all database files from disk."""
        # Load aliases
        aliases_path = db_root / "aliases.json"
        if aliases_path.exists():
            data = json.loads(aliases_path.read_text())
            self._aliases = data.get("aliases", {})

        # Parse overrides.json exactly once (quick-260421-b3a FN-02). Both
        # the variable_io_rules registry and the per-object deep-merge
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
                                for name, obj in data.items():
                                    self._objects[name] = obj
                                    self._package_objects[pkg_dir.name].append(name)
            else:
                json_path = db_root / domain_dir / "objects.json"
                if json_path.exists():
                    data = json.loads(json_path.read_text())
                    for name, obj in data.items():
                        self._objects[name] = obj

        # Apply object overrides (deep-merge onto loaded objects) using the
        # already-parsed overrides_data — no second disk read.
        self._overridden_objects: set[str] = set()
        for name, overrides in overrides_data.get("objects", {}).items():
            if name.startswith("_"):
                continue  # skip comment keys
            if name in self._objects:
                for key, value in overrides.items():
                    if key.startswith("_"):
                        continue  # skip comments
                    self._objects[name][key] = value
                self._overridden_objects.add(name)

        # Fail-fast on the v5.0 schema-extension fields (signal_role,
        # domain_restricted, verified_installed). Runs AFTER deep-merge so
        # the validator sees the final merged shape, BEFORE package_info
        # so any load-time error surfaces during DB construction.
        self._validate_schema_extensions()

        # Project signal_role onto the legacy outlet['signal'] bool so all
        # existing back-compat readers see unchanged data. Runs after the
        # validator so role values are known valid (D-01, D-03).
        self._apply_signal_role_writethrough()

        # Load package registry
        pkg_info_path = db_root / "package_info.json"
        if pkg_info_path.exists():
            self._package_info = json.loads(pkg_info_path.read_text())

    def _validate_variable_io_rules(self) -> None:
        """Assert every loaded rule uses a supported formula.

        Raises ValueError naming the offending object, the role
        ('inlet_count' or 'outlet_count'), and the unknown formula. The
        supported set mirrors what _apply_io_formula actually consumes —
        anything else would silently fall back to the default count.
        """
        for name, rule in self._variable_io_rules.items():
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

        Walks self._objects after the overrides deep-merge has completed and
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

    def lookup(self, name: str, *, allowed_packages: list[str] | None = None) -> dict | None:
        """Look up an object by name, resolving aliases.

        Args:
            name: Object name or alias (e.g., "cycle~", "t").
            allowed_packages: Package filter. None=return all (default),
                []=core only, ["BEAP"]=core+BEAP objects.

        Returns:
            Object dict from the database, or None if not found or filtered.

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
        """Emit a one-time UserWarning if this canonical has empty I/O and no
        variable_io_rules exemption. Dedup via _empty_io_warned.

        Intent is to surface silent patch-generation failures caused by DB
        entries with no inlet/outlet schema. UserWarning (not
        DeprecationWarning) is used because this is a runtime data-quality
        signal to the caller; DeprecationWarning would be filtered out by
        default in Python's end-user runtime.
        """
        if canonical in self._variable_io_rules:
            return
        if obj.get("inlets") and obj.get("outlets"):
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

    def get_signal_role(self, name: str, outlet: int) -> str | None:
        """Return the signal_role for a specific outlet, with honest reverse derivation.

        Per D-02 (28-CONTEXT.md): for outlets that have only the legacy signal: bool
        (no curated signal_role), this returns "audio" when signal: true and None
        when signal: false. None means "not yet curated" — Phase 29's role-aware
        validators MUST treat None as "fall back to the boolean check, do not emit
        a role-mismatch error."

        Args:
            name: Object name or alias.
            outlet: Zero-indexed outlet position.

        Returns:
            One of {"audio","trigger","status","float","data","list"} when curated,
            "audio" when only legacy signal: true exists, None when signal: false
            or out-of-range outlet or unknown object.
        """
        canonical = self._aliases.get(name, name)
        obj = self._objects.get(canonical)
        if obj is None:
            return None
        outlets = obj.get("outlets", [])
        if outlet < 0 or outlet >= len(outlets):
            return None
        outlet_dict = outlets[outlet]
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

    def compute_io_counts(self, name: str, args: list[str] | None = None) -> tuple[int, int]:
        """Compute actual inlet/outlet counts, handling variable I/O objects.

        For variable_io objects (trigger, pack, route, etc.), the inlet/outlet
        count depends on the arguments provided. This method applies the formula
        from overrides.json variable_io_rules.

        Args:
            name: Object name or alias.
            args: Arguments to the object (e.g., ["b", "i", "f"] for trigger).

        Returns:
            (inlets, outlets) tuple.
        """
        if args is None:
            args = []

        canonical = self._aliases.get(name, name)
        obj = self._objects.get(canonical)

        if not obj:
            return (0, 0)

        # If not a variable_io object, return default counts from database
        if not obj.get("variable_io"):
            return (len(obj.get("inlets", [])), len(obj.get("outlets", [])))

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
        - "fixed:N": always N
        - "first_arg": first numeric argument
        - "first_arg+1": first numeric argument + 1
        - "second_arg": second numeric argument

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

        if formula == "first_arg":
            if not args:
                return default
            try:
                return int(args[0])
            except ValueError:
                self._warn_non_integer_first_arg(formula, args[0], default)
                return default

        if formula == "first_arg+1":
            if args:
                try:
                    return int(args[0]) + 1
                except (ValueError, IndexError):
                    return default
            return default

        if formula == "second_arg":
            if len(args) >= 2:
                try:
                    return int(args[1])
                except (ValueError, IndexError):
                    return default
            return default

        return default

    def get_outlet_types(self, name: str, args: list[str] | None = None) -> list[str]:
        """Get the outlettype array for a box.

        Returns a list of outlet type strings: "signal" for signal outlets,
        "" (empty string) for control outlets, "multichannelsignal" for MC.

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

        result = []
        for i in range(num_outlets):
            if i < len(db_outlets):
                outlet = db_outlets[i]
                if outlet.get("signal"):
                    # Check for multichannel
                    otype = outlet.get("type", "")
                    if "multichannel" in otype.lower():
                        result.append("multichannelsignal")
                    else:
                        result.append("signal")
                else:
                    result.append("")
            else:
                # Beyond the database outlets (variable I/O expansion).
                # Inherit type from the last known outlet, or default to "".
                if db_outlets:
                    last = db_outlets[-1]
                    if last.get("signal"):
                        result.append("signal")
                    else:
                        result.append("")
                else:
                    result.append("")

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

        Lists are sorted. In practice they are disjoint today because every
        variable_io_rules entry has populated default I/O, but this function
        permits a canonical to appear in variable_io_ok and one of the
        empty-I/O buckets if a future rules entry has empty defaults.
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
