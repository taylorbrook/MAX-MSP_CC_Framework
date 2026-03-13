---
phase: 8
slug: help-patch-audit-pipeline
status: draft
nyquist_compliant: false
wave_0_complete: false
created: 2026-03-13
---

# Phase 8 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest 9.0.2 |
| **Config file** | none (pytest defaults) |
| **Quick run command** | `python3 -m pytest tests/test_audit.py -x -q` |
| **Full suite command** | `python3 -m pytest tests/ -x -q` |
| **Estimated runtime** | ~5 seconds |

---

## Sampling Rate

- **After every task commit:** Run `python3 -m pytest tests/test_audit.py -x -q`
- **After every plan wave:** Run `python3 -m pytest tests/ -x -q`
- **Before `/gsd:verify-work`:** Full suite must be green
- **Max feedback latency:** 5 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|-----------|-------------------|-------------|--------|
| 08-01-01 | 01 | 0 | AUDIT-01 | unit | `python3 -m pytest tests/test_audit.py::test_recursive_descent -x` | ❌ W0 | ⬜ pending |
| 08-01-02 | 01 | 0 | AUDIT-02 | unit | `python3 -m pytest tests/test_audit.py::test_degenerate_filtering -x` | ❌ W0 | ⬜ pending |
| 08-01-03 | 01 | 0 | AUDIT-03 | unit | `python3 -m pytest tests/test_audit.py::test_outlet_type_comparison -x` | ❌ W0 | ⬜ pending |
| 08-01-04 | 01 | 0 | AUDIT-04 | unit | `python3 -m pytest tests/test_audit.py::test_io_count_validation -x` | ❌ W0 | ⬜ pending |
| 08-01-05 | 01 | 0 | AUDIT-05 | unit | `python3 -m pytest tests/test_audit.py::test_box_width_extraction -x` | ❌ W0 | ⬜ pending |
| 08-01-06 | 01 | 0 | AUDIT-06 | unit | `python3 -m pytest tests/test_audit.py::test_argument_parsing -x` | ❌ W0 | ⬜ pending |
| 08-01-07 | 01 | 0 | AUDIT-07 | unit | `python3 -m pytest tests/test_audit.py::test_connection_extraction -x` | ❌ W0 | ⬜ pending |
| 08-01-08 | 01 | 0 | AUDIT-08 | integration | `python3 -m pytest tests/test_audit.py::test_report_generation -x` | ❌ W0 | ⬜ pending |
| 08-01-09 | 01 | 0 | AUDIT-09 | unit | `python3 -m pytest tests/test_audit.py::test_override_safety -x` | ❌ W0 | ⬜ pending |
| 08-01-10 | 01 | 0 | AUDIT-10 | unit | `python3 -m pytest tests/test_audit.py::test_empty_io_tracker -x` | ❌ W0 | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `tests/test_audit.py` — stubs for AUDIT-01 through AUDIT-10
- [ ] `tests/fixtures/sample_help.json` — minimal synthetic help file for unit tests (avoids dependency on MAX installation)
- [ ] `src/maxpat/audit/__init__.py` — package init (new directory)

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| Full 973-file parse on real MAX install | AUDIT-01 | Requires MAX installation on disk | Run `python3 -m src.maxpat.audit.cli` and verify parse count = 973 |

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 5s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
