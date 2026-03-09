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

    def test_unknown_object_error(self, db):
        """Completely unknown object produces an error."""
        patch = _make_patch_dict(boxes=[
            _make_box("obj-1", text="fake_object_xyz 123")
        ])
        results = validate_patch(patch, db=db)
        obj_errors = [r for r in results if r.layer == "objects" and r.level == "error"]
        assert len(obj_errors) >= 1
        assert "fake_object_xyz" in obj_errors[0].message

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
