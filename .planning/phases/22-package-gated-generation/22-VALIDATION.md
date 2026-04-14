---
phase: 22
slug: package-gated-generation
status: draft
nyquist_compliant: true
wave_0_complete: false
created: 2026-04-14
---

# Phase 22 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | pytest 9.x |
| **Config file** | `tests/conftest.py` |
| **Quick run command** | `python -m pytest tests/ -x -q` |
| **Full suite command** | `python -m pytest tests/ -v` |
| **Estimated runtime** | ~15 seconds |

---

## Sampling Rate

- **After every task commit:** Run `python -m pytest tests/ -x -q`
- **After every plan wave:** Run `python -m pytest tests/ -v`
- **Before `/gsd-verify-work`:** Full suite must be green
- **Max feedback latency:** 15 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Threat Ref | Secure Behavior | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|------------|-----------------|-----------|-------------------|-------------|--------|
| 22-01-01 | 01 | 1 | PKG-11 | T-22-01 | N/A | unit (TDD) | `python -m pytest tests/test_project.py::TestProjectConfig -x -q` | W0 | pending |
| 22-01-02 | 01 | 1 | PKG-11 | T-22-02 | N/A | structural | `python -c "import json; d=json.loads(open('.claude/max-objects/package_info.json').read_text()); assert 'maxforlive-elements' in d; assert 'VIDDLL' in d; print('OK')"` | exists | pending |
| 22-02-01 | 02 | 2 | PKG-12 | T-22-03 | N/A | unit (TDD) | `python -m pytest tests/test_patcher.py::TestPackageGating -x -q` | W0 | pending |
| 22-02-02 | 02 | 2 | PKG-13 | T-22-04 | N/A | unit (TDD) | `python -m pytest tests/test_validation.py::TestPackageValidation -x -q` | W0 | pending |
| 22-03-01 | 03 | 3 | PKG-09, PKG-10 | T-22-05 | N/A | structural | `python -c "import subprocess, sys; [subprocess.check_call(['grep', '-q', t, f]) for f,t in [('.claude/skills/max-lifecycle/SKILL.md','load_project_config'), ('.claude/skills/max-lifecycle/references/project-structure.md','config.json'), ('.claude/skills/max-lifecycle/SKILL.md','max-config')]]"` | exists | pending |
| 22-03-02 | 03 | 3 | PKG-09, PKG-10 | T-22-06 | N/A | structural | See verify below | exists | pending |

**Note on 22-03-02 verify:** This task modifies 5 SKILL.md files. The verify command asserts every file contains `allowed_packages` at least once:

```bash
cd /Users/taylorbrook/Dev/MAX && python3 -c "
import subprocess, sys
files = [
    '.claude/skills/max-router/SKILL.md',
    '.claude/skills/max-patch-agent/SKILL.md',
    '.claude/skills/max-dsp-agent/SKILL.md',
    '.claude/skills/max-ui-agent/SKILL.md',
    '.claude/skills/max-rnbo-agent/SKILL.md',
]
for f in files:
    count = int(subprocess.check_output(['grep', '-c', 'allowed_packages', f]).strip())
    assert count > 0, f'{f} missing allowed_packages'
print('OK: all 5 files contain allowed_packages')
"
```

*Status: pending / green / red / flaky*

---

## Wave 0 Requirements

- [ ] Test stubs for package config and gating behavior
- [ ] Shared fixtures for project config test data

*Existing infrastructure covers most phase requirements.*

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| `/max-new` presents package selection with bundled/community groups | PKG-09 | Skill invocation requires interactive session | Run `/max-new`, verify bundled/community package groups appear |
| `/max-build` blocks without config.json | PKG-10 | Skill invocation requires interactive session | Run `/max-build` without config.json, verify block message |

---

## Validation Sign-Off

- [x] All tasks have `<automated>` verify or Wave 0 dependencies
- [x] Sampling continuity: no 3 consecutive tasks without automated verify
- [x] Wave 0 covers all MISSING references
- [x] No watch-mode flags
- [x] Feedback latency < 15s
- [x] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
