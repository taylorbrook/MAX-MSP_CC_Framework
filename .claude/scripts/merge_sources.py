#!/usr/bin/env python3
"""Merge and enrich the MAX object database.

Applies overrides, RNBO compatibility flags, version tags, and variable I/O
rules to all domain JSON files. Idempotent -- safe to run multiple times.

Usage:
    python3 .claude/scripts/merge_sources.py [--overrides path] [--dry-run]
"""

import argparse
import copy
import json
import sys
from pathlib import Path


DB_ROOT = Path(__file__).resolve().parent.parent / "max-objects"

# Core domains to enrich (RNBO is the reference set, not enriched itself)
CORE_DOMAINS = ["max", "msp", "jitter", "mc", "gen", "m4l", "packages"]

# Default min_version for objects without an explicit override
DEFAULT_MIN_VERSION = 8


def deep_merge(base: dict, override: dict) -> dict:
    """Deep-merge override dict onto base dict. Override values win."""
    result = copy.deepcopy(base)
    for key, value in override.items():
        if key.startswith("_"):
            # Skip comment/note fields -- don't merge into object data
            continue
        if (
            key in result
            and isinstance(result[key], dict)
            and isinstance(value, dict)
        ):
            result[key] = deep_merge(result[key], value)
        else:
            result[key] = copy.deepcopy(value)
    return result


def load_overrides(overrides_path: Path) -> dict:
    """Load the overrides.json file."""
    if not overrides_path.exists():
        print(f"WARNING: Overrides file not found: {overrides_path}")
        return {}
    return json.loads(overrides_path.read_text())


def build_rnbo_name_set(db_root: Path) -> set[str]:
    """Build set of RNBO-compatible object names from the RNBO domain."""
    rnbo_path = db_root / "rnbo" / "objects.json"
    if not rnbo_path.exists():
        print(f"WARNING: RNBO objects not found: {rnbo_path}")
        return set()
    rnbo_data = json.loads(rnbo_path.read_text())
    return set(rnbo_data.keys())


def apply_overrides(objects: dict, object_overrides: dict) -> tuple[dict, int]:
    """Apply object-level overrides via deep merge. Returns (objects, count)."""
    count = 0
    for name, override_data in object_overrides.items():
        if name in objects:
            objects[name] = deep_merge(objects[name], override_data)
            count += 1
    return objects, count


def apply_rnbo_flags(
    objects: dict, rnbo_names: set[str]
) -> tuple[dict, int]:
    """Set rnbo_compatible flag on each object. Returns (objects, count_true)."""
    count_true = 0
    for name, obj in objects.items():
        # For MC objects, check if the non-mc version is in RNBO
        check_name = name
        if name.startswith("mc."):
            check_name = name[3:]  # Strip "mc." prefix

        if check_name in rnbo_names:
            obj["rnbo_compatible"] = True
            count_true += 1
        else:
            obj["rnbo_compatible"] = False
    return objects, count_true


def apply_version_tags(
    objects: dict, version_map: dict
) -> tuple[dict, int]:
    """Apply min_version based on version_map rules. Returns (objects, count_changed)."""
    count_changed = 0

    for name, obj in objects.items():
        new_version = None

        # Check each version rule (higher versions checked first for priority)
        for version_str in sorted(version_map.keys(), reverse=True):
            rules = version_map[version_str]
            version_num = int(version_str) if version_str.isdigit() else None

            # Check exact matches
            if name in rules.get("exact", []):
                new_version = version_num if version_num else float(version_str)
                break

            # Check prefix matches
            for prefix in rules.get("prefixes", []):
                if name.startswith(prefix):
                    new_version = version_num if version_num else float(version_str)
                    break
            if new_version is not None:
                break

        if new_version is not None:
            if obj.get("min_version") != new_version:
                count_changed += 1
            obj["min_version"] = new_version
        elif "min_version" not in obj:
            obj["min_version"] = DEFAULT_MIN_VERSION

    return objects, count_changed


def apply_variable_io_rules(
    objects: dict, variable_io_rules: dict
) -> tuple[dict, int]:
    """Apply variable_io flag and io_rule from overrides. Returns (objects, count)."""
    count = 0
    for rule_name, rule_data in variable_io_rules.items():
        if rule_name in objects:
            objects[rule_name]["variable_io"] = True
            objects[rule_name]["io_rule"] = rule_data
            count += 1
    return objects, count


def enrich_domain(
    domain_path: Path,
    object_overrides: dict,
    rnbo_names: set[str],
    version_map: dict,
    variable_io_rules: dict,
    dry_run: bool = False,
) -> dict:
    """Enrich a single domain JSON file. Returns stats dict."""
    stats = {
        "domain": domain_path.parent.name,
        "total": 0,
        "overrides_applied": 0,
        "rnbo_true": 0,
        "version_changed": 0,
        "variable_io_applied": 0,
    }

    if not domain_path.exists():
        print(f"  SKIP: {domain_path} not found")
        return stats

    objects = json.loads(domain_path.read_text())
    stats["total"] = len(objects)

    # Step 1: Apply object overrides (deep merge)
    objects, override_count = apply_overrides(objects, object_overrides)
    stats["overrides_applied"] = override_count

    # Step 2: Apply RNBO compatibility flags
    objects, rnbo_count = apply_rnbo_flags(objects, rnbo_names)
    stats["rnbo_true"] = rnbo_count

    # Step 3: Apply version tags
    objects, version_count = apply_version_tags(objects, version_map)
    stats["version_changed"] = version_count

    # Step 4: Apply variable I/O rules
    objects, vio_count = apply_variable_io_rules(objects, variable_io_rules)
    stats["variable_io_applied"] = vio_count

    # Write back
    if not dry_run:
        domain_path.write_text(
            json.dumps(objects, indent=2, ensure_ascii=False) + "\n"
        )

    return stats


def main():
    parser = argparse.ArgumentParser(
        description="Enrich MAX object database with overrides, RNBO flags, and version tags."
    )
    parser.add_argument(
        "--overrides",
        type=Path,
        default=DB_ROOT / "overrides.json",
        help="Path to overrides.json (default: .claude/max-objects/overrides.json)",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Show what would change without writing files.",
    )
    args = parser.parse_args()

    print("=" * 60)
    print("MAX Object Database Enrichment")
    print("=" * 60)

    # Load overrides
    overrides = load_overrides(args.overrides)
    object_overrides = overrides.get("objects", {})
    version_map = overrides.get("version_map", {})
    variable_io_rules = overrides.get("variable_io_rules", {})

    print(f"\nOverrides: {len(object_overrides)} object overrides")
    print(f"Version map: {len(version_map)} version rules")
    print(f"Variable I/O rules: {len(variable_io_rules)} rules")

    # Build RNBO name set
    rnbo_names = build_rnbo_name_set(DB_ROOT)
    print(f"RNBO reference set: {len(rnbo_names)} objects")

    if args.dry_run:
        print("\n** DRY RUN -- no files will be modified **\n")

    # Enrich each core domain
    totals = {
        "total": 0,
        "overrides_applied": 0,
        "rnbo_true": 0,
        "version_changed": 0,
        "variable_io_applied": 0,
    }

    print(f"\nEnriching {len(CORE_DOMAINS)} domains...")
    for domain in CORE_DOMAINS:
        domain_path = DB_ROOT / domain / "objects.json"
        stats = enrich_domain(
            domain_path,
            object_overrides,
            rnbo_names,
            version_map,
            variable_io_rules,
            dry_run=args.dry_run,
        )
        print(
            f"  {stats['domain']:>10}: {stats['total']:>4} objects | "
            f"RNBO={stats['rnbo_true']:>3} | "
            f"ver={stats['version_changed']:>3} | "
            f"overrides={stats['overrides_applied']} | "
            f"vio={stats['variable_io_applied']}"
        )
        for key in totals:
            totals[key] += stats[key]

    # Summary
    print(f"\n{'=' * 60}")
    print(f"SUMMARY")
    print(f"{'=' * 60}")
    print(f"Total objects enriched: {totals['total']}")
    print(f"RNBO-compatible flags set to true: {totals['rnbo_true']}")
    print(f"Version tags changed: {totals['version_changed']}")
    print(f"Object overrides applied: {totals['overrides_applied']}")
    print(f"Variable I/O rules applied: {totals['variable_io_applied']}")

    if args.dry_run:
        print("\n** DRY RUN complete -- no files were modified **")
    else:
        print("\nDone. All domain JSON files updated in place.")

    return 0


if __name__ == "__main__":
    sys.exit(main())
