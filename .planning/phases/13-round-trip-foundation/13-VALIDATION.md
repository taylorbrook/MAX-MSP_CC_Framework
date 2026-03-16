---
phase: 13
slug: round-trip-foundation
status: draft
nyquist_compliant: false
wave_0_complete: false
created: 2026-03-15
---

# Phase 13 -- Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest 9.0.2 |
| **Config file** | none -- pytest auto-discovers tests/ |
| **Quick run command** | `python3 -m pytest tests/test_round_trip.py -x -q` |
| **Full suite command** | `python3 -m pytest tests/ -x -q` |
| **Estimated runtime** | ~5 seconds |

---

## Sampling Rate

- **After every task commit:** Run `python3 -m pytest tests/test_round_trip.py -x -q`
- **After every plan wave:** Run `python3 -m pytest tests/ -x -q`
- **Before `/gsd:verify-work`:** Full suite must be green
- **Max feedback latency:** 5 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|-----------|-------------------|-------------|--------|
| 13-01-01 | 01 | 0 | RW-01 | unit | `python3 -m pytest tests/test_round_trip.py::TestFromDict -x` | W0 | pending |
| 13-01-02 | 01 | 0 | RW-01 | unit | `python3 -m pytest tests/test_round_trip.py::TestSubpatcherLoading -x` | W0 | pending |
| 13-01-03 | 01 | 0 | RW-01 | unit | `python3 -m pytest tests/test_round_trip.py::TestBpatcherLoading -x` | W0 | pending |
| 13-01-04 | 01 | 0 | RW-01 | unit | `python3 -m pytest tests/test_round_trip.py::TestUnknownObjects -x` | W0 | pending |
| 13-01-05 | 01 | 0 | RW-01 | unit | `python3 -m pytest tests/test_round_trip.py::TestStructuralErrors -x` | W0 | pending |
| 13-02-01 | 02 | 0 | RW-02 | unit | `python3 -m pytest tests/test_round_trip.py::TestRoundTripIdentity -x` | W0 | pending |
| 13-02-02 | 02 | 0 | RW-02 | unit | `python3 -m pytest tests/test_round_trip.py::TestKeyOrdering -x` | W0 | pending |
| 13-02-03 | 02 | 0 | RW-02 | unit | `python3 -m pytest tests/test_round_trip.py::TestNumericPrecision -x` | W0 | pending |
| 13-03-01 | 03 | 0 | RW-06 | unit | `python3 -m pytest tests/test_round_trip.py::TestPatchlineAttrs -x` | W0 | pending |
| 13-03-02 | 03 | 0 | RW-06 | unit | `python3 -m pytest tests/test_round_trip.py::TestUserState -x` | W0 | pending |
| 13-03-03 | 03 | 0 | RW-06 | unit | `python3 -m pytest tests/test_round_trip.py::TestExtraAttrs -x` | W0 | pending |
| 13-03-04 | 03 | 0 | RW-02 | unit | `python3 -m pytest tests/test_round_trip.py::TestFileLevelRoundTrip -x` | W0 | pending |

*Status: pending / green / red / flaky*

---

## Wave 0 Requirements

- [ ] `tests/test_round_trip.py` -- stubs for RW-01, RW-02, RW-06 (including TestStructuralErrors and TestFileLevelRoundTrip)
- [ ] `tests/fixtures/colored_patchlines.maxpat` -- synthetic .maxpat with colored patchlines for RW-06 color test
- [ ] Project .maxpat files read directly from `patches/` directory via `_load_project_patch()` helper -- no fixture copy needed (MAX-saved files like comp-band.maxpat, FDNVerb.maxpat, granularsynthtest.maxpat are tested in-place)

*Existing pytest infrastructure covers framework needs.*

---

## Manual-Only Verifications

*All phase behaviors have automated verification.*

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 5s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
