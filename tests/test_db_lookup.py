"""Tests for ObjectDatabase empty-I/O health check.

Guards against silent patch-generation failures caused by DB entries with
empty inlets AND empty outlets (130 such entries on the live DB as of
2026-04-19; most recent regression was live.scope~). Verifies:
  - has_complete_io() predicate, including the variable_io exemption
    short-circuit (exercised via monkey-patched fake entry)
  - lookup() emits one-time UserWarning for empty-I/O entries
  - audit_empty_io() segmentation report, with variable_io_ok mirroring
    the _variable_io_rules registry
"""

from __future__ import annotations

import warnings

import pytest

from src.maxpat.db_lookup import ObjectDatabase


# ── has_complete_io ─────────────────────────────────────────────

def test_has_complete_io_true_for_cycle_tilde():
    db = ObjectDatabase()
    assert db.has_complete_io("cycle~") is True


def test_has_complete_io_false_for_empty_entry():
    # "dsp" is a stable doc-artifact entry in max/objects.json with empty
    # inlets AND outlets and no variable_io_rules entry. If this test
    # starts failing, the DB changed -- inspect audit_empty_io()["critical"]
    # to pick a new stable empty-I/O target ("project" is a fallback).
    db = ObjectDatabase()
    assert db.has_complete_io("dsp") is False


def test_has_complete_io_true_for_variable_io():
    # trigger has a variable_io_rules entry. Today its default I/O arrays
    # happen to be populated; the variable_io short-circuit still returns
    # True regardless.
    db = ObjectDatabase()
    assert db.has_complete_io("trigger") is True


def test_has_complete_io_resolves_alias():
    db = ObjectDatabase()
    assert db.has_complete_io("t") is True  # t -> trigger


def test_has_complete_io_false_for_unknown():
    db = ObjectDatabase()
    assert db.has_complete_io("__does_not_exist__") is False


def test_has_complete_io_respects_variable_io_exemption():
    """Cover the defensive variable_io short-circuit branch via monkey-patch.

    Real data does not currently exercise this branch (every variable_io
    rules target has populated default I/O), but we inject a fake entry
    that is BOTH empty-I/O AND has a rules entry to prove the
    short-circuit returns True instead of falling through to the
    inlets/outlets emptiness check.
    """
    db = ObjectDatabase()
    db._objects["__test_var_io__"] = {
        "name": "__test_var_io__",
        "inlets": [],
        "outlets": [],
    }
    db._variable_io_rules["__test_var_io__"] = {
        "inlet_count": "arg_count",
        "outlet_count": "arg_count",
    }
    assert db.has_complete_io("__test_var_io__") is True


# ── lookup() warning behavior ───────────────────────────────────

def test_lookup_warns_once_per_empty_io_name():
    db = ObjectDatabase()
    # First call: warning fires
    with pytest.warns(UserWarning, match="empty inlets/outlets"):
        result = db.lookup("dsp")
    assert result is not None  # object is still returned

    # Second call: warning is suppressed (dedup via _empty_io_warned)
    with warnings.catch_warnings(record=True) as caught:
        warnings.simplefilter("always")
        db.lookup("dsp")
    user_warnings = [w for w in caught if issubclass(w.category, UserWarning)]
    assert len(user_warnings) == 0, (
        f"Second lookup must not re-warn; got {len(user_warnings)} warnings"
    )


def test_lookup_does_not_warn_for_variable_io():
    db = ObjectDatabase()
    with warnings.catch_warnings(record=True) as caught:
        warnings.simplefilter("always")
        db.lookup("trigger")
    user_warnings = [w for w in caught if issubclass(w.category, UserWarning)]
    assert len(user_warnings) == 0


def test_lookup_does_not_warn_for_complete_io():
    db = ObjectDatabase()
    with warnings.catch_warnings(record=True) as caught:
        warnings.simplefilter("always")
        db.lookup("cycle~")
    user_warnings = [w for w in caught if issubclass(w.category, UserWarning)]
    assert len(user_warnings) == 0


def test_lookup_does_not_warn_when_object_not_found():
    db = ObjectDatabase()
    with warnings.catch_warnings(record=True) as caught:
        warnings.simplefilter("always")
        result = db.lookup("__does_not_exist__")
    assert result is None
    user_warnings = [w for w in caught if issubclass(w.category, UserWarning)]
    assert len(user_warnings) == 0


def test_lookup_does_not_warn_when_package_filtered():
    """Empty-I/O package objects must not warn when allowed_packages excludes them.

    Proves _maybe_warn_empty_io runs only on the SUCCESS path of lookup()
    (after the package filter). "ease" is a known empty-I/O package
    object from ease-max. Passing allowed_packages=[] rejects it before
    the warn helper fires.
    """
    db = ObjectDatabase()
    # Sanity: "ease" IS an empty-I/O package object today. If this
    # precondition fails, pick another empty-I/O package object by
    # scanning: [n for n,o in db._objects.items() if not o.get("inlets")
    #           and not o.get("outlets") and "package" in o]
    ease = db._objects.get("ease")
    assert ease is not None, "precondition: 'ease' must exist in DB"
    assert "package" in ease, "precondition: 'ease' must be a package object"
    assert not ease.get("inlets") and not ease.get("outlets"), (
        "precondition: 'ease' must be empty-I/O"
    )

    with warnings.catch_warnings(record=True) as caught:
        warnings.simplefilter("always")
        result = db.lookup("ease", allowed_packages=[])
    assert result is None, "'ease' must be filtered out with allowed_packages=[]"
    user_warnings = [w for w in caught if issubclass(w.category, UserWarning)]
    assert len(user_warnings) == 0, (
        f"filtered-out empty-I/O objects must not warn; got {len(user_warnings)}"
    )


# ── audit_empty_io() ────────────────────────────────────────────

def test_audit_empty_io_segments():
    db = ObjectDatabase()
    audit = db.audit_empty_io()

    # Shape
    assert set(audit.keys()) == {"critical", "covered_by_override", "variable_io_ok"}
    for key, bucket in audit.items():
        assert isinstance(bucket, list), f"{key} must be a list"
        assert all(isinstance(x, str) for x in bucket), f"{key} must contain only str"
        assert bucket == sorted(bucket), f"{key} must be sorted"

    # variable_io_ok mirrors the rules registry (new semantics: not gated
    # on empty I/O; lists ALL canonical names with a rules entry)
    assert len(audit["variable_io_ok"]) == len(db._variable_io_rules), (
        "variable_io_ok must contain every key in _variable_io_rules"
    )
    assert set(audit["variable_io_ok"]) == set(db._variable_io_rules.keys())
    assert "trigger" in audit["variable_io_ok"]

    # Disjoint in practice on current DB (permitted to overlap if a
    # future rules entry has empty defaults -- this assertion is a
    # present-day regression guard, not a spec invariant).
    crit = set(audit["critical"])
    cov = set(audit["covered_by_override"])
    var = set(audit["variable_io_ok"])
    assert crit.isdisjoint(cov), "critical and covered_by_override overlap"
    assert crit.isdisjoint(var), "critical and variable_io_ok overlap today"
    assert cov.isdisjoint(var), "covered_by_override and variable_io_ok overlap today"

    # cycle~ has complete I/O and no rules entry -- must not appear
    all_names = crit | cov | var
    assert "cycle~" not in all_names

    # critical bucket is non-empty (live DB baseline ~130; loose bound
    # tolerates future cleanup)
    assert len(crit) >= 50, (
        f"expected critical bucket to have real entries, got {len(crit)}"
    )

    # covered_by_override may be empty today (0 empty-I/O entries have
    # overrides); just confirm the key is present and the list is a list
    assert isinstance(audit["covered_by_override"], list)
