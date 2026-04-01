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
    """Non-UI objects using their own name as maxclass should be flagged."""

    def test_non_ui_object_wrong_maxclass_triggers_warning(self, db):
        """Object like cycle~ using maxclass='cycle~' instead of 'newobj' gets warning."""
        patch = _make_patch_dict(boxes=[
            {"box": {"maxclass": "cycle~", "text": "cycle~ 440",
                     "id": "obj-1",
                     "numinlets": 2, "numoutlets": 1,
                     "outlettype": ["signal"],
                     "patching_rect": [100, 100, 80, 22]}},
        ])
        results = validate_patch(patch, db=db)
        warnings = [r for r in results
                    if r.layer == "objects" and r.level == "warning"
                    and "maxclass" in r.message.lower()
                    and "cycle~" in r.message]
        assert len(warnings) == 1

    def test_ui_object_own_maxclass_no_warning(self, db):
        """UI objects like toggle correctly use their own name as maxclass."""
        patch = _make_patch_dict(boxes=[
            {"box": {"maxclass": "toggle", "id": "obj-1",
                     "numinlets": 1, "numoutlets": 1,
                     "outlettype": ["int"],
                     "parameter_enable": 0,
                     "patching_rect": [100, 100, 24, 24]}},
        ])
        results = validate_patch(patch, db=db)
        warnings = [r for r in results
                    if r.layer == "objects" and r.level == "warning"
                    and "maxclass" in r.message.lower()]
        assert warnings == []

    def test_structural_maxclass_no_warning(self, db):
        """Structural maxclasses (inlet, outlet) do not trigger warning."""
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
        warnings = [r for r in results
                    if r.layer == "objects" and r.level == "warning"
                    and "maxclass" in r.message.lower()]
        assert warnings == []

    def test_standard_newobj_no_warning(self, db):
        """Standard newobj box does not trigger maxclass warning."""
        patch = _make_patch_dict(boxes=[
            {"box": {"maxclass": "newobj", "text": "cycle~ 440",
                     "id": "obj-1",
                     "numinlets": 2, "numoutlets": 1,
                     "outlettype": ["signal"],
                     "patching_rect": [100, 100, 80, 22]}},
        ])
        results = validate_patch(patch, db=db)
        warnings = [r for r in results
                    if r.layer == "objects" and r.level == "warning"
                    and "maxclass" in r.message.lower()]
        assert warnings == []
