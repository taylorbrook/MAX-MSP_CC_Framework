---
phase: 5
slug: rnbo-and-external-development
status: draft
nyquist_compliant: false
wave_0_complete: false
created: 2026-03-10
---

# Phase 5 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest 9.0.2 |
| **Config file** | none — pytest discovers tests/ automatically |
| **Quick run command** | `python3 -m pytest tests/ -x -q` |
| **Full suite command** | `python3 -m pytest tests/ -v` |
| **Estimated runtime** | ~30 seconds |

---

## Sampling Rate

- **After every task commit:** Run `python3 -m pytest tests/ -x -q`
- **After every plan wave:** Run `python3 -m pytest tests/ -v`
- **Before `/gsd:verify-work`:** Full suite must be green
- **Max feedback latency:** 30 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|-----------|-------------------|-------------|--------|
| 05-01-xx | 01 | 1 | CODE-06 | unit | `python3 -m pytest tests/test_rnbo.py::test_rnbo_object_validation -x` | ❌ W0 | ⬜ pending |
| 05-01-xx | 01 | 1 | CODE-06 | unit | `python3 -m pytest tests/test_rnbo.py::test_rnbo_generation -x` | ❌ W0 | ⬜ pending |
| 05-01-xx | 01 | 1 | CODE-07 | unit | `python3 -m pytest tests/test_rnbo.py::test_target_constraints -x` | ❌ W0 | ⬜ pending |
| 05-01-xx | 01 | 1 | CODE-07 | unit | `python3 -m pytest tests/test_rnbo.py::test_self_contained -x` | ❌ W0 | ⬜ pending |
| 05-01-xx | 01 | 1 | CODE-07 | unit | `python3 -m pytest tests/test_rnbo.py::test_param_extraction -x` | ❌ W0 | ⬜ pending |
| 05-02-xx | 02 | 2 | EXT-01 | unit | `python3 -m pytest tests/test_externals.py::test_scaffold_structure -x` | ❌ W0 | ⬜ pending |
| 05-02-xx | 02 | 2 | EXT-01 | unit | `python3 -m pytest tests/test_externals.py::test_cmake_generation -x` | ❌ W0 | ⬜ pending |
| 05-02-xx | 02 | 2 | EXT-02 | integration | `python3 -m pytest tests/test_externals.py::test_mindevkit_setup -x` | ❌ W0 | ⬜ pending |
| 05-02-xx | 02 | 2 | EXT-03 | unit | `python3 -m pytest tests/test_externals.py::test_message_archetype -x` | ❌ W0 | ⬜ pending |
| 05-02-xx | 02 | 2 | EXT-03 | unit | `python3 -m pytest tests/test_externals.py::test_scheduler_archetype -x` | ❌ W0 | ⬜ pending |
| 05-02-xx | 02 | 2 | EXT-04 | unit | `python3 -m pytest tests/test_externals.py::test_dsp_archetype -x` | ❌ W0 | ⬜ pending |
| 05-02-xx | 02 | 2 | EXT-04 | unit | `python3 -m pytest tests/test_externals.py::test_help_patch -x` | ❌ W0 | ⬜ pending |
| 05-02-xx | 02 | 2 | EXT-05 | integration | `python3 -m pytest tests/test_externals.py::test_build_invocation -x` | ❌ W0 | ⬜ pending |
| 05-02-xx | 02 | 2 | EXT-05 | unit | `python3 -m pytest tests/test_externals.py::test_mxo_validation -x` | ❌ W0 | ⬜ pending |
| 05-xx-xx | -- | -- | -- | unit | `python3 -m pytest tests/test_critics.py::test_rnbo_critic -x` | ❌ W0 | ⬜ pending |
| 05-xx-xx | -- | -- | -- | unit | `python3 -m pytest tests/test_critics.py::test_ext_critic -x` | ❌ W0 | ⬜ pending |
| 05-xx-xx | -- | -- | -- | unit | `python3 -m pytest tests/test_agent_skills.py -x -k rnbo` | ❌ W0 | ⬜ pending |
| 05-xx-xx | -- | -- | -- | unit | `python3 -m pytest tests/test_agent_skills.py -x -k ext` | ❌ W0 | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `tests/test_rnbo.py` — stubs for CODE-06, CODE-07 (RNBO generation, validation, target constraints, self-containedness, param extraction)
- [ ] `tests/test_externals.py` — stubs for EXT-01 through EXT-05 (scaffolding, code gen, build, mxo validation)
- [ ] Extended `tests/test_critics.py` — RNBO critic and external critic test cases
- [ ] Extended `tests/test_agent_skills.py` — RNBO and external agent skill validation

*Existing test infrastructure (conftest.py fixtures, pytest config) covers shared needs.*

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| RNBO patch opens in MAX | CODE-06 | Requires MAX application | Open generated .maxpat in MAX 9, verify rnbo~ object loads |
| RNBO patch exports via RNBO panel | CODE-07 | Requires RNBO license | Open export panel, select target, verify export succeeds |
| Compiled .mxo loads in MAX | EXT-05 | Requires MAX application | Copy .mxo to MAX search path, create object in patcher |

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 30s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
