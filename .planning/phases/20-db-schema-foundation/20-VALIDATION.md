---
phase: 20
slug: db-schema-foundation
status: draft
nyquist_compliant: false
wave_0_complete: false
created: 2026-04-13
---

# Phase 20 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest 7.x |
| **Config file** | tests/conftest.py |
| **Quick run command** | `python -m pytest tests/test_db_lookup.py -x -q` |
| **Full suite command** | `python -m pytest tests/ -x -q` |
| **Estimated runtime** | ~5 seconds |

---

## Sampling Rate

- **After every task commit:** Run `python -m pytest tests/test_db_lookup.py -x -q`
- **After every plan wave:** Run `python -m pytest tests/ -x -q`
- **Before `/gsd-verify-work`:** Full suite must be green
- **Max feedback latency:** 5 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Threat Ref | Secure Behavior | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|------------|-----------------|-----------|-------------------|-------------|--------|
| 20-01-01 | 01 | 1 | DBSI-05 | — | N/A | integration | `python -m pytest tests/test_db_lookup.py -k "package_subdir" -x -q` | ❌ W0 | ⬜ pending |
| 20-01-02 | 01 | 1 | DBSI-06 | — | N/A | integration | `python -m pytest tests/test_db_lookup.py -k "migration" -x -q` | ❌ W0 | ⬜ pending |
| 20-02-01 | 02 | 1 | DBSI-02 | — | N/A | unit | `python -m pytest tests/test_db_lookup.py -k "package_info" -x -q` | ❌ W0 | ⬜ pending |
| 20-02-02 | 02 | 1 | DBSI-01 | — | N/A | unit | `python -m pytest tests/test_db_lookup.py -k "package_field" -x -q` | ❌ W0 | ⬜ pending |
| 20-02-03 | 02 | 1 | DBSI-03 | — | N/A | unit | `python -m pytest tests/test_db_lookup.py -k "allowed_packages" -x -q` | ❌ W0 | ⬜ pending |
| 20-02-04 | 02 | 1 | DBSI-04 | — | N/A | unit | `python -m pytest tests/test_db_lookup.py -k "list_packages" -x -q` | ❌ W0 | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `tests/test_db_lookup.py` — stubs for DBSI-01 through DBSI-06
- [ ] Existing `tests/conftest.py` fixtures updated for per-package subdirs

*Existing test infrastructure covers framework requirements.*

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| Empty placeholder packages load correctly | DBSI-05 | Need to verify empty JSON files parse without error | Open MAX, verify no errors on startup |

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 5s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
