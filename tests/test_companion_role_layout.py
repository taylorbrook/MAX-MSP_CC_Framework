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
        """D-14: six keys exactly."""
        assert set(_ROLE_COMPANION_MAP.keys()) == {
            "audio", "status", "trigger", "float", "data", "list",
        }

    def test_role_map_audio_meter(self):
        """D-14: audio -> meter~ on the right."""
        assert _ROLE_COMPANION_MAP["audio"]["companion"] == "meter~"
        assert _ROLE_COMPANION_MAP["audio"]["placement"] == "right"

    def test_role_map_status_overlay(self):
        """D-14: status -> flonum overlay."""
        assert _ROLE_COMPANION_MAP["status"]["companion"] == "flonum"
        assert _ROLE_COMPANION_MAP["status"]["placement"] == "overlay"

    def test_role_map_trigger_no_companion(self):
        """D-14: trigger has no auto-companion."""
        assert _ROLE_COMPANION_MAP["trigger"]["companion"] is None
        assert _ROLE_COMPANION_MAP["trigger"]["placement"] is None

    @pytest.mark.parametrize("role", ["float", "data", "list"])
    def test_role_map_no_companion_roles(self, role):
        """D-14: float/data/list have no auto-companion."""
        assert _ROLE_COMPANION_MAP[role]["companion"] is None
        assert _ROLE_COMPANION_MAP[role]["placement"] is None

    def test_audio_role_places_meter_right_of_source(self):
        """Integration: cycle~ (audio outlet) -> meter~ ends up to the right.

        cycle~ outlet 0 is role-stamped `audio` in Phase 30 overrides;
        the role map maps `audio` -> companion meter~ with placement "right".
        """
        p = Patcher()
        src = p.add_box("cycle~", ["440"])
        sink = p.add_box("meter~")
        p.add_connection(src, 0, sink, 0)
        apply_layout(p)
        # meter~ should be to the right of cycle~ (role map: audio -> meter~ right)
        assert sink.patching_rect[0] > src.patching_rect[0]
        # And placed near the right edge of the source (gap is _COMPANION_GAP).
        gap = sink.patching_rect[0] - (
            src.patching_rect[0] + src.patching_rect[2]
        )
        assert 0 <= gap < 50, (
            f"meter~ companion should be ~_COMPANION_GAP={_COMPANION_GAP}px "
            f"to the right of cycle~ source, got gap={gap}"
        )

    def test_role_path_hit_for_audio(self):
        """`_identify_companions` with db=p.db claims meter~ via role pass."""
        p = Patcher()
        src = p.add_box("cycle~", ["440"])
        sink = p.add_box("meter~")
        p.add_connection(src, 0, sink, 0)
        # Direct call into _identify_companions with db threaded through
        result = _identify_companions(
            list(p.boxes), list(p.lines), [], db=p.db,
        )
        assert sink.id in result
        assert result[sink.id] is src

    def test_unaudited_role_falls_through_to_heuristic(self):
        """D-13: when db is None, legacy `_COMPANION_NAMES` still places meter~.

        Passing db=None exercises the same fall-through path as an unaudited
        outlet whose `get_signal_role` returns None: Pass A is skipped
        entirely, and Pass B (legacy) catches meter~ by name.
        """
        p = Patcher()
        src = p.add_box("cycle~", ["440"])
        sink = p.add_box("meter~")
        p.add_connection(src, 0, sink, 0)
        result = _identify_companions(
            list(p.boxes), list(p.lines), [], db=None,
        )
        assert sink.id in result, (
            "Legacy _COMPANION_NAMES heuristic must fire when role pass "
            "is bypassed (D-13 fall-through)"
        )

    def test_subpatcher_recursion_companion_placed(self):
        """Pitfall 3: companion placement fires inside subpatchers.

        `add_subpatcher` creates `inner = Patcher(db=self.db, ...)` so the
        recursive `apply_layout(box._inner_patcher, options)` call carries
        db through automatically.
        """
        p = Patcher()
        sp_box, inner = p.add_subpatcher("audio_chain", inlets=0, outlets=0)
        src = inner.add_box("cycle~", ["440"])
        sink = inner.add_box("meter~")
        inner.add_connection(src, 0, sink, 0)
        apply_layout(p)
        # Companion should be placed (role-driven) inside the subpatcher
        assert sink.patching_rect[0] > src.patching_rect[0]

    def test_db_none_uses_only_legacy_heuristic(self):
        """Back-compat: callers without db must still work."""
        p = Patcher()
        src = p.add_box("cycle~", ["440"])
        sink = p.add_box("meter~")
        p.add_connection(src, 0, sink, 0)
        # Should not raise
        result = _identify_companions(
            list(p.boxes), list(p.lines), [], db=None,
        )
        # meter~ is in _COMPANION_NAMES so heuristic still works
        assert sink.id in result
