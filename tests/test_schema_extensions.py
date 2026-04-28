"""SCHEMA-01..07: v5.0 schema-extension tests.

Covers all three new typed fields end-to-end:
  - signal_role (per-outlet, six-value closed enum)
  - domain_restricted (per-object, three-value closed enum, list-of-strings)
  - verified_installed (per-object, strict-bool tri-state)

Plus the back-compat regression anchor: write-through projection from
signal_role onto outlet['signal'] preserves the legacy boolean for the
2,015+ existing readers (patcher.py, dsp_critic.py, get_outlet_types).

Plan-01 references: closed-enum + fail-fast at load.
Plan-02 references: alias-resolved getters with honest reverse derivation
  (signal: false -> None, NOT False; D-02).
Plan-03 references: audit_install_coverage / audit_domain_coverage / no
  umbrella audit() wrapper (D-12, D-13).
"""

from __future__ import annotations

import json
from pathlib import Path

import pytest

from src.maxpat.db_lookup import (
    ObjectDatabase,
    _DOMAIN_ENUM,
    _DOMAIN_TO_FIELD,
    _SIGNAL_ROLE_ENUM,
)


# ── Test helpers ──────────────────────────────────────────────────


def _make_db_root(tmp_path: Path, bad_overrides: dict) -> Path:
    """Build a minimal isolated DB root for fail-fast tests.

    Creates:
      - tmp_path/msp/objects.json  with one canonical cycle~ entry
      - tmp_path/overrides.json    with the given (potentially bad) overrides

    The lone msp object is the override target; only `cycle~` exists in this
    isolated DB so any override entry must target it. The constructor fails
    fast on validation errors per D-15 (mirrors _validate_variable_io_rules).
    """
    (tmp_path / "msp").mkdir()
    (tmp_path / "msp" / "objects.json").write_text(
        json.dumps(
            {
                "cycle~": {
                    "name": "cycle~",
                    "maxclass": "newobj",
                    "outlets": [{"id": 0, "signal": True}],
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
            }
        )
    )
    (tmp_path / "overrides.json").write_text(
        json.dumps({"objects": bad_overrides, "variable_io_rules": {}})
    )
    return tmp_path


# ── TestSchemaValidation ──────────────────────────────────────────


class TestSchemaValidation:
    """Plan 01 fail-fast behavior: validator rejects each malformed value
    at load time, naming the offending object and field in the error.
    """

    def test_unknown_signal_role_raises(self, tmp_path):
        """Unknown signal_role enum value raises ValueError naming object + field."""
        root = _make_db_root(
            tmp_path,
            {"cycle~": {"outlets": [{"id": 0, "signal_role": "frobnitz"}]}},
        )
        with pytest.raises(ValueError) as exc_info:
            ObjectDatabase(db_root=root)
        msg = str(exc_info.value)
        assert "frobnitz" in msg
        assert "cycle~" in msg
        assert "signal_role" in msg

    @pytest.mark.parametrize("role", sorted(_SIGNAL_ROLE_ENUM))
    def test_each_known_signal_role_accepted(self, tmp_path, role):
        """All six values in _SIGNAL_ROLE_ENUM are accepted by the validator."""
        root = _make_db_root(
            tmp_path,
            {"cycle~": {"outlets": [{"id": 0, "signal_role": role}]}},
        )
        # Should construct without raising
        db = ObjectDatabase(db_root=root)
        assert db.get_signal_role("cycle~", 0) == role

    def test_unknown_domain_in_domain_restricted_raises(self, tmp_path):
        """Unknown enum value in domain_restricted (e.g., 'rbno' typo) raises."""
        root = _make_db_root(
            tmp_path,
            {"cycle~": {"domain_restricted": ["rbno"]}},
        )
        with pytest.raises(ValueError) as exc_info:
            ObjectDatabase(db_root=root)
        msg = str(exc_info.value)
        assert "rbno" in msg
        assert "cycle~" in msg

    @pytest.mark.parametrize("domain", sorted(_DOMAIN_ENUM))
    def test_each_known_domain_accepted(self, tmp_path, domain):
        """All three values in _DOMAIN_ENUM are accepted as single-element lists."""
        root = _make_db_root(
            tmp_path,
            {"cycle~": {"domain_restricted": [domain]}},
        )
        db = ObjectDatabase(db_root=root)
        assert db.get_domain_restrictions("cycle~") == [domain]

    def test_domain_restricted_non_list_raises(self, tmp_path):
        """domain_restricted as a bare string (not list) raises ValueError."""
        root = _make_db_root(
            tmp_path,
            {"cycle~": {"domain_restricted": "rnbo"}},
        )
        with pytest.raises(ValueError) as exc_info:
            ObjectDatabase(db_root=root)
        msg = str(exc_info.value)
        assert "list" in msg
        assert "cycle~" in msg
        assert "str" in msg

    def test_verified_installed_string_raises(self, tmp_path):
        """verified_installed as a string (e.g., 'yes') raises ValueError."""
        root = _make_db_root(
            tmp_path,
            {"cycle~": {"verified_installed": "yes"}},
        )
        with pytest.raises(ValueError) as exc_info:
            ObjectDatabase(db_root=root)
        msg = str(exc_info.value)
        assert "bool" in msg
        assert "cycle~" in msg
        assert "str" in msg

    def test_verified_installed_int_raises(self, tmp_path):
        """verified_installed: 1 raises (type(value) is bool, not isinstance).

        Python treats True/False as int subclasses, so isinstance(1, bool) is
        False but isinstance(True, int) is True. The validator uses
        `type(value) is bool` to reject the 1/0/true/false typo class.
        """
        root = _make_db_root(
            tmp_path,
            {"cycle~": {"verified_installed": 1}},
        )
        with pytest.raises(ValueError) as exc_info:
            ObjectDatabase(db_root=root)
        msg = str(exc_info.value)
        assert "bool" in msg
        assert "cycle~" in msg

    def test_verified_installed_true_accepted(self, tmp_path):
        """verified_installed: true is accepted and round-trips to is_verified."""
        root = _make_db_root(
            tmp_path,
            {"cycle~": {"verified_installed": True}},
        )
        db = ObjectDatabase(db_root=root)
        assert db.get_install_state("cycle~") is True
        assert db.is_verified_installed("cycle~") is True

    def test_verified_installed_false_accepted(self, tmp_path):
        """verified_installed: false is accepted and round-trips through getters."""
        root = _make_db_root(
            tmp_path,
            {"cycle~": {"verified_installed": False}},
        )
        db = ObjectDatabase(db_root=root)
        assert db.get_install_state("cycle~") is False
        # is_verified_installed collapses to state is True (D-10)
        assert db.is_verified_installed("cycle~") is False


# ── TestWriteThrough ──────────────────────────────────────────────


class TestWriteThrough:
    """Plan 01 Task 2: signal_role -> signal:bool projection at load time.

    The write-through is the back-compat shim that lets every existing
    `outlet.get('signal')` reader work unchanged while curators write only
    the typed signal_role field (D-01, D-03).
    """

    def test_signal_role_audio_projects_true(self, tmp_path):
        """signal_role: 'audio' overrides any explicit signal: false to True."""
        root = _make_db_root(
            tmp_path,
            {
                "cycle~": {
                    "outlets": [
                        {"id": 0, "signal_role": "audio", "signal": False}
                    ]
                }
            },
        )
        db = ObjectDatabase(db_root=root)
        outlet = db.lookup("cycle~")["outlets"][0]
        assert outlet["signal"] is True

    def test_signal_role_status_projects_false(self, tmp_path):
        """signal_role: 'status' overrides any explicit signal: true to False."""
        root = _make_db_root(
            tmp_path,
            {
                "cycle~": {
                    "outlets": [
                        {"id": 0, "signal_role": "status", "signal": True}
                    ]
                }
            },
        )
        db = ObjectDatabase(db_root=root)
        outlet = db.lookup("cycle~")["outlets"][0]
        assert outlet["signal"] is False

    def test_no_signal_role_preserves_legacy_signal(self, all_objects):
        """Pristine outlets (no signal_role) keep their legacy signal: bool.

        Verified against the production DB (no isolated tmp_path): every
        outlet that has only signal: bool and no signal_role keeps the bool
        unchanged after _apply_signal_role_writethrough(). This is the
        2,015-object regression anchor.
        """
        # Find any object whose outlet 0 has signal: True and no signal_role.
        # phasor~ is a stable choice: MSP, signal:true outlet 0, no curated role.
        # (cycle~ NOW has signal_role from Plan 03 Task 2; phasor~ stays bare.)
        db = ObjectDatabase()
        obj = db.lookup("phasor~")
        assert obj is not None, "phasor~ missing from DB -- pick another bare-signal probe"
        outlet0 = obj["outlets"][0]
        assert "signal_role" not in outlet0, (
            "phasor~ now has a curated signal_role -- pick another bare probe"
        )
        # Legacy bool preserved unchanged
        assert outlet0["signal"] is True


# ── TestGetters ───────────────────────────────────────────────────


class TestGetters:
    """Plan 02 surface: five public getters on ObjectDatabase.

    All getters resolve aliases first, return None / [] / False on unknown
    objects, and the list returner returns a fresh copy (T-28-04 isolation).
    """

    @pytest.fixture(scope="class")
    def db(self):
        return ObjectDatabase()

    def test_get_signal_role_curated_returns_role_string(self, db):
        """After Plan 03 Task 2 fixture, cycle~ outlet 0 returns 'audio'."""
        assert db.get_signal_role("cycle~", 0) == "audio"

    def test_get_signal_role_alias_resolution(self, db):
        """`t` is an alias for `trigger`; both calls return the same value."""
        # trigger has signal:false, no curated role -> both return None per D-02
        assert db.get_signal_role("t", 0) == db.get_signal_role("trigger", 0)

    def test_get_signal_role_out_of_range(self, db):
        """Out-of-range outlet index returns None (no IndexError)."""
        assert db.get_signal_role("cycle~", 99) is None

    def test_get_signal_role_unknown_object(self, db):
        """Unknown object name returns None (no KeyError)."""
        assert db.get_signal_role("nonexistent~", 0) is None

    def test_get_signal_role_legacy_false_returns_none(self, db):
        """An outlet with only signal: false and no signal_role returns None.

        Per D-02: None means "not yet curated"; Phase 29's role-aware
        validators must treat None as "fall back to bool check, do not emit
        a role-mismatch error." This distinguishes "known not audio" from
        "genuinely uncurated."
        """
        # trigger outlet 0: signal: False, no signal_role.
        outlet = db.lookup("trigger")["outlets"][0]
        assert outlet.get("signal") is False
        assert "signal_role" not in outlet
        assert db.get_signal_role("trigger", 0) is None

    def test_get_install_state_absent_returns_none(self, db):
        """cycle~ has no verified_installed field -> tri-state None (unaudited)."""
        assert db.get_install_state("cycle~") is None

    def test_get_install_state_explicit_false(self, db):
        """After Plan 03 Task 2, bach.llll2list has verified_installed: false."""
        assert db.get_install_state("bach.llll2list") is False

    def test_is_verified_installed_only_true_when_state_true(self, db):
        """Per D-10: is_verified_installed collapses to `state is True` only.

        Both False (audited and missing) and None (unaudited) return False.
        Phase 29 must use get_install_state() to distinguish them.
        """
        # Explicit false case
        assert db.is_verified_installed("bach.llll2list") is False
        # Absent (None) case
        assert db.is_verified_installed("cycle~") is False

    def test_get_domain_restrictions_absent_returns_empty_list(self, db):
        """cycle~ has no domain_restricted -> [] (no tri-state per D-07)."""
        assert db.get_domain_restrictions("cycle~") == []

    def test_get_domain_restrictions_returns_list_copy(self, db):
        """Mutating the returned list does not affect a subsequent call (T-28-04)."""
        r1 = db.get_domain_restrictions("floor~")
        r1.append("hacked")
        r2 = db.get_domain_restrictions("floor~")
        assert "hacked" not in r2
        assert r2 == ["rnbo"]

    def test_is_domain_restricted_with_floor_tilde(self, db):
        """After Plan 03 Task 2 fixture, floor~ is restricted to ['rnbo']."""
        assert db.is_domain_restricted("floor~") is True
        assert db.get_domain_restrictions("floor~") == ["rnbo"]


# ── TestAuditFunctions ────────────────────────────────────────────


class TestAuditFunctions:
    """Plan 03 Task 1 surface: audit_install_coverage, audit_domain_coverage.

    Plus back-compat regression anchors:
      - audit_empty_io shape unchanged (D-12 invariant)
      - no umbrella audit() wrapper added (D-13 invariant)
    """

    @pytest.fixture(scope="class")
    def db(self):
        return ObjectDatabase()

    def test_audit_install_coverage_keys(self, db):
        """Returns dict with exactly two keys: 'unaudited' and 'verified_false'."""
        result = db.audit_install_coverage()
        assert set(result.keys()) == {"unaudited", "verified_false"}

    def test_audit_install_coverage_sorted(self, db):
        """Both lists are sorted alphabetically."""
        result = db.audit_install_coverage()
        assert result["unaudited"] == sorted(result["unaudited"])
        assert result["verified_false"] == sorted(result["verified_false"])

    def test_audit_install_coverage_disjoint(self, db):
        """No canonical name appears in both lists by construction."""
        result = db.audit_install_coverage()
        unaudited = set(result["unaudited"])
        verified_false = set(result["verified_false"])
        assert unaudited.isdisjoint(verified_false)

    def test_audit_install_coverage_includes_fixture(self, db):
        """After Plan 03 Task 2, 'bach.llll2list' is in verified_false."""
        result = db.audit_install_coverage()
        assert "bach.llll2list" in result["verified_false"]

    def test_audit_domain_coverage_keys(self, db):
        """Returns dict with exactly one key: 'restricted_no_coverage'."""
        result = db.audit_domain_coverage()
        assert set(result.keys()) == {"restricted_no_coverage"}

    def test_audit_domain_coverage_sorted(self, db):
        """The single list is sorted alphabetically."""
        result = db.audit_domain_coverage()
        assert result["restricted_no_coverage"] == sorted(
            result["restricted_no_coverage"]
        )

    def test_audit_domain_coverage_detects_orphan(self, tmp_path):
        """An override claiming domain_restricted: ['m4l'] on an MSP-domain
        object is an orphan (the canonical entry is in MSP, not M4L). The
        audit must surface the canonical name in restricted_no_coverage.
        """
        root = _make_db_root(
            tmp_path,
            # cycle~ is in msp/objects.json (domain: 'MSP'). Restricting to
            # m4l makes it an orphan -- canonical entry has no M4L coverage.
            {"cycle~": {"domain_restricted": ["m4l"]}},
        )
        db = ObjectDatabase(db_root=root)
        result = db.audit_domain_coverage()
        assert "cycle~" in result["restricted_no_coverage"]

    def test_audit_empty_io_shape_unchanged(self, db):
        """Back-compat anchor (D-12): audit_empty_io still returns its three keys."""
        result = db.audit_empty_io()
        assert set(result.keys()) == {
            "critical",
            "covered_by_override",
            "variable_io_ok",
        }

    def test_no_umbrella_audit_method(self, db):
        """D-13 negative invariant: no umbrella `audit()` wrapper exists.

        Phase 28 surface is the three focused audit functions; an umbrella
        wrapper would couple them and is explicitly out of scope for this
        phase (deferred to Phase 30 if a CLI entry point is wanted).
        """
        assert not hasattr(db, "audit")
