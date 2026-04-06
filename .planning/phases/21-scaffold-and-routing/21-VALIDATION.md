---
phase: 21
slug: scaffold-and-routing
status: draft
nyquist_compliant: true
wave_0_complete: false
created: 2026-04-06
---

# Phase 21 -- Validation Strategy

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
| 21-01-01 | 01 | 1 | SCAFFOLD-01 | -- | N/A | unit | `python -m pytest tests/test_m4l_scaffold.py -k audio_effect -v` | W0 | pending |
| 21-01-02 | 01 | 1 | SCAFFOLD-02 | -- | N/A | unit | `python -m pytest tests/test_m4l_scaffold.py -k instrument -v` | W0 | pending |
| 21-01-03 | 01 | 1 | SCAFFOLD-03 | -- | N/A | unit | `python -m pytest tests/test_m4l_scaffold.py -k midi_effect -v` | W0 | pending |
| 21-01-04 | 01 | 1 | SCAFFOLD-04 | -- | N/A | unit | `python -m pytest tests/test_m4l_scaffold.py -k parameter_enable -v` | W0 | pending |
| 21-01-05 | 01 | 1 | SCAFFOLD-05 | -- | N/A | unit | `python -m pytest tests/test_m4l_scaffold.py -k prefix -v` | W0 | pending |
| 21-01-06 | 01 | 1 | SCAFFOLD-06 | -- | N/A | unit | `python -m pytest tests/test_m4l_scaffold.py -k presentation -v` | W0 | pending |
| 21-02-01 | 02 | 1 | ROUTING-01 | -- | N/A | grep | `grep "M4L Dispatch" .claude/skills/max-router/references/dispatch-rules.md` | N/A | pending |
| 21-02-02 | 02 | 1 | ROUTING-03 | -- | N/A | grep | `grep -l "M4L" .claude/skills/max-dsp-agent/SKILL.md .claude/skills/max-patch-agent/SKILL.md .claude/skills/max-ui-agent/SKILL.md .claude/skills/max-critic/SKILL.md` | N/A | pending |

*Status: pending / green / red / flaky*

---

## Wave 0 Requirements

- [ ] `tests/test_m4l_scaffold.py` -- stubs for SCAFFOLD-01 through SCAFFOLD-06

*Plan 02 (ROUTING-01, ROUTING-03) is documentation-only; verification is grep-based, no test file needed.*

*Existing test infrastructure (pytest, conftest) covers framework needs.*

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| Agent SKILL.md M4L sections | ROUTING-03 | Documentation content, not code | Grep each SKILL.md for M4L section header |

*All other behaviors have automated verification.*

---

## Validation Sign-Off

- [x] All tasks have `<automated>` verify or Wave 0 dependencies
- [x] Sampling continuity: no 3 consecutive tasks without automated verify
- [x] Wave 0 covers all MISSING references
- [x] No watch-mode flags
- [x] Feedback latency < 15s
- [x] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
