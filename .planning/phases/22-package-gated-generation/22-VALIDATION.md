---
phase: 22
slug: package-gated-generation
status: draft
nyquist_compliant: false
wave_0_complete: false
created: 2026-04-14
---

# Phase 22 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest 9.x |
| **Config file** | `tests/conftest.py` |
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
| 22-01-01 | 01 | 1 | PKG-09 | — | N/A | unit | `python -m pytest tests/test_package_schema.py -x -q` | ⬜ W0 | ⬜ pending |
| 22-01-02 | 01 | 1 | PKG-10 | — | N/A | unit | `python -m pytest tests/test_package_schema.py -x -q` | ⬜ W0 | ⬜ pending |
| 22-02-01 | 02 | 1 | PKG-11 | — | N/A | integration | `python -m pytest tests/ -x -q` | ⬜ W0 | ⬜ pending |
| 22-02-02 | 02 | 1 | PKG-12 | — | N/A | integration | `python -m pytest tests/ -x -q` | ⬜ W0 | ⬜ pending |
| 22-03-01 | 03 | 2 | PKG-13 | — | N/A | integration | `python -m pytest tests/ -x -q` | ⬜ W0 | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] Test stubs for package config and gating behavior
- [ ] Shared fixtures for project config test data

*Existing infrastructure covers most phase requirements.*

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| `/max-new` presents package selection | PKG-09 | Skill invocation requires interactive session | Run `/max-new`, verify bundled/community package groups appear |
| `/max-build` blocks without config | PKG-11 | Skill invocation requires interactive session | Run `/max-build` without config.json, verify block message |

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 15s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
