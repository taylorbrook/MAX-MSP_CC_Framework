"""quick-260921-knq: smoke tests for tools/audit_db.py (NH-01).

The audit harness answers "is the object DB still true against the installed
Max?". These tests must stay green on a machine with NO Max installed, so
every assertion runs against either:

  * a fake ``Max.app`` built in ``tmp_path`` (a real Info.plist written with
    :func:`plistlib.dump` plus two hand-rolled ``.maxref.xml`` fixtures), or
  * the deliberately-degraded path (``--max-app`` pointing at nothing).

Nothing here asserts on the real ``/Applications/Max.app``, on real object
counts, or on real patch counts -- those move with the install and would make
the suite machine-dependent.

Fixture requirement discovered while writing these tests: ``ObjectDatabase``
loads happily from a minimal ``db_root`` containing only
``max/objects.json``. ``aliases.json``, ``overrides.json``,
``pd-blocklist.json`` and ``package_info.json`` are each guarded by an
``exists()`` check in ``ObjectDatabase._load``, so no empty stubs are needed.

House convention (tests/test_audit_signal_role.py): import the tool as a
module and drive its top-level callables directly; reach for ``subprocess``
only where the CLI surface itself is under test.
"""

from __future__ import annotations

import hashlib
import json
import plistlib
import subprocess
import sys
from pathlib import Path

import pytest

import tools.audit_db as audit_db  # noqa: E402

REPO_ROOT = Path(__file__).resolve().parent.parent


# ── Fixture builders ──────────────────────────────────────────────


_BITAND_XML = """<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<c74object name="&amp;" module="max" category="Math">
  <digest>Bitwise intersection</digest>
  <inletlist><inlet id="0" type="int"/><inlet id="1" type="int"/></inletlist>
  <outletlist><outlet id="0" type="int"/></outletlist>
</c74object>
"""

# No `name` attribute at all -> the filename stem (minus .maxref) must win.
_NONAME_XML = """<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<c74object module="max" category="Math">
  <digest>Object documented without a name attribute</digest>
  <inletlist><inlet id="0" type="bang"/></inletlist>
  <outletlist><outlet id="0" type="bang"/></outletlist>
</c74object>
"""


def _make_fake_bundle(tmp_path: Path, short_version: str = "9.9.9") -> Path:
    """Build a minimal but structurally real Max.app under tmp_path."""
    app = tmp_path / "Max.app"
    contents = app / "Contents"
    contents.mkdir(parents=True)
    with open(contents / "Info.plist", "wb") as fh:
        plistlib.dump(
            {
                "CFBundleShortVersionString": short_version,
                "CFBundleVersion": short_version,
                "CFBundleName": "Max",
            },
            fh,
        )
    refpages = contents / "Resources" / "C74" / "docs" / "refpages" / "max-ref"
    refpages.mkdir(parents=True)
    (refpages / "bitand.maxref.xml").write_text(_BITAND_XML)
    (refpages / "noname.maxref.xml").write_text(_NONAME_XML)
    return app


_TINY_PATCH = {
    "patcher": {
        "boxes": [
            {"box": {"maxclass": "newobj", "text": "cycle~ 440", "id": "obj-1"}},
            {"box": {"maxclass": "toggle", "id": "obj-2"}},
            {
                "box": {
                    "maxclass": "newobj",
                    "text": "p inner",
                    "id": "obj-3",
                    "patcher": {
                        "boxes": [
                            {"box": {"maxclass": "newobj", "text": "dac~", "id": "obj-4"}}
                        ]
                    },
                }
            },
        ]
    }
}


def _make_fake_repo(tmp_path: Path) -> Path:
    """Build a fake repo root with a minimal object DB and one tiny .maxpat."""
    root = tmp_path / "repo"
    db_domain = root / ".claude" / "max-objects" / "max"
    db_domain.mkdir(parents=True)
    (db_domain / "objects.json").write_text(
        json.dumps(
            {
                "cycle~": {
                    "name": "cycle~",
                    "inlets": [{"id": 0, "type": "signal"}],
                    "outlets": [{"id": 0, "type": "signal"}],
                },
                "dac~": {
                    "name": "dac~",
                    "inlets": [{"id": 0, "type": "signal"}],
                    "outlets": [],
                },
            }
        )
    )
    (db_domain.parent / "extraction-log.json").write_text(
        json.dumps(
            {
                "extraction_timestamp": "2026-01-01T00:00:00+00:00",
                "domain_counts": {"max": 2},
            }
        )
    )
    patches = root / "patches"
    patches.mkdir(parents=True)
    (patches / "tiny.maxpat").write_text(json.dumps(_TINY_PATCH))
    return root


def _snapshot(root: Path) -> dict[str, tuple[int, str]]:
    """Map every file under root to (size, sha256) for byte-level comparison."""
    snap: dict[str, tuple[int, str]] = {}
    for path in sorted(root.rglob("*")):
        if path.is_file():
            data = path.read_bytes()
            rel = str(path.relative_to(root))
            snap[rel] = (len(data), hashlib.sha256(data).hexdigest())
    return snap


# ── install section / version parsing ─────────────────────────────


class TestInstallSection:
    def test_fake_bundle_version_is_reported(self, tmp_path: Path) -> None:
        app = _make_fake_bundle(tmp_path)
        section = audit_db.audit_install(app)
        assert section["available"] is True
        assert section["short_version"] == "9.9.9"
        assert section["app_path"] == str(app)
        assert len(section["refpage_roots"]) == 1

    def test_missing_bundle_degrades_without_raising(self, tmp_path: Path) -> None:
        section = audit_db.audit_install(tmp_path / "absent.app")
        assert section["available"] is False
        assert "Info.plist" in section["reason"]

    def test_malformed_plist_degrades(self, tmp_path: Path) -> None:
        app = tmp_path / "Broken.app"
        (app / "Contents").mkdir(parents=True)
        (app / "Contents" / "Info.plist").write_bytes(b"this is not a plist")
        section = audit_db.audit_install(app)
        assert section["available"] is False
        assert section["reason"]

    def test_build_id_is_split_out_of_short_version_string(self) -> None:
        """Max 9.1.5 ships the build hash inside CFBundleShortVersionString."""
        assert audit_db._split_short_version("9.1.5 (3db35fa476d)") == (
            "9.1.5",
            "3db35fa476d",
        )
        assert audit_db._split_short_version("9.9.9") == ("9.9.9", None)
        assert audit_db._split_short_version(None) == (None, None)
        assert audit_db._split_short_version("") == (None, None)


# ── refpage index: SF-07 name-attribute keying ────────────────────


class TestRefpageIndex:
    def test_name_attribute_wins_over_filename(self, tmp_path: Path) -> None:
        """SF-07 regression guard: filename keying manufactured ~795 phantom gaps."""
        app = _make_fake_bundle(tmp_path)
        index = audit_db.build_refpage_index(audit_db.audit_install(app))
        assert index["available"] is True
        assert "&" in index["objects"]
        assert "bitand" not in index["objects"]
        assert index["objects"]["&"]["filename_stem"] == "bitand"

    def test_filename_stem_is_the_fallback_when_no_name_attribute(
        self, tmp_path: Path
    ) -> None:
        app = _make_fake_bundle(tmp_path)
        index = audit_db.build_refpage_index(audit_db.audit_install(app))
        assert "noname" in index["objects"]
        assert not str(index["objects"]["noname"]["filename_stem"]).endswith(".maxref")

    def test_self_check_counter_counts_only_real_disagreements(
        self, tmp_path: Path
    ) -> None:
        app = _make_fake_bundle(tmp_path)
        index = audit_db.build_refpage_index(audit_db.audit_install(app))
        # "&" disagrees with bitand; "noname" agrees with its stem.
        assert index["name_vs_filename_differs"] == 1
        assert index["files_scanned"] == 2

    def test_declared_io_counts_are_recorded(self, tmp_path: Path) -> None:
        app = _make_fake_bundle(tmp_path)
        index = audit_db.build_refpage_index(audit_db.audit_install(app))
        assert index["objects"]["&"]["inlets"] == 2
        assert index["objects"]["&"]["outlets"] == 1

    def test_malformed_xml_is_tallied_not_fatal(self, tmp_path: Path) -> None:
        app = _make_fake_bundle(tmp_path)
        refpages = app / "Contents" / "Resources" / "C74" / "docs" / "refpages" / "max-ref"
        (refpages / "broken.maxref.xml").write_text("<c74object name='x'>unclosed")
        index = audit_db.build_refpage_index(audit_db.audit_install(app))
        assert index["available"] is True
        assert len(index["parse_errors"]) == 1
        assert "&" in index["objects"]  # the healthy files still indexed

    def test_unavailable_bundle_yields_unavailable_index(self, tmp_path: Path) -> None:
        index = audit_db.build_refpage_index(
            audit_db.audit_install(tmp_path / "absent.app")
        )
        assert index["available"] is False
        assert index["objects"] == {}


# ── package layouts, define aliases, filename-keying figures ──────
# (quick-261001-hwb follow-ups DEF-hwb-11 and DEF-hwb-25)


def _object_xml(name: str) -> str:
    return (
        '<?xml version="1.0" encoding="utf-8" standalone="yes"?>\n'
        f'<c74object name="{name}" module="max" category="Test">\n'
        "  <digest>fixture</digest>\n"
        '  <inletlist><inlet id="0" type="bang"/></inletlist>\n'
        '  <outletlist><outlet id="0" type="bang"/></outletlist>\n'
        "</c74object>\n"
    )


def _add_packages(app: Path) -> Path:
    """Add bundled packages in every refpage layout the real bundle uses."""
    c74 = app / "Contents" / "Resources" / "C74"
    pkgs = c74 / "packages"
    flat = pkgs / "Flat Pack" / "docs"  # ableton-dsp / Jitter Tools layout
    (flat / "group").mkdir(parents=True)
    (flat / "flat.obj.maxref.xml").write_text(_object_xml("flat.obj"))
    (flat / "group" / "nested.obj.maxref.xml").write_text(_object_xml("nested.obj"))
    # An alias document: the stem is a `max define` alias, the name attribute
    # is the implementing class.
    (flat / "pack.alias.maxref.xml").write_text(_object_xml("impl"))
    init = pkgs / "Flat Pack" / "init"
    init.mkdir(parents=True)
    (init / "flat-objectmappings.txt").write_text(
        "max define pack.alias impl script.js;\n"
        "max define bare.alias cycle~ @x 1;\n"
    )
    classic = pkgs / "Classic Pack" / "docs" / "refpages"  # VIDDLL layout
    classic.mkdir(parents=True)
    (classic / "classic.obj.maxref.xml").write_text(_object_xml("classic.obj"))
    gen = pkgs / "Gen" / "docs"  # skipped by the sync walk; docs/refpages only
    (gen / "refpages" / "dsp").mkdir(parents=True)
    (gen / "refpages1").mkdir(parents=True)
    (gen / "refpages" / "dsp" / "gen_dsp_thing.maxref.xml").write_text(_object_xml("thing"))
    (gen / "refpages1" / "old.maxref.xml").write_text(_object_xml("old"))
    (pkgs / "No Refpages" / "docs").mkdir(parents=True)  # docs/ without refpages
    return c74


class TestPackageRefpageDiscovery:
    def test_flat_and_nested_package_docs_are_indexed(self, tmp_path: Path) -> None:
        app = _make_fake_bundle(tmp_path)
        _add_packages(app)
        index = audit_db.build_refpage_index(audit_db.audit_install(app))
        for name in ("flat.obj", "nested.obj", "classic.obj", "thing"):
            assert name in index["objects"], name

    def test_roots_come_from_the_sync_tools_walk(self, tmp_path: Path) -> None:
        import tools.sync_max_bundle as sync

        app = _make_fake_bundle(tmp_path)
        c74 = _add_packages(app)
        roots = set(audit_db.audit_install(app)["refpage_roots"])
        walked = {str(docs) for docs, _pkg in sync.package_docs_dirs(c74)}
        # Every docs/ directory the sync tool walks is an audit root, unless it
        # holds no refpage at all.
        assert walked - roots == {str(c74 / "packages" / "No Refpages" / "docs")}
        # Gen is skipped by that walk and keeps its docs/refpages root only.
        assert str(c74 / "packages" / "Gen" / "docs" / "refpages") in roots
        assert str(c74 / "packages" / "Gen" / "docs") not in roots
        assert len(roots) == 4

    def test_no_file_is_scanned_twice(self, tmp_path: Path) -> None:
        app = _make_fake_bundle(tmp_path)
        _add_packages(app)
        index = audit_db.build_refpage_index(audit_db.audit_install(app))
        # 2 core + 3 flat + 1 classic + 1 gen (refpages1/ is outside every root).
        assert index["files_scanned"] == 7
        assert "old" not in index["objects"]

    def test_alias_document_is_indexed_under_the_define_alias(self, tmp_path: Path) -> None:
        app = _make_fake_bundle(tmp_path)
        _add_packages(app)
        index = audit_db.build_refpage_index(audit_db.audit_install(app))
        assert "pack.alias" in index["objects"]
        assert "impl" not in index["objects"]
        assert [d["alias"] for d in index["alias_documents"]] == ["pack.alias"]
        assert index["alias_documents"][0]["name_attribute"] == "impl"
        # The raw disagreement is still counted: "&", the alias document and
        # Gen's prefix-keyed file.
        assert index["name_vs_filename_differs"] == 3
        assert index["define_alias_count"] == 2


def _fake_db(tmp_path: Path, names: list[str]) -> Path:
    root = _make_fake_repo(tmp_path)
    db_root = root / ".claude" / "max-objects"
    port = [{"id": 0, "type": "bang"}]
    (db_root / "max" / "objects.json").write_text(
        json.dumps({n: {"name": n, "inlets": port, "outlets": port} for n in names})
    )
    return db_root


class TestDefineAliases:
    def test_define_alias_without_refpage_is_not_counted_absent(self, tmp_path: Path) -> None:
        app = _make_fake_bundle(tmp_path)
        _add_packages(app)
        db_root = _fake_db(tmp_path, ["bare.alias", "pack.alias", "ghost"])
        index = audit_db.build_refpage_index(audit_db.audit_install(app))
        section = audit_db.audit_absent_from_bundle(db_root, index)
        # `ghost` has no refpage and no mapping line: a real finding.
        assert section["names"] == ["ghost"]
        assert section["count"] == 1
        # `bare.alias` has no refpage by design; `pack.alias` has an alias
        # document and so is not absent at all.
        assert section["define_mapped"] == [{"name": "bare.alias", "target": "cycle~"}]
        assert section["define_mapped_count"] == 1

    def test_summary_names_the_define_mapped_count(self, tmp_path: Path) -> None:
        app = _make_fake_bundle(tmp_path)
        _add_packages(app)
        db_root = _fake_db(tmp_path, ["bare.alias", "ghost"])
        report = audit_db.run_audit(
            repo_root=db_root.parent.parent, db_root=db_root, max_app=app
        )
        line = next(
            ln for ln in audit_db.format_summary(report).splitlines() if "absent from Max" in ln
        )
        assert "1 DB names with no refpage" in line
        assert "+1 define-mapped" in line


class TestFilenameKeyingFigures:
    def test_phantom_gaps_are_stems_whose_indexed_name_resolves(self, tmp_path: Path) -> None:
        from src.maxpat.db_lookup import ObjectDatabase

        app = _make_fake_bundle(tmp_path)
        db_root = _fake_db(tmp_path, ["&"])
        index = audit_db.build_refpage_index(audit_db.audit_install(app))
        section = audit_db.audit_missing_from_db(index, ObjectDatabase(db_root=db_root))
        # Keyed by name attribute: only `noname` is unresolved.
        assert section["names"] == ["noname"]
        keyed = section["filename_keyed"]
        assert keyed["stems_checked"] == 2
        # Keyed by filename: `bitand` and `noname` both fail ...
        assert keyed["unresolved_count"] == 2
        # ... but only `bitand` is manufactured by the keying.
        assert keyed["phantom_count"] == 1
        assert keyed["phantom_stems"] == ["bitand"]

    def test_figures_reach_the_summary_and_the_json(self, tmp_path: Path) -> None:
        app = _make_fake_bundle(tmp_path)
        db_root = _fake_db(tmp_path, ["&"])
        report = audit_db.run_audit(
            repo_root=db_root.parent.parent, db_root=db_root, max_app=app
        )
        summary = audit_db.format_summary(report)
        assert "1 name!=filename" in summary
        assert "keyed by filename: 2 unresolved, 1 phantom" in summary
        meta = report["refpage_index"]
        assert meta["files_scanned"] == 2
        assert meta["filename_stems"] == 2
        # The bulky lookup tables stay out of the emitted document.
        assert not {"objects", "stems", "defines"} & set(meta)


# ── write guard (T-knq-01) ────────────────────────────────────────


class TestWriteGuard:
    @pytest.mark.parametrize(
        "relative",
        [
            "patches/out.json",
            "patches/nested/deep/out.json",
            "patches",
            ".claude/max-objects/out.json",
            ".claude/max-objects",
            "patches/../patches/sneaky.json",
        ],
    )
    def test_protected_trees_are_refused(self, tmp_path: Path, relative: str) -> None:
        root = _make_fake_repo(tmp_path)
        with pytest.raises(audit_db.OutputPathRejected):
            audit_db.guard_output_path(root / relative, root)

    def test_tmp_target_is_accepted(self, tmp_path: Path) -> None:
        root = _make_fake_repo(tmp_path)
        target = tmp_path / "out" / "report.json"
        assert audit_db.guard_output_path(target, root) == target.resolve()

    def test_sibling_directory_sharing_a_prefix_is_not_protected(
        self, tmp_path: Path
    ) -> None:
        """`patches-backup/` must not be caught by a naive prefix match."""
        root = _make_fake_repo(tmp_path)
        target = root / "patches-backup" / "out.json"
        assert audit_db.guard_output_path(target, root) == target.resolve()


# ── full envelope on the fake repo ────────────────────────────────


class TestEnvelope:
    def test_all_seven_sections_present_in_fully_degraded_run(
        self, tmp_path: Path
    ) -> None:
        root = _make_fake_repo(tmp_path)
        report = audit_db.run_audit(
            repo_root=root,
            db_root=root / ".claude" / "max-objects",
            max_app=tmp_path / "absent.app",
        )
        assert set(report["sections"]) == set(audit_db.SECTION_KEYS)
        for key in audit_db.SECTION_KEYS:
            assert "available" in report["sections"][key], key

    def test_db_sections_survive_an_unavailable_bundle(self, tmp_path: Path) -> None:
        root = _make_fake_repo(tmp_path)
        sections = audit_db.run_audit(
            repo_root=root,
            db_root=root / ".claude" / "max-objects",
            max_app=tmp_path / "absent.app",
        )["sections"]
        assert sections["install"]["available"] is False
        assert sections["missing_from_db"]["available"] is False
        # DB- and patch-derived sections still produce data.
        assert sections["db_age"]["available"] is True
        assert sections["db_age"]["age_days"] > 0
        assert sections["empty_io"]["available"] is True
        assert sections["patch_objects"]["available"] is True
        assert sections["patch_objects"]["files_scanned"] == 1
        assert sections["ui_maxclasses_gap"]["available"] is True

    def test_has_refpage_is_null_not_false_when_bundle_unknown(
        self, tmp_path: Path
    ) -> None:
        """An unreadable bundle is a measurement gap, not evidence of absence."""
        root = _make_fake_repo(tmp_path)
        db_root = root / ".claude" / "max-objects"
        # Give the DB an entry with a populated inlet side and empty outlets so
        # it lands in audit_half_empty_io()['sinks'].
        sections = audit_db.run_audit(
            repo_root=root, db_root=db_root, max_app=tmp_path / "absent.app"
        )["sections"]
        empty_io = sections["empty_io"]
        assert empty_io["refpage_coverage_known"] is False
        annotated = empty_io["critical"] + empty_io["sinks"] + empty_io["sources"]
        assert annotated, "fixture should produce at least one annotated entry"
        assert all(entry["has_refpage"] is None for entry in annotated)

    def test_fake_bundle_run_reports_its_version_and_resolves_refpages(
        self, tmp_path: Path
    ) -> None:
        root = _make_fake_repo(tmp_path)
        app = _make_fake_bundle(tmp_path)
        report = audit_db.run_audit(
            repo_root=root,
            db_root=root / ".claude" / "max-objects",
            max_app=app,
        )
        sections = report["sections"]
        assert sections["install"]["short_version"] == "9.9.9"
        assert report["refpage_index"]["object_count"] == 2
        # Neither fixture refpage name is in the 2-object fake DB.
        assert sections["missing_from_db"]["count"] == 2
        assert sections["missing_from_db"]["names"] == ["&", "noname"]
        # Conversely both DB names are absent from the fake bundle.
        assert sections["absent_from_bundle"]["count"] == 2
        assert "scope" in sections["absent_from_bundle"]

    def test_patch_walk_descends_into_nested_patchers(self, tmp_path: Path) -> None:
        root = _make_fake_repo(tmp_path)
        usage = audit_db.collect_patch_usage(root, patch_source="worktree")
        assert usage["available"] is True
        assert usage["enumeration"] == "filesystem"  # tmp_path is not a git repo
        assert usage["files_scanned"] == 1
        # dac~ lives inside the nested `p inner` patcher.
        assert set(usage["name_to_files"]) == {"cycle~", "toggle", "p", "dac~"}
        assert set(usage["maxclass_tally"]) == {"newobj", "toggle"}

    def test_ui_maxclasses_gap_is_empty_for_admitted_widgets(
        self, tmp_path: Path
    ) -> None:
        root = _make_fake_repo(tmp_path)
        usage = audit_db.collect_patch_usage(root, patch_source="worktree")
        gap = audit_db.audit_ui_maxclasses_gap(usage)
        # `toggle` is in UI_MAXCLASSES, `newobj` is a structural exemption.
        assert gap["gap"] == []
        assert gap["count"] == 0

    def test_unknown_objects_are_reported_unresolved(self, tmp_path: Path) -> None:
        root = _make_fake_repo(tmp_path)
        usage = audit_db.collect_patch_usage(root, patch_source="worktree")
        from src.maxpat.db_lookup import ObjectDatabase

        db = ObjectDatabase(db_root=root / ".claude" / "max-objects")
        section = audit_db.audit_patch_objects(usage, db)
        unresolved = {entry["name"] for entry in section["unresolved"]}
        # `p` and `toggle` are absent from the 2-object fake DB.
        assert unresolved == {"p", "toggle"}
        assert section["local_abstractions"] == []
        assert "limitations" in section

    def test_sibling_maxpat_is_classified_as_a_local_abstraction(
        self, tmp_path: Path
    ) -> None:
        """A newobj naming a sibling .maxpat is an abstraction, not an unknown object."""
        root = _make_fake_repo(tmp_path)
        patches = root / "patches"
        (patches / "my-abstraction.maxpat").write_text(json.dumps({"patcher": {"boxes": []}}))
        (patches / "host.maxpat").write_text(
            json.dumps(
                {
                    "patcher": {
                        "boxes": [
                            {"box": {"maxclass": "newobj", "text": "my-abstraction 1"}}
                        ]
                    }
                }
            )
        )
        usage = audit_db.collect_patch_usage(root, patch_source="worktree")
        from src.maxpat.db_lookup import ObjectDatabase

        db = ObjectDatabase(db_root=root / ".claude" / "max-objects")
        section = audit_db.audit_patch_objects(usage, db)
        abstractions = {entry["name"] for entry in section["local_abstractions"]}
        assert "my-abstraction" in abstractions
        assert "my-abstraction" not in {e["name"] for e in section["unresolved"]}

    def test_deep_nesting_is_capped_not_fatal(self, tmp_path: Path) -> None:
        """T-knq-03: malformed/adversarial nesting must not exhaust the stack."""
        depth = audit_db.MAX_PATCHER_DEPTH + 50
        innermost: dict = {"boxes": [{"box": {"maxclass": "newobj", "text": "deepest"}}]}
        node = innermost
        for _ in range(depth):
            node = {
                "boxes": [{"box": {"maxclass": "newobj", "text": "p x", "patcher": node}}]
            }
        root = _make_fake_repo(tmp_path)
        (root / "patches" / "deep.maxpat").write_text(json.dumps({"patcher": node}))
        usage = audit_db.collect_patch_usage(root, patch_source="worktree")
        assert usage["available"] is True
        assert "deepest" not in usage["name_to_files"]  # never reached past the cap

    def test_malformed_maxpat_is_tallied_not_fatal(self, tmp_path: Path) -> None:
        root = _make_fake_repo(tmp_path)
        (root / "patches" / "broken.maxpat").write_text("{not json")
        usage = audit_db.collect_patch_usage(root, patch_source="worktree")
        assert usage["available"] is True
        assert usage["files_scanned"] == 1  # the healthy one
        assert len(usage["read_errors"]) == 1


# ── the read-only contract, proven byte-for-byte ──────────────────


class TestNoWrites:
    def test_audit_leaves_protected_trees_byte_identical(self, tmp_path: Path) -> None:
        root = _make_fake_repo(tmp_path)
        db_tree = root / ".claude" / "max-objects"
        patch_tree = root / "patches"
        before_db = _snapshot(db_tree)
        before_patches = _snapshot(patch_tree)
        assert before_db and before_patches, "fixture must contain files to compare"

        out = tmp_path / "report.json"
        exit_code = audit_db.main(
            [
                "--repo-root",
                str(root),
                "--db-root",
                str(db_tree),
                "--max-app",
                str(_make_fake_bundle(tmp_path)),
                "--json",
                str(out),
            ]
        )

        assert exit_code == 0
        assert out.exists(), "the --json target is the one legitimate write"
        assert _snapshot(db_tree) == before_db
        assert _snapshot(patch_tree) == before_patches
        # No new paths appeared under either tree.
        assert set(_snapshot(db_tree)) == set(before_db)
        assert set(_snapshot(patch_tree)) == set(before_patches)

    def test_emitted_json_carries_all_seven_sections(self, tmp_path: Path) -> None:
        root = _make_fake_repo(tmp_path)
        out = tmp_path / "report.json"
        audit_db.main(
            [
                "--repo-root",
                str(root),
                "--db-root",
                str(root / ".claude" / "max-objects"),
                "--max-app",
                str(tmp_path / "absent.app"),
                "--json",
                str(out),
            ]
        )
        report = json.loads(out.read_text())
        assert set(report["sections"]) == {
            "install",
            "db_age",
            "missing_from_db",
            "absent_from_bundle",
            "empty_io",
            "patch_objects",
            "ui_maxclasses_gap",
        }


# ── CLI surface ───────────────────────────────────────────────────


class TestCLI:
    def _run(self, *args: str) -> subprocess.CompletedProcess:
        return subprocess.run(
            [sys.executable, "tools/audit_db.py", *args],
            cwd=str(REPO_ROOT),
            capture_output=True,
            text=True,
            check=False,
        )

    def test_rejected_output_path_exits_nonzero_and_writes_nothing(
        self, tmp_path: Path
    ) -> None:
        root = _make_fake_repo(tmp_path)
        target = root / "patches" / "should-never-exist.json"
        result = self._run(
            "--repo-root", str(root),
            "--db-root", str(root / ".claude" / "max-objects"),
            "--max-app", str(tmp_path / "absent.app"),
            "--json", str(target),
        )
        assert result.returncode != 0
        assert not target.exists()
        assert "refusing to write" in result.stderr

    def test_missing_bundle_still_exits_zero(self, tmp_path: Path) -> None:
        """A missing Max install is a reported fact, not an error."""
        root = _make_fake_repo(tmp_path)
        result = self._run(
            "--repo-root", str(root),
            "--db-root", str(root / ".claude" / "max-objects"),
            "--max-app", str(tmp_path / "absent.app"),
        )
        assert result.returncode == 0, result.stderr
        assert "unavailable" in result.stdout

    def test_summary_is_printed_without_json_flag(self, tmp_path: Path) -> None:
        root = _make_fake_repo(tmp_path)
        app = _make_fake_bundle(tmp_path)
        result = self._run(
            "--repo-root", str(root),
            "--db-root", str(root / ".claude" / "max-objects"),
            "--max-app", str(app),
        )
        assert result.returncode == 0, result.stderr
        assert "Max 9.9.9" in result.stdout
        for label in ("db age", "missing from DB", "patch objects", "maxclass gap"):
            assert label in result.stdout
