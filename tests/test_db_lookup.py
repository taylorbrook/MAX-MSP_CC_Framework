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
    (after the package filter). "opensoundcontrol" is a known empty-I/O
    package object from CNMAT externals (it's a documentation pseudo-class
    that survived quick-260427-l2t cleanup). Passing allowed_packages=[]
    rejects it before the warn helper fires.

    Previously used "ease" as the canary; quick-260427-l2t auto-extracted
    I/O for it from the ease-max helpfile, so it's no longer empty-I/O.
    """
    db = ObjectDatabase()
    # Sanity: "opensoundcontrol" IS an empty-I/O package object today. If
    # this precondition fails, pick another empty-I/O package object by
    # scanning: [n for n,o in db._objects.items() if not o.get("inlets")
    #           and not o.get("outlets") and "package" in o]
    osc = db._objects.get("opensoundcontrol")
    assert osc is not None, "precondition: 'opensoundcontrol' must exist in DB"
    assert "package" in osc, "precondition: 'opensoundcontrol' must be a package object"
    assert not osc.get("inlets") and not osc.get("outlets"), (
        "precondition: 'opensoundcontrol' must be empty-I/O"
    )

    with warnings.catch_warnings(record=True) as caught:
        warnings.simplefilter("always")
        result = db.lookup("opensoundcontrol", allowed_packages=[])
    assert result is None, "'opensoundcontrol' must be filtered out with allowed_packages=[]"
    user_warnings = [w for w in caught if issubclass(w.category, UserWarning)]
    assert len(user_warnings) == 0, (
        f"filtered-out empty-I/O objects must not warn; got {len(user_warnings)}"
    )


# ── lookup_strict() ─────────────────────────────────────────────

def test_lookup_strict_returns_object_for_normal_hit():
    db = ObjectDatabase()
    result = db.lookup_strict("cycle~")
    assert result is not None
    assert result["name"] == "cycle~"


def test_lookup_strict_returns_none_for_empty_io_entry():
    """'dsp' is the same stable empty-I/O canary used by has_complete_io
    tests above. lookup() still returns it (with a UserWarning); the
    strict variant must return None so callers fail fast."""
    db = ObjectDatabase()
    # Suppress the expected one-time UserWarning from the lookup()
    # delegation -- it's the documented behavior, not what this test guards.
    with warnings.catch_warnings():
        warnings.simplefilter("ignore", UserWarning)
        assert db.lookup("dsp") is not None  # baseline: lookup still hits
        assert db.lookup_strict("dsp") is None  # strict variant rejects


def test_lookup_strict_returns_object_for_variable_io_with_empty_defaults():
    """Defensive variable_io exemption: an entry with empty default I/O
    but a variable_io_rules registration is a legitimate dynamically-
    sized object (its real I/O is computed by compute_io_counts at
    connection time). Must NOT be rejected.

    Real DB has no such entry today (every variable_io_rules target ships
    with populated defaults), so we inject one -- same pattern as
    test_has_complete_io_respects_variable_io_exemption."""
    db = ObjectDatabase()
    db._objects["__test_var_io_strict__"] = {
        "name": "__test_var_io_strict__",
        "inlets": [],
        "outlets": [],
    }
    db._variable_io_rules["__test_var_io_strict__"] = {
        "inlet_count": "arg_count",
        "outlet_count": "arg_count",
    }
    result = db.lookup_strict("__test_var_io_strict__")
    assert result is not None
    assert result["name"] == "__test_var_io_strict__"


def test_lookup_strict_resolves_alias():
    """t -> trigger; lookup_strict must use the same alias map as lookup()."""
    db = ObjectDatabase()
    result = db.lookup_strict("t")
    assert result is not None
    assert result["name"] == "trigger"


# ── audit_empty_io() ────────────────────────────────────────────

def test_audit_empty_io_segments():
    db = ObjectDatabase()
    audit = db.audit_empty_io()

    # Shape (by_source is an additive dict view -- checked separately in
    # test_audit_empty_io_covers_all_domain_files)
    assert set(audit.keys()) == {
        "critical", "covered_by_override", "variable_io_ok", "by_source"
    }
    for key in ("critical", "covered_by_override", "variable_io_ok"):
        bucket = audit[key]
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

    # critical bucket is non-empty. Lower bound was 50 pre-cleanup; after
    # quick-260427-l2t the bucket dropped to ~7 (documentation pseudo-classes
    # left as known leftovers). The >=1 floor proves the bucket exists
    # without locking in a specific count -- the upper bound is enforced by
    # test_audit_empty_io_critical_bound below.
    assert len(crit) >= 1, (
        f"expected critical bucket to have real entries, got {len(crit)}"
    )

    # covered_by_override may be empty today (0 empty-I/O entries have
    # overrides); just confirm the key is present and the list is a list
    assert isinstance(audit["covered_by_override"], list)


def test_audit_empty_io_critical_bound():
    """Regression guard for FINDINGS § P1-6 cleanup (quick-260427-l2t).

    After Pass A (4 doc-page non-objects deleted from per-domain JSONs) and
    Pass B (~120 package objects populated via tools/extract_pkg_io.py), the
    critical bucket dropped from 130 to ~7. This test locks in the cleanup
    and surfaces regressions:

      - If a new package gets extracted with empty I/O and added to the DB,
        this count creeps up and the test fails -- the fix is to extend
        tools/extract_pkg_io.py (add to MANUAL_FALLBACK or rely on a
        helpfile match) and re-run it.

      - If overrides.json gets corrupted or the deep-merge logic regresses,
        this fails.

    Threshold = 20 (current ~7 expected, headroom for natural drift like a
    new package landing with a few empty-I/O entries before someone runs
    the curator).
    """
    db = ObjectDatabase()
    audit = db.audit_empty_io()
    crit = audit["critical"]
    assert len(crit) < 20, (
        f"empty-I/O critical bucket regressed: {len(crit)} entries (expected <20).\n"
        f"Names: {crit}\n"
        f"Fix: extend tools/extract_pkg_io.py (helpfile match or MANUAL_FALLBACK) "
        f"and re-run it, or add direct overrides for the new entries."
    )


def test_audit_empty_io_covers_all_domain_files():
    """audit_empty_io()['by_source'] surfaces EVERY raw empty-I/O entry.

    The merged self._objects dict holds one entry per canonical name, so
    package entries that share a name with a populated core-domain object
    are shadowed and never appear in critical/covered/variable_io_ok. The
    additive by_source key mirrors the raw per-file state and must expose
    them.

    This test is an INDEPENDENT oracle: it walks the domain JSON files
    itself and never calls any production helper to compute the expected
    total or per-source counts.
    """
    import json as _json
    from pathlib import Path as _Path

    import src.maxpat.db_lookup as _dbmod

    max_objects_root = (
        _Path(_dbmod.__file__).resolve().parents[2] / ".claude" / "max-objects"
    )

    # Exact empty predicate -- must match production capture bit-for-bit.
    def _is_empty(obj):
        return not obj.get("inlets") and not obj.get("outlets")

    # Independent brute-force per-source counts.
    expected_by_source_count: dict[str, int] = {}
    for domain in ("max", "msp", "jitter", "mc", "gen", "m4l", "rnbo"):
        json_path = max_objects_root / domain / "objects.json"
        if not json_path.exists():
            continue
        data = _json.loads(json_path.read_text())
        count = sum(1 for obj in data.values() if _is_empty(obj))
        if count:
            expected_by_source_count[domain] = count

    pkg_root = max_objects_root / "packages"
    if pkg_root.is_dir():
        for pkg_dir in sorted(pkg_root.iterdir()):
            if not pkg_dir.is_dir():
                continue
            json_path = pkg_dir / "objects.json"
            if not json_path.exists():
                continue
            data = _json.loads(json_path.read_text())
            count = sum(1 for obj in data.values() if _is_empty(obj))
            if count:
                expected_by_source_count[f"packages/{pkg_dir.name}"] = count

    brute_force_total = sum(expected_by_source_count.values())

    db = ObjectDatabase()
    audit = db.audit_empty_io()

    # Additive key exists and is a dict of sorted str lists.
    assert isinstance(audit["by_source"], dict)
    for src, names in audit["by_source"].items():
        assert isinstance(names, list), f"by_source[{src}] must be a list"
        assert all(isinstance(x, str) for x in names)
        assert names == sorted(names), f"by_source[{src}] must be sorted"

    # Grand total equals the independent brute-force count.
    audit_total = sum(len(v) for v in audit["by_source"].values())
    assert audit_total == brute_force_total, (
        f"by_source total {audit_total} != brute-force {brute_force_total}"
    )

    # Per-source grouping matches the brute-force per-file counts.
    audit_by_source_count = {
        src: len(names) for src, names in audit["by_source"].items()
    }
    assert audit_by_source_count == expected_by_source_count

    # Shadow-fix regression: previously-invisible package entries surface
    # under their source, but do NOT appear in critical (they are shadowed
    # by populated same-named core entries).
    assert "bach.hypercomment" in audit["by_source"]["packages/Bach"]
    assert "osc-route" in audit["by_source"]["packages/CNMAT"]
    assert "jit.gl.textureset" in audit["by_source"]["packages/Jitter Tools"]

    critical = set(audit["critical"])
    assert "bach.hypercomment" not in critical
    assert "osc-route" not in critical
    assert "jit.gl.textureset" not in critical


# ── compute_io_counts regression (REVIEW 260420-j15 FN-01) ──────

def test_compute_io_counts_honors_overrides_rules_for_lifted_objects():
    """Regression: cycle / combine / router were silently mis-counted.

    See .planning/quick/260420-j15-review-the-objects-database-entries-and-/
    260420-j15-REVIEW.md FN-01 + DQ-02. These three core MAX objects have
    variable_io=true plus an inline io_rule in their per-domain JSON, but
    db_lookup only consults overrides.json:variable_io_rules. Before
    quick-260420-j15 lifted the rules into the loaded registry,
    compute_io_counts fell through to raw default-array lengths (e.g.
    router(['4','6']) returned (4, 5), not (4, 6)). This test locks in the
    fix: if a future edit removes any of the three rules, the test fails
    loudly.
    """
    db = ObjectDatabase()

    # cycle: first arg = outlet count; no-arg = 2 outlets
    assert db.compute_io_counts("cycle", ["5"]) == (1, 5)
    assert db.compute_io_counts("cycle", []) == (1, 2)

    # combine: arg count = inlet count
    assert db.compute_io_counts("combine", ["a", "b", "c"]) == (3, 1)
    # FN-03 fix (REVIEW 260420-j15): arg_count formula now always evaluates
    # len(args), so no-args returns 0 inlets, not the default_inlets=2.
    assert db.compute_io_counts("combine", []) == (0, 1)

    # router: first_arg inlets, second_arg outlets; no-arg = 2x2
    # (first_arg/second_arg keep their default-fallback semantics)
    assert db.compute_io_counts("router", ["4", "6"]) == (4, 6)
    assert db.compute_io_counts("router", []) == (2, 2)


# ── compute_io_counts TC-01 (REVIEW 260420-j15) ─────────────────

def test_compute_io_counts_unknown_object_returns_zero_zero():
    db = ObjectDatabase()
    assert db.compute_io_counts("__does_not_exist__", []) == (0, 0)
    assert db.compute_io_counts("__does_not_exist__", ["a", "b"]) == (0, 0)


def test_compute_io_counts_non_variable_io_returns_db_arrays():
    db = ObjectDatabase()
    # cycle~: 2 inlets (signal freq + phase), 1 outlet (signal). Not variable_io.
    assert db.compute_io_counts("cycle~", []) == (2, 1)
    # Args are ignored for non-variable_io objects.
    assert db.compute_io_counts("cycle~", ["440"]) == (2, 1)


def test_compute_io_counts_trigger_with_full_args():
    db = ObjectDatabase()
    # trigger b i f -> 1 inlet, 3 outlets (one per type letter)
    assert db.compute_io_counts("trigger", ["b", "i", "f"]) == (1, 3)


def test_compute_io_counts_trigger_no_args_post_fn03():
    """FN-03: trigger uses outlet_count='arg_count'. Empty args → 0 outlets,
    not the default 2. Deliberate semantic shift from REVIEW 260420-j15.
    """
    db = ObjectDatabase()
    assert db.compute_io_counts("trigger", []) == (1, 0)


def test_compute_io_counts_route_no_args_post_fn03():
    """FN-03: route uses outlet_count='arg_count+1'. Empty args → 1 outlet
    (just the unmatched), not the default 3.
    """
    db = ObjectDatabase()
    assert db.compute_io_counts("route", []) == (1, 1)


# ── get_outlet_types TC-02 (REVIEW 260420-j15) ──────────────────

def test_get_outlet_types_all_signal():
    db = ObjectDatabase()
    # cycle~ has a single signal outlet
    assert db.get_outlet_types("cycle~", []) == ["signal"]


def test_get_outlet_types_mixed_signal_and_control():
    db = ObjectDatabase()
    # sfplay~: signal channels + control bang on completion. The exact
    # channel count varies by argument, but the multi-outlet result must
    # contain BOTH "signal" and "" entries to prove mixed-type rendering.
    types = db.get_outlet_types("sfplay~", [])
    assert "signal" in types, types
    assert "" in types, types


def test_get_outlet_types_variable_expansion_inherits_control():
    """trigger b i f: 3 control outlets (no signal). Tests the expansion
    path in get_outlet_types where num_outlets exceeds len(db_outlets) and
    types are inherited from the last DB outlet.
    """
    db = ObjectDatabase()
    types = db.get_outlet_types("trigger", ["b", "i", "f"])
    assert types == ["", "", ""], types


def test_get_outlet_types_unknown_returns_empty():
    db = ObjectDatabase()
    assert db.get_outlet_types("__does_not_exist__", []) == []


# ── variable_io registry refactor (REVIEW 260421-b3a FN-01 / DQ-02) ────

def test_compute_io_counts_routepass_uses_loaded_formula():
    """Regression: routepass's rule was living in extract_objects.py's
    VARIABLE_IO_RULES constant, not in overrides.json. compute_io_counts
    consulted only overrides.json, so routepass fell through to default
    array lengths. The output (1, 3) was coincidentally right for 2 args
    because the default_outlets happened to match arg_count+1 at N=2.

    After quick-260421-b3a lifted routepass into overrides.json with the
    normalized 'arg_count+1' formula, the answer (1, 3) now comes from
    the formula path — proven by checking a three-arg case where the old
    fallback would return (1, 3) but the formula returns (1, 4).
    """
    db = ObjectDatabase()
    # The original FN-01 regression case (same number, correct code path):
    assert db.compute_io_counts("routepass", ["a", "b"]) == (1, 3)
    # The arg-count-aware check: 3 args → 4 outlets (3 matches + 1 pass-through)
    assert db.compute_io_counts("routepass", ["a", "b", "c"]) == (1, 4)


def test_compute_io_counts_routepass_normalized_default_outlets():
    """Quick-260421-bti: lock in the normalized routepass rule shape.

    User spec: inlet_count='fixed:1', outlet_count='arg_count+1',
    default_inlets=1, default_outlets=2 — the default_outlets value was
    aligned with the routepass DB entry (2 outlets). The assertion below
    is redundant with the b3a test above on behavior, but explicitly
    anchors this quick task's spec so a future default_outlets drift
    would still have a traceable regression signal.
    """
    db = ObjectDatabase()
    assert db.compute_io_counts("routepass", ["a", "b"]) == (1, 3)


def test_load_time_validation_rejects_unknown_formula(tmp_path):
    """Negative test: ObjectDatabase construction raises ValueError when
    overrides.json:variable_io_rules contains an unsupported formula.

    This validation is the safety net for the refactor — it makes the
    silent-fallback class of bug (stale formula name like
    'arg_count_plus_1') impossible at load time.
    """
    import json

    import pytest

    overrides = {
        "variable_io_rules": {
            "bogus_obj": {
                "inlet_count": "fixed:1",
                "outlet_count": "bogus_formula",
                "default_inlets": 1,
                "default_outlets": 1,
            }
        },
        "objects": {},
    }
    (tmp_path / "overrides.json").write_text(json.dumps(overrides))

    with pytest.raises(ValueError) as excinfo:
        ObjectDatabase(db_root=tmp_path)
    msg = str(excinfo.value)
    assert "bogus_formula" in msg, msg
    assert "bogus_obj" in msg, msg
    assert "outlet_count" in msg, msg


def test_load_time_validation_accepts_live_overrides():
    """Sanity: the real overrides.json in .claude/max-objects/ must pass
    the validator. If this fails, someone added a rule with a formula
    that _apply_io_formula doesn't know about — fix the rule, don't
    loosen the validator.
    """
    ObjectDatabase()  # must not raise


# ── compute_io_counts mc.* (quick-260421-bx3 DQ-07) ────────────
#
# Lock in the 10 argument-driven mc.* objects promoted to variable_io=true
# with matching overrides.json:variable_io_rules entries. These mirror the
# TC-01 / TC-02 pattern above and guard against a regression where a mc.*
# rule gets a default/formula drift (the REVIEW-260420-j15 DQ-07 class of
# bug). Critical disambiguation: most mc.* int args set channel count
# INSIDE a single MC outlet, not outlet count at the connection level —
# those stay variable_io=false and are NOT tested here.


def test_compute_io_counts_mc_pack():
    """mc.pack~ N → N inlets, 1 outlet. first_arg (single int), not arg_count."""
    db = ObjectDatabase()
    assert db.compute_io_counts("mc.pack~", ["4"]) == (4, 1)
    assert db.compute_io_counts("mc.pack~", []) == (2, 1)  # default


def test_compute_io_counts_mc_unpack():
    """mc.unpack~ N → 1 inlet, N outlets."""
    db = ObjectDatabase()
    assert db.compute_io_counts("mc.unpack~", ["6"]) == (1, 6)
    assert db.compute_io_counts("mc.unpack~", []) == (1, 2)  # default


def test_compute_io_counts_mc_separate():
    """mc.separate~ a b c → 1 inlet, arg_count=3 outlets. Only mc.* using arg_count."""
    db = ObjectDatabase()
    assert db.compute_io_counts("mc.separate~", ["2", "2", "4"]) == (1, 3)
    # arg_count with empty args falls through to default_outlets=2 via
    # the same semantic as pack/combine (see test_compute_io_counts_pack_
    # no_args in TC-01 for precedent).


def test_compute_io_counts_mc_combine():
    """mc.combine~ N → N inlets, 1 outlet (first_arg, not arg_count like core combine)."""
    db = ObjectDatabase()
    assert db.compute_io_counts("mc.combine~", ["3"]) == (3, 1)


def test_compute_io_counts_mc_gate():
    """mc.gate~ mirrors gate: fixed 2 inlets (signal+route), N outlets."""
    db = ObjectDatabase()
    assert db.compute_io_counts("mc.gate~", ["4"]) == (2, 4)


def test_compute_io_counts_mc_selector():
    """mc.selector~ mirrors selector~: first_arg+1 inlets (N inputs + selector)."""
    db = ObjectDatabase()
    assert db.compute_io_counts("mc.selector~", ["3"]) == (4, 1)  # 3+1


def test_compute_io_counts_mc_matrix():
    """mc.matrix~ N M → N inlets, M outlets. Signal-only — dump outlet not counted."""
    db = ObjectDatabase()
    assert db.compute_io_counts("mc.matrix~", ["4", "6"]) == (4, 6)


def test_mc_pack_is_variable_io():
    """Post-fix anchor: mc.pack~ flag flipped and rule registered.

    This test fails loudly if a future DB refresh re-extracts mc.pack~
    with variable_io=false (losing the DQ-07 fix) or if the overrides.json
    rule is accidentally removed.
    """
    db = ObjectDatabase()
    obj = db.lookup("mc.pack~")
    assert obj["variable_io"] is True
    assert "mc.pack~" in db._variable_io_rules
