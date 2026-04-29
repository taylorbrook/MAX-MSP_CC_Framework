"""Tests for the multi-layer validation pipeline.

Covers requirements:
  PAT-04: Connection validation checks outlet/inlet index bounds
  PAT-05: Connection validation enforces signal/control type matching
  PAT-08: Multi-layer validation pipeline (JSON, objects, connections, domain)
"""

import pytest

from src.maxpat.validation import validate_patch, ValidationResult, has_blocking_errors
from src.maxpat.patcher import Patcher
from src.maxpat.db_lookup import ObjectDatabase


@pytest.fixture(scope="module")
def db():
    """Shared ObjectDatabase for all tests in this module."""
    return ObjectDatabase()


# ---------------------------------------------------------------------------
# Helper: build a minimal valid patch dict
# ---------------------------------------------------------------------------
def _make_patch_dict(boxes=None, lines=None):
    """Return a minimal valid .maxpat-style dict for testing."""
    return {
        "patcher": {
            "boxes": boxes or [],
            "lines": lines or [],
        }
    }


def _make_box(box_id, maxclass="newobj", text="cycle~ 440",
              numinlets=2, numoutlets=1, outlettype=None):
    """Return a minimal box entry for testing."""
    return {
        "box": {
            "maxclass": maxclass,
            "id": box_id,
            "text": text,
            "numinlets": numinlets,
            "numoutlets": numoutlets,
            "outlettype": outlettype or ["signal"],
            "patching_rect": [0.0, 0.0, 80.0, 22.0],
        }
    }


def _make_line(source_id, source_outlet, dest_id, dest_inlet):
    """Return a minimal patchline entry for testing."""
    return {
        "patchline": {
            "source": [source_id, source_outlet],
            "destination": [dest_id, dest_inlet],
        }
    }


# ===========================================================================
# Layer 1: JSON Structure Validation
# ===========================================================================

class TestLayer1JsonStructure:
    """PAT-08: Layer 1 catches structural JSON errors."""

    def test_missing_patcher_key(self, db):
        """Missing 'patcher' key is a structural error."""
        results = validate_patch({"not_patcher": {}}, db=db)
        assert any(r.layer == "json" and r.level == "error" for r in results)

    def test_missing_boxes_array(self, db):
        """Missing 'boxes' array inside patcher is a structural error."""
        results = validate_patch({"patcher": {"lines": []}}, db=db)
        assert any(r.layer == "json" and r.level == "error" for r in results)

    def test_missing_lines_array(self, db):
        """Missing 'lines' array inside patcher is a structural error."""
        results = validate_patch({"patcher": {"boxes": []}}, db=db)
        assert any(r.layer == "json" and r.level == "error" for r in results)

    def test_valid_structure_no_errors(self, db):
        """Valid structure produces no layer-1 errors."""
        patch = _make_patch_dict()
        results = validate_patch(patch, db=db)
        layer1 = [r for r in results if r.layer == "json" and r.level == "error"]
        assert layer1 == []

    def test_structural_error_stops_early(self, db):
        """Layer 1 errors prevent subsequent layers from running."""
        results = validate_patch({"not_patcher": {}}, db=db)
        layers_seen = {r.layer for r in results}
        assert "json" in layers_seen
        # Other layers should NOT have run
        assert "objects" not in layers_seen
        assert "connections" not in layers_seen
        assert "domain" not in layers_seen


# ===========================================================================
# Layer 2: Object Existence Validation
# ===========================================================================

class TestLayer2ObjectExistence:
    """PAT-08: Layer 2 catches non-existent and PD objects."""

    def test_valid_object_passes(self, db):
        """Known object (cycle~) produces no error."""
        patch = _make_patch_dict(boxes=[_make_box("obj-1", text="cycle~ 440")])
        results = validate_patch(patch, db=db)
        obj_errors = [r for r in results if r.layer == "objects" and r.level == "error"]
        assert obj_errors == []

    def test_unknown_object_warning(self, db):
        """Completely unknown object produces a warning (not error)."""
        patch = _make_patch_dict(boxes=[
            _make_box("obj-1", text="fake_object_xyz 123")
        ])
        results = validate_patch(patch, db=db)
        obj_warnings = [r for r in results if r.layer == "objects" and r.level == "warning"]
        assert len(obj_warnings) >= 1
        assert "fake_object_xyz" in obj_warnings[0].message

    def test_unknown_object_not_blocking(self, db):
        """Patch with only unknown objects has no blocking errors."""
        patch = _make_patch_dict(boxes=[
            _make_box("obj-1", text="fake_object_xyz 123")
        ])
        results = validate_patch(patch, db=db)
        assert has_blocking_errors(results) is False

    def test_pd_object_error_with_suggestion(self, db):
        """PD object (osc~) produces error with MAX equivalent suggestion."""
        patch = _make_patch_dict(boxes=[
            _make_box("obj-1", text="osc~ 440")
        ])
        results = validate_patch(patch, db=db)
        obj_errors = [r for r in results if r.layer == "objects" and r.level == "error"]
        assert len(obj_errors) >= 1
        assert "osc~" in obj_errors[0].message
        assert "cycle~" in obj_errors[0].message

    def test_alias_passes(self, db):
        """Alias 't' (for trigger) passes existence check."""
        patch = _make_patch_dict(boxes=[
            _make_box("obj-1", text="t b i f", numinlets=1, numoutlets=3,
                       outlettype=["", "", ""])
        ])
        results = validate_patch(patch, db=db)
        obj_errors = [r for r in results if r.layer == "objects" and r.level == "error"]
        assert obj_errors == []

    def test_structural_maxclasses_skipped(self, db):
        """inlet, outlet, patcher maxclasses are not checked for existence."""
        patch = _make_patch_dict(boxes=[
            {"box": {"maxclass": "inlet", "id": "obj-1",
                     "numinlets": 0, "numoutlets": 1,
                     "outlettype": [""], "patching_rect": [0, 0, 30, 30]}},
            {"box": {"maxclass": "outlet", "id": "obj-2",
                     "numinlets": 1, "numoutlets": 0,
                     "outlettype": [], "patching_rect": [0, 0, 30, 30]}},
        ])
        results = validate_patch(patch, db=db)
        obj_errors = [r for r in results if r.layer == "objects" and r.level == "error"]
        assert obj_errors == []


# ===========================================================================
# Layer 3: Connection Validation (Bounds + Types)
# ===========================================================================

class TestLayer3ConnectionBounds:
    """PAT-04: Connection validation catches out-of-bounds indices."""

    def test_valid_connection_passes(self, db):
        """Source outlet 0 on cycle~ (1 outlet) is valid."""
        boxes = [
            _make_box("obj-1", text="cycle~ 440", numoutlets=1, outlettype=["signal"]),
            _make_box("obj-2", maxclass="ezdac~", text="ezdac~",
                       numinlets=2, numoutlets=0, outlettype=[]),
        ]
        lines = [_make_line("obj-1", 0, "obj-2", 0)]
        patch = _make_patch_dict(boxes=boxes, lines=lines)
        results = validate_patch(patch, db=db)
        conn_errors = [r for r in results
                       if r.layer == "connections" and r.level == "error"]
        assert conn_errors == []

    def test_outlet_out_of_bounds_auto_fixed(self, db):
        """Source outlet index 2 on cycle~ (1 outlet) is auto-fixed."""
        boxes = [
            _make_box("obj-1", text="cycle~ 440", numoutlets=1, outlettype=["signal"]),
            _make_box("obj-2", maxclass="ezdac~", text="ezdac~",
                       numinlets=2, numoutlets=0, outlettype=[]),
        ]
        lines = [_make_line("obj-1", 2, "obj-2", 0)]  # outlet 2 does not exist
        patch = _make_patch_dict(boxes=boxes, lines=lines)
        results = validate_patch(patch, db=db)
        fixed = [r for r in results
                 if r.layer == "connections" and r.auto_fixed]
        assert len(fixed) >= 1
        assert "outlet" in fixed[0].message.lower() or "out of bounds" in fixed[0].message.lower()

    def test_inlet_out_of_bounds_auto_fixed(self, db):
        """Dest inlet index 5 on ezdac~ (2 inlets) is auto-fixed."""
        boxes = [
            _make_box("obj-1", text="cycle~ 440", numoutlets=1, outlettype=["signal"]),
            _make_box("obj-2", maxclass="ezdac~", text="ezdac~",
                       numinlets=2, numoutlets=0, outlettype=[]),
        ]
        lines = [_make_line("obj-1", 0, "obj-2", 5)]  # inlet 5 does not exist
        patch = _make_patch_dict(boxes=boxes, lines=lines)
        results = validate_patch(patch, db=db)
        fixed = [r for r in results
                 if r.layer == "connections" and r.auto_fixed]
        assert len(fixed) >= 1
        assert "inlet" in fixed[0].message.lower() or "out of bounds" in fixed[0].message.lower()

    def test_auto_fixed_connections_removed(self, db):
        """Auto-fixed connections are removed from the patch lines."""
        boxes = [
            _make_box("obj-1", text="cycle~ 440", numoutlets=1, outlettype=["signal"]),
            _make_box("obj-2", maxclass="ezdac~", text="ezdac~",
                       numinlets=2, numoutlets=0, outlettype=[]),
        ]
        # One valid, one invalid connection
        lines = [
            _make_line("obj-1", 0, "obj-2", 0),   # valid
            _make_line("obj-1", 2, "obj-2", 0),   # invalid outlet
        ]
        patch = _make_patch_dict(boxes=boxes, lines=lines)
        results = validate_patch(patch, db=db)
        # The patch should have the invalid connection removed
        remaining_lines = patch["patcher"]["lines"]
        assert len(remaining_lines) == 1
        assert remaining_lines[0]["patchline"]["source"] == ["obj-1", 0]


class TestLayer3SignalTypes:
    """PAT-05: Signal/control type matching."""

    def test_signal_to_signal_passes(self, db):
        """Signal outlet to signal inlet passes (cycle~ -> *~)."""
        boxes = [
            _make_box("obj-1", text="cycle~ 440", numoutlets=1, outlettype=["signal"]),
            _make_box("obj-2", text="*~ 0.5", numinlets=2, numoutlets=1, outlettype=["signal"]),
        ]
        lines = [_make_line("obj-1", 0, "obj-2", 0)]
        patch = _make_patch_dict(boxes=boxes, lines=lines)
        results = validate_patch(patch, db=db)
        type_issues = [r for r in results
                       if r.layer == "connections" and "signal" in r.message.lower()
                       and r.level in ("error", "warning")]
        assert type_issues == []

    def test_signal_to_control_only_inlet_detected(self, db):
        """Signal outlet to control-only inlet is detected and auto-fixed."""
        boxes = [
            _make_box("obj-1", text="cycle~ 440", numoutlets=1, outlettype=["signal"]),
            _make_box("obj-2", text="print", numinlets=1, numoutlets=0, outlettype=[]),
        ]
        lines = [_make_line("obj-1", 0, "obj-2", 0)]
        patch = _make_patch_dict(boxes=boxes, lines=lines)
        results = validate_patch(patch, db=db)
        type_issues = [r for r in results
                       if r.layer == "connections" and r.auto_fixed
                       and "signal" in r.message.lower()]
        assert len(type_issues) >= 1

    def test_control_to_signal_inlet_passes(self, db):
        """Control outlet to signal/float inlet passes (per CLAUDE.md exception)."""
        # message -> cycle~ inlet 0 (signal/float, accepts both)
        boxes = [
            _make_box("obj-1", maxclass="message", text="440",
                       numinlets=2, numoutlets=1, outlettype=[""]),
            _make_box("obj-2", text="cycle~ 440", numinlets=2, numoutlets=1,
                       outlettype=["signal"]),
        ]
        lines = [_make_line("obj-1", 0, "obj-2", 0)]
        patch = _make_patch_dict(boxes=boxes, lines=lines)
        results = validate_patch(patch, db=db)
        type_issues = [r for r in results
                       if r.layer == "connections"
                       and r.level in ("error", "warning")
                       and "type" in r.message.lower()]
        assert type_issues == []


# ===========================================================================
# Layer 3: Role-Aware Tier Dispatch (Phase 29 / VALID-01 / D-01..D-04)
# ===========================================================================

class TestRoleAwareValidation:
    """VALID-01 / D-01..D-04 / D-19: Role-aware tier dispatch ahead of legacy
    signal:bool branch. ERROR + auto-remove for status/trigger/data/list ->
    signal-only inlets; WARNING + preserve for trigger/list -> float;
    silent fall-through for audio sources and uncurated (None) roles.

    Uses monkeypatch to control db.get_signal_role return values without
    polluting overrides.json. Production fixtures (snapshot~ float role,
    cycle~ audio role) drive the regression-anchor tests.
    """

    def _patch_with_connection(
        self,
        src_name="snapshot~",
        dst_name="*~ 0.5",
        src_outlet=0,
        dst_inlet=0,
        src_outlettype=None,
    ):
        """Build a 2-box patch with one source -> destination line.

        src_outlettype defaults to ['signal'] which sets is_signal_source=True
        in the legacy branch (so we can verify the tier dispatch overrides
        legacy auto-remove for the new role-aware paths).
        """
        boxes = [
            _make_box(
                "obj-1", text=src_name,
                numoutlets=1, outlettype=src_outlettype or ["signal"],
            ),
            _make_box(
                "obj-2", text=dst_name,
                numinlets=2, numoutlets=1, outlettype=["signal"],
            ),
        ]
        lines = [_make_line("obj-1", src_outlet, "obj-2", dst_inlet)]
        return _make_patch_dict(boxes=boxes, lines=lines)

    def test_status_to_signal_emits_use_snapshot(self, db, monkeypatch):
        """status outlet -> signal inlet: ERROR with 'use snapshot~'
        suggestion; line auto-removed."""
        monkeypatch.setattr(
            db, "get_signal_role",
            lambda name, outlet: "status" if name.startswith("status") else None
        )
        patch = self._patch_with_connection(src_name="status_src")
        results = validate_patch(patch, db=db)
        tier_errors = [
            r for r in results
            if r.layer == "connections" and r.level == "error"
            and "status outlet" in r.message and "use snapshot~" in r.message
        ]
        assert len(tier_errors) >= 1, [r.message for r in results]
        assert tier_errors[0].auto_fixed is True
        # Line auto-removed
        assert len(patch["patcher"]["lines"]) == 0

    def test_trigger_to_signal_emits_use_sig(self, db, monkeypatch):
        """trigger outlet -> signal inlet: ERROR with 'use sig~ or click~'."""
        monkeypatch.setattr(
            db, "get_signal_role",
            lambda name, outlet: "trigger" if name.startswith("trig") else None
        )
        patch = self._patch_with_connection(src_name="trig_src")
        results = validate_patch(patch, db=db)
        tier_errors = [
            r for r in results
            if r.level == "error" and "trigger outlet" in r.message
            and "use sig~ or click~" in r.message
        ]
        assert len(tier_errors) >= 1
        assert tier_errors[0].auto_fixed is True

    def test_data_list_to_signal_emits_role_mismatch(self, db, monkeypatch):
        """data and list -> signal: ERROR + auto-remove, no canonical fix."""
        for role in ("data", "list"):
            monkeypatch.setattr(
                db, "get_signal_role",
                lambda name, outlet, _r=role: _r if name.startswith(_r) else None
            )
            patch = self._patch_with_connection(src_name=f"{role}_src")
            results = validate_patch(patch, db=db)
            tier_errors = [
                r for r in results
                if r.level == "error" and f"{role} outlet" in r.message
                and "role mismatch" in r.message
            ]
            assert len(tier_errors) >= 1, (role, [r.message for r in results])
            assert tier_errors[0].auto_fixed is True

    def test_trigger_to_float_warning_preserves(self, db, monkeypatch):
        """trigger -> float: WARNING with 'bang counting' hint; line preserved."""
        monkeypatch.setattr(
            db, "get_signal_role",
            lambda name, outlet: "trigger" if name.startswith("trig") else None
        )
        # Destination must classify as 'float' inlet — flonum is a UI
        # float-display widget recognized by _classify_dst_inlet.
        patch = _make_patch_dict(
            boxes=[
                _make_box("obj-1", text="trig_src", outlettype=["signal"]),
                _make_box("obj-2", maxclass="flonum", text="",
                          numinlets=1, numoutlets=2, outlettype=["", "bang"]),
            ],
            lines=[_make_line("obj-1", 0, "obj-2", 0)],
        )
        results = validate_patch(patch, db=db)
        warnings_found = [
            r for r in results
            if r.level == "warning" and "trigger outlet" in r.message
            and "bang counting" in r.message
        ]
        assert len(warnings_found) >= 1, [r.message for r in results]
        # Line preserved (auto_fixed=False)
        assert warnings_found[0].auto_fixed is False
        assert len(patch["patcher"]["lines"]) == 1

    def test_list_to_float_warning_bach_hint(self, db, monkeypatch):
        """list -> float: WARNING with 'bach.* often does this' hint."""
        monkeypatch.setattr(
            db, "get_signal_role",
            lambda name, outlet: "list" if name.startswith("list") else None
        )
        patch = _make_patch_dict(
            boxes=[
                _make_box("obj-1", text="list_src", outlettype=["signal"]),
                _make_box("obj-2", maxclass="flonum", text="",
                          numinlets=1, numoutlets=2, outlettype=["", "bang"]),
            ],
            lines=[_make_line("obj-1", 0, "obj-2", 0)],
        )
        results = validate_patch(patch, db=db)
        warnings_found = [
            r for r in results
            if r.level == "warning" and "list outlet" in r.message
            and "bach.*" in r.message
        ]
        assert len(warnings_found) >= 1
        assert warnings_found[0].auto_fixed is False
        assert len(patch["patcher"]["lines"]) == 1

    def test_audio_to_signal_silent_via_legacy(self, db):
        """REGRESSION (R2/R10): cycle~ (audio) -> *~ (signal) emits no
        tier finding; legacy branch handles it silently. Production fixture
        cycle~ has signal_role='audio' per Phase 28."""
        patch = self._patch_with_connection(
            src_name="cycle~ 440", dst_name="*~ 0.5"
        )
        results = validate_patch(patch, db=db)
        # No connection-layer error or warning carrying tier-format wording
        type_issues = [
            r for r in results
            if r.layer == "connections"
            and r.level in ("error", "warning")
            and "outlet \u2192" in r.message
        ]
        assert type_issues == [], [r.message for r in type_issues]
        # Line preserved
        assert len(patch["patcher"]["lines"]) == 1

    def test_audio_to_control_legacy_branch_runs(self, db):
        """REGRESSION (R10): cycle~ -> print (control-only inlet) is
        auto-removed by the LEGACY signal:bool branch — tier dispatch
        must not bypass it. Mirrors test_signal_to_control_only_inlet_detected."""
        boxes = [
            _make_box("obj-1", text="cycle~ 440", numoutlets=1, outlettype=["signal"]),
            _make_box("obj-2", text="print", numinlets=1, numoutlets=0, outlettype=[]),
        ]
        lines = [_make_line("obj-1", 0, "obj-2", 0)]
        patch = _make_patch_dict(boxes=boxes, lines=lines)
        results = validate_patch(patch, db=db)
        # Legacy branch produces an auto_fixed error mentioning signal -> control
        legacy_errors = [
            r for r in results
            if r.layer == "connections" and r.auto_fixed
            and "signal" in r.message.lower()
        ]
        assert len(legacy_errors) >= 1, (
            f"Legacy auto-remove for audio -> control inlet was bypassed. "
            f"Got: {[r.message for r in results]}"
        )

    def test_uncurated_role_falls_through(self, db, monkeypatch):
        """Source whose get_signal_role returns None falls through to legacy
        branch unchanged. Mirrors test_control_to_signal_inlet_passes."""
        monkeypatch.setattr(db, "get_signal_role", lambda name, outlet: None)
        patch = _make_patch_dict(
            boxes=[
                _make_box("obj-1", maxclass="message", text="440",
                          numinlets=2, numoutlets=1, outlettype=[""]),
                _make_box("obj-2", text="cycle~ 440",
                          numinlets=2, numoutlets=1, outlettype=["signal"]),
            ],
            lines=[_make_line("obj-1", 0, "obj-2", 0)],
        )
        results = validate_patch(patch, db=db)
        tier_findings = [
            r for r in results
            if r.layer == "connections" and "outlet \u2192" in r.message
        ]
        assert tier_findings == []

    def test_role_tier_table_excludes_audio_keys(self):
        """DEFENSIVE INVARIANT (R2): _ROLE_TIER_TABLE must not contain any
        ('audio', *) key. Audio sources are owned by the legacy signal:bool
        branch; adding an audio key would silently change auto-fix behavior
        for every existing audio-source test."""
        from src.maxpat.validation import _ROLE_TIER_TABLE
        audio_keys = [k for k in _ROLE_TIER_TABLE.keys() if k[0] == "audio"]
        assert audio_keys == [], (
            f"_ROLE_TIER_TABLE contains forbidden audio keys: {audio_keys}. "
            f"Per RESEARCH.md R2/R10, audio sources must remain in the "
            f"exclusive control of the legacy signal:bool branch."
        )

    def test_severity_auto_fix_contract(self, db, monkeypatch):
        """D-19 row: ERROR tier has auto_fixed=True; WARNING tier has
        auto_fixed=False."""
        # ERROR case
        monkeypatch.setattr(
            db, "get_signal_role",
            lambda name, outlet: "status" if name.startswith("s") else None
        )
        patch_err = self._patch_with_connection(src_name="status_x")
        for r in validate_patch(patch_err, db=db):
            if "status outlet" in r.message:
                assert r.level == "error" and r.auto_fixed is True

        # WARNING case
        monkeypatch.setattr(
            db, "get_signal_role",
            lambda name, outlet: "trigger" if name.startswith("t") else None
        )
        patch_warn = _make_patch_dict(
            boxes=[
                _make_box("obj-1", text="trig", outlettype=["signal"]),
                _make_box("obj-2", maxclass="flonum", text="",
                          numinlets=1, numoutlets=2, outlettype=["", "bang"]),
            ],
            lines=[_make_line("obj-1", 0, "obj-2", 0)],
        )
        for r in validate_patch(patch_warn, db=db):
            if "trigger outlet" in r.message and "float inlet" in r.message:
                assert r.level == "warning" and r.auto_fixed is False


# ===========================================================================
# Layer 4: Domain-Specific Rules
# ===========================================================================

class TestLayer4DomainRules:
    """PAT-08: Layer 4 domain-specific validation rules."""

    def test_gain_staged_no_warning(self, db):
        """cycle~ -> *~ -> ezdac~ (gain staged) produces no gain warning."""
        boxes = [
            _make_box("obj-1", text="cycle~ 440", numoutlets=1, outlettype=["signal"]),
            _make_box("obj-2", text="*~ 0.5", numinlets=2, numoutlets=1,
                       outlettype=["signal"]),
            _make_box("obj-3", maxclass="ezdac~", text="ezdac~",
                       numinlets=2, numoutlets=0, outlettype=[]),
        ]
        lines = [
            _make_line("obj-1", 0, "obj-2", 0),
            _make_line("obj-2", 0, "obj-3", 0),
        ]
        patch = _make_patch_dict(boxes=boxes, lines=lines)
        results = validate_patch(patch, db=db)
        gain_warnings = [r for r in results
                         if r.layer == "domain" and "gain" in r.message.lower()]
        assert gain_warnings == []

    def test_missing_gain_staging_warning(self, db):
        """cycle~ -> ezdac~ (no attenuation) produces gain warning."""
        boxes = [
            _make_box("obj-1", text="cycle~ 440", numoutlets=1, outlettype=["signal"]),
            _make_box("obj-2", maxclass="ezdac~", text="ezdac~",
                       numinlets=2, numoutlets=0, outlettype=[]),
        ]
        lines = [_make_line("obj-1", 0, "obj-2", 0)]
        patch = _make_patch_dict(boxes=boxes, lines=lines)
        results = validate_patch(patch, db=db)
        gain_warnings = [r for r in results
                         if r.layer == "domain" and "gain" in r.message.lower()]
        assert len(gain_warnings) >= 1

    def test_terminated_via_send_no_warning(self, db):
        """cycle~ -> send~ (terminated) produces no unterminated warning."""
        boxes = [
            _make_box("obj-1", text="cycle~ 440", numoutlets=1, outlettype=["signal"]),
            _make_box("obj-2", text="send~ lfo", numinlets=1, numoutlets=0,
                       outlettype=[]),
        ]
        lines = [_make_line("obj-1", 0, "obj-2", 0)]
        patch = _make_patch_dict(boxes=boxes, lines=lines)
        results = validate_patch(patch, db=db)
        unterm = [r for r in results
                  if r.layer == "domain" and "unterminated" in r.message.lower()]
        assert unterm == []

    def test_unterminated_signal_chain_warning(self, db):
        """cycle~ dangling (no downstream) produces unterminated warning."""
        boxes = [
            _make_box("obj-1", text="cycle~ 440", numoutlets=1, outlettype=["signal"]),
        ]
        patch = _make_patch_dict(boxes=boxes)
        results = validate_patch(patch, db=db)
        unterm = [r for r in results
                  if r.layer == "domain" and "unterminated" in r.message.lower()]
        assert len(unterm) >= 1

    def test_feedback_loop_without_delay_warning(self, db):
        """Signal cycle without tapin~/tapout~ triggers feedback warning."""
        boxes = [
            _make_box("obj-1", text="cycle~ 440", numoutlets=1, outlettype=["signal"]),
            _make_box("obj-2", text="*~ 0.5", numinlets=2, numoutlets=1,
                       outlettype=["signal"]),
        ]
        # Create a cycle: obj-1 -> obj-2 -> obj-1
        lines = [
            _make_line("obj-1", 0, "obj-2", 0),
            _make_line("obj-2", 0, "obj-1", 0),
        ]
        patch = _make_patch_dict(boxes=boxes, lines=lines)
        results = validate_patch(patch, db=db)
        feedback = [r for r in results
                    if r.layer == "domain" and "feedback" in r.message.lower()]
        assert len(feedback) >= 1


# ===========================================================================
# Layer 4b: Domain Restriction Guard (Phase 29 / VALID-02 / D-05..D-08)
# ===========================================================================

class TestDomainGuard:
    """VALID-02 / D-05..D-08: top-level boxes with domain_restricted
    annotations emit an ERROR ValidationResult. Top-level only — no
    recursion into subpatchers (D-07). Always ERROR + auto_fixed=False
    (D-08). Production fixture: floor~ has domain_restricted: ['rnbo']
    in overrides.json (line ~11058)."""

    def test_floor_tilde_top_level_error(self, db):
        """floor~ at top level (outside rnbo~) emits ERROR naming the
        object, the restriction list, and the wrap-in suggestion."""
        boxes = [
            _make_box("f1", text="floor~ 0.5",
                      numinlets=1, numoutlets=1, outlettype=["signal"]),
        ]
        patch = _make_patch_dict(boxes=boxes, lines=[])
        results = validate_patch(patch, db=db)
        domain_errors = [
            r for r in results
            if r.layer == "domain" and r.level == "error"
            and "floor~" in r.message
            and "is restricted to" in r.message
        ]
        assert len(domain_errors) == 1, [r.message for r in results]
        assert domain_errors[0].auto_fixed is False
        # Restriction list cited verbatim
        assert "rnbo" in domain_errors[0].message
        # Suggestion to wrap
        assert "Wrap in" in domain_errors[0].message

    def test_floor_tilde_in_gen_subpatcher_silent(self, db):
        """REGRESSION (R6): floor~ nested in gen~ inner patcher must NOT
        fire — D-07 top-level only. The walker iterates outer boxes only."""
        # Outer patcher contains a single gen~ box; its inner patcher
        # contains floor~. Domain guard MUST NOT recurse.
        outer_gen_box = {
            "box": {
                "id": "gen-1",
                "maxclass": "newobj",
                "text": "gen~",
                "numinlets": 0,
                "numoutlets": 1,
                "outlettype": ["signal"],
                "patching_rect": [0, 0, 80, 22],
                "patcher": {
                    "boxes": [
                        {"box": {
                            "id": "f1",
                            "maxclass": "newobj",
                            "text": "floor~ 0.5",
                            "numinlets": 1,
                            "numoutlets": 1,
                            "outlettype": ["signal"],
                        }}
                    ],
                    "lines": [],
                },
            }
        }
        patch = {"patcher": {"boxes": [outer_gen_box], "lines": []}}
        results = validate_patch(patch, db=db)
        floor_errors = [
            r for r in results
            if r.layer == "domain" and r.level == "error"
            and "floor~" in r.message
            and "is restricted to" in r.message
        ]
        assert floor_errors == [], (
            f"D-07 violated: domain guard recursed into gen~ inner patcher. "
            f"Got: {floor_errors}"
        )

    def test_unrestricted_object_silent(self, db):
        """Only unrestricted objects -> no domain-restriction error."""
        boxes = [
            _make_box("c1", text="cycle~ 440",
                      numinlets=2, numoutlets=1, outlettype=["signal"]),
            _make_box("m1", text="*~ 0.5",
                      numinlets=2, numoutlets=1, outlettype=["signal"]),
        ]
        patch = _make_patch_dict(boxes=boxes, lines=[])
        results = validate_patch(patch, db=db)
        domain_restriction_errors = [
            r for r in results
            if r.layer == "domain" and r.level == "error"
            and "is restricted to" in r.message
        ]
        assert domain_restriction_errors == []

    def test_severity_contract(self, db):
        """D-08, D-19: domain restriction is always ERROR + auto_fixed=False."""
        boxes = [
            _make_box("f1", text="floor~ 0.5",
                      numinlets=1, numoutlets=1, outlettype=["signal"]),
        ]
        patch = _make_patch_dict(boxes=boxes, lines=[])
        results = validate_patch(patch, db=db)
        for r in results:
            if r.layer == "domain" and "is restricted to" in r.message:
                assert r.level == "error", r
                assert r.auto_fixed is False, r

    def test_message_cites_restriction_list(self, db):
        """Error message contains the literal restriction list (e.g.,
        ['rnbo']) so callers can grep on it."""
        boxes = [
            _make_box("f1", text="floor~ 0.5",
                      numinlets=1, numoutlets=1, outlettype=["signal"]),
        ]
        patch = _make_patch_dict(boxes=boxes, lines=[])
        results = validate_patch(patch, db=db)
        target = next(
            (r for r in results
             if r.layer == "domain" and r.level == "error"
             and "floor~" in r.message),
            None,
        )
        assert target is not None, [r.message for r in results]
        # The list itself is in the message (Python list repr)
        assert "['rnbo']" in target.message


# ===========================================================================
# Layer 5: Embedded GenExpr Codebox Walker (Phase 29 / VALID-04 / D-17)
# ===========================================================================

class TestEmbeddedGenExpr:
    """VALID-04 / D-17: embedded gen~ codeboxes inside .maxpat files get
    Checks 1-9 from validate_genexpr piped through as ValidationResult
    findings, tagged with the gen~ box id. Top-level only (D-07 scope
    alignment with the domain guard)."""

    def _patch_with_gen_codebox(self, code, gen_id="g1"):
        """Build a minimal patch with one top-level gen~ wrapping a single
        codebox containing the given code."""
        gen_box = {
            "box": {
                "id": gen_id,
                "maxclass": "newobj",
                "text": "gen~",
                "numinlets": 0,
                "numoutlets": 1,
                "outlettype": ["signal"],
                "patching_rect": [0, 0, 80, 22],
                "patcher": {
                    "boxes": [
                        {"box": {
                            "id": "cb1",
                            "maxclass": "codebox",
                            "code": code,
                        }}
                    ],
                    "lines": [],
                },
            }
        }
        return {"patcher": {"boxes": [gen_box], "lines": []}}

    def test_embedded_delay_emits_error(self, db):
        """delay( in embedded codebox triggers Check 7 via the walker."""
        patch = self._patch_with_gen_codebox("out1 = delay(in1, 100);")
        results = validate_patch(patch, db=db)
        delay_errors = [
            r for r in results
            if r.level == "error" and "delay()" in r.message
            and "gen~ 'g1'" in r.message
        ]
        assert len(delay_errors) >= 1, [r.message for r in results]

    def test_embedded_clip_emits_error(self, db):
        """clip( in embedded codebox triggers Check 8 via the walker."""
        patch = self._patch_with_gen_codebox("out1 = clip(in1, 0., 1.);")
        results = validate_patch(patch, db=db)
        clip_errors = [
            r for r in results
            if r.level == "error" and "clip()" in r.message
            and "gen~ 'g1'" in r.message
        ]
        assert len(clip_errors) >= 1, [r.message for r in results]

    def test_embedded_init_before_if_emits_error(self, db):
        """Variable assigned only inside if/else triggers Check 9."""
        code = "if (in1 > 0) {\n    y = in1 * 2;\n}\nout1 = y;"
        patch = self._patch_with_gen_codebox(code)
        results = validate_patch(patch, db=db)
        init_errors = [
            r for r in results
            if r.level == "error" and "without prior init" in r.message
            and "gen~ 'g1'" in r.message
        ]
        assert len(init_errors) >= 1, [r.message for r in results]

    def test_clean_codebox_silent(self, db):
        """A codebox with no Check 7/8/9 violations produces no walker error."""
        patch = self._patch_with_gen_codebox("out1 = in1 * 0.5;")
        results = validate_patch(patch, db=db)
        walker_findings = [
            r for r in results
            if "gen~ 'g1' codebox:" in r.message
            and r.level == "error"
        ]
        # Walker may emit 'info' (Check 3 in/out detection) but no errors
        assert walker_findings == [], [r.message for r in walker_findings]

    def test_no_gen_no_findings(self, db):
        """Patch with no gen~ boxes produces no walker findings."""
        boxes = [
            _make_box("c1", text="cycle~ 440",
                      numinlets=2, numoutlets=1, outlettype=["signal"]),
        ]
        patch = _make_patch_dict(boxes=boxes, lines=[])
        results = validate_patch(patch, db=db)
        walker_findings = [
            r for r in results
            if "codebox:" in r.message
        ]
        assert walker_findings == []

    def test_gen_without_codebox_silent(self, db):
        """gen~ with an inner patcher that has no codeboxes produces no
        walker findings."""
        gen_box = {
            "box": {
                "id": "g1",
                "maxclass": "newobj",
                "text": "gen~",
                "numinlets": 0,
                "numoutlets": 1,
                "outlettype": ["signal"],
                "patcher": {
                    "boxes": [
                        {"box": {
                            "id": "in1",
                            "maxclass": "inlet",
                            "numinlets": 0,
                            "numoutlets": 1,
                        }}
                    ],
                    "lines": [],
                },
            }
        }
        patch = {"patcher": {"boxes": [gen_box], "lines": []}}
        results = validate_patch(patch, db=db)
        walker_findings = [
            r for r in results
            if "gen~ 'g1' codebox:" in r.message
        ]
        assert walker_findings == []

    def test_severity_carried_through(self, db):
        """Walker preserves level and auto_fixed from validate_genexpr.
        D-19: Check 7 is ERROR with auto_fixed=False."""
        patch = self._patch_with_gen_codebox("out1 = delay(in1, 100);")
        results = validate_patch(patch, db=db)
        target = next(
            (r for r in results
             if "delay()" in r.message and "gen~ 'g1'" in r.message),
            None,
        )
        assert target is not None, [r.message for r in results]
        assert target.level == "error"
        assert target.auto_fixed is False

    def test_box_id_in_tag(self, db):
        """Two distinct gen~ boxes produce two distinct tagged findings,
        each citing the correct gen~ id."""
        gen_box_a = {
            "box": {
                "id": "alpha",
                "maxclass": "newobj",
                "text": "gen~",
                "numinlets": 0,
                "numoutlets": 1,
                "outlettype": ["signal"],
                "patcher": {
                    "boxes": [
                        {"box": {
                            "id": "cba",
                            "maxclass": "codebox",
                            "code": "out1 = delay(in1, 100);",
                        }}
                    ],
                    "lines": [],
                },
            }
        }
        gen_box_b = {
            "box": {
                "id": "beta",
                "maxclass": "newobj",
                "text": "gen~",
                "numinlets": 0,
                "numoutlets": 1,
                "outlettype": ["signal"],
                "patcher": {
                    "boxes": [
                        {"box": {
                            "id": "cbb",
                            "maxclass": "codebox",
                            "code": "out1 = clip(in1, 0., 1.);",
                        }}
                    ],
                    "lines": [],
                },
            }
        }
        patch = {"patcher": {"boxes": [gen_box_a, gen_box_b], "lines": []}}
        results = validate_patch(patch, db=db)
        alpha_findings = [
            r for r in results
            if "gen~ 'alpha'" in r.message and "delay()" in r.message
        ]
        beta_findings = [
            r for r in results
            if "gen~ 'beta'" in r.message and "clip()" in r.message
        ]
        assert len(alpha_findings) >= 1, [r.message for r in results]
        assert len(beta_findings) >= 1, [r.message for r in results]


# ===========================================================================
# has_blocking_errors
# ===========================================================================

class TestHasBlockingErrors:
    """has_blocking_errors returns True only for unfixable errors."""

    def test_no_results_not_blocking(self):
        """Empty results list is not blocking."""
        assert has_blocking_errors([]) is False

    def test_auto_fixed_error_not_blocking(self):
        """Auto-fixed error does not block."""
        results = [
            ValidationResult("connections", "error", "outlet out of bounds", auto_fixed=True),
        ]
        assert has_blocking_errors(results) is False

    def test_unfixable_error_is_blocking(self):
        """Unfixable error blocks output."""
        results = [
            ValidationResult("json", "error", "missing patcher key"),
        ]
        assert has_blocking_errors(results) is True

    def test_warning_not_blocking(self):
        """Warnings do not block output."""
        results = [
            ValidationResult("domain", "warning", "missing gain staging"),
        ]
        assert has_blocking_errors(results) is False

    def test_mixed_results_blocked_by_unfixable(self):
        """Mix of fixed and unfixable: blocked by unfixable."""
        results = [
            ValidationResult("connections", "error", "outlet out of bounds", auto_fixed=True),
            ValidationResult("objects", "error", "unknown object: xyz"),
        ]
        assert has_blocking_errors(results) is True

    def test_all_fixed_not_blocking(self):
        """All errors auto-fixed: not blocking."""
        results = [
            ValidationResult("connections", "error", "outlet oob", auto_fixed=True),
            ValidationResult("connections", "error", "inlet oob", auto_fixed=True),
            ValidationResult("domain", "warning", "missing gain"),
        ]
        assert has_blocking_errors(results) is False


# ===========================================================================
# validate_patch accepts Patcher instance
# ===========================================================================

class TestValidatePatchWithPatcher:
    """validate_patch works with both Patcher instance and raw dict."""

    def test_patcher_instance_input(self, db):
        """validate_patch accepts a Patcher instance."""
        p = Patcher(db=db)
        b1 = p.add_box("cycle~", args=["440"])
        b2 = p.add_box("ezdac~")
        p.add_connection(b1, 0, b2, 0)
        results = validate_patch(p)
        # Should run without error and return results
        assert isinstance(results, list)
        # Should have gain staging warning at minimum
        gain_warnings = [r for r in results
                         if r.layer == "domain" and "gain" in r.message.lower()]
        assert len(gain_warnings) >= 1

    def test_raw_dict_input(self, db):
        """validate_patch accepts a raw dict."""
        patch = _make_patch_dict()
        results = validate_patch(patch, db=db)
        assert isinstance(results, list)

    def test_valid_patch_no_blocking_errors(self, db):
        """Valid gain-staged patch has no blocking errors."""
        p = Patcher(db=db)
        osc = p.add_box("cycle~", args=["440"])
        gain = p.add_box("*~", args=["0.5"])
        dac = p.add_box("ezdac~")
        p.add_connection(osc, 0, gain, 0)
        p.add_connection(gain, 0, dac, 0)
        p.add_connection(gain, 0, dac, 1)
        results = validate_patch(p)
        assert has_blocking_errors(results) is False


# ===========================================================================
# ValidationResult representation
# ===========================================================================

class TestValidationResult:
    """ValidationResult has correct fields and repr."""

    def test_fields(self):
        """ValidationResult has layer, level, message, auto_fixed fields."""
        r = ValidationResult("json", "error", "test message", auto_fixed=True)
        assert r.layer == "json"
        assert r.level == "error"
        assert r.message == "test message"
        assert r.auto_fixed is True

    def test_default_auto_fixed_false(self):
        """auto_fixed defaults to False."""
        r = ValidationResult("json", "error", "test")
        assert r.auto_fixed is False

    def test_repr_format(self):
        """__repr__ follows [layer:level] message format."""
        r = ValidationResult("json", "error", "missing patcher key")
        assert repr(r) == "[json:error] missing patcher key"


# ===========================================================================
# Layer 4: Unsafe Gain Value Detection
# ===========================================================================

class TestLayer4UnsafeGainValues:
    """GAIN-SAFETY: Detect *~ objects with literal gain arguments > 1.0."""

    def test_unsafe_gain_literal_warning(self, db):
        """*~ 127 produces domain warning with 'unsafe gain'."""
        patch = _make_patch_dict(boxes=[
            _make_box("obj-1", text="*~ 127", numinlets=2, numoutlets=1,
                       outlettype=["signal"]),
        ])
        results = validate_patch(patch, db=db)
        gain_warnings = [r for r in results
                         if r.layer == "domain" and "unsafe gain" in r.message.lower()]
        assert len(gain_warnings) >= 1
        assert "127" in gain_warnings[0].message

    def test_safe_gain_literal_no_warning(self, db):
        """*~ 0.5 produces no unsafe gain warning."""
        patch = _make_patch_dict(boxes=[
            _make_box("obj-1", text="*~ 0.5", numinlets=2, numoutlets=1,
                       outlettype=["signal"]),
        ])
        results = validate_patch(patch, db=db)
        gain_warnings = [r for r in results
                         if r.layer == "domain" and "unsafe gain" in r.message.lower()]
        assert gain_warnings == []

    def test_gain_at_unity_no_warning(self, db):
        """*~ 1.0 produces no unsafe gain warning (1.0 is the boundary, still safe)."""
        patch = _make_patch_dict(boxes=[
            _make_box("obj-1", text="*~ 1.0", numinlets=2, numoutlets=1,
                       outlettype=["signal"]),
        ])
        results = validate_patch(patch, db=db)
        gain_warnings = [r for r in results
                         if r.layer == "domain" and "unsafe gain" in r.message.lower()]
        assert gain_warnings == []

    def test_gain_no_arg_no_warning(self, db):
        """*~ alone produces no unsafe gain warning."""
        patch = _make_patch_dict(boxes=[
            _make_box("obj-1", text="*~", numinlets=2, numoutlets=1,
                       outlettype=["signal"]),
        ])
        results = validate_patch(patch, db=db)
        gain_warnings = [r for r in results
                         if r.layer == "domain" and "unsafe gain" in r.message.lower()]
        assert gain_warnings == []

    def test_gain_negative_literal_no_warning(self, db):
        """*~ -0.5 -- negative is not > 1.0, no warning."""
        patch = _make_patch_dict(boxes=[
            _make_box("obj-1", text="*~ -0.5", numinlets=2, numoutlets=1,
                       outlettype=["signal"]),
        ])
        results = validate_patch(patch, db=db)
        gain_warnings = [r for r in results
                         if r.layer == "domain" and "unsafe gain" in r.message.lower()]
        assert gain_warnings == []


# ===========================================================================
# Layer 3: Override Guard for Signal-to-Control Auto-Removal
# ===========================================================================

class TestLayer3OverrideGuard:
    """Guard: non-overridden MSP objects skip signal-to-control auto-removal."""

    def test_overridden_msp_object_auto_removes(self, db):
        """Overridden MSP object (line~) signal->control: connection auto-removed.

        line~ is in overrides.json, so its outlet types are trusted.
        Signal outlet 0 -> print inlet 0 (control-only) should be removed.
        """
        boxes = [
            _make_box("obj-1", text="line~", numinlets=2, numoutlets=2,
                       outlettype=["signal", ""]),
            _make_box("obj-2", text="print", numinlets=1, numoutlets=0,
                       outlettype=[]),
        ]
        # Connect signal outlet 0 of line~ to control-only inlet 0 of print
        lines = [_make_line("obj-1", 0, "obj-2", 0)]
        patch = _make_patch_dict(boxes=boxes, lines=lines)
        results = validate_patch(patch, db=db)

        # Connection should be auto-fixed (removed)
        auto_fixed = [r for r in results
                      if r.layer == "connections" and r.auto_fixed
                      and "signal" in r.message.lower()]
        assert len(auto_fixed) >= 1

        # Line should be removed from patch
        assert len(patch["patcher"]["lines"]) == 0

    def test_non_overridden_msp_object_preserves_connection(self, db):
        """Non-overridden MSP object (fakesynth~) signal->control: connection preserved.

        fakesynth~ is NOT in overrides.json, so its outlet types are unverified.
        Connection should survive with a warning instead of being removed.
        """
        boxes = [
            _make_box("obj-1", text="fakesynth~ 440", numinlets=2, numoutlets=2,
                       outlettype=["signal", "signal"]),
            _make_box("obj-2", text="print", numinlets=1, numoutlets=0,
                       outlettype=[]),
        ]
        # Connect signal outlet 0 of fakesynth~ to control-only inlet 0 of print
        lines = [_make_line("obj-1", 0, "obj-2", 0)]
        patch = _make_patch_dict(boxes=boxes, lines=lines)
        results = validate_patch(patch, db=db)

        # Connection should NOT be removed (preserved)
        assert len(patch["patcher"]["lines"]) == 1

        # Should have a warning (not error) about unverified outlet types
        warnings = [r for r in results
                    if r.layer == "connections" and r.level == "warning"
                    and "unverified" in r.message.lower()]
        assert len(warnings) >= 1
        assert not warnings[0].auto_fixed

    def test_non_msp_object_unchanged(self, db):
        """Non-tilde object with signal outlettype: existing auto-removal unchanged.

        A non-MSP object (no ~) with outlettype=["signal"] should still have
        signal->control connections auto-removed as before.
        """
        boxes = [
            _make_box("obj-1", text="fakebox", numinlets=1, numoutlets=1,
                       outlettype=["signal"]),
            _make_box("obj-2", text="print", numinlets=1, numoutlets=0,
                       outlettype=[]),
        ]
        lines = [_make_line("obj-1", 0, "obj-2", 0)]
        patch = _make_patch_dict(boxes=boxes, lines=lines)
        results = validate_patch(patch, db=db)

        # Connection should be auto-fixed (removed) -- existing behavior unchanged
        auto_fixed = [r for r in results
                      if r.layer == "connections" and r.auto_fixed
                      and "signal" in r.message.lower()]
        assert len(auto_fixed) >= 1

        # Line should be removed
        assert len(patch["patcher"]["lines"]) == 0


# ===========================================================================
# Layer 4: GenExpr and Domain-Specific Checks
# ===========================================================================

def _make_codebox(box_id, code="out1 = in1;"):
    """Return a codebox box entry with embedded GenExpr code."""
    return {
        "box": {
            "maxclass": "newobj",
            "id": box_id,
            "text": "codebox",
            "numinlets": 1,
            "numoutlets": 1,
            "outlettype": [""],
            "patching_rect": [0.0, 0.0, 80.0, 22.0],
            "code": code,
        }
    }


class TestLayer4GenExprChecks:
    """Validate GenExpr codebox syntax checks."""

    # --- Check 1: GenExpr I/O syntax ---

    def test_genexpr_spaced_io_triggers_error(self, db):
        """Codebox with 'in 1' triggers error."""
        patch = _make_patch_dict(boxes=[
            _make_codebox("obj-1", code="out1 = in 1 * 0.5;"),
        ])
        results = validate_patch(patch, db=db)
        errs = [r for r in results
                if r.layer == "domain" and r.level == "error"
                and "in1" in r.message.lower()]
        assert len(errs) >= 1

    def test_genexpr_spaced_out_triggers_error(self, db):
        """Codebox with 'out 2' triggers error."""
        patch = _make_patch_dict(boxes=[
            _make_codebox("obj-1", code="out 2 = in1;"),
        ])
        results = validate_patch(patch, db=db)
        errs = [r for r in results
                if r.layer == "domain" and r.level == "error"
                and "in1" in r.message.lower()]
        assert len(errs) >= 1

    def test_genexpr_correct_io_no_error(self, db):
        """Codebox with 'in1'/'out1' (no space) produces no error."""
        patch = _make_patch_dict(boxes=[
            _make_codebox("obj-1", code="out1 = in1 * 0.5;"),
        ])
        results = validate_patch(patch, db=db)
        errs = [r for r in results
                if r.layer == "domain" and r.level == "error"
                and "genexpr" in r.message.lower()]
        assert errs == []

    # --- Check 2: GenExpr delay syntax ---

    def test_genexpr_delay_call_triggers_error(self, db):
        """Codebox with delay() triggers error."""
        patch = _make_patch_dict(boxes=[
            _make_codebox("obj-1", code="out1 = delay(in1, 100);"),
        ])
        results = validate_patch(patch, db=db)
        errs = [r for r in results
                if r.layer == "domain" and r.level == "error"
                and "delay" in r.message.lower()]
        assert len(errs) >= 1

    def test_genexpr_delay_read_no_error(self, db):
        """Codebox with Delay.read() produces no error."""
        patch = _make_patch_dict(boxes=[
            _make_codebox("obj-1", code="d = Delay(1000);\nout1 = d.read(100);"),
        ])
        results = validate_patch(patch, db=db)
        errs = [r for r in results
                if r.layer == "domain" and r.level == "error"
                and "delay" in r.message.lower()]
        assert errs == []

    # --- Check 3: gen~ @param message syntax ---

    def test_gen_at_param_connected_to_gen_warning(self, db):
        """Message '@depth $1' connected to gen~ triggers warning."""
        boxes = [
            _make_box("msg-1", maxclass="message", text="@depth $1",
                       numinlets=2, numoutlets=1, outlettype=[""]),
            _make_box("gen-1", text="gen~", numinlets=1, numoutlets=1,
                       outlettype=["signal"]),
        ]
        lines = [_make_line("msg-1", 0, "gen-1", 0)]
        patch = _make_patch_dict(boxes=boxes, lines=lines)
        results = validate_patch(patch, db=db)
        warns = [r for r in results
                 if r.layer == "domain" and r.level == "warning"
                 and "param" in r.message.lower()]
        assert len(warns) >= 1

    def test_gen_plain_param_no_warning(self, db):
        """Message 'depth $1' connected to gen~ produces no warning."""
        boxes = [
            _make_box("msg-1", maxclass="message", text="depth $1",
                       numinlets=2, numoutlets=1, outlettype=[""]),
            _make_box("gen-1", text="gen~", numinlets=1, numoutlets=1,
                       outlettype=["signal"]),
        ]
        lines = [_make_line("msg-1", 0, "gen-1", 0)]
        patch = _make_patch_dict(boxes=boxes, lines=lines)
        results = validate_patch(patch, db=db)
        warns = [r for r in results
                 if r.layer == "domain" and r.level == "warning"
                 and "param" in r.message.lower()]
        assert warns == []

    def test_at_param_not_connected_to_gen_no_warning(self, db):
        """Message '@depth $1' NOT connected to gen~ produces no warning."""
        boxes = [
            _make_box("msg-1", maxclass="message", text="@depth $1",
                       numinlets=2, numoutlets=1, outlettype=[""]),
            _make_box("obj-1", text="bpatcher", maxclass="bpatcher",
                       numinlets=1, numoutlets=1, outlettype=[""]),
        ]
        lines = [_make_line("msg-1", 0, "obj-1", 0)]
        patch = _make_patch_dict(boxes=boxes, lines=lines)
        results = validate_patch(patch, db=db)
        warns = [r for r in results
                 if r.layer == "domain" and r.level == "warning"
                 and "param" in r.message.lower()]
        assert warns == []

    # --- Check 4: Comment #N substitution ---

    def test_comment_with_hash_n_warning(self, db):
        """Comment box with '#1' text triggers warning."""
        patch = _make_patch_dict(boxes=[
            {"box": {"maxclass": "comment", "id": "obj-1",
                     "text": "Freq: #1 Hz",
                     "numinlets": 1, "numoutlets": 0,
                     "outlettype": [],
                     "patching_rect": [0, 0, 80, 22]}},
        ])
        results = validate_patch(patch, db=db)
        warns = [r for r in results
                 if r.layer == "domain" and r.level == "warning"
                 and "comment" in r.message.lower() and "#" in r.message]
        assert len(warns) >= 1

    def test_newobj_with_hash_n_no_comment_warning(self, db):
        """newobj with '#1' in text does NOT trigger the comment warning."""
        patch = _make_patch_dict(boxes=[
            _make_box("obj-1", text="buffer~ #1",
                       numinlets=1, numoutlets=2, outlettype=["", ""]),
        ])
        results = validate_patch(patch, db=db)
        warns = [r for r in results
                 if r.layer == "domain" and r.level == "warning"
                 and "comment" in r.message.lower() and "#n" in r.message.lower()]
        assert warns == []

    # --- Check 5: line~ comma messages ---

    def test_line_tilde_comma_message_warning(self, db):
        """Message with comma connected to line~ triggers warning."""
        boxes = [
            _make_box("msg-1", maxclass="message", text="100, 500 1000",
                       numinlets=2, numoutlets=1, outlettype=[""]),
            _make_box("line-1", text="line~", numinlets=2, numoutlets=2,
                       outlettype=["signal", ""]),
        ]
        lines = [_make_line("msg-1", 0, "line-1", 0)]
        patch = _make_patch_dict(boxes=boxes, lines=lines)
        results = validate_patch(patch, db=db)
        warns = [r for r in results
                 if r.layer == "domain" and r.level == "warning"
                 and "replaces ramps" in r.message.lower()]
        assert len(warns) >= 1

    def test_line_tilde_no_comma_no_warning(self, db):
        """Message without comma connected to line~ produces no warning."""
        boxes = [
            _make_box("msg-1", maxclass="message", text="100 500 1000",
                       numinlets=2, numoutlets=1, outlettype=[""]),
            _make_box("line-1", text="line~", numinlets=2, numoutlets=2,
                       outlettype=["signal", ""]),
        ]
        lines = [_make_line("msg-1", 0, "line-1", 0)]
        patch = _make_patch_dict(boxes=boxes, lines=lines)
        results = validate_patch(patch, db=db)
        warns = [r for r in results
                 if r.layer == "domain" and r.level == "warning"
                 and "replaces ramps" in r.message.lower()]
        assert warns == []

    # --- Check 6: multislider fetchindex ---

    def test_multislider_fetchindex_error(self, db):
        """Message with 'fetchindex' triggers error."""
        patch = _make_patch_dict(boxes=[
            _make_box("msg-1", maxclass="message", text="fetchindex 3",
                       numinlets=2, numoutlets=1, outlettype=[""]),
        ])
        results = validate_patch(patch, db=db)
        errs = [r for r in results
                if r.layer == "domain" and r.level == "error"
                and "fetchindex" in r.message.lower()]
        assert len(errs) >= 1

    def test_multislider_fetch_no_error(self, db):
        """Message with 'fetch' (not 'fetchindex') produces no error."""
        patch = _make_patch_dict(boxes=[
            _make_box("msg-1", maxclass="message", text="fetch 3",
                       numinlets=2, numoutlets=1, outlettype=[""]),
        ])
        results = validate_patch(patch, db=db)
        errs = [r for r in results
                if r.layer == "domain" and r.level == "error"
                and "fetchindex" in r.message.lower()]
        assert errs == []

    # --- Check 7: umenu items format ---

    def test_umenu_items_no_comma_warning(self, db):
        """umenu with items=["LP","HP","BP"] (no commas) triggers warning."""
        patch = _make_patch_dict(boxes=[
            {"box": {"maxclass": "umenu", "id": "obj-1",
                     "items": ["LP", "HP", "BP"],
                     "numinlets": 1, "numoutlets": 3,
                     "outlettype": ["int", "", ""],
                     "patching_rect": [0, 0, 100, 22]}},
        ])
        results = validate_patch(patch, db=db)
        warns = [r for r in results
                 if r.layer == "domain" and r.level == "warning"
                 and "umenu" in r.message.lower()]
        assert len(warns) >= 1

    def test_umenu_items_with_comma_no_warning(self, db):
        """umenu with items=["LP",",","HP",",","BP"] produces no warning."""
        patch = _make_patch_dict(boxes=[
            {"box": {"maxclass": "umenu", "id": "obj-1",
                     "items": ["LP", ",", "HP", ",", "BP"],
                     "numinlets": 1, "numoutlets": 3,
                     "outlettype": ["int", "", ""],
                     "patching_rect": [0, 0, 100, 22]}},
        ])
        results = validate_patch(patch, db=db)
        warns = [r for r in results
                 if r.layer == "domain" and r.level == "warning"
                 and "umenu" in r.message.lower()]
        assert warns == []

    def test_umenu_single_item_no_warning(self, db):
        """umenu with only 1 item doesn't trigger warning (edge case)."""
        patch = _make_patch_dict(boxes=[
            {"box": {"maxclass": "umenu", "id": "obj-1",
                     "items": ["OnlyOne"],
                     "numinlets": 1, "numoutlets": 3,
                     "outlettype": ["int", "", ""],
                     "patching_rect": [0, 0, 100, 22]}},
        ])
        results = validate_patch(patch, db=db)
        warns = [r for r in results
                 if r.layer == "domain" and r.level == "warning"
                 and "umenu" in r.message.lower()]
        assert warns == []

    # --- Check 8: Assistance comments on inlet/outlet ---

    def test_inlet_without_comment_info(self, db):
        """inlet maxclass without 'comment' attr triggers info."""
        patch = _make_patch_dict(boxes=[
            {"box": {"maxclass": "inlet", "id": "obj-1",
                     "numinlets": 0, "numoutlets": 1,
                     "outlettype": [""],
                     "patching_rect": [0, 0, 30, 30]}},
        ])
        results = validate_patch(patch, db=db)
        infos = [r for r in results
                 if r.layer == "domain" and r.level == "info"
                 and "assistance" in r.message.lower()]
        assert len(infos) >= 1

    def test_outlet_without_comment_info(self, db):
        """outlet maxclass without 'comment' attr triggers info."""
        patch = _make_patch_dict(boxes=[
            {"box": {"maxclass": "outlet", "id": "obj-1",
                     "numinlets": 1, "numoutlets": 0,
                     "outlettype": [],
                     "patching_rect": [0, 0, 30, 30]}},
        ])
        results = validate_patch(patch, db=db)
        infos = [r for r in results
                 if r.layer == "domain" and r.level == "info"
                 and "assistance" in r.message.lower()]
        assert len(infos) >= 1

    def test_inlet_with_comment_no_info(self, db):
        """inlet with 'comment': 'frequency' produces no info."""
        patch = _make_patch_dict(boxes=[
            {"box": {"maxclass": "inlet", "id": "obj-1",
                     "comment": "frequency",
                     "numinlets": 0, "numoutlets": 1,
                     "outlettype": [""],
                     "patching_rect": [0, 0, 30, 30]}},
        ])
        results = validate_patch(patch, db=db)
        infos = [r for r in results
                 if r.layer == "domain" and r.level == "info"
                 and "assistance" in r.message.lower()]
        assert infos == []

    def test_inlet_with_empty_comment_info(self, db):
        """inlet with empty comment string still triggers info."""
        patch = _make_patch_dict(boxes=[
            {"box": {"maxclass": "inlet", "id": "obj-1",
                     "comment": "",
                     "numinlets": 0, "numoutlets": 1,
                     "outlettype": [""],
                     "patching_rect": [0, 0, 30, 30]}},
        ])
        results = validate_patch(patch, db=db)
        infos = [r for r in results
                 if r.layer == "domain" and r.level == "info"
                 and "assistance" in r.message.lower()]
        assert len(infos) >= 1


# ===========================================================================
# Maxclass Usage Validation
# ===========================================================================

class TestMaxclassUsage:
    """Non-UI objects using their own name as maxclass should be flagged.

    The check is a hard error: a box with maxclass='cycle~' instead of
    maxclass='newobj' + text='cycle~ ...' fails to load in MAX with an
    "invalid attribute maxclass" error, so the validator emits level='error'.
    """

    def test_non_ui_object_wrong_maxclass_triggers_error(self, db):
        """Object like cycle~ using maxclass='cycle~' instead of 'newobj' gets error."""
        patch = _make_patch_dict(boxes=[
            {"box": {"maxclass": "cycle~", "text": "cycle~ 440",
                     "id": "obj-1",
                     "numinlets": 2, "numoutlets": 1,
                     "outlettype": ["signal"],
                     "patching_rect": [100, 100, 80, 22]}},
        ])
        results = validate_patch(patch, db=db)
        errors = [r for r in results
                  if r.layer == "objects" and r.level == "error"
                  and "wrong maxclass" in r.message.lower()
                  and "cycle~" in r.message
                  and "newobj" in r.message]
        assert len(errors) == 1

    def test_ui_object_own_maxclass_no_error(self, db):
        """UI objects like toggle correctly use their own name as maxclass."""
        patch = _make_patch_dict(boxes=[
            {"box": {"maxclass": "toggle", "id": "obj-1",
                     "numinlets": 1, "numoutlets": 1,
                     "outlettype": ["int"],
                     "parameter_enable": 0,
                     "patching_rect": [100, 100, 24, 24]}},
        ])
        results = validate_patch(patch, db=db)
        errors = [r for r in results
                  if r.layer == "objects" and r.level == "error"
                  and "maxclass" in r.message.lower()]
        assert errors == []

    def test_structural_maxclass_no_error(self, db):
        """Structural maxclasses (inlet, outlet) do not trigger error."""
        patch = _make_patch_dict(boxes=[
            {"box": {"maxclass": "inlet", "id": "obj-1",
                     "numinlets": 0, "numoutlets": 1,
                     "outlettype": [""],
                     "patching_rect": [0, 0, 30, 30]}},
            {"box": {"maxclass": "outlet", "id": "obj-2",
                     "numinlets": 1, "numoutlets": 0,
                     "outlettype": [],
                     "patching_rect": [0, 50, 30, 30]}},
        ])
        results = validate_patch(patch, db=db)
        errors = [r for r in results
                  if r.layer == "objects" and r.level == "error"
                  and "maxclass" in r.message.lower()]
        assert errors == []

    def test_standard_newobj_no_error(self, db):
        """Standard newobj box does not trigger maxclass error."""
        patch = _make_patch_dict(boxes=[
            {"box": {"maxclass": "newobj", "text": "cycle~ 440",
                     "id": "obj-1",
                     "numinlets": 2, "numoutlets": 1,
                     "outlettype": ["signal"],
                     "patching_rect": [100, 100, 80, 22]}},
        ])
        results = validate_patch(patch, db=db)
        errors = [r for r in results
                  if r.layer == "objects" and r.level == "error"
                  and "maxclass" in r.message.lower()]
        assert errors == []

    def test_ui_widgets_button_dial_gain_pass(self, db):
        """Three UI widgets (button, dial, gain~) using their own maxclass pass."""
        patch = _make_patch_dict(boxes=[
            {"box": {"maxclass": "button", "id": "obj-1",
                     "numinlets": 1, "numoutlets": 1,
                     "outlettype": ["bang"],
                     "parameter_enable": 0,
                     "patching_rect": [100, 100, 24, 24]}},
            {"box": {"maxclass": "dial", "id": "obj-2",
                     "numinlets": 1, "numoutlets": 1,
                     "outlettype": ["float"],
                     "parameter_enable": 0,
                     "patching_rect": [150, 100, 40, 40]}},
            {"box": {"maxclass": "gain~", "id": "obj-3",
                     "numinlets": 2, "numoutlets": 2,
                     "outlettype": ["signal", ""],
                     "parameter_enable": 0,
                     "patching_rect": [200, 100, 22, 140]}},
        ])
        results = validate_patch(patch, db=db)
        errors = [r for r in results
                  if r.layer == "objects" and r.level == "error"
                  and "maxclass" in r.message.lower()]
        assert errors == []

    def test_multiple_non_ui_own_maxclass_each_errors(self, db):
        """Three boxes each using own name as maxclass produce three errors."""
        patch = _make_patch_dict(boxes=[
            {"box": {"maxclass": "cycle~", "text": "cycle~ 440",
                     "id": "obj-1",
                     "numinlets": 2, "numoutlets": 1,
                     "outlettype": ["signal"],
                     "patching_rect": [100, 100, 80, 22]}},
            {"box": {"maxclass": "*~", "text": "*~ 0.5",
                     "id": "obj-2",
                     "numinlets": 2, "numoutlets": 1,
                     "outlettype": ["signal"],
                     "patching_rect": [200, 100, 60, 22]}},
            {"box": {"maxclass": "pack", "text": "pack 0 0",
                     "id": "obj-3",
                     "numinlets": 2, "numoutlets": 1,
                     "outlettype": [""],
                     "patching_rect": [300, 100, 60, 22]}},
        ])
        results = validate_patch(patch, db=db)
        errors = [r for r in results
                  if r.layer == "objects" and r.level == "error"
                  and "wrong maxclass" in r.message.lower()]
        assert len(errors) == 3

    def test_subpatcher_container_with_patcher_key_passes(self, db):
        """Box with maxclass='gen~' AND embedded patcher key is a legitimate
        subpatcher container — should not trigger maxclass error."""
        patch = _make_patch_dict(boxes=[
            {"box": {"maxclass": "gen~", "id": "obj-1",
                     "numinlets": 1, "numoutlets": 1,
                     "outlettype": ["signal"],
                     "patching_rect": [100, 100, 80, 22],
                     "patcher": {"boxes": [], "lines": []}}},
        ])
        results = validate_patch(patch, db=db)
        errors = [r for r in results
                  if r.layer == "objects" and r.level == "error"
                  and "maxclass" in r.message.lower()]
        assert errors == []

    def test_error_message_includes_correct_pair(self, db):
        """Error message must contain both wrong pair AND correct pair."""
        patch = _make_patch_dict(boxes=[
            {"box": {"maxclass": "cycle~", "text": "cycle~ 440",
                     "id": "obj-1",
                     "numinlets": 2, "numoutlets": 1,
                     "outlettype": ["signal"],
                     "patching_rect": [100, 100, 80, 22]}},
        ])
        results = validate_patch(patch, db=db)
        errors = [r for r in results
                  if r.layer == "objects" and r.level == "error"
                  and "wrong maxclass" in r.message.lower()]
        assert len(errors) == 1
        msg = errors[0].message
        # Wrong pair
        assert "maxclass='cycle~'" in msg
        # Correct pair components
        assert "maxclass='newobj'" in msg
        assert "text='cycle~" in msg


class TestPackageValidation:
    """PKG-13: validate_patch with allowed_packages catches package violations."""

    def test_no_allowed_packages_no_package_errors(self, db):
        """Backward compat: no allowed_packages produces no package errors."""
        patch = _make_patch_dict(boxes=[
            _make_box("obj-1", text="abl.device.autofilter~",
                      numinlets=3, numoutlets=2, outlettype=["signal", ""]),
        ])
        results = validate_patch(patch, db=db)
        pkg_errors = [r for r in results if r.layer == "packages"]
        assert pkg_errors == []

    def test_empty_allowed_flags_package_objects(self, db):
        """allowed_packages=[] flags package objects as errors."""
        patch = _make_patch_dict(boxes=[
            _make_box("obj-1", text="abl.device.autofilter~",
                      numinlets=3, numoutlets=2, outlettype=["signal", ""]),
        ])
        results = validate_patch(patch, db=db, allowed_packages=[])
        pkg_errors = [r for r in results if r.layer == "packages"]
        assert len(pkg_errors) == 1
        assert pkg_errors[0].level == "error"
        assert "abl.device.autofilter~" in pkg_errors[0].message
        assert "ableton-dsp" in pkg_errors[0].message

    def test_matching_package_no_error(self, db):
        """allowed_packages=["ableton-dsp"] does not flag ableton-dsp objects."""
        patch = _make_patch_dict(boxes=[
            _make_box("obj-1", text="abl.device.autofilter~",
                      numinlets=3, numoutlets=2, outlettype=["signal", ""]),
        ])
        results = validate_patch(patch, db=db, allowed_packages=["ableton-dsp"])
        pkg_errors = [r for r in results if r.layer == "packages"]
        assert pkg_errors == []

    def test_wrong_package_flags_error(self, db):
        """allowed_packages=["BEAP"] flags ableton-dsp objects as errors."""
        patch = _make_patch_dict(boxes=[
            _make_box("obj-1", text="abl.device.autofilter~",
                      numinlets=3, numoutlets=2, outlettype=["signal", ""]),
        ])
        results = validate_patch(patch, db=db, allowed_packages=["BEAP"])
        pkg_errors = [r for r in results if r.layer == "packages"]
        assert len(pkg_errors) == 1
        assert "ableton-dsp" in pkg_errors[0].message

    def test_core_objects_never_flagged(self, db):
        """Core objects are not flagged regardless of allowed_packages."""
        patch = _make_patch_dict(boxes=[
            _make_box("obj-1", text="cycle~ 440"),
        ])
        results = validate_patch(patch, db=db, allowed_packages=[])
        pkg_errors = [r for r in results if r.layer == "packages"]
        assert pkg_errors == []

    def test_package_errors_have_correct_layer_and_level(self, db):
        """Package validation errors use layer='packages' and level='error'."""
        patch = _make_patch_dict(boxes=[
            _make_box("obj-1", text="abl.device.autofilter~",
                      numinlets=3, numoutlets=2, outlettype=["signal", ""]),
        ])
        results = validate_patch(patch, db=db, allowed_packages=[])
        pkg_errors = [r for r in results if r.layer == "packages"]
        assert len(pkg_errors) >= 1
        for err in pkg_errors:
            assert err.layer == "packages"
            assert err.level == "error"

    def test_patcher_instance_uses_own_allowed_packages(self, db):
        """validate_patch reads allowed_packages from Patcher instance."""
        p = Patcher()
        p.add_box("abl.device.autofilter~")
        p.allowed_packages = []  # Set after creation to simulate
        results = validate_patch(p)
        pkg_errors = [r for r in results if r.layer == "packages"]
        assert len(pkg_errors) == 1


# ===========================================================================
# Layer 2d: Community Package Extracted Check
# ===========================================================================

class TestCommunityPackageBlock:
    """PKG-21: Warn when patch uses objects from unextracted community packages."""

    def test_community_block_warning(self, db):
        """Patch with fluid.ampfeature~ produces warning when FluCoMa extracted=false."""
        patch = _make_patch_dict(boxes=[
            _make_box("obj-1", text="fluid.ampfeature~",
                      numinlets=1, numoutlets=2, outlettype=["signal", ""]),
        ])
        results = validate_patch(patch, db=db)
        pkg_warnings = [r for r in results if r.layer == "packages" and r.level == "warning"]
        assert len(pkg_warnings) >= 1
        msg = pkg_warnings[0].message
        assert "FluCoMa" in msg
        assert "not extracted" in msg
        assert "extract_objects.py --package" in msg
        assert "Package Manager" in msg

    def test_bundled_no_community_warning(self, db):
        """Patch with ableton-dsp object produces no community extraction warning."""
        patch = _make_patch_dict(boxes=[
            _make_box("obj-1", text="abl.device.autofilter~",
                      numinlets=3, numoutlets=2, outlettype=["signal", ""]),
        ])
        results = validate_patch(patch, db=db)
        pkg_warnings = [r for r in results
                        if r.layer == "packages" and r.level == "warning"
                        and "not extracted" in r.message]
        assert len(pkg_warnings) == 0

    def test_core_no_community_warning(self, db):
        """Patch with core object (cycle~) produces no community extraction warning."""
        patch = _make_patch_dict(boxes=[
            _make_box("obj-1", text="cycle~ 440",
                      numinlets=2, numoutlets=1, outlettype=["signal"]),
        ])
        results = validate_patch(patch, db=db)
        pkg_warnings = [r for r in results
                        if r.layer == "packages" and r.level == "warning"
                        and "not extracted" in r.message]
        assert len(pkg_warnings) == 0

    def test_no_warning_when_extracted(self, db, monkeypatch):
        """No warning when FluCoMa extracted=true."""
        # Monkeypatch the package info to set extracted=true
        original_info = db.get_package_info("FluCoMa")
        patched_info = dict(original_info) if original_info else {}
        patched_info["extracted"] = True
        monkeypatch.setitem(db._package_info, "FluCoMa", patched_info)

        patch = _make_patch_dict(boxes=[
            _make_box("obj-1", text="fluid.ampfeature~",
                      numinlets=1, numoutlets=2, outlettype=["signal", ""]),
        ])
        results = validate_patch(patch, db=db)
        pkg_warnings = [r for r in results
                        if r.layer == "packages" and r.level == "warning"
                        and "not extracted" in r.message]
        assert len(pkg_warnings) == 0

    def test_ircam_spat_specific_message(self, db):
        """IRCAM Spat gets a specific download message, not Package Manager."""
        patch = _make_patch_dict(boxes=[
            _make_box("obj-1", text="spat5.panning~",
                      numinlets=2, numoutlets=2, outlettype=["signal", ""]),
        ])
        results = validate_patch(patch, db=db)
        pkg_warnings = [r for r in results
                        if r.layer == "packages" and r.level == "warning"
                        and "IRCAM Spat" in r.message]
        assert len(pkg_warnings) >= 1
        msg = pkg_warnings[0].message
        assert "forum.ircam.fr" in msg
        assert "extract_objects.py --package" in msg
