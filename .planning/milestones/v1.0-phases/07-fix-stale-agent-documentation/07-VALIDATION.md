---
phase: 7
slug: fix-stale-agent-documentation
status: draft
nyquist_compliant: false
wave_0_complete: false
created: 2026-03-10
---

# Phase 7 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest (standard) |
| **Config file** | none — uses default pytest discovery |
| **Quick run command** | `python -m pytest tests/test_agent_skills.py tests/test_commands.py -x -q` |
| **Full suite command** | `python -m pytest tests/ -x -q` |
| **Estimated runtime** | ~5 seconds |

---

## Sampling Rate

- **After every task commit:** Run `python -m pytest tests/test_agent_skills.py tests/test_commands.py -x -q`
- **After every plan wave:** Run `python -m pytest tests/ -x -q`
- **Before `/gsd:verify-work`:** Full suite must be green
- **Max feedback latency:** 5 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|-----------|-------------------|-------------|--------|
| 07-01-01 | 01 | 0 | DOC-01 | unit (text scan) | `pytest tests/test_commands.py::test_build_no_stub_labels -x` | ❌ W0 | ⬜ pending |
| 07-01-02 | 01 | 0 | DOC-02 | unit (text scan) | `pytest tests/test_agent_skills.py::test_dispatch_rules_no_stub_labels -x` | ❌ W0 | ⬜ pending |
| 07-01-03 | 01 | 0 | DOC-03 | unit (text scan) | `pytest tests/test_agent_skills.py::test_rnbo_validate_scope_documented -x` | ❌ W0 | ⬜ pending |
| 07-02-01 | 01 | 1 | DOC-01 | unit (text scan) | `pytest tests/test_commands.py::test_build_no_stub_labels -x` | ✅ W0 | ⬜ pending |
| 07-02-02 | 01 | 1 | DOC-02 | unit (text scan) | `pytest tests/test_agent_skills.py::test_dispatch_rules_no_stub_labels -x` | ✅ W0 | ⬜ pending |
| 07-02-03 | 01 | 1 | DOC-03 | unit (text scan) | `pytest tests/test_agent_skills.py::test_rnbo_validate_scope_documented -x` | ✅ W0 | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `tests/test_commands.py::test_build_no_stub_labels` — asserts max-build.md does not contain "stub" for RNBO/ext agents
- [ ] `tests/test_agent_skills.py::test_dispatch_rules_no_stub_labels` — asserts dispatch-rules.md does not contain "STUB" markers for RNBO/ext agents
- [ ] `tests/test_agent_skills.py::test_rnbo_validate_scope_documented` — asserts RNBO SKILL.md clarifies inner patcher scope for validate_rnbo_patch

---

## Manual-Only Verifications

*All phase behaviors have automated verification.*

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 5s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
