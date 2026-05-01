---
phase: 29
slug: validator-depth
status: draft
nyquist_compliant: false
wave_0_complete: false
created: 2026-04-28
---

# Phase 29 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest 9.0.2 (Python 3.14) |
| **Config file** | none — pytest auto-discovers from `tests/` |
| **Quick run command** | `python3 -m pytest tests/test_validation.py tests/test_code_validation.py tests/test_schema_extensions.py -x -q` |
| **Full suite command** | `python3 -m pytest -x -q` |
| **Estimated runtime** | ~10 seconds (quick); ~30 seconds (full) |

---

## Sampling Rate

- **After every task commit:** Run quick command (`pytest tests/test_validation.py tests/test_code_validation.py tests/test_schema_extensions.py -x -q`)
- **After every plan wave:** Run full suite (`pytest -x -q`)
- **Before `/gsd-verify-work`:** Full suite must be green
- **Max feedback latency:** 30 seconds

---

## Per-Task Verification Map

> Task IDs are placeholders bound to plan IDs at execute time. Each row maps a single requirement-bearing test
> to the implementation task that lands it. See RESEARCH.md §"Validation Architecture" for full per-family detail.

| Task ID | Plan | Wave | Requirement | Threat Ref | Secure Behavior | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|------------|-----------------|-----------|-------------------|-------------|--------|
| 29-01-* | 01 | 1 | VALID-03 | — | install warning emitted only on explicit `False` | unit | `pytest tests/test_schema_extensions.py::TestInstallWarning -x -q` | ❌ W0 | ⬜ pending |
| 29-02-* | 02 | 1 | VALID-04 | — | GenExpr Check 7/8/9 reject delay()/clip()/init-before-if | unit | `pytest tests/test_code_validation.py::TestGenExprChecks -x -q` | ❌ W0 | ⬜ pending |
| 29-03-* | 03 | 2 | VALID-01, VALID-05 | — | role-tier dispatch ERROR/WARNING contract | unit | `pytest tests/test_validation.py::TestRoleAwareValidation -x -q` | ❌ W0 | ⬜ pending |
| 29-04-* | 04 | 2 | VALID-02, VALID-05 | — | domain-restricted top-level guard ERROR | unit | `pytest tests/test_validation.py::TestDomainGuard -x -q` | ❌ W0 | ⬜ pending |
| 29-05-* | 05 | 3 | VALID-04 (parity) | — | embedded codebox walker fires Checks 7/8/9 from .maxpat | integration | `pytest tests/test_validation.py::TestEmbeddedGenExpr -x -q` | ❌ W0 | ⬜ pending |
| 29-06-* | * | * | VALID-01..05 (regression) | — | existing legacy signal:bool tests stay green | unit | `pytest tests/test_validation.py::TestLayer3SignalTypes -x -q` | ✅ existing | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

*Plan-to-task slicing is the planner's prerogative — wave assignments above mirror the recommended slicing in RESEARCH.md §"Recommended Task Slicing".*

---

## Wave 0 Requirements

- [ ] `tests/test_validation.py` — new test classes `TestRoleAwareValidation`, `TestDomainGuard`, `TestEmbeddedGenExpr`
- [ ] `tests/test_code_validation.py` — new test class `TestGenExprChecks` (Check 7/8/9), `TestValidateCodeFile` round-trip
- [ ] `tests/test_schema_extensions.py` — new test class `TestInstallWarning`
- [ ] No new fixtures required — `floor~`, `bach.llll2list`, `cycle~`, `snapshot~` from Phase 28 cover every check family per RESEARCH.md.

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| `delay()`/`clip()` rejection in real `.gendsp` round-trip | VALID-04 | end-to-end round-trip through `hooks.validate_code_file` is verified by the integration test row above; manual MAX-side compile is optional confidence check | Open a generated `.gendsp` containing `delay(...)` in MAX; confirm gen~ refuses to compile with the documented error |
| Install warning visibility in console | VALID-03 | `UserWarning` surfaces via `warnings.warn` — pytest captures it but a human eyeball confirms it renders to stderr in normal CLI flow | Construct a minimal patch using `bach.llll2list`; run validation; confirm warning prints once and is absent on second run |

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 30s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
