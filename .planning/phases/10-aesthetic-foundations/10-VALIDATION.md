---
phase: 10
slug: aesthetic-foundations
status: draft
nyquist_compliant: false
wave_0_complete: false
created: 2026-03-13
---

# Phase 10 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest 9.0.2 |
| **Config file** | None (uses default discovery) |
| **Quick run command** | `python3 -m pytest tests/test_aesthetics.py -x` |
| **Full suite command** | `python3 -m pytest -x` |
| **Estimated runtime** | ~15 seconds |

---

## Sampling Rate

- **After every task commit:** Run `python3 -m pytest tests/test_aesthetics.py -x`
- **After every plan wave:** Run `python3 -m pytest -x`
- **Before `/gsd:verify-work`:** Full suite must be green
- **Max feedback latency:** 15 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|-----------|-------------------|-------------|--------|
| 10-01-01 | 01 | 1 | CMNT-01 | unit | `python3 -m pytest tests/test_aesthetics.py::TestCommentTiers::test_section_header -x` | Wave 0 | pending |
| 10-01-02 | 01 | 1 | CMNT-02 | unit | `python3 -m pytest tests/test_aesthetics.py::TestBubbleComments -x` | Wave 0 | pending |
| 10-01-03 | 01 | 1 | CMNT-03 | unit | `python3 -m pytest tests/test_aesthetics.py::TestCommentTiers -x` | Wave 0 | pending |
| 10-01-04 | 01 | 1 | CMNT-04 | unit | `python3 -m pytest tests/test_aesthetics.py::TestPalette -x` | Wave 0 | pending |
| 10-02-01 | 02 | 1 | PANL-01 | unit | `python3 -m pytest tests/test_aesthetics.py::TestPanels::test_panel_attributes -x` | Wave 0 | pending |
| 10-02-02 | 02 | 1 | PANL-02 | unit | `python3 -m pytest tests/test_aesthetics.py::TestPanels::test_panel_z_order -x` | Wave 0 | pending |
| 10-02-03 | 02 | 1 | PANL-03 | unit | `python3 -m pytest tests/test_aesthetics.py::TestPanels::test_auto_size -x` | Wave 0 | pending |
| 10-02-04 | 02 | 1 | PANL-04 | unit | `python3 -m pytest tests/test_aesthetics.py::TestPanels::test_gradient_fill -x` | Wave 0 | pending |
| 10-02-05 | 02 | 1 | PANL-05 | unit | `python3 -m pytest tests/test_aesthetics.py::TestStepMarkers -x` | Wave 0 | pending |
| 10-03-01 | 03 | 1 | PTCH-01 | unit | `python3 -m pytest tests/test_aesthetics.py::TestPatcherStyling::test_canvas_background -x` | Wave 0 | pending |
| 10-03-02 | 03 | 1 | PTCH-02 | unit | `python3 -m pytest tests/test_aesthetics.py::TestPatcherStyling::test_object_bgcolor -x` | Wave 0 | pending |

*Status: pending / green / red / flaky*

---

## Wave 0 Requirements

- [ ] `tests/test_aesthetics.py` -- stubs for CMNT-01..04, PANL-01..05, PTCH-01..02
- [ ] Framework install: None needed (pytest 9.0.2 already installed)

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| Gradient panel renders gradient visually in MAX | PANL-04 | Runtime rendering not testable in unit tests | Open generated patch in MAX, verify gradient panel shows smooth color transition |
| Comment bgcolor renders behind text area | CMNT-01 | Visual appearance not testable in unit tests | Open generated patch in MAX, verify section header has colored background |
| Step marker circles render as rounded amber buttons | PANL-05 | Visual appearance not testable in unit tests | Open generated patch in MAX, verify numbered circles appear amber and rounded |

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 15s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
