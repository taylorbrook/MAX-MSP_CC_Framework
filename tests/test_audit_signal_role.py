"""Plan 30-01: audit_signal_role_coverage() unit tests.

Covers the new audit function shape (msp/mc per-domain bucketing),
gap_count derivation, by_role enum tally, edge cases (mixed audited
outlets, empty I/O excluded, non-MSP/MC excluded), and sort stability.

Pure shape tests -- no data migration verification (Plans 30-02/03/04
add migration-specific coverage)."""

from __future__ import annotations

import json
from pathlib import Path

import pytest

from src.maxpat.db_lookup import (
    ObjectDatabase,
    _SIGNAL_ROLE_ENUM,
)


# ── Test helpers ──────────────────────────────────────────────────


_SEED_OBJECT_NAMES = {"cycle~", "mc.cycle~"}


def _make_isolated_db(
    tmp_path: Path,
    msp_objects: dict | None = None,
    mc_objects: dict | None = None,
    max_objects: dict | None = None,
    overrides: dict | None = None,
) -> Path:
    """Build a minimal isolated DB root for audit shape tests.

    Mirrors `tests/test_schema_extensions.py::_make_db_root` conventions:
    creates per-domain `objects.json` files plus an `overrides.json`. Any
    of the per-domain dicts may be omitted.

    The seed object set guard from test_schema_extensions catches typo'd
    override targets that the loader's deep-merge would silently drop.
    Override-key guard: every non-comment override key MUST appear in
    _SEED_OBJECT_NAMES so tests fail loudly instead of silently green.

    Domain JSON files use the bare extracted-fact shape: every object dict
    must have `domain` (e.g., "MSP", "MC") so audit_signal_role_coverage
    can bucket it correctly. The `signal_role` lives on the outlet dict.
    """
    overrides = overrides or {}
    bad_keys = {
        key
        for key in overrides
        if not key.startswith("_") and key not in _SEED_OBJECT_NAMES
    }
    assert not bad_keys, (
        f"_make_isolated_db override targets must be in _SEED_OBJECT_NAMES "
        f"({sorted(_SEED_OBJECT_NAMES)}); deep-merge silently drops "
        f"unknown keys, so a typo here means the validator never sees "
        f"the override. Offending keys: {sorted(bad_keys)}."
    )

    if msp_objects is not None:
        (tmp_path / "msp").mkdir(exist_ok=True)
        (tmp_path / "msp" / "objects.json").write_text(json.dumps(msp_objects))
    if mc_objects is not None:
        (tmp_path / "mc").mkdir(exist_ok=True)
        (tmp_path / "mc" / "objects.json").write_text(json.dumps(mc_objects))
    if max_objects is not None:
        (tmp_path / "max").mkdir(exist_ok=True)
        (tmp_path / "max" / "objects.json").write_text(json.dumps(max_objects))

    (tmp_path / "overrides.json").write_text(
        json.dumps({"objects": overrides, "variable_io_rules": {}})
    )
    return tmp_path


def _msp_obj(name: str, outlets: list[dict]) -> dict:
    """Build a canonical MSP object dict for fixture use."""
    return {
        "name": name,
        "maxclass": "newobj",
        "outlets": outlets,
        "inlets": [{"id": 0, "signal": True}],
        "arguments": [],
        "messages": [],
        "domain": "MSP",
        "module": "msp",
        "min_version": "5.0",
        "verified": True,
        "rnbo_compatible": True,
        "variable_io": False,
    }


def _mc_obj(name: str, outlets: list[dict]) -> dict:
    """Build a canonical MC object dict for fixture use."""
    return {
        "name": name,
        "maxclass": "newobj",
        "outlets": outlets,
        "inlets": [{"id": 0, "signal": True}],
        "arguments": [],
        "messages": [],
        "domain": "MC",
        "module": "mc",
        "min_version": "8.1",
        "verified": True,
        "rnbo_compatible": False,
        "variable_io": False,
    }


def _max_obj(name: str, outlets: list[dict]) -> dict:
    """Build a canonical Max-domain object dict for fixture use."""
    return {
        "name": name,
        "maxclass": "newobj",
        "outlets": outlets,
        "inlets": [{"id": 0, "signal": False}],
        "arguments": [],
        "messages": [],
        "domain": "Max",
        "module": "max",
        "min_version": "5.0",
        "verified": True,
        "rnbo_compatible": True,
        "variable_io": False,
    }


# ── TestAuditSignalRoleCoverage ───────────────────────────────────


class TestAuditSignalRoleCoverage:
    """Plan 30-01: audit_signal_role_coverage shape + bucketing.

    Covers D-13 (per-domain nested shape) and D-15 (test scope: shape,
    per-domain bucketing, edge cases). Migration regression tests live in
    Plan 30-02's tests/test_signal_role_migration.py, NOT here.
    """

    @pytest.fixture(scope="class")
    def real_db(self):
        """Production ObjectDatabase fixture for real-DB shape probes."""
        return ObjectDatabase()

    # ── 1) Top-level shape ────────────────────────────────────────

    def test_returns_msp_and_mc_keys(self, real_db):
        """Top level keys are exactly {'msp', 'mc'} -- no more, no fewer."""
        result = real_db.audit_signal_role_coverage()
        assert set(result) == {"msp", "mc"}

    @pytest.mark.parametrize("domain", ["msp", "mc"])
    def test_each_domain_has_required_subkeys(self, real_db, domain):
        """Each domain dict has exactly {covered, uncovered, by_role, gap_count}."""
        result = real_db.audit_signal_role_coverage()
        assert set(result[domain]) == {
            "covered",
            "uncovered",
            "by_role",
            "gap_count",
        }

    @pytest.mark.parametrize("domain", ["msp", "mc"])
    def test_gap_count_equals_len_uncovered(self, real_db, domain):
        """gap_count is exactly len(uncovered) per D-13."""
        result = real_db.audit_signal_role_coverage()
        assert result[domain]["gap_count"] == len(result[domain]["uncovered"])

    @pytest.mark.parametrize("domain", ["msp", "mc"])
    def test_by_role_keys_match_canonical_enum(self, real_db, domain):
        """by_role keys equal the closed _SIGNAL_ROLE_ENUM exactly."""
        result = real_db.audit_signal_role_coverage()
        assert set(result[domain]["by_role"]) == _SIGNAL_ROLE_ENUM

    def test_real_db_constructs_without_error(self, real_db):
        """Production DB build + audit yields integer gap_counts >= 0."""
        result = real_db.audit_signal_role_coverage()
        assert isinstance(result["msp"]["gap_count"], int)
        assert isinstance(result["mc"]["gap_count"], int)
        assert result["msp"]["gap_count"] >= 0
        assert result["mc"]["gap_count"] >= 0

    # ── 2) Bucketing semantics (isolated DB fixtures) ─────────────

    def test_mixed_outlet_object_is_uncovered(self, tmp_path):
        """An MSP object with one audited and one unaudited outlet lands
        in uncovered, not covered (D-13: covered means EVERY outlet has
        signal_role)."""
        msp = {
            "cycle~": _msp_obj(
                "cycle~",
                outlets=[
                    {"id": 0, "signal_role": "audio"},
                    {"id": 1, "signal": True},  # no signal_role
                ],
            ),
        }
        mc = {}  # empty MC domain
        root = _make_isolated_db(tmp_path, msp_objects=msp, mc_objects=mc)
        db = ObjectDatabase(db_root=root)
        result = db.audit_signal_role_coverage()
        assert "cycle~" in result["msp"]["uncovered"]
        assert "cycle~" not in result["msp"]["covered"]

    def test_fully_audited_object_is_covered(self, tmp_path):
        """An MSP object whose every outlet has signal_role lands in
        covered, not uncovered."""
        msp = {
            "cycle~": _msp_obj(
                "cycle~",
                outlets=[
                    {"id": 0, "signal_role": "audio"},
                    {"id": 1, "signal_role": "audio"},
                ],
            ),
        }
        root = _make_isolated_db(tmp_path, msp_objects=msp, mc_objects={})
        db = ObjectDatabase(db_root=root)
        result = db.audit_signal_role_coverage()
        assert "cycle~" in result["msp"]["covered"]
        assert "cycle~" not in result["msp"]["uncovered"]

    def test_empty_outlets_excluded(self, tmp_path):
        """An MSP object with outlets: [] is in NEITHER covered nor
        uncovered (those gaps belong to audit_empty_io)."""
        msp = {
            "cycle~": _msp_obj("cycle~", outlets=[]),
        }
        root = _make_isolated_db(tmp_path, msp_objects=msp, mc_objects={})
        db = ObjectDatabase(db_root=root)
        result = db.audit_signal_role_coverage()
        assert "cycle~" not in result["msp"]["covered"]
        assert "cycle~" not in result["msp"]["uncovered"]
        # Sanity: by_role is also untouched by empty-outlet objects
        assert all(v == 0 for v in result["msp"]["by_role"].values())

    def test_lists_are_sorted(self, tmp_path):
        """covered and uncovered lists are sorted alphabetically."""
        # Three uncovered objects in non-alphabetical insertion order
        msp = {
            "zeta~": _msp_obj(
                "zeta~", outlets=[{"id": 0, "signal": True}]
            ),
            "alpha~": _msp_obj(
                "alpha~", outlets=[{"id": 0, "signal": True}]
            ),
            "mu~": _msp_obj("mu~", outlets=[{"id": 0, "signal": True}]),
        }
        # Need to allow these names in seed guard via overrides? No --
        # _SEED_OBJECT_NAMES guard only fires on `overrides` keys. Domain
        # JSONs are not validated against that set.
        root = _make_isolated_db(tmp_path, msp_objects=msp, mc_objects={})
        db = ObjectDatabase(db_root=root)
        result = db.audit_signal_role_coverage()
        assert result["msp"]["uncovered"] == sorted(result["msp"]["uncovered"])
        assert result["msp"]["covered"] == sorted(result["msp"]["covered"])

    def test_non_msp_mc_objects_not_counted(self, tmp_path):
        """A Max-domain object (even with signal_role) is NOT in either
        msp or mc buckets per D-09 (Phase 30 is MSP+MC only)."""
        msp = {}
        max_dom = {
            "metro": _max_obj(
                "metro",
                outlets=[{"id": 0, "signal_role": "trigger"}],
            ),
        }
        root = _make_isolated_db(
            tmp_path, msp_objects=msp, mc_objects={}, max_objects=max_dom
        )
        db = ObjectDatabase(db_root=root)
        result = db.audit_signal_role_coverage()
        assert "metro" not in result["msp"]["covered"]
        assert "metro" not in result["msp"]["uncovered"]
        assert "metro" not in result["mc"]["covered"]
        assert "metro" not in result["mc"]["uncovered"]
        # And the Max object's signal_role doesn't leak into by_role tallies
        assert result["msp"]["by_role"]["trigger"] == 0
        assert result["mc"]["by_role"]["trigger"] == 0

    def test_by_role_counts_outlets_not_objects(self, tmp_path):
        """One MSP object with 3 audio outlets contributes 3 to by_role['audio'],
        not 1 (D-13 wording: 'count of outlets across the domain')."""
        msp = {
            "cycle~": _msp_obj(
                "cycle~",
                outlets=[
                    {"id": 0, "signal_role": "audio"},
                    {"id": 1, "signal_role": "audio"},
                    {"id": 2, "signal_role": "audio"},
                ],
            ),
        }
        root = _make_isolated_db(tmp_path, msp_objects=msp, mc_objects={})
        db = ObjectDatabase(db_root=root)
        result = db.audit_signal_role_coverage()
        assert result["msp"]["by_role"]["audio"] == 3

    def test_by_role_distribution_uses_only_canonical_enum(self, tmp_path):
        """by_role only contains keys from _SIGNAL_ROLE_ENUM, even on a DB
        seeded with one role -- the dict is initialized from the enum so
        all six keys are present with zero counts where unused."""
        msp = {
            "cycle~": _msp_obj(
                "cycle~",
                outlets=[{"id": 0, "signal_role": "audio"}],
            ),
        }
        root = _make_isolated_db(tmp_path, msp_objects=msp, mc_objects={})
        db = ObjectDatabase(db_root=root)
        result = db.audit_signal_role_coverage()
        assert set(result["msp"]["by_role"]) == _SIGNAL_ROLE_ENUM
        assert result["msp"]["by_role"]["audio"] == 1
        # All other roles initialized to 0
        for role in _SIGNAL_ROLE_ENUM - {"audio"}:
            assert result["msp"]["by_role"][role] == 0

    def test_mc_domain_buckets_independently(self, tmp_path):
        """An MC object with signal_role lands in mc bucket, not msp bucket."""
        msp = {}
        mc = {
            "mc.cycle~": _mc_obj(
                "mc.cycle~",
                outlets=[{"id": 0, "signal_role": "audio"}],
            ),
        }
        root = _make_isolated_db(tmp_path, msp_objects=msp, mc_objects=mc)
        db = ObjectDatabase(db_root=root)
        result = db.audit_signal_role_coverage()
        assert "mc.cycle~" in result["mc"]["covered"]
        assert "mc.cycle~" not in result["msp"]["covered"]
        assert result["mc"]["by_role"]["audio"] == 1
        assert result["msp"]["by_role"]["audio"] == 0
