"""Bassoon v0.4.1 regression test: simulator must catch the in-loop
high-Q failure-mode family before it ships.

Per CONTEXT.md D-06: this test asserts verdict in {'mode_competition',
'phase_drift'} on the canonical bell_bright sweep. v0.4.1's D4
phase-delay compensation was correct, but the bell biquad at Q~2.5
inside the loop still destabilises the loop math -- the simulator must
catch this.
"""

from __future__ import annotations

from src.maxpat.dsp_sim import run_simulation

from tests.dsp_sim.fixtures.bassoon_v041_mirror import build_v041_mirror


def test_v041_high_q_in_loop_is_caught():
    """v0.4.1 (correct phase-delay compensation, bell-in-loop, Q=2.5) must trip the in-loop high-Q family."""
    r = run_simulation(
        patch_path="<v041-mirror>",
        mirror=build_v041_mirror,
        params={
            "freq": 220.0,
            "breath": 0.6,
            "bore_damp": 0.3,
            "bell_bright": 0.5,
            "reed_stiff": 0.5,
            "reed_aper": 0.0,
            "cone_loss": 0.85,
            "bell_q": 2.5,
        },
        sweep_param="bell_bright",
        sweep=(0.0, 1.0, 32),
    )
    assert r.verdict in ("mode_competition", "phase_drift"), r.reason
    assert "post-loop" in (r.suggested_fix or "").lower() or "Q" in (r.suggested_fix or "")
    assert r.worst_step is not None
