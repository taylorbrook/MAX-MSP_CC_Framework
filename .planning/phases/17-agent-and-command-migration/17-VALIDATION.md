---
phase: 17
slug: agent-and-command-migration
status: draft
nyquist_compliant: false
wave_0_complete: false
created: 2026-03-16
---

# Phase 17 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest 9.0.2 |
| **Config file** | pyproject.toml |
| **Quick run command** | `python3 -m pytest tests/test_commands.py tests/test_agent_skills.py tests/test_validation.py tests/test_project.py -x -q` |
| **Full suite command** | `python3 -m pytest tests/ -x -q` |
| **Estimated runtime** | ~15 seconds |

---

## Sampling Rate

- **After every task commit:** Run `python3 -m pytest tests/test_commands.py tests/test_agent_skills.py tests/test_validation.py tests/test_project.py -x -q`
- **After every plan wave:** Run `python3 -m pytest tests/ -x -q`
- **Before `/gsd:verify-work`:** Full suite must be green
- **Max feedback latency:** 15 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|-----------|-------------------|-------------|--------|
| 17-01-01 | 01 | 1 | MG-06 | unit | `python3 -m pytest tests/test_validation.py -x -q -k "unknown"` | Existing, needs update | ⬜ pending |
| 17-01-02 | 01 | 1 | MG-03 | unit | `python3 -m pytest tests/test_project.py -x -q -k "create"` | New test needed | ⬜ pending |
| 17-02-01 | 02 | 1 | MG-01 | unit | `python3 -m pytest tests/test_commands.py -x -q -k "build"` | Existing, needs update | ⬜ pending |
| 17-02-02 | 02 | 1 | MG-02 | unit | `python3 -m pytest tests/test_commands.py -x -q -k "iterate"` | Existing, needs update | ⬜ pending |
| 17-02-03 | 02 | 1 | MG-03 | unit | `python3 -m pytest tests/test_commands.py -x -q -k "new"` | Existing, needs update | ⬜ pending |
| 17-02-04 | 02 | 1 | MG-04 | unit | `python3 -m pytest tests/test_commands.py -x -q -k "onboard"` | New test needed | ⬜ pending |
| 17-03-01 | 03 | 2 | MG-05 | unit | `python3 -m pytest tests/test_agent_skills.py -x -q` | Existing, needs update | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `tests/test_commands.py` — add max-onboard to ALL_COMMANDS, add cross-reference tests for v2.0 API
- [ ] `tests/test_agent_skills.py` — add tests for editing API references in SKILL.md files
- [ ] `tests/test_validation.py` — update unknown object assertions from "error" to "warning"
- [ ] `tests/test_project.py` — add test for empty .maxpat creation in create_project

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| Empty .maxpat opens in MAX without errors | MG-03 | Requires MAX application | Open generated empty .maxpat in MAX 9, verify no error dialogs |
| /max-iterate analyze output is readable | MG-02 | Subjective quality check | Run /max-iterate on a test patch, review analysis summary |

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 15s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
