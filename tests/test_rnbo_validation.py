"""Smoke tests for src/maxpat/rnbo_validation.py."""

import pytest

from src.maxpat.rnbo import RNBODatabase
from src.maxpat.rnbo_validation import (
    RNBO_TARGET_CONSTRAINTS,
    validate_rnbo_patch,
)


@pytest.fixture(scope="module")
def rnbo_db() -> RNBODatabase:
    return RNBODatabase()


def _patch_with_boxes(boxes: list[dict]) -> dict:
    return {"patcher": {"boxes": [{"box": b} for b in boxes], "lines": []}}


class TestValidateRnboPatch:
    def test_compatible_patch_has_no_object_errors(self, rnbo_db):
        patch = _patch_with_boxes([
            {"maxclass": "newobj", "text": "cycle~ 440"},
        ])
        results = validate_rnbo_patch(patch, target="plugin", rnbo_db=rnbo_db)
        object_errors = [
            r for r in results
            if r.layer == "rnbo-objects" and r.level == "error"
        ]
        assert object_errors == []

    def test_unknown_object_flagged_as_error(self, rnbo_db):
        patch = _patch_with_boxes([
            {"maxclass": "newobj", "text": "zzz_not_a_real_object 1"},
        ])
        results = validate_rnbo_patch(patch, target="plugin", rnbo_db=rnbo_db)
        object_errors = [
            r for r in results
            if r.layer == "rnbo-objects" and r.level == "error"
        ]
        assert len(object_errors) == 1
        assert "zzz_not_a_real_object" in object_errors[0].message

    def test_unknown_target_flagged(self, rnbo_db):
        patch = _patch_with_boxes([])
        results = validate_rnbo_patch(patch, target="bogus", rnbo_db=rnbo_db)
        target_errors = [
            r for r in results
            if r.layer == "rnbo-target" and r.level == "error"
        ]
        assert len(target_errors) == 1
        assert "bogus" in target_errors[0].message

    def test_external_file_reference_flagged(self, rnbo_db):
        patch = _patch_with_boxes([
            {"maxclass": "newobj", "text": "buffer~ mybuf @file kick.wav"},
        ])
        results = validate_rnbo_patch(patch, target="plugin", rnbo_db=rnbo_db)
        contained_errors = [
            r for r in results
            if r.layer == "rnbo-contained" and r.level == "error"
        ]
        assert len(contained_errors) == 1
        assert "self-contained" in contained_errors[0].message


class TestTargetConstraints:
    def test_contains_three_targets(self):
        assert set(RNBO_TARGET_CONSTRAINTS) == {"plugin", "web", "cpp"}

    def test_cpp_target_disallows_buffers(self):
        assert RNBO_TARGET_CONSTRAINTS["cpp"]["buffer_allowed"] is False
        assert RNBO_TARGET_CONSTRAINTS["cpp"]["max_params"] == 128
