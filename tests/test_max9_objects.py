"""ODB-04: Validate MAX 9 objects are present in the database."""

import pytest


class TestMax9Objects:
    """MAX 9 additions (array.*, string.*, abl.*) must be in the database."""

    def test_array_concat_exists(self, object_by_name):
        """array.concat must exist in the database."""
        obj = object_by_name("array.concat")
        assert obj is not None, "array.concat not found in database"

    def test_string_contains_exists(self, object_by_name):
        """string.contains must exist in the database."""
        obj = object_by_name("string.contains")
        assert obj is not None, "string.contains not found in database"

    def test_at_least_30_array_objects(self, all_objects):
        """At least 30 array.* objects must exist."""
        array_objs = [o for o in all_objects if o["name"].startswith("array.")]
        assert len(array_objs) >= 30, (
            f"Expected >= 30 array.* objects, found {len(array_objs)}"
        )

    def test_at_least_10_string_objects(self, all_objects):
        """At least 10 string.* objects must exist."""
        string_objs = [o for o in all_objects if o["name"].startswith("string.")]
        assert len(string_objs) >= 10, (
            f"Expected >= 10 string.* objects, found {len(string_objs)}"
        )

    def test_at_least_50_abl_objects(self, all_objects):
        """At least 50 abl.* objects must exist (research says 74)."""
        abl_objs = [o for o in all_objects if o["name"].startswith("abl.")]
        assert len(abl_objs) >= 50, (
            f"Expected >= 50 abl.* objects, found {len(abl_objs)}"
        )
