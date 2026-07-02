"""Integration tests: run validate_patch() and review_patch() on every real .maxpat.

Parametrized over patches/*/generated/*.maxpat to catch regressions.
"""

from __future__ import annotations

import json
import re
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

# ---------------------------------------------------------------------------
# Review-blocker allowlist (documented pre-existing debt in committed patches)
# ---------------------------------------------------------------------------
# The committed .maxpat files are frozen (never edited to satisfy critics --
# D-fanout regression constraint). review_blocker_allowlist.json documents the
# existing blocker debt (fan-out-without-trigger per CLAUDE.md Rule #4, plus a
# small number of Bach-llll send/receive routing-bridge false positives) so the
# integration test can exempt ONLY those specific, signature-scoped findings.
# A NEW patch (path absent from the allowlist) or a NEW blocker (signature not
# explicitly listed for its patch) is never exempted -- it still fails.
_ALLOWLIST_PATH = Path(__file__).resolve().parent / "review_blocker_allowlist.json"
with open(_ALLOWLIST_PATH) as _f:
    _ALLOWLIST = json.load(_f).get("patches", {})

# Blocker finding-string formats are fixed by the critics:
#   Fan-out:  "Fan-out without trigger: '<name>' (<source_id>) outlet <N> ..."
#   Bach-llll: "Bach llll type mismatch: '<name>' (<source_id>) connected to
#               '<dst>' (<dst_id>) inlet <N> which expects llll data ..."
_FANOUT_RE = re.compile(
    r"Fan-out without trigger: '[^']*' \(([^)]+)\) outlet (\d+) "
    r"connected to \d+ destinations \((.*?)\) --"
)
_BACH_RE = re.compile(
    r"Bach llll type mismatch: '[^']*' \(([^)]+)\) connected to "
    r"'([^']*)' \([^)]+\) inlet (\d+)"
)
_DST_NAME_RE = re.compile(r"'([^']*)' \([^)]+\)")


def _blocker_match_key(finding: str):
    """Derive a signature key from a blocker finding string, or None if the
    blocker is not an allowlist-eligible kind (fan-out / Bach-llll).

    Keys mirror the allowlist entry keys:
      fan-out   -> ("fanout", source_id, outlet)
      Bach-llll -> ("bach_llll", source_id, inlet, (sorted destinations))
    """
    m = _FANOUT_RE.search(finding)
    if m:
        source_id, outlet, _dsts = m.groups()
        return ("fanout", source_id, int(outlet))
    mb = _BACH_RE.search(finding)
    if mb:
        source_id, dst, inlet = mb.groups()
        return ("bach_llll", source_id, int(inlet), (dst,))
    return None


def _entry_key(entry: dict):
    """Derive the same signature key from an allowlist entry."""
    kind = entry.get("kind")
    if kind == "fanout":
        return ("fanout", entry["source_id"], int(entry["outlet"]))
    if kind == "bach_llll":
        dsts = tuple(sorted(entry.get("destinations", [])))
        return ("bach_llll", entry["source_id"], int(entry["inlet"]), dsts)
    return None


def _is_allowlisted(patch_rel: str, finding: str) -> bool:
    """True only if `patch_rel` has an allowlist list AND the blocker's
    signature matches one of that patch's explicit entries."""
    entries = _ALLOWLIST.get(patch_rel)
    if not entries:
        return False
    key = _blocker_match_key(finding)
    if key is None:
        return False
    return any(_entry_key(e) == key for e in entries)

# Known issues: patches that fail specific tests with documented reasons.
# Use xfail so regressions are still tracked without blocking CI.
_REVIEW_XFAILS: dict[str, str] = {
    "mixer-strip.maxpat": "known issue: message '128' feeds *~ gain inlet via line~ (unsafe gain source blocker)",
}


@pytest.fixture(scope="module")
def db() -> ObjectDatabase:
    """Module-scoped ObjectDatabase (expensive to construct)."""
    return ObjectDatabase()


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def _make_review_params() -> list:
    """Build parametrize list, applying xfail marks to known-failing patches."""
    params = []
    for p in _PATCH_FILES:
        reason = _REVIEW_XFAILS.get(p.name)
        if reason:
            params.append(pytest.param(p, marks=pytest.mark.xfail(reason=reason)))
        else:
            params.append(p)
    return params


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
    _make_review_params(),
    ids=[str(p.relative_to(_REPO_ROOT)) for p in _PATCH_FILES],
)
def test_review_patch_no_blockers(patch_path: Path, db: ObjectDatabase) -> None:
    with open(patch_path) as f:
        patch_dict = json.load(f)

    results = review_patch(patch_dict)
    blockers = [r for r in results if r.severity == "blocker"]

    # Filter out documented pre-existing blocker debt via the per-patch,
    # signature-scoped allowlist. A blocker survives filtering unless the
    # current patch has an explicit allowlist entry matching its signature,
    # so new patches / new blockers still fail this test.
    patch_rel = patch_path.relative_to(_REPO_ROOT).as_posix()
    remaining = [b for b in blockers if not _is_allowlisted(patch_rel, b.finding)]

    assert not remaining, (
        f"{len(remaining)} unallowlisted blocker(s) in {patch_path.name}:\n"
        + "\n".join(f"  - {r}" for r in remaining)
    )
