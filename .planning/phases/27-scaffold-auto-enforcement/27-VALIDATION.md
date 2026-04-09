---
phase: 27
slug: scaffold-auto-enforcement
status: complete
nyquist_compliant: true
wave_0_complete: true
created: 2026-04-08
---

# Phase 27 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest 9.0.2 |
| **Config file** | pyproject.toml |
| **Quick run command** | `python3 -m pytest tests/test_m4l_polish.py -x -q` |
| **Full suite command** | `python3 -m pytest tests/ -x -q` |
| **Estimated runtime** | ~5 seconds |

---

## Sampling Rate

- **After every task commit:** Run `python3 -m pytest tests/test_m4l_polish.py -x -q`
- **After every plan wave:** Run `python3 -m pytest tests/ -x -q`
- **Before `/gsd-verify-work`:** Full suite must be green
- **Max feedback latency:** 5 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Threat Ref | Secure Behavior | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|------------|-----------------|-----------|-------------------|-------------|--------|
| 27-01-01 | 01 | 1 | SCAFFOLD-04 | — | N/A | unit | `python3 -m pytest tests/test_m4l_polish.py::TestParameterEnableEnforcement -x` | ✅ | ✅ green |
| 27-01-02 | 01 | 1 | SCAFFOLD-04 | — | N/A | unit | `python3 -m pytest tests/test_m4l_polish.py::TestParameterEnableEnforcement::test_creates_saved_attribute_attributes -x` | ✅ | ✅ green |
| 27-01-03 | 01 | 1 | SCAFFOLD-04 | — | N/A | unit | `python3 -m pytest tests/test_m4l_polish.py::TestParameterEnableEnforcement::test_skips_non_param -x` | ✅ | ✅ green |
| 27-01-04 | 01 | 1 | SCAFFOLD-04 | — | N/A | unit | `python3 -m pytest tests/test_m4l_polish.py::TestParameterEnableEnforcement::test_idempotent -x` | ✅ | ✅ green |
| 27-02-01 | 02 | 1 | SCAFFOLD-05 | — | N/A | unit | `python3 -m pytest tests/test_m4l_polish.py::TestM4LPrefixEnforcement -x` | ✅ | ✅ green |
| 27-02-02 | 02 | 1 | SCAFFOLD-05 | — | N/A | unit | `python3 -m pytest tests/test_m4l_polish.py::TestM4LPrefixEnforcement::test_skips_hash_sub -x` | ✅ | ✅ green |
| 27-02-03 | 02 | 1 | SCAFFOLD-05 | — | N/A | unit | `python3 -m pytest tests/test_m4l_polish.py::TestM4LPrefixEnforcement::test_idempotent -x` | ✅ | ✅ green |
| 27-03-01 | 03 | 1 | SCAFFOLD-04+05 | — | N/A | integration | `python3 -m pytest tests/test_m4l_polish.py::TestEnforcementIntegration -x` | ✅ | ✅ green |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

Existing infrastructure covers all phase requirements. New test classes added to existing `tests/test_m4l_polish.py`.

---

## Manual-Only Verifications

All phase behaviors have automated verification.

---

## Validation Sign-Off

- [x] All tasks have `<automated>` verify or Wave 0 dependencies
- [x] Sampling continuity: no 3 consecutive tasks without automated verify
- [x] Wave 0 covers all MISSING references
- [x] No watch-mode flags
- [x] Feedback latency < 5s
- [x] `nyquist_compliant: true` set in frontmatter

**Approval:** approved (2026-04-08)
