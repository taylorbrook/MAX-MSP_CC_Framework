"""Object database interface wrapping .claude/max-objects/.

Provides ObjectDatabase class for looking up MAX objects, resolving aliases,
computing variable I/O counts, and checking PD blocklist. This is the single
source of truth for object existence and metadata during patch generation.
"""

import json
from pathlib import Path

# Load core domains last so they take priority over RNBO duplicates
# (e.g., MSP cycle~ has 1 outlet, RNBO cycle~ has 2)
DOMAIN_LOAD_ORDER = [
    "rnbo", "packages", "m4l", "gen", "mc", "jitter", "msp", "max"
]


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
        self._load(db_root)

    def _load(self, db_root: Path) -> None:
        """Load all database files from disk."""
        # Load aliases
        aliases_path = db_root / "aliases.json"
        if aliases_path.exists():
            data = json.loads(aliases_path.read_text())
            self._aliases = data.get("aliases", {})

        # Load variable I/O rules from overrides
        overrides_path = db_root / "overrides.json"
        if overrides_path.exists():
            data = json.loads(overrides_path.read_text())
            self._variable_io_rules = data.get("variable_io_rules", {})

        # Load PD blocklist
        pd_path = db_root / "pd-blocklist.json"
        if pd_path.exists():
            data = json.loads(pd_path.read_text())
            self._pd_blocklist = data.get("blocklist", {})

        # Load domain objects (core domains last for priority)
        for domain_dir in DOMAIN_LOAD_ORDER:
            json_path = db_root / domain_dir / "objects.json"
            if json_path.exists():
                data = json.loads(json_path.read_text())
                for name, obj in data.items():
                    self._objects[name] = obj

    def lookup(self, name: str) -> dict | None:
        """Look up an object by name, resolving aliases.

        Args:
            name: Object name or alias (e.g., "cycle~", "t").

        Returns:
            Object dict from the database, or None if not found.
        """
        canonical = self._aliases.get(name, name)
        return self._objects.get(canonical)

    def exists(self, name: str) -> bool:
        """Check whether an object exists in the database.

        Args:
            name: Object name or alias.

        Returns:
            True if the object (or its alias target) is in the database.
        """
        canonical = self._aliases.get(name, name)
        return canonical in self._objects

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
            return len(args) if args else default

        if formula == "arg_count+1":
            return (len(args) + 1) if args else default

        if formula == "first_arg":
            if args:
                try:
                    return int(args[0])
                except (ValueError, IndexError):
                    return default
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
