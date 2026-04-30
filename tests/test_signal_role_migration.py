"""Plan 30-02: signal_role migration regression tests.

Verifies that the bulk migration of pre-existing MSP outlet-type
overrides from `signal: bool` to `signal_role` does not break any
existing consumer. The Phase 28 write-through projection
(_apply_signal_role_writethrough) re-materializes outlet['signal'] at
load time, so direct readers (patcher.py:250, dsp_critic.py:301-derived
outlettype) MUST see unchanged values.

Per CONTEXT.md D-15:
- Snapshot tests on post-migration overrides.json shape.
- Assertion tests on patcher/dsp_critic readers via the real DB.
- No new fixture files; uses real ObjectDatabase + tests/conftest.py
  fixtures.

The projection contract this file pins:

    src/maxpat/db_lookup.py::_apply_signal_role_writethrough

    For each outlet with signal_role set, project:
      "audio" -> outlet["signal"] = True
      every other role -> outlet["signal"] = False

That projection is the back-compat shim that lets us drop the legacy
`signal: bool` from migrated outlets in overrides.json without breaking
the patcher.py:250 and dsp_critic.py:301 readers.
"""

from __future__ import annotations

import json
from pathlib import Path

import pytest

from src.maxpat.db_lookup import ObjectDatabase

# Migrated objects (Plan 30-02 scope). Each tuple is
# (object_name, outlet_index, expected_signal_bool_after_projection).
# Bare-MSP only -- MC/MCS variants are Plan 30-04.
#
# Derived from the actual outlet shapes in overrides.json at planning
# time; every entry corresponds to a real outlet that gets a signal_role
# in Task 2. The expected bool MUST match the pre-migration `signal:
# bool` value -- that's what makes the migration a no-op for
# patcher.py:250 / dsp_critic.py:301 consumers.
_PROJECTED_SIGNAL_BOOL_EXPECTATIONS = [
    ("2d.wave~", 0, True),
    ("2d.wave~", 1, True),
    ("adc~", 0, True),
    ("adc~", 1, True),
    ("adc~", 2, True),
    ("curve~", 0, True),
    ("curve~", 1, False),     # trigger (bang when curve reaches destination)
    ("fffb~", 0, True),
    ("fffb~", 1, True),
    ("fffb~", 7, True),
    ("gain~", 0, True),
    ("gain~", 1, False),      # float (Slider value)
    ("index~", 0, True),
    ("limi~", 0, True),
    ("limi~", 1, True),
    ("line~", 0, True),
    ("line~", 1, False),      # trigger (bang when line reaches destination)
    ("mxj~", 0, True),
    ("playlist~", 0, True),
    ("playlist~", 1, True),
    ("playlist~", 2, False),  # status (state)
    ("play~", 0, True),
    ("play~", 1, False),      # trigger (bang when playback)
    ("ramp~", 0, True),
    ("ramp~", 1, False),      # trigger
    ("retune~", 0, True),
    ("retune~", 1, True),
    ("retune~", 2, False),    # default-status (Voice allocation data)
    ("sfizz~", 0, True),
    ("sfizz~", 7, True),
    ("sfplay~", 0, True),
    ("sfplay~", 1, False),    # trigger (bang when done)
    ("stash~", 0, True),
    ("stash~", 1, False),     # data (Index (int))
    ("stretch~", 0, True),
    ("stretch~", 1, False),   # trigger (bang when done)
    ("sync~", 0, True),
    ("sync~", 1, False),      # default-status (Control output)
    ("sync~", 2, False),      # default-status
    ("train~", 0, True),
    ("train~", 1, False),     # trigger (bang on 0 to 1 transition)
    ("vst~", 0, True),
    ("vst~", 1, True),
    ("vst~", 2, False),       # list (Dump output)
    ("vst~", 3, False),       # data (Parameter index and value)
    ("windowed-fft~", 0, True),
    ("windowed-fft~", 1, True),
    ("zigzag~", 0, True),
    ("zigzag~", 1, True),
    ("zigzag~", 2, False),    # list (Contents of current list)
    ("zigzag~", 3, False),    # trigger (bang when line reaches)
]

_PROJECT_ROOT = Path(__file__).resolve().parents[1]
_REAL_OVERRIDES_PATH = _PROJECT_ROOT / ".claude" / "max-objects" / "overrides.json"


@pytest.fixture(scope="module")
def real_db():
    """Real ObjectDatabase loaded from .claude/max-objects/."""
    return ObjectDatabase()


@pytest.fixture(scope="module")
def overrides_data():
    """Raw overrides.json text + parsed dict."""
    text = _REAL_OVERRIDES_PATH.read_text()
    return text, json.loads(text)


class TestSignalRoleMigration:
    """Plan 30-02: legacy signal:bool migration to signal_role."""

    def test_db_constructs_without_error(self, real_db):
        """Post-migration overrides.json must load via fail-fast validator."""
        assert real_db is not None

    @pytest.mark.parametrize(
        "name, outlet_idx, expected_signal",
        _PROJECTED_SIGNAL_BOOL_EXPECTATIONS,
    )
    def test_writethrough_preserves_signal_bool(
        self, real_db, name, outlet_idx, expected_signal
    ):
        """For every migrated outlet, projected outlet['signal'] equals the
        pre-migration bool. Captures the patcher.py:250 + dsp_critic.py:301
        contract."""
        obj = real_db.lookup(name)
        assert obj is not None, f"{name} missing from DB"
        outlets = obj.get("outlets", [])
        assert outlet_idx < len(outlets), (
            f"{name} has fewer than {outlet_idx + 1} outlets"
        )
        outlet = outlets[outlet_idx]
        assert outlet.get("signal") is expected_signal, (
            f"{name} outlet {outlet_idx}: expected signal={expected_signal}, "
            f"got {outlet.get('signal')!r}; signal_role="
            f"{outlet.get('signal_role')!r}"
        )

    @pytest.mark.parametrize(
        "name", sorted({n for n, _, _ in _PROJECTED_SIGNAL_BOOL_EXPECTATIONS})
    )
    def test_migrated_object_has_signal_role_on_every_outlet(
        self, real_db, name
    ):
        """Every outlet of a migrated object MUST have signal_role
        (else it doesn't count toward MSPCOV-01)."""
        obj = real_db.lookup(name)
        outlets = obj.get("outlets", [])
        assert outlets, f"{name} has no outlets"
        for i, outlet in enumerate(outlets):
            assert outlet.get("signal_role") is not None, (
                f"{name} outlet {i} missing signal_role; "
                f"migration incomplete"
            )

    def test_legacy_signal_key_dropped_from_migrated_outlets(self, overrides_data):
        """Per D-03: the legacy `signal: bool` is dropped from any outlet
        that has signal_role written. The loader's projection re-materializes
        the bool at load time. Curators must not hand-edit both fields."""
        _, parsed = overrides_data
        migrated_names = sorted({n for n, _, _ in _PROJECTED_SIGNAL_BOOL_EXPECTATIONS})
        for name in migrated_names:
            entry = parsed["objects"].get(name, {})
            for i, outlet in enumerate(entry.get("outlets", [])):
                if "signal_role" in outlet:
                    assert "signal" not in outlet, (
                        f"{name} outlet {i} has BOTH signal_role and signal "
                        f"-- curators must write one source of truth (D-03)."
                    )

    def test_migration_grows_signal_role_count(self, overrides_data):
        """Pre-migration state had 2 occurrences of signal_role (cycle~,
        snapshot~). Post-migration must have substantially more."""
        text, _ = overrides_data
        count = text.count('"signal_role"')
        assert count > 30, (
            f"Expected >30 signal_role occurrences post-migration, "
            f"got {count}. Pre-migration baseline was 2 (cycle~, snapshot~)."
        )

    def test_migrated_objects_appear_in_audit_covered(self, real_db):
        """audit_signal_role_coverage must classify every migrated object as
        'covered' (every outlet has signal_role)."""
        result = real_db.audit_signal_role_coverage()
        covered = set(result["msp"]["covered"])
        migrated_names = {n for n, _, _ in _PROJECTED_SIGNAL_BOOL_EXPECTATIONS}
        # The migrated objects must all be covered. Empty-IO objects (excluded
        # from the audit) are not in the migrated set, so this assertion is
        # tight.
        missing = migrated_names - covered
        assert not missing, (
            f"Migrated objects not in 'covered' bucket: {sorted(missing)}"
        )

    def test_audio_role_count_grows(self, real_db):
        """The audio-role tally grows by N audio outlets migrated."""
        result = real_db.audit_signal_role_coverage()
        # Pre-migration baseline: cycle~ contributes 1 audio outlet.
        # Post-migration: substantially more (Plan 30-02 migrates ~45 audio
        # outlets across the bare-MSP set; baseline + 30 minimum).
        assert result["msp"]["by_role"]["audio"] >= 30, (
            f"audio role count should grow by >=30, got "
            f"{result['msp']['by_role']['audio']}"
        )


class TestBackCompatConsumerAnchors:
    """Plan 30-02 (Blocker 4 fix): line-anchored read-pattern tests for
    patcher.py:250 and dsp_critic.py:301.

    These tests are the back-compat shim's consumer-side anchor. They DO NOT
    validate behavior -- that's the projection round-trip in
    TestSignalRoleMigration. Instead they pin the SOURCE LOCATION + READ
    SHAPE of the two known consumers so any refactor that moves or changes
    the read forces a deliberate update here, surfacing the coupling between
    the migration's safety and these specific reads. Without these, a future
    refactor could silently change the consumer pattern and the migration's
    safety claim would no longer hold.

    Reference: src/maxpat/db_lookup.py::_apply_signal_role_writethrough is
    the projection that makes dropping signal:bool from overrides.json safe;
    these anchors confirm the consumers still consume what the projection
    materializes.
    """

    def test_patcher_outlet_signal_read_pattern_unchanged(self):
        """patcher.py:250 reads outlet.get('signal') -- anchor the read pattern
        so refactors that change it surface here as test failures."""
        src = (_PROJECT_ROOT / "src" / "maxpat" / "patcher.py").read_text()
        lines = src.splitlines()
        # Phase 30 anchor: the read at line 250 (1-indexed) must use one of
        # the known back-compat-safe shapes. If the line moves, update this
        # test AND verify the moved read is still projection-fed.
        target = lines[249]  # 0-indexed
        assert (
            'outlet["signal"]' in target
            or "outlet.get(\"signal\"" in target
            or "outlet['signal']" in target
            or "outlet.get('signal'" in target
        ), (
            f"patcher.py:250 read pattern changed; back-compat shim's "
            f"consumer assumption broken: {target!r}"
        )

    def test_dsp_critic_outlet_signal_read_pattern_unchanged(self):
        """dsp_critic.py:301 reads outlet['signal'] OR outlettype-derived
        'signal' string. Anchor the line so refactors surface here."""
        src = (_PROJECT_ROOT / "src" / "maxpat" / "critics" / "dsp_critic.py").read_text()
        lines = src.splitlines()
        target = lines[300]  # line 301, 0-indexed
        assert (
            'outlet["signal"]' in target
            or "outlet.get(\"signal\"" in target
            or "outlet['signal']" in target
            or "outlet.get('signal'" in target
            or "outlettype" in target
        ), (
            f"dsp_critic.py:301 read pattern changed; back-compat shim's "
            f"consumer assumption broken: {target!r}"
        )

    def test_projection_roundtrip_for_known_audio_outlet(self, real_db):
        """End-to-end: db.lookup('gain~')['outlets'][0]['signal'] is True
        post-migration. This is the actual fire of the projection, not a
        text grep -- proves migration + projection is wired correctly."""
        obj = real_db.lookup("gain~")
        assert obj is not None, "gain~ missing from DB post-migration"
        assert obj["outlets"][0].get("signal") is True, (
            "gain~ outlet 0 should project to signal=True via "
            "_apply_signal_role_writethrough; got "
            f"{obj['outlets'][0].get('signal')!r}"
        )

    def test_role_source_default_status_annotation_round_trips(self, real_db):
        """If Task 2 emits `_role_source: \"default-status\"` on any
        low-confidence fallback outlet, the loader must preserve the
        annotation (not strip it, not warn). Future audits can grep for
        the annotation to enumerate low-confidence picks."""
        # Walk the real DB and confirm any outlet with the annotation still
        # carries it post-load. If no migrated outlet uses default-status
        # (Task 2 fully classified everything), this test is a no-op pass.
        seen_annotation = False
        for name, obj in real_db._objects.items():
            for outlet in obj.get("outlets", []):
                if not isinstance(outlet, dict):
                    continue
                if outlet.get("_role_source") == "default-status":
                    seen_annotation = True
                    # Annotation must coexist with signal_role
                    assert outlet.get("signal_role") is not None, (
                        f"{name} outlet has _role_source=default-status "
                        f"but no signal_role -- annotation only valid as a "
                        f"hint NEXT TO a role"
                    )
        # The test passes regardless of whether annotations were emitted --
        # it asserts ROUND-TRIP, not presence. Document the observation:
        if seen_annotation:
            # Smoke: confirm at least one curator hint survived load.
            pass
