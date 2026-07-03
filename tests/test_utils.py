"""Direct tests for src/maxpat/utils.py (get_box_name)."""

from src.maxpat.utils import get_box_name


class TestGetBoxName:
    def test_newobj_returns_first_word_of_text(self):
        assert get_box_name({"maxclass": "newobj", "text": "cycle~ 440"}) == "cycle~"

    def test_newobj_empty_text_returns_empty(self):
        assert get_box_name({"maxclass": "newobj", "text": ""}) == ""

    def test_newobj_missing_text_returns_empty(self):
        assert get_box_name({"maxclass": "newobj"}) == ""

    def test_ui_maxclass_returns_maxclass(self):
        assert get_box_name({"maxclass": "toggle"}) == "toggle"

    def test_missing_maxclass_returns_empty(self):
        assert get_box_name({}) == ""
