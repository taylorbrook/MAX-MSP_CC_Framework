"""Plan 30-01: audit_signal_role_coverage() unit tests.

Covers the new audit function shape (msp/mc per-domain bucketing),
gap_count derivation, by_role enum tally, edge cases (mixed audited
outlets, empty I/O excluded, non-MSP/MC excluded), and sort stability.

Pure shape tests -- no data migration verification (Plans 30-02/03/04
add migration-specific coverage).

Plan 30-03 EXTENSIONS (appended below):
- TestClassifier: digest-keyword classifier (D-04 conflict policy +
  D-05 LOCKED synonym set; tokens info/channel/name/metadata/hz/freq/amp
  must NOT auto-apply at medium tier).
- TestClassifyOutletHelper: _classify_outlet top-level helper (Blocker 2
  fix — Plan 30-04 imports the helper for MC fall-through).
- TestApply: cmd_apply_run contract (path-traversal guard, enum guard,
  overwrite refusal, idempotent, low-confidence-rejected,
  pipe-roundtrip — Warning 5 fix).
- TestAuditOutputs: --write-review emits SIGNAL-ROLE-REVIEW.md +
  signal-role-audit.json with the 6-column shape and # verify markers.
"""

from __future__ import annotations

import json
from pathlib import Path

import pytest

from src.maxpat.db_lookup import (
    ObjectDatabase,
    _SIGNAL_ROLE_ENUM,
)

# Plan 30-03: import the audit script as a module so unit tests can drive
# its top-level callables (cmd_apply_run, cmd_audit_run, _classify_digest,
# _classify_outlet, _parse_review_md) directly with kwargs.
import scripts.audit_signal_role as audit_cli  # noqa: E402


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


# ── Plan 30-03 helpers ────────────────────────────────────────────


def _make_review_file(tmp_path: Path, rows: list[dict]) -> Path:
    """Write a 6-column markdown review file under tmp_path's phase dir.

    Each row dict carries keys: object, outlet_id, digest, suggested_role,
    confidence, curator_role. Pipes inside `digest` are escaped to `\\|` so
    the parser's pipe-unescape (Warning 5 fix) is exercised end-to-end.
    """
    target_dir = tmp_path / ".planning" / "phases" / "30-msp-outlet-coverage-sweep"
    target_dir.mkdir(parents=True, exist_ok=True)
    path = target_dir / "SIGNAL-ROLE-REVIEW.md"

    def _esc(cell: str) -> str:
        return (cell or "").replace("|", "\\|")

    lines = [
        "# Signal Role Review (test fixture)",
        "",
        "| object | outlet_id | digest | suggested_role | confidence | curator_role |",
        "|---|---|---|---|---|---|",
    ]
    for r in rows:
        lines.append(
            f"| {r['object']} | {r['outlet_id']} | "
            f"{_esc(r['digest'])} | "
            f"{r['suggested_role']} | {r['confidence']} | {r['curator_role']} |"
        )
    path.write_text("\n".join(lines) + "\n", encoding="utf-8")
    return path


def _make_overrides(tmp_path: Path, entries: dict) -> Path:
    """Write a minimal isolated overrides.json with the supplied entries.

    The shape matches the real overrides.json: a top-level dict with a
    `_comment` and `objects` key. The loader looks up `objects[name]`, so
    keys MUST live there.
    """
    overrides_dir = tmp_path / ".claude" / "max-objects"
    overrides_dir.mkdir(parents=True, exist_ok=True)
    path = overrides_dir / "overrides.json"
    payload = {
        "_comment": "Test fixture — Plan 30-03 cmd_apply_run isolation",
        "objects": entries,
    }
    path.write_text(json.dumps(payload, indent=2) + "\n", encoding="utf-8")
    return path


# ── Plan 30-03: TestClassifier (Blocker 3 anchor) ─────────────────


class TestClassifier:
    """Plan 30-03: digest-keyword classifier (D-04, D-05, D-08).

    Synonym sets are RESTRICTED to CONTEXT.md D-05's locked tokens.
    Tokens outside that set (info, channel, name, metadata, hz, freq, amp)
    must classify as low/no_match — NOT data/float/list.
    """

    def test_signal_true_forces_audio_regardless_of_digest(self):
        role, conf, rat = audit_cli._classify_digest(
            object_name="stash~", outlet_id=0,
            digest="Index (signal)", signal=True,
        )
        assert (role, conf, rat) == ("audio", "high", "signal_true")

    @pytest.mark.parametrize("digest", ["bang", "Bang", "Done"])
    def test_trigger_keywords(self, digest):
        role, conf, rat = audit_cli._classify_digest("foo~", 0, digest, signal=False)
        assert role == "trigger" and conf == "high" and rat == "trigger_keyword"

    @pytest.mark.parametrize("digest", ["state", "Mute flag", "Active", "busy"])
    def test_status_keywords(self, digest):
        role, conf, rat = audit_cli._classify_digest("foo~", 0, digest, signal=False)
        assert role == "status" and conf == "high" and rat == "status_keyword"

    @pytest.mark.parametrize("digest", ["list of values", "symbol stream", "list"])
    def test_list_synonyms(self, digest):
        role, conf, rat = audit_cli._classify_digest("foo~", 0, digest, signal=False)
        assert role == "list" and conf == "medium" and rat == "list_synonym"

    @pytest.mark.parametrize(
        "digest", ["value", "ms", "samples", "dB", "note number", "delay in ms"]
    )
    def test_float_synonyms(self, digest):
        role, conf, rat = audit_cli._classify_digest("foo~", 0, digest, signal=False)
        assert role == "float" and conf == "medium" and rat == "float_synonym"

    @pytest.mark.parametrize("digest", ["parameter index", "count of items", "position"])
    def test_data_synonyms(self, digest):
        role, conf, rat = audit_cli._classify_digest("foo~", 0, digest, signal=False)
        assert role == "data" and conf == "medium" and rat == "data_synonym"

    @pytest.mark.parametrize("digest", ["", "wibble", "qzx"])
    def test_unmatched_digest_returns_low_no_match(self, digest):
        role, conf, rat = audit_cli._classify_digest("foo~", 0, digest, signal=False)
        assert role is None and conf == "low" and rat == "no_match"

    @pytest.mark.parametrize(
        "digest",
        # Tokens REMOVED from the synonym set per Blocker 3 (CONTEXT D-05 lockdown):
        # info, channel, name, metadata, hz, freq, amp.
        # These MUST classify as low/no_match (not data/float/list).
        ["frequency in Hz", "channel info", "metadata", "Name", "amp envelope", "info bus"],
    )
    def test_unauthorized_synonyms_classify_as_low(self, digest):
        """Blocker 3: tokens outside CONTEXT.md D-05's locked synonym set
        must classify as low/no_match, NOT auto-apply at medium tier."""
        role, conf, rat = audit_cli._classify_digest("foo~", 0, digest, signal=False)
        assert role is None and conf == "low" and rat == "no_match", (
            f"digest {digest!r} classified as {role!r}/{conf!r} — token "
            "leaked into a synonym set; restrict to CONTEXT D-05 lockdown."
        )

    def test_only_canonical_roles_emitted(self):
        for digest in ["bang", "done", "state", "mute", "list", "symbol",
                       "value", "Hz", "parameter", "info", "wibble", ""]:
            role, _, _ = audit_cli._classify_digest("x~", 0, digest, signal=False)
            assert role is None or role in _SIGNAL_ROLE_ENUM

    def test_signal_true_overrides_status_keyword_in_digest(self):
        """D-04 conflict policy edge: digest contains a status keyword AND
        signal:true is set. signal:true wins → audio."""
        role, conf, rat = audit_cli._classify_digest(
            object_name="bizarre~", outlet_id=0,
            digest="Mute state output", signal=True,
        )
        assert (role, conf, rat) == ("audio", "high", "signal_true")


# ── Plan 30-03: TestClassifyOutletHelper (Blocker 2 anchor) ──────


class TestClassifyOutletHelper:
    """Plan 30-03: _classify_outlet must be a top-level callable helper
    (not inline in _classify_db) so Plan 30-04's MC fall-through can call
    it per outlet."""

    def test_classify_outlet_is_top_level_def(self):
        """Grep-style assertion that _classify_outlet exists as a top-level
        def (not nested inside another function)."""
        src = (Path(audit_cli.__file__)).read_text()
        assert "\ndef _classify_outlet(" in src or src.startswith("def _classify_outlet("), (
            "_classify_outlet must be a top-level function in "
            "scripts/audit_signal_role.py (Blocker 2 fix). Plan 30-04 "
            "imports and calls it directly."
        )

    def test_classify_outlet_returns_classified_row_shape(self):
        obj = {
            "name": "gain~",
            "domain": "MSP",
            "outlets": [
                {"id": 0, "type": "signal", "signal": True, "digest": "Audio out"},
                {"id": 1, "type": "", "signal": False, "digest": ""},
            ],
        }
        row0 = audit_cli._classify_outlet("gain~", obj, 0)
        assert set(row0.keys()) >= {
            "object", "outlet_id", "digest", "suggested_role",
            "confidence", "curator_role", "rationale",
        }
        assert row0["object"] == "gain~"
        assert row0["outlet_id"] == 0
        assert row0["suggested_role"] == "audio"
        assert row0["confidence"] == "high"
        assert row0["rationale"] == "signal_true"

        row1 = audit_cli._classify_outlet("gain~", obj, 1)
        assert row1["confidence"] == "low"
        assert row1["suggested_role"] == ""
        assert row1["rationale"] == "no_match"


# ── Plan 30-03: TestApply ─────────────────────────────────────────


class TestApply:
    """Plan 30-03: --apply subcommand contract (path traversal, enum guard,
    overwrite refusal, idempotent, loader rejection, pipe roundtrip)."""

    def test_round_trip_writes_signal_role(self, tmp_path):
        overrides = _make_overrides(tmp_path, {
            "saw~": {"outlets": [{"id": 0, "type": "signal", "signal": True, "digest": "Sawtooth out"}]},
        })
        review = _make_review_file(tmp_path, [
            {"object": "saw~", "outlet_id": 0, "digest": "Sawtooth out",
             "suggested_role": "audio", "confidence": "high", "curator_role": ""},
        ])
        rc = audit_cli.cmd_apply_run(review_file=review, overrides_file=overrides, force=False)
        assert rc == 0
        data = json.loads(overrides.read_text())
        outlet = data["objects"]["saw~"]["outlets"][0]
        assert outlet["signal_role"] == "audio"
        assert "signal" not in outlet  # legacy bool dropped per D-03

    def test_curator_role_overrides_suggested(self, tmp_path):
        overrides = _make_overrides(tmp_path, {
            "foo~": {"outlets": [{"id": 0, "type": "", "signal": False, "digest": "parameter index"}]},
        })
        review = _make_review_file(tmp_path, [
            {"object": "foo~", "outlet_id": 0, "digest": "parameter index",
             "suggested_role": "data", "confidence": "medium", "curator_role": "list"},
        ])
        rc = audit_cli.cmd_apply_run(review_file=review, overrides_file=overrides, force=False)
        assert rc == 0
        outlet = json.loads(overrides.read_text())["objects"]["foo~"]["outlets"][0]
        assert outlet["signal_role"] == "list"

    def test_invalid_curator_role_rejected(self, tmp_path):
        overrides = _make_overrides(tmp_path, {
            "foo~": {"outlets": [{"id": 0, "type": "", "signal": False, "digest": ""}]},
        })
        before = overrides.read_bytes()
        review = _make_review_file(tmp_path, [
            {"object": "foo~", "outlet_id": 0, "digest": "",
             "suggested_role": "", "confidence": "low", "curator_role": "audiox"},
        ])
        rc = audit_cli.cmd_apply_run(review_file=review, overrides_file=overrides, force=False)
        assert rc == 2
        assert overrides.read_bytes() == before  # no write on validation failure

    def test_low_without_curator_rejected(self, tmp_path):
        overrides = _make_overrides(tmp_path, {
            "foo~": {"outlets": [{"id": 0, "type": "", "signal": False, "digest": ""}]},
        })
        before = overrides.read_bytes()
        review = _make_review_file(tmp_path, [
            {"object": "foo~", "outlet_id": 0, "digest": "",
             "suggested_role": "", "confidence": "low", "curator_role": ""},
        ])
        rc = audit_cli.cmd_apply_run(review_file=review, overrides_file=overrides, force=False)
        assert rc == 2
        assert overrides.read_bytes() == before

    def test_path_traversal_rejected(self, tmp_path):
        overrides = _make_overrides(tmp_path, {})
        before = overrides.read_bytes()
        # Build a path that resolves OUTSIDE the phase dir.
        outside = tmp_path / "etc" / "passwd"
        outside.parent.mkdir(parents=True, exist_ok=True)
        outside.write_text("not a review file")
        rc = audit_cli.cmd_apply_run(review_file=outside, overrides_file=overrides, force=False)
        assert rc == 2
        assert overrides.read_bytes() == before

    def test_nonexistent_review_file_rejected(self, tmp_path):
        overrides = _make_overrides(tmp_path, {})
        # Path INSIDE phase dir but file missing.
        review_dir = tmp_path / ".planning" / "phases" / "30-msp-outlet-coverage-sweep"
        review_dir.mkdir(parents=True, exist_ok=True)
        missing = review_dir / "SIGNAL-ROLE-REVIEW.md"
        rc = audit_cli.cmd_apply_run(review_file=missing, overrides_file=overrides, force=False)
        assert rc != 0

    def test_overwrite_refused_without_force(self, tmp_path):
        overrides = _make_overrides(tmp_path, {
            "foo~": {"outlets": [{"id": 0, "type": "signal", "signal_role": "audio", "digest": ""}]},
        })
        before = overrides.read_bytes()
        review = _make_review_file(tmp_path, [
            {"object": "foo~", "outlet_id": 0, "digest": "",
             "suggested_role": "trigger", "confidence": "high", "curator_role": ""},
        ])
        rc = audit_cli.cmd_apply_run(review_file=review, overrides_file=overrides, force=False)
        assert rc == 2
        assert overrides.read_bytes() == before

    def test_overwrite_allowed_with_force(self, tmp_path):
        overrides = _make_overrides(tmp_path, {
            "foo~": {"outlets": [{"id": 0, "type": "signal", "signal_role": "audio", "digest": ""}]},
        })
        review = _make_review_file(tmp_path, [
            {"object": "foo~", "outlet_id": 0, "digest": "",
             "suggested_role": "trigger", "confidence": "high", "curator_role": ""},
        ])
        rc = audit_cli.cmd_apply_run(review_file=review, overrides_file=overrides, force=True)
        assert rc == 0
        outlet = json.loads(overrides.read_text())["objects"]["foo~"]["outlets"][0]
        assert outlet["signal_role"] == "trigger"

    def test_idempotent_apply_is_byte_stable(self, tmp_path):
        overrides = _make_overrides(tmp_path, {
            "foo~": {"outlets": [{"id": 0, "type": "signal", "signal_role": "audio", "digest": ""}]},
        })
        before = overrides.read_bytes()
        review = _make_review_file(tmp_path, [
            {"object": "foo~", "outlet_id": 0, "digest": "",
             "suggested_role": "audio", "confidence": "high", "curator_role": ""},
        ])
        rc = audit_cli.cmd_apply_run(review_file=review, overrides_file=overrides, force=False)
        assert rc == 0
        assert overrides.read_bytes() == before

    def test_review_md_roundtrip_with_pipe_in_digest(self, tmp_path):
        """Warning 5 fix: writer escapes `|` to `\\|`, parser MUST unescape on
        each cell so digests containing literal pipes round-trip cleanly.
        Without the unescape, a digest like 'value|fallback' is parsed as
        TWO cells and the row malforms (or silently truncates the digest)."""
        review = _make_review_file(tmp_path, [
            {"object": "barz~", "outlet_id": 0, "digest": "value|fallback",
             "suggested_role": "float", "confidence": "medium", "curator_role": ""},
        ])
        rows = audit_cli._parse_review_md(review.read_text())
        assert len(rows) == 1, f"expected exactly 1 row, got {len(rows)}: {rows}"
        assert rows[0]["digest"] == "value|fallback", (
            f"pipe in digest did not round-trip: got {rows[0]['digest']!r}"
        )
        assert rows[0]["object"] == "barz~"
        assert rows[0]["outlet_id"] == 0


# ── Plan 30-03: TestAuditOutputs ──────────────────────────────────


class TestAuditOutputs:
    """Plan 30-03: --write-review emits SIGNAL-ROLE-REVIEW.md + signal-role-audit.json."""

    def test_review_md_has_six_columns(self, tmp_path):
        review_dir = tmp_path / ".planning" / "phases" / "30-msp-outlet-coverage-sweep"
        review_dir.mkdir(parents=True, exist_ok=True)
        rc = audit_cli.cmd_audit_run(
            write_review=True,
            review_dir=review_dir,
            domains=("msp",),  # restrict for speed
        )
        assert rc in (0, 1)  # 1 if gap_count > threshold; both acceptable
        md = (review_dir / "SIGNAL-ROLE-REVIEW.md").read_text()
        first_real_line = next(
            line for line in md.splitlines()
            if line.startswith("| object")
        )
        assert first_real_line.count("|") == 7  # 6 columns + 2 outer pipes - 1 leading = 7 pipes

    def test_audit_json_is_valid_and_shaped(self, tmp_path):
        review_dir = tmp_path / ".planning" / "phases" / "30-msp-outlet-coverage-sweep"
        review_dir.mkdir(parents=True, exist_ok=True)
        audit_cli.cmd_audit_run(
            write_review=True,
            review_dir=review_dir,
            domains=("msp",),
        )
        data = json.loads((review_dir / "signal-role-audit.json").read_text())
        assert isinstance(data, list)
        if data:
            row = data[0]
            assert set(row.keys()) >= {
                "object", "outlet_id", "digest",
                "suggested_role", "confidence",
                "curator_role", "rationale",
            }
            assert row["confidence"] in {"high", "medium", "low"}

    def test_medium_confidence_rows_carry_verify_marker(self, tmp_path):
        review_dir = tmp_path / ".planning" / "phases" / "30-msp-outlet-coverage-sweep"
        review_dir.mkdir(parents=True, exist_ok=True)
        audit_cli.cmd_audit_run(
            write_review=True,
            review_dir=review_dir,
            domains=("msp",),
        )
        md = (review_dir / "SIGNAL-ROLE-REVIEW.md").read_text()
        json_data = json.loads((review_dir / "signal-role-audit.json").read_text())
        if any(r["confidence"] == "medium" for r in json_data):
            assert "# verify" in md


# ── Plan 30-04: TestSiblingAutoMirror ─────────────────────────────


def _make_db_with_mc_sibling(
    tmp_path,
    *,
    mc_outlets,
    msp_outlets,
    mc_inlets=None,
    msp_inlets=None,
):
    """Build an isolated DB root with one MC object (mc.cycle~) and its
    bare-MSP sibling (cycle~). Used by Plan 30-04 sibling-mirror tests.

    The fixture seeds BOTH a bare-MSP entry AND an MC entry with the
    supplied inlet/outlet shapes so the parity gate has real data.
    """
    msp_dir = tmp_path / "msp"
    msp_dir.mkdir(parents=True, exist_ok=True)
    (msp_dir / "objects.json").write_text(json.dumps({
        "cycle~": {
            "name": "cycle~",
            "domain": "MSP",
            "maxclass": "newobj",
            "inlets": msp_inlets or [{"id": 0, "type": "signal/float", "signal": True}],
            "outlets": msp_outlets,
        }
    }, indent=2))
    mc_dir = tmp_path / "mc"
    mc_dir.mkdir(parents=True, exist_ok=True)
    (mc_dir / "objects.json").write_text(json.dumps({
        "mc.cycle~": {
            "name": "mc.cycle~",
            "domain": "MC",
            "maxclass": "newobj",
            "inlets": mc_inlets or [{"id": 0, "type": "signal/float", "signal": True}],
            "outlets": mc_outlets,
        }
    }, indent=2))
    for d in ["max", "jitter", "gen", "m4l", "rnbo", "packages"]:
        domain_dir = tmp_path / d
        domain_dir.mkdir(parents=True, exist_ok=True)
        (domain_dir / "objects.json").write_text("{}")
    (tmp_path / "aliases.json").write_text("{}")
    (tmp_path / "overrides.json").write_text(json.dumps({"objects": {}}))
    (tmp_path / "pd-blocklist.json").write_text("{}")
    return ObjectDatabase(db_root=tmp_path)


def _make_db_with_mc_only(tmp_path, *, mc_name, mc_outlets, mc_inlets=None):
    """Build an isolated DB with an MC variant that has NO bare-MSP sibling.
    Used by test_no_sibling_returns_none."""
    msp_dir = tmp_path / "msp"
    msp_dir.mkdir(parents=True, exist_ok=True)
    (msp_dir / "objects.json").write_text("{}")  # NO sibling
    mc_dir = tmp_path / "mc"
    mc_dir.mkdir(parents=True, exist_ok=True)
    (mc_dir / "objects.json").write_text(json.dumps({
        mc_name: {
            "name": mc_name,
            "domain": "MC",
            "maxclass": "newobj",
            "inlets": mc_inlets or [{"id": 0, "type": "signal/float", "signal": True}],
            "outlets": mc_outlets,
        }
    }, indent=2))
    for d in ["max", "jitter", "gen", "m4l", "rnbo", "packages"]:
        domain_dir = tmp_path / d
        domain_dir.mkdir(parents=True, exist_ok=True)
        (domain_dir / "objects.json").write_text("{}")
    (tmp_path / "aliases.json").write_text("{}")
    (tmp_path / "overrides.json").write_text(json.dumps({"objects": {}}))
    (tmp_path / "pd-blocklist.json").write_text("{}")
    return ObjectDatabase(db_root=tmp_path)


def _make_db_with_mcs_sibling(
    tmp_path,
    *,
    mcs_outlets,
    msp_outlets,
    mcs_inlets=None,
    msp_inlets=None,
):
    """Build an isolated DB with an MCS variant + bare-MSP sibling.
    Used by test_mcs_prefix_strips_correctly."""
    msp_dir = tmp_path / "msp"
    msp_dir.mkdir(parents=True, exist_ok=True)
    (msp_dir / "objects.json").write_text(json.dumps({
        "cycle~": {
            "name": "cycle~",
            "domain": "MSP",
            "maxclass": "newobj",
            "inlets": msp_inlets or [{"id": 0, "type": "signal/float", "signal": True}],
            "outlets": msp_outlets,
        }
    }, indent=2))
    mc_dir = tmp_path / "mc"
    mc_dir.mkdir(parents=True, exist_ok=True)
    (mc_dir / "objects.json").write_text(json.dumps({
        "mcs.cycle~": {
            "name": "mcs.cycle~",
            "domain": "MC",
            "maxclass": "newobj",
            "inlets": mcs_inlets or [{"id": 0, "type": "signal/float", "signal": True}],
            "outlets": mcs_outlets,
        }
    }, indent=2))
    for d in ["max", "jitter", "gen", "m4l", "rnbo", "packages"]:
        domain_dir = tmp_path / d
        domain_dir.mkdir(parents=True, exist_ok=True)
        (domain_dir / "objects.json").write_text("{}")
    (tmp_path / "aliases.json").write_text("{}")
    (tmp_path / "overrides.json").write_text(json.dumps({"objects": {}}))
    (tmp_path / "pd-blocklist.json").write_text("{}")
    return ObjectDatabase(db_root=tmp_path)


class TestSiblingAutoMirror:
    """Plan 30-04: _propose_inherited_roles sibling-auto-mirror tests.

    Covers CONTEXT D-11 (positional copy from bare-MSP sibling), threat
    model T-30-04-01 (strict inlet+outlet parity gate), and curator-override
    audit-trail semantics (proposer is purely advisory).
    """

    def test_sibling_mirror_copies_role_positionally(self, tmp_path):
        """When MC variant's name strips to a known MSP sibling and I/O parity
        holds, the sibling's outlet roles are copied outlet-by-outlet."""
        db = _make_db_with_mc_sibling(
            tmp_path,
            msp_outlets=[{"id": 0, "type": "signal", "signal_role": "audio", "digest": "Audio out"}],
            mc_outlets=[{"id": 0, "type": "signal", "digest": "Audio out (multichannel)"}],
        )
        rows = audit_cli._propose_inherited_roles(db, "mc.cycle~")
        assert rows is not None
        assert len(rows) == 1
        assert rows[0]["outlet_id"] == 0
        assert rows[0]["signal_role"] == "audio"
        assert rows[0]["confidence"] == "inherited"

    def test_no_sibling_returns_none(self, tmp_path):
        """MC-only object (no bare-MSP entry after stripping prefix) returns None.

        Builds a DB containing only mc.bands~ with NO bands~ sibling and
        asserts the proposer returns None so the caller falls through to
        the digest classifier."""
        db = _make_db_with_mc_only(
            tmp_path,
            mc_name="mc.bands~",
            mc_outlets=[{"id": 0, "type": "signal", "digest": "Per-band signal out"}],
        )
        result = audit_cli._propose_inherited_roles(db, "mc.bands~")
        assert result is None, (
            f"Expected None for MC-only object with no bare-MSP sibling; "
            f"got {result!r}"
        )

    def test_sibling_mirror_io_parity_gate_outlets(self, tmp_path):
        """MC variant with different outlet count from sibling returns None."""
        db = _make_db_with_mc_sibling(
            tmp_path,
            msp_outlets=[
                {"id": 0, "type": "signal", "signal_role": "audio"},
                {"id": 1, "type": "", "signal_role": "status"},
            ],
            mc_outlets=[
                {"id": 0, "type": "signal", "digest": "Audio"},
                {"id": 1, "type": "", "digest": "Status"},
                {"id": 2, "type": "", "digest": "Channel count (MC-only extra)"},
            ],
        )
        # 2 vs 3 outlets -> parity fails -> classifier handles whole object
        assert audit_cli._propose_inherited_roles(db, "mc.cycle~") is None

    def test_sibling_mirror_io_parity_gate_inlets(self, tmp_path):
        """MC variant with different INLET count from sibling returns None."""
        db = _make_db_with_mc_sibling(
            tmp_path,
            msp_inlets=[{"id": 0, "type": "signal/float", "signal": True}],
            mc_inlets=[
                {"id": 0, "type": "signal/float", "signal": True},
                {"id": 1, "type": "", "digest": "Channel control (MC-only)"},
            ],
            msp_outlets=[{"id": 0, "type": "signal", "signal_role": "audio"}],
            mc_outlets=[{"id": 0, "type": "signal", "digest": "Audio"}],
        )
        # Same outlet count but inlet counts differ -> parity fails
        assert audit_cli._propose_inherited_roles(db, "mc.cycle~") is None

    def test_sibling_with_no_role_yet_falls_through(self, tmp_path):
        """When the bare-MSP sibling exists but has no signal_role yet on an
        outlet, the corresponding row gets confidence='inherited-no-role' so
        the caller routes that outlet to the digest classifier."""
        db = _make_db_with_mc_sibling(
            tmp_path,
            msp_outlets=[{"id": 0, "type": "signal", "digest": "unmigrated"}],
            mc_outlets=[{"id": 0, "type": "signal", "digest": "Audio out"}],
        )
        rows = audit_cli._propose_inherited_roles(db, "mc.cycle~")
        assert rows is not None
        assert rows[0]["signal_role"] is None
        assert rows[0]["confidence"] == "inherited-no-role"

    def test_mcs_prefix_strips_correctly(self, tmp_path):
        """`mcs.X~` resolves to bare `X~` sibling identically to `mc.X~`.

        Builds a DB with mcs.cycle~ + cycle~, asserts the proposer correctly
        strips the longer `mcs.` prefix and finds the same bare-MSP sibling
        that `mc.cycle~` would find."""
        db = _make_db_with_mcs_sibling(
            tmp_path,
            msp_outlets=[
                {"id": 0, "type": "signal", "signal_role": "audio", "digest": "Audio out"},
            ],
            mcs_outlets=[
                {"id": 0, "type": "signal", "digest": "Audio out (mcs-merged)"},
            ],
        )
        rows = audit_cli._propose_inherited_roles(db, "mcs.cycle~")
        assert rows is not None, (
            "mcs.cycle~ must resolve to bare cycle~ via the mcs.-prefix "
            "stripping rule; got None"
        )
        assert len(rows) == 1
        assert rows[0]["outlet_id"] == 0
        assert rows[0]["signal_role"] == "audio"
        assert rows[0]["confidence"] == "inherited"

    def test_trailing_outlet_fallthrough(self, tmp_path):
        """When MC has more outlets than the sibling (trailing extras),
        the strict parity gate (T-30-04-01) currently rejects the whole
        object — the digest classifier handles all three outlets via the
        cmd_audit fall-through path. This test documents the strict-gate
        behavior (None) and ensures no trailing outlet sneaks through."""
        db = _make_db_with_mc_sibling(
            tmp_path,
            msp_outlets=[
                {"id": 0, "type": "signal", "signal_role": "audio"},
                {"id": 1, "type": "", "signal_role": "status"},
            ],
            mc_outlets=[
                {"id": 0, "type": "signal", "digest": "Audio"},
                {"id": 1, "type": "", "digest": "Status"},
                {"id": 2, "type": "", "digest": "Channel count (MC-only trailing)"},
            ],
        )
        result = audit_cli._propose_inherited_roles(db, "mc.cycle~")
        # Strict parity gate (current implementation): outlet count
        # mismatch returns None, and the digest classifier handles all
        # three outlets via the cmd_audit fall-through path.
        assert result is None, (
            "Strict parity gate must reject MC variants with trailing "
            "extras (sibling has 2 outlets, mc has 3). The cmd_audit "
            "fall-through routes ALL three outlets to _classify_outlet."
        )

    def test_curator_override_preserved(self, tmp_path):
        """The proposer is purely advisory: even when the MC override entry
        already has signal_role on outlet i, _propose_inherited_roles still
        proposes a role for it. The curator's value takes precedence at
        apply-time (cmd_apply_run's overwrite-refusal logic), NOT in the
        proposer.

        Asserts the proposer is read-only and does NOT short-circuit when
        curator data already exists. Critical because cmd_apply_run uses
        --force to honor curator overrides; the proposer must still emit a
        row so the review file captures the inherited proposal alongside
        the curator's choice for audit-trail purposes."""
        db = _make_db_with_mc_sibling(
            tmp_path,
            msp_outlets=[
                {"id": 0, "type": "signal", "signal_role": "audio", "digest": "Audio out"},
            ],
            mc_outlets=[
                # MC outlet ALREADY has a signal_role (set by a prior plan
                # or by curator). The proposer should STILL emit a row.
                {"id": 0, "type": "signal", "signal_role": "trigger",
                 "digest": "Audio out (overridden by curator to trigger)"},
            ],
        )
        rows = audit_cli._propose_inherited_roles(db, "mc.cycle~")
        assert rows is not None, (
            "Proposer must NOT short-circuit when curator data exists; "
            "it must still emit an inherited proposal for audit trail."
        )
        assert len(rows) == 1
        # The inherited proposal mirrors the SIBLING's role ("audio"),
        # NOT the MC's pre-existing curator override ("trigger"). The
        # curator-vs-inherited reconciliation happens at apply time.
        assert rows[0]["signal_role"] == "audio", (
            f"Inherited proposal must mirror the sibling's role (audio), "
            f"not the MC's curator override; got {rows[0]['signal_role']!r}"
        )
        assert rows[0]["confidence"] == "inherited"

    def test_real_db_smoke_mc_cycle(self):
        """Smoke: real DB returns a non-None proposal for mc.cycle~."""
        db = ObjectDatabase()
        rows = audit_cli._propose_inherited_roles(db, "mc.cycle~")
        assert rows is not None  # cycle~ has a known sibling

    def test_real_db_mc_only_returns_none(self):
        """Real DB: mc.bands~ has no bare bands~ sibling -> None."""
        db = ObjectDatabase()
        assert audit_cli._propose_inherited_roles(db, "mc.bands~") is None


# ── quick-260701-r9s: TestOutletMetaSynthesis + TestBackfillMetadata ──


class TestOutletMetaSynthesis:
    """quick-260701-r9s: cmd_apply_run's new-outlet synthesis path must
    populate type/digest from canonical domain metadata (or a role-derived
    fallback) instead of the empty-string stub."""

    def test_new_outlet_gets_canonical_meta(self, tmp_path):
        """Applying a role to an outlet NOT already present, with a domain
        objects.json seeded under the isolated db_root, creates the outlet
        with the canonical type/digest copied verbatim."""
        overrides = _make_overrides(tmp_path, {})
        db_root = overrides.parent
        (db_root / "msp").mkdir(parents=True, exist_ok=True)
        (db_root / "msp" / "objects.json").write_text(json.dumps({
            "saw~": {
                "name": "saw~", "domain": "MSP",
                "outlets": [{"id": 0, "type": "signal", "digest": "Sawtooth wave"}],
            }
        }))
        review = _make_review_file(tmp_path, [
            {"object": "saw~", "outlet_id": 0, "digest": "Sawtooth wave",
             "suggested_role": "audio", "confidence": "high", "curator_role": ""},
        ])
        rc = audit_cli.cmd_apply_run(review_file=review, overrides_file=overrides, force=False)
        assert rc == 0
        outlet = json.loads(overrides.read_text())["objects"]["saw~"]["outlets"][0]
        assert outlet["signal_role"] == "audio"
        assert outlet["type"] == "signal"
        assert outlet["digest"] == "Sawtooth wave"

    def test_new_outlet_audio_fallback_when_no_domain_file(self, tmp_path):
        """No domain file present -> role-derived fallback for an audio role
        is ('signal', 'Signal output')."""
        overrides = _make_overrides(tmp_path, {})
        review = _make_review_file(tmp_path, [
            {"object": "myaudio~", "outlet_id": 0, "digest": "",
             "suggested_role": "audio", "confidence": "high", "curator_role": ""},
        ])
        rc = audit_cli.cmd_apply_run(review_file=review, overrides_file=overrides, force=False)
        assert rc == 0
        outlet = json.loads(overrides.read_text())["objects"]["myaudio~"]["outlets"][0]
        assert outlet["type"] == "signal"
        assert outlet["digest"] == "Signal output"

    def test_new_outlet_control_fallback_when_no_domain_file(self, tmp_path):
        """No domain file present -> role-derived fallback for a non-audio
        role is ('control', 'Control output')."""
        overrides = _make_overrides(tmp_path, {})
        review = _make_review_file(tmp_path, [
            {"object": "myctrl", "outlet_id": 0, "digest": "some data",
             "suggested_role": "data", "confidence": "medium", "curator_role": ""},
        ])
        rc = audit_cli.cmd_apply_run(review_file=review, overrides_file=overrides, force=False)
        assert rc == 0
        outlet = json.loads(overrides.read_text())["objects"]["myctrl"]["outlets"][0]
        assert outlet["type"] == "control"
        assert outlet["digest"] == "Control output"

    def test_resolve_outlet_meta_helpers_exist(self):
        """The two helpers are top-level callables."""
        assert callable(audit_cli._canonical_outlet_meta)
        assert callable(audit_cli._resolve_outlet_meta)


class TestBackfillMetadata:
    """quick-260701-r9s: backfill-metadata subcommand fills EMPTY type/digest
    on signal_role outlets only; never clobbers, never touches role-less
    outlets, and is idempotent (byte-stable no-op on re-run)."""

    def test_backfill_fills_empty_leaves_nonempty(self, tmp_path):
        overrides = _make_overrides(tmp_path, {
            "adc~": {"outlets": [
                {"id": 0, "type": "", "digest": "", "signal_role": "audio"},
                {"id": 1, "type": "", "digest": "Right channel", "signal_role": "audio"},
            ]},
        })
        rc = audit_cli.cmd_backfill_run(overrides_file=overrides)
        assert rc == 0
        outs = json.loads(overrides.read_text())["objects"]["adc~"]["outlets"]
        assert outs[0]["type"] == "signal"
        assert outs[0]["digest"] == "Signal output"
        assert outs[1]["type"] == "signal"
        assert outs[1]["digest"] == "Right channel"  # non-empty digest untouched

    def test_backfill_uses_canonical_when_available(self, tmp_path):
        overrides = _make_overrides(tmp_path, {
            "saw~": {"outlets": [{"id": 0, "type": "", "digest": "", "signal_role": "audio"}]},
        })
        db_root = overrides.parent
        (db_root / "msp").mkdir(parents=True, exist_ok=True)
        (db_root / "msp" / "objects.json").write_text(json.dumps({
            "saw~": {"name": "saw~", "domain": "MSP",
                     "outlets": [{"id": 0, "type": "signal", "digest": "Sawtooth wave"}]},
        }))
        rc = audit_cli.cmd_backfill_run(overrides_file=overrides)
        assert rc == 0
        outlet = json.loads(overrides.read_text())["objects"]["saw~"]["outlets"][0]
        assert outlet["type"] == "signal"
        assert outlet["digest"] == "Sawtooth wave"

    def test_backfill_idempotent_byte_stable(self, tmp_path):
        overrides = _make_overrides(tmp_path, {
            "adc~": {"outlets": [{"id": 0, "type": "", "digest": "", "signal_role": "audio"}]},
        })
        rc1 = audit_cli.cmd_backfill_run(overrides_file=overrides)
        assert rc1 == 0
        after_first = overrides.read_bytes()
        rc2 = audit_cli.cmd_backfill_run(overrides_file=overrides)
        assert rc2 == 0
        assert overrides.read_bytes() == after_first

    def test_backfill_ignores_roleless_outlets(self, tmp_path):
        overrides = _make_overrides(tmp_path, {
            "foo~": {"outlets": [{"id": 0, "type": "", "digest": ""}]},  # no signal_role
        })
        before = overrides.read_bytes()
        rc = audit_cli.cmd_backfill_run(overrides_file=overrides)
        assert rc == 0
        assert overrides.read_bytes() == before  # no mutation

    def test_backfill_never_mutates_signal_role(self, tmp_path):
        overrides = _make_overrides(tmp_path, {
            "adc~": {"outlets": [{"id": 0, "type": "", "digest": "", "signal_role": "audio"}]},
        })
        rc = audit_cli.cmd_backfill_run(overrides_file=overrides)
        assert rc == 0
        outlet = json.loads(overrides.read_text())["objects"]["adc~"]["outlets"][0]
        assert outlet["signal_role"] == "audio"  # role unchanged
