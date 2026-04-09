---
phase: 14
slug: search-and-mutation-primitives
status: complete
nyquist_compliant: true
wave_0_complete: true
created: 2026-03-16
---

# Phase 14 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest 9.0.2 |
| **Config file** | pyproject.toml or implicit discovery |
| **Quick run command** | `python3 -m pytest tests/test_patcher.py tests/test_round_trip.py tests/test_hooks.py -x -q` |
| **Full suite command** | `python3 -m pytest tests/ -q` |
| **Estimated runtime** | ~5 seconds |

---

## Sampling Rate

- **After every task commit:** Run `python3 -m pytest tests/test_patcher.py tests/test_round_trip.py tests/test_hooks.py -x -q`
- **After every plan wave:** Run `python3 -m pytest tests/ -q`
- **Before `/gsd:verify-work`:** Full suite must be green
- **Max feedback latency:** 10 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|-----------|-------------------|-------------|--------|
| 14-01-01 | 01 | 1 | RW-07 | unit | `python3 -m pytest tests/test_patcher.py -x -k "TestFindBox"` | ✅ 13 tests | ✅ green |
| 14-01-02 | 01 | 1 | RW-07 | unit | `python3 -m pytest tests/test_patcher.py -x -k "TestFindBoxes"` | ✅ 7 tests | ✅ green |
| 14-02-01 | 02 | 1 | RW-03 | unit | `python3 -m pytest tests/test_patcher.py -x -k "Duplicate"` | ✅ 3 tests | ✅ green |
| 14-02-02 | 02 | 1 | RW-04 | unit | `python3 -m pytest tests/test_patcher.py -x -k "RemoveBox"` | ✅ 6 tests | ✅ green |
| 14-02-03 | 02 | 1 | RW-05 | unit | `python3 -m pytest tests/test_patcher.py -x -k "RemoveConnection or BoundsCheck"` | ✅ 14 tests | ✅ green |
| 14-03-01 | 03 | 1 | RW-07+RW-03 | unit | `python3 -m pytest tests/test_hooks.py -x -k "ReadPatch"` | ✅ 10 tests | ✅ green |
| 14-03-02 | 03 | 1 | RW-02+RW-03 | integration | `python3 -m pytest tests/test_round_trip.py -x -k "Mutation"` | ✅ 5 tests | ✅ green |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [x] `tests/test_patcher.py` — test classes: `TestFindBox` (13), `TestFindBoxes` (7), `TestRemoveBox` (6), `TestRemoveConnection` (4), `TestAddConnectionBoundsCheck` (10), `TestDuplicateConnectionPrevention` (3)
- [x] `tests/test_hooks.py` — test class: `TestReadPatch` (10)
- [x] `tests/test_round_trip.py` — test class: `TestMutationPreservesRoundTrip` (5)

*All 58 tests passing. Coverage complete.*

---

## Manual-Only Verifications

*All phase behaviors have automated verification.*

---

## Validation Sign-Off

- [x] All tasks have `<automated>` verify or Wave 0 dependencies
- [x] Sampling continuity: no 3 consecutive tasks without automated verify
- [x] Wave 0 covers all MISSING references
- [x] No watch-mode flags
- [x] Feedback latency < 10s
- [x] `nyquist_compliant: true` set in frontmatter

**Approval:** complete

---

## Validation Audit 2026-04-08

| Metric | Count |
|--------|-------|
| Gaps found | 0 |
| Resolved | 0 |
| Escalated | 0 |

All 7 task requirements mapped to 58 automated tests across 3 test files. All green.
