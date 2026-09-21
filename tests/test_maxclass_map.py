"""Direct tests for src/maxpat/maxclass_map.py.

Pins the CLAUDE.md rule that UI_MAXCLASSES (not the database's maxclass
field) is the authoritative source for which objects use their own name
as maxclass vs. "newobj" with the name in the text field.
"""

from src.maxpat.maxclass_map import UI_MAXCLASSES, is_ui_object, resolve_maxclass
from src.maxpat.patcher import Patcher

# Representative UI widgets that must resolve to their own name
UI_OBJECTS = [
    "toggle", "dial", "flonum", "multislider", "meter~", "gain~",
    "ezdac~", "live.dial", "comment", "message", "inlet", "outlet",
    # Jitter pair added by fc3aa27 (shipped with no test coverage)
    "jit.pwindow", "jit.cellblock",
    # gen~/RNBO embedded code editor, added for SF-03
    "codebox",
]

# Representative non-UI objects that must resolve to "newobj"
NEWOBJ_OBJECTS = [
    "cycle~", "pack", "route", "expr", "gen~", "click~", "trigger",
]


class TestResolveMaxclass:
    """resolve_maxclass() both branches."""

    def test_ui_objects_resolve_to_own_name(self):
        for name in UI_OBJECTS:
            assert resolve_maxclass(name) == name, name

    def test_non_ui_objects_resolve_to_newobj(self):
        for name in NEWOBJ_OBJECTS:
            assert resolve_maxclass(name) == "newobj", name


class TestIsUiObject:
    """is_ui_object() mirrors UI_MAXCLASSES membership."""

    def test_true_for_ui_widgets(self):
        for name in UI_OBJECTS:
            assert is_ui_object(name) is True, name

    def test_false_for_newobj_objects(self):
        for name in NEWOBJ_OBJECTS:
            assert is_ui_object(name) is False, name

    def test_mirrors_set_membership(self):
        assert is_ui_object("toggle") == ("toggle" in UI_MAXCLASSES)
        assert is_ui_object("cycle~") == ("cycle~" in UI_MAXCLASSES)


class TestUIMaxclassesInvariants:
    """Structural invariants of the UI_MAXCLASSES constant."""

    def test_is_frozenset(self):
        assert isinstance(UI_MAXCLASSES, frozenset)

    def test_newobj_not_a_member(self):
        assert "newobj" not in UI_MAXCLASSES

    def test_entries_are_clean_lowercase_strings(self):
        for entry in UI_MAXCLASSES:
            assert isinstance(entry, str)
            assert entry, "empty entry in UI_MAXCLASSES"
            assert entry == entry.strip(), f"whitespace in entry: {entry!r}"
            assert entry == entry.lower(), f"non-lowercase entry: {entry!r}"


class TestCommittedPatchProvenance:
    """Entries admitted on committed-patch evidence, with that evidence named.

    UI_MAXCLASSES entries are normally derived from 02-RESEARCH.md Pattern 7.
    These entries were instead admitted because a committed patch that MAX
    itself wrote carries the object's own name in the maxclass field. The
    discriminator is ``patcher.appversion.revision``: this repo's generator
    hardcodes ``0`` (src/maxpat/defaults.py), so a non-zero revision means
    MAX wrote or re-saved the file. Each claim below names the confirming
    patch, its appversion, and the commit that introduced it, so a future
    audit can re-derive the claim without re-running the investigation.
    """

    def test_codebox_is_a_ui_maxclass(self):
        """SF-03: ``codebox`` carries its own maxclass in the MAX-saved form.

        Confirming evidence (review finding SF-03, quick task 260921-ima):

        - ``patches/kicksynth/generated/kicksynth.maxpat`` at commit
          ``02c9917`` ("MAX-side envelope + preset edits"),
          ``appversion`` 9.1.5 (revision 5, therefore MAX-written).
          Inside its gen~ patcher the codebox box is
          ``{"maxclass": "codebox", ...}`` with **no** ``text`` field,
          while its ``in 1`` / ``out 1`` siblings in the same patcher use
          ``maxclass: "newobj"`` with the name in ``text``.
        - ``patches/terrain-synth/generated/terrain-synth.maxpat`` at commit
          ``55757e0`` ("MAX re-save of v0.9.0"), ``appversion`` 9.1.5,
          carries four codebox boxes in the same form.

        19 of the 26 committed codebox-bearing ``.maxpat`` files satisfy the
        non-zero-revision discriminator; all 26 agree on the form.
        """
        assert resolve_maxclass("codebox") == "codebox"
        assert is_ui_object("codebox") is True
        assert "codebox" in UI_MAXCLASSES

    def test_jitter_pair_is_a_ui_maxclass(self):
        """The ``fc3aa27`` pair, which shipped with no test at all.

        ``fc3aa27`` ("fix(maxclass): jit.pwindow / jit.cellblock are UI
        maxclasses (MAX re-save form); terrain-synth window rect restored")
        added both entries to ``UI_MAXCLASSES`` and nothing else -- no test
        and no recorded provenance, which is the same gap that let SF-03
        stay open. Confirming evidence is the terrain-synth v0.3-v0.4 MAX
        re-saves cited in the source comment (e.g. commit ``174840c``,
        "user's MAX re-save, v0.4.1 confirmed working").
        """
        for name in ("jit.pwindow", "jit.cellblock"):
            assert resolve_maxclass(name) == name, name
            assert is_ui_object(name) is True, name
            assert name in UI_MAXCLASSES, name

    def test_gen_container_still_resolves_to_newobj(self):
        """The codebox entry must not perturb its gen~ container.

        A codebox only ever appears inside a gen~/rnbo~ embedded patcher.
        ``gen~`` itself is a newobj and is pinned by
        tests/test_codegen.py::test_gen_box_is_newobj; assert it here too so
        a future UI_MAXCLASSES edit that overreaches fails in this file.
        """
        assert resolve_maxclass("gen~") == "newobj"
        assert is_ui_object("gen~") is False
        assert resolve_maxclass("rnbo~") == "newobj"


class TestPatcherConsistency:
    """Patcher.add_box honors UI_MAXCLASSES for maxclass resolution."""

    def test_ui_object_uses_own_maxclass(self):
        """A UI widget box serializes with maxclass == its own name."""
        p = Patcher()
        box = p.add_box("toggle")
        assert box.maxclass == "toggle"
        d = box.to_dict()["box"]
        assert d["maxclass"] == "toggle"
        # UI widgets carry no object-name text field
        assert "text" not in d

    def test_non_ui_object_uses_newobj_with_text(self):
        """A non-UI object serializes as newobj with the name in text."""
        p = Patcher()
        box = p.add_box("cycle~", args=["440"])
        assert box.maxclass == "newobj"
        d = box.to_dict()["box"]
        assert d["maxclass"] == "newobj"
        assert d["text"].split()[0] == "cycle~"
