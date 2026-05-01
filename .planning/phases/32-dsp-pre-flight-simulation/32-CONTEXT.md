# Phase 32: DSP Pre-Flight Simulation - Context

**Gathered:** 2026-05-01
**Status:** Ready for planning

<domain>
## Phase Boundary

Land an offline numpy waveguide-stability harness — `src/maxpat/dsp_sim/` — that reproduces and flags the bassoon v0.4–0.5 class of regressions (high-Q-in-loop mode competition; group-vs-phase-delay drift) before a patch is committed. `max-dsp-agent` invokes the harness on opt-in waveguide patches and hard-blocks commits when the simulator detects instability.

**In scope:**
- New module `src/maxpat/dsp_sim/` containing:
  - `runner.py` — `run_simulation(patch_path, *, topology|mirror, params, sweep, sample_rate=44100, settle_ms=100, sweep_steps=32, ...)` orchestrator that returns a structured `SimulationReport`.
  - `topologies/` — curated waveguide topology library: `bore_only`, `reed_bore`, `reed_bore_post_radiation` (covers the bassoon model). Each topology is a numpy class/function that ingests a parameter dict and produces sample-by-sample output.
  - `classifier.py` — distinct failure-mode diagnostics (`mode_competition`, `phase_drift`, `no_oscillation`, `runaway`) with the locked tight defaults (D-05).
  - `measure.py` — autocorrelation- and FFT-based fundamental tracker plus amplitude/RMS extractor used by `classifier.py`.
  - `cli.py` — `python -m src.maxpat.dsp_sim --patch X --topology Y --param Z --sweep "lo,hi,n"` manual-reproduction entry point with classification + measurement table + ASCII sparkline.
  - `__init__.py` re-exports `run_simulation`, `SimulationReport`, `TopologyError`, the four failure-mode names.
- Custom-mirror escape hatch — same `run_simulation(...)` API accepts `mirror=callable` instead of `topology=name` so off-catalogue patches can supply a hand-rolled numpy mirror without contorting through the topology library (D-01).
- Test-fixture convention: `tests/dsp_sim/test_<patch_stem>.py` per gated patch, calling `run_simulation(...)` with the `(patch_path, param_name, sweep_range)` triple. Filename convention IS the discovery mechanism — no registry, no annotations (D-02, D-07).
- `max-dsp-agent` integration: agent computes `Path(patch).stem`, looks for `tests/dsp_sim/test_<stem>.py`, runs pytest on it as a pre-flight gate before commit; failure blocks the save with VALID-05 'error' severity (D-04).
- Bassoon regression fixtures — both `tests/dsp_sim/test_bassoon-model.py` (which gates the live patch on the v0.4.2 fix passing) AND fixtures asserting that v0.4.0 reproductions trip `phase_drift` and v0.4.1 reproductions trip `mode_competition`. The simulator is validated end-to-end by reproducing the historical regressions (D-06).
- Documentation: short Builder API-style entry in `.claude/skills/max-dsp-agent/SKILL.md` describing how to register a sim test, plus `tests/dsp_sim/README.md` summarising the topology catalogue, the four failure modes, and the threshold knobs.

**Out of scope:**
- GenExpr → numpy auto-transpilation. The user supplies the topology name (or a custom mirror) per fixture; the harness does not parse codeboxes.
- Live audio simulation / real-time MAX-driven runs — REQUIREMENTS.md "Out of scope" lists this explicitly; pure numpy offline only.
- In-`.maxpat` annotation, sidecar `*.dspsim.json`, or per-project `config.json` `dsp_sim` block — Python-only test registration was selected (D-02). The .maxpat round-trip is unaffected.
- Auto-detection of waveguide structure in `max-dsp-agent`. Trigger is opt-in via filename presence; non-waveguide patches and patches without a sim fixture commit freely (D-04).
- Loose-tolerance defaults or per-test relaxation as the default surface — tight defaults ship as the baseline (D-05). If a real fixture proves them too aggressive, individual `run_simulation(...)` calls may pass override kwargs, but the API does NOT advertise per-test loosening as a documented escape hatch this phase.
- New topologies beyond `bore_only`, `reed_bore`, `reed_bore_post_radiation`. Adding more (string, plate, cylinder-with-tonehole) is a follow-up; v0.4.x bassoon shapes are covered by `reed_bore` and `reed_bore_post_radiation`.
- Promoting `dsp_sim` failures into `src/maxpat/critics/dsp_critic.py` — the gate runs at agent-invocation time, not as part of the existing critic pipeline. The critic file stays scope-clean for this phase.
- A second CLI subcommand for batch-running every gated test (e.g., `--all`). Manual reproduction is single-fixture; bulk runs are pytest's job.

</domain>

<decisions>
## Implementation Decisions

### Simulator Surface (DSPSIM-01, DSPSIM-04)
- **D-01:** **Topology library + custom-mirror escape hatch.** Curated topologies live in `src/maxpat/dsp_sim/topologies/` (`bore_only`, `reed_bore`, `reed_bore_post_radiation`). The same `run_simulation(...)` entry point accepts either `topology="reed_bore_post_radiation"` (default path; covers the bassoon shapes already) or `mirror=callable` (escape hatch for off-catalogue patches). One API, two on-ramps. Generic delay+filter+nonlinearity slot scaffold rejected — the curated topology already encodes the bassoon delay-line + onepole + reed-LUT + post-radiation biquad shape, so the slot generic would force every caller to wire what the library bakes in. Per-patch numpy mirror as the only path rejected — user has done that manually for the bassoon saga; phase 32 codifies the common shape so future waveguides reuse, not rewrite. The mirror escape hatch preserves option-3 freedom when needed.

### Patch ↔ Simulator Binding (DSPSIM-05)
- **D-02:** **Python-only test registration.** The `(patch_path, param_name, sweep_range)` triple from DSPSIM-05 lives in a fixture file `tests/dsp_sim/test_<patch_stem>.py` that calls `run_simulation(patch_path=..., param_name=..., sweep=...)`. No sidecar JSON, no patch-comment annotation, no `config.json` block. Rationale: the .maxpat stays untouched (no round-trip risk), the fixture is a normal pytest module (greppable, IDE-friendly), and the discovery mechanism (D-07) is a filename convention. Sidecar JSON rejected (one more file format to keep in sync). Comment-box annotation rejected (parsing comments leaks structure into the patch and round-trip). `config.json` block rejected (one config field per project is awkward when a project ships multiple patches).
- **D-07:** **Discovery via filename convention `tests/dsp_sim/test_<patch_stem>.py`.** `max-dsp-agent` computes `Path(patch).stem` (e.g., `bassoon-model` for `patches/bassoon-model/generated/bassoon-model.maxpat`) and looks for `tests/dsp_sim/test_<stem>.py`. If present → run pytest on that file as the pre-flight gate. If absent → no gate. Zero registry, single source of truth, greppable. Registry file rejected (boilerplate per patch). Pytest marker rejected (couples agent to pytest internals).

### Failure-Mode Classifier (DSPSIM-02, DSPSIM-04)
- **D-03:** **Distinct diagnostics per failure mode.** `classifier.py` emits one of `mode_competition`, `phase_drift`, `no_oscillation`, `runaway`. Each carries its own threshold and its own reason string. The structured `SimulationReport` returned by `run_simulation(...)` includes:
  - `verdict: Literal['pass', 'mode_competition', 'phase_drift', 'no_oscillation', 'runaway']`
  - `measurements: list[StepMeasurement]` — one per sweep step: `param_value`, `target_hz`, `measured_hz`, `cents_offset`, `rms_amplitude`, `peak_amplitude`
  - `worst_step: int | None` — index of the step that triggered the failure (None on pass)
  - `reason: str` — human-readable diagnostic (e.g., `"phase_drift: fundamental shifted 18 cents over Param 'bell_bright' sweep [0.0, 1.0] (limit 5)"`).
  - `suggested_fix: str | None` — optional, drawn from a fixed table tied to the verdict (e.g., `mode_competition` → "move filter post-loop or reduce Q below ~1"; `phase_drift` → "use phase delay (atan2-based) compensation, not group delay"). Mirrors the existing recipes in `feedback_waveguide_loop_phase_comp.md` so the agent's failure message matches the user's mental model.
- **D-09:** **Verdict ordering is exclusive and prioritised** — if multiple modes would trigger on the same sweep, the classifier emits the first hit in this priority: `runaway` > `no_oscillation` > `mode_competition` > `phase_drift`. Single verdict per run keeps the agent's commit-block message unambiguous; the full per-step measurement table is still in the report for debugging.

### Default Thresholds (DSPSIM-02)
- **D-05:** **Tight defaults, all overridable per-call.**
  - `phase_drift`: |max(cents_offset) − min(cents_offset)| > **5 cents** across the sweep.
  - `no_oscillation`: post-settle `rms_amplitude` < **1e-4** at any step.
  - `mode_competition`: |cents_offset| > **50 cents** at any single step (large pitch jump indicates lock onto filter resonance, not freq_mod).
  - `runaway`: `peak_amplitude` > **10.0** OR any NaN/Inf in the output buffer.
  - `settle_ms` = **100ms** (skip first 4410 samples @ 44.1k before measuring fundamental).
  - `sweep_steps` = **32** linear steps across `(param_lo, param_hi)`.
  - `sample_rate` = **44100** Hz default; tests may override.
  - All thresholds + sweep params accepted as kwargs to `run_simulation(...)` (`cents_drift_limit=`, `mode_competition_jump=`, `amplitude_floor=`, `runaway_amplitude=`, `settle_ms=`, `sweep_steps=`, `sample_rate=`). Override path is a quiet escape hatch, not the documented default.

### Agent Trigger & Severity (DSPSIM-03)
- **D-04:** **Opt-in per-patch via filename presence; hard block on fail.** When `max-dsp-agent` is about to commit a patch, it checks for `tests/dsp_sim/test_<stem>.py`. If present, agent runs `pytest tests/dsp_sim/test_<stem>.py -q` and:
  - **Passing** → save proceeds; agent surfaces a one-line "DSP pre-flight: passed (N steps, max drift X cents)" in its summary.
  - **Failing** → commit is blocked. Agent surfaces the verdict, sweep param, worst step's measured Hz vs target Hz, and the `suggested_fix` string. Severity = error (VALID-05 'error' tier). Author must fix or explicitly opt out.
  - **No fixture file** → no gate; agent commits as before. Non-waveguide patches and patches that haven't been instrumented yet are unaffected.
- **D-10:** **Opt-out path is "delete or move the fixture", not a flag.** No `--skip-dsp-sim` flag on the agent. If the author needs to commit while the sim is failing (unlikely; the whole point is to block bad commits), they delete or skip-mark the test. This makes opt-out auditable in git history. Matches the project's "validation reports findings, user decides via the surface visible in code" pattern.

### Regression Fixtures (DSPSIM-04)
- **D-06:** **Both v0.4.0 (group-delay) AND v0.4.1 (high-Q-in-loop) bassoon mirrors ship as canonical regression fixtures.**
  - `tests/dsp_sim/fixtures/bassoon_v040_mirror.py` reproduces the v0.4.0 GenExpr math (group-delay compensation form for the in-loop biquad) and asserts `verdict == 'phase_drift'` when `bell_bright` sweeps [0, 1].
  - `tests/dsp_sim/fixtures/bassoon_v041_mirror.py` reproduces v0.4.1 (correct phase-delay compensation but bell biquad still inside the loop) and asserts `verdict == 'mode_competition'` on the same sweep.
  - `tests/dsp_sim/test_bassoon-model.py` gates the LIVE `patches/bassoon-model/generated/bassoon-model.maxpat` (v0.4.2+ with biquad post-loop) and asserts `verdict == 'pass'` on the same `bell_bright` sweep — proves the simulator agrees that the shipped fix is stable.
  - Three assertions, one per failure-mode-or-pass, validate the classifier's discrimination end-to-end. v0.5.0 (reed BPF in-loop) is left as a deferred follow-up fixture — the v0.4.1 case already exercises the same mode_competition code path.
- **D-11:** **Fixture mirrors are hand-coded numpy, sourced from `versions.json`'s description of each commit.** They are NOT auto-extracted from the .gendsp file. The mirrors live alongside the test as small (~80–120 LOC) files; reading `feedback_waveguide_loop_phase_comp.md` and `versions.json` for each version gives enough information to reproduce the failure mode. Mirrors target the failure mechanism (filter-in-loop with specified Q and compensation form), not bit-exact reproduction of every Param.

### CLI Surface (DSPSIM-05)
- **D-08:** **`python -m src.maxpat.dsp_sim` ships as a manual-reproduction entry point.** Invocation: `python -m src.maxpat.dsp_sim --patch <path> --topology <name> --param <name> --sweep "lo,hi,n" [--mirror <module:func>] [--cents-drift-limit N] [...]`. Output: classification verdict, per-step measurement table, ASCII sparkline of `cents_offset` across the sweep, and `suggested_fix` string when failing. Exit code: 0 on pass, non-zero (1=phase_drift, 2=mode_competition, 3=no_oscillation, 4=runaway) so the CLI is grep-friendly in shell scripts. Pytest stays the canonical agent-side path; the CLI is for ad-hoc "sweep this one Param real quick" workflows that don't need a fixture file.

### Claude's Discretion
- **Plan boundaries** — natural split: 32-01 runner + measurement (`runner.py`, `measure.py`) + classifier with thresholds (`classifier.py`) + unit tests for the classifier on synthetic signals; 32-02 topology library (`topologies/bore_only.py`, `reed_bore.py`, `reed_bore_post_radiation.py`) + topology unit tests; 32-03 max-dsp-agent integration (filename discovery, pytest invocation, error reporting) + SKILL.md update; 32-04 bassoon regression fixtures (v0.4.0 + v0.4.1 mirrors and live-patch test) + assertions; 32-05 CLI entry point (`cli.py` + `__main__.py`) + integration test against the bassoon fixtures. Planner may merge 32-01/02 if shape allows; 32-04 must land after 32-01 and 32-02 (depends on both classifier and at least the `reed_bore_post_radiation` topology — or a custom mirror in the v0.4 fixtures).
- **Internal helper placement** — whether `measure.py` (autocorr + FFT fundamental tracker) lives separately from `classifier.py` or is inlined. Either works; separating them lets the CLI reuse measurement output without re-running classification.
- **Topology API shape** — function vs. class. Each topology likely needs internal state (delay buffer, filter histories), so a class with `__init__(sample_rate, params)` and `step(input_sample) -> output_sample` is natural. Planner may pick a callable factory if it cleans up `run_simulation`. Whatever shape lands, the public surface is `run_simulation(topology="reed_bore_post_radiation", ...)`.
- **Whether each topology takes a fixed Param list or a `params: dict[str, float]`** — dict-based is more uniform and matches gen~'s Param names; fixed signatures are more pythonic. Planner picks; the user-facing `run_simulation(...)` call should accept a dict either way.
- **Excitation signal for the sweep** — most natural is constant breath-pressure-equivalent (`in1 = freq_target`, `in2 = 0.6` — typical playing pressure in the bassoon model). Planner may decide whether to ramp `in2` over `settle_ms` to avoid impulse artifacts at simulation start, or just let the settle window swallow the transient.
- **CLI sparkline character set** — Unicode block chars (▁▂▃▄▅▆▇█) vs. ASCII (`-=#`). Pick whichever survives in CI logs; user terminal supports Unicode.
- **Whether to ship a `tests/dsp_sim/conftest.py`** with shared fixtures (sample_rate=44100, default sweep ranges, pytest-tmp helpers). Likely yes if more than one test file ends up sharing scaffolding.
- **Whether the CLI auto-detects the topology when `--patch` is supplied** by reading a project-config hint, or always requires explicit `--topology`. Default to explicit; auto-detection couples the CLI to D-02's "no patch binding" decision and we can always add a hint later.

</decisions>

<canonical_refs>
## Canonical References

**Downstream agents MUST read these before planning or implementing.**

### Roadmap & Requirements (this milestone)
- `.planning/ROADMAP.md` §"Phase 32: DSP Pre-Flight Simulation" — phase goal, success criteria, dependencies (none).
- `.planning/REQUIREMENTS.md` §"DSP Pre-Flight Simulation (Phase 32)" — the five DSPSIM-* requirements verbatim.
- `.planning/STATE.md` — milestone-level decisions for v5.0 (Phase 32 declared independent of Phase 28; could ship first or last).
- `.planning/PROJECT.md` §"Constraints" — "No MAX automation" rule justifies the offline-numpy-only scope of this phase.

### Prior Phase Artifacts (optional context only — Phase 32 is independent)
- `.planning/phases/29-validator-depth/29-CONTEXT.md` §"VALID-05 error/warning split" — the simulator's hard-block path (D-04) reuses the same severity contract.
- `.planning/phases/31-layout-ux-builders/31-CONTEXT.md` — the most recent example of a "module + tests + SKILL.md update" phase shape; useful as a planning template even though no schema is shared.

### Codebase Anchors (must read before editing)
- `src/maxpat/critics/dsp_critic.py` — existing DSP critic patterns (`review_dsp`, `_check_gain_staging`, `_check_audio_rate_consistency`, `_check_unsafe_gain_sources`). Phase 32 does NOT extend this file; the simulator is a separate module invoked at agent-commit time, not inside the critic pipeline. Read it to understand which checks the existing pipeline already covers (so Phase 32 doesn't duplicate them).
- `src/maxpat/codegen.py` — `parse_genexpr_io` is the only existing GenExpr parser in the codebase. Phase 32 deliberately does NOT add a transpiler, but reading this confirms the scope boundary.
- `patches/bassoon-model/generated/bassoon.gendsp` — current (v0.4.2+) bassoon Gen~ code. The `reed_bore_post_radiation` topology mirrors this shape (in-loop bore_damp onepole with phase-delay compensation; post-loop bell biquad and reed BPF). The live-patch test fixture uses this file.
- `patches/bassoon-model/versions.json` — full saga of v0.0.0 → v0.5.x. v0.4.0 / v0.4.1 / v0.4.2 entries are the source of the regression fixtures; v0.5.0 / v0.5.1 are the deferred follow-up case.
- `patches/bassoon-model/context.md` — narrative behind the bassoon model and the design choices that motivated the simulator. Useful background for the phase researcher.
- `tests/conftest.py` — existing pytest fixtures (`all_objects`, `objects_by_domain`). Phase 32 adds `tests/dsp_sim/conftest.py` (Claude's discretion) with sim-specific fixtures.
- `tests/test_critics.py` — class-based test pattern that the new `tests/dsp_sim/test_*.py` files mirror.
- `scripts/audit_signal_role.py` — existing standalone module entry point pattern (`__main__.py` style). The new `python -m src.maxpat.dsp_sim` follows the same pattern.
- `.claude/skills/max-dsp-agent/SKILL.md` — destination for the new "DSP Pre-Flight Simulation" section describing how to register a sim test and how the agent gates on it.

### Convention References
- `CLAUDE.md` §"Gen~ (GenExpr DSP Code)" — `History`, `Delay.read/write`, declaration ordering. The topology library mirrors these constructs in numpy (e.g., `History` ↔ scalar state in the topology class; `Delay.read/write` ↔ numpy circular buffer).
- `CLAUDE.md` §"Rule #2: Verify Before Connect" — informs why the sim runs OUTSIDE the existing critic pipeline (it needs to actually execute numpy code, not just inspect the graph).
- `CLAUDE.md` §"Rule #7: Commit After Every Save" — D-04's hard-block-on-fail is the right severity because patch saves auto-commit; an unstable patch must not reach git.
- Memory: `feedback_waveguide_loop_phase_comp.md` — the canonical reference for the two failure modes, the Q heuristic (≤1 in-loop / ≥1.5 post-loop), and the analytic phase-delay formulas for onepole + biquad. The `suggested_fix` strings emitted by the classifier (D-03) lift their wording from this memory so the agent's failure message matches the user's existing mental model.
- Memory: `project_bassoon_model.md` — the v0.2.0 baseline DSP architecture and the freq-as-MIDI-note input convention. The fixture mirrors must use freq-as-Hz at simulation level (skip the `mtof` step) since the topology takes a Hz scalar directly.

</canonical_refs>

<code_context>
## Existing Code Insights

### Reusable Assets
- **`numpy 2.4` + `scipy 1.17` already installed** — `scipy.signal` covers autocorrelation (`scipy.signal.correlate`) and FFT (`scipy.signal.welch` for fundamental detection). No dependency additions required.
- **`scripts/audit_signal_role.py`** — existing standalone-script template; informs the `cli.py` + `__main__.py` shape for `python -m src.maxpat.dsp_sim`.
- **`src/maxpat/critics/dsp_critic.py`** — already does graph-shape DSP analysis. The new simulator complements it: critic checks structure (gain staging, gen~ I/O match), simulator checks dynamic behaviour (does the loop actually oscillate stably?). No overlap.
- **`tests/test_critics.py` class structure** — template for `tests/dsp_sim/test_classifier.py`, `test_topologies.py`, `test_runner.py`.
- **`patches/bassoon-model/versions.json` descriptions** — verbose enough to hand-extract each version's filter coefficients and compensation form into the regression mirrors without reading every commit's diff.

### Established Patterns
- **Module-level entry points exposed via `__init__.py`** — every other package under `src/maxpat/` follows this. `dsp_sim/__init__.py` exports `run_simulation`, `SimulationReport`, the failure-mode constants, and `TopologyError`.
- **`from __future__ import annotations` + `dataclass`-shaped report objects** — used in `critics/base.py` (`CriticResult`). `SimulationReport` and `StepMeasurement` follow.
- **Pytest fixtures in `conftest.py` per test directory** — `tests/conftest.py` patterns inform the optional `tests/dsp_sim/conftest.py`.
- **CLI exit-code conventions** — `audit_signal_role.py` uses 0/1; the simulator extends this with 1=phase_drift, 2=mode_competition, 3=no_oscillation, 4=runaway so shell scripts can branch on the failure mode.
- **VALID-05 error/warning severity contract** — the simulator's hard-block (D-04) reuses error tier; `no fixture file` reuses no-finding (silent pass).

### Integration Points
- **No new top-level dependency** — numpy + scipy already installed; pytest already in the dev workflow.
- **`max-dsp-agent` SKILL.md** — single touchpoint for the agent integration. The agent reads this file at run time; adding a "DSP Pre-Flight Simulation" section is sufficient to wire D-04. No agent-prompt code changes elsewhere.
- **No `.maxpat` schema changes** — D-02 means the patch file is untouched. `save_patch_roundtrip()` and the existing round-trip tests stay green by construction.
- **No `.claude/max-objects/` changes** — simulator is pure DSP code; doesn't read or write the object DB.
- **No `src/maxpat/critics/dsp_critic.py` changes** — the simulator is invoked at agent-commit time, not as part of `review_dsp`. Existing critic tests stay green.
- **`patches/bassoon-model/` is the proving ground** — the live-patch sim test (`tests/dsp_sim/test_bassoon-model.py`) is the canonical end-to-end gate. Future waveguide projects (e.g., a clarinet variant) follow the same pattern: drop a `tests/dsp_sim/test_<stem>.py` next to their patch and pick a topology.

</code_context>

<specifics>
## Specific Ideas

- **Public API surface**:
  ```python
  from src.maxpat.dsp_sim import run_simulation, SimulationReport

  report = run_simulation(
      patch_path="patches/bassoon-model/generated/bassoon-model.maxpat",
      topology="reed_bore_post_radiation",
      params={"freq": 220.0, "breath": 0.6, "bore_damp": 0.3, "bell_bright": 0.5, ...},
      sweep_param="bell_bright",
      sweep=(0.0, 1.0, 32),
      # threshold overrides (all optional):
      cents_drift_limit=5.0,
      mode_competition_jump=50.0,
      amplitude_floor=1e-4,
      runaway_amplitude=10.0,
      settle_ms=100,
      sample_rate=44100,
  )
  assert report.verdict == "pass", report.reason
  ```

- **Custom mirror escape hatch**:
  ```python
  def my_custom_loop(sample_rate, params):
      # returns an object with a .step(in1, in2) -> out method, OR
      # returns a callable that takes (n_samples, params) -> ndarray
      ...

  report = run_simulation(
      patch_path="patches/foo/foo.maxpat",
      mirror=my_custom_loop,   # mutually exclusive with topology=
      params={...},
      sweep_param="custom_q",
      sweep=(0.5, 5.0, 32),
  )
  ```

- **Bassoon regression assertion shape**:
  ```python
  # tests/dsp_sim/fixtures/bassoon_v040_mirror.py
  def build_v040_mirror(sample_rate, params): ...

  # tests/dsp_sim/test_bassoon_v040_regression.py
  def test_v040_phase_drift_is_caught():
      r = run_simulation(
          patch_path="<not-a-real-patch>",
          mirror=build_v040_mirror,
          params={"freq": 220.0, "breath": 0.6, ...},
          sweep_param="bell_bright",
          sweep=(0.0, 1.0, 32),
      )
      assert r.verdict == "phase_drift", r.reason
  ```

- **Live-patch gate**:
  ```python
  # tests/dsp_sim/test_bassoon-model.py  -- filename matches Path("patches/bassoon-model/generated/bassoon-model.maxpat").stem
  def test_bassoon_bell_bright_sweep_stable():
      r = run_simulation(
          patch_path="patches/bassoon-model/generated/bassoon-model.maxpat",
          topology="reed_bore_post_radiation",
          params={"freq": 220.0, "breath": 0.6, ...},
          sweep_param="bell_bright",
          sweep=(0.0, 1.0, 32),
      )
      assert r.verdict == "pass", r.reason
  ```

- **CLI invocation contract**:
  ```bash
  python -m src.maxpat.dsp_sim \
      --patch patches/bassoon-model/generated/bassoon-model.maxpat \
      --topology reed_bore_post_radiation \
      --param bell_bright \
      --sweep "0.0,1.0,32" \
      --params "freq=220,breath=0.6,bore_damp=0.3"
  # Exit 0 on pass; 1=phase_drift, 2=mode_competition, 3=no_oscillation, 4=runaway.
  ```

- **Threshold defaults table** (for `classifier.py`):
  | Knob | Default | Failure mode |
  |------|---------|--------------|
  | `cents_drift_limit` | 5.0 | `phase_drift` |
  | `mode_competition_jump` | 50.0 | `mode_competition` |
  | `amplitude_floor` | 1e-4 | `no_oscillation` |
  | `runaway_amplitude` | 10.0 | `runaway` |
  | `settle_ms` | 100 | (all) |
  | `sweep_steps` | 32 | (all) |
  | `sample_rate` | 44100 | (all) |

- **Verdict priority** (D-09): `runaway` > `no_oscillation` > `mode_competition` > `phase_drift` > `pass`. Exit codes mirror this ordering.

- **Suggested-fix table** (D-03), wording lifted from `feedback_waveguide_loop_phase_comp.md`:
  | Verdict | Suggested fix |
  |---------|---------------|
  | `phase_drift` | "Use phase delay (atan2-based) compensation, not group delay. Onepole: `pd = atan(b·sin(w)/(1-b·cos(w))) / w`. Biquad: evaluate B(e^jw)/A(e^jw) phase, subtract." |
  | `mode_competition` | "Move the high-Q (Q > ~1) filter post-loop. In-loop resonant filters compete with the bore's self-excited mode and detune the fundamental." |
  | `no_oscillation` | "Loop dissipation likely too high. Check `cone_loss` / damping coefficients; verify excitation reaches the loop." |
  | `runaway` | "Loop gain ≥ 1. Add a saturator (`tanh`, `clamp`) or reduce reflection scalar to keep `\\|loop_gain\\| < 1`." |

</specifics>

<deferred>
## Deferred Ideas

- **Auto-transpilation of GenExpr → numpy** (`codebox.code` parser). Largest possible scope; out of v5.0. Future phase if the topology library proves too restrictive in practice. Until then, the custom-mirror escape hatch + topology library cover the cases.
- **Sidecar `*.dspsim.json` config file** — rejected this phase (D-02) but the right answer if non-Python tooling (CI dashboards, MAX-side reporting) ever needs to read sim configs. Revisit only if a real consumer appears.
- **In-`.maxpat` annotation comment as a binding mechanism** — same status; revisit only if patch-portability across machines without the test suite becomes a real need.
- **v0.5.0 / v0.5.1 reed-BPF-in-loop fixture** — the v0.4.1 mode_competition fixture already exercises the same code path. Adding the reed-side variant is a nice-to-have that proves the classifier catches mode_competition from a source-side filter, not just a reflection-side filter. Add when convenient; not blocking.
- **v0.3.1 onepole phase-delay-compensation regression fixture** — the v0.4.0 fixture already tests the group-vs-phase-delay axis. v0.3.1 was a successful fix, not a failure mode; it would be a "must PASS" fixture, redundant with the live-patch test.
- **Loose-tolerance preset / `mode='loose'` API knob** — explicitly rejected as a documented surface this phase (D-05); rerun with explicit override kwargs if a real fixture needs it. Promote to a documented mode only after evidence of repeated need.
- **Auto-detection of waveguide structure in `max-dsp-agent`** (run sim on every gen~ patch automatically) — opt-in is the right default this phase (D-04). Revisit when filename-convention coverage proves too sparse.
- **Additional topologies: `string_only`, `clarinet_cylinder_with_tonehole`, `plate_2d`, `tube_with_register_hole`** — the bassoon shape is what motivates this phase; broader physical-model coverage is a follow-up. Custom-mirror escape hatch keeps off-catalogue patches unblocked in the meantime.
- **Per-step ASCII spectrogram in CLI output** — sparkline of `cents_offset` is sufficient for spotting regressions; spectrogram is overkill for the failure modes the classifier surfaces.
- **Promoting `dsp_sim` checks into `dsp_critic.review_dsp(...)`** — the simulator runs separately at commit time; folding it into the critic would entangle a fast graph-shape pass with a slow numpy run. Keep them separate.
- **Bulk-run CLI subcommand (`python -m src.maxpat.dsp_sim --all`)** — pytest already runs every `tests/dsp_sim/test_*.py`. CLI stays single-fixture.
- **Integration with the existing `audit_signal_role.py` reporter** — the simulator emits its own `SimulationReport`; folding it into the audit reporter would couple unrelated concerns.

</deferred>

---

*Phase: 32-dsp-pre-flight-simulation*
*Context gathered: 2026-05-01*
