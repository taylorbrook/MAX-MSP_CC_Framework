---
phase: 15
slug: intelligent-editing
status: draft
nyquist_compliant: true
wave_0_complete: true
created: 2026-03-16
---

# Phase 15 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest 9.0.2 |
| **Config file** | pyproject.toml (project root) |
| **Quick run command** | `python3 -m pytest tests/test_patcher.py -x -q` |
| **Full suite command** | `python3 -m pytest tests/ -x -q` |
| **Estimated runtime** | ~5 seconds |

---

## Sampling Rate

- **After every task commit:** Run `python3 -m pytest tests/test_patcher.py tests/test_round_trip.py -x -q`
- **After every plan wave:** Run `python3 -m pytest tests/ -x -q`
- **Before `/gsd:verify-work`:** Full suite must be green
- **Max feedback latency:** 5 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|-----------|-------------------|-------------|--------|
| 15-01-00 | 01 | 1 | all | scaffold | `python3 -m pytest tests/test_patcher.py tests/test_round_trip.py --co -q` | Yes - W0 creates | ⬜ pending |
| 15-01-01 | 01 | 1 | ED-01 | unit | `python3 -m pytest tests/test_patcher.py -k "TestModifyBox" -x` | Yes - W0 shell | ⬜ pending |
| 15-01-02 | 01 | 1 | ED-01 | unit | `python3 -m pytest tests/test_patcher.py -k "test_modify_box_io_recompute" -x` | Yes - W0 shell | ⬜ pending |
| 15-01-03 | 01 | 1 | ED-01 | unit | `python3 -m pytest tests/test_patcher.py -k "test_modify_box_orphan" -x` | Yes - W0 shell | ⬜ pending |
| 15-01-04 | 01 | 1 | ED-01 | unit | `python3 -m pytest tests/test_round_trip.py -k "test_modify_preserves" -x` | Yes - W0 shell | ⬜ pending |
| 15-01-05 | 01 | 1 | ED-03 | unit | `python3 -m pytest tests/test_patcher.py -k "TestReplaceBox" -x` | Yes - W0 shell | ⬜ pending |
| 15-01-06 | 01 | 1 | ED-03 | unit | `python3 -m pytest tests/test_patcher.py -k "test_replace_orphans" -x` | Yes - W0 shell | ⬜ pending |
| 15-02-01 | 02 | 2 | ED-05 | unit | `python3 -m pytest tests/test_patcher.py -k "TestAutoPosition" -x` | Yes - W0 shell | ⬜ pending |
| 15-02-02 | 02 | 2 | ED-05 | unit | `python3 -m pytest tests/test_patcher.py -k "test_auto_position_grid" -x` | Yes - W0 shell | ⬜ pending |
| 15-02-03 | 02 | 2 | ED-05 | unit | `python3 -m pytest tests/test_patcher.py -k "test_collision_nudge" -x` | Yes - W0 shell | ⬜ pending |
| 15-02-04 | 02 | 2 | ED-02 | unit | `python3 -m pytest tests/test_patcher.py -k "TestInsertIntoConnection" -x` | Yes - W0 shell | ⬜ pending |
| 15-02-05 | 02 | 2 | ED-02 | unit | `python3 -m pytest tests/test_patcher.py -k "test_insert_stereo" -x` | Yes - W0 shell | ⬜ pending |
| 15-02-06 | 02 | 2 | ED-02 | unit | `python3 -m pytest tests/test_patcher.py -k "test_insert_position" -x` | Yes - W0 shell | ⬜ pending |
| 15-03-01 | 03 | 3 | ED-04 | unit | `python3 -m pytest tests/test_patcher.py -k "TestDownstream" -x` | Yes - W0 shell | ⬜ pending |
| 15-03-02 | 03 | 3 | ED-04 | unit | `python3 -m pytest tests/test_patcher.py -k "TestUpstream" -x` | Yes - W0 shell | ⬜ pending |
| 15-03-03 | 03 | 3 | ED-04 | unit | `python3 -m pytest tests/test_patcher.py -k "TestSignalPath" -x` | Yes - W0 shell | ⬜ pending |
| 15-03-04 | 03 | 3 | ED-04 | unit | `python3 -m pytest tests/test_patcher.py -k "TestConnectedComponents" -x` | Yes - W0 shell | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [x] `tests/test_patcher.py` — Plan 01 Task 0 creates TestModifyBox, TestReplaceBox, TestAutoPosition, TestInsertIntoConnection, TestDownstream, TestUpstream, TestSignalPath, TestConnectedComponents test class shells
- [x] `tests/test_round_trip.py` — Plan 01 Task 0 creates TestModifyPreservesRoundTrip shell
- [x] No framework install needed — pytest 9.0.2 already available

*Wave 0 is Task 0 in Plan 01. Shells created before any implementation tasks run.*

---

## Manual-Only Verifications

*All phase behaviors have automated verification.*

---

## Validation Sign-Off

- [x] All tasks have `<automated>` verify or Wave 0 dependencies
- [x] Sampling continuity: no 3 consecutive tasks without automated verify
- [x] Wave 0 covers all MISSING references
- [x] No watch-mode flags
- [x] Feedback latency < 5s
- [x] `nyquist_compliant: true` set in frontmatter

**Approval:** ready
