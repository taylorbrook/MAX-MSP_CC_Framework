---
phase: 32-dsp-pre-flight-simulation
reviewed: 2026-05-01T00:00:00Z
depth: standard
files_reviewed: 24
files_reviewed_list:
  - src/maxpat/dsp_sim/__init__.py
  - src/maxpat/dsp_sim/__main__.py
  - src/maxpat/dsp_sim/classifier.py
  - src/maxpat/dsp_sim/cli.py
  - src/maxpat/dsp_sim/measure.py
  - src/maxpat/dsp_sim/runner.py
  - src/maxpat/dsp_sim/topologies/__init__.py
  - src/maxpat/dsp_sim/topologies/bore_only.py
  - src/maxpat/dsp_sim/topologies/reed_bore.py
  - src/maxpat/dsp_sim/topologies/reed_bore_post_radiation.py
  - tests/dsp_sim/__init__.py
  - tests/dsp_sim/conftest.py
  - tests/dsp_sim/fixtures/__init__.py
  - tests/dsp_sim/fixtures/bassoon_v040_mirror.py
  - tests/dsp_sim/fixtures/bassoon_v041_mirror.py
  - tests/dsp_sim/test_bassoon-model.py
  - tests/dsp_sim/test_bassoon_v040_regression.py
  - tests/dsp_sim/test_bassoon_v041_regression.py
  - tests/dsp_sim/test_classifier.py
  - tests/dsp_sim/test_cli.py
  - tests/dsp_sim/test_measure.py
  - tests/dsp_sim/test_runner.py
  - tests/dsp_sim/test_topologies.py
  - tests/test_agent_skills.py
findings:
  critical: 0
  warning: 3
  info: 9
  total: 12
status: issues_found
---

# Phase 32: Code Review Report

**Reviewed:** 2026-05-01
**Depth:** standard
**Files Reviewed:** 24
**Status:** issues_found

## Summary

The DSP pre-flight simulator is well-structured with clear separation between
measurement primitives, classifier cascade, runner orchestration, curated
topologies, and a thin CLI. Threat-model commentary (T-01..T-04) is in place
and the importlib-only `_load_mirror` correctly avoids `eval`/`exec`.
Test coverage is thorough across the verdict cascade, mirror on-ramp,
exit-code mapping, regression mirrors (v0.4.0 phase_drift, v0.4.1 mode
competition), and the live v0.4.2+ pass case.

No security or correctness-critical issues were found. The warnings below
flag a NaN-RMS classifier blind spot, drift between CLI hard-coded defaults
and `ClassifierThresholds()` LOCKED defaults (D-05), and a documented-but
inconsistent "callable mirror" branch in `_render_step` that the public docs
do not advertise. The info items are mainly duplication and named-constant
suggestions that would tighten maintainability.

## Warnings

### WR-01: Classifier `no_oscillation` branch silently ignores NaN RMS

**File:** `src/maxpat/dsp_sim/classifier.py:103-110`
**Issue:** The runaway check (D-09 priority 1) inspects `peak_amplitude` for
`isfinite()` and threshold-overshoot. The `no_oscillation` check then uses
`m.rms_amplitude < thresholds.amplitude_floor`. If `rms_amplitude` is NaN
but `peak_amplitude` happens to be finite (e.g. a future measurement-primitive
change, a third-party mirror that returns NaN selectively, or a buffer
where DC subtraction produces NaN through fp pathology), the
`NaN < x` comparison returns `False`, so `no_oscillation` is silently
skipped. Today `measure_rms`/`measure_peak` both return NaN together (any
non-finite sample collapses both), so the runaway branch front-stops the
case — but the cascade itself doesn't defend against that invariant
breaking.

**Fix:**
```python
# classifier.py priority 1: also short-circuit on NaN rms_amplitude.
for i, m in enumerate(measurements):
    if (not math.isfinite(m.peak_amplitude)
            or not math.isfinite(m.rms_amplitude)
            or m.peak_amplitude > thresholds.runaway_amplitude):
        ...
```
Or symmetrically: in the no_oscillation branch, treat NaN RMS as "below
floor" by checking `not math.isfinite(m.rms_amplitude) or m.rms_amplitude < ...`.

---

### WR-02: CLI threshold defaults drift from `ClassifierThresholds()` D-05 baseline

**File:** `src/maxpat/dsp_sim/cli.py:121-144`
**Issue:** The CLI hard-codes `default=5.0`, `default=50.0`, `default=1e-4`,
`default=10.0`, `default=44100`, `default=100` for the threshold and
sample-rate flags. These mirror `ClassifierThresholds()` LOCKED defaults
in `measure.py`, but if `measure.py` is ever revised, the CLI will silently
diverge. `tests/dsp_sim/test_measure.py::TestClassifierThresholdsDefaults`
asserts the dataclass defaults, but no test asserts CLI parity.

**Fix:**
```python
# cli.py — pull defaults from the single source of truth.
from src.maxpat.dsp_sim.measure import ClassifierThresholds
_T = ClassifierThresholds()
parser.add_argument("--cents-drift-limit", type=float, default=_T.cents_drift_limit, ...)
parser.add_argument("--mode-competition-jump", type=float, default=_T.mode_competition_jump, ...)
parser.add_argument("--amplitude-floor", type=float, default=_T.amplitude_floor, ...)
parser.add_argument("--runaway-amplitude", type=float, default=_T.runaway_amplitude, ...)
parser.add_argument("--sample-rate", type=int, default=_T.sample_rate, ...)
parser.add_argument("--settle-ms", type=int, default=_T.settle_ms, ...)
```
Same applies to the per-kwarg defaults on `run_simulation(...)` in
`runner.py:193-196` — they duplicate the dataclass and could be sourced from
`ClassifierThresholds()` as the single source of truth.

---

### WR-03: `_render_step` callable-mirror branch is undocumented in the public surface

**File:** `src/maxpat/dsp_sim/runner.py:131-154`
**Issue:** `_render_step` supports two stepper protocols: a `.step(in1, in2)`
object (used by topologies and all in-tree mirrors), or a bare callable
`stepper(n_samples, params) -> ndarray` (the `else` branch, line 154).
The public docstrings on `run_simulation` and the `mirror=` kwarg only
describe the `.step(...)` form (`runner.py:209` says
`"Callable (sample_rate, params) -> stepper"`). The "factory returns a
callable that itself takes (n_samples, params)" form isn't tested anywhere
and isn't documented in `__init__.py` either. A future reader using the
intended `.step(...)` protocol could accidentally name their stepper
`__call__` and silently take the wrong branch.

**Fix:** Either remove the dead branch (no test exercises it; no in-tree
caller uses it) or document and test it as a first-class supported shape:
```python
# runner.py — option 1, remove the undocumented form:
def _render_step(stepper, n_samples, params):
    in1 = float(params.get("freq", 220.0))
    in2 = float(params.get("breath", 0.6))
    out = np.zeros(n_samples, dtype=np.float64)
    for i in range(n_samples):
        out[i] = stepper.step(in1, in2)
    return out

# Option 2, document and add a test case for vectorised mirrors.
```
If the vectorised form is intended (the docstring at line 154 implies it),
add a `tests/dsp_sim/test_runner.py::TestRunSimulationSweep::test_callable_mirror_form`
case using a stub that returns a numpy buffer directly.

## Info

### IN-01: `_BORE_BUFFER_SIZE = 8192` is duplicated across 5 files

**File:** `src/maxpat/dsp_sim/topologies/bore_only.py:26`,
`src/maxpat/dsp_sim/topologies/reed_bore.py:30`,
`src/maxpat/dsp_sim/topologies/reed_bore_post_radiation.py:34`,
`tests/dsp_sim/fixtures/bassoon_v040_mirror.py:27`,
`tests/dsp_sim/fixtures/bassoon_v041_mirror.py:25`
**Issue:** Each topology and regression mirror declares its own
`_BORE_BUFFER_SIZE = 8192` constant. Changing the buffer size requires
five coordinated edits.
**Fix:** Promote to `src/maxpat/dsp_sim/topologies/__init__.py` (or a
small `topologies/_constants.py`):
```python
# topologies/_constants.py
BORE_BUFFER_SIZE = 8192
```
Mirrors live in `tests/dsp_sim/fixtures/`, so they can import from
`src.maxpat.dsp_sim.topologies` without circularity.

---

### IN-02: Magic numbers throughout `reed_bore_post_radiation.py`

**File:** `src/maxpat/dsp_sim/topologies/reed_bore_post_radiation.py:84-103,180,205,230,231`
**Issue:** Numeric constants for body-formant geometry (`bf_freq=500.0`,
`bf_gain_db=6.0`, `bf_q=3.0`), bell-frequency mapping (`800.0`, `5000.0`),
reed-Q clamp (`0.1`), final mix (`0.7 * bell_out + 0.3 * reed_out`), and
output attenuation (`* 0.25`) are inline rather than named constants.
The comments cite the bassoon.gendsp values inline, which is enough for
review but not for maintenance.
**Fix:** Extract to module-level named constants with provenance comments:
```python
_BODY_FORMANT_FREQ_HZ = 500.0
_BODY_FORMANT_GAIN_DB = 6.0
_BODY_FORMANT_Q = 3.0
_BELL_FREQ_MIN_HZ = 800.0
_BELL_FREQ_SWEEP_HZ = 5000.0
_REED_Q_FLOOR = 0.1
_REED_BPF_BLEND = 0.3        # reed_out share in final mix
_FINAL_OUTPUT_ATTENUATION = 0.25  # matches bassoon.gendsp out1 = rad_out * 0.25
```

---

### IN-03: `reed_res_q` clamp comment is at the read site, not the clamp site

**File:** `src/maxpat/dsp_sim/topologies/reed_bore_post_radiation.py:116-117`
**Issue:** The comment "T-04: reed_res_q clamped >= 0.1 to avoid biquad
coefficient blowup" sits above the param read on line 117, but the
actual clamp (`rrq = max(0.1, reed_res_q)`) doesn't happen until line 205.
A reader scanning for "where is this clamped?" lands at the comment but
not at the clamp.
**Fix:** Move the comment to the clamp site (line 204), or perform the
clamp at read time:
```python
# Read-and-clamp form keeps the invariant local:
reed_res_q = max(0.1, float(self.params.get("reed_res_q", 0.7071068)))  # T-04
```

---

### IN-04: Unused import `numpy as np` in `tests/dsp_sim/test_runner.py`

**File:** `tests/dsp_sim/test_runner.py:17`
**Issue:** `import numpy as np` has no usages in the file (the stub
mirrors return Python floats; runner-internal `np.zeros` is not visible
to tests).
**Fix:** Remove the line.

---

### IN-05: Unused import `math` in `tests/dsp_sim/test_classifier.py`

**File:** `tests/dsp_sim/test_classifier.py:17`
**Issue:** `import math` is never referenced; tests use `make_step()` and
`pytest` only.
**Fix:** Remove the line.

---

### IN-06: `classify([])` returns `PASS` for an empty input

**File:** `src/maxpat/dsp_sim/classifier.py:88-89`
**Issue:** `if not measurements: return (PASS, None, "no measurements", None)`.
"No measurements" is more accurately a degenerate / "could not run" state
than an explicit pass. Today this is unreachable from `run_simulation`
(which raises `TopologyError` on `n < 2`), but if a future caller passes
an empty list directly, it'll silently look like the patch passed.
**Fix:** Either raise (preferred — match the runner contract):
```python
if not measurements:
    raise ValueError("classify() requires at least one StepMeasurement")
```
Or return a distinct sentinel (`"no_data"`) so a downstream `verdict ==
PASS` check is unambiguous.

---

### IN-07: `_BassoonV040Mirror` is missing the allpass fractional-delay stage

**File:** `tests/dsp_sim/fixtures/bassoon_v040_mirror.py:91-93`
**Issue:** The mirror reads `delayed = self._buffer[ri]` and feeds that
straight into the bore onepole, omitting the allpass fractional-delay
interpolator that `reed_bore_post_radiation.py` uses (and that the live
v0.4.0 patch presumably also used). The header docstring focuses on the
group-delay-vs-phase-delay regression, so this is intentional ("targets
the failure mechanism, not bit-exact reproduction" per CONTEXT.md D-11),
but a reader comparing the canonical topology to the regression mirror
will notice the omission. Worth a single line of commentary.
**Fix:** Add a one-liner to the docstring:
```python
"""...
Note: this mirror omits the allpass fractional-delay interpolator on
purpose — the regression isolates the group-delay compensation bug, and
adding the allpass would complicate phase analysis without changing the
verdict (D-11: failure-mechanism focus, not bit-exact mirror).
"""
```

---

### IN-08: Topology `TopologyError` fallback can desynchronise from runner's class

**File:** `src/maxpat/dsp_sim/topologies/__init__.py:34-38`
**Issue:** If the runner import fails (e.g. during isolated worktree
execution per the comment), `topologies/__init__.py` defines its own
`TopologyError(Exception)`. Code that catches `runner.TopologyError`
upstream would not catch this fallback class, and vice versa. The fallback
is documented as transitional, but in production both modules ship
together and the import always succeeds, so the fallback is effectively
dead code today.
**Fix:** After phase 32 ships and 32-01/32-02 are merged, either remove
the fallback or move `TopologyError` into a small shared module
(`src/maxpat/dsp_sim/_errors.py`) that both `runner.py` and
`topologies/__init__.py` import. Remove the now-redundant try/except.

---

### IN-09: `_sparkline` re-checks NaN/Inf inside the loop after building `finite`

**File:** `src/maxpat/dsp_sim/cli.py:254-275`
**Issue:** Lines 254-258 already build `finite` by filtering NaN/Inf; the
inner loop at 263-269 then re-tests each value for NaN and `±inf`. This
is correct (the loop handles the original values, not the filtered list,
to preserve index-aligned characters), just slightly wordier than needed.
**Fix:** Use `math.isfinite()` once instead of three explicit comparisons:
```python
import math  # already available; CLI doesn't import it yet
...
for v in values:
    if not math.isfinite(v):
        chars.append("?")
        continue
    if span <= 1e-12:
        chars.append(_SPARK_CHARS[0])
        continue
    idx = int((v - lo) / span * (len(_SPARK_CHARS) - 1))
    chars.append(_SPARK_CHARS[max(0, min(len(_SPARK_CHARS) - 1, idx))])
```

---

_Reviewed: 2026-05-01_
_Reviewer: Claude (gsd-code-reviewer)_
_Depth: standard_
