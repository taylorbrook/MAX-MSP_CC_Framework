---
phase: 24
slug: layout
status: draft
nyquist_compliant: true
wave_0_complete: true
created: 2026-04-07
---

# Phase 24 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest 9.0.2 |
| **Config file** | pyproject.toml |
| **Quick run command** | `python3 -m pytest tests/test_m4l_layout.py -x -q` |
| **Full suite command** | `python3 -m pytest tests/ -x -q` |
| **Estimated runtime** | ~5 seconds |

---

## Sampling Rate

- **After every task commit:** Run `python3 -m pytest tests/test_m4l_layout.py -x -q`
- **After every plan wave:** Run `python3 -m pytest tests/ -x -q`
- **Before `/gsd-verify-work`:** Full suite must be green
- **Max feedback latency:** 5 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Threat Ref | Secure Behavior | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|------------|-----------------|-----------|-------------------|-------------|--------|
| 24-01-01 | 01 | 1 | LAYOUT-01 | — | N/A | unit | `python3 -m pytest tests/test_m4l_layout.py::TestGroupLayout -x` | Plan 01 RED | ⬜ pending |
| 24-01-02 | 01 | 1 | LAYOUT-01 | — | N/A | unit | `python3 -m pytest tests/test_m4l_layout.py::TestColumnPacking -x` | Plan 01 RED | ⬜ pending |
| 24-01-03 | 01 | 1 | LAYOUT-01 | — | N/A | unit | `python3 -m pytest tests/test_m4l_layout.py::TestDeviceWidth -x` | Plan 01 RED | ⬜ pending |
| 24-01-04 | 01 | 1 | LAYOUT-03 | — | N/A | unit | `python3 -m pytest tests/test_m4l_layout.py::TestWholePixels -x` | Plan 01 RED | ⬜ pending |
| 24-01-05 | 01 | 1 | LAYOUT-03 | — | N/A | unit | `python3 -m pytest tests/test_m4l_layout.py::TestPreserveExisting -x` | Plan 01 RED | ⬜ pending |
| 24-02-01 | 02 | 2 | LAYOUT-02 | — | N/A | unit | `python3 -m pytest tests/test_m4l_layout.py::TestSinglePage -x` | Plan 01 RED | ⬜ pending |
| 24-02-02 | 02 | 2 | LAYOUT-02 | — | N/A | unit | `python3 -m pytest tests/test_m4l_layout.py::TestTabbedLayout -x` | Plan 02 RED | ⬜ pending |
| 24-02-03 | 02 | 2 | LAYOUT-02 | — | N/A | unit | `python3 -m pytest tests/test_m4l_layout.py::TestOverlay -x` | Plan 03 RED | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

Wave 0 satisfied by TDD RED phases: Plan 01 RED creates `tests/test_m4l_layout.py` with test classes and `_make_m4l_patch()` fixture before any implementation code. Plans 02/03 RED add test classes to the same file. TDD cycle guarantees tests exist before GREEN implementation.

*Existing infrastructure (pytest, conftest) covers framework requirements.*

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| Controls render correctly in Ableton Live at 169px height | LAYOUT-01 | Requires Ableton Live running | Open generated .maxpat in Live, verify controls visible and non-overlapping |
| Tab switching works in presentation mode | LAYOUT-02 | Requires Live UI interaction | Click live.tab, verify page controls show/hide correctly |

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 5s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
