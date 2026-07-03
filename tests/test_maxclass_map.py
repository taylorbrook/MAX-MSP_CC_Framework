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
