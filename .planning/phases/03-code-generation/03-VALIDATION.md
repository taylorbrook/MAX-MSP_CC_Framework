---
phase: 3
slug: code-generation
status: draft
nyquist_compliant: false
wave_0_complete: false
created: 2026-03-09
---

# Phase 3 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest 9.0.2 |
| **Config file** | None (default pytest discovery) |
| **Quick run command** | `python3 -m pytest tests/ -x -q` |
| **Full suite command** | `python3 -m pytest tests/ -q` |
| **Estimated runtime** | ~5 seconds |

---

## Sampling Rate

- **After every task commit:** Run `python3 -m pytest tests/ -x -q`
- **After every plan wave:** Run `python3 -m pytest tests/ -q`
- **Before `/gsd:verify-work`:** Full suite must be green
- **Max feedback latency:** 5 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|-----------|-------------------|-------------|--------|
| 03-01-01 | 01 | 1 | CODE-01 | unit | `python3 -m pytest tests/test_codegen.py::TestGenExpr -x` | ❌ W0 | ⬜ pending |
| 03-01-02 | 01 | 1 | CODE-01 | unit | `python3 -m pytest tests/test_code_validation.py::TestGenExprValidator -x` | ❌ W0 | ⬜ pending |
| 03-01-03 | 01 | 1 | CODE-02 | unit | `python3 -m pytest tests/test_codegen.py::TestGenBox -x` | ❌ W0 | ⬜ pending |
| 03-01-04 | 01 | 1 | CODE-02 | unit | `python3 -m pytest tests/test_codegen.py::TestGenBox::test_codebox_structure -x` | ❌ W0 | ⬜ pending |
| 03-01-05 | 01 | 1 | CODE-03 | unit | `python3 -m pytest tests/test_codegen.py::TestGendsp -x` | ❌ W0 | ⬜ pending |
| 03-01-06 | 01 | 1 | CODE-03 | integration | `python3 -m pytest tests/test_codegen.py::TestGendsp::test_write_gendsp -x` | ❌ W0 | ⬜ pending |
| 03-02-01 | 02 | 1 | CODE-04 | unit | `python3 -m pytest tests/test_codegen.py::TestN4M -x` | ❌ W0 | ⬜ pending |
| 03-02-02 | 02 | 1 | CODE-04 | unit | `python3 -m pytest tests/test_code_validation.py::TestN4MValidator -x` | ❌ W0 | ⬜ pending |
| 03-02-03 | 02 | 1 | CODE-05 | unit | `python3 -m pytest tests/test_codegen.py::TestJsObject -x` | ❌ W0 | ⬜ pending |
| 03-02-04 | 02 | 1 | CODE-05 | unit | `python3 -m pytest tests/test_code_validation.py::TestJsValidator -x` | ❌ W0 | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `tests/test_codegen.py` — stubs for CODE-01, CODE-02, CODE-03, CODE-04, CODE-05 (generation)
- [ ] `tests/test_code_validation.py` — stubs for CODE-01, CODE-04, CODE-05 (validation)
- [ ] `tests/fixtures/expected/gen_codebox.maxpat` — fixture for gen~ codebox patch comparison
- [ ] `tests/fixtures/expected/simple.gendsp` — fixture for .gendsp file comparison

*Existing infrastructure covers all phase requirements.*

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
