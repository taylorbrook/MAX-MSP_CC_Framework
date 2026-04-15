---
phase: 25
slug: templates-and-critics
status: draft
nyquist_compliant: true
wave_0_complete: false
created: 2026-04-15
---

# Phase 25 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest 9.0.2 |
| **Config file** | pyproject.toml (implicit) |
| **Quick run command** | `python3 -m pytest tests/test_critics.py -x` |
| **Full suite command** | `python3 -m pytest tests/ -x` |
| **Estimated runtime** | ~25 seconds |

---

## Sampling Rate

- **After every task commit:** Run `python3 -m pytest tests/test_critics.py -x`
- **After every plan wave:** Run `python3 -m pytest tests/ -x`
- **Before `/gsd-verify-work`:** Full suite must be green
- **Max feedback latency:** 25 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Threat Ref | Secure Behavior | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|------------|-----------------|-----------|-------------------|-------------|--------|
| 25-01-01 | 01 | 1 | PKG-24, PKG-26 | T-25-02 | BFS uses visited set to prevent infinite loops | unit | `python3 -m pytest tests/test_critics.py -x -k "beap"` | ❌ W0 | ⬜ pending |
| 25-01-02 | 01 | 1 | PKG-24, PKG-26 | T-25-01 | .get() defaults for malformed patch input | unit | `python3 -m pytest tests/test_critics.py -x -k "bach or community"` | ❌ W0 | ⬜ pending |
| 25-02-01 | 02 | 2 | PKG-24 | T-25-04 | Single DB creation per review_patch() call | unit | `python3 -m pytest tests/test_critics.py -x -k "review_patch_includes_package or review_patch_no_packages"` | ❌ W0 | ⬜ pending |
| 25-02-02 | 02 | 2 | PKG-24 | T-25-05 | N/A (documentation) | grep-verify | `grep -q "review_packages" .claude/skills/max-critic/SKILL.md` | ✅ | ⬜ pending |
| 25-03-01 | 03 | 1 | PKG-23, PKG-25 | T-25-06 | N/A (documentation) | grep-verify | `grep -q "Package Workflow Templates" .claude/skills/max-dsp-agent/SKILL.md` | ✅ | ⬜ pending |
| 25-03-02 | 03 | 1 | PKG-23, PKG-25 | T-25-06 | N/A (documentation) | grep-verify | `grep -q "Package Workflow Templates" .claude/skills/max-patch-agent/SKILL.md` | ✅ | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `tests/test_critics.py` — add TestPackageCritic class with BEAP/Bach/community fixtures (file exists, class does not)
- [ ] Test fixtures for: BEAP patch without output termination, BEAP patch missing VCA, Bach patch with llll mismatch, clean BEAP/Bach patches
- [ ] Framework install: N/A (pytest already available)

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| Templates exist with connection tables, parameter ranges, gotchas | PKG-23 | Documentation structure, not executable code | `grep "Package Workflow Templates" .claude/skills/max-*/SKILL.md` returns matches in both DSP and patch agent |
| Lifecycle suggests templates on package selection | PKG-25 | Guidance text, not executable code | `grep "Template Suggestions" .claude/skills/max-lifecycle/SKILL.md` returns match |

---

## Validation Sign-Off

- [x] All tasks have `<automated>` verify or Wave 0 dependencies
- [x] Sampling continuity: no 3 consecutive tasks without automated verify
- [x] Wave 0 covers all MISSING references
- [x] No watch-mode flags
- [x] Feedback latency < 25s
- [x] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
