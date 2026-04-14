---
phase: 23
slug: agent-package-intelligence
status: draft
nyquist_compliant: false
wave_0_complete: false
created: 2026-04-14
---

# Phase 23 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest 9.0.2 |
| **Config file** | `pyproject.toml` |
| **Quick run command** | `python3 -m pytest tests/test_sizing.py tests/test_layout.py tests/test_package_schema.py -x -q` |
| **Full suite command** | `python3 -m pytest tests/ -x -q` |
| **Estimated runtime** | ~15 seconds |

---

## Sampling Rate

- **After every task commit:** Run `python3 -m pytest tests/test_sizing.py tests/test_layout.py tests/test_package_schema.py -x -q`
- **After every plan wave:** Run `python3 -m pytest tests/ -x -q`
- **Before `/gsd-verify-work`:** Full suite must be green
- **Max feedback latency:** 15s

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|-----------|-------------------|-------------|--------|
| 23-01-01 | 01 | 1 | PKG-17 | unit | `python3 -m pytest tests/test_sizing.py -x -q` | ✅ (needs new tests) | ⬜ pending |
| 23-01-02 | 01 | 1 | PKG-17 | unit | `python3 -m pytest tests/test_layout.py -x -q` | ✅ (needs new tests) | ⬜ pending |
| 23-02-01 | 02 | 1 | PKG-15 | content | `python3 -m pytest tests/test_package_schema.py -x -q` | ✅ (needs new tests) | ⬜ pending |
| 23-02-02 | 02 | 1 | PKG-16 | schema | `python3 -m pytest tests/test_package_schema.py -x -q` | ✅ (needs new tests) | ⬜ pending |
| 23-03-01 | 03 | 2 | PKG-14 | content | `python3 -m pytest tests/test_agent_skills.py -x -q` | ✅ (needs new tests) | ⬜ pending |
| 23-03-02 | 03 | 2 | PKG-18 | integration | `python3 -m pytest tests/test_package_schema.py -x -q` | ✅ (needs new tests) | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `tests/test_sizing.py` — add tests for bpatcher DB-driven sizing
- [ ] `tests/test_layout.py` — add test for adaptive spacing with tall bpatchers
- [ ] `tests/test_package_schema.py` — add tests for relationship package field, PACKAGES.md existence
- [ ] `tests/test_agent_skills.py` — add tests for package intelligence sections in SKILL.md files

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| BEAP template chains produce working patches | PKG-15 | Requires MAX runtime | Build a subtractive synth using BEAP template, verify in MAX |
| Bpatcher visual layout correctness | PKG-17 | Visual verification | Generate patch with BEAP modules, verify no overlap in MAX |

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 15s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
