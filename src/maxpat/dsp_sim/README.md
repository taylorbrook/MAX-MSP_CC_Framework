# `dsp_sim` — Bassoon Waveguide Pre-Flight Stability Harness

## Scope

This module is a **bassoon-waveguide-specific pre-flight stability harness**, **not** a
general-purpose DSP simulator. It is the offline numpy simulator for the `bassoon-model`
patch: it renders a topology over a parameter sweep and classifies the output so waveguide
failures — pitch-lock / mode competition / runaway / no-oscillation — are caught **before a
bassoon patch ships**, without needing MAX running.

It exists to serve the CLAUDE.md Gen~ rule:

> **Pre-flight any new in-loop waveguide filter with a numpy simulation before committing** —
> sweep the filter's controlling Param across its full range at several target freqs and measure
> the output fundamental. If pitch moves more than a few cents across the sweep, the architecture
> is wrong.

The three curated topologies encode the canonical bassoon signal path. If you need to broaden
this into a general DSP simulator (arbitrary gain chains, filter cascades, etc.), that is a
deferred v6.0 roadmap item — see [Scope & Future Work](#scope--future-work) below.

## The Three Topologies

All three mirror `patches/bassoon-model/generated/bassoon.gendsp` and are registered in
`topologies/__init__.py` (`TOPOLOGIES`, `get_topology(name)`):

| Name | Class | What it is |
|------|-------|------------|
| `bore_only` | `BoreOnly` | Passive bore + onepole damping. Sanity-check structure — no reed, just the loop + damping so structural regressions surface cleanly. |
| `reed_bore` | `ReedBore` | Bore + McIntyre-Woodhouse reed. The **v0.3.x ancestor** shape. |
| `reed_bore_post_radiation` | `ReedBorePostRadiation` | The **v0.4.2+** shape: post-loop bell biquad + post-loop reed BPF. Encodes the CLAUDE.md "resonant filters go POST-LOOP" invariant — the resonant sections sit in the radiation/output path, never inside the feedback loop. |

## The `mirror=` Escape Hatch

For off-catalogue patches you do not want to add as a permanent topology, pass a callable
instead of a topology name:

```python
run_simulation(mirror=my_stepper_factory, ...)  # mutually exclusive with topology=
```

`mirror` is a callable `(sample_rate, params) -> stepper`, where the stepper either exposes a
`.step(in1, in2) -> float` method or is itself a callable `(n_samples, params) -> ndarray`
(vectorised form). The `mirror=` callable comes from dev-authored test code only — there is no
string `eval`/`exec` and no third-party plugin loading (Phase 32 threat T-01). `topology=` and
`mirror=` are mutually exclusive; supplying both (or neither) raises `TopologyError`.

## When & How to Run

### `run_simulation(...)` API

Single entry point (`src.maxpat.dsp_sim.run_simulation`). Supply **either** `topology=` **or**
`mirror=`, a base `params` dict, the `sweep_param` name, and a `sweep=(lo, hi, n)` triple:

```python
from src.maxpat.dsp_sim import run_simulation, SimulationReport

report = run_simulation(
    patch_path="patches/bassoon-model/generated/bassoon-model.maxpat",
    topology="reed_bore_post_radiation",
    params={"freq": 220.0, "breath": 0.6},
    sweep_param="bell_bright",
    sweep=(0.0, 1.0, 32),
)
assert report.verdict == "pass", report.reason
```

The swept parameter overrides `params[sweep_param]` at each of the `n` linear steps. `freq` is
taken as the target Hz for pitch measurement. The report carries `verdict`, per-step
`measurements`, `worst_step`, a human-readable `reason`, and (on failure) a `suggested_fix`
lifted from the waveguide loop phase-comp notes.

**Verdict priority cascade** (D-09) — the report reports the highest-priority failure present:

```
runaway  >  no_oscillation  >  mode_competition  >  phase_drift  >  pass
```

Runaway short-circuits the sweep (early-exit on NaN/Inf or peak above `runaway_amplitude`) so
divergent topologies never run unbounded.

### `python -m src.maxpat.dsp_sim` CLI

The CLI wraps `run_simulation` and prints the verdict, a per-step table, and a sparkline (plus
the suggested fix on failure). Its exit code mirrors the verdict priority, so it drops into a
shell gate directly:

| Verdict | Exit code |
|---------|-----------|
| `pass` | 0 |
| `phase_drift` | 1 |
| `mode_competition` | 2 |
| `no_oscillation` | 3 |
| `runaway` | 4 |

### Live-patch gate: `tests/dsp_sim/test_<stem>.py`

The pre-flight gate convention is a pytest file named for the patch stem — a live bassoon patch
`bassoon-model.maxpat` gets `tests/dsp_sim/test_bassoon_model.py`, which runs the appropriate
topology sweep and asserts `report.verdict == "pass"`. This is the harness referenced by the
`max-dsp-agent` SKILL.md pre-flight gate (DSPSIM-01..05): a new or modified in-loop waveguide
filter must pass its `tests/dsp_sim/` sweep before the patch is committed.

## Scope & Future Work

This module is **intentionally scoped to the bassoon waveguide today**. Broadening it with
general topologies — a simple gain chain, a feedback delay, a filter cascade — is a deferred
**v6.0 roadmap item** tracked in `.planning/PROJECT.md` (`### Future`). Until then, use the
`mirror=` escape hatch for one-off, off-catalogue patches rather than adding non-bassoon
topologies to the curated library.
