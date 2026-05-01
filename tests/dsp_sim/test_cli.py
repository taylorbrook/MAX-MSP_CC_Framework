"""Integration tests for the dsp_sim CLI entry point.

Tests argparse surface, --help, exit-code mapping per D-08/D-09 verdict
priority, and the --mirror module:func loader's safety contract (T-01).

Plan 32-05. The CLI is a single-fixture manual-reproduction entry point;
pytest stays the canonical agent-side path. Exit codes mirror D-09:

  pass             -> 0
  phase_drift      -> 1
  mode_competition -> 2
  no_oscillation   -> 3
  runaway          -> 4
"""

from __future__ import annotations

import math

import pytest

from src.maxpat.dsp_sim.cli import _load_mirror, _parse_params, _parse_sweep, main


# ===========================================================================
# Argparse surface
# ===========================================================================


class TestCLIHelp:
    """--help prints the documented flags and exits 0."""

    def test_help_exits_zero(self, capsys):
        with pytest.raises(SystemExit) as exc:
            main(["--help"])
        assert exc.value.code == 0
        out = capsys.readouterr().out
        assert "usage:" in out.lower()
        for flag in (
            "--patch",
            "--topology",
            "--mirror",
            "--param",
            "--sweep",
            "--params",
            "--cents-drift-limit",
            "--mode-competition-jump",
            "--amplitude-floor",
            "--runaway-amplitude",
        ):
            assert flag in out, f"--help output must mention {flag}"


# ===========================================================================
# Helper parsers
# ===========================================================================


class TestParseSweep:
    """_parse_sweep handles 'lo,hi,n' triples."""

    def test_valid_sweep(self):
        assert _parse_sweep("0.0,1.0,32") == (0.0, 1.0, 32)

    def test_valid_sweep_with_whitespace(self):
        assert _parse_sweep(" 0.0 , 1.0 , 32 ") == (0.0, 1.0, 32)

    def test_malformed_sweep_two_parts_exits_2(self):
        with pytest.raises(SystemExit) as exc:
            _parse_sweep("0,1")
        assert exc.value.code == 2

    def test_malformed_sweep_garbage_exits_2(self):
        with pytest.raises(SystemExit) as exc:
            _parse_sweep("not_a_sweep")
        assert exc.value.code == 2


class TestParseParams:
    """_parse_params handles 'k=v,k=v' tokens."""

    def test_empty_returns_empty_dict(self):
        assert _parse_params("") == {}

    def test_whitespace_only_returns_empty_dict(self):
        assert _parse_params("   ") == {}

    def test_basic_pairs(self):
        assert _parse_params("freq=220,breath=0.6") == {
            "freq": 220.0,
            "breath": 0.6,
        }

    def test_strips_whitespace(self):
        assert _parse_params(" freq = 220 , breath = 0.6 ") == {
            "freq": 220.0,
            "breath": 0.6,
        }

    def test_non_numeric_value_exits_2(self):
        with pytest.raises(SystemExit) as exc:
            _parse_params("freq=not_a_number")
        assert exc.value.code == 2

    def test_missing_equals_exits_2(self):
        with pytest.raises(SystemExit) as exc:
            _parse_params("frequency_220")
        assert exc.value.code == 2


# ===========================================================================
# Mirror loader (T-01 safety contract)
# ===========================================================================


class TestLoadMirror:
    """_load_mirror uses importlib (no eval/exec) and rejects malformed specs."""

    def test_no_colon_exits_2(self):
        with pytest.raises(SystemExit) as exc:
            _load_mirror("just_a_module_name")
        assert exc.value.code == 2

    def test_unimportable_module_exits_2(self):
        with pytest.raises(SystemExit) as exc:
            _load_mirror("zzz_does_not_exist_xyz:foo")
        assert exc.value.code == 2

    def test_missing_attribute_exits_2(self):
        with pytest.raises(SystemExit) as exc:
            _load_mirror("os.path:zzz_not_a_real_attr")
        assert exc.value.code == 2

    def test_loads_valid_callable(self):
        # os.path.join is a known top-level callable
        fn = _load_mirror("os.path:join")
        assert callable(fn)

    def test_non_callable_attribute_exits_2(self):
        # `os.sep` is a string attribute, not callable.
        with pytest.raises(SystemExit) as exc:
            _load_mirror("os:sep")
        assert exc.value.code == 2


# ===========================================================================
# Inline mirrors for exit-code tests (D-08 + D-09 verdict priority)
# ===========================================================================
#
# Each public factory below returns an object with `.step(in1, in2) -> float`
# whose output drives the classifier to a specific verdict. They live at
# module scope so `tests.dsp_sim.test_cli:_FACTORY_NAME` resolves via
# importlib.

def _runaway_mirror(sample_rate, params):
    """Mirror that produces NaN immediately -> runaway (exit 4)."""
    class _R:
        def step(self, in1, in2):
            return float("nan")
    return _R()


def _silent_mirror(sample_rate, params):
    """Mirror that returns 0.0 forever -> no_oscillation (exit 3)."""
    class _S:
        def step(self, in1, in2):
            return 0.0
    return _S()


def _clean_220_mirror(sample_rate, params):
    """Mirror producing a clean 220 Hz sine -> pass (exit 0).

    Phase advances per-instance so every sweep step starts from 0.0 phase
    and produces an identical buffer (no spurious phase_drift between
    steps).
    """
    class _C:
        def __init__(self):
            self._phase = 0.0
            self._sr = float(sample_rate)
            self._w = 2.0 * math.pi * float(params.get("freq", 220.0)) / self._sr

        def step(self, in1, in2):
            self._phase += self._w
            return 0.5 * math.sin(self._phase)

    return _C()


# ===========================================================================
# Exit-code mapping (D-08 + D-09 verdict priority)
# ===========================================================================


_BASE_ARGS = [
    "--patch", "x",
    "--param", "x",
    "--sweep", "0,1,4",
    "--params", "freq=220",
]


class TestExitCodes:
    """Verdict -> exit code mapping per D-08 + D-09 priority."""

    def test_pass_exits_0(self, capsys):
        rc = main(_BASE_ARGS + [
            "--mirror", "tests.dsp_sim.test_cli:_clean_220_mirror",
        ])
        assert rc == 0

    def test_runaway_exits_4(self, capsys):
        rc = main(_BASE_ARGS + [
            "--mirror", "tests.dsp_sim.test_cli:_runaway_mirror",
        ])
        assert rc == 4

    def test_no_oscillation_exits_3(self, capsys):
        rc = main(_BASE_ARGS + [
            "--mirror", "tests.dsp_sim.test_cli:_silent_mirror",
        ])
        assert rc == 3

    def test_unimportable_mirror_exits_2(self, capsys):
        rc = main(_BASE_ARGS + [
            "--mirror", "module.does.not.exist:foo",
        ])
        assert rc == 2

    def test_topology_and_mirror_mutually_exclusive(self, capsys):
        # argparse mutually-exclusive group rejects this at parse time
        # with exit 2 (argparse default for usage errors).
        with pytest.raises(SystemExit) as exc:
            main([
                "--patch", "x",
                "--topology", "reed_bore_post_radiation",
                "--mirror", "tests.dsp_sim.test_cli:_clean_220_mirror",
                "--param", "x",
                "--sweep", "0,1,4",
            ])
        assert exc.value.code == 2

    def test_topology_pass_against_live_bassoon_shape(self, capsys):
        """The reed_bore_post_radiation topology with bassoon defaults
        passes a bell_bright sweep -- mirrors the canonical DSPSIM-05 truth.
        """
        rc = main([
            "--patch", "patches/bassoon-model/generated/bassoon-model.maxpat",
            "--topology", "reed_bore_post_radiation",
            "--param", "bell_bright",
            "--sweep", "0.0,1.0,8",
            "--params",
            "freq=220,breath=0.6,bore_damp=0.3,bell_bright=0.5,"
            "reed_stiff=0.5,reed_aper=0.0,cone_loss=0.85,register=0.0,"
            "reed_res_freq=1500,reed_res_q=0.7071068",
        ])
        assert rc == 0


# ===========================================================================
# Output rendering (sparkline + report table appears on stdout)
# ===========================================================================


class TestOutputRendering:
    """CLI prints verdict, per-step table, and sparkline to stdout."""

    def test_pass_run_prints_verdict_and_sparkline(self, capsys):
        rc = main(_BASE_ARGS + [
            "--mirror", "tests.dsp_sim.test_cli:_clean_220_mirror",
        ])
        assert rc == 0
        out = capsys.readouterr().out
        assert "verdict:" in out
        assert "pass" in out
        assert "sparkline" in out

    def test_failing_run_prints_suggested_fix(self, capsys):
        # runaway mirror produces NaN immediately -> verdict=runaway,
        # which has a suggested_fix string.
        rc = main(_BASE_ARGS + [
            "--mirror", "tests.dsp_sim.test_cli:_runaway_mirror",
        ])
        assert rc == 4
        out = capsys.readouterr().out
        assert "suggested fix" in out.lower()
