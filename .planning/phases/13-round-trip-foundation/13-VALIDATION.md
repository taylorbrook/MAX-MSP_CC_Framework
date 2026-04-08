---
phase: 13
slug: round-trip-foundation
status: audited
nyquist_compliant: partial
wave_0_complete: true
created: 2026-03-15
audited: 2026-04-08
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
| 13-01-01 | 01 | 0 | RW-01 | unit | `python3 -m pytest tests/test_round_trip.py::TestFromDict -x` | YES | green |
| 13-01-02 | 01 | 0 | RW-01 | unit | `python3 -m pytest tests/test_round_trip.py::TestSubpatcherLoading -x` | YES | green |
| 13-01-03 | 01 | 0 | RW-01 | unit | `python3 -m pytest tests/test_round_trip.py::TestBpatcherLoading -x` | YES | green |
| 13-01-04 | 01 | 0 | RW-01 | unit | `python3 -m pytest tests/test_round_trip.py::TestUnknownObjects -x` | YES | green |
| 13-01-05 | 01 | 0 | RW-01 | unit | `python3 -m pytest tests/test_round_trip.py::TestStructuralErrors -x` | YES | green |
| 13-02-01 | 02 | 0 | RW-02 | unit | `python3 -m pytest tests/test_round_trip.py::TestRoundTripIdentity -x` | YES | green |
| 13-02-02 | 02 | 0 | RW-02 | unit | `python3 -m pytest tests/test_round_trip.py::TestKeyOrdering -x` | YES | green |
| 13-02-03 | 02 | 0 | RW-02 | unit | `python3 -m pytest tests/test_round_trip.py::TestNumericPrecision -x` | YES | green |
| 13-03-01 | 03 | 0 | RW-06 | unit | `python3 -m pytest tests/test_round_trip.py::TestPatchlineAttrs -x` | YES | green |
| 13-03-02 | 03 | 0 | RW-06 | unit | `python3 -m pytest tests/test_round_trip.py::TestUserState -x` | YES | green |
| 13-03-03 | 03 | 0 | RW-06 | unit | `python3 -m pytest tests/test_round_trip.py::TestExtraAttrs -x` | YES | green |
| 13-03-04 | 03 | 0 | RW-02 | unit | `python3 -m pytest tests/test_round_trip.py::TestFileLevelRoundTrip -x` | YES | green |

*Status: pending / green / red / flaky*

---

## Wave 0 Requirements

- [x] `tests/test_round_trip.py` -- stubs for RW-01, RW-02, RW-06 (including TestStructuralErrors and TestFileLevelRoundTrip)
- [x] `tests/fixtures/colored_patchlines.maxpat` -- synthetic .maxpat with colored patchlines for RW-06 color test
- [x] Project .maxpat files read directly from `patches/` directory via `_load_project_patch()` helper -- no fixture copy needed (MAX-saved files like comp-band.maxpat, FDNVerb.maxpat, granularsynthtest.maxpat are tested in-place)

*Existing pytest infrastructure covers framework needs.*

---

## Manual-Only Verifications

| Test | Reason |
|------|--------|
| `TestFileLevelRoundTrip::test_max_saved_file_byte_identical` | xfail: MAX uses compact single-line array formatting that `json.dumps` cannot reproduce |
| `TestFileLevelRoundTrip::test_framework_file_byte_identical` | xfail: same JSON array formatting limitation |
| `TestSubpatcherByteIdentity::test_byte_identical_round_trip[minitaur]` | xfail: same JSON array formatting limitation |

---

## Validation Sign-Off

- [x] All tasks have `<automated>` verify or Wave 0 dependencies
- [x] Sampling continuity: no 3 consecutive tasks without automated verify
- [x] Wave 0 covers all MISSING references
- [x] No watch-mode flags
- [x] Feedback latency < 5s
- [ ] `nyquist_compliant: true` set in frontmatter (partial — 3 xfail tests for JSON formatting)

**Approval:** partial (53 green, 3 xfail)

---

## Validation Audit 2026-04-08

| Metric | Count |
|--------|-------|
| Gaps found | 3 |
| Resolved | 3 |
| Escalated | 0 |

**Details:**
- Gap 1 (RED): Fixed renamed file path `performancepatchtest.maxpat` → `performance-patch-template.maxpat` (2 tests)
- Gap 2 (MISSING): Added `TestFromDict` class with 3 tests for basic from_dict contract (RW-01)
- Gap 3 (xfail): Confirmed 3 xfails valid — MAX compact JSON array formatting unrepresentable by `json.dumps`
