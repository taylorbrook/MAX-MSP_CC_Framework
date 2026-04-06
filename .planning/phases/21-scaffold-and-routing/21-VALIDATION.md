---
phase: 21
slug: scaffold-and-routing
status: draft
nyquist_compliant: false
wave_0_complete: false
created: 2026-04-06
---

# Phase 21 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest 9.x |
| **Config file** | `pyproject.toml` |
| **Quick run command** | `python -m pytest tests/ -x -q` |
| **Full suite command** | `python -m pytest tests/ -v` |
| **Estimated runtime** | ~15 seconds |

---

## Sampling Rate

- **After every task commit:** Run `python -m pytest tests/ -x -q`
- **After every plan wave:** Run `python -m pytest tests/ -v`
- **Before `/gsd-verify-work`:** Full suite must be green
- **Max feedback latency:** 15 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Threat Ref | Secure Behavior | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|------------|-----------------|-----------|-------------------|-------------|--------|
| 21-01-01 | 01 | 1 | SCAFFOLD-01 | — | N/A | unit | `python -m pytest tests/test_m4l_scaffold.py -k audio_effect -v` | ❌ W0 | ⬜ pending |
| 21-01-02 | 01 | 1 | SCAFFOLD-02 | — | N/A | unit | `python -m pytest tests/test_m4l_scaffold.py -k instrument -v` | ❌ W0 | ⬜ pending |
| 21-01-03 | 01 | 1 | SCAFFOLD-03 | — | N/A | unit | `python -m pytest tests/test_m4l_scaffold.py -k midi_effect -v` | ❌ W0 | ⬜ pending |
| 21-01-04 | 01 | 1 | SCAFFOLD-04 | — | N/A | unit | `python -m pytest tests/test_m4l_scaffold.py -k parameter_enable -v` | ❌ W0 | ⬜ pending |
| 21-01-05 | 01 | 1 | SCAFFOLD-05 | — | N/A | unit | `python -m pytest tests/test_m4l_scaffold.py -k prefix -v` | ❌ W0 | ⬜ pending |
| 21-01-06 | 01 | 1 | SCAFFOLD-06 | — | N/A | unit | `python -m pytest tests/test_m4l_scaffold.py -k presentation -v` | ❌ W0 | ⬜ pending |
| 21-02-01 | 02 | 2 | ROUTING-01 | — | N/A | integration | `python -m pytest tests/test_m4l_routing.py -v` | ❌ W0 | ⬜ pending |
| 21-02-02 | 02 | 2 | ROUTING-03 | — | N/A | manual | Review SKILL.md files for M4L sections | ❌ | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `tests/test_m4l_scaffold.py` — stubs for SCAFFOLD-01 through SCAFFOLD-06
- [ ] `tests/test_m4l_routing.py` — stubs for ROUTING-01, ROUTING-03

*Existing test infrastructure (pytest, conftest) covers framework needs.*

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| Agent SKILL.md M4L sections | ROUTING-03 | Documentation content, not code | Grep each SKILL.md for M4L section header |

*All other behaviors have automated verification.*

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 15s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
