---
phase: 2
slug: patch-generation-and-validation
status: draft
nyquist_compliant: false
wave_0_complete: false
created: 2026-03-09
---

# Phase 2 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest 7.x+ |
| **Config file** | none — uses default discovery (tests/ directory) |
| **Quick run command** | `python3 -m pytest tests/ -x --tb=short -q` |
| **Full suite command** | `python3 -m pytest tests/ -v --tb=long` |
| **Estimated runtime** | ~5 seconds |

---

## Sampling Rate

- **After every task commit:** Run `python3 -m pytest tests/ -x --tb=short -q`
- **After every plan wave:** Run `python3 -m pytest tests/ -v --tb=long`
- **Before `/gsd:verify-work`:** Full suite must be green
- **Max feedback latency:** 10 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|-----------|-------------------|-------------|--------|
| 02-01-01 | 01 | 1 | PAT-01 | unit | `python3 -m pytest tests/test_patcher.py -x` | ❌ W0 | ⬜ pending |
| 02-01-02 | 01 | 1 | PAT-02 | unit | `python3 -m pytest tests/test_patcher.py::test_patcher_structure -x` | ❌ W0 | ⬜ pending |
| 02-01-03 | 01 | 1 | PAT-03 | unit | `python3 -m pytest tests/test_patcher.py::test_subpatcher -x` | ❌ W0 | ⬜ pending |
| 02-02-01 | 02 | 1 | PAT-04 | unit | `python3 -m pytest tests/test_validation.py::test_connection_bounds -x` | ❌ W0 | ⬜ pending |
| 02-02-02 | 02 | 1 | PAT-05 | unit | `python3 -m pytest tests/test_validation.py::test_signal_type -x` | ❌ W0 | ⬜ pending |
| 02-02-03 | 02 | 1 | PAT-06 | unit | `python3 -m pytest tests/test_layout.py::test_top_to_bottom -x` | ❌ W0 | ⬜ pending |
| 02-02-04 | 02 | 1 | PAT-07 | unit | `python3 -m pytest tests/test_layout.py::test_spacing -x` | ❌ W0 | ⬜ pending |
| 02-02-05 | 02 | 2 | PAT-08 | integration | `python3 -m pytest tests/test_validation.py -x` | ❌ W0 | ⬜ pending |
| 02-02-06 | 02 | 2 | FRM-05 | unit | `python3 -m pytest tests/test_hooks.py -x` | ❌ W0 | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `tests/test_patcher.py` — stubs for PAT-01, PAT-02, PAT-03 (patcher structure, boxes, lines, subpatchers, bpatchers)
- [ ] `tests/test_validation.py` — stubs for PAT-04, PAT-05, PAT-08 (connection bounds, signal types, multi-layer pipeline)
- [ ] `tests/test_layout.py` — stubs for PAT-06, PAT-07 (topological sort, column layout, spacing)
- [ ] `tests/test_hooks.py` — stubs for FRM-05 (file write hook triggers validation)
- [ ] `tests/test_sizing.py` — content-aware box sizing
- [ ] `tests/test_generation.py` — end-to-end generation of simple and complex patches
- [ ] `tests/fixtures/expected/` — known-good .maxpat files for comparison

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| Generated .maxpat opens in MAX | PAT-01 | Requires MAX application | Open generated file in MAX 9, verify no error dialogs |
| Layout is visually readable | PAT-06, PAT-07 | Visual inspection | Open in MAX, check signal flows top-to-bottom with readable spacing |

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 10s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
