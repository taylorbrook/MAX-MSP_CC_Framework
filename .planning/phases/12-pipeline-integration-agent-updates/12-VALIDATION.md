---
phase: 12
slug: pipeline-integration-agent-updates
status: draft
nyquist_compliant: false
wave_0_complete: false
created: 2026-03-13
---

# Phase 12 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest 9.0.2 |
| **Config file** | none (defaults) |
| **Quick run command** | `python3 -m pytest tests/ -x --tb=short -q` |
| **Full suite command** | `python3 -m pytest tests/ --tb=short -q` |
| **Estimated runtime** | ~30 seconds |

---

## Sampling Rate

- **After every task commit:** Run `python3 -m pytest tests/ -x --tb=short -q`
- **After every plan wave:** Run `python3 -m pytest tests/ --tb=short -q`
- **Before `/gsd:verify-work`:** Full suite must be green
- **Max feedback latency:** 30 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|-----------|-------------------|-------------|--------|
| 12-01-01 | 01 | 1 | AGNT-02 | unit | `python3 -m pytest tests/test_generation.py -x` | Existing file, new tests needed | ⬜ pending |
| 12-01-02 | 01 | 1 | AGNT-02 | unit | `python3 -m pytest tests/test_generation.py -x` | Existing file, new tests needed | ⬜ pending |
| 12-01-03 | 01 | 1 | AGNT-02 | unit | `python3 -m pytest tests/test_generation.py -x` | Existing file, new tests needed | ⬜ pending |
| 12-01-04 | 01 | 1 | AGNT-02 | unit | `python3 -m pytest tests/test_hooks.py -x` | Existing file, new tests needed | ⬜ pending |
| 12-02-01 | 02 | 2 | AGNT-01 | unit | `python3 -m pytest tests/test_agent_skills.py -x` | Existing file, new tests needed | ⬜ pending |
| 12-02-02 | 02 | 2 | AGNT-02 | unit | `python3 -m pytest tests/test_agent_skills.py -x` | Existing file, new tests needed | ⬜ pending |
| REGRESS | -- | -- | -- | regression | `python3 -m pytest tests/ -x --tb=short -q` | All existing | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

Existing infrastructure covers all phase requirements. New tests will be added to existing test files (`test_generation.py`, `test_agent_skills.py`, `test_hooks.py`).

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| SKILL.md aesthetic sections are readable and accurate | AGNT-02 | Documentation quality is subjective | Read each SKILL.md aesthetic section for clarity and completeness |

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 30s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
