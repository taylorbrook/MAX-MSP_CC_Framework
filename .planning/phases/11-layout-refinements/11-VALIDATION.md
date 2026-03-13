---
phase: 11
slug: layout-refinements
status: draft
nyquist_compliant: false
wave_0_complete: false
created: 2026-03-13
---

# Phase 11 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest 9.0.2 |
| **Config file** | pyproject.toml (standard) |
| **Quick run command** | `python3 -m pytest tests/test_layout.py tests/test_sizing.py -x -q` |
| **Full suite command** | `python3 -m pytest -x -q` |
| **Estimated runtime** | ~5 seconds |

---

## Sampling Rate

- **After every task commit:** Run `python3 -m pytest tests/test_layout.py tests/test_sizing.py -x -q`
- **After every plan wave:** Run `python3 -m pytest -x -q`
- **Before `/gsd:verify-work`:** Full suite must be green
- **Max feedback latency:** 5 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|-----------|-------------------|-------------|--------|
| 11-01-01 | 01 | 1 | LYOT-06 | refactor | `python3 -m pytest tests/test_layout.py -x -q` | ✅ refactor | ⬜ pending |
| 11-01-02 | 01 | 1 | LYOT-05 | unit | `python3 -m pytest tests/test_layout.py -x -q -k "layout_options"` | ❌ W0 | ⬜ pending |
| 11-02-01 | 02 | 1 | LYOT-01 | unit | `python3 -m pytest tests/test_sizing.py -x -q -k "override"` | ❌ W0 | ⬜ pending |
| 11-02-02 | 02 | 1 | LYOT-01 | unit | `python3 -m pytest tests/test_sizing.py -x -q -k "fallback"` | ❌ W0 | ⬜ pending |
| 11-03-01 | 03 | 2 | LYOT-02 | unit | `python3 -m pytest tests/test_layout.py -x -q -k "inlet_align"` | ❌ W0 | ⬜ pending |
| 11-03-02 | 03 | 2 | LYOT-02 | unit | `python3 -m pytest tests/test_layout.py -x -q -k "multi_child"` | ❌ W0 | ⬜ pending |
| 11-03-03 | 03 | 2 | LYOT-03 | unit | `python3 -m pytest tests/test_layout.py -x -q -k "grid_snap"` | ❌ W0 | ⬜ pending |
| 11-03-04 | 03 | 2 | LYOT-04 | unit | `python3 -m pytest tests/test_layout.py -x -q -k "comment_assoc"` | ❌ W0 | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `tests/test_layout.py` — refactor 3 hardcoded assertions (lines 154, 173) to reference LayoutOptions defaults (LYOT-06)
- [ ] `tests/test_sizing.py` — add tests for width override lookup and fallback behavior (LYOT-01)
- [ ] `tests/test_layout.py` — add tests for inlet alignment, grid snap, comment association, LayoutOptions integration (LYOT-02 through LYOT-05)
- [ ] `.claude/max-objects/audit/width-overrides.json` — generate from audit-report.json (LYOT-01 prerequisite)

*Wave 0 covers all MISSING test references.*

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| Visual cable straightness | LYOT-02 | Subjective visual quality | Open generated .maxpat in MAX, verify cables are visually straighter than before |
| Grid alignment on file open | LYOT-03 | MAX may shift non-grid objects | Open generated .maxpat, toggle Edit > Snap to Grid, verify no objects shift |

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 5s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
