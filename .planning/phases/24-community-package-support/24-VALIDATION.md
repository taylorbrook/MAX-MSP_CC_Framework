---
phase: 24
slug: community-package-support
status: draft
nyquist_compliant: false
wave_0_complete: false
created: 2026-04-15
---

# Phase 24 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest (existing project standard) |
| **Config file** | pytest.ini or per-test discovery |
| **Quick run command** | `python -m pytest tests/ -x -q` |
| **Full suite command** | `python -m pytest tests/ -v` |
| **Estimated runtime** | ~10 seconds |

---

## Sampling Rate

- **After every task commit:** Run `python -m pytest tests/ -x -q`
- **After every plan wave:** Run `python -m pytest tests/ -v`
- **Before `/gsd-verify-work`:** Full suite must be green
- **Max feedback latency:** 10 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Threat Ref | Secure Behavior | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|------------|-----------------|-----------|-------------------|-------------|--------|
| 24-01-01 | 01 | 1 | PKG-19 | — | N/A | unit | `pytest tests/test_package_schema.py::test_all_community_packages_present -x` | ❌ W0 | ⬜ pending |
| 24-01-02 | 01 | 1 | PKG-22 | — | N/A | unit | `pytest tests/test_package_schema.py::test_stub_entry_schema -x` | ❌ W0 | ⬜ pending |
| 24-02-01 | 02 | 2 | PKG-20 | — | N/A | unit | `pytest tests/test_extraction.py::test_community_package_path -x` | ❌ W0 | ⬜ pending |
| 24-02-02 | 02 | 2 | PKG-20 | — | N/A | unit | `pytest tests/test_extraction.py::test_pipeline_auto_detect -x` | ❌ W0 | ⬜ pending |
| 24-03-01 | 03 | 2 | PKG-21 | — | N/A | unit | `pytest tests/test_patcher.py::test_community_block -x` | ❌ W0 | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `tests/test_package_schema.py` — tests for stub entry schema, all 10 packages present, correct fields
- [ ] `tests/test_extraction.py` — tests for `--package` path resolution (mock filesystem), pipeline auto-detection
- [ ] `tests/test_patcher.py::test_community_block` — test for block check with `extracted: false` packages

*Existing test infrastructure covers framework and fixtures.*

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| Local extraction with installed package | PKG-20 | Requires MAX packages installed on disk | Install FluCoMa via Package Manager, run `python .claude/scripts/extract_objects.py --package FluCoMa`, verify objects.json updated |

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 10s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
