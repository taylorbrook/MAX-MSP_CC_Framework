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

    def lookup(self, name: str, *, allowed_packages: list[str] | None = None) -> dict | None:
        """Look up an object by name, resolving aliases.

        Args:
            name: Object name or alias (e.g., "cycle~", "t").
            allowed_packages: Package filter. None=return all (default),
                []=core only, ["BEAP"]=core+BEAP objects.

        Returns:
            Object dict from the database, or None if not found or filtered.
        """
        canonical = self._aliases.get(name, name)
        obj = self._objects.get(canonical)
        if obj is None:
            return None
        if allowed_packages is None:
            self._maybe_warn_empty_io(canonical, obj)
            return obj
        # Core objects (no package field) always pass through
        if "package" not in obj:
            self._maybe_warn_empty_io(canonical, obj)
            return obj
        # Package objects must be in the allowed list
        if obj.get("package") in allowed_packages:
            self._maybe_warn_empty_io(canonical, obj)
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
