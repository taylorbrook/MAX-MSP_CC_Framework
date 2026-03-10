"""Tests for the critic system -- DSP and structure critics.

Critics perform semantic/architectural review of generated patches,
catching design problems (missing gain staging, gen~ I/O mismatches,
fan-out without trigger) that the mechanical validation pipeline
does not detect.
"""

from __future__ import annotations

import pytest

from src.maxpat.critics.base import CriticResult
from src.maxpat.critics.dsp_critic import review_dsp
from src.maxpat.critics import review_patch


# ===========================================================================
# Fixtures: Patch dicts for DSP critic tests
# ===========================================================================

def _make_patch(boxes: list[dict], lines: list[dict]) -> dict:
    """Helper to build a minimal patch_dict."""
    return {
        "patcher": {
            "boxes": [{"box": b} for b in boxes],
            "lines": [{"patchline": pl} for pl in lines],
        }
    }


# --- gen~ I/O mismatch fixtures ---

def _gen_io_mismatch_patch() -> tuple[dict, dict]:
    """Patch with gen~ box (2 inlets, 1 outlet) but GenExpr code using 3 inputs.

    The codebox inside gen~ has code referencing in1, in2, in3 but the
    gen~ box only has 2 inlets -- this is a mismatch.
    """
    genexpr_code = "out1 = in1 + in2 + in3;"

    boxes = [
        {
            "id": "obj-1",
            "maxclass": "gen~",
            "text": "gen~",
            "numinlets": 2,
            "numoutlets": 1,
            "outlettype": ["signal"],
            "patcher": {
                "boxes": [
                    {"box": {
                        "id": "cb-1",
                        "maxclass": "codebox",
                        "code": genexpr_code,
                        "numinlets": 3,
                        "numoutlets": 1,
                    }},
                ],
                "lines": [],
            },
        },
    ]
    lines = []
    code_context = {"gen~_code": {"obj-1": genexpr_code}}
    return _make_patch(boxes, lines), code_context


def _gen_output_mismatch_patch() -> tuple[dict, dict]:
    """Patch with gen~ box (1 outlet) but GenExpr code using 2 outputs."""
    genexpr_code = "out1 = in1; out2 = in1 * 0.5;"

    boxes = [
        {
            "id": "obj-1",
            "maxclass": "gen~",
            "text": "gen~",
            "numinlets": 1,
            "numoutlets": 1,
            "outlettype": ["signal"],
            "patcher": {
                "boxes": [
                    {"box": {
                        "id": "cb-1",
                        "maxclass": "codebox",
                        "code": genexpr_code,
                        "numinlets": 1,
                        "numoutlets": 1,
                    }},
                ],
                "lines": [],
            },
        },
    ]
    lines = []
    code_context = {"gen~_code": {"obj-1": genexpr_code}}
    return _make_patch(boxes, lines), code_context


# --- Gain staging fixtures ---

def _no_gain_staging_patch() -> dict:
    """cycle~ directly connected to dac~ -- missing gain staging."""
    boxes = [
        {
            "id": "obj-1",
            "maxclass": "newobj",
            "text": "cycle~ 440",
            "numinlets": 2,
            "numoutlets": 1,
            "outlettype": ["signal"],
        },
        {
            "id": "obj-2",
            "maxclass": "newobj",
            "text": "dac~",
            "numinlets": 2,
            "numoutlets": 0,
            "outlettype": [],
        },
    ]
    lines = [
        {"source": ["obj-1", 0], "destination": ["obj-2", 0]},
    ]
    return _make_patch(boxes, lines)


def _proper_gain_staging_patch() -> dict:
    """cycle~ -> *~ 0.5 -> dac~ -- proper gain staging."""
    boxes = [
        {
            "id": "obj-1",
            "maxclass": "newobj",
            "text": "cycle~ 440",
            "numinlets": 2,
            "numoutlets": 1,
            "outlettype": ["signal"],
        },
        {
            "id": "obj-2",
            "maxclass": "newobj",
            "text": "*~ 0.5",
            "numinlets": 2,
            "numoutlets": 1,
            "outlettype": ["signal"],
        },
        {
            "id": "obj-3",
            "maxclass": "newobj",
            "text": "dac~",
            "numinlets": 2,
            "numoutlets": 0,
            "outlettype": [],
        },
    ]
    lines = [
        {"source": ["obj-1", 0], "destination": ["obj-2", 0]},
        {"source": ["obj-2", 0], "destination": ["obj-3", 0]},
    ]
    return _make_patch(boxes, lines)


def _noise_no_gain_patch() -> dict:
    """noise~ directly to ezdac~ -- missing gain staging."""
    boxes = [
        {
            "id": "obj-1",
            "maxclass": "newobj",
            "text": "noise~",
            "numinlets": 1,
            "numoutlets": 1,
            "outlettype": ["signal"],
        },
        {
            "id": "obj-2",
            "maxclass": "newobj",
            "text": "ezdac~",
            "numinlets": 2,
            "numoutlets": 0,
            "outlettype": [],
        },
    ]
    lines = [
        {"source": ["obj-1", 0], "destination": ["obj-2", 0]},
    ]
    return _make_patch(boxes, lines)


# --- Audio rate consistency fixtures ---

def _control_to_signal_patch() -> dict:
    """Control-rate number box connected to signal inlet of *~."""
    boxes = [
        {
            "id": "obj-1",
            "maxclass": "number",
            "text": "",
            "numinlets": 1,
            "numoutlets": 2,
            "outlettype": ["", ""],
        },
        {
            "id": "obj-2",
            "maxclass": "newobj",
            "text": "*~ 1.",
            "numinlets": 2,
            "numoutlets": 1,
            "outlettype": ["signal"],
        },
    ]
    lines = [
        {"source": ["obj-1", 0], "destination": ["obj-2", 0]},
    ]
    return _make_patch(boxes, lines)


def _signal_to_signal_patch() -> dict:
    """Signal connection cycle~ -> *~ -- clean, no warnings expected."""
    boxes = [
        {
            "id": "obj-1",
            "maxclass": "newobj",
            "text": "cycle~ 440",
            "numinlets": 2,
            "numoutlets": 1,
            "outlettype": ["signal"],
        },
        {
            "id": "obj-2",
            "maxclass": "newobj",
            "text": "*~ 0.5",
            "numinlets": 2,
            "numoutlets": 1,
            "outlettype": ["signal"],
        },
    ]
    lines = [
        {"source": ["obj-1", 0], "destination": ["obj-2", 0]},
    ]
    return _make_patch(boxes, lines)


# ===========================================================================
# CriticResult tests
# ===========================================================================

class TestCriticResult:
    """Test the CriticResult data type."""

    def test_create_critic_result(self):
        r = CriticResult("blocker", "Gen~ I/O mismatch", "Fix the codebox")
        assert r.severity == "blocker"
        assert r.finding == "Gen~ I/O mismatch"
        assert r.suggestion == "Fix the codebox"

    def test_repr(self):
        r = CriticResult("warning", "Missing gain", "Add *~")
        assert "warning" in repr(r)
        assert "Missing gain" in repr(r)


# ===========================================================================
# DSP Critic tests
# ===========================================================================

class TestDSPCritic:
    """Test the DSP critic checks."""

    def test_gen_input_mismatch_detected(self):
        """gen~ with fewer inlets than codebox inputs -> blocker."""
        patch, code_ctx = _gen_io_mismatch_patch()
        results = review_dsp(patch, code_context=code_ctx)
        blockers = [r for r in results if r.severity == "blocker"]
        assert len(blockers) >= 1
        assert any("input" in r.finding.lower() or "inlet" in r.finding.lower() for r in blockers)

    def test_gen_output_mismatch_detected(self):
        """gen~ with fewer outlets than codebox outputs -> blocker."""
        patch, code_ctx = _gen_output_mismatch_patch()
        results = review_dsp(patch, code_context=code_ctx)
        blockers = [r for r in results if r.severity == "blocker"]
        assert len(blockers) >= 1
        assert any("output" in r.finding.lower() or "outlet" in r.finding.lower() for r in blockers)

    def test_missing_gain_staging_cycle(self):
        """cycle~ directly to dac~ -> warning about missing gain staging."""
        patch = _no_gain_staging_patch()
        results = review_dsp(patch)
        warnings = [r for r in results if r.severity == "warning"]
        assert len(warnings) >= 1
        assert any("gain" in r.finding.lower() for r in warnings)

    def test_missing_gain_staging_noise(self):
        """noise~ directly to ezdac~ -> warning about missing gain staging."""
        patch = _noise_no_gain_patch()
        results = review_dsp(patch)
        warnings = [r for r in results if r.severity == "warning"]
        assert len(warnings) >= 1
        assert any("gain" in r.finding.lower() for r in warnings)

    def test_proper_gain_staging_no_warning(self):
        """cycle~ -> *~ 0.5 -> dac~ -> no gain staging warning."""
        patch = _proper_gain_staging_patch()
        results = review_dsp(patch)
        gain_warnings = [r for r in results if r.severity == "warning" and "gain" in r.finding.lower()]
        assert len(gain_warnings) == 0

    def test_control_to_signal_warning(self):
        """Control-rate number to signal inlet of *~ -> warning."""
        patch = _control_to_signal_patch()
        results = review_dsp(patch)
        warnings = [r for r in results if r.severity == "warning"]
        assert len(warnings) >= 1
        assert any("rate" in r.finding.lower() or "control" in r.finding.lower() for r in warnings)

    def test_signal_to_signal_clean(self):
        """Signal-to-signal connection -> no audio rate warnings."""
        patch = _signal_to_signal_patch()
        results = review_dsp(patch)
        rate_warnings = [r for r in results if r.severity == "warning" and ("rate" in r.finding.lower() or "control" in r.finding.lower())]
        assert len(rate_warnings) == 0


# ===========================================================================
# review_patch integration tests (DSP only for now -- structure added in Task 2)
# ===========================================================================

class TestReviewPatch:
    """Test the public review_patch() API."""

    def test_review_patch_returns_list(self):
        """review_patch always returns a list of CriticResult."""
        patch = _proper_gain_staging_patch()
        results = review_patch(patch)
        assert isinstance(results, list)
        for r in results:
            assert isinstance(r, CriticResult)

    def test_review_patch_catches_gain_issue(self):
        """review_patch finds gain staging issue via DSP critic."""
        patch = _no_gain_staging_patch()
        results = review_patch(patch)
        assert any("gain" in r.finding.lower() for r in results)
