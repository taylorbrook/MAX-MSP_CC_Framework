"""DSP pre-flight simulator CLI -- manual-reproduction entry point.

Per CONTEXT.md D-08: single-fixture entry point with no subcommands.
pytest is the canonical agent-side path; this CLI exists for ad-hoc
'sweep this one Param real quick' workflows.

Per D-09: exit codes mirror verdict priority --
  0 = pass
  1 = phase_drift
  2 = mode_competition
  3 = no_oscillation
  4 = runaway

Usage:
  python -m src.maxpat.dsp_sim \\
      --patch patches/bassoon-model/generated/bassoon-model.maxpat \\
      --topology reed_bore_post_radiation \\
      --param bell_bright \\
      --sweep "0.0,1.0,32" \\
      --params "freq=220,breath=0.6,bore_damp=0.3"

Threat model (Plan 32-05 <threat_model>):
  - T-01 (Elevation): _load_mirror uses importlib.import_module + getattr
    only; no string evaluation, no string-as-code execution, no compile of
    arbitrary strings. Test suite asserts the dangerous-call grep returns 0.
  - T-02 (Tampering): no shell invocations or process spawning from this CLI.
  - T-03 (Information disclosure): --patch is carried as an opaque string
    into the SimulationReport; never opened or path-resolved here.
  - T-04 (Denial of Service): the runner caps per-step buffer size; sweep
    n_steps is bounded only by the user's patience.
"""

from __future__ import annotations

import argparse
import importlib
import sys
from typing import Callable

from src.maxpat.dsp_sim import (
    MODE_COMPETITION,
    NO_OSCILLATION,
    PASS,
    PHASE_DRIFT,
    RUNAWAY,
    SimulationReport,
    TopologyError,
    run_simulation,
)


# ===========================================================================
# Verdict -> exit code (D-08 + D-09 priority)
# ===========================================================================

_EXIT_CODE: dict[str, int] = {
    PASS: 0,
    PHASE_DRIFT: 1,
    MODE_COMPETITION: 2,
    NO_OSCILLATION: 3,
    RUNAWAY: 4,
}

# Sparkline characters (Claude's Discretion: Unicode block chars per CONTEXT.md)
_SPARK_CHARS = "▁▂▃▄▅▆▇█"


# ===========================================================================
# Argument parser (no subcommands per D-08)
# ===========================================================================


def build_parser() -> argparse.ArgumentParser:
    """Build the top-level argparse parser (no subcommands per D-08)."""
    parser = argparse.ArgumentParser(
        prog="python -m src.maxpat.dsp_sim",
        description=(
            "Run a numpy waveguide-stability sweep against a topology or "
            "custom mirror. Exit codes per D-09 priority: "
            "0=pass, 1=phase_drift, 2=mode_competition, "
            "3=no_oscillation, 4=runaway."
        ),
    )
    parser.add_argument(
        "--patch",
        required=True,
        type=str,
        help="Path to the .maxpat being modeled (carried in report; not parsed).",
    )
    src_group = parser.add_mutually_exclusive_group(required=True)
    src_group.add_argument(
        "--topology",
        type=str,
        help="Curated topology: bore_only, reed_bore, reed_bore_post_radiation.",
    )
    src_group.add_argument(
        "--mirror",
        type=str,
        help="Custom mirror as 'module.path:factory_name' (D-01 escape hatch).",
    )
    parser.add_argument(
        "--param",
        required=True,
        type=str,
        help="Name of the parameter to sweep.",
    )
    parser.add_argument(
        "--sweep",
        required=True,
        type=str,
        help="'lo,hi,n' -- e.g., '0.0,1.0,32'.",
    )
    parser.add_argument(
        "--params",
        default="",
        type=str,
        help="Base params 'k=v,k=v' (e.g., 'freq=220,breath=0.6').",
    )

    # Threshold overrides (D-05; quiet escape hatches)
    parser.add_argument(
        "--cents-drift-limit",
        type=float,
        default=5.0,
        help="phase_drift threshold (default 5 cents range across sweep).",
    )
    parser.add_argument(
        "--mode-competition-jump",
        type=float,
        default=50.0,
        help="mode_competition threshold (default 50 cents single-step).",
    )
    parser.add_argument(
        "--amplitude-floor",
        type=float,
        default=1e-4,
        help="no_oscillation threshold (default 1e-4 RMS).",
    )
    parser.add_argument(
        "--runaway-amplitude",
        type=float,
        default=10.0,
        help="runaway threshold (default 10.0 peak).",
    )
    parser.add_argument(
        "--sample-rate",
        type=int,
        default=44100,
        help="Sample rate Hz (default 44100).",
    )
    parser.add_argument(
        "--settle-ms",
        type=int,
        default=100,
        help="Settle window in ms before measurement (default 100).",
    )
    return parser


# ===========================================================================
# Helper parsers
# ===========================================================================


def _parse_sweep(s: str) -> tuple[float, float, int]:
    """Parse 'lo,hi,n' -> (float, float, int). Raises SystemExit on malformed."""
    try:
        parts = [p.strip() for p in s.split(",")]
        if len(parts) != 3:
            raise ValueError
        return (float(parts[0]), float(parts[1]), int(parts[2]))
    except ValueError:
        print(f"error: --sweep must be 'lo,hi,n' (got {s!r})", file=sys.stderr)
        raise SystemExit(2)


def _parse_params(s: str) -> dict[str, float]:
    """Parse 'k=v,k=v' -> dict[str, float]. Empty string -> {}."""
    if not s.strip():
        return {}
    out: dict[str, float] = {}
    for pair in s.split(","):
        if not pair.strip():
            continue
        if "=" not in pair:
            print(
                f"error: --params token {pair!r} missing '='",
                file=sys.stderr,
            )
            raise SystemExit(2)
        k, v = pair.split("=", 1)
        try:
            out[k.strip()] = float(v.strip())
        except ValueError:
            print(
                f"error: --params value for {k.strip()!r} not numeric: "
                f"{v.strip()!r}",
                file=sys.stderr,
            )
            raise SystemExit(2)
    return out


def _load_mirror(spec: str) -> Callable:
    """Load 'module.path:factory_name' via importlib. NO eval/exec.

    T-01 mitigation: importlib.import_module rejects malformed module names
    and never executes arbitrary strings as code. The factory must already
    exist as a top-level attribute of the imported module.
    """
    if ":" not in spec:
        print(
            f"error: --mirror must be 'module.path:factory_name' "
            f"(got {spec!r})",
            file=sys.stderr,
        )
        raise SystemExit(2)
    module_path, factory_name = spec.rsplit(":", 1)
    try:
        mod = importlib.import_module(module_path)
    except ImportError as exc:
        print(
            f"error: cannot import {module_path!r}: {exc}",
            file=sys.stderr,
        )
        raise SystemExit(2)
    if not hasattr(mod, factory_name):
        print(
            f"error: module {module_path!r} has no attribute "
            f"{factory_name!r}",
            file=sys.stderr,
        )
        raise SystemExit(2)
    factory = getattr(mod, factory_name)
    if not callable(factory):
        print(f"error: {spec!r} is not callable", file=sys.stderr)
        raise SystemExit(2)
    return factory


# ===========================================================================
# Output rendering
# ===========================================================================


def _sparkline(values: list[float]) -> str:
    """Render a list of floats as a Unicode block-char sparkline.

    NaN values render as '?'. If the entire input is non-finite the
    sparkline is all '?'. A flat (zero-span) input renders all-low.
    """
    if not values:
        return ""
    finite = [
        v for v in values
        if v == v and v != float("inf") and v != float("-inf")
    ]
    if not finite:
        return "?" * len(values)
    lo, hi = min(finite), max(finite)
    span = hi - lo
    chars: list[str] = []
    for v in values:
        if v != v:  # NaN
            chars.append("?")
            continue
        if v == float("inf") or v == float("-inf"):
            chars.append("?")
            continue
        if span <= 1e-12:
            chars.append(_SPARK_CHARS[0])
            continue
        idx = int((v - lo) / span * (len(_SPARK_CHARS) - 1))
        idx = max(0, min(len(_SPARK_CHARS) - 1, idx))
        chars.append(_SPARK_CHARS[idx])
    return "".join(chars)


def _print_report(report: SimulationReport) -> None:
    """Print verdict, per-step table, sparkline, and (on failure) suggested_fix."""
    print(f"verdict: {report.verdict}")
    print(f"reason:  {report.reason}")
    print(f"sweep:   {report.sweep_param} {report.sweep_range}")
    print()
    # Per-step measurement table.
    header = (
        f"{'step':>4}  {'param':>10}  {'target_hz':>10}  "
        f"{'measured_hz':>11}  {'cents':>8}  {'rms':>10}  {'peak':>10}"
    )
    print(header)
    for i, m in enumerate(report.measurements):
        marker = " <-" if report.worst_step == i else ""
        print(
            f"{i:4d}  {m.param_value:10.4f}  {m.target_hz:10.2f}  "
            f"{m.measured_hz:11.2f}  {m.cents_offset:8.2f}  "
            f"{m.rms_amplitude:10.4e}  {m.peak_amplitude:10.4e}{marker}"
        )
    print()
    cents_values = [m.cents_offset for m in report.measurements]
    print(f"cents_offset sparkline: {_sparkline(cents_values)}")
    if report.suggested_fix:
        print()
        print(f"suggested fix: {report.suggested_fix}")


# ===========================================================================
# main() entry point
# ===========================================================================


def main(argv: list[str] | None = None) -> int:
    """CLI entry point. Returns the exit code (D-08 + D-09 priority)."""
    parser = build_parser()
    args = parser.parse_args(argv)

    sweep = _parse_sweep(args.sweep)
    base_params = _parse_params(args.params)

    mirror: Callable | None = None
    topology: str | None = None
    if args.mirror is not None:
        mirror = _load_mirror(args.mirror)
    else:
        topology = args.topology

    try:
        report = run_simulation(
            patch_path=args.patch,
            topology=topology,
            mirror=mirror,
            params=base_params,
            sweep_param=args.param,
            sweep=sweep,
            sample_rate=args.sample_rate,
            settle_ms=args.settle_ms,
            cents_drift_limit=args.cents_drift_limit,
            mode_competition_jump=args.mode_competition_jump,
            amplitude_floor=args.amplitude_floor,
            runaway_amplitude=args.runaway_amplitude,
        )
    except TopologyError as exc:
        print(f"error: {exc}", file=sys.stderr)
        return 2

    _print_report(report)
    return _EXIT_CODE.get(report.verdict, 1)


if __name__ == "__main__":
    raise SystemExit(main())
