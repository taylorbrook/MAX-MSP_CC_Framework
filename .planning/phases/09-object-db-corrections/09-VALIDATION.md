---
phase: 9
slug: object-db-corrections
status: draft
nyquist_compliant: false
wave_0_complete: false
created: 2026-03-13
---

# Phase 9 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest 9.0.2 |
| **Config file** | pyproject.toml (implicit) |
| **Quick run command** | `python3 -m pytest tests/test_merger.py -x` |
| **Full suite command** | `python3 -m pytest --tb=short` |
| **Estimated runtime** | ~15 seconds |

---

## Sampling Rate

- **After every task commit:** Run `python3 -m pytest tests/test_merger.py -x`
- **After every plan wave:** Run `python3 -m pytest --tb=short`
- **Before `/gsd:verify-work`:** Full suite must be green
- **Max feedback latency:** 15 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|-----------|-------------------|-------------|--------|
| 09-01-01 | 01 | 1 | DBCX-01 | unit | `python3 -m pytest tests/test_merger.py::test_outlet_corrections_merged -x` | ❌ W0 | ⬜ pending |
| 09-01-02 | 01 | 1 | DBCX-01 | integration | `python3 -m pytest tests/test_merger.py::test_db_lookup_uses_merged_overrides -x` | ❌ W0 | ⬜ pending |
| 09-01-03 | 01 | 1 | DBCX-02 | unit | `python3 -m pytest tests/test_merger.py::test_empty_io_populated -x` | ❌ W0 | ⬜ pending |
| 09-01-04 | 01 | 1 | DBCX-03 | regression | `python3 -m pytest --tb=short` | ✅ | ⬜ pending |
| 09-01-05 | 01 | 1 | DBCX-04 | unit | `python3 -m pytest tests/test_merger.py::test_domain_grouping -x` | ❌ W0 | ⬜ pending |
| 09-01-06 | 01 | 1 | -- | unit | `python3 -m pytest tests/test_merger.py::test_idempotent -x` | ❌ W0 | ⬜ pending |
| 09-01-07 | 01 | 1 | -- | unit | `python3 -m pytest tests/test_merger.py::test_conflict_preservation -x` | ❌ W0 | ⬜ pending |
| 09-01-08 | 01 | 1 | -- | unit | `python3 -m pytest tests/test_merger.py::test_non_object_sections_preserved -x` | ❌ W0 | ⬜ pending |
| 09-01-09 | 01 | 1 | -- | unit | `python3 -m pytest tests/test_merger.py::test_cli_merge_flag -x` | ❌ W0 | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `tests/test_merger.py` — stubs for DBCX-01, DBCX-02, DBCX-03, DBCX-04 plus idempotency, conflict preservation, non-object sections, CLI integration
- [ ] No framework install needed — pytest already configured

*Existing infrastructure covers framework requirements.*

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| Conflict resolution for 8 objects | DBCX-01 | Requires user judgment on field-level decisions | Present DB vs audit values inline; user approves each |
| stash~ signal vs control outlet | DBCX-01 | Genuine disagreement needing domain expertise | Show audit evidence (5 instances, 100% agreement) vs manual override |

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 15s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
