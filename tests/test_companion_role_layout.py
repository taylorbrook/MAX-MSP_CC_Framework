"""Integration tests for role-driven companion-pair dispatch (Phase 31 LAYOUT-03).

Covers D-11..D-14:
- D-11: Lazy companion placement at apply_layout time (no auto-creation).
- D-12: Role->companion mapping lives as `_ROLE_COMPANION_MAP` constant in
  layout.py (no per-object companion_hint in overrides.json).
- D-13: Augment-don't-replace -- legacy `_COMPANION_NAMES` heuristic remains
  the fall-through for outlets where db.get_signal_role returns None.
- D-14: Six-key role map exactly: audio->meter~/right, status->flonum/overlay,
  trigger/float/data/list -> None.

Source-of-audio for tests: `cycle~` outlet 0 has signal_role: "audio" curated
in `.claude/max-objects/overrides.json` (Phase 28 D-01 canonical fixture).
"""

import pytest

from src.maxpat.patcher import Patcher
from src.maxpat.layout import (
    apply_layout,
    _ROLE_COMPANION_MAP,
    _identify_companions,
    _COMPANION_GAP,
)


class TestRoleDrivenCompanions:
    """Role-first dispatch with fall-through to legacy `_COMPANION_NAMES`."""

    def test_role_companion_map_shape(self):
        pytest.skip("Wave 0 stub -- implementation lands in task 1")

    def test_role_map_audio_meter(self):
        pytest.skip("Wave 0 stub -- implementation lands in task 1")

    def test_role_map_status_overlay(self):
        pytest.skip("Wave 0 stub -- implementation lands in task 1")

    def test_role_map_trigger_no_companion(self):
        pytest.skip("Wave 0 stub -- implementation lands in task 1")

    @pytest.mark.parametrize("role", ["float", "data", "list"])
    def test_role_map_no_companion_roles(self, role):
        pytest.skip("Wave 0 stub -- implementation lands in task 1")

    def test_audio_role_places_meter_right_of_source(self):
        pytest.skip("Wave 0 stub -- implementation lands in task 1")

    def test_role_path_hit_for_audio(self):
        pytest.skip("Wave 0 stub -- implementation lands in task 1")

    def test_unaudited_role_falls_through_to_heuristic(self):
        pytest.skip("Wave 0 stub -- implementation lands in task 1")

    def test_subpatcher_recursion_companion_placed(self):
        pytest.skip("Wave 0 stub -- implementation lands in task 1")

    def test_db_none_uses_only_legacy_heuristic(self):
        pytest.skip("Wave 0 stub -- implementation lands in task 1")
