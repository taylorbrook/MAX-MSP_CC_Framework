---
phase: 4
slug: agent-system-and-orchestration
status: draft
nyquist_compliant: false
wave_0_complete: false
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

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|-----------|-------------------|-------------|--------|
| 04-01-01 | 01 | 0 | AGT-03 | unit | `python -m pytest tests/test_critics.py -x` | ❌ W0 | ⬜ pending |
| 04-01-02 | 01 | 0 | AGT-06 | unit | `python -m pytest tests/test_memory.py -x` | ❌ W0 | ⬜ pending |
| 04-01-03 | 01 | 0 | FRM-01 | unit | `python -m pytest tests/test_project.py -x` | ❌ W0 | ⬜ pending |
| 04-01-04 | 01 | 0 | FRM-02 | unit | `python -m pytest tests/test_commands.py -x` | ❌ W0 | ⬜ pending |
| 04-01-05 | 01 | 0 | AGT-01 | unit | `python -m pytest tests/test_agent_skills.py -x` | ❌ W0 | ⬜ pending |
| 04-01-06 | 01 | 0 | FRM-06 | unit | `python -m pytest tests/test_testing.py -x` | ❌ W0 | ⬜ pending |
| 04-XX-XX | XX | 1 | AGT-01 | unit | `python -m pytest tests/test_agent_skills.py -x` | ❌ W0 | ⬜ pending |
| 04-XX-XX | XX | 1 | AGT-02 | unit | `python -m pytest tests/test_agent_skills.py::test_ui_agent -x` | ❌ W0 | ⬜ pending |
| 04-XX-XX | XX | 1 | AGT-03 | unit | `python -m pytest tests/test_critics.py::test_critic_loop -x` | ❌ W0 | ⬜ pending |
| 04-XX-XX | XX | 1 | AGT-04 | unit | `python -m pytest tests/test_critics.py::test_dsp_critic -x` | ❌ W0 | ⬜ pending |
| 04-XX-XX | XX | 1 | AGT-05 | unit | `python -m pytest tests/test_critics.py::test_structure_critic -x` | ❌ W0 | ⬜ pending |
| 04-XX-XX | XX | 2 | AGT-06 | unit | `python -m pytest tests/test_memory.py -x` | ❌ W0 | ⬜ pending |
| 04-XX-XX | XX | 2 | AGT-07 | unit | `python -m pytest tests/test_memory.py::test_dedup -x` | ❌ W0 | ⬜ pending |
| 04-XX-XX | XX | 3 | FRM-01 | unit | `python -m pytest tests/test_project.py::test_create -x` | ❌ W0 | ⬜ pending |
| 04-XX-XX | XX | 3 | FRM-02 | unit | `python -m pytest tests/test_commands.py -x` | ❌ W0 | ⬜ pending |
| 04-XX-XX | XX | 3 | FRM-03 | unit | `python -m pytest tests/test_project.py::test_status -x` | ❌ W0 | ⬜ pending |
| 04-XX-XX | XX | 3 | FRM-06 | unit | `python -m pytest tests/test_testing.py -x` | ❌ W0 | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `tests/test_critics.py` — stubs for AGT-03, AGT-04, AGT-05
- [ ] `tests/test_memory.py` — stubs for AGT-06, AGT-07
- [ ] `tests/test_project.py` — stubs for FRM-01, FRM-03
- [ ] `tests/test_commands.py` — stubs for FRM-02
- [ ] `tests/test_agent_skills.py` — stubs for AGT-01, AGT-02
- [ ] `tests/test_testing.py` — stubs for FRM-06
- [ ] `src/maxpat/critics/__init__.py` — critic package init

*All test files are Wave 0 -- none exist yet.*

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| Slash commands launch correct agents in Claude Code | FRM-02 | Requires Claude Code runtime | 1. Run `/max:build "simple synth"` 2. Verify agent dispatches to Patch + DSP agents 3. Verify output generated |
| Agent memory persists across sessions | AGT-06 | Requires session restart | 1. Generate a patch 2. Close session 3. Open new session 4. Run `/max:memory` 5. Verify pattern stored |
| Critic feedback feels semantic not lint-like | AGT-03 | Subjective quality | 1. Generate patch with issues 2. Review critic output 3. Verify feedback is architectural/semantic |

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 15s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
