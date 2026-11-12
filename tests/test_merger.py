"""Unit tests for the OverrideMerger class.

Tests merge logic, conflict detection, domain grouping, idempotency,
section preservation, orphan flagging, and audit metadata.
"""

from __future__ import annotations

import copy
import json
from pathlib import Path

import pytest

from src.maxpat.audit.merger import OverrideMerger
from src.maxpat.db_lookup import ObjectDatabase

# ---- Shared Fixture Data ----

REAL_OVERRIDES_PATH = (
    Path(__file__).resolve().parent.parent / ".claude" / "max-objects" / "overrides.json"
)


def _make_proposed(
    objects: dict | None = None,
    conflicts: dict | None = None,
) -> dict:
    """Build a minimal proposed-overrides.json structure."""
    return {
        "_comment": "Auto-generated proposed overrides from help patch audit.",
        "_audit_date": "2026-03-13T14:55:45.608353+00:00",
        "objects": objects or {},
        "conflicts": conflicts or {},
    }


def _make_existing(
    objects: dict | None = None,
    version_map: dict | None = None,
    variable_io_rules: dict | None = None,
) -> dict:
    """Build a minimal existing overrides.json structure."""
    return {
        "_comment": "Expert corrections.",
        "objects": objects or {},
        "version_map": version_map if version_map is not None else {"9": {"prefixes": ["array."]}},
        "variable_io_rules": variable_io_rules if variable_io_rules is not None else {"pack": {"inlet_count": "arg_count"}},
    }


def _make_audit_entry(
    outlets: list[dict] | None = None,
    inlets: list[dict] | None = None,
    confidence: str = "HIGH",
    instances: int = 10,
    agreement: float = 0.95,
    source: str = "outlet_type_finding",
) -> dict:
    """Build a single proposed object entry with _audit metadata."""
    entry: dict = {}
    if outlets is not None:
        entry["outlets"] = outlets
    if inlets is not None:
        entry["inlets"] = inlets
    entry["_audit"] = {
        "confidence": confidence,
        "instances": instances,
        "agreement": agreement,
        "source": source,
    }
    return entry


def _signal_outlet(idx: int) -> dict:
    return {"id": idx, "type": "signal", "signal": True, "digest": "Signal output"}


def _control_outlet(idx: int) -> dict:
    return {"id": idx, "type": "", "signal": False, "digest": "Control output"}


def _inlet(idx: int) -> dict:
    return {"id": idx, "type": "", "signal": False, "digest": ""}


@pytest.fixture
def db():
    """ObjectDatabase from the real project."""
    return ObjectDatabase()


@pytest.fixture
def tmp_merger(tmp_path, db):
    """Create a merger with temp files and return (merger, proposed_path, overrides_path)."""
    def _create(proposed_data: dict, existing_data: dict):
        proposed_path = tmp_path / "proposed-overrides.json"
        overrides_path = tmp_path / "overrides.json"
        proposed_path.write_text(json.dumps(proposed_data, indent=2) + "\n")
        overrides_path.write_text(json.dumps(existing_data, indent=2) + "\n")
        merger = OverrideMerger(proposed_path, overrides_path, db)
        return merger, proposed_path, overrides_path

    return _create


# ---- Tests ----


class TestMergeNonConflictProposals:
    """test_merge_non_conflict_proposals: Merging proposed-overrides.json with no
    conflicts produces overrides.json containing all proposed entries."""

    def test_all_proposed_entries_present_in_merged(self, tmp_merger):
        objects = {
            "adsr~": _make_audit_entry(outlets=[_signal_outlet(0), _control_outlet(1)]),
            "allpass~": _make_audit_entry(outlets=[_signal_outlet(0)]),
            "average~": _make_audit_entry(outlets=[_signal_outlet(0)]),
        }
        proposed = _make_proposed(objects=objects)
        existing = _make_existing()
        merger, _, _ = tmp_merger(proposed, existing)

        merged = merger.merge()
        merged_objects = merged["objects"]

        # All 3 proposed entries must appear (ignore domain header keys)
        obj_names = [k for k in merged_objects if not k.startswith("_")]
        for name in objects:
            assert name in obj_names, f"{name} missing from merged objects"

    def test_empty_conflicts_dict(self, tmp_merger):
        proposed = _make_proposed(objects={"adsr~": _make_audit_entry(outlets=[_signal_outlet(0)])})
        existing = _make_existing()
        merger, _, _ = tmp_merger(proposed, existing)

        merged = merger.merge()
        # No conflicts to merge when none passed
        assert "adsr~" in [k for k in merged["objects"] if not k.startswith("_")]


class TestOutletCorrectionsMerged:
    """test_outlet_corrections_merged: HIGH-confidence outlet type entries appear
    in merged output with correct outlets array and _audit metadata."""

    def test_high_confidence_outlets_in_merged(self, tmp_merger):
        entry = _make_audit_entry(
            outlets=[_signal_outlet(0), _control_outlet(1)],
            confidence="HIGH",
            instances=15,
            agreement=0.97,
        )
        proposed = _make_proposed(objects={"adsr~": entry})
        existing = _make_existing()
        merger, _, _ = tmp_merger(proposed, existing)

        merged = merger.merge()
        obj_keys = {k for k in merged["objects"] if not k.startswith("_")}
        assert "adsr~" in obj_keys

        adsr = merged["objects"]["adsr~"]
        assert adsr["outlets"][0]["signal"] is True
        assert adsr["outlets"][1]["signal"] is False
        assert adsr["_audit"]["confidence"] == "HIGH"
        assert adsr["_audit"]["instances"] == 15


class TestEmptyIoPopulated:
    """test_empty_io_populated: HELP_PATCH confidence entries appear in merged
    output with inlets/outlets arrays."""

    def test_help_patch_entries_merged(self, tmp_merger):
        entry = _make_audit_entry(
            inlets=[_inlet(0), _inlet(1)],
            outlets=[_control_outlet(0)],
            confidence="HELP_PATCH",
            instances=2,
            agreement=1.0,
            source="empty_io_coverage",
        )
        proposed = _make_proposed(objects={"adc~": entry})
        existing = _make_existing()
        merger, _, _ = tmp_merger(proposed, existing)

        merged = merger.merge()
        obj_keys = {k for k in merged["objects"] if not k.startswith("_")}
        assert "adc~" in obj_keys

        obj = merged["objects"]["adc~"]
        assert len(obj["inlets"]) == 2
        assert obj["_audit"]["confidence"] == "HELP_PATCH"


class TestDomainGrouping:
    """test_domain_grouping: Merged objects are grouped by domain with
    _domain_header separator keys between groups."""

    def test_domain_headers_present(self, tmp_merger):
        objects = {
            "adsr~": _make_audit_entry(outlets=[_signal_outlet(0)]),  # MSP
            "counter": _make_audit_entry(outlets=[_control_outlet(0)]),  # Max
        }
        proposed = _make_proposed(objects=objects)
        existing = _make_existing()
        merger, _, _ = tmp_merger(proposed, existing)

        merged = merger.merge()
        header_keys = [k for k in merged["objects"] if k.startswith("_domain_")]
        assert len(header_keys) > 0, "No _domain_header keys found"

    def test_domain_header_values_are_strings(self, tmp_merger):
        objects = {
            "adsr~": _make_audit_entry(outlets=[_signal_outlet(0)]),
        }
        proposed = _make_proposed(objects=objects)
        existing = _make_existing()
        merger, _, _ = tmp_merger(proposed, existing)

        merged = merger.merge()
        for k, v in merged["objects"].items():
            if k.startswith("_domain_"):
                assert isinstance(v, str), f"Domain header {k} is not a string: {type(v)}"


class TestConflictDetection:
    """test_conflict_detection: detect_conflicts() returns dict of conflict
    objects with both audit_proposed and existing_manual sides."""

    def test_returns_conflicts_from_proposed(self, tmp_merger):
        conflicts = {
            "coll": {
                "audit_proposed": {"inlets": [_inlet(0)], "_audit": {"confidence": "HIGH", "instances": 5, "agreement": 1.0, "source": "io_count_finding"}},
                "existing_manual": {"inlets": [_inlet(0), _inlet(1)]},
                "reason": "CONFLICT_WITH_MANUAL",
            },
        }
        proposed = _make_proposed(conflicts=conflicts)
        existing = _make_existing(objects={"coll": {"inlets": [_inlet(0), _inlet(1)]}})
        merger, _, _ = tmp_merger(proposed, existing)

        detected = merger.detect_conflicts()
        assert "coll" in detected
        assert "audit_proposed" in detected["coll"]
        assert "existing_manual" in detected["coll"]

    def test_returns_empty_when_no_conflicts(self, tmp_merger):
        proposed = _make_proposed(objects={"adsr~": _make_audit_entry(outlets=[_signal_outlet(0)])})
        existing = _make_existing()
        merger, _, _ = tmp_merger(proposed, existing)

        detected = merger.detect_conflicts()
        assert detected == {}


class TestConflictResolutionFieldLevel:
    """test_conflict_resolution_field_level: resolve_conflicts() with field-level
    instructions preserves manual digest strings while adopting audit corrections."""

    def test_adopt_inlets_keep_manual_outlets(self, tmp_merger):
        manual_outlets = [
            {"id": 0, "type": "signal", "signal": True, "digest": "Signal output"},
            {"id": 1, "type": "", "signal": False, "digest": "bang when line reaches destination"},
        ]
        audit_inlets = [_inlet(0), _inlet(1)]
        audit_outlets = [_signal_outlet(0), _control_outlet(1)]

        conflicts = {
            "line~": {
                "audit_proposed": {"inlets": audit_inlets, "outlets": audit_outlets, "_audit": {"confidence": "HIGH", "instances": 20, "agreement": 0.95, "source": "io_count_finding"}},
                "existing_manual": {"outlets": manual_outlets, "_note": "Outlet 0 is signal, outlet 1 is control bang."},
                "reason": "CONFLICT_WITH_MANUAL",
            },
        }
        proposed = _make_proposed(conflicts=conflicts)
        existing = _make_existing(objects={"line~": {"outlets": manual_outlets, "_note": "Outlet 0 is signal, outlet 1 is control bang."}})
        merger, _, _ = tmp_merger(proposed, existing)

        resolutions = {"line~": {"adopt_fields": ["inlets"]}}
        merged = merger.merge(conflict_resolutions=resolutions)

        line = merged["objects"]["line~"]
        # Inlets adopted from audit
        assert len(line["inlets"]) == 2
        # Outlets preserved from manual (expert digest)
        assert line["outlets"][1]["digest"] == "bang when line reaches destination"

    def test_unresolved_conflicts_skipped(self, tmp_merger):
        conflicts = {
            "stash~": {
                "audit_proposed": {"outlets": [_signal_outlet(0), _signal_outlet(1)], "_audit": {"confidence": "HIGH", "instances": 5, "agreement": 1.0, "source": "outlet_type_finding"}},
                "existing_manual": {"outlets": [_signal_outlet(0), _control_outlet(1)]},
                "reason": "CONFLICT_WITH_MANUAL",
            },
        }
        proposed = _make_proposed(conflicts=conflicts)
        existing = _make_existing(objects={"stash~": {"outlets": [_signal_outlet(0), _control_outlet(1)]}})
        merger, _, _ = tmp_merger(proposed, existing)

        # No resolutions => conflicts not merged, but existing manual entry preserved
        merged = merger.merge(conflict_resolutions=None)
        obj_keys = [k for k in merged["objects"] if not k.startswith("_")]
        # stash~ should still appear (from existing manual), unmodified
        assert "stash~" in obj_keys


class TestManualOriginalPreserved:
    """test_manual_original_preserved: Resolved conflicts include _manual_original
    field containing deep copy of original manual entry."""

    def test_manual_original_field_on_resolved_conflict(self, tmp_merger):
        manual_entry = {
            "outlets": [
                {"id": 0, "type": "signal", "signal": True, "digest": "Signal output"},
                {"id": 1, "type": "", "signal": False, "digest": "bang when curve reaches destination"},
            ],
            "_note": "Outlet 0 is signal, outlet 1 is control bang.",
        }
        audit_entry = {
            "inlets": [_inlet(0), _inlet(1), _inlet(2)],
            "outlets": [_control_outlet(0), _control_outlet(1)],
            "_audit": {"confidence": "HIGH", "instances": 10, "agreement": 0.9, "source": "io_count_finding"},
        }
        conflicts = {
            "curve~": {
                "audit_proposed": audit_entry,
                "existing_manual": manual_entry,
                "reason": "CONFLICT_WITH_MANUAL",
            },
        }
        proposed = _make_proposed(conflicts=conflicts)
        existing = _make_existing(objects={"curve~": manual_entry})
        merger, _, _ = tmp_merger(proposed, existing)

        resolutions = {"curve~": {"adopt_fields": ["inlets"]}}
        merged = merger.merge(conflict_resolutions=resolutions)

        curve = merged["objects"]["curve~"]
        assert "_manual_original" in curve
        assert curve["_manual_original"]["outlets"][1]["digest"] == "bang when curve reaches destination"
        # Verify it's a deep copy -- modifying original does NOT affect _manual_original
        original_copy = curve["_manual_original"]
        assert original_copy is not manual_entry


class TestIdempotent:
    """test_idempotent: Running merge() twice with same inputs produces
    identical output."""

    def test_merge_idempotent(self, tmp_merger):
        objects = {
            "adsr~": _make_audit_entry(outlets=[_signal_outlet(0), _control_outlet(1)]),
            "allpass~": _make_audit_entry(outlets=[_signal_outlet(0)]),
        }
        proposed = _make_proposed(objects=objects)
        existing = _make_existing()
        merger, _, _ = tmp_merger(proposed, existing)

        merged1 = merger.merge()
        merged2 = merger.merge()

        assert json.dumps(merged1, sort_keys=True) == json.dumps(merged2, sort_keys=True)


class TestNonObjectSectionsPreserved:
    """test_non_object_sections_preserved: version_map and variable_io_rules
    are preserved exactly in merged output."""

    def test_version_map_preserved(self, tmp_merger):
        version_map = {"9": {"prefixes": ["array.", "string."], "exact": ["step"]}, "8.1": {"prefixes": ["mc."]}}
        existing = _make_existing(version_map=version_map)
        proposed = _make_proposed(objects={"adsr~": _make_audit_entry(outlets=[_signal_outlet(0)])})
        merger, _, _ = tmp_merger(proposed, existing)

        merged = merger.merge()
        assert merged["version_map"] == version_map

    def test_variable_io_rules_preserved(self, tmp_merger):
        vio_rules = {"pack": {"inlet_count": "arg_count", "outlet_count": "fixed:1"}, "trigger": {"inlet_count": "fixed:1", "outlet_count": "arg_count"}}
        existing = _make_existing(variable_io_rules=vio_rules)
        proposed = _make_proposed(objects={"adsr~": _make_audit_entry(outlets=[_signal_outlet(0)])})
        merger, _, _ = tmp_merger(proposed, existing)

        merged = merger.merge()
        assert merged["variable_io_rules"] == vio_rules


class TestExistingManualEntriesPreserved:
    """test_existing_manual_entries_preserved: All existing manual override
    entries for non-conflict objects remain exactly as-is."""

    def test_non_conflict_manual_entries_unchanged(self, tmp_merger):
        manual_entry = {
            "inlets": [
                {"id": 0, "type": "anything", "signal": False, "digest": "Messages and data", "hot": True},
            ],
            "_note": "Expert verified",
        }
        existing = _make_existing(objects={"buffer~": manual_entry})
        proposed = _make_proposed(objects={"adsr~": _make_audit_entry(outlets=[_signal_outlet(0)])})
        merger, _, _ = tmp_merger(proposed, existing)

        merged = merger.merge()
        obj_keys = [k for k in merged["objects"] if not k.startswith("_")]
        assert "buffer~" in obj_keys
        buffer_entry = merged["objects"]["buffer~"]
        assert buffer_entry["inlets"] == manual_entry["inlets"]
        assert buffer_entry["_note"] == "Expert verified"

    def test_real_overrides_manual_entries_preserved(self, db, tmp_path):
        """Test against the real overrides.json to verify all 23 manual entries survive."""
        if not REAL_OVERRIDES_PATH.exists():
            pytest.skip("Real overrides.json not found")

        real_existing = json.loads(REAL_OVERRIDES_PATH.read_text())
        existing_obj_names = {
            k for k in real_existing.get("objects", {}).keys()
            if not k.startswith("_")
        }

        # Create a proposed file with no conflicts touching existing entries
        proposed = _make_proposed(objects={
            "newobj1": _make_audit_entry(outlets=[_control_outlet(0)]),
            "newobj2": _make_audit_entry(outlets=[_signal_outlet(0)]),
        })
        proposed_path = tmp_path / "proposed-overrides.json"
        overrides_path = tmp_path / "overrides.json"
        proposed_path.write_text(json.dumps(proposed, indent=2) + "\n")
        overrides_path.write_text(json.dumps(real_existing, indent=2) + "\n")

        merger = OverrideMerger(proposed_path, overrides_path, db)
        merged = merger.merge()

        # All original entries must still exist
        merged_obj_names = {k for k in merged["objects"] if not k.startswith("_")}
        for name in existing_obj_names:
            assert name in merged_obj_names, f"Manual entry '{name}' lost during merge"


class TestOrphanObjectsFlagged:
    """Objects not in any domain JSON are skipped and reported, never written
    with an inactive ``_note`` (the Q11 loader rejects such a key; CR-02)."""

    def test_orphan_is_skipped_not_noted(self, tmp_merger):
        # Use an object name known not to be in any domain JSON
        objects = {
            "fake_nonexistent_obj_xyz": _make_audit_entry(
                outlets=[_control_outlet(0)],
                confidence="HIGH",
                instances=1,
                agreement=1.0,
            ),
        }
        proposed = _make_proposed(objects=objects)
        existing = _make_existing()
        merger, _, _ = tmp_merger(proposed, existing)

        merged = merger.merge()
        assert "fake_nonexistent_obj_xyz" not in merged["objects"]
        assert merger.skipped == {"fake_nonexistent_obj_xyz": "NO_BASE_ENTRY"}


class TestAuditMetadataOnEveryEntry:
    """test_audit_metadata_on_every_entry: Every merged audit entry has _audit
    dict with confidence, instances, agreement, source fields."""

    def test_audit_metadata_fields(self, tmp_merger):
        objects = {
            "adsr~": _make_audit_entry(outlets=[_signal_outlet(0)], confidence="HIGH", instances=15, agreement=0.97, source="outlet_type_finding"),
            "allpass~": _make_audit_entry(outlets=[_signal_outlet(0)], confidence="MEDIUM", instances=5, agreement=0.80, source="io_count_finding"),
            "adc~": _make_audit_entry(inlets=[_inlet(0)], confidence="HELP_PATCH", instances=2, agreement=1.0, source="empty_io_coverage"),
        }
        proposed = _make_proposed(objects=objects)
        existing = _make_existing()
        merger, _, _ = tmp_merger(proposed, existing)

        merged = merger.merge()
        for name in objects:
            obj = merged["objects"][name]
            assert "_audit" in obj, f"{name} missing _audit metadata"
            audit = obj["_audit"]
            assert "confidence" in audit
            assert "instances" in audit
            assert "agreement" in audit
            assert "source" in audit


class TestDomainOrdering:
    """test_domain_ordering: Domains appear in order: max, msp, jitter, mc,
    gen, m4l, rnbo, packages, other."""

    def test_domain_header_order(self, tmp_merger):
        # Create objects from multiple domains
        objects = {
            "adsr~": _make_audit_entry(outlets=[_signal_outlet(0)]),  # msp
            "counter": _make_audit_entry(outlets=[_control_outlet(0)]),  # max
            "jit.gl.mesh": _make_audit_entry(outlets=[_control_outlet(0)]),  # jitter
            "fake_unknown_xyz": _make_audit_entry(outlets=[_control_outlet(0)]),  # other (orphan)
        }
        proposed = _make_proposed(objects=objects)
        existing = _make_existing()
        merger, _, _ = tmp_merger(proposed, existing)

        merged = merger.merge()
        header_keys = [k for k in merged["objects"] if k.startswith("_domain_")]

        # Extract domain names from header keys
        domains_in_order = [k.replace("_domain_", "") for k in header_keys]

        # Verify relative ordering: max before msp, msp before jitter, jitter before other
        expected_order = ["max", "msp", "jitter", "mc", "gen", "m4l", "rnbo", "packages", "other"]
        # Only check domains that are actually present
        filtered_expected = [d for d in expected_order if d in domains_in_order]
        filtered_actual = [d for d in domains_in_order if d in filtered_expected]
        assert filtered_actual == filtered_expected, f"Domain order wrong: {filtered_actual} vs {filtered_expected}"


class TestWrite:
    """Test that write() produces valid JSON with correct formatting."""

    def test_write_produces_valid_json(self, tmp_merger):
        proposed = _make_proposed(objects={"adsr~": _make_audit_entry(outlets=[_signal_outlet(0)])})
        existing = _make_existing()
        merger, _, overrides_path = tmp_merger(proposed, existing)

        merged = merger.merge()
        merger.write(merged)

        written = json.loads(overrides_path.read_text())
        assert "objects" in written
        assert "version_map" in written

    def test_write_has_trailing_newline(self, tmp_merger):
        proposed = _make_proposed(objects={"adsr~": _make_audit_entry(outlets=[_signal_outlet(0)])})
        existing = _make_existing()
        merger, _, overrides_path = tmp_merger(proposed, existing)

        merged = merger.merge()
        merger.write(merged)

        content = overrides_path.read_text()
        assert content.endswith("\n")

    def test_write_indent_2(self, tmp_merger):
        proposed = _make_proposed(objects={"adsr~": _make_audit_entry(outlets=[_signal_outlet(0)])})
        existing = _make_existing()
        merger, _, overrides_path = tmp_merger(proposed, existing)

        merged = merger.merge()
        merger.write(merged)

        content = overrides_path.read_text()
        # Check that indent is 2 spaces (not 4)
        assert '  "objects"' in content or '  "_comment"' in content


class TestCLIMergeFlag:
    """test_cli_merge_flag: Verify that argparse accepts --merge and that
    the merge code path is exercised."""

    def test_merge_flag_with_proposed_file(self, tmp_path, db):
        """--merge with a valid proposed-overrides.json runs the merge code path."""
        from src.maxpat.audit.cli import main

        # Create proposed-overrides.json in the output dir
        proposed = _make_proposed(objects={
            "adsr~": _make_audit_entry(outlets=[_signal_outlet(0)]),
        })
        output_dir = tmp_path / "audit"
        output_dir.mkdir()
        (output_dir / "proposed-overrides.json").write_text(
            json.dumps(proposed, indent=2) + "\n"
        )

        # Also need overrides.json at the expected location -- use the real one
        # We test with --dry-run to avoid modifying real files
        result = main([
            "--merge",
            "--output-dir", str(output_dir),
            "--dry-run",
        ])
        assert result == 0

    def test_merge_flag_missing_proposed_returns_1(self, tmp_path):
        """--merge returns 1 when proposed-overrides.json is missing."""
        from src.maxpat.audit.cli import main

        result = main([
            "--merge",
            "--output-dir", str(tmp_path),
            "--dry-run",
        ])
        assert result == 1

    def test_merge_flag_does_not_require_help_dir(self, tmp_path, db):
        """--merge skips help-dir validation (independent code path)."""
        from src.maxpat.audit.cli import main

        proposed = _make_proposed(objects={
            "adsr~": _make_audit_entry(outlets=[_signal_outlet(0)]),
        })
        output_dir = tmp_path / "audit"
        output_dir.mkdir()
        (output_dir / "proposed-overrides.json").write_text(
            json.dumps(proposed, indent=2) + "\n"
        )

        # Use a non-existent --help-dir but it shouldn't matter for --merge
        result = main([
            "--merge",
            "--help-dir", "/nonexistent/path",
            "--output-dir", str(output_dir),
            "--dry-run",
        ])
        assert result == 0


# ---- Q11 load safety (quick 261022-ud6 WP1, review-validation CR-02) ----


def _db_copy(tmp_path: Path) -> Path:
    """A scratch copy of the real DB root (domain files, aliases, overrides)."""
    import shutil

    src = REAL_OVERRIDES_PATH.parent
    dst = tmp_path / "max-objects"
    shutil.copytree(src, dst, ignore=shutil.ignore_patterns("audit", "_pkg-source"))
    return dst


class TestMergeKeepsDatabaseLoading:
    """CR-02: a merge must never write an entry ObjectDatabase() rejects.

    Since Q11, ``ObjectDatabase._apply_object_overrides`` raises on an
    objects key with no base domain entry and on two keys that resolve to the
    same canonical name through aliases.json.
    """

    def test_unknown_object_is_skipped_and_reported(self, tmp_merger):
        proposed = _make_proposed(objects={
            "notarealobject~": _make_audit_entry(inlets=[_inlet(0)]),
            "adsr~": _make_audit_entry(outlets=[_signal_outlet(0)]),
        })
        merger, _, _ = tmp_merger(proposed, _make_existing())
        merged = merger.merge()
        assert "notarealobject~" not in merged["objects"]
        assert "adsr~" in merged["objects"]
        assert merger.skipped["notarealobject~"] == "NO_BASE_ENTRY"

    def test_alias_proposal_is_keyed_by_canonical_name(self, tmp_merger):
        proposed = _make_proposed(objects={
            "t": _make_audit_entry(outlets=[_control_outlet(0)]),
        })
        merger, _, _ = tmp_merger(proposed, _make_existing())
        merged = merger.merge()
        assert "t" not in merged["objects"]
        assert "trigger" in merged["objects"]

    def test_alias_and_canonical_proposals_collapse_to_one_key(self, tmp_merger):
        proposed = _make_proposed(objects={
            "t": _make_audit_entry(outlets=[_control_outlet(0)], instances=3),
            "trigger": _make_audit_entry(outlets=[_control_outlet(0)], instances=7),
        })
        merger, _, _ = tmp_merger(proposed, _make_existing())
        merged = merger.merge()
        assert "t" not in merged["objects"]
        assert merged["objects"]["trigger"]["_audit"]["instances"] == 7
        assert merger.skipped["t"] == "DUPLICATE_OF trigger"

    def test_merge_run_keeps_object_database_loading(self, tmp_path):
        root = _db_copy(tmp_path)
        db = ObjectDatabase(root)
        proposed = _make_proposed(objects={
            "notarealobject~": _make_audit_entry(inlets=[_inlet(0)]),
            "t": _make_audit_entry(outlets=[_control_outlet(0)]),
            "trigger": _make_audit_entry(outlets=[_control_outlet(0)]),
            "sel": _make_audit_entry(outlets=[_control_outlet(0)]),
        })
        prop_path = tmp_path / "proposed-overrides.json"
        prop_path.write_text(json.dumps(proposed, indent=2) + "\n")
        merger = OverrideMerger(prop_path, root / "overrides.json", db)
        merger.write(merger.merge())
        ObjectDatabase(root)  # must not raise

    def test_write_refuses_a_dict_the_loader_rejects(self, tmp_path):
        from src.maxpat.audit.merger import OverridesLoadError

        root = _db_copy(tmp_path)
        db = ObjectDatabase(root)
        prop_path = tmp_path / "proposed-overrides.json"
        prop_path.write_text(json.dumps(_make_proposed(), indent=2) + "\n")
        overrides = root / "overrides.json"
        before = overrides.read_bytes()
        merger = OverrideMerger(prop_path, overrides, db)
        merged = merger.merge()
        merged["objects"]["notarealobject~"] = {"inlets": [_inlet(0)]}
        with pytest.raises(OverridesLoadError, match="notarealobject~"):
            merger.write(merged)
        assert overrides.read_bytes() == before

    def test_cli_merge_reports_rejected_write(self, tmp_path, monkeypatch, capsys):
        """--merge returns 1 (nothing written) when the rehearsal load fails."""
        from src.maxpat.audit import cli, merger as merger_mod

        root = _db_copy(tmp_path)
        output_dir = tmp_path / "audit"
        output_dir.mkdir()
        (output_dir / "proposed-overrides.json").write_text(
            json.dumps(_make_proposed(), indent=2) + "\n"
        )
        overrides = root / "overrides.json"
        before = overrides.read_bytes()

        real_merge = merger_mod.OverrideMerger.merge

        def bad_merge(self, conflict_resolutions=None):
            merged = real_merge(self, conflict_resolutions)
            merged["objects"]["notarealobject~"] = {"inlets": [_inlet(0)]}
            return merged

        monkeypatch.setattr(merger_mod.OverrideMerger, "merge", bad_merge)
        rc = cli.main([
            "--merge", "--output-dir", str(output_dir),
            "--overrides", str(overrides),
        ])
        assert rc == 1
        assert "notarealobject~" in capsys.readouterr().err
        assert overrides.read_bytes() == before
