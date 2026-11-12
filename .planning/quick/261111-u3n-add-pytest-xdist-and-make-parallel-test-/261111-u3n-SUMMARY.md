---
phase: quick-261111-u3n
plan: 01
subsystem: testing
tags: [pytest, pytest-xdist, ci, test-isolation]
status: complete
requires: []
provides:
  - "parallel-by-default test suite (pytest.ini addopts -n auto)"
  - "pytest-xdist>=3.8 in requirements-dev.txt"
affects: [ci, release-archive, max-dsp-agent DSP gate]
tech-stack:
  added: [pytest-xdist 3.8.0, execnet 2.1.2 (transitive)]
  patterns: ["tests write only under tmp_path", "port-0 sockets held for the process lifetime", "nested pytest runs pass -o addopts="]
key-files:
  created: [pytest.ini]
  modified: [requirements-dev.txt, tests/test_max_bridge.py, tests/test_generation.py, tests/test_release.py, .gitattributes, .github/workflows/test.yml, TECHNICAL.md, .claude/skills/max-dsp-agent/SKILL.md]
decisions:
  - "pytest.ini (not pyproject.toml) with addopts = -n auto only; no --dist loadgroup since no xdist_group was needed"
  - "pytest.ini is export-ignored so release installs (no tests, maybe no xdist) never inherit -n auto"
  - "Repo-path instrument() calls in bridge tests now work on tmp_path copies; repo files still asserted byte-identical"
metrics:
  duration: "~60 min"
  completed: 2026-11-11
estimate:
  tokens: 80000
  tasks: 3
actuals:
  tokens: 9000
  tasks: 3
  commits: 2
plan_head_before: 08c2910132afd9ca4dc71bfdc0ea61519360ed82
plan_head_after: 106ec153e7f8fe955925ae6fc69ba16d8628a3f0
---

# Quick 261111-u3n: pytest-xdist, parallel-safe tests, parallel by default

The 7,574-test suite now runs on 16 xdist workers by default: 3m45s-3m59s serial down to 26-30 s parallel (8.6x). One real parallel race and two transient repo writes into `patches/` were fixed by moving the state into `tmp_path`. No src/ change, nothing under patches/ touched, no xdist_group.

## Wall times (`/usr/bin/time -p` real; 16/16 workers; every run 7569 passed, 1 skipped, 4 xfailed)

| Run | Command | Real (s) |
|-----|---------|----------|
| serial-baseline | `pytest -q` (before any change) | 239.34 |
| par-1 | `pytest -q -n auto -rfE` (before fixes) | 27.57 |
| par-2 | same | 29.39 |
| par-3 | same | 30.36 |
| serial-fixed | `pytest -q` (after Task 2 fixes) | 235.55 |
| par-fixed-1 | `pytest -q -n auto -rfE` | 26.80 |
| par-fixed-2 | same | 28.75 |
| par-fixed-3 | same | 27.80 |
| serial-final | `pytest -q -n 0` (with pytest.ini) | 225.28 |
| par-final-1 | `pytest -q` (default, now parallel) | 26.44 |
| par-final-2 | same | 29.18 |

Speedup: serial-baseline 239.34 s / median par-final 27.81 s = **8.6x**. That makes 9 full parallel runs, plus 2 audit-hook runs and the plan's verify run, all green. Collected count is 7574 before and after (also with `-n 0`). Every full run left HEAD and the stash list unchanged, and its `find -newer` sweep found no repo writes.

## Changed tests

- `tests/test_max_bridge.py::TestNote::test_note_mirror_simple_fm`: `bridge.instrument()` writes its `__maxbridge_` copy beside the source. This test and `test_note_off_by_default` both instrumented the repo file `patches/simple-fm/generated/simple-fm.maxpat`, so two workers wrote and unlinked the same path. It failed with FileNotFoundError in 3 of 5 `-n auto` runs of the bridge files on their own (0 of 3 full-suite runs, depending on how tests were distributed). Fix: a new `simple_fm_copy` fixture puts a copy in tmp_path and the test instruments that. It still asserts the repo file is byte-identical afterwards.
- `tests/test_max_bridge.py::TestNote::test_note_off_by_default`: the other side of the same race. Same fix.
- `tests/test_max_bridge.py::TestFixtures::test_instrument_fixture[5 params]`: wrote `__maxbridge_fx-*.maxpat` and `.atomic-*.tmp` into `patches/max-bridge/fixtures/` and deleted them again. Each param uses a different name, so there was no collision, but it was still a write under patches/. Fix: instrument a tmp_path copy and assert the repo fixture is unchanged.
- `tests/test_max_bridge.py::_free_port()` and its callers (4 tests in test_max_bridge.py plus 8 call sites in test_max_verify_live.py, which imports it): it bound port 0, closed the socket and returned the number (TOCTOU). xdist workers share the OS port namespace, so another worker's ephemeral bind (FakeBridge or a Bridge reply socket) could take the port before the test sent its /ping there. Fix: the reserving UDP socket stays bound and is never read until the process exits (closed via atexit). It still answers nothing, so the "nobody listens" timeout path is the same. This never failed; it was fixed as a static hazard.
- `tests/test_generation.py::TestRegression::test_phase1_tests_still_pass`: the nested `python -m pytest` now gets `-o addopts=`. Without it the child would start its own 16-worker pool inside every xdist worker (N x N processes) and would need xdist itself.
- `tests/test_release.py`: `EXPORT_IGNORE_PATTERNS` now requires `/pytest.ini`, and `TestReleaseArchive::test_maintainer_trees_excluded` asserts `pytest.ini` is not in the archive. Both pass now that the config is committed.

xdist_group markers: **none**. Every hazard could be isolated, so pytest.ini has no `--dist loadgroup`.

How the hidden race was found: a full-suite `find -newer` sweep cannot see files that are created and deleted inside one run. A scratch pytest plugin plus a sitecustomize `sys.addaudithook` (open-for-write, remove, rename, mkdir, rmtree; workers and Python subprocesses included) logged every in-repo write. It found exactly the 7 test ids above. After the fixes, the same audit run logged zero in-repo writes. The tool lived in the session scratchpad and was not committed.

## Config changes

- `requirements-dev.txt`: `pytest-xdist>=3.8`, with a comment. Installed version is 3.8.0 with execnet 2.1.2. `pip download --python-version 3.10` resolves the wheel.
- `pytest.ini` (new): `[pytest]` and `addopts = -n auto`. A comment block lists the serial and debug forms and `PYTEST_XDIST_AUTO_NUM_WORKERS`. It has no testpaths, markers or required_plugins.
- `.gitattributes`: `/pytest.ini export-ignore`.
- `.github/workflows/test.yml`: comment only. The `python -m pytest -q` step is unchanged and now runs in parallel through pytest.ini.
- `TECHNICAL.md` "Test Suite": shows the parallel default and the `-n 0`, `-o addopts=`, single-file and `--pdb` forms, plus a short isolation rule.

### FLAG: `.claude/skills/max-dsp-agent/SKILL.md` edit (approved as config)

The DSP pre-flight gate snippet's argv now ends with `"-o", "addopts="`, and one sentence below the block explains why. Without it, in this checkout the gate would inherit `-n auto` from pytest.ini and need xdist. The pinned prefix `[sys.executable, "-m", "pytest", str(fixture), "-q"` is intact, and tests/test_agent_skills.py passes. In release installs pytest.ini is not shipped, so the gate behaves exactly as before.

## Escape hatches (checked; evidence in escape.txt)

- `pytest -q -n 0`: serial, no workers line. Pass.
- `pytest -q -o addopts=`: serial. Also passes with `-p no:xdist`, which simulates xdist not being installed.
- `pytest -q -p no:xdist` with the ini: fails on `-n`, as expected. This is why the ini is export-ignored and nested runs pass `-o addopts=`.
- `pytest --pdb ...`: works. xdist 3.8 forces `-n 0` under `--pdb`, and there is no `--dist` mode to conflict with it. `-n 0 --pdb` also works.
- `PYTEST_XDIST_AUTO_NUM_WORKERS=4`: gives "created: 4/4 workers".

**Usage note:** a targeted single-file run now starts the full 16-worker pool (about 0.8 s overhead). Use `-n 0` for quick runs.

## Watch list (load-sensitive wall-clock assertions; none failed, left unchanged)

- tests/test_genexpr_lint.py::test_large_codebox_is_fast (`perf_counter < 2.0` s)
- tests/test_max_bridge.py::TestPing::test_no_listener_exit_2 (`< 1.5` s with a 0.5 s timeout)
- tests/test_max_bridge.py test_no_window (`< 2.0` s with a 0.3 s timeout)

## Environment notes

- The worktree lacks the main checkout's gitignored `patches/.active-project.json`. No test failed because of that, and the serial baseline was green with no pre-existing failures.

## Deviations from Plan

**1. [Rule 1 - Bug] The race in TestNote and the patches/ writes were found after par-1..3**
- **Found during:** Task 2, the per-file 5x `-n auto` loop after the `_free_port` fix
- **Issue:** The three discovery full-suite runs were all green, but the bridge files run alone failed 3 of 5 times. The find-newer sweep cannot see transient writes.
- **Fix:** Added the audit-hook scan, then made the tmp_path fixes listed above. triage.txt records it as an "ADDED after par-1..3" row.
- **Commit:** 093b5157

**2. Documentation correction:** the plan expected xdist to reject `--pdb`. Measured: xdist 3.8 forces `-n 0` under `--pdb`, so plain `--pdb` works. Only working forms are documented.

## Commits

- 093b5157 test(xdist): add pytest-xdist and isolate parallel-unsafe tests (quick 261111-u3n)
- 106ec153 ci(pytest): run the suite in parallel by default via pytest.ini (quick 261111-u3n)

## Self-Check: PASSED

- FOUND: pytest.ini, requirements-dev.txt (pytest-xdist>=3.8), .gitattributes (/pytest.ini export-ignore)
- FOUND: 093b5157, 106ec153 (ancestors of HEAD)
- The plan's automated verify passed for Tasks 1, 2 and 3 (VERIFY1/2/3 OK). No src/ or patches/ path is in either commit.
