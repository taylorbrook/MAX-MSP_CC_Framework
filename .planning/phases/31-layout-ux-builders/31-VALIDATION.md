---
phase: 31
slug: layout-ux-builders
status: draft
nyquist_compliant: false
wave_0_complete: false
created: 2026-04-30
---

# Phase 31 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.
> Source: 31-RESEARCH.md §"Validation Architecture" (HIGH confidence — pytest class-based, no config file).

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest (class-based, no pytest.ini/pyproject.toml — uses defaults) |
| **Config file** | none — pytest discovers `tests/test_*.py` automatically |
| **Quick run command** | `pytest tests/test_overlay_readout.py tests/test_labeled_param_bank.py tests/test_m4l_gen_synth.py tests/test_companion_role_layout.py -x` |
| **Full suite command** | `pytest tests/` |
| **Estimated runtime** | ~10 seconds (quick), ~45 seconds (full) |

---

## Sampling Rate

- **After every task commit:** Run quick command for the affected file(s)
- **After every plan wave:** Run quick run command (4 new test files)
- **Before `/gsd-verify-work`:** Full suite must be green
- **Max feedback latency:** 45 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Threat Ref | Secure Behavior | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|------------|-----------------|-----------|-------------------|-------------|--------|
| 31-01-W0 | 01 | 0 | LAYOUT-01 | — | N/A | scaffold | `test -f tests/test_overlay_readout.py` | ❌ W0 | ⬜ pending |
| 31-01-01 | 01 | 1 | LAYOUT-01 | — | flonum at z-index 0 with `ignoreclick=1` | unit | `pytest tests/test_overlay_readout.py -x` | ❌ W0 | ⬜ pending |
| 31-02-W0 | 02 | 0 | LAYOUT-02 | — | N/A | scaffold | `test -f tests/test_labeled_param_bank.py` | ❌ W0 | ⬜ pending |
| 31-02-01 | 02 | 1 | LAYOUT-02 | — | size×24, contdata=1, setstyle=1 baked | unit | `pytest tests/test_labeled_param_bank.py -x` | ❌ W0 | ⬜ pending |
| 31-03-W0 | 03 | 0 | LAYOUT-03 | — | N/A | scaffold | `test -f tests/test_companion_role_layout.py` | ❌ W0 | ⬜ pending |
| 31-03-01 | 03 | 2 | LAYOUT-03 | — | role-driven dispatch w/ None fall-through | integration | `pytest tests/test_companion_role_layout.py -x` | ❌ W0 | ⬜ pending |
| 31-04-W0 | 04 | 0 | LAYOUT-04 | T-31-04 | NO `gain~`/`live.gain~` between gen~ and plugout~ | scaffold | `test -f tests/test_m4l_gen_synth.py` | ❌ W0 | ⬜ pending |
| 31-04-01 | 04 | 1 | LAYOUT-04 | T-31-04 | varname matches param_connect; saved_attr block | unit | `pytest tests/test_m4l_gen_synth.py -x` | ❌ W0 | ⬜ pending |
| 31-05-01 | 05 | 3 | LAYOUT-05 | — | SKILL.md "Builder API" section in both agents | static | `pytest tests/test_agent_skills.py -k builder_api -x` | ⚠️ extend | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `tests/test_overlay_readout.py` — stubs for LAYOUT-01 (NEW)
- [ ] `tests/test_labeled_param_bank.py` — stubs for LAYOUT-02 (NEW)
- [ ] `tests/test_m4l_gen_synth.py` — stubs for LAYOUT-04 (NEW)
- [ ] `tests/test_companion_role_layout.py` — stubs for LAYOUT-03 (NEW)
- [ ] Extend `tests/test_agent_skills.py` (existing) for LAYOUT-05 — verify file exists before extending

No new framework/dependency installs. All fixtures available via `tests/conftest.py` (`all_objects`, `objects_by_domain`, `object_by_name`, `extraction_log`, `db_root`). Class-based pattern mirrors `tests/test_schema_extensions.py:108` and `tests/test_layout.py:25`.

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| Generated `.amxd` loads in Live without warning and dial automation works | LAYOUT-04 | Requires Ableton Live + Max for Live runtime | Build a 3-param skeleton via `add_m4l_gen_synth`, save as `.amxd`, drag into Live, verify each `live.dial` appears in device parameter list and automates the gen~ Param. |
| `max-patch-agent` and `max-ui-agent` actually invoke the new builders post-update (LAYOUT-05) | LAYOUT-05 | Tests SKILL.md content presence, not agent runtime behavior | After SKILL.md updates land, run a sample `/max-build` or `/max-iterate` task that should trigger overlay readout / param bank / companion / m4l gen synth, confirm the agent calls the builder rather than restating the prose recipe. |

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references (4 NEW + 1 EXTEND)
- [ ] No watch-mode flags
- [ ] Feedback latency < 45s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
