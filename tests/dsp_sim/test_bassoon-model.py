"""Live-patch gate for patches/bassoon-model/generated/bassoon-model.maxpat.

Per CONTEXT.md D-06: asserts verdict == 'pass' on the bell_bright sweep.
Per D-07: filename matches the patch stem so max-dsp-agent's filename
discovery picks this up automatically when the bassoon patch is saved.

This test proves the simulator AGREES that the v0.4.2+ shipped fix is
stable -- closing the loop with the v0.4.0 (phase_drift) and v0.4.1
(mode_competition) regression tests in the same suite.

This file uses a hyphen in the filename, which is non-standard for
Python modules but VALID for pytest collection (pytest matches file
paths, not module imports). Do not import this file from other modules.
"""

from __future__ import annotations

from src.maxpat.dsp_sim import run_simulation


def test_bassoon_bell_bright_sweep_stable():
    """v0.4.2+ live patch must pass: bell biquad is post-loop, no detuning."""
    r = run_simulation(
        patch_path="patches/bassoon-model/generated/bassoon-model.maxpat",
        topology="reed_bore_post_radiation",
        params={
            "freq": 220.0,
            "breath": 0.6,
            "bore_damp": 0.3,
            "bell_bright": 0.5,
            "reed_stiff": 0.5,
            "reed_aper": 0.0,
            "cone_loss": 0.85,
            "register": 0.0,
            "reed_res_freq": 1500.0,
            "reed_res_q": 0.7071068,
        },
        sweep_param="bell_bright",
        sweep=(0.0, 1.0, 32),
    )
    assert r.verdict == "pass", (
        f"Live bassoon patch (v0.4.2+) should pass; got {r.verdict!r}. Reason: {r.reason}"
    )
    assert r.worst_step is None
    assert r.suggested_fix is None
