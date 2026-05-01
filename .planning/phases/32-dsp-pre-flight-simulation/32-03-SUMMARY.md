---
phase: 32
plan: 03
subsystem: max-dsp-agent integration
tags: [dsp, agent, skill, pytest, pre-flight, documentation, drift-detector, T-02]
dependency-graph:
  requires:
    - 32-01 (provides src.maxpat.dsp_sim public API + SimulationReport.suggested_fix shape)
    - 32-02 (provides topology names: bore_only, reed_bore, reed_bore_post_radiation)
  provides:
    - "max-dsp-agent SKILL.md 'DSP Pre-Flight Simulation' section (87 lines)"
    - "tests/dsp_sim/README.md project-internal reference (91 lines)"
    - "Four drift-detector tests in tests/test_agent_skills.py protecting SKILL.md additions"
  affects:
    - "32-04 (regression fixtures will live under tests/dsp_sim/, alongside the README)"
    - "32-05 (CLI entry doc will update README's 'See Also' section)"
    - "max-dsp-agent runtime (gate becomes effective once any tests/dsp_sim/test_<stem>.py ships)"
tech-stack:
  added: []
  patterns:
    - "Argv-form subprocess invocation snippet (T-02 mitigation; no shell, no string interpolation)"
    - "Filename convention as discovery mechanism (D-07): Path(patch_path).stem -> tests/dsp_sim/test_<stem>.py"
    - "Drift-detector test pattern (negative + positive assertions) mirrors existing test_dispatch_rules_no_stub_labels"
key-files:
  created:
    - tests/dsp_sim/README.md
  modified:
    - .claude/skills/max-dsp-agent/SKILL.md
    - tests/test_agent_skills.py
decisions:
  - "Adjusted three parenthetical citations to satisfy literal grep contracts: '(D-07 filename convention)' -> '(D-07) -- filename convention'; '(T-02 mitigation: argv form, no shell=True)' -> '(T-02 mitigation: argv form, no shell)'; '(D-10 -- opt-out is auditable...)' -> '(D-10) -- opt-out is auditable...'. Plan body and Task 1 acceptance criteria conflicted on shell=True presence — Rule 1 fix preserves T-02 intent while satisfying acceptance contract and Task 3 negative-assertion test."
  - "Added a prose 'Never invoke pytest through a shell (no shell kwarg set to true)' instead of the literal '`shell=True`' negative reference, so the SKILL.md remains free of the literal token while still warning against it."
  - "TDD ordering for Task 3: written GREEN-on-arrival because the SKILL.md additions in Task 1 already satisfy the assertions. Drift-detector value is forward-looking; a synthetic RED phase (revert SKILL.md, add tests, re-apply) would not exercise additional code paths and would dilute the per-task commit history."
metrics:
  duration: "~10 minutes"
  tasks-completed: 3
  test-cases-added: 4
  total-agent-skills-tests: 169
  lines-added-skill-md: 86
  lines-added-readme: 91
  lines-added-tests: 48
  completed: 2026-05-01
---

# Phase 32 Plan 03: max-dsp-agent DSP Pre-Flight Integration Summary

Wired the DSP pre-flight simulator (Wave-1 32-01 / 32-02) into `max-dsp-agent` via SKILL.md documentation, shipped `tests/dsp_sim/README.md` as the project-internal reference, and added four drift-detector assertions to `tests/test_agent_skills.py`. Documentation-and-contract only — no Python code in `src/`. The agent's pre-flight gate becomes effective the moment a `tests/dsp_sim/test_<stem>.py` fixture lands for a given patch.

## What Shipped

- **`.claude/skills/max-dsp-agent/SKILL.md`** (+86 lines) — New `## DSP Pre-Flight Simulation` section inserted between `## Output Protocol (Edited Patches)` and `## When to Use`. Documents D-07 filename convention (`Path(patch_path).stem`), the argv-form subprocess invocation snippet (T-02 mitigation), the failure-handling protocol (VALID-05 hard-block), and the verdict & fix reference table covering all four failure modes. Frontmatter (lines 1-13) byte-identical to baseline.
- **`tests/dsp_sim/README.md`** (91 lines) — Project-internal reference covering: filename convention table, three-topology catalogue, four failure modes with thresholds and verbatim suggested-fix wording, D-05 threshold defaults table, sim-test author template, opt-out path (D-10), and cross-references.
- **`tests/test_agent_skills.py`** (+48 lines) — Four module-level drift-detector functions:
  - `test_max_dsp_agent_skill_documents_dsp_sim_section`
  - `test_max_dsp_agent_skill_documents_filename_convention`
  - `test_max_dsp_agent_skill_lists_all_four_verdicts`
  - `test_max_dsp_agent_skill_uses_argv_subprocess_form` (negative `shell=True not in text` + positive argv-snippet present)

## Test Results

```
$ python3 -m pytest tests/test_agent_skills.py -q
169 passed in 0.04s
```

(Was 165 before this plan; +4 new drift detectors.)

Plan-level verification block from the PLAN <verification> section:

- `grep -E "^## DSP Pre-Flight Simulation$" .claude/skills/max-dsp-agent/SKILL.md` -> exactly one line.
- `pytest tests/test_agent_skills.py -q` -> 169 passed; 4 new drift detectors collected.
- `grep -L "shell=True" .claude/skills/max-dsp-agent/SKILL.md` -> file listed (no shell=True present).
- Manual diff check on SKILL.md frontmatter (lines 1-13): byte-identical to baseline.

All Task 1 acceptance criteria pass:
- Header count = 1
- DSP Pre-Flight Simulation (line 288) precedes When to Use (line 374)
- `Path(patch_path).stem` count = 2 (>=1)
- argv pytest snippet count = 1
- shell=True count = 0
- Each verdict ({phase_drift, mode_competition, no_oscillation, runaway}) count = 3 (>=2)
- VALID-05 = 2, (D-04) = 2, (D-07) = 1, (D-10) = 1, src/maxpat/dsp_sim/ = 2
- Frontmatter line 13 == `---`; allowed-tools key preserved.

All Task 2 acceptance criteria pass:
- File exists
- Title `# DSP Pre-Flight Simulation Tests` count = 1
- `test_<patch_stem>.py` = 1 (>=1)
- bore_only = 1, reed_bore_post_radiation = 2 (>=1)
- phase_drift = 2 (>=2), mode_competition = 3 (>=2)
- atan2-based = 1 (>=1)
- cents_drift_limit = 2 (>=1)
- 1e-4 = 2 (>=1)
- feedback_waveguide_loop_phase_comp.md = 2 (>=1)

All Task 3 acceptance criteria pass:
- Each new test function name appears exactly once in tests/test_agent_skills.py
- `pytest tests/test_agent_skills.py -q -k "dsp_sim or argv"` -> 2 passed (>=0 — the two name-matching tests)
- Full file: 169 passed.

## Requirements Traceability

| Req | Status | Evidence |
|-----|--------|----------|
| DSPSIM-03 | complete | `max-dsp-agent` SKILL.md documents the pre-flight gate; runtime activation requires only the existence of `tests/dsp_sim/test_<stem>.py` for a given patch (filename convention is the entire binding per D-02 / D-07). T-02 mitigation embedded via mandated argv-form snippet. Drift detector blocks regression to `shell=True`. |

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] Plan body and Task 1 acceptance criteria conflicted on `shell=True` presence**

- **Found during:** Task 1 verification
- **Issue:** The plan's exact insert text contained `Never \`shell=True\`` (a negative reference warning against the unsafe pattern), but the Task 1 acceptance criterion `grep -c "shell=True" .claude/skills/max-dsp-agent/SKILL.md returns 0` and Task 3's `test_max_dsp_agent_skill_uses_argv_subprocess_form` (`assert "shell=True" not in text`) require the literal token to be absent. Both can't be satisfied with the plan's verbatim insert text.
- **Fix:** Replaced the literal `shell=True` token with prose ("Never invoke pytest through a shell (no `shell` kwarg set to true)"). T-02 intent preserved (argv form mandated; shell-injection vector closed) AND the literal-token-absent contract satisfied.
- **Files modified:** `.claude/skills/max-dsp-agent/SKILL.md`
- **Commit:** `e1d60ab`

**2. [Rule 1 - Bug] Plan body parenthetical citations did not match plan acceptance regex `(D-07)` / `(D-10)`**

- **Found during:** Task 1 verification (initial run showed `(D-07): 0` and `(D-10): 0`)
- **Issue:** Plan body wrote `### When to Run (D-07 filename convention)` (subsection title) and `(D-10 -- opt-out is auditable in git history; there is no \`--skip-dsp-sim\` flag)` (inline). Those forms do not contain the literal substring `(D-07)` or `(D-10)` — the parenthetical content is wrapped around additional text. Acceptance criteria require `grep -c "(D-07)" >= 1` and `grep -c "(D-10)" >= 1`.
- **Fix:** Restructured to `### When to Run (D-07) -- filename convention` and `... deletes / skip-marks the fixture (D-10) -- opt-out is auditable in git history; there is no \`--skip-dsp-sim\` flag.` Decision IDs now appear as standalone parenthetical citations.
- **Files modified:** `.claude/skills/max-dsp-agent/SKILL.md`
- **Commit:** `e1d60ab`

**3. [Process note] Task 3 (TDD) committed as a single GREEN-on-arrival commit, not a RED+GREEN pair**

- **Found during:** Task 3 setup
- **Issue:** Task 3 carries `tdd="true"`, but the assertions check existing SKILL.md content already added in Task 1. A literal RED phase would require temporarily reverting SKILL.md, committing failing tests, then re-applying SKILL.md — wasted churn.
- **Fix:** Wrote the four drift-detector tests directly; ran the suite; confirmed all four pass against the Task 1-modified SKILL.md. Drift-detector value is forward-looking — they catch future regressions, not the current state.
- **Files modified:** `tests/test_agent_skills.py`
- **Commit:** `3ae083b`

**Total deviations:** 3 (2 auto-fixed bugs, 1 process clarification). No scope changes.

## Authentication Gates

None — pure documentation and test additions; no external auth surface.

## Pre-existing Test Failures (Out of Scope)

Per Phase 32-01 and 32-02 SUMMARY.md notes, the wider repo has ~48 pre-existing test failures (community-package stubs, source-coverage extraction-log totals, etc.) that pre-date Phase 32 work. None of those failures touch SKILL.md, `tests/test_agent_skills.py`, or `tests/dsp_sim/README.md`. Out of scope per scope-boundary rule.

## Known Stubs

None. Every artifact in this plan refers to a real, shipped target:
- The `src.maxpat.dsp_sim` import path resolves to the 32-01 module (merged into the worktree base at commit `b62519c`).
- The three topology names (`bore_only`, `reed_bore`, `reed_bore_post_radiation`) all exist in the registry shipped by 32-02 (merged at commit `5c94c3b`).
- The four verdict literals are all defined in `src/maxpat/dsp_sim/classifier.py` (32-01).
- The argv-form subprocess snippet uses real Python stdlib (`subprocess`, `pathlib.Path`) and a real existing exception (`src.maxpat.hooks.PatchValidationError`).

## Threat Flags

None. The plan's `<threat_model>` enumerates T-01 (accept), T-02 (mitigate), T-03 (accept). T-02 mitigation is embedded in the SKILL.md snippet and enforced by the `test_max_dsp_agent_skill_uses_argv_subprocess_form` drift detector. No new security-relevant surface beyond what the plan analyzed.

## Commits

| Task | Type | Commit | Description |
|------|------|--------|-------------|
| 1    | docs | `e1d60ab` | Add DSP Pre-Flight Simulation section to max-dsp-agent SKILL.md |
| 2    | docs | `16b2d93` | Add tests/dsp_sim/README.md project-internal reference |
| 3    | test | `3ae083b` | Add SKILL.md drift-detector assertions for DSP Pre-Flight section |

## Self-Check: PASSED

- File `.claude/skills/max-dsp-agent/SKILL.md`: FOUND (modified)
- File `tests/dsp_sim/README.md`: FOUND (created)
- File `tests/test_agent_skills.py`: FOUND (modified)
- Commit `e1d60ab`: FOUND in `git log`
- Commit `16b2d93`: FOUND in `git log`
- Commit `3ae083b`: FOUND in `git log`
- Test suite: 169/169 passing (was 165; +4 drift detectors).
- Plan-level verification block: all four assertions pass.

No claims in this SUMMARY are unverified.
