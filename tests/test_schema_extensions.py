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
import warnings
from pathlib import Path

import pytest

from src.maxpat.db_lookup import (
    ObjectDatabase,
    _DOMAIN_ENUM,
    _DOMAIN_TO_FIELD,
    _SIGNAL_ROLE_ENUM,
)
from src.maxpat.validation import validate_patch


# ── Test helpers ──────────────────────────────────────────────────


_SEED_OBJECT_NAMES = {"cycle~"}


def _make_db_root(tmp_path: Path, bad_overrides: dict) -> Path:
    """Build a minimal isolated DB root for fail-fast tests.

    Creates:
      - tmp_path/msp/objects.json  with one canonical cycle~ entry
      - tmp_path/overrides.json    with the given (potentially bad) overrides

    The lone msp object is the override target; only `cycle~` exists in this
    isolated DB so any override entry must target it. The constructor fails
    fast on validation errors per D-15 (mirrors _validate_variable_io_rules).

    Override-key validation: the deep-merge in ObjectDatabase._load silently
    drops override entries whose key isn't in self._objects (line ~154),
    which means a typo'd override target (e.g., {"nonexistant~": {...}})
    would never reach the validator. This helper asserts every non-comment
    override key is in _SEED_OBJECT_NAMES so tests fail loudly instead of
    silently green-passing on a never-validated override.

    Note on supplementary files: aliases.json, pd-blocklist.json, and
    package_info.json are deliberately omitted -- the constructor uses
    `if path.exists()` guards, so omitting them works today. If a future
    refactor changes those guards to required reads, every test built on
    this helper would fail with confusing FileNotFoundError; add stubs
    here at that point.
    """
    bad_keys = {
        key
        for key in bad_overrides
        if not key.startswith("_") and key not in _SEED_OBJECT_NAMES
    }
    assert not bad_keys, (
        f"_make_db_root override targets must be in _SEED_OBJECT_NAMES "
        f"({sorted(_SEED_OBJECT_NAMES)}); deep-merge silently drops "
        f"unknown keys, so a typo here means the validator never sees "
        f"the override. Offending keys: {sorted(bad_keys)}."
    )
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

    def test_no_signal_role_preserves_legacy_signal(self):
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


# ── TestInstallWarningSurface (Plan 29-01 Task 1 RED probe) ──────
#
# Drives the existence of the _install_warned cache and
# _maybe_warn_install_state helper on ObjectDatabase. Task 2 expands this
# into the full TestInstallWarning class with end-to-end coverage of
# D-09..D-12 behaviors via db.lookup().


class TestInstallWarningSurface:
    """Minimal surface check: cache field + helper method exist.

    This is the Task 1 RED anchor — the helper and cache must be present
    on every ObjectDatabase instance. Behavioral coverage (emit-once,
    silent-on-None, UserWarning category, no ValidationResult) is in
    TestInstallWarning below.
    """

    def test_install_warned_cache_exists(self):
        db = ObjectDatabase()
        assert hasattr(db, "_install_warned")
        assert isinstance(db._install_warned, set)

    def test_maybe_warn_install_state_method_exists(self):
        db = ObjectDatabase()
        assert hasattr(db, "_maybe_warn_install_state")
        assert callable(db._maybe_warn_install_state)


# ── TestInstallWarning (Plan 29-01 Task 2 — D-09..D-12) ──────────


class TestInstallWarning:
    """VALID-03 / D-09..D-12: db.lookup() once-per-name UserWarning when
    verified_installed is explicitly False. Silent on None (unaudited) and
    True (verified present). No ValidationResult emission (D-12: lookup
    warning is the single channel).

    Fixture: bach.llll2list is the canonical verified_installed: false
    entry in overrides.json (line ~11066), confirmed by Phase 28 tests
    and 29-RESEARCH.md anchor table.
    """

    def _fresh_db(self):
        """Return a production ObjectDatabase with empty _install_warned cache.

        ObjectDatabase() construction itself emits 0 install warnings (the
        warning fires only on lookup() calls), so a fresh instance is
        equivalent to clearing the cache.
        """
        db = ObjectDatabase()
        db._install_warned.clear()
        return db

    def test_bach_emits_warning_once(self):
        """First lookup of bach.llll2list emits exactly 1 UserWarning with
        the canonical message text."""
        db = self._fresh_db()
        with warnings.catch_warnings(record=True) as captured:
            warnings.simplefilter("always")
            db.lookup("bach.llll2list")
        install_warns = [
            w for w in captured
            if "verified_installed" in str(w.message)
        ]
        assert len(install_warns) == 1
        msg = str(install_warns[0].message)
        assert "bach.llll2list" in msg
        assert "verified_installed: false" in msg
        assert "Run package extraction" in msg

    def test_warning_cached_per_name(self):
        """Second lookup of the same name is silent (cache hit)."""
        db = self._fresh_db()
        with warnings.catch_warnings(record=True) as captured:
            warnings.simplefilter("always")
            db.lookup("bach.llll2list")
            db.lookup("bach.llll2list")
        install_warns = [
            w for w in captured
            if "verified_installed" in str(w.message)
        ]
        assert len(install_warns) == 1, (
            f"Expected exactly 1 cached warning, got {len(install_warns)}"
        )

    def test_unaudited_silent(self):
        """Objects with verified_installed absent (None per D-09) emit no
        install warning. cycle~ is the canonical unaudited fixture."""
        db = self._fresh_db()
        # Sanity: confirm the fixture is genuinely unaudited
        assert db.get_install_state("cycle~") is None
        with warnings.catch_warnings(record=True) as captured:
            warnings.simplefilter("always")
            db.lookup("cycle~")
        install_warns = [
            w for w in captured
            if "verified_installed" in str(w.message)
        ]
        assert install_warns == []

    def test_userwarning_category_matches(self):
        """Warning category is UserWarning (not a subclass) per D-11."""
        db = self._fresh_db()
        with warnings.catch_warnings(record=True) as captured:
            warnings.simplefilter("always")
            db.lookup("bach.llll2list")
        install_warns = [
            w for w in captured
            if "verified_installed" in str(w.message)
        ]
        assert len(install_warns) == 1
        assert install_warns[0].category is UserWarning

    def test_no_validation_result_emitted(self):
        """validate_patch() emits no ValidationResult for install state.
        D-12: db.lookup warning is the single channel."""
        # Minimal patch using bach.llll2list as a newobj
        patch = {
            "patcher": {
                "boxes": [
                    {"box": {
                        "id": "obj-1",
                        "maxclass": "newobj",
                        "text": "bach.llll2list",
                        "numinlets": 1,
                        "numoutlets": 1,
                        "outlettype": [""],
                        "patching_rect": [0, 0, 80, 22],
                    }}
                ],
                "lines": [],
            }
        }
        with warnings.catch_warnings():
            warnings.simplefilter("ignore", UserWarning)
            results = validate_patch(patch)
        install_results = [
            r for r in results
            if "verified_installed" in r.message.lower()
            or "install" in r.message.lower()
        ]
        assert install_results == [], (
            f"D-12 violated: validate_patch emitted install ValidationResults: "
            f"{install_results}"
        )

    def test_explicit_true_silent(self):
        """An object with verified_installed: true does not emit an install
        warning on lookup. Per D-10, only explicit False fires.

        Use _make_db_root with an isolated cycle~ fixture marked True so the
        test does not depend on which production objects happen to be marked
        true today (audit progress could change that set).
        """
        # Use tmp_path via the existing helper. cycle~ verified_installed:true
        # is the cleanest controlled fixture; no other object in the isolated
        # DB participates.
        import tempfile
        with tempfile.TemporaryDirectory() as tmp:
            root = _make_db_root(
                Path(tmp),
                {"cycle~": {"verified_installed": True}},
            )
            db = ObjectDatabase(db_root=root)
            with warnings.catch_warnings(record=True) as captured:
                warnings.simplefilter("always")
                db.lookup("cycle~")
            install_warns = [
                w for w in captured
                if "verified_installed" in str(w.message)
            ]
            assert install_warns == []
