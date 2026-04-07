---
phase: 23
slug: polish
status: draft
nyquist_compliant: false
wave_0_complete: false
created: 2026-04-06
---

# Phase 23 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest 9.x |
| **Config file** | pyproject.toml |
| **Quick run command** | `python -m pytest tests/ -x -q --tb=short` |
| **Full suite command** | `python -m pytest tests/ -v` |
| **Estimated runtime** | ~15 seconds |

---

## Sampling Rate

- **After every task commit:** Run `python -m pytest tests/ -x -q --tb=short`
- **After every plan wave:** Run `python -m pytest tests/ -v`
- **Before `/gsd-verify-work`:** Full suite must be green
- **Max feedback latency:** 15 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Threat Ref | Secure Behavior | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|------------|-----------------|-----------|-------------------|-------------|--------|
| 23-01-01 | 01 | 1 | POLISH-01 | — | N/A | unit | `python -m pytest tests/test_m4l_polish.py -k "test_longname_derivation" -v` | ❌ W0 | ⬜ pending |
| 23-01-02 | 01 | 1 | POLISH-01 | — | N/A | unit | `python -m pytest tests/test_m4l_polish.py -k "test_shortname_abbreviation" -v` | ❌ W0 | ⬜ pending |
| 23-01-03 | 01 | 1 | POLISH-01 | — | N/A | unit | `python -m pytest tests/test_m4l_polish.py -k "test_varname_derivation" -v` | ❌ W0 | ⬜ pending |
| 23-02-01 | 02 | 1 | POLISH-02 | — | N/A | unit | `python -m pytest tests/test_m4l_polish.py -k "test_push_bank" -v` | ❌ W0 | ⬜ pending |
| 23-03-01 | 03 | 1 | POLISH-03 | — | N/A | unit | `python -m pytest tests/test_m4l_polish.py -k "test_info_text" -v` | ❌ W0 | ⬜ pending |
| 23-04-01 | 04 | 1 | POLISH-01 | — | N/A | integration | `python -m pytest tests/test_m4l_polish.py -k "test_polish_full_device" -v` | ❌ W0 | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `tests/test_m4l_polish.py` — stubs for POLISH-01, POLISH-02, POLISH-03
- [ ] Test fixtures using kicksynth-m4l.maxpat as real device reference

*Existing pytest infrastructure covers framework needs.*

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| Push bank display in Ableton | POLISH-02 | Requires Ableton Live runtime | Load .amxd, open Push display, verify 8 params per bank |
| Info text display in Info View | POLISH-03 | Requires Ableton Live runtime | Hover parameter, check Info View shows annotation |

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 15s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
