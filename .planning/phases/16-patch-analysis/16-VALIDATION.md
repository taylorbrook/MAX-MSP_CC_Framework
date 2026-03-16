---
phase: 16
slug: patch-analysis
status: draft
nyquist_compliant: false
wave_0_complete: false
created: 2026-03-16
---

# Phase 16 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest 9.0.2 |
| **Config file** | pyproject.toml (implicit) |
| **Quick run command** | `python3 -m pytest tests/test_analysis.py -x -q` |
| **Full suite command** | `python3 -m pytest tests/ -x -q` |
| **Estimated runtime** | ~5 seconds |

---

## Sampling Rate

- **After every task commit:** Run `python3 -m pytest tests/test_analysis.py -x -q`
- **After every plan wave:** Run `python3 -m pytest tests/ -x -q`
- **Before `/gsd:verify-work`:** Full suite must be green
- **Max feedback latency:** 5 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|-----------|-------------------|-------------|--------|
| 16-01-01 | 01 | 1 | AN-01 | unit | `python3 -m pytest tests/test_analysis.py::TestComplexity -x` | ❌ W0 | ⬜ pending |
| 16-01-02 | 01 | 1 | AN-01 | unit | `python3 -m pytest tests/test_analysis.py::TestInventory -x` | ❌ W0 | ⬜ pending |
| 16-01-03 | 01 | 1 | AN-01 | unit | `python3 -m pytest tests/test_analysis.py::TestSignalChains -x` | ❌ W0 | ⬜ pending |
| 16-01-04 | 01 | 1 | AN-01 | unit | `python3 -m pytest tests/test_analysis.py::TestParameters -x` | ❌ W0 | ⬜ pending |
| 16-01-05 | 01 | 1 | AN-01 | unit | `python3 -m pytest tests/test_analysis.py::TestHierarchy -x` | ❌ W0 | ⬜ pending |
| 16-02-01 | 02 | 1 | AN-03 | unit | `python3 -m pytest tests/test_analysis.py::TestSections -x` | ❌ W0 | ⬜ pending |
| 16-02-02 | 02 | 1 | AN-03 | unit | `python3 -m pytest tests/test_analysis.py::TestSendReceiveMerge -x` | ❌ W0 | ⬜ pending |
| 16-02-03 | 02 | 1 | AN-03 | unit | `python3 -m pytest tests/test_analysis.py::TestSectionNaming -x` | ❌ W0 | ⬜ pending |
| 16-02-04 | 02 | 1 | AN-03 | unit | `python3 -m pytest tests/test_analysis.py::TestAliasResolution -x` | ❌ W0 | ⬜ pending |
| 16-03-01 | 03 | 2 | AN-01 | unit | `python3 -m pytest tests/test_analysis.py::TestAnalyze -x` | ❌ W0 | ⬜ pending |
| 16-03-02 | 03 | 2 | AN-01 | unit | `python3 -m pytest tests/test_analysis.py::TestControlPaths -x` | ❌ W0 | ⬜ pending |
| 16-03-03 | 03 | 2 | AN-02 | integration | `python3 -m pytest tests/test_analysis.py::TestOnboard -x` | ❌ W0 | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `tests/test_analysis.py` — all analysis tests (new file, stubs for all test classes above)
- No framework install needed — pytest 9.0.2 already in use
- No shared fixtures needed beyond existing conftest.py (DB_ROOT, all_objects)

*Existing infrastructure covers framework needs.*

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| /max-onboard prints readable summary | AN-02 | Requires human judgment on readability | Load a real .maxpat via /max-onboard and review output for clarity and completeness |

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 5s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
