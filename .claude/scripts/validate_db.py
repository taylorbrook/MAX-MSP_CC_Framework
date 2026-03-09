#!/usr/bin/env python3
"""MAX Object Database Validation Script.

Validates the entire object database against all ODB requirements.

Usage:
    python3 .claude/scripts/validate_db.py --quick   # Fast checks (~5s)
    python3 .claude/scripts/validate_db.py --full    # Complete validation (~15s)
    python3 .claude/scripts/validate_db.py --report  # Full + write JSON report
"""

import argparse
import json
import subprocess
import sys
from datetime import datetime, timezone
from pathlib import Path

# Resolve project root (two levels up from this script)
SCRIPT_DIR = Path(__file__).resolve().parent
PROJECT_ROOT = SCRIPT_DIR.parent.parent
DB_ROOT = PROJECT_ROOT / ".claude" / "max-objects"

DOMAIN_DIRS = ["max", "msp", "jitter", "mc", "gen", "m4l", "rnbo", "packages"]
CORE_DOMAIN_DIRS = ["max", "msp", "jitter", "mc", "gen", "m4l", "packages"]
VALID_DOMAINS = {"Max", "MSP", "Jitter", "MC", "Gen", "M4L", "Packages"}

REQUIRED_OBJECT_FIELDS = [
    "name", "maxclass", "module", "domain", "inlets", "outlets",
    "arguments", "messages", "min_version", "verified",
    "rnbo_compatible", "variable_io",
]
REQUIRED_INLET_FIELDS = ["id", "type", "signal", "hot"]
REQUIRED_OUTLET_FIELDS = ["id", "type", "signal"]

RAW_TYPE_MARKERS = ["INLET_TYPE", "OUTLET_TYPE"]


class ValidationResult:
    """Tracks a single validation check."""

    def __init__(self, name: str):
        self.name = name
        self.status = "pending"
        self.detail = ""
        self.errors: list[str] = []

    def passed(self, detail: str = "") -> "ValidationResult":
        self.status = "pass"
        self.detail = detail
        return self

    def failed(self, detail: str = "", errors: list[str] | None = None) -> "ValidationResult":
        self.status = "fail"
        self.detail = detail
        if errors:
            self.errors = errors
        return self


def load_domain_objects(domain: str) -> dict | None:
    """Load objects.json for a domain, return None if missing or invalid."""
    path = DB_ROOT / domain / "objects.json"
    if not path.exists():
        return None
    try:
        return json.loads(path.read_text())
    except (json.JSONDecodeError, OSError):
        return None


def load_all_core_objects() -> dict[str, list[dict]]:
    """Load all core domain objects (excludes rnbo)."""
    result = {}
    for domain in CORE_DOMAIN_DIRS:
        data = load_domain_objects(domain)
        if data is not None:
            result[domain] = list(data.values())
    return result


def load_supplementary_file(name: str) -> dict | None:
    """Load a supplementary JSON file from DB_ROOT."""
    path = DB_ROOT / name
    if not path.exists():
        return None
    try:
        return json.loads(path.read_text())
    except (json.JSONDecodeError, OSError):
        return None


# ---------------------------------------------------------------------------
# Quick checks
# ---------------------------------------------------------------------------

def check_domain_dirs() -> ValidationResult:
    """All domain directories exist."""
    r = ValidationResult("domain_dirs")
    missing = [d for d in DOMAIN_DIRS if not (DB_ROOT / d).is_dir()]
    if missing:
        return r.failed(f"{len(DOMAIN_DIRS) - len(missing)}/{len(DOMAIN_DIRS)}", missing)
    return r.passed(f"{len(DOMAIN_DIRS)}/{len(DOMAIN_DIRS)}")


def check_objects_json_valid() -> ValidationResult:
    """All domain objects.json files exist and are valid JSON."""
    r = ValidationResult("objects_json_valid")
    invalid = []
    for d in DOMAIN_DIRS:
        data = load_domain_objects(d)
        if data is None:
            invalid.append(f"{d}/objects.json")
    if invalid:
        return r.failed(f"{len(DOMAIN_DIRS) - len(invalid)}/{len(DOMAIN_DIRS)}", invalid)
    return r.passed(f"{len(DOMAIN_DIRS)}/{len(DOMAIN_DIRS)}")


def check_extraction_log() -> ValidationResult:
    """extraction-log.json exists."""
    r = ValidationResult("extraction_log")
    if (DB_ROOT / "extraction-log.json").exists():
        return r.passed("exists")
    return r.failed("missing")


def check_overrides() -> ValidationResult:
    """overrides.json exists."""
    r = ValidationResult("overrides_json")
    if (DB_ROOT / "overrides.json").exists():
        return r.passed("exists")
    return r.failed("missing")


def check_aliases() -> ValidationResult:
    """aliases.json exists."""
    r = ValidationResult("aliases_json")
    if (DB_ROOT / "aliases.json").exists():
        return r.passed("exists")
    return r.failed("missing")


def check_relationships() -> ValidationResult:
    """relationships.json exists."""
    r = ValidationResult("relationships_json")
    if (DB_ROOT / "relationships.json").exists():
        return r.passed("exists")
    return r.failed("missing")


def check_pd_blocklist() -> ValidationResult:
    """pd-blocklist.json exists."""
    r = ValidationResult("pd_blocklist_json")
    if (DB_ROOT / "pd-blocklist.json").exists():
        return r.passed("exists")
    return r.failed("missing")


def check_claude_md() -> ValidationResult:
    """CLAUDE.md exists at project root."""
    r = ValidationResult("claude_md")
    if (PROJECT_ROOT / "CLAUDE.md").exists():
        return r.passed("exists")
    return r.failed("missing")


def check_total_object_count() -> ValidationResult:
    """Total object count > 1500."""
    r = ValidationResult("total_object_count")
    total = 0
    by_domain = {}
    for d in DOMAIN_DIRS:
        data = load_domain_objects(d)
        if data:
            count = len(data)
            by_domain[d] = count
            total += count
    if total > 1500:
        return r.passed(f"{total:,}")
    return r.failed(f"{total:,} (need > 1,500)")


def check_each_domain_nonempty() -> ValidationResult:
    """Each domain has > 0 objects."""
    r = ValidationResult("each_domain_nonempty")
    empty = []
    for d in DOMAIN_DIRS:
        data = load_domain_objects(d)
        if not data or len(data) == 0:
            empty.append(d)
    if empty:
        return r.failed(f"{len(empty)} empty domains", empty)
    return r.passed(f"{len(DOMAIN_DIRS)}/{len(DOMAIN_DIRS)} non-empty")


def check_cycle_spot() -> ValidationResult:
    """Spot-check: cycle~ exists in MSP with correct inlet count."""
    r = ValidationResult("cycle_spot_check")
    data = load_domain_objects("msp")
    if not data or "cycle~" not in data:
        return r.failed("cycle~ not found in msp/objects.json")
    obj = data["cycle~"]
    inlets = len(obj.get("inlets", []))
    outlets = len(obj.get("outlets", []))
    return r.passed(f"{inlets} inlets, {outlets} outlet(s)")


def check_trigger_spot() -> ValidationResult:
    """Spot-check: trigger exists in Max with variable_io: true."""
    r = ValidationResult("trigger_spot_check")
    data = load_domain_objects("max")
    if not data or "trigger" not in data:
        return r.failed("trigger not found in max/objects.json")
    obj = data["trigger"]
    if obj.get("variable_io") is True:
        return r.passed("variable_io: true")
    return r.failed(f"variable_io: {obj.get('variable_io')}")


# ---------------------------------------------------------------------------
# Full checks (includes quick checks plus additional)
# ---------------------------------------------------------------------------

def check_required_fields() -> ValidationResult:
    """Every object has required fields."""
    r = ValidationResult("required_fields")
    errors = []
    for domain in CORE_DOMAIN_DIRS:
        data = load_domain_objects(domain)
        if not data:
            continue
        for name, obj in data.items():
            for field in REQUIRED_OBJECT_FIELDS:
                if field not in obj:
                    errors.append(f"{domain}/{name}: missing '{field}'")
    if errors:
        return r.failed(f"{len(errors)} missing fields", errors[:10])
    return r.passed("all objects have required fields")


def check_inlet_fields() -> ValidationResult:
    """Every inlet has required fields: id, type, signal, hot."""
    r = ValidationResult("inlet_fields")
    errors = []
    for domain in CORE_DOMAIN_DIRS:
        data = load_domain_objects(domain)
        if not data:
            continue
        for name, obj in data.items():
            for inlet in obj.get("inlets", []):
                for field in REQUIRED_INLET_FIELDS:
                    if field not in inlet:
                        errors.append(f"{domain}/{name}: inlet {inlet.get('id', '?')} missing '{field}'")
    if errors:
        return r.failed(f"{len(errors)} missing inlet fields", errors[:10])
    return r.passed("all inlets have required fields")


def check_outlet_fields() -> ValidationResult:
    """Every outlet has required fields: id, type, signal."""
    r = ValidationResult("outlet_fields")
    errors = []
    for domain in CORE_DOMAIN_DIRS:
        data = load_domain_objects(domain)
        if not data:
            continue
        for name, obj in data.items():
            for outlet in obj.get("outlets", []):
                for field in REQUIRED_OUTLET_FIELDS:
                    if field not in outlet:
                        errors.append(f"{domain}/{name}: outlet {outlet.get('id', '?')} missing '{field}'")
    if errors:
        return r.failed(f"{len(errors)} missing outlet fields", errors[:10])
    return r.passed("all outlets have required fields")


def check_no_raw_types() -> ValidationResult:
    """No raw INLET_TYPE or OUTLET_TYPE values in normalized types."""
    r = ValidationResult("no_raw_types")
    errors = []
    for domain in CORE_DOMAIN_DIRS:
        data = load_domain_objects(domain)
        if not data:
            continue
        for name, obj in data.items():
            for inlet in obj.get("inlets", []):
                if inlet.get("type", "") in RAW_TYPE_MARKERS:
                    errors.append(f"{domain}/{name}: inlet {inlet.get('id')} has raw type '{inlet['type']}'")
            for outlet in obj.get("outlets", []):
                if outlet.get("type", "") in RAW_TYPE_MARKERS:
                    errors.append(f"{domain}/{name}: outlet {outlet.get('id')} has raw type '{outlet['type']}'")
    if errors:
        return r.failed(f"{len(errors)} raw types remaining", errors[:10])
    return r.passed("no raw types found")


def check_domain_values() -> ValidationResult:
    """Domain values are in allowed set."""
    r = ValidationResult("domain_values")
    errors = []
    for domain_dir in CORE_DOMAIN_DIRS:
        data = load_domain_objects(domain_dir)
        if not data:
            continue
        for name, obj in data.items():
            d = obj.get("domain", "")
            if d not in VALID_DOMAINS:
                errors.append(f"{domain_dir}/{name}: domain='{d}'")
    if errors:
        return r.failed(f"{len(errors)} invalid domain values", errors[:10])
    return r.passed("all domains valid")


def check_min_version_range() -> ValidationResult:
    """min_version is int >= 4 and <= 9."""
    r = ValidationResult("min_version_range")
    errors = []
    for domain in CORE_DOMAIN_DIRS:
        data = load_domain_objects(domain)
        if not data:
            continue
        for name, obj in data.items():
            mv = obj.get("min_version")
            if mv is None:
                errors.append(f"{domain}/{name}: min_version is None")
            elif not isinstance(mv, (int, float)):
                errors.append(f"{domain}/{name}: min_version type={type(mv).__name__}")
            else:
                v = int(mv) if isinstance(mv, float) and mv == int(mv) else mv
                # Allow float versions like 8.1 for MC objects
                if isinstance(mv, float):
                    if mv < 4 or mv > 9:
                        errors.append(f"{domain}/{name}: min_version={mv}")
                elif isinstance(mv, int):
                    if mv < 4 or mv > 9:
                        errors.append(f"{domain}/{name}: min_version={mv}")
    if errors:
        return r.failed(f"{len(errors)} out of range", errors[:10])
    return r.passed("all min_version in [4, 9]")


def check_max9_objects() -> ValidationResult:
    """MAX 9 objects (array.*, string.*, abl.*) have min_version: 9."""
    r = ValidationResult("max9_objects")
    errors = []
    max9_prefixes = ("array.", "string.", "abl.")
    for domain in CORE_DOMAIN_DIRS:
        data = load_domain_objects(domain)
        if not data:
            continue
        for name, obj in data.items():
            if any(name.startswith(p) for p in max9_prefixes):
                mv = obj.get("min_version")
                if mv != 9:
                    errors.append(f"{domain}/{name}: min_version={mv} (expected 9)")
    if errors:
        return r.failed(f"{len(errors)} wrong version", errors[:10])
    return r.passed("all MAX 9 objects tagged correctly")


def check_rnbo_compatible_count() -> ValidationResult:
    """At least 150 objects have rnbo_compatible: true."""
    r = ValidationResult("rnbo_compatible_count")
    count = 0
    for domain in CORE_DOMAIN_DIRS:
        data = load_domain_objects(domain)
        if not data:
            continue
        for obj in data.values():
            if obj.get("rnbo_compatible") is True:
                count += 1
    if count >= 150:
        return r.passed(f"{count} objects")
    return r.failed(f"{count} (need >= 150)")


def check_variable_io_count() -> ValidationResult:
    """At least 10 objects have variable_io: true."""
    r = ValidationResult("variable_io_count")
    count = 0
    for domain in CORE_DOMAIN_DIRS:
        data = load_domain_objects(domain)
        if not data:
            continue
        for obj in data.values():
            if obj.get("variable_io") is True:
                count += 1
    if count >= 10:
        return r.passed(f"{count} objects")
    return r.failed(f"{count} (need >= 10)")


def check_pd_blocklist_entries() -> ValidationResult:
    """PD blocklist has at least 15 entries."""
    r = ValidationResult("pd_blocklist_entries")
    data = load_supplementary_file("pd-blocklist.json")
    if not data:
        return r.failed("file missing or invalid")
    entries = data.get("blocklist", {})
    count = len(entries)
    if count >= 15:
        return r.passed(f"{count} entries")
    return r.failed(f"{count} (need >= 15)")


def check_aliases_entries() -> ValidationResult:
    """Aliases file has at least 5 entries."""
    r = ValidationResult("aliases_entries")
    data = load_supplementary_file("aliases.json")
    if not data:
        return r.failed("file missing or invalid")
    entries = data.get("aliases", {})
    count = len(entries)
    if count >= 5:
        return r.passed(f"{count} entries")
    return r.failed(f"{count} (need >= 5)")


def check_relationships_entries() -> ValidationResult:
    """Relationships file has at least 10 pairings."""
    r = ValidationResult("relationships_entries")
    data = load_supplementary_file("relationships.json")
    if not data:
        return r.failed("file missing or invalid")
    entries = data.get("pairs", data.get("pairings", data.get("relationships", [])))
    count = len(entries)
    if count >= 10:
        return r.passed(f"{count} pairings")
    return r.failed(f"{count} (need >= 10)")


def check_pytest_suite() -> ValidationResult:
    """Run pytest suite and report pass/fail."""
    r = ValidationResult("pytest_suite")
    try:
        result = subprocess.run(
            [sys.executable, "-m", "pytest", "tests/", "-x", "--tb=short", "-q"],
            capture_output=True,
            text=True,
            cwd=str(PROJECT_ROOT),
            timeout=60,
        )
        # Parse output for pass/fail counts
        output = result.stdout.strip()
        last_line = output.splitlines()[-1] if output.splitlines() else ""
        if result.returncode == 0:
            return r.passed(last_line)
        return r.failed(last_line, [output])
    except subprocess.TimeoutExpired:
        return r.failed("timeout (>60s)")
    except Exception as e:
        return r.failed(str(e))


# ---------------------------------------------------------------------------
# Runner
# ---------------------------------------------------------------------------

def get_quick_checks() -> list[ValidationResult]:
    """Run all quick checks."""
    return [
        check_domain_dirs(),
        check_objects_json_valid(),
        check_extraction_log(),
        check_overrides(),
        check_aliases(),
        check_relationships(),
        check_pd_blocklist(),
        check_claude_md(),
        check_total_object_count(),
        check_each_domain_nonempty(),
        check_cycle_spot(),
        check_trigger_spot(),
    ]


def get_full_checks() -> list[ValidationResult]:
    """Run all full checks (quick + additional)."""
    results = get_quick_checks()
    results.extend([
        check_required_fields(),
        check_inlet_fields(),
        check_outlet_fields(),
        check_no_raw_types(),
        check_domain_values(),
        check_min_version_range(),
        check_max9_objects(),
        check_rnbo_compatible_count(),
        check_variable_io_count(),
        check_pd_blocklist_entries(),
        check_aliases_entries(),
        check_relationships_entries(),
        check_pytest_suite(),
    ])
    return results


def get_summary_stats() -> dict:
    """Gather summary statistics for reporting."""
    total = 0
    by_domain = {}
    rnbo_count = 0
    variable_io_count = 0
    max9_count = 0
    max9_prefixes = ("array.", "string.", "abl.")

    for domain in DOMAIN_DIRS:
        data = load_domain_objects(domain)
        if not data:
            by_domain[domain] = 0
            continue
        count = len(data)
        by_domain[domain] = count
        total += count

        if domain in CORE_DOMAIN_DIRS:
            for name, obj in data.items():
                if obj.get("rnbo_compatible") is True:
                    rnbo_count += 1
                if obj.get("variable_io") is True:
                    variable_io_count += 1
                if any(name.startswith(p) for p in max9_prefixes):
                    max9_count += 1

    return {
        "total_objects": total,
        "by_domain": by_domain,
        "rnbo_compatible_count": rnbo_count,
        "variable_io_count": variable_io_count,
        "max9_object_count": max9_count,
    }


def print_results(results: list[ValidationResult], mode: str) -> int:
    """Print results and return exit code (0 = all pass, 1 = any fail)."""
    print(f"\n=== MAX Object Database Validation ===")
    print(f"Mode: {mode}\n")

    passed = 0
    failed = 0

    for r in results:
        status = "PASS" if r.status == "pass" else "FAIL"
        print(f"[{status}] {r.name}: {r.detail}")
        if r.status == "pass":
            passed += 1
        else:
            failed += 1
            for err in r.errors[:5]:
                print(f"  - {err}")
            if len(r.errors) > 5:
                print(f"  ... and {len(r.errors) - 5} more")

    print(f"\nSummary: {passed}/{passed + failed} checks passed", end="")
    if failed:
        print(f", {failed} failed")
    else:
        print()

    return 0 if failed == 0 else 1


def write_report(results: list[ValidationResult], mode: str) -> None:
    """Write validation report JSON."""
    report = {
        "timestamp": datetime.now(timezone.utc).isoformat(),
        "mode": mode,
        "total_checks": len(results),
        "passed": sum(1 for r in results if r.status == "pass"),
        "failed": sum(1 for r in results if r.status == "fail"),
        "checks": [
            {
                "name": r.name,
                "status": r.status,
                "detail": r.detail,
                **({"errors": r.errors} if r.errors else {}),
            }
            for r in results
        ],
        "summary": get_summary_stats(),
    }

    report_path = DB_ROOT / "validation-report.json"
    report_path.write_text(json.dumps(report, indent=2) + "\n")
    print(f"\nReport written to {report_path.relative_to(PROJECT_ROOT)}")


def main():
    parser = argparse.ArgumentParser(description="Validate MAX Object Database")
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument("--quick", action="store_true", help="Fast checks (~5s)")
    group.add_argument("--full", action="store_true", help="Complete validation (~15s)")
    group.add_argument("--report", action="store_true", help="Full validation + JSON report")

    args = parser.parse_args()

    if args.quick:
        mode = "quick"
        results = get_quick_checks()
    else:
        mode = "full"
        results = get_full_checks()

    exit_code = print_results(results, mode)

    if args.report:
        write_report(results, mode)

    sys.exit(exit_code)


if __name__ == "__main__":
    main()
