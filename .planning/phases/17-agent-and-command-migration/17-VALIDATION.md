---
phase: 17
slug: agent-and-command-migration
status: approved
nyquist_compliant: true
wave_0_complete: true
created: 2026-03-16
audited: 2026-04-08
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
| 17-01-01 | 01 | 1 | MG-06 | unit | `python3 -m pytest tests/test_validation.py -x -q -k "unknown"` | ✅ | ✅ green |
| 17-01-02 | 01 | 1 | MG-03 | unit | `python3 -m pytest tests/test_project.py -x -q -k "create"` | ✅ | ✅ green |
| 17-02-01 | 02 | 1 | MG-01 | unit | `python3 -m pytest tests/test_commands.py -x -q -k "build"` | ✅ | ✅ green |
| 17-02-02 | 02 | 1 | MG-02 | unit | `python3 -m pytest tests/test_commands.py -x -q -k "iterate"` | ✅ | ✅ green |
| 17-02-03 | 02 | 1 | MG-03 | unit | `python3 -m pytest tests/test_commands.py -x -q -k "new"` | ✅ | ✅ green |
| 17-02-04 | 02 | 1 | MG-04 | unit | `python3 -m pytest tests/test_commands.py -x -q -k "onboard"` | ✅ | ✅ green |
| 17-03-01 | 03 | 2 | MG-05 | unit | `python3 -m pytest tests/test_agent_skills.py -x -q` | ✅ | ✅ green |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [x] `tests/test_commands.py` — add max-onboard to ALL_COMMANDS, add cross-reference tests for v2.0 API
- [x] `tests/test_agent_skills.py` — add tests for editing API references in SKILL.md files
- [x] `tests/test_validation.py` — update unknown object assertions from "error" to "warning"
- [x] `tests/test_project.py` — add test for empty .maxpat creation in create_project

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| Empty .maxpat opens in MAX without errors | MG-03 | Requires MAX application | Open generated empty .maxpat in MAX 9, verify no error dialogs |
| /max-iterate analyze output is readable | MG-02 | Subjective quality check | Run /max-iterate on a test patch, review analysis summary |

---

## Validation Audit 2026-04-08

| Metric | Count |
|--------|-------|
| Gaps found | 0 |
| Resolved | 0 |
| Escalated | 0 |

All 7 tasks have automated verification. 324 tests pass across 4 test files.

---

## Validation Sign-Off

- [x] All tasks have `<automated>` verify or Wave 0 dependencies
- [x] Sampling continuity: no 3 consecutive tasks without automated verify
- [x] Wave 0 covers all MISSING references
- [x] No watch-mode flags
- [x] Feedback latency < 15s
- [x] `nyquist_compliant: true` set in frontmatter

**Approval:** approved 2026-04-08
