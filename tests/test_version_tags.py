"""ODB-03: Validate version tagging on all objects."""

import pytest


class TestVersionTags:
    """Every object must have a min_version field with correct values."""

    def test_every_object_has_min_version(self, all_objects):
        """Every object must have a min_version field (int or float)."""
        for obj in all_objects:
            assert "min_version" in obj, (
                f"Missing min_version: {obj.get('name', '?')}"
            )
            assert isinstance(obj["min_version"], (int, float)), (
                f"min_version not numeric for {obj.get('name', '?')}: "
                f"{type(obj['min_version'])}"
            )

    def test_array_objects_are_max9(self, all_objects):
        """Objects starting with 'array.' must have min_version 9."""
        array_objs = [o for o in all_objects if o["name"].startswith("array.")]
        assert len(array_objs) > 0, "No array.* objects found"
        for obj in array_objs:
            assert obj["min_version"] == 9, (
                f"{obj['name']} should be min_version 9, got {obj['min_version']}"
            )

    def test_string_objects_are_max9(self, all_objects):
        """Objects starting with 'string.' must have min_version 9."""
        string_objs = [o for o in all_objects if o["name"].startswith("string.")]
        assert len(string_objs) > 0, "No string.* objects found"
        for obj in string_objs:
            assert obj["min_version"] == 9, (
                f"{obj['name']} should be min_version 9, got {obj['min_version']}"
            )

    def test_abl_objects_are_max9(self, all_objects):
        """Objects starting with 'abl.' must have min_version 9."""
        abl_objs = [o for o in all_objects if o["name"].startswith("abl.")]
        assert len(abl_objs) > 0, "No abl.* objects found"
        for obj in abl_objs:
            assert obj["min_version"] == 9, (
                f"{obj['name']} should be min_version 9, got {obj['min_version']}"
            )

    def test_mc_objects_have_version(self, all_objects):
        """MC objects (mc.*) should have min_version set."""
        mc_objs = [o for o in all_objects if o["name"].startswith("mc.")]
        assert len(mc_objs) > 0, "No mc.* objects found"
        for obj in mc_objs:
            assert isinstance(obj.get("min_version"), (int, float)), (
                f"mc object {obj['name']} missing min_version"
            )
