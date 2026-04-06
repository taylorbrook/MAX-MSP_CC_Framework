---
phase: 22
slug: validation-and-export
status: draft
nyquist_compliant: false
wave_0_complete: false
created: 2026-04-06
---

# Phase 22 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest 9.0.2 |
| **Config file** | pytest runs from repo root |
| **Quick run command** | `python3 -m pytest tests/test_m4l_critic.py tests/test_m4l_export.py -x -q` |
| **Full suite command** | `python3 -m pytest tests/ -x -q` |
| **Estimated runtime** | ~5 seconds |

---

## Sampling Rate

- **After every task commit:** Run `python3 -m pytest tests/test_m4l_critic.py tests/test_m4l_export.py -x -q`
- **After every plan wave:** Run `python3 -m pytest tests/ -x -q`
- **Before `/gsd-verify-work`:** Full suite must be green
- **Max feedback latency:** 10 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Threat Ref | Secure Behavior | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|------------|-----------------|-----------|-------------------|-------------|--------|
| 22-01-01 | 01 | 1 | VALID-01 | — | N/A | unit | `python3 -m pytest tests/test_m4l_critic.py::TestGainPlugout -x` | ❌ W0 | ⬜ pending |
| 22-01-02 | 01 | 1 | VALID-02 | — | N/A | unit | `python3 -m pytest tests/test_m4l_critic.py::TestDeviceCompleteness -x` | ❌ W0 | ⬜ pending |
| 22-01-03 | 01 | 1 | VALID-03 | — | N/A | unit | `python3 -m pytest tests/test_m4l_critic.py::TestParameterUniqueness -x` | ❌ W0 | ⬜ pending |
| 22-01-04 | 01 | 1 | SC#4 | — | N/A | unit | `python3 -m pytest tests/test_critics.py::TestReviewPatchM4L -x` | ❌ W0 | ⬜ pending |
| 22-01-05 | 01 | 1 | SC#6 | — | N/A | unit | `python3 -m pytest tests/test_m4l_critic.py::TestTerminalNames -x` | ❌ W0 | ⬜ pending |
| 22-02-01 | 02 | 1 | EXPORT-01 | — | N/A | unit | `python3 -m pytest tests/test_m4l_export.py -x` | ❌ W0 | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `tests/test_m4l_critic.py` — stubs for VALID-01, VALID-02, VALID-03, SC#4, SC#6
- [ ] `tests/test_m4l_export.py` — stubs for EXPORT-01

*Existing infrastructure covers framework — pytest already available.*

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| .amxd loads in Ableton Live | EXPORT-01 | Requires running Ableton | Open exported .amxd in Ableton, verify device loads without errors |

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 10s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
