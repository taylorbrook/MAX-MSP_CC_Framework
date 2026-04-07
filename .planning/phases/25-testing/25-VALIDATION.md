---
phase: 25
slug: testing
status: draft
nyquist_compliant: false
wave_0_complete: false
created: 2026-04-07
---

# Phase 25 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest 9.0.2 |
| **Config file** | None (default discovery) |
| **Quick run command** | `python3 -m pytest tests/test_m4l_e2e.py -x -q` |
| **Full suite command** | `python3 -m pytest tests/test_m4l_*.py -x --tb=short -q` |
| **Estimated runtime** | ~5 seconds |

---

## Sampling Rate

- **After every task commit:** Run `python3 -m pytest tests/test_m4l_e2e.py -x -q`
- **After every plan wave:** Run `python3 -m pytest tests/test_m4l_*.py -x --tb=short -q`
- **Before `/gsd-verify-work`:** Full M4L suite must be green
- **Max feedback latency:** 10 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Threat Ref | Secure Behavior | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|------------|-----------------|-----------|-------------------|-------------|--------|
| 25-01-01 | 01 | 1 | TEST-01 | — | N/A | integration | `python3 -m pytest tests/test_m4l_e2e.py::TestAudioEffectE2E -x` | ❌ W0 | ⬜ pending |
| 25-01-02 | 01 | 1 | TEST-01 | — | N/A | integration | `python3 -m pytest tests/test_m4l_e2e.py::TestInstrumentE2E -x` | ❌ W0 | ⬜ pending |
| 25-01-03 | 01 | 1 | TEST-01 | — | N/A | integration | `python3 -m pytest tests/test_m4l_e2e.py::TestMidiEffectE2E -x` | ❌ W0 | ⬜ pending |
| 25-02-01 | 02 | 1 | TEST-01 | — | N/A | integration | `python3 -m pytest tests/test_m4l_e2e.py::TestViolationE2E -x` | ❌ W0 | ⬜ pending |
| 25-03-01 | 03 | 2 | TEST-01 | — | N/A | regression | `python3 -m pytest tests/test_m4l_*.py -x --tb=short -q` | ✅ | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `tests/test_m4l_e2e.py` — E2E test file (this phase creates it)

*Existing infrastructure (pytest, tmp_path, mock patterns) covers all other requirements.*

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
