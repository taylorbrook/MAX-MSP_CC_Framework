# Phase 32: DSP Pre-Flight Simulation - Discussion Log

> **Audit trail only.** Do not use as input to planning, research, or execution agents.
> Decisions are captured in CONTEXT.md — this log preserves the alternatives considered.

**Date:** 2026-05-01
**Phase:** 32-dsp-pre-flight-simulation
**Areas discussed:** Sim surface, Patch binding, Failure modes, Agent trigger, Thresholds, Fixture scope, Discovery, CLI surface

---

## Sim surface — How the user describes the loop under test

| Option | Description | Selected |
|--------|-------------|----------|
| Topology library + Param overrides | Curated catalogue of waveguide topologies in `src/maxpat/dsp_sim/topologies/` (bore_only, reed+bore, reed+bore+post_radiation). User picks a topology and supplies Param values + sweep config. Smallest user surface; doesn't generalise to brand-new topologies. | |
| Generic loop scaffold (delay/filter/nonlinearity slots) | One generic `WaveguideLoop` class with named slots; user wires lambdas/functions per patch. Most flexible; user has to translate gen~ code into 4 callbacks per patch. | |
| Per-patch numpy mirror file | User writes `patches/<project>/dsp_sim_mirror.py` with a `mirror()` function. Harness only provides the runner. Cleanest separation, max user effort. | |
| Topology library + escape hatch | Topology library is the default path; if a patch doesn't fit, user supplies a custom mirror function via the same API. | ✓ |

**User's choice:** Topology library + escape hatch
**Notes:** Curated topologies cover the bassoon shapes already; the same `run_simulation(...)` API accepts `mirror=callable` as the off-catalogue escape hatch.

---

## Patch binding — How a `.maxpat` points at its simulator config

| Option | Description | Selected |
|--------|-------------|----------|
| Sidecar JSON: `<patch>.dspsim.json` | One sidecar file per patch declaring topology, params, sweep ranges, thresholds. Doesn't pollute .maxpat round-trip. | |
| Embedded patch annotation (comment newobj) | Comment box in the .maxpat with `dsp_sim: ...` declaration. Self-contained; requires comment parsing and round-trip handling. | |
| Project config: `config.json` `dsp_sim` block | Per-project config gains a `dsp_sim` section. Simple if a project ships one waveguide; awkward if multiple. | |
| No binding — Python registration only | The `(patch_path, param_name, sweep_range)` triple lives in `tests/dsp_sim/test_<patch>.py` calling `run_simulation(...)`. Patch untouched. | ✓ |

**User's choice:** No binding — Python registration only
**Notes:** Most pythonic; the patch round-trip stays clean. Discovery of the gating test is via filename convention (see Discovery area below).

---

## Failure modes — What the classifier surfaces

| Option | Description | Selected |
|--------|-------------|----------|
| Distinct diagnostics per failure mode | Classifier emits one of: `mode_competition`, `phase_drift`, `no_oscillation`, `runaway`. Each has its own threshold. Catches the v0.4.0 vs v0.4.1 distinction explicitly. | ✓ |
| Single stability verdict + measurements | Pass/fail flag plus raw measurements; user reads the table and judges. Loses auto-classification. | |
| Distinct diagnostics + structured report | Same as option 1, but also emit a structured `DSPSIM-REPORT.md` with classification + suggested fix. Heaviest. | |

**User's choice:** Distinct diagnostics per failure mode
**Notes:** The selected option also implicitly covers structured reporting — the `SimulationReport` returned by `run_simulation` carries `verdict`, `reason`, `measurements`, and a `suggested_fix` lifted from `feedback_waveguide_loop_phase_comp.md`. The full markdown report file (`DSPSIM-REPORT.md`) was the third option; the agent surfaces a one-line summary instead, with full per-step measurements available in the in-memory report.

---

## Agent trigger — When max-dsp-agent invokes the simulator and severity

| Option | Description | Selected |
|--------|-------------|----------|
| Opt-in per-patch, hard block on fail | Agent runs only when a sim binding exists for the patch. Instability blocks commit (VALID-05 'error' tier). | ✓ |
| Opt-in per-patch, warning only | Same opt-in trigger; failure surfaces as warning, doesn't block save. Lower friction; risks regression class re-emerging. | |
| Auto-detect waveguide, hard block on fail | Agent heuristic-detects waveguide structure and invokes the simulator without opt-in. Most aggressive coverage; risks false positives. | |
| Manual via /max-verify or CLI only | Agent never runs the simulator automatically; author runs the CLI explicitly. DSPSIM-03 would need reinterpretation. | |

**User's choice:** Opt-in per-patch, hard block on fail
**Notes:** Opt-in is via filename presence (see Discovery). Hard block is the right severity because patch saves auto-commit — an unstable patch must not reach git.

---

## Thresholds — Default classifier thresholds

| Option | Description | Selected |
|--------|-------------|----------|
| Tight (5 cents, 100ms settle, 32-step sweep) | `phase_drift` >5 cents; `no_oscillation` <1e-4 amplitude; `mode_competition` >50 cents jump; `runaway` >10 amplitude or NaN. | ✓ |
| Loose (15 cents, 200ms settle, 16-step sweep) | Same other thresholds; faster sweeps, fewer false positives. Risk: misses subtle regressions. | |
| Tight default + per-test override kwargs | Tight defaults but `run_simulation` accepts override kwargs. Most flexible. | |

**User's choice:** Tight (5 cents, 100ms settle, 32-step sweep)
**Notes:** All thresholds remain overridable via kwargs (the implementation provides this even though it isn't the documented default surface). Per-test overrides are a quiet escape hatch, not the primary API.

---

## Fixture scope — Which bassoon version(s) become the canonical regression fixture

| Option | Description | Selected |
|--------|-------------|----------|
| Both v0.4.0 and v0.4.1 | v0.4.0 catches group-vs-phase-delay (`phase_drift`); v0.4.1 catches high-Q-in-loop (`mode_competition`). Two fixtures, two distinct assertions. | ✓ |
| v0.4.1 only (the harder case) | If the simulator catches v0.4.1, it catches a superset of v0.4.0. Single fixture. | |
| Both, plus v0.5.0 (reed BPF in-loop) and v0.4.2 (passing baseline) | Four fixtures: v0.4.0, v0.4.1, v0.5.0, v0.4.2. Heaviest but most thorough. | |

**User's choice:** Both v0.4.0 and v0.4.1
**Notes:** The live-patch test for `bassoon-model.maxpat` (v0.4.2+) is added on top of these two; that gives three assertions (v0.4.0 → `phase_drift`, v0.4.1 → `mode_competition`, live → `pass`). v0.5.0 deferred as a follow-up fixture since v0.4.1 already exercises the same `mode_competition` code path.

---

## Discovery — How max-dsp-agent finds which sim test gates which patch

| Option | Description | Selected |
|--------|-------------|----------|
| Filename convention: `tests/dsp_sim/test_<patch_stem>.py` | Agent computes `Path(patch).stem` and looks for matching test file. Zero registry, single source of truth. | ✓ |
| Registry file: `tests/dsp_sim/registry.py` | A `SIM_REGISTRY` dict mapping patch paths to test modules. More explicit; more boilerplate. | |
| Pytest marker on tests + agent runs all sim tests on save | Tests decorated with `@pytest.mark.dsp_sim(patch="...")`. Agent runs `pytest -m dsp_sim` filtered by patch path. Couples agent to pytest internals. | |

**User's choice:** Filename convention `tests/dsp_sim/test_<patch_stem>.py`
**Notes:** Greppable, no registry to keep in sync, and it pairs naturally with the "no patch binding" decision — the binding is the filename itself.

---

## CLI surface — Manual reproduction CLI

| Option | Description | Selected |
|--------|-------------|----------|
| `python -m src.maxpat.dsp_sim --patch X --topology Y --param Z --sweep "a,b,n"` | Standalone invocation, classification + measurements + ASCII sparkline output. | ✓ |
| No CLI — pytest -k <name> is the only path | Smaller surface area; reproducing means running the test fixture. Slightly less ergonomic. | |

**User's choice:** Yes — `python -m src.maxpat.dsp_sim --patch X --topology Y --param Z --sweep "a,b,n"`
**Notes:** Pytest stays the canonical agent-side path. CLI is for ad-hoc "sweep this Param real quick" workflows. Exit codes mirror the verdict priority (1=phase_drift, 2=mode_competition, 3=no_oscillation, 4=runaway) so shell scripts can branch.

---

## Claude's Discretion

- Plan boundaries (likely 5 plans): runner+classifier, topology library, agent integration, regression fixtures, CLI.
- Internal helper placement (`measure.py` separate from `classifier.py` or inlined).
- Topology API shape (class with `step()` vs. callable factory).
- Whether topologies take a fixed Param list or a `params: dict[str, float]`.
- Excitation signal for the sweep (constant breath pressure with optional ramp during settle window).
- CLI sparkline character set (Unicode block chars vs. ASCII).
- Whether to ship `tests/dsp_sim/conftest.py` with shared sim fixtures.
- Whether the CLI auto-detects topology from a project-config hint or always requires explicit `--topology`.
- Verdict priority ordering (`runaway` > `no_oscillation` > `mode_competition` > `phase_drift`) — captured as D-09 but flagged here as a small judgment call the planner may revisit.

## Deferred Ideas

- Auto-transpilation of GenExpr → numpy (largest possible scope; not v5.0).
- Sidecar `*.dspsim.json` (rejected D-02; revisit only if non-Python tooling needs to read sim configs).
- In-`.maxpat` annotation comment as a binding mechanism.
- v0.5.0 / v0.5.1 reed-BPF-in-loop fixture (covered by v0.4.1 code path; nice-to-have follow-up).
- v0.3.1 onepole phase-delay-compensation passing-baseline fixture (redundant with live-patch test).
- Loose-tolerance preset / `mode='loose'` API knob.
- Auto-detection of waveguide structure in `max-dsp-agent` (auto-trigger).
- Additional topologies (string, clarinet cylinder with tonehole, plate, tube with register hole).
- Per-step ASCII spectrogram in CLI output (sparkline is sufficient for the failure modes).
- Folding `dsp_sim` checks into `dsp_critic.review_dsp(...)` (separation of fast graph pass vs. slow numpy run).
- Bulk-run CLI subcommand (`--all`); pytest already covers this.
- Integration with `audit_signal_role.py` reporter (unrelated concerns).
