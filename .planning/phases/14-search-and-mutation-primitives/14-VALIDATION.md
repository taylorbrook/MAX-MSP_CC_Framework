---
phase: 14
slug: search-and-mutation-primitives
status: draft
nyquist_compliant: false
wave_0_complete: false
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
| 14-01-01 | 01 | 1 | RW-07 | unit | `python3 -m pytest tests/test_patcher.py -x -k "find_box"` | ❌ W0 | ⬜ pending |
| 14-01-02 | 01 | 1 | RW-07 | unit | `python3 -m pytest tests/test_patcher.py -x -k "find_boxes"` | ❌ W0 | ⬜ pending |
| 14-02-01 | 02 | 1 | RW-03 | unit | `python3 -m pytest tests/test_patcher.py -x -k "add_box"` | Partial | ⬜ pending |
| 14-02-02 | 02 | 1 | RW-04 | unit | `python3 -m pytest tests/test_patcher.py -x -k "remove_box"` | ❌ W0 | ⬜ pending |
| 14-02-03 | 02 | 1 | RW-05 | unit | `python3 -m pytest tests/test_patcher.py -x -k "connection"` | Partial | ⬜ pending |
| 14-03-01 | 03 | 1 | RW-07+RW-03 | unit | `python3 -m pytest tests/test_hooks.py -x -k "read_patch"` | ❌ W0 | ⬜ pending |
| 14-03-02 | 03 | 1 | RW-02+RW-03 | integration | `python3 -m pytest tests/test_round_trip.py -x` | ❌ W0 | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `tests/test_patcher.py` — new test classes: `TestFindBox`, `TestFindBoxes`, `TestRemoveBox`, `TestRemoveConnection`, `TestAddConnectionBoundsCheck`, `TestAddBoxOnLoadedPatch`
- [ ] `tests/test_hooks.py` — new test class: `TestReadPatch`
- [ ] `tests/test_round_trip.py` — new test class: `TestMutationPreservesRoundTrip` (add box to loaded patch, verify existing boxes unchanged)

*Existing infrastructure covers framework/fixture needs.*

---

## Manual-Only Verifications

*All phase behaviors have automated verification.*

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 10s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
