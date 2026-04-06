---
phase: 20
slug: foundation
status: draft
nyquist_compliant: true
wave_0_complete: true
created: 2026-04-05
---

# Phase 20 -- Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest 9.0.2 |
| **Config file** | none |
| **Quick run command** | `python3 -m pytest tests/ -x -q` |
| **Full suite command** | `python3 -m pytest tests/ -v` |
| **Estimated runtime** | ~15 seconds |

---

## Sampling Rate

- **After every task commit:** Run `python3 -m pytest tests/ -x -q`
- **After every plan wave:** Run `python3 -m pytest tests/ -v`
- **Before `/gsd:verify-work`:** Full suite must be green
- **Max feedback latency:** 15 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|-----------|-------------------|-------------|--------|
| 20-01-01 | 01 | 1 | DB-01 | unit | `python3 -m pytest tests/test_object_schema.py -x -k "m4l"` | Partial | ⬜ pending |
| 20-01-02 | 01 | 1 | DB-02 | unit | `python3 -m pytest tests/test_object_schema.py -x -k "scope"` | Partial | ⬜ pending |
| 20-01-03 | 01 | 1 | DB-03 | unit | `python3 -m pytest tests/test_m4l_foundation.py -x -k "relationships"` | ❌ W0 | ⬜ pending |
| 20-01-04 | 01 | 1 | DB-04 | unit | `python3 -m pytest tests/test_m4l_foundation.py -x -k "constants"` | ❌ W0 | ⬜ pending |
| 20-01-05 | 01 | 1 | VALID-04 | unit | `python3 -m pytest tests/test_m4l_foundation.py -x -k "detect"` | ❌ W0 | ⬜ pending |
| 20-01-06 | 01 | 1 | VALID-05 | unit | `python3 -m pytest tests/test_validation.py tests/test_critics.py -x -k "terminal or plugout"` | Partial | ⬜ pending |
| 20-01-07 | 01 | 1 | ROUTING-02 | smoke | `python3 -m pytest tests/test_claude_md.py -x` | Partial | ⬜ pending |
| 20-02-01 | 02 | 1 | DB-04 | unit | `python3 -m pytest tests/test_m4l_detection.py -x -k "ParamType or UnitStyle or ModMode or ParamVisibility"` | Yes | ⬜ pending |
| 20-02-02 | 02 | 1 | VALID-04 | unit | `python3 -m pytest tests/test_m4l_detection.py -x -k "detect"` | Yes | ⬜ pending |
| 20-02-03 | 02 | 1 | ROUTING-02 | smoke | `grep "Max for Live (M4L)" CLAUDE.md` | Yes | ⬜ pending |

*Status: ⬜ pending / ✅ green / ❌ red / ⚠️ flaky*

---

## Wave 0 Requirements

- [x] `tests/test_m4l_detection.py` -- covers DB-04 constants, VALID-04 detect_device_type
- [ ] `tests/test_m4l_foundation.py` -- stubs for DB-03 (relationships), remaining DB-04, VALID-04
- [ ] Add test cases to existing `test_validation.py` for plugout~ in _TERMINAL_NAMES (VALID-05)
- [ ] Add test cases to existing `test_critics.py` for plugout~ in dsp_critic _TERMINAL_NAMES (VALID-05)
- [ ] Add test cases to existing `test_object_schema.py` for live.adsrui, live.adsr~, live.scope~ domain (DB-01, DB-02)

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| m4l_constants.py enums match Live parameter inspector values | DB-04 | Requires Ableton Live running | Open a device in Live, check parameter inspector values match enum definitions |

---

## Validation Sign-Off

- [x] All tasks have `<automated>` verify or Wave 0 dependencies
- [x] Sampling continuity: no 3 consecutive tasks without automated verify
- [x] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [x] Feedback latency < 15s
- [x] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
