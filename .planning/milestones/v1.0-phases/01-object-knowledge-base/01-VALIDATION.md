---
phase: 1
slug: object-knowledge-base
status: draft
nyquist_compliant: false
wave_0_complete: false
created: 2026-03-09
---

# Phase 1 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest 7.x + custom validation scripts |
| **Config file** | None — Wave 0 creates test infrastructure |
| **Quick run command** | `python3 .claude/scripts/validate_db.py --quick` |
| **Full suite command** | `python3 .claude/scripts/validate_db.py --full` |
| **Estimated runtime** | ~15 seconds |

---

## Sampling Rate

- **After every task commit:** Run `python3 .claude/scripts/validate_db.py --quick`
- **After every plan wave:** Run `python3 .claude/scripts/validate_db.py --full`
- **Before `/gsd:verify-work`:** Full suite must be green
- **Max feedback latency:** 15 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|-----------|-------------------|-------------|--------|
| 01-01-01 | 01 | 1 | ODB-01 | unit | `python3 -m pytest tests/test_object_schema.py -x` | ❌ W0 | ⬜ pending |
| 01-01-02 | 01 | 1 | ODB-02 | integration | `python3 -m pytest tests/test_source_coverage.py -x` | ❌ W0 | ⬜ pending |
| 01-01-03 | 01 | 1 | ODB-03 | unit | `python3 -m pytest tests/test_version_tags.py -x` | ❌ W0 | ⬜ pending |
| 01-01-04 | 01 | 1 | ODB-04 | smoke | `python3 -m pytest tests/test_max9_objects.py -x` | ❌ W0 | ⬜ pending |
| 01-01-05 | 01 | 1 | ODB-05 | unit | `python3 -m pytest tests/test_domain_classification.py -x` | ❌ W0 | ⬜ pending |
| 01-01-06 | 01 | 1 | ODB-06 | unit | `python3 -m pytest tests/test_inlet_types.py -x` | ❌ W0 | ⬜ pending |
| 01-01-07 | 01 | 1 | ODB-07 | integration | `python3 -m pytest tests/test_rnbo_flag.py -x` | ❌ W0 | ⬜ pending |
| 01-01-08 | 01 | 1 | FRM-04 | smoke | `python3 -m pytest tests/test_claude_md.py -x` | ❌ W0 | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `tests/test_object_schema.py` — stubs for ODB-01, validates JSON schema per object
- [ ] `tests/test_source_coverage.py` — stubs for ODB-02, verifies multi-source extraction
- [ ] `tests/test_version_tags.py` — stubs for ODB-03, checks min_version field exists
- [ ] `tests/test_max9_objects.py` — stubs for ODB-04, spot-checks array.*, string.*, abl.*
- [ ] `tests/test_domain_classification.py` — stubs for ODB-05, checks domain field
- [ ] `tests/test_inlet_types.py` — stubs for ODB-06, validates signal/control classification
- [ ] `tests/test_rnbo_flag.py` — stubs for ODB-07, validates rnbo_compatible flag
- [ ] `tests/test_claude_md.py` — stubs for FRM-04, checks CLAUDE.md structure
- [ ] `tests/conftest.py` — shared fixtures (load object database, paths)
- [ ] Framework install: `pip install pytest` (if not available)

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| Claude uses DB during generation without hallucination | ODB-01 | Requires LLM interaction | Generate a test patch and verify all objects exist in DB |
| CLAUDE.md conventions followed | FRM-04 | Requires code review | Review generated code against CLAUDE.md rules |

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 15s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
