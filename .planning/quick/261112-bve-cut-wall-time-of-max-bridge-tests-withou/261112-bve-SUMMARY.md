---
phase: quick-261112-bve
plan: 01
status: complete
subsystem: tests / max-bridge
tags: [tests, performance, max-bridge, virtual-time, xdist]
requires: [quick-261111-u3n]
provides:
  - "tools/max_bridge.py seams _monotonic, _sleep, _udp_socket (defaults: time.monotonic, time.sleep, AF_INET/SOCK_DGRAM)"
  - "tests/test_max_bridge.py VirtualClock, BarrierSocket, FakeBridge barrier + exit wake, _install_virtual_time, autouse _virtual_bridge_time"
affects: [tests/test_max_bridge.py, tests/test_max_verify_live.py, tests/conftest.py, tools/max_bridge.py]
tech-stack:
  added: []
  patterns: ["module-level clock/sleep/socket seams monkeypatched by an autouse fixture", "acked OSC barrier replaces waiting out socket timeouts"]
key-files:
  created: []
  modified: [tools/max_bridge.py, tests/test_max_bridge.py, tests/test_max_verify_live.py, tests/conftest.py]
decisions:
  - "Bridge waits against FakeBridge end at an acked test-only barrier and jump a virtual clock; only no-listener pings keep a (shorter) real timeout"
  - "TestNote::test_note_run is the one real-time test (slow marker, still runs by default)"
requirements: [BRT-01, BRT-02, BRT-03, BRT-04]
metrics:
  duration: "~7 min"
  completed: 2026-11-12
actuals:
  tokens: 4800
  tasks: 3
  commits: 2
plan_head_before: 9519b73b4277944859f228801ea7a0591c376885
plan_head_after: 317975d67f434ec88c2e5fd490b9e4c59cf04593
---

# Quick 261112-bve Plan 01: Cut wall time of MAX bridge tests Summary

The bridge tests now run the real Bridge code on a virtual clock: waits against FakeBridge end at an acked test-only OSC barrier instead of a real socket timeout. Serial time fell from 23.6 s to 4.6 s (bridge file) and from 12.7 s to 2.3 s (live file). No assert, test id, default or runtime behaviour changed.

## Before / after (BRT-04)

Serial, `--durations=0 -n 0 -q`, under `/usr/bin/time -p`. Base is 9519b73b, the after run is at 317975d6.

| File | Before pytest / wall | After pytest / wall | Tests |
|------|----------------------|---------------------|-------|
| tests/test_max_bridge.py | 23.63 s / 23.90 s | 4.58 s / 4.85 s | 147 -> 148 (+TestSeams) |
| tests/test_max_verify_live.py | 12.71 s / 12.94 s | 2.33 s / 2.56 s | 85 -> 85 |
| Both together, parallel (default `-n auto`) | 6.72 s / 6.88 s | 2.87 s / 3.82 s | 232 -> 233 |

The parallel "before" figure comes from a temp worktree of the base sha in the scratch dir, removed afterwards. Targets were < 8 s and < 5 s, and both are met. Of the remaining 4.6 s in the bridge file, 1.3 s is the slow-marked real-time test and 0.45 s is the numpy/scipy import.

Note: `-p no:xdist` fails with this pytest.ini (`addopts = -n auto` gives "unrecognized arguments: -n"). Use `-n 0` for serial runs.

## Tests over 0.3 s at baseline (BRT-01) and how each was fixed

| Before | Test | What it waited on | Fix | After |
|--------|------|-------------------|-----|-------|
| 3.43 | bridge TestCheck::test_leave_dsp_on | 3 check runs: settle collect 0.1 + record collect (0.2 + 0.5 tail) + `_wait_stable` 3x100 ms polls | virtual clock + barrier | 0.11 |
| 1.83 | bridge TestDspOnLoad::test_bridge_stops_answering | 1.5 s load-timeout ping on muted fake + 0.2 s test sleep | virtual clock + barrier; condition wait `_wait_until` | 0.06 |
| 1.61 | bridge TestCheck::test_bridge_stops_answering | 1.5 s load-timeout ping on muted fake | virtual clock + barrier (barrier acked while muted) | 0.03 |
| 1.45 | bridge TestRecordSampleRate::test_short_recording_end_to_end | record 0.5 + 0.5 tail, settle, `_wait_stable` | virtual clock + barrier | 0.04 |
| 1.42 | bridge TestSampleRateGuard::test_stale_max_rate_end_to_end | same, record 0.5 | virtual clock + barrier | 0.04 |
| 1.37 | bridge TestCheck::test_dsp_unknown | record-0.2 run + settle-only run | virtual clock + barrier | 0.07 |
| 1.32 | bridge TestNote::test_note_run | record 0.4 + tail, note-off collect 100 ms, settle, `_wait_stable`; asserts >= 80 ms real time note-on -> note-off | `@pytest.mark.slow`, real clock and socket (BRT-03) | 1.30 |
| 1.16 | bridge TestCheck::test_error_run | one record-0.2 run | virtual clock + barrier | 0.05 |
| 1.15 | bridge TestCheck::test_clean_run_and_order | one record-0.2 run | virtual clock + barrier | 0.04 |
| 1.15 | bridge TestRecordSampleRate::test_sr_changed_end_to_end | one record-0.2 run | virtual clock + barrier | 0.04 |
| 1.15 | bridge TestCheck::test_dsp_restore_when_on | one record-0.2 run | virtual clock + barrier | 0.04 |
| 1.11 | bridge TestSampleRateGuard::test_sr_guard_end_to_end | one record-0.2 run | virtual clock + barrier | 0.04 |
| 0.51 | bridge TestPing::test_ping_hint_names_toggle | 0.5 s ping timeout, port nobody reads | timeout 0.5 -> 0.05 (real) | 0.05 |
| 0.50 | bridge TestPing::test_no_listener_exit_2 | same | timeout 0.5 -> 0.05 (real); `< 1.5` bound kept | 0.05 |
| 0.44 | bridge TestAnalyze::test_sine | first numpy/scipy import (not a wait) | none needed: import cost, see below | 0.46 |
| 0.30 | bridge TestShoot::test_no_window | `_wait_window` SHOT_POLL polls to its 0.3 s timeout | virtual sleep | < 0.005 |
| 1.64 | live TestBatch::test_abort_on_first_bridge_failed | 1.5 s load-timeout ping on muted fake | virtual clock + barrier | 0.08 |
| 1.64 | live TestSkip::test_unknown_max_state_still_pings | record-0.2 run + first scipy import | virtual clock + barrier; remaining 0.5 s is import | 0.52 |
| 1.23 | live TestBatch::test_crash_is_a_warning | one record-0.2 run | virtual clock + barrier | 0.10 |
| 1.19 | live TestOpenOriginal::test_window_list_failure_is_a_note | one record-0.2 run | virtual clock + barrier | 0.08 |
| 1.17 | live TestRun::test_clean_run | one record-0.2 run | virtual clock + barrier | 0.09 |
| 1.17 | live TestOpenOriginal::test_other_titles_run | one record-0.2 run | virtual clock + barrier | 0.07 |
| 1.13 | live TestRun::test_error_run_blocker | one record-0.2 run | virtual clock + barrier | 0.07 |
| 0.31 | live TestFormatReport::test_main_prints_human_report | 0.3 s preflight ping, port nobody reads | timeout 0.3 -> 0.05 (real) | 0.05 |
| 0.30 | live TestSkip::test_nothing_listening | same | timeout 0.3 -> 0.05 (real) | 0.05 |

After the change, only three tests are over 0.3 s: test_note_run (slow, real time), test_sine and test_unknown_max_state_still_pings. The last two are the import cost explained in the next section.

## Import-cost evidence

From `Q/import-evidence.txt`. Each pair ran in one `-n 0 --durations=0` call, in command-line order:
- `TestAnalyze::test_dc` 0.44 s, then `TestAnalyze::test_sine` < 0.005 s (hidden).
- `TestRun::test_clean_run` 0.50 s, then `TestSkip::test_unknown_max_state_still_pings` 0.09 s.

Whichever test runs first pays the ~0.45 s numpy/scipy import. The tests themselves wait on nothing.

## Seams added (BRT-02)

In tools/max_bridge.py, right after `_RCVBUF`:
- `_monotonic = time.monotonic`: every deadline, `Bridge.t0` and `Bridge.now`.
- `_sleep = time.sleep`: every poll sleep (`_wait_window`, `wait_gone`, `_wait_file`, `_wait_stable`).
- `def _udp_socket()`: returns `socket.socket(AF_INET, SOCK_DGRAM)`, which `Bridge.__init__` uses.

All 22 clock/sleep call lines now go through the seams, with every argument unchanged. Nothing else in the module rebinds them, so production behaviour is the same as before. `TestSeams::test_production_defaults` pins the identities after `monkeypatch.undo()`. The gate below shows no constant, `add_argument` or `default=` line changed, and tools/max_verify_live.py is byte-identical to base.

Test harness:
- **FakeBridge** acks `/__test_barrier` with `/__test_barrier_ack`, even while muted, and never records it.
- **`FakeBridge.PORTS`** tracks the fakes that are running.
- **`__exit__`** wakes the receive loop with an empty datagram (the 0.05 s poll stays as the fallback).
- **`BarrierSocket`** wraps the Bridge's socket:
  - **Peer is a running fake:** a receive sends the barrier and buffers every reply until the matching ack. If anything is buffered, it returns the oldest packet. Otherwise it jumps the `VirtualClock` by the socket timeout and raises `socket.timeout`.
  - **Any other peer:** the real socket and a real timeout.
- **Autouse fixtures** install this in both files. The bridge file skips it for `slow` tests.

## Slow-marked test (BRT-03)

`TestNote::test_note_run` asserts at least 80 ms of real time between note-on and note-off at the fake. It now runs on the real clock and socket and serves as the suite's real-time end-to-end coverage of `collect`, `ping` and `_wait_stable`.

The `slow` marker is not deselected by default, so it still runs in every full-suite run. The marker help in conftest.py now lists "real-time bridge timing".

## Weakening gates and flake check

- Collected ids: every one of the 232 base ids is still collected. The only new id is `TestSeams::test_production_defaults`.
- No removed `assert` line in the diff of either test file against base. The only removed lines are the 4 timeout args, the 0.2 s sleep, one import line and the old marker help string.
- tools/max_verify_live.py: no diff.
- tools/max_bridge.py: no changed upper-case constant, `add_argument` or `default=` line. `TestCli::test_ping_defaults` and `TestCheck::test_check_defaults` pass.
- Parallel loop: 5/5 runs of both files passed (233 passed in 2.89-2.95 s each).
- Full suite `python3 -m pytest -q`: 7570 passed, 1 skipped, 4 xfailed, green before each commit and again at the end.

## Commits

- 72940635: test(261112-bve): virtual-time seams for max_bridge waits
- 317975d6: test(261112-bve): drop remaining real waits in bridge and live tests

## Deviations from Plan

**1. [Rule 3 - Blocking] Seam comments moved above the assignments**
- **Found during:** Task 1
- **Issue:** Trailing comments on `_monotonic = time.monotonic` / `_sleep = time.sleep` failed the plan's `^..$` grep gate.
- **Fix:** Moved each comment onto its own line above the assignment.
- **Commit:** 72940635

**2. Minor:** the FakeBridge receive loop still checks the stop flag at the top of each iteration (unchanged), so after `__exit__` at most the packet in flight is handled before the wake. This is the same draining semantics as before. Tests that need a post-run packet wait for it explicitly (`_wait_until`).

## Known Stubs

None.

## Self-Check: PASSED

- FOUND: tools/max_bridge.py (`def _udp_socket`), tests/test_max_bridge.py (`class BarrierSocket`), tests/test_max_verify_live.py (`_install_virtual_time`), tests/conftest.py (`real-time bridge timing` x2)
- FOUND: 72940635, 317975d6 (ancestors of HEAD)
