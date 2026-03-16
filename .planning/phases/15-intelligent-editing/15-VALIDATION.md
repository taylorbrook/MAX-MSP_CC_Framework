---
phase: 15
slug: intelligent-editing
status: draft
nyquist_compliant: false
wave_0_complete: false
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
| 15-01-01 | 01 | 1 | ED-01 | unit | `python3 -m pytest tests/test_patcher.py -k "TestModifyBox" -x` | No - W0 | ⬜ pending |
| 15-01-02 | 01 | 1 | ED-01 | unit | `python3 -m pytest tests/test_patcher.py -k "test_modify_box_io_recompute" -x` | No - W0 | ⬜ pending |
| 15-01-03 | 01 | 1 | ED-01 | unit | `python3 -m pytest tests/test_patcher.py -k "test_modify_box_orphan" -x` | No - W0 | ⬜ pending |
| 15-01-04 | 01 | 1 | ED-01 | unit | `python3 -m pytest tests/test_round_trip.py -k "test_modify_preserves" -x` | No - W0 | ⬜ pending |
| 15-02-01 | 02 | 1 | ED-02 | unit | `python3 -m pytest tests/test_patcher.py -k "TestInsert" -x` | No - W0 | ⬜ pending |
| 15-02-02 | 02 | 1 | ED-02 | unit | `python3 -m pytest tests/test_patcher.py -k "test_insert_stereo" -x` | No - W0 | ⬜ pending |
| 15-02-03 | 02 | 1 | ED-02 | unit | `python3 -m pytest tests/test_patcher.py -k "test_insert_position" -x` | No - W0 | ⬜ pending |
| 15-03-01 | 03 | 1 | ED-03 | unit | `python3 -m pytest tests/test_patcher.py -k "TestReplaceBox" -x` | No - W0 | ⬜ pending |
| 15-03-02 | 03 | 1 | ED-03 | unit | `python3 -m pytest tests/test_patcher.py -k "test_replace_orphans" -x` | No - W0 | ⬜ pending |
| 15-04-01 | 04 | 2 | ED-04 | unit | `python3 -m pytest tests/test_patcher.py -k "TestDownstream" -x` | No - W0 | ⬜ pending |
| 15-04-02 | 04 | 2 | ED-04 | unit | `python3 -m pytest tests/test_patcher.py -k "TestUpstream" -x` | No - W0 | ⬜ pending |
| 15-04-03 | 04 | 2 | ED-04 | unit | `python3 -m pytest tests/test_patcher.py -k "TestSignalPath" -x` | No - W0 | ⬜ pending |
| 15-04-04 | 04 | 2 | ED-04 | unit | `python3 -m pytest tests/test_patcher.py -k "TestConnectedComponents" -x` | No - W0 | ⬜ pending |
| 15-05-01 | 05 | 1 | ED-05 | unit | `python3 -m pytest tests/test_patcher.py -k "test_auto_position_grid" -x` | No - W0 | ⬜ pending |
| 15-05-02 | 05 | 1 | ED-05 | unit | `python3 -m pytest tests/test_patcher.py -k "test_collision_nudge" -x` | No - W0 | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `tests/test_patcher.py` — add TestModifyBox, TestInsert, TestReplaceBox, TestDownstream, TestUpstream, TestSignalPath, TestConnectedComponents, TestAutoPosition test classes
- [ ] `tests/test_round_trip.py` — add TestModifyPreservesRoundTrip for _raw sync verification
- [ ] No framework install needed — pytest 9.0.2 already available

*Existing infrastructure covers framework requirements.*

---

## Manual-Only Verifications

*All phase behaviors have automated verification.*

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 5s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
