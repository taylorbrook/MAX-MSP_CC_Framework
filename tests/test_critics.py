"""Tests for the critic system -- DSP, structure, RNBO, and external critics.

Critics perform semantic/architectural review of generated patches,
catching design problems (missing gain staging, gen~ I/O mismatches,
fan-out without trigger, RNBO param issues, external code issues) that
the mechanical validation pipeline does not detect.
"""

from __future__ import annotations

import pytest

from src.maxpat.critics.base import CriticResult
from src.maxpat.critics.dsp_critic import review_dsp, _is_normalizer, _GAIN_NAMES
from src.maxpat.critics.structure_critic import review_structure
from src.maxpat.critics.rnbo_critic import review_rnbo
from src.maxpat.critics.ext_critic import review_external
from src.maxpat.critics.layout_critic import review_layout
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
        """cycle~ directly to dac~ -> blocker about missing gain staging."""
        patch = _no_gain_staging_patch()
        results = review_dsp(patch)
        blockers = [r for r in results if r.severity == "blocker"]
        assert len(blockers) >= 1
        assert any("gain" in r.finding.lower() for r in blockers)

    def test_missing_gain_staging_noise(self):
        """noise~ directly to ezdac~ -> blocker about missing gain staging."""
        patch = _noise_no_gain_patch()
        results = review_dsp(patch)
        blockers = [r for r in results if r.severity == "blocker"]
        assert len(blockers) >= 1
        assert any("gain" in r.finding.lower() for r in blockers)

    def test_proper_gain_staging_no_warning(self):
        """cycle~ -> *~ 0.5 -> dac~ -> no gain staging warning or blocker."""
        patch = _proper_gain_staging_patch()
        results = review_dsp(patch)
        gain_issues = [r for r in results if r.severity in ("warning", "blocker") and "gain" in r.finding.lower()]
        assert len(gain_issues) == 0

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


# ===========================================================================
# Fixtures: Patch dicts for structure critic tests
# ===========================================================================

def _fan_out_no_trigger_patch() -> dict:
    """One outlet connected to 3 destinations without trigger object."""
    boxes = [
        {
            "id": "obj-1",
            "maxclass": "newobj",
            "text": "metro 500",
            "numinlets": 2,
            "numoutlets": 1,
            "outlettype": ["bang"],
        },
        {
            "id": "obj-2",
            "maxclass": "newobj",
            "text": "counter 0 10",
            "numinlets": 5,
            "numoutlets": 4,
            "outlettype": ["", "", "", ""],
        },
        {
            "id": "obj-3",
            "maxclass": "toggle",
            "text": "",
            "numinlets": 1,
            "numoutlets": 1,
            "outlettype": ["int"],
        },
        {
            "id": "obj-4",
            "maxclass": "newobj",
            "text": "print",
            "numinlets": 1,
            "numoutlets": 0,
            "outlettype": [],
        },
    ]
    lines = [
        {"source": ["obj-1", 0], "destination": ["obj-2", 0]},
        {"source": ["obj-1", 0], "destination": ["obj-3", 0]},
        {"source": ["obj-1", 0], "destination": ["obj-4", 0]},
    ]
    return _make_patch(boxes, lines)


def _fan_out_with_trigger_patch() -> dict:
    """Trigger object fanning out -- no warning expected."""
    boxes = [
        {
            "id": "obj-1",
            "maxclass": "newobj",
            "text": "bang",
            "numinlets": 1,
            "numoutlets": 1,
            "outlettype": ["bang"],
        },
        {
            "id": "obj-2",
            "maxclass": "newobj",
            "text": "trigger b b b",
            "numinlets": 1,
            "numoutlets": 3,
            "outlettype": ["bang", "bang", "bang"],
        },
        {
            "id": "obj-3",
            "maxclass": "newobj",
            "text": "print a",
            "numinlets": 1,
            "numoutlets": 0,
            "outlettype": [],
        },
        {
            "id": "obj-4",
            "maxclass": "newobj",
            "text": "print b",
            "numinlets": 1,
            "numoutlets": 0,
            "outlettype": [],
        },
        {
            "id": "obj-5",
            "maxclass": "newobj",
            "text": "print c",
            "numinlets": 1,
            "numoutlets": 0,
            "outlettype": [],
        },
    ]
    lines = [
        {"source": ["obj-1", 0], "destination": ["obj-2", 0]},
        {"source": ["obj-2", 0], "destination": ["obj-3", 0]},
        {"source": ["obj-2", 1], "destination": ["obj-4", 0]},
        {"source": ["obj-2", 2], "destination": ["obj-5", 0]},
    ]
    return _make_patch(boxes, lines)


def _hot_cold_ordering_issue_patch() -> dict:
    """Two separate sources feed hot and cold inlets of + without trigger."""
    boxes = [
        {
            "id": "obj-1",
            "maxclass": "newobj",
            "text": "metro 500",
            "numinlets": 2,
            "numoutlets": 1,
            "outlettype": ["bang"],
        },
        {
            "id": "obj-2",
            "maxclass": "newobj",
            "text": "random 100",
            "numinlets": 2,
            "numoutlets": 1,
            "outlettype": ["int"],
        },
        {
            "id": "obj-3",
            "maxclass": "newobj",
            "text": "random 50",
            "numinlets": 2,
            "numoutlets": 1,
            "outlettype": ["int"],
        },
        {
            "id": "obj-4",
            "maxclass": "newobj",
            "text": "+",
            "numinlets": 2,
            "numoutlets": 1,
            "outlettype": ["int"],
        },
    ]
    lines = [
        # Two separate sources feeding hot (inlet 0) and cold (inlet 1)
        # of + without trigger-based ordering
        {"source": ["obj-2", 0], "destination": ["obj-4", 0]},
        {"source": ["obj-3", 0], "destination": ["obj-4", 1]},
    ]
    return _make_patch(boxes, lines)


def _duplicate_patchlines_patch() -> dict:
    """Patch with duplicate connections."""
    boxes = [
        {
            "id": "obj-1",
            "maxclass": "newobj",
            "text": "metro 500",
            "numinlets": 2,
            "numoutlets": 1,
            "outlettype": ["bang"],
        },
        {
            "id": "obj-2",
            "maxclass": "newobj",
            "text": "print",
            "numinlets": 1,
            "numoutlets": 0,
            "outlettype": [],
        },
    ]
    lines = [
        {"source": ["obj-1", 0], "destination": ["obj-2", 0]},
        {"source": ["obj-1", 0], "destination": ["obj-2", 0]},
    ]
    return _make_patch(boxes, lines)


def _clean_structure_patch() -> dict:
    """Clean patch with no structure issues."""
    boxes = [
        {
            "id": "obj-1",
            "maxclass": "newobj",
            "text": "metro 500",
            "numinlets": 2,
            "numoutlets": 1,
            "outlettype": ["bang"],
        },
        {
            "id": "obj-2",
            "maxclass": "newobj",
            "text": "counter 0 10",
            "numinlets": 5,
            "numoutlets": 4,
            "outlettype": ["", "", "", ""],
        },
    ]
    lines = [
        {"source": ["obj-1", 0], "destination": ["obj-2", 0]},
    ]
    return _make_patch(boxes, lines)


# ===========================================================================
# Structure Critic tests
# ===========================================================================

class TestStructureCritic:
    """Test the structure critic checks."""

    def test_fan_out_without_trigger_detected(self):
        """One outlet to 3 destinations without trigger -> warning."""
        patch = _fan_out_no_trigger_patch()
        results = review_structure(patch)
        warnings = [r for r in results if r.severity == "warning"]
        assert len(warnings) >= 1
        assert any("fan" in r.finding.lower() or "trigger" in r.finding.lower() for r in warnings)

    def test_fan_out_with_trigger_no_warning(self):
        """Trigger object fanning out -> no fan-out warning."""
        patch = _fan_out_with_trigger_patch()
        results = review_structure(patch)
        fan_warnings = [
            r for r in results
            if r.severity == "warning" and "fan" in r.finding.lower()
        ]
        assert len(fan_warnings) == 0

    def test_hot_cold_ordering_detected(self):
        """Multiple sources feeding hot+cold inlets without trigger -> warning."""
        patch = _hot_cold_ordering_issue_patch()
        results = review_structure(patch)
        warnings = [r for r in results if r.severity == "warning"]
        assert len(warnings) >= 1
        assert any(
            "hot" in r.finding.lower() or "cold" in r.finding.lower()
            or "ordering" in r.finding.lower() or "order" in r.finding.lower()
            for r in warnings
        )

    def test_duplicate_patchlines_detected(self):
        """Duplicate connections -> warning."""
        patch = _duplicate_patchlines_patch()
        results = review_structure(patch)
        warnings = [r for r in results if r.severity == "warning"]
        assert len(warnings) >= 1
        assert any("duplicate" in r.finding.lower() or "redundant" in r.finding.lower() for r in warnings)

    def test_clean_patch_no_warnings(self):
        """Clean patch -> no structure warnings."""
        patch = _clean_structure_patch()
        results = review_structure(patch)
        assert len(results) == 0


# ===========================================================================
# review_patch combined integration tests
# ===========================================================================

class TestReviewPatchCombined:
    """Test review_patch() combining DSP and structure critics."""

    def test_review_patch_combines_both_critics(self):
        """review_patch catches both DSP and structure issues."""
        # Create a patch with both gain staging issue AND fan-out issue
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
            {
                "id": "obj-3",
                "maxclass": "newobj",
                "text": "metro 500",
                "numinlets": 2,
                "numoutlets": 1,
                "outlettype": ["bang"],
            },
            {
                "id": "obj-4",
                "maxclass": "newobj",
                "text": "print a",
                "numinlets": 1,
                "numoutlets": 0,
                "outlettype": [],
            },
            {
                "id": "obj-5",
                "maxclass": "newobj",
                "text": "print b",
                "numinlets": 1,
                "numoutlets": 0,
                "outlettype": [],
            },
        ]
        lines = [
            {"source": ["obj-1", 0], "destination": ["obj-2", 0]},
            {"source": ["obj-3", 0], "destination": ["obj-4", 0]},
            {"source": ["obj-3", 0], "destination": ["obj-5", 0]},
        ]
        patch = _make_patch(boxes, lines)
        results = review_patch(patch)

        # Should have both gain staging and fan-out warnings
        has_gain = any("gain" in r.finding.lower() for r in results)
        has_fan_out = any("fan" in r.finding.lower() or "trigger" in r.finding.lower() for r in results)
        assert has_gain, "Expected gain staging warning from DSP critic"
        assert has_fan_out, "Expected fan-out warning from structure critic"

    def test_clean_patch_no_results(self):
        """Clean patch with proper gain staging and no structure issues."""
        patch = _proper_gain_staging_patch()
        results = review_patch(patch)
        assert len(results) == 0, f"Expected no findings, got: {results}"


# ===========================================================================
# RNBO Critic fixtures
# ===========================================================================

def _rnbo_patch_with_pascal_case_params() -> dict:
    """RNBO patch with PascalCase param names -- should warn."""
    return {
        "patcher": {
            "boxes": [
                {"box": {
                    "id": "obj-1",
                    "maxclass": "rnbo~",
                    "text": "rnbo~",
                    "numinlets": 3,
                    "numoutlets": 3,
                    "patcher": {
                        "boxes": [
                            {"box": {
                                "id": "obj-10",
                                "maxclass": "newobj",
                                "text": "in~ 1",
                                "numinlets": 0,
                                "numoutlets": 1,
                            }},
                            {"box": {
                                "id": "obj-11",
                                "maxclass": "newobj",
                                "text": "out~ 1",
                                "numinlets": 1,
                                "numoutlets": 0,
                            }},
                            {"box": {
                                "id": "obj-12",
                                "maxclass": "newobj",
                                "text": "param @name GainLevel @min 0 @max 1 @initial 0.5",
                                "numinlets": 2,
                                "numoutlets": 2,
                            }},
                            {"box": {
                                "id": "obj-13",
                                "maxclass": "newobj",
                                "text": "param @name FilterCutoff @min 20 @max 20000 @initial 1000",
                                "numinlets": 2,
                                "numoutlets": 2,
                            }},
                        ],
                        "lines": [],
                    },
                }},
            ],
            "lines": [],
        }
    }


def _rnbo_patch_missing_io() -> dict:
    """RNBO patch with no in~/out~ in inner patcher -- blocker."""
    return {
        "patcher": {
            "boxes": [
                {"box": {
                    "id": "obj-1",
                    "maxclass": "rnbo~",
                    "text": "rnbo~",
                    "numinlets": 3,
                    "numoutlets": 3,
                    "patcher": {
                        "boxes": [
                            {"box": {
                                "id": "obj-10",
                                "maxclass": "newobj",
                                "text": "param @name gain @min 0 @max 1 @initial 0.5",
                                "numinlets": 2,
                                "numoutlets": 2,
                            }},
                        ],
                        "lines": [],
                    },
                }},
            ],
            "lines": [],
        }
    }


def _rnbo_patch_duplicate_params() -> dict:
    """RNBO patch with duplicate param names -- blocker."""
    return {
        "patcher": {
            "boxes": [
                {"box": {
                    "id": "obj-1",
                    "maxclass": "rnbo~",
                    "text": "rnbo~",
                    "numinlets": 3,
                    "numoutlets": 3,
                    "patcher": {
                        "boxes": [
                            {"box": {
                                "id": "obj-10",
                                "maxclass": "newobj",
                                "text": "in~ 1",
                                "numinlets": 0,
                                "numoutlets": 1,
                            }},
                            {"box": {
                                "id": "obj-11",
                                "maxclass": "newobj",
                                "text": "out~ 1",
                                "numinlets": 1,
                                "numoutlets": 0,
                            }},
                            {"box": {
                                "id": "obj-12",
                                "maxclass": "newobj",
                                "text": "param @name gain @min 0 @max 1 @initial 0.5",
                                "numinlets": 2,
                                "numoutlets": 2,
                            }},
                            {"box": {
                                "id": "obj-13",
                                "maxclass": "newobj",
                                "text": "param @name gain @min 0 @max 2 @initial 1.0",
                                "numinlets": 2,
                                "numoutlets": 2,
                            }},
                        ],
                        "lines": [],
                    },
                }},
            ],
            "lines": [],
        }
    }


def _rnbo_patch_clean() -> dict:
    """Well-formed RNBO patch -- no findings expected."""
    return {
        "patcher": {
            "boxes": [
                {"box": {
                    "id": "obj-1",
                    "maxclass": "rnbo~",
                    "text": "rnbo~",
                    "numinlets": 3,
                    "numoutlets": 3,
                    "patcher": {
                        "boxes": [
                            {"box": {
                                "id": "obj-10",
                                "maxclass": "newobj",
                                "text": "in~ 1",
                                "numinlets": 0,
                                "numoutlets": 1,
                            }},
                            {"box": {
                                "id": "obj-11",
                                "maxclass": "newobj",
                                "text": "out~ 1",
                                "numinlets": 1,
                                "numoutlets": 0,
                            }},
                            {"box": {
                                "id": "obj-12",
                                "maxclass": "newobj",
                                "text": "param @name gain_level @min 0 @max 1 @initial 0.5",
                                "numinlets": 2,
                                "numoutlets": 2,
                            }},
                        ],
                        "lines": [],
                    },
                }},
            ],
            "lines": [],
        }
    }


# ===========================================================================
# External critic fixtures
# ===========================================================================

_CLEAN_MESSAGE_EXT = '''\
#include "c74_min.h"

using namespace c74::min;

class my_object : public object<my_object> {
public:
    MIN_DESCRIPTION {"A simple message object"};
    MIN_TAGS {"utilities"};
    MIN_AUTHOR {"Test"};

    inlet<>  input  { this, "(anything) input" };
    outlet<> output { this, "(anything) output" };

    message<> bang { this, "bang",
        MIN_FUNCTION {
            output.send("bang");
            return {};
        }
    };
};

MIN_EXTERNAL(my_object);
'''

_MISSING_MIN_EXTERNAL = '''\
#include "c74_min.h"

using namespace c74::min;

class my_object : public object<my_object> {
public:
    inlet<>  input  { this, "(anything) input" };
    outlet<> output { this, "(anything) output" };
};
'''

_MISSING_INCLUDE = '''\
using namespace c74::min;

class my_object : public object<my_object> {
public:
    inlet<>  input  { this, "(anything) input" };
    outlet<> output { this, "(anything) output" };
};

MIN_EXTERNAL(my_object);
'''

_DSP_NO_OPERATOR = '''\
#include "c74_min.h"

using namespace c74::min;

class my_dsp : public object<my_dsp> {
public:
    inlet<>  input  { this, "(signal) input" };
    outlet<> output { this, "(signal) output" };
};

MIN_EXTERNAL(my_dsp);
'''

_SCHEDULER_NO_TIMER = '''\
#include "c74_min.h"

using namespace c74::min;

class my_sched : public object<my_sched> {
public:
    inlet<>  input  { this, "(toggle) on/off" };
    outlet<> output { this, "(bang) tick" };
};

MIN_EXTERNAL(my_sched);
'''

_CODE_WITH_TODOS = '''\
#include "c74_min.h"

using namespace c74::min;

class my_object : public object<my_object> {
public:
    inlet<>  input  { this, "(anything) input" };
    outlet<> output { this, "(anything) output" };

    // TODO: implement bang handler
    // TODO: add attribute support
};

MIN_EXTERNAL(my_object);
'''


# ===========================================================================
# RNBO Critic tests
# ===========================================================================

class TestRNBOCritic:
    """Test the RNBO critic checks."""

    def test_rnbo_critic_param_naming(self):
        """PascalCase param names should produce warnings."""
        patch = _rnbo_patch_with_pascal_case_params()
        results = review_rnbo(patch)
        warnings = [r for r in results if r.severity == "warning"]
        assert len(warnings) >= 2, f"Expected >=2 param naming warnings, got {warnings}"
        assert any("GainLevel" in r.finding for r in warnings)
        assert any("FilterCutoff" in r.finding for r in warnings)

    def test_rnbo_critic_missing_io(self):
        """Missing in~/out~ in inner patcher should be a blocker."""
        patch = _rnbo_patch_missing_io()
        results = review_rnbo(patch)
        blockers = [r for r in results if r.severity == "blocker"]
        assert len(blockers) >= 1
        assert any("in~" in r.finding.lower() or "out~" in r.finding.lower() for r in blockers)

    def test_rnbo_critic_duplicate_params(self):
        """Duplicate param names should be a blocker."""
        patch = _rnbo_patch_duplicate_params()
        results = review_rnbo(patch)
        blockers = [r for r in results if r.severity == "blocker"]
        assert len(blockers) >= 1
        assert any("duplicate" in r.finding.lower() for r in blockers)

    def test_rnbo_critic_clean(self):
        """Well-formed RNBO patch should produce no findings."""
        patch = _rnbo_patch_clean()
        results = review_rnbo(patch)
        assert len(results) == 0, f"Expected no findings, got: {results}"


# ===========================================================================
# External Critic tests
# ===========================================================================

class TestExternalCritic:
    """Test the external code critic checks."""

    def test_ext_critic_missing_min_external(self):
        """Missing MIN_EXTERNAL should be a blocker."""
        results = review_external(_MISSING_MIN_EXTERNAL, archetype="message")
        blockers = [r for r in results if r.severity == "blocker"]
        assert len(blockers) >= 1
        assert any("MIN_EXTERNAL" in r.finding for r in blockers)

    def test_ext_critic_missing_include(self):
        """Missing c74_min.h include should be a blocker."""
        results = review_external(_MISSING_INCLUDE, archetype="message")
        blockers = [r for r in results if r.severity == "blocker"]
        assert len(blockers) >= 1
        assert any("c74_min.h" in r.finding for r in blockers)

    def test_ext_critic_dsp_no_operator(self):
        """DSP archetype without sample_operator or vector_operator should be a blocker."""
        results = review_external(_DSP_NO_OPERATOR, archetype="dsp")
        blockers = [r for r in results if r.severity == "blocker"]
        assert len(blockers) >= 1
        assert any("operator" in r.finding.lower() for r in blockers)

    def test_ext_critic_scheduler_no_timer(self):
        """Scheduler archetype without timer<> should be a blocker."""
        results = review_external(_SCHEDULER_NO_TIMER, archetype="scheduler")
        blockers = [r for r in results if r.severity == "blocker"]
        assert len(blockers) >= 1
        assert any("timer" in r.finding.lower() for r in blockers)

    def test_ext_critic_todo_notes(self):
        """TODO comments should produce notes."""
        results = review_external(_CODE_WITH_TODOS, archetype="message")
        notes = [r for r in results if r.severity == "note"]
        assert len(notes) >= 1
        assert any("TODO" in r.finding for r in notes)

    def test_ext_critic_clean_message(self):
        """Well-formed message external should produce no blockers."""
        results = review_external(_CLEAN_MESSAGE_EXT, archetype="message")
        blockers = [r for r in results if r.severity == "blocker"]
        assert len(blockers) == 0, f"Expected no blockers, got: {blockers}"


# ===========================================================================
# review_patch RNBO integration tests
# ===========================================================================

class TestReviewPatchRNBO:
    """Test review_patch() auto-invokes RNBO critic when rnbo~ detected."""

    def test_review_patch_includes_rnbo(self):
        """review_patch runs RNBO critic when rnbo~ boxes are in the patch."""
        patch = _rnbo_patch_with_pascal_case_params()
        results = review_patch(patch)
        # Should include RNBO param naming warnings
        rnbo_warnings = [r for r in results if "GainLevel" in r.finding or "FilterCutoff" in r.finding]
        assert len(rnbo_warnings) >= 2, (
            f"Expected RNBO param warnings in review_patch, got: {results}"
        )


# ===========================================================================
# Layout Critic tests
# ===========================================================================

class TestLayoutCritic:
    """Test the layout critic checks (overlap, midpoints, out-of-bounds)."""

    def test_overlapping_boxes_detected(self):
        """Two boxes with overlapping patching_rects produce a warning."""
        boxes = [
            {
                "id": "obj-1",
                "maxclass": "newobj",
                "text": "cycle~ 440",
                "patching_rect": [100.0, 100.0, 80.0, 22.0],
                "numinlets": 2,
                "numoutlets": 1,
            },
            {
                "id": "obj-2",
                "maxclass": "newobj",
                "text": "*~ 0.5",
                "patching_rect": [150.0, 110.0, 60.0, 22.0],
                "numinlets": 2,
                "numoutlets": 1,
            },
        ]
        patch = _make_patch(boxes, [])
        results = review_layout(patch)
        warnings = [r for r in results if r.severity == "warning" and "overlap" in r.finding.lower()]
        assert len(warnings) >= 1, f"Expected overlap warning, got: {results}"

    def test_no_overlap_no_warning(self):
        """Two boxes side-by-side with no overlap produce zero layout findings."""
        boxes = [
            {
                "id": "obj-1",
                "maxclass": "newobj",
                "text": "cycle~ 440",
                "patching_rect": [30.0, 100.0, 80.0, 22.0],
                "numinlets": 2,
                "numoutlets": 1,
            },
            {
                "id": "obj-2",
                "maxclass": "newobj",
                "text": "*~ 0.5",
                "patching_rect": [200.0, 100.0, 60.0, 22.0],
                "numinlets": 2,
                "numoutlets": 1,
            },
        ]
        patch = _make_patch(boxes, [])
        results = review_layout(patch)
        assert len(results) == 0, f"Expected no findings, got: {results}"

    def test_missing_midpoint_horizontal_offset(self):
        """Cable with horizontal offset > HORIZONTAL_THRESHOLD and no midpoints produces a warning."""
        boxes = [
            {
                "id": "obj-1",
                "maxclass": "newobj",
                "text": "metro 500",
                "patching_rect": [30.0, 30.0, 80.0, 22.0],
                "numinlets": 2,
                "numoutlets": 1,
            },
            {
                "id": "obj-2",
                "maxclass": "newobj",
                "text": "print",
                "patching_rect": [200.0, 80.0, 50.0, 22.0],
                "numinlets": 1,
                "numoutlets": 0,
            },
        ]
        lines = [
            {"source": ["obj-1", 0], "destination": ["obj-2", 0]},
        ]
        patch = _make_patch(boxes, lines)
        results = review_layout(patch)
        warnings = [r for r in results if r.severity == "warning" and "midpoint" in r.finding.lower()]
        assert len(warnings) >= 1, f"Expected midpoint warning, got: {results}"

    def test_cable_with_midpoints_no_warning(self):
        """Cable with proper midpoints produces zero findings."""
        boxes = [
            {
                "id": "obj-1",
                "maxclass": "newobj",
                "text": "metro 500",
                "patching_rect": [30.0, 30.0, 80.0, 22.0],
                "numinlets": 2,
                "numoutlets": 1,
            },
            {
                "id": "obj-2",
                "maxclass": "newobj",
                "text": "print",
                "patching_rect": [200.0, 80.0, 50.0, 22.0],
                "numinlets": 1,
                "numoutlets": 0,
            },
        ]
        lines = [
            {
                "source": ["obj-1", 0],
                "destination": ["obj-2", 0],
                "midpoints": [70.0, 55.0, 225.0, 55.0],
            },
        ]
        patch = _make_patch(boxes, lines)
        results = review_layout(patch)
        midpoint_warnings = [r for r in results if "midpoint" in r.finding.lower()]
        assert len(midpoint_warnings) == 0, f"Expected no midpoint warnings, got: {results}"

    def test_upward_cable_no_midpoints(self):
        """Upward-flowing cable without midpoints produces a warning."""
        boxes = [
            {
                "id": "obj-1",
                "maxclass": "newobj",
                "text": "loadbang",
                "patching_rect": [30.0, 200.0, 70.0, 22.0],
                "numinlets": 1,
                "numoutlets": 1,
            },
            {
                "id": "obj-2",
                "maxclass": "newobj",
                "text": "toggle",
                "patching_rect": [30.0, 30.0, 40.0, 22.0],
                "numinlets": 1,
                "numoutlets": 1,
            },
        ]
        lines = [
            {"source": ["obj-1", 0], "destination": ["obj-2", 0]},
        ]
        patch = _make_patch(boxes, lines)
        results = review_layout(patch)
        warnings = [r for r in results if r.severity == "warning" and "midpoint" in r.finding.lower()]
        assert len(warnings) >= 1, f"Expected upward cable midpoint warning, got: {results}"

    def test_negative_position_out_of_bounds(self):
        """Box placed with negative x or y produces an out-of-bounds warning."""
        boxes = [
            {
                "id": "obj-1",
                "maxclass": "newobj",
                "text": "print",
                "patching_rect": [-10.0, 30.0, 50.0, 22.0],
                "numinlets": 1,
                "numoutlets": 0,
            },
        ]
        patch = _make_patch(boxes, [])
        results = review_layout(patch)
        warnings = [r for r in results if r.severity == "warning" and "bounds" in r.finding.lower()]
        assert len(warnings) >= 1, f"Expected out-of-bounds warning, got: {results}"

    def test_empty_patch_no_findings(self):
        """Empty patch (no boxes) produces zero findings."""
        patch = _make_patch([], [])
        results = review_layout(patch)
        assert len(results) == 0, f"Expected no findings, got: {results}"

    def test_collision_pad_exact_touch_warns(self):
        """Boxes exactly touching (0px gap) produce a warning due to COLLISION_PAD=5.0."""
        # obj-1 ends at x=110, obj-2 starts at x=110 -- 0px gap < 5px pad
        boxes = [
            {
                "id": "obj-1",
                "maxclass": "newobj",
                "text": "metro 500",
                "patching_rect": [30.0, 100.0, 80.0, 22.0],
                "numinlets": 2,
                "numoutlets": 1,
            },
            {
                "id": "obj-2",
                "maxclass": "newobj",
                "text": "print",
                "patching_rect": [110.0, 100.0, 50.0, 22.0],
                "numinlets": 1,
                "numoutlets": 0,
            },
        ]
        patch = _make_patch(boxes, [])
        results = review_layout(patch)
        warnings = [r for r in results if r.severity == "warning" and "overlap" in r.finding.lower()]
        assert len(warnings) >= 1, f"Expected overlap warning for touching boxes, got: {results}"

    def test_collision_pad_sufficient_gap_no_warning(self):
        """Boxes separated by > 5px do not produce overlap warning."""
        # obj-1 ends at x=110, obj-2 starts at x=116 -- 6px gap > 5px pad
        boxes = [
            {
                "id": "obj-1",
                "maxclass": "newobj",
                "text": "metro 500",
                "patching_rect": [30.0, 100.0, 80.0, 22.0],
                "numinlets": 2,
                "numoutlets": 1,
            },
            {
                "id": "obj-2",
                "maxclass": "newobj",
                "text": "print",
                "patching_rect": [116.0, 100.0, 50.0, 22.0],
                "numinlets": 1,
                "numoutlets": 0,
            },
        ]
        patch = _make_patch(boxes, [])
        results = review_layout(patch)
        overlap_warnings = [r for r in results if "overlap" in r.finding.lower()]
        assert len(overlap_warnings) == 0, f"Expected no overlap warnings, got: {results}"

# ===========================================================================
# DSP Critic Gain Safety tests
# ===========================================================================

class TestDSPCriticGainSafety:
    """GAIN-SAFETY: DSP critic detects unsafe gain sources and upgrades severity."""

    def test_midi_source_to_gain_inlet_blocker(self):
        """ctlin -> *~ inlet 1 without normalizer = blocker."""
        boxes = [
            {
                "id": "obj-1",
                "maxclass": "newobj",
                "text": "ctlin",
                "numinlets": 1,
                "numoutlets": 3,
                "outlettype": ["", "", ""],
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
            {"source": ["obj-1", 0], "destination": ["obj-2", 1]},
        ]
        patch = _make_patch(boxes, lines)
        results = review_dsp(patch)
        blockers = [r for r in results if r.severity == "blocker" and "unsafe gain" in r.finding.lower()]
        assert len(blockers) >= 1, f"Expected blocker for ctlin->*~ inlet 1, got: {results}"

    def test_signal_source_to_gain_inlet_no_warning(self):
        """cycle~ -> *~ inlet 1 = no unsafe gain warning (signal modulation is fine)."""
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
                "text": "*~ 1.",
                "numinlets": 2,
                "numoutlets": 1,
                "outlettype": ["signal"],
            },
        ]
        lines = [
            {"source": ["obj-1", 0], "destination": ["obj-2", 1]},
        ]
        patch = _make_patch(boxes, lines)
        results = review_dsp(patch)
        gain_blockers = [r for r in results if "unsafe gain" in r.finding.lower()]
        assert len(gain_blockers) == 0, f"Expected no unsafe gain findings for signal source, got: {results}"

    def test_normalized_midi_to_gain_no_warning(self):
        """ctlin -> scale 0 127 0. 1. -> *~ inlet 1 = no warning."""
        boxes = [
            {
                "id": "obj-1",
                "maxclass": "newobj",
                "text": "ctlin",
                "numinlets": 1,
                "numoutlets": 3,
                "outlettype": ["", "", ""],
            },
            {
                "id": "obj-2",
                "maxclass": "newobj",
                "text": "scale 0 127 0. 1.",
                "numinlets": 6,
                "numoutlets": 1,
                "outlettype": [""],
            },
            {
                "id": "obj-3",
                "maxclass": "newobj",
                "text": "*~ 1.",
                "numinlets": 2,
                "numoutlets": 1,
                "outlettype": ["signal"],
            },
        ]
        lines = [
            {"source": ["obj-1", 0], "destination": ["obj-2", 0]},
            {"source": ["obj-2", 0], "destination": ["obj-3", 1]},
        ]
        patch = _make_patch(boxes, lines)
        results = review_dsp(patch)
        gain_blockers = [r for r in results if "unsafe gain" in r.finding.lower()]
        assert len(gain_blockers) == 0, f"Expected no unsafe gain findings after normalization, got: {results}"

    def test_missing_gain_staging_is_now_blocker(self):
        """cycle~ -> dac~ = blocker (not warning)."""
        patch = _no_gain_staging_patch()
        results = review_dsp(patch)
        blockers = [r for r in results if r.severity == "blocker" and "gain" in r.finding.lower()]
        assert len(blockers) >= 1, f"Expected blocker for missing gain staging, got: {results}"

    def test_number_to_gain_inlet_blocker(self):
        """number box -> *~ inlet 1 = blocker."""
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
            {"source": ["obj-1", 0], "destination": ["obj-2", 1]},
        ]
        patch = _make_patch(boxes, lines)
        results = review_dsp(patch)
        blockers = [r for r in results if r.severity == "blocker" and "unsafe gain" in r.finding.lower()]
        assert len(blockers) >= 1, f"Expected blocker for number->*~ inlet 1, got: {results}"


    # --- Task 1: expr/vexpr normalizer + MC gain objects ---

    def test_expr_normalizer_with_division(self):
        """expr containing '/ 127.' is a normalizer."""
        box = {"maxclass": "newobj", "text": "expr $f1 / 127."}
        assert _is_normalizer(box) is True

    def test_expr_normalizer_rejected_without_pattern(self):
        """expr with '$i1 + $i2' (no division/scaling) is NOT a normalizer."""
        box = {"maxclass": "newobj", "text": "expr $i1 + $i2"}
        assert _is_normalizer(box) is False

    def test_vexpr_normalizer_with_scale_pattern(self):
        """vexpr with '/ 255.' is a normalizer."""
        box = {"maxclass": "newobj", "text": "vexpr $f1 / 255."}
        assert _is_normalizer(box) is True

    def test_vexpr_not_normalizer_generic_multiply(self):
        """vexpr with '$f1 * $f2' (variable multiply) is NOT a normalizer."""
        box = {"maxclass": "newobj", "text": "vexpr $f1 * $f2"}
        assert _is_normalizer(box) is False

    def test_mc_multiply_in_gain_names(self):
        """mc.*~ is in _GAIN_NAMES."""
        assert "mc.*~" in _GAIN_NAMES

    def test_mc_gain_in_gain_names(self):
        """mc.gain~ is in _GAIN_NAMES."""
        assert "mc.gain~" in _GAIN_NAMES

    def test_mc_multiply_unsafe_source(self):
        """ctlin -> mc.*~ inlet 1 without normalizer = blocker."""
        boxes = [
            {
                "id": "obj-1",
                "maxclass": "newobj",
                "text": "ctlin",
                "numinlets": 1,
                "numoutlets": 3,
                "outlettype": ["", "", ""],
            },
            {
                "id": "obj-2",
                "maxclass": "newobj",
                "text": "mc.*~ 1.",
                "numinlets": 2,
                "numoutlets": 1,
                "outlettype": ["multichannelsignal"],
            },
        ]
        lines = [
            {"source": ["obj-1", 0], "destination": ["obj-2", 1]},
        ]
        patch = _make_patch(boxes, lines)
        results = review_dsp(patch)
        blockers = [r for r in results if r.severity == "blocker" and "unsafe gain" in r.finding.lower()]
        assert len(blockers) >= 1, f"Expected blocker for ctlin->mc.*~ inlet 1, got: {results}"

    # --- Task 2: line~ backward tracing ---

    def test_line_tilde_safe_message_to_gain(self):
        """message '0.5 500' -> line~ -> *~ inlet 1 = no blocker (safe value)."""
        boxes = [
            {
                "id": "obj-1",
                "maxclass": "message",
                "text": "0.5 500",
                "numinlets": 2,
                "numoutlets": 1,
                "outlettype": [""],
            },
            {
                "id": "obj-2",
                "maxclass": "newobj",
                "text": "line~",
                "numinlets": 2,
                "numoutlets": 2,
                "outlettype": ["signal", "bang"],
            },
            {
                "id": "obj-3",
                "maxclass": "newobj",
                "text": "*~ 1.",
                "numinlets": 2,
                "numoutlets": 1,
                "outlettype": ["signal"],
            },
        ]
        lines = [
            {"source": ["obj-1", 0], "destination": ["obj-2", 0]},
            {"source": ["obj-2", 0], "destination": ["obj-3", 1]},
        ]
        patch = _make_patch(boxes, lines)
        results = review_dsp(patch)
        blockers = [r for r in results if r.severity == "blocker" and "unsafe gain" in r.finding.lower()]
        assert len(blockers) == 0, f"Expected no blocker for safe line~ message, got: {results}"

    def test_line_tilde_unsafe_message_to_gain(self):
        """message '100 500' -> line~ -> *~ inlet 1 = blocker (>1.0)."""
        boxes = [
            {
                "id": "obj-1",
                "maxclass": "message",
                "text": "100 500",
                "numinlets": 2,
                "numoutlets": 1,
                "outlettype": [""],
            },
            {
                "id": "obj-2",
                "maxclass": "newobj",
                "text": "line~",
                "numinlets": 2,
                "numoutlets": 2,
                "outlettype": ["signal", "bang"],
            },
            {
                "id": "obj-3",
                "maxclass": "newobj",
                "text": "*~ 1.",
                "numinlets": 2,
                "numoutlets": 1,
                "outlettype": ["signal"],
            },
        ]
        lines = [
            {"source": ["obj-1", 0], "destination": ["obj-2", 0]},
            {"source": ["obj-2", 0], "destination": ["obj-3", 1]},
        ]
        patch = _make_patch(boxes, lines)
        results = review_dsp(patch)
        blockers = [r for r in results if r.severity == "blocker" and "unsafe gain" in r.finding.lower()]
        assert len(blockers) >= 1, f"Expected blocker for unsafe line~ message, got: {results}"

    def test_line_tilde_midi_source_to_gain(self):
        """ctlin -> line~ -> *~ inlet 1 = blocker (MIDI source through line~)."""
        boxes = [
            {
                "id": "obj-1",
                "maxclass": "newobj",
                "text": "ctlin",
                "numinlets": 1,
                "numoutlets": 3,
                "outlettype": ["", "", ""],
            },
            {
                "id": "obj-2",
                "maxclass": "newobj",
                "text": "line~",
                "numinlets": 2,
                "numoutlets": 2,
                "outlettype": ["signal", "bang"],
            },
            {
                "id": "obj-3",
                "maxclass": "newobj",
                "text": "*~ 1.",
                "numinlets": 2,
                "numoutlets": 1,
                "outlettype": ["signal"],
            },
        ]
        lines = [
            {"source": ["obj-1", 0], "destination": ["obj-2", 0]},
            {"source": ["obj-2", 0], "destination": ["obj-3", 1]},
        ]
        patch = _make_patch(boxes, lines)
        results = review_dsp(patch)
        blockers = [r for r in results if r.severity == "blocker" and "unsafe gain" in r.finding.lower()]
        assert len(blockers) >= 1, f"Expected blocker for ctlin->line~->*~ inlet 1, got: {results}"

    def test_line_tilde_normalized_midi_to_gain(self):
        """ctlin -> scale 0 127 0. 1. -> line~ -> *~ inlet 1 = no blocker."""
        boxes = [
            {
                "id": "obj-1",
                "maxclass": "newobj",
                "text": "ctlin",
                "numinlets": 1,
                "numoutlets": 3,
                "outlettype": ["", "", ""],
            },
            {
                "id": "obj-2",
                "maxclass": "newobj",
                "text": "scale 0 127 0. 1.",
                "numinlets": 6,
                "numoutlets": 1,
                "outlettype": [""],
            },
            {
                "id": "obj-3",
                "maxclass": "newobj",
                "text": "line~",
                "numinlets": 2,
                "numoutlets": 2,
                "outlettype": ["signal", "bang"],
            },
            {
                "id": "obj-4",
                "maxclass": "newobj",
                "text": "*~ 1.",
                "numinlets": 2,
                "numoutlets": 1,
                "outlettype": ["signal"],
            },
        ]
        lines = [
            {"source": ["obj-1", 0], "destination": ["obj-2", 0]},
            {"source": ["obj-2", 0], "destination": ["obj-3", 0]},
            {"source": ["obj-3", 0], "destination": ["obj-4", 1]},
        ]
        patch = _make_patch(boxes, lines)
        results = review_dsp(patch)
        blockers = [r for r in results if r.severity == "blocker" and "unsafe gain" in r.finding.lower()]
        assert len(blockers) == 0, f"Expected no blocker for normalized MIDI through line~, got: {results}"

    def test_line_tilde_to_signal_inlet_no_flag(self):
        """message '100 500' -> line~ -> *~ inlet 0 = no unsafe gain blocker."""
        boxes = [
            {
                "id": "obj-1",
                "maxclass": "message",
                "text": "100 500",
                "numinlets": 2,
                "numoutlets": 1,
                "outlettype": [""],
            },
            {
                "id": "obj-2",
                "maxclass": "newobj",
                "text": "line~",
                "numinlets": 2,
                "numoutlets": 2,
                "outlettype": ["signal", "bang"],
            },
            {
                "id": "obj-3",
                "maxclass": "newobj",
                "text": "*~ 1.",
                "numinlets": 2,
                "numoutlets": 1,
                "outlettype": ["signal"],
            },
        ]
        lines = [
            {"source": ["obj-1", 0], "destination": ["obj-2", 0]},
            {"source": ["obj-2", 0], "destination": ["obj-3", 0]},  # inlet 0 = audio, not gain
        ]
        patch = _make_patch(boxes, lines)
        results = review_dsp(patch)
        blockers = [r for r in results if r.severity == "blocker" and "unsafe gain" in r.finding.lower()]
        assert len(blockers) == 0, f"Expected no unsafe gain blocker for line~ to inlet 0, got: {results}"

    def test_comment_and_panel_excluded_from_overlap(self):
        """Comment and panel boxes are excluded from overlap checks."""
        boxes = [
            {
                "id": "obj-1",
                "maxclass": "comment",
                "text": "Section header",
                "patching_rect": [30.0, 100.0, 200.0, 22.0],
                "numinlets": 1,
                "numoutlets": 0,
            },
            {
                "id": "obj-2",
                "maxclass": "newobj",
                "text": "metro 500",
                "patching_rect": [50.0, 105.0, 80.0, 22.0],
                "numinlets": 2,
                "numoutlets": 1,
            },
            {
                "id": "obj-3",
                "maxclass": "panel",
                "text": "",
                "patching_rect": [20.0, 90.0, 300.0, 100.0],
                "numinlets": 1,
                "numoutlets": 0,
            },
        ]
        patch = _make_patch(boxes, [])
        results = review_layout(patch)
        overlap_warnings = [r for r in results if "overlap" in r.finding.lower()]
        assert len(overlap_warnings) == 0, f"Expected no overlap warnings with comment/panel, got: {results}"


# ===========================================================================
# Package critic tests
# ===========================================================================


from src.maxpat.critics.package_critic import review_packages


class TestPackageCritic:
    """Tests for BEAP, Bach, and community package critic checks."""

    # --- BEAP convention tests ---

    def test_beap_missing_vca(self):
        """BEAP patch with bp.Oscillator -> bp.Stereo (no VCA) produces warning."""
        boxes = [
            {
                "id": "obj-1",
                "maxclass": "bpatcher",
                "name": "bp.Oscillator",
                "numinlets": 1,
                "numoutlets": 1,
                "outlettype": ["signal"],
            },
            {
                "id": "obj-2",
                "maxclass": "bpatcher",
                "name": "bp.Stereo",
                "numinlets": 2,
                "numoutlets": 0,
                "outlettype": [],
            },
        ]
        lines = [
            {"source": ["obj-1", 0], "destination": ["obj-2", 0]},
        ]
        patch = _make_patch(boxes, lines)
        results = review_packages(patch)
        vca_warnings = [r for r in results if r.severity == "warning" and "vca" in r.finding.lower()]
        assert len(vca_warnings) >= 1, f"Expected VCA warning, got: {results}"

    def test_beap_clean_chain(self):
        """BEAP patch with bp.Oscillator -> bp.VCA -> bp.Stereo produces no BEAP findings."""
        boxes = [
            {
                "id": "obj-1",
                "maxclass": "bpatcher",
                "name": "bp.Oscillator",
                "numinlets": 1,
                "numoutlets": 1,
                "outlettype": ["signal"],
            },
            {
                "id": "obj-2",
                "maxclass": "bpatcher",
                "name": "bp.VCA",
                "numinlets": 2,
                "numoutlets": 1,
                "outlettype": ["signal"],
            },
            {
                "id": "obj-3",
                "maxclass": "bpatcher",
                "name": "bp.Stereo",
                "numinlets": 2,
                "numoutlets": 0,
                "outlettype": [],
            },
        ]
        lines = [
            {"source": ["obj-1", 0], "destination": ["obj-2", 0]},
            {"source": ["obj-2", 0], "destination": ["obj-3", 0]},
        ]
        patch = _make_patch(boxes, lines)
        results = review_packages(patch)
        beap_findings = [r for r in results if "beap" in r.finding.lower() or "vca" in r.finding.lower() or "output" in r.finding.lower()]
        assert len(beap_findings) == 0, f"Expected no BEAP findings, got: {beap_findings}"

    def test_beap_missing_output(self):
        """BEAP patch with bp.Oscillator -> bp.VCA but no output produces warning."""
        boxes = [
            {
                "id": "obj-1",
                "maxclass": "bpatcher",
                "name": "bp.Oscillator",
                "numinlets": 1,
                "numoutlets": 1,
                "outlettype": ["signal"],
            },
            {
                "id": "obj-2",
                "maxclass": "bpatcher",
                "name": "bp.VCA",
                "numinlets": 2,
                "numoutlets": 1,
                "outlettype": ["signal"],
            },
        ]
        lines = [
            {"source": ["obj-1", 0], "destination": ["obj-2", 0]},
        ]
        patch = _make_patch(boxes, lines)
        results = review_packages(patch)
        output_warnings = [r for r in results if r.severity == "warning" and "output" in r.finding.lower()]
        assert len(output_warnings) >= 1, f"Expected output termination warning, got: {results}"

    def test_no_beap_no_findings(self):
        """Non-BEAP patch returns empty list from review_packages."""
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
        patch = _make_patch(boxes, lines)
        results = review_packages(patch)
        assert results == [], f"Expected no findings for non-package patch, got: {results}"

    def test_beap_mixed_patch(self):
        """Mixed patch with BEAP + standard MSP only checks BEAP conventions for BEAP chains."""
        boxes = [
            # BEAP chain: bp.Oscillator -> bp.Stereo (missing VCA)
            {
                "id": "obj-1",
                "maxclass": "bpatcher",
                "name": "bp.Oscillator",
                "numinlets": 1,
                "numoutlets": 1,
                "outlettype": ["signal"],
            },
            {
                "id": "obj-2",
                "maxclass": "bpatcher",
                "name": "bp.Stereo",
                "numinlets": 2,
                "numoutlets": 0,
                "outlettype": [],
            },
            # Standard MSP chain: cycle~ -> dac~ (should not trigger BEAP warnings)
            {
                "id": "obj-3",
                "maxclass": "newobj",
                "text": "cycle~ 440",
                "numinlets": 2,
                "numoutlets": 1,
                "outlettype": ["signal"],
            },
            {
                "id": "obj-4",
                "maxclass": "newobj",
                "text": "dac~",
                "numinlets": 2,
                "numoutlets": 0,
                "outlettype": [],
            },
        ]
        lines = [
            {"source": ["obj-1", 0], "destination": ["obj-2", 0]},
            {"source": ["obj-3", 0], "destination": ["obj-4", 0]},
        ]
        patch = _make_patch(boxes, lines)
        results = review_packages(patch)
        # Should have BEAP VCA warning but no warning about dac~ chain
        beap_warnings = [r for r in results if "vca" in r.finding.lower()]
        assert len(beap_warnings) >= 1, f"Expected BEAP VCA warning, got: {results}"
        # No findings should mention cycle~ or dac~
        msp_findings = [r for r in results if "cycle~" in r.finding or "dac~" in r.finding]
        assert len(msp_findings) == 0, f"Expected no MSP findings, got: {msp_findings}"

    # --- Bach llll type tests ---

    def test_bach_llll_mismatch(self):
        """Non-bach object (pack) connected to bach.score llll inlet produces blocker."""
        boxes = [
            {
                "id": "obj-1",
                "maxclass": "newobj",
                "text": "pack 0 0",
                "numinlets": 2,
                "numoutlets": 1,
                "outlettype": [""],
            },
            {
                "id": "obj-2",
                "maxclass": "newobj",
                "text": "bach.score",
                "numinlets": 1,
                "numoutlets": 1,
                "outlettype": [""],
            },
        ]
        lines = [
            {"source": ["obj-1", 0], "destination": ["obj-2", 0]},
        ]
        patch = _make_patch(boxes, lines)
        results = review_packages(patch)
        blockers = [r for r in results if r.severity == "blocker" and "llll" in r.finding.lower()]
        assert len(blockers) >= 1, f"Expected llll mismatch blocker, got: {results}"

    def test_bach_to_bach_clean(self):
        """bach.rev -> bach.score produces no Bach findings."""
        boxes = [
            {
                "id": "obj-1",
                "maxclass": "newobj",
                "text": "bach.rev",
                "numinlets": 1,
                "numoutlets": 1,
                "outlettype": [""],
            },
            {
                "id": "obj-2",
                "maxclass": "newobj",
                "text": "bach.score",
                "numinlets": 1,
                "numoutlets": 1,
                "outlettype": [""],
            },
        ]
        lines = [
            {"source": ["obj-1", 0], "destination": ["obj-2", 0]},
        ]
        patch = _make_patch(boxes, lines)
        results = review_packages(patch)
        bach_findings = [r for r in results if "llll" in r.finding.lower()]
        assert len(bach_findings) == 0, f"Expected no Bach findings, got: {bach_findings}"

    def test_bach_list2llll_allowed(self):
        """unpack -> bach.list2llll produces no findings (list2llll accepts lists)."""
        boxes = [
            {
                "id": "obj-1",
                "maxclass": "newobj",
                "text": "unpack 0 0",
                "numinlets": 1,
                "numoutlets": 2,
                "outlettype": ["", ""],
            },
            {
                "id": "obj-2",
                "maxclass": "newobj",
                "text": "bach.list2llll",
                "numinlets": 1,
                "numoutlets": 1,
                "outlettype": [""],
            },
        ]
        lines = [
            {"source": ["obj-1", 0], "destination": ["obj-2", 0]},
        ]
        patch = _make_patch(boxes, lines)
        results = review_packages(patch)
        bach_findings = [r for r in results if "llll" in r.finding.lower()]
        assert len(bach_findings) == 0, f"Expected no findings for list2llll, got: {bach_findings}"

    def test_bach_non_llll_inlet(self):
        """Non-bach to bach.write (no llll digest on inlets) produces no findings."""
        boxes = [
            {
                "id": "obj-1",
                "maxclass": "newobj",
                "text": "pack 0 0",
                "numinlets": 2,
                "numoutlets": 1,
                "outlettype": [""],
            },
            {
                "id": "obj-2",
                "maxclass": "newobj",
                "text": "bach.write",
                "numinlets": 1,
                "numoutlets": 1,
                "outlettype": [""],
            },
        ]
        lines = [
            {"source": ["obj-1", 0], "destination": ["obj-2", 0]},
        ]
        patch = _make_patch(boxes, lines)
        results = review_packages(patch)
        bach_findings = [r for r in results if "llll" in r.finding.lower()]
        assert len(bach_findings) == 0, f"Expected no findings for non-llll inlet, got: {bach_findings}"

    # --- Community extraction tests ---

    def test_community_unextracted_warning(self):
        """Patch with FluCoMa object (community, extracted=false) produces warning."""
        boxes = [
            {
                "id": "obj-1",
                "maxclass": "newobj",
                "text": "fluid.mfcc~ 13",
                "numinlets": 1,
                "numoutlets": 1,
                "outlettype": [""],
            },
        ]
        patch = _make_patch(boxes, [])
        results = review_packages(patch)
        community_warnings = [r for r in results if r.severity == "warning" and "unextracted" in r.finding.lower()]
        assert len(community_warnings) >= 1, f"Expected community extraction warning, got: {results}"

    def test_community_extracted_clean(self):
        """Patch with BEAP objects (bundled, extracted=true) produces no community findings."""
        boxes = [
            {
                "id": "obj-1",
                "maxclass": "bpatcher",
                "name": "bp.Oscillator",
                "numinlets": 1,
                "numoutlets": 1,
                "outlettype": ["signal"],
            },
            {
                "id": "obj-2",
                "maxclass": "bpatcher",
                "name": "bp.VCA",
                "numinlets": 2,
                "numoutlets": 1,
                "outlettype": ["signal"],
            },
            {
                "id": "obj-3",
                "maxclass": "bpatcher",
                "name": "bp.Stereo",
                "numinlets": 2,
                "numoutlets": 0,
                "outlettype": [],
            },
        ]
        lines = [
            {"source": ["obj-1", 0], "destination": ["obj-2", 0]},
            {"source": ["obj-2", 0], "destination": ["obj-3", 0]},
        ]
        patch = _make_patch(boxes, lines)
        results = review_packages(patch)
        community_findings = [r for r in results if "unextracted" in r.finding.lower()]
        assert len(community_findings) == 0, f"Expected no community findings for BEAP, got: {community_findings}"
