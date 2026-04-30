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
