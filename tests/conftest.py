"""Shared test fixtures for MAX object knowledge base tests."""

import json
from pathlib import Path
from typing import Callable

import pytest

DB_ROOT = Path(__file__).resolve().parent.parent / ".claude" / "max-objects"

VALID_DOMAINS = {"Max", "MSP", "Jitter", "MC", "Gen", "M4L", "Packages", "RNBO"}
# Order matters for object_by_name: core domains loaded last so they take priority
# when objects with the same name exist in multiple domains (e.g., RNBO cycle~ vs MSP cycle~)
DOMAIN_DIRS = ["rnbo", "packages", "m4l", "gen", "mc", "jitter", "msp", "max"]


@pytest.fixture(scope="session")
def db_root() -> Path:
    """Return path to the .claude/max-objects/ root directory."""
    return DB_ROOT


@pytest.fixture(scope="session")
def all_objects(db_root: Path) -> list[dict]:
    """Load all domain JSON files into a flat list of object dicts."""
    objects = []
    for domain_dir in DOMAIN_DIRS:
        json_path = db_root / domain_dir / "objects.json"
        if json_path.exists():
            data = json.loads(json_path.read_text())
            for obj in data.values():
                objects.append(obj)
    return objects


@pytest.fixture(scope="session")
def objects_by_domain(db_root: Path) -> dict[str, dict]:
    """Return dict keyed by domain directory name, each value is the objects dict."""
    result = {}
    for domain_dir in DOMAIN_DIRS:
        json_path = db_root / domain_dir / "objects.json"
        if json_path.exists():
            result[domain_dir] = json.loads(json_path.read_text())
    return result


@pytest.fixture(scope="session")
def object_by_name(all_objects: list[dict]) -> Callable[[str], dict | None]:
    """Return a lookup function: name -> object dict (or None)."""
    index = {obj["name"]: obj for obj in all_objects}

    def _lookup(name: str) -> dict | None:
        return index.get(name)

    return _lookup


@pytest.fixture(scope="session")
def extraction_log(db_root: Path) -> dict:
    """Load the extraction-log.json file."""
    log_path = db_root / "extraction-log.json"
    if log_path.exists():
        return json.loads(log_path.read_text())
    return {}
