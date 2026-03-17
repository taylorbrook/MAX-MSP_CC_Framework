---
phase: 19
slug: tech-debt-cleanup
status: draft
nyquist_compliant: false
wave_0_complete: false
created: 2026-03-16
---

# Phase 19 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest 9.0.2 |
| **Config file** | none (defaults) |
| **Quick run command** | `python3 -m pytest tests/test_round_trip.py -x -q` |
| **Full suite command** | `python3 -m pytest -q` |
| **Estimated runtime** | ~15 seconds |

---

## Sampling Rate

- **After every task commit:** Run `python3 -m pytest tests/test_round_trip.py -x -q`
- **After every plan wave:** Run `python3 -m pytest -q`
- **Before `/gsd:verify-work`:** Full suite must be green
- **Max feedback latency:** 15 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|-----------|-------------------|-------------|--------|
| 19-01-01 | 01 | 1 | RW-02 (gap) | unit | `python3 -m pytest tests/test_round_trip.py::TestSubpatcherByteIdentity -x` | ❌ W0 | ⬜ pending |
| 19-01-02 | 01 | 1 | CL-05 (gap) | unit | `python3 -c "assert 'write_patch' not in open('src/maxpat/externals.py').read()"` | ✅ | ⬜ pending |
| 19-01-03 | 01 | 1 | CL-05 (gap) | manual | `test -f patches/rhythmic-sampler/generated/_fix2.py && echo FAIL \|\| echo PASS` | ✅ | ⬜ pending |
| 19-01-04 | 01 | 1 | RW-02 (gap) | regression | `python3 -m pytest -q` | ✅ | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `tests/test_round_trip.py::TestSubpatcherByteIdentity` — new test class for subpatcher byte-identical round-trip (RW-02 gap)

*New test class is created in same plan that implements the fix.*

---

## Manual-Only Verifications

*All phase behaviors have automated verification.*

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 15s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
