"""Integration tests: run validate_patch() and review_patch() on every real .maxpat.

Parametrized over patches/*/generated/*.maxpat to catch regressions.
"""

from __future__ import annotations

import json
from pathlib import Path

import pytest

from src.maxpat.db_lookup import ObjectDatabase
from src.maxpat.validation import validate_patch, has_blocking_errors
from src.maxpat.critics import review_patch

# ---------------------------------------------------------------------------
# Discover all real .maxpat files
# ---------------------------------------------------------------------------

_REPO_ROOT = Path(__file__).resolve().parent.parent
_PATCH_FILES = sorted(_REPO_ROOT.glob("patches/*/generated/*.maxpat"))


@pytest.fixture(scope="module")
def db() -> ObjectDatabase:
    """Module-scoped ObjectDatabase (expensive to construct)."""
    return ObjectDatabase()


# ---------------------------------------------------------------------------
# Test 1: validate_patch produces zero blocking errors
# ---------------------------------------------------------------------------

@pytest.mark.parametrize(
    "patch_path",
    _PATCH_FILES,
    ids=[str(p.relative_to(_REPO_ROOT)) for p in _PATCH_FILES],
)
def test_validate_patch_no_errors(patch_path: Path, db: ObjectDatabase) -> None:
    with open(patch_path) as f:
        patch_dict = json.load(f)

    results = validate_patch(patch_dict, db)
    blocking = [r for r in results if r.level == "error" and not r.auto_fixed]

    assert not blocking, (
        f"{len(blocking)} blocking error(s) in {patch_path.name}:\n"
        + "\n".join(f"  - {r}" for r in blocking)
    )


# ---------------------------------------------------------------------------
# Test 2: review_patch produces zero blockers
# ---------------------------------------------------------------------------

@pytest.mark.parametrize(
    "patch_path",
    _PATCH_FILES,
    ids=[str(p.relative_to(_REPO_ROOT)) for p in _PATCH_FILES],
)
def test_review_patch_no_blockers(patch_path: Path, db: ObjectDatabase) -> None:
    with open(patch_path) as f:
        patch_dict = json.load(f)

    results = review_patch(patch_dict)
    blockers = [r for r in results if r.severity == "blocker"]

    assert not blockers, (
        f"{len(blockers)} blocker(s) in {patch_path.name}:\n"
        + "\n".join(f"  - {r}" for r in blockers)
    )
