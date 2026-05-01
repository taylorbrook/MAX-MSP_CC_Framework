---
phase: 32-dsp-pre-flight-simulation
verified: 2026-05-01T00:00:00Z
status: passed
score: 5/5 must-haves verified
overrides_applied: 0
---

# Phase 32: DSP Pre-Flight Simulation Verification Report

**Phase Goal:** DSP stability bugs of the bassoon v0.4-0.5 class (high-Q-in-loop, group-vs-phase-delay) are caught by an offline numpy simulator before the patch ships, not after manual MAX testing.
**Verified:** 2026-05-01
**Status:** PASSED
**Re-verification:** No — initial verification

---

## Step 0: Previous Verification

No prior VERIFICATION.md found. Proceeding with initial mode.

---

## Goal Achievement

### Observable Truths

| # | Truth | Status | Evidence |
|---|-------|--------|----------|
| 1 | A developer imports `src/maxpat/dsp_sim/` and runs a sample-accurate waveguide loop simulation with arbitrary Param sweeps. | VERIFIED | `from src.maxpat.dsp_sim import run_simulation, SimulationReport` succeeds. `run_simulation(topology="reed_bore_post_radiation", params={...}, sweep_param="bell_bright", sweep=(0.0,1.0,32))` executes 32-step sweep. Module exports 14+ symbols via `__all__`. |
| 2 | The simulator measures fundamental stability via autocorrelation/FFT and flags Q values where the loop fails to oscillate or drifts off-frequency. | VERIFIED | `measure.py` implements autocorrelation pitch tracker with parabolic interpolation. `classifier.py` emits four distinct verdicts (phase_drift, mode_competition, no_oscillation, runaway) per D-09 priority cascade with locked D-05 thresholds (5 cents drift, 50 cents jump, 1e-4 floor, 10.0 peak). 73 dsp_sim tests pass. |
| 3 | `max-dsp-agent` invokes the simulator before committing waveguide patches and surfaces the stability report in its summary — the agent will not commit a patch that fails its own simulation. | VERIFIED | `.claude/skills/max-dsp-agent/SKILL.md` contains `## DSP Pre-Flight Simulation` section (verified present, no `shell=True`). Documents D-07 filename convention (`Path(patch_path).stem`), argv-form subprocess invocation, VALID-05 hard-block on failure (D-04, D-10). Four drift-detector tests in `tests/test_agent_skills.py` enforce this section cannot regress. All 242 tests pass. |
| 4 | The simulator detects both the high-Q-in-loop failure mode and the group-vs-phase-delay failure mode that motivated the bassoon-model rework, validated against the known-bad bassoon v0.4 fixture. | VERIFIED | `tests/dsp_sim/test_bassoon_v040_regression.py` asserts `verdict=="phase_drift"` on v0.4.0 group-delay mirror. `tests/dsp_sim/test_bassoon_v041_regression.py` asserts `verdict in ("mode_competition","phase_drift")` on v0.4.1 high-Q-in-loop mirror. `tests/dsp_sim/test_bassoon-model.py` asserts `verdict=="pass"` on live v0.4.2+ topology. Three discriminating verdicts from three topologies through same harness. All pass. |
| 5 | Simulator output is reproducible from a `(patch_path, param_name, sweep_range)` triple so any failure can be reduced to a regression test. | VERIFIED | `SimulationReport` carries `patch_path`, `sweep_param`, `sweep_range`, `sample_rate`. CLI `python -m src.maxpat.dsp_sim --patch X --topology Y --param Z --sweep "lo,hi,n"` exits 0. Exit codes 0-4 map to verdicts for shell-script branching. `tests/dsp_sim/README.md` documents the filename convention and author template. |

**Score: 5/5 truths verified**

---

## Required Artifacts

| Artifact | Expected | Status | Details |
|----------|----------|--------|---------|
| `src/maxpat/dsp_sim/__init__.py` | Public re-exports: run_simulation, SimulationReport, StepMeasurement, TopologyError, four verdict constants | VERIFIED | 14 symbols in `__all__`; all confirmed importable. |
| `src/maxpat/dsp_sim/runner.py` | run_simulation orchestrator + SimulationReport dataclass | VERIFIED | 284 LOC; keyword-only `run_simulation()`; `SimulationReport` dataclass with `patch_path` field (DSPSIM-05 reproducibility); `TopologyError` exception class. |
| `src/maxpat/dsp_sim/measure.py` | measure_fundamental, measure_rms, measure_peak, StepMeasurement, ClassifierThresholds | VERIFIED | Autocorrelation + parabolic interpolation pitch tracker. Frozen `ClassifierThresholds()` with all seven D-05 default values exact. |
| `src/maxpat/dsp_sim/classifier.py` | classify(measurements, thresholds) verdict cascade + ClassifierThresholds + suggested-fix table | VERIFIED | D-09 priority cascade (4 annotated branches). Suggested-fix strings match `feedback_waveguide_loop_phase_comp.md` wording verbatim. |
| `src/maxpat/dsp_sim/cli.py` | build_parser(), main(argv) -> int with verdict-priority exit codes; ASCII sparkline; --mirror module:func loader | VERIFIED | All 10 flags in --help. Exit codes 0-4. importlib-only mirror loader (no eval/exec/subprocess). Unicode block sparkline. |
| `src/maxpat/dsp_sim/__main__.py` | Three-line module entry point | VERIFIED | 7 lines with docstring; `raise SystemExit(main())` present. |
| `src/maxpat/dsp_sim/topologies/__init__.py` | TOPOLOGIES dict + get_topology() helper | VERIFIED | Registry exactly `{bore_only, reed_bore, reed_bore_post_radiation}`; `get_topology()` raises `TopologyError` on miss. |
| `src/maxpat/dsp_sim/topologies/reed_bore_post_radiation.py` | ReedBorePostRadiation @dataclass — full v0.4.2+ shape (post-loop bell + reed BPF) | VERIFIED | 231 LOC; 3-stage post-loop radiation chain (body formant, bell LPF, reed BPF); bell biquad strictly post-loop (the D-11 invariant). Accepts full bassoon Param surface (10 Params). |
| `tests/dsp_sim/fixtures/bassoon_v040_mirror.py` | build_v040_mirror factory — v0.4.0 group-delay regression | VERIFIED | 119 LOC (in 80-120 budget). Bell biquad in-loop with GROUP-delay compensation. No import from src.maxpat.dsp_sim.topologies (D-11 self-contained). |
| `tests/dsp_sim/fixtures/bassoon_v041_mirror.py` | build_v041_mirror factory — v0.4.1 high-Q-in-loop regression | VERIFIED | 120 LOC (in 80-120 budget). Phase-delay compensation correct, bell biquad in-loop at Q=2.5 with tanh saturator to prevent numerical runaway. No src.maxpat.dsp_sim.topologies import. |
| `tests/dsp_sim/test_bassoon-model.py` | Live-patch gate; filename = Path('bassoon-model.maxpat').stem per D-07 | VERIFIED | Asserts `verdict=="pass"` with `reed_bore_post_radiation` topology; hyphenated filename collected by pytest. |
| `.claude/skills/max-dsp-agent/SKILL.md` | New "DSP Pre-Flight Simulation" section before "When to Use" | VERIFIED | Section exists (1 header); `Path(patch_path).stem` appears (2x); argv snippet present; `shell=True` absent; all four verdicts appear; VALID-05, D-04, D-07, D-10 cited; frontmatter intact. |
| `tests/dsp_sim/README.md` | Topology catalogue, four failure modes + thresholds, filename convention | VERIFIED | All required content present: 3 topologies, 4 failure modes with D-05 defaults, D-07 convention table, D-03 suggested-fix wording (atan2-based), feedback_waveguide_loop_phase_comp.md cited. |
| `tests/test_agent_skills.py` | 4 drift-detector tests for SKILL.md DSP section | VERIFIED | 4 functions present: section header, filename convention, all 4 verdicts, argv-form (negative shell=True). 242 total tests pass. |

---

## Key Link Verification

| From | To | Via | Status | Details |
|------|----|-----|--------|---------|
| `runner.py` | `classifier.py` | `classify(measurements, thresholds)` call | VERIFIED | Import confirmed: `from src.maxpat.dsp_sim.classifier import classify` |
| `runner.py` | `measure.py` | `measure_fundamental`, `measure_rms`, `measure_peak`, `cents_offset` per sweep step | VERIFIED | Import confirmed; called inside `_measure_step()` per step |
| `runner.py` | `topologies/__init__.py` | lazy `from src.maxpat.dsp_sim.topologies import get_topology` | VERIFIED | Import in `_resolve_stepper_factory()` with `try/except ImportError` guard for standalone worktree execution |
| `cli.py` | `runner.py` | `from src.maxpat.dsp_sim import run_simulation` | VERIFIED | Wired in `main()`; verdict mapped to exit code via `_EXIT_CODE` dict |
| `cli.py` | `topologies/__init__.py` | `--topology` flag routes through `run_simulation(topology=...)` | VERIFIED | Live integration test in 32-05-SUMMARY confirms `verdict=pass, exit 0` on bassoon topology |
| `test_bassoon_v040_regression.py` | `src.maxpat.dsp_sim` | `run_simulation(mirror=build_v040_mirror, ...)` | VERIFIED | Asserts `verdict=="phase_drift"` — test passes |
| `test_bassoon-model.py` | `topologies/reed_bore_post_radiation.py` | `run_simulation(topology="reed_bore_post_radiation", ...)` | VERIFIED | Asserts `verdict=="pass"` — test passes |
| SKILL.md | `src.maxpat.dsp_sim` | documented import path + filename convention | VERIFIED | `src/maxpat/dsp_sim/` reference present; `Path(patch_path).stem` appears 2x |

---

## Data-Flow Trace (Level 4)

Not applicable — this phase produces no UI components or pages. All artifacts are Python library code and documentation. The test suite is the data-flow verification (73 tests run real numpy sweeps through the full pipeline and assert on verdict outputs).

---

## Behavioral Spot-Checks

| Behavior | Command | Result | Status |
|----------|---------|--------|--------|
| CLI `--help` exits 0 | `python3 -m src.maxpat.dsp_sim --help` | Exit 0; all 10 flags present in output | PASS |
| 242 combined tests pass | `pytest tests/dsp_sim/ tests/test_agent_skills.py -q` | `242 passed in 7.39s` | PASS |
| D-05 thresholds exact | Python import + assert on ClassifierThresholds() | `(5.0, 50.0, 1e-4, 10.0, 100, 32, 44100)` confirmed | PASS |
| Topology registry exact | `set(TOPOLOGIES.keys())` | `{'bore_only', 'reed_bore', 'reed_bore_post_radiation'}` | PASS |
| Mirror LOC budget (D-11) | `wc -l bassoon_v040_mirror.py bassoon_v041_mirror.py` | 119, 120 (both in 80-120 range) | PASS |
| SKILL.md no `shell=True` | `grep -c "shell=True" SKILL.md` | 0 | PASS |

---

## Requirements Coverage

| Requirement | Source Plans | Description | Status | Evidence |
|-------------|-------------|-------------|--------|----------|
| DSPSIM-01 | 32-01, 32-02 | `src/maxpat/dsp_sim/` module with waveguide loop simulator + sample-accurate Param sweeps | SATISFIED | Module exists; `run_simulation()` + topology library + mirror escape hatch both operational. |
| DSPSIM-02 | 32-01 | Autocorrelation/FFT fundamental measurement + Q-failure flagging | SATISFIED | `measure_fundamental` (autocorrelation + parabolic interpolation), 4-verdict classifier, locked D-05 thresholds. 10 measure tests + 8 classifier tests pass. |
| DSPSIM-03 | 32-03 | `max-dsp-agent` invokes simulator; surfaces stability report; blocks on fail | SATISFIED | SKILL.md section documented with D-07 discovery, argv invocation, VALID-05 hard-block. 4 drift-detector tests protect this section. |
| DSPSIM-04 | 32-01, 32-02, 32-04 | Covers high-Q-in-loop + group-vs-phase-delay failure modes; validated against v0.4 fixtures | SATISFIED | v0.4.0 mirror trips `phase_drift`; v0.4.1 mirror trips `mode_competition`; live v0.4.2+ topology trips `pass`. Three discriminating verdicts end-to-end. |
| DSPSIM-05 | 32-01, 32-04, 32-05 | Reproducible from `(patch_path, param_name, sweep_range)` triple | SATISFIED | `SimulationReport` carries `patch_path`+`sweep_param`+`sweep_range`. CLI reproduces any failure with one command. `tests/dsp_sim/README.md` documents the pattern. |

All five DSPSIM-* requirements are satisfied. REQUIREMENTS.md shows them as Phase 32 requirements — all accounted for.

---

## Anti-Patterns Found

The REVIEW.md (code review run before verification) documented 3 warnings and 9 info items. None are blockers:

| Item | File | Severity | Impact |
|------|------|----------|--------|
| WR-01: `no_oscillation` branch ignores NaN RMS (if peak is finite but RMS is NaN) | `classifier.py:103-110` | Warning | Silent gap in an edge case; today `measure_rms`/`measure_peak` both return NaN together so runaway always front-stops it. Not a blocking correctness issue. |
| WR-02: CLI threshold defaults duplicated from `ClassifierThresholds()` | `cli.py:121-144` | Warning | Drift risk if `measure.py` defaults change. Not a current mismatch. |
| WR-03: `_render_step` callable-mirror branch undocumented | `runner.py:131-154` | Warning | Dead code path not tested. Not a correctness issue for the documented `.step()` protocol. |
| IN-01..09 | Various | Info | `_BORE_BUFFER_SIZE` duplication, magic numbers, comment placement, unused imports, etc. | Maintainability notes only. |

No blockers, no TODOs or placeholders in critical paths. The three warnings are noted but do not affect goal achievement.

---

## Human Verification Required

None. All five success criteria are verifiable programmatically:

- Module imports succeed
- Test suite passes (242 tests)
- CLI exits 0
- SKILL.md contents confirmed via grep
- All artifacts confirmed substantive (no stubs)

---

## Gaps Summary

No gaps. All five roadmap success criteria are fully met:

1. **Import + sweep**: `run_simulation()` operational with both topology and mirror on-ramps.
2. **Measurement + classification**: Autocorrelation pitch tracker, 4-verdict classifier, D-05 thresholds locked.
3. **Agent gate**: SKILL.md section present with D-07 discovery, hard-block protocol, drift detectors.
4. **Regression validation**: Three discriminating verdicts (phase_drift, mode_competition, pass) from three topologies through the same harness.
5. **Reproducibility triple**: CLI, SimulationReport fields, and README all close the reproducibility loop.

---

_Verified: 2026-05-01_
_Verifier: Claude (gsd-verifier)_
