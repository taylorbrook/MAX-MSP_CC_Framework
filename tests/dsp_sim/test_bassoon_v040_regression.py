"""Bassoon v0.4.0 regression test: simulator must catch the group-delay
compensation drift before it ships.

Per CONTEXT.md D-06: this test asserts verdict == 'phase_drift' on the
canonical bell_bright sweep. If this test fails, either the v0.4.0 mirror
no longer reproduces the original bug OR the classifier no longer flags
phase_drift correctly. Either way, the simulator's discrimination has
regressed.
"""

from __future__ import annotations

from src.maxpat.dsp_sim import run_simulation

from tests.dsp_sim.fixtures.bassoon_v040_mirror import build_v040_mirror


def test_v040_phase_drift_is_caught():
    """v0.4.0 (group-delay compensation, bell-in-loop) must trip phase_drift."""
    r = run_simulation(
        patch_path="<v040-mirror>",
        mirror=build_v040_mirror,
        params={
            "freq": 220.0,
            "breath": 0.6,
            "bore_damp": 0.3,
            "bell_bright": 0.5,
            "reed_stiff": 0.5,
            "reed_aper": 0.0,
            "cone_loss": 0.85,
            "bell_q": 0.7071068,
        },
        sweep_param="bell_bright",
        sweep=(0.0, 1.0, 32),
    )
    assert r.verdict == "phase_drift", (
        f"v0.4.0 mirror should trip phase_drift; got {r.verdict!r}. Reason: {r.reason}"
    )
    assert r.suggested_fix is not None
    # D-03 wording lifted from feedback_waveguide_loop_phase_comp.md
    assert "phase delay" in r.suggested_fix.lower() or "atan" in r.suggested_fix.lower()
    assert r.worst_step is not None
