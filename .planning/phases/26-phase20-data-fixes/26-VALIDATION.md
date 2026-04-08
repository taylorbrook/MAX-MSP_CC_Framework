---
phase: 26
slug: phase20-data-fixes
status: draft
nyquist_compliant: false
wave_0_complete: false
created: 2026-04-07
---

# Phase 26 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest 9.0.2 |
| **Config file** | pyproject.toml |
| **Quick run command** | `python3 -m pytest tests/test_m4l_db.py tests/test_m4l_detection.py -x -q` |
| **Full suite command** | `python3 -m pytest tests/ -x -q` |
| **Estimated runtime** | ~15 seconds |

---

## Sampling Rate

- **After every task commit:** Run `python3 -m pytest tests/test_m4l_db.py tests/test_m4l_detection.py -x -q`
- **After every plan wave:** Run `python3 -m pytest tests/ -x -q`
- **Before `/gsd-verify-work`:** Full suite must be green
- **Max feedback latency:** 15 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Threat Ref | Secure Behavior | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|------------|-----------------|-----------|-------------------|-------------|--------|
| 26-01-01 | 01 | 1 | DB-02 | — | N/A | unit | `python3 -m pytest tests/test_m4l_db.py -x -q` | ✅ | ⬜ pending |
| 26-01-02 | 01 | 1 | DB-03 | — | N/A | unit | `python3 -m pytest tests/test_m4l_db.py -x -q` | ✅ | ⬜ pending |
| 26-01-03 | 01 | 1 | DB-01 | — | N/A | unit | `python3 -m pytest tests/test_m4l_db.py -x -q` | ✅ | ⬜ pending |
| 26-02-01 | 02 | 1 | VALID-04 | — | N/A | unit | `python3 -m pytest tests/test_m4l_detection.py -x -q` | ✅ | ⬜ pending |
| 26-03-01 | 03 | 2 | DB-04 | — | N/A | inline | `python3 -c "from src.maxpat.m4l_constants import ParamType, UnitStyle, ModMode, ParamVisibility"` | ✅ | ⬜ pending |
| 26-03-02 | 03 | 2 | VALID-05 | — | N/A | unit | `python3 -m pytest tests/test_m4l_critic.py -x -q` | ✅ | ⬜ pending |
| 26-03-03 | 03 | 2 | ROUTING-02 | — | N/A | manual-only | Grep CLAUDE.md for M4L section | N/A | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

Existing infrastructure covers all phase requirements. `test_m4l_db.py` and `test_m4l_detection.py` already exist.

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| CLAUDE.md M4L rules section | ROUTING-02 | Documentation content, not testable code | `grep "### M4L" CLAUDE.md` must return a match |

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 15s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
