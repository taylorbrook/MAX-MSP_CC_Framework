"""quick-261001-hwb: hermetic tests for tools/sync_max_bundle.py.

The sync tool reports and additively applies the difference between the
installed Max bundle and ``.claude/max-objects/``. These tests must stay green
on a machine with NO Max installed, so every assertion runs against:

  * a fake ``Max.app`` built in ``tmp_path`` (a real Info.plist written with
    :func:`plistlib.dump`, a handful of hand-rolled ``.maxref.xml`` files, a
    couple of ``.maxhelp`` patches and objectmappings lines), and
  * a fake object DB under ``tmp_path`` (never the repo's DB).

Nothing here asserts on the real ``/Applications/Max.app`` or on real object
counts. House convention (tests/test_audit_db.py): import the tool as a module
and drive its top-level callables directly.
"""

from __future__ import annotations

import hashlib
import json
import plistlib
from pathlib import Path

import pytest

import tools.sync_max_bundle as sync

# ── Fake bundle ───────────────────────────────────────────────────

_XML_HEAD = '<?xml version="1.0" encoding="utf-8" standalone="yes"?>\n'


def _refpage(
    name: str | None,
    *,
    module: str = "",
    digest: str = "A digest",
    description: str = "A description",
    inlets: list[tuple[str | None, str]] | None = None,
    outlets: list[tuple[str | None, str]] | None = None,
    methods: list[str] | None = None,
    attributes: list[str] | None = None,
) -> str:
    """Hand-rolled .maxref.xml. A list left as None omits that element entirely."""
    attrs = "" if name is None else f' name="{name}"'
    parts = [_XML_HEAD, f'<c74object{attrs} module="{module}" category="Test">\n']
    parts.append(f"  <digest>{digest}</digest>\n  <description>{description}</description>\n")

    def ports(tag: str, items) -> None:
        if items is None:
            return
        parts.append(f"  <{tag}list>\n")
        for i, (ptype, pdigest) in enumerate(items):
            type_attr = "" if ptype is None else f' type="{ptype}"'
            parts.append(f'    <{tag} id="{i}"{type_attr}><digest>{pdigest}</digest></{tag}>\n')
        parts.append(f"  </{tag}list>\n")

    ports("inlet", inlets)
    ports("outlet", outlets)
    if methods is not None:
        parts.append("  <methodlist>\n")
        parts.extend(f'    <method name="{m}"><digest>m</digest></method>\n' for m in methods)
        parts.append("  </methodlist>\n")
    if attributes is not None:
        parts.append("  <attributelist>\n")
        parts.extend(
            f'    <attribute name="{a}" get="1" set="1" type="int" size="1"/>\n' for a in attributes
        )
        parts.append("  </attributelist>\n")
    parts.append("</c74object>\n")
    return "".join(parts)


def _help_patch(boxes: list[dict]) -> str:
    return json.dumps({"patcher": {"boxes": [{"box": b} for b in boxes]}})


def _newobj(text: str, numinlets: int, numoutlets: int, outlettype: list[str] | None = None) -> dict:
    box = {"maxclass": "newobj", "text": text, "numinlets": numinlets, "numoutlets": numoutlets}
    if outlettype is not None:
        box["outlettype"] = outlettype
    return box


def _make_bundle(tmp_path: Path, short_version: str = "9.7.3 (abc123)") -> Path:
    """A minimal but structurally real Max.app, version 9.7."""
    app = tmp_path / "Max.app"
    contents = app / "Contents"
    contents.mkdir(parents=True)
    with open(contents / "Info.plist", "wb") as fh:
        plistlib.dump(
            {"CFBundleShortVersionString": short_version, "CFBundleVersion": "9.7.3"}, fh
        )
    c74 = contents / "Resources" / "C74"
    max_ref = c74 / "docs" / "refpages" / "max-ref"
    msp_ref = c74 / "docs" / "refpages" / "msp-ref"
    jit_ref = c74 / "docs" / "refpages" / "jit-ref"
    pkg_docs = c74 / "packages" / "FakePkg" / "docs"
    help_msp = c74 / "help" / "msp"
    for directory in (max_ref, msp_ref, jit_ref, pkg_docs, help_msp, c74 / "init"):
        directory.mkdir(parents=True)

    # Existing object: refpage documents one new message and one new attribute.
    (max_ref / "old.maxref.xml").write_text(
        _refpage(
            "old",
            module="max",
            inlets=[("int", "in")],
            outlets=[("int", "out")],
            methods=["bang", "fresh"],
            attributes=["a", "b"],
        )
    )
    # New object whose FILENAME disagrees with its name attribute.
    (max_ref / "weird_filename.maxref.xml").write_text(
        _refpage(
            "newthing",
            module="max",
            digest="TEXT_HERE",
            inlets=[("int", "Set the value")],
            outlets=[("int", "The value")],
            methods=["int"],
        )
    )
    # A documentation page: no inletlist, outletlist or methodlist at all.
    (max_ref / "docpage.maxref.xml").write_text(_refpage("docpage", module="max"))
    # Existing core object with its own (authoritative) refpage.
    (max_ref / "corething.maxref.xml").write_text(
        _refpage(
            "corething",
            module="max",
            inlets=[("int", "in")],
            outlets=[("int", "out")],
            methods=["bang"],
        )
    )
    # Existing object whose overrides.json entry replaces its messages list.
    (max_ref / "shadow.maxref.xml").write_text(
        _refpage(
            "shadow",
            module="max",
            inlets=[("int", "in")],
            outlets=[("int", "out")],
            methods=["bang", "extra"],
        )
    )
    # New Jitter object; non-ASCII description exercises the escaping style.
    (jit_ref / "jit.fresh.maxref.xml").write_text(
        _refpage(
            "jit.fresh",
            module="jit",
            description="Café matrix",
            inlets=[("matrix", "in")],
            outlets=[("matrix", "out")],
            methods=["bang"],
        ),
        encoding="utf-8",
    )
    # Tilde object, templated inlet type, NO signal method -> control inlet.
    (msp_ref / "ctl~.maxref.xml").write_text(
        _refpage(
            "ctl~",
            inlets=[("INLET_TYPE", "Messages")],
            outlets=[("signal", "out")],
            methods=["int", "bang"],
        )
    )
    # Tilde object, templated inlet type, WITH a signal method -> signal inlet.
    (msp_ref / "sigin~.maxref.xml").write_text(
        _refpage(
            "sigin~",
            inlets=[("INLET_TYPE", "Audio")],
            outlets=[("signal", "out")],
            methods=["signal", "float"],
        )
    )
    # Refpage types all three outlets signal; the help box knows better.
    (msp_ref / "helped~.maxref.xml").write_text(
        _refpage(
            "helped~",
            inlets=[("INLET_TYPE", "Messages")],
            outlets=[("signal", "Audio"), ("signal", "Matrix out"), ("signal", "OUTLET_TYPE")],
            methods=["bang"],
        )
    )
    (help_msp / "helped~.maxhelp").write_text(
        _help_patch(
            [
                _newobj("helped~ @dim 2", 1, 3, ["signal", "jit_matrix", "jit_gl_texture"]),
                {
                    "maxclass": "newobj",
                    "text": "p inner",
                    "numinlets": 0,
                    "numoutlets": 0,
                    "patcher": {"boxes": [{"box": _newobj("helped~", 1, 3, ["signal", "jit_matrix", ""])}]},
                },
            ]
        )
    )
    # Refpage says 1 outlet, the help box says 2 -> must abort.
    (msp_ref / "mismatch~.maxref.xml").write_text(
        _refpage(
            "mismatch~",
            inlets=[("signal", "in")],
            outlets=[("signal", "out")],
            methods=["signal"],
        )
    )
    (help_msp / "mismatch~.maxhelp").write_text(
        _help_patch([_newobj("mismatch~", 1, 2, ["signal", ""])])
    )
    # The collision trap: package refpages whose name attribute names a CORE
    # object and differs from the filename stem. One has a core refpage to
    # collide with, the other does not.
    (pkg_docs / "foo.thing.maxref.xml").write_text(
        _refpage(
            "corething",
            inlets=[("int", "in")],
            outlets=[("int", "out")],
            methods=["bang", "evil"],
            attributes=["evilattr"],
        )
    )
    (pkg_docs / "bar.thing.maxref.xml").write_text(
        _refpage(
            "lonely",
            inlets=[("int", "in")],
            outlets=[("int", "out")],
            methods=["bang", "evil"],
            attributes=["evilattr"],
        )
    )
    _add_define_fixtures(c74)
    return app


def _add_define_fixtures(c74: Path) -> None:
    """`max define` aliases plus one refpage-backed package object."""
    pkg = c74 / "packages" / "FakePkg"
    pkg_docs = pkg / "docs"
    pkg_help = pkg / "help"
    help_jit = c74 / "help" / "jitter"
    for directory in (pkg / "init", pkg_help, help_jit):
        directory.mkdir(parents=True)

    # Core mapping: alias of a core object, no refpage, boxes live in the
    # define TARGET's help file.
    (c74 / "init" / "fake-objectmappings.txt").write_text(
        "max objectfile jit.gl.fresh jit.old;\n"
        "max define jit.gl.fresh jit.old @output_texture 1;\n"
        "max definesubstitution jit.sub bpatcher @name jit.sub.maxpat;\n"
    )
    (help_jit / "jit.old.maxhelp").write_text(
        _help_patch(
            [
                _newobj("jit.old", 1, 1, ["jit_matrix"]),
                _newobj("jit.gl.fresh", 1, 2, ["jit_gl_texture", ""]),
                _newobj("jit.gl.fresh @dim 4 4", 1, 2, ["jit_gl_texture", ""]),
            ]
        )
    )
    # Package mappings: every alias is implemented by the core `corething`.
    (pkg / "init" / "fakepkg-objectmappings.txt").write_text(
        "max define pkg.alias corething alias.js;\n"
        "max define pkg.clone corething clone.js;\n"
        "max define pkg.split corething split.js;\n"
        "max define pkg.nobox corething nobox.js;\n"
    )
    # Alias refpage whose name attribute is the implementing class (the
    # jit.gl.tex2mat / `v8` shape): it documents the ALIAS.
    (pkg_docs / "pkg.alias.maxref.xml").write_text(
        _refpage(
            "corething",
            digest="Convert a thing",
            description="Alias description",
            inlets=[("INLET_TYPE", "thing input")],
            outlets=[("OUTLET_TYPE", "matrix output")],
            methods=["special"],
            attributes=["dim"],
        )
    )
    (pkg_help / "pkg.alias.maxhelp").write_text(
        _help_patch([_newobj("pkg.alias 4 4", 1, 1, ["jit_matrix"]), _newobj("pkg.alias", 1, 1, ["jit_matrix"])])
    )
    # Alias refpage that is an untouched clone of the core page: its message
    # list equals the core entry's.
    (pkg_docs / "pkg.clone.maxref.xml").write_text(
        _refpage(
            "corething",
            digest="Cloned",
            inlets=[("int", "in")],
            outlets=[("int", "out")],
            methods=["bang"],
            attributes=["cloneattr"],
        )
    )
    (pkg_help / "pkg.clone.maxhelp").write_text(_help_patch([_newobj("pkg.clone", 1, 1, [""])]))
    # Help boxes that disagree on the outlet count.
    (pkg_help / "pkg.split.maxhelp").write_text(
        _help_patch([_newobj("pkg.split", 1, 1, [""]), _newobj("pkg.split 2", 1, 2, ["", ""])])
    )
    # pkg.nobox: a mapping line and nothing else.
    # A normal refpage-backed package object (name attribute == stem).
    (pkg_docs / "pkg.fresh.maxref.xml").write_text(
        _refpage(
            "pkg.fresh",
            inlets=[("message", "in")],
            outlets=[("message", "out"), ("message", "dump")],
            methods=["bang"],
            attributes=["size"],
        )
    )
    (pkg_help / "pkg.fresh.maxhelp").write_text(
        _help_patch([_newobj("pkg.fresh", 1, 2, ["jit_matrix", ""])])
    )


# ── Fake DB ───────────────────────────────────────────────────────

_FIELD_ORDER = [
    "name", "maxclass", "module", "domain", "category", "digest", "description",
    "inlets", "outlets", "arguments", "messages", "attributes", "seealso", "tags",
    "min_version", "verified", "variable_io", "rnbo_compatible",
]


def _entry(name: str, domain: str, module: str, **over) -> dict:
    entry = {
        "name": name,
        "maxclass": "newobj",
        "module": module,
        "domain": domain,
        "category": "Test",
        "digest": "Curated digest",
        "description": "Curated description",
        "inlets": [{"id": 0, "type": "int", "signal": False, "digest": "in", "hot": True}],
        "outlets": [{"id": 0, "type": "int", "signal": False, "digest": "out"}],
        "arguments": [],
        "messages": ["bang"],
        "attributes": {},
        "seealso": [],
        "tags": [],
        "min_version": 8,
        "verified": True,
        "variable_io": False,
        "rnbo_compatible": False,
    }
    entry.update(over)
    return {key: entry[key] for key in [*_FIELD_ORDER, *[k for k in entry if k not in _FIELD_ORDER]]}


def _make_db(tmp_path: Path) -> Path:
    """A fake DB whose files use the two serialization styles the real DB mixes."""
    root = tmp_path / "repo" / ".claude" / "max-objects"
    for sub in ("max", "msp", "jitter", "gen", "packages/FakePkg"):
        (root / sub).mkdir(parents=True)

    max_objects = {
        "corething": _entry("corething", "Max", "max", description="Curatéd core text"),
        "lonely": _entry("lonely", "Max", "max"),
        "old": _entry(
            "old",
            "Max",
            "max",
            messages=["bang", "legacy"],
            attributes={"a": {"type": "int", "get": True, "set": True}},
        ),
        "shadow": _entry("shadow", "Max", "max"),
    }
    # UTF-8 (non-ASCII kept raw) WITH a trailing newline.
    (root / "max" / "objects.json").write_text(
        json.dumps(max_objects, indent=2, ensure_ascii=False) + "\n", encoding="utf-8"
    )
    (root / "msp" / "objects.json").write_text(
        json.dumps({"osc.old~": _entry("osc.old~", "MSP", "msp")}, indent=2, ensure_ascii=False)
        + "\n",
        encoding="utf-8",
    )
    # ASCII-escaped with NO trailing newline.
    (root / "jitter" / "objects.json").write_text(
        json.dumps(
            {"jit.old": _entry("jit.old", "Jitter", "jit", description="Escapéd text")},
            indent=2,
            ensure_ascii=True,
        ),
        encoding="utf-8",
    )
    (root / "gen" / "objects.json").write_text(
        json.dumps({"genthing": _entry("genthing", "Gen", "gen-dsp")}, indent=2) + "\n"
    )
    (root / "packages" / "FakePkg" / "objects.json").write_text(
        json.dumps(
            {"pkg.old": _entry("pkg.old", "Packages", "max", package="FakePkg")}, indent=2
        )
        + "\n"
    )
    (root / "package_info.json").write_text(
        json.dumps({"FakePkg": {"name": "FakePkg", "object_count": 1}}, indent=2) + "\n"
    )
    # An expert override that REPLACES the messages list of `shadow`.
    (root / "overrides.json").write_text(
        json.dumps(
            {
                "_comment": "expert corrections",
                "objects": {"shadow": {"messages": ["bang", "custom"]}},
                "version_map": {},
                "variable_io_rules": {},
            },
            indent=2,
            ensure_ascii=True,
        )
    )
    (root / "aliases.json").write_text(json.dumps({"aliases": {}}, indent=2) + "\n")
    return root


@pytest.fixture
def world(tmp_path: Path) -> dict:
    app = _make_bundle(tmp_path)
    db_root = _make_db(tmp_path)
    return {
        "app": app,
        "db_root": db_root,
        "repo": tmp_path / "repo",
        "argv": ["--max-app", str(app), "--db-root", str(db_root), "--repo-root", str(tmp_path / "repo")],
    }


def _sha(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def _tree_bytes(root: Path) -> dict[str, bytes]:
    return {p.relative_to(root).as_posix(): p.read_bytes() for p in sorted(root.rglob("*")) if p.is_file()}


def _load(world: dict, rel: str) -> dict:
    return json.loads((world["db_root"] / rel).read_text(encoding="utf-8"))


def _report(world: dict) -> dict:
    return sync.run_report(world["db_root"], world["app"])["sections"]


def _run(world: dict, *extra: str) -> int:
    return sync.main([*world["argv"], *extra])


# ── Detection and classification ──────────────────────────────────


class TestDetection:
    def test_refpage_parser_is_the_repos_extractor_not_a_copy(self) -> None:
        assert Path(sync.extractor().__file__) == sync.EXTRACTOR_PATH
        assert sync.EXTRACTOR_PATH.name == "extract_objects.py"

    def test_new_objects_are_keyed_on_the_name_attribute(self, world: dict) -> None:
        new = _report(world)["new_objects"]
        assert "newthing" in new["names"]
        assert "weird_filename" not in new["names"]

    def test_page_without_io_or_methods_is_a_documentation_page(self, world: dict) -> None:
        new = _report(world)["new_objects"]
        assert "docpage" in new["doc_pages"]
        assert "docpage" not in new["names"]
        kinds = {o["name"]: o["kind"] for o in new["objects"]}
        assert kinds["docpage"] == "doc_page"
        assert kinds["newthing"] == "object"

    def test_every_section_key_is_present(self, world: dict) -> None:
        assert list(_report(world)) == sync.SECTION_KEYS

    def test_malformed_refpage_is_tallied_not_fatal(self, world: dict) -> None:
        bad = world["app"] / "Contents/Resources/C74/docs/refpages/max-ref/bad.maxref.xml"
        bad.write_text("<c74object name='bad'><unclosed>")
        report = sync.run_report(world["db_root"], world["app"])
        assert len(report["parse_errors"]) == 1
        assert "newthing" in report["sections"]["new_objects"]["names"]


class TestCollisionGuard:
    """T-hwb-02: a mis-named package refpage must never reach a core entry."""

    def test_colliding_package_refpages_are_reported(self, world: dict) -> None:
        collisions = {c["name"]: c for c in _report(world)["collisions"]["entries"]}
        assert collisions["corething"]["kind"] == "shared_name_attribute"
        assert collisions["corething"]["authoritative"].endswith("max-ref/corething.maxref.xml")
        assert collisions["corething"]["ignored"][0].endswith("foo.thing.maxref.xml")
        assert collisions["lonely"]["kind"] == "foreign_name_attribute"
        assert collisions["lonely"]["ignored"][0].endswith("bar.thing.maxref.xml")

    def test_package_refpage_never_alters_the_core_entry(self, world: dict) -> None:
        before = _load(world, "max/objects.json")
        assert _run(world, "--apply", "deltas") == 0
        after = _load(world, "max/objects.json")
        for name in ("corething", "lonely"):
            assert after[name] == before[name]
            assert "evil" not in after[name]["messages"]
            assert "evilattr" not in after[name]["attributes"]

    def test_colliding_refpages_contribute_no_pending_delta(self, world: dict) -> None:
        names = {o["name"] for o in _report(world)["deltas"]["objects"]}
        assert not names & {"corething", "lonely"}


# ── Apply new ─────────────────────────────────────────────────────


class TestApplyNew:
    def test_entry_matches_its_neighbour_in_a_utf8_newline_file(self, world: dict) -> None:
        path = world["db_root"] / "max" / "objects.json"
        before = _load(world, "max/objects.json")
        assert _run(world, "--apply", "new", "--names", "newthing") == 0

        raw = path.read_bytes()
        after = json.loads(raw)
        entry = after["newthing"]
        assert list(entry) == list(before["old"])  # same keys, same order
        assert entry["min_version"] == "9.7"
        assert entry["rnbo_compatible"] is False
        assert entry["name"] == "newthing"
        assert list(after) == sorted(after)
        # Style preserved: raw UTF-8, trailing newline, nothing else rewritten.
        assert raw.endswith(b"}\n")
        assert "Curatéd".encode("utf-8") in raw
        assert raw == (json.dumps(after, indent=2, ensure_ascii=False) + "\n").encode("utf-8")
        assert {k: v for k, v in after.items() if k != "newthing"} == before

    def test_entry_lands_in_an_ascii_escaped_no_newline_file(self, world: dict) -> None:
        path = world["db_root"] / "jitter" / "objects.json"
        before = _load(world, "jitter/objects.json")
        assert _run(world, "--apply", "new", "--names", "jit.fresh") == 0

        raw = path.read_bytes()
        after = json.loads(raw)
        assert list(after["jit.fresh"]) == list(before["jit.old"])
        assert after["jit.fresh"]["description"] == "Café matrix"
        assert after["jit.fresh"]["domain"] == "Jitter"
        assert not raw.endswith(b"\n")
        assert raw.isascii()  # the new non-ASCII text was escaped like the old
        assert b"Caf\\u00e9" in raw and b"Escap\\u00e9d" in raw
        assert raw == json.dumps(after, indent=2, ensure_ascii=True).encode("utf-8")
        assert after["jit.old"] == before["jit.old"]

    def test_template_tokens_are_blanked_never_replaced(self, world: dict) -> None:
        assert _run(world, "--apply", "new", "--names", "newthing") == 0
        assert _load(world, "max/objects.json")["newthing"]["digest"] == ""

    def test_names_are_mandatory(self, world: dict) -> None:
        before = _tree_bytes(world["db_root"])
        assert _run(world, "--apply", "new") == 2
        assert _tree_bytes(world["db_root"]) == before

    def test_an_unnamed_new_object_is_never_landed(self, world: dict) -> None:
        assert _run(world, "--apply", "new", "--names", "newthing") == 0
        assert "jit.fresh" not in _load(world, "jitter/objects.json")
        assert "sigin~" not in _load(world, "msp/objects.json")

    def test_a_name_the_bundle_does_not_document_is_aborted(self, world: dict) -> None:
        before = _tree_bytes(world["db_root"])
        assert _run(world, "--apply", "new", "--names", "no.such.object") == 1
        assert _tree_bytes(world["db_root"]) == before

    def test_documentation_page_is_not_landed(self, world: dict) -> None:
        before = _tree_bytes(world["db_root"])
        assert _run(world, "--apply", "new", "--names", "docpage") == 1
        assert _tree_bytes(world["db_root"]) == before


class TestPortTyping:
    def test_templated_tilde_inlet_without_signal_method_is_control(self, world: dict) -> None:
        assert _run(world, "--apply", "new", "--names", "ctl~") == 0
        inlet = _load(world, "msp/objects.json")["ctl~"]["inlets"][0]
        assert inlet["signal"] is False
        assert inlet["type"] == "control"
        assert inlet["hot"] is True

    def test_templated_tilde_inlet_with_signal_method_is_signal(self, world: dict) -> None:
        assert _run(world, "--apply", "new", "--names", "sigin~") == 0
        inlet = _load(world, "msp/objects.json")["sigin~"]["inlets"][0]
        assert inlet["signal"] is True
        assert inlet["type"] == "signal"
        assert inlet["hot"] is True

    def test_help_box_outlettype_decides_outlet_types(self, world: dict) -> None:
        assert _run(world, "--apply", "new", "--names", "helped~") == 0
        outlets = _load(world, "msp/objects.json")["helped~"]["outlets"]
        assert [(o["type"], o["signal"]) for o in outlets] == [
            ("signal", True),
            ("matrix", False),
            ("control", False),
        ]
        # Refpage digests are kept; a scrubbed template digest falls back to
        # the raw help value so jit_gl_texture is not lost.
        assert [o["digest"] for o in outlets] == ["Audio", "Matrix out", "jit_gl_texture"]

    def test_refpage_vs_help_count_disagreement_aborts_and_writes_nothing(
        self, world: dict
    ) -> None:
        before = _tree_bytes(world["db_root"])
        assert _run(world, "--apply", "new", "--names", "mismatch~") == 1
        assert _tree_bytes(world["db_root"]) == before

    def test_an_aborted_object_does_not_block_its_neighbours(self, world: dict) -> None:
        assert _run(world, "--apply", "new", "--names", "mismatch~", "sigin~") == 1
        objects = _load(world, "msp/objects.json")
        assert "sigin~" in objects
        assert "mismatch~" not in objects


# ── Deltas ────────────────────────────────────────────────────────


class TestDeltas:
    def test_dry_run_reports_pending_names_and_writes_nothing(self, world: dict) -> None:
        before = _tree_bytes(world["db_root"])
        deltas = _report(world)["deltas"]
        old = next(o for o in deltas["objects"] if o["name"] == "old")
        assert old["messages"] == ["fresh"]
        assert list(old["attributes"]) == ["b"]
        assert old["file"] == "max/objects.json"
        assert _run(world) == 0
        assert _tree_bytes(world["db_root"]) == before

    def test_apply_is_additive(self, world: dict) -> None:
        before = _load(world, "max/objects.json")["old"]
        assert _run(world, "--apply", "deltas") == 0
        after = _load(world, "max/objects.json")["old"]
        # New names appended; the DB-only message is retained.
        assert after["messages"] == ["bang", "legacy", "fresh"]
        assert list(after["attributes"]) == ["a", "b"]
        assert after["attributes"]["a"] == before["attributes"]["a"]
        for field in before:
            if field not in ("messages", "attributes"):
                assert after[field] == before[field], field

    def test_nothing_is_pending_after_apply(self, world: dict) -> None:
        assert _report(world)["deltas"]["pending_messages"] > 0
        assert _run(world, "--apply", "deltas") == 0
        deltas = _report(world)["deltas"]
        assert deltas["pending_messages"] == 0
        assert deltas["pending_attributes"] == 0

    def test_override_shadowed_lists_are_report_only(self, world: dict) -> None:
        def shadow_row() -> dict:
            section = _report(world)["shadowed_by_override"]
            assert "shadow" in section["with_missing_names"]
            return next(e for e in section["entries"] if e["name"] == "shadow")

        assert shadow_row()["messages_missing"] == ["extra"]
        assert _run(world, "--apply", "deltas") == 0
        # The raw base entry gained the name; the override still lacks it and
        # stays reported, uncounted.
        assert _load(world, "max/objects.json")["shadow"]["messages"] == ["bang", "extra"]
        assert shadow_row()["messages_missing"] == ["extra"]
        assert _report(world)["deltas"]["pending_messages"] == 0

    def test_gen_duplicates_are_never_written(self, world: dict) -> None:
        gen = world["db_root"] / "gen" / "objects.json"
        before = gen.read_bytes()
        assert _run(world, "--apply", "deltas") == 0
        assert gen.read_bytes() == before


def _add_group_fixtures(world: dict) -> None:
    """A group page plus an object refpage that lists its attributes by name only."""
    jit_ref = world["app"] / "Contents" / "Resources" / "C74" / "docs" / "refpages" / "jit-ref"
    (jit_ref / "jit.group-fake.maxref.xml").write_text(
        _refpage("Fake Group Messages", module="jit", methods=["draw"], attributes=["alpha_mode", "blend"])
    )
    # A second group page that defines `blend` differently: ambiguous.
    (jit_ref / "jit.group-other.maxref.xml").write_text(
        _refpage("Other Group Features", module="jit", attributes=["blend"]).replace(
            'type="int"', 'type="symbol"'
        )
    )
    listing = (
        "  <jitterattributelist>\n"
        '    <jitterattribute name="alpha_mode" />\n'
        '    <jitterattribute name="blend" />\n'
        '    <jitterattribute name="nowhere" />\n'
        "  </jitterattributelist>\n</c74object>\n"
    )
    (jit_ref / "jit.old.maxref.xml").write_text(
        _refpage(
            "jit.old", module="jit", inlets=[("int", "in")], outlets=[("int", "out")], methods=["bang"]
        ).replace("</c74object>\n", listing)
    )


class TestInheritedAttributes:
    """DEF-hwb-24: names-only <jitterattribute> references to a group page."""

    def test_report_names_what_the_group_page_defines(self, world: dict) -> None:
        _add_group_fixtures(world)
        before = _tree_bytes(world["db_root"])
        section = _report(world)["inherited_attributes"]
        assert section["by_attribute"] == {"alpha_mode": 1}
        assert section["ambiguous"] == ["blend"]
        assert section["undefined"] == {"nowhere": 1}
        assert section["objects"] == [
            {"name": "jit.old", "file": "jitter/objects.json", "attributes": ["alpha_mode"]}
        ]
        assert [Path(g).name for g in section["group_pages"]] == ["jit.group-fake.maxref.xml"]
        # Report-only: a dry run and a plain deltas apply both leave it alone.
        assert _run(world) == 0
        assert _tree_bytes(world["db_root"]) == before
        assert _run(world, "--apply", "deltas") == 0
        assert "alpha_mode" not in _load(world, "jitter/objects.json")["jit.old"]["attributes"]

    def test_apply_needs_an_explicit_attribute_list(self, world: dict) -> None:
        _add_group_fixtures(world)
        before = _tree_bytes(world["db_root"])
        assert _run(world, "--apply", "inherited") == 2
        assert _tree_bytes(world["db_root"]) == before

    def test_apply_adds_only_the_named_attribute_with_the_group_definition(
        self, world: dict
    ) -> None:
        _add_group_fixtures(world)
        before = _load(world, "jitter/objects.json")["jit.old"]
        assert _run(world, "--apply", "inherited", "--attributes", "alpha_mode", "blend") == 0
        after = _load(world, "jitter/objects.json")["jit.old"]
        # `blend` is ambiguous and `nowhere` undefined: neither lands.
        assert after["attributes"] == {"alpha_mode": {"type": "int", "get": True, "set": True}}
        for field in before:
            if field != "attributes":
                assert after[field] == before[field], field
        assert _report(world)["inherited_attributes"]["by_attribute"] == {}

    def test_apply_is_idempotent_and_respects_names(self, world: dict) -> None:
        _add_group_fixtures(world)
        before = _tree_bytes(world["db_root"])
        argv = ("--apply", "inherited", "--attributes", "alpha_mode")
        assert _run(world, *argv, "--names", "someone.else") == 0
        assert _tree_bytes(world["db_root"]) == before
        assert _run(world, *argv) == 0
        first = _tree_bytes(world["db_root"])
        assert first != before
        assert _run(world, *argv) == 0
        assert _tree_bytes(world["db_root"]) == first

    def test_group_page_itself_never_becomes_an_object(self, world: dict) -> None:
        _add_group_fixtures(world)
        new = _report(world)["new_objects"]
        assert "Fake Group Messages" in new["doc_pages"]
        assert "Fake Group Messages" not in new["names"]


class TestRefreshLog:
    """DEF-hwb-10: the extraction log is re-stated from the DB after a sync."""

    def _seed(self, world: dict) -> dict:
        old = {
            "total_files_found": 1,
            "total_objects": 1,
            "domain_counts": {"max": 1},
            "error_count": 0,
            "errors": [],
            "inlet_type_fallback_count": 0,
            "variable_io_count": 0,
            "empty_inlets_count": 0,
            "empty_outlets_count": 0,
            "extraction_timestamp": "2026-01-01T00:00:00+00:00",
            "max_installation_path": ".claude/max-objects",
        }
        (world["db_root"] / "extraction-log.json").write_text(json.dumps(old, indent=2) + "\n")
        return old

    def _log(self, world: dict) -> dict:
        return json.loads((world["db_root"] / "extraction-log.json").read_text())

    def test_counts_are_restated_from_disk_and_old_fields_survive(self, world: dict) -> None:
        old = self._seed(world)
        assert _run(world, "--refresh-log") == 0
        log = self._log(world)
        # Every field the extractor writes is still there, in the same order.
        assert list(log)[: len(old)] == list(old)
        assert log["domain_counts"] == {"max": 4, "msp": 1, "jitter": 1, "gen": 1, "packages": 1}
        assert list(log["domain_counts"])[0] == "max"  # the log's own order leads
        assert log["total_objects"] == 8
        assert log["total_files_found"] == 5
        assert log["max_installation_path"] == old["max_installation_path"]
        assert log["extraction_timestamp"] > old["extraction_timestamp"]
        assert log["max_version"] == "9.7.3" and log["max_build"] == "abc123"
        assert log["sync"]["pending_messages"] > 0  # nothing was applied in this run

    def test_superseded_state_is_appended_to_history(self, world: dict) -> None:
        old = self._seed(world)
        assert _run(world, "--refresh-log") == 0
        assert _run(world, "--apply", "deltas", "--refresh-log") == 0
        log = self._log(world)
        assert [h["extraction_timestamp"] for h in log["history"]][0] == old["extraction_timestamp"]
        assert len(log["history"]) == 2
        assert log["history"][0]["domain_counts"] == {"max": 1}
        assert log["history"][1]["max_version"] == "9.7.3"
        # The log is written after the apply, so it records the post-apply state.
        assert log["sync"]["pending_messages"] == 0

    def test_audit_reads_the_refreshed_log_as_fresh_and_undrifted(self, world: dict) -> None:
        import tools.audit_db as audit_db

        self._seed(world)
        assert audit_db.audit_db_age(world["db_root"])["domains_drifted"] != []
        assert _run(world, "--refresh-log") == 0
        section = audit_db.audit_db_age(world["db_root"])
        assert section["domains_drifted"] == []
        assert section["age_days"] < 1

    def test_only_the_log_is_written(self, world: dict) -> None:
        self._seed(world)
        before = _tree_bytes(world["db_root"])
        assert _run(world, "--refresh-log") == 0
        after = _tree_bytes(world["db_root"])
        assert [k for k in after if after[k] != before.get(k)] == ["extraction-log.json"]
        assert set(after) == set(before)

    def test_missing_log_is_created_with_empty_history(self, world: dict) -> None:
        assert _run(world, "--refresh-log") == 0
        assert self._log(world)["history"] == []

    def test_unavailable_bundle_leaves_the_log_alone(self, world: dict, tmp_path: Path) -> None:
        self._seed(world)
        before = _tree_bytes(world["db_root"])
        argv = ["--max-app", str(tmp_path / "absent.app"), "--db-root", str(world["db_root"]),
                "--repo-root", str(world["repo"]), "--refresh-log"]
        assert sync.main(argv) == 1
        assert _tree_bytes(world["db_root"]) == before


class TestAdditiveSelfCheck:
    """T-hwb-02: the writer refuses anything but growth on a pre-existing entry."""

    def _data(self, world: dict) -> tuple[Path, dict]:
        path = world["db_root"] / "max" / "objects.json"
        return path, json.loads(path.read_text(encoding="utf-8"))

    def test_rejects_a_hand_mutated_field(self, world: dict) -> None:
        path, data = self._data(world)
        before = path.read_bytes()
        data["old"]["digest"] = "rewritten by a careless sync"
        with pytest.raises(sync.AdditiveViolation, match="digest"):
            sync.write_db_file(path, data, world["db_root"])
        assert path.read_bytes() == before

    def test_rejects_changed_io(self, world: dict) -> None:
        path, data = self._data(world)
        data["old"]["outlets"].append({"id": 1, "type": "int", "signal": False, "digest": ""})
        with pytest.raises(sync.AdditiveViolation, match="outlets"):
            sync.write_db_file(path, data, world["db_root"])

    def test_rejects_a_removed_message(self, world: dict) -> None:
        path, data = self._data(world)
        data["old"]["messages"] = ["bang", "fresh"]  # "legacy" dropped
        with pytest.raises(sync.AdditiveViolation, match="messages"):
            sync.write_db_file(path, data, world["db_root"])

    def test_rejects_a_changed_attribute(self, world: dict) -> None:
        path, data = self._data(world)
        data["old"]["attributes"]["a"]["type"] = "float"
        with pytest.raises(sync.AdditiveViolation, match="attribute"):
            sync.write_db_file(path, data, world["db_root"])

    def test_rejects_a_removed_entry(self, world: dict) -> None:
        path, data = self._data(world)
        del data["lonely"]
        with pytest.raises(sync.AdditiveViolation, match="removed"):
            sync.write_db_file(path, data, world["db_root"])

    def test_accepts_pure_growth(self, world: dict) -> None:
        path, data = self._data(world)
        data["old"]["messages"].append("grown")
        data["old"]["attributes"]["z"] = {"type": "int", "get": True, "set": True}
        assert sync.write_db_file(path, data, world["db_root"]) is True
        assert json.loads(path.read_text(encoding="utf-8"))["old"]["messages"][-1] == "grown"


# ── Idempotence, write guard, degraded runs ───────────────────────


class TestIdempotence:
    def test_second_identical_apply_is_byte_identical(self, world: dict) -> None:
        argv = ["--apply", "new", "--apply", "deltas", "--names", "newthing", "jit.fresh", "sigin~"]
        assert _run(world, *argv) == 0
        first = _tree_bytes(world["db_root"])
        assert _run(world, *argv) == 0
        assert _tree_bytes(world["db_root"]) == first

    def test_unchanged_data_is_not_rewritten(self, world: dict) -> None:
        path = world["db_root"] / "max" / "objects.json"
        data = json.loads(path.read_text(encoding="utf-8"))
        assert sync.write_db_file(path, data, world["db_root"]) is False


class TestWriteGuard:
    """T-hwb-01: overrides.json has no write path through this tool."""

    def test_overrides_sha_is_unchanged_after_every_apply_mode(self, world: dict) -> None:
        overrides = world["db_root"] / "overrides.json"
        before = _sha(overrides)
        assert _run(world, "--apply", "new", "--names", "newthing", "jit.fresh", "helped~") == 0
        assert _sha(overrides) == before
        assert _run(world, "--apply", "deltas") == 0
        assert _sha(overrides) == before

    @pytest.mark.parametrize(
        "relative",
        ["overrides.json", "aliases.json", "gen/objects.json", "max/other.json", "packages/FakePkg/notes.json"],
    )
    def test_off_list_db_files_are_refused(self, world: dict, relative: str) -> None:
        target = world["db_root"] / relative
        before = target.read_bytes() if target.exists() else None
        with pytest.raises(sync.WriteRefused):
            sync.write_db_file(target, {}, world["db_root"])
        assert (target.read_bytes() if target.exists() else None) == before

    def test_a_destination_outside_the_db_root_is_refused(self, world: dict, tmp_path: Path) -> None:
        outside = tmp_path / "elsewhere" / "max" / "objects.json"
        outside.parent.mkdir(parents=True)
        outside.write_text("{}\n")
        with pytest.raises(sync.WriteRefused):
            sync.write_db_file(outside, {}, world["db_root"])
        assert outside.read_text() == "{}\n"

    @pytest.mark.parametrize(
        "relative", ["max/objects.json", "packages/FakePkg/objects.json", "package_info.json"]
    )
    def test_allow_listed_files_are_accepted(self, world: dict, relative: str) -> None:
        assert sync.allowed_db_target(world["db_root"] / relative, world["db_root"]) == relative

    def test_unreproducible_style_is_refused_not_normalised(self, world: dict) -> None:
        path = world["db_root"] / "max" / "objects.json"
        data = json.loads(path.read_text(encoding="utf-8"))
        path.write_text(json.dumps(data, indent=4) + "\n")  # not the DB's style
        before = path.read_bytes()
        assert _run(world, "--apply", "deltas") == 2
        assert path.read_bytes() == before

    def test_report_path_inside_the_db_is_rejected(self, world: dict) -> None:
        target = world["db_root"] / "report.json"
        assert _run(world, "--json", str(target)) == 2
        assert not target.exists()


class TestDegraded:
    def test_unavailable_bundle_exits_zero_and_says_so(self, world: dict, capsys) -> None:
        before = _tree_bytes(world["db_root"])
        code = sync.main(
            ["--max-app", str(world["repo"] / "nope" / "Max.app"), "--db-root", str(world["db_root"])]
        )
        assert code == 0
        assert "bundle unavailable" in capsys.readouterr().out
        assert _tree_bytes(world["db_root"]) == before

    def test_unavailable_bundle_keeps_every_section_key(self, world: dict) -> None:
        sections = sync.run_report(world["db_root"], world["repo"] / "nope.app")["sections"]
        assert list(sections) == sync.SECTION_KEYS
        assert all(sections[k]["available"] is False for k in sync.SECTION_KEYS)

    def test_json_report_is_written_outside_the_db(self, world: dict, tmp_path: Path) -> None:
        out = tmp_path / "out" / "sync.json"
        assert _run(world, "--json", str(out)) == 0
        assert list(json.loads(out.read_text())["sections"]) == sync.SECTION_KEYS


class TestIoSnapshot:
    def test_additive_applies_leave_the_snapshot_unchanged(self, world: dict, tmp_path: Path) -> None:
        snap = tmp_path / "io.json"
        assert _run(world, "--snapshot-io", str(snap)) == 0
        assert "genthing" in json.loads(snap.read_text())["objects"]  # every DB name
        assert _run(world, "--apply", "new", "--apply", "deltas", "--names", "newthing", "sigin~") == 0
        assert _run(world, "--compare-io", str(snap)) == 0

    def test_a_changed_outlet_on_an_existing_object_is_caught(
        self, world: dict, tmp_path: Path
    ) -> None:
        snap = tmp_path / "io.json"
        assert _run(world, "--snapshot-io", str(snap)) == 0
        path = world["db_root"] / "max" / "objects.json"
        data = json.loads(path.read_text(encoding="utf-8"))
        data["old"]["outlets"].append({"id": 1, "type": "int", "signal": False, "digest": ""})
        path.write_text(json.dumps(data, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
        assert _run(world, "--compare-io", str(snap)) == 1


# ── Apply define and package destinations (Task 2) ────────────────


def _results(world: dict, tmp_path: Path, *extra: str) -> tuple[int, dict]:
    """Run the CLI and return (exit code, per-name apply results)."""
    out = tmp_path / "apply.json"
    code = _run(world, *extra, "--json", str(out))
    applied = json.loads(out.read_text()).get("applied", {}).get("objects", [])
    return code, {r["name"]: r for r in applied}


class TestApplyDefine:
    def test_alias_without_refpage_is_built_from_mapping_line_and_help_box(
        self, world: dict
    ) -> None:
        before = _load(world, "jitter/objects.json")
        assert _run(world, "--apply", "define", "--names", "jit.gl.fresh") == 0
        # Core mapping line -> the core domain file that holds the define target.
        after = _load(world, "jitter/objects.json")
        entry = after["jit.gl.fresh"]
        target = before["jit.old"]
        assert list(entry) == list(target)
        assert "package" not in entry
        # I/O counts and outlet types from the help box (found in the TARGET's
        # help file), not from the target entry.
        assert len(entry["inlets"]) == 1 and len(entry["outlets"]) == 2
        assert [(o["type"], o["signal"], o["digest"]) for o in entry["outlets"]] == [
            ("control", False, "jit_gl_texture"),
            ("control", False, ""),
        ]
        assert entry["inlets"][0]["hot"] is True
        # Messages / attributes inherited from the define target's DB entry.
        assert entry["messages"] == target["messages"]
        assert entry["attributes"] == target["attributes"]
        assert entry["digest"] == (
            "Curated digest (max define jit.gl.fresh jit.old @output_texture 1;)"
        )
        assert entry["description"] == ""
        assert entry["maxclass"] == "newobj"
        assert entry["min_version"] == "9.7"
        assert entry["rnbo_compatible"] is False
        assert (entry["domain"], entry["module"]) == ("Jitter", "jit")
        assert after["jit.old"] == target

    def test_alias_refpage_supplies_descriptive_fields_whatever_its_name_attribute(
        self, world: dict
    ) -> None:
        core_before = _load(world, "max/objects.json")
        assert _run(world, "--apply", "define", "--names", "pkg.alias") == 0
        # Package mapping line -> that package's file.
        entry = _load(world, "packages/FakePkg/objects.json")["pkg.alias"]
        assert entry["name"] == "pkg.alias"
        assert entry["digest"] == "Convert a thing"
        assert entry["description"] == "Alias description"
        assert entry["messages"] == ["special"]
        assert list(entry["attributes"]) == ["dim"]
        assert (entry["package"], entry["domain"]) == ("FakePkg", "Packages")
        # Counts and outlet type from the box; the refpage digests are kept.
        assert [(i["type"], i["signal"], i["digest"]) for i in entry["inlets"]] == [
            ("control", False, "thing input")
        ]
        assert [(o["type"], o["digest"]) for o in entry["outlets"]] == [("matrix", "matrix output")]
        # ...and the object the name attribute points at is untouched.
        assert _load(world, "max/objects.json") == core_before

    def test_cloned_template_refpage_yields_empty_messages_and_is_reported(
        self, world: dict, tmp_path: Path
    ) -> None:
        code, results = _results(world, tmp_path, "--apply", "define", "--names", "pkg.clone")
        assert code == 0
        entry = _load(world, "packages/FakePkg/objects.json")["pkg.clone"]
        assert entry["messages"] == []
        assert entry["attributes"] == {}
        assert "cloned_template" in results["pkg.clone"]["notes"]

    def test_disagreeing_help_boxes_abort(self, world: dict, tmp_path: Path) -> None:
        before = _tree_bytes(world["db_root"])
        code, results = _results(world, tmp_path, "--apply", "define", "--names", "pkg.split")
        assert code == 1
        assert results["pkg.split"]["status"] == "aborted"
        assert "disagree" in results["pkg.split"]["reason"]
        assert _tree_bytes(world["db_root"]) == before

    def test_no_help_box_aborts(self, world: dict, tmp_path: Path) -> None:
        before = _tree_bytes(world["db_root"])
        code, results = _results(world, tmp_path, "--apply", "define", "--names", "pkg.nobox")
        assert code == 1
        assert "no help-patch box" in results["pkg.nobox"]["reason"]
        assert _tree_bytes(world["db_root"]) == before

    def test_name_without_a_mapping_line_aborts(self, world: dict, tmp_path: Path) -> None:
        before = _tree_bytes(world["db_root"])
        # `newthing` is a real new refpage object, but it is no define alias;
        # `jit.sub` only has a definesubstitution line.
        code, results = _results(
            world, tmp_path, "--apply", "define", "--names", "newthing", "jit.sub"
        )
        assert code == 1
        for name in ("newthing", "jit.sub"):
            assert results[name]["status"] == "aborted"
            assert "max define" in results[name]["reason"]
        assert _tree_bytes(world["db_root"]) == before

    def test_define_missing_lists_unresolved_aliases(self, world: dict) -> None:
        missing = _report(world)["define_missing"]
        assert {"jit.gl.fresh", "pkg.alias", "pkg.clone", "pkg.split", "pkg.nobox"} <= set(
            missing["names"]
        )
        assert "jit.sub" not in missing["names"]  # definesubstitution is not a define
        assert _run(world, "--apply", "define", "--names", "jit.gl.fresh", "pkg.alias") == 0
        after = set(_report(world)["define_missing"]["names"])
        assert not after & {"jit.gl.fresh", "pkg.alias"}

    def test_alias_refpage_never_changes_the_entry_its_name_attribute_names(
        self, world: dict
    ) -> None:
        """pkg.alias / pkg.clone both declare name="corething"."""
        section = _report(world)
        assert {a["alias"] for a in section["alias_docs"]["entries"]} >= {"pkg.alias", "pkg.clone"}
        before = _load(world, "max/objects.json")["corething"]
        assert _run(world, "--apply", "deltas") == 0
        after = _load(world, "max/objects.json")["corething"]
        assert after == before
        assert not {"special", "dim", "cloneattr"} & (set(after["messages"]) | set(after["attributes"]))

    # quick-261118-j2w: the deltas pass diffs an alias document against the
    # alias's own DB entry (Max 9.2.1 added dimscale / jit_matrix to the
    # jit.gl.tex2mat refpage, whose name attribute is `v8`).

    @staticmethod
    def _seed_alias_entry(world: dict) -> None:
        """pkg.alias in the DB, lacking the `special` / `dim` its refpage documents."""
        path = world["db_root"] / "packages" / "FakePkg" / "objects.json"
        data = json.loads(path.read_text(encoding="utf-8"))
        data["pkg.alias"] = _entry(
            "pkg.alias", "Packages", "max", package="FakePkg", messages=["bang"], attributes={}
        )
        path.write_text(json.dumps(data, indent=2) + "\n", encoding="utf-8")

    def test_alias_document_delta_is_keyed_by_the_alias(self, world: dict) -> None:
        self._seed_alias_entry(world)
        before = _tree_bytes(world["db_root"])
        deltas = _report(world)["deltas"]
        row = next(o for o in deltas["objects"] if o["name"] == "pkg.alias")
        assert row["file"] == "packages/FakePkg/objects.json"
        assert row["messages"] == ["special"]
        assert list(row["attributes"]) == ["dim"]
        assert "corething" not in {o["name"] for o in deltas["objects"]}
        assert _tree_bytes(world["db_root"]) == before

    def test_alias_document_apply_writes_the_alias_only(self, world: dict) -> None:
        self._seed_alias_entry(world)
        core_before = _load(world, "max/objects.json")["corething"]
        alias_before = _load(world, "packages/FakePkg/objects.json")["pkg.alias"]
        assert _run(world, "--apply", "deltas") == 0
        alias_after = _load(world, "packages/FakePkg/objects.json")["pkg.alias"]
        assert alias_after["messages"] == ["bang", "special"]
        assert list(alias_after["attributes"]) == ["dim"]
        for field in alias_before:
            if field not in ("messages", "attributes"):
                assert alias_after[field] == alias_before[field], field
        assert _load(world, "max/objects.json")["corething"] == core_before

    def test_alias_document_for_an_alias_missing_from_the_db_is_skipped(self, world: dict) -> None:
        """pkg.clone has an alias document but no DB entry: no delta, no error."""
        sections = _report(world)
        assert "pkg.clone" not in {o["name"] for o in sections["deltas"]["objects"]}
        assert "pkg.clone" in sections["define_missing"]["names"]
        assert _run(world, "--apply", "deltas") == 0

    def test_alias_resolving_to_its_name_attribute_target_is_never_written(
        self, world: dict
    ) -> None:
        """An alias whose lookup lands on the target entry must not write the target."""
        (world["db_root"] / "aliases.json").write_text(
            json.dumps({"aliases": {"pkg.clone": "corething"}}, indent=2) + "\n"
        )
        core_before = _load(world, "max/objects.json")["corething"]
        deltas = _report(world)["deltas"]
        assert not {"pkg.clone", "corething"} & {o["name"] for o in deltas["objects"]}
        assert _run(world, "--apply", "deltas") == 0
        assert _load(world, "max/objects.json")["corething"] == core_before

    def test_alias_document_apply_is_idempotent_and_keeps_the_section_shape(
        self, world: dict
    ) -> None:
        self._seed_alias_entry(world)
        shape_before = _report(world)["alias_docs"]
        assert _run(world, "--apply", "deltas") == 0
        first = _tree_bytes(world["db_root"])
        deltas = _report(world)["deltas"]
        assert deltas["pending_messages"] == 0 and deltas["pending_attributes"] == 0
        assert _run(world, "--apply", "deltas") == 0
        assert _tree_bytes(world["db_root"]) == first
        assert _report(world)["alias_docs"] == shape_before

    def test_min_version_flag_tags_an_object_that_predates_the_install(
        self, world: dict, tmp_path: Path
    ) -> None:
        """DEF-hwb-13: an older alias must not be tagged with the installed version."""
        code, results = _results(
            world, tmp_path, "--apply", "define", "--names", "jit.gl.fresh", "--min-version", "8"
        )
        assert code == 0
        entry = _load(world, "jitter/objects.json")["jit.gl.fresh"]
        assert entry["min_version"] == "8"
        assert "explicit --min-version" in results["jit.gl.fresh"]["notes"]["min_version"]

    def test_min_version_flag_keeps_a_point_release_as_a_string(self) -> None:
        assert sync.parse_min_version("9.1") == "9.1"
        assert sync.parse_min_version("9") == "9"
        assert sync.parse_min_version("9.10") == "9.10"

    @pytest.mark.parametrize("bad", ["10", "3", "nine", "9.x", "-8"])
    def test_min_version_flag_rejects_out_of_range_values(self, bad: str) -> None:
        import argparse

        with pytest.raises(argparse.ArgumentTypeError):
            sync.parse_min_version(bad)

    def test_min_version_flag_without_an_object_apply_is_refused(self, world: dict) -> None:
        before = _tree_bytes(world["db_root"])
        assert _run(world, "--apply", "deltas", "--min-version", "8") == 2
        assert _tree_bytes(world["db_root"]) == before

    def test_define_apply_is_idempotent(self, world: dict) -> None:
        argv = ["--apply", "define", "--names", "jit.gl.fresh", "pkg.alias", "pkg.clone"]
        assert _run(world, *argv) == 0
        first = _tree_bytes(world["db_root"])
        assert _run(world, *argv) == 0
        assert _tree_bytes(world["db_root"]) == first


class TestPackageDestinations:
    def test_new_package_object_gets_package_field_and_bumps_object_count(
        self, world: dict
    ) -> None:
        neighbour = _load(world, "packages/FakePkg/objects.json")["pkg.old"]
        assert _load(world, "package_info.json")["FakePkg"]["object_count"] == 1
        assert _run(world, "--apply", "new", "--names", "pkg.fresh") == 0

        objects = _load(world, "packages/FakePkg/objects.json")
        entry = objects["pkg.fresh"]
        assert list(entry) == list(neighbour)
        assert entry["package"] == "FakePkg"
        assert entry["domain"] == "Packages"
        assert entry["min_version"] == "9.7"
        assert [o["type"] for o in entry["outlets"]] == ["matrix", "control"]
        assert objects["pkg.old"] == neighbour
        info = _load(world, "package_info.json")
        assert info["FakePkg"] == {"name": "FakePkg", "object_count": 2}

    def test_object_count_tracks_define_aliases_too(self, world: dict) -> None:
        argv = ["--apply", "new", "--apply", "define", "--names", "pkg.fresh", "pkg.alias"]
        assert _run(world, *argv) == 0
        assert _load(world, "package_info.json")["FakePkg"]["object_count"] == 3
        assert len(_load(world, "packages/FakePkg/objects.json")) == 3

    def test_unknown_db_package_is_refused(self, world: dict, tmp_path: Path) -> None:
        docs = world["app"] / "Contents/Resources/C74/packages/Stranger/docs"
        docs.mkdir(parents=True)
        (docs / "stranger.obj.maxref.xml").write_text(
            _refpage("stranger.obj", inlets=[("int", "in")], outlets=[("int", "out")], methods=["bang"])
        )
        before = _tree_bytes(world["db_root"])
        code, results = _results(world, tmp_path, "--apply", "new", "--names", "stranger.obj")
        assert code == 1
        assert "Stranger" in results["stranger.obj"]["reason"]
        assert _tree_bytes(world["db_root"]) == before

    def test_package_info_only_object_count_may_change(self, world: dict) -> None:
        path = world["db_root"] / "package_info.json"
        info = json.loads(path.read_text())
        info["FakePkg"]["name"] = "Renamed"
        with pytest.raises(sync.AdditiveViolation):
            sync.write_db_file(path, info, world["db_root"])
        info = json.loads(path.read_text())
        info["FakePkg"]["object_count"] = 0
        with pytest.raises(sync.AdditiveViolation, match="shrink"):
            sync.write_db_file(path, info, world["db_root"])

    def test_overrides_sha_is_unchanged_after_define_and_package_applies(
        self, world: dict
    ) -> None:
        overrides = world["db_root"] / "overrides.json"
        before = _sha(overrides)
        argv = ["--apply", "new", "--apply", "define", "--names", "pkg.fresh", "pkg.alias", "jit.gl.fresh"]
        assert _run(world, *argv) == 0
        assert _sha(overrides) == before


# ── ui_maxclasses survey (review C5, Q13) ─────────────────────────


def _write_json(path: Path, data) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(data), encoding="utf-8")


def _survey_tree(tmp_path: Path) -> Path:
    c74 = tmp_path / "C74"
    _write_json(c74 / "help" / "max" / "w.maxhelp", {"patcher": {"boxes": [
        {"box": {"maxclass": "toggle", "patching_rect": [0, 0, 24, 24]}},
        {"box": {"maxclass": "zz.widget", "patching_rect": [0, 0, 100, 40]}},
        {"box": {"maxclass": "newobj", "text": "p tab", "patcher": {"boxes": [
            {"box": {"maxclass": "zz.widget", "patching_rect": [0, 0, 120, 60]}},
            {"box": {"maxclass": "newobj", "text": "zz.textual 1"}},
        ]}}},
    ]}})
    _write_json(c74 / "patchers" / "x.maxpat", {"patcher": {"boxes": [
        {"box": {"maxclass": "newobj", "text": "zz.both"}},
        {"box": {"maxclass": "zz.both", "patching_rect": [0, 0, 10, 10]}},
        {"box": {"maxclass": "zz.label", "text": "hello", "patching_rect": [0, 0, 50, 20]}},
    ]}})
    (c74 / "patchers" / "bad.maxpat").write_text("{not json", encoding="utf-8")
    ref = c74 / "docs" / "refpages" / "max-ref" / "y.maxref.xml"
    ref.parent.mkdir(parents=True, exist_ok=True)
    ref.write_text(_refpage("y"), encoding="utf-8")
    return c74


class TestUiMaxclassSurvey:
    def test_survey(self, tmp_path: Path) -> None:
        survey = sync.survey_maxclasses(_survey_tree(tmp_path))
        assert survey["files_scanned"] == 2
        assert len(survey["read_errors"]) == 1
        assert survey["read_errors"][0]["file"] == "patchers/bad.maxpat"
        widget = survey["observed"]["zz.widget"]
        assert widget["boxes"] == 2
        assert widget["files"] == 1
        assert widget["top_level_boxes"] == 1
        assert widget["median_size"] == [110.0, 50.0]
        assert widget["example"] == "help/max/w.maxhelp"
        assert survey["observed"]["zz.label"]["text_boxes"] == 1
        assert survey["newobj"]["zz.textual"] == 1
        assert survey["newobj"]["p"] == 1
        assert survey["newobj"]["zz.both"] == 1

    def test_section(self, tmp_path: Path) -> None:
        survey = sync.survey_maxclasses(_survey_tree(tmp_path))
        section = sync.section_ui_maxclasses(
            survey, ui_set=frozenset({"toggle", "zz.textual", "zz.unseen"})
        )
        assert section["available"] is True
        assert section["survey_set"] == ["toggle", "zz.both", "zz.label", "zz.widget"]
        assert section["missing_from_ui_set"] == ["zz.both", "zz.label", "zz.widget"]
        assert section["newobj_only_in_bundle"] == ["zz.textual"]
        assert section["unobserved_in_bundle"] == ["zz.unseen"]
        assert section["written_both_ways"] == ["zz.both"]
        assert section["evidence"]["zz.both"]["newobj_boxes"] == 1
        assert section["newobj_evidence"] == {"zz.textual": 1}
        assert section["ui_set_size"] == 3

    def test_run_report_section_is_read_only(self, world: dict) -> None:
        from src.maxpat.maxclass_map import UI_MAXCLASSES

        before = _tree_bytes(world["db_root"])
        map_py = sync.ROOT / "src" / "maxpat" / "maxclass_map.py"
        sizing_py = sync.ROOT / "src" / "maxpat" / "sizing.py"
        hashes = (_sha(map_py), _sha(sizing_py))
        report = sync.run_report(world["db_root"], world["app"])
        section = report["sections"]["ui_maxclasses"]
        assert section["available"] is True
        assert section["ui_set_size"] == len(UI_MAXCLASSES)
        assert "ui maxclasses" in sync.format_summary(report)
        assert _tree_bytes(world["db_root"]) == before
        assert (_sha(map_py), _sha(sizing_py)) == hashes

    def test_section_key_is_last(self) -> None:
        assert sync.SECTION_KEYS[-1] == "ui_maxclasses"


# ── Inherited group profiles (review C8 / Q14) ────────────────────


def _mcwrapper_refpage(name: str, methods: list[str] | None, attrs: list[str] | None) -> str:
    """An MC refpage with one signal inlet / outlet and `bang`.

    `methods` None omits the <mcwrapper> element; [] with attrs [] writes an
    empty one (the mc.record~ shape).
    """
    page = _refpage(
        name, module="msp", inlets=[("signal", "in")], outlets=[("signal", "out")], methods=["bang"]
    )
    if methods is None:
        return page
    block = ["  <mcwrapper>\n"]
    block.extend(f'    <mcwrappermethod name="{m}" />\n' for m in methods)
    block.extend(f'    <mcwrapperattr name="{a}" />\n' for a in attrs or [])
    block.append("  </mcwrapper>\n</c74object>\n")
    return page.replace("</c74object>\n", "".join(block))


def _add_groups_fixtures(world: dict) -> None:
    """MC wrapper refpages plus an mc/objects.json holding their entries."""
    msp_ref = world["app"] / "Contents" / "Resources" / "C74" / "docs" / "refpages" / "msp-ref"
    # applyvalues listed twice: the profile dedupes it.
    (msp_ref / "mc.fake~.maxref.xml").write_text(
        _mcwrapper_refpage(
            "mc.fake~", ["applyvalues", "setvalue", "ease.linear", "applyvalues"], ["chans", "fun"]
        )
    )
    (msp_ref / "mc.native~.maxref.xml").write_text(_mcwrapper_refpage("mc.native~", None, None))
    (msp_ref / "mc.empty~.maxref.xml").write_text(_mcwrapper_refpage("mc.empty~", [], []))
    mc_dir = world["db_root"] / "mc"
    mc_dir.mkdir(parents=True, exist_ok=True)
    entries = {n: _entry(n, "MC", "msp") for n in ("mc.fake~", "mc.native~", "mc.empty~")}
    (mc_dir / "objects.json").write_text(
        json.dumps(entries, indent=2, ensure_ascii=False) + "\n", encoding="utf-8"
    )


def _canonical(data: dict) -> bytes:
    return (json.dumps(data, indent=2, sort_keys=True, ensure_ascii=False) + "\n").encode("utf-8")


class TestGroups:
    """C8 / Q14: inherited group names land in groups.json, merged at call time."""

    def test_mc_wrapper_messages_end_to_end(self, world: dict) -> None:
        """Tracer: refpage <mcwrapper> -> --apply groups -> groups.json -> messages().

        pending_names is, summed over members, the member's effective names
        (profile messages + attributes) minus those groups.json already
        records: here mc.fake~'s applyvalues, ease.linear, setvalue, chans and
        fun, none recorded yet.
        """
        from src.maxpat.db_lookup import ObjectDatabase

        _add_groups_fixtures(world)
        db_root = world["db_root"]
        before = _tree_bytes(db_root)
        assert _run(world) == 0
        assert _tree_bytes(db_root) == before

        section = _report(world)["groups"]
        assert section["available"] is True
        assert section["members"] == 1
        assert section["by_family"] == {"mc": 1}
        assert section["pending_members"] == 1
        assert section["pending_names"] == 5

        assert _run(world, "--apply", "groups") == 0
        after = _tree_bytes(db_root)
        assert set(after) - set(before) == {"groups.json"}
        assert all(after[k] == before[k] for k in before)
        raw = (db_root / "groups.json").read_bytes()
        data = json.loads(raw)
        assert raw == _canonical(data)
        assert list(data["members"]) == ["mc.fake~"]
        (profile_id,) = data["members"]["mc.fake~"]
        assert profile_id.startswith("mc-") and len(profile_id) == len("mc-") + 8

        db = ObjectDatabase(db_root)
        assert db.messages("mc.fake~") == ["bang", "applyvalues", "ease.linear", "setvalue"]
        assert db.messages("mc.native~") == ["bang"]
        assert db.messages("mc.empty~") == ["bang"]
        assert db.lookup("mc.fake~")["messages"] == ["bang"]

        assert _run(world, "--apply", "groups") == 0
        assert _tree_bytes(db_root) == after
        assert _report(world)["groups"]["pending_names"] == 0

    def test_section_order_keeps_ui_maxclasses_last(self) -> None:
        keys = sync.SECTION_KEYS
        assert "groups" in keys
        assert keys[keys.index("inherited_attributes") + 1] == "groups"
        assert keys[-1] == "ui_maxclasses"

    def test_jitter_profile_and_attribute_definitions(self, world: dict) -> None:
        from src.maxpat.db_lookup import ObjectDatabase

        _add_group_fixtures(world)
        jit_old = (
            world["app"] / "Contents" / "Resources" / "C74" / "docs" / "refpages" / "jit-ref"
            / "jit.old.maxref.xml"
        )
        methods = (
            "  <jittermethodlist>\n"
            '    <jittermethod name="bang" />\n'
            '    <jittermethod name="getattributes" />\n'
            '    <jittermethod name="exportsummary" />\n'
            "  </jittermethodlist>\n</c74object>\n"
        )
        jit_old.write_text(jit_old.read_text().replace("</c74object>\n", methods))

        section = _report(world)["groups"]
        assert section["undefined_attributes"] == ["nowhere"]
        assert section["ambiguous_attributes"] == ["blend"]
        assert section["by_family"] == {"jit": 1}

        assert _run(world, "--apply", "groups") == 0
        data = _load(world, "groups.json")
        (pid,) = data["members"]["jit.old"]
        assert pid.startswith("jit-")
        profile = data["profiles"][pid]
        assert profile["family"] == "jit"
        assert profile["messages"] == ["bang", "exportsummary", "getattributes"]
        assert profile["attributes"] == ["alpha_mode", "blend", "nowhere"]
        assert data["attribute_definitions"] == {
            "alpha_mode": {
                "definition": {"type": "int", "get": True, "set": True},
                "source": "docs/refpages/jit-ref/jit.group-fake.maxref.xml",
            }
        }

        db = ObjectDatabase(world["db_root"])
        attributes = db.attributes("jit.old")
        assert attributes == {"alpha_mode": {"type": "int", "get": True, "set": True}}
        assert {"bang", "exportsummary", "getattributes", "alpha_mode", "blend", "nowhere"} <= (
            db.selectors("jit.old")
        )

    def test_thispatcher_profile_from_help_patch(self, world: dict) -> None:
        from src.maxpat.db_lookup import ObjectDatabase

        path = world["db_root"] / "max" / "objects.json"
        data = json.loads(path.read_text(encoding="utf-8"))
        data["thispatcher"] = _entry("thispatcher", "Max", "max", messages=["anything"])
        path.write_text(json.dumps(data, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")

        def box(bid: str, maxclass: str, text: str, patcher: dict | None = None) -> dict:
            inner = {"box": {"id": bid, "maxclass": maxclass, "text": text, "numinlets": 1, "numoutlets": 1}}
            if patcher is not None:
                inner["box"]["patcher"] = patcher
            return inner

        def line(src: str, dst: str) -> dict:
            return {"patchline": {"source": [src, 0], "destination": [dst, 0]}}

        sub = {
            "boxes": [box("obj-1", "newobj", "thispatcher"), box("obj-2", "message", "dirty")],
            "lines": [line("obj-2", "obj-1")],
        }
        help_patch = {
            "patcher": {
                "boxes": [
                    box("obj-1", "newobj", "thispatcher"),
                    box("obj-2", "message", "script newobject toggle, script hide foo"),
                    box("obj-3", "message", "wclose"),
                    box("obj-4", "newobj", "prepend write"),
                    box("obj-5", "message", "; pd dsp 1"),
                    box("obj-6", "message", "$1 2"),
                    box("obj-7", "message", "front"),
                    box("obj-8", "newobj", "t l"),
                    box("obj-9", "newobj", "t l"),
                    box("obj-10", "newobj", "t l"),
                    box("obj-11", "newobj", "p sub", patcher=sub),
                ],
                "lines": [
                    line("obj-2", "obj-1"),
                    line("obj-3", "obj-1"),
                    line("obj-4", "obj-1"),
                    line("obj-5", "obj-1"),
                    line("obj-6", "obj-1"),
                    line("obj-7", "obj-8"),
                    line("obj-8", "obj-9"),
                    line("obj-9", "obj-10"),
                    line("obj-10", "obj-1"),
                ],
            }
        }
        help_max = world["app"] / "Contents" / "Resources" / "C74" / "help" / "max"
        help_max.mkdir(parents=True)
        (help_max / "thispatcher.maxhelp").write_text(json.dumps(help_patch))

        section = _report(world)["groups"]
        assert section["thispatcher_source"] == "help/max/thispatcher.maxhelp"
        assert _run(world, "--apply", "groups") == 0
        groups = _load(world, "groups.json")
        assert groups["members"]["thispatcher"] == ["thispatcher-help"]
        profile = groups["profiles"]["thispatcher-help"]
        assert profile["messages"] == ["dirty", "script", "wclose", "write"]
        assert profile["attributes"] == []
        assert profile["source"] == "help/max/thispatcher.maxhelp"
        assert ObjectDatabase(world["db_root"]).messages("thispatcher") == [
            "anything", "dirty", "script", "wclose", "write",
        ]

    def _applied(self, world: dict) -> tuple[Path, bytes, dict]:
        _add_groups_fixtures(world)
        _add_group_fixtures(world)
        assert _run(world, "--apply", "groups") == 0
        path = world["db_root"] / "groups.json"
        raw = path.read_bytes()
        return path, raw, json.loads(raw)

    def test_groups_writer_refuses_member_removal(self, world: dict) -> None:
        path, raw, data = self._applied(world)
        del data["members"]["mc.fake~"]
        with pytest.raises(sync.AdditiveViolation, match="removed"):
            sync.write_groups_file(path, data, world["db_root"])
        assert path.read_bytes() == raw

    def test_groups_writer_refuses_name_loss(self, world: dict) -> None:
        path, raw, data = self._applied(world)
        (pid,) = data["members"]["mc.fake~"]
        shrunk = dict(data["profiles"][pid])
        shrunk["messages"] = [m for m in shrunk["messages"] if m != "setvalue"]
        data["profiles"]["mc-shrunk00"] = shrunk
        data["members"]["mc.fake~"] = ["mc-shrunk00"]
        with pytest.raises(sync.AdditiveViolation, match="setvalue"):
            sync.write_groups_file(path, data, world["db_root"])
        assert path.read_bytes() == raw

    def test_groups_writer_refuses_definition_change(self, world: dict) -> None:
        path, raw, data = self._applied(world)
        data["attribute_definitions"]["alpha_mode"]["definition"]["type"] = "float"
        with pytest.raises(sync.AdditiveViolation, match="alpha_mode"):
            sync.write_groups_file(path, data, world["db_root"])
        assert path.read_bytes() == raw

    def test_groups_writer_refuses_other_paths(self, world: dict, tmp_path: Path) -> None:
        db_root = world["db_root"]
        overrides = db_root / "overrides.json"
        before = overrides.read_bytes()
        with pytest.raises(sync.WriteRefused):
            sync.write_groups_file(overrides, {"profiles": {}, "members": {}}, db_root)
        assert overrides.read_bytes() == before
        outside = tmp_path / "elsewhere" / "groups.json"
        with pytest.raises(sync.WriteRefused):
            sync.write_groups_file(outside, {"profiles": {}, "members": {}}, db_root)
        assert not outside.exists()
        with pytest.raises(sync.WriteRefused):
            sync.write_db_file(db_root / "groups.json", {}, db_root)
        assert not (db_root / "groups.json").exists()

    def test_bundle_shrink_keeps_recorded_names(self, world: dict) -> None:
        from src.maxpat.db_lookup import ObjectDatabase

        _add_groups_fixtures(world)
        assert _run(world, "--apply", "groups") == 0
        msp_ref = world["app"] / "Contents" / "Resources" / "C74" / "docs" / "refpages" / "msp-ref"
        (msp_ref / "mc.fake~.maxref.xml").write_text(
            _mcwrapper_refpage("mc.fake~", ["applyvalues", "ease.linear"], ["chans", "fun"])
        )
        assert _run(world, "--apply", "groups") == 0
        assert "setvalue" in ObjectDatabase(world["db_root"]).messages("mc.fake~")

    def test_inherited_report_counts_groups_json_as_recorded(self, world: dict) -> None:
        _add_group_fixtures(world)
        assert _report(world)["inherited_attributes"]["by_attribute"] == {"alpha_mode": 1}
        assert _run(world, "--apply", "groups") == 0
        section = _report(world)["inherited_attributes"]
        assert section["by_attribute"] == {}
        assert section["undefined"] == {}
        before = _tree_bytes(world["db_root"])
        assert _run(world, "--apply", "inherited", "--attributes", "alpha_mode") == 0
        assert _tree_bytes(world["db_root"]) == before

    def test_doc_shaped_refpage_of_a_real_object_is_a_member(self, world: dict) -> None:
        """jit.graph / jit.plot shape: no inlet/outlet/method lists, but a DB object."""
        _add_group_fixtures(world)
        jit_ref = world["app"] / "Contents" / "Resources" / "C74" / "docs" / "refpages" / "jit-ref"
        listing = (
            "  <jitterattributelist>\n"
            '    <jitterattribute name="alpha_mode" />\n'
            "  </jitterattributelist>\n</c74object>\n"
        )
        (jit_ref / "jit.old.maxref.xml").write_text(
            _refpage("jit.old", module="jit").replace("</c74object>\n", listing)
        )
        assert _run(world, "--apply", "groups") == 0
        groups = _load(world, "groups.json")
        assert list(groups["members"]) == ["jit.old"]
        assert _report(world)["groups"]["unresolved"] == []

    def test_refresh_log_records_group_fields(self, world: dict) -> None:
        _add_groups_fixtures(world)
        assert _run(world, "--apply", "groups", "--refresh-log") == 0
        log = _load(world, "extraction-log.json")
        assert log["sync"]["group_members"] == _report(world)["groups"]["members"] == 1
        assert log["sync"]["pending_group_names"] == 0
