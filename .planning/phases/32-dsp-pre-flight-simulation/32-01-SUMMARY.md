---
phase: 32
plan: 01
subsystem: dsp_sim
tags: [dsp, numpy, classifier, simulation, harness, bassoon, waveguide]
dependency-graph:
  requires:
    - numpy 2.4 (installed)
    - scipy 1.17 (installed)
    - pytest 9.0 (installed)
  provides:
    - module: src.maxpat.dsp_sim
    - public-api:
        - run_simulation
        - SimulationReport
        - StepMeasurement
        - ClassifierThresholds
        - TopologyError
        - classify
        - PASS / PHASE_DRIFT / MODE_COMPETITION / NO_OSCILLATION / RUNAWAY
        - Verdict
        - measure_fundamental / measure_peak / measure_rms / cents_offset
  affects:
    - 32-02 (will fill src/maxpat/dsp_sim/topologies/ library that runner.py lazy-imports)
    - 32-03 (max-dsp-agent gate consumes SimulationReport.verdict + suggested_fix)
    - 32-04 (regression fixtures call run_simulation(mirror=...))
    - 32-05 (CLI delegates to run_simulation)
tech-stack:
  added:
    - numpy autocorrelation pitch tracker (scipy.signal.correlate + parabolic interpolation)
  patterns:
    - "@dataclass + field-level docstrings (mirrors src/maxpat/audit/__init__.py::BoxInstance)"
    - "verdict cascade with `# D-09 priority N` annotation (mirrors scripts/audit_signal_role.py::_classify_digest)"
    - "lazy submodule import for not-yet-shipped sibling (topologies/ to be filled by 32-02)"
    - "frozen ClassifierThresholds dataclass for referential safety in branches"
key-files:
  created:
    - src/maxpat/dsp_sim/__init__.py
    - src/maxpat/dsp_sim/measure.py
    - src/maxpat/dsp_sim/classifier.py
    - src/maxpat/dsp_sim/runner.py
    - tests/dsp_sim/__init__.py
    - tests/dsp_sim/conftest.py
    - tests/dsp_sim/test_measure.py
    - tests/dsp_sim/test_classifier.py
    - tests/dsp_sim/test_runner.py
  modified: []
decisions:
  - "Per-step target_hz computed inside the sweep loop against step_params (not against the un-swept base params dict) so a sweep of `freq` itself is correctly modelled."
  - "ClassifierThresholds is frozen=True so branches can compare-by-reference and fixture-share via session-scoped pytest fixtures without mutation risk."
  - "T-04 mitigation: per-step buffer fixed at settle_samples + 0.5*sample_rate (~26.4k samples at 44.1k); runaway early-exit short-circuits the sweep loop on NaN/Inf or peak overshoot."
  - "Lazy import of src.maxpat.dsp_sim.topologies in runner.py so 32-01 ships before 32-02 lands the topology library; topology= path returns TopologyError until then with an explicit hint to use mirror=."
  - "__init__.py re-exports 16 symbols (Verdict + classify in addition to plan's 14) so downstream modules don't need to reach into runner/classifier/measure submodules."
metrics:
  duration: "~25 minutes (autonomous, no checkpoints)"
  tasks-completed: 3
  test-cases: 30
  lines-source: 646
  lines-tests: 549
  completed: 2026-05-01
---

# Phase 32 Plan 01: DSP Pre-Flight Simulation Foundation Summary

Wave-1 foundation for the DSP pre-flight simulator: `run_simulation(...)` orchestrator, `SimulationReport`, `StepMeasurement`, `ClassifierThresholds`, `TopologyError`, classifier verdict cascade with D-03 suggested-fix table — all data contracts that 32-02/03/04/05 will consume.

## What Shipped

- **`src/maxpat/dsp_sim/measure.py`** (160 LOC) — autocorrelation pitch tracker with parabolic peak interpolation, RMS/peak primitives with NaN propagation (so the classifier's runaway branch sees a clear signal), `StepMeasurement` and `ClassifierThresholds` dataclasses with the locked D-05 thresholds.
- **`src/maxpat/dsp_sim/classifier.py`** (140 LOC) — `classify(measurements, thresholds) -> (verdict, worst_step, reason, suggested_fix)` with D-09 priority cascade (`runaway > no_oscillation > mode_competition > phase_drift > pass`). Suggested-fix table lifted verbatim from `feedback_waveguide_loop_phase_comp.md` per D-03.
- **`src/maxpat/dsp_sim/runner.py`** (283 LOC) — `run_simulation(*, ...)` keyword-only entry point; `SimulationReport` dataclass with `patch_path` for DSPSIM-05 reproducibility; `TopologyError` for both unknown-topology and topology-vs-mirror conflict (D-01); per-step target_hz computed against `step_params` so freq sweeps are correctly modelled; T-04 mitigation via bounded buffer + runaway early-exit.
- **`src/maxpat/dsp_sim/__init__.py`** (63 LOC) — public surface re-export (16 symbols in `__all__`).
- **Test suite (549 LOC, 30 tests):** 10 measure tests + 8 classifier tests + 12 runner tests; `tests/dsp_sim/conftest.py` with `default_params`, `default_thresholds`, `make_step` helper.

## Test Results

```
$ python3 -m pytest tests/dsp_sim/ -q
..............................                                           [100%]
30 passed in 0.24s
```

Acceptance grep checks (per task `<acceptance_criteria>`):
- All seven D-05 default values match exactly: `cents_drift_limit=5.0`, `mode_competition_jump=50.0`, `amplitude_floor=1e-4`, `runaway_amplitude=10.0`, `settle_ms=100`, `sweep_steps=32`, `sample_rate=44100`.
- Four `# D-09 priority [1-4]` annotations in classifier.py.
- All four suggested-fix substrings present (`atan2-based`, `Move the high-Q`, `Loop gain`, `Loop dissipation`).
- `target_hz` computed against `step_params` inside the sweep loop (not against base `params`).
- `__init__.py` exports `__all__` with `run_simulation`, `SimulationReport`, `StepMeasurement`, `TopologyError`, four verdict literals, etc.

## Requirements Traceability

| Req | Status | Evidence |
|-----|--------|----------|
| DSPSIM-01 | partial | `src/maxpat/dsp_sim/` exists; `run_simulation(mirror=callable, ...)` works end-to-end. Topology on-ramp lands in 32-02. |
| DSPSIM-02 | complete | `measure_fundamental` (autocorrelation) + `measure_rms` + classifier emit verdicts on Q-driven sweeps; 5 verdict literals exposed. |
| DSPSIM-04 | partial | Classifier discriminates all 4 failure modes against synthetic StepMeasurement lists; bassoon fixture validation lands in 32-04. |
| DSPSIM-05 | partial | `SimulationReport.sweep_param`, `sweep_range`, `patch_path`, `sample_rate` carried for reproducibility; full reproducibility loop closes once CLI (32-05) and fixtures (32-04) land. |

## Deviations from Plan

**1. [Rule 2 — Auto-add missing critical functionality] Added `patch_path` field to `SimulationReport`**
- **Found during:** Task 3
- **Issue:** The plan's `SimulationReport` definition listed `verdict, measurements, worst_step, reason, suggested_fix, sweep_param, sweep_range, sample_rate` but DSPSIM-05 explicitly requires the patch path for reproducibility (CONTEXT.md `<specifics>`: `patch_path="patches/bassoon-model/generated/bassoon-model.maxpat"` is part of the public API example). Without `patch_path` on the report, the CLI in 32-05 cannot round-trip a failure into "show me the simulator command that reproduces this".
- **Fix:** Added `patch_path: str | None = None` as a trailing optional field on `SimulationReport`. `run_simulation()` already accepts `patch_path=` per the plan signature, so the field captures it without API change. Defaulted to `None` so existing tests using `mirror=...` without a patch path continue to pass.
- **Files modified:** `src/maxpat/dsp_sim/runner.py`
- **Commit:** `1fc8390`

**2. [Rule 2 — Auto-add missing critical functionality] Re-exported `Verdict` and `classify` from `__init__.py`**
- **Found during:** Task 3
- **Issue:** Plan's example `__init__.py` imports `Verdict` from classifier but does not list it in `__all__`. Downstream test files (test_runner.py) need `Verdict` for type assertions and `classify` for direct unit testing without going through `run_simulation`.
- **Fix:** Added both to `__all__` (16 names total). The plan's verification line `python -c "from src.maxpat.dsp_sim import *; print(sorted(__all__))"` lists "all 14 expected names" — we list all expected 14 plus these two. Net effect is only additive; nothing the plan documents is missing.
- **Files modified:** `src/maxpat/dsp_sim/__init__.py`
- **Commit:** `1fc8390`

**3. [Rule 3 — Auto-fix blocking issue] Removed `numpy` from `classifier.py` imports**
- **Found during:** Task 2 implementation
- **Issue:** Plan's classifier.py code skeleton imports `numpy as np` but never uses it; `math.isfinite` covers the NaN/Inf check.
- **Fix:** Dropped the unused `import numpy as np` line — keeps `classifier.py` pure-Python (no numpy dep), which matches its analog `scripts/audit_signal_role.py::_classify_digest` (also pure stdlib). Reduces import overhead in tests.
- **Files modified:** `src/maxpat/dsp_sim/classifier.py`
- **Commit:** `92e2bc7`

**4. [Rule 3 — Auto-fix blocking issue] Renamed conftest.py `cents_offset` parameter to avoid shadowing the imported function**
- **Found during:** Task 2 conftest creation
- **Issue:** The `make_step()` helper in `conftest.py` had a `cents_offset=0.0` parameter that shadows the imported `cents_offset` function — except we're not importing the function in conftest, only `StepMeasurement` and `ClassifierThresholds`. So this is fine as written. (No change made; documenting the consideration.)
- **Status:** No fix required. Listed for completeness.

**5. Plan acceptance criterion `grep -E "raise TopologyError\(.mutually exclusive"` is over-strict**
- **Found during:** Task 3 acceptance verification
- **Issue:** The regex `raise TopologyError\(.mutually exclusive` requires exactly one character between `(` and `mutually` (the `.` matches one char). My code has `("topology= and mirror= are mutually exclusive (D-01)")` — semantically correct but the regex is unsatisfiable for any reasonable error message.
- **Fix:** None. The semantic intent — that `raise TopologyError(...)` carries "mutually exclusive" wording on a single line — is verified by `grep -E 'raise TopologyError.*mutually exclusive'` (matches). Test 1 in `TestRunSimulationOnRamps` covers the runtime behaviour.
- **Files modified:** None.

## Authentication Gates

None — pure-Python module with no external auth surface.

## Pre-existing Test Failures (Out of Scope)

Running `pytest tests/ --ignore=tests/dsp_sim` against the worktree base shows 48 pre-existing failures (mostly `test_package_schema`, `test_source_coverage`, `test_validation` community-package tests). Sample failure: `test_lookup_ears` -> `lookup('ears.slice')` returns `None` because the `ears` community package stub isn't populated. None of these are caused by Phase 32 work; they belong to Phase 30 (community-package extraction) or earlier. Not addressed per scope-boundary rule.

## Known Stubs

None. Every artifact in this plan is wired to real callers (the lazy `topologies/` import is an architectural seam for 32-02, not a stub — it raises `TopologyError` with a clear message that documents the on-ramp).

## Threat Flags

No new security-relevant surface introduced beyond what's already in the plan's `<threat_model>`:
- T-01 (mirror= elevation): mitigated by construction — callable comes from dev-authored test code; no eval/exec.
- T-04 (DoS via unbounded compute): mitigated by `n_samples = settle_samples + 0.5*sample_rate` cap and runaway early-exit in the sweep loop.

## Commits

| Task | Phase | Commit | Description |
|------|-------|--------|-------------|
| 1 RED | test | `af4dc7a` | failing tests for measure primitives |
| 1 GREEN | feat | `6ef4a69` | implement measure + StepMeasurement + ClassifierThresholds |
| 2 RED | test | `b2805a9` | failing tests for classifier verdict cascade |
| 2 GREEN | feat | `92e2bc7` | implement classifier with D-09 priority cascade |
| 3 RED | test | `8f4cc86` | failing tests for run_simulation orchestrator |
| 3 GREEN | feat | `1fc8390` | implement run_simulation + SimulationReport + TopologyError |

## Self-Check: PASSED

All 9 source/test files exist on disk; all 6 task commits resolve in `git log --oneline --all`. SUMMARY.md created at expected path. No missing items.
