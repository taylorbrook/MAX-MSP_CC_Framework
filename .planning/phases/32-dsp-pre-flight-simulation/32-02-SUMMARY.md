---
phase: 32-dsp-pre-flight-simulation
plan: 02
subsystem: dsp
tags: [dsp, waveguide, gen, numpy, scipy, bassoon, mcintyre-woodhouse, biquad]

# Dependency graph
requires:
  - phase: 32-01
    provides: "TopologyError class (canonical source) + run_simulation orchestrator + ClassifierThresholds + StepMeasurement"
provides:
  - "src.maxpat.dsp_sim.topologies subpackage with three curated waveguide classes"
  - "TOPOLOGIES registry dict + get_topology(name) helper"
  - "BoreOnly: passive bore loop sanity-check (mirrors bassoon.gendsp Data bore(8192))"
  - "ReedBore: rectified McIntyre-Woodhouse reed + bore (v0.3.x ancestor shape)"
  - "ReedBorePostRadiation: v0.4.2+ canonical bassoon shape (post-loop bell biquad + reed BPF)"
  - "16 invariant tests covering registry membership, finite-output, oscillation floor, post-loop fundamental stability"
affects: [32-03, 32-04, 32-05, max-dsp-agent]

# Tech tracking
tech-stack:
  added: []  # numpy 2.4 + scipy 1.17 already installed
  patterns:
    - "Gen~ -> numpy mapping: History x -> _x scalar field; Data buf(N) -> np.zeros(N) + _wi index; Delay.read -> mod-arithmetic indexed read"
    - "Topology API contract: @dataclass with sample_rate + params, step(in1, in2) -> float per-sample API matching GenExpr in1/in2/out1 convention"
    - "T-04 mitigation pattern: clamp delta_p to [0,1], clamp delay_samples below buffer size, clamp Q-factors >= 0.1 to keep biquad coefficients bounded"
    - "Worktree-isolation fallback: lazy try/except import of dependency-plan symbols (TopologyError) with local re-definition so tests pass standalone before merge"

key-files:
  created:
    - "src/maxpat/dsp_sim/topologies/__init__.py"
    - "src/maxpat/dsp_sim/topologies/bore_only.py"
    - "src/maxpat/dsp_sim/topologies/reed_bore.py"
    - "src/maxpat/dsp_sim/topologies/reed_bore_post_radiation.py"
    - "tests/dsp_sim/test_topologies.py"
  modified: []

key-decisions:
  - "Worktree-isolation fallback for TopologyError: try/except ImportError so 32-02 tests run standalone, with canonical class re-bound after 32-01 lands"
  - "Stub-then-replace pattern for the topology registry: Tasks 2 and 3 overwrite Task 1's minimal stubs so the registry __init__.py is importable from Task 1 onward"
  - "Narrow-band FFT fundamental tracker (target_hz + search_octaves) because bell LPF / reed BPF post-loop chains can produce louder spectral peaks than the bore loop's actual fundamental; the v0.4.2+ stability invariant cares about the LOOP fundamental"
  - "Body formant biquad coefficients computed once in __post_init__ (fixed model parameters, +6 dB @500 Hz Q=3); bell + reed BPF coefficients recomputed per step because bell_bright is the swept Param"

patterns-established:
  - "Topology @dataclass shape: per-instance state via field(init=False, default=...); numpy circular buffer initialized in __post_init__"
  - "75-char === banner separators between test classes (TestRegistry, TestBoreOnly, TestReedBore, TestReedBorePostRadiation)"
  - "Per-class _make() helper in test classes for constructing the topology with overrideable params; bypasses long argument lists in every test"

requirements-completed: [DSPSIM-01, DSPSIM-04]

# Metrics
duration: ~30min
completed: 2026-05-01
---

# Phase 32 Plan 02: DSP Pre-Flight Topology Library Summary

**Three curated waveguide topologies (bore_only, reed_bore, reed_bore_post_radiation) covering the bassoon shape, with the v0.4.2+ post-loop placement invariant verified by FFT-based stability testing across the bell_bright sweep.**

## Performance

- **Duration:** ~30 min
- **Started:** 2026-05-01T15:38Z (worktree spawn)
- **Completed:** 2026-05-01T16:07Z
- **Tasks:** 3
- **Files created:** 5

## Accomplishments

- TOPOLOGIES registry dict + get_topology() helper closing the topology= on-ramp from D-01 (combined with 32-01's mirror= path, both routes land)
- ReedBorePostRadiation as the canonical PASSING shape against which 32-04 will compare v0.4.0/v0.4.1 mirrors to discriminate phase_drift vs mode_competition
- 16 invariant tests including the key v0.4.2+ stability assertion: post-loop bell biquad cannot detune the loop's fundamental (cents drift < 5 across the bell_bright sweep)
- Verbatim Param surface from `patches/bassoon-model/generated/bassoon.gendsp`: freq, breath, bore_damp, bell_bright, reed_stiff, reed_aper, reed_res_freq, reed_res_q, register, cone_loss
- McIntyre-Woodhouse rectified reed math transcribed verbatim from the Gen~ codebox (`delta_p = clamp(...)` -> `reed_ratio` -> `reed_opening` -> `reed_flow` -> `stiff_gain`)

## Task Commits

Each task was committed atomically (TDD cycle: RED test commit then GREEN feat commit):

1. **Task 1 RED: failing tests** - `cb92b92` (test)
2. **Task 1 GREEN: registry + BoreOnly + Task 2/3 stubs** - `782972b` (feat)
3. **Task 2 GREEN: ReedBore full implementation** - `e58874e` (feat)
4. **Task 3 GREEN: ReedBorePostRadiation v0.4.2+ + test FFT helper fix** - `5c36cd9` (feat)

_Note: Tests for all three topologies landed together in the RED commit (cb92b92) because the test file is shared; subsequent GREEN commits filled in the implementations._

## Files Created/Modified

- `src/maxpat/dsp_sim/topologies/__init__.py` (75 lines) - TOPOLOGIES dict + get_topology() helper + TopologyError fallback shim for worktree isolation
- `src/maxpat/dsp_sim/topologies/bore_only.py` (103 lines) - Passive bore waveguide with allpass fractional delay + onepole damping + cone reflection (T-04 clamps)
- `src/maxpat/dsp_sim/topologies/reed_bore.py` (117 lines) - Reed + bore loop, full McIntyre-Woodhouse rectified reed math (v0.3.x ancestor)
- `src/maxpat/dsp_sim/topologies/reed_bore_post_radiation.py` (231 lines) - v0.4.2+ canonical bassoon shape: in-loop low-Q damping + 3-stage POST-LOOP radiation chain (body formant peaking EQ, bell LPF, reed BPF)
- `tests/dsp_sim/test_topologies.py` (311 lines) - TestRegistry (4) + TestBoreOnly (3) + TestReedBore (4) + TestReedBorePostRadiation (5) = 16 invariant tests including the bell_bright-sweep stability assertion

## Decisions Made

- **Worktree-isolation fallback for TopologyError** — Plan 32-01 owns the canonical `TopologyError` class definition (in `src/maxpat/dsp_sim/runner.py`). My `topologies/__init__.py` does a try/except ImportError on the lazy import: when 32-01's runner.py is on disk, we use the canonical class; when it isn't (this isolated worktree), we fall back to a local class with the same name and shape. Tests pass standalone in the worktree, and after the orchestrator merges both worktrees the canonical runner-defined `TopologyError` is the one users see. Documented inline in `topologies/__init__.py`.
- **Stub-then-replace pattern for ReedBore / ReedBorePostRadiation in Task 1** — The registry `__init__.py` imports all three topology classes at module load. So Task 1 can't ship a working `BoreOnly` without also importing `ReedBore` and `ReedBorePostRadiation`. Solution: minimal stubs in Task 1 (single-line `step()` returning 0.0, marked `# pragma: no cover - replaced in Task N`) so registry tests pass; Tasks 2 and 3 overwrite the stub files. This keeps each task atomically committable while satisfying the registry-import contract.
- **Body-formant biquad coefficients computed once in `__post_init__`** — The body formant is fixed by the model (always +6 dB @500 Hz, Q=3 — not user-tweakable per `bassoon.gendsp` comment "always on, not user-tweakable"). Computing coefficients at construction saves 5 trig calls per sample in the hot loop. Bell LPF and reed BPF coefficients still recompute per step because their fc/Q are swept Params.
- **Final attenuation `out * 0.25`** — Mirrors `bassoon.gendsp` line `out1 = rad_out * 0.25` directly. The codebox comment explains why: worst-case peaks ~7x (reed BPF Q up to 6 + body formant +6 dB + bore_return up to 1.7) need 12 dB of fixed headroom before the host gain.

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] Test FFT fundamental tracker locked onto wrong spectral peak**

- **Found during:** Task 3 (ReedBorePostRadiation `test_bell_bright_sweep_does_not_detune_fundamental`)
- **Issue:** The test's helper `_measure_fundamental_hz()` did a global `np.argmax` on the rfft magnitude spectrum. The bell LPF + reed BPF in the post-radiation chain emphasize high partials, so the loudest spectral peak sat near 14 kHz (in the bell pass-band) rather than the loop fundamental at 220 Hz. Cents-offset readings were ~7200 (i.e., the 6th partial), and the spread across the bell_bright sweep was 38 cents — but this was a measurement artifact, NOT a real fundamental drift. The post-loop placement was correct; the test was measuring the wrong thing.
- **Fix:** Added `target_hz` and `search_octaves` kwargs to `_measure_fundamental_hz()`. When `target_hz` is supplied (as it is in the v0.4.2+ test), the function searches only within `target_hz / 2^search_octaves` to `target_hz * 2^search_octaves` (default ±0.5 octave around 220 Hz, i.e., 156 Hz to 311 Hz). This isolates the bore loop's fundamental and verifies the actual D-11 invariant: post-loop bell biquad does not pull the loop oscillation off its target frequency.
- **Files modified:** `tests/dsp_sim/test_topologies.py` (added narrow-band search to helper; passed `target_hz=target_freq` in the bell_bright sweep test)
- **Verification:** Cents-offset spread across the 8-step bell_bright sweep dropped from 38.11 cents (false positive — high-partial wandering) to <5 cents (the real D-05 phase_drift threshold). Test passes.
- **Committed in:** 5c36cd9 (Task 3 commit; both the topology and the test fix are in the same commit because they are co-dependent — the test as originally written would never have validated the topology correctly)

---

**Total deviations:** 1 auto-fixed (1 bug)
**Impact on plan:** No scope change. The fix preserves the ORIGINAL test intent (D-11 invariant check) by sharpening the measurement to the loop fundamental band. Without it, the test would have falsely passed on a buggy topology and falsely failed on the correct one — defeating the entire purpose of the v0.4.2+ regression gate.

## Issues Encountered

**Worktree dependency on plan 32-01.** Plan 32-02 documents `from src.maxpat.dsp_sim.runner import TopologyError` in the lazy-import path used by `get_topology()`. Plan 32-01 (running in parallel in a separate worktree) creates that file. In this isolated worktree the runner.py does not exist, so a literal eager import would fail.

**Resolution:** Documented in plan's `<note_on_dependencies>` block. My `topologies/__init__.py` uses a try/except ImportError fallback that defines a local `TopologyError(Exception)` with the same shape if `runner.py` isn't on disk. Tests pass standalone; after the orchestrator merges both worktrees the canonical runner-defined class becomes the one in scope. No tests in this plan import from `src.maxpat.dsp_sim.runner` directly — they import `TopologyError` from `src.maxpat.dsp_sim.topologies` (which re-exports), so they work in both isolated and merged states.

**Pre-existing broader test failures observed.** A post-task smoke check on `pytest tests/ --ignore=tests/dsp_sim` showed 48 failures. None touch `src/maxpat/dsp_sim/` or `tests/dsp_sim/`. The failures pre-date Phase 32 (worktree base = 8e09c18, the "docs(32): create phase plan" commit). Categories: integration patch reviews, community package stubs, source-coverage extraction-log totals. Logged to `.planning/phases/32-dsp-pre-flight-simulation/deferred-items.md` per the SCOPE BOUNDARY rule. No action taken.

## User Setup Required

None — pure offline numpy code. `numpy 2.4` and `scipy 1.17` are already installed (verified at execution start).

## Plan-Level Verification Results

- `pytest tests/dsp_sim/test_topologies.py -v` -> **16 collected, 16 passed** in 0.20s (4 Registry + 3 BoreOnly + 4 ReedBore + 5 ReedBorePostRadiation).
- `python -c "from src.maxpat.dsp_sim.topologies import TOPOLOGIES; print(sorted(TOPOLOGIES))"` -> `['bore_only', 'reed_bore', 'reed_bore_post_radiation']` exactly matches the D-01 contract.
- The third verification step (`run_simulation(topology='reed_bore_post_radiation', ...)`) cannot run in this isolated worktree because plan 32-01's `runner.py` does not exist here. This is expected per the parallel-execution dependency note in my prompt — the post-merge test gate (orchestrator-side) will validate the runner+topology integration end-to-end.

## Next Phase Readiness

- **For 32-04 (regression fixtures):** `ReedBorePostRadiation` is the canonical PASSING shape; the v0.4.0 mirror (group-delay-compensation phase_drift) and v0.4.1 mirror (in-loop bell biquad mode_competition) compare against this baseline. The Param surface is locked.
- **For 32-03 (max-dsp-agent integration):** No direct dependency from 32-03 on 32-02; agent uses pytest as the gate, which works as long as `tests/dsp_sim/test_<stem>.py` exists.
- **For 32-05 (CLI):** The CLI will accept `--topology bore_only|reed_bore|reed_bore_post_radiation` directly from the registry exposed here.
- **No blockers.** Plan 32-01 (sibling Wave-1) is the only integration point; their `TopologyError` lands in `runner.py` which my `topologies/__init__.py` lazy-imports.

## Self-Check: PASSED

All 6 created files verified on disk. All 4 task commits verified in git log
(cb92b92, 782972b, e58874e, 5c36cd9). All 16 invariant tests in
`tests/dsp_sim/test_topologies.py` collect and pass. No claims in this
SUMMARY are unverified.

---
*Phase: 32-dsp-pre-flight-simulation*
*Completed: 2026-05-01*
