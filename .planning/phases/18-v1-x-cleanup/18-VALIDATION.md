---
phase: 18
slug: v1-x-cleanup
status: draft
nyquist_compliant: false
wave_0_complete: false
created: 2026-03-16
---

# Phase 18 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest 9.0.2 |
| **Config file** | pyproject.toml (standard discovery) |
| **Quick run command** | `python3 -m pytest tests/ -x -q` |
| **Full suite command** | `python3 -m pytest tests/ -q` |
| **Estimated runtime** | ~9 seconds |

---

## Sampling Rate

- **After every task commit:** Run `python3 -m pytest tests/ -x -q`
- **After every plan wave:** Run `python3 -m pytest tests/ -q`
- **Before `/gsd:verify-work`:** Full suite must be green
- **Max feedback latency:** 9 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|-----------|-------------------|-------------|--------|
| 18-01-01 | 01 | 1 | CL-01 | smoke | `python3 -c "import src.maxpat; assert not hasattr(src.maxpat, 'Manifest')"` | Wave 0 | ⬜ pending |
| 18-01-02 | 01 | 1 | CL-02 | smoke | `test -z "$(find patches/ -name '*.manifest.json')"` | Wave 0 | ⬜ pending |
| 18-01-03 | 01 | 1 | CL-03 | smoke | `test -z "$(find patches/ -name 'generate.py' -o -name 'build_*.py' -o -name 'gen_*.py')"` | Wave 0 | ⬜ pending |
| 18-01-04 | 01 | 1 | CL-05 | smoke | `python3 -c "from src.maxpat import hooks; assert not hasattr(hooks, 'write_patch')"` | Wave 0 | ⬜ pending |
| 18-02-01 | 02 | 1 | CL-04 | unit+integration | `python3 -m pytest tests/ -q` | Existing | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

*Existing infrastructure covers all phase requirements. No new test files needed. The phase REMOVES tests rather than adding them.*

---

## Manual-Only Verifications

*All phase behaviors have automated verification.*

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 9s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
