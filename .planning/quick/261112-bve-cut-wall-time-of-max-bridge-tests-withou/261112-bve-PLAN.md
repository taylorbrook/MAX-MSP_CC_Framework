---
phase: quick-261112-bve
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - tools/max_bridge.py
  - tests/test_max_bridge.py
  - tests/test_max_verify_live.py
  - tests/conftest.py
autonomous: true
requirements: [BRT-01, BRT-02, BRT-03, BRT-04]

estimate:
  tokens: 70000
  raw_tokens: 70000
  tasks: 3
  confidence: low

must_haves:
  truths:
    - "tests/test_max_bridge.py and tests/test_max_verify_live.py pass serially (-n 0) and in parallel (default -n auto); all 232 baseline test node ids are still collected and no `assert` line was removed or edited"
    - "Serial wall time drops from 23.5 s to under 8 s for tests/test_max_bridge.py and from 12.7 s to under 5 s for tests/test_max_verify_live.py (targets; the SUMMARY records measured numbers)"
    - "Every test that took over 0.3 s at baseline takes 0.3 s or less afterwards, except TestNote::test_note_run (marked slow, genuinely real-time) and the first numpy/scipy import of a process (TestAnalyze::test_sine, TestSkip::test_unknown_max_state_still_pings), which the SUMMARY proves is import cost, not a wait"
    - "tools/max_bridge.py behaves exactly as before at runtime: its clock, sleep and socket seams default to time.monotonic, time.sleep and a real AF_INET/SOCK_DGRAM socket, and no module constant or CLI default changed; tools/max_verify_live.py is byte-identical"
    - "No socket wait against a FakeBridge depends on a short real timeout: those waits end at a barrier the fake acknowledges and the virtual clock jumps; only pings to ports nobody reads use shorter real timeouts"
    - "Five consecutive parallel runs of both files pass, and the full suite (`python3 -m pytest -q`) is green before every commit"
  artifacts:
    - path: tools/max_bridge.py
      provides: "module seams _monotonic, _sleep and _udp_socket, used by every wait in the module"
      contains: "def _udp_socket"
    - path: tests/test_max_bridge.py
      provides: "VirtualClock, BarrierSocket, the FakeBridge barrier and wake-on-exit, _install_virtual_time and an autouse fixture that skips slow-marked tests"
      contains: "class BarrierSocket"
    - path: tests/test_max_verify_live.py
      provides: "autouse fixture that installs the same virtual time"
      contains: "_install_virtual_time"
    - path: tests/conftest.py
      provides: "slow marker description that names real-time bridge timing"
      contains: "real-time bridge timing"
  key_links:
    - from: tests/test_max_bridge.py
      to: tools/max_bridge.py
      via: "monkeypatch of the module seams _monotonic, _sleep and _udp_socket"
      pattern: "monkeypatch.setattr\\(bridge, \"_udp_socket\""
    - from: tests/test_max_bridge.py BarrierSocket
      to: tests/test_max_bridge.py FakeBridge
      via: "a test-only OSC barrier the fake acknowledges, even while muted, without recording it"
      pattern: "BARRIER_ADDRESS"
    - from: tests/test_max_verify_live.py
      to: tests/test_max_bridge.py
      via: "imports _install_virtual_time with FakeBridge, _free_port and _tone_patch"
      pattern: "_install_virtual_time"
---

<objective>
Cut the wall time of tests/test_max_bridge.py (23.5 s serial) and tests/test_max_verify_live.py (12.7 s serial) without weakening them. Add a clock, sleep and socket seam to tools/max_bridge.py (defaults unchanged). The fast tests then run the real Bridge code against FakeBridge while every socket wait and poll sleep runs on a virtual clock. Only pings to ports nobody listens on get shorter real timeouts. The one test that measures real elapsed time gets the existing `slow` marker.

Requirement IDs (quick task):
- BRT-01: list every test over 0.3 s with what it waits on (baseline below; re-captured in Task 1).
- BRT-02: remove each real wait with a seam (or a shorter timeout where only "a timeout happened" matters). Runtime behaviour and default timeouts stay the same.
- BRT-03: anything that genuinely needs real time gets the existing `slow` marker.
- BRT-04: report before/after time per file; full suite green before commit.

Purpose: these two files are the slowest in the suite, and their waits are real socket and polling timeouts, not work.
Output: seams in tools/max_bridge.py, the virtual-time harness in tests/test_max_bridge.py, an autouse fixture in tests/test_max_verify_live.py, a marker description in tests/conftest.py, and the SUMMARY with before/after numbers.

Hard constraints from the user: the bridge's runtime behaviour and default timeouts must not change. Every existing assertion must still hold. Full suite green before commit.
</objective>

<execution_context>
@~/.claude/gsd-core/workflows/execute-plan.md
@~/.claude/gsd-core/templates/summary.md
</execution_context>

<context>
@.planning/STATE.md
@CLAUDE.md
@pytest.ini
@tests/conftest.py
@tools/max_bridge.py
@tests/test_max_bridge.py
@tests/test_max_verify_live.py

## Measuring (read first)

pytest.ini sets `addopts = -n auto`, so `-p no:xdist` fails with "unrecognized arguments: -n". Measure per file serially with `-n 0`. The quick dir is `.planning/quick/261112-bve-cut-wall-time-of-max-bridge-tests-withou/` (Q below; write every measurement file there).

## Baseline captured at planning (HEAD 489829ca, serial, `--durations=0 -n 0`)

tests/test_max_bridge.py: 147 passed in 23.48 s (wall 23.75 s). Tests over 0.3 s:

| s | test | what it waits on |
|---|------|------------------|
| 3.41 | TestCheck::test_leave_dsp_on | 3 check runs, each: settle collect 0.1 s + record collect (0.2 + 0.5 tail) + `_wait_stable` 3 polls 100 ms apart |
| 1.81 | TestDspOnLoad::test_bridge_stops_answering | load ping runs out its 1.5 s `--load-timeout` on the muted fake, then the test sleeps 0.2 s for the cleanup packets |
| 1.62 | TestCheck::test_bridge_stops_answering | load ping 1.5 s timeout on the muted fake |
| 1.42 | TestRecordSampleRate::test_short_recording_end_to_end | record 0.5 + 0.5 tail collect, settle, `_wait_stable` |
| 1.41 | TestSampleRateGuard::test_stale_max_rate_end_to_end | same, record 0.5 |
| 1.37 | TestCheck::test_dsp_unknown | one record-0.2 run + one settle-only run |
| 1.31 | TestNote::test_note_run | record 0.4 + tail, note-off collect at 100 ms, settle, `_wait_stable`; asserts the fake saw at least 0.08 s of real time between note-on and note-off |
| 1.15 | TestCheck::test_error_run | one record-0.2 run |
| 1.14 | TestCheck::test_dsp_restore_when_on | one record-0.2 run |
| 1.14 | TestCheck::test_clean_run_and_order | one record-0.2 run |
| 1.13 | TestRecordSampleRate::test_sr_changed_end_to_end | one record-0.2 run |
| 1.10 | TestSampleRateGuard::test_sr_guard_end_to_end | one record-0.2 run |
| 0.51 | TestPing::test_ping_hint_names_toggle | ping with a 0.5 s timeout to a port nobody reads |
| 0.50 | TestPing::test_no_listener_exit_2 | same |
| 0.45 | TestAnalyze::test_sine | first numpy/scipy import in the process, not a wait (test_dc takes 0.41 s when it runs first) |
| 0.30 | TestShoot::test_no_window | `_wait_window` polls every SHOT_POLL (0.01) until its 0.3 s timeout |

tests/test_max_verify_live.py: 85 passed in 12.68 s (wall 13.81 s). Tests over 0.3 s:

| s | test | what it waits on |
|---|------|------------------|
| 1.69 | TestSkip::test_unknown_max_state_still_pings | one record-0.2 check run (~1.1 s of waits) + the module's first scipy import (~0.5 s) |
| 1.64 | TestBatch::test_abort_on_first_bridge_failed | load ping 1.5 s timeout on the muted fake |
| 1.21 | TestBatch::test_crash_is_a_warning | one record-0.2 run (the second patch) |
| 1.18 | TestOpenOriginal::test_window_list_failure_is_a_note | one record-0.2 run |
| 1.18 | TestRun::test_clean_run | one record-0.2 run |
| 1.15 | TestOpenOriginal::test_other_titles_run | one record-0.2 run |
| 1.13 | TestRun::test_error_run_blocker | one record-0.2 run |
| 0.31 | TestFormatReport::test_main_prints_human_report | preflight ping with a 0.3 s timeout to a port nobody reads |
| 0.30 | TestSkip::test_nothing_listening | same |

Under 0.3 s but carrying the same waits (they speed up as a side effect): the settle-only runs (TestCheck::test_feedback_cap, TestDspOnLoad::*, TestDspOnLoadEndToEnd::*, TestResolution::test_project_runs_top_level_only / test_active_project_pointer_is_used). Every FakeBridge exit also blocks up to 50 ms: the fake's loop polls with a 0.05 s socket timeout before it sees the stop flag (22 fakes in the bridge file, 16 in the live file).

## Where the waits live

All in tools/max_bridge.py; tools/max_verify_live.py has no wait of its own: it delegates everything to `bridge.run_check` and `bridge.Bridge.ping`, and `_max_running` is faked in its tests. So it needs no seam and stays byte-identical.
- `Bridge.__init__` (t0 and the socket creation), `now`, `_recv` (socket timeout = deadline minus clock), `collect`, `ping`: lines ~236-345.
- `_wait_window`, `wait_gone`: lines ~806-839 (poll sleeps SHOT_POLL / SHOT_LOAD_SETTLE).
- `_wait_file` (0.05 s polls), `_wait_stable` (3 reads 100 ms apart): lines ~976-996.
- `_execute` (lines ~1158-1240) calls `b.collect(args.settle)`, `b.collect(record + 0.5 - elapsed)` before `/sf 0`, the note-off collect, `b.ping(args.load_timeout)` after the opener, and `_wait_stable` after the ping that follows `/sf 0`.
- There are 22 call lines of the real clock or the real sleep in the module (baseline of the Task 1 grep gate).

## Why this ordering is deterministic

FakeBridge handles packets one at a time on one thread and replies in order, so every reply to packet N reaches the client before the reply to packet N+1. The existing tests already rely on this: a `/pong` arrives after every event the earlier packets caused. A test-only barrier packet sent on the Bridge's own socket therefore returns its ack after every pending reply. "Nothing more will arrive" is then known exactly, and the wait can be skipped by jumping a virtual clock by the time the Bridge would have blocked. The Bridge code (collect, ping, `_recv`, now, `_execute`'s timing arithmetic) runs unchanged; only the OS-level block is replaced.
</context>

<tasks>

<task type="tracer">
  <name>Task 1: Clock/sleep/socket seams in max_bridge + virtual-time harness, proven on the bridge file</name>
  <files>tools/max_bridge.py, tests/test_max_bridge.py</files>
  <read_first>tools/max_bridge.py lines 74-120, 225-346, 800-867, 970-1000, 1158-1240; tests/test_max_bridge.py lines 1-185, 505-550, 1059-1140, 1440-1470</read_first>
  <behavior>
    - TestSeams::test_production_defaults: after `monkeypatch.undo()` (which removes the autouse virtual time), `bridge._monotonic is time.monotonic`, `bridge._sleep is time.sleep`, and `bridge._udp_socket()` returns a socket with family AF_INET and type SOCK_DGRAM (closed in a finally).
    - Every existing test in tests/test_max_bridge.py passes unchanged, under the virtual time except TestNote::test_note_run (slow, real time).
    - TestCheck::test_clean_run_and_order, TestCheck::test_leave_dsp_on and TestCheck::test_bridge_stops_answering each take 0.3 s or less (serial).
  </behavior>
  <action>
Step 0 (baseline, before any edit, BRT-01). Write `git rev-parse HEAD` to Q/base-sha.txt. Write the sorted collected node ids of both files to Q/collect-before.txt (`--collect-only -q -n 0`, keep only lines containing `::`; expect 232). Run each file serially under `/usr/bin/time -p` with `--durations=0 -n 0 -q`, output to Q/baseline-bridge.txt and Q/baseline-live.txt. Compare with the planning baseline in <context> and note any drift.

Step 1, the seams in tools/max_bridge.py (BRT-02; no behaviour change):
- Add a short "Test seams" block next to the module constants (after `_RCVBUF`). It defines `_monotonic` bound to the real `time.monotonic` and `_sleep` bound to the real `time.sleep`, plus a function `_udp_socket()` that returns a new `socket.socket(socket.AF_INET, socket.SOCK_DGRAM)`. Give each a one-line comment or docstring: every clock read, poll sleep and the Bridge socket in this module go through it so tests can run waits on a virtual clock, and production uses the real functions.
- Route every clock read and sleep in the module through the seams: all 22 lines that call `time.monotonic` or `time.sleep` (Bridge t0, now, `_recv`, collect, ping; `_wait_window`, `wait_gone`, `_wait_file`, `_wait_stable`). Keep each argument exactly as it is (SHOT_POLL, SHOT_LOAD_SETTLE, `min(0.25, SHOT_POLL)`, 0.05, 0.1). `Bridge.__init__` creates its socket with `_udp_socket()`.
- Keep `import time` (the seams need it). Change no constant, default, CLI flag, message text or control flow. Do not write the parenthesised call form of the real clock or sleep in any comment or docstring, because the Task 1 gate greps for it.

Step 2, the harness in tests/test_max_bridge.py (test code only):
- Module constants: BARRIER_ADDRESS `/__test_barrier`, BARRIER_ACK `/__test_barrier_ack`, BARRIER_WAIT 5.0 (a real-seconds safety net that passing runs never reach).
- FakeBridge: add a class-level set PORTS of live fake ports. `__enter__` adds `self.port` before starting the thread, and `__exit__` discards it. In `_run`, right after decoding and before the packet is appended to `received`/`times` and before the mute check, answer a BARRIER_ADDRESS packet with BARRIER_ACK carrying the same arguments, then continue. Barriers are never recorded and are answered even when muted. Update the docstring bullet list to say so.
- VirtualClock: holds an `offset` (starts at 0.0). Calling it returns the real `time.monotonic` plus offset. `advance(seconds)` adds `max(0.0, seconds)` to offset, and `sleep` is the same method.
- BarrierSocket(real_sock, clock) wraps the socket the Bridge would have used:
  - `__getattr__` delegates to the real socket (setsockopt, bind, getsockname, close).
  - `settimeout` only stores the timeout.
  - `sendto` remembers the destination as the peer and forwards.
  - `recvfrom(bufsize)` works in four steps:
    (a) Return the oldest buffered packet if any.
    (b) If no peer yet, or the peer port is not in FakeBridge.PORTS, pass through: apply the stored timeout to the real socket and do a real recvfrom. The "nobody listens" ports use this real path.
    (c) Otherwise send BARRIER_ADDRESS with a fresh sequence int straight on the real socket (the peer stays unchanged), then read with a BARRIER_WAIT timeout until the matching ack. Buffer every other packet raw, including undecodable ones; drop stale acks. On a real timeout, raise AssertionError naming the port.
    (d) If anything was buffered, return the oldest. Otherwise advance the clock by the stored timeout (0 if none) and raise `socket.timeout`. Bridge._recv then returns None exactly as after a real block of that length.
- `_install_virtual_time(monkeypatch)` returns a new VirtualClock. It first captures the current `bridge._udp_socket`, then monkeypatches `bridge._monotonic` to the clock, `bridge._sleep` to `clock.sleep`, and `bridge._udp_socket` to a lambda that wraps a fresh captured-factory socket in BarrierSocket.
- Autouse fixture `_virtual_bridge_time(request, monkeypatch)`: return None (real time) when `request.node.get_closest_marker("slow")` is set; otherwise return `_install_virtual_time(monkeypatch)`.
- Add `@pytest.mark.slow` to TestNote::test_note_run, with a one-line comment: it asserts at least 80 ms of real time between note-on and note-off at the fake, so it runs on the real clock and socket (BRT-03). It is the suite's real-time end-to-end coverage of collect, ping and `_wait_stable`.
- Add class TestSeams with test_production_defaults as in <behavior>.
- Keep the fast_shot fixture, test arguments and every assert line as they are. Stage only the two files by path; never `git add -A`, never `git stash` (CLAUDE.md Rule #7).

Commit only after `python3 -m pytest -q` (full suite, parallel default) is green.
  </action>
  <verify>
    <automated>python3 -m pytest tests/test_max_bridge.py -n 0 -q --durations=0 > .planning/quick/261112-bve-cut-wall-time-of-max-bridge-tests-withou/t1-bridge.txt 2>&1 && tail -3 .planning/quick/261112-bve-cut-wall-time-of-max-bridge-tests-withou/t1-bridge.txt && awk '$2=="call" && $1+0>0.3 && $3!~/TestAnalyze::test_sine|TestNote::test_note_run|TestPing::/ {print; bad=1} END {exit bad}' .planning/quick/261112-bve-cut-wall-time-of-max-bridge-tests-withou/t1-bridge.txt && [ "$(grep -v '^[[:space:]]*#' tools/max_bridge.py | grep -cE 'time\.(monotonic|sleep)\(')" = 0 ] && grep -qE '^_monotonic = time\.monotonic$' tools/max_bridge.py && grep -qE '^_sleep = time\.sleep$' tools/max_bridge.py && grep -q '^def _udp_socket' tools/max_bridge.py && grep -n 'pytest.mark.slow' tests/test_max_bridge.py && grep -q 'class BarrierSocket' tests/test_max_bridge.py</automated>
  </verify>
  <done>Q/base-sha.txt, Q/collect-before.txt (232 ids), Q/baseline-bridge.txt and Q/baseline-live.txt exist. tools/max_bridge.py routes all 22 clock/sleep call lines and the Bridge socket through `_monotonic`, `_sleep` and `_udp_socket` (grep baselines at HEAD: 22 / 0 / 0, now 0 / 2 / 1). tests/test_max_bridge.py passes serially; no call is over 0.3 s except test_sine (import), test_note_run (slow) and the two TestPing no-listener tests (Task 2). TestSeams::test_production_defaults passes. Full suite green, committed.</done>
</task>

<task type="auto">
  <name>Task 2: Remaining real waits: no-listener timeouts, cleanup sleep, fake exit, verify_live fixture</name>
  <files>tests/test_max_bridge.py, tests/test_max_verify_live.py, tests/conftest.py</files>
  <read_first>tests/test_max_bridge.py (FakeBridge, TestPing, TestDspOnLoad::test_bridge_stops_answering); tests/test_max_verify_live.py lines 1-60, 365-410, 780-790; tests/conftest.py lines 1-40</read_first>
  <action>
1. Ports nobody reads (BRT-02, "only a timeout happened"). `_free_port()` keeps the socket bound and unread, so the only possible outcome is a timeout and a shorter real wait cannot flake. These tests also keep BarrierSocket's real passthrough path (a real socket timeout) covered in the fast suite. Change the timeout argument from 0.5 to 0.05 in TestPing::test_no_listener_exit_2 and TestPing::test_ping_hint_names_toggle (tests/test_max_bridge.py). Change it from 0.3 to 0.05 in TestSkip::test_nothing_listening and TestFormatReport::test_main_prints_human_report (tests/test_max_verify_live.py). Leave every assert as is, including the `< 1.5` elapsed bound.
2. TestDspOnLoad::test_bridge_stops_answering: replace the 0.2 s real `time.sleep` call (and its comment) with a condition wait. Add a module helper `_wait_until(predicate, timeout=2.0)` that polls every 5 ms on the real clock until the predicate holds or the real deadline passes, and returns the predicate's last value. Call it inside the `with` block for `("/dsp", [0]) in fb.received`. Its comment says it lets the fake receive the fire-and-forget cleanup. The existing asserts below stay unchanged.
3. FakeBridge exit wake. `__exit__` sets the stop flag, then sends one zero-length datagram from a throwaway UDP socket to `("127.0.0.1", self.port)` and closes that socket, then joins as now. In `_run`, an empty datagram is checked before decoding, because decoding an empty packet raises: return when the stop flag is set, otherwise ignore it. Packets queued before the wake are still handled first. The 0.05 s socket timeout loop stays as the fallback.
4. tests/test_max_verify_live.py: import `_install_virtual_time` next to FakeBridge, `_free_port` and `_tone_patch`. Add an autouse fixture `_virtual_bridge_time(monkeypatch)` that returns `_install_virtual_time(monkeypatch)`; this file has no real-time test. Do not import the bridge file's autouse fixture by name.
5. tests/conftest.py: in both the module docstring line and the registered `slow` marker help, extend the parenthesised list to read "release archive build, full repo smoke sweep, real-time bridge timing" (BRT-03). Leave the marker name and the deselect hint as they are.

Commit only after `python3 -m pytest -q` (full suite, parallel default) is green. Stage these three files by path.
  </action>
  <verify>
    <automated>python3 -m pytest tests/test_max_bridge.py -n 0 -q --durations=0 > .planning/quick/261112-bve-cut-wall-time-of-max-bridge-tests-withou/t2-bridge.txt 2>&1 && python3 -m pytest tests/test_max_verify_live.py -n 0 -q --durations=0 > .planning/quick/261112-bve-cut-wall-time-of-max-bridge-tests-withou/t2-live.txt 2>&1 && awk '$2=="call" && $1+0>0.3 && $3!~/TestAnalyze::test_sine|TestNote::test_note_run/ {print; bad=1} END {exit bad}' .planning/quick/261112-bve-cut-wall-time-of-max-bridge-tests-withou/t2-bridge.txt && awk '$2=="call" && $1+0>0.3 && $3!~/TestSkip::test_unknown_max_state_still_pings/ {print; bad=1} END {exit bad}' .planning/quick/261112-bve-cut-wall-time-of-max-bridge-tests-withou/t2-live.txt && [ "$(cat tests/test_max_bridge.py tests/test_max_verify_live.py | grep -cE '"--timeout", "0\.(5|3)"')" = 0 ] && [ "$(grep -v '^[[:space:]]*#' tests/test_max_bridge.py | grep -c 'time\.sleep(0\.2)')" = 0 ] && [ "$(grep -c '_install_virtual_time' tests/test_max_verify_live.py)" -ge 2 ] && [ "$(grep -c 'real-time bridge timing' tests/conftest.py)" -ge 2 ]</automated>
  </verify>
  <done>Both files pass serially. No call is over 0.3 s except the import-cost tests (test_sine, test_unknown_max_state_still_pings) and the slow test_note_run. Grep gates vs HEAD baselines: no 0.5/0.3 timeout args (was 4), no 0.2 s sleep in the bridge tests (was 1), `_install_virtual_time` in the live file (was 0), marker text twice in conftest (was 0). Full suite green, committed.</done>
</task>

<task type="auto">
  <name>Task 3: Prove nothing weakened or flaky; report before/after</name>
  <files>.planning/quick/261112-bve-cut-wall-time-of-max-bridge-tests-withou/261112-bve-SUMMARY.md</files>
  <read_first>Q/baseline-bridge.txt, Q/baseline-live.txt, Q/t2-bridge.txt, Q/t2-live.txt, Q/base-sha.txt</read_first>
  <action>
1. After timings (BRT-04): run each file serially under `/usr/bin/time -p` with `--durations=0 -n 0 -q` into Q/after-bridge.txt and Q/after-live.txt. Also run both files together in parallel (default addopts) once under `/usr/bin/time -p` into Q/after-parallel.txt, and the same command at the base commit for a parallel before figure. Use a temp worktree of the base sha in the scratch dir, removed afterwards; never stash.
2. Import-cost evidence: run `tests/test_max_bridge.py::TestAnalyze::test_dc` before `::TestAnalyze::test_sine`, and `tests/test_max_verify_live.py::TestRun::test_clean_run` before `::TestSkip::test_unknown_max_state_still_pings`, each pair in one `-n 0 --durations=0` invocation (pytest keeps command-line order). Show that the second test of each pair is 0.3 s or less once the first has paid the numpy/scipy import. Save to Q/import-evidence.txt.
3. Flake check: run both files together with the default parallel addopts 5 times in a row. All 5 must pass; append each tail line to Q/par-loop.txt.
4. Weakening gates, all against the sha in Q/base-sha.txt:
   (a) The collected ids of both files, sorted, contain every line of Q/collect-before.txt (`comm -23` empty; one new id, TestSeams::test_production_defaults, is expected).
   (b) The `-U0` diff of the two test files has no removed line that starts with optional whitespace then `assert`.
   (c) tools/max_verify_live.py has no diff.
   (d) The diff of tools/max_bridge.py has no added or removed line that assigns an upper-case module constant, and no added or removed line containing `add_argument` or `default=`.
   (e) TestCli::test_ping_defaults and TestCheck::test_check_defaults pass.
5. Full suite `python3 -m pytest -q` green.
6. Write the SUMMARY:
   - Per-file before/after (pytest time and wall, serial) and the parallel before/after for the two files together.
   - The full baseline over-0.3 s table with what each test waited on, how it was fixed (virtual clock + barrier, shorter no-listener timeout, condition wait, or slow marker) and its after time.
   - The import-cost evidence, the seams added (names, defaults, why behaviour is unchanged) and the slow-marked test with its reason.
   - The flake-loop result. Note that `-p no:xdist` does not work with this pytest.ini (use `-n 0`).
  </action>
  <verify>
    <automated>Q=.planning/quick/261112-bve-cut-wall-time-of-max-bridge-tests-withou; B=$(cat $Q/base-sha.txt) && python3 -m pytest tests/test_max_bridge.py tests/test_max_verify_live.py --collect-only -q -n 0 > $Q/collect-after-raw.txt 2>&1 && grep '::' $Q/collect-after-raw.txt | sort > $Q/collect-after.txt && [ -z "$(comm -23 $Q/collect-before.txt $Q/collect-after.txt)" ] && DT=$(git diff -U0 $B -- tests/test_max_bridge.py tests/test_max_verify_live.py) && [ "$(printf '%s\n' "$DT" | grep -cE '^-[[:space:]]*assert')" = 0 ] && git diff --quiet $B -- tools/max_verify_live.py && DB=$(git diff -U0 $B -- tools/max_bridge.py) && [ "$(printf '%s\n' "$DB" | grep -cE '^[-+][A-Z][A-Z0-9_]* = |^[-+].*(add_argument|default=)')" = 0 ] && python3 -m pytest "tests/test_max_bridge.py::TestCli::test_ping_defaults" "tests/test_max_bridge.py::TestCheck::test_check_defaults" -n 0 -q && for i in 1 2 3 4 5; do python3 -m pytest tests/test_max_bridge.py tests/test_max_verify_live.py -q > $Q/par-$i.txt 2>&1 || exit 1; tail -1 $Q/par-$i.txt >> $Q/par-loop.txt; done && python3 -m pytest -q > $Q/full-suite.txt 2>&1 && tail -1 $Q/full-suite.txt && test -f $Q/261112-bve-SUMMARY.md</automated>
  </verify>
  <done>The SUMMARY reports the before/after per file (serial pytest time and wall) and the parallel before/after. It carries the over-0.3 s table with waits, fixes and after times, plus the import-cost evidence and the 5/5 parallel loop. Every weakening gate passes: no test id lost, no assert line removed, tools/max_verify_live.py unchanged, no bridge constant or CLI default touched. The full suite is green.</done>
</task>

</tasks>

<threat_model>
## Trust Boundaries

| Boundary | Description |
|----------|-------------|
| test harness -> 127.0.0.1 UDP | FakeBridge and the Bridge exchange OSC on loopback only; no MAX, no LAN |
| test seams -> production code | module attributes in tools/max_bridge.py that tests monkeypatch |

## STRIDE Threat Register

| Threat ID | Category | Component | Severity | Disposition | Mitigation Plan |
|-----------|----------|-----------|----------|-------------|-----------------|
| T-261112-bve-01 | Tampering | tools/max_bridge.py seams | medium | mitigate | Defaults are the real `time.monotonic`, `time.sleep` and an AF_INET/SOCK_DGRAM socket. TestSeams::test_production_defaults asserts identity; Task 3 gates prove no constant, CLI default or tools/max_verify_live.py change |
| T-261112-bve-02 | Denial of service | test suite (flaky waits under xdist) | medium | mitigate | Waits against a fake end at an acked barrier (ordering, not timing). The short real timeouts are only on ports nobody reads (outcome is always a timeout). 5x parallel loop in Task 3 |
| T-261112-bve-03 | Repudiation | weakened tests passing silently | medium | mitigate | Task 3 gates: no collected id lost, no `assert` line removed in the diff vs the base sha; the real-time path stays covered by the slow-marked test_note_run |
| T-261112-bve-04 | Information disclosure | BarrierSocket on a reserved port | low | accept | Loopback-only test packets with no payload beyond a sequence int |
| T-261112-bve-SC | Tampering | npm/pip/cargo installs | high | accept | No package is installed by this plan (stdlib + existing pytest-xdist only); the legitimacy gate is not triggered |
</threat_model>

<verification>
- Serial: `python3 -m pytest tests/test_max_bridge.py -n 0 -q` and `python3 -m pytest tests/test_max_verify_live.py -n 0 -q` pass; per-file times recorded before and after.
- Parallel: both files pass 5 times in a row under the default `-n auto`.
- Full suite `python3 -m pytest -q` green before each of the task commits.
- No weakening: the Task 3 gates (ids, asserts, verify_live unchanged, no constant/CLI-default change, default tests pass).
</verification>

<success_criteria>
- tests/test_max_bridge.py serial time under 8 s (from 23.5 s); tests/test_max_verify_live.py under 5 s (from 12.7 s).
- No test over 0.3 s except test_note_run (slow, real time) and the proven first-import tests.
- The bridge's runtime behaviour and defaults are unchanged; every existing assertion holds.
- The SUMMARY has the before/after per file and the over-0.3 s list with what each waited on.
</success_criteria>

<output>
Create `.planning/quick/261112-bve-cut-wall-time-of-max-bridge-tests-withou/261112-bve-SUMMARY.md` when done
</output>
