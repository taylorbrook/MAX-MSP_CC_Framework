---
phase: 6
slug: fix-skill-documentation-signatures
status: draft
nyquist_compliant: false
wave_0_complete: false
created: 2026-03-10
---

# Phase 6 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest (installed) |
| **Config file** | None explicit (uses default discovery) |
| **Quick run command** | `python3 -m pytest tests/test_agent_skills.py -x -q` |
| **Full suite command** | `python3 -m pytest tests/ -x -q` |
| **Estimated runtime** | ~5 seconds |

---

## Sampling Rate

- **After every task commit:** Run `python3 -m pytest tests/test_agent_skills.py -x -q`
- **After every plan wave:** Run `python3 -m pytest tests/ -x -q`
- **Before `/gsd:verify-work`:** Full suite must be green
- **Max feedback latency:** 5 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|-----------|-------------------|-------------|--------|
| 06-01-01 | 01 | 1 | DOC-SIG-01a | unit | `python3 -m pytest tests/test_agent_skills.py -x -q -k "patch"` | Partial | ⬜ pending |
| 06-01-02 | 01 | 1 | DOC-SIG-01b | unit | `python3 -m pytest tests/test_agent_skills.py -x -q -k "patch"` | Partial | ⬜ pending |
| 06-01-03 | 01 | 1 | DOC-SIG-01c | unit | `python3 -m pytest tests/test_agent_skills.py -x -q -k "dsp"` | Partial | ⬜ pending |
| 06-01-04 | 01 | 1 | DOC-SIG-01d | unit | `python3 -m pytest tests/test_agent_skills.py -x -q -k "dsp"` | Partial | ⬜ pending |
| 06-01-05 | 01 | 1 | DOC-SIG-01e | unit | `python3 -m pytest tests/test_agent_skills.py -x -q -k "dsp"` | Partial | ⬜ pending |
| 06-01-06 | 01 | 1 | DOC-SIG-01f | unit | `python3 -m pytest tests/test_agent_skills.py -x -q -k "js"` | No | ⬜ pending |
| 06-01-07 | 01 | 1 | DOC-SIG-01g | unit | `python3 -m pytest tests/test_agent_skills.py -x -q -k "js"` | No | ⬜ pending |
| 06-01-08 | 01 | 1 | DOC-SIG-01h | unit | `python3 -m pytest tests/test_commands.py -x -q` | Needs verification | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] Add signature-accuracy tests to `tests/test_agent_skills.py` — verify SKILL.md files contain correct function signatures
- [ ] Verify `tests/test_commands.py` covers import path accuracy for max-verify.md

*If none: "Existing infrastructure covers all phase requirements."*

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| *None* | — | — | — |

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
