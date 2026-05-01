# Phase 32 — Pattern Mapping

**Generated:** 2026-05-01
**Purpose:** Map every new/modified Phase 32 file to its closest existing analog so the planner can mimic project conventions verbatim.

---

## src/maxpat/dsp_sim/

### `src/maxpat/dsp_sim/__init__.py` — NEW

**Closest analog:** `src/maxpat/critics/__init__.py` (sibling-of-`critics`-style multi-file submodule with public re-exports + `__all__`)

**Excerpt to mimic:**
```python
"""Critic system -- semantic/architectural review of generated patches.

Provides review_patch() which combines DSP, structure, layout, RNBO,
package, and external critics to catch design problems that the mechanical
validation pipeline does not detect.

Usage:
    from src.maxpat.critics import review_patch, CriticResult

    results = review_patch(patch_dict)
    for r in results:
        print(r)  # [severity] finding
"""

from __future__ import annotations

from src.maxpat.critics.base import CriticResult
from src.maxpat.critics.dsp_critic import review_dsp
# ...

__all__ = [
    "review_patch",
    "review_dsp",
    "CriticResult",
]
```

**Notes:** Re-export the public surface listed in CONTEXT.md D-01: `run_simulation`, `SimulationReport`, `StepMeasurement`, `TopologyError`, and the four failure-mode literal constants (`PHASE_DRIFT`, `MODE_COMPETITION`, `NO_OSCILLATION`, `RUNAWAY` — or expose them as a `Verdict` enum/`Literal` alias). Keep `from __future__ import annotations` and the `__all__` list (used by every module in this codebase). Module docstring should mirror the "Usage:" example block style above.

---

### `src/maxpat/dsp_sim/runner.py` — NEW

**Closest analog:** `src/maxpat/critics/dsp_critic.py` (orchestrator + structured-result return shape) combined with `src/maxpat/audit/cli.py::main` (multi-phase pipeline body).

**Excerpt to mimic (orchestrator entrypoint shape, from `dsp_critic.py`):**
```python
"""DSP critic -- checks signal flow, gen~ I/O matching, and gain staging.

Catches semantic DSP issues that the mechanical validation pipeline does
not detect:
  ...
"""

from __future__ import annotations

import re
from collections import deque

from src.maxpat.critics.base import CriticResult
from src.maxpat.codegen import parse_genexpr_io
from src.maxpat.utils import get_box_name


def review_dsp(
    patch_dict: dict,
    code_context: dict | None = None,
) -> list[CriticResult]:
    """Review DSP aspects of a patch.

    Args:
        patch_dict: A .maxpat-format dict.
        code_context: Optional dict with gen~ code strings keyed by box id.

    Returns:
        List of CriticResult findings.
    """
    results: list[CriticResult] = []
    # ... pipeline body
    results.extend(_check_gen_io_match(box_lookup, code_context))
    results.extend(_check_gain_staging(box_lookup, lines))
    return results
```

**Notes:**
- `run_simulation(...)` follows the same docstring shape (Args / Returns).
- Keep all helper checks as `_underscored` module-level functions (matches `_check_gen_io_match`, `_check_gain_staging`). Phase 32 helpers: `_simulate_sweep`, `_render_step`, `_resolve_topology`, etc.
- The pipeline body mirrors `audit/cli.py::main`'s "---- Parse phase ----", "---- Analyze phase ----" comment-banner style — use the same `# ----` separators between simulate / measure / classify phases.
- Return a single `SimulationReport` (NOT a list of findings) — D-03's structured shape is closer to `BuildResult` (`ext_validation.py`) than `list[CriticResult]`.

**Excerpt to mimic for `SimulationReport` (from `ext_validation.py::BuildResult`):**
```python
from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path


@dataclass
class BuildResult:
    """Result of an external build attempt.

    Attributes:
        success: Whether the build produced a valid .mxo.
        mxo_path: Path to the .mxo bundle if successful, None otherwise.
        errors: List of compiler error messages if failed.
        attempts: How many build attempts were made.
        message: Human-readable summary of the outcome.
    """

    success: bool
    mxo_path: Path | None
    errors: list[str]
    attempts: int
    message: str
```

**Notes for `SimulationReport`:**
- `@dataclass` with field-level docstrings under each attribute (matches `audit/__init__.py::BoxInstance` which uses inline `"""..."""` per-field docstrings — copy that style if any field needs explanation).
- Fields per CONTEXT.md D-03: `verdict: Literal['pass', 'mode_competition', 'phase_drift', 'no_oscillation', 'runaway']`, `measurements: list[StepMeasurement]`, `worst_step: int | None`, `reason: str`, `suggested_fix: str | None`.
- `StepMeasurement` is a second `@dataclass` in the same file (or `measure.py`).

**Excerpt to mimic for `TopologyError` (exception class, from `hooks.py`):**
```python
class PatchGenerationError(Exception):
    """Raised when unfixable structural errors prevent patch generation."""


class PatchValidationError(Exception):
    """Raised when validation finds blocking errors that prevent file write."""
```

**Notes:** `TopologyError(Exception)` with a single-line docstring — same shape. Raise on unknown topology name and on `mirror=` + `topology=` both supplied (mutually exclusive per D-01).

---

### `src/maxpat/dsp_sim/measure.py` — NEW

**Closest analog:** `src/maxpat/audit/analyzer.py` (computational helpers + per-input "measurement" shape).

**Excerpt to mimic:**
```python
"""Audit analysis engine for comparing help patch data against the object database.

Compares parser-extracted help patch data against the ObjectDatabase across
5 dimensions: outlet types, I/O counts, box widths, argument formats, and
connection patterns. Produces per-object findings with confidence scores.
"""

from __future__ import annotations

import statistics
from collections import Counter, defaultdict
from dataclasses import dataclass, field
from typing import Any, Callable

from src.maxpat.audit import BoxInstance


def classify_outlet_type(help_type: str) -> tuple[bool, str]:
    """Map a help patch outlettype string to signal/control classification.

    ...

    Args:
        help_type: The outlet type string from a help patch's outlettype array.

    Returns:
        Tuple of (is_signal, normalized_label).
    """
    if help_type in SIGNAL_TYPES:
        return (True, help_type)
    return (False, "")
```

**Notes:**
- Free functions named `measure_fundamental(buf, sample_rate) -> float`, `measure_rms(buf) -> float`, `measure_peak(buf) -> float`. Match the snake_case + tuple-or-scalar return style of `classify_outlet_type` / `compute_confidence`.
- Use `numpy as np` and `scipy.signal` (CONTEXT.md confirms both already installed). Autocorrelation: `scipy.signal.correlate(buf, buf, mode='full')`. FFT fundamental: `np.fft.rfft(buf)` + parabolic interpolation OR `scipy.signal.welch(buf, fs=sample_rate)`.
- `StepMeasurement` dataclass lives here (same file as the measurement primitives) OR in `runner.py` next to `SimulationReport`. Either is consistent — `audit/analyzer.py` defines `Finding` next to its analyzer functions.
- Module-level constants UPPER_SNAKE (`SIGNAL_TYPES = {...}` is the convention).

---

### `src/maxpat/dsp_sim/classifier.py` — NEW

**Closest analog:** `scripts/audit_signal_role.py::_classify_digest` (single classifier function returning a verdict + confidence + rationale tuple, with priority-ordered branches).

**Excerpt to mimic:**
```python
def _classify_digest(
    object_name: str,
    outlet_id: int,
    digest: str,
    signal: bool,
) -> tuple[str | None, str, str]:
    """Classify a single outlet into (role, confidence, rationale).

    Per CONTEXT.md D-04 (signal:true wins), D-05 LOCKED synonym set
    (data={parameter,index,count,position}; ...), D-08 (three-tier confidence:
    high/medium/low).

    Returns (None, "low", "no_match") for unmatchable digests; curator
    must fill curator_role in SIGNAL-ROLE-REVIEW.md before --apply.
    """
    # D-04: signal:true ALWAYS classifies as audio, ignoring digest text.
    if signal is True:
        return ("audio", "high", "signal_true")

    tokens = {t.lower() for t in _TOKEN_RE.findall(digest or "")}

    # D-05: strict trigger/status (high confidence — auto-apply).
    if tokens & _TRIGGER_KEYWORDS:
        return ("trigger", "high", "trigger_keyword")
    if tokens & _STATUS_KEYWORDS:
        return ("status", "high", "status_keyword")
    # ...

    # D-08: low — curator must fill curator_role.
    return (None, "low", "no_match")
```

**Notes:**
- Public function: `classify(measurements: list[StepMeasurement], thresholds: ClassifierThresholds) -> tuple[str, int | None, str, str | None]` returning `(verdict, worst_step, reason, suggested_fix)`. The verdict-priority cascade matches D-09: `runaway` > `no_oscillation` > `mode_competition` > `phase_drift` > `pass`.
- Module-level `_FROZENSET` constants for the suggested-fix table (lift wording verbatim from `feedback_waveguide_loop_phase_comp.md` per D-03).
- Threshold knobs as a small `@dataclass(frozen=True)` `ClassifierThresholds` with the D-05 defaults (`cents_drift_limit=5.0`, `mode_competition_jump=50.0`, `amplitude_floor=1e-4`, `runaway_amplitude=10.0`). Mirrors how `LayoutOptions` (`defaults.py`) packages tunables.
- Comment-cite each branch with the decision id (`# D-09: priority order ...`) — matches `audit_signal_role.py`'s heavy `# Per CONTEXT.md D-NN` annotation style.

---

### `src/maxpat/dsp_sim/topologies/__init__.py` — NEW

**Closest analog:** `src/maxpat/audit/__init__.py` (small subpackage init that defines a shared dataclass + lazily imports the CLI).

**Excerpt to mimic:**
```python
"""Help patch audit package.

Provides tools for parsing MAX/MSP help patches (.maxhelp files), extracting
object instance metadata, ...
"""

from dataclasses import dataclass, field


@dataclass
class BoxInstance:
    """A single object instance extracted from a help patch.

    Represents one newobj box found during recursive traversal of a .maxhelp
    file's patcher hierarchy.
    """

    name: str
    """Object name (first token of text, e.g., 'cycle~')."""

    text: str
    """Full object text (e.g., 'cycle~ 440')."""
    # ...


try:
    from .cli import main as run_audit
except ImportError:
    pass
```

**Notes:**
- This `__init__.py` exposes the topology registry. Per CONTEXT.md D-08 the registry is a simple `dict[str, type]` (e.g., `TOPOLOGIES = {"bore_only": BoreOnly, "reed_bore": ReedBore, "reed_bore_post_radiation": ReedBorePostRadiation}`).
- Plus a `get_topology(name) -> type` helper that raises `TopologyError` on miss.
- The `try/except ImportError` lazy-import pattern is NOT needed here (no circular risk).
- Keep field-level docstrings if a shared `TopologyParams` dataclass lives here.

---

### `src/maxpat/dsp_sim/topologies/bore_only.py` — NEW

**Closest analog:** `src/maxpat/codegen.py::generate_gendsp` for free-function shape; `src/maxpat/audit/parser.py::HelpPatchParser` for class-with-state shape. Topology classes need internal state (delay buffers, filter histories) per CONTEXT.md "Claude's Discretion" → use a class.

**Excerpt to mimic (class shape from analyzer.py):**
```python
@dataclass
class Finding:
    """A discrepancy found between help patch instances and DB.

    Attributes:
        object_name: Name of the object with the discrepancy.
        dimension: Which audit dimension flagged it
            (outlet_types, widths, empty_io, connections, arguments).
        confidence: HIGH / MEDIUM / LOW / CONFLICT / NONE.
        details: Dimension-specific data (varies by check).
    """

    object_name: str
    dimension: str
    confidence: str
    details: dict
```

**Excerpt to mimic for the topology class itself (use the bassoon.gendsp structure as a guide — translate Gen~ History/Delay → numpy state):**
```python
"""Bore-only waveguide topology.

Models a passive bore waveguide (delay line + onepole damping + reflection)
without an active reed. Used for unit-testing the simulator harness on a
known-stable structure.

Mirrors the bore loop from patches/bassoon-model/generated/bassoon.gendsp:
  - Data bore(8192)             -> numpy circular buffer
  - History bore_lp(0)          -> scalar state
  - History ap_x_prev/ap_y_prev -> allpass interpolation state
  - cone_loss = 0.85            -> per-roundtrip attenuation
"""

from __future__ import annotations

from dataclasses import dataclass, field

import numpy as np


@dataclass
class BoreOnly:
    """Passive bore waveguide. step(in1, in2) -> output sample."""

    sample_rate: float
    params: dict[str, float]
    _buffer: np.ndarray = field(init=False)
    _wi: int = field(init=False, default=0)
    _bore_lp: float = field(init=False, default=0.0)
    # ...

    def __post_init__(self) -> None:
        self._buffer = np.zeros(8192, dtype=np.float64)

    def step(self, in1: float, in2: float) -> float:
        # ... per-sample numpy math mirroring bassoon.gendsp loop body
        ...
```

**Notes:**
- Convention from CLAUDE.md "Gen~ → numpy" mapping (cited in CONTEXT.md `<canonical_refs>`):
  - `Data bore(8192)` → `np.zeros(8192)` circular buffer; track `_wi` (write index) as `int`.
  - `History x` → scalar attribute prefixed `_` with `field(init=False, default=0.0)`.
  - `Delay.read/write` → indexed numpy reads with mod-arithmetic on the buffer.
- `step(in1, in2)` is the canonical per-sample API (matches GenExpr `in1`, `in2`, `out1` convention from the `.gendsp`).
- File header docstring MUST cite the `.gendsp` it mirrors and the relevant CLAUDE.md rules (matches the heavy provenance commenting in `bassoon.gendsp` itself and in `audit_signal_role.py`).

---

### `src/maxpat/dsp_sim/topologies/reed_bore.py` — NEW

**Closest analog:** Same as `bore_only.py`. Class extends bore loop with the rectified McIntyre-Woodhouse reed model (lines around `// Reed model -- rectified pressure-flow (closed-form)` in `bassoon.gendsp`).

**Excerpt to mimic (from `bassoon.gendsp` reed block, transcribed to numpy):**
```python
def step(self, in1: float, in2: float) -> float:
    # in1 = freq Hz, in2 = breath pressure 0..1
    breath = self._smooth_breath(in2)
    cone_return = self._read_bore()  # bore reflection
    delta_p = max(0.0, min(1.0, breath - cone_return + self.params["reed_aper"]))
    reed_ratio = delta_p * (1.0 / 0.85)
    reed_opening = max(0.0, 1.0 - reed_ratio * reed_ratio)
    reed_flow = delta_p * (reed_opening ** 0.5)
    stiff_gain = 0.75 - self.params["reed_stiff"] * 0.45
    reed_sig = reed_flow * stiff_gain
    self._inject_bore(reed_sig + cone_return)
    return reed_sig + cone_return  # bore_only excitation, no radiation
```

**Notes:** Topology mirrors v0.3.x (pre-bell-biquad) bassoon. Loop closure + onepole bore damping with phase-delay compensation per `feedback_waveguide_loop_phase_comp.md`. No body formant, no bell biquad, no reed BPF — those live in `reed_bore_post_radiation.py`.

---

### `src/maxpat/dsp_sim/topologies/reed_bore_post_radiation.py` — NEW

**Closest analog:** Same class shape as `reed_bore.py`. **This is the canonical bassoon v0.4.2+ shape** — every block from `patches/bassoon-model/generated/bassoon.gendsp` lines ~150–end belongs here.

**Excerpt to mimic (radiation chain from `bassoon.gendsp`):**
```python
# Stage 1: body formant peaking EQ (fixed +6 dB @500 Hz, Q=3)
bf_out = (
    self._bf_b0 * rad_in
    + self._bf_b1 * self._bf_x1
    + self._bf_b2 * self._bf_x2
    - self._bf_a1 * self._bf_y1
    - self._bf_a2 * self._bf_y2
)
self._bf_x2 = self._bf_x1
self._bf_x1 = rad_in
self._bf_y2 = self._bf_y1
self._bf_y1 = bf_out

# Stage 2: bell radiation LPF (variable cutoff)
rad_out = (
    self._b0 * bf_out
    + self._b1 * self._bell_x1
    # ...
)
# ...
out1 = rad_out * 0.25
```

**Notes:**
- Param list comes from the live `.gendsp` (verbatim Param names: `reed_stiff`, `reed_aper`, `bell_bright`, `bore_damp`, `reed_res_freq`, `reed_res_q`, `register`, etc.). The fixture/test harness passes these as `params: dict[str, float]`.
- Bell biquad is **post-loop** (the v0.4.2 fix). Reed BPF is **post-loop** (v0.5.1 fix). D4 phase-delay compensation uses bore_damp onepole only (no bell biquad term — matches v0.4.2+).
- Header docstring should explicitly note "v0.4.2+ shape; the v0.4.0 group-delay regression and v0.4.1 in-loop biquad regression are reproduced via mirrors in `tests/dsp_sim/fixtures/`."

---

### `src/maxpat/dsp_sim/cli.py` — NEW

**Closest analog:** `scripts/audit_signal_role.py` (argparse + subcommand-free shape, exit-code conventions, `__main__` block). Use this rather than `audit/cli.py` because it's a single-file script-style CLI without subcommands, matching D-08 ("single-fixture manual reproduction").

**Excerpt to mimic:**
```python
#!/usr/bin/env python3
"""Audit signal_role coverage across MSP and MC tilde domains.
...
"""

from __future__ import annotations

import argparse
import json
import re as _re
import sys
from pathlib import Path

# Ensure project root on path when invoked as `python scripts/audit_signal_role.py`
_PROJECT_ROOT = Path(__file__).resolve().parents[1]
if str(_PROJECT_ROOT) not in sys.path:
    sys.path.insert(0, str(_PROJECT_ROOT))

from src.maxpat.db_lookup import ObjectDatabase  # noqa: E402

# ... commands ...


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="audit_signal_role",
        description=(
            "Audit signal_role coverage across MSP/MC tilde domains. "
        ),
    )
    sub = parser.add_subparsers(dest="cmd")
    audit = sub.add_parser("audit", help="Report current coverage (default)")
    audit.add_argument(
        "--threshold",
        type=int,
        default=20,
        help="Per-domain gap_count threshold (D-10 locks default at 20).",
    )
    audit.set_defaults(func=cmd_audit)
    return parser


def main(argv: list[str] | None = None) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)
    if not hasattr(args, "func"):
        args = parser.parse_args(["audit"])
    return args.func(args)


if __name__ == "__main__":
    raise SystemExit(main())
```

**Notes:**
- Per CONTEXT.md D-08: NO subcommands (single manual-reproduction entrypoint). So the parser is simpler than `audit_signal_role.py` — drop `subparsers` and put flags on the top-level parser.
- Required flags: `--patch`, `--topology`, `--param`, `--sweep "lo,hi,n"`. Optional: `--mirror module:func`, `--params "k=v,k=v"`, threshold overrides (`--cents-drift-limit`, etc.), `--sample-rate`, `--settle-ms`.
- Exit codes per CONTEXT.md `<specifics>` table: `0=pass, 1=phase_drift, 2=mode_competition, 3=no_oscillation, 4=runaway` (matches D-09 priority).
- Output: classification verdict line, per-step measurement table, ASCII sparkline of `cents_offset` (Unicode block chars `▁▂▃▄▅▆▇█` per D's planner-discretion note), `suggested_fix` line on failure.
- `main(argv: list[str] | None = None) -> int` signature MUST match `audit_signal_role.py::main` (the `__main__.py` will call `from .cli import main; raise SystemExit(main())`).
- Drop the `_PROJECT_ROOT` sys.path hack (the module is invoked via `python -m src.maxpat.dsp_sim`, not as a loose script).

---

### `src/maxpat/dsp_sim/__main__.py` — NEW

**Closest analog:** No existing `__main__.py` in this codebase. Use Python's standard idiom; the CLI's `__name__ == "__main__"` block in `audit_signal_role.py` is the closest stylistic anchor.

**Excerpt to write:**
```python
"""Entry point for `python -m src.maxpat.dsp_sim`."""

from src.maxpat.dsp_sim.cli import main


if __name__ == "__main__":
    raise SystemExit(main())
```

**Notes:** Three-line module is canonical. Note `raise SystemExit(main())` (not `sys.exit(main())`) — matches the `audit_signal_role.py` ending.

---

## tests/dsp_sim/

### `tests/dsp_sim/__init__.py` — NEW

**Closest analog:** `tests/__init__.py` (minimal package marker).

**Excerpt:** Empty file (or one-line docstring). Most existing test packages in this repo use empty `__init__.py`.

**Notes:** No re-exports needed.

---

### `tests/dsp_sim/conftest.py` — NEW (Claude's discretion per D-08)

**Closest analog:** `tests/conftest.py` (session-scoped pytest fixtures, project-root path pattern).

**Excerpt to mimic:**
```python
"""Shared test fixtures for MAX object knowledge base tests."""

import json
from pathlib import Path
from typing import Callable

import pytest

DB_ROOT = Path(__file__).resolve().parent.parent / ".claude" / "max-objects"


@pytest.fixture(scope="session")
def db_root() -> Path:
    """Return path to the .claude/max-objects/ root directory."""
    return DB_ROOT


@pytest.fixture(scope="session")
def all_objects(db_root: Path) -> list[dict]:
    """Load all domain JSON files into a flat list of object dicts."""
    objects = []
    # ...
    return objects
```

**Notes for `tests/dsp_sim/conftest.py`:**
- Module-level constants for `SAMPLE_RATE = 44100` and the canonical `BELL_BRIGHT_SWEEP = (0.0, 1.0, 32)`.
- Session-scoped fixtures: `default_params() -> dict[str, float]` returning the bassoon-typical Param dict (`freq=220.0, breath=0.6, bore_damp=0.3, bell_bright=0.5, reed_stiff=0.5, ...`).
- Optional: `default_thresholds() -> ClassifierThresholds` — though tests can also rely on `run_simulation`'s defaults (D-05).

---

### `tests/dsp_sim/README.md` — NEW

**Closest analog:** No existing per-test-directory README. The closest convention is `.claude/max-objects/PACKAGES.md` (technical reference doc for an internal subsystem) and `.planning/phases/<phase>/*.md` files (per-feature documentation in the planning tree).

**Notes:** Plain markdown. Sections per CONTEXT.md `<domain>`:
1. Topology catalogue: `bore_only`, `reed_bore`, `reed_bore_post_radiation` — one paragraph each describing the underlying physical model and which Param names it accepts.
2. Four failure modes: `runaway`, `no_oscillation`, `mode_competition`, `phase_drift` — verdict priority, threshold knob, suggested-fix lifted from `feedback_waveguide_loop_phase_comp.md`.
3. Threshold knobs table (mirror the D-05 table in CONTEXT.md `<specifics>`).
4. Filename convention: "`tests/dsp_sim/test_<patch_stem>.py`" — D-07.

This is project-internal docs, not user-facing — keep it terse and engineer-aimed.

---

### `tests/dsp_sim/test_classifier.py` — NEW

**Closest analog:** `tests/test_critics.py` class structure (small fixture builders + `class TestX:` containers).

**Excerpt to mimic:**
```python
"""Tests for the critic system -- DSP, structure, RNBO, and external critics.

Critics perform semantic/architectural review of generated patches,
catching design problems (missing gain staging, gen~ I/O mismatches,
fan-out without trigger, RNBO param issues, external code issues) that
the mechanical validation pipeline does not detect.
"""

from __future__ import annotations

import pytest

from src.maxpat.critics.base import CriticResult
from src.maxpat.critics.dsp_critic import review_dsp


# ===========================================================================
# Fixtures: Patch dicts for DSP critic tests
# ===========================================================================

def _make_patch(boxes: list[dict], lines: list[dict]) -> dict:
    """Helper to build a minimal patch_dict."""
    return {
        "patcher": {
            "boxes": [{"box": b} for b in boxes],
            "lines": [{"patchline": pl} for pl in lines],
        }
    }


# ===========================================================================
# DSP Critic tests
# ===========================================================================

class TestDSPCritic:
    """Test the DSP critic checks."""

    def test_gen_input_mismatch_detected(self):
        """gen~ with fewer inlets than codebox inputs -> blocker."""
        patch, code_ctx = _gen_io_mismatch_patch()
        results = review_dsp(patch, code_context=code_ctx)
        blockers = [r for r in results if r.severity == "blocker"]
        assert len(blockers) >= 1
        assert any("input" in r.finding.lower() or "inlet" in r.finding.lower() for r in blockers)
```

**Notes:**
- One `class TestClassifier:` with one method per failure mode (`test_runaway_detected_on_nan`, `test_no_oscillation_below_floor`, `test_phase_drift_over_5_cents`, `test_mode_competition_50_cents_jump`, `test_pass_when_clean`).
- Build synthetic `list[StepMeasurement]` directly in each test (no real numpy simulation needed for classifier-only unit tests).
- Use module-level `_make_step(...)` helper (matches `_make_patch` style).
- `===` banner-comment separators between fixture and test sections (75 `=` chars — exact convention from `test_critics.py`).
- One-line method docstrings explaining the expected verdict.

---

### `tests/dsp_sim/test_topologies.py` — NEW

**Closest analog:** Same as `test_classifier.py` (`tests/test_critics.py`).

**Notes:**
- One `class TestBoreOnly:`, `class TestReedBore:`, `class TestReedBorePostRadiation:` per topology.
- Each tests basic invariants: `step()` returns finite floats, `step(0, 0)` returns ~0 after settle, `step(in1=220.0, in2=0.6)` produces non-zero RMS within 100ms (oscillation onset).
- Param-keying parity test: `BoreOnly(params={"bore_damp": 0.3})` accepts the same Param names as `bassoon.gendsp` declares.

---

### `tests/dsp_sim/test_runner.py` — NEW

**Closest analog:** `tests/test_audit_cli.py` for end-to-end orchestrator-shape tests; `tests/test_critics.py::TestReviewPatch` for the integration-API tests.

**Excerpt to mimic (from `test_audit_cli.py`):**
```python
"""Integration tests for the audit CLI entry point.

Tests the CLI wiring: argparse flag handling, invalid path errors,
dry-run mode, and full pipeline execution against the synthetic fixture.
"""

import json
from pathlib import Path

import pytest

from src.maxpat.audit.cli import main

FIXTURES_DIR = Path(__file__).parent / "fixtures"


class TestCLIInvalidPaths:
    """Test error handling for invalid help directory paths."""

    def test_nonexistent_path_returns_1(self):
        result = main(["--help-dir", "nonexistent/path/that/does/not/exist"])
        assert result == 1
```

**Notes:**
- `class TestRunSimulation:` with tests covering: topology lookup miss raises `TopologyError`; `mirror=` and `topology=` mutually exclusive; threshold-override kwargs propagate to `ClassifierThresholds`; report shape (verdict, measurements length == sweep_steps, worst_step bounds).
- Use a simple in-test `mirror` callable (not a real bassoon mirror — those live in `fixtures/`).

---

### `tests/dsp_sim/fixtures/__init__.py` — NEW

**Closest analog:** `tests/__init__.py` (empty package marker).

**Notes:** Empty file. The fixture mirrors are imported by the regression tests via `from tests.dsp_sim.fixtures.bassoon_v040_mirror import build_v040_mirror`.

---

### `tests/dsp_sim/fixtures/bassoon_v040_mirror.py` — NEW

**Closest analog:** `src/maxpat/dsp_sim/topologies/reed_bore_post_radiation.py` shape (per-sample numpy class), but hand-coded to reproduce a SPECIFIC regression. Source the math from `patches/bassoon-model/versions.json` v0.4.0 description ("Update D4 phase-delay compensation to use biquad analytic group delay at freq_mod") and the historical `bassoon.gendsp`.

**Excerpt to mimic (header comment style, lifted from `bassoon.gendsp`):**
```python
"""Regression mirror: bassoon v0.4.0 (group-delay compensation form).

Reproduces the v0.4.0 GenExpr math:
  - Bell biquad INSIDE the bore loop
  - D4 compensation uses biquad GROUP delay at freq_mod (-d/dw of phase),
    NOT phase delay (atan2 of complex B/A).

Group delay overshoots phase delay by ~3x near resonance; sweeping
bell_bright detunes the loop. Asserts verdict == 'phase_drift' when
bell_bright sweeps [0, 1].

Source: patches/bassoon-model/versions.json v0.4.0/v0.4.1 entries +
feedback_waveguide_loop_phase_comp.md analytic forms.
"""

from __future__ import annotations

from dataclasses import dataclass, field
import numpy as np


def build_v040_mirror(sample_rate: float, params: dict[str, float]):
    """Factory matching the run_simulation(mirror=...) escape-hatch contract."""
    return _BassoonV040Mirror(sample_rate=sample_rate, params=params)


@dataclass
class _BassoonV040Mirror:
    sample_rate: float
    params: dict[str, float]
    # ... per-sample state
    def step(self, in1: float, in2: float) -> float:
        ...
```

**Notes:**
- File size target ~80–120 LOC per CONTEXT.md D-11.
- Public surface: `build_v040_mirror(sample_rate, params) -> stepper` (factory matching `mirror=callable` per D-01 / `<specifics>` example).
- The class is private (`_BassoonV040Mirror`) — only the factory is the public mirror entrypoint.
- DO NOT import from `src.maxpat.dsp_sim.topologies` — fixtures must be self-contained per D-11 ("hand-coded numpy, NOT auto-extracted").

---

### `tests/dsp_sim/fixtures/bassoon_v041_mirror.py` — NEW

**Closest analog:** Same as `bassoon_v040_mirror.py`.

**Notes:**
- Same shape, different math: D4 compensation is correct (atan2 phase delay) BUT bell biquad is still in-loop with high Q. Asserts `verdict == 'mode_competition'`.
- Source: `versions.json` v0.4.1 description + the `bell_q = 0.7071068` Butterworth-vs-Q=2.5 distinction from `bassoon.gendsp`.

---

### `tests/dsp_sim/test_bassoon-model.py` — NEW

**Closest analog:** `tests/test_critics.py::TestReviewPatch` (live-asset gate test) — minimal class with one or two methods asserting end-to-end behavior.

**Excerpt to mimic:**
```python
class TestReviewPatch:
    """Test the public review_patch() API."""

    def test_review_patch_returns_list(self):
        """review_patch always returns a list of CriticResult."""
        patch = _proper_gain_staging_patch()
        results = review_patch(patch)
        assert isinstance(results, list)
        for r in results:
            assert isinstance(r, CriticResult)
```

**Notes:**
- **Filename hyphen is intentional** — must match `Path("patches/bassoon-model/generated/bassoon-model.maxpat").stem` exactly per D-07. (Note: this is a non-standard pytest filename pattern — confirm pytest discovers it; pytest's default `testpaths` collects `test_*.py` regardless of hyphens, so this is fine, but the planner should add an explicit pytest test to cover the import path. Python module-import-via-hyphen would fail, but pytest's collection mechanism uses the file path, not the module import — so no `from` import is needed in this file.)
- One test method: `test_bassoon_bell_bright_sweep_stable()` calling `run_simulation(patch_path="patches/bassoon-model/generated/bassoon-model.maxpat", topology="reed_bore_post_radiation", ...)` and asserting `r.verdict == "pass"`.
- Use the canonical params dict from `bassoon.gendsp` Param defaults (e.g., `freq=220.0, breath=0.6, bore_damp=0.3, bell_bright=0.5, reed_stiff=0.5, reed_aper=0.0`).

---

### `tests/dsp_sim/test_bassoon_v040_regression.py` — NEW

**Closest analog:** `tests/test_critics.py::TestDSPCritic` test methods (single-purpose negative assertion).

**Excerpt to mimic:**
```python
class TestDSPCritic:
    def test_missing_gain_staging_cycle(self):
        """cycle~ directly to dac~ -> blocker about missing gain staging."""
        patch = _no_gain_staging_patch()
        results = review_dsp(patch)
        blockers = [r for r in results if r.severity == "blocker"]
        assert len(blockers) >= 1
        assert any("gain" in r.finding.lower() for r in blockers)
```

**Notes:**
- One module-level function `test_v040_phase_drift_is_caught()` (NOT inside a class — matches the `<specifics>` example in CONTEXT.md). Could optionally wrap in `class TestBassoonV040Regression:` for symmetry with `test_classifier.py`.
- Imports `build_v040_mirror` from the fixture file.
- Asserts `r.verdict == "phase_drift"` and `r.reason` mentions "phase_drift" or "cents".
- `r.suggested_fix` mentions "phase delay" or "atan" (the suggested-fix table per D-03).

---

### `tests/dsp_sim/test_bassoon_v041_regression.py` — NEW

**Closest analog:** Same as `test_bassoon_v040_regression.py`.

**Notes:** Same shape; asserts `r.verdict == "mode_competition"`. `suggested_fix` mentions "post-loop" or "Q > ~1".

---

## .claude/skills/

### `.claude/skills/max-dsp-agent/SKILL.md` — MODIFY

**Current shape:** YAML frontmatter (`name`, `description`, `allowed-tools`, `preconditions`) followed by markdown sections in a fixed order:

1. `# DSP/Gen~ Specialist Agent` (title + 1-paragraph blurb)
2. `## Domain Context Loading` — what to read at startup
3. `## Capabilities` — `### GenExpr Code Generation`, `### Gen~ Patch Integration`
4. `## Gen~ Pattern Library` — pattern table + don't-hand-roll table
5. `### Layout and Finalization`, `### Signal Chain Construction`, `### Bpatcher Argument Substitution`, `### Audio Architecture Patterns`, `### Control-Rate Fan-Out in DSP Patches`
6. `## Package Intelligence` — `### Community DSP Packages`, `### BEAP and MSP Integration`
7. `## Package Workflow Templates` — FluCoMa / BEAP / chains
8. `## Editing Existing Patches (via /max-iterate)`
9. `## Output Protocol (New Patches)` — numbered steps
10. `## Output Protocol (Edited Patches)` — numbered steps
11. `## When to Use` — bulleted scope
12. `## When NOT to Use` — bulleted exclusions

**Where to slot the new "DSP Pre-Flight Simulation" section:**

Best fit is between `## Output Protocol (Edited Patches)` and `## When to Use`. The pre-flight gate runs at output time (right after critics) and before commit, so it's a natural extension of the output-protocol numbered steps. The new section may also be referenced FROM the existing Output Protocol step list (e.g., "5. Run DSP pre-flight simulation if `tests/dsp_sim/test_<stem>.py` exists — see § DSP Pre-Flight Simulation").

**Excerpt of the existing Output Protocol section (current shape to extend):**
```markdown
## Output Protocol (New Patches)

1. Generate GenExpr code and/or MSP signal chain
2. If GenExpr: validate with `validate_genexpr()` from `src.maxpat.code_validation`
3. If .maxpat with signal objects: `finalize_patch(patcher, is_new=True)` -- applies styling, layout, assistance comments, and midpoint generation for all patchers and subpatchers. Then serialize via `patcher.to_dict()`, validate via `validate_patch()`
4. If standalone .gendsp: generate via `generate_gendsp()`
5. Return output for critic review (DSP critic checks signal flow, gen~ I/O matching)
6. Apply revisions if critic requests them
7. Write final output via `save_patch_roundtrip(patch_dict, path)` or `write_gendsp()` to project's `generated/` directory
```

**New section to add (after Output Protocol blocks, before `## When to Use`):**

```markdown
## DSP Pre-Flight Simulation

Before committing a waveguide patch, agent checks for an opt-in numpy
stability fixture and gates the save on its result.

### When to Run
- Compute `stem = Path(patch_path).stem` and look for `tests/dsp_sim/test_<stem>.py`.
- Present → run `pytest tests/dsp_sim/test_<stem>.py -q` BEFORE `save_patch_roundtrip()`.
- Absent → no gate (non-waveguide patches commit freely).

### How to Register a New Sim Test
For a patch at `patches/<project>/generated/<name>.maxpat`:
1. Pick a topology from `src/maxpat/dsp_sim/topologies/` (`bore_only`,
   `reed_bore`, `reed_bore_post_radiation`) or write a custom mirror.
2. Create `tests/dsp_sim/test_<name>.py` calling
   `run_simulation(patch_path=..., topology=..., params=..., sweep_param=..., sweep=(lo, hi, n))`.
3. Assert `report.verdict == "pass"`.

### Failure Handling (VALID-05 'error')
If the gate fails:
- Surface the verdict, sweep param, worst step's measured Hz vs target Hz, and the `suggested_fix` string.
- HARD BLOCK the commit (severity = error per VALID-05).
- The author fixes the DSP issue (or, if intentional, deletes/skip-marks the fixture per D-10).

See `tests/dsp_sim/README.md` for the topology catalogue, threshold
defaults, and the four failure modes.
```

**Notes:**
- Keep the markdown style consistent with the rest of SKILL.md: `## Section`, `### Subsection`, bulleted lists with bold leading terms.
- Reference `src.maxpat.dsp_sim` once with the canonical import path.
- Cite the decision IDs (D-04, D-07, D-10, VALID-05) in inline parens — matches the existing SKILL.md's reference style ("see CLAUDE.md 'X' section").
- DO NOT modify the YAML frontmatter; no new tools or preconditions are required.

---

## Cross-cutting Conventions

These apply to every new file in Phase 32:

### Module-level
- **`from __future__ import annotations`** at the top of every `.py` file (used in 100% of `src/maxpat/**/*.py` files inspected). Enables `dict | None`, forward references, etc., without quoting.
- **Module docstring** is mandatory and follows triple-quoted multi-line form: a one-line summary, blank line, then context paragraph(s) explaining purpose, decisions referenced, and notable invariants. Look at `dsp_critic.py:1-11`, `audit_signal_role.py:1-25`, `audit/cli.py:1-5` for archetypes. Phase 32 modules SHOULD reference relevant CONTEXT.md decision IDs (D-01..D-11) directly in the docstring like `audit_signal_role.py` does.
- **`__all__` list at module bottom** when the module is part of a public package (`__init__.py` files); not required for inner-leaf modules like `runner.py`.

### Dataclasses
- **`@dataclass`** (frozen=True for immutable config like `ClassifierThresholds`). Field-level docstrings via inline `"""..."""` after each attribute when the field needs explanation (matches `audit/__init__.py::BoxInstance`).
- **Class-level docstring** with `Attributes:` block listing each field (`ext_validation.py::BuildResult` is the cleanest archetype).
- **Mutable defaults** via `field(default_factory=list)` / `field(init=False, default=0.0)` (matches `audit/__init__.py:50` and the topology state pattern).

### Exception classes
- **Single-line docstring**, inherit from `Exception` directly (matches `hooks.py::PatchGenerationError`, `PatchValidationError`):
  ```python
  class TopologyError(Exception):
      """Raised when a topology name is unknown or mirror conflict detected."""
  ```

### Naming
- **`snake_case`** for functions, methods, module-level names.
- **`_underscore_prefix`** for module-private helpers (matches `dsp_critic.py::_check_gain_staging`, `audit_signal_role.py::_classify_digest`).
- **`_UPPER_SNAKE`** for module-level frozensets/constants when private (`_OSCILLATOR_NAMES`, `_GAIN_NAMES`); `UPPER_SNAKE` (no underscore) for public constants (`SIGNAL_TYPES`, `DEFAULT_HELP_DIR`).
- **`PascalCase`** for classes and dataclasses (`SimulationReport`, `StepMeasurement`, `BoreOnly`, `ClassifierThresholds`, `TopologyError`).

### Imports
- Order: stdlib → third-party (`numpy`, `scipy`) → `src.maxpat.*`. Blank line between groups.
- Absolute imports only (`from src.maxpat.dsp_sim.topologies import ...`); never relative (`from ..topologies`). Matches every existing file in `src/maxpat/**`.

### Test files
- **Module docstring** describing the test surface.
- **Banner comments** between sections: `# ===` (75 chars) for major sections, `# ---` (75 chars) for sub-sections (matches `dsp_critic.py:88` and `test_critics.py:22`).
- **Class containers** named `TestX` with a one-line docstring describing the surface under test.
- **Test methods** named `test_<scenario>` with a one-line docstring stating the expected outcome (e.g., `"""cycle~ directly to dac~ -> blocker about missing gain staging."""`).
- **Helper builders** at module top, prefixed `_make_` or `_<scenario>_patch` (matches `_make_patch`, `_no_gain_staging_patch`).

### CLI conventions
- **`main(argv: list[str] | None = None) -> int`** signature (matches `audit_signal_role.py::main` and `audit/cli.py::main`).
- **`raise SystemExit(main())`** in the `if __name__ == "__main__":` block (NOT `sys.exit(main())`).
- **Exit codes** per CONTEXT.md `<specifics>`: `0=pass, 1=phase_drift, 2=mode_competition, 3=no_oscillation, 4=runaway`.
- **Argparse** via a `build_parser()` factory function (matches `audit_signal_role.py::build_parser`); flags use `--kebab-case`, `default=...` shows in `--help` via the `help=` string.

### Per-CLAUDE.md DSP rules
- **Gen~ → numpy mapping** (CONTEXT.md `<canonical_refs>` cites CLAUDE.md §"Gen~"): `History x` → scalar `_x` field; `Data buf(N)` → `np.zeros(N)` + write index; `Delay.read/write` → buffer indexing with mod-arithmetic.
- **Param ordering**: in `.gendsp`, all `Param` declarations come before any expression. Topology classes mirror this — accept the `params: dict[str, float]` in `__init__` and use them in `step()`.
- **`from __future__ import annotations` + dataclass + `field(init=False, default=...)`** is the canonical state-bearing class shape.

---

## PATTERN MAPPING COMPLETE

Files documented: **23** (22 NEW + 1 MODIFIED).

NEW (22):
1. `src/maxpat/dsp_sim/__init__.py`
2. `src/maxpat/dsp_sim/runner.py`
3. `src/maxpat/dsp_sim/measure.py`
4. `src/maxpat/dsp_sim/classifier.py`
5. `src/maxpat/dsp_sim/topologies/__init__.py`
6. `src/maxpat/dsp_sim/topologies/bore_only.py`
7. `src/maxpat/dsp_sim/topologies/reed_bore.py`
8. `src/maxpat/dsp_sim/topologies/reed_bore_post_radiation.py`
9. `src/maxpat/dsp_sim/cli.py`
10. `src/maxpat/dsp_sim/__main__.py`
11. `tests/dsp_sim/__init__.py`
12. `tests/dsp_sim/conftest.py`
13. `tests/dsp_sim/README.md`
14. `tests/dsp_sim/test_classifier.py`
15. `tests/dsp_sim/test_topologies.py`
16. `tests/dsp_sim/test_runner.py`
17. `tests/dsp_sim/fixtures/__init__.py`
18. `tests/dsp_sim/fixtures/bassoon_v040_mirror.py`
19. `tests/dsp_sim/fixtures/bassoon_v041_mirror.py`
20. `tests/dsp_sim/test_bassoon-model.py`
21. `tests/dsp_sim/test_bassoon_v040_regression.py`
22. `tests/dsp_sim/test_bassoon_v041_regression.py`

MODIFIED (1):
23. `.claude/skills/max-dsp-agent/SKILL.md`
