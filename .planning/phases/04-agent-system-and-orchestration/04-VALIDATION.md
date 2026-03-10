---
phase: 4
slug: agent-system-and-orchestration
status: draft
nyquist_compliant: true
wave_0_complete: true
created: 2026-03-09
---

# Phase 4 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest (no config file -- run from project root) |
| **Config file** | none -- see Wave 0 |
| **Quick run command** | `python -m pytest tests/ -x -q` |
| **Full suite command** | `python -m pytest tests/ -v` |
| **Estimated runtime** | ~15 seconds |

---

## Sampling Rate

- **After every task commit:** Run `python -m pytest tests/ -x -q`
- **After every plan wave:** Run `python -m pytest tests/ -v`
- **Before `/gsd:verify-work`:** Full suite must be green
- **Max feedback latency:** 15 seconds

---

## Wave 0 Strategy

Wave 0 test files are created **inline by TDD tasks** in Plans 01, 02, and 03. Each TDD task writes tests FIRST (RED phase), then implements (GREEN phase). No separate Wave 0 plan is needed because:

- Plan 01 (critics): Creates `tests/test_critics.py` as part of TDD Tasks 1-2
- Plan 02 (memory): Creates `tests/test_memory.py` as part of TDD Tasks 1-2
- Plan 03 (project/testing): Creates `tests/test_project.py` and `tests/test_testing.py` as part of TDD Tasks 1-2
- Plan 05 (agent skills): Creates `tests/test_agent_skills.py` in Task 2
- Plan 06 (commands): Creates `tests/test_commands.py` in Task 2

All test files are authored before their corresponding production code within each plan's TDD cycle.

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|-----------|-------------------|-------------|--------|
| 04-01-T1 | 01 | 1 | AGT-03,04,05 | unit (TDD) | `python -m pytest tests/test_critics.py -x` | inline TDD | pending |
| 04-01-T2 | 01 | 1 | AGT-03,04,05 | unit (TDD) | `python -m pytest tests/test_critics.py -x` | inline TDD | pending |
| 04-02-T1 | 02 | 1 | AGT-06,07 | unit (TDD) | `python -m pytest tests/test_memory.py -x` | inline TDD | pending |
| 04-02-T2 | 02 | 1 | AGT-07 | unit (TDD) | `python -m pytest tests/test_memory.py -x` | inline TDD | pending |
| 04-03-T1 | 03 | 1 | FRM-01,03 | unit (TDD) | `python -m pytest tests/test_project.py -x` | inline TDD | pending |
| 04-03-T2 | 03 | 1 | FRM-06 | unit (TDD) | `python -m pytest tests/test_testing.py -x` | inline TDD | pending |
| 04-04-T1 | 04 | 2 | AGT-01,02 | structure | frontmatter grep check | N/A (markdown) | pending |
| 04-05-T1 | 05 | 2 | AGT-01,03 | structure | frontmatter grep check | N/A (markdown) | pending |
| 04-05-T2 | 05 | 2 | AGT-01 | unit | `python -m pytest tests/test_agent_skills.py -x` | inline | pending |
| 04-06-T1 | 06 | 3 | FRM-02 | structure | ls existence check | N/A (markdown) | pending |
| 04-06-T2 | 06 | 3 | FRM-02 | unit | `python -m pytest tests/test_commands.py -x` | inline | pending |

*Status: pending | green | red | flaky*

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| Slash commands launch correct agents in Claude Code | FRM-02 | Requires Claude Code runtime | 1. Run `/max:build "simple synth"` 2. Verify agent dispatches to Patch + DSP agents 3. Verify output generated |
| Agent memory persists across sessions | AGT-06 | Requires session restart | 1. Generate a patch 2. Close session 3. Open new session 4. Run `/max:memory` 5. Verify pattern stored |
| Critic feedback feels semantic not lint-like | AGT-03 | Subjective quality | 1. Generate patch with issues 2. Review critic output 3. Verify feedback is architectural/semantic |

---

## Validation Sign-Off

- [x] All tasks have `<automated>` verify or Wave 0 dependencies
- [x] Sampling continuity: no 3 consecutive tasks without automated verify
- [x] Wave 0 covers all MISSING references (handled inline by TDD plans)
- [x] No watch-mode flags
- [x] Feedback latency < 15s
- [x] `nyquist_compliant: true` set in frontmatter

**Approval:** approved
